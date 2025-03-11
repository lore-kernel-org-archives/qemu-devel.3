Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FDBC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts68W-0007Bz-Kj; Tue, 11 Mar 2025 16:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ts68U-0007BH-MA; Tue, 11 Mar 2025 16:23:34 -0400
Received: from mail-dm6nam12on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2417::626]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ts68O-0004Fl-8d; Tue, 11 Mar 2025 16:23:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjeuGXTmkj9inUTnLtOjy113gMlGsvoIBDhGGfirwtzhOt/rGDU6P4yP/Osn+16sncFE+MGXx69BlRpa6TNS42fUAFERho7H9KqEhlzQwZ1vqPlh3ONlay/1gPTVBLB7QaARsfDYiZpLeOUJ/nuOWAwo2Q+d7t7B6VibvRsVQWsaG6cDuzD2MSP9YWo6DmF+6nDB28F98ckwbfsABdZHqpG2XGKFXjd5MWDT5NyVRibq5+m0ZqaqsHyYHDzFfS40VDYUfIhDCstUr5GQ5G8NygIUiui2N78VOGT4eNrdggkoAWjUFxeXXc90guPSRye2IhPphrV2WyhU6oA5Pe8LSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVw+z5YsejrGMIVJ7iD4h5Q8tKsCJkxas3XrRWjuV+8=;
 b=mSmNNKPTRanBi/y2EeIr3on9piidKtGOiP03ePzfA8xQ3vUU5+oLorrP7H85YIqZGMJSpEdXnLgpZzeqgzo+qPULv66nilnVzaYZbpchqVYP2DjexGBfQdZ11rhFtqINyLyJYnPfLGseQjJr8Oi+f8UpVntFDIJEUzDu+3RljS5Iz1D2I853fJFGUI4wqSvWN2sg74BMrJ2SfJnBDhN8ymkZ0s+umz+Nvgq2KhpRpLvWbPgjZXztcEMLYuQUTKndfUC+VfI/ueApKdNrEBwwUTRuo18oKRYN3vy4Gpv+SB3z8rAJf9j4PnfVsLORhmHo33yEEq83v5xduk4MP610ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVw+z5YsejrGMIVJ7iD4h5Q8tKsCJkxas3XrRWjuV+8=;
 b=LD+KjyYSKv0bE7TIumlngHTqw5loybH/EClsb7raLlHTzd5jZNjGhhVbkwnbfu6F0t4Evj3pdYFIiajPTiO90x7OLccxC2Ciuji4J6ISgsTNBtvC9NxJxLvc371FjKzkGPJxvDlbcBJHfRI/i0ytF4e7Pasn0TKR6QlSWTFLoWTCqgV40BU36F+kbruaIgPRz0gI4p5CaBKfLqbMdG0qMWO1d/coBoAflVO52JfciopSJhYD0Ge2/9o4L4reYfAB25e3T7ctDcUG7rUorgS8ECQ3E6gccwMeR3uELwdw7hslPWd5NznesC1IcJzVGpIDEd2dBqXv1lb0ZGOsH7shoA==
