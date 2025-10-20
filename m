Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2211CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAuBs-0001WO-B4; Mon, 20 Oct 2025 14:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vAuBn-0001Tv-S8; Mon, 20 Oct 2025 14:01:01 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vAuBl-0004Yc-Ci; Mon, 20 Oct 2025 14:00:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eorpK+F7k24DN0iFmkFKjDPhTNiMud0y+C7OqC3O+tK6zmqJBKwoBCV4QfMJ++BMiTJrqNk2SKpe5G0NtEdI0+t/gh9FOseSmAbHyFm4hlEOIkz+PqGhiI56qugyIyA1oPG6Wc+yiaefFluB4kb/mQ30IgNRD6YpN4s60m5UUuV0+C7Qwr7NTBQ5FtZ0+Gdzx3MpTip8jwTH6HyXf5lkEdJM4tLsXLyJ08sApuTs8Bs5SMhRMNZFHPQiBDDekgf1fuE4Pss20/3IR3iSOdHu7fEuk6W8Zk+zNlneoN1lsBTYST6Ze2Zim685M2Rx/ilS3PbATdkgx2rVANyZpih/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Int7Bs5gyElnzo3vl0TNgJkfY0ghNW4R1ABalFytcSs=;
 b=UpMJKdd7IJCIsV7ZrwiHcKT0oadXtUgnC6Exw7UzqzamnY8RQ79BGUKeeyQ0fPluqFTbgKubY8SHIbS9gHfBclvTn6LYjaldLlgFKnEXv+0pgYLV+VBjzZItDdGDEU4zKQce47uj/1Y7WTjp1W5OoraA4oI+8hXoBYWs0H8PRbupT7mE5yDP6ebUlRx2NmU1D/SdHpyeH9hpAbqNfFUMO4Dhbk9oT/qC4u3S5TVmmYgoWhTbiMvkpXpfyE3JCTQW9QmZLo/BcwACd++rMxUdFtViv4fRZjdCSDGiifUvYx0lEzwxbj6LmyENnk9SMGf2QQon0jLpfQmA1qF+T09n7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Int7Bs5gyElnzo3vl0TNgJkfY0ghNW4R1ABalFytcSs=;
 b=hdZKwz4xd7qEZQGMeHKmW1KcZcKsUIo/+1MSXdGlxaHPdJ0zHVJoG8KGxhTX9LF2UHvT26agiM59h6yM0peJgQIGhYusKWY4Lg3GVoYGtf/iJauoYAf7UCphp1/BawZshm0YiBMY8qeWKXJLb8uO9cN+YkwD3dKea6o1MQgZpPHgchwzyDMiLO2DtC2qoIenRg/+WPTyUT07AfGRb3UNZ0Mz7qXLcdZxIdUxys2ALizz+/MbARWs3ExMfcUWUB3RSoTpeTVl6Xs8R9bP5T8THJjgxMwbh6WinslKfOFKfhru6e+o7lfKNkKNutmXWJ3p9JbAtCgIPLhJGpCLfIA7qg==
