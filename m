Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349C606A326
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=allelesecurity.com header.i=@allelesecurity.com header.a=rsa-sha256 header.s=google header.b=H03Y6b1q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPVcl-0006pw-Pt; Fri, 06 Nov 2026 20:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1xPVck-0006pn-OV
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 20:53:42 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1xPVch-0003CE-4G
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 20:53:42 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b300713befso10193847b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=allelesecurity.com; s=google; t=1794016415; x=1794621215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rQufxoiW6mBGjeYNxiqBhROlIjKV0eamLrpxHGbovrE=;
 b=H03Y6b1qk2K/z5Hn0KhD5H9Gf4fEarsZkr1HioJVqv90p3254xKdM7yxCSEppX47Lv
 Lc6w1vvXLKMNI4C66BzOxO5YzBeyHIgrgGa5f/7hj3gbS6at9qWr8KPp6FqNfi5LeZcF
 5KSdAujEocREA0rx7JG2zdG7ObIk64Z5IMGOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794016415; x=1794621215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQufxoiW6mBGjeYNxiqBhROlIjKV0eamLrpxHGbovrE=;
 b=T8Ww9NgW1IfrhbDC+7QW3xIMF0eybBi/L8qhM8EXLExQenZdHSUU7N8XqAoyxBPTWz
 PFGoBjgLVqoe0ueeK4cqGGazvl25BAuOIhCiJgdGutGRp0RdIrRfYhISeax/yV7GZP8K
 xmlmFcWifT11uuXc38x7wV75bT4Kdzc+lLy2O/nAoJ+lpa7Zr8f7b2/AUtLyZHfgbB+U
 XMhWgS91tSLeLMOyiS5gdh2l9noWFD7UHxvNDKsqXSp1R/hpskiruTRNfvRx+rrkyMdW
 vWBe6y5Nd1Du4SDUUJBCIbA5zGlYtADddb0xXZu7LdLcGB+6QadGJt640HbRJx337VSm
 PGbA==
X-Gm-Message-State: APuU4Z+LjUinOv8/frBTYskjekG5Hlj41IT05iV3lSmXXgWKQdZgoZnA
 XY8RbD2uhoMOmjHxoduXM3APdRCteHr7NCRjhwvcZ3FxCZHqEqecLkLVUAk3Xr9mrfMDY8sNhYh
 3+ils2Y4=
X-Gm-Gg: AYBFou1gfTfmCe8GM4D6lH+ZbrJOSShkTjlEEG1G9uLW+hZ+49mnO0vtzXZfvRkF+bs
 vRnJBLx7peK02BgtuBNrb0nM95iwK08sR4qjbeT2L+sv8pmO26PxQ6xtkhoFEUdMmSX7pXfilJ9
 Nc+CF2/a/856fZCPLoPK0v4xljoIvM6zHR6majXP0KYY2OhGUM68y7ObbGqyp/vPeISGehnK6ne
 7VFe1UYJQyoLNXeFn8GPWBEFXKLJk91Ejo560EoDx2/Dqvj81wyLxxpcgfHSTZoZK2T6jcJYBBY
 fbYsua5wClIgxq14Z0kWcHhqGULgG2gBTidxRHfj1kqwOmy7rmjLacGSjyMFlWVi6Z5BvTLVtIs
 U+4ZkPsY33qPq0WCapVPKJAMifNb7AXfn2yCiU/XXf0gSW3k/nlrb8AJ6Ol6p5PtLPjVoRpB5Fd
 +adEPdwbgH1sLXSyNpz3pCLbRvAMVMHrGOIZ1V5/LRHW++zwXOYL2eVmOqtU0yOha/CyHNUQB+H
 B1uvsJveqLFVFgDIV2vhGOVXkHaAnVSZzkeXaAc622LIdKWCXGH0HQdFcYAzOYjXDQ1KQ3RiNll
 +BsDVZbszS9/0KpZJam/nSUWqTecWrpEcDw4Wpxczy2XAWX9Tojj
X-Received: by 2002:a05:690c:8d0e:b0:8b3:416:b1b8 with SMTP id
 00721157ae682-8b34194a4admr22766267b3.11.1794016415117; 
 Fri, 06 Nov 2026 17:53:35 -0800 (PST)
Received: from weyl ([179.105.152.115]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b33f7fec67sm32336817b3.22.2026.11.06.17.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:53:34 -0800 (PST)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 kvm@vger.kernel.org, Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH v3] target/i386/kvm: Add APERF/MPERF MSR passthrough
Date: Fri,  6 Nov 2026 22:51:41 -0300
Message-ID: <20261107015141.473255-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=anderson@allelesecurity.com; helo=mail-yw1-x112d.google.com
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

Introduce support for exposing and enabling APERF/MPERF MSR passthrough
for x86 QEMU guests when running under KVM.

The Linux kernel supports a KVM capability, KVM_X86_DISABLE_EXITS_APERFMPERF
under KVM_CAP_X86_DISABLE_EXITS, allowing the hypervisor to disable read
intercepts on the IA32_APERF and IA32_MPERF MSRs. This lets guests track
effective frequency directly, without VM exits. QEMU currently lacks a
way to request this capability or expose the corresponding feature bit
to the guest.

This patch adds:

- the `aperfmperf` CPU feature flag via FEAT_6_ECX (CPUID.06H:ECX[0]),
  marked unmigratable and excluded from auto-enable;
- the `aperfmperf` property on the KVM accelerator.

`-accel kvm,aperfmperf=on` makes QEMU enable the KVM capability at VM
creation and report the CPUID bit as supported. QEMU fails to start if
the host KVM does not support the capability. `-cpu
...,migratable=off,aperfmperf=on` exposes the bit to the guest. Both are
required for the guest to use the MSRs.

This allows guest operating systems (such as FreeBSD or Linux) to
compute effective CPU frequency from APERF/MPERF, which is not possible
today since the bit is never exposed and KVM does not emulate these
MSRs. Since the guest reads the raw host counters, pinning vCPUs to
host CPUs is recommended for meaningful results.

Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
Changes in v3:
- Added it as a standalone accel option, no longer depending on cpu-pm.
- Added the flag to no_autoenable_flags.
- Link to v2: https://lore.kernel.org/qemu-devel/20260602140348.774203-1-anderson@allelesecurity.com/

Changes in v2:
- Marked aperfmperf as unmigratable.
- Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-anderson@allelesecurity.com/
---
 accel/kvm/kvm-all.c      | 13 +++++++++++++
 include/system/kvm_int.h |  1 +
 target/i386/cpu.c        | 19 ++++++++++++++++++-
 target/i386/cpu.h        |  2 ++
 target/i386/kvm/kvm.c    | 25 +++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 411f28dde2..bff66b2381 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4264,6 +4264,12 @@ static void kvm_set_kvm_rapl_socket_path(Object *obj,
     s->msr_energy.socket_path = g_strdup(str);
 }
 
+static void kvm_set_kvm_aperfmperf(Object *obj, bool value, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    s->aperfmperf_enable = value;
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
@@ -4284,6 +4290,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->xen_evtchn_max_pirq = 256;
     s->device = NULL;
     s->msr_energy.enable = false;
+    s->aperfmperf_enable = false;
     s->honor_guest_pat = ON_OFF_AUTO_OFF;
 }
 
@@ -4330,6 +4337,12 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "rapl-helper-socket",
         "Socket Path for comminucating with the Virtual MSR helper daemon");
 
+    object_class_property_add_bool(oc, "aperfmperf",
+                                   NULL,
+                                   kvm_set_kvm_aperfmperf);
+    object_class_property_set_description(oc, "aperfmperf",
+        "Allow frequency related MSRs for APERF/MPERF interface in Guest");
+
     kvm_arch_accel_class_init(oc);
 }
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938..651f5e7b83 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -160,6 +160,7 @@ struct KVMState
     uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
     struct KVMDirtyRingReaper reaper;
     struct KVMMsrEnergy msr_energy;
+    bool aperfmperf_enable;
     NotifyVmexitOption notify_vmexit;
     uint32_t notify_window;
     uint32_t xen_version;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4..ca5b321df4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1548,6 +1548,23 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
     },
+    [FEAT_6_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "aperfmperf", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 6, .reg = R_ECX, },
+        .tcg_features = 0,
+        .unmigratable_flags = CPUID_6_ECX_APERFMPERF,
+        .no_autoenable_flags = CPUID_6_ECX_APERFMPERF,
+    },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
@@ -8781,7 +8798,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         /* Thermal and Power Leaf */
         *eax = env->features[FEAT_6_EAX];
         *ebx = 0;
-        *ecx = 0;
+        *ecx = env->features[FEAT_6_ECX];
         *edx = 0;
         break;
     case 7:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e90371..4b730c5e30 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -709,6 +709,7 @@ typedef enum FeatureWord {
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
     FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
     FEAT_6_EAX,         /* CPUID[6].EAX */
+    FEAT_6_ECX,         /* CPUID[6].ECX */
     FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
@@ -1241,6 +1242,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_XSAVE_XFD        (1U << 4)
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
+#define CPUID_6_ECX_APERFMPERF (1U << 0)
 
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e29ecaba57..72634d2c3b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -501,6 +501,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         }
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
+    } else if (function == 6 && reg == R_ECX) {
+        uint32_t ecx;
+        if (s->aperfmperf_enable) {
+            host_cpuid(6, 0, &unused, &unused, &ecx, &unused);
+            ret |= ecx & CPUID_6_ECX_APERFMPERF;
+        }
     } else if (function == 7 && index == 0 && reg == R_EBX) {
         /* Not new instructions, just an optimization.  */
         uint32_t ebx;
@@ -3401,6 +3407,18 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+static int kvm_vm_enable_aperfmperf_msrs(KVMState *s)
+{
+    int supported = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
+
+    if (!(supported & KVM_X86_DISABLE_EXITS_APERFMPERF)) {
+        error_report("kvm: APERF/MPERF passthrough is not supported by this host");
+        return -ENOTSUP;
+    }
+    return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
+                             KVM_X86_DISABLE_EXITS_APERFMPERF);
+}
+
 int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3586,6 +3604,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    if (s->aperfmperf_enable) {
+        ret = kvm_vm_enable_aperfmperf_msrs(s);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
 
     if (first) {

base-commit: 99e6fa0053ba1b1454b8c4446f857c430547a702
-- 
2.56.0


