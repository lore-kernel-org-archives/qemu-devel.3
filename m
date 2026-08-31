Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37938C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0zwj-0001ro-5m; Mon, 31 Aug 2026 07:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1x0zwh-0001qu-34
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:12:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1x0zwe-0003Ez-QH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:12:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso4386490b3a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788174775; x=1788779575; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Z+X/PncSkuE6MgGSZCE8eysDDYP/aNPOAR017HvVGw=;
 b=ZVZ7a3n96UjU1lxMCmTIoe2aFXkU+b3luRFUqzvgZq8v7bp/nTFAzfr3IPvGc/VHDU
 zzDcIxjoFZoFmoNbOHjcYIy97U1fNXFPFoCCuTvwVIABoCjhoguRYL/q+0Jfx9g5AK/1
 8yqkUFVQUoW/JbHN3nlb+ECqqX3Bt2vDmSmN34NjiadYrKl4zgVrRt4xQMWGye/Yzyvh
 OqPQduZbXHg7UucbsWk9Bp8lZmzOCX8rzA+WCZ+s15eDfLInge34VIRl7lSlVqUc3Rye
 DBQVs/FHzwDT0hum3dwSJRT7UuBJ8zZfY2D2qypRYxTJtxbdjU/tPn+R9qgWKlgFe46S
 wpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788174775; x=1788779575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Z+X/PncSkuE6MgGSZCE8eysDDYP/aNPOAR017HvVGw=;
 b=cCwaeqgZzkbl8lAwJBfDoKxHPnZXMskrEZUl2UbTwAW7lst63loEsWIEiCLnTr20/p
 odJJiio2pHZTZB0JMdxFcnPRNdB80kFJCp9dme8NW7tsmN9VLda5JqEkSkfz+AbaWgHP
 qMs9VXPmwhsk6cKnRjjyz44t3ehc+bbkKlPAh8DEGcG0Zkjqz2qc7YKrU/gzWyxka7Xb
 ngR8prJVOyXbhDwrKFoPrbyn6/1Nt2vJ7szGg84tRi01s8lFj4iWi3SGf+lnXJiRZg38
 mjIH4LAkwl6ZOLCwshrf0vZJGEkGcXOLyQi5ZNHf+oihI21UMt1D7OUnW/t7WAGLzM2a
 ZlKw==
X-Gm-Message-State: AFuF++nrqQjl7ydWqKmqI6gSilggHIiyFf0do33DPTQSqmy6IlZt+w71
 1DWa7oe2isA50P3R8lkB7ewoXNd6xZBrUSaV8G1I2YBOLmN8yroxCsN0
X-Gm-Gg: AR+sD10by1klFnirC1rHIokJrNVc0UUwaSFfR+LkgixLXETG95KpQFQikJ00QuEAdaF
 NzNwFeEKobd5QMGsK6ly/1dvfXBpJPdOh/GEdxUQCHGQ+YFMK62SfF2BQGO3TYmAKC5OquupPd4
 D12Iy/mRad6e3fbpQKlJOlz2af/jYrlCWHp5v3zTNVAjLXc50iNrdtI9Y3w1d2wwnJw6Iph52rx
 qVh4ri+Arrhc4t+/zIiDAnzHCD1J83N3ruaFeTO4r82Pp9U5waIC/DMZRC2xv26zhAGqD7Ze3EC
 fNiojRvI0vkni1dTZVFAw5NtrMtWA2M7/o9u89vSbC+UaGzO9rURk4piZ/Wmh5uvw20cBbNfS9u
 Xi54TzbD+EgmNtiTdHKO3BwtWabG5flt7ihCvt8Tfd2z8lVWIuPVZQCRalLJU3NGep4yVDxMtCW
 FIav5U4wUyoxLOd/Xt8HS98oWoaVJhNp9hsxxSeS4VelEQRGg/gLvhyF5QYcNGNJO7BtbdPd/vn
 ihVD3XmUYrgs3jyY6QAHXQ8kFC0WGK5hhcA
X-Received: by 2002:a05:6a00:ab0a:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-85629f09863mr42946001b3a.10.1788174775164; 
 Mon, 31 Aug 2026 04:12:55 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8900:7ad7:8121:d841:db7e:846b:ea5e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-856a397d927sm3367329b3a.54.2026.08.31.04.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 04:12:54 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Mon, 31 Aug 2026 19:11:14 +0800
Subject: [PATCH v4 3/3] hw/riscv/k230: Attach a standard SPI NOR flash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-t_v4_spi_patch-v4-3-370d416f26b5@gmail.com>
References: <20260831-t_v4_spi_patch-v4-0-370d416f26b5@gmail.com>
In-Reply-To: <20260831-t_v4_spi_patch-v4-0-370d416f26b5@gmail.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add an optional `spi-flash` machine property and attach the selected
M25P80-compatible flash device to logical spi0 CS0.

Add qtests covering the Standard 1-1-1 JEDEC ID read, a read at a fixed
address, and an EEPROM read with a multi-byte command and a non-zero
address.

Standard 1-1-1 transfers against the attached flash were also manually
verified through the U-Boot and Linux SPI paths of the K230 SDK.

Enhanced SPI, IDMA and XIP paths are out of scope for this series.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst      |  1 +
 hw/riscv/Kconfig                |  1 +
 hw/riscv/k230.c                 | 66 ++++++++++++++++++++++++++++++++
 include/hw/riscv/k230.h         |  2 +
 tests/qtest/k230-dwc-ssi-test.c | 83 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index a7f7a494cd..7113e79ab1 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -24,6 +24,7 @@ The ``k230`` machine supports the following devices:
 * System Direct Memory Access (SDMA)
 * GZIP Decompress Engine (Decomp_gzip)
 * 3 DWC SSI controllers (Standard SPI mode)
