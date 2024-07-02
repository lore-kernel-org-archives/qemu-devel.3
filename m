Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F62C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwS-0000KN-Ip; Tue, 02 Jul 2024 16:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvp-0007DR-II
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvm-0008Ky-Jp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y6BvONQ3xHQ5Uc0x7v2hZbGWG9V5fJeg5muDy0KhuLY=;
 b=cvbF/7RorY8G1Om6iB2PC4jU496lRLXnQHJZ0cxADUJ6p74Kexd7a/x/ms0858h9QII+Wx
 fVYidQDrSnnIigpx6xsTIX6vc7cAoB4a2DPVwkxb1caGbBWSoodZgbpcza6R0ECWBAAurB
 A/FHJWMFTDdzmZnwiBqykfX+ypTEA0k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-8smMLbexMJeEfx-mYj0S8w-1; Tue, 02 Jul 2024 16:16:46 -0400
X-MC-Unique: 8smMLbexMJeEfx-mYj0S8w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-363edbfc61dso2462809f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951404; x=1720556204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6BvONQ3xHQ5Uc0x7v2hZbGWG9V5fJeg5muDy0KhuLY=;
 b=XkC2E535q+eCPPps+bvc27VwJl6nOWKaG8brk6zEqFG1aFSPXX5kuWoypb/uVT4Vfi
 4GtOZ41PSWosHtRTkDTyBT5qhfE6Kp5qVFvClJTvHeZIweK1rzyy86GZsTWUrfJ9ZHDB
 WO3SZ4NWfanECnnopq50pcmjPwFrbTtorAfdZYFZT4mxUy0BYWDvH8X+zz4BwL/BjUQK
 aWlOUydUAsroho30eVHRXBgg3ecgLrs7uhZw0Il6hQx65sy/bUK8XewSHPf9wij1Nv2f
 c/OuLzkaeiTCAmFAJ3Lqs+FGf3d92B0Ao9j41Ju9BmOcT43QF9MCpGrou0b3/4kmNxlo
 G8gQ==
X-Gm-Message-State: AOJu0Yzw0ue7jrC9ZKpCcoFRrYFjzyfntVZUZ9X++A7Hw8YDr+Pu3avR
 zt9Q97TY9yMV3GgWIm7953tbFfJ9SrFv+Cb82pEZDluprropxQ4Ay0ozlzN95UMExFNYje0CmDD
 PmS/C5N5TKdGAGj8vz6mBMGkIz/2SjugPFq0MAsaOHeEK113wjjj6oStGNAT+1qocsLYS2w1aFq
 ckLxkwMDz7F7SQHVvmDwR42DHN9eDV5g==
X-Received: by 2002:a5d:43c4:0:b0:367:62a:edb0 with SMTP id
 ffacd0b85a97d-36775725b8cmr6426510f8f.44.1719951403776; 
 Tue, 02 Jul 2024 13:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHptFwGNjeFwUs9xw7nNg2IrcQFIRGRFEBDa85VTVv+3w0lm2BswxV6m7eb526aNOotOurLqg==
X-Received: by 2002:a5d:43c4:0:b0:367:62a:edb0 with SMTP id
 ffacd0b85a97d-36775725b8cmr6426492f8f.44.1719951403195; 
 Tue, 02 Jul 2024 13:16:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba0bsm14087515f8f.69.2024.07.02.13.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:16:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 24/88] hw/mem/cxl_type3: Add DC extent list representative
 and get DC extent list mailbox support
Message-ID: <1c9221f19e62e448a9ca71a2d5c8a369102a0c38.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and implement get DC extent list mailbox command per
CXL.spec.3.1:.8.2.9.9.9.2.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-10-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 22 +++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 73 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  1 +
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c2c3df0d2a..6aec6ac983 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -424,6 +424,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_NUM_REGION 8
 
+typedef struct CXLDCExtentRaw {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtentRaw;
+
+typedef struct CXLDCExtent {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+
+    QTAILQ_ENTRY(CXLDCExtent) node;
+} CXLDCExtent;
+typedef QTAILQ_HEAD(, CXLDCExtent) CXLDCExtentList;
+
 typedef struct CXLDCRegion {
     uint64_t base;       /* aligned to 256*MiB */
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -474,6 +493,9 @@ struct CXLType3Dev {
          * memory region size.
          */
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCExtentList extents;
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6ad227f112..7872d2f3e6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -84,6 +84,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1322,7 +1323,8 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
      * to use.
      */
     stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
-    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
     stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
     stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
 
@@ -1330,6 +1332,72 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.9.2:
+ * Get Dynamic Capacity Extent List (Opcode 4801h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len_in,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct {
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint32_t count;
+        uint32_t total_extents;
+        uint32_t generation_num;
+        uint8_t rsvd[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    uint32_t start_extent_id = in->start_extent_id;
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    uint16_t out_pl_len, size;
+    CXLDCExtent *ent;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+    size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        CXLDCExtentRaw *out_rec = &out->records[record_done];
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
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
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1377,6 +1445,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 658570aa1a..2075846b1b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -673,6 +673,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return true;
 }
-- 
MST


