Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E31C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgs-0007j4-Mg; Tue, 30 Apr 2024 12:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgU-0006HS-3s
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:32 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgR-000622-Tg
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:25 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51ab4ee9df8so7531140e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495821; x=1715100621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Ebca77e5IYL9WEAaF2UYa4r/GkVpnh2Kl3ta9A5c+4=;
 b=msClK3kX2jHfgGigTJzGxYDXa1R4plXADb2JeN+CbN80faeQB1oKFtxSETJnQ0WNA5
 PtB3WP79tlmzKVSCVswwPOrrgZWxnjFOVN+4SC9NBYyHks83c/50WOqwiDnyqkbmcDan
 55Xo6IxRUYnja6B6JE1z1P1U5GS9cJ7MJnOd1A61J0fUOlB+BN5g/xLvPtK4804azvSw
 vKpA+nKN+4v9J8FFGSOx3laIPgdtrEpwFFWaVkafDh0dE5RCAOcsQSnmnWc49xg71Vra
 4j6M1vTnzzv4piVyY6XvrK6L1ZnXogJm+7p1edZrOg4GMfBaQY5uXy3ebJTNsqAoFZAi
 Y2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495821; x=1715100621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Ebca77e5IYL9WEAaF2UYa4r/GkVpnh2Kl3ta9A5c+4=;
 b=F2tnSIFWx8C/PIkHDK2k9RTinlJ2dY4NM8iFfMF6b5y+7woCxa4x8t2g3e/mNXB3QN
 50Pb74M6gbvULEN9TTMxj8HKhtJ6fDhn+JUdxOxMpF6AjM/vfqgmb9UBITZTQh4UOK9W
 tCGTaA2HC0kk8GKl8v2HGNW7SvOX/T0kbe/d/f+IyVvLE3hDWxYMUyaL5sJ8hHCIoNNP
 lDSLDJQzb399JYvo2P85j8g80jviNNCKxrZHM2ncn+6LEfKVgsXlcbSk7iYpbF4UYWkD
 ebWzreMIzdN11OdQoemwSW6qmOFnLJkXhKYTfWXvg85lJT+/LCfJVJYa3Z3bu4gYYsfJ
 O+sw==
X-Gm-Message-State: AOJu0Ywaqp/YAjUM/61rU4Xn5VwscyPw8mZMRT4kFm2S+R+mRFGNsYaf
 F38xwrqDyzRitHir7+bZIZ6+3Ext+wZz3wbSbVD7nQM4X81gQtBjPSGin+MK
X-Google-Smtp-Source: AGHT+IEM3Jz9S/DKrWu5RICfZqu5IuAbuhDXbfyJpfQLWPTCw63HqZI9CE91kUAd3S8w9gG9YoAS8w==
X-Received: by 2002:a05:6512:1386:b0:516:cc06:fa03 with SMTP id
 fc6-20020a056512138600b00516cc06fa03mr23704lfb.56.1714495821221; 
 Tue, 30 Apr 2024 09:50:21 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a05651210c300b0051d7d7a21d7sm1000646lfg.308.2024.04.30.09.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:19 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 06/17] xen: mapcache: Break out
 xen_ram_addr_from_mapcache_single
Date: Tue, 30 Apr 2024 18:49:28 +0200
Message-Id: <20240430164939.925307-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
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

Break out xen_ram_addr_from_mapcache_single(), a multi-cache
aware version of xen_ram_addr_from_mapcache.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 326a9b61ca..d2deff70c8 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -377,7 +377,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
     return p;
 }
 
-ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
 {
     MapCacheEntry *entry = NULL;
     MapCacheRev *reventry;
@@ -386,8 +386,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     ram_addr_t raddr;
     int found = 0;
 
-    mapcache_lock(mapcache);
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+    mapcache_lock(mc);
+    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
         if (reventry->vaddr_req == ptr) {
             paddr_index = reventry->paddr_index;
             size = reventry->size;
@@ -396,11 +396,11 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         }
     }
     if (!found) {
-        mapcache_unlock(mapcache);
+        mapcache_unlock(mc);
         return RAM_ADDR_INVALID;
     }
 
-    entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
+    entry = &mc->entry[paddr_index % mc->nr_buckets];
     while (entry && (entry->paddr_index != paddr_index || entry->size != size)) {
         entry = entry->next;
     }
@@ -411,10 +411,15 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
     }
-    mapcache_unlock(mapcache);
+    mapcache_unlock(mc);
     return raddr;
 }
 
+ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+{
+    return xen_ram_addr_from_mapcache_single(mapcache, ptr);
+}
+
 static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
 {
     MapCacheEntry *entry = NULL, *pentry = NULL;
-- 
2.40.1


