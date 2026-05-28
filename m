Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD7CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjHd-0000Dv-LU; Thu, 28 May 2026 18:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wSi1b-0008VY-BD
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:12:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wSi1X-00055B-Lo
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:12:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so86806825e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780002734; x=1780607534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pd+UEfP8Fkx65KGHNLigoqyWnVI7rHhjzFMv0CnIYaw=;
 b=BrIztlZdGcUnahBn/Ey2/Hx+kHGjqLcaWnfLQDnIBt05tchHoGgwvr0a7/ZB+9sXOM
 m4yjO3jSokEkEN71knbs1McyGAWzdt3C+E5DDBkURKBFNLMdChPPXiPbmfRFIGUbiGRu
 V4nNjnyF3yMoo8uQyIvl2+QAm+YKVk1NqSIFa4tk9Oi3tMgs/8dIpGp4ET1uHZrOgsWo
 VhvMos65scTmMQZvcIefUpv4+c5/OHFTv5VupNi1YVFBKg+/eB5FGCyzoMDn4pMVIgN0
 Q9RiZOkWsrafIB2z9kTT/PNedW7XFr0MI/Xgj8pC33nCNcagk7n6RowMhFq8WpcW3uU6
 p2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780002734; x=1780607534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pd+UEfP8Fkx65KGHNLigoqyWnVI7rHhjzFMv0CnIYaw=;
 b=mvHzaP/HvdU5GwwrZgI+P+Sy920zTDjyACjcTIVFtRjcXWLhQO04EY4Bs1zGVQO8kj
 2lXK3uaMjYWzNVDa3H9yQ1q/LURxs4LAXhXEnKy9p/B6tc+vl1cXyRrIcvlGOqi8c8uH
 q+JiV0dUUwCWm3npgLX9bDhjEUEDTWzWYCb8FPMDGRGA46ZsEMp3cMT8fqzciFUOtUpn
 21cVk7BXqdYZEJKvRQ19mrUaFeqwmhkK/FOp1bg1MOi1gJYQ28N11myoEsbm0jp4vYvs
 iJt3gbpvjLCM1lj3DqNoPmMTwSKIoqcJPHX67RxI3zKCQPbp/r1KwSBP7HmRXSqjXSfF
 w6Ug==
X-Gm-Message-State: AOJu0YzByk6R6nV30MKOkJSwG2Z5qbBg/112KbcZdKhomOGiAQtbfZye
 fZamSn3lEnT+3hiD9DMbBKYi1QdmtLsLoENEY20xET8kCAB3UMiOrwI2Ry3Koqv9
X-Gm-Gg: Acq92OGwp21kXGbibZ9coaE8ZhR21cAAxqELIa/tbz4YKvc6lJ6FYFcrHZRvFLiUlCd
 uHCm/NRR8CAunuM3uet3+sDDWJIpNcR/jRGNPXp9EG7N4YnaVla21L070yKu1Rae6VLBLepjjG1
 ilYagoZKJfUVM0Ls4aE8nCXvLcmgS27XVncfVT4Q30pvOaCBoGyZNPaGf27T7D07YXDN0mCGRIV
 ABmGCnPXhJo/BKMStl1pYrdagkIyQdw+DTHv3aCDVg/UvHHsh8QZZHl9wN9Yg5Ox7mEfAjiWJ0n
 u51uqKaqelFLqEdJsz6Z+V0cdcrBK3n1eindpq+LPZiXSMBix5okJAMlMKdRE5VXLC/ZiRFh2XS
 Mf34gsJgN51xMBpJsU7Ni+7I4SpVIgvNMILlNpoSryflIs2RIYJhjh5sqVcfIZpRKitToj4AXeh
 wPlStQzgFONJAUTuA=
X-Received: by 2002:a05:600c:3504:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-4909c0b493bmr2242105e9.15.1780002733800; 
 Thu, 28 May 2026 14:12:13 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c609787sm108365e9.6.2026.05.28.14.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:12:13 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v0 2/2] hw/arm: Add AM64-virt machine
Date: Thu, 28 May 2026 23:12:10 +0200
Message-ID: <20260528211210.74266-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528211210.74266-1-wafgo01@gmail.com>
References: <20260528211210.74266-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=wafgo01@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 18:32:56 -0400
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

