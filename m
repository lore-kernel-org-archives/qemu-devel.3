Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E5FC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGS1-0007OK-Q0; Mon, 17 Mar 2025 15:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZT-0003aU-Az
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZ6-0001EU-M5
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22409077c06so117371995ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229825; x=1742834625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/81TCdkrP4U9ftuJqqmxfWdVPH8Vq1OR4n4vbJaQfuc=;
 b=DTlxxt54tddpa2kGdQIPQKm8Ow1jsE7GjnQplRmw5XsbXdx2oRHGf6+xon8dOM6GsI
 n8WDc43GbMYwROS3uLfWLPS22f/fGtFdcbbq1h9/XYkL/DFDItwT727BKzz1wpoIY/Lw
 GY+7JEi/WBxw24XeWbi9V8km+8AooLMN8xgufw+lunieZ7WacN1zaupWLrHvDAIu7kdb
 LBkmXCMFObHpzTM0480ec+IDOy2LQe9v7JNfVeDKIYlI5CNb8EYPGDWdXkWy5Yoq0E+i
 BUHnsHTVerc5yETzUkri8ckQAlO8xzx7tiyuLOHLhrNklnv0cPIQ33uMYz8rCCoGlAMb
 jMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229825; x=1742834625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/81TCdkrP4U9ftuJqqmxfWdVPH8Vq1OR4n4vbJaQfuc=;
 b=u2CCZ7KKPXsroSShCHM2uGdG6U1vFD6GdvuAPeXJArKNa1dB38iQ0qxcG02Vh/CDWn
 BChFfK2SZOI481T2RnStiddVxqlW8V2F1mGA0L8tHlB6UDUe1lY3oF7f9diCXdI80br4
 wM/VrBOnf2+0iDdP4CCd1AWJwrF+nGAje87SFQOwvdoTRvF5+0coLL0PGvIyXsGRXKgv
 t/LfJX8S+z3BOms8JgboHbbGhhKa/HVcWe2S3P3lRMBLK4ubgyykUZUQ/z+RaO3Ji/3P
 lcQwp+RAc0uDgI52JYui6hHyUfqZg6t0+AxBCrqRB+xrpPFLOXkyJDXLjhYThihRiiAU
 ZtHw==
X-Gm-Message-State: AOJu0Yzr+bn7/VadlKyEgcNEtVOzANcxGkSN4BHj12dtIQ51gf5l6OdX
 RbVRXwGVCAJEvKwo+PbRpcqikgNW7NlN7j92M/Wo4X2vvAb/xQT54EZNcw==
X-Gm-Gg: ASbGnctpVtV/Sknz+eE0hEo9wIaPAcrmxcR7b24jE/D9zBZGyow8WTG7RlyrH+wBbYo
 5gytNue+yFgRFfiev+QuOHAkC/J1NvbzwBNmWkXWZA4n1XKVx3WDASUFb3RAUFpfXpOn8oEOtm6
 WtrcEXVHIt+2kw2WJdSAqDiVjCUCP9rawnIflJW9sUneHEDMCo2ko5poX8G/ytivm7GcMXgSqhR
 Km4KPUcQCjlsqQL+tX2tzo6YjlVKBy35/8ETO8DJ0DygAdMhINulzDLdXA7YcS4w8oYfVPmEWaS
 qBdDkr/llNffqyC5medx+YkC0j2aUphzbfCbFHjQP10d0pTnto2SU2m+JTjgCJMgIA==
X-Google-Smtp-Source: AGHT+IFak24zVoWJ9MyZ/aEEihMeyRc3i0vqCnEzyb8zC6JLW9jUB2nMLHXl1QSGf0gpVDtxsB5jkQ==
X-Received: by 2002:a17:903:1a2f:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-225e0a15ecemr181984885ad.5.1742229824837; 
 Mon, 17 Mar 2025 09:43:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:43:44 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 4/9] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
Date: Mon, 17 Mar 2025 16:31:31 +0000
Message-ID: <20250317164204.2299371-5-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:05 -0400
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

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e9991fd1a7..4bb51bf3e8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,7 @@ enum {
         #define GET_MHD_INFO 0x0
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO 0x0
+        #define GET_HOST_DC_REGION_CONFIG 0x1
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3399,6 +3400,100 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h)
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
+    } QEMU_PACKED *in;
+    struct {
+        uint16_t host_id;
+        uint8_t num_regions;
+        uint8_t regions_returned;
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint8_t dsmas_flags;
+            uint8_t rsvd1[3];
+            uint8_t sanitize;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED *out;
+    struct {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED *extra_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint16_t record_count, out_pl_len, i;
+    uint8_t start_rid;
+
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    in = (void *)payload_in;
+    if (in->start_rid >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    start_rid = in->start_rid;
+    record_count = MIN(ct3d->dc.num_regions - start_rid, in->region_cnt);
+
+    out = (void *)payload_out;
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    extra_out = (void *)(out) + out_pl_len;
+    out_pl_len += sizeof(*extra_out);
+
+    assert(*len_out <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    /* TODO: For now, fix host id to be 0 */
+    stw_le_p(&out->host_id, 0);
+    out->num_regions = ct3d->dc.num_regions;
+    out->regions_returned = record_count;
+
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
+        out->records[i].dsmas_flags =
+            ct3d->dc.regions[start_rid + i].dsmas_flags;
+        out->records[i].sanitize = 0;
+    }
+    /*
+     * TODO: Assign values once extents and tags are introduced
+     * to use.
+     */
+    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
+    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
+
+    *len_out = out_pl_len;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3523,6 +3618,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
     [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
         cmd_fm_get_dcd_info, 0, 0},
+    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
+        cmd_fm_get_host_dc_region_config, 4, 0},
 };
 
 /*
-- 
2.47.2


