Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93CDC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 20:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL6OQ-0000HD-F1; Fri, 30 May 2025 16:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uL6ON-0000Gq-JM
 for qemu-devel@nongnu.org; Fri, 30 May 2025 16:31:51 -0400
Received: from mail-dm6nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2415::629]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uL6OL-00061q-98
 for qemu-devel@nongnu.org; Fri, 30 May 2025 16:31:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEM3YfLBVchJAvlj0Gcwz5cJSmvmMruDem043YOhyHVC2l828OskoIxdHxyPH4kaM1TPjDbItPMdeeDStKLv+2N5O+YOzGhOc0KvsmBAQF/R6BC9xgA8BhEh4RDsysY6Ca6d/pWp9faGqqiPp23hFUpE6+SKWw8KR+GrYzVzQN58XSyjc8BYvgXDd1SkPnseiM0XMC0m5n5IgA6v5PMf6OSoXODGOcw8KzRCNdbLh8slk9q+oXHgFPbNdNTvu/mBaYYQY0JCrYGsNuap4t+ct/vZeb7ZQ5t/fCDab8tX2Ua4ZNXBPuMuatkzLIB73sKmmcdLAAh8LlXkye0sQ5GH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvt3sJ+4dretZl7Q8mmAvhRaQ9DSnxp9NrD3P4QYkG0=;
 b=cbX1phWhnKcvepx3IzV8+hPI7budquarMsBlLATFENcebkTAPLfCilEQB+rl3YeVr3vHqCPgTpzIUZRiBVlxOYSJ+GKOuWTn5/rZoMhEKoU9J1YlU4SAaMT7RhJja1TgNy8EH/g9H72lptUh9sMRP5ijAVzH6LMJ5zIrzJPjKIL0+uN/JgXscVAIgAeYcX1heCua8v/jq5qFTo5AXreQUC8xr1JFsGpjlO+i18XKyksr+YJCDaDaogok4v//lZnGcp6iMUCt7FH04DROIc+DYIQtdJdR2UD2itUsrKvF/RcmNYyGJSXQFgpibkzhq7RdR5cVutjvRFZviwpx0p/wLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvt3sJ+4dretZl7Q8mmAvhRaQ9DSnxp9NrD3P4QYkG0=;
 b=EZE6IJ+6mdEzNwo71fsl2pXwHrPo+FqiVfjl85RarO5GfO2oReuOBGAjEKoh4vTZeOngKaYildOuvOtVjI0meNGNpb43k5nvYTDm6yawMf2uelbExd2b+rAtfPLzDiGDUJnokxlKFsR5a3Wrypb4lTzv8yeywHyKKGlqaHvPznyXAOTk/zGz7QMPL25NWgPmHuFzI6uCQlBTPId7O/f+lQlotQPcglrxWH7r+9oikrGFN6AEFs61gpSP+8C3WlOz41rUcXNQ+xoYRz+opCCEJQLvDoW/dLyvVEjn5zu8Def1MDLAGzsAGVPbNeQC/+w0AcK9E5G02Lnr6Zq1C3L/3Q==
