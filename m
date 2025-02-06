Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEB1C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgAeT-00035r-QJ; Thu, 06 Feb 2025 17:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tgAeR-00035H-4M; Thu, 06 Feb 2025 17:47:15 -0500
Received: from mail-bn8nam12on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2418::630]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tgAeL-0003WE-Pl; Thu, 06 Feb 2025 17:47:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEvxxD6SqQPDWArPjpUsm82tDDsYPX5hPGTRWfMqIOs81xZv+FOglBNnOB/flKCDSH6+enNhgnwBHVwCwf/8L6/1A0fYU68+3kkvEzLHsRRB9+tG0Su3SwZWxuadUdkc/6an3lNrAKVlgWVGLK0aHTDLrlYbqeclohIOZ5zP7ChShnQ9XtHw7b6ovs0pk2qKxDg+0zEPeHvraYcfjpAypu7mOIJTCKSDEI6rZvdlnMmIFlbOavw0jxLnSlWQkgoXPEuiNCKCyk5jS+8bxRaY3wK3lPmB44EpcoH/BPn2YTcv/1ByELKYIoa/G66y08UBiB9rn3beGcHYSF92hEOQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxNu1/q20CiDmE1NFCGByIG00Hpibl86qSQtfE0EkUA=;
 b=rOfPmrYfnvZizQZ3q/WMbIUA+pxplKkfQTXVZjrGbAhhWHw9o3kpKA3B5aLM3Mr17+fBr+OBGpdR7n1gHWReOdV6SEh4WswmWTKlNm+GBcxyzibJzeWWhTpdUpw4+DxdBzIN//wsWV6N5N2Q14YvK/oiUe+l0Yjrom0zTm2zF9Xba5VX7LHnHOwN98VgiTf090uPhq1KsC566dRRvhn/V3tzv7M61mDJSksBT4YHkFhu/j2MkgUbJl9VrWLp710ygiLYP3ONsocNxqKb5XekjaMDv4tQLPXjojilF/YYei0qWmCOPbhdwqJkw7lBBb8Chej0D1zUN3ZyYWHQPcSMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxNu1/q20CiDmE1NFCGByIG00Hpibl86qSQtfE0EkUA=;
 b=FdF3rrbI8nXULfw1QrjSI7TkIC30yN6z2iQzVpEUkeT59+yDr5mcyGrHJqVXKSySdI4SrShaSw0KAEIddpCApyF0C/GaaqddNSnyRy+qnGF5EN4XTY6BESsLIl5OFD90IIfX20ghqrn/cdKA32485iGrC+onMBRysg+nNh7qC20DRGO8ddqJYp/s7Of/Ybj1Q5McSIMDIRLUfNL6rSf66XPpTqZ0Lpd0V/IDV6Q9Bb7d2T2clrqTpKD84tyqNOjg2NtQh/KB6e7NfopwS9x0tn0z4ueWZUSWln+AGKxgm8V3x5b60aeSZXSy67yvestkaCtRywAVwNwktQRMYFDnRQ==
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 22:46:58 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::7f) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 22:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 22:46:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 14:46:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Feb
 2025 14:46:44 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Feb 2025 14:46:44 -0800
Date: Thu, 6 Feb 2025 14:46:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Daniel
 =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ddutile@redhat.com" <ddutile@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z6U70maXhx8UcMID@Asurada-Nvidia>
