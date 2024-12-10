Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F471E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 23:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL9F9-0005hf-Kd; Tue, 10 Dec 2024 18:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tL9F6-0005gr-HS; Tue, 10 Dec 2024 18:02:12 -0500
Received: from mail-dm6nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2417::617]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tL9F4-0007dg-B5; Tue, 10 Dec 2024 18:02:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFzKPNfhrnBeTOdnyEqtw6Og7tnFlQr/uXIFR9K4hM1ui63MXnw8FYh7L9JwwIjoRsyxXZ3yXJ/e8HRttaeIBb7LViMOvfi9iIWpEfVH3V8Qcht3SXs3PXse7KTxS2D8j9BnZno0Pfeu/Of4lSf4Oo1tt2c+QxvmOxVqjfK9xga1IvMJ+dpaO4FsW6orX+EPLt2omhsXt4y5OngaChuI0jBjczuZGnMFQkGTosqpC74ZA+fJku1zPMyxga+kHv5tPLOQfkX2l6q6TH6Luui7SQbBMn268dEytaZcz23g5MyNJ21EagmdADGDErPX+KLqtq8e2SpH0SLgVovdEyLbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPlhDI+HrFX1Sg+QADmsB2EUTslvD2OUgJ5qvNVTSe8=;
 b=iSuFrH4LwoD91ZsMKp6727fX6mdr+t0UVwfb1SjpZ1K5oIXBWt8CqKKU8nL80DtnrsEdIMIQ+kLriN0VT2DMDUgqB4wzIgrDfTtORLferaAP67HBNfNPdoi2milF6lLzWWEfyn4nJkaAL9MaFzRaHtCOve7cI0xauNXViLfE8/mTCrgfq1QEHe7nTzfsDfoX8avXPnWMpiSvFki/0+yi0LvM0uMVjSz48dSIkrF4cjw2nEVlyW7LR5jtXnpjoZVtFzGl/rf5HIJ6ruTnO/TlBiQxXZHGZ4G3Jo/+pDO3ofD9WQk3A9x19ALcznbaLxQiMhyDCDwdfoIs7S9TfDyqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPlhDI+HrFX1Sg+QADmsB2EUTslvD2OUgJ5qvNVTSe8=;
 b=r9UY8NxQ6Mirzcruebbt4VtbVT/gt/fHIJnS89mdI09nJ1tR2jcKc/edJDS9tRVDLO7KtOK1vqmMKobSA3ueNZJX8tIs7cmn1f4HBkNN6oPrY6vGFGfmqTq1f0ChMCdjkQLHVk5q9C4Kl3w2flRowVQsy/8EddGDMord/tVSWsA1zGxca2ZBysdbwf3+MfKLh3Vvz0lI+CwrAZN6wz3LWeQJp/1opWfoE6i9WXVlTGmhOIJKIdPleHHucMGFC4RCYFDljlWWWN/xwsIYT34M57mVVpGJxN2des3vDcGaxaoe4T7JDa0YGDiRHoh6Zu/OmC5awDR3/5vvJa+2evsVGA==
