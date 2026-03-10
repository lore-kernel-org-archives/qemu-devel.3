Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22299FCC9A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 01:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzlTN-0006lG-63; Mon, 09 Mar 2026 21:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vzlTJ-0006l6-6W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 21:01:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vzlTG-0005eG-RC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 21:01:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629IN9h11628413; Tue, 10 Mar 2026 01:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uoBgMc7aTMnOWUp0MUjRDpBMxFbSeCTe9BDgujtkazA=; b=
 NrJnHVog87WVJnQiOG8Lv2ug+a+5GyPuW/bzZmo+iCXdiw9bsEQSRXrsSh9eU8OP
 OuYRbr8z6r+isb03BaOTHVDVX+PCZdynpWKkPHO+XJrwYwLEVF+fdMHUEFwOyBTF
 LjaWq3cf8+MNJ9XwLdbIpGXnozRsDEjfDEJo1Ioc6PD9faaH3eYXsiHnH3kfAJyc
 IT7CXO7VGP9R77XDXJw217/j4jLtvOvE9OQwOQ/r75gF6/GoZpenxex8AUA59Crp
 C81Kn7ZgtMQdP9DxDnnk191qi5Vp/5pn/YnyGp9KN9ShRuHF5ibtuD/UBWY2LGvR
 1zZjeFbmSRjbwSpUIrEBGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmps20hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 01:01:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62A10Jwv020253; Tue, 10 Mar 2026 01:00:58 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafde3cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 01:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1i4FINaKDWjxWYZx5TJNR/V003hRdXRcbxEqD5oCaB4BncIOyYR/ZhFi6phIN7uok1CSuE958RQGJjgtmix4fKg/otmr38NwmwyY1VqEd39Ai1KFpEE1CMBNckYKDnGZjqOVdTHnegnE19OixgcLC0A1TTN1DwRNDwdxGphpj2kKQVJ/XG4ZQ8wceRzKNKe7L5etfTDRaNEFipUS35++jid/I8NOjvRA0IpPbTPIghSbyLau2oFQqAApW3pPdgPq6nTxUrAj2lolyhZ2HEzAQ07CwGFXSN3KQhGr/dQKpe2TrDo+sEMiSS1dgmCJsArQmdYHpYSSo8CjQPfxYtPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoBgMc7aTMnOWUp0MUjRDpBMxFbSeCTe9BDgujtkazA=;
 b=d2kd2OOeikTmwlx2vEDekegsH4DCpVmx63OIsTDAQ4LIfNpyPWWm2rjzoOBkqLeZP1KEw14ksGlUjzCYGW7xnR0M+JhJVtazHKKdmCM7sna+IIZEEfVoDojJBKFWjquczlhV0xOdFhIIzzXcJ8Wzofqb4UDICYAETTIK8ZdV59dWD9w4Ustfif1r7Xy2D/Q331Vb8kzGmDQliYW1lFypHmGixNSjAhQsVidv1Rodqo/aI5WefYSy/ZQxXbD7ncOw9Gp3XSef2WfM/3EoiYbZfyn8BqOLqkDATVOzsVdcU+/gxbbv/5imxnfR4Dzs+4czkeId7V6ZUdjMF7ObW/AxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoBgMc7aTMnOWUp0MUjRDpBMxFbSeCTe9BDgujtkazA=;
 b=UZno5MGsuUDhpQUN0M6HLl6ph/LCqIyxCcMKdyE4QOyHEIWPnaSmrFx1vjGZtOlCnUI6p0SVqKqm3T8OevrsO2vivUhMpEmuFfjVeUgWHQX7K6l9SsqIELmRVjP2pSXaPjDxnwwSUZ1EAAy+gJifmuDrKPf4bwXQKJ+NN8LogfA=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MN0PR10MB6007.namprd10.prod.outlook.com (2603:10b6:208:3c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:00:54 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 01:00:54 +0000
Message-ID: <a87231f5-3ad1-4287-b9cf-7c0a8211694e@oracle.com>
Date: Mon, 9 Mar 2026 21:00:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/i386/amd_iommu.c: fix incorrect page_size for
 hugepages
To: David Hoppenbrouwers <qemu@demindiro.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20260225145831.28275-1-qemu@demindiro.com>
 <20260225145831.28275-3-qemu@demindiro.com>
 <863c6284-812c-495e-a452-a4dec3ed7115@amd.com>
 <80ea964c-a33d-42ab-b5bc-ae63f6124a08@demindiro.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <80ea964c-a33d-42ab-b5bc-ae63f6124a08@demindiro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:610:60::40) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MN0PR10MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d6df67-2094-4687-41bb-08de7e407af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: aZAYcRM9iiAU16OVbxJeEAVXV+NOMjsdtlyrBwKrFX6dA0jQBj8cqpkxDCC9z5oma0tuI3ti3LJj7JcC46y0dNkTdoe0POEbuz2NXqDNcIYvE2Qz/yUo7y3jfFPFKiJjQe03iNOsXOSd4bkhQ7EnOrkUaJ9RKLM7XIplwO7dkE3n8yBPPz7j7bRajFsSi7dN51w5tsS2hkPFH1rWE9/AHNZJOcw/DFF7woGIm22do1dkx26NB6XBy8XGdpcxys+sSH4AG5uGvoTcF0v/JalDYcwdN8APj1lZg52l0I8OmVLpVwh+EGuVj5rmlksNQecbPgQRsDSqUNN5zoBa6cWbpAmIhVmJma9zgmNtpQ0IRCbjqEnzkm0062w0gSx5ETlMh9CTihfPAK+xyJmhyv/eAB5vWZMbf9jPktOTle/IcRDwENIhHiiOS1//MCM6F/odSG9EZeKb6VuPklmPO8t4UK1UmIFxJoLnvS/MRkxaYGIXkK7UCQRryk+wuNOAUf9Qi+t0Ag9hVqh6veFyKvcm7TKj+ac2ffJfHBEZrV+RC7qYeMmCMZbuyakxaK/23YFE/YAS2XfQY7cepTj5W8wbFMIeOS0MQP1o24KlYdwP1DCbk7/QahCm5Rs49y7qyAi1KNzRHhD5k1lT9cbS7HUraGU/ZqS6w5H/PNvMyf4A6XEnJPVS5+rs3EQcQzOyhDYO9uqpg0h4/DN4+5vRNClidItJqiaCYkMaeWUs8eSrfZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNsTXdleXNuYXQwZEt2d1FJSW5XdWlNYVN2dXVEcVJBNmFlenBEWmdrZzlq?=
 =?utf-8?B?b3d1b1J1NjJ1MFhZcWp5MTJZRjFkYUZveWlkOFNRaWhaYnM3UDZzK2ozZG9r?=
 =?utf-8?B?NE5QKzVSMzRFZGx2TTNGTlhXcDNzSU1xcFJIZVVnbnduWWdCOFhiSDJ2Y3dK?=
 =?utf-8?B?SVN4b3EvR0pieGd1UFVKV3pXbzZYVi9SL2d3bXdoNlhkTEMrdG1QOElzaVhr?=
 =?utf-8?B?YVgxZUJBdHpGTTRGT0lQZzhNMmwyM3Q5T2FveG9SY2xaV3FZVkltUEZJb1hv?=
 =?utf-8?B?RlBzVjlHUFMvTHJPWnQ1cFJ1MnA4UlRXejU4eXVlVVcyMzQ0VE0xRG42UkZH?=
 =?utf-8?B?R2pJQVZpaU56b0FkUlRMZGluN2plUW1QeS9iUklRZksvcDNsbFVPSG1LUXRM?=
 =?utf-8?B?U1RQU3JrNWcxNEZ5b3dmNitlN0pjY1F3RGxZNVBFSTBSSHdlZ3NWUlo0TU85?=
 =?utf-8?B?ajRHZ3M3ZStPM2QrSVIzZnZpZ1ZESlZpZXk1eEVnMnVwejA4MjNOaS9DRjRy?=
 =?utf-8?B?bVk4d3MwRmdHK1dwUklNdGhTTVV4Q3pyVFVLT2JxbkVUaEE4WlZ4QTNrV01l?=
 =?utf-8?B?S1pwbElDS0ZxN1hhcnNZTU5yaE43cW5LQWl5eEtHNmhxL2drMFpqblpDc01p?=
 =?utf-8?B?dTltWUlXc3BwRGg2dTl1Q1lRaFZVV05GT1NkdGdZd0daQ2RaaVhCTzNBSVV3?=
 =?utf-8?B?QTBCNitIdWZjM3F3MStERERQczMrOGhhUWxORGo2KzRQYWJPaWQybUlQdU9t?=
 =?utf-8?B?OExJVGdpeEJZTVMvTjlkc2NzejJIU3BnRGpwYXZjcDNLQ3BpZFpPd2hBMkoz?=
 =?utf-8?B?YVQ5QXlrR1BvVUV4anpRRFdwZm52WXJWeGVjSFdnL1BKNWJXbEZ6RUlEUXFV?=
 =?utf-8?B?TmYvQ2xTQWFlSHd6SnJYaXJodEs0c1RPaDRHUnBKSTFPYllXS2xmTlVBRHVQ?=
 =?utf-8?B?MnI4TTZqdFBWM082OCtheUo0Z0lLUi9OV0EzeDNteXBaa2ZsQXZEZWFLQTF6?=
 =?utf-8?B?ZHBsMzZRczBTeS9LODVRR0pFNFVyQVF3ekgzZUtKaFl4RXFiZzEreFJMUWxR?=
 =?utf-8?B?NXpSYllsOWl2TU10VHdFUWQvVHphQUhuM2pUTVZzNlovT2FNZ0UwMVFlVVpK?=
 =?utf-8?B?VXo3R29jTEZlS2t3cFdRMWMrcDMvTjc4dkY0dVY0bkNFVmRqVEJkVDFKNkhL?=
 =?utf-8?B?V0t6djltVFBQTDhBSUJENWl0Y0RkSVhuSGEzdkN2cGZ4YmsxajVDMnlIRkJo?=
 =?utf-8?B?S2Rhdnp2S05RL3cwc3FUOVZuUkJRTjU5NlU3dGxtUytqWE5pQ3RuaDNaT3Yz?=
 =?utf-8?B?Q1dCRlVOSnc1WnpZTS9FcGlVekRRZEN2a0ViMFp0aGJvL2RmdGtSYWplRjZk?=
 =?utf-8?B?aEpEVEtTSTUzTENRWWJTYWhUQlVSUVIvZUl0ZmgzWEpTVHpWNDhSQWhmMVox?=
 =?utf-8?B?eEp5YzR0YUR2RVZDYVluYXBPVHRYdU1zcUw0cllkQVJPRjNMZ3FXVzNCNTYz?=
 =?utf-8?B?WDFKMFNURE8rWVoxQlUrRDdZcllxR09WUWdEc204L2Q4Zk1lcEk2MGtyNWsr?=
 =?utf-8?B?MUVFWGlGbllNa2d5QkM0Y1kyMi9wdmF2QXhiNGZ2L01nOEVEdTJVQjN6eU9G?=
 =?utf-8?B?WG5adzdjVzJteWNHSXlCRWNsSXJWanhCbUpCSGljbng1QlhPa1VDNGJJeU85?=
 =?utf-8?B?aHRZRW1qcTM4N1ljTmFXeWxINUNnVndvWFBiTEdFb01qbExyQk9iN2Z6dWcv?=
 =?utf-8?B?T0pxRGJkSDRWQlpJZU91Z0cxY29maUZJN3Z4R2FKdHdyWWJidFdqbStobDNJ?=
 =?utf-8?B?eU01MTZzc3NadDc5aW5jK1FxbjZ5eXNaeGorMFJvcUJjbGtQNXpYZGgrRWsv?=
 =?utf-8?B?b3kvejZPT1dBMnRFcEZNWDVuYzViQS9SVGZKUnlOVW1UTGNBeUxXWG5Mb0tt?=
 =?utf-8?B?L3d0cmU5V3BsQnZvQkw4K2ZXRzBRcDNzWjdyRWdPNnVpMTVaSmh3OGRaVGtk?=
 =?utf-8?B?TnNYT0tnWCs1aThwZTlKTkFhK1MvOVdhMTJZa1FjSHJuOHdhWTdOTTF1Zlds?=
 =?utf-8?B?SnJtWTFRdlB2bW5vUUE2S0l5aEEyVXhyOW9WNHl3Q3IzVktHUjdiMHZtT1Nw?=
 =?utf-8?B?ZHZWcW1aRERFeDd4YXltMTRNRVRpZW1lQzNtL29IWkdTdnZRY21NbnVKczlR?=
 =?utf-8?B?a2JQSnRBRjBDZk54NFhGNFUzei9YamlRRjVtN0dNUk9CdkhVRkRRZXAvWDMv?=
 =?utf-8?B?RWVCWFc5dk44RDFZSWlkM3kzbHU4UVZyenhpdEVRUkZ2R2VNTlBCM1R4cWw3?=
 =?utf-8?B?YW4zOGxpaHM1ZjRxdk5mOFlkUU84b3lYRUFxRVFyNjVueXhFNko1Q0tSZzdI?=
 =?utf-8?Q?ZkNwxA6cCgapNJVg=3D?=
