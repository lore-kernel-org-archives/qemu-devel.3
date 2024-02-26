Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F319C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX5S-0004c1-Pa; Mon, 26 Feb 2024 04:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX5R-0004bV-KC
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX5J-0005Dj-D3
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33dcd8dec88so654933f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938939; x=1709543739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2JL0lvPjHTbqYBDEnpbpZDHGDP1jZ/xznh+r/K8/d0=;
 b=AVADNh4GfA+Ax15dyNFHnDuxHBCYZcNjUgUfWZUvcFKytXa9VjOluygN2L+uN1vXVa
 7/ZUec01JI0ErVCIxeeRD/PGwewZUHpDeVml8co1zD1UiV3uFj5KewSZwa5hQgZEdmCB
 AEQoSspNqumPUPBj6gNByNdDF59IiTcVk5EOh6OuSaE3e1NGd2X8kwRTFQgXB3DQrXYt
 3eCYyU1lap8KtktBjKLKH8Cdb6oAc6XJNlVwRrgsTN9KVXrAquTud7LfMmYuCWc7AjwY
 +xfUy4QNGICJqmbpeKEfqUFhqsTPSMjW8rkx+ZYZS+qIutHnUDdIv1XKem2CwIZgtMyv
 /dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938939; x=1709543739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2JL0lvPjHTbqYBDEnpbpZDHGDP1jZ/xznh+r/K8/d0=;
 b=cUS/x1HaLlxXUQNuloVEmowgXoOkMJ9ZXP4wDr03JLIzeYA6LI2xzrQFRDRyG3Hyp4
 iMnLts1YWckKhblt/8xpW76kbenO8js41EFkzXnYGIfN1pXzZAZ/gCsD7o/VV7BE55at
 u4FOfAR25pYb5HXmHemxLJwqMLJAQTJsxWJOywHl3OkqUGTqjFTABCeW9TabiEJ1t4FA
 pPQ6a8Yq3gM8bU5gLj+kHp1hBPBnc1TCb0zNSpgUKAiqaT0pqwAKHG7AAl/WRS5ninXj
 fTvAHf8e0wflCfHu00sHHT0G+q7QcM5Uqlh3LL3xkk0N80RY2i7G8mCbSyUf/FRX7FI3
 k74w==
X-Gm-Message-State: AOJu0Yzm64ZubbQVvBruHLcr5hIkmN6LDp6ozkaxHU+ZgSJRn3gQ814+
 xKpPqCQS2BxltAzridv4dPEh8niNUATISzoelZTEEmHlOYKN3UEBA2a/+09cQTRmBugl80LIWYy
 yk93sfg==
X-Google-Smtp-Source: AGHT+IHb65bP/rHVwoupwbaI8n9GSPTwk+1yMBz5ukoWHayDWmsBYybwUsGOhWcLkogrFv8IibZeAg==
X-Received: by 2002:adf:e78f:0:b0:33d:38cf:aa76 with SMTP id
 n15-20020adfe78f000000b0033d38cfaa76mr4572454wrm.46.1708938939398; 
 Mon, 26 Feb 2024 01:15:39 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm7578814wrm.52.2024.02.26.01.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 01:15:39 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 12/12] plugins: cleanup codepath for previous inline
 operation
Date: Mon, 26 Feb 2024 13:14:44 +0400
Message-ID: <20240226091446.479436-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/plugin.h       |  5 -----
 accel/tcg/plugin-gen.c | 13 ++++---------
 plugins/core.c         | 29 ++++-------------------------
 3 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index f6fa10a0f56..7c34f23cfcb 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -68,11 +68,6 @@ struct qemu_plugin_ctx {
 
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
index 47e05ec6347..8028786c7bb 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -440,15 +440,10 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
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
index 4b428dc25b1..c0f06d6bcf9 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -315,22 +315,6 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
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
@@ -493,15 +477,10 @@ void qemu_plugin_flush_cb(void)
 
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


