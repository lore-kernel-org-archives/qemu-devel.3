Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405D6C5DF7F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww7f5-0002IX-Kk; Mon, 17 Aug 2026 20:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f4-0002Hw-Mm
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:38 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f1-0004HB-Ib
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:38 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4a46a53abc9so2277740b6e.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787012794; x=1787617594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YxQZJeHypYn2iOG/6U1270aJb0XpU7mcjD7Tcqt6wWE=;
 b=OddsuepTAuFG463Qly0tfmo/MAmVNZGhqC6Mad6B5tSnTHxSJtDNlczcl97qtyNQ15
 N1G4uPotbg/qjkrj6D06hyP+fcYuSeVKyGI6iPmKnrNIrLWv4sCEMebtTjTu+g+XHhs/
 u9WMmXJ5KCoHVI9TLwEByp9ncbZkvvrps39K6r63/TV6mxVG+dKrRfbAoUI8K7Oe2jf2
 4613Xpo81vFXeuVIqvZiXyeonYeciip14BkF6Jeq1sgAI9VEFI72I5W2K5DvEakw5nkC
 9VekPkyFtJ9kg9B/dQItEO0yZEkbKDnmCgJP8IauL8cAw3VYFuWkEcugoCDsFmK1Qy6u
 D6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012794; x=1787617594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YxQZJeHypYn2iOG/6U1270aJb0XpU7mcjD7Tcqt6wWE=;
 b=F3ea+XWu5N5BLNDB0xEmxYryITwuLTvoYrcGCMW4RmhE01fm4uVLRJ0S4BqjAFqbCT
 j8XfS+r+otESjJMET+ofEul2vbkhL1QsReET45LkQ00MZ0eLVzKKwsLZg0pxoanIOmpH
 JBE/K2p6DmliB6Cwt/p29CR3vU0cH9eV6HvoIcPowRT9UgHp5Up7yyAG+rqa5ZCYwWt+
 7EauEvxRwPx+fuWRg+2DJUGFExAoIGd0JObczFaBq4ydcLT58cxeg7x2cA4zPTGx5OsD
 5+x3HWbyXdMDrlcglu+QlkL0lYZOy1OsugYUG05hh0Z+tTwPJ6UmpsWbLZi/sINvOmRD
 yfmg==
X-Gm-Message-State: AOJu0YyonzK8hdisshlDSasp4sTK9EQj5ql6kg8lSShPr6148sPKFwM2
 cBH7HbYhYUrWij0qAkPaZPbgnDFkvcFSagyQzJXiPqBRJDW7p4fq4koVrRZTN4Tt
X-Gm-Gg: AR+sD11iMfGhGGtaeZCma4cxUYuFQ75HUyVTlWkSbrQaoglyVCmA/5SMBYPj7/b5uuz
 EWB43GQ/T5X7+/P96KxTZ+HV4G28RZA3Zoa94L/8M4Teo8FwzJaBuLY90wjR9nBVqzfzUQCn+bG
 VVcDxwRXdoi+/vPErzPS1WpyqbhyT7DWUFRJffI5YngONICl7IToRvXrLgMyTVNC5RBpRl7tUEl
 zXnKwe1USC/7GQWu1h6QC+dylQqgXJYEAqXfOIs6aTssMhsg5gjz1gDCVhNvuIOYyemdVf5prCu
 kF5IaKqJmnOZW850o7OBfrPTNQhEhkHB7IMn+RY3IouOnhU5Wtu9WUIsOmsocgeSZQdVMGLnwN+
 iZif506vd8cBVMbjQ4qPZjt5G6SflfJsjOHzwPcHf4W/sKDzvlNhWQxfacxXooGSs7Zjt9UoZAL
 I/JIaI+Hmf+dTybe9dIVwvlmdLi8CGDd8OqGZE6/cTM1i3ov2NTwGHxgHacrb7zNbU8Q2Hp9Zcz
 enHLTRfUS0=
X-Received: by 2002:a05:6808:1814:b0:4a4:82b:2a36 with SMTP id
 5614622812f47-4b241bc2652mr28261333b6e.11.1787012794278; 
 Mon, 17 Aug 2026 17:26:34 -0700 (PDT)
