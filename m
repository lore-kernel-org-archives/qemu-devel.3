Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0A0CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 20:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGNBu-0003k2-E4; Tue, 04 Nov 2025 14:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGNBr-0003ji-D2; Tue, 04 Nov 2025 14:59:39 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGNBp-0008P0-QJ; Tue, 04 Nov 2025 14:59:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7Tg1NLm3ICo2wb/+JyDtpQgvYLwvaW1C9Ab7OprMXQ0kGuqe92VwPw8FC0WnI31i1WW7tn/wHu7k+K3RJEXVOfB/Y8mEgJAgQ9NAf66CDAvRgDcqF3xe/QkgjMGe5YTBrLQWxhOpr4UBLd031xl4dcoCr77B1JZLOZC276jxuP7DLcA+J/ofNr1tBgNIdrO1couucr3tSTtjyctCZQrHRgbp8RVT+aJX0Y7bHe98vQQMEzoVx/hlRa7toZTjFf4xqwwJy2yZD4kYHp9+mJ5APYbl21JMJwEiO6ryc5thqtB6KRyBw6UoWovmrxts4GLZvSaomArKY5tX/eLc3aDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAcq1wbReewZs16VSkMaGe6K5z5wUebD+XwE/5c8uno=;
 b=X2Q2xqLjxEFKStmqWW4jfnhOdKC+aZ2Eo0XOcO3EbkmxlmbhYREHDpcejTo3DYknqXeAAlnXT3U4buenM026VfurRJStzZmdPVHEoKdcoQV8Ka1N+XvdAIdwCyEM2V4E3TXRR0fzqTHKmSeyIdeqb05PBLW8hYkQp+c6MHCiHOFnsr3AD/BZQlHxLp9p8Uas9iRCsQCPq0ZliqHO67e+KF3s07J0/rVE1OBhwxmb6RQzfuMp02U+KgqyRvWHjPbaatc1X3Ehsu3DOkajarGGvSCptxlYvLZ0AzzyrCseA2nI4zIATJ/YlBlXOTlURdIk9x7zr0TzAFaicWan2NqPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAcq1wbReewZs16VSkMaGe6K5z5wUebD+XwE/5c8uno=;
 b=YX0umrJ2BhKL+HsActdp2pz3pKA9wSj5Ij9sIgVmGvZz/oAtlF6ifPC67kws5VXzEEyMnK8TIAROzH82IC1HWA725oBl4Zzn9Fj4g7OHUkMf0vHAFu4OZbKiDNcBWA5Vmq5bRsgPWBhLqwVeftFK9Fen8fL+rrRlI4+0zPno3RPHp6r6FBD9GA3sCWUAlzgVoSyMxo/gf+YQSBMKpLQX2bc7eq36SAuTgLEofCpuRZl2gxVLcEX4x6yI5+2+ALotLov3bdj24Kn8anOxOICS1qlZFEsXURlOcrzSTM4yYczxv5cCgUTWZ8TBwXP1XH18RWe2mxYvW/eUnGd8cFnC5A==
