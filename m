Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8736CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGK6N-0004TX-7M; Tue, 04 Nov 2025 11:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGK6F-0004Rx-MS; Tue, 04 Nov 2025 11:41:40 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGK6D-0000x9-Qa; Tue, 04 Nov 2025 11:41:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiD7vHc+CsUatHI+6SVKP89fzcXLYBG633U2Bl/Xg9kvTFqAjzXeL8IUlPM7teld0SrZGHOEWUdWoiFzO5u0yx3i3uwZiEpqbNrCYwpaOOnpa4P2aaF5jI7+8jDJQ4+Xwl5+hD1xe8eUYzZ8SqoHJkCC5jHgQcfdUtuX/QF2oZSyoAv2BIB8onn6HPw/2BpA7+p6BtksQEk3tTB7Y4bxk8vmkRY0Ea2wrSknaH/jVVdfe3eaYsBhkZBt0Om8b8HsQTGmBTbAlvmuc4ynXMNwUChopy8Yzcux2CAYIcD+L5buFm5EmEo7o2XofUPFgnyDfiSKd2GvmdG9vdWE2+VoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/JnQhkydP56+xCfisz+rerb7ezvYuiKJ+OOCeYunJI=;
 b=jPUQ3ZxwkILBXI8zM7Z1oqsGwF86kHd4tKC3ndz7pSuXl4rYuDnIhKbcVxGDAQcSWO+7vCahglQ/DZeDHMlFrxErakh/HQJp8tziHNCS/jDmtnHbeTnhRYGwCun+jXgleIT+ODX/xTCQCTBfr65ues4mHDW96CmnqRNIsoIXwugRU7dN2p9aIimWW2b5okfxqG9ZOwkC11X3/c/pCpqoE+ept5+g6Hf2uoHYyaKaDdQ/s16mLB5xo6Al6FhVY5VdDfetKpg3JvG6kIU7PVY2GeB+Egz5uPQOEIM/8YK7Y3uiSVJPrc1FXJlKCMc3KXS8zfT3nCGueD1BrUgSenZBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/JnQhkydP56+xCfisz+rerb7ezvYuiKJ+OOCeYunJI=;
 b=utSdG1i//lPp1bugx9nOakoN1FXoH61lB0J6PH4uVidgiTrTHYBgvsxhROg8lEtMZSIW1n8Wm6KbY5QA21yJcDQkSXm0HYKkW5dputa+W2Dmek2OpNEC9Yg4mevfzBP+XfTdhh0U8j+NIW6j786xk9aKSe9NLUfY/zBRQAXGy5r2lvHuB1dtd+WPgzLxhqF30wVKjszYsdcdd1CXMU9UvsvdnK6F4cPatCLbwI3Tr4LQzvxjhGshYKNYCeQcWv+JRbbckI8nvk3xrh7Mi7AIQ0vH2ahGAOgCwIngEOvjIidZBRmjouxm3m+HSvWBOsL6rzDPOZCuEsGlGOJFU8bqkw==
