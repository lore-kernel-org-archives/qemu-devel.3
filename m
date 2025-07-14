Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA0BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMS-00035Y-O6; Mon, 14 Jul 2025 19:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJW-00061g-Mo
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJU-00063l-Pu
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xH0Hadx8VDWbsC99yPU6FzlCEOXY/KFNLOZusRRYw4I=;
 b=OdjMCkK6QKGuu7HKWzyTk0TIrAIhM9eJ+gnvEbb/LdVt9y2jMuv6sS9h1jEM+PPNCCuwJR
 yoRhN+J+IbEjWeJyBd5/zKdqW+SsFnjKBkeRQIvnAn5ZAyoowKTkpGIUYLXA7Y/uVLzqrX
 U8B/8I0DjlGiZ33nFCNB8sw5wp8/Nw0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-qmfRLH4rO0atdoYcovNDBQ-1; Mon, 14 Jul 2025 19:10:21 -0400
X-MC-Unique: qmfRLH4rO0atdoYcovNDBQ-1
X-Mimecast-MFC-AGG-ID: qmfRLH4rO0atdoYcovNDBQ_1752534620
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so1964291f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534620; x=1753139420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xH0Hadx8VDWbsC99yPU6FzlCEOXY/KFNLOZusRRYw4I=;
 b=O7V/EK0tZ+hDfn5WmoKXmJVw8H4gqOLtBRY7bLfAPBnIFJFCkY5WdheYhjBBccxVpP
 USAi79wnedMpp/XnjTdVfvVD3ZLBb8p/7G3FNz7wfIxEutY/Q8TtZRRa5AhiCy9uBaWN
 Ld5QgM//jCo8pF3NeSoVG8rr44DsVSVUp4EmC6Av9YVi3Cvbl8ZCSlwqtAE7LwJFHTxJ
 cv2WiQahYQbWqjGgQdUFPEt01RwaVI61DthU3U5ueZsKAbHy1AQL2ecpClxiaF1yhGN0
 ksFZPKI4TceH5fgSXVX4X2lWImv3/kYxbsh2921/w9dssd8DmIbnri8X9+vPjl/6Saw5
 +rew==
X-Gm-Message-State: AOJu0YxyW7JlNZAjY1/l4NdNEtXCwTeRYhuMB0tPQ1JaodEKndYvEwTX
 NskjuVFGttz1yCMo3IYhlpqXlD3t84FwDeSfG5zORhRH0fhbjNQnIrHrt4FVrOVzLKMhhyjb7uC
 T2LdgBxpPzPknRk226K4sAP5Txv/SE4cymjTk8OECOhsCotmQFijR0Cl2YW/j+chQTHzwvX38WF
 +zmG+jHzPqsQX+R/clKXuShuZItf/yRSrHOg==
X-Gm-Gg: ASbGncsxgnX1ZzAE0KOy10yU3NIUpB2ZvRXWEIh/d3z2hJ7VrA+2LMHHkIGOA/VGE/y
 2OLU3ZSXh/tYQ5q2XG6kmVCO5a6udbdxfY8pephGohTz71ztQG8nhqPf7NnCDnr+mWOJnizxw81
 ePZcQIkyjcVQZ/NivAvDyws+uiJ+h3UdxdTxLDqiEcO+cCd6hWzyTW51m7DvrrEKPop5H/fyep1
 S2/EeQ1+8AUkjlk36fSyNsAhKOa9tcHGUc4a3PK6BEeL2POuVfpTSm4JhIcQcyRsSh6DlidmXHs
 n64CvvWOXwWxGlGWr0/Z7tCexWACC8pH
X-Received: by 2002:a5d:5f86:0:b0:3b5:e6bf:97b3 with SMTP id
 ffacd0b85a97d-3b6095203bemr1064112f8f.4.1752534619817; 
 Mon, 14 Jul 2025 16:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFntv/Un948yZlYBcCDPEYqwwzA2OgWsygeZ21LVv18doLG0rJLdzwU3vMCX0O8EAxaGd0Y6A==
X-Received: by 2002:a5d:5f86:0:b0:3b5:e6bf:97b3 with SMTP id
 ffacd0b85a97d-3b6095203bemr1064093f8f.4.1752534619322; 
 Mon, 14 Jul 2025 16:10:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456178ace19sm54583895e9.19.2025.07.14.16.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:18 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 92/97] hw/mem: cxl_type3: Add DC Region bitmap lock
Message-ID: <69fd70566d15188681b9b2c51fb799e030e287e6.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Add a lock on the bitmap of each CXLDCRegion in preparation for the next
patch which implements FMAPI Set DC Region Configuration. This command
can modify the block size, which means the region's bitmap must be updated
accordingly.

The lock becomes necessary when commands that add/release extents
(meaning they update the bitmap too) are enabled on a different CCI than
the CCI on which the FMAPI commands are enabled.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 1 +
 hw/mem/cxl_type3.c          | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7e0a66906f..42ae5b7479 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -540,6 +540,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52d3910ed9..a7a1857a0c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -692,6 +692,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        qemu_mutex_init(&region->bitmap_lock);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -1020,6 +1021,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
         return;
     }
 
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
                len / region->block_size);
 }
@@ -1046,6 +1048,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
      * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
      * backed with DC extents, return true; else return false.
      */
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
 }
 
@@ -1067,6 +1070,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
     nr = (dpa - region->base) / region->block_size;
     nbits = len / region->block_size;
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_clear(region->blk_bitmap, nr, nbits);
 }
 
-- 
MST


