Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AD7C54E6E
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJN-00030l-LV; Fri, 15 Mar 2024 21:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJF-0002xu-K9
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJD-0000nL-RZ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dff837d674so1595975ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554282; x=1711159082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgRR5z5N9ZwHDXdf41GgZ4jwjQp2wWo1KDtmOb5J2wQ=;
 b=ONjPB90mU3KHmE03s1nE0Pvus8BiQyKxoO7QSGwgI+Or5S7p+4l4o8izlFO+/WCLjK
 aLEw5sefbCaOr0kMjCpTBIVgbzoQqOnt8IkEg8zrJPI94sY34K06cFUpR/TUH2WyFHrr
 jwDiP88cs41W38btRPMg77L1CT0GK/j/1QB7uj2soxhkeaVlFofKa5KgOq4KvwWBX6Cp
 t8eNk2xbSBfpyObnd3QrNMEGS8BL2OwrxGVXHHyD9rC5h++tEGBMeWpdnBzdPMbdrXnp
 2fnoJbWubMrg9yS6MLv3QRWuQeqL1EjTqo6CgrDpzvNQrhyxdFKjIQRJN/i68U1tNfbk
 bbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554282; x=1711159082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgRR5z5N9ZwHDXdf41GgZ4jwjQp2wWo1KDtmOb5J2wQ=;
 b=jL2WkuQyf/Nr3W4+L+HUZrp/bu25HDf/gKZ4AALrDm0+tHBtEn4et/Biwv3oYEjlNA
 duyDPEsnbZD5qIu3h3xrZvqixswNNwRzlfvcMTz8xw2Z8wouqUhAZg7xTFXpAUx2f8WP
 +K/H8objSNXt3w9HhB6qCBsHUxQkuyvYg0lzfOGrKlQoyHgOBuTTC/L07Mylf1nlOgJK
 Tf+xUM4nBumLLYG0i7zTTImaHA+x2IFbNlkGqMwO4TIZ3B2AIFbNiNXf8Sui7T071aoo
 2yH/EwF5vAOPj8uBOi/lpDa3AljYRB0TV8qO871m4B0qLTg2OKvpsV1YVKIUFIWDh6gT
 ITEQ==
X-Gm-Message-State: AOJu0Yxcr5skTphZkXIs8ees8DgV6WzEcoczThrGtV81vzJrV1RuHzbK
 I2psWmPLAKZrfpTLQb1qC5ZeChBvD/qB8YssTxlbnTMjQSg8wdV4jbCidgv+1fYD5ihOYKHavYV
 E
X-Google-Smtp-Source: AGHT+IHXeJaFwsAGpY3IfBS/WzsVgk9xYpzzzt26ckwQQzisLZQxcs67AD+Tg9eciUKSmGfoeftrIg==
X-Received: by 2002:a17:902:da8b:b0:1dd:b3e0:519d with SMTP id
 j11-20020a170902da8b00b001ddb3e0519dmr8072434plx.6.1710554282422; 
 Fri, 15 Mar 2024 18:58:02 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:58:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 19/22] plugins: Merge qemu_plugin_tb_insn_get to plugin-gen.c
Date: Fri, 15 Mar 2024 15:57:17 -1000
Message-Id: <20240316015720.3661236-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Merge qemu_plugin_insn_alloc and qemu_plugin_tb_insn_get into
plugin_gen_insn_start, since it is used nowhere else.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 39 ---------------------------------------
 accel/tcg/plugin-gen.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 34498da717..07b1755990 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -128,14 +128,6 @@ static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
     g_byte_array_free(insn->data, true);
 }
 
-static inline struct qemu_plugin_insn *qemu_plugin_insn_alloc(void)
-{
-    struct qemu_plugin_insn *insn = g_new0(struct qemu_plugin_insn, 1);
-
-    insn->data = g_byte_array_sized_new(4);
-    return insn;
-}
-
 /* Internal context for this TranslationBlock */
 struct qemu_plugin_tb {
     GPtrArray *insns;
@@ -152,37 +144,6 @@ struct qemu_plugin_tb {
     GArray *cbs;
 };
 
-/**
- * qemu_plugin_tb_insn_get(): get next plugin record for translation.
- * @tb: the internal tb context
- * @pc: address of instruction
- */
-static inline
-struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
-                                                 uint64_t pc)
-{
-    struct qemu_plugin_insn *insn;
-
-    if (unlikely(tb->n == tb->insns->len)) {
-        struct qemu_plugin_insn *new_insn = qemu_plugin_insn_alloc();
-        g_ptr_array_add(tb->insns, new_insn);
-    }
-
-    insn = g_ptr_array_index(tb->insns, tb->n++);
-    g_byte_array_set_size(insn->data, 0);
-    insn->calls_helpers = false;
-    insn->mem_helper = false;
-    insn->vaddr = pc;
-    if (insn->insn_cbs) {
-        g_array_set_size(insn->insn_cbs, 0);
-    }
-    if (insn->mem_cbs) {
-        g_array_set_size(insn->mem_cbs, 0);
-    }
-
-    return insn;
-}
-
 /**
  * struct CPUPluginState - per-CPU state for plugins
  * @event_mask: plugin event bitmap. Modified only via async work.
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 28414c4ff1..70914c3bf8 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -380,11 +380,34 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
 {
     struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
-    struct qemu_plugin_insn *pinsn;
+    struct qemu_plugin_insn *insn;
+    size_t n = db->num_insns;
+    vaddr pc;
 
-    pinsn = qemu_plugin_tb_insn_get(ptb, db->pc_next);
-    tcg_ctx->plugin_insn = pinsn;
-    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
+    assert(n >= 1);
+    ptb->n = n;
+    if (n <= ptb->insns->len) {
+        insn = g_ptr_array_index(ptb->insns, n - 1);
+        g_byte_array_set_size(insn->data, 0);
+    } else {
+        assert(n - 1 == ptb->insns->len);
+        insn = g_new0(struct qemu_plugin_insn, 1);
+        insn->data = g_byte_array_sized_new(4);
+        g_ptr_array_add(ptb->insns, insn);
+    }
+
+    tcg_ctx->plugin_insn = insn;
+    insn->calls_helpers = false;
+    insn->mem_helper = false;
+    if (insn->insn_cbs) {
+        g_array_set_size(insn->insn_cbs, 0);
+    }
+    if (insn->mem_cbs) {
+        g_array_set_size(insn->mem_cbs, 0);
+    }
+
+    pc = db->pc_next;
+    insn->vaddr = pc;
 
     /*
      * Detect page crossing to get the new host address.
@@ -392,16 +415,18 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
      * fetching instructions from a region not backed by RAM.
      */
     if (ptb->haddr1 == NULL) {
-        pinsn->haddr = NULL;
+        insn->haddr = NULL;
     } else if (is_same_page(db, db->pc_next)) {
-        pinsn->haddr = ptb->haddr1 + pinsn->vaddr - ptb->vaddr;
+        insn->haddr = ptb->haddr1 + pc - ptb->vaddr;
     } else {
         if (ptb->vaddr2 == -1) {
             ptb->vaddr2 = TARGET_PAGE_ALIGN(db->pc_first);
             get_page_addr_code_hostp(cpu_env(cpu), ptb->vaddr2, &ptb->haddr2);
         }
-        pinsn->haddr = ptb->haddr2 + pinsn->vaddr - ptb->vaddr2;
+        insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
     }
+
+    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
 }
 
 void plugin_gen_insn_end(void)
-- 
2.34.1


