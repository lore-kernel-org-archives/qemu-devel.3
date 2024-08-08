Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2654EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 18:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc7wH-0000VT-AD; Thu, 08 Aug 2024 14:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sc7w7-00006V-Ld
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:32:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sc7w5-0002S9-1N
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:32:31 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfXLO017666;
 Thu, 8 Aug 2024 18:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=w/LSA6FaM+w2/beryG4u/Gg2m43TpE8H7Z+yzwCifRs=; b=
 PbVGwNHHCa5qlMzBoGIu4Tbczr1d1cPUiWUKWI1Y5xOT6leZA0iLrg2IPleP0e5T
 hOGr0kHMXOyJ2LXJav0kQybhDhTpyoDzcsdJpMjRHle37YiGHDZ2av4VFtAFnQO0
 FanSIhpENphKHTcq13trqGCOcrRQOnfN1+3SWYidDRHeDtFz7IDALCZvCxxvKm1U
 LhGZvPXvTD5Izq+h3Eyrc5p7jz2gYtcvrpa5LqiUQBgvV5712RIZEWsyYQKZPa8B
 PzNsRFuZ4GbSKCtZTso28OAgfUN5GDcrQ7+l05oG/u2hFF0mCs1wmMJ8GXhhDkKA
 kivE7k7hopDDdpfo4paOKw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfatkpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Aug 2024 18:32:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 478HA4tg040674; Thu, 8 Aug 2024 18:32:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40sb0c34xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Aug 2024 18:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1Q3XdpqDoEpbOpVBBvDLwfJnf/1D4CWgbgYzaiB3bxLnPVZWAiUbvKlz8e776daV+1MJds1eQYbyxRYR0B+RjdD/V8fhtD/2BG6GmxejIBb2fwrVgNB+oAHJ5CWKc0nBUOoaxRQYEwHtlLj0gjbEsix5afvfJcF2qLvt+9qcq9DR1VMnfzBdfEMtAU1xbV3AQ6FWvqttkltak60Z5huugP1KelfRwptYqXKFpebimq4Xf4nemkaC0+zejqjQjrgboHg5YRVC4CLhJuJGzdiFMfXQlvMnJp1vNFpRWuIytqRy2t8X6pOhu08O65y6qVjSzreGhUwguMZDEZNLUomtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/LSA6FaM+w2/beryG4u/Gg2m43TpE8H7Z+yzwCifRs=;
 b=jkJIKsq0h/S1dKUIh3c95NTZUFUqGFRUiwhieec+fEm92JHkplO8keaiztUWrEfYEPt/RRTWEr7L3HrjUz3lby/Brw/hEnxstFhhflii0MFo/Ju1PPGnfCzlFS6Ou8Dz3lBhXvJMxI1HtQIgRkbOCf+mSR643gfxg9JxWR18dkGPdh44BfN4Fh9sslPGGtn+Cwx1JxM+kb4lnwLbs0Oz36vbDF6Yable+ihBxI1KOSBkwELcf8ssj9w27em7qR8tsIeHc94z+ApHyHQpZJcxw7OgOMNdH/dpKZJ+bvt5Anf9TDym4SyegXuA4NAfmUYFkM2n/juzh8yOo/s7tl7hmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/LSA6FaM+w2/beryG4u/Gg2m43TpE8H7Z+yzwCifRs=;
 b=s2WTHgZiGDojgFH6thCQ59WO7ELbEQZfukRGz/A/Xz/3hUNf5Z16bd3sus1fJopma+8iT6Tu1LjT3Fyn8EDcX5okqnrCjKRZK1O4UVJZJ/z2oxM94UQtnEBaTcDA9zBbnnqstGl5plDQD8e+y0l7LT7TITpx0eJsxKsMRAt6RSc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 18:32:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:32:19 +0000
