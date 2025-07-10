Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB41C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 23:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua0F1-0001mP-Uu; Thu, 10 Jul 2025 18:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ua0Ez-0001lT-Fv; Thu, 10 Jul 2025 18:59:45 -0400
Received: from mail-bn7nam10on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ua0Ex-0005Lj-Fv; Thu, 10 Jul 2025 18:59:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXWYImFtK9vcRT5XMImgUlweZg7r++wQjGbEN7ARGb2i7CYRSAjLc9EFP+jQax0b/R+P6jAkX3F5KctfnX6ddWdcKE4UUjS5zlb3EIskRSVNHGHAynSNVRn9drw10uJvyfHyji5BAKPbnNi61G+keyoSy3c+bXodlvPwxdZzNq2muTLb/wN6YY6a++FiPVNE414fsS2Dj4by9H59W1HTAyNTUSLRvaeFUro483R/t3jHJmwEW4V42i83yyKaWZHZbsVAF+MNNFSdcf3CHk5tVKk/GucYXx+k6Bou4A+evd7eSShfF1bGnwJ7/F63bucsRzGm7jkEOS9xE/7xCEm5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us7pxLIfx52ZHZ7YYvP9v3wsMMSyJPO9f40gNge/XjU=;
 b=LLkgwgRRji8MoNwH1dd/nVRFN/1nhStAH41a0hTqzL/Uj5+OKBvQG3NxG58Jeq3mYcnRDCIx0WcIYdWF/tC4tCoUE/M95xrCifKGTNky1nkKWqoiIto5pGyaDf33HcIpQjNnp9B182SZJroB3rF/LgqtZQ46E2KQ6/Qnbg0I36b/rvPjInCQG2X69yKFsun2HSPCRMAY9Mp/w41vmnYGZw/pwVygphdMYixRHbjluxx3NRkss3WJEqu8xL4DmgWroXB34CXuJDojzNF+9QkzYnDmuFBC2mAWOARPOd5n2ry1Iy6FgExXNkvKaHujNh2B7VkfjjxKOHlSa7Ldpkj5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us7pxLIfx52ZHZ7YYvP9v3wsMMSyJPO9f40gNge/XjU=;
 b=tnPiTevM0I4nb7R1TiyEMBsB1zECqyKkH/F4kGs4+au07yjSe3AdsZBZjFKXLMyI6Qrsq98+qyBKE9jp4Tw/SJIzljJNQQmjNeDDQNmZWHVIiiLh21XNuewr8kJUMSXUbN3j7ScNJ88sw3k01Y4PdSD0IJ2vUMIY2UfH6KvLyy8g6lrT/z490z5j6GlPT+mrALAOjVLD7xf1+RruDLc7OJBeNhWoqoXLILRfhPTshY+89TDqSpKJtfuFYjmdtHviTUJ/Pa2OoHPHSyuukQ7ATHdacqfgUXpjdjKSXFt3JD6ZEVHqy2LA5USrHwkPbBMRI8Ip+5nLkk/O7uKya3N+UQ==
