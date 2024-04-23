Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A74C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 05:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz8O2-0003aU-0j; Tue, 23 Apr 2024 01:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1rz8O0-0003ZU-Pg
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 01:08:08 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1rz8Ny-0005bS-PQ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 01:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713848885; x=1745384885;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Cn2OHg2aUxl0wuo1HMhj/v3O0HjDpaZDiGBJ56/9Oy8=;
 b=AdeY50YJwyMFda+i0MilFikH1yzDttKma0v6htJkCYK+Zw/00Dy3Cblv
 haltagaUQvfBbgAr92qWdlGnisFEIzicYQDl8/pVolowLmzAJbsRlHhLm
 Lb3YHEi1lspxCKEDx30KWxjrsOeQuomnwYACB3DEDWphi6/mhG73TJ5rk
 75F4q4/Hw9UjaLlZF28jeh3OQvlvCyQQ//34kN/uFFIxT+r5iKYnCaVS7
 94R6ly/Q9eGjBuA4DQhN0bjd6ngC0a8g+EpqsyHHMNb5bYE78bPxPNT3t
 2b/ojAihiC8OWY8jM8zKrIfD2pVF35OZMQ23W/NbPMPVjSn8YGUmZA7LY w==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; d="scan'208";a="11009476"
X-MGA-submission: =?us-ascii?q?MDFmdFDqknzZpRydLwXp0/3nDN64qeTgJfNNN0?=
 =?us-ascii?q?EOqhIdY6l9UU4oaH4bKrlSor2sXpi41A2AA3RR3h9Nu8bzW9y+WjfgXO?=
 =?us-ascii?q?7PcDB2MaaIPrwChsujbTkq5kM2ioWyi2hQdbY/dx+atGjBw3uampNbr6?=
 =?us-ascii?q?gcq3/LjblG0XxIzSYbxbpVlg=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.50])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 07:07:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUI3mAVa7AVVbTO4s5tHJuHnMy2TYG4fLINaNgINST2k5EiS3vU1X7z3b+BcfTmfxs+ZEr7hWeLgkg9GJk2rBBPuxG3ri4wLNn+Il4rCuoaxMUuX36Vy7Khb6T+87ra/4QQizvIYKCCzLOgArMRg2zKU4m0jSw4disvUabIP96aAZ61lCkGKS7ydp0cQjE2+QKsXz9ESO+gADiyt1LlqsxLNnePu+mYrGfpZIqZdhbSiv8E3X7+RPZAdkuRFT6GYEHNdowxr8pQiSTaE+FWDjx+7cONYsCBh1zoHXm8LO2D7+vEHuHz+2P7uQ6QvBY1/tU2oJAxTHmRflYuhEyFlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn2OHg2aUxl0wuo1HMhj/v3O0HjDpaZDiGBJ56/9Oy8=;
 b=UDd5r37vVAfo0OW5rL7UgVikd8u5aUIv07z8zLW3Sr3SjODXIKfIE6XSqfWobc/BX20knlBCEYWP53S8zfxHQrPpRD/zkaCgl8WYonMH/2tTTp93yOpUpZG32/NAnMqUUB1LP0u0pPGMgcxs/6COuQkzlPEaNXbnOqI2NWag2UmcLswwDbZ/jTG3RsSk2rURNx049pwBdzxMZE9L+QX4O3fmt291Uf/n+Y5vIg1X1SjTQXcACqgtFsAnlruAnsuEfSW1f7yhaOcGqwTwa7Kx9eUOwSQBSwqXy61g4wU7pW5lwLkaG5EQQs5LhqG3nDb0p+XEtNYrfiba+K1tLoHFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8530.eurprd07.prod.outlook.com (2603:10a6:20b:4e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:07:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 05:07:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH intel_iommu 5/7] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Topic: [PATCH intel_iommu 5/7] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Index: AQHalM0ih2akMhZuME+ObdSEe3SmSrF0gy8AgADLlAA=
Date: Tue, 23 Apr 2024 05:07:56 +0000
Message-ID: <7fd52664-655c-46fc-8442-c4ad286274cb@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <20240422155236.129179-6-clement.mathieu--drif@eviden.com>
 <cd254155-71aa-480f-8962-038c71a2f786@linaro.org>
