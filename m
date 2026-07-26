Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C278C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxzF-0001kA-HY; Sun, 26 Jul 2026 08:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzD-0001YK-3S
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzA-0003KE-7D
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso1856147b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068979; x=1785673779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKHz/f2Y+2B+bg+Zr4OrOSfNNtCTzXA5eoPO+6fqgDA=;
 b=nr6Hc4uZXV69mdK958WDmE4WgzZ2VewREW7zEvWVJJWk2zJqkYFV76d6aUNSPOFFmh
 2d0ImjwwzRucSB0tOcMxd4henz9nvT1xCPRXeD4uteMY+OIdmPbw9MQkLMCJJXMM9StK
 S7Fm+dISWAX/8tm9mGAqE6dnow1fTPyp2GwSySQdBRzZWi5CIewua7nh0GSl7Cm9lBTV
 m8Q2JJtzvOspPZMe11Jk/pAWARlROkFBYu/FwGVxn6OZs9QJ8S83qn9FT3OkN230U83E
 cYjud8BSOwq5ZWW2Toca9tNZ5l4iQn0ZJog8oAcW2/1Qwa9XN5KZ3iJuDHCOwCTRfeJI
 alXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068979; x=1785673779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKHz/f2Y+2B+bg+Zr4OrOSfNNtCTzXA5eoPO+6fqgDA=;
 b=AhLATpGpGa4tOVgvmCtGFPSTu0HRivLDvJmYGaAhxJHlxtOIM2iblR5Ol80omki7im
 VxNlpe0SeDFNTw3cNuOSgphaZeQ+X9NjRhgZnzvj/sqpv5XBmEBU2UQcxXPgoPcdlap6
 IXvpdxdhDMIKztNpHKkcRPtUFsRmua2Bi79tqs/a72creAK4zQ+6c0p7hVDHOXr/dfdR
 06S3nkywznZ73shdCCyms7s5ffvqc6rr1I796wXDl0CfqUl8Elo/AIO07ePvhNDNve7I
 1NWxCOfwvlwhqu4O5/qsf9ueAnbcVTdevpSLQZFQqrv6EnizHcV8lxS1g4OpSN/7a7tI
 rdQA==
X-Gm-Message-State: AOJu0YyDwtYDJYcOUpso5MkEn1LLCTdQDxvP+MkAAxzr/qPo86alPfOL
 r49noZFeWhSS0eGpnF8+rAc1pT3ix5AMcqngLAh7bZoEY9RN9zd02swWhAKtpGM8Z+c=
X-Gm-Gg: AR+sD12xIeMYSHyC5F1d4RaBTy5hCjlno/RT/V+b9bJiRWprDL2gxpSsXRJhwwuRJQY
 QvgXLrKqGxXt0a732s7dVJ6a2PXpaxRGUFFLWEhOTFl5nRA/PKWnSxxnbCW5e5gfD96pcuHr8ox
 +ka7BH+l4GKywZ6BeOqvBrFYjleTHq3RG47cduwnivYe2zH86JBhuWY6DcVTrvcRg2Z1vvnjOpz
 /VX75pu9UfukgyahT9SBs3e6nRl7eIKLaRs5yMZn9NK56F7JLFsT7NNk0YmJGRr05pYSihmvQxc
 bqu8Y5BhCCC6J0W4Vfz9KP4/yp/fjR/yOdYZwsG551KQLEqigNCA+PkvqZBcR+JuCxYfxVvI41e
 63GwlH/HL6PsW0vE+q1cNI2RTJC0TkaEh18wNNXbnSv7cOlWRCt6klsNYKaBbYa2vPaVLg0H0HR
 J46nagQryw/xfzuI1iK3GY
X-Received: by 2002:a05:6a00:b83:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-84e59425aa8mr3871874b3a.9.1785068978619; 
 Sun, 26 Jul 2026 05:29:38 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:29:37 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 07/11] hw/riscv/k230: Attach SPI NOR flash to spi0
Date: Sun, 26 Jul 2026 20:28:25 +0800
Message-ID: <d42e5d4f870c5ea9b5a6f0aa871242dccbe5c3bb.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the optional spi-flash machine property and attach the selected
m25p80-compatible device to logical spi0 chip select 0.

