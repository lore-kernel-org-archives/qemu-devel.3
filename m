Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF36CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 00:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz2cG-0007c7-0B; Wed, 17 Sep 2025 20:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uz2cE-0007be-9w
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 20:35:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uz2cA-0007KZ-IU
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 20:35:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HN2u5u014267;
 Thu, 18 Sep 2025 00:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fXHdTOT+tCreCnFgSWBTJaVZy9mJPawJnnGhkBHbGvw=; b=
 hqrBdPEYFicnMHxH/1JGJv2Q2+xX5E7uURbi2QiGhOMu3c4G2R8m76Kzx/dBFyUG
 tDp9EAt5HoBheFMOMpyrK9Nw5sY4I+gcHuqKDitSKN7y/jvyPbz5WnW7LNO7xFWb
 ZmT601NbbmZwtFloLMMDlfgYCHWNE+YWQekNbJsTjzQ7fC2rLrxG+hmO6CRyA1FD
 IHupBJm61oydGR6ZBENIdhe1VK9LVOIc/zU/BRS69O0ju3ggih9uueHo+injcosb
 eahMQoqF0xzwPJ/x5wE8nR3kLvZesSSDhv5K7FyXCmdT/JDroRtuLrH4UqSuEkVI
 O7B5GngHlwBhKtdAnY3fGw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kafjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 00:34:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58HNNshv035088; Thu, 18 Sep 2025 00:34:57 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2mrjb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 00:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP3H/si+ZuM7EHI3hkXZ4pnU7p0d+tdIiK8VJvAdRpuSoYHxpx6hDY9TjJqf+QngRtvgALUE4isLtHghZ2GnKQG39A6N8RsZpq9sJKzd2VW/FizHklogzxTUIdZZ7x/243ck6CRyqUkLWsEoU5mUYeBjJotv5xb2YVIRRoaBxNBi5TA73lfkHpj1D8FpN0NJIPsEnpkn8ufJiufeljPPtROaohbXs3AwdNl/Lzd/DhejFbolE9crbmukyC2K4NLs4q57XfW/Zpt/bfy801qHsSbg3cxAn9fkxd0EAdCd1S+UMCgKY0AFvM70rLHs/yLfdUVQvuMb+P1Ie+/f7fxuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXHdTOT+tCreCnFgSWBTJaVZy9mJPawJnnGhkBHbGvw=;
 b=eozolyY/aVHA3sgrGPie0veuaDEQbVGcTB2hxmPEr6QSPmUPyQThxwyZEzIoGLIh4wmVAHq/uQiFy0+3f8RsMQ0VplHCaU7vIVVjLyN1032Fa5UeEU0xsCcP6uocjhBxCa70iR8F/+kjB2gT1Iq7uJa5tzgMTRyNNCClNUvINj3DuFcXA9lrzFof0FhwiHubRQKczB+rEjXgkPyG5pnXL8rmXUSpt5pGJ/f6ZAavjwOXyvH65ii5YhH2eRqxAlozbgg1Tjn2Uv79LWBHhbU498cN8BLS5Pla5H5ysOOhmMhipiu1j7GJJhWciHFZsfcOZRtorAxhIuWne/0XsJuYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXHdTOT+tCreCnFgSWBTJaVZy9mJPawJnnGhkBHbGvw=;
 b=lYaKxykzK0xeptv0zXdmwkWUZXZNFB9Zwq35WyoNJLRPeZmzWyVIkHZRhqVvcBqgnIxqYU3hwRm2w/RdFY7SdiBjPD+K8N0vP1HlPyV3r5uUIdOHyl5aaY9YUgB72vPsJfHwn68NbWoUPg3mM5yr30QE4hmCJBHT2QbX/LZwj4U=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 00:34:54 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 00:34:54 +0000
