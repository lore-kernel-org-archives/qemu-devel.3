Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD447C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8jg-0004CP-6n; Wed, 03 Jul 2024 18:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ja-0003hg-HA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jY-0001Ne-Hm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5yMEJxQrvHs2013SKJXv7QWp1/VlpmqevozX2UnFx8=;
 b=Gci07JTBQxE1O8O2lid/Mq3Ug9kfVPRQ2Zs+YDLznAzh3XJ7Y7PNpynIl0uwXMO2eDOXWq
 +85tZFyLYYSKv79LegOS8vui2IqlPggMFBW1Gf41HUQUSVknysX0PfI94Nlcfxb0AFfGri
 He8KQVSfYpfqcJixGaHfJVTj0Wh85OU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-ZxSjruN1MLyOxVQ-t8L8nw-1; Wed, 03 Jul 2024 18:45:49 -0400
X-MC-Unique: ZxSjruN1MLyOxVQ-t8L8nw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee86eda4e4so9771771fa.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046747; x=1720651547;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5yMEJxQrvHs2013SKJXv7QWp1/VlpmqevozX2UnFx8=;
 b=DVdChoI274rYLB+pJ06KFA4/2WGr+WOoOjRUfX28Ey5gRdJoJGIEmnWBUJvR6E/b7B
 /TsHfwwXeKU+SBL43B21rbmbYVcjmczGs5eGQYbmXkR/29ExMSk8+ePcKYrnYV2secTm
 PoBp92kA6yJkL4fLIx0JXIC2aDT+tdzrJ1YQn8u4YAw04LhUelmp3zk0UN/Nf9Gn5tc/
 IZtalDUZzP4XsbJ37vEbJiyJntENm6NK6trCGNRbOD1aL0omwl3x2sVxjfGNb7QZEmC5
 rLHXpSwiNa1u+7AvoSRFkMezWKRaeQkLEATNFwSDPB0NBoH1+C7q/TGHmpQMPFEg5n53
 3CEw==
X-Gm-Message-State: AOJu0Ywgxb1N0FQSaXdkrV7pwo3sIAxdnXQQxRq8FCSSTrC3lcXlBLO4
 jd91cAg5R9BDPmHsTcZPpxM5QM6sRo90DcP5CCsV6cYh/CwPfyBx4z/0PHWaQtOOZmaAiH+H89r
 /oJZ9ruAoHkE14Q8PyOzi9jsFYoOxNQt9CM1wTsVIykAY3MpcOLT8l1j2ySXqWllllFX3zj32Pg
 9b7rdHP03jrxK7T7xapLPxiYFYHDjakw==
X-Received: by 2002:a05:651c:1a20:b0:2ee:44f7:cc74 with SMTP id
 38308e7fff4ca-2ee5e34591cmr96368611fa.6.1720046747518; 
 Wed, 03 Jul 2024 15:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7mXFUpgNQBCgd7X2pTuYRWexbGaRz0u5FOqZYJpq1l6njhQ2DXVDYitiAWwivRIC3Fm5llA==
X-Received: by 2002:a05:651c:1a20:b0:2ee:44f7:cc74 with SMTP id
 38308e7fff4ca-2ee5e34591cmr96368411fa.6.1720046746829; 
 Wed, 03 Jul 2024 15:45:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58614f3d51asm7646980a12.81.2024.07.03.15.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v3 19/85] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <0f0f140b100392fd938eb6933752155ea68b26a8.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Per cxl spec r3.1, add dynamic capacity (DC) region representative based on
Table 8-165 and extend the cxl type3 device definition to include DC region
information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: we store region decode length as byte-wise length on the device, which
should be divided by 256 * MiB before being returned to the host
for "Get Dynamic Capacity Configuration" mailbox command per
specification.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-5-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 16 +++++++
 hw/cxl/cxl-mailbox-utils.c  | 96 +++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

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
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 626acc1d0d..bede28e3c8 100644
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
-- 
MST


