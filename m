Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E95C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACZP-0006gA-7Q; Thu, 23 May 2024 13:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYo-00060t-HT
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:08 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYk-0003fY-D0
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so122445865ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716486532; x=1717091332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3Dkdm32lp5f6RMYNOcQ/PPZ87Y6R6yDh0BiQEry7hs=;
 b=KaiPSwOc32A56JNqi2ukGOXalOkVuYBw7HF1L7KnZikOCrorhbk4cHKXwgWs5P7C4T
 DMTcIqmx3bTFATtbN7ezyYGpIxx5+sG94inJBqKcz6Da2fHIyKq0Ctf7ilZGJJc2sQcF
 8Q49Ic5WpJSD1iQTETUAMW1RJNGP8Vyn1tLEdE5qYHNX8zqe1muAubWDNt1CiOcT8YZa
 sXxJv65bZKLcF0dDUqTac5r/ovanAL8KxhYq+6d6zWd1axvkf1iELQOQYwHZFyJWVU6B
 eXH8EkwNjGb2Fo55qKZaq+fUaqbWdCnU6/al894ZsG+SPXe6LADp5eNsJAuXgp+AdVGF
 eD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486532; x=1717091332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3Dkdm32lp5f6RMYNOcQ/PPZ87Y6R6yDh0BiQEry7hs=;
 b=ApFTnHmKJRD7JpoIBMizFcgmqOqeuk1h4zAle3/cmkNhFYYCkF+1WxPyl5UrSs106W
 OQykB3D0Nf1AdQcTn5QEgZAgLXj2yc/bmfD730lCcg2KbmQOiKizFApCGfGtto0Qqi8B
 rnpmcirGDZRzFACpOg6zPFQpmSt0VWVFCCVTWwXgAqzFF6nwxvIy2yBhlFuJPgS7bubX
 pQnEl+O2q+2x0j2xsPIXSOPTz7ueUk8V4pqs7kvW+WyMLwP+ZfxAgKgQ0Rlwp1U6lgJC
 iNbZergssapTsC0DDE2jvZ69a6zQ5NljHNQZj++uBXCruoodfHcCJQg44+uT+mJZOKfO
 J/KA==
X-Gm-Message-State: AOJu0Yxp7xcxwUgZ504qMnJpBcuB//FRggsWpKTz7cXohXXQ7Ekql4T1
 ZGxqv+WA8LEgg9yAyvhrri6K4M8rqc4m4ycnT3URXdj+y4qs4XsewiswOg==
X-Google-Smtp-Source: AGHT+IGe9DW+u5d7YhtV2coNCHdsuIuR4Bqp6Ytu8BryQ+8TGFuT5OoaEd8kf5HHcxnPPNVRtLlf1w==
X-Received: by 2002:a17:902:e892:b0:1eb:d7ce:1946 with SMTP id
 d9443c01a7336-1f4497e5828mr430865ad.52.1716486532351; 
 Thu, 23 May 2024 10:48:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:48:52 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, armbru@redhat.com, mst@redhat.com,
 Fan Ni <fan.ni@samsung.com>, Svetly Todorov <svetly.todorov@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 09/14] hw/mem/cxl_type3: Add DC extent list representative
 and get DC extent list mailbox support
Date: Thu, 23 May 2024 10:44:49 -0700
Message-ID: <20240523174651.1089554-10-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62e.google.com
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

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and implement get DC extent list mailbox command per
CXL.spec.3.1:.8.2.9.9.9.2.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 73 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 22 +++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 831cef0567..1915959015 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -84,6 +84,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1322,7 +1323,8 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
      * to use.
      */
     stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
-    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
     stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
     stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
 
@@ -1330,6 +1332,72 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.9.2:
+ * Get Dynamic Capacity Extent List (Opcode 4801h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len_in,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct {
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint32_t count;
+        uint32_t total_extents;
+        uint32_t generation_num;
+        uint8_t rsvd[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    uint32_t start_extent_id = in->start_extent_id;
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    uint16_t out_pl_len, size;
+    CXLDCExtent *ent;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+    size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        CXLDCExtentRaw *out_rec = &out->records[record_done];
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1377,6 +1445,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f645a3f2e9..f6ab885270 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -672,6 +672,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return true;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c2c3df0d2a..6aec6ac983 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -424,6 +424,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_NUM_REGION 8
 
+typedef struct CXLDCExtentRaw {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtentRaw;
+
+typedef struct CXLDCExtent {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+
+    QTAILQ_ENTRY(CXLDCExtent) node;
+} CXLDCExtent;
+typedef QTAILQ_HEAD(, CXLDCExtent) CXLDCExtentList;
+
 typedef struct CXLDCRegion {
     uint64_t base;       /* aligned to 256*MiB */
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -474,6 +493,9 @@ struct CXLType3Dev {
          * memory region size.
          */
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCExtentList extents;
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
-- 
2.43.0


