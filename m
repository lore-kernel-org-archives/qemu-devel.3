Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949E8C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Khf-00039z-1v; Fri, 26 Apr 2024 08:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Khc-00039d-Am
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0KhZ-00064f-NS
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5591so2421165e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714134556; x=1714739356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DB0/7Uqp2qUB8AIDdwjge4FwiUAyUxwuYK0G2iKn4ik=;
 b=qDLbAyKdbgASlqXkTww1ViH8YU6hVgUh7iGxletNdXqOq1+tyAHtnPlzQ81U7GX4Op
 GylbqcURjpA0NiGVJZM5m34VYjO0IH9hXxxaGauj2p1kct9GxQ6vgkJenOM8j2PBHlZy
 wyYz5bxNTTBF0k+5ZwlF+lO0xXpYesy1H+2s8nKRHj/N9YYPgc4igBJmQG4RsxtwuHz8
 L+FL0L8tUlgbQ/KBM5aNn8go6qD64MPobA5ZFuMmgahHCDv0s5umKGz8OYlQSPDbMHjT
 2nCza2jAHHo6h8ax+A3avW1UwEP2CruGMbGSB1aP1V1VBS+w2CxVMJHXJo1XPyJHFXj9
 Ifbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714134556; x=1714739356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DB0/7Uqp2qUB8AIDdwjge4FwiUAyUxwuYK0G2iKn4ik=;
 b=Jl+13V7BmmOCX1VZVn299noZJ7KxNm9GZC03nDcLebalWjZa47HIjDL8GdUB8hdFML
 AA3Gnp6YkvB9LdvjLKrJaqVYLNdDxl70DdtTAGvnBnqDTrK1zxjgSAgKTsVKa5PlgtIt
 oW9A53Xi6zvoK5qOfFn7oYvdDEyYfPT6Nk2/GMS5LstOm89dWnsKXCGcu0u2uYYjjr7P
 /m0lKwLqFmtzKj0mbbE+Wl/u+0MKaMUJStPYeW2Mhm2PXGQG9saBRUOJPv3kmB148jz3
 GZHrmoEFaBYmVjylOCdsUhGfxPAxrmeCdqV308EDpjX9TNuD5yqmtqtSu91036HUYxZu
 KBcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjtgPrdTinwnhwvIoRaJDT9EGmJhGfpjPeB+FN7S/e9k2YGGt2Ksi3jGbP9tWmz/EhGUqeroRAHQVJq0I+jKLlXLLTzHM=
X-Gm-Message-State: AOJu0YzrT86kzXvlvaInB20EpOplMaOZzJrXzZuKF+QzLnLTGm0Hy74T
 2dBylO+tVGYcsQYpChYB1QlNJ5ubPCNxneO2klCnoGmrCssDJlUHs6LpcfiogBc=
X-Google-Smtp-Source: AGHT+IHCAP5IkNiPFnFpcNNCL7txGdygEj/htN3jHc4CxfhejruZd2+PvvxeDgIwV/1AihzOFSco1A==
X-Received: by 2002:a05:600c:470f:b0:41a:8374:7eae with SMTP id
 v15-20020a05600c470f00b0041a83747eaemr1980934wmo.31.1714134555834; 
 Fri, 26 Apr 2024 05:29:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c460f00b0041a964b55ddsm1397134wmo.1.2024.04.26.05.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 05:29:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 1/4] target/arm: Refactor default generic timer frequency
 handling
Date: Fri, 26 Apr 2024 13:29:10 +0100
Message-Id: <20240426122913.3427983-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426122913.3427983-1-peter.maydell@linaro.org>
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The generic timer frequency is settable by board code via a QOM
property "cntfrq", but otherwise defaults to 62.5MHz.  The way this
is done includes some complication resulting from how this was
originally a fixed value with no QOM property.  Clean it up:

 * always set cpu->gt_cntfrq_hz to some sensible value, whether
   the CPU has the generic timer or not, and whether it's system
   or user-only emulation
 * this means we can always use gt_cntfrq_hz, and never need
   the old GTIMER_SCALE define
 * set the default value in exactly one place, in the realize fn

The aim here is to pave the way for handling the ARMv8.6 requirement
that the generic timer frequency is always 1GHz.  We're going to do
that by having old CPU types keep their legacy-in-QEMU behaviour and
having the default for any new CPU types be a 1GHz rather han 62.5MHz
cntfrq, so we want the point where the default is decided to be in
one place, and in code, not in a DEFINE_PROP_UINT64() initializer.

This commit should have no behavioural changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  7 ++++---
 target/arm/cpu.c       | 31 +++++++++++++++++--------------
 target/arm/helper.c    | 16 ++++++++--------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b53f5e8ff2a..a1509a3a58e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -59,10 +59,11 @@ static inline bool excp_is_internal(int excp)
         || excp == EXCP_SEMIHOST;
 }
 
-/* Scale factor for generic timers, ie number of ns per tick.
- * This gives a 62.5MHz timer.
+/*
+ * Default frequency for the generic timer, in Hz.
+ * This is 62.5MHz, which gives a 16 ns tick period.
  */
-#define GTIMER_SCALE 16
+#define GTIMER_DEFAULT_HZ 62500000
 
 /* Bit definitions for the v7M CONTROL register */
 FIELD(V7M_CONTROL, NPRIV, 0, 1)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a152def2413..9f2ca6633a1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1506,9 +1506,12 @@ static void arm_cpu_initfn(Object *obj)
     }
 }
 
+/*
+ * 0 means "unset, use the default value". That default might vary depending
+ * on the CPU type, and is set in the realize fn.
+ */
 static Property arm_cpu_gt_cntfrq_property =
-            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz,
-                               NANOSECONDS_PER_SECOND / GTIMER_SCALE);
+            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
 
 static Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
@@ -1954,6 +1957,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!cpu->gt_cntfrq_hz) {
+        /*
+         * 0 means "the board didn't set a value, use the default".
+         * The default value of the generic timer frequency (as seen in
+         * CNTFRQ_EL0) is 62.5MHz, which corresponds to a period of 16ns.
+         * This is what you get (a) for a CONFIG_USER_ONLY CPU (b) if the
+         * board doesn't set it.
+         */
+        cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+    }
+
 #ifndef CONFIG_USER_ONLY
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
@@ -2002,18 +2016,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     {
-        uint64_t scale;
-
-        if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
-            if (!cpu->gt_cntfrq_hz) {
-                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
-                           cpu->gt_cntfrq_hz);
-                return;
-            }
-            scale = gt_cntfrq_period_ns(cpu);
-        } else {
-            scale = GTIMER_SCALE;
-        }
+        uint64_t scale = gt_cntfrq_period_ns(cpu);
 
         cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
                                                arm_gt_ptimer_cb, cpu);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6b224826fbb..1e3002f9947 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2474,6 +2474,13 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .resetvalue = 0 },
 };
 
+static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    cpu->env.cp15.c14_cntfrq = cpu->gt_cntfrq_hz;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3228,13 +3235,6 @@ void arm_gt_hvtimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_HYPVIRT);
 }
 
-static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
-{
-    ARMCPU *cpu = env_archcpu(env);
-
-    cpu->env.cp15.c14_cntfrq = cpu->gt_cntfrq_hz;
-}
-
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /*
      * Note that CNTFRQ is purely reads-as-written for the benefit
@@ -3514,7 +3514,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
       .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
-      .resetvalue = NANOSECONDS_PER_SECOND / GTIMER_SCALE,
+      .resetfn = arm_gt_cntfrq_reset,
     },
     { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
-- 
2.34.1