Received: from SN1PR12CA0089.namprd12.prod.outlook.com (2603:10b6:802:21::24)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 10 Jul
 2025 22:59:38 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::31) by SN1PR12CA0089.outlook.office365.com
 (2603:10b6:802:21::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 22:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 22:59:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 15:59:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Jul
 2025 15:59:17 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 15:59:16 -0700
Date: Thu, 10 Jul 2025 15:59:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Message-ID: <aHBFwlEeE9iIEsBD@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d86735a-6213-461b-488e-08ddc0057173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQpdn+6YEs7cMcUdO3Y7pHnQ8INLvJZ3Px5WOiPxRAzL1cfTTFNRHAsvmz08?=
 =?us-ascii?Q?qbvemc8ymM5jjddjM3e7ufrZ7DeogY6aozPIkoaBtJHmPn0TIVH8lPvEs3fD?=
 =?us-ascii?Q?scEg5cPmYk6huQqh42RhZOrqs9LSan60xt/kUHwUNXEji4wlepV4Hqpb2bEO?=
 =?us-ascii?Q?mF9s+3yLJVGXdHzYNIiWAGwTkfulDAMygSxSD8RTGuXQ1DfvhbpYA3gnaiN0?=
 =?us-ascii?Q?byHbxVFA/7mxaDKW1jHaDQ1QufepgNrBO+tllckJPjdSd3qp0KaZVVBCmi2a?=
 =?us-ascii?Q?8BH05RC5o44u7xaInrsqgbphixvPBl7ueoGSflMcIK9xrgJuxkyDRSGNsrmX?=
 =?us-ascii?Q?9hF49dGA7NzS270XEE/QCxNbKLxOaPQKsDki5ciDt8pp9qJ4bkZc3wW/Ng18?=
 =?us-ascii?Q?U0FAvabr/vQKtkYMv45rDu4CebsRAv5AkRvdP6D+H3fe0qLB0upI307j24Kr?=
 =?us-ascii?Q?w++9gQ1TO2HN5h4/faKxkOCeL4sK1Y1mJiD7YR1reWJjlwNKyphorddcAmhe?=
 =?us-ascii?Q?V8RsqiHu2swiM31W7rcM5zmIz9EGN1L9k5cwpRUxRWuljszz69oGwsoQNdqn?=
 =?us-ascii?Q?XXPHQcvarE5S6Fhc0qhKpE1WmgGbUQkWXZ/FfKG5Qv5SrOR4hf1Y2UV4D/TU?=
 =?us-ascii?Q?ekSTeTR2Ov4V3b+fvljYfvo+mUZgSwAd2wYi091GPciWSZMH55SHBghWUjRw?=
 =?us-ascii?Q?9woRBDNJM5NBhJrOO+ggxQfERqC40595Xu5EEO57yFEy2KR4/aZZctxN4kgL?=
 =?us-ascii?Q?ewLyOBv+QkNgrKuIxBENhBLzfWrQn8x7CgPLnxiZ81Bkhs8himjtZZLW7kcx?=
 =?us-ascii?Q?InSdD8f6WTzFG5qLFKTsy1j0tJ6CJBLC7QTXMzNk66LUbYUrVkasl5/B5c+R?=
 =?us-ascii?Q?mCc+keiiqT/KgZCYhJpRiSAvZJ8rM3JXiIwnr6OUaFHbvTrvxykJtjznYIH9?=
 =?us-ascii?Q?AX2HSQyFNtE8sbUxQ5A+Ajk0FIVaEva3EbPlSjGOHm5Dvs7Aft68dTIfvyZo?=
 =?us-ascii?Q?g1w7o5dZsUqjMUGnf0aJKYfZTrhXGpJYpekfjPYrsbYHkzONURHBHnvM/fpM?=
 =?us-ascii?Q?YRBQa97DThraKr8flvHPslyMUXzFiwoTqIvrSkk92VpNec3op9+5iHWShl/S?=
 =?us-ascii?Q?Hc9F8DKhRtTyTJ9/2C/QV4aMJeXsX5NBxOfkuiQ5vsbsC0kvuS665Vzf5lik?=
 =?us-ascii?Q?XTY+vYzFXLvbC2TB0/ZQYaS6hRUAxt+YSfkxXeWJRiZJNj7ayd9MScVA/fk8?=
 =?us-ascii?Q?xoVaDjzCWEmyZI8HWzBSkuJRinnPhHoqU1LuhvEdihT4H+S7QLlL0WpGTKe6?=
 =?us-ascii?Q?FLu8S/8W9oKJGQRcCzedb7EQUB4z9CY8lcJA6MvMleTKF3TdL1qnnPyIvBm3?=
 =?us-ascii?Q?maYam/ZAhqbmjvfTbKeA4x7ZZ/HhAPNlcs/rnrsY/jTST2kDRLintqNeRPWM?=
 =?us-ascii?Q?K8q7sM9ZyKq30jQbqkKxaDVxlhGD8fCVXXAPNcmTnQFjxfCKp1P8Wfnfbin0?=
 =?us-ascii?Q?DyOarIPIGTTm3zgifi4wOS0VoOzO2Yg+Duu3?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 22:59:36.5831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d86735a-6213-461b-488e-08ddc0057173
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
Received-SPF: permerror client-ip=2a01:111:f403:2009::61f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 08, 2025 at 04:40:50PM +0100, Shameer Kolothum wrote:
> Currently, pci_setup_iommu() registers IOMMU ops for a given PCIBus.
> However, when retrieving IOMMU ops for a device using
> pci_device_get_iommu_bus_devfn(), the function checks the parent_dev
> and fetches IOMMU ops from the parent device, even if the current
> bus does not have any associated IOMMU ops.
> 
> This behavior works for now because QEMU's IOMMU implementations are
> globally scoped, and host bridges rely on the bypass_iommu property
> to skip IOMMU translation when needed.
> 
> However, this model will break with the soon to be introduced
> arm-smmuv3 device, which allows users to associate the IOMMU
> with a specific PCIe root complex (e.g., the default pcie.0
> or a pxb-pcie root complex).
> 
> For example, consider the following setup with multiple root
> complexes:
> 
> -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
> ...
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1 \
> -device virtio-net-pci,bus=pcie.port1
> 
> In Qemu, pxb-pcie acts as a special root complex whose parent is
> effectively the default root complex(pcie.0). Hence, though pcie.1
> has no associated SMMUv3 as per above, pci_device_get_iommu_bus_devfn()
> will incorrectly return the IOMMU ops from pcie.0 due to the fallback
> via parent_dev.
> 
> To fix this, introduce a new helper pci_setup_iommu_per_bus() that
> explicitly sets the new iommu_per_bus field in the PCIBus structure.
> This helper will be used in a subsequent patch that adds support for
> the new arm-smmuv3 device.
> 
> Update pci_device_get_iommu_bus_devfn() to use iommu_per_bus when
> determining the correct IOMMU ops, ensuring accurate behavior for
> per-bus IOMMUs.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With a nit:

> +        /*
> +         * When multiple PCI Express Root Buses are defined using pxb-pcie,
> +         * the IOMMU configuration may be specific to each root bus. However,
> +         * pxb-pcie acts as a special root complex whose parent is effectively
> +         * the default root complex(pcie.0). Ensure that we retrieve the
> +         * correct IOMMU ops(if any) in such cases.
> +         */
> +        if (pci_bus_is_express(iommu_bus) && pci_bus_is_root(iommu_bus)) {
> +            if (!iommu_bus->iommu_per_bus && parent_bus->iommu_per_bus) {
> +                break;
> +            }

I think this should just check "if (parent_bus->iommu_per_bus)",
which means that the parent's iommu bus is private so not shared
with any other PCI buses.

