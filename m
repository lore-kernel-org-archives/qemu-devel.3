Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8860CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvhaQ-00059V-J6; Mon, 08 Sep 2025 15:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uvha4-0004k3-UO; Mon, 08 Sep 2025 15:31:14 -0400
Received: from mail-dm6nam12on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2417::604]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uvhZn-0005C5-Pt; Mon, 08 Sep 2025 15:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqCOiLe1tlnQKPx9W9XaGKuqS5mYRbkQ+MV9KqARaF5KKjBVfN4kJvg+NNylXOY8t6uOIq1Vqe8oHn/o6AHK36EfyqMFXUIWOyIvd+3hOAYuZhVHXq0XQdDjMYsLfg3XDxydVYmSC+q8ltAxO82UScmkU+wE6ELRFEniWrYxiqrMBa5PBk/tjbtbKVqisQCk5IfB/qkSI1g6o4LKPLTOeNGNi+rHT0j1nXWiRBFTuKcN4ofd4D9Jt9Rx5FVX8VBWHFukFcSiCskZdrjPsNO8AiJ0x6NHwDksauMdQxuNZa8RKVWsqa0XN1qapaLQ8fPKcdFZlMHh/XU118OtkqKbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uca8U065mr6ZPcovwvg2eYSqlRz7JEyUvxbHbpf7VI=;
 b=F55ij+8KIX8ezb5nciaO2QRNf3DoW98xNFyAAFp/WeUkpymxF4afRVdGxYgt5a82Lfy8HpJRx3Sbu5jCfXj5WGvcFOu5amqiVwlP/+YytJRPOGME1WBRfnmguWdiPOZgUEUDUYxW+W53DtcMEs9DSAFJXB3tuXGNyvpO24ExgrCYg8wuPY6M0QFvaOTzjOjaQ0IkQsjft76H72rDBirwQtITsWiyTGoYzbsEufpsL7eK9um1inxU3SVjI1eq5UUWer6mWafQUhk/WYh9Pg7fwpsadG9D2Mvd7hIGvv+0S8OxCb3E2vjkSuNaX7SLamed9cJJ3SMM5kYl1yC8d/q+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uca8U065mr6ZPcovwvg2eYSqlRz7JEyUvxbHbpf7VI=;
 b=kNPOt6W9pbuxio1mvIHEJRQGq7wqqIYC6/zANnYreQcl5gZeD0e8u3+9K9mk8/WN6debG1SV9+ZeJxT1RUWb+8eP2uh1R7TIA5Vb5C7br6cXL3F0JZYe8jX3ZAiq1ZqCFoeYgKvOsB1XxJeI23vh0Ubzm6OsPyfMTmof8h3+5gwcSJs1fZCGTqGXew2vRSaHLCOJy1iJ39RcbvriJu4K8uYBXDc53te7UY22Ck/HI6vMaWgQDUhyjGhH1roZv1s12AfgTHZxurpPqOVBeKx80LvqmYRQjUfBclSUMUfl6S65FrsFi66mEWXI4SdiG7AcvNsvgQaNpDO6Rm30WO2Kow==
