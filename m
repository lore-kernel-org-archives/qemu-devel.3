Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63045C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMsD-0008SP-Q5; Mon, 14 Jul 2025 13:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubLpL-0000bP-7w; Mon, 14 Jul 2025 12:14:51 -0400
Received: from mail-dm6nam11on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2415::617]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubLpF-0001hL-3t; Mon, 14 Jul 2025 12:14:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw3TFrUMEKoZpbUv6DQVp1iqvZPof3e/dcER5+GAou3bwHgsuAFpwNj4euYr6JTasCArOfvZ7huhVzD7pMPRWkPPysB0BjtA+m9LeTHqONzJy/EtqFChtwa379OSOQfhBC4CCHlwYuBpMvAud6MuN3o9gfPZryL0QbtvQZN57NwyFpF6maADkqjKnj4SGAv7J8mg1KUPf5CZnslMqoi2p8Ja3loiqkoDtAFM0AHMqSREmxTHPIfu+D8d3iEt91YLu3MZdxXYZjrar9mJOPYj7+eFfXv4IZuWsFkt7b83bfZ0yy7T9BoMJNZLhEe/adPG5prwJEJCEUAotbSKqT6TrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtGKYslkYDG8ruzgDh2AHXolp0m4Mki/FXVe1hyVbkU=;
 b=kC+PC7wcFHANaIn72eIQSWH2O6RdoDDVrKQ4J51q/p2LEIpVzqB+uG+UchVs2eN9tTrrFDFTLBvKppNFjra0My+sJNftocPzvJ/SyBv4/T872mjB+jkI7AymDo7n9ERCrOl9Kf/8k0WMYdyFKfMJIUbejqHqUKRoIq6REFGlifm7vXll9dOLytE3eZlWgAuQHAltgiJjJDJw2ZQoVg02vVJyyenyOAx6v4GwKg2VdO7BhGle0RlIi+9M2lU5wRals9Hw9sc6SYOx1iN4/i5arWWbNy0bdzZ77dqbrTHGwQWumDQmMD/YK02UFdbX2MZ7KS1Knipu4BTYdU9Us8//Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtGKYslkYDG8ruzgDh2AHXolp0m4Mki/FXVe1hyVbkU=;
 b=bk9B1T8B7ho9WzKDC11OfAm69Q4amwS+8y9WFJ5tigdAOF7NvUW1DDtxiFCz9M5YHlV3dJbKMhQ6i69nlwlJxbf+45tcrkP1a47bzOlKnGfz1S2fzLjsnV2mZpmtH9g/OjAjkzLZ2vayG4z4Gj1O8TY7FHCcddOcfyQjU1ECcW2xVIQyVNc93FYxbz4TP4FprHF/Dx91jTdYrO3KUWhZftQoTbUXhvbOHsxEJrjyt9o9Xjdt8RyzGZx8cUkD2QbuDrTRhG30Ieh2EJf5zDFfiDHE7ryqX/bKOzUjOpTv+BtmmOBWw/xOIWqysItgSDO0OL+1nzkGa1Uz84jZMJslrQ==
