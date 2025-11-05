Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5D8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjGp-0004ho-9P; Wed, 05 Nov 2025 14:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGjGo-0004hb-2S; Wed, 05 Nov 2025 14:34:14 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGjGm-0003gF-J5; Wed, 05 Nov 2025 14:34:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaLGIYvk1UnU6rzoSf33WQm7Yzr9ZBxhfR4k5iDPOCvX+AaHa07eHJW5XSvWdgk72UItFk9Inouzb3ajdTEM1Al0scAm4z1I0iBzieJQPJmfi7JU/ECWJktwR8tGH3OdO9beOoICZ19t6RGbLmMbn+8qxKBTXPYYaX/YNpVSwDPSPlPW1puEcuw8PQ0x94m1D9Xs3BtpmhngcT4mXd0ExEfGhefoLphJgaoQbNqozo1fA0nISzIRMvx/YeJV7TDohu3m1kU9O1MBbGO06JBKrszhoZ2gGJf6viHfODHMsn6nFETYuAix+hm/x8ht3o/kpBULxRjvFA9oudsDyX2oDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ta48nbcf3OMmVzNqoas3aqHwOApyS/rSdEJXHpepE=;
 b=cVZ4/EAxUf1CAQN43aBUYd4hCWE7HSXt7Ojxz9Qv57pNQPgxHJ8U24B5tt0faXa97E5bSIcpyKeMtokMK3Y77nv8Y9n2Kb/IzMYsFmIRgOTLfNmQq8QsreaxhouDdEfZ1CRQPslrnA/jiKysdorbKKBC+fOWlB4TuiFpLAbdw9FLzpA1j4WEtVFi1X0QNu6hb8FEbe7roTosFH9pEZK3wb1ohykoDF2MQcyK05WsUm2jp08eUZOxwsxNzE/SuODJCsSvFCzHj/wGLJgHEsLcg43LxZUHIc0qnoQUYG+i+4eXCu+J5P3oSfAgudLQlbzryuu2maL7M6YPGP3hzCNc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ta48nbcf3OMmVzNqoas3aqHwOApyS/rSdEJXHpepE=;
 b=ju6fYhZ/QKbn0ZinV2z7CZSgxCqiTUyidlK5D7n/sMUulMwwEUBfj3W6T9Vk65Y9BbXjtbji5wJclS/Mjv7byUQaoHHsqeeSMQLpid+LIcV78uVk6ywG1ybhPYvfHC2fdR+bA/q19aknVZOYEYvxckEqy5fFxH6HeSgZqJo1lUHzPYrx9rI+XB9oFRzPLU+jskqyC43k0QOLTZcEv6HOlXleLUpum7aouIgeJu9AVG2CLNSShvSlgxUXqh/iMmQadipY/YBP5OpTeLEdywI477Glp/flH9fBy7rsJkIVTIagTR6BJ6HvaESaU3Or0YOjkR59ruuTn66kwiL8290gJw==
