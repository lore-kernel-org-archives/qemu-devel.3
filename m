Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100D7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMg-0004Na-O3; Mon, 14 Jul 2025 19:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJb-00062M-OA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJZ-0006Fc-HF
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0m37+PZCmQcuLfhICj493rD4h2Afg7fkrW07waZNyQ=;
 b=XbRMCctHUxoxypWf/gK18a+SvJnZ0p/RqsY/pN/5hhCpyZEY6Vfic0zhmszSHgKmgCQeUc
 Kx+wDP8zwFb0YeK3cQAXfgNimKC+O4alDW9G/leZasLMTw9Le0m8x1K4klk/Tii+k0g8TL
 NL1U44e2xhNwJpOgnTO6iNSNdhnQDrM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-PsUkX43LNFe47d7Shls4HA-1; Mon, 14 Jul 2025 19:10:27 -0400
X-MC-Unique: PsUkX43LNFe47d7Shls4HA-1
X-Mimecast-MFC-AGG-ID: PsUkX43LNFe47d7Shls4HA_1752534626
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4e9252ba0so2841406f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534626; x=1753139426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0m37+PZCmQcuLfhICj493rD4h2Afg7fkrW07waZNyQ=;
 b=pCRGYm+emAK7zMsu4xZf8JrtZiMV1T/E2ZSOs2J2DnyVA0G+22b1plcjuW8PN+Y6WC
 h7JGM8ZjDfopMjU5g/lN8DO0VbYPaxbx2w+a6HtSxdGQmoTnsZZ0WhHWBICMeJ8Qw+XW
 sUF8RvnTGBZEX186gYKRaq4cD0OUr6iO/KWlLQQNVLm86/ej9kSmrt55LRKfskj0aOrT
 eHicOvbCQSQot7AXmhCHEwHxvP0m1+YVwLlYKA5UeARDbSRayHHGJXHfcpBbgf30HreO
 SvM/rPlqqyPLhSN71VE+kRACADs0sU8Qld1Yh7kxVxdSieznq40s5aR6lkZkteskaAAN
 72KA==
X-Gm-Message-State: AOJu0YyEq5VYqBW+UrFtS3ECIdGrbVpYmJbXgD8qRPmexcpoTY4tRON4
 7mPFK/OcjVzF0unw8fiBaxkWr63cwhAr+xfMag08jH0JZLZtJZME29+mm2ISqwACuN59erl+6sS
 HokROg+a9IEdjMvlmNM6HsUsMRa2iJNOG6trBL6H2lFvbAmqspBnDUN7TmR/O+DmlaSQIusGiSa
 EtCHlzeSZVQleLXSgh+ZO29wlrdNeDBpEBdQ==
X-Gm-Gg: ASbGncuDr6e7XchIFqFTTfAwb/3RapRj1EzP0kUK+r9GCGmFfvO2kNpx9vblkvdQXQI
 J6YbgdtpU2vc+mCGY8jraV9b3k2pcR9nDXRhvnYryWVhyqf3O5o2sOVu0jvV1zfE/gE9lOJ8Z8K
 8KIZ0oz1J63pC4utb1cYshOQk2/PTAFSe3g+cM6kRyDr+RoxwXvxkH+AJtSGFtlP7qkdsW2Z/JV
 Pi0at6DSq2y20EBSuHosPIjnT9kiinYASoYEu9b7dlsDWMZY+Saa2sV8IrPTZbzwruKxm+Tot8v
 iXeiYqIMRGy9KELbSZNN2VrAGqSWDwgw
X-Received: by 2002:a05:6000:5c7:b0:3a5:2ec5:35a9 with SMTP id
 ffacd0b85a97d-3b5f187d0fdmr13843150f8f.3.1752534626118; 
 Mon, 14 Jul 2025 16:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4t5UPCpWXssI1Ii0D+6BchN4PPATmCF2ZjxNozGg0QpMhZe6BjQk2Fv3qdPrFq49pj5QFxw==
