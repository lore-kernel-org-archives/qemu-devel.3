Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E41E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIEk-0001p8-6N; Mon, 29 Dec 2025 13:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIEN-0001cX-7e; Mon, 29 Dec 2025 13:44:41 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIEL-0007lA-LV; Mon, 29 Dec 2025 13:44:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/1EoAfJYbdzn/iVIwAR5asjTliLvpVElgVlHlupdu3hBvmkZVWdk7sN54BzCTpPCxYDxy3PrtNEs106xhSew7ZFc7uCRWW1mzOAOOTYDSQCoR04GaACgkR5FpZB+ikdL7aMaCCbpJJ5FjJsPxdqR8+74j63jL/yTpQZ/PqSkgemHC/TvXoDq+JWfJtgEhfb4A6bKxrF0CvV5ZKmonm9C+WNZfHCEiFaUmhW9uEdhEoiibvMrz5OoC4kplumvQm2g0GFzfOEkHgRcC6GJwPNyP3jaYkRhdOj9/t6SXEQKBcyMPVCGx8PRLGejaCusTrgcyBcecQqENd6kz+LDMZ/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIb7i5qL4toKfCtbmMQV0pl+5mn+EJ1+/LYGqRSrcI8=;
 b=HojV8SMzzuKt5lXCzH0K8mMcfnZ2Eon0RNHX3ja0glMkbOC0Vd9qbsAp9yt0j/Ab2940OB6bwdPL1hEwhzbNcWHWxcRd2gNrwnJHYwW8OlGFqPOclLGec/rGeiJV6NnQMgE4mqAFJhYzr7WJA4lcjtdypVC++6olGO+hnAjoEM0YlbGZgHfQc3itkzkLuZEr2A99SsEt5T2lD0jElviycb16dD26F9lpK0foENFT5U+G1fhmBiMVfSav/2OYhB38WHJE5fYyqX/+iG+r6wB2A3DeqyUdaoN5CiENRccUhWQ3E/NjThthS/hEQHwHEvZTvnduzmopxSI6Qv+81pqVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIb7i5qL4toKfCtbmMQV0pl+5mn+EJ1+/LYGqRSrcI8=;
 b=m9R1i+N3yNUkaZJ7inPxK+ZqArkqPXLOSz6B3XZOxSmGEXShURL/LB8HfIY74kPTkA/H/WCoHMYZ5wIJAfXNax4hheoESIqcx3gxfcfnz6zo2SKbqlOUMcYerJ8K7f/tDzeM3U/rVZm70+pfhEXqQ56rVjbGdUTMk8gSqMiynBu5r4DV02gY9swn8dFzgKyPJvS3/VrK9sR5Kuc4U2PXnXaLZEy1an1C1iIeLApgGZNOjP/reLqjXp/bQjSaYvzrss+K41XokvZCQ4VGQNROC+jEjTknPwUEmRBkZgRCR9vsL1AEgC55ZE4R3Ks7wKyDJh/Vd4zxfmckLecVG56YaQ==
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 18:44:24 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::53) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 18:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 18:44:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 10:44:08 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 10:44:07 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 10:44:07 -0800
Date: Mon, 29 Dec 2025 10:44:06 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 02/16] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Message-ID: <aVLL9tvQfRgZ4hnq@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-3-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-3-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 223ae393-88fe-4e42-5852-08de470a499f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQAx1C0krFytbBun4VPR8MspkWEWhss/KlI0RQNBq+cHwNY+StFap1PnZIiV?=
 =?us-ascii?Q?40tRxPVMDyWtd52J3IMFSXnuMNifL5z0DKSK3jWAuUAmLMWkuZx4EYwjVA+Z?=
 =?us-ascii?Q?pWIajts9wLXcYL+HCAhlD6ncNUjdkPXgG557kBm/GTTaF5dYWW7toMQJRmXx?=
 =?us-ascii?Q?QWDHsm37E2QEUX1Z8h05ZlLtSJU2waYv0gG8X++WFxoVDYr3JGe5bj0S44ft?=
 =?us-ascii?Q?GeL1ZegRU9mlM070OoZPBJrKiM4Or2W0rZ6EX7zUFAE5YVDO+Rp01NfUFLP6?=
 =?us-ascii?Q?QMiItLoIUWvySYdRZj8ghednCP9IFkzpyNansgOJDhuZxFXXBySpV25+aC/S?=
 =?us-ascii?Q?6ufNZB9Qo58yRrKnXj+NIbBNCXwYKUIHLSNUIZXl1GPMOyRimdxeoP3MvzAM?=
 =?us-ascii?Q?GvR2falPgcOk3AOVTQNySMFKPnHl43kwg09pmXZ/Ih3jUZf0J/bCquWjlKyh?=
 =?us-ascii?Q?ijxZX4sVJ5yrEwGP1DRpW1fynaQIOvInKbQyOSAMobAF4OapZZQuohkoxE3y?=
 =?us-ascii?Q?VulijVF9UvRq9BGyzT0mSsrirQWZ4jsKMbNkYoyiSfMquAUc/uuzQ5jW/fME?=
 =?us-ascii?Q?NibO0P9deqDzdniecxtUxGwwnC6JVV371m5Bh4IaaNZqP8Vte5NN9cK6jhp6?=
 =?us-ascii?Q?Qp50dljyQJfr2AvNG55L75BjBuBKk+xi63C+dWAXa4fmAMVREGk1gjC2Xg0X?=
 =?us-ascii?Q?5oMA+xzUcSCKKzhF8vEM3LkVN/LGaVwrQkarjyhggkmnfg36q7FzyKDcEp9c?=
 =?us-ascii?Q?GPNpPZnVnGqOJww7r77I2+duQP4g464bXlyNsf4JNDChkxPPNHH//aoIf13J?=
 =?us-ascii?Q?hNUZltPb9dhlc91X7p5uemA57AOjN6tE08NRPT8thG2pilLotUhnRavkpKzp?=
 =?us-ascii?Q?jDjawHduJAOKXVUFRYuEByudghcXhcpJ3BpfwaNAqiWJ0Ck7SJJIk7iiC5pE?=
 =?us-ascii?Q?/hdmdbPM5wfI24cTe5PO6RN1apCUafRxDE0FCt8YPmX4YkEQ5fHmPSfUdzTQ?=
 =?us-ascii?Q?e7yiO1pgWSeLsIhWEVfdJEn2vIfoK0TP8RsxMAfuajexxKwSBJJzZ5gDED2H?=
 =?us-ascii?Q?OFDXFSQ2qzJSnjS5FSANsG9jz/8gXKkvuSpr0hRzaC/3bdnr5kM75OZF2qa6?=
 =?us-ascii?Q?RrQ9bPDKtfcLdJzvuRUINf0iSn4fmc8XOvubEGtKb11gjFiFoa+Y4rFeFqvi?=
 =?us-ascii?Q?ZTeZhBon/vcR508kwPn25Sc6EW8ADrTkUR1iNqqBPhPkCQlR02RDVuaW3+As?=
 =?us-ascii?Q?xygvIbzXttDuP3PrnoDR7dTwFU4au5c/MzPrj5vP3+aUqdNWVnMpEmEb56DG?=
 =?us-ascii?Q?etKr4ZnQ+ZID/b66cTiOwxb6DPyWhARoD+hNxETYsYpbq4ojn1JzHa77Ybqy?=
 =?us-ascii?Q?3G6Si9hBkeW9ZOLRMy3QDPXRZBzYYMolPc9VTija6jWojWmPQkql3zJGDKMG?=
 =?us-ascii?Q?YR9+rnKW3MkbMsxWH1awlrFJ92Q3RhlUBqg/tvMqitl4SSX+n6BqCwP+sxRy?=
 =?us-ascii?Q?STo1J6GjUfBTBEuWuS00aD5iWNgMSZg2OtVgkNfMDwGOAYEdI5DL86Lqs8Ym?=
 =?us-ascii?Q?GjsVYWnqE1R5f+4+nHw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 18:44:24.1812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223ae393-88fe-4e42-5852-08de470a499f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=nicolinc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

On Wed, Dec 10, 2025 at 01:37:23PM +0000, Shameer Kolothum wrote:
>  bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                    uint32_t viommu_type, uint32_t hwpt_id,
> +                                  void *data_ptr, uint32_t len,
>                                    uint32_t *out_viommu_id, Error **errp)
>  {
>      int ret;
> @@ -467,6 +468,8 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>          .type = viommu_type,
>          .dev_id = dev_id,
>          .hwpt_id = hwpt_id,
> +        .data_len = len,
> +        .data_uptr = (uintptr_t)data_ptr,
>      };

Perhaps we should update the trace as well, given that we do print
data_len/ptr for iommufd_backend_alloc_hwpt().

Nicolin

