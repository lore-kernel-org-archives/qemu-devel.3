Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54E8CAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGz-00064U-65; Tue, 30 Sep 2025 21:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lGL-0005e5-Fa
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFN-0008DL-9m
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so41966955e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280581; x=1759885381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkorhTYVdtNEc2JK9JCYJPvsAtCb3dSBOdMaKNrFs7Y=;
 b=c/IBDRZdX2QyTxvPUieuUL1mGP6FJHpv0VtlQwU4gLSkD/DqR+0t6Du5lRGXf9MOQ3
 yQqG6W6msiTNi7HOseCvKC5qmNIhC6HC0Qfr/ywrIH9ttr7wB+BHLSjtKJqx0z6cFdWJ
 JwNRkYyDLi9vRVsJStmgErvssviuF38UaYgPU+hkOh/xZMRy4Lo2eSdO0JWMfuUtSNPP
 keP5pvwrk9WGP4i25niOj4//HhYinjoOUeqcvtQk9PMio9OEC8UdbLtIhzXtmQRi9HvI
 +/7mgRjkVj4gdwn8DUHIeefzHfhOQUYn9rH1JDTd/R7AQNHVKbrGs2bwVVFLqizsa1el
 SJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280581; x=1759885381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkorhTYVdtNEc2JK9JCYJPvsAtCb3dSBOdMaKNrFs7Y=;
 b=riRRtKeyD0PwIdYNzRRCthDA3Sk+/ZWVEEFRQ5D1ga2cDK9K68tEm3Sh43ysx9bbt6
 Mn2vD7ycBleY2IZGhagn3uI4E/5Vlp1GNVoea0jp2MjHKLcDzq/LNAylcRraJipzqtqY
 a/n2v22EMaaXMSd2GL3Jw3F0Kc7jOthx5deK2GyBSL7UAhSgGCTqmFnCi+McLvhE1T2p
 sKVW/vA9cdEYsSoOQMA2tVN99yrJFJvCTAk+sVUexblyoCCef5+nd9Zi8Qc9obBKCsbD
 RMsO+rb2Q736WIDWZaXGuQ9JLgpPoOEYoXBSYmVMlYNkmnGalgbSBcUQUtQd+cl2KqT3
 fm8A==
X-Gm-Message-State: AOJu0YwKK49XG+846LJX1+18OTpNe/g9J5DpdgDz3GEsyKRcAo/oLpkY
 +HDtrZOCF7yjgCVESWSkIXVNoQnj9JU7jwE0fLdde0FRoGkLItY3pWLOp+rbZstSb/39MpCJUeF
 l2SoaHFFOoQ==
X-Gm-Gg: ASbGncts3hxr50RuCEpthovg24x0jct3qFC2fmpSoN15cjlkHgwI7/vAtAMcQtF7Sti
 LRfwFlwzrJfsRZ7C1S58pmotBUm7fAm8dYeygxCmaU77vPzRCcUNkLOzzh8tTKPLbi+qsCiGOAR
 QAbnE607DdJDECsxtDluFyOPNMeLVh/+2U2D/4rUJm1u40ilCgH0JABaTHkJ4QoqcpVNw+WR3Dw
 4Bu1vBE0szpzaYMB9lhlZdZWkmzzf61Hbv+AQA/9gsIJq+oEjHPeEXNGME/x0CoSfmgXWuIBJgD
 tUD+9ZNJAW6yK+G1G+OBHzk1nA+FMU67a9ZRrUdLPmRxZbKev21ZdWTLUcrxeRb9vDFgGnmCfL/
 lcpE29IyYLyahzE8ry0Ny2rJptoSMUIRU0doWeNMYmnOn7SiCVT9WitMSUiT8A/OEGEs97Lk8/W
 /k5FLkfk9Xdu1DIUocWpXmSRlaJcWp2dYxMsTLaMIIYfo=
