Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5308EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNWd-0007zG-UW; Thu, 18 Jul 2024 05:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNWY-0007uv-Eb; Thu, 18 Jul 2024 05:34:06 -0400
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNWU-0004On-IM; Thu, 18 Jul 2024 05:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWy2+Hk96zvO8xwZtzWq8KM4Sw8D0q0B3NqhpNRdQY0dghj+GzL3XYIB0cVjstV6ITpmc9mdB5YqitmfmM9j7b7GN0N5cwomxu0LLzgtbutcNbYp82n/PTpOfrgrVMpteGcwoa+L11mbW+lr7XtspKDVm6HvuEKz3WawncEe6qIP+dVA8EQWFyNicO51mfrPGn/PZHvb1sppzi+5eAm3FZlAM4GoNAS0U0G19FOUARnQPwEWqrJQm8X9U1c03bAUKVDxNWSHC1k3ExRKGBf01iAB3WmuUrMKusilmpFez8RiQdaY8new3S68tr5bNKkIysho//HI69LqAbqIt32muA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI9LQWTu/ZyAKMyyccVlDGvU8AI/OFH6HyrCbkDTkMY=;
 b=hl18ncCMfMjoI18nNWOeZlk3WcXU/M7zdzqpWbXKgpMxq8fY1QLY2uRjaKMAe8/IdtBHJzXv30kv/NEIMi4CL2todsiR2pf0uUNAYFn8XFQuKggSDbv5Q3IV28INnc1Z/oGrXJzvrCxi/uiUKODYsqn2a3iSqQM7wA2TlBHnntLaDwwSdUIoseFgb8Ypbfhr/+UdyNUgz/4VueMgDui0th1SU6/Mo3uzXWaCyuC96k2TVSA5PrU1FTaA91QU6al7PPpkTPINhUvLEeNWF+KeNuadRY06kyScgUTRWsN2jPRLvFn5pq3+KCKRJvTkAOJUiAcbqS37k8h5Zna1U2YA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI9LQWTu/ZyAKMyyccVlDGvU8AI/OFH6HyrCbkDTkMY=;
 b=ExLeL+Vu/XEPyzww1qYTF3XoqHsf95JiqfZ6ZWvEHQuGhGdz28CWD6zHQaOUBkwmF3gQc1J7J92UG/qzGtlwJ8YtCXA6QoeFfgOAP2NM1L1t+j6X/sqccwasTsX1p1V7qrAZQnddAZvaqXFg1u9RC9iXw7MuzDfGbyWGLpf9nHyjKvdXUmel1EHUsDSldSb6D+j+l/GVbBvXeY2FZz4fyTPlVlp6RXZP0YpzdWgko3SWNZzvDlxeMw5j/+NffLE9uNa8p9Jn8iK6p6vveMhdWK59qKOgC3jGMS7z/XRf0FvaLMUtUoIJ5OaQUSQO8tBYMNLHZxAZYBft7+qbHt6HbA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB6171.apcprd06.prod.outlook.com (2603:1096:301:11e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Thu, 18 Jul 2024 09:33:52 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 09:33:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 15/15] aspeed: add tmp105 in i2c bus 0 for AST2700
Thread-Topic: [PATCH v1 15/15] aspeed: add tmp105 in i2c bus 0 for AST2700
Thread-Index: AQHa2N7KmPIg08Gy2EyTNUTHBwyvb7H8LtgAgAAKSdA=
Date: Thu, 18 Jul 2024 09:33:52 +0000
Message-ID: <SI2PR06MB5041CC0BCF0DDAB4F2700A47FCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-16-jamin_lin@aspeedtech.com>
 <25c98896-64ff-4cfc-9364-454b5a2501a5@kaod.org>
