Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075D2C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDk-000888-J7; Wed, 21 Feb 2024 13:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDh-0007wG-Ht
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:25 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDf-0003LT-NE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:25 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so5359955a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539679; x=1709144479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMsgYchrz+Nvp+KunIns7+nQr9EgC+4zBQ7CzSVSfR4=;
 b=C20VSSLFbkinDsECXyzFp9cp9Y2v1XGDX0DaH6v2neIxFOEGhX3ega5xvJMeCwMiok
 uUx3MLsJfQY/oW5MkbizdfDLfqT35ZumfYfWS5yH61m8b0I1pYJkyEeq4G0JBtP5Wz1+
 AqTsONLH/jUdaZk/1hF0fgCfWav/U5TzyJFQ07Otk9DR6bvxIfMUar7PVOD6b3GbWBjC
 +u+MuRlp1jJZvIGIvUlF7a/P/j+fld4afFEn2lHAZ6fOP8N1I3cM4FugWT+5pN4m10xl
 c0pNk7LEV7Czp5dTJGlffnjkeMS0tae7Oimj9AAGTa+B8p9h6R1BsR9fyjlgkh9SrzMt
 tGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539679; x=1709144479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMsgYchrz+Nvp+KunIns7+nQr9EgC+4zBQ7CzSVSfR4=;
 b=BtwAh2ADI5aW1hP6vZhl2ChuTs1GWknEtslWZAByjoNl2yeNVo5iivRkcrHtE8Bb0W
 tShZERTjQdpU1QwlAZCggQAbj6xicnYhGyVCSOvTyucspE+iGyLB+KU+YkJ3X5j6kUA3
 HTVE+6lNkZkVT94UIpEx45Ii4DEE4ooN9GL/3d/lCTyDVLtiHu/cXDIke07uFfmCAIm2
 e6Er8RqnBOiA0mf7cTNHw+Pu07BqVdgc9DWdgQX9k9AufYJtchyHfKZ0KTu88YhQtouZ
 winNZIZE0gctw1fr6HoezXvQU7G99dM6TxnGqlQ6L1AfIyiOjQyToqPPFjP/sfmGoFtv
 jhvw==
X-Gm-Message-State: AOJu0YyK89RURoNF9pr1ySvZPOtru3TPAHIsNMrVWkE7KBFcyGBn5Qfg
 81JFxH1n+pz9h52nQTXw+FyKes9PK+kx4YJxTyJYVtV5CQaPiM5hNxO/cNcX
X-Google-Smtp-Source: AGHT+IE55Txhzt5qTIZN0Q8RXv9M2omyIKe/vPoOqMifiqePhZSO9K1zIAHiHrBjclNSMl0HCCDkNQ==
X-Received: by 2002:a17:90b:4b4c:b0:299:73b3:cf15 with SMTP id
 mi12-20020a17090b4b4c00b0029973b3cf15mr8589636pjb.12.1708539679129; 
 Wed, 21 Feb 2024 10:21:19 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:21:18 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 07/10] hw/mem/cxl_type3: Add DC extent list representative
 and get DC extent list mailbox support
Date: Wed, 21 Feb 2024 10:16:00 -0800
Message-ID: <20240221182020.1086096-8-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x529.google.com
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

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and add get DC extent list mailbox command per
CXL.spec.3.1:.8.2.9.9.9.2.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 23 ++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f95e417683..dae7fe00ed 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -83,6 +83,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1344,6 +1345,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
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
+    struct get_dyn_cap_ext_list_in_pl {
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_out_pl {
+        uint32_t count;
+        uint32_t total_extents;
+        uint32_t generation_num;
+        uint8_t rsvd[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
+    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
+    uint16_t out_pl_len;
+    uint32_t start_extent_id = in->start_extent_id;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);
+            stq_le_p(&out->records[record_done].len, ent->len);
+            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
+            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
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
@@ -1391,6 +1459,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b966fa4f10..f4edada303 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -661,6 +661,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return true;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 2f244da9a1..12a6fb47a9 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -424,6 +424,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_REGION_NUM 8
 
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
 typedef struct CXLDCDRegion {
     uint64_t base;
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -470,6 +489,10 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCExtentList extents;
+
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
-- 
2.43.0


