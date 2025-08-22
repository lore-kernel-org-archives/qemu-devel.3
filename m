Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDCECA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 22:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upaAs-0006O5-5i; Fri, 22 Aug 2025 18:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaAq-0006NW-E8
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:23:52 -0400
Received: from mail-co1nam11on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2416::622]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaAo-0000Xe-Fj
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:23:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEn+CJXPFaYIdMO9tZQvmEeFsEWXa25uEIqfZlqfZIoySpvurlQ5SXARAAe4ev+mIlP7AU6OL/hiAS7mH1XGYc4F1Gti9WSdankOQZSnDr5ALTWMJlf9IWQW0khYL/QatDLtcOQDSYo+Fq4+pLCvtsZkTeh96SHkb0yBSjdXR8eS8R6ZmDs5I1OzuDDzw/LQGWb7tFNLfejXwtMSK5mKOCQncHr0IvIxdvaE26kn0ak2fxTS8U0RkUETHheAVIBSvoz4zZjua55wtdqlfLsmah3tL1OW9dmtvxQhs/F9I3i0DNlOtlqJN/iC5yvPm/yRaoQidzIIVEBXbd+IXkKd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAccYEe39wGwUBhS32B7t1Vql7NkIMO6aa1In4zOF7Y=;
 b=hVPkibwCXEbNATCc97lSj+0Re0q4iDlZNLLStM4hnM9ncFfQiIysTGAh++q9GJdeoc0Lnpvdb2qZBDxqYRNoZ6EQiwZ4AazNrs5L11ZnsnRvrOHd/kWAuCd57OcBuYsydq26ROXm6U3l72FxgaxUlqNsZ5rBP9vdH2UvSEEX0fKAzfZPDtKWFH/kLMiHtn7YjeaH0KlwAfV+5ZEnqe6D2S0d6lMv0SQtXbA7Jac+Rpcep0F62dLz8Ken4S+d/lFhesqCKM+FMH8Y5L8o+Ggp7J+XLGGTHs3/Ip0nLArb/Bj8r+f13lhAwF6RBXn/N7IEaDMRplDNRmlHXo0YgPMl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAccYEe39wGwUBhS32B7t1Vql7NkIMO6aa1In4zOF7Y=;
 b=Fb+pZjcunE/rnsmOL+vcGk6DS2o04yQjh72iYdag83EAoJPzUmkcVnvRFznv3gK4OqwMuni7v94R55XVfMWHiRk46wJZ2AyJ2oIxScKTazy2KJnFAiO6oqDWRgaJZH7n1ZAmEfVz6VFg5Hz02wRiCWdioCZDrbrXbciknznjQToRLlCKuNNPnwpPQcx1W2JjXrxpR8Dr/ycO/SRN4F9qQgsXIN/iLEmrRmgpkwuMllt5zb4gc9BUGYXlXdn09PKftDy9dneMIPMqo6vpsgq2TYMSW/fgKk9ORHu5fiEa68IPSqCBESnP8IxpQaadUu3yAUzxmC+BkcH/cmI7whOf3w==
