Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704DFD3C90B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPg-0007W4-Dq; Wed, 10 Dec 2025 08:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPZ-0007TE-UU; Wed, 10 Dec 2025 08:39:21 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPX-0001OR-Hg; Wed, 10 Dec 2025 08:39:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6QdyqVazp2ly9Sx1wIqyLaztVXVS25RdQUHWBLc66Owq4IgSYyOkcE2sYAlBLyojXoI6yeO8g9b9FtLW4sJGtq9DXylxz4uSUQYR8OWPnMWFLe5Id3gzo6LKlGrAKj1Iy0RfX6MDOAisB56NJtS3qfiAazjBDGeaMMSsgXAJsdGFZyGMjX5h0iq/6kiWntuTbD2JQVhXNqD31/VfugEmovkouxiStcQ9gKzcpK+EvghPai60OTIwXzsCowybYzlBfsYPcDz6ABQCviHi/prKqaVdO89sTCnOx3prY+IsRTevrcywN4IheMYUcj7Mahp+vCC20kmTPNo1gZE5iTRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRP8/FzCTgOGUZmD5lYPAwmEtSuvTVE4Oo/CuLwoFuI=;
 b=G5XO0rnr9UvW8dZD3r+Tyv2dOwspPqxjCUTo9pI5+KpDFxAfJ8buuIFWNypBq+y+SPh1QRwF+Bt3bYVuCQx2bWAUYnCiu/BqKkowQv8wQaUonYqGLPWW6Fr5Jtgn/UAtkGrzjTeJCgK4RtRa2zBCqKQxtv6m5V2W6CJAQpNWCnP+Sm3wfdTm8+alRdJd5eWtJcrfZUoM4O9AkKYIGNkOX5WswjzQDXHkEGqTkIlyphKW53BX2Ldy743TDhbHNhKYbN1SDZro8OaP2iQ4fWc+mf1n0jysvqAvbuvRAdBo4+jhdpszJ3n4HLWmUvP+Y3pB7FwU36macoV2wEfriuzsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRP8/FzCTgOGUZmD5lYPAwmEtSuvTVE4Oo/CuLwoFuI=;
 b=G8qJSLEKrCPyFzswImuHcXDc37rC48N9EIz3pmR19o9WamKF35pzTlQbqBoBw1VUB/gl6SwubiICpZmygrojFVFEtEdetvjRRWu9zpwgXx4xzphl5zK2zRe0HJjVt9zznrkTJ9MejeXTr1BI/HcCj7goAj/aq8fEiNdouiq1TlhKKpMyISR//zJBPxJL4BZw4urZ1ccBLAUPkMiry/dLqlDxTwJrTpF0jUErSfJsyi3ZaSmmXmCZ8a0cAnvIhumfSf+/J7dUbqgt/Dbd/TNAzwH/iMHHGvo6jhisw3OMioEDedO4zXsinjLgR+lkzJUIqg7YFJlBnWrtQfRxdUuq6g==
