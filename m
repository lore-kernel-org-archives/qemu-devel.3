Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E00C48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHhS-0004hK-61; Tue, 06 Feb 2024 04:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhP-0004gt-Qj
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhN-0004ma-RG
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fdb18ffc7so17284465e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211498; x=1707816298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/g0mzC04szOUnabir1iLLohCVaDKcAp4uQzKj4Dxwg=;
 b=WqhZPq20rTP/4q7aSjt+/8odZ6p6q/mJAGXw1KAfYNrOxgzNwSbKutPk3UDbE4mXt0
 jMXlMnA2RM/5qPVvZ1Ho5mOoGsAg51/LJEDNOldv5N8N9VtwieGZEFhyTn+POXL11InQ
 muE7JEwq1ZyPPWr6tAnNi6d62UzVBZ6e3Crue5zjVjPNYebUmE6vVAfRK/QCzAz7XJyl
 5lHexawIi70xl2cjiOtu2kkFSUMLbFfYA3YIwvti9mvse9zLYsPJ2jkWtekTapA6jfKc
 E1KVh+OB6OUs6AQLijVyUBUd4+XdKlZxd7OqFQtKn45RfSPPT/s87xDcok6LmCAgEQNR
 O4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211498; x=1707816298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/g0mzC04szOUnabir1iLLohCVaDKcAp4uQzKj4Dxwg=;
 b=vuAxKIVIiiIjvtXKHNdHhfAiv9b6+LB+qvMATOaBYMOC4KRR3DX4dOOGgkobUg8kg0
 zz/VM0NQsypOzzb2bmEF+ibYpN1ymWUswSuxYLa1qaqCOzRGhQug/W3DKVJAXGkKolTt
 GWvXGA+auyjxgNfuXGst3ZPF3c7ewkV3T5lYtmdL5oEZTzHAnd6Biw89ve2kwPSrrokO
 xCfMdpAwRlyyAukwo9qWTpI6VxKC0zkekL2xOHJ1cUt0z4skEliWJqwqSTTHlRPMuplr
 6fjUuC0flzltP4u/WGChrk2+JltzYtO5DZzeo0QvT0uuITetg1USyIO3CHWPULFJVPlt
 loag==
X-Gm-Message-State: AOJu0YyJnABf4fnImQQ9Lu6Z1WeckSb+5r22BO7ivukGAjHNOMwjueRI
 +YN7EKvnIncoRNu9no8XDH5nBlu8lr1AOVbK/34iu/lpRUMgSkoYNVeM04cavjL8o7l5YYGvWEk
 lxJM=
X-Google-Smtp-Source: AGHT+IH+8nT9xcnw94BA8stxbQa5xKFKrAuaY+V9Kp/tazUjFz7EkOk4Jru+sqD+K6ymiOxt+jl0jg==
X-Received: by 2002:a05:600c:3b8b:b0:40f:df20:170e with SMTP id
 n11-20020a05600c3b8b00b0040fdf20170emr1176154wms.28.1707211498653; 
 Tue, 06 Feb 2024 01:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVkUoJtjxsYrrru7l6Q7fWujJ6IhxOQmpENemZpNSzhbD/MpcgbSBISnecs9TbnzgvStjswP8UBxvXneF3P3m8+vsuwgOAI4ynJcd3mn6VukHWzNAcsKzI8fDdWeaDl24vtzFZKllL6iFe2Jo2gBkWBxnJGnR8JSUpMXSkyMeOOTPlQDCIT/mEnXAkp4JbMRjdpt/sihwyJiqFejoACQDpDFsGMEAnVNHcKwspoIrqj1KI5vGnomL4qI1ovPq+qYDTh13wACY0unIqquP3pMX845aYrH+9D3kRCGpJXb4dPyxYq6VV4D70WiJPYpz1AN6MxKq0/ajGwWC8f+Qq+m4J1Nug++rjRfQ==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:58 -0800 (PST)
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
Subject: [PATCH v3 07/17] plugins: implement inline operation relative to
 cpu_index
Date: Tue,  6 Feb 2024 13:24:12 +0400
Message-ID: <20240206092423.3005995-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
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

Instead of working on a fixed memory location, allow to address it based
on cpu_index, an element size and a given offset.
Result address: ptr + offset + cpu_index * element_size.

With this, we can target a member in a struct array from a base pointer.

