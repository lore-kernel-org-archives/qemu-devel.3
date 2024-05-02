Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 21:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dmQ-0008Pk-W1; Thu, 02 May 2024 17:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmP-0008PB-JN
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmK-0002pB-C0
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f4496af4cdso272070b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714684542; x=1715289342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLkTY4QNWn5qkw4obyWojmSJ+y67SJD7JCyqwiPsOVQ=;
 b=V8xXTvmUYAVZyD2LZqkIO74py2RId/kgL7qMBMZt5tWi4gjqpgq8oJEkcapS6ffLqS
 VdKa+c2kbPUwl+Sz/m3ldjh9j1DEDXqpqCm38Rc9rWUTKGBBpwzMwRVxF6d6l048odZu
 d+5aUfa6DwWFAQUn0eu5V6uLGxuoCZne9fYVq/6c8Jd5WjZdE0hIrbWjIgBn0yJK+Noc
 tecD/QzAOT/Jp9w3TUrtOYc4yFd7l0Eb6ZJH809xJdGSC8rvXrZDHn+ckOHLOx8sP0/f
 Tf8C1hSLOj0YC/zD3+F/6S9h5cjJh9XPJjhalMxkVmSETeXEqobjTzx4+0qVwiimhp2Z
 8hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714684542; x=1715289342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLkTY4QNWn5qkw4obyWojmSJ+y67SJD7JCyqwiPsOVQ=;
 b=Fg5XB5wXgQKdIAHQaikBSNmByl3XpQoKe3+L0VVEubx9ylHHgpt8M3lts/JNMlBMMf
 jLVAB3tlH+fehYxy8l2ADFqMKi6cJCuRFh3vkIUsROWrhZ3RbNANfKYgV269L8QYymNc
 h8DuUQv0NB4VXJapSi6+r8hJvzYJIj4Qz8Xe0FUbiNLiKDCYXgh9g1Hk5BHO8bnE8XoI
 nZ9OiqvRxMA9SLk/+Jm7Mxc1p4Dz4jHKQJqnFNFDJR0Q0tx4Fe+sM6jVQeCC5nNBQ4R9
 hsZqG4TDdOPFFZxWHeWyK9f8b7YQSq5yOHxIu17f6PCZmdF22OtUxOutDkUTXrlz/+UC
 xr4w==
X-Gm-Message-State: AOJu0YwaBXgCQ47mJ3mLRezgC/p3LkyM5m0A/NEzh9EpPgmo4AaTIawd
 VaZnicywcj09A19M72Nbk8puldqpEdZmT97SgSVoSPm67BMVOB/kWHv4PPI0du7J5WrbbmpSaaU
 gtRk=
X-Google-Smtp-Source: AGHT+IG6wNLPBn9D+k3lHxvbiF9Da5hOdXQPIDekXn1W8n1pIHm8CZiAnP17w/405tcIUlGTgP6ytQ==
X-Received: by 2002:a05:6a21:279a:b0:1af:66a9:d104 with SMTP id
 rn26-20020a056a21279a00b001af66a9d104mr1046083pzb.1.1714684542020; 
 Thu, 02 May 2024 14:15:42 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a63f24e000000b0060063c4be3bsm1700915pgk.14.2024.05.02.14.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 14:15:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 5/9] plugins: conditional callbacks
Date: Thu,  2 May 2024 14:15:18 -0700
Message-Id: <20240502211522.346467-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
References: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Extend plugins API to support callback called with a given criteria
(evaluated inline).

Added functions:
- qemu_plugin_register_vcpu_tb_exec_cond_cb
- qemu_plugin_register_vcpu_insn_exec_cond_cb

