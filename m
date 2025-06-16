Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6503BC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2U0-0007Ri-LV; Mon, 16 Jun 2025 01:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2TQ-0007IC-Gh; Mon, 16 Jun 2025 01:33:36 -0400
Received: from mail-dm6nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2417::607]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2TO-0006gb-EY; Mon, 16 Jun 2025 01:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUYKc2uYPAGlqhsyV+Z8trJAPbmw4VjJO9Vzu2rDMrp2yShURvTTgsXkwsFGaYXEpUfFh3hSdhK90V7rASfLa/edgl4jGJaGyOr4j58DI+oxBEasgdeRQReIQa6cP42OTdv5CzsNrECJ1LSdqJQ5ocb2rAdm2eKmIyjQwv1gsBVnisPmziSn1XAKHVJgb2A3x8JcQdZ4dO3NTMq7ACFvK299UhYyFKb/iHvLxDsNjx792h8E/2fVmAZsdFzC1b7zKPtz900tjZCWqsNEAGEw75sSdH/QyyOiot333C+p11Lu3+MvnTuYEVOrKYk4gkT2xzTrIEwwHeqvjDwp5KNIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpvwvMPO6m5nNy6hjjcyUb9rpVyKDTnhVaHjs2+VaWM=;
 b=yki+R76iGyMAw7dYX4C8/8JzMx7QTAM/RPHEUvsLQ5xsFuety1Q31VnOMAdhILzcYFF2LX9/DI/tVliqh5254oBaoxSoj3S0Yjj2SY74WjND783wgHNOw18xb47DDm56/4VMfq/7TgF4YjGgdPaVab2LEPQS8MOBk3F3vwHBRIYGjBSgMA83TL3MmrlgdM5jSmhEBRzDT7NB1YI8/w8yRBsjFl2xly2884Cuy2jvDBHS5s7YTlieyrUUqQZ5pxrO9xMyP/YS46XDY79HLK+1RiD8OV1SedraoNfoKhL69KElBMZOKBE+ibE/CrdMXijL+Z1rlLtpnRDZX5fFkLk63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpvwvMPO6m5nNy6hjjcyUb9rpVyKDTnhVaHjs2+VaWM=;
 b=mZTRKwbl92qRKooQQqFoOw/LCJi+aaQ2Ke3HGRbsmiTlBCnoIz8x9rg/dQF5J/jQKrkhJAj4Ore9XMpO5tjq+h4HJLjvYPgqigTEe6ePupi+gCVZ6Zd9vaHBVattXTwSZ02s1HFsIDi1qJb26zNtf5E0ygE2DRLJi603bBx09LuRV6bKN8IpYEbfhvTTsP65rPug3O2VfiOeblv4XNrVtZU1H5kAaq2acgJI2ESqq7RTHNW5zi+BbgmUZz0/jqxrfDZlRiLH3qvw6JUh1YUg3rMaJmIVAg2lIfkvr7ayeVsxFe34wLv3f3khYmU4NScME5SXAQBDz17PL0BYXJ5ofw==
