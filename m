Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58806CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBJ-0005UC-7M; Sat, 30 Aug 2025 11:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUQ-0002uk-L2; Fri, 29 Aug 2025 04:29:43 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUL-0006QC-9t; Fri, 29 Aug 2025 04:29:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGvx4LNDFdgMrDc8EAiCtZp4D6cE8C7LicB6sNow2+sNttYs+drQV7+SfKdWUanztEaHiAcyC6KEvoX+mC6E+cArcBYLtFcaPSDauZl+Dqe2f8msNgpUl1MoBg5DSVnsx2pUWF0CHkZtpD4x4FdLrWhOIpwab96dN2GFpU3s2Vkqds2HcUxmHpNu2YORyVVoAaNJe9wmseK/HKYDesbZz5h7/uGuz4fKi+IFRQZ+CdI/nFmKdJ/Uz43mx++6c4iCjsOxJcvYdpAdZlrNIaN758v1GhiT49Ed8eYOpb+7I1TGZTEBfyFWrwQp/TLBbE/aqym8JtrPkjy0RYWxg6ngLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXTaYNhXa6PsWcyqfVyVATmSC6JTnkjfHpbmLc1oisY=;
 b=Ugq80laYatJrtcTS0YtJ3cSYpXL6usR6pGCY9rQ0qUhE9fooIqE8T/clGVZDXeZiHzAEVk3xfh98RUXD1A8jYO1BbAvJucWpy9vSaI5h2FKIFMx5y9wf2tYJ78d2tHFByJ/8XwodTOpLhXohTGJ7rynMeW6F1vh8IDXwt0X50V8Yi8WiXi9V0LXuGUd/yJnUXEn3i61hpTekFakfI0S5U1lnusiGfB+44Ucf3Mbb9VZYQIxjEJYzCVlM4eq5gaoBjztUuzgna2dl+1v9Dx5ks8IRkoi3H0c0HbpsiMOt4DR9kpfcdXjF6YUCuU0q4HQP3HNFajcYzbVLXmslgKy66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXTaYNhXa6PsWcyqfVyVATmSC6JTnkjfHpbmLc1oisY=;
 b=fEoEXyZEkDDY2JD2nNVjvNm4y9ESWqZ8cTl2zG14cmWgMqC5uRyCct29hSJRQQa2K8Y7TzIVG14ZyXE6MdFjsguKMv2o7fofcKAdMhkIJ1CsxxWISzUPmzmgMgyeeBfyyfbyTUy2jcfe2bJVqpZ0Dvje6DEEMWL8E9XwG5U49m3i69ZvyDMiAG7rqvrxKBHFdEkHOUA7PjEFUdVl5+duy5XuWkbNclEwqLB6d+a9JfKKkO4kgOMSQTN8u3wROw3zyv/Ag2ONtB6GXrCD0gq9gavlKuZFNfHFJ7nSU+Yb3Infdsge+GwqQC5EOCsT5xOMo+M66W/AewzEbStzG2Nfxg==
Received: from SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 08:29:26 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::87) by SJ0PR03CA0370.outlook.office365.com
 (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Fri,
 29 Aug 2025 08:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:09 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:03 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 06/11] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Date: Fri, 29 Aug 2025 09:25:28 +0100
