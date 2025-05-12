Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558A9C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPzm-0003yA-H0; Mon, 12 May 2025 06:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uEPyO-0002ks-6k; Mon, 12 May 2025 06:01:29 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uEPxm-0001Sk-KF; Mon, 12 May 2025 06:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIMLo3q7w53xTeLvrLjj+zzMnruZeZ3slvJYrjAlT/PqKeu7o7+NF0xFYRVSd6j2oBoaANyAroM3Tus0/oKXhAbrWxRE6Fw+a758IDrjJ9PAD/uwhyujrGvulHCgElaI89Th11Ugiz9gA/CzWrUx4G/5Jm6LTGCf2lxlJok7qGKTveKR70O2WQS3/8t0mzyukKyLSTPCgmSKGcupyqGMfS58/NN1dnjPXDiW0RaoD1z6H4wq/fMAeUgxaWNmcgIy+Av7YBZjAe4im6mjAn4OULfQ5Rg0Yp1tgla/Aj9VK1a7HhjDuXXXino2irrL4QScUQpnzgk0m1XPcH6qjxm88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ6C8ahAMt0CFpcwuGsC5v4zIunorndkUCB7Fm8hbKk=;
 b=TEApacUAspPTjMjJMQlAn+aQYv/vV39TYJU9mQCkHNIq7GXA39aKOgzEabmNarFGKGpjYbyHLaHwd6vLvej/xyHaE8W5inRbJikU/rZDhHXq6cHSGl65dVykYwT2SCkeJ9DRA4LU8vxTcK2PjQOYEnsyLHURn8JBFUKrXhiRWTjhRks1iFWIdcU35u99EmC+K6xFIdH+BzG0nWr+3EGLclxefpIFY7f6kLVKXQCbzGRTLp90JJG4x2iFVSg+WYQfjeF8lBhau+CvOZbg+ZhW9cesWgOCpCRa3OrHQ7ICI1oKGi/5XmpdRgWQTfJ0EG4r6KRsQKuJbQxLeFaT3YSMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ6C8ahAMt0CFpcwuGsC5v4zIunorndkUCB7Fm8hbKk=;
 b=pNhtTlNqAmtmKm/A79As+eHvmLMjjto9c9VhrxeGXQFbKI70zlHvFuosvsJ1c8ZHVw1OfoHBpfHhYUdhE6TxULuutpJqr8+wpmx6wLWlebA3kiL6F7Fk5CnJzCOhuDdDLPXUnVYNilplm+/HD3iS3EectlZE9hISSJuSVN+C010f+Z5Wb6pd0JucMQQmcWOzxcOuyWmpcFGR64zZQD7FHI8+BqmTnoZA8cBJ8twNXN7oKbNUZHoCdnw1AY2jAlQpwrntQEw2dSeIripONB6rMp3av3+Vv+1L72s4JusQ1JYmmfearDwAwmlIxlf8VZWldjsajyc+5TOuS2FYlLG8Ug==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by TYSPR06MB6972.apcprd06.prod.outlook.com
 (2603:1096:400:46a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 10:00:36 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:00:35 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 1/3] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Topic: [PATCH v1 1/3] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Index: AQHbvzg4PRqV4ofMIE6wJpv/ULm1mrPOq8WAgAAaYvA=
Date: Mon, 12 May 2025 10:00:35 +0000
Message-ID: <KL1PR0601MB418025E901276E34F27B4D168597A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250507101005.1474823-1-steven_lee@aspeedtech.com>
 <20250507101005.1474823-2-steven_lee@aspeedtech.com>
 <cfb3ec2f-b9f0-4016-892c-bcdad95f548e@kaod.org>
