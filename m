Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C469CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 21:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXobE-00070b-2s; Tue, 14 Jan 2025 16:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXobC-00070Q-N6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:37:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXob9-0001qB-0i
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:37:22 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIXs7B003878;
 Tue, 14 Jan 2025 21:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=4A9r0uOiFlXQj+rFjaUM8bZclJ2ql/G6gw4KaapDkPA=; b=
 f2kEFbKhElGTSpm6tH2uFDf4gySlLm3Q6dzvamkd7NR6/q+BQhqtDYFAD8D94smJ
 FEJQLAaYXfPo6exZE79OUxw7e8R4ii9CT0M87/TJeO0aVnAE2KXcM+wJZWBmOh/1
 f9HqHK8/AfF2KEsx6tF0e1+24lIKKqfSZWNEy6S/i90LOoUnMYHFtjLFC6MKOEDK
 ti2X6q9I/DAaolm6RbTBvJYwjkMHl83ANpJJqqSk3JKwS6blSGbVjogksZLQEqQe
 XnUIjD0b9c/Jo3dpaLoZUFDKUp2E3oEP+JO6QioeM/qnOnGVfEms5+xwddSKLa4I
 ZQ0nH8MlkCaSuowWDqL7RQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjapp0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 21:37:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EKdDeY037139; Tue, 14 Jan 2025 21:37:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f396nak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 21:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIq9K3G4+7ZIe0GpiVuU0GzaSxqWjTy6ro64LOMXxRpywvqYd12h1VfNikj7ORCUPMucbb2kM2nXMdO6IJzesiZREjO+zCl46UoD4KxV9yL//MldRJKJNbYRIikAv7AOOmykcqRLEX1HM5DBTWw1Zy1D5d9ALtiq06VBxpHtsvRy61zxwXVbDoEpquTOrZzaqVCMNfPirb0ijGFB5Ej8mjTm+/oLh0FWG2SezDR6BayL+XgobI2lylZDQJ80fwloZEUw7wvTHHVejBW0IIWyIlUkTewAtEZIBb/wB4dohNxWA3uqrbCxeNkFABTOBynLON2MENAmIYZtYmQP3yWB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A9r0uOiFlXQj+rFjaUM8bZclJ2ql/G6gw4KaapDkPA=;
 b=qhx/lTZ4ShYkFFdKkfnE4kTbKo9ylBTo8ppkHPRxNp0LjGfe1IL4FYs+mQLIOih/s/tvwXndItLtyIM3F3YqkieY+Pnp1uYBBjuzog+0B2vp2Q6Y7YP2vCXpoTJxx/jMxrcow9HIqAm6kgEjw3xnwBIHSRXwZizf0PvnZBwevtsHc1ABUaJkysHvB2UHX9AecQdw5Yse3QB0ytk7D/fOnYML6gVrmDhxePVHuz6I2b7us3ScPr6F3mMgXwtN2sjk8XwKjLhMv+t2QjKste+3hKmvVyEzNgxYpS1PNEFjkeTOdvy0ZUZldf/ozLbZCXt2ZU60hEgpL+aBphz/VXdLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A9r0uOiFlXQj+rFjaUM8bZclJ2ql/G6gw4KaapDkPA=;
 b=mLlRrrPGgnIHTUkvSpYK2lBWdouNu0DLw3OOctVRxHZ+7M/4C9cHrvP1UqwQoJ4RInbxLV2+okLw0JJQPY+9TgcxmPCm6TVhyBZQXvyFk/F6Ue5QelOUYC3/oNrv6m8jXtipdESlHHzAIwR14sUvDWrFCNOBb8SStIsV1ocxgeY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7430.namprd10.prod.outlook.com (2603:10b6:8:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 21:37:08 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 21:37:08 +0000
Message-ID: <f51c7838-9f50-4e09-bc8c-bcd71659e61e@oracle.com>
Date: Tue, 14 Jan 2025 16:37:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/24] Live update: cpr-transfer
From: Steven Sistare <steven.sistare@oracle.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
 <87plkpf8bn.fsf@suse.de> <31ff4dc5-d51d-48b4-ba39-58d864f9ecde@oracle.com>