References: <Z6T3cX_fM-aeYbMI@redhat.com> <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
 <20250206182201.GL2960738@nvidia.com>
 <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
 <20250206203855.GM2960738@nvidia.com>
 <Z6UgKHfGD34K3Rcs@Asurada-Nvidia>
 <20250206211113.GN2960738@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206211113.GN2960738@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7fc22a-3808-458a-b853-08dd47002967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p1nRFIMMtlwdSlJSgdQbrbAMqnR6/+9ytgVLt5WZgFUdjjhWssK5zqRgoLM2?=
 =?us-ascii?Q?2hnceTxo6cmoNMW5JYnoI8Rxfsea1ZThwd2xTIgclvrIFCqgIIM5PEoTG1Q7?=
 =?us-ascii?Q?JDzjQnULi2Isz5nrnnZga7CZpwF3s0ZtSgXEzI9voPredqYcTFNIhciPoZeH?=
 =?us-ascii?Q?oeNlENxYU4q27nOyiOdx9q+qL8wf3Qyx1hsSzt7nNQAZlt2vAVryIsb9t3Vv?=
 =?us-ascii?Q?Ec9qrFaCm88hD7ko8o4r0tg+73strEN1mYRKjtK31tV4RWRpgaC8SVa+0E6N?=
 =?us-ascii?Q?vwkzE4Dh3+w/cLxEw2pksaJvWywxda2caENIfB9i7dxl/F/f7BzgEc53FgGs?=
 =?us-ascii?Q?moqq3HvqEBQczlbLiqDx4buWDKf8xW9p8GRJJNz9/ymcWfFdzp4pPSCx5VWk?=
 =?us-ascii?Q?DvPq8hHv6xjAbYxfkyLMSqP3diNrYa4VQwMKJJO/a5J/7D/P3vflyw4sr7sj?=
 =?us-ascii?Q?4CfqE+ko4CsZ/xuuUxCtiwRRQ0225vsmVhLwuhxJHicAouSJg8WwtwCIK/ht?=
 =?us-ascii?Q?3lE+bYGctOPm7/uKplbYTkg0C1DweEYWNrA6vb2sqyCH6jMlmkmzKK8lGw3U?=
 =?us-ascii?Q?o7cUyrDOP48lQZ4bysTHiUwlz1NUZPd9xYoStb/lqOpFUCQ4s6i+Ejl6dMxZ?=
 =?us-ascii?Q?NTsUteGjDiKXiChbrMizOTtFDSKrNfpIhoH96kq1gJHnQrYrwByHe6p7OWx5?=
 =?us-ascii?Q?QRvYoE/HElk17xS2v0AC6UXEQ+WBXDPAlmHi5KGSZyuj3VXlqo5I9wEzewQG?=
 =?us-ascii?Q?kySVpMLDe8067WdEHMbVtv8kAHfVszEaXrhtxpdy2+2X+iZjn5gXT5TRlKtM?=
 =?us-ascii?Q?3Ia2S2bvEa8k9UZkXx5h/7trBWA0irVUvEz5HFWSMaJLNhIKcdaI3m11bHXw?=
 =?us-ascii?Q?EXhpgDQ/+pjugz1jtGOA7rLoEV+l4VAzFCLkDROULck/ReUWYKwk+4WffngU?=
 =?us-ascii?Q?j6zKZV+Jpd4A49WFuOlnScx+jYiGRvnV7CdOFNt66I4mvxQY7fZGSeMfc+jD?=
 =?us-ascii?Q?vlORGGuaSDnmzQWJ0jmHwgDrCcR2b867Ct36xs1E6gYPHCvttZrdND6NYFS5?=
 =?us-ascii?Q?n1cbOCgK8Ira0bEKBS4Fw1Wwy0D8DoT5033HGzytVoSFOHv9a5KXO4+ByA4U?=
 =?us-ascii?Q?wjPMdq7tY2RzrPnuv3rk3Xl+HTjV+K+1P7vedVtxEx9xUUba03i8UqVJDS5H?=
 =?us-ascii?Q?klArpTB5nGYqWZIMK50EfRDL1IDk331KEUxRMdATHNoetMRszV7e0PW9FIk0?=
 =?us-ascii?Q?6FsCU0N8WQY/1KFNV/w/sBZ+L/aKrbmGgVDd5nyMg7O+qUUnCLNbl6erog12?=
 =?us-ascii?Q?XMWH+Jm+yWeJv3HSPG1ZMnHRYFFpR8NrRvMQMzu6R3wzsqzNPu98vLvADRko?=
 =?us-ascii?Q?OIvCfzN6FvCr7N79Ryj/i/ygTBLfpsWyFCzxNqljryH9AoHa2Wt/00/5Y0iG?=
 =?us-ascii?Q?eopq2hB0xtdycGvZA82BIce5pknIdRf0eKirg7jKWi6vrgn1FcscJxVJ0uHA?=
 =?us-ascii?Q?6koDJGyQ7o+10Mk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 22:46:57.4838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7fc22a-3808-458a-b853-08dd47002967
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
Received-SPF: softfail client-ip=2a01:111:f403:2418::630;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Thu, Feb 06, 2025 at 05:11:13PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2025 at 12:48:40PM -0800, Nicolin Chen wrote:
> > On Thu, Feb 06, 2025 at 04:38:55PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 06, 2025 at 12:33:19PM -0800, Nicolin Chen wrote:
> > > > On Thu, Feb 06, 2025 at 02:22:01PM -0400, Jason Gunthorpe wrote:
> > > > > On Thu, Feb 06, 2025 at 06:18:14PM +0000, Shameerali Kolothum Thodi wrote:
> > > > > 
> > > > > > > So even if you invent an iommu ID we cannot accept it as a handle to
> > > > > > > create viommu in iommufd.
> > > > > > 
> > > > > > Creating the vIOMMU only happens when the user does a  cold/hot plug of
> > > > > > a VFIO device. At that time Qemu checks whether the assigned id matches
> > > > > > with whatever the kernel tell it. 
> > > > > 
> > > > > This is not hard up until the guest is started. If you boot a guest
> > > > > without a backing viommu iommufd object then there will be some more
> > > > > complexities.
> > > > 
> > > > Yea, I imagined that things would be complicated with hotplugs..
> > > > 
> > > > On one hand, I got the part that we need some fixed link forehand
> > > > to ease migration/hotplugs.
> > > > 
> > > > On the other hand, all IOMMUFD ioctls need a VFIO device FD, which
> > > > brings the immediate attention that we cannot even decide vSMMU's
> > > > capabilities being reflected in its IDR/IIDR registers, without a
> > > > coldplug device
> > > 
> > > As Daniel was saying this all has to be specifiable on the command
> > > line.
> > > 
> > > IMHO if the vSMMU is not fully specified by the time the boot happens
> > > (either explicity via command line or implicitly by querying the live
> > > HW) then it qemu should fail.
> > 
> > Though that makes sense, that would assume we could only support
> > the case where a VM has at least one cold plug device per vSMMU?
> > 
> > Otherwise, even if we specify vSMMU to which pSMMU via a command
> > line, we can't get access to the pSMMU via IOMMU_GET_HW_INFO..
> 
> You'd use the command line information and wouldn't need GET_HW_INFO,
> it would be complicated

Do you mean the "-device arm-smmuv3-accel,id=xx" line? This still
won't give us the host IDR/IIDR register values to probe a vSMMU,
unless it has a VFIO device assigned to vSMMU's associated PXB in
that command line?

Nicolin

