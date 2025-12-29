Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005CDE92725
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 20:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJad-0007w6-Te; Mon, 29 Dec 2025 15:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJaY-0007vP-EI; Mon, 29 Dec 2025 15:11:34 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJaW-0006Ed-Ub; Mon, 29 Dec 2025 15:11:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umQh1nfPNqMeobMxyuDNT7ac7WVVAs/75yB6Zj5piPCFs8VZV7dsZ45gkx1VMiUD7iyY0y6CiWRKsuEoNqLxMjpvOAJiugrQQ6V8ByvB/8zoZvq+qsy3zh0ZjSjwOEViV/X8irC4QK/awg2eZ9eu8vL4X2lAAwL6/2H7+bPkAI9WpPYXIVVFYrheEgtq0zbN6W10eeo0hyGbDbp71mp0tz1RFO8/+FtOATv7r5QpVWMeCRDGDpXV47Vhd0tpUgnH9SBzHqrgTjIh6aFGMh+QJy3I9cFhwBVqgRHCEIJ0bKCNuASbhukTppQYeZRndRh+xEpsvKdC8SVyE/SrNUgmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNMqyURaPMkRZqQOKYfNOAQF4NlecirDjr5Ng7DjgWI=;
 b=XfYh/FyHsmSASNHey4GcvOmjVtkDy7ugoWL9Ichom0E7HY+8zvjs9lkBKEz6spIcTL0qMFZN754WRyI0Yl4QaXvHCfYrdI59l1wKGXpEMGXxtOTEnBV+L+kXJTQYZxzhmJe7Bsb+gauZq+3IeeTTxgLO9Nvcdx1VOAn/wNLWj3ltzS0q5V6i0Rm4H8Eo1lHzeXf5A6npzl5cHzage9M/KpTDv4wYvTIA5MpN2sWkv+N5Xatok+Nn3Nf3sR9cnBSLIuTXIeENCtVNXUrmT+lgMH4jvfhLo5LqOTc05R5OYGyddzfqkI8ztoULovJIiln+VKIiqncB0eud4/luekOBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNMqyURaPMkRZqQOKYfNOAQF4NlecirDjr5Ng7DjgWI=;
 b=NmxpHpgUKf6GrQgIsvTW3r58J8iHWXpA9kMGDxgyWPraE96UBf9J9v5/S4aHTZSYNk0a+7gjRLWPE5Fzx21p5DX8RdwZWwj8EasCpGKtGuzPU+6tTyOIFsooEovJ0j6Sj1ruGnIG2IoKcAWppRnc4EQI10CLwUKVjWQ0oCNU++J45O32Khmp1gxfcndUjYA/m+sGS56gfdLvUSaqy28oMmKfLD8bVJUvHpTEkyDeue92y7DwXZDLovH3LUyk43+LRN7d+cwWKLk4HHg0RrUql6HxifcGPedgiyUwvGgR99Rn0RF2POXgX4eKsjqjKQ7Xi+lQxKsr3DHpPMKK8f4GzQ==
