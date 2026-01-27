Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AA9D2F029
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiwI-0007Jr-RK; Tue, 27 Jan 2026 08:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiwF-0007FG-GN
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:59 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiwB-0004cO-E2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:58 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a7a94c6d4fso26742795ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769519814; x=1770124614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7WkHiVNJCD9TWHbxn4o1h9ogKNZelcybfMD61+3Zog=;
 b=QcJlRxDIXWrLF4Ly/tUfWFIIqXYF6wDiKziLg2INKIEEpEKt3Wdw6MHf3DT9Aa0KK1
 ABaDpslwE9HzA6RfoCZF8HmEH6SYAFxl8vab/g9IrA8albVz/apLIm1xFAKDKgg0XZQC
 MiqbU+7rm8QXSCVI1raIx9HUnhxGqVALVBAgOyOk2P7jA7s31LOB5rjcX0Sl+PddfLUH
 Ul3XOTS3ESbLzxF/HRZYWYtMvHgAc7wRC4cy/nJeYarFi2BeVds1k25Gda1BeR3e+lt5
 zfq+O9KC23NfSGhaChTfLH/Hf3DhdiG3YHXpeGxLGyfLhBJNq21nSpxcTkFjp4GiJKrm
 3p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769519814; x=1770124614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O7WkHiVNJCD9TWHbxn4o1h9ogKNZelcybfMD61+3Zog=;
 b=D73E/JsVocDQuQIi+5O9cVhbD+EcLLRAmXMDboRmQ8CQ/pN4eqcM2nddsXJ7d3p5K0
 jiHLJdBqsX/qeIIUhMLYjBu5mKfniIQhMMM6G/WaI3DDD2k1iAuoDCcQ+LIcgvPoVcun
 EE0KJLmCn9XSRVl2rl7q6tf2gSXocedtdwG3JCDMEGqCNVAlo0fi/0fsmpkGowRttAza
 HCiUwKpox/zqSv1KA5xINn7Y/LdQ0hkNhBC+ls15di0OZXroOa8rDF9BVg1BbAuzdECh
 WMK9CcOWy5WTcmBbCkJ1VNewWCJINEzeHWsTXTMfBVQQRLS3ldqQOlNh217HHGBocJdY
 5xIw==
X-Gm-Message-State: AOJu0YwY7MUSpAPYhK3iI8cnYWCEjyuKLxZ7VTHMx2PHSUq03EygBNIg
 tUEDRnoWZ6ciZeyvGu1hNymIEi6xjACq8IWSMonQBrYN9YgDcdp6Bfwq7dgBGAxL088WWw==
X-Gm-Gg: AZuq6aLIUGHF8yfL5olXSL67EbzUU0hX+gl3AluZ6p06+T6L47fd4UvvjiHO34LY7X/
 O0d62WM513GWxQQ1UzjBM60IyjxbLxpssHUWEaYOFoqvDAq7BlVbjpITD+Tf0mzdmW3ogYldzJx
 3slt38kkH+u+BO31cL2JyZdDJEqZN6ChdNC3Q8gM+IHnLgIcmzgtl3XCoqsAfOua3mSlm3rvVrd
 DcbThewyysvgN249OHTKFujOH9W3v3gLnCL/jrGoGHNi0TaeuXrk1G7KMIWL8XGcyObEFMAxHCe
 h19D6MaBqgg5QUfce9LMa4KqwUQ++wyRyWiz+xGbboxdq2sTwAzjpYsszd4OuH+B3htocZ3l2j2
 tLUn4FxYK+mkw9Zj32x6ajunb42DE0D1qVjxioAaTLy7OZgXgsh4vVlVxD1G5Glw1LKDHLHkOT8
 fCSHSbQzeW/e1/vS7a+q/2ZSDOn3rk335yvl3ZmXh3BfEKne4ABR2EYB5C8bQ=
X-Received: by 2002:a17:902:da2d:b0:2a1:3cd8:d2df with SMTP id
 d9443c01a7336-2a870e35032mr17078785ad.54.1769519813648; 
 Tue, 27 Jan 2026 05:16:53 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.23.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb03b4sm117164345ad.82.2026.01.27.05.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 05:16:53 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v3 7/7] target/riscv: add sdtrig trigger action=debug mode
