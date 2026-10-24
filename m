Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B3606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 11:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKZoM-0001ID-2V; Sat, 24 Oct 2026 07:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKZoI-0001Hy-8u
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:21:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKZoF-0004W9-U8
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:21:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dc9SxectuiRHgkvA7CgmBFx/r90Fr41QhKid1foXgoLe4bDtLg/ktVobPUGr8hkepeyUeqetwXKo7k7vzTZ2r+wgOjAFWL+bsK6XQ/0hVsdBx8aoquN+sXmAQ2cYTkccvMe5l4mk+mNN8XPXuBS0FBlEm79MlSs/lfPDd4vRKi1r83REpBLBmER1wLd9fo4oaFs37s7Jxz6xDTBBz2lSFe93acekCz+hf7dMQqcVmoKs9WnUXNZ+tgTFyh5c+uxn5OSIG0+4OsH3/jqxDOkArnOZ2P7mnGgMfJRoBou1jCoXv1G3Wwvnki4Z1arign3pnOcjT8pO9SYmE92AqbSXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhEFUU8TuVdlNZowDvWBYO8A2CvTEmsbGrZ2MjkG1KA=;
 b=ORpsilNHAaQLtoQKc3nphjLGBKSK2+iicIKwWbaikX4yOKNA/ck8YEDAgwcTB/nS8VmOxt5uHrmlEstu3pMSqNkcqI95vRJPz4igvRBgZ7x+kBwI1F4/wkZwxYjiRxCP95LdpFODGpANj83qZqoE52fv4vlmeWpIK4TTC5R3g8PUYr0YtTIFOfW/e9RE1txLPE3VVfg7I2Et5yj4babsWyPR3031maw2oJxt8nVljFpcN2AMZ8DSAL9J5MO6ii+vxWZo5Mmn6tfR2PIV8fga5vzWrsBB4j1uELP2XN8ddfKYIHNeqkwKOLk2izg49d8z5f0kel1otshlpKi2p3Yspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SI3PR06MB8657.apcprd06.prod.outlook.com (2603:1096:4:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.5; Sat, 24 Oct
 2026 11:21:04 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Sat, 24 Oct 2026
 11:21:03 +0000
Message-ID: <ce143ceb-55d4-4454-9b71-7f3e5f090d3e@linumiz.com>
Date: Sat, 24 Oct 2026 13:20:59 +0200
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Saravanan Sekar <saravanan@linumiz.com>,
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>,
 Christoph Seitz <christoph.seitz@infineon.com>,
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>
Subject: Re: [PATCH v2 1/9] target/tricore: replace legacy DPM/CPM CSFRs with
 CPXE/DPRE/DPWE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
 <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-1-c722e4ca5661@linumiz.com>
 <ef5d6289-547a-4ffc-9535-262fc83ce18c@oss.qualcomm.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <ef5d6289-547a-4ffc-9535-262fc83ce18c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::10) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SI3PR06MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: d817af80-8510-4577-9e64-08df31c0e3a6
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|56012099006|4143699003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 78/Q5b3t32il0OvZ6HWr2KFiNbJds886r4CGYlaVmM5Fa4q7X5WtV0Powo5F+NN8rQK/6lb0gzKnstnEgTPQCgVRnroxCvjWTO66mo+S1d/xkfq7SB9FMINtGoKH+UJ039aiQ8WdOwHWGBXrpZj4DROnddOgfTMBsvnljc53/BHZncNRnJGBWKsOZIsm2/PtcydsPA9+PY4ZVQQ9dpLQEOM0Xl84zXWVJDAw8Fa2hlZgqv/OIM8lX7BiQ71ptGWuKKzG3/tTx2XzgIqnaPVf/d/E1UeKL56BytCIxsmQVPptMzVl3R1K/XslLmc6KTyFCnydS83VCio5LNFQ6QgrKf49R8MgxBK0jm9DEFGwP7qpoTZXd8XAG3Ao9VIVFY4C2aMiQ6FVRNQ7FilAVVNKH/g4Ygdnldi2/zczMN4Qon3BcKs5Fm1xjWPvYftakoLUVp3HpCo9V67oLMiWnBzr4nUuXAEUZQ5XKyL4KwZY67kY30Lln5rBbH5hHSxmAF53CRDx+cZVwW3VWPUA8uvakrAmkYDXvs/xD7tH8Vn9T8KNMICHzUY1E4YxmZ1KSVjrQozCqu1rx5RN8gIzXKyRDhj+zU4+qxpeQs2TM9WrEUf/YI+/M9WWUjkB7P5tvfuXxYqP3WwPpLow6cx41Y0pW6B4X7OpibQLmC/Hhm38atw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhiSGxnZlovNzZLTGZrVEcvYm9ycWZxa2NyVzBZRjJlU3BJUWxoR09iT2Zy?=
 =?utf-8?B?RkhQQ2RoeUd4WW43bEpKdERtU1hiWmo1WHZlYVpKeGRtY2VNeTRZMG1qaGZ4?=
 =?utf-8?B?WTBIbWZUbktjNnRNenBmSmdDc3ZrMnU2V1FhZFhsRFJDSjRUZU9QcGVaWmp3?=
 =?utf-8?B?K2JJZU83aUVXYWVRZEl1OG82cFY1UkM1ZDlFRExLL0h4eHdscnJrcUlVeFZR?=
 =?utf-8?B?d1JtT0hNMVFpQ2NZM3REOTcra2pyZWo2eFlQSnQzR2xhdDhxbWR6dXA2eldx?=
 =?utf-8?B?dTVBM3lpQUtuMnRaeE1uekdPSk83aGg4VG84czVvM2ZsSlFZRTNVWU1aUU5w?=
 =?utf-8?B?YkUyWXA1WDlQS2FoMWNDNWgxdkJQS0YvaEhNR3BJY2ZiLzdLRG1qd3VScFpL?=
 =?utf-8?B?aTdlRmlBVDZvL25kZU9mMlErdUpOVzhDaUNBb01Oa2RjdS80NEFjSGt1b04w?=
 =?utf-8?B?VU9KVzY1UUsydHBIbUsxalYvSXRLTVhZeDB4c05FSW5oWEZWYzNobGt1UGtu?=
 =?utf-8?B?dmRkTkE2a1lKM05YM01oZ3F5K044dzl1REpBdVRJeTJ1WXhGdkJ4Si9FY056?=
 =?utf-8?B?L2Z4T2I4UDBhbkJLdGhsanJNU1VUTTJQNWQ2N3ZETWpBS3FJRE0xZXI2ZEJQ?=
 =?utf-8?B?ajV3Z2JOQzJzTnlWQU5xeGdFaGNLdk94bFRTMmx6VlhvdmlhRjJvdUlHS3Iw?=
 =?utf-8?B?WXZWZXVST1dZOFF3ZElwb3dobEgwQS96Q0NQVW9hcWIxM3dFL1ltWnZpMVB3?=
 =?utf-8?B?aXpaK2FWR3pyT043QWgvTW5VZmFZTXVhaFFwcXhQakgxZ1J5QWM5Zlp4V2Jv?=
 =?utf-8?B?ZGcrOStIOXZRNElOam9vNWhUNmxlVmlvYVNTRTM2ajVLMk5OSEFnQ2RDRkEy?=
 =?utf-8?B?RExZOXBqa25ENm55cGpMOWgwaEZjQjZxTFVoZTBNYVlmTlF5R2hPNkxTWlcw?=
 =?utf-8?B?QWZ2UmI0Qjcwak9kclBoVlNJNGY0c3dqK3JnVWhlRG5RWlJPZVAyQWkzOGNP?=
 =?utf-8?B?TTVVWjVmcHVVSEozcFZIck14dW91dHVjSFhZL2xUWk16T3kzZ1NWbHhhM1lV?=
 =?utf-8?B?SFJZUThtZE1ybG5vRWl2Y29qRFF6T054MnBzT2FTYnVJVzZwREZJZlF5OGlx?=
 =?utf-8?B?ekhwRDdWVHFxdDBDTEFsdzVzeW50RnY2UnI0K25PUy9MK2FsM1NBeG5Rd1dm?=
 =?utf-8?B?bGtHZGYxYkk4MUkrcllTbitjUEcyQzBpcDJ6Nlp2SHRMTDFxWFdrS3RBS2k1?=
 =?utf-8?B?ajZIOVVZeXBCMERuWm9oOTA3S3E3SnZmUnl3anFJVTBTT1RKTzZzK0JUb2E4?=
 =?utf-8?B?NlFHQXZ4ZE9iMUFnMG1IcnRnaVZpR0VsczZjdG1BOER6TkR0K0NEaGZmbUNk?=
 =?utf-8?B?QXJKb1hXa29pQmpyY2RzRUVvMEMvTnRsc0R5OHlhK2hGSGpkYXJ0MFR0azBZ?=
 =?utf-8?B?clJtNVNCQ2pMaDRlUmhxY2RLcG8zMllwdjFJaWhJLzhzbFRyc1JCS0lSRDlm?=
 =?utf-8?B?c1VOYkJyMExRREVNdWdEUHRMWnVWeGkzMUdGUzBmTm5jcm9MVHIxL2pMakls?=
 =?utf-8?B?Ny9kT3hlbmRobGpUanZsUGt1OExSN0g5cEM2OXA5N1QvdDRSai94MHBlWXhj?=
 =?utf-8?B?NmIrb2lzcnVwNHBRZDRmRjR1a3RPNUdKRU5PdzZMaDQxTmduVDNNRkhlV09u?=
 =?utf-8?B?blVlZmNKYkl4WWRWdFdudmt6NlNhaE5QVGVvaDZtenlNeFgxMlgyYUpiWkJB?=
 =?utf-8?B?QzhtR0VEUHRxMVR3em9nOFp4OEU1K29Jam9CTTdHanRJbjkwRFhZalpPLzBD?=
 =?utf-8?B?UmRLNm5YMEpjODB6NUZSdTJzQUhBQ0g1d3gxYkJRa0dKUjRjZWk3RE9rVlRX?=
 =?utf-8?B?ZkNKQ214OHB1bG5VQkY3RUVrVWJXc1VDcG9UMVl4dTNKU3lTTXNuTm8xM0NL?=
 =?utf-8?B?R2J4bi9IRmZVTTBGajZRMDhFMWJHSmE3Y1h1WnVBSG82UFowUWxLNTlZV1BJ?=
 =?utf-8?B?NG9CLzZjaGxNM3pBeHRQYmlGQzVTV2xqcWNaK1RsdXBjdjN5cWFjWGovdllh?=
 =?utf-8?B?bnBoWWhpM0pGQTh5VUQxTWdVV1dVVHpYQVRodzR0cERNU2JrTStPaWFhRFpu?=
 =?utf-8?B?VStFYy9KSWdJbDVWWEdudlVHMWpyMlhHRWxvUVJtQi9XbVFqZ0h4YzYwTU0v?=
 =?utf-8?B?Q0JSTGw4WTdFWXJieXlidTA1T2gwakM2L0N0MFVBSFpqUjB0ZlFKZlJhRnI2?=
 =?utf-8?B?U1BRR09RM082QkZKVHNjdTRDSjZJN1h1VGs0SDlEL3hRMEVQeEdwY05uK05a?=
 =?utf-8?B?UDNEUGlaeXRMZVJ0OXI0MitVRVp2bGoxNGFQUkZmd2RNcGFqV3h0UT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d817af80-8510-4577-9e64-08df31c0e3a6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 11:21:03.4093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KIjgZUutOxU0Lx5TFNuRxbyNq1tF6RZSq7eC5KulfpIuYH7SlTv35lZV8kebXsb+Ek88I9IntFgqgu7g+scww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8657
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=parthiban@linumiz.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 12:39 PM, Philippe Mathieu-Daudé wrote:
> On 23/10/26 22:11, Parthiban Nallathambi wrote:
>> The DPM0-3 and CPM0-3 entries had wrong addresses and were never
>> used.  Replace with the correct per-protection-set enable bitmask
>> registers (CPXE, DPRE, DPWE) per the TriCore architecture manual.
>>
>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>> ---
>>   target/tricore/csfr.h.inc | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/tricore/csfr.h.inc b/target/tricore/csfr.h.inc
>> index cdfaf1d662..24d8310947 100644
>> --- a/target/tricore/csfr.h.inc
>> +++ b/target/tricore/csfr.h.inc
>> @@ -83,14 +83,18 @@ A(0xDC10, CPR3_2L, TRICORE_FEATURE_13)
>>   A(0xDC14, CPR3_2U, TRICORE_FEATURE_13)
>>   A(0xDC18, CPR3_3L, TRICORE_FEATURE_13)
>>   A(0xDC1C, CPR3_3U, TRICORE_FEATURE_13)
>> -A(0xE000, DPM0, TRICORE_FEATURE_13)
>> -A(0xE080, DPM1, TRICORE_FEATURE_13)
>> -A(0xE100, DPM2, TRICORE_FEATURE_13)
>> -A(0xE180, DPM3, TRICORE_FEATURE_13)
>> -A(0xE200, CPM0, TRICORE_FEATURE_13)
>> -A(0xE280, CPM1, TRICORE_FEATURE_13)
>> -A(0xE300, CPM2, TRICORE_FEATURE_13)
>> -A(0xE380, CPM3, TRICORE_FEATURE_13)
> 
> That would break TC1.3 DPM/CPM registers.

