Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDB0C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp6Y-0003l4-L9; Wed, 19 Feb 2025 13:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Gie2ZwgKCoU53qjx21qpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--wuhaotsh.bounces.google.com>)
 id 1tkp6E-00039C-CN
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:47:13 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Gie2ZwgKCoU53qjx21qpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--wuhaotsh.bounces.google.com>)
 id 1tkp66-0004pq-4G
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:47:05 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-220d8aa893dso526255ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990811; x=1740595611; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=M0Okg1E1VKh2zDVBD2EeLDVaF3WBxFI/Lxfymlmdrcw=;
 b=4kjhJK+1/JYvHe951GxSL1zHVEzlAIBDN6xTG+B+NEeUUe14u6zJuiBxiXpo7MhdIL
 UELSR4nTSC/UPXFhpr6mSxxmbq8UviVRuYZBF5yrgAbxlk2Ht/aTZ3HVFpCVNn1WmlbG
 R7pFld6Pp5/xyevohKbsDWvSlOjI2CsEneuTOSJWOkls8NsgunNPvelC65PA6GkBmuug
 BeZuloqHGe+FDRwu3YOfrzVqR43dLAYmpDD4lKTul1g17tys5dMDeiB0LQH2c793EBt3
 49hIAQ+yiAMFy5R4vTuGrPomdY80aJK+wjzd1GofYXDp+2oPzRyVeMyDQmBiwTZwmwgD
 v47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990811; x=1740595611;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0Okg1E1VKh2zDVBD2EeLDVaF3WBxFI/Lxfymlmdrcw=;
 b=biBA5ESLfR+s5C8jqQA1e6jiDYbbTfWPCvVsknlMbUkgjNjLRqdxmVoxiDJM+z6fPr
 J/gvyYNx4oNxCDqKVj02EpUHE/E9MVy710+qWRtWtPSHiB4R31lIqnzLZHi9yflPJodG
 sd+yKpMQyS7OHCDMhVHJdZPzIxyRvXFRL8c9qoG4wI3tNRRzZ+d8T9koLzaJ8+f9R7eN
 5J5H67nltTREibXp9TKpk+xwCNQacUzvM6ltEQ6b2VAdc0DUYD29A4TayAgSR6ds8u2I
 sNm5XqY8bi7ErxrXMv/ZesaNrMitxpSKE7Li3TV517WBuJhHNcMiePycQRLlUEayu0Ks
 2LPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIf4LzJ4gWH1bK/UcW3oZI5ekaptg2dtKImC/nRyQ5/DzkApSdR6Yd0Mteyo8NcsNgeYRgtAZOw2YF@nongnu.org
X-Gm-Message-State: AOJu0Yxg8N+pXt452dndHZouCjraHUfzvIzyyvMebwfyS3L1otRv0Hpm
 mYy0tCHafcTeBbCJE29kpXxmH3lZuqtkVnCAUHkvc0HJkm+5jDCJQ8m3njuQC3G0usnniIacO/h
 hTI0rt68Ujw==
X-Google-Smtp-Source: AGHT+IGznmffYg8rNJl8KKxnMFs27GvY17AqRmV2aW1FTB4sm84bHwm1QfhjUkAJnjFuy8XzbxApu8c1qCyNbQ==
X-Received: from pfbcw22.prod.google.com
 ([2002:a05:6a00:4516:b0:731:9461:420e])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e28:b0:732:5a8f:f51b with SMTP id
 d2e1a72fcca58-7326179ebd4mr34318408b3a.8.1739990810991; 
 Wed, 19 Feb 2025 10:46:50 -0800 (PST)
Date: Wed, 19 Feb 2025 10:46:07 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-17-wuhaotsh@google.com>
Subject: [PATCH v5 16/17] hw/arm: Add NPCM845 Evaluation board
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3Gie2ZwgKCoU53qjx21qpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/arm/meson.build       |   2 +-
 hw/arm/npcm8xx_boards.c  | 253 +++++++++++++++++++++++++++++++++++++++
 include/hw/arm/npcm8xx.h |  21 ++++
 3 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/npcm8xx_boards.c

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d7813c089c..465c757f97 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -12,7 +12,7 @@ arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
 arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
-arm_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c'))
+arm_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
 arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
