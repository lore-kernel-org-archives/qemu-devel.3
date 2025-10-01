Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D71CAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGQ-0005ij-KH; Tue, 30 Sep 2025 21:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFw-0005Tt-40
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFF-0008Bc-2T
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so65872745e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280575; x=1759885375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7h307QOx44Ki9SH92ohHJPER/ZS3m1zJos18uaOTvw0=;
 b=C6QyghUrCxfJ+KRNmYgHfY+dcYHY7SAjydkStHZg5q7TQJWhfaKqBJUZkCk2+jqemb
 xWONMyeZMz8np6A2l6cHc9y2kc3vhARRLm02uk/z9/g1eJm0xe7gPuairKURQUWEqqj8
 Ui4ujIa2StkQweL/OVzKtkxSQOUlY9vGC6RWEA4thzgiBmgvvDX+S5OrZbQ1FlsAGpt5
 EaT7ToL+KGnV8bCUmxoZD17DzE7pxlpqntl2ouSvb8lIMByyh4xQANZStIg7wOIB8TBd
 CgaJ8kK8UM7DKhBt31oiwxg4ArtbS8UW3YsTtGxtUpg/NLg7Fx7vj8BXwKrMqmKv37yL
 f4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280575; x=1759885375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7h307QOx44Ki9SH92ohHJPER/ZS3m1zJos18uaOTvw0=;
 b=kqoL4aMSgHSMC+YYMBFWv4KxIB5qCCwv25FFKLC1P61tnNMUVoLT8I8QegHNusI/t7
 wVc87Q+/o2xQYDXQfzpGvpD5R30KfNKDXgZQ55/CM7XAP5jBH7pz3XsQUhDvk9lLalhY
 IDJ1EIW076qQRkxrkaWTDp+w/D91gKbuwWJaWlwqRrI5vP6Qp1Ij6bLLzTVxZQuxXiVX
 dD1j26fq5hS9V5LFHcVAEAle8B0osfouaBK8tjZQYYVdoP1F3jNu22hSK9UOgr7iSqWJ
 kWly3WIcZiitryzUziQp6bnaMoljhkknhAvo4mJ93oA/YKLKhYKkGe74yurrpvFH7kYQ
 gwMA==
X-Gm-Message-State: AOJu0YzYCsrQn6wXodafiYSgmtsN0x6I0KsZ+ie5aPD67KIH+1i6KjWd
 S0gCb6e0LMtxIDgHMPrChJMRYwJtvdmpnIY7RD5FqENu8SCYu2Dd6lukmOW0MOnYRIOSmBNjhNr
 obvlJF/TMcg==
X-Gm-Gg: ASbGnct1kFxyWLfbbA2X34frtKftbJ+W7kx9H5orjB4VZm9mm3fwBa0ZLBJ03LDEpOA
 piiyoKh2cosWIcP9v6PyMPZLijxFZWnpMEk69X+DyPcKsAOpOU9/mZMHr40jvxKkdKiLujgpXln
 LNmVjuJDktu8caETZTsGjrXQHxSabI6iwXshVPjvQPH2dy4e7Gy2yeVmNzDs2BfbFBZUUsl03uT
 FIMQ5+u3mLoBxuZNfE9RzWC2lgam3sgNqsP1OV0koSPRO19Ty3LbTvLt6uZZwW6TvCVBD8+nvrk
 oFE3l5kkYD4fsoccp25mV1548trODb06rBVlbTWJR7PIUyB6xOYlta5Vo2Ab7/DjthCtpSKsdrF
 pnSPD4BLJDZkmNSSf6oCFXcBVAWBBlYR1rWcLV1Bhx+5FNIwaqbzyFoHH8rCMrh+2VW0pryVsyl
 dQaJX8aj2gNGYZY5uVQ21Go2pA8MX/mh++BOcvXeeEsfM=
X-Google-Smtp-Source: AGHT+IEnY0uugUJqIG/xkP/LpPRxljbK0+8Z0BcVIT+7ekPwlS5/mNaj9Fu6cCj6dxs1BSLKaSxR2g==
X-Received: by 2002:a05:6000:26c3:b0:3eb:5e99:cbd3 with SMTP id
 ffacd0b85a97d-425577ed539mr1014530f8f.2.1759280574636; 
 Tue, 30 Sep 2025 18:02:54 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:54 -0700 (PDT)
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
Subject: [PATCH RFC V6 18/24] target/arm/kvm,
 tcg: Handle SMCCC hypercall exits in VMM during PSCI_CPU_{ON, OFF}
