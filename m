Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45747C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHp-0001N6-7i; Tue, 13 Feb 2024 04:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHm-0001MF-VM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHk-0000Fr-T8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:06 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41166710058so10055485e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817263; x=1708422063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHzR1Tdp7wuD7lKMTx4Q92ukiOIQPur1oGG8syEeMto=;
 b=w4vvAvaRiNHC3wSN/MAaubk4Yhr+JIUg6RGaZCPg1AYRetSD40lD5zoYjeA29KL8VE
 1qB6qqz/L3llCGUYz+1UWmWYTdbJFhcIpu0NYW3FPp58DFsYz2XSsU3wNk2Gm2KUbRCS
 g2nmhDvt3PMmQ6zGxHZhBte1ORnCgcP1iISIrSGqMemBqrqFt+FSqe1y6zYZK5Ie7qJc
 plMl9u2T9BtOaqdgH/lfrWj12aRm3UWdw/I1A7qluhdpoKlO4Zjru81U50Wene7u4BDj
 o2abtVbKpgafvj8WbRSX2J9fkS4vwUExEQ3Ifq18IEJ4HfdqTezF+c6c0Ms7gE+1Gdlt
 +h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817263; x=1708422063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHzR1Tdp7wuD7lKMTx4Q92ukiOIQPur1oGG8syEeMto=;
 b=MRI8gdiIlrQQjJlajkDgaNqLriPL/RDvPTEb3KlgMrwiWC2OpZ2EUAvLfwwWVnrkWP
 7bwdzLwp3rjudx1nqPQ0xOfJNsJODWTPhqmxXE2U9ucdy2O1GyqB10yb1Fd/+8mFazuD
 UEcw92LiZIL4XMabOnft9ZwMNo45WdzYsoPmZ6Q5SALVlYeqZaGKpFBqPlOB4uD2d19r
 JtzEjqQW9KQoYdLsrLnC0qq5VtRrow/0lgLyV2ZxkN5SjROCl8HGGJzA6i1gOYwCy4PO
 SNv2kkNDo4SRvvJkledPmCOUYXoXoA/J07O54Ms1uP3zS1FZoOSWWEys7ZJnAae8JSo9
 AxkQ==
X-Gm-Message-State: AOJu0YzYkPAWMD3Leyp0J+SYH27kkCOV0BR5jkQgz82NuIXDvcfhCqcf
 xxDqFZWVVqIYR8qmxo+RWl+Ti/XcmxV6u3rNJ20kLhZW2cg2ppeAs5VeUeUaEm+bANqCPjh5Pf8
 i
X-Google-Smtp-Source: AGHT+IEdcDIqCpDgWSfZa7GRFdhMwWml7Hx67yuh+6E4gecN2jhOS4Ubi62nC6sHqri/hR6O3ow1nQ==
X-Received: by 2002:a5d:6302:0:b0:33b:2153:b0f3 with SMTP id
 i2-20020a5d6302000000b0033b2153b0f3mr6693960wru.29.1707817262796; 
 Tue, 13 Feb 2024 01:41:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXbgoO0qt0yqlfRkAiIYZIvxvt6WejoSmu/wW5m9r9GMHfaq+L1+di0iCNe/Gn6BsH49BVSaIPE5oCoPdK8BdUdmMyBsFn6/kKQK66Rwv+yfmP7MVmWGl01by7W7p0VrJtfGdSFrtfqNwceBtgQU7ftJkUorlBTwFJ4b1Zhjief6pLYaJL3lQveqNkPPHA4OfOEStLKeFlAEIzXoNXRxCEWxvWXd7niW+9xw/CMJyY1Ymdad63mQhylCfnR43f8du/PozFQO50YkY4OgsxjKski625DFhhQKoIamOrE4EWXo26dwuMw1Kr7WgtzWkYodAaXXpMymzEvUJElXKB+0rEWnxCXZw==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:02 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 09/18] plugins: add inline operation per vcpu
Date: Tue, 13 Feb 2024 13:39:59 +0400
Message-ID: <20240213094009.150349-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x331.google.com
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

Extends API with three new functions:
qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().

Those functions takes a qemu_plugin_u64_t as input.

