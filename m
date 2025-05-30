Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6B1C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 21:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL6uq-00077d-US; Fri, 30 May 2025 17:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uL6up-00077S-IR
 for qemu-devel@nongnu.org; Fri, 30 May 2025 17:05:23 -0400
Received: from mail-bn8nam11on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2414::602]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uL6un-0000bS-NK
 for qemu-devel@nongnu.org; Fri, 30 May 2025 17:05:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u82T/IWxIWzGJrMH75BufC2Qa3ASPsNPITahsHNBKGRNg7gdXfCVOFJCgQux1cr3wlTD3DItkx7xCqdejLrdTa0wruQrZmJWYACfGhC4tU7zoRxTboUGzep0X5S5oWGSPKg1iReZIEhQihbJDRImv5QQS96g3CPbaoHC7t9KPB5FjTBM8LDcFK4bK5YNQ2xMwzKH50yqy07ZkzFfUaPP3qn+gB3Xqs17Mo9KpDwDy/Hh8Xq5OHP4/+TFWiyG97Mr+4qbp7VjsGwj7WYOUUCTCCUqZRf8MRCywbN1iBaPU0U/985/52EBE4ceK+G+xbRIXBeSUs4aRfzPM17U2Dg1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3I88VM7CC9N1MDpNq66I1xGV7mhTL65zcyfZd56dmE=;
 b=kPydoF4cVbYG1tW/lhUVawFdVEJUWpcrY3s4CXVOENoztvjM+AgLfnhBKuDnW53Jwvtutftr3sVZqaDusYKTr//GuELGoVcV9+bcVMtm0Ck6mfbbHxj/4aE6OlaD4sTxSBqQ6G2cwY4sFosZI/EoYFqBnTSljW4ksxlxxuVmVlXe/buFPPYy/1njv5hzUH8/AyQvz/eS4WZUGC71B0ocrfNlbfg803n8K7CgNRixFu+rKMkXJaflKpo5NnWA3sgR+oGGbC1wdfepD/ubwfWlxA+Qm4zIvHPEIimtyPQbuvrACbA8ka94g8eUIZVcl0Pjl3M218Tf/sqNQA3n2GqMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3I88VM7CC9N1MDpNq66I1xGV7mhTL65zcyfZd56dmE=;
 b=KA8E+h1Iu42HYf+GkLMxw3JYoP9ZIz0tVwXB0zdtxhX2+wrZ1JmrhLGsBkm58X//IVUuQTkOgOlXLm+O/wXmFQTBShuVqlZmnHppX8923EDBLeNouR42GTes9oBqSZkuJ/fZKnm/FOs5NqB6igaSyWCoAo9KJrBlx1LGESm9NDWlJFXgmfhPceKSXo7X7No7w7fFqDnmtxBpq45SZYjNtQ36in9p84QSMobZ2veacyG/IwFTyW9X7nYvdv+I166mJvByo9//ucbFZ/EWfK3xvnds8ja9c1fS7vgzTd1/IO/eWmPf9JtL03SWy16mJ76pGoCsO6YTM/lw9NFfUPeVNA==
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 30 May
 2025 21:05:17 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::5a) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 30 May 2025 21:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 21:05:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 14:05:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 30 May
 2025 14:05:04 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 14:05:03 -0700