Received: from CH3P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::30)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 22:23:41 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::96) by CH3P221CA0018.outlook.office365.com
 (2603:10b6:610:1e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 22:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 22:23:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 15:23:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 15:23:27 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 15:23:26 -0700
Date: Fri, 22 Aug 2025 15:23:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 03/21] intel_iommu: Implement get_viommu_cap() callback
Message-ID: <aKjt3eVhfCJrL8hI@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822064101.123526-4-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 570229e2-6202-430d-949f-08dde1ca8c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HullzEXnbWLcWYDii2MlvUqMmJwYb1ZZo05J8367hkLUiM1NhJNadcuu9soL?=
 =?us-ascii?Q?1Oc6uktlbxXcFGHDzx3dAQWDsbdDVjyh7URPYJkjfenL9AYDWI+3+f5AIo5A?=
 =?us-ascii?Q?OIsEKwkOsdzn+T9NhLCmLA9jwX/TdBByyZnmpH19Oo+VVBYeQsbwWfP9Totb?=
 =?us-ascii?Q?loZ75t6jEP22KFTfHZbROrDDg+9WaKdGjwmaBaYlFwxOl/TrrsAzXKkuLUuD?=
 =?us-ascii?Q?QFnrluzeW9EHQN/iZwvXIFCIVbLYK+QOnqdK5KpXaQxe51PJdN6MqPktOhyO?=
 =?us-ascii?Q?flE/E/FOSTdkYKjeo6xKsQEN6Bwma7y4Cgj+LMf0VKCE+fIIxwmNUlpMw3yo?=
 =?us-ascii?Q?IUggsGZKQPWmm/rZudR1+intVTPmiRhOl3hsVwcOneG8Bm3NPwMmRq0F9T8e?=
 =?us-ascii?Q?JOwltBwpJWRfKPGEU60h+rXTLyFCFaSJA7ko/2g7O3yYoGYwavOi0pR3R2q2?=
 =?us-ascii?Q?iCWmx6STKiCwJVIrcJHucUBYuq/ow9ev+mU/wwjQVTP7ZqfHTZ4VJ6ANGpFM?=
 =?us-ascii?Q?Ra/wyVUyy32AVnINa4bFFscpbP5sZvPX41Rl/OzO7xhbRP4imgZh7NDA7WgN?=
 =?us-ascii?Q?XN08kV2xcLFoC+bQJC40itMH3caUCgOrCaPYZrr3Lkjp8cZkusUKZ3FxjImm?=
 =?us-ascii?Q?P18TL/aGY9pYWb8heOhigOiB0JMsUziqul81eGQ2qBmiL/wwungMl/r3JsIG?=
 =?us-ascii?Q?XuT9/ctKaN7R3XyLrESDnNyixHf7pL99aQ6DgxDEo9So8ORd6nuo9LH3GDx8?=
 =?us-ascii?Q?mpWtd4rmZd1O3O/hnW3UK6QUM4l9Pl1xQ/ohJHPEAv1MeJDSiKY/Qq9sU4j0?=
 =?us-ascii?Q?15XFTaUEePlq80eA+Xrvz4ZSPZfgyi7OKyjYNpm08HzajuPy6Tb/I3A4jNiQ?=
 =?us-ascii?Q?C48IrgYHzwti1z1T783wdKBoUBeQbhG9FJQOIGEHZwIMbo1dTr6fMXrvsn7z?=
 =?us-ascii?Q?fsfR/VS3WtBDvKNBwsM0ObsHEJxvTEgPwBHMAkhZ8N1rrdUoC4jWPX7RzeWR?=
 =?us-ascii?Q?0LJBoJta/XdOvaDxHNi/T19Jvi6JuJ+uqs8Wqupf40iMTKd7Aov4j7uZRIWC?=
 =?us-ascii?Q?J2P84g9tKBJfYW3jmmVm34DD1ThkUgi6XhPbNovPmB+SLDgYMMCK7bF2Om7r?=
 =?us-ascii?Q?cw97N1EyzisArztTQgPe6IHGgFOcPiOeQm+EzoZXJWfdvoLjtVmyjLKtED8V?=
 =?us-ascii?Q?bm0h8sMatnWsxTUtvYgHvN4KyaKEYja3IAQOe94g7yASITFJ+YLjXupWyYBI?=
 =?us-ascii?Q?j+AFPZlMt98/r5UTcDovtixBnTvU3ZGRKeeTnjEQfMCQGlN65u91jET5xQQ/?=
 =?us-ascii?Q?GBEhGCmXNoyOYSCfFDvhRSgYgsJegdAzVAyQJifnF2E3DoG/onWFrSBbh7ZL?=
 =?us-ascii?Q?ogfYIKCwYC0j+k6anHZEZPTTF5vk3uwLINBb+DWiNZ91ONrcW1c9+JhiaUhQ?=
 =?us-ascii?Q?Y2ypTVLhi8xyrGLu9NnLFpuAp3iqEvYbtyGBp0oGEKSIWTLpsCDnNfKXm5a3?=
 =?us-ascii?Q?uG4y2LNJ94ByfPsfdsgdd8/uTYyTxaWIijxQ?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:23:41.2040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 570229e2-6202-430d-949f-08dde1ca8c84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
Received-SPF: permerror client-ip=2a01:111:f403:2416::622;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Fri, Aug 22, 2025 at 02:40:41AM -0400, Zhenzhong Duan wrote:
> Implement get_viommu_cap() callback and expose stage-1 capability for now.
> 
> VFIO uses it to create nested parent domain which is further used to create
> nested domain in vIOMMU. All these will be implemented in following patches.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

