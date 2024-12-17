Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE69E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHh-0004Ke-In; Tue, 17 Dec 2024 17:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHf-0004Je-Ps
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:19 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHc-00019k-Rd
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:19 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso4575806b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475395; x=1735080195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0X1MlNNMfXe3fyFvrKoslEpzjFsMN2sr/cA5ARxGXA=;
 b=mzHlmLHcZ8Fo7pqVvqGdxzzG9QxkoKMX4Rgvb15Ro1+Hge2csQtIxynVJZrg97tyoW
 Yk7LCkr5IuYB9yIRDbnFB45gPOYfb7tUuRxUD7SvdE2tmRsofpD0lnBuj5QZKHfIqWE9
 m/DsdB+9qE3ruYMDUN5orL25aV3DBSBqLUxf5Wrhy6H6GG8dPZMRsnEg50b5E0GFQ/M+
 X8QZU2ImB6wZ6z05Abio2e0bOdSf3/4NnyMq2S/sNsq7Sw/q7viSNGljQf0VOS2a/BZw
 vmnUVewZzQ2Po5fQwzI57S2ZM5oDl5lrKs6OnFEariDmnB3Zs3r7n0oynYjUNthQA+x6
 W4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475395; x=1735080195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0X1MlNNMfXe3fyFvrKoslEpzjFsMN2sr/cA5ARxGXA=;
 b=gRi2dsIGhrIVLUvweIvXHQGKrguKWowa4pb5sF7VOvdMIU0vUWodgsLV3wsMhOJbEU
 Vbu1BtxaiJ4fk5bgt0KMABLHEa9EHF2joLhU048oMGqZj8wP/7Lb2dnmnGiL8BEhE/aM
 JxOoX+1C1ua8IeGN0xzLzV343n5KjOgI0c6fUQgjjZPg1VRTiVf1OLRdBacrKW71NppP
 +vrJF3NfFK0GkxGIhadIGjnKFfkSzJaFIdvs/5vQWSTK2vB/cP0QrREzL/mfr8wckIf2
 CeS7MtfTHcKcTigF7fmTnH+f4MxBbjcBMO8UyusWzhs6xOpk8a0jN956HuRx40OSwJ6X
 YspA==
X-Gm-Message-State: AOJu0YwxEhn4GNeDx9jnMynQt1V4pBQkcVQ1XL+Q5tbnqdpECBIjXO5w
 hvBrIuJwER6e9vT71F4ZgZF8CHQ2WgJ0gZN46Lfn57e8qZ0hk99/ZOtqLkEoFBlo508T6CNif1j
 Qp6s=
X-Gm-Gg: ASbGnctVRaiO2sQW9BmU5VpOeAVgyP232C62haWdKNcQyaCDh0a1jJTeYVP7GIKR+fc
 LAwAix3BGk6S2/qTP3TPfwfvpsqwueA6DqZd1lKOE4C+8xnWBXo/wR9hOg6fISk+DA+NHAPprAF
 /q8PRP8kGWJ/30PF9IITT2FAU6iGF1BqwHbs0N+PXExmycNfUWiZXC2V2qaOC6GL4Luu1EuEIVJ
 XaloPsLqMO8OvN6bRHkUhUArDh/gUboXzUMGLDVkdkw+KeNGlY5gM7s
X-Google-Smtp-Source: AGHT+IHhV1+e7qDlpH/39EOrBl/0IOuMcvsw5ERVXjjgPkTXYRyNqhcHKibk/u+Mm65vUu65rltJZw==
X-Received: by 2002:a05:6a20:c70a:b0:1e0:d380:fe66 with SMTP id
 adf61e73a8af0-1e5b4515e91mr1107320637.0.1734475395262; 
 Tue, 17 Dec 2024 14:43:15 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 05/11] contrib/plugins/stoptrigger: fix 32-bit build
