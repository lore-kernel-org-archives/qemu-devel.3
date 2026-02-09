Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B8DE94622
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 23:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpay9-0005qq-QH; Mon, 09 Feb 2026 18:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpay8-0005oW-FT; Mon, 09 Feb 2026 18:47:04 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpay6-000113-Po; Mon, 09 Feb 2026 18:47:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEypEG6kwyuQfcjZPQGvZrOlb34S09akQKBE77DKiChW6eZ28pJ6fTQHd4tB8lSY2B7xBbg83qf6E2IP8Lhc+GcZIkoiLssYP49PyCzuuMgyCoi9VBK1J4VC2IzdkcM5vQdJO6APp5Ly5SLvxx+SVgMMU/y1MTAe6v0f0hoADrJnBD3GGKjrubA+JKuuNK7kkBqrf4cnhAJo7hjeG8Lm54M4SDFFOrV6QqlVCQfx/OrkdXpt1KDQPzKB6nEN8ut75G/qxUrLLDqykuYtUteYXYY/aswjc7PAsY0vKaCpaiaBCpdcEmObbRDFjHJKYdvTFki+DL5wBolweZQuryupOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqTXX4SYRo8VP4MORxuVG/fXIuwbx3HdIkheXpopWso=;
 b=CoAeG+3AMhYgxjFbncxBhTHeemoC6dQ1jQYu1bGzaIOsaWTFDcStgfyW2KH3sxj/p7KXKmw+B/HM6U6qdPHrMvNKg+51DatJhqxQ1VDkw5t5FJ9ug/Lrrc5X4wPHAR0uVh9mBQRtPXsEsgYY339ecq5SUoRz2sJIvV2/HlYWG5uqERO5LrZoxB1X9uZQ6saLmKv+MZ3MDZvjZWaU77XreQToZzrF8GAoLFeTkwWoCCEPGqE+Umz3HGoYCrS9kwk3G8ydPp8k6WPxmNMg5bUVQ3qk9loQNKV0TOY2MIn/T5L0SyjeS0Sps/YU9C9bvwidPYXo48RjaQLSd8qrxqC/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqTXX4SYRo8VP4MORxuVG/fXIuwbx3HdIkheXpopWso=;
 b=Cp2jolx6m/kbxmaCfH5OsiP2a+A5jJl8IL1sDJv5xmIbvvtMX3Ku9YE/2PjYPji/W1C66P9zx2gXhu/dnosWZGD39u6p86p4017SNObBLql/Y4Ksd/ZvyTyAd64GI5VnYqRRWI8a8ncukODtxfurqzX6nS5UsoWod56r9q2q9JY4f18v2u5EmHY+7/30pxVwOK/bQs9VWqHI6V8NI7EBSOaUwB72cK/F89zLhMvnX6yHeQINN9/d95BJM4c29EQviYU5hhaKxgjdHLCJwO9DsH41KwUEICGpieTK0fHRBKVeorFdMDzjqjPO20TT9QooVpwDlVg6z1Ifs+1wx2O13A==
