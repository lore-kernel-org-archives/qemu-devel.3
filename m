Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1F1CEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 02:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su0Ws-0000hL-Ia; Thu, 26 Sep 2024 22:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su0Wq-0000cB-QJ; Thu, 26 Sep 2024 22:16:20 -0400
Received: from mail-sgaapc01on20711.outbound.protection.outlook.com
 ([2a01:111:f400:feab::711]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su0Wp-0007kk-Ad; Thu, 26 Sep 2024 22:16:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAAodAdm7OLnDv71I05GbYh56rc8zgxuKtx1JQSGzfOEEObT0QHE1JMZJPY9WTFzG7CmF8o6IxuNkxPbEkWbqV1ErjM8YKp5MDvWUWPSKT+FwYLjCeuXIJcwBcNyqVNO2Mpxzp26XSbvC/f5p82j5Y6uMPpV/1hnPnN3Xoj34PB/1uUL92R9OHYyhf99MPmSDBf4Ff1fAVVrtAyl3jBKSwEZuhT5EadNBZp1Uv2j3y0cUNHBLYb/nZeGoGWvKsxF/A6uTH28Atp/ERtD3JQzrZt3tB7tN2+KgwdXC8AAdHBftENgJymedXl6NhjGIEIQAfRgu6ej71JEC35EgBmIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08NCA+68p3knCi8bugVEyTMBQK8R5hwuFFEzimjxvSQ=;
 b=vFFxZ//5h/cGf83UeVQo/mCndoj45e3lcU+7lA+LuKiXbdqWL2za1c1O/6tV0eaiuxe9y+a+Ztu3moW4ad2iDMFrHPlG4+9gC9eBmj4Ts3qMaYSDzos+1qSElqh66483ZV+cQTOITHwOsU8/l6BYNRgKD/2PhslZ0kmuAse5A7smsIL1F+ezWBo5NZIbdBbq4EBu2d3SKBcLZJlVjRgA387m3Orn8P8wCq7IZk1K1GikjjTIGBqUhqHXylGM30xw6zgB1yO988ZQzT87QCsOR/QC3b94lp+Y+bFemze49+BSIFKH15YOphmG+EcSb4YztFZDd2Zxyo3E2feWDadapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08NCA+68p3knCi8bugVEyTMBQK8R5hwuFFEzimjxvSQ=;
 b=gfohZWNZA6dk/Myr4lHncDHCDyWBpmOORqP6j1jLmJLctKi0JcLAowxVsL3aj/3UFJBKZEUmk2xjg87Pq2b4RpWpuD3P2mQvfJBYqLqW8nTB4Iv9gTIo1QZkuKb0jtec/d94zusxCSX3eVjDh32GcWRgpe12asgRy0If8C6SpcR6cQGwv339berVkamAvQOyxRrKjk9honKKB6qbiJ7B+wK+U61yU7wJefbSKAJty52QqYcTcsKiAxfGoujKswnQvF1b+3b6s3GSBdXgjRpkSxnLgcXBv6NAP+TC2bu+HHIe4AoKMYrYq2QtBBGIVb4eCdd6/qlqEet+wlgQzZcDsg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR0601MB5799.apcprd06.prod.outlook.com (2603:1096:820:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 02:16:11 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Fri, 27 Sep 2024
 02:16:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 0/6] Support GPIO for AST2700
Thread-Topic: [PATCH v3 0/6] Support GPIO for AST2700
Thread-Index: AQHbD+gVwmQ29c/aREKHLSGeVLq1VLJqPfuAgACof6A=
Date: Fri, 27 Sep 2024 02:16:11 +0000
Message-ID: <SI2PR06MB5041AC649E5F76F2700A42D9FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <e1076f8e-2e32-41ba-adf4-8e28aae8e526@kaod.org>
In-Reply-To: <e1076f8e-2e32-41ba-adf4-8e28aae8e526@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR0601MB5799:EE_
x-ms-office365-filtering-correlation-id: 2a0cbd3d-9386-487f-5e69-08dcde9a5b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QXVyTDJwMDF4VzFwazVjTDZaMkJIdjhNZk1mdmExTUJwekxPR0tqZDg2UnRT?=
 =?utf-8?B?OXJVR1RqSW5STE5hbVk2MTlzb2NuZTl2K3NCRGlPanRpb0h1bGdxYXRRUkFW?=
 =?utf-8?B?OEt0MkJEZnYwVEtJUU1oaFZkaHRCR3pYbk5xczJnazQ2K2MxVGJQQ0VXdkxl?=
 =?utf-8?B?Q2JNMXJ0Sk9SUUY4TXFSY2NxeHpYdHBjOE5iY21hVlBSY2ZseFJLYlZUQ05V?=
 =?utf-8?B?bCs1VDJQV0ducTFWMlo2V1E0VXlKOGVQSUpRNVgvaFhxTWp4RXd1SUJTUDEw?=
 =?utf-8?B?UDBRam1SdkNoZm8rU1ZmMWxkL0o2TVNiemdHN0hFa3NWSVlyNE91am5BNVlR?=
 =?utf-8?B?cDlaWG1kVjczZVhLUjJQVWZpY2laMHMrS0lwTzFqVjltMnVEcXNoL3JtYTZ0?=
 =?utf-8?B?OVpqTDc3dzkwU1R4cTJKY0JkdGRLWThYd1BMWDZJREJiZENSUWg4TjdqZlN3?=
 =?utf-8?B?clhxTkJnaENESWFkLzRDKytqYndEcUF3dkRrYldUZjdFcVBMUm9WODhERnBD?=
 =?utf-8?B?VFhvMVA0KzR0RXF0amE0NVdtSmVmYlhCVzVmZlBkUXFoSjFtaTZLSEZzSjFz?=
 =?utf-8?B?RnJKK1ZBeWw4VlNQbTlVLzk1VlR5SU5LZ0g5OU9XMGt4WEI3TkJLcHZXY0xX?=
 =?utf-8?B?QXVhREZJb2hvTFNQakgwZWNPK0tLTG9sNG03UHFOck9MNjVXaVdXbXJFKzZ3?=
 =?utf-8?B?WU5hc0gxV1JhUXduQlcwMGNXell3SUNqb0RDd0dubENxMVlXQVRzN0tQQWtV?=
 =?utf-8?B?NkRQRmNDQ0lXMjc2cnA1Q2pUM0NUQkJVOWNCWDB6Tlh1MkdhSlRMWlc1eDkv?=
 =?utf-8?B?TGFmK2NSTWRhSmFid3lhQzNYUVk1dFRTTUJrVGZqdE15VUVoVThvVC9oZElO?=
 =?utf-8?B?bkhnR21XZUp5SklxQ1Ivc24vNDQ5R1lkRTZRekVqbEpPUVFKMWRJbUd6RVEx?=
 =?utf-8?B?UDdyaHJPZW9HZG9BaTRHdVh4NWlycmJoVFhoQ2c3MHFDUm13UktqeWF1RzMz?=
 =?utf-8?B?dmNoOEx6bXhPNTRYQUhLOFpCeVZmYUdxcXFuOEF6WGJzQlBXWXFxQWErNVBC?=
 =?utf-8?B?eW13bStvd0FYcVJHWWJHQTVUeWh4bEQyaGQvbGM1amN5NDdwZStrZ0NlNVpv?=
 =?utf-8?B?aDBUWmNJemVIOHczakxyejQ0K25FUGt4UHQ0QlFBVldyTVYvVWRreU1YNnVV?=
 =?utf-8?B?aU1aanJON3Jmb25KSlZrMmR4cEtyV2o1a0xJQ1hUQ250TXF0eUg2a1JEdzFL?=
 =?utf-8?B?eWF1MXVsM202TGgzSUVHWGgxK2QzcVZyb1NiTVRXMkpybG85Y29WNVF4OURU?=
 =?utf-8?B?ZGw1VEF1ZG9EcmJUVThpZHhackxQelczQTQ5M2hQZWdPYmNWbGsvcHZ1YXlm?=
 =?utf-8?B?QnB0YUdRSVhpQzBjdmN2Wi9JVzR3dHQ2dWxxbEg2amNXNXJkWlJIMDNlR00x?=
 =?utf-8?B?aWF1QlNvZVZtS3o0T1JVZU1oaVpPV0s1TE1WN2dwSWpHOGlHVjVIandhQXZD?=
 =?utf-8?B?aUJSSkRqeHB1ZXZLa3pIaGlxSEFCZ3ZGWGhJV05LdDNVbVNrMXVQemVwVkJG?=
 =?utf-8?B?SXA5NEZaYmxsRSsrczN6blh1ODJUaXMzU1QwQTB4WUdsajdEVmRTN0dCaDFP?=
 =?utf-8?B?ZU1IWi9UVnJObXhXNnRjVW93YlZRVXBnZHRYdzRRSlRqcU9aRE1mNk1LN0FL?=
 =?utf-8?B?QlhXWkw3MkdJaGY1NHprUDRRMVgvUlJuU0dPUmFGTXJ0dEV3UE05alU0VlN4?=
 =?utf-8?Q?W0GxeOL5yxMXumIYxiRp+qk8fu0EZCa+n49mEnY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEdKaW9neDZ3QUNNdUhGd1hnbEtuSU90ZDNMTEpZSHBiRWRhWU9TeUQwMHJB?=
 =?utf-8?B?dGR6ZVVFSW5nVXpnQ0JyTGQwSHZpdDJxclhyeitGMzVIZXZWSm96ejhVeklN?=
 =?utf-8?B?cld5MkFLVkZvOTZPOS9Bbnd0UWcvYVNGTFhEZEt6b0RkcCtvWEMvMUhiZlFC?=
 =?utf-8?B?dlRmZXdVNVJYSU5rQlVIQW1DczByS1hXVGVUMzBiN3pkaW5xTFZwTVp3RVdk?=
 =?utf-8?B?V0czVHF1VW1vM0dUaGdmTkRnV2E2NEhEWFBTeVY5NktFaVI5SFdGNXdDazEx?=
 =?utf-8?B?SEd5ZW80ZysyTHYxeVhVVVI4RUQ2TEtZSHlsd0JPaFNzQUVOdXlQSzRhTE5i?=
 =?utf-8?B?SExoY2l1V0tDU01FcUN2OXlZQ2hsYndDb2R2TVFET2VWSHlad09NZHlLcHhD?=
 =?utf-8?B?UVAzbjhJYW8ybXA5bzJjZExjc1pJQnVZSjhJMFRabmFqZVJMNUp4dmpONmw2?=
 =?utf-8?B?b2xlOW5jcVBQcWluRHBhU3J0Q0xEY2plN0xtSjRSMWduYmNtNEtDNXU5dDBF?=
 =?utf-8?B?U3g0STJWRmc1Z1dsaFI2dFRXdDhXc2FtYkVTS29QVWhvWWcrb0xDRDh3V09s?=
 =?utf-8?B?aUFndnJFaHNFWCtzdkVUSHFVbWFuaVZHVWVjMW5TZmZsTWZmU0RJM0NqYWVD?=
 =?utf-8?B?WU1GbjVtS05sRWVSSGFnQ0xKQmJ6NXlVV2h0OGJhL3lPbGljVjJOekxNZk1i?=
 =?utf-8?B?RmUxcW13bGtKTXBhdUF2TmlBSkY0SG5lS0ErYTdNaHl6QVFmYk55N1cySDcz?=
 =?utf-8?B?clBxNFZRRUZUTk1CK2JLb3QrM1lSWU5wSTIrcE5QdDdJbElQM2dWYVFZR2tU?=
 =?utf-8?B?TVhVMVVabnp5YVM5VVN4TjEyQ3Zodi8rajRTRFZlSVBTSjAxSlExckhXdXln?=
 =?utf-8?B?dGw4N0tsODk3TytZQjQ5dFYvM2xBYVNtY3dzSzdhRGNTZm5TZ2xtK29WL2FZ?=
 =?utf-8?B?Y1oxY3o4djBYaWJRN3gyU0ZZVjV6MElKcFJhWlpmdjZ1T0tQbG12UmdMaTEx?=
 =?utf-8?B?ZERYSFlrLzJVa2E5U3Y4Q2x2V0xyenVWdENPbk9ydHk1NFpJQi8zWWM5Q3Fm?=
 =?utf-8?B?TFJBT0NTaW85VCs0S1BLUVl0Si81U1M3ZG51ZjBkNnZuRk5sRjdLL0xwV0FK?=
 =?utf-8?B?RnVET0RtaFFTeWdhSDBSNHhQRmxPelVXenFkY3NWYUFoejhTMDZGV1dIT21a?=
 =?utf-8?B?VlJzNC9XQ0FrdEl4d3Z6SWVqMDN3OTVEUXk0OWpyRDB2aFlUaHduNkQ4U1N6?=
 =?utf-8?B?VmlJR2l5WTQyU0pmVmxpS25hTjRKRjNGMFpWVjNBWURUTGpCck9STmErakph?=
 =?utf-8?B?MHkyOFBydEpmMUE5c0VWam0wU3krdU10OUprYzF6MlZTNGhrWCtoTVQ0enpi?=
 =?utf-8?B?MTF6T1JFRTZ1c1B1dVdSdWl1dlRVS0xlSnBpR1M1aElIZUJOUllKeTNpSUFk?=
 =?utf-8?B?dXBrYkROekRiK21YQVdEMGpyWi9Odlg1TkpJejBJQ21kbUFGYjVhT245N2Nh?=
 =?utf-8?B?d3J3SnpqM0w3RmIrZ0JmVU5oNkJwL3RqdDNTemxmc0llUjJwV0lYaHlhZ21a?=
 =?utf-8?B?eXR1Qmd6aHRXRkRFMC9zVHRDczh6eFVMLzdUMU16MGJ3OEtHZnpkVncwQzk0?=
 =?utf-8?B?cmgreTNlems3YW1LeUREUmVDbWtKaVFFc2FzNDQ2RE90UGIzRCtBdVBKOVVp?=
 =?utf-8?B?TnFlNzFUTDQ1dFVobUJEdFFVTnVkekU5c3ZDN1JrczZlNTJrZTVhV0RvVExv?=
 =?utf-8?B?V042N3cwWmVsYkJ4eG83d1JNZVNqU25Eb3pwVHVDb0s5ZE1wMERmblJQcFpN?=
 =?utf-8?B?YkJwWVNTVjVBTm9hUGtnbC9Ic0hZVmg2UE5rUlg2N2w5OVhMRHo0QzgyZG5y?=
 =?utf-8?B?SnlRRlc4RUJOTmxWTFBmVGc5dFJDSUVEekEvb3I4WXErazAvcTRaRGVYbTFI?=
 =?utf-8?B?NnhUTGhpbHZyaXh2dktMZXRnYXNwVlJ0eWd4bnVITnpyMWVHeEJ2MWFZTFJ6?=
 =?utf-8?B?U2luUmtKUlVsM0NPcXlvOGhpOEFNMFhKYTV0aURpR2RYbWpDY2lKRWJjdW9Y?=
 =?utf-8?B?OUlUSm5YRWo5RnFsc0I2QmJpcjlycWN6TFUxSEtlWkpYcEVEUE40RU5hYnor?=
 =?utf-8?Q?l+TJ5lVGnAaU1X+zJ0flZBZxa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0cbd3d-9386-487f-5e69-08dcde9a5b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 02:16:11.4422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R12tyzzFSp5jS/ZBgE/eVFhppJojpFzROqfynijXla4di/eArh6FjCYrrVOG8kcbemMO9UWtmau98MUTdERRIBx1Xbx+Ef4+fiOCMKACXO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5799
Received-SPF: pass client-ip=2a01:111:f400:feab::711;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC82XSBTdXBwb3J0IEdQSU8g
Zm9yIEFTVDI3MDANCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gT24gOS8yNi8yNCAwOTo0NSwg
SmFtaW4gTGluIHdyb3RlOg0KPiA+IHYxOiBTdXBwb3J0IEdQSU8gZm9yIEFTVDI3MDANCj4gPiB2
MjogRml4IGNsZWFyIGluY29ycmVjdCBpbnRlcnJ1cHQgc3RhdHVzIGFuZCBhZGRzIHJldmlld2Vy
IHN1Z2dlc3Rpb25zDQo+ID4gdjM6IHJlbW92ZSBuZXN0ZWQgY29uZGl0aW9uYWxzIGFuZCBhZGRz
IHJldmlld2VyIHN1Z2dlc3Rpb25zDQo+ID4NCj4gPiBKYW1pbiBMaW4gKDYpOg0KPiA+ICAgIGh3
L2dwaW8vYXNwZWVkOiBGaXggY29kaW5nIHN0eWxlDQo+ID4gICAgaHcvZ3Bpby9hc3BlZWQ6IFN1
cHBvcnQgdG8gc2V0IHRoZSBkaWZmZXJlbnQgbWVtb3J5IHNpemUNCj4gPiAgICBody9ncGlvL2Fz
cGVlZDogU3VwcG9ydCBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbiBvcHMNCj4gPiAgICBody9ncGlv
L2FzcGVlZDogRml4IGNsZWFyIGluY29ycmVjdCBpbnRlcnJ1cHQgc3RhdHVzIGZvciBHUElPIGlu
ZGV4DQo+ID4gICAgICBtb2RlDQo+ID4gICAgaHcvZ3Bpby9hc3BlZWQ6IEFkZCBBU1QyNzAwIHN1
cHBvcnQNCj4gPiAgICBhc3BlZWQvc29jOiBTdXBwb3J0IEdQSU8gZm9yIEFTVDI3MDANCj4gPg0K
PiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgfCAgMTggKy0NCj4gPiAgIGh3L2dw
aW8vYXNwZWVkX2dwaW8uYyAgICAgICAgIHwgNDI3DQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCj4gPiAgIGluY2x1ZGUvaHcvZ3Bpby9hc3BlZWRfZ3Bpby5oIHwgICA0ICst
DQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDQzMCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkNCj4gPg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSB0byBhZGQgdGVzdHMgaW4gdGVzdHMvcXRl
c3QvYXNwZWVkX2dwaW8tdGVzdC5jIGZvciB0aGlzDQo+IGNoYW5nZXMgPyBBdCBsZWFzdCBvbmUg
d2l0aCB0aGUgYXN0MjcwMC1ldmIgbWFjaGluZSBpZiBwb3NzaWJsZS4NCj4gDQoNCldpbGwgYWRk
DQoNClRoYW5rcyBmb3Igc3VnZ2VzdGlvbi4NCkphbWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBD
Lg0KPiANCg0K

