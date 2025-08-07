Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19F0C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 15:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk2nN-0005Ic-Ep; Thu, 07 Aug 2025 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uk2n4-0005DU-Cv
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:44:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uk2n0-0003zl-Nx
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:44:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4byWcr3v0Pz6DB3X;
 Thu,  7 Aug 2025 23:42:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 4CD371402FE;
 Thu,  7 Aug 2025 23:44:09 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.37) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Aug 2025 17:44:08 +0200
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>, 
 <jonathan.cameron@huawei.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v5 5/7] hw/cxl/cxl-mailbox-utils: Move declaration of scrub
 and ECS feature attributes in cmd_features_set_feature()
Date: Thu, 7 Aug 2025 16:43:44 +0100
Message-ID: <20250807154346.2209-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250807154346.2209-1-shiju.jose@huawei.com>
References: <20250807154346.2209-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.170.37]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

Move the declaration of scrub and ECS feature attributes in
cmd_features_set_feature() to the local scope where they are used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8f62ea9b54..ce02ae8528 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1350,10 +1350,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            CXLCCI *cci)
 {
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
-    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
-    CXLMemPatrolScrubSetFeature *ps_set_feature;
-    CXLMemECSWriteAttrs *ecs_write_attrs;
-    CXLMemECSSetFeature *ecs_set_feature;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
     uint8_t data_transfer_flag;
@@ -1395,13 +1391,14 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     }
 
     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+        CXLMemPatrolScrubSetFeature *ps_set_feature = (void *)payload_in;
+        CXLMemPatrolScrubWriteAttrs *ps_write_attrs =
+                                &ps_set_feature->feat_data;
+
         if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ps_set_feature = (void *)payload_in;
-        ps_write_attrs = &ps_set_feature->feat_data;
-
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->patrol_scrub_wr_attrs)) {
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -1422,13 +1419,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
     } else if (qemu_uuid_is_equal(&hdr->uuid,
                                   &ecs_uuid)) {
+        CXLMemECSSetFeature *ecs_set_feature = (void *)payload_in;
+        CXLMemECSWriteAttrs *ecs_write_attrs = ecs_set_feature->feat_data;
+
         if (hdr->version != CXL_ECS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ecs_set_feature = (void *)payload_in;
-        ecs_write_attrs = ecs_set_feature->feat_data;
-
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->ecs_wr_attrs)) {
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-- 
2.43.0


