Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7D2C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMbv-0003Z4-3W; Tue, 20 May 2025 09:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uHMbj-0003B4-7X
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uHMbd-0002Nj-6I
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:10 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxyuBJfSxoX27zAA--.680S3;
 Tue, 20 May 2025 21:02:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx_cZGfSxoW1bjAA--.62430S5;
 Tue, 20 May 2025 21:02:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] tests/qtest/bios-tables-test: Use MiB macro rather
 hardcode value
Date: Tue, 20 May 2025 21:01:53 +0800
Message-Id: <20250520130158.767083-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250520130158.767083-1-maobibo@loongson.cn>
References: <20250520130158.767083-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZGfSxoW1bjAA--.62430S5
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace 1024 * 1024 with MiB macro.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec435..0b2bdf9d0d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1622,7 +1622,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 256ULL * 1024 * 1024,
+        .scan_len = 256ULL * MiB,
     };
 
     data.variant = ".memhp";
@@ -1717,7 +1717,7 @@ static void test_acpi_riscv64_virt_tcg_numamem(void)
         .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
         .ram_start = 0x80000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.variant = ".numamem";
@@ -1743,7 +1743,7 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.variant = ".numamem";
@@ -1765,7 +1765,7 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
     /*
      * While using -cdrom, the cdrom would auto plugged into pxb-pcie,
@@ -1841,7 +1841,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.variant = ".acpihmatvirt";
@@ -2095,7 +2095,7 @@ static void test_acpi_riscv64_virt_tcg(void)
         .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
         .ram_start = 0x80000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     /*
@@ -2117,7 +2117,7 @@ static void test_acpi_aarch64_virt_tcg(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.smbios_cpu_max_speed = 2900;
@@ -2138,7 +2138,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     test_acpi_one("-cpu cortex-a57 "
@@ -2223,7 +2223,7 @@ static void test_acpi_aarch64_virt_viot(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     test_acpi_one("-cpu cortex-a57 "
@@ -2407,7 +2407,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
     char *args;
 
-- 
2.41.0


