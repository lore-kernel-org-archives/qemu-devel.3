Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9CDC54E68
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIv-0002o0-Fc; Fri, 15 Mar 2024 21:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIt-0002mU-Ck
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:43 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIr-0000ij-6o
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:43 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5cdbc4334edso1627687a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554260; x=1711159060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GryAJXFnUj11zs8uoNqYE1HevxmAcx5O0dvpjg9Kdo=;
 b=fr5Rd8qizMkRpHiKVKSDyTvDZ5N5xCH0fnImn6PdBwpoCHQVTLQ419I5reLDU6gsdv
 3Bjw2bcNjv+EI2M4Ksfiw3LOqW3xj4qVYAsSg5xVf7Yr4PBZN1TkQpBW4O6nDuxx5Zhi
 zuIuFTokXJGapIqYiCuWs1pChPYrT7KM/2Ub+bOMLgPRnRZ8AGW418Lufh5K9yst4MOK
 U6e+vumKfog98FepOaI3txXLvK6WJ6PIzpwPTgqtisd2j2PYhiPJoUisWXDU/WxubnCw
 3nuPwIn3tifD6v5GlZbB6LNIG77M5DytM9vrthjtZyXUHLAtI4KEvdad94fLCZGCdS4B
 KE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554260; x=1711159060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GryAJXFnUj11zs8uoNqYE1HevxmAcx5O0dvpjg9Kdo=;
 b=YFWEcmR9N0MKMgomnkX4ncvTsO7WgcL8F1qy+WHfs57PPXGnHFcFCHH/1rLr0xHNgk
 kDUAt+6ZEnhXrmDJhKNNhTj7VDrSbZiKSogyF6eytxKD5IYs23RY+67S/jdk1Y+Xo8p3
 WKLiwnk4wndhHFQZhspQN+1uaY5E+qfjrR5FVCrbh9gyc190S4cCCVg510Y0iGDhGAr+
 X/r6XdPwFGjB5/hVHyXciASr62ybU1R58I8ON92ejxqRtJDCUxBIOrrFKRAqaWeLdtO5
 tWo37FQ01nSdW1ZPucsojdpAb8PjEJGQ2MRDdMMzMQclcxcVCi+Q3onNX+0i4cIYl7MN
 LzxA==
X-Gm-Message-State: AOJu0Yy0V/gHqUVoA9T0hJvxjqnGAqe+p1BI5lCZQXqBVGZm0xjBK2XK
 TjnSB43P/8q7OJOTrw9uRahBc2aOISXXUlm3RNz6Tlro7nXKatVXhXW2fC/i37grlrFp9DQTOS9
 Y
X-Google-Smtp-Source: AGHT+IHFhP52+OweqqIyFLe2g17m8VTkg2UQkhEuUj10MhWyC+TyJPczziveuw9xmi0Q49Dqhblmbw==
X-Received: by 2002:a17:902:7d98:b0:1dd:de0f:c01e with SMTP id
 a24-20020a1709027d9800b001ddde0fc01emr4439010plm.37.1710554259849; 
 Fri, 15 Mar 2024 18:57:39 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 07/22] plugins: Use emit_before_op for PLUGIN_GEN_AFTER_INSN
Date: Fri, 15 Mar 2024 15:57:05 -1000
Message-Id: <20240316015720.3661236-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index c56f104aee..8fa342b425 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -207,8 +207,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
-        gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
-                    gen_empty_mem_helper);
+        tcg_gen_plugin_cb(from);
         break;
     case PLUGIN_GEN_FROM_INSN:
         /*
@@ -614,16 +613,6 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
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
@@ -709,11 +698,14 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
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
@@ -772,16 +764,49 @@ static void pr_ops(void)
 
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
@@ -846,19 +871,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
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


