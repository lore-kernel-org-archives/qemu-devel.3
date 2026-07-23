Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F406CC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn2xd-0004wu-J8; Thu, 23 Jul 2026 19:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wn2xb-0004vw-R1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:15 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wn2xY-0001ci-N8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:15 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4a451915d8aso694889b6e.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784849771; x=1785454571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=peh2Pmyv7l6hf9+ZkMIxYhy7GzBfBvGbGeUeyFh5t4c=;
 b=pU2lUWvBrspGBQyxe4uMno1dwmdqXaRh8r3C1Aeguq+rXO+nBeRPMLDLTKBwoAtvWK
 yHc7KrPSG9MkOQIf01/OI61gHHKaVh8aMazlIdbl01bp2F11vjVJD9s7p5qfkuxhYNzj
 DyFF55R59g12hTw9xCj4SH7Ed0chFYCbTDU7tub6yv4gsxuFuOqAqoWdIKkpVoCgKXRV
 ecFiPnhMZPmuioIAR2+Y/YBrTXjX0DKwsO4z5TYwq2C+gPmD0zcwb2wwEOECHDp+ie4K
 7iNE1bedeTGeI7YZX5eq7PR38IeglzSGxPIzARrv1jq+YGR4yk7bzv8xGpRgu4jArq+N
 36CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784849771; x=1785454571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=peh2Pmyv7l6hf9+ZkMIxYhy7GzBfBvGbGeUeyFh5t4c=;
 b=HXsp/OwcvRvcOkNthhU7UIpYy+4k310RqNXGby8gqUgF9NjQxef3ckRw7rC3xQrSnZ
 zHB+tAZMEhlAVRF/HB2uiVgM6LfhWzSukugDSM7T5Kobq1RHWT0cb9Tio/vNXfRfWLoK
 bC8y9CehE/pysGViMoBhpO/uojiXkjWXXqE2MqaVWhrQCDhbhKKzyX6PI6FPNlaBHZww
 x/cSnX+++4EqGyRYP4GFQ1snJPN83jwF+V5JB0U/baVYqxpqzmEYI9cGcgmsznHfWVmq
 SyaugblGm2btOl813SgGHity6kKNDgSJwyzLc4QNIS+kr2oQAwhT+aAO5zJIvngRM4BQ
 2oWw==
X-Gm-Message-State: AOJu0Yxrr/Kn8x8EnoWXKVc0tprtKHUsIirYt3noF7dg8sD8OXbs+9bh
 47Qtaq013nHgdLZZubWVlaF6k67Zb2uWOXmEq8VWbEiLcQnhVGkVhjSfUJvIUgTs
X-Gm-Gg: AR+sD116K3oTq1J++QPjck/FR+Tucm5YOh8pmuzi91BY3Wf4PzrC3dXT//4w04FK8s5
 mtWoHdGBup0pa9VtszVmoCavMfB6+trvFr3ggukSxbCGiVN1MFyaDKh30Z8eIOugcksTkpxDMqM
 ZQcToyD/RQUKX56S7nXrXebKHiYJHkSOFsayEm8XzmLLfS7RuTxWe10k4NcShYMt7su1+JvcLyu
 MxiSLvL/jbY93g5rKTtEhSFKl/Njot2Rrz7KNZ/I/0t5oKX288fH7ZgPlj3e/QySaYgcUBxmMLs
 ixj4Rzn8gpXV2BXK2VrQx5UHmvJMtgPneByQ4pO2EX5sh/SFAZa2KoBMG6/dxt8cxvgshmu0+D6
 bzQWXDbpNA5/WyKUETFANAPDT2VSNqLeK1hXDESif5pbZ5U+68qnmUOETKqv951FK/j37vH23hm
 p2I5XoHJQSdIfsUcY5hKGVD9w=
X-Received: by 2002:a05:6808:1305:b0:4a4:68a9:5f06 with SMTP id
 5614622812f47-4ab3561ac03mr3358485b6e.42.1784849771059; 
 Thu, 23 Jul 2026 16:36:11 -0700 (PDT)
Received: from HPE-2MQ6131DV6.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab248c6667sm3631997b6e.0.2026.07.23.16.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 16:36:09 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 2/4] hw/arm/armsse: add Arm Corstone SSE-310
Date: Thu, 23 Jul 2026 18:36:03 -0500
Message-Id: <20260723233605.805-3-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723233605.805-1-simonxhy0404@gmail.com>
References: <20260723233605.805-1-simonxhy0404@gmail.com>
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

