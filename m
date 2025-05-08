Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF93C3ABBF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyb-000613-Ey; Wed, 07 May 2025 20:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyY-000608-WD
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyW-0006vm-Vp
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so535023b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663535; x=1747268335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoNEXMDldpkF71Yld0esCBvC3wY+eEKFQ2RXqToFtnc=;
 b=mb7RBkIOmYUnOJXwvd+RGdj3dFXm6IMfB64cR4EEZQf6846dvy3pdY7A9QPrjh5+J3
 hP8XV9cZqxtqMyDDaTggE/cfVZLDoxe7WMMqxLIzbs/fPHZ3/OHJN2GtbPiUyu1oEH1m
 z9x7zAm9TbR3cqLdCqjhduhJ9LKQF5J3twpzS5g8fiKfu6JVqp+DHpX392PJ76pLVSpo
 EhYLB0W6Pqk/I2aYQSkF+JJhKzhGPt2qvl24zAQUiHhJOQq3xvs+rrq7CqQ8LtP4gkfB
 BqVNYO55h1jW2tYJVrk/GlWv8FK6uLqUaIlhSWpjRTzSYvCE7iDDlKNGXaTqWimfMM8f
 ob5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663535; x=1747268335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoNEXMDldpkF71Yld0esCBvC3wY+eEKFQ2RXqToFtnc=;
 b=JMInNV8mqJcLTpMV/JeO5hdy97QqiqMslahs6TfhtcmXqr4n8OKddLaEd3GFjUAs09
 HLP/+Faq9u5ErjRebD7/DgF5DA76Pl3vQMfQ2OxOtvYWz19fqt/gIgJOZ1wAzs2arSIK
 Xad68cuWjYaWgEtt8KjVqnrgN/UWC6cEZAvOawC1VLtyNbTF0NFJEyEsFKm7E4FMYWR0
 izwjc9yors37DZ7GtklBB0mGaL7k19nRXJ7Z5UmqVkDXnlNHQjeR0sHBFq7dAEbCgUoN
 rdzVgWH4FsnpazmKhVIx9JHng+IV17mJ5gj9K5N0M7L5HKMEDl36sj2SFuOE0J3/J4SX
 czbQ==
X-Gm-Message-State: AOJu0YwdmXnXp+3hHq/ni3V/4zYX9DAHJbGhdxHQCbOnoShcWPq8IbAl
 fwjMkR7GBRkREd5OgJmwyQPcjCQZSu8DJ0sU86lERSFaLXmmXk0I07WdfQ==
X-Gm-Gg: ASbGncvcJAmKqhe4t91hJFlNGVJYSTpE8Uv/JIFHMpNVSX6lRtMatiiFBnZ/NGCeHfZ
 J0m1YWGi9xv+w88bIBciQrIOA3oPVzLlvHomk0Mrvt75YD0JCxKFYSigngO0ybTOK7d+9oAEQ4D
 v4K0WJkdjbDPXRp2lCxT9CoLY8r2Y+PuOozGVkqFuWWpsUeMfl8WseP0CFJTX5XByx5/aR5F2mw
 H6uVkRtCv+1swMAwKi0Wrt49H23G1akuygyPFnsdlq03vjprCr6/RMqWWNAZPkTsU3BLJFxmjSP
 JyN6H3mJ2gefbAJIr6xjwSc4KRx90GqVuymAV5CP9ij1BTOT7tddIHdyJ33C9yf+3/PG0c4a
X-Google-Smtp-Source: AGHT+IFTYn/CQgyZzBOVhEQ/fxJc7ir1WqKkKSaJV9DJzJBUeo1khH9iM7ucvxHOFfJ5tzh85C60sg==
X-Received: by 2002:a05:6a00:3385:b0:740:6f80:88d1 with SMTP id
 d2e1a72fcca58-740a999336amr1838461b3a.9.1746663535285; 
 Wed, 07 May 2025 17:18:55 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:55 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 08/10] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region
 Extent Lists
Date: Thu,  8 May 2025 00:01:04 +0000
Message-ID: <20250508001754.122180-9-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42f.google.com
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

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 75 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_opcodes.h |  1 +
 2 files changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index fe38a13f71..a897a34ef9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3516,6 +3516,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
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
+    if (in->start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
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
@@ -3649,6 +3722,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0 },
 };
 
 /*
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index ed4be23b75..ad4e614daa 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -65,5 +65,6 @@ enum {
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
+        #define GET_DC_REGION_EXTENT_LIST 0x3
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2