Add an "am64-virt" machine that instantiates the TI AM64x SoC model
and prepares it to boot a Linux kernel on the Cortex-A53 cluster.

The machine wires up DDR at 0x80000000 and uses the standard ARM PSCI
SMC conduit for SMP bring-up. It is intentionally minimal:

  - No built-in device tree; users supply one via -dtb.
  - No flash, no PCIe, no MCU/R5F cores.

The intent is to provide a starting point on top of which the full
AM64x platform (mailbox, secure proxy, DMSC/TISCI service, M4F core,
R5F cores, dynamic DT generation, ...) can be added in subsequent
patches.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/arm/Kconfig     |  7 ++++
 hw/arm/am64-virt.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build |  1 +
 3 files changed, 88 insertions(+)
 create mode 100644 hw/arm/am64-virt.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 96cb0f5185..e0884a806e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -631,6 +631,13 @@ config TI_AM64X
     select ARM_GIC
     select SERIAL_MM
 
+config AM64_VIRT
+    bool
+    default y
+    depends on AARCH64
+    depends on TCG
+    select TI_AM64X
+
 config ARM_SMMUV3
     bool
 
diff --git a/hw/arm/am64-virt.c b/hw/arm/am64-virt.c
new file mode 100644
index 0000000000..3018773045
--- /dev/null
+++ b/hw/arm/am64-virt.c
@@ -0,0 +1,80 @@
+/*
+ * TI K3 AM64-virt machine
+ *
+ * Copyright (c) 2026 CMBlu
+ * Written by Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/ti-am64x.h"
+#include "hw/boards.h"
+#include "qemu/error-report.h"
+#include "system/address-spaces.h"
+
+#define AM64_VIRT_DRAM_BASE 0x80000000ULL
+
+typedef struct AM64VirtMachineState {
+    MachineState parent_obj;
+    TIAM64xState soc;
+    struct arm_boot_info bootinfo;
+} AM64VirtMachineState;
+
+#define TYPE_AM64_VIRT_MACHINE MACHINE_TYPE_NAME("am64-virt")
+OBJECT_DECLARE_SIMPLE_TYPE(AM64VirtMachineState, AM64_VIRT_MACHINE)
+
+static void am64_virt_init(MachineState *machine)
+{
+    AM64VirtMachineState *ams = AM64_VIRT_MACHINE(machine);
+    MemoryRegion *sysmem = get_system_memory();
+
+    if (machine->ram_size > 2 * GiB) {
+        error_report("am64-virt: maximum supported RAM size is 2 GiB");
+        exit(1);
+    }
+
+    object_initialize_child(OBJECT(machine), "soc", &ams->soc, TYPE_TI_AM64X);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&ams->soc), &error_fatal);
+
+    memory_region_add_subregion(sysmem, AM64_VIRT_DRAM_BASE, machine->ram);
+
+    ams->bootinfo.ram_size = machine->ram_size;
+    ams->bootinfo.loader_start = AM64_VIRT_DRAM_BASE;
+    ams->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    ams->bootinfo.board_id = -1;
+    arm_load_kernel(&ams->soc.a53[0], machine, &ams->bootinfo);
+}
+
+static void am64_virt_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "TI K3 AM64x virt machine";
+    mc->init = am64_virt_init;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->default_ram_id = "am64-virt.ram";
+    mc->default_ram_size = 1 * GiB;
+    mc->default_cpus = TI_AM64X_NUM_A53_CPUS;
+    mc->max_cpus = TI_AM64X_NUM_A53_CPUS;
+    mc->min_cpus = 1;
+}
+
+static const TypeInfo am64_virt_machine_info = {
+    .name = TYPE_AM64_VIRT_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(AM64VirtMachineState),
+    .class_init = am64_virt_machine_class_init,
+    .interfaces = arm_aarch64_machine_interfaces,
+};
+
+static void am64_virt_machine_register_types(void)
+{
+    type_register_static(&am64_virt_machine_info);
+}
+
+type_init(am64_virt_machine_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 89fad790f5..faa00741c3 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -85,6 +85,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_common_ss.add(when: 'CONFIG_TI_AM64X', if_true: files('ti-am64x.c'))
+arm_common_ss.add(when: 'CONFIG_AM64_VIRT', if_true: files('am64-virt.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-- 
2.52.0


