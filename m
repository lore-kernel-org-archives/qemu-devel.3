Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79243C071FD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 18:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxtFe-00088G-5r; Fri, 19 Apr 2024 14:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxtFZ-00086U-Ae
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:46:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxtFV-00012I-7d
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:46:16 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-347c197a464so1623048f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713552372; x=1714157172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nQaBx9r5N0v1ewmC8t+fla4PMGkNo0kCNDVTJv0sKQ0=;
 b=GqcT31viqtYC+yK9thvU76igP6tEqLmk1edT1DvuRj81+SU/yRwHzMLtumkYBzGB6D
 Yhiyl/sCHiygN/uBm/hYisuxfTB9SBrZHMBgvPvNPfvFU5s9vZSNNJfHI1wX4YlUhTS8
 td1/svA6t8hs7HPjxXJnEBeVdo3fr/+4bn/Maxkw/IVSjyQTs2hedczvskKqkXhw7CXv
 6HW/S5bzRw01y2n5ZORi/NG3/wJhmqYxfPREZzEzfYRPoqoB1T3eS9TB5RAEwM31Go8Y
 E9Lnlne/0CbBWHwFbEFup1vZDY5yi3fy/NtUs/2ezrDfSIAsrn1vuT0p9FlomFLTErPs
 kdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713552372; x=1714157172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQaBx9r5N0v1ewmC8t+fla4PMGkNo0kCNDVTJv0sKQ0=;
 b=iGLix8KwrgGdcr9Kd/prkg5TrWkZUnpZEWyBuKYQ7VA2edXBGYepal31USjvjndmyp
 n98swvO3gjmaE+uplhSuEPpf1qlhVsSc2Yk2/EYaASLyzigtm0xJbxSHjuuVvympCLUg
 WdZZIDCLsb8AlZzXf5B8jNOqxuSUfh6u4jyfKJBWIcd8Jv1yvcPTW0DQW3WvzIXJNs7x
 KZ41Ur3quFRWTlhXVfZpMchGdRSN773lPE8nZRlR1VnaE9OJ4TI4pM89gA2EtYfTKnia
 zJ84O0tVNemUqnbprXffTsUugopviGRSkigRATd7W6riwsNHqMd0EKv+WlsPYtHukQBP
 LoZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/bBB6W+syGMCH2Oc6kvPTUxf1QNFMqRV0wrgkt5eBWtQ6lIKR2XbSNg4q0uetEzbnT/PJhnBEUdIdBka0RCtcQGEhYc=
X-Gm-Message-State: AOJu0YwE7Eso7XdqjhGsIWZ/wArYMdMf/RMGp2VaUu6DWzW1yD0CVvuY
 0q9ZUBYT3XxMlQ1l6nlzchi0G+1oHlAte1hU0tNgQwI9gUtJvd5ERKt9mgXzxBMlUtG29zLevpG
 Z
X-Google-Smtp-Source: AGHT+IGdjmMIK3C4Nlq4n9h61VU3FAlvJ5fqqM5JQuR/7yR+NRzK6fDrM/SaGNcHFWRrqyvyesXNOw==
X-Received: by 2002:adf:ce08:0:b0:346:a7:4acb with SMTP id
 p8-20020adfce08000000b0034600a74acbmr1777083wrn.62.1713552371491; 
 Fri, 19 Apr 2024 11:46:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 cs18-20020a056000089200b003437799a373sm5108718wrb.83.2024.04.19.11.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 11:46:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Default to 1GHz cntfrq for 'max' and new CPUs
Date: Fri, 19 Apr 2024 19:46:08 +0100
Message-Id: <20240419184608.2675213-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419184608.2675213-1-peter.maydell@linaro.org>
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

In previous versions of the Arm architecture, the frequency of the
generic timers as reported in CNTFRQ_EL0 could be any IMPDEF value,
and for QEMU we picked 62.5MHz, giving a timer tick period of 16ns.
In Armv8.6, the architecture standardized this frequency to 1GHz.

Because there is no ID register feature field that indicates whether
a CPU is v8.6 or that it ought to have this counter frequency, we
implement this by changing our default CNTFRQ value for all CPUs,
with exceptions for backwards compatibility:

 * CPU types which we already implement will retain the old
   default value. None of these are v8.6 CPUs, so this is
   architecturally OK.
 * CPUs used in versioned machine types with a version of 9.0
   or earlier will retain the old default value.

The upshot is that the only CPU type that changes is 'max'; but any
new type we add in future (whether v8.6 or not) will also get the new
1GHz default.

