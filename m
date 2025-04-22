Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99508C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 12:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7D3y-0005v2-Nq; Tue, 22 Apr 2025 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7D3v-0005uU-28
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:49:19 -0400
Received: from mail-bn7nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2009::609]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7D3q-0006rb-VX
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irvqIA7sTo7nH0/zM2nkeVqkEJlO0/p5PVCHzEIPlVFyr/VBOrjgGwdJy0pAk4/cg+UqmG3ob2rCHzMBXNcwYFZSkGASLI7VtnJl2CrVrTquTUTy3a19zQNAAQyZqG415diuvi0s7FgbYLBTcCgzE0M+zJPHt9HW9OmlMEVnjbOJ62/a29pb0qrKIzTOwCk5cphSvHOQJIwPXeW0N+00V/2ZKXXbmVXL7eZ0nj54Yq2CumUtRmNFpjNJJgeTnQwQj1t2xrxa1MrOdaqBotXsPMEoQH64wbXX97CgWkXmfXGXxjBCMujOtYww2cb9J9Trb99NWRDPUYP4etjRKncisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQYl8o/8ermjk4F1Bnt4V6fCeW2lkZ98t9ojDHPIkFs=;
 b=PBWfF1h/cX89wiCH3wRZkZzDgeuNd1nzKX24Zxl8pehTJQoCcdYxeQZmDY08zug5Ci4C7B3u6NndsfrDnJPARVf2S0A68Oq8bl3jba/4XgjUJrNquqNZqMRt7SfF7xxv+p8/Z6X8q/l4lb6dazU6j6ifGsNeQzKKO6tL7XnuliSdVstYolL5noNR3cBOTXc7Bb5wKeK7CTq/EO2rDOcf1/4Xz1lzTazODoAlp8CjHiw8j8CK5j81L1+MOp2D0AYT9YtN34vLRMNNiIiN3aP5ykRk/u5lbwW/ZT7wxxvMqgVFKLSAvd259FUuwunz+T5GaPHj5n9u4xirHmNsXgJmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQYl8o/8ermjk4F1Bnt4V6fCeW2lkZ98t9ojDHPIkFs=;
 b=16EwodDPogJLQK9Q2mVhVQTszbW07Ub/xO3u09Sd+tKZtUZ2zFZ/a24Y5TO7Hkpv8Ll3jHfFYdO2wzEmYaLLiUZfJ1Q5xNdl4BfdAZFJlvrPql7YClU2pazXDITd0atUQ44h58gsfsvMCIGVtMmWG8fzzyw+Qr00OcYwyrZPcl0=
