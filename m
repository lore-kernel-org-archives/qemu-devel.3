Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27B6C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 23:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxbCx-000317-Bj; Thu, 18 Apr 2024 19:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCt-0002xZ-5g
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:21 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCq-0005tn-Ag
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6eff9dc1821so1540359b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713483013; x=1714087813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ggrpoa55J+CuYa6WaJVJnd/Z1hpjsnV4FDGSfq86nOQ=;
 b=LEMPM9zO7hRylXsKOeyz8En7QrT+hcOH570L6PaWuhcv9lNzISLnGkb6l0IRjdtcC1
 mE5vBp5pgC732N5ATTtAhEINOmTeLkCeqlSDmk1jYxqsHCcUmvfr075tS5PAliaYmNW3
 I9kHP7vj85jUENr+hhv7muEfzJesTkUtxEL3b1W81pxvyeXR9h+TT2exUlm8W2tTUB0m
 2gxkrzJC9XJWPAgrtIJaFLNAtosPysddmhoylygsMi49hKXGXXerlNmDkRY/lkJhlQIq
 sQBba01kh9/N73HxqAxGe/AQ6bl/+a8OG1rObiEEdUOGk1OQG4SEHfrM0DkTKMXsEz2W
 Xltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713483013; x=1714087813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ggrpoa55J+CuYa6WaJVJnd/Z1hpjsnV4FDGSfq86nOQ=;
 b=Y00Q2rqt0gqQJqslorJqksFdeBGxviUlPVPtikuGtf7fb7oA9yks9rn381ADv03ZhA
 u/LfDBrf3olS0i5d+fiLc26XTvzvr9xjILb0zYoCXkLPWGNmZjBtUsVEP5UHDYaoLxnA
 1CMsjSG3+0krwb3GIkBWyxEKumLO2wchBZ4sSWVXbWFTYbKSdtZYW+Qnq01G+/WN3qLq
 s3vt7S6h0B4ltnnGlGH5bGZDAbd+wSAqr8MyW3hM8tVm25euBYiPE4wJO3CngI+Yzrhu
 GT7HafZXv8JOZWGk9bzbJ6BCSJfOMd8yjubcNM54CIgArCY/5RyR6py5P7lKgNaGiNgh
 7Zow==
X-Gm-Message-State: AOJu0YzvgbSMW9C4GuCHg/cH3Nd7WZD/HYwz8VuF6LpRCS0v23yNef/f
 7GuiJBVJngs39WKOi8BSeb470whoq6CvSXK+5RcVsCqSxu6iRlqP5nvUGQ==
X-Google-Smtp-Source: AGHT+IFzgF73P2kI4foReYX74Mh4RfoG1oX0kH4u/p06dPT/Tbq0J7QDVqdIYlKQaXMV/Vaon1Tgtg==
X-Received: by 2002:a05:6a00:27a0:b0:6ea:7981:d40b with SMTP id
 bd32-20020a056a0027a000b006ea7981d40bmr713005pfb.16.1713483012793; 
 Thu, 18 Apr 2024 16:30:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 16:30:12 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 05/12] hw/mem/cxl-type3: Refactor
 ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
Date: Thu, 18 Apr 2024 16:10:56 -0700
Message-ID: <20240418232902.583744-6-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Fan Ni <fan.ni@samsung.com>

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5ceed0ab4c..a1fe268560 100644
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
2.43.0


