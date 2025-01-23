Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A22C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasmA-0005JX-4K; Thu, 23 Jan 2025 03:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tasm6-0005Fs-05; Thu, 23 Jan 2025 03:41:18 -0500
Received: from mail-bn1nam02on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2407::606]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tasm2-0007Ns-IZ; Thu, 23 Jan 2025 03:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqVAzULt8nJ1k7REzLm3OcTtoZuASkSfNNZ2A/CR59I166evddW37Y3PVW1QagXQS37oeQsNUDIaT9MMI1dbqk2RUSCZpDx9tM2TL5+t29eVGnbzeA4p5IJnAvsBtMEzQ1u7QGIyEE7+o+DEDxMJ72JMbby+m3ogB5eKxFQXqL2/1kykLz4vzCBI0YQPf2apXqtxEBAg/+hsWDJFF93JDMC7R7X+d0ReosjwSa2WTGYzlf2khZ92kHc4n85FsRrV+j2odsTL/qEuUBjjpcmUj7avcqcxdTtn15uBNRLZmcUy574CIt77LGnZ8Xq53V776/ic+p2FPcrd037K50cabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp8iMNXYfk5u7Jkt8jG/HytJrtnpSKp1jdiChJ7l0ic=;
 b=VLxK/fH21mc/9wSSB8OqcnC6qnqahmeGzKifdesYNKQ6r30K531+ESx1CuZQkxk3yhk1Bb1cmkqfkd1K5rVjoe0R+iCcH5sTC0fJNoT4lrpGjECdkdyNyDAjgwlc4HHRRCHeo4eCJqcZQrFaIkLMwtMjcFHh3FUAc+GuhY4mq7v6M2b1dfPzL/C7U9SfauOUHB1fev9DJ2ndXKLJ5OFKzFH0BPqRrNG3gIgP+Bc1gnlNTSXEV/RZpiEA3EfmD0C/EMuW0fbCIo8fBO6d+EHbCIetcSnQkWepbacWKdzRepTNy1zOSBGWNv29Xkadx08VdT5pdHQc81Bd5IGpaLGRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp8iMNXYfk5u7Jkt8jG/HytJrtnpSKp1jdiChJ7l0ic=;
 b=MhR0N6rlIfAG0sbsJpk7gfz9qFdaBmpXIxGtEKCJlJuTIBmAnca1wcZlxj5I6xGAhupgEDyOPxMUJofKd2jA2ClluWvcxTSib9FuYNtmcdV1I1Snt4TdQtYhID/R2fmDStw+5OMrPW33qq612r9dP5pE/Oxv0R7UWVbBCJPy9yPexI+3mlYs1rlJ4jikpHPRw6SDXcV/r3z1k796R+EK8e5aSBgHkd9URLD15ElL1Pg09SXZ5LG6vqDck/VNYrVinAY14jvV6RLay5N2BtimMwHfb0bNVMT04z2yEnvQHxO9g7tUZCt+pRFaEg3G/7Xm4QvMs93CsJz7Cu/vPTV3EQ==
