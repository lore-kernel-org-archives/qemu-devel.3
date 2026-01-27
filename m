Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67873D2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkosb-0007JQ-Vt; Tue, 27 Jan 2026 14:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkosN-0007Fj-2j; Tue, 27 Jan 2026 14:37:23 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkosL-0001WV-94; Tue, 27 Jan 2026 14:37:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwmeNfn89t+2mdysISd/9tBDdS/meuayIt8zW8CtpdAHQQX3yW5pt6oWGkjjop7o/zSx/oaxkCKYybVWiU0l9O9GKdoaQZaeR3wNCaAdHJchO/hhhOcx8itrUC+Wbh53tmu/z30DWkEuEEziJ+pJPURMj/95ULvmLxzXcYAoNEZIxdq9GWJB1PivyiNqtNkslbAhxdxPs2TRjWdjUA0ISleUIbxCvhPosJW18WlP83ClAmaRl95Ugd6t70Fjbwv7enQ5/+cGViICqe9jzxgCeL4STWmgDWRJtzIZsyvKF7mxT3oZceS6YaxjGALbtvWo989+S+JEw4HBlldLNrAiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB7sqO5sXH687RhAEb1CpBzqn5DCgGFuC5qk6p4wq6c=;
 b=Kn5oK9X6KWClWRgkCBvWp+sYggC8cth7QX9GnbRTSwUl4sZwHfAeK7hgth8rVcrUb8GDwxkyTbaokgM3aIQ1ukoV3sQ/pmaeV7Ec+UGg3lz1UeLDXoBMHlsGaLLcqWYn9pWY55h6Cevk5ky2MnywnciABDEcmGPKV4I0baAwYgazJp2UuKLjsaYVsbAK09w/ZY3SXX4fHd9XTJu229/WaaHQ5NtcUX/81AmHvXaFHjW8Yj05qtpy29/5ACLMBeFr5sKTGXh34EAa/ZZo9nv9HYOjv5VOdaJq6nagIcmbNaPq10WCFN/HE9+d+AN+bAGtbZmEgMoYBplsSM4Ct7qFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GB7sqO5sXH687RhAEb1CpBzqn5DCgGFuC5qk6p4wq6c=;
 b=KJ3LvufTjnZHSyU1n/AL2Tun5MHpfPBmmU4tgJGD6ivT0KrdLWLzj2d2eAm2fG0Mlm3zOGSEtXqkTSaLB8gbYgVYirILwAt+pYPEVXCYVLzmU9lAgjltH4KCMDnw84zmmDD0GQbGXIcVnZgs1faip2xs/AOUlkPVjKClNJXdgPkIijz+tgv99lE0ZWrbsfdlDUo0QU5A1BDFWIrSd/Kl1UchGp+AtlJM7md7PjiZ9HbtRJ2X/F0yp7Hgbv2kCooqryH2yij9FG9tM1jsqrX3dgBcDqXvr2kFa+NK13Iegwe6m1bBSTxA17MfEbr+hLmQ0n8MRUVPk8GCHcsKaKcENg==
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:37:10 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::db) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 27 Jan 2026 19:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 19:37:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 11:36:47 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 27 Jan 2026 11:36:47 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 11:36:46 -0800
Date: Tue, 27 Jan 2026 11:36:45 -0800
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into
 guest
