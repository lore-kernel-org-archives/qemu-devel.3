Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A5EF99E0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 22:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr1W1-0003sa-8y; Fri, 13 Feb 2026 17:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1Vy-0003r8-JJ; Fri, 13 Feb 2026 17:19:54 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1Vx-0005Uj-C9; Fri, 13 Feb 2026 17:19:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGyqLLC7Zvu2deNJwVDCJQQpuJLPQrOFVmzkjbskebJcj8NdeCBirgJ0ykskr1K09LZXoNh96OlF6oTGtucn/K6/gbN0Fp/b1HUzUdyVXzTyrgVNxh7YIkqLMUmFni26Jpl4NZFr7xV8N5tD8k2VqoTatXW1rFe/smkFqcF3P97SWeT7dYouGA89QaHD4ODnrdXi/ubxRPsqsXwN/j17u0qwqHGC9GSUmSNRARAK5TOOX/QRNKo521QYPb8cCu7IglfOgwIupfBGEX3qlrDvuhyDCPfi9pIoOAx6WHz0NzgEwyexo1q4Qz7C1hmg3G/JbBSNvq/Wnl4awDz+R3l6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfGKzJZt6nqtds3yN5uZ8jUXB2MXocLBPeiglx7JywA=;
 b=fOkQ8NB96rATp+y9Ly82njaO20qkHM/+FrV9O6NICgXxbpdXZW6AIZOS86dBA7cDXogxsESJlzDoOP4pGUvdROyJCSvxVEbnSp8G/MFGtosuSb7QJG6GrM3lwNcwhJYaMghASt2p9mxLYzqiMeWCW4h4tbeI01dYG1VQGWCNMna/c3kbuObwD5j+CXfdC7iSZvHmGZkv8Mh7AxLgT5St9mPiXoE1dMrGpgZyMnlgxDvUVic5oX1KauT0q63Pm91gKG/zwfCJln/HHtExMNMp47QpwQfxkNy3Zn7uKkexLonZolMdX03HeHJTw2QjUE+yFSO4WVEGjlgq6udcdJweLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfGKzJZt6nqtds3yN5uZ8jUXB2MXocLBPeiglx7JywA=;
 b=D1KGkftut6PwrVaEq5meQtSZKePpZ3SdUG5Xw/6wkuhXeouWeAra5jxAv9HQsc3nGyegn5/bBgA1L6Nmst7RuPo4jWmah/ukv0EtgV60tf/hGn++FL4cRJQeQ3lPUx+wJ5aS+gicSlpbSzdy9VTL5c6DVQWNLlQmS9OGsuCiG5fOMGeowBN3XIT39HExsDUwc/LvxhZJ6DmKhoHgvhP8FtkJmobCKlc5n21wZCKsZtFcvbzZgf4psKKKZxj3ajXYDYCNsQh+Lo16xJ39dVa8QvkmfVhoWwv6wrkhVvLTNmqS83cs62sLMuXBIi+CQ2E1he4Z1CQ4LzEALhAqS9E4OA==
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.11; Fri, 13 Feb 2026 22:19:44 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::fe) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.10 via Frontend Transport; Fri,
 13 Feb 2026 22:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 22:19:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 14:19:32 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Feb 2026 14:19:32 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 14:19:30 -0800
