Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A707FE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 22:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOP7a-0008DW-1a; Thu, 19 Dec 2024 17:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tOP7K-0008CJ-Az
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:35:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tOP7G-0003E9-H6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:35:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJKebLr007375;
 Thu, 19 Dec 2024 22:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=OG7W59rNC2qU1SnFnqJcfd+pzh6SLvqwO+bA0KXzRZM=; b=
 GRCH6GXHY7O44pbJRTWOn3Fl09XbrPPIEDTmRAelriCEqllWHRx2/+3/lkAAkgeQ
 GZqbeQ9/Pg4o8NGmPuVy60gF5oxktJATdEA1uoEKvAYBuhQQT8PP2zWz5Xh5IsaR
 zxxaS1H+RJhZeXRfztSwJM6mv1VEg4jL3mF5T9Mu9J5F3eHWYtDWvh2Q5sZzTOI9
 zV/yX4gGlwY2YoHPxUF5O/YhT74AUasdF17aZ/rigSHq8yJY9urz3X5mqt6SQE7T
 iE56aqdeeqx+GdFMnraK49gkmvszJHRgqmqfIXcchcKoWMHBV30sUAnlTSk6zmNW
 GPzF9RV544RfmOjpKp2Scw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m0ccpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 22:35:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BJM4I2d010942; Thu, 19 Dec 2024 22:35:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fbmrw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 22:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPJrlSsm74gvCt8iHsdj7PVvGPDG913CqWNRrR0IAdSsaYHko5RVwO96z4hZQi8W3UxUa75bzh5YMrujSrxmBNF6OD9iPdLil2wZ62EsQPDpURBICfc7KZZZuDghM+s40jJuNJTLFim4pLujxw5LUxjoFgiqOoXz6g1HeWdw8Rg4uot+MlTnh4XEkb9PhRQ9vnkzpKnJgimYOpUpVnVHkiXytJyvf6balpZrXr5APiMZkPP13DmlImfw5sOssYzOlGbDqaDcSRnd/lHwMqBIxSsVLWtRmsZCq4evYF1fevs4NFXqQNnRsA51xRoArOkCs7ouhXDFsf6Lf0OGiXdD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG7W59rNC2qU1SnFnqJcfd+pzh6SLvqwO+bA0KXzRZM=;
 b=YejLf7Ju+Gj7j7N8KRfgrdIvVyta4tTFu7Lmtl5KRHJANyP57707uISmdM7VO5dMJEWV+jPyB8Ty9cwxijk1bY/asJRZoyX1FXDxDCvEvZKRwdfhpgrTdJWsCnALMpBmhvR4BJmJ2TDD+dWRk/1tKvHcsPbCgnxzNo/wmYvUOi5t0HZnYf+d9BeC8d9Q2eToD2eQ+Cyg5AfTErUzvt/ghx6GaGnyeQfCk/dW43XvjgyjkSTL69ZJMxZm2V608Zhcvk6U5NykUVxvC9Kz1RBDI3FwBPPxqAr+6P3YOeysliA+CNBlfNjzCLOF33p1oSQlGy8PNHxwf8noQUl/9yTAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG7W59rNC2qU1SnFnqJcfd+pzh6SLvqwO+bA0KXzRZM=;
 b=Ly19xv8mhekpvv9tIAlBg//GB5t4950f177VO4Pqjpgj5PabRNKnAn6Lm/uKfGuNBSwYSi+GXGLb5HKSPRQhsz9a30hxYlk9ocQM5u9HIFEGPwi0OE28TAGB6SEmOnwQCPcjysmk3n6sQA8bxfWprQfcTLbHoNvXpPqWF9P9udE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 22:35:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 22:35:21 +0000