They expect as parameter a condition, a qemu_plugin_u64_t (op1) and an
immediate (op2). Callback is called if op1 |cond| op2 is true.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h        |  8 ++++
 include/qemu/qemu-plugin.h   | 76 ++++++++++++++++++++++++++++++++++++
 plugins/plugin.h             |  8 ++++
 accel/tcg/plugin-gen.c       | 48 +++++++++++++++++++++++
 plugins/api.c                | 39 ++++++++++++++++++
 plugins/core.c               | 32 +++++++++++++++
 plugins/qemu-plugins.symbols |  2 +
 7 files changed, 213 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 0c5df7fa90a..0c0aae09e6f 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -68,6 +68,7 @@ union qemu_plugin_cb_sig {
 
 enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
+    PLUGIN_CB_COND,
     PLUGIN_CB_MEM_REGULAR,
     PLUGIN_CB_INLINE_ADD_U64,
     PLUGIN_CB_INLINE_STORE_U64,
@@ -89,6 +90,13 @@ struct qemu_plugin_dyn_cb {
             union qemu_plugin_cb_sig f;
             TCGHelperInfo *info;
         } regular;
+        struct {
+            union qemu_plugin_cb_sig f;
+            TCGHelperInfo *info;
+            qemu_plugin_u64 entry;
+            enum qemu_plugin_cond cond;
+            uint64_t imm;
+        } cond;
         struct {
             qemu_plugin_u64 entry;
             enum qemu_plugin_op op;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c5cac897a0b..337de25ece7 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -262,6 +262,29 @@ enum qemu_plugin_mem_rw {
     QEMU_PLUGIN_MEM_RW,
 };
 
+/**
+ * enum qemu_plugin_cond - condition to enable callback
+ *
+ * @QEMU_PLUGIN_COND_NEVER: false
+ * @QEMU_PLUGIN_COND_ALWAYS: true
+ * @QEMU_PLUGIN_COND_EQ: is equal?
+ * @QEMU_PLUGIN_COND_NE: is not equal?
+ * @QEMU_PLUGIN_COND_LT: is less than?
+ * @QEMU_PLUGIN_COND_LE: is less than or equal?
+ * @QEMU_PLUGIN_COND_GT: is greater than?
+ * @QEMU_PLUGIN_COND_GE: is greater than or equal?
+ */
+enum qemu_plugin_cond {
+    QEMU_PLUGIN_COND_NEVER,
+    QEMU_PLUGIN_COND_ALWAYS,
+    QEMU_PLUGIN_COND_EQ,
+    QEMU_PLUGIN_COND_NE,
+    QEMU_PLUGIN_COND_LT,
+    QEMU_PLUGIN_COND_LE,
+    QEMU_PLUGIN_COND_GT,
+    QEMU_PLUGIN_COND_GE,
+};
+
 /**
  * typedef qemu_plugin_vcpu_tb_trans_cb_t - translation callback
  * @id: unique plugin id
@@ -301,6 +324,32 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           enum qemu_plugin_cb_flags flags,
                                           void *userdata);
 
+/**
+ * qemu_plugin_register_vcpu_tb_exec_cond_cb() - register conditional callback
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @cb: callback function
+ * @cond: condition to enable callback
+ * @entry: first operand for condition
+ * @imm: second operand for condition
+ * @flags: does the plugin read or write the CPU's registers?
+ * @userdata: any plugin data to pass to the @cb?
+ *
+ * The @cb function is called when a translated unit executes if
+ * entry @cond imm is true.
+ * If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never interpreted and
+ * this function is equivalent to qemu_plugin_register_vcpu_tb_exec_cb.
+ * If condition QEMU_PLUGIN_COND_NEVER, condition is never interpreted and
+ * callback is never installed.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
+                                               qemu_plugin_vcpu_udata_cb_t cb,
+                                               enum qemu_plugin_cb_flags flags,
+                                               enum qemu_plugin_cond cond,
+                                               qemu_plugin_u64 entry,
+                                               uint64_t imm,
+                                               void *userdata);
+
 /**
  * enum qemu_plugin_op - describes an inline op
  *
@@ -344,6 +393,33 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             enum qemu_plugin_cb_flags flags,
                                             void *userdata);
 
+/**
+ * qemu_plugin_register_vcpu_insn_exec_cond_cb() - conditional insn execution cb
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @cb: callback function
+ * @flags: does the plugin read or write the CPU's registers?
+ * @cond: condition to enable callback
+ * @entry: first operand for condition
+ * @imm: second operand for condition
+ * @userdata: any plugin data to pass to the @cb?
+ *
+ * The @cb function is called when an instruction executes if
+ * entry @cond imm is true.
+ * If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never interpreted and
+ * this function is equivalent to qemu_plugin_register_vcpu_insn_exec_cb.
+ * If condition QEMU_PLUGIN_COND_NEVER, condition is never interpreted and
+ * callback is never installed.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_insn_exec_cond_cb(
+    struct qemu_plugin_insn *insn,
+    qemu_plugin_vcpu_udata_cb_t cb,
+    enum qemu_plugin_cb_flags flags,
+    enum qemu_plugin_cond cond,
+    qemu_plugin_u64 entry,
+    uint64_t imm,
+    void *userdata);
+
 /**
  * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
  * @insn: the opaque qemu_plugin_insn handle for an instruction
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 7c34f23cfcb..7d4b4e21f7c 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -93,6 +93,14 @@ plugin_register_dyn_cb__udata(GArray **arr,
                               qemu_plugin_vcpu_udata_cb_t cb,
                               enum qemu_plugin_cb_flags flags, void *udata);
 
+void
+plugin_register_dyn_cond_cb__udata(GArray **arr,
+                                   qemu_plugin_vcpu_udata_cb_t cb,
+                                   enum qemu_plugin_cb_flags flags,
+                                   enum qemu_plugin_cond cond,
+                                   qemu_plugin_u64 entry,
+                                   uint64_t imm,
+                                   void *udata);
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
                                  void *cb,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index a5313cbbb2f..9deddd74c42 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -132,6 +132,51 @@ static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
     return ptr;
 }
 
+static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
+{
+    switch (cond) {
+    case QEMU_PLUGIN_COND_EQ:
+        return TCG_COND_EQ;
+    case QEMU_PLUGIN_COND_NE:
+        return TCG_COND_NE;
+    case QEMU_PLUGIN_COND_LT:
+        return TCG_COND_LTU;
+    case QEMU_PLUGIN_COND_LE:
+        return TCG_COND_LEU;
+    case QEMU_PLUGIN_COND_GT:
+        return TCG_COND_GTU;
+    case QEMU_PLUGIN_COND_GE:
+        return TCG_COND_GEU;
+    default:
+        /* ALWAYS and NEVER conditions should never reach */
+        g_assert_not_reached();
+    }
+}
+
+static void gen_udata_cond_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->cond.entry);
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+    TCGLabel *after_cb = gen_new_label();
+
+    /* Condition should be negated, as calling the cb is the "else" path */
+    TCGCond cond = tcg_invert_cond(plugin_cond_to_tcgcond(cb->cond.cond));
+
+    tcg_gen_ld_i64(val, ptr, 0);
+    tcg_gen_brcondi_i64(cond, val, cb->cond.imm, after_cb);
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_call2(cb->cond.f.vcpu_udata, cb->cond.info, NULL,
+                  tcgv_i32_temp(cpu_index),
+                  tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    gen_set_label(after_cb);
+
+    tcg_temp_free_i64(val);
+    tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_ptr(ptr);
+}
+
 static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
 {
     TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
@@ -177,6 +222,9 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
     case PLUGIN_CB_REGULAR:
         gen_udata_cb(cb);
         break;
+    case PLUGIN_CB_COND:
+        gen_udata_cond_cb(cb);
+        break;
     case PLUGIN_CB_INLINE_ADD_U64:
         gen_inline_add_u64_cb(cb);
         break;
diff --git a/plugins/api.c b/plugins/api.c
index 3912c9cc8f6..2242d40bbbc 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -96,6 +96,25 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
     }
 }
 
