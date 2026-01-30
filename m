Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DA1D49C6B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 08:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljWP-0005bK-SF; Fri, 30 Jan 2026 03:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vljW9-0005WT-0C
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:06:14 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vljW6-0008OL-EF
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:06:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVUD7yZoiHD/wS8Zv2MoyNiiAm8rYJ8arNSZHSq5qrboywEvDEmzULsdYf4LpBnNHIAhsGbcWizfbvEhjyCNXCggXDHymvyLLKFnK3CB9I6HyGeMSc/ris3fpeKZOkA80YQPSDAAL9FBSiF7M3lQK9hYL+SN+48y217Utxpbdp1ta6NiJjelpi+GohxCZjGSVfkNg9b7nit60++ujpH8koCoJZawwNiZWRaT7IvXpfvX/6uR/SYYMJTXuUQjStDiKG3xJai0903HHk+qxbEnd1WPkIizBGarOHjxwyPxmh2j60g7Cb5jX+xF4FJT7XDJNcduKrbZRDfpkQwmJYEj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW3LHgQxb1d1IDd7xwZtmT0Kmo/Mbq4+wOVaRjw0j0w=;
 b=pIlvAlNFk3Lz0vQR+4oaItR42kLtDj4elgv0DIO3Bfr58qGEDU8UkUMe+knTHHpCJ7tNcDYbTh7NRXwVaZHtDF2fXRcS4biryFiVnook5KbGxVauZpFI/BpbkMMh6z/h8qEaNAZG1AEjCogSAIRBTc4pP8ZZWggSs30281c04sJZdqrGB7s9g0o7D8CUFkMuoO2G4/TXDZLthMorepSg/SFh1tMi5m3pSleLLNCj+XEzcs2sEGOciwhGXGv4YJWkvpxiN14QhZs+uyAqciwCWWrkVHekNqyqJyw/4S1BZt1996kcRVhQFIxKKp0JsNIHFOQ+FiMuMAaFjtPnHPHGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW3LHgQxb1d1IDd7xwZtmT0Kmo/Mbq4+wOVaRjw0j0w=;
 b=5A+L3f7uoUAXlS2rCCuiN+/tB2muZQacuhlfc0vGFvosx8rQZPeOVN4CsfGtFC8QOeBuxQSK2cjkYH508E4sdw8tdxkciYVQWlAo1tEWfDt5YX2SWDmFlAQQG2eUR91bfbzJ6jTqG18FoAJKhXdT2hDaKvb1YhN3laBytMsYGdk=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:06:05 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d8) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Fri, 30 Jan 2026 08:06:04 +0000
