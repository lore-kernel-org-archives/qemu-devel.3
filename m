Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D81C3ABA8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d5a-0008Jk-L4; Tue, 29 Apr 2025 01:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4y-0007YP-7z
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4v-0005z7-Cq
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:23 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227914acd20so55783245ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902820; x=1746507620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTaFFMYBVP+QujpvomI3smt+CnB1wh0iLnUK0PT4pEc=;
 b=gbKgy8zStpBMUsa6qctQkH3WO9Zpv60GX62dD+TMlCmFXQToSYiS7mdUJjK9l81OCC
 EpRu21+CjWZC3HC3wac5ecelz/1+vWS57UW9cuvdTJbLIeHgH68W0W4KWZ9IF9Wb2r3x
 Wl9eEcPOkSEOR1i7KuI7+BDpF8REUycYOcXTL4dCZaxAhMVEBdZeAMPWkJ0PgS6pbbnB
 lZ7aLYXONyitfu1Y4fSFL8SebVmwsAeWpkvg6yoZaBTeJoC501WGZgcqoiMOzj3dqUCg
 o1FGGKeRRAobnIqv94B0iDrQUFSmm2rlpT4Z6aD9g4vRZxpqeAnzFk17Ltq9klMGI3z5
 6r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902820; x=1746507620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTaFFMYBVP+QujpvomI3smt+CnB1wh0iLnUK0PT4pEc=;
 b=IfjQ/0inKnXi2hYV6kDoF/a1T7qdzMkE3aZbQ/zFPRIpcfI1qIpx/UdUFZsWWv5NEP
 hygPwHAujiwC7F8JRlfNVpJUVdoOddpZ9AF0TtGvOfUpp6AGPPEXnqLQ6B3GrjZngvo8
 dBmh3+4EYA3hDehqtbWAw312rn40fKGzIRq1KpaSRHCMWKftuLXGIn43bWnNrXeRu6Oi
 5Wx2Y1VDp0Igi8tevtBt0sovhefo0EZSye6anwt/yYUPvU8kAjcD53/GB93jnKfMvb4A
 upSJTKgkSDmrZ2Nyu17MDXktq2vmFiJkTsn1RAceKcHmhd3mwh3GxZM1bLhXscELMItX
 spkA==
X-Gm-Message-State: AOJu0YxB6r6fFieY+lHW8C/CPtFe90EVXW+Cakuu27Vip/7eDvYOXXlA
 udU3Y5+FmE58doDUJznzJIX6LXFZ9dPHVvXdP3QlqHZrstsM5oRV0DJd9KMC809HWO0pPUhLQvF
 s
X-Gm-Gg: ASbGncuSdHZxALuOPw5Vfq69W4hwRBOxpP1XqqlH1TZDvz29L9AKfPm024v1cqRO2m7
 Gc0QlL15AUE6P/2e3xA9r/KvcR/Vc1utAqW8RIw4CaFQCoH9rIOcXEU4ryawzG+KLgEQ3g5b6Yu
 sWY/2mF7kBC3M72jM8oETU3DQK97ToevCASo+VbfFfPEFFX6/pFzlK+2OQ5vgEYnyrSDhlBBnWc
 tiwzhNbcnhSrRnoiqQTy4xI7mEQz5uhkFQ/V905Lv4BrsqD2ZPJhmoMhEqANOsvN++OBBHxvmEp
 fuXtlVNWlmsQH612CrY+yghCxV2pFlR51wL6kdGM
X-Google-Smtp-Source: AGHT+IEx/Jh51iAi9wYCRK0qOdbUNLmln4cWvAe8L1xYO15g0HGBE2gNuockkWPBNYfIVdVxbblv3w==
X-Received: by 2002:a17:902:d488:b0:215:a56f:1e50 with SMTP id
 d9443c01a7336-22de6bff536mr25643515ad.8.1745902819983; 
 Mon, 28 Apr 2025 22:00:19 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/13] target/arm: move kvm stubs and remove CONFIG_KVM from
 kvm_arm.h
Date: Mon, 28 Apr 2025 22:00:01 -0700
Message-ID: <20250429050010.971128-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

We have to be careful to expose struct kvm_vcpu_init only when kvm is
possible, thus the additional CONFIG_KVM_IS_POSSIBLE around
kvm_arm_create_scratch_host_vcpu.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h  | 84 ++-----------------------------------------
 target/arm/kvm-stub.c | 77 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 82 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 05c3de8cd46..c8ddf8beb2e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -94,7 +94,7 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
-#ifdef CONFIG_KVM
+#ifdef CONFIG_KVM_IS_POSSIBLE
 /**
  * kvm_arm_create_scratch_host_vcpu:
  * @cpus_to_try: array of QEMU_KVM_ARM_TARGET_* values (terminated with
@@ -116,6 +116,7 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu);
 bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init);
+#endif /* CONFIG_KVM_IS_POSSIBLE */
 
 /**
  * kvm_arm_destroy_scratch_host_vcpu:
@@ -221,85 +222,4 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
-#else
-
-/*
- * It's safe to call these functions without KVM support.
- * They should either do nothing or return "not supported".
- */
-static inline bool kvm_arm_aarch32_supported(void)
-{
-    return false;
-}
-
-static inline bool kvm_arm_pmu_supported(void)
-{
-    return false;
-}
-
-static inline bool kvm_arm_sve_supported(void)
-{
-    return false;
-}
-
-static inline bool kvm_arm_mte_supported(void)
-{
-    return false;
-}
-
-/*
- * These functions should never actually be called without KVM support.
- */
-static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
-{
-    g_assert_not_reached();
-}
-
-static inline int kvm_arm_vgic_probe(void)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_pmu_init(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 #endif
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 965a486b320..2b73d0598c1 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -22,3 +22,80 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
 {
     g_assert_not_reached();
 }
+
+/*
+ * It's safe to call these functions without KVM support.
+ * They should either do nothing or return "not supported".
+ */
+bool kvm_arm_aarch32_supported(void)
+{
+    return false;
+}
+
+bool kvm_arm_pmu_supported(void)
+{
+    return false;
+}
+
+bool kvm_arm_sve_supported(void)
+{
+    return false;
+}
+
+bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
+/*
+ * These functions should never actually be called without KVM support.
+ */
+void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
+{
+    g_assert_not_reached();
+}
+
+int kvm_arm_vgic_probe(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_pmu_init(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


