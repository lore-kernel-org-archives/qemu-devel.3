Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE64CD1283
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp61H-0005NC-LX; Tue, 26 Mar 2024 08:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp61F-0005Mg-UK
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp61C-0000gS-Qp
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4148c6af2d3so8338095e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456504; x=1712061304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1PJSyLekmQiJMmv7/zxpIRkCdRPSC16cTFoxh7+v0c=;
 b=OyUSa1LAcJeG3ntTk43VVI6PDnWwG1Mf/BMjtwzB2z+CrOIhfRKp5id/63xnVQ6s7P
 sRl+XeZGuqpanDeF3KTx6Yzz/KcxyesmB+lNghm+YEZ3BZ/brjDey6vlvIxCmYxwKkEj
 BkhoI+H8mmCVezVibAgXJt1xkm/Dwr+AqwMiDBXqk+1qsTZSIIhyo3miK8rLUBc9YJn6
 +QzGHdRFhX+X+4l7OCLsEKBH57MgvxcGVIHqdMAiDT3/UeRyv8KxjYc3zmhkJsKKh6Ue
 j8mTgZj8cno07RWt4+ueTd4RK31TfwAJpH8tglD4/tfXjWmLhzBJJN93BqaJSzbnQfgl
 rivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456504; x=1712061304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1PJSyLekmQiJMmv7/zxpIRkCdRPSC16cTFoxh7+v0c=;
 b=kZAxUw1POnO9DM7VIXroRUIThDejOEXBil3ToIG8jBntd8uE29VadRS+QYkRhXwifK
 Ql70xVDo2W9POa6o7E4MqQ+oHbBIF0b7OgVitkq4tJNswwdmY1I8Lr3xqybZrgOdjhwK
 6FnbIZs0+djVihJJogPZEWxEjd+lRIX+s1QSWf4HieBDrCXALIcQkPPKWzMV3DuRzmJU
 0Eropz/yCtcBXS2FvnnrT3kOMj57FVLl7ruxpLIL3ZzVezMLdsSeUATU+dnGH4DXHEjX
 el1I4wCo7ho++y8hTqqeEz1xnlvEGTOd+YTLR4y8bIUzNSpA/GFZUc3dWlZl4ebHI40E
 C+eQ==
X-Gm-Message-State: AOJu0Yza0bpX2ePXCYGPEV37K0cD5qtSPVls+7tbZtszTdgEkLYP/YyI
 3nXDnFVJGocU72yidZz4vfF9ayKiECwgtOuILuwupL3MenIoVEXpm28Ifp01rGLP4Iq4cl6h/ye
 xXrU=
X-Google-Smtp-Source: AGHT+IFVl5SsnJTLvqEIU0yusx4gfTw+mzpB1tRpxymY3AJdU0Bq6kWCwulbEiQ6nbTEUNeF6AkYwg==
X-Received: by 2002:a05:600c:3ba3:b0:413:2966:4bfb with SMTP id
 n35-20020a05600c3ba300b0041329664bfbmr6620401wms.1.1711456504244; 
 Tue, 26 Mar 2024 05:35:04 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b004148090cf85sm716317wma.0.2024.03.26.05.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:35:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 7/9] plugins: distinct types for callbacks
Date: Tue, 26 Mar 2024 16:34:24 +0400
Message-Id: <20240326123426.761473-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

To prevent errors when writing new types of callbacks or inline
operations, we split callbacks data to distinct types.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h  | 46 ++++++++++++++-----------
 plugins/plugin.h       |  2 +-
 accel/tcg/plugin-gen.c | 58 +++++++++++++++++---------------
 plugins/core.c         | 76 ++++++++++++++++++++++--------------------
 4 files changed, 98 insertions(+), 84 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bb224b8e4c7..a078229942f 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -73,34 +73,40 @@ enum plugin_dyn_cb_type {
     PLUGIN_CB_INLINE_STORE_U64,
 };
 
