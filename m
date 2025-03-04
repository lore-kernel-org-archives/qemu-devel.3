Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5B5C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 03:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpJHS-00044Z-6O; Mon, 03 Mar 2025 22:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpJHO-00044B-S4; Mon, 03 Mar 2025 22:49:15 -0500
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpJHK-0002at-KC; Mon, 03 Mar 2025 22:49:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRVQMBsQuNBf350DNGtEnRtwRzXMnIHiNO62qABlrpRLROjf/IuHVPvXj604dAGBltOIQTl7eehiJOSh88MisU13iXDWChPuwn8VGTHRPK+XNVUwrUoNfPGYTxIZSeuRRXyZFZqafZc7z7DmZcN0olve43U+FtHGUodH6Xqerqnh2bowD0na/q69yNXEYfxErdfzE9guGvFp/hdcSLNJvBUk6sAyhvD1HZvOTWI9v4ICOpZNJLF16S08emDe7LhyzKqW1LlGP3pwDEURBTKuwZdsnszDWVoH/l9tgGA4SgMy7SD6jxipuFLlZdXHEKrQvdSi7Nx4ZIG8gJ9f0e2mVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikOQZdoBlid2njRZ0ZRfNGgb2XjVDxq1mrkknwnN4eA=;
 b=cN0dc9vNOqatkxVPoPXNhG9SszIF60tUqx+nDHG8HEvppdcvshUl4fjasDPqWaGJDNfyLzyIWGWN9IV/C3VGm1Vz1LwH/hWZtsGLIoEmfva8W7DUXVOuxLnSHKLYy4DZddbZsGu3ckMr15EtGaGbW9wkQzVXyqoLhZUNxhwVlbmKs+k14BTlrhu/o9RE5QDSLvoZvvEya22j1WClNIQE51/wU4nrtclPQ9crtIlW0QvnbjqIfKzrwxK1z92ctRr2jb0anrgeciJWrn75A70xSVPr2i1Kx2K6e58tdCH3kFHV5DXnEXZGo4PtwZzb/GdyF0LBojdb7MXZhV69KlEJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikOQZdoBlid2njRZ0ZRfNGgb2XjVDxq1mrkknwnN4eA=;
 b=mLEKLvjk+Hbst9myhLo/jo3/3ptvuCqiMUgq13pIyrokPLK0UGNyhTjbD/i3hI9BCLxf5KfpHFGD4x0ANcufE3tliT6jSQbKvHJ7kVcqKXLfH/x0LpbNGsUrHGspj5OUFukXHgzVo33+EAvCNSmOk+xul3A//r05UJySlFZIq6d6uyq9TFmulQC3etlqwP5gQVsKRZKknAtXNY7EdNGxe+lq57JLR4+VkHeX3SyOvyt0GNR1aNYvMyEhYqECJ1/OSW+VXyL+tyGvdf0nB2df8Yyik3InuvwSpkxGO7pydyINaz/qwPIy9Rb5pIbiylIaaG4VW/URIlAexutldBsVQA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6764.apcprd06.prod.outlook.com (2603:1096:101:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 03:48:54 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 03:48:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 21/23] tests/functional/aspeed: Update test ASPEED SDK
 v09.05
Thread-Topic: [PATCH v4 21/23] tests/functional/aspeed: Update test ASPEED SDK
 v09.05
Thread-Index: AQHbjCJk5ldEiA/AnES15zYQj+UR8bNhoI2AgAC3aQA=
Date: Tue, 4 Mar 2025 03:48:53 +0000
Message-ID: <SI2PR06MB50410D9982B7D8FD90359BA4FCC82@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-22-jamin_lin@aspeedtech.com>
 <fe5a2bbd-789c-4add-b256-700d98f6a107@kaod.org>
