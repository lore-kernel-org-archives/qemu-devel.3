Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3356606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=WYJSnOGH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2tg-0000Q7-MN; Tue, 24 Nov 2026 21:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2tB-0000EJ-3B
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:42 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t6-00079M-L7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:40 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b4d5e645d1so33595157b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795574253; x=1796179053; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0uQomD/7jYFFCn01yAXbAJpuXqIpyq5wUONqra66zs=;
 b=WYJSnOGHfY49Q8i2lWCJWZl/jhf/R2EyJXMmXVUALqD78+gFTLgh594agqnkiwzaCS
 en2HXo7ttjdYV6Xyp/S5gXHaK0aDOJjYYrremcm2thDrip9wBNo1uZC4yf+UxcMtAcvU
 lfYJaoBenx3wKIcLGWUGXr1tzxhkGt8kovcZ7ZsrG7jPcFo56GPLTjrK3zm/m2ZyE3fz
 DRUAOiZTkS3hSuZlBHrn7ocPhoZowMNEgTEugUJlkjNl6debNbsTWquPUoRMYu//t74H
 rzswaYERKKg6oFvtiLAHhXZXAVt0eqlh+IQhQPxFU90q/rXfygJFJ6bX3BIQ4gzClkAR
 eNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795574253; x=1796179053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y0uQomD/7jYFFCn01yAXbAJpuXqIpyq5wUONqra66zs=;
 b=uZCKoTGj9/4RHnaCUCAyRdSvG9uB1CvjpRFftGd5kZZu1wYR2gxw+wUzXB6YGHLs6t
 3d1S5VvEsSlG20clAU7ii/uaohi7z6Xi/ctQiuXNVZn+7mVCqfpueWGbbaq9LuDpQuN7
 NdkJ/FIhMofBqmC4vyMgrRj0zzs30rU/gIrOj2ZxCTkal0O+KHG7bOwVSUFy8Dg8Q4fx
 tSDJUKXyluniiyvL+GDsP006VgK0xgnXU0LVQCOlaJ2ncXOpTpuFlwm5818nMYTSvsxX
 T3NnezL6oOzy9+nu4aAOpgV2CKt3ziU+cmg0/tWvSNNeZXJbK6CUvTvw/NKHAIWqcu1y
 arUQ==
X-Gm-Message-State: APuU4Z9CYHhP5I8QNhemVOOxYbL63xUBBal1zHF+t8pf1m94tN5D1lqy
 r4u6BK6fkn2239BWTCZ4lfm6Jf3755oru3ENNlradQ8gHDIkObS2awQMh9Akjpu0uzE=
X-Gm-Gg: AZFdTZcN0Hb50UiipuFrjgiUFx3XFmF4wMqOXUG9Mz0n2id9NCi9lY8K8FmZ7DcoZbp
 bAjpeB1v3rdrm+K5ddQKLwNNdo6UgLTP1dwSoKhHfGDQ+P8K0V6QzJ49NRFRdtvb46GFK83SUQ6
 YRmy8ibfg/RnEeZ3GBc144HH5gUXy4viBJJxeHarIAX3sBDqnPMKjXJf4MMueQN4LGqmkKVB3oS
 CnTs4XinLVY8Wm+CT56ouO9gO/hMIErS01Wccn3jPR9QlYqyDe2rHxbjLu3meTyuBLO6EDtw0+x
 45P8ld5i6D7wwER8ewWqzetlCha5Tbf1Hjg4Jas/qG+d8M1HwQqIFKv8AfD/QQ2uJ/F5fHVyWya
 iZaQ5qEdxKmcA2TfC9cLYf54s43K1nljmDBnoiFfg8bcxGd1c//JhCaHOTLQciNVkMzJXCTGUkI
 6AtzGRf06UtOHoor+NTE5/vqq7ErqaPkcDYrC4NDjJMgsbntHK64hwXqyhN5IW+qjehBe/Sd+fD
 39wiU1FOv7tu+oyUg9Kg6+GRxIGW+wJATNFVUNy/X8i0GuUPoDFO7eMsoVeIMBBZ+/y5c3678Gs
 GRidU6/+wPtF2ET/t8vGQiwERGBX0PgBgLmj072Vi24lf0nhCqprLkLndjVMS5w03BOCXo+14yu
 0KxLXamE5ow==
X-Received: by 2002:a05:690c:e0c:b0:8b4:d64a:7aaa with SMTP id
 00721157ae682-8b5204ba69fmr69205257b3.43.1795574253394; 
 Tue, 24 Nov 2026 18:37:33 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:ea8f:7897:2f4d:9891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm65626717b3.8.2026.11.24.18.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:37:33 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 20:37:25 -0600