X-Exchange-RoutingPolicyChecked: PEIMW64+QaLkgK0FTWIjJrE7/yjlC1gnjgMxhL7zQjouMsXKvPuSM/AipHF4pB35GVpcFlpsP72i1Qc4Ec7PKl2u/+GfEA3bhAe1ZjX2ElMIUhOv6vIm3GBCFbHKNFQMbtEIqf6LTf2EMrNtz9X3lXkN67PuqHtLwSOgEUwGNjSQlOos6AZzvZQSvZZwgqw5xQVeuxeHzOvCuFhKXO/4ryzG+JM2QKeJ4VCcbMBrKT7Hn0JvG3YWQks1So99L8mlTZIMXMBPRhZwvkPEIq/yna3ksSrn3dJt8r3Hlb/SrWWV4GIIyfrN7v0NnBCP4xXMRQl/2dWu8q/AGVMQ+cE2ZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Aw5mK4omrAdozdjOWYBPpYUjWSgpZF0axDVmzlvIMw72Id0TTiyHCTSY5ojnn+jakOEkRanXSsMLzvcdmoSZoZVpwnTTOX9YmsuAtn529yT1qcFLbu0zRqfDGbd+JTcDuemtf8IfFLvtPSwJT2oIfUw6LpOB/ybywgY7VlmvUe/LGwwk9Hvh5wpYCzOMHQu72sIM2YEWEt8xhvBs9ATMVBg3uP4R3j/ZdcwHqq3EyRgKXE21i86gTRIG4IPRGZhQWmyvfWCs73VL3yRCEvtRKpwLjqPwk2Ub+zM2/IJRqOufsswKME61Yn7pTYNqJtRPX3aBbPLO+yk65ydguy6uHzNb+eMvGj2HAc+ZexpZcGyWXHIazSMjK1FRCllPU9aa6rgbc946ecOUVaSNBsm1LeLompiPLhQi/3ZQW1z8fQUfNQnFebgWCmRCE1IzoWABRiK/Jw5tJCAHJL2QJXQnjUcVbHNQGv99asnNj9/Xk220cvbYBiK4iZaYHT3dB62fNsItDDWP7FaWagfaC6u2Q6trqxwwsbOAAvRxthyh0YhYpJd8yQyT27GgWeBCl5UKZsHJzdjxqo4UILRmbdWfswDyz7JROok9O4gXQCr89k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d6df67-2094-4687-41bb-08de7e407af2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:00:54.4195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmAZ8vmtO3jWnLrRDyMjJAupUdvaGnFeD3eN/i+JWkEQRLS0KEygXeLJHIIZF/DJnfLMiqmheEeT/v2uA6rJgVQAOh0wO3iJ8hP6P6q2VJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100005
X-Authority-Analysis: v=2.4 cv=IJQPywvG c=1 sm=1 tr=0 ts=69af6d4c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=PMsPOMrQDPkl-mX17-UA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAwNSBTYWx0ZWRfX74WLOmgaXcWm
 oLQSwbiOai8QfSG4KjI5CkQBg5D3GOCM1RCZOLlB8eAAATqq+qXvMUJpmBhee4AeuZkW4BMHCav
 /ISXcKTNiLNnO+W20kuMMG+Bd+B0I+Huy5YEPddKkUm3pNC094MPQEN8ExbptrOs3gts+RXz8+Z
 AdAk8qz6fa3fVLwmCox4kj1FzDsuQW5G1ch9IFajoCXzsmAsecxkAUMKryEFossaN7DUl/nnUFW
 b63N8nGZY4NS4gIlJ9GUKDZ9xdMGpka4uXKPheyF81vuKfr23QJQHH9ULQ5XjSwvha0dW2gXOHL
 rnWpe0+e1Ru0ywvl5nmfz9e1EVyJWOzqt7QmfxjMzeTQlQNZOm4ky1bmA84cIc3s4EHOZ32Nh+w
 13t9e5GgGeXxXx60nrumxQN/E/FxGd8iHwT2KHKW73SNySEeg8HmP/3xfDZ9VKqI5jX4U0W2VwP
 J69YvNi9vgYsvmR2n76ekjT3Hy6PqE6cXQMN3n+g=
