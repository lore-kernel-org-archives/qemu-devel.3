Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7503CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUTm8-00039d-UT; Tue, 02 Jun 2026 14:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wUTll-00037H-7i; Tue, 02 Jun 2026 14:23:18 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wUTlj-0002xB-Ez; Tue, 02 Jun 2026 14:23:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/yw+JnsNF1D26KnCXeKD9UrhqP8rNF9SOR8cfcBTngZtEgfoE69uZG9gvLxrB2GET55a7jAEKvNNLi83lybBb3817uoy9bTfxZ55mAXn3JOeirraTBr6cxcYrzwBoURtrx2yHiF+u2hNJzkl3G+khKZM8Tjudx4bEFwImerNTuAQa0Z/syDg92d2TRjBPtP78Q5xpkj26XzP5Bqu/iFxEI+g+qY+6m5urI1bhksRSPA4uH5/0EGBShhXaCWmdhjGRJ4ryRg9Xzw6ZyjDqIEmDa1H8R5TZzj9yb0vlD1zLQ6orKNP0La07EhDGu9iOpLS4PIQ1PobmmoxfBUTt7hAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgHIwPGB+Azb50CTSIzGAtVmhuohvj1Q4rMLpt4qQVQ=;
 b=fUqMRDA0j/IGpvhgWlGikPyMmCmEI/1zHgjmR8XhAbRwT9p4xumoKFEG3eqMlMPmWpWaLGiXvG4eQybZ9rNN7Ju3S6gyLYHWoVY7W6sIkXNiRudOhCNOqJct/k9mwc5jdUBrrqM9p4Bt4s07ZfrBAZD7nUZFNwhUVbLvfBsKX4uXX4tp18B6UlG/6OejO87gcXvwrFF2tyT0MsdVkqXEKV2FXG8nXh2CLhky6EnAVyHJU1YqYUMCXNgM2sGKwK83lzsbrNAfNqIzguOxplDzTCGr6kJ1DILnK+aT3MkHB2BwZlP6U4eRg92cauFgTIWuXuWxi4Z9e96v8wDMF4ykBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgHIwPGB+Azb50CTSIzGAtVmhuohvj1Q4rMLpt4qQVQ=;
 b=KPBl7LLacJJbqbf4pPUGhGoMxHVdXGa2+b1lyuZlCECQ0Ghq0r4YQEtVqx4RQTrjWNhRneYa9EkP/jfok8q1aFGt2fa2yg5rP5VilzDjW3wZ2znXjDye5PjgiizClJPSOWxMz04bK6o7ghdIKOWtotD7nhsWw/K0YA6jngWK3KQIMDAb9KPLmp8aOxEoLrGqlYdNJtzQRdEac9dLmJFngu4WsQVyGt8rgOhEeNZ9gTOr7xlTPI8Ly11oATXqzf1Q3ZDPh4pwK16Q43WWeJ4FoNMNoLunUtCLGbV07IlRaE3jrP/oHgRVVh0GiN3yiDuEqTeq71IWB/U5TbNSkHRzqg==
