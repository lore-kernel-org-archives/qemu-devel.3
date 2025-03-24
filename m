Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004FBC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 15:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twk4y-0007E5-Ef; Mon, 24 Mar 2025 11:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1twk4i-0007CC-1v; Mon, 24 Mar 2025 11:50:53 -0400
Received: from mail-bn8nam04on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2408::631]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1twk4f-0002Td-UA; Mon, 24 Mar 2025 11:50:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwgnWIV5VsxPGtNcmqVM63wa850azYuAbT0jGSw7B4jjwjVb41o1L5YV2WMLQNwGb7iUJQ3q3iRdEXpD+xMP0mb1GYrkOshz1D7OwySGMvMRD44ME7jn5HIvwX2hev4nDkj7TU/imZjTTZ8G26bjqr1xzhFHXwoINqaumQ6mpX43EEJK9gWiHFv2qAnTcjc5XhSiZAD7Gky26LrI7IWvIBrZjmiWsPMDp864+Cpf4ylwo8B0Q2SLJpU5f0Kcak0vCsdA5rtvc/Pa+NTQJMG5gAh1OIYCKiSkAGYvMejj+yx2g+SFV/BUafmhabyNS4uZ22NSrjErTnQAAm8lWoap6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRvEeXqTotxPTtciCPARw6pL6yBfJGWo0SpZ6KIdzTg=;
 b=p4iQFs+0MPl2zyKYNlO9N0hph5mHMKo2fjtE+k+jv7Og1sHtSuoP8/agH7o5Mqme5Qq+Tbgu27UtM2HvWo4HTXW56pW6m111t0rAgPNTKx/2IDiYtIK6t30pmNtisVKtiERKrSOpFU5I55YaOk7yohJ7V29DQPWa1olG/y/GHT0pnYFQmD+Fyf64jPNthsb/ic5nmupMYZbMWKh9mDKP2nP5sdrgvCVuVmjwyfHT85qx7X2nGFB1doF4Ab9p5IATMf3bsaoSInZvNnYwHyzt7K67KxhpF+r+UQeGq2/C1WbVdmSUUQZ4jKcl1yH7FQFpSg+WGTy5NNYv/lGPSXjb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRvEeXqTotxPTtciCPARw6pL6yBfJGWo0SpZ6KIdzTg=;
 b=RiTIddtmWvXVzyL9HQWmt4yVSpO2qFTnv8KOEL5zrF45yur7Mjv502+dADt0kt6j/u7eECbYLWX9osyIP2KSCAcrSFmhkT1x5hxBRx4fLLtVHOa07i1VviIrOTvs0MYij/nGP6qZCBLuLnkPOIWvjZl+UEDp+5W8bRUWrOW1O4OKD8zhoCh3/JzYh916eoK2D+NGuaMv2dsdY8voucjWYmpImW9d/EjpPj1MQZjXjEolC1498q3bn6Tlr5wg2rnxQmrZ+aj8JHpcZ4wWsoGClid3LrUc1iNW2TjiL/AEWPa7FcgW2cq+9lf4wLCoW1qqmivGxs8KP6fBoOCHvfaP+g==
