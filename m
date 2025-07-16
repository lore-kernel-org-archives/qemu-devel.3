Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A72C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6bV-0001dW-3G; Wed, 16 Jul 2025 14:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6Zt-0007Go-6c; Wed, 16 Jul 2025 14:10:08 -0400
Received: from mail-dm6nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2413::609]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6Zr-000754-6v; Wed, 16 Jul 2025 14:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC8u+J0ENqTaBcNNxYHDJnIGweghg7JfFrZWkyHBQRF3BpKO/Z8BUadO0BNEQaeyPKm+sgOwJZ7/xR6OqHNtC2MmjuXUmqd9xPyVHaYz/8Ukat+51qdwK7Xk3qOxYd9x5El/dEpOeAfGYAoqZdmLjag/VbkRod8w9Ijum4pqDqd8O6OcQt8tFTCdkAFeFqoAh1sM4ZUn/v6Cdwht4z20FP8FxlSXHczsEx0NPQer/G6nLahiP9IIYQsesaXYOD2xwgliLFU4MDr0PPXGKcGOcMJGuiDfp6ouZi4WUY/JYD0F1d3vfFCFITmOq1OBSaonQ+REDCPz+i9HuuSLJs3s2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr0Erdp4bwM8yG5ioO6lyFfnonF0dZ9gCpTREY8XkAo=;
 b=CtQLZiYSBlzlXRQYM2actx5MG11BFFuv79JymAi3di3X/Ak79D4Vz1BWmVr1klBUyKt6nlJkLQ8GjiRSPof1jgJzW3F0FqhbLvmMValHiGuIr+vtcRU/qP+bXkYMU4YV1IoAcJ3m95EgKsQ+/rSColFDyUgr5wavyJNzGP5wOPLyn5hY7wZ+NeXGHLhxgb5E2j/Evaj8QNlHRKtL8Oh3dWSUHrkZySNZppfrPk2ljuy1SFFcXGBraBtJZRe6WX9v6MvWSG/FI4wqmHlLOovCS1wDtr+4KzQ5cEnJNRBEiUYVB41E1HnMgazvqcae9q4rwnm5xdaiWq8ZaeqQHicUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr0Erdp4bwM8yG5ioO6lyFfnonF0dZ9gCpTREY8XkAo=;
 b=j1nMXqteQZbuzokpZerFvCEHFeaTp2pLi0i6c1dRGqT1NV+ouwow4f5x1b3xIh6qjwTcnU7fERieOQRcyEeWxKXhDmJAZXmR632xHJwQkpKYgQWKez+6sR25gDSTP6swBpZkxozV2pOBKFd2SYs9zytjioQOWCd684q3TMp35drFIWojBKaGqybJIAD3SZzf8a/ojdqAa+6adynOPE0EgLMoUNEVnmJkSfzgetGzNfyycOsGKJdOmtzzitGD+zO6ivVogvkKz+7y66y8Jia/MfvSkhxbPr0OGCnkgUaY5J2qsXc2GPdjszf9PMKP206o8bzoX0aAaZsUQo8r3YkRzQ==
