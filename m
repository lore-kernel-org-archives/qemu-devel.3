Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50CEE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIai-0000SJ-1y; Mon, 29 Dec 2025 14:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIag-0000S5-NM; Mon, 29 Dec 2025 14:07:38 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIaf-0001zT-7J; Mon, 29 Dec 2025 14:07:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwe9lw/L6goDMjPQBWDC1GMW+pVaZ7OzLgLZc4ckQ29wNe1fKnhoPFbch4Alhkk0jktcha7MkHY70oyar7x73F9Mh21PUKx6Zmz6BAT8kVA/P3esE4dnfaOsRuRnzA88Z82iss8xentDE+jFNhSaw7lA2mjVzuf4+IhmrsDgU7a5ARQ+JIhw6pmwnAGaShXi7X8liiMGfjWHPN9J2LGHe0qVnlJ8I+dt9Z0AIVkV57ocEh8WechCx54IcUnx8rQxc49Oqpo8t7FoguNox+BO2bAnPF0NoPhzO4NI7WI9d/lYLqVrP6RuWrvxPmlY4J2O11BLLPmMDrSjPN3nKxC/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ6a1xUOrdVm+kmKYGT+wi9ZcEJll7Gu/6RF39I18DM=;
 b=nF+WyYYAN6jhxe2rAQtxxAziBe5M1SLavHA725+fPG5P/YrVyocKfxLb1n/r7hFKkgo5o/7qFXJ6mg40EHpzz1blyOtBIvD6WwvsWxkG2jt7uN4KNV3WsgJznthc84KtXE2TKyWWDMzVVR0fzCckmyYl1czrxoHDqcyXy22ho8wpDNNG1iX1DzwKpB+o1J9KnmSr0UgZSh/45duNNqn1Cf8jTh8hcfMTYLLO90leYUITLpWLI2O05pNOfX9Rridv2YgN39lGlZxspyJT86ZoMWpMun2oBL/erfF/ZqtkEhXOryJwF9MSXahKU3tCM3aXJ19CT/Tdwq31p/lc+j4CIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ6a1xUOrdVm+kmKYGT+wi9ZcEJll7Gu/6RF39I18DM=;
 b=PjktQABhSX8Uvx8Mw1KpVwSghbishlUatqgS9/vlBzaqB8XFGWpmybgXNWGc8CwkMpuKQUOk9dywwXuC3+Aiv0Ci8H34QMevZfJrOW0kj4EmL6tS5LM+7dgC32SMhkMGK9GtmP+EBk+Fkd7sqbqZWXDsGoicchM3GHeeiFQA5sgcqOPLuP7eutlCSfiVUB8jEDr3iyLhcy1v/ua/Brr0K4QnQfm8uLwnQpm6R0xy6pGfyGZ3EGjDsEeofa6dUHh79gCEDXWtJSGaqMUHKj7QPwBtiyjiPBxGDW92sjGvPqIQuyY/4NJiHu/3KKTHqifnkd1yKjUv0bTUoqBi/sMqaQ==
