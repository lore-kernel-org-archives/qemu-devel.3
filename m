Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24ECC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 06:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCBmP-00086d-GD; Tue, 06 May 2025 02:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uCBmO-000836-0x
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:27:48 -0400
Received: from mail-co1nam11on2082.outbound.protection.outlook.com
 ([40.107.220.82] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uCBmL-0006ko-Kp
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=av8dLJ4XAMCUKI1t++F9qQRyUwIp+rEy1ADyreTpH5FlatfdeBLLwXMN639LX79ubDoOR0MWYAvn7+ELLrlAeUaivBSV/EswV27WWdQ1zc5BAINSpQFNbznWHMtB+qg/kwQst3RG28VBEBxJXrnhdp5r18rK/Gh6U6XkCZV6HSqSXtmCjPQ4ICPsNMp8Df7tUTnJ9J+wgeQn+6Lzio6+lBcvzi7XxMKlmVMQB7CPntbV5Uje9gwpZYsK+P7FS8j/K1qWNjzAV5/cFF5twjra+Y9hlbrvFHT2sf2y8fXPYLK2l3D7CDgAh8hXQQUHL69CCKDSKCnovwY3x5nXvrnaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbJ3ZV4RxMp8AQHB/xXhN7HSbRagSV8rTsuSURZKOiA=;
 b=A6RVjHT5OAy3ve6vSL/KlVFI5bQ8SYil829EUmOYt2Arn8ptzjVQujt4ju/CPiIQRJlFtIXMeZQqnUKqX9avcQJpV3OLmuY9KVU0AnooZKtwBFAfN0PmUopQiao8h7Ye/3QKKm11uXy64MjQ+kEDxbq6Mq2lg6Wdj1HDAw+7LOZ9/BESGQaJh7+BM1wOJRPhsVmgB+QUO/HJQsDQKsBgRAXTWSuFmTjkrcErgttvM6peecpb6J8hBIJCXqCHESbZ3+G8Mb7vDAJApHKZAvSFVc5c/PQU1hEJmYeiD5xA4D9+iA7vXxDENyjhcg3ZsAp2rT6QBc1I8i5JT1mZ9/xcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbJ3ZV4RxMp8AQHB/xXhN7HSbRagSV8rTsuSURZKOiA=;
 b=V77K2mEsJ7D0qKbNao6ZSk7SKoonxa0EkYYJi75H4nkmbvqcBHvKMNJxZkQCG6M02Hm+RO2kT7U+QLnl5EHn4aUSWkuEsXDijbJXSatCVVbgHa90eL7pIRumOMK2ZwC61RTkY8V9TiWaTLK4L8YSlcHnC6oB3iNUvxJ0HJtR4BQ2pr0u4DOde39xNGkezJDXYuwKEAlxO+2X9l0jNUjBF7ln4hNSqkZX9ikVEcU2q4evxydoJNGGyxRYCmT7U8Cevlc3YBGYUo5GNFj2BA8SELCl3+8tzL19iXWIeN5uv/Zl2wWCfOhc4WWjx42q32ffdw16sWvSfbgE4aoHE9WtCA==
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 06:22:38 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::2b) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 06:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 06:22:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 23:22:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 23:22:21 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 23:22:15 -0700
Date: Mon, 5 May 2025 23:22:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <joao.m.martins@oracle.com>,
 <chao.p.peng@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Message-ID: <aBmqkO65SFPniYgR@nvidia.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
 <82239156-8ec5-4dde-8333-3569146d3195@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82239156-8ec5-4dde-8333-3569146d3195@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: c81cc779-b7e5-4c8f-3ce3-08dd8c666598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yPyGKR2awmZapRkVUxmYpqqcRCvnvqFhd352uH7ij2dxsaiwd/M7dAAbM6Iu?=
 =?us-ascii?Q?fUCPicQH2RKC8QW5GnKZ3gWHSJlStJcF4NtZMaTibHPsdGPVNuVpATRAswVf?=
 =?us-ascii?Q?Bhvv3sERkPxSWnANbzewMVRvH5RjnVMdNhv+HCYpB3NqeTM3hhr/l7PqvbXG?=
 =?us-ascii?Q?YbY5vjA5uNuwVL0/p8w11h5mAXyyikvfxC7HmrawdT9pmYVxAwDp2c0g1ez1?=
 =?us-ascii?Q?6vZlYAwVs0bvWAPZbZd/ICr3/YF99Ux2Qhj7yzxVq2zj1wz1FR9t2aRophqU?=
 =?us-ascii?Q?52XJ29/jypeVJZ8jDxchNNEBSDgpASg4JwUjSZRoDThky2z6vqRNDumbjgvU?=
 =?us-ascii?Q?Zh4wM3IEdU5FTCWYvzTlCk6g2VW0WC3rGMXz2hSRl3jZqPFNe9rtadUdz7u2?=
 =?us-ascii?Q?15iQ+XiDqKbjongoht2Bfe8zEBXZvErEZVMzxizXGNdBOUhRJ4bOMMDFEtKz?=
 =?us-ascii?Q?nKsfSf8Pr9iLIJ295kbeMdZ+tTsmkUgpmZ99yUIDWcBP8nwTf5ZU3RaDlBn9?=
 =?us-ascii?Q?KTarRGnUoFLcCQ6jpe7oL2Y4lgUgfEGXhGT4ndj+NowpE0iP1iechkm0omK/?=
 =?us-ascii?Q?QPwiWQPsFw2Eey+GqwxKGXuybATwqrtIBxG47de5OYqye9+H6cBmDYScrs3J?=
 =?us-ascii?Q?gcJhrTNqAq/LUlmtpmnmR84iFyal/VuPbA63IYoiThYSDn8Gf8Jg23GLUUzF?=
 =?us-ascii?Q?kh7KInUfu7aGfLRtQ8R9TlQO2mQKYKRepDMND0gxNgnwIDFchiznGYVLMHfS?=
 =?us-ascii?Q?tzsqAW9GFd0EqruKedHt+yOD+jpLzruvodvXOgYzoRQ6oeRRRycxV86J8MP8?=
 =?us-ascii?Q?tfwd5b8JMpdh4M3f6Fs2aBJHtvdfzLE6OzD2FnRP7/+Nd0nOsfh8IBs8wKHY?=
 =?us-ascii?Q?JE+tXT5XLjj30rdDa69Jw0mSqJpKFSXcbH1/E9Px5ve6Q9ZEHPwJ+0HI4xld?=
 =?us-ascii?Q?8MqNWjiRIioLj2hK84Psrk3ZA2xT8X1NdwLIFxmhI6vssO+qLdfXSmOnLHt+?=
 =?us-ascii?Q?/rG9w3DsqOfDdWxKPd7DwIRrjLt5BycjPWWFfh+kiSbbVgcVCkY6hQ2mt5Qh?=
 =?us-ascii?Q?lGCZFZWmFpbjiWrPsDYCGgG3s1mGBLNNbpVpHa52kp2wl/zcjkiaVVWZzTX4?=
 =?us-ascii?Q?mDP3OUb/0HXAbFtgxz/1jsAJA8VEFqKk7F8hwfBdJgtQrvYk/S1LCz5xsUtY?=
 =?us-ascii?Q?8o8uO1p8ehVZ31Bbald0rkGjASas+637WK8xJPZAhcMMiqQH5iWxOFbpfvKT?=
 =?us-ascii?Q?AanmxeLvNFG6OTaZTKTXSndF6T7OUrt7zpEW1jOYFEQpIqhgHp9zdpmtb0xW?=
 =?us-ascii?Q?CeWqNoZC+a2uPFPs7Zyq4DinJvbgkeoaCG3ff4FW7LLnBWiieKarqlhuNjbv?=
 =?us-ascii?Q?u2ptJT3lFPQ2p+ubbjuTg+1CBQuAkWO4qQOZuZ5f618/Os2uWmpxcoc8+Vut?=
 =?us-ascii?Q?jGGI93w/R3Qu/fRl6X7HwjhAVdJZ5XMaXwgI10idNg7+7JnunnZBj3kg/rAU?=
 =?us-ascii?Q?gQnKyAQ21xXaHuH08pueUj5LB0yEiGOx0qfI?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 06:22:37.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c81cc779-b7e5-4c8f-3ce3-08dd8c666598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
Received-SPF: permerror client-ip=40.107.220.82;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, May 05, 2025 at 06:38:17PM +0200, Eric Auger wrote:
> > +/**
> > + * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device capabilities.
> > + *
> > + * @type: host platform IOMMU type.
> > + *
> > + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
> > + *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> > + */
> > +typedef struct HostIOMMUDeviceIOMMUFDCaps {
> > +    uint32_t type;
> > +    uint64_t hw_caps;
> > +    VendorCaps vendor_caps;

> can't we store the raw data in the caps and let the vIOMMU code
> interpret it via a PCIIOMMUOps callback?
> 
> If my understanding is correct this is also Nicolin's initial
> suggestion, no?

It was, until Cedric suggested to do a further isolation between
the iommufd uAPIs/structures and vIOMMU code, so vIOMMU wouldn't
need to deal with any iommufd uAPIs/structures.

So, what Zhenzhong did is kinda creating another vIOMMU specific
iommufd driver(s) in backend/iommufd, which for now only unpacks
the hw_caps and vendor_caps, and likely will further forward the
caps via another non-iommufd structure (?) to vIOMMU.

It's slightly different than what we do in the kernel, where all
the vendor data isn't touched by the core, but still makes sense
in QEMU world I think?

Thanks
Nicolin