Received: from SJ0PR03CA0150.namprd03.prod.outlook.com (2603:10b6:a03:33c::35)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 18:22:57 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::96) by SJ0PR03CA0150.outlook.office365.com
 (2603:10b6:a03:33c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 18:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 18:22:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 11:22:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 11:22:34 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Jun 2026 11:22:33 -0700
Date: Tue, 2 Jun 2026 11:22:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v6 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV
 design and lifecycle
Message-ID: <ah8fZ+M/rQFBzK18@Asurada-Nvidia>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-31-skolothumtho@nvidia.com>
 <ah4aAZR29tw5/pV5@Asurada-Nvidia>
 <IA0PR12MB7555F3EB9CDFD9B063CD5B73AB122@IA0PR12MB7555.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA0PR12MB7555F3EB9CDFD9B063CD5B73AB122@IA0PR12MB7555.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d58a00-f222-4d42-158e-08dec0d3f87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: qgMIYhkNGj/z8cAEULGrHpd2HzCZGCSDdj6L9xYDO/OoV/xyaS44eW1/CsZKQpjhyWKtnxY+iE1r3E2B8en3qnKLdRlkBzR27OgqBZiO04UEt9cFeVv7CFyeAliVM+cpr8yZKTYVq3EYihHXySOL8l3ImRYnKBFo697uDtnZF4TT/NmKDE6RXzNX7c4Mo9cLvi4/vcwtXs3YCZtnb1VHWPr16mqeqohCvaeZMQ2oZORuGRcCdHAg+IHzVW08Wuoc2SjPdRfgYCufjn47+sbFBYvjLE0WyOOm7LbuLpBfWN38Ni7p1I3wGuzIzBvUwJFvzLMj+51Dhs5PdBWwQIfN7gyPfdKe3CDwpXYqXFCi6Vl+UuOg8dkCOntgXmZ0AIzc+eEA1LfQLkm0gG12yrKrVqNPBfqDcqI0YL9C/Q3osYpypGIl94U9olMyAgaP7W/4gRezk9LKJZ7kljlNF8BzM00Z8k7gZUklx1I5xpwEfY603dq6N0rRMCZP5luSM6xLNBE8F7eeW96R/LzQ7/8GyN6wywDzXvf1sJCw+YLKmxvrXsWXhcdWKHTUhqfi4iULRIBpilhivaiJKOfClTmxlaGNlQhvOVaodp+7qLLBHxOXSYWAH55Qhoi7bkbuJldf1lK1KHgYDfhOaG7dkesXkv4EcdQGWIS3bfHUsEgK5QRNXRZdC56W3kaOPHI9L8x/FMbTeE4oGUTA8NkFen1PC2dS3K6OoZdMaU0iYE8kUbo=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z1sCPCTYDrIN1nE3WHFrAAIsYjFislPL+7si0YlAZss6vo6NgKZbD+iYerq5cfTiZ8XEVtTAGcnCV2jhb8yv2t4weGDkfLZlla8MGn75idElnnsnkUZqR++lpbi28WZF0oupFlOy6sN37+Rm12unkqrXUqOpRW/xNPBtheFUQ+pF2YKdsaTnxG9hL7XrJ6AlDfjwziVf20usNAb9V/N5LdUqvUVL1qYKwWt8HKtN3k6ESfSxvx+pCWVNgDmxRORmbleaaXcux8sV3uH+lRWYFU7FnmIStvHIJpZ+3l3N9Qzferexil3MuY0xUGfF88ttsc0ofEmgljt+o8UDlTO355JMIabDIk9s0ZM3bxv6xmKmWXHoAUbTmuAwtPf1RIYMPigxWClexQrkhkZydcvEt54oVIA6mHmKcqPNv2d2sFXXu9B6iY+tstIHtg/tuDkT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:22:57.1369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d58a00-f222-4d42-158e-08dec0d3f87b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nicolinc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 02, 2026 at 02:40:07AM -0700, Shameer Kolothum Thodi wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > > + * 2. Guest writes VINTF_CONFIG.ENABLE = 1:
> > > + *    QEMU mmap()s the offset from step 1 into its address space and
> > reports
> > > + *    STATUS.ENABLE_OK = 1. The host VINTF was already enabled by
> > > + *    IOMMU_VIOMMU_ALLOC; QEMU only acks back.
> > 
> > I wonder this mmap should be done after the
> > CMDQV_CONFIG.CMDQV_EN=1
> > rather than VINTF_CONFIG.ENABLE=1.
> > 
> > Spec says that:
> >  "Program the CMDQV_CMDQ_ALLOC_MAP_X register(s) to map the Virtual
> >   CMDQ(s) to the logical CMDQs on Virtual Interface following the
> >   CMDQ allocation rules. This again is an optional step and the CMDQ
> >   allocation can be done after the Virtual Interface is initialized."
> > 
> > This means the LVCMDQ mapping can happen before
> > VINTF_CONFIG.ENABLE=1.
> > 
> > And the mmap info is returned with IOMMU_VIOMMU_ALLOC. So, this is
> > doable?
> 
> I think it is. We could in theory as well do it just after IOMMU_VIOMMU_ALLOC.
> What you think?

Yea. That sounds right to me.

> > > + * 5. Guest SMMU driver programs a Stream Table Entry for a passthrough
> > > + *    device: IOMMU_VDEVICE_ALLOC programs SID_MATCH/SID_REPLACE
> > in this
> > 
> > Ideally, the VDEVICE_ALLOC should happen right after the device gets
> > plugged *and* its vSID is available; similarly the vdevice should be
> > only freed when the device gets unplugged. So, its lifecycle should
> > stay with the plugged state.
> > 
> > We do VDEVICE_ALLOC when guest programming STE is because that's the
> > only place we found in the existing functions. We could (or arguably
> > maybe we should) find a better place to allocate VDEVICE. E.g., vfio
> > code can call qemu_add_vm_change_state_handler_prio() to register a
> > callback function, where vSID (vBDF) should be available once the VM
> > start to be "running".
> > 
> > I think your narrative fits the current design. But we might need to
> > be more accurate here, since this is about "lifecycle".
> 
> Yes, the above is based on the current design. I will add a caveat to
> cover that. 
> 
> I remember discussions about use cases(CCA realm ?) requiring an early
> mandatory VDEVICE_ALLOC before guest boot. Regarding the suggestion
> to use qemu_add_vm_change_state_handler_prio(), it might help,
> but I'm not sure it covers all the cases like, hotplug, guest PCI
> re-enumeration during boot, etc. (Having _DSM #5 might help here,
> but per the PCI Firmware Spec it only "indicates to an operating
> system that it should preserve assignments of PCI bus numbers",
> so, guests are not strictly required to honour it.) Anyway, I'll take
> another look as a follow up.

Yea. I am not giving a suggestion that would work perfectly here.
I think we are good with what we implemented for now. REALM stuff
will need to take another look.

Nicolin

