Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF33106ACEA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nKE-0006lm-Kb; Thu, 12 Mar 2026 17:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w0nKB-0006lI-TU; Thu, 12 Mar 2026 17:12:07 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w0nK9-00054r-F5; Thu, 12 Mar 2026 17:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL+HFxvZ47pNNz1IJbpAm4EdBcIXOQo7MVDQP9qtkDaDEJhoig/2MQogj0QuM41+OECqPD8Ui2goZziZPAuV+vWGjdHocFj/KdhO6v+PEBUtwIvsas0Efq+hfOt18kUO/p9lLFxd3OOzieep8q4YHHqNDHOWvKDC3c2evWqZPLyq7gsWy6ovD2mWNDVgeOhbvt8aFael39M9Q7QZNwx+aKEVQ1YFmktV2QsdMIfwPrLakXEr/XHbZ0vfADBi8GeYy6tGKuJjF0jgE6b36emU9jVgJSOVo+H45ERbhinq0goZIBjRcvJo1NKknnrmTpPgyuvLTFXYBxYE4Uqfykt1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/jZ6+McF+CP5On9LTINT2Qe05NBhOrc31XL7XBtpHE=;
 b=EZxpGhSN6qlYF8I6RvPWjYHRqTXg4qIVVX6woGn33MQ7o7sHLzaXpxm1s7V0bOcT6q+IMoRvZg/kRXaUUvUeGKtowvXvGPYL/APw7laPNelO3M+DUkUJaTHn8NbfxE9yDh2GSEWuQ4CZbUnl5tJf9MAWVVKqsTrkoTdG5xKmsZ/FdVhbizz7Hhv9cJoRijxArY53xbMf6hb2YZosUYIskm01p328t2FHJ9/m7Fc4JAVg3oMTDAjFC4cIXRDntCzGYn+EPkRUxEZYDqehmexu9Xs2vw0uowlWXCL9dGuVe+NW0AxnVqgfZ4EfbBz4Z7FtMJ0yaL4OEwrVduEZop2nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/jZ6+McF+CP5On9LTINT2Qe05NBhOrc31XL7XBtpHE=;
 b=U8+gJiDLYygQu4umvOsOSRc1UqQt2IEJBeF/x3JEuZ0xUX/FHzAK/PsGSnVRNk9/wRWTmzqhKgpEZlhyXSazoMN/VNO0loO+ryYNRPvcT/D2UTkvhrK5nd5ZDwyxkUmJ8QMiWo0pjbjR6PuPZFVx6f1pBg7GIp13NAIYUHbtAGlc885HKHMPkIdoG1leDE8xeBVO6tAQBYeHbHIjPWJ3CHaq1KNWyl+JixiWuYhceD7nHMvy6icZf+NNiQ73jcvXjq5ELr6pTDWPMi4FBj8uYqhayQmFfqyQzekgWDrFjAJxuv4FpbN5tGPNGzTMqt51N8DP9arOfmGtDQ++bvYIxA==
