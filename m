Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3232C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQhn-0004Ux-7q; Mon, 14 Jul 2025 17:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubP6C-00064b-MY; Mon, 14 Jul 2025 15:44:31 -0400
Received: from mail-co1nam11on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2416::604]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubP68-0002SF-L2; Mon, 14 Jul 2025 15:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGtG8ZdbtIObUZ49ZuOPqrE1Trvpc+YTz22/79Ko3F+EAmzVO/XgIIZiDZPJ3yIgZy1h/EuK8F1J3Y4x74v2p3uEqEn1vxZ7arQ/yyu0Iv8xmdWznZe3AGfbZ9U1bD4VPLqNkb4l+ul5pUVBJfmWDV8ykDZoK2IHtN1N6O9yj6GLYA9aLbc/rdVVdL+NMgCWGXE/A9FjS/I4DslkWpvqz2vz5tlU4Uu4/L6Ugfoz7LVg5Bo0T2K9LJBJe1ioJhtzDndXYFfGUAeKNN5N5ssH7E5Juea5NYpGVonZT7NFlJZIhmABnZpaw6VvwMxDaY7H7KVdiOujalcsu6rStk/FhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8RT/aOzRa78UU7eePe6CuaxUhnneHrQB160yssSJMM=;
 b=h/L7eYKQJc+ltiqGmp2bxMLFhfL5LhR285EJahgGZMLdwYMlU8gliyc0sIBkzdAgoAkONR+UEmQ7uUMw8fcpD2gBOFjx0IFYG0x7sKYCFuO/PgHtPQuSCaQiB3LdQZ4/0LspUQNbF2uOMEqvc9k/B/m36S/eXrQ6L9bjCZoDGRQ4Z2XprI/NAPh7c5w9uxfB3nJXEKkeCZOnt3sqojidDTszzzDtDKx2qs6kSm1EbJcr8K4N8K3ZVjL4senOW+S6EnxWg+OYqBhU0N7NxSl7VRBqRGXkHwZWZo4agZMCOo0syT1RlIAApSOooW6M8A4s86/cURvUrHgsY1DX1CwZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8RT/aOzRa78UU7eePe6CuaxUhnneHrQB160yssSJMM=;
 b=eneTKe4VnsaQBQhVc26FWuIYcJlDtGnPhXmc15sfydRad5s7TVJIBxrEDBp4idIXMrEFt8OoBpdlDmhIhRdCoe8+/AUBmDOIgHTstuV/sxwvtgaABJW0ptaWvlI0vVmAoObcWTyk0FLuVZkObqarv1RYosXbZvp1vlW7esi4+OLtt+1i5AIhOPCHjiLT5C/aHer9OxEy1d2UhElhYfErGnC+qzC7vV0NbuQbRCfW66j7Y7ZdsZFVb/BIE/Y/HRaIsfx7JonTZ1LjY7T9iWmIFmOlfVkNygkCofUXSEJbBgXqkRAXHItSXsjiAb8qPCMsMMxMLodoOZYpnee2URDuog==
Received: from BL1PR13CA0413.namprd13.prod.outlook.com (2603:10b6:208:2c2::28)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Mon, 14 Jul
 2025 19:44:09 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::24) by BL1PR13CA0413.outlook.office365.com
 (2603:10b6:208:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.15 via Frontend Transport; Mon,
 14 Jul 2025 19:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 19:44:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 12:43:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 12:43:51 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 12:43:49 -0700
Date: Mon, 14 Jul 2025 12:43:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 10/15] hw/arm/smmuv3-accel: Allocate a vDEVICE
 object for device
