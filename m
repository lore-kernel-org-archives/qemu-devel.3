Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D8ACD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL123-0005ng-Cc; Thu, 07 May 2026 11:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL122-0005kR-4Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11z-00042t-TL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so6701555e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169174; x=1778773974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0vjExETreirHyQEBenl6DOZ9G0i3KJ1YXzOqbb5GT7w=;
 b=ys5GkSirO0rwFpMWji9B8qlgPplBYburdyRDKlUFJLhZpHmVd0cYVLwzptYbWtR44F
 b4aOIK7tLz0/tyQ1x3sYADMtu1tD2y/PsqZgCjZz/sNuTPPxzIuh8RcjiE1dPihFFLdG
 CzbNdtQOAtVW75g9PZ/P45kjjVaQCf8EAKZ/UUSXryZbHPS32jxp4tbrS5jnzDGOTwIq
 m2ft9PcDhBxjcVxC7boKlA0qNh1bVikdND/nAthVf48iQbzy95MesqQM1O7Xsdxw3tgq
 sTBi0y5I5jawjiHf5nHKq0VG6ouJT5G9xKJ6odNW3R/6B63wlCuH+7r5dqBOqhhcG1Ss
 9mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169174; x=1778773974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0vjExETreirHyQEBenl6DOZ9G0i3KJ1YXzOqbb5GT7w=;
 b=GLpfr/zl8l0lcZyZkr+9GrAcEZc5mx/l6JgCAlepE3F+uzQdOMzSgwNzJu6/3wghKK
 eRZStwQKMv242rXxDfxpkz7UI/p3xmMrA1c3WZD4BqTVJzgwg8yRLGACkDHrmhmdn4IU
 gJHBwKbhRRsmMbp+yRaUZfMEWon4JI1m4kGO8gK6/O0WfZ81Xh9Fm9foy+eRfaQGaM79
 vS/BvmULeiYtoZhvMeqW1Lm3hMSRubDERR3b3/AVluEkv0Mua5eM0e1p0aaoi8MON84X
 +Fb41ZGTSZcRslWqsU1GkM57UUvWO9LL9gcpG9chlNdevnsVoN+Z4QICWo/1UDj2nzpe
 tYCg==
X-Gm-Message-State: AOJu0YzdTPTdEW9QhThl5o55bQn/jCFRTBsBG3XArzvubd6Rd21+KirE
 oCWpbminyHAWhMsXrUhx9lBlIBrU0LBrzbBtMPmR8BWW/lA0K0/FrETkxh5+dIixm8pquMOE27q
 Ng+PB
X-Gm-Gg: AeBDiesXXop2YlYYppivHGB7CBtqQut0AS3UMnlZlpWVfR5n9S5Y8DJFdEcwq7W6PYL
 /Etjz5oHp2RMjI3+/AnEyXJP2cYZFKJBuW8pPBp2dkF3Uzo2tX3A5MKqePdfQWKx+eC92/brsWN
 awHp/GOOH8wtgTFGAk2ZAkJQBmK9JyEt28mNEebk1HZMSwqWG5s0b22U5Am3TEXerUZrqJ3/mbZ
 EfiHFE80IaWUgXatUv67C4Cfl1PxflK+dgMzN+kxJSb9xa0j/2U3f7w9O3L5kLShF8EDMS1mD7V
 P/JjZsIOFwJ0hDo8ZtnAovPJBGKVP4wKqA/AvyPDvSV4Xm6Hkr5Hq35Icfe0A1dFQF2gwbH/eR3
 VbP+YGeDs2/YM8lzQvwnGPJK3Rt3BDP/oSEeVkt9mljHxjXktINSD+jdRWtguBUZulWUIUqPlMm
 Uj9XEv0U1WbxBMTjBnCsdhc+pl1jZk2lTNxqd0Z1zPxLgJvPcMPLKBpeLxaSvAgi66i1zKzFKJJ
 Ae1YImpJ4ipcNkgok/xf1WJ5lMSX90T4GCf/eoiig==
X-Received: by 2002:a05:600c:a10d:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48e51e1f013mr107836585e9.11.1778169174149; 
 Thu, 07 May 2026 08:52:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/67] hw/arm/virt: Create and connect GICv5
Date: Thu,  7 May 2026 16:51:47 +0100
Message-ID: <20260507155154.1886557-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In this commit we create and connect up the GICv5.  We do not
advertise it in the ACPI tables or DTB; that will be done in a
following commit.

The user-facing gic-version property still only documents and permits
in its setter function the existing set of possible values; we won't
permit the user to select a GICv5 until all the code to handle it is
in place.

Although we currently implement only the IRS, and only for EL1,
we reserve space in the virt board's memory map now for all the
register frames that the GICv5 may use. Each interrupt domain has:
 * one IRS config register frame
 * one ITS config register frame
 * one ITS translate register frame
