Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CDFEE36AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqaQV-0000qH-Tz; Thu, 12 Feb 2026 12:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqaQ4-0000lw-PU; Thu, 12 Feb 2026 12:24:01 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqaQ2-00042d-12; Thu, 12 Feb 2026 12:24:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb6follFAnu1oMsQEj97rZXBMrWlOtQFOdWfFZVCVtLZnB9awB6d5Q8iFSntw/yuF8gLF9R4aamEO/ZF5TKiVmXJCnlay2Ga9KPGjbqY4hGdzjd48J/hjO0diB87ELMw25xsAmudAJ7oK0ym5TpRajlryfqp+xMmw0B123xlTDo8GS8F/3Ov23TJJUGJbsqtQ4uxJqhey2CNtpujA9/4+ZGNJcaJBHcQu6cNUpGMXxuVO2Wap5iG5Ojay+ulhWHNHRt2tIQIOwH5UwKY53MBFyWvIfGt8DjUerzjL0bEQKr/dUA1Je0F4DUEPmVFcbgfsQDAWx0aO/elcgAEsl8qXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67BBM20Sse6xclU/B9033k/NWrF8c6XrJpKSQkZTx6U=;
 b=s/oaLdPA9IMk4jcIvm+rOmDrSGg+02UJPcuapxZYYm3Fd8nspBhYNSFtDZPvQRjK+TI36iUyKyqaAparaf5QoCCIf7tpt8WXSUGcIxNZXc+qi0jIeJm5+OtIlCoeENR8VbEDOACU/YfK7iBfXuZoEJzBHoLXLrow9XRYzRPr8blbPvQ0ixOMRQeatWChha024yjjonlOpL98oNVmULAIwQ3cMEvcoNEYdpXM6hcTnWSL0mCEurZCw4gEG9E+K34LgHOKW3aYnwdY/PRNRcVTc35mMjI1/JsBlkMqdK3HIvQfbu4zs3VwJ8mjxulzUf7tLiXXxIk84ui0B7wR5KmAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67BBM20Sse6xclU/B9033k/NWrF8c6XrJpKSQkZTx6U=;
 b=bMDO9mFrgCBTRYfXVgyPfqKc4AWueAqAw+dIP21nP7rDOTzMmLsssXE1xE9tKesMcnF8vlH6YQzR+KYqxcHqgWSgQq+C0ofToYZOvSxraDRd4fW2+l1d6rWQ1Qq1d9TqR9CUgLzk6Au22rZdwiL7dQgV8ig1iCMkj3/w6mXeNHf5/AFAa8fRrns2uTH99EA6HXwn9gpM9VxJtEFlLbCvr8BqSE2ggsjjwkRTu4S6ID73WsfZzbOc/nqcdfk8EOm6jz+62/bqmIRqdGmeBw41M9+Ky1OWtchwgl2tLlYN3kYw25ixTD34xy7jWl+kB4uRLMs5a3fJhBhrb3t/gDh0PQ==