Received: from CH2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:610:53::28)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 05:33:27 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::28) by CH2PR17CA0018.outlook.office365.com
 (2603:10b6:610:53::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 05:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:33:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:33:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 15 Jun
 2025 22:33:13 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:33:09 -0700
Date: Sun, 15 Jun 2025 22:33:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 7/7] qemu-options.hx: Document the arm-smmuv3 device
Message-ID: <aE+sklMpv4/UfT6G@nvidia.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613144449.60156-8-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 048f7822-5de6-4a22-8ed9-08ddac9751d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K1MSBpfZC8oJeh83kS7S6Q1ttdBRR0pZOx+vaX1cN2IQm5/eB1fDYxfzWPrB?=
 =?us-ascii?Q?a1W5R3L/pDRLI80z9IAaPzrFDCMVw6pm6GznWFkpoixifAvsUA+ZgTDnSgq9?=
 =?us-ascii?Q?OmLSvcYxhnBuJW6aHzt06l/JrpoE7KZYX7Gl+SvKn34u+sWq6Q6nxFPW9x0d?=
 =?us-ascii?Q?r/JGDE5e45LKk3hfyf5TLH9JVsKsCykExQ1GFlh+yI+qN+NKxH7K1H5F4NxO?=
 =?us-ascii?Q?chlcXT4gnMQn4EhHJLN7gSXCfivlBtFVIid7CcVNxyaxEu8wLEsqeDTT9UnT?=
 =?us-ascii?Q?8xWILuDarJVgS3oqJHuXUHtw/XyPSVr2ezT75auQHIz8JZG4Q1ttKlRu6Xsu?=
 =?us-ascii?Q?InCrUkcNuKn4uBh4oltKAPpJphHU4/s2KHvWR8ZzVEjFaKnp+mgDBLzBU0Le?=
 =?us-ascii?Q?bKk8oNW+w6hr8K1/iLrPGv/07m1wcjcA+vq3MlqzCISAlhZVBfuaiyhY3fep?=
 =?us-ascii?Q?Upudan7ghg4z2rSS05+0c27rY8ZeqrpEEj15dtV+kWsPenslH4uDVjiPOG1l?=
 =?us-ascii?Q?yBhTjHBEcX9Vtf8n1jwvda4tVLja9jIHdUw/tUyHxznBJwqmUs8StNfs6N7K?=
 =?us-ascii?Q?J2gKmaQc1KIGW0FYseP/MVLsFD4zYTqIj8YtO/VQ3nbfdK+t+xz5qBkceXDl?=
 =?us-ascii?Q?Lgm59Q15RoJtC1Sa0kA5MsM6aLMt3gyX9f4SrtOqsHBRkCy6fwSM68eTE7Cl?=
 =?us-ascii?Q?caBsTIjWoHXutJRXUOZL9JIbocFmO6MzhX5PCdItXkI1DJHRWa2/7FdR94E5?=
 =?us-ascii?Q?fB1rpvRnRoz9pHtBkxHl3EE+CvfCwm2XIurUhtUxyhzcmNsgi+i8SubJfcem?=
 =?us-ascii?Q?eFKVFgqM84FDr0Ec+e8hkUJFOLpqg4SlGQR06MeWOrgE+n7iinn0iKsBy/H2?=
 =?us-ascii?Q?yJ7jlbKUa2iOoTR2Exwp2Yl/Q9pKcoAxLb6WciEyfrEUGFGcPzQAH0Y14+Wv?=
 =?us-ascii?Q?LtB0tWjoYZ9da8nSIzd0sTBn7dNYgnNI1U0qrBG9wDB9B3vTZj42FnpegAgQ?=
 =?us-ascii?Q?blvfX85x6ZnLlsWRo0oTCJYFY2Lfp8oY3loNM1WQulLJzoKNRNTKZ9KwXdRw?=
 =?us-ascii?Q?NS4cjhHFwf4ggDTXNHz9ks6SoRcTSg9cC/BIroXytv6E+LNEUjvFoMgB/ft8?=
 =?us-ascii?Q?Y/wBOJHyvYc2JuHi7lTUgWF2dk0Ig/MJk5ao7JVZwzGUNRk7ba/KzWmuZSl7?=
 =?us-ascii?Q?OcSIwqnHOehGOf8wdhaf6f+ZZYrLmUaIYjX/MyAgEyb4ayyvO1TFzOtxR+pK?=
 =?us-ascii?Q?NGzytWVLWiqWyM44Vr2wkl44WtZD71TiYqwCAS1c1Fj5X/54G+Z6JoKVVwhQ?=
 =?us-ascii?Q?28TKb8wEWObFrVE0rgY7M8nk/h8lc4Tpo3sOJJxyJYn7dAc/scE11Shbx4+z?=
 =?us-ascii?Q?T300UUAghmY/D1vfpkIKBV5zzkieGekhpGWT7cSYr8VGPWfUpub2tV036k8v?=
 =?us-ascii?Q?x99iehMemcdWPC72xDeQ3M/oKRnKmyOVXvSxStY49hJ7Cg3FhhuT07OHxIwF?=
 =?us-ascii?Q?WLRvKxClhBYqQnckE6UDu2+swjF7nyHaXJyc?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:33:26.7819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f7822-5de6-4a22-8ed9-08ddac9751d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
Received-SPF: permerror client-ip=2a01:111:f403:2417::607;
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

On Fri, Jun 13, 2025 at 03:44:49PM +0100, Shameer Kolothum wrote:
> Now that arm,virt can have user-creatable smmuv3 devices, document it.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

