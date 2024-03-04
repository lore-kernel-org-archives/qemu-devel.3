Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AD6C54E55
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEEh-0005WN-Ey; Mon, 04 Mar 2024 14:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEf-0005VR-1y
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:29 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEW-0006wX-Jn
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:28 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-607c5679842so48932017b3.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581459; x=1710186259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8lPD938tgQqBzbyLXCNS0GDAHx1dZoU8O4sZyz4+ao=;
 b=Y66kDvOWkiZH98Cxn30Z8/RKSgR67scwQ6Nppy2EdP14DY8aZuQGFOA01dM5N6/y0l
 q7b4sLfWqe+unM5bjStTJNyShfDbyqRKdwptSt3UIqOc1ZZGggtvX5Lihc8UJfxRRFpS
 LJh86TULZbpL9WeMg0FvodBm0XFgyyo8l6SU5p6qI6Osn26YjLZclTAeP4KOynfM22Xn
 flBj9qovCAPAtCYjS2b4ZvAkmLEyvorSc7jHdfXo5YsZdKubFRBJ3Y6X0oKYvPm5mX1C
 Kcmfetj7DlFLD/AXzHoJ2YDCsYhXbEN1Bzz8P1DzBwTf+MQHu3Ph7nJOxnfrEjhRC8pw
 coAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581459; x=1710186259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8lPD938tgQqBzbyLXCNS0GDAHx1dZoU8O4sZyz4+ao=;
 b=ggYmC+PZDy5NLy/EMSe6r5QPp5x/lcH/+DfAtKcMVhjPp/xDO6yEExooNpV3UTooZH
 2f47j68wpJ2wYrfOpMWWj/nJwr2RYFIrTtSxqOSZD65EDn8e5KyD4oJC3IjacDWlDGym
 Kp3C5gbqZFtzBGYOn59FDyRV6ERmrkR1zMDvub4KUxjq+GyYPE/xYGurW1slsaSRgHME
 QDHqUKf7u/HgBoQ2XmE/pF1KtrUCF8O07uX73bWUJ7+DwvTUaz0i16/Qevv96Wv09Ez+
 lRhUldCyJuwKcJQgMW4nNSimHhdmgcQHoeZUcKVqmF8sR8jSA6lr3D5uR18RRiTIQTqa
 uyrw==
X-Gm-Message-State: AOJu0Yx6R+Wk8P+1nq7AsdkDCtXL6G05SrE4ZlFAfWH7VoBVlXCSy/Gx
 HJ4Gj6q8EaYQybfkdM87NpUZNsvZdWGxuV/yD/hckHt2Rj5QcmNh1C5zPyUk
X-Google-Smtp-Source: AGHT+IGMxwD7M3abEPAmA4B7Id72YrzI5ZSRaZbmHCQNrQ/PXng4IFuOLlXZLROHo70LffTiLhR0wg==
X-Received: by 2002:a25:5f48:0:b0:dbf:6267:eba4 with SMTP id
 h8-20020a255f48000000b00dbf6267eba4mr7589407ybm.27.1709581458654; 
 Mon, 04 Mar 2024 11:44:18 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:18 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 07/13] hw/mem/cxl_type3: Add DC extent list representative
 and get DC extent list mailbox support
Date: Mon,  4 Mar 2024 11:34:02 -0800
Message-ID: <20240304194331.1586191-8-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
CXLType3Dev and add get DC extent list mailbox command per
CXL.spec.3.1:.8.2.9.9.9.2.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 71 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 22 ++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8309f27a2b..425b378a2c 100644
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
@@ -1325,7 +1326,8 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
      * to use.
      */
     stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
-    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
     stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
     stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
 
@@ -1333,6 +1335,70 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
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
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    uint16_t out_pl_len;
+    uint32_t start_extent_id = in->start_extent_id;
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);
+            stq_le_p(&out->records[record_done].len, ent->len);
+            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
+            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
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
@@ -1380,6 +1446,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2b380a260b..102fa8151e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -673,6 +673,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return true;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 265679302c..8148bcc34b 100644
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
@@ -470,6 +489,9 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCExtentList extents;
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
-- 
2.43.0


