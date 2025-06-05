Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD51C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKER-0000OT-16; Thu, 05 Jun 2025 19:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEP-0000O8-Sx
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEN-0004hL-Vu
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:45 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c46611b6so2058841b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166962; x=1749771762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GH9hNFPpMz8Q6rMqsaXZiZgLCZEo74kBRzCVEOjXJY0=;
 b=gkf3g21QqxuPvcWtYs5E7di/juqxidZ0Nl7NdshJHzoM3Jho17VK9jjj/rom/X+e3Y
 CpEtXq+Q/Zt8rcG1TlgiwYDI7Ob+pNa5hi5e4PzohsjNlTIA6QmEntKQqhogKIKmvEQt
 M9YNiBeY+CNd5zAvDNdkt0yVzekgxYiQwkklg/eeylcfaVWGfL+51c+OAB0ZKlS7qF2I
 CFacBM6MIVEEwOoVOvpHiOArvqT0cHfqSgfvvTPCwyjQyO4EdfwkDE4K/A4+7RMOlfLC
 Thhz/Jn26B69QLKtX5RoPv6dGgmyqO4aFFfrkHUUxWrfX/YEMtNaXKP2U45xBMTvAjZi
 ShXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166962; x=1749771762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GH9hNFPpMz8Q6rMqsaXZiZgLCZEo74kBRzCVEOjXJY0=;
 b=d8ZtoNqLNnm5IhPgjJ0FgQKfEraLfjEK40eL51Jsk9CANQs0VZ9AnJjT6U/EesGUzL
 Y/FopCk/59QQEltP0PgWif0seY5ONgG9vxcuCELTDeiWL5F4ba3F3j2+UVBn0bbtvoo1
 1aHkZqKPtaGq8LT34LvphDPwGX/vpUq82rPdnjDZWcdbpj+7k4cmnRMOj23QDrk99Sb3
 oiaV1jtNod3/gS58wjVlpPcrPOpgIHJTK7sEbVKPsFeAVpDJ8SML/6mHPCkvqwBansn2
 hWYyxheu/9X1vOfjfo8oe2xN/M+skt7DzC7fbAVkfw38RF5l0gEWoTE4GyzQgIkPsdMY
 jFhw==
X-Gm-Message-State: AOJu0YxRk1tESmYHA8J291gZKWEL2pWNOxKzknIalwSjLrHzycCqj0Q0
 fFAWZl6wIzOQxwB5uzJgL2e3oXnwCLB0dL0v+Rta0MTCtbHVwLkOPkK3Ot59Fw==
X-Gm-Gg: ASbGnctV9WcBSQHvrOXXKVdfU7F87Ll5luBEij2iHlL1ujEBpk7uObXexVy77veDkpz
 o78GvNRTZ+67BwzmTYJS2kOS0ByXljbEg1/HLD4z5bspcINqy1sWvgwGdPRpxXZkx3exGLKTlGx
 vnvLD4qICsF2O9OVPpgy7p+zb9cAwwGChwShyR0aUVRteYf7NtjufZa5MulHmGiiEC5/Mbyglr6
 KccbV4BZIWK/I33Lgm86VDivHtA0fzc3F1IuTcv7g6BWh9vPhI4hLflOs4Sn8qEpHdM6mzZcLZ2
 nvNUdNOMPs5ziw/QBaVyXw0pU9ZwW9sxLUim+FOKl+O5stmazT3R98rHYypZlIhWzcY3WPLZ
X-Google-Smtp-Source: AGHT+IFGm1WYLbicboBkF812GUAYFtoQQHmVrtviWtRvmyBHsKQY87ZlIgFsAq30K931StEVij+YjA==
X-Received: by 2002:a05:6a20:9149:b0:201:b65:81ab with SMTP id
 adf61e73a8af0-21ee68cc39fmr1260367637.23.1749166962231; 
 Thu, 05 Jun 2025 16:42:42 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:41 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v3 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region
 Config
Date: Thu,  5 Jun 2025 23:42:20 +0000
Message-ID: <20250605234227.970187-7-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  6 +--
 include/hw/cxl/cxl_device.h  |  3 ++
 include/hw/cxl/cxl_mailbox.h |  6 +++
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1b5c7216f9..47b1509a0e 100644
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
+    /* Return success if new block size == current block size */
+    if (in->block_sz == region->block_size) {
+        return CXL_MBOX_SUCCESS;
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
index 96ef9be444..76af75d2d0 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -721,4 +721,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
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


