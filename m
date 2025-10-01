Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A306CAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 02:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3mYz-0005o5-D9; Tue, 30 Sep 2025 22:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v3mYt-0005lk-Fv; Tue, 30 Sep 2025 22:27:24 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v3mYK-0001Pj-Fd; Tue, 30 Sep 2025 22:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5OmHBM9IcNfXXHsthrdr5ASBg/AlSDoJ9DPjEAf+wJXbHTJMZ0kKeb3zT/2zhm04Jh0piKlDdcXflQ8dGxSsCUTeBFAmnTqmsCV43b38kYyx67ea3YjCpzp89yebXJEhF/1usMKsQDVyackaDPcfw5pt3+YauLxKy8vDLt4C7EpLonnP7FhHcgUD6rjJWfXXQ20eZPaliDcuvFI7/ad2+c/hz0Fena5GMP1qFvY1mfUL6PqZyHF1DchRajszDIDLUnSekkIGJdVmvD++cCbeewelftWE+hvTVmCTZQhH7FczHMKN79zAdDsK92zM7Xb6H8uQizT3iz4DUiTQtMh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVJEX4mPecAQ1oROXrMkFa+BoE66yN8rHmRxOmZYBog=;
 b=gaN2t2nHlMtEH/eeyrWsODSzw4B67bVKqGv0qmD/+pjWl5WgejZQ2AFM45wArkSuHlroWZqNH3TwqPQTRHklH/nAnuMToCoJMNzxK23LsoUJ4PE+w2xDPsTlkgvw81FK93TG3mGtjV0Zm0R2mJoLt5av8CSw/sRuRAIEAMQHCheEvRivs7n7cQI5Ohus99v1H6GGphbHjsLgjWiEk7IIRWPsnlirIUYoFnWCunGgtpvfEoCF/OxK4CSG9fHdqt0VnRROtSvQIRT3Furq8Y/AT7cxZ9hTSy7fgbLM23TXlTpBsqHq2V2I689dRLJonbD0BQGzXoDchUQyRWMjsG8uRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVJEX4mPecAQ1oROXrMkFa+BoE66yN8rHmRxOmZYBog=;
 b=OWt46dviBBV0tGQPp/Cg4canN+wi1whA4FyUDkwozOL8Vzz4GzoWKnSb2J8bsoDhxhIOs7Pk+89TrXCZwRwbOwPDI62dvVNexv5MTNHPWo4vikOumAxIVNwvbiT4l//x1zNXkdBYeLBnPql5fI82C3xM5LE7svOO4ELUWBBb+HT3zPcqXpmN76Oib0N5m81pmGV75mmC8f/l/sInuR7/cYU3nz1rG25iHkqzzdLpf7uY+j2vE9H2hPau1RwotMB14mV//pkntER1OCqAW026vlwtm5/9J01gufWHWuP46dXyGfEuLxY59XTLVTyA5kuMj9sETlmEzPcdDqRNC/jFzQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYQPR06MB8044.apcprd06.prod.outlook.com (2603:1096:405:2fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 02:26:27 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 02:26:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 0/8] Support VBOOTROM to ast2700fc machine
Thread-Topic: [PATCH v3 0/8] Support VBOOTROM to ast2700fc machine
Thread-Index: AQHcLdoKsLUetXLy90+MC2/DhfRoebSpq6CAgALtE6A=
Date: Wed, 1 Oct 2025 02:26:27 +0000
Message-ID: <SI2PR06MB504178B33BC303FCBB0FEBFDFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
 <ebe8c9c3-0e94-4ed0-a231-4d93306fb779@kaod.org>