Received: from MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:23:17 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::97) by MN2PR16CA0041.outlook.office365.com
 (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 20:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:23:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 13:23:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 13:23:03 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 13:23:00 -0700
Date: Tue, 11 Mar 2025 13:22:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Message-ID: <Z9Cboq3scDHS/DAS@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e391b04-476f-4c04-7c65-08dd60da8e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ZdxlLFElp9pRB4TforAbxMvWWepv+VGYQigDKXX6gjKaMYIXFmG+SSZyNpF?=
 =?us-ascii?Q?NATloAX4dD++PTpDbICbTd/MKRbEv2Tuq4j6+e7lQu8TxKrnLT6P4mXyZMZv?=
 =?us-ascii?Q?1o/HtFg/OyyUN6AzjSlvJLvJB+rncx1LG4X4vPiJ1qcDbOOWo2bQiOHIZ+de?=
 =?us-ascii?Q?CDfzzUWK7s4sYji3MwSI5TZCUyZqzTnJZD/M5pzzM0QyZV9Dzq2gjZuQFt4Y?=
 =?us-ascii?Q?udnFsaVk4pRITIPlrqornaimaZ1vL/XNpLnUoaEhrw6NMYCp8uKS1QZ9mmMu?=
 =?us-ascii?Q?2TQjlIwm/Z2x7PKvY44tVN6X6b3zyVd8ts8Z2idUql0Hv8JwUp03m63ZEksT?=
 =?us-ascii?Q?1n1IvRUPSl36fCPgbh27G6TToEZ5AseO3BebkOZjv4GvZ7JZQp7+4ihwSa8q?=
 =?us-ascii?Q?G967dcwuae5k0D7F/4CQmbD29mfB7WAW9JHBZQ+LZykmsujcfFI9P8OaTP9u?=
 =?us-ascii?Q?gjXS2rR20013LzTE63kzR+S/RIWVpc5G7eD5Cqlku97L+wYh/hKwJP1QhY/z?=
 =?us-ascii?Q?wT0+jw0vRa60SxIyb2fGMrCR3sVc7sD0utQyaQPHoKMQF68sp/UoDLprfidA?=
 =?us-ascii?Q?2wSvx/0/3qdnrbP3TkvVLyEvgb/1mYlrLfzhS5kJbtO4ztHxsJCHoDKz4R6y?=
 =?us-ascii?Q?g6uyHkvUOk9BFjH9QFDaDYcK7OMglY9TUbFCTTIyCsXd3sXzuyVQsUfvHIHO?=
 =?us-ascii?Q?HqvHwKS1dVTDxRNhJsj4sneJMQ6ZvKHSFJM9fFlZq5XpsO4wphdbWOkCQBVE?=
 =?us-ascii?Q?IHEv6TOCIrt5dfaIhg+Ls1Wo6XCzjIRU0GYI1UXvMNpnpLf5KL92d2FrmBlu?=
 =?us-ascii?Q?/lUsM6ieaZ3uZ72J5nA4C0GEWL59tOEnYOp4CdFJy9Ncbvj7tdA7kYjNBOER?=
 =?us-ascii?Q?xyzR+0CXBKbi9TNhuyd6sJEOkit947QmAykJB7j3H68O0UeOx4lOg68UJp42?=
 =?us-ascii?Q?shjp1hvoPgGlLPX5OIIjGrPMtYepvLhtXUWj8XGspRMpOCpxzy9aKGJ8ugxT?=
 =?us-ascii?Q?v5jLEv46DOHQYsPkTB59EJwAGUN/y1tKrSpgwx8mSV52/sUS/Hw+sSkJy0Zq?=
 =?us-ascii?Q?tR8t67sVmqPIpP+1O6elRRRIeLGBtUHQojE9bmOsrAj9RuaQnR8XM0UjrgrF?=
 =?us-ascii?Q?YMAVMD1evyF3Mq+0GSHXM/0J0sf4C0tjlD6waMSHqpTUzjHtmJ24UAGYdHYn?=
 =?us-ascii?Q?SdZw1oMETQWFmhlVD1xcMkQ9tJ9fiFIwFedjjlSpnjXzBzsR9c9SO4AE118V?=
 =?us-ascii?Q?iinFxt/CstPnYxUu0mxC1NMGgeIGCyBpCS97pjOK37nyonp+02OKZc1F7ag1?=
 =?us-ascii?Q?fUR3Xt9GDpsW43opuHUcUOp9SBh9SxtTE4vBd+aRxeGMblsEsfm/JLkObdRB?=
 =?us-ascii?Q?6DfF5gAs4ECVOCFy0ILcVD2pZYX6XpfxhrCipx/8pDegrIHoyL/Fqcrw/vMr?=
 =?us-ascii?Q?rlhxu1cNZgrnheVmdFsNVcGqCyiO/I0t1wHmXcu9rkGDZJCdZ/8RAE0ScwHs?=
 =?us-ascii?Q?13d54z3EpIOhS0Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:23:15.6439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e391b04-476f-4c04-7c65-08dd60da8e07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052
Received-SPF: softfail client-ip=2a01:111:f403:2417::626;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 11, 2025 at 02:10:29PM +0000, Shameer Kolothum wrote:
> Allow cold-plug smmuv3-accel to virt If the machine wide smmuv3
> is not specified.
> 
> No FDT support is added for now.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt.c         | 12 ++++++++++++
>  hw/core/sysbus-fdt.c  |  1 +
>  include/hw/arm/virt.h |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4a5a9666e9..84a323da55 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -73,6 +73,7 @@
>  #include "qobject/qlist.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> +#include "hw/arm/smmuv3-accel.h"

smmuv3-accel.h included smmuv3.h in the patch prior.

> @@ -2911,6 +2912,16 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>              platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
>                                       SYS_BUS_DEVICE(dev));
>          }
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_ACCEL)) {
> +            if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +                error_setg(errp,
> +                           "iommu=smmuv3 is already specified. can't create smmuv3-accel dev");
> +                return;
> +            }
> +            if (vms->iommu != VIRT_IOMMU_SMMUV3_ACCEL) {
> +                vms->iommu = VIRT_IOMMU_SMMUV3_ACCEL;
> +            }

Looks like it is to support TYPE_VIRTIO_IOMMU_PCI?

Just asking: should SMMUV3_ACCEL work with that?

Nicolin