X-Google-Smtp-Source: AGHT+IGtiMfNDTwBfFlWDk5u04zD0uoanejP/L9zghp74Y9gIVBsMBao7ceLjywLt+u/Os5JnWjkgg==
X-Received: by 2002:a05:600c:198b:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-46e612e57c3mr13281575e9.36.1759280580648; 
 Tue, 30 Sep 2025 18:03:00 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:03:00 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 21/24] hw/intc/arm-gicv3-kvm: Pause all vCPUs & cache
 ICC_CTLR_EL1 for userspace PSCI CPU_ON
Date: Wed,  1 Oct 2025 01:01:24 +0000
Message-Id: <20251001010127.3092631-22-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

Problem:
=======

When PSCI CPU_ON was handled entirely in KVM, the operation executed under
VGIC/KVM locks at EL2 and appeared atomic to other vCPU threads (intermediate
states were not observable). With the SMCCC forward-to-userspace filter enabled,
PSCI ON/OFF calls now exit to QEMU, where policy checks are performed.

In the userspace CPU_ON handling (during cpu_reset?), QEMU must perform IOCTLs
to fetch ICC_CTLR_EL1 fields that reflect supported features and IRQ-related
configuration (e.g. EOImode, PMHE, CBPR). While these IOCTLs are in flight,
other vCPUs can run and cause transient inconsistency. KVM enforces atomicity by
trying to take all vCPU locks (kvm_trylock_all_vcpus() -> -EBUSY). QEMU
therefore pauses all vCPUs before issuing these IOCTLs to avoid contending for
locks and to prevent -EBUSY failures during cpu_reset.

KVM Details: (As I understand and stand ready to be corrected! :))

Userspace fetch of sysreg ICC_CTLR_EL1 results in access of ICH_VMCR_EL2 reg.
VMCR is per-vCPU and controls the CPU interface. Pending state is recorded in
the distributor for SPIs, and in each redistributor for SGIs and PPIs. Delivery
to the PE depends on the CPU interface configuration (VMCR fields such as PMR,
IGRPEN, EOImode, BPR). Updates to VMCR must therefore be applied atomically with
respect to interrupt injection and deactivation. The KVM ioctl layer first
attempts to lock all vCPU mutexes, and only then takes the VM lock before
calling vgic_v3_attr_regs_access(). This ordering serializes userspace accesses
with IRQ handling (IAR/EOI and SGI delivery?).

ICC_CTLR_EL1 initially reflects architectural defaults (e.g. EOImode, PMR).
Most fields are read-only feature indicators that never change. Writable
fields such as EOImode, PMHE and CBPR are configured once by the guest GICv3
driver and then remain pseudo-static. Both the initial defaults and the
guest-configured values can be cached and reused across resets, avoiding
repeated VM-wide pauses to fetch ICC_CTLR_EL1 from KVM on every cpu_reset().

Appendix: ICC_CTLR_EL1 layout (for reviewers)
=============================================

ICC_CTLR_EL1 [63:0]

  63                                                                        32
 +----------------------------------------------------------------------------+
 |                                   RES0                                     |
 +----------------------------------------------------------------------------+
  31        20 19 18 17 16 15 14 13 12 11 10   9   8  7  6   5  4  3  2  1  0
 +------------+--+--+--+--+--+--+--+--+--+---+---+---+--+--+--+--+--+--+--+--+
 |    RES0    |Ex|RS|RES0 |A3|SE| IDbits |  PRIbits  |R0|PM|  RES0     |EO|CB|
 +------------+--+--+--+--+--+--+--+--+--+---+---+---+--+--+--+--+--+--+--+--+
              |  |        |  |                       |   |             |  |
              |  |        |  |                       |   |             |  +CBPR
              |  |        |  |                       |   |             +EOImode
              |  |        |  |                       |   +-PMHE
              |  |        |  |                       +----RES0
              |  |        |  +--SEIS
              |  |        +-----A3V
              |  +--------------RSS
              +-----------------ExtRange

 Access: {Ex, RS, A3, SE, IDbits, PRIbits} = RO;
         {PMHE} = RW*;
         {EO, CB} = RW**;
	 others = RES0.
 Notes : * impl-def (may be RO when DS=0)
         ** CB may be RO when DS=0 (EO stays RW)

 Source: Arm GIC Architecture Specification (IHI 0069H.b),
         §12.2.6 “ICC_CTLR_EL1”, pp. 12-233…12-237

