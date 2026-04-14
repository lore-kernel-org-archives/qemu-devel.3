Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D553F9D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCgV6-0007cx-Dw; Tue, 14 Apr 2026 12:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCgV3-0007Wv-5B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:20:29 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCgV0-0006iO-UM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xeowkv0M5+s2EfUlGJft9eQbpwlEmJJdDdg4qJ0QGRYLF00syITW8/3VMJmEviHeW34eqpjZCkXFItrssVw0rI7JuVb9pXue31m4qtZif4GZRJCxgbyZIzisgDHTWQziVude5O9sNiw+Qc/Y6ojSh4AUJGIqipOTe5nkV0UYCASfTUHytcG6j2y4/ks3dYqK9+8yEgrbYZ62Mwg5e+qzHHjG/DFL9hDjxQfGCnenL+q7oku6LOQRh2NBglF0GgmNdSrC4a0AP7EpqC8G7O1t+mvydfhaQj/v0CSzNm+iUxTBum2ABIluvzuK22MdNhDZB4YNJ/HnaiknCTvAae5Chw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIDzx/pVWjYLxpUp4zC5KyQXgLaiVeC2DTEMBsPr+sc=;
 b=Py+I9StgoS8MOgAaxrl36NEMaEXHd64GdBOSaS+Qd6piEM3rV1edXZ+ZEn1553NQUQUTM/kkfV0UELrNqo7HZ2iblzUEhbZkwS9Z4fIPYfLOKr1xc+i+wRSuqgaphlH3e0LV0jKpHaAERakhv9vM6kCzJ+xMqqy1xXPr92fxRU4K8pMWNFUwsb1qV+3jodet0HEmN/GA4Y9lRuKgOtBEUp/pJQu8VhTRSrCI0Mpew9YLi9LyVXlfM2nTE8SPFPeG0oipdBGLfnwQNG5GsT76KVxPE/aJOyKTLpDmwDKwDAo91COXYuoMqX+nZUiDWXn4147g1Ju3+GXnAUO48NR2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIDzx/pVWjYLxpUp4zC5KyQXgLaiVeC2DTEMBsPr+sc=;
 b=H2P5Z2AZX0xJJfupF4JsszHJmBHA+7fQ+QXnOCVK9vv+s5LCcvxTF5IC2xdgBReFZGUX0ylUfNnkXGBjpUeA0+2L3zI3rU/1Yrt29DJ1APNoMxoFW3bbcP8MibRymGRQfhtZi+Ep+lhiG4F8W8H5so4+a+9j6WAO8pC6td+EdDxOS5Wh8n7DXVdtLbsOvsy+8YOBjTIBx9IF7CHZ2G1DfPz//8GSRHYmTpaWZwQiw4iu1tVszSM1MQdtbRhFvokyOeYvUiMYldiYAVdTOzJJR1aBALHcn/9X9BZUFLq/bCuDx3SHC57nd8Jabyr5fekmmfFR/77yslxLalY9II2+1g==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by DUZPR04MB9981.eurprd04.prod.outlook.com (2603:10a6:10:4d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Tue, 14 Apr
 2026 16:20:22 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Tue, 14 Apr 2026
 16:20:22 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv5 01/15] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCHv5 01/15] hw/arm: Add the i.MX 8MM
 EVK(Evaluation Kit) board
Thread-Index: AQHcy9DG4Tq2c1qndki/HWXadYKLu7XeiFsAgAAtqYCAAAP7AIAAAqNw
Date: Tue, 14 Apr 2026 16:20:22 +0000
Message-ID: <AM0PR04MB43704378E23DF09B87724B9A87252@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
 <20260414053715.1378021-2-gaurav.sharma_7@nxp.com>
 <D981B877-F5F8-4873-B241-AE20CA354410@gmail.com>
 <AM0PR04MB4370D4D69523579FA7971C8A87252@AM0PR04MB4370.eurprd04.prod.outlook.com>
 <CAFEAcA9sgRbWtPeJ=B58nMBKNn4wciyXOgc0cX6xmPByAimuXQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9sgRbWtPeJ=B58nMBKNn4wciyXOgc0cX6xmPByAimuXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|DUZPR04MB9981:EE_
