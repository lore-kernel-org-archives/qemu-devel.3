Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCAD112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PHB-0004ZE-H5; Wed, 11 Mar 2026 15:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0PH9-0004Yg-UC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 15:31:23 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0PH8-0007ME-4s
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 15:31:23 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8cd7284782dso13651285a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773257481; x=1773862281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoN1byBlNJBymheyUApYukXBcwXtZCRCGJ9HA0PFMhQ=;
 b=XX/zddccAaUpzJtqnVgRjYkmgKgfiSETfkks4hXMuoxCaAPyCkwSmM+ncPJ49TJ7zY
 186kzia8q9nBXdMRHtUx9mRVwxFlR6IxY4d3lLP1Fyi2zJFGMLILMM72PT6p8/+xnnsp
 oPSsbqprgSuuwa3QJnbfkvvL79Y9NonP5sHSi55Lmx/a0ovt/2GTlVJuTZvRhAqS5ji/
 2zc8qdlBv2t/3p2YttLcCPZt4OAi4XZrwZEJE78U96d/0xlshaJYC6YHBHSe87yI8XHR
 oSILNXdroPxxafvjG+S4I2KDuS0fJJG+uhyPRBEHZ8uf4xOwlQ9g1eck3l/N367ctwz3
 /Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773257481; x=1773862281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YoN1byBlNJBymheyUApYukXBcwXtZCRCGJ9HA0PFMhQ=;
 b=T1/41Htl5TdRN3H5Qa1Vrgc9CPuay5ZOmYUGFQMvGJgnCHXZ1g8McLn+REjVXO+sjk
 LFFE31t7m067N8T/sKV0zbTEHNRvhQ5w+1n+eAihViwBbSBmRhTPXS/irlI5h0NzPR/l
 GA/2d36/B4fllFmXoRReF/s9aW2rUsqQTtjktDL52gQUI2eRaA666puou7eapK8oWcbw
 N1uBkRaTZVmdbl84/HPywA3loH71EbkSAYOb+eUJEcVFns8b1sRSREUNfjZPhnHJ2rLX
 XTxONA1mAbvYMgqN3+YCDBSgp4jrYIG+ZFt60ICPAP8FoRF+kJoRa1qwvc0hLLJVwaCW
 qG/w==
X-Gm-Message-State: AOJu0YzCisdu8g79Qbm+423hObHBNpFQQv5qtk/4cBsC4dDo21iV6Fb0
 VVDt7O9KLWzQOnJDKRcrRFzFqtKPfWmWaVwJy8TgLpy9C1yeT/cyC0fVRks33gH0KcrFESJmCG/
 gDgGY
X-Gm-Gg: ATEYQzygsnDiGHsgyhBAdfjZ5owkp5HkDriHalN6m0z7zFh2QP1SYtCc0AyqqUB2N7K
 6QnrTlXQpXmVHnJ1jOZTkzs/yOYMA9Kk/wWUHit/owQD2SGg1LVaWpU0kF8DnME6koCzMpHwSMr
 Fv6fCYA51cXYJ8ERS8XuZaYu6t/ipuS90GUDyDM+jx5vb5D7ZQ80wDxolZxrdHQ83cJjHAI+Ade
 Fvn2I4koTaQi1OlOw3jrKqmCB/HZhuuwOm/IORzh5r0C0FPNMx07zDDr7iBcZ1ppq7x0rhaAeXR
 u9ANhghknImpnVeRdoM2pRUbYISnSwmbrXqqwpXqcsV0zQoSVTL4sPgMk7hkJnieRTTq7dFz4gU
 GRndMXxJ5Amu+aGEm3C13ysPr+pOTDR+0Fqrqv6gJ6Gx0t8hBIKlncpVQAn/kLh6yRbu6zmuVWa
 3lIwYjR8PiH1i45LAuV5nCIzHDtlHyCZUDTfCli0A7hJsyk7nEjHnPs1OInilBUSLY6iopIMG76
 JtC
X-Received: by 2002:a05:620a:19aa:b0:8cd:90f4:324d with SMTP id
 af79cd13be357-8cda196c760mr477014585a.31.1773257480904; 
 Wed, 11 Mar 2026 12:31:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda214be99sm213168585a.41.2026.03.11.12.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 12:31:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/1] plugins: add missing docstrings to qemu-plugin.h
Date: Wed, 11 Mar 2026 12:31:12 -0700
Message-ID: <20260311193112.417841-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311193112.417841-1-pierrick.bouvier@linaro.org>
References: <20260311193112.417841-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x730.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

