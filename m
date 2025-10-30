Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134D1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEND2-0007dD-4q; Thu, 30 Oct 2025 03:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vENCu-0007cR-Qo; Thu, 30 Oct 2025 03:36:30 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vENCm-00064P-1w; Thu, 30 Oct 2025 03:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNU6ereVBjTacN+ltn3eELcxtuYkJ2l0FGmBTMTD913oKggDdbQpr/fkxpSBe0Lmpu+mZg9OxE8/mRot5HaZkvVJQ+4tixta3TWoBr6Pbm1e/YgnH19P0s8T8PJoK9HnOamb0VeTpJtD50exv/ULzPknl4SJYefMRO6YEDIvdRbWMIWWT3HGBvfzzdmFYCw+wHAdbrdtM2JFB5Zm7DO75igwIi+y4PHn9w+HL5EAmbU2VYz7a7rt0c6JQ9wQg0TN84LDoHiLM3oqp3y8EcIcm1oOqPJQOpyyDdBEwJsKuGIs3509X40lkPHNo6EnFte5QAl9rkMHdbbAqzti7Z/32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lorpsg5yBWp+3Da1zF1i9vrUGZw1tEes/+u/rwNUeE=;
 b=cLE3SHaX22qsWTA+EBy4wtdnKjtm1kWEoYwxiQAOjTgDwQLH3nt4buVQtzz5Ljlt5QfYMWJZdAY7W/V2vYbORrcPqND71Vjc2rOAxhx2bhAby+fe4ZaNpU/C7FVSgIyGYC907Da0CLCTaB0QM32bFP4cGtl21gPvwWN2aLCd10/ffaLQc4p4MNvMck7Lqq4FnTOLpJ3N2hy89fQkoProyCa6G35GN87axOokCSjqKKU6oEQOQBavd3e1RmuizWmE7fszfL5FRCkzcyWETVFd3MCIbnH5dSy0zHDhUVQvK04CP/snKMC590HOhT6dwSWhYxQ+tUYiYU85BjmOg8hLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lorpsg5yBWp+3Da1zF1i9vrUGZw1tEes/+u/rwNUeE=;
 b=gvIRHkTIXUHQS3G+I+bpbGOHQLNTVVfjrq/xeb2Nkc7K8/0nPYbXm8TckY1alyuWkNeVFzcJDIrRmu+LBFpkfV0jEbUf4rCqZUfc2JVxyLSUw9ATY5eGte7NVJAP6oU+7AlRyj/e5XskWdYgsxN1NX4CA5WnRbqoTn5f8r7OLVvwgORufN0Rxjz4IuGvsPDvgTVbS0ScOWMD7n2ovlHF9ljIs6Uh/wLncvgGXal8o75A/fSU6WjA/M/3rDgKlJXu6YnPYzoGZPPgh/uYCHUn5PeBcwi874kpPcLOHOeK8xcqCjP86gK3NTear1zRaZh7UM9Ir7wDyzQJnzeg6DO2GA==
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 07:36:01 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::37) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 07:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 07:36:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:35:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:35:46 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:35:45 -0700
Date: Thu, 30 Oct 2025 00:35:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
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
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Message-ID: <aQMVT5BN6kLq6+cJ@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
 <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
 <CH3PR12MB75480062975BA40AD454742CABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQGXibWAiMpXAQlF@Asurada-Nvidia>
 <CH3PR12MB7548FB14A0D0F08688DE9CCDABFAA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQL3gNT+1Ehgi1pn@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQL3gNT+1Ehgi1pn@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 82211c0b-a959-4a2d-703d-08de1786f9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9MC+paFQ2m/VmzZWurvtxuOf2agKm4qkEOZnd3HdS8imCm9NWatwmn8yy4A5?=
 =?us-ascii?Q?zvpjO/eBRp57vvU3NypuZRwv6Fw2WxJdxwLt+QJI4fyyCe657riMpF6aYFcP?=
 =?us-ascii?Q?2qoG4B9/0cS4xuqAmj93rN9dQjgn5RpnwQUrVEv9zYTysHzvcgS55O0N722n?=
 =?us-ascii?Q?AUtxkEqj9tf5rbXlhm5tHID6iGTBFyCrCkj4SrXWFlYTzf3lmJrRavxOiYM1?=
 =?us-ascii?Q?2qMIrhNNhhmQ8R4jJOprZKDEswTJxwtdv7/GHQzMmDsGh674hk+o2he3WoVv?=
 =?us-ascii?Q?Po1TEvpIv5fvlfEL5d9SGfPIYnbbXOLBipyCXSiOdp/hrMGdn5/P1TNfmaV4?=
 =?us-ascii?Q?mWfPl09opLg71QelddcDOrerXlThkSaNt1x4U97scaSuYPitHx8Mj4KuCfvR?=
 =?us-ascii?Q?7QzK9vhOnwPE0MfH4xPxJCLeQU4plCswIMaN2MTrjwSOrzB//GVlJP9X8fNs?=
 =?us-ascii?Q?bGrZe9OfxDQk1KOMAwqCvb6Q2o//pv3aYf9cV9usULHZD7TF9FO8hGE5UQPC?=
 =?us-ascii?Q?PhBGjji/w5jvQ3q532RXG1pBTs5yd4/k3Bt3dr6EDtqcAQqs4xNJUA4xaAwf?=
 =?us-ascii?Q?Bnq1vouiGJLuuMUwu4AhhaMUtCJXrPPDVygruY/Zv3+91qH7LSex9SoebHep?=
 =?us-ascii?Q?LYdRNNlh1sQRm1K7S9xOBRfAlf7fykBO5QWFvbmmpZn/saFj4RLTno5x+UfM?=
 =?us-ascii?Q?rnIBtdDd1jBYwxOi7n2clVId8mz1OHrddSTjSEMz4L60YDG+yW3FjR4UKfEj?=
 =?us-ascii?Q?ib0dVGZXG7HSUoCVXxF/DXAfWo8ZJAwnH2AP8zSld5S4QO2YSHKfr4yGnoMR?=
 =?us-ascii?Q?66Rnuws3ELddVpiQLex3JUguvZWTi3EfWEiCqbcJvY0kVfVhgYWkqBE3ksqO?=
 =?us-ascii?Q?lZAEJmbDjjq8E2iVntt6k8ltSsEt8jegIsrulWbGbKS7EzGEhA/qgv6HmHSO?=
 =?us-ascii?Q?oSu8mZBkulBs0uNoxDLgT1q/iZFAnO9yQ7gvTfdaj/6KSjmJmxXkDopsFzwL?=
 =?us-ascii?Q?13ewqQ5J7SMA0NkRkD3buAs/Xrr0fIqugqo1E1t6ayVeLXJFPHHoqw89YzeD?=
 =?us-ascii?Q?lknZCz+1Z+sgnh3IiXNTDWeLlPXxfxqaIyxHg1cQMViEQwxtdH3xN2qLIb4L?=
 =?us-ascii?Q?bkcvxCuFuBZu5SKG1PgeuvkqZ0wIOWgCCjjYxjekWfs3FPHDdQjffjgrkC9T?=
 =?us-ascii?Q?8o06EzKSsXoT5niBgy++3Oubkf/+/DFibwqMYbeA6/Eh6Dz+0UcRM3q1EDeL?=
 =?us-ascii?Q?IDOAzeS1UrZ+8an6A9Oa/psynLntafpajqqPblaMsM/jnPZRzKzEG6THtwyp?=
 =?us-ascii?Q?2b0VqID/us2CQFaokJwZHq5kwUCGl7K0cYyVMoNUXXcigCLUbWmOSDkYW+Lg?=
 =?us-ascii?Q?sXDMIRMsUh77i/EL9DZa40Klpsu9tEQ/Ge0wiq1CRWThw/eePFcfEb9g+3nw?=
 =?us-ascii?Q?K4zYPYSmGR3QzT2Fz8nYqQLi3wZwFEr2GaBXp2myQLcvW5Y7cH2XSFDfViZH?=
 =?us-ascii?Q?Mz7X/Ecfm7RkTz7jBWs1LHTwYYSblBu3dzOmxK/6ooODOkGdGHovr27b7jxY?=
 =?us-ascii?Q?n7BXKt+BY8sQV5L9QaQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:36:01.1323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82211c0b-a959-4a2d-703d-08de1786f9a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

