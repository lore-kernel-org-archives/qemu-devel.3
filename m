Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C17C282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 02:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpIRq-0003SR-Ik; Mon, 03 Mar 2025 21:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpIRc-0003Rb-Jn; Mon, 03 Mar 2025 21:55:47 -0500
Received: from mail-psaapc01on20724.outbound.protection.outlook.com
 ([2a01:111:f403:200e::724]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpIRX-000133-H7; Mon, 03 Mar 2025 21:55:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ppagru6rorDd1QZG8CQ3CtkfvmFeTXEeHh0JXI2y+EPcpEZPuJ5WVf0AqaCDn85gDfLq9sg8obfKN+vzl24ze1TJm/qjv6scuF0kcxO1Uf1lGdnBhNNsIOWTTUSZuesrttS2/cnuZgO1VkAzNof45hO/xEAHhH2JBPUyQYl921uVWVDqVjn3UJhEV8CSA/F28PIv8XD97duoQmR+EpOUfef54pW8XiaP37fq31KL6fHHp3DD6fgdtEoPgTjbwdF1StzgPaGoZhFjoQF8q/CtpSD+K9XodRO07mtnxkXyxwOnZArb0aX0wB1Ifr1gcOJWBBJbOB4zpjC+07SZNopMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YohaogvhHLLBAdQtGQ6G6kfUfZq7SPjQQi6wmWdRCG0=;
 b=TVdY7GJwDl1bnGPz/O59hsP+YA99KcLB0WtJ/UOXLKmq3XZNBlN1MB9B+WfERzqCnuRUn++JmZH1JxfwtBACmxcomiiSBuxPcwgl05AE4T7pdoRJve764FMba/upCCsvtfkFfwSGztvad83t2Isp1ZaFMc0dL9pFAGqt2JRdr5pBQsdB3b3z4uaAw/meuAiiY9O2oG2Qkt1WQl6KeeNkOZaoy74aCmsEcsY2lwkZ7DDVIuV/bh8diwB3+gXkpxvfiTSbdJIlGkYMxJEWqw8dihw+u5QUbPCkscreznEGa11yGxc8LIDN/pT5a8BoTRbI47/y+qVJt5tf6MIK96YOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YohaogvhHLLBAdQtGQ6G6kfUfZq7SPjQQi6wmWdRCG0=;
 b=lXNJ+lPw/wtCECNxmEPFylUpo4cfTXfs1yfgaxOwfmABmh0cDsA78ntrORHWVHP4k2X1fDbm3dD6M84xMKZYQWcOAMj4ALEm3pMlcxLXyeGuMqrJfq2zbOSmqSjJlIzwNTUkhuPZdTLvXgmb85to9c089ra4FlwSi73VxvzcBeszPmnSIytlPu0B5iCjWmSmzgmCltntc4Azbpt2rHVB4txpn7UelNmY7xqQhm0wCNi3VoU+9TUcI9N6/wG9lgMqL+a4bD5B3EUzoFcMU9Q2OUd4hap7tjrg0SkXGE7YWMUSPihBxkdNC5xHJ300ACil4IfX4pRtfvIuhkYDGzF5xg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 OSQPR06MB7181.apcprd06.prod.outlook.com (2603:1096:604:291::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.26; Tue, 4 Mar 2025 02:55:25 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:55:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 06/23] hw/arm/aspeed: Rename IRQ table and machine name
 for AST2700 A0
Thread-Topic: [PATCH v4 06/23] hw/arm/aspeed: Rename IRQ table and machine
 name for AST2700 A0
Thread-Index: AQHbjCJZ+mP+Pkm0qECMECR12iafOLNhd2kAgADR7+A=
Date: Tue, 4 Mar 2025 02:55:25 +0000
Message-ID: <SI2PR06MB50413CA57C3F1184178EE348FCC82@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-7-jamin_lin@aspeedtech.com>
 <ee616fe5-280d-4afa-84db-9896b39fcb7a@kaod.org>
In-Reply-To: <ee616fe5-280d-4afa-84db-9896b39fcb7a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|OSQPR06MB7181:EE_
x-ms-office365-filtering-correlation-id: c6454cab-6217-47db-b25c-08dd5ac80355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vnl6MEpHd0dnWkx3emFBYkVIRGpNMWwxSEdsVUpidkE3elJvbUNpSTBHOE1N?=
 =?utf-8?B?NFlPczltc1k2eCtvYXFuaE0zTzVNaC83a3F3d0doUG9hWGdURHRGV01va05Z?=
 =?utf-8?B?eVNwRDNHeGpMbndnRE9TK0dYelZ5dE0zbDJ2QWNRdHB4ZDh3TDJidzdNaWlF?=
 =?utf-8?B?aVRDZTJxS1NiUTZyVWVhT08xUGNJMHJXc2FobE5pdmtSN1kzcks2c2JKc2Vn?=
 =?utf-8?B?SE5QRExDM3ZXaG4yUExoMlFTajE0S1FJQ3hlTU50S29FbXhTN3EzREt0c2xT?=
 =?utf-8?B?anlqYU5KTFozUThMdGxJRGVodmFPRU9FaVJnZFB5eURPM3RtWURZclRBSTRz?=
 =?utf-8?B?YklMWXUrd3ZHQVVRQjBPTy9Yd0pjc2NJUENLd2srbW9jMXY1Y1RsQzZ3bm4z?=
 =?utf-8?B?VUZWTzdHbG9ITHNQbHJ1RHFhQW5KeEgxbi9EaDlpMzZSZXJZYmszTmNzQVVC?=
 =?utf-8?B?ZUY4NTdkTEg4Z0Qvd2dJcG15Tzd1eU5SVkREUTE4aXhTdUlLVXhNWkVIdU0r?=
 =?utf-8?B?NG9WWmlwc1ZnQVBpUFJocWk5aWxmM2lrbWtiZWpHbUNQcnNQVGxtRGNuL3Np?=
 =?utf-8?B?bHN1ODQ1dXBscDFJd3lwT2wxbHYvY0o0dXB6ZTltUmo4eXd4TUVyRE9GUDk1?=
 =?utf-8?B?bVZ6cXVIU2xLak1PSEVycG9NOWhHZzNsTXJCakJkaWpwVjI1TGZuQ05NVGFM?=
 =?utf-8?B?dWw4NXV1YnIvOWVrcXhPL1BQeFhyK3NBZUNtUDVMazVRZXBlaWNSc3hLekdS?=
 =?utf-8?B?STdVVVhCbzF3QWxxc0ROTnJNaDlKek83NVJQYTlkVWRwa3Ruem1yajgxU09Z?=
 =?utf-8?B?ck4xNjVWOXNIOGVDUDlMZnRRNVBURXVUb1FqYkxXSVUyRnAxU2dRTlVuQmRC?=
 =?utf-8?B?eDgxTDF6cVV1b2NlUzh4dFdVK3VjZkRFRHVIODRGWnJIN2cxc2RyMUVVaHpC?=
 =?utf-8?B?SDYxSjRFejZNMDVBUUw0ZUdqeEpHVGNoRlJCNWp6MTNkMzE1eHNYR3p0dGtw?=
 =?utf-8?B?YXc0YTZtREpISmJPZGtqWnovdHFpc2JpcDJ6OTM0cGRUb1RreStYcTBaY21t?=
 =?utf-8?B?Vmo2Unprd0pvN0V6VUlROXl0OVNzcjFSL2czRVlXVHNrODdpbEFjcVBGWGlx?=
 =?utf-8?B?cG5DSllGVExneldXNlR0YXAwa2xUdlVQOTJubmFrbGJraHhaZ1ZNVzdGWlEx?=
 =?utf-8?B?dU9xYk1ZWnFCcG0wLzFLbjMvREdsUDVtbU1LREMrUkJHclNzbWFCZWhuQnR5?=
 =?utf-8?B?bjF1RkQwaUVpRityTXdWNS9lYUVHbTBNWmxvdTllNUlJSklyMlBDRWN1a0R4?=
 =?utf-8?B?VHBhQUxBOGpwNk5xTkhzd2NUcmRjMkZxaEJ4NXZ1SVd0WEJPWW1lQW9BMkZv?=
 =?utf-8?B?MStKZWM0b1grUTloV0tQYjQ4T3M4b1BDamNURGhXeGtCWDRRbGlpYzFySGJR?=
 =?utf-8?B?aUR6bHBsbVlLem9yWGtBUTFCL0RMSFNzekNScEZTL1JRVi9tK3dNRmdUSFpH?=
 =?utf-8?B?NkxBd3NlK1NMdDllS2p4SWdFMHdUWllrZUVGZFk2Mk92QU0xdi9aYjd4NGNY?=
 =?utf-8?B?RlhIOExHY3RoSzhrR0RPNjMzRUFzRkRaSldJZEtIWEoyZlBLM0pjb2J6Q2tl?=
 =?utf-8?B?bE1zRVQ3VjJSN3VscVpaOXc2L0hRaGR6VFdMQnh0cTBielZPTU9sUkNwN3hw?=
 =?utf-8?B?MWZpZ1FscU8yY2x5bGZXODlCMVloMHg3Szc2bjl3U054NGRXaHVuamlncW5u?=
 =?utf-8?B?ZnM4OFZLMS90VVRyUkF6K0FYZ3dNdyt0V25JRlY2YThUWVNYOHluVE4rT210?=
 =?utf-8?B?aXR5NkpmQmw5bGVIdUkzZ2xUN0NNRWVadGdQQlJIY24vbkVXQVovRDM0eDJo?=
 =?utf-8?B?WVFZQWI2dzl1ZVF4TnZYNGEwRzFxb3phZFFIa0h4Q1hlM3k3QiswWlhXa1pO?=
 =?utf-8?Q?irckiv2nn/EqAYJsc9werSD5tOITstst?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGpIYk9GZmlxbkVSRjlmc1JiMGMrYUJuNWo3eHJibllJN1BBK3VjaC81QjBQ?=
 =?utf-8?B?cmVBU3pyV3k1Tk9JclJNWkpJOFIvT3p1aytaeCtidzByL29WalNqWlYvZXJ4?=
 =?utf-8?B?aU94RHJaWktCNEtvby9odTg5TlVXS1lRd3gwR2NpaDlMOUkxWUZ6NUhob3Z5?=
 =?utf-8?B?cXVLaUNCZHZZYTVIOVJGcHpLTWdUUTZYTmRrbHhsMk90Zlg0azFmUysvNFJo?=
 =?utf-8?B?aXRkU1lrTVFYSjFWdnFabjBmbkZLbDlBM2EzMkhqNENKcmVMemljbFBYU0RK?=
 =?utf-8?B?QU5kcUN2ZXpuazNLZ3hZL21zU25vL2hwRytnbTJQY3g2eTJ0Wk9tdnc4UUJy?=
 =?utf-8?B?Q1djZzAyQkNmRXUzbWhlL0VTeEdEbUxycG5MZnpBZVJmdHBoRW43OHhtdUtY?=
 =?utf-8?B?ZVB0b2o3VnNjZUd2dHdZbG0yMXlJeE1ZanU5N0ZZT1JlcDhHeURRVlNsVUll?=
 =?utf-8?B?ZExQbGtDTkx1MmN6dVdtdW9MYTRTOFpwRTBUZ1lSUHAxWXBkbGpUTmprQVRS?=
 =?utf-8?B?MEZqSWp3cFA1R25tL2dzUVZZU2xIaEp3WW52c1IyQjR0SFdVNFgvOVRoNGE5?=
 =?utf-8?B?OXlLNFRNNmVIdncyZ2ZNVVBZL2hydzNoTFU3MUhOUHdIK1pxRGpRd1BJcVJj?=
 =?utf-8?B?VGRkR1FKTmowTWgyeUdTWDNUeExlbFBhYXhSZ3V6b0dXSWNxeGhud3BrOWxC?=
 =?utf-8?B?a1g3ZWdtZE1nMVJXSS8xNXFxejBHbFpOY2JYbzhZbHhBMjNzaFlpYTFMckZp?=
 =?utf-8?B?MGt0RFdpajMrZWtSTG1JMnoydjNqYlVOK2Y2SlZ2cXkzR2pobGtaMFRlUGlO?=
 =?utf-8?B?aHBRZFFZa2Q0NlVnOUZkZnBCMUxsM0JTd3E1SnFSRk1hQWJZQmlLaG0wUDc1?=
 =?utf-8?B?NE43czYzWmVQc2ZSV1d3UENTVkhSVkErYjFDTUkwWmZrY0hCY2d6Tkc3OFVy?=
 =?utf-8?B?YWdsY3dhakZaSjJWM0g1OW80VU9YR0pFdEJzYmhUZEZGRURnQUk1UDl5WkpZ?=
 =?utf-8?B?UDMyRjNNR3VxRHJVUHVZYnowSXplS3Z2Y3hpN2graS8xNDRhNC9zY0FKYkxZ?=
 =?utf-8?B?N0RhQWEzeU5Oc1ZjaHMzdldNYmZXYStxSysxMVlxMm1CNjU4Qk8rczNFYm1r?=
 =?utf-8?B?VnFUajRVc0RwSG13aE5NMTNTbEpBM1dwUGpLcU5jWkFFd3dzL2oyZWZrWVJU?=
 =?utf-8?B?enlRb3U5a3IycUoxMEtKa2xEbENRRzlOZkM2WllPMnoxaStZMkRrbHFnZEgz?=
 =?utf-8?B?QytxcVJuL2VUcjVYNUlXSTU1K0I0R2J5VG1CSGo1Zi9KWlo4SitSajl6UDAw?=
 =?utf-8?B?ZTViMmZuaW9mNG03VU90VmJlNzZqNnpQYXpzZnhnMDNUaE5VbnUvM0h5aitL?=
 =?utf-8?B?L25YUFhCZTc4bUhLYVg4US9NVnFucmRGQXpod1cvTzJ0UXVKem5kUE9PbHl5?=
 =?utf-8?B?VCtRT3hYazg2NnVLT25IeUw2UVQzK0R0Z1RtNXR2UXNSdVptWWpFemwvVTJa?=
 =?utf-8?B?RW5YT1pob3lUbjExdWJmZXIvamNpZHo0WTFiREhNbStUb0NNM3VBV1ZPUUJh?=
 =?utf-8?B?YWlvL1FsVis3Q2hwazhzTzNrOGNXbGJFbVBvQ1NvVXB0UGkzSENTTnpsRStu?=
 =?utf-8?B?b3hUTkR5QVlDK0ZEbVFsZEpqWDRMYWhrNFFVS29TUENyampoa2dsWWR5elZ6?=
 =?utf-8?B?L0FZZytGempNNWZ3SUdpckxCLytpRFk3QkdFVmFhUjZ4WUgrY0l2WDFlSEVY?=
 =?utf-8?B?cnVsNThoYjNKcHBhekpmZVhhNWoreTJjNU5NYnBmQjRScEdQRk80V2NrTHdk?=
 =?utf-8?B?N0tzblg0OVVxcjNFUytWcUhlTGtHRWt1WkVnejJSbitVN1A3M0M2SVlQckVL?=
 =?utf-8?B?OVZpZ21CRGQzQ3VqWCtCT09uOWZnSmtDd2RPU2tiWE96ZUw1ZFgvOFEzUUFM?=
 =?utf-8?B?Tng1enZabTM1cUkvUHNld01ML0xxeW1XMXR2a0FQQzBOU2s2WnFVcEVJZDdo?=
 =?utf-8?B?TG16UG93Q0dHS0h6MlRjM0JwTDdOTmw4b1dBbzY1aktLWCt1ejJlbTFoUllC?=
 =?utf-8?B?cytyaElsTnFGQ1Z2b2RPbzVhdllsM2UwUC9rMnNsUTBJaGMzTzl5dHRXL3dJ?=
 =?utf-8?Q?POGdieO2WaDTBXKR6W20TcVG+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6454cab-6217-47db-b25c-08dd5ac80355
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 02:55:25.2151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0nKuhmuYXyOE+/3zUcuWthA1PVkTa8023j876XD0RSfaEv9CT9SC8bwzr61f0krTMSfg9I49vEmEDuklxCtnV2fltn6vFzaP9XOsOcMbt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7181
Received-SPF: pass client-ip=2a01:111:f403:200e::724;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzIzXSBody9hcm0vYXNw
ZWVkOiBSZW5hbWUgSVJRIHRhYmxlIGFuZCBtYWNoaW5lDQo+IG5hbWUgZm9yIEFTVDI3MDAgQTAN
Cj4gDQo+IE9uIDMvMy8yNSAxMDo1NCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEN1cnJlbnRseSwg
QVNUMjcwMCBTb0Mgb25seSBzdXBwb3J0cyBBMC4gVG8gc3VwcG9ydCBBU1QyNzAwIEExLCByZW5h
bWUNCj4gPiBpdHMgSVJRIHRhYmxlIGFuZCBtYWNoaW5lIG5hbWUuDQo+ID4NCj4gPiBUbyBmb2xs
b3cgdGhlIG1hY2hpbmUgZGVwcmVjYXRpb24gcnVsZSwgdGhlIGluaXRpYWwgbWFjaGluZQ0KPiA+
ICJhc3QyNzAwLWV2YiIgaXMgYWxpYXNlZCB0byAiYXN0MjcwMGEwLWV2Yi4iIEluIHRoZSBmdXR1
cmUsIHdlIHdpbGwNCj4gPiBhbGlhcyAiYXN0MjcwMC1ldmIiIHRvIG5ldyBTb0NzLCBzdWNoIGFz
ICJhc3QyNzAwYTEtZXZiLiINCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFt
aW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZC5jICAg
ICAgICAgfCA5ICsrKysrLS0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgfCA4ICsr
KystLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNw
ZWVkLmMgaW5kZXgNCj4gPiBjNmMxODU5NmQ2Li4yNDgyZjA1MTU0IDEwMDY0NA0KPiA+IC0tLSBh
L2h3L2FybS9hc3BlZWQuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBAIC0xNjcz
LDEyICsxNjczLDEzIEBAIHN0YXRpYyB2b2lkDQo+IGFzdDI3MDBfZXZiX2kyY19pbml0KEFzcGVl
ZE1hY2hpbmVTdGF0ZSAqYm1jKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZ
UEVfVE1QMTA1LCAweDRkKTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBhc3BlZWRf
bWFjaGluZV9hc3QyNzAwX2V2Yl9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywNCj4gPiB2b2lk
ICpkYXRhKQ0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9hc3QyNzAwYTBfZXZiX2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+ICt2b2lkICpkYXRhKQ0KPiA+ICAgew0KPiA+
ICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsNCj4gPiAgICAgICBB
c3BlZWRNYWNoaW5lQ2xhc3MgKmFtYyA9IEFTUEVFRF9NQUNISU5FX0NMQVNTKG9jKTsNCj4gPg0K
PiA+IC0gICAgbWMtPmRlc2MgPSAiQXNwZWVkIEFTVDI3MDAgRVZCIChDb3J0ZXgtQTM1KSI7DQo+
ID4gKyAgICBtYy0+ZGVzYyA9ICJBc3BlZWQgQVNUMjcwMCBBMCBFVkIgKENvcnRleC1BMzUpIjsN
Cj4gPiArICAgIG1jLT5hbGlhcyA9ICJhc3QyNzAwLWV2YiI7DQo+IA0KPiBwbGVhc2UgcHV0IHRo
ZSAtPmFsaWFzIGFzc2lnbm1lbnQgbGluZSBmaXJzdC4gU28gdGhhdCBpdCBpcyBlYXNpbHkgaWRl
bnRpZmllZC4NCj4gDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2ls
bCBmaXggaXQuDQpKYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+ICAg
ICAgIGFtYy0+c29jX25hbWUgID0gImFzdDI3MDAtYTAiOw0KPiA+ICAgICAgIGFtYy0+aHdfc3Ry
YXAxID0gQVNUMjcwMF9FVkJfSFdfU1RSQVAxOw0KPiA+ICAgICAgIGFtYy0+aHdfc3RyYXAyID0g
QVNUMjcwMF9FVkJfSFdfU1RSQVAyOyBAQCAtMTgxNyw5ICsxODE4LDkNCj4gQEANCj4gPiBzdGF0
aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX21hY2hpbmVfdHlwZXNbXSA9IHsNCj4gPiAgICAgICAg
ICAgLmNsYXNzX2luaXQgICAgID0NCj4gYXNwZWVkX21pbmlibWNfbWFjaGluZV9hc3QxMDMwX2V2
Yl9jbGFzc19pbml0LA0KPiA+ICAgI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+ID4gICAgICAgfSwg
ew0KPiA+IC0gICAgICAgIC5uYW1lICAgICAgICAgID0gTUFDSElORV9UWVBFX05BTUUoImFzdDI3
MDAtZXZiIiksDQo+ID4gKyAgICAgICAgLm5hbWUgICAgICAgICAgPSBNQUNISU5FX1RZUEVfTkFN
RSgiYXN0MjcwMGEwLWV2YiIpLA0KPiA+ICAgICAgICAgICAucGFyZW50ICAgICAgICA9IFRZUEVf
QVNQRUVEX01BQ0hJTkUsDQo+ID4gLSAgICAgICAgLmNsYXNzX2luaXQgICAgPSBhc3BlZWRfbWFj
aGluZV9hc3QyNzAwX2V2Yl9jbGFzc19pbml0LA0KPiA+ICsgICAgICAgIC5jbGFzc19pbml0ICAg
ID0gYXNwZWVkX21hY2hpbmVfYXN0MjcwMGEwX2V2Yl9jbGFzc19pbml0LA0KPiA+ICAgI2VuZGlm
DQo+ID4gICAgICAgfSwgew0KPiA+ICAgICAgICAgICAubmFtZSAgICAgICAgICA9IFRZUEVfQVNQ
RUVEX01BQ0hJTkUsDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIv
aHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgaW5kZXgNCj4gPiA1MjdhNWY4MjQ1Li5mMWJlZWE3ZWNl
IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gKysrIGIvaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPiBAQCAtNzMsNyArNzMsNyBAQCBzdGF0aWMgY29uc3Qg
aHdhZGRyIGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1tYXBbXSA9DQo+IHsNCj4gPiAgICNkZWZpbmUg
QVNUMjcwMF9NQVhfSVJRIDI1Ng0KPiA+DQo+ID4gICAvKiBTaGFyZWQgUGVyaXBoZXJhbCBJbnRl
cnJ1cHQgdmFsdWVzIGJlbG93IGFyZSBvZmZzZXQgYnkgLTMyIGZyb20NCj4gPiBkYXRhc2hlZXQg
Ki8gLXN0YXRpYyBjb25zdCBpbnQgYXNwZWVkX3NvY19hc3QyNzAwX2lycW1hcFtdID0gew0KPiA+
ICtzdGF0aWMgY29uc3QgaW50IGFzcGVlZF9zb2NfYXN0MjcwMGEwX2lycW1hcFtdID0gew0KPiA+
ICAgICAgIFtBU1BFRURfREVWX1VBUlQwXSAgICAgPSAxMzIsDQo+ID4gICAgICAgW0FTUEVFRF9E
RVZfVUFSVDFdICAgICA9IDEzMiwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9VQVJUMl0gICAgID0g
MTMyLA0KPiA+IEBAIC03NjIsNyArNzYyLDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3Qy
NzAwX3JlYWxpemUoRGV2aWNlU3RhdGUNCj4gKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAg
IGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgiYXN0MjcwMC5pbyIsIDB4MCwgMHg0MDAwMDAw
KTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI3MDBfY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQNCj4gPiAqZGF0YSkNCj4gPiArc3RhdGljIHZv
aWQgYXNwZWVkX3NvY19hc3QyNzAwYTBfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQN
Cj4gPiArKmRhdGEpDQo+ID4gICB7DQo+ID4gICAgICAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25z
dCB2YWxpZF9jcHVfdHlwZXNbXSA9IHsNCj4gPiAgICAgICAgICAgQVJNX0NQVV9UWVBFX05BTUUo
ImNvcnRleC1hMzUiKSwgQEAgLTc4NSw3ICs3ODUsNyBAQA0KPiBzdGF0aWMNCj4gPiB2b2lkIGFz
cGVlZF9zb2NfYXN0MjcwMF9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkN
Cj4gPiAgICAgICBzYy0+dWFydHNfbnVtICAgID0gMTM7DQo+ID4gICAgICAgc2MtPm51bV9jcHVz
ICAgICA9IDQ7DQo+ID4gICAgICAgc2MtPnVhcnRzX2Jhc2UgICA9IEFTUEVFRF9ERVZfVUFSVDA7
DQo+ID4gLSAgICBzYy0+aXJxbWFwICAgICAgID0gYXNwZWVkX3NvY19hc3QyNzAwX2lycW1hcDsN
Cj4gPiArICAgIHNjLT5pcnFtYXAgICAgICAgPSBhc3BlZWRfc29jX2FzdDI3MDBhMF9pcnFtYXA7
DQo+ID4gICAgICAgc2MtPm1lbW1hcCAgICAgICA9IGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1tYXA7
DQo+ID4gICAgICAgc2MtPmdldF9pcnEgICAgICA9IGFzcGVlZF9zb2NfYXN0MjcwMF9nZXRfaXJx
Ow0KPiA+ICAgfQ0KPiA+IEBAIC04MDAsNyArODAwLDcgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZv
IGFzcGVlZF9zb2NfYXN0Mjd4MF90eXBlc1tdID0gew0KPiA+ICAgICAgICAgICAubmFtZSAgICAg
ICAgICAgPSAiYXN0MjcwMC1hMCIsDQo+ID4gICAgICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZ
UEVfQVNQRUVEMjdYMF9TT0MsDQo+ID4gICAgICAgICAgIC5pbnN0YW5jZV9pbml0ICA9IGFzcGVl
ZF9zb2NfYXN0MjcwMF9pbml0LA0KPiA+IC0gICAgICAgIC5jbGFzc19pbml0ICAgICA9IGFzcGVl
ZF9zb2NfYXN0MjcwMF9jbGFzc19pbml0LA0KPiA+ICsgICAgICAgIC5jbGFzc19pbml0ICAgICA9
IGFzcGVlZF9zb2NfYXN0MjcwMGEwX2NsYXNzX2luaXQsDQo+ID4gICAgICAgfSwNCj4gPiAgIH07
DQo+ID4NCg0K