Date: Fri, 30 May 2025 14:05:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
Message-ID: <aDodfcVaeaYj6iGy@Asurada-Nvidia>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-5-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530093512.3959484-5-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ac28fb-e9ff-4ed2-cc42-08dd9fbdadd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E3aD2BXcmtcVLb7mk1zZkT47pR7ZcwV3MxlPNfb8uufZ5RUlClLwEuhK9RJx?=
 =?us-ascii?Q?Hycjnvs2abzAbO7Mtuj+lVY7Tn4bgDkt411UdRn+YVHIkrc5wI8oArZPb+s5?=
 =?us-ascii?Q?6pAiNjpClTsnAcdNioGssd7sVByzhudDIWPkOJUDJYnXZZHWIwRxiTQnWrRg?=
 =?us-ascii?Q?VxWl90KOy/0aC/TQpehsZYcyusptRtt+KkHrwi0LN5Cgscnh+mFt7shnGvEE?=
 =?us-ascii?Q?ExqNxEXQo2kCn4qt4qrSGnPe+uuV/Ri5sojwTY6imz6grWAclBiL338JoKV7?=
 =?us-ascii?Q?Zj9CnxajSshf5/7w4X7YCB19Np4qA2KZaVBV/h7hluH0Yl6pl17a+uRgFoPR?=
 =?us-ascii?Q?baOtccQIrbK75WWMkQ6Kk7+/+hrljDRmJjxrsYizwqPQiDhZZYEV/kDQiD7X?=
 =?us-ascii?Q?xFNAwgJNyG8BQhh36rkLwjB2VuIdNEw422OAukzKzPBYD5ei9lWiN1HhWDUX?=
 =?us-ascii?Q?4OhuG3XR3uOV9XtaPOZ+qLa9Yo0uMkfakzImC5gCxtfX+XMdEl2FTX648Dd1?=
 =?us-ascii?Q?jpvKIFFv4+sgcQ59vtA9vTmeTlsg1Ui7aabXbNXKOOm2oxhWDFOvA6lgZwth?=
 =?us-ascii?Q?oU/r2snRYkHG3QZl253DE7pUgrnMoKNy0KCNawpLZgImvreMb+Ugs+XDuMxE?=
 =?us-ascii?Q?BqT7idLRooWJQxL518tg3MsYmUdYwF1XkidFDMeefu7Zbs7Jrz4tqz+0irC0?=
 =?us-ascii?Q?usbdG7R3twfZWkvui9mShbjFtf+QBHX1W9ZF+VvdkCLMI0l5i1yLM/voY9Yx?=
 =?us-ascii?Q?NcT6s7/xbVtBYOCPvpoi7Bhu+W51fqcJfpgeN9Fy3/zkyRcwJazLxPndLIQw?=
 =?us-ascii?Q?iw7BKoTY8HmwwaLxsDLhRIucaAqKejrv1IxLqqjdYLy5f/P5k90D5OVM+JG5?=
 =?us-ascii?Q?bIRzocqShLMFI6sgOkHapB5JMT/W/kIv3eo4Txo6yR/SdtcqSvlnM6VqW36U?=
 =?us-ascii?Q?fLKMb1NktEbwNQuSLThdfNqPKC8isP83uKPJY/dLdjux12eTf8Ni9thnXurI?=
 =?us-ascii?Q?4TqGSj0DhqEymgYcjbE1MI91nLyuPXFKJFCVWmVQsVwo16qtYm7Sm/4GBOb8?=
 =?us-ascii?Q?fz3ok8F5TqxqCksPlftUyPdX+jN0SPLzj1sERA7cZcaMwgCGn0TjKiGj2dF+?=
 =?us-ascii?Q?obFYw4sWhJFrmd5kVMQmUC6Xjn3pftcHLd7VVvCJKBFHYldI6fMp0UucTCl5?=
 =?us-ascii?Q?2ncME22jHRbcFH56C1BegRRK+HRErfZX0wqRagAF9mYCVK4iMlWaW99VFFm2?=
 =?us-ascii?Q?sZcXEHZxCmkPts0ZjkhwOPXYLqvnYdafFFzXUhA3ECZI6P0Ich1YPDoPx0Qa?=
 =?us-ascii?Q?W/nRjR9OJD516njrJfT63Uj8N3R+cqKuTbG2l4y40Y9yAI4Yp5+oJMXZhosI?=
 =?us-ascii?Q?jTaT0WekNqvczrS9TAuKNoAH/qEy1quveTRlAxuVrM4RJ1k9+nOyhRyERPPJ?=
 =?us-ascii?Q?4tBEOqDMgWwlT0ZE6GUxpY4+fZT8mHVFmfVw6tzn8V0AQAmrZuoebiJOZiQw?=
 =?us-ascii?Q?YsJUP+0mfHI0mGTDiMrcYEFpLxwm0b7GKHwT?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 21:05:16.8957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ac28fb-e9ff-4ed2-cc42-08dd9fbdadd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
Received-SPF: permerror client-ip=2a01:111:f403:2414::602;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Fri, May 30, 2025 at 05:35:12PM +0800, Zhenzhong Duan wrote:
> Some device information returned by ioctl(IOMMU_GET_HW_INFO) are vendor
> specific. Save them as raw data in a union supporting different vendors,
> then vendor IOMMU can query the raw data with its fixed format for
> capability directly.
> 
> Because IOMMU_GET_HW_INFO is only supported in linux, so declare those
> capability related structures with CONFIG_LINUX.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

I like this that we eventually moved all vendor stuff back to the
vendor vIOMMU code.

> +typedef union VendorCaps {
> +    struct iommu_hw_info_vtd vtd;
> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
> +} VendorCaps;

Nit: can it be just:

typedef union {
	...
} VendorCaps; 

?

>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
>      uint64_t hw_caps;
> +    VendorCaps vendor_caps;
>  } HostIOMMUDeviceCaps;

Ditto.

