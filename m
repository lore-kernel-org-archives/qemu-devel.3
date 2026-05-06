Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA05CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKh5S-0002lJ-Ea; Wed, 06 May 2026 14:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKh5P-0002he-AE; Wed, 06 May 2026 14:35:07 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKh5N-0003Et-Gx; Wed, 06 May 2026 14:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0F80MjIxEscNZ7ar99qDxVVQBMxP/XaRWQxiNjq8LJp+2G+Hg2avo+rN3umt0nUu18JSJ3fDWgxFK2tZB/7XNxpmLgnfPTcY71eS/+S6MvgakxnLMIAP896YCCUS5PyXb//r/4+aUzH7PNQN2IWlRl+eXN+us34T4NJQj7AvWhobsGw6D+Hc90I4qoFpVWUTSlqAvMLY7x12e71mKTpvYhUY38uh44fZp79BB++D9bjWXEzVyW2dr9K2+qwJz5QJPzyR+YWN3HJc3tzDx6d/sh7wvdg8Epmyr7F636cg840r0ToJexQ8E8/+eX20+gCN0pQJ33BbvrIUXos2QPPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbV+oyDC9RO8IkuFnTQutxrp9zgX6ajzqAdy4dJABT0=;
 b=PvAF8TLB0UYsveAXW3guK/YheLkG3gLSXkA4LlD5P3GMJ0ITdW92mDwsDB5fIiwIZDQXvh5dcievZeSocSb/J8QNYaQZ3AJdMsPSIv1CQt761hCvG0rKTzY8Qpw17V1kxOAw9yUEIuMbCujdko31zupSifHqZ+6wxtS1GYUJdyEhx6kY5CoFUvZpGXH0dC45nTZg5RcMZgqbKZj1BpalvLIF45NN1BrAeQ1LtsAXyAYbKgTArtDw2+fslPy3+j2pO8v913nQKpo3CWWGhnNyxEyqzB1bm3xgokdwa8KZuK/UZ1tnP0PE6tF23AV7zMohEmaqVm6L7AXZIsePHPiHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbV+oyDC9RO8IkuFnTQutxrp9zgX6ajzqAdy4dJABT0=;
 b=JdDsyGUkjKVeaiQdX+B66cGqf3Vs1sTGVdK5vXVw/dTDj5rwRVKXwd+2oUqpEPnh6lj1IJG1Sq3h2sZkcr1rC17ORnGsJkBmJajglCkofji1BOB4+8RxgUUJ9oGv6bZJZdgLxUWQIXVknID2Fk5A4AlORj18aV6Q+G2X2pMyYw8mj1ofWjeORUeKFig33rtUFD54Unmz60XAqpN2q4hF7c0vzwr0sJK67ZwgPXtrCFvv55aZty88KNnOO/5kPrCjX/RABJamCQ6HapEo6BO1yOYgSmiYaf2bPEvTOCbIEvBdOXCQSt53Bp+STqZWmvjFys8r1u+g21YBuQFST0PPFg==
