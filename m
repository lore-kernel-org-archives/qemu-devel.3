Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CF0EDF04D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQZP-0007O4-PF; Thu, 12 Feb 2026 01:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqQZN-0007NP-VM; Thu, 12 Feb 2026 01:52:57 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqQZM-0001tv-A8; Thu, 12 Feb 2026 01:52:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm0IqcKCIVYbtvDGWxxkcrRuXF/Ik4gVk2FOnqcid+jRQvlzRFF9AUw4PBy7sneBM4QaB1QOnDJUBFtCY4wv6ScOs6v3xz+MnaftO1VOzsvO8OIOcZdYvPo0VsqAvd2H9WF0oIgt3XVaE08aIEdUxLx2sV1OVOxqrcUV07dSoIWE8KcVT9Ly67GRySD/f6HXdYbIwEpx/mqifExbOo9qNh0i+MR1UeD7bAhob3741TSnPhvlP003AgIjSyihZDwhm3t+nc6i2oo3fZcBt3mJEcgb0mwdn0pexdnGdal2hXA8pk1iQfD/4SLEcjIGFch0+J14Xo/7EW/akb2JvaaJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQYE0lo+pBi8mXXbU4PyjlglJDXcLo7CxD0k1eSd5HY=;
 b=yd5trZJ49FsKT7yN36mz+ooNrpCYMYrptxD39X/kPqbWsRlrqqGJ7ZYhbftlXmb3/yNxZBUnfP9jgYcuzEVF+AQTOjuKfvDWV3kyhj26+S9HO4WB5ghxVayteWrXY6+FvxmUO3MubCjB6548g75Xy85MWBRlgnLgUvbs4xklQyQhX74uWCeeXTO1VEKE3oGpu9ljiNCKQxmGLWaaffTlu+5b9WzPW8m/QhK7ikCu2KQN0LO2P/m1Ob0SGwVAkQu6oIuVgWt2Kmod8d5aso+CxgjGw9bm6A1lK11mmBj9C2O4uf79yFJjnHZPIHJddqZsE4PwfxHCEdNQTYCTyJfS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQYE0lo+pBi8mXXbU4PyjlglJDXcLo7CxD0k1eSd5HY=;
 b=LlzSTWbTl0CVFazBoHQ33xZ8WZGaZ4gcqF75zBrDYyA2T2Y86V2ICwgS/JGAGJe8l/3glvHYhllyGUQ0dLrC5jYDcRb4UWccZNBUoNflAOHTep4kmUKNE2oGb5sqknr0ys6IhIvntG9gcmFGjYmHdpqazGenzXXzkYx8i2ifZI5bMZQnd61pmDdB9gtRvpUAsUW19YBpcp9QC4qIjMDmLFsTmL9BQrVVXK1E7EasNBHxGq4cQnIFbLEN2FeUL3x+ikWN0oU0sSu4g3MYHPbiBLhFoR9LbMqFXj7x6o+ezVnss7RQmsAdl2Wy93CRCzz/tsvo5fJzqlWEhbzcfH3Jzg==
