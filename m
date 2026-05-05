Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C0AFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 19:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKLbT-0008LY-Sr; Tue, 05 May 2026 15:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKLbO-00088X-Dw; Tue, 05 May 2026 15:38:42 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKLbM-0002u7-4m; Tue, 05 May 2026 15:38:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvb/iI11ckk6mhxLIq7ijoQrFbHXE22D2vTDpc7fuvdRvOm90b7mIEc6BYIeMqav16Pkh7Bb60G5Z/jo9AWdkRJT9U+wLwRYOgY63jM2dCVfLmdU98l85wKK0axxAbnB8R+tmBbHTdXzfrI0XEROx6/Vm95I6jTHLCZyNNwq1cQXJArmLN4HLcqzEkoNei8PZTL+dQ0XRtwQ+5PO5SfsSJhQaGFRaMSQAkgaX56PwHLnW+wMkCs7LuCFtZURei7qFDkItBQ71HefFJClJGWZl1TSc1piAUaPBGbzGZXIuStvM9hATnjuuxhlTJwCIOjNFBtHewSOl+Nex7chyH/eOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s76AqnDC02ySqmezQS+CeeVrxW8XH7Sknrh4EzDVJB8=;
 b=AheNbOUSk7k3Kb+M5ibORC+aStywJ40nBKiDHZMPVyISy5qsAKtSnL5h4a7f/vujcVnLJ60q3tsZWYCLJN1JXA2LEK8z2sWDtlA53vAueOZnnA7Y/oY3OW/T5/o06QNnk6aCjgo155KIszK23SdxVBtAWHlqe08Gk6QUyR/QcaiepbJUAhrsx7Eb2WLkjlSmna8j/q++fJVHbXwpUOh9vlARDvwk/j4/60/ANyzWD9jbyB+HSyngmvIvBDzNXuLuUPudy+zySDBCCbt53fb59u/vyp+cqfNLZ96WzgLkqo9TnnEQIgXWwACB828VNU87+td3fziCClOCcDZVlb5iHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s76AqnDC02ySqmezQS+CeeVrxW8XH7Sknrh4EzDVJB8=;
 b=jjImFNzB6DN8No7zSZV6isA7/HBK5nI9jjv1oiRkb80ek3uh41hoxn2+NWh3SMP6Em+8P6SnvXmNAC1zOrS+5GvIdXl2wJjbxt1jKTxlnz8udq/RjFxrOY44VlXWINJkiGT/+zESeLZp28+UdytABx8SEPVl9UZzcLC95uCxwe30CkwpNx15o1g/1cbeJxnq6As6vMxjJiFIPFWOHn8M0vH6vZIDVfsBA+INcrI7SfqcDC02q/rOY0B7Pbii87zB1AgunlF4qXRMqexUHSmU4NTUxbgK1qSmmASxftBL4MszodG/NUjcaWESe9NK5+tuL5JZhG4JiVSksLvQLYC2RQ==