new file mode 100644
index 0000000000..19610483f9
--- /dev/null
+++ b/hw/arm/npcm8xx_boards.c
@@ -0,0 +1,253 @@
+/*
+ * Machine definitions for boards featuring an NPCM8xx SoC.
+ *
+ * Copyright 2021 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "chardev/char.h"
+#include "hw/arm/npcm8xx.h"
+#include "hw/core/cpu.h"
+#include "hw/loader.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/datadir.h"
+#include "qemu/units.h"
+
+#define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff
+
+static const char npcm8xx_default_bootrom[] = "npcm8xx_bootrom.bin";
+
+static void npcm8xx_load_bootrom(MachineState *machine, NPCM8xxState *soc)
+{
+    const char *bios_name = machine->firmware ?: npcm8xx_default_bootrom;
+    g_autofree char *filename = NULL;
+    int ret;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_report("Could not find ROM image '%s'", bios_name);
+        if (!machine->kernel_filename) {
+            /* We can't boot without a bootrom or a kernel image. */
+            exit(1);
+        }
+        return;
+    }
+    ret = load_image_mr(filename, machine->ram);
+    if (ret < 0) {
+        error_report("Failed to load ROM image '%s'", filename);
+        exit(1);
+    }
+}
+
+static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
+                                  const char *flash_type, DriveInfo *dinfo)
+{
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash = qdev_new(flash_type);
+    if (dinfo) {
+        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
+
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
+}
+
+static void npcm8xx_connect_dram(NPCM8xxState *soc, MemoryRegion *dram)
+{
+    memory_region_add_subregion(get_system_memory(), NPCM8XX_DRAM_BA, dram);
+
+    object_property_set_link(OBJECT(soc), "dram-mr", OBJECT(dram),
+                             &error_abort);
+}
+
+static NPCM8xxState *npcm8xx_create_soc(MachineState *machine,
+                                        uint32_t hw_straps)
+{
+    NPCM8xxMachineClass *nmc = NPCM8XX_MACHINE_GET_CLASS(machine);
+    Object *obj;
+
+    obj = object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
+                                &error_abort, NULL);
+    object_property_set_uint(obj, "power-on-straps", hw_straps, &error_abort);
+
+    return NPCM8XX(obj);
+}
+
+static I2CBus *npcm8xx_i2c_get_bus(NPCM8xxState *soc, uint32_t num)
+{
+    g_assert(num < ARRAY_SIZE(soc->smbus));
+    return I2C_BUS(qdev_get_child_bus(DEVICE(&soc->smbus[num]), "i2c-bus"));
+}
+
+static void npcm8xx_init_pwm_splitter(NPCM8xxMachine *machine,
+                                      NPCM8xxState *soc, const int *fan_counts)
+{
+    SplitIRQ *splitters = machine->fan_splitter;
+
+    /*
+     * PWM 0~3 belong to module 0 output 0~3.
+     * PWM 4~7 belong to module 1 output 0~3.
+     */
+    for (int i = 0; i < NPCM8XX_NR_PWM_MODULES; ++i) {
+        for (int j = 0; j < NPCM7XX_PWM_PER_MODULE; ++j) {
+            int splitter_no = i * NPCM7XX_PWM_PER_MODULE + j;
+            DeviceState *splitter;
+
+            if (fan_counts[splitter_no] < 1) {
+                continue;
+            }
+            object_initialize_child(OBJECT(machine), "fan-splitter[*]",
+                                    &splitters[splitter_no], TYPE_SPLIT_IRQ);
+            splitter = DEVICE(&splitters[splitter_no]);
+            qdev_prop_set_uint16(splitter, "num-lines",
+                                 fan_counts[splitter_no]);
+            qdev_realize(splitter, NULL, &error_abort);
+            qdev_connect_gpio_out_named(DEVICE(&soc->pwm[i]), "duty-gpio-out",
+                                        j, qdev_get_gpio_in(splitter, 0));
+        }
+    }
+}
+
+static void npcm8xx_connect_pwm_fan(NPCM8xxState *soc, SplitIRQ *splitter,
+                                    int fan_no, int output_no)
+{
+    DeviceState *fan;
+    int fan_input;
+    qemu_irq fan_duty_gpio;
+
+    g_assert(fan_no >= 0 && fan_no <= NPCM7XX_MFT_MAX_FAN_INPUT);
+    /*
+     * Fan 0~1 belong to module 0 input 0~1.
+     * Fan 2~3 belong to module 1 input 0~1.
+     * ...
+     * Fan 14~15 belong to module 7 input 0~1.
+     * Fan 16~17 belong to module 0 input 2~3.
+     * Fan 18~19 belong to module 1 input 2~3.
+     */
+    if (fan_no < 16) {
+        fan = DEVICE(&soc->mft[fan_no / 2]);
+        fan_input = fan_no % 2;
+    } else {
+        fan = DEVICE(&soc->mft[(fan_no - 16) / 2]);
+        fan_input = fan_no % 2 + 2;
+    }
+
+    /* Connect the Fan to PWM module */
+    fan_duty_gpio = qdev_get_gpio_in_named(fan, "duty", fan_input);
+    qdev_connect_gpio_out(DEVICE(splitter), output_no, fan_duty_gpio);
+}
+
+static void npcm845_evb_i2c_init(NPCM8xxState *soc)
+{
+    /* tmp100 temperature sensor on SVB, tmp105 is compatible */
+    i2c_slave_create_simple(npcm8xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
+}
+
+static void npcm845_evb_fan_init(NPCM8xxMachine *machine, NPCM8xxState *soc)
+{
+    SplitIRQ *splitter = machine->fan_splitter;
+    static const int fan_counts[] = {2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0};
+
+    npcm8xx_init_pwm_splitter(machine, soc, fan_counts);
+    npcm8xx_connect_pwm_fan(soc, &splitter[0], 0x00, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[0], 0x01, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[1], 0x02, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[1], 0x03, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[2], 0x04, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[2], 0x05, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[3], 0x06, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[3], 0x07, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[4], 0x08, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[4], 0x09, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[5], 0x0a, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[5], 0x0b, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[6], 0x0c, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[6], 0x0d, 1);
+    npcm8xx_connect_pwm_fan(soc, &splitter[7], 0x0e, 0);
+    npcm8xx_connect_pwm_fan(soc, &splitter[7], 0x0f, 1);
+}
+
+static void npcm845_evb_init(MachineState *machine)
+{
+    NPCM8xxState *soc;
+
+    soc = npcm8xx_create_soc(machine, NPCM845_EVB_POWER_ON_STRAPS);
+    npcm8xx_connect_dram(soc, machine->ram);
+    qdev_realize(DEVICE(soc), NULL, &error_fatal);
+
+    npcm8xx_load_bootrom(machine, soc);
+    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
+    npcm845_evb_i2c_init(soc);
+    npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
+    npcm8xx_load_kernel(machine, soc);
+}
+
+static void npcm8xx_set_soc_type(NPCM8xxMachineClass *nmc, const char *type)
+{
+    NPCM8xxClass *sc = NPCM8XX_CLASS(object_class_by_name(type));
+    MachineClass *mc = MACHINE_CLASS(nmc);
+
+    nmc->soc_type = type;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus = sc->num_cpus;
+}
+
+static void npcm8xx_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
+
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_parallel = 1;
+    mc->default_ram_id = "ram";
+    mc->valid_cpu_types = valid_cpu_types;
+}
+
+static void npcm845_evb_machine_class_init(ObjectClass *oc, void *data)
+{
+    NPCM8xxMachineClass *nmc = NPCM8XX_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    npcm8xx_set_soc_type(nmc, TYPE_NPCM8XX);
+
+    mc->desc = "Nuvoton NPCM845 Evaluation Board (Cortex-A35)";
+    mc->init = npcm845_evb_init;
+    mc->default_ram_size = 1 * GiB;
+};
+
+static const TypeInfo npcm8xx_machine_types[] = {
+    {
+        .name           = TYPE_NPCM8XX_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(NPCM8xxMachine),
+        .class_size     = sizeof(NPCM8xxMachineClass),
+        .class_init     = npcm8xx_machine_class_init,
+        .abstract       = true,
+    }, {
+        .name           = MACHINE_TYPE_NAME("npcm845-evb"),
+        .parent         = TYPE_NPCM8XX_MACHINE,
+        .class_init     = npcm845_evb_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(npcm8xx_machine_types)
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index a32fbb035b..9812e6fa7e 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -51,6 +51,27 @@
 
 #define NPCM8XX_NR_PWM_MODULES 3
 
+struct NPCM8xxMachine {
+    MachineState        parent_obj;
+
+    /*
+     * PWM fan splitter. each splitter connects to one PWM output and
+     * multiple MFT inputs.
+     */
+    SplitIRQ            fan_splitter[NPCM8XX_NR_PWM_MODULES *
+                                     NPCM7XX_PWM_PER_MODULE];
+};
+
+
+struct NPCM8xxMachineClass {
+    MachineClass        parent_class;
+
+    const char          *soc_type;
+};
+
+#define TYPE_NPCM8XX_MACHINE MACHINE_TYPE_NAME("npcm8xx")
+OBJECT_DECLARE_TYPE(NPCM8xxMachine, NPCM8xxMachineClass, NPCM8XX_MACHINE)
+
 struct NPCM8xxState {
     DeviceState         parent_obj;
 
-- 
2.48.1.601.g30ceb7b040-goog