Message-ID: <c94ed602-76a8-497f-a64d-16f49e067f9f@oracle.com>
Date: Thu, 19 Dec 2024 17:35:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 19/19] migration: cpr-transfer documentation
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-20-git-send-email-steven.sistare@oracle.com>
 <Z2RRvnsYZ7t3f8-b@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2RRvnsYZ7t3f8-b@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:408:e9::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4978ffe9-207c-4c1c-6a6e-08dd207d6c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vnc2emlIZkhnMVJEQk5TelJPeGtweDM5dmFYR01nR2VBeXkvVEtKQ2g0R2NU?=
 =?utf-8?B?UWVHZHZTN3NKS0p3YmdLTHo1cEFLWmUzMTNYaWdvbDNtSjNSZWpuUDBSMTFx?=
 =?utf-8?B?NStxMlRyYlIwSTRGSmRUT0ZKZnRlMkx5NEFONk1OOXI5SU9udkRzNTRHL2xl?=
 =?utf-8?B?WjEvZjdqQTVhQzZGbmtUUDlnam1ILzRTMFBuWFhDVVFPcE5FdFNzMlZ3K3BH?=
 =?utf-8?B?a0xzTDBWRk1GK0pqaHhNMlJobTIxdFhhWEcxUWlpMUg1Sjh6OTMxRXdCMUpk?=
 =?utf-8?B?SDFRcVZxK3psRVRYYzIwWDdlTlJKNldXOW1zUHgrejBCSlNxdWh2VUhnNnZp?=
 =?utf-8?B?Q0RjRXQxa0lCWWRkOW9SUW5qekw0UGswMTBNaXBtMXRKREExeklwOGFxeEhW?=
 =?utf-8?B?T21qeFlHUGNxakxGTlFpcUNjMzduSkJBa1MyNjdJZVY0R0dLV0dKNml4SjRm?=
 =?utf-8?B?SEQyS2pyWXpxMVlPbHJHQVVsREpxQ2hZalNqYWhCRk9uNXl6Y3czQUV2aTFx?=
 =?utf-8?B?eTd1bFh6c0R4cklqdFNmSHNqMGR5Y0xjR252cVN2cThCYmE3K1ZIaEJGRjhs?=
 =?utf-8?B?OFpNZ0hiUFZkaDFHSit0QXZSenFEVjdVaEU3MHZUNGwzMVpVdmcwbWRUaE9F?=
 =?utf-8?B?TXhsYTZhTnVCeFd3eGIxNTkrclpBRS9OaHRZVTFHU3dXeWRyc205UVg0ZWJh?=
 =?utf-8?B?RTRXb04zakhjRzJYSzJ2ci9hMzFaWGZ3QkM2T1J3WTEyQUJmUkVHT0ZjcEUv?=
 =?utf-8?B?UkJBZGM1cmc5Lys0L1A5dWtzTWFudjllVWZyRjg4U2JYOThVT0lNR3VVdmsw?=
 =?utf-8?B?UjdDV2IvYUs2VGFNZDNKNGQvRWxWT1V5Ym5HMDlnS0xSaG5hNjhZSks1UThx?=
 =?utf-8?B?U1R1MHhSRkl5bkM1NDdHS2ttSFhiWU5SbGphZnNJQzEzeUpWUGxpYnluVGcw?=
 =?utf-8?B?MHQxaHQ4MzA5WGJ1UFNsQ1VTR1VjekpKTG95R1JuWmM3VkNnMHY5SGh2SFpP?=
 =?utf-8?B?T3lJRllDcFkxYzVLejc4Qk1yYTJML0lKeGVlK1N4VExsSC9SaDU3eU9aYXNY?=
 =?utf-8?B?ZFJWUTRYYVN1MEtsUWZXSUFQdVgrdmV4Nlh5bGZHTmVKU0lPcXBRY3hKWFFY?=
 =?utf-8?B?TGd6NnFnSURUdEdaYjRGdU1UNHI2Y3VCUEFZREdCT0FoSTJ4OFV5M05jaUZw?=
 =?utf-8?B?RDBaM09YTlNwdjBmMC82Sm81aUZESS84YWlSMU5TUmNxTnN4emlLbXFHRTdz?=
 =?utf-8?B?TnJ3QXk0WEhNajdndDhjbCtoamhVVlBBMFFsUldvQTY0dGR6OU04cldKTGJs?=
 =?utf-8?B?L1IzanRyUy9NUXJwSldFUlpXTmJneG1NYjcrYmZmYUwyUmcwUkppdGpzMzNY?=
 =?utf-8?B?L3g3WGhVeVIxdVJsOXBRaXRwL3lsWHUvU0EyVnhsNGx6aE4yZGpCYWovNVZN?=
 =?utf-8?B?aXdGaThncmQvTGJ0RDJxRXZCaFRTTVZMcms4NFNGdUIwbmhmT0p4eUhCT3VN?=
 =?utf-8?B?dmo0OHBseERDNGo3MFJYak5Tc3dYdlVQWWdORmVMNk5hbDFrVnVWVUtWbkhR?=
 =?utf-8?B?cWE5RHlITzhnRDVPdlBqMmVPeE5ZSjk3NHdvZ3lOclBKY2NCdUttUE9PUzFr?=
 =?utf-8?B?YURZQnJqaHRmSUJUcDdmM0lpQVpzM2VDMTc5RU1iTGNiREtwWStIdndwSGg4?=
 =?utf-8?B?VlBEZnd0MUhudVp3d2NBeEI5dGZsNWJjenpWaWtqMnVVM1J1b3lVaWszMDdm?=
 =?utf-8?B?V2pqeW1Wc0FOTGowOC9na2xOclEwYjFJaDJ0eWZxZy94Qm9KUjFDYSt6NEhQ?=
 =?utf-8?B?NnFRVzRHVVhMcmxIN0c1Y1Z2SFJZV00zdUpsZFYwR2Flb0hyNUMvUGRSSFFt?=
 =?utf-8?Q?jhcg7BtquIHdC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFPcWJuNHdLRTJ3UHFURTNoMTRiQXRTSThkSm1ZckwzRzFQK005VEEybGNM?=
 =?utf-8?B?Qzd0S2h4SXozVVMvY0RaV0ZwcjQvbFpBRkZ4VEx6RVBtMlljZko1TGM5REZ2?=
 =?utf-8?B?cG43bGhWcXQ5aElUVGFjU1phSkJ2dXR6Z1Y2Vy9SUmJNcWZ1QjFDVHdUZ3BM?=
 =?utf-8?B?bWV0OFBFRFNYWUNCRTJYMmRQOG4xcUM3d3AvRkpSeHJsZnAzZ3FzQ3BjMmZL?=
 =?utf-8?B?cktKNVk5ZmNRcXpyZmd1RDRuejFQSURaK2hJcFI0Vm55aE45dmU2V2tOV3BV?=
 =?utf-8?B?OFNWdlFreHZ4QUhuTytjajlHNUp1QW8yWVZBMlUzd2tzZE1UMFVHQ0Y4SzFY?=
 =?utf-8?B?eEdkZFVRQzkrMmtvVVlsR2szYklRZVVwaG5vSmNYOU9zbHJwSEhiWDYwYWRj?=
 =?utf-8?B?SW9YOVhUTjhneTBpdUN1ZnhCVGUxVHhMamtsVDVJOVdiVzAzTk9lUXRmOFA4?=
 =?utf-8?B?NnI0Yi95TUdDK1BMTTBPWFN0K2FpSFltbnRLUVBpR3NRWlpmZFpHZjdKQnUv?=
 =?utf-8?B?NEpEdGpuRFdpeUpRY2c4eVQ0cDFCbHVUQlRrVU9NV2twOUJOQS8rUWgxOEFY?=
 =?utf-8?B?ajhlVE5RTC9LcVhUcm5xcDVyWGZBbmh2RHB1cHBKVm1pUDFjU1pPRzYwR2JP?=
 =?utf-8?B?QmRWNEw0MmovWHMyd0JDQ3pudVhHd3VTWmxQRmdWclhZQXpRSlpXYld0cTRN?=
 =?utf-8?B?UEtDMkxJampQU2JQc1FVTEpDRWdnR0J0aUFCVFNPSDV6K0VvZUJTbmdHOWcx?=
 =?utf-8?B?bHdmVEFiaWRHU2NzaDVtVXBuUDY2dy9FT2duZmNzRFJaWVFONGpNSzVHVWtQ?=
 =?utf-8?B?c2lKN1J0WEZMZjRkWk5WekNZS1ZUL1U5aUVJQ2d3bFFwUEtMR3poelRJc2RD?=
 =?utf-8?B?RW1OTm8vRVJaS0Uzcm9od1luYjVHRkFjRUV0dmlKNkwweGxRYkpJL1RMZmlT?=
 =?utf-8?B?MHhpeFAxVVhWZEgzWUNvK3d3cGFrVWdUUW9CQnNaZ3k0Qi9BMGcrcHhMY2Uz?=
 =?utf-8?B?VnJsTThDQm1hVFNucldBaGlacXpMOGw5V0RJS3o1YmR1ZWNiR01LRzZpN1NT?=
 =?utf-8?B?VWlFWWR0YmRjOEVlYmRMTFRmR2RCVy8yUWV6YklZV3NsNUJ1eUZqK25NMjBM?=
 =?utf-8?B?enZCRnhsYnh0dGlCQ25RRzhCdi9QdUN3ZFJFYk83U0k2angycnRVZ2hTUGxW?=
 =?utf-8?B?UmFaVENxcnA3MHRULy9mSVFUNHR0WHJZQjlIdFQxeFV6RWUxaTV5NHNzZ052?=
 =?utf-8?B?QlUxUFBvRFdMcmtmeEdLbE1qKzVmdG5zbFc2bEFtcmpzblV6L0VQcHJXdkxl?=
 =?utf-8?B?OFdvdERQaG1OY3lOeFhzcTdJNldTc3pRZHR5NTNORWRyME1aS3VHNTFVZ1BW?=
 =?utf-8?B?bmhiSDRndGRvSjZhMWtUTisybUdFTE5HZWdDei9hVHg5WkZxcmdTeGVtSzN3?=
 =?utf-8?B?RHBlaW1qaERpQVRxWitzOXYwbjllaXh1R2pReis4SGlHSUVDdTVFNFRyRWtI?=
 =?utf-8?B?aC9id1pPSmhISmtQazN5b1YwemUyMHg3T29ma0lnTU5nc0FuRWlvL2tEVENo?=
 =?utf-8?B?blpTVTZMMmZDNnpYVjFqQVNPemhOVlpBaEVLUGxxNVZ0RGZ3TVNQMlhUbG9S?=
 =?utf-8?B?UUhDdVVvOHdZNzRGN3h5ZExYTlltK0RXMU1zaVVRdkZ5bGFqSkhhaTdKWVg1?=
 =?utf-8?B?bjMxcUo3bmJyVEVjSjhmdmFZN094ZG5YK3ROajQ4UkRYQnY5eGczalV5VEhC?=
 =?utf-8?B?L0FETDBVaEQxajJ4QTdSZXlYMDJSM2QveGE5VzdGTDR1S25qMTVjdUY3UzVi?=
 =?utf-8?B?aWVxUHArL2xtUENUSlMzTWhLRWJIeWcvZFVXVXNqUm9XcHltK3ErMGs2ZXlq?=
 =?utf-8?B?ZDkraWtEenMzSGhiZlI3MkhKUVdlZHBkWWVkdm5UOCtiM3gwbFpoaDg5Nk9P?=
 =?utf-8?B?QmNaSUwrTSt5NVQ3dzRuUjlDaUFNTHhoWE5pMHhGNU1vQm9nLzNKaWhtU1BF?=
 =?utf-8?B?SWVPTXBmdVNVTVJRN0lFV0c2cTJreHNTVWZBY1FQZHZTSlRxc25PTXFUdUl0?=
 =?utf-8?B?cmQyYXRVYUY4czlkbmlwTk11d0tQaTlRV3pXa080SUxjbjFSMnl0aVA4WXlY?=
 =?utf-8?B?clVWVEZ2TEo0VDIrRXIyOGJhbTloSS83OVY0RUkwUXFLYWRGNWlhNDNQWVpK?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Di5YfcoRRlP5SMGktF7QOWJYhGcBCZUPICs28lILMGrhrJTRnwBReMbkG4B7RFzfkLffgYH0BTAo6r4gLOUm2sg7K1LPvqRXJYlpvLNMLjCUJbLjRJiG682l8BODSwJedzMf8KaoINU0DsGxVzyza8Ia4wVx2kHN+D0/hfe/Sswsi2ckWyFlEeacAz90tuKlDDvhhulV340CKZX6Yit7vAFtHFBCYtWIFKp3kLkhqrTGjloVh/NIJpeTHMdTyXn+4TsBp7a/n5s+swGCszVHitGaTiVYq2nFOQqsVkbT6oPukWxxc0QPqMRl+BYjwhG+bIKuC60cx6+lVLgmdVqdgqsR8urxQ/OT/s1njwWQyXI/mo7ZPNROSez7/l2ttfHBpsB3CRqIsHApdLFk1sT5nzgruFgfzhMYIPi4Su+Ybn90dMKFZ9iNkYBrVSCO9yZ2Xq8YxPxENb0ls9NF3w8z/RfyWbk0mGqvyvxHCJRuxPHixwZGixkQxgOh7aLevg6zPgnSkqLEUArqHvMG2nMoOQ3tND+Ij/EIYcdCPMomJvCUSW8lCQqwlXjvkM2HKNmkr3utTNq2wW/6XxnezUTOnUI7BITrn1p7QbgkMLnzXBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4978ffe9-207c-4c1c-6a6e-08dd207d6c1b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 22:35:21.4163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJtawKv3b4FuVK02MkHqKDZqqZRThY9xTU9eQzMOCog504iEz7/RwC1v8akHa7/Z27hG9KFSsk1soNrOsphJIbDiBfAyMsw6/Pe0QOeNub0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_11,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190178