Resets that may trigger ICC_CTLR_EL1 fetch include:
  1. PSCI CPU_ON
  2. qemu_system_reset() during full VM reset
  3. Post-load path on migration
  4. Lazy realization via device_set/-deviceset

It can be expensive to pause the entire VM just to reset one vCPU, especially
for long-lived workloads where hundreds of resets may occur. For such systems,
frequent VM-wide pauses are unacceptable.

Solution:
========

This patch caches ICC_CTLR_EL1 early, seeding it either from architectural
defaults or on the first PSCI CPU_ON when the guest GICv3 driver has initialized
the interface. The cached value is then reused on every cpu_reset(), avoiding
repeated VM-wide pauses and heavy IOCTLs. The IOCTL path is retained only as a
fallback if the cached shadow is not valid.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/intc/arm_gicv3_kvm.c            | 93 ++++++++++++++++++++++++++++--
 include/hw/intc/arm_gicv3_common.h | 10 ++++
 target/arm/arm-powerctl.c          |  1 +
 target/arm/cpu.h                   |  1 +
 4 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index e97578f59a..62d6016e8a 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -27,6 +27,7 @@
 #include "qemu/module.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
+#include "system/cpus.h"
 #include "kvm_arm.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
@@ -681,13 +682,73 @@ static void kvm_arm_gicv3_get(GICv3State *s)
     }
 }
 
+/* Caller must hold the iothread (BQL). */
+static inline void
+kvm_gicc_get_cached_icc_ctlr_el1(GICv3CPUState *c, uint64_t regval[2],
+                                      bool *valid)
+{
+    const uint64_t attr = (uint64_t)KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer);
+    const int group = KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS;
+    GICv3State *s = c->gic;
+    uint64_t val = 0;
+    int ret;
+
+    assert(regval && valid);
+
+    if (*valid) {
+        /* Fast path: return cached (no vCPU pausing required). */
+        c->icc_ctlr_el1[GICV3_NS] = regval[GICV3_NS];
+        c->icc_ctlr_el1[GICV3_S] = regval[GICV3_S];
+        return;
+    }
+
+    ret = kvm_device_access(s->dev_fd, group, attr, &val, false, NULL);
+    if (ret == -EBUSY || ret == -EAGAIN) {
+        int tries;
+
+        /* One-time heavy path: avoid contention by pausing all vCPUs. */
+        pause_all_vcpus();
+        /*
+         * Even with vCPUs paused, we cannot fully rule out a non-vCPU context
+         * temporarily holding KVM vCPU mutexes; treat -EBUSY/-EAGAIN as
+         * transient and retry a few times. Final attempt aborts in-loop.
+         */
+        for (tries = 0; tries < 5; tries++) {
+            Error **errp = (tries == 4) ? &error_abort : NULL;
+
+            ret = kvm_device_access(s->dev_fd, group, attr, &val, false, errp);
+            if (!ret) {
+                break;
+            }
+            if (ret != -EBUSY && ret != -EAGAIN) {
+               error_setg_errno(&error_abort, -ret,
+                                "KVM_GET_DEVICE_ATTR failed: Group %d "
+                                "attr 0x%016" PRIx64, group, attr);
+               /* not reached */
+            }
+            g_usleep(50);
+        }
+        resume_all_vcpus();
+    }
+
+    /* Success: publish and seed cache. */
+    c->icc_ctlr_el1[GICV3_NS] = val;
+    c->icc_ctlr_el1[GICV3_S] = val;
+
+    regval[GICV3_NS] = c->icc_ctlr_el1[GICV3_NS];
+    regval[GICV3_S] = c->icc_ctlr_el1[GICV3_S];
+    *valid = true;
+}
+
 static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3State *s;
     GICv3CPUState *c;
