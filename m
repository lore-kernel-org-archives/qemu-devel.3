Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BE2C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpIG-0001jM-L6; Tue, 13 Feb 2024 04:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpIE-0001fd-Mf
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:34 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHz-0000Gy-6N
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:34 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33cdd1d732dso226206f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817277; x=1708422077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpn7ZrX++QOMXIPnhSOuAzbdhuGwGNkpxbx03u36x+U=;
 b=UzZ4kuJFQYlhQIoCIN9V83nvS6aOcalgjdDTplW6+YKrlJvkTje9EgT4sn5phzX8VE
 ac1ozRBrpjqAkzxNjOGQzcmbisww1L5bHYtu472RpE2DaTBfZvR3nbziPkUBiypUefJV
 vXC/L3d8zRGx0YyXLsQpEHZIOodVp91LflpC74yqotDSaN6SwTJSzQp2YRRV4SXEJp52
 7V8oVG/2pQqBqdIGuGU65itR2mb3XhuWaTeGyYC36XBlGacSeyHp3LZhMbDd+EHE/ht+
 9w5jEwayRW4oawfGN0JIY2n52diCN8VCZg+NFwb5oXndk9kWnvSK5YFmRxh5YnxvyDru
 MXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817277; x=1708422077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpn7ZrX++QOMXIPnhSOuAzbdhuGwGNkpxbx03u36x+U=;
 b=ESw9K3ayd2XQs2yGPT/XsNzwpEGQLSuONrmTMiOTVtaRuIPqO8u0c/ZAfFzT/E0q0i
 gnficOjN8x/ymtzRJjc+YMZJNWE3NaKDyAjzY9cKR3NMkwgm8bwep8nYj4aBLvYqiuhd
 2TdqkR3+9LgZOaOurYGa8iESRx00x9s4+3FjqLq3R7uxOqLFD8tJycIuv4uWSuelH61x
 Zjv/+9x1ThAFJ5LNke263dTpHvOoJ0AFNrOFlkWo12GgdRB2nqqKLAUz8L/2CmEb1kGp
 H9d683okeF9rrudkRSOB0qHrjA3db9LC5Yh3xTXSVCgstYihf7VomW8EI16HY+OlxhvX
 DsKw==
X-Gm-Message-State: AOJu0YyDEHaiUzmAjeq0Z3zqVu+3NKkj176b1JXH4tsiDSYAvomzKgTz
 VAnJBexiPWHUJy4Gb/Zm1BAyS3yjly5/KlHRjjvKC8L2QJhdrJ/sp8QtdYnespbbAJcjss8eemW
 W
X-Google-Smtp-Source: AGHT+IHPCfmzje2mbO3ZdxS70hIhSTXUAAkUzkPi5hedrwmfXT2FZ0fLdw8DAYMpgog50e/vl5cX6g==
X-Received: by 2002:adf:f245:0:b0:33b:4908:9bbc with SMTP id
 b5-20020adff245000000b0033b49089bbcmr8235584wrp.40.1707817276833; 
 Tue, 13 Feb 2024 01:41:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXdsVz76ZbRWZUdS2RPjmqjygpveiHNswiu9r1TPuz1jbRP4+0cD3o1eMztLeM7as6ZI/u3B2ECO5HNEI55o9eK1/UC5jTaIjIBlJjE+8RSAHfIFGPof4x6EZAOAnmNOLJYm4D5z01pKgIshHHYPXMGNAcVQbgs1SI5QTaqfk13N8zTsofwf/yAVukWL9Nn2IEAU+oluFwROqSjzeR6AX5qzVqjXimmDgQpyiIDVlrIqiTMCBYCanbDt4lN5qYe2RvK2yJjKXSqJIkNLIDNeb8gg82YSqUr+/ALDv5gZDsb3jIlWIDSUv0xmOu41Z/b37/UzKk7f+YkWI8BKFkPesv0CqboWQ==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 13/18] tests/plugin/bb: migrate to new per_vcpu API
Date: Tue, 13 Feb 2024 13:40:03 +0400
Message-ID: <20240213094009.150349-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