Date: Tue, 27 Jan 2026 21:15:51 +0800
Message-ID: <0fa8cc505f0c9f863aecc71710f77c7af76d7586.1769517768.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
References: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Allow mcontrol/mcontrol6 action=1 when Sdext is enabled. When such a
trigger hits, enter Debug Mode with cause=trigger and stop with
EXCP_DEBUG.

Also report inst-count triggers in tinfo and read their action field.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/debug.c | 53 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5877a60c50..4e30d42905 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -110,6 +110,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
         action = (tdata1 & TYPE6_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_INST_CNT:
+        action = tdata1 & ITRIGGER_ACTION;
+        break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
@@ -280,6 +282,7 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
 
 static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
+    CPUState *cs = env_cpu(env);
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
     switch (action) {
@@ -289,6 +292,21 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
         riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         break;
     case DBG_ACTION_DBG_MODE:
+        if (!env_archcpu(env)->cfg.ext_sdext) {
+            qemu_log_mask(LOG_UNIMP,
+                          "trigger action=debug mode requires Sdext\n");
+            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
+        }
+        riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_TRIGGER);
+        /*
+         * If this came from the Trigger Module's CPU breakpoint/watchpoint,
+         * we're already returning via EXCP_DEBUG. Otherwise, stop now.
+         */
+        if (cs->exception_index != EXCP_DEBUG) {
+            cs->exception_index = EXCP_DEBUG;
+            cpu_loop_exit_restore(cs, GETPC());
+        }
+        break;
     case DBG_ACTION_TRACE0:
     case DBG_ACTION_TRACE1:
     case DBG_ACTION_TRACE2:
@@ -441,6 +459,7 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
 {
     target_ulong val;
     uint32_t size;
+    uint32_t action;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH);
@@ -448,11 +467,25 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
     /* validate unimplemented (always zero) bits */
     warn_always_zero_bit(ctrl, TYPE2_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE2_CHAIN, "chain");
-    warn_always_zero_bit(ctrl, TYPE2_ACTION, "action");
     warn_always_zero_bit(ctrl, TYPE2_TIMING, "timing");
     warn_always_zero_bit(ctrl, TYPE2_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE2_HIT, "hit");
 
+    action = (ctrl & TYPE2_ACTION) >> 12;
+    if (action == DBG_ACTION_BP) {
+        val |= ctrl & TYPE2_ACTION;
+    } else if (action == DBG_ACTION_DBG_MODE) {
+        if (env_archcpu(env)->cfg.ext_sdext) {
+            val |= ctrl & TYPE2_ACTION;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "trigger action=debug mode requires Sdext\n");
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
+                      action);
+    }
+
     /* validate size encoding */
     size = type2_breakpoint_size(env, ctrl);
     if (access_size[size] == -1) {
@@ -569,6 +602,7 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
 {
     target_ulong val;
     uint32_t size;
+    uint32_t action;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH6);
@@ -576,11 +610,25 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
     /* validate unimplemented (always zero) bits */
     warn_always_zero_bit(ctrl, TYPE6_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE6_CHAIN, "chain");
-    warn_always_zero_bit(ctrl, TYPE6_ACTION, "action");
     warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
     warn_always_zero_bit(ctrl, TYPE6_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE6_HIT, "hit");
 
+    action = (ctrl & TYPE6_ACTION) >> 12;
+    if (action == DBG_ACTION_BP) {
+        val |= ctrl & TYPE6_ACTION;
+    } else if (action == DBG_ACTION_DBG_MODE) {
+        if (env_archcpu(env)->cfg.ext_sdext) {
+            val |= ctrl & TYPE6_ACTION;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "trigger action=debug mode requires Sdext\n");
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
+                      action);
+    }
+
     /* validate size encoding */
     size = extract32(ctrl, 16, 4);
     if (access_size[size] == -1) {
@@ -919,6 +967,7 @@ target_ulong tinfo_csr_read(CPURISCVState *env)
 {
     /* assume all triggers support the same types of triggers */
     return BIT(TRIGGER_TYPE_AD_MATCH) |
+           BIT(TRIGGER_TYPE_INST_CNT) |
            BIT(TRIGGER_TYPE_AD_MATCH6);
 }
 
-- 
2.52.0


