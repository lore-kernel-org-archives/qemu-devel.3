Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAA41098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYe-00033z-Jz; Fri, 20 Mar 2026 09:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYb-00030O-5U
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:29 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYX-00065n-Uo
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:28 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso316999466b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011983; x=1774616783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pssv4yiloRewG2kTYaAF6W2Bd+ecbZHh3uu6HTuwmWY=;
 b=rfS0RcJZ+QBo+205Aa3D00uM6eoaDB2ILJBXMM+isfFXLYVTey1rKa5wm7Xhaqjf4R
 T3E/oCX1S1HIO7jSlAfB/jE0cYGMAg21fpWfRPgEHYrWt9GQE6iJWDBUgZJKgtEfukxo
 XA56CKz5kh+WNUf6qshcQcJZYLQZjq4IYuNjQHwBzPrRQRYUTGuQSQwL5aDCMV/M6Rg0
 +0IkhNARUQ1wcaiX8BQTTGZ0BviMmr5XhRwp1zRgHdEp0otX0QeJ7jCfQ414NwLg+8X+
 oEzUaxGuqUlR1OoCD18qNuYCwYHywEzjLJz/s5Sp82dNWJRq3MC9CFeeIte5/7hbuWv9
 /6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011983; x=1774616783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pssv4yiloRewG2kTYaAF6W2Bd+ecbZHh3uu6HTuwmWY=;
 b=OlAwp3jZUpkUCREwPc2yzVeesGw3jWjQyxG6qwqj+c3pu0oe0ZU2wM5TF6Qq9mNlir
 AmWBl7LfYvOvkVpgD0z4cBBo/xY6cxgJZym619jQgGafptK5qHJWR+gFb678lXFVKHMj
 IPiyGYyV32xHyhFzHdQjKXmPlca573n9yCGX+GeyLVtNRMJFKm9WyemSC+IA2/OMh1Qw
 H0vfrrDQtqEhEnkaAojGF8f43H3aBWcvrtMe82SZAvuNX/YXTJwXZbnRaKxgzG5K1eGE
 cvCREtmhqeq401+CxuEc7jx8Fxl/aK/aFGltuFibImDRmpdKaAmzHib2xNJG4d3w/epg
 KPcA==
X-Gm-Message-State: AOJu0YyVYQ5kto6NpAYszyFphsZsxhjxVTukZYX+P7KCpAQSRUJAAHaj
 m5Qq8HnxpxzjsT6KCHjOHfjtyC33YyjmUr/krybUqFSLXDYSSRiw1ZQiZA8mcGHNfwg=
X-Gm-Gg: ATEYQzzgx52sl1pdO8Zab9nRtBZ2dvm5BwAsdn+V6eJ+ekmPwPIJDy8CzXdgDUEYr+p
 L8W3cb6hH64PUKKZJYdV+b+phk4KqCPZBoknyyeO92/K0kCpCJaLVhkBbYW9hn0hc0k78Xl5KpA
 O97FUHIPqnPUvrO1JG54335UFu731qt8E17kGKQLELp4rOEXfahIK2Y5gyHcMwP/mpLI7461fiF
 EOrOda1IEWg6Icb8Kj3BhEcioDWcWO8OTfmaFiz/TBRNiF42tQ0COFlDJdlCD0uV60mhNny7aBy
 SdygIVUEsWYbLKrQlUaXEN8pXV/oOFZJ4YK7JrE44yd6XxNDESxBXrsh9ZUK+sgZcMxSMJOKmyq
 d//VJUSrSGmtyt35nksNVMKwo5m4uZsNMNR1dZdEC1Zlh5BVplbNmBWPmdlrJTjSxHOrDvg9yX9
 YlJ484uLeL85Me+BxchaoVcRo=
X-Received: by 2002:a17:906:13c2:b0:b97:61d7:793f with SMTP id
 a640c23a62f3a-b982f282a9fmr176763866b.24.1774011983417; 
 Fri, 20 Mar 2026 06:06:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f9024asm162354166b.26.2026.03.20.06.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 085965FA5C;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 27/35] target/arm: wrap event_register in a union
Date: Fri, 20 Mar 2026 13:05:58 +0000
Message-ID: <20260320130607.2071996-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

While the event register is either set or not due to the
implementation defined nature of bool types we can't set it directly
from TCG code. By wrapping in a union we can alias a 32 bit value to
the bool in a future patch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h           | 9 +++++++--
 hw/intc/armv7m_nvic.c      | 2 +-
 target/arm/machine.c       | 4 ++--
 target/arm/tcg/m_helper.c  | 4 ++--
 target/arm/tcg/op_helper.c | 6 +++---
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bf6cf74c2e1..9c25b60ae83 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -763,9 +763,14 @@ typedef struct CPUArchState {
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
-     * WFE/SEV handling is currently implemented only for M-profile.
+     *
+     * It is treated as a boolean but we need the union so we can set
+     * it from TCG.
      */
-    bool event_register;
+    union {
+        bool as_bool;
+        uint32_t as_uint32;
+    } event_register;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a7651f831eb..d630f80e51a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -238,7 +238,7 @@ static void nvic_update_pending_state(NVICState *s, VecInfo *vec,
         int scr_bank = exc_targets_secure(s, irq) ? M_REG_S : M_REG_NS;
         /* SEVONPEND: interrupt going to pending is a WFE wakeup event */
         if (s->cpu->env.v7m.scr[scr_bank] & R_V7M_SCR_SEVONPEND_MASK) {
-            s->cpu->env.event_register = true;
+            s->cpu->env.event_register.as_bool = true;
             qemu_cpu_kick(CPU(s->cpu));
         }
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b0e499515cf..844e6a37c77 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -514,7 +514,7 @@ static bool event_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.event_register;
+    return cpu->env.event_register.as_bool;
 }
 
 static const VMStateDescription vmstate_event = {
@@ -523,7 +523,7 @@ static const VMStateDescription vmstate_event = {
     .minimum_version_id = 1,
     .needed = event_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_BOOL(env.event_register, ARMCPU),
+        VMSTATE_BOOL(env.event_register.as_bool, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index a0cb8cb021e..3259e624e02 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -964,7 +964,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
      * take (which might now be the derived exception).
      * Exception entry sets the event register (ARM ARM R_BPBR)
      */
-    env->event_register = true;
+    env->event_register.as_bool = true;
     armv7m_nvic_acknowledge_irq(env->nvic);
 
     /* Switch to target security state -- must do this before writing SPSEL */
@@ -1910,7 +1910,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     arm_rebuild_hflags(env);
 
     /* Exception return sets the event register (ARM ARM R_BPBR) */
-    env->event_register = true;
+    env->event_register.as_bool = true;
     qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 635c538ed4b..b5c8024ace7 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -476,7 +476,7 @@ void HELPER(sev)(CPUARMState *env)
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
         if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
-            target_cpu->env.event_register = true;
+            target_cpu->env.event_register.as_bool = true;
         }
         if (!qemu_cpu_is_self(cs)) {
             qemu_cpu_kick(cs);
@@ -503,8 +503,8 @@ void HELPER(wfe)(CPUARMState *env)
     if (arm_feature(env, ARM_FEATURE_M)) {
         CPUState *cs = env_cpu(env);
 
-        if (env->event_register) {
-            env->event_register = false;
+        if (env->event_register.as_bool) {
+            env->event_register.as_bool = false;
             return;
         }
 
-- 
2.47.3


