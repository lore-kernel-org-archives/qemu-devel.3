Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07DDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 00:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEzQD-00062E-2b; Fri, 31 Oct 2025 20:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzQ7-00061K-Td; Fri, 31 Oct 2025 20:24:40 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzQ1-000543-MU; Fri, 31 Oct 2025 20:24:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsztwFGY2olkQuuczesPMbRnst+KYvErnK3dsK6i6JSqMdT02F0tX61Pz9eRnktG+qYUEMsoJnYkXMGRG1NScLEnwGwI2rT0PSy9VN847W1Ji69yvKho7hkxekjG7Fj+znyDMR+wMIi0pQBeKiZ/wKZEVsR6dj8q6K5nTt09WlqmBSNMlJqASlu1T/q7C2deVKvtgkT9JNhodjSd5/bYXYakivM+/WfqkxiFjdoewCFxpoYwd3qKiG2bWNK9EPOWvbaVycWIZ/JoJh9nAE9+VLoQ1UpCzsTKl5yR3epYDCjSgkAdEVGExCzRSA36uWCn5DRJwakylk41b6Otsv5HPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3Lb+WuY78IOS/e9/b6BfObv+g0cW7N/3eBYPMqvqhQ=;
 b=JzIVoF5Gbjh2UwctDdyTjTspej+LnYYigBzdLwRRCR17FdNmK1pHAx9I3XHe3g/pLFn0yOjwI/6ve+3uvScH4jtIfKaIC2VAdBi9ZKfYEIJI3yBFN43nE8AX0k8+yCfFQl5dttiCItr30Y9sTYeCB/xX3xt+QGifmrgPlC+6rqkWF241tpIA8Q4M9KkvNaMJ+A18mkS8ZZwMe6IqIcwPcfsIMvmO5GAKN8zjCE3Tdx8673sS8H7CmCGsZ2JcO7kkmKH7leAYtCIbIzyFLVnuOuVGMG03RWyDSD79O1aC1EFejs6tR4SavSJZ1uYI7YBUvpYTD/HcERDbgGlkmOgKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3Lb+WuY78IOS/e9/b6BfObv+g0cW7N/3eBYPMqvqhQ=;
 b=GkhvJk9gxJTKqvTFcv95Y7Ka/nU12j1agT6epywGTtICwUQonYd4mzDSE/2S8Ssme4JFHlZqc58UGsJ/aTRqhG0Pw1bRrgbkwReVsGKb3/m/SPBwA6py2M0rRiUL4PoErG4Lqc62o99Bs3gQSLI3IVRjhawGPJcFqsUIO6MpRUv9euPVp+qCBlAKe2uOPAeNo9w1Y4LLMtf1FdeufmeTWtfWgJqBfUOCK2sQGh/KaMZKqBwd7r1QWlvlhyHInYHHrNM1NhEuO38X68KrcS3p5hagK7NUqEq5BY18uJ7bqXmVpqy0hwigf2GAABy90qA9O/He63M8FZpISbVf8kwS3A==
Received: from CH3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::27)
 by DS2PR12MB9709.namprd12.prod.outlook.com (2603:10b6:8:276::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:24:26 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::aa) by CH3P220CA0009.outlook.office365.com
 (2603:10b6:610:1e8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Sat,
 1 Nov 2025 00:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sat, 1 Nov 2025 00:24:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 17:24:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 17:24:15 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 17:24:14 -0700
Date: Fri, 31 Oct 2025 17:24:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 18/32] hw/arm/smmuv3: Initialize ID registers early
 during realize()
