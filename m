Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEFCE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIMu-00009H-5K; Mon, 29 Dec 2025 13:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIMP-0008K5-JL; Mon, 29 Dec 2025 13:52:56 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIMN-0000K0-TG; Mon, 29 Dec 2025 13:52:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nve2mRs1JbckwCif+tCknJP69caMlv3yVrmZjm82VXvOc5UryV1qRWJTLbB+XClcpO9InCcUF88wIMCB7WJ9RnH/t897sCkXlYN0sndsZJnmrKEXs7ZRcfcBxpxFA66McmjOyWoHsygoRznZbC/1QW3VZOehLjIp5tpZjmzOj5fRSMJvTgIygLCDikRn0eitnuOwo5EH0qfU1Bwx7e1LTH/gXQWS8eclQLf5vHCd28BsK13yQ+KQHzebxZAhD1LdNLuDRn3jKyNu/ELArFvocLsuMFTZ5VXZRlIOd11ctN3xS8YLN0/b5f/7kXVAjgbZsI+8zPQXLUWCC4jcBupLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ6RCzNXXAL2uirSeudmw86obDsNHSYrYVVZaPm8dlw=;
 b=B/3qwBH1QtwHr6Oj5uW12iMnj0336E7+mBu9C6vYsezEuhafkwV0Nhl8X/kSF8eJQVFYlpwrKqFOSx6mrpD1qgIFFkEu4ViZUDdYFn1SHEPdYnJulsAkqGT8mt2Zhta/IW52StlxpvJu6aH/YDcmImMIp64mSI8DUCV97ntLM3WbTxk3UhvhIWcLPyIXAe6RMuQh8LUeeV5O70y5wwzrB8rofk5SI4ndmFHEe/J+DgP1EBuK6QIGY3Hy5ivnILfMxqfe7WHpSlBGUksAZRq2sPcoHuAc/P71bApghHRqWapgEoDhuJaPkWoUPdJXPY9nn604/sJ3twUPCA6TrLBfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ6RCzNXXAL2uirSeudmw86obDsNHSYrYVVZaPm8dlw=;
 b=CRXJs/Sqn0008ztPmcbDO1M/CfZbJL98KBqzH+iMJQ/ym2ILW4EbKd0mpNrgOv3YqA3+BmQPyoz2y1t853TqIKq0Hv3d3EdGW6vok5RiH5Jtua0PojUa+Pb0ZPPwFjPG1/bYYf5rPnDgTXtddJCd0BMJP1Z2kV4CQe3OeNeGhz+rqOyKEij6R1RsPk6s3VLiDefrsah4zom4Brjtp5Flxp3/cO590woylI3d2FsIq9w6yZKUjHqWpuWYRVc9E+ZUkFrCPlTD6fKrPTXG02YqUAdByISdRzaTVtcCSJXvuu/EFi5IR/8Gx6A1N/9hhlyiORyFmOw07vex4smjkkC33Q==
