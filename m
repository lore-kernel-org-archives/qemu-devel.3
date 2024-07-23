Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F21C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDC2-00021n-91; Tue, 23 Jul 2024 06:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDC0-0001o7-IM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBy-0001ho-EN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+b3iGPXHzRDxcu2/iYzWpqXB4BTdAoJBt36m9nCwv4=;
 b=XKBCha1/Vx1viC3nZvFtN82qZt9w1cICXD5dYKoT69mg8vph1FZ+EcMRPwMNy+B5J6I5Ib
 tS+ID6QpNq9rTS0H9yOaveS2Xu+k3ZGhRkNusLbxQ7HJkLyo0v/h8xGJgJUMV6XVSr3Bo0
 nR1rB4AdJv30bl1NM5mENiFCy/A/Sxw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-VXAP5w-ENFuZjmlymlYmOQ-1; Tue, 23 Jul 2024 06:56:24 -0400
X-MC-Unique: VXAP5w-ENFuZjmlymlYmOQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a77e024eaa4so457986066b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732182; x=1722336982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+b3iGPXHzRDxcu2/iYzWpqXB4BTdAoJBt36m9nCwv4=;
 b=E7aVas9steL2wTcezKaX9feuGKs6qjLicjHc9i4iCFLo5sFZTSfsfqPLyrS8QGh0RY
 M+ELfEm+Bbuh3OpY45gX30+oTKhGUic5C4D1MEHKitCRQWq6PaXK9thxWGt5s/cURa82
 FRArdw6PB+P2igAB9GkYQP6Wa+PL/4alzzEANVrS7OkDDhVJJQt33MgUzgWvi2QLZEiY
 tcaHFB7hdoQpeom4QkRKQSp72nn2nDv8odoUbQDuOnbDjVLnWn8i5O8UuGC5MIcNJ0m4
 8tC3+pEw1bpueniCRIlI785ioN9loBb1639hB3T8RFxJLUWmeCJ3saB5gxfNkS07S61+
 oGtw==
X-Gm-Message-State: AOJu0YxiHEyyMNgrLjGS/4XOqRLcqpfxOV/dMflHyyE33/GXN+5RfruY
 8GDz+XNXLttHLPphmzgKn4uwNSf1Y21+NNLQ78blyHiDBmu2+UEByQWt/NfcojwDu3oFZFQesJZ
 AmHlQLgyCnc2xj+A+wLUDDVX8kG+x+qSDvrUfOrS3rI73WyRZH60oFLAnElCHzqVdaU35evaKzP
 uAxtgXnZtHNgMdqO1GeLviFghkZ9Vk0w==
X-Received: by 2002:a17:906:dc8f:b0:a77:bf32:b91e with SMTP id
 a640c23a62f3a-a7a8847a781mr214491866b.49.1721732182383; 
 Tue, 23 Jul 2024 03:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ3zodNmP4n7W4iHdyxeYC4wWlOHBzHMcdXJQSd3ngCCD8gBPkF6cxCiSHfczMzDc0GifvPg==
X-Received: by 2002:a17:906:dc8f:b0:a77:bf32:b91e with SMTP id
 a640c23a62f3a-a7a8847a781mr214488766b.49.1721732181665; 
 Tue, 23 Jul 2024 03:56:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785c6csm522830766b.20.2024.07.23.03.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:56:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 13/61] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Message-ID: <2d41ce38fb9af3e66f85c8b8f9c3f83148c3d549.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts. The ECS control feature
allows the request to configure ECS input configurations during system
boot or at run-time.