+void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
+                                               qemu_plugin_vcpu_udata_cb_t cb,
+                                               enum qemu_plugin_cb_flags flags,
+                                               enum qemu_plugin_cond cond,
+                                               qemu_plugin_u64 entry,
+                                               uint64_t imm,
+                                               void *udata)
+{
+    if (cond == QEMU_PLUGIN_COND_NEVER || tb->mem_only) {
+        return;
+    }
+    if (cond == QEMU_PLUGIN_COND_ALWAYS) {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, cb, flags, udata);
+        return;
+    }
+    plugin_register_dyn_cond_cb__udata(&tb->cbs, cb, flags,
+                                       cond, entry, imm, udata);
+}
+
 void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
     struct qemu_plugin_tb *tb,
     enum qemu_plugin_op op,
@@ -117,6 +136,26 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
     }
 }
 
+void qemu_plugin_register_vcpu_insn_exec_cond_cb(
+    struct qemu_plugin_insn *insn,
+    qemu_plugin_vcpu_udata_cb_t cb,
+    enum qemu_plugin_cb_flags flags,
+    enum qemu_plugin_cond cond,
+    qemu_plugin_u64 entry,
+    uint64_t imm,
+    void *udata)
+{
+    if (cond == QEMU_PLUGIN_COND_NEVER || insn->mem_only) {
+        return;
+    }
+    if (cond == QEMU_PLUGIN_COND_ALWAYS) {
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, cb, flags, udata);
+        return;
+    }
+    plugin_register_dyn_cond_cb__udata(&insn->insn_cbs, cb, flags,
+                                       cond, entry, imm, udata);
+}
+
 void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_op op,