X-Proofpoint-GUID: UCq-gyk206zlxSuAPjnbDOFDghx2mTA8
X-Proofpoint-ORIG-GUID: UCq-gyk206zlxSuAPjnbDOFDghx2mTA8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/5/26 5:10 AM, David Hoppenbrouwers wrote:
> On 3/2/26 6:34 AM, Sairaj Kodilkar wrote:
>>
>>
>> On 2/25/2026 8:28 PM, David Hoppenbrouwers wrote:

>>
>> @David Could you please test above patch ?
> 
> It appears to work fine with both the Linux VM and my own kernel project.
> 

Thank you for reporting and testing this bug fix David. Like Sairaj I have
not been able to reproduce it but it is clear there is an issue.

>> I have rearraged some part of code. Along with it I have added a
>> requirement that caller
>> must validate DTE before calling fetch_pte. This requirement simplifies
>> the loop.
>>
>> If @David and @Alejandro are okay with this change, I can prepare and
>> send official patch.
> 
> It is fine with me. I don't need to send a v2?
> 

No need for now, though I would appreciate your review and testing on the
next round of patches. I am working on additional changes, essentially
adding to Sairaj's observation/approach that we are better off following
the Page Table Root pointer outside of the loop, so that we end up
iterating simply on PDEs/PTE. I've been delayed by other work, but I wanted
to ack your question.

Thank you,
Alejandro

>> Thanks
>> Sairaj
> 


