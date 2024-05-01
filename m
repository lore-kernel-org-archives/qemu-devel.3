Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37741C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B5w-0002jC-Pu; Wed, 01 May 2024 10:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5p-0002hH-Pi
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5n-0002A5-LR
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ec4dd8525cso14159005ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574274; x=1715179074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIMvAm2jbpK2PQHQ4qVUc/TGJ1BeB5t3WwlK4/K5NYE=;
 b=IHeisvYKwzqrGywBsJcw47HfjUVT1DzNIycb6w2Im8R+7ld6ttJeRf9iYNl44uKI6O
 YIEL7ryccK4wl17njz5BhvbLZ01Pzmm4SN9fNPx51AoOSH/T+YX9UlEm64wdZ/xYNkCH
 ga3DZnG0L+c5tVRSTcmsjP92tzdPRqguvqVfL3FtOW6E352YOk5I+27jD3jfKUTAPPr5
 AlvUYVlgF8g2rZdrg8UPl3S4NDMySqUQZPZ/laVv35ReizWxp0NUrAWD9jtpYAsMXJpM
 YmrYqWb4SH888Mr1Q54AqikdfV2yx9Uk4GMc21FyODDkDO5VbDWn4ZBWRKRBIkaYABJJ
 OfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574274; x=1715179074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIMvAm2jbpK2PQHQ4qVUc/TGJ1BeB5t3WwlK4/K5NYE=;
 b=g9nywH4GdE2TtEG35M+cb3HsO4qPVn7JfF/ewFku9LUjMFD1Cj7BT05+NKy0hWvcj9
 cuCPv19CsxzAvNt91rSnVW7vL4t7jkjlTVUgAqs3p9QKXEVrzLSEtVZ59wPkzIrVaeoA
 u5f36FspiDa3Fko7eKscUZPSoHm6nvIs7FIx45gQf3F1wCrzUOiq7aXva4dtE1iMpOOA
 YcBiHwNqQpHGhuI3zpe9tQb0ne8gmVU5fU7A5IELojvJ5fvIgL8ZT3iufvdbUOHpZPmH
 6ooQJG+uBIv/5i4SZnFzlU7tVRMqSsDLfbfSVYRM1qs5yrO+dPSnXqRi/Vx152vwnP0U
 1viQ==
X-Gm-Message-State: AOJu0YwSrIUmyq2FDMjeNYaNi/bDFoOccmmriYRGDrRiWPLkrKAx5wBp
 Dn6SCcHf+ctaJNiB4ZrcWQw7lHLa/oYfp198ZVhoetQj60rhJGEjYHw2Fc+x891klNy/g01Sk9l
 w
X-Google-Smtp-Source: AGHT+IHn4Ov6oFRrRj1ipYf8G9eG7JIVxvPf9kxzGiRNnLez7YMANxqQBAcTy4vwAqUSZ5080/aECA==
X-Received: by 2002:a17:902:db0d:b0:1eb:5291:d3cd with SMTP id
 m13-20020a170902db0d00b001eb5291d3cdmr3092382plx.49.1714574274409; 
 Wed, 01 May 2024 07:37:54 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/20] plugins: Simplify callback queues
Date: Wed,  1 May 2024 07:37:33 -0700
Message-Id: <20240501143739.10541-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We have qemu_plugin_dyn_cb.type to differentiate the various
callback types, so we do not need to keep them in separate queues.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 35 ++++++----------
 accel/tcg/plugin-gen.c | 90 ++++++++++++++++++++++--------------------
 plugins/api.c          | 18 +++------
 3 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 0d0062448b..b679a22bae 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -67,15 +67,8 @@ union qemu_plugin_cb_sig {
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
@@ -85,7 +78,7 @@ enum plugin_dyn_cb_subtype {
  */
 struct qemu_plugin_dyn_cb {
     void *userp;
-    enum plugin_dyn_cb_subtype type;
+    enum plugin_dyn_cb_type type;
     /* @rw applies to mem callbacks only (both regular and inline) */
     enum qemu_plugin_mem_rw rw;
     /* fields specific to each dyn_cb type go here */
@@ -107,7 +100,8 @@ struct qemu_plugin_insn {
     GByteArray *data;
     uint64_t vaddr;
     void *haddr;
-    GArray *cbs[PLUGIN_N_CB_TYPES][PLUGIN_N_CB_SUBTYPES];
+    GArray *insn_cbs;
+    GArray *mem_cbs;
     bool calls_helpers;
 
     /* if set, the instruction calls helpers that might access guest memory */
@@ -136,16 +130,9 @@ static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
 
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
 
@@ -162,7 +149,7 @@ struct qemu_plugin_tb {
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
 
-    GArray *cbs[PLUGIN_N_CB_SUBTYPES];
+    GArray *cbs;
 };
 
 /**
@@ -175,22 +162,22 @@ struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
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
index d9ee9bb2ec..e77ff2a565 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -83,9 +83,8 @@ void plugin_gen_disable_mem_helpers(void)
 static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
                                   struct qemu_plugin_insn *insn)
 {
-    GArray *cbs[2];
     GArray *arr;
-    size_t n_cbs;
+    size_t len;
 
     /*
      * Tracking memory accesses performed from helpers requires extra work.
@@ -104,22 +103,25 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
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
@@ -288,18 +290,21 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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
 
@@ -308,18 +313,21 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
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
 
@@ -346,21 +354,22 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
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
 
@@ -384,13 +393,10 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 
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


