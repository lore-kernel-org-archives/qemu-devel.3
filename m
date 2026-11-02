Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2392606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CLzBlXE2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDR-00047k-Ui; Mon, 02 Nov 2026 08:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD7-0003KV-87
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:32 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD4-0002JE-DT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:28 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so32310985e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626585; x=1794231385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R6+J12izgwW3WpIOqbuLUIdCgWC94kD4XMwa574zXDA=;
 b=CLzBlXE2BC5uOc7VoxkgnNfmzo2l65BVQoiMOxA/kl4v5gtM+wvVJ3NOuM1bl7eJqf
 jGMllfB8lzLFx67X0jEDEIttecC7YbDp/sgeoEoziH0/cB03UUcvKgxZ/BplLz+i5tE/
 A4aMiTGXLO9T8LTZpIjmdcW8W6PhZaeWFW6SrRAys/7TvCcxC1GM5L68KMb8qXBSzqKc
 dTUbFdO/j8IKVFAkkVqA9nB/U7Eh6EpmWuTOE3nd0iyha42TI8Sdkh3j7i209VEyriC0
 iY3KYPePtIVgISZQSLYp9bINw9fdu209VH7Ja8UAFgFtiyy/SB6PXdtxql4nIscVJyRV
 zmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626585; x=1794231385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=R6+J12izgwW3WpIOqbuLUIdCgWC94kD4XMwa574zXDA=;
 b=uSvJ60nuL9Y565xOy1T5EVIxlS4wjHnFf/cnDOFE9V+KPBSNPtTA5LiopTUF+hcPjH
 34RHX5L94rBDxn6fPRhTRokjmY4jxnI+qnGUVZ5aEQNqJ3lNUNUTPZBQyPa/QPPi2dYl
 XkiKjH5ZbAozYC7z93kX8R5b1QThbfcpQfW95+59i7yBI7/iNgM/W2TNykz5wPhyqq6q
 W5JRSfVklHsPJYE4yztQxiIxeELmarXzcW7ubGlnDVDDn48UvlvoFZbNL4OOK2SK+atN
 IXTtLjs/bUs6/wbaqvDpQEuNTJGgspVvI4poLZrbnch/MrDZ8oRK8Hjn0b5mA7jO0rer
 wgSw==
X-Gm-Message-State: AFq9FYJxLq1IagF8tW0uardk39gEaB9AqjbBLzaLOV8cFLPu4Wcdb71T
 ssZu7zIaySYAOO16nz3BtdJj7pKH5oAsG+Mf6DtavRf18/zqe1ZmrkcId6xpVx15vy5llgG3lol
 R86ODUGA=
X-Gm-Gg: AYBFou1WdiRPIfPt2l58VEOjFODJf7iQzdhdJIzB1Op97XpstBirb9AioKGilOe1gBq
 puim+Sxqeg6E+jzg8fOE8PnDdAdgjWyPu7PCgct9gup/jKMEg0JvfN9+KRx/ien4Jf28hT2GKjN
 cg09LJK5JrIAABNrvYedwOqTOZa4rNxps9QQRUbOgmtkLz/bxcn6sybuAvtQuItAmlv6CcpNqM6
 H51zY9sP2yPrlwn96N4DOVoTEZh1pLm4bzE9jJ1jTq65b9fp7wXlytdkN64tsfpeVJfcF0frXwI
 hsV6B+XqgCl3Yfo/IAJC8aAUQNnth4vOEv0GFSOki2R8kmk0YortJXba75DLxclWHwDPgeT2ZHC
 OD0ggho3up9GPzAftY1x98TT93iN16KpJA6X69nkbtnupj3HkekL2aTT4BSloQ+711/ciLF5WYP
 dEkQ9rri/pIPMsaVbGwA1w6YtXDCZ9o05bxsDtQNRmdj5ixHQ8NA0VkXkjD50Cx8Gw1FC+hCHY5
 CHiYeuStx40YLCQeySvHc9N3CUe5Gcp4nX/QHSL6QD46qVKSIksXjv0SU9Oa0FiV31TGaLCvw6W
 u9JhBnwACZhYto56axzCFnHJ+25kkwHk8iwOKLr9wG6aC/BjK6cIl7nPn75Zy7M7HRlOx/xjJVF
 WGRqVRMUJmKawSluIqBE=
