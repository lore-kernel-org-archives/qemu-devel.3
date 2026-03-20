Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D065D1098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYb-00030A-0o; Fri, 20 Mar 2026 09:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYY-0002wI-8s
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:26 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYU-00063t-3l
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-667acaeae82so2864686a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011980; x=1774616780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oPB471eXj4owIYL5CBF7Q395nZGbkHiFon/ZP2/K+k=;
 b=IHYHI5EX6VKTy4l4e8G7hG34T1PWQ6+Ug5744yot++EMWTz/5sUeoTuy/rNStKqfp8
 ikdfkNTVviPT7bv+9zpVCRfmc8CHNfgp4Uo9ZYhuZLPOR1RF0yUpDPY3dIc8e/VC3QU+
 V5S7aYZsv4pFbxJsQGFLP6TqGezYV9p7BgzrRMvxy+WMP+G4hyV4zb5tmrQ7Aqrd6Brk
 suVqVuIHTcBTfMioJiIyDVRuswiRjuLs7XT4yZ9cYcJJ9xdWwxVwlovsWrRXh1OpvuL/
 a4K3jpMwj8vk52Ji8OvbP1IJV5fz4w3TzvJ1oK77UZrOo9fM/FUeJCsuzENqSdJSksjH
 A9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011980; x=1774616780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4oPB471eXj4owIYL5CBF7Q395nZGbkHiFon/ZP2/K+k=;
 b=heVxMqSCYG/dAdaXcQl8kFJzcNSzyC3XeW47QTd8DP+jrylytzdV3Qrss4axGczsTH
 1iyPS5PAT4IfalncsOZUlwq54xbsQbi8ZZvIXLGuVA+3OPMEuS7S5nqkhxaqyuimAqk9
 XC+eOYo8wnOHShczK4BuA9CW5lbMA+J7nAVQrwuS4Bh6zgjNSnsBmFv2T3QAvKOK1H0G
 E84t43szvfQo7RNZ/c2cxmAQyojCg3iP7fb39ZTQ1hLsLKTjjA14Awlfi14sKfPwvuQ/
 aPPnABJwRaFJnWX0o0+oPXp+4JBfhB9MF97vjpxs+ZmneDPuVgq052knzkQca1oAQQe2
 MP1w==
X-Gm-Message-State: AOJu0Yyneqf2q5/gixjpXnntN5Jw5JHP1QAab2uSr298EBuStZ8vTe7j
 4fh2I28a6Nt2P4Mjq8RE1v1h5p2O7gGmHk5CuCfyqWkjJOmS2ldCAFTiZwJKeKT5owE=
X-Gm-Gg: ATEYQzzO4ie4S7LD3to2wgI2dR+PK1CSwKjFgKOiUMJ6Vac1dt26QnJ7EdsoIcBDKAm
 vG8ns038iWOXxplvCHLnAdxwTofi8Qx2Qmbew2VEJgnfICQzCjuvCNM8/fND07i/2Onb/R7jkO8
 imE+xdXSBJcZwxGvbjaue+2LdoQ9phCb0NW1ho3mvdkisFCKPZk9SQv/7pPUxUJUo+95iQpnbEX
 lisl/jgH6pRwvPBQvVsifWwH9nXa1UuJHn9yNK0y7uJ42UGlpRytld+LkXKcW6tjpN6nNfvseYs
 ufKi4JdjxmaAZf+cXsitvdL2Uz9jRcBQ+ekBc6iLpN1by90tN25dCXgLP7ogccX/BViNXoHoLtg
 EVvvl5QapXpKpATMAkhJmmsqDaOn431lKoymcUe/k+4euha1TRLSbV8+jhsfC5TZRDcxyXe0nfc
 VsMz0Hdp81R6G2p4nnH/SGKrU=
X-Received: by 2002:a05:6402:5289:b0:666:ebb7:1232 with SMTP id
 4fb4d7f45d1cf-668c8f0492bmr2439429a12.6.1774011980404; 
 Fri, 20 Mar 2026 06:06:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668d1cc8a17sm1340445a12.18.2026.03.20.06.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E90C5FAEB;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 31/35] target/arm: enable event stream on WFE instructions
Date: Fri, 20 Mar 2026 13:06:02 +0000
Message-ID: <20260320130607.2071996-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now we can calculate when the next event stream event is we can re-use
the wfxt_timer and configure it to fire as we enter a WFE that is
going to sleep. Reverse the M-profile logic so we can enter a sleep
state in both profiles.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h           |  2 ++
 target/arm/cpu.c           |  5 +++++
 target/arm/tcg/op_helper.c | 37 ++++++++++++++++++-------------------
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9c25b60ae83..6a7d92d73db 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -967,6 +967,8 @@ struct ArchCPU {
     QEMUTimer *pmu_timer;
     /* Timer used for WFxT timeouts */
     QEMUTimer *wfxt_timer;
+    /* Are we in a WFE */
+    bool waiting_for_event;
 
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d51599dfdab..a0569f74cd5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -780,6 +780,11 @@ static void arm_wfxt_timer_cb(void *opaque)
     ARMCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
 
+    if (cpu->waiting_for_event) {
+        CPUARMState *env = &cpu->env;
+        env->event_register.as_bool = true;
+    }
+
     /*
      * We expect the CPU to be halted; this will cause arm_cpu_is_work()
      * to return true (so we will come out of halt even with no other
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index d513045269c..fbe160ab70a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -494,31 +494,30 @@ void HELPER(wfe)(CPUARMState *env)
 #else
     /*
      * WFE (Wait For Event) is a hint instruction.
-     * For Cortex-M (M-profile), we implement the strict architectural behavior:
+     *
      * 1. Check the Event Register (set by SEV or SEVONPEND).
      * 2. If set, clear it and continue (consume the event).
      */
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        CPUState *cs = env_cpu(env);
+    CPUState *cs = env_cpu(env);
+    ARMCPU *cpu = ARM_CPU(cs);
 
-        if (env->event_register.as_bool) {
-            env->event_register.as_bool = false;
-            return;
-        }
+    if (env->event_register.as_bool) {
+        env->event_register.as_bool = false;
+        return;
+    }
 
-        cs->exception_index = EXCP_HLT;
-        cs->halted = 1;
-        cpu_loop_exit(cs);
-    } else {
-        /*
-         * For A-profile and others, we rely on the existing "yield" behavior.
-         * Don't actually halt the CPU, just yield back to top
-         * level loop. This is not going into a "low power state"
-         * (ie halting until some event occurs), so we never take
-         * a configurable trap to a different exception level
-         */
-        HELPER(yield)(env);
+    /* For A-profile we also can be woken by the event stream */
+    if (arm_feature(env, ARM_FEATURE_AARCH64) && cpu->wfxt_timer) {
+        int64_t next_event = gt_calc_next_event_stream(env);
+        if (next_event > 0) {
+            cpu->waiting_for_event = true;
+            timer_mod(cpu->wfxt_timer, next_event);
+        }
     }
+
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
 #endif
 }
 
-- 
2.47.3


