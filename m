Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02976CF887F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 22:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCh1-0005Df-GN; Thu, 20 Nov 2025 16:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCh0-0005DN-GH; Thu, 20 Nov 2025 16:59:54 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCgy-0000Cm-JR; Thu, 20 Nov 2025 16:59:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdA+krCaj1M6ExRYb9YoY35Zhdc2EY12ARnZHLU1WpNc0CxnQUd7UaKq9nwU6b5/Ax1gwzWd9G2SUFK7DO5cLhC9Fos4M6zVRzOXDSScFevn1JLki659OKHgD3TRRQHZqm1LNmT8XbIrc9ZpQOxWrCS1IFBX2Z+0gbqsrr/pO11xLLj0UvYzwRZYypsoRlBeKyqiB8SqtS29E/fbWPlwf+j7rwSBXnqW8FY0iUonczn3cpduptBfjmpWNIK6M8PV/gF4ffSsCl/MnUXSkPU9U2Askj/881bWdr3tKpFjdnz84OVDxEZfcQXRvCiTJWn+eRqOqXryEHAZwU0NV+nFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRvSzdiAcL0Y8fQprnBY2MWaQhdrU4czJSC5w/mnpOA=;
 b=jfvnTTYt7d9XEOjVM9/xCIuE0/HpAZa0Oy0TGCqe956mv5+/2xZTt9t9JeKl3K3qVml0TKU4yTUohkQPVapwC21q4XdgzCjMfZgVFzOMl6LI80fznSj2EPspf0T4GRMmf67exkMBOkbHEpWx7p3KVzJu/jcwL6POXTwHdZoYV8vEFhzgnDKBIj0qxVepYFlwyleSL4eWA8a2K4e7QrrKWh4d81JpHrg+3+Q9pGRlKxxJs7QfgmKU3PpuF/q1q3CjyYDRNY8IPVx/Y9GU6sDXSHyDaI8/U0DdwoaXfXGG3XEzdrllJezzyJii/oM6rLVD9JrPqe1bJF7kjAFhWes4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRvSzdiAcL0Y8fQprnBY2MWaQhdrU4czJSC5w/mnpOA=;
 b=qTj06aBdYAV/QxqFlB6MbqrL8zsBtsb5tvBeWpqhZT+qJPqXfW25EQgir/Yjm0Aedp3H487+I/nvskI0UPRsUZSsmpO1DuQUhYhLI9pkvKmDhOBU/JJtF6B72A/2BkrVqa5S9yqSIk/FcnnIOw7ASErAMciKQvL635zXwEGBeK1uNl7JhKHYQuLY0vheHDBymEKGkx7EuFw6FiF7vyqF7oVyzVta2eJ7ryU3PGa63qrCVV6fOO24VARQhA1CsIfS3f3OeVXcXo5ai5c57k+J94tbgQnjhpeREasR9lGPtwR8eQrAsu9dXDXR1HFW6HtQo/AejiZbv1dSyN1vf7k+Vg==
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:59:44 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::b7) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 21:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:59:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:59:24 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:59:24 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:59:22 -0800
Date: Thu, 20 Nov 2025 13:59:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
Message-ID: <aR+POdsUj11aIjfh@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-33-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-33-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 956881b3-65c8-4774-206c-08de28801cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?njGtVlopUU1vQzSRrovpv8AKrTUWxq1fYtfXfVYWevIl67uVbfceZV7+/mOe?=
 =?us-ascii?Q?MV1PpfP8bQxZ1WF9Gz7/nwh1t5cymFAAkOGuvmQyZcTMBEVSoSwfE0UTBm/9?=
 =?us-ascii?Q?m+2L7F8T23OHmY/+ghDhX4eviZyggOYnfGUoIfKgZ2p9/zx8/HEvyBg1uzWO?=
 =?us-ascii?Q?Iex17wxqXwX+E0VyMCzO2+tzszrQ0CGDIPWJC1/3kvKaM30TMS4hkRj2qJ4r?=
 =?us-ascii?Q?4tEfeOCPoOFOqlkSKzWm7NZZ/VP6HYikU03VyW5S3fDZaOXt0oIZvVO8Q0mm?=
 =?us-ascii?Q?SVG8FKZ6g6ULyXYvrgaMvxqf9ZEFx/ReFWx/vY3csL7bhtBkfJwE7Jp5Z3wA?=
 =?us-ascii?Q?zuxpyNeFPJd2JdsBmlcXeHij/n6bt1i9Uu8QaoQuQS8/bhg+E6fMphNNXK90?=
 =?us-ascii?Q?42SGsk7XpywuyW9RD6oYher2EPuB6LEKEt8JcjjvvRELBXyTvIVAkmW6W4ji?=
 =?us-ascii?Q?F+g6YDq3rKPektGiZbuOnQJIolwaQCNXknUj/WJHJ31kHDjHcf4kZ/b9HRDs?=
 =?us-ascii?Q?sW+GSXd8D46uuQMHNiUIiQnQsiyWviHLk6suAC99qfn7gwpuMfe/zXRD5Gq3?=
 =?us-ascii?Q?YLCeDsWoyJVUUjqn/ozZqcRh3sHvWlzt+FtxIiYOfgAdhH/ZBHsPH1aDERuN?=
 =?us-ascii?Q?GaELWMb/DUAwUAjsHQr7jwuULdLqaJ0U/zSzYzfsq//+ndHxn6xXpdP3N+sL?=
 =?us-ascii?Q?F82LgAJWwmwn/JVj3GmPgMaGrfAUfczzQMsIkglLRwe9KXGjhLYrVLwD298x?=
 =?us-ascii?Q?/WfPQzEXeQA/7elrC++spgvU/pdMC3XQOVLnFRiCEbt/zgyiQq4TWzvWDDcm?=
 =?us-ascii?Q?km7mkI40+Q6K91h/gH/mEtigbW4nYaS8N2+5OERhRb474LJYHBctKuRnWKu4?=
 =?us-ascii?Q?kAZoDJHgCkH+b3Ohm66o8kPc67K6qq40/FDhvBRoLXWuBXSxuUfojJwmgSU5?=
 =?us-ascii?Q?W3RmGEdZ/0LNhB+nWbsccicejxU4eV+w6qnjNf9cSv5SEbsjmsFTNAWflBjG?=
 =?us-ascii?Q?0K3xeWX5s0qSmZGsmCt/j/gayMyXs1605eMcuZeL4P3hDnXpW5d5Aq4NOlo1?=
 =?us-ascii?Q?xZTQgx0msQ6evYI/JYrvgRG65Q/tAzuALCLGT3Zc0Vq7xw0Kc03kLuONgiOz?=
 =?us-ascii?Q?ehxIXFxHUGK2hA4HzKdf0QtbqXFdLIQ12kkfT8Gy5p+Taz+V/xn1EP3WIrBv?=
 =?us-ascii?Q?phcVwTxW6qhiIh+4W58MpWqFNu/sW0t1xm/BG2nf6fQYS+qg4WoMqLMBvwSh?=
 =?us-ascii?Q?HUXn8XeuTdNWJlpAHWeSQLL/OIRJeWeY+N8t7dL2i96hP8eM1gQjGIjvUA8a?=
 =?us-ascii?Q?H0PF3rAoUGy/cybA6YLD3yaeFygh3LbAHUmOIvslz6ntXSyNuK09a6tLL5iG?=
 =?us-ascii?Q?8o4UXScqP6WZLheXVEgQLkTD+FK4YViZ6p84VRCy1oK+HVc7psMjTCtv3yU7?=
 =?us-ascii?Q?OnRq4w+kwiXWft73/xeCg1yZdOHIJN9OmhA3W/bPgP1n5ILAz4/gsaOtlfnS?=
 =?us-ascii?Q?FQlxrzK5vYMWP6DJjxaCGiDHfMABKK2+XHkxLUWCPKw642gWyza4ssOw547r?=
 =?us-ascii?Q?FnI6E6VPLsHHdXOJqyI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:59:43.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956881b3-65c8-4774-206c-08de28801cb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

On Thu, Nov 20, 2025 at 01:22:12PM +0000, Shameer Kolothum wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> If user wants to expose PASID capability in vIOMMU, then VFIO would also
> need to report the PASID cap for this device if the underlying hardware
> supports it as well.
> 
> As a start, this chooses to put the vPASID cap in the last 8 bytes of the
> vconfig space. This is a choice in the good hope of no conflict with any
> existing cap or hidden registers. For the devices that has hidden registers,
> user should figure out a proper offset for the vPASID cap. This may require
> an option for user to config it. Here we leave it as a future extension.
> There are more discussions on the mechanism of finding the proper offset.
> 
> https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/
> 
> Since we add a check to ensure the vIOMMU supports PASID, only devices
> under those vIOMMUs can synthesize the vPASID capability. This gives
> users control over which devices expose vPASID.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

