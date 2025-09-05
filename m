Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD4CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uubJW-0004RI-DR; Fri, 05 Sep 2025 14:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uubJQ-0004QQ-9n; Fri, 05 Sep 2025 14:37:29 -0400
Received: from mail-bn8nam11on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62d]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uubJ9-0005Oo-Af; Fri, 05 Sep 2025 14:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTLBbA1y6xbix+/tbEPyR607DxRGaFW2YNy1s584olb247qWAyGenLjBTXhe5BwZdmYykvkWhZfXdJ+NVce81enPz7C/MCRUc7+z4h/vzCB8uYvxWfp8EemGz+arnBzmbhWLgeBHwowQQkyjoTmfDpS83pVib7YuyB506otWoVmPt59nRZuumMu9LJ5aQd1pZNeBc2P7yp/EX7xrwXgK9ZweoieHIOUHtzDtRlsTjrSJJp5qIIDbxJCtQl5BJlHsZcpu3Zaaq0IXXe/oqXWpPU7DrUyhi2HhqjjeaR8lTTKCMcGzRmfqrVMXqNtS54rKbnVQFZvWrbt1g6y5NulNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKr/0Opa1vkktKpLul8iXasjmQOoXLQQmW38q33MDsU=;
 b=FCqUclBVlkSK0yAH+M1gUNYvQWkx8k/OJfEc8/yUQ6grszC/jnlmXD6xbmwS1zxXXfvAnpUJUR1pTHmofH8kDzvujEONKCbz2m38MqKDxTZ4Xxkmmk12Va3IMfPmx9trFUFdE9qeT9u0Jv+fMfrBxsNQTaabr5NYwX0VnNrEUqfiBMMX698JhlHlksGZIHZ5KdaSetNF/pAg03laDsVwFRAgpVEzExWeVtnz/fC79pIcDYNb8PZgq9+nlN8a6EECnmwoVQbp5W6vxsDbYVAuW+R4jdpMwfK6Hb14S8Tib03fykwRDC5BJE3X0LgkScllMsPmd+KGRLsdKoPEGOw9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKr/0Opa1vkktKpLul8iXasjmQOoXLQQmW38q33MDsU=;
 b=OCqecu9wK6BUftp1Esdlftnd9s/wjND/7KnZmdIUfSs4aITNKmQPxEM2l0tsxNtRHzfsACc8EFRN1Ee5iSHBXuTHF2kEBfWHUzzrrN+LVG+RrO9Oqv3O+O4IeOGkJnY0UUNm1wqTw3u9IN8mMj1dxTY5T9i/20g+EmiW/dAS6h9LZJ0FZ03XZZPljvezjP4BXH528OuqJjucxS5Ucbs/Fbustz7mW9Jh9EW3bg5PBRDxGnqvZj4BJTLzZmqOuNbz5ZlHhBxHO9vOPlor1tVeLvF71R0OTg2vDeimX+XKx6nIGPJdN/EpDEH/Qu7FppT7NUI36//RCAH2CNKw9r0xgw==
Received: from CH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:32::27)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 18:36:57 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::f5) by CH0PR07CA0022.outlook.office365.com
 (2603:10b6:610:32::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Fri,
 5 Sep 2025 18:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 5 Sep 2025 18:36:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 5 Sep
 2025 11:36:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 5 Sep 2025 11:36:40 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 5 Sep 2025 11:36:23 -0700
Date: Fri, 5 Sep 2025 11:36:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 10/15] hw/arm/smmuv3-accel: Allocate a vDEVICE
 object for device
