Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA31E94622
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 23:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpaXh-0000Py-A2; Mon, 09 Feb 2026 18:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpaXf-0000Pj-Cs; Mon, 09 Feb 2026 18:19:43 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpaXd-0007nZ-S5; Mon, 09 Feb 2026 18:19:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSDPgF32WyGfo5ovSTu7ThtIvdn9b/18mEiYWGXbdSlffPw33ohmlbvDfP2vrgC8Uwu4m7U0t46U3Zaqx6pxVMZ6qg9FKZ7/SEeYTYUwh52xrjstRNP809DKOym6RGQg0gEeXAEH5HRnPj3cz+gUZrQCn0Tvwe16H8BvmwD+Fdo8VOVWit21NoqAYaveSXM76zWueKNRmcVoOekSkP5FSnLX9F6E6mj/ojg8oh1vXsAcZD4HOw2YXJlgCxAg5PUkOYzTmH9XyPciltZLQxD20EW6KkRJ6R3G4DpURJ56HkoBn06957L9MtH6MjxoNyE2mmtF3QWLB5SxW/eiUFIB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN1IPLukgiQhwFdhU1nPHn1GhqU8jKGICIytEf/izK4=;
 b=gdB4iY2hhojYMd1LGMH5+QJz04FhqGaXwTwISiCpBCfMsmVYFIefsqc52apLU38e0PgJDbHX8XbwWY3VFpfw5bZuCUjAtI+7T3FfZG3q1u/2y4ME+ogkjIZl7uBwOaO7MHpsND7povQVjDzTKkZRodbRWcNCgFGGMsJSoj4EJ260qdHf+97S1e8ucKCsGQefD7k8jWUbdWLsmt5Aa7frE0BdNEPzDIrbEM9mOG2Vr/UAtzNMnBShKQJotrJjNsUiMuL8fj+R6ghNGCKVCoMcomcTFwstZpC8yy/Cv6a+f86ThNchBRNR/GqoECAE0km+excZMsqGwTikeMRWovnKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN1IPLukgiQhwFdhU1nPHn1GhqU8jKGICIytEf/izK4=;
 b=et8jvXnWK3XEba4cuCeA6hbvXeBqr8BOhn+jUjBk/Y6hzyKTsHbY5M9CQrPCafewUA6s1IMftO4M5KbSR4FBVu1loYdbG9v27jKKJ41qDvvc3UGHyq1i1Q0lhMJmRSMrm2NQboDtEMZFkYk6hgcCDkkTSWoODSNUE5yRHwBU08a/jLwxOHXBanekwWvzPehM4VdeICDJpnWaSfBffNHHyIX8OgcGavRWR0LZasQCp1sNlH+imT2y8frTFJ10Z3Tr+6308Y0TTxZahWbIpmvLC3eBD0in4S1jesYi05WolgrOPvS7A4v8Qj5HNhskHToWKyOR4VNnYipJINY4pmTGLg==
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by BL4PR12MB9722.namprd12.prod.outlook.com (2603:10b6:208:4ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:34 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::d7) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Mon, 9
 Feb 2026 23:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Mon, 9 Feb 2026 23:19:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 15:19:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 15:19:17 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 15:19:16 -0800
Date: Mon, 9 Feb 2026 15:19:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 10/24] hw/arm/tegra241-cmdqv: Emulate global CMDQV
 registers
