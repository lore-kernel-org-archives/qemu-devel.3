Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EACC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdN-0001JR-Rf; Fri, 17 Jan 2025 08:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcy-00010u-7d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:12 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0002ES-TC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:11 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab34a170526so292284866b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121387; x=1737726187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtbti+nfIC33MIZ1eYW+qTFtToL57v/F5KN9R+uVCLw=;
 b=vu0SOSet9ldPkOTJU6GXws1FUpz0D37fktPafwMKpnqIxM7xyMtqTqzS8NSm4n/ObW
 +bQSSmC4+y3IJGYEXMNPNMeq/GKv05zaYv6iS+8IFxz+tdyda4RmpUj+22yyM6XjFa5v
 x/2qrBNsOSCTRX9hL7XACCoE8+fHvxq+3cs4GQ6o5fbkGxSYkU79JPTGd0I8yDCOrMxp
 BZhJ5u/tQCVSuXRT7zNrMoinlcCeVQ9/kZGGrMC49/26afoypj5KqiCNI0F1dB4Sig+8
 +H86Hrj/oXfc2n54NjMMRAh/UWDbjHpmsGOIBGIFaFT4bzbqwKrpAgEdK1YEZZhFBq1s
 IwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121387; x=1737726187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtbti+nfIC33MIZ1eYW+qTFtToL57v/F5KN9R+uVCLw=;
 b=SC2Gw6r4zh2uYMiZkw3cnVHrztQrRRGkI0yeLfzmZepSYcPTEQ7s4W+Jy75acsT3ww
 9HVzG2wIENP3/cApwI1EFOJDq4NUZ6RbfCQtTs7JTQu6vrCICAkhhPpTImecLDCuUa/r
 MszH6IMCpm/4hGiLq8Jp+M7fSjgEh6lfjPCCodjB3F74ue7PK+uiW67AgIfiuzTN9S0M
 9KytZMQ0Xts5sBkEL9s2wOMdaIkdvxMdJ22VwGDd5QZefyU/ggXQ3pAsF0997vmA/LYe
 lHYxOPZM78BtTFnjNpLTulLAVLNs5yv8Qs6jrSQzmCPZA8s1xEWxfiWLDJ477fJj4vOS
 bHng==
X-Gm-Message-State: AOJu0YzjoVeMcYJzQOxrS3ND1vTYNQ9vxkXHtOAkNITbZQsormoF7w3N
 JUzGw5hfnd2r+7CI5/LRNuVP0UtPKvPnRQ0l+m+bG01EOKzIf+pYcM8Tk9WU0c0=
X-Gm-Gg: ASbGncvgI/Hj6kwF0D0RttlI4K4vcGtQpOm23hpwDlAHjfXgZ19vcJn6gQxWlqR4MXK
 LA3vh2L1CzwQssRF2tja6YeLrvvfv2vyYuxvJaQFkrE5JvCRwfVS8pk4IuNCWmXZrxOT0irabmc
 k7ghfHOW9Tx8X+RAI0f1goIlvgpa2YlxoBxJZTFCkR/D+qktItbdEwaYA2SpifitiSNk2pnXVft
 gKjRNvhJpV6fh8A8d+q8uc4LJHSGL70AmkEyxtpmCutdx1tJIqNh1Y=
X-Google-Smtp-Source: AGHT+IFwDFvhwSHZSrE/hyV7sM7BvEZbTOwlzT5La5owbhogMfKBcNgDJo/WZWE35T1fm/Q1eai4EA==
X-Received: by 2002:a17:907:96a5:b0:ab3:6734:99da with SMTP id
 a640c23a62f3a-ab38b3841d7mr255257566b.37.1737121387499; 
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce2295sm175622866b.64.2025.01.17.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69A34608B4;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 16/37] contrib/plugins/cache: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:35 +0000
Message-Id: <20250117134256.2079356-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241217224306.2900490-7-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-17-alex.bennee@linaro.org>

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 512ef6776b..7baff86860 100644
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


