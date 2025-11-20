Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E770DCF887F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCYP-0002GK-2J; Thu, 20 Nov 2025 16:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCYL-0002FX-Ut; Thu, 20 Nov 2025 16:50:58 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCYK-0006XN-Ey; Thu, 20 Nov 2025 16:50:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFTUc+BhpjQtg4ISxr78s1EjeWdBB7lHDbTLwmwKxKbyilAdEw+JT9QSsnW9FmF2d3Vgsmr2bBJzD3VOfLqBqtVDiLh/qCWYnuHL8ew2AL3rOPnUhUcPWBZEX9ycQ8vdbWOWQLNyL2tRv3sQ40jiclj5+VrJFBNDvQXgf6XqWgky/Bir6LqCjS9TtjGty/YLtqjR+6Jx8m3hKSuc4tIEvHBhGORti4e7o2Sp9VHdaM5ZTpC9KdM5KWMpDaMXY2ff/wWpADxPw9sS8JIpT2AU39AQspzBXA4hW017gnPWnRB1O5TWghtsmcaRQkdzK77+3nfVg0MDbuckD04vm3ytHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL5XcNcObupFS9zylHEwogSQ+OLEZjpvpn5UO5LtflA=;
 b=f5qenAvqpYA0a0ZggOw5E4qXACUzYbXudbkSWvJ+cJCXZ4WJ4NR85nDyhKhZ9qW53NGeYktUhBZcxaBYxMgo5F5DGI+FyFADMZPhNW75WQh7KJFhj9ET6MyI4IpckZ3RdEe9LsET6N8EdTlhYdtn5FH00GMln4IQSbsrQir5N/OJ4ITR3hrRrGWpq+pT7FQgPwFdefnjWA/SjN2xL2QwaGG0qK1L7iyJ7GUOOlY9QCLhieB4tgGnTLrM8D5rXjnPpGid4McKcF5TUnNFy7nq0bVK/O5xYmhzhtjhdZ936PYKbvSKMhdl+LMbV6lSDvJeYrq2uju5aZJFbImfQfrbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL5XcNcObupFS9zylHEwogSQ+OLEZjpvpn5UO5LtflA=;
 b=TaNg0Zx5DxCAGB8Z2iISh8fsOSlCnDox/6BOVB85Rz/eJhVMszQU9LxRy0zFzWW7a43INTE3QwuJvFoXrnCcoxZW9bWtW9tBTGiTZTD22gTmCDqWG/I+fdNxefOpux2nX8J5vIIVyq3GrVXO1uDaQDfSZSMa72aB6guo02GVIGf0bgOKrQN67rdJeBsoRcLgMFb/JLDref1t49rN6lXEn8CsOtsk/m5UEZXqxzUShBnmJPHhVRUQNxcApLJgnParQrNpIZDxvFL7tleqbWGoA6W6j5askDsduLTIyn1VBRrpnMOMVS2/xg1jjHGaYlBeYMTj6Eh1XYU5Kd9wNa8ElQ==