Received: from CH0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:610:e5::33)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:11:56 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::13) by CH0PR03CA0268.outlook.office365.com
 (2603:10b6:610:e5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Thu,
 12 Mar 2026 21:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 21:11:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 14:11:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 14:11:35 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 14:11:33 -0700
Date: Thu, 12 Mar 2026 14:11:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Message-ID: <abMsBC8xgCdyKp5C@Asurada-Nvidia>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-18-skolothumtho@nvidia.com>
 <22acfd93-72cd-49ca-b2f6-a080bf66104c@redhat.com>
 <CH3PR12MB754885F68C4F08CC39732EB2AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <8ee0ec15-bf22-473e-85f4-96426a9e763d@redhat.com>
 <CH3PR12MB7548CED599FE7D572486BD6AAB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <641d5a7b-e487-49c5-abcd-4efce4cfd56d@redhat.com>
 <CH3PR12MB7548AB5CBDD893E34F4542E7AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <70cab06d-2114-46b6-ab56-403cbd0003e0@redhat.com>
 <CH3PR12MB754836BEE54E39B30C7210C0AB44A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB754836BEE54E39B30C7210C0AB44A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 5883825a-206f-49f8-ebbd-08de807bfe3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: a3WvZqeduDM3uJ19n5fzPNekhbiYUCgDysNA5FitMq3i5fOeqe/+Vpx6ZJUQcue7Ew90fQxhMncOfvtxz5kpAN8dYmDkB2RNk8z7oQVgbaA/CGR9Rx5/1g+0t8wEcucNt+uCWgPRGvTaD5s+YpwlhzUVzOdn8+EUcPHXUe5ykcUVs/S303u0fO9P0SkyVWIKL84ScpiGqv14XlNRjq/gyg9mzOGB7GipHdAtBqMRxhe7NStmusH+amrKCLWeC6nYrAFWbO5jzJmvMMOpLFucFwS9dBj7fgjtoWqTcSNiR5leXnKMPzc4ppWRIImXOJ7Hu1/8+V90I+41HkgJkCktHIeI6hojG5Gsbu74Wrph6zsVdhwIEfDVlNyoM+pY01RvIIMcg7EoqjNBn7P/E4/aE4G7v6l+gWTgM1XRh3d5fGSWLMiOdKUBK/Efwg6GzuVIZ9dnsj2zFmDJ+S7M4XLfL95RzmyIzuienzdBPhJ1F5B0WlP8+Nn8D3yReEg6qe1+5wouJGHTLMwqWQJE55Jk4y0dEiakPFVjbnGjmGiDwcexHdr7htWsRdRu/C/1OiM+F9acsbCcqP4MFUmVbvLQre8i25TA2k6sP68TsEy/dDJYyuTWsPhdDBxf9/WRQKFNrgcbYQ5YHimkMSCqwkgQTvmJ3MJQUdTxtGkUjWOCAhf+6mHsFxjJsjDpz+VvMqCRw+wRv6fkxjD350QO79Db1C3BuHnmXPGg0QyjUCsfCkIQgZZYbqam0X8Ifed9IVWKzTBffwzs5kQ9McaKgw9jLg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xlQLL5Zt4YxgP1oYFq8ZSnwE0ppKg1wSgSZS8W407RJXV/N8srzIuKueVc0a+cPjJL0uAVOxEZ8nX5q8SY1hCOjsoiR1hZvlSBLaR/X6XdvCVP9RSSRsYpGInnxRUCqkFT4DZ3/Lx1u1xjqpBAIg/nzRB7EPAHXOO59DXcdQzdtx4g8fQTZlJoyD3ybl5LhuYkcoxi14Ri3tt6oOsNKZR3/Jk9MtVKYlEPpkz8WrXfJOpcMuDarZmXsio4dJHJQK4bPleQgK/VHOTLyl1nlLYReInyw3t5stnTgkx0/GKmpIfnsAVoTq23pAvQQISPPbA1EZzcxRwuzQ27xOzGZFawbwBs202YbcwKFIJkZkFu5HOBbaMyg5YJGe8gIUyR29QE8qCe06eufIfaObBP/++JCEsWym17nqllECG7uyTcb86DM1u7jLoCU3Jg+PNWOG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:11:56.6078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5883825a-206f-49f8-ebbd-08de807bfe3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=nicolinc@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

On Thu, Mar 12, 2026 at 11:05:36AM -0700, Shameer Kolothum Thodi wrote:
> > I understand. But guest works in HYP_OWN mode as it sets the HYP_OWN
> > bit. So resetting it looks like a hack to me, not documented in any way
> > in the spec. Besides, as tegra241_guest_vcmdq_supports_cmd() forces to
> > send on the cmdqv cmdq only legal cmds I don't see any problem leaving
> > the bit to 1. What is important is that the host does the check (and the
> > host sets HYP_OWN to 0 for that cmdq). I did the trial to comment
> >         //value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
> > 
> > and it seems to work properly
> 
> Ah.. that’s interesting. .I was under the impression that we are toggling
> the HYP_OWN so that guest does sets the tegra241_guest_vcmdq_supports_cmd()
> correctly and delegates the supported cmds through that queue.
> 
> See, 
>     tegra241_cmdqv_init_structures()
>         tegra241_vintf_alloc_lvcmdq()
>           tegra241_vcmdq_alloc_smmu_cmdq()
>           {
>                .... 
>                 if (!vcmdq->vintf->hyp_own)
>                       cmdq->supports_cmd = tegra241_guest_vcmdq_supports_cmd;
>             
> However, it looks like the above happens before tegra241_vintf_hw_init(),
> which sets HYP_OWN. That may explain why toggling the bit here does not
> make any difference.

Well, looks like we exposed a kernel bug...

It seems that the sequence of setting hyp_own and supports_cmd got
inverted during a rework when I got the driver upstream.

It turned out that both host and guest kernels sets supports_cmd to
tegra241_guest_vcmdq_supports_cmd().. IOW, the host is sending non-
invalidation commands to the SMMU CMDQ rather than the HYP_OWNed
VCMDQ, although this is completely harmless and probably does not
affect host performance at all since non-invalidation commands are
not that frequently issued.

This explains why Eric's experiment didn't fail. I'll submit a fix.

With that being said, in QEMU we do need to wire HYP_OWN bit to 0.
This is not decided by the spec, but by the host SW implementation:

 550         /*
 551          * Note that HYP_OWN bit is wired to zero when running in guest kernel,
 552          * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
 553          * restricted set of supported commands.
 554          */
 555         regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own) | 
 556                  FIELD_PREP(VINTF_VMID, vintf->vsmmu.vmid);
 557         writel(regval, REG_VINTF(vintf, CONFIG));
 558
 559         ret = vintf_write_config(vintf, regval | VINTF_EN);
 560         if (ret)
 561                 return ret;
 562         /*
 563          * As being mentioned above, HYP_OWN bit is wired to zero for a guest
 564          * kernel, so read it back from HW to ensure that reflects in hyp_own
 565          */
 566         vintf->hyp_own = !!(VINTF_HYP_OWN & readl(REG_VINTF(vintf, CONFIG)));

This should have been mentioned in the uAPI header. I'll submit a
patch to add this line near IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

One thing we need to get our head around is that a guest hardware
is different than the host hardware:
 - Host HW is backed by a VINTF (HYP_OWN=1)
 - Guest HW is backed by a VINTF (HYP_OWN=0)
This is a fixed configuration, decided by the hardware and the spec
also.

Thus, the guest version of the VINTF must align with its underlying
hardware, so QEMU cannot allow setting HYP_OWN=1.

Otherwise, guest OS would have no idea this is a guest version of
hardware and would issue unsupported commands that will fail.

Nicolin

