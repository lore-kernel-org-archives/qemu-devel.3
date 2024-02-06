Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A670C4829C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHiP-0005tI-5x; Tue, 06 Feb 2024 04:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhr-0005GG-Vy
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:36 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhe-0004zW-LJ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40fc6578423so35407185e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211516; x=1707816316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpn7ZrX++QOMXIPnhSOuAzbdhuGwGNkpxbx03u36x+U=;
 b=s2nBvNaw14+vObWdOIheMf7F9dXwtU/xW/6xQci2kw64rKVG4aWY5mUKahLtc5dggJ
 UXOeAqlqZyyyleNyvom21f5MroYRClDescBCT3jr5rntmHuAvBxWfNbbY1oY4tPLBxe/
 NPsobT+NamQgHTYR8h5ve3AdlLx6OBENZg9gpFb07xPT//qUU39lTdhgY2OnH4S9oq56
 B1LYuQNgkrH0vidLapYUhYyOEUk6fnJop60c4H9FJMqzgypcEEQptGZ0AedwQ/q999JC
 mdQwwDGHDlGxynu2JF3YxJFcluCSzvuh0vItBaS+HmzFN0FXUOFNeie6lebI/e/z1obS
 Pj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211516; x=1707816316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpn7ZrX++QOMXIPnhSOuAzbdhuGwGNkpxbx03u36x+U=;
 b=V/sUoUkPfjMyr6zWke22TxleMYphF9k5325glOQcU39dCag7wlbM8Az7mBNJsTBSQp
 5y1NMYWA5EVbY+2vUhPyUm+8+jBUIu6h++psOvQ7n/MlRexhOF2NaH/qDKi6SquxpUqB
 HJWVm134WZcX7jQR0Yuu2u6V+OAq9oL0MEWUpYQj++9EUmqvYynGSaNk+KaNZyjt7Hrh
 pXl4R2G1YZPhDta4bu/ULFnFdEZnHFRSP5ZPNINNWD90JEEdBxKxRxj4Q6CoA0XnWiYj
 DghSO0GXD7elBMhVw+i5nRhV1Q39OmYwB5RHU7uL6u/oeI+/kgOrmj+VxPdSGUVxkfn/
 kQ5A==
X-Gm-Message-State: AOJu0YwbBrOdf7m8ONhTJDdvCXu2ETILDfyi8YSSZWYUD4MnXMBkWVPT
 Jm7YjpQXW0thv7Acc1nvJ0VQFxyIldQbTGQIUJxbeaXqf5Ggiql5nILbi9omuPL4E1bX3PMzb0y
 z8Tc=
X-Google-Smtp-Source: AGHT+IFSMJuVJV5wAejP+kHXQzrJT7bnIWj8fcaBoQ2F/RTJjiX9Tbjq9ufkpgD8iXNEGS6rXJF3Xw==
X-Received: by 2002:a05:600c:3b11:b0:40e:fb8f:76b2 with SMTP id
 m17-20020a05600c3b1100b0040efb8f76b2mr1228668wms.12.1707211516270; 
 Tue, 06 Feb 2024 01:25:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW0jfc3MbXKY5AB/3k2PfJ3xXJUnv/eWGALsxO710J4S4tyGv+l55z8CtL0fZAS+bB6ni1Wptbxwp5piXKGRtLBBzu/hTPO5C5ucc3+2BRg8S3uctNqBVWeV1N2v8yMB/LnKFcBLtBYy5EG2OIT7WcF7HSVA7RLu9FiphPLHEz6Mv+82h7CRP7vHKznLMpvzVw1xyzZ0+Sh5zFyxd+ep7jOPhNthZhYiTTUyHwLKtDWHFubtnY8j1YE7Jf+tqHIERuTv7r0O9ED1FU+NZL3XAoOIQvaaRECbXiTL/ievlOtS7iWh7m9vOyJP+bNNtiFQbRCnx435BpRQLkFJJv2dE3kWly/t2F10g==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:25:16 -0800 (PST)
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
Subject: [PATCH v3 12/17] tests/plugin/bb: migrate to new per_vcpu API
Date: Tue,  6 Feb 2024 13:24:17 +0400
Message-ID: <20240206092423.3005995-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x332.google.com
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
 tests/plugin/bb.c | 63 +++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index df50d1fd3bc..36776dee1e1 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -17,27 +17,25 @@
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
 typedef struct {
-    GMutex lock;
-    int index;
     uint64_t bb_count;
     uint64_t insn_count;
 } CPUCount;
 
-/* Used by the inline & linux-user counts */
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64 bb_count;
+static qemu_plugin_u64 insn_count;
+
 static bool do_inline;
-static CPUCount inline_count;
-
 /* Dump running CPU total on idle? */
 static bool idle_report;
-static GPtrArray *counts;
-static int max_cpus;
 
-static void gen_one_cpu_report(CPUCount *count, GString *report)
+static void gen_one_cpu_report(CPUCount *count, GString *report,
+                               unsigned int cpu_index)
 {
     if (count->bb_count) {
         g_string_append_printf(report, "CPU%d: "
                                "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                               count->index,
+                               cpu_index,
                                count->bb_count, count->insn_count);
     }
 }
@@ -46,20 +44,23 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("");
 
-    if (do_inline || !max_cpus) {
-        g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                        inline_count.bb_count, inline_count.insn_count);
-    } else {
-        g_ptr_array_foreach(counts, (GFunc) gen_one_cpu_report, report);
+    for (int i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        CPUCount *count = qemu_plugin_scoreboard_find(counts, i);
+        gen_one_cpu_report(count, report, i);
     }
+    g_string_append_printf(report, "Total: "
+                           "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                           qemu_plugin_u64_sum(bb_count),
+                           qemu_plugin_u64_sum(insn_count));
     qemu_plugin_outs(report->str);
+    qemu_plugin_scoreboard_free(counts);
 }
 
 static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 {
-    CPUCount *count = g_ptr_array_index(counts, cpu_index);
+    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
-    gen_one_cpu_report(count, report);
+    gen_one_cpu_report(count, report, cpu_index);
 
     if (report->len > 0) {
         g_string_prepend(report, "Idling ");
@@ -69,14 +70,11 @@ static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
-    CPUCount *count = max_cpus ?
-        g_ptr_array_index(counts, cpu_index) : &inline_count;
+    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
 
     uintptr_t n_insns = (uintptr_t)udata;
-    g_mutex_lock(&count->lock);
     count->insn_count += n_insns;
     count->bb_count++;
-    g_mutex_unlock(&count->lock);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -84,11 +82,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.bb_count, 1);
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.insn_count,
-                                                 n_insns);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, n_insns);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
@@ -121,18 +118,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
-    if (info->system_emulation && !do_inline) {
-        max_cpus = info->system.max_vcpus;
-        counts = g_ptr_array_new();
-        for (i = 0; i < max_cpus; i++) {
-            CPUCount *count = g_new0(CPUCount, 1);
-            g_mutex_init(&count->lock);
-            count->index = i;
-            g_ptr_array_add(counts, count);
-        }
-    } else if (!do_inline) {
-        g_mutex_init(&inline_count.lock);
-    }
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    bb_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, bb_count);
+    insn_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, insn_count);
 
     if (idle_report) {
         qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
-- 
2.43.0