Subject: [PATCH 6/8] hw/riscv/spacemit-k3: Load next stage from boot media
 if bootrom is not supplied
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-spacemit_k3-v1-6-e911d6e88542@oss.tenstorrent.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Jeuk Kim <jeuk20.kim@samsung.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the bootrom is not supplied via -bios, simulate the bootrom's
loading of the next stage from appropriate boot media based on the
boot selection pins. A boootinfo block is read from a fixed address on
boot media to determine the offset to load the next boot stage from.
A CRC check is done on the loaded boot stage, and compared to a value
stored on boot media. If this check fails, or the boot media is unable
to be read, the next boot media as per the boot mode order is chosen.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 hw/misc/spacemit_k3_syscon.c         |  31 ++++++
 hw/riscv/spacemit_k3.c               | 197 ++++++++++++++++++++++++++++++++++-
 include/hw/misc/spacemit_k3_syscon.h |  10 ++
 3 files changed, 235 insertions(+), 3 deletions(-)

diff --git a/hw/misc/spacemit_k3_syscon.c b/hw/misc/spacemit_k3_syscon.c
index 03a826495a..452cab8183 100644
--- a/hw/misc/spacemit_k3_syscon.c
+++ b/hw/misc/spacemit_k3_syscon.c
@@ -30,8 +30,14 @@
 #define BOOT_MODE_VALUE_USB 0x10001000
 #define BOOT_MODE_VALUE_UART 0x10001800
 
+#define SELECTED_BOOT_MODE_VALUE_EMMC 0xb00
+#define SELECTED_BOOT_MODE_VALUE_NOR 0xb01
+#define SELECTED_BOOT_MODE_VALUE_UFS 0xb03
+#define SELECTED_BOOT_MODE_VALUE_SD 0xb10
+
 /* CPU Config register offsets */
 #define BOOT_PIN_SELECT 0x20
+#define BOOT_DEV_FLAG_REG 0x110
 
 /* Syscon APMU register offsets */
 #define APMU_RCPU_CLK_RES_CTRL 0x14c
@@ -183,6 +189,31 @@ static uint32_t spacemit_k3_boot_mode_value(int boot_mode)
     return boot_mode_values[boot_mode];
 }
 
