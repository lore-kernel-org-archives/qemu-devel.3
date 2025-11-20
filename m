Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450D6CFA446
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMBpg-0004ZN-7r; Thu, 20 Nov 2025 16:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBpc-0004Yq-Jj; Thu, 20 Nov 2025 16:04:44 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBpZ-0003Z3-Ec; Thu, 20 Nov 2025 16:04:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCKCI0aYxw3pQTQofpCU0bgQIggH8reV0EY03WXG1pXyxqlQmkt5ID3UQJndDGkZceEBA3gB8cQ3wn4FYK+8dr+cCV4dq/GYeMFzG0j3MKIVD4503RuUYXvQyXoxSeOhsfa8LbwLZjFQKPUwYSUO+IG0elIkgErt5TUlCXJI+nTuIjPsfVM0a1cLDjFACrX+pbGERqIz3lAzEOTp2HVGx8WlZ+WMgP6w/RJOb7Tuml3eWrqFEY1S9YRsrmV9q5fAggICItlSFXflSsKWSG+jSGr9HdtT7VEZulvcXvNoKrP/psC+E9YG5AgOJyV6iYCmq16q2fHquUDLuywEh9Q9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHHk/JU/OlLAOFwevrhsPgjduEhoOTnset3xgUn4dIk=;
 b=IUdLwzTMLJ9+M/2LzffiA7utWdGUdoGF9T3u++QFPNKH2aLhtMXZKZNFGPalCuVrSS4h/hFQhD5/cEBuWUzPkkFbSYMWdMpfvRM9YmXgqdbXTHGQuiyWquXe1lM6g+BkNB4DLVKjkqqmKJidQvFxFoZyjOR+UGKIS3cKoSAkPVhQJ2MdJQhZGuDVpHDDe3nzWBuB5zhcRuPwHEsd7Cpt4j32Yd1UXGcCVyi9PVa/5kVZeSB6GW5+s8TX+zQ1uRP61R37NVs2BTmzskGcSgzy1U2K5+/N/eX5hG4MAJTMeQoCupZuCi36qVfJfD3BBG1mBgFV9N5hX1bRNn/ZYo73Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHHk/JU/OlLAOFwevrhsPgjduEhoOTnset3xgUn4dIk=;
 b=LFHPWzCPsboIAuJuhu55k8h4FAFgiK+ZsE5RAk/JP9WzDVCW2EqlvVqHyxRA98/iJPwU4B8tCZKTqDZohG8390PklhqZopBAGFV1jtE8KCMsNcJTvjQENdsvo5X+cerfRGnEawkX3rd1VTR2BLIv/nBrGfo2wKwd1RAnMCDU1qSAJpTID/zR1zMNN8pSir9gbU2ROuim6ijANbZPUq/jSLBXKH4ijQFSJr5QfcDAFQbnRM7LQo1ux5xN8NxJeL6docsJaHfk67MDuyPe1hAJkVPbEMAWBMjwrgWtAfMYEXo0QX/y3YMk0vyssQnb0A9YXTKm/wHYjIo5rZoTxcBB2w==
Received: from BN9PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:fb::12)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:04:29 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::24) by BN9PR03CA0037.outlook.office365.com
 (2603:10b6:408:fb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 21:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:04:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:03:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:03:58 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:03:57 -0800
Date: Thu, 20 Nov 2025 13:03:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 15/33] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based
 hwpt
