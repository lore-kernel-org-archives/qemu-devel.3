Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6782CCF885D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMBka-0003JO-Br; Thu, 20 Nov 2025 15:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBkZ-0003J9-7X; Thu, 20 Nov 2025 15:59:31 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBkX-0002U6-No; Thu, 20 Nov 2025 15:59:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHwLWPfFGze1Bnmw87S/BcWKNiwgsz01yIPmtFJLpyGrLAlZWLj+9iBD0tU8/Mx5KDD1wk5Wuxur/8RyT3Fcy0Lm95o4HcT5eH5bCN+kedT6eqztCjRrHVePX/BA++dF623Y/422yg/uo72nQY8Az9KSIO1RFLO9EjvkwZHKUrz/3nDg9sWw1v9T4/AX7I8MvLA+ZAu1GtHYrC3WVD05gBVy/rOO+ocFcdTR9GmYa/pMyysnV5/sFCYjGBd5VsDWekUv6B+Tps55GYF+//6NvV1wdfKJob1cPqPB9E9yVnGZMCvmTmeTiok42rtNk9hzsVkT5qYbBUVChsMPwF66Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOWnvRifX8oiTzSro/yEorpNyhTJ2Z8YgXFVXBrkZgU=;
 b=fClFOhAr/RovovgyOIRgNu5/sZeA7cWXqveu8QOxiOZvT7B8oA02IB631TWWGihWOV0xWKLg7oXwzOwPGCYIqYjlmvkGzRxAS9g06jdGpBZU0EjH0+G5dMgpNIOdG9Wg2jh5YlZhcQL+p2P62jzlw4AWumOml6VK3BZT365AMU+41q8+BJiK6Qu5n9duHtlvk2wsXmJd2mBkWLgJicyLiSPNYC2Bdfxln0RdnbOB1YPC8QN1Vpd0tws+ZPnAA7FX3aZBNSiO/TpL/C6OtZBHTgzp+Rouk2Hwb+G0jFsY9lsVGG5d5y9fLh41+ik1lcSNPBAehpPfPWLNUbuCXfVX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOWnvRifX8oiTzSro/yEorpNyhTJ2Z8YgXFVXBrkZgU=;
 b=eB2Q0+kpDdCU6FKLvQH2e+gYb/UWV3uJwHN7y432cWG4MmqdR/6x2QXGGZy9bvx3xXbvKR2pnQQmvKH/rcxajn0PNVLnAM8p3xQbRwgMEqPNyFLyOdGWsr3ccpDfDmf2aQwbCsI3o42O1tn/X8GkwSmFgdk+iGerLEPnrRebn2MtJiDkT2brJutDL/aiVvch6vSwbEj45i1cZJvmmKRCHdIE6mHtQa59fx64KLBTqUnGLwyOgwLfsIjq9/JWUImKXJE22AxJwCD0tpy1NYg76e0NGSUSR856+J9obequbuECWMSBtmA0KAoLYf4kaECRmaZtAAw+bwu9f9YW9gaV3A==
Received: from DS7PR03CA0188.namprd03.prod.outlook.com (2603:10b6:5:3b6::13)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 20:59:20 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::41) by DS7PR03CA0188.outlook.office365.com
 (2603:10b6:5:3b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Thu,
 20 Nov 2025 20:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 20:59:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 12:59:13 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 20 Nov 2025 12:59:13 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 12:59:12 -0800
Date: Thu, 20 Nov 2025 12:59:11 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 13/33] hw/arm/smmuv3: propagate smmuv3_cmdq_consume()
 errors to caller
