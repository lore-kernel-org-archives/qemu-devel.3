Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDECC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpIV-0002Uw-UE; Tue, 13 Feb 2024 04:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpIG-0001jK-LF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpI6-0000Ih-Vd
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:35 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33cddf4b4b5so139884f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817284; x=1708422084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLrDeSzxAfz0BkmoOA2bd0HrCpMytbURUXRn/P+Vjdc=;
 b=jpzXerFUIBX/1Bnt29k5zb7z5C+C+qvQU/BYQXRPvnhOzQQTCcw7cYdo68KfDqsETS
 /zUphpkdvfGQgYgin8K9qnjLeq6nWyoGnct5LU0D55ggz8fokW9kvXDokr7dcs445N/N
 plAvrWwAmbxYiodS4ODqwpCjikL3L7XNkIqtOc7E3KgouZPnrrA7kEOSJ5uhuiBMSSyy
 UdAQn1UcsPVm7ziKc/Hn9MyXDiZ3S53/CrM2H19ybVGo7AXQLk32rlSu9dWyc8HizLo0
 xW+PmJMdkKTyekyOmAa1A3e5c59wJWQAAxuEV/iyuBVNNfJiaKKiMsfojEUIyjjte59X
 lhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817284; x=1708422084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLrDeSzxAfz0BkmoOA2bd0HrCpMytbURUXRn/P+Vjdc=;
 b=iZtuj0ziyRqqgaoXTo3yM5bXwQD2ZexjxKCecbx2lCSL/Bi8DUiQICw4KFUNnLszJ9
 +RcZu/cUgGyrHVVCUVmtg9ueeGF5OQFhnmbco+MQY7rgQUk/Kau9lfxhYwWqv/DW/U5X
 xjRh9xFTl0IHo329isE7FwVJDhA2EpwiFrHjHg2Kgr85GbAr8sJRoo3orIftjQQ/5XPD
 w0teb+RpHyhH06tQxDhb/Cg2Y1y9FirYsgBQDNWN+3cq6yM+KkluWvSGcQV8DBToMyDA
 SVtV35rb/YFY7j7yWGYyEYk7R0jNNaTKLNnWaXKm/RTo/Sim3fh0GJjcPSai+KOvuEWk
 5V5A==
X-Gm-Message-State: AOJu0Yy1Q8ZP76o4jmhk3TqpwHKNgQX0QW2/jmSETqbXHye2yH5/ZI2K
 tavsiCcPzVboVWpTv1UIOQkzDR5nEZUvsnGINv4kvwK+ePfcI/foULOqvEnEnto9Z027NuCxqyL
 5
X-Google-Smtp-Source: AGHT+IHKqRw64J9Egk1apaQ6QcyAB7/VPYtoJ+P3fE8DIMOeCbVz5o82ex9Q51tyOmLcKvtUcf7k6w==
X-Received: by 2002:adf:ee8e:0:b0:33b:2e44:6dc8 with SMTP id
 b14-20020adfee8e000000b0033b2e446dc8mr8500549wro.25.1707817283778; 
 Tue, 13 Feb 2024 01:41:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXY2S2RCcFV8HJLYUHATIpyQA6R1I/nB2lpVITmPyUoJVUhLq5MqP10WwB28DzD1F+1QW1iB9ibNx5CuSGqQ7WjFXmn/WXXvuDJyvvC//F45nFUoqzosCUmOXh8QuFd5RVujSYvEOmsn+SEYSvTa/TNsStBI4svFjVBoaDITVFg7As2k2CuOlW4AnYg+281ZbxIyYX/a6Yc2MBl3mdT0ZV3CoQVQIMEUM+w3hUyETyZKQJ9ugifeqggvRfAwXw/S5UaT7r3x7RhZk2iBJqe9mFlXZCepp8KjiyZPs6MYGQAPBtdWNIHGH6qsS3P3Ge4AJTJqaIJvvkNs01R1q94sxdVPSeeRw==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:23 -0800 (PST)
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
Subject: [PATCH v4 15/18] contrib/plugins/howvec: migrate to new per_vcpu API
Date: Tue, 13 Feb 2024 13:40:05 +0400
Message-ID: <20240213094009.150349-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x436.google.com
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
 contrib/plugins/howvec.c | 53 ++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 644a7856bb2..2d10c87e0fb 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -43,13 +43,13 @@ typedef struct {
     uint32_t mask;
     uint32_t pattern;
     CountType what;
-    uint64_t count;
+    qemu_plugin_u64 count;
 } InsnClassExecCount;
 
 typedef struct {
     char *insn;
     uint32_t opcode;
-    uint64_t count;
+    qemu_plugin_u64 count;
     InsnClassExecCount *class;
 } InsnExecCount;
 
