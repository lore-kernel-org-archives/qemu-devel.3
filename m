Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324ABC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 05:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfuEw-0000l5-NS; Thu, 06 Feb 2025 00:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfuEu-0000kn-5F; Thu, 06 Feb 2025 00:15:48 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfuEr-0001n4-Hb; Thu, 06 Feb 2025 00:15:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJg6eP54LizjN9CjRC+Mg5fhQE+IbLdDdVm9RnC3eam/QOCio/QJW8LK40onEl740/+iWpCNHHyf0arsUUrBXaS5lDBhhjToKJyiyYLBHHw0M89o+TqNcEbr5SZ5NGS3It6pL18qrHp6m+9nu433QpzAcStdu8+VzO4PEYW6TdDkjjtuRtHG7U47Yd3Ugs8XVj6nqr38RvILokSAWt3OHEb5Raixtid+uWtcYHXmb39gFfHgQfp6uGPO0Zh+z4MbMdJLWial7jepnH3YvYKcvB9+Jli8LFfHTgOIdFTZQdTtlXp/ycBM4nsDGY6LT9swe/YmVPzU81ZJNX0G6D7ATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSvh3wvW94ZAEFxehc9KxboM4ysyWVm3yhOHy1Wl62g=;
 b=c+dntRVhxwTM2otIs3ZoM2m1rSaXuzVcISM09ScB+xRZzG3ir8cILKr9Ou/rkDk9944V93Lzx96iz0bYzVRmGdGeDOMxh7NH1kbHpZ33xI9q14U/yqm/2t4prYY9kSdEYNsGm1ynh+GJGk9Y9CD/oDSZLskr+nK+jpeUMotsd/S4SNRJTJVbCYxlOj+J3flf6pI9fEXQ7QZe9BMFm2hd3A5rquSRrErQ2RkzzIi/96mgfCEZt5DyzBYIScd08ljjlD6oVG7W7lEcKEZC8buD5HRF5CT9fkVbmaPOdtOKo9j1Lmdk3WlC6XRkRwyxPGqYhHRXiMTw3zSW9hn/TK1BfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSvh3wvW94ZAEFxehc9KxboM4ysyWVm3yhOHy1Wl62g=;
 b=PBADETQ8U1AAqNOrpfn8C6ua8KD6AZCICjBDMuk9ZX0ToY2jUzWjXk4EUReayrytd9V5dboyoQftS7BRNVkYAocgD37jQoCbMo3uQt3OxJN9tnvj3trMT+eXcSGz1qECO5fYwql6itnCKaZarDswfA58ST8oYNfZRUHsogvaaCrxH287oqzpe/m8lvEUjyeQ5H0fJuvTO0nmIVUKPSPcQZuy+VbFqWvQieQRxmhZN1kZq4mF1XmP7o2O3JZDNK0T0+oSMsP9WqMwEyjgelyEgL9bc27Q7HKLIygOrbJRYfWcy773Nv7vZM9VjO98cmoConBwg2iarjY/wdZAtqg7NA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6244.apcprd06.prod.outlook.com (2603:1096:400:35c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Thu, 6 Feb
 2025 05:15:34 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Thu, 6 Feb 2025
 05:15:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joel Stanley <joel@jms.id.au>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 12/18] hw/arm/aspeed_ast27x0: Support two levels of
 INTC controllers for AST2700 A1
Thread-Topic: [PATCH v1 12/18] hw/arm/aspeed_ast27x0: Support two levels of
 INTC controllers for AST2700 A1
Thread-Index: AQHba9LAR+6tJtZgg0OzH5hIXoiXmbMuxMkAgAgoeYCAAT1PgIAANmFAgAEVwoCAAFhTgIAAA6Pw
Date: Thu, 6 Feb 2025 05:15:33 +0000
Message-ID: <SI2PR06MB5041B6BB13FB75F73E0DA27BFCF62@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-13-jamin_lin@aspeedtech.com>
 <cb18b72dbfce3a606a4bd7ea41732d451fbea0f1.camel@codeconstruct.com.au>
 <SI2PR06MB50414F9067112317161AD907FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ad26f753de3648a2b238514ac7136847a2ae3a71.camel@codeconstruct.com.au>
 <SI2PR06MB50410511510D84B854672E8CFCF72@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <64d943d2e53c70ca55b33ec7a9b103368d72acc0.camel@codeconstruct.com.au>
 <CACPK8XfaJKPObz+FuRQhP7SSxPCV+KNaeFgT+U0id6HhYQ0Fdw@mail.gmail.com>
