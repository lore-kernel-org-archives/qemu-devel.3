Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3633C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dLB-0007kK-1e; Thu, 16 May 2024 11:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL6-0007hG-Ac
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL4-0002u5-RL
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420160f8f52so31982785e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715874492; x=1716479292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=i03cVGdNBc7yUI8Ib9UF/agERpI+G0rEZbdC85K0KKcHHtg6/E2OPGnYEF630DPoUa
 Ia5ez9XFvlDWDtUgM7P1dJ4V28n8hcQrgHtrC7+/zQh6ZiC8qRjiq/W1lFgwrurOcERN
 A4FwIyWbr421jycuiOtTz7Xqf2B5fm49O3UH/WDOMknyeZSOrL+POxj2/MI6FROiOSs3
 IjNNSyUm30JuwCgpm9gwKDzSM3ALXTsJGj/wMJAdnjDmBcnSxCV4XCiLqhrsj5ve7Vge
 3TtB4zgDGGsq86eMPoVIDEGp4OETRYjB52qMGQOlpKQ+TtyAfFL2CH2kI3s7wf9wZzSj
 W15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715874492; x=1716479292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=O+jQj8NIL+eLZV1LTtokJasBh+0697fIskW/69Um8MCDkOnn3JWOpK4aY2sjGcRuid
 rY4b0Tme9q/RAyg2fsXIC1kXilsXegjBH4p1zXW5A5TiD7K2Ly3z8x5bnAwBgn4XCpu7
 +9XqSTjBw8KDO3ofnHlrPmNnEkBTAOzcI2YQxBvAnsszbGaj97SE8NqWbGmbyi86+ceT
 oCLphkrcceJeVDLRdP1YW5FLe8WuO+TlO1uHWotbZF7tuAA0zGmoNwQ2q/TyeX8uJmpF
 nmOeJUSmhmeEjYRlWNUT7J8VCyx9TJIJf/vmbxgHh6859gcHDewJfa/mSg/+yTIHu4/8
 9ZtQ==
X-Gm-Message-State: AOJu0YyLOQZIYcGhHZH9ZgKl+dyIw+PwTCB4QeZpCsRk7Hj6w66mrbEC
 ro/7cUorhmXOYOeOXMy5wd6wyG9SYWLkU8Nb+4yz9jfZexcssNFXQjZyHZDVaNU=
X-Google-Smtp-Source: AGHT+IFjr0fT67BiVLzPhzx72CFQaxGN4vZsogPbdN+2UbY4Li7I/8td4kLMOJN0uGIq1S8SJxxrwg==
X-Received: by 2002:a05:600c:154e:b0:41f:e959:9053 with SMTP id
 5b1f17b1804b1-41fead6ae10mr166768825e9.38.1715874492348; 
 Thu, 16 May 2024 08:48:12 -0700 (PDT)
Received: from gmail.com ([213.0.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420193b0903sm135397305e9.47.2024.05.16.08.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:48:11 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v6 2/8] xen: mapcache: Unmap first entries in buckets
Date: Thu, 16 May 2024 17:47:58 +0200
Message-Id: <20240516154804.1114245-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x332.google.com
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

When invalidating memory ranges, if we happen to hit the first
entry in a bucket we were never unmapping it. This was harmless
for foreign mappings but now that we're looking to reuse the
mapcache for transient grant mappings, we must unmap entries
when invalidated.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index bc860f4373..ec95445696 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -491,18 +491,23 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         return;
     }
     entry->lock--;
-    if (entry->lock > 0 || pentry == NULL) {
+    if (entry->lock > 0) {
         return;
     }
 
-    pentry->next = entry->next;
     ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
     if (munmap(entry->vaddr_base, entry->size) != 0) {
         perror("unmap fails");
         exit(-1);
     }
+
     g_free(entry->valid_mapping);
-    g_free(entry);
+    if (pentry) {
+        pentry->next = entry->next;
+        g_free(entry);
+    } else {
+        memset(entry, 0, sizeof *entry);
+    }
 }
 
 typedef struct XenMapCacheData {
-- 
2.40.1