X-Received: by 2002:a05:600c:34cf:b0:4a2:fe3:121b with SMTP id
 5b1f17b1804b1-4ac18d68ba0mr209145005e9.28.1793626584822; 
 Mon, 02 Nov 2026 05:36:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/47] target/kvm: Pass an Error handle to kvm_arch_init_vcpu
Date: Mon,  2 Nov 2026 13:35:31 +0000
Message-ID: <20261102133547.1375701-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

The 2 callers of kvm_arch_init_vcpu(), namely kvm_rebind_vcpus()
and kvm_init_vcpu() are passed an Error handle. So it is a pity
not using it in kvm_arch_init_vcpu(). Also, in the future, the
error handle could be passed to other functions called inside.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Message-id: 20261030131406.461599-7-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/kvm.h       |  2 +-
 accel/kvm/kvm-all.c        | 15 +++++++--------
 target/arm/kvm.c           | 26 +++++++++++++-------------
 target/i386/kvm/kvm.c      | 22 ++++++++++++----------
 target/loongarch/kvm/kvm.c | 27 +++++++++------------------
 target/ppc/kvm.c           | 10 +++++++---
 target/riscv/kvm/kvm-cpu.c |  6 +++++-
 target/s390x/kvm/kvm.c     |  2 +-
 8 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index d29624034cb..26d55cc699c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -358,7 +358,7 @@ int kvm_arch_get_default_type(MachineState *ms);
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
-int kvm_arch_init_vcpu(CPUState *cpu);
+int kvm_arch_init_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
 #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db8fba53f33..ddc82f9775c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -504,11 +504,11 @@ static int kvm_rebind_vcpus(Error **errp)
             }
         }
 
-        ret = kvm_arch_init_vcpu(cpu);
+        ret = kvm_arch_init_vcpu(cpu, errp);
         if (ret < 0) {
-            error_setg_errno(errp, -ret,
-                             "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
-                             vcpu_id);
+            error_prepend(errp,
+                          "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
+                          vcpu_id);
         }
 
         close(cpu->kvm_vcpu_stats_fd);
@@ -751,11 +751,10 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
         }
     }
 
-    ret = kvm_arch_init_vcpu(cpu);
+    ret = kvm_arch_init_vcpu(cpu, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
-                         kvm_arch_vcpu_id(cpu));
+        error_prepend(errp, "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
+                      kvm_arch_vcpu_id(cpu));
     }
     cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 76b3996d3b5..86a4d2a6b1c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2008,17 +2008,16 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
 {
     int ret;
     uint64_t mpidr;
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    Error *local_err = NULL;
     uint64_t psciver;
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
-        error_report("KVM is not supported for this guest CPU type");
+        error_setg(errp, "KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
 
@@ -2064,16 +2063,19 @@ int kvm_arch_init_vcpu(CPUState *cs)
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
+        error_setg_errno(errp, -ret, "failed kvm_arm_vcpu_init");
         return ret;
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
+            error_setg_errno(errp, -ret, "failed kvm_arm_sve_set_vls");
             return ret;
         }
         ret = kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);
         if (ret) {
+            error_setg_errno(errp, -ret, "failed kvm_arm_vcpu_finalize");
             return ret;
         }
     }
@@ -2082,11 +2084,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         psciver = cpu->psci_version;
         ret = kvm_set_one_reg(cs, KVM_REG_ARM_PSCI_VERSION, &psciver);
         if (ret) {
-            error_report("KVM in this kernel does not support PSCI version %d.%d",
-                         (int) PSCI_VERSION_MAJOR(psciver),
-                         (int) PSCI_VERSION_MINOR(psciver));
-            error_printf("Consider setting the kvm-psci-version property on the "
-                         "migration source.\n");
+            error_setg_errno(errp, -ret,
+                             "KVM in this kernel does not support PSCI version %d.%d",
+                             (int) PSCI_VERSION_MAJOR(psciver),
+                             (int) PSCI_VERSION_MINOR(psciver));
+            error_append_hint(errp, "Consider setting the kvm-psci-version property "
+                              "on the migration source.\n");
             return ret;
         }
     }
