Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C817C5AD44
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 18:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wslq8-0000fv-LV; Sat, 08 Aug 2026 14:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslq4-0000VJ-39
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:32:09 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslq0-0007hS-Di
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:32:07 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so558203a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786213923; x=1786818723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3WwhUV+c4Hz7g4wkB288txhSDzf0C0wY0jvSEyNIqvQ=;
 b=dda9sSkEXsjylNrqeW+CelGupQ29eq7n1ESKzjJUZj8Tr1p0GsdLWTNMdtsVPUQFSi
 ru7E+JUzxjmYtPAF51qTTNwezscR7/umPUk13UI9424DJgWiklPBgwjqXDZCS+wtVJf9
 xjFaZOkVW5ZJcUrfgCooNnvjy/OLW9YrTqMOnJknjujG+Pf7pWAwTFQFOjYSkGEX2f5z
 E08mz0Hk1d1XLPHJ8Po/AKZ8sPkJikEf7EADem48rlGCSp+wc0NmpIB/7oqyKZUrKdaH
 DkUysIaXLFXUnsySUpYfa1us/h9zhjf9n1rr8sAbjGxFK5s3vBb2fV8s6oJEKeqdTy7i
 PUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786213923; x=1786818723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3WwhUV+c4Hz7g4wkB288txhSDzf0C0wY0jvSEyNIqvQ=;
 b=HBe9YFt9DeFupifP2lmKoR8XiGvqMM42j0ACTc87ZvgxgmHLQlBdETPnd3mOs8wjW8
 C9sJR7QZjUTvxofewq2FytE1vZKhMvLJlvPraQeh2lkb+FKZLpXDHbyAVacy+bcktAV5
 eDDxsaPmne/0GdzMZgOMP5NpHH/ncFM8dORkGE/++y19JGUUBK6tJK5uVgOeaHpklnUy
 WOJGL4WGX9rqjn8oW6XOhZG0m0r9GC7nJpxu20yuCyLg8aI9qEoVu7CvFD+6myX2LZGP
 4oO9vPBCExkYDKW61hktiDzHUWY+y765lenz/mXGc8SFwSX1gNYioRWhwVH6YTJ5e8LX
 oLqw==
X-Gm-Message-State: AOJu0YwHtIImvX3INyQRUEHB8JlBAZZmrMSrsE32k6aUAtT+ADaReBMa
 gQIjJVKWO5jUFofLS3iiJgeNoH1BWcbCsJl/T5el0s4V6HrrolTjtNifHMynmWmj2ht2MA==
X-Gm-Gg: AR+sD11OUr2uIA0G3wnOf3TKG9OEQYGbLqOFDHIN0OkD1VWFYHvrWkbwlHJHBhiQYXj
 znks6q5+C18rK2GwMpSwPug5puhDicFs7pZFeaKVG3jtah1Ois3Yf1kD3RxVYVfyBashLg9zJSC
 8uypA8qGB+utnH4fzsfHoZwgw2S7uTqGzkZN3+PM0NgyblPnqEflR/JSnk9uhYlUCUP0VEPMNzf
 FodiAnWwkzF4RzDmgtB4jxbw3ZqEV/a5Eo89Ox16Mb0EuVR+3BhgL/YQHOgURjNSRldXpp4g0Iz
 JrmrhMaz/ae+xOCSqy8G476XNlrpv1rTAMFHqkeEYKYoMUHX9za8r3YCnsYzegsHLpgBaiRsLHl
 WM57VKuHxsCrF+3wWmcCUwVVOk6s2NxAnsmhTMQX/bwgN6mHskIBR9Fcquu9JpT7/dA7qogW9DO
 oix2MkFEhtnDwfB1cr5wOufPLG+CZ2Md9zcE+LF1Bem7yvZpB5vd75GsM27nbDatLCBmswjAzHi
 suliRWnGmM/WYDjVA==
X-Received: by 2002:a17:90b:2245:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-3903c538565mr26465139a91.1.1786213922806; 
 Sat, 08 Aug 2026 11:32:02 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8a00:6035:79d0:50fd:3a6e:508:beb2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6c13asm6772393a91.2.2026.08.08.11.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 11:32:02 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
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
Subject: [PATCH v3 5/5] hw/riscv/k230: Attach a standard SPI NOR flash
Date: Sun,  9 Aug 2026 02:29:56 +0800
Message-ID: <20260808182956.290561-6-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x102e.google.com
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
M25P80-compatible flash device to logical spi0 chip select 0.

Use the supplied MTD backend when present and retain the erased-flash
default otherwise. Document the machine option and add qtests for Standard
1-1-1 JEDEC identification and fixed-address reads.

Standard 1-1-1 transfers were also exercised manually through the K230
SDK U-Boot and Linux SPI paths against the attached flash.

The enhanced SPI and IDMA boot paths are outside the scope of this series.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst      |  1 +
 hw/riscv/Kconfig                |  1 +
 hw/riscv/k230.c                 | 66 +++++++++++++++++++++++++
 include/hw/riscv/k230.h         |  2 +
 tests/qtest/k230-dwc-ssi-test.c | 85 +++++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 7a49cac95b..620ef263de 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -21,6 +21,7 @@ The ``k230`` machine supports the following devices:
 * 2 K230 Watchdog Timer
 * 5 UART
 * 3 K230 SSI controllers for SPI only
+* Optional SPI NOR flash on spi0 CS0
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0bc0d18ca2..94bf786ddc 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -163,3 +163,4 @@ config K230
     select UNIMP
     select K230_WDT
     select DWC_SSI
+    select SSI_M25P80
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 4911f2d1be..c2c101758d 100644
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
@@ -541,6 +544,49 @@ static void k230_firmware_boot(K230MachineState *s, MachineState *machine)
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
@@ -572,6 +618,12 @@ static void k230_machine_init(MachineState *machine)
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
@@ -584,6 +636,13 @@ static void k230_machine_instance_init(Object *obj)
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
@@ -593,6 +652,12 @@ static void k230_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -600,6 +665,7 @@ static const TypeInfo k230_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
+    .instance_finalize = k230_machine_instance_finalize,
     .instance_size = sizeof(K230MachineState),
     .interfaces = riscv64_machine_interfaces,
 };
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 4eee78ddec..1fe5713e53 100644
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
diff --git a/tests/qtest/k230-dwc-ssi-test.c b/tests/qtest/k230-dwc-ssi-test.c
index a522fc4973..807f143987 100644
--- a/tests/qtest/k230-dwc-ssi-test.c
+++ b/tests/qtest/k230-dwc-ssi-test.c
@@ -78,6 +78,7 @@
 #define K230_SSI_XIP_MODE_BITS          0x0fc
 
 #define K230_SSI_FIFO_DEPTH             256
+#define K230_SSI_FLASH_SIZE              MiB
 
 typedef struct K230SsiInstance {
     uint64_t base;
@@ -577,6 +578,88 @@ static void test_icr_total_clear(void)
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
+
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
+
 static void test_unsupported_registers(void)
 {
     QTestState *qts = k230_ssi_start();
@@ -613,5 +696,7 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dwc-ssi/icr-total-clear", test_icr_total_clear);
     qtest_add_func("/k230-dwc-ssi/unsupported-registers",
                    test_unsupported_registers);
+    qtest_add_func("/k230-dwc-ssi/flash-jedec-id", test_flash_jedec_id);
+    qtest_add_func("/k230-dwc-ssi/flash-fixed-read", test_flash_fixed_read);
     return g_test_run();
 }
-- 
2.43.0


