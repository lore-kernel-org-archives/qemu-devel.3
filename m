Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA69C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwe-0001ll-4V; Tue, 02 Jul 2024 16:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvk-000767-Pc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvc-0008JM-ES
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMOgEcAe53x2nl/kUwLBbhwXiRFlv4+KNdbX+UZGPhI=;
 b=CO1yXoq74hNy9scjomFIM+YnkdZ9sIlJcOgsazOVeoFaBRHpUOiU7dKtvbubjlWmIsOGh6
 Bejf9O3s3wjd+OXzJ9hn01ny4ghZp0Qet0JfEMohGy6ntXgxtelOYIJmxz7QEgvQ4FJ/SO
 GD9Tu148c4SWAOJcCF2Gm9dJmOCF1K4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-YzN6a8scNsaTQqVMPb274w-1; Tue, 02 Jul 2024 16:16:38 -0400
X-MC-Unique: YzN6a8scNsaTQqVMPb274w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36787ba7ad4so654807f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951396; x=1720556196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMOgEcAe53x2nl/kUwLBbhwXiRFlv4+KNdbX+UZGPhI=;
 b=suZdT4sZxurW/NFhSYMP7D0/HGLV3qJAdZBXD1fhIqaur9i1DMOx8UBiVPy8CEMnw+
 c3mMROqArgse1UlYzCqjTSyJownINBbqC/rvSNiV0eOruhggrItWyLXQ0AX4dUXH4PSZ
 pyHr8FcEEx26YxFOgR+wd8yQWJLmusHlIbfomAF5/gIxjc0lFd/aHO4C2lc04OkXyGoz
 HF7DphNypg98WDNLer6I5jXKSxtNPoj4XXUOBlJHt7EGLuWNp2uO4U58BIIQg7O7xkxp
 OIzw5LRfe8uiDDqvqz0CDszLfNfGfPxFP14J4At0Brl4qfTztFmi8zuGY3F7OrTyRkuq
 VEhw==
X-Gm-Message-State: AOJu0YwFZbTEig//KSixz/alQzJj3PMex7GhH29oGKhVP5svhjjUUJ60
 MhUlgjOOTO/JKlR8bdyYIJmvGaizeMl+vLJ0sU1xUgl1YbL8JhiqOOSmCfEwgbBXOyMZcnguyXA
 RwC3gatTw75GtXPGFaPrKFhg86nQp059JBPgKM0ixd6XIkDE6XogA0Yi3Iw39o016LAlXzxtLnF
 8c5NRLy6DZilnPIvqpKngDPhDKoFqEeA==
X-Received: by 2002:adf:e708:0:b0:367:8a24:dd2d with SMTP id
 ffacd0b85a97d-3678a24decfmr1491582f8f.65.1719951396465; 
 Tue, 02 Jul 2024 13:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMtiYZ27S1YV8XToo5Ab9zb6KtzPNmsNuBl91U8kQBzkQCyfA5M9cGR1KqUmeVjeZOFGhIeQ==
X-Received: by 2002:adf:e708:0:b0:367:8a24:dd2d with SMTP id
 ffacd0b85a97d-3678a24decfmr1491564f8f.65.1719951395756; 
 Tue, 02 Jul 2024 13:16:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d62sm14073289f8f.105.2024.07.02.13.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:16:35 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 22/88] hw/mem/cxl-type3: Refactor
 ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
Message-ID: <69e4fb569dc1602bfeef5b8c58de5f40cd5d756e.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Fan Ni <fan.ni@samsung.com>

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-8-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 06c6f9bb78..51be50ce87 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -44,7 +44,7 @@ enum {
 };
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                          int dsmad_handle, MemoryRegion *mr,
+                                          int dsmad_handle, uint64_t size,
                                           bool is_pmem, uint64_t dpa_base)
 {
     CDATDsmas *dsmas;
@@ -63,7 +63,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         .DSMADhandle = dsmad_handle,
         .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
         .DPA_base = dpa_base,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -132,7 +132,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
          */
         .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* Header always at start of structure */
@@ -149,6 +149,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
@@ -163,6 +164,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        vmr_size = memory_region_size(volatile_mr);
     }
 
     if (ct3d->hostpmem) {
@@ -171,21 +173,22 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        pmr_size = memory_region_size(nonvolatile_mr);
     }
 
     table = g_malloc0(len * sizeof(*table));
 
     /* Now fill them in */
     if (volatile_mr) {
-        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
+        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vmr_size,
                                       false, 0);
         cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
     if (nonvolatile_mr) {
-        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
+        uint64_t base = vmr_size;
         ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                      nonvolatile_mr, true, base);
+                                      pmr_size, true, base);
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
     assert(len == cur_ent);
-- 
MST