Current semantic is not modified, thus inline operation still targets
always the same memory location.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/plugin.h       |  2 +-
 accel/tcg/plugin-gen.c | 65 +++++++++++++++++++++++++++++++++++-------
 plugins/api.c          |  3 +-
 plugins/core.c         | 12 +++++---
 4 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index fd93a372803..77ed10689ca 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -100,7 +100,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
 
 int plugin_num_vcpus(void);
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b37ce7683e6..68dee4c68d3 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -132,16 +132,28 @@ static void gen_empty_udata_cb_no_rwg(void)
  */
 static void gen_empty_inline_cb(void)
 {
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    /* pass an immediate != 0 so that it doesn't get optimized away */
+    tcg_gen_muli_i32(cpu_index, cpu_index, 0xdeadbeef);
+    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
+
     tcg_gen_movi_ptr(ptr, 0);
+    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
     tcg_gen_ld_i64(val, ptr, 0);
     /* pass an immediate != 0 so that it doesn't get optimized away */
     tcg_gen_addi_i64(val, val, 0xdeadface);
+
     tcg_gen_st_i64(val, ptr, 0);
     tcg_temp_free_ptr(ptr);
     tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(cpu_index_as_ptr);
+    tcg_temp_free_i32(cpu_index);
 }
 
 static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
@@ -289,12 +301,37 @@ static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
     return op;
 }
 
+static TCGOp *copy_ld_i32(TCGOp **begin_op, TCGOp *op)
+{
+    return copy_op(begin_op, op, INDEX_op_ld_i32);
+}
+
+static TCGOp *copy_ext_i32_ptr(TCGOp **begin_op, TCGOp *op)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_ext_i32_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_add_ptr(TCGOp **begin_op, TCGOp *op)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        op = copy_op(begin_op, op, INDEX_op_add_i32);
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_add_i64);
+    }
+    return op;
+}
+
 static TCGOp *copy_ld_i64(TCGOp **begin_op, TCGOp *op)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         /* 2x ld_i32 */
-        op = copy_op(begin_op, op, INDEX_op_ld_i32);
-        op = copy_op(begin_op, op, INDEX_op_ld_i32);
+        op = copy_ld_i32(begin_op, op);
+        op = copy_ld_i32(begin_op, op);
     } else {
         /* ld_i64 */
         op = copy_op(begin_op, op, INDEX_op_ld_i64);
@@ -330,6 +367,13 @@ static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
     return op;
 }
 
+static TCGOp *copy_mul_i32(TCGOp **begin_op, TCGOp *op, uint32_t v)
+{
+    op = copy_op(begin_op, op, INDEX_op_mul_i32);
+    op->args[2] = tcgv_i32_arg(tcg_constant_i32(v));
+    return op;
+}
+
 static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
 {
     if (UINTPTR_MAX == UINT32_MAX) {
@@ -395,18 +439,17 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    /* const_ptr */
-    op = copy_const_ptr(&begin_op, op, cb->userp);
-
-    /* ld_i64 */
+    char *ptr = cb->userp;
+    size_t elem_size = 0;
+    size_t offset = 0;
+    op = copy_ld_i32(&begin_op, op);
+    op = copy_mul_i32(&begin_op, op, elem_size);
+    op = copy_ext_i32_ptr(&begin_op, op);
+    op = copy_const_ptr(&begin_op, op, ptr + offset);
+    op = copy_add_ptr(&begin_op, op);
     op = copy_ld_i64(&begin_op, op);
-
-    /* add_i64 */
     op = copy_add_i64(&begin_op, op, cb->inline_insn.imm);
-
-    /* st_i64 */
     op = copy_st_i64(&begin_op, op);
-
     return op;
 }
 
diff --git a/plugins/api.c b/plugins/api.c
index 15edad6769b..dedcbdfd30d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -106,7 +106,8 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               void *ptr, uint64_t imm)
 {
     if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
+        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
+                                  0, op, ptr, imm);
     }
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index fd8604bcb79..863c2e64217 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -320,7 +320,8 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
 
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
+                               enum qemu_plugin_op op,
+                               void *ptr,
                                uint64_t imm)
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
@@ -476,9 +477,12 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb)
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    uint64_t *val = cb->userp;
+    char *ptr = cb->userp;
+    size_t elem_size = 0;
+    size_t offset = 0;
+    uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
@@ -511,7 +515,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                            vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE:
-            exec_inline_op(cb);
+            exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
             g_assert_not_reached();
-- 
2.43.0


