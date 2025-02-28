Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D50C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to5FK-000648-BN; Fri, 28 Feb 2025 13:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1to5FI-00063l-R6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:38:00 -0500
Received: from mail-vi1eur05on20722.outbound.protection.outlook.com
 ([2a01:111:f403:2613::722]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1to5FG-0007GR-I3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:38:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDI8Vt6392hPAH4nWCEv0fygxo8k8GrQxFfFEGo0BWNKS4IcT171EQY74T6gQhQEP8cyvspLvzO5nGe8f7/rQagYm1UQOju9rHtld28ZGA94Jv5eF/QBuQpKeTBSXiOnPyEoFB5k30mQ+nYNA14IGE+i2U/xN+b4oGdkK2sr83Nh1XU+7WqT9q3cuJVcS6B545WDF64DBu79LFxcdvip9FYL9C7yni77w7PuU75gjVPEj0xw6hzuAKI51B+M7ohWKBXlEWrQNdqCxB5Z0mkBB2laASH2WdrJYQGFIe8tKGNLiXGqGN35WZeb8CyOYLxbkj3X+OjmcXXihol5ZIr3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CHZXiZ6IK6yUmYKOKV3PNS75boLWahbtgvt8Qc4sGs=;
 b=wZWJ38C8voHc/wKDihrgWMUfS+lyUf9aqRzj+DMTJZ4direlB8kLie8d8uG5Hbw4+yFN9o0lK0xqODPPRni303r8OKM8uBsjxAMtP5pwF3fTtTKhPCxXJqfGNcCiI8b/1HKSoqadzQS1/rEv9iyMVRO8bL1MvwluCVHlgD7Y7FW14C1t9wHgSIwmdaFHdWlgjEwQbTIFbrSLhvARhg2dNdvKLvKqrsU5zUC2IvOcXLnlzgpZNT+SGxVjeOpjZ5WOCrGlqwtF2CY5LFvkkdluWvkdWV8qOQeH83b/m7G0Zp4Ylva90lQXRB1yWNbo7VEFRXXnJSFrYI4LLH/P7VT7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CHZXiZ6IK6yUmYKOKV3PNS75boLWahbtgvt8Qc4sGs=;
 b=nxXK1s2SsGNkEXjJuf0E/DThpP8QfekjBwNv77mi65QZUh58FKTt12rX/kAo8chV6bhKiuiYKq+ZxvRmodW/MxZkV8Psa4W+h6boTH9U2d3ZjUoy4IrZfK9T0EF9g95eGPJ4k7LDyHYAG8+s58NWktxeEUqYC+EDo/swmf+uil+q+E2cEvcSAJnPjJc3XP6C3Rko17hIzuYp2zdFL+RBWKDjUwfwmhb6lTXO+YZDwp5sBcoEQksxAGVL6l/9JQw95rAiJKvlQp2cDzp2XM+ttxypP48+VQvjNcdnjXAxHShlOaE7SoKoEcW/GlBa29JKPWWJUpMshO3DAEs0/jMisw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8253.eurprd08.prod.outlook.com
 (2603:10a6:10:413::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 18:37:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 18:37:54 +0000
Message-ID: <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
Date: Fri, 28 Feb 2025 20:37:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c136c25-4a4e-4985-0b4e-08dd58270381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU9yVkEvRGZOeDd1TWwwNGFOaWZsaWJQV2VLOGdLd3JvOWdXMVZhUERJZnl3?=
 =?utf-8?B?S3NxT1pFRlNwdnBiQkRxZXlTZy8wZi9tWjVPNGVCamh2d09iYlhyelVlZm1T?=
 =?utf-8?B?RW4vd1QzdCt0L1lxZ0hjVWFnVGM3ZDZmdjNybTl4ZTZhOTVDWWkzN1MrdWd0?=
 =?utf-8?B?Z3dxRUU5Z1c3YUJxdFB1VzlveEdGK2pJK1ZFZE9EQ24wYkN5NWN3K3FwR0Na?=
 =?utf-8?B?WHQzTTJIUXdES2JhNytmbHhEOG9ieWdOb0xHcWk3ZERuOFZxaWJlSkxvQkhD?=
 =?utf-8?B?VEYvZ25nZE9LczlaU1Bwa2Z1NVp2UWQyQllwMTVUZFZNbVJPUExrbmRWQnRZ?=
 =?utf-8?B?RTJXallGeFR2SUVaeU5GQ3FicU51SEt6dlJaM0JsVGgzazJ3aWx3YnNNT1R6?=
 =?utf-8?B?YS9Vd1Z2MERGOXNPcncwalc4MEdYaWc0R2ZiVW5EeWlYME5XaTdRNDBLa2dB?=
 =?utf-8?B?UXFUV1Fhbm84SVVCWm81Q0lHbHptRzJEM1hWSVdhV0diMHNEaG9NWVp3Wksw?=
 =?utf-8?B?cW5hNmVHZlhDdjNTOHVEWlVsQXVPd0JNNTNVOXFDMGlOQmRlRk53QXRhQ3pJ?=
 =?utf-8?B?UkEwTjJGOHBlSWxHYThRd08wQTNhWlMxMFRhS2ZKQXA4a09LNXFzakhiNXV1?=
 =?utf-8?B?VFJ1anU4VjRwZDQwV1o0YlZ6V0J4Rlg5SGFNQXpEUjVmcC91WXZQaEozNlVJ?=
 =?utf-8?B?Zk9VdCtXNGc4Vjllc3RVT3NUN29RK00wN2cxY1FjR3o5a3M1TThvVU9VT3hZ?=
 =?utf-8?B?Y0p0bDFvcUVad3ZXWHRzWXRDdkI3Z2lIRndEMXVWTmFJWkhvVld4RkFmT09X?=
 =?utf-8?B?eUppa3NVb3pGZUtGMkw5YnRrV3luSzdFTDZ6K2FwOGpZVEdmaHFjM3VDVkdz?=
 =?utf-8?B?a25EdDlTcmdsRnBGeW45cFFDR0xpUkx6dE5DVzg0MTlCbjJsbFJNYWlkSnVU?=
 =?utf-8?B?dHVyMjRuTC9qazlwZFpZbUhUeHAxQUxETm1IMkFrWm8zTFNPdmxodlVPKzR4?=
 =?utf-8?B?Mms1NjdWRzR4UHBIbmYwRWdFcmNaR0Q1dWZUektHNWlYRnMvOTVRL0ZJMEx3?=
 =?utf-8?B?Qk9lWWJqV1VjaG5WUWRtOVR3WFBCK0dqK2t2ODJxVEo4WHRkNFBZME1lVFFI?=
 =?utf-8?B?a1Evbm82WnNFZllSS0tqMTNpY1FHQ3RsY0FmUERucnZzeE16SGdndTNHZFhL?=
 =?utf-8?B?cU9rTGsybTRYSFduUE1uNStYWmtSQlVXYTVJTGgzRmN5ZXFZMTFQN1p1SnBV?=
 =?utf-8?B?ZUJoYktkNmRES044Wm5ZN0ZDa0R2Q2RqUFZ5UGtqcDc2Kzlua01QQll5Wk0y?=
 =?utf-8?B?OFROUitEQllWbWFtZm1vTzdEZjBsZStQVmxnZkl1MXFXalFBdDRWVWVsNG96?=
 =?utf-8?B?Um1uR2dkQWVtOFRIK25sRkNnRFg5UkNFSFo2bjhoVHkrOHUvbWZEU2htMTBR?=
 =?utf-8?B?R1V4cU9aVXVhOGJac3BFMTdjd1MyV291K3BJUEZqZm00M1JUZGc5S1RYUFYz?=
 =?utf-8?B?Y3ZraWI3ZU9UdDdqeVc2MU1TMVVaRlFieXFpMUFXTnhiZG9MajkyV3o1L3VL?=
 =?utf-8?B?UkptTXo5SXRsa25QQ25ZK29rd2d5ZFhnL3A4bDdxcDN4RnRXUit5RWp3Y2Js?=
 =?utf-8?B?dDhIbzZ0bmZpSUxzMCtFc2JXSXZqMjlob3VLaVl0ZldnTk5yVmVFYmR6SnN4?=
 =?utf-8?B?RmZnLzhROGQrQnJxbE8wQjJsK3l6TERVeDBYSXIwU2o1L3d4WWxrWkVTZFdR?=
 =?utf-8?B?aUlUYXBBTkVnWlozSWNjbzRqOWFwd1lyRG9qL2ZJcTBJa3NzVWtObEVZM2VJ?=
 =?utf-8?B?OWNsb3hGSExrY1Zpc3l4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNzZ1YxSDkzWWh1cjIyMnVYd21kODB3eklCNmpPNXVVWEcrWldtN0h0cGtB?=
 =?utf-8?B?U2g3Vk0vQy9jYlRESXgrM1ZyY3V5R0ZDeU1vSWN1ZkpmVVZSN1ZacFNReFRO?=
 =?utf-8?B?RkJPZDVOQkE0YjhMVmtSY1RwY1dNT2JSazNjVXg4Z3k1Q2pleFYvbGlDNFRQ?=
 =?utf-8?B?SmFGUlVVdXBtOGJUT3Y3QWg0M0UvZUpHRkNHbkRNcUlsNUZOMzFjeUNHc0R4?=
 =?utf-8?B?M2dIZ0E5YW1LNnZMVnppNTRTZ1ZVbEFETUVuTW1rNHBxL2xSUmdDRzNJU0t3?=
 =?utf-8?B?NjJWU3lNUTg3TzcwK3JJdnZzdW9lK1RVM05RQUJVSHl3WFMvZmZNT2gwZS9O?=
 =?utf-8?B?akJhR1NoZnVFTEJCRGFKUU55Y3hDSEhoVnh4dTNhbVkrQUlhVWhlN1FMNjEv?=
 =?utf-8?B?S01jQVdhMWwzdFZZMkdkelNJU1B3Y0ZuUEZLK0dWbHVqT20xYzhOU3RrTno0?=
 =?utf-8?B?eVZIb01ldnlCNUJlYVBMVEcwaWx1MGh3Y3ZNNGRKeWpYbWNiajFvSEhOZjRm?=
 =?utf-8?B?ckNESVJJQ2FJNDVYdTg1SHFDQnd0M0hsNFN3WTBmWW42SENERWRIdTRyQUlp?=
 =?utf-8?B?ZEM0UFJ0ejA1OUZBQ1J3RVVXSDNwR29UMzRlcFF3Y2VTSHV3ZTdCRUwybGU0?=
 =?utf-8?B?SCtDU002ekxNa1d1eUM2NUtERXN5aXdvOFp2eWo5cGM3RGtLVjVycTlibmJr?=
 =?utf-8?B?VlIrSWpIZ2hsQnRPWkxSQlZFTFcxVjVqYzd2amhGUCt3bTB2cDRXWkMrTmh2?=
 =?utf-8?B?MHl1Yko1N0I4WWRTYlBESmR6UXgzUWVKSHdrVUFwZ000WE13ZksreFNReHBB?=
 =?utf-8?B?c1VzKytjVmZobDgrSTRsWlBvV0RUVW9wVGh1eXdXNnRURUk2a3AraUFpV3Bj?=
 =?utf-8?B?aDVVSDFVOVRGRjgwODBjWE00NXlLRzFxVW5HRVpFZUFUc1ZLMjNya3U1aDdB?=
 =?utf-8?B?OW9STWgvU09HSU9YMEYxL01ySHN6WnZHK2RMWTczR0hqRTNnVndVSGZtNVZu?=
 =?utf-8?B?UWplUHIydEpEWDI5eXZZeWdib1IyYzNyU0ZDb094azZ6WTR6b2JUU3gwczBv?=
 =?utf-8?B?RUFOL2pNN3dEM2N2dDF0azczQUk4Njgya1BIM21LZ2Q3ZVVEMHYrVDFsSlVK?=
 =?utf-8?B?Y3BWQ0JDUjJvMXJueFpBSVFBR0VnZzYwaGQ1SWNlWmJHZlhGZGVQVjRVZkZ6?=
 =?utf-8?B?dDA4dGxITkZ3TXZXODA0NkROcGdBWTdlQ21ZUHcrMC9aQ0Q5UDVJeFBuZzEy?=
 =?utf-8?B?eWtxZTZiV1locjUyYm9pcFRzOTB5bnlPRDR6Z0x3amtZdXlCSHFUc0RUbHVp?=
 =?utf-8?B?bTZZeWEybE9SRnpGQU9JTDJvS2FMbDFCaHBZK1dCNXQ3MzRPSGFGenFuZWM0?=
 =?utf-8?B?V1hsR3JEaDNSVVE4dTAwYis4VklwRnFEWFdRQWNhMnd6aGNlZVUrR0tBajdJ?=
 =?utf-8?B?cmxoWXFvQjRKc2tJZXM3dFdZdEl3Q1pQSjRUemFpRU91TzRlVXNnMzVOZVJV?=
 =?utf-8?B?WEx6dDZWVGdNVnU4MGJHdlNwd2cxTFFSLy9nSC9FNHhqd2VhL3A3ck05aHN3?=
 =?utf-8?B?ZDI1MytSQTUxL1BZZGdsbW5IbGZRSjJYaW1BUHNYZ01aN2duNCs0VDRRejJ1?=
 =?utf-8?B?cHlSd1Ixc01raGJ3c0pGRGlTUi9hUDY2RTNGa3dkWVdKSHpUYXJGdmxnUDEw?=
 =?utf-8?B?V2xkZHhBamFadWdGYkVYVjduZGphNzhabktiVlI2L0drWC9la3c4RVorV1Z3?=
 =?utf-8?B?SnFxOE40WTV0RlQyUTJkLyt0ck1FeEZLM3lLYlQzNS8xMTVVR1NyNzN1K1Iv?=
 =?utf-8?B?MnpzbVdkaG1RVXEwdlV0M0JkdHFSaFFoRWJ3VGdETGZrbzdmTktrYnZSRGpp?=
 =?utf-8?B?UlV2TzcvcXpqM280a1JpNk5rL2FmSlBWNDNjWDluTFEvRit4cWlPc0FrVDYw?=
 =?utf-8?B?cHFURlArWnZTeWZPaE1rMURwS3dLUnFyNlFwVWNxY3lYSVdBMFFmSW1xZm0r?=
 =?utf-8?B?a2d5S00ycFFYTFh1M1RiSC9RYkRGM0NWcDNoNUVxQmo4MjE1eldWYUFCOWVO?=
 =?utf-8?B?aGtVckdVSXBLVjBlMVFObDNyRldWYkNRWmF2TzBpVlVlUWkrV0h1clRsN1VX?=
 =?utf-8?B?b2szV0ZJYkhHaXFUWjh2N3RjY20vOVNTcitZRTRzV3QySmxMeHVVWGFzTlZs?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c136c25-4a4e-4985-0b4e-08dd58270381
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:37:54.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9zkk13cW+bAAxApa3aIiKaMLqsCakNW9JUd01Gn8nVq5uY9xQ+SqZamnRXFnB2neG+TmAyN2uOKO+JwRryHmgnkSWYnKa9Eh17klOjo77g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8253
Received-SPF: pass client-ip=2a01:111:f403:2613::722;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
> On 2/28/25 8:20 PM, Steven Sistare wrote:
>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>> Hi all,
>>>>
>>>> We've been experimenting with cpr-transfer migration mode recently and
>>>> have discovered the following issue with the guest QXL driver:
>>>>
>>>> Run migration source:
>>>>> EMULATOR=/path/to/emulator
>>>>> ROOTFS=/path/to/image
>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>
>>>>> $EMULATOR -enable-kvm \
>>>>>      -machine q35 \
>>>>>      -cpu host -smp 2 -m 2G \
>>>>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>> ram0,share=on\
>>>>>      -machine memory-backend=ram0 \
>>>>>      -machine aux-ram-share=on \
>>>>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>      -nographic \
>>>>>      -device qxl-vga
>>>>
>>>> Run migration target:
>>>>> EMULATOR=/path/to/emulator
>>>>> ROOTFS=/path/to/image
>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>> $EMULATOR -enable-kvm \
>>>>>      -machine q35 \
>>>>>      -cpu host -smp 2 -m 2G \
>>>>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>> ram0,share=on\
>>>>>      -machine memory-backend=ram0 \
>>>>>      -machine aux-ram-share=on \
>>>>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>      -nographic \
>>>>>      -device qxl-vga \
>>>>>      -incoming tcp:0:44444 \
>>>>>      -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>
>>>>
>>>> Launch the migration:
>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>
>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>      migrate-set-parameters mode=cpr-transfer
>>>>>      migrate channels=[{"channel-type":"main","addr":
>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>> {"channel-type":"cpr","addr":
>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>> dst.sock"}}]
>>>>> EOF
>>>>
>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>> following messages:
>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>> 0x00000001)
>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>> allocate VRAM BO
>>>>
>>>> That seems to be a known kernel QXL driver bug:
>>>>
>>>> https://lore.kernel.org/all/20220907094423.93581-1-min_halo@163.com/T/
>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>
>>>> (the latter discussion contains that reproduce script which speeds up
>>>> the crash in the guest):
>>>>> #!/bin/bash
>>>>>
>>>>> chvt 3
>>>>>
>>>>> for j in $(seq 80); do
>>>>>          echo "$(date) starting round $j"
>>>>>          if [ "$(journalctl --boot | grep "failed to allocate VRAM
>>>>> BO")" != "" ]; then
>>>>>                  echo "bug was reproduced after $j tries"
>>>>>                  exit 1
>>>>>          fi
>>>>>          for i in $(seq 100); do
>>>>>                  dmesg > /dev/tty3
>>>>>          done
>>>>> done
>>>>>
>>>>> echo "bug could not be reproduced"
>>>>> exit 0
>>>>
>>>> The bug itself seems to remain unfixed, as I was able to reproduce that
>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>> without the cpr-transfer migration the above reproduce doesn't lead to
>>>> crash on the source VM.
>>>>
>>>> I suspect that, as cpr-transfer doesn't migrate the guest memory, but
>>>> rather passes it through the memory backend object, our code might
>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>> corruption so far.
>>>>
>>>> Could somebody help the investigation and take a look into this?  Any
>>>> suggestions would be appreciated.  Thanks!
>>>
>>> Possibly some memory region created by qxl is not being preserved.
>>> Try adding these traces to see what is preserved:
>>>
>>> -trace enable='*cpr*'
>>> -trace enable='*ram_alloc*'
>>
>> Also try adding this patch to see if it flags any ram blocks as not
>> compatible with cpr.  A message is printed at migration start time.
>>   https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-email-
>> steven.sistare@oracle.com/
>>
>> - Steve
>>
> 
> With the traces enabled + the "migration: ram block cpr blockers" patch
> applied:
> 
> Source:
>> cpr_find_fd pc.bios, id 0 returns -1
>> cpr_save_fd pc.bios, id 0, fd 22
>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host 0x7fec18e00000
>> cpr_find_fd pc.rom, id 0 returns -1
>> cpr_save_fd pc.rom, id 0, fd 23
>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host 0x7fec18c00000
>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size 262144 fd 24 host 0x7fec18a00000
>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size 67108864 fd 25 host 0x7feb77e00000
>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192 fd 27 host 0x7fec18800000
>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size 67108864 fd 28 host 0x7feb73c00000
>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536 fd 34 host 0x7fec18600000
>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size 2097152 fd 35 host 0x7fec18200000
>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536 fd 36 host 0x7feb8b600000
>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd 37 host 0x7feb8b400000
>>
>> cpr_state_save cpr-transfer mode
>> cpr_transfer_output /var/run/alma8cpr-dst.sock
> 
> Target:
>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>> cpr_state_load cpr-transfer mode
>> cpr_find_fd pc.bios, id 0 returns 20
>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host 0x7fcdc9800000
>> cpr_find_fd pc.rom, id 0 returns 19
>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host 0x7fcdc9600000
>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size 262144 fd 18 host 0x7fcdc9400000
>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size 67108864 fd 17 host 0x7fcd27e00000
>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192 fd 16 host 0x7fcdc9200000
>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size 67108864 fd 15 host 0x7fcd23c00000
>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536 fd 14 host 0x7fcdc8800000
>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size 2097152 fd 13 host 0x7fcdc8400000
>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536 fd 11 host 0x7fcdc8200000
>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd 10 host 0x7fcd3be00000
> 
> Looks like both vga.vram and qxl.vram are being preserved (with the same
> addresses), and no incompatible ram blocks are found during migration.
> 

Sorry, addressed are not the same, of course.  However corresponding ram
blocks do seem to be preserved and initialized.


