@echo off
echo About to execute watch_tests.ps1
powershell -executionpolicy bypass -file .\watch_tests.ps1 %1
