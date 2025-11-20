Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8BFCFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCEr-0005OD-Er; Thu, 20 Nov 2025 16:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCEh-0005M5-9T; Thu, 20 Nov 2025 16:30:43 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCEe-0001dV-Vn; Thu, 20 Nov 2025 16:30:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF8E0SqQTuhPBh2xwCrCvgGCWoZ3hMy97YAOEYwXjewT60FGbtG1rAlujf5ykVC7UcKF538XlL5IRu2Ip+bUky0AdyPKeKvF6gwhWbxavxDeY8BbRLDsfMBjVoqGOHCOv1eJPWKiabdpJrBZmQ63vdvXsCsUHWFkBpcgLL7cQ0GGXCCp9rtfwo8f5Rh41i0Tw7lvBUvpfEwFPg0tRY6wTSyN2yxDFGTRFEGYyYmGOyhbtdAOwMgN0KP2ml/SbP85gcMmYOXyGelQ3jvTMiCJKuef4l8LRxRqvtY08+EHwFMLrcFcJfuLXZy6FiqkqM39OnHjtnaKYzT3mAXkJH4CYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kzCTJzLxNqKnuCOl0pE6SSaxqXO8dsM8an36DanoLY=;
 b=qHTNdEZQkTodxBpnMbzmM/I5b9g//v5c0xfp19oizc4433jw3MLJZhF4p6k0/29y+w5fF29rR38IrHXMDcCjX9vYE7YSRNME6gQhh/2MeRv7FgXOqCc3GtKZG7EGd95USHsnjpEBPxhePBuQZu3tXkzEW0kdMVz36WTfNEK5ROPl85gS7wtcn8jqEa8MvmLYWAUb64ekMeC9SbmF27814Gj9IvcE3Iq6f8jWEI3eCjJ0saW+Pp2CF8tB4ziAWs4O7UAsg3zSrtJRo+VRNVGRbeJiqJ01DJsmi1qgG2Fntj/VEajafvXaRhcdrGwEk0KzGdaMI46eWKK32z0kQyRwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kzCTJzLxNqKnuCOl0pE6SSaxqXO8dsM8an36DanoLY=;
 b=XaMFP6JZ++estf4yMg/tIfV2F+KhADsEfDzM9ZV4+pP454VMTKv6/8cQCFHTmJByCVfq7KI07L6v3+g7gJULKH+q3T0+YoeN75SyuAzuLHpVo9vBeslqRZ76FwRkQY2+JIX8SBdJ2YN8Rzd4eR63Z4iu87nLaCGEfCKZ2IDaNVZuyzP5WRdA0SKd3aYHiIKuH7AAXGesqwHkjQ3w5nXvHAfXNYt7uDaE/gupEHsDEY1xFnofWyDDZ5hdvcvZVuHKCESg44G83kLD88WmQy3Up9voRcxZfoG6ScMHvlDJSm7EEOT/urCRQRpoWq8i0adkzzLiZEQjS6//mCPlAB2stg==
