Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586FCC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfYvV-0002n7-K4; Thu, 29 Feb 2024 00:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYvR-0002mY-JR
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:25:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYvP-0005yR-Nk
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:25:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d6f1f17e5so321037f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709184342; x=1709789142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mdlljGjjXpWyYuEwsIaeI9gGRtfmPnU4W1OBz5Lh8Y=;
 b=YAiOnZjq6Suxdka9ppBUMAG7hE12ow9iaWWdTPpc+pVPJx1vmyt+R+xVSnR12kbMOq
 TXk6L1yjxsG/v/Riifawytxgb8tHFnScnw7qdcvL2YygRdEjhNFcVBVHB+fZGI/h/lxW
 Fje9ya8m8nAymjcKBqfqdPppQ8JYT1wHR091EXB2mNZ0FLUYC9PoU5iIc8wi8hXiVtjC
 G5UxXx6bw4zePFzEbu5H8QFAt7ccuV0q5tc28XywzGAzopHl3FGyRxw5g2SsbAtibH3D
 N8c6oL1Q8qHU9+d9UDeBp8q6rQtMrfPzHP8OeV95RzkPKfTp9m42BCgwkFRYUPQ7JLf/
 hwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709184342; x=1709789142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mdlljGjjXpWyYuEwsIaeI9gGRtfmPnU4W1OBz5Lh8Y=;
 b=ErpkHohBK0D22UbXoHysiDkZHp/8PvjvN6Y83u6LTgozDvL6lsfKqQ4LvVzOz67Zvg
 d9K9lq1Vij/pQdjsFr0sG80VCi3XCI9KB2cKFwuYrHQTU7CdWYF3MDBau7EbLPC/KhUg
 wihMcJkIWwfw1uN76PlONTowrHwodsfzg/GCkx/KdHI31YUz24BjD2XfhAaQbniWoDv/
 vBnWDeEK3F7Z4dTZMIl2w7ECD5hP9RWFkX0FCFl0YoUCDQHVwKfqdiBUDo6jW24duflN
 PjVNiryOGRUlokX+V9h+BmYz8+Y3cloSQwOgn9m2Xnil3UdkUmmtCAlZoIZAhRUy41D0
 E5Xg==
X-Gm-Message-State: AOJu0YxMaxJ7eDZxEcrAue6etjXcJZiR877pA4MVdIgxA8mopoqv/stv
 W09smdnUWlKQ7+rKBplfwhLtDBEMydtO0ETl8zYObFKGcauoNBYU7JJNNqYBFXRJ/q2dmEDj3gJ
 nvMw=
X-Google-Smtp-Source: AGHT+IF+zUHb7AT9Eqy2aqBPm7Obowug+fZ3WzH18bK7Yicbtw1LDQSmbJBsVZ7wcrqpaKrRTQ9AAw==
X-Received: by 2002:a5d:53d2:0:b0:33d:26b1:c460 with SMTP id
 a18-20020a5d53d2000000b0033d26b1c460mr506434wrw.39.1709184342122; 
 Wed, 28 Feb 2024 21:25:42 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 e14-20020adffc4e000000b0033dfa7ecd33sm660241wrs.61.2024.02.28.21.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:25:41 -0800 (PST)
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
Subject: [PATCH v6 07/12] tests/plugin/insn: migrate to new per_vcpu API
Date: Thu, 29 Feb 2024 09:25:01 +0400
Message-ID: <20240229052506.933222-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
References: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
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

Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/insn.c | 106 +++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 56 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 54da06fcf26..5e0aa03223e 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -16,25 +16,21 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-#define MAX_CPUS 8 /* lets not go nuts */
-
-typedef struct {
-    uint64_t insn_count;
-} InstructionCount;
-
-static InstructionCount counts[MAX_CPUS];
-static uint64_t inline_insn_count;
+static qemu_plugin_u64 insn_count;
 
 static bool do_inline;
 static bool do_size;
 static GArray *sizes;
 
+typedef struct {
+    uint64_t hits;
+    uint64_t last_hit;
+    uint64_t total_delta;
+} MatchCount;
+
 typedef struct {
     char *match_string;
-    uint64_t hits[MAX_CPUS];
-    uint64_t last_hit[MAX_CPUS];
-    uint64_t total_delta[MAX_CPUS];
-    GPtrArray *history[MAX_CPUS];
+    struct qemu_plugin_scoreboard *counts; /* MatchCount */
 } Match;
 
 static GArray *matches;