Content-Language: en-US
In-Reply-To: <31ff4dc5-d51d-48b4-ba39-58d864f9ecde@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:208:32f::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7642b378-d683-47d8-95d6-08dd34e398c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEFyVExkTmhXNUdLZDFMbTE0ZVhwNDFsam9XSjdNVTdHMDNZbUsxZ280MzFM?=
 =?utf-8?B?UVhuM2FPZDJyR2dpdk52ZllKdUhXTEVNTHNHMVlwQWh0WXR0S004MjArMjZq?=
 =?utf-8?B?S01RS2lETlBlWjZSVWFlR3o0cG9KaW9teVNRWXp6aUZwcHFLVDdxOU1rTW8y?=
 =?utf-8?B?cTl5eDhnd3RLZzYyYjJYckN1emgwUWZJTExVMXBsVkhyZXhlc3FVMms2eVp3?=
 =?utf-8?B?alBLblJ2aGZWcEZaa3JpS0NMVmt6elJpbEVHVG1RUFI1RFFKMkFhV3REbFo5?=
 =?utf-8?B?bVVsRjEyUlNMQlpSZFYva1ZJOC91b3hsWnVUZTlOcmlJbWxTdWduTzc5MXQ3?=
 =?utf-8?B?TlhyK1R1MkhVRXowbkpxR0k2cWoxOE9uV3JnamRGTG53RHh1aHpjR2J5T2dx?=
 =?utf-8?B?amt5TlE3RTk2WC84MzJpVWoxK1VkYlJsamVUclAxb1pTamtkajVWbjB6eWFM?=
 =?utf-8?B?WnpzY3dUQVdYVDUweXlYcmRjVDBLUmp1aUJpcm8wVDJ4SVl6djRRbytEbnMy?=
 =?utf-8?B?YmNRM1Awd2E5cGU4T09oOUVpZ0w1bFZtUTBSbGdxeHRyenRoc2lqZVZNQzBY?=
 =?utf-8?B?V2VYNmpBRVpHUjhoQTloVTFzdzUwZGtZT0gyNVgrWGZRWTBlM21qbnJhNGpl?=
 =?utf-8?B?TmxiSE5tM3RqRTNEOHV4cDVoS2RocGd2SThlUThURXYxUTd4K2piODQ4V3RR?=
 =?utf-8?B?Zk1mbGM0czdWN1JtcFNvaXJ3T1p2ZjFXWnA1d3ZaRCtWaE5UL3IwcEhpZkxY?=
 =?utf-8?B?c3R6SGxLejFpZUpoY1NxSmxaTDZTbGdIempvRmdaMFVPSU5BQlBadmU4K2pE?=
 =?utf-8?B?ajdvVmtRbXpnb04vNzJ3ajFEVWZkbFRUdkhReTRNU1o4cXUra2M3NEFuTDVU?=
 =?utf-8?B?WFJkOWtZWGxuL3A3ZWJxOVJEYTB1eDdoVURSUjRZdDNNckpPR2JKdTdhQjYw?=
 =?utf-8?B?V0IrSitzOEV2YmFxeDRqQ293ZWRZK3dPTUtsdXB1enRJQ2VYN0MxZm1RNUxi?=
 =?utf-8?B?RW80b3J4cEY2NzBtcmtVVitzZ20xT2xiVm9kN1JxMjhDZ1BtbDJFZHllTjBF?=
 =?utf-8?B?am9ma1pZeTkwNzJWWlo4UWdjbmp3Z3hOSDdCdmRhcWFhcHA0ejBiVW4vdjRU?=
 =?utf-8?B?Q1lRRzdzRGVhRlhaa2JvSEhqaVRVWUpkVXRXb2pKd1hwNnVUcENpOFZEbGgz?=
 =?utf-8?B?VXlscFFweTZScDAwOHBLaGNDM0dSMkJ3YjFUZEU5MTZTckdxcHpkanlJQkVV?=
 =?utf-8?B?T0F4b2tIdUl2aE0yVWNEYWVqVVBIQVdDMnhmWUVoZmFsNk8rWlF5NGtucUpH?=
 =?utf-8?B?OTBOK2JqUERDL2RxVFA4UE01YVBtTElUN2dFWSs0dUwzUlVyTXBUdXo1a1hm?=
 =?utf-8?B?bSt2cy9PSzJ0YTU5d0pDTG9IbUpVNE52NEV1V2prY2c4SGpyVUxZVVlscXNa?=
 =?utf-8?B?d3hOM05YOEYxVlBWbFQ1M29xSkRTVk1leGlBZExRWml2Wm1TN2VaQi90WmlT?=
 =?utf-8?B?d0hhczRwNklwU3pjc2pwMjNYTnJ5MlZvWTFHaGt1emwwNm50YmVXTnA2dWJv?=
 =?utf-8?B?cyt1R1AvL2ZGWDZQODh5WUNpZVkyV1hWNFJQd0NHaElpcGltMjlwT0tlY1Fs?=
 =?utf-8?B?enZzRnRrOWNWVTdwekYvV3pPOW1Zdk5SVjdlMzNTcGdiRko4SU01a1g2LzB6?=
 =?utf-8?B?QWhTMmdYOXNabDNVSjBnOWhZM051endtNThyY2xTWStvbVZ2aEVHU0Q4QWZ5?=
 =?utf-8?B?VnhwVWFXU1IwL1p5amZKQlhDckxsTTZHVXRtdzBscmNRSFRJeE5jTnVDdDYv?=
 =?utf-8?B?emI2MUJrMk5FUUxxUjFSZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhkYmFoKzBDdVZxRmFtZ3RYTnVjWGNDaVZJcWtUQnJDY0dnYXExNVJCMDRk?=
 =?utf-8?B?VzBJclVYQjlNNHphNTRKU3ZUaWJ2aUpBRW4yTUNMdnJJQVU4WGJmb3RBZlRK?=
 =?utf-8?B?T1NuUUZNaGFsYncxSmR3WUh2eUJxVUtFZjg3VC9YLytmbUlmaVg5Y2cyWDA2?=
 =?utf-8?B?aEZWcU9Gb2tjY1NzTzUrZHMySXZtRHJwbjgzQld3VHduREM5bDVLcWs0Y0k0?=
 =?utf-8?B?ZWNLQUpYN1ZKN24rWW83ajhSYmx4dUJWZFRzQi9DOXBSMWh0Q2ovN2dIQWhv?=
 =?utf-8?B?dXRoY1plRERlSlVjWjNxeUVueHAvZzNLNTYraHN2K09wMzdabXJSdUIvWm1V?=
 =?utf-8?B?by9GNjBCb0xuUThSN3I0SldXY1Uxb0Z3SzdKdnNlNXBFZ3J6eU5RdUdSVDEx?=
 =?utf-8?B?akUwRXA1dTR3aitVZ3FnQ05raWhPcHhUd1dTZDVHd3ZQMk9ET0FOUVNIQTFy?=
 =?utf-8?B?QVJ1aFVkMXJMR25GczY5REJqSFRHNkFSV0ljT3BTWW1GRmJhY0srUERBVEhX?=
 =?utf-8?B?MGJ2U3VwSnJLRm8wdnQrbWEybGR6ME4vY0FRWTMwaVNSeW9xUDhHYWY2NVlG?=
 =?utf-8?B?cnBTTTFBRVFKSytKUXNsY3crNmx5ZG0xZklHWWRKNm5QU0JCWDlROXFKelpI?=
 =?utf-8?B?RC94cTlURit5eGJwc2JsRmdidWdRekdIdUtzV1QxcEpZNEw1YnRxZkdOOTVw?=
 =?utf-8?B?K0RNL01Za0EvOWNFRTk5Z3Fkb1Z1cENlOVp0ZWVaNjk4MWpQL1R3ZGZFRlNi?=
 =?utf-8?B?RXgxNmlrSVFFSVR4L0p0VU15a1BVY3R4V3EyUXBwVGNTMS9kbjZnWUE5UDlG?=
 =?utf-8?B?RUh3bzNGTU5hRkNWWEtzakYvVU9YSS92U1lxNkN0ZlZJaUdSaEVEcjNwMmln?=
 =?utf-8?B?OU9Db1pGQW54Q21sM3ArUXpDTWk2bng5L3hic28xT2M5WWFza1dGTEpjTjA0?=
 =?utf-8?B?ZVkxSmRnS1I3T081OUt0M0VvNG0yWUdDS0hCaVZnV3JDc0hPUUxIcHJVQ1dD?=
 =?utf-8?B?NEs3QlVCWVJpdjdXVHJqTHJjU0QwZEdRYkdHT1dWaGFZQUdCUC9zMC9VZ0Zx?=
 =?utf-8?B?WnNMTVVFaCtzQWZKOTF6d0YxRE5lTzk2aEUvbkliRGRiU0ZwQUpXaytzcXhj?=
 =?utf-8?B?OGh4ektiMWxwMjJiQkJHR2NXZlVHRzA3TFo5M1VtTFV2UFNsK0ZRMVVtSGIx?=
 =?utf-8?B?cXhCc2NTT1Q2ZkxDbWZuTTUyaGRaNG5pZzRZTnpHMDlETXZZZUVyUURjR0ta?=
 =?utf-8?B?MlJIb3pCNml1bmtnNU5OYkJlMWJ1akI0anBWS213ZUUwaS9HZWEvbnlUaHFK?=
 =?utf-8?B?TlNTRFpuZnJLQkpJRnVyMGNCeEF5clJpWU1nZmc4WjBBbE16K214VVdJSnlZ?=
 =?utf-8?B?QTVOWnBSRUtWbHkrcWNjK2U5VDk0clFQSVJ1THZ2d0RsbmJWNnJNa1Y3aE9r?=
 =?utf-8?B?bDhwd0htTU84M0JEaFUvNC9GVnY2Zi9XVEczWUI1SG16Rk9ZR3AxNHFTcEdR?=
 =?utf-8?B?NXZvTWVlbjVSMmtPR1lScVN0TndFWVgyWHBmdTFsaGx5cTZERkhJODBCNHBh?=
 =?utf-8?B?eWJlazhlNnBBRGpHdHB6YXc5OUtvd0NXMi9CdkUxNzJraWh4ZDRuWGhOWFR2?=
 =?utf-8?B?MEhSUExLQlR5cWM1QjZFTzlJcWVzbUdZRFJGZTNFZUhpTG9McExtcGtWSGkw?=
 =?utf-8?B?b0pPazdCcy9aUHVzT01vWlpydDB6aS91dHpnUDJ6Q2NnWHEydFdqQVVlUUxp?=
 =?utf-8?B?OG1ZSjZ3OUEyYWxVK1VTS3lHVElxSTNVMXVieWZUZXlTSkNIMVlOV0JrUmkz?=
 =?utf-8?B?bCsrbmF0UitadjZLUmVHOXhLeVRiQ25TNVVaNGpQUlFLZXRNWEdiQUQzTko1?=
 =?utf-8?B?M2tSSnJpL1lVbkRsdUliQXcyZ2NEYzB0eC94Yzlpelg1K29GSVNRQ0xxYU84?=
 =?utf-8?B?STY4VWxsY0JnN0FqZXVMWm1WalpBTTJQc2hLU2RkR3NIcmRBQU1vS2RYWjZX?=
 =?utf-8?B?RVFmbzErbXlVa08vcFVEOGNGNVEzS3VRNmZpSm1qcHlrQU5FVndwaFBRbUl2?=
 =?utf-8?B?UHFNUlV0Nk8vSTc4ZDM1VmNpU3Y0VUdROFF5MVZLTVkxSEY5cDNPUDg4Rm55?=
 =?utf-8?B?amxmcmp5YnpGTmovNWozTDlxd3dJc0ZiVVVDQm5KSVVIcWVHMDFhNkdjNWY0?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2VCoqb3o5GCAS7nctrF4kNk54yEKAtAKUs2NeioCKlDGIDqVp3skPbifsiu4Gl5A5q1TkY/oXwjdG1RLFc6Ak6eF2jlFpShlF1G+QsNhrqnVQER5vzT082wTYetLK8oO77TPnBNllrWbGbJPaMQODQI4oZUHwW7nRlU1SmRMU/7fqihPDhDBpwhfm1qpPyJ+vPmZeSrfCzAIGaHF/XvqF6V5iPoacW6UTdSGX0wsSKKu1EFtcA0766n3r4sIyaO9dYwwaWepkDMP6VSeqWeO214zHr0mtBhz73kW1ZzKsnyoFsWOxiW8XwcqLzsW0Otfuzx5W774mbAdgSCsG8eWgiQ5rX+cgPSM+0wNOcjTkW4oy8o2zEBUhuN1pz++G/BvH9lb9qJ4OLcBUAt4b38fe/Dd9Qhg6pmkiA/32mKfYldeViqRlPhkyq4yyD9hkSAeS45oKjxWlhOnBwyfth8Svph2tIIDOy5BfekrNkLbkUlljUnpqIxRce6ks2bRV+26Fp6p74z9Se7BLNIKxYzPmi1S2vtBUeMStOjCa9QzqjIgdyJ+suDCjFWO4dYZzq48TP5QNkzL7x7r5CnbT7S8s4eTRgzIKKm34DSWYIoYSu4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7642b378-d683-47d8-95d6-08dd34e398c7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:37:08.4488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5GE3iXmbCBSGiAQeDGqLuIERA4zA3HMXBqsQLewLR8aQ+NFVbnOC7tuJAvFYaVCtLdvWWS9HHcFjFmd5nejoTDYvO95/yVP0lKterdC230=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501140162