Use an MTD backend when supplied and keep the erased-flash default when
no drive is configured.

Cover JEDEC identification, standard read and page program, Quad output
read, and Quad page program in qtest.

Also exercise standard SPI reads and writes from U-Boot and Linux.

Also verify the U-Boot-managed boot path by loading the Linux and OpenSBI
payloads from the attached SPI flash instead of injecting them via the
QEMU command line. The system reaches a Linux shell.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst     |   1 +
 hw/riscv/Kconfig               |   1 +
 hw/riscv/k230.c                |  66 ++++++++
 include/hw/riscv/k230.h        |   2 +
 tests/qtest/k230-dw-ssi-test.c | 285 +++++++++++++++++++++++++++++++++
 5 files changed, 355 insertions(+)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 0358709d2c..0d2617c0f9 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -21,6 +21,7 @@ The ``k230`` machine supports the following devices:
 * 2 K230 Watchdog Timer
 * 5 UART
 * 3 K230 SSI controllers for SPI and QSPI
+* Optional SPI NOR flash on spi0 CS0
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 69059ae044..4984b0c9f3 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -163,3 +163,4 @@ config K230
     select UNIMP
     select K230_WDT
     select K230_DW_SSI
+    select SSI_M25P80
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 1863d5ecbb..36fd1eda22 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -21,7 +21,9 @@
 #include "system/device_tree.h"
 #include "system/system.h"
 #include "system/memory.h"
+#include "system/blockdev.h"
 #include "target/riscv/cpu.h"
+#include "hw/block/flash.h"
 #include "hw/core/loader.h"
 #include "hw/core/sysbus.h"
 #include "hw/riscv/k230.h"
@@ -31,6 +33,7 @@
 #include "hw/intc/sifive_plic.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
+#include "hw/ssi/ssi.h"
 
 /* Align K230_SDK k230_canmv_defconfig */
 #define K230_DIRECT_OPENSBI_ADDR 0x8000000
@@ -512,6 +515,49 @@ static void k230_firmware_boot(K230MachineState *s, MachineState *machine)
                               memmap[K230_DEV_BOOTROM].size, 0, 0);
 }
 
+static char *k230_machine_get_spi_flash(Object *obj, Error **errp)
+{
+    K230MachineState *s = RISCV_K230_MACHINE(obj);
+
+    return g_strdup(s->spi_flash_model);
+}
+
+static void k230_machine_set_spi_flash(Object *obj, const char *value,
+                                       Error **errp)
+{
+    K230MachineState *s = RISCV_K230_MACHINE(obj);
+
+    g_free(s->spi_flash_model);
+    s->spi_flash_model = g_strdup(value);
+}
+
+static void k230_connect_spi_flash(K230DwSsiState *ssi, unsigned int cs,
+                                   const char *flash_type, DriveInfo *dinfo)
+{
+    ObjectClass *flash_class;
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash_class = module_object_class_by_name(flash_type);
+    if (!flash_class || object_class_is_abstract(flash_class) ||
+        !object_class_dynamic_cast(flash_class, TYPE_M25P80)) {
+        error_report("'%s' is either abstract or not a subtype of m25p80",
+                     flash_type);
+        exit(EXIT_FAILURE);
+    }
+
+    flash = qdev_new(flash_type);
+
+    if (dinfo) {
+        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+
+    qdev_realize_and_unref(flash, BUS(ssi->spi), &error_fatal);
+
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(ssi), "cs", cs, flash_cs);
+}
+
 static void k230_machine_done(Notifier *notifier, void *data)
 {
     K230MachineState *s = container_of(notifier, K230MachineState,
@@ -543,6 +589,12 @@ static void k230_machine_init(MachineState *machine)
                             TYPE_RISCV_K230_SOC);
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
+    if (s->spi_flash_model) {
+        k230_connect_spi_flash(&s->soc.dw_ssi[2], 0,
+                               s->spi_flash_model,
+                               drive_get(IF_MTD, 0, 0));
+    }
+
     /* Data Memory */
     memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
                                 machine->ram);
