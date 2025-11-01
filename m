Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFF3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 00:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEzoM-0002t0-RP; Fri, 31 Oct 2025 20:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzoB-0002p7-Pb; Fri, 31 Oct 2025 20:49:33 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzo3-0007yC-C1; Fri, 31 Oct 2025 20:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKSdBHXA1SWGWv3Q8b/X9kR/bMZCX319n5HoqQQbbOQQY6pdIDAbJqsDPTzvfeAQ5jHEuIRnQdZYxDF1paJ4SGQFvYDBo1zI/QsNTRArhnMvpepPC7SdqXc0k/oFVwCxKiZJJciPOvBM3AHQu/skVz8HUcI+pHlEdDvSrvP2M83hjO6+kRsDLNL9prBjWhbhw/GjTZtvjPtMtP5z1TLJezVqxjSS76m2oV2PTmRS8/zOA4rZhjb+h0VODqoIArtBLNzYA/GBxalibZ+Go5rUBIRN9r65dAsgxOw+FjQ5tGck3LjZjZnuKy89Lnjj8zEcMR8tj79B1C4Pv7yuIyP00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4RyY/IXI6DjCDXe2vu7QguiZrGcsSkU5oVyUqy8gUA=;
 b=n+vLUpqYq8iY3v5lxOivIvjuhned3l9opBCUyo9mQZbFKro190f26pA5EPfgJgmLRS3E/b4vWaFnwF8mD6rQQkDr6XUmz/uCRjZg4zeJtWImaFTc8J8RXk4GV7sLb0knt+k2Nvt9Ek+2NNovg1r65NgVS3xPwWh5Cfk2wEXyBPmAQhHup2WPV/Nfd9wNPYdt+htuly6HibVUnL7umpCA/qbl+K01cCEyEWHby39H1fhq6ak5tMnv5UjabXHs5vU1yqJHDJUO5U02kegcx00tW2TQD1Uphs9M2zwhl/QDaYIFcfDaWOA1X0s08UBrW4bH1NY90Bm9QM8NaCn2I68+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4RyY/IXI6DjCDXe2vu7QguiZrGcsSkU5oVyUqy8gUA=;
 b=GSxhdflI5N4IbxAYxfkesSHF4PYianuspHnrHMkEqUMTsuf8JmoZMfHHe5s8nR5l7qUMa48RKJwrF/wOb/emJ9hKcrguUMwRxjOeO32WWBR7P+wH5SDYffWfs/RsngQPsg3NYgwYXKKIYQulLoSjJU1wi1rE4H15o70Esd4+0d2/KamnAZ8dav3ltghtRKqyEGNPl4CxQS3owVNowN/OlXRaErLcQK+OP2O3gx7aVixVt7jgANlrCGG249FKpFnxq+tYo6elMXws4wYZd/62xfNL4XdY2cbV9ZWDx1eNfC4Qlk/0vLLLbwxRvxEJrPCWDuQAO/DUgQk7s6THc42FpQ==