Message-ID: <f8b37c27-db20-4e03-bb34-88357f33a26d@oracle.com>
Date: Wed, 17 Sep 2025 20:34:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] amd_iommu: Add basic structure to support IOMMU
 notifier updates
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-10-alejandro.j.jimenez@oracle.com>
 <82dd98e4-aba0-4413-ac4d-c64cb2d25c7d@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <82dd98e4-aba0-4413-ac4d-c64cb2d25c7d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH0PR10MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a540802-dfb3-4443-f68d-08ddf64b2fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjlobG9FSjdJYUl3Si9HSVh1bzkyQytSdEUvMFk0TFFjSm13VStSR1VHNFhu?=
 =?utf-8?B?MGV0aFZqZWdtREJjM2FOdGlWSGJyd2djMGR3cFdHRDNlUWdBRHZ6N25sUXJI?=
 =?utf-8?B?dmd2N0R2Y3F2UVBIdndkNWpXeDJ2eWVtRzF2KzBvRkYrQUc1cnNnZng1bUx3?=
 =?utf-8?B?V29GQzl3YTZ1cHV2NFlab1FqL1RDSU5NRU9VUVYvNS9VUW14aHZkb29wbUtk?=
 =?utf-8?B?NU5KVlorbi9ZNkNvN3JJbm9NcjNYbUIvOVloUEhERnYwdXJGU0t2TzJzQ3pB?=
 =?utf-8?B?ZzVIN0tEVkpiL3JYNEZMZzV1VUhrMnVaVEtYVWRZTTBuZlFyK3BxcEZXcmp4?=
 =?utf-8?B?RUZNbjdBdVd6NCs1UEJpT2s3MFZqbGZJaEVEZXVtdW5SVktYNUVZamNxTEdM?=
 =?utf-8?B?RjlBek9kZ2wzVGlsMVlidWJVdUliUXNKVEVwQXM5NXljV3hpR3FMc3hQTzV4?=
 =?utf-8?B?bTlIS3YyaWQyUFZxQnk2VVZ2dHBRdjEyVjVPbXo0Y2k4eTRuNi84b1FCR3h5?=
 =?utf-8?B?TnRIRWFOZEZHS3hiMWdERjRmYnJmVTBJeWxYYWtIaS9xSVV4YmU0bWRzZVNh?=
 =?utf-8?B?TWVkdFRSaWE2aHZhQmxVSThQT3lKK2dVd1duM1krSUd6WWwwQksxWkM2dThP?=
 =?utf-8?B?OVlkK2czNTJFemVBMkR1NzVvSTRuMVhaU0FHTXdTbE5rc0FLYVZEVW0zY1Q1?=
 =?utf-8?B?RDdjRFVPR3U3K1lJZ3F6NnpuUzNsVVlSV0FFSFZVSlBRVnFxVEZJa0c3djA2?=
 =?utf-8?B?bVJweGZCMTJHeDM4REh3cFZ6dWkwcXVKckN5bDExUTRrcTJOYW1uajRHZTYv?=
 =?utf-8?B?Qkh5NTN6aHk3ZDZQdGxuQVAxN2FWayt2S2h0OGxYMFRqbkU0YVF4RExJZHRO?=
 =?utf-8?B?S2JvWmR0SThyOWhQc0JwMlBPNG13bnVVYWsybzNZZkhZMXo0ak9LWmZFRGph?=
 =?utf-8?B?R0IycW9QdXJOZ2haOGdaU3RwK0Jyci80ZVE0c25sNG9KaExPS3U0cEVGaHVx?=
 =?utf-8?B?bzZHTzB2NmNJRmRGbmRldHFaVnkvaWFGTVF1Q3hWYTh2QkVXL3V4T0F5dlNZ?=
 =?utf-8?B?akZoaEh6Qk5XTWNDb0lSc2ViUkpVZTZZM2hWeFJnay9FK3hqS3FNV0pVWUd6?=
 =?utf-8?B?L1pqaEtwbnpZQVl3NU1GeUVyeXFualc2ckhiV2RDRkVsN2NqcjBRa1V3SDlJ?=
 =?utf-8?B?TGo5RVhKNnFoRVRqVGdKRk4vbGZTc2M5U0VVYzVUL1I2T1VvbzBIV1ZjUVpi?=
 =?utf-8?B?NTl5aVUycGxKcUR2S3dsbkx1M0hZeCtEbFhBUlFjN2pjbnV2eVRMbE10QkF4?=
 =?utf-8?B?dURFWE9NOFNOcU1mUFZzc213SktpV0tqVmRFYTBRaHNiY1RyK1BxSTlEVjJS?=
 =?utf-8?B?L3I2WC94ZFNNbWY3V2lTelVTZmFRdXVYZGZrdy9CUzdRVllRZmZuc3BWakJi?=
 =?utf-8?B?V0laOVJPTmZ6ZGJ6bGtOcTlFVFA4dk9Za0dEQjFmdGRFS1lNWVJuUzJjeC9W?=
 =?utf-8?B?ZlNhK1VSeEZZRGZyY01jNTBDWFplTjl6TEZ6eEJ6R01RRTRmTmJ4bkFsdTNv?=
 =?utf-8?B?elFFWlhOdkFxdE5GWVIyL3AyQ0hWVVVQT3ZZOEZEQUN0bS9MY04ydGFJWUxk?=
 =?utf-8?B?NDdzR3h1OEJDRm9TalJBaWRCcmZubUxFTXp0aGREc29zamxLUDFtMTR1cHVH?=
 =?utf-8?B?U3RJZkpISGxqUnliRTNjK0hYQ2RiaHdqRmU1dTZ4eUdmdGZxV0owWkJUK3Jk?=
 =?utf-8?B?NnFEZVZIN25UcVhHdFFXQWVjYXdmWUI5QnB3L1VFMk15N1M3S1NoTGIwb3N4?=
 =?utf-8?B?THZmOTZhM0R1R3VrWlVWMHU0OCtYZThKQzBQVytSOFd5MisxTGRIV2N3VkFa?=
 =?utf-8?B?RDA3czk1M1p2bVE5SG56eEFrekNHcXN0UHc4QlFVdWU1NStISkNiK1pER2di?=
 =?utf-8?Q?YAtb5e2d8f4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE12cGFsODFrZm50U2dLbnZpdVhZenE2U2dOUmovRzhGWDYyMmk3NFJndzQx?=
 =?utf-8?B?M0JZSUlwQXJIYzFlNmtoeFAzOGt6Z1pLaHdQSjk0T3Y0QXEzcjl0ZnhuTHgz?=
 =?utf-8?B?a1R2K0RERGkyeVg4czdLMjhYbVBLbjRNQ2M1Mk5kQmFWSWhyZ1hzbXZ0ZnlD?=
 =?utf-8?B?T3BkYVpsbTJJN3FYT1RTY2prMHdIZ1laMnR2dWthd3NtUHd3QSsrRndhRW9x?=
 =?utf-8?B?dE1yL2c1eExndDVLRnd5dVgxZ1AxNTM1TkRyR0FTRVljUFZnTnEvb3h3SWo1?=
 =?utf-8?B?NTNva01zRUtlbnMrYWsrSTYxWlEvVk92THhZS1drSEQrL3NaQ2dLN0NKZzdt?=
 =?utf-8?B?NEZxcjAvRHliQUZJa3VJZkRTbHNDcHZNUDlBazlRYWpFRVNXb2FUOUlodVZm?=
 =?utf-8?B?Zk1mbEZYVmdhMmtmZWI1TjdGR3dTUHg4KzRIQ2RQTnRzNEdsS2xuT0UvTzFj?=
 =?utf-8?B?VUFWdWF2MFZIaVRjV0xWdTZFcGlvckNtRHN1RkZtY3Vjd2lRaUxleEJGOFdR?=
 =?utf-8?B?aDVhOHZhQmdoZXRnVGkzcGtsQjNjS21pWEZMd0x3S0JtNGszc2hoa3FZampN?=
 =?utf-8?B?OVJOV2MzVXRoQkZaaDhQT2xndWd6d1V2NGVQR05nZEhxRXA0b2hWaFVLc3ow?=
 =?utf-8?B?UjUvTEkzdmF1blZYY0ZUd3J0VDFxbmJPQ3FrVTR4MTk2NlFSeE9JSnJ2SlpO?=
 =?utf-8?B?VytERTNIRlVKdUNwdGdYeEVvdFZUREtJN3daTllyV2JGY1R6Mmh6VU1COFRK?=
 =?utf-8?B?UjAzbTE0bXVsT2p5WThNSmlQc1VSNHRRN0ZvY2xBRDR2R3NSTGcySlBSWFJj?=
 =?utf-8?B?OVhUVXlFV29xT3BHd2R4WlVxSldnR3FINW83STk2cTFwYWJvWnRIMXQ4TzBL?=
 =?utf-8?B?NXR3WDJtbVRyeEhtL0NXYjZ2MktIdU02NGIzWlc0TGN6WHNYWjdWeDMvbGd3?=
 =?utf-8?B?OU03OXFrUEtFbVlrUmRaK3ptaEtYSkNWTDlRVlBzWUlFL0swOW9wUDNaaldT?=
 =?utf-8?B?WEVTN3diZ2JaN1N3UHhqMW1YOWp6amo1aVBrODVNTURFR3FHZmgxT2FKZW01?=
 =?utf-8?B?NDVScWZHK1hKcGp6NHpKbjJCQUltU2lFLzR4bGdzU2h2MjhmMUx4ZFJYNEUz?=
 =?utf-8?B?V2JxNGRpdVFYeVJSTGcrSHUrUDIyMTBBQkI2bG9pYnV1RWY2b08rUmdOVVNz?=
 =?utf-8?B?SlhDV0swUFdJSmFoTTM0ZzlMVGU3MnVFMUE1S24wbXhSUWM3TTdzdDE3ZUJF?=
 =?utf-8?B?Z0dqall3YUErNERaeDk0UUFQdEpBODdTeDlEY2NOU3N2MXVYdzdXcThLZkFj?=
 =?utf-8?B?MVQ5NVJkTnBUNFJoSGFxQzdCOTBmK3ZwUlZtT2ZiMnFjQlFaelhDb01jS0pN?=
 =?utf-8?B?aWRSS3BPV01lKzRGQ1pZb1JWakF4azdkT2RLV3FMWkxSZElSNFZ5a2JiUlFV?=
 =?utf-8?B?ZEdLUkRCVnpNN1ROQkZLMm5aTHNHdkhRWjM5TFBQaFh5cGVlMjJocnFwRWFL?=
 =?utf-8?B?bk53ZlZ4aEM3bmxySTBwWXlrSjhCT2dtR2k5NWJ6L29tT05hb1NFVnI4UkxC?=
 =?utf-8?B?eDBER1pqWnNiUUtoaWd0bGJzRm9JVlZkRVl6VFdlbTBxVnRQaFJnZm91RFpB?=
 =?utf-8?B?RU5abGxwT0RzWUxPRVQyemtiMjJuWUZjb2xOekpWbUZOdDhHblNKSE9NbnFQ?=
 =?utf-8?B?V3dsdEg3cVVUdCtUWFlFSUhqeUZPekpzaE9NZkttNXVLTktJRWtBWVVGTUtR?=
 =?utf-8?B?bWJQMldjN2RhVmQ1NVB1cm9JdFBqVlp4ay9pcXRYMStiaE1YV01EeEFUbXhp?=
 =?utf-8?B?S0VVNk9iSisrcWxFZW1jRm0wQWRqVDZFd25ZVmZab0hOWEI5RlJOV3VWZmtL?=
 =?utf-8?B?dGNXeW9ra25mTnBtVEd5aUhGRXkycnhZNVJWRldrYTRuMTFWQzZpcDF6MnZQ?=
 =?utf-8?B?Yjhya3E3UUh3T3dTMEJlRllBb2hvR2NtVzNvVytVTGdPWkVFZDJ1Ly9JSVds?=
 =?utf-8?B?S3VVcTB4VXhtY0IvOWR0L295WXVqTk9KMnBHRUZzbVc5enZIR0lRaXdoZFFo?=
 =?utf-8?B?OWFuRkRqa1lwYkw4ZmxJMjB3SkM2QlpYVDhkMGc3MFpNU1Bva0lGdXl2UStr?=
 =?utf-8?B?M1VVMmVFOE1wMk1kSGxjN2NseS9vOGNOUC9mbEhSZUkrSTc4RkN1M0IyamhR?=
 =?utf-8?Q?37e64mjPj0sRkpHq6uTrZvc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VO+Bu+0JzzLAECt6H0dvfGhqXhj7/WlGYKrOQ/WUbqLx787i6I7WlHOmVLINUE4i7vxDVIrueO+EF7VufU22SFo0OVKso0tGlTbUu/fQYE3Vw5sH6hWsWCW1yhrWBzEO51B9HzHXf08PQThYrqolNvLKO+fxBtg2rv6U45T3XCqWlnD2kMQGgO8ao5nE3Sbk5w1dAiVSBNqa1plYWD9rY0N3zDcitPTDILl+tLGM5P+hZpgp09h4eVdyI0IHhVioEJx3hkCnDWRIaSIhLtnjkhjNh3HlPAibCL594qEp1POB2MbSHCP1XrPchb8VznkiV50dnBxzoakY9Up5IT7ef5yk0XNMLN/I2Nc1FtyUGK9kR7sTFflA/eeKM+dlIgBTcPbFRqvZRxTrJ6U1/HwfwTGSI5gzUFtv5Y3bwKSGcIFyxBEY4dRAVVtDyBPkrXiYohEp5TrL2Vwklu2MGeKccMFWBbCSgG/WfD04i3StH2W5AkbhJhp/zMnTg6MngZkn5TDWY3hXqvIOaVmimXquBPD6SZ0lEJ66wiRF7IuI5YTzuYmuiftK22dNV61WXzKTBdhFJWQ6OoBlI3DbzjQpol2ZwrCm4Q88ZHzo64dIv98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a540802-dfb3-4443-f68d-08ddf64b2fe3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 00:34:54.4590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwbwaXx7z+zWRz9CJfHvnKlrnEWVzav3UcYsF399VQwEgRd+k1JCk8Gevkr2lylgA29veJISmxQ8UL7yh2g2a+YdrR3qPSdUUhw5Y4qZLQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180003
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cb53b3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1IzDNr8zmPRHvLrNZ-4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: hcNmSC_8IHQfAgnVcybh6f3b5fQLa-d7
X-Proofpoint-ORIG-GUID: hcNmSC_8IHQfAgnVcybh6f3b5fQLa-d7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX0ADOCPf3zC6G
 1gYdZFUGUlcJhCHQkmK7gj5eZlvoTeqtTMaAkNciFexfiVC6W8UrfFjYJ37yZyK4G1p59Nm8iQv
 ZqXNb2s24r/MWUcHF/kDOoLob1sOjOxY02rvjJMXhoC2/ZftIOBqbPULqYo26oXHXaKRt1Osc8V
 TheVO09SMp0VrJHkQoXZvxEkaNZSuN+aTymh195NicnEfpVY+3Mw9d9PyKY35+56/q005SHM1yA
 ERKGxKvQi9054+DWLPSIqXbsyCvtIQYE5139Q8PR3GujDIotJG4JNTBUxx3Bz9awndFSP0ZQzKz
 k+YtFluLUsejhgboBkNNaK70plWPgUPLKjj4MzbQak7I36je0w4JPJL06EvcbF5VLatONmwV5mx
 rr4QD7+Vqrm2nlQYsTglCbaXJqVCog==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/23/25 12:53 PM, Sairaj Kodilkar wrote:
> 
> 
> On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
>> Add the minimal data structures required to maintain a list of address
>> spaces (i.e. devices) with registered notifiers, and to update the 
>> type of
>> events that require notifications.
>> Note that the ability to register for MAP notifications is not available.
>> It will be unblocked by following changes that enable the 
>> synchronization of
>> guest I/O page tables with host IOMMU state, at which point an amd-iommu
>> device property will be introduced to control this capability.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 26 +++++++++++++++++++++++---
>>   hw/i386/amd_iommu.h |  3 +++
>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 6a2ba878dfa7..2f69459ab68d 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -66,6 +66,11 @@ struct AMDVIAddressSpace {
>>       MemoryRegion iommu_nodma;   /* Alias of shared nodma memory 
>> region  */
>>       MemoryRegion iommu_ir;      /* Device's interrupt remapping 
>> region  */
>>       AddressSpace as;            /* device's corresponding address 
>> space */
>> +
>> +    /* DMA address translation support */
>> +    IOMMUNotifierFlag notifier_flags;
>> +    /* entry in list of Address spaces with registered notifiers */
>> +    QLIST_ENTRY(AMDVIAddressSpace) next;
>>   };
>>   /* AMDVI cache entry */
>> @@ -1711,6 +1716,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus 
>> *bus, void *opaque, int devfn)
>>           iommu_as[devfn]->bus_num = (uint8_t)bus_num;
>>           iommu_as[devfn]->devfn = (uint8_t)devfn;
>>           iommu_as[devfn]->iommu_state = s;
>> +        iommu_as[devfn]->notifier_flags = IOMMU_NONE;
> 
> Hey
> Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE. Though both are same, the 
> clang compiler complains about it and fails to compile (GCC works ok).
> 

Good catch, IOMMU_NOTIFIER_NONE is the correct type to use. I fixed it 
and checked it builds with no errors using:

CC=clang CCX=clang++ ./configure --target-list=x86_64-softmmu --enable-debug

Also fixed the whitespace changes you pointed out on the earlier reply.

Thank you,
Alejandro

> Thanks
> Sairaj Kodilkar
> 