+void spacemit_k3_set_selected_boot_mode(SpacemitK3CPUConfigState *s,
+                                        int selected_boot_mode) {
+    static const uint32_t selected_boot_mode_values[] = {
+      [SPACEMIT_K3_SELECTED_BOOT_MODE_EMMC] =
+          SELECTED_BOOT_MODE_VALUE_EMMC,
+      [SPACEMIT_K3_SELECTED_BOOT_MODE_NOR] =
+          SELECTED_BOOT_MODE_VALUE_NOR,
+      [SPACEMIT_K3_SELECTED_BOOT_MODE_UFS] =
+          SELECTED_BOOT_MODE_VALUE_UFS,
+      [SPACEMIT_K3_SELECTED_BOOT_MODE_SD] =
+          SELECTED_BOOT_MODE_VALUE_SD,
+    };
+
+    if (selected_boot_mode < 0 ||
+          selected_boot_mode >= ARRAY_SIZE(selected_boot_mode_values)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad selected boot mode %d\n",
+                      __func__,
+                      selected_boot_mode);
+        return;
+    }
+
+    s->regs[TO_REG(BOOT_DEV_FLAG_REG)] =
+      selected_boot_mode_values[selected_boot_mode];
+}
+
 static const MemoryRegionOps spacemit_k3_syscon_mpmu_ops = {
     .read = spacemit_k3_syscon_mpmu_read,
     .write = spacemit_k3_syscon_mpmu_write,
diff --git a/hw/riscv/spacemit_k3.c b/hw/riscv/spacemit_k3.c
index 47e5ec1932..2ff035c239 100644
--- a/hw/riscv/spacemit_k3.c
+++ b/hw/riscv/spacemit_k3.c
@@ -27,9 +27,15 @@
 #include "hw/ssi/ssi.h"
 
 #include "system/system.h"
+#include "system/block-backend-io.h"
+#include "qemu/error-report.h"
+#include <stdint.h>
+#include <zlib.h>
 
 #include "hw/riscv/spacemit_k3.h"
 
+#include "system/qtest.h"
+
 #define SPACEMIT_K3_IRQCHIP_NUM_MSIS       511
 #define SPACEMIT_K3_IRQCHIP_NUM_SOURCES    512
 #define SPACEMIT_K3_IRQCHIP_NUM_PRIO_BITS  3
@@ -43,6 +49,11 @@
 #define SPACEMIT_K3_ACLINT_MTIMECMP      0x4000
 #define SPACEMIT_K3_ACLINT_TIMEBASE_FREQ 24000000
 
+#define SPACEMIT_K3_FSBL_NOR_OFFSET  0x0
+#define SPACEMIT_K3_FSBL_SD_OFFSET   0x100000
+#define SPACEMIT_K3_FSBL_EMMC_OFFSET 0x100000
+#define SPACEMIT_K3_FSBL_UFS_OFFSET  0x100000
+
 static const MemMapEntry spacemit_k3_memmap[] = {
     [SPACEMIT_K3_PCIE] =              {  0x80000000,    0x4000000 },
     [SPACEMIT_K3_ESPI_SLV_MEM] =      {  0x84000000,    0x2000000 },
@@ -92,6 +103,130 @@ static const MemMapEntry spacemit_k3_memmap[] = {
     [SPACEMIT_K3_DRAM] =              { 0x100000000,  0x400000000 },
 };
 
+static int spacemit_k3_load_fsbl(SpacemitK3State *ms, DriveInfo *di,
+                                 uint64_t bootinfo_offset,
+                                 int selected_boot_mode)
+{
+    /* Read Bootinfo block */
+    g_autofree void *bootinfo = g_malloc(0x44);
+    uint32_t spl0_offset, spl_max_size, spl_size, target_crc, computed_crc;
+    if (blk_pread(blk_by_legacy_dinfo(di), bootinfo_offset, 0x44, bootinfo, 0) <
+        0) {
+        error_report("Cannot read bootinfo from boot media");
+        return -1;
+    }
+
+    /* Check CRC of Bootinfo block */
+    target_crc = ldl_le_p(bootinfo + 0x40);
+    computed_crc = crc32(0, bootinfo, 0x40);
+
+    if (target_crc != computed_crc) {
+        error_report("Bootinfo CRC doesn't match");
+        return -1;
+    }
+
+    /* Get SPL Offset and Max Size from bootinfo */
+    spl0_offset = ldl_le_p(bootinfo + 0x20);
+    spl_max_size = ldl_le_p(bootinfo + 0x28);
+
+    if (spl_max_size < 0x1000) {
+        error_report("SPL Max Size value is too small");
+        return -1;
+    }
+
+    /*
+     * Every bootinfo block generated from the vendor
+     * BSP seems to have this as the max value, so
+     * cap it at that.
+     */
+    if (spl_max_size > 0x74000) {
+        error_report("SPL Max Size value is too big");
+        return -1;
+    }
+
+    g_autofree void *fsbl = g_malloc(spl_max_size);
+
+    /* Read SPL */
+    if (blk_pread(blk_by_legacy_dinfo(di), spl0_offset, spl_max_size, fsbl, 0) <
+        0) {
+        error_report("Cannot read FSBL from boot media");
+        return -1;
+    }
+
+    spl_size = ldq_le_p(fsbl + 0xfe0 + 0x8);
+    if (spl_size > spl_max_size - 0x1000) {
+        error_report("SPL Size is too big");
+        return -1;
+    }
+
+    /* Check CRC of SPL*/
+    target_crc = ldl_le_p(fsbl + 0xfe0 + 28);
+    computed_crc = crc32(0, fsbl + 0x1000, spl_size);
+
+    if (target_crc != computed_crc) {
+        error_report("FSBL CRC doesn't match");
+        return -1;
+    }
+
+    rom_add_blob_fixed("spacemit-k3.fsbl", fsbl + 0x1000, spl_size,
+                       ms->memmap[SPACEMIT_K3_SRAM].base + 0x1000);
+
+    /*
+     * Bootrom writes to this register to specify boot medium it picked
+     * Subsequnent stages read this register. Simulate this write
+     */
+    spacemit_k3_set_selected_boot_mode(&ms->cpu_config, selected_boot_mode);
+    return 0;
+}
+
+static int spacemit_k3_load_fsbl_sd(SpacemitK3State *ms)
+{
+    DriveInfo *sd = drive_get(IF_SD, 0, 0);
+    if (!sd) {
+        error_report("Failed to get sd");
+        return -1;
+    }
+
+    return spacemit_k3_load_fsbl(ms, sd, SPACEMIT_K3_FSBL_SD_OFFSET,
+                                 SPACEMIT_K3_SELECTED_BOOT_MODE_SD);
+}
+
+static int spacemit_k3_load_fsbl_emmc(SpacemitK3State *ms)
+{
+    DriveInfo *emmc = drive_get(IF_SD, 0, 2);
+    if (!emmc) {
+        error_report("Failed to get emmc");
+        return -1;
+    }
+
+    return spacemit_k3_load_fsbl(ms, emmc, SPACEMIT_K3_FSBL_EMMC_OFFSET,
+                                 SPACEMIT_K3_SELECTED_BOOT_MODE_EMMC);
+}
+
+static int spacemit_k3_load_fsbl_ufs(SpacemitK3State *ms)
+{
+    DriveInfo *ufs = drive_get(IF_SCSI, 0, 0);
+    if (!ufs) {
+        error_report("Failed to get ufs");
+        return -1;
+    }
+
+    return spacemit_k3_load_fsbl(ms, ufs, SPACEMIT_K3_FSBL_UFS_OFFSET,
+                                 SPACEMIT_K3_SELECTED_BOOT_MODE_UFS);
+}
+
+static int spacemit_k3_load_fsbl_nor(SpacemitK3State *ms)
+{
+    DriveInfo *nor = drive_get(IF_MTD, 0, 0);
+    if (!nor) {
+        error_report("Failed to get nor flash");
+        return -1;
+    }
+
+    return spacemit_k3_load_fsbl(ms, nor, SPACEMIT_K3_FSBL_NOR_OFFSET,
+                                 SPACEMIT_K3_SELECTED_BOOT_MODE_NOR);
+}
+
 static void spacemit_k3_machine_done(Notifier *notifier, void *data)
 {
     SpacemitK3State *s = container_of(notifier, SpacemitK3State,
@@ -103,9 +238,65 @@ static void spacemit_k3_machine_done(Notifier *notifier, void *data)
 
     riscv_boot_info_init(&boot_info, &s->soc);
 
-    riscv_find_and_load_firmware(machine, &boot_info,
-                                 firmware_name,
-                                 &start_addr, NULL);
+    /*
+     * Load bootrom supplied via -bios.
+     * If no file is supplied, load next stage from supplied images
+     * exactly as how bootrom would.
+     */
+    if (machine->firmware && strcmp(machine->firmware, "default") &&
+        strcmp(machine->firmware, "none")) {
+        riscv_find_and_load_firmware(machine, &boot_info, firmware_name,
+                                     &start_addr, NULL);
+    } else {
+        switch (s->boot_mode) {
+        case SPACEMIT_K3_BOOT_MODE_NOR:
+            if (spacemit_k3_load_fsbl_sd(s) < 0) {
+                error_report("Booting from SD failed, trying NOR");
+                if (spacemit_k3_load_fsbl_nor(s) < 0) {
+                    error_report("Booting from NOR Failed");
+                    if (qtest_enabled()) {
+                        return;
+                    }
+                    exit(1);
+                }
+            }
+            break;
+        case SPACEMIT_K3_BOOT_MODE_EMMC:
+            if (spacemit_k3_load_fsbl_sd(s) < 0) {
+                error_report("Booting from SD failed, trying EMMC");
+                if (spacemit_k3_load_fsbl_emmc(s) < 0) {
+                    error_report("Booting from EMMC Failed");
+                    if (qtest_enabled()) {
+                        return;
+                    }
+                    exit(1);
+                }
+            }
+            break;
+        case SPACEMIT_K3_BOOT_MODE_UFS:
+            if (spacemit_k3_load_fsbl_sd(s) < 0) {
+                error_report("Booting from SD failed, trying UFS");
+                if (spacemit_k3_load_fsbl_ufs(s) < 0) {
+                    error_report("Booting from UFS Failed");
+                    if (qtest_enabled()) {
+                        return;
+                    }
+                    exit(1);
+                }
+            }
+            break;
+        case SPACEMIT_K3_BOOT_MODE_NAND:
+        case SPACEMIT_K3_BOOT_MODE_USB:
+        case SPACEMIT_K3_BOOT_MODE_UART:
+            error_report("Supply bootrom via -bios to use these boot methods");
+            if (qtest_enabled()) {
+                return;
+            }
+            exit(1);
+        }
+        s->soc.harts[0].env.resetvec =
+            s->memmap[SPACEMIT_K3_SRAM].base + 0x1000;
+    }
 }
 
 static void spacemit_k3_machine_init(MachineState *machine)
diff --git a/include/hw/misc/spacemit_k3_syscon.h b/include/hw/misc/spacemit_k3_syscon.h
index 873f2c08e1..68450680d7 100644
--- a/include/hw/misc/spacemit_k3_syscon.h
+++ b/include/hw/misc/spacemit_k3_syscon.h
@@ -77,4 +77,14 @@ enum {
     SPACEMIT_K3_BOOT_MODE_UART,
 };
 
+enum {
+    SPACEMIT_K3_SELECTED_BOOT_MODE_EMMC,
+    SPACEMIT_K3_SELECTED_BOOT_MODE_NOR,
+    SPACEMIT_K3_SELECTED_BOOT_MODE_UFS,
+    SPACEMIT_K3_SELECTED_BOOT_MODE_SD,
+};
+
+void spacemit_k3_set_selected_boot_mode(SpacemitK3CPUConfigState *s,
+                                        int selected_boot_mode);
+
 #endif /* HW_MISC_SPACEMIT_K3_SYSCON_H */

-- 
2.43.0


