Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C47C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 09:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh53c-0002pz-Nd; Mon, 04 Mar 2024 04:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rh53a-0002l2-De; Mon, 04 Mar 2024 04:56:26 -0500
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rh53X-0002f4-CJ; Mon, 04 Mar 2024 04:56:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wks/GBsKYJ/FTgHeDQAP8OCpHik8DC/e/Okr7KmiEs8lzO9Za9EIb1Ym3CDnBIIrK6LXziqDZ/wdL56HV9M7br0UtyhRCvhqHVwggbj1QY5CwWpad6aHwQljcChBm8PQYh9cYOnUxLaFXlySzr+az4ft4Cj2C2QGV9FsNh+Iy97sP2NeuoQqhf3Q3cGnOyAcV3POOEpzM8ljkiLBEbe427I1dxDZEWl/9bQzoDOwDg4Rpcn8AdZIfp/bOvPnBFZNG9SRq4ojpF2dtWgotYbxW8OedH7IkVOOUImByNwnItlNt32LgybiH/Nsie/XInqAoCVS1uTKrM69Xm4S18rupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/ggj07rRxBnQTCgxQc96SP93m9uXy/9BOSDOGAh+0I=;
 b=AR7NGomImPHSPtoVo4inEezwwIQVzunJCq62A9MzUOVGMvfy9FUKaQOC2WDUeTT3yu4DP84VD6fy4gtwShoOKAGsTcRLDmRSwJ2VzMKiJDn5POFfgCE99hpZ88zFTG6XAcz9B1wosoU38Jt7l5NkatJhwnwLR9S5cxJFks9RSHsDdC4RsVmodVjxlquKeNDvtEanoLZuF0bul48TUpBami20Mz4H/d4Ic8vVRPlZGG0pHBOQ4EYt/xB7c/HS/Tm3+o86IzUUBzDxl010kIxGCCe2QFt0BY40dMNjFmKUUxG+xl/rBteHDZp5/HvE22/lIIjkii8484scs3CpUGT9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/ggj07rRxBnQTCgxQc96SP93m9uXy/9BOSDOGAh+0I=;
 b=M4SZFLBu+u/y8e5mxpMbPiBajz8PtqjQhpwfimEQZEeGezrw0GnD9dc/8cQmKsbPYmbPaUup3jXur9Fkup9y9cQA68lqMrgKgbnjcvDfP3eBOf0anqLGN+nU2lnCTta6vkWlUGUoTJs5SjTkN5z068b/rn66Ja/EPgKPc4R6vlCceOHkcX6z+t4+TZYTW45awDGD6oTx9+o4vEDwgHVIY4MGSVIniS5FVXM1/WXFTD6ulHkf8umSoTbICuiMk98/RUOMe6aKsbDOL7Xc/P996wIYx7MWOEnr2+7vLEYk+0TkRzAJ/flmvbAlbUMRyVOYhzb7BNOmRwk9Ael7HU7FDg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6242.apcprd06.prod.outlook.com (2603:1096:400:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Mon, 4 Mar
 2024 09:56:13 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 09:56:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
Thread-Topic: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
Thread-Index: AQHaauLiedApTYd2DEatyfju4PLRdbEg8W0ggAAMVYCABmAQ0A==
Date: Mon, 4 Mar 2024 09:56:13 +0000
Message-ID: <SI2PR06MB504190B93104EC157393483BFC232@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240229074234.976164-1-jamin_lin@aspeedtech.com>
 <20240229074234.976164-9-jamin_lin@aspeedtech.com>
 <SI2PR06MB5041B1EA856220BB77B8809DFC5F2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <d6e7d67f-7498-4817-8586-8af216f9d739@kaod.org>
In-Reply-To: <d6e7d67f-7498-4817-8586-8af216f9d739@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6242:EE_
x-ms-office365-filtering-correlation-id: 40da7965-b44c-44eb-3451-08dc3c315381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BjAAcJJQreP3Krr8c4qgW4fcHpjB6J/HcUdgjcrYFOuMbJnpPIR/+8kHraY492rcxS2TSHbuAnfyC7J3qx6rXfBh6l/WafrwfK2qIErArjsM1ZrB1/RCRfqL61nLztezYobHxqRRgIJovXXPCO+kdTkfaCGGLMUPvoT0WMLh0JDdv6YswI4rbl6ihuFls0Wjja/ZzFYCKAUDJTEwzrSW4AKPx5WKwkXF7wPKVHyStgx59AQxSLzkaIKjbpFjb/nsNaXSsdHeBDFEKKvqAxSnX5YJlGOpsbyNYJeo/M0toQKzbRGRE1Fyb7W1a7yshJvbu9G0WjEQkOTTJqavCk7gO3eheujx4wmdzqa5Zr7hIExZhaW0eA0RAp+qmliWHcsn4IBHniHSS9vxooIQ4r4njPhX9Qi99X7BJSGKcucgT+7zzMeOo96q98R96i3OPaKd0x+zXfTzpVizr8o7X8rnQGIxkCk2AUnRKTOUJ9v9e5/O01Rdd6tDstVfvRJ2kajlY7luNeIqMNDqtSHuwptuXHVFBaLM9p3CI5W5v97cwYWcF37lCXrQ4AAzygL63P7bnVf0u7aBDAFy4H97Sic/RYjZD4CkKlpzDC9+wb/TudiR9bzJcd2dnWa/oWFXgaGvIFy8rDh6wI4y6h1gN+mYc/rYone8rfX6T+LrinQZgiQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akV6aWVKWHNTWnpLQUE2V25BSVdnUXFSWSs2R3M4OVF4MHNGYmwyd3c1TmVI?=
 =?utf-8?B?a3h6VmVjRnRQdXdqYjFIYkszdWhuMkZwSzc2bkVhc29aLzRXY25xRWY4WU1R?=
 =?utf-8?B?cG96VkhOa1R1SHNkRjZ5MUlScUhNaTJSckVrbkpia3o5emN3VTFjWkZRS3Bh?=
 =?utf-8?B?VDBZNlhrQWlkMGcrUGpjMnI4aU9IaDg2MGE2ZHJoanVqdzU0MFhPR084eldI?=
 =?utf-8?B?bnhUd3FFUmNtb01ua2RjSFVIUmNMdFZCQWwxVW8reEYzVUlVWnhIcTZLSXlq?=
 =?utf-8?B?K0V3Smw4eXdpRTBKRnpvZEQ5Tk9qVUJlTnJaeHoyM29LT0UzbHp2Tld6T3FS?=
 =?utf-8?B?ODliTlFZK2pYcnFVRmRoelAyem1GSnRBRXYvRWIwRjUxaWdpZ0V5ZmtjM2hT?=
 =?utf-8?B?M2dNSWsvM3hCb1ZOblp3NDg0Tko2YzIvVmwwZGxzTmZQaG54cWVRcDJiM3Qr?=
 =?utf-8?B?UUVTZEI3VXNybnRUcjQzcW5NV3FLcC9jTzNjcC9ZUnp0bUVyTDlsNXFBUjJK?=
 =?utf-8?B?VjhFN1JBbXB4UUI4L09namh2Vko3cjhqNnpWL2RYVmY3clNhakkwZG9IWXBJ?=
 =?utf-8?B?YlBncExCbnBBQjBtdHF0eFBOc2J1eDBXMjNESzBPREJpV3dwT2NVWFE5b3pj?=
 =?utf-8?B?U0xjZ0s1SFJINXhUeGlZWUlJRWhBR0NEQ2lRcEtrVXNaSWZhRkwzK1BNRHJt?=
 =?utf-8?B?alRiRmdzM05ZVDNNRStraXBTQWtiQjRPMTBmRDZmdEdxWmt1UGx0a3I2UXEv?=
 =?utf-8?B?bmFmQW4zUzBvYVl3UzVXeW84RFoyeG1MeTEyL012UjNKNVoyUjdieGhoN2N5?=
 =?utf-8?B?N0JVb3FsODVjb0I3WHJ3c1lxUHJGekZrdjMyOWhveXBXclYweWorRlFjM2Nq?=
 =?utf-8?B?TEc5NHdyUEdPMFU3dXIxemlFZDR5a3owU1pLcWpuZ0FOSFlhVU0yb01vSE1I?=
 =?utf-8?B?K1pDRzBVTmxiMDA5VWFCK1pZWUtCRUtSa003TDhuVlRzdUtFOXBxQ3ZTY21U?=
 =?utf-8?B?UmluWmJTUW5YdU5XcXhiZGU0aDEyTUJOSzFWam5SUEFkOEdmOXRLTWQ4aTVy?=
 =?utf-8?B?MlBRWXlseDRCM09wQ0tGKzhzRTJmZmYzZk8zSlBPeTROMER6SWtwNDU4MXp2?=
 =?utf-8?B?eW81NDhQOWNUZGk3TS9HclVhaW5SVkRCRnY2RnlHTzI2RlpIYWJ0bzQwekk3?=
 =?utf-8?B?V3B2WGd5bHBoS2RKNWdmMUx6TXVIblhVSS93U1J2SmtObXpBemJkWGRBZGwz?=
 =?utf-8?B?SWdTeEFMdnBTdndtUXZJdEhLRi90VlowZDQ5dGRKZnRKUENlMWd1MEI2bVhS?=
 =?utf-8?B?Z0ZTeW1ONjRYVFJEMlh5MFN0ZlFQeTdzSDVJNUxDWHFhK3V3QjMxWWRnQnNz?=
 =?utf-8?B?dVVLcXV4SmJPeld1OWtBRHViZzkvVE5NUDY4U1BSM0MyYUd6TG8vNlJEUW9q?=
 =?utf-8?B?bkViSDdqSjRiK1JhbkswTTdYMDRZWjNwNTdRWmRMbEwvdHE4R3lTREZsTkFC?=
 =?utf-8?B?cE9Vc3RpU2NzcnFkbXBDYWNYUThCaDcvZVEzQzJRd2Z0VGEwc2FSUGNrbTVi?=
 =?utf-8?B?dGVyb2hQdURDVHpMbmV3UUFqd0dHNnBHU2tPams1Vmc1RDlMRkF3Y2NrQWxI?=
 =?utf-8?B?OHJrcXR4L0pjTUxDV2JRQXdrN0hhKzVwMGNUcTMwSjR4SDdiN05uQ3RuR3pG?=
 =?utf-8?B?ZFBlZzdob3hpY1ZWYWRZUWI1Wkk1amd6TE5IN3ErV1l2aDBlODhINmlMMk1q?=
 =?utf-8?B?bXh2V2VZQnRPdktURlJmRDBxVlkrb2Q5RHFxenZwczAraklwNkxlUXhuSDJR?=
 =?utf-8?B?Q2FJR3JFT3B1UHQzTXJDOEpmT1NpNmZoTXlLZ204VjcrZytNNDFZWnJhdHFn?=
 =?utf-8?B?YWwxWXQ3bTcyODZmSWUybWdha2Ewd2F5emV2b3ZGTU50SGlWdmRReTRZV2lp?=
 =?utf-8?B?dyt4VVdEaCtwajZWMTZrVjRDOFBaUjEydGRyOUlEeWtaaWVSZ0pFOWUvY1Jn?=
 =?utf-8?B?MS9zVDNUTzlSclFhQm0vaXgzbWJDSlphb3BNZDY3TjBPZFJiZzM1U1AvRmpx?=
 =?utf-8?B?ckQ5MmlqKzZKamd4TWRhcTcwcEFIZ3lPdkZ4bHBCb3AyTTdLekRFRit6V2cr?=
 =?utf-8?Q?18wcS2sja5IC9Dvr3YzIdeBBF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40da7965-b44c-44eb-3451-08dc3c315381
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 09:56:13.1285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAAUYhqXnMf9iGpqwcR/ZtYKs7wt4zeVvTmj2Ak49jAva4iq2bKw5VVgF+nub2EmUV4M17i3Rl0PRyU1kxklGUQCPniLy6d5DQprXqupFbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6242
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjksIDIwMjQgNDozMiBQ
TQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc7DQo+IGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdTsgam9lbEBqbXMu
aWQuYXU7IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBD
YzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPHl1
bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDgvOF0g
YXNwZWVkOiBBZGQgYW4gQVNUMjcwMCBldmFsIGJvYXJkDQo+IA0KPiBIZWxsbyBKYW1pbiwNCj4g
DQo+ID4gSSB0cmllZCB0byBzZW5kIHRoZSBwYXRjaCBzZXJpZXMgdG8gc3VwcG9ydCBBU1QyNzAw
IGJ1dCBJIGVuY291bnRlcmVkDQo+ID4gc29tZSBwYXRjaGVzIHdlcmUgcmVqZWN0ZWQgYnkgc2Vy
dmVyIElQIDIxMS4yMC4xMTQuNzAuDQo+ID4NCj4gPiBFcnJvciBMb2c6DQo+ID4gcWVtdS1kZXZl
bEBub25nbnUub3JnDQo+ID4gZWdncy5nbnUub3JnDQo+ID4gUmVtb3RlIFNlcnZlciByZXR1cm5l
ZCAnNTUwLVtTUEZdIDIxMS4yMC4xMTQuNzAgaXMgbm90IGFsbG93ZWQgdG8gc2VuZCBtYWlsDQo+
IGZyb20gYXNwZWVkdGVjaC5jb20uIDU1MCBQbGVhc2Ugc2VlDQo+IGh0dHA6Ly93d3cub3BlbnNw
Zi5vcmcvV2h5P3Njb3BlPW1mcm9tO2lkZW50aXR5PWphbWluX2xpbkBhc3BlZWR0ZWNoLmMNCj4g
b207aXA9MjExLjIwLjExNC43MCcNCj4gPiBxZW11LWFybUBub25nbnUub3JnDQo+ID4gZWdncy5n
bnUub3JnDQo+ID4gUmVtb3RlIFNlcnZlciByZXR1cm5lZCAnNTUwLVtTUEZdIDIxMS4yMC4xMTQu
NzAgaXMgbm90IGFsbG93ZWQgdG8gc2VuZA0KPiA+IG1haWwgZnJvbSBhc3BlZWR0ZWNoLmNvbS4g
NTUwIFBsZWFzZSBzZWUNCj4gPg0KPiBodHRwOi8vd3d3Lm9wZW5zcGYub3JnL1doeT9zY29wZT1t
ZnJvbTtpZGVudGl0eT1qYW1pbl9saW5AYXNwZWVkdGVjaC5jDQo+ID4gb207aXA9MjExLjIwLjEx
NC43MA0KPiANCj4gJCBob3N0IC10IHR4dCBhc3BlZWR0ZWNoLmNvbQ0KPiBhc3BlZWR0ZWNoLmNv
bSBkZXNjcmlwdGl2ZSB0ZXh0DQo+ICJnb29nbGUtc2l0ZS12ZXJpZmljYXRpb249NzdGc2VkSXpH
cUZ2czNiRmZ5NUwybFRfQUdFV1ZlY3lvSndaTjdLRFZuTSINCj4gYXNwZWVkdGVjaC5jb20gZGVz
Y3JpcHRpdmUgdGV4dCAidj1zcGYxIGlwNDoyMTEuMjAuMTE0LjcyDQo+IGluY2x1ZGU6c3BmLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20gLWFsbCINCj4gYXNwZWVkdGVjaC5jb20gZGVzY3JpcHRpdmUg
dGV4dA0KPiAiZ29vZ2xlLXNpdGUtdmVyaWZpY2F0aW9uPXNCUFBGZVl5aXg2b1dlQzNHUko2NHpR
TkZMSnBONlNGQk1UOFJYOFp1TQ0KPiBFIg0KPiANCj4gTWF5IGJlIHRyeSB1c2luZyAyMTEuMjAu
MTE0LjcyIChtYWlsLmFzcGVlZHRlY2guY29tKSBhcyBhbiBTTVRQIHNlcnZlciA/DQo+IA0KVGhh
bmtzIGZvciB5b3VyIGhlbHAuIFdlIGFyZSBjaGVja2luZyBvdXIgc210cCBzZXJ2ZXIgbm93IGFu
ZCBzb3JyeSBmb3IgeW91ciBpbmNvbnZlbmllbnQuDQpKYW1pbg0KPiA+IERpZCB5b3UgZW5jb3Vu
dGVyIHRoZSBzYW1lIGVycm9ycyBiZWZvcmU/DQo+IA0KPiBJIHJlY2VpdmVkIHRoZSBmdWxsIHNl
cmllcyA0IHRpbWVzLg0KPiANCj4gQnV0IHRoZSBtYWlsaW5nIGxpc3RzIG9ubHkgaGF2ZSA0IDoN
Cj4gDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwMjI5MDgw
MDE0LjEyMzUwMTgtMS1qYW1pbl9saW5AYXMNCj4gcGVlZHRlY2guY29tLw0KPiANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDIyOTA3MjMxNS43NDM5NjMtMS1qYW1p
bl9saW5AYXNwDQo+IGVlZHRlY2guY29tLw0KPiANCj4gb3INCj4gDQo+IA0KPiBodHRwczovL3Bh
dGNoZXcub3JnL1FFTVUvMjAyNDAyMjkwODAwMTQuMTIzNTAxOC0xLWphbWluLl81RmxpbkBhc3Bl
ZWQNCj4gdGVjaC5jb20vDQo+IA0KPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNDAyMjkw
NzIzMTUuNzQzOTYzLTEtamFtaW4uXzVGbGluQGFzcGVlZHQNCj4gZWNoLmNvbS8NCj4gDQo+IA0K
PiA+IE15IHNlbmQgZW1haWwgY29tbWFuZCBhcyBmb2xsb3dpbmcuDQo+ID4gZ2l0IHNlbmQtZW1h
aWwNCj4gPiAtLWNjIHRyb3lfbGVlQGFzcGVlZHRlY2guY29tDQo+ID4gLS1jYyBqYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20NCj4gPiAtLWNjIHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tDQo+ID4g
LS10by1jbWQgIi4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAuLi92MS1wYXRjaC8qLnBhdGNo
Ig0KPiA+IC4uL3YxLXBhdGNoLyoucGF0Y2gNCj4gDQo+IFRoZSBjb21tYW5kIGxpbmUgYWJvdmUg
aXMgc2VuZGluZyB0d2ljZSB0aGUgc2FtZSBzZXJpZXMsIHlvdSBzaG91bGQgcmVtb3ZlDQo+IG9u
ZSBvZiB0aGUgICIuLi92MS1wYXRjaC8qLnBhdGNoIiBjb21tYW5kIGFyZ3VtZW50cy4gdGhlIHJl
c3QgbG9va3MgY29ycmVjdC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

