Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24553C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 17:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtzv-0000Pa-9y; Fri, 02 May 2025 13:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAtzj-0000LC-Vz; Fri, 02 May 2025 13:16:16 -0400
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAtzh-0002ay-UR; Fri, 02 May 2025 13:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=favoY2x6JDSUI5O8oJjjypr75PzWoMS8KIDnGvf9K7RgkWPrmElQqewTzuAEob5nnb1pkXU5QkM53Ew5cgwdXMI2BfkKraVSrzbZpZ2mTB+XhoRr4YRE8dhXdldw9ilYsjn5kkYNa99AIGTz2bMPXMTHcdOJTHVvE23tMLCIjheAtlRa/JxYexg2lXPKgQC8bZSAxH0VuQBW7Rn0L1EarE3t/eDP+rhaUURhPhq9ssYunxhYpDMC91ITLZ+Z7i3L3xOP0xLzQAghVnPcjRD7KEhcSGZTifSkLjaJJz/wgcIOz7mDrRpT42RPiFWRCpZJjleSngQ6MZlAIH/6yMUmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK687L4BjWiGrryAX3uCgYWzUti7WdhHpGvoI6ykccE=;
 b=MkLN8eHy384HGzStpKzL+LYDcR9dG2E57HZ98aATx/bULgbz109t2QXeGlbIuEho7c2BBAsfz91tuEpgFYzcYRXs/y3bJk91k/M2QrJJu0sPhupDZPpozLmaHeG+6VEye3K6deA4q5vu9z7P0iHWuAwSJOnOzIawRqBENSLQCg8GTrtpwnamXx58JBHBXg7aU+e90GLpi7ZKyfSz3jkiIDUZ91RV/NQB7tc20ceh965RF9Gui3hQdUobKvbrnDH61YhhZgw/ZadDiMLlr5SRvWJzjSjQWcDA+SOLYC+k2mtWhEIfolSMGUZvmBXLy4VI+hns9iDrMgG0ctKNTSDEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK687L4BjWiGrryAX3uCgYWzUti7WdhHpGvoI6ykccE=;
 b=ef6OTHWqx86hkxY9RXnUnDSeV0SS4WWXEy0gA0i6E3eZ8eIAFeBsttQIOYYSlQJTix6eAigEYnBQhuZmsaIhC5ZhLIicCrMLl106402LM6UiG57+146vtgceQm+30DRBYIw+Vm9LbkWI97qrky1VdIcw4LEF5541MFLnRWSk9XZTnzuovK+llInQSXllH6YeeWGL7DE+uNhCyu39hfXyaw2pDLMvUGx2cn4aFfQgPCA1uC/8azg6QdFCizdMDEAlM6MWuDJUQ08AnBkHyT933INXf5US8nczGNXgky6eSlTLZXMeh2hotSJocnF//adyVHxWUW+uHy5qMdNWouJ77A==
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Fri, 2 May 2025 17:16:06 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::4b) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Fri,
 2 May 2025 17:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 17:16:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 May 2025
 10:15:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 10:15:53 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 2 May 2025 10:15:52 -0700
Date: Fri, 2 May 2025 10:15:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 3/6] hw/arm/virt: Factor out common SMMUV3 dt bindings
 code
