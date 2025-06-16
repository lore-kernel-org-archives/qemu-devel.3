Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF569C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2MN-000577-JQ; Mon, 16 Jun 2025 01:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2Lc-0004y9-IG; Mon, 16 Jun 2025 01:25:34 -0400
Received: from mail-dm6nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2417::608]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2LZ-0005mJ-DJ; Mon, 16 Jun 2025 01:25:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5vhsMenmCketvLKEHIRBlARx5FBAvIOHdvpl0Cc9rQqsvn92u9d3GQpyqHahgCre+ebExQ5WhQwEUyHkizAiWFrVf083wSgKIHlv3pwq/adNWAlu3Kxa61stJWxdo5VkKnfrndAyxvjlOvTQFOsXyEORuvBg1AJ+ocilqqezYAQyWZqn7LXUEK0HM/bNWFGWHQMQmapUUxfwRUHiF/ATrLWV7c1H8mJd0GlRw/mFlO/S24Tmqpb3ex78TFgTx6FTpPA1R7Nxhv9X0dizDoMJalLIUZ2ytkNpeXWerl9U0wyEXKvXfa9O0UlzJjd2GBrH1/GhzjYT7hVZQHrbwPo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTzTJYxItKDWhluqkBZlRKskTeMmgG8knpRIFOrn0pw=;
 b=Rd6AnFiI1MEXiniWpF+rEwxVHIMTZRFp0Tv3Jlm1q/6uA727L0EzYEeQ1dRssfndLhrgMOE5eUXG0Y8qfxmSXb7WRnjWVCH11mupyl3PiEuMf12jMFxb560cYWr/161SbMG6Cux1enN4gIYHadqAqLWsCf2vz9B37y9BRR8Id+qSGhk6shSI8qzSz3pNBOo4x1tRCtqEpD+UKflvqU6I5yoHedMG2ke9UfWPX5slsAfLB0ck4H7j9myWTRU3RJrsA7x/wlaSwJaVzHBu3cQYCxQ3DFUBRv2m5j7Rd/YJhQdREtd+PMunIeslNrH7QzhY5aydIK6bDSo+Q4FDDxjqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTzTJYxItKDWhluqkBZlRKskTeMmgG8knpRIFOrn0pw=;
 b=eb/21YvVTl1spkMJP+KnlYyXmLrvMlV9tIJcbozmj9sYLDb6/M7GrJ2uACHgf9Z+Iq69oE1YqFYhnJfqPZ5fsVQmFDKSeZS+j17984XCUnRZXHDx3A15t7y1NgLf3KYGOQaJayb8PFRPmdsULX3B5Hgyl8QEG+fBLEhqgth4m66o+BAZKpZ3cE03VZqXP9P1jEYpqjFdP7FB8Rnl1ToMi8yS6zZEpAtfdLK4Z91rJEY42R581aXlnWEMQRNP+g6Vxubsxt/c6Lm0zFtA9R4H5zjm9CXEjKaQsc0IazIu5BUTsBx/ymqvAkzaQS9q6s6oMzPuTwVANDCnQr0vyKt3fQ==
