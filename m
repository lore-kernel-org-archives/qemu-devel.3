Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F60ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 16:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4MQp-00029o-Qf; Thu, 02 Oct 2025 12:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v4MQk-00029A-Mk; Thu, 02 Oct 2025 12:45:24 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v4MQU-0003PF-TW; Thu, 02 Oct 2025 12:45:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcJf6IiJcFytt4xkbmRiOiulsdbnh773Gsvny9FbDJAX18FbdfS9YdOxU/JSm4sT+rvyYs1BtPPinmBtfZdGXG5IlmiNTptN39RvRPf3oYfes/b36tZfRtAGOhzDJg7kQ8MEU7Kzn7+C0/+KyUEx8ibxwABtSHtSom+Tl0RDTrlrEvDY4UlK19LOjQEHNAUiI87af5yv5eewyG5BNZhZ+tlcD6f9n89BSQHm5JMabj18aEPbqG+BawFZlGgtN7OEj2cLNmi8z1e3jX2/U0qMw3V7KfAdgC2Uhc8nyX9BokIAza1PZTW13HQgOE7b/qq6YpC5RTVSIkxOZkUjLTcC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqdtbYupu9tJ0J7QGxBl/9o/wIZf9Ezu5y406Ka1I4o=;
 b=NGQIk2cCnWKpGRq1/v0yaOtWtx4DLUZ5pp6ni7sQBoz/wYHXteuieFBAaAXcib6RDw3/k6kOT67Ehxc3Zqkc1K/YwL25shdbElnZKG9EvTdmmjxprVdq7pWEW0snrix64F1F18x+8U278AcmT+ZbYcsNSqfWY5BHa1W9O1hi+THzTCdS4saTl7TQ3GnFVd7Q1Gw8CuvJLH5yQVqEfMin+SCWWxn1RRkIpVAtKJNornQquZxcU25hktJQncpp6LqcjAZKTfAuTfp1rOp/KE7itCO2dohqWlKPHsW13grB0Sy/vg1UDIQkEZRL6pcL1BLJ6myaWJwG0df8cHtN64Se0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqdtbYupu9tJ0J7QGxBl/9o/wIZf9Ezu5y406Ka1I4o=;
 b=hNc5Y9uRICoR5YuZHglqWswd8uFaAnssrAu8ZVl1ENGJc4me9mTi5G4NrNSjv6Ho5De0+WruXO+ABclRDzQxTYnI5QMEC5LuPwV2YrxrrW2X5SCKIZdb8RMKegVbF09cajFo3hWCIghztNzwxiDwOrlparKcmmgZpGeAP2CiI3+TKHyDyvYMwkNsff7XCyHjkj8aFFUBN85TOoOrL8g2q7bqcH+3dqxeOxzeNe2dNG/znEK97tJxOqfLPZ8tPXd4MrvSVIafO5ipUnOCYFZlZr+fknEbuCfPEmtmQ677/fm3qB7dY6/Abqj9s4ywZD1LMjivOnIEbenKkqUf/9FfBA==