Received: from LAPTOP-86EU4LQA.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960dfc9bsm1715165b6e.14.2026.08.17.17.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:26:33 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>, Owen Giles <owen.giles@hpe.com>,
 Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 2/9] hw/arm/armsse: add Arm Corstone SSE-310
Date: Mon, 17 Aug 2026 19:26:22 -0500
Message-ID: <20260818002629.172827-3-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818002629.172827-1-simonxhy0404@gmail.com>
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22a.google.com
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

Add baseline Arm Corstone SSE-310 model.

Device list changes between SSE-310 and SSE-300:
New NPU0 Power Policy Unit and Configuration interface.
All other devices are the same.

Update comments in include/hw/arm/armsse.h to include SSE-300 and
SSE-310 and their respective documentations. New SSE-310 IRQ mapping.
sys_version and iidr values from the "SSE-310 with M85 and U55 FPGA"
documentation for the mps3-an555. Refractor comments and code
pertaining to both the SSE-300 and SSE-310.

Arm Corstone SSE-310 TRM:
https://developer.arm.com/documentation/102778/0000/

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-3-simonxhy0404@gmail.com>
---
 hw/arm/armsse.c                 | 208 +++++++++++++++++++++++++++++++-
 include/hw/arm/armsse-version.h |   2 +
 include/hw/arm/armsse.h         |   9 +-
 3 files changed, 211 insertions(+), 8 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 55fbc2c290..6cf8d5bba1 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -26,7 +26,7 @@
 #include "hw/core/qdev-clock.h"
 
 /*
- * The SSE-300 puts some devices in different places to the
+ * The SSE-300 and SSE-310 put some devices in different places to the
  * SSE-200 (and original IoTKit). We use an array of these structs
  * to define how each variant lays out these devices. (Parts of the
  * SoC that are the same for all variants aren't handled via these
@@ -118,6 +118,18 @@ static const Property sse300_properties[] = {
     DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
 };
 
+static const Property sse310_properties[] = {
+    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
+    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 21),
+    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
+    DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], true),
+    DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
+    DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
+    DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
+};
+
 static const ARMSSEDeviceInfo iotkit_devices[] = {
     {
         .name = "timer0",
@@ -480,6 +492,146 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
     }
 };
 
+static const ARMSSEDeviceInfo sse310_devices[] = {
+    {
+        .name = "timer0",
+        .type = TYPE_SSE_TIMER,
+        .index = 0,
+        .addr = 0x48000000,
+        .ppc = 0,
+        .ppc_port = 0,
+        .irq = 3,
+    },
+    {
+        .name = "timer1",
+        .type = TYPE_SSE_TIMER,
+        .index = 1,
+        .addr = 0x48001000,
+        .ppc = 0,
+        .ppc_port = 1,
+        .irq = 4,
+    },
+    {
+        .name = "timer2",
+        .type = TYPE_SSE_TIMER,
+        .index = 2,
+        .addr = 0x48002000,
+        .ppc = 0,
+        .ppc_port = 2,
+        .irq = 5,
+    },
+    {
+        .name = "timer3",
+        .type = TYPE_SSE_TIMER,
+        .index = 3,
+        .addr = 0x48003000,
+        .ppc = 0,
+        .ppc_port = 5,
+        .irq = 27,
+    },
+    {
+        .name = "s32ktimer",
+        .type = TYPE_CMSDK_APB_TIMER,
+        .index = 0,
+        .addr = 0x4802f000,
+        .ppc = 1,
+        .ppc_port = 0,
+        .irq = 2,
+        .slowclk = true,
+    },
+    {
+        .name = "s32kwatchdog",
+        .type = TYPE_CMSDK_APB_WATCHDOG,
+        .index = 0,
+        .addr = 0x5802e000,
+        .ppc = NO_PPC,
+        .irq = NMI_0,
+        .slowclk = true,
+    },
+    {
+        .name = "watchdog",
+        .type = TYPE_UNIMPLEMENTED_DEVICE,
+        .index = 0,
+        .addr = 0x48040000,
+        .size = 0x2000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "armsse-sysinfo",
+        .type = TYPE_IOTKIT_SYSINFO,
+        .index = 0,
+        .addr = 0x48020000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "armsse-sysctl",
+        .type = TYPE_IOTKIT_SYSCTL,
+        .index = 0,
+        .addr = 0x58021000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "SYS_PPU",
+        .type = TYPE_UNIMPLEMENTED_DEVICE,
+        .index = 1,
+        .addr = 0x58022000,
+        .size = 0x1000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "CPU0CORE_PPU",
+        .type = TYPE_UNIMPLEMENTED_DEVICE,
+        .index = 2,
+        .addr = 0x58023000,
+        .size = 0x1000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "MGMT_PPU",
+        .type = TYPE_UNIMPLEMENTED_DEVICE,
+        .index = 3,
+        .addr = 0x58028000,
+        .size = 0x1000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "DEBUG_PPU",
+        .type = TYPE_UNIMPLEMENTED_DEVICE,
+        .index = 4,
+        .addr = 0x58029000,
+        .size = 0x1000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "NPU0_PPU",
+        .type = TYPE_UNIMPLEMENTED_DEVICE,
+        .index = 5,
+        .addr = 0x5802a000,
+        .size = 0x1000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = "NPU0_CFG",
+        .type = TYPE_UNIMPLEMENTED_DEVICE,
+        .index = 6,
+        .addr = 0x40004000,
+        .size = 0x1000,
+        .ppc = NO_PPC,
+        .irq = NO_IRQ,
+    },
+    {
+        .name = NULL,
+    }
+};
+
 /* Is internal IRQ n shared between CPUs in a multi-core SSE ? */
 static const bool sse200_irq_is_common[32] = {
     [0 ... 5] = true,
@@ -507,6 +659,20 @@ static const bool sse300_irq_is_common[32] = {
     /* 30, 31: reserved */
 };
 
+static const bool sse310_irq_is_common[32] = {
+    [0 ... 5] = true,
+    /* 6-8: reserved */
+    [9 ... 12] = true,
+    /* 13: reserved */
+    [14] = true,
+    /* 15: reserved */
+    [16] = true,
+    /* 17-26: reserved */
+    [27] = true,
+    /* 28, 29: per-CPU CTI interrupts */
+    /* 30, 31: reserved */
+};
+
 static const ARMSSEInfo armsse_variants[] = {
     {
         .name = TYPE_IOTKIT,
@@ -574,6 +740,28 @@ static const ARMSSEInfo armsse_variants[] = {
         .devinfo = sse300_devices,
         .irq_is_common = sse300_irq_is_common,
     },
+    {
+        .name = TYPE_SSE310,
+        .sse_version = ARMSSE_SSE310,
+        .cpu_type = ARM_CPU_TYPE_NAME("cortex-m85"),
+        .sram_banks = 2,
+        .sram_bank_base = 0x21000000,
+        .num_cpus = 1,
+        .sys_version = 0x7e10043b,
+        .iidr = 0x74e0043b,
+        .cpuwait_rst = 0,
+        .has_mhus = false,
+        .has_cachectrl = false,
+        .has_cpusecctrl = true,
+        .has_cpuid = true,
+        .has_cpu_pwrctrl = true,
+        .has_sse_counter = true,
+        .has_tcms = true,
+        .props = sse310_properties,
+        .props_count = ARRAY_SIZE(sse310_properties),
+        .devinfo = sse310_devices,
+        .irq_is_common = sse310_irq_is_common,
+    }
 };
 
 static uint32_t armsse_sys_config_value(ARMSSE *s, const ARMSSEInfo *info)
@@ -604,6 +792,14 @@ static uint32_t armsse_sys_config_value(ARMSSE *s, const ARMSSEInfo *info)
         sys_config = deposit32(sys_config, 4, 5, s->sram_addr_width);
         sys_config = deposit32(sys_config, 16, 3, 3); /* CPU0 = Cortex-M55 */
         break;
+    case ARMSSE_SSE310:
+        sys_config = 0;
+        sys_config = deposit32(sys_config, 0, 4, info->sram_banks);
+        sys_config = deposit32(sys_config, 4, 5, s->sram_addr_width);
+        sys_config = deposit32(sys_config, 10, 1, 0); /* No CoreSight SoC */
+        sys_config = deposit32(sys_config, 11, 2, 0); /* Basic level PI */
+        sys_config = deposit32(sys_config, 16, 3, 4); /* CPU0 = Cortex-M85 */
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1205,7 +1401,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(DEVICE(&s->nmi_orgate), 0,
                           qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0));
 
-    /* The SSE-300 has a System Counter / System Timestamp Generator */
+    /* The SSE-300/SSE-310 has a System Counter / System Timestamp Generator */
     if (info->has_sse_counter) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->sse_counter);
 
