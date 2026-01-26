Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8541CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK5r-0007AA-75; Mon, 26 Jan 2026 05:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5o-00074C-G8; Mon, 26 Jan 2026 05:45:12 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5i-0005Uz-26; Mon, 26 Jan 2026 05:45:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwpLgYF5GSEbhwVqkICCw6Lbsjyc6VZK2UzuyCtXj/SsPkYRu+4hZsIbXK2Xnj/fRyLIsDbp2li3qtKLuiLxqisZDDNEapPALVGtqIMCuL+/2nnoWArysxI1U9FzEWneYL8wJX8KaqMwYRhHP3kA+KveJM4GdGwpOFvhgY70HPz37yLNRogotdg0KfTKWOgX1U8TbxfbeTuw2PDx7o0KJagltNkhlCyGg18a/38UHE7DWX1zp7HABY6iR09Om0qknRwuErggd7pPJjupI/hGinI1Hyx5pgPl48Ek/9NOeE324qIeCgl3QlbkMNWfhP1RusGrcV3C0yTAum9uhMdRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sLTdlTkQkI82nizZ9ZBHUwEpMDenQNMu4zTFpytN3M=;
 b=mT3kueV2hCPt04h7pxBj2LiDmcg5K5SPJ5YILhyUDvfXWVor00nXYQC9TglPWxSQrOTbHyH+p3cS9yXMwtnOMMbMrzbhL/gsTIYR2nkP6/yvebownlXbUUw53XwueGCW/C/N4kBkRrGCef+Y7fAk8SDwjcERmXj3KQfNe5TdQ+AVDIEqhOG4t0glYr/xq5SuEtdNzS25MFqD6VQWNxz4UFlEgt93Ca+FLqqdJWGEb9tWq48iGJ6sAFfmP0jP6i/WW/yYBbSkW4KjnL2EJZjjHI40AAjG2iOWoNNR8qJYl0l2u+aITS1TZEjrwerdHEMPfNn4PwKma5mAtzm0dtmT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sLTdlTkQkI82nizZ9ZBHUwEpMDenQNMu4zTFpytN3M=;
 b=RH2dXuhdlucEySTRn+J1EJlMHB+r8iDSS+J72XgMCN4dfEUGd/TxAG2FgShSqB7vFSh4kuTGLHOEIXnkCzH+ivb5QHN4MA5zAK0qLiO3Tpld1HmuGpucCFVxJ5UIXg0SAFgEKT9RJ14wr7kC/Jhri+sYDbVcse7jFrXm8G0krbh6ojFrMrZ2L06/BI8iLS0WXr2m5a4gInrftx/njiGpZqg/B8kK/5zg+ZBmmDaIB8rm38rnnbwj1JqIirrUEqPABO42MtapcNqVodi0qFzRflFeVjHe5t+2Ojv9wL/63WcWPQCHk3NUYoAJaNY1NsS6NDqq2QToBAnb6X5D1jGZWw==
Received: from BL0PR01CA0033.prod.exchangelabs.com (2603:10b6:208:71::46) by
 DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Mon, 26 Jan 2026 10:44:59 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::76) by BL0PR01CA0033.outlook.office365.com
 (2603:10b6:208:71::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:44:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:44 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:40 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 04/37] hw/arm/smmu-common: Make iommu ops part of SMMUState
