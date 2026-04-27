Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084B9FF885D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 03:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHCSK-0002fc-MA; Sun, 26 Apr 2026 23:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHCSG-0002fJ-7m; Sun, 26 Apr 2026 23:16:18 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHCSD-0001dW-MU; Sun, 26 Apr 2026 23:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPiOGkoWJzusj5A8rlEHALAAvg1V0WL8ijTX0Im0g7qLFp6qhYtiEUYvVYwWFE01CkUqT2gi75CGONQC/agk+2H5eyKBUNyTZ9B+obMbvqzl1n1b9QCMNICDBOoTSbEPMd/9uurLf9ijn3WndWsjKRtfk5a3Asl2rADtF3SmSbyTjkWOQQz5WAl6HjRBhniwK9Xk7BNJr3XhsUsgB3rSMuJqjGbGz0J5AsDQEwEbFfpKKpn+Y98KuBzksjROQ3gHP8C4lul/2tTPUhmzVVRIZ8hDL8SGkVYTmzk3+UHEW1Px7DATTjs/fpBRTmXK0q4uVpKeo/ZPAoULifbPSYLEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq5hYqBVtB+/wv7I8rQ9813hMrWQisETNfukuiLAfiY=;
 b=HGYyBnoNMmfoej1xldEuFbLpTtIlDpAdW3KdQQFtZpdW7/WcfxriJ+9pheOnOuktBaVFq8qXTrBys0ZyYbmPBulPEgrBLU0KiRAsyZ8It6/MTUsjBhGvQ1UasXSa9crOk9E9sYVG73XF3FNtgY7c6e8IEybj2XnF8fb3hMtwXtlICzTqBI0DIn350T5w/6KMhDoIdff742ojbU/u0Kq3U93buXMBwHy1gBwr5/iI6XmaIAzW9Lj0GCgrlHWEiSYKmEGhq2/yTPDspYSI0RCLnky26siZfcpb2PhK5o4Viuk+eiBB0xWF8PWSepEKStuPbYjVSWZ438BbAEqspb7VVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq5hYqBVtB+/wv7I8rQ9813hMrWQisETNfukuiLAfiY=;
 b=i2AGRmgJi4CJlGJfo+6rbXgkCP/DJvros/KHV3TJMUtWWyX2+nedrYl1k0Y4SoBV36Nq+NjwY0mEaa1/DmwNHHbqZ4OWb2hQcYpZUneFdhOJNWGYBJQop8rDjOg/py8kHrre/NRpQ+wubtC13KRS70zqsFgWVdGuNaVs8l5VzATiML0MzgjCd4bAi52dzR3H4rfRnKAdHtv/2x5yB8IzR1fOkjJFAVOJMLEcWcFVJlb+1CeeChUrrKMney5FVL3gOKmoqYkS69BNs89qMnItf7eUIk569mrbCizeNUr3adR9NcTkpWC2cGucBniFX93KkPIdxMcGjOy4hj8jFT7J3Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY0PR06MB5307.apcprd06.prod.outlook.com (2603:1096:400:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 03:16:01 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 03:16:00 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>
Subject: RE: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device
 to SBC
Thread-Topic: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC
Thread-Index: AQHcMWF+L2UGo6OJWUyqQMwE3TR2a7XvoCOAgAADVwCAA+D1EA==
Date: Mon, 27 Apr 2026 03:16:00 +0000
Message-ID: <SI6PR06MB76313BC0842AFB0A8C204E42F7362@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-3-clg@redhat.com>
 <CAFEAcA8Dja4yqnaHsXc9pg6EzEAVZFR3=E0sGa9Bz4bvuf+_bA@mail.gmail.com>
 <CAFEAcA8nyngyeWi4Vb=ZWJfxNsyFfSqFJMnWnYG2ce95xaCfPA@mail.gmail.com>
In-Reply-To: <CAFEAcA8nyngyeWi4Vb=ZWJfxNsyFfSqFJMnWnYG2ce95xaCfPA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY0PR06MB5307:EE_
x-ms-office365-filtering-correlation-id: 04f8b962-2dbe-4f7d-9c9e-08dea40b4ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UBsrCW1grQCGdr5C/w4ec3MtsxV9gbJwmVO4CUbirHlnrtxQ58Tg8UqnowEbfXrP2zPwl1SkzhKHjK5kcOOucEfrgkRkAzFCRg6DlmSDfLYSUXgs3HqtU1LKcXt66dUWzgPLCRf5RwayyWfAdsEG/bsyCGrrSNKuWOYDPf6gIV7GTihGcZa+0ZD4tIMiAQbnh64Lh5N1A1e1QxHTLclRJxC4L5DoWJ2AzcMagpvvqyU/RCm94BaF3yEYqGxVKRYozBgZkIj+OybLRJGuUPv/Jf4qniBX4NXnt3T/kVK6RsxhPdP8crD+P4aKEoWb6b1/rk+ai4Yk55zUUjfspEMMwJqj1fuICSStXr0+vn8TBU9NjRuJia3ilMlYYZwSl7rNEXehzb8+Gf5EyMLjPwLe0Wq+LP2e3jlG5fskSQb3XQHYo4Bi9p6A3aSBSYrSesYaAlodOrptZzcLqFM0aZ0lQWZ9D2Po2/QXMNvgBSac8NEZ/kqCn6nUusRqj1dQqBvUSIxmdT2NQ/5BxEtPbOCnEv6ZWhbxLbaXKDh+EZ5gsxomSNKMLzlscr4nmhmYC7QBsiK6BWjdCjFRwv/0s5ydHFy4gS1d5wj3SfIg4uLXXaddg4Y32vQT2GhX4tPKAjYTNV3xqdSQDraTV98CePVRKIR/p60l3fFuL3BlflUtMpTXSqN1lA2oM4S3XyubQAZV8bgrYtsEzs2GvwObTlO2FgJpB+io6qvsIX5Q/5IAE2Fu4JsDg0EubWPWO8yla8oeaBfsOkLOd+20+kYtDwjZUapB+ir6kh0G3nV86gt8Uso=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RElrQlZKQnJtdVdOb1ZuSGpLQUMzUnl2bmtaNFJWMXgxTWY5TElkOGF3NjNr?=
 =?utf-8?B?RzlnRHM0TzNCUEk0UGd3a0IyY1hndGJVclJTVjY3c3JReFpVcUVFdUx0RjhB?=
 =?utf-8?B?OWZZRDJDTGZnRk01eW1YYTZ0c2RhYzdMOUd1dk04NjZBeHE3NDZYRkNGUjds?=
 =?utf-8?B?LzdGdndKcDRLWmRLbWZaOXdvelRoK3A4WmlZbjJ5UHFKaTJPUGJ3Ni82Wmc2?=
 =?utf-8?B?bWpDakplU3JrbUxaOWtzZ2MwU0RnMnA1bm1MVXZ2RXFwQVQrQitXNXhycHRa?=
 =?utf-8?B?RFRlamtnRGNUaUFpNFVsK0RUNmxpTlFRVnpORTN1ZmNnNWJORUx4dHB1cXFJ?=
 =?utf-8?B?VjFTMzZabzZzQnpscE1VYVZ2c0RkKzBnR1V5WExvWFJHSjVOdW1TZGtseFB2?=
 =?utf-8?B?bTVoS2NNN3dUZnJPUEJuWWZ5VVZyd3l1VEVJbHRscVVzQ01TSGNwejRYeDdX?=
 =?utf-8?B?ZXNsQXVFR0tXSHlwSDJ2Q2ZlbW9abjA3eEVRWVNOdFE2NlhleFVMZUJSUGVr?=
 =?utf-8?B?djBmbC9yUE9paGtieVZ5Q2dkeEFUdDhabUdlVXBKcGowMmw5cGE1U1VLNGZE?=
 =?utf-8?B?SFBVRWR2ajlQdFF2N1p6Z05jS2Q4enZIVnRYS0tIdytucUd6Vm94c2xyeXZ3?=
 =?utf-8?B?TXVndFMwbzlOZDlNUHdzb3NlVGlKOVdXcHFFN1JFck1vbnJsem1EaDRtOVgy?=
 =?utf-8?B?ZmxIejY1UXdRQ1ptY2daeGkrbyt4WTljMStDM3pCWkxLQkJVQnk0ZVRHZTIr?=
 =?utf-8?B?a2U2RWtNelpLZURVdTdjMmI4K0NEcVdjb1dzU2Q1bElFUzFjK05DWEdRdmQ4?=
 =?utf-8?B?MCtJWjRlWTlyeE9PMWZuZGhUN3pIRG13SXlreU1zMjZ6NE5vNVFZL2RLVXhm?=
 =?utf-8?B?SVdsRHBkRkZPUkxEQU5FOHlOaDkxNGN6T3d6SUplV01jd25CODhBUUhtRitm?=
 =?utf-8?B?cE4vMjZnMTZhL0FTYnpTTlkwZHhjVzYrVzhGclRXYjBhZ0ZXUSszRGNqdm1E?=
 =?utf-8?B?OEY2SjBRYnV0ck9US1N2THpwdUJMVi9icEZSY3ZIaVY5WHdvbkVtMFNROURG?=
 =?utf-8?B?bnJQQitPODUxbkhMTkVuaGV6M1doblpHOUNDeldtcDVzc21WY3U2MW1TcUNp?=
 =?utf-8?B?a0taTTJ4RFFRekViMm1COVdzdTNUTnFkbDlEMkZuSHFsTms4eHRwZjRMQ29y?=
 =?utf-8?B?Sll6WUVvV1NHNkNrMXZvUkJuUmhleTNzNmR1eE1PSzV6RFlVd2pMYmdIczQ0?=
 =?utf-8?B?Q1hoVHBKNTVrVFlpM1JIYWxNZ1NJRjlHVzk4YVhXcHN3b3J6cmpjTHBRcnVi?=
 =?utf-8?B?enBvYXZSdkdlSXBTVnlZRWdvNkxuYm1yUDlYam1Gd3ZOQ2JHbUNsUW1USjBr?=
 =?utf-8?B?VmV1OTExeVZrYzlCaHFQeTVySjA5S2JVNVp6MEFORkF6UjZpcERaZ1hvZVFS?=
 =?utf-8?B?WVV1UWJLTG1mS1JkRXVKbXNmSEdqWFpHd0dhaVJUdmxTWmUxU0k4R1JQTEFZ?=
 =?utf-8?B?VHk0YXRzZU9QdGZjem9vTWRDTWozaERUMVZrc3BoNXl2VVdVUGhjVUVzVExS?=
 =?utf-8?B?QlNEZTVkWkZ0dFFRU2QzUnowbnZYbHFlQzR5QWtER2pLS2w4UVlIcStXTjZ4?=
 =?utf-8?B?S1BFbUc4WE0xZkxvcHQ2UHFsSEJaTkEzWDFDVkgzblFBdXRKdTVSbFQ3QkE3?=
 =?utf-8?B?UWdUb2U2UnEwOUtoc0xOYXltMFkxczI5SWxabWk5enFRTjIxVnduZmZ2eTRy?=
 =?utf-8?B?R0RFN0ZyR204UFAyMzhSQ0JReXpsUlByNW9VaStWMkEwRjhuRmxMakExdFlG?=
 =?utf-8?B?SGoxUUhHMktpaUFJeVhvSHJWdXFMaDBoNUdLSWZIb0xwOXFwUzYzSjQ4NS9X?=
 =?utf-8?B?b1F6QzU3K0w5Ni9iS2U5bHUyK3V6UzF5ZE1pTExRMDZWQ2hmTjJDOFozdHd1?=
 =?utf-8?B?Zm5tOWtVNWJnSHJSQUtIZ3N4K0dhN1BvQklBSWtLMDEwNHpWb1IyOTFrMUh6?=
 =?utf-8?B?ZWJ2M0ZaZ1BLWjhLcU8reW1qalZSZ2Z5VERleTdFK2k5YXNjbTgwK0xneUdF?=
 =?utf-8?B?MWh6SERHZVNycEt4QVQyUUhNZ0kzeWloK3lpV3FneHhLMmVoUjZlaVo2dGNt?=
 =?utf-8?B?WDRRWVpJMklMZ3ZieGVYZW9PSENmb0ZQZ0l0M201LzR2RWNzMFYxaURReXhk?=
 =?utf-8?B?bnhCVTA1M3o3QlduWnovcXo1OGtoOTJlcVhqR3B1MlJhMHRMN2hSVkJNdCth?=
 =?utf-8?B?UEJ1VVhaZ3pUaWpyZHJKM09QaVZtL1NGbXZGQ0JrUm1XUWJ0cWdnbm5YMUVZ?=
 =?utf-8?B?SFphb2d6ME42ZzJzRCs3TWhDZ1JwVGFhRDFkMmFJbk1wbTV3ZmgxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f8b962-2dbe-4f7d-9c9e-08dea40b4ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 03:16:00.5738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TBfGdCOizVBeRhP3py/TVn+olLOGZA7SGEGvuE+exiA1CSNFMtHH0wF0PmdTD5Sd/dvmeURNfnY2pAAx+UZxU36Ifdj6Tb6AQck3X0xK0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5307
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjYgMTE6
NTggUE0NCj4gVG86IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gQ2M6IHFl
bXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgS2FuZSBDaGVuDQo+IDxr
YW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUFVMTCAwMi8zMl0gaHcv
bWlzYy9hc3BlZWRfc2JjOiBDb25uZWN0IEFTUEVFRCBPVFAgbWVtb3J5DQo+IGRldmljZSB0byBT
QkMNCj4gDQo+IE9uIEZyaSwgMjQgQXByIDIwMjYgYXQgMTY6NDYsIFBldGVyIE1heWRlbGwgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gQnV0IGhlcmUgaW4gdGhlIHByb2cg
cGF0aCwgd2UgdXNlIHRoZSBhZGRyZXNzIGZyb20gdGhlIGd1ZXN0IGRpcmVjdGx5DQo+ID4gaW4g
dGhlIGNhbGwgdG8gYWRkcmVzc19zcGFjZV93cml0ZS4gVGhpcyBtZWFucyB0aGF0IHRoZSBhZGRy
ZXNzIHRoZQ0KPiA+IE1lbW9yeVJlZ2lvbiBpbiB0aGUgT1RQIGRldmljZSBzZWVzIGlzIG5vdCBu
ZWNlc3NhcmlseQ0KPiA+IDQgYWxpZ25lZCwgYW5kIHRoYXQgaXQgY2FuIGhhdmUgdmFsdWVzIHRo
YXQgZXhjZWVkIHRoZSB2YWxpZCBzaXplIG9mDQo+ID4gdGhlIE9UUC4NCj4gPg0KPiA+IFRoZSBP
VFAgZGV2aWNlIG9uIHRoZSBvdGhlciBlbmQgc2VlbXMgdG8gdHJ5IHRvIGFjY291bnQgZm9yIHRo
aXMNCj4gPiBkaWZmZXJlbmNlOiBpdHMgcmVhZCBmdW5jdGlvbiB1c2VzIHRoZSBvZmZzZXQgaXQg
aXMgcGFzc2VkIGFzLWlzLA0KPiA+IHdoZXJlYXMgaXRzIHdyaXRlIGZ1bmN0aW9uIHVzZXMgIm90
cF9vZmZzZXQgPSBvdHBfYWRkciA8PCAyIiB0bw0KPiA+IGNvbnZlcnQgdGhlIG9mZnNldCBpbnRv
IGEgYnl0ZSBvZmZzZXQgYmVmb3JlIHVzaW5nIGl0IGFzIGFuIGFycmF5DQo+ID4gaW5kZXggZXRj
LiBCdXQgdGhlIHdyaXRlIGZ1bmN0aW9uIGRvZXNuJ3QgY2hlY2sgd2hldGhlciBpdCdzIGdvdCBh
bg0KPiA+IG92ZXJsYXJnZSB2YWx1ZSwgc28gSSB0aGluayBpdCBjYW4gd3JpdGUgb2ZmIHRoZSBl
bmQgb2YgdGhlIHN0b3JhZ2UuDQo+IA0KPiBJIGZvdW5kIGEgcmVwcm8gd2hpY2ggdHJpZ2dlcnMg
YSBjbGFuZyBhc2FuIGZhaWx1cmUsIHNvIEkgZmlsZWQgYSBidWc6DQo+IA0KPiBodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzM0MzYNCj4gDQo+IFdvdWxk
IHlvdSBtaW5kIGhhdmluZyBhIGxvb2sgYXQgaXQ/DQo+IA0KDQpIaSBQZXRlciwNCg0KU29ycnkg
Zm9yIHRoZSBjb25mdXNpb24uIEkgcGxhbiB0byBtb3ZlIHRoZSBhZGRyZXNzIGNvbnZlcnNpb24N
Cg0Kb3RwX29mZnNldCA9IG90cF9hZGRyIDw8IDI7DQoNCmZyb20gYXNwZWVkX290cF93cml0ZSB0
byB0aGUgdXBwZXIgbGF5ZXIgKGFzcGVlZF9zYmNfb3RwX3Byb2cpIHRvIGVuc3VyZQ0KY29uc2lz
dGVudCBiZWhhdmlvciBiZXR3ZWVuIHRoZSByZWFkIGFuZCB3cml0ZSBwYXRocy4gVGhpcyBzaG91
bGQgaGVscCByZWR1Y2UNCmNvbmZ1c2lvbiBhbmQgYWxpZ24gdGhlIGltcGxlbWVudGF0aW9uIG1v
cmUgY2xlYXJseS4NCg0KSWYgdGhlcmUgYXJlIG5vIGNvbmNlcm5zIHdpdGggdGhpcyBjaGFuZ2Us
IEkgd2lsbCBwcm9jZWVkIHdpdGggc3VibWl0dGluZyBhDQpwYXRjaCBzaG9ydGx5Lg0KDQo+IHRo
YW5rcw0KPiAtLSBQTU0NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

