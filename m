Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D45EC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMbk-00032o-2h; Tue, 20 May 2025 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uHMbf-0002zt-Vn
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uHMbd-0002Ne-3p
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:07 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxWOFIfSxoV27zAA--.54S3;
 Tue, 20 May 2025 21:02:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx_cZGfSxoW1bjAA--.62430S3;
 Tue, 20 May 2025 21:02:00 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] uefi-test-tools:: Add LoongArch64 support
Date: Tue, 20 May 2025 21:01:51 +0800
Message-Id: <20250520130158.767083-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250520130158.767083-1-maobibo@loongson.cn>
References: <20250520130158.767083-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZGfSxoW1bjAA--.62430S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add support to build bios-tables-test iso image for LoongArch system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>

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
2.41.0