Received: from BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 20:11:22 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::4a) by BYAPR03CA0029.outlook.office365.com
 (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 20:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 20:11:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 12:11:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 12:11:06 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 12:11:05 -0800
Date: Mon, 29 Dec 2025 12:11:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Message-ID: <aVLgV+kscNVlHjIq@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-16-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-16-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: e16ed991-c52d-45a9-76f5-08de47166f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lql53s0M9AqjQiO9juo8pXSC5EdrRB5BeCUX6q5pAEHu4NyFZWskW3EmBD9m?=
 =?us-ascii?Q?g5kCjdVqHJKll7dNxld8/eQqxEsnMNGFJ+rYTXASkkY/I7oc45LhVf0Q0v5L?=
 =?us-ascii?Q?9f/mXVhJWEcIYc224rvbrSZpQ3kC2cUbo+pGUvRwlwzoFGC6fXIRukg+kUcB?=
 =?us-ascii?Q?tHeRH/ATFd1xsk4j0TWAGvtB2u/ztJcvp+2W2EJ1qNcAffjrEXHcw3ctXInn?=
 =?us-ascii?Q?uJ+RgLjaTMFbVYMuKNVMxvvTf13A6prF9S8dYOLmBR0fomNp6M416q4AIDkb?=
 =?us-ascii?Q?Cz3OPlzEU8ogixgUTXzvfXgLslv1tVX0+/UC+zzF2l6b+iK4KMv3aFitPyJy?=
 =?us-ascii?Q?KWVHhczPlgpmgcGXy55YpbmtYJrYBbKV6Vxm9WTnXEI77vbNLIGVhap5limB?=
 =?us-ascii?Q?c7NKL74Qyst/aoIgfCi4S8Z5IOBtOpDNYNrY0Np0i4mGHYo3JGkDFyOof7Ey?=
 =?us-ascii?Q?GezxbXqm8hgMY1hXUhi3wL8M1Gr1TAQ3AO2i7RA/fczAOnTF7plnRtgb5V6Y?=
 =?us-ascii?Q?w3PmBgvODxAifRXToEqNRA/NM7m21i57qmcoivSqE36Ks6SgZWdSXx/wT2fN?=
 =?us-ascii?Q?IOHGAyzBmgZyLIuZil8Xyd5HShSAVUmAoeZdfds2L/WKjxYboh5Y6h6upQP0?=
 =?us-ascii?Q?9wneoFuxviipUeTW9SLJeQYRmpkfohqfbiorKgTkGoOkIzwt/6siL4tPx/4D?=
 =?us-ascii?Q?j4A4rqlYtSprOXQ+be8NqGsDVm464XWFF2itkWCD90x9kxwSoAtIN2GmonLZ?=
 =?us-ascii?Q?WSB/RhOxKnAuKgRvltc5US2PHm6/7DUMIhEe8eRW2pptY3RXuoF+AxVA9xla?=
 =?us-ascii?Q?Z+OZxnsLUGA6vtb0QUtdSX8t7s+IL413B20kmcITSBa3S/S6uPwrNRARk/Ve?=
 =?us-ascii?Q?Eat0HlXljxOi3z+m0ugga2wXcBhtBgpycBuOqFBIk/PTF1BOfvIp4+AUDnXx?=
 =?us-ascii?Q?zI52xYXjCne/OKkuAZpUZ+t3rA6+9DKl7H8K6q/sXpQnCN48kHolyjaUp7os?=
 =?us-ascii?Q?WLMTcDfF+wa+nQdrXZvtoi3OH2cvmIOSvUQ7o8FkmXMUTUe/UT151osHBVoD?=
 =?us-ascii?Q?dJHGWF3PHY8vnw8bLMx5lQqUBSr1e6vyU68CDJfweoolDSGr8IN5erwVcZc8?=
 =?us-ascii?Q?fLHv0KEmmMOoYptRKVSwx0drrWjQpNeis6IfUxCRDQe86iuaTL46cLKASMCS?=
 =?us-ascii?Q?9CF13Tj2r2BGwAzkQMSllBiG59hQ+MGhbLuSpObfpFDyuf0mWdOk+5IQZP8S?=
 =?us-ascii?Q?fGK0vE+uKvWDNOtIL7CTMpLrvp7btklIpaarhahCz+WAWujpLKNAO81tzfYW?=
 =?us-ascii?Q?UGdI1HDFKjn/zQmEU9c1Ek0h1ahXiFYCgw9gPaMWyH5t3tN2Y5y4U0dIfRyP?=
 =?us-ascii?Q?NyYicWHWxUOi/P70KCGXSpLURrG0l4UORFnkgfG4EZDh9nNAwrLMchSeZ/Dv?=
 =?us-ascii?Q?zDwX9tj7zM0hUXziTOZdADmaLUvhKAdbkNfdRQaEA98HtKYeP+ZsQuYw75Bv?=
 =?us-ascii?Q?yh6ABXh/5CUyi3O7xZXHiQ8DQOXJAMU2/8iL/96EIGaxl85EG0VxEz9A7gid?=
 =?us-ascii?Q?Acv/VnpK4KO61uOZEmc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 20:11:21.8803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16ed991-c52d-45a9-76f5-08de47166f90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nicolinc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 10, 2025 at 01:37:36PM +0000, Shameer Kolothum wrote:
> +static int smmuv3_cmdqv_devices(Object *obj, void *opaque)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> +    GArray *sdev_blob = opaque;
> +    PlatformBusDevice *pbus;
> +    AcpiSMMUv3Dev sdev;
> +    SysBusDevice *sbdev;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> +        return 0;
> +    }
> +
> +    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) {
> +        return 0;
> +    }
> +
> +    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    sbdev = SYS_BUS_DEVICE(obj);
> +    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
> +    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    sdev.irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
> +    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +    sdev.irq += ARM_SPI_BASE;
> +    g_array_append_val(sdev_blob, sdev);
> +    return 0;

This is pre-building SMMU's IORT nodes right? Maybe a different
naming? And can be shared with the existing iort_smmuv3_devices?

We do so, because we need to link CMDQV's DSDT node to the SMMU's
IORT node but it is created in build_iort() that is called after
build_dsdt().

Let's explain why we have this pre-building.

Nicolin