Add Arm Corstone SSE-310 model.
- Include new NPU power policy unit and configuration interface in device
list as unimplemented devices.
- sys_version and iidr values from the "SSE-310 with M85 and U55 FPGA"
documentation for the mps3-an555.
- Refractor comments and code pertaining to both the SSE-300 and SSE-310.
- Add support for SSE-310 in the iotkit files.
- Add SSE-310 PIDR and CIDR registers according to the SSE-310 TRM.

Arm Corstone SSE-310 TRM:
https://developer.arm.com/documentation/102778/0000/

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
 hw/arm/armsse.c                 | 208 +++++++++++++++++++++++++++++++-
 hw/misc/iotkit-secctl.c         |  18 +++
 hw/misc/iotkit-sysctl.c         |  60 +++++++--
 hw/misc/iotkit-sysinfo.c        |  12 +-
 include/hw/arm/armsse-version.h |   2 +
 include/hw/arm/armsse.h         |   1 +
 6 files changed, 287 insertions(+), 14 deletions(-)

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
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 54bfe1ba59..38add5b1f1 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -109,6 +109,18 @@ static const uint8_t iotkit_secctl_ns_sse300_idregs[] = {
     0x0d, 0xf0, 0x05, 0xb1,
 };
 
+static const uint8_t iotkit_secctl_s_sse310_idregs[] = {
+    0x04, 0x00, 0x00, 0x00,
+    0x52, 0xb8, 0x3b, 0x00,
+    0x0d, 0xf0, 0x05, 0xb1,
+};
+
+static const uint8_t iotkit_secctl_ns_sse310_idregs[] = {
+    0x04, 0x00, 0x00, 0x00,
+    0x53, 0xb8, 0x3b, 0x00,
+    0x0d, 0xf0, 0x05, 0xb1,
+};
+
 
 /* The register sets for the various PPCs (AHB internal, APB internal,
  * AHB expansion, APB expansion) are all set up so that they are
@@ -232,6 +244,9 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
         case ARMSSE_SSE300:
             r = iotkit_secctl_s_sse300_idregs[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = iotkit_secctl_s_sse310_idregs[(offset - A_PID4) / 4];
+            break;
         default:
             r = iotkit_secctl_s_idregs[(offset - A_PID4) / 4];
             break;
@@ -499,6 +514,9 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
         case ARMSSE_SSE300:
             r = iotkit_secctl_ns_sse300_idregs[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = iotkit_secctl_ns_sse310_idregs[(offset - A_PID4) / 4];
+            break;
         default:
             r = iotkit_secctl_ns_idregs[(offset - A_PID4) / 4];
             break;
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index dff89c677f..e6b1fe5d32 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -87,6 +87,12 @@ static const int sse200_sysctl_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const int sse310_sysctl_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x54, 0xb8, 0x4b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 /*
  * Set the initial secure vector table offset address for the core.
  * This will take effect when the CPU next resets.
@@ -118,6 +124,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->scsecctrl;
             break;
         default:
@@ -130,6 +137,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->fclk_div;
             break;
         default:
@@ -142,6 +150,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->sysclk_div;
             break;
         default:
@@ -154,6 +163,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->clock_force;
             break;
         default:
@@ -180,6 +190,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->initsvtor1;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -193,6 +204,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             break;
         case ARMSSE_SSE300:
             /* In SSE300 this is reserved (for INITSVTOR2) */
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -209,6 +221,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             break;
         case ARMSSE_SSE300:
             /* In SSE300 this is reserved (for INITSVTOR3) */
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -221,7 +234,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->wicctrl;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is CPUWAIT */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is CPUWAIT */
             r = s->cpuwait;
             break;
         default:
@@ -236,7 +250,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->ewctrl;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is NMI_ENABLE */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is NMI_ENABLE */
             r = s->nmi_enable;
             break;
         default:
@@ -249,6 +264,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pwrctrl;
             break;
         default:
@@ -261,6 +277,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_sys_sense;
             break;
         default:
@@ -273,6 +290,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_cpu0_sense;
             break;
         default:
@@ -287,6 +305,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram0_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -300,6 +319,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram1_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -313,6 +333,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram2_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_vmr0_sense;
             break;
         default:
@@ -327,6 +348,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram3_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_vmr1_sense;
             break;
         default:
@@ -342,6 +364,9 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE300:
             r = sse200_sysctl_id[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = sse310_sysctl_id[(offset - A_PID4) / 4];
+            break;
         default:
             g_assert_not_reached();
         }
