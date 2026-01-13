Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5617CD2F350
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfie5-00047E-SG; Tue, 13 Jan 2026 12:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vfidZ-0003xa-Lb; Tue, 13 Jan 2026 12:57:03 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vfidX-0005ks-Hw; Tue, 13 Jan 2026 12:57:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNCCwMXXPFKzYD/484MLHyMQUD3fxSK+1idVTdGeJK887xQN11lZxOI0SsIB4i5tsiCdIuqXIEsom9mNQfjWayPw9Nr2Bw+RWkRUl0AaVMzj+ZfE73KbNuMgAI2eA7+hvFSZicy1lUSaPlnBKo82xkg0UwsyIJIVospYKcsTmetxVhZ82SXjbGIav6FppRg2EhL1wW6qWoMFs4e7kFdj55Y6+Ex/SUwr5QGV/BcplJLy0rkxDz86cm21Xxo7L4nNHqnTVl9g+JyNBNMrkwpwUqf2TZxkMx8Rwv8wNsbSkKNOWQW4f8K96VMBA0P/xeTcqYjfzA8upqeCwzH1bYyyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYQcRdBvyKmoA0j3Wj78FIBtyG0sidpENmvp67xbkPs=;
 b=nELK/8hGZs9TQFqxg91bb2gzdBeM69JKAVlqEJ0a2b+X/65+RoHx9mY0dzo57jvl1ewBxnJYJ5h7jXiwJbzW2FRWlo5+nOYlEqJ3FnFKsv5HOW+b3n4FpkcoZ4HBFA4MZjcDqApk0lqebHCOiJl0D+Z/8TuVd8j+uSKDFNHitPDlpjrASSY0KCI6QGUuEYQoopeTh186KsxJwCHBj9uQAnZmtdbX4vRVuuZO9WQ+ZWPuMjWKV8glJq0s69Z49frHq2H872epw7okweD35TkU+2DWQERZDPS+aHcNoi2xb/XZTMWoX0GhBAVDRarrGLaqOO0WjoWxz82vJTbI4388vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYQcRdBvyKmoA0j3Wj78FIBtyG0sidpENmvp67xbkPs=;
 b=pws/3Kmdt3BqLl2s+5zhT7OdaF45E8AMws/q9ItzWmBxDNYvrkOz/p3hplCk6uPyMpHfeis+hK6ydkqMUmTsVzBBRhjN4Y3eixIFY4uWT7Wgk/ixJ/i27xudtS0x5JKLyvXJVk/o8Dch3vuLtCRZgbLlItLrEU0BqAk4buAPTRI8ovyqvAPYsY/bUZzVox37WtkohPBbpwUbOmsZYoj2hRnjlCgakSSQiXbWsYn6uu2r+oQYlWHqySjMXjr4C849vHVVgVp5iIKOxpWIzlE8k75avvzJwIQ/Fr1rYDr8uqgZOKjNSFniOlnICcYy5ElHfdEOzs6vfbtgwDhYp+BXGA==
