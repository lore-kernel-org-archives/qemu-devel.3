Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF5CCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxqu-0001ru-H0; Mon, 04 May 2026 14:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJxqo-0001rG-Jk; Mon, 04 May 2026 14:17:03 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJxqm-0007X5-Th; Mon, 04 May 2026 14:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzWoS0J36nk31R+L7EMUvab3Gdgu36svZrLXXOLVfIDbYFQeC768Bedp1YVK23BiFK/+LU0046s2zOgMp7X0RoXDu+cg5cmLnHHa1z+J89VCE5XSmES0VEerxTu2PQjFlv8emOxyx3DGx1nQmy2xMv4aUuolY8F1zIT48i/aCG2ZV+35e/EgTy+DxwsBA4yccAJiC/A/V9QfuCkO1DSvOrFbWzlfmz9y+ZvEZzb8eMQW9s+zJVPLhRF8pFZNeVXWln/Xqipozk6V7SYi+D8t60tkQXtmxhF3++LvCcYozyFm71J8VZVVE9zWVRlVz25dvobE9aqmKgeVicdAtwdUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zep/MlTa5sdX6esa8DK8yXEyEj43ORBx4qo3nON+MrE=;
 b=vEPisV3ZykE9c3lo9XMy9tXuB6GFp2rWSxSn+bxs4ppnAUvtCCILrA42IhHiXiTupdjrvH6QHY5CqyZX9pvAqsaQVHS4i4QUC1A8kjCLG29gyA8PHkyowR5SNc9leF9G0vGY4n9p2GAeYYpa9JhaSZDWNibjoiXgUTg0+1oxT22lWxLOul2bDC1BAIEUvF5+e8dZguKXbHDH4066qwmDe5Bl0uddraY5Yv4p0WBra0leuLQocxynv5WDSA4tktu2dPFWqhL8ruHiq3X4Yks+6BMkrBPfGaQLZpJ9OVRg3CbZd99iVYVzuovTmTCj/kxkLeSeyOvgKs7Px1FdVfGJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zep/MlTa5sdX6esa8DK8yXEyEj43ORBx4qo3nON+MrE=;
 b=A/ROGtTpm3jUxew5d8rE0RriZ3bxH6lHvR7FYFGY5KgdkLGHLAYo4+UUW46GGAX+8xHj2uHIMAQ8hxB7lrPdr3ZbRltC9K9qCd2Bpct3MBhMrjAC3fOiViAVD3o75dnfAIM+AN4O75txezrOclekVMGICnSno1KZBzk2kbNu4BEe8Hw1QhtRArLdgOC0TVPCvg9nh186SLPBkdoiAczVOkeH97ZQItSihYJIL8E7Zqtc8Z4EZCMsk5PDbMtWSLsP3JMVCfItDnXtdmMapaCvJbSEtbuz/WniaMxGeusI7ixz1GJRkYAOJ3LU9VQuNMtMHBQPZDJmmFggmHD59MO3Yw==
Received: from SJ0PR03CA0123.namprd03.prod.outlook.com (2603:10b6:a03:33c::8)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:16:52 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::4) by SJ0PR03CA0123.outlook.office365.com
 (2603:10b6:a03:33c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:16:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:16:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:16:28 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:16:26 -0700
Date: Mon, 4 May 2026 11:16:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 05/31] system/iommufd: Remove unused viommu pointer
 from IOMMUFDVeventq
Message-ID: <afjid8vaqLJnsAQ4@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-6-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-6-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d6fca1-d525-4a2a-1da9-08deaa095093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GxKyw7QY2ZWyrS5ynIl3wt0sF8zEACu+TFiv2OFiKVLzlNqMjffN/rhszrvFF8lQ+ys+shvo1IDzoCiZ6gNUmQSwNJ30fv/4SFnXqMLos/ZfvO56+GRx0q+2G3Oc2LuTmy9B0veZUp7LwHi55H5zPs2aN/WxTgukrES0FyHSOfghzsks0IqAaTs2kbBdBjYeKaEBgkHSpLRqIyaSB/t9A+MKuTe/Q1TSPlvHKAxmb/eHx/hbYyRor5B+1uEK2s/nv1aBt0aCgnPppSi8ie9D9pdV7sHQl47SBtymghRvadH94va4ldQz6y/cpUUUFY9amQQa7ua0lmx4ESJI5coIh/J0aVgC7SR9fxxxLi6XntaIaKJYH1Z4ZVB+pE3GUIxAVCDXaGeynuPzOkrevuaiNh35jJ5393UY1+Nz0y+1Fn/oTHUhQcuw3DQniNxIEGs4de94EE+AbHqlXyLkd2pA04ICdV+z1hbljHcqwdmJ7c95u9PSICUPpMOX6Q7mVZChiLiuAh1oabE7ZmI3cg79Rhe5nlLsMVyyxOB69yWxbHglnIQKv3Mbgcz7CuygeDXi8DPhFXwXbWnKln4q+FWq1qR9Y2ZRGtE9kL4VEhr0KCVViG7W4vxloxBQFkpWiJmEHPbT6BoA5uDZAeT2HuA8J6/tTj59Ag4Pu8pFrTzBnrUgcZb7xa8fiHj0/tI2R6YDRchrG9mPnqrDp2mXJ4O5LMGYVZGfx9j0U/Vmw3xLmFo=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HI42awplW+cyVkc1WmpTXkeBadZKaP6ZrU8o4IMbTR9cwHRKrEg2QkHWjw2t11gisQ+uNEuhTZh924GWPgCv9o1au+Y/xivwqXg7yxd0p6axcuMuZ7Q2F3SS9ihlmB5mIeqR9XdhpO2GLp6I5GlcCYN4g2mW8R/E6LBAXqhN8fxj67irna8bCRdRy9pzwwbr0z0xIPMWxuEC5iXfdwq7/MbOwQW8DFZVhpThCzETHUs63PA7GAW3baFiKkjSNKkCsaX+z/n/A1KNcHT1S9QF7MUQoNTJjxKMPxPsejQ0d0nwOANbsvbgpvPUpd4E4sRFSymyQAw8UCKtSq88cgVFmdZwBopM2fcPm4pmQQkfGa/0yRbwE6FbK1st65FfEW3o5klsAKyjY/B5KiJewtfe5EwTvPFz7TUpvI91a7SorTxWr+FFaM+XceYNOMeeeVUh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:16:51.6133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d6fca1-d525-4a2a-1da9-08deaa095093
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nicolinc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 15, 2026 at 11:55:26AM +0100, Shameer Kolothum wrote:
> The viommu field is assigned but never used. Callers freeing the
> veventq already have access to the IOMMUFDViommu object through other
> references, so this field is redundant.
> 
> Removing it also simplifies upcoming changes where veventq is
> allocated based on the viommu id before the IOMMUFDViommu object is
> created (e.g. vendor CMDQV-based veventq allocation).
> 
> No functional change.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