Received: from CH2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:610:54::37)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 19:07:30 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::d5) by CH2PR11CA0027.outlook.office365.com
 (2603:10b6:610:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 19:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 19:07:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:07:27 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:07:26 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 11:07:26 -0800
Date: Mon, 29 Dec 2025 11:07:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Message-ID: <aVLRbI2dYkvIwEBv@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-6-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-6-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 23eef60d-b9e5-457c-723d-08de470d8396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hX94tZ/c1iVv2C3J6MzhOUkktRIU7JBXumla2OsqTrusumsB12bm0iES6l0T?=
 =?us-ascii?Q?eVdUjRFb5twomMfE7Ftkbpv/7tqLfu+qGRURMZCvkVq/eXOSWU+OHLNuG05n?=
 =?us-ascii?Q?a1AFKhonOu3TShGZSm1IVqDfNZky08yIMiBAEJVJJcdDRj1+8ae/Ib2CKq4Z?=
 =?us-ascii?Q?7WKXFQ1UDpnA5dgtZdKZQol3tHjei+dB0hvMEoGdJQrzRvVCrzpvaF+Pri79?=
 =?us-ascii?Q?8HR0uJE/EwKLDoNZAdCBmmd1V2ZeFKlQcFSQUg01B8fVolsnr49i9MkUIskR?=
 =?us-ascii?Q?Ot6+HiN3EtlwEvnlvKrdP+cWFkAw7LEOcuqn+4oEnJZc6+fzW7WTOl/CFnmD?=
 =?us-ascii?Q?+p2hp+PGT3ygnfLefrfeSG3ZVQrY3GJS+3z93xu88jrJsPdUK8x9KO1NhBlu?=
 =?us-ascii?Q?wN8PuHKwP9cZSzevkjwLNBOCMcbk1jf5aSVgAaUTSYXjrGVMOOn/SQSv6LTv?=
 =?us-ascii?Q?+MubO/jFcGVTJC6Ft+xw83yeP9d8HW/gbz256vhg0DmW1TzMKYMcgaD2W+Sf?=
 =?us-ascii?Q?9JIHRwfPyqfRY5a9z+dW8T/vTSXvQpbvhiSQl4s1BNN8+7Q5a9Vc/sdc5pCW?=
 =?us-ascii?Q?btMDcxx4ZpzS1bDlOUemyQF1TLI1AK9D1vmqL1CCE0KnZwxMiYjODh0IuNaK?=
 =?us-ascii?Q?q6YuPPRcuj1aWhLVzbYG5uL8Wv4ixFOvcNeH0NACxOtawvXvK07gJR0EcaRg?=
 =?us-ascii?Q?8qkuOzNkzv2GpoSAWdiAvKB8WEIWlgsLQO2SNxoY/hb/f/c05UKEFOX+nfsb?=
 =?us-ascii?Q?rHb3Ma3mihGoKwGZvcvJwGJkm1XAzDi/4KWMtAL6F53aoZ7T4fvE6FjLUvDl?=
 =?us-ascii?Q?wM5kyRXrIOLY128IsrxA3oyIUrI6qwyRoA42S4RJGD4Ahnk60iVDECy5LpmD?=
 =?us-ascii?Q?8PV70iBDlMVD9Tnint7o8eImU05EHOvSe2LISnipLrmXNHDi1lGgHo0QgPtI?=
 =?us-ascii?Q?GrcNutcdwNY2E2QQ0rskXpV2juvfj3BDG1zvzy93nUhOfmsyba1seKMW5Bau?=
 =?us-ascii?Q?piaUyjN8r+Q9sqgqPUD1l3xAwOYXXVvBzvS8jjmPgTCE8WrlgnkkBnuCV8os?=
 =?us-ascii?Q?VRpVoRqFRkikwj5WuN2PdZmTtKH/gFSKua5lef3NO5L34RokJbR3J/G+RFda?=
 =?us-ascii?Q?4a3vpjOtCUwCAyAX3CsPTrnyFlxvK5UiB+5yr56MMHbMMiH5w0hw8UIWMRRR?=
 =?us-ascii?Q?ZLTadpeN7q8oZWv9MXop8JUdfp+bi4+/94AyFUkCxsgis0BQsQMDNa5Bsg3K?=
 =?us-ascii?Q?3pqV03vLufxx/+3OsfVGp4XCgFL6rkbK+Zg7YucvksmQb/WbvMaobyFfTgJd?=
 =?us-ascii?Q?xS4JAI4r+CBaJ1fZp8dVrlzzC0RYqiqMjGzg2PjHENYwPrCxkSHELCX8tx1H?=
 =?us-ascii?Q?Iwd/KHmdpSJO4sxujy8Gu1PJo/o/YTLGMLFdEAlTtjjGtUsGdE8Z5rOWfis8?=
 =?us-ascii?Q?C9WKP0Y4gcf2TIlVH/DewQFM4hVb7vM9+ya3fO2SBKo5d01iYKzQrvZKuZvF?=
 =?us-ascii?Q?BRcr5G9En+D3U+OOcxm6KK81AwLKqzizjdbfkSQ/plcbtySiki6J3Q+wMxwF?=
 =?us-ascii?Q?rg8d6aH5OSocYhy9vL4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 19:07:29.9389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23eef60d-b9e5-457c-723d-08de470d8396
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

On Wed, Dec 10, 2025 at 01:37:26PM +0000, Shameer Kolothum wrote:
> +void tegra241_cmdqv_init(SMMUv3State *s)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
> +    Tegra241CMDQV *cmdqv;
> +
> +    if (!s->tegra241_cmdqv) {
> +        return;
> +    }

Maybe g_assert?

> +typedef struct Tegra241CMDQV {
> +    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
> +    SMMUv3State *smmu;

I see all the cmdqv functions want "smmu->s_accel", so maybe store
"s_accel" instead?

> +#ifdef CONFIG_TEGRA241_CMDQV
> +bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                                 uint32_t *out_viommu_id, Error **errp);
> +void tegra241_cmdqv_init(SMMUv3State *s);
> +#else
> +static inline void tegra241_cmdqv_init(SMMUv3State *s)
> +{
> +}
> +static inline bool
> +tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                            uint32_t *out_viommu_id, Error **errp)
> +{
> +    return true;

Should it return false?

> index 2d4970fe19..8e56e480a0 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -73,6 +73,9 @@ struct SMMUv3State {
>      bool ats;
>      uint8_t oas;
>      bool pasid;
> +    /* Support for NVIDIA Tegra241 SMMU CMDQV extension */
> +    struct Tegra241CMDQV *cmdqv;
> +    bool tegra241_cmdqv;

tegra241_cmdqv is a Property, so it has to stay with SMMUv3State.

But "struct Tegra241CMDQV *cmdqv" might be in the SMMUv3AccelState?

Nicolin