@@ -555,6 +607,13 @@ static void k230_machine_instance_init(Object *obj)
 {
 }
 
+static void k230_machine_instance_finalize(Object *obj)
+{
+    K230MachineState *s = RISCV_K230_MACHINE(obj);
+
+    g_clear_pointer(&s->spi_flash_model, g_free);
+}
+
 static void k230_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -564,6 +623,12 @@ static void k230_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_cpus = 1;
     mc->default_ram_id = "riscv.K230.ram"; /* DDR */
     mc->default_ram_size = memmap[K230_DEV_DDRC].size;
+
+    object_class_property_add_str(oc, "spi-flash",
+                                  k230_machine_get_spi_flash,
+                                  k230_machine_set_spi_flash);
+    object_class_property_set_description(
+        oc, "spi-flash", "Attach an M25P80-compatible flash to spi0 CS0");
 }
 
 static const TypeInfo k230_machine_typeinfo = {
@@ -571,6 +636,7 @@ static const TypeInfo k230_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
+    .instance_finalize = k230_machine_instance_finalize,
     .instance_size = sizeof(K230MachineState),
     .interfaces = riscv64_machine_interfaces,
 };
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index cfe30590cc..493d739aa4 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -52,6 +52,8 @@ typedef struct K230MachineState {
     /*< public >*/
     K230SoCState soc;
     Notifier machine_done;
+
+    char *spi_flash_model;
 } K230MachineState;
 
 enum {
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index a507814b66..658b1f4cbf 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/bitops.h"
+#include "qemu/units.h"
 
 #define K230_SPI0_BASE          0x91584000ULL
 #define K230_SPI1_BASE          0x91582000ULL
@@ -68,9 +69,11 @@
 
 #define K230_SSI_SPI_CTRLR0_TRANS_TYPE(v) ((v) & 0x3U)
 #define K230_SSI_SPI_CTRLR0_ADDR_L(bits)  (((bits) / 4U) << 2)
+#define K230_SSI_SPI_CTRLR0_XIP_MD_EN     BIT(7)
 #define K230_SSI_SPI_CTRLR0_INST_L_8      (2U << 8)
 #define K230_SSI_SPI_CTRLR0_WAIT(v)       (((v) & 0x1fU) << 11)
 #define K230_SSI_SPI_CTRLR0_SPI_DDR_EN    BIT(16)
+#define K230_SSI_SPI_CTRLR0_XIP_MBL_8     (2U << 26)
 
 #define K230_SSI_SR_BUSY                BIT(0)
 #define K230_SSI_SR_TFNF                BIT(1)
@@ -88,6 +91,10 @@
 #define K230_SSI_IRQ_AXIE               8
 
 #define K230_SSI_FIFO_DEPTH             256
+#define K230_SSI_FLASH_IMAGE_SIZE       (32 * MiB)
+#define K230_SSI_FLASH_PATTERN_ADDR     0x100
+#define K230_SSI_FLASH_HIGH_ADDR        0x1000100
+#define K230_SSI_FLASH_PROGRAM_ADDR     0x22000
 
 typedef struct K230SsiInstance {
     uint64_t base;
@@ -96,6 +103,10 @@ typedef struct K230SsiInstance {
     uint32_t first_irq;
 } K230SsiInstance;
 
+typedef struct K230SsiFlashImage {
+    char *path;
+} K230SsiFlashImage;
+
 static const K230SsiInstance k230_ssi_instances[3] = {
     {
         .base = K230_SPI0_BASE,
@@ -117,6 +128,17 @@ static const K230SsiInstance k230_ssi_instances[3] = {
 
 #define FLASH_CMD_JEDEC         0x9f
 
+#define FLASH_CMD_WREN          0x06
+#define FLASH_CMD_RDSR          0x05
+#define FLASH_CMD_READ          0x03
+#define FLASH_CMD_READ4         0x13
+#define FLASH_CMD_QUAD_OUT      0x6b
+#define FLASH_CMD_QUAD_IO       0xeb
+#define FLASH_CMD_PP            0x02
+#define FLASH_SR_WIP            BIT(0)
+
+#define FLASH_CMD_QUAD_PP       0x32
+
 static QTestState *k230_ssi_start(void)
 {
     return qtest_init("-machine k230");
@@ -210,6 +232,188 @@ static bool k230_ssi_plic_pending(QTestState *qts, uint32_t irq)
     return qtest_readl(qts, addr) & BIT(irq % 32);
 }
 
+static void write_exact(int fd, const void *buf, size_t len, off_t offset)
+{
+    ssize_t ret = pwrite(fd, buf, len, offset);
+
+    g_assert_cmpint(ret, ==, len);
+}
+
+static void k230_ssi_flash_image_init(K230SsiFlashImage *image)
+{
+    static const uint8_t low_pattern[] = {
+        0xa5, 0x5a, 0x3c, 0xc3, 0x11, 0x22, 0x33, 0x44,
+    };
+    static const uint8_t high_pattern[] = { 0x71, 0x72, 0x73, 0x74 };
+    uint8_t erased[4096];
+    int fd;
+
+    memset(erased, 0xff, sizeof(erased));
+    image->path = NULL;
+    fd = g_file_open_tmp("qtest.k230.w25q256.XXXXXX", &image->path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, K230_SSI_FLASH_IMAGE_SIZE), ==, 0);
+    write_exact(fd, low_pattern, sizeof(low_pattern),
+                K230_SSI_FLASH_PATTERN_ADDR);
+    write_exact(fd, high_pattern, sizeof(high_pattern),
+                K230_SSI_FLASH_HIGH_ADDR);
+    write_exact(fd, erased, sizeof(erased), K230_SSI_FLASH_PROGRAM_ADDR);
+    close(fd);
+}
+
+static void k230_ssi_flash_image_clear(K230SsiFlashImage *image)
+{
+    if (image->path) {
+        unlink(image->path);
+        g_clear_pointer(&image->path, g_free);
+    }
+}
+
+static QTestState *k230_ssi_start_with_flash(K230SsiFlashImage *image)
+{
+    k230_ssi_flash_image_init(image);
+    return qtest_initf("-machine k230,spi-flash=w25q256 "
+                       "-drive file=%s,format=raw,if=mtd",
+                       image->path);
+}
+
+static void flash_write_transaction(QTestState *qts,
+                                    const uint8_t *command,
+                                    size_t command_len)
+{
+    g_assert_nonnull(command);
+    g_assert_cmpuint(command_len, >, 0);
+    g_assert_cmpuint(command_len, <=, K230_SSI_FIFO_DEPTH);
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_TO, 8, 0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, 0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SSIENR, 1);
+    for (size_t i = 0; i < command_len; i++) {
+        k230_ssi_write_frame(qts, K230_SPI0_BASE, command[i]);
+    }
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, BIT(0));
+    k230_ssi_wait_mask(qts, K230_SPI0_BASE, K230_SSI_TXFLR,
+                       UINT32_MAX, 0);
+    k230_ssi_wait_mask(qts, K230_SPI0_BASE, K230_SSI_SR,
+                       K230_SSI_SR_BUSY, 0);
+    k230_ssi_disable(qts, K230_SPI0_BASE);
+}
+
+static void flash_read_transaction(QTestState *qts,
+                                   const uint8_t *command,
+                                   size_t command_len,
+                                   uint8_t *data, size_t data_len)
+{
+    g_assert_nonnull(command);
+    g_assert_nonnull(data);
+    g_assert_cmpuint(command_len, >, 0);
+    g_assert_cmpuint(data_len, >, 0);
+    g_assert_cmpuint(data_len, <, K230_SSI_FIFO_DEPTH);
+
+    k230_ssi_configure(qts, K230_SPI0_BASE,
+                       K230_SSI_TMOD_EEPROM_READ, 8, data_len - 1);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, 0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SSIENR, 1);
+    for (size_t i = 0; i < command_len; i++) {
+        k230_ssi_write_frame(qts, K230_SPI0_BASE, command[i]);
+    }
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, BIT(0));
+    k230_ssi_wait_mask(qts, K230_SPI0_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, data_len);
+    for (size_t i = 0; i < data_len; i++) {
+        data[i] = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    }
+    k230_ssi_disable(qts, K230_SPI0_BASE);
+}
+
+static void flash_read(QTestState *qts, uint8_t opcode, uint32_t address,
+                       unsigned int addr_bytes, uint8_t *data, size_t len)
+{
+    uint8_t command[5];
+
+    g_assert_cmpuint(addr_bytes, <=, 4);
+    command[0] = opcode;
+    for (unsigned int i = 0; i < addr_bytes; i++) {
+        command[1 + i] = address >> (8 * (addr_bytes - i - 1));
+    }
+    flash_read_transaction(qts, command, 1 + addr_bytes, data, len);
+}
+
+static uint8_t flash_read_status(QTestState *qts)
+{
+    uint8_t command = FLASH_CMD_RDSR;
+    uint8_t status;
+
+    flash_read_transaction(qts, &command, 1, &status, 1);
+    return status;
+}
+
+static void flash_wait_ready(QTestState *qts)
+{
+    for (int i = 0; i < 1000; i++) {
+        if (!(flash_read_status(qts) & FLASH_SR_WIP)) {
+            return;
+        }
+        qtest_clock_step(qts, 1000000);
+    }
+    g_assert_cmphex(flash_read_status(qts) & FLASH_SR_WIP, ==, 0);
+}
+
+static void flash_write_enable(QTestState *qts)
+{
+    uint8_t command = FLASH_CMD_WREN;
+
+    flash_write_transaction(qts, &command, 1);
+}
+
+static void configure_enhanced_transfer(QTestState *qts, uint32_t tmod,
+                                        uint32_t frf, uint32_t trans_type,
+                                        uint32_t wait_cycles,
+                                        bool mode_bits_enabled,
+                                        size_t data_frames)
+{
+    uint32_t ctrlr0;
+    uint32_t spi_ctrlr0;
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, tmod, 8, data_frames - 1);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, 0);
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_CTRLR0);
+    ctrlr0 &= ~K230_SSI_CTRLR0_SPI_FRF_MASK;
+    ctrlr0 |= frf << K230_SSI_CTRLR0_SPI_FRF_SHIFT;
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_CTRLR0, ctrlr0);
+
+    spi_ctrlr0 = K230_SSI_SPI_CTRLR0_TRANS_TYPE(trans_type) |
+                 K230_SSI_SPI_CTRLR0_ADDR_L(24) |
+                 K230_SSI_SPI_CTRLR0_INST_L_8 |
+                 K230_SSI_SPI_CTRLR0_WAIT(wait_cycles);
+    if (mode_bits_enabled) {
+        spi_ctrlr0 |= K230_SSI_SPI_CTRLR0_XIP_MD_EN |
+                      K230_SSI_SPI_CTRLR0_XIP_MBL_8;
+    }
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPI_CTRLR0, spi_ctrlr0);
+}
+
+static void start_enhanced_transfer(QTestState *qts, uint8_t opcode,
+                                    uint32_t address)
+{
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SSIENR, 1);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, opcode);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, address);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, BIT(0));
+}
+
+static void read_enhanced_result(QTestState *qts, uint8_t *data, size_t len)
+{
+    k230_ssi_wait_mask(qts, K230_SPI0_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, len);
+    k230_ssi_wait_mask(qts, K230_SPI0_BASE, K230_SSI_SR,
+                       K230_SSI_SR_BUSY, 0);
+    for (size_t i = 0; i < len; i++) {
+        data[i] = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    }
+    k230_ssi_disable(qts, K230_SPI0_BASE);
+}
+
 static void test_register_contract(void)
 {
     QTestState *qts = k230_ssi_start();
@@ -390,6 +594,85 @@ static void test_qspi_config(void)
     qtest_quit(qts);
 }
 