Date: Tue, 17 Dec 2024 14:43:00 -0800
Message-Id: <20241217224306.2900490-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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
 contrib/plugins/stoptrigger.c | 48 ++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index 03ee22f4c6a..b3a6ed66a7b 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -21,9 +21,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 /* Scoreboard to track executed instructions count */
 typedef struct {
     uint64_t insn_count;
+    uint64_t current_pc;
 } InstructionsCount;
 static struct qemu_plugin_scoreboard *insn_count_sb;
 static qemu_plugin_u64 insn_count;
+static qemu_plugin_u64 current_pc;
 
 static uint64_t icount;
 static int icount_exit_code;
@@ -34,6 +36,11 @@ static bool exit_on_address;
 /* Map trigger addresses to exit code */
 static GHashTable *addrs_ht;
 
+typedef struct {
+    uint64_t exit_addr;
+    int exit_code;
+} ExitInfo;
+
 static void exit_emulation(int return_code, char *message)
 {
     qemu_plugin_outs(message);
@@ -43,23 +50,18 @@ static void exit_emulation(int return_code, char *message)
 
 static void exit_icount_reached(unsigned int cpu_index, void *udata)
 {
-    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
+    uint64_t insn_vaddr = qemu_plugin_u64_get(current_pc, cpu_index);
     char *msg = g_strdup_printf("icount reached at 0x%" PRIx64 ", exiting\n",
                                 insn_vaddr);
-
     exit_emulation(icount_exit_code, msg);
 }
 
 static void exit_address_reached(unsigned int cpu_index, void *udata)
 {
-    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
-    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", insn_vaddr);
-    int exit_code;
-
-    exit_code = GPOINTER_TO_INT(
-        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
-
-    exit_emulation(exit_code, msg);
+    ExitInfo *ei = udata;
+    g_assert(ei);
+    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", ei->exit_addr);
+    exit_emulation(ei->exit_code, msg);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -67,23 +69,25 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     size_t tb_n = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < tb_n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        gpointer insn_vaddr = GUINT_TO_POINTER(qemu_plugin_insn_vaddr(insn));
+        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
 
         if (exit_on_icount) {
             /* Increment and check scoreboard for each instruction */
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_STORE_U64, current_pc, insn_vaddr);
             qemu_plugin_register_vcpu_insn_exec_cond_cb(
                 insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
-                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, insn_vaddr);
+                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, NULL);
         }
 
         if (exit_on_address) {
-            if (g_hash_table_contains(addrs_ht, insn_vaddr)) {
+            ExitInfo *ei = g_hash_table_lookup(addrs_ht, &insn_vaddr);
+            if (ei) {
                 /* Exit triggered by address */
                 qemu_plugin_register_vcpu_insn_exec_cb(
-                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
-                    insn_vaddr);
+                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS, ei);
             }
         }
     }
@@ -99,11 +103,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
 {
-    addrs_ht = g_hash_table_new(NULL, g_direct_equal);
+    addrs_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
 
     insn_count_sb = qemu_plugin_scoreboard_new(sizeof(InstructionsCount));
     insn_count = qemu_plugin_scoreboard_u64_in_struct(
         insn_count_sb, InstructionsCount, insn_count);
+    current_pc = qemu_plugin_scoreboard_u64_in_struct(
+        insn_count_sb, InstructionsCount, current_pc);
 
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
@@ -124,13 +130,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             exit_on_icount = true;
         } else if (g_strcmp0(tokens[0], "addr") == 0) {
             g_auto(GStrv) addr_tokens = g_strsplit(tokens[1], ":", 2);
-            uint64_t exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
-            int exit_code = 0;
+            ExitInfo *ei = g_malloc(sizeof(ExitInfo));
+            ei->exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
+            ei->exit_code = 0;
             if (addr_tokens[1]) {
-                exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
+                ei->exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
             }
-            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
-                                GINT_TO_POINTER(exit_code));
+            g_hash_table_insert(addrs_ht, &ei->exit_addr, ei);
             exit_on_address = true;
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
-- 
2.39.5


