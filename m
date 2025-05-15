Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF50C3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 03:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFPfT-0004j4-It; Wed, 14 May 2025 23:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uFPfQ-0004id-9i; Wed, 14 May 2025 23:53:56 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uFPfN-0004RP-Mv; Wed, 14 May 2025 23:53:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuhdNCnOoyWKhVqVwzokIlm09fUk6Apja45sJi5HOVN7KHCo6t2ZYOL2WHubWIDSktFTfsa8fMv7R/zKaRnoBWxaOttBc/57H+SzF6bT4AniPzDWjAsxWtbD2yCa9wKg218FL4CNwoi+qtdQ98VzNJqt0c69fkOA2ZZ9scI2ij2giwWdpoyE1BM0T7NZAM4sPXXNxgv9vPxfJDTP9ljMB+WlWQzu09KfwQGhcXzelDPxKcz0uu7cYtaJg5M56cnb0H1WceAGyogBpi65azHz6EtbWXPB71m9ek6pGTDET7Z66Oscvn2pe3u44+ub4I9XmHMEJYDA5XvXWmx5Oe18rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyfmVy2QkLch1uxXRD0t+v9ojsOMFt4zNur/85D2bHs=;
 b=Jq4ERA32pN54S3DTCwZwS8cWx5cTl/ZGqZvVFVKUmR1uQJo07RnHWbvGTv9/lN3KAPZJqrOq4ghOPGuva6G+1auhevnEXfFR6vm7XEW7Z0ylGai4gjGOYnOj5LPt+Yj9LHZkJbIfBN0iAVGQhf7G/8bD2NAwuPe5AMKvy+j59X45dwVffl2kHdLLfslqZb0JsZ56nCF2rC3HHdFognsuX8G0ue8xBF7t8ImAekk5zIhTFCakmcg6kjj6D6fCbGe+IOz/450UgCpA/zRhLjv95duTlmgibm9vNOd1krX/MgRPIOskGa3ayu6krVPgduEztegvy9PCnQYNk35VWgANwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyfmVy2QkLch1uxXRD0t+v9ojsOMFt4zNur/85D2bHs=;
 b=a20zZwkMUZHf8XlXPByJirdLQA15MQT4CL6An849AtzbhAHIYUIm8AD4oYtlgQuUbv7BVl0V/Tj66vI/xqTys29B3AeP5EjRLWqfvrmJ26YM6NsMzeq2VKiTo4bawjDBqMdKCtNx4uAEwcRzn7GsXMPl59/5mhlA3eMdW6HiZrCutTkQGFKE9nbjIL33E423OmQmBrD/TMqzIL7sZtZDgW5fxkV9e2TX4YM1LrFWGzJx+u8OFWwKFtRxBcf8fkq7ZmG5Se4W5XSvXDng7cu0soa8kyyneMeCwkJCGG8cZ/MySS+wHzSkZCHP4Fwv/cYXoql7b9427M2TuTgWZwWFmw==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB6911.apcprd06.prod.outlook.com
 (2603:1096:101:1e9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 03:53:42 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:53:42 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 1/5] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Topic: [PATCH v2 1/5] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Index: AQHbxK8hIxKExE9QvkaEht3mQUDXTrPSHomAgADxmhA=
Date: Thu, 15 May 2025 03:53:42 +0000
Message-ID: <KL1PR0601MB4180F85D8AE98848CD181EC08590A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250514090354.1461717-1-steven_lee@aspeedtech.com>
 <20250514090354.1461717-2-steven_lee@aspeedtech.com>
 <76676e3b-1b3a-48e7-9bd3-3017df35b31b@redhat.com>