X-Proofpoint-GUID: VRZvkAuHa69rYUvwW5ai7cLv_elmGXSr
X-Proofpoint-ORIG-GUID: VRZvkAuHa69rYUvwW5ai7cLv_elmGXSr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/14/2025 4:14 PM, Steven Sistare wrote:
> On 1/14/2025 3:29 PM, Fabiano Rosas wrote:
>> Hi Steve,
>>
>> The CI shows some issues, please take a look:
>>
>> https://gitlab.com/farosas/qemu/-/pipelines/1624984802
> 
> ------------------
> I will fix this bug in V7 tomorrow.  Same failure for each.
> 
> cross-armhf-user
> cross-i686-system
> cross-i686-tci
> cross-i686-user
> cross-mipsel-system
> cross-mipsel-user
> 
> In file included from ../util/oslib-posix.c:36:
> ../util/oslib-posix.c: In function qemu_shm_alloc:
> /builds/farosas/qemu/include/qapi/error.h:335:43: error: format %llu expects argument of type long long unsigned int, but argument 7 has type size_t {aka unsigned int} [-Werror=format=]
>    335 |                               (os_error), (fmt), ## __VA_ARGS__)
> ---------------------------------------------
> 
> I will fix this bug in V7 tomorrow.
> 
> cross-win64-system
> 
> hw/core/machine.c:467:13: error: 'machine_set_aux_ram_share' defined but not used [-Werror=unused-function]
> hw/core/machine.c:460:13: error: 'machine_get_aux_ram_share' defined but not used [-Werror=unused-function]
> 
> -------------------------------------------------
> 
> This bug could be mine, but I need to investigate further and reproduce it.
> It occurs on s390x, but all migration tests pass for me on x86_64.

