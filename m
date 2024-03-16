Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FC0C54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 02:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJP-00031w-7b; Fri, 15 Mar 2024 21:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJI-0002zB-LJ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ6-0000mC-2i
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1def142ae7bso11280255ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554274; x=1711159074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1r860Fs0umWNdHdT/Kjt1p732OG4U2qCU3kOvvc/EXA=;
 b=C6hqQhucmvJoFsRhlkclp1wl8V7zDuNe5RZBlIi09iLbivPehlQZjvEwdKNAUTWLPy
 bRJQ7fKtO8qArytBULWJCiTWjX8LPG62VRPYYjcPzrkmwAbZQw3PFJbaSAMnfOWnGAe5
 8GYfH0RnQSR5FAqhKBFqcTtz408MHkkLv6Om4f3zvH08OWsfv/K0a5SdylD21rcvyDTh
 97jqcYYmC4wWWxwSgWaEU+1XGUbraWa25o6u7uQ7zyBMLXkzzQIxF5yeQjSiIpTtWH0P
 2j6BQQT+SiUWSORWc9Wcew/Pml+V+mHi8bYCn/am9osJxaJ+SFzU6mER7W58hMG+ZxZZ
 PH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554275; x=1711159075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1r860Fs0umWNdHdT/Kjt1p732OG4U2qCU3kOvvc/EXA=;
 b=ESUD6caqfXdaWdrciUjKPY4DiLvdTXaKf3BK3PZyN8aQqO60Jfhftzf8ep9sG9C3qt
 c+mUJeioCppkcsco5XMM4jU8Swq81l6XvYVIYTusmB6yIJ7p07DHwM7o0fvC4csbzbYh
 0NMfCvn6fRMngMCeBudhyc6n9hJIOF/qOdgQmFSGKFEpboj9k5ScBFn4ay7A5ctNyq89
 ywWmi1GCh2eb3B82OcvLYPvIDkGeX8Ot+S8Mv7W4Djql6w0WSAt6NRW+avvIjkoiZUjM
 pgVXcJoVlV61bNIHK6lbUuEluio7uR1+RalIJOq62jKNuicEz4Y6AyqgQOlQR91u8M5x
 wGYA==
X-Gm-Message-State: AOJu0YxEQY132qVmIgGk7cC2kaBwQPGuC3UjZhuEgHBvAqjMH5Cyoa75
 dPME703zPeC9SZ8e322zZIiiT+kN9nE7YicPIuxvHe2t5X9gNPDIKJMqzd/RQJW6EnKr6f/3SW+
 G
X-Google-Smtp-Source: AGHT+IHt4Nin4peh6BI9ITOXXcJ1+cMRzSCAyoWN9iMSXq+6XbyJySGAmFzQ6RmjuFfUCkRxWeRDYQ==
X-Received: by 2002:a17:902:e551:b0:1dd:c24d:4d1f with SMTP id
 n17-20020a170902e55100b001ddc24d4d1fmr7475289plf.67.1710554274583; 
 Fri, 15 Mar 2024 18:57:54 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 15/22] plugins: Simplify callback queues
Date: Fri, 15 Mar 2024 15:57:13 -1000
Message-Id: <20240316015720.3661236-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We have qemu_plugin_dyn_cb.type to differentiate the various
callback types, so we do not need to keep them in separate queues.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 35 ++++++----------
 accel/tcg/plugin-gen.c | 90 ++++++++++++++++++++++--------------------
 plugins/api.c          | 18 +++------
 3 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index ee1c1b174a..cf9758be55 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -66,15 +66,8 @@ union qemu_plugin_cb_sig {
 };
 
 enum plugin_dyn_cb_type {
-    PLUGIN_CB_INSN,
-    PLUGIN_CB_MEM,
-    PLUGIN_N_CB_TYPES,
-};
-
-enum plugin_dyn_cb_subtype {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_INLINE,
-    PLUGIN_N_CB_SUBTYPES,
 };
 
 /*
@@ -84,7 +77,7 @@ enum plugin_dyn_cb_subtype {
  */
 struct qemu_plugin_dyn_cb {
     void *userp;
-    enum plugin_dyn_cb_subtype type;
+    enum plugin_dyn_cb_type type;
     /* @rw applies to mem callbacks only (both regular and inline) */
     enum qemu_plugin_mem_rw rw;
     /* fields specific to each dyn_cb type go here */
@@ -106,7 +99,8 @@ struct qemu_plugin_insn {
     GByteArray *data;
     uint64_t vaddr;
     void *haddr;
-    GArray *cbs[PLUGIN_N_CB_TYPES][PLUGIN_N_CB_SUBTYPES];
+    GArray *insn_cbs;
+    GArray *mem_cbs;
     bool calls_helpers;
 
     /* if set, the instruction calls helpers that might access guest memory */
@@ -135,16 +129,9 @@ static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
 
 static inline struct qemu_plugin_insn *qemu_plugin_insn_alloc(void)
 {
-    int i, j;
     struct qemu_plugin_insn *insn = g_new0(struct qemu_plugin_insn, 1);
-    insn->data = g_byte_array_sized_new(4);
 
-    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
-        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
-            insn->cbs[i][j] = g_array_new(false, false,
-                                          sizeof(struct qemu_plugin_dyn_cb));
-        }
-    }
+    insn->data = g_byte_array_sized_new(4);
     return insn;
 }
 