Message-ID: <aXkTzRM695oTWFaD@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-7-skolothumtho@nvidia.com>
 <58f0ca59-b08c-44cd-b469-f152271c14f6@redhat.com>
 <aXgBD/N+aOVNlcGb@Asurada-Nvidia>
 <26e22c1c-09bc-4e6e-9859-bc8092b8ca7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26e22c1c-09bc-4e6e-9859-bc8092b8ca7a@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff195e8-a8a8-490a-6a47-08de5ddb7546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JBHLPju0pH10pjbNXRuDEa6HQBw7FZgWNrH75zW1ATlrDQcVZlllgzOUVd?=
 =?iso-8859-1?Q?FhzftFlYQQcIHUIbY0g3seznBOwYaLsrT5+IBXMjaNa3nY6RO6nPEdwIFV?=
 =?iso-8859-1?Q?OEskmT+/IHYCiAWd9ogpRYfSZG74rGHhl5TUX7ygVN8PsLBRNPXTSIKYa4?=
 =?iso-8859-1?Q?RPD6Il2ookUFFdJqeO9bIrWT2xErwf67AL0+ZirwFZMlq4vmO645+j8HAf?=
 =?iso-8859-1?Q?wIi5/Xq5haIZ9aGSfEn8xMDmiU8jZMrhuehyErJA6LbENJaPWrybjNvtfz?=
 =?iso-8859-1?Q?ggiiYXEJ9A80PqAyMyumenyeUvKA1AuvdW2RlDRZTEoLZCrb6F+V6cKTy4?=
 =?iso-8859-1?Q?6MgJFoqTtAOCIJEwIxKfv6ysuSt8al5FL4hFyQLf70v/FnbjOiEpNJcmd+?=
 =?iso-8859-1?Q?D33MfKdc4l0xUoWZVvgtvC6CNrtnFkxrSnjnFmZdn7FC9aimTrBphZbyHH?=
 =?iso-8859-1?Q?gBGggv98Gl1qq8iXJJGs4PXipFdgJdXS/AzBwL4XQmIDf/mZlG/uA3bqe+?=
 =?iso-8859-1?Q?9MdF/znFsEJSegpRm57yyi76SB9lkH0G+Rdh68fvrSY9fkbe92zuTKE4l7?=
 =?iso-8859-1?Q?MihZv4zBuMt8CwKo+SvwF0SqmoJkdBRdP1JM4qVf7tPnhx+HIk3keK/+tk?=
 =?iso-8859-1?Q?3P8jnS0Og9I26bErj+ZWPQkYr9oPCa21KwqN4YwRKaXFcRNrfq5LhUkhnK?=
 =?iso-8859-1?Q?E+TUVCuis1h/o3NCy+kF6EWiyCtjOMD8me4xgvhH4DTZfKb/IeVkz+mPCk?=
 =?iso-8859-1?Q?N2WcnX7Bu2STX93ESz0vsfsXLI3erW9VsUHsxti/b9BiR0SLKGkMxbz3mV?=
 =?iso-8859-1?Q?rX7oPj5MBXIm0NlmtHIhKbEuw+bIH17vq2l2/tmpGWO3XNT/+gUQnQoy+I?=
 =?iso-8859-1?Q?iQXUuetqV/81WtU6Bf6yI4oy7iIfA8h5qr7rK8xSKjpEfFqNP4qf6UbN0+?=
 =?iso-8859-1?Q?Y/uZdObuv/Rbib8alELHC233j/a2ZzyKezMGU53Sz3GUBsUxTOHXkEHMsc?=
 =?iso-8859-1?Q?hc8rS4tSYQ2yXCUtxnRWSPD8R/Uzv/E+xbhDZ2HLW51Lsb+HGyuARzoz7m?=
 =?iso-8859-1?Q?PKllHrRgm8l9jX+eof870/wjBdsxwK+75+rEi7zuQSr9qrifzS1VmLeSKY?=
 =?iso-8859-1?Q?aNZITtd6AcwRtKDB3g4V4/hPGM7i8bwKumA+I9swLC5edDYAxOtrOQMkJ4?=
 =?iso-8859-1?Q?GhRRJn4prgKzu9VKlTOvJVP407M2pnwtrZ7xv1oc/lZD5Wf9I3ILFMs3Dv?=
 =?iso-8859-1?Q?niPMC55axNXbczwvHyItIbaAcGZHg5KRs12mq5wAnK7v1hyCUShogxSi09?=
 =?iso-8859-1?Q?PDUHqfb+8G+iyurdrj5jmlNsBe4RCuefGriopEe2elFQdMwGbEU9X5OhIW?=
 =?iso-8859-1?Q?/x6tJ8RoHJ6k0rANRkUjnSJDGuiZaIZJB1lFwOgHt18zDmTbYGaae/2Q2a?=
 =?iso-8859-1?Q?g3irQhJzq+1D3ODQy4va35MhUx0+rvC8QfMgtjyCmTLqBcWOATnUXCU9Hb?=
 =?iso-8859-1?Q?fNmYf+FqG7iQDX7KFhBQOz4tPnDr+0hIgJB8Exi84jL3S90cL27NJiC4a2?=
 =?iso-8859-1?Q?9ssIWLKhJHc5O4JF3mdiZ6PWi5KYob8e7Io1CgAhBGaINySLmUGBUdXAW+?=
 =?iso-8859-1?Q?CtxOtIjreqF5bGKHSlYnhnTN8CQuGT6EaiGcqq9Zs80q7bW4vVugTv/dvE?=
 =?iso-8859-1?Q?9kQe+A3YtmlNOVtGmnMR/uORqX+oULsxAyG3XC/HpGkdV+04bdB+FYUoIv?=
 =?iso-8859-1?Q?/hXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:37:07.9011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff195e8-a8a8-490a-6a47-08de5ddb7546
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.399, SPF_HELO_NONE=0.001,
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 27, 2026 at 02:23:33PM +0100, Eric Auger wrote:
> On 1/27/26 1:04 AM, Nicolin Chen wrote:
> > On Mon, Jan 26, 2026 at 02:48:55PM +0100, Eric Auger wrote:
> > So, the MMIO regions look like this:
> >  1st 64 KB page -- Global CMDQV registers
> >  2nd 64 KB page -- Global VCMDQ registers Page0 (mmap)
> >  3rd 64 KB page -- Global VCMDQ registers Page1 (trap)
> >  4th 64 KB page -- VINTF0 Logical VCMDQ registers Page0 (mmap)
> >  5th 64 KB page -- VINTF0 Logical VCMDQ registers Page1 (trap)
[...]
> >> I have difficulties to link that with the commit message
> >>
> >> "Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
> >> 64 KB pages:
> >>  - Page0: guest accessible control/status registers for all VCMDQs
> >>  - Page1:configuration registers  ../.."
> >> Those 2 pages, are they part of  mmio_vcmdq_page?
> > Not exactly. Both the global VCMDQ region and VINTF region have
> > their own pages (at 0x10000 and 0x30000).
> >
> > Here, it duplicates the mapping to 0x10000 (Global VCMDQ page0)
> > and 0x30000 (VINTF0 page0) for simplification, because we only
> > support VINTF0 in this case.