Received: from BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23) by
 PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Wed, 10 Dec 2025 13:39:11 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::ea) by BYAPR01CA0046.outlook.office365.com
 (2603:10b6:a03:94::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:39:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:50 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Date: Wed, 10 Dec 2025 13:37:31 +0000
Message-ID: <20251210133737.78257-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee0b03c-486e-49c1-2e28-08de37f1803c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f0ZbUWHz0gJsUYR+pHSHgaDaiShGHp7L+XZsfW54hiqANGcqB61wJKXMYlQc?=
 =?us-ascii?Q?wQv+xRxxthw6SOPqoQcDllSkV5TJ3jHzJ4bh/PD+ch9qtkct+d1Lk9BdXJqn?=
 =?us-ascii?Q?Bd7oiywiu2z285F1f9DvLXbJKpIZjnRsLaRNiaM1RnfaJq8dcq7PEoYxaog0?=
 =?us-ascii?Q?TdKIsIMmcjypYDrdYoKxO72fGZGo/ArUWaYPKStWCDlg1J31G9C7MKoheSWB?=
 =?us-ascii?Q?IAZvwCU1sexAMtuJpZykVvyeNymX+IrhoQw7V6mjdWWFzXaaBawwK7rJBe7d?=
 =?us-ascii?Q?BaC9pZ1QiTt0t7GVdU8v0puf510cU7lGfLLdV1VeByV4VwEjHU/BtHQFK6Zi?=
 =?us-ascii?Q?meDTXpO4Wi4AFEMnve+oICPWRo+PoICqXxVS99xHZXAy5kxkI8V2Po1trFvJ?=
 =?us-ascii?Q?cabFdqmXM4pfXSqSuPNtNaMFwqtsimiOY7S8BMrd6xnmo1lGt30YvrvagilP?=
 =?us-ascii?Q?Y7ZyGhpWSvDceRjdENzfvmkJvNOgNEDDRNnU6NqVa7zInA6Q+tput3fGkdPr?=
 =?us-ascii?Q?ksab49Qf7WpLXVH3O9hKAgiLPPIwBCOAdNKPUMHgeVaxXt5E58adU6ZGH7nj?=
 =?us-ascii?Q?kkPEqLVzYGlOipKO4CnMNnn94W51662uRc88YVo6JTFJXRNjzGeNz/CE26HT?=
 =?us-ascii?Q?mh5JbGuNVFclXrxnA78O5TPHoaCZyZJwhnwhr0HiRyV8Ln8Q/N/CoQJoYImT?=
 =?us-ascii?Q?23G4I8Ll/6WNXTtIpjNOZq7ljWjyneXF67yUpOGw/Ulxnm0uc0zMlYxvLttW?=
 =?us-ascii?Q?dqAFzYV17WEXSP+ce1n5Eovg2+3RkkwfMPmNuGqs7vm7wKy9b+VNDphOB/gP?=
 =?us-ascii?Q?t0JrW0Y7UM7uKpF899bl/Rhkh08IoMLqPZUxQKRkh+8fMY/rQ+qiklUV0sBB?=
 =?us-ascii?Q?3knIFbUNO77sUEFyhUwNSBhG36bGaPc2pFeeQq0Tp480983H8P3bAjtQh+rD?=
 =?us-ascii?Q?9n/V6y8aMsUe6lQMkIrnSjh6JgqIeBzdtfpVfxr04Tm93fWNjtR92PacFhSG?=
 =?us-ascii?Q?XwgPOlxnx1IEUPOZrL5qG/M61q7I2+3ii9QhuBWj2zzKnImY/qa32Kf4ia9H?=
 =?us-ascii?Q?x1ru9UL2yyJ8dlkLeT6K63xDz7YM1BzsAS3ZkfeMMPfXrDvmHsKtzXqm0+9i?=
 =?us-ascii?Q?0Uz1A6lETApPEC+n7zY52nVH+++pazqhrd75AUkeAbnqqEpsnhvDuhT3pLTu?=
 =?us-ascii?Q?0/RKp+sLJgLMPTsN6ihggX3iJWQHUc5DSYmS1NCVXN9hYjc9CSj0OlJby4Wr?=
 =?us-ascii?Q?NG/csTTTJfyC2pabumdZMuXo/q1rE1/sP86GAuQTB3b9AzeI5TzGmCcUUUEK?=
 =?us-ascii?Q?Urd+8ez4R8aj8uGMWFVQdGstGLlwedTGfPUhU5xkj4HtOPg87AP3jAmW9NPA?=
 =?us-ascii?Q?A1ygIVo+TR/Vmr8nViEzuxgjfJ8NycwoMF644OJ4abD4u6sFr/VaDEIS09I9?=
 =?us-ascii?Q?0ARo6NcadISEP4L9yfaLuvRrQl3R3S4Wh3OUyTO6CxNvqJkPNzWU0buGrceK?=
 =?us-ascii?Q?ZNtmROscKOIhoSz/700ORBYUWu0bwHcFLmSial8XNYxe4lVcE8NVfARB3xzy?=
 =?us-ascii?Q?9xaZj9C5WGu0zpMrohE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:11.0308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee0b03c-486e-49c1-2e28-08de37f1803c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
Received-SPF: softfail client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Allocate a Tegra241 CMDQV type vEVENTQ object so that any host side errors
related to the CMDQV can be received and propagated back to the guest.

Event read and propagation will be added in a later patch.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 51 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  1 +
 2 files changed, 52 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 5e9a980d27..812b027923 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -136,6 +136,52 @@ static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset,
         return 0;
     }
 }
+
+static void tegra241_cmdqv_free_veventq(Tegra241CMDQV *cmdqv)
+{
+    SMMUv3State *smmu = cmdqv->smmu;
+    SMMUv3AccelState *s_accel = smmu->s_accel;
+    IOMMUFDViommu *viommu = &s_accel->viommu;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+
+    if (!veventq) {
+        return;
+    }
+
+    iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    cmdqv->veventq = NULL;
+}
+
+static bool tegra241_cmdqv_alloc_veventq(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    SMMUv3State *smmu = cmdqv->smmu;
+    SMMUv3AccelState *s_accel = smmu->s_accel;
+    IOMMUFDViommu *viommu = &s_accel->viommu;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (cmdqv->veventq) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(viommu->iommufd, viommu->viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                       1 << 16, &veventq_id, &veventq_fd,
+                                       errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
+        return false;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = viommu;
+    cmdqv->veventq = veventq;
+    return true;
+}
+
 static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
@@ -259,11 +305,16 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
         g_free(vcmdq);
     }
 
+    if (!tegra241_cmdqv_alloc_veventq(cmdqv, errp)) {
+        return false;
+    }
+
     viommu = &s_accel->viommu;
     if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
                                         IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
                                         index, addr, size, &hw_queue_id,
                                         errp)) {
+        tegra241_cmdqv_free_veventq(cmdqv);
         return false;
     }
     hw_queue = g_new(IOMMUFDHWqueue, 1);
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 4972e367f6..ba7f2a0b1b 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -24,6 +24,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_vintf_page;
     void *vcmdq_page0;
     IOMMUFDHWqueue *vcmdq[128];
+    IOMMUFDVeventq *veventq;
 
     /* Register Cache */
     uint32_t config;
-- 
2.43.0