@@ -67,41 +63,40 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
-    unsigned int i = cpu_index % MAX_CPUS;
-    InstructionCount *c = &counts[i];
-
-    c->insn_count++;
+    qemu_plugin_u64_add(insn_count, cpu_index, 1);
 }
 
 static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
 {
-    unsigned int i = cpu_index % MAX_CPUS;
     Instruction *insn = (Instruction *) udata;
-    Match *match = insn->match;
+    Match *insn_match = insn->match;
+    MatchCount *match = qemu_plugin_scoreboard_find(insn_match->counts,
+                                                    cpu_index);
+
     g_autoptr(GString) ts = g_string_new("");
 
     insn->hits++;
     g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
                            insn->vaddr, insn->disas, insn->hits);
 
-    uint64_t icount = counts[i].insn_count;
-    uint64_t delta = icount - match->last_hit[i];
+    uint64_t icount = qemu_plugin_u64_get(insn_count, cpu_index);
+    uint64_t delta = icount - match->last_hit;
 
-    match->hits[i]++;
-    match->total_delta[i] += delta;
+    match->hits++;
+    match->total_delta += delta;
 
     g_string_append_printf(ts,
-                           ", %"PRId64" match hits, "
-                           "Δ+%"PRId64 " since last match,"
+                           " , cpu %u,"
+                           " %"PRId64" match hits,"
+                           " Δ+%"PRId64 " since last match,"
                            " %"PRId64 " avg insns/match\n",
-                           match->hits[i], delta,
-                           match->total_delta[i] / match->hits[i]);
+                           cpu_index,
+                           match->hits, delta,
+                           match->total_delta / match->hits);
 
-    match->last_hit[i] = icount;
+    match->last_hit = icount;
 
     qemu_plugin_outs(ts->str);
-
-    g_ptr_array_add(match->history[i], insn);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -113,8 +108,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_insn_exec_inline(
-                insn, QEMU_PLUGIN_INLINE_ADD_U64, &inline_insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
             uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
@@ -136,10 +131,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          * information about the instruction which we also need to
          * save if there is a hit.
          */
-        if (matches) {
+        if (matches->len) {
             char *insn_disas = qemu_plugin_insn_disas(insn);
-            int j;
-            for (j = 0; j < matches->len; j++) {
+            for (int j = 0; j < matches->len; j++) {
                 Match *m = &g_array_index(matches, Match, j);
                 if (g_str_has_prefix(insn_disas, m->match_string)) {
                     Instruction *rec = g_new0(Instruction, 1);
@@ -169,36 +163,33 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                        "len %d bytes: %ld insns\n", i, *cnt);
             }
         }
-    } else if (do_inline) {
-        g_string_append_printf(out, "insns: %" PRIu64 "\n", inline_insn_count);
     } else {
-        uint64_t total_insns = 0;
-        for (i = 0; i < MAX_CPUS; i++) {
-            InstructionCount *c = &counts[i];
-            if (c->insn_count) {
-                g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
-                                       i, c->insn_count);
-                total_insns += c->insn_count;
-            }
+        for (i = 0; i < qemu_plugin_num_vcpus(); i++) {
+            g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
+                                   i, qemu_plugin_u64_get(insn_count, i));
         }
         g_string_append_printf(out, "total insns: %" PRIu64 "\n",
-                               total_insns);
+                               qemu_plugin_u64_sum(insn_count));
     }
     qemu_plugin_outs(out->str);
+
+    qemu_plugin_scoreboard_free(insn_count.score);
+    for (i = 0; i < matches->len; ++i) {
+        Match *m = &g_array_index(matches, Match, i);
+        g_free(m->match_string);
+        qemu_plugin_scoreboard_free(m->counts);
+    }
+    g_array_free(matches, TRUE);
+    g_array_free(sizes, TRUE);
 }
 
 
 /* Add a match to the array of matches */
 static void parse_match(char *match)
 {
-    Match new_match = { .match_string = match };
-    int i;
-    for (i = 0; i < MAX_CPUS; i++) {
-        new_match.history[i] = g_ptr_array_new();
-    }
-    if (!matches) {
-        matches = g_array_new(false, true, sizeof(Match));
-    }
+    Match new_match = {
+        .match_string = g_strdup(match),
+        .counts = qemu_plugin_scoreboard_new(sizeof(MatchCount)) };
     g_array_append_val(matches, new_match);
 }
 
@@ -206,6 +197,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    matches = g_array_new(false, true, sizeof(Match));
+    /* null terminated so 0 is not a special case */
+    sizes = g_array_new(true, true, sizeof(unsigned long));
+
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
@@ -227,9 +222,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
-    if (do_size) {
-        sizes = g_array_new(true, true, sizeof(unsigned long));
-    }
+    insn_count = qemu_plugin_scoreboard_u64(
+        qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
     /* Register init, translation block and exit callbacks */
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
-- 
2.43.0


