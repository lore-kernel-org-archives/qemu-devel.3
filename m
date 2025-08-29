Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E41CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN43-0002Yx-MZ; Sat, 30 Aug 2025 11:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urq60-00044h-Ek
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 23:48:12 -0400
Received: from mail-mw2nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2412::614]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urq5u-0003eI-US
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 23:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4fRTTrCRmkj85XIwEXur43BzSEp7zK0p044CYU0gg1jcxT2pkQa/F8rAm3esU8QTXzyNW6wQeZzuWhEimuJ4aG6c9CPrrG3v3ecitbRO/xocshPuM8i8VUpIAvGgTCrj7vhzbipqpds1ejsLCCfvIPj+EUCd+rCIw2Ap4NhgaUemVfIAsR+PcGD1baOfyzuBwR/rVdm1/ybWZYjMMdQG9EjadozeBEKStDd0IuXyUanEkMUEFuCCvWifUjWtbT2pu9RmIQwH+VzuDvoay0R73eVkfHdUaHajD8gmsdU56MbI4vSfW0eY4fdSaaYhyq7Bco6BFvYxeNz/gwdftP/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc+8fWldv0ZdcaAXx9Zq4H64ke6bEWx+VcUiPiOYeu8=;
 b=gHgEbnFCk/tbF2eGJcWZzv8G3Pxx8R3fFG3YjjJOfKv+M9EgogvsOiWimCK7qOBgo1OM18fCy1aqck6+jtZ9J4BgZO2EPu7pVqUQGIA5tekWeoGK08SIx4G+pryN6rQsUWiEcvzpXQJR7d7UZf+y/IMo4Mk7MQyD4fdf5AKIy9Cp+/857gG0V+BIoznV1/HKFKQ/yCe/vyrALIuzvCDAFOPYXFFyz5I/ok2lk4V3GOIVNHk33sQhDCi64bonFC5MXhB7noDMVQKzbsPQ9lSJxgOf17Xyk/VSICc+mLv2hy3XL/d5Uo6i8uYCZ6bki+zI0TmCqyChiE67N9f3tHiPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc+8fWldv0ZdcaAXx9Zq4H64ke6bEWx+VcUiPiOYeu8=;
 b=MxELsqOTComU7rQayHC8LKDu+HH5ipLq3coBstly+Y3oZFtw2tWrRcB13gAPavxNlqiAq8y7oXxM61NqtWh6CoxrhOueLHJkCSh42v/7ZZwKK0Hcf48VT0RNc4jToNlztUTYQS1eLKjssU2Mp8cAJfGjysKu5WK6nAUXeoRPujlWVDVVUmjCDs5DfrqltbFXxjAilO5EsFD5iEY/UCx9+2HarD4h7PrLKcV1Nl5gCr7KUj3Nws77ohD9zH+GzLvg8oQvQRTqqZp1MGzJoWwFilqKTR3rmoPSh3NYyRJSEB5REIh9uWZezK00Q0+AUd9UsNKJsKPm3O598r76FHfYeQ==
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by IA0PPFB67404FBA.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 29 Aug
 2025 03:47:53 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::4d) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 03:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 03:47:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 28 Aug
 2025 20:47:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 28 Aug
 2025 20:47:38 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 28 Aug 2025 20:47:36 -0700