@@ -2108,16 +2111,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
      */
     ret = kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MPIDR), &mpidr);
     if (ret) {
+        error_setg_errno(errp, -ret, "failed retrieving MPIDR value");
         return ret;
     }
     SET_IDREG(&cpu->isar, MPIDR, mpidr);
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    ret = kvm_arm_init_cpreg_list(cpu, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
-    return ret;
+    return kvm_arm_init_cpreg_list(cpu, errp);
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 072da8b9f12..3cbaee700bd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2218,7 +2218,7 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
     }
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
 {
     struct {
         struct kvm_cpuid2 cpuid;
@@ -2240,12 +2240,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     int kvm_base = KVM_CPUID_SIGNATURE;
     int max_nested_state_len;
     int r;
-    Error *local_err = NULL;
 
     if (current_machine->cgs) {
         r = x86_confidential_guest_check_features(
                 X86_CONFIDENTIAL_GUEST(current_machine->cgs), cs);
         if (r < 0) {
+            error_setg(errp, "failed x86_confidential_guest_check_features (%d)", r);
             return r;
         }
     }
@@ -2258,6 +2258,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     r = kvm_arch_set_tsc_khz(cs);
     if (r < 0) {
+        error_setg(errp, "failed setting tsc_khz (%d)", r);
         return r;
     }
 
@@ -2285,14 +2286,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
      * can still proceed and check/expand Hyper-V enlightenments here so legacy
      * behavior is preserved.
      */
-    if (!kvm_hyperv_expand_features(cpu, &local_err)) {
-        error_report_err(local_err);
+    if (!kvm_hyperv_expand_features(cpu, errp)) {
         return -ENOSYS;
     }
 
     if (hyperv_enabled(cpu)) {
         r = hyperv_init_vcpu(cpu);
         if (r) {
+            error_setg_errno(errp, -r, "failed hyperv_init_vcpu");
             return r;
         }
 
@@ -2371,6 +2372,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
         r = kvm_xen_init_vcpu(cs);
         if (r) {
+            error_setg_errno(errp, -r, "failed kvm_xen_init_vcpu");
             return r;
         }
 
@@ -2419,12 +2421,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
         ret = kvm_get_mce_cap_supported(cs->kvm_state, &mcg_cap, &banks);
         if (ret < 0) {
-            fprintf(stderr, "kvm_get_mce_cap_supported: %s", strerror(-ret));
+            error_setg_errno(errp, -ret, "failed kvm_get_mce_cap_supported");
             return ret;
         }
 
         if (banks < (env->mcg_cap & MCG_CAP_BANKS_MASK)) {
-            error_report("kvm: Unsupported MCE bank count (QEMU = %d, KVM = %d)",
+            error_setg(errp, "kvm: Unsupported MCE bank count (QEMU = %d, KVM = %d)",
                          (int)(env->mcg_cap & MCG_CAP_BANKS_MASK), banks);
             return -ENOTSUP;
         }
@@ -2432,7 +2434,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         unsupported_caps = env->mcg_cap & ~(mcg_cap | MCG_CAP_BANKS_MASK);
         if (unsupported_caps) {
             if (unsupported_caps & MCG_LMCE_P) {
-                error_report("kvm: LMCE not supported");
+                error_setg(errp, "kvm: LMCE not supported");
                 return -ENOTSUP;
             }
             warn_report("Unsupported MCG_CAP bits: 0x%" PRIx64,
@@ -2442,7 +2444,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         env->mcg_cap &= mcg_cap | MCG_CAP_BANKS_MASK;
         ret = kvm_vcpu_ioctl(cs, KVM_X86_SETUP_MCE, &env->mcg_cap);
         if (ret < 0) {
-            fprintf(stderr, "KVM_X86_SETUP_MCE: %s", strerror(-ret));
+            error_setg_errno(errp, -ret, "failed KVM_X86_SETUP_MCE");
             return ret;
         }
     }
@@ -2470,9 +2472,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
             error_setg(&invtsc_mig_blocker,
                        "State blocked by non-migratable CPU device"
                        " (invtsc flag)");
-            r = migrate_add_blocker(&invtsc_mig_blocker, &local_err);
+            r = migrate_add_blocker(&invtsc_mig_blocker, errp);
             if (r < 0) {
-                error_report_err(local_err);
                 return r;
             }
         }
@@ -2501,6 +2502,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_data.cpuid.padding = 0;
     r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
     if (r) {
+        error_setg_errno(errp, -r, "failed KVM_SET_CPUID2");
         goto fail;
     }
     kvm_init_xsave(env);
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 7ca95181a18..db39267375f 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1320,11 +1320,10 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
 {
     uint64_t val;
     int ret;
-    Error *local_err = NULL;
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
 
     cpu->vmsentry = qemu_add_vm_change_state_handler(
@@ -1334,51 +1333,43 @@ int kvm_arch_init_vcpu(CPUState *cs)
         brk_insn = val;
     }
 
-    ret = kvm_cpu_check_lsx(cs, &local_err);
+    ret = kvm_cpu_check_lsx(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
-    ret = kvm_cpu_check_lasx(cs, &local_err);
+    ret = kvm_cpu_check_lasx(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
-    ret = kvm_cpu_check_lbt(cs, &local_err);
+    ret = kvm_cpu_check_lbt(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
-    ret = kvm_cpu_check_pmu(cs, &local_err);
+    ret = kvm_cpu_check_pmu(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
-    ret = kvm_cpu_check_pv_features(cs, &local_err);
+    ret = kvm_cpu_check_pv_features(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
-    ret = kvm_cpu_check_ptw(cs, &local_err);
+    ret = kvm_cpu_check_ptw(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
-    ret = kvm_cpu_check_msgint(cs, &local_err);
+    ret = kvm_cpu_check_msgint(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
-    ret = kvm_cpu_check_misc_v1_1(cs, &local_err);
+    ret = kvm_cpu_check_misc_v1_1(cs, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8e89a6c665c..cd19f7a6fd9 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -484,7 +484,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *cenv = &cpu->env;
@@ -493,9 +493,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     /* Synchronize sregs with kvm */
     ret = kvm_arch_sync_sregs(cpu);
     if (ret) {
+        error_setg_errno(errp, -ret, "Register sync failed");
         if (ret == -EINVAL) {
-            error_report("Register sync failed... If you're using kvm-hv.ko,"
-                         " only \"-cpu host\" is possible");
+            error_append_hint(errp, "If you're using kvm-hv.ko,"
+                              " only \"-cpu host\" is possible\n");
         }
         return ret;
     }
@@ -504,6 +505,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     case POWERPC_MMU_BOOKE206:
         /* This target supports access to KVM's guest TLB */
         ret = kvm_booke206_tlb_init(cpu);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed kvm_booke206_tlb_init");
+        }
         break;
     case POWERPC_MMU_2_07:
         if (!cap_htm && !kvmppc_is_pr(cs->kvm_state)) {
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5a82a63b822..523b515f2aa 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1605,7 +1605,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
 {
     int ret = 0;
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -1615,6 +1615,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
         ret = kvm_vcpu_set_machine_ids(cpu, cs);
         if (ret != 0) {
+            error_setg_errno(errp, -ret, "failed setting machine id");
             return ret;
         }
     }
@@ -1623,6 +1624,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     kvm_riscv_update_cpu_cfg_isa_ext(cpu, cs);
 
     ret = kvm_vcpu_enable_sbi_dbcn(cpu, cs);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "failed kvm_vcpu_enable_sbi_dbcn");
+    }
 
     return ret;
 }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index dc67e848864..76dd1e67c01 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -403,7 +403,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs)
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     S390CPU *cpu = S390_CPU(cs);
-- 
2.43.0