Message-ID: <aYprcoyITz1GuPbF@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-11-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-11-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|BL4PR12MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5329ec-6950-442e-4624-08de6831afce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AbuFQD9wRhtpoWistvf+XOLMTz/9meBzhyvP75oOt8xbx3JQXYahqO2o3Z3a?=
 =?us-ascii?Q?EVCpwsj9DLhUEveugmNuzjeXK5t0If3twceA54XIBM8tHP4b9Y66ntndizHu?=
 =?us-ascii?Q?f1pjREIRNfH+RUuYN9FrZrhpqz0DiK8ROkrn8Rl2rArZfZQwqCwAjZycvHlW?=
 =?us-ascii?Q?S4YJPrhYMGQrq4koGPT4RQhAld/ZbaO08T8cZNw8ifBzElNTUIgBeTk7dqAI?=
 =?us-ascii?Q?VolyUvrdLizT+X0hEyXUNBfJy4lqAXTY5qvdITs6uEStT3hN0TnR56LJX0a5?=
 =?us-ascii?Q?/otB2Lgp0lf6+vAA1jtuEbHIZSXB76uY5pd0qcLX35enBrxXXkRSng+eylxN?=
 =?us-ascii?Q?iJGafEOJZUL1s9C3hXKuUeiGWE/RUr8AKlEpupMwjItLIOGtGqbP36P04GhM?=
 =?us-ascii?Q?dMvUuB/a5SY1bl+qNTjkTnmTKybHj5LqAIJxN9qeXaZ48XLiGxMSuIv2XWtB?=
 =?us-ascii?Q?zp77JXq3ybXQEhNOPqV88pnAYxWB7aomIoltXuj6UAwN22zhox108lUDa1EV?=
 =?us-ascii?Q?qp1yDWXlu+LnGr/MMeop/9Fj9OObsqgSJCfPef7abn6GlBHoe1ZBkLY2AZP3?=
 =?us-ascii?Q?3/svswXCIeycmiqsorCbiZxpRpdRItvtGe+AyilhW5lEpMPLRbxBvLYsKawE?=
 =?us-ascii?Q?mx4hL8PC/BRei0yaXlf77HfKhpm2xmQzxo2Ozv2Q8DhXKkAP5ySrXtkevkQ1?=
 =?us-ascii?Q?unJitQ8daIYwqlooKTM9jAXm1r/NPaYVlz3m9UDXM8B8cNbwFPfbpAJ9pFHO?=
 =?us-ascii?Q?CGOsKXWiRqE60mWyE9WxwawUtzzzaZ6euo3Dr4NS1Z7ch48b7u+JJT/NOhoa?=
 =?us-ascii?Q?lVVYC3OPHvNj6IEWbInFVTPfFi6GroTnS7rjaUttZTLsHP7FUmi8eKh0kmpe?=
 =?us-ascii?Q?tHKJyD5+i4pWXDUoXu86B2VumTf1KOO2NkrSECVhkvyJjoKrkiOIV86RhPv4?=
 =?us-ascii?Q?I3z+eYKUrPmwpPx/ujPtuAV7vL9tlBOXsJspmSq466rcVozXz1J1TVFmKJ54?=
 =?us-ascii?Q?WXhauxxUjzOXV84MHFCUHpyTFGhjyt/gGDDe7MkOMTFQPHetISM4aoThqDXS?=
 =?us-ascii?Q?sJ2snue7ImGvogdqZxXEMzSR/sfHdz+tkke5fw4If2jcxZn+4XPLXrJpr0Jn?=
 =?us-ascii?Q?BGnrrG2piEY+0ZVNmlN72A82iG32zXqd+tSzoyFbVwQSZpPHO331dfRpPMUr?=
 =?us-ascii?Q?5LbDV5mlcGZ9TC/Ggrh5PElGKb/FOVDG+nOUxzk5OxDvFMCNRQr7fgm8fAp2?=
 =?us-ascii?Q?jy1zq0SstLBZyXyubGsstVbJDFZq0E62yJD3ifbsFj9Pf4i4TO4QmL0ZRZ94?=
 =?us-ascii?Q?3Dp+Wm5G78Re3RnXkFh8AIjkVN+vRPEKb2URDTExKMJMKsrKLJDDuQhhb084?=
 =?us-ascii?Q?zzXdjbRxNIscItS08t+wNyx1fOTg8khuGlnbSxdzFX2dBeIFpVLSOO2nd36Z?=
 =?us-ascii?Q?6In7U4mWvrOo5XW11lwuTAoPM0ry7DXDdzhyNIFlRdKI8v62bz6+j4ZvdbqY?=
 =?us-ascii?Q?Gb4EtUpFInVQWfIC2iqsuvieAzUCtBJJhsSsKTW4dj6Nns70gpoi20PVbYzB?=
 =?us-ascii?Q?T0EhlF10Y72PeIfscL2vpsv9Cul6ycwOOs+ck5ntBzqUKX8LSoMNboigEu1y?=
 =?us-ascii?Q?XpwxAfp7x20QNu2QOEgC1cH5/WzJc5opip/0vwPwZP8lnVFzB9pnuhRZZrGh?=
 =?us-ascii?Q?knDJyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1DB1eeaYuG3hVV7RY/K+zJoserchfD7kHRQ3ITnU/HFFOejQMQq4IXTbctxez3snagI++fHdLHsNRSP9GC2/HnNBKC0VlUeR6QPWCSZNqO0Y0jdtQp/nZM0qNpU9VWvTbw0Km9nSnt5VX+Zf+yUFgi7cRreZ/WiA0vO8p11iiPSsWDioLwZ1WbY0uj0fKIakdRdoUwt2OC182AW/WZCp5nik4/T7wSETff9iMGEBUj8KOwsZf6pBPiyzHw7UuF+MziHMthaZ7H7DLHARPXYjP2fIHLbcXkOTk3DS0k+ECxs0FyYKng1IGn6nRJsUI8UK+p3BoRvRi1M4sDeyqbLiC3fDfl0ri8lAsvgB7VwBFAopUb7h9ymUsbRBIlk13iqy9vo+gK/IhF+50T7v8ZWTbUdQfsaDl3FDsEorhrAQ4weHPOyD8mJDZwGA0qYV0Lmi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:34.4048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5329ec-6950-442e-4624-08de6831afce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9722
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 06, 2026 at 02:48:09PM +0000, Shameer Kolothum wrote:
> +static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
> +{
> +    int i;
> +
> +    switch (offset) {
> +    case A_VINTF0_CONFIG:
> +        return cmdqv->vintf_config;
> +    case A_VINTF0_STATUS:
> +        return cmdqv->vintf_status;
> +    case A_VINTF0_LVCMDQ_ERR_MAP_0 ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        i = (offset - A_VINTF0_LVCMDQ_ERR_MAP_0) / 4;
> +        return cmdqv->vintf_cmdq_err_map[i];
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return 0;

I wonder if we'd still need to implement VINTF0_SID_MATCH/REPLACE
registers as it's a part of HW spec. They don't need to associate
with anything but register cache alone to support MMIO.

> +static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
> +                                       uint64_t value)
> +{
> +    switch (offset) {
> +    case A_VINTF0_CONFIG:
> +        /* Strip off HYP_OWN setting from guest kernel */
> +        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
> +
> +        cmdqv->vintf_config = value;
> +        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
> +            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
> +        } else {
> +            cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
> +        }

To emulate the HW perfectly, VINTF_EN = 0 might have to disable
the VCMDQ feature, i.e. deallocate HW_QUEUEs and munmap page0.

Otherwise, guest could continue using the vcmdq "hardware" after
disabling it, which doesn't make sense.

This means that HW_QUEUE allocations would have to be delayed,
until VINTF_EN=1 and corresponding VCMDQ_EN=1.

> @@ -59,6 +129,36 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
> +    switch (offset) {
> +    case A_CONFIG:
> +        cmdqv->config = value;
> +        if (value & R_CONFIG_CMDQV_EN_MASK) {
> +            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
> +        } else {
> +            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
> +        }

We'd need to do something about this as well. VINTF/VCMDQ should
not be functional when CMDQV_EN=0.

Thanks
Nicolin