In-Reply-To: <cd254155-71aa-480f-8962-038c71a2f786@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8530:EE_
x-ms-office365-filtering-correlation-id: 6d07f37f-99e9-4cf5-b030-08dc63535665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?OGpTKy9DeDV5enBDZUhlN2RicExjdEpqcDhzbi9vMXZaK2FYRklwbEd6YmJK?=
 =?utf-8?B?Wm01bnpkZnpTbEtpTG85eS9pT0NzQUtpaEtxdldxeVllY0RxWFNBeTZSY0tn?=
 =?utf-8?B?T1NkZXFObExJMkJhekw4SFFDQUZOQ0pVbnJkV3dYQ2FuTWdvcVdFV1VhdHZC?=
 =?utf-8?B?YlVuYlZndUo3SWtQZnpveHBnTnBUWWFCTE84QjU4MGtLVFI3amt2bVNlTm9Q?=
 =?utf-8?B?MXRaUlVqTWdNM21MWkhGNEZPcVVUZzAzaGFUNVp6aGpHZkJ1aFAxbkxMWXY1?=
 =?utf-8?B?UUt0SnluMTZuQjF2ZHluSGEzY3I5dnUwMU81WU53bGlDVUlST3RvZzBNanFO?=
 =?utf-8?B?S3dhSDFRZFJxWUsxRDYrQXl3bDQ3ZWlreUk1RHNQWUVQNWZiL3MxWW9Dd2Vn?=
 =?utf-8?B?Sk1qLzZ1K1lvczkzTE5Cd0JNZWpvTkRLUm5tdDJvK3h6VkVNN0QyUWpLQm1n?=
 =?utf-8?B?bHNrclFpd3IxSGxzcVgvTm03Yi9Gby8wT212amJHMi9FV20vSVVjdHdXUzZU?=
 =?utf-8?B?YitUdWdTbEsrcFFycCt4UXpXV0lTTWUzV0RIdEUwb0tJOHI2M2Y2TlhYVVNa?=
 =?utf-8?B?MHllVnVaU2xOSnBiWnRtbWpuQ01mRDA5cmw4WW54ZWVJU2tqZkYwNjhUdzRz?=
 =?utf-8?B?OFFPVlp6U01sRXREVjNmYzJhc3c4RW5sUzNuQ2pNRzlZbHpxK1Vnem1POG0v?=
 =?utf-8?B?K3JqRXRTZStEQW5WRmgwQVRHaWg5dHpUcjdBZnJKVVlqUVBEUXg2dFVuWVZV?=
 =?utf-8?B?d3R6d3JRY2h6N295YlRScGtaNkoxc1BrUC81RWtWY09ZOXBUc1p1K2Z0cnVr?=
 =?utf-8?B?N2VGRkpLVkt5Y2Jlbk5GdkpUbkUveTlYSW9FQTN2cUVuK1EvenEvUzNTK1cz?=
 =?utf-8?B?bkJpZEp4R0dreFF5WmI1elRjWjErc1d4c1BsNTUzeXZTU20vWlBxdXY4TEhY?=
 =?utf-8?B?UFVWNmlDenNzbmhwT0RFT1B5Z2dHcVAwS2J6a2xZU2lSbUJrMC9oN3lCUUxG?=
 =?utf-8?B?QWY2a0NiS3RJWWo0VzRuNEY2RjdJVnM5U292L09DOGJJSitIMGtwck5WSDFV?=
 =?utf-8?B?ZW80N3llY2w4NmFKSjFjbzNlZ0ZETUxvdWdNRmU0dG5aaEhSZHU4elZ1VTg5?=
 =?utf-8?B?N2ZVa1VEa1BTNnROYmRnZE5mc0pramNxcmpKOVRjcmM1WS9jZU9haVB1bDkz?=
 =?utf-8?B?dDVGbWk0bGhrazNkdXNRWWZOSjNRM3dGVnpvNld0aVZxOERPSURJMnZzem8r?=
 =?utf-8?B?WDU1aDhrK2lNV2Z3S1J5cVBUVzkvcmRScGpJQzRQdlhsVFNVem5KVTZIZXkv?=
 =?utf-8?B?TGFYajcyQ3RrU0ZMQTJIQTE5ZThzV084UnEyYXVQRHcvVWxFbnN3K01Id0po?=
 =?utf-8?B?alAwMFdYd1VSOGUvZUw3ZCsrY0gwT2VNODdQU2RPbDY1KzFVZWl0aVFsR1M0?=
 =?utf-8?B?U01HWllZZTJWU0VKSmxMaGZqUlF2SXFTTHNKSkF0dnVielZNeWc4dGtrOGRC?=
 =?utf-8?B?cEFOcDhVc1FHcUxISkJyaHZXVGQwdkVTOHVnS1lESmVOcTZXSSs3SXpFSWwx?=
 =?utf-8?B?eTk4YWFyZGRKWlNsRTZ3REpBM2JaTjFoaUx3QkY4QldTRXVwUmx5Yjk1V0F0?=
 =?utf-8?B?S0w2eEJQdXF1S2R5Q0FpWld0K1A1WWlQbWRNdWFGYjJTdjJ4cjJBcVdrS2NX?=
 =?utf-8?B?aGlWZ3hhSHljTEtSazQ3S2lSdVptcW9aUkdPbnloMERPQ0JGZENPY3F3NGRh?=
 =?utf-8?B?KzArZWREYXdSWGR0cG5admVxczlaVkkzZm9BTWJ2eXNwRkt4dU53b0ErR0JJ?=
 =?utf-8?B?QzdYczFJMy9oS1Z6U0R5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdiZWluSUpheHJTbUhybGFaYUZtemUyRVh4SEVoMnJCSTBsZVNydzZpNmhH?=
 =?utf-8?B?QTI1R2pMSmszaXdpUytlWWQwYlc4b3lYcERDQmRxc0RmUDRwMnpZbjVaL3k1?=
 =?utf-8?B?NE9SSHRMWHhCWXhUNVhuTS85QzVHeU4rQ0dPVEdGYnhuNENvTDhuZ2YvZGtG?=
 =?utf-8?B?MHg1Z1RKdWFTWUVzNmdhNVpxZGJwNlFSSVZGa3IvODVnYVprRFVPd2ZJQTlu?=
 =?utf-8?B?bXFqcVhHckRLYmdnaXpDc1J1bERJSmVGODhQZEVzQ3BpRGpjU1U3VUU2SkFl?=
 =?utf-8?B?SHNPQ0xVYzFOVWFXVjQ4RFhGMWd2ZnJPYS9qdVA4OFc3Y29SVytzOHJ4OVdz?=
 =?utf-8?B?ZGoyOFVab3ppT3JBRE92RVJDbEVDUy9xY1FoQjJNVGFmSTNoMnhKWXVMQ1p2?=
 =?utf-8?B?Ui91bEJiQ1pRMUFNVlY2L3lPZUN3QjdmUitJMEliYmJTR3ZaQlhxQ3VVNEYz?=
 =?utf-8?B?YkFSZEJiYWFYaVNtbjZFSFB4R1JmN1lzenArRm0rL3JUenYvcmJUYmZVcGtq?=
 =?utf-8?B?VTFJMUM2ajJFcHN5aWt1Mkkrb2F3MDgvdEhoQkhKWE56SUhCTnc3S0tQWEh0?=
 =?utf-8?B?K01LSWt2MHVQVGcrbWZRdkVLUlFwbVVWZjNnSGhWUUtjU05qekJEUWdUN3F1?=
 =?utf-8?B?S29laExHYTNQaktwTGVIVHcwZ1RQTGxFZklUY2w5ak9nN1VNUW1YYmlGVjdR?=
 =?utf-8?B?K1dBVDhoM09JNDlid3F2a1oxUlM0V0tKdDczOVRGL3ZoSTdxRks2ZFd3RFFx?=
 =?utf-8?B?UHkxUE51SE5NdThFOUxOalQyU3JNa2RTRWhSL2xaWFFpYlVvWno0bHlFSzV4?=
 =?utf-8?B?Nkl6QVFRU3RZMVlDeVJJeGo1R2Z3Q3BaMmhHVnpRZDRaZlJrWkFiQWhHTWpj?=
 =?utf-8?B?VjRoTld0cVgrY2ZKa1BjZVJveTBsemFpa00wWXpGZ3lHYlNVeEE3RVQwUXhy?=
 =?utf-8?B?U3psL0ZlQUJMNk5HRW9MVTN1Mm1oWTRMZXM2K2g3YmI1ZjBOcGJDa3BieHNR?=
 =?utf-8?B?dlBSWVhEdzY2NTYzN0hwZ1Jybmhpczc3bjU1bzdYTnJSUlpGV3BtMVkyclF0?=
 =?utf-8?B?R0JNRjg2OVlFZWlPVm84TWxOWlgyWFo0Nnl6NDhJK3JkNHBNVm82K21XTDZI?=
 =?utf-8?B?bkZZTUV3b1FPSDZCZWJOQzE3bmRNbURYRzRLaXVBQ0Z2bFJBS0h1SWJ6R2Np?=
 =?utf-8?B?bjJ4eEdobjFadUVVZWNOdHdIS1Z0b0FVWXJ1OHE3NStkVGtIaFpVNjlIQjBT?=
 =?utf-8?B?MCtSZnpIbTVzM2J3SlRBelZEdmFPeWlybnR3V1h3VzIwR3QrQTY2cHd1aVBs?=
 =?utf-8?B?WCs2WG5wZ0pSTFJ4elpxMjFXTE03MjlERXJJZU5nV3d6bzJvSmlvd2NySDBn?=
 =?utf-8?B?aUxwdmdCYjl1dTVxZXZaRVd6alNvZmlBS3g4UEF4M216cTBUSFBFMmFWTm0y?=
 =?utf-8?B?V1lSWkI1NFJtTHZUYWpGc0VqbjRKZ3VrKzdseHlXVnRDNFhxRkxIWUQzV004?=
 =?utf-8?B?dU1tZzFITXE3WHl6SFMzbmdXQ0RCdWJlcVJhQk00N29lc1p1RE1SUGF6NzlS?=
 =?utf-8?B?ME8zVGM0akloRkxGNnZRcHRKY0Rqb0VvUnc5T3JFUmxrNGJXaUd5ZSt6d1FI?=
 =?utf-8?B?OWtkem5INWJtdm5nY3VJbUwrV0Y1WXZTblFOYkpoSHEraFd0Rm9NK2U0dUVt?=
 =?utf-8?B?ODdQNDQ2STFUQmc5QnA1Q1l3a2tUU1ZvN2JBd25qVDQxNWVidCtNZmxkM3Ry?=
 =?utf-8?B?TTNncTRGN2xyNnlma0swcWxCWVB0WFV0Yy9RNjRWNjNNZDNhc2l6S0lqOWox?=
 =?utf-8?B?RWNieUdHdHEzcWdXcitkSmIzTE5PNFRJY2JZcC9Jc1BxajNVVEFaSG9PM0pq?=
 =?utf-8?B?aE1KUHpVU3l2czNiWm5hMnFFUlBtS0tob29PV3FsbW1Ja2FQeGZLMWhabVRI?=
 =?utf-8?B?MkNQU2pTOE1DUnFwc2FNVURpamplMkNZUlVxbzZKTHFXZGUrMDBMYnoxNFhP?=
 =?utf-8?B?N3NPYkx6a0RndkpUcFRRZUVXT1ZWYVA4eEFEWC93MlY1V1E5YUNCMTk5Q24x?=
 =?utf-8?B?dGpNWSt0WXBJUTJxOU91ZWNkeEpCaGdXRnhtVjdzVU9lZWE0OU5ERGZkcHFQ?=
 =?utf-8?B?bUd5WU5yK29ZQXNET2xQMzJIZGVIQjJKRnFTdEVYeUU3RWdKVVU4R29xbGd6?=
 =?utf-8?Q?muOit8+fjyfHKTO9CPEVYO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF23AE7E6A8D3046B477D67AB68EF267@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d07f37f-99e9-4cf5-b030-08dc63535665
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 05:07:56.2419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGANhJtX0FicB6uDoifPPjHEznn2jdTzVjcaMer3gCmh9j8EFK9dn8Ql4QqBpWOgfAjIqbjM10AQXVg00x0a3hb9owLsoX33/r1FOvMbKb+VlNx4xufD5au3NXnC/0xp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8530
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