Received: from MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 19:59:31 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::38) by MW4PR04CA0144.outlook.office365.com
 (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 19:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 19:59:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 11:59:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 11:59:11 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 11:59:10 -0800
Date: Tue, 4 Nov 2025 11:59:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aQpbDau45OdUC/5u@Asurada-Nvidia>
References: <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
 <aQpJi37XslsYV+Ez@Asurada-Nvidia>
 <20251104185651.GL1537560@nvidia.com>
 <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
 <20251104193521.GM1537560@nvidia.com>
 <aQpXSymujCs9l+MQ@Asurada-Nvidia>
 <20251104194552.GN1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104194552.GN1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 30173986-4762-4bb6-f08f-08de1bdcaac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OBjCweWbFwsOCdKvrQ6JBO4Hn656/enJ05n5r9PN1JOhJi9ay0CZC1cHNjB8?=
 =?us-ascii?Q?KhRkwTCs1vc8RnmCCZFfEEULsSzWSp7lgYBlt2HIyix8lLQM/LdvJ2MHjIxR?=
 =?us-ascii?Q?fn/48oTQgr4N2esmx0L7jidThcwdqfUOrgrk9oecvqhQ0Jwhqq98uyFAnePy?=
 =?us-ascii?Q?qD1EMu7m2J8WHyW4N2ZJC4c/dcuwHR38MD60BGS4SE1bBkh/EozLqAaivjLo?=
 =?us-ascii?Q?IfCGiXdRVhBxVErBzsGsARUHjha6dzPzwnyWa0vhTpHESKfII8fdMSasY5KQ?=
 =?us-ascii?Q?qJwoZrpP5ezAB/DJZoLfexLl6mfkF/j4H2c7+AN/LcmoOmJdX3hqn9q/tqy1?=
 =?us-ascii?Q?G5zlack4Ep4dQHP3rWUkrujNT1NeILvNvuI0KAeKzB/QctVWOmPFjVYbxFqU?=
 =?us-ascii?Q?LR3HHEeGNqZNb+HwDEd/hy3CyHND/ZYhZiz1Z/LlKNrwmk+t2M+gZmH76MoZ?=
 =?us-ascii?Q?3kF88Q/xd1MNbKwIBDwoYRwjliFdANgyz1l3HoSgxeR2HSCSJT9kndgk3cHN?=
 =?us-ascii?Q?0/UYyLkU8wq+ZzCq9p1F+7THXTSnBo+bUcdEXtg8Xn3+MwI9R4810TOUYyC/?=
 =?us-ascii?Q?g0gjAsalF1bsz8Bvf3yjq2ZNIa1wDRrbYrzK5erdY3pHQmYR4U1WKZ3FmlKh?=
 =?us-ascii?Q?Suo6Zl/VJQNQ05Y1r72fI+qZk9SyeHFtj/0no/qVw8+F5BXm35+uX0ldM739?=
 =?us-ascii?Q?oSBqmMCo/aqKVmnbtG3ZCkE9yDJoyn9I27nBoE+MJkRY4DYb4sK1hrChlMJv?=
 =?us-ascii?Q?3ZjQQ/GOFKqkNp89UlYIhPFICCjbPn6FidEjIPhVhjHaknWRE2em+7jVcfyi?=
 =?us-ascii?Q?ZFXazYClESTT32aGbj9fN1bYNa7rat16ZIT19QMq39ValIv6kRI5/99aeTXu?=
 =?us-ascii?Q?JYA/3nCaR1BigkC+CuVwaKZ/6peJzQkPmQ7spDdz8Ij88tRF71SMXn1NRN3C?=
 =?us-ascii?Q?36//IfYiBrupcAaT9sgkiWwdu+rpvc2hMpwT0lOewMwVD8+eXaKzUotqnJ9W?=
 =?us-ascii?Q?8IyBOAzycVgmbUqiDJhdIwZ3npCI//HVBz1f08Yjbn0t8lWW8pWWIlUOVwx0?=
 =?us-ascii?Q?BP818fGBxheChFVmPdlsjum30po3f7/w3siDPL+cKronSJKPc9PGBi5aZ0Lt?=
 =?us-ascii?Q?cGJuWwmhzUNEmgCExJVAHWtYtRSVx0djwBO3s1OW6OC9llNGm0apyAy5QSYF?=
 =?us-ascii?Q?fW6AwZJj43ZM0IFSt3DmYrB6TsxAlxSvpBunXpZAANamHrec//Y/gkD2NA9R?=
 =?us-ascii?Q?urYDpcn8Iso3aTnPU9L8UB1hWyKM738ks2QAWS6fVAJEzKAfPI7L27YFum57?=
 =?us-ascii?Q?rJ4U8a8gpb9xkCoOJJoD/JxAMtAVJuGNrmeqzJvRbFlZGSqeK+hvnAtOj1Ll?=
 =?us-ascii?Q?L+SKnmakUDq51F3iq32NmlAl2ESCPTlX2pCy3bPCD17DXW9XcWh6nyc7rSQb?=
 =?us-ascii?Q?MpSROt/vHXbPbRPOHYs5m3SIC+3TBpbhovVbZPym5gp8XRDimcB84euIao1J?=
 =?us-ascii?Q?xK6qMKLr8mVR2N1EyjC3zopxTUEkhuN80O2kleRrSH1TNbZmJ5FKvFqJChxl?=
 =?us-ascii?Q?cUanWzJOG6SAt1vsnBE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:59:30.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30173986-4762-4bb6-f08f-08de1bdcaac6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 03:45:52PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 11:43:07AM -0800, Nicolin Chen wrote:
> > > Right, but qemu has no way to duplicate that behavior unless it walks
> > > the full s1 and s2 page tables, which we have said it isn't going to
> > > do.
> > 
> > I think it could.
> > 
> > The stage-1 page table is in the guest RAM. And vSMMU has already
> > implemented the logic to walk through a guest page table. What KVM
> > has already been doing today is to ask vSMMU to translate that.
> 
> No, we can't. The existing vsmmu code could do it because it mediated
> the invalidation path. As soon as you have something like vcmdq the
> hypervisor cannot walk the page tables.

Hmm? It does walk through the page table (not invalidation path):
https://github.com/qemu/qemu/blob/master/hw/arm/smmu-common.c#L444

And VCMDQ can work with that. We've tested it..

Nicolin

