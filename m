Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5E9EB362E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 19:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx8aE-0003Hf-Q0; Mon, 02 Mar 2026 14:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alwilliamson@nvidia.com>)
 id 1vx8XP-0002kQ-L0; Mon, 02 Mar 2026 14:02:39 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alwilliamson@nvidia.com>)
 id 1vx8XO-00063w-4a; Mon, 02 Mar 2026 14:02:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9KnccOq8AgpY7wZIATigWNzy4ja/c0IdbXxm29D1oOT6MHyeudlAQIj9qlD5r7WhXHQcI1rUnQPGnhiIqMiO+qGxEqirlpeN8c04rEl7IS3ONZB+uXeY9pp+zXqFD1GA+0r4jZuhnmWpVlGY2MrFxt5fcYauGZZs30XIJtLSQvBsX9JdEO2LIqtToLHrv3TSwRY/dD8oXMy+c7tiwcGmBZZlHFMNFAPz4dq6xr60BTa628ylkfcWXr7OjvAb7esoGFu9kkNnhEGN14/ocinRK2M6xdjgRxaK1juCYZsaPCu7M+CEzaLCZOEnpfClEbFx87253V3zfrTTQtPavYUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdXMWqMPuB6sJrfaxYvHiN6SMDs1NKlHHgie4FiVLlk=;
 b=xq/lnRQj34XFr3jMeFWxsb4ZSqilM7RxfG/fsXc1KPzBmeBvI2pWOENcWLDoH8xUCfhVd0TWAMMkrWhIK+pYIKSWbFlNeVCK8ikmvZX/lShD5VU+i/7VfeSgjTwo0DGp01oiDddR3U/7wnpo5xh/WswUecw9OKAygpThIVBgpdizMM6LvpRKHVmsf2s9PuglFXm6FYStlpzxQ2GteSLGYCDNE2Rr5ui/1LX0KqgmzPq/+hjDbVv1lW+ct5Xt3wtL5qsx95P2lg2SggwNDrca9vamY8/0Ss8dobd9R+auJ9UGulPseypSWb4O4Ffcki5XFVvYqBVUpummkcazkaDNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=rsg.ci.i.u-tokyo.ac.jp
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdXMWqMPuB6sJrfaxYvHiN6SMDs1NKlHHgie4FiVLlk=;
 b=c8nCZ7QVZOlgwqiswTsbQzZ7UeGVPYwZx3l6d51xHKJYTOQwOztcyQRWDpkeWGhXfB4dntcRegnhUNsVN/Jwrhsf/crb2k6rHanQYbP4j6cbWu6ex9ral1fHuZbs5jXHBMf/z4qE+30kpm+0ccVnBc3SM8gOoZFpSyZfmUnCI/JRL4rFaiO28qVTRYeUvjttrmwIM9ogIR8hbmklCE6OY/J1iTADI7FchNtd7SE14n5/lgdzNbb9sEJNxyz3dofuiAs+UNSI0iizy74aMsfs3New1jYbmM1cg6kbLmXd/mEAWxrozWKJcrS5V/kpNTNr9Icl+tnCuMFUlQTZpCZ0Mw==
Received: from BN0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:e8::8)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.21; Mon, 2 Mar 2026 19:02:29 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::97) by BN0PR04CA0033.outlook.office365.com
 (2603:10b6:408:e8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 19:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Mon, 2 Mar 2026 19:02:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 11:02:07 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 11:02:05 -0800
Date: Mon, 2 Mar 2026 11:59:57 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: <qemu-devel@nongnu.org>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Keith Busch <kbusch@kernel.org>, Klaus Jensen
 <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/4] vfio/pci: Grow buffer in vfio_pci_host_match()
