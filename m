Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEFFC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B5q-0002gv-W4; Wed, 01 May 2024 10:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5k-0002fu-8l
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5h-000281-Jc
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ec4b2400b6so15850345ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574268; x=1715179068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmGbooE7MMw6U3zKUesAFTGouJdUS0zDOY8tro2IA3U=;
 b=HuFebopbOYN2vvIkfMQ/vFyBsvayuSNRXbP/Df0Dy8GxXMfFdcCJw+6WX17iRLPNEH
 JVBp09WfpiJ1tKuPiasT1d0zvO+JvBGM+WX7sS6I/zyn3T2cB8GoRcr4tptBk1Sce9IO
 whDwJIPi4mwoPTf03NZY/Vzmy9iHbma9m/l+x4rXCat1e4uWJdFKYa2vWVhyqgmk6Wn+
 865zWKsqkOeOg8Kd9wAAQmu8Z28j3eouuhkZ+k227H6NSDdIN6aWy2LZDgDbDp0KhoyX
 0p5zTbMiy4h5w0WSgHEkfhk5eu3qQZoSN8lcYHUKzlqT0fqC+vRUVv31dWkeIrOMHwL2
 GUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574268; x=1715179068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmGbooE7MMw6U3zKUesAFTGouJdUS0zDOY8tro2IA3U=;
 b=VDQTBz14PBQJ9fgkrDsYp/srVhN0iqJ/oOL31kpVECQgP1jUQNi2mE79s5Es2O1wM9
 iCBduH8qdFge+q5lJiXtTtmQN0KcN1qc4mDmc+hUHcJ8Ej3KRQFZVFEiKw0g5iUD21fo
 UgWrsQqGo6uoW0wLrJDL0CCJqHye/Y+k/wDxl6qlR6CDaHw3Qxe50d9q8sQRuRN+qF5B
 l0lGgHSQARFBOy/I7wX6eeYkZn7kEDWZUnn0R/fW16Mz2lZOMzvcMwir8ORA+9uMWSMk
 3/64qxMVPqXagFPI+KL3oHDP3PC626RS6wyzX00BWl5MB0l+k0IvxvtHh50HTzle2l9r
 Mq7A==
X-Gm-Message-State: AOJu0YwRDC6KT8NT8AtZaaBhj/Y2mEM8aeF+rP+MK8zlnPnDm66+2/xI
 6p0lGeKS4vH+Ho89XX6fOGEk/7P/5CDnYRcfAbNwcxvX9ftECrbajAtASECDDWMaFvBl5ldPAo+
 D
X-Google-Smtp-Source: AGHT+IHGqVCGfpS+zAllKaAga8iSLKzsNbN7wI7nF98sNkvvB2BU5xpHEvgqbSPSOvesgHd12um9WA==
X-Received: by 2002:a17:902:dac7:b0:1eb:527e:a8ad with SMTP id
 q7-20020a170902dac700b001eb527ea8admr3075691plx.51.1714574268186; 
 Wed, 01 May 2024 07:37:48 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/20] plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
Date: Wed,  1 May 2024 07:37:26 -0700
Message-Id: <20240501143739.10541-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

By having the qemu_plugin_cb_flags be recorded in the TCGHelperInfo,
we no longer need to distinguish PLUGIN_CB_REGULAR from
PLUGIN_CB_REGULAR_R, so place all TB callbacks in the same queue.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 96 +++++++++++++++++++++++++-----------------
 plugins/api.c          |  6 +--
 2 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 4b02c0bfbf..c803fe8e96 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -201,6 +201,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
+    case PLUGIN_GEN_FROM_TB:
         tcg_gen_plugin_cb(from);
         break;
     case PLUGIN_GEN_FROM_INSN:
@@ -210,8 +211,6 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
          */
         gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
                     gen_empty_mem_helper);
