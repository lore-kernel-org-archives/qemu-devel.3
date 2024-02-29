Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD34C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfYvb-0002op-Tt; Thu, 29 Feb 2024 00:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYvZ-0002o9-VM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:25:53 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYvV-0005zR-0V
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:25:53 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33de6da5565so284511f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709184345; x=1709789145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppE1notIMZL45Hs6pC/NlspuyTzo8NjjnmHK5ZpYTNo=;
 b=AGcRFjWX6e5NrHfn7l8x6uLb7O4Fq3GdX5FehSsPlaMWF6SzBGGtK15L0mb5mwa9vf
 kaJmVqz2+nJq6rWQR2yI+b7ebbBE5gCC6SRjm0CqkAi7yZ7YZtUr+DPZHL4mgdB9oXrh
 NkbkHlYNJE9SAs5Sh/FAtH9ZoFU0yIa8SSpl602jvd/5lXDpFspymJX4tQe4z30jzGC2
 qma7gwCgWvl8JzABz6a59sZ5osn1zKdxL4/HDdv+jrEZ9xUMyfhsQUpozKp/TQW6NTCy
 9Uw1AKvQxq00CYdgkNOjOOvOPoRzCD7Of1gyl3EkRzIdbGrBOZm5dIEQqnw4YDiqITie
 5zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709184345; x=1709789145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppE1notIMZL45Hs6pC/NlspuyTzo8NjjnmHK5ZpYTNo=;
 b=jxSDHfQ2TTKqJmvC74WddScq6ifQGhx4uD/vr2iVUZX+QV8kq0Hc0hKddZz2dRU+/P
 CU8n1T8EuKr3T8hi8z79M8qKDr4706OBVpezzFuUQ7dKtk0e3TecEEMyOXOz8iQ8WC4q
 XAUvwj1ZmzjSYSKgacJt/wXPQkBV9aY1teTyUxwNU8VI4WYsi3PnBJw3XNGn/cpd8FaA
 tS7ZMuyCUm4SmyaDsxsMqnCE5jFl1/3uxuzcQRde+emApbZr4zW3VCUv0mZGycT4F6aO
 tA62zQaGf8EkkLH/U5jlUnYAH80HHWmGI2zlOG3HmViYXW2tqiaycr+93DO2Y7HX+H8K
 FYTg==
X-Gm-Message-State: AOJu0Yzf2rb7HY7kIUKwU6IYq03HV4Z8wPRkoEzgDo9tnHFlkJ6z37Z0
 5GUtfPhJ7Dy4KCzDZcJCReUXBCCzhCVb/ZJtTUhcRnSMlukAeCskQpfenmzk2wve6FJRr64B9XI
 KrSc=
X-Google-Smtp-Source: AGHT+IF/JTFGNOphkTjxuaXJmbyQTW1Y5pjbLcQfSt915ENO+pSRNlX126NWD06DcIEez6EVnQjITg==
X-Received: by 2002:a5d:4b8a:0:b0:33d:96c7:ae3d with SMTP id
 b10-20020a5d4b8a000000b0033d96c7ae3dmr503207wrt.16.1709184345745; 
 Wed, 28 Feb 2024 21:25:45 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 e14-20020adffc4e000000b0033dfa7ecd33sm660241wrs.61.2024.02.28.21.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:25:45 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v6 08/12] tests/plugin/bb: migrate to new per_vcpu API
Date: Thu, 29 Feb 2024 09:25:02 +0400
Message-ID: <20240229052506.933222-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
References: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x436.google.com
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

Reviewed-by: Luc Michel <luc.michel@amd.com>
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


