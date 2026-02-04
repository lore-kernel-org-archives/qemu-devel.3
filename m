Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61382E8B397
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 04:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnUGY-0001pg-1u; Tue, 03 Feb 2026 23:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vnUGU-0001pD-4f
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:13:18 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vnUGR-0007rh-Gn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:13:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrC4SKFagj836tLDSLIzuun2A0p3X3kvIMYoe88vQyqFYB9RhN2affFhfjW29b9tNLIa8wxmAW55WG+E5fd8ih3pAuhD7fae1fqi8qrNQeCCN3L0pEtb9cXKwuZhgFMK2GcYeLoBxszvfA+zrdpgPQxWvsme9laqOpH8ygEJInNv9BRjuvFDxsr3tNNCqk3A3hYr0JwP60LA6jYmDEhtucUe6x+1b8PFoRz6bB3+iAzx2pHqnX+wbt0Nb99fAMMCGIq3+7nYSkDHIitkheiX0oXT9oAJxvabuIhzbfHbA8VWDNU22NyzbT32QCz17go/58nUTPTnoy6Q3IPHAN2V4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdHH5DJRKSVHjf3owoDq6ebSBXsdGXxNVfSA05HoS4o=;
 b=SYbGqT5P1q8C6BMreH4c29/evL+bqkyoVGCXWFIW8gdb0ES5bbAZHzTqz+TdT4SqVFDJ14creG/10PRxxZwryLLIQnMDB1BKyDbRjCpLZBZL38Uu5My6Q3rtB6bIcKYACjZjA/XkMpSt2RdygZU7HOsVUA6X8BX0SHfR3hRN+5kBEi+yjt/sgbVsaQzvFTn7nro5qktwKnALlxvhEFnu+xd2g/F/yMbekANv79WhF8SsmcOjIZUADPaKT7XvLorYb0IqzIWf4FwTqSW7z+2nq6a3iemPHzzErJqbJh0aKZNBtjNMQXy2Q9xi//J70Cmenhxok1yibGEYc60NL1dFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdHH5DJRKSVHjf3owoDq6ebSBXsdGXxNVfSA05HoS4o=;
 b=KO7jclmUtdQ+e4SBNwLRGn5FGDmueZbWvE2L5tBBMou9dYkvoGrsonVe/oaDKuJPN21lojQ4anbxk2B7DJ+hEc9coDuCBZTUj63C34Q3bcde8hBM79jC4gOJNwDBy+xl8AzyJRESA02TNfwVLOGTt+2OldYK6l60/PemjdHRB44=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:13:08 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::8f) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 04:13:08 +0000