The ECS control allows the requester to change the log entry type, the ECS
threshold count provided that the request is within the definition
specified in DDR5 mode registers, change mode between codeword mode and
row count mode, and reset the ECS counter.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Link: https://lore.kernel.org/r/20240223085902.1549-4-shiju.jose@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705123039.963781-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 24 +++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 14 ++++++++
 3 files changed, 109 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 2c1df25453..5cae7159e6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -447,6 +447,27 @@ typedef struct CXLMemPatrolScrubWriteAttrs {
 #define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
 #define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
 
+/* CXL memory device DDR5 ECS control attributes */
+typedef struct CXLMemECSReadAttrs {
+        uint8_t ecs_log_cap;
+        uint8_t ecs_cap;
+        uint16_t ecs_config;
+        uint8_t ecs_flags;
+} QEMU_PACKED CXLMemECSReadAttrs;
+
+typedef struct CXLMemECSWriteAttrs {
+   uint8_t ecs_log_cap;
+    uint16_t ecs_config;
+} QEMU_PACKED CXLMemECSWriteAttrs;
+
+#define CXL_ECS_GET_FEATURE_VERSION    0x01
+#define CXL_ECS_SET_FEATURE_VERSION    0x01
+#define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
+#define CXL_ECS_REALTIME_REPORT_CAP_DEFAULT    1
+#define CXL_ECS_THRESHOLD_COUNT_DEFAULT    3 /* 3: 256, 4: 1024, 5: 4096 */
+#define CXL_ECS_MODE_DEFAULT    0
+#define CXL_ECS_NUM_MEDIA_FRUS   3 /* Default */
+
 #define DCD_MAX_NUM_REGION 8
 
 typedef struct CXLDCExtentRaw {
@@ -534,6 +555,9 @@ struct CXLType3Dev {
     /* Patrol scrub control attributes */
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
+    /* ECS control attributes */
+    CXLMemECSReadAttrs ecs_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+    CXLMemECSWriteAttrs ecs_wr_attrs[CXL_ECS_NUM_MEDIA_FRUS];
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 485beb9dba..0621f686f4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -825,6 +825,7 @@ typedef struct CXLSupportedFeatureEntry {
 
 enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_PATROL_SCRUB = 0,
+    CXL_FEATURE_ECS,
     CXL_FEATURE_MAX
 };
 
@@ -877,6 +878,20 @@ typedef struct CXLMemPatrolScrubSetFeature {
         CXLMemPatrolScrubWriteAttrs feat_data;
 } QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
 
+/*
+ * CXL r3.1 section 8.2.9.9.11.2:
+ * DDR5 Error Check Scrub (ECS) Control Feature
+ */
+static const QemuUUID ecs_uuid = {
+    .data = UUID(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba,
+                 0xb9, 0x69, 0x1e, 0x89, 0x33, 0x86)
+};
+
+typedef struct CXLMemECSSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemECSWriteAttrs feat_data[];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemECSSetFeature;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -930,6 +945,23 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                     CXL_FEAT_ENTRY_SFE_CEL_VALID,
             };
             break;
+        case  CXL_FEATURE_ECS:
+            /* Fill supported feature entry for device DDR5 ECS control */
+            get_feats_out->feat_entries[entry++] =
+                         (struct CXLSupportedFeatureEntry) {
+                .uuid = ecs_uuid,
+                .feat_index = index,
+                .get_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(CXLMemECSReadAttrs),
+                .set_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(CXLMemECSWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE,
+                .get_feat_version = CXL_ECS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_ECS_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         default:
             __builtin_unreachable();
         }
@@ -989,6 +1021,18 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                (uint8_t *)&ct3d->patrol_scrub_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &ecs_uuid)) {
+        if (get_feature->offset >=  CXL_ECS_NUM_MEDIA_FRUS *
+                                sizeof(CXLMemECSReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = CXL_ECS_NUM_MEDIA_FRUS *
+                        sizeof(CXLMemECSReadAttrs) -
+                            get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1009,10 +1053,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
     CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
     CXLMemPatrolScrubSetFeature *ps_set_feature;
+    CXLMemECSWriteAttrs *ecs_write_attrs;
+    CXLMemECSSetFeature *ecs_set_feature;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
+    uint16_t count;
 
 
     if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
@@ -1062,6 +1109,28 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             ct3d->patrol_scrub_attrs.scrub_flags |=
                           ct3d->patrol_scrub_wr_attrs.scrub_flags & 0x1;
         }
+    } else if (qemu_uuid_is_equal(&hdr->uuid,
+                                  &ecs_uuid)) {
+        if (hdr->version != CXL_ECS_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ecs_set_feature = (void *)payload_in;
+        ecs_write_attrs = ecs_set_feature->feat_data;
+        memcpy((uint8_t *)ct3d->ecs_wr_attrs + hdr->offset,
+               ecs_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
+                ct3d->ecs_attrs[count].ecs_log_cap =
+                                  ct3d->ecs_wr_attrs[count].ecs_log_cap;
+                ct3d->ecs_attrs[count].ecs_config =
+                                  ct3d->ecs_wr_attrs[count].ecs_config & 0x1F;
+            }
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1072,6 +1141,8 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
         if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
             memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
+            memset(ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7c583d80f5..d648192ab9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -844,6 +844,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     uint8_t *pci_conf = pci_dev->config;
     unsigned short msix_num = 6;
     int i, rc;
+    uint16_t count;
 
     QTAILQ_INIT(&ct3d->error_list);
 
@@ -917,6 +918,19 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                            (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
     ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
 
+    /* Set default value for DDR5 ECS read attributes */
+    for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
+        ct3d->ecs_attrs[count].ecs_log_cap =
+                            CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
+        ct3d->ecs_attrs[count].ecs_cap =
+                            CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
+        ct3d->ecs_attrs[count].ecs_config =
+                            CXL_ECS_THRESHOLD_COUNT_DEFAULT |
+                            (CXL_ECS_MODE_DEFAULT << 3);
+        /* Reserved */
+        ct3d->ecs_attrs[count].ecs_flags = 0;
+    }
+
     return;
 
 err_release_cdat:
-- 
MST