X-Received: by 2002:a05:6000:5c7:b0:3a5:2ec5:35a9 with SMTP id
 ffacd0b85a97d-3b5f187d0fdmr13843130f8f.3.1752534625612; 
 Mon, 14 Jul 2025 16:10:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562797af47sm1210035e9.3.2025.07.14.16.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:24 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 95/97] hw/cxl: Create helper function to create DC Event
 Records from extents
Message-ID: <062e3341472aa54f22eaf316ba01aec0f8f49a1f.1752534227.git.mst@redhat.com>
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

Prepatory patch for following FMAPI Add/Release Patches. Refactors part
of qmp_cxl_process_dynamic_capacity_prescriptive() into a helper
function to create DC Event Records and insert in the event log.

Moves definition for CXL_NUM_EXTENTS_SUPPORTED to cxl.h so it can be
accessed by cxl-mailbox-utils.c and cxl-events.c, where the helper
function is defined.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-10-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl.h        |  1 +
 include/hw/cxl/cxl_device.h |  4 ++++
 hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 -
 hw/mem/cxl_type3.c          | 37 +-----------------------------------
 5 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index de66ab8c35..998f495a98 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -23,6 +23,7 @@
 #define CXL_DEVICE_REG_BAR_IDX 2
 
 #define CXL_WINDOW_MAX 10
+#define CXL_NUM_EXTENTS_SUPPORTED 512
 
 typedef struct PXBCXLDev PXBCXLDev;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c836fc17f0..71a5834c3d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count);
 #endif
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index f90470930d..7583dd9162 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -258,3 +258,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
         }
     }
 }
+
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count)
+{
+    CXLEventDynamicCapacity event_rec = {};
+    int i;
+
+    cxl_assign_event_header(&event_rec.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(event_rec),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    event_rec.type = type;
+    event_rec.validity_flags = 1;
+    event_rec.host_id = 0;
+    event_rec.updated_region_id = 0;
+    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
+                              ct3d->dc.total_extent_count;
+
+    for (i = 0; i < ext_count; i++) {
+        memcpy(&event_rec.dynamic_capacity_extent,
+               &extents[i],
+               sizeof(CXLDCExtentRaw));
+        event_rec.flags = 0;
+        if (i < ext_count - 1) {
+            /* Set "More" flag */
+            event_rec.flags |= BIT(0);
+        }
+
+        if (cxl_event_insert(&ct3d->cxl_dstate,
+                             CXL_EVENT_TYPE_DYNAMIC_CAP,
+                             (CXLEventRecordRaw *)&event_rec)) {
+            cxl_event_irq_assert(ct3d);
+        }
+    }
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4b0fdbbdd8..b6f30e8689 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -28,7 +28,6 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
-#define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
 #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
 #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4a45b4510e..4e975b1a42 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1957,15 +1957,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
-    CXLEventDynamicCapacity dCap = {};
-    CXLEventRecordHdr *hdr = &dCap.hdr;
     CXLType3Dev *dcd;
-    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
     CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
-    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
     uint64_t dpa, offset, len, block_size;
     g_autofree unsigned long *blk_bitmap = NULL;
     int i;
@@ -2078,38 +2074,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         dcd->dc.total_extent_count += num_extents;
     }
 
-    /*
-     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
-     *
-     * All Dynamic Capacity event records shall set the Event Record Severity
-     * field in the Common Event Record Format to Informational Event. All
-     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
-     * Event Log.
-     */
-    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
-
-    dCap.type = type;
-    /* FIXME: for now, validity flag is cleared */
-    dCap.validity_flags = 0;
-    stw_le_p(&dCap.host_id, hid);
-    /* only valid for DC_REGION_CONFIG_UPDATED event */
-    dCap.updated_region_id = 0;
-    for (i = 0; i < num_extents; i++) {
-        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
-               sizeof(CXLDCExtentRaw));
-
-        dCap.flags = 0;
-        if (i < num_extents - 1) {
-            /* Set "More" flag */
-            dCap.flags |= BIT(0);
-        }
-
-        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
-                             (CXLEventRecordRaw *)&dCap)) {
-            cxl_event_irq_assert(dcd);
-        }
-    }
+    cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
 }
 
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
-- 
MST


