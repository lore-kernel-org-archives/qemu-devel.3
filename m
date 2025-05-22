Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A1C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI1pa-0002hx-0u; Thu, 22 May 2025 05:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uI1pW-0002ha-S4; Thu, 22 May 2025 05:03:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uI1pU-0000p0-3C; Thu, 22 May 2025 05:03:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFGIpXKtJoiq/q1yv4AZNSabBE4FHPWo87xRNCjJL8wzBqflVixIEeHDlH4I42zWNt52Mg7EOnBskkDhQfq4OI5wbapN5zh28GznJlcuQYeoRvWShL3kZvDGeqfsM/qu8q0BNoUX522U0jtwvaZgYNoHdxdDqHd/WibZshhF8su2nVa0MKsYVcJpSK8nRnFv9qr3wx+aCBP0h74iHEFewgOnx+Kg2X13bTIdmYlVtp7Cj0XcKJTbb+SzJRRwsSQZWEeHOBYF2bP0DHUkH9yLDFrYo9jYBdclA4Wfsx3vOGg866GT0kj+H8koje43rxUQgmcWKr2gIQ0n58VMYJSZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha4smQpe6blHY/7vxomgE9uITpvf79KpOWAQ2V286Xc=;
 b=BtpXJBEYTEMRJ7VVgGd9Qghy/FxgAb2+EnO6xpxCC9PrV0cUHj5jXtEWW3frsmtcCL7EoK/u0Lmn+0Gwb4X7lzUG3BNEI/kHFmDdP7g6d3Lwd4HSv7Tt9PQtaqMPMrw3TXfhb05QlsogRepFCLg9NRKHDCsECA7Ix+2B5EGKz8rgHtgR0CPt9F9QJs3bS7HzIlSRS0QXwg8y6vVFeaJR6g2EcZBZLqmhGeRJl9T1/n3Nkw//M67agZNXavkQMeaxWTYR61noLioq+x6LcZ8uOVHFnGsI3Gm2CQQWoLT/34dDmSN2OyIxA4++PVMLlTPWAlSt1ZXT2rhKry8hnlB4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha4smQpe6blHY/7vxomgE9uITpvf79KpOWAQ2V286Xc=;
 b=AjKbOZKbiBvGPCFFdE7MDEQ2ra2N+pelYoFTBCmbj1xRw0Hig0YNMXSAW6QSdnma/2gQkRXp/lJIR/maA4V0kWGVsNZSQaL0ycqXeO0FJODBsf0czQPZAbXb8Q2Cr9hOGmU9g6up9kTtLFaePsrhBSasTUVerhfAbgwnz0dE5+tw7qgRmPab+vlXm4i/y8XXob5vo8KX/GokBeBL2NeGCyZ3Ygj1rYcVeRyXPFBwK/EJqnxTlEybqW2huk82OZuzTKlLxfz0svmmMtDcWQceYHeeHI2bU5JioYqILb4WrC8GI1SYUvhlQIjBhp2bI//kyGDzEwTCUScmPyIRPw6Zlw==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by TYZPR06MB5225.apcprd06.prod.outlook.com
 (2603:1096:400:1fa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 09:02:59 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 09:02:58 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 1/5] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Topic: [PATCH v3 1/5] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Index: AQHbysq48ta26MTr/0WfB0ez5DM927PeRxcAgAATsqA=
Date: Thu, 22 May 2025 09:02:58 +0000
Message-ID: <KL1PR0601MB41800BFA6FF47C9113BAF9C38599A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250522033628.3752086-1-steven_lee@aspeedtech.com>
 <20250522033628.3752086-2-steven_lee@aspeedtech.com>
 <f88ca20f-ec6b-486a-834f-5c7eafa3baaa@kaod.org>
