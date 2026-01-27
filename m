Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91A5D1953D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 00:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkWZy-0007Xg-RI; Mon, 26 Jan 2026 19:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkWZq-0007Q0-7O; Mon, 26 Jan 2026 19:05:02 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkWZo-00064w-BI; Mon, 26 Jan 2026 19:05:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtB/Q1ojzm7nUf4n73I8m1GdPJOBLMeBd2Soo5hUWvV5xDrZqlAwRAfznOFmqKeAV6qLkIMoSsRASeJsjvmVroGnsve4CeUCpOAkzMj2MJ9+e8iWrypJblvdwqSDdZHPfE0IqZLyIYEEpPlnotNpojkC4UNwcHlbYBNqqhSoRckNjtsZkF30ntAtVMd+RWwcLB5Wtlwp4RvhpxtFFrPFWqr5yiL0d4iZ+x1dJez37pnoz0msKE3xSQ7G1FxPWe5A08roYqOLDPPbhvxOkD5HV3umg4Rh9RQ9aSRL9MjvQWQuE+ye/UtlXsLa3AAx2IibdcUcso0tqDwV6YZQ2YPTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/8NfJjB7xwvT7erKaP0DMJLg6C/Z8QWHeVNKIdwxhQ=;
 b=rKVHBNQ1ui2jN+uEWg228dMI7UCWFK82/9lkMds8/1D+4UqZentSLfAMvdw8tYhAvPJX2wN/rXx7Ny6g73LzeD8hSrapFxrx0dLYRDP/XEmk9fg+yqKHlVBQk483G+X/muVLkp/J0X1u1OaFAwaMgHABvbaLj+KSjpqPqwuLUyc/vpZaVlxjKCD6ue+A26bNDWxn9zdwY4KDYDM0eP+OkVYgDmD+cS6dZgCpCbJ1/s7q3Yr5Pb6SB0omxkBUR5jHKEJB24DtBAclUG92qeFxchBpw6csQmQWoGDEqMgAHqcSdKBLLtXxTpMf7ORu6oZB1owBcTRHk3anDHpL22d4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/8NfJjB7xwvT7erKaP0DMJLg6C/Z8QWHeVNKIdwxhQ=;
 b=YCXDcMjeNH4JmzLB7YMQtPOmmEN+UUl3DOo1eexs+iMJhiYG43s3rKEdGC+LcDPUoU2t9Glt900doWBSjPt4J1TmubmrQfd/FLyfg/K4O01jQ4z5V5R9a0EFOY8FeynzZccOSemAuqJEtm5P5ALi//TqgY0NfxOk8I05XagrlwWWQCyM959lgGz5hz0xHlwrWqbqcKeemjn/vWAjLrOAaAyqEy07ALyvttWWR8HxTBJ1GVW4vakdSR3cttI+RivqodqQNHewtmBmtFIKinP2bvOLMWCZ/M3dUvZxD2pXakEMfExNNBmAuWzEgYYLKm6IgEPH48rCU/IX402W4ckVqQ==
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 00:04:53 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::12) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 00:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 00:04:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 16:04:34 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 16:04:34 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 16:04:33 -0800
Date: Mon, 26 Jan 2026 16:04:31 -0800
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into
 guest
