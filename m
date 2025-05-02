Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F8C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfnk-000843-Ju; Thu, 01 May 2025 22:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAfng-00083F-2A; Thu, 01 May 2025 22:06:52 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAfnb-0003nt-Ly; Thu, 01 May 2025 22:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9oynR6JpEv4qTU1rd6ibRoJ9+5VBWd060aNZ7hLHGTIBDFmspyq9j0v6q00w34V/uZo3rxITAy12tahPsWt8T869GxliCkZymyPM6cjYm2vVJB6D9jmFAGQlAdcyegoltH0beRl4UWTNIRE58QI0aHmzpQ57Hmh9H3BbzmOh0eWQeS6gQuQTCbjNBmdJ6n8AJC+swO4wvHL16W5k10H2iT+527TV+SHrfHjAodXi7K1Izxq3iSZvu4upwK/r0cwnyJP190srZD5zRpvbFA9Y7wshXSQZdMzHtIBiED8RZ9uZkOopnAUzfzcnwYjHqo7SJXZ9ozwzjQZ5BaE8Fjg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVhlgOmKTu/T5Kk86biGdTpqhycGO04RP23EuxWl6IM=;
 b=PsGX7oOFY1P0at+tL58o1mh6atKkBS0VIWfVRZy7UWmGhSWySrFq5zlRbhj8Kh0lv0NZnlV6VvBJ1EXnjdLulRY5CYjZ3Dy9XUX1BDeVdFAgow/2QPiG7Fe6yUTv6f9rljMqcxZjOOYoGsr+IjzW2GUdX28+EplL5y0sKME4OTBfzFS5uLvcgqX5JHcUQGcBusHZT6eFxoFaWiug+Lvp0T8YtN+esVhjj5uFVG6sGxnwOB/wsju1bfmU2+rLzGBeELPSPyQZSSjOpLzX/Lgtmgs6PVBMlS8yZ7Lo4KtfX47zLexvzuG472PgNG0EDSqGpAvg5jEaDTXIi2R7epRMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVhlgOmKTu/T5Kk86biGdTpqhycGO04RP23EuxWl6IM=;
 b=T9juXUPinNWUJyJV+YG8g4Lz0yynKh933EMnH3MTCl0PRXwBMm/8qJZ2iGc6z4+uTqUSA7fu0SJq1YBla8QTNefKsq94ItMafulsuV49dyt9BP1rT5KZJeRPiLTmruODZr7lVszV3QZ+e+S5E9NhWsmr0Ns3mKuo/lthMTahrw1/yspmhkOztgW+/j/sdiHiIq/aAPjy/tH8yVm3bywszsgmKINJfPzqWALK5D5yHGIGgRKWSndx9TYiu6p0IjZFBsNf3JLrX8Mz9B0KqvkXsU6kWdkR/DBIzTdtjiI1RC0jmausdgQnzi0dWQLSyzaUcLeluVNGTzbLGjJZMKq2Sg==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by TYZPR06MB6725.apcprd06.prod.outlook.com
 (2603:1096:400:45a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 02:06:36 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 02:06:35 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 5/9] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1
 SSP SoC
Thread-Topic: [PATCH v3 5/9] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1
 SSP SoC
Thread-Index: AQHbuOfCgfrm1yugvkSpD/x7CrtlRbO7926AgAKZ4oA=
Date: Fri, 2 May 2025 02:06:35 +0000
Message-ID: <KL1PR0601MB4180A5FEDCA81D3E2B25E7CF858D2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250429091855.1948374-1-steven_lee@aspeedtech.com>
 <20250429091855.1948374-6-steven_lee@aspeedtech.com>
 <11b5a654-00e9-447d-8827-83702ec30ab8@kaod.org>
