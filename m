Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=vnqPYKep
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpAP-0006CV-AL; Fri, 27 Nov 2026 01:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9e-0005YN-S3; Fri, 27 Nov 2026 01:09:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9d-0005Nh-1x; Fri, 27 Nov 2026 01:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=PecJ4mKFjbNPzs0Wy2eBwW5Xndn9QgFJqbNuGHL6vG8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vnqPYKepd++K5C3yndsKbSIE+4jO9h4GJ9I/nLhAp/VxJK0IQrdnAYGLZSjRFwjlM
 CYSeEuARAf0T4Cr/PaxSU4ondoLZpgLn9cKm2mLb/bIMEELAgbE7iqPSUkaLxZ7Cip
 eeGWVgfelNJgec1/zB7nJbjCV88kc+M0U0NVxDuXZSdUk+x3+1v+DBy6rEVVrt+OVy
 QQiemaH8vUfArlCLDwQpX44wpAa/GIdzy8guZ9tgfdOtULb7wxUyvBOrIJ7hreoXOT
 CxICi9PnYuSPTMDZi54FHwQWGJ6Bi4geOtZmH9SCo93z0d0wvscZ6+UOqT2m0tywGK
 N5f6wal0H1CAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F38E1EA37A;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CC884699A5;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6F059CF342; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 136/152] gitlab-ci: Switch the msys2 job to use ucrt
Date: Fri, 27 Nov 2026 08:54:34 +0300
Message-ID: <20261127055709.39630-73-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

The MSYS2 folks marked the MINGW64 environment as deprecated a while ago:

 https://www.msys2.org/news/#2026-03-15-deprecating-the-mingw64-environment

Now they also removed the mingw-w64-x86_64-libnfs package, so the msys2 job
is currently failing. It's expected that other MINGW64 packages will be
removed in the near future, so switch to the UCRT64 environment now instead
to fix the issue in a future-proof way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261123131427.209394-1-thuth@redhat.com>
(cherry picked from commit 2bfbe39d0fff8af881cffe2bab9b615e77807c35)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 145500ae464..ec697f407f4 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -12,8 +12,7 @@ msys2-64bit:
   stage: build
   timeout: 100m
   variables:
-    # Select the "64 bit, gcc and MSVCRT" MSYS2 environment
-    MSYSTEM: MINGW64
+    MSYSTEM: UCRT64
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
@@ -76,24 +75,24 @@ msys2-64bit:
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
-      mingw-w64-x86_64-binutils
-      mingw-w64-x86_64-ca-certificates
-      mingw-w64-x86_64-ccache
-      mingw-w64-x86_64-curl-winssl
-      mingw-w64-x86_64-gcc
-      mingw-w64-x86_64-glib2
-      mingw-w64-x86_64-libnfs
-      mingw-w64-x86_64-libssh
-      mingw-w64-x86_64-ninja
-      mingw-w64-x86_64-pixman
-      mingw-w64-x86_64-pkgconf
-      mingw-w64-x86_64-python
-      mingw-w64-x86_64-python-certifi
-      mingw-w64-x86_64-python-setuptools
-      mingw-w64-x86_64-python-wheel
-      mingw-w64-x86_64-rust
-      mingw-w64-x86_64-rust-bindgen
-      mingw-w64-x86_64-zstd"
+      mingw-w64-ucrt-x86_64-binutils
+      mingw-w64-ucrt-x86_64-ca-certificates
+      mingw-w64-ucrt-x86_64-ccache
+      mingw-w64-ucrt-x86_64-curl-winssl
+      mingw-w64-ucrt-x86_64-gcc
+      mingw-w64-ucrt-x86_64-glib2
+      mingw-w64-ucrt-x86_64-libnfs
+      mingw-w64-ucrt-x86_64-libssh
+      mingw-w64-ucrt-x86_64-ninja
+      mingw-w64-ucrt-x86_64-pixman
+      mingw-w64-ucrt-x86_64-pkgconf
+      mingw-w64-ucrt-x86_64-python
+      mingw-w64-ucrt-x86_64-python-certifi
+      mingw-w64-ucrt-x86_64-python-setuptools
+      mingw-w64-ucrt-x86_64-python-wheel
+      mingw-w64-ucrt-x86_64-rust
+      mingw-w64-ucrt-x86_64-rust-bindgen
+      mingw-w64-ucrt-x86_64-zstd"
   - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
-- 
2.47.3


