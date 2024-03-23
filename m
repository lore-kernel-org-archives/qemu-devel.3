Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D815C54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5CF-0002mN-Ef; Sat, 23 Mar 2024 13:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5CD-0002m3-NM
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C6-00066L-1P
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso2237718a12.0
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711215008; x=1711819808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APeG/8zopMeZ+EKfHuhSVKWY0YScOPqHRLuO02LWlN4=;
 b=hSydgXbMKBcw1FiSlZAAtb2w2F8ssg3MHr4jmjrX99U8AMUoXx4lMdwDbStUWg2xU1
 5Ya+rf2MRpWk/zxOylMWqEWIIjw3LRvQaYmA0gsP3H6QwZE9T/U9GMLPVpkHWMaiyjJV
 ijOrX4s0nFHIL495mP7nUBGHBHCZ+0g4ePQnmwkZQbuaAxU8wzFeGYNRL/AuSGsnZJ6L
 4kgDUt4cxmbDUKyDO6F8xhT8Bs8HGbRUCkbdlgQYE0wP35iIV13GOFfVXuFQCH2hEsZw
 eYUEzjvH1d8XdRi27M4lOCvcDcJ/jjxyU0NJ6RLRUdI9A2+O0/1sSDJWBKRh8aH0+4Os
 CmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711215008; x=1711819808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APeG/8zopMeZ+EKfHuhSVKWY0YScOPqHRLuO02LWlN4=;
 b=bkZ3UC0gshM/bq3sbwlSQDNSYFmw8Ql2n2pEmQi0AUOr6m+yYxo5AQNC3KaLwqY/eo
 dV3KQerm9wLpULM1KS/DHUutrTbRsM2euBjkriAMGuMF6i3eC2TghqdeY520KRHfwceg
 QwqFgRMMgElLS3B4uGCVhT6uM5NOTeDZH4KpkKR7s5UdatJHdzNQEuPvYmFgo38ZlAwN
 f8CfIVFGBlh0XBjxlYcRi3nDU+pPCLQmKfDUq2LW5BWxmqemaGcddEoW8l4DRIhJ6kZo
 in3+LkHM+hRID++XBqD4O7IgCaJ4seYr4S2GzQ1zPGBxh2f3umAxH8hxFNQ4Oake14bl
 Uv4g==
X-Gm-Message-State: AOJu0Yxl68fZR8DgeW5vRE7H0bChEZUQnWTaXUczDl1s1BuTnXb36tkj
 WtCMI0GiVkJXzaa5+/9io8zshDmcEsFTo3uKw5HWV9W6VhmS58iRmkOuRasangv77wFvi4TF4UG
 z
X-Google-Smtp-Source: AGHT+IFVWefvO/kOLQLT8VoMELhOKeQUHilMQDhivOpUx8S792WCq8ngmfEVw25mwvumTF1POCdDCw==
X-Received: by 2002:a17:902:e54d:b0:1d9:4ede:66b5 with SMTP id
 n13-20020a170902e54d00b001d94ede66b5mr3428591plf.15.1711215008371; 
 Sat, 23 Mar 2024 10:30:08 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:30:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH v2 7/7] target/hppa: Fix EIRR, EIEM versus icount
Date: Sat, 23 Mar 2024 07:29:54 -1000
Message-Id: <20240323172954.1041480-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323172954.1041480-1-richard.henderson@linaro.org>
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Call translator_io_start before write to EIRR.
Move evaluation of EIRR vs EIEM to hppa_cpu_exec_interrupt.
Exit TB after write to EIEM, but otherwise use a straight store.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 -
 target/hppa/int_helper.c | 14 ++++----------
 target/hppa/translate.c  | 10 +++++++---
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 1bdbcd8f98..8fd7ba65d8 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -91,7 +91,6 @@ DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tl, env, tl)
 DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index efe638b36e..90437a92cd 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -28,7 +28,7 @@
 static void eval_interrupt(HPPACPU *cpu)
 {
     CPUState *cs = CPU(cpu);
-    if (cpu->env.cr[CR_EIRR] & cpu->env.cr[CR_EIEM]) {
+    if (cpu->env.cr[CR_EIRR]) {
         cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -89,14 +89,6 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ulong val)
     bql_unlock();
 }
 
-void HELPER(write_eiem)(CPUHPPAState *env, target_ulong val)
-{
-    env->cr[CR_EIEM] = val;
-    bql_lock();
-    eval_interrupt(env_archcpu(env));
-    bql_unlock();
-}
-
 void hppa_cpu_do_interrupt(CPUState *cs)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
@@ -280,7 +272,9 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
 
     /* If interrupts are requested and enabled, raise them.  */
-    if ((env->psw & PSW_I) && (interrupt_request & CPU_INTERRUPT_HARD)) {
+    if ((interrupt_request & CPU_INTERRUPT_HARD)
+        && (env->psw & PSW_I)
+        && (env->cr[CR_EIRR] & env->cr[CR_EIEM])) {
         cs->exception_index = EXCP_EXT_INTERRUPT;
         hppa_cpu_do_interrupt(cs);
         return true;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5b8c1b06c3..46b2d6508d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2166,10 +2166,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
         gen_helper_write_interval_timer(tcg_env, reg);
         break;
     case CR_EIRR:
+        /* Helper modifies interrupt lines and is therefore IO. */
+        translator_io_start(&ctx->base);
         gen_helper_write_eirr(tcg_env, reg);
-        break;
-    case CR_EIEM:
-        gen_helper_write_eiem(tcg_env, reg);
+        /* Exit to re-evaluate interrupts in the main loop. */
         ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
         break;
 
@@ -2195,6 +2195,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 #endif
         break;
 
+    case CR_EIEM:
+        /* Exit to re-evaluate interrupts in the main loop. */
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+        /* FALLTHRU */
     default:
         tcg_gen_st_i64(reg, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
         break;
-- 
2.34.1


