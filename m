Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B5BE8B39F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 06:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnWgH-0007rk-K2; Wed, 04 Feb 2026 01:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1vnWgF-0007rO-BF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:48:03 -0500
Received: from mail-westus3azon11011066.outbound.protection.outlook.com
 ([40.107.208.66] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1vnWgC-0005rB-Rv
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx4e6w5sXepcqbmtCK4DszS3PofUVSPR3bGznVtjZvOUZi0dWfXmUWLvroO7MOWfXKogcPudPsi+YJnGbF2g8EDDieYDviIxNYDlGP/Zl8yvGxAjJF3dVuRLW69Tzl5uHUVRzzhfZ21/IcJBWJJaxeMhdlDYuYLHia/oBKeOpR4+EUZoed2WqX74F7xq4I3NPnVrkHF7iJXZBherYWBmvUi9y03gdyoK1PjxPp7Ocb4iiEWrY5yV0haU6UqaAqkOGzhTjZ7NCGTDRFAcHGyPzbUR/BlkNJ2WXTv8k/hHWcDJ9i6P/3NcUT5+CiRz60U+yTIgDB2WAKeLMm4LBeuWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9clVYLlSpy9CksWF+Ayq2TcvUtjtoDxpyDafa7tPnHs=;
 b=FeH7McXe2kPOLvtCHUJ6VE8q4rUZxHTun5E/IW3d51xO3wGRyn/kaYu4C0zW9VwAzsOoEKuWkiTipQ/wNBOUqCHJXdBolumttkinPS1uRdaX0UFRi8/Ot5Sv/Ha9ZtZTfmyc4eR6Ak9oocEyNt7YsLckr3NkwYEWli/SYVGvEeXESZ8yoGNb3GFk61A+I5ozH9tm0tPhXJb6jfc1sPiO6+Kqkl4brhslsFxEZ6mjUEBDQaQcvKPLPBlfaQzE92vUn7n/r+NxxYwCT3BZC0RpG8QmkFBToMb3OQLkuPcmB/lTZZpBNTk8HtSuFGTeS75/vChFPauUktXD1MQF9B+qBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9clVYLlSpy9CksWF+Ayq2TcvUtjtoDxpyDafa7tPnHs=;
 b=P4q4DRaHa+21vHtt/0SqDfzuvFEzXlPF+k1PZZ1nK/ckA0Eyi3+AjWOt3pbd31/MnWhrWsBQgE7b8dPmlx5D814JSiOEVQ/CPDdaWoCnsXVvidej+i5nfU3gByidolGUJCO7KNhp3rXGI7NGMTZnXpBbhU6UUx+0+umuGfjibTM=
Received: from BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Wed, 4 Feb
 2026 06:42:54 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::68) by BL0PR02CA0142.outlook.office365.com
 (2603:10b6:208:35::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 06:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 06:42:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 00:42:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:42:52 -0800
Received: from [172.31.180.39] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 22:42:49 -0800
Message-ID: <fbd7da6a-5b06-4fb4-9edf-f2a53a137ea0@amd.com>
Date: Wed, 4 Feb 2026 12:12:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
Subject: Re: [PATCH 2/5] i386: Add CPU property x-force-cpuid-0x80000026
To: Zhao Liu <zhao1.liu@intel.com>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <seanjc@google.com>, <santosh.shukla@amd.com>,
 <nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <babu.moger@amd.com>
References: <20251121083452.429261-1-shivansh.dhiman@amd.com>
 <20251121083452.429261-3-shivansh.dhiman@amd.com>
 <aV4PgVwYVXHgmCi3@intel.com> <8ef42171-5473-449f-bd72-e9874fa6f7f1@amd.com>
 <aWSpZxg7kKrdBifu@intel.com>
Content-Language: en-US
In-Reply-To: <aWSpZxg7kKrdBifu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdca86e-afbf-4b4e-f274-08de63b89fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1FQQkplQ2JMVFlaeHI2K20rVE1kMjgvUSs4YjBFZWdLVGN2ZzYyeVJLNXdN?=
 =?utf-8?B?eThpZjdSaGcwcmVBZjVrdldQTUIzS0RtVWlRRTdaZkloSStnV1dLSmx4UWNJ?=
 =?utf-8?B?Q1RCNWMvSlRVdjArN2F5MEFMRDVPQXgwc2x1WVEyUWRBRWY1NWtHaDZpY01x?=
 =?utf-8?B?Z3d1YmtHSDczNHVJZFFmQzhxaDZVZWk1QWxSdVpvcGtVVWdrelhZYTBWQ2I1?=
 =?utf-8?B?MnpEL2xPN0pyTG9hditFY0d1OUhEb3BBWGRycW5HU0l1d2drR2FRR0NRelhk?=
 =?utf-8?B?NEdkNUcxU0tNSmFjS21nYklFQ210VkhBTWppa0tRNHVzWDZLOTBKR2tBVk1h?=
 =?utf-8?B?QXllZmhIUUZKUk90SkV4a2Z2VmZSZVFUWFJDZVlCMUUwVVRuSGJ2QlJEUlBT?=
 =?utf-8?B?KzFlK3l4MkR2UXpQTGhwaVlnYzZlS1g0cmRVNGJTc1NBdnFWY3JteCt1eGhW?=
 =?utf-8?B?UmpIeStxVlZ3OU1KS1FsSXZzb2pHKy8yWXNJRXdEdzhFT0FFa3FLb2s1US9R?=
 =?utf-8?B?ellqZHVUMmJyTjJhMTFyd2RKR0IzN0VDQnlEY0tZM0RZdDR5aUxsZjZFb28z?=
 =?utf-8?B?UnJLVHR5RE8xeGo1ZGNER0xaWXYweXpJTFZsSXlTZWhLSms4OFdSVXhpdmRW?=
 =?utf-8?B?QStYTE0vek50VkJFTFhuUFRwS3g5bThmWlV1MmZIMCtsNy9PQ2lNVjMybHFY?=
 =?utf-8?B?U1JYSDhQTXJIZmdlbGJRMWVremtRMHN1RUhWZC8vSXBDRmxmVTJxZzNUVW9p?=
 =?utf-8?B?TWFUbU9ISmptSW4xVjZNTlQ1MUZ0eWVuVENNc2ptaHZmSG9KblFOdjg3Tm9U?=
 =?utf-8?B?bVFDQmZUYXNIaTBKLzNPWDBsU25ubTdibFBuSzZEMGxMV2t0aUZaRXpXTURj?=
 =?utf-8?B?TU80dDFjalNOazVyY1R2UUhqVXE0WStSMGpPMlFJWXl6MkpYdldXbE9qdnlS?=
 =?utf-8?B?QU9OdTdKRTdrWDJOSDVObCtmS0xiNGFXRXFTVE5KY1NraVIxdUFPNTg1OEhK?=
 =?utf-8?B?YWRZcHJvNmNLVHNBSzR4STZwYXdNRkNKV2V1SW51VWdPR1R2cFlwRTlJeDZB?=
 =?utf-8?B?VzlJTzBUZjFRYzJSNGc5TmFhM1VYSVlhQ0JoanVJNG93TlkxWjBjc3dTUVd0?=
 =?utf-8?B?ZDdGRDhMRDlpME8zS2tGQ3NvQVNVVFl3L25rUDdITHZFTmw1dEJKbk9SWlVa?=
 =?utf-8?B?cGs0SmQ2SGtxVi81M3pqcm9ETGFIMDljTWZXSHRYdGkvcGJ6cnpPM0J0RURw?=
 =?utf-8?B?bzFMT2Nlc3BzWGRWdnJuemtrVElWc1V3TEJaeDZuQ1Rpd3g3RitHbUFuTFM1?=
 =?utf-8?B?Ym9xYTZlVmRGa05JeC9BazBBMmJhUUpPNmxNRWpmdUo1UGRlUUhxakplY3dz?=
 =?utf-8?B?Zm9OOHVobFdFR0d4M05mNGZBeG9xUUtZNVExWFRYL0VNL1dNZmFTSVZsUTQx?=
 =?utf-8?B?R1B6WmJxS0tHUkNnc0tFNGJtSHJWWCt1alhsSWpHaWFaQWZ1bUlOMU5NSVJx?=
 =?utf-8?B?VXNwcFRucnNOTUZycVprSVZzVVdLdHBOVXVsbldSa2xhOE1lQnlUZFY1Z1hz?=
 =?utf-8?B?SEhVdlFrZmtyUmZzTWttRFNUZHRiWVRVSmNQQ3hDcVVRNEZ2cVpKaTZYSElG?=
 =?utf-8?B?ZGJzdkpCeG13czVQL2sxaGFBdFZpRVoxOUhyS01TRk5yMEYySFk5eDJ0dHJn?=
 =?utf-8?B?TnhVYlE3eHZUZ1NJL2phZHZmVTJJQVZ2amhaQlpaV3dvaURtYm01dnRFTnZV?=
 =?utf-8?B?dU9wbEVqbnFiRm9PNlh0ME94S25iZXU5bml3Q0E3U0twN08vZjJIS2tsd3VQ?=
 =?utf-8?B?SCtiMTREblZEcmpGZ1BOYk1JVlJ5OThQQjNpUUhWMzQ3bm92TEZkUWIrcERN?=
 =?utf-8?B?TWVmUmt3ckxuZW0wOHJBUTBvenc3Ym9vWXkwZ0E2V2RoZUt2OGhyQjV4TFZ4?=
 =?utf-8?B?bGVZbGlqZXh0NnAybjdmWGJFY1M0anVoak9kekVNTFYydnZneTlqTFlpbzBB?=
 =?utf-8?B?OWhHcFRyQkR0U2MrcDZHQU5WYlpuZi93NitXM3FuQ3pCZC9UQ1F4eExOQUNj?=
 =?utf-8?B?aURnaHl2RVB4WUFUK1dDVzd3cXFLN1h1QlJDNGxKSVNxa0kvdWMxRkNrcjZy?=
 =?utf-8?B?WW9LVjBVcGpXRndPYXBZOXZUTlZvNlZ3ZUU5ekJ4cERNR3o2VkErazZsb0hD?=
 =?utf-8?B?emJGeUpncWE0emZxM3h4S01vNlV0a0Q1bFFqam9jSEJ1a3FtdnJSTGlNV2xx?=
 =?utf-8?B?djlSM01HWE1wYmV1bjU1ZHUrSHBRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MN/2MwL15+Y/ZUHlZv3td8YBdhesx6OLIj3KOg5nnuctpHjQ9Cvs8VJ5wxZ4zpk+sabJI0nTOB+Bdv65epwAj1nYsodWtLGhuGk1n6zd7v0QGkzLSloAUAXVr5vDaigMiYE101UopCypCVcp9fflfgoobsuI6WQU/MYmfvyhGSXYed/EYJzkQs45ST/fd3eNXEnfqQPT0P4IuXVqLQZJ4Tqvev1Tn9de/P0sTUJ4MVo7qMWquRSlvwXdO/FhE5V2nDj9kg1jauj8wykLibqqEQqdKg5hJ7Hs0Vcyf5F3OnFDE8e/uDEPzAv0swbcLjhSnyYvyzxBjiIsBzdtjwtnFzFJWhluvxu0fl2viqYVgGPLMfTzDFMC/6+npVNBkyroQEXDf5hMcYROryWFSw4Y1J+ZH/dwByFixdFh5NgrJIWgCpIxr7F8TxgLxdCT+iRa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 06:42:54.0053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdca86e-afbf-4b4e-f274-08de63b89fde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
Received-SPF: permerror client-ip=40.107.208.66;
 envelope-from=Shivansh.Dhiman@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

On 12-01-2026 13:27, Zhao Liu wrote:
>> On 07-01-2026 13:17, Zhao Liu wrote:
>>> On Fri, Nov 21, 2025 at 08:34:49AM +0000, Shivansh Dhiman wrote:
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index b7827e448aa5..01c4da7cf134 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -9158,6 +9158,12 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>>>          if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
>>>>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
>>>>          }
>>>> +
>>>> +        /* Enable CPUID[0x80000026] for AMD Genoa models and above */
>>>> +        if (cpu->force_cpuid_0x80000026 ||
>>>> +            (!xcc->model && x86_is_amd_zen4_or_above(cpu))) {
>>>
>>> I understand you want to address max/host CPU case here, but it's still
>>> may not guarentee the compatibility with old QEMU PC mahinces, e.g.,
>>> boot a old PC machine on v11.0 QEMU, it can still have this leaf.
>>
>> Wouldn't initializing x-force-cpuid-0x80000026 default to false prevent this?
>> Oh, but, this CPUID can still be enabled on an older machine-type with latest
>> QEMU with the existing checks. And probably this could also affect live migration.
> 
> Yes, on a zen4 host, booting an older machine with latest QEMU will have
> this CPUID leaf.
>  
>>> So it would be better to add a compat option to disable 0x80000026 for
>>> old PC machines by default.
>>
>> Does this look fine?
>>
>> GlobalProperty pc_compat_10_2[] = {
>>     { TYPE_X86_CPU, "x-force-cpuid-0x80000026", "false" },
>> };
>> const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
> 
> It looks fine if we only check "if (cpu->force_cpuid_0x80000026)".
> 
>>> If needed, to avoid unnecessarily enabling extended CPU topology, I think
>>> it's possible to implement a check similar to x86_has_cpuid_0x1f().
>>
>> Do you mean something like this? I avoided it initially because it is
>> functionally same as current one, and a bit lengthy.
> 
> Sorry for confusion. Could we get rid of model check
> (x86_is_amd_zen4_or_above)? and could we do something like 0x1f leaf,

The CPUs prior to Zen4 do not have this CPUID. So, we need to match the hardware
and avoid enabling 80000026h on guests booting with EPYC-Milan or older. For
such a condition, we can't get rid of the model/family check.

> 
> static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
> {
>     return cpu->force_cpuid_0x1f ||
>            x86_has_extended_topo(cpu->env.avail_cpu_topo);
> 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> }
> 
> similarly, apply x86_has_extended_topo() for AMD CPU as well?

Something like this looks fine?

static inline bool x86_has_cpuid_0x80000026(X86CPU *cpu) {
    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);

    return cpu->force_cpuid_0x80000026 ||
            (x86_has_extended_topo(cpu->env.avail_cpu_topo) &&
             x86_is_amd_zen4_or_above(cpu) && !xcc->model);
}

> 
> x86_has_extended_topo() also checks "module" level, but I think we could
> return error in encode_topo_cpuid80000026() for unsupported "moduel"
> level?

That can be done, but it should be harmless to let QEMU encode 80000026h when
only module is present, right? Another option can be to add vendor specific
checks in x86_has_extended_topo(). Thoughts?

> 
> Thus, when users explicitly set these levels, the 0x80000026 leaf will be
> enabled.>
> Furthermore, I think it's better that different x86 vendors could adopt
> similar behavior for these extended topology levels, especially since
> they are all all configured through a unified "-smp" interface.

Ack.

> 
> Thanks,
> Zhao
> 

Regards,
Shivansh

