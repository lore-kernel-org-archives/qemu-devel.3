Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813A7C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHrWt-0004Vb-Og; Wed, 21 May 2025 18:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uHrWr-0004V6-FQ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:03:13 -0400
Received: from mail-mw2nam04on2047.outbound.protection.outlook.com
 ([40.107.101.47] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uHrWp-0007mh-6C
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga3ap+9ckWhmYj+l+VWQY+YTmClIoT//624IHHJOHIIdl1GonNWSwdQpjV/Z/+tkxtJ0IR3CO2feGcq2547NYI9rl0GEG+1q13ZtXIr7/gTh7OeC1Hg6kJZnKV7+u+JhTI052d9VMU25+mIxDSeHZRRLesuCDMjgXgt2f2kzf0j0OWkbopo6HeLYEBa89XvAJGlRtQ3o0OlxSQJ2aT7Out8poCPJSzJisyhMyQmWLrAgJPD7LIJ63OBYelTKADElviWGSah6AKYYMhWnJoVaNXhclGSGPWc8yqlsqIU+VtFgoz0yLt1lWHuEiga2jfT/2+ZmCD/BlY8LQY6KNBW2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR9nusYACZOzEYIiv2ZfA9Q+SbAuD31oSk+wJ3ikmbA=;
 b=LtQLqkblMi+j1zAo73ym8O5E6MgZ5RThzWg1bvfuyAKfSXsMowWRaH5gHxTRSzDT5pVb/qHAam3mSC3vCOsB/nh7F+wKF5Ps/45M6u7K+cmYL2Rs/TqsQNrSddCNYpjAf8iERfLMh+b+GDEOIlJio2c2cEZmr/2Spq1dBy8bcBt2yU08NR0TjHjpiHwYWb9kw/pniuRgZy56Yxt4/kTTrX5GMx1QK7QczWRFzRrk89A+iu1FW4jYdxCFee4Ue0wSNJ+LPMu44NiRGvWwXFQztDIt2P5O8e4ytHch4Ywkc93HMmpCfgTuKUtfCXodS6FcPgnvOHs94HlGn6zKM/+eSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR9nusYACZOzEYIiv2ZfA9Q+SbAuD31oSk+wJ3ikmbA=;
 b=CcSDa9xLBxYqDm/H85P8xsTwzQ1KGp6AMJkWb5GbUjiTiWY4F84fZU0kSUeVTT/hlsAvKwEuyyldCEBCNLDzG4lSUtY3klDJbddPs2sqofYijGMLaw9buC8yTH+ZSJNIQepl3VZHS3Rkno4AFgHGnT1NjjTiN12jk28UsmpBm64UzcS89fzahrkhyeZKSvaNTr3TRhNKsbI5fnAxvWl22Ak18yIPJmSFeLgqmyQhDL/7wfVMYMD7btmlEoDmVbiv852dRcQr2NghPovAyGW4YzyYKkqcEbprud+DaSBiNpRXR3uS5SvnoUExAwOQ4zB13hxIzlKefprY1ZQDDuAj0g==
Received: from MN2PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:d4::30)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 21:58:01 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::83) by MN2PR04CA0017.outlook.office365.com
 (2603:10b6:208:d4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 21 May 2025 21:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 21:58:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 14:57:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 14:57:44 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 21 May 2025 14:57:43 -0700
Date: Wed, 21 May 2025 14:57:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device info
Message-ID: <aC5MVvwPCFertplB@Asurada-Nvidia>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-6-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521111452.3316354-6-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b4a512-585d-418e-6dc5-08dd98b28e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ayqhm+alWMT+56bKyApjjl7Zs9n8azoHmY3ZyNZ0BBncosZbPZ7oagTNgLyv?=
 =?us-ascii?Q?0mMZUCu6wXtSZ+cgDXyrLJ0XSlmqXd5A7qExNK5DREF0sh0KDUKOl+RYdAVS?=
 =?us-ascii?Q?LET+8k/asILceLuLNe8WsLhIuiftnIOyAcECruTHomWB5x/SIgeAf6ldkkuc?=
 =?us-ascii?Q?R+qrrMGJ1xR8cFm4XMJV3bpzpANBBf1GaA4M0+jUsV3uMP6sINgQJGXt/8Go?=
 =?us-ascii?Q?nCgT++LLFXet3O2C/WRoyICjNoPE2Qo/gq7TG43wg3H9IFFooBwWzOM1c4Yr?=
 =?us-ascii?Q?fHEI073zJAlVgIP2o/jthon7f9dzKPskcQp0jF2aCw535mwJ7e0xmkByDDbU?=
 =?us-ascii?Q?ual9quN8XSXCaD7Vq41GBwwb5nNCY6m8hfDoIPlhU7S2jBTPONzVt3VwXGrc?=
 =?us-ascii?Q?UmgnJGhB3cup20XgOBj330WX3eCH0RUgQEL8SwXiaS0rcETUlkzXDk9D6Ln5?=
 =?us-ascii?Q?cWN9yNr+kAtPX5aZji9NdX1AICq1Eeggt1+qbMfnhcBc0YtR+G2STqpw2LZF?=
 =?us-ascii?Q?Z4WM2RDTkBW9c9LNOlqjwkNSdyJ8P42+DUgpU5bO+YVqxys6zRBgHfBKum68?=
 =?us-ascii?Q?/nb15xn4zgc4qrcPOLPpeBuXv8QkQAEZgYR29WvjlGWBQQoIde6NBfJTOd7a?=
 =?us-ascii?Q?UK6+WxxLBCD3EoZ24U77AaGFvi00z7KklTlzHfR+XQvujkbK27ODBJniYxX+?=
 =?us-ascii?Q?7R5D24iSbHAIabAbftc3QbsQlrV/EkmYGDM/0wLKnAWVVQV5TjvIHsFqvgWI?=
 =?us-ascii?Q?EoWiHk/i21QMj6Ai18tqRn2VhBgceuvos0Cj47RqOwY584/0WLETZdJ2OsgP?=
 =?us-ascii?Q?JIF81isO346gSDxRkuhU5JuNV5z1o2frhneDgBeGKPLIobCb6HWLl78ySaGJ?=
 =?us-ascii?Q?1w5yA8DGxX6lFWnfopSrxXqAzmlmeMLh4iWw2E4FvjUZC/fQu9GqiLRKp21w?=
 =?us-ascii?Q?KCCC7A7HmnGyMWlRbGpZ5oXSHEV6aYgt61yhRmYvWlbaqHAPIO95FqVRK/X1?=
 =?us-ascii?Q?LrO+WiBSBdZSR/SO1HkAuomWhBbf4iObLU17n2sE2I9IvQBlMkv64W7dcTXx?=
 =?us-ascii?Q?lhohKPRaASt/CTgSlq8xA6E8wGHFOk3VEXyuvK/K5i6VLrEkAHX/oSM0Foq6?=
 =?us-ascii?Q?d3OPMbaMGOMqiH9pDgU/zvBwOt427ktJQQKwrvPPVm6TiY+bH8rfNBOQha/R?=
 =?us-ascii?Q?/U0bXTuRyfzrY0r+AQdP9vfvSdsU1x1kq7g30/m62HRi3gVZAuNM5xVG0jrf?=
 =?us-ascii?Q?uaYzKovGoodt4lpEaTifVA04zCyGxD3SM8scSkbWgMm+xUPmo8luSGYIZoYE?=
 =?us-ascii?Q?VpBFXHQw/XF80PuHj4fwaBlgC1pyHDFAovJ63BvDwYSHG5gM3DSpkT4Uit5F?=
 =?us-ascii?Q?b+UfUvhT9kT0LzQ7Y+e0QGfp4JgE0EFPv/zd44NbsPnv5NbIr8NIKVnM9y2s?=
 =?us-ascii?Q?cLWZNSH1m+YVMuzdb6F4K9AsXjxS9KUhajb/tTPYo7uYKPYv8PXy3jHH5/dJ?=
 =?us-ascii?Q?MpAjmp8bPODau2PsICeWo8lyDbzFC3qDjjDM?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:58:01.3726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b4a512-585d-418e-6dc5-08dd98b28e50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
Received-SPF: permerror client-ip=40.107.101.47;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 07:14:35PM +0800, Zhenzhong Duan wrote:
> @@ -852,6 +853,17 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      caps->type = type;
>      caps->hw_caps = hw_caps;
>  
> +    switch (type) {
> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
> +        vendor_caps->vtd.flags = data.vtd.flags;
> +        vendor_caps->vtd.cap_reg = data.vtd.cap_reg;
> +        vendor_caps->vtd.ecap_reg = data.vtd.ecap_reg;
> +        break;
> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
> +    case IOMMU_HW_INFO_TYPE_NONE:

Should this be a part of hiod_iommufd_get_vendor_cap() in backends?

Thanks
Nicolin