Received: from MN2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:208:178::34)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 16:41:29 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::4d) by MN2PR19CA0021.outlook.office365.com
 (2603:10b6:208:178::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 16:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:41:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:41:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:41:03 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 08:41:01 -0800
Date: Tue, 4 Nov 2025 08:41:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Message-ID: <aQosnAjTXAmxq9LB@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-18-skolothumtho@nvidia.com>
 <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
 <CH3PR12MB75481D898FF28E9832B0013EABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQjpzdwbJVPN7AqF@Asurada-Nvidia>
 <CH3PR12MB7548CBA8B4C962BE867C9362ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQj5xQwsq/kBaJP/@Asurada-Nvidia>
 <b0a02ca2-6115-4313-88b2-f3218aa2b686@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0a02ca2-6115-4313-88b2-f3218aa2b686@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e10104e-9d92-4043-bf84-08de1bc0ff65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFdOTFhhUWZPcTNTbzJRRUR5eUZYeG9aNHhSTEtTUjhCQnBJTUpENnJKVU5u?=
 =?utf-8?B?L1B2blc5ZGRLQ0loM0xQSnBuZnY2ZHdZVGlnSHVBcVl6eXZYQVVlQkRwa1Fw?=
 =?utf-8?B?cTlIN2xJckpnRkRVa0RuTE1sTUt1RnlHZE1TN2dtWmwwT2podW9FVnhDbFpz?=
 =?utf-8?B?VU5kbmlRZ0hzZ1cxUXN6cWQ3MzRueUxPVEZ3WU9HcWVKdHV1T3h1MDRrb3V4?=
 =?utf-8?B?eVZ5L3pLek8ycDRiS1kxK0RrTGkybUZrS0FmdTRLenp6Z3Qvc3pmbVNUS2Jm?=
 =?utf-8?B?TU1BK1pCaXhOSWJTMnY0THZldEV5blpZbzJOZHVWNW5aaHRWZ1VUdVdmK2ZN?=
 =?utf-8?B?Z0hlWmNWc2NyUEQvWG5tWXlNQ3Bva0o3YUVodXBvNjNGTkcrMmtCVUFmS0xG?=
 =?utf-8?B?anpaQ3pscjIrRC8xNTZDU0xwa2gxU0lWdDkzbnNFejZ6WUpodHJjNlVnSi90?=
 =?utf-8?B?TDEwcklhZ1Z6a0ZvRkpyNjR6dFEwNkZhREhsVWVDZ3pHYkFNeml6SVA2SE5w?=
 =?utf-8?B?SHpUTmw4YlNVcU0rVk44QmtENFFyUWtXUnBhckx4Z1gwd3NqbzJvY1FFSUlV?=
 =?utf-8?B?QWdjd212aVpmakhOaVEwYWF0U0Q4cmgxZDF1SkxhaWlhMWlWVWJPWFMwWXU3?=
 =?utf-8?B?c0MyekorVEc1ckcrckxSV2FvNlF0a09TaTRZOXNZRVJwYmpQdUFRaDQwL0xo?=
 =?utf-8?B?OU9BaUhmUWNEdzUzTGd5SmRsbmltd0pTZG5vUFAzSjc2MGZwYW9aN1lEbk9R?=
 =?utf-8?B?VHMwZXByR2U0L1dwekZNNUpnZGRFQUZ2WlhkdDMvQ3JLVWpWdmtXajJJTkxP?=
 =?utf-8?B?elBlcHBQYlVoSEkwUWZVZmNUZE0xdFVBajVRaDc0Y00rekoybTNXQS9CR29Y?=
 =?utf-8?B?aUdJUzI4SXJ6ZVhLTUozKzNybktMbWIremlqNmk1N2dBK3RBUnhiTC8xVTFZ?=
 =?utf-8?B?djBVaFNBalVGNnJEbVM2K2NnV0g5S2NKK1FVOCs0c25kVHJXNTE0YitmcHFH?=
 =?utf-8?B?RkxBZDAxYndsRnZBakR5bW15ZUZPOTgzRjhaaVMvNUY5c3FqVFBhZDFBVWJk?=
 =?utf-8?B?ZEloMmp2Z0haUHRpR21uVU9CajM5WTFXOTNZc0tlUlNtaGxkUmpVYTNMYllO?=
 =?utf-8?B?Qi9uR1dTTEpOV2toMmpJN0paSFJjYkpQc1g4K28zTlZ3T1lUWUdMcTlQT2pY?=
 =?utf-8?B?Sy9QelFnYmJna0p2L0l1aS9Eck5vRmZBZ3k0aHNFSkYwQmowWmtvcHFIdU5m?=
 =?utf-8?B?cVBrMWNGVmdsbXFnazdYRXo0VFljeko0ZnAzb1NKNTFKdGxGQUVEbTgrdkQv?=
 =?utf-8?B?dnliWmxLcFh5dVdPaFNqdG5uMEhxVXVDTHQzUnpXNG9aKzZwNDRjVzZGanZJ?=
 =?utf-8?B?TE40c3JTaWo0cGxLQmx4WU5YTDBCVVhLdUgrZldENkFyelVsNmxIYVYvQ3FU?=
 =?utf-8?B?eUJnaFhKTFBjbzlQaC9kRkpKVWVCZ3R0cndzNjZZdzVLUU9YWXNpSTVZWFh2?=
 =?utf-8?B?eDAzN2hxMThDUVdKY0FlZUlGdlBsQmwvVCtIWVVxKzR2SE9XbWl4ZEhNaE9w?=
 =?utf-8?B?aXZTcEdNTVEyeUJrT2laeWxnSzNNazN6amp6L2ZEaTJ0U1pKejh1WXdQMElu?=
 =?utf-8?B?dkw3YzZnWG5HaDUza2RtUGp1WHpSWisyVTFZbm9LV2NTVVhTZ2J4THpaYmlm?=
 =?utf-8?B?QVlpSTVFUGg0WEdRUkpLOUtsMkdNMlkydWhoR1JWSXZkbjk5c05tdG9WVlBB?=
 =?utf-8?B?SDQ0TUtYV3QrRWE3NDJ2bHJ2bWliclBVUFdZL2NENmhwYnIxaTVJL3o2M0Fx?=
 =?utf-8?B?YVNnTng4eUhiVUhTZmlidVh5M21iUjI2TDgrc0ZGRWhyRjVISFJNcTJwYTd1?=
 =?utf-8?B?RXVXS2F2KzcvVG54Z3VMKysxb21ZejNBRnd4RXFFWTBwaG52KzE1YWs2c0VC?=
 =?utf-8?B?bUpXNlI4UGs4c0RMeWU4NngrOGFmcytQZnUrNHpEZHlDTUlNeDJsZnNFK0lq?=
 =?utf-8?B?TG0vRlE0ZURDZVVVZlNIZlhCbkgrMzdacld6MVNtSHkxZHpvK2VLQ1BqY3RT?=
 =?utf-8?B?UG5Oc3RtY05qN0RFY2NFT3NuVXUrTFhBTFdRbFR1UmU0ak9kK2t1UExTSkd6?=
 =?utf-8?Q?cW+0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:41:26.3855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e10104e-9d92-4043-bf84-08de1bc0ff65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=nicolinc@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 09:55:46AM +0100, Eric Auger wrote:
> On 11/3/25 7:51 PM, Nicolin Chen wrote:
> > On Mon, Nov 03, 2025 at 10:17:20AM -0800, Shameer Kolothum wrote:
> >>>> The general
> >>>> idea is, we will pass the errp to accel functions and report or
> >>>> propagate from here.
> >>> But there is no "errp" in smmuv3_cmdq_consume() to propagate the these
> >>> local_errs further? It ends at the error_report_err().
> >>>
> >>> If we only get local_err and print them, why not just print them inside the
> >>> _accel functions?
> >> Right, we don’t propagate error now. But in future it might come
> >> handy. I would personally keep the error propagation facility if possible.
> > smmuv3_cmdq_consume() is called in smmu_writel() only. Where do we
> > plan to propagate that in the future?
> >
> >> Also, this was added as per Eric's comment on RFC v3.
> >>
> >> https://lore.kernel.org/qemu-devel/41ceadf1-07de-4c8a-8935-d709ac7cf6bc@redhat.com/
> > If only we have a top function that does error_report_err() in one
> > place.. Duplicating error_report_err(local_err) doesn't look clean
> > to me.
> >
> > Maybe smmu_writel() could do:
> > {
> > +   Error *errp = NULL;
> >
> >     switch (offset) {
> >     case A_XXX:
> >         smmuv3_cmdq_consume(..., errp);
> > +       return MEMTX_OK;
> > -       break;
> >     ...
> >     case A_YYY:
> >         smmuv3_cmdq_consume(..., errp);
> > +       return MEMTX_OK;
> > -       break;
> >     }
> > +   error_report_err(errp);
> > +   return MEMTX_OK;
> > }
> >
> > Any better idea, Eric?
> 
> Can't we move local_err outside of case block and after the switch,
> 
>  if (cmd_error) {
>    if (local_err) {
>       error_report_err(local_err);
>    }
> ../..  

I see Shameer's vEVENTQ patch (WIP) has errp also that will end
up an error_report_err() in the smmu_writel() for A_EVENTQ_BASE.

So, it seems to be cleaner to do in the top function? I am fine
with adding in cmdq function for now and moving later though.

Thanks
Nicolin

