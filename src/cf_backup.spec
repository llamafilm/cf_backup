# -*- mode: python ; coding: utf-8 -*-

# update the version with the latest git commit #
import sys
import subprocess
try:
    git_commit = subprocess.check_output(['git', 'rev-parse', '--short', 'HEAD'], encoding='utf-8')
except (FileNotFoundError, subprocess.CalledProcessError):
    git_commit = input('Could not get info from GitHub.  Enter commit number: ')

new_version = '1.0-' + git_commit.strip()
print(f"Building {sys.platform} version {new_version}")
with open('_version.py', 'w') as f:
    f.write('version = "' + new_version + '"')
#################################################
block_cipher = None


a = Analysis(['cf_backup.py'],
             pathex=[],
             binaries=[],
             datas=[],
             hiddenimports=[],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          [],
          name='cf_backup_' + new_version + '_' + sys.platform,
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          upx_exclude=[],
          runtime_tmpdir=None,
          console=True )

with open('_version.py', 'w') as f:
    f.write("# placeholder will be overwritten by PyInstaller\nversion = ''")