Message-ID: <aR+CPNEIeHVPrJTx@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-16-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-16-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ad417e-0e2a-424e-647a-08de28786500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i6dLF/Z23WPiCloPwl3PXCqgSRtkClCTsCDaz2oUVLkmR+WocIcclmaMwXMx?=
 =?us-ascii?Q?U6NnA+lRhKOY7rbKdCS/RXo5VG36R9wVYtfJ8cQOgJBiXNOQxndj8b0gpgFC?=
 =?us-ascii?Q?YNoDtTZ4enLrOYK+P5O5mtHrkesCGu4fMiSMzZ41l9YBIa7uG23Ak5BxejU9?=
 =?us-ascii?Q?SF2Uc9l2UhJMTvUBP8rpx/DyzdoJW7d1p0wvfit/TohwYIa5UBxhs4dpP4i1?=
 =?us-ascii?Q?8MoqA2xDqzhh/gxXqENR4kd9IcjXEaD4IwjxbORyfsEyzhD5t9ozkuhBK264?=
 =?us-ascii?Q?ChfwERHbDbKHjDVdbtou1I5rvRmhUIAsigrEClyjJrUL77vqAzGInWqd26Ee?=
 =?us-ascii?Q?gdX3DreZisnoV4/1gaFX4fgGfUDl+L0k97ZfJFwCN8qM+ydIEVgoU0vjCVDi?=
 =?us-ascii?Q?aK8VqQrEoEmOwInBsL9vF6ILr7iTNLQUbEFL9pXOmfU27gBe+zuwCUHFb2WE?=
 =?us-ascii?Q?EiM1RS80ZGoVjuD3C1cr0jNV59A0ETToX89wInYiz8pqPvkqkFkQjUd/01gK?=
 =?us-ascii?Q?0sgfZYheZ5d1y/l01ikRYfKgTkSVrJUQAosQo3505hiwt+cDrF4gAH/+CAVI?=
 =?us-ascii?Q?J3HhpcO6skoYXbz6y8pYfbvXxBnXaaj8tfktjvpdLbWribps6WXPIoJtukxg?=
 =?us-ascii?Q?RDGNXAlAIzkXa6e0WY8Zh260ukKxOCtQ8nFlnCtAVKLXsSSgpCxQNcXSaDuR?=
 =?us-ascii?Q?nKvclW1CumLmrMjnSS4rSD9BB24ErXPJGeB2nhwhYkGoWSnHjJCblPlnwM/G?=
 =?us-ascii?Q?Nk2a/TB+MKGdQTNrZghIXLJ6pjeJpr00NpidLAdiW2M3uqw2M/MlHg8VwlOD?=
 =?us-ascii?Q?GRk5clqwFe5l/3HsbFQitYCdFCAPLbrDIXgS/mPMvZZnN+om4r36JMwyhcfU?=
 =?us-ascii?Q?xkS+Eb6unmpLtI6KhASo/DQmQzx6bTtS0tjm8bQX3yJjFLdfX73hqyi9SEA2?=
 =?us-ascii?Q?yz0mcqVRy09rjIYeu+i1Itz8j2ONF2qwihBDmnqpA8d0JDZ+zNI6M9cFBsw+?=
 =?us-ascii?Q?hYusrx7xojijdmK8fFQGfqakEPg/MXKbkdpHs9QO49zhQaAjzrlUSef1jhjN?=
 =?us-ascii?Q?cnAvou6YQj8h5owcDZP7l9hSINwzFjK/Tk3msaZpp3vWMHCActsUDLEFL/EX?=
 =?us-ascii?Q?OdZCtqsCFX9Gh2511FUI6IjFVStYUt0Cek2PWxcCW5409BX7kkC2QdzLib35?=
 =?us-ascii?Q?wT7PjnX2i6rh5mqlWJL+1s1tzRGe30hFLNAK0DY5rsRE9E+empHNvqSdIcfG?=
 =?us-ascii?Q?P3UIrsXgLzTugRiRKIqSsHqiqpT48UcsV3wfPXwcbLYvgv0zXv6eA72HcdCh?=
 =?us-ascii?Q?iugk9ijyWLul7ySaVzE0X50EJpmexxasnbPlcGWq++PajOFUvrTO3Muufr3W?=
 =?us-ascii?Q?hyHVDBy7oyXnc2K5l9CTiUMRX59xGpxfQ0Bss9s1u7f/+2tqdpzPRuHqSGew?=
 =?us-ascii?Q?F3F73Jy9kcuQmHQz+8f+gcA6sAsfXyELgMD9jiena0BsyX0BKYXL0BELsxHr?=
 =?us-ascii?Q?bdU7oDPbnUiPgbTr51B5PA2F8sn95Er+z9twBHLvs9WGiH7uRRFN8i/c8Rl5?=
 =?us-ascii?Q?0ahUFX9ELCuJ/BtOrNs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:04:28.7086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad417e-0e2a-424e-647a-08de28786500
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

On Thu, Nov 20, 2025 at 01:21:55PM +0000, Shameer Kolothum wrote:
> On guest reboot or on GBPA update, attach a nested HWPT based on the
> GPBA.ABORT bit which either aborts all incoming transactions or bypasses
> them.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