Received: from CH2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:610:4f::13)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Tue, 22 Apr
 2025 12:49:06 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::9f) by CH2PR18CA0003.outlook.office365.com
 (2603:10b6:610:4f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 12:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 12:49:05 +0000
Received: from [10.136.47.77] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 07:49:00 -0500
Message-ID: <ead40e48-868a-4ee6-a23e-ee11e1047880@amd.com>
Date: Tue, 22 Apr 2025 18:18:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] amd_iommu: Toggle address translation on device
 table entry invalidation
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-15-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-15-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 695eebfb-ed96-474d-f9bb-08dd819c10f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEdIWGFhSHk1TFUrMFBCWFNlSkV6eG8rNTNiUlI0ZjZydUUyeXZQdlR0clJs?=
 =?utf-8?B?ckRHRWJpbVROdmZNM044NmRLQ2VmMmp6aTBlZTVPclRYTU5LVTlmcmRFM2Vm?=
 =?utf-8?B?OW52WDNSdXhPbkM5cGViNlFWbWVldklqemEzbnNJZWRpUEJ3V3BBaGNOWGV5?=
 =?utf-8?B?dUZoWWRaYkpPN28yQVhaVW40TmpyS3dzc09RT0RkbjkxblVoRFlhRzVUOFdH?=
 =?utf-8?B?UGlpNHhOWnZ6ZXRCTE9DbkpvWU5LaTRPL1JzM3hNcFl6c25VYWszR3lKQU02?=
 =?utf-8?B?QVMzYVcxOWNIWFNrK0NwR3B6OGlOVWx3aEJOUmVCSXVMaWhSWHZ6YUszN3Rv?=
 =?utf-8?B?OWhMNDFDa01RYlNpTkNRZWNCRDE1YmN5Yjh0bUdQOFB3ZmxSb1RVYVlyZ2xy?=
 =?utf-8?B?V2RtT24zMk5taE1Ha1JXYUdwRTRrcndieXdkNDhQYUpCdksyOHBRU1dETXhh?=
 =?utf-8?B?bXZtSm9BMkxBWTludjFFSGtZQm5Scm5xdW1wdUx3VE9VaWdzMEdld2RoN25W?=
 =?utf-8?B?YUFiY1RNRlJ4WVFvaE16c3k5MHl6YmdxMWt6cEFGbUIvN1VhOC96alVhd2Nj?=
 =?utf-8?B?b1dSaGtHdHp1Z0tzRFpickY0NHBUR2dYd3pkdHdaYXdONkU2WlRNZ3RmY2Zn?=
 =?utf-8?B?R0hvQ1cyRGNqdCtUUi9sKzVZbzNSNlVWZ2w3S0FRNGNIa0tSbHpOZzNRd2ZQ?=
 =?utf-8?B?WDgzc1hMdGtha0hBaGczUGd1K2w5ZzhTVEd1VHh6enhSRjFUMnZKVVlwMko0?=
 =?utf-8?B?Z1R3WGtsUm5OdGZrNGo1Vmk0UHYxSjhlUUx5Z2UzUWtjVW5qVjdhT1ZSMHpE?=
 =?utf-8?B?OUgvbnQzdnVqMEc0ZWw1c0JNUzlyWkhNcWp2STkxNVh3L2RzUGpPVm1OQkY4?=
 =?utf-8?B?WVVpUlhSRnU1VVY1NmNyZGpWY3pLZ3dsNGhRcEFGOVcwcE5PclpxOUl1ZVFV?=
 =?utf-8?B?T1F4UlhPdC92RllSeXBZZzlDeVRWSzB2WnBCcVFOeVJ1RW02M0lZOVE3Wmta?=
 =?utf-8?B?b2ZLd1ZLV0J5M2x6d21jVk41UTNPbXFRdXNxQm82WmRIdk1wMjExMU84dFBo?=
 =?utf-8?B?NnJsMUhsTGwxRkRwYXU4OTkrbHBBUCtzY293L05hSUxPYXY3UEtzVjA1M0ZW?=
 =?utf-8?B?blRHRTYzUzVzTS9BTUdMdGJJempIWElha3g2YitDdHB0b1ZDNFFUQ1Y4OGkx?=
 =?utf-8?B?ZnF0Q0tSN1A4MXlTQVpxU25tTWJ3UjdtTmQ1Zlo1VHQyckR3UXdjTzRld0lZ?=
 =?utf-8?B?R3F2aXg2ZE8zdlNCMGsrWGhJWkZuVGE1SGxjRUlPY3JZUHVZc0J1UExYNXNx?=
 =?utf-8?B?bnpKdjIrSm5kOWlCdzRFdUk2Ulc2UTk4ZDg0azZaQzhKOWVrcGFPR0ZmejA3?=
 =?utf-8?B?Rkl4Tk9oWk1tdTl1Tmphc1FqNXBIa3MrcWdwVm41NW1Vbi85WjN1K1NJTlps?=
 =?utf-8?B?VUExMU5sekxHbmdYQ2Z6aElxeTNCdzlvVDBFcGM5YzIwU3N1c09IWDJaWkkw?=
 =?utf-8?B?S3ZsK3ZjaVVjUFFWWVBmMy9DNk1HS0dXVVJrSldoT0FYeWVtci93TW14b0FJ?=
 =?utf-8?B?eDZaUkI0dDZ0UUViTEdMQ0dNU1Z2SE5aY1laQmJBKzI3b2NZd2ZkV2hTV0lJ?=
 =?utf-8?B?TUJhVUpjQkRiT2lVU2djMkROeVBPb1oyS2FVOHgvdFJGNnJoYWx5ZC9OeVp3?=
 =?utf-8?B?c3cxRkNaRkg3cVc0cGt6ck5lV1hpZVJ0aFdnem9iZUtMcjNwbUJycVppNXdF?=
 =?utf-8?B?RS9KUi9IdnpQcEhSNFVaTFhFcGRFWjBUWGt2T2hOeU1qeDdiUzg3RlZia0Fn?=
 =?utf-8?B?UDFDS3Z2YU9vSmRYWnkxSlB1TjNFZjFsdEZvbSsxOUJ1c0N2VWJNaXE0RDdM?=
 =?utf-8?B?SWUwT0xsK01OYzQybEpreEd3NDhSeGhwZkNwRmxabnZNSTNKY2hDMGpNL2sw?=
 =?utf-8?B?OHZMSFRjK25uVTlLNWdZemtPZnYzS3pFeVd0RzdwcWhMVE0zZUk5MmlmR0RZ?=
 =?utf-8?B?QVhkUUJiaURJZkJEVnI3VVh6K0JHb2NCL0pOUWZDdzBUdzRyY0RuWlBMaFZm?=
 =?utf-8?Q?efGgYN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:49:05.5527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695eebfb-ed96-474d-f9bb-08dd819c10f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