Received: from CH2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:610:51::37)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 18:52:44 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::4) by CH2PR15CA0027.outlook.office365.com
 (2603:10b6:610:51::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 18:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 18:52:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 10:52:43 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 10:52:43 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 10:52:42 -0800
Date: Mon, 29 Dec 2025 10:52:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 04/16] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Message-ID: <aVLN+TufyaJp02XU@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-5-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-5-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 21dee9f7-f16d-4af5-7b77-08de470b73bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qDEOmWWc0vA/ZMPmwFVmHNzapHuLi9ZOQg9VhcbHaDWs93cdwX8Xf2Z7D/dE?=
 =?us-ascii?Q?VjoY3pqPIDfXIev3hQxVrPSNTAHx2WPgVxWy9QnBWfD67eQWhkgfHuR9OtyQ?=
 =?us-ascii?Q?nvjDhTKZvZhpig9C5wUp1syQUdaeFmEFSbY2Jqc59r7m/z3pJrh4TD9mMoUo?=
 =?us-ascii?Q?cM4meoZdLomujXjzQB6s6BWc4hZUoDa4KU9IWHh7Y/EWt5SAxiojrIYEqaQP?=
 =?us-ascii?Q?PFjH5WAikz5a5HQBzAA3j1D2N0PegGp8920CkYag/hooR9u2NWF3dRn0UugN?=
 =?us-ascii?Q?d/ZxlWn0fZ6QxRa5jSvkmDus3IulycVetJZtzjST0DVGpkJHYru4d/yM5nmU?=
 =?us-ascii?Q?g19Fy7raW1ppgsrd+jQCAt8666thBHjbIJmzMF7Yxy+rwe1sqGtI8gJh+GMt?=
 =?us-ascii?Q?G0E5AqURxXgmgWErytLPkoOzaU5uKIHfj3ia3PYFDyMoLge1DsSH39iGR2gJ?=
 =?us-ascii?Q?VRphd58CUjw9ds6FIyJxGmOvXgQBMFmw94JM/dFQKI/zw9Yt8luzNfI+5nA1?=
 =?us-ascii?Q?A8ky4o+YT1cQ73DNeCYlyY9p0Pjba2oD4hHvrMCmxbp2+LS5gsqDCYqEory8?=
 =?us-ascii?Q?dtUzssPWFTCTD5zltwaU5i/sL+3bIL3kdj7iwvCX6Z86HnRMXKlgPvkLxTxn?=
 =?us-ascii?Q?k1J0vkyMDHbdjK1AQuFSae3IHzfIvuSM/3z4uRl3QKn0NghtkqfoXy4ydSZM?=
 =?us-ascii?Q?vuVOYjEfL4gujajbCF4g1KNqhKF34+NYElVpX2orp22lWq0kyf80QfWjkY7z?=
 =?us-ascii?Q?D7RvFwMpBWuAJIt6UXks+JvDrVj5H3XmY+N466YTnjcoZUYbCuZ3yjak4JLr?=
 =?us-ascii?Q?d9uSWgLuPSpPcQLkqdA+EUbB56n8wld5rXBXzLE2Vq6nXbE1Qb4z8iwBqc5+?=
 =?us-ascii?Q?i/tUPrlFZrhzxWEKGb50EMZs4dBMT7pzmXqi/IWVRQEiBH0Mu0FrjYpLHowL?=
 =?us-ascii?Q?Ml6yVVTAw5EbahSw+AkHcr1VTklmd4/IZ1vo4urxWFLJkQwv6RYjOWmnj5Z0?=
 =?us-ascii?Q?k4FkyIIl6Wr4XoaXSQ0ZNBtWgux8hIeHIVnpCm62UFEGARHezlSlVacJF4S8?=
 =?us-ascii?Q?r8pADfLcxjeJeXgUTKAVP2tDzC2ov2ho0kqa5RKWjcM6kATMuH4BRglNtMRb?=
 =?us-ascii?Q?TRUtyf7dZq/AOCt0u2ozuLZqiYUoUn6s31FdlIJqHE/AlXITP3+j9525FINl?=
 =?us-ascii?Q?pFOmcPSIcL0lDIAkLvb/qxj1DPTn4CB9Jq9ZpcZR70slhTorWN4/Dqr0b9BV?=
 =?us-ascii?Q?xQ9T+A66d7kme2qoWhdU3JATC/ag7IpbeL162O/JAjNSpP95WTdtqG2DL0Oc?=
 =?us-ascii?Q?+tfLD9HSvenYFLRzDAuD/UrQlzOJUwEhvq7N8x34RKFlAHyCpKY+DkF4XDwJ?=
 =?us-ascii?Q?o5oaw4eojwS6HbYUqGHB8NBn8MuQV3WrHRQtVFJLgAv86xpcMJqoBMTOq8+f?=
 =?us-ascii?Q?hRU7+bBL26gwPRvYUlsYUjfSo6sGDZdT5XjvDxhYCRYg4qWf4fnUCbIM9HDX?=
 =?us-ascii?Q?hOEnwuTFMDBilGzzUcONGvTNahEsTK64H4nJQA5UClgNMYMEA/a0WiNsClCG?=
 =?us-ascii?Q?YmEbQY4YaevSYs3Dc+o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 18:52:44.3753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dee9f7-f16d-4af5-7b77-08de470b73bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Wed, Dec 10, 2025 at 01:37:25PM +0000, Shameer Kolothum wrote:
> +bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
> +                                 uint64_t size, off_t offset, void **out_ptr,
> +                                 Error **errp)
> +{
> +    g_assert(viommu_id);
> +    g_assert(out_ptr);
> +
> +    *out_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, be->fd,
> +                   offset);
> +    if (*out_ptr == MAP_FAILED) {
> +        error_setg_errno(errp, errno, "failed to mmap (size=0x%" PRIx64
> +                         " offset=0x%" PRIx64 ") for viommu (id=%d)",
> +                         size, offset, viommu_id);
> +        return false;
> +    }
> +
> +    trace_iommufd_backend_viommu_mmap(be->fd, viommu_id, size, offset);

Like the other two APIs, maybe move the trace next to mmap() and
simplify the error_setg_errno()?

Nicolin

