Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D7C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 11:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u519O-0005yD-Aq; Wed, 16 Apr 2025 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u519I-0005xu-J5
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 07:41:48 -0400
Received: from mail-bn8nam11on2076.outbound.protection.outlook.com
 ([40.107.236.76] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u519C-0004d5-1U
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 07:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYUBXoizg2842rkC5vrlYs8bZ9Anlh5aHUEOYYnuqjFQHrPhoxKVhzzuhaIg2Iy7HkFBepgEp0zWFGcaeS2GowcSJ8/pTpp60B53ACGHibWxBUgjKLHA1xEr9/Uv3MXzsVUDUM+Prt2rBHyF/M1s/n7Y7H2jSyD2EJ+eIg6E8qqRdGioiiZe6H+5DS8Hpke6ZgCkGmrUcHpruL48zLULaSVCoyGpg0ozNjYrpJW4Y6V74ATiUszHI3V4nF/u4RiLH5+ALtCrNrjYMEz9Ig4gq+FNHCWi+cYVbO8X/JDbDHn6YD7LJMFfNEpCc+LmyunxLzUw97jYuW0rklmXUXcF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0jdL/OMQ24hQ6eX/yJK+gebGw5lrSZqoif5mko08xc=;
 b=PGjoyYyDIx48jnjle/OPEG+xstbdl4WGVImXx7RM4PSQ4mC3nKpbMx+4geJlzwapWlN0PGT67WwB+rHENsEmM0vkC00OL9nBf0N777wkXCt8ywbhVeCqL34hWOh0EaSBuuT7SPD05X+UDsQPmzPQ2poCWMK52OzsC05J9snzyIva4Uz11lHMtLFNu1OF176W8+R4OMfi8BAh7uU7RsfFaoO8PWD2+cUfzL059ejshuWGFJkQfG+reXJdTFvYQaDMhFaAlL6qLAP1ULFYzBUMixauRn88CbwZHHsmgELSNATORllH1LzZNtZFMPzMNOlIxYK/SRjCiVR5VaM8hj/wJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0jdL/OMQ24hQ6eX/yJK+gebGw5lrSZqoif5mko08xc=;
 b=bTTbcCCJvdBFXCh4B3yBEQ3r4uYXSi8OTlJWS4ZhLrBWs6jzYWCgqopgzDTdf2feYREhtpnhc3ePHeDvsb+dg6SIYkOBL9V5OVpJWyVY6YfHndNkMtnJt/TCh156P7FQkNcGs5wj88Cz6d9B0PU948M1ozPJy0jbD8B+nEyBf/8=
Received: from CH2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:610:54::31)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:36:31 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::e4) by CH2PR11CA0021.outlook.office365.com
 (2603:10b6:610:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 11:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:36:31 +0000
Received: from [10.85.32.54] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 06:36:26 -0500
Message-ID: <4a7a8eff-dd21-49b7-9d2a-449ae0424eb2@amd.com>
Date: Wed, 16 Apr 2025 17:06:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] amd_iommu: Add helper function to extract the DTE
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-3-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-3-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 7023f881-3c40-4546-2d46-08dd7cdaef1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkZYYkwrZFhzK2c5dHJGSVJuQ3JveTBLckF0b0RVVDl0S0JEbzhMZmJLRXBD?=
 =?utf-8?B?eE93cUh6ODE1cEFZYnRMTHBxM3ZmZXFtWW14QWFGT3hZMVZRS3Z4bDNpYld3?=
 =?utf-8?B?L0xNOU5xTDV3UlgzZGREWDRVS3hoQVhSbUhoVzMxanRlMDcySFJvN1FpdzY4?=
 =?utf-8?B?WkdwQjRJZGEraENCZkt6S2NndlorY3g5NGxrWnY0bHlaeTUwd1VHREJpYU9D?=
 =?utf-8?B?cTU3K0Myd3pZMTVwMzJHZUVPaXBCUTM5NnVsMUJuMWNNYVJPSDdkb28zbkhL?=
 =?utf-8?B?d3VXbjZ1ZCtKRFN4NFlxOTdyY0dMMWF6akQxS3k2R1VSZHhuaWNvU29zRE9m?=
 =?utf-8?B?WEpsb1pxOFhOVXlhL2YrQ0dlK0kxaTByR2MwT3N0UllENTBnUEF1VGZ6ejZ0?=
 =?utf-8?B?OGZ3ejF4MXZYTEs2a3hhT3JnazFQWkdBZzdtMFR6eEh4V09wczk3SVhKNE9q?=
 =?utf-8?B?R2gyNmlCZm8xY3lxbEM1Q1JSOHZvOWZYMVBDY3JrS2lKdVZZUGVKVm5ia0d6?=
 =?utf-8?B?WXZZL05BUFIrMVJhS1ZON2o5MkhCMG4rdkh4am1TSGkvYU5mdzY2Z0pFZ1U3?=
 =?utf-8?B?MG5qbTFMOGNWbjRhdzQ5NFgvZmFSTFIzZWZQL1V2YnR4ZENGRHFMZHhHSDhL?=
 =?utf-8?B?WmNaVkNGU0hKME5ORjhsQjJFUHQyR043TjF4SUZRd3EyWlRVbGhhMGNHWnVw?=
 =?utf-8?B?TGVjOEQrSGZFdVJVRXJTVWVHNUd6RWNZWVcrWTRuWWhHNTNQQUFHZTFEdTlN?=
 =?utf-8?B?RWt3OXYzV3V3MFdWL250NDU5L2dWZnNHelQ0eTkyV0hhZDJMa1NaMllmVUhj?=
 =?utf-8?B?TXVZMnBDVFRIRkFRV3MvMFYyYWoxWGprM2F5TVdORHI1aHgySjdhb2puTW96?=
 =?utf-8?B?Rm9tUVpPZDlYUnVqQ0FhbElqSUdtN1VyeHJrL0ZKZkdjT3dFSE1HaWpjRjdT?=
 =?utf-8?B?QnA0cjdUTHU5QkxpWTRabEhPWlZYOER6M0IvdmNVYThhSHhCUzVudUxBVzNX?=
 =?utf-8?B?Q0V4aTVtQ2ZpV1lackZBN2lNcHhGbTBacUdyV0pKRjFEcTFkdGI3SU5iQjIx?=
 =?utf-8?B?UGo1K3ljWExZaUZRM25rKzNBZDdFb0c5ejk5akJPSFN0cXB6TE1CNERZQldy?=
 =?utf-8?B?SVNrRU5oREdVQlBIWk5YejE0Q3ZSZU1BdkRVMG5oY1E3V3VSWUUrYVJnRmRn?=
 =?utf-8?B?MHNOYzVpSjhmWXZyYW5qbWxOMHJCSTRIUFRaSEY3bS92QTVIc1NLVGY2QWkv?=
 =?utf-8?B?MmtvMitvUW9HSUhudjZabC9VUVdYRUw5RVpCaGlQaHJ4MXZtd1JmYWZydlY3?=
 =?utf-8?B?MU5CRzVYcVN6UG5hcjhXQnhlMDZFczdYaDQvL2dBendLK2NXMkZldUN5ajY5?=
 =?utf-8?B?MW84aHFvb1M2eElDQVlVL0NSWGVWeVpSZlNKOHZsbG5ET0lxdGF6dXpSOWlT?=
 =?utf-8?B?Kyt3dmdCaktoK1pWT1g3V21JaEVmWjFsOVQ1c3hBOGhQUjV1WE15S2svMVhk?=
 =?utf-8?B?YUxzSEFGSVRHUTV6aXRZR005eVJXQU9ERExrMlBkY2h3b2NQdW5xV0kxUmx6?=
 =?utf-8?B?dFplSnluNE5FaTVUTHpLZHhnTERzRUlxQko4TU83SUtHRTBLN2RZOWFGZ2Fq?=
 =?utf-8?B?S1VSaGFWcVM0VG1KTzVveG9SVmpyQkU3ZUp3RHQvZEZLZm1VbDV3ZkFrZTRj?=
 =?utf-8?B?TGNxOXI0dHdqSGw0bnVJTmRyeG51VnhMcklrdmRzN3ZRQTZ6REFEQmZTRnc0?=
 =?utf-8?B?VXNUMUZCN1VERWUwSjBiNGFXNFdpSTI1TGt4RGNHSXpEdXRRMkxldnVYM0RG?=
 =?utf-8?B?ZFlJNDlXLzB1d0ZNNWsxclZBWWZLb0JVYm9vbWNUekhPdnFpUVB3SnFOU2ZH?=
 =?utf-8?B?UmVtbWdYQk9pbXZ2SHl5dzlqYklQY0ZxY09Kb29UMkh6aHVPWnBHOHBvVWUy?=
 =?utf-8?B?K2Zrd2d0SURueXhKNXRIOWZmakYyQm1YMmZsZXdRUUpyVHlnazRDaHNJSC96?=
 =?utf-8?B?ZVI0a2xJaWVPY2RvbnQ2TUd3S1ZhVTAwOFg4biswWWtrQXAzcEhmU3Qra1Qy?=
 =?utf-8?Q?0k3KVP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:36:31.2300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7023f881-3c40-4546-2d46-08dd7cdaef1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