Received-SPF: permerror client-ip=2a01:111:f403:2009::609;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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



On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
> Device Table entry (DTE) e.g. after attaching a device and setting up
> its DTE. When intercepting this event, determine if the DTE has been
> configured for paging or not, and toggle the appropriate memory regions
> to allow DMA address translation for the address space if needed.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 68 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 3bfa08419ffe..abdd67f6b12c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -101,6 +101,8 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
>                                                  uint64_t *dte, hwaddr addr,
>                                                  uint64_t size, bool send_unmap);
>   static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n);
> +static void amdvi_address_space_sync(AMDVIAddressSpace *as);
> +static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as);
>   
>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
> @@ -432,7 +434,15 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
>       trace_amdvi_completion_wait(addr, data);
>   }
>   
> -/* log error without aborting since linux seems to be using reserved bits */
> +/*
> + * A guest driver must issue the INVALIDATE_DEVTAB_ENTRY command to the IOMMU
> + * after changing a Device Table entry. We can use this fact to detect when a
> + * Device Table entry is created for a device attached to a paging domain and
> + * and enable the corresponding IOMMU memory region to allow for DMA
> + * translation if appropriate.
> + *
> + * log error without aborting since linux seems to be using reserved bits
> + */
>   static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>   {
>       uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
> @@ -442,6 +452,62 @@ static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>           amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                      s->cmdbuf + s->cmdbuf_head);
>       }
> +
> +    /*
> +     * Convert the devid encoded in the command to a bus and devfn in
> +     * order to retrieve the corresponding address space.
> +     */
> +    uint8_t bus_num, devfn, dte_mode;
> +    AMDVIAddressSpace *as;
> +    uint64_t dte[4] = { 0 };
> +    IOMMUNotifier *n;
> +    int ret;
> +
> +    bus_num = PCI_BUS_NUM(devid);
> +    devfn = devid & 0xff;
> +
> +    /*
> +     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
> +     * been allocated within AMDVIState, but must be careful to not access
> +     * unallocated devfn.
> +     */
> +    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
> +        return;
> +    }
> +    as = s->address_spaces[bus_num][devfn];
> +
> +    ret = amdvi_as_to_dte(as, dte);
> +
> +    if (!ret) {
> +        dte_mode = (dte[0] >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
> +    }
> +
> +    if ((ret < 0) || (!ret && !dte_mode)) {
> +        /*
> +         * The DTE could not be retrieved, it is not valid, or it is not setup
> +         * for paging. In either case, ensure that if paging was previously in
> +         * use then switch to use the no_dma memory region, and invalidate all
> +         * existing mappings.
> +         */
> +        if (as->addr_translation) {
> +            as->addr_translation = false;
> +
> +            amdvi_switch_address_space(as);
> +
> +            IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
> +                amdvi_address_space_unmap(as, n);
> +            }

Hi,
I think amdvi_switch_address_space() should come after
amdvi_address_space_unmap(). amdvi_switch_address_space() unregister the
VFIO notifier, hence mr->iommu_notify list is empty and we do not unmap
the shadow page table.

Code works fine because eventually vfio_iommu_map_notify maps
entire the address space, but we should keep the right ordering.

Regards
Sairaj Kodilkar

> +        }
> +    } else if (!as->addr_translation) {
> +        /*
> +         * Installing a DTE that enables translation where it wasn't previously
> +         * active. Activate the DMA memory region.
> +         */
> +        as->addr_translation = true;
> +        amdvi_switch_address_space(as);
> +        amdvi_address_space_sync(as);
> +    }
> +
>       trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
>                                PCI_FUNC(devid));
>   }


