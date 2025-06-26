Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD762C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5G-0006NL-Br; Thu, 26 Jun 2025 18:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv4z-0006KZ-RH
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv4x-0000t4-91
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234b440afa7so18092575ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976899; x=1751581699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/txe+GX1yelBZfnxrTVVuIYl+qM4L46oqnhDie7BELg=;
 b=CZfqinzJ1t587cGtfu9ExuQ6Ibv57oLgd7vk71EWwpvsENxmdlFSgL5gmu9AYI4d+O
 V0YSPJyTfAD9U74OZAena3S/lxVLsh3HChaYoPVqQFadyJJKvQJz9Xoqwe+4Tc7kBGxG
 TgR7TRkgUq9rXaj4P7uWz5MvfY35PbtYVlz0WsIHoJho7TzG5aIBuyXQUdZE+5DgH1n9
 ztuLVnpNItp8D6XnbgfSipTR1JB8vNl66AAO310gw6ID7udWTJWSxilv7eAlTCcKaSZ1
 Bs/xDKLDpWPbdAahEjR1fd7qdvXAH9YrHItP8SpziFT21toXPXhXUlqjI5IvHbGeg3IJ
 h6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976899; x=1751581699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/txe+GX1yelBZfnxrTVVuIYl+qM4L46oqnhDie7BELg=;
 b=qPEn+Y4yXWMD+86VF6MchS+i7kLzm0bj1qjUcbetXyI/0VkSGx3Nq/0cV2bBSv+CQ8
 EYEjzqDLbY9Kg/FTCzEm7lDB/IhFE8Vs0/N6phZ3vlH7v6vo4YpBqZoJvFazqGviisG4
 YBR0ef24Y53FLzUg7S5ZjAjm3/pw54M4K/C/IYxW8bDBbiUyx0CHbjglmIrBummN3QgH
 RL/Cg34jFA0fkdfqxSxyw+dwAOnoCbnqD1lWGcINoFhPxWLUsZGP7eJlhlXytgaeN0cS
 zS/Ei/9XwwU5P+FE7HZJhpEFaM+/XqjVkzhWt3BS8ixtIKOk1+1MuRtq3CmwkJag1K9n
 9S2w==
X-Gm-Message-State: AOJu0YwAuVRVqKFXxUyd0eOO5GuYXRwtZC+P8JALW1fDbK9jjTptOqSh
 gg5ttlNRcVE0nvE2g7OJ17qe/e2F/VxLb039LPPlanO5L9Q7JZH4cXCnv5yx/w==
X-Gm-Gg: ASbGncuIGCF77k7dynJAaSmeQnLlNqxwnKHLzUehXQVaCWFg8SYVW1AppfSRURU0MoR
 wQeNJRMwsHO5HPy+GxJ9PMprJgIMQLPf6ij74IctvtJRtXrVWcRz7i8C5VoC8NNoB3Gr1yNrp2j
 9la1/wBC697cno9YgszE1C2BdcM+yZl62ph9JLZ0mHMzscFroRnnKukoffOkXh17BIVx6Mty/5X
 Yn2sc3qBIqc+Vnnu6R8dhRAdehPOMc5UQzoXmDiUMAqVG9r/Mgv6crQWgnGeZ9AHi9UX3jBiksO
 oYhEyBhljBST2h5vreiyaKh+4xLiS3X7y4fogZt6vRiXPU7jfl3m6RR/nj2h9ylVncVjqsL3BwK
 +iKBN/dHMAa3sp3puqw==
X-Google-Smtp-Source: AGHT+IGlta+/mPFCCDU/bXzB0MEGu5PRj9+kz3XbJlCrBwUqQ7GCFPAD+WOadorLND+c+51S6uQnzg==
X-Received: by 2002:a17:902:e543:b0:235:779:edfe with SMTP id
 d9443c01a7336-23ac4653fc7mr14517155ad.43.1750976899056; 
 Thu, 26 Jun 2025 15:28:19 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:18 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 02/10] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Thu, 26 Jun 2025 22:23:25 +0000
Message-ID: <20250626222743.1766404-3-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Add booleans to DC Region struct to represent dsmas flags (defined in CDAT) in
preparation for the next command, which returns the flags in the next mailbox
command 0x5601.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          |  8 +++++++-
 include/hw/cxl/cxl_device.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f608470362..0fccd22800 100644
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
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1170ac58a3..397edcff4c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,15 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* r3.2 Section 7.6.7.6.2 Table 7-66 DSMAS Flags Bits */
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
@@ -538,6 +547,12 @@ typedef struct CXLDCRegion {
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
-- 
2.47.2