Correct, DPM/CPM entries are valid for TC1.3.
I will keep them and only add the TC1.6 registers.

> 
>> +A(0xE000, CPXE_0, TRICORE_FEATURE_13)
>> +A(0xE004, CPXE_1, TRICORE_FEATURE_13)
>> +A(0xE008, CPXE_2, TRICORE_FEATURE_13)
>> +A(0xE00C, CPXE_3, TRICORE_FEATURE_13)
>> +A(0xE010, DPRE_0, TRICORE_FEATURE_13)
>> +A(0xE014, DPRE_1, TRICORE_FEATURE_13)
>> +A(0xE018, DPRE_2, TRICORE_FEATURE_13)
>> +A(0xE01C, DPRE_3, TRICORE_FEATURE_13)
>> +A(0xE020, DPWE_0, TRICORE_FEATURE_13)
>> +A(0xE024, DPWE_1, TRICORE_FEATURE_13)
>> +A(0xE028, DPWE_2, TRICORE_FEATURE_13)
>> +A(0xE02C, DPWE_3, TRICORE_FEATURE_13)
> 
> So these are for TC1.6 CPXE/DPRE/DPWE. Is there a typo
> to gate for TRICORE_FEATURE_16?

Yes, it should be TRICORE_FEATURE_16. TC1.8 uses the same address.
Address has to pick the right register depending on core version.
I will fix this in v3.

> 
> I see there are TC1.6.2 and TC1.8 manuals but haven't checked them.

TC1.3 is an old core and current AURIX devices uses TC1.6 or later.
IMO I would like to deprecate TC1.3 CPUs. I will send that as followup
series.

Thanks,
Parthiban

> 
>>   /* memory management registers */
>>   A(0x8000, MMU_CON, TRICORE_FEATURE_13)
>>   A(0x8004, MMU_ASI, TRICORE_FEATURE_13)
>>
> 


