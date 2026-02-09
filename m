Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7927E94625
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 23:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpb31-0007Gv-Fd; Mon, 09 Feb 2026 18:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpb2x-0007G0-4K; Mon, 09 Feb 2026 18:52:03 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpb2u-0002ev-FU; Mon, 09 Feb 2026 18:52:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhmO3E0A1BVO2SPrLK7zisdxIrXsc5Df1gPJB+Axz+oa7DSNjiiCE94FGFc2/3xfHOXunbWcNgZGx2tdCFMxv+65Hr+IvqxFyI/yQWOPz1eT+EBk4Tp4Gmz290ihWQQJmoxd6gCRgbdW7XSrbfIEcz6evGS3njGqyx15Zt3LxFO/XsbzZ6jZ3chULTdzUamzoEJLT4FtiNkJ39Ysnrs4+u3QFTrCidsDXuJRIVhi2Msfi8wF31tWAd5Ltz5eL7yPkxfymHk5qjV2mlik3rvyWqvWMarQk8zXRHPK1P9d1VO06xyWgnMlqzd7JjF5S/7HuEcWPcyjiMdjeIDc2EiMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN/5EE+5He+XDvKjVAdqEC72juGfbxNAN/prOTb42zA=;
 b=vpAfhSavHwX1YvxxLEEIrZeAEC2OQEwWu50nW0L61RzgwX9PxyXVpE+Ya+7qd/isuoQV9+NCaWJtL1PT6yV/WGLlS1vbMRshult66uQ4A9TDPRWjIJIT6rA5jQ3qy2UuUa35lA+M/WV86BpkzoiR2aC3T2/4ziF9b845QurHxunXgA+ZGegTcqpRTxNJwZpTavyrzJSSxNLwWt06DcLcbcE+XcXfEk7nwi/vFDRrYJ81zBugy3sK/67H+wegAtzdC2itEvLUEsKiZX9d2WTtwAgMw4yhcbMoXacDqfd8MM+NwckgdEPWJXopPMpOvFyvmUn+iO7EE8VO9zaMlXyxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN/5EE+5He+XDvKjVAdqEC72juGfbxNAN/prOTb42zA=;
 b=P3FRbhqJv3guB9Wbav43BDmzVSEM9UQeduLpv43WTDBcshM7AXUFX6Y4sPquL1KWgAFyzlzaSCr2lRbpIeVxKKPlf+MbERi09t46/63p3sD5+Kahnj60ChnnGlPV06qlvWA4rOqcsw3DufMrBXxnCYfaayoKHS0M0RRI1aI9jahinIHvHTJO/OCQ3ZB92lsgbni5r/chVn52XRASlil02/a4TTsiTSJlCkkQetV4Ilcr+FG1iAvwm6vyf8x8MHo/ZQQOFnlUHNY9nQv2kL4xjm7/b9IXLocsnIxfMrAtuGuPxKtHD/xDvaxNv5J6T8ODwmixqwh1mPeWuT22KerK+g==
Received: from DS7PR03CA0244.namprd03.prod.outlook.com (2603:10b6:5:3b3::9) by
 CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.17; Mon, 9 Feb 2026 23:51:52 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::5c) by DS7PR03CA0244.outlook.office365.com
 (2603:10b6:5:3b3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 23:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Mon, 9 Feb 2026 23:51:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 15:51:37 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Feb 2026 15:51:36 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 15:51:36 -0800
Date: Mon, 9 Feb 2026 15:51:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 17/24] hw/arm/tegra241-cmdqv: Add vEVENTQ allocation
 and free
