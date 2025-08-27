Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983DFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHoa-0000jq-OC; Wed, 27 Aug 2025 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urHn4-0005DV-Lr
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:10:29 -0400
Received: from mail-bn7nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2009::623]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urHmx-0006Lz-U8
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:10:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afalVu4Tco8Tic4taZhXEAglOQwFfFx5xd04jJkh5dLrLZgJKQkHkLemgMPAFnv+Z2VcOBo04LsfbL84GpjAHRbdEtaqAwo69U8FWdSp1Q+8xeTB8Ay5QpokzIYKECDhG2ud2b+tiEiXQyFd/5p5geqE8Xx4mnFmLyF2bmt+MdRhEtbwC8a+TkYs7s6UYaWWLIn+UJo1SpYittu+W9TAkPtep9WveZG1NPSKluNVRVwbYR5FGJUVKAQdU5Bu/9aDh1hCGTXeu6CbFMgDPR9HlvgoFqCjmEaXIOuF31StR1/XQU2jUKIPF/qNMzKi9bp5ozhB8R18K/BylPE++2Jj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcZ5U1ArKGmWIR3Aqj3nkiZR+UJSLbFSCJOcWHQ2TS8=;
 b=Q1qAB516qJe7kaDsDrVfbwNibYTvQmlT4Az4Um3CGU71aQS/+ABHVpbE9tQ2qeBP62o6zKp9WuDp2CBIvgNCLNe72fNYfTcnF8vHM3ytrDxR6Czfa2v5hiEnLPEiMcN3vhG6P/Dd4KZVWDJqInqNi3GZSMjyc2EUF9GkSeE7x/0ID3OcZk3Pk9T6nazekjRg6tCTie29WTQ4Eq9aCWY7ifdCafypA8NLtq8WeUYXEZj6+9m4mqnANIpB6gOU4AMbWBtKNgbsrPYD8GcY6dKg619Oq69NgzGnlcIfwQGeSvrVKGpmEvxj/OUDPOr93/TM2aVdre5SsX2ZsnMrxFf9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcZ5U1ArKGmWIR3Aqj3nkiZR+UJSLbFSCJOcWHQ2TS8=;
 b=dw/HXOqGPtnpcn14xK/V+GuCTVvAsMBGbR+ibvJiqw1OlNiXicddZ+J+rgVEwPcRz5O1GTlz1CCWEjI/xGDaSVVpIVQbgSEGoB7k7Iy0X1A9zFkGmsroauHGfZBb2Oit1B6MocclfsFR+3E5TADQMA/PcCsirng4L9So+QunhlzlNC32bc1PYnt9dxUadVeXvBsNbINnVJ6TPalFBrTeICXzRcjG+izCdiG32hb6MhvvFlQQ+UtRuLx1vvDnnGW29+KoNGuxPT4Xf+uaHP0xFPowp4zXpdmDMtCBzKQthz5BKOxAgDnGjm2JFL2+FaC+jbDTr4wu8bSUQtKsxYlymA==
Received: from CH2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:52::12)
 by DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 15:10:05 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com (2603:10b6:610:52::4)
 by CH2PR04CA0002.outlook.office365.com (2603:10b6:610:52::12) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14
 via Frontend Transport; Wed, 27 Aug 2025 15:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 15:10:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 08:09:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 08:09:39 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 08:09:38 -0700
