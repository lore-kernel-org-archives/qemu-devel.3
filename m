Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F88E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDA-0005Mb-OW; Tue, 17 Dec 2024 17:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD9-0005LO-1o
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:39 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD7-0008Qv-4V
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:38 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2163dc5155fso51077075ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475116; x=1735079916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+nQuV745MSVduGtVwWvyxFW8ma4a2v2SK14uCf1mjQ=;
 b=kPPHoLCR0u8ugTSQQMdt+HX83bUSVPMirb0nDnCxeMU2fWAapZYmF3OCkIcev/OVYr
 LlT4pC7CSnUEDhLztLEj+oZLo8dCowuGh+IHrvTvG7OZSUU3JtuHYOT10hPCp/283Y8V
 QQl3d/Pjf6OcNFJvzkZA0RUC6eKlCn+9rWjsWLQt8zJNNWf3LK2SOm0KDzHXXmFaTAHb
 /Aemvthn3byEGu+gfJZgHGa2qShIODSXMtc+LlmJKK9lwl9ee5KXVv8nL+hOdOUNDbWz
 icaIKWDj/WEFukpwVOw8EzXHHUlEn/qApNhI1gZuL2va9pWurHacc9WxhwWIRAFMGf9C
 FFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475116; x=1735079916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+nQuV745MSVduGtVwWvyxFW8ma4a2v2SK14uCf1mjQ=;
 b=B2eRqdCLaOoDkQ/jE1fFPrlDsk8D9XlgMiVTpeJogwye/sC7PmBrWPQZ7tuQZt7uM1
 9jv/ivlYiVz0iq1JVs/aXuo8BWI1QgIf78FLFcW0G//LWMedwEtf9lCxTHWA3e1lKGIV
 0tZiAj2wnu2xLaZHIJDvw1eGs8MsDVx0HAooKx42DZDezadUJ9wyc2RDebb7kA/3E1Qm
 6ewd7ZQ+YZR+JdSfQm2FiRyVl2QYNptWVC53za/moX9g5fsqG0afdvWHnUadbGEftMY2
 2HIF1afcdQN7SnUSO7V+vBvvX8wLOPjjZeVQxBErdN/AJHzysYHH0GWVKoReY8vf9GlQ
 aZWg==
X-Gm-Message-State: AOJu0Yz9Nrkqr5QgEO7oZesYDMjwfPNZwf6icDfJv5u85UCUIFO4/Ucw
 OCSvWnjSyLXgZwJebwg+o8U3VkWjxlYAcCl71GQH2jrbCz8IGpsceqZe+vKgcHH8BBjwJrm6pZw
 9+xw=
X-Gm-Gg: ASbGncvgqbR2rh14DK9p2Wl9gfdHrmPPl656hC1xZ5MWCSjNsPAcYrxiKLdyqQ27F1b
 uzHGu/om/5wPCKEgyZ6zbhdrq9mfB6LHuLloodRmk31MBVgrk2cTkilJ+BsNRJvAw2JdRJlvoYo
 27xk0wNVNWULdxTSeYDan9ODjhzZ2cAABCyjclLiyCvDVpXziJWcDhdseyvecrJVuQxv7JI50EA
 bQQDa++zlZXW6SpKzgZLjYkzhIxMmJ3ut+oFov8tVFK0ySYT89xq168
X-Google-Smtp-Source: AGHT+IEonfW9NN4+0M3sn5pW8TzroOG1jJxWHp+/uqduWDAQ7D2cwcMiHffkI2MN6IoEvKBGV/zxAw==
X-Received: by 2002:a17:902:d2cc:b0:215:b8b6:d2ea with SMTP id
 d9443c01a7336-218d6fe4940mr5700635ad.15.1734475115897; 
 Tue, 17 Dec 2024 14:38:35 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:35 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 06/11] contrib/plugins/cache: fix 32-bit build
Date: Tue, 17 Dec 2024 14:38:20 -0800
Message-Id: <20241217223825.2895749-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/cache.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 512ef6776b7..7baff868609 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -208,7 +208,7 @@ static int fifo_get_first_block(Cache *cache, int set)
 static void fifo_update_on_miss(Cache *cache, int set, int blk_idx)
 {
     GQueue *q = cache->sets[set].fifo_queue;
-    g_queue_push_head(q, GINT_TO_POINTER(blk_idx));
+    g_queue_push_head(q, (gpointer)(intptr_t) blk_idx);
 }
 
 static void fifo_destroy(Cache *cache)
@@ -471,13 +471,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     n_insns = qemu_plugin_tb_n_insns(tb);
     for (i = 0; i < n_insns; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        uint64_t effective_addr;
-
-        if (sys) {
-            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
-        } else {
-            effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
-        }
+        uint64_t effective_addr = sys ? (uintptr_t) qemu_plugin_insn_haddr(insn) :
+                                        qemu_plugin_insn_vaddr(insn);
 
         /*
          * Instructions might get translated multiple times, we do not create
@@ -485,14 +480,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          * entry from the hash table and register it for the callback again.
          */
         g_mutex_lock(&hashtable_lock);
-        data = g_hash_table_lookup(miss_ht, GUINT_TO_POINTER(effective_addr));
+        data = g_hash_table_lookup(miss_ht, &effective_addr);
         if (data == NULL) {
             data = g_new0(InsnData, 1);
             data->disas_str = qemu_plugin_insn_disas(insn);
             data->symbol = qemu_plugin_insn_symbol(insn);
             data->addr = effective_addr;
-            g_hash_table_insert(miss_ht, GUINT_TO_POINTER(effective_addr),
-                               (gpointer) data);
+            g_hash_table_insert(miss_ht, &data->addr, data);
         }
         g_mutex_unlock(&hashtable_lock);
 
@@ -853,7 +847,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
-    miss_ht = g_hash_table_new_full(NULL, g_direct_equal, NULL, insn_free);
+    miss_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, insn_free);
 
     return 0;
 }
-- 
2.39.5


