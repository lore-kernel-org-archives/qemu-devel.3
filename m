Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2DBCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 22:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vExIK-0001kH-6R; Fri, 31 Oct 2025 18:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vExII-0001jm-0x; Fri, 31 Oct 2025 18:08:26 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vExIG-0001rU-1G; Fri, 31 Oct 2025 18:08:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeIqyAiFsjGwgV3fekGtz3dLPzgQOGBBkvJT1t8pwniFJT2xqxyzpNL4EzzhESWeVAech9wRGmkTnCA+E1wK9g9bLX7gUrEV6Ztzs7r6dh6bw1eYvYDuLAlYeMTkxu82JT5vpBrD2/NnUZS+i0R4yzXL1G4dqHTlck+75gi9PXUnYvF+4DhG2H2RcwSq+MNIFaUllCvze9JRK3gtoIx5egn7URbsUMTsY0UZ8FdXO++NVa51V2/g4Zzxo413eW5JwhpxPMX3n5dCFtVhLhHBPyIpMhL1u9vh/K137ENkmdn4huwCwtApXD1XFg+R6v4byWVbhUU8JM6CAZAZIRmfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlUO6HAAD4xTR4dww1wK5pUm4U9POxNCxy4ysqwVFNY=;
 b=yPUNAqSzfPwDOsgfid0WG3ZjTGtH6X8ZfthsxuEpBy/jn8J0s9/RHew7LbLvjTp/i8yhe7Tntt06CkMGpIrcUwFJT4uIhgv4ivfvEEciNeMXgkW4kbWXDNqd0lXQtmn6FtAEQdtq/fPxTvcLVvzhHHl/V6TqYpekpqcZGUWd2BaVbJS0JzZdjkR8zf21qdPCDT4IgxO9IMLp+Ra31tPwhm9xlcsis4r0mFsZFKbBWG3ynZohf96X1dcwTBUlncM1uJ6BRFtqdNx65uh7mk5Bo8o4wcJqmfg7yUXIsfIO9b2K8CtaKlG/9xx+PAJgtC4o1oHlfH+Bkdae8Xuae50r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlUO6HAAD4xTR4dww1wK5pUm4U9POxNCxy4ysqwVFNY=;
 b=UhoLJXVIFRWPCcWTsQG1eyDNmqBl7fdaXMvdE1C4l4+kKNAiNlJ8vzElfco0M4UILsjxn/IGfRm/T0Xth+V2QNJIDFIjU9vgUlWV1xif55ZX2yqcDP/1O+42lRAJbFt14Mc2E0jY18mihab3PIcgP2B0tS8t05OsvkcWA5LcRczuU0zy1Zb4carcPtSNef4DFUHCGBej8cOHwggWKMmXWW+enJHyHZaJ7v0Kt3o1U9aYhLxNFTFQgGPtUa/Z0y7k1EQJEIqR7fHYFMYgraItEjnHIKWaV9oTMca34ZPee/zRbVsS3E5aO7m9deSLVRS/SdMc+EIMsoa0lwDoD9sTgg==
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 22:08:16 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::4a) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 22:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 22:08:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 15:08:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 15:08:05 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 15:08:04 -0700
Date: Fri, 31 Oct 2025 15:08:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 12/32] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Message-ID: <aQUzQzxV9u3G/4xQ@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-13-skolothumtho@nvidia.com>
 <aQUx3e2ZtJKMgfnd@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQUx3e2ZtJKMgfnd@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d762f37-6b03-4b0f-0c24-08de18c9fdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7pN8+VbTCnQiyOnXkZSJpJJ1jViFi0VGQNWl7wrozPB4v6YU0OHnkeUNQKkG?=
 =?us-ascii?Q?ynwT7Nl2r/psqSTCyH4+lESCWfK2xd0cQ1XdCtz4SG5V3pHxtc02fJAVznsi?=
 =?us-ascii?Q?522f8cOt5tXhXmUhx+cbn73XtbCunMKsGYU6DvVa/rX3g8pFfXEmk3cgVprG?=
 =?us-ascii?Q?Km6vINRuJYsLMPIUodtNggH7q+EvHkdcCjW1/WIXWY00+/+29NBGwhP8ovic?=
 =?us-ascii?Q?HREU69cnbzkDyHH399pLRm0lfW5YDqs9LBzmM2zvj7xQvucUvFImu6z+dsEc?=
 =?us-ascii?Q?Mg6xbwnZWtsHUH43sVchP2VRVRdFFgUoKn05PzLHDpxoGEBCsKEjUJ6CDuQ6?=
 =?us-ascii?Q?gj8OHUVeYebWQnIMvolMs3PF+CfwB7d8mCGa0UzFEVmCUVP5di3rHi8tK/cQ?=
 =?us-ascii?Q?CdiLal1aFDXQZw4MT8GEFFrD34UqHTXtJT69C8leTUEwT1d4yfp81jLFRppR?=
 =?us-ascii?Q?0tjpXQwaAFYTwjDapsQJdqpiHJub3rBnqAICegAfbFBBbPXvXYl0tOK9twMN?=
 =?us-ascii?Q?P1gYmOxzZ0Mc4rRJ1TeX8CMLbVYasau1OvNMYOHdWvQarl6HMny6ZRLwDhpt?=
 =?us-ascii?Q?cQeYCXm9fX6NXVTWeEr3CwzstOI/Q8PUjYwlk6EFYYEyN3zFfqbUO8JM2z5X?=
 =?us-ascii?Q?47/wgllkfhlX8Ny0Zg4fSgmvDafKK+OjViAR9zSZ0E8JRYEgUUmhnz8ohtD5?=
 =?us-ascii?Q?E2LQvJDZ1r/3DZVeyOOYQ9/8WFRay9KnH0kkUUvJrsAczlY5liEzr8/zflcD?=
 =?us-ascii?Q?EAZ9cNtOWhJWom06dO/OQuHeaGgDj66PcBF+eT+I9STnWgJSkNMqJqLHkHw0?=
 =?us-ascii?Q?eDNPTS2WeXIpO1BBnyEVBT1wBOXfrFQCqoHC/mGVX4nEBzLpNeCeniL8U3hd?=
 =?us-ascii?Q?E13VV4+yGFVtNxItoKXAp7y/d3IUCOckzDQaXEotolnxmSLm6ayH/5IE9+ub?=
 =?us-ascii?Q?LsgkEbs5K+3TdWH2u2ja2OzrOvC8WCPRtot55l74ufSSPL5/l2S7dBySvEvl?=
 =?us-ascii?Q?FKXN2dPEKouRlwPmfLbOQjtXZjNwgRPdwlJtlsBFzqqcSeMAnNDDkhHPP4xy?=
 =?us-ascii?Q?ONUntsmyb/k4xII7ta9P6BDrNt2bWNydF/t4tL+68iqcSLQsXp7e+YiWAhHp?=
 =?us-ascii?Q?dwQj2TnSh8ijuTA5Ci0MmnzntyGNO50BXtnyrbYXwJFbuk6mldfP+5qDDeHW?=
 =?us-ascii?Q?zL/qEcZcG/psN5kG9XLqv6xTPUP7UXuCdzvWzx424f76W5pTyTPZB48P77MR?=
 =?us-ascii?Q?voTKOKlY7H5zb4IJ9j+I60b2zMAvV2E/ah3yKj61+Z+vfIuNE0b49Np+DTHo?=
 =?us-ascii?Q?C2/J4bMFyHY3Sv8DR1T7ebbEKu7W7zU3CmKbA+aE/Ol3Rwvb59wwkJpvg9b2?=
 =?us-ascii?Q?NqjzFtD8roW+5MdrJoG4R04By7Ob5IR2p6jhKYoHRXxie0oW2MdBU5WlZsDH?=
 =?us-ascii?Q?7MFELguBK6j9f6R3IYPe++ln0RWOoG9NGXsf0152lLP/gxlmpqA0XctzxFQT?=
 =?us-ascii?Q?vZjn1FYz4nPOgUfQAauY/kfYA/aClAgmQIl5FmN8tqa00UbbEXiDMKoFDL20?=
 =?us-ascii?Q?HkVtvbKxUH8N5AB+RxM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 22:08:15.7201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d762f37-6b03-4b0f-0c24-08de18c9fdd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Fri, Oct 31, 2025 at 03:02:08PM -0700, Nicolin Chen wrote:
> On Fri, Oct 31, 2025 at 10:49:45AM +0000, Shameer Kolothum wrote:
> > +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> > +                                          HostIOMMUDevice *hiod, Error **errp)
> [...]
> > +    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
> > +        error_append_hint(errp, "Device 0x%x: Unable to alloc viommu", sid);
> > +        return false;
> > +    }
> 
> And here:
> 
>     if (!s_accel->vsmmu && !smmuv3_accel_alloc_viommu(s_accel, idev, errp)) {
>         error_append_hint(errp, "Device 0x%x: Unable to alloc viommu", sid);
>         return false;
>     }
> 
>     accel_dev->idev = idev;
>     accel_dev->vsmmu = s_accel->vsmmu;
> 
> Feels slightly cleaner.

Also, because we set accel_dev->vsmmu under the hood, we missed
"accel_dev->vsmmu = NULL" in the revert path and unset().

