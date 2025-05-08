Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8916C3ABBF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyN-0005xy-6J; Wed, 07 May 2025 20:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyJ-0005xG-77
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:43 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyF-0006ud-UD
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74019695377so380722b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663518; x=1747268318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UzfCXhOe5/C4YaZOPQC6pTRxKyvgdqK1nFkuJEa6WE=;
 b=ccvHtEKplyPDMPcLVC7BxzvHgQvGwV+m0JpZPO8WjRZQjs9KxmJDaLgzWX2Bo0lftN
 buuxpIvbVIxsKsI8TsxUYYACRBqQrki6P2D4faBvNf3rnBUykrQZ1U3/pX59GjargKVQ
 +XUp/3qB2ATMZeK68SrKg197P1om9mr7GZGlPTeAnsnLB0x8puyodFewvDfBg9nk6GmD
 JBH0oRzgZXbqJtTCK/tEVao//IeQGxbnZqefWi7jYdC020YbD2yAZybVlF5NZYQSg8yy
 x3BMLzZtx5cgS8LhYew1oHTsokeZ77N3jzgKnLxujePTGpZcQKMmqLSSlKAgb0gO6Grv
 oWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663518; x=1747268318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UzfCXhOe5/C4YaZOPQC6pTRxKyvgdqK1nFkuJEa6WE=;
 b=eK94c+yPszwlni8NTacwFbgT8eNSfDcQNo9V3XYvaQ0mjvKWWUEECkkNJEt9HW6Fw+
 kU3zi63r6o7ONM4FTNSSnkHA57pUnN2bxu8rxDdbklhQ4T7CsonnCkft1+7QLHT9VlHe
 J2/M8FxA0kItldIli+nwYuQaridsK8iVubDIyLB9fjOItmDHY0oUe++Yx4568U5+Z+q6
 Xx1xom2jCBfqsiXR4oGPMT74HeLfzHBGrHXS1A7jWSkV+K+W96lw3VmdqSlhrYCyCf0C
 nW/1Uo8zpyyjyJnU/hE1ca+1P3zxbE+wGhRSKv8UUHKfKxPTqI6lfaUkjsKLf2teaWt7
 bxuw==
X-Gm-Message-State: AOJu0YwJTP83egdDOoqbn3YbgP0BIi1Ncwm3BznxBaMjFEvH6CpnkgzR
 Gek3YC/YhhpYYsLJLx/nn1khISXwkMSUeYaefcDrkudnrstigHaLhhJx5g==
X-Gm-Gg: ASbGncsyC4w1es3g7M7cdf4o5HcVu08zXCv8kfQru2CHzD8w7xNeN6S0Md/RpaP4wOp
 RouLJ4K+qkL+VMxeIC1boY4zaqAXtp+u5EECLO96qn4nLMhZZx2cfKS73j92SEGZUGmjkGDLCwv
 qKRvMtb8M6C9RL+u4qlA2qR8tPQl9YnSlYnVsencekNUTFtNI9kmSpdryFKpM8Kt1y/olp+gN2b
 xd62iUQM0/zzqM5CfQklhEonUo+c45f37Ws0hbtszIfVjHeMHyYgBYMliXH42e5rOvgfk2xYGhm
 Qv0FrNc9HvaUaDNYkaH9YveSwmNtBjX6j20WisBgXGS9Dbcga4MR6ZGnulqryw==
X-Google-Smtp-Source: AGHT+IG+o8P6V0KtyS2bloAjWwn5+vJfInoujb7IZk0nbc+BciMONlU9JhPHCNfuuvvvfLldxwKgNA==
X-Received: by 2002:a05:6a00:e8e:b0:740:9abe:4d94 with SMTP id
 d2e1a72fcca58-740a9a97d28mr1701296b3a.21.1746663518380; 
 Wed, 07 May 2025 17:18:38 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:38 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 04/10] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region
 Config
Date: Thu,  8 May 2025 00:01:00 +0000
Message-ID: <20250508001754.122180-5-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
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

FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 102 +++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_opcodes.h |   1 +
 2 files changed, 103 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d3c69233b8..6afc45833d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3326,6 +3326,106 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
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
+/* CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h) */
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
+            uint8_t dsmas_flags;
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
+        build_dsmas_flags(&out->records[i].dsmas_flags,
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
@@ -3450,6 +3550,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
     [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
         cmd_fm_get_dcd_info, 0, 0 },
+    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
+        cmd_fm_get_host_dc_region_config, 4, 0 },
 };
 
 /*
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index c4c233665e..68ad68291c 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -63,5 +63,6 @@ enum {
         #define GET_MHD_INFO 0x0
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO 0x0
+        #define GET_HOST_DC_REGION_CONFIG 0x1
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2