In-Reply-To: <cfb3ec2f-b9f0-4016-892c-bcdad95f548e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|TYSPR06MB6972:EE_
x-ms-office365-filtering-correlation-id: 39b48f92-013e-42f2-e65e-08dd913bd759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bzM5SVBQK2lnQ2prSTRoeDlIdkFtMmxpRm1Kd2Z3ZFRxYzBZdmgxQVl2aWN3?=
 =?utf-8?B?V3UzU2YxOEwwRGZGOVV0SVRPVlErODUrUkgwQmx3ZlN4U1hINXJNS2NmRzFC?=
 =?utf-8?B?L2k4N0c4UDZ3ZWFuaW5GNjZ3emVuTFRaTmVYU0RsVTBaOW1WbG5aSHNKSDZo?=
 =?utf-8?B?aStSUGc2eVl1QTgrTHpyWFRDbWF6UFNLY0ljRmhEMWVGa2tJaFAvSERYMlBP?=
 =?utf-8?B?cmllUm1kdDFVMEI1UThZTEJTd2M5WXFnRGNmQittOVZIUWZtODBYbWRsbkxs?=
 =?utf-8?B?Zk5NdHhxZ0p3cDh3V2NBb0RRVmNLTG9MVHByb0VJRXBpYzNYR3pkVGt2SEpJ?=
 =?utf-8?B?d0FHVng0Rmt4enlvOHJjWnhIMDg4OUsvd09yRXo3TGlmaGg1L2JINTR3K3Ns?=
 =?utf-8?B?RVMyWmllRlBhdTFoL2JpQmhlc0dqNFhHYTY3b3lMTFlvQVJUWEt2eUdrcjY1?=
 =?utf-8?B?KzB5ekllVkFrS29qYVpZVzQycENSckxLZCtXRUYyRnMwakpubWpUa2tQYkdh?=
 =?utf-8?B?WDQ0R3dEaFlpUHFDditPb2pDaWpKWFdscFlwclpra1I5azJoNVl3WlJ5dHp4?=
 =?utf-8?B?SzJiVEw4OTJtanlNekRsVEplWlpIRjJldGlJdExrNXdSeUhUZ09XVVFzU1BF?=
 =?utf-8?B?dnQ5MVIreUczTWVmMTMrbDJsN3VhcnpUU09RTmdtS1ZQUGMrNGkrZEhQT2JR?=
 =?utf-8?B?NUVUcWFiODBnaEthemxqVDhWTHI4ajA4V0thTHBxNm4rb1NDZlJRaENjTGhE?=
 =?utf-8?B?KzN3L3hONWdJeTQ4ZXpjYlIyUVVsT1Z6UW9EME9NMUNYWVJwNW51V3dudGpB?=
 =?utf-8?B?WG4rMWNzT0FqSGRxZjgyZnFVUkorbGxWbkI3V1BqamZqZldIN3BwRW1JVjRo?=
 =?utf-8?B?OVAwVXJuOGk2T1p0bVkzZUZPOTVDTGoyb3lvV3BjUjMwL1YweEJCZGd3QUhD?=
 =?utf-8?B?UVUvQXg3V2xyRjFWdHdwMjJPNlhnV29mZkFWaXRGNHFWWGYyQm9PdDltRTZ5?=
 =?utf-8?B?ZHByUVYyclRrUjJOSVRBUG5XN3M0L0E3U0Y5MnZ2TjdSbkNhR3lzMXJwcVpP?=
 =?utf-8?B?L1dEZGlpaWtrS1BJZHVWR0F3enlGOE9jUWhhaW1hZWx2Nmg0dnJsMmJQL3hG?=
 =?utf-8?B?eW9Ia1ZuWUNXL3gyc2J3WktWdXptTVFXR0hRSDNteGY1YnRQNFE5bjNNbTNR?=
 =?utf-8?B?N2ZIOWVCMVlVb3JTdlVlVGpoWk5UQThlVTFjU2lpYkV0N1FRZVd0QW9MRHpi?=
 =?utf-8?B?L1JJcXJSdFpXWncycHE1dDN2ankvR2VOeXZqZERjcDlIblExbVRJSVFQVkRW?=
 =?utf-8?B?VWlBUERBdEJaMkI5SDZ5bzhYV0ZqZmh4RXJNQm9QNFRzWUNkc0dGbTUzNGNM?=
 =?utf-8?B?ZmFOdEJlcWpTTWJabmdFT0w0VHVHWTNZc2N5bHdpZlBETG45am85ZmR1Q2Q2?=
 =?utf-8?B?V2dqZ2Zmeml1SVgvd0FTTjVuUU9KT01iSTBnUUtqeSt3d0xmWlNmMm9hL212?=
 =?utf-8?B?NENvczhwcXprTFp6RERqWmMxbWIzQ0xhT3NsdXlQR29ESnRtV20xWHlCSkdW?=
 =?utf-8?B?R2dIQTVNZVFQUmdwaXFEeGcyeDZ4NThOMlJtY0VlMnFiWGdFSXdobUxFQUJE?=
 =?utf-8?B?S1I3SCsrMzg3NE4xUm5CSkk2bzVlTVVWb1lqbURrMHI5WFhVZytUUHo5WFhH?=
 =?utf-8?B?bkROUVo0Yi9mbDBqcHhRMzFvY2lhVDFXY2FMbmVqSWlqeUlHaUUySE9VU1N6?=
 =?utf-8?B?bEpJUTJObjd0bisySHdhNlVYZ2ZwSjVWdzZ0T0R4ZVBXREJCeG52Y09EZnFE?=
 =?utf-8?B?WlkrQkpsZ0YrMFdTNWlhR0dSV0hEWnhVY3poOTQwMFljSzlBQm5KMEl3R2tC?=
 =?utf-8?B?V2ZHNzRiRzNQR0VlR1E4Mnc2UENuZ0JXZHFQN3JTMGhUZnJHSWF1TE52aGww?=
 =?utf-8?B?elczZ3BLVFhsYy85QmYvMzR0Q2hUcmp1SElIQUFOZFVGbHp6bC9iaVV5YUMw?=
 =?utf-8?Q?VdaQZB6lpvMP7XK8UP0Ih4dc/vOEzY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFJR3RseCt5bW5kRmRObDdpVWRlblVDam9MSHp1dmhJK2FxanVhdkNEekgr?=
 =?utf-8?B?SWp4WC9ZR1FJOTdyTldKV25VY0I0QXJlYm5udFhQbFVpc2M2RFo2TDY2WEVW?=
 =?utf-8?B?eTY0UzVGQ21qdnRUOWg0TVM4ZXBnQkJ5ZTJab3NXd1NjOFliMGsrNkFjRzJI?=
 =?utf-8?B?N3plSVdJaHNhd1ZNMVlDeEVKMGlOanlTN1Irb2l6WjdrN0pLOU5NbnNvZkRs?=
 =?utf-8?B?THdiZWNRZ01OeE9VSjRGcEhoaFpvVGRPc3RFVXI1QmxQamFPU3o1NVNWRWpl?=
 =?utf-8?B?MXVkUU5PSTJ3OFUvbUxjTGIweFFsbjk3djBycVFabFIwd0E1Wmh2di9OWHBo?=
 =?utf-8?B?SG5XYk4xQmtmMjdhdmpsRUFxaG9NNXUrczRydlN6MDQwRk8xWXVmMjYvb2xQ?=
 =?utf-8?B?eWlNbzB3RWpLWTdKMUNRYnJkZkhUQk5Xcm9yaGxCcjZXVDBmR0dMd0gzM25U?=
 =?utf-8?B?TVBjYmhQRUVuTXIvVWFxbGRxQUxzUndkNjJUUm8vMFBzVDQ5b08xMHg5U3Fm?=
 =?utf-8?B?ZmdJWmNjSjFWV1ZHU3ltTlkwMkk0RENXTmxBSTJFTHdsQjFkZElyczZsRTR1?=
 =?utf-8?B?MmVTUHhkamZnY0orUk91SjF1M3oxcE9rT1Rxcm45M3JWRSt6VzZ0TGREbmZ5?=
 =?utf-8?B?TXRpSEpNQXZWdmlZR2w2bzQyOUFsOGFaQmRJTUVYMDlUSWpKa254b1E1SElG?=
 =?utf-8?B?cmRLbC9CSWlCbnRkcmFueHZBcFVyUXAzMWpCSzFVMUM4c1dma3VNdHI4YUt4?=
 =?utf-8?B?UzNxYW1BMnZOU0pwRFhYTzA1dGJJK1NKRWpCRE5rRnFVaWZHMWlNczE3NzNV?=
 =?utf-8?B?YXMrTDd0ZEY4czkxR0RrVlhBYUNpQ3JtM3RwOXVuWENldkNuVmtwbWRGalJR?=
 =?utf-8?B?Zm80TGlOUGFSN1RoeTBtZ2lCZmh3OGdtS0ZxZmF0TjZ2VklyK0VwS1J2UEpn?=
 =?utf-8?B?UWlwMXBRMy83THFuMjZLNVBDQVNQNXY4UGFjdnZrWEswWEpJZm9YdjJjamwx?=
 =?utf-8?B?WEJOMXVsVWV0cTZNZWFsRXRra2g2dmswNXRUbHZ5OUtpQ29NR2lXRjJOczcv?=
 =?utf-8?B?R3k1M3RFVjlJVDdUQVFFdTkxNEdjVGQyc29ZZExDaHJ2bks1alZMQXBhdTJt?=
 =?utf-8?B?bFdiYkVGL1lsSmIxMThnZ2UrNnFFejZKdnNxaXhoR3psZGJPWERhQ0pvMWVI?=
 =?utf-8?B?MlowNW92ME1OZk12Mm13S1pwcUt5UVZXRUZPaUY5Zm9PMDYwb2dsTDFuVk5u?=
 =?utf-8?B?ejM3NVVuZDRmeE1wRDJXZWU1dDhVeFlNN0Z1Y015emhvTDVrci83V3h2bUxY?=
 =?utf-8?B?VXdocnFBeUloTUxURWZVbXY4dU8rR2RSN21JSjF2eHQ3L2w2dXdKakhXbmMx?=
 =?utf-8?B?ZStzbHpINnpDcTMxRUFqUTNnSGNCV01EOUpKTXB1c2pNUThpM3RvVSt4YXpQ?=
 =?utf-8?B?NTczaG1aOHNQOVVVbVJ1ZmgvdlNIbzRDRTJlTHluMi80ZnRRU3R3RERXaG12?=
 =?utf-8?B?dEVtblA0Z1RXWS9Pa2ZLdEZ5dHcvQXl5WXdodi8weXhZYndWOGFwbVEwQWhu?=
 =?utf-8?B?OHM5ZGg0ejY0UmRoam50T2hxYmxocWpYWHNJR2c1czdFcm9EZllEd1JGSHlD?=
 =?utf-8?B?cCtrM1pESzZaaVNYcE81c3lvRWF0ajUvUHUyVE90UitwclhGNzNTOVg3SjBV?=
 =?utf-8?B?UlhUcmZzYXkwc1RtcDJ1WlJFdi9HdngyNEcybzdQVlNQakxKd0s2cnRtdHc1?=
 =?utf-8?B?UzAweFBNTjRkcHBjRWs4ZEo3a1d0MFBTTmY2QXA2ZWNCc2NqQUlEaG4rNktx?=
 =?utf-8?B?b1JFTnhtOS94dG1wYmR1djlvVEVWWEZVcnJPZ2pTUnpveG81aFo4eFNjcURD?=
 =?utf-8?B?UHExVit2N3l2QXkrL2oyVTVVLzdtU040OXlJR3JrWlh3bUhmSmtSTmpmZm9x?=
 =?utf-8?B?WVRuRWR3RUQ1a1NyRDlBZkJyV3ZKaTVoclBqV2VUekQzZUVFUkE2WDk0TktS?=
 =?utf-8?B?dCs3WU9hRVZBRkpuVGJtRzl6bG5UQWZFRnp3dWxGckk0Q09nWkVOUVFVZ3Zp?=
 =?utf-8?B?SERQejNGNUJyTzVYT0prZHdiQm9vOThETHpIbXFsaDcwd25KZ1U5QXF3U0FF?=
 =?utf-8?Q?38xHtGAw9mX1yQuHqd6jxXoUE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b48f92-013e-42f2-e65e-08dd913bd759
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 10:00:35.8409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JBIHsetgF1ut1JQTSjtA1qlA47br710GI5dr8/CXSzwId8aiP77yFkLLFj47stwdvWyKH/kcNLa5cNjHBLT28XcrE0XwoHN+5MREN2m0PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6972
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=steven_lee@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIE1heSAxMiwgMjAy
NSA0OjA5IFBNDQo+IFRvOiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUgPGxl
ZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBT
dGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1h
cm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+
OyBsb25nemwyQGxlbm92by5jb207IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0
ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzNdIGh3L2FybS9hc3BlZWRfYXN0
MjcwMC1mYzogRml4IG51bGwgcG9pbnRlcg0KPiBkZXJlZmVyZW5jZSBpbiBjYTM1IGluaXQNCj4g
DQo+IE9uIDUvNy8yNSAxMjoxMCwgU3RldmVuIExlZSB3cm90ZToNCj4gPiBDbGFuZydzIHNhbml0
aXplciByZXBvcnRzIGEgcnVudGltZSBlcnJvciB3aGVuIGJvb3Rpbmcgd2l0aCAnLW5ldCBuaWMN
Cj4gPiAtbmV0IHVzZXInLCBkdWUgdG8gYSBudWxsIHBvaW50ZXIgYmVpbmcgcGFzc2VkIHRvDQo+
ID4gbWVtb3J5X3JlZ2lvbl9maW5kKCksIHdoaWNoIHN1YnNlcXVlbnRseSB0cmlnZ2VycyBhIGNy
YXNoIGluDQo+ID4gZmxhdHZpZXdfbG9va3VwKCkuDQo+ID4NCj4gPiBUaGUgcm9vdCBjYXVzZSBp
cyB0aGF0IENBMzUgbWVtb3J5IHJlZ2lvbiBpcyBub3QgbWFwcGVkIHRvIHN5c3RlbQ0KPiA+IG1l
bW9yeS4gSW4gYWRkaXRpb24sIHVuY29uZmlndXJlZCBOSUNzIChkdWUgdG8gbWlzc2luZyBwZWVy
cykgbGVhZCB0bw0KPiA+IGEgY2FzY2FkZSBvZiB3YXJuaW5ncyBhbmQgcG9zc2libHkgbWlzYmVo
YXZpb3IuDQo+ID4NCj4gPiBGaXggYnk6DQo+ID4gLSBSZWR1Y2UgY2EzNSByYW0gc2l6ZSB0byAx
R2lCIHRvIG1hdGNoIHRoZSBhc3QyNzAwYTEtZXZiLg0KPiA+IC0gTWFwIGNhMzVfbWVtb3J5IGlu
dG8gc3lzdGVtIG1lbW9yeQ0KPiA+IC0gQWRkIG5pYyBjb25maWd1cmF0aW9uIGluIGFzdDI3MDBm
YydzIGNhMzUgaW5pdCBmdW5jdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlbiBM
ZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJZDljMGU2ZjE2
ODYxYzY0YTExZjYyOTlhZmI2ZWYwMmViNDA4NjA0MQ0KPiANCj4gQXMgc2FpZCBlYXJsaWVyLCBw
bGVhc2UgdHJ5IHRvIHJlbW92ZSB0aGVzZSB0YWdzLg0KPiANCg0KV2lsbCByZW1vdmUgaXQuDQoN
Cj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jIHwgMTYgKysrKysrKysr
KysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMg
Yi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+IGluZGV4IDEyNWEzYWRlNDAuLmNjYmE1
ZmM4YTEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiAr
KysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+IEBAIC00OCw3ICs0OCw3IEBAIHN0
cnVjdCBBc3QyNzAwRkNTdGF0ZSB7DQo+ID4gICAgICAgYm9vbCBtbWlvX2V4ZWM7DQo+ID4gICB9
Ow0KPiA+DQo+ID4gLSNkZWZpbmUgQVNUMjcwMEZDX0JNQ19SQU1fU0laRSAoMiAqIEdpQikNCj4g
PiArI2RlZmluZSBBU1QyNzAwRkNfQk1DX1JBTV9TSVpFICgxICogR2lCKQ0KPiANCj4gd2h5ID8N
Cj4gDQoNCkkgbm90aWNlZCB0aGF0IHRoZSBhc3QyNzAwLWExIGNsYXNzIHNldHMgdGhlIFJBTSBz
aXplIHRvIDHigK9HaUIuDQpUbyBwcmV2ZW50IGNhMzUtZHJhbSBmcm9tIGV4Y2VlZGluZyB0aGUg
Ym91bmRzIG9mIHRoZSByYW0tY29udGFpbmVyLCBJIHJlZHVjZWQgdGhlIFJBTSBzaXplIGFjY29y
ZGluZ2x5Lg0KDQogIDAwMDAwMDA0MDAwMDAwMDAtMDAwMDAwMDQzZmZmZmZmZiAocHJpbyAwLCBp
L28pOiByYW0tY29udGFpbmVyDQogICAgMDAwMDAwMDQwMDAwMDAwMC0wMDAwMDAwNDNmZmZmZmZm
IChwcmlvIDAsIHJhbSk6IGNhMzUtZHJhbQ0KDQo+ID4gICAjZGVmaW5lIEFTVDI3MDBGQ19DTTRf
RFJBTV9TSVpFICgzMiAqIE1pQikNCj4gPg0KPiA+ICAgI2RlZmluZSBBU1QyNzAwRkNfSFdfU1RS
QVAxIDB4MDAwMDAwQzAgQEAgLTU5LDYgKzU5LDcgQEAgc3RydWN0DQo+ID4gQXN0MjcwMEZDU3Rh
dGUgew0KPiA+ICAgc3RhdGljIHZvaWQgYXN0MjcwMGZjX2NhMzVfaW5pdChNYWNoaW5lU3RhdGUg
Km1hY2hpbmUpDQo+ID4gICB7DQo+ID4gICAgICAgQXN0MjcwMEZDU3RhdGUgKnMgPSBBU1QyNzAw
QTFGQyhtYWNoaW5lKTsNCj4gPiArICAgIEFzcGVlZE1hY2hpbmVDbGFzcyAqYW1jID0NCj4gQVNQ
RUVEX01BQ0hJTkVfR0VUX0NMQVNTKG1hY2hpbmUpOw0KPiA+ICAgICAgIEFzcGVlZFNvQ1N0YXRl
ICpzb2M7DQo+ID4gICAgICAgQXNwZWVkU29DQ2xhc3MgKnNjOw0KPiA+DQo+ID4gQEAgLTY4LDYg
KzY5LDcgQEAgc3RhdGljIHZvaWQgYXN0MjcwMGZjX2NhMzVfaW5pdChNYWNoaW5lU3RhdGUNCj4g
PiAqbWFjaGluZSkNCj4gPg0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25faW5pdCgmcy0+Y2EzNV9t
ZW1vcnksIE9CSkVDVCgmcy0+Y2EzNSksDQo+ICJjYTM1LW1lbW9yeSIsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgIFVJTlQ2NF9NQVgpOw0KPiA+ICsgICAgbWVtb3J5X3JlZ2lvbl9hZGRf
c3VicmVnaW9uKGdldF9zeXN0ZW1fbWVtb3J5KCksIDAsDQo+ID4gKyAmcy0+Y2EzNV9tZW1vcnkp
Ow0KPiANCj4gSSB0aGluayB0aGlzIGJlbG9uZ3MgdG8gYW5vdGhlciBwYXRjaC4gUGxlYXNlIGFs
c28gbW9kaWZ5IHRoZSBmYnkzNSBtYWNoaW5lDQo+IHdoaWNoIHN1ZmZlcnMgZnJvbSB0aGUgc2Ft
ZSBwcm9ibGVtIHJlZ2FyZGluZyB0aGUgZ2xvYmFsIHN5c3RlbSBtZW1vcnkNCj4gdXNhZ2UuDQo+
IA0KDQpJIHdpbGwgc3BsaXQgdGhpcyBpbnRvIGEgc2VwYXJhdGUgcGF0Y2gsIGFuZCBwcmVwYXJl
IGFub3RoZXIgcGF0Y2ggdG8gdXBkYXRlIHRoZSBmYnkzNSBtYWNoaW5lIGFzIHdlbGwuDQoNClRo
YW5rcywNClN0ZXZlbg0KDQo+IA0KPiA+ICAgICAgIGlmICghbWVtb3J5X3JlZ2lvbl9pbml0X3Jh
bSgmcy0+Y2EzNV9kcmFtLCBPQkpFQ1QoJnMtPmNhMzUpLA0KPiAiY2EzNS1kcmFtIiwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVNUMjcwMEZDX0JNQ19SQU1fU0laRSwN
Cj4gPiAmZXJyb3JfYWJvcnQpKSB7IEBAIC04Niw2ICs4OCwxNCBAQCBzdGF0aWMgdm9pZA0KPiBh
c3QyNzAwZmNfY2EzNV9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEFTVDI3MDBGQ19CTUNfUkFNX1NJWkUsDQo+ICZlcnJv
cl9hYm9ydCkpIHsNCj4gPiAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgIH0NCj4gPiArDQo+
ID4gKyAgICBmb3IgKGludCBpID0gMDsgaSA8IHNjLT5tYWNzX251bTsgaSsrKSB7DQo+ID4gKyAg
ICAgICAgaWYgKChhbWMtPm1hY3NfbWFzayAmICgxIDw8IGkpKSAmJg0KPiA+ICsgICAgICAgICAg
ICAhcWVtdV9jb25maWd1cmVfbmljX2RldmljZShERVZJQ0UoJnNvYy0+ZnRnbWFjMTAwW2ldKSwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgTlVMTCkp
IHsNCj4gPiArICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0K
PiA+ICAgICAgIGlmICghb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5jYTM1KSwg
Imh3LXN0cmFwMSIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBU1Qy
NzAwRkNfSFdfU1RSQVAxLA0KPiAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gICAgICAgICAgIHJldHVy
bjsNCj4gPiBAQCAtMTcxLDYgKzE4MSw3IEBAIHN0YXRpYyB2b2lkIGFzdDI3MDBmY19pbml0KE1h
Y2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4gPiAgIHN0YXRpYyB2b2lkIGFzdDI3MDBmY19jbGFzc19p
bml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgIHsNCj4gPiAgICAg
ICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7DQo+ID4gKyAgICBBc3BlZWRN
YWNoaW5lQ2xhc3MgKmFtYyA9IEFTUEVFRF9NQUNISU5FX0NMQVNTKG9jKTsNCj4gPg0KPiA+ICAg
ICAgIG1jLT5hbGlhcyA9ICJhc3QyNzAwZmMiOw0KPiA+ICAgICAgIG1jLT5kZXNjID0gImFzdDI3
MDAgZnVsbCBjb3JlIHN1cHBvcnQiOyBAQCAtMTc4LDEyICsxODksMTMgQEANCj4gPiBzdGF0aWMg
dm9pZCBhc3QyNzAwZmNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRh
dGEpDQo+ID4gICAgICAgbWMtPm5vX2Zsb3BweSA9IDE7DQo+ID4gICAgICAgbWMtPm5vX2Nkcm9t
ID0gMTsNCj4gPiAgICAgICBtYy0+bWluX2NwdXMgPSBtYy0+bWF4X2NwdXMgPSBtYy0+ZGVmYXVs
dF9jcHVzID0gNjsNCj4gPiArICAgIGFtYy0+bWFjc19tYXNrID0gQVNQRUVEX01BQzBfT04gfCBB
U1BFRURfTUFDMV9PTiB8DQo+ID4gKyBBU1BFRURfTUFDMl9PTjsNCj4gPiAgIH0NCj4gPg0KPiA+
ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzdDI3MDBmY190eXBlc1tdID0gew0KPiA+ICAgICAg
IHsNCj4gPiAgICAgICAgICAgLm5hbWUgICAgICAgICAgID0gTUFDSElORV9UWVBFX05BTUUoImFz
dDI3MDBmYyIpLA0KPiA+IC0gICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfTUFDSElORSwN
Cj4gPiArICAgICAgICAucGFyZW50ICAgICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0KPiA+
ICAgICAgICAgICAuY2xhc3NfaW5pdCAgICAgPSBhc3QyNzAwZmNfY2xhc3NfaW5pdCwNCj4gPiAg
ICAgICAgICAgLmluc3RhbmNlX3NpemUgID0gc2l6ZW9mKEFzdDI3MDBGQ1N0YXRlKSwNCj4gPiAg
ICAgICB9LA0KDQo=