DQpPbiAyMi8wNC8yMDI0IDE4OjU5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
T24gMjIvNC8yNCAxNzo1MiwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4gVGhpcyBw
aWVjZSBvZiBjb2RlIGNhbiBiZSBzaGFyZWQgYnkgYm90aCBJT1RMQiBpbnZhbGlkYXRpb24gYW5k
DQo+PiBQQVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNv
bT4NCj4+IC0tLQ0KPj4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNTcgKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMz
IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPg0KPg0KPj4gwqAgc3RhdGljIGJvb2wg
dnRkX3Byb2Nlc3NfZGV2aWNlX2lvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlRESW52RGVzYyAqaW52X2Rlc2MpDQo+PiDCoCB7
DQo+PiDCoMKgwqDCoMKgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hczsNCj4+IC3CoMKgwqAg
SU9NTVVUTEJFdmVudCBldmVudDsNCj4+IMKgwqDCoMKgwqAgaHdhZGRyIGFkZHI7DQo+PiAtwqDC
oMKgIHVpbnQ2NF90IHN6Ow0KPj4gwqDCoMKgwqDCoCB1aW50MTZfdCBzaWQ7DQo+PiDCoMKgwqDC
oMKgIGJvb2wgc2l6ZTsNCj4+DQo+PiBAQCAtMjkxMiw2ICsyOTQxLDcgQEAgc3RhdGljIGJvb2wg
DQo+PiB2dGRfcHJvY2Vzc19kZXZpY2VfaW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPj4gwqDCoMKgwqDCoCB9DQo+Pg0K
Pj4gKw0KPg0KPiBTcHVyaW91cyBuZXdsaW5lIDspDQpPdXBzLCBzb3JyeSwgaXQncyBmaXhlZA0K
Pg0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KPg0KPj4gwqDCoMKgwqDCoCAvKg0KPg==

