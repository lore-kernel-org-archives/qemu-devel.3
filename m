Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3075E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 02:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJO5L-0000nF-Lr; Thu, 05 Dec 2024 21:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tJO5J-0000mH-BP; Thu, 05 Dec 2024 21:28:49 -0500
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tJO5G-0007ku-8x; Thu, 05 Dec 2024 21:28:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLc+wJu83NVp0bA8a5R4sHf98/W9zp8/1LOF+urTvGPAkloeuCsDPl3J9wMTE6ZR4Ed8LJmg3vrbC/bZYoNsOcnVb3wCdegVjLni8CsXmo07jYt52niywJHdmRm1dDo5rqDkwkJOXTJPeztBUiZKVK+PaNhdX+5np6HkxGxTcD4BZFumBaDJ1POuUAGmx/du9BjnkeZKT2WlSePYHjyqhxEME2QYFMiv02F0oE6idew3iUSHfu6R6ggwGxuDThEa97nkbAxCMakKZWFP2qrIooq2hsaFB4lytG8UmdRYD03OYaUEt97dcwGwaSVR2EKxJXx3NlwgfBA2czbYRoYotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYo7JZ9gj5kD/kOV3nJDCkSLK/hwEeOXpWGFMdYEohY=;
 b=xIxb75cUTrBwGVEiVXof7yxaZ1DI8NxESj5DHyaKdQGqzWhbbiDYk41dLA48muDnFsMzKM43dAlgg3uSYWMacjo4URz13pdLMxutrxBFHt3GxjtxpQ+SQPB32Ds8WQ1dnipYMx9sJBFe7rWFG2bYzzNrmyp4gqa8i0aPkyxAcFFORiQCKzHunaYtE5rjzldEJNoKRGy9HSfM+h/W15Y/fQLk4kkpOQO5IxLpw+Rx9wnudA6WwLsoMAUIceU7B+hJQ48ppRT0WyU50P0lR05pP54w0y7c1KTy7GZulc07WsHQ7SQTZCJLiGABEzaIi2m7kkr6U7rjNXutTtmmWwapBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYo7JZ9gj5kD/kOV3nJDCkSLK/hwEeOXpWGFMdYEohY=;
 b=amCx+/FNG8DcoFhMC7iaJviVInjNy/V0YQtClmCoIl7e+hRSLdUKPuA9YusTGi3NkRxk3ggd9aMa+PSvVzJirI7nu28x/4dCEJJPiSAaFr8k70qu0MBkPuNYLff3kFnPQefkW5CHBxgXYSkEzIQY9v2S4IoaO2m2933+TjSBM6G9Kjlc7qFGenN2r4+r+FWi6NemuuuojcjI4tXaIlJZaI2VN3czpHAxlvafHHGkzFzhiU29F3y/tMjVo8sVXUbc/xYkRm8Ld2XEWUwKKLe42eNuvvKA7EnGb0WytZAsCUrQCbiDrajDNlWGzUdZBm8xDHGl4ReQjDwoo7D7pvT6sA==
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by KL1PR06MB6820.apcprd06.prod.outlook.com (2603:1096:820:10c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Fri, 6 Dec
 2024 02:28:33 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%3]) with mapi id 15.20.8251.008; Fri, 6 Dec 2024
 02:28:33 +0000
From: andrew Yuan <andrew.yuan@jaguarmicro.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGh3L25ldDogY2FkZW5jZV9nZW06IGZlYXQ6IGFk?=
 =?utf-8?B?ZCBsb2dpYyBmb3IgdGhlIERJU0FCTEVfTUFTSyBiaXQgaW4gdHlwZTJfY29t?=
 =?utf-8?B?cGFyZV94X3dvcmRfMQ==?=