Received: from BL1PR13CA0304.namprd13.prod.outlook.com (2603:10b6:208:2c1::9)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 20:31:44 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::ad) by BL1PR13CA0304.outlook.office365.com
 (2603:10b6:208:2c1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Fri,
 30 May 2025 20:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.0 via Frontend Transport; Fri, 30 May 2025 20:31:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 13:31:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 30 May 2025 13:31:31 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 13:31:31 -0700
Date: Fri, 30 May 2025 13:31:29 -0700
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v2 3/4] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Message-ID: <aDoVoaWGIdnQYenM@Asurada-Nvidia>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530093512.3959484-4-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: a292f5a1-7b2b-4f9b-df12-08dd9fb8fe4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bDyoLLGQsVyhL3w+31TOOpU8RMAPypYTko8UEyQRNHRb3cQUAiaXUrA/q6?=
 =?iso-8859-1?Q?d14rIwYxZ0N9Z8IbeV+b8b921yyYvFQXbXVkDPOCez3hoFb1O4Vuzv0Eys?=
 =?iso-8859-1?Q?+WA0qlN1uf/vvhm63lHjqs+bACSIPkWE1BqIPFge7d2v7W/kqA9RTnbShb?=
 =?iso-8859-1?Q?FyZRyPw1/kdf93371SDLfixkf6J8Hu6qPPLB9wNXgyHzD5kknqJvA38w4C?=
 =?iso-8859-1?Q?iQgqO9Ij/Hw/68hgRC9quXsLEFiIrTwVC1Rlm0cBLFmvtDDQeJ4QrWaOHA?=
 =?iso-8859-1?Q?08Spu5os7VOjfsgY/lQRCs++DN6wIY8kjqDY0X0zhjxZ9b8WuMqSqXDw/Z?=
 =?iso-8859-1?Q?a7GdGx5jMJPvN18uJwyMUlVEQsS0P4nPY63h+/E50BKxiUOzCHIGbiVCxc?=
 =?iso-8859-1?Q?Gh+72Sh5RfShr2oh8aVefmUs6a/ZEpITXHMpeYAQC/CfDnp+94QKkiFto4?=
 =?iso-8859-1?Q?GttUamf4/QrFx6S8Dk0pj3gi5drlsPaRmiCKVZZihHbQevXjgc5mAet4TX?=
 =?iso-8859-1?Q?j0xz+Pr3lB3ApEnHnf0aLN6lhofNAAPeQkERjHNOw7hgn2CL86llNL4jfB?=
 =?iso-8859-1?Q?gQYoiigzrZbYAzIAmn9Hcz8GmR/RX57aDF4Q6rmPgvV8hgFzPO/g1p8gWv?=
 =?iso-8859-1?Q?C+JM4kIMVpEl2VbNwbAb5iHgpC4ri73WIjTMMm7G/6S4zXB8beASH2OxUL?=
 =?iso-8859-1?Q?U8hylPEloDmCPb2cI0Iq0oeqar1UBi3eLuF4IsYmfKuzvfngZrL8Jr12aJ?=
 =?iso-8859-1?Q?wa/L3Xx0nNRVbgsm+nBGn2tMdAdz54I9gKTwd70Zp6JJw2wIsA85NzjPFT?=
 =?iso-8859-1?Q?CjXrnu04OFei0d/jgX8ctLBYPy0VaqSH7OGfrZpy6ypQRiW2G0ke19sRiJ?=
 =?iso-8859-1?Q?ZTDmpAHJE1cpleRcesPqQy+BXKZ+KQklf68CZegVoDYkZiwBM4PKUzvb0W?=
 =?iso-8859-1?Q?MDNqUBtuSanyD5JnthuaPx9L0Sr/ospsCGpH2TGJFwtw7qobZ5D0BAMWDZ?=
 =?iso-8859-1?Q?KuglrpTwpM5WJzrpcmEh1ILuFxYFTttWcY/g4Lp2R2iGEf9groILE21/FC?=
 =?iso-8859-1?Q?C8VXOSD1t/5xBvURyXhi1wB2gVYkGH+WWOFDZTNiLDyVKVJ6fQgRG2kNEy?=
 =?iso-8859-1?Q?IfXnYP5Hrd0Am+zxNr/kkqPhyrRR5qg+WOCEr7+itQxgO5m93vSfb7WF8T?=
 =?iso-8859-1?Q?RzCeuQ7AHNQiKMEsKcVVI9PufoVAlEupmG/vK0dQ7gCB2R9uqp+PSJL/AF?=
 =?iso-8859-1?Q?seqwAD2/aK/gfGlOXZ/5zqU0W9+Ew+RyJVqB8eBS5Rey+tJoZORMXeDBL3?=
 =?iso-8859-1?Q?scvoWSCg3PKV9ZabaBtZPu8Ko2LepQUm2mCj8nZWsE9ejMD/T/iWM/QSwJ?=
 =?iso-8859-1?Q?EGUlUtEikRAyGzu+OjD3rJZLuEqJJnR5VCsAFW0XL0dMth5yWUq5xeaR3g?=
 =?iso-8859-1?Q?IX8CcChD5vwFtCo3aQvE8eVakCLCg74A7RGAygCQuK/evIL2C0m+H7LfkK?=
 =?iso-8859-1?Q?yH1DDY53aZoJMnLxu4FIm3W41D6rx48CpKfW00IaFRYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 20:31:44.3690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a292f5a1-7b2b-4f9b-df12-08dd9fb8fe4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
Received-SPF: permerror client-ip=2a01:111:f403:2415::629;
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

On Fri, May 30, 2025 at 05:35:11PM +0800, Zhenzhong Duan wrote:
> Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
> utilizes them to attach to or detach from hwpt on host side.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static bool
> +host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t hwpt_id, Error **errp)
> +{
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +
> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
> +}
> +
> +static bool
> +host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           Error **errp)
> +{
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +
> +    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
> +}

Could be a separate patch though:

So, we have the attach API returning "int" while the detach API
returning "bool". Is errno returned back to the attach caller(s)
so the attach API can be a "bool" type too?

Nicolin