X-Proofpoint-GUID: DILIXdE6yUIcF9efLHmN4zq84svAs5RG
X-Proofpoint-ORIG-GUID: DILIXdE6yUIcF9efLHmN4zq84svAs5RG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/19/2024 12:02 PM, Peter Xu wrote:
> On Mon, Dec 02, 2024 at 05:20:11AM -0800, Steve Sistare wrote:
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> I think this one is already good enough, so:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> But still, a few comments inline.
> 
>> ---
>>   docs/devel/migration/CPR.rst | 176 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 174 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
>> index 63c3647..a8a57c0 100644
>> --- a/docs/devel/migration/CPR.rst
>> +++ b/docs/devel/migration/CPR.rst
>> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>>   VM is migrated to a new QEMU instance on the same host.  It is
>>   intended for use when the goal is to update host software components
>>   that run the VM, such as QEMU or even the host kernel.  At this time,
>> -cpr-reboot is the only available mode.
>> +the cpr-reboot and cpr-transfer modes are available.
>>   
>>   Because QEMU is restarted on the same host, with access to the same
>>   local devices, CPR is allowed in certain cases where normal migration
>> @@ -53,7 +53,7 @@ RAM is copied to the migration URI.
>>   Outgoing:
>>     * Set the migration mode parameter to ``cpr-reboot``.
>>     * Set the ``x-ignore-shared`` capability if desired.
>> -  * Issue the ``migrate`` command.  It is recommended the the URI be a
>> +  * Issue the ``migrate`` command.  It is recommended the URI be a
>>       ``file`` type, but one can use other types such as ``exec``,
>>       provided the command captures all the data from the outgoing side,
>>       and provides all the data to the incoming side.
>> @@ -145,3 +145,175 @@ Caveats
>>   
>>   cpr-reboot mode may not be used with postcopy, background-snapshot,
>>   or COLO.
>> +
>> +cpr-transfer mode
>> +-----------------
>> +
>> +This mode allows the user to transfer a guest to a new QEMU instance
>> +on the same host with minimal guest pause time, by preserving guest
>> +RAM in place, albeit with new virtual addresses in new QEMU.
> 
> IMHO it's important to have some words discussing the diff
> v.s. ignore-shared, because from above it's undistinguishable from it.
> 
> The important bit could be that cpr-transfer allows pinning.  If that's too
> internal a concept, we could mention "unlike an ignore-shared migration,
> cpr-transfer will start to enable local migrations to work seamlessly with
> all kinds of device assignments like VFIO, vDPA and so on".

