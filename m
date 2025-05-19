Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8359AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 01:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGpXU-0002oz-8v; Sun, 18 May 2025 21:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uGpXR-0002oC-6u; Sun, 18 May 2025 21:43:33 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uGpXO-00030C-CF; Sun, 18 May 2025 21:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSr8VkLC+2N/yElP/s7BWN3a/3m/PqbMeBQfd/Bz7OrcfdYv3Xt5RwWl/yeO0kWCoNLwQfPv+TfTHsqmi68hwx0HCCAbKaE+qPnCgZ6QrPq0MoHDan2UXacxMZOvDcLsDA7kmfIiAUwEogFIAf9ajy2hKPmpP2HkrFkDviqtAltHJY2GZK17h2KG0mwafoOQyLXGP6SK7Z1wr8kgJcftZsJNsZVlqB19GIIJVAaUluotA2YaQXAYYY2zbEboHDO00I8tLcin28My32Njdc3G1pfVFu87NAYRR/KE/l7CcRUZfS41BDr9IxInYEAarh7P6UT6PI2zeOIFgkUhNbZIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iuGeBPbSyRxB4H1CgBj2NUL0xXoS55Ym0fWSh4OHac=;
 b=hdujEcMxVGo8+C4qzDSI7KbzXr1+P1WDkERj+XB/kG5qfWRWsUqK2l6zt8WomThJL8xiFjCmT8zTUQmmJalbI3ZyDt/lYJtSioPtTcdrQXwJ8shMKU15rUL8W7IZEG4BsH6lEx7AqNY8ZhzTwzxmBqdxz66RVFgqBO5dP6ff+37+TauaZf32dPIDpbppvd2yHhO+FP6G2IC3KQom7okbb41oJLF/ngCZGNEoVay45LlGZPJLGU61rl8m2jM/jCIjZnH/A6q9Hot2qARPID+6xddYpvBKm5+CW1+AmPLEkOjAedW8vvdWSVmGXECDj3kYoKjx+QB8EAK/lnUP9MMbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iuGeBPbSyRxB4H1CgBj2NUL0xXoS55Ym0fWSh4OHac=;
 b=IAZqJDu774NnzjWoXb4Hz2z16OuUxDN9kJ5Ckbvz9BnHcD2GE7zGOfK0GL0vXZJFEQO1ICk+l1/nVMWhWfxog9PrRepSlWLvxbuYrR/XuE52zGRcjEq6DtdJBNCU0k9/7tnm9uTSMJY20h/cj51Hf95gseIXec16tan+/nV9bWM/KzG6digrp/q7xIPUam3gcE1fPCV4DZexUtRC7evYHSACSn7VllOQaAcEujaOxbFb40zhR+fuvHOzLaO1ry/kqq9+ptssjdc2nRLOwrJZkssEScU0HVk51zrpVzRK9q2qx04LMWg46TxoSBF5P6LR2kaFYXiauylkIYQXiF64Pw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5764.apcprd06.prod.outlook.com (2603:1096:101:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Mon, 19 May 2025 01:43:16 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 01:43:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PULL 34/46] hw/intc/aspeed: Add Support for AST2700 INTCIO
 Controller
Thread-Topic: [PULL 34/46] hw/intc/aspeed: Add Support for AST2700 INTCIO
 Controller
Thread-Index: AQHbkPqZAMm1nT4ye0CS62ZvbxetrLPVj10AgAQNO5A=
Date: Mon, 19 May 2025 01:43:15 +0000
Message-ID: <SI2PR06MB5041028CC4056422E61F5E47FC9CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250309135130.545764-1-clg@redhat.com>
 <20250309135130.545764-35-clg@redhat.com>
 <4feacbca-76fe-42cd-a8f6-9daf70f2b437@linaro.org>
