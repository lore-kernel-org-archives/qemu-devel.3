Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18216C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 21:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dmM-0008N5-UL; Thu, 02 May 2024 17:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmK-0008LW-MN
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmI-0002ok-Oj
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:44 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso7775792b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714684541; x=1715289341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwiuoqvuZesoeTfyTbR5jyoxVWb/NhK8asPTRiYJ8l0=;
 b=QOIg6JYEpzyMOxC20dbh4IJQKZAlM9bPGWhVnIMVzGXQUQiVzmaGcoKSFMHFyfARtp
 91hSgqLzE1ZtH/NB83UbA9Qde8RTdlQicvhRfdtBwvvH4fEXoKNuZRB0h+FLbC1dCLpj
 kXhULakyqWddi5sTiLgH5kw69PZgHRM47cqP7nfeL4thSV1Kd+81f4JyuaGYgAKe2eo9
 UEVLzXhhTe3uo6Lsnm8AGxB74psQ6msKnEb1jrpCn7vwmCcPPq4ug0t3U6mEA1jt+Kgn
 N3qSm9oq3zaUAd92G6P/L00ZeHzz00HUeb6SR0BX70esOU1ze7E1geMVmuTcuSEzSe0Q
 a0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714684541; x=1715289341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwiuoqvuZesoeTfyTbR5jyoxVWb/NhK8asPTRiYJ8l0=;
 b=IVVMVtaJLOCCDXPaTsXMv8jtXMin9DquGMU5V4E/kc07UEZgN9bipxuwXEy+W6yegp
 U0XwMQEC5DM+qACU+vkJE/mFTUETA8A1036riPSNGg26dhwILofQGOYIe0OqSb5UGpOT
 Rffa4XJl1fzhSyI4SuAsnla+NQpW2oNkpubLkQnNYF+DuyLvgx1l+PIlhpEzbgNnul5j
 suyqapDW2Ek04uIMRH5bcBdASRa+Y/LdiPgja91cElJ5tNUeYulFent0PKDPfUzObM2N
 zc44R4qIkGw5mXU1tDlPz+tSrVhzU3BRz5eX2Us9J79nQlkyDGpV8n3kSCw4zQZ4kgXU
 4RUA==
X-Gm-Message-State: AOJu0YyfSx37HX+pm4ox62dp+CL8DIwWVajaf9p1B/yEFh8nyHS2EgSE
 h93xEEZ0HHfDwJ2cYVMZYKJcYtBmO1AbQqLxot9q1Xg88A/RYyZoSQfFx2XfAN7Hxl7u4clF6dS
 I/U4=
X-Google-Smtp-Source: AGHT+IGN6I4FUkf/rLU1GmfyBLNIiTNDl2q4kIn4/rlvRDsRyIVHc7sKYtlhGkZxoB31DD+HD2n19A==
X-Received: by 2002:aa7:88d2:0:b0:6ec:fdfe:9bde with SMTP id
 k18-20020aa788d2000000b006ecfdfe9bdemr783078pff.25.1714684540948; 
 Thu, 02 May 2024 14:15:40 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a63f24e000000b0060063c4be3bsm1700915pgk.14.2024.05.02.14.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 14:15:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 4/9] tests/plugin/inline: add test for STORE_U64 inline op
Date: Thu,  2 May 2024 14:15:17 -0700
Message-Id: <20240502211522.346467-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
References: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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