Received: from SA1PR02CA0019.namprd02.prod.outlook.com (2603:10b6:806:2cf::12)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 17:23:48 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::42) by SA1PR02CA0019.outlook.office365.com
 (2603:10b6:806:2cf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.12 via Frontend Transport; Thu,
 12 Feb 2026 17:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 17:23:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 09:23:30 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 09:23:29 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 09:23:28 -0800
Date: Thu, 12 Feb 2026 09:23:27 -0800
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Message-ID: <aY4Mj5GvO8X+tO51@Asurada-Nvidia>
References: <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
 <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
 <CH3PR12MB7548A87A5BC62C6D90501947AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <ef13c99e-29b3-47cf-a090-811294e723e0@redhat.com>
 <CH3PR12MB75481019FE5FEB62BCE96D58AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7af8156e-4874-4cab-b71a-c39c56aa59c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7af8156e-4874-4cab-b71a-c39c56aa59c0@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: c9436ab4-de70-47ee-89cf-08de6a5b7b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?R/VqzchlwUOOlaDv5jIMeT4p2Jo+xdZyLg3D4q3f2Uh9wuTfbPMKrvWt24?=
 =?iso-8859-1?Q?j9JFG4mIq8MLubFKvKsL4i1k8P4PcGnBP0HCyvrkpfGUHB5AzPtbIQj/Zm?=
 =?iso-8859-1?Q?+vKZX8i4ClumI0irt+hsq33IqtaxdnIPsGZKxJ/mUN3RXUIDOA01CKkFEf?=
 =?iso-8859-1?Q?rYYTg77ufi14c2xrLrqRj9MhT2ffhSP24eJBCIQelfXmHeicNlxZqzxqyy?=
 =?iso-8859-1?Q?9BeWiuwsocf2+zNdFaKMOgAHxBdTtxz5PYczAuuD5ArjD7fEUx2pl1+9IJ?=
 =?iso-8859-1?Q?gEzixdv+FqL3rXqZ4tlzyd4NazrndACsKPCNqtEPfbrjqAdUoNr93nJx+W?=
 =?iso-8859-1?Q?k1CN60j6YJBT4X0IhRJX6UWMmWgcTpWrwmEqKzTFY6EzDD9H8e5dYixUHX?=
 =?iso-8859-1?Q?ki+iyRBt4ChuEEpfPxPW5C1Fmj0Mw9tdQ376CXQnS7zmeLLG3hzf+F9t9N?=
 =?iso-8859-1?Q?R1E4/TajmVxDuU1eUkicfp1mooFrn+dkFPO1iABj7kylIU4KrmJW/mQCe5?=
 =?iso-8859-1?Q?srn7RFgawTogz7r3WmtQ7vapsY4c9KXM/qzhuIt/08sJdJWr83Imy00R7z?=
 =?iso-8859-1?Q?r+c0MxTXJroOHTLng8+R/TpXW/DzFqQAG0heX0DGkp3+I2NrYhX/pA3dGW?=
 =?iso-8859-1?Q?Ek2BEj2+juF+8K7LoiRkjoNiEYuCCTFPs+gIS98mL2y/bVoOjn0wrm/QIM?=
 =?iso-8859-1?Q?kG72VT3491RJXDUgFLOV4imrAKroyZJwYi77ZtAlc5WJZ+EbjzpB6OB8ox?=
 =?iso-8859-1?Q?okwza2T0klPjdmtqO+PI0EuX+gLqTiIEz0E7u7KUA1kf8H92/kN+t/tNsS?=
 =?iso-8859-1?Q?2tdnIidtr/9PhxaoaBhogi5I669mfJPqALS8BgWDKiMbuvNeuAnYPjwRPM?=
 =?iso-8859-1?Q?5tYjlJjK4ji0m0BDAR3QiGuia+AnvJUGgfJX0tSd2peeSvxC620odbppfQ?=
 =?iso-8859-1?Q?Mk8Q/iyvcioCfbOBTnfkJ4CezGGaDy0LGJMliW3KKtRQUHUjdJ3poiXzAt?=
 =?iso-8859-1?Q?iBLG1zXWy1+h4KkdcZvL5fw9Uj77bxnwpvieofeqZUt2hNhQEYc6qfYcL6?=
 =?iso-8859-1?Q?rXDiWZ4bKXIVAArNJrWOQeikzomeGJNMzJ/5JiPC9FM8yVm1mM+RcV92ZA?=
 =?iso-8859-1?Q?HHGsHDQsXiCje3iFP3jBS/EOjnAfMQDTrVpKocN+bMzqBp7w8YJR0GlL4H?=
 =?iso-8859-1?Q?NCGiImQyWJTu2DTBO60GimX9RRAS8Ghe9vg1G7Jzka2nm2upxfcM1/kUDi?=
 =?iso-8859-1?Q?liPlI97YA2I79zi4Wiy4ajrABx4PMtKZBO9StIjtWiS8PtwJ+ETR+a92qt?=
 =?iso-8859-1?Q?m7bouccRDsdsjsPCmr7ozkfyDXfSG45cUKfXpQIUR+En3UeDyKpR21oKR2?=
 =?iso-8859-1?Q?PUNNQK+nIwzELVD1DurGOYzRYsUnnIDDKAKIds438kHRC4h069oXMyj9u6?=
 =?iso-8859-1?Q?hVCYGtQWwJo+hZG/TOPbo2tSI9vZ9YAWIoOsufz4MyQNnFs5OvEJAyM9nE?=
 =?iso-8859-1?Q?RPvZ1JeaDYkKdt+Z1pYU7pflR/8mgTt+pcMeWGYbjeXEY02Vv+zOBMOuPd?=
 =?iso-8859-1?Q?vsectEAtMx/DkPQMMzpzqP7tuKnxlxnydl2qBvsr26JgWgixzH9tPKGv5L?=
 =?iso-8859-1?Q?u/mQVNPrAJCPoIeZuytDM2hNBSqe8k9XzcdijhoEWyP0vRhBDC97p2BqBF?=
 =?iso-8859-1?Q?AZWNmK4tFLpzkkhGNfAPwcYoZHmt/dX/ThCjKg1wMCkMZD+15E3jAIUUPq?=
 =?iso-8859-1?Q?BTFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YHcnbuYLYnMjMZW+8MJ+VbeIj6iJEJ9dh/Kczm4Z80Pm9S6VdP0wvoXRNwUfF4Dr06s1LfgJACjLWKowSzwlgM46P2YM6ehJFWwGBZnSKC3+vwZkLikjiwteheliA6fZNHkafccY6B/uiYbCXTqffFhZdwGFliqCboQ9P0aO1fJgNnHmzrKuN3VgU5L6edYz8RKZ97F9A5Rd+uZOso8nM6Zv0oqF0w4J1ICUt+BFMAGtvWU83qzuf6Z2N3puvGmeep9opouGvrlIAbCE1xJD/uJt7AR56DTcd+I49qrih+vZdQ27pQEW8xWGKT+ZriiHrlLmZwbD3S55VCQYyyZGBtwtx8i9t+Qcg+WUKiH7dGvnoY2v5+OtFWh3zzsI4GeeaaWYmQiqVbKXtvH2PpuNkbdyPxYgpyQRP0MvH+gO31w1y2V1e8GUwEsRELrSRXte
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:23:48.0100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9436ab4-de70-47ee-89cf-08de6a5b7b9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_PASS=-0.001,
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 12, 2026 at 06:05:58PM +0100, Eric Auger wrote:
> >>> The vCMDQ path does not replace the normal accelerated SMMU init/reset.
> >>> Instead, it requires additional init/reset steps on top of the regular accel flow.
> >>>
> >>> if (accel)
> >>>     accel_init();
> >>>
> >>> if (accel && cmdqv)
> >>>     cmdqv_init();
> >>>
> >>> So the vCMDQ logic is an extension of the accelerated mode, not a fallback
> >>> or alternative implementation.

Yes. And I think it makes more sense by moving cmdqv_init() into
accel_init(), completely transparent to the common smmuv3 module
maybe?

> >>> I think the later patches in the series make this clearer.
> >>> Please let me know if you still feel the ops necessary.
> >> do we have any way to introspect from the kernel what cmdq type we have,
> >> so that we could have a cmdqv option with ON/OFF/AUTO value instead of
> >> duplication cmdq option for each vendor?
> > Looking at it again, I think we can, by calling IOMMU_GET_HW_INFO with all supported 
> > CMDQ types and check which one succeeds.
> 
> then I think we should endeavour doing that. Regarding the ops, if you
> feel that reset/init can be managed through a simple add-on code I am
> fine with it. Maybe Cédric or Peter will have another opinion though ;-)

I like that on/off/auto depending on the IOMMU_GET_HW_INFO return.

Thanks
Nicolin

