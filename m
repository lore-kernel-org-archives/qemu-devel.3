Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9262FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXSc-00028f-6v; Fri, 03 Jul 2026 02:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXSZ-00027t-In; Fri, 03 Jul 2026 02:33:12 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXSX-0000gS-Mu; Fri, 03 Jul 2026 02:33:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzWPSykZ43sFVEXEBHeMzwDl29BGhELx+SBfF0f9BnVuv4z8qDCxckfAmO3ofjdDzWcXu4ZznvYdExN3AN25/fBLt8TxnDYap28nYP7pkKwLXqYTRJMDpAnMei+81dtQ1FAXj7rX3H4eaxuWTcixq+TxcWiBKaqt2AXfRWiAXUd/60js70rfHC4hgH2unJOGKjKnwYhNBeXm9DVU0Dwq3BZql7XcZf924p16VEVKXc/B3rfzEPHBGICNFpFKlhQmefMIljNPmOaECeHz84GI2mZrr3yLZ9dd8HY+av/3+36WMIP0Tlj63l/gIItc4oYMVUmFU1fyv1vKodKIEZRN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm4g8JxoTvi25xPG5lezkEnnOBvHyP+Wvoa4GrGbmIw=;
 b=uuy2iAjhRvyf8Az3ZcxGQ+XAToevc/RgJ7EnUOeOa1XvQUD3QEJU9fZBbi+te6RP98Ikgy1Pz+7DsamxQiuJME0aeaqMjzpte0vswccsr9ZP0fxyDKZ44QfW2CbHYzMZnyRBVKogeEUWDIZw7fbw7JWvldVT0Et87cx+zppiiHB4zL5ExQYRVkOuedlI8bvK7Bt1i1vAIDe7s7hNZbnufKxjWS1vJlgNRzZBa2CjUMOKPCZTW5ZyJTojljf4kC8zKGoSYCWpjXMmM2Da6010UGUH/e8TdPqym57DaC/AsBDu8zhFaEbZqTfVZIFKSCL0ssL8rYZJZBFITm8lsrU6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm4g8JxoTvi25xPG5lezkEnnOBvHyP+Wvoa4GrGbmIw=;
 b=j1c/sym/BclgYNCCvYtZrO8wwPyw73/2yBt6IG0lKybXLuYGOC7SSmMsnEPznCvBSPqxAYV1wfLKuBL8QXXjAdZc45qwEnlhzDcI0r8i5JO7RbBg4Qr9e3kPdCVwSl6gKb9mu3RScIAizNyNy+npghEMLV4/oOg09frls6NV5m05NNSjlclP2hFO5YnY2PovQNnjtVK81oTWEFbTnV97mMX9X/KHhx9q8sMlCojeY8iTxJNMPlt22nCo+X29YcPuMmsL6XrhMmTBu1n+EKv4oCOlJC+jLxzuoUrBVDUnyUSm7bHMyfjqhfB7Luh9Yz1PJXkhioYGchI72BtJRxdjTw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5819.apcprd06.prod.outlook.com (2603:1096:301:f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:33:00 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:32:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap
 settings
Thread-Topic: [PATCH v4 19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap
 settings
Thread-Index: AQHczhpW0uXv0YCWFUyr/F146QByDLYqOnuAgDGUi0A=
Date: Fri, 3 Jul 2026 06:32:59 +0000
Message-ID: <TYZPR06MB49804C41AF10DB142C2DA295FCF42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-20-jamin_lin@aspeedtech.com>
 <845631ed-6a52-4068-a002-92c3f70dc4df@kaod.org>
In-Reply-To: <845631ed-6a52-4068-a002-92c3f70dc4df@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5819:EE_
x-ms-office365-filtering-correlation-id: b455928c-952c-474f-3de4-08ded8cced2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|6133799003|56012099006|4143699003|921020;
x-microsoft-antispam-message-info: RqxwNJp/0MZ+lIWNdgLOUEtQ4DhaCM328OLWUxJxmDjIulJ08raBcd+kxyFmsaiiCeJrojtPW3LCKxsiisJylt+9V6PLUjQ9O1kM9lHoygy8V0yIZXVygqHPBEZ03NwwcoUWpy9t6LMY8VwwTChlWcAenVdPTmpuYwjzlGxF6zaxXGuwlqklA85PMLX8AG5QQXbyix4s/lK7e6qH4LGPhRU973YaJlVt0JRR4gKt3EY8Ym3momT1VF8tWks21stUom+NwOTsKnUGGSss+MscetG/oTN1Y09Ny4LC2WeID8m4uswe9wmgLq2cOqDYq3EX+CqWTbiTtnkyZlp+Ei6uVR7t8JqYvj5jjnilVSWXpcol5rRDdesCCrc59J+IZcm7W71zshgSwxizet/Iu1Q3QN5L+f3bTiybagKUxie/whFyNSyMm+GyBu8W7l6455rRzUWJ/IM1X21hIBi5IoklUR/u4oRq2Lm259F2A4t2XpWxWEeR3ajeul/XjeM1s8EFY91NcyiSDWHNdIJrYwMB8ZyoiiJxku+cb+DpEHwPQbi9Gx6Dw/M6g9Cl+l3R47+F0Ih7DERCSDRhxlmzxLlz4qvinx3gHG4Um1+fHicFlQnzdin3hafp+3aMdXOR7d+RmZZd72+XiaPP7EVkL7hSSNP0aWm47c+IX17LNqwYfH0NwoYjK+CtGkq4JWTq/5ihCmTQX8/uivz60JEvBoMGhs7ujEm3rhuRdGzFJQqsoQOuEuQyIfPUW+JVnqanmI29
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak43dm5QZU90R1V6dFFuTlU4NHlqcUF1WXlhUkx3YXc1bXY4WllWaUVlYzVG?=
 =?utf-8?B?WnB5YXpYSTMya3BJU1F4NVFxOHZaWUlYQWx2Ymh5MU8zZS9RS3FkVk55TGZ1?=
 =?utf-8?B?VVpNZVYwVml0Tkc4S1diN1prYVNhMFRmMDc5M2IveWZQVXdVNzBoNHBlVFpu?=
 =?utf-8?B?S2ZnZGVPSDdmZEZSbjNCbUxLRGV6WnVkRUdOSko2Ukg4bkJvaTZ5WjRaMjEx?=
 =?utf-8?B?dXRpS1FkUDdFS1RHZnEyV2VYWFdCNzl5WVQ5ODVCdDdLWENSaTd0MEwrUm5P?=
 =?utf-8?B?SThiaEkvSFdFRjZBVWtPQjNOdUVLR3VPcStuNEk4UUY1U0ZROEhlVzVCQmZX?=
 =?utf-8?B?bEZqZ2RUVDRyWDl6RzNyY25VMUpYcHRtL3NhTU1CejNXNmcvandhdXR1NkFz?=
 =?utf-8?B?SHJ6SExoWUhHSW9GNmg2dk50N2JIaXRROWlhNGtadUF3K3dRdXM4Z3BQMVdD?=
 =?utf-8?B?MzU2eUpXZFVDYmZxbUlvMEduWVZKcG5zUTd4d0k2TjhPTVM1dDk1cVdURlVx?=
 =?utf-8?B?VkQxaHNOckFjZU5aK0pDZWRLNklBVy81WElQUzNjZ0hRaHh0N0FuLzBxSk55?=
 =?utf-8?B?R3g1bVAwcTVYOEtXeXRNbldxeFlsUGEvTm9Vanp5Y1FDbDFYdFgyQTFid3ZU?=
 =?utf-8?B?UHM1c2tSWmdsVHlNZ0V2MTdETStjcW40SlJ3MUthN1Z1ZDMzVEJCTXRINkV4?=
 =?utf-8?B?WXlIWVBQdGRlTyt4VWVqeDNadk5LWVdOUU5ET0tCZGpvOFdFeTVibGgwanBP?=
 =?utf-8?B?bFU2M2h4NmRLcFE2cTVZbStrVVVFeFAxRHdwSU1QYzlET2RLN2N0Ym9scWFY?=
 =?utf-8?B?bnRCMWhhMDZieWFxUXRhQ2lRN3lIWEF4ZCtUdVA4TGFVbDNWM1h4QklhV2ZI?=
 =?utf-8?B?WnBmNkcwaFB5b2NkSVdoQ09QOVZIQ0FaWEY4NU50cmxDWjVFNkZEWVhlMnVB?=
 =?utf-8?B?YXpXd09ETU4yREM4cFU3ZU9xcFdhZzFBWTliY2srci9JeHhYNmErdVBwTXBX?=
 =?utf-8?B?SVJ2clprd3d4RXd0UGZuanVuQ2IvZU1xQ1NXUW9JSHU0d1lBOUV6ZDRsZDVW?=
 =?utf-8?B?K1hGaTN1eG9QTVY0bTRUeDcyZnp3M2hkQUVJb1VxWVdIRDJKQ04ya0k2d0kz?=
 =?utf-8?B?cktIMEpjRlg3TXkrLzNGVUg4UHlPalBET0tFOGpnR29GRHJJczJYdG9wUG5j?=
 =?utf-8?B?bUxXMzFNQjJmQ0llcVlnK3Q2RzI0TFl3NWdZNE9lT0VhZmtrejBUUENtYXNm?=
 =?utf-8?B?aEV4V3RVaC9CdEF4UnZFL2ErMDRDSWxpc052K0luM3k1eFZOaTlzR1lrNDJh?=
 =?utf-8?B?RzNIUVhVQTJzbWt3WE1mWkhVTi9lTXdCWmd3ODVxOGkrOHlFcGtkWWRSSGlM?=
 =?utf-8?B?enNMMlVJeFUxK1N0SnhxWUdYTUpvMUxIeWF5M3liWVRnWURlZDBSRW5sM3B3?=
 =?utf-8?B?Zi9kVlBKN3NOQUxzVzdSc0ZIUGlpRXIxSkVBZGpoM24xR2Evc3daU0l4cCtY?=
 =?utf-8?B?Z3lpVDBZNHE5V2g2eEdJVzVlaHFuSHFSVktqVGt3TEpJeHhkcnpROE1XbTg0?=
 =?utf-8?B?ZWtzZnZzZzB3MlMxaXhLRVkvbGNvSStKWnhTbzIrV2FLZWZNTmtkUGwrQ3Nr?=
 =?utf-8?B?Z2w4YUQ4cjRubFdTSlpTYTVuSDl5N0ZUNm5qcUlGeFpKaXJkRjVCN3FFcXdv?=
 =?utf-8?B?amZrQmRqblJTSzA5TVA1TFluYUlubGJpMEgxQlZQcllLTzRaMktTNDgyd2RP?=
 =?utf-8?B?QTRjZlVRbGltcTY3WGdKYkgzdFNQQmFHNkd5emtHTkhRTlR1L2d6T2NjQkNX?=
 =?utf-8?B?UVJ1UkJ0VXVWR0xxeTFBWXFqUGV4MWhKdFN1R2RVNGFSRjRpcTVkR1BqMVZx?=
 =?utf-8?B?YmxVeEtrOXBxLzJEK2gwYTkwdG1DYkFFeDg2OEc2UHJldFUxQnlXbSswSHkr?=
 =?utf-8?B?Q2Mvc1hnbVBhS3JLV1Z6eE8vaTVQelNmR1ExY3RjZXRUVUhYRVRTRkJlSzlU?=
 =?utf-8?B?SVdEejRTQml5SGFpQmZ2akdxOStGbWJ0QzBZaHAvRHVmNk1URHFkUXVVeTY3?=
 =?utf-8?B?eDJycWpmL0FDRUV2UUc2c1NaSGVXUEtaYi9Sd0kwTnJuRVNsSzlSQkJTdTA4?=
 =?utf-8?B?ZDZuclJpRjJycDJIWEl3U0hYMk5kNUMwanRaY21MZVVQVnNQNWcwZytiUUpw?=
 =?utf-8?B?eFB5ZGVmbzdmbEZaMXRwUEJudXVLakpuMy92aGh5TDQ0aW1SODN2N3NReWcz?=
 =?utf-8?B?aFlsSTFpbjRzaXhVSXVnODNoWS9FdG1wcW0xVHpHOWRyNitEMXVsYlB0akRV?=
 =?utf-8?B?M3FNWHd0eG9MRHdaS0RzR3NrSjJ6elZzcTFubTI4Z3lsQUZ5SjVEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z7n/87GJrzV4latyoGvyhQZf/1XTRhsNc1FrkXFtwY6Q1az3hZHWhXxnCZINZkfJtx/sVjhjzmpOdLcyu2RKf/IU/L4ZZgG300oP1MXl3LoLUsErMyH16EjTtsC5aUE9H2B6F26COp0vibqAdS+Iz5caM2Ccdb45R9ajxT0UchiTzJYRXmRqykBcvauAlsCIaq5SDjReqIQ8ra7uDEhTgzkvhCIAk6/7JmkqFU9RRbp80JXDTrW9TBbqH8gnb1iM5iCibjjPx47y18EjVfVUOqrx6F2QgWJmO7VdIET0g8KclSx+2/AbqmbjtK+G+ZlH7PlGacPtqefyIlW4bPvy7Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b455928c-952c-474f-3de4-08ded8cced2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:32:59.6781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQQpUWtyFyU/9KCi5SbgQJUBpONl5+8rV3/Z1Zf4ZIz2MQgA0fi9YfGc5YI499Ousv6rJz67lciitTCLlBuC9RsnxlTpqyTD7bq4mOguWKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5819
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDE5LzIxXSBody9hcm0vYXNw
ZWVkX2FzdDI3eDAtZmM6IEZpeCBoYXJkd2FyZSBzdHJhcA0KPiBzZXR0aW5ncw0KPiANCj4gT24g
NC8xNy8yNiAwNToyOSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZSBoYXJkd2FyZSBzdHJhcCBz
ZXR0aW5ncyBpbiB0aGUgQVNUMjcwMCBGQyBtYWNoaW5lIG1vZGVsIHdlcmUNCj4gaW5jb3JyZWN0
Lg0KPiA+DQo+ID4gVXBkYXRlIEhXX1NUUkFQMSBhbmQgSFdfU1RSQVAyIHRvIG1hdGNoIHRoZSB2
YWx1ZXMgb2JzZXJ2ZWQgZnJvbSB0aGUNCj4gPiByZWFsIEVWQiBkdW1wLiBUaGVzZSB2YWx1ZXMg
YXJlIGFsc28gY29uc2lzdGVudCB3aXRoIHRoZSBjdXJyZW50DQo+ID4gYXNwZWVkX2FzdDI3eDBf
ZXZiLmMgbWFjaGluZSBzZXR1cC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9h
c3QyN3gwLWZjLmMgfCA2ICsrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVk
X2FzdDI3eDAtZmMuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jDQo+ID4gaW5kZXggZDFm
ZjZmYmQ0ZC4uNjlmMTE0ZTY4ZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3
eDAtZmMuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jDQo+ID4gQEAgLTUw
LDggKzUwLDEwIEBAIHN0cnVjdCBBc3QyNzAwRkNTdGF0ZSB7DQo+ID4NCj4gPiAgICNkZWZpbmUg
QVNUMjcwMEZDX0JNQ19SQU1fU0laRSAoMiAqIEdpQikNCj4gPg0KPiA+IC0jZGVmaW5lIEFTVDI3
MDBGQ19IV19TVFJBUDEgMHgwMDAwMDBDMCAtI2RlZmluZQ0KPiBBU1QyNzAwRkNfSFdfU1RSQVAy
DQo+ID4gMHgwMDAwMDAwMw0KPiA+ICsvKiBTQ1UgSFcgU3RyYXAxICovDQo+ID4gKyNkZWZpbmUg
QVNUMjcwMEZDX0hXX1NUUkFQMSAweDAwMDAwODAwDQo+ID4gKy8qIFNDVUlPIEhXIFN0cmFwMSAq
Lw0KPiA+ICsjZGVmaW5lIEFTVDI3MDBGQ19IV19TVFJBUDIgMHgwMDAwMDcwMA0KPiA+ICAgI2Rl
ZmluZSBBU1QyNzAwRkNfRk1DX01PREVMICJ3MjVxMDFqdnEiDQo+ID4gICAjZGVmaW5lIEFTVDI3
MDBGQ19TUElfTU9ERUwgIncyNXE1MTJqdiINCj4gPg0KPiANCj4gUGxlYXNlIHNlbmQgZmlyc3Qu
DQo+IA0KU29ycnkgcmVwbHkgeW91IGxhdGUuDQpJIHdpbGwgc2VuZCB0aGlzIHBhdGNoIGluIHRo
ZSBuZXcgcGF0Y2ggc2VyaWVzLg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+
IEMuDQoNCg==