Date: Wed,  1 Oct 2025 01:01:21 +0000
Message-Id: <20251001010127.3092631-19-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Author Salil Mehta <salil.mehta@huawei.com>

To support vCPU hotplug-like feature, we must trap any `HVC`/`SMC`
`PSCI_CPU_{ON,OFF}` hypercalls from the host KVM to QEMU for policy checks. This
ensures the following when a vCPU is brought online:

1. The vCPU is actually plugged in (i.e., present).
2. The vCPU is not administratively disabled. (Policy Checks)

Implement the registration and handling of `HVC`/`SMC` hypercall exits within
the VMM, ensuring that proper policy checks and control flow are enforced during
the vCPU onlining and offlining processes.

Co-developed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/arm-powerctl.c   | 27 ++++++++---
 target/arm/helper.c         |  2 +-
 target/arm/internals.h      |  2 +-
 target/arm/kvm.c            | 93 +++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h        | 14 ++++++
 target/arm/meson.build      |  1 +
 target/arm/{tcg => }/psci.c |  9 ++++
 target/arm/tcg/meson.build  |  4 --
 8 files changed, 139 insertions(+), 13 deletions(-)
 rename target/arm/{tcg => }/psci.c (96%)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 20c70c7d6b..ab4422b261 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -17,6 +17,7 @@
 #include "qemu/main-loop.h"
 #include "system/tcg.h"
 #include "target/arm/multiprocessing.h"
+#include "hw/boards.h"
 
 #ifndef DEBUG_ARM_POWERCTL
 #define DEBUG_ARM_POWERCTL 0
@@ -31,14 +32,17 @@
 
 CPUState *arm_get_cpu_by_id(uint64_t id)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cpu;
 
     DPRINTF("cpu %" PRId64 "\n", id);
 
-    CPU_FOREACH(cpu) {
-        ARMCPU *armcpu = ARM_CPU(cpu);
-
-        if (arm_cpu_mp_affinity(armcpu) == id) {
+    /*
+     * with vCPU standy/hotplug support, we must now check for all
+     * possible vCPUs
+     */
+    CPU_FOREACH_POSSIBLE(cpu, ms->possible_cpus) {
+        if (cpu && (arm_cpu_mp_affinity(ARM_CPU(cpu)) == id)) {
             return cpu;
         }
     }
@@ -119,9 +123,18 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
 
     /* Retrieve the cpu we are powering up */
     target_cpu_state = arm_get_cpu_by_id(cpuid);
-    if (!target_cpu_state) {
-        /* The cpu was not found */
-        return QEMU_ARM_POWERCTL_INVALID_PARAM;
+
+    /* Policy check: verify 'administrative' power state of target CPU */
+    if (!target_cpu_state || !qdev_check_enabled(DEVICE(target_cpu_state))) {
+        /*
+         * The cpu is not plugged in or disabled. We should return appropriate
+         * value as introduced in DEN0022E PSCI 1.2 issue E
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[ARM]%s: Denying attempt to online ACPI disabled"
+                      "(_STA.Ena=0)CPU%" PRId64", needs admin action first!\n",
+                      __func__, cpuid);
+        return QEMU_ARM_POWERCTL_IS_OFF;
     }
 
     target_cpu = ARM_CPU(target_cpu_state);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c1299ff84..814fe719da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9110,7 +9110,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                       env->exception.syndrome);
     }
 
-    if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
+    if (arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
         return;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1b3d0244fd..ffd82a7ace 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -645,7 +645,7 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs);
 
-#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
+#if defined(CONFIG_USER_ONLY)
 static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
     return false;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1962eb29b2..98eb6db9ed 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -529,9 +529,51 @@ int kvm_arch_get_default_type(MachineState *ms)
     return fixed_ipa ? 0 : size;
 }
 
+static bool kvm_arm_set_vm_attr(struct kvm_device_attr *attr, const char *name)
+{
+    int err;
+
+    err = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    err = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    return true;
+}
+
+int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
+{
+    struct kvm_smccc_filter filter = {
+        .base = func,
+        .nr_functions = 1,
+        .action = faction,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VM_SMCCC_CTRL,
+        .attr = KVM_ARM_VM_SMCCC_FILTER,
+        .flags = 0,
+        .addr = (uintptr_t)&filter,
+    };
+
+    if (!kvm_arm_set_vm_attr(&attr, "SMCCC Filter")) {
+        error_report("failed to set SMCCC filter in KVM Host");
+        return -1;
+    }
+
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret = 0;
+
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -594,6 +636,22 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
+    /*
+     * To be able to handle PSCI CPU ON calls in QEMU, we need to install SMCCC
+     * filter in the Host KVM. This is required to support features like
+     * virtual CPU Hotplug on ARM platforms.
+     */
+    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN64_CPU_ON,
+                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("CPU On PSCI-to-user-space fwd filter install failed");
+        abort();
+    }
+    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN_CPU_OFF,
+                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("CPU Off PSCI-to-user-space fwd filter install failed");
+        abort();
+    }
+
     return ret;
 }
 
@@ -1440,6 +1498,38 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
     return false;
 }
 