x-ms-office365-filtering-correlation-id: 5b7c13c6-2e12-40b3-54f9-08de9a41ba7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: MuLj3cx0yDovHnfobkqqP0kPuM+x2yaY+ttGOlkjLykvYHFdkOg/uYJTWehmkumV/Lhb+KoUT8xMVeS2DJFC7McwPd7qucid/c4flJ3pfW+fXFd8Y234FAkm2jAMccLkWx3vvOovT6SzcPyo6RVNrNiXQkDSWBBZT5TNmlV5kvGHYnCFWZzR1GTnOW31rMidOVj88dvNDE0kQvKvyM1pSWlH/BiutdBJgGBN34f2IdrpizU7QLcEi6jzWnec7bStDq7UuiRkk0LGwpLvbKOExiL7RCxdAMR1F2tcn58tlVblXgESO5thZFjUh+5b+/zIh6DnqskEImV4thPoszQgRJzm4hKXRTtHXQpo6NX62fRYLZ4rZ2uNIkuLX9x8b2aaAwspIOBNh80KR/vr37/eubdCH34RWo+VKIo83KE6KEQzOSSoUCklnoTR1e7h2QCpH+sypuoJk7HaY8NgOaj1t02+F+tDtuK6Ay9aoNlKq6G8oDn4/3gpKMiCRzewrA+yrz+EBADTSYKytnKvxygqhHeyRakoc/F/AHatAd1VTigP5z+qFtm26W4urIRI1F74oHkwcidAzhfPWZNJ18vtP6V3dGv+6+yTwrt1tWibKbFimavxK7m8IQ2ZJJ1kBJoEzS/+pUl/YmjJ05sIuq+5aT9kGKUcgQI/3x5+UIk+gg69IuFqq0dbzPte0OIZjjAi7x623ybM7Xjf3tzqGDvU5KJDxSaR+rcI/xVk5FfhujLmRNGCR7mG/JaYgWdT9p/Moeyfhl5pqNp2CuLMIxJn1rYOvREq3NB/OM6Vcso8RHA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzVTYUl4RVdyZ1dvWGFCak12cVJlK3o5QndRZjRVeXY3eWtjcjRJeW5YVWlH?=
 =?utf-8?B?OFlvYzVJWk4vZ3drbnlqVU1mbVp5cURCKzVyZW1rcjlIT1pNWWIvTUNmSm8z?=
 =?utf-8?B?dnVwMVlxN1h5S2ludDNtK1ByVUpyY2FVQnFpZWdSdVYzclRGV2IxclhybVdk?=
 =?utf-8?B?a2ZBYVdibkdwWUNzWHJ3T3BKUThoSUZFVHowRkdlbmxDcnhleFN1ZTBwU0Fr?=
 =?utf-8?B?YnhDMEdrL2VNZ09HZ1VuMUwwQW9hMExRN09YK0NrK2lHai96YVlHN2tZUzdS?=
 =?utf-8?B?UzNUejZ6V2V5NkhnU2N4TGtMcDFKQ1kzMTFUYnpibXdCdXAzQVFBNkZJVmt3?=
 =?utf-8?B?VytYS2J4eWs1UFJENXFzdEJTeXRLOE5uTVkydndTWmpDOXNxNHdFemRVV0cz?=
 =?utf-8?B?NWxMOGRyY1lxTFBHTDdaVDZNRW03S0xScDdkTUNFanFKSWN6bWVqc1RzZFha?=
 =?utf-8?B?ZjJMMTlsQTZFaDBxcnR6REF1bi9IMDVFRFRHSjhpWU1WcFViNVE4b0ptVUtP?=
 =?utf-8?B?ZjRMQ1d0OGpSSmJjRFNQMWEzVDdxTDlmUE1uWnhNaTBMdFhjRkJkVElnQjNm?=
 =?utf-8?B?VXBKM01qN1hKUFV3RDg4andrV3Y5NUFIajRINjdFOHFncTJoMDRzUWFVVDdP?=
 =?utf-8?B?ekhMVXlBbld5VnRZalpWR0JLOGNnMTFqa1dFdlJ5UDRFYkJUTXpnUnVDSU9M?=
 =?utf-8?B?V1VZaFJuM09TVTFNVUE0dFByRVVzS2NZTHRMbEZob0pSbUZjNFFBYUNtd3Vj?=
 =?utf-8?B?WDZIUmxPbnp5dExwMWpTMmozOWhjK2NYVnkwYVdYcTNwdHFrRHZibFJRZFlj?=
 =?utf-8?B?dlp2NTMxYzN0U0d1d0dvWVd1RU9DU2JnZkJ0L2Zvb3FIc1hUSE1NYmJZb1I3?=
 =?utf-8?B?dzNiUzNJYXN3dUNickswbVRDV0h0dzFlSkJsMDVaMGU5c2RlUnNMY0NPN0lT?=
 =?utf-8?B?SlFQazBod0tjMlNzK2M5T011YjZrdTZNa0dZaXZOTklYaFpSMkVJOFZFT2lN?=
 =?utf-8?B?UFE1Z2hLR3lMc1B5NUY5eitXOXlQODltY2x6K0JYbXZBMzQrUnpURG5aN1dv?=
 =?utf-8?B?U05QOTluUWFzQ1gzaXBmRmJjcWJpbTBEQUt5ZVpUZ0pnNnVrSE9ObXo4Q1BQ?=
 =?utf-8?B?cXpmMXZkZnpyaGcrcGR1bjVtUnpoeWE3Um4wMnFWQStyR09XTDZFQTBMejk5?=
 =?utf-8?B?ZmxkWUk1cW9iNXo0eHdrNUpVZG4zOWNQRFdjQkVmeVdSV2wyd28vUFBleTMx?=
 =?utf-8?B?VVBZK3hUSGtQNDVXek9naWdsOXRhdGFlU3JYWVR6cERiMlcvbHZjU3dQT2ZW?=
 =?utf-8?B?TkFaSHVBd1hnYmo0OGlKMUdOckRvUEVtTkE0eTdhQUtJdE9NR3V4b2tnNWhw?=
 =?utf-8?B?SFdUdjhUdWVuZUc3K1FyY3BOdndzUldJVThZeEgyc1Y3MThQTTJodi9aZ3ZP?=
 =?utf-8?B?dVJvMGpKRmdWYzcrQWVxYVNPejRkZU1qQ1ExY1Q3N0ZiZ3lQMnYyT00zSzJq?=
 =?utf-8?B?YU1iU1VGMHV3bjVsMkdMZHpKQk1IdXlpWEl4ajBsNzNCOUd4UTRzQkxIRzBO?=
 =?utf-8?B?NzcvaWxSNHlPSlQ2OFNES1oyQjFZNzZRTjhjNnFubklWNytGazd1S1crc3hE?=
 =?utf-8?B?b3cvYXp0eEpKaURZeEpxc2wrV0pGWnRVeWZLbm45K1dFOFk2MytSMmNNVjVv?=
 =?utf-8?B?ZjNtQmtjaWdjNzlVUG1kRlUvaTUybmlEM0UzQ1hadG5heExxVDZFWE84QjhC?=
 =?utf-8?B?cnprNnQ1WTQ1QkZYMG51djQ1THMvMklYNGF2MTFER3pzaXNxekhDaVI1OGdR?=
 =?utf-8?B?c3RWb0IwRDNCaFIxMFczeE1jRXRmUDAvemlzQWpnM21CaExqa3Q0UG5NV2ZN?=
 =?utf-8?B?cndPWC93NTlJa0cxdjhQMFdBNWsyRUlJQWl4VmI1alFMSk5HYXBrMHNjT3Nz?=
 =?utf-8?B?UEJtanFJOGJoVTErN3RMVkdDVVAwZkV4Zkp4a0U5WGU4UFE4RVl3WmUzZm1N?=
 =?utf-8?B?R3Vqd3lLTWcrMml0RHI0TkZiSHUzdXF6ZTlqTlpSVG9nUkYwVkEyY2R0Y1Ur?=
 =?utf-8?B?N1d6dTVub09yelVxeG9uNTF5Qk55enhGWHFsSENqWGNWbEx3aDMrYVlRL0p0?=
 =?utf-8?B?NUpmbGxnUTl5RXF3dkJ2aEpIOGZBcENLNndseUxNeG8rZGxYc3J2WlFvdDh0?=
 =?utf-8?B?YlprZmQyUFJ2amk2VzNPdnp3QUY2YnZ6VWdwSTdHZnJFWFJpZG1nSm1ZVDNE?=
 =?utf-8?B?eGJJbkRISTV4M3ZQM2dscThNTjNRUWFiZUVmSkdzVG9tNldCVnlteVBISHZk?=
 =?utf-8?B?ZEVhYmk4eUlvR3RmbDJjbkRaeU85bE5FekFPSVp2cStCQUo2dS9OUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7c13c6-2e12-40b3-54f9-08de9a41ba7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 16:20:22.4798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYkcOoG4lzS7x/XLjpZwrfqpH9p8zThR0oldCEhYCwiD8CtWbmbQvZGkXXdOJKwElOgwAfjaoli2ygBgGqwyQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9981
