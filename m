Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC53E9B371
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2Tx-0004sB-Ck; Mon, 02 Mar 2026 07:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2Tv-0004r1-99
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2Tt-0005zn-J1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772454876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rrw4l+/J8qGKKfxV9RG7a81ApxqF/Mp2YVRyEH6o5QQ=;
 b=LXP0+y1L2lUFES6bhZLQOHTZtGDjXf+3M2MZOYUDN53KqwbCRaES/Jwt/fwVFq5GTLtZu2
 X/HjgWXJjiwzKeJ06orCj5v91hkx5xdNboLPdfifk9gsM1X7KhUru41lreT2dBZTPzS0ER
 ALBSv9lMah6AxdAW3D3LZQJYZxJoxuE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-YVgiwCHgOy6FxkCy2B7o2A-1; Mon,
 02 Mar 2026 07:34:33 -0500
X-MC-Unique: YVgiwCHgOy6FxkCy2B7o2A-1
X-Mimecast-MFC-AGG-ID: YVgiwCHgOy6FxkCy2B7o2A_1772454872
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99EEB195609F; Mon,  2 Mar 2026 12:34:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FD4A1956053; Mon,  2 Mar 2026 12:34:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/10] gitlab-ci: Remove the microblazeel target from the CI
 jobs
Date: Mon,  2 Mar 2026 13:34:08 +0100
Message-ID: <20260302123413.274700-6-thuth@redhat.com>
In-Reply-To: <20260302123413.274700-1-thuth@redhat.com>
References: <20260302123413.274700-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Since we're going to remove the qemu-system-microblazeel binary,
remove the related tests from the CI jobs now (or switch to "microblaze"
where it is appropriate).

Note: Since "build-system-ubuntu" does not have as many targets as
"build-system-fedora", we turn the "microblazeel-softmmu" into a
"microblaze-softmmu" in the ubuntu job, and remove the corresponding
target from the fedora job instead, so that the load is more balanced
now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260226084608.11251-4-thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml   | 6 +++---
 .gitlab-ci.d/cirrus.yml      | 4 ++--
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index fef19c2d5da..6ad35945222 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -40,7 +40,7 @@ build-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs --enable-rust
-    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
+    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
@@ -112,7 +112,7 @@ build-system-fedora:
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg --enable-rust
-    TARGETS: microblaze-softmmu mips-softmmu
+    TARGETS: mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build check-doc
 
@@ -664,7 +664,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-      --target-list-exclude=aarch64-softmmu,microblaze-softmmu,mips64-softmmu,mipsel-softmmu,ppc64-softmmu,sh4el-softmmu,xtensa-softmmu,x86_64-softmmu
+      --target-list-exclude=aarch64-softmmu,mips64-softmmu,mipsel-softmmu,ppc64-softmmu,sh4el-softmmu,xtensa-softmmu,x86_64-softmmu
     MAKE_CHECK_ARGS: check
 
 build-libvhost-user:
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 177bd684ef5..f2a9a64b76a 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -42,7 +42,7 @@ x64-freebsd-14-build:
     CIRRUS_VM_RAM: 8G
     UPDATE_COMMAND: pkg update; pkg upgrade -y
     INSTALL_COMMAND: pkg install -y
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu --enable-rust
+    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu --enable-rust
     TEST_TARGETS: check
 
 aarch64-macos-build:
@@ -56,5 +56,5 @@ aarch64-macos-build:
     INSTALL_COMMAND: brew install
     PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu --enable-rust
+    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu --enable-rust
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 59ff8b1d870..cf977dfefb1 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -111,7 +111,7 @@ cross-win64-system:
     IMAGE: fedora-win64-cross
     EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu
-                        m68k-softmmu microblazeel-softmmu
+                        m68k-softmmu microblaze-softmmu
                         or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
                         tricore-softmmu xtensaeb-softmmu
   artifacts:
-- 
2.53.0


