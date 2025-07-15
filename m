Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAE2C83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 18:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubk2N-0004YD-Ni; Tue, 15 Jul 2025 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubjTE-0008Am-Rk; Tue, 15 Jul 2025 13:29:36 -0400
Received: from mail-dm6nam12on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60c]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubjTB-00023U-DY; Tue, 15 Jul 2025 13:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dskVgyAi4LcvHt6LDkgFOB5wbGKBbmmv0sfr+A9z79WUQGBhGiciA0+0x306jE+PArL0MqBGdnmFlm1bGPVoI+1PSORv1sHSi3+VQbHkQDAqhHWpzDSGtl9prrJJBg3NWHz6ttqa81fKy74xSg7tieYvn21h47cZ1T0OqbC5HOoqzhDrshgsgHmFsh+Q8n19d0b1sInTb4mVHtrpg7nXQ/voZ+1wyNWSay2OpgQ463nXeZ7sGgmEZu9eEEWwGWAO024vn9+RxEuGzFQRReX/QxgJuPWaXZrUlaEVxl4P3kXx04/Fi6xnHnAQgFG9S+RK6aIlEWXQizsYjosQ9M8/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOa4oOPzi4HncXe++APvtmjbVRwSRukwk+2y46DTsYM=;
 b=VlMTjxnjiRqi7oBFoFDrXtyR3uosmA+c4LBaSPDUiCpRnQV5KKyIkJ40rzis6FLmg4UJs3Sc+1xR+c/m+Z3CxJdBTip+qoxJA3qNTsF2EDom4P8SXLflpCVsalUcCKaht3d6qybgBHwW0ZJwd39vBwhz/9xj7qHUVhfI7582jBnQk40FJjIunTZ/e9n+xb1bGcWlR46qE9hPiBMzDpRBt2rZPZu53OMA879xTC1KoPQwoOJ3SqXrXmTAgGzjONp8H1bctjoHM4feXz0xxUDwoMaYn1N660zzeDW14A3SngDcTn5ezafP7MD7UmaNSlH7J+PjvylKd2q0y6SA2NCi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOa4oOPzi4HncXe++APvtmjbVRwSRukwk+2y46DTsYM=;
 b=cnpEO6aXADUx1tXyQFlvR7YAOm5TKXJe54k/TPrWt7Jwko5KT+XQMLvWWqQRKv3LSRsv0vMVGN3vpJrqp1oBU6Z2YMtA7kXtrDN3C9/h+KtF7aqeMoWpvrNmlr1OxhuwAt8lfSPLuu707mwnP/WVr64KNkLKaSftdcQWsD8TtEDweFce/khxEhguq61t/e2V89CZ6xY7abLujs3JGHuYjhGlx086pw/pEZcFm1427P4OGE9BvOKo8YYAqORaC6HO/rukhuD/mHwmdiba9X1H8YrGeN49wlPBipRe2LN6hBcZrN+orVJADfY1qjxaVp0ZQarSi3d2nSSYRvrVLv3h2A==
