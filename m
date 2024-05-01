Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0F0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6G-0002rQ-42; Wed, 01 May 2024 10:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5i-0002fl-Fs
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5g-00027c-G6
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ec85c2f469so6239705ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574267; x=1715179067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+chihv+aCHSo8sD0JFlhAbGFbkZ1HxgertwSMQKsZo=;
 b=dUw5Gb0RKNUbheHth2F8cKp984zPnnAWTEsgMGpW70DXZVp0Xs9gKaNVIbF0G5iIjg
 pvuKKxOm+17ZNFI0TXFsNPo3Bi6yV5D+oeHM6qW5CZ5PBxtTHjO7GcvnmRMQlYlno5/A
 4m6VYnZjHqqs8ma6nni8ufSpCmk/RWruGkH7++xO9cbBxXtry/RIQ9A8pPxH3crj+F9W
 Zhq0gcx7b1BwxYN6RL60cmHz1Ey5X79liHxZhUL4i9FBa6/FByh3t9JiIuYAY7uMUNsW
 VrS4Cjuni8WKj96d8mnXWdO/F2YfXUJot9OwY/nnj1JIyFZ2wxZyRUVGCXcxtSpgrVXE
 +Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574267; x=1715179067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+chihv+aCHSo8sD0JFlhAbGFbkZ1HxgertwSMQKsZo=;
 b=QYITX83F43mb5TdSidjrtDZ7OoIDz3VmEajWXCNedBET2YOovnihm2MfH+yLgVvlXA
 RrTnXB5VomkCb4B2x6iKZfJRSze83ePRw9xZx80GVft7ia3Q3sSiivWijX0M8foyRhJg
 bYpqFH235bZO1GvzCSRCHqH7MkMV5Az/YhWwcFPM58ZqLNSPx7z6vz+7kxxHH1kFd/+B
 bwIgneuwuW3Z9WBj69UcCvPlLrZtQyKJYkTa0/a7lM2X4bVF0q6lGK23OUTjTSZDo1H4
 g+CfOY/qL6WmZDH44VJIYZ0kyGRvqNBcsJMV3N2f4fTbj5qeByI1dsgi9n9nj516DrMQ
 r44g==
X-Gm-Message-State: AOJu0YxB4LFNWDrOgHBZdv9FgEKOvdxCW+HeGM7oYAfiSo6OC+j2UyQm
 bT4lB1eNDvfldBDwDthtczGSEd0eB34H/Vp6QzIMtPKm9PBtJCQ00suSXKiT3ykP3Oz8NfVAz3v
 W
X-Google-Smtp-Source: AGHT+IHrLjmI46ApGo9WN4Lc7K6s6FIYACFiHxGnNrx5KZBw9QmINcZoczFf3DqVRtExcpwq6kLZfg==
X-Received: by 2002:a17:902:8b89:b0:1e4:733c:eac8 with SMTP id
 ay9-20020a1709028b8900b001e4733ceac8mr3709168plb.8.1714574267276; 
 Wed, 01 May 2024 07:37:47 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/20] plugins: Use emit_before_op for PLUGIN_GEN_AFTER_INSN
Date: Wed,  1 May 2024 07:37:25 -0700
Message-Id: <20240501143739.10541-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Introduce a new plugin_cb op and migrate one operation.
By using emit_before_op, we do not need to emit opcodes
early and modify them later -- we can simply emit the
final set of opcodes once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  1 +
 include/tcg/tcg-opc.h       |  1 +
 accel/tcg/plugin-gen.c      | 74 +++++++++++++++++++++----------------
 tcg/tcg-op.c                |  5 +++
 4 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2d932a515e..9de5a7f280 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -74,6 +74,7 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
+void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
 void tcg_gen_plugin_cb_end(void);
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index b80227fa1c..3b7cb2bce1 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -197,6 +197,7 @@ DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
+DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
 DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 4b488943ff..4b02c0bfbf 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -201,8 +201,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
-        gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
-                    gen_empty_mem_helper);
+        tcg_gen_plugin_cb(from);
         break;
     case PLUGIN_GEN_FROM_INSN:
         /*
@@ -608,16 +607,6 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
     inject_mem_helper(begin_op, arr);
 }
 
-static void inject_mem_disable_helper(struct qemu_plugin_insn *plugin_insn,
-                                      TCGOp *begin_op)
-{
-    if (likely(!plugin_insn->mem_helper)) {
-        rm_ops(begin_op);
-        return;
-    }
-    inject_mem_helper(begin_op, NULL);
-}
-
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -703,11 +692,14 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     inject_mem_enable_helper(ptb, insn, begin_op);
 }
 
-static void plugin_gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
-                                          TCGOp *begin_op, int insn_idx)
+static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
+                                   struct qemu_plugin_insn *insn)
 {
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-    inject_mem_disable_helper(insn, begin_op);
+    if (insn->mem_helper) {
+        tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
+                       offsetof(CPUState, plugin_mem_cbs) -
+                       offsetof(ArchCPU, env));
+    }
 }
 
 /* #define DEBUG_PLUGIN_GEN_OPS */
@@ -766,16 +758,49 @@ static void pr_ops(void)
 
 static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 {
-    TCGOp *op;
+    TCGOp *op, *next;
     int insn_idx = -1;
 
     pr_ops();
 
-    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
+    /*
+     * While injecting code, we cannot afford to reuse any ebb temps
+     * that might be live within the existing opcode stream.
+     * The simplest solution is to release them all and create new.
+     */
+    memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
+
+    QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
         switch (op->opc) {
         case INDEX_op_insn_start:
             insn_idx++;
             break;
+
+        case INDEX_op_plugin_cb:
+        {
+            enum plugin_gen_from from = op->args[0];
+            struct qemu_plugin_insn *insn = NULL;
+
+            if (insn_idx >= 0) {
+                insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
+            }
+
+            tcg_ctx->emit_before_op = op;
+
+            switch (from) {
+            case PLUGIN_GEN_AFTER_INSN:
+                assert(insn != NULL);
+                gen_disable_mem_helper(plugin_tb, insn);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            tcg_ctx->emit_before_op = NULL;
+            tcg_op_remove(tcg_ctx, op);
+            break;
+        }
+
         case INDEX_op_plugin_cb_start:
         {
             enum plugin_gen_from from = op->args[0];
@@ -840,19 +865,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 break;
             }
-            case PLUGIN_GEN_AFTER_INSN:
-            {
-                g_assert(insn_idx >= 0);
-
-                switch (type) {
-                case PLUGIN_GEN_DISABLE_MEM_HELPER:
-                    plugin_gen_disable_mem_helper(plugin_tb, op, insn_idx);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            }
             default:
                 g_assert_not_reached();
             }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index aa6bc6f57d..0f2026c91c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -312,6 +312,11 @@ void tcg_gen_mb(TCGBar mb_type)
     }
 }
 
+void tcg_gen_plugin_cb(unsigned from)
+{
+    tcg_gen_op1(INDEX_op_plugin_cb, from);
+}
+
 void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
 {
     tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-- 
2.34.1