Message-ID: <aHVd9Gk89DgvRt7m@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-11-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-11-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: f15281aa-3282-42be-b9bb-08ddc30ecce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qOqVGZR4AsV19raKNrVxjpIHykosdKamVAV+MCb0OP2G6JuIn7F53gTea7vy?=
 =?us-ascii?Q?rs8DkNnmC/PhLMuMrBMcgU3lc1DHYHvbRPS5O/nUD38B0tis8wAG178FAweP?=
 =?us-ascii?Q?MNHrbfKywUF0pV8p+bJfqHiMPR6DG7FxIFpZ2AzakXMqyTs1o9EEI/f3rs0I?=
 =?us-ascii?Q?FewlOBWC29wUNTv4/lFZhwdXq/644gHFxDjEpNvI15iMySbRShpVoiPoAu4z?=
 =?us-ascii?Q?hGsCtkkg0ufMC0HftFe8YEdP357AYniSD471RrRaZ3+8wikfiAQlj5pohXfc?=
 =?us-ascii?Q?kGmzyVnyJiIjQ8N0f6tHkbXgwORV790naw4RL9GXYvsaWlOSz8B9l/eAAuAv?=
 =?us-ascii?Q?XUW09RNu7jhft9sTDjL23HQ/NN1zDxy3pLacRBqtUqk60ef72Xra/fJo9PpF?=
 =?us-ascii?Q?2ccUMjkrtYAmuaMcfHxXc3VlryZxKH6+wDGm0fM8lMmpJVBjISSVA2EzGpVQ?=
 =?us-ascii?Q?wVh7BAqQ1LMgM5kjxK/P2DlfzuMTVv9WJM4IExn1DAgfjwfidoE2QeF8sEeV?=
 =?us-ascii?Q?0DGHb5NDD5wJZA2zsuhCNlk2b4KKoAPGvhBLvPXBccbQLH7AWHdcxZNnpP09?=
 =?us-ascii?Q?7zPWOp42BAeZhKeIWJrNrDUPx20AAMcn2OIj1x07aRLHP9R4sxbu4T+0M+g7?=
 =?us-ascii?Q?qNFOIt9V71Ob46Kiubill9PHKMbVxoL2o01MOm/h2nCC6HRg8sJL1vslux99?=
 =?us-ascii?Q?EjbIqxr5cfd5Up8KvvALZp1dv2lgUJg84nynWNakUFaR3fSP67UEqgSgDvnt?=
 =?us-ascii?Q?Yex/c02ujT/wpyvxRYXmwOGZ/aSugPMDZaAoM2KKQ8Acl3xBNO+eDDA20vct?=
 =?us-ascii?Q?fEE0svJNlCf/t0UpkEUJtYHDx8dCWwuU2X4iSOFE6QoOEzxMwr7o43EKTjlv?=
 =?us-ascii?Q?RpmrGt1wQsB5YssgjX0JVEcOB1ewm9g1wsccjjfswR/iBrJrfPjX+1eNMBm3?=
 =?us-ascii?Q?lS/B4BCXeHms3rAkGWiA9LH16sJn6wL52clZX2bzBt1CgX3cl0NXAfI4gfzt?=
 =?us-ascii?Q?g5EXTgp+kozazq06m019J5cmDYr9YTQy450H5IlU3Gb08vnRvKKUSZ6tT2B4?=
 =?us-ascii?Q?Q/7eXBqbvPjLrGvJdcWQIUVU3sGZBCAII906lZvG8HSS918EL2BCnqH2/USb?=
 =?us-ascii?Q?9Vuxrvm6q0/+Xvb+v55UXStGAHxAxCQ29y3uWZQRUyQ2XOWN+zBndQOkFLoR?=
 =?us-ascii?Q?68zv4BvsTCSp4W+Wq8DsZfCA+A9/9Cz5wHab+XVA+RuAX3DRTu+BroAKYzgv?=
 =?us-ascii?Q?aTRrUrWxwjv12Gj9EOp93BbgUGwlC2XW3Pvbr+m0a8UzDIulPn+12kPzWCff?=
 =?us-ascii?Q?5tc/M7uNl3jxdo9Qz/WOom1sgIXFBNldfV4+wJGhSlo4gOuncPN75GqN066V?=
 =?us-ascii?Q?snBUBP7e7d5w5OCC4wh0QB5etLIoFYPprJk3N0gZZ6ik2hh6801cGHKi0nMj?=
 =?us-ascii?Q?9mgWYzHL+ucvne5SSvxC8CPJsrUnpP5hZnOuhS3YVRdwt6aMI69YIuCj4f5V?=
 =?us-ascii?Q?wNDxPEkykFQIkDlxBN7qcFVpLXqnqfLBDfwR?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:44:08.9125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f15281aa-3282-42be-b9bb-08ddc30ecce6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
Received-SPF: permerror client-ip=2a01:111:f403:2416::604;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:36PM +0100, Shameer Kolothum wrote:
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 74bf20cfaf..f1584dd775 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -93,6 +93,23 @@ void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
>          return;
>      }
>  
> +    if (!accel_dev->vdev && accel_dev->idev) {
> +        IOMMUFDVdev *vdev;
> +        uint32_t vdev_id;
> +        SMMUViommu *viommu = accel_dev->viommu;

Can we put the viommu line at the top of these three?

> +
> +        iommufd_backend_alloc_vdev(viommu->core.iommufd, accel_dev->idev->devid,
> +                                   viommu->core.viommu_id, sid, &vdev_id,
> +                                   &error_abort);

Let's check ret.

> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 06e81b630d..21028e60c8 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -40,6 +40,7 @@ typedef struct SMMUv3AccelDevice {
>      HostIOMMUDeviceIOMMUFD *idev;
>      SMMUS1Hwpt  *s1_hwpt;
>      SMMUViommu *viommu;
> +    IOMMUFDVdev  *vdev;

No need of extra space.

>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index b7ad2cf10c..8de559d448 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -44,6 +44,11 @@ typedef struct IOMMUFDViommu {
>      uint32_t viommu_id;
>  } IOMMUFDViommu;
>  
> +typedef struct IOMMUFDVdev {
> +    uint32_t vdev_id;
> +    uint32_t dev_id;
> +} IOMMUFDVdev;

This adds to the core header. Maybe it can be done with the patch
that adds iommufd_backend_alloc_vdev()?

Thanks
Nicolin