Message-ID: <aXgBD/N+aOVNlcGb@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-7-skolothumtho@nvidia.com>
 <58f0ca59-b08c-44cd-b469-f152271c14f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58f0ca59-b08c-44cd-b469-f152271c14f6@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f052a2-cec8-43fa-ecdb-08de5d37b2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?M+XULDAkgWk8fl0r8ndFNy2wzluEI7213Cs/RSSKZ0gEudxH7Yd/ZP7n21?=
 =?iso-8859-1?Q?zx8OH9qihYu8XeDqM3bD7mgf2rubItN2Ule8z2FSiX/kqai3QyavaLk3xD?=
 =?iso-8859-1?Q?edik4FzyZB+ZmbIbGPnNbOsEopIDvY2JGEmtCF65sF3tP1G3py/0grjZOu?=
 =?iso-8859-1?Q?MBojRnyZUYzskL+5aAkCWow7fQRh0RBWg+gCZFrJD0HGYSjY5iGE/++9n9?=
 =?iso-8859-1?Q?3bbGDVLZESC+0YcA6qWZRYsxJ/6zKt65TqLtZRKL5QXC00iSejXdBhymGW?=
 =?iso-8859-1?Q?gw9/5mvaLoap9ybDxf7WWgthKmZRfVXogKtNVopGYk0cwCnsuaMzsl2KLr?=
 =?iso-8859-1?Q?G0G8gCgu83yfC7d+rGUDFfL3Z2Qol8VtNkouZUK3JTO4pujtu9oUaFpZyW?=
 =?iso-8859-1?Q?RKM+rdVf67NWHCdzquXOvQu6oeRerMA56V1Qp4tsrirnMvjXBCxAvtgEPQ?=
 =?iso-8859-1?Q?+AKd9EtSgEPSSvaJxqBA2lcNHZlBGX4UxxkdX9p/gX/Jg7z3bmoCxNLzJv?=
 =?iso-8859-1?Q?/M+t4HTq+LiQMqLHy03FIO56LHSMPhr2g56a/Y2CY/NgokSIveEzkrv6Q+?=
 =?iso-8859-1?Q?lEwW8m9DcSeKzS6IfXjK0evtYPxs6hPvk7k0fMARpMsE/W+MwshDlF5TQQ?=
 =?iso-8859-1?Q?UMMGWS8yQo+iafhdP+j/VRtLi0rclUOx94pyRK0IbEZAY1PYhK5F4FwXTE?=
 =?iso-8859-1?Q?NXKrBrmsw5AhvZKBHiyRoaZinBRHQlTLWzCMWxabtpbV413w7wBPUOxkOF?=
 =?iso-8859-1?Q?Hd/2tAcXzOIKIpmoIW8MdP0JDhx2Zd/S7cNxSFFjL46UJrPPrFjPR/+DKS?=
 =?iso-8859-1?Q?F82CXmQ7vLJi72si6DBQXTfp65GS+P3LT8+yvfv+iurW9e7uU60+2BWHU8?=
 =?iso-8859-1?Q?pJqJ2TLc4RbBPmVRFoAY+ewqQZ+ounjbhPCEc3hsoIlN4LQbnNfLCgkhf0?=
 =?iso-8859-1?Q?Idfeqfprj5wR5DCClwy3FEvJ08k5sB6IX2CM/EN564VcleYRCTUtg37KYC?=
 =?iso-8859-1?Q?S7UUuiQeoUMUPK7/wcGp990M8gZ2L6d5izZOzoij06KqZKeIGecpmgIiqe?=
 =?iso-8859-1?Q?GiGgvtmyFbTQmx+ZVZ97Jbo6DZL/xCypIZsoP/PBSNxE527ysvpD9nZr0J?=
 =?iso-8859-1?Q?qr9bgRfyYOZpmEqEtMuXGcYvKKTb+czBs/FuLJr4kWOI+djX7eDXuapH6L?=
 =?iso-8859-1?Q?Inwp7tigIB8zrxOUHUPOJrriQrlUaBgb3ozVzzKqd8h/mpNJNo1yV4KU5F?=
 =?iso-8859-1?Q?kierVBZw2rBGOWXs8H9NP2plI1x39GeE/rdzIhEHHThUok2lF5LYMYeQZc?=
 =?iso-8859-1?Q?ipXruIJgxhfn/UoE1N7HSvf33PNQt9h34/k+keuBc15M5epL3txFYAd3yY?=
 =?iso-8859-1?Q?qprNTqe7mUQXuFGsHhPyi4pb24W9Ws++HzuVWiavp4t0aobTMMoBmwS/0p?=
 =?iso-8859-1?Q?5X6aObCytImiVKXdebAj8t2C/27uYh2CoRtKnXRK1QihXKApvvHOVpw5Eg?=
 =?iso-8859-1?Q?l2X6dpzx34qXumr5t7Graz7GZG1+DZLPu2nzJthQia09qNzDSLLf+RI3aa?=
 =?iso-8859-1?Q?0LDD7t3sD1lIJSb52O6Ey33wDNhprSEi8uiSvdkYZAmk+8dzSL5Bp5NjNP?=
 =?iso-8859-1?Q?zgPGheeUj4GeULk4DQUbJMPGtXIakqa2+OspxvFPgWc9DTi/wAWTSzrVx1?=
 =?iso-8859-1?Q?83qY2R6WuviazsiHfqHpihMSQRQZeFD1/yJZ4ahz9+Nn5zGdN0hBYyhBrx?=
 =?iso-8859-1?Q?GrSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 00:04:53.4890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f052a2-cec8-43fa-ecdb-08de5d37b2b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 26, 2026 at 02:48:55PM +0100, Eric Auger wrote:

> > +    name = g_strdup_printf("%s vcmdq", memory_region_name(&cmdqv->mmio_cmdqv));
> > +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vcmdq_page,
> > +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> > +                                      name, 0x10000, cmdqv->vcmdq_page0);
> > +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x10000,
> > +                                        &cmdqv->mmio_vcmdq_page, 1);
> > +    g_free(name);
> > +
> > +    name = g_strdup_printf("%s vintf", memory_region_name(&cmdqv->mmio_cmdqv));
> > +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page,
> > +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> > +                                      name, 0x10000, cmdqv->vcmdq_page0);

> I don't get why we need/have 2 RAM devices pointing to the same @ptr
> = cmdqv->vcmdq_page0. Is 0x10000 ~ VCMDQ_REG_PAGE_SIZE?

The first one is for "vcmdq" and the second one is for "vintf".
Explaining below...

> The names of the MRs are quite confusing: If my understanding is correct
> we have;
> 
> cmdqv->mmio_cmdqv (0x50000 sized) which as the container for the 2 subregions.
> Then within that one we have 2 subregions, one at offset 0x10000 (mmio_vcmdq_page
> ), one at offset 0x30000 (cmdqv->mmio_vintf_page).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c?h=v6.19-rc7#n19
It's defined in the kernel driver (yea, we should clarify in the
QEMU code as well).

So, the MMIO regions look like this:
 1st 64 KB page -- Global CMDQV registers
 2nd 64 KB page -- Global VCMDQ registers Page0 (mmap)
 3rd 64 KB page -- Global VCMDQ registers Page1 (trap)
 4th 64 KB page -- VINTF0 Logical VCMDQ registers Page0 (mmap)
 5th 64 KB page -- VINTF0 Logical VCMDQ registers Page1 (trap)

In real hardware, there will be 6th 64KB and beyond, for VINTF1
and others. But, we're omitting here in QEMU as only VINTF0 will
be supported -- kernel only exposes one VINTF per VM as well.
(Yes, we should clarify this too.)

> I have difficulties to link that with the commit message
> 
> "Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
> 64 KB pages:
>  - Page0: guest accessible control/status registers for all VCMDQs
>  - Page1:configuration registers  ../.."
> Those 2 pages, are they part of  mmio_vcmdq_page?

Not exactly. Both the global VCMDQ region and VINTF region have
their own pages (at 0x10000 and 0x30000).

Here, it duplicates the mapping to 0x10000 (Global VCMDQ page0)
and 0x30000 (VINTF0 page0) for simplification, because we only
support VINTF0 in this case.

There is a little catch in this implementation. The real physical
mapping between a global VCMDQ and a logical VCMDQ happens when
QEMU calls HW_QUEUE ioctl. So, the mmap'd page0 doesn't have any
real VCMDQ backing up the emulated VCMDQ. So, perhaps QEMU should
trap the page0 and delay the memory_region_init_ram_device_ptr()
until the HW_QUEUE ioctl is done?

There might be also a corner case: when the kernel exposes two
physical VCMDQs, but the guest OS only uses one, i.e. QEMU only
allocates one HW_QUEUE for VCMDQ0 but doesn't allocate VCMDQ1.
In such a case, the VTINF0 page0 should be able to control the
logical VCMDQ0 only, while the global page0 should control both.

We are getting away this corner case with any guest OS running
Linux kernel because it only accesses VTINF pages. But likely we
should do something about it..

> Then you talk about 0x30000 :VINTF register I guess this is the second cmdqv->mmio_vintf_page
> 
> Well I am confused at this stage of the reading.
> 
> Also without any spec, this is difficult to understand. Is there any public doc?

It seems that Red Hat can get the doc under NDA..

Thanks
Nicolin

