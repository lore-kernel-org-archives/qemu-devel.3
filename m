Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0703CD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JD-0003kR-3y; Mon, 04 Nov 2024 16:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84J8-0003LT-58
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84J6-0005Sd-9t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hR+ACnXBxInDGsaK6RI1lemH57wgeYS/tmIS32BvoE=;
 b=NBjAOaVvHtVnkCxaAOKFIb8uGMexaoa9RLp4iw3exHjMhh4kKrqFLdVDw6UmdW4WKAhvVR
 TQFwTTo/xXamHjSV+NzzhgavTgkAmYMOaqkfhEG8Pio0EGkB2uexdyZ7JnYd/2Wht1tqyu
 Ok+8jFDEIsWR/AVPjsNThGdHRKRbUWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-llUoWFuFOLeemTAOw89cUw-1; Mon, 04 Nov 2024 16:08:14 -0500
X-MC-Unique: llUoWFuFOLeemTAOw89cUw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso29856085e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754493; x=1731359293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hR+ACnXBxInDGsaK6RI1lemH57wgeYS/tmIS32BvoE=;
 b=gX1p8GbZETSx2gGL5omFvAr/fOH8bi6rSFM1uWBc3Xc3ZstqzMG/MR2HqknE18Hj+6
 x5nERf5BoN8zH6gYoJ4ddTUqIRD++Clghn2tG4cQF8i7xeoq1GnaaxkC+jalrwkPzT+R
 5wsXo7gdUwaS7+afIwbJfnfsua9OeO2pudsv4VpZNoeJirk7Po8bl0mVCEuoHjefXazc
 a/6IH/RE7oNcIRSwY7lnKBJDc14naFRwUqZK7U8InX/pdsvWrRe4W5h49d+B1XLxu2IP
 AnGT85tUAnP0ZTti+GWINNMWf/N18ZSN43/NUC+QWUAM80FW7Vm9lQtXzH+YFAkDn8Hq
 9GFQ==
X-Gm-Message-State: AOJu0Yz4upiqLHxGZO+kU5qbFXCRW9WZoW7/dPgKKTuSsfVah0r0Nykj
 d+Anlr5vD8Xn653vL85T+c3iw265wT64a8KHmxOOnMDLlc44l/8bprefZsDMPjHO5P3GzgdcQIw
 8vFJx9gTHkHEv1wVIhiX+H5pwKEsedluWuvHQFNMYRLffxnr4SKkArigERTg9qK8aMwQsbzX5rr
 hDvp1IjwAUN6kTVyTnw2K+Tva/K8s3lg==
X-Received: by 2002:a5d:4b02:0:b0:37c:d183:a8f8 with SMTP id
 ffacd0b85a97d-3806113cfedmr25094721f8f.19.1730754492707; 
 Mon, 04 Nov 2024 13:08:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENF2S8LFp7vg+zKgY7podnNTHV8WgZiOkwvinKde2tNFfcP88gm6xhwxNY41b/Clfr7fRPNQ==
X-Received: by 2002:a5d:4b02:0:b0:37c:d183:a8f8 with SMTP id
 ffacd0b85a97d-3806113cfedmr25094700f8f.19.1730754492187; 
 Mon, 04 Nov 2024 13:08:12 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e565csm14118677f8f.48.2024.11.04.13.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:11 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 39/65] hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS
 control feature tables
Message-ID: <d1853190db5c59ad5b0537a2ac59c8d4494cbd98.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

ECS log capabilities field in following ECS tables, which is common for all
memory media FRUs in a CXL device.

Fix struct CXLMemECSReadAttrs and struct CXLMemECSWriteAttrs to make
log entry type field common.

