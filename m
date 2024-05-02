Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FFCC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 18:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2art-0003D1-Fn; Thu, 02 May 2024 14:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2ark-0003B2-1u
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2ari-0003Qk-9T
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so15775275ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714673343; x=1715278143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwiuoqvuZesoeTfyTbR5jyoxVWb/NhK8asPTRiYJ8l0=;
 b=gnqOiLJ+mrbuvK9W4U8SlyqpQtV+8/bN0yWkN9qSqYepSOAfrVQ5RQL5L31e/4TFh9
 sEgj9IN3+h73tbvEN0dQfrjzV8QJKWotf8iVax3RDJriulotEt5Yjt83JqR0l8te5H/n
 qZY78zP7WUd8BJ/+rsPgvtghZvnkvyXb1/pjoQtVrh4H1maknaEUtQaaNev0mCUR1X5l
 3KGZId+Th6R5C7reVVfDHWt6EcSkdN4N3IzHzkltA1vE/N8lOMBSknO66VCIh38PB1TH
 Si4pQJnR3CHB0k3Lrg9Jx172+A/yL6YAqDK+Ow/iJ8bVFIqgfeXXCqiGgC/M63L6Vofg
 L3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714673343; x=1715278143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwiuoqvuZesoeTfyTbR5jyoxVWb/NhK8asPTRiYJ8l0=;
 b=bV+ZEWQRtoGfTGMTBSSNkdh9Z4Lyg05fyd+O2f7WSiVQQ4KBkLdKR8XwDYn9fkwmsH
 +re6joNFb0ddYYoMp8vaM6Ib2XneGBfCPkeOSUnVqqEBwsorsDsBr/A3UVKNiGE9nIM7
 +juypk5tYX9rJtZPSSCDVKJYNXHIzkHxsv+teCEYkBCvl445qr65VBJUVCx87317qSA3
 0fe6nmtEiK9hM7t39I1FxhSTO/8FrUnc3xAyq4NYXbnD3VwU6wb+IiCh3p7LNFhge/kY
 8oRWVsaXosyoA8X3dVNEzevAavv41pSedNiR8F53ZviJ+5ALdCIYzmSAAGDP837NFR0P
 WUPw==
X-Gm-Message-State: AOJu0YwevrxlprMlKiguZig0UUyN6e/iW+4/RmI2TcsNy7PiRM8Lz4V4
 2bTv4bUoj7kGvDu2jwCYSpAUWFdwuXBU6YaETWv81qb8kF9RhDMhYwaEK99ts1mNBPMWXHK5so3
 GgP8=
X-Google-Smtp-Source: AGHT+IHWGMhPQ8RD4zXhqILGbNgp6u+RyJOxEwh1gRqzE2X/o376msy/i8VB/Kdb8aIJZexgOhaYBw==
X-Received: by 2002:a17:902:d491:b0:1ec:8206:626f with SMTP id
 c17-20020a170902d49100b001ec8206626fmr739666plg.9.1714673343439; 
 Thu, 02 May 2024 11:09:03 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001ebd73f61fcsm1615605plg.121.2024.05.02.11.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 11:09:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 4/9] tests/plugin/inline: add test for STORE_U64 inline op
Date: Thu,  2 May 2024 11:08:42 -0700
Message-Id: <20240502180847.287673-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
 tests/plugin/inline.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
index 0163e9b51c5..103c3a22f6e 100644
--- a/tests/plugin/inline.c
+++ b/tests/plugin/inline.c
@@ -22,6 +22,12 @@ typedef struct {
     uint64_t count_mem_inline;
 } CPUCount;
 
+typedef struct {
+    uint64_t data_insn;
+    uint64_t data_tb;
+    uint64_t data_mem;
+} CPUData;
+
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 count_tb;
 static qemu_plugin_u64 count_tb_inline;
@@ -29,6 +35,10 @@ static qemu_plugin_u64 count_insn;
 static qemu_plugin_u64 count_insn_inline;
 static qemu_plugin_u64 count_mem;
 static qemu_plugin_u64 count_mem_inline;
+static struct qemu_plugin_scoreboard *data;
+static qemu_plugin_u64 data_insn;
+static qemu_plugin_u64 data_tb;
+static qemu_plugin_u64 data_mem;
 
 static uint64_t global_count_tb;
 static uint64_t global_count_insn;
@@ -109,11 +119,13 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
     stats_mem();
 
     qemu_plugin_scoreboard_free(counts);
+    qemu_plugin_scoreboard_free(data);
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(count_tb, cpu_index, 1);
+    g_assert(qemu_plugin_u64_get(data_tb, cpu_index) == (uintptr_t) udata);
     g_mutex_lock(&tb_lock);
     max_cpu_index = MAX(max_cpu_index, cpu_index);
     global_count_tb++;
@@ -123,6 +135,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(count_insn, cpu_index, 1);
+    g_assert(qemu_plugin_u64_get(data_insn, cpu_index) == (uintptr_t) udata);
     g_mutex_lock(&insn_lock);
     global_count_insn++;
     g_mutex_unlock(&insn_lock);
@@ -131,9 +144,10 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 static void vcpu_mem_access(unsigned int cpu_index,
                             qemu_plugin_meminfo_t info,
                             uint64_t vaddr,
-                            void *userdata)
+                            void *udata)
 {
     qemu_plugin_u64_add(count_mem, cpu_index, 1);
+    g_assert(qemu_plugin_u64_get(data_mem, cpu_index) == (uintptr_t) udata);
     g_mutex_lock(&mem_lock);
     global_count_mem++;
     g_mutex_unlock(&mem_lock);
@@ -141,20 +155,34 @@ static void vcpu_mem_access(unsigned int cpu_index,
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
+    void *tb_store = tb;
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_STORE_U64, data_tb, (uintptr_t) tb_store);
     qemu_plugin_register_vcpu_tb_exec_cb(
-        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS, tb_store);
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
         tb, QEMU_PLUGIN_INLINE_ADD_U64, count_tb_inline, 1);
 
     for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        void *insn_store = insn;
+        void *mem_store = (char *)insn_store + 0xff;
+
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+            insn, QEMU_PLUGIN_INLINE_STORE_U64, data_insn,
+            (uintptr_t) insn_store);
         qemu_plugin_register_vcpu_insn_exec_cb(
-            insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+            insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, insn_store);
         qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
+
+        qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+            insn, QEMU_PLUGIN_MEM_RW,
+            QEMU_PLUGIN_INLINE_STORE_U64,
+            data_mem, (uintptr_t) mem_store);
         qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
                                          QEMU_PLUGIN_CB_NO_REGS,
-                                         QEMU_PLUGIN_MEM_RW, 0);
+                                         QEMU_PLUGIN_MEM_RW, mem_store);
         qemu_plugin_register_vcpu_mem_inline_per_vcpu(
             insn, QEMU_PLUGIN_MEM_RW,
             QEMU_PLUGIN_INLINE_ADD_U64,
@@ -179,6 +207,11 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         counts, CPUCount, count_insn_inline);
     count_mem_inline = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, count_mem_inline);
+    data = qemu_plugin_scoreboard_new(sizeof(CPUData));
+    data_insn = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_insn);
+    data_tb = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_tb);
+    data_mem = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_mem);
+
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
-- 
2.39.2


