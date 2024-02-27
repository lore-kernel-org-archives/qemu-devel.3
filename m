Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158F9C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexat-00012a-JD; Tue, 27 Feb 2024 08:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaW-0000nf-53
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:40 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaO-0002uX-Ni
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:39 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d26da3e15so2419590f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040811; x=1709645611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q35YcF1YF7GYvOT4t2N1QC44pCmMfpb9rbcmh1O9UAs=;
 b=Eoo8Gq/1RW6Fo3i7OVfQXC5Pdpx5RWa/IHTGcQ1itr88k3cYeXcq/Mn5mwiXoqFrfJ
 WsOD2+N54CaFyzdK/1V/yVLRtH4Z0lh8Vzh7jpT1g8FgqEDhcEbIGg3CHzTDoogxlk5R
 qyZF9S/tAoH5ovte91d4TMMy5qRQcmWzVjXiS16h/H7wkcSAdVha3tkmkBMSTOEksBTf
 Gf4GLfC3Giqf3PUtF45d4D2ImAzKDSjpzLEiSXZclvBHqrV/zhl/5Sq2/ZBj7SYINMEi
 12/DAOvC8jVvuTO++IIpRXzSAiL4ebbWCP0O7fIsz/N2RKZXfDu2BdCIh9eKlBIuSFhr
 QDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040811; x=1709645611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q35YcF1YF7GYvOT4t2N1QC44pCmMfpb9rbcmh1O9UAs=;
 b=Nfr94YEU33mhT3rbcW6cikpSZtbK30Ec3RMeCkVMawg0gSqn5182Jm+t4nSobq8I7M
 3W8KzQqs5BM86l4xgERiglaKeGoMedMj/mF769GxYT/9ezeJGsFoTYYc5MRaI1kOEXFc
 bA1VtgbIyhFTcZ/XD9aNw0+wVKUx0VTIkE/AkSdzppyHefzuGQX9UaPHlRBiYuX/FHK8
 iFIvA8IcJSiunPdTMj7hZPDWsiPeJMCocz1Po67VnKrZUya6n7vSGTn9hlFQwspj4k3b
 XKwoSrT8LzAC2kdq2jm+gWcNdGFfct5l6X1OfkdK7By+qRHsWCHgN2X25oSVmcuwv8Ts
 akDg==
X-Gm-Message-State: AOJu0YxMbqTxe1r6YhXWZnB07PI/C3zf8m3T+svCLW0TYnmEkZhGw3TS
 RQ29jbteAVeD4xzPZMGFIQ8FY3F5mTscRPTqaEEfTZtMKAQoHVY5XQzVtu38NqImd3u3UqHf4Xl
 E
X-Google-Smtp-Source: AGHT+IFPkbJClMAy6ZHbMW5IQCGgYJVrIz6CqTE+EVG3WWAzTV4MjNXK0piqNIXwtXnsh/7Qgretmg==
X-Received: by 2002:adf:ed0b:0:b0:33d:2872:2437 with SMTP id
 a11-20020adfed0b000000b0033d28722437mr8278795wro.31.1709040811392; 
 Tue, 27 Feb 2024 05:33:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/45] hw/arm: Introduce Raspberry PI 4 machine
Date: Tue, 27 Feb 2024 13:32:59 +0000
Message-Id: <20240227133314.1721857-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240226000259.2752893-11-sergey.kambalin@auriga.com
[PMM: Change name to 'raspi4b', not 'raspi4b-2g']
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/raspi_platform.h | 11 ++++++
 include/hw/display/bcm2835_fb.h |  2 +
 hw/arm/bcm2835_peripherals.c    | 17 ++++++--
 hw/arm/bcm2836.c                |  2 +
 hw/arm/bcm2838.c                |  2 +
 hw/arm/raspi.c                  | 27 ++++++++-----
 hw/arm/raspi4b.c                | 70 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |  2 +-
 8 files changed, 119 insertions(+), 14 deletions(-)
 create mode 100644 hw/arm/raspi4b.c

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 3018e8fcf3e..45003e24258 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -49,6 +49,17 @@ struct RaspiBaseMachineClass {
     uint32_t board_rev;
 };
 
+/* Common functions for raspberry pi machines */
+const char *board_soc_type(uint32_t board_rev);
+void raspi_machine_init(MachineState *machine);
+
+typedef struct BCM283XBaseState BCM283XBaseState;
+void raspi_base_machine_init(MachineState *machine,
+                             BCM283XBaseState *soc);
+
+void raspi_machine_class_common_init(MachineClass *mc,
+                                     uint32_t board_rev);
+
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
 #define INTE_OFFSET             0x2000   /* VC Interrupt controller */
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 38671afffd5..49541bf08f4 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -16,6 +16,8 @@
 #include "ui/console.h"
 #include "qom/object.h"
 
+#define UPPER_RAM_BASE 0x40000000
+
 #define TYPE_BCM2835_FB "bcm2835-fb"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835FBState, BCM2835_FB)
 
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index ed38a08a577..a0bbe76f264 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -108,6 +108,7 @@ static void raspi_peripherals_base_init(Object *obj)
     /* Framebuffer */
     object_initialize_child(obj, "fb", &s->fb, TYPE_BCM2835_FB);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->fb), "vcram-base");
 
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
@@ -229,7 +230,7 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     Object *obj;
     MemoryRegion *ram;
     Error *err = NULL;
