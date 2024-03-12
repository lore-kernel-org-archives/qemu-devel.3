Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CD5C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwyT-0001xp-BS; Tue, 12 Mar 2024 03:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjwyS-0001xh-8e
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:55:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjwyQ-0003cn-5B
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:55:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e70d71756so2707091f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710230096; x=1710834896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+G3JO44I+TxZBMJCq8y8IXXNFiDh61c1hkycZ0ZrhWs=;
 b=CeByDYahlN3h50C3JiqXOZtrCQRJsQ3uV5xgxp+c5RoD53oyTev/7fB/pxTeKqMtb1
 wsn/4ybrPcsQCuy1FlwmuJsQ29GT2JktpJM6UmDTo03bTXYoJoCv8o38xYqNCr4l+SII
 TPuKhywLEBN4rtoMpCgNP/7K0EuqzNHpl3zWixff4qQ2MNnSHlA+T7XOoN9Y7qyCiIVK
 L7L3MwO66GOyaQh6bixsPrmtRNpMOJn2p54urDc3fetsYdGZgxSskOHapn8+QyIZUpv7
 S/ZiwFLHVaTW8RBzUfpBSky0JQE3xrNJh6jCm9Ocwsuf/c16SlAXvbIbX9H9xRnenMU0
 aHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710230096; x=1710834896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+G3JO44I+TxZBMJCq8y8IXXNFiDh61c1hkycZ0ZrhWs=;
 b=FsYYOVb7qYohCY+rRvIgpQihhSDNKq0UzSC8puWbsDniSIBJmBq5rBl7w27UghRVit
 rtgZ9wY5XeODMMl9kiZPS2AmlVVE2Jtoy48mSsEPjCsq2eg2Kgxe7jFLQqZEQl1eAfsq
 EgLTEDnVQL9GGXcFOee+Hyc6MqH6JYjdSQcN1PIMIr4/sNHkZaIvj9ZvFe9OZnQPG3Gk
 QGs59JwklbocsuWT7NQEn4a3OIOqICoQW4jBwLKO/F+uDyuNnLsfKytX163rGZgfp7Ge
 xpcuWjbICXUEtszOlKGFwTLqg+aX0GdvPIYCbUWjbj9JN/JF1AK5bDfOJHudz3/WaIg4
 QZ6A==
X-Gm-Message-State: AOJu0YyUmjS0BvoZ5/cBzt1gKZdNTNEALFuAVurrGxucsOW15r3uX5eR
 a1vDBHJlNDuiFZXrRsofNgR7fF1HDixLcEr5VyzWmc9BSTIEdGeCW0Q+Jt+PEm1L9e07qOrMZde
 PKEk=
X-Google-Smtp-Source: AGHT+IGhW4n5yUA9LF7GK5GdH/P7B2ozIOtsE5av7M4oZBieAq8OATzBdxyD7I/2l3/SaABIevVZww==
X-Received: by 2002:adf:ca07:0:b0:33e:929e:5366 with SMTP id
 o7-20020adfca07000000b0033e929e5366mr5564145wrh.28.1710230096205; 
 Tue, 12 Mar 2024 00:54:56 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u12-20020a5d6acc000000b0033e7a499deasm6108795wrw.109.2024.03.12.00.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:54:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/5] plugins: add new inline op STORE_U64
Date: Tue, 12 Mar 2024 11:54:25 +0400
Message-Id: <20240312075428.244210-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
References: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h      |   1 +
 include/qemu/qemu-plugin.h |   4 +-
 accel/tcg/plugin-gen.c     | 114 ++++++++++++++++++++++++++++++++++++-
 plugins/api.c              |   2 +
 plugins/core.c             |   4 ++
 5 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 33a7cbe910c..d92d64744e6 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -75,6 +75,7 @@ enum plugin_dyn_cb_subtype {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_REGULAR_R,
     PLUGIN_CB_INLINE_ADD_U64,
+    PLUGIN_CB_INLINE_STORE_U64,
     PLUGIN_N_CB_SUBTYPES,
 };
 
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4fc6c3739b2..c5cac897a0b 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -305,12 +305,12 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
  * enum qemu_plugin_op - describes an inline op
  *
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
- *
- * Note: currently only a single inline op is supported.
+ * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
  */
 
 enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
