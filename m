Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922ADCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcjEO-0007Uz-81; Thu, 25 Jun 2026 08:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wcjEL-0007NM-SQ; Thu, 25 Jun 2026 08:30:54 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wcjEJ-0005X7-Qh; Thu, 25 Jun 2026 08:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYDMaWmiJMj9DGfxjufpnlS1lWx9Dahrbb20q3Qnowfp3royTYCKUp2dZK6VMSXpQ8um++Pyg3+WGwuuWVrbbFlVt2gtkax4eddV/cnH1erHkvNxcANPSptl1M5yadNdaccSJHVy66n/RDm6LKo4HEkEKga2lnbE/dKmirVn5lAtruMqvgCLa7vfKc2UwOVHz2chTvN+HzuBvWp2JNFc98nDudXs8CtvNbk82WNdaYp7To/ROHY5mwQxnulwJ+rncNXXnYJQQdph2ln0/dihBWQ81eU88tP1v7Yep+agcC7BW03/SngPCJDcfgRkhf4/pqKssQcDKhbOU86xLzd6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1u8kNh78HhO7Tq37XEKf86iULjm/IzQFqvjrXzLIGI=;
 b=ieFpbxPAMGhUQwYdDqnrtt6iLIHeWgCA/+2++YphaGTFJR562N0UZP03Tw9uwsOKU/Y6Jv2LS/k0c+hcWo22fupwd+CH95N3ObXe6U2yMNHdGhvrSuEm4BQiQxqT9Zwm0cfKVdeKp84nl+RCW3xH+h07ItK5vd5sMl00wwWDT/KYVQgXOIkVNfGSLC4wEO6VmORi+Wo9QKJZNuI0H0AZOeK3/9gei7Nynl9TSd1/zvnt/n2cluGPTfE5WIYkyEX0coLMe7/A41oxpNiAcce1OREchD7jsKRqAvipfuLW+KpyjnCrw2N7n1gznKExqByWlZK3DWoqB+wHLPgnl8hBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1u8kNh78HhO7Tq37XEKf86iULjm/IzQFqvjrXzLIGI=;
 b=C1Jpivu52Kx6yaHt2X2g9t1Zr2TfG/HT+Ltfh2tp+Cbbyflp7HgZswNYd7MmcoMCsOFkACwPJJGI0o7GZ+mdLwBK5OZ8rVmOow/jloyjmz1RSQJaqLk0TdQjbF0ciDwwjVTZN7QGwuDdNublOC1mhtNcQbRq7lxdwQ/JVZ88mLfA71jioGzH6kqBEJ4vTQDjliCGFpRMXFo3YGWoRGTH8KrAxUPSgSX826ePm05zZOIAbsPNN19WNarBmEestSW6wFDf/8s4wbzL6ZhQ6v0nMT3qZBsK75IzNqUo1peeLPy7TlPJOGClxcjAKkqtcS+k7chgn41Hvju1++0NHz00qw==
Received: from MW4PR04CA0152.namprd04.prod.outlook.com (2603:10b6:303:85::7)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:30:38 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::95) by MW4PR04CA0152.outlook.office365.com
 (2603:10b6:303:85::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 12:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:30:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:30:09 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:30:07 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2] hw/arm/smmuv3-accel: Fix veventq read returning true on
 EAGAIN/EINTR
Date: Thu, 25 Jun 2026 13:28:43 +0100
Message-ID: <20260625122843.107584-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ccc2f4-23d7-465a-4059-08ded2b58eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: +FiXwB1VlY6j90nZ/hr9s2cJKBa645p8p4C4bgQiEnqm7KmwBrcJstQd45zjy2lDvaMVhE9XJPWGmJGUQVYsF1SEq/Z8m0mRLksPD54UdErZN0klLBeLVshPuv20OeG1ShCAyHz5OsS7ApufpBgH1KTRvoSFx8wjocWLcqQNq2MQ+m1oxc7AaCf+oIJrgEor6r0nDESBuZUe8gIxRZQ/gXHvhdrTbKdWs8KuzarEvFOMYF8E5xCZzDzpkHmko4RQLR+r2zsWelmRK6z8feooiSmOIzWz+JDLRq6G1AiPjoJcOFqgqhLV/yAwzsfG0DiG8mhS3gWuzUgbDqs14RfDihyTC5yXlBYI7sQDFobB0GI9WYosiK5CsQyyCXKX/pRZ2TCpVkkSez8jKTZ5CYX1t9oDEbvFg3c0tJNqI05x4IflgmsO019djx6WccvK10Gjq4/CTVGP1ueZcF3S5o9vLp4aKfAf6tn3Z45LcWG64m8p6s555Ls1VC1fdLfU34J2jZnOIiUBuv7D2ntXAyHW5qJqV38Y3klP+hhtV6BqLsgyb0Ym131UXIKB2DjJCoQJeyHRH6z39Mai9BpE13+AYcxR8MJTeACaxQIpDhobdCbGGMnp+8/+dlx4yXvkfnbFF8p82QusARuXlAdPfGgbz9Q/v7J7R/specSGtxBg7bnp3eUrZvYcr9QsdcdTX/zhuevRLsV7N2hjZHc43+YgIQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6sNus9xuq3zdBY2qxC+bNWH8qTj9HbydVtfRqMvsQRALa6rdp3UBOJmsuHpnWu69CaETmzERfb2OIAY7PuS7ewo7cO48wvc8unSuzsM1NZ544fyO13YUbFoFqXVftZI29jEzX2+O+NE7rMZLlxdWLhcffyRzUTzNtlpizoVXQy2aoMTz3IQ00hTwFdGmMW74fwg6nnGatgV1loATPDRQmsgpsulPD3WmuY97CPdZNgauXRkIMdUEym8jV7KDJs6uKUK19NKZXNqz0Iu44kFkb53O/jsJyMPvgZLPpH2s4BjUaRiipSwMeSdGgkaPS20hGUmyC03KgLXJCJIu7Qa6DWIwWdBc9vZH1hBovaXD1kTZQCbh93v9LR539+YFMSo0Moatnc0JkNUftnF98pcShZhF7DIC+0i6XZwx+hI+Abu0g6tHT2F4M2H6/4ez4ZLL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:30:36.1563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ccc2f4-23d7-465a-4059-08ded2b58eeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