OK, I'll add something like that.

>> +
>> +The user starts new QEMU on the same host as old QEMU, with the
>> +same arguments as old QEMU, plus the ``-incoming option``.  The user
>> +issues the migrate command to old QEMU, which stops the VM, saves
>> +state to the migration channels, and enters the postmigrate state.
>> +Execution resumes in new QEMU.
>> +
>> +This mode requires a second migration channel type "cpr" in the
>> +channel arguments on the outgoing side.  The channel must be a type,
>> +such as unix socket, that supports SCM_RIGHTS.  However, the cpr
>> +channel cannot be added to the list of channels for a migrate-incoming
>> +command, because it must be read before new QEMU opens a monitor.
>> +Instead, the user passes the channel as a second -incoming
>> +command-line argument to new QEMU using JSON syntax.
>> +
>> +Usage
>> +^^^^^
>> +
>> +Memory backend objects must have the ``share=on`` attribute.
>> +
>> +The VM must be started with the ``-machine aux-ram-share=on``
>> +option.  This causes implicit RAM blocks (those not described by
>> +a memory-backend object) to be allocated by mmap'ing a memfd.
>> +Examples include VGA and ROM.
>> +
>> +Outgoing:
>> +  * Set the migration mode parameter to ``cpr-transfer``.
>> +  * Issue the ``migrate`` command, containing a main channel and
>> +    a cpr channel.
>> +
>> +Incoming:
>> +  * Start new QEMU with two ``-incoming`` options.
>> +  * If the VM was running when the outgoing ``migrate`` command was
>> +    issued, then QEMU automatically resumes VM execution.
>> +
>> +Caveats
>> +^^^^^^^
>> +
>> +cpr-transfer mode may not be used with postcopy, background-snapshot,
>> +or COLO.
> 
> Maybe we can even remove this line.  It's not like someone could think
> about supporting any of above; they just don't apply in cpr context.

