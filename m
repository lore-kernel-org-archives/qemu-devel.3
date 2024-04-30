Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1268C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgp-00012q-1V; Tue, 30 Apr 2024 03:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgj-0000tm-J5
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgh-0008Pi-S7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JmZN2kTcTDZJ50d2NsMjDgbsSWIiw0AqDPZau+AXCw=;
 b=GHU0B8V+5ReUxbRQ33SDMSQna/Z/MgFBFTj86zNjGDqlX2KAWII7wRrBhfpnypqB9iQuVo
 wigS7vD+8Xu7YzM7oJmlfhRHLJ/VTfMt+aMlbeY7T3Ezajs13lvEUbaBu8cxYKI2W9jfaj
 KLKgk3+6NVTgUjjdUVjXyBTFWRi6yjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-VEPFPp79OJ-XFW0uVv64ug-1; Tue, 30 Apr 2024 03:13:57 -0400
X-MC-Unique: VEPFPp79OJ-XFW0uVv64ug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 284B489A7E4;
 Tue, 30 Apr 2024 07:13:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A20D040B4979;
 Tue, 30 Apr 2024 07:13:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Chris Friedt <chrisfriedt@gmail.com>,
	Chris Friedt <cfriedt@meta.com>
Subject: [PULL 08/19] hw: misc: edu: rename local vars in edu_check_range
Date: Tue, 30 Apr 2024 09:13:29 +0200
Message-ID: <20240430071340.413305-9-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chris Friedt <chrisfriedt@gmail.com>

This serves to make the local variables a bit less ambiguous.

The latter two arguments are named to match DMA_START, and
DMA_SIZE.

Signed-off-by: Chris Friedt <cfriedt@meta.com>
Message-ID: <20221018122551.94567-2-cfriedt@meta.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/edu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 14250e0ac3..e1cb443438 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -103,24 +103,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
 
-static void edu_check_range(uint64_t addr, uint64_t size1,
-                uint64_t start, uint64_t size2)
+static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
+                uint64_t dma_start, uint64_t dma_size)
 {
-    uint64_t end1 = addr + size1;
-    uint64_t end2 = start + size2;
+    uint64_t xfer_end = xfer_start + xfer_size;
+    uint64_t dma_end = dma_start + dma_size;
 
     /*
      * 1. ensure we aren't overflowing
-     * 2. ensure that [addr, end1) is within [start, size2)
+     * 2. ensure that xfer is within dma address range
      */
-    if (end2 >= start && end1 >= addr &&
-        addr >= start && end1 <= end2) {
+    if (dma_end >= dma_start && xfer_end >= xfer_start &&
+        xfer_start >= dma_start && xfer_end <= dma_end) {
         return;
     }
 
     hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
              " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
-            addr, end1 - 1, start, end2 - 1);
+            xfer_start, xfer_end - 1, dma_start, dma_end - 1);
 }
 
 static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
-- 
2.44.0