It remains the case that the machine model can override the default
value via the 'cntfrq' QOM property (regardless of the CPU type).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 11 +++++++++++
 target/arm/internals.h | 12 ++++++++++--
 hw/core/machine.c      |  4 +++-
 target/arm/cpu.c       | 28 ++++++++++++++++++++++------
 target/arm/cpu64.c     |  2 ++
 target/arm/tcg/cpu32.c |  4 ++++
 target/arm/tcg/cpu64.c | 18 ++++++++++++++++++
 7 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 20d8257c853..4eeeac3fe94 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -953,6 +953,9 @@ struct ArchCPU {
      */
     bool host_cpu_probe_failed;
 
+    /* QOM property to indicate we should use the back-compat CNTFRQ default */
+    bool backcompat_cntfrq;
+
     /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
      * register.
      */
@@ -2367,6 +2370,14 @@ enum arm_features {
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
     ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
+    /*
+     * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
+     * if the board doesn't set a value, instead of 1GHz. It is for backwards
+     * compatibility and used only with CPU definitions that were already
+     * in QEMU before we changed the default. It should not be set on any
+     * CPU types added in future.
+     */
+    ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 74d4b1b0990..11d9ff0fc08 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -61,9 +61,17 @@ static inline bool excp_is_internal(int excp)
 
 /*
  * Default frequency for the generic timer, in Hz.
- * This is 62.5MHz, which gives a 16 ns tick period.
+ * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
+ * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
+ * which gives a 16ns tick period.
+ *
+ * We will use the back-compat value:
+ *  - for QEMU CPU types added before we standardized on 1GHz
+ *  - for versioned machine types with a version of 9.0 or earlier
+ * In any case, the machine model may override via the cntfrq property.
  */
-#define GTIMER_DEFAULT_HZ 62500000
+#define GTIMER_DEFAULT_HZ 1000000000
+#define GTIMER_BACKCOMPAT_HZ 62500000
 
 /* Bit definitions for the v7M CONTROL register */
 FIELD(V7M_CONTROL, NPRIV, 0, 1)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index a92bec23147..bd40483d880 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -33,7 +33,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_0[] = {};
+GlobalProperty hw_compat_9_0[] = {
+    {"arm-cpu", "backcompat-cntfrq", "true" },
+};
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
 GlobalProperty hw_compat_8_2[] = {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b248b283423..2c8160d6b74 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1388,6 +1388,11 @@ static void arm_cpu_initfn(Object *obj)
 static Property arm_cpu_gt_cntfrq_property =
             DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
 
+/* True to default to the backwards-compatibility old CNTFRQ rather than 1Ghz */
+static Property arm_cpu_backcompat_cntfrq_property =
+            DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU,
+                             backcompat_cntfrq, false);
+
 static Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
 
@@ -1709,6 +1714,8 @@ void arm_cpu_post_init(Object *obj)
         qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
     }
 
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_backcompat_cntfrq_property);
+
     if (kvm_enabled()) {
         kvm_arm_add_vcpu_properties(cpu);
     }
@@ -1834,13 +1841,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     if (!cpu->gt_cntfrq_hz) {
         /*
-         * 0 means "the board didn't set a value, use the default".
-         * The default value of the generic timer frequency (as seen in
-         * CNTFRQ_EL0) is 62.5MHz, which corresponds to a period of 16ns.
-         * This is what you get (a) for a CONFIG_USER_ONLY CPU (b) if the
-         * board doesn't set it.
+         * 0 means "the board didn't set a value, use the default". (We also
+         * get here for the CONFIG_USER_ONLY case.)
+         * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
+         * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
+         * which gives a 16ns tick period.
+         *
+         * We will use the back-compat value:
+         *  - for QEMU CPU types added before we standardized on 1GHz
+         *  - for versioned machine types with a version of 9.0 or earlier
          */
-        cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+        if (arm_feature(env, ARM_FEATURE_BACKCOMPAT_CNTFRQ) ||
+            cpu->backcompat_cntfrq) {
+            cpu->gt_cntfrq_hz = GTIMER_BACKCOMPAT_HZ;
+        } else {
+            cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+        }
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 985b1efe160..c15d086049f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -599,6 +599,7 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -656,6 +657,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index b5a60682fa6..bdd82d912a2 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -457,6 +457,7 @@ static void cortex_a7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -505,6 +506,7 @@ static void cortex_a15_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -696,6 +698,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     cpu->midr = 0x411fd133; /* r1p3 */
@@ -924,6 +927,7 @@ static void arm_max_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index c3369f40824..b0eb7fbb385 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -63,6 +63,7 @@ static void aarch64_a35_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -231,6 +232,7 @@ static void aarch64_a55_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -299,6 +301,7 @@ static void aarch64_a72_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -354,6 +357,7 @@ static void aarch64_a76_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -423,6 +427,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -592,6 +597,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -663,6 +669,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -885,6 +892,7 @@ static void aarch64_a710_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -982,6 +990,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -1077,6 +1086,15 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    /*
+     * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
+     * to because we started with aarch64_a57_initfn(). A 'max' CPU might
+     * be a v8.6-or-later one, in which case the cntfrq must be 1GHz; and
+     * because it is our "may change" CPU type we are OK with it not being
+     * backwards-compatible with how it worked in old QEMU.
+     */
+    unset_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
+
     /*
      * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
      * one and try to apply errata workarounds or use impdef features we
-- 
2.34.1


