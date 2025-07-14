Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7030DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQyY-0006St-CH; Mon, 14 Jul 2025 17:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPM5-0002I0-0z; Mon, 14 Jul 2025 16:00:55 -0400
Received: from mail-mw2nam10on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2412::612]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPM3-0004tu-4h; Mon, 14 Jul 2025 16:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVQkp2FEffbYbSOQIkwv/J6XFiL2ZIGIVGXMZ0KFzYPOeWz6hlJ1qjreWNYk74nmzDKawOdafp42r1u6gybl+E3CbL2GWMAtDamDF08v5cEw4UcE+G4C6uudBF0YOmsjmwh3EElIoP0ASlSpnu9XiNmgl1uz5+Oy/nzw2Ce3G49HZS9H0tscPMxGauYAv/3FmGSY1GdxibceY0qNXJEEKiaQneCQqKmJFHbSjJRl+B2SwawqN10N8lRVjmBUY0JlnztJIdO+p9i1oD6bze3PiaBrmDbDk+lwI1q+GPtiT+tcPfNLmP0Wwc9FyM0HPPxB5ycKHlbu999mv+sI8gjA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es2lJvFWr4xYVG7BsXzJdSeBQ70507Bz97NSZf9YKrY=;
 b=fUa37bLrEUpxafuxOQc9jWoV77OTlln4n9i1z1+oxpqR7nSGQkW28C6KZZEGwij1YoccvsCQpVQDawKkmaMBHHo3EqkHwfLyxqx1LFMM1bNoDWVGkaRMwgf3yq0wCSqwNJ59EEyZ6GDg/x/tYKgOUIcYOMSDDK+tNHQ0yWjC+HgDA2DvC4XIVeRAUJ61To/Y2bQgC3xkItzztKTmc6zazN1mk/QQx0UbntHbj5f2hPEioVwvp+uxZdWZ7I58H0wyS4ovs3Y68Y83L28quMMpXaOoBdaUGARBEXV7isv1MDDuZKgK1uI/L2TCZl3l/USlUAUtJNFgsbYMykxIIZtcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es2lJvFWr4xYVG7BsXzJdSeBQ70507Bz97NSZf9YKrY=;
 b=SXisgC/ZoFDcLFLjM8vqHv83j3BkiBfbdsw6G3p7N1EEdjtCPm5I8x7hSIPcApVo/N1/HOQBCwvdVFmpJ5kPTHDTKLjrOsyl5BiXsT+PMO+0XQV5PEKSoLrylv9ETw1Syebd7jprhEXlA+wiZmYrzR33hmpT1k7jjZAN2NbIae5FljmRQfD2AMHx/fEygXMEy/paxRI2qx9sXunTveQkS2g5kWsbEy6nBvpaHrAtE/51TPTt/RR4sUrC4bX6WqircrhYVPtxMo4405Gc4nrttIWtY3BoGBvnyOgiD4vSn588jmHDvu8olUcLmfIdyrv5+MIWziRHHQmIRDojVdQ2ww==
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 20:00:45 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::78) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 20:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Mon, 14 Jul 2025 20:00:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 13:00:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Jul 2025 13:00:18 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 13:00:17 -0700
Date: Mon, 14 Jul 2025 13:00:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 15/15] hw/arm/smmu-common: Add accel property for
 SMMU dev