In-Reply-To: <CACPK8XfaJKPObz+FuRQhP7SSxPCV+KNaeFgT+U0id6HhYQ0Fdw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6244:EE_
x-ms-office365-filtering-correlation-id: 9b40ef6a-dc47-4353-3e2c-08dd466d4885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZE9WTU9IeEo4b2JqZDdnd3l5V0RmTnVidm13S01FVmw4eXd2b1k3OXMzczJH?=
 =?utf-8?B?bDA4dmVvTUc3TDAwbzJlWjBZdWtOM2ZhaS9EdDY3ZG1VWTdWdFgwQ0dYQWxk?=
 =?utf-8?B?U3ZPa1dPTzhlRmx6SEF5NWs0TUtmV1l3enV4VldiNS9lempWdFo0dnVyb0Nk?=
 =?utf-8?B?eEIyZ3dZYW52TnM0NC8vaGpmTHUrRGNXOGhWRGEwbGZvQUQ5QklMMDJVWW9X?=
 =?utf-8?B?ZGlkM2NpeG1FQlZwU3QzR0xwMXFoVnJ5V2RkS01LYmlLQlYya3Q0SUtmcGtL?=
 =?utf-8?B?Z0Y4Y3BvMjZmY0lSVEgzdHY0N3ZFbVoxbWlra3FyUmV4VmNnVmlRM0FGbFl1?=
 =?utf-8?B?eW5pZTZXS1l5QjdpbFRuZExDNGJ3dUNMOEVhcnJNK3Rxd3RsalF6SGluVmZn?=
 =?utf-8?B?SW9XYWltSnhpSDNRSU50NFlhM2IwQUZXUldwK1NCaGl2S1oyYTNmdVFmTmVW?=
 =?utf-8?B?QUtwd2U0ZWZzMEUxU1poNTBjUXVHM3RYSlErOThGamxrWUp1Qk1QWDIzNXdD?=
 =?utf-8?B?aXRQL2dQT1VGbVNYNTRjT3hCcmJKWmN2anVvWVpjYUhkSDA1QkFXakp6c0Fv?=
 =?utf-8?B?Y1BDWm8ySFQ4TWU0MnhEQldRVWRKMkRuK1ZaKy9iNnkxdjZFVGdLMEFWKzRS?=
 =?utf-8?B?dVNuNU1McGRQQlZtTlVYd3VQRmZjN1IrbG9zaUpRZmNPZHVHLy80ZHBXNWk0?=
 =?utf-8?B?TzV1Y0tReitJTStwd1p6Nng0YnA4UDdZb0VDRWQ4N1c2cjJZWVlEZXh2Y0xm?=
 =?utf-8?B?N1dFQ2lpR2svTkR2VHFra20yZnNRbGJtSEl6UHVhTTJacXpBcjJHaDI0dVI2?=
 =?utf-8?B?c0tWT0NJVXJCZmxrYnN2MkhJWGMrQ3VRUWkrU2ROWFpaNmdlaHA2UUV0ZHp5?=
 =?utf-8?B?SzhjdlEzMkZHeUFYMUZzSmpwQzZYK1VZbzBZbHZmQmIvZGFYbzlMck1oWnhP?=
 =?utf-8?B?L3h0RlZCVDM4RGJDTG9JcE5URUNUdFZIaDZTS3krYWZhU3I0VUh2bW9lZC9a?=
 =?utf-8?B?NFY4NlhtK0VBbFNQeC9VODI5d05kcy9pY0ZodTdScTRPMDF2YWxpMWd1SWRk?=
 =?utf-8?B?cytRcTVrTWdVQTNFSjdteHRrUksvM25SdXJUc09yZFBaV1Y4UkErcXJXUEkr?=
 =?utf-8?B?aHB0N1NlL2tUOVNmdVZTVzNmSlpydWJyNVVNOXhUZ2d2UWg4UWR6aEYrSG55?=
 =?utf-8?B?cWo1ZTQ3WWY1WkJyQmY4VFM1aGRsZVBBM2gyM3dGZHRNRStzcTZ1YlArRW91?=
 =?utf-8?B?RWEvZzNoUDJQNVRtYnhIaWxyQ0RndzVhVDRNbVM0clBVaGFtMWZrSDd0VGhG?=
 =?utf-8?B?ZlpldUxPcU45K1hKWDNkSzBvWGljS3NYZWkxd294Z052V3hKajRMUnZkUkZi?=
 =?utf-8?B?ZUZFK1FZUG5vbE9qVTNLSzkvRi9aa1Y3RllJcmZsVmxibWtLd2NhSnY1dFVX?=
 =?utf-8?B?OUtJdldGdlRkR0RrNTIzd042dGs2cmM0NlFwUUtQdVVNc2x4LzVZSUozZ0xN?=
 =?utf-8?B?emsvWGFGZUFxYWg1akVsbVVKOGx5bTk5U0VjOTQ0NVhGWCttSkhuUThRNG5m?=
 =?utf-8?B?ZkVOdVRrRFM3bjc0OUI4azF4bFpNRkczS2NhQi85WDZVYmFWL1VkN0llNTFH?=
 =?utf-8?B?bEtJYkZyM0hOaGo2ckJFbDNDTEV3OTJUTitJUnR0aHdTRjkvYmhwZUdkWHFG?=
 =?utf-8?B?Zi9CSjNnOGVUTmJHcUY3VUw5bkhiRTE5dkFYbFJZNWVCdWluYWk2aUlDcHBR?=
 =?utf-8?B?T2ZUSCtIVGo3WmVJUkVaSFJ3NVk0ZnAwWDBHZEtWdXBHNW1hbDNmdHZucGNr?=
 =?utf-8?B?Z3VyS243dzczNEp2TURqSGJGU1A3aDJvMGNFYUxhSzMwUzZOcWZBWFBJZnNj?=
 =?utf-8?B?bGhrRzhhWkYwWXNwYml3Z0VzY0thYmFvVDRGVlpTTHRmZEVHLzhzWHYxM0M2?=
 =?utf-8?Q?RtTFHF7GnNj1n6FQlB/Fo9m0oJw8FkZB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVrSW9PVWtITWlnWFNsclc1c01wemt5Y0FpQzdUSUJLTzF4TGZPeUMxL3lV?=
 =?utf-8?B?ZXZ0MmZ5NEI0c1ZsWVhkdmlIb2YvN3ZEeGFnUzdKV2xqTm9DVHYzd1F5bmJv?=
 =?utf-8?B?eUFJOE13a2NGZUl1NTFJM0FRUlpEQlNCdHIwMFJJRGxsTXRGOExicHVlVWtP?=
 =?utf-8?B?YUdmR1VqajJMUE54aitjWkJBMzE5S0V6T29tdlhnUHVKWFhOSDJCOUV5RnZR?=
 =?utf-8?B?bXoxWUs4RTQvM2srbWtSMmtxcVc1QW0vMmNYdXU1L1YrN0RFbmVWNmRBL3Zh?=
 =?utf-8?B?VHExZE1hcHlvN28vZWhSWTU3TTlKTFdyZmg2VzVLVm9qNFd3Z3B3dTZlQ0l4?=
 =?utf-8?B?MUF1U0FWNEZFLzhDYXZObUFMTDlab3JsU2lISVVDSUVxeU13UlNpUmR6RVZj?=
 =?utf-8?B?bXZ1aFIvYUpNcmhrVG9Cc2xUUVNMUytMQWc0R3ZPL3AwdHN6aHlMUmhVV0kv?=
 =?utf-8?B?bVBVTDBJWEFjeTB1dm5HcjRjbFVIcUljVWYxcXdTWktnMjhvRnorakU1VVZt?=
 =?utf-8?B?TDBpWnNQeTNPZHdQb3JSdHp1NlQyMW8rdkVmWjh4azlwbjQxMUNaTjBrbjZ5?=
 =?utf-8?B?R3Rpb3Fub2d2K2dBVTIrSHN0SVF6TGZzNXgzWXVqeklHYnplYnBCUDBZVjZO?=
 =?utf-8?B?NUxDSzlCR1FzTVdGOG9rVHk0cXkzQzZSMWxFQytHSU8wZzJZamZielE3NDFG?=
 =?utf-8?B?RFJJWlJLUmpjcW9PYlpDM3lpNVN5UjhzQjBabVVHeTZlS2tENlIrcFJPK1B4?=
 =?utf-8?B?OXlnTVU2YjZ0V3U2QVdGWUJ0RWdtK1FhYkFiNWZiZGMwbksxaVZ1NlBUSFBP?=
 =?utf-8?B?THhFci95Yy9Rbm15VE1tQnJuam9PZENtRkdMTXU0ZG0rUnlpUW9tR2w1NVlU?=
 =?utf-8?B?bFp2V1R4L1k4QlRiSmEwL1NZWmQ4cDRWY25Ma0NnY0EzNGFDZklzenlQem9T?=
 =?utf-8?B?MDZIM3M0SUh3OE9yVWF3OXgyWFplTXl1R3NNOTdZU3hKdllMWWpZaUtTa2NN?=
 =?utf-8?B?alhsaUJhU2s4MTdwcVBaWFI1TmljK2VyVzRiMmFkVDNQT3U2V3VJMytQalZv?=
 =?utf-8?B?Y0tLRzJqbVlzY095K2k4MmdlTHdwcVRLRTBMT0VWd1NTZGwrOW53N3JSZW13?=
 =?utf-8?B?VGpVenZzcUJvcFg1UG55NWRtb2F5T1RNY2ZscWQxZDhnOHJ2cUIxQk4xT2ZX?=
 =?utf-8?B?Kzk3VXYzSlhIT1FZMm1taUNoZk1wTnZuZU93TlMxVC82VittbFphb1E5QTVo?=
 =?utf-8?B?NlpPRG4yUENPMFhEcGtYMkE3ODJtWnI1S0pRUERVTUtqVDlsWlhvNUxCaWJo?=
 =?utf-8?B?dldqWUorYjVLRXU3S2h5TklWSEpsS1lEWE1NbWRmZkdBWmRlK3hLUWMzL2Jp?=
 =?utf-8?B?b2paZ3lHcDdSS2ZKeEdsY3R5TUpISUFWNFB4c1lMbmZ2U0lTbDU1K0tRdG85?=
 =?utf-8?B?bXJEdzFUcGVuYnRUWU9NL0psdWx1ZTlhdlVrWmlRZUE4QXAvNW1pd1BnVlBS?=
 =?utf-8?B?aDZOeHJFcjkwOUlXUEV6VHljTVpYOU95RUFKem5zdzVCT3Z4SHVOcHF0YzFB?=
 =?utf-8?B?dzhPMjJCbmVKajVuNHdudUtjT3doWk9BK3V5aVFXNGFYaFozVHlNTHJ5Ym1D?=
 =?utf-8?B?YzlsSHQ2dUNaaTRvSTRZbFRVcEtPTGxLNmdDQWlKNWQ2UkFUUGRPRDloaDRw?=
 =?utf-8?B?alVUdmJtTnhKdHZ0L2txV1FxWlhGZ0ZPZUpwWUFPaDBvdVZlY3hBRjVGUEhM?=
 =?utf-8?B?eXRoQS9OSTdGS1NYTGVxVUkwaEovUkVwd2QxMFBkaS9rUnE3L0FkZ3ZITGlu?=
 =?utf-8?B?T0srb3lDc3VELzkyQlBRV205RTlNTU1xQ0Vpa3RhZkFKRWNkWU85QVkwNC9q?=
 =?utf-8?B?YlFZcjE2Ni9vdzZ3RmxBRjVxMVRPeU9hMDNuNG9pZU16VHJ6YXAwMExLbWVl?=
 =?utf-8?B?WDZhYTRqRjJjY2NXUUp1Qi94UVQxQzlkUG1TWlRBZ3VKNkp1M0doay9kbXl2?=
 =?utf-8?B?anc5Rzk4bmdyeHNIWnB4V2VBNjRzYkpwSmVFYlpreE1ORnRWZnVFWFRTUDRR?=
 =?utf-8?B?UFgvdUhwcE1uNWZ5YU5WMGtDV0RXUGp3OGRqSEFISFBsQ1F5MTVXSy9TWEZC?=
 =?utf-8?Q?8N+k7QLlRc91zydyyVamxYKqt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b40ef6a-dc47-4353-3e2c-08dd466d4885
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 05:15:33.8426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjx+O1XaCTdlbBjPjGyw7TVdsMTDvtVmr4LH+YlI3b38uYqI1BkChg7i9+4e97JVRM7GHt2ZNk0MDSS/4XSgIJ+ye/ZUK4Bt6sBbLCLgLxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6244
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 THREAD_INDEX_BAD=3.197 autolearn=no autolearn_force=no
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