@@ -161,7 +148,7 @@ struct qemu_plugin_tb {
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
 
-    GArray *cbs[PLUGIN_N_CB_SUBTYPES];
+    GArray *cbs;
 };
 
 /**
@@ -174,22 +161,22 @@ struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
                                                  uint64_t pc)
 {
     struct qemu_plugin_insn *insn;
-    int i, j;
 
     if (unlikely(tb->n == tb->insns->len)) {
         struct qemu_plugin_insn *new_insn = qemu_plugin_insn_alloc();
         g_ptr_array_add(tb->insns, new_insn);
     }
+
     insn = g_ptr_array_index(tb->insns, tb->n++);
     g_byte_array_set_size(insn->data, 0);
     insn->calls_helpers = false;
     insn->mem_helper = false;
     insn->vaddr = pc;
-
-    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
-        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
-            g_array_set_size(insn->cbs[i][j], 0);
-        }
+    if (insn->insn_cbs) {
+        g_array_set_size(insn->insn_cbs, 0);
+    }
+    if (insn->mem_cbs) {
+        g_array_set_size(insn->mem_cbs, 0);
     }
 
     return insn;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c8f0e0ecaa..669e343cfb 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -89,9 +89,8 @@ void plugin_gen_disable_mem_helpers(void)
 static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
                                   struct qemu_plugin_insn *insn)
 {
-    GArray *cbs[2];
     GArray *arr;
-    size_t n_cbs;
+    size_t len;
 
     /*
      * Tracking memory accesses performed from helpers requires extra work.
@@ -110,22 +109,25 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
         return;
     }
 
-    cbs[0] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
-    cbs[1] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
-    n_cbs = cbs[0]->len + cbs[1]->len;
-
-    if (n_cbs == 0) {
+    if (!insn->mem_cbs || !insn->mem_cbs->len) {
         insn->mem_helper = false;
         return;
     }
     insn->mem_helper = true;
     ptb->mem_helper = true;
 
+    /*
+     * TODO: It seems like we should be able to use ref/unref
+     * to avoid needing to actually copy this array.
+     * Alternately, perhaps we could allocate new memory adjacent
+     * to the TranslationBlock itself, so that we do not have to
+     * actively manage the lifetime after this.
+     */
+    len = insn->mem_cbs->len;
     arr = g_array_sized_new(false, false,
-                            sizeof(struct qemu_plugin_dyn_cb), n_cbs);
-    g_array_append_vals(arr, cbs[0]->data, cbs[0]->len);
-    g_array_append_vals(arr, cbs[1]->data, cbs[1]->len);
-
+                            sizeof(struct qemu_plugin_dyn_cb), len);
+    memcpy(arr->data, insn->mem_cbs->data,
+           len * sizeof(struct qemu_plugin_dyn_cb));
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
@@ -294,18 +296,21 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             case PLUGIN_GEN_FROM_TB:
                 assert(insn == NULL);
 
-                cbs = plugin_tb->cbs[PLUGIN_CB_REGULAR];
+                cbs = plugin_tb->cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                     struct qemu_plugin_dyn_cb *cb =
                         &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-                    gen_udata_cb(cb);
-                }
 
