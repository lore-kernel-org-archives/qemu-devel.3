Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8178EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 04:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uccME-00063a-R1; Fri, 18 Jul 2025 00:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uccM8-00060M-Nt; Fri, 18 Jul 2025 00:05:56 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com
 ([40.107.220.42] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uccM6-0007B3-IL; Fri, 18 Jul 2025 00:05:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaOWsT0ED5EdXOFOIWfl+yXWG2rf8EfUicL9CBApbN5cIekI6qsMrXxVyxRUWUgOsFE+BsxxZ9Kyg+Ij3mP3KpiPg6HY0CUWlKCub0+ma1KIaKIumQzio01UWB14kou6tOSzC8EuuJUBaTB37RkDJ3Fr/ED4MMOxN275JmfSyEEcraqKX8I9LpUOIE59GcD1qRSKB2m+6OGH8XRy2HyxBKfi3eL/Keem2LoKFoDWwxypxOu1UHTwMrbMkfKU4yMcYPvuh4tnH4OWNxM+Ftss738R9wM2GjIzxD06oBhTX8ZXIRYW6JyxLKXFjYrbPjomSPlrr+CyEOvyG/e//BpaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np4FDZq9kzSv6C5AC78nYBkfAVG4/4dxVr9HJnX4ikI=;
 b=ipXtZZXUhs5/e2tTft+z44NBNw2MdVfhRrHm2sGfSrAOcth7sIeVRWCGxvI+lXV9lSFvGefZRBpnZCD7niZ+tA3Anac8u/lQM1GvG7ly1zG+zZrqdra8VSYIavrJn32lggqM8ofqUnoV8qBXQoujC76Ng/OXl5NruupRl4OR9hX+t1JH88wIbqwpFYd/OVZAnNId8Qm3dIXHrZ5b1ORuSg43j7WTaZqgTsRjVxK2Tryzv3OIBmNCX3ddNJ2Y0FRcDPgT6WHlhCDQ5vdx8YkU09I9+t7PYOCF0Ng2vPZnSPi6DRQTHDb/3feJ3AvY4aoMaW4AvHdfR6+p/ae0NUe95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np4FDZq9kzSv6C5AC78nYBkfAVG4/4dxVr9HJnX4ikI=;
 b=sl1J0mnyrW8LAWjyug4fbrL+p+avu+MjQQ70e4rNVBJT9JY+Dvb4YPR6jIErU+aYj2vguMUOq8/Frbx0Nq53a1og8TmvMKT789ZjP0yTMbza2xh3JwmUoHgEz66GCOhH+jj0pBgk6kxu6pMQBUh710vmzCQ/tDuacdxlZ9y+wAkRr0mSfH6gPkabaJg7BUXy4gISK5JY+71mg3EsDc37eNoqck9L2NWil8/+FT981vcaRueb5zJvcGikV/zKYVSAzgajQ0nnVdWhD/yqEqG1ry6ttl0LCZCeNFSLLd/Pn4ECr8JiF2mN5vEfNFHR1YZdNvRcyGUnm7Qp5VhO4L6Phg==
Received: from MW4PR04CA0172.namprd04.prod.outlook.com (2603:10b6:303:85::27)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 04:00:47 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::7) by MW4PR04CA0172.outlook.office365.com
 (2603:10b6:303:85::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 04:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 04:00:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 21:00:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 21:00:27 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 17 Jul 2025 21:00:26 -0700
Date: Thu, 17 Jul 2025 21:00:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v8 00/12] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Message-ID: <aHnG2aiT3TGwIB/9@Asurada-Nvidia>
References: <20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f182a3-597e-4219-4e37-08ddc5afacc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mXYbvstDR5KH6U4cCdd4nE7N4y9nNUE9o0PpN5tqTnP3CFh76sNbCkNxYtdR?=
 =?us-ascii?Q?YQSMsoWC4QNYOxIG+nAt7onv5E00giKJfF3N/wDvRsnQ1E+eggbNcFAEUAAz?=
 =?us-ascii?Q?ZLvzBmW9zYuXZ0nPTXOgKj5HqEYxvXHYUj+7k7UbfUMNIzfbQdE66rrbzc6b?=
 =?us-ascii?Q?j1C46R4pkrXzgS/x6cY0KY8+DQoFsNKRy+4bGREqXEUFatfkuwbbnB6BRzF1?=
 =?us-ascii?Q?MfOGr8YUHFmqqlDKyma44bcdMtswWxIU+cK9S8YieamdGxfx17hDsU5LEu6d?=
 =?us-ascii?Q?cRBY0263FfcFqTmnA/ybGqfFUF7uugeI7kP4AHJK4U7OfHYwta0VEisQZd4V?=
 =?us-ascii?Q?rmmz3duqW5yvkpnjFsLDlSZ+iVE0TkY1Qv3bdoetDQBhj4qCOAvYtoyS/k2P?=
 =?us-ascii?Q?AKVA+TpphCUZ+0TG7OmW0ylUZaJ80UlgoVN0LKSaVkpwaPbJi8+3hmU12RIX?=
 =?us-ascii?Q?YILt8KIsxz0G9BlRVqrnOUhaOvNs1ptZGKn/AjLSW8r04b1WV6H56IL2iQ0f?=
 =?us-ascii?Q?RZBb+lPXSauJEE3q0LDbTNuXE9k779Z3oOMpgOCcW8yV4pGk0bUeyswcQp+9?=
 =?us-ascii?Q?Bw/24CPmcpKO4g59imTdt9dgRWA7c9aLVlmakva+PvDvqjAOquqWjLoip97R?=
 =?us-ascii?Q?FcNECC7eOanZPkUnjlRysj5MVtd8Ezzb0gfv0BBooOyud9rrH8M3LGLJ+HQI?=
 =?us-ascii?Q?hYNGmTl0rHokWPy5ybUHGyXn7NpIpSjJLcHBg64Noco8zlAbPA9oI2+SBhWN?=
 =?us-ascii?Q?ut/oKzzaApEvGC09U1XumMJKWJqS10Qp8wq82y3plDioaByKTy1nYd+Opj7n?=
 =?us-ascii?Q?oc9S5+kajX/PDHMlV9zsZB9UVm87rBlLnrvXNLYfjcxBhY8e6z3gKjrhv4FW?=
 =?us-ascii?Q?uT8LGQgis0Envw1JfTYF1BJ+AoAG7hyR7rB/E6hcLSfQnXeDzDxsho3STHzt?=
 =?us-ascii?Q?aCWdaiIBzxaqXUtI54hRJhg0D2nb30Pn/UafBCRXQsDcL2QPU+XJLWq3RtEn?=
 =?us-ascii?Q?/Xf6iH0W0WzS5a2xaF9uKoz1OIFRIpmPgfjh9/jDFNcqXgFEal2oXZMKheLD?=
 =?us-ascii?Q?a6rLYDgQhLk5Yn3Q/xAmspivd2xcJ5Sd1sgzCcOP99FRGAr+o6gi8oeRlgST?=
 =?us-ascii?Q?2xeoMP0IqMbAjoCygCGpPdONr8PrdBAW2vZ0uUOIqbwLsUcW1UqrYTTrgcyV?=
 =?us-ascii?Q?jxa8abFGqnRzr14w+k7NcZUAE/NpevJvssJ5SolXcaHaeDTCqa2feqHEH4Uy?=
 =?us-ascii?Q?Mi5DsZbcCpgwU5LBQ1rq1mEYhsRdlME7dhVE0tTjMbUx5R66fZdkjq0KEsEO?=
 =?us-ascii?Q?4wP6t816WlGCvO3kZuCssJiv5l8DaSc75YSqh20KFzRMhDvhLlG2UG5n4jIT?=
 =?us-ascii?Q?/7djVjh/bocVwZFJpSlop6Xs/zzHsAZoUxBMtaJ3AFXiL3Cq3c+2buWMLx8L?=
 =?us-ascii?Q?NDkSib1NEow8jaPVBUDiQpUE/wkA57ZFa26EuUBTPks4ZSVyxjV8oHm9v4u/?=
 =?us-ascii?Q?+0ZhzSExQRVqWMbsL4ZjC5A8ns+aCkwsY8TH6F2l13n/ChmQ13cn8YI3Rw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:00:46.3772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f182a3-597e-4219-4e37-08ddc5afacc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
Received-SPF: permerror client-ip=40.107.220.42;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jul 11, 2025 at 09:47:37AM +0100, Shameer Kolothum wrote:
> Changes from v7:
> 
> 1. Rebased to latest target-arm.next(I have included patch#1
>    as I can't find that after a git pull of latest)
> 2. Addressed comments from Nicolin and added R-by tags. Thanks!

I've tested this series using the latest vSMMU RFCv3:
https://lore.kernel.org/qemu-devel/20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com/

I was able to create four vSMMU instances with four pxb buses, then
to pass through four vfio-pci devices to a VM.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