+static void test_spi_nor(void)
+{
+    static const uint8_t expected[] = {
+        0xa5, 0x5a, 0x3c, 0xc3, 0x11, 0x22, 0x33, 0x44,
+    };
+    static const uint8_t payload[] = { 0xde, 0xad, 0xbe, 0xef };
+    K230SsiFlashImage image;
+    QTestState *qts = k230_ssi_start_with_flash(&image);
+    uint8_t command = FLASH_CMD_JEDEC;
+    uint8_t id[3];
+    uint8_t actual[ARRAY_SIZE(expected)];
+    uint8_t program[4 + ARRAY_SIZE(payload)];
+    uint32_t addr = K230_SSI_FLASH_PROGRAM_ADDR;
+
+    flash_read_transaction(qts, &command, 1, id, sizeof(id));
+    g_assert_cmphex(id[0], ==, 0xef);
+    g_assert_cmphex(id[1], ==, 0x40);
+    g_assert_cmphex(id[2], ==, 0x19);
+    flash_read(qts, FLASH_CMD_READ, K230_SSI_FLASH_PATTERN_ADDR,
+               3, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), expected, sizeof(expected));
+
+    flash_write_enable(qts);
+    program[0] = FLASH_CMD_PP;
+    program[1] = addr >> 16;
+    program[2] = addr >> 8;
+    program[3] = addr;
+    memcpy(program + 4, payload, sizeof(payload));
+    flash_write_transaction(qts, program, sizeof(program));
+    flash_wait_ready(qts);
+    flash_read(qts, FLASH_CMD_READ, addr, 3, actual, sizeof(payload));
+    g_assert_cmpmem(actual, sizeof(payload), payload, sizeof(payload));
+
+    qtest_quit(qts);
+    k230_ssi_flash_image_clear(&image);
+}
+
+static void test_qspi_sdr(void)
+{
+    static const uint8_t expected[] = { 0xa5, 0x5a, 0x3c, 0xc3 };
+    static const uint8_t payload[] = { 0x12, 0x34, 0x56, 0x78 };
+    K230SsiFlashImage image;
+    QTestState *qts = k230_ssi_start_with_flash(&image);
+    uint8_t actual[ARRAY_SIZE(expected)];
+
+    configure_enhanced_transfer(qts, K230_SSI_TMOD_RO,
+                                K230_SSI_FRF_QUAD, 0, 8, false,
+                                ARRAY_SIZE(actual));
+    start_enhanced_transfer(qts, FLASH_CMD_QUAD_OUT,
+                            K230_SSI_FLASH_PATTERN_ADDR);
+    read_enhanced_result(qts, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), expected, sizeof(expected));
+
+    flash_write_enable(qts);
+    configure_enhanced_transfer(qts, K230_SSI_TMOD_TO,
+                                K230_SSI_FRF_QUAD, 0, 0, false,
+                                ARRAY_SIZE(payload));
+    start_enhanced_transfer(qts, FLASH_CMD_QUAD_PP,
+                            K230_SSI_FLASH_PROGRAM_ADDR);
+    for (int i = 0; i < ARRAY_SIZE(payload); i++) {
+        k230_ssi_write_frame(qts, K230_SPI0_BASE, payload[i]);
+    }
+    k230_ssi_wait_mask(qts, K230_SPI0_BASE, K230_SSI_SR,
+                       K230_SSI_SR_BUSY, 0);
+    k230_ssi_disable(qts, K230_SPI0_BASE);
+    flash_wait_ready(qts);
+
+    configure_enhanced_transfer(qts, K230_SSI_TMOD_RO,
+                                K230_SSI_FRF_QUAD, 0, 8, false,
+                                ARRAY_SIZE(actual));
+    start_enhanced_transfer(qts, FLASH_CMD_QUAD_OUT,
+                            K230_SSI_FLASH_PROGRAM_ADDR);
+    read_enhanced_result(qts, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(payload), payload, sizeof(payload));
+
+    qtest_quit(qts);
+    k230_ssi_flash_image_clear(&image);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -400,5 +683,7 @@ int main(int argc, char **argv)
                    test_interrupt_controller);
     qtest_add_func("/k230-dw-ssi/plic-routing", test_plic_routing);
     qtest_add_func("/k230-dw-ssi/qspi-config", test_qspi_config);
+    qtest_add_func("/k230-dw-ssi/spi-nor", test_spi_nor);
+    qtest_add_func("/k230-dw-ssi/qspi-sdr", test_qspi_sdr);
     return g_test_run();
 }
-- 
2.43.0


