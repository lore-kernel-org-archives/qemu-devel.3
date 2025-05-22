Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457FCC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBiV-0002ng-MM; Thu, 22 May 2025 15:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uIBiG-0002nI-Qs
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:36:21 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uIBiE-0003kN-4A
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:36:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPJuXt5P1nuKQC/u9XQIWD8ugGPKTxhm/kYVCnI+IqYjMTqRvWthHCENmmnuClzokjaTu99ZANyUSScy65fmpgru9q9MKYxBrpWxlyliwAsd6gHCNjyhIlVWu9JpChNB8OZw5yRqNSx2Cm/eVXblQDYSt7YvJCji2aKAx1PRdNT0fhzNrf8KJKrt7qvPDH6+41I+ErYNKlaj5snJFScACii7I2uC7DxyHrY42taT6OhV8oeAaazPt8RvX3zKGEnJG2BWNNfhPZzQu7t4g9C4cgwSM9HU7IV1c++1p76N2x6ccvvBph3TiGwj/qw/RnlVocpW+CLi3trCZHTOeca+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97Z6H7z9EDuf+IL8C/PCSMONoeGtBsHTgl7n6pmkmSI=;
 b=jtBxp5Y/CidmV3ZN8FCOTAy0PuCYUhsaknErdUawe9ZkwSO9H4XU1rxjdbBMkJ+Y2kgVVjfD6BsLTA3H/NB9aBDlvCUxIGE+v92IutMmaEuSY+W5qskuBbYNW6gbIPocHgkVADnLrfyS2YLqqilcQG/O5ysLornjxVgDOBZc/0msC7GPTfTRWCkUkxhFaB3eZ8cPiMq49fIJlD2nLrunAYY23qAQwbacPoo7CVAmiHCT9DBYN2GYdQINltyppA/Dp6ZhHlJdS1ujZvy0+wABuyYTmrsTb5LUyQ9qKi6RSlOM3UVLwvEyCMtdJdHPjsq9dFBphZ7mwnUQVYOKVk90rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97Z6H7z9EDuf+IL8C/PCSMONoeGtBsHTgl7n6pmkmSI=;
 b=JxhX2is5/KE/k2ytYOfWOwhVcqVHAZ59Cjn3WI+QnvtTnqbslH9vdy7EZOPN7uwUNEYmlbo88DzLZ/nOkfoH2mHNvlaUZgaYzfFV0i/KZ62TrgoR6cPfWwQzNNZFFuRAjrYmooJ6OSd6GF54GngOX+kodpsw5ZuHBQDXsCO32uhWvjGR/K7fULQI7hnyyxEWoYbOy3FZSZI12JfUOXiMS2oKGczNjEouhml6CVtD0bsRiesEnvUikXj6lLnrbA14QCD2qAJXiU1/2ZjHrZ5fhETyCLFPqn74Q0XpuHprf9GPS+gPM7XQLkZ1kpQ46uoEhuXMZCsh4HV8SgPINSBOYg==
