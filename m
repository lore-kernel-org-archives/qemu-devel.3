Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E08CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 20:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKjI4-0005TR-Rj; Wed, 06 May 2026 16:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKjI3-0005T5-Ds; Wed, 06 May 2026 16:56:19 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKjI0-0002D3-NK; Wed, 06 May 2026 16:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWPgGX98MkxbbYHHr+TVUpCjVOogC3cmI6iPF7PlZRkLNBkmLpZNbYO2cbFcBHD4mD40N/eoBkbptHWUi6tgYkDloQxFuuk69YQTt0kmsI2CQ2cNZ7FojDbJhWYS6gvMiJnqWzf423CJDFWIkQRkCwq6qBMcz021jCQ/g5qJxtJEjpH3nOm9PFxEFvF5iAn5IZ8DoaqT5x2TTXXNAM/WZL6LlL8mPas0ExYKZQzwvdyogSG9RuCz4AmH3gTGpKmd5lGWWieNQ0jREah+yVtSWVoIJXyKct/fZQHOA3FhR5jGASz2VrYeACcR5nn5/Xm2HgJr2IFH8zvGoChI5r87rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoKdfukLFo/zc4K6RXdUZPSJi+T2XnZ2ROziFKibJso=;
 b=qW28ZzqIbDDdz4z2PzfuGTg3Inu7yzywToSbOfReMFcZ9XvGrooSi4ECqEGPQ1Mx3+nOEpcD+3R1zNT+PUDl410yy57XyAwW0oQstxkwo7T1Q3vVcdkhYJG1xPEo9m77OOdfJZCbH4DIpH9mBy503PnF/yicKixEMKaBXAxZDnRV7hlYmiaE38PAMC39yGz9STFZ3EgHTU1UxQr7Zfx3B1d2xNSsjb50xGVKLNFPUqSA1E2EVh7ZVDGyODZ3/m7vxUjJWBt/nEXWMnBAMT3h+gSpShVIFfK57VfTrMc7zDVIDrzBPqJC/RpTXn/0m8JeLHYau3oIbmBKE7q8Hy9fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoKdfukLFo/zc4K6RXdUZPSJi+T2XnZ2ROziFKibJso=;
 b=nMfKGQBv3m+k5fxYTnvsHM4fakk9Lnc4w7CGP8mdomxRxCIYWi5+JxEPaVwVufxri0I4/+YEvQAsp5nDp7X4LfO6kIG7ox5EyXPGFnX+wI+M80jION6nI89iN+/rkAlY+jTXYbHUZfdm1FH2oIEbZHWKydSR3vJ/8utAkw1ovWEI25ygkaTg28ZMwplSvv1YWRqshFZ3t/cqIB+4/W1oWc+LINtMfw26ZOPRQXi+BRyl5sO2g1lImhsdMtULdDHFoBveqNuCbtxbt+9jtnMpXzDttlORRm4ZGi5Lb3iO7SHOj7ucyrCB++lEqn4JGXj7Dzss8ouJpNQk/DS1kkMaJQ==