Received: from PH8PR20CA0014.namprd20.prod.outlook.com (2603:10b6:510:23c::24)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:46:53 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:23c:cafe::5d) by PH8PR20CA0014.outlook.office365.com
 (2603:10b6:510:23c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 23:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Mon, 9 Feb 2026 23:46:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 15:46:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 15:46:28 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 15:46:27 -0800
Date: Mon, 9 Feb 2026 15:46:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 14/24] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Message-ID: <aYpx0baxoZWExE5/@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-15-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-15-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 8967adc4-c95c-470d-961a-08de68358068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wXeN9qZ8FPuj5tf5QkgC5RiJQ+U0lRXH3LBQf54N2dwHBUcfN/oNC+9XemNN?=
 =?us-ascii?Q?SHlAZd0HHBB3rxJ0qlFIlC/Uq2asMyO5s7MiJWpNHlpKfFcE3DakghYwfTGv?=
 =?us-ascii?Q?kjTFewi0D7wOsPOOOx5bk6SBo6gskHXOGYxwVXU17b2rvFV6PofbbmvFZQ/c?=
 =?us-ascii?Q?+8TdyvxXZFI0rrF+Hy7prAZe9TUGsdeOCAk9/1A9kFg4pcHlZNm5a1CyfUm6?=
 =?us-ascii?Q?vptRg+No5akxVYRvZJOia3MNs7ggYaSIEnQq7SMHG6yk8F6WBO6ERAW3rhsU?=
 =?us-ascii?Q?Jp8rY7A3zfEOL3DKj91YDnxMqiWdapjrZJjJQ4ze92AxLkWFQsni4XoJk3ZJ?=
 =?us-ascii?Q?CHd98cX6Jqyoe8yS0aQYz/dlz2jsh6toeYbGNO5pSheIWxjgQcXS9Xyars0h?=
 =?us-ascii?Q?AH7tTCwkG0uH09XZW5Q7CjcSiNMuxNItEqgYvc3KGRl0V5sxwvNFdEmzK400?=
 =?us-ascii?Q?5TC+WlSqGOflw3FdWji9JJDmfNKqfzJzCphG3kCr7dOsttoIQspJhG2LANIo?=
 =?us-ascii?Q?SxjgN1jSf27sljIXNVecpPzjq/s7+WRGIldfXv9bc6SsNgCQsbGX1US4c1sc?=
 =?us-ascii?Q?apVlPch+jRt66KVtbQieT094in/hT58coTedlNgM4+qKXyHK9YD8o68djOwU?=
 =?us-ascii?Q?xCUZ+MlLAJySd2ubjy3duIOTvlneodXru+gP6MYzrCqR8qV9XdLq0bPzRJYk?=
 =?us-ascii?Q?ZL8wB/0E3OTLi9ZA474KemByp3TyiRv5f5C5NwUDEHc4Trz0t6uGQxZCycc+?=
 =?us-ascii?Q?RrmVtFo9Ca7ySbhD+flJf5zImS4uVuMqsBEY7TwytW/SNYpkJjaFRpuvfAlw?=
 =?us-ascii?Q?+XAkHU8z5WKo4XwT+eDe613YePaQrR4rv5caAG9Jq7Yzvi6QIYVwhr1mOqFr?=
 =?us-ascii?Q?umj7IJ36DkpprY55TnzbZgltHCVk5/oJOlZ42VizxIzNQupONAUWdPDNsPlH?=
 =?us-ascii?Q?UljMq/+vqB0ifuR3nlQ9WwVirTdkkvpmv61p+mAELBgxKWtDJUad6G4DJ1I8?=
 =?us-ascii?Q?+ZXgFExDseud4/Q2VcnidC1RAdZPkcBuNlGH/RMEnaAXqk+wPpcRXsCqLGeE?=
 =?us-ascii?Q?Na80L+PLyJcxDnGAVmtDGLqEMAL32bBvSr4Qlv2m9TQP41v+P2cI4SYzhjyd?=
 =?us-ascii?Q?BeT4Qq0fAiroVutbPr7lLH5GWFCEbe7mjdxerZy2cZEdxoqP9s5jjXjPwwtf?=
 =?us-ascii?Q?pyUrzUoRGV6bjc0fCLn3hspfFCHv883cULNjUsB8yi7IxXGsjMV/brAxPOP0?=
 =?us-ascii?Q?pZq5NBQkLOwJE1jSZS+Q/lizHBv/g0Yce4DQKspXP1XbyljI2urTzSytZxKQ?=
 =?us-ascii?Q?hKN0GEyyo3+CCpMuOXjCnIEXvTHsj72nmABOrVU8LIuRA4PKWhRetHdHYOTY?=
 =?us-ascii?Q?NUBLtf1fihj3T9KzzmipFEZ72nuf3RJVoPOMfFFvPJSz0AyMq979k/0sKN8c?=
 =?us-ascii?Q?sn8TJeqzb+SNnxXpSGs97K9G11zV4V3HyosM29yf2c6XQVj9E9jDn4NWZM7r?=
 =?us-ascii?Q?4+oWAbY89VptzLusx+b3FmI/damBJx8jg5QETCpNA02xSmpTFix5E5i9awAQ?=
 =?us-ascii?Q?giCXyaeK5iIIitbtfZ5OmHzg+yneWkzm9/E4aZnRlfs4UYLVj7rCiy2uL4PW?=
 =?us-ascii?Q?Pq46MY44YkuPBo3GRJVngF6q6e650CZyYdaLhNXjrwOyOnBZdyqLBpJhtND8?=
 =?us-ascii?Q?bCbG3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SKgY46yj6YXFFT2MN9wKmxwuytPjca1NfVyCHiUNuAyVWl5+ivYFEpp/nwmpSeKqJnmWfcQ8uVwNhRAaLUtUtNftODGBra8btqZncPiQtRb6bqlypVHA5n1tByMOQu9cxJRpANQV/bE5h8816nynWyOJwpwlw7UmYy2SMq56nsaL2vJs5Lh5N7n99FPGHeUWwBCrgnC83WB3H5zGTrLwTauedjuaBX8P8pALPAg4N+vRYiU9HaUgJHkAxvBXRKPdUAvXlXzpo+Y11WB8L5ktKCCTY3/992602vyYm+k61GksLIbTOu82Gx8z1uk/kRqLxcjyrVXpC3xJMGou7EEoeKF+5iW57xS9t4oHz/mwiPK9b86EJzetvuM6bJ/A7mafraHSM7wu2+MgAiDr4Z1aR5sdOtKYA4R02AulrXG99cj+IuJmb/CQJ5X0mvEA7ly7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:46:52.9113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8967adc4-c95c-470d-961a-08de68358068
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 06, 2026 at 02:48:13PM +0000, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Add support for allocating IOMMUFD hardware queues when VCMDQ base
> registers are programmed by the guest.
> 
> When a VCMDQ BASE register is written with a valid RAM-backed address,
> allocate a corresponding IOMMUFD hardware queue for the CMDQV device.

Let's mention that this is because QEMU doesn't trap VCMDQ_EN bit,
which is a part of VCMDQ_CONFIG register accessed via the mmap'd
page0.

> +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> +                                       Error **errp)
> +{
> +    SMMUv3AccelState *accel = cmdqv->s_accel;
> +    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
> +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
> +    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
> +    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
> +    uint64_t size = 1ULL << (log2 + 4);
> +    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
> +    IOMMUFDViommu *viommu = accel->viommu;
> +    IOMMUFDHWqueue *hw_queue;
> +    uint32_t hw_queue_id;
> +
> +    /* Ignore any invalid address. This may come as part of reset etc */
> +    if (!address_space_is_ram(&address_space_memory, addr)) {
> +        return true;

We should probably check addr and size - 1 + addr?

Nicolin

