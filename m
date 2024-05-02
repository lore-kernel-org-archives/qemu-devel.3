Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC301C25B4F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 21:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dmX-0008Vq-UF; Thu, 02 May 2024 17:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmV-0008VH-OF
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmP-00030q-Ho
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ed9fc77bbfso6811315b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714684547; x=1715289347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/LO5tC874FLSEu8fk1T5CBIMYOJ6qSGhK9i0Ks4R2w=;
 b=tjPAMAq9/KC1Qgum3OhJobN1iP3fKs1h2nx1tM6KIqrQze9IWGJSbr4finHhyrifQt
 +27YEha5OwBwi1QgGAdIRqxgjT8jN1nMYAl+FfcgfbO6Uc08IAPVidL/RYOqa0zoCUlW
 FWPip93BBbmunY/c4DSVA0J/9eKmIZJtng1HAcZagx5RRP9P+IkTWn6oeGzkPTN1W/Nt
 ND2zYLLs/XLeAYi7QNAidFZ8Ka2HPBaPOdMBbjj9rCNx2rqDIxpdLC6JYCxSOzSuxgey
 +UO5dL3IcNGIOnTcfETSj2WsjYARkFtHe0558INf7Btp3F5895Y4yT7zx0oyijmPtqax
 4BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714684547; x=1715289347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/LO5tC874FLSEu8fk1T5CBIMYOJ6qSGhK9i0Ks4R2w=;
 b=vpmUuhm7tETiinKXiAj0vBJYtYtGCgtlTHtKnfWlAYWICtgQJYlyPxuHVLHpBTf/Tq
 7wCJIuLdCywM+V1LInE2liUyLmFQvmHXN5jjKxk0/4bWlVh55Jof7GbRXd/DxToGQSGW
 kDVEbvbXez62bNcKCkW5JIIEalM0G3KzhJaG2iO7BVhX0cIx48YWbkFCN6ZzmNEkOrra
 SNnCWaMy/Zx9Kmz5qzxEVgIjVZ2NFbc40cHa9pnt3b/KYJkmqe1F1gFN6JvrzyzdPfy+
 kxpF+udl6KVCigxsIRpfeBsOAa3krNGvA/H5tSs4HKeztWZDUyDB1F9wTw0woaeDvITN
 XXPQ==
X-Gm-Message-State: AOJu0YzQxsDH7J9jB/UJ40ZcFsKERCVg4amghIniWntojE7Ftvq6m0Wx
 kdWueilUPZhgYtafSNmx6y/lj3BSFJV6zn29vQNYWgxSsdAa4vgxi+Hu6sk7hm1MZG4krbWcPVp
 91sE=
X-Google-Smtp-Source: AGHT+IGMZ/GfMB5thDNwvPdx0PGLkRj+zRBnCslwGJ548U/e1oryjCZKDCDFzj7TUG5jfVuZLuaoYg==
X-Received: by 2002:a05:6a20:8c2a:b0:1a7:a435:1388 with SMTP id
 j42-20020a056a208c2a00b001a7a4351388mr932631pzh.49.1714684547595; 
 Thu, 02 May 2024 14:15:47 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a63f24e000000b0060063c4be3bsm1700915pgk.14.2024.05.02.14.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 14:15:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 9/9] plugins: remove op from qemu_plugin_inline_cb
Date: Thu,  2 May 2024 14:15:22 -0700
Message-Id: <20240502211522.346467-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
References: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This field is not needed as the callback type already holds this
information.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h |  1 -
 plugins/plugin.h      |  4 +++-
 plugins/core.c        | 13 +++++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 313b7c72684..1ad8a59209b 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -83,7 +83,6 @@ struct qemu_plugin_regular_cb {
 
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


