Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDCFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Khm-0003Ed-Dz; Fri, 26 Apr 2024 08:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Khi-0003D6-M0
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Khb-000655-QT
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4155819f710so15711345e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714134557; x=1714739357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3y0R1vsfiLr1WCIZ1FebY/60oHcB7hAtVgV1KQkX9c=;
 b=ERtohyW60QZtwC+FgdOTYxMhihCh3BEN8zoCN0v6fBlSRd4uzlBsPFqBJzK15/x09u
 MZJQhDA1BeZ+7MLPIvZRPCCaE0gshHQjcwaayNIzcD9WLYXDS3mxfZxI8WD+sEham6ML
 C78iK5+hYqjhZ8J3aryem/Rxfx3uktNZJg8FR6YfLeBlnM2zmMlihKwaFROoNQqKPzZc
 iGw7v1hsZLU0aHV6+qN/a7B9zxYOFBAeuakIRAvQTRq0EuwLiQDxqOF/c5Odove9ITqr
 57qmiwpeAbP89V7S3iMal60fwEO/im4rFIpnCpt+/MIcEUhRPj1UrRzQJhkQ7AKdlm6b
 e9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714134557; x=1714739357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3y0R1vsfiLr1WCIZ1FebY/60oHcB7hAtVgV1KQkX9c=;
 b=B65Gs7jFIKjdkLTaZCHIyJB2w3dxV9U28MOj1cX19/bc01UvhB+1yUowIx/My0CcYN
 t9X+AOOkexq4lLi70tI1MovQoTyTF9TBfWmjHtHtU8mWXhpkjadcZcH9i3nZed8Z0YAZ
 6lo7Z2gmbNE8Kz0HSrqWp/t711QQ0PFrfN3bGF+cCqcKZw+Vmto0kYFf0m5HxAhSBaJh
 qw5BNfFdhN5KbNF/EGPCIID73aGibAQv+zPST7CqWxR0pFt5R6xX36RLqx8Kgs3tKwb+
 VNq+vLgSIO4OmIcwi6BTmK9g+4eFF8/BJj3XsQzVmi1woxJApwhmvOQR8ugdQ636LREI
 yUtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7nnJ0MeN62lvVawSH2kNJGW08X89OmzHa8lUT2Ri9WkVJRbITa2urzb+ihHmN8VjG0R/QwNtcg+dLna2vfbnAKEA3lH8=
X-Gm-Message-State: AOJu0Yxsy2mPIgywuGZLP3EZnu1fpkBXTSX41r/bBDPozTbsdo6bXKGQ
 A0fs9+k+HE6ebVGbCbKva+OG4Sq2KxV9pNMTiN6vGZ0bkXcJ3DkWa0rlFAZn/dA=
X-Google-Smtp-Source: AGHT+IEJ7Ry1kCRsS2eWiLzWfjTyRO3qj5sh7kd9FaGpxOI69dSmOMqLgIv5p99W8kLD0xwvKd9yQg==
X-Received: by 2002:a05:600c:a43:b0:41b:9828:f4c2 with SMTP id
 c3-20020a05600c0a4300b0041b9828f4c2mr1107159wmq.3.1714134557463; 
 Fri, 26 Apr 2024 05:29:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c460f00b0041a964b55ddsm1397134wmo.1.2024.04.26.05.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 05:29:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 4/4] target/arm: Default to 1GHz cntfrq for 'max' and new
 CPUs
Date: Fri, 26 Apr 2024 13:29:13 +0100
Message-Id: <20240426122913.3427983-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426122913.3427983-1-peter.maydell@linaro.org>
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v1->v2: use DEFINE_PROP_BOOL in arm_cpu_properties[] instead of
qdev_property_add_static() to define backcompat-cntfrq property
---
 target/arm/cpu.h       | 11 +++++++++++
 target/arm/internals.h | 12 ++++++++++--
 hw/core/machine.c      |  4 +++-
 target/arm/cpu.c       | 23 +++++++++++++++++------
 target/arm/cpu64.c     |  2 ++
 target/arm/tcg/cpu32.c |  4 ++++
 target/arm/tcg/cpu64.c | 18 ++++++++++++++++++
 7 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 97997dbd087..b614bc5d139 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -959,6 +959,9 @@ struct ArchCPU {
      */
     bool host_cpu_probe_failed;
 
+    /* QOM property to indicate we should use the back-compat CNTFRQ default */
+    bool backcompat_cntfrq;
+
     /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
      * register.
      */
@@ -2359,6 +2362,14 @@ enum arm_features {
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
index a1509a3a58e..5a5be347c67 100644
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
index 0dec48e8021..4ff60911e74 100644
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
index 9f2ca6633a1..fdc3eda318a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1959,13 +1959,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
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
@@ -2574,6 +2583,8 @@ static Property arm_cpu_properties[] = {
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
+    /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
+    DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
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
index de8f2be9416..e4f983bcdc1 100644
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
index 62c4663512b..b235bd22979 100644
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