diff --git a/plugins/core.c b/plugins/core.c
index e1bf0dc3717..b3d0208e022 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -371,6 +371,38 @@ void plugin_register_dyn_cb__udata(GArray **arr,
     dyn_cb->regular.info = &info[flags];
 }
 
+void plugin_register_dyn_cond_cb__udata(GArray **arr,
+                                        qemu_plugin_vcpu_udata_cb_t cb,
+                                        enum qemu_plugin_cb_flags flags,
+                                        enum qemu_plugin_cond cond,
+                                        qemu_plugin_u64 entry,
+                                        uint64_t imm,
+                                        void *udata)
+{
+    static TCGHelperInfo info[3] = {
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        /*
+         * Match qemu_plugin_vcpu_udata_cb_t:
+         *   void (*)(uint32_t, void *)
+         */
+        [0 ... 2].typemask = (dh_typemask(void, 0) |
+                              dh_typemask(i32, 1) |
+                              dh_typemask(ptr, 2))
+    };
+
+    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
+    dyn_cb->userp = udata;
+    dyn_cb->type = PLUGIN_CB_COND;
+    dyn_cb->cond.f.vcpu_udata = cb;
+    dyn_cb->cond.cond = cond;
+    dyn_cb->cond.entry = entry;
+    dyn_cb->cond.imm = imm;
+
+    assert((unsigned)flags < ARRAY_SIZE(info));
+    dyn_cb->cond.info = &info[flags];
+}
+
 void plugin_register_vcpu_mem_cb(GArray **arr,
                                  void *cb,
                                  enum qemu_plugin_cb_flags flags,
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index a9fac056c7f..aa0a77a319f 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -27,6 +27,7 @@
   qemu_plugin_register_vcpu_idle_cb;
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_insn_exec_cb;
+  qemu_plugin_register_vcpu_insn_exec_cond_cb;
   qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_mem_cb;
   qemu_plugin_register_vcpu_mem_inline_per_vcpu;
@@ -34,6 +35,7 @@
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
+  qemu_plugin_register_vcpu_tb_exec_cond_cb;
   qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
-- 
2.39.2


