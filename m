Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A68C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGS6-0007YG-Lp; Mon, 17 Mar 2025 15:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZi-0003g1-SF
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZX-0001GV-DA
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223a7065ff8so48293225ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229843; x=1742834643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hkn8lClrCPRJjRc61OgGLP/RguDNSmf0MEgtbmwbv9k=;
 b=HWAq2HQkQBooDYUriAS0r/tvYPFOk24qXmiceR6e3UKMYDl4t5nqpCxZIU5OJF9WRI
 efDn2H4tIUa1eYBPeK/+NUv2QhOQPD3EPQ6k8z6zDyQ5sOuieE1Dweo++M4z+O3DxQ3J
 6NAbHfzWGnT14woDqDY+EofTPqwcNFk0ecSUzjH3MZ1LeMJs5e7IbbeoQ7Stz3hPySXh
 JnhmwOfAiaQghxRmywvbDGcBbeeIgvFatcCgN3vTGLjDybsNSngyzLy8+CFcz6sNO5cI
 ZHBalBkF2mCawM5m2Gj3rst7yI2f2cNsRrzIhRgxnxjYBkZeB7BFEFnAHErfgOBh4/Vq
 ngqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229843; x=1742834643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hkn8lClrCPRJjRc61OgGLP/RguDNSmf0MEgtbmwbv9k=;
 b=VD5LDiSaqivXVmx65gpH1zFENNEuTt+R/SrOoJ5UG9Zbo2swm6OnMVex/LMXWS8A5C
 Ee/BCz6m7RReYtAeBdmMGAIlwW3oXmbivt8io3Xkykglg6maiNK8XjEjTAo2JjjaBZ0y
 de68Z+nxYgEwPf5TXGvz37rxDGV+TgCkRcZGJKe7M+cGVUEK0B3zYHC2H93QKO1RLjbf
 N5YKXf4rDYAgTEOLKsQ2FX8LSWqSXYVRgRnq6Z0xXdx4QRzzR7JM6UPB1uG7pGZreLHN
 FDe0c0g8XAL+3EbcPJfOpgMyBkzJPg8j40WjbO1Sny8GcPD6M7TWs0/1OqBJZ3ozdhbI
 fo0A==
X-Gm-Message-State: AOJu0Yzh02pmfThfAnQc9y/oxE/BJLTV8yE8X9J9OFfzP2qZXctEO86w
 9wXcHCZCIXuME0JYrsmRJVfc1Jn7v7z5BbXv+NJujhlqqycZNqMvWKdrYg==
X-Gm-Gg: ASbGncu2u5QLaIi5RbEjvV5Li8AoIi5cM35N3uyH1/ZGGsOs6zHt9RwJ4c+yukpSeCp
 hNH2CiD96dhDd7Coxk/Pk/EBVFnhu/cta/KAHG/U0L2JAqN2plXrVASht33Ung6hMxnu9gruzlb
 nfMDsB/IXlx6oOq52fDQuaUA7KAMveaNaxhTKVV/T/t+s9P8U8XGBj+XQJgKxrrc9I+eV0i+ZLJ
 PzGA4wfYLDkQemBMJH3mCRVxiQUliqdQ7lS5OVy3+JyoAx8X5iRGxBVolqFZ2xp6mZIotODtvJg
 9SeOd+L2gZq+gxAKkRQMMXYQDxSspTEhFZBUeDKmIPzHdSyTfxQ6tRWXSW+Y7Ndt5Q==
X-Google-Smtp-Source: AGHT+IFBkclO4TGHL2gkT3CI6sTdHYNvtYyBsSFqLvPDNhaaWWBtBRtVqvIa0ai7H0IA+fE/Z8x3dA==
X-Received: by 2002:a17:903:1d0:b0:21f:6c81:f63 with SMTP id
 d9443c01a7336-225e0a89e29mr142478615ad.16.1742229842840; 
 Mon, 17 Mar 2025 09:44:02 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:44:02 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
Date: Mon, 17 Mar 2025 16:31:33 +0000
Message-ID: <20250317164204.2299371-7-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:39 -0400
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

FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |   2 +-
 include/hw/cxl/cxl_device.h  |   3 ++
 include/hw/cxl/cxl_mailbox.h |   6 +++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bb51bf3e8..51ead2b152 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -125,6 +125,7 @@ enum {
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
+        #define SET_DC_REGION_CONFIG 0x2
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3494,6 +3495,98 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_mbox_dc_event_create_record_hdr(CXLType3Dev *ct3d,
+                                                CXLEventRecordHdr *hdr)
+{
+    /*
+     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
+     *
+     * All Dynamic Capacity event records shall set the Event Record Severity
+     * field in the Common Event Record Format to Informational Event. All
+     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
+     * Event Log.
+     */
+    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
+
+    st24_le_p(&hdr->flags, flags);
+    hdr->length = sizeof(struct CXLEventDynamicCapacity);
+    memcpy(&hdr->id, &dynamic_capacity_uuid, sizeof(hdr->id));
+    stq_le_p(&hdr->timestamp, cxl_device_get_timestamp(&ct3d->cxl_dstate));
+}
+
+/*
+ * CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602)
+ */
+static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    struct {
+        uint8_t reg_id;
+        uint8_t rsvd[3];
+        uint64_t block_sz;
+        uint8_t flags;
+        uint8_t rsvd2[3];
+    } QEMU_PACKED *in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLEventDynamicCapacity dcEvent = {};
+    CXLDCRegion *region;
+
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /*
+     * TODO: Fail with CXL_MBOX_INVALID_SECURITY_STATE if
+     * device has been locked
+     */
+
+    in = (void *)payload_in;
+    region = &ct3d->dc.regions[in->reg_id];
+
+    /*
+     * TODO: Fail if sanitize bit doesn't match current config and "the device
+     * does not support reconfiguration of the Sanitize on Release setting."
+     * Currently not reconfigurable, so always fail if sanitize bit
+     * doesn't match.
+     */
+    if ((in->flags & 1) != (region->flags & 1)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    if (in->reg_id >= DCD_MAX_NUM_REGION) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Check that no extents are in the region being reconfigured */
+    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Free bitmap and create new one for new block size. */
+    g_free(region->blk_bitmap);
+    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
+
+    /* Create event record and insert into event log */
+    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
+    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
+    /* FIXME: for now, validity flag is cleared */
+    dcEvent.validity_flags = 0;
+    /* FIXME: Currently only support 1 host */
+    dcEvent.host_id = 0;
+    dcEvent.updated_region_id = in->reg_id;
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                        CXL_EVENT_TYPE_DYNAMIC_CAP,
+                        (CXLEventRecordRaw *)&dcEvent)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3620,6 +3713,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         cmd_fm_get_dcd_info, 0, 0},
     [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
         cmd_fm_get_host_dc_region_config, 4, 0},
+    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
+        cmd_fm_set_dc_region_config, 16,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ac74e62875..b742b2bb8d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1686,7 +1686,7 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
-static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                                     const QemuUUID *uuid, uint32_t flags,
                                     uint8_t length, uint64_t timestamp)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 81b826f570..217003a29d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -806,4 +806,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp);
 #endif
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 8e1c7c5f15..820c411cbb 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -8,6 +8,7 @@
 #ifndef CXL_MAILBOX_H
 #define CXL_MAILBOX_H
 
+#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
 #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
 #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -15,6 +16,11 @@
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
+#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
+#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
+#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
+#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
+#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
 
 #define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
 #define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
-- 
2.47.2


