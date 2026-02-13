Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABD4EF99E0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 22:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr1i1-0007BL-68; Fri, 13 Feb 2026 17:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1hy-0007Ae-AB; Fri, 13 Feb 2026 17:32:19 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1hw-0001NB-LI; Fri, 13 Feb 2026 17:32:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4LYYPn1CA4YFovIm103WthfhZ2ezcco3+g0Pq8ZJPVszotdbU33Ttgjyn5Sap5dGGnPivPCLttR1EAn+CxCrIxKNMzWL3MiCg9K7Q2q+zX2B+BKXxH+U/NPiUa+gShF3J5mn565SWBCYKo3wv4URPTQQvAFP2wCgnpPkoTa0JHdoeuRX6nyx0hlYmD5XaTFs7cMbsi6z+1lzRc/bzazqr/+HE3noiVRDh8eWvzY6By+RHHhDl2Av6jeun4/ldai5DqPS5exgPKWyFoPl2YzAr3Qyy/oKw+pXPJ77Ldi+XE5uYPQsAFs1wBKe800bg4ztDPnfd6eZ8S5ImJB1LCTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5faBIPDq0TZ2zqD6dYFbWnjdgSpd6TJhwmLdWdkLpx8=;
 b=VKH/zydSQoh2yefcg8uTe9xwvE0CPMMb7TR3d6TYHYfnMqsu7aKWjkQn+BME4sgbdJxuTzWUmRM2OM6mCHtSH/i6kdK57VN2CXa9uqhGmcaxD7co+wm4kDSQb6LIqSdzvphsJLEx415LuvU0B7ltWpjvwkxrDRARR1Mn98cqFHRXC7Mkc7S4RKPSoWUdx9ubNsiTQdoz/EQcZ3nKoTRiMrz7XipLhskjrV1KFK28lY37J9mmenm+wWqzyrkNlMlGRKfYFbyLXRgFspPMJVhNwGvoFBYgNENaLGjaqHpC5eSKkha9UmgD5QhoKPXScUl1EX49rQFm9C6IzzfyMn1clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5faBIPDq0TZ2zqD6dYFbWnjdgSpd6TJhwmLdWdkLpx8=;
 b=jmrSVn0bJrB18qv9sSr0w1PeZRSJh6SDwou8mUIoyfLb2C4YtRIA4H0enloaYW43VqS7X407SOqnTjJ7u4avfjvSoykdFuUrZ/qcige9vC3WteB9Icraui9fzEnb1cpZqkCpJveyLcFlPpocvAYq8F2gf2rk9gCG576yQ0xmbWoX4EpWys4Ro35DxhbCr7mbCPnNTtulU/LoIhkMyq9QLg3qTYDZq8EmfPJ2OU6oQFPbsQ8Fuck5UeH/rE0+MOVVOGmtq9OfmVHhGO+iX3yio8EoznvVSHNT1t55EhvUq39PPQRysbZBr3LpJIFI26XEPa40HnLEeX8/7biS5h+cfQ==