+struct qemu_plugin_regular_cb {
+    union qemu_plugin_cb_sig f;
+    TCGHelperInfo *info;
+    void *userp;
+    enum qemu_plugin_mem_rw rw;
+};
+
+struct qemu_plugin_inline_cb {
+    qemu_plugin_u64 entry;
+    enum qemu_plugin_op op;
+    uint64_t imm;
+    enum qemu_plugin_mem_rw rw;
+};
+
+struct qemu_plugin_conditional_cb {
+    union qemu_plugin_cb_sig f;
+    TCGHelperInfo *info;
+    void *userp;
+    qemu_plugin_u64 entry;
+    enum qemu_plugin_cond cond;
+    uint64_t imm;
+};
+
 /*
  * A dynamic callback has an insertion point that is determined at run-time.
  * Usually the insertion point is somewhere in the code cache; think for
  * instance of a callback to be called upon the execution of a particular TB.
  */
 struct qemu_plugin_dyn_cb {
-    void *userp;
     enum plugin_dyn_cb_type type;
-    /* @rw applies to mem callbacks only (both regular and inline) */
-    enum qemu_plugin_mem_rw rw;
-    /* fields specific to each dyn_cb type go here */
     union {
-        struct {
-            union qemu_plugin_cb_sig f;
-            TCGHelperInfo *info;
-        } regular;
-        struct {
-            union qemu_plugin_cb_sig f;
-            TCGHelperInfo *info;
-            qemu_plugin_u64 entry;
-            enum qemu_plugin_cond cond;
-            uint64_t imm;
-        } cond;
-        struct {
-            qemu_plugin_u64 entry;
-            enum qemu_plugin_op op;
-            uint64_t imm;
-        } inline_insn;
+        struct qemu_plugin_regular_cb regular;
+        struct qemu_plugin_conditional_cb cond;
+        struct qemu_plugin_inline_cb inline_insn;
     };
 };
 
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 7d4b4e21f7c..80d5daa9171 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -108,7 +108,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
+void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index);
 
 int plugin_num_vcpus(void);
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 1b1dd264e2b..d00a2b3fd67 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -108,13 +108,13 @@ static void gen_disable_mem_helper(void)
                    offsetof(ArchCPU, env));
 }
 
-static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
 
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_call2(cb->regular.f.vcpu_udata, cb->regular.info, NULL,
+    tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
     tcg_temp_free_i32(cpu_index);
@@ -160,21 +160,21 @@ static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
     }
 }
 
-static void gen_udata_cond_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 {
-    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->cond.entry);
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGLabel *after_cb = gen_new_label();
 
     /* Condition should be negated, as calling the cb is the "else" path */
-    TCGCond cond = tcg_invert_cond(plugin_cond_to_tcgcond(cb->cond.cond));
+    TCGCond cond = tcg_invert_cond(plugin_cond_to_tcgcond(cb->cond));
 
     tcg_gen_ld_i64(val, ptr, 0);
-    tcg_gen_brcondi_i64(cond, val, cb->cond.imm, after_cb);
+    tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_call2(cb->cond.f.vcpu_udata, cb->cond.info, NULL,
+    tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
     gen_set_label(after_cb);
@@ -184,37 +184,37 @@ static void gen_udata_cond_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_ptr(ptr);
 }
 
-static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_inline_add_u64_cb(struct qemu_plugin_inline_cb *cb)
 {
-    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
     TCGv_i64 val = tcg_temp_ebb_new_i64();
 
     tcg_gen_ld_i64(val, ptr, 0);
-    tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
+    tcg_gen_addi_i64(val, val, cb->imm);
     tcg_gen_st_i64(val, ptr, 0);
 
     tcg_temp_free_i64(val);
     tcg_temp_free_ptr(ptr);
 }
 
-static void gen_inline_store_u64_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_inline_store_u64_cb(struct qemu_plugin_inline_cb *cb)
 {
-    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
-    TCGv_i64 val = tcg_constant_i64(cb->inline_insn.imm);
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
+    TCGv_i64 val = tcg_constant_i64(cb->imm);
 
     tcg_gen_st_i64(val, ptr, 0);
 
     tcg_temp_free_ptr(ptr);
 }
 
