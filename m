Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138D606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=GnIkshnI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp1G-0002tF-0Y; Fri, 27 Nov 2026 01:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0s-00024g-1G; Fri, 27 Nov 2026 01:00:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0q-0001ou-6m; Fri, 27 Nov 2026 01:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=x+CpF/vzT9GMHQ7P8w3DxToM8grOnZAYPzGhZv9KTjI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GnIkshnI8gIXFId7XJUtAdKYOWr4IicfwMQBH01DzE5f73U1/sTjKCV/gLKkeqPfF
 YQ1frRSGWWckks8fTUZcycFt3vaOP68s7Vys3+lJsctYD1tLNNjd4/qVQL4biNNAaP
 S21J1v9bCwTHHElPs/659gNOoovAX8DoA93VgPvY+HlVcrnmQjuxf4vo1d4VKp42po
 OTTTHPpXTDu9Eefu2lvsW2S2A5h/xHWCR+U7G3XB3Qmov5VZYqCl3bmhIaA7B//Ivy
 fQc5zcMrjC/IgYYtF1zb4e6n5U82OoD9G/AKHOM4XRXQRyiHAJ+2YSuIqr/OHhuWeM
 mfuFzVriU+2Jg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E42F1EA307;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9A5B2469941;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8BBD3CF28E; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 124/140] gitlab-ci: Switch the msys2 job to use
 ucrt
Date: Fri, 27 Nov 2026 08:53:50 +0300
Message-ID: <20261127055421.39015-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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
(Mjt: keep the package list from 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index beac39e5bde..06cd9185216 100644
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
@@ -75,18 +74,18 @@ msys2-64bit:
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
-      mingw-w64-x86_64-binutils
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
-      mingw-w64-x86_64-zstd"
+      mingw-w64-ucrt-x86_64-binutils
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
+      mingw-w64-ucrt-x86_64-zstd"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
-- 
2.47.3


