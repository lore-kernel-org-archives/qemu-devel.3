Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AA2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgq-0007fs-N0; Tue, 30 Apr 2024 12:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgd-0006R2-D5
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:37 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgX-00062T-Lx
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:32 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-516d2600569so7363413e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495826; x=1715100626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kom/SHDfVUZpmIZv8oD+sehGVIlmksQJn6703to5aOw=;
 b=BKzV8L/ZbU8k0t+UCnLCHRhG/69tFqUuWWD9nWrcz6Kvx+DZRVoqB85ADB6oc57ONL
 aKzxzZiChLptuN4fAnddeXaLkJpH7ia/0FGFdIVyvF7OKIEMlqWyV2FnxA+2Hxxl5ce0
 BqJd/rlLQVM1L9uGILDM3e8Rs2vZKXyFPBTdkv1bfQJNMECVWGlxaXe8FnJXgIYt/IfJ
 /CjLfYvwteuuAflfTcOyVlOPYWq586HYlXKBnCWNGuP53R0pmBabfJ38vflmUf1fa3MR
 k7NwO91fzUqIxlXuqTyUh6c8vPnr/yBZXC0NjCnd4eISudntD0Qy1k4QRTifk+KsT7bW
 6kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495826; x=1715100626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kom/SHDfVUZpmIZv8oD+sehGVIlmksQJn6703to5aOw=;
 b=kRk2hfDXkUnLkytzDsGg5t5qzHVJP/M9QZl4fRDgBYbZNjWnyy0SR/Dv9UjxBeUswC
 bjaCcPbdDgScbBb6ZgJUoh04fen4x2QJts4lYzvexKhHMk1Om/O/g8mU5+qGvPRs7cxS
 0D6PdIhOrpk1gM3fSEkOVBzDzaNAf5Pf6R95k/XJRY10MtXqdHaZnZExsGYVwM48tris
 x24b9yMSqgx58v9unv4gJJ//YunfeKADGfN1OXHbYatW5/7fh9bXiGQlHEkYniptIXvX
 vPxXJcRZyxfOJgS8mIggjK2mm+8pgrDQT1ZqxxKXEwH0EkRV3N2TS1hu+jLGNx+kZhz9
 CdAg==
X-Gm-Message-State: AOJu0Yz5LejvGApVHYhA2atHSf39UMFeEeY1llwzpGHCxTB/5oNx/kZk
 OcUwfiE+0kgerBkzWkkiv/hTM1GSHUiQmMCDJwHGVhfHKPu68dW6Xc1ZN8rU
X-Google-Smtp-Source: AGHT+IFL7xixQZzyY4IgwLtRiYEyYk+uUHOVAzj9b5xqr6eOpzsgiDsvBW99qrlkBchrQCMFWP2fRg==
X-Received: by 2002:ac2:5a50:0:b0:51c:f898:60cb with SMTP id
 r16-20020ac25a50000000b0051cf89860cbmr15984lfn.35.1714495826099; 
 Tue, 30 Apr 2024 09:50:26 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a197518000000b00518b91e8fd7sm4495626lfe.235.2024.04.30.09.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:25 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 09/17] xen: mapcache: Break out
 xen_invalidate_map_cache_single()
Date: Tue, 30 Apr 2024 18:49:31 +0200
Message-Id: <20240430164939.925307-10-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Break out xen_invalidate_map_cache_single().

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 34454da2f6..dd08cd296b 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -512,17 +512,14 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
     }
 }
 
-void xen_invalidate_map_cache(void)
+static void xen_invalidate_map_cache_single(MapCache *mc)
 {
     unsigned long i;
     MapCacheRev *reventry;
 
-    /* Flush pending AIO before destroying the mapcache */
-    bdrv_drain_all();
-
-    mapcache_lock(mapcache);
+    mapcache_lock(mc);
 
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
         if (!reventry->dma) {
             continue;
         }
@@ -530,8 +527,8 @@ void xen_invalidate_map_cache(void)
                                        reventry->vaddr_req);
     }
 
-    for (i = 0; i < mapcache->nr_buckets; i++) {
-        MapCacheEntry *entry = &mapcache->entry[i];
+    for (i = 0; i < mc->nr_buckets; i++) {
+        MapCacheEntry *entry = &mc->entry[i];
 
         if (entry->vaddr_base == NULL) {
             continue;
@@ -552,9 +549,17 @@ void xen_invalidate_map_cache(void)
         entry->valid_mapping = NULL;
     }
 
-    mapcache->last_entry = NULL;
+    mc->last_entry = NULL;
 
-    mapcache_unlock(mapcache);
+    mapcache_unlock(mc);
+}
+
+void xen_invalidate_map_cache(void)
+{
+    /* Flush pending AIO before destroying the mapcache */
+    bdrv_drain_all();
+
+    xen_invalidate_map_cache_single(mapcache);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
-- 
2.40.1