Message-ID: <aR+BH0rmguLK1DM7@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-14-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-14-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab7dbfe-80ed-4677-225d-08de2877acfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hW1XpWcE+feD8e36/4mgjaHJQi0w1nkx/uyo0Ybn8YmHbj2ZN4awZZeU7tX7?=
 =?us-ascii?Q?aVUCiuHmf6W23me+/+kOw868gRWvsKIhqqCJUWyR+gT+lyEXIFpF2I8VOXct?=
 =?us-ascii?Q?VVVFuNQPemIqaRP7MbbqAQ2tycPHkKAm6PnDcJCeNR7Ai4R7epalYw2ArYrt?=
 =?us-ascii?Q?zZr2byehMkUygPDnmqSmk/bwy53tjry9IGrFEGgi+vbf07zlI2Q9tH8QEf+I?=
 =?us-ascii?Q?0T0P29BBKbs/FB63da++10XyEwddLC1PjbbmJDdjvRHtkmt4cqcqIUA91FCc?=
 =?us-ascii?Q?21J0Mg5ix4JFXDZpqtLf9rL+UGAC+y9nE+Gq6ikgmW4tVBHAb/wSYi4XaZiz?=
 =?us-ascii?Q?dCtfol+gsYXVxPb2Dd2g6PIVMjZRKmgzoIB10Gio9mWF+SkAAWnXEp8MItRD?=
 =?us-ascii?Q?6rvB9fxe9fbAkDJa5VtNiVmohd1boopYMLO4qZc2HVnpI+GvPjEM9I4S4JfK?=
 =?us-ascii?Q?LREvkkvAwjT6UQ7nDYMkKqzfLLRMF+17Cp396hvKbeoAkKDpJIzxg7MdBV1/?=
 =?us-ascii?Q?htOyD4cJPdh1CVRcXeIb9+OoPWV2wZhuNI/n7kQxWbRQcSSO+09R+Zx425px?=
 =?us-ascii?Q?PtFuUcIAj0/C+l7QXfwiQcKy5dfagigAE2TpEbq650Q/SYr2UGiPsAaPwEGK?=
 =?us-ascii?Q?s2sEzcI/hj+RZwaFM2/EVyfNauOXelRdqXT2nnZMx7Yrif4NVVv4Zo/9ESRg?=
 =?us-ascii?Q?5S358m3ThfBD852OE9cnCJ3NgbbaN/DIcfTnQyfzT/mzrZS7OtoDhyGBflhT?=
 =?us-ascii?Q?GFBh+kie3nm3CPsQGzlwp26SPn6Gn1TrVpgX/rYLMrZFZoBngmrOBLKaT3yg?=
 =?us-ascii?Q?dTGag3R81zLUt0UT8+JQAinv/KY/xI44CwFlHCqZmcPQSAQlzQy6ndBLj1cu?=
 =?us-ascii?Q?Le58JJdILmDkAvYXZB5Bqp6KRcbZhswruqAolsp6qps+odYC0DUyqo8zpSNB?=
 =?us-ascii?Q?9duoe0eE88Rxp8B9CwyjoTIGyEXLELIPasEA6GFovLxyRJE3bh5vd45ylG7B?=
 =?us-ascii?Q?euBjxxX78KgTOrAJ3Yn2o45IEiaz58jUMzNck97jgEtjbkmK1Q5FduYJNfZt?=
 =?us-ascii?Q?jtFYPQhTR0thU5CxNh64CQ2nxXMlNmbIA428pQ68q6DYGb+Gl6O0pb8tBkD1?=
 =?us-ascii?Q?C0ugJyE6bnuyZQMcUCeff9+MUR9dcMcflx468O42YFWRdRbL0JxYbAbt7Azn?=
 =?us-ascii?Q?EmBypFar9G1Uy7qvt49CzbtqtuxpfSNornrUnzTLubSzk84iFbz3BIsj2ZwK?=
 =?us-ascii?Q?+Hj8aBytf6KG3QDEw5wLeajZgU3sdYVj9g9F+01oxZSyTVm4+r4F2pxlW8Dq?=
 =?us-ascii?Q?o8sYZ260UQvf9vUU2Vi0EcS9VgUlDiUI7MnMFEu3qgAIKSHxbKMKC0BJDfCy?=
 =?us-ascii?Q?HrsEbbyr0Q7BQEX/Gys4vCl4Fq4nbL4BrjadBU9Zeycny+oDq05V/FEt9mOl?=
 =?us-ascii?Q?/uva5RopVCFcB9qLE5C3aQefoyb22hclQ4lRiGYZST2y4BsQkF7sHN6k2KEG?=
 =?us-ascii?Q?7d8aLyNuIG9JYli50hsxISnXPi0uFT4buc25rLEX003CGqeKf3YNq72XDBh9?=
 =?us-ascii?Q?8PIM2XKflIfE/UBrQaA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:59:20.0212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab7dbfe-80ed-4677-225d-08de2877acfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

On Thu, Nov 20, 2025 at 01:21:53PM +0000, Shameer Kolothum wrote:
> smmuv3_cmdq_consume() is updated to return detailed errors via errp.
> 
> Although this is currently a no-op, it prepares the ground for accel
> SMMUv3 specific command handling where proper error reporting will be
> useful.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