In-Reply-To: <4feacbca-76fe-42cd-a8f6-9daf70f2b437@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5764:EE_
x-ms-office365-filtering-correlation-id: 276effa5-ecb7-4a6e-f319-08dd96768625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VGNnYlJCZURmY0I3aG1NTmdHZCtyUGtBQWYzTSt1RFBnTzJvM0hNbzNmdnpk?=
 =?utf-8?B?dG1pRUg4YzdCT2YvTVBpWmdZUzl6TlYwRGhUOE1kcEtKR2ZkeEJlbXBldU85?=
 =?utf-8?B?RDRPbmpZRXBkU2E3ZGRQRnJKU3lhMFVRc1NucStKVGhXWFBYT0ZkZG5ud2di?=
 =?utf-8?B?NGhLMUFmL0xhZGlJNDdKUlhCcGlsNWpoY0xSbThmMHVIU3AraWoyU3owWFpG?=
 =?utf-8?B?SERFZkZGc29zSi9ESjZISXZrZWhWZTRhbEs4a2I5RjZ1QUpxaTdUWXhQZkxD?=
 =?utf-8?B?T0Y1Q2p6S2hyOW84RzJBZS81YVJUOGMzbFFuekZlemtUdks5bG1UZDdvUkFD?=
 =?utf-8?B?N1h5YXRtc3ZqMzZibDd2THJ1NGlCaXkwSEszaElSa01GMFJEckt5K0dFdVJZ?=
 =?utf-8?B?Uyt0U1NHZHVyQlZIVWZXMVZIZ2NOSTR5L09acURDd01MYXZ0dUFrcURiTVlK?=
 =?utf-8?B?RUhXQUhHeXhPUW8vQmFSR0RVQUZuWEJncHVvTHlsSEd4bXYwS2ZJbWZ6ZGpZ?=
 =?utf-8?B?MGxtb25ublhPSzlWUEc5NWY4Z0VKNHhFNGR1VXZXM3Nubk04RGZLZXdvNy9r?=
 =?utf-8?B?NVlFTmNONFFZdExsbE1jbVRLZXNaQ2tHc3ZQQnU5QzE0eUtmMGhNa2ZBd0hS?=
 =?utf-8?B?VjNLTkZHRi9ZSFJ1YXNZRkJtWGtlMnJldWFsS25oWFRkZGdqaWlvUU16TzVT?=
 =?utf-8?B?emhVRHlQQnZCMWgyS3B2aUx0cjlvdGozdVpHbnNuV2hkNWMwY2ZKYVAwQzJ3?=
 =?utf-8?B?OThNQXVjMUgxS09uYWRsWlhGZG9GOEQ2YTdxNDNKTEE1UU9DTEtwaHJadzMv?=
 =?utf-8?B?WVZwYTQ4UUc1UkZ4c3l4TVZHK01Jd2hJTkZscEltT1U5SzJJdTVQUzhPKzh6?=
 =?utf-8?B?bTJtd1ZnclZSSUdUYVJiblM2WEY1anpGMVJKbE5qOE96VEtqLzdwMkZTMHIx?=
 =?utf-8?B?ZmYxWHUzVk9ranMzYm1iVUNyOGZraERJejkrTVdxWGNaMHJGVUNucURQcS81?=
 =?utf-8?B?eWR1eVg4c2xKcWpJOWlHM1JHVnRnbUxJemc3RDZjQzdVeDV2NzVqSFZwaWZm?=
 =?utf-8?B?dzB4UFRnV3FqSXMrSEFOTmVKNUc3QlFKVDFhYXl2WGhGL2ZJQ1NvdnZ3dG4x?=
 =?utf-8?B?cVh1S2R1UEFNZitTQXE4OGltMDVRYXBneVNJOWM0U0xvNEpiOGlFSE1WVGZS?=
 =?utf-8?B?QjdIV1BSS3ROZW5YdndQc2Z2Umx0M0gyc0lBRWZBSEd4c2ROVzF6M0pCQXZN?=
 =?utf-8?B?NlRpTm9MUlNUd0pMWmRyWUpMR2NCeXF2SHZpcjhYanIyWU05SFc2a3ZSQnhr?=
 =?utf-8?B?Z0ZzZFAwSEMyR09hYmlQa1A0ckxNdnJBL04vU0dpYjlWMVExUXQ3d1hOc01m?=
 =?utf-8?B?NXZ5bzM2L2ZGb1ZXclNrc2VDbkxHVWlSeW9aaEJaVHBxNjZNSFFGakZ5MWVt?=
 =?utf-8?B?bFducDlINWtXbVVYSTg2djNKOWZOaTh6R01idDVCRXR2U3p4am9wdjJxRWJ5?=
 =?utf-8?B?UDhUYTNROTRxRVo5YW52S0RMTktDV3JTYTdkUmM4aEY5Um85b1kxM3hXYzI4?=
 =?utf-8?B?QnkyU2x0TWQ2TDZoWlpoUkJINUdWMitBM25FMkhHdno3d2tyTVVyelphU3gy?=
 =?utf-8?B?N2ZRcFBlOURjaGNMeEErN3Q1RHhtUm9lNitrUUFGYkJhTnZZa3paVE95YnFq?=
 =?utf-8?B?blFVYVdhS3lRaktubDBSM2VsL1cvQUQxZ21jaGVaSDNpRjhCV1MyZ1F5Q3Fi?=
 =?utf-8?B?ZlVZOWZLalJIRXpmanFLVnFqcTVVSjNYRTdqK1BncTliKzNlM2s3WkV6T0F2?=
 =?utf-8?B?RFdadmNjZ04rRm96SG5Razh6bExldG5GNm5UajNla0xYVUNCcTE0Rmp3RHNi?=
 =?utf-8?B?eXI2UkdXTTlDKys0QnJUcTNiL0JObTVvcVBPMml5YzJLUDZjb3o2Q1JrN0pD?=
 =?utf-8?B?SHFxREs4NlQrMnNiYjZlaTlydXpWLzQwK2NqMi9MNysxK1JDMFlMY0RxSCtn?=
 =?utf-8?Q?w/poave4rC8Ifm2ggXjQmuTT6hmiXk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1ZKU2VjSm9WbFNLWG5pM0piVWx4c3FSSTdpL0M0QXRaUUVwT0JaVGVaUTYx?=
 =?utf-8?B?Y2lMaDdSUTQxa1U0VDQweGkwWE1aNU56YzI1M3llUFRCMjZZUnNWMkNEM1p4?=
 =?utf-8?B?TFBhczhwZDNqNTZOV09kcnE0eHVVYUc2MCtNNnFrQmQxdHhGbE1GQ1NOK2Vl?=
 =?utf-8?B?RFZFemtGV3E4OVF3NGdTUlNCMXR4T3VqVHRyRkhZK2k4OERxQ3REUE85b1Ny?=
 =?utf-8?B?OTl0c0xObzF6SXI1WGNwc3kvWW5IZDF4QU5NelJ5ZjRLLzdGL3BGUC9KTERp?=
 =?utf-8?B?dmhTaitZTElTRUVmSFJ1RE13R0dzSWFyZFNxTWZwU09lUWsrMm9nUmQrZDhw?=
 =?utf-8?B?S1pSZkw5MjltWHV1Vzk0ZmZiRXJBbFpCQU94L3ArUi9weEh1bTNXWEdCV0tK?=
 =?utf-8?B?cS9KcjZPa0tsaE05OEZoOVZuSEprU1BsOEJJakdvMWczeEV4alE4ODhCWXBR?=
 =?utf-8?B?V2l4NUJkU3dlV2kxNU14V3lZMUlPdmxHOUh5aG5TM0trS0dBTFJKOG0rS3M2?=
 =?utf-8?B?bFdPRmE2OTRJUWdHKzJTVVpyV1lESUdvK0grN3BQSEF1MjE4YXJ6NmN6YUxP?=
 =?utf-8?B?RHc2aFU5Z1Qzd3UwRW5PNm9LRWVHRkF4TW5Ea3NDdE1GSHZhYlJZWDhsSlNY?=
 =?utf-8?B?N1N6QzJBZDVNNExLNmFFT3FXcWxZcFZ4TUhFL1pSV1hSbDd1R1p1RG5ETWxF?=
 =?utf-8?B?N0FyYlNZZ1FLdjVKaUJ3ZndmZkozUXE5bkdWRWdDd1cxNzJ6NWhFK3ZjZXRL?=
 =?utf-8?B?MEhJT3RSNkU4Mk1wdUg0T2E0RXkyVllHRGYra05HQkxsa1A1QUUzOExTZ2dX?=
 =?utf-8?B?VmRHQXh1a1M0U3VYZ3d6WnVuN01xUHVQZUdxUkNNMWxFODNXUnFSRlJRTGVL?=
 =?utf-8?B?Vk41bVVOUDQzUldSbnFYdXFsQ0pVbkRTUEw4RHJ0eGRsSkJydk5ycDdwYVNn?=
 =?utf-8?B?UWExb1RhaXpaNDgycFJiVmZabTRQY25kWXFpRy9nd1cwLzRiaEdwRGowU1FY?=
 =?utf-8?B?SlhmcHZ5YlRuWkRHOHA5ZUlGRVZIWm4yU29hakNEUTZnTkF6dS9jcm1wcmc4?=
 =?utf-8?B?cUZCcWtiRkhsRkJudjFtV0huT2lUNC9ZVTJzQVZINkVtRlp1Q3dvUVR4NFE3?=
 =?utf-8?B?TVFMbWd6YTVMclJNMkRCczgwVGRESld3NUR1dVdybE1hRG5HSXF5Szg0d1Ar?=
 =?utf-8?B?TFdRYlJtSWZvU1ZvTm1EaXJDOWdoS2hLVnpDYWpLc2dSL1ZnTkhONG9oeTZB?=
 =?utf-8?B?N1R3QlRRTDdxUUNlNFJ6VE5kQ3loSjVwMDlCalYyTUJvenJwQ0RwVFJ0RkRO?=
 =?utf-8?B?cGhkdjdHdzBmRzZzK0lOM1d5R0Q4cEdZWHVwUWthTXQ5Nm9JTXpXM29vWUVK?=
 =?utf-8?B?UC9HazhMQ09xaUIvM0NJZGZNWGRKbU00VnFaT3M2SE5hVHAzNkNBaEZGYzhk?=
 =?utf-8?B?TXRoemJvVWVPWTMrNlBFVEhjaHVSM3prOTVwZFJFc2pNL3Z5U1BuN0lSbklG?=
 =?utf-8?B?N2FvREtORE5zK3R4MXVBOVBWNEdzekxuai93Q1R3d0p3OTFpTzFkcGVtKytD?=
 =?utf-8?B?eC8wMnJUakFUY2ZRa2RkOGNzR3pJMkRLVXMvaVF6ZjdaT09PbWZDY3UwNG8y?=
 =?utf-8?B?a3VXZ2MrczVnejFmOWJHZTFmZ0Q4b1VLSUc2ay9qbUhsRXU4T05aZEtnOWVk?=
 =?utf-8?B?K1krUkpaY0hObmFhaSs0bWc3ekNZdHhBTzFZdUo5ejZ0MmQ0RGhXNFVwN2J0?=
 =?utf-8?B?YS9OR1dNQXNoU3lVTDgweDFFZzlmSUkvaU9HL2E1eUdsK0t1MGNGODcrNWNu?=
 =?utf-8?B?TE5hUjZsT01qY3pGdVFaRTRrd1dDWVRzVXJ0YVY3WkVFWnJSVStRQ1JtYzFI?=
 =?utf-8?B?enNzRlEyWmkyUmRGU3c1dzhveWl1TlVDV3E5UVp1T0hFTC9TM0NoM3o1N3RG?=
 =?utf-8?B?OXRHWnQ1K29lTHpnWGVmbnhLUUNTOE1hcGpBdS8xeXlXQm5BZFhFZVI4dUdP?=
 =?utf-8?B?ZlZWZmUybzdhdDBLM0IwMm9COWVkM3JsLzViZFZVdnZReHJlOUtkcDdwSkpk?=
 =?utf-8?B?bWZvT1RYenN5ME5NME92TXIwNHFaNzBqUVBjTXRFZWtLSnJ3R0FjREplTWxY?=
 =?utf-8?Q?EULi06GoXjZme4D0NJf3uCkVV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276effa5-ecb7-4a6e-f319-08dd96768625
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 01:43:15.7167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzxIWx8aYioTkLRMO6xIC/gBITtFwCCx/xGEY8OS0sSoCIHBZ7WUL+34Aov8mU2e/Z/nkpg2BeI53MMw1S087jeKDmW3FdFOKp14uL6B/go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5764
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgUGhpbGlwcGUsIA0KDQo+IFN1YmplY3Q6IFJlOiBbUFVMTCAzNC80Nl0gaHcvaW50Yy9hc3Bl
ZWQ6IEFkZCBTdXBwb3J0IGZvciBBU1QyNzAwIElOVENJTw0KPiBDb250cm9sbGVyDQo+IA0KPiBP
biA5LzMvMjUgMTQ6NTEsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+IEZyb206IEphbWlu
IExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4gSW50cm9kdWNlIGEgbmV3
IGFzdDI3MDAgSU5UQ0lPIGNsYXNzIHRvIHN1cHBvcnQgQVNUMjcwMCBJTlRDSU8uDQo+ID4gQWRk
ZWQgbmV3IHJlZ2lzdGVyIGRlZmluaXRpb25zIGZvciBJTlRDSU8sIGluY2x1ZGluZyBlbmFibGUg
YW5kIHN0YXR1cw0KPiA+IHJlZ2lzdGVycyBmb3IgSVJRcyBHSUNJTlQxOTIgdGhyb3VnaCBHSUNJ
TlQxOTcuDQo+ID4gQ3JlYXRlZCBhIGRlZGljYXRlZCBJUlEgYXJyYXkgZm9yIElOVENJTywgc3Vw
cG9ydGluZyBzaXggaW5wdXQgcGlucw0KPiA+IGFuZCBzaXggb3V0cHV0IHBpbnMsIGFsaWduaW5n
IHdpdGggdGhlIG5ld2x5IGRlZmluZWQgcmVnaXN0ZXJzLg0KPiA+IEltcGxlbWVudGVkICJhc3Bl
ZWRfaW50Y2lvX3JlYWQiIGFuZCAiYXNwZWVkX2ludGNpb193cml0ZSIgdG8gaGFuZGxlDQo+ID4g
SU5UQ0lPLXNwZWNpZmljIHJlZ2lzdGVyIGFjY2Vzcy4NCj4gDQo+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4gTGluazoNCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwMzA3MDM1OTQ1LjM2OTg4MDItMTgt
amFtaW5fbGluDQo+ID4gQGFzcGVlZHRlY2guY29tDQo+ID4gU2lnbmVkLW9mZi1ieTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9p
bnRjL2FzcGVlZF9pbnRjLmggfCAgIDEgKw0KPiA+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAg
ICAgICAgfCAxMTINCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAxMTMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gDQo+ID4gK3N0YXRpYyB1
aW50NjRfdCBhc3BlZWRfaW50Y2lvX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzaXpl
KSB7DQo+ID4gKyAgICBBc3BlZWRJTlRDU3RhdGUgKnMgPSBBU1BFRURfSU5UQyhvcGFxdWUpOw0K
PiA+ICsgICAgY29uc3QgY2hhciAqbmFtZSA9IG9iamVjdF9nZXRfdHlwZW5hbWUoT0JKRUNUKHMp
KTsNCj4gPiArICAgIHVpbnQzMl90IHJlZyA9IG9mZnNldCA+PiAyOw0KPiA+ICsgICAgdWludDMy
X3QgdmFsdWUgPSAwOw0KPiA+ICsNCj4gPiArICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOw0KPiA+
ICsgICAgdHJhY2VfYXNwZWVkX2ludGNfcmVhZChuYW1lLCBvZmZzZXQsIHNpemUsIHZhbHVlKTsN
Cj4gPiArDQo+ID4gKyAgICByZXR1cm4gdmFsdWU7DQo+ID4gK30NCj4gDQo+ID4gK3N0YXRpYyBj
b25zdCBNZW1vcnlSZWdpb25PcHMgYXNwZWVkX2ludGNpb19vcHMgPSB7DQo+ID4gKyAgICAucmVh
ZCA9IGFzcGVlZF9pbnRjaW9fcmVhZCwNCj4gPiArICAgIC53cml0ZSA9IGFzcGVlZF9pbnRjaW9f
d3JpdGUsDQo+ID4gKyAgICAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLA0KPiA+
ICsgICAgLnZhbGlkID0gew0KPiA+ICsgICAgICAgIC5taW5fYWNjZXNzX3NpemUgPSA0LA0KPiA+
ICsgICAgICAgIC5tYXhfYWNjZXNzX3NpemUgPSA0LA0KPiA+ICsgICAgfQ0KPiANCj4gQ291bGQg
YmUgc2FmZXIgdG8gYWxzbyBhZGQgLmltcGwubWluX2FjY2Vzc19zaXplID0gNC4NCj4gDQpUaGFu
a3MgZm9yIHRoZSBzdWdnZXN0aW9uLg0KV2lsbCBkbw0KSmFtaW4NCj4gPiArfTsNCg==