Received: from SJ0PR13CA0162.namprd13.prod.outlook.com (2603:10b6:a03:2c7::17)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 21:30:27 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::bb) by SJ0PR13CA0162.outlook.office365.com
 (2603:10b6:a03:2c7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 21:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:30:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:30:08 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 20 Nov 2025 13:30:07 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:30:06 -0800
Date: Thu, 20 Nov 2025 13:30:05 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 20/33] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Message-ID: <aR+IXfWiclEXCmLY@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-21-skolothumtho@nvidia.com>
 <aR+HuvInfdzmtRSs@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aR+HuvInfdzmtRSs@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: df876cc4-1957-4f5e-7412-08de287c0600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SuIV1O8iCRJSIQzvADyzyJ105xN1Qz5iU6EvU85oyVveoS8eoRsTdtxM7qR5?=
 =?us-ascii?Q?Af00gUpKTxwME9IP8dPAT1bkmZTkuUxeHUnb7C2aa1sWvSWXz250lQJylwcw?=
 =?us-ascii?Q?/2d3SOlmvFutfObKh3uJlmJHxR1mTrRVlyEC+M+sY8NX2crp3l4DIpnuIfLa?=
 =?us-ascii?Q?ETz87S687oOMHYwF5taxc0MTb9JS56WRQTlSgdVMDIUERiW8y9OOZlQIzGdk?=
 =?us-ascii?Q?NXXZO918EryRu+kdboWxvFtFdbLpADccqhLxXfxxY5kb7WIaTZJwNLNcvcIz?=
 =?us-ascii?Q?TMcYfe0RL09yCZ4etv/CKsEGUsWNcd/5LIHkrOnbGkyVq5fC+2l8HQjl5v1s?=
 =?us-ascii?Q?eU9u+qNku/4RJFDZu81aBB91O9XonO7L0cRJC+8kyrmyHLnZcuWsxDA2VZ56?=
 =?us-ascii?Q?Xen3M6l9XqsrhseCVTMum85/i1rdWX1c8B1YBBEO3xbZs0NpMewtY0Qw1nWT?=
 =?us-ascii?Q?GvgiyAJvB8t+dmYfs5EYUYeZAge9ryULCiUPd0ujGlEHOHllt3ZLEns4MJyD?=
 =?us-ascii?Q?OspnSpuOpA31cZsV3EzqmwOKyKLv88GRaW0wkcmeviNokIS5QnORnPCKQRIg?=
 =?us-ascii?Q?qWYAiqXeqYLfEgefp6gc4xna7CUywOllqF1W7P/OWPUVdoBhT7jHH4soAY2R?=
 =?us-ascii?Q?uIDT+RkECcDgjvvnvglbr+bL+8uV+TXq8ev0kZKD3LqOzUh3QQYSNCIIAKc8?=
 =?us-ascii?Q?rBGvWYk8CGRJwN2VZ3RhgZoXIU4QQAC7cHh3Z08/DEsz3qF5f6RTw8IP1CVe?=
 =?us-ascii?Q?6ftjiMsKPrq+hsa8uCszw9SBSJgWB8jZMnK9IgVbWG+gw/LkrHcU3LUrlKGr?=
 =?us-ascii?Q?aDajDZKe3e0luvMKuxlb5yUX2WnNxFDkQB6+6ntLKDGBfxFyObYfBc6+/UjW?=
 =?us-ascii?Q?3zs4QcBcLEeYdqSj5KkSoGt2eBBSJCy48nRN9Dlob/AHjUG5LbBS/6fQtAjV?=
 =?us-ascii?Q?5INeUyZbiQBwkjyEDqcruErHmZtGRrL5RGLKl9bJ04Q+qsrJOEyLzV2euc6+?=
 =?us-ascii?Q?jPTFrBvwSeI0yEs1bR9HwHo7nP9cZbKk42+3XrVhPdQounYVSYPiZbSWob7j?=
 =?us-ascii?Q?43ovdaVSozh9dXlO1y73i9cGs9hbelhyvJmXi/Qpjwmp1v98FrzO4xlAk8MP?=
 =?us-ascii?Q?ETFx2hWoXvWKKMX4S7tijasvlmDVLQDVdo2lCFzeZH9I4Mu1xrJweA+rpSk1?=
 =?us-ascii?Q?SnONOUkLI33iFRAEj4bWCmhS3iawzNedG7jRtJhd8gEvOtA4GibFxFL2DxEM?=
 =?us-ascii?Q?nB6x1nbwnbNjK+0fhYCzAtp80LHoWNwkfXN8jyqkft7K6/HnFDlP1DgdGTa5?=
 =?us-ascii?Q?+UtuoKpG8jg/Kgp8P4q05Cg0C7I7XIlIyEGjG4cl46gV8UwbQR4jGMkZaPZi?=
 =?us-ascii?Q?daDRSLdLyqkmGLREnNV01+xHOhCENhMV7dXsiV6gV9RZyTW6srnbEWdkbHZ4?=
 =?us-ascii?Q?7i4bJtqZkNPxBowcZwKwdgvUbJZ4QeKuU+uBT32rLy2jCjuf1ACR4eac7DLD?=
 =?us-ascii?Q?cwO861XinFOblxGESg7WTMuCA7uGv161AevNt57fFFefzQlZVqBWr10vCycQ?=
 =?us-ascii?Q?liJlY70QTQTsqwbkTao=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:30:27.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df876cc4-1957-4f5e-7412-08de287c0600
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
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

On Thu, Nov 20, 2025 at 01:27:25PM -0800, Nicolin Chen wrote:
> On Thu, Nov 20, 2025 at 01:22:00PM +0000, Shameer Kolothum wrote:
> > +    /* QEMU SMMUv3 supports Range Invalidation by default */
> > +    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
> > +                FIELD_EX32(s->idr[3], IDR3, RIL)) {
> > +        error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
> > +        return false;
> 
> If host reports info->ril=1 while VM sets s->ril=0, it could have
> worked. But this would reject the case.
> 
> I think it should be:
>     if (FIELD_EX32(info->idr[3], IDR3, RIL) <
>         FIELD_EX32(s->idr[3], IDR3, RIL)) {
> ?

Never mind. I realized that you are doing in a followup patch :)

Nicolin

