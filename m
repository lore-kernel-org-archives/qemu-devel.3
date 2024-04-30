Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D965CC25B10
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgq-0007Zq-Qx; Tue, 30 Apr 2024 12:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgZ-0006Ln-Rk
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:37 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgV-00062K-On
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:30 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51ac5923ef6so8251e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495824; x=1715100624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fl7u/xU9kjPK32PHrP3OybWWMA4e16GqaL6Xbstmvbo=;
 b=ZSZjD51uNd8i7erT+VldYZ1iRtMoY+GZZCYThpn18CgJeRzTPC2Qehu/DEheflMQBd
 bAJMBdK2ojL6tCUqaBunHkuFSanFjjsN15K6UAWyMjz7ZUN0phYat/kIrJ5Flg2RSfDl
 AuKGoVUNGX6oOUrDJBvWvXEcDvdesK4ymmu+DFdJddEPur9Rtd8FY9YflXBrpAywR6rH
 0Eixs6FPxoCDf/0T5BcP2AKUD7HJrkF8wPlA5RQidL1eb2z2KBXN/pA0m9KkTmQeUO0q
 Vd4Yj+kMH9rGPXDinzF1zyU3xyej/7jhEiIX8g3+agdUxtCTHdLyF4tvEgSmiaNp2LAc
 e65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495824; x=1715100624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fl7u/xU9kjPK32PHrP3OybWWMA4e16GqaL6Xbstmvbo=;
 b=gmP0SZDVdJLfYYAZT3WHwp8vCrMf/Wae15LYnyI+6Z48sCmimVk4QBJ43DshLQM7ux
 C0fJ93DeBxYcz8vlzbI0JY4JUrqctzdpx9OVPQo2fTooBHCMbHaROyMxXef8wApo/KkV
 tBGpyjgr679HnvycBOPgNRDh+dA1Wci+tRIngBWtdAV+GbKrKw09WbOQKVU4NXs8Fo08
 +46szHPP5JdTUWRs3gBmcm0piysvvAQwdrk1JVhXF+4MQxpLdN4QCBkvyULqcl49yILi
 6xaL1nfS28EfmeKE8OU3+okzrrAo8ZctoeMfQnJtkjcpnBR4agn6reC1RaGrHogLML0h
 gJTA==
X-Gm-Message-State: AOJu0Ywco0JCiSFqc5OM6YtO+k53MP6oz4YfYOiikTxTyV9j1AGOdbnL
 +7JYXRJ36r3LUScArXMF9NwwtHZmVZVnh1/b24kv4EEXE3Xs5dBZB91zzNKr
X-Google-Smtp-Source: AGHT+IEr1VKCghuiim9RyIssq8iqWzgedXC6VPdssb/073WGO5FTX1lD3Adw0P8JM08/qNMg1AdtBQ==
X-Received: by 2002:ac2:5f01:0:b0:51d:6630:b83f with SMTP id
 1-20020ac25f01000000b0051d6630b83fmr89702lfq.17.1714495824584; 
 Tue, 30 Apr 2024 09:50:24 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a197012000000b0051d9149a2cesm917564lfc.84.2024.04.30.09.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:23 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 08/17] xen: mapcache: Refactor
 xen_invalidate_map_cache_entry_unlocked
Date: Tue, 30 Apr 2024 18:49:30 +0200
Message-Id: <20240430164939.925307-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
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

Add MapCache argument to xen_invalidate_map_cache_entry_unlocked.
This is in preparation for supporting multiple map caches.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 6e758eff94..34454da2f6 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -420,7 +420,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     return xen_ram_addr_from_mapcache_single(mapcache, ptr);
 }
 
-static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
+static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
+                                                    uint8_t *buffer)
 {
     MapCacheEntry *entry = NULL, *pentry = NULL;
     MapCacheRev *reventry;
@@ -428,7 +429,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
     hwaddr size;
     int found = 0;
 
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
         if (reventry->vaddr_req == buffer) {
             paddr_index = reventry->paddr_index;
             size = reventry->size;
@@ -438,7 +439,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
     }
     if (!found) {
         trace_xen_invalidate_map_cache_entry_unlocked_not_found(buffer);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+        QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
             trace_xen_invalidate_map_cache_entry_unlocked_found(
                 reventry->paddr_index,
                 reventry->vaddr_req
@@ -446,15 +447,15 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
         }
         return;
     }
-    QTAILQ_REMOVE(&mapcache->locked_entries, reventry, next);
+    QTAILQ_REMOVE(&mc->locked_entries, reventry, next);
     g_free(reventry);
 
-    if (mapcache->last_entry != NULL &&
-        mapcache->last_entry->paddr_index == paddr_index) {
-        mapcache->last_entry = NULL;
+    if (mc->last_entry != NULL &&
+        mc->last_entry->paddr_index == paddr_index) {
+        mc->last_entry = NULL;
     }
 
-    entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
+    entry = &mc->entry[paddr_index % mc->nr_buckets];
     while (entry && (entry->paddr_index != paddr_index || entry->size != size)) {
         pentry = entry;
         entry = entry->next;
@@ -488,7 +489,7 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
     XenMapCacheData *data = opaque;
 
     mapcache_lock(mapcache);
-    xen_invalidate_map_cache_entry_unlocked(data->buffer);
+    xen_invalidate_map_cache_entry_unlocked(mapcache, data->buffer);
     mapcache_unlock(mapcache);
 
     aio_co_wake(data->co);
@@ -506,7 +507,7 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
         qemu_coroutine_yield();
     } else {
         mapcache_lock(mapcache);
-        xen_invalidate_map_cache_entry_unlocked(buffer);
+        xen_invalidate_map_cache_entry_unlocked(mapcache, buffer);
         mapcache_unlock(mapcache);
     }
 }
-- 
2.40.1


