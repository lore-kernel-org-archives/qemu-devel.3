Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8B0C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMH-00021M-CP; Mon, 14 Jul 2025 19:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJQ-0005v0-4r
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJO-000636-Dr
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6ig9qRqfwkiCHsf8lh00IHDvF+tRPqYAeXg59c4+Ng=;
 b=ACaGDALd3pC2Q0cDn1EqJKSFU5T0hamZOqO6Jm/NJCGaGSVxiNZii2MSFof9HZfvK7owwC
 MXKz2I/HYOtiyNvz3il6v8fYc2YZfhPC+r7EwGF/wrHp0ZiHxzHrkTclQcZTV4j9Vd3y5j
 K//meB9nJf2mD+j3LJ1OJFuXDbDZeNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-Iya3C_ujNamJgnu0cMwMLg-1; Mon, 14 Jul 2025 19:10:13 -0400
X-MC-Unique: Iya3C_ujNamJgnu0cMwMLg-1
X-Mimecast-MFC-AGG-ID: Iya3C_ujNamJgnu0cMwMLg_1752534612
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455eda09c57so23180375e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534612; x=1753139412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6ig9qRqfwkiCHsf8lh00IHDvF+tRPqYAeXg59c4+Ng=;
 b=DJFY7eGdKJ8K8VEQIvG1pfcmDITwsWeHmrg0EswuHZ41FoatzFYx5l2nR2tsLCH6XB
 H+FJbsNvH3IIV+xapHeNMfAJp53vblcaKXocGoP+fTNZbY3McpbfNBwMk1OYUETebe/c
 8KxwdT4f8vaqP+LAjZukyUAYGx6HDMeimHWYSHkpQO3GIq8Nbify2FvEY6sPHm0GjvjJ
 HhBYj9/6PcxOr9sjFRQ7gD/xX/nS0uP96h/wJiIbyuJ0z+0kMKNXv+DkMIn/4ya8wI1v
 YCZY5N9EhzztGUSEj+yhkh9VipNh99WWy/OtgqR9VKuWu3FR5958DRCWqrDpNvApxCQA
 pPkA==
X-Gm-Message-State: AOJu0YxKVDhIFwK5+mMps1E0pHcyAu9JwgsecjP51ii3DWsMK0Ta/0MO
 VAi5Vhs3n9OyLwQKLciZeWPQDdDgSNNwFiiY6cHGF13jWakx4wqthLVSpcIPVd0txy222rizLqi
 e7aS6FY/ZDFErIOpPEIegEfZRFpixZnBseKe323oSBZVDwbFb6mwIEa8b9b9Uhseg5dxwmW4P/2
 Vhf1t06/IBPhdVVvoO4e1sVBSf8SNGsu2X5A==
X-Gm-Gg: ASbGncs7h50QnKMEyWIoH61Ec063SZKXd2DV7XauJOCcvehYuMinbUn0/bbfZzuV9Pw
 rkVwK8Hp5p9lwegJB7fgnGXYmNuWJOJbV0aame88d3vmtWI008dDaLB9rfjS/doP8hwTfp+HIe8
 Ma7VvRBcie8+IDrnej07bkiKLDM++4nirb2yj+32cT9RP1QVIYCBBfgDBQrcHc7/0ppRL5pc+qJ
 nHRgRIsqbFO2CEm1Rodt5C25RNiJ3U5c3NlEaDOTxOLNAnH5OKnYcSND0tuT7NORlaB/EPzHGiG
 Oc1Jp5UoBaRwWBs5ZZvn8Y2Q9zB5yv43
X-Received: by 2002:a05:600c:348e:b0:456:24db:2efb with SMTP id
 5b1f17b1804b1-45624db321dmr17190645e9.15.1752534611691; 
 Mon, 14 Jul 2025 16:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEinTC7GlzrmxvU/JeuzzeYkvLwdHpFoX41I5fOl4wtQegcFJeBgD8H1HOQKWFybB1pGvM/aA==
X-Received: by 2002:a05:600c:348e:b0:456:24db:2efb with SMTP id
 5b1f17b1804b1-45624db321dmr17190415e9.15.1752534611302; 
 Mon, 14 Jul 2025 16:10:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26c8bsm13392519f8f.88.2025.07.14.16.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 89/97] hw/mem: cxl_type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <c4dab0352b52095292323d8e0a8d8b83b1cb877a.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Add booleans to DC Region struct to represent dsmas flags (defined in CDAT) in
preparation for the next command, which returns the flags in the next mailbox
command 0x5601.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 15 +++++++++++++++
 hw/mem/cxl_type3.c          |  8 +++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7eade9cf8a..7e0a66906f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,15 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* r3.2 Section 7.6.7.6.2: Table 7-66: DSMAS Flags Bits */
+typedef enum {
+    CXL_DSMAS_FLAGS_NONVOLATILE = 2,
+    CXL_DSMAS_FLAGS_SHARABLE = 3,
+    CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY = 4,
+    CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT = 5,
+    CXL_DSMAS_FLAGS_RDONLY = 6,
+} CXLDSMASFlags;
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
@@ -531,6 +540,12 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    /* Following bools make up dsmas flags, as defined in the CDAT */
+    bool nonvolatile;
+    bool sharable;
+    bool hw_managed_coherency;
+    bool ic_specific_dc_management;
+    bool rdonly;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d898cfd617..6b0889c9ae 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -226,10 +226,16 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
          * future.
          */
         for (i = 0; i < ct3d->dc.num_regions; i++) {
+            ct3d->dc.regions[i].nonvolatile = false;
+            ct3d->dc.regions[i].sharable = false;
+            ct3d->dc.regions[i].hw_managed_coherency = false;
+            ct3d->dc.regions[i].ic_specific_dc_management = false;
+            ct3d->dc.regions[i].rdonly = false;
             ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
                                           dsmad_handle++,
                                           ct3d->dc.regions[i].len,
-                                          false, true, region_base);
+                                          ct3d->dc.regions[i].nonvolatile,
+                                          true, region_base);
             ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
 
             cur_ent += CT3_CDAT_NUM_ENTRIES;
-- 
MST