Message-ID: <aYpzBh4/E7jzp9p5@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-18-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-18-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: d58629a1-8780-4ecc-b9a2-08de683632b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uyJM/wYLueMDl15QgXMmkw5l9ECylTDLwItOWpJfa6lmrCEUMJ1pwyA/260a?=
 =?us-ascii?Q?0Ak2sg6pzeDanVIxePisr5mBzjRq0sZ/a7s9PBqrHqZTJRFCmtLDh1DU7xJx?=
 =?us-ascii?Q?LKrRB2ueccRHqZG3W3MnsctIYlx7xckFAHIlZyKJl7BsKj/2Dol4p8MaDE8r?=
 =?us-ascii?Q?YSGfkkZiARV8U0Nje7qGptcDOHPn0HTM6ftmZv2nCBb4b2HWf88vccT6aFIN?=
 =?us-ascii?Q?hDneK8WoubIfew9X/mWjVtViqESOWalUZAfphCus/kvLu3Hz65oWeBY1koFi?=
 =?us-ascii?Q?lly8lPBGcen9tGwDzuS/EXEHFRp94OvL7qmzqGzy0AVqvdQQtiWyyDV/Ia0B?=
 =?us-ascii?Q?kBdb1i0FPy8wxYBA8G04Nwtk2zKtxigiN9BZ5uTj5ncFM/4S9msP9aOVRz8y?=
 =?us-ascii?Q?hwBX66NKG76RmFGqjovC4SHN+mxfhdDuOwpzEJnkd87KcoWna/YPtQa+C9VM?=
 =?us-ascii?Q?UXCvx/xAsz/Bn3bRSWZxOw2ZE1EQq6aY4nUDgDewUXjtcz1C2EO4KdVbKg/C?=
 =?us-ascii?Q?0iiiRFKtcbsUUl8rMerth40wqFzfQJJDNltO/uxlVGXogWiCk5ppG7q9L2AZ?=
 =?us-ascii?Q?O5qgNXHjuTwXxTpKdw6Gerd25vnxk4nNgf/suASVI3tqZUhg1shHYGM+RjJb?=
 =?us-ascii?Q?RubSMNLszqIYqast707+950Qd9ko8wspBzu1m8IK9eArvR6b2gpSXr95KJtN?=
 =?us-ascii?Q?jiXEQLapoaJase0GkL8E5rQ1LerNxUOAPonZC4hA5gRGg8uykHgpgpAz+Jrx?=
 =?us-ascii?Q?Rv3+HBUMrYEltvbpDFxdgez8r2fV3tEGbdKvvASFdWLcxXavF2+Hr8E+GVVu?=
 =?us-ascii?Q?6g2lEVDt4id8Fn9G3aw7MnYhPzBidERbaFNGxA0LBzyeQ0XeXSX6kGHPHNf0?=
 =?us-ascii?Q?2uFwif6Je9rZGnjy2Z/Yb4QxwM6NpRzJQE55hN/dLPlZQwXBe7VnAd1U+0pQ?=
 =?us-ascii?Q?5d0fitKcuIIaUcqH7lcGdKeJz9YyVIEo80Hya8GZHXpN9U35wKURAv4FPmIj?=
 =?us-ascii?Q?39lPnQ0bUqp1JEF0ybdA4CCZdffkMVZf4m4eUy+9QsHXIGjl3YJfG9EblSWo?=
 =?us-ascii?Q?y2tmo7R2BBFTbMZg1rUOQrnMW5XaDPgiKhTD13d3QN24LnXf4O5hsFxCy8rg?=
 =?us-ascii?Q?gD9IICkebSTWJggXfGEluFspdfs8OAqQnnAyKTLhXi6wnpR7dG+jGBHXBXQ2?=
 =?us-ascii?Q?I+Jp64n5uqvPIlbykYnVuMwkX+uDz0KR7O0Us73tQNzU7hX1OOguKt6z0Z9d?=
 =?us-ascii?Q?k94SYFKZ/5P6WqecietcwrCoCsxYU7m2SrSpnCTPPo9BYXvfFrxUjq0ne58q?=
 =?us-ascii?Q?Q3j4CZGx/LwCmmwb3VskokAr9cs0+EQwMu7gNy31/sxPRRLQ6jYmnTHvxHsZ?=
 =?us-ascii?Q?DNd67DaMnROU0Swcyc6OxvqJwA21Ifd0rifRu7JCTbbzgk6oiJfa2yeKSh9a?=
 =?us-ascii?Q?jexROY6nS8hrlbHKLXNvbt+sQJTq1f3dHFoERK+Gj5tLYVSCGo5AgPSQrX7V?=
 =?us-ascii?Q?oZB1uFrHfAzzseQAw/NjZxLhKIgi5QMlfkw7zRodcSczXP9VkV38MP1lF3Vt?=
 =?us-ascii?Q?eALu/dAoEEth9rF8ASClJrfTCQgXFfPVHYu2Yjtn8qLI0WAbz6YAqZDWiXRD?=
 =?us-ascii?Q?5lYDOLCVGuwp6TXsABkrSxoUn5MDmEwbElrmUedzKIrEuZ7eKWqMD2OdIg46?=
 =?us-ascii?Q?yB1e8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3UO6VglzyfHuyGin5070bzusurWd1ml3R/Vl5lHMaUn/9sHfStzYN889uQNq9zTe45cYpM6vce4NFEddduAUlgyR/oqcYcqztcrC5Vj+rYplnIRu6QNjNhPWTl0Bxmms2XI9bHVFr7eqS4wjRMhwrZkDaWwW84DrGXhCpQexkO4NApWYdXFnw8KuZ8elZFdSmt+bZH49ZsZ6+J2DLc/yulu86z0lE9bySqRZSCv0YRCLdZhI6VKXKNGZT4uWYMkljWnmjZKbUuAFM/Lf5Iexu2V+/j68eyq+UcbXtX5W8t5gJdfwGZ4spMNijG1tSu1B1c/fveIV4Xalrndke+PDFDf9J+ZewP9OBZdQmECnmnka3qXTEoV/T26Y6hYT9/FAx79fPF3qbdyau5qhlJRR4/1pxxzJMFCgzhiLNNxXa8L34UxIOGkYF8xEa1e1BS76
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:51:51.9985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58629a1-8780-4ecc-b9a2-08de683632b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 06, 2026 at 02:48:16PM +0000, Shameer Kolothum wrote:
> Allocate a CMDQV specific vEVENTQ via IOMMUFD, and add the
> corresponding teardown path to free the vEVENTQ during cleanup.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

