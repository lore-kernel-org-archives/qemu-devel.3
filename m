Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737A6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 07:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHmt-00025D-4N; Fri, 09 May 2025 03:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHmr-00024z-MT; Fri, 09 May 2025 03:04:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHmp-0001ik-3l; Fri, 09 May 2025 03:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPpZxjKCbDczg4PGw91NxLh+/3UhI9d4yP7nKLhttl+v6miOaxPsacOYIQH3TGwv83tw2ZG4zZmUMCIOYHo8twB26UnYmzc4eft+ZtzL5Xu0adkmoWzEe9YH+v82tNkBXKaRwoV/aNdk8/Es2pPvZNvdzcm2NiNgq1mequlUePbU6glSM7oVY9DWLd4hil3tWPf58m6UVSTr9MFAnKome6oRLvHsD/dC9b9QPp/ARFYcKWkv/owvK5nB2tkhAipyUWf2CFtAl/59NUTEcg0TAUEU70ThhfQ67FYSc0PLlcBlnR2Tp3ejLeDt33iLJcq5iDdiGlF9LlbUoY6K6bjByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUjIwUahWMRiwMan8I75aRb9BByjDtCgGpjRyxaR//s=;
 b=FJmDCVoZvg5iy6Ap/ksLKJgviOjO6YQK1tbc86PxOeSmIn2xKH/kfmqcBZ3N17tW4bHMBLuFBSY/MZyYpxPdjBpKiN5aagmj5P2yfwLfcYMOc2UH+kSreCBex6YUeFgLIu8GSW57UHqYfNRtO+R+o1HX2vbhdAfkCcTcTObdvslTGIiDg1t2F/Rke7aGtJjysixbWCmeocypewDlJiJq+ZpUABgYuwEoaMfKROGgkOvOUI0y+RUa9QGWP6QC/CZuttZxX4tMmbvDb6PmGftWqNjFs9TC+/v+mlsEwImfoQ62o43+2YsbQkkeJOTsa7nb6VNUng1Eg92cpj4c/jYT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUjIwUahWMRiwMan8I75aRb9BByjDtCgGpjRyxaR//s=;
 b=PMisd8+X5XjQn0P005jehNWruI/u53tfGwoQCk3R9grlNOeYKYxiS5aSvVYlmf5TZ8rzXRKOkLlv4ZdD27DLwgUdUymyVIG7LHw6xTAO3MfUSSAKShRS04DjtJpr2uuNTE5fuimM0yKTIOBxbhLT9iuHBfU3nu4pUnAm31F5WC/74kxXjcecBFQ0dJtNmDtHgXzobrMwFfVy/0aqWqfRU6u7Ad4sF9+0BkmS+XMT2/aAcPae591wAOOfn5VWXwbJW9Ip3FN4GvnPbu6JQHYEz4kiXag3I046DU4zgSqpm8HYWtSXG6aSm8GLqG0kvIQG4k79rVdQSIg0gMfBozqhBQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB5979.apcprd06.prod.outlook.com (2603:1096:400:356::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 07:04:39 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 07:04:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Topic: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Index: AQHbmkNXc4tSzAUgS0eQdreGXV1+FbOQEMwAgDoaPGA=
Date: Fri, 9 May 2025 07:04:38 +0000
Message-ID: <SI2PR06MB504194D74CCFCBB9403B7214FC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-9-jamin_lin@aspeedtech.com>
 <ff5e84c5-4714-4897-90b6-40df76746443@kaod.org>
In-Reply-To: <ff5e84c5-4714-4897-90b6-40df76746443@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB5979:EE_
x-ms-office365-filtering-correlation-id: 8af69af0-f31b-4eef-6f81-08dd8ec7c3c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?b0J1WjZoM2FTK3BnbU9XQTMrZ1FMb0I5dVpwbFFUU0c3dVFVU29QOURhTFBi?=
 =?utf-8?B?U1orSnJTVTI3RzcrRjNqWE9UczFjUFl6VFpHOFZQNmRPalVIdkRiWlBIY2FE?=
 =?utf-8?B?Z2FlWmtWUzc1MFg0QnFuK1JLUCtxRnQvT2tob04xYVJUZUlHODJCWFJRaXZU?=
 =?utf-8?B?SmVsNmdFb0J4TUc3ZnAyWmZ3MVhDVFBtN1RXK0RpYXFYdHVRWHhLZUNZUTRC?=
 =?utf-8?B?ZE9YVDRtRTdyOHV3U2FwMDNWci9Kd0ZwRWsxTUI1VEFNNWVML3ZHQVpoM0Nr?=
 =?utf-8?B?UW0xSXoxajNVS1BjcTBUSy9tbFVZeVVycWIwcFZxanJ3cm5rMkVpeGtmcWpy?=
 =?utf-8?B?WS9tVWZSdzd1cWkrU0tmYStEcFVKWmYzTzRKSW1wUnI4Z2sxVk9pV094TWIv?=
 =?utf-8?B?d2ZmekROQTJMd3VnNWRWU0N3OHlqOGp1SFVzNU84bXJSd0NoWEZ6akprU3Jr?=
 =?utf-8?B?bUlyNmMwUVUvZTRjUmNvK1hZcnlSZHJjWEVVWksvQ1VWZnVYT0tIeFZPYzJi?=
 =?utf-8?B?Y2NGZHUrTmdkd0gxMnZqdEF3eG54YW10Z2dBL1N5VzF6M0NaQlR5TTlqVDd5?=
 =?utf-8?B?bDRSSUVZeTJWalQ0aitvVk8rNXFRdWtNRHZZb293UzdMRDVKeW5oc0JxSzQx?=
 =?utf-8?B?SnJKY3UwU0pWeGRTbVNsSXBJdzNJbmRZWDg0TnlOdDZ0NXdlaWl2Y2xJcFg5?=
 =?utf-8?B?WGtDemY0eHlEMzBiNXlBaHZnL2Q1ME14TTRLeWprS1g3ZUhuWGVmNTFLbExi?=
 =?utf-8?B?N0pLdHNPaGNpd3RJdmRFWCtnK1pVTitSdWhOSVBoV21CM2dPbVBncVdKdHAz?=
 =?utf-8?B?MmppZVBySmxkMTRZWlpra1h0R091Y0pXdEdxbUU1RzE2TUVjT2REODBaQ1JQ?=
 =?utf-8?B?dlYyTjZGYXRnRVJ4Z2FTeHZhZjRVbGFOK2xuN3k2enY0QTZ6L0NRQVN2c2pW?=
 =?utf-8?B?Q29ZNHZZWEdncUxoc2h2ZTROQWFVR21NMHA1T2hlMktxaE16OG52cUtWQXdv?=
 =?utf-8?B?WGtRNnk4NVVHMUxtejJCNDFwaUZ3a0l3SzRsT292K1ByeUFoMFg2a0xaNlpP?=
 =?utf-8?B?azFxK3E0ck1BeDFuRjZNZXBGc3pvaHIrSVJuc3VZYlhSNEpzUVQ2M1JPSmRp?=
 =?utf-8?B?TmJMODgwMXo3ek0xS25Xcy93c0pWYjlBd2ZSWkxHSy8rd3daWFRsVGM5bkZy?=
 =?utf-8?B?em9pZTZFc29ianhoMXNmT0x4QnQxZElYc2R1NWxYSHBRMzZNU041NEVLNHNZ?=
 =?utf-8?B?TzYxZkFPTUtuKzd1SjZrQ3ZuK3ZUMmV5SjVqRmorTXk4SEs4bmcyQi9KOGNy?=
 =?utf-8?B?eXluaEVtRXJBaWpGMWN5Sk1wYmtNeG0vVTZ2WnQ0dDQ0ZmRXNDdEQjMrSXJy?=
 =?utf-8?B?bGw0VFUyQzVNdGs1cFpFVjVqWlJzY29rTGRab2UxWlNlSEhHdGVnS1h1OTQ4?=
 =?utf-8?B?NkhSWFFLalhpREEvQlZRZVI0djBQaEpaTlcrT01ESzRKY1laU0pZL3I4N3Bw?=
 =?utf-8?B?d0YxSVgwMGNhOEJiTlh5RVJhWWRMTnJZWlR5dVNCWE9PeTM2eFVTYXd6cnFO?=
 =?utf-8?B?RXNzWlhEZG1KeEpMZ2VxZGk5U015UzBLdkIyN3pZWnMxMXN0YVdqZW1OR2V4?=
 =?utf-8?B?bzhRK2htVkdJTit0aTRhUGl2blVMblhnRE9qMkJYNm0xSXBucVk2UGNBTjF4?=
 =?utf-8?B?ZkpnQitWUUQyWDlIZWhZQmhwSGF2MnFLaWJtU3FIQld3amcrLytrR1VxUFkv?=
 =?utf-8?B?dXZwclBxaFhTR3JIUG1nekszK0RZT3VESGZLYzVwQjZ2cG9nOE1HcURZQmZW?=
 =?utf-8?B?dldIVDBCT09pS2hBSm5JRW1TTHNXZUFGc2FQVVpqV3pIRHBqb0JWQUlDMkZw?=
 =?utf-8?B?VzQreUFUNElGeW5uUVlOc21qVWdocFBwNjgrRjI0a2xkazA5NmIvZjVaL0Ez?=
 =?utf-8?B?Q0xJR1ZOTmVydXRNaENsWEZycEpGUmFNZDY3WHlCOHJWL1h5bkZROGk2bStJ?=
 =?utf-8?Q?shBmlmjYRZjYWtlKDt9w63vrfP/20U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS9ZT1VOWmE1YmpOS1JIcURhV1Y4TlovcEFoRjhkRDd1K0k2RWpQZzRiajNw?=
 =?utf-8?B?NFNrekoydFBLS2IrSVJHcDlnUFBRZUh2R1ZVQnhIOFJkWXB6UCsycWxucG1r?=
 =?utf-8?B?Q0RFOUlleGxQSUpROU5ZT0hWMDBCdWZZVFVrSGxrekhramJKb00vTmFubkdK?=
 =?utf-8?B?NFNxNVVidmV2SFQ5R2VaZ3FqdC9zaGJLMjc3c1MzdXY0QnNoaDk5b3pwNVN6?=
 =?utf-8?B?azJhYXdOVCtkeVYyZXhTNWNVeXBHbjZQYWFGdEJYV3hXZGdnWklZQVNIZEVX?=
 =?utf-8?B?S2cvR0VmV0hPTnM1NnM5RUUrZGxzNUZXUlJpdFNzWFlxQXkrK2tpUDRuVTZk?=
 =?utf-8?B?em5JNjRFSFVSMm5aTzZkZk9mRzFrZmM5OGUzdU5XdVNiSjZHUjlHRmlJamM3?=
 =?utf-8?B?QUFUSzV0WUxxeng1OURhWERyRTJKejVhUzBZWVRuWk9FcFpWWnowOW0zbVc2?=
 =?utf-8?B?NzI1R2Jkaldad00yRHJjck1pNFJKNHBjZ1hBTWxXN2pxbUFRQjBsOG1SNnpX?=
 =?utf-8?B?MVVlN0x2c0lJQm1weXBqTE5HbFZwajRoaHZLelMrV2txVElyUkJObFI2YzVl?=
 =?utf-8?B?aGljcUYvdmt4SDBVdXJSM3lYY3VwWk1MZ2tEN0Fla21BMy9WY1B6clFZS0tj?=
 =?utf-8?B?R0RqajZ0RDkxTDhjSWRVMk40QjBGU3Znek5kbGtYMkI3SEh6Tkp4Y1JaUnRx?=
 =?utf-8?B?dVBRUDNNY2YyWXA0YWk1cmlITWMxdmFhQS9ISEM0WklnRmFNYlZFOVYrc0RD?=
 =?utf-8?B?WGlyTDhQeUxya0ZRYXh6Vk9DT2t3Y25aZzYvaWJjRFArVDJpb25JYUl5Rzhi?=
 =?utf-8?B?L2crSmh0cXUrNFlUL3Arc1FDT2FVVTRKZWtOOU40b1NrazVNdmNHV3dlY1RF?=
 =?utf-8?B?QVkrbjZtbVRnamxvZERqZ1pKbEJMT2NxT3k4MlprREdTZUZ3VDFKQy9vc0Zl?=
 =?utf-8?B?dzFiWjl6a3FadTNVdWw3WGhSakg5TGtvN2NOalAydU5iQ1BFc3plNkEyZWNa?=
 =?utf-8?B?M3lKQlhUSlplTTBjVnpaZVFBeDJoTWhPUys1VThXU0dZOU9nLzg0U05RcDd1?=
 =?utf-8?B?M1VuMDdQVkFnM2ljTnhiaStkZDMvOXhJS1Ivd3p0KzNLVTVVd1cxSU9YME1i?=
 =?utf-8?B?bWtYR245TXBrQmNtS2hQU0NKRzRrd1VwRW9zOCtmTGF0b21aS0RBekMxbXIy?=
 =?utf-8?B?a3lvT2hzYU1KNUJNR2EzR0pVejBNWnAyS0xINUplSkh3bWVNbytCV0NvTHVR?=
 =?utf-8?B?NGdyMWVreFZ4SXE2UXFTc212cnY3Q3Evd0puYlVEbDM4WWdhcnpYRGx2OXU4?=
 =?utf-8?B?NG1BbllSS2cwU2FpaFIydzI3Q3FOb2JvOEN0YTFHYkYzY0VHbUo1dWxsZUl2?=
 =?utf-8?B?RGwrUHBtcHFDSDA4RWJURkxieHIyQ29DNnRrdUltT0ZhTjdEVTI0WEpsOW5I?=
 =?utf-8?B?TVdHRHQ1QlJLVlVMLzFjdCtMNThLWDJDZ0hmQytKVzRZek1tbUtueGFYMGI4?=
 =?utf-8?B?U1MvZHNUbEFkRjEvT2ZnZ3NkdWZldDlCa2YydVp6NGNuY3dkeGVOR2VFNXdv?=
 =?utf-8?B?Z0c1NS9UclR2SGFyeEZJb3Fpa2xQK3Q3enN4NWFzNkVNQUZUbmtkQnN4dGtT?=
 =?utf-8?B?UXR6MDF3ZXRrZTllME54SjhxdU4zemN3Qk16MUpXT1RmRWkyelg4Ulk3RnR5?=
 =?utf-8?B?L1E3Nkl4Q0VCZHBxUHVGZEJQUTJ6UE5pUmZxSmlEMUtzVS9vY1hkSHhmdVFD?=
 =?utf-8?B?K3d1Y2hxcXJBby83OHF4N2hNSm1FdFNVRVBnZU1wdjJnbWVrYXAwMmc4N2hi?=
 =?utf-8?B?ZHVLOU9hRVhtb3NWWWk2TXBPeHVZR1dBWmZrOGdQVWdMS1dVM3grbFB1a1dG?=
 =?utf-8?B?UUMrczF5SUc5blZETWxaN1c4QjFlNGVVUEVPL2t1OGNyaHVJS0Y0MU1WZ0E5?=
 =?utf-8?B?Uis0Rzd2dUpYTDQ0S2lJVStDd0x3RUc4QUJjSEtCVXl1NVROczd6cGhSbUNK?=
 =?utf-8?B?MnI2K01SbWprczR6Q3l6ZnJHVDFScFJYMllxRmN3bW9rYmV4T01aWjdzbHR5?=
 =?utf-8?B?TUVjTGo5UFFHSWlOTDd6YkhhVEIyRDlKMnZRdWlWR3RIRUk5RWxVOUZYeGFL?=
 =?utf-8?Q?0gp/dB3jI/iJFy/AvaYjKvBJ7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af69af0-f31b-4eef-6f81-08dd8ec7c3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 07:04:39.0089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ah+36polRP2phlzGQr07WGzhtGQBwu2hb0tt/m3BHFAKgfJTXy7eXNgjmnQC0EiKtM6JseU3gwtwmQyt4nDRxFpdoYtiPqcKjsvqR29kmfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5979
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IFN1cHBvcnQgRE1BIDY0IGJpdHMNCj4gZHJhbSBhZGRyZXNzLg0KPiANCj4gT24g
My8yMS8yNSAxMDoyNiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEFjY29yZGluZyB0byB0aGUgQVNU
MjcwMCBkZXNpZ24sIHRoZSBkYXRhIHNvdXJjZSBhZGRyZXNzIGlzIDY0LWJpdCwNCj4gPiB3aXRo
IFJfSEFTSF9TUkNfSEkgc3RvcmluZyBiaXRzIFs2MzozMl0gYW5kIFJfSEFTSF9TUkMgc3Rvcmlu
ZyBiaXRzDQo+IFszMTowXS4NCj4gPg0KPiA+IFNpbWlsYXJseSwgdGhlIGRpZ2VzdCBhZGRyZXNz
IGlzIDY0LWJpdCwgd2l0aCBSX0hBU0hfREVTVF9ISSBzdG9yaW5nDQo+ID4gYml0cyBbNjM6MzJd
IGFuZCBSX0hBU0hfREVTVCBzdG9yaW5nIGJpdHMgWzMxOjBdLg0KPiA+DQo+ID4gSWRlYWxseSwg
c2dfYWRkciBzaG91bGQgYmUgNjQtYml0IGZvciB0aGUgQVNUMjcwMCwgdXNpbmcgdGhlIGZvbGxv
d2luZw0KPiA+IHByb2dyYW0gdG8gb2J0YWluIHRoZSA2NC1iaXQgc2dfYWRkciBhbmQgY29udmVy
dCBpdCB0byBhIERSQU0gb2Zmc2V0Og0KPiA+DQo+ID4gYGBgDQo+ID4gc2dfYWRkciA9IGRlcG9z
aXQ2NChzZ19hZGRyLCAzMiwgMzIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgYWRkcmVzc19z
cGFjZV9sZGxfbGUoJnMtPmRyYW1fYXMsIHNyYyArDQo+IFNHX0xJU1RfQUREUl9TSVpFLA0KPiA+
DQo+IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsDQo+ID4gTlVMTCk7IHNnX2FkZHIgLT0gMHg0MDAw
MDAwMDA7IGBgYA0KPiANCj4gSSBkb24ndCB0aGluayB0aGUgY29kZSBleHRyYWN0IGFib3ZlIGlz
IHVzZWZ1bC4NCj4gDQo+ID4gVG8gbWFpbnRhaW4gY29tcGF0aWJpbGl0eSB3aXRoIG9sZGVyIFNv
Q3Mgc3VjaCBhcyB0aGUgQVNUMjYwMCwgdGhlDQo+ID4gQVNUMjcwMCBIVyBIQUNFIGNvbnRyb2xs
ZXJzIGF1dG9tYXRpY2FsbHkgc2V0IGJpdCAzNCBvZiB0aGUgNjQtYml0IHNnX2FkZHIuDQo+IA0K
PiBJIHN1cHBvc2UgdGhhdCdzIHdoYXQgYml0cyBbMzA6MjhdIG9mIHRoZSBmaXJzdCB3b3JkIG9m
IHRoZSBzY2F0dGVyLWdhdGhlciBlbnRyeQ0KPiBhcmUgZm9yID8NCj4gDQo+ID4gQXMgYSByZXN1
bHQsDQo+ID4gdGhlIGZpcm13YXJlIG9ubHkgbmVlZHMgdG8gcHJvdmlkZSBhIDMyLWJpdCBzZ19h
ZGRyIGNvbnRhaW5pbmcgYml0cyBbMzE6MF0uDQo+ID4gVGhpcyBpcyBzdWZmaWNpZW50IGZvciB0
aGUgQVNUMjcwMCwgYXMgaXQgdXNlcyBhIERSQU0gb2Zmc2V0IHJhdGhlcg0KPiA+IHRoYW4gYSBE
UkFNIGFkZHJlc3MuDQo+IA0KPiB5ZXMgdGhlIEhBQ0UgbW9kZWwgY2FuIHVzZSBhIHJlbGF0aXZl
IGFkZHJlc3MgYmVjYXVzZSB0aGUgRFJBTSBtZW1vcnkNCj4gcmVnaW9uIGlzIGRpcmVjdGx5IGF2
YWlsYWJsZS4gVGhlcmUgaXMgbm8gbmVlZCB0byBjb25zdHJ1Y3QgYSBwaHlzaWNhbCBhZGRyZXNz
Lg0KPiANCj4gPiBJbnRyb2R1Y2UgYSBoYXNfZG1hNjQgY2xhc3MgYXR0cmlidXRlIGFuZCBzZXQg
aXQgdG8gdHJ1ZSBmb3IgdGhlIEFTVDI3MDAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1p
biBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUv
aHcvbWlzYy9hc3BlZWRfaGFjZS5oIHwgIDEgKw0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfaGFjZS5j
ICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfaGFjZS5oDQo+ID4gYi9pbmNsdWRlL2h3L21p
c2MvYXNwZWVkX2hhY2UuaCBpbmRleCBhNDQ3OWJkMzgzLi41OGZiNjYwMDlhIDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfaGFjZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9oYWNlLmgNCj4gPiBAQCAtNTIsNiArNTIsNyBAQCBzdHJ1Y3QgQXNwZWVk
SEFDRUNsYXNzIHsNCj4gPiAgICAgICB1aW50MzJfdCBzcmNfaGlfbWFzazsNCj4gPiAgICAgICB1
aW50MzJfdCBkZXN0X2hpX21hc2s7DQo+ID4gICAgICAgdWludDMyX3Qga2V5X2hpX21hc2s7DQo+
ID4gKyAgICBib29sIGhhc19kbWE2NDsNCj4gPiAgIH07DQo+ID4NCj4gPiAgICNlbmRpZiAvKiBB
U1BFRURfSEFDRV9IICovDQo+ID4gZGlmZiAtLWdpdCBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYyBi
L2h3L21pc2MvYXNwZWVkX2hhY2UuYyBpbmRleA0KPiA+IDUxYzY1MjNmYWIuLjhmMzMzZmM5N2Ug
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvbWlzYy9hc3BlZWRfaGFjZS5jDQo+ID4gKysrIGIvaHcvbWlz
Yy9hc3BlZWRfaGFjZS5jDQo+ID4gQEAgLTE0OCw2ICsxNDgsNyBAQCBzdGF0aWMgYm9vbCBoYXNf
cGFkZGluZyhBc3BlZWRIQUNFU3RhdGUgKnMsIHN0cnVjdA0KPiBpb3ZlYyAqaW92LA0KPiA+ICAg
c3RhdGljIHZvaWQgZG9faGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLCBpbnQgYWxn
bywgYm9vbA0KPiBzZ19tb2RlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym9vbCBhY2NfbW9kZSkNCj4gPiAgIHsNCj4gPiArICAgIEFzcGVlZEhBQ0VDbGFzcyAqYWhjID0g
QVNQRUVEX0hBQ0VfR0VUX0NMQVNTKHMpOw0KPiA+ICAgICAgIGJvb2wgc2dfYWNjX21vZGVfZmlu
YWxfcmVxdWVzdCA9IGZhbHNlOw0KPiA+ICAgICAgIGdfYXV0b2ZyZWUgdWludDhfdCAqZGlnZXN0
X2J1ZiA9IE5VTEw7DQo+ID4gICAgICAgc3RydWN0IGlvdmVjIGlvdltBU1BFRURfSEFDRV9NQVhf
U0ddOyBAQCAtMTgyLDYgKzE4Myw5IEBADQo+IHN0YXRpYw0KPiA+IHZvaWQgZG9faGFzaF9vcGVy
YXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLCBpbnQgYWxnbywgYm9vbCBzZ19tb2RlLA0KPiA+ICAg
ICAgICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAgICBzcmMgPSBkZXBvc2l0NjQoc3Jj
LCAwLCAzMiwgcy0+cmVnc1tSX0hBU0hfU1JDXSk7DQo+ID4gKyAgICAgICAgICAgIGlmIChhaGMt
Pmhhc19kbWE2NCkgew0KPiA+ICsgICAgICAgICAgICAgICAgc3JjID0gZGVwb3NpdDY0KHNyYywg
MzIsIDMyLCBzLT5yZWdzW1JfSEFTSF9TUkNfSEldKTsNCj4gPiArICAgICAgICAgICAgfQ0KPiAN
Cj4gVGhhdCdzIHdoZXJlIGEgbGl0dGxlIGhlbHBlciB3b3VsZCBiZSBuaWNlIHRvIGhhdmUuDQo+
IA0KSSBhZGQgaGFzaF9nZXRfc291cmNlX2FkZHIgaGVscCBmdW5jdGlvbi4NClBsZWFzZSBzZWUg
cGF0Y2ggNiBjb21tZW50cy4NCg0KPiA+ICAgICAgICAgICAgICAgc3JjICs9IGkgKiBTR19MSVNU
X0VOVFJZX1NJWkU7DQo+ID4NCj4gPiAgICAgICAgICAgICAgIGxlbiA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKCZzLT5kcmFtX2FzLCBzcmMsIEBAIC0xOTAsNg0KPiA+ICsxOTQsMjEgQEAgc3RhdGlj
IHZvaWQgZG9faGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLCBpbnQgYWxnbywNCj4g
Ym9vbCBzZ19tb2RlLA0KPiA+ICAgICAgICAgICAgICAgc2dfYWRkciA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKCZzLT5kcmFtX2FzLCBzcmMgKw0KPiBTR19MSVNUX0xFTl9TSVpFLA0KPiA+DQo+IE1F
TVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiA+ICAgICAgICAgICAgICAgc2dfYWRkciAm
PSBTR19MSVNUX0FERFJfTUFTSzsNCj4gPiArICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAg
ICAgICogSWRlYWxseSwgc2dfYWRkciBzaG91bGQgYmUgNjQtYml0IGZvciB0aGUgQVNUMjcwMCwg
dXNpbmcNCj4gdGhlDQo+ID4gKyAgICAgICAgICAgICAqIGZvbGxvd2luZyBwcm9ncmFtIHRvIG9i
dGFpbiB0aGUgNjQtYml0IHNnX2FkZHIgYW5kDQo+IGNvbnZlcnQgaXQNCj4gPiArICAgICAgICAg
ICAgICogdG8gYSBEUkFNIG9mZnNldDoNCj4gPiArICAgICAgICAgICAgICogc2dfYWRkciA9IGRl
cG9zaXQ2NChzZ19hZGRyLCAzMiwgMzIsDQo+ID4gKyAgICAgICAgICAgICAqICAgICAgYWRkcmVz
c19zcGFjZV9sZGxfbGUoJnMtPmRyYW1fYXMsIHNyYyArDQo+IFNHX0FERFJfTEVOX1NJWkUsDQo+
ID4gKyAgICAgICAgICAgICAqDQo+IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiA+
ICsgICAgICAgICAgICAgKiBzZ19hZGRyIC09IDB4NDAwMDAwMDAwOw0KPiA+ICsgICAgICAgICAg
ICAgKg0KPiANCj4gSSBkb24ndCB0aGluayB0aGUgYWJvdmUgY29tbWVudCBpcyB1c2VmdWwuIFBs
ZWFzZSBrZWVwIHRoZSBvbmUgYmVsb3cuDQo+IA0KPiA+ICsgICAgICAgICAgICAgKiBUbyBtYWlu
dGFpbiBjb21wYXRpYmlsaXR5IHdpdGggb2xkZXIgU29DcyBzdWNoIGFzIHRoZQ0KPiBBU1QyNjAw
LA0KPiA+ICsgICAgICAgICAgICAgKiB0aGUgQVNUMjcwMCBIVyBhdXRvbWF0aWNhbGx5IHNldCBi
aXQgMzQgb2YgdGhlIDY0LWJpdA0KPiBzZ19hZGRyLg0KPiA+ICsgICAgICAgICAgICAgKiBBcyBh
IHJlc3VsdCwgdGhlIGZpcm13YXJlIG9ubHkgbmVlZHMgdG8gcHJvdmlkZSBhIDMyLWJpdA0KPiBz
Z19hZGRyDQo+ID4gKyAgICAgICAgICAgICAqIGNvbnRhaW5pbmcgYml0cyBbMzE6MF0uIFRoaXMg
aXMgc3VmZmljaWVudCBmb3IgdGhlIEFTVDI3MDAsDQo+IGFzDQo+ID4gKyAgICAgICAgICAgICAq
IGl0IHVzZXMgYSBEUkFNIG9mZnNldCByYXRoZXIgdGhhbiBhIERSQU0gYWRkcmVzcy4NCj4gPiAr
ICAgICAgICAgICAgICovDQo+IA0KDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24gd2lsbCB1cGRhdGUg
dGhlbS4NCg0KPiBUaGUgU0dfTElTVF9BRERSX01BU0sgbmVlZHMgYW4gdXBkYXRlIHRob3VnaC4g
QUZBSUNULCBpdCdzIGJpZ2dlciBvbg0KPiBBU1QyNzAwLg0KDQpUaGUgdmFsdWUgb2YgU0dfTElT
VF9BRERSX01BU0sgd2FzIHdyb25nIGZvciBBU1QyNzAwLCBBU1QyNjAwIGFuZCBBU1QxMDMwLiAN
ClRoZSBjb3JyZWN0IHZhbHVlIHNob3VsZCBiZSAweDdGRkZGRkY4Lg0KV2lsbCBjcmVhdGUgYSBu
ZXcgcGF0Y2ggdG8gZml4IGl0Lg0KUGxlYXNlIHNlZSBwYXRjaCA0IGNvbW1lbnRzLg0KQnkgdGhl
IHdheSwgQVNUMjUwMCBkbyBub3Qgc3VwcG9ydCBTRyBtb2RlLiANClRoYW5rcy1KYW1pbg0KPiAN
Cj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gICAgICAgICAgICAgICBw
bGVuID0gbGVuICYgU0dfTElTVF9MRU5fTUFTSzsNCj4gPiAgICAgICAgICAgICAgIGhhZGRyID0g
YWRkcmVzc19zcGFjZV9tYXAoJnMtPmRyYW1fYXMsIHNnX2FkZHIsICZwbGVuLA0KPiA+IGZhbHNl
LCBAQCAtMjE4LDcgKzIzNyw5IEBAIHN0YXRpYyB2b2lkDQo+IGRvX2hhc2hfb3BlcmF0aW9uKEFz
cGVlZEhBQ0VTdGF0ZSAqcywgaW50IGFsZ28sIGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICB9IGVs
c2Ugew0KPiA+ICAgICAgICAgICBwbGVuID0gcy0+cmVnc1tSX0hBU0hfU1JDX0xFTl07DQo+ID4g
ICAgICAgICAgIHNyYyA9IGRlcG9zaXQ2NChzcmMsIDAsIDMyLCBzLT5yZWdzW1JfSEFTSF9TUkNd
KTsNCj4gPiAtDQo+ID4gKyAgICAgICAgaWYgKGFoYy0+aGFzX2RtYTY0KSB7DQo+ID4gKyAgICAg
ICAgICAgIHNyYyA9IGRlcG9zaXQ2NChzcmMsIDMyLCAzMiwgcy0+cmVnc1tSX0hBU0hfU1JDX0hJ
XSk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICAgICAgICAgICBoYWRkciA9IGFkZHJlc3Nfc3BhY2Vf
bWFwKCZzLT5kcmFtX2FzLCBzcmMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJnBsZW4sIGZhbHNlLA0KPiBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKTsNCj4gPiAgICAg
ICAgICAgaWYgKGhhZGRyID09IE5VTEwpIHsNCj4gPiBAQCAtMjc1LDYgKzI5Niw5IEBAIHN0YXRp
YyB2b2lkIGRvX2hhc2hfb3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4gaW50IGFsZ28s
IGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICBkaWdlc3RfYWRkciA9
IGRlcG9zaXQ2NChkaWdlc3RfYWRkciwgMCwgMzIsDQo+ID4gcy0+cmVnc1tSX0hBU0hfREVTVF0p
Ow0KPiA+ICsgICAgaWYgKGFoYy0+aGFzX2RtYTY0KSB7DQo+ID4gKyAgICAgICAgZGlnZXN0X2Fk
ZHIgPSBkZXBvc2l0NjQoZGlnZXN0X2FkZHIsIDMyLCAzMiwNCj4gcy0+cmVnc1tSX0hBU0hfREVT
VF9ISV0pOw0KPiA+ICsgICAgfQ0KPiA+ICAgICAgIGlmIChhZGRyZXNzX3NwYWNlX3dyaXRlKCZz
LT5kcmFtX2FzLCBkaWdlc3RfYWRkciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRpZ2VzdF9idWYsIGRpZ2VzdF9sZW4pKSB7IEBAIC02MDEsNg0KPiA+ICs2MjUsNyBAQCBz
dGF0aWMgdm9pZCBhc3BlZWRfYXN0MjcwMF9oYWNlX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmts
YXNzLA0KPiB2b2lkICpkYXRhKQ0KPiA+ICAgICAgICAqIGhhcyBjb21wbGV0ZWQuIEl0IGlzIGEg
dGVtcG9yYXJ5IHdvcmthcm91bmQuDQo+ID4gICAgICAgICovDQo+ID4gICAgICAgYWhjLT5yYWlz
ZV9jcnlwdF9pbnRlcnJ1cHRfd29ya2Fyb3VuZCA9IHRydWU7DQo+ID4gKyAgICBhaGMtPmhhc19k
bWE2NCA9IHRydWU7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBh
c3BlZWRfYXN0MjcwMF9oYWNlX2luZm8gPSB7DQoNCg==

