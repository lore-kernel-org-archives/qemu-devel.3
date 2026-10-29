Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=jJlmfSha
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKoe-0001ZM-T1; Thu, 29 Oct 2026 03:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMKoP-0001Yk-Tf; Thu, 29 Oct 2026 03:44:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMKoN-0002hZ-7J; Thu, 29 Oct 2026 03:44:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkFbAVXV0BS4qoMu2NbDqn8PTMHcMaT7lIlOeJjWpEnM2yYOfNbqf3nTggvYkWsUtvXtDo68hMhMgH+9XV7eKfFH70HCHkb8oTrYGMl2xg6rW9Gzi+/vms8czn3PH1e71jtYqvceRZr5xTreozfSzwAtLsLt2LJEqApauPYl9KtHbaLxm7JKcxUMwJFvoQKBiF5Clcx4kZovHqWA1HGuoPWgusI6Iz3yyaXYj39xLEyLukmvpJpWhA6KB4/GEt6Kj9xQMA6BfJGmalF8MOMk/OQ2eLkD2/P5T2AjGI/I/yi8EtVA55Ln8Pf5uyOfr28f+nUnKvNyL90P4yrE7ZWXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZejXDiGvDiy9oAF/ILWTIfw5lhTMNCzzUSdqxnVpY8=;
 b=Sbtwhe6thPvIvQemiltkaekYF977NXipAVIP0BkX0VzWg0c2eROg5lvoM5oIve7s8OV+gY8ukvoaWgPgTMC+kgzp2Vjgc+yv24JdWBZEqJgRA7OKjEeg0o18TwTeV+xGgJECI/chxX7K5Tb6gy30dWNpsBJ2A7oA/II9do4hL3rVI2U4YsOZeucfF8qX0Thd+xUabbWujExCAiqKCvFvA8mj2udCC1eeg6ILTQnaiUo8exRqoHNK5nTaDW0b82KWTX/Iu+Xgt+rzgGo7Jh7FCslRzg+GLtow9G7/r8h3vyYw2nGRSeVLUjOXvaw91WA2YvxB3N04oDgdUZrdcL6OCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZejXDiGvDiy9oAF/ILWTIfw5lhTMNCzzUSdqxnVpY8=;
 b=jJlmfShawcUh+AZv6KvFH6TZi8IGgEL4/QDzolfTOUOPyNYHa/Trk5qHR3A3XGyQjoEiQq197GThLotuu1UbkJsT7qLruf/tt9HJSVHFMxdbaBcSmJBiD9/h/eGSrEOhwcaE7wuZGnrnLrcRmqsEzckqWyXIlO4wZ//NauUJPAB/LiD/Qb1lMff60mOe+VnEorVs1GQ9GhLm/Ppv11fBEiJ68fEAxITqJyoet8mydCKLG2URfVh7uekEsGzV4pCqurrIjMTu2IH74OhbarKTZwz80l41fHqA9ekeSvnchgxDk3s1CiCdF3eJyDSJNAqmFOYiKBfFi18wyWhba1zk+A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUZPR06MB8968.apcprd06.prod.outlook.com (2603:1096:d10:86::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:44:26 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:44:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Timur Maksimov <gessingate@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: RE: [PATCH v2 4/6] hw/i2c/aspeed: fix buffer transfer in non-packet
 mode
Thread-Topic: [PATCH v2 4/6] hw/i2c/aspeed: fix buffer transfer in non-packet
 mode
Thread-Index: AQHdZky2/95pPIU7nkuaAUSRDZXVPLcUD8NAgAAQToCAAAOlgA==
Date: Thu, 29 Oct 2026 07:44:26 +0000
Message-ID: <SEZPR06MB7362E41CDA36CBE3ADB0F286FC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-4-07deed1dff60@gmail.com>
 <SEZPR06MB736293095EFE3149F167A71DFC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
 <15aa908814cfe5e3fd3d0ac4c7b3bd043b28df36.camel@gmail.com>
