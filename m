Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C7EC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 09:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWGQ-00034w-HU; Mon, 26 Aug 2024 05:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGN-0002sK-6g
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGL-0006yp-7t
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724665426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ir0QOgKcUJWxAwfoZqvsMPWT86CVhCjJZnQAeCV5J18=;
 b=Hgsl/leKCa7Z4P1BMGe6cG86TlregWnJSAjelJOT4Vz58iIEWe05U98/5ma468aBiU3Bjh
 qzIz3OMbFjjF+Joy8+8QQPtaHxjK11fOtbNzzlItBoKDj/iQrE+hH3Su5rWjVZUb5PYvpd
 UtWAzCXnzka04c9G03rDyA92QOCEs/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-Hj8hSSv9OnCQ8hyBxLtYvA-1; Mon,
 26 Aug 2024 05:43:39 -0400
X-MC-Unique: Hj8hSSv9OnCQ8hyBxLtYvA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D734E1956095; Mon, 26 Aug 2024 09:43:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.178])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 759B41955E8C; Mon, 26 Aug 2024 09:43:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/3] .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2
 job
Date: Mon, 26 Aug 2024 11:43:29 +0200
Message-ID: <20240826094330.276592-3-thuth@redhat.com>
In-Reply-To: <20240826094330.276592-1-thuth@redhat.com>
References: <20240826094330.276592-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The qtests are broken since a while in the MSYS2 job in the gitlab-CI,
likely due to some changes in the MSYS2 environment. So far nobody has
neither a clue what's going wrong here, nor an idea how to fix this
(in fact most QEMU developers even don't have a Windows environment
available for properly analyzing this problem), so we should disable the
qtests here for the time being to get at least test coverage again
for the remaining tests that are run here.

Since we already get compile-test coverage for the system emulation
in the cross-win64-system job, and since the MSYS2 job is one of the
longest running jobs in our CI (it takes more than 1 hour to complete),
let's seize the opportunity and also cut the run time by disabling
the system emulation completely here, including the libraries that
are only useful for system emulation. In case somebody ever figures
out the failure of the qtests on MSYS2, we can revert this patch
to get everything back.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240820170142.55324-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index a83f23a786..759e9a76b5 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -17,12 +17,7 @@ msys2-64bit:
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
-    # do not remove "--without-default-devices"!
-    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
-    # changed to compile QEMU with the --without-default-devices switch
-    # for this job, because otherwise the build could not complete within
-    # the project timeout.
-    CONFIGURE_ARGS:  --target-list=sparc-softmmu --without-default-devices -Ddebug=false -Doptimization=0
+    CONFIGURE_ARGS: --disable-system --enable-tools -Ddebug=false -Doptimization=0
     # The Windows git is a bit older so override the default
     GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
   artifacts:
@@ -81,33 +76,16 @@ msys2-64bit:
       bison diffutils flex
       git grep make sed
       mingw-w64-x86_64-binutils
-      mingw-w64-x86_64-capstone
       mingw-w64-x86_64-ccache
       mingw-w64-x86_64-curl
-      mingw-w64-x86_64-cyrus-sasl
-      mingw-w64-x86_64-dtc
       mingw-w64-x86_64-gcc
       mingw-w64-x86_64-glib2
-      mingw-w64-x86_64-gnutls
-      mingw-w64-x86_64-gtk3
-      mingw-w64-x86_64-libgcrypt
-      mingw-w64-x86_64-libjpeg-turbo
       mingw-w64-x86_64-libnfs
-      mingw-w64-x86_64-libpng
       mingw-w64-x86_64-libssh
-      mingw-w64-x86_64-libtasn1
-      mingw-w64-x86_64-libusb
-      mingw-w64-x86_64-lzo2
-      mingw-w64-x86_64-nettle
       mingw-w64-x86_64-ninja
       mingw-w64-x86_64-pixman
       mingw-w64-x86_64-pkgconf
       mingw-w64-x86_64-python
-      mingw-w64-x86_64-SDL2
-      mingw-w64-x86_64-SDL2_image
-      mingw-w64-x86_64-snappy
-      mingw-w64-x86_64-spice
-      mingw-w64-x86_64-usbredir
       mingw-w64-x86_64-zstd"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
@@ -120,7 +98,7 @@ msys2-64bit:
   - mkdir build
   - cd build
   - ..\msys64\usr\bin\bash -lc "ccache --zero-stats"
-  - ..\msys64\usr\bin\bash -lc "../configure --enable-fdt=system $CONFIGURE_ARGS"
+  - ..\msys64\usr\bin\bash -lc "../configure $CONFIGURE_ARGS"
   - ..\msys64\usr\bin\bash -lc "make"
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
   - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
-- 
2.46.0