Received: from BN9PR03CA0623.namprd03.prod.outlook.com (2603:10b6:408:106::28)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 19:34:02 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:106:cafe::f4) by BN9PR03CA0623.outlook.office365.com
 (2603:10b6:408:106::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 19:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 19:34:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 11:33:42 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 5 Nov 2025 11:33:42 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 11:33:41 -0800
Date: Wed, 5 Nov 2025 11:33:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
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
Message-ID: <aQumlE1pcKypHs8O@Asurada-Nvidia>
References: <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
 <20251105181049.GU1537560@nvidia.com>
 <aQuYZM/8SX+RtDtv@Asurada-Nvidia>
 <20251105185816.GW1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105185816.GW1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: eefed976-056b-4046-28e9-08de1ca2465c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEuvT47kHm4Lb3pUPBk2n2BvUwM+pkY+Ihm0ngCriplMQQZ5X1srH2fbwFpu?=
 =?us-ascii?Q?rKy3gDyy581kueBnjkCpt0WqdaLLMMKJ4pgpXH8BCB1Kb0Aw/IvwvFtoXm0j?=
 =?us-ascii?Q?VkDdu7/umqHNIJY4uLXQZ0xUPTod9XP18WOOi08Xh6rv0Op2t1GPIeuCBl6l?=
 =?us-ascii?Q?b0Nh7Pckb+L65SvCr3WlfuDImjz083kf2F7shHvQAM67n7gS6k3rLL7K6iq0?=
 =?us-ascii?Q?LiLxrnstLnZ7UTAaflqYoQoI6BuVHrOPEdT8/ZM+CbvJuld0L+JkQFs2975m?=
 =?us-ascii?Q?s/HimvQlmS/PbLGxg6kZSPjcrACN5iRsE4DtXgut80KGjZaTPvyY2ZlWO0gS?=
 =?us-ascii?Q?aVyNNq8QjkJ1usqAJmsiGwXlRe2ZPh4MnwZdmFxHdOVcV1JFVlOTXDU60JSP?=
 =?us-ascii?Q?TxyS12LtpGbZ7yQ2cJigW9OZJ7/R28CP1ppaY2zzXSFB6j4ogju1+2jBBeCg?=
 =?us-ascii?Q?yE54gOLoXdIFWqDRuddX89vYiKdLo9/atBij9RC8ccbcbO2D+bKJPq0E9uDw?=
 =?us-ascii?Q?x0C+k94OFqKS/9LwpMyWU0ZO4+jt+oIwtw64L38AXvKlNKJevgvgfw+NJT5R?=
 =?us-ascii?Q?UYMFNTPVQs9wkCy4E4LD7UYgGr55JxNvOr6UWfIarPwjXM5uQeeRzRFvEAjE?=
 =?us-ascii?Q?rhQojX0o7ENodvRFWK+eKhE4Y0cn/gDfFuNbdrHVyKHV1seI0tMte6OL4pJI?=
 =?us-ascii?Q?JkHP+7q4oRhrsCnVhqegDEY/kbs3z3bbLxDawyuP5v+ENWhjXpsfpKg2dMAT?=
 =?us-ascii?Q?8S1tQZpzQXjPG4vK66gSg70q5MQm3idAD9yhz2DZ1GufA5w+Tbl38ou8Covi?=
 =?us-ascii?Q?0p2RVP+z2odXid+7NqMwrb0/agNPOP6eeagzPkie6c6NglZOsQXigYCN2Xkq?=
 =?us-ascii?Q?WPu6oBL85WpWp/c4KtS/Xnoe7YHmSaaUUPkymX0Q7Q3A0Z0m37/g9CKiJDGA?=
 =?us-ascii?Q?ny17xce4ufus66MHjxdtzEBIUgAL5SdgD7D95CLpeF3h8bFOADTdiFfOZ5yu?=
 =?us-ascii?Q?uUHzA+ERZyiNHCQBzuCJPQz/+A9CB397bx2+XYcqe9q8Gd96uqdQS2xoEO6j?=
 =?us-ascii?Q?ifZNogCvgJtWPN73kvvTKTve58UQxQP73z7gCAPHcOCGRUuTLQiDSdRKDkMb?=
 =?us-ascii?Q?FfsvfYUfWl8XwQHfg7OaH0/Kigz2W3s9W7WGAo88tM8/h6ravkfBVTEXpRQF?=
 =?us-ascii?Q?ce7mmaUI89MElUjqSTYsaQ6qwPfDKnWVG9cEAKAASxhDfV/8Yn2ruKAacToC?=
 =?us-ascii?Q?Y0jBgmfAlz7xdVGahs2jO/8WbqPdX4ysCoxU5VO+7OF511gLpA8D2XGqOhmr?=
 =?us-ascii?Q?KBkiuwYx2tUWHhrNDHHMyi2Ih0NqFiDYyxXX0LKMwmsDEZZBLnVUa00ZAUMC?=
 =?us-ascii?Q?nkdcNM/l5g/UA84fIJvLn6nm1MtgabE8Bx3V+X/3VaoCtRaFANw9kuv1Gkwg?=
 =?us-ascii?Q?3P5ScR1NyM2Pt78W+beRzeXnK5zMEOA1wr2obu8vj5TMPlKg9BpQ1ezA/0kN?=
 =?us-ascii?Q?ttmEbYVNYX0J4SvPf8f28+kJwI1hifc/uSTmcKVuf7VqEAd81IHzm+Dah41I?=
 =?us-ascii?Q?pBvNhiCldP+cSvKvO5Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:34:02.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefed976-056b-4046-28e9-08de1ca2465c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

On Wed, Nov 05, 2025 at 02:58:16PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 10:33:08AM -0800, Nicolin Chen wrote:
> > On Wed, Nov 05, 2025 at 02:10:49PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
> > > > if the guest doorbell address is wrong because not properly translated,
> > > > vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
> > > > See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
> > > > vgic_its_inject_msi
> > > 
> > > Which has been exactly my point to Nicolin. There is no way to
> > > "properly translate" the vMSI address in a HW accelerated SMMU
> > > emulation.
> > 
> > Hmm, I still can't connect the dots here. QEMU knows where the
> > guest CD table is to get the stage-1 translation table to walk
> > through. We could choose to not let it walk through. Yet, why?
> 
> You cannot walk any tables in guest memory without fully trapping all
> invalidation on all command queues. Like real HW qemu needs to fence
> its walks with any concurrent invalidate & sync to ensure it doesn't
> walk into a UAF situation.
> 
> Since we can't trap or mediate vCMDQ the walking simply cannot be
> done.
> 
> Thus, the general principle of the HW accelerated vSMMU is that it
> NEVER walks any of these guest tables for any reason.
>
> Thus, we cannot do anything with vMSI address beyond program it
> directly into a real PCI device so it undergoes real HW translation.

It's clear to me now. Thanks for the elaboration!

Nicolin