The same caveat is listed for cpr-reboot mode.  We should either delete both
or keep both.  But IMO many aspects of migration are confusing for beginners,
and more detail rather than less would be helpful.

- Steve

>> +
>> +memory-backend-epc is not supported.
>> +
>> +The main incoming migration channel cannot be a file type.
>> +
>> +If the main incoming migration channel is a tcp type, then the port
>> +cannot be 0 (meaning dynamically choose a port).
>> +
>> +When using ``-incoming defer``, you must issue the migrate command to
>> +old QEMU before issuing any monitor commands to new QEMU, because new
>> +QEMU blocks waiting to read from the cpr channel before starting its
>> +monitor, and old QEMU does not write to the channel until the migrate
>> +command is issued.  However, new QEMU does not open and read the
>> +main migration channel until you issue the migrate incoming command.
>> +
>> +Example 1: incoming channel
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +In these examples, we simply restart the same version of QEMU, but
>> +in a real scenario one would start new QEMU on the incoming side.
>> +Note that new QEMU does not print the monitor prompt until old QEMU
>> +has issued the migrate command.  The outgoing side uses QMP because
>> +HMP cannot specify a CPR channel.  Some QMP responses are omitted for
>> +brevity.
>> +
>> +::
>> +
>> +  Outgoing:                             Incoming:
>> +
>> +  # qemu-kvm -qmp stdio
>> +  -object memory-backend-file,id=ram0,size=4G,
>> +  mem-path=/dev/shm/ram0,share=on -m 4G
>> +  -machine aux-ram-share=on
>> +  ...
>> +                                        # qemu-kvm -monitor stdio
>> +                                        -incoming tcp:0:44444
>> +                                        -incoming '{"channel-type": "cpr",
>> +                                          "addr": { "transport": "socket",
>> +                                          "type": "unix", "path": "cpr.sock"}}'
>> +                                        ...
>> +  {"execute":"qmp_capabilities"}
>> +
>> +  {"execute": "query-status"}
>> +  {"return": {"status": "running",
>> +              "running": true}}
>> +
>> +  {"execute":"migrate-set-parameters",
>> +   "arguments":{"mode":"cpr-transfer"}}
>> +
>> +  {"execute": "migrate", "arguments": { "channels": [
>> +    {"channel-type": "main",
>> +     "addr": { "transport": "socket", "type": "inet",
>> +               "host": "0", "port": "44444" }},
>> +    {"channel-type": "cpr",
>> +     "addr": { "transport": "socket", "type": "unix",
>> +               "path": "cpr.sock" }}]}}
>> +
>> +                                        QEMU 10.0.50 monitor
>> +                                        (qemu) info status
>> +                                        VM status: running
>> +
>> +  {"execute": "query-status"}
>> +  {"return": {"status": "postmigrate",
>> +              "running": false}}
>> +
>> +Example 2: incoming defer
>> +^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +This example uses ``-incoming defer`` to hot plug a device before
>> +accepting the main migration channel.  Again note you must issue the
>> +migrate command to old QEMU before you can issue any monitor
>> +commands to new QEMU.
>> +
>> +
>> +::
>> +
>> +  Outgoing:                             Incoming:
>> +
>> +  # qemu-kvm -monitor stdio
>> +  -object memory-backend-file,id=ram0,size=4G,
>> +  mem-path=/dev/shm/ram0,share=on -m 4G
>> +  -machine aux-ram-share=on
>> +  ...
>> +                                        # qemu-kvm -monitor stdio
>> +                                        -incoming defer
>> +                                        -incoming '{"channel-type": "cpr",
>> +                                          "addr": { "transport": "socket",
>> +                                          "type": "unix", "path": "cpr.sock"}}'
>> +                                        ...
>> +  {"execute":"qmp_capabilities"}
>> +
>> +  {"execute": "device_add",
>> +   "arguments": {"driver": "pcie-root-port"}}
>> +
>> +  {"execute":"migrate-set-parameters",
>> +   "arguments":{"mode":"cpr-transfer"}}
>> +
>> +  {"execute": "migrate", "arguments": { "channels": [
>> +    {"channel-type": "main",
>> +     "addr": { "transport": "socket", "type": "inet",
>> +               "host": "0", "port": "44444" }},
>> +    {"channel-type": "cpr",
>> +     "addr": { "transport": "socket", "type": "unix",
>> +               "path": "cpr.sock" }}]}}
>> +
>> +                                        QEMU 10.0.50 monitor
>> +                                        (qemu) info status
>> +                                        VM status: paused (inmigrate)
>> +                                        (qemu) device_add pcie-root-port
>> +                                        (qemu) migrate_incoming tcp:0:44444
>> +                                        (qemu) info status
>> +                                        VM status: running
>> +
>> +  {"execute": "query-status"}
>> +  {"return": {"status": "postmigrate",
>> +              "running": false}}
>> +
>> +Futures
>> +^^^^^^^
>> +
>> +cpr-transfer mode is based on a capability to transfer open file
>> +descriptors from old to new QEMU.  In the future, descriptors for
>> +vfio, iommufd, vhost, and char devices could be transferred,
>> +preserving those devices and their kernel state without interruption,
>> +even if they do not explicitly support live migration.
>> -- 
>> 1.8.3.1
>>
> 


