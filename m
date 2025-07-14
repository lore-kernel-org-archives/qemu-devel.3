Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E029C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRTc-0000gz-6K; Mon, 14 Jul 2025 18:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPhq-0001R4-Md; Mon, 14 Jul 2025 16:23:23 -0400
Received: from mail-mw2nam04on20623.outbound.protection.outlook.com
 ([2a01:111:f403:240a::623]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPhn-0002Ph-Do; Mon, 14 Jul 2025 16:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqXy5MGxK/pkMZBDqQ96s0/BFJBY+iZKXGENI//AmS/IoASbHc5D+7+Wgzf1W4BI+TpEhs5WBCUgVuyJdl94E9s6KR5qWI7E//uNMQxEbSBsnaWqd7VBk6SSjZHA4j2/H2sW2uSRyxyv6a3LFhQlIlxoxBePixBuhxW5SP5nNUHSiSNIbbQWd8dZwl5IG2EqyiPxA3W19aLmL2kGf2nHQ/1pm+uFfoVhvrb1mNjbz5LStRwfF7yiiDbuWMn/WSp/BPmgQk3TsU3R6IMIVxVktdQleNo+uYBOGoTnT4OUb4M7rA3lcBSoA3pe1dNsw0fYbQsKY70zBK5QXjnOL51Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsrhZojGbDPxJt58NSnpD3A3jXxteIEjgrcN22XR+6o=;
 b=rDBTehYtvgqsZ8xuUGNgEmRZBbtfb0Ggosmco3qmRi3VmrQVcLWbNy92qhIKGKUqbbnYfLQcP7LxyCAcKkHsF4kyOodWnWmiRptjFZnJ+Dh+ym5yMIrRL6w0CNok8SUpg4X7ajk97rc0DzvHzBC4Im4ANrKRCVA32HTm9mFHoKlOurBIoN3h7XKT8BGi6iY9O6iT0kv9FfNVWM8SFtywNjjdGbAm1XJV4V0jhvXtoGlM194QwlmBswUOXQmDL0aYyQlPkCjUoi6BCjO6n9scw0KHzbZCgFLpPOxiIuaU8bQPFTeikrSH2naj0OOFt7bg1DbJBtrwmq4oSKHwbsWbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsrhZojGbDPxJt58NSnpD3A3jXxteIEjgrcN22XR+6o=;
 b=tHVeEqxOlxSSKKxCgT29qeciywe6l0VW/CPg1Bwr0sbp2hfT0E0edMgzgFkyTZQf1Ef3+21g/cRWaCHIWtLnUts6ZOK3wCyR1volAaQsfGi9KK3PDYZLC00C35UTLfM0e3WEGu7NAd3SL0QMI8B6gR3IiqPY0EKe3KDJGtZkDBqbZP43vusDuHejyxGTihQmdEILrNpVeIWFrSAH0Ds2rHZE4rMwUGSa8AEBKTGMjXfblSKLuoj70xpq68m8GVaPJoVhfbCYj6NL2eifYa+l6faRJ1qSo02RNvWTemWJd0m5NM3Pgp4+qtW06fxAMF/+MFdRSQhBItNe2APSs4+mOg==
Received: from MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::18)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 20:23:13 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::43) by MW4P221CA0013.outlook.office365.com
 (2603:10b6:303:8b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 20:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 20:23:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 13:22:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 13:22:53 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 13:22:52 -0700
Date: Mon, 14 Jul 2025 13:22:50 -0700
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 00/15] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Message-ID: <aHVnGnda8EgWaLKi@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <aHUs1Eq/dBxzxEBm@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHUs1Eq/dBxzxEBm@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9c9637-4343-4223-4ab9-08ddc314411d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?iZAyT5ZpGeijehdpR+sSyL+QcldnSzU4oTJDUKlgfyCF0b89FIO9T5PP9B?=
 =?iso-8859-1?Q?IPC2In6TC7pyDyAib5fJTKQTfP5g8XAs43gBnuVc2CGaT8POViDeMzdlFn?=
 =?iso-8859-1?Q?/uF0l8QzlCRbWAZX7ZBMe00OI6lN+w1w9dZyExQ1v/3hll235R9QJlx+YG?=
 =?iso-8859-1?Q?93zjtyGyQ2AoirgBQJF0GT4sTqmODEpB0wz/8ekJLUiuvUd1NfKiqc2beN?=
 =?iso-8859-1?Q?xMeR6TMlvZn9fV4OPHezr9/1I2MZKHiI7L9aUXlMIZb6XhV2xxm6dInIdQ?=
 =?iso-8859-1?Q?K6jsKycSqDoOUi87gUU1pLZX9dLBR+F551w3sgbRMPZRbQ9P2WIFJ/WjKo?=
 =?iso-8859-1?Q?aaCZNOqrCW3BScQHrG5C7vimQ66iUxRkrjtFCBWX1DhouXfCOR5QiP49Px?=
 =?iso-8859-1?Q?2ZOwodCDXDm4nwnWN9IruoyTxeEMUWdZf+H4jPvShh5irbbptEsXhMuLwA?=
 =?iso-8859-1?Q?nHKDuMr7UM4AtHEUFRuMH4eZuXnsUluUe5OfLxH1GRTjdfbTvcAU2do+ZU?=
 =?iso-8859-1?Q?uBRksdXXU6YGEfRMU/YXTOTYuKx9vXGyNOqgHjvqJO/gmSCtNy69uVwGro?=
 =?iso-8859-1?Q?QyE1Ie5CYbJWvGVx80zJMCk0rujpGVegjtch0LACyKM7Y+dx8lw1dyqvmM?=
 =?iso-8859-1?Q?nUZ/LuGWwsp8QZVgGU9vkRYTEllKBMSw090l68/Lvc7L1V1id4vuiW7twd?=
 =?iso-8859-1?Q?gXZOKVGOEzxhTYfUyYsNKij6ynOsPLXhlyghiOzwDUfcAhHHpjGwt6wMTG?=
 =?iso-8859-1?Q?v5kEeHa8MsYO2AfzOelSCZ7htz6N/wAVoN1FSqI6cOJnjvn7mHh5pU0d10?=
 =?iso-8859-1?Q?yJgU6jqfsJxsj2ssxPXJQS/r1VHJbWDaugFlJab7rSIm3+t9/ZSgTmQpib?=
 =?iso-8859-1?Q?uHw5+xVvlHqxp1JRcGPeln/z84NfvDDU67VIdG7fVFLAdlZ3Lnn4bvEH3Q?=
 =?iso-8859-1?Q?RkiiyPlXHZwbwMEzXJn4v66BvDMoMcgO4dMUQTjhSs1BVwGocEYo03FbtY?=
 =?iso-8859-1?Q?DFSdWSMOgmvhC0+cDkPSri/njYlvYqcceUY8rHPwbd7/feSWO3XYpWEQc4?=
 =?iso-8859-1?Q?3RO/H0haVy760ae7pYaZVfLSRXh9Rm9CUFVqtoZE1H9zC53rqS+8gQL6HC?=
 =?iso-8859-1?Q?LQWQqnzgONGfbVmrMMRqLin83gEfrMNxwLrY/NJwnBP4+uwO4fS1yMBRal?=
 =?iso-8859-1?Q?AuaVexqzyHE/qd3t4r7HG8UlLIKwRSmtvRYpMLemdYE1o2gnuQDGZhCb6Z?=
 =?iso-8859-1?Q?0LyoBEsShIve90jaJlJ8KpO0paVGIBloyaK8TbxCdMhwv4uZld8CDJeKJF?=
 =?iso-8859-1?Q?+w/YxXTw+cmG/A2XeVLIli+5FdP2nbKkZiG8ENFapIFZjxoyEezfJh1q8B?=
 =?iso-8859-1?Q?3qi/Ru2QfKZcdo49PU8q+mjGbTqm4w8Ffgz8uXzv9euBJcHGUJDbCFz3Ml?=
 =?iso-8859-1?Q?49DTVG8odm6ZnXSqblvncg/9KGJhzihrA2NVTgBCggGuJoCnUj76fJGEdc?=
 =?iso-8859-1?Q?7+8Zg7WzmzHT9/v0UQV+tb9jm39tvmxrh9dE/6KNkjJjLpdHV68JcbM/tR?=
 =?iso-8859-1?Q?KFaNqGK269Gq3Kv3Q4BzBp1eF7KB?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:23:11.5356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9c9637-4343-4223-4ab9-08ddc314411d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
