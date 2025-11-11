Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725FFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 02:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIeD1-0006ta-J5; Mon, 10 Nov 2025 21:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIeBa-0006Ip-G7; Mon, 10 Nov 2025 21:32:49 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIeBX-0005N9-0o; Mon, 10 Nov 2025 21:32:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBz8XsuQuu+De1oCVHACgmVgXiwF0LBjjK1b6sh5X2q6FeZ5XVtMpxhpjPVjoXmbYZMF/s/l1B749S+BHwYZaK/4sAoDT9241/NY27T344OpeIV9hVQ0zXyRDC7EIv7vBPiBmOAmTJhmoMy7l5eZgGLwHU8/2G9BXiyjHoe71ChYSCvkmzz06bT2aClUmNXPqkKVIOuk5v+CI/TlFoTMimf/TrrET+6Q7gzkZbofT2roaorS+QH5kM0K7V1j1YdUXh5YPr7qajyZ1Nu82Vn1O6S4YUT66q8QbmlX8iQOuFOYnByF8gOazKXuFcsPMtq+/nPGKglf254y3WMslX7u+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU3SIL/Y85IEeN/8s1BtvrxVnLN92Sh4p4TykrBOyGI=;
 b=GdnpbIo4h+6+r5sbMgZfA1NYSyeMGknuzAO8AqyFErDi6O8h0gI88sXN6xWe9PQXn9I0KvRHmnvoNpWlzO7Amj0meshzBFy/nkbYtYqmECHK71bl09tpKIGi1xXVnLI4O1zUyvbL2Z5OuIcgP3r+W5bWeSEj1UZiCsVQyQJAg851fk8ILG0HsdXqvKwyS+Iw5+e3FpFy+LLaXC9AqwyXfnI7Wt0N+nSTOmrOBwtzsM+SX3CH2zAEgKUKeuHwE+roT6NstAQpRFd1jL2TZgvzH1kXte3n79ey3T3NykLyfABH2o8/0xMAyFvwK6WoxSKcTYib3AG1BVyqN00GbHZjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU3SIL/Y85IEeN/8s1BtvrxVnLN92Sh4p4TykrBOyGI=;
 b=pGRRSiSG81jAqSAu9cQOSuLKsDYLklZHJePV6BMeOVfq2gPL60TSEGdaqixRGS5XBlf8wROtMauRi/7NqQ+WIW/C2Tnw4OxgTgxww7R8RAcU8tJMqwWqp/3XrlLEFdW9d/CAfvtqqCwPfl3kN0QzEfBQ5isg+ji47728v39hSSQnFeaRGpqpZ6LDxC8VwniDaTHnc3usKrYwzPLaXQbt0JWSKSquCuAH8Yj3QENeZmGjYpZXsB9ud6QYHBOtay8PTJEwdb0MUb050dB99/9/7/Ar67L/AfGJyn2YlwFyT5XNp/62Ta1qMnW8UZK3A5/+R9ySkkMrCPYWJPDNG/cXSw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5851.apcprd06.prod.outlook.com (2603:1096:301:f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:32:32 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:32:32 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 00/17] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v2 00/17] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcTgiII/qWo2DjcEmFwqeBHb2lu7TsJj0AgACZT3A=
