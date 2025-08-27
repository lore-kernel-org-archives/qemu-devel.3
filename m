Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7AACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJTp-00020M-Fv; Wed, 27 Aug 2025 12:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urJTi-0001w3-ID
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:58:32 -0400
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urJTb-0006eM-4M
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:58:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy/tK5pqbykjrFGuF4rLTRnbKsfK18+Hbu2qBTAfCS8Arj3LnPzGQbbTePDKtVVCXDkTLti3VmoiQS6V+qROKp+sk3DRLRKJ7RXwkfoh14hMtK9p+DGiLoirTy50MAQ3o9eb4fzli7+hqONBmJKXz9QwFJ+Y4n5ajk5fHBHH20O4piRCiCv4sg9OvkvWDhYEfg45MlFYQ/TcaCtWD2fabunecB2xrRoDQVQRXEDFYCsXMzkfZedDcLPyLJpfdY8DYKCqFgvWkueXiO3k1GFs9PLQ5bRV5nQeNVV+t5QEYaI+AleRUnu/wGiOqBICP9V3ADmcmSEbUIcGfeHA7p0ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma9P4TqmUJeiIrDyK+/GVs030wpCdEoYDwLIb9a+7TU=;
 b=nBMqxPL/LDVrU+qgWz0hwDKLFE3YILOQfFt/NlJFEWPUo3SzRgupnWMoZJnHvc3ZBN0JCA/EOfTE0K81Cp4rISWRE3TVhUoYZz0XZjyct2C2WaZTk3Depb2G1/gMz8bOii3nc32h4K/oKvRM36ufXBGDY86bIF8IPRHDkJhm3s9UdOnjo25xqdzADAwJVH1XLGU32lJR9TYW3TGo5niHMYOG5jKGBcnEH6YtquFFsOyuuiVzaa6sSW+sPW+TL5YgalXsP0xKFcvIxZh640UMRsk4h2RkZbSokGL5v/fdcbgur2mY2tv8338M3oqRs+KM06XxLaNd2EL/K+MNKFJOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma9P4TqmUJeiIrDyK+/GVs030wpCdEoYDwLIb9a+7TU=;
 b=QcxfUzz8AR3Xp2iwau9SVDGFyhk6Zfaedli2WryCAum9lzZ0elV07/OCowFv8r5v2Ot6Af13DX0uBuAI7KloUCnFfAB/d8pJiH4kYDc4qdxm/f2ci/aak2mlJdCaISAoILmHh/ufQY7oBGO4SihhZE/q4dYZWi4qe7WYROVo3UmncFoO2RIJeWn0fultSd17qDQYNfeyw/2TDmxzGnnJSMRqA2IPQtq/Se/U9CxInDV2rHPfOdyO3rGiOPjJ+xCS9CuhYRMci76AVjvMe+oFIDku0dLoWAdEhPz5uA+IlgFO8JdZkklpwa/sqLDelUHdcpmbzyON7nway371WVE+HA==