Date: Mon, 26 Jan 2026 10:43:01 +0000
Message-ID: <20260126104342.253965-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: fce9e269-d9b0-43d9-82d7-08de5cc7f3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkJjdTJPREsyZ21pUGloTFlzTVYwT1ZQdEFicFdHQVN1Yis0aUhVZjBvZDhK?=
 =?utf-8?B?eUdTSWRkUVRQY0tYK0UxRHRubnp3b0xRWnF0TytBOXdZbmhSc0M4VEN2RHEr?=
 =?utf-8?B?Q1Z1YUh4WWNBZTNOZ24rZ1JjNGFwV0cyMmJEUFU1OEVWdDdQOUx6TDNvNUg2?=
 =?utf-8?B?NWdyVHRkVlhFdllWbWQzLzFOcmNsc1ZZaG51NzBvdHplQ0JwcTYrMy9PYitL?=
 =?utf-8?B?NklJU2ZpVmdhQk05ekowNmJpdUs5M3VJVFMwYkN6bUY2YmxFUTczR3VzZ2Fn?=
 =?utf-8?B?MUFNVFAvbUcvaC8xTE5TYmxtbnFJZkY1QWEybHR0cGh6YWg3MFVlZ0wrUnY0?=
 =?utf-8?B?Yk8zVFBiMGpic3ZzWlYyb1N3eGdRUTBPR2VjRFQrWUZtUS9lNmRrcS9HdUVu?=
 =?utf-8?B?cnh0cDErcGxqaTFRblpxMkV3QW84bFE5MTJKdnNQTXFJeUVkMHpoTEZrM1Fr?=
 =?utf-8?B?Q0NiaEp0dk1TMXhRUkNQdmVmanhCeTRLOEhtYldreTVsOUlvQXZJQmhxd0ho?=
 =?utf-8?B?OVRBVFNDRVJpdEJSTHVWZUtpa3pvTjYvZEtmazIvK3paYkhteHpObUlBSHVv?=
 =?utf-8?B?M28yUDJ0bk1nNUR0ZmFqZDFEWGtiMFEyOWhCYlhPdzVSaUZXOHo1Q2VjdWNn?=
 =?utf-8?B?cWpxR0JmZnpSNjliN3Z3QXF4SG5LZjNlQ3laQnZoejk1MjRJYjZmWTJVd0Nr?=
 =?utf-8?B?VCsycG9Vdy8rZE9JL2g5Rk9JZWIwL0xwY0puTXpvSFRoaGdQdk8zRFJ2SXZa?=
 =?utf-8?B?OVpFV0dmMi9NT2N6UnBocUZ2SmxSblNxUks4b21OTmNzYjJxUE11cGs4RjRK?=
 =?utf-8?B?ejMwOE55UnFWcFhFcXJhRUg1V2V2akozdFpJaktnMjMvNmFPTVhpN1UwZzRa?=
 =?utf-8?B?TlVsUFNIVVlObTRJQjFjbTBCZGRTNTJQV01sUld4Y1U1K1Q3RTRtRGRxL2tY?=
 =?utf-8?B?UlZaNjRVR2kzcCthd3hNek5Fb1U3VGN0SWlScGt6ZFQrOXQzeC9qeFh2Um9U?=
 =?utf-8?B?NmtKRldIQytSamxieEtzWlFFQ09hRG1MbnJHemNvSmw2bmJWMk80YlllMkhC?=
 =?utf-8?B?cW16NDllSFN3dUg3bjJyK04raC84RXQwUENNaHJOZURVdzcrR1FYUGhnS2Jn?=
 =?utf-8?B?MkdldU1ibTJrWlQ3S1Vrdmtlb3dEMDhoTTZnTkpRZjBMYm5CK1VZbzU1Rmdm?=
 =?utf-8?B?NkJTcGI0YmdVSys4eVAzaGtUYVV3bDd4aXluS250WkY2c1hsZzZKQXV1ejVr?=
 =?utf-8?B?TFpSOUNYbnZKaG9yV09MWFk2bm9LYnppN3pWQWNJRlFYT2pITXA3MWVzck5v?=
 =?utf-8?B?Qm02Qnd2RG1SWnYvVlFoaHV5UnNTWnNsKytMQjVOckNQOFZMOUxrMmNLMWxw?=
 =?utf-8?B?dERiVnNrRmlzcGF5WldlY1hGMnNWM0NVbDRIbDQ5bHZTekpIUFhGL052K0xw?=
 =?utf-8?B?aU5sbnY3QVZYVVRsZStxU0JZcStCNkczcGNzYVRYcFd6Q3MxbjVETUR4aG9V?=
 =?utf-8?B?UmlZUVJZUjhNang3d1doQmlHSnR3UC96SVFORUxIWUwxNzRmdFVtTVFGM0dZ?=
 =?utf-8?B?ejN2S1VKL2tuQ0lTc1B3L2U5Wm51ODRBSkFGSzJaR2cvclNtaERqcWlFb0Qr?=
 =?utf-8?B?bHh6U0VUVVh3SG9MKzJzSXVJTXdxUHB1TjNrbmxHOUNOR2dabEhtVHdiQita?=
 =?utf-8?B?Q0FRdm05OVJ5THg0UGVYUDZHb0J1R0w3dGZVOEhXQnR5L3JLSzhXbWN4ZGNr?=
 =?utf-8?B?Qy9rNTlOWG40YTlWUm5LRmMvR3FybkVMYnkwQ1JIeUx5SVAraUdqdjRkUFpM?=
 =?utf-8?B?UWg1YXB1K1JtVTJTNGlnRzA4aUxqVjBjLzRuK1Zqd3RQeFpqdUVhUStWWXk0?=
 =?utf-8?B?U2NwNnN3NXppQ0Y2OUVQWGVsSmFNNVBVdm5hL1JLUUd5SzNkcTUvTi9ZamU1?=
 =?utf-8?B?RlhLcUpmbzJucmpDUmpVUG5IVHhQZjdtZVA3QXZDSlZkWTZESmdoS3ZlOFp0?=
 =?utf-8?B?V0lsTVYwWjdMVUZJR0RGOUlTWGJwdUpVc1dyYmdTU3Fmbkw4T3ZHb2d0aElD?=
 =?utf-8?B?c3ZqUFEvT2ZnUVFsM08vVm5tQnFTNXkwODczQktFZGt5QVljU09ZVkJZYVRN?=
 =?utf-8?B?bE8yQTBaM2lFRWFlL1VSQ0ltVmRHL01MT2NuS2RzY2gvWlRkNlErVndNRUlB?=
 =?utf-8?B?eEJjREFvd21KaFJmemtwcE1YMHVUWlpxeVlrMGsrR0FYRFhvTXV6TWwxWWZv?=
 =?utf-8?B?TmZNL1pCemNVbmsrU2NqY2IzWHdRPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:44:59.2331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce9e269-d9b0-43d9-82d7-08de5cc7f3f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Make iommu ops part of SMMUState and set to the current default smmu_ops.
No functional change intended. This will allow SMMUv3 accel implementation
to set a different iommu ops later.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 7 +++++--
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 1492d7dd95..58c4452b1f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -959,6 +959,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                            "smmu-secure-memory-view");
     }
 
+    if (!s->iommu_ops) {
+        s->iommu_ops = &smmu_ops;
+    }
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -978,9 +981,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
         return;
     }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index f5060cf36f..7b975abc25 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -166,6 +166,7 @@ struct SMMUState {
     AddressSpace memory_as;
     MemoryRegion *secure_memory;
     AddressSpace secure_memory_as;
+    const PCIIOMMUOps *iommu_ops;
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