Fixes: 2d41ce38fb9a ("hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature")
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241014121902.2146424-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 36 ++++++++++++++++++++++--------------
 hw/cxl/cxl-mailbox-utils.c  | 24 +++++++++---------------
 hw/mem/cxl_type3.c          |  9 ++++-----
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e14e56ae4b..561b375dc8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -463,18 +463,6 @@ typedef struct CXLMemPatrolScrubWriteAttrs {
 #define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
 
 /* CXL memory device DDR5 ECS control attributes */
-typedef struct CXLMemECSReadAttrs {
-        uint8_t ecs_log_cap;
-        uint8_t ecs_cap;
-        uint16_t ecs_config;
-        uint8_t ecs_flags;
-} QEMU_PACKED CXLMemECSReadAttrs;
-
-typedef struct CXLMemECSWriteAttrs {
-   uint8_t ecs_log_cap;
-    uint16_t ecs_config;
-} QEMU_PACKED CXLMemECSWriteAttrs;
-
 #define CXL_ECS_GET_FEATURE_VERSION    0x01
 #define CXL_ECS_SET_FEATURE_VERSION    0x01
 #define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
@@ -483,6 +471,26 @@ typedef struct CXLMemECSWriteAttrs {
 #define CXL_ECS_MODE_DEFAULT    0
 #define CXL_ECS_NUM_MEDIA_FRUS   3 /* Default */
 
+typedef struct CXLMemECSFRUReadAttrs {
+    uint8_t ecs_cap;
+    uint16_t ecs_config;
+    uint8_t ecs_flags;
+} QEMU_PACKED CXLMemECSFRUReadAttrs;
+
+typedef struct CXLMemECSReadAttrs {
+    uint8_t ecs_log_cap;
+    CXLMemECSFRUReadAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+} QEMU_PACKED CXLMemECSReadAttrs;
+
+typedef struct CXLMemECSFRUWriteAttrs {
+    uint16_t ecs_config;
+} QEMU_PACKED CXLMemECSFRUWriteAttrs;
+
+typedef struct CXLMemECSWriteAttrs {
+    uint8_t ecs_log_cap;
+    CXLMemECSFRUWriteAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+} QEMU_PACKED CXLMemECSWriteAttrs;
+
 #define DCD_MAX_NUM_REGION 8
 
 typedef struct CXLDCExtentRaw {
@@ -575,8 +583,8 @@ struct CXLType3Dev {
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
     /* ECS control attributes */
-    CXLMemECSReadAttrs ecs_attrs[CXL_ECS_NUM_MEDIA_FRUS];
-    CXLMemECSWriteAttrs ecs_wr_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+    CXLMemECSReadAttrs ecs_attrs;
+    CXLMemECSWriteAttrs ecs_wr_attrs;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3a93966e77..67041f45d3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1133,10 +1133,8 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                          (struct CXLSupportedFeatureEntry) {
                 .uuid = ecs_uuid,
                 .feat_index = index,
-                .get_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
-                                    sizeof(CXLMemECSReadAttrs),
-                .set_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
-                                    sizeof(CXLMemECSWriteAttrs),
+                .get_feat_size = sizeof(CXLMemECSReadAttrs),
+                .set_feat_size = sizeof(CXLMemECSWriteAttrs),
                 .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE,
                 .get_feat_version = CXL_ECS_GET_FEATURE_VERSION,
                 .set_feat_version = CXL_ECS_SET_FEATURE_VERSION,
@@ -1204,13 +1202,10 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
                (uint8_t *)&ct3d->patrol_scrub_attrs + get_feature->offset,
                bytes_to_copy);
     } else if (qemu_uuid_is_equal(&get_feature->uuid, &ecs_uuid)) {
-        if (get_feature->offset >=  CXL_ECS_NUM_MEDIA_FRUS *
-                                sizeof(CXLMemECSReadAttrs)) {
+        if (get_feature->offset >= sizeof(CXLMemECSReadAttrs)) {
             return CXL_MBOX_INVALID_INPUT;
         }
-        bytes_to_copy = CXL_ECS_NUM_MEDIA_FRUS *
-                        sizeof(CXLMemECSReadAttrs) -
-                            get_feature->offset;
+        bytes_to_copy = sizeof(CXLMemECSReadAttrs) - get_feature->offset;
         bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
         memcpy(payload_out,
                (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
@@ -1299,18 +1294,17 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         ecs_set_feature = (void *)payload_in;
         ecs_write_attrs = ecs_set_feature->feat_data;
-        memcpy((uint8_t *)ct3d->ecs_wr_attrs + hdr->offset,
+        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
                ecs_write_attrs,
                bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->ecs_attrs.ecs_log_cap = ct3d->ecs_wr_attrs.ecs_log_cap;
             for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
-                ct3d->ecs_attrs[count].ecs_log_cap =
-                                  ct3d->ecs_wr_attrs[count].ecs_log_cap;
-                ct3d->ecs_attrs[count].ecs_config =
-                                  ct3d->ecs_wr_attrs[count].ecs_config & 0x1F;
+                ct3d->ecs_attrs.fru_attrs[count].ecs_config =
+                        ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
             }
         }
     } else {
@@ -1324,7 +1318,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
             memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
-            memset(ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6911d13fe6..5cf754b38f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -920,16 +920,15 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
 
     /* Set default value for DDR5 ECS read attributes */
+    ct3d->ecs_attrs.ecs_log_cap = CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
     for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
-        ct3d->ecs_attrs[count].ecs_log_cap =
-                            CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
-        ct3d->ecs_attrs[count].ecs_cap =
+        ct3d->ecs_attrs.fru_attrs[count].ecs_cap =
                             CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
-        ct3d->ecs_attrs[count].ecs_config =
+        ct3d->ecs_attrs.fru_attrs[count].ecs_config =
                             CXL_ECS_THRESHOLD_COUNT_DEFAULT |
                             (CXL_ECS_MODE_DEFAULT << 3);
         /* Reserved */
-        ct3d->ecs_attrs[count].ecs_flags = 0;
+        ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
     }
 
     return;
-- 
MST


