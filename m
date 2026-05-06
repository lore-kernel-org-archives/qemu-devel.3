Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76729CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgq9-0005hM-Jo; Wed, 06 May 2026 14:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKgq4-0005gr-GB; Wed, 06 May 2026 14:19:16 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKgq1-0006M4-KZ; Wed, 06 May 2026 14:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVmZYyyMwU7H74rdeBhrxCCT1OQIkSks/dUtDrqcO8IQw+dU+Aa9a8uv2EyGZMyVjaoEDBNGeEprxAppwIeS2oQOrzZxSZ1FwfXYFtfr1HQ/XVVV80SBbfDxEfsToRFx6/f/A1Difey6UR7eP5g+T8nyQdV5l07MOGuYjkt8vSOr/MTtoI1JzQZWEWx1yNvq4R6+d4OWW99TvwzPqwB2Be9OD0LQHy1EEJBjNflwPP/yWVk4/kLsm8jvpVzx07f0ZOzFoszb4RGZ5+Pr+QEzbODMV+QKI8a/HZQlqvbomApEPbEaodgBd+F6hXJFY7ebrvpdwBNlGZh4TBDjhhj6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZMGJRkA8ugh4yZY45xoLlftyxFYk8Bf0cvxp9Ezi1s=;
 b=kbMgle/B6uT96tziHtOKlA8qeQnQ8WJJ9hfy+PLahhbQyVv3nl/yj0UEZl0MQbZlqArXIDrgb8xS7h4+CetvQiERVlUIVFoVuYRiLe+5GxttmyczWXaE4MCN8KR4u3KkyZA+lUMQn3tA9PZREEhhCjGNvBn70qi4v324DleKYQ7vn5EmfSQpPWKgkIXk5cfpTLnIQ5B+ekG3Ajc+Y5sSYw+ASKL3SerImRKCsg/rNINPUqGCgTD4DVBVWKysuocFenvWCsSgtMQwkDxFvRbslaClDXLe+7fw78n13fSpuKtQpK60gXuyCOmMKoHZb2CXpxhcDreAKlpuYBDZTrd8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZMGJRkA8ugh4yZY45xoLlftyxFYk8Bf0cvxp9Ezi1s=;
 b=b5f6fpcObVFQDmmA7/VGE6E3N1SdoXl7jauS1Hrk//AALuIfMcnJnYkIZgvlRB+BTlponTv1K0mkfS7Myb+OKPponoXJRUxrr2le20l6YFVbc/7sThOwnbNjH7VOdsCC5eZ36PzF9BnxgpoO893bq/oEZzbb0d4QtczNbslRDb2N8tYqb7eHat5nKK3iRuJDDDVYi2r4bO7gDicWqDDp3p9jeexBf8YZRJKLVFILE2noFY2gkk/rswJVT11rSklvI7LIqfFaRSpZjPCV0r71Quvwe+fjHZxxB32etPj/Ha55Cy531Kij2bB1g9s0nHEaipkml2ScwCkgUueGXOgF/A==
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 18:19:06 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e5) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 18:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 18:19:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 11:18:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 11:18:41 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 11:18:38 -0700
Date: Wed, 6 May 2026 11:18:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Message-ID: <afuF+sJtEApWisp+@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
 <afk8f6BNAN2J/9f2@nvidia.com>
 <CH3PR12MB7548E9681835CC2A31ACED1BAB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afpHGPsdG5F3xLlX@nvidia.com>
 <CH3PR12MB75489F58CFA97FBBFCA9776BAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75489F58CFA97FBBFCA9776BAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5b0e85-4d6b-4085-f1c7-08deab9bf4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UoWB/kTl22FwlCli7ryfRRgOeGMR6jtkC/Fz8TXNgPBGSgp8guJG68uTlrT57svxr99VgKQaehgSIHwFXDTJzdWUtJ922wbn56CUAWxl5AjUYjwCU3qPQ+jrJZRd00FlfEc65DLhtfygx1l7aTGdzTDiBSw+q265W6zq5Ogzt0RSbOEkBpJD31u3VjvVRmTUMFWMDT1Tgs2yXRc6bMHlK1AuQOB3/MNMgh5NXF1UUngg/22yGLlkUvSPtS8QpeAHbZxV7CZLHga3Nh1+HDjt4xTy5VPBsEBDRIh+6Fha/46L01Xmmd5OrtIE9vobkA3bGn6DQj+Q3kPKCayVzldsKiSSBouR/FYkB3ICnXcQEMYk5k9KBpfrDj3phCqmcvy7vB88ncMt7qnVEELtFaOHJ/SAekXuxDMzeFPsIHv7zkieSPcznue1PRzUZn6cJAyfJOwfR29nfkbIyZMkx+O2WBFws0/BOT4Jy6GeCTZLz6AJtkuGK7FR3NGTlF4YAy/pLzMGV2oZEOc3JR2jYCFE3/mRbP+BYotGsbi46Fj7wMbCuSYJfdV3zjPC8UxNCl2Zq7FAVJ2M3npb74fBDzCI3If/9X+corFnhUwPsutBLbIzf4p1VMwRQHdQPogFUP5/Opco0Fqo2HVN2fSFFnAqY4N/nrUPB7sowNVYGgli3dh/bk2KJr8R2RTTyHzIZQd22r+dLd0tAnZe6HbmjfdSoUbT/359JFxZ0rg3tOUlrJM=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bibh6olCPy++nQv1uZvNVoA+dXlkfBv5N9lbpnauMydv1cyoh5NFMAFr2+N0ySa/bwLEVtIQwJAZGtmr1pgWuhmxPlENfpVxiaXexo8B/ClIAbzJMx5pJZ/B/Z8zdS05CMlQCC0eoU0j98igYAacugaD0bBamJC+3LHSn8pX2a+/V5d8UJmmyqebTAGPm9D4Woq3iP9LxUVRkNECR+QfAJcxqtgWksapD3UfYZmdZIITiA6sWQXRN5cBt8WFRdvJDyOTj8gJzxBXa5ObP0xr30EUG31EFBKj2Qs5UKv6Cx6TLCD9SIdjgnOlRowsr+yLrPjwn5QonGvoYKxcz8iV7AbNult6PWV0GhB4skBoPVZ3z8es3uU3zpmEs5tdPyswj/CMLswGOLqzzW8wdMJGA2VXYYM3FTDdKcLiFniFgdIkNAtR1hC5pI0i1HW8jny7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 18:19:04.8289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5b0e85-4d6b-4085-f1c7-08deab9bf4cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Wed, May 06, 2026 at 01:18:58AM -0700, Shameer Kolothum Thodi wrote:
> > > Not sure I get that completely.
> > >
> > > Spec(p. 176) has:
> > >
> > > "While the software can program the Virtual CMDQ(s) directly using the
> > > direct VCMDQ aperture (and not through the Virtual Interface), it is
> > > required that the VCMDQ be allocated to a Virtual Interface before it
> > > is used to send commands to the SMMU."
> > >
> > > The spec only restricts sending commands before allocation, not
> > > programming BASE. In our model, the BASE write itself triggers
> > > alloc_hw_queue so there's nothing to fence there.
> > 
> > Our model has an assumption that guest would map a VCMDQ to the
> > VINTF0 first before doing any meaningful programming.
> 
> Yes. And I think by "map" here, you mean the writing to the _ALLOC_MAP
> register. If so, yes, we don't check that.

Yea, map == ALLOC_MAP.

> > My concern here is about the access to the direct/global VCMDQ MMIO
> > space (0x10000 and 0x20000).
> > 
> > So, if this concern is a real case, should we:
> >  1. If the guest maps the VCMDQ to VINTF0 before it writes BASE,
> >     call setup() to allocate hw_queue as our model expects.
> >  2. If the guest writes BASE before it maps VCMDQ to VINTF0, we
> >     need to fence against it.
> > ?
> > 
> > One more thing to check for case (2): after the guest programmed
> > BASE and then maps it to VINTF0, and it never writes BASE again,
> > should we call setup() at map?
> 
> That is a non-spec compliant behaviour I guess:.
> 
> In p.176: "Allocate a VCMDQ to the Virtual Interface", this is
> the order:
> 
> -Program the CMDQV_CMDQ_ALLOC_MAP_X to map CMDQ X to the
>  Logical CMDQ (L) on Virtual Interface (V). Logical CMDQ allocated in the
>  Guest must be in order starting from 0.
> -CMDQ is allocated to be used by the software. Guest can now program
>   the VCMDQ to use it   as described in the "Enabling the Virtual CMDQ"
>   section.
> 
> "Enabling the Virtual CMDQ" (p.175) is where BASE is programmed. So the
> spec explicitly places ALLOC_MAP before BASE.
> 
> Should we support a non-spec compliant Guest is another question.
> IMHO, supporting non-compliant behaviour adds complexity with
> no real benefit.

I read that as a spec recommendation (IOW, a SW guidance) not an
ordering enforcement (IOW, not a HW contract).

The real restriction for BASE registers is, per spec:
    Should be programmed before CMDQEN == 1
and HW behaviour for breaking this restriction is:
    Ignore Writes to the register when the CMDQEN == 1

My reading is that, so long as SW follows this minimal rule, it
can do whatever it wants.

(Btw, seems we haven't applies this restriction into our code?)

The point is about how we are going to simulate the HW. If real
HW allows this (maybe worth hacking the driver to confirm this),
there seems to be no reason for us not to support that?

Nicolin

