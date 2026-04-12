Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEA3F3ED67
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 02:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBkSG-0004Jp-2a; Sat, 11 Apr 2026 22:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkSF-0004JU-8H
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:43 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkSD-0000ca-F9
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:43 -0400
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8a3b0242631so39291466d6.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 19:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775960500; x=1776565300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vazYcj8GwpUqusYCDniEwJxYizenODa1Oa0Jn+0NlQQ=;
 b=CjSdkGAuncLKJ+k1frGeTMPQool1+ZXS8zYT8H+3OeLocYGo12jELlCWE+YNbhu/dU
 zEkMtTORNfJNemfyqDq+MqW9DGI28U6CQ/63NRKoFl8YJU0n3HrUbXqfKmKYzEWkCGUR
 8UUDKQifSxuNoLaQRtHxDRf8v1qeKFod6dglUKHBVR6bJ8lQ8IfaQ8WsVQfex+/yJMH7
 x+HiS3EFPjixDB9xMz0Ss+qJU8frvqgI1+ojfoM+a3Bm6IhEjYglXdMfnAQ6iQ693uRD
 g7Zdox2DvrQMEsm1lzmccZUQvdxpx0Nugj9PpbWELkk0ZmODLeilSkyE0fKvdgeixejx
 P/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775960500; x=1776565300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vazYcj8GwpUqusYCDniEwJxYizenODa1Oa0Jn+0NlQQ=;
 b=eoz9//NXU29s6DrTRqyXUz82n1HLVOKB8tlNaChqrovleq725DTa9ZScmZCgWCP5EY
 mn2dnD95JOTusdC4A/a97t68EADHzBdIJpFXaOga9CudbSzr6DVO0PMRVWqv+1afQBFV
 FYUgZGTKCI3RQGiQFJOW0BPPh6odLxRYW+MRfq6lSXx0rYzbywiJKU4COhDEeNNrEsO3
 1ZIk3w6IOncWqD0lPSW15EImn/C23FTdP5CsCuRjlA5uXTY1T/ntIEr5umLkM1bVtcb6
 KwdJGyo2dHIU49vQOpWNXUPmNvJJAiYP/YFKg8+vxU1bhTHtw5T/1BMa+lO7AqdWPMoB
 9VMQ==
X-Gm-Message-State: AOJu0YyZJT3MB6jye6wsuvXuyAc/OT/Tk2PFvz/q2+2BnI5Y1bOGjBUE
 jDwacfh1je++nvhTdJN2qeRSdX2tYXOA1Coko/2N/TgchQSehHvrtSTw
X-Gm-Gg: AeBDiesRQZidFsxrGfWJJ4iYp2Cgl6eFmd+1plMBWsiVHOR/6U+qx0OPOBrhP5Iafbu
 wY35YBJ2NG2PsksOB93APSeqn9ldxpsVJWIkct2NRWS2OF6QsZxYIyzJ4frsiYoU/2rr4FkQYoz
 dfWULtmnc6AZe5cHEXtggxPHEIkqdzfEl2n9nTUASVr2uis6dRNhL8sxXgCvsoy0eGXrig+6ZmO
 mQTyK4pS312bOVvnwiv3tXOyLibXmBUo/mBJbY0bShLk3TQZAJrfjE6OQIa4uHnXMPc9R/eC1X5
 aDpv2SB3Khj0/VN56W1SAe/LPrUZmji9JV3ULksf1vxZrpALErI+u93YlR9OSLuK0502b+p6Pl0
 XgKIwviP4UJl66oMO+ICxvZOMAxUjMM5lS6oX3OZyXsXSRPzURYvx6MIXLJ2p4cLNgc1XkKoI99
 DaxUbVsnNyZIsocv7gD+9JK5Q63ZXVbHPcs40NzETMXRB3Dq3Cg03lI1L5I1GSK71blrfM
X-Received: by 2002:a05:622a:4009:b0:50d:ce35:6e67 with SMTP id
 d75a77b69052e-50dd5ba3bd7mr124645941cf.42.1775960500394; 
 Sat, 11 Apr 2026 19:21:40 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca05592ecsm15455576d6.29.2026.04.11.19.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 19:21:40 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 7/7] target/riscv: add sdtrig trigger action=debug mode
Date: Sun, 12 Apr 2026 10:20:24 +0800
Message-ID: <c2838d2c9fc0135bf346ee3754d5e519157bab9d.1775959096.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf42.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Allow mcontrol/mcontrol6 action=1 when Sdext is enabled. When such a
trigger hits, enter Debug Mode with cause=trigger and stop with
EXCP_DEBUG.

Also report inst-count triggers in tinfo and read their action field.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 target/riscv/debug.c | 53 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5877a60c50..6c69c2f796 100644
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
+            qemu_log_mask(LOG_GUEST_ERROR,
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
+            qemu_log_mask(LOG_GUEST_ERROR,
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
+            qemu_log_mask(LOG_GUEST_ERROR,
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
2.53.0