Message-ID: <20250829082543.7680-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f7bc4f-6657-497e-f6ea-08dde6d629ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWorTVBBb3ptb3hrUVJJVml2aW15SnI4eU42T2NYKzVVdmFsdTZFS1o1MTBM?=
 =?utf-8?B?aHl3NVlDRlBTelhLcGpKWUdVQXhoQWt1VDFjd1ByeThIMzBpM0dONVZNSjJr?=
 =?utf-8?B?SGJ5NXZCelp1L0V4ZlhvdFZvVmREdllFdkpwYmFnZElBV3dvT1kzaFhkWVc2?=
 =?utf-8?B?WmJoSWgxZzZQemVISVRqZ3dFOW9wcmZ6OHdSZG0zMXJWVGJMbEhMUFRjTTQy?=
 =?utf-8?B?OGswbC9KVkNONk1PaWlMcFhxZ2VsSXZZNGRSMm5RdS9lR0V4STkzUm1vMlc2?=
 =?utf-8?B?TGxTTHJYdmNPanA5OERlR1VCU2NGY2M0aHN0cy9PUi9oWFFrRTNYcDlWTC9U?=
 =?utf-8?B?SVZuOEEvV2srT3B2MXlhRFprTUh6SkJ4UytHSmZUS0dYV3pqVlRsQmpyemNT?=
 =?utf-8?B?ejdEaEVHNDN1eE1tNjZWYTNsZnZOdFAzOVdBT1gySUw1MHNpdGFFVDBvQmEx?=
 =?utf-8?B?WEg2dWdETzh1dG8weENQUGRLcnNuVHJnQWErNXFvRms3N3FvdTBzQnN1STJz?=
 =?utf-8?B?WGtiU0RaWk5zUlFrWllES0M1OVJTVlpXZHYxb1lEdy93eDZQMFdQNXdWUnhu?=
 =?utf-8?B?U3A3Q1JJUU0xcU9MR0hxcUgrVnpTS2VaU2dRRTkvRlhISWlyNDcvWVhvWXVD?=
 =?utf-8?B?cXhyVnBjRjM1S2RKZkt2eE41MDQydFhFeHQvS2VPQ0hYOXJYdytmaEhFemNR?=
 =?utf-8?B?cjhsaFN6QjVOZ0VhYkc0aGY5c1EwbklaeGc4OVk3d0NJNDByMm9PdVFXcTdR?=
 =?utf-8?B?OWxSS3ZzOWdSeXM3Y3VNR0c4OHFxTXVUOU8zZGtYN2hQZjYxSUFtVVZSTVRo?=
 =?utf-8?B?b1BrTlF6QzZkQlhGUHZCKzN4N0VTSEI5MXNOREYvQXhuaWs5UCtDVk54RjZK?=
 =?utf-8?B?M3RyU1drQit2ZG1LR0xRNGNZTWtOM0Job3ZNOU9RdmswQy94cjM4djZiek5y?=
 =?utf-8?B?S1RodVRrbUs0ZW44R2FBMDBEQms3aW5sY2h3UlRMalpEd3pBdGxkSktOUDVn?=
 =?utf-8?B?MjY1VmhkUC8vRlpabW1abGxIVStIK3lyYXBBMm5ZQmhmSGxZOEs1SlVFVVNS?=
 =?utf-8?B?U3FtU0I2ZkxvTXpjU0FLU0lWeVF5SThrQWluUjVpRXhVQTRzUW55a1lJWFYy?=
 =?utf-8?B?dm5XQkUxdzV0eGREK3VoMVlVck5DQ05FM1ZzbGdBbVZMUG9qU0RUYWhQSS9N?=
 =?utf-8?B?eTlhMlJVVHZQbDk0eVBUbFlkR0tuR2FMQTFrTTlSd2FKb1ZQc1hwSy9iM2lL?=
 =?utf-8?B?a0F6TnByL0ovRUFldTZvM2VzTTJtQlhUWGRTNnN6UTJxV3lFVGNiL1hKMWlK?=
 =?utf-8?B?MGgzUG1wVWlTYzdGbThRdWtlRU9tZXBpUEpEeDVNUVJVMmx3ZjNreVJZbG93?=
 =?utf-8?B?L0lySW5zZFo3ZjJHaHc3Mk5keXBlL0I3czFOUWFjaDRXRkYzOG1JUEZPYTlJ?=
 =?utf-8?B?Q3JHWWxKUWwxQUwyZUswV1RCdVBPTDYrZlJwbHdHZ1hFRkRZTDc5WWR6WmhJ?=
 =?utf-8?B?L0kwd3drREhpdGN6eHRvb2dzM2wyR2s1aGJZSmkvSThJenl2VXZuNWVxUDAy?=
 =?utf-8?B?U1pJUkZCdURPa01mUXpLV2g4aXUxRHhjRVlzdE1EWUpJVEVwQ0hUZWV4WURl?=
 =?utf-8?B?VWZsdW40YnZSa2pHeGpsUGdEd0QreDA5SlU3b0tDQ1lIQkRJTkU3MWwvMVR2?=
 =?utf-8?B?cjZwL2pOaGI4K1VBQmZURGpsQWpLYkdDbHpNR09iWG56RkVmS1dvc1FQYmov?=
 =?utf-8?B?bGw3WllZN0JsdTlBM3ZzWmxkRGlUQ1pCanpodGt2bTJjNHA4NHVoemVFeTZT?=
 =?utf-8?B?VmJ0YUZITkJPblkwNlNna0ppKy92cU84cGM5NHlkblVnNEF4NDIvdUtyK1M2?=
 =?utf-8?B?MFQ3Y1VyQ0RzUzdxSmdiVHAwcnpNd2lNVVg0MXFQRGFVTDl0VXFHRXhlUXVq?=
 =?utf-8?B?QUpoYmEvc1FwUkUxNFNFdnNPQ0pkd21uOWcwWVRHN3E3aWt4aUxFclJkdmlB?=
 =?utf-8?B?cXcrakRzU1d4UmJqV3Bna0VZV2EwalZPbnFpMUZMQmZySExESXd2MVM2ZWR4?=
 =?utf-8?Q?tSce0i?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:25.6146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f7bc4f-6657-497e-f6ea-08dde6d629ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
