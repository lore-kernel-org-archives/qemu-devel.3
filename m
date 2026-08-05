Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8792AC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZR-0005mh-Q2; Wed, 05 Aug 2026 11:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZO-0005lu-5D
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:14 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZL-0007c4-Ky
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:13 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-48a0ca07c38so723194b6e.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943810; x=1786548610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4xZSFW/3ru0OkV2HgMsI1LCVRBUpnAQblZnopJOlyMw=;
 b=itPtlJdmW/oh+G1m1mbcjm/Tr7RX3X03I2Y8eIguwbK/5095sqrFg5L80/sk35evPU
 ZWC5BG8d6+7+T9z4DPDYs3XW39msqMvNnykiSilSB0MhXJecaPtJ+9ToYkbh5Uyu5XEs
 O37qGXxvcbZs+I58bJj0GXt8XHTkyEYq9B7GSWjh/XhPiyWHzdY4X6fZ78NuTx9jTD+R
 zylMwESSIz/nHd067+Ho5x6vf5/tT1ubnepYnQ+z0iH/9AaBiUzgE8KPVyJA/y5TLR8A
 dHEVWNSD978OPUP/rGi140S9Xy9PJsbYsHielrRJvFUIPr+ZQ2qqxJ+v4dx6AiNYeFFO
 9Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943810; x=1786548610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4xZSFW/3ru0OkV2HgMsI1LCVRBUpnAQblZnopJOlyMw=;
 b=iFIE7gEtdNml2byeVP/UUSgLz88sGzgbr7SI9dvVdxzyWXQj8Iae4E93/qiVsk9y7S
 so0Hme/OUT99Vvqlzey9US/IA+zO5cHWo+MZ3A4D1BzODqIw1hDurI+HeA0Lq8S4uXAd
 5YJyrZ3m7HpHEd2SzTRNgfk/CotXsFsU3bwls5lFUtVMYmqzr7yEr7KQyU6dMLm6Zd01
 wEUxf484p/nW4FsR5itv0SCzY/ir1q3gYi5WAfkc6hTAOhRrYNfegnxJCf75tq5OaJzL
 XR4Wmfddej9lGxZz9PVb8bVqeeuOD8s9RzT62vbLubCoX6oEJ1V7BD63EdnBrS/qxcrS
 m62g==
X-Gm-Message-State: AOJu0YzrOZnFIqX+9CiEW4KMqW6KyvXf1Hrq0yBlYqcRWGmBovAezgKT
 CjKPiJjfcdDEauxbKWEj7ZrjeTpCa+7lMSq4DIvWp6vmuO7tYHHpldjojjaxJQ2m
X-Gm-Gg: AR+sD10cjKMon5YtWEN+8sETTB7JyqMEEg4XtNCjqWKpZz1mdErZPo1ZjwMkGI53+nQ
 2Ss1Vml0eGPFZCLTP+jhJ5xqt7L02SC5MEtFZNtr6mXqQkUnhARpK5f1LaXBjCXAivJ1kKC9f2m
 FsiqFxEkpVA5Sq/6fDakkGMqfHJematXopx7V1FgiMysKjWLITPn/9ueUZFCxsicwFf/nD5oZ7C
 CXt7/cgXTpuMXuN8r7u80LgDuf7JZ5riDN06NkSG3Ryk2hg5u8w9opfg7n/L9UoHBypV3EsRsL4
 w7GbRN7FFixHyVM7RCIv6+ZyQqNPLrggUL7Bwc2TWbdFCINhRkkmJAj0QlGQgPUKA8bQwkhMvSA
 sUqkJPgGy6s0vjErczicP0Al7mHo5jPpATYLvavcjmToc64jWNROfbTFc1Nf22fIYMic5dbZzfb
 jfzguwiKQhnxuwP5zuytI6BcNzR880/kfNxyr4R83L+GDBoBkUSvSpW6R84v+Yp+9/+cznfxbK9
 bLSgtVME8Xx
X-Received: by 2002:a05:6808:3a0f:b0:4a3:f4b7:cbdf with SMTP id
 5614622812f47-4afadf93109mr4011031b6e.15.1785943810244; 
 Wed, 05 Aug 2026 08:30:10 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:09 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 2/9] hw/arm/armsse: add Arm Corstone SSE-310
Date: Wed,  5 Aug 2026 10:29:58 -0500
Message-ID: <20260805153005.9989-3-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153005.9989-1-simonxhy0404@gmail.com>
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22d.google.com
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
---
v1 -> v2
	Split v1 armsse patch into multiple patches for armsse and iotkit files
	Update comments in armsse.h to include SSE-300 and SSE-310
	Remove sys_config2 property
	Add SSE-310 to iotkit files in next few patches
---
 hw/arm/armsse.c                 | 208 +++++++++++++++++++++++++++++++-
 include/hw/arm/armsse-version.h |   2 +
 include/hw/arm/armsse.h         |   9 +-
 3 files changed, 211 insertions(+), 8 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index ddb210c895..1847c73322 100644
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