Received: from [172.31.190.188] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:13:05 -0600
Message-ID: <f03b77f4-6b89-4ac0-b51f-09ea8b74ee8d@amd.com>
Date: Wed, 4 Feb 2026 09:43:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>, 
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-4-sarunkod@amd.com>
 <e91cc0cc-bbdd-4d58-8753-7ba267aab79f@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <e91cc0cc-bbdd-4d58-8753-7ba267aab79f@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 7803fecf-61c7-450b-d898-08de63a3b3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3RwVVNWWHVwTU0xNGs4K1l4bzg4L3RNVUs3SFNNNEYzQkxkL0c3SVFENmZT?=
 =?utf-8?B?eWFkNi9CL2dzS3BZWGVWWFFWS3hYdHNOdnZndWpKSG9KcW1RalNhMHU5TUtI?=
 =?utf-8?B?WUtYY2tVYUdnMlpQSi9qSkJVMk9CU3B4K0EyRGhHZ3FKR1RsVUdKT25kNllx?=
 =?utf-8?B?N1R2MzIyR2dhSkEvdWZua3JISHdNRkd5VHRmSG5zekp5YmV6OEoyYWZoaVQ2?=
 =?utf-8?B?UzRIWWpVMGxCNUNldS9sYUVoWlVRenVVZW1jZW5BYVhvQ0sremJMbHJOOXZH?=
 =?utf-8?B?YjFERkt3T3h2Qjg5WTd3L2lNZjRVRktqUjI0eFg0aHhZbjFITndCMDV6TDdp?=
 =?utf-8?B?M0pRU3hnZ1lnWmRlWEQ3OVB2ZVdSTkZHaDU2b1VvZ3hlcUI0UkNwbUo4bGxl?=
 =?utf-8?B?c0JFOUhTNnU2Um1mZVhkbmtRY0pWeVkrUDF4c1Q2MjJmOVV3STRMVG0xMWFo?=
 =?utf-8?B?OUxQZGgzWFN2TEJVNVgyQk85WVArY1ZLMzhlTFpxTVBPR29qT3Zpdi9vWWNw?=
 =?utf-8?B?ZElHa0ZvRzc5RFdDT0hZeEZNS2JFM1J2TUgxRlBPdmFGQ3cxTXVwd0dkNVpP?=
 =?utf-8?B?eFd5UjVuYjZQcnp0UGN0cTkwa1VRbjE2azc5b2VsVTNKNWFvODZ3V2ZwekRI?=
 =?utf-8?B?SVRUZTlOMjNpS0E4T0xOYThUSXBMdi9GWVRackppQ2hTM3RIOXExOVRFVkhW?=
 =?utf-8?B?M2Z3eGk3R3FhS1VFRUc3YWdDWUxSUjZkRkQ5VEI1Z0ZRYkhibGZsMVFMZGNo?=
 =?utf-8?B?bk5VTENXZEVYSTUzMHB5dUFTTWttd1V1enhwSUc1eVB4VTVFUkQxc1FoQVhn?=
 =?utf-8?B?WEIvQldELzlWajN5cjVnTlptZi9aaHpycVpGTHlPaThxV0FKNEV4d0V1QkRl?=
 =?utf-8?B?TWZsdzFCeTM2VkVuSmdqUnR6aWxUMkFUcUNMa2x0QllGc0pPQVMwS1NOTXU4?=
 =?utf-8?B?WHYwdi9RUWRMdHMvZ0M1TVN5QitEdHBPK1pJdGYwNXNUa0hpV1BtQWdzeU5B?=
 =?utf-8?B?UkIwdlBjV2Q2K28vTHdYdGFid0JPVG9qSjBoNmMvZndHUXp4SlM1OXR3eGlK?=
 =?utf-8?B?Qi9weFFwQlVGVkphQnRXMmxQNis1K0FlaldnSndERUxpcG52eklkOFluK2x4?=
 =?utf-8?B?NGVvWjVPZzlhbmtEY2pSNVQ0ZVZLN3ZlTHhxUDAzUnVFblkxaHJTc2d1c1I1?=
 =?utf-8?B?WlNiRytnWGIvQzNmQ01vamFoM3Z6L3RRSlloTnd1aWpqVGtPYkRnWG9jcDVI?=
 =?utf-8?B?MjBvTXBqa1FFTkMwdXRXK05yMjQ2Uk0xcUpmc2cxbXFBVnpaZXFsVFNZVDFP?=
 =?utf-8?B?cVVtWVg1cFdFTVlyYlVTSk1LVHZVaWx2L1RidnNTK1o4S2pyUEczUE4rL0t4?=
 =?utf-8?B?dUN3L2xuU1IwWlBhSGdTOUIzYUY0ZkV4MDE0MkVWeFVmdnNZR0Fpd091YStC?=
 =?utf-8?B?REdDZDVsbWJSWWhzVVdkZ2ZnWW90VUY5UmQxS2NEYVpLZUZhY1B0LzRVVDZH?=
 =?utf-8?B?a0lWSHRHdDdjeDBldjc3Ti9uL2xvMXFZYUFXeEFvcndULzlYazdzZmVVL0R3?=
 =?utf-8?B?cnFaUzlsUy93YW1SRFhtRUpUT043Yml6SlZ0VGl3NWxIM2RScUo4dHNHMFNK?=
 =?utf-8?B?amtOWDlNa2xKWTFCNHg0SWJqcWdWZUR6NTdDVlpTYnF0MmU4T3FQY093Rnds?=
 =?utf-8?B?WjlrcER1MWc0dHVpcGJnclhvYWpDUGZ2bTQwQXpUSy8xWXVCanJaeTFKdDIx?=
 =?utf-8?B?YndqeGNVWGIvQzJKRTJwT3MyYm85Uk5XeHdqYUUzSURRbHNsSUNQNGRzYTJv?=
 =?utf-8?B?djVPc0J2RVNod0xhK3dxWS9DbGNiMURtbjJWMzRtNGhOeUFjend5R2VTYWtC?=
 =?utf-8?B?VmYyV01mdkhGV1UxOUdsUlpxbEZoMWNpQkRydTd2MHhpZUdmVi9rYXlGVHVW?=
 =?utf-8?B?SUdDVUp3Vncyc2NYMStsMzZVRGZrUFJTRno5T1Q1cFRKWjFwQkZVRmZMcGdW?=
 =?utf-8?B?Y0tFWWFSazMzQU9WR1g2ZytBSURnWDFQdktHNkxzZFFWNGo2ZWFVZ1ZlRnNP?=
 =?utf-8?B?NnNWZWY0cEpRUzFTNXE4NmRWajUzQmJnRDVnMHlpQWJLMWNFeVNLT0JNTVYw?=
 =?utf-8?B?RmV3NitBWWNQZ2VDbW9ZY0NZN3dueG1DenR3ck5kUW9pNFFJOTRRMS9KWnVR?=
 =?utf-8?B?dEsrRmJOVFQyK3JEZTljSjZnQ21welovUFR0WU9OQlVvZVY2NlAvSGdLdGts?=
 =?utf-8?B?ODd6Y3dHbE9nTEllck9rdXhvQVB3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /wvydF+u4l8yTqhRFo/OLZ82BLXG6/JSyE5Rkn651/SlpN4l4H69gmKLa3swwvF98lzs/v0wgw+ia1WEaiB8e6CDH+jnoxRY5Ouiby0EucI6dQQuuYcNLRDBTLFojMUFNAvDk9A/LBHYLoIDNUyleptOVdAauLujeZoZx5t/10wpjQPk93PxpDUgdtmz6Za3mbk+qYSduSCoyU7J+QQQmUEs64IzdPy7yeFPgOQoQAyAmIWFGXZMEi5nFDysA84YWZrlK8vmLP1veZRmquRvP3a+ydPC9P7dbso4W08ukxYIfV6VaJpfHb/Td3+0d/mhEh0mjRGE8BgSp4hm795mdD679f/ZBXpRSijqe4za1VefyhbrrWnun9PNX/xbP6JPlJri3Jfo39fQPt7PjE1NcDERWhSFr8zYdMTNrIxT1veUK07dI5dxVERUvNtx6NwO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:13:08.0852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7803fecf-61c7-450b-d898-08de63a3b3d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/3/2026 4:59 AM, Alejandro Jimenez wrote:
>
> On 1/29/26 5:28 AM, Sairaj Kodilkar wrote:
>> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
>> sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
>> 0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
>> The guest programs these registers with appropriate vector and destination
>> ID instead of writing to PCI MSI capability.
>>
>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>> MSI capability and does not care about xt mode. Because of this AMD
>> vIOMMU cannot generate event log interrupts using XT event log register
>> (0x170) when the guest has enabled xt mode.
> I see that you slightly modified this from the initial version, but I would
> leave it as it was i.e.:
>
> "Because of this AMD vIOMMU cannot generate event log interrupts when the
> guest has enabled xt mode."
>
> There is no "XT event log register (0x170)", it is the "MMIO Offset 0x170h
> XT IOMMU General Interrupt Control Register" as you mention in the next
> sentence.

Sure

>> Introduce a new flag "intcapxten" which is set when guest writes control
>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>> the XT MMIO register (0x170) to support XT mode.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   hw/i386/amd_iommu.c  | 43 +++++++++++++++++++++++++++++++++++++------
>>   hw/i386/amd_iommu.h  | 17 +++++++++++++++++
>>   hw/i386/trace-events |  1 +
>>   3 files changed, 55 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 850d3920a76d..742ef5d42561 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -194,18 +194,38 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
>>      amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
>>   }
>>   
>> +static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
>> +{
>> +    union mmio_xt_intr xt_reg;
>> +    struct X86IOMMUIrq irq;
>> +
>> +    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
>> +
>> +    irq.vector = xt_reg.vector;
>> +    irq.delivery_mode = xt_reg.delivery_mode;
>> +    irq.dest_mode = xt_reg.destination_mode;
>> +    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
>> +    irq.trigger_mode = 0;
>> +    irq.redir_hint = 0;
>> +
>> +    x86_iommu_irq_to_msi_message(&irq, msg);
>> +}
>> +
>>   static void amdvi_generate_msi_interrupt(AMDVIState *s)
>>   {
>>       MSIMessage msg = {};
>> -    MemTxAttrs attrs = {
>> -        .requester_id = pci_requester_id(&s->pci->dev)
>> -    };
>>   
>> -    if (msi_enabled(&s->pci->dev)) {
>> +    if (s->intcapxten) {
>> +        trace_amdvi_generate_msi_interrupt("XT GEN");
>> +        amdvi_build_xt_msi_msg(s, &msg);
>> +    } else if (msi_enabled(&s->pci->dev)) {
>> +        trace_amdvi_generate_msi_interrupt("MSI");
>>           msg = msi_get_message(&s->pci->dev, 0);
>> -        address_space_stl_le(&address_space_memory, msg.address, msg.data,
>> -                             attrs, NULL);
>> +    } else {
>> +        trace_amdvi_generate_msi_interrupt("NO MSI");
>> +        return;
>>       }
>> +    apic_get_class(NULL)->send_msi(&msg);
>>   }
>>   
>>   static uint32_t get_next_eventlog_entry(AMDVIState *s)
>> @@ -1483,6 +1503,7 @@ const char *amdvi_mmio_get_name(hwaddr addr)
>>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR);
>>       default:
>>           return "UNHANDLED";
>>       }
>> @@ -1537,6 +1558,11 @@ static void amdvi_handle_control_write(AMDVIState *s)
>>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>>       s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
>>                 s->ga_enabled;
>> +    /*
>> +     * intcapxten does not depend on xten flag because IOMMU spec does not
>> +     * specify any dependency between these two flags
>> +     */
> I'd like to modify the comment to add more info/breadcrumbs e.g.:
>
> "
> IntCapXTEn controls whether IOMMU-originated interrupts are sent based on
> the information in XT IOMMU Interrupt Control Registers rather than the
> IOMMU’s MSI capability registers. Therefore it requires IOMMU x2APIC
> support capabilities (i.e. XTSup=1), but it is independent of whether a
> driver chooses to enable x2APIC mode for interrupt remapping (i.e. XTEn=1)
> "
>
> This conveys your reasoning for not linking intcapxten and xten, while also
> giving the exact search terms to query the spec and find the relevant
> sections. Any concerns with this?
>
> Otherwise,
>
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Hi
Thanks for suggestion. I will expand the comment.

