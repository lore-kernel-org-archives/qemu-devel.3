Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC53FF4198E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwO-0000vn-7I; Wed, 15 Apr 2026 06:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwM-0000r0-Ha; Wed, 15 Apr 2026 06:57:50 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwK-000438-Em; Wed, 15 Apr 2026 06:57:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJvfuJROq/B8X0Nn0uo+OgBxoSkm2vIENQxLXm9Zw0573G5EDcCxZ+TPEnjnGYbU2Hsm8icVCaEqvGbnkpRvSzcYeLQcvuEul6q8xw0aLd0F4G4vuPn9Ee5tzO9ma0NE9v1wvji8XPJE/TL3fu77HSyDDQ+TUxgqBpokhPtcrYbOWiLb6yWLMnnembrtbPKy8l1tLiuVBxy2aJGoglPjHPgEEHx6cveYwzfe0kh/lg7tXFo3UFokXt8sb5eIqvPYt7X8DVif8liEMKp8O4tWicjzAhDgrr/U5pZ6asveJIq4+Q6yCB8VNtOcZjFOQiBKfAY0wwT+8PdfMdE5dA94aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p4C+D+WPClM0B1yWUNVmHpxzgGjcviSdBy+Z2vVcnY=;
 b=qK+JQoxK+40hH7LkjhM5vV2rxJWjOSNZJPmx0YhLIrhdjrUkMOiQzMo4gj1qgFkwGwQ8PMGsEjhfnzdYEUMbh2qC4Z4uogFbCWdfwynSA6bKU79RUiJOQKlQ2KgI0U83FxIzEfcMuphZKeuaLZc4Z4ZDwD3iLKnjlCaKMxX55A9JIgbYEkUH42w7xBZVzzImvdtb676soFit/99CGMccESrEuekMfSBt67rioFUTAFBwp9CN2T5PFYEV/PnjQZ4oJNWSZGte6zf7JwbG26uwoArIsdj5lQpPpgYHbDT6j+QtpzwBdETlomr075CRtzC0GPhMaRPnEmamZKgU3eTCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p4C+D+WPClM0B1yWUNVmHpxzgGjcviSdBy+Z2vVcnY=;
 b=shbxpAZ//+h4bsHKKeM+lZ7NHZHHun+xunPr1crIwKAYFhjG5bUdKbjgLPni/FBYSn/Ii3rvoejEVhEgpjdScCs6mrlHBOG6NIxDldrHdauSbU7G/RUYXJlLrGcqr/hhVnFZou2gVc24WVLjH/Bygh7b+2D1KHZIWZYd8MQm3KF6YUqC8dCVDDqs2U6PX6rlib5T77EvgQSR/Mt+77oR+rYjrUpjc9AfA0SDxqly6Rl5a020eJ/UzDKnz4r9Rqt3ug3EkikuEG2sTvqyfvCUqD5auHsOZ6Gzb0ncShgJc7RljmPX0ECC43HvNWEVPTHxct1lkkFByZUyYAEI+qBarg==
Received: from PH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::25)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:37 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::4a) by PH0P220CA0005.outlook.office365.com
 (2603:10b6:510:d3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:21 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:18 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 13/31] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Date: Wed, 15 Apr 2026 11:55:34 +0100
