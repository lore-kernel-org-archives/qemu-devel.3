Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E5EC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX5L-0004W5-63; Mon, 26 Feb 2024 04:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX5I-0004UY-2h
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:40 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX5B-0005DP-Sz
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:38 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33dcd8dec88so654874f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938929; x=1709543729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwJ8e6wUH7fqyic9sqG77ZVCFxcpo7vgFJo8+jFAkz0=;
 b=cCw1Pwfud3hGF7uAydYs7LOsTS3aDpX0i52AGLlShFBhbT03nSFErBRjvD5r5v/QZC
 cajN/S0lzidbexwWA3yJ77haRhJhaDvmM1BY5nVZctUwMAX8LXM1h5kinKak9LQoEguj
 fLbTaDdHyxl6OqTZi7m4LPGmL8mmxSYSawGEKZqUjRqS/l8x/AaVWdUXGiDOvBvJBS0h
 tjL36otWM5W3LFmCoQv1/i/O4Zi0YhePY5VEl1+XHUyAddOleYm7Bq8E6bpitbkO2Z30
 oWaKjMXaBJ9nfJ62kMrB8UnwASTiZEpUsD9osumbJfCgZByptg4z2dD5VHLuITlQ+ACF
 cxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938929; x=1709543729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwJ8e6wUH7fqyic9sqG77ZVCFxcpo7vgFJo8+jFAkz0=;
 b=KkqtCF2GqhD8yesP+T0/SQbOiTTkUnkYMAGLcs+HYoY5BH7NmQJ7YRMjtIzL5fNuLF
 61T2fLaWfgf+aAso7blxKekOaJjpxHoxmcD0jAFWwG5Zx3sfFwTgAEseq7KH2D5Rq715
 x2yL8u2IyFizmvnYXpUbV/lbAmrvriwFK+AImUznQODwhRjzeS7f1tL9oOeI/D3bv6Fw
 /Kn+9K9IC2/WhXeUBn613fFiRFr/TWUj1KwUoSrAyyE4WANKZBotfByydcVDy8rUIrjb
 eQw/c4377sG8BseFM8aWlez8RyM/OwZHC1Nilb0AYwEwF+F4ML4d5Ow9Vzu0ljHdqCT/
 QXNQ==
X-Gm-Message-State: AOJu0Yzagtja7hOuxiRvsuhFYcDSgNuTC4B1RRuBD/NT6L0/SQwCz1FH
 JnvilhzT3Z8QKR8lbRAzCoWnLjE/wCEf3PjM+94RrnOxP9XtAuTCqsigJ+cSDp2gdomhlr3epXg
 PEHcFpA==
X-Google-Smtp-Source: AGHT+IGUQbnBj7V3S0Yv3MR/K1iQBtAOlV+k7jLXslKRYYJ950rWiutTjVHX9tQgB/ol7NKpPr82PA==
X-Received: by 2002:a05:6000:1243:b0:33d:b32a:8acb with SMTP id
 j3-20020a056000124300b0033db32a8acbmr4350659wrx.23.1708938929000; 
 Mon, 26 Feb 2024 01:15:29 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm7578814wrm.52.2024.02.26.01.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 01:15:28 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 09/12] contrib/plugins/hotblocks: migrate to new per_vcpu
 API
Date: Mon, 26 Feb 2024 13:14:41 +0400
Message-ID: <20240226091446.479436-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x429.google.com
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
 contrib/plugins/hotblocks.c | 50 ++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 4de1b134944..02bc5078bdd 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -34,8 +34,8 @@ static guint64 limit = 20;
  */
 typedef struct {
     uint64_t start_addr;
-    uint64_t exec_count;
-    int      trans_count;
+    struct qemu_plugin_scoreboard *exec_count;
+    int trans_count;
     unsigned long insns;
 } ExecCount;
 
@@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 {
     ExecCount *ea = (ExecCount *) a;
     ExecCount *eb = (ExecCount *) b;
-    return ea->exec_count > eb->exec_count ? -1 : 1;
+    uint64_t count_a =
+        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_count));
+    uint64_t count_b =
+        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_count));
+    return count_a > count_b ? -1 : 1;
+}
+
+static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
+{
+    ExecCount *cnt = value;
+    qemu_plugin_scoreboard_free(cnt->exec_count);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
@@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     GList *counts, *it;
     int i;
 
-    g_mutex_lock(&lock);
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
@@ -63,16 +72,21 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
-            g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-                                   rec->start_addr, rec->trans_count,
-                                   rec->insns, rec->exec_count);
+            g_string_append_printf(
+                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
+                rec->start_addr, rec->trans_count,
+                rec->insns,
+                qemu_plugin_u64_sum(
+                    qemu_plugin_scoreboard_u64(rec->exec_count)));
         }
 
         g_list_free(it);
     }
-    g_mutex_unlock(&lock);
 
     qemu_plugin_outs(report->str);
+
+    g_hash_table_foreach(hotblocks, exec_count_free, NULL);
+    g_hash_table_destroy(hotblocks);
 }
 
 static void plugin_init(void)
@@ -82,15 +96,9 @@ static void plugin_init(void)
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
-    ExecCount *cnt;
-    uint64_t hash = (uint64_t) udata;
-
-    g_mutex_lock(&lock);
-    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
-    /* should always succeed */
-    g_assert(cnt);
-    cnt->exec_count++;
-    g_mutex_unlock(&lock);
+    ExecCount *cnt = (ExecCount *)udata;
+    qemu_plugin_u64_add(qemu_plugin_scoreboard_u64(cnt->exec_count),
+                        cpu_index, 1);
 }
 
 /*
@@ -114,18 +122,20 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         cnt->start_addr = pc;
         cnt->trans_count = 1;
         cnt->insns = insns;
+        cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
         g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
     }
 
     g_mutex_unlock(&lock);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &cnt->exec_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64,
+            qemu_plugin_scoreboard_u64(cnt->exec_count), 1);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
-                                             (void *)hash);
+                                             (void *)cnt);
     }
 }
 
-- 
2.43.0