and each of these frames is 64K in size and 64K aligned and must be
at a unique address (that is, it is not permitted to have all the IRS
config register frames at the same physical address in the different
S/NS/etc physical address spaces).

The addresses and layout of these frames are entirely up to the
implementation: software will be passed their addresses via firmware
data structures (ACPI or DTB).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-61-peter.maydell@linaro.org
---
 hw/arm/virt.c         | 101 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  14 ++++++
 2 files changed, 115 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2475d583cc..cf4d430454 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -68,6 +68,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/intc/arm_gicv5_common.h"
 #include "hw/core/irq.h"
 #include "kvm_arm.h"
 #include "whpx_arm.h"
@@ -184,6 +185,19 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
     /* This redistributor space allows up to 2*64kB*123 CPUs */
     [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
+    /* The GICv5 uses this address range differently from GICv2/v3/v4 */
+    [VIRT_GICV5_IRS_S] =        { 0x08000000, 0x00010000 },
+    [VIRT_GICV5_IRS_NS] =       { 0x08010000, 0x00010000 },
+    [VIRT_GICV5_IRS_EL3] =      { 0x08020000, 0x00010000 },
+    [VIRT_GICV5_IRS_REALM] =    { 0x08030000, 0x00010000 },
+    [VIRT_GICV5_ITS_S] =        { 0x08040000, 0x00010000 },
+    [VIRT_GICV5_ITS_NS] =       { 0x08050000, 0x00010000 },
+    [VIRT_GICV5_ITS_EL3] =      { 0x08060000, 0x00010000 },
+    [VIRT_GICV5_ITS_REALM] =    { 0x08070000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_S] =     { 0x08080000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_NS] =    { 0x08090000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_EL3] =   { 0x080A0000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_REALM] = { 0x080B0000, 0x00010000 },
     [VIRT_UART0] =              { 0x09000000, 0x00001000 },
     [VIRT_RTC] =                { 0x09010000, 0x00001000 },
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
@@ -1106,6 +1120,49 @@ static void create_v2m(VirtMachineState *vms)
     vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
 }
 
+static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
+{
+    MachineState *ms = MACHINE(vms);
+    SysBusDevice *gicbusdev;
+    const char *gictype = gicv5_class_name();
+    QList *cpulist = qlist_new(), *iaffidlist = qlist_new();
+
+    vms->gic = qdev_new(gictype);
+    qdev_prop_set_uint32(vms->gic, "spi-range", NUM_IRQS);
+
+    object_property_set_link(OBJECT(vms->gic), "sysmem", OBJECT(mem),
+                             &error_fatal);
+
+    for (int i = 0; i < ms->smp.cpus; i++) {
+        qlist_append_link(cpulist, OBJECT(qemu_get_cpu(i)));
+        /*
+         * GICv5 IAFFIDs must be system-wide unique across all GICs.
+         * For virt we make them the same as the CPU index.
+         */
+        qlist_append_int(iaffidlist, i);
+    }
+    qdev_prop_set_array(vms->gic, "cpus", cpulist);
+    qdev_prop_set_array(vms->gic, "cpu-iaffids", iaffidlist);
+
+    gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+
+    /*
+     * Map the IRS config frames for the interrupt domains.
+     * At the moment we implement only the NS domain, so this is simple.
+     */
+    sysbus_mmio_map(gicbusdev, GICV5_ID_NS,
+                    vms->memmap[VIRT_GICV5_IRS_NS].base);
+
+    /*
+     * The GICv5 does not need to wire up CPU timer IRQ outputs to the GIC
+     * because for the GICv5 those PPIs are entirely internal to the CPU.
+     * Nor do we need to wire up GIC IRQ/FIQ signals to the CPUs, because
+     * that information is communicated directly between a GICv5 IRS and
+     * the GICv5 CPU interface via our equivalent of the stream protocol.
+     */
+}
+
 /*
  * If the CPU has FEAT_NMI, then turn on the NMI support in the GICv3 too.
  * It's permitted to have a configuration with NMI in the CPU (and thus the
@@ -1319,6 +1376,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     case VIRT_GIC_VERSION_4:
         create_gicv3(vms, mem);
         break;
+    case VIRT_GIC_VERSION_5:
+        create_gicv5(vms, mem);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -2254,6 +2314,11 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
     /*
      * Adjust MPIDR to make TCG consistent (with 64-bit KVM hosts)
      * and to improve SGI efficiency.
+     * - GICv2 only supports 8 CPUs anyway
+     * - GICv3 wants 16 CPUs per Aff0 because of an ICC_SGIxR
+     *   register limitation
+     * - GICv5 has no restrictions, so we retain the GICv3 16-per-Aff0
+     *   layout because that's what KVM does
      */
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
         clustersz = GIC_TARGETLIST_BITS;
@@ -2399,6 +2464,11 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
         return finalize_gic_version_do(accel_name, VIRT_GIC_VERSION_MAX,
                                        gics_supported, max_cpus);
     case VIRT_GIC_VERSION_MAX:
+        /*
+         * We don't (currently) make 'max' select GICv5 as it is not
+         * backwards compatible for system software with GICv3/v4 and
+         * at time of writing not widely supported in guest kernels.
+         */
         if (gics_supported & VIRT_GIC_VERSION_4_MASK) {
             gic_version = VIRT_GIC_VERSION_4;
         } else if (gics_supported & VIRT_GIC_VERSION_3_MASK) {
@@ -2427,6 +2497,7 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
     case VIRT_GIC_VERSION_2:
     case VIRT_GIC_VERSION_3:
     case VIRT_GIC_VERSION_4:
+    case VIRT_GIC_VERSION_5:
         break;
     }
 
@@ -2451,6 +2522,12 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
             exit(1);
         }
         break;
+    case VIRT_GIC_VERSION_5:
+        if (!(gics_supported & VIRT_GIC_VERSION_5_MASK)) {
+            error_report("%s does not support GICv5 emulation", accel_name);
+            exit(1);
+        }
+        break;
     default:
         error_report("logic error in finalize_gic_version");
         exit(1);
@@ -2510,6 +2587,10 @@ static void finalize_gic_version(VirtMachineState *vms)
                 gics_supported |= VIRT_GIC_VERSION_4_MASK;
             }
         }
+        if (!hvf_enabled() && module_object_class_by_name("arm-gicv5")) {
+            /* HVF doesn't have GICv5 support */
+            gics_supported |= VIRT_GIC_VERSION_5_MASK;
+        }
     } else {
         error_report("Unsupported accelerator, can not determine GIC support");
         exit(1);
@@ -2545,6 +2626,9 @@ static void finalize_msi_controller(VirtMachineState *vms)
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         }  else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        } else if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            /* GICv5 ITS is not yet implemented */
+            vms->msi_controller = VIRT_MSI_CTRL_NONE;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2560,6 +2644,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
             error_report("GICv2 + ITS is an invalid configuration.");
             exit(1);
         }
+        if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            error_report("GICv5 + ITS is not yet implemented.");
+            exit(1);
+        }
         if (whpx_enabled()) {
             error_report("ITS not supported on WHPX.");
             exit(1);
@@ -2736,6 +2824,13 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
         virt_max_cpus = GIC_NCPU;
+    } else if (vms->gic_version == VIRT_GIC_VERSION_5) {
+        /*
+         * GICv5 imposes no CPU limit beyond the 16-bit IAFFID field.
+         * The maximum number of CPUs will be limited not by this, but
+         * by the MachineClass::max_cpus value we set earlier.
+         */
+        virt_max_cpus = 1 << QEMU_GICV5_IAFFID_BITS;
     } else {
         virt_max_cpus = virt_redist_capacity(vms, VIRT_GIC_REDIST);
         if (vms->highmem_redists) {
@@ -2782,6 +2877,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if ((vms->virt || vms->secure) &&
+        vms->gic_version == VIRT_GIC_VERSION_5) {
+        error_report("mach-virt: GICv5 currently supports EL1 only");
+        exit(1);
+    }
+
     create_fdt(vms);
 
     assert(possible_cpus->len == max_cpus);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b74ffada7e..3ba33b4bd2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -66,6 +66,18 @@ enum {
     VIRT_GIC_VCPU,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
+    VIRT_GICV5_IRS_S,
+    VIRT_GICV5_IRS_NS,
+    VIRT_GICV5_IRS_EL3,
+    VIRT_GICV5_IRS_REALM,
+    VIRT_GICV5_ITS_S,
+    VIRT_GICV5_ITS_NS,
+    VIRT_GICV5_ITS_EL3,
+    VIRT_GICV5_ITS_REALM,
+    VIRT_GICV5_ITS_TR_S,
+    VIRT_GICV5_ITS_TR_NS,
+    VIRT_GICV5_ITS_TR_EL3,
+    VIRT_GICV5_ITS_TR_REALM,
     VIRT_SMMU,
     VIRT_UART0,
     VIRT_MMIO,
@@ -119,12 +131,14 @@ typedef enum VirtGICType {
     VIRT_GIC_VERSION_2 = 2,
     VIRT_GIC_VERSION_3 = 3,
     VIRT_GIC_VERSION_4 = 4,
+    VIRT_GIC_VERSION_5 = 5,
     VIRT_GIC_VERSION_NOSEL,
 } VirtGICType;
 
 #define VIRT_GIC_VERSION_2_MASK BIT(VIRT_GIC_VERSION_2)
 #define VIRT_GIC_VERSION_3_MASK BIT(VIRT_GIC_VERSION_3)
 #define VIRT_GIC_VERSION_4_MASK BIT(VIRT_GIC_VERSION_4)
+#define VIRT_GIC_VERSION_5_MASK BIT(VIRT_GIC_VERSION_5)
 
 struct VirtMachineClass {
     MachineClass parent;
-- 
2.43.0