Message-ID: <20260415105552.622421-14-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 5669c509-ab61-47e3-9c6e-08de9addcdfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hsBcelog3D3P2Q4UH8bZOtGqRJU4M9OSlMarZzJGn8BCXkkhdlPFXO+LB5rhCWEibWX04uzflXpsm3zBjYMDE9JllMayNJ52cE8tvabLBw67D9MdWn0n1uv7Mf0NMBmb3wxncGsx0sAFp9J+LYvK6xeebrPjvZOP6fkzS3rRo+bpFt6k2TMPXBTyUX1/XCtKvgrUgBsEg4OcFIK6hpBLUikJIzI7c0XbN1J3tjkX/MuNZAcdxFQv7YmVpqp1NiGuLFLa4v/tFWZxwwU+0kMpz4fw6hYioZiKsFoG0e4Wf09gGvl44fJkdViYoalE9A1P0prm1CTM3pv/JSsrB0cWGGPySHEoFGnZFaLalNhWl26z8RMn0kxPwChauPQKKjQcdhNHxOGaV4KvxAhmLYYS/DNS08CGC7yeFRu7cTrzVmslNmMXbfN7+18I+xdcIDUKDypmb8lx+o50jYejSr31tp0O2BintxpizSOx79tCyNQ9lsKkDaQ6stopO125qwnzwhatF10sLEtuDoltxxEB6cmz5DgKtpQOvgvb6+za7tbkUok2lbFjzdymEndnzMMTQZzBZRA3DSvM1TSOK+heXr6UbrYKEJ4NGRWZfFUW2xO3sOV7rtanlBSTCBrX3/3Raj/Tph5dB4r+oo5XbF98cK2AsHba6kW5U9JjdU0a3JGuIwJMhs2ny1slzOCwclCdmfQB8dNqlyO4fauJPpzqSjUGOUZHtPeoyZIn2CYjq/ZtnRuuspOIm1uf7U32UrbbI1Vga2zfXK4JE/5ZJ1mW5A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ejYrnnYN5S1GKONujhmHPsWUg1RIA8u2Vyxlw8hPXeR04Wn2HYgYRzIu++yB8Vh/eCqby8sZwhuDa3QLZDDiiv3J6EL+EY5RcAVgzUOr1ibYsNLp6TsCPxDEsL5hISO5vsFNfiwSlLaWfP2lvFD74oO+9NIFc6TzRQa1y0dtcAWV5w/E+1N6yZi8/kg7GkrJN5xOl3xuY33ug/Iydi00xGqMI6kVnwUE+59OK9wN7IQDLf31rBUr3AnHLaRdpA692ctxhHxlbkpc4ohjuZDXDDrsyh/2by7lxjEZuGXOrzxmIm8Z8iXPELXjLirbFR20Y79jyHW56X1YMfdvgv6r3QK26I2gsyqpNC5YYcLSuif1OaoR970sZPBXvsYDEaTedf+/eTONTQCpsYBS1R5vNZKLHauj1tuF3we7UJEoIlvjvhRkZjUyVZb7RgwrC7FT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:36.6212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5669c509-ab61-47e3-9c6e-08de9addcdfe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Replace the stub implementation with real vIOMMU allocation for
Tegra241 CMDQV.

Allocate a matching vEVENTQ together with the vIOMMU, since it is
specific to the Tegra241 CMDQV vIOMMU and used to receive CMDQV
events.

Free both objects on teardown.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/tegra241-cmdqv.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 2a34a4b6b4..fa0aa3ab04 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -30,6 +30,7 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    IOMMUFDVeventq *veventq;
 } Tegra241CMDQV;
 
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ccd3c6d275..2f1084b55f 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -25,13 +25,57 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+
+    if (!viommu) {
+        return;
+    }
+    if (veventq) {
+        close(veventq->veventq_fd);
+        iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
+        g_free(veventq);
+        cmdqv->veventq = NULL;
+    }
+    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
 static bool
 tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+    uint32_t viommu_id, veventq_id, veventq_fd;
+    IOMMUFDVeventq *veventq;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+                                      idev->hwpt_id, &cmdqv->cmdqv_data,
+                                      sizeof(cmdqv->cmdqv_data), &viommu_id,
+                                      errp)) {
+        return false;
+    }
+
+    if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                       1 << 16, &veventq_id, &veventq_fd,
+                                       errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
+        goto free_viommu;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    cmdqv->veventq = veventq;
+
+    *out_viommu_id = viommu_id;
+    return true;
+
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
 }
 
-- 
2.43.0