SGkgSm9lbCwNCg0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiBTZW50
OiBUaHVyc2RheSwgRmVicnVhcnkgNiwgMjAyNSAxMjo1NSBQTQ0KPiBUbzogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IENjOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgQ8OpZHJpYyBMZSBHb2F0ZXINCj4gPGNsZ0BrYW9kLm9yZz47
IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUNCj4g
PHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+
OyBvcGVuDQo+IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxp
c3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgVHJveSBM
ZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgWXVubGluDQo+IFRhbmcgPHl1bmxpbi50YW5n
QGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEyLzE4XSBody9hcm0v
YXNwZWVkX2FzdDI3eDA6IFN1cHBvcnQgdHdvIGxldmVscyBvZg0KPiBJTlRDIGNvbnRyb2xsZXJz
IGZvciBBU1QyNzAwIEExDQo+IA0KPiBIaSBKYW1pbiwNCj4gDQo+IE9uIFRodSwgNiBGZWIgMjAy
NSBhdCAxMDowOSwgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4N
Cj4gd3JvdGU6DQo+ID4gVGhhbmtzLCBJJ2xsIGNvbnNpZGVyIHRoaXMgdXBkYXRlZCBkaWFncmFt
IGFzIHdlbGwgd2hpbGUgSSBwdXQgbXkgb3duDQo+ID4gdG9nZXRoZXIgZnJvbSB0aGUgb3RoZXIg
cGllY2VzIG9mIGluZm8geW91J3ZlIHByb3ZpZGVkLg0KPiANCj4gV2hlbiB5b3Ugc2VuZCB0aGUg
bmV4dCB2ZXJzaW9uLCBwbGVhc2UgdHJ5IHRvIHNlcGFyYXRlIHlvdXIgY29kZSBjbGVhbnVwcyBh
bmQNCj4gbWlub3IgcmVuYW1lcyBpbnRvIGEgZGlmZmVyZW50IHBhdGNoLiBJdCBtYWtlcyBpdCBl
YXNpZXIgdG8gc2VlIHdoYXQgeW91J3JlDQo+IGFkZGluZy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+
IEpvZWwNCg0KVGhhbmtzIGZvciBzdWdnZXN0aW9uLiBDZWRyaWMsIGFsc28gbWFkZSB0aGUgc2Ft
ZSBzdWdnZXN0aW9uIGluIHBhdGNoIDAsDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvcWVtdS1kZXZlbC9jb3Zlci8yMDI1MDEyMTA3MDQyNC4yNDY1OTQyLTEtamFtaW5fbGlu
QGFzcGVlZHRlY2guY29tLw0KDQpJIHRoaW5rIEkgd2lsbCByZS1zZW5kIHRoaXMgZmlyc3QuDQoN
CjEuIElOVEMgcmVuYW1lL3ByZXJlcXMvY2xlYW51cHMNCiAgIGh3L2ludGMvYXNwZWVkOiBSZW5h
bWUgSU5UQyB0byBJTlRDMA0KICAgaHcvaW50Yy9hc3BlZWQ6IFN1cHBvcnQgZGlmZmVyZW50IG1l
bW9yeSByZWdpb24gb3BzDQogICBody9pbnRjL2FzcGVlZDogSW50cm9kdWNlIGEgbmV3IGFzcGVl
ZF8yNzAwX2ludGMwX29wcyBmb3IgSU5UQzANCiAgIGh3L2ludGMvYXNwZWVkOiBTdXBwb3J0IHNl
dHRpbmcgZGlmZmVyZW50IG1lbW9yeSBhbmQgcmVnaXN0ZXIgc2l6ZQ0KICAgaHcvaW50Yy9hc3Bl
ZWQ6IEludHJvZHVjZSBoZWxwZXIgZnVuY3Rpb25zIGZvciBlbmFibGUgYW5kIHN0YXR1cyByZWdp
c3RlcnMNCiAgIGh3L2ludGMvYXNwZWVkOiBBZGQgSUQgdG8gdHJhY2UgZXZlbnRzIGZvciBiZXR0
ZXIgZGVidWdnaW5nDQogICBody9hcm0vYXNwZWVkOiBSZW5hbWUgSVJRIHRhYmxlIGFuZCBtYWNo
aW5lIG5hbWUgZm9yIEFTVDI3MDAgQTANCg0KSmFtaW4NCg==

