Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A856C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY41l-0007M1-DY; Wed, 15 Jan 2025 09:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY41j-0007Lr-My
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:05:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY41d-0001My-7F
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:05:45 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FCiuf9013069;
 Wed, 15 Jan 2025 14:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=u+KgADRq03nwfeTNuYHZpDGQGKotPHDguuwIDf0CiI8=; b=
 h0PkkBzTfcS4y8Xk3EaqEFl5fWfVSgOcOoQSEcKF4cnP3zL2gisKVrSXnLRoXw+q
 IHcsBYu8QtH8Ni6EKTWIWWrXChD3+/1WYzZj2YcGP89sUIwbCHPebeYgsH5NnRfF
 MZtLITUrTHgcxssKxfgm44dHv2ptSEx6W3kGS4KT4lDMwc3Wa4WicLKxITGQuPYm
 31APIQN1sHWX3ncTaJl3r4ftE7HfJP48lVuJMlyD9bFb4+LFFN0tjvHlpozgK14r
 RWPofFZpfY/6IldvLA4TWEzGVvV22mGP1ykV6XhpWpDqq152vXyYBZq3Ax2PZWsQ
 4VdQYdbdW0yaHCClYMWkIw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcr9bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 14:05:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FE26iE040337; Wed, 15 Jan 2025 14:05:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39g8vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 14:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sw2GGvdIiduHRihWHMzV/Uzcr703c3VNGqEP5zH4tSMFJAKciyT61gMsDhdg9hmRRMhOne6a8SmoiDv7JUspoiYoRd9krAnxPcQsnj0OkawuJJoe9yLTpj9SQ1UFpz/6ExlOBSf9vpxTrORYGtBt1YS8xAZV1BzOOakJwFgdKqvHkb8A5F6cNjchX/mhswzR4/rtlzGClU7SaxQQqZMzwivSKkKz3sueTGoD53TPKx6/UBTUbhn0AAXTFfQvsG7DPSbSC1JcmyZ9/1ZC6vMBlZFIlEMReKNc43AQWxR7WiPb1gNN+KJJMOrtk98yxDI2Yj9yE44x5XUxqP3BRmOo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+KgADRq03nwfeTNuYHZpDGQGKotPHDguuwIDf0CiI8=;
 b=tPDjwJR5y6krHjquelQ165MfiWQxyy66jzEWiOY4AqGBduatEJSuXo9Okm2s9uF0CC62tB7MA00YocX59bHNgpyiElN+T+SBiIOLmoYVTWGjZM9FbVLytsmxMAy+gETXFyRwtnwQvnqWuhv3TX35z7BQOd/zHPCv4xvxm8fSf5kmaxwwL/vl/o+qzjFoyal+U1OScb+1DkOfKm6bg5bbVrmL6C6cX8QJA/X1kg+p04q6kklL4YJrC5qmfNjurm7+bAyNuM5vjreYzgEbYKBJxeXSUQbnWlFpqjJkP1kjX7h5FWzp5GdO/XG60nEGOFsgk0Q4uUMiJkQt0uOHB6VM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+KgADRq03nwfeTNuYHZpDGQGKotPHDguuwIDf0CiI8=;
 b=XlBC0Ta+ImOHJQvsuCr1MsHp6K9D446NeOxBPEqVsU0e0Mj63qcsRgyPvA/EEzD2n+EMSoLZwfrpXyKRGZuYk0s5Cn0jD809wJHwZ9XBO+8VqwopIktYwwYFFwLJAqdFNRQ8tncEwazwbQpxYjzC3NyZniTZsKcUuvuqOktS3rU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4151.namprd10.prod.outlook.com (2603:10b6:610:aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:05:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 14:05:31 +0000
Message-ID: <4b2ee1b2-cb39-4668-b5a5-761386513e50@oracle.com>
Date: Wed, 15 Jan 2025 09:05:30 -0500
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
 <f51c7838-9f50-4e09-bc8c-bcd71659e61e@oracle.com>
Content-Language: en-US
In-Reply-To: <f51c7838-9f50-4e09-bc8c-bcd71659e61e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0475.namprd03.prod.outlook.com
 (2603:10b6:408:139::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b8f2d2-67d0-4ba9-bfc7-08dd356dac72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uzg2Wk8vQ1VaVGZBTXlKeG1NckNlTDAwcDRPOG1xTk82OWQxTWpldGVLNDI4?=
 =?utf-8?B?ZFhGWDJaRXB2Uzdzc3o1MTFCM1RDM3JJSmx1bk92UnVHRlE4NVhDTm05bGdM?=
 =?utf-8?B?Z2VIS3p6VUFUelowRWcyRVZhNHJxM3JBMENDK3ZoTXVWT1BvVHhGRXBwUjU4?=
 =?utf-8?B?My90NlZKL1hHQyt2ejFOWjlGR0hnS3BhbUhNWWJmb3NJYmp0S1RnR2krRHpK?=
 =?utf-8?B?N1E4ckxoWFAxUmwxc2RwNXFSbkRaVzkyeDdOU2cwYUFsYTE1MCthY3YxSUFx?=
 =?utf-8?B?N3pUQ1pjclplU2VGSVdtYndoTVJIRVN1SVpSck0wMENpUmtIL2w5bGcwQ3dq?=
 =?utf-8?B?bEhTdGpKZHJOL0FsaDEyT3RZcjdtYkw4Tk1xQ1NrcGE3eDdieUQ5dkJ6Q0NB?=
 =?utf-8?B?d0RoczRET1BiNTJHRVZpanNyWHJ5MmIzVGFDQit4M1pDaTlmclVMUlMvSlhm?=
 =?utf-8?B?Wi9RREo5VTZKdFc1dU1ZUUs3Z3kzZVNOUk9pVTBsMEpFbDZCbGpWZ1lZMFlY?=
 =?utf-8?B?Q0hybVlnN1dsQ0FHMUxWUlVaUmpacWh6U28vMCsrTlZtUU1PdHNzM2JPUzly?=
 =?utf-8?B?cmM4cTVQd3ZvekRobHFPR2JXSWhtNlc3SGRtdllMUnVKMnVId1h1eHVNQk5P?=
 =?utf-8?B?VGRQV0F1K1lkdEhoeGkzSDZCRG1CTXVPeGxHOGpBUjJSb2EvaW9oNDV1WHN2?=
 =?utf-8?B?K3pIelNHRU90aTNoamUzZEc5OWFOcTF2SWhPcThWQjdodWRUTWdhVGhKOC9j?=
 =?utf-8?B?NlpiVm84cFJJLzRINWdYYllwaXdMdWFhemtWRCtzN1hjc1ZaSllVeEVRVlNx?=
 =?utf-8?B?VEJmVmtvVjI2bklZMCtYRC9jZDJnTGEycVJnVmQydUZ1SVRZRXp1WVFKSE51?=
 =?utf-8?B?UGlmdlB0eVAxcnc3akxGZ0s5Zkd3dmdsSXpWZkp1Zkt5ZGsyUVp3OUdQQkVn?=
 =?utf-8?B?b1FMYXYxcytWQjFsMUlBa2RSbjRsck1pbFI5QjNWdkpMb05sZTRWR201UUc0?=
 =?utf-8?B?eDFnQzRhYmZ6dWdyOEY5T29aK3BDWDZhNENWdC9oYlBpUDlZZFNvYWd5TVFH?=
 =?utf-8?B?aWorK2VLazl2RVoyNnZhQUQ3TE1oN3JNNTNEQTdXUlVhNU0yWXZKcUdtdit5?=
 =?utf-8?B?UFRDZXVDS1BTOFJjbW1NdXA1SFcyZUxsU2p2Z1hyZldHN0dUSHlVWG9FdlIx?=
 =?utf-8?B?V01qdWs4ankwY0RNWGVaTEhqWWNjNGl6TXpGdGNucDA3L2ZRaHFuQ1g2NHpp?=
 =?utf-8?B?K2NCWDVKTFJWa3MzcEtzYjA3STJWNmtCbjd2a0lDbmxPS1dyWGlHWDhBWGZ1?=
 =?utf-8?B?a0JqQUtFV2Ntc1NwZDkwTUEySS9NS0tKVHA5OFhYUXRDWkhjSnJESXJmSXZa?=
 =?utf-8?B?Qk5MUlhtUkYxNlkwR0JzcTROaEJCRUszTW5LZGR1Y2h0ZE9EeWhFNEVTa3JE?=
 =?utf-8?B?MWtPWnhQZlBSOVRGKzk1Wnpqa1ZocDRuclJuWFV5KzdrdGxNemRoaWNKckNK?=
 =?utf-8?B?c1c4Y1k1OGE2b2g3eWppMjRLUmhqNFJpWkMzcVcyNU5mamQ4U0grcHBlaUlP?=
 =?utf-8?B?N0tKbGEweEE3L3JyKzZEYUdWZXYzUVk0dkhiMHdoWUdOVkEvN21TeDRDdldz?=
 =?utf-8?B?SCs2WHRPdFgwN1VmY1FXdURWQldic2dhRUFGSVVOWC94cUVLb1R1V1lGekoz?=
 =?utf-8?B?ekhlajJJZ05uUTNZbHdnNm9rNnNvREt1cXFoTjg5NlZObXdPV21DTFlWNFc5?=
 =?utf-8?B?QWxMcmZ0WUgvK3ZKWnBjVUJBOGt6WTREWmtnSlV5RUN1K200YnJVSXZHb0h4?=
 =?utf-8?B?VFFodGVwMG51S093VkswQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHZITW5KUWwwZFFNbEtXZjhhS3NhUXJQSm8xVXJWSzRMQWo1em9Ja2k1eURz?=
 =?utf-8?B?VmJSUHJSakVndURBQ3JrL2xvUXQzSVZaUVRkZk1LU2o1Z2VoaTUvUERuY3pL?=
 =?utf-8?B?SDMvQm5XbE42Z3lmQUROQzkrMGkxVVczU2RROWZITmNrQ29CcXcwMDcwVkE2?=
 =?utf-8?B?dEYxdGc0VTVCZjNuajhCTkNkZjg4NzYyTDR3UTdreEdXeTFzSjR6anQ0cTF6?=
 =?utf-8?B?YmxOalpRNlhqSjcvYjB6WlRQeUxPblh2YS9MOVRJZXZrZDVRaktwSTNLWlRl?=
 =?utf-8?B?UDdBSzBGMXl2R1hncTBQdGVmcWRvK1N6d2luSE9pYjJQeXZkV1MwQTlpbXpz?=
 =?utf-8?B?cWhYdWxGWTZnU3kwazVIWFlEQUU2VmdhUkt3NUt5d3Z6TklibDZSY0xUVGc5?=
 =?utf-8?B?M05sSVlGYzJOajNwWTV3blZHbldjUEpBamFoTUQxV2JkVUs5YUF5ZXFQcDZI?=
 =?utf-8?B?R0lpOVhzRUE0TlZmWEdnK2xDL3BJZTcrR3dtQ0daMjhsWEdPTzFpbkgwQ1BG?=
 =?utf-8?B?aFZlWnZuRDZaUEN3dG94bEl5UG4rV05CUmZ5dzQrbzYxVlV6ZVNQeEhrVzAr?=
 =?utf-8?B?RjM4Qk5BZk9LV3JuRDh4ZmZUaTRuUGh3UElUWk92alk5OVMrMXZCeGJFUXVm?=
 =?utf-8?B?Z01DT0NnL05SYy9FOHhkTCt1UlhtVUxuNXpVVmxsNFl5OURoV3R2SnpSUjgx?=
 =?utf-8?B?dmhraUg0bEQzQzdTYloyUDJPUzZyanZKSkZjTzZkcytZekRmcXlyR1IrSWVU?=
 =?utf-8?B?bEpnb3hiSVJPMFFLUVQ1blBFQllTL0FQVTAxblJZZHpXb1loMFlHR3Rwb25F?=
 =?utf-8?B?N2dBUzVsaTEwK2JHV1A5UnJaWjRFUHFFU3E4bmVRVTlUVEp2STVEejAxNXVJ?=
 =?utf-8?B?cEZOdGpOZTg5eGtyUEc3RDhYYkZlRzF5NTlIL1dzZEdUM0tzOGFIMzRYQ2Js?=
 =?utf-8?B?aUtmMStPUlhkeURGNk1pYkRpakpScW8rdVhweDdFWnc5a2ttUmJrUlJ6RlhM?=
 =?utf-8?B?cUkzdjVSb1RzcWV2UGR5R0hveHRBYWpEdFh0Y3BjbjE5WHJ0amVQZW45UmdB?=
 =?utf-8?B?anRKK1NFTUhhbDVPSS8rUytFWFo3SnNYVkJ4amJVT20xSTNRYmtnVUFMWlJE?=
 =?utf-8?B?Z3ozZUpHenhFeFFUNmJBcDNnSWk0aVQ0dlFNODhndFpFS1ZOZ3ZxTXRnOU1i?=
 =?utf-8?B?ZlEzVmZWamFUdThrbFNkSmptbThiSnAyWEhvN0g2L09NdGxBVHJ2T2MzMXRB?=
 =?utf-8?B?ak1GaW0zUWZtK0tqdElhRjRDREd6dUpEM0Y5TGVCUDdlY094Z3hiYStUay9J?=
 =?utf-8?B?VUhURnBOMlBEdGduNVpGVHdULzZnK2NnMWJQM3V0M080WWJBYTVnZXBIbEwr?=
 =?utf-8?B?Rmg1NGpNeWxGTEVhTTBxMFo5c3hCcjk3K3FwYUZSMFFqTlg2cjFObUI4ZTFY?=
 =?utf-8?B?enQvd0ppNjl4RFpWVjUyNE5NMU04K3F4TVUycDlURW9mUENSa0gwZHAwZ1l3?=
 =?utf-8?B?dFRMemI5Y3lGd2I5QlF1THJqdWV4RlJ1eDhVY1lEMTFmdHRvQ2dWZlZSaDNH?=
 =?utf-8?B?NTRzSStmZlp4T0pTMjRHVEV4OWJxWWlvOUFXZXI4djJPRkRDYlh6b05oemZi?=
 =?utf-8?B?dGQyUllEaFJGZ2dGTVdnbE9BaUtNWjJRQ0VFcUVNTW8zelRKaTdybTdaa0kx?=
 =?utf-8?B?akZSYUNGYnpVdGwzV2p5bGlPdmVxb1JWcS9OZVhaSWJndEMyeWEzdnVOVXpm?=
 =?utf-8?B?Y2hXMHpvWU5QaFdscDRadFVyYTVOTmNUMjFjTHZFdjJKRHk5M2lpOW8xWU5h?=
 =?utf-8?B?YTVyNlBONjBKZnFqZGRML1g4OWdrTkZSR3BLMmQwbDlCZGZaSytPYTQ2VDZv?=
 =?utf-8?B?Ry9pUHlZeHlMVVYxc1U2OUN1U0k2QmlYWDArV29uTElINzM1VGQ5RGJDdWda?=
 =?utf-8?B?cjFSR0c2N3FLQmYzT25xM2lYWmtXU3R3TkxCZTcwTjNzNUVwTmtVUHhOMHlS?=
 =?utf-8?B?Wi9nYi9jM1V2eXM1SG9hbjY1U2I5MWJuMC8veUR1Wnc2S0FpRDc5aGo4SUsv?=
 =?utf-8?B?cU5vSjR2WlBnaW5wbDdSTlZPeWhsSjFKLzFodUE5VUljaTR4YVlCNEprbUlq?=
 =?utf-8?B?b0tZNDEzYmhrdUZ5d2R4NWZOT2RxNy9SblVvTGZVMm91TTg3QTRrY1k0TmJ0?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L1lqXzg4LcwDHwzHFh65YO+ybIwDhroZjPx4yIinjlHMy9aGHuZ9dzaZRb5t1vxCBoB4AvVyNRocHjlLRFb5u3DhQG4D6sUK+KIuuOFVAYv7r9h56YdgAm+j+3P27CwU/LHIgVc90lGVSuHgupdSl7tdV5TTvXQ9HMpLIkQ2v1ii7yQsWZeUDR5wAlF15TGmk/RCasvLYAIjOPLGniBOMtP1PD2N+l8OAijZd78/B1/fFHI5bNTUf3ZLwjCVFkk1odL2M8MraqsoR6Fwo75/2TrN8rIIn5cefcSrukR+ftSRS1E6V3lUzuB8E+EXbEQLoWRuOAdwLJ+glFcg7RNDUNlR2i15YLN7jcTxBFWeH3R9wZfVfZFhEEQKtYG38e/M72Ijftt36tpp/QgdQCMNt4tmqIYX/M0TW+XcS82YLivGUTamVJ0I3KTsyDCNQJe5uw3aUNQbwsUtYeiJnOssDp5ItZJmhyuMOtlbbpHN5uPOLfiolyQXLATXKMzJgwnTNiGEOhPt00XlWvpYVImJlVvOSnyYsSMi0uFD65G3B1Oc0+r4blF8ipsbjq/MLmg9A0ZlZp58zP0OXh99lUlexApiPk4xiMfd1bMHqvj475A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b8f2d2-67d0-4ba9-bfc7-08dd356dac72
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:05:31.8715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zM9EZZ3ZStv9YNd30gJFlxZ5mYVatkCQusGS0bYIwyzhOqZmFB58wKm+FXdbbKvRzJAkuVPGBvnS8BpaMMkGHr2OdVnjqtXNVzIhy6KH0oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501150107
X-Proofpoint-GUID: TdFs9GYIdWrCsXCKJCNv8Cd7kTbyQbi9
X-Proofpoint-ORIG-GUID: TdFs9GYIdWrCsXCKJCNv8Cd7kTbyQbi9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/14/2025 4:37 PM, Steven Sistare wrote:
> On 1/14/2025 4:14 PM, Steven Sistare wrote:
>> On 1/14/2025 3:29 PM, Fabiano Rosas wrote:
>>> Hi Steve,
>>>
>>> The CI shows some issues, please take a look:
>>>
>>> https://gitlab.com/farosas/qemu/-/pipelines/1624984802
>>
>> ------------------
>> I will fix this bug in V7 tomorrow.  Same failure for each.
>>
>> cross-armhf-user
>> cross-i686-system
>> cross-i686-tci
>> cross-i686-user
>> cross-mipsel-system
>> cross-mipsel-user
>>
>> In file included from ../util/oslib-posix.c:36:
>> ../util/oslib-posix.c: In function qemu_shm_alloc:
>> /builds/farosas/qemu/include/qapi/error.h:335:43: error: format %llu expects argument of type long long unsigned int, but argument 7 has type size_t {aka unsigned int} [-Werror=format=]
>>    335 |                               (os_error), (fmt), ## __VA_ARGS__)
>> ---------------------------------------------
>>
>> I will fix this bug in V7 tomorrow.
>>
>> cross-win64-system
>>
>> hw/core/machine.c:467:13: error: 'machine_set_aux_ram_share' defined but not used [-Werror=unused-function]
>> hw/core/machine.c:460:13: error: 'machine_get_aux_ram_share' defined but not used [-Werror=unused-function]
>>
>> -------------------------------------------------
>>
>> This bug could be mine, but I need to investigate further and reproduce it.
>> It occurs on s390x, but all migration tests pass for me on x86_64.
> 
> Duh, "s390x/migration/mode/transfer", definitely mine :)
> I will skip this test for unsupported architectures.

I found the problem:

     KVM support                     : NO
     HVF support                     : NO
     WHPX support                    : NO
     NVMM support                    : NO
     Xen support                     : YES

cpr-transfer does not support Xen.  I will check for that in the test.

- Steve

>> s390x/migration/mode/transfer - ERROR:../tests/qtest/libqtest.c:1362:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return")) FAIL
>> 23/109 qemu:qtest+qtest-s390x / qtest-s390x/migration-test           ERROR          199.38s   killed by signal 6 SIGABRT
>>  >>> G_TEST_DBUS_DAEMON=/builds/farosas/qemu/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 QTEST_QEMU_IMG=./qemu-img UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/builds/farosas/qemu/build/pyvenv/bin/python3 MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon MALLOC_PERTURB_=123 QTEST_QEMU_BINARY=./qemu-system-s390x /builds/farosas/qemu/build/tests/qtest/migration-test --tap -k
>>
>> stderr:
>> ERROR:../tests/qtest/libqtest.c:1362:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
>> ../tests/qtest/libqtest.c:207: kill_qemu() detected QEMU death from signal 15 (Terminated)
>> (test program exited with status code -6)
>>
>> Full log written to /builds/farosas/qemu/build/meson-logs/testlog.txt
>> make: *** [Makefile.mtest:26: do-meson-check] Error 1
>> Saving cache for failed job 02:46
>> Creating cache clang-system-non_protected...
>> ccache: found 15435 matching artifact files and directories
>> Uploading cache.zip to https://storage.googleapis.com/gitlab-com-runners-cache/project/43309410/clang-system-non_protected
>>
>> --------------------------------------------------------------------
>>
>> I do not recognize the RUST test failures.
>>
>> - Steve
>>
>>
> 