Message-ID: <aLstn2coK3AMRCES@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-11-shameerali.kolothum.thodi@huawei.com>
 <2bc9b909-e25b-4b4d-b4db-0cf1d10a339b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2bc9b909-e25b-4b4d-b4db-0cf1d10a339b@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c28f80-1484-4620-f733-08ddecab31fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e9NgTk+ikd8CJfvFbuNkIbs1HghKbzEuDFiDxT07VcDGhplJ0EbAqzpfB/yE?=
 =?us-ascii?Q?QLtKpqzE9yGsaA8aRfdc3Gxra73H4BxkACONt5OmMCZTi1KYX7dv+t4JPSqu?=
 =?us-ascii?Q?akG8Cyer/ciYD/JvzorasLGCg4ErTAyBRynxvVtkpZz335INjaBJNMov2e0A?=
 =?us-ascii?Q?3AwopQ3RDJzYCU1rceAukmPsFsTzzS/mHPNQhJkcAaihEVdm+3qBVjMXvb0k?=
 =?us-ascii?Q?INczlvhvL4be9DeeKwo51hcHUG/1pgv5+eHYC9ho5CmD2HiAiLnFtl0nLv8W?=
 =?us-ascii?Q?OFZ+SkWChpcbUiyo5ZzQ+n8CFm52HIyrY5qw3rmiV5PHjNLg5zArq16vmlQr?=
 =?us-ascii?Q?24IQwcBn33rd94onBalwesP8z0LWxUuqrv76PO4Pwx9DOokRhjwqh0xPtW1l?=
 =?us-ascii?Q?8qHdld5xCRK/9oJbzWeejzhe8NM/ixcg4ZJrkBSqcK+5TBfnefDCmwViOC2G?=
 =?us-ascii?Q?/hoKs4jeGtlXUmJEreuWQc4GRkraVXIs//W+yviBN3r8HZZxSpfBaOPzIwGQ?=
 =?us-ascii?Q?yph1cuil6UKyvbzC1nKoczCHYvpNPiwe7fO/BbVs5ff/K/nT3G7ufIa6iG9P?=
 =?us-ascii?Q?YVvdtVQdRujF+cSuS9n8E8uKRgc/fiuHUqYh+khfILKPOCwQFrhWCcg20M9l?=
 =?us-ascii?Q?TQfCSY95j2Ad8hH6XBT/e+ntNzhEjMPLCkn3Ie0FjtqjUXf+57uBUatjL4TG?=
 =?us-ascii?Q?tMS88Oboj1h8oxYf22S+d4gyYnBzUW3KbLprFyfCmttpJVTYI6uzu/Zu52lM?=
 =?us-ascii?Q?VB19OeqaJ/9WUxnf49DShivE272EnFi36js+iv3ptKR3En1Kz4Ge+FiEyHR0?=
 =?us-ascii?Q?Uo3ktdOnuDr9qYv+8tJ/8FozYKt0TdXXUUenVDNXVWFEe1jQkd+iohuOt8OS?=
 =?us-ascii?Q?6ixd35kiR7fsjBkX9WJghjakLz0EuO6Dlbi7toWTj69rYUqM+nuMp27jDyx2?=
 =?us-ascii?Q?hSezM3F6SNlrnorkwbQUUmvmVTEe4DlBdzsGilzGECduQmh72sO1MwUm2MMp?=
 =?us-ascii?Q?LaOZKO59ZosRqXJHy17MbfjR0SduYyPpb27VaENSgKIuJl4mynmpiYmJpo5P?=
 =?us-ascii?Q?engUCx0njs5PGbyQ9+ps/cSNa3OP++bryAXJKMR70rXTNMuuqMguvThIS0he?=
 =?us-ascii?Q?DcL+Z+he+9MK5fGOQZVbVIb0w8XfBQCeQYc1FgqvIujuwGN1RwLaHz04jCdf?=
 =?us-ascii?Q?2YOhXyANf9PRtCdcy7ieGJIV2woRM2diR0AjW+RDdF6Rqt5JcTqZk2Xd4Xl1?=
 =?us-ascii?Q?OJ+QRblne2SWDCIxG+jZUyiFOYKhtiJsyL1pfAUhGawUBG07qhmx/RV7Yc+5?=
 =?us-ascii?Q?M68F/5DCY2jPjVFx3Ryipey39P0lPTAmdNWt0llHGld7l++yuar5L85S4j/g?=
 =?us-ascii?Q?40h3/88iHPtsFw6jyXDLqLcPVdtIs+ZSPxXQ8heyVSPRUZWm6PKV6LnK/R28?=
 =?us-ascii?Q?gV75vQiR94/pozCA4eDQpdGyo4RF0GJk24m7klrURDlc1Nmr3/9IGZkLyG0I?=
 =?us-ascii?Q?Z3kfVKgY01ubK41qs+oRAFKBBibMXoK7yybg?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:36:57.7034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c28f80-1484-4620-f733-08ddecab31fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
Received-SPF: permerror client-ip=2a01:111:f403:2414::62d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Fri, Sep 05, 2025 at 11:57:59AM +0200, Eric Auger wrote:
> Hi Shameer,
> 
> On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Allocate and associate a vDEVICE object for the Guest device
> > with the vIOMMU. This will help the kernel to do the
> > vSID --> sid translation whenever required (eg: device specific
> I am not sure I get this. Do you mean translation between the vSID and
> the pSID?

Yes, the kernel requires VMID for all TLBI commands and pSID for
device cache (ATC, CD) invalidations.

QEMU only forwards raw guest commands to the host, leaving vSIDs
in those ATC_INV and CD_CFGI commands. So, kernel will need the
vSID->pSID mapping to overwrite the SID fields.

I think we should have spared a few more words :)

Thanks
Nicolin