Date: Tue, 11 Nov 2025 02:32:32 +0000
Message-ID: <SI6PR06MB7631B0B6286AB604757EB4A7F7CFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <3751eebe-8a2f-4e85-bb9c-3a856407cc4f@kaod.org>
In-Reply-To: <3751eebe-8a2f-4e85-bb9c-3a856407cc4f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5851:EE_
x-ms-office365-filtering-correlation-id: 23e47788-b261-477d-e895-08de20ca9130
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?elNaUmhjZlpsNkROMkZTZGtVSTNiMUlsZUdITzhLS0IwUFpvZnpmNm5UMStC?=
 =?utf-8?B?MU8vdCttWThwNXV4MnJkWmxEZ080YVVKN1BXdEZvNkNiL1R0cHhZR2tmYktC?=
 =?utf-8?B?ZG1YWkdvSVdHZUFaWlRrQng5YjNRSVk1aVQ0amVDZDZiSU1pYkNabW1MclJr?=
 =?utf-8?B?VCtVUUtmTFkwTEFFdWJVaUZUSThjdHI3eWIwQ3JBS2JVdjdURS9vajNYWDQ5?=
 =?utf-8?B?TUJsekNHUWdPcndHQmtmdFBmUklhMm1zYVRiUHBFUEw5Y1ViTHRmVXRqTjE2?=
 =?utf-8?B?bkY0Vy9weUM1NXA4STYvZVpXY1R3bUxTK2xtRXBqOXlWOXBOb0oxcld4eVFx?=
 =?utf-8?B?NUN5U2F0WTVucEtRZUdrVWVneXpuaDh6MDB5N1dRZzIvLzdVdDFxT05VNDg2?=
 =?utf-8?B?NHhRTzFubllic1FLZ0F5OTVUeWU5aDhqcEs2dnVkRlpzMDUwU2tKQVJtMkkx?=
 =?utf-8?B?NEFHcllwbjBPWUVWcGNNOTFiK092V3grTXNaTDJ1RWxxSy9LMVB4V3MzZkpB?=
 =?utf-8?B?VHpNeUNhdHUveXgyRzUzbE1DU2tCLzY2dmJDZzNYQmlLdTBlVmNtWWsyNFQ1?=
 =?utf-8?B?SE5IZ1Rod1ZmZWxBbTJNc1B0eC8vNmQ0clB3cUNXTW5DaTN0aW5iOVo4aXB3?=
 =?utf-8?B?TENra0tJSWxVbHZsZE8ya2VBUUc5akErcFY3SzdKYUNySnAyMURFSGhOcGRC?=
 =?utf-8?B?eWNNMFFHcUx5MkI2R0FzSldES1Bmbm1VWUdLdXRSUzZRR1ZENGNhWnRMdVMw?=
 =?utf-8?B?aFpKRUtHT21WME9PUWlIL2NLYUlzcG1sTTFyS2xXbjZjc1U0UWNBU3lTdXJo?=
 =?utf-8?B?S2l2VzN4RnNvK2ZNbCtIZlJQa1l2d3o1RHBCV1B5bFhiYU1nSlB6L3U4Q2lU?=
 =?utf-8?B?enVQRFNCV3ZldHQzQXltNVJ2SzduWTEzNXUxd0huaTAycUora3BGZ2hkOGdK?=
 =?utf-8?B?Z080bXNUdUNDZGQrS1hwRmJJMVpTMllaNVJhNnhiN3liWGFTYVRKSDM3MHZK?=
 =?utf-8?B?RTBEMkZBQXkwNnNyMEh5c08wdW0xN29SU2hEZUVZVTNVQlkvOFY1a1orcVIw?=
 =?utf-8?B?ek85Mk1WdFYzbERuVEhoUzFvTCtVKzVhU3d1RGVZZGdlSGpFZ256WlJONXZD?=
 =?utf-8?B?UDQ3dFgzaytYZFZMa290MGZBd3dXcERick40dTdsaUh6VE1zNWJLUUlyK3R0?=
 =?utf-8?B?U1dXOGxUSGdvYTZCdFdPT1U3NlcwZ25OcHFKcWJOMENsTjlxT1g3L0g3MFc0?=
 =?utf-8?B?ZEJTTGZjM05ORjFHdXFpTWI3dXd0bmRWdENkWWtJcnJLeGNJWGpHd3d2cmJI?=
 =?utf-8?B?eUlTN05HYmJrOThqaDVNOHZTMFhHdUI0R1hoWjVYZVdqclFlazVjeXh2cUtj?=
 =?utf-8?B?YWhZdi9uY1RPOHVYNnBsOHI3aGpsOUtRRy9kWVdQMVRmRmZwMGtNQkxqMHdu?=
 =?utf-8?B?REEwUnRrL3c2YXVMSzlqT2taY29jZWorcmlKNXdNN0l3MFlzZHBiNzdqcXp2?=
 =?utf-8?B?eW1ncDNVS1AvNlBjdU9CZ0J5TW92akFtQlBUa09jNzU0bWN6VlNCNEUzWC9j?=
 =?utf-8?B?UjJNZlJjRm0xUThwUGhrSUUwU20zSzgxVUFDTXdvLzgwd2RGdHQ4d3hqQ2gy?=
 =?utf-8?B?SjdLNlBkM29ZaTNZcWZUaHpjbUtyVWZhRll4ajJUTW1FY0JBM0g0OWRmRHls?=
 =?utf-8?B?NDAwZjFrSGZyT1NEc1JUKzZoN0tObU5GWHpkekRUVUhvMFdBdnFyTXhBUHNw?=
 =?utf-8?B?Sk15djEza0o1cFl6YkVYeHYyQ0Z6OXRrNnVYUTZ0cVQ0NVp5dTdMTHI1ZGZj?=
 =?utf-8?B?SWhsLzgzK1BzcXFaSlF0cXRsSFdyMWdvTW1PdTg5eWMwMEhZNm5jSUcyQXph?=
 =?utf-8?B?dXNHbnJFNWUyU3FNaFpqb0JhMVU2Rk5FWXgzcW04WnQ5Qy9ENUdkbUlKU2NF?=
 =?utf-8?B?MkprMjZIOGl5aHVjTGtDd1dBYjZuRTZSd08rRFlFNlhYQkNhUHRpemVYL2hC?=
 =?utf-8?B?YXVBaDVKSkpwdXkrVnRJRHFhZWtlbVRLdks1RnpzSDg4cE9NeHJkamd4NlI3?=
 =?utf-8?Q?7sTJKS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVRpb3pndk02VXRaYzhmdlF3SFBraytQSTNQSlZPckVMRTRIOFo0OXlPRWp3?=
 =?utf-8?B?UFVDbkl0VDI4azNEK3o5NnNkVEVIaU4wanJ1OWZwZVk0RXNYL0FFUFpRdThH?=
 =?utf-8?B?TXBlVHpwTDIxTDRqMXFSRU40Nys3OFMvZlNaVVdVMlcwclIwb3hXcUdXeTlJ?=
 =?utf-8?B?YTN4MEQ4czNMek82WVNpTmNlWFY2WStsUmVYeWNvTC84NGVYYUV1QjJOQklQ?=
 =?utf-8?B?OHRlWVc0M2dRWDNSbFNBYWZkdHdQTDdHbkNPUllFN0Z3L2VCTWk5MlJTYThV?=
 =?utf-8?B?ellqY3Y4WmUzdlE4ZmpEZFB5MFdKZVBoSlhOdkJjMHpPR0ZsMkhBRk5qUDRP?=
 =?utf-8?B?bTBhVHdlN0Y5c0RRYU1NQjRMVVlidnduS2RtLzdPOVliR2IrU2JteWlNZ3Az?=
 =?utf-8?B?T3FLYW9PUDZIVEFBYlBxYXRsSC9SVk1SU1gxWnpyRTdKZDlFYVBIdStrejVX?=
 =?utf-8?B?RWxPQnFIS0NhQ3pQZVo0b0JUSGROZUwxaWtBSmlFSkY3RUoxY1JiOFZpbjdG?=
 =?utf-8?B?UkdQd1BjYStyb2VXTDdVRGlKaGtaTU1sNmtncVAyWHlEdWw0M3dVN1QzNW5t?=
 =?utf-8?B?TGhJRjJoR3c0TVgrdjNDSkVkekFwaDJuU0JPZTlGZ05ha1c0ejhwcUNDM2or?=
 =?utf-8?B?dnIzWXc3RXF0WGZOMTJPRlUxSkRiRUd1OE45bFZ5Z3FDZ0VhZ2VrYU5xWXVi?=
 =?utf-8?B?b0lnbWlabGovUDE3NFJFOG4vbzN2K1lLY2hrdy9keDh1VGNtek9LSzlsSDdm?=
 =?utf-8?B?ekIzSkJYNzMxazhLeCtnME02cFBKeExWUUJ6WVV3TXVpaDNMWmNockZmM2l1?=
 =?utf-8?B?TnlQRDl0M3EwSVZkb2FUVTFWbjIvbEtzNlpHLzhrTUVHZUdCeWtZWU8zVWRn?=
 =?utf-8?B?NCthMCtaMDk5YlpQT2k5RUdWMnZVTTFzSFprNllMNXNXMys0MkNGYmFZYVMz?=
 =?utf-8?B?L0t1VXJhRjNWbjJEbmRXYmEzQzZEelB4dnlIM0ZvYUZBMk9tdXd0VWM5YTdk?=
 =?utf-8?B?cHk1WTAyV2VFeGNlZEtHNmJCcWswSlFONm11WFN1V1pMZzQwN0VpUm1aVjN4?=
 =?utf-8?B?YjJQSGIrdG9GRDEyMWhxd0JhZXljQ2x3RC9Rdm9UWS9NL2NIbWRIYk9ibDAy?=
 =?utf-8?B?MDk5ZllRSGNNOVoxWTVNdUhYTXNMRzFMNGdBSCtpUGg0N01yRExDOG1LdmNt?=
 =?utf-8?B?eTlqTUc2cEs0b3VWSTF3Q1BkaHpMamxCbTR2Z242MWViNUpzQmxWRlJzaDFh?=
 =?utf-8?B?UnlOUlRvOWlpZExUK2NIalg5cHl6dk5oaVVldWQ1UHRQVko2KzE2N0ZKSTdX?=
 =?utf-8?B?TWFVM00wQ0tnWHY2VlNMNktGV3VPaWtmTS9uVTc0Q3hlOGVIdk9yV1Mwb0N2?=
 =?utf-8?B?aGxYMkFybXZMOUl0eDMzVmtKSFphRGxlYWM4QmtHby9GRjc2eU9KZmR3Ri9V?=
 =?utf-8?B?RVNNNldYcXoyQVZvN3o2bTNJN3d4dGd2MVFHMXZ1OXNLcVcxZndWVTJhc3FV?=
 =?utf-8?B?VzZZU3g4WUg0K01uVTJIZW5LMFVwaWg2MHRuc0NkSzVzZXRObEtHbXN0MXFG?=
 =?utf-8?B?Z3l2NXJ4eks1MUV0cEVLNUN4NExId3pRRGUrNlBCaHhSZW03QWlrN201UUVu?=
 =?utf-8?B?V3VLWGFPNjF2WlM1R3hUZmhOcHIydUZlaTM1bmRaSVJzWlBLNXc1TWh2NEVJ?=
 =?utf-8?B?N0grakVRYTRWNzhHam5GYU1yWmJIMm1pNjM5WThnVkxLK0VXUDFaNlJDM2x2?=
 =?utf-8?B?bW5YL3FLQzFJbmE5V0lxWk9iT1lTUUt1ejJHeUd2S2s0Tzc5Um9jWW9ITHY2?=
 =?utf-8?B?REQwenQvMUZ1OVRub1MzUmluaEdpK3h3bWdjQ3VPLzdQOWt5WGVESVNDMUI2?=
 =?utf-8?B?cHFYTkNyTFhDV1hYTkhZMjJmR1hvVmkwbE5rSE9XYXFSZzZ3L1BqT1VGNS93?=
 =?utf-8?B?TFRjS254eTZaMGN1OHRvb3FxNCtLaHFtTEMzbGllRzYrVHBiVnpVQ3FXQ1lB?=
 =?utf-8?B?VmsyaUxSS2syR0FadndjZ3B4NGFjU21tMnpPdGhEcmdNUlc3dTh5TWlUK0R4?=
 =?utf-8?B?UWFCRmNOcW9mb2xWZ3A0Wmhwbmx2c1VlYjdPWFRLWGhCMlBMRmdDRGpTNVRX?=
 =?utf-8?Q?qVaLTs2w4Yew3vAINABbOI8Ln?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e47788-b261-477d-e895-08de20ca9130
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 02:32:32.4489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8gUQe8y+RjNnK/UW9dlpJEP15D2yZMPalgQ6G6L2hGqtmqwu8Wc0WHnjgs3tHo9UermgDLPeqXrvqikDCYR/QbzUOBypJmij1fhTXVedOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5851
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KSW4gdGhlIHNob3J0IHRlcm0sIHRoZXJlJ3Mgbm8gcGxhbiB0byByZWxl
YXNlIGFuIGltYWdlIHRoYXQgaW5jbHVkZXMgdGhlIEFTVDE3MDAuDQpPbmNlIHN1Y2ggYW4gaW1h
Z2UgYmVjb21lcyBhdmFpbGFibGUsIEknbGwgc3VibWl0IGEgcGF0Y2ggc2VyaWVzIGZvciBmdW5j
dGlvbmFsDQp0ZXN0aW5nLg0KDQpJJ2xsIGFsc28gdHJ5IG1vdmluZyB0aGUgQVNUMTcwMCBjb2Rl
IHRvIHRoZSBody9hcm0gZGlyZWN0b3J5LiBJZiBJIGVuY291bnRlciBhbnkNCklzc3VlcyBkdXJp
bmcgdGhpcyBwcm9jZXNzLCBJJ2xsIGxldCB5b3Uga25vdy4NCg0KQmVzdCByZWdhcmRzLA0KS2Fu
ZQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMSwgMjAyNSAxMjo0
NCBBTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBN
YXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5f
bGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5k
cmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47
DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlz
dDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBU
cm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMDAvMTddIGh3L2FybS9hc3BlZWQ6IEFTVDE3MDAgTFRQSSBzdXBwb3J0IGFuZA0KPiBkZXZp
Y2UgaG9va3Vwcw0KPiANCj4gT24gMTEvNS8yNSAwNDo1OCwgS2FuZSBDaGVuIHdyb3RlOg0KPiA+
IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4g
SGkgYWxsLA0KPiA+DQo+ID4gTFRQSSAoTFZEUyBUdW5uZWxpbmcgUHJvdG9jb2wgJiBJbnRlcmZh
Y2UpIGlzIGRlZmluZWQgaW4gdGhlIE9DUA0KPiA+IERDLVNDTQ0KPiA+IDIuMCBzcGVjaWZpY2F0
aW9uIChzZWUgRmlndXJlIDIpOg0KPiA+IGh0dHBzOi8vd3d3Lm9wZW5jb21wdXRlLm9yZy9kb2N1
bWVudHMvb2NwLWRjLXNjbS0yLTAtbHRwaS12ZXItMS0wLXBkZg0KPiA+DQo+ID4gTFRQSSBwcm92
aWRlcyBhIHByb3RvY29sIGFuZCBwaHlzaWNhbCBpbnRlcmZhY2UgZm9yIHR1bm5lbGluZyB2YXJp
b3VzDQo+ID4gbG93LXNwZWVkIHNpZ25hbHMgYmV0d2VlbiB0aGUgSG9zdCBQcm9jZXNzb3IgTW9k
dWxlIChIUE0pIGFuZCB0aGUNCj4gPiBTYXRlbGxpdGUgQ29udHJvbGxlciBNb2R1bGUgKFNDTSku
IEluIEZpZ3VyZSAyIG9mIHRoZSBzcGVjaWZpY2F0aW9uLA0KPiA+IHRoZSBBU1QyN3gwIFNvQyAo
bGVmdCkgaW50ZWdyYXRlcyB0d28gTFRQSSBjb250cm9sbGVycywgYWxsb3dpbmcgaXQgdG8NCj4g
PiBjb25uZWN0IHRvIHVwIHRvIHR3byBBU1QxNzAwIGJvYXJkcy4gT24gdGhlIG90aGVyIHNpZGUs
IHRoZSBBU1QxNzAwDQo+ID4gY29uc29saWRhdGVzIEhQTSBGUEdBIGZ1bmN0aW9ucyBhbmQgbXVs
dGlwbGUgcGVyaXBoZXJhbCBpbnRlcmZhY2VzDQo+ID4gKEdQSU8sIFVBUlQsIEkyQywgSTNDLCBl
dGMuKSBvbnRvIGEgc2luZ2xlIGJvYXJkLg0KPiA+DQo+ID4gQmVjYXVzZSB0aGUgQVNUMTcwMCBl
eHBvc2VzIGFkZGl0aW9uYWwgSS9PIGludGVyZmFjZXMgKEdQSU8sIEkyQywgSTNDLA0KPiA+IGFu
ZCBvdGhlcnMpLCBpdCBhY3RzIGFzIGFuIEkvTyBleHBhbmRlci4gT25jZSBjb25uZWN0ZWQgb3Zl
ciBMVFBJLCB0aGUNCj4gPiBBU1QyN3gwIGNhbiBjb250cm9sIGFkZGl0aW9uYWwgZG93bnN0cmVh
bSBkZXZpY2VzIHRocm91Z2ggdGhpcyBsaW5rLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMg
aW50cm9kdWNlcyBhIGJhc2ljIExUUEkgY29udHJvbGxlciBtb2RlbCBhbmQgd2lyZXMNCj4gPiBp
dCBpbnRvIHRoZSBBU1QyN3gwIFNvQy4gSXQgYWxzbyBhZGRzIHRoZSBBU1QxNzAwLXNwZWNpZmlj
IExUUEkNCj4gPiBleHBhbmRlciBkZXZpY2UgYW5kIGdyYWR1YWxseSBjb25uZWN0cyBjb21tb24g
cGVyaXBoZXJhbHMgb24gdGhlDQo+IEFTVDE3MDAgbW9kZWwuDQo+ID4gRm9yIGJsb2NrcyB0aGF0
IGFyZSBub3QgeWV0IGZ1bmN0aW9uYWxseSBpbXBsZW1lbnRlZCAoSTNDLCBTR1BJT00sDQo+ID4g
UFdNKSwgdGhlaXIgTU1JTyByZWdpb25zIGFyZSBtb2RlbGVkIGFzIHVuaW1wbGVtZW50ZWQgZGV2
aWNlcyB0bw0KPiA+IHJlc2VydmUgYWRkcmVzcyBzcGFjZSBhbmQgbWFrZSB0aGUgbWlzc2luZyBm
dW5jdGlvbmFsaXR5IGV4cGxpY2l0LA0KPiA+IGVuc3VyaW5nIHRoYXQgZ3Vlc3QgcHJvYmluZyBy
ZW1haW5zIHN0YWJsZS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGltcHJvdmVkIGNvdmVyIGxldHRl
ci4NCj4gDQo+ID4gSW4gdGhlIG9mZmljaWFsIHJlbGVhc2UgaW1hZ2VzLCB0aGUgQVNUMTcwMCBm
dW5jdGlvbnMgYXJlIG5vdCBpbmNsdWRlZA0KPiA+IGJ5IGRlZmF1bHQuIFRvIHRlc3QgdGhlIEFT
VDE3MDAtcmVsYXRlZCBmdW5jdGlvbmFsaXR5LCBwbGVhc2UgaW5jbHVkZQ0KPiA+IHRoZSBmb2xs
b3dpbmcgRFRTIGZpbGVzIGZvciBwcm9iaW5nOg0KPiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9B
c3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNoL2ENCj4gPiBy
bTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtbHRwaTAuZHRzaQ0KPiA+DQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNo
L2ENCj4gPiBybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtbHRwaTEuZHRzaQ0KPiANCj4gSXMg
YSByZWxlYXNlIHBsYW5uZWQgPw0KPiANCj4gPiBBZnRlciBpbmNsdWRpbmcgdGhlc2UgRFRTIGZp
bGVzIGluIHRoZSBCTUMgaW1hZ2UsIHlvdSBjYW4gdmVyaWZ5IExUUEkNCj4gPiBmdW5jdGlvbmFs
aXR5IHVzaW5nIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW9zOg0KPiA+DQo+ID4gMS4gSW4gVS1Cb290
Og0KPiA+ICAgICBSdW4gdGhlIGx0cGkgY29tbWFuZCB0byB0cmlnZ2VyIHRoZSBMVFBJIGNvbm5l
Y3Rpb24gYW5kIGRpc3BsYXkgdGhlDQo+ID4gICAgIGN1cnJlbnQgY29ubmVjdGlvbiBzdGF0dXMu
DQo+ID4gMi4gSW4gQk1DIExpbnV4Og0KPiA+ICAgICBSdW4gaTJjZGV0ZWN0IC15IDwxNi0zOD4g
dG8gc2NhbiBhbmQgdGVzdCB0aGUgSTJDIGJ1c2VzIGV4cG9zZWQgYnkNCj4gPiAgICAgdGhlIEFT
VDE3MDAuDQo+IA0KPiBiZWNhdXNlIHRoaXMgd291bGQgYmUgZ29vZCB0byBoYXZlIGZvciBmdW5j
dGlvbmFsIHRlc3RzLg0KPiANCj4gPg0KPiA+IEFueSBmZWVkYmFjayBvciBzdWdnZXN0aW9ucyBh
cmUgYXBwcmVjaWF0ZWQhDQo+IA0KPiBUaGUgQVNUMTcwMCBtb2RlbCBpcyByYXRoZXIgYmlnIGFu
ZCB2ZXJ5IHNpbWlsYXIgdG8gYSBTb0MsIHdpdGhvdXQgQ1BVcy4NCj4gUGVyaGFwcyB3ZSBzaG91
bGQgbW92ZSB0aGUgbW9kZWwgdW5kZXIgaHcvYXJtIGluc3RlYWQgPw0KPiANCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPg0KPiA+IEthbmUNCj4gPiAtLS0NCj4gPg0KPiA+IENo
YW5nZUxvZw0KPiA+IC0tLS0tLS0tLQ0KPiA+IHYyOg0KPiA+IC0gU2VwYXJhdGUgdGhlIEFTVDE3
MDAgbW9kZWwgaW50byBhIHN0YW5kYWxvbmUgaW1wbGVtZW50YXRpb24NCj4gPiAtIFJlZmluZSB0
aGUgbWVjaGFuaXNtIGZvciBhc3NpZ25pbmcgdGhlIEFTVDE3MDAgYm9hcmQgbnVtYmVyDQo+ID4N
Cj4gPiB2MToNCj4gPiAtIEluaXRpYWwgdmVyc2lvbg0KPiA+IC0tLQ0KPiA+DQo+ID4gS2FuZS1D
aGVuLUFTICgxNyk6DQo+ID4gICAgaHcvYXJtL2FzcGVlZDogQWRkIExUUEkgY29udHJvbGxlcg0K
PiA+ICAgIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBMVFBJIGNvbnRyb2xsZXIgdG8gQVNUMjdYMCBw
bGF0Zm9ybQ0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEFkZCBBU1QxNzAwIExUUEkgZXhwYW5kZXIg
ZGV2aWNlIG1vZGVsDQo+ID4gICAgaHcvYXJtL2FzcGVlZDogSW50ZWdyYXRlIEFTVDE3MDAgZGV2
aWNlIGludG8gQVNUMjdYMA0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEludGVncmF0ZSBpbnRlcnJ1
cHQgY29udHJvbGxlciBmb3IgQVNUMTcwMA0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBM
VFBJIGNvbnRyb2xsZXIgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEF0
dGFjaCBVQVJUIGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICAgaHcvYXJtL2FzcGVlZDog
QXR0YWNoIFNSQU0gZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwNCj4gPiAgICBody9hcm0vYXNwZWVk
OiBBdHRhY2ggU1BJIGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICAgaHcvYXJtL2FzcGVl
ZDogQXR0YWNoIEFEQyBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgIGh3L2FybS9hc3Bl
ZWQ6IEF0dGFjaCBTQ1UgZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwNCj4gPiAgICBody9hcm0vYXNw
ZWVkOiBBdHRhY2ggR1BJTyBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgIGh3L2FybS9h
c3BlZWQ6IEF0dGFjaCBJMkMgZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwNCj4gPiAgICBody9hcm0v
YXNwZWVkOiBBdHRhY2ggV0RUIGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICAgaHcvYXJt
L2FzcGVlZDogTW9kZWwgQVNUMTcwMCBJM0MgYmxvY2sgYXMgdW5pbXBsZW1lbnRlZCBkZXZpY2UN
Cj4gPiAgICBody9hcm0vYXNwZWVkOiBNb2RlbCBBU1QxNzAwIFNHUElPTSBibG9jayBhcyB1bmlt
cGxlbWVudGVkDQo+IGRldmljZQ0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IE1vZGVsIEFTVDE3MDAg
UFdNIGJsb2NrIGFzIHVuaW1wbGVtZW50ZWQgZGV2aWNlDQo+ID4NCj4gPiAgIGluY2x1ZGUvaHcv
YXJtL2FzcGVlZF9zb2MuaCAgICAgIHwgIDIwICstDQo+ID4gICBpbmNsdWRlL2h3L2ludGMvYXNw
ZWVkX2ludGMuaCAgICB8ICAgMiArDQo+ID4gICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX2FzdDE3
MDAuaCB8ICA1MSArKysrKysNCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfbHRwaS5oICAg
IHwgIDI1ICsrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgICAgfCAxNTQg
KysrKysrKysrKysrKystLQ0KPiA+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAgICAgICAgICAg
fCAgNjAgKysrKysrDQo+ID4gICBody9taXNjL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDMw
Mw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBody9taXNjL2FzcGVl
ZF9sdHBpLmMgICAgICAgICAgICB8ICA5OCArKysrKysrKysrDQo+ID4gICBody9taXNjL21lc29u
LmJ1aWxkICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gICA5IGZpbGVzIGNoYW5nZWQsIDcwMCBp
bnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuaA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfbHRwaS5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
aHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlz
Yy9hc3BlZWRfbHRwaS5jDQo+ID4NCg0K

