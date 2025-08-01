Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21711C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpvb-00052T-S2; Fri, 01 Aug 2025 09:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUa-00050u-FY; Fri, 01 Aug 2025 03:47:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUX-0007nA-Uc; Fri, 01 Aug 2025 03:47:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so1032118f8f.3; 
 Fri, 01 Aug 2025 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754034467; x=1754639267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEMsCOYaw6Z6paMzL0qht/X5wur0yQZhbuE80tZXu6E=;
 b=PzOjulZyBRCUcsGNNtJ+Vl/ESLoZg1tXZcWv4omwuqwugAV+bPXeMIBePeeZzB4tgS
 53gure5khbzny/1qMB4zSpmlTNl0gWg1s6lAhTV3C/kceSbrHEysIdUzxtc8H+i4OjBS
 zbO/I/+sYV/gw9hjimfMDBY4/dZLeHI3PwN4LymNHcYM2Twp88pdBzNaJ8F88k5cLmtE
 fm93k1FDdaBRunundV9WmfEV0Ae+kgwmgvfWyJO684PAiLaTzbUwOx0QsZ6v3bKSzs8G
 jJ9tYsgZ7L/TK5kSRexcMk7oetnrgB+VgyUwhTA3hHIdK8y1eGcb9LePLpL+ztWhdlE4
 b6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754034467; x=1754639267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEMsCOYaw6Z6paMzL0qht/X5wur0yQZhbuE80tZXu6E=;
 b=n57lpfBocHk/KIFKVGBawVxFLI19+lAJX9GjQDdcggBIlWIizHsVJgpGyxklCDcrtQ
 ujTtWWuQ5wu6JleHIGyGIOFbVF5+kel81Z4u4OLPgM06rOLYQw191sLO21qfnlQvPurC
 wsIiFjB1qsrYAsP4PGokn03TpixAUv1IJRDwZyX7QhNJoQb41vyQ5XUqMxBm8QBJkaZK
 i+KJR761ZhftoN0PMf3EgnE0Q973CeLlaEYM5PxITr9mU1755J6NOe9pPGPgGlHyj1Il
 47atAwCSAZhd8NhnKC5idIPr5f2ySJ9NnIb1KneWZ4YvFaDWQZAkqgo/iksyd6GvVL1W
 7Xqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCSF/F+9XcCVnkML27xk/C8MDGTss5Q6Tgcp5csD7AGQMXRPuaSDmkyTwdTbRH1LyuUVhigjd+/yhL@nongnu.org
X-Gm-Message-State: AOJu0YzquK7/TUJaVLHKvZk4wAVZrG5ekb/yE0y4uOPUTia/6mFUKom5
 CbI3u8aYPrcaJFLgtebZ0sUzDmnMlD7ffyqfNfRiqL9eNjeKeV7AuLJjUQ1PcQ==
X-Gm-Gg: ASbGncvith1Y1Lg8OCmAEZs1HUp5kRsTtNY4wAjmvaddwf1NnPfABlBzL+bXZsnVBzd
 RY5o62ch5NeEFx38X7iZmJA3Qc5xSiowIMTS//4SCga5aKCj4HBBiFDy0RyC+7BflE1LbhfgQSV
 4eF6/jvzqpdvcXl9yrVN/+OxcJlweZ6JsrO9SLO/OdvOaP+ka8zTKGNW7KpbTW4WxPvPlf5ymOO
 dNfnJAomIDDYu5wI5I4r9QGr39J8Ffrca2LqDavVK3x47bAMi268NYwmrPyVQHSjAnhPhqbZWna
 sdwMqJpAKi7APbMBDNcMMs7+jeqhaz0JDCmyTHOpQziz4lmtTn96ASW+Wjr8wBUJZdVwbV0wvrW
 ueSaLj9pK14ZHhV3qb0qqYcUsyl0wSQnSSw==
X-Google-Smtp-Source: AGHT+IEeT7XDuRqINZgTjeci+11FxwzNyLfURlk68CUh+VNw+VO6ihfpG/dtpQ11HIbuuqEBijB/eA==
X-Received: by 2002:a05:6000:40d9:b0:3b8:d15f:1d4a with SMTP id
 ffacd0b85a97d-3b8d15f1effmr2105331f8f.41.1754034466597; 
 Fri, 01 Aug 2025 00:47:46 -0700 (PDT)
Received: from shameer-ubuntu ([195.11.233.227])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm5049185f8f.44.2025.08.01.00.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 00:47:45 -0700 (PDT)
From: Shameer Kolothum <shameerkolothum@gmail.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, berrange@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, armbru@redhat.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com,
 yangjinqian1@huawei.com, shameerkolothum@gmail.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [RFC PATCH RESEND 3/4] target/arm/kvm: Handle KVM Target Imp CPU
 hypercalls
