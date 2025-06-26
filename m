Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F5FC7EE33
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5M-0006QF-MY; Thu, 26 Jun 2025 18:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv5I-0006OM-1X
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv56-0000tx-Sf
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23633a6ac50so22416695ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976909; x=1751581709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNzdswBVnpQdWNT16OCETeREezHNIv1SZz5MkHcTEn8=;
 b=UMs60P+xLmvhP7TzHDhN8Kmw0jftpLbvVUjd8bkIGJLOq/1JADpW6/NJsbRTxYd64Y
 djm3DHmVAYWEmIf6TrX8LLzly5FBVEwCSxcTOfoTEIYEU1eW0PmwQnFCVKKM05tmfQxk
 WSB2Gp9Nbm+f55Z8XPbIf3sBN8UZT91j2tUvVOUWYLNKyVKE8AhKh+x/0CeMBdXgcOKH
 MngROsW6rIv1C4ip/0qfWkZh8x/DlxUk9jBZvmY4grgGDAhRUCNjSus0RjTIDjtpJIX6
 9mrB9ZBKnURgjluAKQZlyK729feXXKmtN9htuCAkWVj3bm+rcAi5d6kAYqsKnZ3TztB5
 TQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976909; x=1751581709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNzdswBVnpQdWNT16OCETeREezHNIv1SZz5MkHcTEn8=;
 b=hil66k/VYkp7nMqOIxYX33zLQwn4G+K4K9qS2dy+10tnYcBgt7GNYjFr1Je2MV3qP6
 WX3BwlxG43my5H55/rBjnmb4sd1KJo2ZNj6XtD6CHzLqt1c2O7r36QXKq3F9vz92eX/U
 +v9CiHcow8wClvlhupwQXs9mxHN3nTYgIpZ0/zeiYFO4+YBrtL/MFUDXv6jK28uQ+dDe
 zfZyGE/m7+z3m0gXUlRB2eUG8p39vHaXgVoNyeAgtIRFVSKkwiANqP7itp8FLjyoSF8G
 l772kXF+DWk2RPgb2mECAUAnl1sumtiwY4yzJY2rYJ9KYZLsfPWhO3LwH7UUG0ZSfKf4
 69cg==
X-Gm-Message-State: AOJu0YwUgW7CfMToWyXvQ496lHg2lcMf75y5GVea5EXlHQT8TSYOvY5B
 iQeVEFjyQeGFmF93atXqxVLvL2OChAjttFdcou7ey60PUZ8723x9Tcx+iVyp6Q==
X-Gm-Gg: ASbGncv5wTAEEAPjknOJ2RC9TzffFAyfFh3wSJ/XffGDve2PlIKzTAQkYevehVlNsuG
 IMiuRYiqO+KnaTSs3KGVhwfQoy2TKN0v8RcxhqYBYOSqRe+1g4+BoxseALcKQWFDOWwRNOiMmjy
 URkLv+eBkCDcFXQGwIH0jTeYYF3H2aVZzrmEk5VH+BBvNaA5mQ+d9lHJixrELoUwytvElmwPnbR
 GCISzPWBrK2oF7xU0hbOjgAgjdg+XluCmMlO6aVlJJNSqc08beJe76KcpRIC0rk+AIENRDxvAb3
 Zg8yeIUG6fZMIfHfoEfyX8Z7oVPsmxpAlnr1NqojGylM1pSP+4wwPRfg3Dq02rC6XbLU7iJBC6E
 Su3YlqvEZ3J9eY9Nkrg==
X-Google-Smtp-Source: AGHT+IEoLN21IQhU3rd/hGmCc35DGpKEcYEcpyldg1wX32m6cPlhGIDY4ch+t8LStiJysEhJ+nzDOA==
X-Received: by 2002:a17:902:ce11:b0:235:5a9:976f with SMTP id
 d9443c01a7336-23ac462451bmr16428175ad.24.1750976909069; 
 Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:28 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 08/10] hw/cxl: create helper function to create DC
 Event Records from extents
Date: Thu, 26 Jun 2025 22:23:31 +0000
Message-ID: <20250626222743.1766404-9-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 -
 hw/mem/cxl_type3.c          | 37 +-----------------------------------
 include/hw/cxl/cxl.h        |  1 +
 include/hw/cxl/cxl_device.h |  4 ++++
 5 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..724055f2cf 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -260,3 +260,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
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
index e3d54ed124..382c41c025 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -27,7 +27,6 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
-#define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
 #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
 #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ee554a77be..9c2b9d197b 100644
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
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..3ae4303383 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -23,6 +23,7 @@
 #define CXL_DEVICE_REG_BAR_IDX 2
 
 #define CXL_WINDOW_MAX 10
+#define CXL_NUM_EXTENTS_SUPPORTED 512
 
 typedef struct PXBCXLDev PXBCXLDev;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 82e3bc1a71..91ec1ba299 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -732,4 +732,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count);
 #endif
-- 
2.47.2