Thread-Topic: [PATCH] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
Thread-Index: AQHbOa/QiNhY8wt940Krqqk61d+xg7LYRwOAgABO4/A=
Date: Fri, 6 Dec 2024 02:28:33 +0000
Message-ID: <KL1PR0601MB4891B1891714A767E183513CE3312@KL1PR0601MB4891.apcprd06.prod.outlook.com>
References: <20241118114806.1119-1-andrew.yuan@jaguarmicro.com>
 <7a9f495b-7aea-4b7b-8bd5-e1e7db34b6be@linaro.org>
In-Reply-To: <7a9f495b-7aea-4b7b-8bd5-e1e7db34b6be@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4891:EE_|KL1PR06MB6820:EE_
x-ms-office365-filtering-correlation-id: 79993ee0-f6d2-4a10-2f74-08dd159dae27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZWhwWFBpcW5Ca0VvU2NCbkNMWlkzYjdWK05NUGs5REwrRmpxMzBoZVluWkd6?=
 =?utf-8?B?cFE5UWF1d1JCY3NCZmxicFV0RExqblVNNHVrSVlNL0JtK2FMbmgycC8yU3da?=
 =?utf-8?B?WVFCcVBwK1EvaXRpOEN2blNid1Mzb3k0V2tDZE5NR243UDBodGtlVDhOVnFY?=
 =?utf-8?B?dFJxNVJNWlA2VzlkNUxhR213QUxpSFgyckYzWEFFMGp1UUc2RXdTUHE2VUdZ?=
 =?utf-8?B?SGg3VWdud1NvUU45dFFJa2cxQTFyRDJiMVpzTnRiVEVLYlZDY2JnUWFKdlcy?=
 =?utf-8?B?KzFqblduQ2FlamI2Ly9vb0EyQ0J3bWIxa0RZcHk0ZEVjanI0b3hTNGFhSUVs?=
 =?utf-8?B?c3ZGbURZbkpyZzc1eFVCRzFvUytRc0RKY25KMmlJWmZqWEhoUnhtY3NveHNK?=
 =?utf-8?B?cDhiaFVsd25ocHNwVm0veVVVUFl0cnlhYVlLSEtPL21lMnVjaVVGV05VTFJ0?=
 =?utf-8?B?RHV5VFFnelVqU0Zib2JWWFZoMmI4Zzl2cU9xWGdibVBTOHBWM0dDdkYrMnJI?=
 =?utf-8?B?aWNUZnE2d3ViQUNhUHFKS2pYSEk2SGhMRWtuUU0xdXhlNnFzWVZQaXcwSWxw?=
 =?utf-8?B?a2xEVzZNQ0JzLzJRcGtJYTF1bXhWN2txRmpKM0c4amlxM29OS1lFN1pqZC9l?=
 =?utf-8?B?K2pUdFJnaTJFNUNWTEFXNlJyUnd2NTJwM3FuUEdmcTJ2bVN1OHFzNnNUK1Jm?=
 =?utf-8?B?NVc5VytjVkJkQkJPRGE0bkQ5K2xRclBwU0RPSm4yKzE1STFLanRNa0Q4cnZW?=
 =?utf-8?B?S3U3WkRqYTRvSHBrYlNlYTBkUXZsaExFYTlqWUtkN1V3S05IZGVhWG1jaHlq?=
 =?utf-8?B?d0IzTzU0UW9iYVNyZ09lMnE4V1BJYVNHN2RsLzdOMVkzQUR3bnc4cm9tb3Zk?=
 =?utf-8?B?bXhJTVVHWlEwcUJXVGxHbmlUaHlZRGRSWjVIMHJJWVpTQ3JrYUdCOGVkb2Rx?=
 =?utf-8?B?b1ZIay8yc2JyMG1uV2YwbGRtY2c5WWV3UCtvU0t0cGtQU3p3UkFDVWlScEty?=
 =?utf-8?B?SjV2enNtK2JPSVdWMHJHbWc3MzlZcDg5eDRVVDFKNHhXWFR2MjJENE14U3di?=
 =?utf-8?B?VW5pbllXd2puRVNKcURHRmJVeXIzRXBZYVR2dHBFWVR3K0RLUHpFTm5ScmtP?=
 =?utf-8?B?VWdqc3pXTlJpWWl4RkZWaWJNUVF2WGpUU2pYV0dlVFFLdXlsdElnczJFQmpE?=
 =?utf-8?B?M24xVEU4S1V6NDNzdGhvU1NkeElvN0p5bDRQV3A5RWxKb3hkMmd2aWVZc2R1?=
 =?utf-8?B?K2lMVytuZE9oU0ZGUitnTDQyK050dFJOaVNEdFNPTFlVTXk5OWxRUFAzS0NR?=
 =?utf-8?B?QlcyWVp2QkhiSWI3MXpiMHpMa0NlVmRGWnE5dUFCQjBiNGN4cmcySk9EbU5a?=
 =?utf-8?B?U2V1NHowNjNnWVloLzVOSXJYWlFadzJMT2xzZGpCRXJQclNtNTNJWHF6Wmxx?=
 =?utf-8?B?TzM3c01peUY5NmNzTW9tQVZWU2E4b2VCSEZKbU9MZXgyT00zbjV0OFdaZ1hs?=
 =?utf-8?B?M1Rod0VNU3dVMVZoeWhiUWZXb2JmMWhwKy9INkZvVXBDNnBHNWVBZSsxZEpM?=
 =?utf-8?B?V3N6VEN1WnIwdk94TG9vSHFBRlc0dlREdWcvSlpFM0JNR0xRc2tHZVVsb1BE?=
 =?utf-8?B?TmVnL1hFUzIzQlZzMU9XenQzeVQydkVZb1dPT0w0WUN3UkNVb1AwTWF6SVJH?=
 =?utf-8?B?TmVKOFNQdXBDOGVLMjY1amJIbVZ2Y3FpZXM4VlNpT1ZHSGRwNUVPRVVTcjFa?=
 =?utf-8?B?YWhUekFLdnN0QmlHT3RDV2FuOXYxS0hheFhpK3k1d09MR0xrK2JDQUZWRVBn?=
 =?utf-8?B?dnVydjB1bGxkQ2JsOW1SSEVOM3FIQjJiUlcxVjIzV2hGQ08rREFIVXNSTThC?=
 =?utf-8?B?OW5iRW1DS0JyajNIbWpWWlFEVzhVYnJhVU5qaVFtdjVWU0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzN0c2gvQld0NkRrR1EzRXRWZkVMb0p6VmhkYUtyU3JCeVFkejdsZXJxNTBo?=
 =?utf-8?B?eHV4bUVNcXdSZ2tpSTc5UXpUcXpscHEzVWxVNzhQTTZlRkZyMjc0R2FvTm9h?=
 =?utf-8?B?L04xNUdyOGZyTkkySldYYVNjWmJ1c0ZMdjAvbmtzV0JxVmx4azdqNEhnVjhu?=
 =?utf-8?B?MjBoanhaVDNQRlAzM240RlpPOXB3bkR1UGY0NUwrdnlrNjg3TGhZVVNxUGto?=
 =?utf-8?B?NjBVSDF2N0g5UWtzYTRTZFVyZHV5cFBnMFNOM0NobjVoRkJERkRpa1c4Nm1C?=
 =?utf-8?B?LzExWlhPdVBUbFA0OTIwTndFY0tFTitrWDVSTzZkRTcyQmJIVk42bTZabFJ5?=
 =?utf-8?B?UWQ1RitJeVRuMEZBUE5NdkJnMEVVMVNKc3JoUHJnVnRacWVzOTBjUkFBbTlm?=
 =?utf-8?B?QTZNRkpFQ1NlaG91ZlJuVVJqYlJkNVFJN3lJY3N3eEtNc3d3emtsa1UvOTd2?=
 =?utf-8?B?RmxncDFFTkxRT2JyVzM2ZExUWk1WMkgxS2kvcERVUEtXOW84elJuR3QzaTlU?=
 =?utf-8?B?cy8xUU9tQ1o2OWhZRDRjUmVFdDhOSTgxRW9JZ0h5dGExYUJDUjhFd1lyUlMy?=
 =?utf-8?B?dDBkMDJXamo3VHlnZFpIbjF5b25iUks5eVJUSTdaSjhNR2VRUml4VjRlL255?=
 =?utf-8?B?ZkZVNDhvUjljTC9MbmlZMFN3REdabEVTa09BTDFCSTgxUUdiUDZqZlQ3SFhF?=
 =?utf-8?B?eHNyQlVZWUFwLzlta1lFaXJUT1gybkVJTG02dlFaajBMSjZ6ejJhY3FvbzBo?=
 =?utf-8?B?cDJjMmdkQzNuWUJDVm9IYmZZWGZWbFJSVmNrMW5PdWF6ajgxK2FFcUZNNTkr?=
 =?utf-8?B?ZXp3VEhmcEk2VEt5WWloQi9rckc3eWVFMWVoK1AzSVl4KzdIYktaenErME53?=
 =?utf-8?B?ZXVqWGtIVGpqWjV4cldtclNOdUhSSFVOeEN0RlVwZjFGTDJjQ3pPODdibGZw?=
 =?utf-8?B?djVxNlFOSnpTb0orbWhZQk5lWFZaZ0M4RlE4alpqc01OUjAwRjhRSFZDN3lI?=
 =?utf-8?B?U20rV050Sk81a2xibkNlZ2UyY3Azb2tUbTAyeExTdXo4em5RcDhWZElTK2FI?=
 =?utf-8?B?azdaVnAyUEllRzA0VVFjOFdaVjBobDN6R1VDN1d1bk5nZXlNOERuWWVaWHhj?=
 =?utf-8?B?RGQ3NlF4UzFvMWVlYk5jbDBObi9PalNqQXByc2V1amx4Vi80czE3ZDN6UVZv?=
 =?utf-8?B?SitwOTUrMDBTRklnUnY5ajJiYkUwN2JYNDhzZnB0dFI5TE4ycWoxYzZabDF1?=
 =?utf-8?B?MUI5OS8yRzM0Q040WjFyYlpNVitlUVVYR3ZESXo2cFZ2OG1aZlNPYkRNbWVI?=
 =?utf-8?B?RE53aHdkS00zM2JLVGV0SnJkSzBBUEpaOVdWeVlSQUFKZTlzMTZmMEpMSFNP?=
 =?utf-8?B?cDFtQktaMUF3aitTYzJHa0ZQQStzZ2JjR282MERSa3VPWDlVU0ZqUVdsQlhi?=
 =?utf-8?B?WW9PaHFxdnhYckVxanRTaEd6a0ZrOUl3Uk1jZWhWbjkrUlBOTlBCWGFUbmFx?=
 =?utf-8?B?VHViTWpNdzlyYTlMR0k4MU9NbUVmZHE4WEpEcmxsMnVJeC9Ia0NpTDM4ZWUv?=
 =?utf-8?B?WVBwQkxkblcvZVFKTklJeCtiVTdPNXBWLy9KaEpuamNqVU4ySzhUYzBuSXVi?=
 =?utf-8?B?NUxJLzlwM2N2Nlh2QitGbHYzOW1LMVE0VEJON2NHL2NZbVd2bnBld3BqbDRP?=
 =?utf-8?B?WUk5N2NybVVJL3Y0ZnZZb1lqQW11UWNCL0lBTHJTYm94b0JiczBHZWprVm14?=
 =?utf-8?B?Tzl5VzhPRW43dzZTc21ncnd4Y21Mc0pyUVQ4emZqN1JoNWhVZTd0ZmJqMjBh?=
 =?utf-8?B?YzM5OU1jM053YTVOdDA0T2MvNkk3TEx6T1FMVkd5WEgzU0c2Z21sUTNvYVlt?=
 =?utf-8?B?TE1ET09LZDRHcGpGNVpQTXJ1WVFPODdDbmdDNHJrSEdXYjBDcjZybkc3dWdH?=
 =?utf-8?B?N3ZMWXNwTnBHZ1E3eEtMVkdldlBia09KcWpzc0tEZ3RZWjJPcWpNV3lEYURZ?=
 =?utf-8?B?SVBKL0pTRFdmUWo4NDVmZ2loS1VxSlhRU2xndkQvR1Z0OExIa3RiM1FGd3Np?=
 =?utf-8?B?R3VGam9ycFZMMzV5bzV4QnB6T1Y2U0NoSWRRbUlMTUgyZkE5ZWFBYnMrY1U5?=
 =?utf-8?Q?eV4sYIny7NgDf7umOJQI6XPVB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79993ee0-f6d2-4a10-2f74-08dd159dae27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 02:28:33.2187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LuIuNEDfPGH/oIQDs8VQR9nQIRi8l4rw7rcybczJWBbdGs6Z7eAGzQNuTiZ8eZZ4JIhq0EcOIUkI4OMdMzTbUXfp9Fs84dkGjEJTecRWtLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6820
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