Received: from BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 23:02:01 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2f) by BY3PR05CA0031.outlook.office365.com
 (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 23:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 23:02:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Dec
 2024 15:01:50 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Dec 2024 15:01:50 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 10 Dec 2024 15:01:49 -0800
Date: Tue, 10 Dec 2024 15:01:48 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <eric.auger@redhat.com>, <ddutile@redhat.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Message-ID: <Z1jIXHmFcBFIUeKn@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: c147ffe2-4b07-4708-1a8d-08dd196ea781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?klelcnXTwSIJBD74y0CYag0kFSDXnkHeVhhsDRU+bHk0gV/W1De+uRfFliXe?=
 =?us-ascii?Q?HyLJeHDWYDC6Stu2Chs7g2ggN5b9LtKtB4T7ihOCN954gWlKvCcnnxhIwdeY?=
 =?us-ascii?Q?wkRnolO51HYYE8tltlp95oItwda5CF2kylFwZmWxFsIPEKGGJtwthrV0DJLu?=
 =?us-ascii?Q?XYYaWwL40N+9/RWiKfUGWWMj/bKlHGlAYEkpm3odpXyn9EdFVP0Yp+XxNP0Q?=
 =?us-ascii?Q?7vXH50uwuE1IsgjSKbypuHEPv54HlSOCO/B5HFFM/dGiRbKWeEo2tX2eA/TA?=
 =?us-ascii?Q?5you1wA5DrrJWr1cWRs2ctMTERYsL5Huk2/56KvuTjKaBa6Swd1i3/9HAk/8?=
 =?us-ascii?Q?a5Iby+2vXs0Y6Kk/E07Hzo3aM0iT1liDuIjdPpV/+luXbmUNdMtrkmFi4h+R?=
 =?us-ascii?Q?yW57IuKsbie6Dt5D4EzI1rKRxz2Tn5kql6Cxm0jWHb5QJEOXMaXmOCjqBEn6?=
 =?us-ascii?Q?IUfNwSf6tdYpaz8MRY67Nor5l23gbIZcHFUcfGarL/BpVL0ayySYG/nd92jg?=
 =?us-ascii?Q?RcRCQstUrlFNVfa2aG/d/waImAhS3lwN7rk5UhVNhwVTPWVLkGFYp+AUIE3z?=
 =?us-ascii?Q?JtzD8tRCdyOt/EX4os1d/MmKRYtPapPbMM2jQpAl4wFt+J+pzv5H4fXYeSPS?=
 =?us-ascii?Q?H3ukZLRxZAGiFieXewTMpYQmnOwDSvi6JuNiYcq8VbMyPNzMtPt3UdTMJAFN?=
 =?us-ascii?Q?PX9lBVYI72YHuQYxvKIUcOoh4lFiwG3mJjpCz3AX2xjynunv+z9+0IZ9/Hel?=
 =?us-ascii?Q?K64XLV0F9NwtRx0tJEpssabJg+nuA64hCl4U+8y48S5DniY3EDJDdhiFjkJx?=
 =?us-ascii?Q?Xzj4iG8i5M9N+M3miqUar1neBGwLUi2UkLuWu4AIpf4JasQ2DKBlsRkAAth7?=
 =?us-ascii?Q?MYlogbiZBamUUWNqvPgcu5duCJ43GYUoRUbTdLj6b1McskPUD3HWeAG7Ya3t?=
 =?us-ascii?Q?WGELCZh4jQ0SUffwTSUB5nv+7PfDGfrZ8dAE6WCpnvF7c+pMrelpuV6nE9tL?=
 =?us-ascii?Q?y4A74mme+ZXOW2dTRzIgnne10Y02G+RsoG2bRFCpumf60EN+cekV7kJ/LK6U?=
 =?us-ascii?Q?z05bnz73iEa3Hi2Qh03WtKuVrbZUD+9poPDTqqNN3mNl/7QA61KuQRbwtHIe?=
 =?us-ascii?Q?8n+OlHvxlDg+HO08wEFUfJyuYLC+86K3sI73kzRwqtkrKrgiyzQBwkVedG+0?=
 =?us-ascii?Q?uMXu76Bq1Uuk1kqgwUnfa4pq244h9U1Ae0REurRVrkeJFTnhuPYKyZtJ+yIN?=
 =?us-ascii?Q?IyAz0MuxnNe9YBKVPybXiWweMJC+sf8JgnbSK2cnz/fcBoe+dtAW+agPkeOH?=
 =?us-ascii?Q?76UQzeDSPDL7QNDGrp9zMv8hgj+2OYf6rXr7Q+xO/kmdh28hG2mZf+vye+R3?=
 =?us-ascii?Q?oOshLloNjQ5kZ4Zr4XEbdtoeEtg/uykAyLKFQK8ZKPS462n4QjGQIF9Y5PG6?=
 =?us-ascii?Q?WWeI1s8K66BEcpZ0/hslMKRl1jUtzdwr?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 23:02:00.2893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c147ffe2-4b07-4708-1a8d-08dd196ea781
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
Received-SPF: softfail client-ip=2a01:111:f403:2417::617;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

Hi Eric/Don/Shameer,

On Fri, Nov 08, 2024 at 12:52:42PM +0000, Shameer Kolothum wrote:
> Those IOVAs belong to [0x8000000, 0x8100000] matching
> MSI_IOVA_BASE and MSI_IOVA_LENGTH definitions in kernel
> arm-smmu-v3 driver. This is the window used to allocate
> IOVAs matching physical MSI doorbells.
[...]
> +static void
> +build_iort_rmr_nodes(GArray *table_data, GArray *smmu_idmaps,
> +                     size_t *smmu_offset, uint32_t *id)
> +{
[...]
> +        /* Physical Range offset */
> +        build_append_int_noprefix(table_data, 0x8000000, 8);
> +        /* Physical Range length */
> +        build_append_int_noprefix(table_data, 0x100000, 8);
> +        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> +        *id += 1;
> +    }

Jason made some kernel patches for iommufd to do MSI mappings:
https://github.com/jgunthorpe/linux/commits/for-nicolin/
It addresses Robin's remark against a get_msi_mapping_domain API
so that we could likely support a RMR solution as well, if a VMM
chooses to use it v.s. a future non-RMR one (mapping vITS page).

Yet, here we seem to be missing a pathway between VMM and kernel
to agree on the MSI window decided by the kernel, as this patch
does the hard coding for a [0x8000000, 0x8100000) range.

Though I am aware that the sysfs node
"/sys/devices/pci000x/000x/iommu_group/reserved_regions" exposes
the MSI window, it's probably better to have a new iommufd uAPI
to expose the range, so a nested domain eventually might be able
to choose between a RMR flow and a non-RMR flow.

I have been going through the structures between QEMU's SMMU code
and virt/virt-acpi-build code, yet having a hard time to figure
out a way to forward the MSI window from the SMMU code to IORT,
especially after this series changes the "smmu" instance creation
from virt code to "-device" string. Any thought?

Thanks
Nicolin

