Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508DCC5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZ1-00026w-3c; Sun, 01 Jun 2025 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYy-000265-Ip
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYx-0004dX-0b
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQ5mn/pPFh+YZmi+IS0xHBlc0CO0vI6XdycBZ6UjxU8=;
 b=Xue3aLxNtcMOiuPiqdsg0eAbG38FgX68C8YWyjM8mW0AgLrkIVQ1ihAOZcbVjc2nkdPl/1
 /j6aV9fKXctXX7bwOhGww/8Wx7YmUumKnlUMKNIna7kFgcuSsnDetiXeaqLw6IKXivLEeC
 juoUcO+ocEi4bgCBOQ68Avn8UF4f5sI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-F7RybbWuOMWfxqSgQWGazA-1; Sun, 01 Jun 2025 11:25:25 -0400
X-MC-Unique: F7RybbWuOMWfxqSgQWGazA-1
X-Mimecast-MFC-AGG-ID: F7RybbWuOMWfxqSgQWGazA_1748791524
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso4806005e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791524; x=1749396324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ5mn/pPFh+YZmi+IS0xHBlc0CO0vI6XdycBZ6UjxU8=;
 b=PcsWvfcv0WTgihp8Lnct7iV7IXxcfPA9Tk0qJlfu2kfDgYTee6Yx5qAPrSCDHG0cAo
 8/pgt8vG90ExGhk+YlD9lkpHoNnlSYVyZUh06GWkajHSiqxxe045rxDPrNS7mApRPBux
 rrE8Q4+PBPipemYHSYNsr2HzPYfDf48QVA/LcrbX8TMpKRk0SXQYP5dVRd+QYgoFdy2/
 eC8l+NLhI413w4Q9FXC3cMoKrPjBFQjgLh61/MmZSY9P24ux4alhRQwEYKJIWxGwRTs6
 Ywi9fB4dM+atFpxKTCgP2e2OJFux4FH/8cgCE50MDMqZqspLusQPXTsG6VyBm95L96N+
 m+wQ==
X-Gm-Message-State: AOJu0YxUPlnwuJM5bdoV0fs7fV7ISgqierUnCY1L/bx4OOxWkRSsik0e
 E2ac0oa/eS6KGo1UxtoLdHKqjnSkigxr0fJ6wu4uUgG8wMkkUX1W4saIQExojYcD5zOqVfwI4E3
 a0k9C/iyELovouwOx/BirxhVAUwm2Z4uszKBEzMl4naUbUePr8CHKuGVoF0H/vJC0BKI2F063ca
 33uoILu1Qe2+vzsXA4pQRWcNgHcxL/5/7/jQ==
X-Gm-Gg: ASbGnctpLsOnd1Z1K2rabDV0h3rP3RFqE/9qzIw9TFB0cvMpi+ivhp3Jq1j8tM5scJ+
 HBXdWVM2VXaB25ggRNNAiAQHu8g58Lf32WcoAsXjYI7RJfAWQCQWT0QcbaWxDOirFir77x3U6Xl
 oRJ0OaSFzosiwzV+juiJ40JevPYzh49N5obQTJ4cDv+2gCbNH2RjmbVsH5GMtNxxmHnd2fH/eVZ
 JIz17Cz0bYuti8QzHOAE9B737rPKlgt4ysIDMEAejg4QxFsL5nELSr6ONpr1MuoPtt++NDVjjSu
 19tfZw==
X-Received: by 2002:a05:600c:35c2:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-4511edf0aa8mr40353395e9.23.1748791523758; 
 Sun, 01 Jun 2025 08:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlbannIW+eZkKcdo0t8CEhQuUXo62gtoqGtTVNmNEPeQwSrozs93k+XHDrQRxkDGo6bc2E8w==
X-Received: by 2002:a05:600c:35c2:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-4511edf0aa8mr40353175e9.23.1748791523355; 
 Sun, 01 Jun 2025 08:25:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b92bsm11592943f8f.9.2025.06.01.08.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:22 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/31] uefi-test-tools:: Add LoongArch64 support
