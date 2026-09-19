@echo off
setlocal EnableExtensions DisableDelayedExpansion
rem Resolve inputs and outputs relative to this script, not the caller.
pushd "%~dp0" || exit /b 1

if not "%*"=="" goto usage
if not exist "GMCM-main.tex" (
    echo Main file not found: GMCM-main.tex 1>&2
    set "GMCM_BUILD_EXIT=1"
    goto finish
)
where latexmk >nul 2>nul
if errorlevel 1 (
    echo latexmk is required; install it with your TeX distribution. 1>&2
    set "GMCM_BUILD_EXIT=127"
    goto finish
)

rem Keep auxiliary files outside the source directory for the entire build.
:new_build_dir
set "GMCM_BUILD_DIR=%TEMP%\gmcm-build-%RANDOM%-%RANDOM%"
if exist "%GMCM_BUILD_DIR%" goto new_build_dir
mkdir "%GMCM_BUILD_DIR%" >nul 2>nul
if errorlevel 1 (
    echo Unable to create a temporary build directory. 1>&2
    set "GMCM_BUILD_EXIT=1"
    goto finish
)

echo Building GMCM-main.tex with XeLaTeX and BibTeX...
call latexmk -norc -r .latexmkrc -outdir="%GMCM_BUILD_DIR%" GMCM-main.tex >"%GMCM_BUILD_DIR%\build.log" 2>&1
set "GMCM_BUILD_EXIT=%ERRORLEVEL%"
if not "%GMCM_BUILD_EXIT%"=="0" goto build_failed
if not exist "%GMCM_BUILD_DIR%\GMCM-main.pdf" (
    echo The build did not produce GMCM-main.pdf.>>"%GMCM_BUILD_DIR%\build.log"
    set "GMCM_BUILD_EXIT=1"
    goto build_failed
)

copy /Y "%GMCM_BUILD_DIR%\GMCM-main.pdf" "GMCM-main.pdf" >nul
if errorlevel 1 (
    echo Unable to copy the completed PDF.>>"%GMCM_BUILD_DIR%\build.log"
    set "GMCM_BUILD_EXIT=1"
    goto build_failed
)
if exist "GMCM-build-error.log" del /Q "GMCM-build-error.log"
echo Build succeeded: "%CD%\GMCM-main.pdf"
goto cleanup

:build_failed
copy /Y "%GMCM_BUILD_DIR%\build.log" "GMCM-build-error.log" >nul
if errorlevel 1 (
    echo Unable to save GMCM-build-error.log. 1>&2
) else (
    echo Build failed. See GMCM-build-error.log for details. 1>&2
)

:cleanup
rmdir /S /Q "%GMCM_BUILD_DIR%" 2>nul
if exist "%GMCM_BUILD_DIR%" (
    echo Unable to remove temporary build directory: "%GMCM_BUILD_DIR%" 1>&2
    set "GMCM_BUILD_EXIT=1"
) else (
    echo Temporary build files have been removed.
)
goto finish

:usage
echo This script only builds GMCM-main.tex and accepts no arguments. 1>&2
set "GMCM_BUILD_EXIT=2"

:finish
popd
endlocal & exit /b %GMCM_BUILD_EXIT%