-static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
+static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
 
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_call4(cb->regular.f.vcpu_mem, cb->regular.info, NULL,
+    tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_i32_temp(tcg_constant_i32(meminfo)),
                   tcgv_i64_temp(addr),
@@ -227,16 +227,16 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
 {
     switch (cb->type) {
     case PLUGIN_CB_REGULAR:
-        gen_udata_cb(cb);
+        gen_udata_cb(&cb->regular);
         break;
     case PLUGIN_CB_COND:
-        gen_udata_cond_cb(cb);
+        gen_udata_cond_cb(&cb->cond);
         break;
     case PLUGIN_CB_INLINE_ADD_U64:
-        gen_inline_add_u64_cb(cb);
+        gen_inline_add_u64_cb(&cb->inline_insn);
         break;
     case PLUGIN_CB_INLINE_STORE_U64:
-        gen_inline_store_u64_cb(cb);
+        gen_inline_store_u64_cb(&cb->inline_insn);
         break;
     default:
         g_assert_not_reached();
@@ -247,15 +247,21 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
                           enum qemu_plugin_mem_rw rw,
                           qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
-    if (cb->rw & rw) {
-        switch (cb->type) {
-        case PLUGIN_CB_MEM_REGULAR:
-            gen_mem_cb(cb, meminfo, addr);
-            break;
-        default:
+    switch (cb->type) {
+    case PLUGIN_CB_MEM_REGULAR:
+        if (rw && cb->regular.rw) {
+            gen_mem_cb(&cb->regular, meminfo, addr);
+        }
+        break;
+    case PLUGIN_CB_INLINE_ADD_U64:
+    case PLUGIN_CB_INLINE_STORE_U64:
+        if (rw && cb->inline_insn.rw) {
             inject_cb(cb);
-            break;
         }
+        break;
+    default:
+        g_assert_not_reached();
+        break;
     }
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index b3d0208e022..7ea2ee208db 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -336,13 +336,13 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
 
+    struct qemu_plugin_inline_cb inline_cb = { .rw = rw,
+                                               .entry = entry,
+                                               .op = op,
+                                               .imm = imm };
     dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = NULL;
     dyn_cb->type = op_to_cb_type(op);
-    dyn_cb->rw = rw;
-    dyn_cb->inline_insn.entry = entry;
-    dyn_cb->inline_insn.op = op;
-    dyn_cb->inline_insn.imm = imm;
+    dyn_cb->inline_insn = inline_cb;
 }
 
 void plugin_register_dyn_cb__udata(GArray **arr,
@@ -361,14 +361,14 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
+    assert((unsigned)flags < ARRAY_SIZE(info));
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = udata;
+    struct qemu_plugin_regular_cb regular_cb = { .f.vcpu_udata = cb,
+                                                 .userp = udata,
+                                                 .info = &info[flags] };
     dyn_cb->type = PLUGIN_CB_REGULAR;
-    dyn_cb->regular.f.vcpu_udata = cb;
-
-    assert((unsigned)flags < ARRAY_SIZE(info));
-    dyn_cb->regular.info = &info[flags];
+    dyn_cb->regular = regular_cb;
 }
 
 void plugin_register_dyn_cond_cb__udata(GArray **arr,
@@ -390,17 +390,17 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
+    assert((unsigned)flags < ARRAY_SIZE(info));
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = udata;
+    struct qemu_plugin_conditional_cb cond_cb = { .userp = udata,
+                                                  .f.vcpu_udata = cb,
+                                                  .cond = cond,
+                                                  .entry = entry,
+                                                  .imm = imm,
+                                                  .info = &info[flags] };
     dyn_cb->type = PLUGIN_CB_COND;
-    dyn_cb->cond.f.vcpu_udata = cb;
-    dyn_cb->cond.cond = cond;
-    dyn_cb->cond.entry = entry;
-    dyn_cb->cond.imm = imm;
-
-    assert((unsigned)flags < ARRAY_SIZE(info));
-    dyn_cb->cond.info = &info[flags];
+    dyn_cb->cond = cond_cb;
 }
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
@@ -432,15 +432,15 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
              dh_typemask(i64, 3) |
              dh_typemask(ptr, 4))
     };
+    assert((unsigned)flags < ARRAY_SIZE(info));
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = udata;
+    struct qemu_plugin_regular_cb regular_cb = { .userp = udata,
+                                                 .rw = rw,
+                                                 .f.vcpu_mem = cb,
+                                                 .info = &info[flags] };
     dyn_cb->type = PLUGIN_CB_MEM_REGULAR;
-    dyn_cb->rw = rw;
-    dyn_cb->regular.f.vcpu_mem = cb;
-
-    assert((unsigned)flags < ARRAY_SIZE(info));
-    dyn_cb->regular.info = &info[flags];
+    dyn_cb->regular = regular_cb;
 }
 
 /*
@@ -557,20 +557,20 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
+void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index)
 {
-    char *ptr = cb->inline_insn.entry.score->data->data;
+    char *ptr = cb->entry.score->data->data;
     size_t elem_size = g_array_get_element_size(
-        cb->inline_insn.entry.score->data);
-    size_t offset = cb->inline_insn.entry.offset;
+        cb->entry.score->data);
+    size_t offset = cb->entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
-    switch (cb->inline_insn.op) {
+    switch (cb->op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
-        *val += cb->inline_insn.imm;
+        *val += cb->imm;
         break;
     case QEMU_PLUGIN_INLINE_STORE_U64:
-        *val = cb->inline_insn.imm;
+        *val = cb->imm;
         break;
     default:
         g_assert_not_reached();
@@ -590,17 +590,19 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
         struct qemu_plugin_dyn_cb *cb =
             &g_array_index(arr, struct qemu_plugin_dyn_cb, i);
 
-        if (!(rw & cb->rw)) {
-                break;
-        }
         switch (cb->type) {
         case PLUGIN_CB_MEM_REGULAR:
-            cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
-                                   vaddr, cb->userp);
+            if (rw && cb->regular.rw) {
+                cb->regular.f.vcpu_mem(cpu->cpu_index,
+                                       make_plugin_meminfo(oi, rw),
+                                       vaddr, cb->regular.userp);
+            }
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
         case PLUGIN_CB_INLINE_STORE_U64:
-            exec_inline_op(cb, cpu->cpu_index);
+            if (rw && cb->inline_insn.rw) {
+                exec_inline_op(&cb->inline_insn, cpu->cpu_index);
+            }
             break;
         default:
             g_assert_not_reached();
-- 
2.39.2