Received: from PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::8)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 08:41:07 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::79) by PH7P223CA0007.outlook.office365.com
 (2603:10b6:510:338::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Thu,
 23 Jan 2025 08:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 08:41:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 Jan
 2025 00:40:49 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 Jan
 2025 00:40:49 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 23 Jan 2025 00:40:45 -0800
Date: Thu, 23 Jan 2025 00:40:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>
CC: Donald Dutile <ddutile@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z5IAiw2eGPrHu7tu@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
 <Z5HBJOgO4tUJApY+@nvidia.com>
 <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 302642d9-b1f9-46be-f41f-08dd3b89ac9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z00sQmkLn2fRuCMAO85A+gkbK45OPNhFmxiYBn6nUW9FtLXkb/GK+RouP092?=
 =?us-ascii?Q?pjAAMEXnt/Rfe/BJ9HZifdTlnRQOpPlc9qSIFLiZgTcvaw5QRmyWuZPTGf+s?=
 =?us-ascii?Q?91L/RRCuXZupVrjQcyIXlHIzV4m3yi/aZmw1gHHOjbAomWGGYkoJmZ6RDY6b?=
 =?us-ascii?Q?gw1zZlp8iN+AGkePAzVpEKDsQXnNCVdevXiahb9dHc48gKiUtZyKSAdhdazE?=
 =?us-ascii?Q?BWHK3y/MewSv04gF6ez8C8IaC7t6Ykl0m84ob9Z8QcXxijOyc04DHMqPTYO/?=
 =?us-ascii?Q?iwoYbdrVlmEanuPkug+haZIlqfYyeOCCuf9sZwaWegyIr1QrTyRS0NRsrmtn?=
 =?us-ascii?Q?Y5Sk4KsMIPCj00mfTZronnqyUxqPw0rnrVKGOKN3Pg5DdV/1Btbunxm9hEv2?=
 =?us-ascii?Q?+gXRc8/htduNhNNEmCSfjFapWgBsowP9qKtfCRQERfD34HIEVCjFBGiYrJlN?=
 =?us-ascii?Q?ifY3fUKuaaHrOzIpCLqmNdVV9cpTZKtHZJxHsf2mbsmAu1U1lJeHgCEWRHVp?=
 =?us-ascii?Q?Zepaqfbrdtls9/z4OSMGBtxeAdP/SIyqv0RubvaJQdvfaaGT13WdjTrL1CPI?=
 =?us-ascii?Q?f9EeGofhT4ExYmY4gF8OZFfwLsyo/BWADhRPT8SS4Gtnv88DVOrDRocBCuLi?=
 =?us-ascii?Q?QqIgyhw6BWC4Jc3wszK+WCCl/a87DfIn/xfuEZ5n/a/XeVWrhdHHsMoEGI0c?=
 =?us-ascii?Q?ol5Grbwl1OyQM6OUZmvG9VLqUC3QYwAIDmrMIkXNxEN9pfzlZTnC1kH2VpfI?=
 =?us-ascii?Q?DwVcaU5XQcenwkPlLxVL8K8eSaFqLuXmSQvJbM04VNYsq6v6nLihx8DeGEvo?=
 =?us-ascii?Q?6wiGWf84i9EPjRFnsUj54NGmCJYeaGd5kfaMH7yPVhZUGWzHgcxBCPF94R7D?=
 =?us-ascii?Q?P8PgpIGxUeAJ0XasBy30olRIfK0ZfNoXBUg0dTq54fjD3bqeob7Bu6clYSFG?=
 =?us-ascii?Q?UMIvvyXpkk1dQnM+nTGKsq3B9gsUnPCd+azWn4SQfuLcNR1RxThJk8Te6pp9?=
 =?us-ascii?Q?WYLjwua7MHvXt76RzxFdYnnk3zbYYRnnFSJ8tHgS8scBJOQMYpEVxS2c2xJz?=
 =?us-ascii?Q?Y8/CtVYN1h6h4X6yjWJaHSSH+AAvoPTCo2BL9Wk/eae5u7RLveC6Ynf3SRDy?=
 =?us-ascii?Q?TppS8dHcsAxtcWu/uBgwOXf/xDFPsKHD553ioMMpBCxtV29VGgX/s7psTq04?=
 =?us-ascii?Q?4fjNuhJu8QuopG1kKohWUIL2Onk3TZuJR6+okfBZWf5Cyo+61nGJ+fZWeMg/?=
 =?us-ascii?Q?l9/C/ALkmfXxD+4V5gpFlMwjCD177M/0zkGQRKS+YGtwZCMhMOm/rsbx/l29?=
 =?us-ascii?Q?LNWcq3nkglpiytBZq7xMKtorluDMHSXrjK5y8NvylnK6BTrF0fSzh3vq5DNt?=
 =?us-ascii?Q?5bEHXEfojJeWMQA7Ilutra0x0fLlu4u+iWXtCAASZbacKDOWFQvuV2u1/MR+?=
 =?us-ascii?Q?FDEX3tUKpUp3B7w5qP9x+qAeB2uue8dfFIPRxqw4V/CBmHyQm5YtDmEfJ7m+?=
 =?us-ascii?Q?DD8GzPRBG7p3oeU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:41:04.7728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302642d9-b1f9-46be-f41f-08dd3b89ac9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
Received-SPF: softfail client-ip=2a01:111:f403:2407::606;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Thu, Jan 23, 2025 at 08:28:34AM +0000, Shameerali Kolothum Thodi wrote:
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > I wonder if we can make some progress in Feb? If so, we can start
> > to wrap up the iommufd uAPI patches for HWPT, which was a part of
> > intel's series but never got sent since their emulated series is
> > seemingly still pending?
> 
> I think these are the  5 patches that we require from Intel pass-through series,
> 
> vfio/iommufd: Implement [at|de]tach_hwpt handlers
> vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
> HostIOMMUDevice: Introduce realize_late callback
> vfio/iommufd: Add properties and handlers to TYPE_HOST_IOMMU_DEVICE_IOMMUFD
> backends/iommufd: Add helpers for invalidating user-managed HWPT
 
> Hi Zhenzhong,
> 
> Just wondering what your plans are for the above patches.  If it make sense and you
> are fine with it, I think it is a good idea one of us can pick up those from that series
> and sent out separately so that it can get some review and take it forward.

+1

These uAPI/backend patches can be sent in a smaller series to
get reviewed prior to the intel/arm series. It can merge with
either of the intel/arm series that runs faster at the end of
the day :)

Nicolin

