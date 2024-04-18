Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F23C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 23:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxbD8-00034G-8I; Thu, 18 Apr 2024 19:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCn-0002vh-9Y
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCk-0005sQ-2d
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:12 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so1449963b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713483006; x=1714087806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAys60q15bX2FDoPastpCKCHWQud2bcFghMDEoFsPeo=;
 b=echszMTrnOeYJ8HA4JRj5EvSULVBHBVSCL+sq73HB6lrtIJPOHhJ0S8pJB4M170IQ0
 vwgMtwaL/vainhz+zdWenbDuYpcNmxDLUFa7OgogJS043pb4ZcMzfWvkaVrZAkNTdUx2
 Dn7W1pItipMVKK1aQyhsAkQYD4Ee5UgI/9vHwk6g2FTW9S8DX8UhcuNhVs+C7QTtVSLs
 sIYu/SyI3KRpkj/x9uKZK5o3O6iDhj7GAF5X9IKBAGO6yziZHWIN+b9yX7ZNSdEHAk61
 51gKYu6bDxBjp/d5tBIh8V6FR8WJv6qDPTWT6ulJL+jfRDv1KRSXf9Mry2NZMh7HdRua
 VmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713483006; x=1714087806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAys60q15bX2FDoPastpCKCHWQud2bcFghMDEoFsPeo=;
 b=kTAOi0sWgyW/bD/SyRtU64lVfKhCYaSx/G5qleaaDDwSQDu/TXU7iEF8kYa2/+xBMJ
 cqXrfVwB954rZpcOGRSl1yAvFNWxcfh9VAZvBpqGVROnYtLZyew/5UQnwQV59HO1D/yC
 MoPrtm5sLa6Qv2TOKsaozOa+B++mMBW5kDOvUbYrilqncOrHoFORfbBfee5ZwoWbEI0U
 edOqRTqHCZqo61OB351itwV3MIQNEHHp5SmmI/M07E0d3fOAKa1rWgq3WuQDeXVsaWeL
 Ew8PixV/KyihcHUqr8/UPWcpHyS2Og09Ply8R6VwItol90BSWLOCRcyLz5eodtm0yPSG
 KB/w==
X-Gm-Message-State: AOJu0YxoEs0sui8Y5DD8jjuHo6MvdYF8YU9i1eTbSE1d1Iomqu+aJUau
 SCL5wSDU8R6nh2GaAKisFpO53TuE3hWNkW480vJX2KMuhYrBsGI5B4iiAg==
X-Google-Smtp-Source: AGHT+IH71h5HXU7UEOIDmxSsT9ALHXKk/ZgkOabosSJEp4T4jkfwimaHu3SvhuUftZxT7JeDT5WImg==
X-Received: by 2002:a05:6a00:3d04:b0:6ea:c4e5:a252 with SMTP id
 lo4-20020a056a003d0400b006eac4e5a252mr691623pfb.5.1713483006087; 
 Thu, 18 Apr 2024 16:30:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 16:30:05 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 02/12] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Date: Thu, 18 Apr 2024 16:10:53 -0700
Message-ID: <20240418232902.583744-3-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x431.google.com
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

Per cxl spec r3.1, add dynamic capacity region representative based on
Table 8-165 and extend the cxl type3 device definition to include DC region
information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: we store region decode length as byte-wise length on the device, which
should be divided by 256 * MiB before being returned to the host
for "Get Dynamic Capacity Configuration" mailbox command per
specification.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 96 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 16 +++++++
 2 files changed, 112 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ba1d9901df..49c7944d93 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -22,6 +22,8 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
+#define CXL_NUM_EXTENTS_SUPPORTED 512
+#define CXL_NUM_TAGS_SUPPORTED 0
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -80,6 +82,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1238,6 +1242,88 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
+ * (Opcode: 4800h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct {
+        uint8_t region_cnt;
+        uint8_t start_rid;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint8_t num_regions;
+        uint8_t regions_returned;
+        uint8_t rsvd1[6];
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint32_t dsmadhandle;
+            uint8_t flags;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    struct {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED *extra_out;
+    uint16_t record_count;
+    uint16_t i;
+    uint16_t out_pl_len;
+    uint8_t start_rid;
+
+    start_rid = in->start_rid;
+    if (start_rid >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    extra_out = (void *)(payload_out + out_pl_len);
+    out_pl_len += sizeof(*extra_out);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    out->num_regions = ct3d->dc.num_regions;
+    out->regions_returned = record_count;
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                 ct3d->dc.regions[start_rid + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                 ct3d->dc.regions[start_rid + i].decode_len /
+                 CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                 ct3d->dc.regions[start_rid + i].len);
+        stq_le_p(&out->records[i].block_size,
+                 ct3d->dc.regions[start_rid + i].block_size);
+        stl_le_p(&out->records[i].dsmadhandle,
+                 ct3d->dc.regions[start_rid + i].dsmadhandle);
+        out->records[i].flags = ct3d->dc.regions[start_rid + i].flags;
+    }
+    /*
+     * TODO: Assign values once extents and tags are introduced
+     * to use.
+     */
+    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1282,6 +1368,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
+    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
+        cmd_dcd_get_dyn_cap_config, 2, 0 },
+};
+
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
@@ -1487,7 +1578,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+
     cxl_copy_cci_commands(cci, cxl_cmd_set);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_dcd);
+    }
     cci->d = d;
 
     /* No separation for PCI MB as protocol handled in PCI device */
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a5f8e25020..e839370266 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -422,6 +422,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+#define DCD_MAX_NUM_REGION 8
+
+typedef struct CXLDCRegion {
+    uint64_t base;       /* aligned to 256*MiB */
+    uint64_t decode_len; /* aligned to 256*MiB */
+    uint64_t len;
+    uint64_t block_size;
+    uint32_t dsmadhandle;
+    uint8_t flags;
+} CXLDCRegion;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -454,6 +465,11 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    struct dynamic_capacity {
+        uint8_t num_regions; /* 0-8 regions */
+        CXLDCRegion regions[DCD_MAX_NUM_REGION];
+    } dc;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.43.0


