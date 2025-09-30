Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE99CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 00:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3NzQ-0007kv-0b; Mon, 29 Sep 2025 20:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3Ny3-0006sg-Cs; Mon, 29 Sep 2025 20:11:45 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3Nxu-0002QL-Vj; Mon, 29 Sep 2025 20:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY6M7nZOFwS/MOGOpXqmmZqU4V3SuF1Z+2YZaWqi1tW8kyl53LWIgcZF5buvfa3vGhcYGpCnnTGNv5N48Q1UDmyW/I2OuHGl0NXninxrHA6dJWegzRbdZ6V/jse0sCIMuj0s7RL842TOfE3HoDxyrjdOH7ouvjXZxsWpRMHU7VYk1Dgk4rAUsMZmmy3cJNqXIp9j5aoVr2AFi5yKrR/5Ivdyf6KkubPp87JGQkoNXwx3iYxJeChXzKQqorQxVgvurQ02pM/igeWh331ekfmTLQRZpQFt7H07ySREgjlKi4vP3STZ9Zq+MyN6bOtcYO+JJpKTTcL6m6ctyM2ya5GHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwuEdRbLarqLunaMKFTXZg8HZ2CXPwmBkPElBi4E04g=;
 b=nJEDq4y8GS/UhIuyxGFDIAqrGs6WTvgta8x9HtYiiHyc87odu2oGTLOIGYeA8yVtl+FFFmExz6yNG2TfiLAVIBo27w/wJoeiar1C69yhoHNo6LqYh1c+c1IXn/gfRmdjE4xTUzBHXPnprNC79faZOUM+jgiVWR45newPjNpMroPwmI4J9Q9vyl4JO3GOJCUetnfcn8/i1v1FgcVijsuM1ZJiD5g4zHB4hyVmcJ8fWknXsateWyQHpuVVg7STOyxi732k6TBSpV3qF6QW5vUvV3aIrIJi7gxAJTzdh1ViL/ZNVYwQd1ArrCDwNNxKE4YC1eaI/APoSsIviwHbhQwcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwuEdRbLarqLunaMKFTXZg8HZ2CXPwmBkPElBi4E04g=;
 b=isPDHi/gtHaCY6LgwIfruC3wrGUAW9WIW4Nl0kdt5HBw4ylkFhtkMAGtlr4ALwkGZxSj4NQRDzYbF2DMHU541l2ldHjuax/F/Up59dgpzestyTXnvlwCqK6jmB6Jsezrsv3j5VouzDGhSWvP1y4299LwS5sjElKD1aVGM98xvIKYOHH9aHRF0xWGiUKIcnfPywoQ9vFdHxTkdcq8WyC0zmpFLpcxuC9TTkUstSjUlK2biRD6GXlJ5tHRCNvljAuujjvYk0myv30OYvpPJc3VJ+if9cImAKsRU5Y7cUY2zt/nOyTqtb55ZCoukCczuU6jlgST503G4oAEMd0N8LIMDw==
