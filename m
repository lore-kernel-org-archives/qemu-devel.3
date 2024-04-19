Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4544C07C79
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqgj-0003iF-4q; Fri, 19 Apr 2024 12:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqem-0001HT-FZ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqed-0001At-Jm
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:06 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34a3e0b31e6so1235308f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542398; x=1714147198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdsJt69+Vn2LQu2a//QmjSh4AtFMIlHO+kRO+YRpF0Q=;
 b=tHnKaGHk/TAzn7mz7wZx1k25nMqVfSLoOhvUQ/b1QS7gs+oIJed4WxFySEEqhTy5/k
 M9XKFCOEKlr7dUYbyttMfzpR7jz1XFfcx3k2iE8uKwGdfP67oaOv0qnyfRRLUJmvAj2G
 S1+oMMCWZGBMmr/yaKK2Au6F9ynAWONo6LTRVQgk/b+rbrrmfWPMSxkbZVtBIxlYDcQx
 /WuXbjsrECHy/aGlvWr7IpFIO6S7jhN1bvveYkt5U1A4XUC0aSUrA8TIZoljLJjL0TcQ
 oTRK6dVTyKdaYaSw/C+cD6xTaaxb7r8XWtnW7NFdxM2fUWjElO847E0gw3RpHr9RyAvd
 wTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542398; x=1714147198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdsJt69+Vn2LQu2a//QmjSh4AtFMIlHO+kRO+YRpF0Q=;
 b=NAhuKfCoR8O7qUej+CLtxO1lJYopXEcrN65AuP3zf4fcv5A38/z8sLmrG27zQ2hBXu
 dCXPb96m2r9gHG90Rx1A6JzqEGkPZCyhxN7QTC4k4hwOUo1WYiAHO3pNKQP1NHaSpXsa
 5e6fCPxyQYj5hSkYcsNHguDyjKgJO7nwUasVOc47icX4q9ccVRS2rGAuBGiLgijvvtKl
 /d0GIBxYJQjl5M4DClcAzwCW9gJP7xcrXiihdZmmFjvOUBbRF/XZ05e9N0WfguR365h5
 Jj2ybY2WdjT+faxLR0nFGBmYymczd/pXSGWkb+Zc/blacH3xDnYjs2hZJ4hQValPlOFJ
 t9xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCGMhOasjz/JHBHDF3itnqUXg9qK2yyf+wHW4EM30GR1V/kEUB36q4wZxYnAWI6vfs0WMLABdYcPED5rwexSDW05IJbJ0=
X-Gm-Message-State: AOJu0YwpY7pAeX8THAw42cBgVTVG5OfSQHJUhz9WUFhPOjEdcot07aFR
 8EjsWfr5yzHu6QUAImcma17Q90jOdRbPZHYUOct2e61weYb0nOi3y2tw7jc6L9M=
X-Google-Smtp-Source: AGHT+IGNEE/ZTIzfkGoDmlqGbmqGKRHYpsN+u5qQoorOaVeIoEGpyOeiLlHyPQ/djbxbYUKJ99BAEA==
X-Received: by 2002:adf:e044:0:b0:34a:cc3:806 with SMTP id
 w4-20020adfe044000000b0034a0cc30806mr1583821wrh.51.1713542398179; 
 Fri, 19 Apr 2024 08:59:58 -0700 (PDT)
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
Subject: [PATCH v2 17/22] target/arm/cpu: Set number of PMU counters in KVM
Date: Fri, 19 Apr 2024 16:57:05 +0100
Message-ID: <20240419155709.318866-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x435.google.com
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

Add a "num-pmu-counters" CPU parameter to configure the number of
counters that KVM presents to the guest. This is needed for Realm VMs,
whose parameters include the number of PMU counters and influence the
Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 target/arm/cpu.h          |  3 +++
 target/arm/kvm_arm.h      |  1 +
 target/arm/arm-qmp-cmds.c |  2 +-
 target/arm/cpu64.c        | 41 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 34 +++++++++++++++++++++++++++++++-
 5 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 24080da2b7..84f3a67dab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1093,6 +1093,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2312,6 +2313,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b040686eab..62e39e7184 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -17,6 +17,7 @@
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
 #define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
+#define KVM_REG_ARM_PMCR_EL0            ARM64_SYS_REG(3, 3, 9, 12, 0)
 
 /**
  * kvm_arm_register_device:
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 0f574bb1dd..985d4270b8 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -95,7 +95,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3",
-    "num-breakpoints", "num-watchpoints",
+    "num-breakpoints", "num-watchpoints", "num-pmu-counters",
     NULL
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9ca74eb019..6c2b922d93 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -638,12 +638,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
     cpu->num_bps = val;
 }
 
+static void arm_cpu_get_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        val = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+    } else {
+        val = cpu->num_pmu_ctrs;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_ctrs = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > max_ctrs) {
+        error_setg(errp, "invalid number of PMU counters");
+        return;
+    }
+
+    cpu->num_pmu_ctrs = val;
+}
+
 static void aarch64_add_kvm_writable_properties(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
                         arm_cpu_set_num_bps, NULL, NULL);
     object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
                         arm_cpu_set_num_wps, NULL, NULL);
+
+    cpu->num_pmu_ctrs = -1;
+    object_property_add(obj, "num-pmu-counters", "uint8",
+                        arm_cpu_get_num_pmu_ctrs, arm_cpu_set_num_pmu_ctrs,
+                        NULL, NULL);
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 623980a25b..9855cadb1b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -418,7 +418,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         if (pmu_supported) {
             /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
             err |= read_sys_reg64(fdarray[2], &ahcf->isar.reset_pmcr_el0,
-                                  ARM64_SYS_REG(3, 3, 9, 12, 0));
+                                  KVM_REG_ARM_PMCR_EL0);
         }
 
         if (sve_supported) {
@@ -919,9 +919,41 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
     }
 }
 
+static void kvm_arm_configure_pmcr(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        return;
+    }
+
+    newval = FIELD_DP64(cpu->isar.reset_pmcr_el0, PMCR, N, cpu->num_pmu_ctrs);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded, since older versions of KVM ignore it.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_PMCR_EL0");
+    }
+}
+
 static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
 {
     kvm_arm_configure_aa64dfr0(cpu);
+    kvm_arm_configure_pmcr(cpu);
 }
 
 /**
-- 
2.44.0