Message-ID: <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
Date: Thu, 8 Aug 2024 14:32:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 316d1ccb-e7bc-4b70-1ecf-08dcb7d86f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmxTYVhZNW5haXVVU094L3FxeGtFd21WNTNaekJtRVErcjJqdFdNNy9jck5m?=
 =?utf-8?B?UlB3OFNXUjZWcGFhR25OQ1pQUUpsei9yZXgwZGdwcnhkWWx1cU1RSzBpV25h?=
 =?utf-8?B?aHlnQ0U0eGh5d05sNWNYd2ZVdzNhdERRS1NXWHdUY3JMRmp5M29FZ0NRRkcz?=
 =?utf-8?B?WnpzK3BjVFFvbGhFbFVYY3UzQWF1ZjRVa2RreWttMGVnYzRSZ0toK1plOEtQ?=
 =?utf-8?B?aW8vZGFEdzRFQWFvS2U3Ukk5MCtLYTdwdGlEdUNqdExvOGdrOTkwTXJrMkpy?=
 =?utf-8?B?T0VORkhsMDh0d3FGUHRsc1d2eXJGVlpNQWdaeEgvNWpPWk8yTTlicjBlQ1Fy?=
 =?utf-8?B?THl5SXhCM2MveXQrRUs4bGhWVVptNWpsVGt4V0pyaEgzNzIvalpuS2ZjTE11?=
 =?utf-8?B?dnhHU09sL2ZEWXlOeHpxSWYrZDhOc2FIODhCdXJxSGRKbGljWFlrQjZYclRp?=
 =?utf-8?B?WlR1a0lvdVBBYWd4VUdYZDNEQ1JOaVUvT05ESXFYM2VjZWsvaGRUYTJvN0VQ?=
 =?utf-8?B?UVlKOFF3TThTa1VlRmFqaHhGSVVWZ21VVWxGSGN4YnJPT1BqQklvblc5TkNq?=
 =?utf-8?B?dzZnTWt0MCtIbGRiaG9iNVZEUXpTREl5MU5lRko2SlhYR0Rab0p3Z1cwaUdt?=
 =?utf-8?B?Z2dGdUNGQ09Ocis2d2VranVwa1BiZnh2Z1k1cE5DQTU0azNab0VGY3A0bHY5?=
 =?utf-8?B?aFp0djdrYngvUVhuRjBhWkZodmZrU0hzTUZwbXdWeUhSc1pxeG1OcDduSkdQ?=
 =?utf-8?B?bWU2OFlueXZSakRxMjJqUkM5Q1VQYmUwcWwxVStHbjdvNmZHWkV5ZFlIWEE2?=
 =?utf-8?B?L0JqbmZXdXIzLytTK3dmcEdrcHA4LzI2RGJIOXNUMlJxMDViUzIwWElLdEt2?=
 =?utf-8?B?YnA5WjFxdnhybGFMSUZGMm15eFVSWmVManRFanVUbFhXRlhGZHl4dDFqbHZm?=
 =?utf-8?B?OWtFR28wYnd5eDJEMWRZTHVjbTVEUnl0MUtxMGVGQnptU2FKQ2FFTXYrY3Fa?=
 =?utf-8?B?WWhsWkJZTUJRYTNwK2Q1Y1lwdG5GVDA5ZDZCaXUyS3FqSU93M1RoVHZ3Vkgz?=
 =?utf-8?B?U25OQ3A2bDRzMmxkbVgwWXVoTVJINDJRSUlMZmh6SlhFOUJSL2NlbmtoS3F3?=
 =?utf-8?B?Wmc1OFo4UHJFd0tEL1lpcHVwakRoaG9OTVphOTIvTzlneWFkMkNhbUN1NmE2?=
 =?utf-8?B?TktDVEovOWhZbkV5N0JqdzBBcUt5dUJYTDNwRkhVa2NaVVpkbVhtUTR5YUVU?=
 =?utf-8?B?SFZsakdzNlViRW8rUWMwdzBERDIyN2x3bDM5QTIwdHRZTVlXYXJpbEMzeC9t?=
 =?utf-8?B?b0M5dzAwWlpxMlBWNDRUYkIzdmk1cDNNOEI4b2Z2KzlNZUt3UDI1UU40TnUx?=
 =?utf-8?B?M29QN2JYQnJ2WmF4WGhiRHhNU2txZUcrV09MeU1oMUZXbjlXb1hQeTZjckwx?=
 =?utf-8?B?SkpXSGM4cTk2MFNuSldyczY4U090Y0s1VG9IMzJObStodGR3UWp6ckVtOEhQ?=
 =?utf-8?B?TnhmVENUL2hVNEtRS1Y5RmNLNzdOdVVyU2JKWUVoUE4vNzV6RjNQWURWcnNS?=
 =?utf-8?B?TlNCTUh3VzZETnFiZjY4NmxxQXBsNG1yZ0wrWVJoL3ZvTGFFR0lvQjVzaEFE?=
 =?utf-8?B?dk4wNGlUdXp2UytxN1p2ODVUQnYwcjVJbUNQaU9yMUpVV3RTTlM3a2hPMWpL?=
 =?utf-8?B?UmxJL1pyL1IyRzZXamErRFJhWmVxamlHRGZjQjhLN0lESzBVa0NSTGkxbTdN?=
 =?utf-8?B?c1VJWmVqSDEreXNXbjNDTTNPVjN2UGFGN1R0V25yYnEwcXpsRXNpOFZsUDds?=
 =?utf-8?B?UnhVWURGcGloTzFGT0lmUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVqVDRFQ096MW5KcWdwTldDWDJKa2I4T3ZNdDVTOE8zOUNxckcvd0Y1Vndu?=
 =?utf-8?B?ZnBWUG1VMGhJV0dBNUdaVElFREd1TVl3dVRoZ3czSWp6RzZ5TVdZbHNvQnpo?=
 =?utf-8?B?VWhsQktCNmQyYWF2RjkwNloyR1AvNU5teTRZcDhpU2pSUXdYY2NjV0duZ2dL?=
 =?utf-8?B?TldvUWNrY2hDRkQ4aTFJUEZuNm5BQlNhM200YUtNaEo4UHUrQ1N5dDl6TTJK?=
 =?utf-8?B?cDdBQjMzeFhyYjFLTEZhYW5mQXBFdG9lVnRjSC9acnJsaWJUa0k1ZGE1SHdp?=
 =?utf-8?B?cy94WTM0b2UwZE9ORTgwVWFwYmxKL3BYT2hvUnJKUXY5eXlzR293VTdRMmlR?=
 =?utf-8?B?WW5jRDVMRFNsazdDMEhkZEYyNVN1SjByMHFWL2l5MGdnNG9jRDhaOCtNVzdX?=
 =?utf-8?B?MWp0VXBVTTU1UFRKazhoalZyU2svU1BiRCtKaTVHMFRiRFlQaC8wVEdBRlJx?=
 =?utf-8?B?VlpRM3JjK2tLV0VyL3lVZ0lMYVRGY3BLdWY3ZCtZeitDNmR3UjhXMGkvZ2w3?=
 =?utf-8?B?VkhLSmg5clRUUjQ4Y24vL0s3QitSeU5jVlZSMHVmRjFLQ0NzcGR0SFViYzlm?=
 =?utf-8?B?dytrN1JDeFhkaGpGNzF1TFRCaStFU09sVUNPOE45UGF2SVRxSEJkN2N4K1do?=
 =?utf-8?B?YWlVV2cvMC9qelB1VlVtL1N0WW5yY2VQbjhPcTBCRWVtS2paNUErU3QxWDhQ?=
 =?utf-8?B?UGFYbjFEK29lWFU5R1R5UHNnR2NJcXlvSzRsKzE5blJveExwMzdOWDc2RXhz?=
 =?utf-8?B?LzVUSllzeXNoQ2Z2ZzFnMEJUMUJQSnRPYTMxbG52dTNMZWZFWWVxWS9KbDMr?=
 =?utf-8?B?UHVqVHJGWUlLbC8wQVl1VTBTQXE1bnp2c3c2VlRYKzlZU2ZWanR2SHVQVEhL?=
 =?utf-8?B?L1Q0a2RUSkMyTlZiakNWWVJMSnBOVHByVDBpY1ZyakdET3RWeno0RXRqalJM?=
 =?utf-8?B?NW9tclpyR1VSY1VTaHVKZnRPR25OSDQ4K2Z2VS94YS91Z0VUZFRJSThDVi9R?=
 =?utf-8?B?bEozc1JvQUp2UWRQNmQ4SGgwcTlPQmVWRGY0VXhsVit1RFlJTUlHTFl2VmU1?=
 =?utf-8?B?aUtHWEN3ZW42aFJaLzk3K1E5WjJvM2E5OUcrVVQ5NlU0bUxjTTNuL29DeFF0?=
 =?utf-8?B?R2l2anQyeWZ3bU9nOVVZVGRBUWhKZmFucGZUSmRYWXFPdW45N2RiV0pkdzZX?=
 =?utf-8?B?L1BsUWZ2R0ZlNkovakN3TDFvVGM1N1E0TnpYa2sxSEltWWdwQlRDMVdZVlEr?=
 =?utf-8?B?SUdTY3FLL0lLWWZzNE1xalBILzNLUUczd1hxRVB6WitwTzRFRGdnb1phdkkv?=
 =?utf-8?B?MGQ2WW13Nk1iYzhqZEt6bTM5SEsrM3BaUEhzRVZ6dlgxWmJBNEpDQjhOVTMz?=
 =?utf-8?B?MjN6L3A5emNmTWsyL3ladStqdnIyMHBGVTdrQ0FURldHeGlxQmw4akt5THhS?=
 =?utf-8?B?UmdDRzgwbGpHYk1KTlJCMnk0cWprdE96b1lBYW1QNHp1NU1iTGxHT2RzOWVW?=
 =?utf-8?B?dHdhY2p0K2w2WElqRjA4QXYrbkZROWowZjdRQ2JSeVJvOVFSeXBEcVRGZ2JH?=
 =?utf-8?B?WktxM1VVa252SFlEV2JDdG9ueVRCL2I4TXB1SkViNTVZNHZPR0xrV2oyNFdn?=
 =?utf-8?B?d1VxRGgrTHp2TFJIQUdtaTA0YmlKR1RvOEV6blZUWitNMGZvSFBqMnN0NHJZ?=
 =?utf-8?B?aHFEbm4vUFJyM1JjTGQwNTJnU1czY0V1VC9MTGNYR2d1QUt4bTUxb1pKYUdh?=
 =?utf-8?B?OU56THhQMDR2NEc1SE9ZeDVSRTMzdzJRL3loSGFhbld4R1QzcDdQaVIzd3Nh?=
 =?utf-8?B?c2xPc3J5TWovZC80dVdZbDBoeExWNWdqL0tEWWsyRTVMRENhYXNSTkVwYUNV?=
 =?utf-8?B?VytiY3UxVEpEOGpuMDlPaTFwWFFNd3p0eDRTbnlXRVlnWkYxWk1TdElXM2hC?=
 =?utf-8?B?RjFkeW5obXlrTHZvbUFWV2RHYXBHUjczeVZ6dU5SWmhwTUtLMHhUN08yOXhM?=
 =?utf-8?B?VWs3TFJESXgxdE9WczlrSVV2UkdhNCt3dmhOdXo4ZWwzMVpXandXUnJSMVNk?=
 =?utf-8?B?UEdnNk1aRWtCSWFpamFEZzNTSkg4UjJtdGI3SnA3N1pLVGNDWmc1cTJCbHVN?=
 =?utf-8?B?b1RTUGs2R0szWWFhcWdqblFvcmd5cUVXZ1F0cGxLZWI1OTdwRVFOd2xzUzM3?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OgN0Z+eGGC2SRKF5CnACKShkxG42d+CX2hCDEl4VC0+NDg/JUK5CWEzrFQR27I7iA1sasfKHGwr3PTRX6YEoxWSHQoV2ABXnwVu5RPlD0DhTMaWoHDusXENTqo+tgDg52INu+ETZaRXvl7NCMxTut0oLxHDIfvwtxWojI0Yr/AiJd0jyAlO1D1MrqN4KKcNlcnVWyqmHuJNYII3uA1RAwViLOsMARSiKUWWONzfGdeKNV18N/gA9ADcvvgJQH+kudFP+8XtTz0pHG4EFKvbAsSrDSxgkdkwmtiABj5H4gv9YRE1GQWMQCEHMql+7mjG5ZN6dgzOf2ff5+GxtJkGy05GbQyXB51m6J4XrtIxCUbjCb4izQMGYHCsMjqNoZzpRGLdOimdqwuOqX69jsJV0WlF6ZQPsHEeJET8eWS57X02Z4+g/zxOLQpxDyNuEg88bCSW42eEMdKg/Fh5H9Q+DVL7+0/DmDI2M1v/I5Bn5Fn+yMGemRwxL/SQaZK+/AtWX/XHPUg8N3dUm7kfyTDyhS/Vq2uzRljeXOYXaZSEuP3xip71TAz6aqVE/eYoxhxQR2rEBvHRmrI4eYQfwtfmjLEvTp5ZxHKj0M1FRjyK9zoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316d1ccb-e7bc-4b70-1ecf-08dcb7d86f78
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:32:19.2467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr8FS486XGo6sa4OJRnPR8cheZmfMqGqx4H4SHHSPiCiQ5v5xvjnkRWE7bOYI2ZJ2tRfsckZi7W5R3IzrWTCTBJKKo46EDmHhaYrdr0+FJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080132
X-Proofpoint-GUID: lI8Wz6PgW3LtHCtJWnaQ71_tEv3YGByL
X-Proofpoint-ORIG-GUID: lI8Wz6PgW3LtHCtJWnaQ71_tEv3YGByL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/29/2024 8:29 AM, Igor Mammedov wrote:
> On Sat, 20 Jul 2024 16:28:25 -0400
> Steven Sistare <steven.sistare@oracle.com> wrote:
> 
>> On 7/16/2024 5:19 AM, Igor Mammedov wrote:
>>> On Sun, 30 Jun 2024 12:40:24 -0700
>>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>>    
>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>> on the value of the anon-alloc machine property.  This affects
>>>> memory-backend-ram objects, guest RAM created with the global -m option
>>>> but without an associated memory-backend object and without the -mem-path
>>>> option
>>> nowadays, all machines were converted to use memory backend for VM RAM.
>>> so -m option implicitly creates memory-backend object,
>>> which will be either MEMORY_BACKEND_FILE if -mem-path present
>>> or MEMORY_BACKEND_RAM otherwise.
>>
>> Yes.  I dropped an an important adjective, "implicit".
>>
>>     "guest RAM created with the global -m option but without an explicit associated
>>     memory-backend object and without the -mem-path option"
>>
>>>> To access the same memory in the old and new QEMU processes, the memory
>>>> must be mapped shared.  Therefore, the implementation always sets
>>>    
>>>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>>>> user must explicitly specify the share option.  In lieu of defining a new
>>> so statement at the top that memory-backend-ram is affected is not
>>> really valid?
>>
>> memory-backend-ram is affected by alloc-anon.  But in addition, the user must
>> explicitly add the "share" option.  I don't implicitly set share in this case,
>> because I would be overriding the user's specification of the memory object's property,
>> which would be private if omitted.
> 
> instead of touching implicit RAM (-m), it would be better to error out
> and ask user to provide properly configured memory-backend explicitly.
> 
>>
>>>> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
>>>> as the condition for calling memfd_create.
>>>
>>> In general I do dislike adding yet another option that will affect
>>> guest RAM allocation (memory-backends  should be sufficient).
>>>
>>> However I do see that you need memfd for device memory (vram, roms, ...).
>>> Can we just use memfd/shared unconditionally for those and
>>> avoid introducing a new confusing option?
>>
>> The Linux kernel has different tunables for backing memfd's with huge pages, so we
>> could hurt performance if we unconditionally change to memfd.  The user should have
>> a choice for any segment that is large enough for huge pages to improve performance,
>> which potentially is any memory-backend-object.  The non memory-backend objects are
>> small, and it would be OK to use memfd unconditionally for them.

Thanks everyone for your feedback.  The common theme is that you dislike that the
new option modifies the allocation of memory-backend-objects.  OK, accepted.  I propose
to remove that interaction, and document in the QAPI which backends work for CPR.
Specifically, memory-backend-memfd or memory-backend-file object is required,
with share=on (which is the default for memory-backend-memfd).  CPR will be blocked
otherwise.  The legacy -m option without an explicit memory-backend-object will not
support CPR.

Non memory-backend-objects (ramblocks not described on the qemu command line) will always
be allocated using memfd_create (on Linux only).  The alloc-anon option is deleted.
The logic in ram_block_add becomes:

     if (!new_block->host) {
         if (xen_enabled()) {
             ...
         } else if (!object_dynamic_cast(new_block->mr->parent_obj.parent,
                                         TYPE_MEMORY_BACKEND)) {
             qemu_memfd_create()
         } else {
             qemu_anon_ram_alloc()
         }

Is that acceptable to everyone?  Igor, Peter, Daniel?

- Steve