In-Reply-To: <76676e3b-1b3a-48e7-9bd3-3017df35b31b@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB6911:EE_
x-ms-office365-filtering-correlation-id: 41fb7ccc-0e9e-49db-c0c9-08dd9364159b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEtEZjBNRlNIRjgwVlo1Q1ZZVFZWWlIzNVRLOElPaFI2QnBZcENKTW8yMS9z?=
 =?utf-8?B?cEcwRkVWL3Z0QTU2MjJsbnhSbktubDl4TElUZ0ZlRC9oakZjSDJ4WEI5dUtP?=
 =?utf-8?B?K0pyYmQ0OXN0L05IVXcyY1FTZk1WOVNjSitjTElXekQzSHNlRWxHY21BT0pa?=
 =?utf-8?B?cUFmOHRkcVR5UnBlaVB6ZGlONUVrV2JBRUszVmtHS0tTa0xIbHVKWTVvZVVp?=
 =?utf-8?B?N0VJbHlnUTdBQklFbU9YK3ltY0ljaUJnVFlUTWZrSGRxaUY0TXo0K3JRNXg0?=
 =?utf-8?B?Vm9iQzVTRlBpdXFWblpNTUlJeDB1b3VaaENoS2xGeE05RENpa3hWUHpEWGMz?=
 =?utf-8?B?bUdEVG9uYjNOODFMOVIvbWh3SVJCYmIvYmh3QURtalBLNmxYZEdmejFMOGZl?=
 =?utf-8?B?c1lIQzZzbmxrWEV2V2xLcko0ZDloUlF5U1RqY1VoQXhvRXpZOUJjWVdnQitY?=
 =?utf-8?B?eENiQVY1cGN0Nlc4R1gzRnJ2YzBDaTN2YVJpNXJJL0pJZlQwOUlzek1SdVJX?=
 =?utf-8?B?MVFUN3MvZlBNT2o0Ym53dnYvNXN6Y2U3bHNtdDBiRi9iWER3KzdIWmRzVXlF?=
 =?utf-8?B?WFMxdjh5MnFuK29DaXBnT2pNVHBGL1JoeVlkMHJXWWlLY0FBcDhubnR1S3JO?=
 =?utf-8?B?ZWhsNHpmVXV2RUl6aitmSGtQdWlQRHdRdkZLeCtTaVJuUUtOSTVlMU5GaUJV?=
 =?utf-8?B?YWd0dFdwSjNwUGo3US9DSVdIakxONTUrKzRJVDE3TFczbkcrLytQNW9LTjV3?=
 =?utf-8?B?cHhuRDdDajU5UGgzTU1yUEJaL05IbUhIb0J0YXdEZW5Qa1NvdCtoQ3k5UGt1?=
 =?utf-8?B?QmhwQkNmYU1VMTIzRjF0Q3k0QmpCcHVEcm5vT0JoajkzTmdocmY2QXFkR1B1?=
 =?utf-8?B?TWI5cDcyVFNRZThTWmJqTHpBdDFjTDVPQmZvcCtCNnBJbkxDVWI2UDIzQzgx?=
 =?utf-8?B?ZGVxNVlIY09KMnpudXd0UWFiN3FIRFdkMHZOK3pRNU5qSEFLZkFGZXFybVVI?=
 =?utf-8?B?TnJ0MUNGZ1prMnYvQUcrcWtYcnFkblkydHNRV24ySGY1T3ArdG90U1ZZMUZK?=
 =?utf-8?B?UnRTaDliNVBDV2MweE5rVE9CSHhLWkN3QlhEc0l1M1dTczNjY05NclNSeS93?=
 =?utf-8?B?aDhNbVhIT2pFNHRWRW05NExPR0Y1bTFnUXBiTUxOV1VJdXo1REZwOFY4Z080?=
 =?utf-8?B?ejh0bTBLQ2VlRDIxejNqeXVzRU1Ob01Xc1pRVERDMW5Xc0lFazFwbjJvbytM?=
 =?utf-8?B?QnVkY0NSRXRBMW9zVVo4ZXhTT1lzUVN0NkYrTCswNTNKTlVjdnNHWnpEODJU?=
 =?utf-8?B?OThrSDFSdGsxVk1nNm5wc1cveTJib1d4S0tDd1dwRGxZeXB3NDUwMXExZWRl?=
 =?utf-8?B?UlBHYzhaa296RUxqWUladUMyeE5JbEJTSlJKSitUdGgyWWZSVGpEeS85eWtR?=
 =?utf-8?B?UjVmNENxZ0dvUjhXZUVtVmpSenBiWm9YTExXU3lXYnY0SUhDSklSN3V1VXM2?=
 =?utf-8?B?czZESUYreEc4aGhXSVRmNUhVcXhJOHRGSHpuTHl1eFZDR2E1bHFscGlHYUpu?=
 =?utf-8?B?TS9TWFhCVldkYmVwdlJaSjkzZzJGRFp4V2dsVkdTOEl0d295WHV3ZzgxaFlw?=
 =?utf-8?B?dTkrZGV5UG1UcWVpbDZzMThpQTFuMitkalE0eGI2Nlk3UUVyREIwTktIbWVM?=
 =?utf-8?B?QmwwazEybzdST2Q4TlpkblBwZjFQcmZKYVZmTUZRb0I3c3c5Rkp4cTlGVi9Q?=
 =?utf-8?B?WXNXNGVqdFU5T2swcElSOGtDNFJHZVNGNVVuQTVES3BkaXJVZnVtSGlHaHRY?=
 =?utf-8?B?ek5TUW9FSkQzSm96eGFZZXhDbEZXbVVDUC9nTW94cC9sejZLR3c2MGdYamJJ?=
 =?utf-8?B?bDV1ZDQzdWs5Q0JIblo3UXhBRmR1a1hGeXhmZEMvcTN4R3lWVWJRRUszaEFB?=
 =?utf-8?B?TTcvTDFJTytNcTFCNGtEYUJnVVFmOFErNzJlRVMrdnNPa3BTSXRmUmhka2M4?=
 =?utf-8?Q?0IZWaq1sZb1hJd8CyQihmr+oHSoRTk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ky9NQ3RnNjdQeGxlU3dCZTA4dU9FU0VFVFNHMGhrMkZEb1BKSncyYlZ4VVhS?=
 =?utf-8?B?WHlYanFBdndCTGk3aEphSW5EWndMeWVyTWhmK3N5LzM0WnlJcStCdmVDTU5z?=
 =?utf-8?B?STUzVjYzb0V5Sit0ZVhrbCtrRkZNRlFING5IRHFlcnZIK0cyZGFqUVR3bStp?=
 =?utf-8?B?Q0g0bGtNb2VadGVBZitBaUJLRGdwQ3VvQUtsMzdTUWlmc0poOFFtakxvc04r?=
 =?utf-8?B?OHZhRVBRYUdSTWpPR1JmWWFBN0RKNTIzSFFnL0dtU3Z1SWhOb0ZNMWw4bmRK?=
 =?utf-8?B?akdwakM1Mno5ZlRBY0FhK1FOK0g1SlorWW1QQmh0ZFoxeFhxK2FwSkNVZldG?=
 =?utf-8?B?Kyt3K0sxZnZJamdERE9qY3dXMHdaQSt2aDBVcFpycCtqcjJINUZoVmllbDEz?=
 =?utf-8?B?TmoydTBXVDA2QkkzeVkvdUVCaU5sNkt1bGUyTEJPQmFjMDhCU245NXBucWQz?=
 =?utf-8?B?ZGozdGNidC9IQ0M2aVNianFWRmptK0tNbmdOd3MvWW9xMG9weFBwY3J2M1Vw?=
 =?utf-8?B?UXdBYnVXK3hLb2V3UjVycVhMbTQxVUsvd2Q2QWR1ZXkwUkxqS2Z3LzNlOXhS?=
 =?utf-8?B?TGtVc2U3NU9GN1VIc0VLeDRLeVJCL212akpLNzhPTW4yTlBCc05NcHY2eGZX?=
 =?utf-8?B?TlhMVVdzVDRpdjU3dEJ6YVJBWG5rdEJEaWdxZ0pGUTdKL3h5TWlqb1NDMlMy?=
 =?utf-8?B?MjQ5TWJxTkFaS0lXNWEvUWNJS05Db1B1cldONnAvV0g5Y1I0eVROL2dQWmlB?=
 =?utf-8?B?dGp0a2ZMSS9TenBYcHg5dGp4cWNHWm9pTFVXV3hyN0FscEFpZlR2Ynk3R2dS?=
 =?utf-8?B?VHBReDlxRHJQaGlTSkE2RlF1NW9yL3h0OFFTaTVIakpVay9QNjErQTJ2ajlE?=
 =?utf-8?B?VkxVb2VQc1Uva1ZwOXFvZmRydDZNQy8vT0JyY3lVQnpvTTdQMGtWMHlzeHlV?=
 =?utf-8?B?eThqMmhIUkxSTHdMZ3ExelVjbFNUbDNTVFlXVVNBS0NuK2x1bFkvenVNaGda?=
 =?utf-8?B?dGpBMkVlVzkrMHVNU0xHb2FIcERBdGt3WFJocEUwUUZQSCtZQjZJRjNHdzVK?=
 =?utf-8?B?MzIweGJVVTkySk5JeVo0QXNWRzkwZnFnd0J4TUFFcXppMnhWdExUMG5yRjBU?=
 =?utf-8?B?RTZldFcyMjVad056QWRZMUV5ak14b0RzK2lUMFF2WllmSGVHdXJyY2J1ZzZV?=
 =?utf-8?B?TVExSHpKaDc4WEgwc3lGYlk2NWZKMG8wS1ZBOVMwUmJDK3lYRndPRS93SHk1?=
 =?utf-8?B?c0wrT3BNcStTbUVCK0xSVjhyblBacGg1RFZFMFVHUVorbXAwY0ZXWEhmckdF?=
 =?utf-8?B?bi9wdDZESmZUQUNIZ2xEbGJxbTYzWU9ZZEJNZ0E4SGtDajIxSVQxa2JCWlZt?=
 =?utf-8?B?M3pjSlNGOHNTNkZBcG9iUmtmcjZ2QXhHeEV0a3VPYlB5SnJVQzVDNWkvczNz?=
 =?utf-8?B?cnNoUTVVRzMxMzBjYnZ4djhQMTFlYkxGeXhJd0pMQzZrVk1BZFRRR0NtZlpx?=
 =?utf-8?B?SUdTcHdpQm02WEJIYU04ZCtDcFJZY2NNNTRvN29kSml2Q2tWTVZpRVNFeTRp?=
 =?utf-8?B?eGNqZklLSUREemxDRUoyWmw2NlRVUU55MDlPbDA2cjlGVEp3cUVQQm54bDRh?=
 =?utf-8?B?bzdGUHdhRmhmd25RRTRYczlLNWdxckxmbzFFQTJPbXAzdTV0TWxycWVCenZr?=
 =?utf-8?B?elVjZDA2VGk3SGlxWVF6QjJzSUNDd09EZ0xGRkdxUnJoanVqTGY0emNST2ha?=
 =?utf-8?B?SkhoZDIxZ0VDaVp2ZXNHUVFZN2VmU3R4SXg2T2hQbjhVRnBnS1pPMS9zS04w?=
 =?utf-8?B?UEsxUjFoM09qRWpxZEw0Z1JhQjVmS1d3TFdzOHRaVGkxVGt3bmRlVkh2RTln?=
 =?utf-8?B?dlFRMThJUS92UW4yY1drb1plLzM1THdkbzdtUHpiZ1NqWG1aQTFCR0w1T0Z0?=
 =?utf-8?B?bTZaNVpsZGEzTVJRRVhPTGZleVRBNm1ueGNjVVNQTVVxczZiY3BtaGd0Yi9I?=
 =?utf-8?B?ckdjMC8wSTMvYXJ4SjZIYW1qSUg3M0VFUWcybVNIdEFjTFh2T0V4S1JkN1ha?=
 =?utf-8?B?UXlUUWIxT3VnOGZoVG4rYnA4anRERnRaaU9DTnpkTUpYK0NEMksxUi9UZ1Vq?=
 =?utf-8?Q?chtCiis9y4JqJEzzv+1PJ5RgA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fb7ccc-0e9e-49db-c0c9-08dd9364159b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 03:53:42.4984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BtVN2nwMjsyDROmklz7WycBk/ts8qS5qoa6lkoSa4lMDDpu/rFBYQ66zHr4VzAcF5bieZWoAPboYWxobB9QZKwr6EvnlhPgpEzafqdyE9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6911
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=steven_lee@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDE0
LCAyMDI1IDk6MjggUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFz
cGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNV0gaHcvYXJtL2FzcGVl
ZF9hc3QyNzAwLWZjOiBGaXggbnVsbCBwb2ludGVyDQo+IGRlcmVmZXJlbmNlIGluIGNhMzUgaW5p
dA0KPiANCj4gT24gNS8xNC8yNSAxMTowMywgU3RldmVuIExlZSB3cm90ZToNCj4gPiBDbGFuZydz
IHNhbml0aXplciByZXBvcnRzIGEgcnVudGltZSBlcnJvciB3aGVuIGJvb3Rpbmcgd2l0aCAnLW5l
dCBuaWMNCj4gPiAtbmV0IHVzZXInLCBkdWUgdG8gYSBudWxsIHBvaW50ZXIgYmVpbmcgcGFzc2Vk
IHRvDQo+ID4gbWVtb3J5X3JlZ2lvbl9maW5kKCksIHdoaWNoIHN1YnNlcXVlbnRseSB0cmlnZ2Vy
cyBhIGNyYXNoIGluDQo+ID4gZmxhdHZpZXdfbG9va3VwKCkuDQo+ID4NCj4gPiBSb290IGNhdXNl
Og0KPiA+IC0gTWlzc2luZyBOSUMgY29uZmlndXJhdGlvbiBpbiB0aGUgQ0EzNSBpbml0aWFsaXph
dGlvbi4NCj4gPg0KPiA+IEZpeDoNCj4gPiAtIFJlZHVjZSBjYTM1IHJhbSBzaXplIGZyb20gMkdp
QiB0byAxR2lCIHRvIGFsaWduIHdpdGggYXN0MjcwMGExLWV2YiwNCj4gPiAgICB3aGVyZSB0aGUg
cmFtLWNvbnRhaW5lciBpcyBkZWZpbmVkIGFzIDFHaUIgaW4gaXRzIGNsYXNzLg0KPiA+IC0gQWRk
IG5pYyBjb25maWd1cmF0aW9uIGluIGFzdDI3MDBmYydzIGNhMzUgaW5pdCBmdW5jdGlvbi4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyB8IDE1ICsrKysr
KysrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZj
LmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+IGluZGV4IDEyNWEzYWRlNDAuLmZm
NjQ2MDU2NjMgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4g
PiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+IEBAIC00OCw3ICs0OCw3IEBA
IHN0cnVjdCBBc3QyNzAwRkNTdGF0ZSB7DQo+ID4gICAgICAgYm9vbCBtbWlvX2V4ZWM7DQo+ID4g
ICB9Ow0KPiA+DQo+ID4gLSNkZWZpbmUgQVNUMjcwMEZDX0JNQ19SQU1fU0laRSAoMiAqIEdpQikN
Cj4gPiArI2RlZmluZSBBU1QyNzAwRkNfQk1DX1JBTV9TSVpFICgxICogR2lCKQ0KPiA+ICAgI2Rl
ZmluZSBBU1QyNzAwRkNfQ000X0RSQU1fU0laRSAoMzIgKiBNaUIpDQo+ID4NCj4gPiAgICNkZWZp
bmUgQVNUMjcwMEZDX0hXX1NUUkFQMSAweDAwMDAwMEMwIEBAIC01OSw2ICs1OSw3IEBAIHN0cnVj
dA0KPiA+IEFzdDI3MDBGQ1N0YXRlIHsNCj4gPiAgIHN0YXRpYyB2b2lkIGFzdDI3MDBmY19jYTM1
X2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQ0KPiA+ICAgew0KPiA+ICAgICAgIEFzdDI3MDBG
Q1N0YXRlICpzID0gQVNUMjcwMEExRkMobWFjaGluZSk7DQo+ID4gKyAgICBBc3BlZWRNYWNoaW5l
Q2xhc3MgKmFtYyA9DQo+IEFTUEVFRF9NQUNISU5FX0dFVF9DTEFTUyhtYWNoaW5lKTsNCj4gPiAg
ICAgICBBc3BlZWRTb0NTdGF0ZSAqc29jOw0KPiA+ICAgICAgIEFzcGVlZFNvQ0NsYXNzICpzYzsN
Cj4gPg0KPiA+IEBAIC04Niw2ICs4NywxNCBAQCBzdGF0aWMgdm9pZCBhc3QyNzAwZmNfY2EzNV9p
bml0KE1hY2hpbmVTdGF0ZQ0KPiAqbWFjaGluZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEFTVDI3MDBGQ19CTUNfUkFNX1NJWkUsDQo+ICZlcnJvcl9hYm9ydCkpIHsN
Cj4gPiAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICBmb3Ig
KGludCBpID0gMDsgaSA8IHNjLT5tYWNzX251bTsgaSsrKSB7DQo+ID4gKyAgICAgICAgaWYgKChh
bWMtPm1hY3NfbWFzayAmICgxIDw8IGkpKSAmJg0KPiA+ICsgICAgICAgICAgICAhcWVtdV9jb25m
aWd1cmVfbmljX2RldmljZShERVZJQ0UoJnNvYy0+ZnRnbWFjMTAwW2ldKSwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgTlVMTCkpIHsNCj4gPiArICAg
ICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICAgICAgIGlm
ICghb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5jYTM1KSwgImh3LXN0cmFwMSIs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBU1QyNzAwRkNfSFdfU1RS
QVAxLA0KPiAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gICAgICAgICAgIHJldHVybjsNCj4gPiBAQCAt
MTcxLDYgKzE4MCw3IEBAIHN0YXRpYyB2b2lkIGFzdDI3MDBmY19pbml0KE1hY2hpbmVTdGF0ZSAq
bWFjaGluZSkNCj4gPiAgIHN0YXRpYyB2b2lkIGFzdDI3MDBmY19jbGFzc19pbml0KE9iamVjdENs
YXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgIHsNCj4gPiAgICAgICBNYWNoaW5lQ2xh
c3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7DQo+ID4gKyAgICBBc3BlZWRNYWNoaW5lQ2xhc3Mg
KmFtYyA9IEFTUEVFRF9NQUNISU5FX0NMQVNTKG9jKTsNCj4gPg0KPiA+ICAgICAgIG1jLT5hbGlh
cyA9ICJhc3QyNzAwZmMiOw0KPiA+ICAgICAgIG1jLT5kZXNjID0gImFzdDI3MDAgZnVsbCBjb3Jl
IHN1cHBvcnQiOyBAQCAtMTc4LDEyICsxODgsMTMgQEANCj4gPiBzdGF0aWMgdm9pZCBhc3QyNzAw
ZmNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4gICAg
ICAgbWMtPm5vX2Zsb3BweSA9IDE7DQo+ID4gICAgICAgbWMtPm5vX2Nkcm9tID0gMTsNCj4gPiAg
ICAgICBtYy0+bWluX2NwdXMgPSBtYy0+bWF4X2NwdXMgPSBtYy0+ZGVmYXVsdF9jcHVzID0gNjsN
Cj4gPiArICAgIGFtYy0+bWFjc19tYXNrID0gQVNQRUVEX01BQzBfT04gfCBBU1BFRURfTUFDMV9P
TiB8DQo+ID4gKyBBU1BFRURfTUFDMl9PTjsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNv
bnN0IFR5cGVJbmZvIGFzdDI3MDBmY190eXBlc1tdID0gew0KPiA+ICAgICAgIHsNCj4gPiAgICAg
ICAgICAgLm5hbWUgICAgICAgICAgID0gTUFDSElORV9UWVBFX05BTUUoImFzdDI3MDBmYyIpLA0K
PiA+IC0gICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfTUFDSElORSwNCj4gPiArICAgICAg
ICAucGFyZW50ICAgICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0KPiA+ICAgICAgICAgICAu
Y2xhc3NfaW5pdCAgICAgPSBhc3QyNzAwZmNfY2xhc3NfaW5pdCwNCj4gPiAgICAgICAgICAgLmlu
c3RhbmNlX3NpemUgID0gc2l6ZW9mKEFzdDI3MDBGQ1N0YXRlKSwNCj4gPiAgICAgICB9LA0KPiAN
Cj4gVGhlICJhc3QyNzAwZmMiIG1hY2hpbmUgY2Fubm90IGluaGVyaXQgZnJvbSBUWVBFX0FTUEVF
RF9NQUNISU5FLg0KPiBUaGVzZSBhcmUgdHdvIGRpZmZlcmVudCB0eXBlIG9mIG1hY2hpbmVzLg0K
PiANCj4gQW4gImFzdDI3MDBmYyIgbWFjaGluZSBzdGF0ZSBpcyBkZXNjcmliZWQgYnkgOg0KPiAN
Cj4gICAgICBzdHJ1Y3QgQXN0MjcwMEZDU3RhdGUgew0KPiAgICAgICAgICBNYWNoaW5lU3RhdGUg
cGFyZW50X29iajsNCj4gDQo+ICAgICAgICAgIE1lbW9yeVJlZ2lvbiBjYTM1X21lbW9yeTsNCj4g
ICAgICAgICAgTWVtb3J5UmVnaW9uIGNhMzVfZHJhbTsNCj4gICAgICAgICAgTWVtb3J5UmVnaW9u
IHNzcF9tZW1vcnk7DQo+ICAgICAgICAgIE1lbW9yeVJlZ2lvbiB0c3BfbWVtb3J5Ow0KPiANCj4g
ICAgICAgICAgQ2xvY2sgKnNzcF9zeXNjbGs7DQo+ICAgICAgICAgIENsb2NrICp0c3Bfc3lzY2xr
Ow0KPiANCj4gICAgICAgICAgQXNwZWVkMjd4MFNvQ1N0YXRlIGNhMzU7DQo+ICAgICAgICAgIEFz
cGVlZDI3eDBTU1BTb0NTdGF0ZSBzc3A7DQo+ICAgICAgICAgIEFzcGVlZDI3eDBUU1BTb0NTdGF0
ZSB0c3A7DQo+IA0KPiAgICAgICAgICBib29sIG1taW9fZXhlYzsNCj4gICAgICB9Ow0KPiANCj4g
YW5kIGEgVFlQRV9BU1BFRURfTUFDSElORSBtYWNoaW5lIHN0YXRlIGlzIGRlc2NyaWJlZCBieSA6
DQo+IA0KPiAgICAgIHN0cnVjdCBBc3BlZWRNYWNoaW5lU3RhdGUgew0KPiAgICAgICAgICAvKiBQ
cml2YXRlICovDQo+ICAgICAgICAgIE1hY2hpbmVTdGF0ZSBwYXJlbnRfb2JqOw0KPiAgICAgICAg
ICAvKiBQdWJsaWMgKi8NCj4gDQo+ICAgICAgICAgIEFzcGVlZFNvQ1N0YXRlICpzb2M7DQo+ICAg
ICAgICAgIE1lbW9yeVJlZ2lvbiBib290X3JvbTsNCj4gICAgICAgICAgYm9vbCBtbWlvX2V4ZWM7
DQo+ICAgICAgICAgIHVpbnQzMl90IHVhcnRfY2hvc2VuOw0KPiAgICAgICAgICBjaGFyICpmbWNf
bW9kZWw7DQo+ICAgICAgICAgIGNoYXIgKnNwaV9tb2RlbDsNCj4gICAgICAgICAgdWludDMyX3Qg
aHdfc3RyYXAxOw0KPiAgICAgIH07DQo+IA0KPiBUaGVzZSBhcmUgbm90IGNvbXBhdGlibGUuDQo+
IA0KPiBZb3Ugd2lsbCBuZWVkIHRvIHJlZGVmaW5lIHRoZSBhdHRyaWJ1dGVzIChzdGF0ZSBhbmQg
Y2xhc3MpIHlvdSBuZWVkIGluIHRoZQ0KPiAiYXN0MjcwMGZjIiBtYWNoaW5lLg0KPiANCg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcuDQpXaWxsIGZpeCB0aGlzIGluIHRoZSBuZXh0IHBhdGNoIHNl
cmllcy4NCg0KUmVnYXJkcywNClN0ZXZlbg0K