+    QEMU_PLUGIN_INLINE_STORE_U64,
 };
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 494467e0833..02c894106e2 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -46,8 +46,9 @@
 #include "qemu/plugin.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
-#include "tcg/tcg-temp-internal.h"
+#include "tcg/tcg-internal.h"
 #include "tcg/tcg-op.h"
+#include "tcg/tcg-temp-internal.h"
 #include "exec/exec-all.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
@@ -82,6 +83,7 @@ enum plugin_gen_cb {
     PLUGIN_GEN_CB_UDATA,
     PLUGIN_GEN_CB_UDATA_R,
     PLUGIN_GEN_CB_INLINE_ADD_U64,
+    PLUGIN_GEN_CB_INLINE_STORE_U64,
     PLUGIN_GEN_CB_MEM,
     PLUGIN_GEN_ENABLE_MEM_HELPER,
     PLUGIN_GEN_DISABLE_MEM_HELPER,
@@ -153,6 +155,30 @@ static void gen_empty_inline_cb_add_u64(void)
     tcg_temp_free_i32(cpu_index);
 }
 
+static void gen_empty_inline_cb_store_u64(void)
+{
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    /* second operand will be replaced by immediate value */
+    tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
+    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
+    tcg_gen_movi_ptr(ptr, 0);
+    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
+
+    tcg_gen_movi_i64(val, 0);
+    tcg_gen_st_i64(val, ptr, 0);
+
+    tcg_temp_free_ptr(ptr);
+    tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(cpu_index_as_ptr);
+    tcg_temp_free_i32(cpu_index);
+}
+
 static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
@@ -218,6 +244,8 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
         /* emit inline op before any callback */
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE_ADD_U64,
                     gen_empty_inline_cb_add_u64);
+        gen_wrapped(from, PLUGIN_GEN_CB_INLINE_STORE_U64,
+                    gen_empty_inline_cb_store_u64);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
         break;
@@ -235,6 +263,11 @@ void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
     gen_empty_inline_cb_add_u64();
     tcg_gen_plugin_cb_end();
 
+    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM,
+                        PLUGIN_GEN_CB_INLINE_STORE_U64, rw);
+    gen_empty_inline_cb_store_u64();
+    tcg_gen_plugin_cb_end();
+
     gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_MEM, rw);
     gen_empty_mem_cb(addr, info);
     tcg_gen_plugin_cb_end();
@@ -352,6 +385,20 @@ static TCGOp *copy_st_i64(TCGOp **begin_op, TCGOp *op)
     return op;
 }
 
+static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(TCGV_LOW(tcg_constant_i64(v)));
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(TCGV_HIGH(tcg_constant_i64(v)));
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_mov_i64);
+        op->args[1] = tcgv_i64_arg(tcg_constant_i64(v));
+    }
+    return op;
+}
+
 static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
 {
     if (TCG_TARGET_REG_BITS == 32) {
@@ -455,6 +502,24 @@ static TCGOp *append_inline_cb_add_u64(const struct qemu_plugin_dyn_cb *cb,
     return op;
 }
 
+static TCGOp *append_inline_cb_store_u64(const struct qemu_plugin_dyn_cb *cb,
+                                       TCGOp *begin_op, TCGOp *op,
+                                       int *unused)
+{
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
+    op = copy_ld_i32(&begin_op, op);
+    op = copy_mul_i32(&begin_op, op, elem_size);
+    op = copy_ext_i32_ptr(&begin_op, op);
+    op = copy_const_ptr(&begin_op, op, ptr + offset);
+    op = copy_add_ptr(&begin_op, op);
+    op = copy_mov_i64(&begin_op, op, cb->inline_insn.imm);
+    op = copy_st_i64(&begin_op, op);
+    return op;
+}
+
 static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
                             TCGOp *begin_op, TCGOp *op, int *cb_idx)
 {
@@ -542,6 +607,12 @@ inject_inline_cb_add_u64(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
     inject_cb_type(cbs, begin_op, append_inline_cb_add_u64, ok);
 }
 
+static void
+inject_inline_cb_store_u64(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
+{
+    inject_cb_type(cbs, begin_op, append_inline_cb_store_u64, ok);
+}
+
 static void
 inject_mem_cb(const GArray *cbs, TCGOp *begin_op)
 {
@@ -583,13 +654,14 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
                                      struct qemu_plugin_insn *plugin_insn,
                                      TCGOp *begin_op)
 {
-    GArray *cbs[2];
+    GArray *cbs[3];
     GArray *arr;
     size_t n_cbs, i;
 
     /* emit inline op before any callback */
     cbs[0] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_ADD_U64];
-    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
+    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_STORE_U64];
+    cbs[2] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
 
     n_cbs = 0;
     for (i = 0; i < ARRAY_SIZE(cbs); i++) {
@@ -662,6 +734,13 @@ static void plugin_gen_tb_inline_add_u64(const struct qemu_plugin_tb *ptb,
                              begin_op, op_ok);
 }
 
+static void plugin_gen_tb_inline_store_u64(const struct qemu_plugin_tb *ptb,
+                                         TCGOp *begin_op)
+{
+    inject_inline_cb_store_u64(ptb->cbs[PLUGIN_CB_INLINE_STORE_U64],
+                             begin_op, op_ok);
+}
+
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
                                   TCGOp *begin_op, int insn_idx)
 {
@@ -686,6 +765,14 @@ static void plugin_gen_insn_inline_add_u64(const struct qemu_plugin_tb *ptb,
         insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE_ADD_U64], begin_op, op_ok);
 }
 