Received: from CH0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:610:b3::15)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 6 May
 2026 18:34:58 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::74) by CH0PR03CA0040.outlook.office365.com
 (2603:10b6:610:b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 18:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 18:34:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 11:34:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 11:34:37 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 11:34:34 -0700
Date: Wed, 6 May 2026 11:34:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Message-ID: <afuJt4lDUQ6SxA6T@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
 <afk+zBZLQx+x+ODl@nvidia.com>
 <CH3PR12MB754892989B2A76D3D3A941D6AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afpKfEvuT3ZeBSiH@nvidia.com>
 <CH3PR12MB7548E76E38625713F6AE9F78AB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548E76E38625713F6AE9F78AB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: e582dbec-a45c-4b7e-f63a-08deab9e2c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HeRKZjzQdC/xVHW8O6dK2aRhC84QC2xcmixBtujZCX7whc8Jk4LSFb6ORY6U5V+9HM3lRVoyNCSO1O8UblLcxURe6+T8hjtGX/pmO1zp/5aL5jHlKiS6eC/7rr1CVbPCI+k54c8AnJ1r9D1ai4+g1HGwbkAfG9JBezNP7HRbD3ftUA6PNzU7Gi3qXSvihC8vVT1KPixcRiTTxva8WN92rBGpeJ1MiUG26mrK9VOF76EXoVkk8IYRN6T53DymCU5pTmFDev0N/yewDyn5W9ZMCT6YLZ9v5IYdy0sCaQZcCW2ZacTjEOcce/kDTouPVejJER+WT+dvGXm64xZdEx5f8oj8QIuRxE13dGB7uS5aK+fj/9iHnj3UlAwTbB5itDGTXYMhN34jvvWWXQdu0AoNVqRN4XMHTigpjCw0btccu0ZK7iw55lOe9FLhBbyASooD91sFOwa+IOk3hB8m5fymuHjlT1li0OsYXySRPWd80qM7BdQ7JE7p4r9Qb3KvC1L4/744QHv4S2hQd6YZW8BBzP7rJ1ZHVBoQaaYNm2CrvG/DIaLKJaYnpQ7T3vR4RLdoVNBI0eX/16Qs0JA70a739d3eLGzuGC805OO+3nA6fjeUq51NX1+/xnBBqVtN+xbglcSY8HxY/dw0nDQzRYmt/o3x9n7Lnhj007eUEcuTtpXlXa7OQhqe69zG3++xufNwxi8WNGXHDxxGWJiE2Xt/ZzCjsyuVhmfw5Gi/hcUcEsU=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2pjGKCAtstfLj880fElq3xO1T8vMudS6dOyXk0S8HipwpS4oiZ9/S0HwQIPjFzzAvB9Txbo2e0HXIJ6UwQJphrsUGJBHvHiyymYzAORg28Z+znG6UJWc60QrKd/8tG+XV1CSKwXLfx39M/O1fj/EGTLIuVA1pLEMzn1CaeckaErnyLA8sxcV4UR6N3GEMFASkO7DLg5bBZwCcdHZUHmb6f8Q5EEmdwkl2lBPvxeHKFKI8F6+DLSlOyTtBFWVZTNctFPw1EzZolKFNdZTZiJfw0k0rN5S8WNSpzXXn69v8JuGOJvKA0vhq/B2wGN/HM1+bE3xJoVAg8cKAr1Vfn/IH8O6R0baGAb2MjVWwSKQO7ZsLTKX1ZosqNr3mEGIPMGwmi7VFo3z+TSN0BE34e6aAYZRPCeF7jVJExPtoaKK79qM95fg/UOj35+WehQ3xp5v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 18:34:56.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e582dbec-a45c-4b7e-f63a-08deab9e2c47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=nicolinc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Wed, May 06, 2026 at 06:16:00AM -0700, Shameer Kolothum Thodi wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Could this be a case:
> >  - Write the PROD_INDX/ CONS_INDX with a consistent value (0xf)
> >  - Program the VIRT_CMDQ_BASE
> >  - Read the PROD_INDX/CONS_INDX, expecting 0xf
> >  - Write the PROD_INDX/ CONS_INDX with 0x0
> >  - Program the VIRT_CMDQ_CONFIG to enable the CMDQ
> 
> Yes, if Guest is not spec compliant then this can be any order.
> 
> However,
> 
> >  - Program the VIRT_CMDQ_BASE -- suppose we call setup_vcmdq()

> then kernel will reset PROD/CONS, right?

But I don't have an impression that QEMU only supports Guest to run
Linux...

> Again, the question is whether we should handle all these non-compliant
> cases to prevent the guest from shooting itself in the foot, or simply
> propagate any hardware error events due to the non-compliant
> behaviour.

I don't really feel it convincing to call it non-compliant. HW does
not disallow that behaviour. Also, the flow in my example does not
shoot itself in the foot: it basically follows the spec recommended
flow by adding a pre-write before programming BASE. The remaining
steps are still exactly follow the spec recommendation. Yes, it is
odd to do so, but it is not insane yet. There might be some similar
corner case to exist for certain reasons that we can't imagine yet.

And adding these to making the QEMU model closer to a real HW isn't
seemingly very convoluted? I'd feed the spec to an AI and run some
analysis to see what else we need to cover here.

Nicolin