On Wed, Oct 29, 2025 at 10:28:35PM -0700, Nicolin Chen wrote:
> On Wed, Oct 29, 2025 at 11:19:59AM -0700, Shameer Kolothum wrote:
> > > According to SMMU spec 6.3 GBPA register's Additional information:
> > >  - If SMMU_IDR1.ATTR_TYPES_OVR == 0, MTCFG, SHCFG, ALLOCCFG are
> > >    effectively fixed as Use incoming and it is IMPLEMENTATION
> > >    SPECIFIC whether these fields read as zero or a previously
> > >    written value. In this case, MemAttr reads as UNKNOWN.
> > >  - If SMMU_IDR1.ATTR_PERMS_OVR == 0, INSTCFG and PRIVCFG are
> > >    effectively fixed as Use incoming and it is IMPLEMENTATION
> > >    SPECIFIC whether these fields read as zero or a previously
> > >    written value.
> > > 
> > > On the other hand, QEMU seems to set both OVR fields to 0, so all
> > > those "other attributes" wouldn't be necessarily forwarded to the
> > > kernel?
> > 
> > OK. Based on the QEMU OVR value, GBPA now resets to 0x1000, meaning
> > SHCFG = 0b01 (Use incoming). However, in the current vSTE bypass/abort
> > cases, SHCFG is set to 0b00 (Non-shareable).
> 
> Ah, no, my bad. SHCFG will need to be forwarded, if the hw_info
> call reports that host SMMU has SMMU_IDR1.ATTR_TYPES_OVR == 1.
> 
> So, the SHCFG=incoming has been the default case, but to support
> a non-incoming configuration, kernel needs to allow SHCFG in the
> vSTE.
> 
> > However, I think the SHCFG will be overridden by S2FWB.
> 
> I don't think S2FWB affects SHCFG. SHCFG has been set by kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c?h=v6.18-rc3#n1681