In-Reply-To: <ebe8c9c3-0e94-4ed0-a231-4d93306fb779@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYQPR06MB8044:EE_
x-ms-office365-filtering-correlation-id: 4e26d101-e098-4218-c85d-08de0091eca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RG5URWRaanFrS1U4bnFuRlM0Mk94UEgwT1pRaStDSm9BNTErNjhoWnNWWHl4?=
 =?utf-8?B?bXNYRm8xS09LcEhzSEUxK0hUR0crNWxSckJGYVRKeFUwaklOVjFxc3NBV2I0?=
 =?utf-8?B?Nm9hZ0F1WCsraXJWNllyVWg1QWFubXVBMm85YnVQbE5weEFOdHBKOTNJb200?=
 =?utf-8?B?NTRQb0tIMHF6cnJ0TDdEWTlMY3FUTVp2WXprcXdGWTFEUjF0cUVoaXlkMUly?=
 =?utf-8?B?b3JmeGdxelN2R0ZrNmpUajdXSzlFbmswT1FnanRGNWhIMkd3RDBZcjNWK2F4?=
 =?utf-8?B?VnBPQ3AvYm9jbWJDWUdqdE5TczM2TEZOTmJUQTFiSkhlU0tvZHAvRmZCb3lE?=
 =?utf-8?B?Z3VwRUFkUm5LQ2lZeUdTMlNBRExHL2VhVUlRbllHQUZycnlDazZYZi9WUzVl?=
 =?utf-8?B?K3ZmTFc4RUtWVzhhYitJOFpaQnpTbDhHY1JMR2F5Q0xOWDk1SWxGWUNtaFA1?=
 =?utf-8?B?aDV4ZjAzVjlFY2c3Q092anRveWk5REY5VWRZb2haajVXdmZLTUQ5SVBUQUxh?=
 =?utf-8?B?blJkNXpsczQrMVluK0tmWVphS1NkcFV1My9RQWIwelV6S2EwZXl2Q2ZlZHVZ?=
 =?utf-8?B?ZWsxV3Z3YXpzK1U2MjE5NjZ1cDhYZ0lwLy9hcVJMT1l1ZzBDM095aTNCS0t5?=
 =?utf-8?B?QmdnYUpXMmdXNmp1T3c1cXZicjVnQU1VemNDRFk4NjVScTg5OUhhdnMrS2Nz?=
 =?utf-8?B?Ym5Qamg2d2FSdXF0Wi80MFE0YVZBdXVQSndhamcrdjJMWTJyS0ttajQxc1R5?=
 =?utf-8?B?VUFwS3p2TytISXFQZHlWVzllTTdZM2pXTUVUM0RkUjhYTUhmOUE1VFQwR3JY?=
 =?utf-8?B?Rm5lcGEvSGpzUTNZU0psdWZXTkJCN1VmODM2eWoxYVJjVkVkYmo2TGlOdnlB?=
 =?utf-8?B?YjV1bjY1N2hIcEZHNHFDZThicm9KN2U3NnJYcGFKTHV1bTZBYVgvQ3RGZVNl?=
 =?utf-8?B?Y0hkT2E3bEJYcTdTeEl1UE9DK0EwUnpLbGFUNkVwRjB2bWphZzN3WERKdGZl?=
 =?utf-8?B?VG5UbFU5ZW9OM2U1dVB6WjlnRTdRMUV2RjFrME9yeklmdjRubHZHbE9GbXVZ?=
 =?utf-8?B?a05XU1h3SDFCMk1nRWs2RmxHeWduK2x1VVhPZlJIYlRHN0lXVmhsd3czdjJK?=
 =?utf-8?B?Y3VtanNKam53S0k1UiswdEExMzZhMkM1cnRWbGNxOW5NVzAwQkpQejExc0xo?=
 =?utf-8?B?TnJXaWtSNms4bEFjb1g4UXAzdTU4OTZEK0RML3A0WmNFR1htU01YbXRGNTRm?=
 =?utf-8?B?cGJocjZFUGswZWNFRkpGS3hnUENYZUVpZHdNLzZORnBOR3l3UEpxUmsxTTEx?=
 =?utf-8?B?MThraGhXc2E2d0hSL25DRnBPb2dTTEN0RExCRG5pRldLREhwc3hMZHQ1Rm5M?=
 =?utf-8?B?d3R1eHJFMzV3dVM0dGxRdktCVDIvdm5xUjBoOENqdnN1ZHY1ZFFEbGRHZXZk?=
 =?utf-8?B?ZlVlb2VRdmpidFpyRXlYT25BelBxRU9NZ1dLSk1xTEdTQWpPaDViektNVGhQ?=
 =?utf-8?B?MEdHeGNGaXpQZ0F3VGxxNzZnVGNObnlqZ2x2QlpMYjJLS1FJdVN0cFR3Nm9w?=
 =?utf-8?B?dHk0eGp6WEdOMmFyWERaZ0RvR0dnRjBTcEFmalFwVUlobDVOb0JyeW40WThT?=
 =?utf-8?B?Z1FXOFVuT0MyRlVEZ0g5b3h6ZXF3N1h4YTRRdTBlTnZET0E5YXFKTy9NMm1Z?=
 =?utf-8?B?eGN3dXdPK01ZSzc3UzdyQXM2djRGR2xRQUd5SWlrNUNaQ2VOYXNua3dQSkFB?=
 =?utf-8?B?OXNkLy92amtMV29RR291YXR5TU5LZHNTUXB3OU1XNHFQalpJSkZCamhCWldK?=
 =?utf-8?B?RFg0WjE1dGRIR3RHV2orZVB1SHc2SnhUdU5Cd20rQXZVTmgwdHQ5TkRvQld3?=
 =?utf-8?B?aHYyczQ2WUxScHRzZ05WRUJOVnJuUUY1c1d0TVpUNVhuSzZzVzA3dmIwbmt4?=
 =?utf-8?B?N3NkUXhKR0EzZlN6eHZuQXp0MXpSSUhsaDI3RlF2MVAwZnY4SXl1WXJ2cG1q?=
 =?utf-8?B?c01HbWgweUxnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVNIdUplYkVEODFVVHFMS2kvWTVjcDNGT1ZqWlhRNTY1QlJlYUQrUndqYXlo?=
 =?utf-8?B?R3dQVHVKNG0vSkR1QkxkSUU4c2RxV3hqWkZKNGtMRm5OU3MzajVTcHVQYnow?=
 =?utf-8?B?bW1aSkRpRCtuNm52STl4b2VBRGV5SFowUW9qZjRrUHZxK05OdkJqL3pGVFdY?=
 =?utf-8?B?Lzdvc1J4Nk03Vmp0aWFKRU55Q2Z1NG9hYnJMMXphaUtmd1pWaElybTJiZmxv?=
 =?utf-8?B?R0dicFR6d1Y5QkJXRXhiZVp4ZXQwQ25jUGhzQjJISmEzTkFGODNDVnMrbHMx?=
 =?utf-8?B?ZVEwSDFDTmkwaWJKNEs3VzVCMGR3Y05SMHF3NFdWNVlFd052TmtHVWdXNkNO?=
 =?utf-8?B?c3gvcWIzTThDRHBCaGZaZzRoeHFnbUcwYytKLzA1TGFHQ1lobDNyaHk4eUEy?=
 =?utf-8?B?RU94cTlxK1JBVTBvNkIvTVdFS3VJU1NheGJyY2ppMUV2WDdmclVkaE5NdHZV?=
 =?utf-8?B?VmpKUFdZQkFqQ1dVK1ZtUU9KY2EraWlDSEpDWHB5dW5GbmVOTCtMM3ZNSkMw?=
 =?utf-8?B?RGNPMXRuUTE4dXUwaUpVN0d3TlUwT2YwcUR0NDFrQmhhcTNsK0dCZWZPaUxL?=
 =?utf-8?B?d0VMTlB6MktEeTBoRFRFb2g3NTNRcnVPK3FDN2EwV2Y4RUxVb1V3em9JOG95?=
 =?utf-8?B?SVJncURqN0JhRFpmS1VDNE94RnJQRWdsYkdqUlBLTUl3VlFzS3ZQcnp2RzlO?=
 =?utf-8?B?ek9ZYTc2N3owbE8zMllKQjUvQ0piY2thTnpHZEJpS2hwU1dpVkpnb0hvdEZn?=
 =?utf-8?B?cHRPY2RkWERYc2hxNU1wYXZRY0Z4Q0JHU25uUlYyVXJjNmVZOHd0aFR2eUpl?=
 =?utf-8?B?RU0wUnUrZTdyWEhVUlZobWNRWXh5VWNMUVZ6N0x2d09EYVc5QXJMcUhadWYw?=
 =?utf-8?B?MkFTQ1JrNTFUeGhFWUJMQ3JiVkExUk9jcjJnOTRTaDJzWUthVjBUazRuK3lK?=
 =?utf-8?B?clIrMHFlSUpMUTBiMW1pSDZlVWd2KzNsbHlGVnNyN2lSUWxJZ3JCRVlxOG5D?=
 =?utf-8?B?UnRLWnJDU1FMbWUzSnN5em4xaU5aSE5jZENDUTVmRk9GbG1GejVDSU54VEFO?=
 =?utf-8?B?ekkzWmltMHZ3Q3l3ZUdUNzJMN2k0VjJBWjNEYXJSMndudTh1TVFsRXdXbXpx?=
 =?utf-8?B?TDZyc3FBajgzZVUvdjZHUHk3U09OeVhPbUpQSm11Rm1uMmh0YU82azFsa2Jp?=
 =?utf-8?B?dytxWktOZFVRR2hqOW9KWHZHNFhmMDRMS2hWNWlNRDRUMUVTcXFnVXBZbGgv?=
 =?utf-8?B?VmQyRGNhYldGdFFUYVlRQndRTTRJSXdITG01NjhXVGs5QlFhQXpnM0dTdnpZ?=
 =?utf-8?B?NXhDY3dCQlpzVFBEUWtPYjJ0OWMrQmZ3eDYrNEkwMnhPeEZTN3Y5cHRZZE1Q?=
 =?utf-8?B?VFVUcGdES1pkcVEwNlhYYW8rcjVxTFN6SWVEOVRJa3A4ZDZQd2lpcE1pYW5L?=
 =?utf-8?B?N0R3ak9CaDU5TVJ4RDBZUCsyNTRTbXB3eTNNQUhWVWlnWm52TzZFQkFoMUtB?=
 =?utf-8?B?N3hvUnpDTTNvZVFsQUJqcWt4U0pMdEUvR09LMjF0WGR6K2R0Z3k3MDhmMW1n?=
 =?utf-8?B?ZEVYSjBZS1BpQ3BwandwWW5NN0h2dXVNNUttaURJeTIwbjNRd0tLeEJjVEZ1?=
 =?utf-8?B?YVRCY3pIVHoxNVdDS1hxM2xIbHc4OUV0ZUdYVlNIU2dwL1RhQTFDNVViM3hx?=
 =?utf-8?B?bmlwNTBNZ2ZDUGM2WUtRNGVWeVdFd0JBbGVvWXJCTU50Q0FuQXdlZHhtOENu?=
 =?utf-8?B?YmI0akFFbEVuVmZjT1BSbG1ZOGRYL1lwdnRIVXNGTmprUEx0Mi9tbUEyUW9x?=
 =?utf-8?B?RTJhWXB3b3dvZlJVOHNkLzlON3c1QVVDQ0lqSXVWZVRsdm1JYjZmUFExdXVD?=
 =?utf-8?B?c1pBWlR2QVZpNjlnUndNZDl4RHFDaWUzSm9WeDU2ZllINWFLc3E5Mm53WVFR?=
 =?utf-8?B?a0x5MGl0VHhiK0ptRmNINThXQlY1MkRNaUJHNXQ4cHVsUDNKNmVMcXFnNmVY?=
 =?utf-8?B?eU5ha3RrQktrdVVUMXJqT2xHbGJkVmRPTnlLdS9iSDZhbkV0S1VGczhoRjd6?=
 =?utf-8?B?R0ptbmZ2aDR1Vit2S3RGNkp1eGc1MVkwcGtYa0V6djkyc21OUmM3TWdoV3U3?=
 =?utf-8?Q?YvvZFmlzv7gOJCXoRrqK1iQN/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e26d101-e098-4218-c85d-08de0091eca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 02:26:27.2978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNiRrhrLtOXrOhZ6FAs8IQOuyIlAMnBpL/KmMa75VJ1250Gjxj/nraqn+mfqjfSEDUwobtvO144CtO7RuTZ1yaCYaHbhZvdqNyuUQqprnWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8044
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