Received: from CH0PR03CA0438.namprd03.prod.outlook.com (2603:10b6:610:10e::14)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:56:05 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::99) by CH0PR03CA0438.outlook.office365.com
 (2603:10b6:610:10e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 20:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 20:56:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 13:55:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 13:55:32 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 13:55:29 -0700
Date: Wed, 6 May 2026 13:55:26 -0700
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
Message-ID: <afuqvoODHtr2KoSk@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
 <afk+zBZLQx+x+ODl@nvidia.com>
 <CH3PR12MB754892989B2A76D3D3A941D6AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afpKfEvuT3ZeBSiH@nvidia.com>
 <CH3PR12MB7548E76E38625713F6AE9F78AB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afuJt4lDUQ6SxA6T@nvidia.com>
 <CH3PR12MB7548FA36B3EB6386EDF09B3CAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548FA36B3EB6386EDF09B3CAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 181668f2-3eb8-40e6-f2fb-08deabb1e3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: scLuMC9BJOLP/UmbqrZtSc6pjdonzwDlW0ChWY/03j5GSLB8fKDkZ0CMu+AxhA7WYwjjlPo4PXWY0tkz/dC7HBaabIpWA4p8dgQ0G/wdDpk/TfsdbWlb5MfZZzlIjkc/bUKlZPO993/Q2u+4C+Jf/w+jjg5aIGLg5ZHLDX5FAyAkI6InyMCDAIyREAkWf68ce06MvvJvnCTxjHKN5F7a3FL8pQDsRbXDU98zjZ/AIsR4C6ceG6+Yo2uCAMVbygBBYjHr9ANPU00enEr/bKAb89LyuG0leQTLTOcFxT0wcJXN32l4YnkvZICSmCsV8jGR0UCcabHv+F2BNGnJmiey3nMu8z0Ue6Vgv4F6AXxRwzDuVcasb23IRekoGdzOAnp1vmR/328zyItimzDnhSdVXWYGLwAgR7Oe+bScXZCms/X8w9Sz6h8XAbZzWhGckKkDAx+0aeDVi/Mb6sMxrdTaLJZXOpmLAX5paVPmTLZA9XI/6QijGOWDdoqzZotxQeEe8CEZYFPm7sCrvYhSt2US842i/XHmqs70patR1uvXc8umz4gIZFK2Tz8SargN5mtp3Xabp+/MvkpRdxjwjB7ZjMQn5yP8hX5OgJN/AyfaYXGKqJ6VjjySallydGr0OGXrEKbo8NgnAgyuzhNgBQoGy7kCLUcs34VoJ7Sj43PgaQ4gp5Q6qzSks6ZX315SXUlB7UB62P9GKLY3AETy/D+PfnPPYHgijROONplMdDZHDXo=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F4lez6S/VHR43TSucF6wYRx3IQeNZVogqaDq3PSqdGokW7X36ZyPNo0eVw2YGrm4ilQ7pu5gvWQHrHsLt9Z5ZBAaiTDWZG96PZ+r2u4l2M36adI7Cs9fsi+L65ZIPV2CmWojdbV1wAaX7x/vW9K6p7nl6uJZHvVGFWYH0TyhNSDa6PBecNiq+TsbnKh71d7FE7a/tSXQje4pE/6qS0DS0ZN0/xYnkwO+pRl8mDfWOpuSYQjS41VMrPV5ZXc/i13g1cEiD1ClL3SjDFY679+9Fwd6WXIboHJkP0XoXxdXOXMUlfm+5fnvN7xLtOtEe5AVgY+/MiIAlF1O62vKw3Wh/wAdAgKz0lIJGFDWZrrG4d8qIgD4AvLG6DQPfqPK3HCtJy3my2m5E0OYFFFRrAqZ5CvcAfy2+LQy6ln2UlDi0RWPOTIKiapAz+CXTCDm1V5J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:56:04.8858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181668f2-3eb8-40e6-f2fb-08deabb1e3ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

On Wed, May 06, 2026 at 01:13:53PM -0700, Shameer Kolothum Thodi wrote:
> > -----Original Message-----
> > On Wed, May 06, 2026 at 06:16:00AM -0700, Shameer Kolothum Thodi wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Could this be a case:
> > > >  - Write the PROD_INDX/ CONS_INDX with a consistent value (0xf)
> > > >  - Program the VIRT_CMDQ_BASE
> > > >  - Read the PROD_INDX/CONS_INDX, expecting 0xf
> > > >  - Write the PROD_INDX/ CONS_INDX with 0x0
> > > >  - Program the VIRT_CMDQ_CONFIG to enable the CMDQ
> > >
> > > Yes, if Guest is not spec compliant then this can be any order.
> > >
> > > However,
> > >
> > > >  - Program the VIRT_CMDQ_BASE -- suppose we call setup_vcmdq()
> > 
> > > then kernel will reset PROD/CONS, right?
> > 
> > But I don't have an impression that QEMU only supports Guest to run
> > Linux...
> 
> Oh no, I was referring to host kernel behaviour on IOMMU_HW_QUEUE_ALLOC
> IOCTL. It seems to reset PROD/CONS to zero in that path and I thought
> it was following spec in that case.

Ah, it was fixing a kernel bug, where the VCMDQ registers never got
cleared even after a host reset (IIRC). And the solution is to clear
them before handing over to the guest.

Once QEMU allocates the hw_queue that ALLOC_MAPs it to the VINTF, it
should probably sync what the register caches were programmed by the
guest.

> This scenario writes PROD_INDX before BASE, which is explicitly
> non-spec-compliant — TRM p.175 "Enabling the Virtual CMDQ"
> mandates BASE as the first step, with PROD_INDX/CONS_INDX
> initialization following. For a spec-compliant guest, PROD_INDX
> is only written after BASE, at which point vintf_ptr() is
> valid and writes go directly to hardware with no discard
> involved.

I think the goal of VMM is that a guest VM cannot distinguish
between real HW and emulated HW. If we just follow the minimal
"spec compliant" flow, it fails to do so. So, "spec compliant"
itself doesn't make a lot of sense to me.

With that being said, if QEMU is okay with the minimal support
for "spec compliant" flow only, I certainly won't be against
submitting it (for the initial version maybe?).

> 2) But then after some prompt it says:
> 
> Looking at SMMUv3's register write handlers, QEMU doesn't enforce
> any programming order there either —   registers are written to cache
> unconditionally. CMDQV should follow the same convention. Will fix by
> replaying cached PROD_INDX/CONS_INDX values to hardware after
> alloc_hw_queue succeeds, making the pre-to-post-alloc transition
> transparent to the guest.

Yes. We are indeed missing a few details in the implementation.

> 3) But it changes position again if you ask in a different way:
> 
> SMMUv3 has no equivalent transition point where hardware takes over.
> In CMDQV, the BASE write is a fundamental transition — before it,
> there is no hardware queue; after it, hardware owns the registers.
> The BASE write is a fundamental transition point — before it, no
> hardware queue exists; after it, hardware owns the Page0 registers.
> Pre-alloc writes to PROD_INDX/CONS_INDX are undefined behavior by
> spec, and "discard" at transition is the   correct consequence.
> There's nothing to "preserve across" in the SMMUv3 case.

Ask it to do a deeper research before answer any question, or
to pinpoint where spec declares that "undefined behaviour" for
example.

> I think the spec is vague and doesn’t demand a strict order.
> So may be better to sync the registers after the alloc.

Agreed.

Nicolin