Received-SPF: permerror client-ip=40.107.236.76;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Hi Alejandro,

> Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
> common operation required for syncing the shadow page tables. Implement a
> helper to do it and check for common error conditions.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 5f9b95279997..22d648c2e0e3 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -77,6 +77,20 @@ typedef struct AMDVIIOTLBEntry {
>       uint64_t page_mask;         /* physical page size  */
>   } AMDVIIOTLBEntry;
>   
> +/*
> + * These 'fault' reasons have an overloaded meaning since they are not only
> + * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
> + * IOMMU specification, but are also used to signal internal errors in the
> + * emulation code.
> + */
> +typedef enum AMDVIFaultReason {
> +    AMDVI_FR_DTE_RTR_ERR = 1,           /* Failure to retrieve DTE */
> +    AMDVI_FR_DTE_V,                     /* DTE[V] = 0 */
> +    AMDVI_FR_DTE_TV,                    /* DTE[TV] = 0 */
> +} AMDVIFaultReason;
> +
> +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
> +

No need to have this function declaration as it is a static function.

>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -882,6 +896,28 @@ static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
>       return true;
>   }
>   
> +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
> +{
> +    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    AMDVIState *s = as->iommu_state;
> +
> +    if (!amdvi_get_dte(s, devid, dte)) {
> +        /* Unable to retrieve DTE for devid */
> +        return -AMDVI_FR_DTE_RTR_ERR;
> +    }
> +
> +    if (!(dte[0] & AMDVI_DEV_VALID)) {
> +        /* DTE[V] not set, address is passed untranslated for devid */
> +        return -AMDVI_FR_DTE_V;
> +    }
> +
> +    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
> +        /* DTE[TV] not set, host page table not valid for devid */
> +        return -AMDVI_FR_DTE_TV;
> +    }
> +    return 0;
> +}
> +
>   /* get pte translation mode */
>   static inline uint8_t get_pte_translation_mode(uint64_t pte)
>   {
> @@ -990,6 +1026,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>       uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>       AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>       uint64_t entry[4];
> +    int dte_ret;
>   
>       if (iotlb_entry) {
>           trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
> @@ -1001,13 +1038,13 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>           return;
>       }
>   
> -    if (!amdvi_get_dte(s, devid, entry)) {
> -        return;
> -    }
> +    dte_ret = amdvi_as_to_dte(as, entry);
>   
> -    /* devices with V = 0 are not translated */
> -    if (!(entry[0] & AMDVI_DEV_VALID)) {
> +    if (dte_ret == -AMDVI_FR_DTE_V) {
> +        /* DTE[V]=0, address is passed untranslated */
>           goto out;
> +    } else if (dte_ret == -AMDVI_FR_DTE_TV) {
> +        return;
>       }
>   
>       amdvi_page_walk(as, entry, ret,

Regards
Sairaj Kodilkar

