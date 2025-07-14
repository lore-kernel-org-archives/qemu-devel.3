Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE7CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMO-0002VP-JI; Mon, 14 Jul 2025 19:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJZ-00061v-0D
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJW-00064T-RN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RhLQJM6xRaKS6Z3ARqutwBh0YK+m2Rf5pjXPvLsV/iI=;
 b=Hc6xxqX7hZgdnIPyrF0WxvnlPgFzzEjh2zfOx5cMlNsZnNplXrJX/Hx63HnaBa38of4arb
 ENMCCqoJqf56zVYTAlzDw2VzvGmwX8dV7mRpv7mxqpvae5O0OAj5A+hwbVhTy2YyAHYRGK
 YWJ8Y7r6ZdDSJO64GSvzwb9oMGZTNYE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-36sdPaVpM82FBC_r1NDFKA-1; Mon, 14 Jul 2025 19:10:24 -0400
X-MC-Unique: 36sdPaVpM82FBC_r1NDFKA-1
X-Mimecast-MFC-AGG-ID: 36sdPaVpM82FBC_r1NDFKA_1752534624
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-454dee17a91so36743625e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534624; x=1753139424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhLQJM6xRaKS6Z3ARqutwBh0YK+m2Rf5pjXPvLsV/iI=;
 b=dkv2/O1dWa7nqb0uxM7aJppzlGZVlRBykMGYJxNNdCdn03tMhmRX/GvD7Iruufbqu7
 DbmHP+PKn5FYc/DjTR4Pv/7c+opLxtS3X8/pzXoM4hx1XMwf8U4tyvjyBAofrH/O9Dv+
 WOISEvHrx5n5iz/Drw0l2Qex0jlQXYIU1lFQNCAa/tXQyHartoCkgc3u5HfXUo5HHDTX
 STYyGKYRfhb3HZzfFMAVbchenLQv7i7ttWFWkNCKf+VtAueSQJti2hXvsXtEJ6AzjNXo
 ihix51JZYER3FlGURoAtG1EHcGPnFwkAgRwiJFEN0AV3sWtC5hAXQuFZzqVCNGhuT4tY
 uj+g==
X-Gm-Message-State: AOJu0YzfGGuMUGr3Dl101f8wTMyo0g0DB01ipi4eoU1nOX7+X2c7KZf/
 644uNJOsQTBDeA5FVhwU1ocupJmXTyISIU+hNglNOXIZq3ARdNyzGsNdrBKFwsJFrCQa7Q5hR1g
 bPAsV5Hf/6GA6jQ7pwdAufRMXT6tSqCvES+jvI//nPwvluRMEtYfnE1U/8R/FAgdE2+mPnQ16oQ
 GFERcSatTikW8ezNQzpAJIo/MKKoPxe4dEGw==
X-Gm-Gg: ASbGnctF9hSHUr6vHxsww7IV9T3vnG7o1fH8lnnEZCoqNGGVYy9kV/D1S4qkR28GX8o
 93WWYlwagKPtmPS3rc7tfOEYrUaYwMKxCTZ5uKpMyj0F+yUPq0Wujx1TroinIpukRrbsr/fhBrw
 e8wtU48Z0yglBQWlgMySEjMtXLjO19Zv8Uesn5mK1W5+H9p2weJKCuMtdaotnNMuLk6/3F3KQLI
 ojJR3xh3em0NbhVLBxKOfAvPXgsrqDgpVRdws/ztKw4WAEZUflp5cceFEkRdBB3HuXmSnPAmXOI
 bfZFGfbeNFj3N6JI0Rq4YN7S+38NNrpI
X-Received: by 2002:a05:600c:1e8a:b0:456:18ca:68db with SMTP id
 5b1f17b1804b1-45618ca6fbcmr55866785e9.8.1752534623635; 
 Mon, 14 Jul 2025 16:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEMpwc8oKtx7+gnG3upuXnyL+uMTT8cSfvn2fhjRDsv29txWLkiFgMXMJb+3/yk7z27oOYzg==
X-Received: by 2002:a05:600c:1e8a:b0:456:18ca:68db with SMTP id
 5b1f17b1804b1-45618ca6fbcmr55866555e9.8.1752534623074; 
 Mon, 14 Jul 2025 16:10:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561dd91072sm32621045e9.14.2025.07.14.16.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:22 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 94/97] hw/cxl: mailbox-utils: 0x5603 - FMAPI Get DC Region
 Extent Lists
Message-ID: <841924a48f409dc85efed523edf2eb339c42ff58.1752534227.git.mst@redhat.com>
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

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-9-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b4a0f7d664..4b0fdbbdd8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
+        #define GET_DC_REGION_EXTENT_LIST   0x3
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3470,6 +3471,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.4: Get DC Region Extent Lists (Opcode 5603h) */
+static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t start_extent_id;
+        uint32_t extents_returned;
+        uint32_t total_extents;
+        uint32_t list_generation_num;
+        uint8_t rsvd2[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtent *ent;
+    CXLDCExtentRaw *out_rec;
+    uint16_t record_count = 0, record_done = 0, i = 0;
+    uint16_t out_pl_len, max_size;
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.nr_extents_accepted) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.nr_extents_accepted - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            out_rec = &out->records[record_done];
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
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3595,6 +3669,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0 },
 };
 
 /*
-- 
MST


