Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A51AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp61L-0005Rn-Lh; Tue, 26 Mar 2024 08:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp61K-0005RA-Rl
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp61J-0000hx-8y
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41490d05b2cso1139365e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456511; x=1712061311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vj9khMMybYoBi53WQZnVBkx0fV+CetJXYOmHrrh01o=;
 b=J+G0K6JbS8wS7l+jGAQm1RQje7YrzpmzneMlMkZ8vd99jbAoX4rafrLYjEZYGSQbkm
 DI96VtjpMNMc9SMlTm6FOt96iULwilqKqhhOE5QBJnbTlIva2xNVqAoyKKodeEsejyLI
 3B7GL/N/0M80C+Bi017TaXdNdT8jX609/q6fYfu7zbiDSHMnGiRNscg40jivbJhaSFT6
 ui16KnedThoQCdTrWWBLQx4KQk8qh9htdQk/WjicsxfKsiRSBpkXEf0cCZVn5DHy/ReG
 ssO1f4VJMFfrfMtlY0TIwnSxFEZZf2lLtDob/9r69wcpp0swbIfJD7XD4qqFbCHp3XpY
 G0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456511; x=1712061311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vj9khMMybYoBi53WQZnVBkx0fV+CetJXYOmHrrh01o=;
 b=AYOqE+rawIRzeI5cx3E7DrvwCPtCkK6DnkAdXPg8imxj29J8TG3R7Ph8y4fe6s7tHt
 G+S7RSywbP5wPdTHyNqEBEhmDvCIPUmjG/TsnXxy32ebSn4/X+84WGFG9zuVKR7Kf7DS
 b2FHd5NHtUqT1JqniAGSkuCm75EnjYNgMKkfRPh5vlYDwDVCBvJhy6BmkCXtqPcfGfRr
 g0rdl5ifCQyqpWd9fYRCWQkAVqu0RGNO1Fot3nz+hdQQ6xlVK7F0/1CuCiXW84nEUjMm
 Nr5KtqMWrkxhGCDZixpNNcAz0x+F6kS21awmN42J9/7xjY8zh1qzN+GsNHW1P3rkarDk
 MGsg==
X-Gm-Message-State: AOJu0YxuGDfI1jmjc2lj29ODOQ8nrCW6X4Lf5gDq9BJ7bu2gzBon9P/v
 K+B1mMe+7IQqEtMkGxuk86//cqzTUaYH23mxSacY+ruWXNDLAvxthAioXozHTXf+MdK390e09ej
 qvig=
X-Google-Smtp-Source: AGHT+IEW2z6C8OOwCwfZ6zUa7Lq4sTm3MXTQlkJJeVaJMOVscAwW0oyaoNKi0/QUS5moS56Hb5deGg==
X-Received: by 2002:a05:600c:4ed0:b0:414:e24:12b4 with SMTP id
 g16-20020a05600c4ed000b004140e2412b4mr2006116wmq.34.1711456510933; 
 Tue, 26 Mar 2024 05:35:10 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b004148090cf85sm716317wma.0.2024.03.26.05.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:35:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 9/9] plugins: remove op from qemu_plugin_inline_cb
Date: Tue, 26 Mar 2024 16:34:26 +0400
Message-Id: <20240326123426.761473-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h |  1 -
 plugins/plugin.h      |  4 +++-
 plugins/core.c        | 13 +++++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index a078229942f..7f7b915e495 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -82,7 +82,6 @@ struct qemu_plugin_regular_cb {
 
 struct qemu_plugin_inline_cb {
     qemu_plugin_u64 entry;
-    enum qemu_plugin_op op;
     uint64_t imm;
     enum qemu_plugin_mem_rw rw;
 };
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 80d5daa9171..30e2299a54d 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -108,7 +108,9 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index);
+void exec_inline_op(enum plugin_dyn_cb_type type,
+                    struct qemu_plugin_inline_cb *cb,
+                    int cpu_index);
 
 int plugin_num_vcpus(void);
 
diff --git a/plugins/core.c b/plugins/core.c
index 7ea2ee208db..a9f19e197aa 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -338,7 +338,6 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 
     struct qemu_plugin_inline_cb inline_cb = { .rw = rw,
                                                .entry = entry,
-                                               .op = op,
                                                .imm = imm };
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->type = op_to_cb_type(op);
@@ -557,7 +556,9 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index)
+void exec_inline_op(enum plugin_dyn_cb_type type,
+                    struct qemu_plugin_inline_cb *cb,
+                    int cpu_index)
 {
     char *ptr = cb->entry.score->data->data;
     size_t elem_size = g_array_get_element_size(
@@ -565,11 +566,11 @@ void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index)
     size_t offset = cb->entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
-    switch (cb->op) {
-    case QEMU_PLUGIN_INLINE_ADD_U64:
+    switch (type) {
+    case PLUGIN_CB_INLINE_ADD_U64:
         *val += cb->imm;
         break;
-    case QEMU_PLUGIN_INLINE_STORE_U64:
+    case PLUGIN_CB_INLINE_STORE_U64:
         *val = cb->imm;
         break;
     default:
@@ -601,7 +602,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
         case PLUGIN_CB_INLINE_ADD_U64:
         case PLUGIN_CB_INLINE_STORE_U64:
             if (rw && cb->inline_insn.rw) {
-                exec_inline_op(&cb->inline_insn, cpu->cpu_index);
+                exec_inline_op(cb->type, &cb->inline_insn, cpu->cpu_index);
             }
             break;
         default:
-- 
2.39.2


