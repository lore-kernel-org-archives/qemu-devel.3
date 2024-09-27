Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E96CEBF6B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 02:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su0Ya-0008Sy-0e; Thu, 26 Sep 2024 22:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su0YY-0008Mb-Ds; Thu, 26 Sep 2024 22:18:06 -0400
Received: from mail-sgaapc01on20712.outbound.protection.outlook.com
 ([2a01:111:f400:feab::712]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su0YW-0007og-Po; Thu, 26 Sep 2024 22:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3BHlpiwj7xqWcpnOEETYPF9qJnlDtJwT2J4sIqJlr9F1hn+IBXj9CkXjjuSlLyHhnlfWS+Bukgh5cPZ7Xpc88mZNdmbV45ByHpgfMdgtoaVSR8XdchHaq4mvZ/e3bHWes+2wqm7Q/Qc6cOmwwQ5YuAVdL4qLF/dDTjjnXPcX3h2sNMOtKs0g0+gp0+0MMNPbWnTHuF2M03JQ46kGpei4Fc6tKVm/td++aMVe3AeT150SSEtU6Ep78gCBnTqmhPRfEuKVY6OyAHok0cM/Cbfrw6ghS0w8rU6+phqIh07aa/sk3k0yxdfhr2boj4AIxB2Y5hZn8rpY9oyWOPg128CCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7SG04p0lJmcJbRMjM2ia5Bx6tPjCFsVtGsbfeMcF/I=;
 b=sQjyuLMThjGatDfDVbCMbCcQ2H+2jl69VWlOwvQ5ENtDm0WdbKWjBRWygImTXOnuX1+ULrONo8hdT2V8I1aNhn/vUO+KCx+WSleOCTZQ1F7iCPDeqaoFQe9f9iZMlYkaefEXZmVNmgIl83x48ibv2Zb0huNsvdPG3L+xB+5eB/ArvKRKDwPXeBmpaV23BtqBEHpW8HszFSfklbCuqk1iME9hyMPzD1C1SxKJ2AK4AjaFJwKII5jj2hxCBTTo2LvL1XvKk1z9rFCAR4BNS8oJnrV+X46bYFSflAHTOGkYFFsO6Xx2R7/0kVfTRwl9qfeNk9paVywX/UtEWhdEmgVSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7SG04p0lJmcJbRMjM2ia5Bx6tPjCFsVtGsbfeMcF/I=;
 b=nBt3c11hOeO8hEiKgjt9R3Gx4713dIYaTtBf0tIcjN/FnEvFvb6h+eLiNgknQGciN8sGO6nOX8eDF7V1sNQG8jjHKgNbvULdXFjDDGk3SvJ/Dy5hwt9T6wdiX1tODpJHguS+ay90aYYJ002iUWt7H0OqjaTU7TePPv3j3VO+cdl3lgArbZYTDaBhPvXLe9uYx08CfV5h45Ofu+igk0TIMroV3DJ5z7fAE5wrLtEGQ95cmGCPUUamx7kg8oUUcQsR6a1CNmhP6TG9pi35QnaDXao6IfhjO8TsS9V4/joy9n+GXE9g64iqGi2p8R20wS5h79UpuzvXzhHY6BHfPeSTsA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6437.apcprd06.prod.outlook.com (2603:1096:990:2d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.29; Fri, 27 Sep 2024 02:17:56 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Fri, 27 Sep 2024
 02:17:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 6/6] aspeed/soc: Support GPIO for AST2700
Thread-Topic: [PATCH v3 6/6] aspeed/soc: Support GPIO for AST2700
Thread-Index: AQHbD+gadY6tSqj0y0+12GFmBuF0EbJqPX2AgACpS1A=
Date: Fri, 27 Sep 2024 02:17:56 +0000
Message-ID: <SI2PR06MB5041CBAFA2DD44D18A4DFB76FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <20240926074535.1286209-7-jamin_lin@aspeedtech.com>
 <6aea4f4b-2446-43c0-acb9-0f0df000f3b4@kaod.org>
In-Reply-To: <6aea4f4b-2446-43c0-acb9-0f0df000f3b4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6437:EE_
x-ms-office365-filtering-correlation-id: 681448ae-3d61-4aaf-80de-08dcde9a99d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eUN2K1Ewa0lvTkF4bUZud3F6WkU5SDVkOGhkK0E4b0JhNFd6NHBPWllLWjBU?=
 =?utf-8?B?OTZzYllwUnhjUWZacDkrYUJOekMxVkphcU1Kd0haeU40YVNWcXdVbGRkTEYx?=
 =?utf-8?B?MUc1NzE1R0FzUlZnak9iTkdwNzFlZVl2RjRqdFE0U3Z1TVVObDB3U0lXNmE4?=
 =?utf-8?B?QlcyV1djaEwrd1kxYXNocjAyMlVyd0VXL09RMGRaYVJLUUNscWVwTGVuazRm?=
 =?utf-8?B?OTVXZ0NtNnR0eGU5blMrZEtRa243NDRHYXN4emUxZXhBajVacmdRMlZ4cHZR?=
 =?utf-8?B?WHRyTkdEOERNejdjbkpDNWxVYkNocjlLWWplWlV0TzQ1alNLVFVtcTJkcXBl?=
 =?utf-8?B?ckNMSSsxOUFpdXA0WDVlWEZtTmcyeDc5YVdEVnNrL1J1RWs2cXByOEhQUDFW?=
 =?utf-8?B?bmQzdkh0SmRjZXB4SzNGZTNlWmNHZW1OK2luSklZRGFYdFpWM1JKaFRoZDFw?=
 =?utf-8?B?TU93aTJuVWNVOHhpNXppZVg1S3lOWG05blY4eDhPQ1EzK01lM2FWbDZGeEtX?=
 =?utf-8?B?Y3FGbTlzdys1YnFwU2VvcmR3Yjd5R3hidkROL3hBb0FVRTNzRGVsR01DZVZp?=
 =?utf-8?B?RDF4Z0grTm9zNjE0TDJCcSt5aDVCZmQ0bzMrYXlFVVJYTW8xNFhiRGJWVCtT?=
 =?utf-8?B?L0dZM1JXVm1jN3czQW5GUGlkdU0vdCtwdUY2N1h5UmtiSTlNWlFYUGt3cnpR?=
 =?utf-8?B?VFZzc29ySnBWYWtSY1NuZHh3YVUvNCtKMkppMlZTRE5ITi9LWjlEU0JYaHQ5?=
 =?utf-8?B?NCt3NlpJRmtrYittODNXYU80eC80V00zOURSckpJZWdmVHozNUcwSnFzNkpG?=
 =?utf-8?B?NFJhT3hvdC9qS0lBajhxdys4YlA1bHM5cWVnb0lrczBLSTRVanpQdWRicSt4?=
 =?utf-8?B?SUhTK3k5dTgxYVJZZFEvdUdYQkdjbERoS29ZdTZMSTZwZXFNck5DT0NSUEll?=
 =?utf-8?B?MDlYRHRGY2p0ZWZGKys3TVhHSzFWRHpwMGlHdnBaRmd1ZHhaUWptK3ZHZDhO?=
 =?utf-8?B?ZTR6bHJWd0J4cW1KUER2MXQ0STJjNHNyQjVMMFhoMHNOYWxaYWdOblpGbGxY?=
 =?utf-8?B?cklwV0VhNTNwUy8xelpadW9RS2x6TTFuSi9kdGJvekhFMUxZSjJ1aVVFVU9a?=
 =?utf-8?B?VzFWOG1mNVZ4ZFpnYThmK29PcHg1T2d0am5hNm04NzZHWUJoaUVoMUFxN3Nz?=
 =?utf-8?B?L0ttQXEvN0p5cWpHdjArVFM2aGgrcE04SXhiZUVmNTBWSU9vWlYyajhQVWtx?=
 =?utf-8?B?aVJnQXFGaGwybjREcVU2NVVFeHVnb0hZLzVYaE42bEtQV2k1YWI5V3ptbzA3?=
 =?utf-8?B?SGZhMnFXNFI4RGNYWkxsZzA2dkhoRk1oaDlEcUJCYmIybDZTWFoyUS9vTGg5?=
 =?utf-8?B?YytYZ2dISDZGQko0aFh5WnVYOWZ0SVd0cWtIWFBzcjZYY1FGMCtOY05oU1ZO?=
 =?utf-8?B?YUtseVdOK2pYZUVxOWJoTndnWW4zVTRWYk83dDhsdFRMb0hyTUw5RE5JeFho?=
 =?utf-8?B?NjU0S1BYTWV3dDhyRlhPcXpKRWs5aTU3bkJPRG1LWnVaTGJidGl0MGhOL0lz?=
 =?utf-8?B?UnMxNEZFK25XNmFDc0wvR01GRFBIQXFMMk5YWHJpTTVKamNKcGE3N0ZUZVE0?=
 =?utf-8?B?Z1FieGxPaFFvdWtRT1dSdnF1N3liV0JudWdQREM4eTM0bWN2bnRIY0pmT2Y5?=
 =?utf-8?B?Unorcy9pNEhvYjZrZEhtbkpWdnhjNzdTMHBEbHBocXRaMFRpQU5QeFdTdDZt?=
 =?utf-8?B?VG9OZ3U3empVUm45ak1vNVJuVHhYNVZYL2NVSTdxbno4T042eDhRU2twdTV4?=
 =?utf-8?B?MFlCNGUvZnMwUmFlZUpXUVc0bG94N2YveHdsUzlQUFh6UW1Wc0pSM2Izdncr?=
 =?utf-8?B?SE1kRW8wcUxYbmFSZWp2Q2RRSit1TjVEbmZaTW11eG9rdkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NS9QZ3lWb0JBNzY0TXRqbk5mUkswM0RTRytZanV4cnRMNW9zZVh3b0M5djNN?=
 =?utf-8?B?SGRpTFhnTmRRM0JXbWVkRXdMMFVXZFRXbXd0RUVRUU9oZ1BRc0NnV2tDRXFr?=
 =?utf-8?B?VzdyNkhiYTV0ZmJwVnk2aWZIbXpHTFhYejhqRTA4RzhPQUF2SG5EOGlidWhF?=
 =?utf-8?B?bFRRVnBNZXVvamc0bE5vYnJYUWZLUE5vMSt3WWh6T3ZFdnBxZHNkSWRrWFVP?=
 =?utf-8?B?WHhBY3BSYk5iQmk2Mm5EQWQ1ckNPd0ZTR0toWnYrUW1tYk1ZWVdld3JMTE1K?=
 =?utf-8?B?RHl3Q0lvUHZ2OVpteS9DSkZOclRzekNDK1NQZzNiUkpTZDlvdTFLenhzeTM4?=
 =?utf-8?B?a2JVZ25ISDZBMFgwd1EzeUNGaTJxaTR6MkF0WW5aK2FKTGZhNEljOCtVMHVu?=
 =?utf-8?B?UlJScDBzS3lXbVBueDUzR21WOGdwRk9KNnNqNXdydldkZWViTVFBOHlNMmhu?=
 =?utf-8?B?Q0NBK0tUTnBWc3p3YXVDckJ4elluQ0xnUVZ0b2ZONEFFT0FGK1VjSGV6bmRV?=
 =?utf-8?B?OUdMZi9FcC84LzhuY1NDczZNZXdlRk1nV01XZHRnQVdIZm00SjI2YXhaN0dx?=
 =?utf-8?B?YnZFZHBkZ2U1M3BRWGZYL3RZQy9RMUluWnBzUjZneCtUaDFJditJaC9ENUN0?=
 =?utf-8?B?djFiMXB5dGNZTmpaTzNDY01rR1pDUm5nODF2WE9UdHlLOGJ4SFRsckVsSUhY?=
 =?utf-8?B?QXp2SGpqMEQyY2tTdjhnNjRXTVpmZDRoMU5naDE0UW5ucmoxZCtKZDl5SmJG?=
 =?utf-8?B?aEh3RG44RlRoZGF3K1Q1d3RVWHcxMjQ0Ti9SLzkraFNDZFZNZndjdTFzOE0w?=
 =?utf-8?B?cWpSSVhzZHNCcGxGeERidmhoTGJ4N1BlUFp4Szc0RXpkZGdCdWsxYkF4UEMw?=
 =?utf-8?B?NjRWanlPbHI2ZzE3M2NqY0ZFSmJPWWVia25jOUdwOGRWZVRQY2J1dlhWemFG?=
 =?utf-8?B?anhWZUdlZWtGYkRFVXJoOVFVSm5Mb2c0cVJzeFFGY05tVHNhYVJxakJaY1Rz?=
 =?utf-8?B?bVZDSzdBQmJyS3I1M3p1eml2bG85aXIrRmI1cVZTTjV5YXdyZldQTjc4clJD?=
 =?utf-8?B?QXdDc1piYndmSUQ1dC9QWWg0ZVRjSzhtMzg3eFZFbjhXRzNRS3NhaGM4UGZl?=
 =?utf-8?B?UGVMRkhaVFZ0R2JrdCtJejdHbmxReGdsd2NudStlTnRYK3psUklDWXRiaDZs?=
 =?utf-8?B?UFBveC9qamIzQWd5dEY3Sk82alVRdnZXalU3NHFOMXdwQjh3K3RrWkpCWFoy?=
 =?utf-8?B?bWg3L2JLS1hLVDBjRE1qS2ZaVnFuUDMwQmszbk1tOGlFWHo0Zis2Q2NHbkRE?=
 =?utf-8?B?TDd2SlorK2ZrYjlvQ0h3ckFIemtid2FlQjR5QnNRSU9kYXFyUVA4cWQvc3Nv?=
 =?utf-8?B?NEh6WnNzSkZnTUtaZjQwbTB5ekdTYXdYNVRrcm5STktNc1JlTngraTJFbVNu?=
 =?utf-8?B?VTBTSlFFNXBvL3hpRUN4NTIwTzdpNFZvbmFMOHVkTEFVNG1nR1VJc2JlY015?=
 =?utf-8?B?N3YzZVRUeW94Q0NDeVlVZlNOYkpHaDJ0ZmpIa2tiWURXTWpWWXNnbUY4RlU4?=
 =?utf-8?B?dEZsUEw5Qk5ndFhERllRRnVGNFVvYS9JMVNvYmgwb1I5VzRxcGNTcnQ5TXFV?=
 =?utf-8?B?MXVZcytDcjBxOU9oMXBjS2RHL2p0cm5iVkhpbTRCTVdWMHBhNUY1NnlnbzZE?=
 =?utf-8?B?R0x4WFFxeVFwVDF3RVowSStRanFTSHh0VnpiVFBqaUt1ZlNOZXdmbVVTOGhG?=
 =?utf-8?B?L0hOelV3dFhTZ25mZEJBZloyc1dnZEZBUksyZ3dmWnVNK0hkQmtBUkF0ZU5G?=
 =?utf-8?B?VFRTSG1MUGt0ZExNa1N3R1FZVW12ZVpoMjQwcmlZa2ZVS05Pait4SGJRUzVt?=
 =?utf-8?B?cGVqd1AzL0J0U1ZjWklqaTJ4RVM2aHBYblFVdEpSMDZCM1d3VS9tUUNDeXVX?=
 =?utf-8?B?TWxkUkRYL1FOclZRenprdW80SStZbURnSVFwQW5ubGJuU3lmT09GTlVDR2R4?=
 =?utf-8?B?L3pEdDZSTzVEd0M5TTdCT2NwU2tiVzgrUW04a1JsLzVxd3djNFRSZ2dSSkVW?=
 =?utf-8?B?bXhuZUZNYWNTNmxLZGJkYXBmUlZ1NFhVQXBxRTR0RHczNDRmSjVxb3FNdEdT?=
 =?utf-8?Q?9tnNCW84ECTVSK4AVPBm0/cKN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681448ae-3d61-4aaf-80de-08dcde9a99d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 02:17:56.7015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyhZjzUseX1TKQHUzpa0AptpydCj2qHx//X7Oa/gpDsWp/h7duK+CYpwRsP1ehXbD9HBf2SS7jadJ3c8KA187bhGmaNmRNLOwO/EL/MAjlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6437
Received-SPF: pass client-ip=2a01:111:f400:feab::712;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNi82XSBhc3BlZWQvc29jOiBT
dXBwb3J0IEdQSU8gZm9yIEFTVDI3MDANCj4gDQo+IE9uIDkvMjYvMjQgMDk6NDUsIEphbWluIExp
biB3cm90ZToNCj4gPiBBZGQgR1BJTyBtb2RlbCBmb3IgQVNUMjcwMCBHUElPIHN1cHBvcnQuDQo+
ID4gVGhlIEdQSU8gY29udHJvbGxlciByZWdpc3RlcnMgYmFzZSBhZGRyZXNzIGlzIHN0YXJ0IGF0
DQo+ID4gMHgxNEMwX0IwMDAgYW5kIGl0cyBhZGRyZXNzIHNwYWNlIGlzIDB4MTAwMC4NCj4gPg0K
PiA+IFRoZSBBU1QyNzAwIEdQSU8gY29udHJvbGxlciBpbnRlcnJ1cHQgaXMgY29ubmVjdGVkIHRv
IEdJQ0lOVDEzMF9JTlRDDQo+ID4gYXQgYml0IDE4Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tPiAgIGh3L2FybS9h
c3BlZWRfYXN0Mjd4MC5jIHwgMTggKysrKysrKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGlu
ZGV4DQo+ID4gNzYxZWUxMTY1Ny4uZGNhNjYwZWI2YiAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0v
YXNwZWVkX2FzdDI3eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4g
QEAgLTYyLDYgKzYyLDcgQEAgc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI3MDBf
bWVtbWFwW10gPQ0KPiB7DQo+ID4gICAgICAgW0FTUEVFRF9HSUNfUkVESVNUXSAgICA9ICAweDEy
MjgwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0FEQ10gICAgICAgPSAgMHgxNEMwMDAwMCwN
Cj4gPiAgICAgICBbQVNQRUVEX0RFVl9JMkNdICAgICAgID0gIDB4MTRDMEYwMDAsDQo+ID4gKyAg
ICBbQVNQRUVEX0RFVl9HUElPXSAgICAgID0gIDB4MTRDMEIwMDAsDQo+ID4gICB9Ow0KPiA+DQo+
ID4gICAjZGVmaW5lIEFTVDI3MDBfTUFYX0lSUSAyODgNCj4gPiBAQCAtODcsOCArODgsNyBAQCBz
dGF0aWMgY29uc3QgaW50IGFzcGVlZF9zb2NfYXN0MjcwMF9pcnFtYXBbXSA9IHsNCj4gPiAgICAg
ICBbQVNQRUVEX0RFVl9BRENdICAgICAgID0gMTMwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX1hE
TUFdICAgICAgPSA1LA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0VNTUNdICAgICAgPSAxNSwNCj4g
PiAtICAgIFtBU1BFRURfREVWX0dQSU9dICAgICAgPSAxMSwNCj4gPiAtICAgIFtBU1BFRURfREVW
X0dQSU9fMV84Vl0gPSAxMzAsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9HUElPXSAgICAgID0gMTMw
LA0KPiANCj4gVGhpcyBjaGFuZ2UgbmVlZHMgc29tZSBleHBsYW5hdGlvbiBhbmQgYSBGaXhlcyB0
YWcuDQo+IA0KVGhhbmtzIGZvciBzdWdnZXN0aW9uIGFuZCByZXZpZXcuDQpJIHdpbGwgYWRkIG1v
cmUgY29tbWVudHMgaW4gY29tbWl0IGxvZy4NCg0KSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBD
Lg0KPiANCj4gDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfUlRDXSAgICAgICA9IDEzLA0KPiA+ICAg
ICAgIFtBU1BFRURfREVWX1RJTUVSMV0gICAgPSAxNiwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9U
SU1FUjJdICAgID0gMTcsDQo+ID4gQEAgLTEyNCw3ICsxMjQsNyBAQCBzdGF0aWMgY29uc3QgaW50
DQo+IGFzcGVlZF9zb2NfYXN0MjcwMF9naWMxMjhfaW50Y21hcFtdID0gew0KPiA+ICAgc3RhdGlj
IGNvbnN0IGludCBhc3BlZWRfc29jX2FzdDI3MDBfZ2ljMTMwX2ludGNtYXBbXSA9IHsNCj4gPiAg
ICAgICBbQVNQRUVEX0RFVl9JMkNdICAgICAgICA9IDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZf
QURDXSAgICAgICAgPSAxNiwNCj4gPiAtICAgIFtBU1BFRURfREVWX0dQSU9fMV84Vl0gID0gMTgs
DQo+ID4gKyAgICBbQVNQRUVEX0RFVl9HUElPXSAgICAgICA9IDE4LA0KPiA+ICAgfTsNCj4gPg0K
PiA+ICAgLyogR0lDSU5UIDEzMSAqLw0KPiA+IEBAIC0zNzMsNiArMzczLDkgQEAgc3RhdGljIHZv
aWQgYXNwZWVkX3NvY19hc3QyNzAwX2luaXQoT2JqZWN0ICpvYmopDQo+ID4NCj4gPiAgICAgICBz
bnByaW50Zih0eXBlbmFtZSwgc2l6ZW9mKHR5cGVuYW1lKSwgImFzcGVlZC5pMmMtJXMiLCBzb2Nu
YW1lKTsNCj4gPiAgICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJpMmMiLCAmcy0+
aTJjLCB0eXBlbmFtZSk7DQo+ID4gKw0KPiA+ICsgICAgc25wcmludGYodHlwZW5hbWUsIHNpemVv
Zih0eXBlbmFtZSksICJhc3BlZWQuZ3Bpby0lcyIsIHNvY25hbWUpOw0KPiA+ICsgICAgb2JqZWN0
X2luaXRpYWxpemVfY2hpbGQob2JqLCAiZ3BpbyIsICZzLT5ncGlvLCB0eXBlbmFtZSk7DQo+ID4g
ICB9DQo+ID4NCj4gPiAgIC8qDQo+ID4gQEAgLTY1OCw2ICs2NjEsMTUgQEAgc3RhdGljIHZvaWQN
Cj4gYXNwZWVkX3NvY19hc3QyNzAwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKipl
cnJwKQ0KPiA+ICAgICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJQ0UoJnMt
PmkyYy5idXNzZXNbaV0pLCAwLCBpcnEpOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgLyog
R1BJTyAqLw0KPiA+ICsgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+
Z3BpbyksIGVycnApKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsg
ICAgYXNwZWVkX21taW9fbWFwKHMsIFNZU19CVVNfREVWSUNFKCZzLT5ncGlvKSwgMCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICBzYy0+bWVtbWFwW0FTUEVFRF9ERVZfR1BJT10pOw0KPiA+ICsg
ICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNfREVWSUNFKCZzLT5ncGlvKSwgMCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBhc3BlZWRfc29jX2dldF9pcnEocywgQVNQRUVEX0RFVl9H
UElPKSk7DQo+ID4gKw0KPiA+ICAgICAgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgiYXN0
MjcwMC5kcG1jdSIsIDB4MTEwMDAwMDAsDQo+IDB4NDAwMDApOw0KPiA+ICAgICAgIGNyZWF0ZV91
bmltcGxlbWVudGVkX2RldmljZSgiYXN0MjcwMC5pb21lbTAiLCAweDEyMDAwMDAwLA0KPiAweDAx
MDAwMDAwKTsNCj4gPiAgICAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoImFzdDI3MDAu
aW9tZW0xIiwgMHgxNDAwMDAwMCwNCj4gPiAweDAxMDAwMDAwKTsNCg0K