Date: Wed, 27 Aug 2025 08:09:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Message-ID: <aK8fsD+c0LAXzB3y@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
 <fba0b1ce-13de-4c80-9f44-4adc07cc6934@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fba0b1ce-13de-4c80-9f44-4adc07cc6934@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebb1109-7f41-498c-f4ba-08dde57bcd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MrOLZk2fJG69GjZ6jHHBw+eTp+hRhQc0HtEyAOONQdmG1xdIMQZAEFLFsi/w?=
 =?us-ascii?Q?48iB2iirv/nDGepKoxaaXm2YLdD/iYgaYau6xeaFkbi3To+Tdj3oOhQltKP8?=
 =?us-ascii?Q?mWn/ZmqcwfZmy0zjpEQ2aFUOtuAUvGfOVvpeEqdwPYmEBh+o/2Vnzi8eZ3aO?=
 =?us-ascii?Q?OUbzzdOT3vN/HGCcKSKv/vMafpYV4xxMv0WyqqlTAHX7iOe17sexki/wPQHv?=
 =?us-ascii?Q?rJj/5fk6WnxQEzfg7vx1YEVtcOHZS4OJd8Dw1ACfBuAIq2wU+WaWtk9s3DOW?=
 =?us-ascii?Q?drgCAsnKtcycILVT3ywtlzKg0hLyz2Dl+V+C9X5Xk2+AJi4NA1+uwmLgHkD/?=
 =?us-ascii?Q?QJf8giukD09jeoYG2fV8PRoMQe6oPmQldGUwSrSCwohcr+Dfn35ScAMTk9w6?=
 =?us-ascii?Q?ueMsfLW9x8+YmpEz6oB6b0tGucotF6Iq2UVNtBBkCSJvlc0gRqPvke4wRtg6?=
 =?us-ascii?Q?Aa8SNx+LjCnQONLVS+Tz/kI4rXB+nCaJcAyrhOfZU/6x/xPV1QW58T9pcJIp?=
 =?us-ascii?Q?V8QMBfWLdwT/Equ8pSEWJ80jnWV1B0O+Oote9iVQR1QqTANB+ABmzUhBokBe?=
 =?us-ascii?Q?T2oxQ1beVWs0wVS10io2aq5PKBoLMZYPzP0LVkBahvICbBK4pCJyn7OBO7Uw?=
 =?us-ascii?Q?4xgoK5G/dzYPfKBOvAPYH4D4OEgFs/YXq4a3eHhnAds5IvkKR7m/mWMqb2xy?=
 =?us-ascii?Q?NCj/E9tWRj2JacWZQsQdDiL0QnwK3bUPDfH0ne75H2XrKnPY9cKC22O/60lv?=
 =?us-ascii?Q?nVQeK/F0G/0TOVkAVnwnmBMhEb8++6uZKB6laCQQ6xeMZNqnAM4loyCGWxYs?=
 =?us-ascii?Q?l77ERr6Llc46hVAsq1bg54jLuIKkPytsShDhv64uLAuEjRJHWKF7gUVxd+3q?=
 =?us-ascii?Q?sLRB2NJHX0qc7CQEqHI6ciUxQ+2MlCMeSxG1YB73ieWsoEIXm5PF+jKmhjum?=
 =?us-ascii?Q?1yAxvJV+/kpoBcJMh9nvJm4ewPh63pL+BAJD01ypihKeKGo6QPaVZrw2yhvr?=
 =?us-ascii?Q?LC2K/cOlyBEPxtd1RaYvOpY0bXq++yhkz2t2GDjy5snNSdGWm71iLcVy+2Yu?=
 =?us-ascii?Q?FyNP9tHXQh+peRiAp1Pl09MVreUb90jeTlxhEHttR9JwgS4OjEzEQGFO5AZ4?=
 =?us-ascii?Q?pV3vCE634NMniLY2iQuqaBqSitpOW1XTHuzJ+lXKKPzH8g2N9ass21QbcSvB?=
 =?us-ascii?Q?mConWd5PNhLqXgfnFbhEA/K4abc8fBoQxwVFacUf/N6XTzEcpKfgMapIbcnF?=
 =?us-ascii?Q?gdXG2+a0FVY4Z52a97/HpUSbAY5XMVjY9AyuZ/GDUp115U1YX70M7OviNlcs?=
 =?us-ascii?Q?7S5ti/Lsl9o+5dLmeCFOk0yf5zjS4sVsck2Sh1burrEEWDB9Xt35ZCNv4KZ4?=
 =?us-ascii?Q?MDQMPvt2xLlsUjXhKqAXNCRrJYPauco/tJ+n7q5IHh+dQ0SKKfa31XFnYisT?=
 =?us-ascii?Q?bTBHVj/vlQaQ+Pqc8wPGoa397Nj8o7fB0KWk5vmPDLSpmtYQjh6c+WNzNiBW?=
 =?us-ascii?Q?PGITFhBgHeLrK2HGacxWiq/Jf0HvH06oOD5n?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:10:04.7356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebb1109-7f41-498c-f4ba-08dde57bcd8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762
Received-SPF: permerror client-ip=2a01:111:f403:2009::623;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Wed, Aug 27, 2025 at 07:56:38PM +0800, Yi Liu wrote:
> On 2025/8/23 07:55, Nicolin Chen wrote:
> > > +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> > > +        container->bcontainer.bypass_ro = true;
> > 
> > This circled back to checking a vendor specific flag in the core..
> > 
> > Perhaps we could upgrade the get_viommu_cap op and its API:
> > 
> > enum viommu_flags {
> >      VIOMMU_FLAG_HW_NESTED = BIT_ULL(0),
> >      VIOMMU_FLAG_BYPASS_RO = BIT_ULL(1),
> 
> hmmm. I'm not quite on this idea as the two flags have different sources.
> One determined by vIOMMU config, one by the hardware limit. Reporting
> them in one API is strange.

It's fair enough that we want to make such a clear boundary between
a vIOMMU flag and a HW IOMMU flag of the same vendor..

> I think the bypass RO can be determined in
> VFIO just like the patch has done. But it should check if vIOMMU has
> requested nested hwpt and also the reported hw_info::type is
> IOMMU_HW_INFO_TYPE_INTEL_VTD.
> 
> 	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
>             type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
>             vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>             container->bcontainer.bypass_ro = true;
>          }

Then, it feels odd to me that we don't have a clear boundary between
a generic flag and a vendor flag :-/

It's fine if we want to keep all the host-level vendor flags outside
the vIOMMU code, but at least could we please have a generic looking
function outside this iommufd_cdev_autodomains_get() to translate a
vendor flag to a generic looking flag?

We could start with a function that loads the HostIOMMUDeviceCaps (or
just VendorCaps) dealing with vendor types and outputs generic ones:

        host_iommu_flags = host_iommu_decode_vendor_caps(&vendor_caps);

        if (hwpt_flags & IOMMU_HWPT_ALLOC_NEST_PARENT &&
            host_iommu_flags & HOST_IOMMU_FLAG_BYPASS_RO) {
             container->bcontainer.bypass_ro = true;
        }

Over time, it can even grow into a separate file, if there are more
vendor specific requirement.

Nicolin