@@ -367,7 +392,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
 
 static void cpuwait_write(IoTKitSysCtl *s, uint32_t value)
 {
-    int num_cpus = (s->sse_version == ARMSSE_SSE300) ? 1 : 2;
+    int num_cpus = (s->sse_version == ARMSSE_SSE300 ||
+                    s->sse_version == ARMSSE_SSE310) ? 1 : 2;
     int i;
 
     for (i = 0; i < num_cpus; i++) {
@@ -418,7 +444,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
     case A_INITSVTOR0:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
-            /* SSE300 has a LOCK bit which prevents further writes when set */
+        case ARMSSE_SSE310:
+            /* SSE300 and SSE310 have a LOCK bit which prevents further writes when set */
             if (s->initsvtor0 & R_INITSVTOR0_LOCK_MASK) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "IoTKit INITSVTOR0 write when register locked\n");
@@ -444,6 +471,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             break;
         case ARMSSE_SSE300:
             /* In SSE300 this is reserved (for INITSVTOR2) */
+        case ARMSSE_SSE310:
+            /* In SSE310 this is reserved */
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -457,7 +486,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->wicctrl = value;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is CPUWAIT */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is CPUWAIT */
             cpuwait_write(s, value);
             break;
         default:
@@ -485,6 +515,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SCSECCTRL unimplemented\n");
             s->scsecctrl = value;
             break;
@@ -498,6 +529,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl FCLK_DIV unimplemented\n");
             s->fclk_div = value;
             break;
@@ -511,6 +543,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SYSCLK_DIV unimplemented\n");
             s->sysclk_div = value;
             break;
@@ -524,6 +557,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl CLOCK_FORCE unimplemented\n");
             s->clock_force = value;
             break;
@@ -540,6 +574,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             set_init_vtor(1, s->initsvtor1);
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -554,7 +589,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->ewctrl = value;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is NMI_ENABLE */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is NMI_ENABLE */
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl NMI_ENABLE unimplemented\n");
             s->nmi_enable = value;
             break;
@@ -568,6 +604,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             if (!(s->pwrctrl & R_PWRCTRL_PPU_ACCESS_UNLOCK_MASK)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "IoTKit PWRCTRL write when register locked\n");
@@ -585,6 +622,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_SYS_SENSE unimplemented\n");
             s->pdcm_pd_sys_sense = value;
@@ -599,6 +637,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_CPU0_SENSE unimplemented\n");
             s->pdcm_pd_cpu0_sense = value;
@@ -617,6 +656,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram0_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -632,6 +672,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram1_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -647,6 +688,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram2_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_VMR0_SENSE unimplemented\n");
             s->pdcm_pd_vmr0_sense = value;
@@ -665,6 +707,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram3_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_VMR1_SENSE unimplemented\n");
             s->pdcm_pd_vmr1_sense = value;
@@ -684,6 +727,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             break;
         case ARMSSE_SSE300:
             /* In SSE300 this is reserved (for INITSVTOR3) */
+        case ARMSSE_SSE310:
+            /* In SSE310 this is reserved */
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -769,7 +814,8 @@ static bool sse300_needed(void *opaque)
 {
     IoTKitSysCtl *s = IOTKIT_SYSCTL(opaque);
 
-    return s->sse_version == ARMSSE_SSE300;
+    return s->sse_version == ARMSSE_SSE300 ||
+           s->sse_version == ARMSSE_SSE310;
 }
 
 static const VMStateDescription iotkit_sysctl_sse300_vmstate = {
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 19f089e6ee..21e161bdc2 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -58,6 +58,12 @@ static const int sysinfo_sse300_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const int sysinfo_sse310_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x58, 0xb8, 0x2b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
@@ -68,13 +74,13 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_SYS_VERSION:
         r = s->sys_version;
         break;
-
     case A_SYS_CONFIG:
         r = s->sys_config;
         break;
     case A_SYS_CONFIG1:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             return 0;
             break;
         default:
@@ -84,6 +90,7 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_IIDR:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             return s->iidr;
             break;
         default:
@@ -95,6 +102,9 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE300:
             r = sysinfo_sse300_id[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = sysinfo_sse310_id[(offset - A_PID4) / 4];
+            break;
         default:
             r = sysinfo_id[(offset - A_PID4) / 4];
             break;
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
index bdf2d4db8e..d0dcba1fbb 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -127,6 +127,7 @@ OBJECT_DECLARE_TYPE(ARMSSE, ARMSSEClass,
 #define TYPE_IOTKIT "iotkit"
 #define TYPE_SSE200 "sse-200"
 #define TYPE_SSE300 "sse-300"
+#define TYPE_SSE310 "sse-310"
 
 /* We have an IRQ splitter and an OR gate input for each external PPC
  * and the 2 internal PPCs
-- 
2.34.1