SGkgQ8OpZHJpYw0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC84XSBTdXBwb3J0IFZCT09UUk9NIHRvIGFzdDI3MDBm
YyBtYWNoaW5lDQo+IA0KPiBKYW1pbg0KPiANCj4gT24gOS8yNS8yNSAwNzowNSwgSmFtaW4gTGlu
IHdyb3RlOg0KPiA+IHYxDQo+ID4gICAxLiBBZGRlZCBzdXBwb3J0IGZvciBWYm9vdCBST00uDQo+
ID4gICAyLiBNb3ZlZCBjb3Byb2Nlc3NvciBpbml0aWFsaXphdGlvbiBmcm9tIG1hY2hpbmUgbGV2
ZWwgdG8gU29DIGxldmVsDQo+ID4gICAzLiBVbmlmaWVkIFNDVSBjb250cm9sbGVycyBiZXR3ZWVu
IFBTUCBhbmQgY29wcm9jZXNzb3JzDQo+ID4gICA0LiBTaGFyZWQgdGhlIHNhbWUgU1JBTSBiZXR3
ZWVuIFBTUCBhbmQgY29wcm9jZXNzb3JzDQo+ID4gICA1LiBTdXBwb3J0IFBTUCBEUkFNIHJlbWFw
cyBjb3Byb2Nlc3NvciBTRFJBTQ0KPiA+ICAgNi4gQWRkZWQgc3VwcG9ydCBmb3IgY29udHJvbGxp
bmcgY29wcm9jZXNzb3IgcmVzZXQgdmlhIFNDVSByZWdpc3RlcnMuDQo+ID4NCj4gPiB2Mg0KPiA+
IFNwbGl0IHRoZSBvcmlnaW5hbCBwYXRjaCBzZXQgaW50byBzbWFsbGVyIHN1Yi1wYXRjaGVzIGZv
ciByZXZpZXcuDQo+ID4gICBUaGlzIHBhdGNoIGZvY3VzZXMgb246DQo+ID4gICAgMS4gQWRkaW5n
IHN1cHBvcnQgZm9yIFZib290IFJPTS4NCj4gPiAgICAyLiBNb3ZpbmcgY29tbW9uIEFQSXMgdG8g
U29DLWxldmVsIGNvZGUgZm9yIHJldXNlIGluIGRpZmZlcmVudA0KPiA+ICAgICAgIHBsYXRmb3Jt
cyBhbmQgcmVkdWNpbmcgZHVwbGljYXRpb24uDQo+ID4NCj4gPiB2Mw0KPiA+ICAgIDEuIERyb3Ag
ZGVhZCByZXR1cm4gY2hlY2tzLg0KPiA+ICAgIDIuIE1ha2Ugc3ViLWluaXQgZnVuY3Rpb25zIHJl
dHVybiBib29sIHdpdGggZXJycC4NCj4gPg0KPiA+IERlcGVuZGVuY2llcw0KPiA+DQo+ID4gQmFz
ZWQgb24gaHR0cHM6Ly9naXRodWIuY29tL2xlZ29hdGVyL3FlbXUgYXQgdGhlIGFzcGVlZC1uZXh0
IGJyYW5jaC4NCj4gPg0KPiA+IEphbWluIExpbiAoOCk6DQo+ID4gICAgaHcvYXJtL2FzcGVlZDog
TW92ZSBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVzKCkgdG8gY29tbW9uIFNvQw0KPiBjb2RlDQo+
ID4gICAgaHcvYXJtL2FzcGVlZDogTW92ZSB3cml0ZV9ib290X3JvbSB0byBjb21tb24gU29DIGNv
ZGUNCj4gPiAgICBody9hcm0vYXNwZWVkOiBNb3ZlIGFzcGVlZF9pbnN0YWxsX2Jvb3Rfcm9tIHRv
IGNvbW1vbiBTb0MgY29kZQ0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IE1vdmUgYXNwZWVkX2xvYWRf
dmJvb3Ryb20gdG8gY29tbW9uIFNvQyBjb2RlDQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gw
LWZjOiBEcm9wIGRlYWQgcmV0dXJuIGNoZWNrcw0KPiA+ICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4
MC1mYzogTWFrZSBzdWItaW5pdCBmdW5jdGlvbnMgcmV0dXJuIGJvb2wgd2l0aA0KPiA+ICAgICAg
ZXJycA0KPiA+ICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYzogTWFwIEZNQzAgZmxhc2ggY29u
dGVudHMgaW50byBDQTM1IGJvb3QNCj4gUk9NDQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gw
LWZjOiBBZGQgVkJPT1RST00gc3VwcG9ydA0KPiA+DQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3Bl
ZWRfc29jLmggfCAgIDggKysrDQo+ID4gICBody9hcm0vYXNwZWVkLmMgICAgICAgICAgICAgfCAx
MDUgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICBody9hcm0vYXNw
ZWVkX2FzdDI3eDAtZmMuYyAgfCAgOTYgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
DQo+ID4gICBody9hcm0vYXNwZWVkX3NvY19jb21tb24uYyAgfCAgOTYNCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDE1OSBpbnNlcnRp
b25zKCspLCAxNDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gDQo+IEFwcGxpZWQgMS02IHRvIGFzcGVl
ZC1uZXh0LiBXYWl0aW5nIGZvciBhIGNvbW1pdCBsb2cgdXBkYXRlIG9mIHBhdGNoIDcuDQo+IA0K
DQoNClNvcnJ5LCBJIG1heSBoYXZlIG1pc3VuZGVyc3Rvb2QgeW91ciBjb21tZW50cyBvbiB0aGlz
IHBhdGNoOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwv
cGF0Y2gvMjAyNTA5MjUwNTA1MzUuMjY1NzI1Ni04LWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8g
DQpXaWxsIHJlc2V0IHBhdGNoIDcgYW5kIDggYW5kIGNyZWF0ZSBhIG5ldyBwYXRjaCA5IGZvciBm
dW5jdGlvbmFsIHRlc3RpbmcgKHY0KS4NCg0KVGhhbmtzLA0KSmFtaW4NCg0KPiBBbHNvLCB3aHkg
aXNuJ3QgdGhlcmUgYSB2Ym9vdHJvbSBmdW5jdGlvbmFsIHRlc3QgZm9yIGFzdDI3MDBmYyBtYWNo
aW5lID8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