Received-SPF: permerror client-ip=2a01:111:f403:240a::623;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 14, 2025 at 09:14:17AM -0700, Nicolin Chen wrote:
> Hi Shameer,
> 
> Thank you for sending the v3.
> 
> On Mon, Jul 14, 2025 at 04:59:26PM +0100, Shameer Kolothum wrote:
> > Branch for testing:
> [...]
> > Tested on a HiSilicon platform with multiple SMMUv3s.
> > 
> > ./qemu-system-aarch64 \
> >   -machine virt,accel=kvm,gic-version=3 \
> >   -object iommufd,id=iommufd0 \
> >   -bios QEMU_EFI \
> >   -cpu host -smp cpus=4 -m size=16G,slots=4,maxmem=256G -nographic \
> >   -device virtio-blk-device,drive=fs \
> >   -drive if=none,file=ubuntu.img,id=fs \
> >   -kernel Image \
> >   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0,accel=on \
> >   -device vfio-pci,host=0000:75:00.1,bus=pcie.0,iommufd=iommufd0 \
> >   -device pxb-pcie,id=pcie.1,bus_nr=2,bus=pcie.0 \
> >   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on \
> >   -device pcie-root-port,id=pcie1.port1,chassis=2,bus=pcie.1,pref64-reserve=2M,io-reserve=1K \
> >   -device vfio-pci,host=0000:7d:02.1,bus=pcie1.port1,iommufd=iommufd0,id=net1 \
> >   -append "rdinit=init console=ttyAMA0 root=/dev/vda rw earlycon=pl011,0x9000000" \
> >   -device pxb-pcie,id=pcie.2,bus_nr=32,bus=pcie.0 \
> >   -device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.2 \
> >   -device pcie-root-port,id=pcie2.port1,chassis=8,bus=pcie.2 \
> >   -device virtio-9p-pci,fsdev=p9fs,mount_tag=p9,bus=pcie2.port1 \
> >   -fsdev local,id=p9fs,path=p9root,security_model=mapped \
> >   -net none \
> >   -nographic
>  
> I am looking for that "branch for testing" to try some tests on my
> side, but couldn't find one. Would you please share a Github link?

Oops. I found the link. Never mind.

Cheers
Nicolin

