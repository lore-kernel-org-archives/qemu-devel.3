Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870F9FD3774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHbK-0005bH-IK; Wed, 25 Feb 2026 11:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHbE-0005aD-Ls
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHbD-0005Yo-7q
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772036334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGiE2Mj26/K0+IHn+BsLqkO0T620m/FjtFIhpQuCwR8=;
 b=Yb2gHVKlwN+jkJNM24RVQIq0WYMcaNikAvDc4V/V9YY+UCeZySg00vBHzW3Yoh+uoAuRm8
 KhhZ+le6JM+jWL1V5F5ZStDhcAHAWi5/VJ1AVZoivty6LgSW+oMbz2NJFi3RdyKlVDHe4f
 INEwkwb6w+/xiltUGJc2S+NLtYH9dVk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-Ie7zv96SObi5Fe8bJ6Xxhw-1; Wed,
 25 Feb 2026 11:18:51 -0500
X-MC-Unique: Ie7zv96SObi5Fe8bJ6Xxhw-1
X-Mimecast-MFC-AGG-ID: Ie7zv96SObi5Fe8bJ6Xxhw_1772036329
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D22CE1956078; Wed, 25 Feb 2026 16:18:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37F2E1800465; Wed, 25 Feb 2026 16:18:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 3/4] gitlab-ci: Remove the microblazeel target from the CI jobs
Date: Wed, 25 Feb 2026 17:18:20 +0100
Message-ID: <20260225161823.1438850-4-thuth@redhat.com>
In-Reply-To: <20260225161823.1438850-1-thuth@redhat.com>
References: <20260225161823.1438850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml   | 6 +++---
 .gitlab-ci.d/cirrus.yml      | 4 ++--
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1b656b9eb08..ae3a367cb39 100644
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
 
@@ -676,7 +676,7 @@ build-without-defaults:
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


