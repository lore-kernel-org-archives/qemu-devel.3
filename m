Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DD6C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASWv-0006Tg-ME; Fri, 24 May 2024 06:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWp-0006Pr-9R
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:03 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWn-0007do-M1
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:03 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e95a75a90eso7845651fa.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716547919; x=1717152719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=g3iVZeH2rLzKjk86UDLyIpjROPNi5hcd1Vz9bSCOzqL/QKvCkVsL/yEVcMyaIRxqDP
 oGeZxquVKNQrxlDX1Azc3qo8hB1ZSrU1J1fdgTBSjY9g+F0o77o31/aMeJ2QcFPiLJJV
 GInaHlFttpbIur4SWkwvJl9jOnu3loXpp4gAtwaQfXlftUVl+r0Y1P8kcswCSNfZ0tsm
 LxK/JL9rjWiFmG/0h+zH17ItwtReTtx4fnewlKrnm2Jf9jaZBxDtByXzrQzcwrUgL6ev
 6lN6G/jmiuXXw+f5CcYTGGPAfSJyIZsbdt92Z/BZbCkwKahJqQqiJFJIez07ilPMvCIS
 OUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547919; x=1717152719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=b5Fg+VDp/AcLcAUg5nPVvY9YbKAHa7VmoZvC8JoRX7lNm/AQrN10j+mFFMczzk99Hz
 lp4V0FY7/mRC2lZLgamWFZcHeZ16py7Anmym482q5OcXYMp7OJMzcwMyKUFYuajSANlX
 2F7tKuUzIz5KHVMFz5ICOedicO0bBH+H7k/jnNe4VBQ8UJ1wDanjJ9N77ocjvb5A7ccS
 RpUe3AvKsSvNe9IVX4Vc5B2jrc5rp0Ngk/E1p1I2xXxn7bhzqAvuIsR20rFrBTFv35ss
 X6DTSQWqecV5o9xLoZ2QF6XCV5L5CPtV42Fw8YC3yqKUSrgCxMUnqBTMupNKnXl1kb50
 Stog==
X-Gm-Message-State: AOJu0YzcYCPDxXoL8Bc//Thn74AFumhMeODWqJS6n1K7jMhVG0S0VSgu
 JcMCvaIDj9NJw4RhK58jxLcZu3rKstHdgrMhFvH2VT6gHkvJxK3aYFRfMlvO
X-Google-Smtp-Source: AGHT+IG7/58L7fP8XfkA17hx/P2HA+GooUSMBu7K0MzZTbJxr4odywyDF44eC1SlJ9lDqF4xGtjtyw==
X-Received: by 2002:a2e:8417:0:b0:2e5:751d:4b0f with SMTP id
 38308e7fff4ca-2e95b2822ebmr10863631fa.34.1716547918939; 
 Fri, 24 May 2024 03:51:58 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e95bcf4c32sm1421121fa.66.2024.05.24.03.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:51:57 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v7 2/8] xen: mapcache: Unmap first entries in buckets
Date: Fri, 24 May 2024 12:51:46 +0200
Message-Id: <20240524105152.1301842-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x232.google.com
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