In-Reply-To: <11b5a654-00e9-447d-8827-83702ec30ab8@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|TYZPR06MB6725:EE_
x-ms-office365-filtering-correlation-id: 26847064-c5d7-4ff2-551a-08dd891df7b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGNUZjU4WWJNa0xKdVhnNGNCRndILzlmdnhFbXdXVkZFbHZiWXpuMS92akps?=
 =?utf-8?B?S3lJUEJEaTFOOWlaZmVEY2VDYStEajJtT0VMZExzUFFFQncrRWs2K3o5RTV4?=
 =?utf-8?B?bkE4OTdLbW9qZTlzUzZlZmZYM0dIZEFtZnRGSktXYU1STkN1clhrdHI5dngx?=
 =?utf-8?B?OHRjVFM3UHJIQ1g1NG1TNndzT3cvVDJXRktSdEE0VEc5RjhuaHRiT042cWJD?=
 =?utf-8?B?WVFKV1NiWUhwVmwweGdnVHcyYi9rN1ZtNDByWkozNlpDU2hRT1lGNWpFUXNK?=
 =?utf-8?B?d0FIa3VicEQxdy9FRG5UM0lGR3lIUzFqc2ZmY0ZuQ1V4VE9BZ09ocVBGelo1?=
 =?utf-8?B?NEpjRCsrODV4dkVLcXZOcEsxbzVXUmNBdDQ4NjNTSzhRRGV5ODRsVTFMU2Ux?=
 =?utf-8?B?V2dzQ3lvZmNJT0NsOHI4RHA4blNIQXBNckljSDVBK1J5Q1htUGZ3eGZwQ0Ru?=
 =?utf-8?B?a2FZb2RWek9MdTRtdXNSTktwSTRXenZXVWJCeTBGWnVISktaTjVOaUIzbEJI?=
 =?utf-8?B?OGF0TWxNSFNTK0drOXlJT0tMNnQ3NWJGWGlSSnZKTE92M0NxUWt6RFJwUWRO?=
 =?utf-8?B?VkM3Snpod1o4TUFFckxmRkhEcDNBNnNpMk1QUEMrbERNYU1KNGxPMFgxZi9Z?=
 =?utf-8?B?NTBLSnRqZ2VBUG5NN25zaCt1QnNjOTlUS2dZOWFKWG5BT1FXMDVNZEhQbkdR?=
 =?utf-8?B?MVduSWRsSUlPT1pNYlpCcHhHY0dyYzQ0MnN5aG9GaHd4ajZzSHRERDh4WVVL?=
 =?utf-8?B?SG91NUtDeW44N0hzSm9ONWZWZFpRdno3RWVFMUd0MTQrb2hoVVN0b3pDU04x?=
 =?utf-8?B?b3kva2w5bThKdmgxOENUbmZhSHBMakZsY0gzaEh2QnNVQk5iRDFhdzNaU1RB?=
 =?utf-8?B?cDJEUnVBVGtYRmdQWjhIellCODBJUi9aeTJtWDNDNVF3QXVjaHZLeGhwVE91?=
 =?utf-8?B?RnRDNnBWb0I4U1Y5VGp2UjlKWG0xeUpyR3F2OFBxYVVNaUJCTnlaT0N2dXRX?=
 =?utf-8?B?cnl3bktzbFp4S2xxREF6NHhrVVdmZ1JWdEhzbjBYdFVOelpYVEFtY0cyOVdO?=
 =?utf-8?B?S0RKb0gyeU5YbUpPakFQUjMxL1Jab1NzTnV6WEwxemVscUNFRyt3MXJlMUtE?=
 =?utf-8?B?WURBdGxRUWtnREZXQnlCZnFlQm5saHQvVmpNWXRla3VTaTgzWDU2NUlPTWxJ?=
 =?utf-8?B?QUtrN3BmeFplQlNKcHMzbWhuVzRXRjJPVTFJc3RwU0JFcnh6bnIyWElTRkNB?=
 =?utf-8?B?N1E4NHdaNWJsbUpZeE1QRXg1R3U1ODV6MlV5eVNHaGpaS3ppN0VydDFucTR1?=
 =?utf-8?B?MngyYkVSMW93b2FyeFFjNzhWV1VUNFAvQkpkbllzVlN4V3BOQjhONDB5WjJF?=
 =?utf-8?B?OUwvRU9NN3dmMEh3c0tueHQwaHlKWTNYRDBWL3V4SUhMQ0NDYVpLU09kODNC?=
 =?utf-8?B?UzV3RENnVmN3cUtiNmtCRFZJcjFvSkkzRUxKNjlib3VOcnZ6YjJSSG4wY3dF?=
 =?utf-8?B?YjVpRVpyTi9yNXRUWTJTQTBpN0ZhZ1owUEhGbFNpVlEzQnFMVHRjbUpsV3Js?=
 =?utf-8?B?K1VTdkJ5bFlaOW04engxUHZDRzRiQVJ5d2ZLL1cxMDV3eDhoNHVqOGt2T0Rm?=
 =?utf-8?B?NmYzK21nNkE5a01UV2hQQ3NFVHIxNVRTT3NSQThEYWpmQzlScU1xOTNYUUpJ?=
 =?utf-8?B?K01TajBBbTlnZjBvM1ZORi9jaTlVcjZmbWV2Sit3K3dRdXB3dnRHL2xxdldT?=
 =?utf-8?B?STZQVzk5bUdBT1VJeWpzQ3ZXeCsrNitRcHJRbzdZZXRoSk1NQlRDZ2JjQ3p4?=
 =?utf-8?B?Sy9mSXV3S05hK05wbDQrdlUwZDV6bkJYS0gySnZseWxDbXFibk9RRG1HYkhw?=
 =?utf-8?B?MWlSUXd3ZFpZeUVwNzk5ZzdWVFlDQzJndHEwR0lES1VKdnlCaVhrL1RWTmFy?=
 =?utf-8?B?a080MVE2RWJzaGVjZnZSaXh5ZXpjREdpM2pFV1JQbXRIRUthT0x0RFFZSWNK?=
 =?utf-8?B?dy9VSCtGVWtRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkhmVG4vNnNhY2YvdGUvWWJYYmZpeUZhejMybm05eGFMMXJFa2RrSDV5VXMr?=
 =?utf-8?B?SHlJTG53YWZSamozTzdtZ05mYXJVbjJSb0lLRzd5UCs0K252RUJqWTB0Q1h5?=
 =?utf-8?B?bUR2cm5VdDdOejkvV1BWVDB6UWJnVnFGQ2dBekN5VmcyaExrTDJZeWVCMDdx?=
 =?utf-8?B?eGZqdVdOZW8zUXJDNnFKRXFlK0UvREp0bmQrZFRIWGtyUXRldVc5cWVQQlcy?=
 =?utf-8?B?MVpSS2hrY2QrdWcwN20rYStwNXhqVTJwelp4ZkxEYWtnMTNEOThOR0dtbURE?=
 =?utf-8?B?SWFBVnM4QTU4cERZR0RVNjM2L1B3UWtYNTZCT1FsRlBLU2FjTnhCaGtmS2Zu?=
 =?utf-8?B?WEk2ejliN1ZXSjlhZTZrczA4TE5UNDkyM1RCVlRtRVhXeHFKaXpNQ1NvZ2pu?=
 =?utf-8?B?UmRnMCsvUnhJeWVjcmRFRWphMmp2UnB2SFp2SGphZnJ2Rmk0eEIzSGdwUUl5?=
 =?utf-8?B?KzhRMTBEWHVzdTgvL1VvRnVhYktUZ2pkOHM2VFFJZU5tbnRtS0VOK1M0cDUx?=
 =?utf-8?B?ZUl0dHFKTHFoVjh4U0lmcW1vZGFFOHltNEd4MjN0WnM4bGkrVnBYUnNOeVBq?=
 =?utf-8?B?MjBPZGJ0ODNFQ3BRNkdORHorNFMwd3F2WkhsRGVicGM5cXNXdm05ZXFMYzZq?=
 =?utf-8?B?aUdzdXBWWG5pZmpwZHp2b1o2eXFJMHBJK3hVcXAvTFpzWEhDY09CcS9yT0hu?=
 =?utf-8?B?N2tuekhKWjEwL0dmQlY2YkxUWEIzUU55VFhnREpZRzlHZTVlQ1R5R3B0a1ZH?=
 =?utf-8?B?UTh1aExDWTdtRlREUDVpR2xjTVBRN3hXN0dQOEx1bUlWU05IVW1WTVlqVXZP?=
 =?utf-8?B?c3V2dTBhVWNOMU5oUkU5Y2tzMUlTS1hobFRiUHRseCtqRHAxa3k2U01lbDQ5?=
 =?utf-8?B?bWpxOHI2dWdGRGhnQVVXTE55eGNFNjNYM2FMZDdlTVBmbDRnTmltRWo2YjNl?=
 =?utf-8?B?NzIzSlRWL3JPUGxMVW02QlVHbEVRbkZreUx1ZTBJY3ZreVRqaktUcXprbkJB?=
 =?utf-8?B?V3VJdFRCNWRqek40ZTd0VUU3VzFYdG9COFRkV2hHdlFUNlMyM1kvWWFtNE1s?=
 =?utf-8?B?OTYxQTZnOWVEcHVqM3A3NHh1b2hOQUd3dzdyMWR0L0xqa3h0WVN4azhyWWhp?=
 =?utf-8?B?MktrdFZweDBVcHJhb0o3K29ZM1dXbm50SVoxSHlleFZWNi9jZTNML242dTNR?=
 =?utf-8?B?V1VsVER2MTg0NFVPeDM0L0FhbVAxWGtBK1ZSYmd3WHdNUzNZZXdxUEY2RmtZ?=
 =?utf-8?B?L0F5anNCVjY5K2xpUTBqT3o3SjcxOFVLQzkyaVF4elpDTzBQekVrYWhRV3I5?=
 =?utf-8?B?RWdVMXROVlBGQUw2TGE0ejNvV1ZyQ2N0Y2lhZUxITlNZaUwrNHB5a0NSeWkw?=
 =?utf-8?B?bnpFcVhJUVJaakQzK25YWkNqcHMvdXhseFE5cy9LMjNNbFdGa20zalA1TTNK?=
 =?utf-8?B?SUxJdXVYaG1qTFZBYnVJS0RGcCt5SWI2d2tmV0I4L0l1ZU83QmJOaWRWa3BP?=
 =?utf-8?B?ZExIRTZDUWcveE9WNU45YnlrRk4wUFVqa0pIWDF4YnZQMWNUWkhPVGlha1RG?=
 =?utf-8?B?bGRpa0xuQzBIZWRzVFc0b3VYcm9sMUgwRDdqaHlwRGZta1FFdjVNamtycUVm?=
 =?utf-8?B?Z1Rqend0T3EzazRZY1pXMFNEcjNWVlVMTHBVT3pWTFlKckhlaHZDVHQwTktX?=
 =?utf-8?B?VTMxR3FXMUVmQ095aEtXZkxycVJoam01Uy9qZlhWT0NpYjNnblUrSzEwOFdH?=
 =?utf-8?B?dE9QNzU3Z2Fzamh0UzNralB6b05oWDBhbjZFZnFydklGSjhZeFNicndtdS9r?=
 =?utf-8?B?L2NrdEVkbVhlT3BFUVNGMHJRaXFRZDJieExKcGxJajJqd2Q3a28vdlVUTnVY?=
 =?utf-8?B?QVVKSUIySWc3bEpHMTdrdVZMTTBGdk94aVhVN05XM0VXQTBvMXNjWjJ4OWNN?=
 =?utf-8?B?eHUwanptWU93b29pa1ZzbFZqaVZJWk05K1haWS9vejFJOXhmaktFMDg0MWhP?=
 =?utf-8?B?SElzTzNjYVd4TFJsWFNNSUVXSzVpUnN5NFhOS09lRDRzVWZQaURCU2dzMHV3?=
 =?utf-8?B?R2VGcWduczVsZWtRSmJlVm5ER2xEcm5ITk0yTS85dkZibXNLcDFTSHlpTnRq?=
 =?utf-8?Q?V+kJHliYD6S+Sw2EdRKBV5wm+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26847064-c5d7-4ff2-551a-08dd891df7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 02:06:35.8953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWAlMXXPiRs6hJLM+4AaV7jLUytTOiGgqaOqVl+7dKoA0eIIB5Ynzr5AjEpbpN3heWNDjY/BYceMzV7jhA7/KG77Vh1vyk00Gacpbrx0Z9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6725
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=steven_lee@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMw
LCAyMDI1IDU6NDYgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFz
cGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDUvOV0gaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLXNzcDogSW50cm9kdWNlIEFTVDI3eDANCj4gQTEgU1NQIFNvQw0KPiANCj4gT24g
NC8yOS8yNSAxMToxOCwgU3RldmVuIExlZSB3cm90ZToNCj4gPiBUaGUgQVNUMjcwMCBTU1AgKFNl
Y29uZGFyeSBTZXJ2aWNlIFByb2Nlc3NvcikgaXMgYSBDb3J0ZXgtTTQgY29wcm9jZXNzb3IuDQo+
ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIEExIFNTUCB3aXRoIHRoZSBmb2xsb3dpbmcg
dXBkYXRlczoNCj4gPg0KPiA+IC0gSW50cm9kdWNlIEFzcGVlZDI3eDBTU1BTb0NTdGF0ZSBzdHJ1
Y3R1cmUgaW4gYXNwZWVkX3NvYy5oDQo+ID4gLSBEZWZpbmUgbWVtb3J5IG1hcCBhbmQgSVJRIG1h
cCBmb3IgQVNUMjd4MCBBMSBTU1AgU29DDQo+ID4gLSBJbXBsZW1lbnQgaW5pdGlhbGl6YXRpb24g
YW5kIHJlYWxpemF0aW9uIGZ1bmN0aW9ucw0KPiA+IC0gQWRkIHN1cHBvcnQgZm9yIFVBUlQsIElO
VEMsIGFuZCBTQ1UgZGV2aWNlcw0KPiA+IC0gTWFwIHVuaW1wbGVtZW50ZWQgZGV2aWNlcyBmb3Ig
SVBDIGFuZCBTQ1VJTw0KPiA+DQo+ID4gVGhlIElSUSBtYXBwaW5nIGlzIHNpbWlsYXIgdG8gQVNU
MjcwMCBDQTM1IFNvQywgZmVhdHVyaW5nIGEgdHdvLWxldmVsDQo+ID4gaW50ZXJydXB0IGNvbnRy
b2xsZXIuDQo+ID4NCj4gPiBEaWZmZXJlbmNlIGZyb20gQVNUMjcwMDoNCj4gPg0KPiA+ICAgICAg
LSBBU1QyNzAwDQo+ID4gICAgICAgIC0gU3VwcG9ydCBHSUNJTlQxMjggdG8gR0lDSU5UMTM2IGlu
IElOVEMNCj4gPiAgICAgICAgLSBUaGUgSU5UQ0lPIEdJQ18xOTJfMjAxIGhhcyAxMCBvdXRwdXQg
cGlucywgbWFwcGVkIGFzIGZvbGxvd3M6DQo+ID4gICAgICAgICAgICBCaXQgMCAtPiBHSUMgMTky
DQo+ID4gICAgICAgICAgICBCaXQgMSAtPiBHSUMgMTkzDQo+ID4gICAgICAgICAgICBCaXQgMiAt
PiBHSUMgMTk0DQo+ID4gICAgICAgICAgICBCaXQgMyAtPiBHSUMgMTk1DQo+ID4gICAgICAgICAg
ICBCaXQgNCAtPiBHSUMgMTk2DQo+ID4NCj4gPiAgICAgIC0gQVNUMjcwMC1zc3ANCj4gPiAgICAg
ICAgLSBTdXBwb3J0IFNTUElOVDEyOCB0byBTU1BJTlQxMzYgaW4gSU5UQw0KPiA+ICAgICAgICAt
IFRoZSBJTlRDSU8gU1NQSU5UXzE2MF8xNjkgaGFzIDEwIG91dHB1dCBwaW5zLCBtYXBwZWQgYXMN
Cj4gZm9sbG93czoNCj4gPiAgICAgICAgICAgIEJpdCAwIC0+IFNTUElOVCAxNjANCj4gPiAgICAg
ICAgICAgIEJpdCAxIC0+IFNTUElOVCAxNjENCj4gPiAgICAgICAgICAgIEJpdCAyIC0+IFNTUElO
VCAxNjINCj4gPiAgICAgICAgICAgIEJpdCAzIC0+IFNTUElOVCAxNjMNCj4gPiAgICAgICAgICAg
IEJpdCA0IC0+IFNTUElOVCAxNjQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlbiBMZWUg
PHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJOTI0YmYxYTY1N2Yx
ZTgzZjllMTZkNjY3MzcxM2Y0YTA2ZWNkYjQ5Ng0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9h
cm0vYXNwZWVkX3NvYy5oIHwgIDE0ICsrDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAtc3Nw
LmMgfCAzMDkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBo
dy9hcm0vbWVzb24uYnVpbGQgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCAzMjQgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC1zc3AuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2Fz
cGVlZF9zb2MuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IGluZGV4IGRkNWZi
NzMxZTIuLjdjNjUzMjQ4MDEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVk
X3NvYy5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gQEAgLTE0
NSw2ICsxNDUsMTggQEAgc3RydWN0IEFzcGVlZDEweDBTb0NTdGF0ZSB7DQo+ID4gICAgICAgQVJN
djdNU3RhdGUgYXJtdjdtOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICtzdHJ1Y3QgQXNwZWVkMjd4MFNT
UFNvQ1N0YXRlIHsNCj4gPiArICAgIEFzcGVlZFNvQ1N0YXRlIHBhcmVudDsNCj4gPiArICAgIEFz
cGVlZElOVENTdGF0ZSBpbnRjWzJdOw0KPiA+ICsgICAgVW5pbXBsZW1lbnRlZERldmljZVN0YXRl
IGlwY1syXTsNCj4gPiArICAgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSBzY3VpbzsNCj4gPiAr
DQo+ID4gKyAgICBBUk12N01TdGF0ZSBhcm12N207DQo+ID4gK307DQo+ID4gKw0KPiA+ICsNCj4g
PiArc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QyN3gwc3NwX2NsYXNzX2luaXQoT2JqZWN0Q2xh
c3MgKmtsYXNzLCB2b2lkDQo+ID4gKypkYXRhKSB7DQo+ID4gKyAgICBzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0IHZhbGlkX2NwdV90eXBlc1tdID0gew0KPiA+ICsgICAgICAgIEFSTV9DUFVfVFlQ
RV9OQU1FKCJjb3J0ZXgtbTQiKSwgLyogVE9ETzogY29ydGV4LW00ZiAqLw0KPiANCj4gU28gbm8g
RlBVID8gIEkgd29uZGVyIHdoYXQgImNvcnRleC1tNCIgQ1BVIG1vZGVsIGluIFFFTVUgaW1wbGVt
ZW50cy4NCj4gU29tZXRoaW5nIHRvIGNoZWNrLg0KPiANCg0KVGhlIFNTUCBjb3JlIG9uIHRoZSBB
U1QyNzAwIGlzIGJhc2VkIG9uIGEgQ29ydGV4LU00IHdpdGggRlBVIChNNEYpLg0KSG93ZXZlciwg
UUVNVSBvbmx5IHByb3ZpZGVzIGNvcnRleC1tNCBhdCB0aGUgbW9tZW50LCBzbyBJJ20gdXNpbmcg
dGhhdCBmb3Igbm93Lg0KDQo+ID4gKyAgICAgICAgTlVMTA0KPiA+ICsgICAgfTsNCj4gPiArICAg
IERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ID4gKyAgICBBc3BlZWRT
b0NDbGFzcyAqc2MgPSBBU1BFRURfU09DX0NMQVNTKGRjKTsNCj4gPiArDQo+ID4gKyAgICAvKiBS
ZWFzb246IFRoZSBBc3BlZWQgU29DIGNhbiBvbmx5IGJlIGluc3RhbnRpYXRlZCBmcm9tIGEgYm9h
cmQgKi8NCj4gPiArICAgIGRjLT51c2VyX2NyZWF0YWJsZSA9IGZhbHNlOw0KPiA+ICsgICAgZGMt
PnJlYWxpemUgPSBhc3BlZWRfc29jX2FzdDI3eDBzc3BfcmVhbGl6ZTsNCj4gPiArDQo+ID4gKyAg
ICBzYy0+dmFsaWRfY3B1X3R5cGVzID0gdmFsaWRfY3B1X3R5cGVzOw0KPiA+ICsgICAgc2MtPnNp
bGljb25fcmV2ID0gQVNUMjcwMF9BMV9TSUxJQ09OX1JFVjsNCj4gPiArICAgIHNjLT5zcmFtX3Np
emUgPSBBU1QyNzAwX1NTUF9SQU1fU0laRTsNCj4gPiArICAgIHNjLT5zcGlzX251bSA9IDA7DQo+
ID4gKyAgICBzYy0+ZWhjaXNfbnVtID0gMDsNCj4gPiArICAgIHNjLT53ZHRzX251bSA9IDA7DQo+
ID4gKyAgICBzYy0+bWFjc19udW0gPSAwOw0KPiA+ICsgICAgc2MtPnVhcnRzX251bSA9IDEzOw0K
PiA+ICsgICAgc2MtPnVhcnRzX2Jhc2UgPSBBU1BFRURfREVWX1VBUlQwOw0KPiA+ICsgICAgc2Mt
PmlycW1hcCA9IGFzcGVlZF9zb2NfYXN0Mjd4MHNzcF9pcnFtYXA7DQo+ID4gKyAgICBzYy0+bWVt
bWFwID0gYXNwZWVkX3NvY19hc3QyN3gwc3NwX21lbW1hcDsNCj4gPiArICAgIHNjLT5udW1fY3B1
cyA9IDE7DQo+ID4gKyAgICBzYy0+Z2V0X2lycSA9IGFzcGVlZF9zb2NfYXN0Mjd4MHNzcF9nZXRf
aXJxOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX3NvY19hc3Qy
N3gwc3NwX3R5cGVzW10gPSB7DQo+ID4gKyAgICB7DQo+ID4gKyAgICAgICAgLm5hbWUgICAgICAg
ICAgID0gVFlQRV9BU1BFRUQyN1gwU1NQX1NPQywNCj4gPiArICAgICAgICAucGFyZW50ICAgICAg
ICAgPSBUWVBFX0FTUEVFRF9TT0MsDQo+ID4gKyAgICAgICAgLmluc3RhbmNlX3NpemUgID0gc2l6
ZW9mKEFzcGVlZDI3eDBTU1BTb0NTdGF0ZSksDQo+ID4gKyAgICAgICAgLmFic3RyYWN0ICAgICAg
ID0gdHJ1ZSwNCj4gDQo+IFRoZSBhYnN0cmFjdCBjbGFzcyBkb2Vzbid0IHNlZW0gdXNlZnVsLiB3
aHkga2VlcCBpdCA/DQo+IA0KPiANCg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCwgaXQg
d2FzIG9yaWdpbmFsbHkgaW50cm9kdWNlZCB0byBzdXBwb3J0IGJvdGggQTAgYW5kIEExIFNvQ3Mu
DQpBZnRlciBkcm9wcGluZyBBMCBzdXBwb3J0LCBJIGZvcmdvdCB0byByZW1vdmUgdGhlIGFic3Ry
YWN0IGNsYXNzLg0KSSdsbCBjbGVhbiBpdCB1cCBpbiB0aGUgdjQgcGF0Y2ggc2VyaWVzLg0KDQpS
ZWdhcmRzLA0KU3RldmVuDQoNCj4gPiArDQo+ID4gK0RFRklORV9UWVBFUyhhc3BlZWRfc29jX2Fz
dDI3eDBzc3BfdHlwZXMpDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9tZXNvbi5idWlsZCBiL2h3
L2FybS9tZXNvbi5idWlsZCBpbmRleA0KPiA+IGFjNDczY2U3Y2QuLmFlYzBhMGI5OGQgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvYXJtL21lc29uLmJ1aWxkDQo+ID4gKysrIGIvaHcvYXJtL21lc29uLmJ1
aWxkDQo+ID4gQEAgLTQ0LDYgKzQ0LDcgQEAgYXJtX3NzLmFkZCh3aGVuOiAnQ09ORklHX0FTUEVF
RF9TT0MnLCBpZl90cnVlOg0KPiBmaWxlcygNCj4gPiAgICAgJ2FzcGVlZF9zb2NfY29tbW9uLmMn
LA0KPiA+ICAgICAnYXNwZWVkX2FzdDI0MDAuYycsDQo+ID4gICAgICdhc3BlZWRfYXN0MjYwMC5j
JywNCj4gPiArICAnYXNwZWVkX2FzdDI3eDAtc3NwLmMnLA0KPiA+ICAgICAnYXNwZWVkX2FzdDEw
eDAuYycsDQo+ID4gICAgICdhc3BlZWRfZWVwcm9tLmMnLA0KPiA+ICAgICAnZmJ5MzUuYycpKQ0K
DQo=