Date: Thu, 28 Aug 2025 20:47:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Message-ID: <aLEi1yjlmdNeJx08@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
 <93a7a387-ae57-488e-b341-2beea67bf78e@redhat.com>
 <IA3PR11MB9136E928181D1B95F5AD39AB923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ff8022d1-6363-43c7-b095-cf8f0a692a16@redhat.com>
 <IA3PR11MB9136713B0F6F9DD8D5751294923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136713B0F6F9DD8D5751294923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|IA0PPFB67404FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: d20768f3-a8e9-4ac7-8670-08dde6aed571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2D6XeIsy5lPS9YNiaqiQSErJqwM7CxZ0Iv136PGGAFJrvz4XGcQGwR4HR5KK?=
 =?us-ascii?Q?akOG8+vSxMR3izrZgQiuhZkQg+CCvzFnFMyzGxBrxb3WGi/0YbMXZ5gPMmnr?=
 =?us-ascii?Q?OM0orEwp7Sp+PCen05mEBzrzD41uv7ui29uizfuG1f/detZBlP0Otpr2pE+b?=
 =?us-ascii?Q?mex3O+I/buaDxsC3KkA3zZBG7MkHtv39SgML6ph9+LTu7+tDd8SvkhBjyF1c?=
 =?us-ascii?Q?dwqETY0uWJOUITsl28tJ3Jj+Aliw9qXbkUL7my+NL77Zdqp/4EmgkFEbWmV0?=
 =?us-ascii?Q?LTulFoswjUzOxvkUza6Dbgni4iZOTNMxeMOAoL0cRWAhaVeR/GynAurbQMOW?=
 =?us-ascii?Q?zAs8a2tMdV9gGAmY7fDfzttO4GY9Y2wOJ9/kUrEikHJidR3kcEcz2U/+KclP?=
 =?us-ascii?Q?OywOLY+sEfyg0WjIbgbO26z8n4l2Y3v38G69q2dHBY6QnJNmvdZee6CWlwyE?=
 =?us-ascii?Q?kbD2chapIJxfXZZjcwQfpQpSnuepDUV5nOphgV0WdNhypX8/XJPL5+5IHKu0?=
 =?us-ascii?Q?qs5u5UXIf2tFot/YXWy+d8rVVHGDGptQAOU4iUc561supqTwVI8pJm45q5Wu?=
 =?us-ascii?Q?GMJOf6cR8oToiYxEDkwRVroBFKEaQ/qAm7nrO/TPHmTR8KZVniCWLAz5K2Y8?=
 =?us-ascii?Q?L9mj29BlS4J96fxRqnqxUqHJZxriKgltoX/kHWX0WyOcysVhCXvdKayFyDF1?=
 =?us-ascii?Q?7eBh2GxS1aECUY3aYRozfd7tptKDXRi4K4D/spStLufEsMEznAyr7CTruqpQ?=
 =?us-ascii?Q?e82k2a0Dhzoan8l1qGzT1lijamFZfBgfXK6q5p5kRodl7ofECZXUgeI/XjnX?=
 =?us-ascii?Q?D6y69dj6L5gq3NswQM8kvkk+gZvpCij9UqIWBStO5r3NSRa0IMuComvRLbPQ?=
 =?us-ascii?Q?uBDjaKYk8BsXqppMXnR8dNdB3VMBTJOYSzgECYSsd8GCFJqxsNiaBHPDyRq1?=
 =?us-ascii?Q?D+xvyUVol7CC7LwbTPsTX9yXN5CBHgiBHOLCw6P16fTBCyJYgMY8FFqiDOiI?=
 =?us-ascii?Q?aFgqYIDvCzGBhMPjLcubaV/qmclHaQroXnzlI3qDOEjw3krhtCBK2Ci3T9Dw?=
 =?us-ascii?Q?7bzp/dLD1Y3anuQeAKlNdpFWyCa9f6X0FBYDRDuap0hMtWMsyx4d4eJSh94I?=
 =?us-ascii?Q?qB7HnuVi1QUbVPIcmdPosXwIS38C0afMK/EBPhjbVnCu57QMB9MHL02SwCdp?=
 =?us-ascii?Q?PAIMi5r6/cvs40moYOew8FCQFJu1SjTaAMa0vuBUePyj8m873ZhzOT1vGYmD?=
 =?us-ascii?Q?yNyvlKlckleT6KNugbIbCJbRNx3sr8KXWcksghA8krP7n5e6TaJZb8UDZmUB?=
 =?us-ascii?Q?JdMHj0Yf+30HOtLmPERfS810vqqOuoakiIsksKGiAbm0Oao+p4+57tdHYQUx?=
 =?us-ascii?Q?lT09tnWJxZ6vNgS79lfJ3AdrgecosTLFbQm11G2j7RLudAKsdbHlgRGbWz0K?=
 =?us-ascii?Q?FKm9Lg3W6GTo/a2UDSXLvmiA+P0JoLbeqtbxhmMrVp0OeCwp4TKbpV3A9AGu?=
 =?us-ascii?Q?o9zwoyDW4ZgEUJB+8vHDsLUtv2Wgs//Qff1D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 03:47:53.5530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d20768f3-a8e9-4ac7-8670-08dde6aed571
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB67404FBA
Received-SPF: permerror client-ip=2a01:111:f403:2412::614;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Fri, Aug 29, 2025 at 01:40:01AM +0000, Duan, Zhenzhong wrote:
> >-----Original Message-----
> >On 8/28/25 11:53 AM, Duan, Zhenzhong wrote:
> >>>> +    /*
> >>>> +     * If vIOMMU supports stage-1 translation, force to create nested
> >>> parent
> >>> I would rather not use another terminology here. You previously used
> >>> hw_nested, I think that's better. Also bear in mind that smmu supports
> >>> S1, S2 and S1+S2 in emulated code.
> >> What about 'nesting parent' to match kernel side terminology, per Nicolin's
> >suggestion:
> >>
> >> In kernel kdoc/uAPI, we use:
> >>  - "nesting parent" for stage-2 object
> >>  - "nested hwpt", "nested domain" for stage-1 object
> >I still think that since you queried the HW_NESTED cap it makes sense to
> >continue using it. This can come along with the kernel terminology though.
> 
> OK, like below, do I understand right?
> 
> +    /*
> +     * If vIOMMU supports stage-1 translation, force to create hw_nested
> +     * (aka. nesting parent in kernel) domain which could be reused by
> +     * vIOMMU to create nested domain.
> +     */

FWIW, while I was targeting the word "nested parent", I think Eric
was commenting on the word "stage-1 translation".

The vSMMU code supports "stage-1", "stage-2", and even "nested" as
its full emulation modes (no HW acceleration). So, any word like
"stage-1 translation" or "nested S1" can be confusing to the vSMMU
folks, as neither of them necessarily means "HW_NESTED" that stands
for "HW-accelerated nested stage-1".

Also, "HW_NESTED" != "nesting parent". They're two different things.
Thus, "force to create hw_nested" isn't accurate. Here, we want to
create a "nesting parent" HWPT. There is no other alternative name,
IMHO, given this is essentially a kernel-defined object.

Anyway, if we all agree on the VIOMMU_FLAG_WANT_NESTING_PARENT, it
is not necessary to have this comment (at least the first part) --
we could still note that the nesting parent HWPT will be reused by
vIOMMU to create nested HWPTs, if you'd like to.

Thanks
Nicolin