Received-SPF: permerror client-ip=2a01:111:f403:2417::601;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

Currently, pci_setup_iommu() registers IOMMU ops for a given PCIBus.
However, when retrieving IOMMU ops for a device using
pci_device_get_iommu_bus_devfn(), the function checks the parent_dev
and fetches IOMMU ops from the parent device, even if the current
bus does not have any associated IOMMU ops.

This behavior works for now because QEMU's IOMMU implementations are
globally scoped, and host bridges rely on the bypass_iommu property
to skip IOMMU translation when needed.

However, this model will break with the soon to be introduced
arm-smmuv3 device, which allows users to associate the IOMMU
with a specific PCIe root complex (e.g., the default pcie.0
or a pxb-pcie root complex).

For example, consider the following setup with multiple root
complexes:

-device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
...
-device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
-device pcie-root-port,id=pcie.port1,bus=pcie.1 \
-device virtio-net-pci,bus=pcie.port1

In Qemu, pxb-pcie acts as a special root complex whose parent is
effectively the default root complex(pcie.0). Hence, though pcie.1
has no associated SMMUv3 as per above, pci_device_get_iommu_bus_devfn()
will incorrectly return the IOMMU ops from pcie.0 due to the fallback
via parent_dev.

To fix this, introduce a new helper pci_setup_iommu_per_bus() that
explicitly sets the new iommu_per_bus field in the PCIBus structure.
This helper will be used in a subsequent patch that adds support for
the new arm-smmuv3 device.

Update pci_device_get_iommu_bus_devfn() to use iommu_per_bus when
determining the correct IOMMU ops, ensuring accurate behavior for
per-bus IOMMUs.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c             | 31 +++++++++++++++++++++++++++++++
 include/hw/pci/pci.h     |  2 ++
 include/hw/pci/pci_bus.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..0012cc12e7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2909,6 +2909,19 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
             }
         }
 
+        /*
+         * When multiple PCI Express Root Buses are defined using pxb-pcie,
+         * the IOMMU configuration may be specific to each root bus. However,
+         * pxb-pcie acts as a special root complex whose parent is effectively
+         * the default root complex(pcie.0). Ensure that we retrieve the
+         * correct IOMMU ops(if any) in such cases.
+         */
+        if (pci_bus_is_express(iommu_bus) && pci_bus_is_root(iommu_bus)) {
+            if (parent_bus->iommu_per_bus) {
+                break;
+            }
+        }
+
         iommu_bus = parent_bus;
     }
 
@@ -3169,6 +3182,24 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
     bus->iommu_opaque = opaque;
 }
 
+/*
+ * Similar to pci_setup_iommu(), but sets iommu_per_bus to true,
+ * indicating that the IOMMU is specific to this bus. This is used by
+ * IOMMU implementations that are tied to a specific PCIe root complex.
+ *
+ * In QEMU, pxb-pcie behaves as a special root complex whose parent is
+ * effectively the default root complex (pcie.0). The iommu_per_bus
+ * is checked in pci_device_get_iommu_bus_devfn() to ensure the correct
+ * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
+ * it's not appropriate.
+ */
+void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
+                             void *opaque)
+{
+    pci_setup_iommu(bus, ops, opaque);
+    bus->iommu_per_bus = true;
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6b7d3ac8a3..6bccb25ac2 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -773,6 +773,8 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
  */
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
 
+void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
+
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
 
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 2261312546..c738446788 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -35,6 +35,7 @@ struct PCIBus {
     enum PCIBusFlags flags;
     const PCIIOMMUOps *iommu_ops;
     void *iommu_opaque;
+    bool iommu_per_bus;
     uint8_t devfn_min;
     uint32_t slot_reserved_mask;
     pci_set_irq_fn set_irq;
-- 
2.43.0


