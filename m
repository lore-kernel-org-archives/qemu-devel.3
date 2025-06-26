Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE6AC7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5K-0006PX-PM; Thu, 26 Jun 2025 18:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv5A-0006Lr-Jw
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv54-0000tk-30
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2350fc2591dso15861185ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976907; x=1751581707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3OR2sM5Mt73qc/RceEmvVlGIx7XFJ60NMbMeF9QBhw=;
 b=TirIhFoWroxG++M+lruvc83t3cKULKUE3vD3mDX7EH+Vz71bzI9iEgGXaMLE1wm8i8
 Qv0NjZTAnbOdWB28q+fuXiPLGE+vCymR3F4437hde8DG8cuHmncilq42O2k3JmrwvY0g
 qyFFjYlLyF4oFAlAqDGXcOTljJoozakkxNzsKgoAGjt+PmUqSAC7x1bmH9bb3jvxfs6b
 5CVRLpPnzTghPvabuZBrqSbQIDuNWOMN0nGOyJgvXPqP31pyeHxL+8+EoAR53UiSGI37
 d1ye5xUlwAJ/7Zqf9klRs52tMVDehlkp93efbSylhHUlLUILRFoxnGwqXPPujRpopDE0
 w7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976907; x=1751581707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3OR2sM5Mt73qc/RceEmvVlGIx7XFJ60NMbMeF9QBhw=;
 b=etHyQZiOCQT87Ayjdn8fM0OIKmANu4E+omu4E5MdtZHRX10wFg6x0YC1z/4E2njChN
 cXwWKl677UhgGtMcBInz3K/670sDfMamSyzg8+bgnJ8agtZaLQIg1P8rZWfV6rUGv0af
 K2faPkIlTAzPiJVkMi9RPoegL31Fz8p2d5yx/X3eBCajIFNael45ZP4nzu0J8BuWkW5s
 QsIVydZbCg1Jo8CZZ6D3t5JWTBzdIf+kvQbMgRbLg3/w7dgQbss8cF0ZnBH6LaGcD//4
 ZVBE7KpZvpuDLq/JTxpZhMuGM3f71NnBg6jHnuI2Avj9sDKI23RO7ZXC9THybOu9ziIB
 LCBw==
X-Gm-Message-State: AOJu0YxYGkAVZgNNAOONJKBOjq5Yn+P11kxLYYENtSXeQ1aa0TgJO5ZH
 UoiB7fG1O5Ivzc/aQUEp/lpzPCRzqnogvBLz99Do3WF67LH0te2zAS9XxQdQaw==
X-Gm-Gg: ASbGncscDDOFk74dNtP4ba98agkrHI7wdSVDB3RKD8jXHpcKpS4fFxxaR3NLEOjWbVY
 2APKOC47Oxnm2qkqBKsxGiP7TKgKKicDfOPs7sRfmgise01yjAQRnDPizcrT1TIAqmix+5+rNFJ
 YO2G3Z32SWusZUfioE6fE5no/ry+xIj51VK0Nm84zZDV1WuIl/ohxHLn8Tg6Xtp9T4Rz2bTqtRR
 xZzIrUf5KY7GCSZ7m78vAwqBZZsj2U7h7x9bceu4eTg3fNDOPO1Xw3x2nGEJd6mUEzBCPa3VF8o
 4Gi2X3os9v8gzw+yXcdJ/zQ5jvsAqSmg+qUuuYZyp5dykgfO55uTbidbne31WHLsr0ie6Dmyk+8
 4fi5QgQw=
X-Google-Smtp-Source: AGHT+IFu9sX5qahTX6pLMUGmJOeGYzCNgXfj800wA7YwHPMovd/dEXpPsBTFkpCCcZuKHYFr7c+Ndw==
X-Received: by 2002:a17:903:8c6:b0:232:59b:5923 with SMTP id
 d9443c01a7336-23ac6375c83mr10666695ad.23.1750976907058; 
 Thu, 26 Jun 2025 15:28:27 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:26 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 06/10] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region
 Config
Date: Thu, 26 Jun 2025 22:23:29 +0000
Message-ID: <20250626222743.1766404-7-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  6 +--
 include/hw/cxl/cxl_device.h  |  3 ++
 include/hw/cxl/cxl_mailbox.h |  6 +++
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7f0709a27f..69c618383a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -121,6 +121,7 @@ enum {
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
+        #define SET_DC_REGION_CONFIG        0x2
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3387,6 +3388,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
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
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLEventDynamicCapacity dcEvent = {};
+    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
+
+    /*
+     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
+     * This command shall fail with Unsupported when the Sanitize on Release
+     * field does not match the region’s configuration... and the device
+     * does not support reconfiguration of the Sanitize on Release setting.
+     *
+     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
+     * doesn't match.
+     */
+    if ((in->flags & 0x1) != (region->flags & 0x1)) {
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
+    /* Check that new block size is supported */
+    if (!test_bit(BIT((int) log2(in->block_sz)),
+                  &region->supported_blk_size_bitmask)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* Return success if new block size == current block size */
+    if (in->block_sz == region->block_size) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    /* Free bitmap and create new one for new block size. */
+    qemu_mutex_lock(&region->bitmap_lock);
+    g_free(region->blk_bitmap);
+    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
+    qemu_mutex_unlock(&region->bitmap_lock);
+    region->block_size = in->block_sz;
+
+    /* Create event record and insert into event log */
+    cxl_assign_event_header(&dcEvent.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(dcEvent),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
+    dcEvent.validity_flags = 1;
+    dcEvent.host_id = 0;
+    dcEvent.updated_region_id = in->reg_id;
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                         CXL_EVENT_TYPE_DYNAMIC_CAP,
+                         (CXLEventRecordRaw *)&dcEvent)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3505,6 +3584,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         cmd_fm_get_dcd_info, 0, 0 },
     [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
         cmd_fm_get_host_dc_region_config, 4, 0 },
+    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
+        cmd_fm_set_dc_region_config, 16,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b872a26173..ee554a77be 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1590,9 +1590,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
-static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
-                                    const QemuUUID *uuid, uint32_t flags,
-                                    uint8_t length, uint64_t timestamp)
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp)
 {
     st24_le_p(&hdr->flags, flags);
     hdr->length = length;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 6a5025200c..82e3bc1a71 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -729,4 +729,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp);
 #endif
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 9008402d1c..a05d7cb5b7 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -8,6 +8,7 @@
 #ifndef CXL_MAILBOX_H
 #define CXL_MAILBOX_H
 
+#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
 #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
 #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -15,5 +16,10 @@
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
+#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
+#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
+#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
+#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
+#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
 
 #endif
-- 
2.47.2


