Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16E5C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHhy-00056r-AV; Tue, 06 Feb 2024 04:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhY-0004pT-Cl
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:13 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhQ-0004qa-NO
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:11 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5112d5ab492so7430835e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211502; x=1707816302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jy1rbHGzFBtEHIrb0UzJIVl/3vebd/Q3PmRd1pnc7wk=;
 b=Y5ybvpuQ8VfabNi0Wf1awIleMgXCK1eLBJDW5Eh12dHrIVQrAH1oXS8SpqwjiiKcBU
 ptJD1vjz7RzUK+AABWge2ccTzAQB32LUWNlIQMxeZN5gAkhvJxUgBLxK1wPDVLzBpRqI
 Etv1ypKXdPsvLcSh3/ethg59wkf/GwIduglhzPWEN9C2EtXBS3+rNpYyA5/FOr5kC73l
 lFzOmrRR7Mc8Tp1jz3XEUC0G69EJChgzLOYDXLfD07RRjDqt4e65zj+4VhmOjVr4WK4X
 g7Laz0rEK9ZAmL6H+CUfo9L+knserqsSHBP9GPGQqQsysf4u0HYYDUoPZGAZ37ywbzlD
 q3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211502; x=1707816302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jy1rbHGzFBtEHIrb0UzJIVl/3vebd/Q3PmRd1pnc7wk=;
 b=XFZP0wkPfThGIcRlmq7ve5o0OsBGdSYufS8AeRr8Ho5nnvr6Y63HBnc+8dFT0MNqcN
 r+b4OW1UeM7I5ZFoEFTVMIhOcOzu4yg8UXaB5Cww6pD0jl2h/Ysr94KNw+2tQrw0zVlK
 ZyZTun8lk6wm2Z/lmWbfVCElwZA6fZZC+H3HpyEe2AnqUqHdiKieZXFUQzXwEN3HaP0e
 UaZGGKzvo7hcsZck7RCAxoOiC0wM9FRCwI1W2ULbC+LZVR6t4K9D7gS1IFRawoiL9GDK
 NhRXoDG20aqRVwOIrnJFh/ZuyimCpl99V/ZQpNcTilUd3W6bdAyQonpIseKQ7sXuBmaR
 oiyw==
X-Gm-Message-State: AOJu0YzD5wjnECw7uGMPBZDCcrjOhOpbNwuDS0K4dh45ltCpTK2UeOwi
 AI1mlwL0kLv4xzYD1ieLAGnku+Xs2frDtFLxpxTffE5DnhZf0p76YLpkNItdojxCuqvB//wYjA0
 Wtz8=
X-Google-Smtp-Source: AGHT+IFpUBYnXnP+z2bvT6GQL7mbjJ29+guU+SzxDlvyOKs/hpOaaF6GQ5EAKtCIZ/EDS46UmmCMrA==
X-Received: by 2002:ac2:495a:0:b0:511:4ba4:dc2b with SMTP id
 o26-20020ac2495a000000b005114ba4dc2bmr1404101lfi.21.1707211502228; 
 Tue, 06 Feb 2024 01:25:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWmFm9+NTdSrz9f1Z1xMd8TBX9XkaekBYSKiTACYZ2ocgZfvG2xPTieZazMr5zBauVUzuDQUZUwu/cC5xv5DKPpXsgCwQtQN/TJduftzk8hrL96B/XQqMgChvsXMz7uuaHzcEAWoB0aPNA8i1MBn00K8jcAv/PWHws7sKZ252/nLaD70ESMUc0T9d8dbufBHittckE1yyudJ/440ERXQrYTN0jI7jal2OZbP4p3HeCzmSs5OvuptmKPOQ+gkPkNsHnHWxD3XovloFA2yN7HarZ3yv3xNqnC48aIjzmKh8hdKmzgkn6fItbfJEI+Cj6rScO+EwnzCArKHWYo1Ew5cpJRHtpHcbMyQg==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:25:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/17] plugins: add inline operation per vcpu
Date: Tue,  6 Feb 2024 13:24:13 +0400
Message-ID: <20240206092423.3005995-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x136.google.com
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
index af4aeef4d78..0fd72544615 100644
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
index 77ed10689ca..1ece1b6707a 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -74,6 +74,12 @@ void plugin_register_inline_op(GArray **arr,
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
index 68dee4c68d3..4930e674c7d 100644
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
index 863c2e64217..48e351d7631 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -334,6 +334,23 @@ void plugin_register_inline_op(GArray **arr,
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
@@ -482,6 +499,12 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
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