Received: from BLAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:32b::13)
 by SA5PPFC3F406448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 22:32:09 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::5d) by BLAPR03CA0008.outlook.office365.com
 (2603:10b6:208:32b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.12 via Frontend Transport; Fri,
 13 Feb 2026 22:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 22:32:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 14:31:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Feb 2026 14:31:51 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 14:31:50 -0800
Date: Fri, 13 Feb 2026 14:31:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 0/5] vEVENTQ support for accelerated SMMUv3 devices
Message-ID: <aY+mVQU2w1S3bc9p@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260213103942.142823-1-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d17b667-f80a-4109-82b9-08de6b4fb964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EbflmEqxyywIWIHczrSsZwuflOe2pU5nEEFVfvKB5J2ZWgHYgMlN+A91lpnV?=
 =?us-ascii?Q?zdlqro5Y2W25O/KOMWgn9+WGyTN/rQmN5+ikrPkkLQovCVxQwSdnebYPmCQw?=
 =?us-ascii?Q?zWTj4NEJwiPLiRvD08UHWaSxgxgkajFPe+VOKoVRV9KwzCWNmUF6Z5ABOlWf?=
 =?us-ascii?Q?9kMtP0D2Gr/aSDxv2fPRcbltB7Nhw9M6Z3fmwlFcMkx5iLX6U9nNzIpSzMwZ?=
 =?us-ascii?Q?Ku4MqdGbv3a25awNWpVfCFX8ukdwY0FZW+Lb7TJd2+u7B9RWcyFbGUHm4Wx6?=
 =?us-ascii?Q?kNlyhK+TTcru4UFhlTNu8CTnRRju3QKW5ZpvHDjUg4+cafw7GQwgJefwKXEK?=
 =?us-ascii?Q?T6qybCpdwGyvPmb1eLIBsUoNCEkiHazYd/vSWDTI+bNYRqTwOqh1Yi9nMDNZ?=
 =?us-ascii?Q?/9wT3uhKHHHENkOIY/aY1OepPPSXd4mKpWka5RJO93VLxdYweOF7dUPRPBuK?=
 =?us-ascii?Q?eR34scu6sQVoqj4MvrMxfOzE/I+ttB9QxVszZE+LzWuM/LSRNX8/61AyQSsY?=
 =?us-ascii?Q?urNacnNj7TkRkFNL7URRDQg8BSgyFSryjUckxxQoJ2k2W15Rpv1WDrXLkeXL?=
 =?us-ascii?Q?W5IHbIB+oR/CDBy+HIcePQy+uEhXtJNznuWceJSFwrtB6KJJKtOW9Ncp53AI?=
 =?us-ascii?Q?J/OtaA8rMyQcTOaiPys9QPmW8HuU9+yOGF36zpLUcehmoQwpWKRTGsuDJOxd?=
 =?us-ascii?Q?tmEHNHGvMCuKjYlLN6pqSg/VwBDYlOTqBAl32vWTCyWroBEfkkclskICy04+?=
 =?us-ascii?Q?weuyt2wHxiFOKBPf+Ci9Sy7ZZcy3P03RX6r1IEmWjJ2flkpp1GzGT7tyCzE0?=
 =?us-ascii?Q?QQg2cG4W3VdzKq7oNzWEggEpsyUWJDMWvCRjqAVrpGYl4kDyovdTCPH4cPDR?=
 =?us-ascii?Q?ZK/WFRsoxbQyUZxA07VrgfjYOHKn0+cz3pmJoux6puiWePz0ZMdZxg69UwGx?=
 =?us-ascii?Q?LvPZSBpcHBBJZgeIEPN3IGb8jbPRn7JRZMIrBrslW2PIMKtBTZVnASeLYvQw?=
 =?us-ascii?Q?+BlB3yVKzQXFc8xPX+enW3/1Iv+tFtw1wJuA81hSGEg6pjr9P7VKxpUSrzNz?=
 =?us-ascii?Q?JpwkHbj9FszrDVWd2MHQTmzThWxwx2Leq7OK/ozzOAAKzBXeeKnGQy+kvAaw?=
 =?us-ascii?Q?wHy1J7kTabqucQY561wifqYndHI8+gZKi1LzTXFVnQ4GqLYzXeDQpY7DS/3g?=
 =?us-ascii?Q?BTuyoFfv9kwQnDTKZpPkbAETBH8AGLZduYSeS3ev2obkJUl01Slvpk0VwPDY?=
 =?us-ascii?Q?TeO97gSVQ8jbFo8Efn2TPlrVwJshBbg+ryy8kVZAndhwkjVvjUhqP6gvlkKs?=
 =?us-ascii?Q?szpERU5itJ/Dp+uJfNnUQDAKi8A16+yIWRqVHSWEjV/kn6SKtOLIVo0MgGa3?=
 =?us-ascii?Q?0C2giIT29QajYa4RdOT9xYoXrwlZpgfaQnW6T0DzTis+Uwv3vBMg94Tnt7hN?=
 =?us-ascii?Q?GAkfo7kbih7mGNk+kkdp6TCwZq2XTbRResj1tr1DfuFIPb8t/ASocqNvFkCt?=
 =?us-ascii?Q?xZypCyzlq/Vbg8DXEgWxJTL54ETVAACykyL0r3wdbh/X9d6ijfEhLCSs3R3g?=
 =?us-ascii?Q?eLzbVtQvw+9nIyVlqZvT2ceZuKH9VK2OsW+ky9n3+LTzKne6jcg6xeWR9kzG?=
 =?us-ascii?Q?6w4+U1OyMl3hO14k4n8fQhczuDwm3b9n+FHJ/i1bzh2MtfnVZ2faPzfz5rxL?=
 =?us-ascii?Q?q9xhvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zPUKDi8iKf3uS5VBlBtVu5YJBdYkFhKy6Q3BNt5f+lk9kSdptqq5vK7foF964fXrF8hLrbqLDzG+mnfNHZV+IR9qqK9X9iqfr5FQHsLdDqS/0tPIWHAD7sMWtg3N4+AggVAVDytul17DYTeYfriAgQD44BHGXp7zQvEZAgQo2CjBtiV+/NsiKlMZTFvHIdkvSXwU2FTZMditHpEevTQGFKPv4LbiMRyXyrD/sPl8pPnJbuXmfTcKrl+Dtky7sxXhIQJTe1huo04c2Y8S1/6VvESVIrMo0Lj6U5VqWe8PdFJGdlhGrdUlSQqiJxfWXgm0cbPGPUsb10FcgqzaZdxrUgnOP4R02VSU8THzmt57lITQEEZ7qP3lzXBjv+JJyyW1Q3ICa370ZfZA8z+qpaT6QVpwfvCQY8peD+EQYBCmYmlQm8FKgby56aplUST4PiD2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 22:32:08.8237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d17b667-f80a-4109-82b9-08de6b4fb964
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 13, 2026 at 10:39:37AM +0000, Shameer Kolothum wrote:
> Hi,
> 
> Changes from v5:
>  https://lore.kernel.org/qemu-devel/20260211083415.133534-1-skolothumtho@nvidia.com/
>  
>  -Addressed feedback and picked up tags. Thanks!
>  -Decoupled alloc_veventq on smmuv3_cmdq_consume() (patch  #3)
>  -Updated error messages (patch #5)

I tested by hacking away the RMR nodes and msi_gpa to trigger some
translation faults at MSI doorbell.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

