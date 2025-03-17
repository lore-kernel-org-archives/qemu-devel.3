Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A5C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGSB-0007bl-0G; Mon, 17 Mar 2025 15:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZ3-0003Ur-P6
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDYr-0001Be-U0
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225477548e1so80024915ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229808; x=1742834608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAaLVmqu9E16HyMGv9eV8vHzoQlr4XWZ3Yj3gmP1ZVU=;
 b=G2fY61TKjFhlx9zRjKMU3eNArzLb10QGCZ7cr91UAjhLKWqKrc7Ll3p2e+c9NKQ77W
 sE8AxDPbq7v/wu7dpWlsbEKReei4wVJkgfScTXQcNEYiOahA2OV0Ui3TH1TZEeNLM4DP
 aTBOLEHOeOtAsKd5/N49Kxf9BD2qp6uR5SDxvuoE3wohFTbdUg81Vp9CE6H+Kfiyns8a
 q+/uBB8t8iGoaMNTjURqW+eUXF1ACT02bp7RNSJAXi4/xvZCsBMhFCM0wGz2nnSw8mvL
 afyH5AjyAvLMmxGFCODS4NHlqEogwbpCSawyHhvp0n/fdpnRbXkZkLVQ9NvLIk930vh0
 DzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229808; x=1742834608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAaLVmqu9E16HyMGv9eV8vHzoQlr4XWZ3Yj3gmP1ZVU=;
 b=aZje9iXaz8JCkPB6t8zJz0R0/SmSNFSR2cFkeJ7ru0EllOY7VfxacTwwDNjTUUENgc
 Mm7OVmhNSy16t6k3YP1K06id/BVytksN9Lyxy3E2soTK2sJ1lT7SGVgDBXE8kZ3/xj6k
 XgGqAtz4ewUHVUjD6BoSoDmIvfdivrIWl1e4gXR/A3O8ZaxFNs86enWO3AbYDPHADfcc
 M/T+2bxdJsSDN0CIs0lHSd5VTgA4gPDonFy1vkT76t2JKPIHmZ2SYFz6IuhQPbESQROZ
 NAiNrmuCSB+vDKYqUamX7d3OWGjYBnW4sQqe9o80DNLqXX49FYl+NlDUsYtCFMD9e5lh
 f0uQ==
X-Gm-Message-State: AOJu0Yzjpb5JhFUfgEQ8chy999IXcXSJA+WP1E+r87Kh/QxWYHdQ3NGu
 +BvIrSikL6T8/uWI+9oAuTi8F8nrBRxMvxbCLo9m5EsLH8fb7kMPJ0JCmw==
X-Gm-Gg: ASbGncvk656HBqloWo+iQNqdx+KkUzFoxiyo7rchnN+BPuOO0l964ZVLtQBYjQ+fC/g
 GMLtUPItBvjPbAH4Tv1/g3s4KnfDslIH4UEZNS9SVB4ybW7HQuzfhTwcUWHl+FUGUusFtvkutVB
 lATII2LjNlnT1XGYi521RQoal+o8i7mUsihGPz3Vpqa/b0yZY1Bwy0e8u5UjVx1CRnRXiZyhPEJ
 wbl4h51/7s6WSO5tg34XfjtrOeHmtAp2jAyTmTeXmgCrpi+UAOxFZmkvI/Skf6jo4zDgB3mjwUw
 4yF3S/W5OHkx2NqQcs4OsxiOMwmap+9/pO83UCHIL+8bzJucEiM88asK3B8qPuh5KQ==
X-Google-Smtp-Source: AGHT+IGkTtuuqZhQdLdpoG9OkgJlR5lZTGZes5mG3fw6uc48OLBRxw/jQmjoTiuqAN7bv3zJRRROTA==
X-Received: by 2002:a17:902:7488:b0:224:826:277f with SMTP id
 d9443c01a7336-225e0af5bc8mr123722155ad.33.1742229808421; 
 Mon, 17 Mar 2025 09:43:28 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:43:28 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 1/9] cxl/type3: Add supported block sizes bitmask to
 CXLDCRegion struct
Date: Mon, 17 Mar 2025 16:31:28 +0000
Message-ID: <20250317164204.2299371-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
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
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:47:56 -0400
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

Add supported_blk_size field to CXLDCRegion struct in preparation for
next patch. It is needed by command 0x5600 Get DC Region Config.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 3 +++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 11c38a9292..731497ebda 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include <math.h>
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
@@ -766,6 +767,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     uint64_t region_len;
     uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
+    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
     CXLDCRegion *region;
     MemoryRegion *mr;
     uint64_t dc_size;
@@ -811,6 +813,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .block_size = blk_size,
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
+            .supported_blk_size_bitmask = supported_blk_size_bitmask,
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..bebed04085 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2