Message-ID: <20260302115957.10cd3b9a@nvidia.com>
In-Reply-To: <20260302-nvme-v2-2-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
References: <20260302-nvme-v2-0-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
 <20260302-nvme-v2-2-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 7445a8ee-3307-49ad-fc2c-08de788e4017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: 4K2Kz5VWWdV4pkiOIX7brOOZ9c5QcA4WHRC14J1NYWBAz2th5MysNe4bBZSBu6Hd+0lnTeMQSuHLKnKnXeUtCEbQsWndTDDn48amdFvPDC4ABD5HZBRn9KbcipIxwOWrcWgPlUTja+Me02F2QhXJk/rP58WNoW1COt5b1domMpg7sJANn/CYAORWAkJYGlPHbcMsQtkcVsBTBQd39wTa5BVOP392L/LTNdosfI0d563hQr0FdbSOn9aRiaf8p1blQEftjZK8M4fw66YLkMuRiACA4mYDOOEp+yzQKm0QEv7BKy2wrhtW7MCHM1PwmBF80Kl9M6oJ9/SvSkRH5IfcI/n8Eo8xS93fyqC5ljm1EQyJN/lB+pOc7KSPiqkmbRLRzKa4rbldm24qrSGC0K3Qm9bta1vf8Q8Ye00HrUh27bHNjBkeZz4Sn3IQyNPE+3yoqlkD47VMLjh+VNa+1QDrd12zewOSr6atoYkxQqV6xx2z7+GHOFwZOxpt4PtTBxfXCiVwCj0TPxqaPf75f+ZxIeJjKmqqlRIRuHgmDbsJ7KVNvYqbAY7IEAlXMtjH3rUw+08rs8RUBpJsei47gUPIcYkpXk0yMSlk4nm+hF47tHwb1UYIsm+ISkSYRvf32mK7s5uEBSXcqBp0ixjSoZdiL5iBkQmvYvyaOhThLrk5t/GvL6uF5GDQjhTD9HXGeKGV0S75MwqzLVzF48CqcHeKPSLd37fcZQJTa6L16MU24Ya+BRksauIFYSitzRIeCvvuG4udyO0X3jXkSPVhEmvkuss+gk3dFATmKb4vp9CftmzYKrxXYJA5j24cb0/UrhCi
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Iieh8KZH+fbMbLZd6eYogUW5l29SOayB80GWvWCKKMog2ZP49HIA9gbK7lMx43dib0AfEe0Dhq/9qscAbddT13ciakzSLMmFJfDsMbhuj8R225b+7kfddSmzgAyWdhO3TrT1Z37jjZ11VfqQVN5mh0z0f1CdIE+aD+Irp3roHM//B3evLUfXPdUtPdN4TKpuCasQMx6mlATN25PJSUt/k81rRNjHtV1k0u8oFZsnKwTbLOCpvfuYCiZwH/NkpcNOJ4+3hF58NggMNdYWqBP6l+RDnTOws9991DSbAbQknQVgBz59+QM8k+xcaj51Qt7FxSbuCYxA/Lf6wVNgozGYASkBb1XpciHJS+qLN8nE26VpDSwvo2DnmKenV1cq41AQLKyKvnRC60Ky2jmZKPW7+DJe7GCgVQmfbAdxEhLIpi/z8BeTje8BRPQgJ7/sMy8z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 19:02:28.5231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7445a8ee-3307-49ad-fc2c-08de788e4017
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=alwilliamson@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:05:33 -0500
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

On Mon, 02 Mar 2026 16:48:09 +0900
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> Ensure the buffer in vfio_pci_host_match() will not overflow even when
> an invalid addr parameter is provided.

This commit log could be much more straightforward.  Something like:

    Each field of PCIHostDeviceAddress is an unsigned int, therefore
    while a valid address is limited to 13 characters, an invalid
    address could exceed the specified format, up to:

        ffffffff:ffffffff:ffffffff.ffffffff<NUL>

    This requires 36 characters with the terminator.

With that:

Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
    

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c89f3fbea348..94c174a773fb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2739,7 +2739,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>  
>  bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
>  {
> -    char tmp[13];
> +    char tmp[36];
>  
>      sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
>              addr->bus, addr->slot, addr->function);
> 