Received: from [10.136.44.172] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:06:01 -0600
Message-ID: <fc30ca1f-e235-4076-b1f0-0f82f7cedd8a@amd.com>
Date: Fri, 30 Jan 2026 13:35:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio
 register name
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <vasant.hegde@amd.com>
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-2-sarunkod@amd.com>
 <08862b0d-5d27-41de-beb7-da26c1d894e6@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <08862b0d-5d27-41de-beb7-da26c1d894e6@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: ce130fe1-85b8-4ca0-55e7-08de5fd66aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXpuOXk0VXZuaTM3NVVTSDFheW5RMklsWXNkRVZ3TFpyV0hWalgwalJTZW1O?=
 =?utf-8?B?NkJWRlE0aGYrUk1sYmM2OHZvaFZoZ21nY1p1UFB4Njk3VUtMUnplRDhVa2VO?=
 =?utf-8?B?c0FPTG0vajJONUxJak1pYkpkVlB6bWd3anNsc3M1aEEvTUpvYWZOMnNaQlZB?=
 =?utf-8?B?eFpCVTFJR3pwY1pQY3VhZFFlM01QVVpBYk5HYytFVkczVzBGbVZpMXpSaW4x?=
 =?utf-8?B?SWJ6cWpUZHVYeXpZL09hZTRwL3RRaUNiWU0wbGRocmtaL1BUbkVpTTl3WG9M?=
 =?utf-8?B?aCtPQ0Vmb2xyeTNFbmZNOXFNUlVCRHR1WEp3RlJ5WFhGd3lOMFFGbUhSYndY?=
 =?utf-8?B?ekZ1TDBmTGV4ZVVJZmFBM2tUckVHOVBxMVBzZFdTVjFnWmJyeDV2T0k4Yy9k?=
 =?utf-8?B?N0tCenI1Z1JHYndBZExwOFhOTlZoOHJXaTYwOTJ2YmhGNkhHQytkUGg3MVVo?=
 =?utf-8?B?WEp0YktKVWJoWHI4WmRtUWVDNEUzaytxcHZ6UTBaTHpWOGk5Ym85TlM5Yk95?=
 =?utf-8?B?L3NpSFFQa3lNOWNaelFUbldGcGthaGUvYVlBZVFXdUV2b1NoOVhKeTlrVEpj?=
 =?utf-8?B?Wk5tQmVmMkxXbGxzeDBvd0lLNlc0dTR2R1hzajRVYXJpUDRtbk1wUW9zSEZL?=
 =?utf-8?B?ZmRZT0svMnZXOE9MUFJXbGVZRitWTHNQd3hPYVVETVNIVmRlRENTMkt3cWRQ?=
 =?utf-8?B?by9QNGpEZ3VsTUw2VmY3U0ZESGwrVmhVbDBpMDlIRUZLMVVIUjBjWHE0QUJF?=
 =?utf-8?B?M21rWGFmQkVVaU84ekVrd0hDYWVjS2NEWjFyQytucjMyNDlpSTBXOVRaLy9q?=
 =?utf-8?B?Y1dORkdSUFEwQ3RmTFpUNENNYzlMcms5UkVQY3F0ZUlQMUpzU0d6MWY5eHJN?=
 =?utf-8?B?bG0wVW1UeFd1QVQrWlBIT0FmZ0cyYWEvMVdvSjMvRElZQ2Zkb0QvdUE0ZGFV?=
 =?utf-8?B?NjdXK1FydDFnRVJSWTdncG5yL2tSYXhMdzU1VFVlbDcyV2xtRk96UGI1djhs?=
 =?utf-8?B?TVMxd2ozdTRvWm1EazV0ZGVyTDg2UU1zZ0R2elRlUTM5WmkxeFhURTdTVi9B?=
 =?utf-8?B?a1hrM2tnMTAvY28zbmVHeTR0MnJUWHJWTlY5N2RRTjlhMEY0VlBzOUFkMkFC?=
 =?utf-8?B?S2FwVWVvQzZCWUt4NDMrT3BRTVJvVlNaUS9YTkQ2WjVtWXhnalpJbDZjbk5k?=
 =?utf-8?B?bUY3TW1OYWdQd1gwVWxzS1MvMTNoVGhsWW1nTHVrelIwWHBXYyt4ZGVodEZO?=
 =?utf-8?B?ZFprN2NncWZxWGQ4d0lWbXdrK0ZXSENMUTAxSmRONFowQzVialRsanpoYmpN?=
 =?utf-8?B?ZEF6NUZrTFJDUnY2MDQ4R3V6NGE4ZVhYYXhSbXd5TUt1K0ZvZ1RtWW1kVE9o?=
 =?utf-8?B?djlHN21tbjFSUjdiTzhMM0t0SHVudTRHaTZwdW0rZXBKblNYZ2pnMjV1NUZi?=
 =?utf-8?B?VjVSMGo1KzdnVm1wM3gxRUhubFQ5dStnYnhwNWVXVlZJcFpuTUV0cEdTTWtY?=
 =?utf-8?B?S2RUbEg5anFIOXJja0hPRUU0QlJLdGlyeURidEhhVmdpdGZlek5UUTJGWUhm?=
 =?utf-8?B?Y0hyN25EQkcyMEJzeXdKL1hic2h6dC85WnIyVDlzYW13WjVSVW9LanJJZXBx?=
 =?utf-8?B?aWp1NlUwT1FjcFRmd1hZRTNEKzgrTWdOVFZRWXNGaVJhQitzcWxjay9VZXA4?=
 =?utf-8?B?bXBZYjV6RkszdmZhSzFncFlJN0FXcjUxblJ2aEN1eHJSWVJPVkk3MG4wYlRF?=
 =?utf-8?B?aDUrT29EWDZOeHU1WHY2anM4OFhpWUl1TWtCaTg4VHV5T3VrVHVmZmlSTFNs?=
 =?utf-8?B?RElRTVoxMVBDK3NuaU8rcEYzMmx0MEZybmJ6aWQ2RnFYRWdtL0xxcWZ5c1VR?=
 =?utf-8?B?OFFHc3VqVmUvaDFRbDhvNU4vTlRUVEVDYkhRVGsyRWdkSERxN3RVdEJiSUJG?=
 =?utf-8?B?UzlUUFFnTFZaTzFpTjhJSnpmNTFrRitIM1BEcG5CS0VVSklMYVlsTUxZZXk3?=
 =?utf-8?B?NU5zeE4wK0NXNHBmM05MTUZFTUwxL2lhRVZoc0pjVWdhVzF5RUFRRUZFaEMr?=
 =?utf-8?B?YlhTSTJSUEJLNUdvOVNja3h1UXlDKy9TQ2VIQ2tkd0F5SW1kUUFXMTkwUks2?=
 =?utf-8?B?S0hQNExMc3ZCTjJSQ09jd3RHSlBUeEEyTFJ6U1M0SXdBUFNsR0JXOExOdldi?=
 =?utf-8?B?TFVzME5saXBiVlRKbXZmTFZFZDl0VkVET3ZkbHJtUUU0b3FadTQrZitob0F1?=
 =?utf-8?B?dzFGS2xGUmpFRHlmY25UUGE0ZW5nPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ztJxf4Ti7NohchHXo7IwJF2AA0ZxvGWqdk6DaHuwbHD+u0i9ZttgvURy1gIbvj95LTuBcJLB/PiJdFJoGihza7pw2Kmvz/inAPbYHpjBZIefHlaXVR55nqAxCqTxKejWov9ATleT3/iHO1DRWwqvN19H7s0x2T7c748AK8QfTKahx0EKxGkGBj0WMkTs6HvPq+bJDjup0lLqJO7ukDwewymvOZKotC/NmBA+QI2zlXmJ34i49ltgwtGswZCc5YwkRJ8CgH7AAWJIKkZIuGJ8OwB8Et/v641OS3ha9GMctK5a5K0L9M1iuDbl/7WW1wd62q/ozf0YA9vtZtfwA55BeMC1j02TPzJsBLcly7PTWrGNpq9TWcIAfF4oagByxSVYBqpoYxEQL9DunOM2KP1OifZy3pT8ZOhy8xK3dRr0DyLzFiJWB9VdCgw85h3+7l8v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:06:04.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce130fe1-85b8-4ca0-55e7-08de5fd66aaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/30/2026 3:20 AM, Alejandro Jimenez wrote:
>
> On 1/29/26 5:28 AM, Sairaj Kodilkar wrote:
>> This makes it easier to add new MMIO registers for tracing and removes
>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 65 +++++++++++++++++++--------------------------
>>   1 file changed, 27 insertions(+), 38 deletions(-)
>>
> I'd like to also remove the unused AMDVI_MMIO_REGS_{LOW,HIGH} definitions
> and amdvi_mmio_trace_{read,write} helpers as I did on the example diff in:
>
> https://lore.kernel.org/qemu-devel/eaf49cf3-e56b-40f1-974d-207969c7371e@oracle.com/
>
> assuming you agree with it, no need to send a new revision, I can add those
> changes to the current patch.

Sure go ahead,

Thanks
Sairaj

>
> Otherwise:
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 789e09d6f2bc..62175cc366ac 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -35,28 +35,7 @@
>>   #include "kvm/kvm_i386.h"
>>   #include "qemu/iova-tree.h"
>>   
>> -/* used AMD-Vi MMIO registers */
>> -const char *amdvi_mmio_low[] = {
>> -    "AMDVI_MMIO_DEVTAB_BASE",
>> -    "AMDVI_MMIO_CMDBUF_BASE",
>> -    "AMDVI_MMIO_EVTLOG_BASE",
>> -    "AMDVI_MMIO_CONTROL",
>> -    "AMDVI_MMIO_EXCL_BASE",
>> -    "AMDVI_MMIO_EXCL_LIMIT",
>> -    "AMDVI_MMIO_EXT_FEATURES",
>> -    "AMDVI_MMIO_PPR_BASE",
>> -    "UNHANDLED"
>> -};
>> -const char *amdvi_mmio_high[] = {
>> -    "AMDVI_MMIO_COMMAND_HEAD",
>> -    "AMDVI_MMIO_COMMAND_TAIL",
>> -    "AMDVI_MMIO_EVTLOG_HEAD",
>> -    "AMDVI_MMIO_EVTLOG_TAIL",
>> -    "AMDVI_MMIO_STATUS",
>> -    "AMDVI_MMIO_PPR_HEAD",
>> -    "AMDVI_MMIO_PPR_TAIL",
>> -    "UNHANDLED"
>> -};
>> +#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
>>   
>>   struct AMDVIAddressSpace {
>>       PCIBus *bus;                /* PCIBus (for bus number)              */
>> @@ -1484,31 +1463,41 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>       }
>>   }
>>   
>> -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>> -{
>> -    uint8_t index = (addr & ~0x2000) / 8;
>> -
>> -    if ((addr & 0x2000)) {
>> -        /* high table */
>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
>> -    } else {
>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
>> +static inline
>> +const char *amdvi_mmio_get_name(hwaddr addr)
>> +{
>> +    /* Return MMIO names as string literals */
>> +    switch (addr) {
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
>> +    default:
>> +        return "UNHANDLED";
>>       }
>> -
>> -    return index;
>>   }
>>   
>>   static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>>   {
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>> +    trace_amdvi_mmio_read(mmio_name, addr, size, addr & ~0x07);
>>   }
>>   
>>   static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
>>   {
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
>> -                           addr & ~0x07);
>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>> +    trace_amdvi_mmio_write(mmio_name, addr, size, val, addr & ~0x07);
>>   }
>>   
>>   static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)