Also I hope the confusion around RH bit is clear now

Thanks
Sairaj

>> +    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xtsup;
>>   
>>       /* update the flags depending on the control register */
>>       if (s->cmdbuf_enabled) {
>> @@ -1743,6 +1769,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>       case AMDVI_MMIO_STATUS:
>>           amdvi_mmio_reg_write(s, size, val, addr);
>>           break;
>> +    case AMDVI_MMIO_XT_GEN_INTR:
>> +        amdvi_mmio_reg_write(s, size, val, addr);
>> +        break;
>>       }
>>   }
>>   
>> @@ -2393,6 +2422,7 @@ static void amdvi_init(AMDVIState *s)
>>       s->enabled = false;
>>       s->cmdbuf_enabled = false;
>>       s->xten = false;
>> +    s->intcapxten = false;
>>   
>>       /* reset MMIO */
>>       memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>> @@ -2463,6 +2493,7 @@ static const VMStateDescription vmstate_xt = {
>>          .minimum_version_id = 1,
>>          .fields = (VMStateField[]) {
>>              VMSTATE_BOOL(xten, AMDVIState),
>> +           VMSTATE_BOOL(intcapxten, AMDVIState),
>>              VMSTATE_END_OF_LIST()
>>          }
>>   };
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index e9401f3a5c27..886814770276 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -57,6 +57,7 @@
>>   #define AMDVI_MMIO_EXCL_BASE          0x0020
>>   #define AMDVI_MMIO_EXCL_LIMIT         0x0028
>>   #define AMDVI_MMIO_EXT_FEATURES       0x0030
>> +#define AMDVI_MMIO_XT_GEN_INTR        0x0170
>>   #define AMDVI_MMIO_COMMAND_HEAD       0x2000
>>   #define AMDVI_MMIO_COMMAND_TAIL       0x2008
>>   #define AMDVI_MMIO_EVENT_HEAD         0x2010
>> @@ -107,6 +108,7 @@
>>   #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
>>   #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
>>   #define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
>> +#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
>>   
>>   /* MMIO status register bits */
>>   #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
>> @@ -343,6 +345,20 @@ struct irte_ga {
>>     union irte_ga_hi hi;
>>   };
>>   
>> +union mmio_xt_intr {
>> +    uint64_t val;
>> +    struct {
>> +        uint64_t rsvd_1:2,
>> +                 destination_mode:1,
>> +                 rsvd_2:5,
>> +                 destination_lo:24,
>> +                 vector:8,
>> +                 delivery_mode:1,
>> +                 rsvd_3:15,
>> +                 destination_hi:8;
>> +    };
>> +};
>> +
>>   #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
>>   OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
>>   
>> @@ -421,6 +437,7 @@ struct AMDVIState {
>>       bool ga_enabled;
>>       bool xtsup;     /* xtsup=on command line */
>>       bool xten;      /* guest controlled, x2apic mode enabled */
>> +    bool intcapxten; /* guest controlled, IOMMU x2apic interrupts enabled */
>>   
>>       /* DMA address translation */
>>       bool dma_remap;
>> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
>> index 5fa5e93b68dc..a1dfade20f18 100644
>> --- a/hw/i386/trace-events
>> +++ b/hw/i386/trace-events
>> @@ -118,6 +118,7 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
>>   amdvi_ir_target_abort(const char *str) "%s"
>>   amdvi_ir_delivery_mode(const char *str) "%s"
>>   amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
>> +amdvi_generate_msi_interrupt(const char *str) "Mode: %s"
>>   
>>   # vmport.c
>>   vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"


