Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD552CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNbOd-0003EK-Da; Mon, 24 Nov 2025 13:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vNbOb-0003DQ-PU; Mon, 24 Nov 2025 13:34:41 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vNbOZ-0006y7-Pc; Mon, 24 Nov 2025 13:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVkF0rdiaM83pdyaZMIwc//p9F343kGl2Lkw25q0k6jZUBRUqz9ELkPRfCftArrCxlDUOHO0kIKPQ45WNbsdBXr/eHQCqc2yxruN4mfnYa8NJgQEKB33JnvVxR2Z7s2GMI48GYznT/eYerWRJ1fwX2+2fJeA7HYP7/Kv7827hudUXMhQlaW+EhRjSuSIQIas+3KNWODxci5n6oIwKz1rK6YAafxl64vbIgMMrgnQGnSRsUmkxxU55BdgE7Lh5fZ2DFv/Moh07Snf1PAJ0yzokysnQK/hRcioumYWGfrWKj1v9wFD8FIhfJY4x5uCaq/JfUvmf8pMeI16Yz6+Vl8t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQGaykcvRTtqWVT6w3ZIzpZfvh3DdgslLvx0qd74gGI=;
 b=HyGU2hAX/4UVCOeYqk6fjKZH0AHWVtSgFR7GG1u8s3wjhsqq6w/nk2BBXIRn2ana4YpQ8Q+R1z4KgVPnY76tbw6uRKfG28lVKXG8vzKakQVZRLwIuvE/gmODF/YWljlWyiWHbGg/wALK8AYrJEk9u7VoWYO8/pMUS2+83tRWuo9EVP9/oHJQZi4YO1vrlJPNjQGrEo6CeAF7lCNdz8NvCSgjiTIKTld9bax0aqIDw6uOSnV/NDbTQ4VLLLULDtSa/qmkZhpvtXJaW6EyTJY+FKJ8I01vHqZFVDQt8iaWSZLKjiRs3O2ZwWzIt+mhz/fHFtzPJvKmM2iRfQ3IMlASpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQGaykcvRTtqWVT6w3ZIzpZfvh3DdgslLvx0qd74gGI=;
 b=aTWTEXKGKvPsss3CHeaIgTbaxGLeNV+5yjvlbCSYo/xGedv6S3PKrEmVH30j9YSmehaF6eOhvUGW0YKg4EH596ullTjGgK/jlz53xWp/xxJ4cT+2owDktCYPPHah60dsvq8qWdScI9MQGUFTrG8urnCqR90phEHPQcpqprOQ3W1BP3lpmYTqVCRWyRqQNqVdDiWvKmDpeXbZ4Lut1S2v3uHBTPfeDDCXO9U5/RoDS3JCWyGPkPfgOImmnd12TxcIoo0GVn8NhfSn8Au1EGSlZb2FtZL22pejguxqSkkzxdqJw00D/APMtRZwIKmx5p9vTybuutLTOIeXKaRdp7wT6A==