Received: from DS7PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:3b5::35)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 19:36:13 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::78) by DS7PR03CA0060.outlook.office365.com
 (2603:10b6:5:3b5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 19:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 19:36:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 12:35:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 12:35:56 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 22 May 2025 12:35:55 -0700
Date: Thu, 22 May 2025 12:35:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device info
Message-ID: <aC98moHCEJ3kWJGC@Asurada-Nvidia>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-6-zhenzhong.duan@intel.com>
 <aC5MVvwPCFertplB@Asurada-Nvidia>
 <SJ0PR11MB67449F7571B0604A8D2522D39299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67449F7571B0604A8D2522D39299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: e334ccbc-e503-4429-459f-08dd9967e913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H7GiIYGi7BU6VSndo4ThtxOVZh3d1YxilAvBA3wNNXeAMgFthaEE+oxyQUWt?=
 =?us-ascii?Q?2pk3kXG92HVG0cgIGXq+7QEV3V3YGUrpxLp2+3DJqGETxI3uYfZiwHovJ+ks?=
 =?us-ascii?Q?oDa/m2Dqk66UgaSr/qUh1Ar3NB2KNQ9zdhxKF+b/or4DfnQZs9DofkR/sls4?=
 =?us-ascii?Q?KAjpKLz7tAsTM3xXkLInTHc4S8W7ETJANu/lbhGYWl4iBuE/NJ30I5xNio2A?=
 =?us-ascii?Q?/XHzww2E7Zr2FS9Rbmn+e7mpYewEetUSjbvyLU8vx/yBQOQlqVKX7yrlvfoz?=
 =?us-ascii?Q?Fx4lM06KiRi6f7jkXbplqWYHLd6r0aFhFIyip0ZNYgB1Mo7EruLMLwYM0TRm?=
 =?us-ascii?Q?whHkpk0PaDCg2tqwnZ/bOhat1081VkbkhVwRgaUBFhnOVnZ1SC0zmeDaxxYB?=
 =?us-ascii?Q?egPDqZ8LAz86r0dCo+aGyUvGn/iw+R6ZFZ0WNzD7F7QUgz1pKqyA5UswmZym?=
 =?us-ascii?Q?Q1g1e9aIpcOaM27lfEDBnCjhdiymAcpTF9yVrdl8PDkDVosQ9/s/0NqRNnyb?=
 =?us-ascii?Q?F63rmGIAnUUiCy4a8TsVd7/aw2DllyDxNQ8qgnYrL6ItScZ5AIWeYz6JA0Db?=
 =?us-ascii?Q?FgsYXjwNt73sm9I0sFT2xqZTCVO64xLtLQvQkaapS6dwE8lih95IaVFPAyVL?=
 =?us-ascii?Q?AlTNux1WCGUE4GF7fcmfmanPGijL3XplCeD1uq/PYD2EjtlwOOBDO7tl4Dm2?=
 =?us-ascii?Q?AurAJvA3nNNlgD2mvYriB7PUccNaPLb/QimbvafG9hBVXPLy+W68d4TzQ0qc?=
 =?us-ascii?Q?YcYC+dmWImdMKfnsL3iLjEGoszIcuqW3I4aIsTFtkTlQGoNKnNibJguOqemq?=
 =?us-ascii?Q?+36pT/CRLuIo+dNcmHnYkG/0GbIcYeJMM9eR6tfaEFTPRRmJiapa+lccqlBY?=
 =?us-ascii?Q?7KXwYECSygUvRXc2KorK2CLynrio9MIHQJPyzinfFm9HgkyI6yW5trN3WURM?=
 =?us-ascii?Q?IshbjNxUZdIwVLE7xGzZokR+IEhAq0Duwf86uAjV9Ngrdg2jyF9qvc7hLycv?=
 =?us-ascii?Q?BRKjvkB/L5lGdR4rj6kkj2vp3r7GtjRkaft7ndM/bzgiuPMwV4TvYEME1M07?=
 =?us-ascii?Q?i0nqBb/yB7CTbl1x5MWBjiEz16oVnbrLkU/vdi2FxQRjF7+Yp5cQdUnEBWOX?=
 =?us-ascii?Q?ncN1bJ6AD2zOO6+i+3/Vu/xt4CIOuM0zJfdn3D1CYkcvefyi3uRqF89tc544?=
 =?us-ascii?Q?jlJbnnlJENWogmp1gQVyANRBhsYLCPEBN1IirP0E7PRwvaQ/vWUbspsSAHo0?=
 =?us-ascii?Q?d7qplkBa6W/4aO/tqrgZV76nt3BOUwuhgBIiE5p6xb0smfeVvpJtQqQxdCUM?=
 =?us-ascii?Q?zQvoL/aVM++ddqGZ0ArHwnrZ1zOnK1r9N4L7B/17ouX+yT5ELbqr88M1RijS?=
 =?us-ascii?Q?eGSzH5qVAih+JdaxCldW0LQcsS68EUJTKyixLE/vUg+Up90DCCarqK//wAUQ?=
 =?us-ascii?Q?5gnjUy+f0xO8Pll/gauV8HUlWzLDABIgWXgqlRtxIK75FowFRdi7zRxu4zm6?=
 =?us-ascii?Q?RQLRoP0uedl9GVazd8N6VKfl/nAo84Nt/3u/?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:36:12.6388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e334ccbc-e503-4429-459f-08dd9967e913
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
Received-SPF: permerror client-ip=2a01:111:f403:2418::600;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

On Thu, May 22, 2025 at 09:21:04AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device info
> >
> >On Wed, May 21, 2025 at 07:14:35PM +0800, Zhenzhong Duan wrote:
> >> @@ -852,6 +853,17 @@ static bool
> >hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> >>      caps->type = type;
> >>      caps->hw_caps = hw_caps;
> >>
> >> +    switch (type) {
> >> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
> >> +        vendor_caps->vtd.flags = data.vtd.flags;
> >> +        vendor_caps->vtd.cap_reg = data.vtd.cap_reg;
> >> +        vendor_caps->vtd.ecap_reg = data.vtd.ecap_reg;
> >> +        break;
> >> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
> >> +    case IOMMU_HW_INFO_TYPE_NONE:
> >
> >Should this be a part of hiod_iommufd_get_vendor_cap() in backends?
> 
> Made following	adjustments which save raw data in VendorCaps,
> let me know if it matches your thought.

Yea, LGTM. Point is that we keep all vendor structure decoding
inside the backend, so VFIO wouldn't need to care about types
nor what's inside the data.

Thanks
Nicolin

