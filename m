Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFD4C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXH-0006as-9x; Tue, 10 Jun 2025 08:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXC-0006Zd-9b
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyX9-0002Zs-MO
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so34147035e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560213; x=1750165013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8bs9uu+7kLf40D2babTGQO+kwfnbkrmCW8mE247ZCQ=;
 b=wcWvOv96w6eeSol8Z91fipI//S2r1YDZWGJ0ZPFSbkTZ2jNIoYG2SNCyLhd1klqp4t
 9jQ0MA8g85A2TLbwM7JcWZf4PEJr3iyvxDtf+Zz+5uYJOx4ZH5DSVYNdo4jukrBh4D2R
 tn5IHVD0F4Xp9II4OWPs0oJ9kUtrdXrqEXeWrlx9ZRdvQLcgw22Z6lhN2QJRgleaoKLQ
 au7cAQaD2jK1NmIl6l17OM2rbWqjWZNye2TZ0SFTpBEdHs9JsYyizcsL/68aseO6AFlH
 pZ2Xmy0eABnBgpDbMrasbDf0wHdH3iIJmy6yxoIauCkJuoH81vv8fzVsbw+WdrH63pRb
 VLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560213; x=1750165013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8bs9uu+7kLf40D2babTGQO+kwfnbkrmCW8mE247ZCQ=;
 b=sxC+4IsPgZ1bJFIkdMnSxYtPU9lvkZb/mY1T4Av5Wd4fyqU1XJ/zhhO2gVi4S3aCN2
 g1RkNa0hZOvXoYoxQo4Tump9IhiJnZua48olKg1J62ZjH17UnSt0+isHajX1TIyV04RN
 AcClAsqeRI+M8gDR2scE3ZSCgItIybsXbKzpSTnB/1/bchBcF7A+AOUYT7zsbs3/Wxky
 pXUMbA1Cr5Cyx9bstItEMCW/qZoDQRcI3ilJizXeZnPA6khKqdzZw/6rugOj5hhm/JDu
 fwYNiqEJxHBurJ60y/7IKIGRsY1OdMrA0E4DDTnX5HFZcLzaBiDY7Pir+cB3XqRe6zLZ
 axew==
X-Gm-Message-State: AOJu0YxkVyYT68sOjODeZSmYooYluce5gY72zUcGdLvsVA74m4FII/8u
 cBEfj05A4h7NmQdoGmNAbnAN63oy5+zBREf/LKN2jeisFwIAp+YMhOrrGC+LGGSIhYpF+d+tq4f
 wu2IkjaE=
X-Gm-Gg: ASbGncvdkVm8YHgmlxJkY3aZp4kXUyAyrnP+vUznDgFThRCvFpht8geNa2Vgl8FkRyz
 D0ZztPcu5dAFctRzXMLoyyjT6CFIVafUB7j0gMRN4czhJKcwMLn23clBwZhiqHRBahKLIpmm1kx
 NChF7NV/z97ZVfciCPQ6bjv5Fc+AIYklU9rEXNCBpBS1O0KjdwekygJe35c5iJp2EU6Mvc04OL0
 5Qtp0gbzDVzPPp2iMSlMOuh6j5UIjOagS5qey9fAMPlDI6Ix67l+AxNqYSIxkjbqyFmRCLXhAWc
 GX6iOyfnugj1hVIMIfnSl5rt083oKSDXTlmGpo2CNoNXwcWpX4mSWOKr+NGdoMTO3Q5pWbfnFfF
 ZlJlDsWCnH4na/YvKEcahBIMXQyjQ3CyLVTVLUT7vpQ==
X-Google-Smtp-Source: AGHT+IHEyPBsJHjdzR/YjnQ34pr6B4VvJU65Fg9zAyIC4Zw8TW0DPg5DjZQ3/NfZhtGrRpVapMds8g==
X-Received: by 2002:a05:600c:58d8:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-4520151f219mr101712615e9.26.1749560213375; 
 Tue, 10 Jun 2025 05:56:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532462d93sm12494764f8f.91.2025.06.10.05.56.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:56:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/24] hw/pci-host/raven: Revert "raven: Move BIOS loading from
 board code to PCI host"
Date: Tue, 10 Jun 2025 14:56:13 +0200
Message-ID: <20250610125633.24411-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This reverts commit d0b25425749d5525b2ba6d9d966d8800a5643b35.

Loading firmware from the PCI host is unusual and raven is only used
by one board so this does not simplify anything but rather complicates
it. Revert to loading firmware from board code as that is the usual
way and also because raven has nothing to do with ROM so it is not a
good place for this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <4ca4f71bf661923d9a91b7e6776a0e40726e2337.1746374076.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 55 ---------------------------------------------
 hw/ppc/prep.c       | 27 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 57 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index b78a8f32d32..f8c0be5d21c 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
