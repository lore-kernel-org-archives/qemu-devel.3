Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B7C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHiO-0005eo-8V; Tue, 06 Feb 2024 04:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhv-0005Hy-Uh
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhp-00051M-2M
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:32 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40fe2d3d5cbso3073735e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211520; x=1707816320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwJ8e6wUH7fqyic9sqG77ZVCFxcpo7vgFJo8+jFAkz0=;
 b=YRGmORrTHiLOENx0aCM7WPMQr0BoL+VC7H4YW1RfTyufQK51XxtIjNFhlJgG5Can7/
 KM2www3oAoPux+qlfwoTKpn0fLlBYaonfq1q3XKd26jtBMSI2C8bCp69AOC13nhIXLFp
 vXa0dAO2hh57IaVPJHTZN6VuX0dwU0/FUc7gHMxTQfkwBbfEOKGZIxRA7qtsMR7CCMZ8
 Pj/66l7jV/N8+k/4/V+GS5mdSBwSEwfs0AaKK9NBdhB6xcx0jEzxRMK1Susv1bmB7Ba+
 xZUzwpGUxUP0oNvIC6J4wmC9tVyfP29nrjn3rqv2dSXbyUmZMn9H/WC6zuXF/G6LZ+aj
 BgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211520; x=1707816320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwJ8e6wUH7fqyic9sqG77ZVCFxcpo7vgFJo8+jFAkz0=;
 b=ruJ63beozt51y4wRBF9HzAakTsgtArknk3dvqP9u8J0R0MT60bUBqlvzEW8jPteHtk
 dHBBttumogs41Lc2vSfig1wi/gn2EFzwEWE8N4Wjz0J9UILL1+z9W3An3+1zmOJL4hfz
 HoCZ52J1qlJAoRGVmmvbuFxamycURkPoja0zTl3HZkAFLskziNxv1BCDFoN7Cv6zNt+L
 NNxap+OLhdsaicFrQVFSQddOBo9/ygFPkd7TPVZuyN7fXafPg4uvkKkcw3nt9mEFov2l
 sY0zdUZIDH4uGzUqyznHUbG0+fjdRMqA8xmldvcbU/ByBkqw2TE6V+s35SjvbsFGc7hJ
 URwA==
X-Gm-Message-State: AOJu0YxaNIfo3qgrn9Tlnz672gmpmIObJHdXhEtU3166D5OLvJMvbPoS
 MN5dqg+JXFG+LLhSEAmV46KoLE4X5YXDSNybO/XntKLg4jAu6Ac4yjnMLyDv/6/TaqhBjjRXIoR
 wM6c=
X-Google-Smtp-Source: AGHT+IFcCTk2RM2qW3ihoEvPNsFYwZPdMl2MkvdVmbrQ6DNu5NgkrdJO+Lp8Co3uvK24JnRNMskbNw==
X-Received: by 2002:a05:600c:5491:b0:40f:c5cc:e756 with SMTP id
 iv17-20020a05600c549100b0040fc5cce756mr1632415wmb.32.1707211519787; 
 Tue, 06 Feb 2024 01:25:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUYNq+56G9LiYdkKWk5PJs0ecb2uMS0vMn7bCVZoG3bPbuqG77fe6Q2elGy2QGGCKxoz+uFizB3mG9zibVa/3J2otP3ay01XWLkIH19XNWZxpDda8Sacl+DkN1EDVcxvHm7No33rci0V5M3a9O0k+0bhxgIreA0YPwAHid4lXvCQNhs/Hd3YitNipOie49BfkmqR4eAi5vr3wzSSQ/ybBali/4zl/Fej+oZZpSGkF0XMumJN9YfnFPXI6H2uN7kT/gHWcf5ljRQ6bhjbLKTaeInUHo6SVqjwQN7YElThFugFzg1HmEl/47pt19euMxq4x/6mZYxp1zWD5gwi/LDGblQeKegfKLkYg==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:25:19 -0800 (PST)
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
Subject: [PATCH v3 13/17] contrib/plugins/hotblocks: migrate to new per_vcpu
 API
Date: Tue,  6 Feb 2024 13:24:18 +0400
Message-ID: <20240206092423.3005995-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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