Received: from BL1PR13CA0154.namprd13.prod.outlook.com (2603:10b6:208:2bd::9)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 19:38:33 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::1f) by BL1PR13CA0154.outlook.office365.com
 (2603:10b6:208:2bd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 19:38:33 +0000
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
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 19:38:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 12:38:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 12:38:07 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 12:38:04 -0700
Date: Tue, 5 May 2026 12:38:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Message-ID: <afpHGPsdG5F3xLlX@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
 <afk8f6BNAN2J/9f2@nvidia.com>
 <CH3PR12MB7548E9681835CC2A31ACED1BAB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548E9681835CC2A31ACED1BAB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: e4372dde-7d78-4cf3-e5aa-08deaadde49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vuoAa2KwGBl2fWncm5QTytndc7HLmrcVBY45m+M4mvfUAxNOYT4AlfRRcNsVa13mCFGX14EKqkUJsDfYiAr+TxT43yrDykfRA4jyc4jqhPU4pzEBb+HO2h7kWYDlWqOAVsPErK2+qpUUrwAIQQofUr1pZ0Zzgdm+Sl46XMeolNDpHr0xu3cZWVqbr47RjzgGOHPyDxH3Pp4a49OujLRZEgWmAVeRKQzvqh8qcVQZ04PRsZtGXbaGrSUJNpUhtwTbFs0xfShv999Ze7tYwGj9vCTeV/fThjlDpso6sDzG6ir+hnZ70ZakyGmrX84gTfzK2Fqm7P+WZ+2+ZIH6JytHOxZaL6KdrLbFbXugj1Anj4tDaKLB3DHN6CTAuFswkjVhUrUCPflSWRjNBd7xttke+zhV7NsYoGP1MT/ERGyxgeHwJV1O+9jyVqMhhob7QknF7P3LMl8VCdnofNE/rPiReyOumCmT9BsRQoacmc7knLV6xXAG42FRqRlpodlDE7iOBz4XHvn916VtG8K6iOIdvMuj2eCN3Q/+qf07kCpwAw4D6D6hAg2srI6inOILqX8mTI0DODrZFC8KlyjiPmoAQlFGNyiUdNTITExSVPdbOfRf1KILh3qhuK63Yx0GL5xuFwEsD4BuVKycLR72kxiBkgDgKhNRpl+Xniu5Spwp/HuEP+ysO2vBeejTdphSPivQb1BatcHU0eJVyUOqrC1ityREBcUBr+OvHEZLR1n7Ijc=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ESysKhiMkdL1OcFpbYNhDamO3m6dY63/HKYwspfCCJQdkg9uKjYGiLMlZuZbOqOvO7OA05uhowkf78UAVDRit5pT8ObbfpXXR7rMGH/xeB1vuHVlfyriDycgDM61QF9VFmu8EeCpTwr1qsFxPe+cqRWcnzSOVW6cAmhLsvR98FR/mGGk/NpuGlTyTRpWFfTg3ROSE/dU5Bz2oZrSUQ5z+XC8pOXNFNHkf1jx0IMYiy0MbJC7WvsoxqKjQODpZDslTgoHi/5r1LygGL3Nm9q46IO6TajWrPS710yzgWWKJmF9GBLD3MpmYX9ac7vrbx1pkXWdjD8JH8U1z8/CZvAnJNJsPnXqw2KYnZZppT6cgR3rc48HFn9sWBW8kodGpvAO7n6sCYLPodzfyQeM99pUPX4A+iFr6/pTaMuLj/KZyMce5d/oME5oE9W9UUTzs4nz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:38:33.1195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4372dde-7d78-4cf3-e5aa-08deaadde49d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Tue, May 05, 2026 at 02:59:55AM -0700, Shameer Kolothum Thodi wrote:
> > Also, do we fence against unassigned vcmdq? Corner case is that a
> > guest might write base address registers via direct (global) MMIO
> > space.
> > 
> 
> Not sure I get that completely.
> 
> Spec(p. 176) has:
> 
> "While the software can program the Virtual CMDQ(s) directly using the
> direct VCMDQ aperture (and not through the Virtual Interface), it is
> required that the VCMDQ be allocated to a Virtual Interface before it
> is used to send commands to the SMMU."
> 
> The spec only restricts sending commands before allocation, not
> programming BASE. In our model, the BASE write itself triggers 
> alloc_hw_queue so there's nothing to fence there.

Our model has an assumption that guest would map a VCMDQ to the
VINTF0 first before doing any meaningful programming.

What if a guest programs BASE before it maps a VCMDQ to VINTF0?
This can end up with allocating hw_queue that will map the VCMDQ
to physical VINTFx, while the guest hasn't map it yet.

> For other's
> (Page 0: CONS_INDX, PROD_INDX etc.), the vintf_ptr() check already drops
> them silently if vcmdq[index] is not yet allocated, consistent
> with spec p.172:
> 
> "If no Virtual CMDQ is mapped to the Guest, or if the logical CMDQ index
> in the Virtual Interface being accessed by the software does not map to
> any Virtual CMDQ, the access is dropped with no Fault/Interrupt".
 
My reading: "the access" means accessing logical VCMDQ via VTINF's
MMIO space (0x30000 and 0x40000). Yes, silently dropping it is what
we want.

My concern here is about the access to the direct/global VCMDQ MMIO
space (0x10000 and 0x20000).

So, if this concern is a real case, should we:
 1. If the guest maps the VCMDQ to VINTF0 before it writes BASE,
    call setup() to allocate hw_queue as our model expects.
 2. If the guest writes BASE before it maps VCMDQ to VINTF0, we
    need to fence against it.
?

One more thing to check for case (2): after the guest programmed
BASE and then maps it to VINTF0, and it never writes BASE again,
should we call setup() at map?

Thanks
Nicolin