@@ -35,9 +34,7 @@
 #include "migration/vmstate.h"
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
-#include "hw/loader.h"
 #include "hw/or-irq.h"
-#include "elf.h"
 #include "qom/object.h"
 
 #define TYPE_RAVEN_PCI_DEVICE "raven"
@@ -47,10 +44,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
 
 struct RavenPCIState {
     PCIDevice dev;
-
-    uint32_t elf_machine;
-    char *bios_name;
-    MemoryRegion bios;
 };
 
 typedef struct PRePPCIState PREPPCIState;
@@ -77,8 +70,6 @@ struct PRePPCIState {
     int contiguous_map;
 };
 
-#define BIOS_SIZE (1 * MiB)
-
 #define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
 
 static inline uint32_t raven_pci_io_config(hwaddr addr)
@@ -333,48 +324,9 @@ static void raven_pcihost_initfn(Object *obj)
 
 static void raven_realize(PCIDevice *d, Error **errp)
 {
-    RavenPCIState *s = RAVEN_PCI_DEVICE(d);
-    char *filename;
-    int bios_size = -1;
-
     d->config[PCI_CACHE_LINE_SIZE] = 0x08;
     d->config[PCI_LATENCY_TIMER] = 0x10;
     d->config[PCI_CAPABILITY_LIST] = 0x00;
-
-    if (!memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios",
-                                          BIOS_SIZE, errp)) {
-        return;
-    }
-    memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
-                                &s->bios);
-    if (s->bios_name) {
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bios_name);
-        if (filename) {
-            if (s->elf_machine != EM_NONE) {
-                bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
-                                     NULL, NULL, NULL,
-                                     ELFDATA2MSB, s->elf_machine, 0, 0);
-            }
-            if (bios_size < 0) {
-                bios_size = get_image_size(filename);
-                if (bios_size > 0 && bios_size <= BIOS_SIZE) {
-                    hwaddr bios_addr;
-                    bios_size = (bios_size + 0xfff) & ~0xfff;
-                    bios_addr = (uint32_t)(-BIOS_SIZE);
-                    bios_size = load_image_targphys(filename, bios_addr,
-                                                    bios_size);
-                }
-            }
-        }
-        g_free(filename);
-        if (bios_size < 0 || bios_size > BIOS_SIZE) {
-            memory_region_del_subregion(get_system_memory(), &s->bios);
-            error_setg(errp, "Could not load bios image '%s'", s->bios_name);
-            return;
-        }
-    }
-
-    vmstate_register_ram_global(&s->bios);
 }
 
 static const VMStateDescription vmstate_raven = {
@@ -417,19 +369,12 @@ static const TypeInfo raven_info = {
     },
 };
 
-static const Property raven_pcihost_properties[] = {
-    DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
-                       EM_NONE),
-    DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
-};
-
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->realize = raven_pcihost_realizefn;
-    device_class_set_props(dc, raven_pcihost_properties);
     dc->fw_name = "pci";
 }
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 739526335ca..982e40e53e1 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -35,6 +35,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/datadir.h"
 #include "hw/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
@@ -55,6 +56,8 @@
 #define KERNEL_LOAD_ADDR 0x01000000
 #define INITRD_LOAD_ADDR 0x01800000
 
+#define BIOS_ADDR         0xfff00000
+#define BIOS_SIZE         (1 * MiB)
 #define NVRAM_SIZE        0x2000
 
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
@@ -241,6 +244,9 @@ static void ibm_40p_init(MachineState *machine)
     ISADevice *isa_dev;
     ISABus *isa_bus;
     void *fw_cfg;
+    MemoryRegion *bios = g_new(MemoryRegion, 1);
+    char *filename;
+    ssize_t bios_size = -1;
     uint32_t kernel_base = 0, initrd_base = 0;
     long kernel_size = 0, initrd_size = 0;
     char boot_device;
@@ -263,10 +269,27 @@ static void ibm_40p_init(MachineState *machine)
     cpu_ppc_tb_init(env, 100UL * 1000UL * 1000UL);
     qemu_register_reset(ppc_prep_reset, cpu);
 
+    /* allocate and load firmware */
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_report("Could not find bios image '%s'", bios_name);
+        exit(1);
+    }
+    memory_region_init_rom(bios, NULL, "bios", BIOS_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), BIOS_ADDR, bios);
+    bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+                         ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
+    if (bios_size < 0) {
+        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE);
+    }
+    if (bios_size < 0 || bios_size > BIOS_SIZE) {
+        error_report("Could not load bios image '%s'", filename);
+        return;
+    }
+    g_free(filename);
+
     /* PCI host */
     dev = qdev_new("raven-pcihost");
-    qdev_prop_set_string(dev, "bios-name", bios_name);
-    qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
     pcihost = SYS_BUS_DEVICE(dev);
     object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
     sysbus_realize_and_unref(pcihost, &error_fatal);
-- 
2.49.0


