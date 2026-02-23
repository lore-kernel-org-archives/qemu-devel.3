Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15C3EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZMr-0005l9-4y; Mon, 23 Feb 2026 12:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLE-0002vg-7Y
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL9-0000SU-D4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837634de51so20468495e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866200; x=1772471000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W+SiJjnlnmDMFokE5A1Qunqp4HakTLA2MrS0hcnraE4=;
 b=CR7cJ1/LuPvzRnF2+2QEsFjnf5wvZqHNlHNTFHrjrvlChkQzveK0399aAa7XVGSv4w
 q+SY8y+FzMdC7jcuMq+NB6P5xj4xhNDkGqRFB8SbDY+ufSCKRvZ3YK+KvcJRf1+C7pBJ
 EVjFcLSo8vB/NJhABAiSM6TCiEJNWXyzXthwvd2phSLq+jPd9mGmIhz76kZjtMHifzz5
 FvG8OITcvb+fxATLSil4zOQDeUgcaMIerfanUBtR4GOwKePysLjTFef62kU9CEIk6oaA
 2YQLfZ16EDTTuLv5t7axkOckUcmTYa9PUpjDjKP8iUa2O3c7VZFJYgAMpKITrJNpT4ce
 J/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866200; x=1772471000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W+SiJjnlnmDMFokE5A1Qunqp4HakTLA2MrS0hcnraE4=;
 b=CeAIrBl5AkBWogGO8Vr0nY8JQxVPB0f5+mfjQj2Uigaq3VJ1CUQktV+xC47WspGmgx
 YRKrWUMkJ7LYJWQUnY7fgavq79PWSkWk3BpZaGeoZCnrwklV5AGN6hze+fhf++z0QAIk
 4UIXHupu6kguZH/rex+/zqji1HwASKDGYfulvEWshu45xeWX/p0fX3bR+7FjtWnKSaAE
 ODYEWUSdTnX/QYhZlpweV9qC2sTFpqDaxKtI3c92HVmtwvPY8LHbUZq3sl5ZQURtCtyP
 i0LgVrZYHE3+dcWYvnrNCIZ5zPJp5BpUmzZe+kByIN+bALhJYnMZHvyUZ5zPoLBM3Q7n
 BdmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMnq14ikJ2z3VPR1cCj4pSvuLfqqmV6DQsMHHfE2FWxo5qgzI2oMgs8/fdk29WLe0ozAbPyfMWRfwH@nongnu.org
X-Gm-Message-State: AOJu0YxUqj222v1LJm5L9tysWS9WBlwYJ5LX5hHvfLULHHlf8zeIG0jn
 txU84H/Xy67z5Q7Mv3Wn8EWtC2vPEAO6LW/KSoYh5UEoCx7SkcWkD+Bkulbhykm1VTg=
X-Gm-Gg: AZuq6aKbDztmVRnKii+x+4J7/7UG+6UWRx8AH4H1dNnbXOcARjxreWmzZVdL66lBnRd
 NQ6T3yX3FzCkkrryt+ZZA6tmXexuMnNp6w6mXNSPRkhRd2H+Qu53dTcPZQltfmsvYrpp61hr2dl
 Oj83GGRQCf4bvOL+S0DgFAShtVa1AMVjVfLmyxei5OzH2G0bTN1AGxUSR0yaX6GeDJ2SQu11dGN
 Ud3K2AaJhH+3irM45n2HUI7ljRmKlnlv6z1gbCGknMfn52hFfNSlRGX+qjT6sH91SdavRKP50LH
 0L6IB7GJspXcxO1OFfH1cCAlPbvZ9744Mi8YolQpFqrHK7d9jrWoK1s/1n24sqTQYTJQ99T9h0a
 HT6BWEq8u82msjRs+N7X29BhcprvMP6VgdQcdsyW9Vd90i9QVmR74ug1SY6rZA53NEhhvY78yyk
 BSSXUnFNKkNV3WHQ7nPngbrzSzCQSLb3UmvhT7h2F8HSQ6167mlUxeZWm9yAyndroubB5ADzPug
 B18DFRXKyjnAoE5bK6ws4NKOE/Igpo=
X-Received: by 2002:a05:600c:8b16:b0:480:68ed:1e70 with SMTP id
 5b1f17b1804b1-483a963de73mr209947465e9.35.1771866200213; 
 Mon, 23 Feb 2026 09:03:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 60/65] hw/arm/virt: Create and connect GICv5
Date: Mon, 23 Feb 2026 17:02:07 +0000
Message-ID: <20260223170212.441276-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
---
 hw/arm/virt.c         | 101 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  14 ++++++
 2 files changed, 115 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3d19eb0fee..a9addf5ac0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -69,6 +69,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/intc/arm_gicv5_common.h"
 #include "hw/core/irq.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
@@ -185,6 +186,19 @@ static const MemMapEntry base_memmap[] = {
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
@@ -781,6 +795,49 @@ static void create_v2m(VirtMachineState *vms)
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
+    object_property_set_link(OBJECT(vms->gic), "sysmem",
+                             OBJECT(mem), &error_fatal);
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
@@ -994,6 +1051,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     case VIRT_GIC_VERSION_4:
         create_gicv3(vms, mem);
         break;
+    case VIRT_GIC_VERSION_5:
+        create_gicv5(vms, mem);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1929,6 +1989,11 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
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
@@ -2074,6 +2139,11 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
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
@@ -2102,6 +2172,7 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
     case VIRT_GIC_VERSION_2:
     case VIRT_GIC_VERSION_3:
     case VIRT_GIC_VERSION_4:
+    case VIRT_GIC_VERSION_5:
         break;
     }
 
@@ -2126,6 +2197,12 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
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
@@ -2177,6 +2254,10 @@ static void finalize_gic_version(VirtMachineState *vms)
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
@@ -2210,6 +2291,9 @@ static void finalize_msi_controller(VirtMachineState *vms)
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else if (whpx_enabled()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        } else if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            /* GICv5 ITS is not yet implemented */
+            vms->msi_controller = VIRT_MSI_CTRL_NONE;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2225,6 +2309,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
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
@@ -2397,6 +2485,13 @@ static void machvirt_init(MachineState *machine)
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
@@ -2442,6 +2537,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if ((vms->virt || vms->secure) &&
+        vms->gic_version == VIRT_GIC_VERSION_5) {
+        error_report("mach-virt: GICv5 currently supports EL1 only\n");
+        exit(1);
+    }
+
     create_fdt(vms);
 
     assert(possible_cpus->len == max_cpus);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 6b4691761e..34588747aa 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -63,6 +63,18 @@ enum {
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
@@ -116,12 +128,14 @@ typedef enum VirtGICType {
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