smmuv3_accel_event_read_validate() returns true for EAGAIN/EINTR, but
no data has been read into the buffer. Callers treat true as success and
proceed to use the uninitialized buffer.

Change the return type to int with three distinct states:
  0  — success, buf is populated and valid
  1  — EAGAIN/EINTR, no data available
 -1  — error, @errp set

Resolves: Coverity CID 1660057
Fixes: d4aea0f75b ("hw/arm/smmuv3-accel: Introduce common helper for veventq read")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 v1 --> v2:
 -Changed helper ret type based on discussion here:
  https://lore.kernel.org/qemu-devel/20260623075101.17770-1-skolothumtho@nvidia.com/

Thanks
---
 hw/arm/smmuv3-accel.h       |  4 ++--
 hw/arm/smmuv3-accel-stubs.c |  6 +++---
 hw/arm/smmuv3-accel.c       | 30 ++++++++++++++++++++----------
 hw/arm/tegra241-cmdqv.c     | 11 ++++++++---
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dd755c394d..ea11d513cc 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -97,8 +97,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
-bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
-                                      void *buf, size_t size, Error **errp);
+int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                     void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 147ae06163..b8dd7e7b89 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -47,10 +47,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     return true;
 }
 
-bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
-                                      void *buf, size_t size, Error **errp)
+int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                     void *buf, size_t size, Error **errp)
 {
-    return true;
+    return 0;
 }
 
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 80900c2521..6df19f0e0e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -440,8 +440,13 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
-bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
-                                      void *buf, size_t size, Error **errp)
+/*
+ * Returns  0 on success (buf is populated and valid).
+ * Returns  1 if the read should be retried (EAGAIN/EINTR).
+ * Returns -1 on error with @errp set.
+ */
+int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                     void *buf, size_t size, Error **errp)
 {
     uint32_t last_seq = veventq->last_event_seq;
     uint32_t id = veventq->veventq_id;
@@ -451,22 +456,22 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
     bytes = read(veventq->veventq_fd, buf, size);
     if (bytes <= 0) {
         if (errno == EAGAIN || errno == EINTR) {
-            return true;
+            return 1;
         }
         error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
-        return false;
+        return -1;
     }
     hdr = (struct iommufd_vevent_header *)buf;
     if (bytes == sizeof(*hdr) &&
         (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
         error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
         veventq->event_start = false;
-        return false;
+        return -1;
     }
     if (bytes < size) {
         error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
                           type, id, bytes, size);
-        return false;
+        return -1;
     }
     /* Check sequence in hdr for lost events if any */
     if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
@@ -475,7 +480,7 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
     }
     veventq->last_event_seq = hdr->sequence;
     veventq->event_start = true;
-    return true;
+    return 0;
 }
 
 static void smmuv3_accel_event_read(void *opaque)
@@ -487,13 +492,18 @@ static void smmuv3_accel_event_read(void *opaque)
         struct iommu_vevent_arm_smmuv3 vevent;
     } buf;
     Error *local_err = NULL;
+    int ret;
 
-    if (!smmuv3_accel_event_read_validate(veventq,
-                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
-                                          sizeof(buf), &local_err)) {
+    ret = smmuv3_accel_event_read_validate(veventq,
+                                           IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
+                                           sizeof(buf), &local_err);
+    if (ret < 0) {
         warn_report_err_once(local_err);
         return;
     }
+    if (ret > 0) {
+        return; /* EAGAIN/EINTR */
+    }
     smmuv3_propagate_event(s, (Evt *)&buf.vevent);
 }
 
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 29c488e0e4..7223aa9d1d 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -841,13 +841,18 @@ static void tegra241_cmdqv_event_read(void *opaque)
         struct iommu_vevent_tegra241_cmdqv vevent;
     } buf;
     Error *local_err = NULL;
+    int ret;
 
-    if (!smmuv3_accel_event_read_validate(veventq,
-                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
-                                          &buf, sizeof(buf), &local_err)) {
+    ret = smmuv3_accel_event_read_validate(veventq,
+                                           IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                           &buf, sizeof(buf), &local_err);
+    if (ret < 0) {
         warn_report_err_once(local_err);
         return;
     }
+    if (ret > 0) {
+        return; /* EAGAIN/EINTR */
+    }
 
     if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
         cmdqv->vintf_cmdq_err_map[0] =
-- 
2.43.0


