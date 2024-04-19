Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E5AC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqgi-0003Zv-1L; Fri, 19 Apr 2024 12:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqem-0001HR-FW
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqed-0001Ae-Gx
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4155819f710so18449415e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542397; x=1714147197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYvfcDH3KQ6snrWfH/Ek9+OMW5ZpL7gVRfc7ZM2MjAE=;
 b=Y+ohttYQfHjjJnf/3MSLrEAKf3wSDThY7PDowVpTA4t6Wgi+UoYsnt2CadwweB1jsj
 FrLRmUIS4UQcth0kp4Yux8Hm1GhVzkrJMvIeSwd6e42D/v1juQ/lrFipNEeyCjjO6CXR
 sD42VtQZT9Om1wZ2Jrt5zjE/jfz46ZU6X1Fuf96QE+PDcFoj88ijOSfVm0I1UcS2yzSX
 Z8cFjl0L2Gft0RBpabHG6DLBX35ehtHVxVfSieof6Wlk07IxkSPpQCZH9/pfmWyyy3sC
 QyholOuwsLjFsSe7TkzkLjIpAnIbzYT4IE55geNiEO6rpuGz6FREOFyro/BbVIv2TXLt
 J1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542397; x=1714147197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYvfcDH3KQ6snrWfH/Ek9+OMW5ZpL7gVRfc7ZM2MjAE=;
 b=LN6/11rMDlHVVGwDhk8gBAKGxH7sOETD5PVSuJ3ApsIhCzmn7FK9V38hNdaQcuUVfY
 EUCLq8fwcpGMtcL5M4rV9UTcY/6vQi0o5FRlaARqgOrtai4/KONFjO4NJZiXiDcl/pPK
 92RTrMYQixEb2GZ5sDHglDb6aVFhlQ8s4qwO02QQAC6fN/Os3igG8DKRQQpEL4FF8iBL
 ryJUVkvqy74tesO1ZjHaMhTNC6Pe3kBw6RTG3FjXBuIwth4ZIxVkQ7PQ1C2FHIc/ltta
 CpmtUOF7qLwtd309vdQ0ZH81syFus2k2qoqiyy8YJTBIOcWg5LaJpfnL8fYKXHvm6LJH
 hWAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC30Oa6knmYysu5Hyd7jFSFLC5z/Va9TEDcWyAdH+k2tHzcFjidMRUPyrOka1dfDADVnrYnFJVysqEO7w9dzH6toCRulk=
X-Gm-Message-State: AOJu0YwEpdJmsOrVcs1O7GTlpfwyEg5gUiGMNH+9a/6S0DTQQDe5tYEK
 nryft10F2CHykaSmBtIWm82HuU1OajJk5dGO1Wmq7eUXIZzuaupFYIcd/7bDU+8=
X-Google-Smtp-Source: AGHT+IHNyNL2Q29+VBI1a+s20xx7GAuvwPFbUqa9vNRiWfqyeebNx8G45kD+mJ1WZo6VGxRdo9wECg==
X-Received: by 2002:adf:eb84:0:b0:34a:d5e:afd2 with SMTP id
 t4-20020adfeb84000000b0034a0d5eafd2mr1598954wrn.4.1713542397562; 
 Fri, 19 Apr 2024 08:59:57 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:57 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 16/22] target/arm/cpu: Set number of breakpoints and
 watchpoints in KVM
Date: Fri, 19 Apr 2024 16:57:04 +0100
Message-ID: <20240419155709.318866-18-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x333.google.com
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

Add "num-breakpoints" and "num-watchpoints" CPU parameters to configure
the debug features that KVM presents to the guest. The KVM vCPU
configuration is modified by calling SET_ONE_REG on the ID register.

This is needed for Realm VMs, whose parameters include breakpoints and
watchpoints, and influence the Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 target/arm/cpu.h          |  4 ++
 target/arm/kvm_arm.h      |  2 +
 target/arm/arm-qmp-cmds.c |  1 +
 target/arm/cpu64.c        | 77 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 56 +++++++++++++++++++++++++++-
 5 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d3ff1b4a31..24080da2b7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1089,6 +1089,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Allows to override the default configuration */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 4b787dd628..b040686eab 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -16,6 +16,8 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
+#define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
+
 /**
  * kvm_arm_register_device:
  * @mr: memory region for this device
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738b..0f574bb1dd 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -95,6 +95,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3",
+    "num-breakpoints", "num-watchpoints",
     NULL
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 985b1efe16..9ca74eb019 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -571,6 +571,82 @@ void aarch64_add_pauth_properties(Object *obj)
     }
 }
 
+#if defined(CONFIG_KVM)
+static void arm_cpu_get_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_wps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_wps = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val < 2 || val > max_wps) {
+        error_setg(errp, "invalid number of watchpoints");
+        return;
+    }
+
+    cpu->num_wps = val;
+}
+
+static void arm_cpu_get_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_bps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_bps = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val < 2 || val > max_bps) {
+        error_setg(errp, "invalid number of breakpoints");
+        return;
+    }
+
+    cpu->num_bps = val;
+}
+
+static void aarch64_add_kvm_writable_properties(Object *obj)
+{
+    object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
+                        arm_cpu_set_num_bps, NULL, NULL);
+    object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
+                        arm_cpu_set_num_wps, NULL, NULL);
+}
+#endif /* CONFIG_KVM */
+
 void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     uint64_t t;
@@ -713,6 +789,7 @@ static void aarch64_host_initfn(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
         aarch64_add_pauth_properties(obj);
+        aarch64_add_kvm_writable_properties(obj);
     }
 #elif defined(CONFIG_HVF)
     ARMCPU *cpu = ARM_CPU(obj);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6d368bf442..623980a25b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -318,7 +318,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
                               ARM64_SYS_REG(3, 0, 0, 4, 5));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 5, 0));
+                              KVM_REG_ARM_ID_AA64DFR0_EL1);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
                               ARM64_SYS_REG(3, 0, 0, 5, 1));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
@@ -876,6 +876,54 @@ out:
     return ret;
 }
 
+static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (!cpu->num_bps && !cpu->num_wps) {
+        return;
+    }
+
+    newval = cpu->isar.id_aa64dfr0;
+    if (cpu->num_bps) {
+        uint64_t ctx_cmps = FIELD_EX64(newval, ID_AA64DFR0, CTX_CMPS);
+
+        /* CTX_CMPs is never greater than BRPs */
+        ctx_cmps = MIN(ctx_cmps, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, BRPS, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, CTX_CMPS, ctx_cmps);
+    }
+    if (cpu->num_wps) {
+        newval = FIELD_DP64(newval, ID_AA64DFR0, WRPS, cpu->num_wps - 1);
+    }
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_ID_AA64DFR0_EL1");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded. KVM does offer the writable mask for this
+     * register, but this way we also check if the value we wrote was sane.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_ID_AA64DFR0_EL1");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
+    }
+}
+
+static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
+{
+    kvm_arm_configure_aa64dfr0(cpu);
+}
+
 /**
  * kvm_arm_cpreg_level:
  * @regidx: KVM register index
@@ -995,6 +1043,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
         fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
         abort();
     }
+
+    /*
+     * Before loading the KVM values into CPUState, update the KVM configuration
+     */
+    kvm_arm_configure_vcpu_regs(cpu);
+
     if (!write_kvmstate_to_list(cpu)) {
         fprintf(stderr, "write_kvmstate_to_list failed\n");
         abort();
-- 
2.44.0