-        /* fall through */
-    case PLUGIN_GEN_FROM_TB:
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
@@ -626,24 +625,6 @@ void plugin_gen_disable_mem_helpers(void)
                    offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
 }
 
-static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
-                                TCGOp *begin_op)
-{
-    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR], begin_op);
-}
-
-static void plugin_gen_tb_udata_r(const struct qemu_plugin_tb *ptb,
-                                  TCGOp *begin_op)
-{
-    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR_R], begin_op);
-}
-
-static void plugin_gen_tb_inline(const struct qemu_plugin_tb *ptb,
-                                 TCGOp *begin_op)
-{
-    inject_inline_cb(ptb->cbs[PLUGIN_CB_INLINE], begin_op, op_ok);
-}
-
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
                                   TCGOp *begin_op, int insn_idx)
 {
@@ -702,6 +683,41 @@ static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
     }
 }
 
+static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_call2(cb->regular.f.vcpu_udata, cb->regular.info, NULL,
+                  tcgv_i32_temp(cpu_index),
+                  tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_temp_free_i32(cpu_index);
+}
+
+static void gen_inline_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    GArray *arr = cb->inline_insn.entry.score->data;
+    size_t offset = cb->inline_insn.entry.offset;
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_muli_i32(cpu_index, cpu_index, g_array_get_element_size(arr));
+    tcg_gen_ext_i32_ptr(ptr, cpu_index);
+    tcg_temp_free_i32(cpu_index);
+
+    tcg_gen_addi_ptr(ptr, ptr, (intptr_t)arr->data);
+    tcg_gen_ld_i64(val, ptr, offset);
+    tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
+    tcg_gen_st_i64(val, ptr, offset);
+
+    tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(ptr);
+}
+
 /* #define DEBUG_PLUGIN_GEN_OPS */
 static void pr_ops(void)
 {
@@ -780,6 +796,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
         {
             enum plugin_gen_from from = op->args[0];
             struct qemu_plugin_insn *insn = NULL;
+            const GArray *cbs;
+            int i, n;
 
             if (insn_idx >= 0) {
                 insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
@@ -792,6 +810,25 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 assert(insn != NULL);
                 gen_disable_mem_helper(plugin_tb, insn);
                 break;
+
+            case PLUGIN_GEN_FROM_TB:
+                assert(insn == NULL);
+
+                cbs = plugin_tb->cbs[PLUGIN_CB_REGULAR];
+                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                    struct qemu_plugin_dyn_cb *cb =
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                    gen_udata_cb(cb);
+                }
+
+                cbs = plugin_tb->cbs[PLUGIN_CB_INLINE];
+                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                    struct qemu_plugin_dyn_cb *cb =
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                    gen_inline_cb(cb);
+                }
+                break;
+
             default:
                 g_assert_not_reached();
             }
@@ -807,25 +844,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             enum plugin_gen_cb type = op->args[1];
 
             switch (from) {
-            case PLUGIN_GEN_FROM_TB:
-            {
-                g_assert(insn_idx == -1);
-
-                switch (type) {
-                case PLUGIN_GEN_CB_UDATA:
-                    plugin_gen_tb_udata(plugin_tb, op);
-                    break;
-                case PLUGIN_GEN_CB_UDATA_R:
-                    plugin_gen_tb_udata_r(plugin_tb, op);
-                    break;
-                case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_tb_inline(plugin_tb, op);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            }
             case PLUGIN_GEN_FROM_INSN:
             {
                 g_assert(insn_idx >= 0);
diff --git a/plugins/api.c b/plugins/api.c
index 8fa5a600ac..5d119e8049 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -92,11 +92,7 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           void *udata)
 {
     if (!tb->mem_only) {
-        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
-                    flags == QEMU_PLUGIN_CB_RW_REGS ?
-                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
-
-        plugin_register_dyn_cb__udata(&tb->cbs[index],
+        plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
                                       cb, flags, udata);
     }
 }
-- 
2.34.1