Received: from MN0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::9)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 17:56:49 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::ba) by MN0P221CA0023.outlook.office365.com
 (2603:10b6:208:52a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 17:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 17:56:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 09:56:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 09:56:25 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 09:56:24 -0800
Date: Tue, 13 Jan 2026 09:56:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Message-ID: <aWaHR/SEgDs+2RJX@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-6-skolothumtho@nvidia.com>
 <309bce2f-be34-4d3b-83e3-2a115f1ace80@redhat.com>
 <CH3PR12MB7548CCE21D0E447A18E190BAAB8EA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548CCE21D0E447A18E190BAAB8EA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e569efa-2e22-49b0-8bd1-08de52cd1fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q0jP9F1RLALBtPnbEdM1HfNO+P8PnlUJ87KIz4sTVn/w6NhHnj7E4BmENo+N?=
 =?us-ascii?Q?OOb23Qawc9lChvCQSMHVpv4EHG7MKCGtqNIT+I/w881oapfby7zX3Z2556no?=
 =?us-ascii?Q?A2Mn4gI3SxbPMKlGRkKunc3FLykGHw7PX7t+YDDuEQgNsLEVc/tF/B6f5Yck?=
 =?us-ascii?Q?PtUag6ybPOAXyGGY3/AW0gCGzaVyJ1HzXKT1uHHYQgkuieoir9gCNuNGdWjO?=
 =?us-ascii?Q?3gjMPazOTddICG3Q25GTS50nFrBklAJDfAO5T+NM46pl2s/3fXmOPPcmIqD1?=
 =?us-ascii?Q?1dVWFOcgrNj13W6ej8kmoaM2OQ4KrJJUWLefDW0XlEG1btfqqZTG1g3LzZvQ?=
 =?us-ascii?Q?V1zgPIn4V126E2KaAMFFLecOoGd/+j59v9drz45HLeMYLBF1ik1gj7v27Ve7?=
 =?us-ascii?Q?BF64vFsLAA6JXk+fPmEm3cUXrLvr695hM1q7ve0VoGvqf60Y0V2UZxSU6D8S?=
 =?us-ascii?Q?8Q05oGfS7c4AJevIpkXSrG0Kf/2urOYmSAKpFNjRqSE53UbS6dBGqGchYed8?=
 =?us-ascii?Q?a70iUfAsPgHEmhqK7D4VlYPufHYztQF3MxGE+lnlAMthU423oc4q9teOIv0x?=
 =?us-ascii?Q?SMQyYHU1+bzfTU9xz+ev6AKH9IDC2Mp0BzN0hTPK/UBz4rRxJXr9fvF7w8vZ?=
 =?us-ascii?Q?F1JP2HTTYYP5K1XBF2rc9K3VLWDxRwjVDZ2pD4/k+FhmonrWQaxDDU7Xf2Z8?=
 =?us-ascii?Q?ppsaou3Lkg30ZEcxggCakZTjzIqqalRVezTv9haI4ep+6I7/+gCnSLTL3Sz3?=
 =?us-ascii?Q?cucVhSwO7NtVpMUWgEJe5R78I199DlARqDFgP/ly29yWVPkG9CeCPMAFxxs8?=
 =?us-ascii?Q?CjIyxCr/QdZEXOtS24Zgho8623uIVAu4Dxbiu7ZhdFXqf3+i2tTYYwfIIzeS?=
 =?us-ascii?Q?JC+feTsP6qVzg9eOSgkWgJikQTasZTXt1YjFIkjU0a3AXRaPBQ8DebJtZXtq?=
 =?us-ascii?Q?P8H5pltdTmY6Z/e7lvCR3JxgD43+lwm+W5eu45AmZzrk5oLDeEMkDn0ceGT7?=
 =?us-ascii?Q?TEqTGRAxSCt5JQaVAnmePv7kqKvILLBq2bjBT9z6hTwLUjpmx3sRhxeJfvdY?=
 =?us-ascii?Q?SgtTTX7JWmLcV9rsEIFnPG19pFytluusxSCTPS6CvjxvV3yFIjZ25izD2N2X?=
 =?us-ascii?Q?OuaZwxoLHDuXHINCCQNNrmBWKwkxwLqt3f4rSIaSho6MG+Cig2OROGo3iEtQ?=
 =?us-ascii?Q?zpaQQFUAQ5qgNG5/d/gryehl30Y1/CTXdQtRUW4Dc/JVp3UU+56hiCjN0tkK?=
 =?us-ascii?Q?pD9UO5W4eOK46+l4eT63HlY1/7EpFEioV+k6j9hlWAWpWLiIEUQvXpTbKuKp?=
 =?us-ascii?Q?WEBXDLmR7QM5QBzv3tBCRMlLHq+1qRLedVC0ypQyo7wGEHdF9xYSMq58jSFc?=
 =?us-ascii?Q?WTTSUtlOOZtr3t0Ftb6o6fkkfmaSl9FRodeoBfyl7esodQGIzk95VzaOLbO+?=
 =?us-ascii?Q?A1TZPY3qSzQjcQtBberthwKxgt7/ZWsQ434yWYjOtUwPJR/aLLoxwdbH+83D?=
 =?us-ascii?Q?JbluMQbK5q6MS/DqpY18kg+TgdDDLAGWIfQooFr8IJEakCfEhXNYzwd5e/76?=
 =?us-ascii?Q?C9fhwUnxd+dnj/QY/1I=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 17:56:48.9967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e569efa-2e22-49b0-8bd1-08de52cd1fff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 13, 2026 at 06:41:03AM -0800, Shameer Kolothum wrote:
> > > -    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> > > +    if (s->tegra241_cmdqv && !tegra241_cmdqv_alloc_viommu(s, idev,
> > &viommu_id,
> > > +                                                          errp)) {
> > > +        return false;

> > I am confused. In tegra241_cmdqv_alloc_viommu() it returns false if
> > alloc_viommu fails. but you seem to reset s->tegra241_cmdqv as if you
> > would fall back to non cmdqv setup. What do you try do, fallback or
> > execute either tegra241 code or default code. Or maybe I misunderstand
> > the uapi call sequence?
> 
> No fallback intended. Currently, if the user has enabled tegra241_cmdqv and
> tegra241_cmdqv_alloc_viommu() fails, we fail the device init. Sorry about
> that to reset s->tegra241_cmdqv and !viommu_id logic, , that was a left
> over logic from previous internal branch I had.
> 
> @Nicolin, is there any such requirement for a fallback in this case?

Likely no. I agree that we should do in the cleaner way.

Nicolin