+* Optional SPI NOR flash on spi0 CS0
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index f348da6d20..1fbf1e0722 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -165,3 +165,4 @@ config K230
     select K230_GSDMA
     select K230_DECOMP_GZIP
     select DWC_SSI
+    select SSI_M25P80
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index eb40b53ba8..abd1cc508c 100644
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
@@ -577,6 +580,49 @@ static void k230_firmware_boot(K230MachineState *s, MachineState *machine)
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
+static void k230_connect_spi_flash(DwcSsiState *ssi, unsigned int cs,
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
@@ -608,6 +654,12 @@ static void k230_machine_init(MachineState *machine)
                             TYPE_RISCV_K230_SOC);
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
+    if (s->spi_flash_model) {
+        k230_connect_spi_flash(&s->soc.dwc_ssi[2], 0,
+                               s->spi_flash_model,
+                               drive_get(IF_MTD, 0, 0));
+    }
+
     /* Data Memory */
     memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
                                 machine->ram);
@@ -620,6 +672,13 @@ static void k230_machine_instance_init(Object *obj)
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
@@ -629,6 +688,12 @@ static void k230_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -636,6 +701,7 @@ static const TypeInfo k230_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
+    .instance_finalize = k230_machine_instance_finalize,
     .instance_size = sizeof(K230MachineState),
     .interfaces = riscv64_machine_interfaces,
 };
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index fdabf454be..9b581ff3e0 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -59,6 +59,8 @@ typedef struct K230MachineState {
     /*< public >*/
     K230SoCState soc;
     Notifier machine_done;
+
+    char *spi_flash_model;
 } K230MachineState;
 
 enum {
diff --git a/tests/qtest/k230-dwc-ssi-test.c b/tests/qtest/k230-dwc-ssi-test.c
index 42e3190cb4..a0ec580679 100644
--- a/tests/qtest/k230-dwc-ssi-test.c
+++ b/tests/qtest/k230-dwc-ssi-test.c
@@ -80,6 +80,7 @@
 #define K230_SSI_XIP_MODE_BITS          0x0fc
 
 #define K230_SSI_FIFO_DEPTH             256
+#define K230_SSI_FLASH_SIZE              MiB
 
 typedef struct K230SsiInstance {
     uint64_t base;
@@ -593,7 +594,87 @@ static void test_icr_total_clear(void)
     qtest_quit(qts);
 }
 
+static void test_flash_jedec_id(void)
+{
+    QTestState *qts = qtest_init("-machine k230,spi-flash=m25p80");
+    uint32_t id;
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_enable_cs(qts, K230_SPI0_BASE, BIT(0));
+
+    /* JEDEC RDID (0x9f): m25p80 reports 0x20 0x20 0x14. */
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x9f);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    id = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(id & 0xff, ==, 0x20);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    id = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(id & 0xff, ==, 0x20);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    id = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(id & 0xff, ==, 0x14);
+
+    qtest_quit(qts);
+}
+
+static void test_flash_fixed_read(void)
+{
+    QTestState *qts = qtest_init("-machine k230,spi-flash=m25p80");
+    g_autofree uint8_t *image = g_malloc(K230_SSI_FLASH_SIZE);
+    g_autofree char *flash_path = NULL;
+    uint32_t byte;
+    int fd;
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_enable_cs(qts, K230_SPI0_BASE, BIT(0));
+
+    /* Standard 1-1-1 READ (0x03) at address 0x000000. */
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x03);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+
+    /* Without a backend the flash is erased and reads back 0xff. */
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    byte = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(byte & 0xff, ==, 0xff);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    byte = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(byte & 0xff, ==, 0xff);
+
+    qtest_quit(qts);
 
+    memset(image, 0xff, K230_SSI_FLASH_SIZE);
+    image[0x123] = 0x5a;
+    image[0x124] = 0xc3;
+    fd = g_file_open_tmp("qtest-k230-ssi-XXXXXX", &flash_path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+    close(fd);
+    g_assert_true(g_file_set_contents(flash_path, (char *)image,
+                                      K230_SSI_FLASH_SIZE, NULL));
+
+    qts = qtest_initf("-machine k230,spi-flash=m25p80 "
+                      "-drive file=%s,format=raw,if=mtd", flash_path);
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_EEPROM_READ,
+                       8, 1);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SSIENR, 1);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x03);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x01);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x23);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, BIT(0));
+    k230_ssi_wait_mask(qts, K230_SPI0_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, 2);
+    g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI0_BASE), ==, 0x5a);
+    g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI0_BASE), ==, 0xc3);
+    qtest_quit(qts);
+    g_assert_cmpint(g_unlink(flash_path), ==, 0);
+}
 
 static void test_unsupported_registers(void)
 {
@@ -633,5 +714,7 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dwc-ssi/icr-total-clear", test_icr_total_clear);
     qtest_add_func("/k230-dwc-ssi/unsupported-registers",
                    test_unsupported_registers);
+    qtest_add_func("/k230-dwc-ssi/flash-jedec-id", test_flash_jedec_id);
+    qtest_add_func("/k230-dwc-ssi/flash-fixed-read", test_flash_fixed_read);
     return g_test_run();
 }

-- 
2.43.0