In-Reply-To: <15aa908814cfe5e3fd3d0ac4c7b3bd043b28df36.camel@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUZPR06MB8968:EE_
x-ms-office365-filtering-correlation-id: f04e9a4b-83a5-41c6-3378-08df35907515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|261028144727099003|56012099006|4143699003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|10067099003|38070700021;
x-microsoft-antispam-message-info: IzjyghuMhr+Z5TqA2gpTVL4eShJVazdaE0wM+X1432/iWkh2EppJGqA8ZshB8dBoAIMeYFKoGesfLYFwNwWAwdje3rtLAM1xJVu/S3VJv5165KRZmbW9nLuxgQbtO2pXij1drBbMO4fN8MHYvVY0gCrW7sM5gE0JW0ImpmoveIDNS9ck/G2mAso6LASP6FuprEr98nU2hu9PI1Y8jzZe0ASfeLRJ0lRdEFlrh+mJqXUX6Ry/P8QNeGv0XjSJPoN1uDg7VamV7eIn13gtzpMYKejrnpsN+jyOuYThyoDCq1vNGIhHhf0aqfmWqlwqhgZ/5sUI1IPmAsPDeQ9k2wkiqHWJuitUyeCs0qHrMujiKpTROeRZtNwOlYH+zaRaVmsKQdUJ/57DrLh+fpRPqyOUhhKnud8fcuWl0XU56Iuhb/lM5jm1cW/OC08kJZlQbhmmzFZ2PgPen86cWpULIeMKSX1ain+/CgDFt+JIAfJbchNRdMJC6EVntp6p6gqWhTnCVsp9JIvVu8JJJN2Qs6PmT92wBPMfb9B8UqIV7fZ9uYCnoR9egfHOnQeRiYBNBJSOMztQGAPaXVzFfTaLeMjxvSr5VaAm9okXLuLo1wjRQ3566Wn+KsTevcP7gy8RJI2a6DMmuRvszbO+/0mKStWS95LCCw0faKPoavN0SqmD0jyIz1mB76R0OYWffw7KlonlFNYCxdpuDWCupmGGEa0cqQoJPCi+MsU6VjbYP5jOvw8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(261028144727099003)(56012099006)(4143699003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXlLbHdIOVVXM2Z3T1EwKzJyVTRWb3k3STVGMCtnU3BJVTlyenZyTWVuSmpi?=
 =?utf-8?B?VlB3dnFQbjdXYkllSHVrTStPbXRGRDIwQW8yZnlnQWlOYk5QTkZuaHhKZytT?=
 =?utf-8?B?TEFNQmhOdVM1c1R0YWlScW9rc3NSZENIanMvTkZ4MGRMM0xOVklpT09hc291?=
 =?utf-8?B?Sm9yYUVERWlWSUdQc2Ywa2N1RE0zZjJ1RWs2WUdKeXpzVGJZN2x2QU4zRnhm?=
 =?utf-8?B?OFdSM0cyYWNSbi9hSFcwTkl4MlBZNjBqS0pVaDhuMllmRXo3elEvSkZicTJC?=
 =?utf-8?B?NzFYVFh4ekw5R01Ud1o0Sk5JUDVRQThnMzN1WmoxM2lLdUFuYTVXUGtRRjN1?=
 =?utf-8?B?bTVNcEZWL2JmWGtPQUo1bmM2eG1lcUs4UCt0eHBuVzdPTTRHZ3hsM2NaTmJR?=
 =?utf-8?B?cWNraEliYjNMZGtDclZHUW8xclpxaWtzcW03WTZodEFVODJEdlpzQkNCNG9h?=
 =?utf-8?B?c3lQOEd4WmNaQVVnaVpzdE8xd2t6b3RzL0V3VUJNbXFHSXFEaThubVF4bDNa?=
 =?utf-8?B?amNwa2FkYUxKN1pKTVFSdmNPaWxXOEpKQmtlTFRxYWtVajl2NnRZeEVwdHN0?=
 =?utf-8?B?Tndaa0wxZjN5SWdKa09wT0Nva3B3a0dqMGUwWEN5QVVxUFl2Y25sTUYwRTg5?=
 =?utf-8?B?dHRnVU1UUjRxMG1DVk5CTXhhTGtFV2p6QlVEVDV6a1p6Q1FER2JnYVhNcnVa?=
 =?utf-8?B?N1YySlU0S2I2VVZjb2d1c2xsZkdJOTVMNFNVN1BpYk9DZ2orWU0yeDZkcUVJ?=
 =?utf-8?B?bmY5Y0pvUHRFbllmczlCdmV1REVLb1dHY1pPRW85MFdyNEZ6emJrOWJjQW00?=
 =?utf-8?B?enkrcjhQbjlOM2o3K25PNktua2ltUW5nSUMvREZublpqd01XeWpKQk41ZHMx?=
 =?utf-8?B?aWhPNjEzNzNBYzAxRlVLL2graDQwcWdUUnhCTDlFaG1aSWZxRUlnSDZ3M1dM?=
 =?utf-8?B?MmpZYlhJL0xHMmFCUGlLcEZiQ0locUduay80M1pHRkVNOFI3WXV5b20ySm5I?=
 =?utf-8?B?dFFRU0VBd3k4dHRqSjMyeEYyeHdGWkZSNGZORVR0UTNRaDFvdEVBTG5jYjJi?=
 =?utf-8?B?RFg1UmtLTEp3N0lHY2prMWVCN3lzU0Y3NVBGYitEektBLy9XRzl5a1ppK0ow?=
 =?utf-8?B?R0R6R3RrRndzRWdwSmtwUnozZmVDbmpKRGEzU3JuRlExR2JTRjZKMzR0YUZ2?=
 =?utf-8?B?NUpJb3hZV2RGU3FUTlFZbGlwY2dGcjRTL3F1UDRFZERrR1pHOHVWd2J6QjJI?=
 =?utf-8?B?RjZ3ZmNqRVRGSGl4d1Q0QXpKcy9ZVjA2SUF5RS9JdGhRNDlaUGVqMUxwYkpY?=
 =?utf-8?B?OE5BL1NTZGo3dnh0MTlhbXNQcWNrUm1kM0FQSWsxMXpFWGhTYmtLbW1Jclho?=
 =?utf-8?B?cm5OWXFsdVZSNjU1ZldCTW51T1ZPVVkvRzFabW9OU1g1VWhSMkdaOHVOWCto?=
 =?utf-8?B?a21CVWZRTkVhRTBqUi9EemRzV3hFb0hSOFlqMitnL0RZeEJ3QldPNkJUazBC?=
 =?utf-8?B?ME5yTUpnS0NTbi9OWm1ZakhHT2NBc0dyV25HNDlsSFJYSmJPNFErNWhaUW9i?=
 =?utf-8?B?azd6MitMRFJITlpmOFdWQkZVUkJBRE1FRjBaRmxpeVJMR0dPQklxSEgxL3pQ?=
 =?utf-8?B?S2c4emE1NklibXdRQWVtL0tEcXpvalhVeGc0bEs5T0ZMeTF0YVIyNVZXVFB1?=
 =?utf-8?B?NzUwVCtBK2V6L0hEZS96VDU5dU1wQXJRZ3d3VldFN1BmRE9VY2NQTi9VQlFW?=
 =?utf-8?B?L21KMjh6ZExjRStnTHNyWWpiQUJsNXhhN2cxM3JMRTk2b3V0VmxOOGN4WW1K?=
 =?utf-8?B?RC9TNDFZSER0Z0ZsZVliZVdYZGxzbkVwRWZtc08vamFqZkZnRGkrVGxOM3dH?=
 =?utf-8?B?YnlZQmRUUG5rSGlUa1ZLdTRRM1NJbmN6bWVPY1Z2TU9WQ2t3bFZhaUdxR0Na?=
 =?utf-8?B?aWVBaUpsYlljZW9CZHlvNS9oWitOM0MrSXRCN2ltUDl2eWwzbVNGV0hpUTZv?=
 =?utf-8?B?YnRCazJDNG8yWkxaRWVteUxEd3BndStqM2tXOHJraGZmWW5oQzNDellueVNu?=
 =?utf-8?B?M3RTVGxHanJjK3hmODhmZnJnTXlTU0hlNldXYWw4MXY4TVpMbEV3bXJMZVhD?=
 =?utf-8?B?dWhMeEk1SWo1L0JFeW1lb0N0RFNadElSeFJYNkpndnl5di9IV1A5eWNnMkNo?=
 =?utf-8?B?RlN6MXowTFo5czRNRW5GeDAvb0EzZ1VGOWhtOXNwT3E2bGxuVmZlaGphbFJq?=
 =?utf-8?B?WkxZdmZmTHlBRWM2aXRZVUVQeVFyYkZSazZwZlJLRCtHdCtNQ1M1Y3YwS1NU?=
 =?utf-8?B?OEhjODFvTENudlpDcUlndjR4TUZudTZmeGcycDhUNitOSjRsdlViUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y+5ZMhIGzj3tQG9JYtxVNhaQv/ogCsEkHyDdepkXkZGcy9Xn8aY+J9KDafrF9IDNC+Qh+vdwUf/BWt1dtkV/06+1npeNx+H/HXg0RcSB6A1zptLx90VSnZTs39Zh/gbfke3KIeL/OnDRNz31za8sXor9zuerJ/69VGGO3uINGHGlUtow2nuoJiX0K3WG+jzapvd8bF+MI+NWceVeRB0Oe0c+8h1NONztPZxGOwTV+y/bNcaFmFnrf1SOv0TU26KVUkWYzShQNbZkjmeaQGe9HQKqsEv+P1cThwpCYATv2cbvmQYUHjnsoUDEJNKBjb5rgqk6WvCw4zfBKiaoFEhC6Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04e9a4b-83a5-41c6-3378-08df35907515
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 07:44:26.5503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5g45ZZx38pZRZvVtKlPykhH2LjXCG44yU587gFiveUy2lJhsRSdso46Q7c7qPqn5O5SFRElMgV7u9zzMbZ0uQM9bAIRjeuKXq5DPT1BIE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8968
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgVGltdXIsIA0KDQpJJ20gbm90IHNheWluZyB0aGV5IGRvbid0IHdvcmsuDQoNCk15IG1haW4g
Y29uY2VybiBpcyB0aGF0IHdlIGN1cnJlbnRseSBkb24ndCBoYXZlIGZpcm13YXJlIHRvIHRlc3Qg
dGhpcyBtb2RlIG9uIHJlYWwgaGFyZHdhcmUuDQpBbHRob3VnaCB3ZSBjYW4gdGVzdCBpdCBpbiBR
RU1VIHVzaW5nIFFUZXN0LCB0aGlzIGRvZXMgbm90IGd1YXJhbnRlZSB0aGF0IFFFTVUgYmVoYXZl
cyB0aGUgc2FtZSB3YXkgYXMgcmVhbCBoYXJkd2FyZS4NCldpdGhvdXQgdGVzdGluZyBvbiByZWFs
IGhhcmR3YXJlLCB3ZSBjYW5ub3QgY29uZmlybSB0aGF0IHRoZSBiZWhhdmlvciBpbXBsZW1lbnRl
ZCBieSB0aGlzIHBhdGNoIG1hdGNoZXMgdGhlIGFjdHVhbCBoYXJkd2FyZSBiZWhhdmlvci4NCg0K
VGhhdCBzYWlkLCBJIHRoaW5rIHRoZSBRVGVzdCBpbiB0aGlzIHNlcmllcyBpcyB2ZXJ5IHVzZWZ1
bCwgYXMgdGhlIGZ1bmN0aW9uYWwgdGVzdHMgZG9uJ3QgY292ZXIgYWxsIHRoZSBJMkMgbW9kZXMu
DQoNClRoYW5rcywNCkphbWluDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzZdIGh3L2ky
Yy9hc3BlZWQ6IGZpeCBidWZmZXIgdHJhbnNmZXIgaW4gbm9uLXBhY2tldA0KPiBtb2RlDQo+IA0K
PiBIaSBKYW1pbiwgeW91IGFyZSByaWdodDsgIG5vIGRyaXZlciB1c2VzIHRob3NlIG1vZGVzLCBh
bmQgSSBjYW4ndCB2ZXJpZnkgdGhlaXINCj4gd29yayBhdCB0aGUgbW9tZW50Lg0KPiBEbyB5b3Ug
c3VwcG9zZSwgdGhhdCB0aGV5IGRvbid0IHdvcms/IEFyZSB0aGVyZSBpc3N1ZXMgd2l0aCB0aGVt
Pw0KPiBXZSBjYW4gZXhjbHVkZSB0aGVtIGZyb20gdGVzdHMsIGJ1dCAgYnVmZmVyIG1vZGUgaXMg
aW1wb3J0YW50IGZvciBvbGQgY2hpcHMNCj4gbGlrZSBBU1QyNTAwLg0KPiANCj4gT24gVGh1LCAy
MDI2LTEwLTI5IGF0IDA2OjMzICswMDAwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgVGltdXIs
DQo+ID4NCj4gPiBBcyBmYXIgYXMgSSBjYW4gc2VlLCBubyBBU1BFRUQgTGludXggZHJpdmVyIHVz
ZXMgbm9uLXBhY2tldCBidWZmZXIgb3INCj4gPiBETUEgbW9kZSBmb3IgbWFzdGVyIHRyYW5zZmVy
czoNCj4gPiAtIGkyYy1hc3BlZWQuYyAob2xkIHJlZ2lzdGVyIG1vZGUpIG9ubHkgdXNlcyBieXRl
IG1vZGU7IHRoZSBhZGRyZXNzDQo+ID4gwqAgaXMgYWx3YXlzIHdyaXR0ZW4gdG8gdGhlIGJ5dGUg
YnVmZmVyIHJlZ2lzdGVyIGJlZm9yZSBTVEFSVC4NCj4gPiAtIGkyYy1hc3QyNjAwLmMgaW4gdGhl
IEFTUEVFRCBTREsga2VybmVsIChuZXcgcmVnaXN0ZXIgbW9kZSkgc2V0cw0KPiA+IMKgIFBLVF9F
TiBmb3IgZXZlcnkgbWFzdGVyIHRyYW5zZmVyLCBhbmQgdGhlIGFkZHJlc3MgY29tZXMgZnJvbQ0K
PiA+IMKgIFBLVF9BRERSLg0KPiA+DQo+ID4gSGF2ZSB5b3UgdmVyaWZpZWQgdGhpcyBiZWhhdmlv
ciBvbiByZWFsIGhhcmR3YXJlPyBXaGljaCBmaXJtd2FyZSBhcmUNCj4gPiB5b3UgcnVubmluZyB0
aGF0IHVzZXMgbm9uLXBhY2tldCBidWZmZXIvRE1BIG1vZGU/DQo+ID4NCj4gPiBUaGFua3MsDQo+
ID4gSmFtaW4NCj4gPg0KPiA+ID4gU3ViamVjdDogW1BBVENIIHYyIDQvNl0gaHcvaTJjL2FzcGVl
ZDogZml4IGJ1ZmZlciB0cmFuc2ZlciBpbiBub24tDQo+ID4gPiBwYWNrZXQgbW9kZQ0KPiA+ID4N
Cj4gPiA+IEluIG5vbi1wYWNrZXQgbW9kZSwgdGhlIGZpcnN0IGJ5dGUgb2YgdGhlIHR4IGJ1ZmZl
ciBwb29sIGNvbnRhaW5zIGENCj4gPiA+IGRldmljZSBhZGRyZXNzLCBzbyBhdm9pZCBzZW5kaW5n
IGl0IGFzIGEgZGF0YSBieXRlLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA5NjFmYWYzZGRiZDggKCJo
dy9pMmMvYXNwZWVkOiBGaXggVFhCVUYgdHJhbnNtaXNzaW9uIHN0YXJ0DQo+ID4gPiBwb3NpdGlv
bg0KPiA+ID4gZXJyb3IiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGltdXIgTWFrc2ltb3YgPGdl
c3NpbmdhdGVAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGh3L2kyYy9hc3BlZWRfaTJj
LmMgfCAxMSArKysrKysrLS0tLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9ody9pMmMvYXNw
ZWVkX2kyYy5jIGIvaHcvaTJjL2FzcGVlZF9pMmMuYyBpbmRleA0KPiA+ID4gZmY2ZWY2ZDIzYS4u
NTEwNzU4ZmI3YSAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPiA+
ICsrKyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPiA+IEBAIC0zODIsNyArMzgyLDcgQEAgc3Rh
dGljIHZvaWQNCj4gPiA+IGFzcGVlZF9pMmNfYnVzX3JlY3ZfZG1hX3Bvb2woQXNwZWVkSTJDQnVz
ICpidXMpDQo+ID4gPiDCoMKgwqDCoCBTSEFSRURfQVJSQVlfRklFTERfRFAzMihidXMtPnJlZ3Ms
IHJlZ19jbWQsIFJYX0RNQV9FTiwNCj4gMCk7wqAgfQ0KPiA+ID4NCj4gPiA+IC1zdGF0aWMgaW50
IGFzcGVlZF9pMmNfYnVzX3NlbmQoQXNwZWVkSTJDQnVzICpidXMpDQo+ID4gPiArc3RhdGljIGlu
dCBhc3BlZWRfaTJjX2J1c19zZW5kKEFzcGVlZEkyQ0J1cyAqYnVzLCBib29sIHNlbmRfYWRkcikN
Cj4gPiA+IMKgew0KPiA+ID4gwqDCoMKgwqAgQXNwZWVkSTJDQ2xhc3MgKmFpYyA9IEFTUEVFRF9J
MkNfR0VUX0NMQVNTKGJ1cy0+Y29udHJvbGxlcik7DQo+ID4gPiDCoMKgwqDCoCBpbnQgcmV0ID0g
LTE7DQo+ID4gPiBAQCAtMzkxLDExICszOTEsMTIgQEAgc3RhdGljIGludCBhc3BlZWRfaTJjX2J1
c19zZW5kKEFzcGVlZEkyQ0J1cw0KPiA+ID4gKmJ1cykNCj4gPiA+IMKgwqDCoMKgIHVpbnQzMl90
IHJlZ19wb29sX2N0cmwgPSBhc3BlZWRfaTJjX2J1c19wb29sX2N0cmxfb2Zmc2V0KGJ1cyk7DQo+
ID4gPiDCoMKgwqDCoCB1aW50MzJfdCByZWdfYnl0ZV9idWYgPSBhc3BlZWRfaTJjX2J1c19ieXRl
X2J1Zl9vZmZzZXQoYnVzKTsNCj4gPiA+IMKgwqDCoMKgIHVpbnQzMl90IHJlZ19kbWFfbGVuID0g
YXNwZWVkX2kyY19idXNfZG1hX2xlbl9vZmZzZXQoYnVzKTsNCj4gPiA+ICvCoMKgwqAgdWludDhf
dCBwb29sX29mZnNldCA9IHNlbmRfYWRkciA/IDEgOiAwOw0KPiA+ID4gwqDCoMKgwqAgaW50IHBv
b2xfdHhfY291bnQgPSBTSEFSRURfQVJSQVlfRklFTERfRVgzMihidXMtPnJlZ3MsDQo+ID4gPiBy
ZWdfcG9vbF9jdHJsLA0KPiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFQNCj4gWF9DT1VOVCkgKyAxOw0KPiA+ID4NCj4gPiA+IMKgwqDCoMKgIGlmIChTSEFS
RURfQVJSQVlfRklFTERfRVgzMihidXMtPnJlZ3MsIHJlZ19jbWQsIFRYX0JVRkZfRU4pKQ0KPiB7
DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHBvb2xfdHhfY291bnQ7IGkr
Kykgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGZvciAoaSA9IHBvb2xfb2Zmc2V0OyBpIDwgcG9v
bF90eF9jb3VudDsgaSsrKSB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDhf
dCAqcG9vbF9iYXNlID0gYWljLT5idXNfcG9vbF9iYXNlKGJ1cyk7DQo+ID4gPg0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlX2FzcGVlZF9pMmNfYnVzX3NlbmQoIkJVRiIsIGkg
KyAxLA0KPiBwb29sX3R4X2NvdW50LA0KPiA+ID4gQEANCj4gPiA+IC02MzMsNiArNjM0LDcgQEAg
c3RhdGljIHZvaWQgYXNwZWVkX2kyY19idXNfaGFuZGxlX2NtZChBc3BlZWRJMkNCdXMNCj4gPiA+
ICpidXMsIHVpbnQ2NF90IHZhbHVlKQ0KPiA+ID4gwqDCoMKgwqAgdWludDMyX3QgcmVnX2ludHJf
c3RzID0gYXNwZWVkX2kyY19idXNfaW50cl9zdHNfb2Zmc2V0KGJ1cyk7DQo+ID4gPiDCoMKgwqDC
oCB1aW50MzJfdCByZWdfY21kID0gYXNwZWVkX2kyY19idXNfY21kX29mZnNldChidXMpOw0KPiA+
ID4gwqDCoMKgwqAgdWludDMyX3QgcmVnX2RtYV9sZW4gPSBhc3BlZWRfaTJjX2J1c19kbWFfbGVu
X29mZnNldChidXMpOw0KPiA+ID4gK8KgwqDCoCBib29sIHN0YXJ0X2NtZCA9IFNIQVJFRF9BUlJB
WV9GSUVMRF9FWDMyKGJ1cy0+cmVncywgcmVnX2NtZCwNCj4gPiA+ICtNX1NUQVJUX0NNRCk7DQo+
ID4gPg0KPiA+ID4gwqDCoMKgwqAgaWYgKCFhc3BlZWRfaTJjX2NoZWNrX3NyYW0oYnVzKSkgew0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiBAQCAtNjQyLDcgKzY0NCw3IEBA
IHN0YXRpYyB2b2lkDQo+ID4gPiBhc3BlZWRfaTJjX2J1c19oYW5kbGVfY21kKEFzcGVlZEkyQ0J1
cyAqYnVzLCB1aW50NjRfdCB2YWx1ZSkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgYXNwZWVkX2ky
Y19idXNfY21kX2R1bXAoYnVzKTsNCj4gPiA+IMKgwqDCoMKgIH0NCj4gPiA+DQo+ID4gPiAtwqDC
oMKgIGlmIChTSEFSRURfQVJSQVlfRklFTERfRVgzMihidXMtPnJlZ3MsIHJlZ19jbWQsDQo+IE1f
U1RBUlRfQ01EKSkgew0KPiA+ID4gK8KgwqDCoCBpZiAoc3RhcnRfY21kKSB7DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgIHVpbnQ4X3Qgc3RhdGUgPSBhc3BlZWRfaTJjX2dldF9zdGF0ZShidXMpICYN
Cj4gSTJDRF9NQUNUSVZFID8NCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJMkNEX01T
VEFSVFIgOiBJMkNEX01TVEFSVDsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgdWludDhfdCBhZGRy
Ow0KPiA+ID4gQEAgLTY4Niw3ICs2ODgsOCBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gYXNwZWVkX2ky
Y19idXNfaGFuZGxlX2NtZChBc3BlZWRJMkNCdXMgKmJ1cywgdWludDY0X3QgdmFsdWUpDQo+ID4g
Pg0KPiA+ID4gwqDCoMKgwqAgaWYgKFNIQVJFRF9BUlJBWV9GSUVMRF9FWDMyKGJ1cy0+cmVncywg
cmVnX2NtZCwgTV9UWF9DTUQpKQ0KPiB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGFzcGVlZF9p
MmNfc2V0X3N0YXRlKGJ1cywgSTJDRF9NVFhEKTsNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoCBpZiAo
YXNwZWVkX2kyY19idXNfc2VuZChidXMpKSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgaWYgKGFz
cGVlZF9pMmNfYnVzX3NlbmQoYnVzLCBzdGFydF9jbWQgJiYNCj4gPiA+DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIWFzcGVlZF9pMmNfYnVzX3BrdA0KPiBfbW9kZV9lbg0KPiA+ID4gKGJ1cykpKQ0KPiA+
ID4gKyB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU0hBUkVEX0FSUkFZX0ZJRUxE
X0RQMzIoYnVzLT5yZWdzLCByZWdfaW50cl9zdHMsDQo+ID4gPiBUWF9OQUssIDEpOw0KPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGkyY19lbmRfdHJhbnNmZXIoYnVzLT5idXMpOw0KPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiAyLjUz
LjANCg==