In-Reply-To: <f88ca20f-ec6b-486a-834f-5c7eafa3baaa@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|TYZPR06MB5225:EE_
x-ms-office365-filtering-correlation-id: d96510b1-578c-4d98-6048-08dd990f72e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WG4yVGRZQmpSYmpLai9iQUVrTXBFWkJFUkpDRTBGNUZrdHMxNkhEZEN5aTFC?=
 =?utf-8?B?cEhPTldEbXJ3UGM5M2k4VExRRnZvVHQwSUlZaW0yejZjK2JZSUFtZ1pwS05H?=
 =?utf-8?B?SHBwcVpseHpDclJSYjkwb2pKSTRZKzZlZFZadFhtR1dRU1V3VDVZTmxlVFVw?=
 =?utf-8?B?eVd1RjJsZ2FsOGw5RGZVM0JqOHJUZEwwTGxLc3k1YWJtc2FPU0lMTjY4Z2M0?=
 =?utf-8?B?bm5xNjNGRGlKL3p1b2tjYWdPSG52R3lROHR6amh0OUNDcmVva05GL1NEV1Jh?=
 =?utf-8?B?YkNPc09hRVJ4anBRZ1BxbEV5N2IrOWRYdXpUYjhtNHJZUndOWndhSHdROGdG?=
 =?utf-8?B?dTBOMVFLYTRjV1pzcklzeVpKRzFsMW11cHM0KzlwOFBRcGxRSjROQUZYMnZ3?=
 =?utf-8?B?amN6RER0aHNkRU9XQm5aQXZDQ0tjTmNHb3dMK2JCOStUaEtOU1VvYytBS1px?=
 =?utf-8?B?emd2T3VqRTVQMzJRaTRHS1pNandjVXBMWWI5WWpCOWdaTXZuL0VuMW5HZVVU?=
 =?utf-8?B?aXBVZEFXOHpBa0lOeStwSU16c1JHV1lwcVBpdTZUc0lPTmtFUW9CU1c5NVlX?=
 =?utf-8?B?RGE0OE9hQXV5UEtyR25DMnVZa0F0bmM3MnIxMlRrOXkwcDZXSVJUWTZzMnlP?=
 =?utf-8?B?a3NJaEtHNkRWQzhPRERrNlU0V3VqOGJLSFJoRjVvNUlhaUxVR2lVQm1yWTZE?=
 =?utf-8?B?RXlZRW50SUdWQ0x3VmpCcVpqYm1HRldobXY4TnBCOURFOVlzc3YyOVBpaTZ2?=
 =?utf-8?B?NW5oVWdKRlV4anRMR0d6NmdZUGNTYUZUejBMYVZkNWVNNnlodHJtTmFSZElR?=
 =?utf-8?B?bi9UQStmaytsR3ZOTDBzUGJIc1ZmR21DNWx6U2JoSDE2RzJGK0o4ekhvTDRt?=
 =?utf-8?B?UWx6ODIzSWc0aVFYTWdmdUJiMUZUdVpnUlJQbThyOFlSQVV4T3ozT3ZHT01W?=
 =?utf-8?B?cUxVcGFVWWdpanhTODFaUDYrVnBiSmFwbE1pRmR3a09jcUtVblJHVU4zblZS?=
 =?utf-8?B?VGlhNWxhNURPdGRCUHhjSlljbnA4Zm50VU5sTytsd0FSaXhJQ2ltcWM5Zk11?=
 =?utf-8?B?Zy9VV0MwMFQ3NkF6emFQYjBHRW5ZY3BHOGx4OFloTkdTc2pNYWtYOW5yK3Br?=
 =?utf-8?B?aVBMeDdORHZ2WkpDNmlnSU9xRGhKOE5UZFZZS3VaZEJoSnEzd1VWWHR3THlS?=
 =?utf-8?B?MHQrV2U5WW9lYkI1dGlXTzRJcGxjbldubXNhcmdNekQzOVR4dTVhUmoxb2hE?=
 =?utf-8?B?N3pCbjJFTXVkUXhMYjNGVThYUStFU2xYRHdRRkYzVHI3RTJkd215NTdSUkY2?=
 =?utf-8?B?Sk5OMUUxc09QMVY2V2cxYUZJNnlDdmlrMU4wdjU5MHNxRCtVNUVGN0h2dXM5?=
 =?utf-8?B?WTBReVcvdlJkcnhydE5wSXk4ekVqZmQ5eDJpdGdZcDdDaTIyUlJucXFNdUxi?=
 =?utf-8?B?OWtBNjBoMHlXRlZCT2luSkczZk9VT0tlcU5WTnEyVzU5TkRCYjQvRzJYMVhU?=
 =?utf-8?B?enZhZ2NFWW9MbXNQMkFEWFJoN21CMjV2UHNBZjhNeFVmbE9xK2xydlI2aWk1?=
 =?utf-8?B?UDdZb2VoN2Q4OGQvU1Nrc0ZoR1JqTkFEVUdmdFVNN3F3R01UNEhWdVE1bUNO?=
 =?utf-8?B?aWZvQU5YeElDaFpyMVJTMkdJRFA0WUttbEwvT3gxRkNFczBUM2RDeEFscEhq?=
 =?utf-8?B?SDYvM3h1OFRnVlhhZnJRd3N5T1ZZazcyZUdCNW9zd0lpZWxiL3BzOUw5bmJG?=
 =?utf-8?B?OXoreGpiQ3M4ZmQvZjFOVjZYdDRVUzBzNDhqeWExbjQ2a2hwNDRzOXBJSEd4?=
 =?utf-8?B?ZUZrK1lPc3FNd0FDanRQWlFsbUF4U1YwdnhCZWQ5WUNZS0t0OTM1VDFhVGlr?=
 =?utf-8?B?RUpoT1UvZWxBNkh0SW5QZVUzZktsN2Q0V2pCZnhlUlYxMXdvMXk0QWRjZGZD?=
 =?utf-8?B?UlRUU2RHTjBXb3NRRUJrK1RicStRa3d2Mmd4am9WVkNtaE1PVElxeWhLYytD?=
 =?utf-8?B?WGFjTDk1dmZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJrcGFJeGwyaW9DWFVvTU1vOTh2ZHVjS3JqaWVyeWkzejVmcWFWcFc4akpP?=
 =?utf-8?B?VVEvN05sTFZFU0tCRXUwTng4bGRrYlg3WEVWUmVhRFZuVHhaQTJsUGdlY0lD?=
 =?utf-8?B?T2x3YjJlcUJnTlNzWUVNWHl6S01ZTFIxdnZVQmR0aWpCdFIwelJSZEEzZXho?=
 =?utf-8?B?WFhQSGM3MDVYYU1CNnRacFMwNHVhbHM3bEtwcnhrT0s0ajlEQVBEUFF3K0Ro?=
 =?utf-8?B?VVY4QXptYm0xMWx0OXh0blRKNUtVZW85bDZYSTFKMUlxQ3E0MElVb3ZzMG8v?=
 =?utf-8?B?NmFET3JQMlE4MHVEWVVCUjF1Z09GckNrUmUvUmZ3WXlDYlhvR0xYSEJLS2d5?=
 =?utf-8?B?N215dVJIS1c0ZDBkUU9pL2IzQkFlc09yY2djZ2VIanp5cENzNTJ4Mk1hcFR5?=
 =?utf-8?B?V2lKT1JESjBKK2k0WERzTVlLVDlNN2t1K3VPL0t5OTM1Nnphdkx2d05UcUNo?=
 =?utf-8?B?b3diMkpRdm1ESy9xSjM5aHZ0VWJLaTRTdm1HMUR1L1FldnR6dythbzJ2bUZn?=
 =?utf-8?B?RlNCS1lmd3pKN2dRN3htMWtmck1YZ0ZrTlgrWWF1SCtzRTFxSWhCRmZTelho?=
 =?utf-8?B?ZjJvRmNrZjZUZWZuL0d2SFhqVVFSeFJPajh6aGRtVU1WMWZ5TmkxU2ZCSFR0?=
 =?utf-8?B?MURkUGFXamhuUEhYZXFoK2tJa2NBV29nNnhiSVpVY2NXWEVHUlBwWG1wWVd3?=
 =?utf-8?B?bjR4bzVlVnVwYmF6TjBUUFQ4ajg4cktjV0NZV05HS3RCN2ZTcExOYVh5bXBI?=
 =?utf-8?B?SEYyUVdUTzZxdmdlcWo2dnRDemFFS29NcFVkS082ZkJZT09hdFZiaVBoRkRh?=
 =?utf-8?B?ajdUUk1WN1E3RUJXNWhhcU1sazlxT2NIWkdTS2wvbHpQbXprSnY0U0gyV1c0?=
 =?utf-8?B?M1l4dXlVZUxibjkxNXdHRHlSZkdhVytqRUg0VTQ1ZG5mYWdDRWsxciswOWIx?=
 =?utf-8?B?VWdZdVd6akowc0cxVW9CZVZQa3M0TDN6V21SczVvNEhNeUhrdjVoQld5WTVB?=
 =?utf-8?B?ejRWcVEzSzdXdU1zdHBaMlpmOGVIREtjUGlGb3ozbklnNmdnc215bXhDOFNW?=
 =?utf-8?B?TWVWOTVHTjNDSDhpemkrNlZ0UEtCYzdHbDNNY1JsS0VGcDk1RUtndU5tMGJ2?=
 =?utf-8?B?T3MwQUZKUHlVWjB5dFhGVk9TUWtIZ0l3SXNoQ1B3SG1VWHVFTzlySlhBN1BO?=
 =?utf-8?B?dGNpbXNjRzFLQXBGR3FLN1Q2Yit4anVSb3V6ZFB1MVJNSmtnejNGWmduVy9Y?=
 =?utf-8?B?Z1FsNkFvOXBrUFppQTVWbUlYUkEwenRZc0pSaDcwT1RUWTJWZUxEc1czOG5X?=
 =?utf-8?B?Vk9VNnp6c01xZEpERi80Tit4L1pGM3pERkE3Q3pmSzNEZ3dWam1DVVZUMTNj?=
 =?utf-8?B?MlZmL3diVjBjK2FiN2E1aHpnQTFJN1lrdHUvYUJIS1EvSEtLMWFqZURXZXpY?=
 =?utf-8?B?TEJ4WkluZis5MktmUE5hdjBuVWZ0ank5cWRGQkJKaC9pR0JpcVF4VkFOVEpj?=
 =?utf-8?B?dlloQjFoU3NuUE1qYlZaVzlKamRtVjM5WEdjUFhhZWQ2UlJBWmd5RTA2UlRx?=
 =?utf-8?B?WHZMMFh6UEFkbHJaRFNEY2tiQnV1M3hlS29nL2ZKSmNsUzVGMkE4NHQwM2Qx?=
 =?utf-8?B?TUpKTzJaL091d1dKZFNucnFPcVY3Qi9iTEF6U3VaQWdhZnRUNCtTWW5SRGk2?=
 =?utf-8?B?UGphUG96L2lpY21Yc1kzZjZJdGtaa1czTmVXbW4yb1lQZXo3ZjR5MHpxazI5?=
 =?utf-8?B?amVVdjhleUZNUDJhMnJyK2RkUE11QjN4U0dRb1RCN3BIODQ0WGxJaFprOWRt?=
 =?utf-8?B?d09sclNPdVNEbHhuWjlUZzZMYlU2djdWM3R0bDN3eGN4Q1FLWUNick9OTjdj?=
 =?utf-8?B?NSt4T0Q5d1QvV1hZakN3ZG9lS2xFdnY1VTlmM0k3RFNETEtNeHl5N1lycFBK?=
 =?utf-8?B?Sm9MUGF6RUxCOHdHaEk4RHprQlVVL2lTb08vQW5KUGRoUFpGRFFnalpmbnRr?=
 =?utf-8?B?Z1dsS2taM0tQdWMrWlR5R3VoNUtsNmRmUDN0Nkw3V3FzM2VUazk0YUxkcVcz?=
 =?utf-8?B?TlRNZCtKZ2tsd1RXUk4xMnZkUVZvWWhReFc0VE1XSlYwVks0a2tKT0Z3Z2dP?=
 =?utf-8?Q?rZoyYJt9FFmPvZqGl25sy5j7q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96510b1-578c-4d98-6048-08dd990f72e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 09:02:58.7529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ie1ss48pic1ruCa3XBXaRLPceNFvFVOT+TPd+YLEuzzMsaFNvKdk0TkDsXOfAbKr6yTXJlz2lTd7sqtcdnKQO1tJvtgLcS7dixSp/ebd6K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5225
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=steven_lee@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDIyLCAy
MDI1IDM6NTIgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+
OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExlZSA8
bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2Vs
IFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11
LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNv
bT47IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFzcGVl
ZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNV0gaHcvYXJtL2FzcGVlZF9h
c3QyNzAwLWZjOiBGaXggbnVsbCBwb2ludGVyDQo+IGRlcmVmZXJlbmNlIGluIGNhMzUgaW5pdA0K
PiANCj4gSGVsbG8gU3RldmVuDQo+IA0KPiBPbiA1LzIyLzI1IDA1OjM2LCBTdGV2ZW4gTGVlIHdy
b3RlOg0KPiA+IENsYW5nJ3Mgc2FuaXRpemVyIHJlcG9ydHMgYSBydW50aW1lIGVycm9yIHdoZW4g
Ym9vdGluZyB3aXRoICctbmV0IG5pYw0KPiA+IC1uZXQgdXNlcicsIGR1ZSB0byBhIG51bGwgcG9p
bnRlciBiZWluZyBwYXNzZWQgdG8NCj4gPiBtZW1vcnlfcmVnaW9uX2ZpbmQoKSwgd2hpY2ggc3Vi
c2VxdWVudGx5IHRyaWdnZXJzIGEgY3Jhc2ggaW4NCj4gPiBmbGF0dmlld19sb29rdXAoKS4NCj4g
Pg0KPiA+IFJvb3QgY2F1c2U6DQo+ID4gLSBNaXNzaW5nIE5JQyBjb25maWd1cmF0aW9uIGluIHRo
ZSBDQTM1IGluaXRpYWxpemF0aW9uLg0KPiA+DQo+ID4gRml4Og0KPiA+IC0gUmVkdWNlIGNhMzUg
cmFtIHNpemUgZnJvbSAyR2lCIHRvIDFHaUIgdG8gYWxpZ24gd2l0aCBhc3QyNzAwYTEtZXZiLA0K
PiA+ICAgIHdoZXJlIHRoZSByYW0tY29udGFpbmVyIGlzIGRlZmluZWQgYXMgMUdpQiBpbiBpdHMg
Y2xhc3MuDQo+ID4gLSBBZGQgbmljIGNvbmZpZ3VyYXRpb24gaW4gYXN0MjcwMGZjJ3MgY2EzNSBp
bml0IGZ1bmN0aW9uLg0KPiANCj4gDQo+IFBsZWFzZSBzcGxpdCBpbiAyLg0KDQpXaWxsIHNwbGl0
IGluIHY0DQoNClJlZ2FyZHMsDQpTdGV2ZW4NCg0KPiANCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
U3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3
L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jIHwgOSArKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5j
DQo+ID4gaW5kZXggMTI1YTNhZGU0MC4uZjhjYjYzMmJjYSAxMDA2NDQNCj4gPiAtLS0gYS9ody9h
cm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1m
Yy5jDQo+ID4gQEAgLTQ4LDcgKzQ4LDcgQEAgc3RydWN0IEFzdDI3MDBGQ1N0YXRlIHsNCj4gPiAg
ICAgICBib29sIG1taW9fZXhlYzsNCj4gPiAgIH07DQo+ID4NCj4gPiAtI2RlZmluZSBBU1QyNzAw
RkNfQk1DX1JBTV9TSVpFICgyICogR2lCKQ0KPiA+ICsjZGVmaW5lIEFTVDI3MDBGQ19CTUNfUkFN
X1NJWkUgKDEgKiBHaUIpDQo+ID4gICAjZGVmaW5lIEFTVDI3MDBGQ19DTTRfRFJBTV9TSVpFICgz
MiAqIE1pQikNCj4gPg0KPiA+ICAgI2RlZmluZSBBU1QyNzAwRkNfSFdfU1RSQVAxIDB4MDAwMDAw
QzAgQEAgLTg2LDYgKzg2LDEzIEBADQo+IHN0YXRpYw0KPiA+IHZvaWQgYXN0MjcwMGZjX2NhMzVf
aW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBBU1QyNzAwRkNfQk1DX1JBTV9TSVpFLA0KPiAmZXJyb3JfYWJvcnQpKSB7DQo+
ID4gICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgZm9yIChp
bnQgaSA9IDA7IGkgPCBzYy0+bWFjc19udW07IGkrKykgew0KPiA+ICsgICAgICAgIGlmICghcWVt
dV9jb25maWd1cmVfbmljX2RldmljZShERVZJQ0UoJnNvYy0+ZnRnbWFjMTAwW2ldKSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgTlVMTCkpIHsNCj4g
PiArICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICAg
ICAgIGlmICghb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5jYTM1KSwgImh3LXN0
cmFwMSIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBU1QyNzAwRkNf
SFdfU1RSQVAxLA0KPiAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gICAgICAgICAgIHJldHVybjsNCg0K

