Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9477EF4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx6-0002gw-QW; Wed, 15 Apr 2026 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx3-0002B5-7T; Wed, 15 Apr 2026 06:58:33 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx0-0004DQ-VK; Wed, 15 Apr 2026 06:58:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRlaZLgQga8i0CNTHAzk07VbPqHZGOOPkoXf/2hjeGmdf34RbKnSqNP6FrzZZdWtSF5ePn/pnQapqdR+WWAEd3+toTCtY+20d6uVYlAWehbC5fz3iXft40NY2MXDG2X0UUa/0sFOuhS9/ELv2h/JKmgPXysYqTsh7m02y543ddd7ytEaClh652g8yHy3lzkh40oArB8dUz/A83V5osI9/oQddQ0CkyHHDO9lGzCrSKR6MX24UVltS8YGxZnbMZNJtiRiwphOKnG9D2lUYLGEgv7pPhgQu/1ccJwsOm2/tpLhUpG+jHRyKtMlT9tSvicpc3KMjB40nGyL90gSFPLBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti3bGolNQdApf2wshIwdl8NA+dBB6hAKVrI7tIh21K0=;
 b=Q6xbPR8TON8AeyAhm6xYa5u3Ch0FKmRixstCDwhJd/Cn2czftCBdMSQygt9DNBs2ZRNsRYk4swqBEj2WJ7xT5C0F4uakJQTrqwPG8KBjiXStMj3paZbG6mIRQUxAriBcN0xCUhIoFWJ/NEeWNwxKM2c49wyXt39dTsaM7wAA+ztxAh0fqsorO3g9C8bbzK72SKHq5GTKFMNAjZHIvNcUz2ncqUHNAFBhmnGumbvQNnuduJNk5RkddXd1vINGZtQ8NOBllfinKO4SfZzLsNERHgTHqzBjwJ/OY7JSVPJMmSb7AI2iU3T63juRa08aATB55cuy7elh6IDPoxO1Fjvl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti3bGolNQdApf2wshIwdl8NA+dBB6hAKVrI7tIh21K0=;
 b=tT5AG29SpnMIoW0C4xea7xKFMiBD58Tu48hCNVLXa+E4D9/E+mfzEIXT76IlZvIJTYSzFEdpU6QG92dI73i6/yLOwGOQO7dOaMdMMR3O0yl+kP91br/1G1zv0GK+gJgL0bpP9h285G7eyqivjHahT2Mi+mAmwdzxIggxzVCFXZw5oaV6NfNuEWK74Z4jccuxVfrRJ5xfeqlK2JdXFLGDdVhb38N1I5L4J6kYTD+pi5/tWUPLn61KcmecARdnnUwBNNPGfwzJJWooNjK8pjuRHzVRxnLaF/brdMs1FklsEzOAhv3g3ug97RcMvtx2soLXhuqHrj+W6d7wtKGPxDDEWA==
Received: from DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) by
 PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:17 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::bf) by DM6PR01CA0011.outlook.office365.com
 (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:00 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:57 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 23/31] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Date: Wed, 15 Apr 2026 11:55:44 +0100
Message-ID: <20260415105552.622421-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 951b2cfd-9d52-44e7-3c75-08de9adde60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: FIkx7s/+rwuhqidKR5nCZOuJVWJvcWY1rAVVORQynBuWEcu8uU0bhJrh1zJpuPl52vw0KyspLBzSORSx3pEFZQDvRSdz3DQWfBboleH9+6am0n+nz6sKopJ7yQTqUJUraWCYeVopSsweAf5QMl5EY+WQVgfdTNt5F9ZhfxwMwxJbsJgbblBKifWTbWseJ2TWXua2Uvy5coNdl+lXfMWHPE9Rqd8mSuUMuYV56wsP8O/Bwipn+J3FUz/XlT3MUW2drVjLliI5bDj6pTBizj3nwGAu4UjGxPXm5bA+iM/EkGMi9d7a5rqpvYaz0mo8o0m71AWNXq7ytDMUoetDQB3m9UzeAIB0vHf85ZoqBTbcYdQQ3jJSfC2M9uVBcYYBxQ/AEF2WTAK6vTGuev8UrKmSi4kPZNYpSe+0jP5Sp60mWSRN4BSVLposS88DOQvM4F0jMGWU9c22sh003thP8bar73ugECH8b7Rh2uaK31KWPMDm0vQ+U+W4R7ftieTFfEFb26LjVXnMrSBByH63krbUCJpF0iaxwX4upN61vOyM545MlJUA70gzV8UypqNfpYBUvFQ8ft+hP4acOifUaD76yT/qJkq0HEcLFZLOPHBNmhlgbndzFOjJksmdmZi4z9CpKQGLGWK49edfSG63Kk1di4tLbwuHW/uN6hjv+9uIZdlDBKyMEjGF3K6dUyFJxyPQutnqZgo+/rWnVpyzwR8EHIEsbAK1wNfJ9RYt0SNQIplExn43Pu8cbAGA0m5QLjU8VPaGmto+ohi6Mx0wwDLQYA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LcTXPD4D2OL6Pd0fnDO/FTon+TFkNwA/u21sNC9R2dPoxF1E9wVQyKgxHW1EHFRwbJQ4qYHICfBhGT7+k7mBgCTySmUi8Yyas2v4J/cRVO/1s5p+jkdi6pO216ljDegl99XEJhl0c8mZPCB2wrmsA5ow4KSgr7/FmAVxigs8YMgUs/PKar4zWihKHNiqn/sskmACv/PNu8rn1L903Mo84m6kJsNUwr+C2SGeE3YrHDU3pN7YZ+8q4uDc4afhRjiqzE4onJkzjR+czyIJfAe3NPWOZCzpmMj4WT0936YvYk9Yt2kHr1k3WY23jS6Y8WOZnGhqEpCUsHbXBmTo3bBldg7BIjm6f40lp9kxa7oAjwDkViPXefw9P8/3ln2VW0/ZP9EOROcpwJ6ava+n2SJw4xeOp0XNW+Hf75Ahj7/tWC4UOm4G5Kb2ywAv/0qe31Bp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:16.9816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951b2cfd-9d52-44e7-3c75-08de9adde60d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the vEVENTQ read and validation logic into a common helper
smmuv3_accel_event_read_validate(). The helper performs the read(),
checks for overflow and short reads, validates the sequence number,
and updates the sequence state.

