Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D25D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtB-0008Tv-HX; Wed, 28 Jan 2026 20:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsw-0008OP-EP
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:50 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsu-000371-Md
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:49 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a7a23f5915so2510895ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650307; x=1770255107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mb63Yt1v4Ty5OkvWSIBVZAbYBXgyy5QqQMvYk6KNSps=;
 b=oN7D1Ir4JW1Xf+SwlP+2vHgyKmkCbEVgENk7adgc7knq0wzhBAXdDy+UBxnszGKfDB
 e2uKWDGGqKnAOFWLyAfoQDF5wR1Q7fyom+0TEQgVDUtG6AzedabtKyhatkokNw2w7hGg
 54FHrR86896mjNYZ+DBvBa9xI5K8cH4K0pySn21JmFE5SL1LPQNEQclrC3MCs3XbiPvb
 RILwcHpm7ATj3vpVB2VncUnRyAWek50f+Um+QEWmEqwzQ2+PtQNMvvxMfgSWw3WYNvnU
 Z+5wIOGnR/Ad6miScY6FT9WvdeaAHUfBfa1892+u1yHd6J7JGoJ9odle3otr0Wl7klVL
 fLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650307; x=1770255107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mb63Yt1v4Ty5OkvWSIBVZAbYBXgyy5QqQMvYk6KNSps=;
 b=Hx0NWQlPJJnN2UaNNKN+kjXdPTHuyNNFabWHzwmVmbc5lAbkWXOVkC3NyerARtG1Zl
 HfkWHrrgs5BNmFB7jiS6o9nbhKtL8x+kKxJpBqy4cA3xDRXP/aU3/kMw3kZVkCTWqUpe
 zskS1rCvqSe6oKbMlqI5XV2ERiwLXOeWgOvhgpFsskzvLNb7VmmCI9DiH5z8G2NpdH0a
 LlJusv8OfKarQVeyhNx6fdkFN/+bAUQNU+bB8Kqon3A05xzuANPyOKu/6CVW0e7zIcWy
 hfeo9y4kHRhufmjPU6uZXWVZqzr5a5VOpeU7SeM8/iyaqmF4eLnbrQXD0RfAh8RTAswb
 ckgA==
X-Gm-Message-State: AOJu0Yzb0nJWikpyXEJfhYRrSxDUFKg5wJ1Y1WexYHlQtxbLJs65cVgq
 5L2fLulLU2Hd9ccfBdSRzWkp2Y1wTqqGzUpxi4gqFAYxR6WaIy4nGN7rVzitSrf99yy+O2p8UKR
 JRsq+
X-Gm-Gg: AZuq6aLa8Ga1JfHqgq//q74LkkxCFNvQxbxuP01PXDNxN5bMelVDxk2ht0FCqJzsaAx
 qqTbfT+OgX6kZUsNBIGmudzOOEDkxuIfZ6hfKo3lXRI95Ja59aop328nc3WQTXHJYYZIwR7JEww
 0XTrH5czKqeFMra9eUHx5NPEa/raxpT3N0fZHUljpbrBsqJ8IQe6KgkhBnkjyWVfaAq0LYQl25Z
 IQuSbyc1PIL+ok2gbA9WIgZb//bGOcB+A4g4HwXR5EFIOYrGwrWEvHX/S+DbQNZDauxBxsoApy8
 Qc2lJAuyBZgg/UYWiQ28iQeTy9MB9d0pEodjpaCac3tXzNa6DFURyJxo6WCTzwzQH93wdQBVPXl
 LDTx8N1RofwC2ydm0xgiMn4h0mrifjL+6yE5SGfcKs5cfXNbFW/3VQgnEf9vO/QR34jtKzvdikB
 1V68sIbet7oNMWUdbnxqKD6/EPjrj9p+R+qlxc4xxFFnPCnjX+Ruozhpr4y4D/pgO7
X-Received: by 2002:a17:903:1b08:b0:2a7:5171:921e with SMTP id
 d9443c01a7336-2a870ddbb1emr65997775ad.45.1769650306828; 
 Wed, 28 Jan 2026 17:31:46 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:46 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/20] contrib/plugins/hotblocks: Correctly free sorted counts
 list
Date: Wed, 28 Jan 2026 17:31:15 -0800
Message-ID: <20260129013134.3956938-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bradbury <asb@igalia.com>

g_list_free should be passed the head of the list.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 98404b68852..d3dd23ed9fa 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -73,15 +73,16 @@ static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("collected ");
-    GList *counts, *it;
+    GList *counts, *sorted_counts, *it;
     int i;
 
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
-    it = g_list_sort_with_data(counts, cmp_exec_count, NULL);
+    sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
-    if (it) {
+    if (sorted_counts) {
+        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
@@ -94,7 +95,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                     qemu_plugin_scoreboard_u64(rec->exec_count)));
         }
 
-        g_list_free(it);
+        g_list_free(sorted_counts);
     }
 
     qemu_plugin_outs(report->str);
-- 
2.47.3


