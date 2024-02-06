Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C608C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHiO-0005bx-0m; Tue, 06 Feb 2024 04:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHi2-0005NY-CL
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHht-000521-DD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40fdc63f4feso14544105e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211530; x=1707816330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yU4raDcKf+FPYuHZq7bZi5tZwN3XViuFGVvnL6vOuMc=;
 b=rL21EtXtRvTG12D7JP2/bkNX7BdHvVty/jm5A7WRN9i7Ktxz3NnRKwDlP/Z+MRq0+b
 SklOC/y1d5R51Q4fD6OQSb4x6Vga7bgTF0c5UWiJNCaYsE/pjMDNzc5Y7KaBXcg4Fqvx
 z4jHHfqfKdExKbUM4ehAsiDHy6RiN3nDRxn8OWhOjFclQ0PMWdhtsFSZ06TL/dTU+liJ
 dqO1wgBu3Bqa+K/hg1DpNXOSi9llWCrwy7cd+cAb1agcnN63ElXRik6/cxoCFpqTAO4Y
 Q8QaWBOFGg/dVuZoIWKcp0cKxPb3Zp52tmLX1VPN3sn+jmLcPEgf5rpP93fOboeuPnjH
 jsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211530; x=1707816330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yU4raDcKf+FPYuHZq7bZi5tZwN3XViuFGVvnL6vOuMc=;
 b=X4yArsT0NnA8NzNz/qq92BILC5rcSc7BV5f7SYpToD82ofgAFpmJpfdDrlJ0hgs1BK
 l3uB4aFRrz+YRXtKID6BQ94/zz2YBvNWP9MPi6Ct2AoiNTk49MUdTgdr3XUZ71/gsT0y
 4sQAW2PFyZz/FhBzPnNnBZu2s1MxiZkUKjdH/QVWdAWCXrtnUTzFkGs2IKlbOMNzmdYp
 Q89+r75YB6K9MNrv9tzpgZe+PPTWR5wLCpcN0/bAKVMgDJYn2bqIkdxkNMOB7576jdW+
 YUZ/VnBzzhRYNifw9Rz9Y7PkoW9hTxxeaDCbDdSyYF8rp7oHVYptWtHSj29VpNpE0ryc
 F9Sw==
X-Gm-Message-State: AOJu0YyshJwnHqBgxFeqyxdMd17rAgw6dMRCBSlOWCQ9suxb6+65GqED
 NWaakwJKQPt0/DQthuDPIRqg6TdcedZu1CKI1B7Q74p8vDLgPChA02WFizw3IYRdhDJFrU2Zv3f
 3RtY=
X-Google-Smtp-Source: AGHT+IFlMp9UENKAEE/MOJJ72baQPZYIWrWX3nTpaR2WntLlPj7FQdIqLourKp/25Ccw8ntU8BCR9Q==
X-Received: by 2002:a05:600c:4f8f:b0:40e:c722:2b9a with SMTP id
 n15-20020a05600c4f8f00b0040ec7222b9amr1638513wmq.32.1707211530349; 
 Tue, 06 Feb 2024 01:25:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXf37gLZdIh419UqJnatI3dsluiwTIa8GlNYnfbK3uWuKiFCZZXtHeZQsWUmm0pbzdUDhH3ignaunToqvluglvCE+iKBPOWOZ2GQDnhYizyrUw3joN0tnkYq98SpDp9EqththJbnuQ3P0q1QFiywaOkJPXDhFx5A7NnXumFiplcTSvLNCsX2ARTPJOh3GPkmzfpZ0KHhHyY0WoA0FWMcy+HfxZAA32pF4z4jhvTIWTj4bzR58w775IQmkFDmaz8SgUsUvft1H4SdxR0KbapG5rgh3EbKTJFXv1fz+I5nCXuqb/xyjcGv58kkXJpYyBs1TO0l31mO3aa4ANKIXA7/m0P2ka+BMTR5w==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:25:30 -0800 (PST)
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
Subject: [PATCH v3 16/17] plugins: cleanup codepath for previous inline
 operation
Date: Tue,  6 Feb 2024 13:24:21 +0400
Message-ID: <20240206092423.3005995-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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
 plugins/plugin.h       |  5 -----
 accel/tcg/plugin-gen.c | 13 ++++---------
 plugins/core.c         | 29 ++++-------------------------
 3 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 8e485cfbd58..ba52a5995db 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -69,11 +69,6 @@ struct qemu_plugin_ctx {
 
 struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
-                               uint64_t imm);
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 4930e674c7d..0d613956734 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -439,15 +439,10 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
 
     op = copy_ld_i32(&begin_op, op);
     op = copy_mul_i32(&begin_op, op, elem_size);
diff --git a/plugins/core.c b/plugins/core.c
index 48e351d7631..7f1b8dbfd00 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -318,22 +318,6 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
 }
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op,
-                               void *ptr,
-                               uint64_t imm)
-{
-    struct qemu_plugin_dyn_cb *dyn_cb;
-
-    dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = ptr;
-    dyn_cb->type = PLUGIN_CB_INLINE;
-    dyn_cb->rw = rw;
-    dyn_cb->inline_insn.op = op;
-    dyn_cb->inline_insn.imm = imm;
-}
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
@@ -496,15 +480,10 @@ void qemu_plugin_flush_cb(void)
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
-- 
2.43.0