Received: from CH0PR03CA0423.namprd03.prod.outlook.com (2603:10b6:610:10e::6)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:11:22 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::99) by CH0PR03CA0423.outlook.office365.com
 (2603:10b6:610:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Tue,
 30 Sep 2025 00:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 00:11:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 17:11:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 17:11:11 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 17:11:10 -0700
Date: Mon, 29 Sep 2025 17:11:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aNsgHV/Ebqx0WZXf@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929133643.38961-7-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: aa898674-a166-49fe-56e5-08ddffb5e2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GrsddmqSNKOI2BWpCA8Ow6L/201J0GQzrSPWs/iR0BNCXc6Q2lwSP42dX5uJ?=
 =?us-ascii?Q?MhQxq1OFMFQ0NYrCer6s8nWrafaJ4XXFDaqKASm2Con7zluhdq8rs5xSFtpj?=
 =?us-ascii?Q?6MR0+jPwkcGfigLETB6wWqa65rvT4gHTpqrKE5YFVB1p6aegF97YgTFG7avw?=
 =?us-ascii?Q?EcBO67wCCrXMidC+R0NJJ7aaVjeuAGC4ZTDBcqbg/vXwl3Bgl9Ea+p1N3f6f?=
 =?us-ascii?Q?66xx4u7sCNHLI8ofHJ+G+tWj2rl5QunyPQ+nGkuD9shnZIoQ5OJRndOVvkLU?=
 =?us-ascii?Q?4W+TCyzPdMtLykzK/je8O9irlOyXhTk2XjllmHExWYFNT+1u+UPh/OyqytpZ?=
 =?us-ascii?Q?nkzNvaXIhnyc4aqa/ZgAjgFNsYKQRUz5M64wWhQMUKT7tqVYQGFv/wixSjeC?=
 =?us-ascii?Q?TTyJF1ZMM8EIm/5IjTHqUUfaSfq5ITMiLp8VnWq3useiqeZi2eUahiRJz+T0?=
 =?us-ascii?Q?ogfmW/0JePSCAGJsNi98e63hUH/bgOsNj7Cn/b6SP15eFNADhBDC+AD5ZqaE?=
 =?us-ascii?Q?SOqP1QUCT7pb6bwoygjpQpfbxJSkGZ5UTpwvxGXA9mL0BqFZYvELPeR11Sa7?=
 =?us-ascii?Q?3aQVvOZDC47TmeZMWI/hlwhHMqckd/TvFbwD6kyS+7TgVGv9OIFxN3bdcBzc?=
 =?us-ascii?Q?UB8ycsp4P84zJEchhjDRQ/7NsdqLQM+xy2LEmaiOxgGIxYzdfN4JLuZ/yMZy?=
 =?us-ascii?Q?oZxHb/GFnTvo+pKQ6y9DXeWbRguLQebV5X6pzWOeq9TKmpUbn5PLuTZ103DI?=
 =?us-ascii?Q?atQ5Fufplruv766VUWzP7zgZ0jT8lm0/pE7KprHGdtxSz6kIy7OXrnNqYANb?=
 =?us-ascii?Q?JvmLU9nQCkfj1ihcAxD4g32yiie/yWPJagVr4sE4RHFCr735GKI+XYt7fVyh?=
 =?us-ascii?Q?41a05CLQ5ihvh5QeBXhvRq0LRHxbVa8qIHkR2SjiCUBIbxUUxFrLKnVIdZTM?=
 =?us-ascii?Q?ZOo327nLKbAHSl/6afkwZglWDjcAkrG/WQxqilFs8tsf3c0IzkHCbHkR98NR?=
 =?us-ascii?Q?8RJAL95Zhb+5PSJ85zxSYr1lOEf8mW5ueA1YpQ+HyL+/QkWUOqpE0Y/+ZkZ3?=
 =?us-ascii?Q?cJKhfhufitX4bSUMWQxM7qml9bTiehx1si9DpTIWrm6AstzsB/Ji5D6KjiMm?=
 =?us-ascii?Q?h2iusiPYHJXCkw0L1l/61l3SJpc3iOkJ6Dp47OdN3NOh9Q0gzZuBiorp6lSw?=
 =?us-ascii?Q?tXfeGdINiVs/tDMNYi7vTLcwe8gdEaxTs32vflElG87WPywq38VuiIUb1o9N?=
 =?us-ascii?Q?89kg3YzAMdt10tjvF3mS5BUYq9B+duOrF1JNQ2s5BwXGK6DjOIYxlIqw+33J?=
 =?us-ascii?Q?jn4n6apCVl2ird3EQrcpGk+Ggwx3mqKq8wFtD5T1XXvMat08QBlyp74wCxIv?=
 =?us-ascii?Q?cqusBlYdDy5+jjBBOZVCeK5r85tAkFSTVsJ3vvBlZEXShBe49Isw26uM4eMk?=
 =?us-ascii?Q?/G1DsMNOYXvvciTs8de2O9YdLUEWKRb+pyRG+rOaVfLGyUhetnwqAxHJ9/LG?=
 =?us-ascii?Q?r2TAiRUAuirXKUidWPjxbJkPra9o4YJnJxL6dAFNHdy9+DkmEFfE7G/2tiy3?=
 =?us-ascii?Q?drL4BFJ2UXRh6AVCtDk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:11:21.6301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa898674-a166-49fe-56e5-08ddffb5e2eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Sep 29, 2025 at 02:36:22PM +0100, Shameer Kolothum wrote:
> Accelerated SMMUv3 is only useful when the device can take advantage of
> the host's SMMUv3 in nested mode. To keep things simple and correct, we
> only allow this feature for vfio-pci endpoint devices that use the iommufd
> backend. We also allow non-endpoint emulated devices like PCI bridges and
> root ports, so that users can plug in these vfio-pci devices. We can only
> enforce this if devices are cold plugged. For hotplug cases, give appropriate
> warnings.
> 
> Another reason for this limit is to avoid problems with IOTLB
> invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an associated
> SID, making it difficult to trace the originating device. If we allowed
> emulated endpoint devices, QEMU would have to invalidate both its own
> software IOTLB and the host's hardware IOTLB, which could slow things
> down.
> 
> Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
> translation (S1+S2), their get_address_space() callback must return the
> system address space so that VFIO core can setup correct S2 mappings
> for guest RAM.
> 
> So in short:
>  - vfio-pci devices(with iommufd as backend) return the system address
>    space.
>  - bridges and root ports return the IOMMU address space.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With some nits:

> +    /*
> +     * We return the system address for vfio-pci devices(with iommufd as
> +     * backend) so that the VFIO core can set up Stage-2 (S2) mappings for
> +     * guest RAM. This is needed because, in the accelerated SMMUv3 case,
> +     * the host SMMUv3 runs in nested (S1 + S2)  mode where the guest
> +     * manages its own S1 page tables while the host manages S2.
> +     *
> +     * We are using the global &address_space_memory here, as this will ensure
> +     * same system address space pointer for all devices behind the accelerated
> +     * SMMUv3s in a VM. That way VFIO/iommufd can reuse a single IOAS ID in
> +     * iommufd_cdev_attach(), allowing the Stage-2 page tables to be shared
> +     * within the VM instead of duplicating them for every SMMUv3 instance.
> +     */
> +    if (vfio_pci) {
> +        return &address_space_memory;

How about:

    /*
     * In the accelerated case, a vfio-pci device passed through via the iommufd
     * backend must stay in the system address space, as it is always translated
     * by its physical SMMU (using a stage-2-only STE or a nested STE), in which
     * case the stage-2 nesting parent page table is allocated by the vfio core,
     * backing up the system address space.
     *
     * So, return the system address space via the global address_space_memory.
     * The shared address_space_memory also allows devices under different vSMMU
     * instances in a VM to reuse a single nesting parent HWPT in the vfio core.
     */
?

And I think this would be clearer by having get_viommu_flags() in
this patch.

> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 1bcceddbc4..a8eb2d2426 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -48,7 +48,6 @@ struct PXBBus {
>      char bus_path[8];
>  };
>  
> -#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
>  
>  static GList *pxb_dev_list;
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index a055fd8d32..b61360b900 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
>  
>  #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
>  #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
> +#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)

Maybe this can be a patch itself.

Nicolin