Hmm, the table "13.5 Summary of attribute/permission configuration
fields" in SMMU spec doesn't seem to show the complete picture..

I found the pseudo code in ARMv8 spec telling the details:

shared/translation/attrs/S2AttrDecode
// S2AttrDecode()
// ==============
// Converts the Stage 2 attribute fields into orthogonal attributes and hints
MemoryAttributes S2AttrDecode(bits(2) SH, bits(4) attr, AccType acctype)
	MemoryAttributes memattrs;
	apply_force_writeback = HaveStage2MemAttrControl() && HCR_EL2.FWB == '1';
	// Device memory
	if (apply_force_writeback && attr<2> == '0') || attr<3:2> == '00' then
		memattrs.memtype = MemType_Device;
		case attr<1:0> of
			when '00' memattrs.device = DeviceType_nGnRnE;
			when '01' memattrs.device = DeviceType_nGnRE;
			when '10' memattrs.device = DeviceType_nGRE;
			when '11' memattrs.device = DeviceType_GRE;
	// Normal memory
	elsif apply_force_writeback then
		if attr<2> == '1' then
			memattrs.memtype = MemType_Normal;
			memattrs.inner.attrs = attr<1:0>;
			memattrs.outer.attrs = attr<1:0>;
			memattrs.shareable = SH<1> == '1';
			memattrs.outershareable = SH == '10';
	elsif attr<1:0> != '00' then
		memattrs.memtype = MemType_Normal;
		memattrs.outer = S2ConvertAttrsHints(attr<3:2>, acctype);
		memattrs.inner = S2ConvertAttrsHints(attr<1:0>, acctype);
		memattrs.shareable = SH<1> == '1';
		memattrs.outershareable = SH == '10';
	else
		memattrs = MemoryAttributes UNKNOWN; // Reserved
return MemAttrDefaults(memattrs);

So, it seems that you are right. SHCFG will be overridden by S2FWB.

However, we have CPU like Grace that doesn't have S2FWB..

Nicolin