-    uint64_t ram_size, vcram_size;
+    uint64_t ram_size, vcram_size, vcram_base;
     int n;
 
     obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
@@ -333,11 +334,21 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base",
-                                  ram_size - vcram_size, errp)) {
+    vcram_base = object_property_get_uint(OBJECT(s), "vcram-base", &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
 
+    if (vcram_base == 0) {
+        vcram_base = ram_size - vcram_size;
+    }
+    vcram_base = MIN(vcram_base, UPPER_RAM_BASE - vcram_size);
+
+    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base", vcram_base,
+                                  errp)) {
+        return;
+    }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), errp)) {
         return;
     }
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 7e4c60dd804..db191661f29 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -66,6 +66,8 @@ static void bcm283x_init(Object *obj)
                               "command-line");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
 }
 
 bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 332e906a84f..ddb7c5f757a 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -54,6 +54,8 @@ static void bcm2838_init(Object *obj)
                               "board-rev");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
     object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
                               "command-line");
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 7d04734cd23..8b1a046912c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
+#include "hw/arm/bcm2838.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
@@ -61,6 +62,7 @@ typedef enum RaspiProcessorId {
     PROCESSOR_ID_BCM2835 = 0,
     PROCESSOR_ID_BCM2836 = 1,
     PROCESSOR_ID_BCM2837 = 2,
+    PROCESSOR_ID_BCM2838 = 3,
 } RaspiProcessorId;
 
 static const struct {
@@ -70,13 +72,9 @@ static const struct {
     [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1},
     [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
+    [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
-static void raspi_base_machine_init(MachineState *machine,
-                             BCM283XBaseState *soc);
-static void raspi_machine_class_common_init(MachineClass *mc,
-                                     uint32_t board_rev);
-
 static uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -93,7 +91,7 @@ static RaspiProcessorId board_processor_id(uint32_t board_rev)
     return proc_id;
 }
 
-static const char *board_soc_type(uint32_t board_rev)
+const char *board_soc_type(uint32_t board_rev)
 {
     return soc_property[board_processor_id(board_rev)].type;
 }
@@ -248,13 +246,14 @@ static void setup_boot(MachineState *machine, ARMCPU *cpu,
     arm_load_kernel(cpu, machine, &s->binfo);
 }
 
-static void raspi_base_machine_init(MachineState *machine,
+void raspi_base_machine_init(MachineState *machine,
                              BCM283XBaseState *soc)
 {
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     uint32_t board_rev = mc->board_rev;
     uint64_t ram_size = board_ram_size(board_rev);
-    uint32_t vcram_size;
+    uint32_t vcram_base, vcram_size;
+    size_t boot_ram_size;
     DriveInfo *di;
     BlockBackend *blk;
     BusState *bus;
@@ -293,11 +292,19 @@ static void raspi_base_machine_init(MachineState *machine,
 
     vcram_size = object_property_get_uint(OBJECT(soc), "vcram-size",
                                           &error_abort);
+    vcram_base = object_property_get_uint(OBJECT(soc), "vcram-base",
+                                          &error_abort);
+
+    if (vcram_base == 0) {
+        vcram_base = ram_size - vcram_size;
+    }
+    boot_ram_size = MIN(vcram_base, UPPER_RAM_BASE - vcram_size);
+
     setup_boot(machine, &soc->cpu[0].core, board_processor_id(board_rev),
-               machine->ram_size - vcram_size);
+               boot_ram_size);
 }
 
-static void raspi_machine_init(MachineState *machine)
+void raspi_machine_init(MachineState *machine)
 {
     RaspiMachineState *s = RASPI_MACHINE(machine);
     RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
new file mode 100644
index 00000000000..f1e91f7c98f
--- /dev/null
+++ b/hw/arm/raspi4b.c
@@ -0,0 +1,70 @@
+/*
+ * Raspberry Pi 4B emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/display/bcm2835_fb.h"
+#include "hw/registerfields.h"
+#include "qemu/error-report.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/arm/boot.h"
+#include "qom/object.h"
+#include "hw/arm/bcm2838.h"
+
+#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
+OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
+
+struct Raspi4bMachineState {
+    RaspiBaseMachineState parent_obj;
+    BCM2838State soc;
+};
+
+static void raspi4b_machine_init(MachineState *machine)
+{
+    Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
+    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
+    BCM2838State *soc = &s->soc;
+
+    s_base->binfo.board_id = mc->board_rev;
+
+    object_initialize_child(OBJECT(machine), "soc", soc,
+                            board_soc_type(mc->board_rev));
+
+    raspi_base_machine_init(machine, &soc->parent_obj);
+}
+
+static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+    mc->init = raspi4b_machine_init;
+}
+
+static const TypeInfo raspi4b_machine_type = {
+    .name           = TYPE_RASPI4B_MACHINE,
+    .parent         = TYPE_RASPI_BASE_MACHINE,
+    .instance_size  = sizeof(Raspi4bMachineState),
+    .class_init     = raspi4b_machine_class_init,
+};
+
+static void raspi4b_machine_register_type(void)
+{
+    type_register_static(&raspi4b_machine_type);
+}
+
+type_init(raspi4b_machine_register_type)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 1390a9d7b51..6808135c1f7 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -30,7 +30,7 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
-- 
2.34.1


