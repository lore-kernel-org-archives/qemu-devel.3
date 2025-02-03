Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190CC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1Xz-0001jB-Fl; Mon, 03 Feb 2025 13:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tf1Xg-0001Xg-Kw; Mon, 03 Feb 2025 13:51:35 -0500
Received: from mail-mw2nam04on20620.outbound.protection.outlook.com
 ([2a01:111:f403:240a::620]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tf1Xe-0005Vr-AE; Mon, 03 Feb 2025 13:51:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKiPLbMKO1Ce1Tt0U7tiZ8fxWkfGfVcDhAuFIzXjKksmUBfQOIahnR410NMYafHrMXVSK+SXXjgXReuftbMUyJ7uMj9AxWSwXSUaWNfEnRMC75fu+cJG9Cz4ve8U4IRipdFo+mvxd4IjGbXbWiRnGz5SqlvbB+WUjVYzd6auO+SVXvvKn/4+MuVLuJNo9bzdbUfJ4r4mLmuwTVwSZjkV9MSyjiVsLpdbPoFHyKKnTNJsRNozl4RJsgu7fch+QpbE1R7ifYrTon9T4hbn6wO+goMw8oa2d0M7mPGG9RDzWXqDx1iPLowsieMEND4j4ZlM+Q+kkC5HgJ+bmXDW92fGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/ngzArC4zKkAI5Q1qrYK7AeyPjdluw1/8pEOarWZ/A=;
 b=bdv7wBw9BaxjC/6MD7hj9sojbWl+c+LYe+qHi+W1gczNVHCN+FUaFv8NttTwJ1xssCQx1cmmYnr6P7uWbxnR/UVJ9HieAK1k7+ySKIVXsruC5WTbY7jo6PdvEvL6rblOeKzWb2FgesE1BaFZef47IuTrJNj5dhPM4i4rvs/zPtzoETAUaw7Rq/i2/mMYrZf2TEdJraoRZ/DjOczNRO2XH4jQKWQMHj5b5aRHm5kWC2HmHlambprEIM8h3HYK9FCIyGGpDQi8vIDVCZEhYx2dWo6QS2k7gmCqUyY/JEY74L3BDxDgwAKZA80EH1hJfC17z9HzfWt4P5sYSY2ASnF3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/ngzArC4zKkAI5Q1qrYK7AeyPjdluw1/8pEOarWZ/A=;
 b=NfOyIOhnskNmaLBbvvM3IJLT7WZY5W91G0wyRNzwW2tH7nxdl7Js3kGGmB0p7M4Lzs69SOCLRMlStwQXufEkL1WTXjuDsDVd4vBo2wz9qaKiT22ZdaaN8IcizGJJOAKklQGQcB9crwo/YMdah1EFw7P/nwOi/7lgS7jZlEawT/StbxrPmb6L0ecI0xtaVTzX3nMZs3yHp3WzyWjwoCvCaW5gTyA4WojX7/bGjK9qRJkUXvMY9nNMtJap3zLrkW++Xh0JPsrkuZhjWC5uhUNs9DtT6T8G5gPHHb2SJLBX+Nuldm5AnIg014nmou6HQ7h55DrmedqO4R6dewC3T2tVTA==
Received: from BY5PR20CA0034.namprd20.prod.outlook.com (2603:10b6:a03:1f4::47)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 18:51:19 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::e5) by BY5PR20CA0034.outlook.office365.com
 (2603:10b6:a03:1f4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 18:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 18:51:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 10:50:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 10:50:59 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Feb 2025 10:50:58 -0800
Date: Mon, 3 Feb 2025 10:50:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Daniel
 =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a012b4-0063-4e3f-be7e-08dd4483beb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/WYAR3L3pkesdPw3LgIdR0mNk/pKVZea/N1rGd0QGeKT0+K+3YtNJkMBSlHw?=
 =?us-ascii?Q?5fCpXPEAaOuw+pM7GTP4YNu8wwkMImFI64rhBOBSh5zvzVISWdqVEjRyL/3P?=
 =?us-ascii?Q?H/52A0vz0Xe2kQwySUiqn/Tw1cZ1DJENcwOL5pSoF4Wl7cs86npVZ6ODxg6X?=
 =?us-ascii?Q?JB4GCglvkvoZIEQcymgqlUZl/A8u8XZJ1CJE1hu6SHLA/PN+jrfysqSJx5qh?=
 =?us-ascii?Q?t6jzqd72nRv9eVvyaT1nnLG5aUxscwUANpQxsoSErX4yVgM3egLGTJpRdBpq?=
 =?us-ascii?Q?wu56CPT00eq5UTeHaBOQ7FO7+82gNlhFeEB7uMXU5GKTmjdLhHpLnC247ZQ5?=
 =?us-ascii?Q?9nHhl0n1YRT1EGhmOmnfhWhHsc4Nk+YrV+OF+mg1vnxYsSrqhSZt81jLXrn3?=
 =?us-ascii?Q?oi22xQBjgwxJKvQJ9a9ng+Q5RX76QsKrOwn2brjbKNEy9juJn8JHVzmEgHjv?=
 =?us-ascii?Q?FR6I3hgiU+JZbhy8l6/4Od8aOU0u3YP66iHfealssWEK6L18vzMJ24PIXk1g?=
 =?us-ascii?Q?7SZuVs5ebqiMCsQ0GzS4RMmZE3DEM6+MSHJl09IMXfDYlLbtG891XZWizJPp?=
 =?us-ascii?Q?Gvl+OQebXAHqUC81PrfjYLtKdY99UrNwc7ZaoDNWKYoeEfc18Y1sNBHwJoZr?=
 =?us-ascii?Q?aiXQjEHKTbPrrLLN3GaV1cwsaSNcAhjvxyg8PvlKZV9taVIAGiD5hs6VdGtQ?=
 =?us-ascii?Q?CKvw57w3BtD0o070JwwD/ipdP+X7B3mVKa/iTjCx5OCCpR18riGH/3clgU05?=
 =?us-ascii?Q?x5Q0+/kyO7yDvLLkL2+tijK9K+AyxvNAEP8AQ9IedizgTl0uXVjZqDXl/JJR?=
 =?us-ascii?Q?GDDQCDiPNEt/cheNBdYDR8o5Ey78/OD0MlSumzefSlmWFADhIw56wilyMWJx?=
 =?us-ascii?Q?I4Sn7cpt8hKvDmXmVe9YsvOA0+CzbNDx/QgfgP1ILkSlh9bOIoAAzqTZuTPF?=
 =?us-ascii?Q?nh5u79iKPLdrehQyjC1aroEBvnq0BsgYEuWrUhV6F8joZytb5cnIrI7GM4qL?=
 =?us-ascii?Q?0cZ5dCyqNP9r0mHplvBHeTBuMUrO5Lk0Cv4gvxsGQkqzaw47SBxbEOiRvKzc?=
 =?us-ascii?Q?YwWPRiS+Y5MkM/99p8vZcI6XNNePe7vaFStozWMbHAGR81IfctKj4tuYDqFW?=
 =?us-ascii?Q?3hyZYBUxtT3mp2QB8PEVl+hsQB40eabk57wbRDSha00YBtmXbCjFCcWnhTCK?=
 =?us-ascii?Q?D3lxta38Ttc4N5L1RX99yE+DM7MhV1EDQfR2ddE+68s6fnskRpK2As2V10K8?=
 =?us-ascii?Q?a04fnXi2G7b2EPHwNP1Gs8O/ANmOQTZdXqnRr4izAwnWTFyT5F+FEMCrrBvj?=
 =?us-ascii?Q?B8tD8oYFvHq84VhuF8g/PPPnGmxZwsSNMQxSNW28G+VaVc1IqQcSNvNd56kC?=
 =?us-ascii?Q?dWhVb4fw8AkSCBlGEggKHY/Lib5SjPBzU69QBbtqpv3D1ewClFmyYrxoKGzI?=
 =?us-ascii?Q?Y58+nEWwXPizWdYYrpUbNQllj3RUTdt0qINOpFwhQ3mEv+04uWyWTSRCaq0z?=
 =?us-ascii?Q?yUE13wzW/Vnstpw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 18:51:18.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a012b4-0063-4e3f-be7e-08dd4483beb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
Received-SPF: softfail client-ip=2a01:111:f403:240a::620;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

On Fri, Jan 31, 2025 at 05:54:56PM +0100, Eric Auger wrote:
> On 1/9/25 5:45 AM, Nicolin Chen wrote:
> > On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi wrote:
> >> And patches prior to this commit adds that support: 
> >> 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for arm
> >> SMMUv3")
> >>
> >> Nicolin is soon going to send out those for review. Or I can include
> >> those in this series so that it gives a complete picture. Nicolin?
> > Just found that I forgot to reply this one...sorry
> >
> > I asked Don/Eric to take over that vSMMU series:
> > https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
> > (The majority of my effort has been still on the kernel side:
> >  previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
> >
> > Don/Eric, is there any update from your side?
> To be honest we have not much progressed so far. On my end I can
> dedicate some cycles now. I currently try to understand how and what
> subset I can respin and which test setup can be used. I will come back
> to you next week.

In summary, we will have the following series:
1) HWPT uAPI patches in backends/iommufd.c (Zhenzhong or Shameer)
   https://lore.kernel.org/qemu-devel/SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com/
2) vIOMMU uAPI patches in backends/iommufd.c (I will rebase/send)
3) vSMMUv3 patches for HW-acc/nesting (Hoping Don/you could take over)
4) Shameer's work on "-device" in ARM virt.c
5) vEVENTQ for fault injection (if time is right, squash into 2/3)

Perhaps, 3/4 would come in a different order, or maybe 4 could split
into a few patches changing "-device" (sending before 3) and then a
few other patches adding multi-vSMMU support (sending after 3).

My latest QEMU branch for reference:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v6
It hasn't integrated Shameer's and Nathan's work though..
For testing, use this kernel branch:
https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v6-with-rmr

I think we'd need to build a shared branch by integrating the latest
series in the list above.

Thanks
Nicolin