Received: from MN0P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::30)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Mon, 14 Jul
 2025 16:14:38 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::84) by MN0P221CA0008.outlook.office365.com
 (2603:10b6:208:52a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 16:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 16:14:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 09:14:14 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 09:14:14 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 09:14:13 -0700
Date: Mon, 14 Jul 2025 09:14:12 -0700
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
Message-ID: <aHUs1Eq/dBxzxEBm@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b75e00-523e-4b92-3933-08ddc2f18798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wbr3UMFB/n6/5OJC4xEDBAKowR3t1TR7s/xjtUzrbMF9Pb8SMN25i6IGxL?=
 =?iso-8859-1?Q?b+S9thp+yoGhY56SJIjiPThgBHbXsxceGIfL27q5ztS8moBboQX/bxmmY+?=
 =?iso-8859-1?Q?ObXIEf5uEz8cEDDdROGTB9oJEYMVwUIydJfssMCn0PxSACcNXZB5Adu4HP?=
 =?iso-8859-1?Q?WECnBdR1aTIJH7CJhgFmWbJbkT+3hLFTMJJDJLvy0xHWJZ/Px/Ix4LSzU3?=
 =?iso-8859-1?Q?lHgvbjReteS4UJeC1eo17M410H8tpm8y+riOnr0WviMxSXOWOU2DO2rzDA?=
 =?iso-8859-1?Q?GM7d3HDAz2yttV+fFERbZEbdfI8edphHJ9/ECB+ui4jgln+QgySnsPaJ7M?=
 =?iso-8859-1?Q?fJAsxTXcDgazyHY3R4SPknc3GCiYSwZ4Lwf+mTitTgYk1w166DoAYwVrn9?=
 =?iso-8859-1?Q?22rmeE1ZVRTQWwLHu/ilzXfYsiYTEI2Ex46QhhrbebPbj3ObU10pRFHDeF?=
 =?iso-8859-1?Q?sYpe0WJGH8JdiI7l+vbfEP1rMG3C22Ds5STVSPjcqcRqg2+/GTJQGLHuhs?=
 =?iso-8859-1?Q?zoYADGiM6Lq06Vb1nVEJ70541d56lvisikuzZcyTMTQ+X8jsgcdHC03JP2?=
 =?iso-8859-1?Q?+aqEQECOK+ija92aqrtecOwODN2/uT/PoZlnR9Cz2iz/b/lc4QGT8NgmHM?=
 =?iso-8859-1?Q?7KffiQNQgY/g18VdBckDzrU4kZp4nfrxb4i1UY9BeBT/XYOXgsvTGtOsop?=
 =?iso-8859-1?Q?8R/Pft76EHgTBDwllfGXUaVFczzxGXSNQt7NbgsRyz2NRQrerFJ6vdDluj?=
 =?iso-8859-1?Q?e1o1kBMMF6xqp8ttvmiFU2uYTCBFJ9dloYMigZxH/sMKZljC2hEmA41HLP?=
 =?iso-8859-1?Q?WhqmQNYEqysg14x2a8vixWTIzlQUhAiFETmLuM80LIpkXilh3Jer+33EHT?=
 =?iso-8859-1?Q?Thr1nK5kY7kBIo3q9EJ+zZsU0DxXC97/uaAPJIYzKHRpfNVxFgJOO9xnnz?=
 =?iso-8859-1?Q?7bfW8ICK2tcq6Ghnf578Ud1lYHYWihdpbG8kBqWuGG2UVEUiO+JQTJjiP/?=
 =?iso-8859-1?Q?CcOBbytWd8Qhm8/T3XQ3d00Z4EwSFETLZZgW+wk+bIrSgDbetUmhFQG8LC?=
 =?iso-8859-1?Q?BI/89JA1fyAIqc4Y2/bJnxrGVtCQ3K2MGeTrsuSN8A6U+tgAW6Ca7ZNFVU?=
 =?iso-8859-1?Q?pAy/tlXeHd7nC4thyMxCQ+zqHYEhnBUEA3LUmvBN3JDnPBWsB+FJJIIv66?=
 =?iso-8859-1?Q?2xstJgiteXo14ZdrcVaT+ZmHGNTfyLWNZzVFkNIgDm4DCiJ1q2I18rameB?=
 =?iso-8859-1?Q?f+n8Nc/iFXxts2RK2r1I56iWzwSTMCMook5y1ZWxLwzxJLGfLIwnWlKR9f?=
 =?iso-8859-1?Q?MMYuTEHNoL0DhIMSqiJ+BeUCdVjTO/8A8Jt1O/OfZuxKSStSBqOwuxM6W/?=
 =?iso-8859-1?Q?0z2BB+l7WF0M0Cy8nU/6CmFky7avu+dPhUs2t+wRenlinPkt+MGFY5+/mQ?=
 =?iso-8859-1?Q?E7mHIqzhtNRHouTL63efZeYPY2pmP7g+yF0AoSHY/fTIyddQbseqInHqbV?=
 =?iso-8859-1?Q?1TNZBEl+aITIbFACyrgeLvO20Iy2ijTdPGeJueVrgNkWMmTQK8XcpzcPt7?=
 =?iso-8859-1?Q?WSPBGpVvOtVeDpMgfszwsW0H+JnB?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:14:37.2451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b75e00-523e-4b92-3933-08ddc2f18798
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
Received-SPF: permerror client-ip=2a01:111:f403:2415::617;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Hi Shameer,

Thank you for sending the v3.

On Mon, Jul 14, 2025 at 04:59:26PM +0100, Shameer Kolothum wrote:
> Branch for testing:
[...]
> Tested on a HiSilicon platform with multiple SMMUv3s.
> 
> ./qemu-system-aarch64 \
>   -machine virt,accel=kvm,gic-version=3 \
>   -object iommufd,id=iommufd0 \
>   -bios QEMU_EFI \
>   -cpu host -smp cpus=4 -m size=16G,slots=4,maxmem=256G -nographic \
>   -device virtio-blk-device,drive=fs \
>   -drive if=none,file=ubuntu.img,id=fs \
>   -kernel Image \
>   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0,accel=on \
>   -device vfio-pci,host=0000:75:00.1,bus=pcie.0,iommufd=iommufd0 \
>   -device pxb-pcie,id=pcie.1,bus_nr=2,bus=pcie.0 \
>   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on \
>   -device pcie-root-port,id=pcie1.port1,chassis=2,bus=pcie.1,pref64-reserve=2M,io-reserve=1K \
>   -device vfio-pci,host=0000:7d:02.1,bus=pcie1.port1,iommufd=iommufd0,id=net1 \
>   -append "rdinit=init console=ttyAMA0 root=/dev/vda rw earlycon=pl011,0x9000000" \
>   -device pxb-pcie,id=pcie.2,bus_nr=32,bus=pcie.0 \
>   -device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.2 \
>   -device pcie-root-port,id=pcie2.port1,chassis=8,bus=pcie.2 \
>   -device virtio-9p-pci,fsdev=p9fs,mount_tag=p9,bus=pcie2.port1 \
>   -fsdev local,id=p9fs,path=p9root,security_model=mapped \
>   -net none \
>   -nographic
 
I am looking for that "branch for testing" to try some tests on my
side, but couldn't find one. Would you please share a Github link?

Thanks!
Nicolin