Date: Fri, 13 Feb 2026 14:19:29 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Message-ID: <aY+jcfiH/FmxaIa5@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <20260213103942.142823-2-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260213103942.142823-2-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 90eb5493-28ce-47df-7665-08de6b4dfd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xsvfQ2h3SQqehevnaWB3VVA+R9kLQqZeI2v78I73RW8aGhSAp3V0w4+D0Bma?=
 =?us-ascii?Q?5oEMH8l/qXzq4aQU5NL77b5QIdkGkvFjV6jm8qOyHqPAV8BoLiryHt6+w9UO?=
 =?us-ascii?Q?jSzdysW/iDhcMwxCXkovgJJgkow26KKB5k5+xqSqzurUv81NJpUBoX3uA3nb?=
 =?us-ascii?Q?sUQh29/Ws1n5Rpb8aIbzYa5W52047yiyXRoUrmUN4AHwsimSO7l8mVLsLX3t?=
 =?us-ascii?Q?+0dzc9QWik9Hl0gJOnrGlCX5/Z1vUWEmpIchrF51idURKvaYnCSg0kgWZ3lE?=
 =?us-ascii?Q?jfRaYn2BMMY+JrDmLLGj3Jv9S2mBOCQpdSufEi9xyRl1bdnzQQo0r1OYbwpx?=
 =?us-ascii?Q?V7DzdlW6hlkzx4siyK4l+JvZVYZQV5N2WiUjodXY0dMDxYr9ygtjbWxXQhsA?=
 =?us-ascii?Q?3RW2Eq7WeshkJtEMxm9v7lYsF4HAB08jQtaIJC8hcWc2E5nGsLeT8tKCGkA3?=
 =?us-ascii?Q?KXMoSdEpLiIAXTsfUpPrX7fy5ZBU5aHth1kh+bBTHjaoIwZhXx+ECBgnOmn8?=
 =?us-ascii?Q?3NYMwl40oF+GsQB3IE6sYzzQ8yIgUxRsCeYA7pIyZhRWlBpRp2fYfJ3NF1JO?=
 =?us-ascii?Q?uuOQDw5O7YSTv6FdFMCzrnULHli/LiDd5GJx0aMps9MkahCRswMYv0kZEfTU?=
 =?us-ascii?Q?h/Nap3zc5SePviFQ/L9A6UI/kzPYqBGMrLyyQymTwmdo6VdRQtncEaJmy4Cc?=
 =?us-ascii?Q?N0JDUN9qa5HhFJI2pWx+ceA24EVFbaVJiRNS75qWbeiVC0lLaW3M/hEqdY3U?=
 =?us-ascii?Q?cCgdApNwgj/+PEHcx9KDsOaiTHzAA8PdeIG9d84KWv3Diwehps+7pXjAFIXi?=
 =?us-ascii?Q?AJ0xOSKBmaUoJ/JWakEX7gdKTuG5J+Drwvifma6goiP2vhIKoobmROxitGr6?=
 =?us-ascii?Q?ILd9wVsfmi0YLhRLz+9Qnaa70HhWgaX+3heacMnmhlQkoXaUA3IBeNNW5voD?=
 =?us-ascii?Q?FvTMS/7e/2FVbmX+HZkpkkFq5slIHIS35aAOC51G9mHg+SEwDro8miFxzCxc?=
 =?us-ascii?Q?terRPQXkmGcq3LRiAcoFZvQrhy2nMw4aJkZ2Q72bVTjH4sLUfeI1uX+AWHdo?=
 =?us-ascii?Q?zcoO68ubGYBJmGRNoxfswWyqv+SeSosN4Y+LuxVBUuuAXqae+dSJOu4S2Yfc?=
 =?us-ascii?Q?oWvkm5kmZe2VylutMA3+IfLllCkZ2JF8nXrH0f2EjU0bFMB9VFaSQcobhWRU?=
 =?us-ascii?Q?5eOrmVE6z3hCAzKb30bbYPMudBu7SFAyZhb0ZpaCyOMFZEpOOYKLP2vWKllE?=
 =?us-ascii?Q?nOFv66hT0o8+CTmsYPDLyylhl/RlHdJw26Pcy5waM5ukH5EuG6dQ4RbPorAX?=
 =?us-ascii?Q?QHs4RiLtFcY486uZgxGlK2X6ssDEDYLzLgoGeLadWD2zJEHW8FH5AJ1yN8+Y?=
 =?us-ascii?Q?8GYYBx0Dxr3YE/jgmr/I9rCSq52MtOrmIn1QtBSDISZ9nO+hcFgi8FUuqtX1?=
 =?us-ascii?Q?0/7R9pQVZzv/DS5P6W2ugeZrGT3H6CatPjmfYUtTFXtiOGaK/i9hA/LwEv3C?=
 =?us-ascii?Q?7HtdL333s6k0NQO36YJ2ZhcA1VBNwcGaVwVPfrIPAHTDGQ/etcbore4nqK2X?=
 =?us-ascii?Q?5JV7XJEGV+8/rxqch8B8G5cmHY1sw6ynMATdVPL+fayypy6oX4NX7yZCrC4v?=
 =?us-ascii?Q?U86WSDoZb6AF/4n1n5cyUVjl/GHAG1BKiVJhK8LZ6RgdOJcENplgRJgKSE2l?=
 =?us-ascii?Q?h/l4tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ApthnchZbPjA3A3th1G7PMY4LVyMtpZK95hfOClNO8rxqLBsTPUkPDJlO97LyQalLR6ZxwEoC6QfNPl27A1MAuy3R5Wv76k9BQBVRMCHvONM49WoGrOSyLS8GTRluzKP3HVvtkHC/qv/cfnCsdLS2QADRgnDX/vhouFd56nVQADw+OUNjTgf7HLNPZchXwE6i/lvRfhwWcbh6q7Us3SUSio7v72w2WWIPzjeFnlECPxw2KTlUWIY5ZpIqni5Mkym8LP3GbipoYq5J6AfocEg4M17v1iF45/JeDSnX0q/rCtc6ey8Mz7NBF2DQZbT33uby0UYFdvBTF7r42amnk1lIeynujRusFJUTkKO0O8Pd2pZdVdgFd6oQnzFgLJt1s/So6f3JghlKnkyG6rP6FdgfCDbRr9lip+cnPybMpaf09ElgBEZJIanGM1mhiWt70E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 22:19:44.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eb5493-28ce-47df-7665-08de6b4dfd90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nicolinc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

On Fri, Feb 13, 2026 at 10:39:38AM +0000, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
> queue (vEVENTQ) for a vIOMMU object.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