Received: from BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46) by
 PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 05:25:23 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::48) by BYAPR01CA0033.outlook.office365.com
 (2603:10b6:a02:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 05:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:25:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:25:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:25:06 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:25:02 -0700
Date: Sun, 15 Jun 2025 22:25:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 3/7] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Message-ID: <aE+qrQWHIlTtJdBy@nvidia.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613144449.60156-4-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 78333f97-63c7-4a69-5cb7-08ddac96308b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T7f0g2jqUuo5m+Bbhi1SZSFCMIG0cP34ilfrjk+RV44x9HuT96DEwjfGR3R0?=
 =?us-ascii?Q?xWUt7KcRNZwGGNi2EtUWAkd6mW6883c7F0w3g6KDnot4ns4WPotpsb/HiyJ/?=
 =?us-ascii?Q?7ePa9Sw2x2JNryq3vNa19WLP8oX5toByxnS1ItSq22obQ1WFRnSwq6aJVoGk?=
 =?us-ascii?Q?p7PoLSj9cVC72WDGbzfpUJsBRhTEBr9pJZo5d01aHm9egWD68PRqpuzGbuCq?=
 =?us-ascii?Q?4JT7Sc76CffsgM0lbIGIduyn+YCC9rm1ylngBM4N8fAVuMju4qxdDfbjDUzl?=
 =?us-ascii?Q?/icwczgxiT5mFODbmAVZx/T9w3n0ehMJ0wjBFVdIyE9/s+ViklE+IwU84+r3?=
 =?us-ascii?Q?V+szbTr9MfMkwRIRbsaKjimao6EMTxQgmTpQSzwyMr2nWKjLqWY0z9DmQWRV?=
 =?us-ascii?Q?0/+WOD0zUhXeQyCBdTX06tADbo+M9ZF8+LQHonAe/LXJ9uicGjZ7qNhsciub?=
 =?us-ascii?Q?SQO/psv82q4XwGwUCETZyc/va0Nu+0qKebTWfaUHaOQlIv3NEwwpiNVfDT95?=
 =?us-ascii?Q?ILUQUg9ySjSbvqA7wcZEoLZV3fliaclB/0KignMOVc90AB+fV+OgoEQQr2Yi?=
 =?us-ascii?Q?d5+Gtm5h/ViGEY5U8QnclZoo7mwd6X/pzCn+KBhxs8s7eNHdYnIkiNZEVCVC?=
 =?us-ascii?Q?wDYx1udWXC/g32AoRVz+B8pmqACMlk7dIBV5mAwqQX6cPXXdjzF/vxbnrR0R?=
 =?us-ascii?Q?ClCqHShgSf2nv6i+oZtc6QaLW/pt5cjfrp112za3qFtSqh+CvbawldhHO3Yc?=
 =?us-ascii?Q?+I1V3cWVdfNPTQkbVOj0LJElpae8Q3xltNytMSnhKRUdCr2Dxa5zXUCJeWQJ?=
 =?us-ascii?Q?fAz8FPwOqHGimHN77v9mSRvtyp/wMB+XCn0705tIvc+Ra/eTEhLDGveeGtrc?=
 =?us-ascii?Q?kQubaVZVgUaHSMoCpU7o1KQoe+6hBefxpaCp6HNx/1D0G+iMkWCxDkDH6Sud?=
 =?us-ascii?Q?yyhlR1jox3w3xqFQjKphMxtKicUKV0i8OywO0uhlad4KPqJXH8g3AQenh2XK?=
 =?us-ascii?Q?MHCEfshx02DUEvKk1pvqSgUtsBF9X7Ljq2AqVIOyZsoCEEuNmBquJ6QDSgbY?=
 =?us-ascii?Q?bKQp7P+Wh0Avw8u9vVIMumNd04vblyUgoYqmAGtYr2Utcnlmz+xy68gPafYn?=
 =?us-ascii?Q?m3p9gpgS4KUUKFfasIIxCJu7axL6VyRTROTVfX9w1dHfa8rbRVEDCrvfGJej?=
 =?us-ascii?Q?LQEgaCmY2CPC4UrvidJRjlTKRogfq2Q0sG7Ix1aAcZcjYX6EeQxMSsP3Kry9?=
 =?us-ascii?Q?54ZYkr7N1S1gCG2psH63v95+BIU6MA84/57Ce8a3v7EvQX4l8wraYjEQoIuf?=
 =?us-ascii?Q?f9ahHAu56l/4dixS8IrJwSP+rdxbtlJUPTqrkl+FHiouGXDo0UVWBL5Qf3/p?=
 =?us-ascii?Q?jUaaxdy9QB+s9a5bQ3s/aSsaJY8/8UA5B2/mOt3Xf7G3xPk/9yT05x/4ysAX?=
 =?us-ascii?Q?D6zOX9Y1gPOZ/r6HoK1kHdsYEKv0jFqCa3ZFnS5I9u7zdEEgNxuQIPk/MdB1?=
 =?us-ascii?Q?1PlGo9YdumaCDzub50GgVffoRsJqchm8Daoi?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:25:21.5040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78333f97-63c7-4a69-5cb7-08ddac96308b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
Received-SPF: permerror client-ip=2a01:111:f403:2417::608;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Fri, Jun 13, 2025 at 03:44:45PM +0100, Shameer Kolothum wrote:
> With the soon to be introduced user-creatable SMMUv3 devices for
> virt, it is possible to have multiple SMMUv3 devices associated
> with different PCIe root complexes.
> 
> Update IORT nodes accordingly.
> 
> An example IORT Id mappings for a Qemu virt machine with two
> PCIe Root Complexes each assocaited with a SMMUv3 will
> be something like below,
> 
>   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
>   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
>   ...
> 
>   +--------------------+           +--------------------+
>   |   Root Complex 0   |           |   Root Complex 1   |
>   |                    |           |                    |
>   |  Requestor IDs     |           |  Requestor IDs     |
>   |  0x0000 - 0x00FF   |           |  0x0100 - 0x01FF   |
>   +---------+----------+           +---------+----------+
>             |                               |
>             |                               |
>             |       Stream ID Mapping       |
>             v                               v
>   +--------------------+          +--------------------+
>   |    SMMUv3 Node 0   |          |    SMMUv3 Node 1   |
>   |                    |          |                    |
>   | Stream IDs 0x0000- |          | Stream IDs 0x0100- |
>   | 0x00FF mapped from |          | 0x01FF mapped from |
>   | RC0 Requestor IDs  |          | RC1 Requestor IDs  |
>   +--------------------+          +--------------------+
>             |                                |
>             |                                |
>             +----------------+---------------+
>                              |
>                              |Device ID Mapping
>                              v
>               +----------------------------+
>               |       ITS Node 0           |
>               |                            |
>               | Device IDs:                |
>               | 0x0000 - 0x00FF (from RC0) |
>               | 0x0100 - 0x01FF (from RC1) |
>               | 0x0200 - 0xFFFF (No SMMU)  |
>               +----------------------------+
> 
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