VGhhbmtzLCBQaGlsaXBwZSwNCg0KbGR1d19iZV9wKCkgcmV0dXJuIGEgQmlnLUVuZGlhbiB2YWx1
ZSwNCkJ1dCwgYXMgdGhlIHJlZ2lzdGVyIGRlc2NyaXB0aW9uLCANCnRoZSBieXRlIHN0b3JlZCBp
biBiaXRzIFsyMzoxNl0gaXMgY29tcGFyZWQgYWdhaW5zdCB0aGUgYnl0ZSBpbiB0aGUgcmVjZWl2
ZWQgZnJhbWUgZnJvbSB0aGUgc2VsZWN0ZWQgb2Zmc2V0KzAgYW5kIA0KdGhlIGJ5dGUgc3RvcmVk
IGluIGJpdHMgWzMxOjI0XSBpcyBjb21wYXJlZCBhZ2FpbnN0IHRoZSBieXRlIGluIHRoZSByZWNl
aXZlZCBmcmFtZSBmcm9tIHRoZSBzZWxlY3RlZCBvZmZzZXQrMS4NClNvLCBsZHV3X2xlX3AoKSBp
cyBhcHByb3ByaWF0ZS4NCg0KSSB3aWxsIHJlc2VuZCBhIHBhdGNoIC4NCg0KVGhhbmtzIGZvciB5
b3VyIHRpbWUuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPiANCuWPkemAgeaXtumXtDogMjAyNOW5
tDEy5pyINuaXpSA1OjMzDQrmlLbku7bkuro6IGFuZHJldyBZdWFuIDxhbmRyZXcueXVhbkBqYWd1
YXJtaWNyby5jb20+OyBlZGdhci5pZ2xlc2lhc0BnbWFpbC5jb207IGFsaXN0YWlyQGFsaXN0YWly
MjMubWU7IGphc293YW5nQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQrkuLvpopg6IFJlOiBbUEFU
Q0hdIGh3L25ldDogY2FkZW5jZV9nZW06IGZlYXQ6IGFkZCBsb2dpYyBmb3IgdGhlIERJU0FCTEVf
TUFTSyBiaXQgaW4gdHlwZTJfY29tcGFyZV94X3dvcmRfMQ0KDQpFeHRlcm5hbCBNYWlsOiBUaGlz
IGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBPVVRTSURFIG9mIHRoZSBvcmdhbml6YXRpb24hDQpEbyBu
b3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRp
b24gdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBp
cyBzYWZlLg0KDQoNCkhpIEFuZHJldywNCg0KT24gMTgvMTEvMjQgMTI6NDgsIEFuZHJldy5ZdWFu
IHdyb3RlOg0KPiBGcm9tOiBBbmRyZXcgWXVhbiA8YW5kcmV3Lnl1YW5AamFndWFybWljcm8uY29t
Pg0KPg0KPiBBcyBpbiB0aGUgQ2FkZW5jZSBJUCBmb3IgR2lnYWJpdCBFdGhlcm5ldCBNQUMgUGFy
dCBOdW1iZXI6IElQNzAxNCBJUCANCj4gUmV2OiBSMXAxMiAtIERvYyBSZXY6IDEuMyBVc2VyIEd1
aWRlLCBpZiB0aGUgRElTQUJMRV9NQVNLIGJpdCBpbiANCj4gdHlwZTJfY29tcGFyZV94X3dvcmRf
MSBpcyBzZXQsIG1hc2tfdmFsdWUgaW4gdHlwZTJfY29tcGFyZV94X3dvcmRfMCBpcyANCj4gdXNl
ZCBhcyBhbiBhZGRpdGlvbmFsIDIgYnl0ZSBDb21wYXJlIFZhbHVlDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZHJldyBZdWFuIDxhbmRyZXcueXVhbkBqYWd1YXJtaWNyby5jb20+DQo+IC0tLQ0KPiAg
IGh3L25ldC9jYWRlbmNlX2dlbS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvaHcvbmV0L2NhZGVuY2VfZ2VtLmMgYi9ody9uZXQvY2FkZW5jZV9nZW0uYyBp
bmRleCANCj4gNTI2NzM5ODg3Yy4uN2VjNWRiYWE5YyAxMDA2NDQNCj4gLS0tIGEvaHcvbmV0L2Nh
ZGVuY2VfZ2VtLmMNCj4gKysrIGIvaHcvbmV0L2NhZGVuY2VfZ2VtLmMNCj4gQEAgLTkwOSw4ICs5
MDksOCBAQCBzdGF0aWMgaW50IGdldF9xdWV1ZV9mcm9tX3NjcmVlbihDYWRlbmNlR0VNU3RhdGUg
DQo+ICpzLCB1aW50OF90ICpyeGJ1Zl9wdHIsDQo+DQo+ICAgICAgICAgICAvKiBDb21wYXJlIEEs
IEIsIEMgKi8NCj4gICAgICAgICAgIGZvciAoaiA9IDA7IGogPCAzOyBqKyspIHsNCj4gLSAgICAg
ICAgICAgIHVpbnQzMl90IGNyMCwgY3IxLCBtYXNrLCBjb21wYXJlOw0KPiAtICAgICAgICAgICAg
dWludDE2X3QgcnhfY21wOw0KPiArICAgICAgICAgICAgdWludDMyX3QgY3IwLCBjcjEsIG1hc2ss
IGNvbXBhcmUsIGRpc2FibGVfbWFzazsNCj4gKyAgICAgICAgICAgIHVpbnQzMl90IHJ4X2NtcDsN
Cj4gICAgICAgICAgICAgICBpbnQgb2Zmc2V0Ow0KPiAgICAgICAgICAgICAgIGludCBjcl9pZHgg
PSBleHRyYWN0MzIocmVnLCBSX1NDUkVFTklOR19UWVBFMl9SRUcwX0NPTVBBUkVfQV9TSElGVCAr
IGogKiA2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IFJfU0NS
RUVOSU5HX1RZUEUyX1JFRzBfQ09NUEFSRV9BX0xFTkdUSCk7DQo+IEBAIC05NDYsOSArOTQ2LDI0
IEBAIHN0YXRpYyBpbnQgZ2V0X3F1ZXVlX2Zyb21fc2NyZWVuKENhZGVuY2VHRU1TdGF0ZSAqcywg
dWludDhfdCAqcnhidWZfcHRyLA0KPiAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAg
ICAgICAgICB9DQo+DQo+IC0gICAgICAgICAgICByeF9jbXAgPSByeGJ1Zl9wdHJbb2Zmc2V0XSA8
PCA4IHwgcnhidWZfcHRyW29mZnNldF07DQo+IC0gICAgICAgICAgICBtYXNrID0gRklFTERfRVgz
MihjcjAsIFRZUEUyX0NPTVBBUkVfMF9XT1JEXzAsIE1BU0tfVkFMVUUpOw0KPiAtICAgICAgICAg
ICAgY29tcGFyZSA9IEZJRUxEX0VYMzIoY3IwLCBUWVBFMl9DT01QQVJFXzBfV09SRF8wLCBDT01Q
QVJFX1ZBTFVFKTsNCj4gKyAgICAgICAgICAgIGRpc2FibGVfbWFzayA9DQo+ICsgICAgICAgICAg
ICAgICAgRklFTERfRVgzMihjcjEsIFRZUEUyX0NPTVBBUkVfMF9XT1JEXzEsIERJU0FCTEVfTUFT
Syk7DQo+ICsgICAgICAgICAgICBpZiAoZGlzYWJsZV9tYXNrKSB7DQo+ICsgICAgICAgICAgICAg
ICAgLyoNCj4gKyAgICAgICAgICAgICAgICAgKiBJZiBkaXNhYmxlX21hc2sgaXMgc2V0LA0KPiAr
ICAgICAgICAgICAgICAgICAqIG1hc2tfdmFsdWUgaXMgdXNlZCBhcyBhbiBhZGRpdGlvbmFsIDIg
Ynl0ZSBDb21wYXJlIFZhbHVlLg0KPiArICAgICAgICAgICAgICAgICAqIFRvIHNpbXBsZSwgc2V0
IG1hc2sgPSAweEZGRkZGRkZGLCBpZiBkaXNhYmxlX21ha3MgaXMgc2V0Lg0KDQpUeXBvICJkaXNh
YmxlX21hc2siLg0KDQo+ICsgICAgICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgICAg
cnhfY21wID0gcnhidWZfcHRyW29mZnNldCArIDNdIDw8IDggfCByeGJ1Zl9wdHJbb2Zmc2V0ICsg
Ml0gfFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICByeGJ1Zl9wdHJbb2Zmc2V0ICsgMV0g
PDwgOCB8IA0KPiArIHJ4YnVmX3B0cltvZmZzZXRdOw0KDQogICAgICAgICAgICAgICAgICAgIHJ4
X2NtcCA9IGxkbF9iZV9wKHJ4YnVmX3B0cltvZmZzZXRdKTsNCg0KPiArICAgICAgICAgICAgICAg
IG1hc2sgPSAweEZGRkZGRkZGOw0KPiArICAgICAgICAgICAgICAgIGNvbXBhcmUgPSBjcjA7DQo+
ICsgICAgICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgICAgIHJ4X2NtcCA9IHJ4YnVm
X3B0cltvZmZzZXQgKyAxXSA8PCA4IHwgDQo+ICsgcnhidWZfcHRyW29mZnNldF07DQoNCiAgICAg
ICAgICAgICAgICAgICAgcnhfY21wID0gbGR1d19iZV9wKHJ4YnVmX3B0cltvZmZzZXRdKTsNCg0K
PiArICAgICAgICAgICAgICAgIG1hc2sgPSBGSUVMRF9FWDMyKGNyMCwgVFlQRTJfQ09NUEFSRV8w
X1dPUkRfMCwgTUFTS19WQUxVRSk7DQo+ICsgICAgICAgICAgICAgICAgY29tcGFyZSA9DQo+ICsg
ICAgICAgICAgICAgICAgICAgIEZJRUxEX0VYMzIoY3IwLCBUWVBFMl9DT01QQVJFXzBfV09SRF8w
LCBDT01QQVJFX1ZBTFVFKTsNCj4gKyAgICAgICAgICAgIH0NCj4NCj4gICAgICAgICAgICAgICBp
ZiAoKHJ4X2NtcCAmIG1hc2spID09IChjb21wYXJlICYgbWFzaykpIHsNCj4gICAgICAgICAgICAg
ICAgICAgbWF0Y2hlZCA9IHRydWU7DQoNCg==