Received: from CY5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:930:8::37)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 06:52:48 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8:cafe::bd) by CY5PR03CA0016.outlook.office365.com
 (2603:10b6:930:8::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Thu,
 12 Feb 2026 06:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 06:52:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 22:52:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 22:52:32 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 22:52:31 -0800
Date: Wed, 11 Feb 2026 22:52:29 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <aY14rcVQuLs3ugll@Asurada-Nvidia>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
 <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYzTUDmTzIZZCwnW@Asurada-Nvidia>
 <39acf072-3227-442b-acfe-658829071917@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <39acf072-3227-442b-acfe-658829071917@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b428ce-50ab-4a70-8d28-08de6a03554d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JxC//Pi6KT9PheQbLjzS4n64dxzokNi6glF97qs1sVosQIW6s5jRVBxNQ/NB?=
 =?us-ascii?Q?X9W8pGpFs7P6QuZ3sAko2GK7dxMGHg1v9neIcfzQyeNu+XzHjD+WgbKNUf4I?=
 =?us-ascii?Q?BfR20vnunu/hCUEU6E3XSrjxn9XA1ws9HvJcQiJwWr27ba941ndhLvV8jM2d?=
 =?us-ascii?Q?6BzXg28wpNMyTrgjV6VK0uraJjLc71lfKxPBEckEBLjdazg7heu2PXaqaPR6?=
 =?us-ascii?Q?JaFhDeLjy3CwiDJmvpGO8XKNwYKKWZkVY3TN0Jq02h/aFzN/kdhi9J4zESxZ?=
 =?us-ascii?Q?Majt6ZXi1iHUiA/WkvZ+EOPxSDxMZIoc5ui6nUBPPYwb4IWxJxEUzLZtG9ND?=
 =?us-ascii?Q?LzBBxs1OxOi1j/GAm+3nffqBqE196zENNNTI01i4rwEYwL3Y33U720EsnSqf?=
 =?us-ascii?Q?vHwdJki9K1mIoMrxDMmo4yP3jKeaLkSTdpi78T66eFuHB4GxPtR6QKVu+Ion?=
 =?us-ascii?Q?/50oOIVeiFDr3RCA0poLp8AWzUUvwYW4jMpCXxTPQ5LiKvsVm2EXTTcn4UMw?=
 =?us-ascii?Q?Imgk2qktbVhx58ti5G15B7I9G47Kq41Dd7bShB9dfHQ8N3ti3px8QM+VIqNU?=
 =?us-ascii?Q?/oNYJxvlvirVJL9yC2MXQAWkYrduhwuMkAxU9ldOgAXu8ZxLgyN/P9OTRWS5?=
 =?us-ascii?Q?mIdq2vpfrRG/jNFCSxkY6VuYEC6gV664TxCGFyesZpkhMguLac67xhorULQR?=
 =?us-ascii?Q?Fd5MRbpoRmtcb9jQ17PthccxMyVkvzMoeOCEtNUod7IXgvMUhcaVF1nSM0SM?=
 =?us-ascii?Q?Tuw69D7ZzOXIRpS2aqEawFVxM+mc4CzW2DKK/9xpmd9eyH+6sOXk97ydt3vw?=
 =?us-ascii?Q?+SCSutQsPpRpZvUWlPkv7VHffB/j6BCoGBhtXx7T/DvXOVZlMhjnKw3gIa3L?=
 =?us-ascii?Q?KDKH2ma2I7UYj4x0VdBR97mth1xMwleYGbpIhy6iz1WtrEZRKzmqwyeyvV+T?=
 =?us-ascii?Q?FMGcnMxsxPZGonqYpP43yrcCWLWdrl3QDOgx1jWM2jY7xtqgBj0D82KRf0tx?=
 =?us-ascii?Q?SG2pr3wy6FBgjSFiYgdTUhx0NNSS9BiIaF17MA1o5xQdxbWRjSjyB4wFeRZo?=
 =?us-ascii?Q?oyaFz8Krg2Rmfy5WGEqdG/653UP8uc4fKbDvDdSlmcsrDNU/I62sU/AAysfm?=
 =?us-ascii?Q?IH+ZHw76bCaBvbkveIXE7de7rXB22jnaFAvI7cvMr+BFETkxL6wHmJpEbfYt?=
 =?us-ascii?Q?iUGjQnRv5GZXFYfW9S+ldSLaDHOOESFFbpZtYEsJW+j9xQCn2HH0+1yEzNCG?=
 =?us-ascii?Q?EO3J1DG6jDtT2BJzEXl4InMb3Yk5bCgO7wmdy6P2mgLp085B64wHj4gsE/Bj?=
 =?us-ascii?Q?aGchG8//q1zgYSxafsFMHvrweaWSEbVUe47Uy958WnrdlNGD9bw8PQgjCOfu?=
 =?us-ascii?Q?ZErcLRJtqmqfci5E9RdnuLYjHYq30T4yotB8jbPUlhNzFxDnLIvedF5e2tDX?=
 =?us-ascii?Q?5mDDqMBbw7aEAFjEXVQDPr5ujfEyWm4FuPyHGb/SLy7uU8GOFdgryXcwvU9N?=
 =?us-ascii?Q?0GMNzHX0mTvt4uVWToRyGjGTsW8XlxnPWvz/WWm6Sekm0ycnk7fEHZTp2GG+?=
 =?us-ascii?Q?5+9e0REsCyt6E9W7wWz9Ipak4ihJOckXz253s9pCes38Ta6TrAiCFg9yZanj?=
 =?us-ascii?Q?tshf991yZrEzf6FxAyDIVSRPv8YKZewlNnc1nOQ6cxhHumKzhJo7KlqFgqab?=
 =?us-ascii?Q?kT4JZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L16C7KouD0V06RY+6SNpNENuXuQCbda8oFZ56lvwWaSDp7ZAazGGP5zgAAzsiQgvWg83OADe27R2e3DBzN6BHTqkTBg+dGDf6dfUQB5P/jvueeKfe+VI50cZhU294eyU8GR7itazR6eRyMksyYIo0V/3M/OOVGmJIhE0kd74AoFR6XjoCv/LwWtBttsZ/wwhyXjewZ12SyylToLfmOf7O4rUhWtvaSMmrgwfUYpypx/DBtKA3UWl/vdYRU2VE+fg3hS1GiYJCAJa2evQlebAMUqdjKxhYR9wqG+dcMmtm8u65mZEXogwwthcX88XAmZQvsAbkp4P8Bco9Ll1a3QHVEHWPQ7TSRASn5JPmnxPFDjfv+kerp//yJn97V4yHNeQQhmZznPPJmBQ/CdUg66WJpJ74twWXGD30KTc1sixnvf2hkNGWSWxSLv6o8ufIWcC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 06:52:48.0182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b428ce-50ab-4a70-8d28-08de6a03554d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
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

On Thu, Feb 12, 2026 at 07:39:03AM +0100, Eric Auger wrote:
> Hi Nicolin,
> 
> On 2/11/26 8:06 PM, Nicolin Chen wrote:
> > On Wed, Feb 11, 2026 at 10:43:04AM -0800, Shameer Kolothum Thodi wrote:
> >>> On Wed, Feb 11, 2026 at 07:14:40PM +0100, Eric Auger wrote:
> >>>> On 2/11/26 7:07 PM, Nicolin Chen wrote:
> >>>>> On Wed, Feb 11, 2026 at 08:34:13AM +0000, Shameer Kolothum wrote:
> >>>>>> +        if (local_err == NULL) {
> >>>>> Does eventq need to rely on !local_err from cmdq?
> >>>> if local_err is NULL we can safely use it, no? Or maybe I miss your
> >>>> point. maybe test !local_err directly?
> >>> Point is: if local_err isn't NULL, why can't we allocate vEVENTQ?
> >> Technically nothing prevents that I guess.
> >>
> >> The only thing is we have to call error_report_err() if local_err != NULL
> >> and then set local_err == NULL before calling  alloc_veventq().
> > Or should we use:
> >
> > include/qapi/error.h-402-/*
> > include/qapi/error.h-403- * Append a printf-style human-readable explanation to an existing error.
> > include/qapi/error.h-404- * If the error is later reported to a human user with
> > include/qapi/error.h-405- * error_report_err() or warn_report_err(), the hints will be shown,
> > include/qapi/error.h-406- * too.  If it's reported via QMP, the hints will be ignored.
> > include/qapi/error.h-407- * Intended use is adding helpful hints on the human user interface,
> > include/qapi/error.h-408- * e.g. a list of valid values.  It's not for clarifying a confusing
> > include/qapi/error.h-409- * error message.
> > include/qapi/error.h-410- * @errp may be NULL, but not &error_fatal or &error_abort.
> > include/qapi/error.h-411- * Trivially the case if you call it only after error_setg() or
> > include/qapi/error.h-412- * error_propagate().
> > include/qapi/error.h-413- * May be called multiple times.  The resulting hint should end with a
> > include/qapi/error.h-414- * newline.
> > include/qapi/error.h-415- */
> > include/qapi/error.h:416:void error_append_hint(Error *const *errp, const char *fmt, ...)
> > include/qapi/error.h-417-    G_GNUC_PRINTF(2, 3);
> >
> > ?
> 
> Usually error_append_hint() is used to append a user friendly msg that
> helps the user to fix the problem.
> In qapi/error.h there is an example that relates to "Receive and
> accumulate multiple errors (first one wins):" by using error_propagate()

I didn't look very closely but just run a grep for "append" :)

Yea, I think error_propagate() should work better.

Thanks
Nicolin

