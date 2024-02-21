Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E94C5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDb-0007hc-QC; Wed, 21 Feb 2024 13:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDZ-0007g6-0i
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:17 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDX-0003J8-1Y
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:16 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so4867318a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539673; x=1709144473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=un/ALJ33UJ/4j/7Dwtf0xAxrV2NGLPOZb9LxVVKMbdE=;
 b=Vbhr/9JoLBzc5Uns1bH6sx9fYjh6jt31ROhH5tcwRZStdirtb9u6cShs+mR9IvXpmN
 bxi7kRbpmzyFUfv3yJ4InslbYcQKyLACHHvJfQ5C/u+dWAUIHyWi5TrF9joX1uiD74P+
 Ac1ZFTDUmN2Lt6m5EGDjkOt0Vs8DJfySzquFtG3inPa1FwUA04u8akZ56FiQSpYwK24M
 0O1TFwRTxo8Nt7nAmOpklWZWw1doAvP8Q55+OVWnedTcs068pTYgi9DTWC8/Ea8W71vl
 qbyY2wX8ltA24nbjvcK/gwR05qlxm53XhEsfIgaNI9M4dgSGRB+dkESgfFAytas3ggm3
 xm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539673; x=1709144473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=un/ALJ33UJ/4j/7Dwtf0xAxrV2NGLPOZb9LxVVKMbdE=;
 b=UGjN+bVvdCUVzcjxIx7ggXyFYbOD9UdvXDesBuQGnFm6Hxd8BuUHNEiZ2kCPTccaVk
 8XxXo/10yjU0bA8q8cpxO1hHSE10kxyVYd1LSjjfGretR2PEEJSIKq6vPT3XtQFFDI26
 UX3/YtBGZTB8n35lkb1IEsuUaokqbOx/aWIPlnR3d9/B5ASKl9U8GHlEdTr0x00T1wX2
 PaycoF2woTZGk5stEsfUDQu/xJE2scbWnwqlaN7r4hjltUayhjbbPoqVOgyxfUcXvWzw
 0ZXicms5hN3uzLkfS/WG+2kkAYOjya3IPfccCGuytTEeK2duFGiGVJKhtN0m9xWNN8ql
 2QBw==
X-Gm-Message-State: AOJu0YwkVt/sO0KS3dIhMwjxgTLiKpJ1OukGRqw85gLt7Mmvb49054Au
 U8QibqttMDApkccLpI6nZAYXPtMsLuyi8SX1yPeHxapRgH0qzTXJH+gWRgmb
X-Google-Smtp-Source: AGHT+IHZJskgqEMippermGM7haozIZGUI/e1pO3JbuOpb/ZzYlJZuIuyb9dQ1vzD1Ic/ZVpDa2Qq3w==
X-Received: by 2002:a17:90a:10d0:b0:299:bade:ed0b with SMTP id
 b16-20020a17090a10d000b00299badeed0bmr6854885pje.45.1708539673292; 
 Wed, 21 Feb 2024 10:21:13 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:21:13 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Date: Wed, 21 Feb 2024 10:15:55 -0800
Message-ID: <20240221182020.1086096-3-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x530.google.com
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

Per cxl spec r3.1, add dynamic capacity region representative based on
Table 8-165 and extend the cxl type3 device definition to include dc region
information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: decode_len of a dc region is aligned to 256*MiB, divided by
256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
mailbox command.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  16 ++++++
 2 files changed, 126 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ba1d9901df..88e3b733e3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -22,6 +22,7 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
+#define CXL_SPEC_AFTER_R30
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -80,6 +81,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1238,6 +1241,103 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
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
+    struct get_dyn_cap_config_in_pl {
+        uint8_t region_cnt;
+        uint8_t start_region_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_out_pl {
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
+        /*
+         * if cxl spec version >= 3.1, extra output payload as defined
+         * in struct get_dyn_cap_config_out_pl_extra comes here.
+         */
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
+    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
+    uint16_t record_count = 0;
+    uint16_t i;
+    uint16_t out_pl_len;
+    uint8_t start_region_id = in->start_region_id;
+#ifdef CXL_SPEC_AFTER_R30
+    struct get_dyn_cap_config_out_pl_extra {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED;
+    struct get_dyn_cap_config_out_pl_extra *extra_out;
+#endif
+
+    if (start_region_id >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
+            in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+#ifdef CXL_SPEC_AFTER_R30
+    extra_out = (struct get_dyn_cap_config_out_pl_extra *)(payload_out +
+            out_pl_len);
+    out_pl_len += sizeof(struct get_dyn_cap_config_out_pl_extra);
+#endif
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    out->num_regions = ct3d->dc.num_regions;
+#ifdef CXL_SPEC_AFTER_R30
+    out->regions_returned = record_count;
+#endif
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                ct3d->dc.regions[start_region_id + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                ct3d->dc.regions[start_region_id + i].decode_len /
+                CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                ct3d->dc.regions[start_region_id + i].len);
+        stq_le_p(&out->records[i].block_size,
+                ct3d->dc.regions[start_region_id + i].block_size);
+        stl_le_p(&out->records[i].dsmadhandle,
+                ct3d->dc.regions[start_region_id + i].dsmadhandle);
+        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
+    }
+#ifdef CXL_SPEC_AFTER_R30
+    /*FIXME: need to set valid values in the future*/
+    stq_le_p(&extra_out->num_extents_supported, 0);
+    stq_le_p(&extra_out->num_extents_available, 0);
+    stq_le_p(&extra_out->num_tags_supported, 0);
+    stq_le_p(&extra_out->num_tags_available, 0);
+#endif
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1282,6 +1382,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
@@ -1487,7 +1592,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
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
index 3cf3077afa..6df7fecdf1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -422,6 +422,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+#define DCD_MAX_REGION_NUM 8
+
+typedef struct CXLDCDRegion {
+    uint64_t base;
+    uint64_t decode_len; /* aligned to 256*MiB */
+    uint64_t len;
+    uint64_t block_size;
+    uint32_t dsmadhandle;
+    uint8_t flags;
+} CXLDCDRegion;
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
+        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
+    } dc;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.43.0