Received: from MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 15:50:38 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::d5) by MW4PR03CA0150.outlook.office365.com
 (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 15:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 15:50:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 08:50:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 08:50:21 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 08:50:20 -0700
Date: Mon, 24 Mar 2025 08:50:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Message-ID: <Z+F/O4fN49uM9wiN@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
 <Z9xKL49nOenvQIsW@Asurada-Nvidia>
 <2f84490d309440a4a2ac56fd893ddab8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f84490d309440a4a2ac56fd893ddab8@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2627709b-0f03-4f82-376a-08dd6aeb9f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?76zvwsmtTgoyaRzDCX+knLHmHWcQC7pan2thFjVFC+46/9apEFabO4dQD3qh?=
 =?us-ascii?Q?gTS66jb/2JuoHwfVBDzFwaHOLeVAuzn9iNDhxYrrM1ZeKG4uByvFNEz2EQGc?=
 =?us-ascii?Q?N6AmPNN6xfgUnHGzlOr3x3Hjj8VEkAzmdEjsYc272/46l+leYEEO59WvADGg?=
 =?us-ascii?Q?IMGUp9wRI7JXBKrsp2d+OKMm6w1S8Yp0vXMBsbn4rVU3t/tXs7EuqeTjW6Wh?=
 =?us-ascii?Q?NX1Bsvmz4XyeKm/C7OEkR8tS06OZV4HDp92qKiu2sbAb039zam8eurjNVBqc?=
 =?us-ascii?Q?Maeu+Jiuj4jKWFJ6ET/2zQYfvRcMrUUZGpDV3vatFmRzqPf4fQzu1s91B/Gt?=
 =?us-ascii?Q?YGgNqMe13Ntex/5FGUDFSY6XqiUgJ0nYZSpruvv6NVkxYIDxFpnTrUkF5Xqz?=
 =?us-ascii?Q?7un8Qqlmqi5fV7sLyEX+pSUbvI47il8E5pXrMXU6qoS3TOKUOGALJSjPIbMQ?=
 =?us-ascii?Q?KP+lr4mpraJB0QFO0HGaoUwcGMkGxnXjs76hBR1Dmau+5FPNbcABv2UtlpQV?=
 =?us-ascii?Q?/m6NFErhC60aU2BTFeRswLKnwVhnu63b7sKT0Xuu2b2g8SMEQAs5Y6EvHb7X?=
 =?us-ascii?Q?ohZG9NWdpnRzX32CKK4DxsHpg9rExszTb5bWsG6+48dvO62MNlbOj5cJCvyo?=
 =?us-ascii?Q?oDTxZZVIl9tNQZ8O/ZS6bzDcweYV+Z1+ZDBzQCFTD/UCii5NcY6thaJDuyDN?=
 =?us-ascii?Q?BeUJRmYKX38dcKwkFnVMlfy66o6lIYerM95PGPZnvjchey6azG3JNE15+a9g?=
 =?us-ascii?Q?/fw0NVXwR9f7GrmIWei4A6sKX7Lmt2olETN2ZLToR0+H/4FwFojKrzWWbqia?=
 =?us-ascii?Q?1RGnqDpXdmYW8rcDiM5O33vUen/W1lik9AoQ8WZYfQ4WKKY7txcmkdPv6GuK?=
 =?us-ascii?Q?fjSEG0c7ZCEh1jzRo235oVDDBPseqItX7t220lQdyx+9TYzthVA81Ir0RBxf?=
 =?us-ascii?Q?ZMTViAE+qJvZ8ETJGm//E3pW1syEFknUeNHwwqbWMu00UVczrVMRHo1Vm3QZ?=
 =?us-ascii?Q?3LaAxahOgUl6iGil4hM3ph2EUuoJFfKJhAF5Zfm5IUyen1AYxYTuWLtmIYnO?=
 =?us-ascii?Q?mZMn7ilLVbDwWXezRYwbX29rH6gyclXMe0ynVbBjkd2gWfpOo0QvYRNBDv+o?=
 =?us-ascii?Q?Lu4uV8mobDhVpEWpehZZilcQfqArzFcXzTrXfMe6DWrccvEO2/2nQhXR0scZ?=
 =?us-ascii?Q?ZAnP07nV+mq5i8c3cKNJXlhJDVsMtXZTrh2D3PSgHbHTyMyhfZJwpeB75dbj?=
 =?us-ascii?Q?IcFojt5+JrIoxY+p+DWV+zuSpozije0WBTDOjD8oOpwQJqnmPZmp7e/MKnhD?=
 =?us-ascii?Q?QG85UE9C/iuaNVttv+7sd3jtqPefGtqbGkLP6b4xSdOkJIZ4gY1SeUTumTs6?=
 =?us-ascii?Q?gdg91cP/dZyG9BfiMv5jQ2mKa6JoS23goa/ONottZkuGEA/w6akepYDtdIfD?=
 =?us-ascii?Q?63LPVGWZor7T3imaalez+gMWzP70xuojtEWv5zlh/usOBEMxSX/OnFn1GjRr?=
 =?us-ascii?Q?Vxbg8qi5HUu91n4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 15:50:37.8521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2627709b-0f03-4f82-376a-08dd6aeb9f52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353
Received-SPF: permerror client-ip=2a01:111:f403:2408::631;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

On Mon, Mar 24, 2025 at 08:19:27AM +0000, Shameerali Kolothum Thodi wrote:
> > If VM has an emulated device and a passthrough device:
> >  attach the emulated device to PCIE.0 <=> vSMMU bypass (or accel=off?)
> >  attach the passthrough device to pxb-pcie <=> vSMMU0 (accel=on)
> 
> This can be other way around as well:
> ie, 
> pass-through to pcie.0(accel=on) and emulated to any other pxb-pcie with accel = off.
> 
> I think the way bus numbers are allocated in Qemu for pcie.0 and pxb-pcie allows
> us to support this in IORT ID maps.

That sounds fine. The reason why I picked pcie.0 for emulated
devices, simply for keeping the design of pxb-pcie for multi-
vSMMU cases.

I think libvirt could still choose to keep it simple, although
on the QEMU side we have to keep the flexibility.

Thanks
Nicolin