@@ -1225,12 +1421,12 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     if (info->has_tcms) {
-        /* The SSE-300 has an ITCM at 0x0000_0000 and a DTCM at 0x2000_0000 */
-        memory_region_init_ram(&s->itcm, NULL, "sse300-itcm", 512 * KiB, errp);
+        /* The SSE-300/SSE-310 has an ITCM at 0x0000_0000 and a DTCM at 0x2000_0000 */
+        memory_region_init_ram(&s->itcm, NULL, "itcm", 512 * KiB, errp);
         if (*errp) {
             return;
         }
-        memory_region_init_ram(&s->dtcm, NULL, "sse300-dtcm", 512 * KiB, errp);
+        memory_region_init_ram(&s->dtcm, NULL, "dtcm", 512 * KiB, errp);
         if (*errp) {
             return;
         }
@@ -1461,7 +1657,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      *  0x50010000: L1 icache control registers
      *  0x50011000: CPUSECCTRL (CPU local security control registers)
      *  0x4001f000 and 0x5001f000: CPU_IDENTITY register block
-     * The SSE-300 has an extra:
+     * The SSE-300 and SSE-310 have an extra:
      *  0x40012000 and 0x50012000: CPU_PWRCTRL register block
      */
     if (info->has_cachectrl) {
diff --git a/include/hw/arm/armsse-version.h b/include/hw/arm/armsse-version.h
index 60780fa984..6b498cb334 100644
--- a/include/hw/arm/armsse-version.h
+++ b/include/hw/arm/armsse-version.h
@@ -25,6 +25,7 @@ enum {
     ARMSSE_IOTKIT = 0,
     ARMSSE_SSE200 = 200,
     ARMSSE_SSE300 = 300,
+    ARMSSE_SSE310 = 310
 };
 
 static inline bool armsse_version_valid(uint32_t sse_version)
@@ -33,6 +34,7 @@ static inline bool armsse_version_valid(uint32_t sse_version)
     case ARMSSE_IOTKIT:
     case ARMSSE_SSE200:
     case ARMSSE_SSE300:
+    case ARMSSE_SSE310:
         return true;
     default:
         return false;
diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index bdf2d4db8e..6aa1363ccf 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -11,12 +11,16 @@
 
 /*
  * This is a model of the Arm "Subsystems for Embedded" family of
- * hardware, which include the IoT Kit and the SSE-050, SSE-100 and
- * SSE-200. Currently we model:
+ * hardware, which include the IoT Kit and the SSE-050, SSE-100,
+ * SSE-200, SSE-300, and SSE-310. Currently we model:
  *  - the Arm IoT Kit which is documented in
  *    https://developer.arm.com/documentation/ecm0601256/latest
  *  - the SSE-200 which is documented in
  *    https://developer.arm.com/documentation/101104/latest/
+ *  - the SSE-300 which is documented in
+ *    https://support.arm.com/documentation/101773/latest/
+ *  - the SSE-310 which is documented in 
+ *    https://support.arm.com/documentation/102778/latest/
  *
  * The IoTKit contains:
  *  a Cortex-M33
@@ -127,6 +131,7 @@ OBJECT_DECLARE_TYPE(ARMSSE, ARMSSEClass,
 #define TYPE_IOTKIT "iotkit"
 #define TYPE_SSE200 "sse-200"
 #define TYPE_SSE300 "sse-300"
+#define TYPE_SSE310 "sse-310"
 
 /* We have an IRQ splitter and an OR gate input for each external PPC
  * and the 2 internal PPCs
-- 
2.53.0