@@ -159,7 +159,9 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 {
     InsnExecCount *ea = (InsnExecCount *) a;
     InsnExecCount *eb = (InsnExecCount *) b;
-    return ea->count > eb->count ? -1 : 1;
+    uint64_t count_a = qemu_plugin_u64_sum(ea->count);
+    uint64_t count_b = qemu_plugin_u64_sum(eb->count);
+    return count_a > count_b ? -1 : 1;
 }
 
 static void free_record(gpointer data)
@@ -167,12 +169,14 @@ static void free_record(gpointer data)
     InsnExecCount *rec = (InsnExecCount *) data;
     g_free(rec->insn);
     g_free(rec);
+    qemu_plugin_scoreboard_free(rec->count.score);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("Instruction Classes:\n");
     int i;
+    uint64_t total_count;
     GList *counts;
     InsnClassExecCount *class = NULL;
 
@@ -180,11 +184,12 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         class = &class_table[i];
         switch (class->what) {
         case COUNT_CLASS:
-            if (class->count || verbose) {
+            total_count = qemu_plugin_u64_sum(class->count);
+            if (total_count || verbose) {
                 g_string_append_printf(report,
                                        "Class: %-24s\t(%" PRId64 " hits)\n",
                                        class->class,
-                                       class->count);
+                                       total_count);
             }
             break;
         case COUNT_INDIVIDUAL:
@@ -212,7 +217,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                    "Instr: %-24s\t(%" PRId64 " hits)"
                                    "\t(op=0x%08x/%s)\n",
                                    rec->insn,
-                                   rec->count,
+                                   qemu_plugin_u64_sum(rec->count),
                                    rec->opcode,
                                    rec->class ?
                                    rec->class->class : "un-categorised");
@@ -221,6 +226,12 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     }
 
     g_hash_table_destroy(insns);
+    for (i = 0; i < ARRAY_SIZE(class_tables); i++) {
+        for (int j = 0; j < class_tables[i].table_sz; ++j) {
+            qemu_plugin_scoreboard_free(class_tables[i].table[j].count.score);
+        }
+    }
+
 
     qemu_plugin_outs(report->str);
 }
@@ -232,11 +243,12 @@ static void plugin_init(void)
 
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
-    uint64_t *count = (uint64_t *) udata;
-    (*count)++;
+    struct qemu_plugin_scoreboard *score = udata;
+    qemu_plugin_u64_add(qemu_plugin_scoreboard_u64(score), cpu_index, 1);
 }
 
-static uint64_t *find_counter(struct qemu_plugin_insn *insn)
+static struct qemu_plugin_scoreboard *find_counter(
+    struct qemu_plugin_insn *insn)
 {
     int i;
     uint64_t *cnt = NULL;
@@ -265,7 +277,7 @@ static uint64_t *find_counter(struct qemu_plugin_insn *insn)
     case COUNT_NONE:
         return NULL;
     case COUNT_CLASS:
-        return &class->count;
+        return class->count.score;
     case COUNT_INDIVIDUAL:
     {
         InsnExecCount *icount;
@@ -279,13 +291,16 @@ static uint64_t *find_counter(struct qemu_plugin_insn *insn)
             icount->opcode = opcode;
             icount->insn = qemu_plugin_insn_disas(insn);
             icount->class = class;
+            struct qemu_plugin_scoreboard *score =
+                qemu_plugin_scoreboard_new(sizeof(uint64_t));
+            icount->count = qemu_plugin_scoreboard_u64(score);
 
             g_hash_table_insert(insns, GUINT_TO_POINTER(opcode),
                                 (gpointer) icount);
         }
         g_mutex_unlock(&lock);
 
-        return &icount->count;
+        return icount->count.score;
     }
     default:
         g_assert_not_reached();
@@ -300,14 +315,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     size_t i;
 
     for (i = 0; i < n; i++) {
-        uint64_t *cnt;
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        cnt = find_counter(insn);
+        struct qemu_plugin_scoreboard *cnt = find_counter(insn);
 
         if (cnt) {
             if (do_inline) {
-                qemu_plugin_register_vcpu_insn_exec_inline(
-                    insn, QEMU_PLUGIN_INLINE_ADD_U64, cnt, 1);
+                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                    insn, QEMU_PLUGIN_INLINE_ADD_U64,
+                    qemu_plugin_scoreboard_u64(cnt), 1);
             } else {
                 qemu_plugin_register_vcpu_insn_exec_cb(
                     insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, cnt);
@@ -322,6 +337,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 {
     int i;
 
+    for (i = 0; i < ARRAY_SIZE(class_tables); i++) {
+        for (int j = 0; j < class_tables[i].table_sz; ++j) {
+            struct qemu_plugin_scoreboard *score =
+                qemu_plugin_scoreboard_new(sizeof(uint64_t));
+            class_tables[i].table[j].count = qemu_plugin_scoreboard_u64(score);
+        }
+    }
+
     /* Select a class table appropriate to the guest architecture */
     for (i = 0; i < ARRAY_SIZE(class_tables); i++) {
         ClassSelector *entry = &class_tables[i];
-- 
2.43.0