Message-ID: <75d4680c55498d6cf4f89b31e52d97f90d7fc46e.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

Add support to build bios-tables-test iso image for LoongArch system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Message-Id: <20250520130158.767083-2-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/uefi-test-tools/Makefile                         |  5 +++--
 .../UefiTestToolsPkg/UefiTestToolsPkg.dsc              |  6 +++++-
 tests/uefi-test-tools/uefi-test-build.config           | 10 ++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
index f4eaebd8ff..8ee6fb3571 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -12,7 +12,7 @@
 
 edk2_dir              := ../../roms/edk2
 images_dir            := ../data/uefi-boot-images
-emulation_targets     := arm aarch64 i386 x86_64 riscv64
+emulation_targets     := arm aarch64 i386 x86_64 riscv64 loongarch64
 uefi_binaries         := bios-tables-test
 intermediate_suffixes := .efi .fat .iso.raw
 
@@ -56,7 +56,8 @@ Build/%.iso.raw: Build/%.fat
 # stripped from, the argument.
 map_arm_to_uefi     = $(subst arm,ARM,$(1))
 map_aarch64_to_uefi = $(subst aarch64,AA64,$(call map_arm_to_uefi,$(1)))
-map_riscv64_to_uefi = $(subst riscv64,RISCV64,$(call map_aarch64_to_uefi,$(1)))
+map_loongarch64_to_uefi = $(subst loongarch64,LOONGARCH64,$(call map_aarch64_to_uefi,$(1)))
+map_riscv64_to_uefi = $(subst riscv64,RISCV64,$(call map_loongarch64_to_uefi,$(1)))
 map_i386_to_uefi    = $(subst i386,IA32,$(call map_riscv64_to_uefi,$(1)))
 map_x86_64_to_uefi  = $(subst x86_64,X64,$(call map_i386_to_uefi,$(1)))
 map_to_uefi         = $(subst .,,$(call map_x86_64_to_uefi,$(1)))
diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
index 0902fd3c73..facf8df1fa 100644
--- a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
@@ -19,7 +19,7 @@
   PLATFORM_VERSION        = 0.1
   PLATFORM_NAME           = UefiTestTools
   SKUID_IDENTIFIER        = DEFAULT
-  SUPPORTED_ARCHITECTURES = ARM|AARCH64|IA32|X64|RISCV64
+  SUPPORTED_ARCHITECTURES = ARM|AARCH64|IA32|X64|RISCV64|LOONGARCH64
   BUILD_TARGETS           = DEBUG
 
 [BuildOptions.IA32]
@@ -65,6 +65,10 @@
 [LibraryClasses.RISCV64]
   BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
 
+[LibraryClasses.LOONGARCH64]
+  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
+  StackCheckLib|MdePkg/Library/StackCheckLibNull/StackCheckLibNull.inf
+
 [PcdsFixedAtBuild]
   gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x8040004F
   gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0x2F
diff --git a/tests/uefi-test-tools/uefi-test-build.config b/tests/uefi-test-tools/uefi-test-build.config
index a4c61fc97a..8bf4826634 100644
--- a/tests/uefi-test-tools/uefi-test-build.config
+++ b/tests/uefi-test-tools/uefi-test-build.config
@@ -21,6 +21,16 @@ dest = ./Build
 arch = AARCH64
 cpy1 = AARCH64/BiosTablesTest.efi  bios-tables-test.aarch64.efi
 
+####################################################################################
+# loongarch64
+
+[build.loongarch64]
+conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
+plat = UefiTestTools
+dest = ./Build
+arch = LOONGARCH64
+cpy1 = LOONGARCH64/BiosTablesTest.efi  bios-tables-test.loongarch64.efi
+
 ####################################################################################
 # riscv64
 
-- 
MST


