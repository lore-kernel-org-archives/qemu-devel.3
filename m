Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE518C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t98-0005w9-KG; Mon, 06 May 2024 03:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8x-0005r7-AN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8v-0001eo-PT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DU50XkwxYuhVEPBKoJ+oPs10H2H4J3RCxabXElmSlk=;
 b=HQj3UxhAH94Xmm7DobP80eUgDlgzejyHG1c5XjgSQRGvakHQVj9URmG0u6mEjVvaDMT80F
 hkVnCYYmWAFw62NfsY6dIOoZte8sD0Q6Q3J4RgmaO6s80jjYnzFL3oRF4CJ90a2DGxPdXz
 DYVbujhVNSch9gPfPMlr/f2O0KRFUco=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-BLuM4K8aPhWFYvTiU4nOLQ-1; Mon, 06 May 2024 03:52:11 -0400
X-MC-Unique: BLuM4K8aPhWFYvTiU4nOLQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572ef3eb368so215269a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981930; x=1715586730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DU50XkwxYuhVEPBKoJ+oPs10H2H4J3RCxabXElmSlk=;
 b=rp9SYc9kKHvF2qvP00z6MoajbBdMJhAD898jUJUvZxt8ASQ3yfZ2luWQC61sYsoja/
 gqSD9y3DKO6hAiMVw2yDKoBZ4o+UC9WhlSG4M5hRc712xE1EB9NdkCB8FyWZ3GqpEYh+
 w6IUcguChpbps8x3Qs2QDDN/5cy476ksc3KauboIOwtFe9iCp3qu+EV/HXKCcNZES9QQ
 fpS9kr2xIKsc6Hq6a7cLmQ4nYFqybwH+6uIKnI+DpXkYASlWxal6MLD+ZkE2WS2rIR9E
 JRO4znKodvB7pBMYlYLrADF7p5vVLwHjH++UveraVM1Ju5hh8QhDekwp01kvgChdFrFc
 I7Gg==
X-Gm-Message-State: AOJu0YwCobcYib34CVCuVVSK1cv4i1MUoJ70a+3UafI4RlrgrygW+Y5v
 7w7bDHq/8Uj+lcYxqRhm0GFEISyBj7DI8G4qWM/973ykKErXyfyX1is7zVhC4JujP6Fk2CcZYjU
 Z5OXKQsC3heC30MSSiRMDBI7Snz9Yq7DwLe22gGS1um1xrVXSKRPWZS+f2k0o01JakXlzpl1DC0
 8OqeCik12pW1njJ5fZqyUM50a3ngQWMf/IKO3h
X-Received: by 2002:a50:8e16:0:b0:572:a17d:a302 with SMTP id
 22-20020a508e16000000b00572a17da302mr4940693edw.42.1714981930094; 
 Mon, 06 May 2024 00:52:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ1+JV4lAk76pz7VFh1V5aSwRct4x0ttUcgJXg2KVa7LVUKokJ3k7xa2dhB4uAsJ30L6fkDA==
X-Received: by 2002:a50:8e16:0:b0:572:a17d:a302 with SMTP id
 22-20020a508e16000000b00572a17da302mr4940683edw.42.1714981929766; 
 Mon, 06 May 2024 00:52:09 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a50ea8a000000b00571c1df911fsm4845755edo.37.2024.05.06.00.52.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/46] mips: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:56 +0200
Message-ID: <20240506075125.8238-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with MIPS.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/mips-softmmu/common.mak      |  5 +++--
 configs/devices/mips64-softmmu/default.mak   |  4 +++-
 configs/devices/mips64el-softmmu/default.mak | 10 ++++++----
 .gitlab-ci.d/buildtest.yml                   |  3 ++-
 hw/mips/Kconfig                              | 12 ++++++++++++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/configs/devices/mips-softmmu/common.mak b/configs/devices/mips-softmmu/common.mak
index 416a5d353e8..b50107feafe 100644
--- a/configs/devices/mips-softmmu/common.mak
+++ b/configs/devices/mips-softmmu/common.mak
@@ -4,5 +4,6 @@
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
-CONFIG_MALTA=y
-CONFIG_MIPSSIM=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_MALTA=n
+# CONFIG_MIPSSIM=n
diff --git a/configs/devices/mips64-softmmu/default.mak b/configs/devices/mips64-softmmu/default.mak
index 566672f3c22..1b8d7ced1c6 100644
--- a/configs/devices/mips64-softmmu/default.mak
+++ b/configs/devices/mips64-softmmu/default.mak
@@ -1,4 +1,6 @@
 # Default configuration for mips64-softmmu
 
 include ../mips-softmmu/common.mak
-CONFIG_JAZZ=y
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_JAZZ=n
diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
index 88a37cf27f1..9dce346c4fb 100644
--- a/configs/devices/mips64el-softmmu/default.mak
+++ b/configs/devices/mips64el-softmmu/default.mak
@@ -1,7 +1,9 @@
 # Default configuration for mips64el-softmmu
 
 include ../mips-softmmu/common.mak
-CONFIG_FULOONG=y
-CONFIG_LOONGSON3V=y
-CONFIG_JAZZ=y
-CONFIG_MIPS_BOSTON=y
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_FULOONG=n
+# CONFIG_LOONGSON3V=n
+# CONFIG_JAZZ=n
+# CONFIG_MIPS_BOSTON=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e2e92f25c58..811132443a7 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -649,7 +649,7 @@ build-tci:
 
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
-#   x86_64
+#   mips64el, x86_64
 # does not build without boards: i386, loongarch64, x86_64
 build-without-defaults:
   extends: .native_build_job_template
@@ -665,6 +665,7 @@ build-without-defaults:
       --disable-qom-cast-debug
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
+      mips-softmmu mips64-softmmu mipsel-softmmu
       s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 5c83ef49cf6..9bccb363eb9 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,5 +1,7 @@
 config MALTA
     bool
+    default y
+    depends on MIPS
     imply PCNET_PCI
     imply PCI_DEVICES
     imply TEST_DEVICES
@@ -13,11 +15,15 @@ config MALTA
 
 config MIPSSIM
     bool
+    default y
+    depends on MIPS
     select SERIAL
     select MIPSNET
 
 config JAZZ
     bool
+    default y
+    depends on MIPS64
     select ISA_BUS
     select RC4030
     select I8259
@@ -38,6 +44,8 @@ config JAZZ
 
 config FULOONG
     bool
+    default y
+    depends on MIPS64 && !TARGET_BIG_ENDIAN
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply ATI_VGA
@@ -48,6 +56,8 @@ config FULOONG
 
 config LOONGSON3V
     bool
+    default y
+    depends on MIPS64 && !TARGET_BIG_ENDIAN
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_PCI
@@ -69,6 +79,8 @@ config MIPS_CPS
 
 config MIPS_BOSTON
     bool
+    default y
+    depends on MIPS64 && !TARGET_BIG_ENDIAN
     imply PCI_DEVICES
     imply TEST_DEVICES
     select FITLOADER
-- 
2.44.0