Received: from CH0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:610:33::31)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 18:00:42 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::69) by CH0PR08CA0026.outlook.office365.com
 (2603:10b6:610:33::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 18:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 18:00:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 20 Oct
 2025 11:00:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Oct 2025 11:00:23 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 11:00:22 -0700
Date: Mon, 20 Oct 2025 11:00:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 11/27] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aPZ4tcsMfN+2puGL@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-12-skolothumtho@nvidia.com>
 <aPFx7Egdny+JCO9U@Asurada-Nvidia>
 <291fe8be-405e-4ea3-acfb-d090f6a7cd15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <291fe8be-405e-4ea3-acfb-d090f6a7cd15@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a201060-54af-4760-41dd-08de100295e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WXxCZlJWcx0lF+HLZU9dcFBZV1S3LCTj9lPiX2kgAj9HAavnCbxvwMzbQxTT?=
 =?us-ascii?Q?hDbX/xLcz4A2i1MukGvbF6xyas6zLlVikwaNLNLHtDhhyeW2euDjpEYv7rmH?=
 =?us-ascii?Q?9dwSQgQ2eD69stKbcrTGKuDGIPtDMp5Li9+EPQapXpvl/hnH/sIg6WESZKCO?=
 =?us-ascii?Q?xvWxkfRMHbBYfqELckMu9ehhwW4lm85AE1wzK0+s5MUHPXQQA4UL7rNH1dx5?=
 =?us-ascii?Q?ojhonSWIZxnqSJECRC9AyxawCWlhEnxh0PYbXVMnsYsVyCvLD3ufJOMLXKq3?=
 =?us-ascii?Q?6beeZ9YIL2GzWfUKashOXwBdBOVH+/QRHcT4Q+/GPN5bQrMxCtoFExSyODZi?=
 =?us-ascii?Q?Wo9fGbl3oiLH9EGumLmMKrO+TzG7DQnrRivooeN0px9Om3TuYrUs09LfgyQA?=
 =?us-ascii?Q?K5RdhcAh35qyTcVm7qan2MoylpFKzRdg/Pocs3EegcKZZJsI8Hj9yNqDMcTH?=
 =?us-ascii?Q?JJCNtt90gQ64RTdiGnLbaaSeaYP9x6yYE32y+FvhlwS8wekZUbTNYuaEfKYa?=
 =?us-ascii?Q?vaBOv3NhnvgFs2nTxqAGAjImTUUhW2iLY3Qi9Q2xtjIPfyScc6BG57BTbmMT?=
 =?us-ascii?Q?uEqxrSfrTCxVwZjeC16g6hQaWhEwIQSInjsiXRNoWgLxYCxAZAjhJjSNv9+z?=
 =?us-ascii?Q?IuI4GMPJKjqgSUisKrwAkTyffUZ8t//MOOuIUtHqM2KDpw/7CkcQR7ebO5Fc?=
 =?us-ascii?Q?yxbc1nMSZt7+HaI40biw4aOLTuX3lz6/1Jmd+Y7XTdBjWwQupjlyHcSfdhmA?=
 =?us-ascii?Q?j74Cktrwr81GlV4+KhrCzqslYudJ21yPMiEGH8XFR9kso2Eo6hIroVq6leLd?=
 =?us-ascii?Q?gVPomaHoJB+YfQ8+5Ip/KaErLJBugBbzpAWbl5UvG/0TKIJZwTVk1EpDQChY?=
 =?us-ascii?Q?IIr2LFwBsF0QcN1bejbMHPgbFYYIDTQ45s6jb9hhalRzBKTnDBqL/gRCZy0e?=
 =?us-ascii?Q?c/HjrzyBZPU/UvHHt96aXgOUlf4z+Q3WyEldE+pbZpEXkCfqco/1/rmPtPGh?=
 =?us-ascii?Q?u8ECxA5lgNzQryqHjpWJm7XTT/SaUA3qdoAwuxrIWT+1xBSS7sDNNvI3XRjG?=
 =?us-ascii?Q?qm6IPBaQr/JSkhmWVrBWG3ON6BtpQvIoLivfD90qVIvwm7yu6V8AdigEe7D7?=
 =?us-ascii?Q?npLqnfpF5VrDun3DXr64LZzkVTYWZ9n2eKBS3C16KN4Er9w6pBMdLmuu1NXm?=
 =?us-ascii?Q?JZAkLq72pbPqT9GoRyxRtfVEpvEDZU3ZDbQ74blPCrQjrDhKU0PqUeZq5FEA?=
 =?us-ascii?Q?CIT6t+UPxykBV8o/FlChgX2XH+v/PRE/ZEfAy+Ftw/ym5MntLaGTzC1DX25m?=
 =?us-ascii?Q?zJ211b2/+WCKX6d9Qu7ed+mE2Io6cwk3s91bRtHROThc80yi5rTZdq69m3af?=
 =?us-ascii?Q?Gum2kBXnlPhIh0XX1cm5Mnh1BUISocMF0qfA9fPL0omrzNiP8FwVYCdPn3M2?=
 =?us-ascii?Q?tR3tgyWBdzMOHZc9KVbVkSO3FJXn7kUBvPHnZA1AVYD0SEigA/e75WyITs1P?=
 =?us-ascii?Q?0iS+UEMK11qiXfc3w4evCT+5ClYX9OTH2LEx2QGl7gr3YbZF1unwzlnO6dBC?=
 =?us-ascii?Q?s3LNfAGRbiSuZfLc8W4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 18:00:42.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a201060-54af-4760-41dd-08de100295e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 20, 2025 at 06:14:33PM +0200, Eric Auger wrote:
> >> This will cause the device to be configured with wrong MSI doorbell
> >> address if it return the system address space.
> >
> > I think it'd be nicer to elaborate why a wrong address will be returned:
> >
> > --------------------------------------------------------------------------
> > On ARM, a device behind an IOMMU requires translation for its MSI doorbell
> > address. When HW nested translation is enabled, the translation will also
> > happen in two stages: gIOVA => gPA => ITS page.
> >
> > In the accelerated SMMUv3 mode, both stages are translated by the HW. So,
> > get_address_space() returns the system address space for stage-2 mappings,
> > as the smmuv3-accel model doesn't involve in either stage.

> I don't understand "doesn't involve in either stage". This is still not
> obious to me that for an HW accelerated nested IOMMU get_address_space()
> shall return the system address space. I think this deserves to be
> explained and maybe documented along with the callback.

get_address_space() is used by pci_device_iommu_address_space(),
which is for attach or translation.

In QEMU, we have an "iommu" type of memory region, to represent
the address space providing the stage-1 translation.

In accel case excluding MSI, there is no need of "emulated iommu
translation" since HW/host SMMU takes care of both stages. Thus,
the system address is returned for get_address_space(), to avoid
stage-1 translation and to also allow VFIO devices to attach to
the system address space that the VFIO core will monitor to take
care of stage-2 mappings.

> > On the other hand, this callback is also invoked by QEMU/KVM:
> >
> >  kvm_irqchip_add_msi_route()
> >    kvm_arch_fixup_msi_route()
> >      pci_device_iommu_address_space()
> >       get_address_space()
> >
> > What KVM wants is to translate an MSI doorbell gIOVA to a vITS page (gPA),
> > so as to inject IRQs to the guest VM. And it expected get_address_space()
> > to return the address space for stage-1 mappings instead. Apparently, this
> > is broken.
> "Apparently this is broken". Please clarify what is broken. Definitively if
> 
> pci_device_iommu_address_space(dev) retruns @adress_system_memory no
> translation is attempted.

Hmm, I thought my writing was clear:
 - pci_device_iommu_address_space() returns the system address
   space that can't do a stage-1 translation.
 - KVM/MSI pathway requires an adress space that can do a stage-1
   translation.

> kvm_arch_fixup_msi_route() was introduced by 
> https://lore.kernel.org/all/1523518688-26674-12-git-send-email-eric.auger@redhat.com/
> 
> This relies on the vIOMMU translate callback which is supposed to be bypassed in general with VFIO devices. Isn't needed only for emulated devices?

Not only for emulated devices.

This KVM function needs the translation for the IRQ injection for
VFIO devices as well.

Although we use RMR for underlying HW to bypass the stage-1, the
translation for gIOVA=>vITS page (VIRT_GIC_ITS) still exists in
the guest level. FWIW, it's just doesn't have the stage-2 mapping
because HW never uses the "gIOVA" but a hard-coded SW_MSI address.

In the meantime, a VFIO device in the guest is programmed with a
gIOVA for MSI doorbell. This gIOVA can't be used for KVM code to
inject IRQs. It needs the gPA (i.e. VIRT_GIC_ITS). So, it needs a
translation address space to do that.

Hope this is clear now.

Thanks
Nicolin