+static int kvm_arm_handle_hypercall(CPUState *cs, struct kvm_run *run)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    kvm_cpu_synchronize_state(cs);
+
+    /*
+     * hard coding immediate to 0 as we dont expect non-zero value as of now
+     * This might change in future versions. Hence, KVM_GET_ONE_REG  could be
+     * used in such cases but it must be enhanced then only synchronize will
+     * also fetch ESR_EL2 value.
+     */
+    if (run->hypercall.flags == KVM_HYPERCALL_EXIT_SMC) {
+        cs->exception_index = EXCP_SMC;
+        env->exception.syndrome = syn_aa64_smc(0);
+    } else {
+        cs->exception_index = EXCP_HVC;
+        env->exception.syndrome = syn_aa64_hvc(0);
+    }
+    env->exception.target_el = 1;
+    bql_lock();
+    arm_cpu_do_interrupt(cs);
+    bql_unlock();
+
+    /*
+     * For PSCI, exit the kvm_run loop and process the work. Especially
+     * important if this was a CPU_OFF command and we can't return to the guest.
+     */
+    return EXCP_INTERRUPT;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1456,6 +1546,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_arm_handle_dabt_nisv(cpu, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
+    case KVM_EXIT_HYPERCALL:
+          ret = kvm_arm_handle_hypercall(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ec9dc95ee8..bb2dfde3af 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -216,6 +216,15 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+
+/**
+ * kvm_arm_set_smccc_filter
+ * @func: funcion
+ * @faction: SMCCC filter action(handle, deny, fwd-to-user) to be deployed
+ *
+ * Sets the ARMs SMC-CC filter in KVM Host for selective hypercall exits
+ */
+int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -242,6 +251,11 @@ static inline bool kvm_arm_el2_supported(void)
 {
     return false;
 }
+
+static inline int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
+{
+    g_assert_not_reached();
+}
 #endif
 
 /**
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 07d9271aa4..ae4e75c4a9 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,6 +15,7 @@ arm_system_ss.add(files(
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
+arm_system_ss.add(files('psci.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
diff --git a/target/arm/tcg/psci.c b/target/arm/psci.c
similarity index 96%
rename from target/arm/tcg/psci.c
rename to target/arm/psci.c
index cabed43e8a..fbd2bd2d6f 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/psci.c
@@ -21,10 +21,13 @@
 #include "exec/helper-proto.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "system/runstate.h"
+#include "system/tcg.h"
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
+#include "exec/target_long.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
@@ -158,6 +161,11 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_0_1_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN64_CPU_SUSPEND:
+       if (!tcg_enabled()) {
+            warn_report("CPU suspend not supported in non-tcg mode");
+            break;
+       }
+#ifdef CONFIG_TCG
         /* Affinity levels are not supported in QEMU */
         if (param[1] & 0xfffe0000) {
             ret = QEMU_PSCI_RET_INVALID_PARAMS;
@@ -170,6 +178,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
             env->regs[0] = 0;
         }
         helper_wfi(env, 4);
+#endif
         break;
     case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
         switch (param[1]) {
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 895facdc30..f4d8db0f79 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -49,10 +49,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(files(
-  'psci.c',
-))
-
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
-- 
2.34.1


