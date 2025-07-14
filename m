Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD955C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMd-00047R-F9; Mon, 14 Jul 2025 19:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJQ-0005v1-7H
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJO-000630-Ao
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQsMSXn3O6fJ5Qu14+HzAkdfpt7nRejvAZC4T7sYHrY=;
 b=DqI4NJlZl53ZJHfHnc3/zPZSpdMjiN7sgfaC4UYQMZzxO/h9r7E+3/BM+fpI3xHyQxZm/4
 exnvQeqAEK2nfeNs7L0eR2Mj4V9GMevFX6TDv9O5Jjsx2Z9dmujW9+1u62UhDfLFaVi6aO
 zFEMxUaUy/N9uoDyUUq/1yMD81b0Kdc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ehCD-Ga1Pgi8gz3ZVxeWFg-1; Mon, 14 Jul 2025 19:10:16 -0400
X-MC-Unique: ehCD-Ga1Pgi8gz3ZVxeWFg-1
X-Mimecast-MFC-AGG-ID: ehCD-Ga1Pgi8gz3ZVxeWFg_1752534615
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45611579300so13303465e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534614; x=1753139414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQsMSXn3O6fJ5Qu14+HzAkdfpt7nRejvAZC4T7sYHrY=;
 b=sSb4mSR+l5nK/EXSatJYOi5amp8A6jD/sLz1R3aNtGQw3jwhD8PXfnCzWjERA7K7ha
 +I4eNoWOgROnzber+OPvZ9SKl+LolOqC3zWrH+VdeMgOXxkdq50fEnU5FVEsx8nlkHM8
 V7/02Ud0LCmXp/SXTppZ/3HokXoRTKvsw8x4lLLyo/voQA6Q4f61JxStK74HjmPcuhkD
 aFfnV/eFO6ue9rgkntSnbHvUq6svmHVefBYQpNH8iQr1czKQz1sDgE4OtGR21kmJ82e6
 fd/4iFGGukKwhbEujothy0lhffTga3B3g/viKMYxDTlcv4F/HrHD46JVVREKXByhxieo
 PY8w==
X-Gm-Message-State: AOJu0Yz4gy0rMLDPuLHMDjr6IyUH0wqjK6YlhFTypFI7dVRMYapn3adB
 V12jBTUSX8H5d1tQ1TXDW4mYArVwM6dvcp/4pZweInSUOsxKnYRxQzRAiNHKdh+z2cbHaelg0KK
 dX3s8VYPannSqbOsQHBmpSdpMBfB71Zy0e0XgzAOX8OVewpUz+R99t0tgRw0kCMpYnS3V+XSE8n
 rV6F4zt7JtqPNkPIYdHAkYhiobuJ6p97IF5w==
X-Gm-Gg: ASbGncsinev3a0ukGbrRtpO69WpsAW90K6mO/5y60gTu5fOcc3tpU8AoJpHdbVHwy0l
 s5XbQxp5iocwsfzOgUkNYMjdAUTsF0H02W8M2WjaRQXcojMQbrpPO1c1p2wzhsQjn6DSdPh80Zm
 hdCvrLV775KXbuJNalV8YjZxg2ZzbQOCyAKDvJnA5OfOs2U1hgfjMJxbYrEW40j08jTD+DftIVv
 l/fBwN5jjaEB0FGmR+Q+jCVvskaHvItB5T1jUqHOHZxwGlcBH6ALfb5ki1CTD2A+bYGAtjuIYPT
 fikMfbc8MoJKwIHFe/ucIXppS5NWOmyp
X-Received: by 2002:a05:6000:18a5:b0:3a6:d5fd:4687 with SMTP id
 ffacd0b85a97d-3b5f2dc2906mr8623572f8f.18.1752534614261; 
 Mon, 14 Jul 2025 16:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGftFNumpmK0tJcuQI0+ugaBC56COUS4kShCPbFHqpW93kxGcMXvhqYdopb9wztBVHO2JzLTQ==
X-Received: by 2002:a05:6000:18a5:b0:3a6:d5fd:4687 with SMTP id
 ffacd0b85a97d-3b5f2dc2906mr8623557f8f.18.1752534613695; 
 Mon, 14 Jul 2025 16:10:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d76fsm13835390f8f.64.2025.07.14.16.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:12 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 90/97] hw/cxl: mailbox-utils: 0x5601 - FMAPI Get Host Region
 Config
Message-ID: <d7c348898363dd75e927e52614d50825d9a815e8.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 106 +++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3304048922..bf1710b251 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -120,6 +120,7 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO    0x0
+        #define GET_HOST_DC_REGION_CONFIG   0x1
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3286,6 +3287,109 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void build_dsmas_flags(uint8_t *flags, CXLDCRegion *region)
+{
+    *flags = 0;
+
+    if (region->nonvolatile) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_NONVOLATILE);
+    }
+    if (region->sharable) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_SHARABLE);
+    }
+    if (region->hw_managed_coherency) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY);
+    }
+    if (region->ic_specific_dc_management) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT);
+    }
+    if (region->rdonly) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_RDONLY);
+    }
+}
+
+/*
+ * CXL r3.2 section 7.6.7.6.2:
+ * Get Host DC Region Configuration (Opcode 5601h)
+ */
+static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t region_cnt;
+        uint8_t start_rid;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t num_regions;
+        uint8_t regions_returned;
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint8_t flags;
+            uint8_t rsvd1[3];
+            uint8_t sanitize;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    struct {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED *extra_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint16_t record_count, out_pl_len, i;
+
+    if (in->start_rid >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    extra_out = (void *)out + out_pl_len;
+    out_pl_len += sizeof(*extra_out);
+
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    stw_le_p(&out->host_id, 0);
+    out->num_regions = ct3d->dc.num_regions;
+    out->regions_returned = record_count;
+
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                 ct3d->dc.regions[in->start_rid + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                 ct3d->dc.regions[in->start_rid + i].decode_len /
+                 CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                 ct3d->dc.regions[in->start_rid + i].len);
+        stq_le_p(&out->records[i].block_size,
+                 ct3d->dc.regions[in->start_rid + i].block_size);
+        build_dsmas_flags(&out->records[i].flags,
+                          &ct3d->dc.regions[in->start_rid + i]);
+        /* Sanitize is bit 0 of flags. */
+        out->records[i].sanitize =
+            ct3d->dc.regions[in->start_rid + i].flags & BIT(0);
+    }
+
+    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
+    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3402,6 +3506,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
     [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
         cmd_fm_get_dcd_info, 0, 0 },
+    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
+        cmd_fm_get_host_dc_region_config, 4, 0 },
 };
 
 /*
-- 
MST


