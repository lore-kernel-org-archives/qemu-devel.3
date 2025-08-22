Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127EFCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 23:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upb0y-00063S-QH; Fri, 22 Aug 2025 19:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upb0w-00062s-SE
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:17:42 -0400
Received: from mail-mw2nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2412::630]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upb0q-000796-1u
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:17:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u54OPQiePEO4WYfTF6q36EoHAWJ3V1jjLM24U+ChYtjYkLJxesugqB2gfF+YAyncKgswim4t2OCSI+ca6lUu8vOlgl/DLdjAEsFWnKZWLbo0ZQjvcVd/QL88/yqlPwWZLFHNmUN1Z/M9pABGlvmcv4hfrJzfk4pc8wM+HK5aSH0mTaduk0r8c+1TeBGKq03Eny5fmYO4HM1OC98Ub/zeGEJVyAcs1tYvyikRpPKonsHdpe3m2IrHsyVhYr6IJQ0UjK3gdyoqMqidCcQXVtZvX8x2KdESo9njVkDln/3MO5pGawAfaz5hiIJAK453OK2Odo3170M9YIDig+Jpcf9STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO67l0jfuiygKijmfY7mRC9o2DxxuKiPKMxPaoctLO8=;
 b=tgSTfFHKb/biuZJh9Mkv6LQlrBf2RsjRUfBCEw5ETIHNmLBwnN8rKk3xMg9hRD1V+eMB1/1OXqpxSUQ3UtOtXyi1F+8CuO99OY+lkVMUmgsZ+pGw6Zp9gIMdOXu2b9ko+XWwpU/T08xJ4AdBFeE1YFt6MZ5Tu4L685LrOZC5mq5L2TTDKA/0d2k/lqPOS8IdI/t2hmEmf9lb87RAPHQ5IzjLBl9Ilio6IDXP8HesGx/Yj0MG4RHEPEbF+huJzJ/IjNovWl4RfFsyBWXCPGPifAxPdUMAX+x0ND1x4QPSP0BIio6/ZLF3NX5gCh0KNKdmC70mjxdTui2K0RALKzQG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO67l0jfuiygKijmfY7mRC9o2DxxuKiPKMxPaoctLO8=;
 b=r9/cbAOIpyl4JwjAOkCCpeL3HHcNeWw7R0BqcvZLi29x+J/bb5yoUV1RNvSYtqjIUsZvJtcsUQWl/kYf0kq0sOmh0Fy0Usj738RsrptZxcigzKHRFBAAHgdEceW1sU+lCXdyWioHyDfdioE/HGHYBDpWaE53iRhb8FVMjBAgNZI5kAppwq5Nsh6r7WcQ0kxcXN1yqrDq2+Qf2PgWSskXwnr8OR4wYP+r7Swbbti9wn9UJ2dpUxk3qkfAYmvPGcbfjABw1UqUNgGWi6X9N3tjfy4ouR2h1oB/QwSggNnyftKnLDLz8IUhTJf7Cr72gkg/lhaffukLVs8phlFiDYWKzw==