This helper can be reused for Tegra241 CMDQV vEVENTQ support in a
subsequent patch.

Error handling is slightly adjusted: instead of reporting errors
directly in the read handler, the helper now returns errors via
Error **. Sequence gaps are reported as warnings.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  2 ++
 hw/arm/smmuv3-accel-stubs.c | 11 ++++++
 hw/arm/smmuv3-accel.c       | 67 ++++++++++++++++++++++---------------
 3 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 28bceca061..448f47c0ca 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -71,6 +71,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index c08caa6fa4..e8f08dc833 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -41,6 +41,17 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
 
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
+{
+    return true;
+}
+
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9068e65e2b..230f608f03 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -436,47 +436,60 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
-static void smmuv3_accel_event_read(void *opaque)
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
 {
-    SMMUv3State *s = opaque;
-    IOMMUFDVeventq *veventq = s->s_accel->veventq;
-    struct {
-        struct iommufd_vevent_header hdr;
-        struct iommu_vevent_arm_smmuv3 vevent;
-    } buf;
-    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
-    uint32_t id = veventq->veventq_id;
     uint32_t last_seq = veventq->last_event_seq;
+    uint32_t id = veventq->veventq_id;
+    struct iommufd_vevent_header *hdr;
     ssize_t bytes;
 
-    bytes = read(veventq->veventq_fd, &buf, sizeof(buf));
+    bytes = read(veventq->veventq_fd, buf, size);
     if (bytes <= 0) {
         if (errno == EAGAIN || errno == EINTR) {
-            return;
+            return true;
         }
-        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", type, id);
-        return;
+        error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
+        return false;
     }
-
-    if (bytes == sizeof(buf.hdr) &&
-        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
-        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id);
+    hdr = (struct iommufd_vevent_header *)buf;
+    if (bytes == sizeof(*hdr) &&
+        (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
         veventq->event_start = false;
-        return;
+        return false;
     }
-    if (bytes < sizeof(buf)) {
-        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
-                          type, id, bytes, sizeof(buf));
-        return;
+    if (bytes < size) {
+        error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
+                          type, id, bytes, size);
+        return false;
     }
-
     /* Check sequence in hdr for lost events if any */
-    if (veventq->event_start && (buf.hdr.sequence - last_seq != 1)) {
-        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
-                          type, id, buf.hdr.sequence - last_seq - 1);
+    if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
+        warn_report("vEVENTQ(type %u id %u): lost %u event(s)",
+                    type, id, hdr->sequence - last_seq - 1);
     }
-    veventq->last_event_seq = buf.hdr.sequence;
+    veventq->last_event_seq = hdr->sequence;
     veventq->event_start = true;
+    return true;
+}
+
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    IOMMUFDVeventq *veventq = s->s_accel->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_arm_smmuv3 vevent;
+    } buf;
+    Error *local_err = NULL;
+
+    if (!smmuv3_accel_event_read_validate(veventq,
+                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
+                                          sizeof(buf), &local_err)) {
+        warn_report_err_once(local_err);
+        return;
+    }
     smmuv3_propagate_event(s, (Evt *)&buf.vevent);
 }
 
-- 
2.43.0