Received: from SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:49:11 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ac) by SJ0PR03CA0052.outlook.office365.com
 (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Sat,
 1 Nov 2025 00:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sat, 1 Nov 2025 00:49:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 17:49:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 31 Oct 2025 17:49:04 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 17:49:03 -0700
Date: Fri, 31 Oct 2025 17:49:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 19/32] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Message-ID: <aQVY/q1XVBwbAov3@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-20-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031105005.24618-20-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aadb691-8e9d-4a47-9a7d-08de18e078c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VMXbgM/GoqtabRU7DhpegyIooUJ+TMb4gS54LJKJV0iHmht9xubw1foH1IAc?=
 =?us-ascii?Q?D63T60qH9tVW6gojbyTSiERvJQKn6Gd5i/QgtOGXDv+8sDulwei2Fj0x9btu?=
 =?us-ascii?Q?q7CRZWlsoNrOpXpJcFnPxKWDDltoh9uJVdyU+T0PtsCgahWAw9rl+F62KpYC?=
 =?us-ascii?Q?jGtv773Ptf8jXDDeMEPtgBVp+3dfVy/RO8kctz3mQ7kJomT/o3zyYsVf2IGG?=
 =?us-ascii?Q?5DjrC8gg5p+5Aa3F+r+1QndBkSDF8dle2hDmsEYU419mPrkaoJPDgTaV2O77?=
 =?us-ascii?Q?Br7kcTrdzJXcHjNQ2I2Ovf5O11fDNm2MSupULy2+rb3UhcPptaa/D+PlnqQl?=
 =?us-ascii?Q?0IeE75rC468vL/Q3i6RSwR0mFaU0SELp1h+1jgvkdyWbmazlhQYxll+I2nHZ?=
 =?us-ascii?Q?04ysAKxIEeCPwvtQuEOlZJ0bNcT2mUj98knIXK4hD9/izAQ5+UtZplWfAuL9?=
 =?us-ascii?Q?0kGRbqUkOg9QDiqjf6WGgJbx1hrk1dOwJxhdoff1LN7MJC13sHlJJLCHwvYi?=
 =?us-ascii?Q?6Y3nyDRwSN+TcMSwhmyKWWxje+hvwD2gCibigO8XzjQFTRHqV+dkIiKOfXba?=
 =?us-ascii?Q?DaC9OCzmI5yharPI+CNYcOEZpuUVHEzaILvxmuZ+OIKy9NPGY+t9sDnXrwkg?=
 =?us-ascii?Q?PsKNgEtLMMyf04KZTyL2Dxwq8EoiwojrvFUwkdHFSTRhrcPI4MTWGTRHxBZD?=
 =?us-ascii?Q?41f3iFrmk/R90yEoWEwNbH6uR4ufgIkzIM6FcZ/mNe/15CeYGbChO9wkPyU2?=
 =?us-ascii?Q?dt/+16Knm4BAAt6PFxcop9a/tikOLL5r2Vh4JAk/tVBq6GZtR0OsOAzOGCt+?=
 =?us-ascii?Q?fiEsOkuOv9bgzzUWLF24fi6iL9IIa5nM2tqaiqLkuU/oFy/3MFordXeD1Luj?=
 =?us-ascii?Q?ttpRKaCNpY96AWUpEHjezEG6QNZ4Ry3j/1J52IK8crI9raC3QlhbjoiW9lVs?=
 =?us-ascii?Q?SeagaUoLISFis/lQcwDFwmc4NazZrcIKk3LTXa6dzU1B3LTP6Az8zrjH8odR?=
 =?us-ascii?Q?Jbk3pa5pe+4vZ6MlBeWVTGv42ZWiatfBJEkwa2o62hLQ2PBpm8RTMAybXnx2?=
 =?us-ascii?Q?XavjH9w54Ul6V9g+9jLQ4/brwih5wDU6bHa4pke+skdkmDxJR+v+LU6N/1DQ?=
 =?us-ascii?Q?/DQoffb1oxtUjza2h6Fii5038yei2LRn360+Qqp0FOx/UYcj4aXXKldMFKws?=
 =?us-ascii?Q?9m1j2joqyBrXDLKPg3jiLvP1d5bAa09HEIif0pTQPdKzMTaY9h1ZnXhAgy9u?=
 =?us-ascii?Q?KTDdXy7Lfv5QM6mfRhisiqH0gdWG4eVaiTk4OznSiaxL9gaK7JfxfptFL2/7?=
 =?us-ascii?Q?lehYKifur2J8MAGtdtCq8H/xxJizGEdYLtXYpTxS1dbBms6wc0yvjZcLPG0j?=
 =?us-ascii?Q?mSheBCic4hz7j5v+nV+L3l/OiGQRm8Wc8ZnHeh1/euewqvc4ooRxFIwRuXXN?=
 =?us-ascii?Q?JVDztRCiBqPBHXG1AWpT+emIikXrFn1tFuinOYpfmMKy8KtDFcln4LvAxmdN?=
 =?us-ascii?Q?PCi3YDU8642EiuBHYf01RbyYk7S2BhqWI519jWbZCounUn5TQlbpe+MBl6QN?=
 =?us-ascii?Q?Yj6BWf39CgcxiV4vd7g=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:49:11.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aadb691-8e9d-4a47-9a7d-08de18e078c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Fri, Oct 31, 2025 at 10:49:52AM +0000, Shameer Kolothum wrote:
> Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
> features are compatible with the host SMMUv3.
> 
> Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
> Only the following fields can be used:
> 
>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
>   - IDR1: SIDSIZE, SSIDSIZE
>   - IDR3: BBML, RIL
>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
> 
> For now, the check is to make sure the features are in sync to enable
> basic accelerated SMMUv3 support.

Note that SSIDSIZE will be added in the follow-up PASID support.

> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index a2deda3c32..8b9f88dd8e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -28,6 +28,98 @@ MemoryRegion root;
>  MemoryRegion sysmem;
>  static AddressSpace *shared_as_sysmem;
>  
> +static bool
> +smmuv3_accel_check_hw_compatible(SMMUv3State *s,

Maybe rename to:
    SMMUv3State *smmu

then...

> +                                 struct iommu_hw_info_arm_smmuv3 *info,
> +                                 Error **errp)
> +{
> +    /* QEMU SMMUv3 supports both linear and 2-level stream tables */
> +    if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
> +                FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {

this looks nicer:

    if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
        FIELD_EX32(smmu->idr[0], IDR0, STLEVEL)) {

> +static bool
> +smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                           Error **errp)
> +{
> +    struct iommu_hw_info_arm_smmuv3 info;
> +    uint32_t data_type;
> +    uint64_t caps;
> +
> +    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> +                                         &info, sizeof(info), &caps, errp)) {
> +        return false;
> +    }
> +
> +    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
> +                     data_type);
> +        return false;
> +    }
> +
> +    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {

Nit: it doesn't seem to be necessary to have a wrapper?

Nicolin