Received: from BN0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:e8::19)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 23:17:27 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::46) by BN0PR04CA0044.outlook.office365.com
 (2603:10b6:408:e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 23:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Fri, 22 Aug 2025 23:17:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 16:17:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 22 Aug 2025 16:17:18 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 16:17:17 -0700
Date: Fri, 22 Aug 2025 16:17:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Message-ID: <aKj6fFPCJ07wWIXY@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822064101.123526-8-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 34aa26d7-467c-4b2c-c300-08dde1d20f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dSOXGhh7ZtuBrHF74MMep7zJo7MN+mnZgdv+PQOWcAwNZ/jqz+pNhv+7e0gL?=
 =?us-ascii?Q?dVIlX9iOf0ejYkTVYAGW1mHc81JER1E18mwfnE78Flun3znvi8Ezsm766xbo?=
 =?us-ascii?Q?G2XGCSn0pr0iH/XEM+2p7zxxh5ylel1EBo1lRdgecgnpGK6dRvE0mPoOu4zt?=
 =?us-ascii?Q?w4ajnslK4fijdjhUYBkcYhZsi9p5pY1KAqbBjls+vz0vNptkzfJJfpI9sFWW?=
 =?us-ascii?Q?t7ppszeXXBNSFhG5vmJfB52QMJvB85gcA14whIhBD8CkI/80xzL3cz0hKBQ1?=
 =?us-ascii?Q?tsK1tCaI1jlTFD93pPrGFP+zv6wxSabrDyS+x8sCjBJFG3sQ4jpPKKcS7IW1?=
 =?us-ascii?Q?djMbL/8yTnMbMvOhkZjI+AWxsY66S0HgPB2vsFWTUBR5aNZkfbhlFsqvljFD?=
 =?us-ascii?Q?Y1nZ0RgePtiYQiM3zKW8KLPYLc4fvKsV2M+GTZ1vx0leB9HcC8IzivU/e6vs?=
 =?us-ascii?Q?8ervoAUmRn8DWUKBFxZV+K4kbvQgKaowYULA9QvdzQgKF16PgTUAbd0yEId6?=
 =?us-ascii?Q?RuJUFXid0bpoQTjT0xT26Sv27ci4CQg31vPWdolPJWigAuBGAuNXRxbFVC8w?=
 =?us-ascii?Q?dvN8+Ank4Sr9z3Du+47YeXCTskj4CBhZsEUUw9uv9hKwxTPgjSRe+DuBNhnL?=
 =?us-ascii?Q?zmAwrohIqz0bjRVHhUYq/BmKa4kebhq6bJ7lW1aqcuDOFErVQ7I9JCykDyr8?=
 =?us-ascii?Q?GcoE5IfnZK48EPxPk/iigOcgUpvOHiKgeOccyHPSG5N6nsCEQ6R6Uzxs4Pg6?=
 =?us-ascii?Q?GMcfFsQx+2C9Y/Q+o4v8JloIqf8sBGTLQT9/f15MUTPx6lAKZ5kQI5PmvV6Y?=
 =?us-ascii?Q?7YB9yg2JrcSKudneeroZ+Zn14Sf4eXI9YZ5euNbl0KWs6DhyO/CsmCKDq7zc?=
 =?us-ascii?Q?i5nFOzNxTqOzVrPtL+EufVJO3jd2TAYz8ODYU7sSxpFusfg0dQIu9MmHwtnb?=
 =?us-ascii?Q?pNx+2GNr9KOjXgH13JKpCLvy3c7i7FCU/p7LwZ8o7BAQDWXjST/t7+bIN9Ed?=
 =?us-ascii?Q?r1NxkXh0ukHLIbJcruIDWBQ8nfweCnOGpPU6k72lRBnryq8PitXKAotQQH+R?=
 =?us-ascii?Q?GFNTAuEqgC2f8K6VDE6vXPrEvZOtazaCGOSWUscGYV+r+rNjDa3ZGcz1Oen5?=
 =?us-ascii?Q?XimcY5Gh9dFUehkKA70X4hRgPC1vOYCO6kayexQsqnmDdjnHYzBdxbtoDC+7?=
 =?us-ascii?Q?wCHmhl6+lWth3SYB3qoFPZu47ZENI9VbnUcUVUA0heVjqb8TWhZAMI1EpVxf?=
 =?us-ascii?Q?PHMcFFMIegvycSauWyuXcdKmw5Ubr5yPijaLl5aIj3oYXoamJ79pA4oblnqL?=
 =?us-ascii?Q?IblcDUzsuV12aiGb3EfbFHjtg5ShaReVF3cKmF+l5oBTaQAZePOSVv5TKBPA?=
 =?us-ascii?Q?JlbaMCo0ar58PpRF6Ly7X8gAjnvoHRf5jk5kcpbrFBUmZGEtPuh5frulgXwX?=
 =?us-ascii?Q?Bs+UpgF/ov+B7zMnDfyDCjl7nkz1Dk5zCT7tGf3+DtkeRpvsJHg9sUuzlilv?=
 =?us-ascii?Q?NjABdMcYc8UrzGbjtM3VTohmNmUPUChheIae?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 23:17:26.6360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aa26d7-467c-4b2c-c300-08dde1d20f0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
Received-SPF: permerror client-ip=2a01:111:f403:2412::630;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Aug 22, 2025 at 02:40:45AM -0400, Zhenzhong Duan wrote:
> Introduce a new structure VTDHostIOMMUDevice which replaces
> HostIOMMUDevice to be stored in hash table.
> 
> It includes a reference to HostIOMMUDevice and IntelIOMMUState,
> also includes BDF information which will be used in future
> patches.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