Received: from SJ0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:a03:39e::15)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 16 Jul
 2025 18:09:51 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a6) by SJ0PR03CA0280.outlook.office365.com
 (2603:10b6:a03:39e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 18:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 18:09:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:09:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 11:09:47 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:09:46 -0700
Date: Wed, 16 Jul 2025 11:09:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aHfq6ccB44yupGb1@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
 <20250716115123.GW2067380@nvidia.com>
 <aHfi3SS/V6qlx77H@Asurada-Nvidia>
 <20250716174506.GB2177622@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716174506.GB2177622@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ed9fca-ccb0-4ba3-8d6a-08ddc493f59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mmu5waIMNDl/BtJEjZMyeoESN2HP8gvqbhy1qy9TxuLFLS8fzTJpm2KfBOtp?=
 =?us-ascii?Q?Iy4NqYHueIb7duUujqHEyvCPqXjizkCJDw7zEzEtTlnB0+3tTBAPhxruvbWH?=
 =?us-ascii?Q?c0Y7lqvHRQ1FvXBx8ewcXOnnXLX31jLiKG0Q3CRr8wzTjjUC6BU435f7vODk?=
 =?us-ascii?Q?6sTAMWBVtK7Vq+5Z53/aCbikZJ+7hMEnn2C+yRzK6tgvG2Xcz68OT8/tDSQZ?=
 =?us-ascii?Q?2rVV8Wo+xls36lKnvISANWqr9vzGeqSkGfNlsIFklOv+H2QjceniGZZk32kd?=
 =?us-ascii?Q?S58zXPgYmBU8zUv35G4X8dtKCeb6mtZ/3GuinxEqg2UghagWP3s86f5Pd2+w?=
 =?us-ascii?Q?ntcmzZln2N7zVn/Pw2deBJanPR1P4e0t2DZXJ+EQYiMiRBk4UOGFq+x/iztb?=
 =?us-ascii?Q?J2FdVn0x+HVFo8BqBl+aSRkWj/+Hh5/jPlvgqF4uQ0Xc6Msk+vANL1MPsXut?=
 =?us-ascii?Q?GP2FCFTQRD5qb8Ae4FhqDmFiR+rvpynfoN4/amUqd6Evy0KLATMWKkk1ICp6?=
 =?us-ascii?Q?7TGJN/RTVnSb04mrT182QSm01nowEdhiux9hTDpi6TiV8ZOFei043KC14LVO?=
 =?us-ascii?Q?iQtpGDxGeLTHWAVfXMDnIlBf1FZ89VmtkkSZ84QWnduNx3562czA2cGNyueL?=
 =?us-ascii?Q?w9n1W0dVnzsco9oF21fedxwKER5A53ZGaXctvs9Sy87zm5qWvUXY+z5VbhTD?=
 =?us-ascii?Q?YpPrXVv2fiDl0dCeGLdhPiuRytX8M3k6FeQ1hhT/ZW1JcpGgmJ5mvfM/Xef2?=
 =?us-ascii?Q?MqVYpLLFlQ2Q7Q9sCA96YIkfq1MBw3EjUwOKIpZxrNCalXhLrD81Xnrjjvs9?=
 =?us-ascii?Q?7WmSVD6vvHC2mVn5UuQ9Auqe5cR0+sKrr4Z4PhZWga6ESPeqrb/dZTZE9o1o?=
 =?us-ascii?Q?QiWzWsKurgVARDsOmRfzrfsKe6IaoWrbT+M677qWnCmX6rUcq+f3t10v6gu4?=
 =?us-ascii?Q?yW9GPmAPoWK9Uu+ujM+Fx1x5kYWJevb+sHGfSBPLD++thC4jTR/GMe/A6pjC?=
 =?us-ascii?Q?jQ+ZLXAoszoe1m2PtiPZUouq1MLFbCmi5+u46xb4bHMEPX0JW6qnNIi3a61A?=
 =?us-ascii?Q?j9eXm/ytcKiPuiSre3+7M5i3sfT/W+fBQbCSOXyvJGywFakHsLADEHS6oJuO?=
 =?us-ascii?Q?dxq52AwqInWm0Nuj9PaSwvNMpojOhHZQf7hyu49o8CeGWiLv1HofVaDZMPAR?=
 =?us-ascii?Q?G6WSocMHgXIktwkn3lZ074f1feUF+PwUKMBeEsO/fPlstXfuhv+Izzl8wLcJ?=
 =?us-ascii?Q?PqAZBfNNSWp3eKG85QDCFUXxUev4zKyJUlJtDhsL+wKYEW9NahYPzw4ZDGvx?=
 =?us-ascii?Q?4duTmGSU8VpYKPpo9HZAuovLwJgODyyglxOueE6JmHA5LoEP/yzP4rZtM8Sj?=
 =?us-ascii?Q?21N5oR2yRDbr62JvH3ve4mvmIxbMTr2L2AjbpnQ04olethmVC5Er1BxqdAWN?=
 =?us-ascii?Q?2ghGOeHDJC5Eu6h3rDQQhceCwyYLs5s8vvAEcEEw3kDR8b/U4Ko92Nghy6Rj?=
 =?us-ascii?Q?5zaL5oW48lCV/kYMpzN6qI7S25gY0xG6QHx3?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:09:51.5994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed9fca-ccb0-4ba3-8d6a-08ddc493f59b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Received-SPF: permerror client-ip=2a01:111:f403:2413::609;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 02:45:06PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 16, 2025 at 10:35:25AM -0700, Nicolin Chen wrote:
> > On Wed, Jul 16, 2025 at 08:51:23AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 15, 2025 at 07:57:57PM -0700, Nicolin Chen wrote:
> > > > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
> > > > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> > > > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> > > > > +    }
> > > > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
> > > > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> > > > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> > > > > +    }
> > > > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
> > > > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> > > > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
> > > > 
> > > > Unless there is some conflicts between the QEMU emulation and the
> > > > SMMU HW, I think we should probably just override these fields to
> > > > the HW values,
> > > 
> > > The qemu model should be fully independent of the underlying HW, it
> > > should not override from HW.
> > > 
> > > It should check if the underlying supports the model and fail if it
> > > doesn't.
> > 
> > For every bit? If there is a conflict at a certain field (e.g.
> > VMM only supports little endian while HW supports big endian),
> > it must fail.
> 
> Yes every bit.
> 
> > But here, I mean for these specific fields such as GRANxK and
> > RIL (range-based invalidation), we should override them with
> > the HW values. Otherwise, the guest OS seeing RIL for example
> > will issue TLBI commands that the host can't support. Right?
> 
> No.
> 
> If the SMMU model does not include RIL then RIL is not available to
> the guest.
> 
> If the SMMU model only supports GRAN4K, then the guest only uses 4k.
> 
> This exactness is critical for live migration. We cannot have the IDRs
> change during live migration.
> 
> So there should be some built in models in qemu that define exactly
> what kind of SMMU you get, and things like if 4k/16k/64k or RIL are
> included in that model or not should be command line parameters/etc
> like everything else in qemu..

OK. I see your point. That will leads to a very long list of
parameters.

So, a vSMMU model is defined following the parameters in the
command line. A device (and its attaching SMMU HW) that's not
compatibile should just fail the cold-plug at the beginning.

Then, it shouldn't run into any problem that I encountered.

Thanks
Nicolin

