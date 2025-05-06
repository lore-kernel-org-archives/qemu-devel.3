Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42ADC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 05:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCAYD-0005nP-TM; Tue, 06 May 2025 01:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uCAY1-0005lh-Rx; Tue, 06 May 2025 01:08:54 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uCAXw-0004mL-LM; Tue, 06 May 2025 01:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkPuuBsuE3f1628Z0GIL/dDAmkStujNEkyKiQmPArbskRouxc1JVBmAh6Ij+UiOArcU5Vo5pKzY60tSt8LZdcn/7JowLUgWPvyMdwcentiXkHi2N7jZmCeuyEm5uN6BOoGtHzxunuZMiSSyV79BfmFLEOV83H2WAQtABZXEFBzlfX3m1sdkyNTOEiDCYJ3zM8/JDsDSgMekCnQwkSsuBlKefVSvhKNpDIIVJHdz3MaUMVEf8oJqXb+8xhLmQSRNa+ntdPUVDVSBwjyUX22q8W5HoegbLPlycu0v8nVNti0OPsc3xGMfHc4UuSWxXVYlm59IsT4cjJ1+B9/IvG9+k2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVp8YnE8Ke8R2N9fmml2dEdvx/g+PJb8NCocHylfWpo=;
 b=LwcPyhmYIiIAbrvmxM+vPTd7+Hoj2upJQKnNlLOympQkJ8DLTh0FJaXquf7JhhOm4MQqw9/MWyyMYBcX1guGGOdCe5Boq9jEBz3sA+6KJ+dxy629uYJy7UlKg4vbSmAn8GG0auL/XbtBHUUVXj16PEpVjjPiMgCAoEN4OuGzofPN6hgKSaUqis+Qm4ITuKKwbX42lxUzkRyteuUDD7Iu7dK9oNpQfRjJM6FF9tM7nU1ck7rssM86GEhRoBfr/Az4by41rPWDeJelu2+0a8X6T+6XLgXyP6JUVli/L02sRg3DAXhXVIJLLnzXok/fDFGybctynvoRD0pXMGJC7eJskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVp8YnE8Ke8R2N9fmml2dEdvx/g+PJb8NCocHylfWpo=;
 b=SPwLTFWXqVBR1Vm7mVajkALTL0NjiI4sO+vW3uNhYulLV6HkmUG9xvphCjpW4RyloCj2HZOpsgiOqUpvOC0cRDkTSDFOvWXY5dCjWvt8DSdlfcdgbx/oUhhcucM1UFWPT7CBTK7UUFC8+evv9eWT2PZ3uPAXBZhMIgl9qi2G5pKqKU9PVe6FLuLT6BG7XTdtu658AWiHnm0BunhLelT17HPlP6mwSyX3n4j2o4+xp+RkJBAqswMT3xWxxI7bTRIGNGanE2/JR9O4J0IhpJlZ3M2nZB5xXBYXk8IQNotVb6KfroHK64EwwB12HDu5C+GJICLBQkMoOYMZYEWn1a4VYg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5279.apcprd06.prod.outlook.com (2603:1096:101:82::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 05:08:32 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8699.021; Tue, 6 May 2025
 05:08:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 09/22] hw/misc/aspeed_hace: Ensure HASH_IRQ is always
 set to prevent firmware hang
Thread-Topic: [PATCH v1 09/22] hw/misc/aspeed_hace: Ensure HASH_IRQ is always
 set to prevent firmware hang
Thread-Index: AQHbmkNXZL4vdK2DY02k2ne5JqunpLOQMK8AgDUkdBA=
Date: Tue, 6 May 2025 05:08:31 +0000
Message-ID: <SI2PR06MB50412594D041FA2581AEFF42FC892@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-10-jamin_lin@aspeedtech.com>
 <e2a8770c-d206-441e-9542-9616531e263c@kaod.org>