Received: from MN2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:208:23b::20)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 16:44:37 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::d6) by MN2PR11CA0015.outlook.office365.com
 (2603:10b6:208:23b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Thu,
 2 Oct 2025 16:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 16:44:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 09:44:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 09:44:21 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 09:44:20 -0700
Date: Thu, 2 Oct 2025 09:44:18 -0700
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
Subject: Re: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Message-ID: <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-9-skolothumtho@nvidia.com>
 <7167d287-f0d0-4bb8-8750-e38e9e31df10@redhat.com>
 <CH3PR12MB7548C5CB7B9BE18AAE5492BEABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548C5CB7B9BE18AAE5492BEABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 6692989f-7cd2-42a0-708c-08de01d2f92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFRpRXhnOS9BQmY4ei85QkFCVG9tMERsb1lrcEc3RnRpU1MwTEErVzgvT1o5?=
 =?utf-8?B?ck1NeGZVQ0NweFJRVDlnUDNsTjgvWkZzSHdQQXdwMlZlOHZkVGU5K1RKNFI2?=
 =?utf-8?B?T2tVVVBYV1lZOFgyYnhiaFhIa0ljclh4Zkx1T0w2eUdJZnhhaGNoUTBueUlB?=
 =?utf-8?B?d041eE1RZVFaeXB6L1FwRS9CaFhQQ1U4MTk4OGRmVlhWdkdnVFZKVEVvZDc4?=
 =?utf-8?B?ZGVsakhXSFF0RlU0Uk82NFYwR3BEU3IvNVJSTEtJcmJrRVZyTlJMOWN3bjRy?=
 =?utf-8?B?OURjaTY1YitHMWtqak95dGExKzFXQkYycUNqMXNmeFNJaVhucHVqN0diaXZa?=
 =?utf-8?B?UVdPQmdVbkM5YkVLMEw3ZERyR21FUnRscW9PZHFPMlpzekx2dWpLU2o2dDFl?=
 =?utf-8?B?bnpYajU0L0lJMlFzekR5RmxFWTRwdnhUQnF5b3REQnBnYTFsUDU5WUtZalpW?=
 =?utf-8?B?YzRYUjFVMDlNME96eTRBV3VNTVR5WTZEM2ZjTXVQOUMveTBEOXZza3J0RmJR?=
 =?utf-8?B?NHpVMzc5MHdNTEJjVHZnRTRUcG1KQzRVMW5YcUFVdzB4UkdFVG1uVTNGVnZo?=
 =?utf-8?B?a2VhVmVFY1A3Y0RnMG52WUJXYmxQbS9aSktpZlpiRDBDeEhiOVhnNHJYQXlV?=
 =?utf-8?B?WFJYNW5zZm5EdCtrUEJrakkxZWVXQTRmVWZ2OXR1dHNBUEFWMXVmdHhNbXZh?=
 =?utf-8?B?bXV1d0ROaldiaURNdnBYR0JRTmphQy9oNXI0eG92RDZ4SnJnanRHTEhuSDJ4?=
 =?utf-8?B?UGZEb2phREw4YnQxUUsvM1ZJQm9zd1RJcHJneDhHenJ2UXBkdnVoTUtEeFM5?=
 =?utf-8?B?emtVYlRTZk8reFZxblo4eXZvUlYxaktoYXRDVEM5alZpSjRKQ05yMjQrSDIv?=
 =?utf-8?B?NThIcDVQLzkxU1BtQldEQnRialIvV2tvaFJGSUxOKzNxQUFQaGhLN1Q5d1pm?=
 =?utf-8?B?dlV4SitidU1NWVlQQmpZcFcyR0lrYWhWT3NJT3BvbzNGaVpYVjRnVFlvTWs4?=
 =?utf-8?B?NTgrbHpzQWkvZG5RODIxcG00T0FJMnNCdDRBL3NYRnR6cTZLc1dBL1p1K1dS?=
 =?utf-8?B?dG9OUklPeVA1cHpaS084NE1JOW5Kczh4YzFVMG90aHhYTUJUMUlvSkdBSTB0?=
 =?utf-8?B?QjlyN1ZKUWNpZWc3ajhnNjNHdzZzeTN2endpRHAzKzN0bFFlOVgzLytSNXlm?=
 =?utf-8?B?QTZPVDVGWjdYQzMvV2lzWWx6STlLbnhhNmNVYllYOVJvbVBBWTdKMTNTQmxJ?=
 =?utf-8?B?MHFPVmJrTmN6Ti9IK0NGbUl6dGVjUjJXY2RnTEVnN2xQY0pzYVhmaWQvd3dP?=
 =?utf-8?B?TFhqN0M2eXJ6aXVYT21KNjVVWng5RjJtZXFqQlpaTG8vbWtSdW53UDdmZG1T?=
 =?utf-8?B?VEpLT2pvZ0xZT3RvcWdJY3hEcEZhOFZqU0pjMlU0U2ZsYTUyWWpsc1VwbmI5?=
 =?utf-8?B?S0FnNmxraXQ0YTBaUVpWMW1uU2R0VWRPS2FYakdvR2lFa1pWVDVDK1BkUGps?=
 =?utf-8?B?SzJ5N1Qzems3UlhsWlJtaWVQTzZPdVFkUXZHeWJ3QVlrMlRobEF4WWhCbHFG?=
 =?utf-8?B?MU5TeXNNYUxMNlN2YUI0Ykh5cVBPMFVwN2xJUDhaS2FwREQySi8xTUpmcEsz?=
 =?utf-8?B?NGM2ZTlpOXZqZmRKamZsNVhrbHhNcmw5WmMyelVubGxNY200elFjNE5yREJp?=
 =?utf-8?B?L0JrNElWZTNBck1OcHQ2c0g3R0VSM0gyNGZ4UUZod0NyWnV1UkgrSFBLRkVN?=
 =?utf-8?B?TXhPQWxGNmtJQlN3eW1kNE1kbWlXeExoUkl1TklCS2N3eDNxNE5pbktUejla?=
 =?utf-8?B?bEdQNnVaY3pnYWNXN1I0QmgwYjkzWDkzRmo4TzJod2xsaVM2cTdXck9VMXhw?=
 =?utf-8?B?Q0FqZEkxZDYxa1lOdmkwanBvZFhYa0tvTlRjN3FEM1VSR1VvZVV3K3pMdFhn?=
 =?utf-8?B?bXkvYXU1N0dOS1VnZzl5RlZzZmdqR3ROMUpyeFdPQy9lZGc3UzVKU1BjNzQv?=
 =?utf-8?B?UTdqTytyU05pdjFZQ21vNXBqR2V1WktYKy9HeEU4cFRVZkFjUm1nN1gvVTFm?=
 =?utf-8?B?NmVoci92RHh0c3RySTdteGRWZnJ4UFFDOE14VWUvNWdmcWNFWHlsblRDNW9J?=
 =?utf-8?Q?K2jg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 16:44:36.6396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6692989f-7cd2-42a0-708c-08de01d2f92a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
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

On Thu, Oct 02, 2025 at 04:34:17AM -0700, Shameer Kolothum wrote:
> > > Implement a set_iommu_device callback:
> > >  -If found an existing viommu reuse that.
> > I think you need to document why you need a vIOMMU object.
> > >  -Else,
> > >     Allocate a vIOMMU with the nested parent S2 hwpt allocated by VFIO.
> > >     Though, iommufd’s vIOMMU model supports nested translation by
> > >     encapsulating a S2 nesting parent HWPT, devices cannot attach to this
> > >     parent HWPT directly. So two proxy nested HWPTs (bypass and abort) are
> > >     allocated to handle device attachments.
> > 
> > "devices cannot attach to this parent HWPT directly".  Why? It is not clear to
> > me what those hwpt are used for compared to the original one. Why are they
> > mandated? To me this deserves some additional explanations. If they are s2
> > ones, I would use an s2 prefix too.
> 
> Ok. This needs some rephrasing.
> 
> The idea is, we cannot yet attach a domain to the SMMUv3 for this device yet.
> We need a vDEVICE object (which will link vSID to pSID) for attach. Please see
> Patch #10.
> 
> Here we just allocate two domains(bypass or abort) for later attach based on
> Guest request.
> 
> These are not S2 only HWPT per se. They are of type IOMMU_DOMAIN_NESTED.
> 
> From kernel doc:
> 
> #define __IOMMU_DOMAIN_NESTED   (1U << 6)  /* User-managed address space nested
>                                               on a stage-2 translation        */

There are a couple of things going on here:
1) We should not attach directly to the S2 HWPT that eventually
   will be shared across vSMMU instances. In other word, an S2
   HWPT will not be attachable for lacking of its tie to an SMMU
   instance and not having a VMID at all. Instead, each vIOMMU
   object allocated using this S2 HWPT will hold the VMID.

2) A device cannot attach to a vIOMMU directly but has to attach
   through a proxy nested HWPT (IOMMU_DOMAIN_NESTED). To attach
   to an IOMMU_DOMAIN_NESTED, a vDEVICE must be allocated with a
   given vSID.

This might sound a bit complicated but I think it makes sense from
a VM perspective, as a device that's behind a vSMMU should have a
guest-level SID and its corresponding STE: if the device is working
in the S2-only mode (physically), there must be a guest-level STE
configuring to the S1-BYPASS mode, where the "bypass" proxy HWPT
will be picked for attachment.

So, for rephrasing, I think it would nicer to say something like:

"
A device that is put behind a vSMMU instance must have a vSID and its
corresponding vSTEs (bypass/abort/translate). Pre-allocate the bypass
and abort vSTEs as two proxy nested HWPTs for the device to attach to
a vIOMMU.

Note that the core-managed nesting parent HWPT should not be attached
directly when using the iommufd's vIOMMU model. This is also because
we want that nesting parent HWPT to be reused eventually across vSMMU
instances in the same VM.
"

Nicolin