Date: Fri,  1 Aug 2025 08:47:29 +0100
Message-ID: <20250801074730.28329-4-shameerkolothum@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801074730.28329-1-shameerkolothum@gmail.com>
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shameerkolothum@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 01 Aug 2025 09:35:51 -0400
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

When target implementation CPUs are set, handle the related hyper calls
correctly by returning the information requested.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 target/arm/kvm.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8f325c4ca4..5adecc864e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1697,6 +1697,71 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
     return false;
 }
 
+/* Only supports HYP_KVM_DISCOVER_IMPL_XXX hypercalls */
+static void arm_handle_smccc_kvm_vendor_hypercall(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    uint64_t param[4] = { };
+    uint64_t idx;
+
+    if (!is_a64(env)) {
+        env->regs[0] = SMCCC_RET_NOT_SUPPORTED;
+        return;
+    }
+
+    memcpy(param, env->xregs, sizeof(param));
+
+    switch (param[0]) {
+    case ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID:
+        if (!target_impl_cpus_num) {
+            env->xregs[0] = SMCCC_RET_NOT_SUPPORTED;
+            return;
+        }
+        env->xregs[0] = SMCCC_RET_SUCCESS;
+        env->xregs[1] = PSCI_VERSION(1, 0);
+        env->xregs[2] = target_impl_cpus_num;
+        break;
+    case ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID:
+        idx = param[1];
+
+        if (!target_impl_cpus_num || idx >= target_impl_cpus_num) {
+            env->xregs[0] = SMCCC_RET_INVALID_PARAMETER;
+            return;
+        }
+
+        env->xregs[0] = SMCCC_RET_SUCCESS;
+        env->xregs[1] = target_impl_cpus[idx].midr;
+        env->xregs[2] = target_impl_cpus[idx].revidr;
+        env->xregs[3] = target_impl_cpus[idx].aidr;
+        break;
+    default:
+        env->xregs[0] = SMCCC_RET_NOT_SUPPORTED;
+    }
+}
+
+static int kvm_arm_handle_hypercall(CPUState *cs, struct kvm_run *run)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    kvm_cpu_synchronize_state(cs);
+
+    if (run->hypercall.flags == KVM_HYPERCALL_EXIT_SMC) {
+        cs->exception_index = EXCP_SMC;
+        env->exception.syndrome = syn_aa64_smc(0);
+    } else {
+        cs->exception_index = EXCP_HVC;
+        env->exception.syndrome = syn_aa64_hvc(0);
+    }
+    env->exception.target_el = 1;
+
+    bql_lock();
+    arm_handle_smccc_kvm_vendor_hypercall(cpu);
+    bql_unlock();
+
+    return EXCP_INTERRUPT;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1713,6 +1778,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_arm_handle_dabt_nisv(cpu, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
+    case KVM_EXIT_HYPERCALL:
+        ret = kvm_arm_handle_hypercall(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
@@ -2212,6 +2280,29 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
     return kvm_set_one_reg(CPU(cpu), KVM_REG_ARM64_SVE_VLS, &vls[0]);
 }
 
+/*
+ * Supported Target Implementation CPU hypercalls:
+ *   KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_VER   = 0,
+ *   KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_CPUS  = 1
+ *
+ * Setting these bits advertises the availability of the corresponding
+ * Target Implementation CPU hypercalls to the guest.
+ */
+#define BMAP_2_DISCOVER_IMPL_BITS 0x3ULL
+static int kvm_arm_target_impl_cpus_set_hyp_bmap2(ARMCPU *cpu)
+{
+    uint64_t bmap2;
+    int ret;
+
+    ret = kvm_get_one_reg(CPU(cpu), KVM_REG_ARM_VENDOR_HYP_BMAP_2, &bmap2);
+    if (ret) {
+        return ret;
+    }
+
+    bmap2 |= BMAP_2_DISCOVER_IMPL_BITS;
+    return kvm_set_one_reg(CPU(cpu), KVM_REG_ARM_VENDOR_HYP_BMAP_2, &bmap2);
+}
+
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
 int kvm_arch_init_vcpu(CPUState *cs)
@@ -2293,6 +2384,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
+    /* Set KVM_REG_ARM_VENDOR_HYP_BMAP_2 if target impl CPUs are required */
+    if (target_impl_cpus_num) {
+        ret = kvm_arm_target_impl_cpus_set_hyp_bmap2(cpu);
+        if (ret) {
+            return ret;
+        }
+    }
+
     ret = kvm_arm_init_cpreg_list(cpu);
     if (ret) {
         return ret;
-- 
2.34.1


