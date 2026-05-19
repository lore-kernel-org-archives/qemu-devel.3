Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D7CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsL-0002mo-62; Tue, 19 May 2026 06:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrz-0001Pi-5K; Tue, 19 May 2026 06:40:19 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrw-0006m4-Cs; Tue, 19 May 2026 06:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQbTNg6vuxo6m/Cn8jrFvX9F/vD+CYEcP0ldYZ5c67mernBsfedmcRV8g4leq1Hg5vx9odU/e8ME4iiZq8l7aoa5EDtk1ZuZd+PZgOhl0gAAybnWve5dD+pPy0k9AdF20Jmo7HRrPAzFHT50x/QaGO+/EIJEhBjRYW/S/LwaZtuloSWc4A2jEfnxUlaVAFsn41MoC6cNvE8bmkrTZhsifPPqXNGgU2xvQ/+6y3vqCYMsAubeP5ShhXiK65wajs270dhPLzWWPlgj5mQXfVmDXImikCIjPidxofX2ur50qe8SBpXJL5QVEsicxbrwTLdHc+Slr+i2q6gMHCmMnnLqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epxiku7ZWiB4qpaX3a0yXA8UDG6iVgNHB+Tl2WHrTfM=;
 b=WgSdZbapb1wGOqtjMC2fPKU1Cdr+qtgzYp1CcVaCU4/H6x5fLoZ0mQL6TiOLuM9+HgNNve5xWBHPokW8Eth9C4GFTtbJE5SfIDtLBqrKmKg7yzyLuezDXFnOyTDX/PbHJAYBTkMP+BzIBCuGbShdHqSdv5RkRHPP9QpqH0v5J2ChH8u6OvctJ5VmKO/IQD4Vs5Ol/I6BoFmt7+NSWijCEtYgHGi9mhm2IztWOEhJvOezGlXF09gxvB8PT3ID/ZV6G1NW6V7viU/OZR66Ck9deLJEzi2JP7V83SFDMoDPfaADr/Wz/6HFKCcWAIgSfPx5YbACwDarty131PzseAR4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epxiku7ZWiB4qpaX3a0yXA8UDG6iVgNHB+Tl2WHrTfM=;
 b=NfqYGtk/7ILxmhUt8/+hMWLrNNUxLe1eePL3zoEItIX0uN+fBowCKU/lMfB6p5OT7w2iguuNp4Wdxw10OpWXCq7CUq2kXrf8ZGxLrO9begZHGOTNOyVZkjBz5034GEUsw5bJYiC+sKlNK4gbfjCyzm7RwKPXSmR/ZtnoS9IGXWFkeEvE+tqPz+C8XxKyJLAJqyxKEICkT7scZ367hnf2YNdZBAFXvPCYhQl0MD7jYQx72P4gMXmv3/zovg7dvrlzSlegOlZOzdd8159Q25CMwzsmLGVdYMAtXzGMaqi+apydfUVnCpUJdOGL4NXtcLEhNUoPfPJ/dMDi12MeUppEEA==
Received: from PH7P220CA0087.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::35)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Tue, 19 May
 2026 10:40:06 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::16) by PH7P220CA0087.outlook.office365.com
 (2603:10b6:510:32c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:48 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:45 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 23/32] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Date: Tue, 19 May 2026 11:37:01 +0100
Message-ID: <20260519103727.899332-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd94279-49b3-417d-35d3-08deb592fdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|3023799003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0LhHb7szm2DeE8P2tdAJsElpx4NfTv/lr0vQgNN/t3geR9p1BIR+DqhLQm9frJZCTGp2Z9uf3fOf6mUehmWsh+bm6NgMP6axEOT8iGOQfio+Mnt0qinmnkaF1AGxEYKA93abdp0GIDca1Q0pqttN9jehECLcjrNhGUhSVC4MF5g8C5YP25wHiqxVDJaQ6OVGdoOFS/oV2JgTKCnq/wN8nfBxhmJRceEM3fz/JA8bme4ElCsl6IKwt/Ztks9vcdElwm+3iUPtTiabBh9DfsLYsHqluyBRBa1rq+rJ20D04NG9qnfcerGNnP+hYUFftfUvg0RtlQ4WBDqCDNqo5AUMuWAn11kCbVcM/GkttAn8CHWh67U3LOIR72hVT374L/9PU+cJ4PjqsdJh/1LmLXomRHDx20bPAWRzj5hIGJoUFyPg5rvsLOaJATBTLFqsThEUBEleIdE0zTBpNRkqS2x+kSw9/n5nXHbDfo67QbYv9bEiHKa7KpW5Hu3gCfaSAygNm5PTPXowG/e2S/nchAWMenQy5s9CkyxmYjJkH5OygVD3eobK9A/rc7c8+sj+PB3Ky8Sfzglbv9yH2kOTLtC9SPfuJLZq79UBlY1Su7M3wY4DR6Xqy7Or4OSAZyg5igRHAschTmhB342Uqs59iaykGvEypvgsxWvHA548yah56KclreT2MpwxHbc/L7Bwe9ctmwznmh7Sy+F95R/W24B+uwuSgBKUjBTsX7nhApmBdpk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(3023799003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h35ZVrkP8eNkCTDabbVyJs2y1v8LEu04l9XczUy4mYFX0O7sjmunehfjOOPoyFNIxassoStTUGEO/WtoBqCR4R3zYqlDlz3rKsicT+XZ5/rj1o9yGiFu6ZNbKTbwHbJ+YACmAr5SblT8mqqCMtHXfdeCyXaVQvCwVCJK7T7QQsFx+t15NQU+959POpqx7y3WFfCGcS01ZjIkDycoq5ufGnF/8x1oq2u5O8GEoz1C8hgs1Uj0uFYU1cNJNF1yHmQOx7f9psCJc0ksoezOv8r9Zj0YY2RUZCUDMnfMz79VfVNpyJa8w1ZDZAk2I+vr0sp9WLNVRefPNKwm1Enu/kzl5ZZZm9Bh/yTkLtFVAkze0TdmSoNGV8NUdFBZoRgXaJJI76M7bCTPj/N9D17uY9hMt0SMUYhEtJG6KI8y7ahVg6poQmunWS8B4eNTSYPjC54w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:05.8938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd94279-49b3-417d-35d3-08deb592fdc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       |  2 ++
 hw/arm/smmuv3-accel-stubs.c |  7 ++++
 hw/arm/smmuv3-accel.c       | 67 ++++++++++++++++++++++---------------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 49c10535cf..241639ec8e 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -88,6 +88,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
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
index 202b1aedd9..acc0ca5251 100644
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


