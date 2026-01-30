Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC4DD49C6B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 08:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljZb-0006Q0-Vg; Fri, 30 Jan 2026 03:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vljZa-0006Ph-PR
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:09:46 -0500
Received: from mail-westcentralusazon11013002.outbound.protection.outlook.com
 ([40.93.201.2] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vljZY-0000kZ-T5
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:09:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoCzTwhi8GzmK1v41TCzTYD7AjrDPejXISdNAibA0Q6ffdp6pkf1f9CbZBx+oYD8UPTWq1io1eMM+dXtaxy+D4Em+5m4r91uKT10irWG6ksCj41dUKueT/uBss+5ow3uxsFfk8ahts1d9oXKqAGM5dJdtd+h2p23XmzpAx8iqsgq9/tdS11QsFJbm61Wvzo771+4rjZHsJKWEj6rnsDZ9QePsh1o+Yln+hQ0fepECL/AiOxVuzUFTpKxpWqyg1Cko4p/1YuJbd5+cmN2U/z5bzYtwHbBUkaI2n77JhLKaE0vV+EeNCqIVU7YMRcsy5NOj/dYvIwMsemPhJ1xb7eqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp4ESfdc1YXGux2OnPXErAl1MgjTFy8J+RkoJs14ruo=;
 b=gM32hr9K9hzppvpkGTpaKc1+z6zQTf7M48Db3Pi1I+oB/8n5geoJCgxWIXwvZ6uoWS4PDHQiB1mgV6QXCNxRjzKmPMBa3x0WJyKDP2Entholf8nanP1TJIzU9Q2oV3oMweCliHvOXTrT/vIFxebkXoDs1TQUDtHmfwhW6RYhlTFg2yn4H7zTW5SV6mE8KQRGe7M51BWzxDVUtUmrfu9yEd0ET8jNgyqfiYICrj3+YU51zzWE3hRO48f+X+aWAW7Es92QNTbhXsSfS9/4cWjL6Yho7xrRNx+pem4wfT9VdgIBh7sSzzR60sjCapIcPClZscerL+ZsY3wFeO+Yq1gaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eviden.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp4ESfdc1YXGux2OnPXErAl1MgjTFy8J+RkoJs14ruo=;
 b=Rz4U2zhk9O1+F+Npkz92r92+xuD9hSC2iCB639WE9rofXs6ezn2Hf92vYvV0HloCp6YfERyhdJ++mMiI59vh+Wi+X6gR4EpyAtilW0jWc0zw5cr69gS1wyjO3WnHW5O2CWQNIbd6JJnCY5yL0kntwPENRzDOUyovTuQp3zzayVg=
Received: from BN9PR03CA0461.namprd03.prod.outlook.com (2603:10b6:408:139::16)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 08:04:36 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::67) by BN9PR03CA0461.outlook.office365.com
 (2603:10b6:408:139::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 08:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Fri, 30 Jan 2026 08:04:36 +0000
Received: from [10.136.44.172] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:04:33 -0600
Message-ID: <df3b9d64-b47c-48e7-a368-715a74989cfa@amd.com>
Date: Fri, 30 Jan 2026 13:34:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio
 register name
Content-Language: en-US
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-2-sarunkod@amd.com>
 <85c7506f677e3a9145eb8be2212ee62c0b92169e.camel@eviden.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <85c7506f677e3a9145eb8be2212ee62c0b92169e.camel@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ed19dd-788d-4f23-b2ea-08de5fd635c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkgrWEw4VFR1RTMranJEdDJ1N1oyZklQMGdEaE5XbkhZbEs2MHZlWHJmeUQ1?=
 =?utf-8?B?UlROVFdHM05ac0hQYjhDUmh0clNxWHY5VVR5b29EL0VxWEx3Tko2Ymlwdm1Y?=
 =?utf-8?B?UUNiVFhZQ3JCMmpLakVoOVA1VU1KUWRmVVNoYlJLVldUT04vakxqMDJVTmlN?=
 =?utf-8?B?N0FDaUluc2J2c2JFN0swaFFmVmpKYXhwSWJTeEFiT0NiMWJwRWQ5YVpJejlp?=
 =?utf-8?B?OUcyOUhCQ1dYMFdaNkFNNUZUWWk1blpVY0Y1VVNmdXZBRVVXU0tWYThhV2J4?=
 =?utf-8?B?VzBtaVh2bmxVSmc2b3hJUXZmZWFpanpnZzZMUjFmUW9iTUR4SkRLa2xwMnRO?=
 =?utf-8?B?ZDJrUEVWUkl2NWN6MCtIL2hqNS9FV01nM0V3dUFzR0FIbk9hcW4rODFEbWsx?=
 =?utf-8?B?UTdPbVM2MmhPenFHc0NKV0ozNkZKbldMMHQwR3hmZG9udzZHRUpaRCt0aTcr?=
 =?utf-8?B?TFFhRStqTlpXZFJ4ZHNKekhUMWREdjk5SUFOVzVXUjZwWWIwS0IwVFRETG9a?=
 =?utf-8?B?MytmZFJiamk4TG5pRXgxM0NYS1ZUbUtxN3pCejF6N2RvbHBHYjhwWkZabXVq?=
 =?utf-8?B?NkpkU1lnNFVIUnVJbXAyaE1oaDFWSURoMkJUbWh3R0JXdi9GUWNwMDZxZUg5?=
 =?utf-8?B?emg0RHRVVFgyTXFzMmx1MnFnWC9yZVNpZlhLRW51RlhoakZ4ZU5Ldms2Rjk2?=
 =?utf-8?B?RUFTUjc2TExPRTZDVmZiYTY4Mzc0NjREdkJDbDRtcEU3eGs2VmRyNFplcFRE?=
 =?utf-8?B?Yk1wY0xZUFVrLzdQUEMyYXJCb2VvMXJNQk4yVnBOeEd1Sm1JWUJRSmRDcXVG?=
 =?utf-8?B?RXFNSzFIdjNYK1p2Rk5iT0RCWHYrSC9HWmFkeWllYXBJK3BMZnBheHpaa09I?=
 =?utf-8?B?SHlOK3kwZG1LYzl5cklqNkU5NEc5dzY4YjdkRzNLMnR4ZHVhWmNsQXc2WUE5?=
 =?utf-8?B?TjBlOFIwVHoxYmhkMndYWjdTc1Rhd2VWQXUxYmdsZDJMclZWV1lCVDVJa0ha?=
 =?utf-8?B?dSs3YkVtaGEzYXBVZDhtMUQ5TWxQV0dYTUNYSGxiZkVYL0pQUmhDem84L0Zt?=
 =?utf-8?B?b3UraW5ncHBXR2pmSEt1cURicWl1SnhNTEIzVlNCemM2dFFjUjBaT0lDT2ZL?=
 =?utf-8?B?WDZ1bG4xMjNQRW02U2ZvQmxIY0xZM0wvQnp5dmk2M2ovWkRmR1RCUStNandN?=
 =?utf-8?B?R1ptd3hiMzFVYWdoMWpralNuL0MrbkI3elpHaTZCRk5jZzBuZ0ZxOUgrVnBK?=
 =?utf-8?B?Ulg5akRSOFVURDcyc1FxRGdiK21QVlNUN3lnRnZ0VGNtNWRtTlZ1SWRuU0wz?=
 =?utf-8?B?cXBBT0V2NlhmVGl6M05nbTljYVlFUjYrd2ZhTFA1VTlIZU5KaGoxZmZwRjZH?=
 =?utf-8?B?N1QydnpJd0FzK3QxTGoxZW5Ya1dsNEZWV2lmVnNjNzRHZC9raXh2MkNubEpS?=
 =?utf-8?B?Y1NIMnl1dlBlVGxCL0llb2FzN1Zhb2lLdncvZEpEenRSMGxabGlKN05kRkZT?=
 =?utf-8?B?Y2VTazk4MnhXaDJlRjZDZWtVYW4zVmJOZ0tjZGNQLzNleGM2S29xNmE2T1NP?=
 =?utf-8?B?R0pZUXdoZDlDbGlTbExCWkMyMGdhU21SZkl6Wk9TcGVmNytBaTArV0c0Y1hP?=
 =?utf-8?B?UVNaVnFKSGpUNm15R05mQ2prZFpHQ3lSbVU5aEUwTVBoeEVsTHdabXl0M1dC?=
 =?utf-8?B?emVYQ3hHWXFhTnNIMFRUTG5QOGlzTWhtaEIvT0kzSmhKNHJVYWZUejg2M0hU?=
 =?utf-8?B?YXBJRHhZSENhNElvelRieFhwVU1pRUczV3hNNitXY3V5eU85ZUpCSkE4VFYv?=
 =?utf-8?B?clZuUmllV09VODNwbjhKaU91bDNyUzNBTmtaZXU2dFBYTWJMblZaQjByRVdp?=
 =?utf-8?B?UUo5OTBJOUxFV1FRcHYwdHJwNUFFeHl1emlhVE9odnFXYjhBVmQ2ejJEZENi?=
 =?utf-8?B?QzV0eUNHekZlQUFYeHByU0hJZms3ZDRaemNHY0NFRWZwMkFUdGxxRXZzZWtu?=
 =?utf-8?B?aDBPdlY1di95Yi9EWWR4QnhUeTQ5dHU3RmVoSXBQTE5NOC9nZWcyRGYvUmpO?=
 =?utf-8?B?cDdWVXdTVkRiNnduWThMUlVhMzVSNE14OVdtVkNmWkUrQVFwR2lHdzFBM3hC?=
 =?utf-8?B?TnFKRTBYOUN1ZURPTHlyZ2hNRW45N0dXWGlRZXNMQyt3cmIzNUk4UFhsNVNy?=
 =?utf-8?B?VXZ0QytPTVNnNllRamxuaklqL3hiWStvQWx3MCsxOVdQRDB1QU1GbWxER2lz?=
 =?utf-8?B?NUZJNnFoOWhtRExOSXZVR1NKQXlnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KWkQr3EKfzUQ+0wkh1cTu2KgdfH+y5hWt2GV8owQEaU8ohiuOfHXCkgA/FKvF5p64gBOdDQks2Wp1dX/s4sq8RdpoGO8WeBgZON+1KuvJK543Yvexw9BJfqL98Iu/ABCFI6VD/ECFxH03bsFdOpQbctEeeSQ2PPG6phNaxsTMMoB16yAh7biWLSrTA0oDrzYO95h3SxizKNeG4kQ72gGg92u5PYlcqiAspivdchYdXfquZHfoH3tj6GTwywVlo1KeoHfzAX7rTpd2C/7uj1nMWTBM8+Yf18Wa3GXHMyW9eDR/Gh9xdN1LrW+rtoOB8ljh20fODDd2B7LoxTfsvXn44EBRAw5iOqXRDbYIAtdpeYsmbEi1Q1+kgSYm8cl8XYrrqweJoudP+REQXXCTvEV55Pb7OOjULoRCXumZGl1yalhsZ1Qs8cjGPJ6hqxdUUuv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:04:36.2548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ed19dd-788d-4f23-b2ea-08de5fd635c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
Received-SPF: permerror client-ip=40.93.201.2;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/30/2026 1:09 PM, CLEMENT MATHIEU--DRIF wrote:
>
> On Thu, 2026-01-29 at 15:58 +0530, Sairaj Kodilkar wrote:
>> This makes it easier to add new MMIO registers for tracing and removes
>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>
>> Signed-off-by: Sairaj Kodilkar <[sarunkod@amd.com](mailto:sarunkod@amd.com)>
>> Reviewed-by: Vasant Hegde <[vasant.hegde@amd.com](mailto:vasant.hegde@amd.com)>
>> ---
>>   hw/i386/amd_iommu.c | 65 +++++++++++++++++++--------------------------
>>   1 file changed, 27 insertions(+), 38 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 789e09d6f2bc..62175cc366ac 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -35,28 +35,7 @@
>>   #include "kvm/kvm_i386.h"
>>   #include "qemu/iova-tree.h"
>>     
>> -/* used AMD-Vi MMIO registers */
>> -const char *amdvi_mmio_low[] = {
>> -    "AMDVI_MMIO_DEVTAB_BASE",
>> -    "AMDVI_MMIO_CMDBUF_BASE",
>> -    "AMDVI_MMIO_EVTLOG_BASE",
>> -    "AMDVI_MMIO_CONTROL",
>> -    "AMDVI_MMIO_EXCL_BASE",
>> -    "AMDVI_MMIO_EXCL_LIMIT",
>> -    "AMDVI_MMIO_EXT_FEATURES",
>> -    "AMDVI_MMIO_PPR_BASE",
>> -    "UNHANDLED"
>> -};
>> -const char *amdvi_mmio_high[] = {
>> -    "AMDVI_MMIO_COMMAND_HEAD",
>> -    "AMDVI_MMIO_COMMAND_TAIL",
>> -    "AMDVI_MMIO_EVTLOG_HEAD",
>> -    "AMDVI_MMIO_EVTLOG_TAIL",
>> -    "AMDVI_MMIO_STATUS",
>> -    "AMDVI_MMIO_PPR_HEAD",
>> -    "AMDVI_MMIO_PPR_TAIL",
>> -    "UNHANDLED"
>> -};
>> +#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
> Hi Sairaj,
>
> Shouldn't we define this inside the mmio_get_name function and undef it after the return statement?
> I think it would be cleanup to make the scope of this a bit smaller as it is specifically written for this function.

Hi
I think this is probably okay as its unlikely to cause any issues in future.

Thanks
-Sairaj

>
>>     
>>   struct AMDVIAddressSpace {
>>       PCIBus *bus;                /* PCIBus (for bus number)              */
>> @@ -1484,31 +1463,41 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>       }
>>   }
>>     
>> -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>> -{
>> -    uint8_t index = (addr & ~0x2000) / 8;
>> -
>> -    if ((addr & 0x2000)) {
>> -        /* high table */
>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
>> -    } else {
>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
>> +static inline
>> +const char *amdvi_mmio_get_name(hwaddr addr)
>> +{
>> +    /* Return MMIO names as string literals */
>> +    switch (addr) {
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
>> +    default:
>> +        return "UNHANDLED";
>>       }
>> -
>> -    return index;
>>   }
>>     
>>   static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>>   {
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>> +    trace_amdvi_mmio_read(mmio_name, addr, size, addr & ~0x07);
>>   }
>>     
>>   static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
>>   {
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
>> -                           addr & ~0x07);
>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>> +    trace_amdvi_mmio_write(mmio_name, addr, size, val, addr & ~0x07);
>>   }
>>     
>>   static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)