Message-ID: <aHVh0BI0GuY/dL6G@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-16-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-16-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: ed07b4f5-959d-44c6-8a6a-08ddc3111ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gRRUWOh50TVGEGsJMDv+DtxStuyEYR+9dAude428+3Lf9PCe16IYG1WULiC/?=
 =?us-ascii?Q?gWnORwF3CjuVaTVDW2oK4gVK9Z7iOIYn/URAsGiCVwhmth/hY2QtFGXMthFz?=
 =?us-ascii?Q?g9kUBqEjOfUlVJWM/d0yqada+2p3PqADPgOjL2gqwnv5PtTJEBU6noCten0V?=
 =?us-ascii?Q?D8cpAGuUZ1IriyXwLhBGdOY2QNqCuOnFfRAEYvH9RErS1cOeTD9cwekwfdH1?=
 =?us-ascii?Q?Wk6N5vEcmv4yMMioMM8Vbm9EXOBrYXeRlMiAkg+ZUEuOOc/d04LGr4tyDzX5?=
 =?us-ascii?Q?6fVadLcIbJQ7nmhdglE0sX3tEB+AgEr50EO/lsrRws49mO3oVYZrgTi21sjM?=
 =?us-ascii?Q?QumQzMTIYgZq1/R3UclnYXogtTfy2PVt/d4f3konkTh+71cd+Gh698Fv4YTL?=
 =?us-ascii?Q?dmH8u/d6SGoZ8gjVxN2xUjmqmpzK/Wrw7h3Wa/y7JRfIgH4B/h/kn8nbmu1x?=
 =?us-ascii?Q?AzcDcVqDuE6xnuk24UEJidNu284ZFce4vGOaU2Su3nXL+xbuNqK1P4xXbehI?=
 =?us-ascii?Q?RUEiGvbTZnYNgxBaZ1RtV6SqB+PnY9MFsBtwW/UbRU/+hbPhRyPLYLLTQXk+?=
 =?us-ascii?Q?x7NF9HLIouzqagL27etOTOMQtuD9wSQvncQDH6HEtpfGY4py5hzPUmDOAu5o?=
 =?us-ascii?Q?nBwBoX2hwTorxikKFtH89uQVlBovS709ogz/4PfqNiW0YdvOsCdGTqatMibW?=
 =?us-ascii?Q?lgl2mxhGEGbeBKJom58a9kQuj3lBuBM2Q2nMews/wc6tK8Nnxt2jV3omRV8P?=
 =?us-ascii?Q?kKrs9r6QcsJW+LsEnlf/hfAK1Z1RKj3ndUqBgm9TxXHFrMnss0Ipbm6018Vj?=
 =?us-ascii?Q?bJEiJ2raH6W3JH6t/vuOhN7ewpDmbGa5Q6P1I5XbnHtuu7RyRPrmI9T9cjYh?=
 =?us-ascii?Q?0w1rR+QCIm57UEEt/Tg02v1aDnEfikrOTzot1kKWaCwArtGAY1mN2x06HxOu?=
 =?us-ascii?Q?FOcRQS+j/35Oa41gsWGPGIkMakKNTPcY3sApvhGnHYvGT3gJlYp0ub/k90Xo?=
 =?us-ascii?Q?mAdZS4WAUcIxRDP9Yh3r8iaYaquQ3OLSAb3lycydg4H+nJZdmmkzJjWXnhVJ?=
 =?us-ascii?Q?6KQHRe7A8B0MqZwuMHfYqE28NmJTpUwofgNYtiNZNDTMu9d4jHBzplJ/02/1?=
 =?us-ascii?Q?86wxr2hvSvsg1FZye4eAQuWH3xPi3t4rxVF+/Eq71H/+9zFQURjUrKFQObMp?=
 =?us-ascii?Q?b5jdO8e7sZM0IcT5sdy90DblJoj8xHPh+mKrWtZi/HpPrnYoO/u5gfqjcay3?=
 =?us-ascii?Q?urVAS5sqQA6cHmwx037YOW7BjoyagR4+tvfOAolUsbjaawuyGrDIMmshSv1D?=
 =?us-ascii?Q?ji/M3fzUTtZC56VZgAfXFnEvIA0X+S9ORGhMJzYufz+JqqNnZXk0TAj9NGVS?=
 =?us-ascii?Q?cxuoa48jEQGJ4MU4ZVt2KXa+1eEledDTUrWyZvAHAzuEV3/oXb0UPmjwjvew?=
 =?us-ascii?Q?/Ar49K6qFETSKhXYH0Tqfw2t+PiX+lxzrYbdzrj6r3SgTm0wvyQyVOmb9VTI?=
 =?us-ascii?Q?Emkd/UAq3H8I6fxhrC6pp/Xr4zWyA01fOSDE?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:00:45.0538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed07b4f5-959d-44c6-8a6a-08ddc3111ea4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
Received-SPF: permerror client-ip=2a01:111:f403:2412::612;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:41PM +0100, Shameer Kolothum wrote:
> Now user can set "accel=on". Have fun!
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

