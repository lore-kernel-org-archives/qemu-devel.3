Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB32C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgPe-0000vu-K7; Tue, 28 Jan 2025 02:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgPc-0000v9-44; Tue, 28 Jan 2025 02:53:32 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgPZ-0007ms-WE; Tue, 28 Jan 2025 02:53:31 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A712CE1ABD;
 Tue, 28 Jan 2025 10:52:59 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 21C321A62AC;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 1439E51FEF; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 04/31] cirrus-ci: Remove MSYS2 jobs duplicated with
 gitlab-ci
Date: Tue, 28 Jan 2025 00:40:56 +0300
Message-Id: <20250127214124.3730126-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Various developers are reluctant to git Cirrus-CI the permissions
  requested to access their GitHub account.

- When we use the cirrus-run script to trigger Cirrus-CI job from
  GitLab-CI, the GitLab-CI job is restricted to a 1h timeout
  (often not enough).

- Although Cirrus-CI VMs are more powerful than GitLab-CI ones,
  its free plan is limited in 2 concurrent jobs.

- The GitLab-CI MSYS2 jobs are a 1:1 mapping with the Cirrus-CI ones
  (modulo the environment caching).

Reduce the maintenance burden by removing the Cirrus-CI config file,
keeping the GitLab-CI jobs.

Update Yonggang Luo's maintenance file list to the new file, which
use the same environment shell.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230322135721.61138-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit da80f11efeea451eaa00e347f722d867ed9ac5be)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: ignore previous changes in .cirrus.yml since it is being removed anyway)

diff --git a/.cirrus.yml b/.cirrus.yml
deleted file mode 100644
index 4895987da4..0000000000
--- a/.cirrus.yml
+++ /dev/null
@@ -1,109 +0,0 @@
-env:
-  CIRRUS_CLONE_DEPTH: 1
-
-windows_msys2_task:
-  timeout_in: 90m
-  windows_container:
-    image: cirrusci/windowsservercore:2019
-    os_version: 2019
-    cpu: 8
-    memory: 8G
-  env:
-    CIRRUS_SHELL: powershell
-    MSYS: winsymlinks:native
-    MSYSTEM: MINGW64
-    MSYS2_URL: https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-base-x86_64-20220603.sfx.exe
-    MSYS2_FINGERPRINT: 0
-    MSYS2_PACKAGES: "
-      diffutils git grep make pkg-config sed
-      mingw-w64-x86_64-python
-      mingw-w64-x86_64-python-sphinx
-      mingw-w64-x86_64-toolchain
-      mingw-w64-x86_64-SDL2
-      mingw-w64-x86_64-SDL2_image
-      mingw-w64-x86_64-gtk3
-      mingw-w64-x86_64-glib2
-      mingw-w64-x86_64-ninja
-      mingw-w64-x86_64-jemalloc
-      mingw-w64-x86_64-lzo2
-      mingw-w64-x86_64-zstd
-      mingw-w64-x86_64-libjpeg-turbo
-      mingw-w64-x86_64-pixman
-      mingw-w64-x86_64-libgcrypt
-      mingw-w64-x86_64-libpng
-      mingw-w64-x86_64-libssh
-      mingw-w64-x86_64-snappy
-      mingw-w64-x86_64-libusb
-      mingw-w64-x86_64-usbredir
-      mingw-w64-x86_64-libtasn1
-      mingw-w64-x86_64-nettle
-      mingw-w64-x86_64-cyrus-sasl
-      mingw-w64-x86_64-curl
-      mingw-w64-x86_64-gnutls
-      mingw-w64-x86_64-libnfs
-    "
-    CHERE_INVOKING: 1
-  msys2_cache:
-    folder: C:\tools\archive
-    reupload_on_changes: false
-    # These env variables are used to generate fingerprint to trigger the cache procedure
-    # If wanna to force re-populate msys2, increase MSYS2_FINGERPRINT
-    fingerprint_script:
-      - |
-        echo $env:CIRRUS_TASK_NAME
-        echo $env:MSYS2_URL
-        echo $env:MSYS2_FINGERPRINT
-        echo $env:MSYS2_PACKAGES
-    populate_script:
-      - |
-        md -Force C:\tools\archive\pkg
-        $start_time = Get-Date
-        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND $env:MSYS2_URL C:\tools\archive\base.exe
-        Write-Output "Download time taken: $((Get-Date).Subtract($start_time))"
-        cd C:\tools
-        C:\tools\archive\base.exe -y
-        del -Force C:\tools\archive\base.exe
-        Write-Output "Base install time taken: $((Get-Date).Subtract($start_time))"
-        $start_time = Get-Date
-
-        ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
-        C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
-        C:\tools\msys64\usr\bin\bash.exe -lc "export"
-        C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
-        echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu --overwrite=*
-        taskkill /F /FI "MODULES eq msys-2.0.dll"
-        tasklist
-        C:\tools\msys64\usr\bin\bash.exe -lc "mv -f /etc/pacman.conf.pacnew /etc/pacman.conf || true"
-        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Syuu --overwrite=*"
-        Write-Output "Core install time taken: $((Get-Date).Subtract($start_time))"
-        $start_time = Get-Date
-
-        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed $env:MSYS2_PACKAGES"
-        Write-Output "Package install time taken: $((Get-Date).Subtract($start_time))"
-        $start_time = Get-Date
-
-        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\etc\mtab
-        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\fd
-        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\stderr
-        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\stdin
-        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\stdout
-        del -Force -Recurse -ErrorAction SilentlyContinue C:\tools\msys64\var\cache\pacman\pkg
-        tar cf C:\tools\archive\msys64.tar -C C:\tools\ msys64
-
-        Write-Output "Package archive time taken: $((Get-Date).Subtract($start_time))"
-        del -Force -Recurse -ErrorAction SilentlyContinue c:\tools\msys64 
-  install_script:
-    - |
-      $start_time = Get-Date
-      cd C:\tools
-      ls C:\tools\archive\msys64.tar
-      tar xf C:\tools\archive\msys64.tar
-      Write-Output "Extract msys2 time taken: $((Get-Date).Subtract($start_time))"
-  script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure --python=python3"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
-    - exit $LastExitCode
-  test_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-    - exit $LastExitCode
diff --git a/MAINTAINERS b/MAINTAINERS
index e688db1f55..83c4eacc66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3731,8 +3731,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
 Windows Hosted Continuous Integration
 M: Yonggang Luo <luoyonggang@gmail.com>
 S: Maintained
-F: .cirrus.yml
-W: https://cirrus-ci.com/github/qemu/qemu
+F: .gitlab-ci.d/windows.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.39.5