Received: from BL1PR13CA0421.namprd13.prod.outlook.com (2603:10b6:208:2c3::6)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 8 Sep
 2025 19:30:41 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::36) by BL1PR13CA0421.outlook.office365.com
 (2603:10b6:208:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Mon,
 8 Sep 2025 19:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 19:30:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 12:30:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 12:30:04 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 12:30:01 -0700
Date: Mon, 8 Sep 2025 12:29:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 12/15] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Message-ID: <aL8uth59ShMJyaDH@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-13-shameerali.kolothum.thodi@huawei.com>
 <c2935990-ac0b-4272-b3aa-92a555d88e99@redhat.com>
 <CH3PR12MB75486D76AC47F611FC646510AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75486D76AC47F611FC646510AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc5ad21-b70f-4d08-aef6-08ddef0e329c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VpFKYkW1MNXR1t45uFRe5sLuIW7wL1KT5oAfPqDodlUnqbiTSLByJTBWPwS8?=
 =?us-ascii?Q?sVP4W2/SpkMAJvHh6wjNzckanlK9oI9JC/0r43V1PAEhupRkpFp37uPu2VGt?=
 =?us-ascii?Q?P9fIuLQ/lvkAPPGy/1ihGpheVMm1ffiVP5ECNxcxKwNXD/RhqJ16kPmnJ59i?=
 =?us-ascii?Q?s/mulSxrQ4fIBTPTRPaJ6g7WqS5gSymyGogYidZx793/IVC/Fb5ymeykDHXQ?=
 =?us-ascii?Q?nZoKUqZkLrnaGOK39DHbRM0gHVhyqLduC22vWfVSRmX6TQS5rIdBGAAlAml1?=
 =?us-ascii?Q?pC9odw32RYVy3USyzFk4Qah3krBOyLSi8oHNNm/gTJdWYYKPKYNAm8hkb4qp?=
 =?us-ascii?Q?QzYsRVSUJavhhis5xmoQKHLNLb8wOy3EkIfwmmjEZUR+t4GbW9UBTMF7mcuV?=
 =?us-ascii?Q?2OToqsL9QGjMDyiy80TeswbO9B3QmZxz8rPNbMGotev0x72L9FGrQRIw+CJt?=
 =?us-ascii?Q?17tFyhSyo69KLQ1xHYKc1TPzxHUR4eEd3uGUcOXcPkklx2d/6KHFgt/ddntJ?=
 =?us-ascii?Q?+tZvuOVmMDS82NLL/dazzdPU3cfn3ilgGrGgB6j74e5tz8uaL9hi4QSV880r?=
 =?us-ascii?Q?qgjGdAmwcg2/m36NReUOf1k1aBVPNHOaAHk9yHX8lQ93K+jDzHKHcOl5ec8o?=
 =?us-ascii?Q?96IV5RJcrhk1tj+2AH90N3wNKwj2xqQbjqZy5M9X/fqc9/CW/Fj6VHQPGyMQ?=
 =?us-ascii?Q?1OxOMerR6TBObkOkDOzoC8J+SXKXxJ2ZwUXHtBu22hyFjwGX4993lEV4Yao8?=
 =?us-ascii?Q?Sxb2pTOO3CYTciWGNhmTpqIvHcPZcAeUMnPOZlTVLYQ7qDnDnFna+NMUyhRj?=
 =?us-ascii?Q?9ztPxhKpPo575AnsCiw6BLor8q40O8mHYRHZOk4VXtYX57NdeA633Xm127dL?=
 =?us-ascii?Q?tOorcfVS9k42ImO/XVMS4GHDQ76CXvT6FS6DdUFnhNow3GSkH/qo3fQyR0nu?=
 =?us-ascii?Q?c5upfyYTnC08AoYCAloRyjdMGFh2jSTeNpbMbe/GiQDcTPRLOCaqLmPnf7S8?=
 =?us-ascii?Q?fRFQzGdKBVtHCTOlLxGbY1cjPLFZIlssRPTijKpPl5F/T+1HyiojkyMYjWAP?=
 =?us-ascii?Q?Ada5RhNFTiN9Gf8lSGXPM5oH4jl3+orkceDyTzsowlok/ysZnplTvqCrcfSN?=
 =?us-ascii?Q?XDXa+Ysy58UF6tFo8vHd9H3bTeDkfYB2rdeloCyvHM6NFrUo56dRIxlHLC7+?=
 =?us-ascii?Q?gSvHmpTAHitVdzQWU24WI4p93Zvb667QlF4HQz2SMV3goJePw/HoNbKqDljG?=
 =?us-ascii?Q?uQgdvxUnW0cWvnusOcVHl7CxkfVkTHiy9SCMmhc9ShCIqip3HCJcP8MIhkh0?=
 =?us-ascii?Q?sa3ALKdJX7TsqzLKRWftSQ1lsNCArrhRP/5a1AEw2fJ1giND8g5ekiLifsc9?=
 =?us-ascii?Q?5lc2JeNIMgw6YdGBcC8QbmBidGrFTgFIQeTZVL+XbjmvU7uaz4Yh3+7xUFUG?=
 =?us-ascii?Q?GH4fYVYOnsyLBCZsV0Jz5XjQ5JOeDOvMdoJji3taaEy3jNn/KF+ohGFty6M8?=
 =?us-ascii?Q?6ir2GQZrhMcKQ25P/TeOu9YP/Nt3p78IQHcC?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:30:41.2182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc5ad21-b70f-4d08-aef6-08ddef0e329c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
Received-SPF: permerror client-ip=2a01:111:f403:2417::604;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 08, 2025 at 02:59:55AM -0700, Shameer Kolothum wrote:
> > -----Original Message-----
> > From: Eric Auger <eric.auger@redhat.com>
> > > +/*
> > > + * SMMUCommandBatch - batch of invalidation commands for accel
> > smmuv3
> > > + * @cmds: Pointer to list of commands
> > > + * @cons: Pointer to list of CONS corresponding to the commands
> > It is not totally clear to me how the list of "CONS" indexes is used. Is
> > it meant to store errors, how do you update cons index in case it starts
> > failing, ...
> 
> This is how I understand it,
> 
> The cons here is to store SMMUv3 queue cons corresponding to the cmd. And
> in case batched invalidation fails(iommufd_backend_invalidate_cache()), it will
> update the batch->ncmds with the index of the last failed command. The cons
> value at that index is then used to update the SMMUv3 cons index.

Yes. It is used to update the CONS index to the vSMMU CMDQ.

Nicolin