Message-ID: <aBT9xkeiCgJCMQwx@Asurada-Nvidia>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502102707.110516-4-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 47bee18e-c90c-4d52-4eb0-08dd899d059e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SAPGjfHa4HYHQMo34Y4qoe717mppTntxqLNhtY80uFxLxXxFl62t5tvVpWzc?=
 =?us-ascii?Q?sJXz3rYZwHxHwDVEnmKQ9ii+PNIa9vNKyCQNgaP3isbmbor2nZtOiSVlhSMq?=
 =?us-ascii?Q?5bwmkljXUmrpp4N0M9wYOV3W9dbyYux+UCJmUup/R59JPhujiCYe0cxU/Peh?=
 =?us-ascii?Q?msgVDYxlZf21paQldue6zSu8CiBuDab1XOCK5ALVLveU5KUyJo7xOPQAVT5t?=
 =?us-ascii?Q?3uDFDuCWpHYBOgCL9atfPjTnnTBp5pT03VKUeBxqYa0r4MJQIaamTwaFBB8v?=
 =?us-ascii?Q?DOu1SdPuBmZ9/hcJcgXtDEMqvXmSkp1DX02cNP9SbyPyH9LJZejyqhpipYyi?=
 =?us-ascii?Q?rDvBoaztV5AWx7xffC3qLCfXBeEMjfK077wtRBFa3TrcOdClnFbds1cUF5gP?=
 =?us-ascii?Q?579k5LJyE+pTaufOgIvszbHzzrM0dqsuvPC9R+0hci10s9OJvPpGv76MogXc?=
 =?us-ascii?Q?1HwSF0i7rCvmSAvQeCwAxWAni3oPwkFXz+56NmUwW+vmj6ALjZh5cTdGqnWD?=
 =?us-ascii?Q?QEdRsT7ee2rcrBEqGFCieuaeV9a9TAdW9WmQQi2PKSx50oZAydThZz9p7zhc?=
 =?us-ascii?Q?KDgcVnHUcWeaQ2tbGcAchsgH159WM4RYuo5eMSeH67Lo3KSuPO5ewwFUN4mj?=
 =?us-ascii?Q?BeS94mq4uJBrlt/esGWi08lpOBvUEf2cxo+sbS90QDaQ6VbKGf4GBSmUbga9?=
 =?us-ascii?Q?pf9EGUWHJc7r1ZNVfirbFNVGGbxwjhej2ZDhyp3e8J7akR7PR2OlQgXJ3zil?=
 =?us-ascii?Q?nq1zqIx4bei5p9mCo3TmLpgffVOWwZTAKJ6XSGWtCeK/6wFD7K3wRHOI5i7i?=
 =?us-ascii?Q?k4f+mQP1xaJFh56F/eW3SuhXGe9oYk3/eWKI2oFtbsyUJLQHxkN2FzlQbz7k?=
 =?us-ascii?Q?iLMM8gOKeLt9yAuLztRKJebftz+apbYkN/Q5NF+fQmssiT92fjPey+12KD15?=
 =?us-ascii?Q?uIOlMr2wEHyBzLYjtJpezdjvPOQq0fpKhn8d8ZkdzzAJGwrSrHc2/NeOk+YE?=
 =?us-ascii?Q?jPYcihDholcghPozktN484HygGUD1wRp0ppqR4uW2JM+gfTDNFJjrFsevdC0?=
 =?us-ascii?Q?JxBjmABu70WLpmx3Fno07fK5JVXkpgQ5RbPrbNHfkG1B1GA1vbt+76YHNG43?=
 =?us-ascii?Q?jRYKYewyvGsXWhovBKB//8uzZDN9uBPYe7A3HnCOSxvsz4KvP0og8rqUMW6Z?=
 =?us-ascii?Q?uztMH/POjSvN5HpxsoqfB5u2g+KRf95jKnnSAgoxekhgNng9mKu6NSFF0JhV?=
 =?us-ascii?Q?n7DmBqvZ0Yivkgr+08CiklVdJ+KS7lOSIFO59OI34Jj8A7O65oXKDw7yhWLu?=
 =?us-ascii?Q?aHCwakPDa9/awphuSKJw6+2BWVbGUSyqJjzq1SEvdzx+G93cf8+fyCGBn/yv?=
 =?us-ascii?Q?wLA1v3tIDxkaYDWLLPcsEmKyOMDjIUI8Q1Lbq9eVCEFmg/4Inx7/zRzznWCZ?=
 =?us-ascii?Q?o0W74kCE50WdHvJEcLpMQ5t1ylefLk+UwmlNZeygTQGIuzoX7cB/qeVE+4So?=
 =?us-ascii?Q?sNzbKrd5oe8I8UiAjWSdtj5rOVzzr8WlU0zl?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 17:16:05.3083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bee18e-c90c-4d52-4eb0-08dd899d059e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
Received-SPF: permerror client-ip=2a01:111:f403:2009::62f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On Fri, May 02, 2025 at 11:27:04AM +0100, Shameer Kolothum wrote:
> No functional changes intended. This will be useful when we
> add support for user-creatable smmuv3 device.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