Received: from SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::13)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Thu, 20 Nov
 2025 21:50:48 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::a5) by SN7P220CA0008.outlook.office365.com
 (2603:10b6:806:123::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 21:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:50:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:50:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 20 Nov 2025 13:50:26 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:50:25 -0800
Date: Thu, 20 Nov 2025 13:50:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 30/33] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Message-ID: <aR+NIE+n2P0E6m8e@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-31-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-31-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bd5d8c-b0bc-4034-c5d3-08de287eddf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JWn4EsY4dUNuqoYepRlCcOS2uXTPgm8BO+se271k+r9z/HufEu43UrMs53dp?=
 =?us-ascii?Q?K+wZZYuqu7ddHHrD7DIXx+6RipOjbz5SpHCooRi7/AQcYEJTfLAAnAC3fqfe?=
 =?us-ascii?Q?KrErXIIhVEuQxWZSPs+Mdq7oAK09NHmXM4vwaZtKIZJAJHfOak+aofX/I1uA?=
 =?us-ascii?Q?zhlTYViRtydrz5VQQh5MwdfL4cJ+dS8aaXQegh3u+aHv8nFLVdTtaDBjidVP?=
 =?us-ascii?Q?ah5ooF93pGb5PqoMlMpdzrtHZsoOvr0xwdIOPeFOJMXadwdbLVE8Bbl4OyRG?=
 =?us-ascii?Q?WL40NyU/5oOgAfPLNY7wUerN7l6RDdfnjBMB+4M5u/ozVm5KBSmr+70hBwvi?=
 =?us-ascii?Q?1zlZmn7y9TjISoDgik5snxlNca0FnUo9khU4z/csNpxXehgA332O41E8DIjj?=
 =?us-ascii?Q?dZO7WGGYAMIvAXzTvVw5yFk8wS37057R552JSYsw4nKalvZQfKV7VvHHZDw8?=
 =?us-ascii?Q?bezuBnXL960e1AUC9G0msmNJPkLm8I6J/HBw+L6cZBL63X8s0OweILBeJfl9?=
 =?us-ascii?Q?buJGJKkS9MVZWd+QayvGwD39wF+LDVSwR0DWbR37QLQ0yiLXEDgTeWMJaPcT?=
 =?us-ascii?Q?w04PXcCYL+fB8tauyMn/3nLnL0zQckPo63mKBnTO7hq2ysQCHOsOisAVPbsZ?=
 =?us-ascii?Q?ztWCDOlHHW3QdtNI/B/7Vh4/4phuRCno7QPKqzfjKn3hoDFVKpL0uccCofwz?=
 =?us-ascii?Q?DsQi8nZkX2KYtLF9AfKyogMA/B82tXhYFwtq9eyDic3Zc3HfgpZ0x4ogX06a?=
 =?us-ascii?Q?tln2DDxB9s72CKJunfhjy2lhV0zNZSPGmILkHXBJCxjgFIB8oq8k0MBtTAEa?=
 =?us-ascii?Q?R+4bVxKU0+4q9V2i0L+wOfJTbiEIxXjUKc2cdl7HVeSfhmi74L4xzOZZZVpB?=
 =?us-ascii?Q?BiEzrKWTOke7V4lmJ3BbUlnnIF7PYtcVaxUNWBvduy42ESZHmeUW8G7gqnNc?=
 =?us-ascii?Q?QwIAj73yOhqeY1i3bXNwlcVT+KyNI33aWxF3ouBrTUx1Zmiy54sJ1O7d0rLg?=
 =?us-ascii?Q?Tp1luWg30zXjcx6dBcnvnY5NVI7k4tNo4KqGG1CEd9fdloj31dXqkQ16fS3g?=
 =?us-ascii?Q?9eRKO1YOgugrfny0PK5yJDLpCuiEoOolD7EmSjx7toEHComLFDoHaWZTwvm0?=
 =?us-ascii?Q?JgJoDER+++IRmZehJqgd/3CghCSNYghu/XS/gFkGLrWlJ8s6g7B7U0qMOpYv?=
 =?us-ascii?Q?mgc8uWnUbddPj/hbLMOM2UbILaQl++c6cZxp/qwpriaUfgdlOMhO8P03JuIJ?=
 =?us-ascii?Q?zSFPlF7029qyB/rsBk1qONTRVaJJuOjQ+BxleuWUgxUqBYljKrrwCt2CmbtZ?=
 =?us-ascii?Q?3sW8SDeCET4vawID1mF8sCR5hyGqb8Ja1fH4dmvgEcytCU4WmaiSBW0fvjDq?=
 =?us-ascii?Q?1i36ga9CEQDW98DArEvInsqkyfnAkZxMN4CulwboabLNkrPGwCJ5uRnFegGw?=
 =?us-ascii?Q?Bf6K8lHWYe3q1mbterjKMF3rpREcBbgem979pdwbrbXDJOg7Bmm1mrK0H99X?=
 =?us-ascii?Q?jZYvJwSubh216ymP54BSTXIKrHhwg9l9zheDUXlMj2//w+2TZtUhHIqu6YHh?=
 =?us-ascii?Q?bBHvEfql4HImEbyCXTw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:50:48.6567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bd5d8c-b0bc-4034-c5d3-08de287eddf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

On Thu, Nov 20, 2025 at 01:22:10PM +0000, Shameer Kolothum wrote:
> Retrieve PASID width from iommufd_backend_get_device_info() and store it
> in HostIOMMUDeviceCaps for later use.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