Message-ID: <aQVTLAPgYaCzaU4I@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-19-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031105005.24618-19-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS2PR12MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: 06471768-6ed4-4147-0aa6-08de18dd0367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TWWd6KnKEwyRgorVvqR4opIw9bCgUCUwFH0LhMeW52x/GDsv7zStnKn+ExHi?=
 =?us-ascii?Q?TXw9rZiaTyHV1KqBOvyuNrUjnz/BZWr0rmI61QskHb+L+cP8juSanWMMFDw0?=
 =?us-ascii?Q?AxW+/9z2IOcXzwqwtbDehcIaAZ6vX+PVjun+/J/pYWBjnHnw0ISFk/CP0vZX?=
 =?us-ascii?Q?R7CN9C6uwH6di0uBk8U/7yxUPxDeZaeEvU9j+0a6EfXThPsVIehw8jPxo5m1?=
 =?us-ascii?Q?jD8qVRMZQLIU0+qhrdjriKgmxT2ukWHKb3p/sO8E4PO7NS1u2lxkVWxHTJKi?=
 =?us-ascii?Q?BBaS7gVn5rmLvRA8HhJnwDL4LK2ke+VluxY+nFkg+DdFiy+ktQVxyl9CwF0v?=
 =?us-ascii?Q?7gpyUvnfQPZOqsV9KI6PTTH0lssK9+RgZoN+eQDB2BZC0VNO6u1fNwLF6/ZK?=
 =?us-ascii?Q?/LGoljP4r6uLgVF7yXZtOixkX2PgbVIH9jZT88z6BWy9MbWVENfEbCGtCAS6?=
 =?us-ascii?Q?T5UtMxcJMUFhmPPycoaOcwc1zZrO0ZdWCCJypOtlljHNJtcQpOatVnMo5o+m?=
 =?us-ascii?Q?Lh9/R5uPMJyUOsuv7q/J0MLc24jo1CUI5JN9l4tYkD3LZSlElwHSWA8k/XZG?=
 =?us-ascii?Q?3WmE0dMHpICJS4XQjik5o+faM5WXHwRydVk8eVcbfKSF9rA+x0soVf+ZbwK0?=
 =?us-ascii?Q?I1895bkKqegQST0q6GEOvjqsYnx+lDDv/pJgXv5R0Wmzh01HBg3gDoiRLY/a?=
 =?us-ascii?Q?2heTth6s4R7WtnzbAD5kvM2oneg8azEef/hF3llo/gWqNFY2ZWU1mmMMR0sK?=
 =?us-ascii?Q?/THpRLm1mmlDiLSh5ZnyD9kfcc7gvKSA/+6Q2V+o9puS2jx6BluubLa+LpWl?=
 =?us-ascii?Q?vAJ5C39w6nLu8+8bwdqrcF+Z/nBItCWNKLS9GfC44MqTPghwLQ5a7yVmH0YC?=
 =?us-ascii?Q?CUUOSsdtH9JTzcD6Prf7Hc1wWrgaPvlChrSk41GYhCTYnUD8yC4vd9IdgYjo?=
 =?us-ascii?Q?YfdNWDWvKSbk5bV00rjvAILYlHoXl2vVkcV3qbKnZgZMG8yioGYGn2qqqQpr?=
 =?us-ascii?Q?7CAMbayUAS530EC9OIcHRRVJQ79mh2KF5dQbVYemA9vC5jqvk4ddjeFfsGW5?=
 =?us-ascii?Q?RYqks5VEmU2i5Srxf8etlwQJQ0vleOQtjs8RTVLxTmSjPVsRQgshKsqIfZOI?=
 =?us-ascii?Q?+heD6zQXqwwadTfp0H1lpCkc4E7oUsNpD2HoqD91CXfw0jG+xyThVSLd2FQj?=
 =?us-ascii?Q?KUyA6Lkg+46TuK/WeRSxKNfqnY/aczhcuUUEM5/1t0FagH99qfZD9ny+MgY+?=
 =?us-ascii?Q?ClK++wua748rO8L/ZopwWQWNqmwFl9NTyPdHKiz15NPGuwOJwQOVAyZpGfB8?=
 =?us-ascii?Q?Ty7KLckNvuBcbr0Yql/u3b3asV0ohUM6ODfv+Yu5R4+2AqI4qRxYTgWe7rW2?=
 =?us-ascii?Q?UAJA7MmEshPkMXwS334AxcgowluHj7llLu/BrO7B2Yp23dzeubNt7POriZkI?=
 =?us-ascii?Q?VLUDspuFYPes8hcyK5me1AcoKjxuCKmbsBMJxav9oMC/+CV0G2uSZfHumB3E?=
 =?us-ascii?Q?gTet2fKXz0q4Kgkzsn2M1epu0yjIfanmwC2kOSQHx/T2AmG6GKhUM2rnHF/C?=
 =?us-ascii?Q?5t1H6v3Trorl2ct7IKA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:24:25.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06471768-6ed4-4147-0aa6-08de18dd0367
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9709
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

On Fri, Oct 31, 2025 at 10:49:51AM +0000, Shameer Kolothum wrote:
> Factor out ID register init into smmuv3_init_id_regs() and call it from
> realize(). This ensures ID registers are initialized early for use in the
> accelerated SMMUv3 path and will be utilized in subsequent patch.
> 
> Other registers remain initialized in smmuv3_reset().
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