Received: from DM6PR21CA0003.namprd21.prod.outlook.com (2603:10b6:5:174::13)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Wed, 27 Aug
 2025 16:58:07 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:174:cafe::10) by DM6PR21CA0003.outlook.office365.com
 (2603:10b6:5:174::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.5 via Frontend Transport; Wed,
 27 Aug 2025 16:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Wed, 27 Aug 2025 16:58:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 09:57:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 09:57:32 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 09:57:31 -0700
Date: Wed, 27 Aug 2025 09:57:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Message-ID: <aK84+rvhEpgJ60Ob@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
 <aK3tAUUn5t61VPyk@Asurada-Nvidia>
 <b5e4d5ef-c7f0-4b3c-aec5-3916755f92ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5e4d5ef-c7f0-4b3c-aec5-3916755f92ef@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3d8f7d-ac4e-4a2b-4543-08dde58ae585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fARIdiFo/vZkHL0inRdhxiwFXV91Am5GnKw8zSkgfCTOhsWb3dyUajgYQ8Eq?=
 =?us-ascii?Q?9HoamPpZSsqJNXwEJAIEZ4eK6DTH7IClOIeEVm+O/wZt2pvb5uFQ26io3La9?=
 =?us-ascii?Q?ypo2JXWyQynxi0wS8HtBDmHgCCWw8RSWYKT3e7iKS2MHOP7vkk2gBR8LNovT?=
 =?us-ascii?Q?RtLexFvbmyo0C9WHr5vOMKhpUB4obdDMJC1wJ5jo4TM9Ug72bFp9+addkOEu?=
 =?us-ascii?Q?fg8fKHkv2yfJCktMgF05qyIFpnNHdxD77a/Iys4hApgJNfH9UGIXIB4XvUs2?=
 =?us-ascii?Q?+NDy2/4WZF5REqD/Wsbtef35e8mCYQBd/Ul4DTja3xL8QOrbbXR9NmS48vEf?=
 =?us-ascii?Q?Fws0Vvle0wR9eSgCCPYguO0zQNW9HG/MptpMOmDUggR48h3JunjE10arETnU?=
 =?us-ascii?Q?BfrsrbFTXSvFkYcLkz6dKczv+j3XeSc56ITEkWcV9EgfU7ATdf1tBxoBOgqG?=
 =?us-ascii?Q?sCiWoVP/+TmfbT+km7dqx3bp4c4/8SaaFVNpkPQzOy4fMG3gN1LziF8GmDw0?=
 =?us-ascii?Q?msuX5diAlDG7/2RcIfsB/hsxbj0MDvee4VGOCQvLVGX5BUBzQjR0RO+mG7SS?=
 =?us-ascii?Q?PZjzmgPSwe70KyRymWjEEn/3d2l/0bUEiQZPpqXatXWXRFEuhrpdV8tglpJd?=
 =?us-ascii?Q?K/0eoIxkIpPmU56xvK+IlvmOvWrx5Ki2El1WqDgB5jnMFbSVijJps6y9VrEM?=
 =?us-ascii?Q?LebiZelT9KlL5YobqyDYcs32u6VCKnrYnYPgP7b0cqLNGY1LKbuNrecL/c5q?=
 =?us-ascii?Q?7glo/f5THN4xXidscIXk44VBTRblIlu3f0l3CJrSwGnYUtnrJhzoabUQXSaI?=
 =?us-ascii?Q?2raBTGCbm5YdfOgIA/CKvanuYIxBoWEFOgQEjdFgp1T6e/Tf1KQ0KeBQ6C92?=
 =?us-ascii?Q?GOLn5NE9tc2K11iHozvTP53Ev6hz2Y7vw78ZI8mDZyBFV2juV98zhsFQunCn?=
 =?us-ascii?Q?1sM3U8Wu+lrGK9Aw/qrK+tBwGIUnSjwG7opitfpbEO64WM9v8MI8Y1ZjlqfG?=
 =?us-ascii?Q?Z4ji/ddKhLcnx7B9urayAjm0aQ3SL8SYgKAk7VFkRrOIXK+f9t/w0+YugaaP?=
 =?us-ascii?Q?iy2nBjF9RjaLIlWJgz75LyJCReAuzqMU/5BgtT9VgAtsV3XbROWQalnjtsz3?=
 =?us-ascii?Q?ksxD8uIt6kcOWxkgxeYG7G/lvIH8ggs9de+oxlJ/Zw12LZOx1O8O7LzTF+/+?=
 =?us-ascii?Q?n2o0KKcpvxzDyEthQuAfVtmfKJmN4ohB2j27YZyEFMrznmu7H4OoJUDvM8/t?=
 =?us-ascii?Q?M892o6/tDd2DewDJjERZ1ZyxorMiaZwBwaffVUY1ArEgTT/3AfNyqnkSu5Tq?=
 =?us-ascii?Q?3bfP3ejpIc4KhPPdPSOP7g6rHVEUyoefh196k5y46VUs0RCapAh2w3NYKUkm?=
 =?us-ascii?Q?/SvSsPoRtP6GOSbCYdt2zpMlNlcfeAgRGfOx/oKde4g3rWAZDRNU7ZQgl2zg?=
 =?us-ascii?Q?H7A5Ov0kymg6XyH5B/VjQstChb0gWI5WOvTyVUUPOoAttH/z7wlUZpmbbujC?=
 =?us-ascii?Q?9B9N+ly3DOFSmYs6zwrD59PhgzVcFvf81Jhg?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:58:07.2140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3d8f7d-ac4e-4a2b-4543-08dde58ae585
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
Received-SPF: permerror client-ip=2a01:111:f403:200a::61a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Eric,

On Wed, Aug 27, 2025 at 06:36:09PM +0200, Eric Auger wrote:
> On 8/26/25 7:21 PM, Nicolin Chen wrote:
> > QEMU log:
> > smmuv3_accel_set_iommu_device: bus=0, devfn=0, sid=0
> >
> > The set_iommu_device op is invoked by vfio_pci_realize() where the
> > the BDF number won't get ready for this kind of PCI setup until a
> > later stage that I can't identify yet..
> >
> > Given that VTD wants the BDF number too, I start to wonder whether
> > the set_iommu_device op is invoked in the right place or not..
> >
> > Maybe VTD works because it saves the bus pointer v.s. bus_num(=0),
> > so its bus_num would be updated when later code calculates the BDF
> > number using the saved bus pointer (in the key). Nonetheless, the
> > saved devfn (in the key) is 0, which wouldn't be updated later as
> > the bus_num. So, if the device is supposed to have a devfn (!=0),
> > this wouldn't work?
> 
> in hw/arm/smmu-common.c, along with smmu_find_smmu_pcibus() there is a
> comment about late computation of bus number. This looks like a safe
> place where the bus_num is known.

Yea, sid is a parameter of that smmu_find_smmu_pcibus() function,
so bus_num must be known.

What I want here is to allocate a vDEVICE (needs vSID), as early
as possible. This will be potentially a requirement for CCA.

Thanks
Nicolin