This patch adds docstrings for typedefs and function declarations in
include/plugins/qemu-plugin.h that were previously missing. This
resolves inconsistencies in the docs, e.g., the description for
qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
but code cache flush callbacks not being documented themselves.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260311-add-missing-plugin-docs-v3-1-d68b9135e397@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/plugins/qemu-plugin.h | 106 ++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 12 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 827e8e17877..9e4e40aceee 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_RW_REGS_PC,
 };
 
+/**
+ * enum qemu_plugin_mem_rw - type of memory access
+ *
+ * @QEMU_PLUGIN_MEM_R: memory read access only
+ * @QEMU_PLUGIN_MEM_W: memory write access only
+ * @QEMU_PLUGIN_MEM_RW: memory read and write access
+ */
 enum qemu_plugin_mem_rw {
     QEMU_PLUGIN_MEM_R = 1,
     QEMU_PLUGIN_MEM_W,
     QEMU_PLUGIN_MEM_RW,
 };
 
+/**
+ * enum qemu_plugin_mem_value_type - size of memory value
+ *
+ * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value
+ * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value
+ * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value
+ * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value
+ * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value
+ */
 enum qemu_plugin_mem_value_type {
     QEMU_PLUGIN_MEM_VALUE_U8,
     QEMU_PLUGIN_MEM_VALUE_U16,
@@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {
     QEMU_PLUGIN_MEM_VALUE_U128,
 };
 
-/* typedef qemu_plugin_mem_value - value accessed during a load/store */
+/**
+ * typedef qemu_plugin_mem_value - value accessed during a load/store
+ *
+ * @type: the memory access size
+ * @data: the value accessed during the memory operation (value after
+ *        read/write)
+ */
 typedef struct {
     enum qemu_plugin_mem_value_type type;
     union {
@@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
  * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
  */
-
 enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
     QEMU_PLUGIN_INLINE_STORE_U64,
@@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void);
 QEMU_PLUGIN_API
 void qemu_plugin_update_ns(const void *handle, int64_t time);
 
+/**
+ * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function type
+ * @id: plugin id
+ * @vcpu_index: the executing vCPU
+ * @num: the syscall number
+ * @a1: the 1st syscall argument
+ * @a2: the 2nd syscall argument
+ * @a3: the 3rd syscall argument
+ * @a4: the 4th syscall argument
+ * @a5: the 5th syscall argument
+ * @a6: the 6th syscall argument
+ * @a7: the 7th syscall argument
+ * @a8: the 8th syscall argument
+ */
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
@@ -836,24 +871,62 @@ typedef bool
                                         uint64_t a6, uint64_t a7, uint64_t a8,
                                         uint64_t *sysret);
 
+/**
+ * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
+ * function type
+ * @id: plugin id
+ * @vcpu_index: the executing vCPU
+ * @num: the syscall number
+ * @ret: the syscall return value
+ */
+typedef void
+(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id,
+                                     unsigned int vcpu_index,
+                                     int64_t num, int64_t ret);
+
+/**
+ * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
+ * @id: plugin id
+ * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
+ *
+ * This registers a callback for every syscall executed by the guest. The @cb
+ * function is executed before a syscall is handled by the host.
+ */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
 
-typedef void
-(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
-                                     int64_t num, int64_t ret);
-
-QEMU_PLUGIN_API
-void
-qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
-                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
-
+/**
+ * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filter
+ * callback
+ * @id: plugin id
+ * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
+ *
+ * This registers a callback for every syscall executed by the guest. The @cb
+ * function is executed before a syscall is handled by the host. If the
+ * callback returns true, the syscall is filtered and will not be executed by
+ * the host. The callback must then set the syscall return value via the
+ * corresponding pointer passed to it.
+ */
 QEMU_PLUGIN_API
 void
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
                                             qemu_plugin_vcpu_syscall_filter_cb_t cb);
 
+/**
+ * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry
+ * callback
+ * @id: plugin id
+ * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t
+ *
+ * This registers a callback for every syscall executed by the guest. The @cb
+ * function is executed upon return from the host syscall before execution is
+ * handed back to the guest.
+ */
+QEMU_PLUGIN_API
+void
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
 /**
  * qemu_plugin_insn_disas() - return disassembly string for instruction
@@ -861,7 +934,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
  *
  * Returns an allocated string containing the disassembly
  */
-
 QEMU_PLUGIN_API
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
 
@@ -888,6 +960,16 @@ QEMU_PLUGIN_API
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb);
 
+/**
+ * qemu_plugin_register_flush_cb() - register code cache flush callback
+ * @id: plugin ID
+ * @cb: callback
+ *
+ * The @cb function is called every time the code cache is flushed.
+ * The callback can be used to free resources associated with existing
+ * translated blocks in a plugin. @cb is guaranteed to run with all cpus being
+ * stopped, thus no lock is required within it.
+ */
 QEMU_PLUGIN_API
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb);
-- 
2.47.3


