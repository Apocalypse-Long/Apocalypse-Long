# ==============================================================================
# Apocalypse-Long Homepage & GitHub Profile Deployment Helper
# ==============================================================================

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   🤖 Apocalypse-Long 个人主页与 GitHub Profile 管理" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$options = @"
[1] 🌐 在浏览器中立即预览个人主页 (index.html)
[2] 📋 将 Profile README 推送到 Apocalypse-Long/Apocalypse-Long
[3] ❌ 退出
"@

Write-Host $options
$choice = Read-Host "请输入操作选项 (1-3)"

switch ($choice) {
    "1" {
        Write-Host "正在打开本地主页预览..." -ForegroundColor Green
        Start-Process "index.html"
    }
    "2" {
        Write-Host "正在准备推送到 Apocalypse-Long/Apocalypse-Long 仓库..." -ForegroundColor Yellow
        $tempDir = Join-Path $env:TEMP "Apocalypse-Long-Profile"
        if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
        
        git clone https://github.com/Apocalypse-Long/Apocalypse-Long.git $tempDir
        if ($LASTEXITCODE -eq 0) {
            Copy-Item -Path "README_PROFILE.md" -Destination (Join-Path $tempDir "README.md") -Force
            cd $tempDir
            git add README.md
            git commit -m "docs: update profile readme (powered by antigravity & ai)"
            git branch -M main
            git push -u origin main
            Write-Host "✓ 部署完成！请访问 https://github.com/Apocalypse-Long 查看个人主页！" -ForegroundColor Green
            cd $PSScriptRoot
        } else {
            Write-Host "克隆失败，请检查网络或认证。你也可以直接将 README_PROFILE.md 的内容手动粘贴至 GitHub 仓库的 README.md。" -ForegroundColor Red
        }
    }
    Default {
        Write-Host "已退出。"
    }
}