-                cbs = plugin_tb->cbs[PLUGIN_CB_INLINE];
-                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
-                    struct qemu_plugin_dyn_cb *cb =
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-                    gen_inline_cb(cb);
+                    switch (cb->type) {
+                    case PLUGIN_CB_REGULAR:
+                        gen_udata_cb(cb);
+                        break;
+                    case PLUGIN_CB_INLINE:
+                        gen_inline_cb(cb);
+                        break;
+                    default:
+                        g_assert_not_reached();
+                    }
                 }
                 break;
 
@@ -314,18 +319,21 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 gen_enable_mem_helper(plugin_tb, insn);
 
-                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR];
+                cbs = insn->insn_cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                     struct qemu_plugin_dyn_cb *cb =
                         &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-                    gen_udata_cb(cb);
-                }
 
-                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE];
-                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
-                    struct qemu_plugin_dyn_cb *cb =
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-                    gen_inline_cb(cb);
+                    switch (cb->type) {
+                    case PLUGIN_CB_REGULAR:
+                        gen_udata_cb(cb);
+                        break;
+                    case PLUGIN_CB_INLINE:
+                        gen_inline_cb(cb);
+                        break;
+                    default:
+                        g_assert_not_reached();
+                    }
                 }
                 break;
 
@@ -352,21 +360,22 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
             tcg_ctx->emit_before_op = op;
 
-            cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
+            cbs = insn->mem_cbs;
             for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                 struct qemu_plugin_dyn_cb *cb =
                     &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-                if (cb->rw & rw) {
-                    gen_mem_cb(cb, meminfo, addr);
-                }
-            }
 
-            cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
-            for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
-                struct qemu_plugin_dyn_cb *cb =
-                    &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
                 if (cb->rw & rw) {
-                    gen_inline_cb(cb);
+                    switch (cb->type) {
+                    case PLUGIN_CB_REGULAR:
+                        gen_mem_cb(cb, meminfo, addr);
+                        break;
+                    case PLUGIN_CB_INLINE:
+                        gen_inline_cb(cb);
+                        break;
+                    default:
+                        g_assert_not_reached();
+                    }
                 }
             }
 
@@ -390,13 +399,10 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 
     if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_state->event_mask)) {
         struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
-        int i;
 
         /* reset callbacks */
-        for (i = 0; i < PLUGIN_N_CB_SUBTYPES; i++) {
-            if (ptb->cbs[i]) {
-                g_array_set_size(ptb->cbs[i], 0);
-            }
+        if (ptb->cbs) {
+            g_array_set_size(ptb->cbs, 0);
         }
         ptb->n = 0;
 
diff --git a/plugins/api.c b/plugins/api.c
index 29cce2d97c..3912c9cc8f 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -92,8 +92,7 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           void *udata)
 {
     if (!tb->mem_only) {
-        plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
-                                      cb, flags, udata);
+        plugin_register_dyn_cb__udata(&tb->cbs, cb, flags, udata);
     }
 }
 
@@ -104,8 +103,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
     uint64_t imm)
 {
     if (!tb->mem_only) {
-        plugin_register_inline_op_on_entry(
-            &tb->cbs[PLUGIN_CB_INLINE], 0, op, entry, imm);
+        plugin_register_inline_op_on_entry(&tb->cbs, 0, op, entry, imm);
     }
 }
 
@@ -115,8 +113,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             void *udata)
 {
     if (!insn->mem_only) {
-        plugin_register_dyn_cb__udata(
-            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], cb, flags, udata);
+        plugin_register_dyn_cb__udata(&insn->insn_cbs, cb, flags, udata);
     }
 }
 
@@ -127,8 +124,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
     uint64_t imm)
 {
     if (!insn->mem_only) {
-        plugin_register_inline_op_on_entry(
-            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE], 0, op, entry, imm);
+        plugin_register_inline_op_on_entry(&insn->insn_cbs, 0, op, entry, imm);
     }
 }
 
@@ -143,8 +139,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       enum qemu_plugin_mem_rw rw,
                                       void *udata)
 {
-    plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
-                                cb, flags, rw, udata);
+    plugin_register_vcpu_mem_cb(&insn->mem_cbs, cb, flags, rw, udata);
 }
 
 void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
@@ -154,8 +149,7 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
     qemu_plugin_u64 entry,
     uint64_t imm)
 {
-    plugin_register_inline_op_on_entry(
-        &insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE], rw, op, entry, imm);
+    plugin_register_inline_op_on_entry(&insn->mem_cbs, rw, op, entry, imm);
 }
 
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
-- 
2.34.1