+    ARMCPU *cpu;
 
     c = (GICv3CPUState *)env->gicv3state;
     s = c->gic;
+    cpu = ARM_CPU(c->cpu);
 
     c->icc_pmr_el1 = 0;
     /*
@@ -713,11 +774,33 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 
     /* Initialize to actual HW supported configuration */
-    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
-                      KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
-                      &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
-
-    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
+    /*
+     * Avoid racy VGIC CPU sysreg reads while vCPUs are running. KVM requires
+     * pausing all vCPUs for ICC_* sysregs accesses to prevent races with
+     * in-flight IRQ delivery (e.g. EOImode etc.).
+     *
+     * To keep the reset path fast, cache the architectural default and the
+     * guest GICv3 driver configured ICC_CTLR_EL1 on the first access and then
+     * reuse that for subsequent resets. Most fields in this register are
+     * invariants throughout the life of VM. Fields EOImode, PMHE and CBPR are
+     * pseudo static and dont change once configured by guest driver.
+     */
+    if (cpu->first_psci_on_request_seen || s->guest_gicc_initialized) {
+        if (!s->guest_gicc_initialized) {
+            s->guest_gicc_initialized = true;
+        }
+        kvm_gicc_get_cached_icc_ctlr_el1(c, c->icc_ctlr_configured,
+                                         &c->icc_ctlr_configured_valid);
+    } else {
+        /*
+         * kernel has not loded yet. It safe to assume not other vCPU is in
+         * KVM_RUN except vCPU 0 at this moment. Just in case, if there is
+         * other priviledged context of KVM accessing the register then we
+         * KVM device access can potentially return -EBUSY.
+         */
+        kvm_gicc_get_cached_icc_ctlr_el1(c, c->icc_ctlr_arch_def,
+                                         &c->icc_ctlr_arch_def_valid);
+    }
 }
 
 static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index a8a84c4687..0282a94edc 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -165,6 +165,15 @@ struct GICv3CPUState {
     uint64_t icc_apr[3][4];
     uint64_t icc_igrpen[3];
     uint64_t icc_ctlr_el3;
+    /*
+     * Shadow copy of ICC_CTLR_EL1 architectural default. Fetched once per-vCPU
+     * when no vCPUs are running, and reused on reset to avoid calling
+     * kvm_device_access() in the hot path.
+     */
+    uint64_t icc_ctlr_arch_def[2]; /* per-secstate (NS=0,S=1) */
+    bool icc_ctlr_arch_def_valid;
+    uint64_t icc_ctlr_configured[2];
+    bool icc_ctlr_configured_valid;
     bool gicc_accessible;
 
     /* Virtualization control interface */
@@ -240,6 +249,7 @@ struct GICv3State {
     bool force_8bit_prio;
     bool irq_reset_nonsecure;
     bool gicd_no_migration_shift_bug;
+    bool guest_gicc_initialized;
 
     int dev_fd; /* kvm device fd if backed by kvm vgic support */
     Error *migration_blocker;
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 89074918a9..0b65898cec 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -68,6 +68,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
     ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
     struct CpuOnInfo *info = (struct CpuOnInfo *) data.host_ptr;
 
+    target_cpu->first_psci_on_request_seen = true;
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
     arm_emulate_firmware_reset(target_cpu_state, info->target_el);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cd5982d362..603e482b3a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -974,6 +974,7 @@ struct ArchCPU {
 
     /* Current power state, access guarded by BQL */
     ARMPSCIState power_state;
+    bool first_psci_on_request_seen;
 
     /* CPU has virtualization extension */
     bool has_el2;
-- 
2.34.1