Received-SPF: permerror client-ip=2a01:111:f403:c201::1;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAxNCBBcHJpbCAyMDI2IDIxOjM4DQo+
IFRvOiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gQ2M6IEJlcm5o
YXJkIEJlc2Nob3cgPHNoZW50ZXlAZ21haWwuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0K
PiBwYm9uemluaUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIdjUg
MDEvMTVdIGh3L2FybTogQWRkIHRoZSBpLk1YIDhNTQ0KPiBFVksoRXZhbHVhdGlvbiBLaXQpIGJv
YXJkDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFr
ZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hl
biBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMg
ZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIFR1ZSwgMTQgQXByIDIwMjYgYXQgMTY6NTcsIEdh
dXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBCZXJuaGFyZCBCZXNjaG93IDxz
aGVudGV5QGdtYWlsLmNvbT4gSSBnZXQgdHdvIHdhcm5pbmdzDQo+IGR1cmluZw0KPiA+ID4gY29t
cGlsYXRpb246DQo+ID4gPg0KPiA+ID4gMSkNCj4gPiA+IC4vc3JjL2RvY3Mvc3lzdGVtL2FybS9p
bXg4bXAtZXZrLnJzdDoyOiBXQVJOSU5HOiBUaXRsZSB1bmRlcmxpbmUgdG9vDQo+ID4gPiBzaG9y
dC4NCj4gPiA+DQo+ID4gPiBOWFAgaS5NWCA4TSBQbHVzIGFuZCBpLk1YIDhNIE1pbmkgRXZhbHVh
dGlvbiBLaXRzIChgYGlteDhtcC1ldmtgYCwNCj4gPiA+IGBgaW14OG1tLWV2a2BgKQ0KPiA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiA+IFtkb2N1
dGlsc10NCj4gPiA+DQo+ID4gPg0KPiA+ID4gMikNCj4gPiA+IC4vc3JjL2RvY3Mvc3lzdGVtL3Rh
cmdldC1hcm0ucnN0OjcxOiBXQVJOSU5HOiB0b2N0cmVlIGNvbnRhaW5zDQo+ID4gPiByZWZlcmVu
Y2UgdG8gbm9uZXhpc3RpbmcgZG9jdW1lbnQgJ3N5c3RlbS9hcm0vaW14OG1tLWV2aycNCj4gPiA+
IFt0b2Mubm90X3JlYWRhYmxlXQ0KPiA+ID4NCj4gPg0KPiA+IEkgaGF2ZSBiZWVuIGNvbmZpZ3Vy
aW5nIGFuZCBjb21waWxpbmcgbGlrZSB0aGlzOi0NCj4gPg0KPiA+IC4uL2NvbmZpZ3VyZSAtLXRh
cmdldC1saXN0PSJhYXJjaDY0LXNvZnRtbXUiIC0tZW5hYmxlLXdlcnJvciBtYWtlIC1qMzINCj4g
Pg0KPiA+IFRoZSBidWlsZCB0dXJucyBvdXQgdG8gYmUgZmluZS4gTm90IHN1cmUgd2h5IGl0IGRv
ZXNuJ3Qgc2hvdyB0aGVzZSB3YXJuaW5ncw0KPiBpbiBteSBidWlsZC4NCj4gDQo+IFlvdXIgc3lz
dGVtIGlzIHByb2JhYmx5IG1pc3NpbmcgdGhlIG5lY2Vzc2FyeSBkZXBlbmRlbmNpZXMgdG8gYnVp
bGQgdGhlDQo+IGRvY3VtZW50YXRpb24sIGFuZCBzbyBjb25maWd1cmUgZGlzYWJsZXMgaXQuDQo+
IElmIHlvdSBwYXNzIGNvbmZpZ3VyZSAnLS1lbmFibGUtZG9jcycgaXQgd2lsbCBpbnNpc3QgdGhh
dCBpdCBidWlsZHMgdGhlIGRvY3MgYW5kDQo+IGNvbmZpZ3VyZSB3aWxsIGZhaWwsIHRlbGxpbmcg
eW91IHdoYXQgeW91IG5lZWQgdG8gaW5zdGFsbCwgaWYgaXQncyBtaXNzaW5nDQo+IHNvbWV0aGlu
Zy4NCj4gDQo+IElmIHlvdSdyZSBhZGRpbmcgc29tZXRoaW5nIHRvIHRoZSBkb2NzIGl0J3MgYSBn
b29kIGlkZWEgdG8gYWxzbyBjaGVjayB0aGUgYnVpbHQNCj4gSFRNTCAoaXQgYXBwZWFycyBpbiB0
aGUgZG9jcy9tYW51YWwgc3ViZGlyIG9mIHlvdXIgYnVpbGQgdHJlZSkgaW4gYSB3ZWINCj4gYnJv
d3NlciB0byBtYWtlIHN1cmUgaXQgbG9va3MgdGhlIHdheSB5b3UgZXhwZWN0IGl0IHRvLg0KPiAN
CkdvdCBpdCBUaGFua3MhIEkgY2FuIHNlZSB0aGUgd2FybmluZ3MgYWZ0ZXIgcGFzc2luZyB0aGlz
IGZsYWcgdG8gYnVpbGQgdGhlIGRvY3MuIFdpbGwgaW5jbHVkZSB0aGUgZml4IGluIHRoZSB1cGNv
bWluZyBwYXRjaCBzZXJpZXMuDQoNCj4gLS0gUE1NDQo=

