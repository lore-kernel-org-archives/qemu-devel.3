Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99149CD6E64
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1AK-0008PT-66; Mon, 01 Jun 2026 07:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19c-0006zW-2g; Mon, 01 Jun 2026 07:50:00 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19a-000591-BH; Mon, 01 Jun 2026 07:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW75EU4WwPiBSB+nuz8jTYzAauaEOQUbxv85apZ/U6G+akKFy1TuKRVmuY8yx4iaRnzs17BHxiKUAXxGnzOUEZrjreC5D0GMUZRryObbXrDOon87EvrY6bCMOcZTHevGcwyGsFoq4DImyo6riQtX4Yhpx8NMB29jqjsmM42/cFLUuVFOf460ER2952u8B2rF6Y5krn/z4YUkeFoUirW6JUoq1cjt1PJ38xnh/cdWhUs0V9pv0gNw5822zO/Gl5F/Ze9cyjbUMG7MSFmeiVQff0dH0jE2mVN4wiGnQ2G9jIb20swob/nRQeKTQ75WdoX8P1cdQDY3FJUh1eWJLaVEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu04pDzQrjWyXDK3OhbksiojksDSCcHsaDwoE25GW5k=;
 b=tM/OG2lz6sLSROM9hyZS17jd/B7UwuZtY83ol2Jzkh87vCUusa/JMQzPKVntRKgKpCtVna32MsV+yik53ccxhm96nWF1tODxsuvkiBd34CINHY5vUp0GfIL/rdQUYD0HBg+de4Cbny5ukkR8fviIiMmUc8EzFA1409pm8OaGJV0AKeQ7zhHXBJ4AUSY+sxmRowD0q33NmOYjCwiZvhAMJ2Ph6WW7dWQd/Qup0uyWBoa5HdG1X3OoaVFNjJzFPIo2kKGCyTi799Egk5tSQ7LC2eyJsFETlrEVNDIrh3w0OrjzUyjpIL9FYa03PJLd/KYvYTwbCwEL8cXz1PNQCCYe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu04pDzQrjWyXDK3OhbksiojksDSCcHsaDwoE25GW5k=;
 b=bG2SxZ5jDXa0Vamqc2dS8q5wRmS46Z9zoy+w5IulQJINVUyY7FaS83W6t4E+6WNkI0ISBRTL1jVyxrEgx3m9Xp638H9Da+4iUvF8gj3Mte54CeQSSkbX1VYNk3Rlq4covn8MmtfIWj3IT0cui/4dvpcDTB3t7NpXh9YtuBbQuxWpOCNBVJ54Cvxt8Lli6+t3EXRc84c0SgK2+F1Yrod2zm7YIXIB0CVBkNOwIZXhLCFOk1T+mmUvtCRXRneMaScOTsqND1qXq39yXQ1FBBDZIDyDe1mYLURuZbQKS3AmMvmEX5JnRngNctKwYSJT/nd5uT+1rB75OSH6KsoaXrDg+A==
Received: from BL1PR13CA0221.namprd13.prod.outlook.com (2603:10b6:208:2bf::16)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 11:49:43 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::50) by BL1PR13CA0221.outlook.office365.com
 (2603:10b6:208:2bf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 11:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:49:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:32 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:28 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 22/31] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Date: Mon, 1 Jun 2026 12:42:12 +0100
Message-ID: <20260601114221.457995-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaed530-1bd6-47ae-ed8b-08debfd3ded8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: By6UVFjoRrF2UUx9xBd8Pxvoi5NOrrEptnvNDel5pB63q7vti5Wa7tuVA75usYwL2T1X8EYKVGSHA7CVXAIUaJAmcFAtTtSgeW0m2cL/tszsQsDNgdnXGCsnoo255+h//lY3YpTzlp0BrIwHhYwGU58KkRS9PUsTXQg1GI+88ZNHLF7jYkbBmdFImXeJejKf4knUTyC9MPtBjQmamDOQm3n1YO4pW6lii/sPY/zTwDsnjBX2KA6n345RRc6ZZr1iu7GX+cJSsn9jg1QBJQRHBTOgbtEVm5EzY1F+lE6WGevlo13tlgkpAHMxouSnC/D2Do4UIIIxZTlsYc1wBwFAqVzUJQtMC5rnGRgW8l12R5MbpFwO9t6jUdYirvLMS5NsocrxXYYY3k1bn0P5sOGNChk+oDHHTpxrWcp6iUDezR4D8W0NwI+Otkmd4sOVw8FYHkTLGKjlBbGZRyiDVT6gbazm9YFEz2p9eMptch4b+BjkYjB1psbTl0+IEMFcM8sXVzGkf/MVvQOlo32i8/T0SkwRNrTxZqM/E64hcwx3cFJX+eaqm7KuWDu872mmMVX0j7++WqD7liGuLnpQP7L+w+5nOtOJUm30zLpK//0peD044NXTViYMihd5a2w+TzQilTBp5etjIPcjutJ5XHq5FS1MFTS6xPeUg3repMmh7FgTedcQkgTOI3TkK+sbD2LpKSOHxGgWU3ZWhZ00OSih7ukzbHUb4zJwhqsgj7l00Xs=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: atOiHGtVvsVNApO8+U1IZLm9HpWPy+5F1H85Mw6FhptlLDaU4HzTpdPAdFAKgj/xU8lGCXw3wbwy9TFC8jxoTPDRQ2QmEL8fcGho2O3g2/EAyhdDRKVfXRrtBWtBqywuknfbpYVtkzL3/nkOPN9rjBSEcNr3/5CkA8p6a+PMw9PIlvo2ERG55JrOxgTP240vRp9mgCAWRU9WJ2BnrBx72VfUS8X7AbO3zuzy9zI9HY40/x4jLMsMUC0rXr/aYbCPeJidqNmWfzk6/d3su6H+gWruSL05acfhKLzI4GEhlQ/xsmYrVXeOuoTfepCnEOGcRu4JId1NEaoOML+bkmQOFcSLUHgf/TvsZK73M3dItgcOGKYWTNxCgq0+dfuvLALL7I68gAl2Qbb8m6tMxwIdApaVMIuMe5/cV9ZnwxgQy0NETyFr4WQG0V3Vu5LW9GLp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:42.9214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaed530-1bd6-47ae-ed8b-08debfd3ded8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  2 ++
 hw/arm/smmuv3-accel-stubs.c |  7 ++++
 hw/arm/smmuv3-accel.c       | 67 ++++++++++++++++++++++---------------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index e0bbec8581..8d0f636338 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -87,6 +87,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 70cef66966..9e6c44a282 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -47,6 +47,13 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     return true;
 }
 
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
+{
+    return true;
+}
+
+
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3ceca56a67..c1c2a67c97 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -440,47 +440,60 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
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


