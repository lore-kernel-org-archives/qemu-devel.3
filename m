Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E66DC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5K-0006Oi-1i; Thu, 26 Jun 2025 18:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv52-0006L9-AX
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv4w-0000ss-EG
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2350fc2591dso15860095ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976896; x=1751581696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aklx2xGgDQNbjMLifr3+RHSJMwqIIoFZqjTwJHtrWFA=;
 b=Ud03Hhi326YTARsJjoF9HnX1is789jJjsv5UmkmXIFqkm5K11ccdHm7n2nu47yPmEz
 PLfF2r/2yAJ429yJmnx7D7sS1jmNlpCLB2SS/nE4c9LlQKdgUkCPbjWB8sjE2EIpZUYT
 WIN0YBlwEv21VJmSZijdImTkGzVa+s/2ru7SUfxDaf92UuxF1Hk3t1ebSnaOt2Wi7vxV
 le/HRbMlkM/9qkZH3M8Y0mf1EF84DjHIErNcm9VHqUUIE3nTN27ZYbG5885MvLcUVZKR
 ShKOUDKCdoi6kyGUJDgSgUFw8h2MQNVNtf/4WJLvdea8qf0AQ+yn8LQrd2HreGP1TTAU
 dENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976896; x=1751581696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aklx2xGgDQNbjMLifr3+RHSJMwqIIoFZqjTwJHtrWFA=;
 b=cfgAAeXI3syd+UejUgq1koBW/vy1Tq0xmbbj5Le65Us9pXvztJa2nTecA3QL+I+Jdx
 j7/vy6zsz8v5pgjK+19yOl6ZMYFs6mrQe0/+L+S+rLnSEU5gJZhzTSejiQk5dyynRZus
 hSQ3AHEDm0pBUft4D0eViFERlfByhVS2q6IzqTd5GPpzxlOVZGvwdI5af/xeoTRLkux6
 cKns9eVilTKchfjW6seBnRH7nBiH1hfNkJtlYHNZza+Uupj0UxD/+XvpAye+ey9EdXYX
 C1iCDwzLaVxLkZnFnM8u76cy6HeRvISx0ugQUN1LwxnBtMb5E2a4rDDZuwhsOs1PNnoe
 emgA==
X-Gm-Message-State: AOJu0YzaQSlFvqcpi1VVsfhuyxriFngELZICkCW2Hag8G0LS7y/rmZ9w
 kA+hx8ySI8Vzr6BkQF6l2qshSMXggpjRw0bXIMfwFLsAf56Rsh6ezGYDLZpo2A==
X-Gm-Gg: ASbGncvjDzdlXYC1bldNU9RErN/CGR5+eqPRKkj148afI3LKivsSUvqztgmA2NStkXg
 hIP1AqXawqd5i6WoiPqgvLlSIENyaUu7YoMdG54fmlTwluTIiGwjXDYBPaf5qMS8piEV2J8F5z2
 YYxotVzgxaHIM3muweK2FNGNnZGK3Rj0q7ToE/3H/INn9h1j0aZkuNVwAe3bxRHp6auE0RmOj3r
 Qpk2ZyJq1Uowx7vMAasCPnVQ8QbB1lYY0T55mNAxnMS170bkVVjyqtR++BDGPyEIM6jCXWIpc4i
 N+D3fTSDENLcrIUsrT4b0pwkYTtzRbQs940wBm1phxNqfLpr47UMAHJwoGY95aR5mMI8m0xHPxu
 I2jauXBY=
X-Google-Smtp-Source: AGHT+IHz2T1AGTKlgEh04tTP+AB1TPi1D0Imo3NC98lquq5mX2SDbpto25YBL0kXICCj64vRD1vP8A==
X-Received: by 2002:a17:902:ce8d:b0:234:8a4a:ad89 with SMTP id
 d9443c01a7336-23ac4e9784amr10003215ad.1.1750976896114; 
 Thu, 26 Jun 2025 15:28:16 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:15 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 01/10] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Thu, 26 Jun 2025 22:23:24 +0000
Message-ID: <20250626222743.1766404-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x62e.google.com
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

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 59 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  4 +++
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 64 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3914fa73b9..9a0f8bd2fc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -23,6 +23,7 @@
 #include "qemu/uuid.h"
 #include "system/hostmem.h"
 #include "qemu/range.h"
+#include "qapi/qapi-types-cxl.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -117,6 +118,8 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO    0x0
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3237,6 +3240,52 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h) */
+static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct {
+        uint8_t num_hosts;
+        uint8_t num_regions_supported;
+        uint8_t rsvd1[2];
+        uint16_t supported_add_sel_policy_bitmask;
+        uint8_t rsvd2[2];
+        uint16_t supported_removal_policy_bitmask;
+        uint8_t sanitize_on_release_bitmask;
+        uint8_t rsvd3;
+        uint64_t total_dynamic_capacity;
+        uint64_t region_blk_size_bitmasks[8];
+    } QEMU_PACKED *out = (void *)payload_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCRegion *region;
+    int i;
+
+    out->num_hosts = 1;
+    out->num_regions_supported = ct3d->dc.num_regions;
+    stw_le_p(&out->supported_add_sel_policy_bitmask,
+             BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE));
+    stw_le_p(&out->supported_removal_policy_bitmask,
+             BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE));
+    out->sanitize_on_release_bitmask = 0;
+
+    stq_le_p(&out->total_dynamic_capacity,
+             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        memcpy(&out->region_blk_size_bitmasks[i],
+               &region->supported_blk_size_bitmask,
+               sizeof(out->region_blk_size_bitmasks[i]));
+    }
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3350,6 +3399,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
+    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
+        cmd_fm_get_dcd_info, 0, 0 },
+};
+
 /*
  * While the command is executing in the background, the device should
  * update the percentage complete in the Background Command Status Register
@@ -3647,7 +3701,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+
     cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
+    }
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f283178d88..f608470362 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include <math.h>
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
@@ -634,6 +635,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     uint64_t region_len;
     uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
+    /* Only 1 block size is supported for now. */
+    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
     CXLDCRegion *region;
     MemoryRegion *mr;
     uint64_t dc_size;
@@ -679,6 +682,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .block_size = blk_size,
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
+            .supported_blk_size_bitmask = supported_blk_size_bitmask,
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c43a394ce1..1170ac58a3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -537,6 +537,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2