Received: from BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 18:34:29 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::6a) by BYAPR06CA0031.outlook.office365.com
 (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 18:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 18:34:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 10:34:17 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 10:34:16 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 10:34:16 -0800
Date: Mon, 24 Nov 2025 10:34:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Message-ID: <aSSlJukXV0C48pFX@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
 <CH3PR12MB754869BFD4D1B5C65EE30AB8ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSCnyrcIe7kqIncW@Asurada-Nvidia>
 <CH3PR12MB7548BCF00E128545097E3DE4ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548BCF00E128545097E3DE4ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d25fe92-1a25-4946-69ba-08de2b881aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Aorxx2/Oa+BPOSuQ2rv1Xo5L9tfNs/7OyfdlCVxXtzElu4cjiJUnfcxpxoVV?=
 =?us-ascii?Q?ZEoUk8iMCRYU6Uauzb7BLl2BrQHByVFWFANUk4sBK9rloCpnI9ToNEnvvAzt?=
 =?us-ascii?Q?DWdp3qi9E5xU6ZJHd/O2RypmsuPiLbB0XMjocbdD2Kg2evu+HamAqDNX4npZ?=
 =?us-ascii?Q?g1bEvjHIvnIe4q0Mt7pIQbTW1XYt/k5ZgzvEeONJOt3cSyhg9su245Uo6U6p?=
 =?us-ascii?Q?8mbzzYbsuN9uy07ZPLnKCgz7GUxONq0AO1d4LpirviZUc17bPq/zSAbOknVz?=
 =?us-ascii?Q?CgdweyYUDe5rzABCda/7lMzoQ0jCyVd4FVXtcyh+IYTQusXjJCqMnEET2qAM?=
 =?us-ascii?Q?qLGcmHdL5kL+Hn8RA6iv92XrPU8czO/nJvnz7BQyw73eflFiOVKO9eZrWXbF?=
 =?us-ascii?Q?X5VHe9nBpDfcOmwwZCwbAqk5AT1g99HTsqCG7GPybhadsLgAjuSGHdzuZ+94?=
 =?us-ascii?Q?JsqxJqBFI5TVqareyAUF9iKEhlxHMsTQlCAcSJLAq1/QFdM9z+K3MxMzLhTR?=
 =?us-ascii?Q?NvIuhcowRRhaJYEEAhxNvrB92XVOGjyBUULNpF6w0WEzLHJtgW8z4oNSAj5x?=
 =?us-ascii?Q?fsOFtJaVPn1syOJPksjbguUXfcKpL81lAmpkaVZBKQ08y2xXMqI3G2kKDAmD?=
 =?us-ascii?Q?S8t2ihmiIoCGya44zDD63kDjT7fGHyQxiOAG+/HS2O0a5TH7v3Xf14Bp/0zr?=
 =?us-ascii?Q?qNIbA89LzzW3reskuv2hcCiC5DP3lEr9XbaMVSYE+y6qHDE6Stn/xvs/mOfo?=
 =?us-ascii?Q?ZGDVemNCEKTIQHYGfoO53al1JmOSS4v2nPw8zWFQ1jccZ8jM/ilQ8xauIllK?=
 =?us-ascii?Q?cLo1UYu92FzzStgFy3skLN59FmlC+5fZlVZrX6FIlJSi2YpuO0f2U8WBtKzs?=
 =?us-ascii?Q?Tah052RW3fzEOmxRUVtcO0f7VQiLxs/KdCgv4fG2JI68VImbszI2OR1Fppgy?=
 =?us-ascii?Q?+sjQlNMvk11bdx0ooC4thaOXQ2u0rCGHuAW85p3tuGCxryYot74pbS2lOzPG?=
 =?us-ascii?Q?tsHdvYPbCz2gdpRiMfXSLCmg2hl91aYpgAlF8XL+KBTxGb1pZR6Wgwx0mJGn?=
 =?us-ascii?Q?c0N9w3kCmlmwIyiPezgtcGfoUsmW8DsL6d8TqH2+U8fTAIfqS1rMVev80Vni?=
 =?us-ascii?Q?x4raFmc2/tQVs4LSkmMcuUo6sbzInn26YeHUcWrfoqVAZYQXa9t3FTzYhPqf?=
 =?us-ascii?Q?CCX5VfIZjx3dsFbTR67jm1OZtUYa98dcb+Wi87pfNXtnekdjRg8jhFYOm6rV?=
 =?us-ascii?Q?q6sTuU6XnV5tbDmGtSE34byRVnT5NzQ6oms3fQ8IyfaVG2zCS9zU87rVCnnD?=
 =?us-ascii?Q?1g1fopBN9xqcSA4aWkr5q5BhgayuiLPxl3MM0sq10DnX2HejS7zlCopb3GuP?=
 =?us-ascii?Q?NDHX18hbaoF5G7jBSgBCDBbINLQApO36+iEicehnrtbPHg4u1LPhv5wI+fqd?=
 =?us-ascii?Q?EWNWjm26vtbW3xYXYeV5sO5qVQVuNEQesiDakTi8J42403dlMu3T8/OfBj3I?=
 =?us-ascii?Q?xfKZqJevvz/mnLrlUM/VuUWNUjWnc5SC57L2U5pJ413U+AdmHZmDv4GUY7rU?=
 =?us-ascii?Q?xrY6hSLsXhWeliut7bo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:34:29.5711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d25fe92-1a25-4946-69ba-08de2b881aa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 24, 2025 at 12:05:38AM -0800, Shameer Kolothum wrote:
> > > > > +        if (object_property_find(OBJECT(dev), "accel") &&
> > > > > +            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> > > >
> > > > Do we need object_property_find()? A later patch seems to drop it.
> > > > Perhaps we shouldn't add it in the first place?
> > >
> > > We need that at this stage as we haven't added the "accel" property yet
> > > and that will cause "make check" tests to fail without that.
> > >
> > > We remove it once we introduce "accel" property later.
> > 
> > Hmm, I assume object_property_get_bool() would return false when
> > "accel" is not available yet? No?
> 
> It is the errp that will be set if there is no "accel" is available that will fail the
> tests. Another way to avoid object_property_find() is to pass NULL for errp in
> object_property_get_bool(), but I think again when we introduce "accel" we have
> change that into either errp/error_abort here.
> 
> I am not sure there is any other way to handle this.

This path is to set MSI GPA, which could be optional, right? So,
we don't really need to exit when accel is not found or accel is
set to "n".

In that case, could we just use NULL even when "accel" is added?
Why do we use error_abort or errp?

Nicolin