> so Global VCMDQ registers Page0 and VINTF0 Logical VCMDQ registers Page0
> are basically the same?

Not exactly the same.

The global page0 is programmable at any time so long as CMDQV_EN
is enabled.

The logical page0 is programmable only when SW allocates and maps
global vcmdq(s) to a VINTF. "logical" also means "local" to that
VINTF.

> I would recommend to use cmdqv->mmio_vcmdq_page0 and
> cmdqv->mmio_vintf_page0 to avoid any misunderstanding

Yea, that makes sense to me.

> > There is a little catch in this implementation. The real physical
> > mapping between a global VCMDQ and a logical VCMDQ happens when
> > QEMU calls HW_QUEUE ioctl. So, the mmap'd page0 doesn't have any
> > real VCMDQ backing up the emulated VCMDQ. So, perhaps QEMU should
> > trap the page0 and delay the memory_region_init_ram_device_ptr()
> > until the HW_QUEUE ioctl is done?
> might be safer indeed.
> >
> > There might be also a corner case: when the kernel exposes two
> > physical VCMDQs, but the guest OS only uses one, i.e. QEMU only
> > allocates one HW_QUEUE for VCMDQ0 but doesn't allocate VCMDQ1.
> > In such a case, the VTINF0 page0 should be able to control the
> > logical VCMDQ0 only, while the global page0 should control both.
> 
> you lost me. Need to look at the kernel or spec ;-)

That was for supporting a partial local vcmdq mapping with QEMU,
as guest OS is allowed to do so from HW simulation perspective.

E.g.

A VTINF exposed by the kernel supports maximum 2 VCMDQs. IOW, VM
owns 2 global vcmdqs. And mmio_vcmdq_page0 is supposed to have the
access to both vcmdqs.

Kernel only exposes physical VINTF's page0 via mmap, for security
reason, which starts with 0 logical vcmdq, i.e. no access to any
global vcmdq via mmio_vcmdq_page0 or mmio_vintf_page0.

A guest SW only allocates and maps one global vcmdq to the VINTF,
which means only one HW_QUEUE ioctl is invoked so that the kernel
only maps one global vcmdq accordingly. Then, both page0 only has
the access to one global vcmdq via its logical mapping.

In such a case, memory_region_init_ram_device_ptr() to 0x10000
for mmio_vcmdq_page0 is basically wrong, since it's supposed to
have access to both global vcmdqs.

So, this makes things uneasy to support.

What we could likely do:
  - only mmap mmio_vintf_page0 to 0x30000 (logical page0)
  - drop mmio_vcmdq_page0 and trap 0x10000 (global page0)
    a) if vcmdq is indexed to a mapped global vcmdq, read/write
       mmio_vintf_page0.
    b) if vcmdq is indexed to an unmapped global vcmdq, read/write
       the value in the register array cached by QEMU.

This would likely slow down the perf if guest OS is using a LVCMDQ
via the global page0. But functional wise it should be okay.

Nicolin