Received: from CH0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:610:75::7)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 17:29:24 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::1e) by CH0PR04CA0092.outlook.office365.com
 (2603:10b6:610:75::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 17:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 17:29:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 10:29:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 10:29:03 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 10:29:02 -0700
Date: Tue, 15 Jul 2025 10:29:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Message-ID: <aHaP3ULG90gGqWHJ@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136ACFB4721D47304A9885C9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136ACFB4721D47304A9885C9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: d420197f-8ee5-4c17-c99e-08ddc3c5244c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J0+bETXl5nl2gTQNJ/TuVhvuUxNXTzTJJV4GDI14iISaWihdRIYQeyL0k7GE?=
 =?us-ascii?Q?HQKrpHWqA/QgMod9iTMMTBTVINj2AFfa14GsT6iqQW+rw5DYiHHANbzdmnQ2?=
 =?us-ascii?Q?+0s3EPvbiWt6BVpqyoiH/w18O/X2p7ybXeJN6NRJAhmmS4ZsmDOY1pUU3coW?=
 =?us-ascii?Q?Xs9F33+Rl0ppO4Hj/VLZzebzRdUPixgdpB2jl7rAyfRbN5UPoVwzivByq9ME?=
 =?us-ascii?Q?/SvZ3nOTjjkxlVHDtZUGhKUQuFzAfuk6uA+ljNH3KU2DAX1Uh3yS0vSUTetO?=
 =?us-ascii?Q?6O78q6g49u9CypVHo9KfrV6ei265qD20NPTFCJvS34P5Quo7LI9BNAlYvT0o?=
 =?us-ascii?Q?K4uV3lZXIAYZnTckehsZEdmRr1CnD5/EjXA5h4jr+itavHhFx8aEtTiVQLKF?=
 =?us-ascii?Q?ki6WSKwk7ixBTL1XvDL1WhbcQncNqV8xh4hZ+zrA5/AHvudy2m8PIVMXRGi7?=
 =?us-ascii?Q?pW/maND86DpMm+ckssHUF14Ik2iY0FZgLNHSky12HZiUjEBFpUCGkhYAXWO/?=
 =?us-ascii?Q?hwz1H3SZwegu+MFE/kXLfPon76t/Sswz3ccp9csQRwZFSsnMpIbU9flGH99/?=
 =?us-ascii?Q?ZbaFAIkTpXa/x9l/NWKI7AqMfe6SGq5PFMKfvpFTpnDAInALJBAULcY19E+a?=
 =?us-ascii?Q?D79CphZN1I7ZBnbnoPcXIV+FBLXORLL6qUpojZdc8kGaze8Yx5vFmqKW7Xfm?=
 =?us-ascii?Q?L5LUQ0oWFZFN7vcXSitDo3ZyE9P2xzvVOW1f+clPxOdkp39Xr1P8ShRWKAQz?=
 =?us-ascii?Q?Bw2tV7xaRBTSIsU8kGY4SREimPEtl+LcKDUhaR0EafM8P34wafNsZ9RbxQl8?=
 =?us-ascii?Q?1NYeGHJhSY0pzk9oYbNT8OFLQUvEN+db6QpsoGp4OloPXkQwn7yybPQjMMwS?=
 =?us-ascii?Q?uJ3+GG1z5iCBjP/a6QcAKnsd+cbVqGSJfRHdUqZ2N6kLm5vmXf8KIQUoks8y?=
 =?us-ascii?Q?jLgfx+oOt9yuM8cHWzfIIpBPk/nlH18RBYzu/2nKhIovsqHquPdME94vjghw?=
 =?us-ascii?Q?yqU/GSeOmMnLMP1lh7KVv3BEprmetHRY7OwnscFgNnjmUFx9tq4rdgk1X0rb?=
 =?us-ascii?Q?+LAaYc/wmC8TeQN1KhdyX86gRboqmnJibEqvOAT7OGHrOJTmz3pvErzTrn3M?=
 =?us-ascii?Q?+4fKmppqWwPdxsly/rMTjFUfImacge0YRg2QGuo5UBbGbYksfPA0hTP5z+DE?=
 =?us-ascii?Q?yeGRureS6lbIo8OG/bV8l8ngi3yO+jaVWjoOy/Gf0+Sgwa58VQ0p6AVzFyJf?=
 =?us-ascii?Q?qfVPr6R1aJcjTQEBSstnTAISKl5kO3jmFQ/dJ4IzCLa86TdpMkqdZfM+/5k2?=
 =?us-ascii?Q?v1YN5/P/uPPmQf1xsgonUpphvK9jUCJO7BtZsHle36qxHq7IWCbv/vE6/zb/?=
 =?us-ascii?Q?ZSRMpaS42GXpq0mSA5Jjny3sZf157iCJ+Aj5LucZW6lV5MVtKcA3LEKU3BRY?=
 =?us-ascii?Q?q4EkmtB+30Wu5lGl1N3Q0ZwHsw89e1mwLKeqVcY5ImhDkd+rRN+zhSAm5I+s?=
 =?us-ascii?Q?FbdgiFWEZL0GqTmIQ0FtPwOhgttB+sE/7HaE?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:29:23.9762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d420197f-8ee5-4c17-c99e-08ddc3c5244c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
Received-SPF: permerror client-ip=2a01:111:f403:2417::60c;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Tue, Jul 15, 2025 at 10:48:31AM +0000, Duan, Zhenzhong wrote:
> >+static const TypeInfo types[] = {
> >+    {
> >+        .name = TYPE_ARM_SMMUV3_ACCEL,
> >+        .parent = TYPE_ARM_SMMUV3,
> >+        .class_init = smmuv3_accel_class_init,
> >+    }
> 
> In cover-letter, I see "-device arm-smmuv3", so where is above accel device
> created so we could use smmuv3_accel_ops?

The smmu-common.c is the shared file between accel and non-accel
instances. It has a module property:
    DEFINE_PROP_BOOL("accel", SMMUState, accel, false),

where it directs to different iommu_ops:
937 static const PCIIOMMUOps *smmu_iommu_ops_by_type(SMMUState *s)                                                                                                                                                                                                                                                                                          
938 {                                                                                                                                                                                                                                                                                                                                                       
939     SMMUBaseClass *sbc;                                                                                                                                                                                                                                                                                                                                 
940                                                                                                                                                                                                                                                                                                                                                         
941     if (s->accel) {                                                                                                                                                                                                                                                                                                                                     
942         sbc = ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMUV3_ACCEL));                                                                                                                                                                                                                                                                              
943     } else {                                                                                                                                                                                                                                                                                                                                            
944         sbc = ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));                                                                                                                                                                                                                                                                                      
945     }                                                                                                                                                                                                                                                                                                                                                   
946     assert(sbc->iommu_ops);                                                                                                                                                                                                                                                                                                                             
947                                                                                                                                                                                                                                                                                                                                                         
948     return sbc->iommu_ops;                                                                                                                                                                                                                                                                                                                              
949 }   

Nicolin

