Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7726DC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbGq-0007Rf-Fr; Fri, 23 Feb 2024 14:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawH-0005nR-6B
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawC-0005Fp-Of
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuBn9YK65/VJijo7z361xypecvvLSdypK1RNAkg3cAg=;
 b=g7Ytn+tjRDJ9eCnC7bjQhAB3QiBTVJVb/xgfvaXcoJlZNMhiBiKq7GczSJQW8DM/+Xsl65
 8tkgd/HRT+FMUI7hgleDKSz6Cqpy21NxAXdyoY1NU/I8UF18E88sc13i/RRCc7EAiODCD9
 db3Ru63XRsvDMlUo5HO+fR+Noo/qoUk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-HeE8df90NE-BtQ5AmfahDw-1; Fri, 23 Feb 2024 14:10:19 -0500
X-MC-Unique: HeE8df90NE-BtQ5AmfahDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 782E888CDCF;
 Fri, 23 Feb 2024 19:10:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74B1E8CED;
 Fri, 23 Feb 2024 19:10:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/11] .gitlab-ci.d/windows.yml: Remove shared-msys2 abstraction
Date: Fri, 23 Feb 2024 20:10:02 +0100
Message-ID: <20240223191003.6268-11-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Now we don't build msys2-32bit we don't need the abstraction out of the
common msys2 handling from the 32-vs-64-bit specifics. Collapse it
down into the msys2-64bit job definition.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240222130920.362517-4-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 85 +++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 8fc08218d2..f116b8012d 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -1,4 +1,4 @@
-.shared_msys2_builder:
+msys2-64bit:
   extends: .base_job_template
   tags:
   - shared-windows
@@ -14,9 +14,20 @@
   stage: build
   timeout: 100m
   variables:
+    # Select the "64 bit, gcc and MSVCRT" MSYS2 environment
+    MSYSTEM: MINGW64
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
+    # do not remove "--without-default-devices"!
+    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
+    # changed to compile QEMU with the --without-default-devices switch
+    # for this job, because otherwise the build could not complete within
+    # the project timeout.
+    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
+    # qTests don't run successfully with "--without-default-devices",
+    # so let's exclude the qtests from CI for now.
+    TEST_ARGS: --no-suite qtest
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
@@ -72,33 +83,35 @@
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
-      $MINGW_TARGET-binutils
-      $MINGW_TARGET-capstone
-      $MINGW_TARGET-ccache
-      $MINGW_TARGET-curl
-      $MINGW_TARGET-cyrus-sasl
-      $MINGW_TARGET-dtc
-      $MINGW_TARGET-gcc
-      $MINGW_TARGET-glib2
-      $MINGW_TARGET-gnutls
-      $MINGW_TARGET-gtk3
-      $MINGW_TARGET-libgcrypt
-      $MINGW_TARGET-libjpeg-turbo
-      $MINGW_TARGET-libnfs
-      $MINGW_TARGET-libpng
-      $MINGW_TARGET-libssh
-      $MINGW_TARGET-libtasn1
-      $MINGW_TARGET-lzo2
-      $MINGW_TARGET-nettle
-      $MINGW_TARGET-ninja
-      $MINGW_TARGET-pixman
-      $MINGW_TARGET-pkgconf
-      $MINGW_TARGET-python
-      $MINGW_TARGET-SDL2
-      $MINGW_TARGET-SDL2_image
-      $MINGW_TARGET-snappy
-      $MINGW_TARGET-zstd
-      $EXTRA_PACKAGES "
+      mingw-w64-x86_64-binutils
+      mingw-w64-x86_64-capstone
+      mingw-w64-x86_64-ccache
+      mingw-w64-x86_64-curl
+      mingw-w64-x86_64-cyrus-sasl
+      mingw-w64-x86_64-dtc
+      mingw-w64-x86_64-gcc
+      mingw-w64-x86_64-glib2
+      mingw-w64-x86_64-gnutls
+      mingw-w64-x86_64-gtk3
+      mingw-w64-x86_64-libgcrypt
+      mingw-w64-x86_64-libjpeg-turbo
+      mingw-w64-x86_64-libnfs
+      mingw-w64-x86_64-libpng
+      mingw-w64-x86_64-libssh
+      mingw-w64-x86_64-libtasn1
+      mingw-w64-x86_64-libusb
+      mingw-w64-x86_64-lzo2
+      mingw-w64-x86_64-nettle
+      mingw-w64-x86_64-ninja
+      mingw-w64-x86_64-pixman
+      mingw-w64-x86_64-pkgconf
+      mingw-w64-x86_64-python
+      mingw-w64-x86_64-SDL2
+      mingw-w64-x86_64-SDL2_image
+      mingw-w64-x86_64-snappy
+      mingw-w64-x86_64-spice
+      mingw-w64-x86_64-usbredir
+      mingw-w64-x86_64-zstd"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
@@ -115,19 +128,3 @@
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
   - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
   - Write-Output "Finished build at $(Get-Date -Format u)"
-
-msys2-64bit:
-  extends: .shared_msys2_builder
-  variables:
-    MINGW_TARGET: mingw-w64-x86_64
-    MSYSTEM: MINGW64
-    # msys2 only ship these packages for 64-bit, not 32-bit
-    EXTRA_PACKAGES: $MINGW_TARGET-libusb $MINGW_TARGET-usbredir $MINGW_TARGET-spice
-    # do not remove "--without-default-devices"!
-    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
-    # changed to compile QEMU with the --without-default-devices switch
-    # for the msys2 64-bit job, due to the build could not complete within
-    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
-    # qTests don't run successfully with "--without-default-devices",
-    # so let's exclude the qtests from CI for now.
-    TEST_ARGS: --no-suite qtest
-- 
2.43.2