This allows to have a thread-safe and type-safe version of inline
operations.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h        |  1 +
 include/qemu/qemu-plugin.h   | 51 +++++++++++++++++++++++++++++++++++-
 plugins/plugin.h             |  6 +++++
 accel/tcg/plugin-gen.c       |  7 +++++
 plugins/api.c                | 37 +++++++++++++++++++++++++-
 plugins/core.c               | 23 ++++++++++++++++
 plugins/qemu-plugins.symbols |  3 +++
 7 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index ccf9d2ebd2d..e42353d9bb9 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -92,6 +92,7 @@ struct qemu_plugin_dyn_cb {
     /* fields specific to each dyn_cb type go here */
     union {
         struct {
+            qemu_plugin_u64 entry;
             enum qemu_plugin_op op;
             uint64_t imm;
         } inline_insn;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index a48586ef0c1..cdf1266d724 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -328,6 +328,22 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inline op
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @entry: entry to run op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op on a given scoreboard entry.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm);
+
 /**
  * qemu_plugin_register_vcpu_insn_exec_cb() - register insn execution cb
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -358,6 +374,22 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @entry: entry to run op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time an instruction executes.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm);
+
 /**
  * qemu_plugin_tb_n_insns() - query helper for number of insns in TB
  * @tb: opaque handle to TB passed to callback
@@ -583,7 +615,24 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm);
 
-
+/**
+ * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem access
+ * @insn: handle for instruction to instrument
+ * @rw: apply to reads, writes or both
+ * @op: the op, of type qemu_plugin_op
+ * @entry: entry to run op
+ * @imm: immediate data for @op
+ *
+ * This registers a inline op every memory access generated by the
+ * instruction.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_mem_rw rw,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm);
 
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 3bf1aaf5c2d..f6fa10a0f56 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -73,6 +73,12 @@ void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_op op, void *ptr,
                                uint64_t imm);
 
+void plugin_register_inline_op_on_entry(GArray **arr,
+                                        enum qemu_plugin_mem_rw rw,
+                                        enum qemu_plugin_op op,
+                                        qemu_plugin_u64 entry,
+                                        uint64_t imm);
+
 void plugin_reset_uninstall(qemu_plugin_id_t id,
                             qemu_plugin_simple_cb_t cb,
                             bool reset);
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c15627c5e47..25915a93242 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -442,6 +442,13 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
     char *ptr = cb->userp;
     size_t elem_size = 0;
     size_t offset = 0;
+    if (!ptr) {
+        /* use inline entry */
+        ptr = cb->inline_insn.entry.score->data->data;
+        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
+        offset = cb->inline_insn.entry.offset;
+    }
+
     op = copy_ld_i32(&begin_op, op);
     op = copy_mul_i32(&begin_op, op, elem_size);
     op = copy_ext_i32_ptr(&begin_op, op);
diff --git a/plugins/api.c b/plugins/api.c
index dedcbdfd30d..be2badda9fa 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -111,6 +111,18 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
     }
 }
 
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm)
+{
+    if (!tb->mem_only) {
+        plugin_register_inline_op_on_entry(
+            &tb->cbs[PLUGIN_CB_INLINE], 0, op, entry, imm);
+    }
+}
+
 void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
@@ -136,6 +148,18 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
     }
 }
 
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm)
+{
+    if (!insn->mem_only) {
+        plugin_register_inline_op_on_entry(
+            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE], 0, op, entry, imm);
+    }
+}
+
 
 /*
  * We always plant memory instrumentation because they don't finalise until
@@ -148,7 +172,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       void *udata)
 {
     plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
-                                    cb, flags, rw, udata);
+                                cb, flags, rw, udata);
 }
 
 void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
@@ -160,6 +184,17 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                               rw, op, ptr, imm);
 }
 
+void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_mem_rw rw,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm)
+{
+    plugin_register_inline_op_on_entry(
+        &insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE], rw, op, entry, imm);
+}
+
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb)
 {
diff --git a/plugins/core.c b/plugins/core.c
index 5984bc2568c..10ffdf6d938 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -326,6 +326,23 @@ void plugin_register_inline_op(GArray **arr,
     dyn_cb->inline_insn.imm = imm;
 }
 
+void plugin_register_inline_op_on_entry(GArray **arr,
+                                        enum qemu_plugin_mem_rw rw,
+                                        enum qemu_plugin_op op,
+                                        qemu_plugin_u64 entry,
+                                        uint64_t imm)
+{
+    struct qemu_plugin_dyn_cb *dyn_cb;
+
+    dyn_cb = plugin_get_dyn_cb(arr);
+    dyn_cb->userp = NULL;
+    dyn_cb->type = PLUGIN_CB_INLINE;
+    dyn_cb->rw = rw;
+    dyn_cb->inline_insn.entry = entry;
+    dyn_cb->inline_insn.op = op;
+    dyn_cb->inline_insn.imm = imm;
+}
+
 void plugin_register_dyn_cb__udata(GArray **arr,
                                    qemu_plugin_vcpu_udata_cb_t cb,
                                    enum qemu_plugin_cb_flags flags,
@@ -474,6 +491,12 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     char *ptr = cb->userp;
     size_t elem_size = 0;
     size_t offset = 0;
+    if (!ptr) {
+        /* use inline entry */
+        ptr = cb->inline_insn.entry.score->data->data;
+        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
+        offset = cb->inline_insn.entry.offset;
+    }
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 6204453d0fd..0d8141b85f1 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -28,13 +28,16 @@
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_insn_exec_cb;
   qemu_plugin_register_vcpu_insn_exec_inline;
+  qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_mem_cb;
   qemu_plugin_register_vcpu_mem_inline;
+  qemu_plugin_register_vcpu_mem_inline_per_vcpu;
   qemu_plugin_register_vcpu_resume_cb;
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
   qemu_plugin_register_vcpu_tb_exec_inline;
+  qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
   qemu_plugin_scoreboard_free;
-- 
2.43.0