In-Reply-To: <e2a8770c-d206-441e-9542-9616531e263c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5279:EE_
x-ms-office365-filtering-correlation-id: be96ddc9-76f0-41bb-c1d4-08dd8c5c0bb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Q0tpWXd1S00rcG56ODVJTE1mNEl0Wjl3WTdJSXJmY08yandwaG5JRnRXZWhy?=
 =?utf-8?B?WVNoaEw4WGdpSURKak0va2U3MUlETFZTMXpYNEc2VmpaU2lsd2JRZkdndVJw?=
 =?utf-8?B?UXNEbEVUcVU0aVpPNXYzbkZQc2FxQXBjQk1hSUxxeUIwR0lmRmVKeFo3YlRT?=
 =?utf-8?B?RzFVNk9lQkFyejMwMWhWSzdvcWlVNGpwemdhYy9VNm9XSi9kcUcyRWdyMVNH?=
 =?utf-8?B?UEtibzkvS3RWd0JBZTg2U1JXeDBodkc0Z2tXTnFZTE13VnRWVXZLV3ZCME5o?=
 =?utf-8?B?UmgzM25Kc2greTRKam9PT3RYUjNodjB6TzY2RjhtZ0Judkt2NVVoWm5HQ2ti?=
 =?utf-8?B?eHBWNy81ZFpqN3pvdE05Vk1tY3ZiRVBPMHhjaDJKcEc5OWNlZzFsZGFWME9G?=
 =?utf-8?B?c1VVekNrMkRhcDBKOXhTUjVrcHJtVjhpVThjeGZtYWJwK282ckhqWEU3Rm1V?=
 =?utf-8?B?c0JWQ0VoRkxQZXlwYXZwTVExZjQxbkZLUjkzL1N2TzEydGx0WXpYVDM0bnd5?=
 =?utf-8?B?Q0s3a3FBVUd2cFhFT3gzcTFUaWhMQjB2L2FJZksyaTc3T0pqREtzZHR0R2RD?=
 =?utf-8?B?MUZYRFMyU210TWlpMzMwREZ5Vlg4N3RyWlIzdmxYTmtGdDh2OEYxRkhSZmo1?=
 =?utf-8?B?MW1hOGgrODBXc0xhWDZFbGdIV25YdTFONEdKa3ArZUxRMElpWEN3WkRncFRu?=
 =?utf-8?B?Q3QzbXN3b3lYbEtPZUJ1YWhRYlZGQmgxVDZzVm92aFE4dWF5N0dGcGJBcEVL?=
 =?utf-8?B?eVlVSWhrUUw0TTQ3eWltcE9GM2wwSGczYWhaQWY4dXpsbmdwZmNoMGI4M3Rp?=
 =?utf-8?B?WFI4cU5SdFd4QzR3K2dHUzhFQlRzTjBNRi9xVG9BSGc2SnYxWW8wMWVjQVBD?=
 =?utf-8?B?d052Z1RMMXp0d3MyNjk5U3dpaFpWZFk3NzVoNk1RY3ZqbTVXb0wwOW1obFRL?=
 =?utf-8?B?d1lTdWUzY2VpMXBDeVRGWjI0dnpHbW9oRGRzZFJhYk95bDhXbUZxckM1cHAy?=
 =?utf-8?B?VTkxVDlJU0RxamhZV2RWdFBEWHF0aTVCUjlpcE03bTRwTzl1VzhDaHRSL2Yx?=
 =?utf-8?B?WHl2SHJuekxTeHRFNEhwYXZ4eE1xTEJhZGYvQWlvdk9mRHBjOStxZlVpMERi?=
 =?utf-8?B?RFBvWjY1eGtGUVRHNmNOajB5eThBR0E2dTk1YzZrczlVSkxCSnhQM0ltejJ5?=
 =?utf-8?B?MWdKOHdobUcxc1ZnaGxxZzNjTGp1a0FSeldWNExkQUNXTFhxZUJCQlZid0xI?=
 =?utf-8?B?ZVdNT2NYdHNJT0Zyakc3TWtzVUJzK0ozQ2J3RGpsWnF2VTE2YStvL2dWTmc2?=
 =?utf-8?B?aWRxZlM1OHFPTXBGYWZqcld6eC9oTTZNVzlZWVpVTFNFQnE2OEZWcHYxOE5h?=
 =?utf-8?B?MWkrbnJDZVMxbHhjQlB0TzVXVTZqWW5MUndoTEprSGZWMzJodkpXTnBkUGNK?=
 =?utf-8?B?c3JIMWdNdlQ1aklHTjVNR2U1REVaVHhVSzR3VjRFaGJkVlFPUDUrYWtSM3F0?=
 =?utf-8?B?V1JieklSU2VNc2tKeWZPSmFuTWJtUnhEeGU0bkt1RVlkQlJqNUlzd1QwamVV?=
 =?utf-8?B?U2w0Yi9UU29FUUpQOE9NMkFvRSttdGZLQzhhNUJLOHVCTHhBem81c1c2cTVY?=
 =?utf-8?B?eTI5L2tqRUVSSXFSb00vaWM2dkVPZ2tWY1QvUVRYeFVvTEpjUmtmRDVEcWta?=
 =?utf-8?B?VE1TWndpK2RxVjBwQTdWWjRVeGZCYTFFd0tDT3NIRjE2Mzc5K2RMcEhKV2Vl?=
 =?utf-8?B?bDROQmNCNGo0TUQrNkpLdExpVGNYR1dOTTJJMVlWWllXL0svQnNtU3c1d1M2?=
 =?utf-8?B?YXdJd1NrNUZ2Vkg0TTdGby9CUGo1eFRpSEZzZDA4c1VMa01yYzVMS3VwcTA5?=
 =?utf-8?B?OGRiclVTcS9jUngvVGtpY20vQ2hwdDBKd21IdnlLZ3duOXMrRi9yVFVUbzNV?=
 =?utf-8?B?L083b0hTZER5Y21RTDZqb0tyYTNrU3NPSUVXMlBQMFdUSmlPR3daYVNQcDRO?=
 =?utf-8?Q?5kBrQNs5oY1vbsgARdoxn53645nrIY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUwwUWRiYTl2bDFReW92SVF0djBzZThTZXIwOStaWmorVE1qUjkxdVFtZzU5?=
 =?utf-8?B?VEtaZXdJR3BGN0JwVTNEZVJHay9sREtpalowV2FvNVNRbTgrT3dzSUdDYnc0?=
 =?utf-8?B?VWpPZmxSZmFORzBGZ2FmaFVUWXZQbkZtSHcyRFRvVWNlWTExa2tlUkRjKy8x?=
 =?utf-8?B?ZHdCRlZyMG1jTGl5K1FUdkdEZHY1WlAwZ3FWVWxlMlF4MDRaRTVQclJKU29V?=
 =?utf-8?B?YjdlZ0UrQTIzQVpKOU9TVHhYYmtoVDkySndQSU5SWHBaWFg4NWJ1bmU0OFdh?=
 =?utf-8?B?UEZtMDRxYi85RHlZdk9xekYxTGhreDJqT1dNZ1hUL0VxWndGaSttSmtWVVZq?=
 =?utf-8?B?OVkzc1NyTzhyalBTWHM2YlJFYWM4TE9ZZWt5UStHTkFjQ3d0ajJsL05pUTRz?=
 =?utf-8?B?V2NRMWQzZDlrMU5qZnJwaGVPbFp2QWpPcHVJb3N2SE56cy93VUh2TkdZRlpZ?=
 =?utf-8?B?V1JJTHhBRGtuYXJVdm1IU0pnZS82QmxBcjU4cE4rSmJIZ01tRmx3b1BEQlNm?=
 =?utf-8?B?dTkrMUpOMVpkZVFhbGtyVm5qZXZHUXNPMVZJYmtrZXMwcVFyTnNJUmFOaEFV?=
 =?utf-8?B?cCtnNjJqY2xkWHZ5ZnQwai9FMVNyVEsyN1VpY2JCMzJrSWd6RzkvNE94UDFU?=
 =?utf-8?B?YTZhYklYa2wyOTJXNGo2eVdRRmJ4K1FYRU5jRjRiYVZuaWVOeVJ3WUtsQk1S?=
 =?utf-8?B?ai9yTE1yYzMrbkQ0TmV1SE50R24ycjNEQndSN09TTTYyN0hmcjZXbWhoMmNG?=
 =?utf-8?B?MTlkSUQ1V0F2Z281U0xUeVFrcG1SL2UwMVZVL2U2alNILzhjekNsR3BEUWxO?=
 =?utf-8?B?YVFiNzh1N0FIZ21KL3N6MzdpdW9VVEczcCtOZC9XVkJVL042eDUxQlJRaWo2?=
 =?utf-8?B?VzBvYkJCcVJXckdqTytwS1ZwajUwWGJoYW8yVm4zY0NzQnhHeCtTSEx3VVpj?=
 =?utf-8?B?UlJkWWE2aDc5NSt0YWYxRnFvOEVNejhHOGpYN2xsdE1MZXh4MkNnenFvaE5T?=
 =?utf-8?B?NkQ2UkdvVFZ0K3JNY3ZvcUZVNTloaVNtZ1gva3ZNTnpROEtGa2ZQMU1QSjlr?=
 =?utf-8?B?cjk3OGs4WkVNQkxTbm1uN1E2RXNhdk5wSHZCWVowTTBTOUFTZko3YnIyMW9V?=
 =?utf-8?B?KzdDclE2cWtyTEVSZ0hHZTByVENYbGRpRTVoRm4wclZCbndxV1o2QlVJb0RP?=
 =?utf-8?B?cDNtd2lmYzNDdHp6RzhWTFF3OHlTV3R2QXRKYTI2YkNNZWR0N2FIcTJqYmRP?=
 =?utf-8?B?b2hpWDFlQStEcC91S1QwcjhVaG1qVDJGTmpzbFZnbFJ2VWxhSVVoOS9GU0cv?=
 =?utf-8?B?alVidnBJWEV4bG1sc3YvQnhwdVN3VnZocFVNejVtcml1M2l2SjUvZmp6bTM1?=
 =?utf-8?B?NG1GZjFlK3IzbEk2RlpxYTNVUS9CR2x3SEU0UTgvalpRQ3d0N3Q3aTd3Q3pC?=
 =?utf-8?B?M3NWS08zV3RpZkNMOVA2cFRFcDhNcXpZT3RPRitiTkJkMzJtcldGMkpoRENx?=
 =?utf-8?B?bnFMcFY1WnB6RVZXbXJrUXByS3V2UTY4NXU4U1J3L2kxWnplVmVtcmJPT1dt?=
 =?utf-8?B?WEFhSnA1WmFGSkRPdzJtK1UxcmFvQ0hISURnbGljbnQ5YUlGYUM3c1pLL1hV?=
 =?utf-8?B?TWdqSjN5WUdrSy9BM2xpdEJSUkZtK0tLSmN6U0JwaGtMTnZPNGdoZGM0dXZN?=
 =?utf-8?B?RHlNbWZ5ZHpYb2xadkhZUHcwUzRwa1YyYnlaQWdlRjlFY25Xd0pPeVFpZW1G?=
 =?utf-8?B?cXIrU0N2b0YwYnVaK2J0NENWZUJFbStxU01kdHc2N2t4dEtsWHplKzhkc0pX?=
 =?utf-8?B?bW0zclVmeWNMVWNjblp0TXpTODlBa3lNbjM2ejdQVlhvdDdhd1pRczZnbnpD?=
 =?utf-8?B?VUN6MFpCTEFKdktFZ1kxMVBMMG5qcEVCOFkvaFIxQWtyMk15ejE2emp4dTk1?=
 =?utf-8?B?VkJscGdzMi9nZHpXUnBFZ2pMcUgxK2ZpU01GaXZyVjdTQ2tXSVZjNFM4bk05?=
 =?utf-8?B?ZzAxZ3dYRTZwenNaQ1VEc1JwcUhhY2NyVG1oS1BPd2xzczI1ek11UHdRejFJ?=
 =?utf-8?B?TVZibUl0cXl5YzJVeVl5Y1JldzJjd3l2N2tMaGEyZStRMEYrTUZuOUtKMFNa?=
 =?utf-8?Q?b+jn1sS5Vi+r4AJhmEsAbZjgl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be96ddc9-76f0-41bb-c1d4-08dd8c5c0bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 05:08:31.7994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Anq1aIBPDes+LLmH2A3np5uluYAucyCD5mI8MUWMMMmZcbU/5+1yTmrJPpyeklhyMsNkNW124P5DCwhXoGXyBOSSiA07xYeV5QZqUF4fSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5279
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDkvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IEVuc3VyZSBIQVNIX0lSUSBpcw0KPiBhbHdheXMgc2V0IHRvIHByZXZlbnQgZmly
bXdhcmUgaGFuZw0KPiANCj4gT24gMy8yMS8yNSAxMDoyNiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+
IEN1cnJlbnRseSwgaWYgdGhlIHByb2dyYW0gZW5jb3VudGVycyBhbiB1bnN1cHBvcnRlZCBhbGdv
cml0aG0sIGl0IGRvZXMNCj4gPiBub3Qgc2V0IHRoZSBIQVNIX0lSUSBiaXQgaW4gdGhlIHN0YXR1
cyByZWdpc3RlciBhbmQgc2VuZCBhbiBpbnRlcnJ1cHQNCj4gPiB0byBpbmRpY2F0ZSBjb21tYW5k
IGNvbXBsZXRpb24uIEFzIGEgcmVzdWx0LCB0aGUgRlcgZ2V0cyBzdHVjayB3YWl0aW5nDQo+ID4g
Zm9yIGEgY29tcGxldGlvbiBzaWduYWwgZnJvbSB0aGUgSEFDRSBtb2R1bGUuDQo+ID4NCj4gPiBB
ZGRpdGlvbmFsbHksIGluIGRvX2hhc2hfb3BlcmF0aW9uLCBpZiBhbiBlcnJvciBvY2N1cnMgd2l0
aGluIHRoZQ0KPiA+IGNvbmRpdGlvbmFsIHN0YXRlbWVudCwgdGhlIEhBU0hfSVJRIGJpdCBpcyBu
b3Qgc2V0IGluIHRoZSBzdGF0dXMNCj4gPiByZWdpc3Rlci4gVGhpcyBjYXVzZXMgdGhlIGZpcm13
YXJlIHRvIGNvbnRpbnVvdXNseSBzZW5kIEhBU0ggY29tbWFuZHMsDQo+ID4gYXMgaXQgaXMgdW5h
d2FyZSB0aGF0IHRoZSBIQUNFIG1vZGVsIGhhcyBjb21wbGV0ZWQgcHJvY2Vzc2luZyB0aGUNCj4g
Y29tbWFuZC4NCj4gPg0KPiA+IFRvIGZpeCB0aGlzLCB0aGUgSEFTSF9JUlEgYml0IGluIHRoZSBz
dGF0dXMgcmVnaXN0ZXIgbXVzdCBhbHdheXMgYmUNCj4gPiBzZXQgdG8gZW5zdXJlIHRoYXQgdGhl
IGZpcm13YXJlIHJlY2VpdmVzIGFuIGludGVycnVwdCBmcm9tIHRoZSBIQUNFDQo+ID4gbW9kdWxl
LCBwcmV2ZW50aW5nIGl0IGZyb20gZ2V0dGluZyBzdHVjayBvciByZXBlYXRlZGx5IHNlbmRpbmcg
SEFTSA0KPiBjb21tYW5kcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFt
aW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiANCj4gU2hvdWxkIHdlIGFkZCBhICdGaXhlcycgdHJh
aWxlciA/DQpUaGFua3MgZm9yIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgYWRkDQpKYW1p
bg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfaGFjZS5jIHwgMTggKysrKysr
KysrLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYyBi
L2h3L21pc2MvYXNwZWVkX2hhY2UuYyBpbmRleA0KPiA+IDhmMzMzZmM5N2UuLmQ0ZjY1MzY3MGUg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvbWlzYy9hc3BlZWRfaGFjZS5jDQo+ID4gKysrIGIvaHcvbWlz
Yy9hc3BlZWRfaGFjZS5jDQo+ID4gQEAgLTMxMSwxMiArMzExLDYgQEAgc3RhdGljIHZvaWQgZG9f
aGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLA0KPiBpbnQgYWxnbywgYm9vbCBzZ19t
b2RlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvdltpIC0gMV0uaW92X2xl
biwgZmFsc2UsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW92W2kgLSAxXS5p
b3ZfbGVuKTsNCj4gPiAgICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgLyoNCj4gPiAtICAgICAqIFNl
dCBzdGF0dXMgYml0cyB0byBpbmRpY2F0ZSBjb21wbGV0aW9uLiBUZXN0aW5nIHNob3dzIGhhcmR3
YXJlIHNldHMNCj4gPiAtICAgICAqIHRoZXNlIGlycmVzcGVjdGl2ZSBvZiBIQVNIX0lSUV9FTi4N
Cj4gPiAtICAgICAqLw0KPiA+IC0gICAgcy0+cmVnc1tSX1NUQVRVU10gfD0gSEFTSF9JUlE7DQo+
ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyB1aW50NjRfdCBhc3BlZWRfaGFjZV9yZWFkKHZvaWQg
Km9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVuc2lnbmVkDQo+ID4gaW50IHNpemUpIEBAIC00MDAsMTAg
KzM5NCwxNiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaGFjZV93cml0ZSh2b2lkDQo+ICpvcGFxdWUs
IGh3YWRkciBhZGRyLCB1aW50NjRfdCBkYXRhLA0KPiA+ICAgICAgICAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IiVzOiBJbnZhbGlkIGhhc2ggYWxnb3JpdGhtIHNlbGVjdGlvbg0KPiAweCUiUFJJeDY0IlxuIiwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBkYXRhICYgYWhjLT5oYXNo
X21hc2spOw0KPiA+IC0gICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgfSBlbHNl
IHsNCj4gPiArICAgICAgICAgICAgZG9faGFzaF9vcGVyYXRpb24ocywgYWxnbywgZGF0YSAmIEhB
U0hfU0dfRU4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgKChkYXRhICYgSEFTSF9ITUFDX01B
U0spID09DQo+IEhBU0hfRElHRVNUX0FDQ1VNKSk7DQo+ID4gICAgICAgICAgIH0NCj4gPiAtICAg
ICAgICBkb19oYXNoX29wZXJhdGlvbihzLCBhbGdvLCBkYXRhICYgSEFTSF9TR19FTiwNCj4gPiAt
ICAgICAgICAgICAgICAgICgoZGF0YSAmIEhBU0hfSE1BQ19NQVNLKSA9PQ0KPiBIQVNIX0RJR0VT
VF9BQ0NVTSkpOw0KPiA+ICsNCj4gPiArICAgICAgICAvKg0KPiA+ICsgICAgICAgICAqIFNldCBz
dGF0dXMgYml0cyB0byBpbmRpY2F0ZSBjb21wbGV0aW9uLiBUZXN0aW5nIHNob3dzIGhhcmR3YXJl
DQo+IHNldHMNCj4gPiArICAgICAgICAgKiB0aGVzZSBpcnJlc3BlY3RpdmUgb2YgSEFTSF9JUlFf
RU4uDQo+IA0KPiBpcyB0aGF0IHN0aWxsIHRydWUgb24gdGhlIEFTVDI3MDAgU29DID8NCj4gDQo+
ID4gKyAgICAgICAgICovDQo+ID4gKyAgICAgICAgcy0+cmVnc1tSX1NUQVRVU10gfD0gSEFTSF9J
UlE7DQo+ID4gICA+ICAgICAgICAgICBpZiAoZGF0YSAmIEhBU0hfSVJRX0VOKSB7DQo+ID4gICAg
ICAgICAgICAgICBxZW11X2lycV9yYWlzZShzLT5pcnEpOw0KPiANCj4gDQo+IA0KPiBSZXZpZXdl
ZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gQy4NCj4gDQoNCg==

