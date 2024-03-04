Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51956C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7xH-0002lA-Jk; Mon, 04 Mar 2024 08:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7xA-0002Ew-4o
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:02:03 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7x4-0000rB-DA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:56 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-566adfeced4so4561989a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557311; x=1710162111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2IiUkHopV2kqQ50xbiRbR5fNcCFrzYMY0qVpPsgzH8=;
 b=wEshOLytLsF/L4rWlQz8PTn+S4mo6DhN7PNpxCGhFUb5ZUlsnN4tI4LadHzLx5p8/s
 +UR9UULJfhy7CFLGiiW7FWdwJMNEiZr/yzPva6NlYBtlLfymLNolwa1uFJdxKlmMkJ9P
 BRAkMcPBFEIcWxV53UU8NAbqq7tzZCQ98RHgSGzUX7EhRK6JjOaEDJD9mpjmIHy4nMaS
 9l1w3AmCZYE/leW9RYwavAGVfIVhu6dKSymLyIluJYR/39lAs3xSs0WZtVW2VHUSuyz/
 yy7MalRcl+y5sZXpDuXGUSoTkOAGnOPee2z2VnnNV8R6VRqK3c6T4OCl6LISI20cPBKI
 SRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557311; x=1710162111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2IiUkHopV2kqQ50xbiRbR5fNcCFrzYMY0qVpPsgzH8=;
 b=oTtMhtq6ARIxollxaYEf2SoCBM1ESX25wYWYfhnt/s9bkCnxYx5Uf7Fb0VM1fnwTYh
 +tqToSkTwiT+zV6TwCWIUjqK8p0K9TGt8cJz/8uX85LBbUnKI7bXjaI4RU8V7ljIXoiJ
 MAS9Ir/EzkJ1GNmiSngwUmnDP67Uxn6YYayHEcyFLkgnP1SmsYNJJAnsbYMqNifxVJyk
 Brb3X4M1v7xrUP0Ga8QnIkjyTOXwtGqFopmG2RWuOU4NE3uv+Rg+oYacCA3sJXmSXfTA
 ISpIsqmSf7TAVx7WcB8/0TI56yYqZd6AqRNbs0ypsC+wj+34QyleIJm7vStskAZ4UMCc
 VvkQ==
X-Gm-Message-State: AOJu0Yx0xmB7gn4najx7OfPWJkE8a4z2vUzwZSGO8e0SS7BTo6HikDuH
 lbgv5ZzLVT/9XdrSdY6Nxg070kmU6nW45PB2lC4aqOumevSGGuaWsipz/AyEoFEFpc5clqCbBJj
 uc3w=
X-Google-Smtp-Source: AGHT+IF46DLwNntfxR6YkGnZo3Gc4+nj5fSveH603eo+uoO/UZYsZ3WwdRqbdAss2krRjTU+EJCitw==
X-Received: by 2002:a17:906:ae55:b0:a44:4a94:a6d5 with SMTP id
 lf21-20020a170906ae5500b00a444a94a6d5mr5008138ejb.27.1709557311061; 
 Mon, 04 Mar 2024 05:01:51 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:01:50 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 10/12] contrib/plugins/howvec: migrate to new per_vcpu API
Date: Mon,  4 Mar 2024 17:00:34 +0400
Message-Id: <20240304130036.124418-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x52c.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.2