+static void plugin_gen_insn_inline_store_u64(const struct qemu_plugin_tb *ptb,
+                                             TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_inline_cb_store_u64(
+        insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE_STORE_U64], begin_op, op_ok);
+}
+
 static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
                                    TCGOp *begin_op, int insn_idx)
 {
@@ -701,6 +788,15 @@ static void plugin_gen_mem_inline_add_u64(const struct qemu_plugin_tb *ptb,
                              begin_op, op_rw);
 }
 
+static void plugin_gen_mem_inline_store_u64(const struct qemu_plugin_tb *ptb,
+                                            TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_inline_cb_store_u64(
+        insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_STORE_U64],
+        begin_op, op_rw);
+}
+
 static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
                                          TCGOp *begin_op, int insn_idx)
 {
@@ -750,6 +846,9 @@ static void pr_ops(void)
             case PLUGIN_GEN_CB_INLINE_ADD_U64:
                 type = "inline add u64";
                 break;
+            case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                type = "inline store u64";
+                break;
             case PLUGIN_GEN_CB_MEM:
                 type = "mem";
                 break;
@@ -801,6 +900,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_INLINE_ADD_U64:
                     plugin_gen_tb_inline_add_u64(plugin_tb, op);
                     break;
+                case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                    plugin_gen_tb_inline_store_u64(plugin_tb, op);
+                    break;
                 default:
                     g_assert_not_reached();
                 }
@@ -820,6 +922,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_INLINE_ADD_U64:
                     plugin_gen_insn_inline_add_u64(plugin_tb, op, insn_idx);
                     break;
+                case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                    plugin_gen_insn_inline_store_u64(plugin_tb, op, insn_idx);
+                    break;
                 case PLUGIN_GEN_ENABLE_MEM_HELPER:
                     plugin_gen_enable_mem_helper(plugin_tb, op, insn_idx);
                     break;
@@ -839,6 +944,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_INLINE_ADD_U64:
                     plugin_gen_mem_inline_add_u64(plugin_tb, op, insn_idx);
                     break;
+                case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                    plugin_gen_mem_inline_store_u64(plugin_tb, op, insn_idx);
+                    break;
                 default:
                     g_assert_not_reached();
                 }
diff --git a/plugins/api.c b/plugins/api.c
index 09ff7c70127..b7feed224a8 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -60,6 +60,8 @@ static enum plugin_dyn_cb_subtype op_to_cb_subtype(enum qemu_plugin_op op)
     switch (op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
         return PLUGIN_CB_INLINE_ADD_U64;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        return PLUGIN_CB_INLINE_STORE_U64;
     default:
         g_assert_not_reached();
     }
diff --git a/plugins/core.c b/plugins/core.c
index a641a366ef9..11f72594229 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -489,6 +489,9 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     case QEMU_PLUGIN_INLINE_ADD_U64:
         *val += cb->inline_insn.imm;
         break;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        *val = cb->inline_insn.imm;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -516,6 +519,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                            vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
+        case PLUGIN_CB_INLINE_STORE_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.39.2


