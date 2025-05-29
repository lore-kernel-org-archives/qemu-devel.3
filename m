Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94676C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgIs-0003fC-25; Thu, 29 May 2025 12:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uKgIp-0003eu-DM
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:40:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uKgIn-0006Qi-8k
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:40:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-234488c2ea6so12304115ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748536820; x=1749141620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kYNbXaI7S/Aqt1+tr2L7iGWdwvMVK43iCdmEWh/uNF4=;
 b=ItD2xpKDcE2QMhqaqud4nRajHpeWPhQgqgXVHTxuAJ/CbIiHxkkqvdMWhxg9PKEqg1
 C7kSSxGnUChv2nZ5qLKXL/irlNH13aPbAVlJOvO2jmKWxeiRmxFyYDn41UtFDH3Qhy+i
 BXQo+z5U0OZPB6wwEh2LfLIQAzC/HsCyzbdxA+niQOHkddu6Y4hivAE5G4YieSv/OIit
 oHwYCg/SR8iSeFw6MG7UgbwvPSXw6k/ru0KNSH4nT4thnhXIHMxIB9V8B8Hxom++f1lw
 KEn/GazuYYXEaVxXC8qG3OIJWegCk+9uE0TD3ta8KhH7jyx750PnYq0cGkopVY4BZBEm
 Um/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748536820; x=1749141620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kYNbXaI7S/Aqt1+tr2L7iGWdwvMVK43iCdmEWh/uNF4=;
 b=cObvMa4/8u46sFySDrTouslj9S+QjV21XGy5lrwSkP5hBanWS7kxGTkCdG3tUukmkl
 deSi42NbWPf/fNumPHRnMmDRScXQui7vcVoikkBLbftNBe4CFqUfQaT8t9QKi1XK3O8T
 H9Mv/tV94x0C/XzW+AFn1DQ8PnmLnqTwiCYqIvP95jdVMbrO3KHnAvlmQXNpvHhdgRx0
 X4CxbuOFKKaUwto94ILv+m8Af7uHGGOfHpzdGBzqDDARIx27AnrcfTCrSEiFW3ZUAP6g
 pgeqBy2I92YA7R61DcnxJ243LZGU8ljjhSkblABeX5fo84BLXEtJ6Dyz2CeJd7ID/wKD
 vtnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3p37+ee8Vr2/Bditi1ilB3f3BNQ7vY8DGT071Kb3pGmSroLFxDoCxR2zPpda9KYf97KKadI8+fe6E@nongnu.org
X-Gm-Message-State: AOJu0YwdOkDWWA/VDzted4+7noFe6l2ySeR2sXTzb4N4C+K0evD4Pw9w
 vsY4+v72G5qcTnDUxHpQBCnuMer1N63T/6i0xPcr+Y4ykidQFP5DYiKOfOwfww==
X-Gm-Gg: ASbGncuSPWdQ9f0sh50YCE3S2G6jyFj7CCNBV4ilYxf9PNW705L5gQeodsXCghsw7WW
 QgFuHqhdO/pw74jPiRk8F++ZtpG8V2jWfVn7cxc52wdu0GuT2GITbJVKltIJiRWRoGPMX9ueh/G
 c4XByVCTFa40dAvSr6VO5ecEFGllgm91npiBSMvfrIuXVTCFp2lOPS2JhVZ/7vAAKs9WfxMRzoJ
 LXIMc2YwPZujt7GDytHGES5FAUWW3YIu6zy3LOsv+8kcjvCTHwXpxLGH0HXzSklUM1NoM20CJ2l
 T01EV7z0YierI7kuZ8eiWoSRKujQNkfL98I73cgZf8Q0ni3bCN83vyPgo5P+LLN5p6AgRA==
X-Google-Smtp-Source: AGHT+IGlRn6ufcaM9FLeterqYY+YfCTHaKiwbaVFWaTmmZV5ZtrbGUuJEWojZSwMmIH6vMs0Ijz1LA==
X-Received: by 2002:a17:903:2f85:b0:234:d7b2:2ac3 with SMTP id
 d9443c01a7336-23529201121mr3217425ad.20.1748536819577; 
 Thu, 29 May 2025 09:40:19 -0700 (PDT)
Received: from smc-140338-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd8cfbsm14361615ad.118.2025.05.29.09.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 09:40:19 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan.cxl@gmail.com, anisa.su887@gmail.com,
 gourry@gourry.net, fan.ni@samsung.com, mst@redhat.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [Qemu PATCH v2] hw/cxl: fix DC extent capacity tracking
Date: Thu, 29 May 2025 16:34:25 +0000
Message-ID: <20250529163925.2916725-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
extents in different states including added, pending, etc.

Before the change, for the in-device extent number tracking purpose, we only
have "total_extent_count" defined, which only tracks the number of
extents accepted. However, we need to track number of extents in other
states also, for now it is extents pending-to-add.

To fix that, we introduce a new counter for dynamic capacity
"nr_extents_accepted" which explicitly tracks number of the extents
accepted by the hosts, and fix "total_extent_count" to include
both accepted and pending extents counting.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
1) No functional changes;
2) Rebased the code to ToT of master branch;
3) Picked up tag;

v1:
https://lore.kernel.org/linux-cxl/20250520195741.789841-1-nifan.cxl@gmail.com/
---
 hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h |  3 ++-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 299f232f26..0b615ea37a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     uint16_t out_pl_len, size;
     CXLDCExtent *ent;
 
-    if (start_extent_id > ct3d->dc.total_extent_count) {
+    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
 
     stl_le_p(&out->count, record_count);
-    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
     stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
 
     if (record_count > 0) {
@@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
     QTAILQ_INSERT_TAIL(list, group, node);
 }
 
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+    uint32_t extents_deleted = 0;
 
     QTAILQ_REMOVE(list, group, node);
     QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
         cxl_remove_extent_from_extent_list(&group->list, ent);
+        extents_deleted++;
     }
     g_free(group);
+
+    return extents_deleted;
 }
 
 /*
@@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
-    uint32_t i;
+    uint32_t i, num;
     uint64_t dpa, len;
     CXLRetCode ret;
 
@@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     }
 
     if (in->num_entries_updated == 0) {
-        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        ct3d->dc.total_extent_count -= num;
         return CXL_MBOX_SUCCESS;
     }
 
@@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
     }
     /* Remove the first extent group in the pending list */
-    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    ct3d->dc.total_extent_count -= num;
 
     return CXL_MBOX_SUCCESS;
 }
@@ -3160,7 +3167,7 @@ free_and_exit:
         }
         *updated_list_size = 0;
     } else {
-        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
+        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
     }
 
     return ret;
@@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
         ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&updated_list, ent);
     }
-    ct3d->dc.total_extent_count = updated_list_size;
+    ct3d->dc.total_extent_count += (updated_list_size -
+                                    ct3d->dc.nr_extents_accepted);
+
+    ct3d->dc.nr_extents_accepted = updated_list_size;
 
     return CXL_MBOX_SUCCESS;
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 94e7274912..f283178d88 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     }
     if (group) {
         cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
+        dcd->dc.total_extent_count += num_extents;
     }
 
     /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ed6cd50c67..a151e19da8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -618,6 +618,7 @@ struct CXLType3Dev {
         CXLDCExtentList extents;
         CXLDCExtentGroupList extents_pending;
         uint32_t total_extent_count;
+        uint32_t nr_extents_accepted;
         uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
@@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint16_t shared_seq);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
 void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                  uint64_t len);
 void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
-- 
2.47.2