Duh, "s390x/migration/mode/transfer", definitely mine :)
I will skip this test for unsupported architectures.

- Steve

> clang-system
> 
> s390x/migration/mode/transfer - ERROR:../tests/qtest/libqtest.c:1362:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return")) FAIL
> 23/109 qemu:qtest+qtest-s390x / qtest-s390x/migration-test           ERROR          199.38s   killed by signal 6 SIGABRT
>  >>> G_TEST_DBUS_DAEMON=/builds/farosas/qemu/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 QTEST_QEMU_IMG=./qemu-img UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/builds/farosas/qemu/build/pyvenv/bin/python3 MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon MALLOC_PERTURB_=123 QTEST_QEMU_BINARY=./qemu-system-s390x /builds/farosas/qemu/build/tests/qtest/migration-test --tap -k
> 
> stderr:
> ERROR:../tests/qtest/libqtest.c:1362:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
> ../tests/qtest/libqtest.c:207: kill_qemu() detected QEMU death from signal 15 (Terminated)
> (test program exited with status code -6)
> 
> Full log written to /builds/farosas/qemu/build/meson-logs/testlog.txt
> make: *** [Makefile.mtest:26: do-meson-check] Error 1
> Saving cache for failed job 02:46
> Creating cache clang-system-non_protected...
> ccache: found 15435 matching artifact files and directories
> Uploading cache.zip to https://storage.googleapis.com/gitlab-com-runners-cache/project/43309410/clang-system-non_protected
> 
> --------------------------------------------------------------------
> 
> I do not recognize the RUST test failures.
> 
> - Steve
> 
> 


