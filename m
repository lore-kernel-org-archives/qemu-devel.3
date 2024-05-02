Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B978C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 18:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2as6-0003IU-74; Thu, 02 May 2024 14:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2arp-0003Cm-N8
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2aro-0003Rd-08
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:13 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1eb24e3a2d9so59304875ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714673349; x=1715278149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lsk4oECB6lPbH6nnvnJHxDeMiXhoORF0bXiX/ejFcVA=;
 b=G0E/Ucslnq7BJwpJEl/Ya5rTwh1Y6cqa6aYQi7fypoy4XqRfW+Z+bfZiijC3ZeGaLy
 PDHmcdcDhLPOqY2Ib+ettGU3VwUbTS3z9z9Iw3rxI/1hekQcFOo0fyMYVSEIsiHkvNVk
 a23VCxPmqHAf1JYZ/hEABK9WutvIKjDkNQ8f+/sqhwDiArnBB59GFAGio3MvSe8lJxvr
 nO7f5aPV5D+yMsFDEDE99mhAS9rEzQnkcFW/cNbyHy45YE+OqAo+DCCXZB5gLve8ek0e
 nH9vaX6pnDscY5SmsILCkm52s93MBk9pVq3ABwi1OJFXPUY2lg/CfKZ80YddC0JwMjTH
 OtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714673349; x=1715278149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lsk4oECB6lPbH6nnvnJHxDeMiXhoORF0bXiX/ejFcVA=;
 b=EH7Dfelaqe0V6+W8uqee+62Kg5Qu3nMT8/b2jwG+W06relZImvVmJj0nqQYZX/ORLA
 smZw9ZP1B3ubsl44Nfk9KQAhEPCdLkKI/zjd+Aka+N42ap3a41r0PjFSe3dgPVIxTATe
 oDr3czoYNZuwRZFkHrIernlh66zmU9qNGT5z6A8dNt0o27dRQABMdVlnxpjA6/d8mqSM
 sa5ImVjvOW03f4N02oKavcv81ThJva+aNX2OjEeZFTQe8agipsZlPPoqw0NENfws4XbH
 pJq6a2GtbVoaW3ktU8EQvyhYHjyvTVppjEsnC6x0vLZUeA0ylZGKG+3rFKuamxI/ldTJ
 hySg==
X-Gm-Message-State: AOJu0YyENor+8kmmyJwHq++jTGDH5kYvo93C85YorrKYlkENfiX1pn6Z
 UmnPaHN5OwwZQLrqX4HusA3qXks2zWTyNQvKhQ5sRXxDdetVRF5N2m1uYBLn8oyt9l5vnodA+x4
 u9Og=
X-Google-Smtp-Source: AGHT+IFcTuZbrYYw6bL0R34hq3tBNJgw1w0wZS0rTe6HJhldd0zWdK4FRoDEB4k1vmaY8NWenZ4dVQ==
X-Received: by 2002:a17:902:bb17:b0:1ec:7b0d:9eb9 with SMTP id
 im23-20020a170902bb1700b001ec7b0d9eb9mr388455plb.64.1714673349353; 
 Thu, 02 May 2024 11:09:09 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001ebd73f61fcsm1615605plg.121.2024.05.02.11.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 11:09:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 9/9] plugins: remove op from qemu_plugin_inline_cb
Date: Thu,  2 May 2024 11:08:47 -0700
Message-Id: <20240502180847.287673-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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