In-Reply-To: <25c98896-64ff-4cfc-9364-454b5a2501a5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB6171:EE_
x-ms-office365-filtering-correlation-id: d5926996-ef94-4a9b-7a2d-08dca70cbc6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0FrSjdQaGJRRXFPSUJTOC95SWgyUkJsck9peGNubjZXQjFCRzhiczBsMkht?=
 =?utf-8?B?MXZ3cG96YzdUL1c4KzdTWW1tbnNEdFFvclZwMnNJSzlZeC9IMXlFcWd1UnJU?=
 =?utf-8?B?akdNbENHaldhS1RLdnRsWlk1OXByVHQwN0xFcUdpWmhMcHJQcnJsTE0zRmhp?=
 =?utf-8?B?Vk0wdW11RURUN1A1dXhnZFdsNklaKy9xYUt1emsxeFBudVVHUGtqWXJjWC9Y?=
 =?utf-8?B?M2xMQW13R2pOQSt0SXlPdlVWMWZyOFkxQ0xHSmczY0g5Wmlhb0hUbW9oSTd1?=
 =?utf-8?B?cnNlelJmSmU4WVlyTnRrMHdaQStCY2JMd1duN24ybmtiQTNsSUpvMG4waGU4?=
 =?utf-8?B?YVZCUEJESEV0ZTNuaVYvdXZPZWsvb0Y3VThQVW1SOFlMQ2xrUXI0TlYvalA4?=
 =?utf-8?B?YUgxVElMRHBxeFQ5a3JSalZJRlZnY2d1akpkenlISVFkWGVHQzZJMi9wcVRi?=
 =?utf-8?B?L0RJcWVubmJueHBnVnQvM1NSdkhHRDI1QmJRakxQWmtJNGlxM3oyUVpSNnBa?=
 =?utf-8?B?bnJqS3pzYzlWYXNmWVNjOXpBaXRwaDhJZk1GalA2RlFMR0o3aE52SFBnK3dY?=
 =?utf-8?B?NDVUeTJWNGw1aVFEUXBkQnpld3kzWkhBV0w5c2pPUmhoeDZFeVB2N050eG0w?=
 =?utf-8?B?TUNoN2dvTmVHYXBaUG1IcWRDT0J3elg5OHBIb1h2eEFEQnRqZlVvWnZYYTVr?=
 =?utf-8?B?Q3kwMDFkY1ExZmtFNFdaZGc3S3lFVGxZamhRZE1IcU1VdzJWL0p0aEh2Vmkw?=
 =?utf-8?B?RXJaZUxSMXYwT21TUmtmYk5TcG8vNW9Qcnp0dEcvbEhzcmh3OVVCSUIzaHNY?=
 =?utf-8?B?S2x4ZFI0cXVjSkdPUDVxVCtkVWc1cUJ0SWdqbXNzNzd3YTc3b0hzOGkrMXFr?=
 =?utf-8?B?RHF1SEhUemhabFMxMWhFUDkrOGJNaGc1U3RPSnRsNEcyQ2NXc2thTXZvS0g0?=
 =?utf-8?B?d2lQeFc2NVI3cGhoWHZKcVBYTVU0NU51TzNRSlo3KytxdjJ2WUlLSkd5ZVZ1?=
 =?utf-8?B?N09qUXRrd2hHRldGRzQwL3BtdERWWWg3emNRSVBMNHJiNklRRUlVdU50MDkv?=
 =?utf-8?B?UUxkcW5NeklJY2Y2OWkzWFBJTUhGYUpsK2VJM2lWWkJkSkg4Unk2akVuOHFX?=
 =?utf-8?B?bm92YjFjN2k4UWZpbm04YU5FOFVTMmQ2VFk4RUs2SWtvVlJZRGk1ek9tN1Ns?=
 =?utf-8?B?V0pSdUxZUEplcXg3d2F0TFFuU1o3T3JmOEE3RTMveFRHaThnQllNK3I1cExY?=
 =?utf-8?B?cmIyTVBrOHZ3c1pBUEErSDRpSE5LZ1p4c1BvOWVNaVVaRkRWWEZ3NVkvM0hY?=
 =?utf-8?B?SEJtN3p2UWNnM1ptMDJINnJHVERlMExlMFlxc0NlU1hTOVFVcDI3d0lhQlFR?=
 =?utf-8?B?dG92S1BJWnA2bEFydlJTOVhhQ2ExMGZVTHR3Z3hWcG12YzI1MnBjRHF0SS9u?=
 =?utf-8?B?QllyZ0FFbjgvb05yVVROOHJmd01kMXdWZXFmN0lVekc1SkRrOWphODBEd25u?=
 =?utf-8?B?djBFNWpGY1BhVFZXcGtrKy9RM3pLc2NoaGNWTjBUWkJpZ05vbW4yMFVmSFhp?=
 =?utf-8?B?aUtjVDE1Ymd2UW9xWWNtOGRqZmZlT1gzR3FKTGRpYStDMm15UmNKaGJTOGFL?=
 =?utf-8?B?WG0yMm96U3ErVmY5NmFubEdxcjcwWnE0ZzJwNHFad3Q0KzF3Vk9KZkVyd3dI?=
 =?utf-8?B?S1dlYjhQSGpYaFlERVlQZ244S2NCblp6WVZLdlBjNlBnYVJWZTNicEFLMDZy?=
 =?utf-8?B?NVUwejhiNHo3RkVXQmJseThWcEVpRHlvMjJHekFHdkMybXUzQnlvbmNJQU1Q?=
 =?utf-8?B?Y2F4YkFDNTVKWEQ4ODZBb0MyNEppRDJzZFRBRStLdmhHWEpvOHdKTHRoL0J2?=
 =?utf-8?B?T3lhY0dHckRMenVkbUVZT0J0Nmp0K0Z6SHFoVVVEcW1GT0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzFRMm5GWlpDc285dWI0eWxWR1c2MlNNd0ZBOThQbkNiaENMblRXVVp5YkdS?=
 =?utf-8?B?THB5RHZEOGplZDFvVUVtM2kzRFYrbWlhZURFejdlanZzR3gwSzk5R2ZXajkw?=
 =?utf-8?B?Z1o0ZTgwZGNmWVRHNmVYSG9xM2l6SVpzRnQydHVoanpJY1U1d0JBMENJSmxs?=
 =?utf-8?B?QzhuQnlkRk52NHFZTG90cVB4V0tHS1U1aEZoRFVQaWY2eTZ5WG56Sms0d2dK?=
 =?utf-8?B?a1FRZXlhOGZmOTdKK2ZPTlhSVW9ybDdBVGY5MHVEWm9RSHdLdUxUam4rcnY1?=
 =?utf-8?B?NXdIMFcyb3BOYk1vWHdzVlgyaW1oQ0p0RDZQRnRDK2NoaXFKZlBEZEpCYXdU?=
 =?utf-8?B?NzRaaGp1dml4eE15TVNaRHJWcVU2SHBVUVNOQjJMQ0dyN0Fib3UrQklVUk1w?=
 =?utf-8?B?cDJSVkVnTlFiMGZadndPRG5hMFZuVi9TNjhnRXk2b3RWY2RjWW90ak5HdURt?=
 =?utf-8?B?QWZvZlNXM0VzeHVpVWN4cFBCQUxqcllYWUpXbTlNbUZKQ202eCsyamtXL3Vt?=
 =?utf-8?B?WDZyU0RQWGhoSG1KdHc3UlNXYW5tWGFSSU0xVzE1ci9sOU9xazdYbkZDY2gz?=
 =?utf-8?B?eGFOQ0tVb1VRSjZtb2FpaUlYWVdhQ1k3bTM1dC9aYXVMOWVBVnNidVpUdVo2?=
 =?utf-8?B?ZThNSHBEdEpBZ1owSUoxa0duc2xtSFNlSk1iaEhGQko1VEVPMDBpWjFCOExQ?=
 =?utf-8?B?SHdESThsYnEvL2RvSDJMektoazYyZGpmZEwzTXlMbjdka0FQckNhaDFpb2wy?=
 =?utf-8?B?TjVNbFBuanBEa1k0dWszbEJwTGVmQ3BMa1JJOVJNbXlQSnQ4OWFWSkFYeEFa?=
 =?utf-8?B?UmtKMTBaTy9lYVJkNEdEcEppZ2VkSFFHcHRFVDlyVU5WcTRrb2xvWDAyMm5C?=
 =?utf-8?B?bUlKcWZHS1BnQU82QTdjbWJYL0UwT3pqSW1qTkM1L0tyS3hmazZLNlJYb3BG?=
 =?utf-8?B?RXJsSXpnZ0xaVjJqbXN5SmpPcVBLenZlQlRxQmlhY3lQVXVESFJFajhRMUZ4?=
 =?utf-8?B?RTAyRkc0d3hWMHZPNWIzWGUxNFB5M3poNmdUTWNpckJ5R0lZV1BaYk9yZnRW?=
 =?utf-8?B?NGxGRE1rZUk2dFQ1YzZteG5RNWRFNEFKeTBjRFdlYlM1UWx4MmJuWFZoYmkw?=
 =?utf-8?B?RXFzY0VwZy81NXFFc3RBbDdRUlRoVGFxR3VYYXluajJQaDJiaitWT2h3NktF?=
 =?utf-8?B?VGE1QS9jNldMMEhHZnBlU3VRUFNUSmNCcFhuR1R3dUZTTDFKVGZ3TFgvR3J6?=
 =?utf-8?B?RXFvTWFxSjVXamRqaytDQjN0YmN6UTlkQ3owcENaeEFSQ015ZFNnam9sR2JO?=
 =?utf-8?B?OFpmb3RGRXNIWmRucWtCbHJ5aUQ4dStkV1NHOUlyUVZMdER1YThkQU9CZlA3?=
 =?utf-8?B?NXpzUzBBNDBRVElrd2hsalhMR1BydE1wV2d6bWwvODV3NzFudjhzVkJWMEFZ?=
 =?utf-8?B?MXh1QS9vSGZvc1VPeUZBVFhZZHRxYzFidjFwRUZtcEk1eHI5TGJEOFdXSHJv?=
 =?utf-8?B?bmRvMFd2cTMxYy9yQ01BcS81QVordGF4VFpoVW14UzQ1VTdYbmticWJwWU8z?=
 =?utf-8?B?eTdlbHRicU5VMHdaMlFsWVBLTHBhTnBuUUNDODloVVB6Vzh4QzlVOU05ejNq?=
 =?utf-8?B?M0dFTHVMN3J4L29iUEd0bUJKOHhkZnpaakpFSWd3c25zc3JkVlhmL0pIYWFW?=
 =?utf-8?B?SlhSOFFoeEJKTXg5T2xqaE1TWVRwdkxQMHR3QUxTTU1EVWZVWUxQaVkxdENx?=
 =?utf-8?B?RUs2RFl6R2d3RGJvbHM4bGNSbVdsN20zcTdEVCtzLytic081ejVhTndReU83?=
 =?utf-8?B?dGRsRnBtTWk1RFhaK1Q4dnBSZ3poOFhFaCtjL0E4TlI5WnlmbDdwUnJYRVly?=
 =?utf-8?B?aVg0YXk3WkZWUXNrSk92SllBWHczZllwc2RYTXZyMi9DY3NFUEo0SDFJSEIz?=
 =?utf-8?B?RkM2Q3BUdHlvRE9PZU1GbDdKUmc0dEtjRUl4UDU5S2t3bWRhYUk3ODk4QzFQ?=
 =?utf-8?B?SDFpUWhTbzlyWG8vM2JFWHJHdmx4S1dVRkJjQUU5d2lUV0dNUDFxNHVyTGtJ?=
 =?utf-8?B?blR5YyszTmNkS0lXdmNtcFJnQzlUazlvRXVwSGtXbHUzOXBIcjJwejZzTWZS?=
 =?utf-8?Q?Ys9Dl9tCrOlsr4O09JFI1AcKW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5926996-ef94-4a9b-7a2d-08dca70cbc6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:33:52.1919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+9sxuZxlJd7XIKmHmD2ZitPY5gaF8usmvG2/bV9sfSbDZxBDFKweFFH9EJEDtwJRy/Av8duWWy1azeEyyJiI+p3l8IzZTEx87maWoytHRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6171
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTUvMTVdIGFzcGVlZDogYWRk
IHRtcDEwNSBpbiBpMmMgYnVzIDAgZm9yIEFTVDI3MDANCj4NCj4gT24gNy8xOC8yNCAwODo0OSwg
SmFtaW4gTGluIHdyb3RlOg0KPiA+IEFTUEVFRCBTREsgYWRkIGxtNzUgaW4gaTJjIGJ1cyAwIGZv
ciBBU1QyNzAwLg0KPiA+IExNNzUgaXMgY29tcGF0aWJsZSB3aXRoIFRNUDEwNSBkcml2ZXIuDQo+
ID4NCj4gPiBJbnRyb2R1Y2UgYSBuZXcgaTJjIGluaXQgZnVuY3Rpb24gYW5kDQo+ID4gYWRkIHRt
cDEwNSBkZXZpY2UgbW9kZWwgaW4gaTJjIGJ1cyAwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+DQo+IEFzIGEgZm9sbG93dXAs
IHlvdSBjb3VsZCBtb2RpZnkgdGVzdF9hYXJjaDY0X2FzdDI3MDBfZXZiX3Nka192MDlfMDINCj4g
dG8gcmVhZCB0aGUgc2Vuc29yIHZhbHVlLg0KPg0KVGhhbmtzIGZvciByZXZpZXcgYW5kIHN1Z2dl
c3Rpb24uDQpXaWxsIHVwZGF0ZSBhdm9jYWRvIHRlc3QgY2FzZS4NCg0KSmFtaW4NCj4gUmV2aWV3
ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4NCj4gVGhhbmtzLA0K
Pg0KPiBDLg0KPg0KPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZC5jIHwgMTAgKysrKysr
KysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVkLmMgaW5kZXgNCj4gPiBm
ODc2NmVhNDYyLi5lZDk4NzU4NzA4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWQuYw0K
PiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBAIC0xNjA0LDYgKzE2MDQsMTUgQEAgc3Rh
dGljIHZvaWQNCj4gYXNwZWVkX21pbmlibWNfbWFjaGluZV9hc3QxMDMwX2V2Yl9jbGFzc19pbml0
KE9iamVjdENsYXNzICpvYywNCj4gPiAgIH0NCj4gPg0KPiA+ICAgI2lmZGVmIFRBUkdFVF9BQVJD
SDY0DQo+ID4gK3N0YXRpYyB2b2lkIGFzdDI3MDBfZXZiX2kyY19pbml0KEFzcGVlZE1hY2hpbmVT
dGF0ZSAqYm1jKSB7DQo+ID4gKyAgICBBc3BlZWRTb0NTdGF0ZSAqc29jID0gYm1jLT5zb2M7DQo+
ID4gKw0KPiA+ICsgICAgLyogTE03NSBpcyBjb21wYXRpYmxlIHdpdGggVE1QMTA1IGRyaXZlciAq
Lw0KPiA+ICsgICAgaTJjX3NsYXZlX2NyZWF0ZV9zaW1wbGUoYXNwZWVkX2kyY19nZXRfYnVzKCZz
b2MtPmkyYywgMCksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1RNUDEw
NSwgMHg0ZCk7IH0NCj4gPiArDQo+ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9hc3Qy
NzAwX2V2Yl9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZA0KPiAqZGF0YSkNCj4gPiAg
IHsNCj4gPiAgICAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7IEBAIC0x
NjE4LDYgKzE2MjcsNw0KPiBAQA0KPiA+IHN0YXRpYyB2b2lkIGFzcGVlZF9tYWNoaW5lX2FzdDI3
MDBfZXZiX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkDQo+ICpkYXRhKQ0KPiA+ICAg
ICAgIGFtYy0+bnVtX2NzICAgID0gMjsNCj4gPiAgICAgICBhbWMtPm1hY3NfbWFzayA9IEFTUEVF
RF9NQUMwX09OIHwgQVNQRUVEX01BQzFfT04gfA0KPiBBU1BFRURfTUFDMl9PTjsNCj4gPiAgICAg
ICBhbWMtPnVhcnRfZGVmYXVsdCA9IEFTUEVFRF9ERVZfVUFSVDEyOw0KPiA+ICsgICAgYW1jLT5p
MmNfaW5pdCAgPSBhc3QyNzAwX2V2Yl9pMmNfaW5pdDsNCj4gPiAgICAgICBtYy0+ZGVmYXVsdF9y
YW1fc2l6ZSA9IDEgKiBHaUI7DQo+ID4gICAgICAgYXNwZWVkX21hY2hpbmVfY2xhc3NfaW5pdF9j
cHVzX2RlZmF1bHRzKG1jKTsNCj4gPiAgIH0NCg0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRl
bnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQrlhY3osqzogbLmmI46DQrmnKzk
v6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+
i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrprkuYvmlLbku7bogIXvvIzoq4vku6Xpm7vlrZDp
g7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvnmbzpgIHogIUsIOS4puiri+eri+WNs+WIqumZ
pOacrOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWSjOmKt+avgOaJgOacieikh+WNsOS7tuOAguis
neisneaCqOeahOWQiOS9nCENCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVzc2FnZSAoYW5kIGFueSBh
dHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2VkIGFuZC9vciBvdGhlciBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9y
LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFuZCBpbW1lZGlhdGVs
eSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdpdGhvdXQgY29weWluZyBv
ciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0K