In-Reply-To: <fe5a2bbd-789c-4add-b256-700d98f6a107@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6764:EE_
x-ms-office365-filtering-correlation-id: aa3abd79-ccd2-4f40-fa7b-08dd5acf7bb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SW1FSk1PSnprUTB3LzkrNDhkQ1EvYTJpdUFhTlEwOUpRNVpzVDZTQzhtSWNr?=
 =?utf-8?B?NlhzOGNUZFUvdUw2eno0VGNWSVJIcElwS0Z0b3lqTGJoOHViUjA0TXRReWNV?=
 =?utf-8?B?aGV0R0s2SGtITjR5NW4zOVVvdzlxMy85a3JMVzRjVVJFWDFNT3h5SW5DTkdm?=
 =?utf-8?B?L2ZOYWdqSENFbzhsdk1jcEVkaEhBYXgxSlo5SUtGSmU5Q0xIL3FHNWFqWEF2?=
 =?utf-8?B?SkxBRGlwUXoxV3dWeHVjUlJCWGczQXpuTlBYQTBpVDlDcTFBYjdrT0NNRmVI?=
 =?utf-8?B?dGtYODRXUGdwNmJTSFRndGVZNFBnazd3aEU1YTVIT0NKc2lWTnFaakVmQjFN?=
 =?utf-8?B?a1FQL0JmWGNhWGorcTJ4U21idmlnYVBiVlRPSTZNRGUxTUc0dGk3OHhwTzIz?=
 =?utf-8?B?MXp2bUp6YkJ1TlZvUlkzU1M5TWNraElYWXZ4VDhhajVoQUlpcS9zd2s4UTBG?=
 =?utf-8?B?aVUvTGF4SXAzd1NvdmNLNjdIeDl0M3UwNkNNKzEwL1YzdzVwUkdUTHdtK29Q?=
 =?utf-8?B?NnNZNldqQzZJblVoQXdpMWhsdkdWL0JrS1pNZndLWDJhYTJpQ055Nk94eHZm?=
 =?utf-8?B?RDBCR1JjQndrR0RpL1VMY0FURXViNW5NK2pnMERkOFlwdUgxeTRydU1INGND?=
 =?utf-8?B?bUIzV1hsMmdLZEJTVS93cmpId21vdWZBZUc3OHBuWlVqamtQcE9ac2FIcTRr?=
 =?utf-8?B?ZXZNTmxWQWxTVklLbTRMbWVaN1J6TzF3Z1k2SVQ5ek5obWkzV1lRQ0ZOZkd1?=
 =?utf-8?B?WGxiYWJuSzU3YldWbmVEWnZCZUxuaGVucXpvS2p3aXpkZTA0b3BxK0JNSkE2?=
 =?utf-8?B?aXk2Mk5CSTlpdGdlYm81ajh0QlRqaTBjeTdLVFZ3TG4yaC9TaWh5Ri80T2ow?=
 =?utf-8?B?ZVZrRys2ZEtnbGdqMGxlZDFSZ0RiRExYajVOUGlaV01JOXg1dTdZQXp6UXBa?=
 =?utf-8?B?MHMwbm5CSy9Ka2JrMVg1Y3FmOGJYMEU5WFcrUDZXdlpWN1B3R3NuTlVQNTYy?=
 =?utf-8?B?MEF5cUJ1NXpRV1hqbFNSakZOay80cmJoYi9FSE1zRGZWc3Bld1A5NHNzMjR6?=
 =?utf-8?B?OVpVMHNQcmlCak1hQUd4QUE1STVvbEJ2VEJENDJjM0oyNmduNnJjQWM5cm5l?=
 =?utf-8?B?RGtsN21vdC9ScmF5UFprTTJmS1pqZmIwV1JaMkpEbGR5L0tWa1E2SUh4ZWNI?=
 =?utf-8?B?YjJRK1B0NmZyTlFXdW14NTJybTFsOTVMU3hTQ28wWXdnalpZcUd4VW8zcGVJ?=
 =?utf-8?B?NGNtZm85VVNDVXRjd2VYcFFpOUdhcHkwL0xmeUlEMXdjSStYQlUrWWlTejNk?=
 =?utf-8?B?aDJJN3Z6V2o2eUZGejIyLzIzQUVldGQ3UEtpQmlvY1VuWUhHREUzNEtKenhE?=
 =?utf-8?B?bzkvZVJzQm4zNDlHbUt6WnlpZldEL0szNEtrTTk4ejV3a3h4Vzl0eUpsZ0hx?=
 =?utf-8?B?NEY5K1lXNngxSmpSTlZKLzhFM2RuZEV1YnRZelBySTRPUUpiV29rRnhpb2lv?=
 =?utf-8?B?aUZHY05oWWZaL0pZOHZ5TEwvZ1RPOFlIdWRVTzFoTG5XaUdKbmdaSjdMWEdo?=
 =?utf-8?B?WW1TQ2kyaDhlZXltbXFPVzBOZ1NzZnZ0Zmo5SldQOUpBbFRRWXpBMlU3RTdi?=
 =?utf-8?B?cVBSaWp1em9aMmpwMC9pZlpsdEU0bkRvVXllYkdDOE10SW5IWHdMYkxXMjBu?=
 =?utf-8?B?L0NmZWVLL2J1dlZVK05vY3JYalB1dEZJVUFCbXpwYUtKN0RvdUhuTUVHV0tS?=
 =?utf-8?B?cTA4R1VsTmlrNmJEM3ZRMWI2UTdKckozbVNRTCsvc1NWbG9iVm1FRjNnTmZX?=
 =?utf-8?B?SmdzQ2VxdFhiRHRoeVZRb2hRa3YyZFZWejduOEZoOXRXYlFyVXhmNVUrTkEv?=
 =?utf-8?B?OSsxc0ZqdDlSR1pGeHpZR0ZNUytydGh0Yzh4YTQrSmc1T05hNFJqVzdnazRR?=
 =?utf-8?Q?QP3Yt6MloYpebYi8AGa9chq8y6w3Gnqy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmo0bFlDRkNPL0x3Y3F1MitBYldqY0JpZ2dhOHNQWEVTQ3o2a0tOSFRuakta?=
 =?utf-8?B?NzlDVHIyWTZ2T2pFSlpYQkIxbm52MU1pcGdPWFBIbUFIRmFUYzFuRFM0UWxW?=
 =?utf-8?B?cUhYb1orcm1UNGhoaDVzVWdOaWlSR1YrZU1lRnFNR2FvTFNYMTgvM3pLeVpt?=
 =?utf-8?B?Y01VUkJXek1PUlJPYUV5cjlNZ0Ewdmw5dWZ0RldJSVpiWGJOeTJCOENtakl1?=
 =?utf-8?B?S0RUY3gxTnllaFZKK1VlbTBpRnpXVU1taVlHYkZHV3NaaklWaUltNFA1STdl?=
 =?utf-8?B?WERMWVp0dXdMNkpNam1nb0F3dGs1aHRtVENOWmJRUU1LanlieUZDY3liUW9x?=
 =?utf-8?B?eWdpUnNyZ3BZeGZkTjZWQXRTbUs5QnlmdUd4WnA4N2pnR0pORytGQlVweGJz?=
 =?utf-8?B?bExNMUNrRmNGaHFqaVM4MjBqOEFVK3F0K2tPbSt5bWhWR1pwSGV5ZUVnWVQz?=
 =?utf-8?B?RHdINFNnM3JKT1ZRbjFjREFvbTBVc0VlRUptc2tEallCd0VPQUg5d2ZIYlc5?=
 =?utf-8?B?c3I5UFJpMEF1UWJxNm5GekZ0dTBIMUM2aXRUZDh6MTkxczhWeFpHb3k5elVZ?=
 =?utf-8?B?c1huM1VMTUgyTnBrd21TQWVpWWFlNlJUMDdlRnRSaVFKOFk0Y09zZVpWNVNQ?=
 =?utf-8?B?RjlPbGJNZ3VTU2JVZ2xxTFVnYk9WU1NPaVU4cFhzeUQxOXgzWVVUbFF6QjZr?=
 =?utf-8?B?TUc3ZjdmOXhrT3NjVEN2Q3BEaUpTMCtBaUFiYVdFNnk1SEF5dzEwaGhSWTE1?=
 =?utf-8?B?aVd2bEdPQUxzb3BvTGxLNzJrUTZKamVrQlBtQ3c5dGpRN1haN0JQc25SZ0lT?=
 =?utf-8?B?QlU4b2pvRUdCNEtaQ0dKZkQ5VnRMbE1vbkwrYW8wK1UyUytxVTgyaDJXZGxY?=
 =?utf-8?B?WnNSYm5TZEp2aHkyUCs1d0dVcDBnNXFBalZnZktHcWRHMlhrNndiM3FxbDJM?=
 =?utf-8?B?UDIzc0lvZUVpQU40dmNVUlhlZGVZRkc1Wm5ibW1pYXhMZW9OVjJuVSsxdjQv?=
 =?utf-8?B?V2dTNnlkUEppdHJBTUtMVmMwd3lHay94VlRXSXROcDhFaVFSa2tmQmxibDRO?=
 =?utf-8?B?bG42WS9wS0I5dmIyV05lbkZLUnp0VHpvSnNUbFhqNHdON2hQOWpXTkhPR3dC?=
 =?utf-8?B?elhOMkEydndWY3Q4aUFMOVJKYllEbDBaTThISFZKT1UyakNCSzg3OUNwNVZr?=
 =?utf-8?B?dzNTSEU0WUM2L3pZRTI3dnRyM1RxNGNOYmEyNndETW5SMGwwYmhyblJIUElz?=
 =?utf-8?B?SXA0RStkOUo2SDF0UWk5bHRIaURrK250eGNScnhPWnVDZFZWa1VqcVZ0LzB4?=
 =?utf-8?B?MThxOVNlckpFSmM1VnNtem4zSkV1dTYxUmdWcXpMVTB2dnJyUHNyOTh2bWNl?=
 =?utf-8?B?VGgwMGNaemc1RXhEb0ZndlQ4VXY3TU53emcwVDNFK1RPckVTQVRMRWZUS052?=
 =?utf-8?B?ZXRlNGpDV1FzbE5LNTdZVzNMK0tJazVDMVh0ZGlpeFFQeTZ1Q2VrUTFFMi9D?=
 =?utf-8?B?UFdSQU1id2ZKY2E0VDB3RnJ5SE9ubVVIS2N1ak9nUXlkOFp0NFIwUlBKdUVP?=
 =?utf-8?B?Tk84VDlKZzcrRy9kUjFZZWhwSUU0UWtoWEZwMTlheDBjczJrdjFyaDZWL3JX?=
 =?utf-8?B?eFRLRzFoNTdJRkk5ZjNKVFgwb0s1dU1YMzBZQ2h2NWhwMlkvTWoreE82Tjdo?=
 =?utf-8?B?eTQzNmhDdFI3U3JMK0UzTm01T3U2WmZLQzlzcnZRYmZ6ODdJUjNRRzNUcjJ4?=
 =?utf-8?B?bnNmWDd0K1RHelZibXM3Wks1VDl2b3lHYjlyUC9rcWRoRnExVWl5VW5aMUdK?=
 =?utf-8?B?SzlCRU5ONjdaMG9yZ3RIeUxPbWw2ZFdrdDJrcnovSEpnQkNKaVpTVGZtTFJs?=
 =?utf-8?B?RVFKTEhETHFseDVvQ2Rob09YYURML2NZQXRSRlZ3TzB5WnpNVWQydWZYZTRM?=
 =?utf-8?B?R3ZCVzRUZXNsaEVhVVVDY1p6OGUvTmJqNkpOdWUrZGdHb3pwdkVZUDhYUndY?=
 =?utf-8?B?R3BMZFB3RFFGdkxSWDlFSnY3T1Y5RXJvdWU1cG8yTUlaWGpvSUdaYXQ1Wlg0?=
 =?utf-8?B?U3J1c3BYVTBmM0djeUxRbFZDMXIyd2hIMmc3Z2drSUNQWVdEL3gwVGV1MUJv?=
 =?utf-8?Q?hlZUk7rmJ39J3KvJc9t0Fqq3N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3abd79-ccd2-4f40-fa7b-08dd5acf7bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 03:48:53.6490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+oQ5sWI3FCn1cmCyuAdP9bQ2Ey4b4+uhyprkr6G3NR/CPfr8QQngB7qbUIF/SWX0/XWXTaj/mWs3kEkx2gwmEyuqVIBCZrBzALWRoBx19g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6764
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjEvMjNdIHRlc3RzL2Z1bmN0
aW9uYWwvYXNwZWVkOiBVcGRhdGUgdGVzdCBBU1BFRUQNCj4gU0RLIHYwOS4wNQ0KPiANCj4gTWF5
IGJlIGFkZCBhIGxpdHRsZSBjb21tZW50IGFib3V0IHRoZSBuZXcgYXN0MjcwMC1hMC1kZWZhdWx0
IE9wZW5CTUMNCj4gYnVpbGQgaW4gdjA5LjA1Lg0KPiANClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0
aW9uIGFuZCByZXZpZXcuDQpJIHdpbGwgYWRkIHRoZSBmb2xsb3dpbmcgY29tbWVudHMgaW4gY29t
bWl0IGxvZy4NCkphbWluDQoNCkluIEFTUEVFRCBTREsgdjA5LjA1LCB0aGUgbmFtaW5nIGNvbnZl
bnRpb24gZm9yIHByZS1idWlsdCBpbWFnZXMgaGFzIGJlZW4NCnVwZGF0ZWQuIFRoZSBwcmUtYnVp
bHQgaW1hZ2UgZm9yIEFTVDI3MDAgQTAgaGFzIGJlZW4gcmVuYW1lZCB0bw0KYXN0MjcwMC1hMC1k
ZWZhdWx0LCB3aGlsZSBhc3QyNzAwLWRlZmF1bHQgaXMgbm93IHVzZWQgZm9yIEFTVDI3MDAgQTEu
DQoNCj4gT24gMy8zLzI1IDEwOjU0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gU2lnbmVkLW9mZi1i
eTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IA0KPiANCj4gUmV2aWV3
ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEMuDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9h
YXJjaDY0X2FzcGVlZC5weSB8IDEyICsrKysrKy0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90
ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gPiBiL3Rlc3RzL2Z1bmN0
aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weQ0KPiA+IGluZGV4IDA3YjBjN2MxZmQuLjhkZjZh
OTdhMjggMTAwNzU1DQo+ID4gLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNw
ZWVkLnB5DQo+ID4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5
DQo+ID4gQEAgLTI3LDkgKzI3LDkgQEAgZGVmIGRvX3Rlc3RfYWFyY2g2NF9hc3BlZWRfc2RrX3N0
YXJ0KHNlbGYsIGltYWdlKToNCj4gPiAgICAgICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJu
KHNlbGYsICcjIyBMb2FkaW5nIGtlcm5lbCBmcm9tIEZJVA0KPiBJbWFnZScpDQo+ID4gICAgICAg
ICAgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCAnU3RhcnRpbmcga2VybmVsIC4uLicp
DQo+ID4NCj4gPiAtICAgIEFTU0VUX1NES19WOTAzX0FTVDI3MDAgPSBBc3NldCgNCj4gPiAtDQo+
ICdodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9kb3du
bG9hZC92MDkuMDMvYXN0DQo+IDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neicsDQo+ID4gLQ0KPiAn
OTEyMjVmNTBkMjU1ZTI5MDViYThkOGUwYzgwYjcxYjlkMTU3YzM2MDk3NzBjN2E3NDBjZDc4NjM3
MGQ4NWE3NycNCj4gKQ0KPiA+ICsgICAgQVNTRVRfU0RLX1Y5MDVfQVNUMjcwMCA9IEFzc2V0KA0K
PiA+ICsNCj4gJ2h0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVh
c2VzL2Rvd25sb2FkL3YwOS4wNS9hc3QNCj4gMjcwMC1hMC1kZWZhdWx0LW9ibWMudGFyLmd6JywN
Cj4gPiArDQo+ID4gKw0KPiAnY2ZiYmQxY2NlNzJmMmEzYjczYjkwODBjNDFlZWNkYWRlYmI3MDc3
ZmJhNGY3ODA2ZDcyYWM5OWYzZTg0Yjc0YScpDQo+ID4NCj4gPiAgICAgICBkZWYgc3RhcnRfYXN0
MjcwMF90ZXN0KHNlbGYsIG5hbWUpOg0KPiA+ICAgICAgICAgICBudW1fY3B1ID0gNA0KPiA+IEBA
IC04OSwxMSArODksMTEgQEAgZGVmIHN0YXJ0X2FzdDI3MDBfdGVzdChzZWxmLCBuYW1lKToNCj4g
PiAgICAgICAgICAgZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsDQo+ID4g
ICAgICAgICAgICAgICAnY2F0DQo+ID4gL3N5cy9idXMvaTJjL2RldmljZXMvMS0wMDRkL2h3bW9u
L2h3bW9uKi90ZW1wMV9pbnB1dCcsICcxODAwMCcpDQo+ID4NCj4gPiAtICAgIGRlZiB0ZXN0X2Fh
cmNoNjRfYXN0MjcwMF9ldmJfc2RrX3YwOV8wMyhzZWxmKToNCj4gPiArICAgIGRlZiB0ZXN0X2Fh
cmNoNjRfYXN0MjcwMF9ldmJfc2RrX3YwOV8wNShzZWxmKToNCj4gPiAgICAgICAgICAgc2VsZi5z
ZXRfbWFjaGluZSgnYXN0MjcwMC1ldmInKQ0KPiA+DQo+ID4gLSAgICAgICAgc2VsZi5hcmNoaXZl
X2V4dHJhY3Qoc2VsZi5BU1NFVF9TREtfVjkwM19BU1QyNzAwKQ0KPiA+IC0gICAgICAgIHNlbGYu
c3RhcnRfYXN0MjcwMF90ZXN0KCdhc3QyNzAwLWRlZmF1bHQnKQ0KPiA+ICsgICAgICAgIHNlbGYu
YXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfU0RLX1Y5MDVfQVNUMjcwMCkNCj4gPiArICAgICAg
ICBzZWxmLnN0YXJ0X2FzdDI3MDBfdGVzdCgnYXN0MjcwMC1hMC1kZWZhdWx0JykNCj4gPg0KPiA+
DQo+ID4gICBpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOg0KDQo=

