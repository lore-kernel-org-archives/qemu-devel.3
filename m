Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79716CCFA13
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 01:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIdGh-0003cY-T3; Mon, 10 Nov 2025 20:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIdGT-0003Wa-Gf; Mon, 10 Nov 2025 20:33:47 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIdGQ-0006SR-5Y; Mon, 10 Nov 2025 20:33:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuQbgvJOsx3PRYuME5QpEppSQpP515k9zSvBHBj9xe2QkAuOocVlmROghTO+9gOYJqB9drtJO68VoHliyzuqmel6oEz993cusDZYmEd53MX/267nVdOHJc45/E1870YflOg5ytASVdZKS5fhRAAMZtsBUVIvjLfLAEoqAub+JAA6TKomC54XlY8J55auKsZkkjDWo/u1OONpev2AIZlOYK6GxU/TsWpkJDdtmxUEYE2NP0Edr4g7IR7IJWeB+C/gO7fbxLtEGN4QrRpTYGmWN7iom6VzmE4W+s0oNtLDKKC9akl2uzXOQi+wqr+thneVMKEweWbP5FuJ06Zet0vcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9EIlBnqwZhk+21S1YSE6nfqoa+6P6JhcWIuoAtOqKA=;
 b=SVEaAYbmqZmNhAzPcVVPFjFlLwiNSFDAnAMggewer+obRP+4Jra7M5QP4ntvDEz0Upx8/YlapZH+yam/93o7Si96T+gLrrwO5SI0+3hwSDptkYt4UBFLz90sUs4aepbjrRqWKuFysLTO0aJGvdUfWQfPRFB06MbHpR9lincJ6tam3rZGY9iD2Uq0Qf33jWMiLZnY0iCefl4nVCQtf7DxgAE8Mqz9mbkwBSDHAv7/nJHrsvLgk+T4/cTHCQyKiIOLMZKF4cCe/3e7AXq02JuaPOEnZwnK/kR5B4GfJT5Z6eF8YVN47mckBRjOdX56+2aupeGGSPRUxP3jJaZB77+4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9EIlBnqwZhk+21S1YSE6nfqoa+6P6JhcWIuoAtOqKA=;
 b=TZ4S5oDEedVwr6QW5CRHBwi+mcT+KNo9M9EpEQLBQoajyO7GWCT1jESAt8L5pEj8/sIWn9HMG5q78Ss5LimMsjXu+jOC0/BEo7L2FibLPDRIPcilyZH/wyHOVWlzcAhGnGdEDjrTIKYYXeQltfha+kdvHUbZi4oNCL4nPOOoCaG7BlPc93Gmsf4PzIEx0Cq1Y44NWjparISU1e5mVJodC3/hk6fMDGB37u+g/mgwEYKm4H5VNs+DCQsp738Mwo5/OU8ebRGvdkpdkgK0zUILu6NYwWbPrlSofL1CwfaelYtJDr2eO2FzECS5qzvxdOlHqRQE0h4QZRhFztfVEMl+dg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6953.apcprd06.prod.outlook.com (2603:1096:405:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:33:33 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:33:33 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Yubin Zou <yubinz@google.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 16/17] hw/arm/aspeed: Model AST1700 SGPIOM block as
 unimplemented device
Thread-Topic: [PATCH v2 16/17] hw/arm/aspeed: Model AST1700 SGPIOM block as
 unimplemented device
Thread-Index: AQHcTgiRN2NNSqU/SUS5oo/OkJT3M7TsHjKAgACau4A=
Date: Tue, 11 Nov 2025 01:33:32 +0000
Message-ID: <SI6PR06MB7631AD1B0C7457F8890AAA08F7CFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-17-kane_chen@aspeedtech.com>
 <e5c2996f-610a-4c53-b086-d0c9306add00@kaod.org>
In-Reply-To: <e5c2996f-610a-4c53-b086-d0c9306add00@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6953:EE_
x-ms-office365-filtering-correlation-id: c670515f-8503-426d-63a7-08de20c2538a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?Y2xnV2FXZFpHRHJ3ZzlXNHEwU0JDWWNjb1RyZEJoYVV3Y1V5QXdXVEM5QWsx?=
 =?utf-8?B?N0lUK3dvU1BSN2hrOFlMTHFkM2dUYXdlaDlEVzBOZS9JaVM1enNqa1lXU0xO?=
 =?utf-8?B?cS96L3hUZzlrbXFyMW55S2lxMkZNZ1RmM2FVVGVteUcyRnBWTExzSEtrQytD?=
 =?utf-8?B?TDRKZUNKaDlHckpkRFpWM3pSMFR4N2hoS0FkQXkxNU5TOCtjSWVMQWowTHNT?=
 =?utf-8?B?RnZyNTRWdmdzMkMzeWxwV3ArUDJpWkk3V0paVThoVXpHbzcrVlhGd1p2ZWYx?=
 =?utf-8?B?MEdxMmNoL2Njd2hFT1gybVJ4em9RS0Q4V0ZqdXlOSEQrNVpKUzYzYlk1dnFi?=
 =?utf-8?B?V3FrRDBvL29yRitEcm5PZW5BSWVabHNNUzdRTTBGZCtka2c1c0RRWTNBRDJj?=
 =?utf-8?B?YVFSblgwQlNNRmFQajBhZ2RQL0ZnV093d2xldzR1RHdZaENVL3JIMFNod0dl?=
 =?utf-8?B?WldpeXV2Uk5Ib01yRlE1cHBscVRHbC9veUY5bWxReFNuUG55OVpIT0J0cWZi?=
 =?utf-8?B?YTRNelJVQXQrTDE2clBmR2psNGtnb1M5UXc4ZldvaXdhd2N1QjNOUkNod1Z3?=
 =?utf-8?B?U0YvOE44U2VtVmFQNXNTcVF0NExnTXRGaVNORUxIa3dMaHhGNkpFdnppTm1m?=
 =?utf-8?B?ZTlub1FIcEsvckQxcFdCa3FGeXBuTEtZM01hWVRZYzB5V2xlQm12UDBsMDQ5?=
 =?utf-8?B?OW5tZjBGSU5uR3lhaVg4d3NIRkNLUURhVjQ3aklEb3ZGNFljYlhPSzNkVGkx?=
 =?utf-8?B?VGFnZUZsN3pMTVRrV1JMYlNGckFDYTMwb2ZDdHdHenBiUFNSZXJJZnRpSmox?=
 =?utf-8?B?MFpIejVrQWxzb256TmsvNGNMdkx4N2EzMjY5cFVYYUkxMHFBUDRhbmFxTzdO?=
 =?utf-8?B?cndKMmNnNEN1VjJjcU9ORzl6OW5LaUNTdnpiaWovV092ekt4Si9LRXhReUNF?=
 =?utf-8?B?VDcwUzRzcXQxMXUwdWoxRHBINGlBOHdSb1JURmZiT2VzVVE4dTR2VGtUR2dU?=
 =?utf-8?B?YmlmVjAzWWRFaG5EU3dYMlJBU0VaZjV2NGFaYWxaS3dFR29TWWhqVW9kRkFE?=
 =?utf-8?B?QUpZc2dwZU1hOE1MdHBYdVZBaGU4MEpmT0NadXByT21ueUtRWlUrei9RVWVK?=
 =?utf-8?B?a0hhTnhOdVpaVUdRSmp2UDQ4dUFPK1hROUhpUUhjZEM2MTdEVjlxODJaYytt?=
 =?utf-8?B?TjUrWVhWbVdjVStFQ0E1YTUwYTJUOUxDbHB4SU8yM1RVWDk4NkdmbXkwRkdj?=
 =?utf-8?B?MFBYbkl5a3pPTHFXdEQ2VGQ5ODBJUFd4dVF0NUFCZnM3dFdhR3RaQVJXa2ZT?=
 =?utf-8?B?V3k0amJiTXg5d3JWaWpFcmVnRWVmTmh6UTBldDFEaVV0MTNLdk1KVWFFdzhM?=
 =?utf-8?B?emhGa2RWU3I4clR6S2UrRFN3clRkQkdDOGROd3ZyeUpJWFRzYjlzZXUyZjMw?=
 =?utf-8?B?d2h0azJoN0FlMFcyazYxTUJ5NjZyN2FYNGRZOHVaRjVBd1d1aUFhYzVpNjdW?=
 =?utf-8?B?Z1JPN0lXS1Y0NEpPZXkxWm9qNW8wTjMrMGhFeEwra1FJUXNCdm14M0lCL0sw?=
 =?utf-8?B?YWszWjNlcnk5YVMrUDIxOEVUN20ySGdxM3Ntdkc1Nm5Gc0gxNFJjY1hwaTJh?=
 =?utf-8?B?b21LL3NZQlpYYzNMWXE0eldnLzd1Vm9hUURzVFRaeW9iQ05ZUTZRSStVbytO?=
 =?utf-8?B?NlhTeFRPeXpZRkJNOTNsTElBZmlNRGI5eTRXTFRwUnIwNklLZ2l4OU01ZEJ4?=
 =?utf-8?B?Y2hxTzZxMFc4SVlvS0xkMndLZEp1SGEyU2d5MU1mUXdQSUZwVmRUanFsSFo2?=
 =?utf-8?B?YWM1QkJSUGZrclFWMmFxRVROQjBrcWk4YjFudDNHUXpqaVRGZVhiTVg0RmQ5?=
 =?utf-8?B?b3FFUmhkNHQycVhzY3NNL2FyNHdzTlRtdFZLa1FhSGNQWVB0VmFpbEhZVElL?=
 =?utf-8?B?ZHdoMmhXTmN1RDVJOUZrbDI5L0d4UDZFNmhwNGtrV3RYSzY2NEJ2SHBwQ3NM?=
 =?utf-8?B?M3ZEWTVpZjMxajJYK0JYdTl3M2EydVE2RXpGK0N1Vjd1TmN2V0FPbzBWTitz?=
 =?utf-8?B?bDFpWlJXWDRDbVJCNmErcG5WWFFmV09yWGxGdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVvaFRIaGZ6cEpXUEpwYWJGcVpocVh3N2lHTVJUTmsyZ1VxbzA4aW1YYXh3?=
 =?utf-8?B?RUhzUUVjOGFjN2djMEpNV1ROZWdxaWUyOENCUm11eFZtUWU0V290bUhxemVh?=
 =?utf-8?B?Z3JBVzhmZm5BZG9XL2FzOXlSbmppU0hTWmsvSk44aFlWVWpJUW9jdTZQdHVw?=
 =?utf-8?B?ZjNwdkR2UzZ1anhYQm4rUHduOC9hWTloWFovUW9IeVFlbVpIdktIcXh3SExL?=
 =?utf-8?B?Vi9iVUlYK2t1QXpBcVRCd0l2TWhmb1hlbnNUOFpiOHlVZVFpamxJeGt2YllO?=
 =?utf-8?B?MFhiSUFmWlMrVkVyV2RyTCt1Nm5ZdEpBR09zYTI4NnpjeG9MRlQrcEJsNUww?=
 =?utf-8?B?STRQV2VjQ3lTZVM5cTRKdlRDMnc0TE5NcTRWemNMdUhQWTlrNCtuQ28xZkVi?=
 =?utf-8?B?c014T2F5NXhTeGZTZTJqQ2p5NnM3ZVp5R3VvNUEwcmxnWGp1eDBWNFFYdVZ3?=
 =?utf-8?B?ckdyelQyT0hxcDVnUCthYXdOUTlYY1hrdnQ3QjFta0VpUlg1UXVSd0h6SjBt?=
 =?utf-8?B?c2hNMlE0ekNCdDRqZ3JFSUIyK3F5OWl1Sk8ybzZPZDIwU296bWlHVkh5K2E4?=
 =?utf-8?B?bmNIM0k3NEMzdmd0R2FpaEdCQVdLMTVaQ2grQXU5ck1pLzlwdy9rMURWdnFK?=
 =?utf-8?B?WWJ1ME0vNnhDRWlWdFlMUC9zTVlhV2p3ZVgxWTVzSXZsa0daelI3YUJEYkRD?=
 =?utf-8?B?ZXFTbFdlN1FtUVpiZkltN2V2SC9SU2tRUE5EZy9GYlFxSXd0OURXby9OUUhp?=
 =?utf-8?B?dXhWeUdkZ21BRXZnVXJwdmsxelRkYjRROFJGeVJXcmZJYkhPTVBnMWJPUUpu?=
 =?utf-8?B?cHMvWnJEWGV5ZnlOaFFUcU5DNkkyMFBPRHF1YjlaTzY0WHZQQUpkNjYzVXk1?=
 =?utf-8?B?OWl6L1g5dXdDbFd1dXFOYzV0bUQ0K0diSDhxMStvdHNWK1Q1UWNqdWR5dnA4?=
 =?utf-8?B?ak1jRnN6elVKbUdraXBiVVZMTHIzN1VaNEUyc1BEVDZiKzZBZ0tKRnFqd21w?=
 =?utf-8?B?dzd5VGd3TjI5ZHh3Y0ZiK1g5ZXBpZTh3SGlzN2ZlT2JXR2lweU9IZ25IMHI2?=
 =?utf-8?B?YTRGOEU5TUtsRkNCaEIwdVNoQlgxNU9IUWNkNzNOSFhSUFI0MmFoRVlnRVNI?=
 =?utf-8?B?dHJkVjdKMS9iWWxZSDNkTGxQTk9oa01XblNWbmNBVEpDOVA5NFVMdjRuTXU5?=
 =?utf-8?B?bFVJczRMYWlZa3VRcjM4UGthSTk5VndwenZudGxXNE9rS1A3TkUxamN5S0tO?=
 =?utf-8?B?K01BT1hoUkZ6MGN4UVFaZ1plY3JEYnpXb2NSRlJnVzlsdjVGZ1VPY3NBSDBs?=
 =?utf-8?B?VmV2QUJOa3NHeDIzSU1BR0xxM29wZXdza1FuWkhpVnF1RFhLbEMyaVBpanZi?=
 =?utf-8?B?QUp4V1J5bk1Zb3dGSG9QV21RcGFZNUZlZGdIUDBIR0tnUE9HVzloemhYMUJl?=
 =?utf-8?B?NkhabStZcHRtVFpXdncyNERHWGVNSVIxd3JReXNwYktYZzhMMDk4U1Y0bmEw?=
 =?utf-8?B?b01xeGxScEJqL1Q5SGZlZDZYMUFvRGQxZnYzdXVMazc5YkJkTnZZa0wvM0NM?=
 =?utf-8?B?Wkl1VFV2WS84ZHRkRG44UlZCd2p6aU81Rnppd0hXRGNLd3BROWcrcHdqSDhi?=
 =?utf-8?B?RGlFcDNyQXFab1J0aGNHVm1QZ1FvNk82b0tBdzg5TkhYbHBNVUdzUjZUTEFp?=
 =?utf-8?B?TTJrU25QVHhyak5tb0RkcWVtS21hRWhxYkRFanBCaWZDeVhoS1RicWx4d2FR?=
 =?utf-8?B?NCtudy8zaDVCMHFKaHBIakRtWmJ3T0lTQmFvamRLaEV3Q1pRWE5DS08rdHpy?=
 =?utf-8?B?WnY5UnkxYkp3clc1UEhCYVZ5cVpZUEFUK2dZam84cWp3a1Z4ZjFrRjZRcWNV?=
 =?utf-8?B?MzlhMGthU0hKREV5UklFRm9XV1F1TEhaNDJsdTJyVjUvZFFiYnk0VVNxWGZW?=
 =?utf-8?B?c0pDVnh6dWlBN1FKam42T0xuTW0vUTNFY3I4cmp1dGYvTDJsVUgzUVdQY3k5?=
 =?utf-8?B?ZkVQMlZHS1FDVE5UcEM3YkQwSW5ZWDdXUVQ2V0F0NGdXcHdRWFBxRWxQb2Vy?=
 =?utf-8?B?TWRTNXZteWo1L2tLZzA4UnZjbXh2S3Vlc21SakdMY0IwRGtzWmMwVHY2VlRR?=
 =?utf-8?Q?uAgSBeKIm2HRmE3KWQZh+Ny9i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c670515f-8503-426d-63a7-08de20c2538a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:33:33.0267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqB+L3hffxq37B8drP1YVAhjMf2H0wJiOXQynPKWTpkPUFM5bE9zPF3zsB0ii/it7ZSIlDZ4hU3p0EnWy9nOZ6Yhr55R5rsSeUU2ZY5A7I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6953
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uIEknbGwgaW52ZXN0aWdh
dGUgdGhpcyBtb2RlbCBhbmQgaW50ZWdyYXRlIGl0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDExLCAyMDI1IDEyOjE1IEFN
DQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRl
bGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVA
YXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4g
b3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFs
bCBwYXRjaGVzIENDDQo+IGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFl1YmluIFpvdSA8
eXViaW56QGdvb2dsZS5jb20+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTYvMTddIGh3L2FybS9hc3BlZWQ6IE1vZGVs
IEFTVDE3MDAgU0dQSU9NIGJsb2NrDQo+IGFzIHVuaW1wbGVtZW50ZWQgZGV2aWNlDQo+IA0KPiBI
ZWxsbywNCj4gDQo+IE9uIDExLzUvMjUgMDQ6NTgsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9t
OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEFTVDE3
MDAgaW5jbHVkZXMgYW4gU0dQSU9NIGJsb2NrLCBidXQgUUVNVSBoYXMgbm8gZnVuY3Rpb25hbCBt
b2RlbCB5ZXQuDQo+IA0KPiBEb2VzIHRoZSBzZXJpZXMgICJody9ncGlvOiBBZGQgQXNwZWVkIFNl
cmlhbCBHUElPIChTR1BJTykgY29udHJvbGxlciIgWzFdDQo+IHByb3Bvc2VkIGJ5IFl1YmluIFpv
dSBmaWxsIHRoaXMgZ2FwID8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiBbMV0NCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvL3FlbXUtZGV2ZWwvMjAyNTExMDYtYXNwZWVkLXNncGlv
LXYxLTAtYjAyNjA5MzcNCj4gMTZmYUBnb29nbGUuY29tDQo+IA0KPiANCj4gPiBFeHBvc2UgaXQg
YXMgYW4gdW5pbXBsZW1lbnRlZCBkZXZpY2Ugc28gdGhlIGFkZHJlc3Mgc3BhY2UgaXMgcmVzZXJ2
ZWQNCj4gPiBhbmQgdGhlIG1pc3NpbmcgZnVuY3Rpb25hbGl0eSBpcyBleHBsaWNpdCB0byB1c2Vy
cy9ndWVzdHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hl
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRf
YXN0MTcwMC5oIHwgIDEgKw0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5jICAgICAgICAg
fCAxNiArKysrKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2FzdDE3
MDAuaA0KPiA+IGIvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmgNCj4gPiBpbmRleCA0
MDQ4ZDMxMTU0Li44YWRhM2E3Nzc1IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvbWlzYy9h
c3BlZWRfYXN0MTcwMC5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9hc3QxNzAw
LmgNCj4gPiBAQCAtNDQsNiArNDQsNyBAQCBzdHJ1Y3QgQXNwZWVkQVNUMTcwMFNvQ1N0YXRlIHsN
Cj4gPiAgICAgICBBc3BlZWRXRFRTdGF0ZSB3ZHRbQVNUMTcwMF9XRFRfTlVNXTsNCj4gPg0KPiA+
ICAgICAgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSBpM2M7DQo+ID4gKyAgICBVbmltcGxlbWVu
dGVkRGV2aWNlU3RhdGUgc2dwaW9tOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgI2VuZGlmIC8qIEFT
UEVFRF9BU1QxNzAwX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9hc3BlZWRfYXN0MTcw
MC5jIGIvaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5jIGluZGV4DQo+ID4gMzdiMjk0NmZjMC4uNjZh
NWYyMWQyNyAxMDA2NDQNCj4gPiAtLS0gYS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmMNCj4gPiAr
KysgYi9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmMNCj4gPiBAQCAtMTksNiArMTksNyBAQA0KPiA+
ICAgI2RlZmluZSBBU1QyNzAwX1NPQ19MVFBJX1NJWkUgICAgICAgIDB4MDEwMDAwMDANCj4gPiAg
ICNkZWZpbmUgQVNUMTcwMF9TT0NfU1JBTV9TSVpFICAgICAgICAweDAwMDQwMDAwDQo+ID4gICAj
ZGVmaW5lIEFTVDE3MDBfU09DX0kzQ19TSVpFICAgICAgICAgMHgwMDAxMDAwMA0KPiA+ICsjZGVm
aW5lIEFTVDE3MDBfU09DX1NHUElPTV9TSVpFICAgICAgMHgwMDAwMjAwMA0KPiA+DQo+ID4gICBl
bnVtIHsNCj4gPiAgICAgICBBU1BFRURfQVNUMTcwMF9ERVZfU1BJMCwNCj4gPiBAQCAtMjYsNiAr
MjcsNyBAQCBlbnVtIHsNCj4gPiAgICAgICBBU1BFRURfQVNUMTcwMF9ERVZfQURDLA0KPiA+ICAg
ICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9TQ1UsDQo+ID4gICAgICAgQVNQRUVEX0FTVDE3MDBfREVW
X0dQSU8sDQo+ID4gKyAgICBBU1BFRURfQVNUMTcwMF9ERVZfU0dQSU9NLA0KPiA+ICAgICAgIEFT
UEVFRF9BU1QxNzAwX0RFVl9JMkMsDQo+ID4gICAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0kzQywN
Cj4gPiAgICAgICBBU1BFRURfQVNUMTcwMF9ERVZfVUFSVDEyLA0KPiA+IEBAIC00MCw2ICs0Miw3
IEBAIHN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW10gPQ0KPiB7
DQo+ID4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9BRENdICAgICAgID0gIDB4MDBDMDAwMDAs
DQo+ID4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9TQ1VdICAgICAgID0gIDB4MDBDMDIwMDAs
DQo+ID4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9HUElPXSAgICAgID0gIDB4MDBDMEIwMDAs
DQo+ID4gKyAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1NHUElPTV0gICAgPSAgMHgwMEMwQzAwMCwN
Cj4gPiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0kyQ10gICAgICAgPSAgMHgwMEMwRjAwMCwN
Cj4gPiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0kzQ10gICAgICAgPSAgMHgwMEMyMDAwMCwN
Cj4gPiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1VBUlQxMl0gICAgPSAgMHgwMEMzM0IwMCwN
Cj4gPiBAQCAtMTYyLDYgKzE2NSwxNSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0MTcwMF9yZWFs
aXplKERldmljZVN0YXRlDQo+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPg0KPiBhc3BlZWRfYXN0
MTcwMF9pb19tZW1tYXBbQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RSTF0sDQo+ID4NCj4gPiBz
eXNidXNfbW1pb19nZXRfcmVnaW9uKFNZU19CVVNfREVWSUNFKCZzLT5sdHBpKSwgMCkpOw0KPiA+
DQo+ID4gKyAgICAvKiBTR1BJT00gKi8NCj4gPiArICAgIHFkZXZfcHJvcF9zZXRfc3RyaW5nKERF
VklDRSgmcy0+c2dwaW9tKSwgIm5hbWUiLCAiaW9leHAtc2dwaW9tIik7DQo+ID4gKyAgICBxZGV2
X3Byb3Bfc2V0X3VpbnQ2NChERVZJQ0UoJnMtPnNncGlvbSksICJzaXplIiwNCj4gQVNUMTcwMF9T
T0NfU0dQSU9NX1NJWkUpOw0KPiA+ICsgICAgc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0Uo
JnMtPnNncGlvbSksIGVycnApOw0KPiA+ICsgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9u
X292ZXJsYXAoJnMtPmlvbWVtLA0KPiA+ICsNCj4gYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW0FT
UEVFRF9BU1QxNzAwX0RFVl9TR1BJT01dLA0KPiA+ICsNCj4gc3lzYnVzX21taW9fZ2V0X3JlZ2lv
bihTWVNfQlVTX0RFVklDRSgmcy0+c2dwaW9tKSwgMCksDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIC0xMDAwKTsNCj4gPiArDQo+ID4gICAgICAgLyogV0RUICovDQo+ID4gICAgICAgZm9y
IChpID0gMDsgaSA8IEFTVDE3MDBfV0RUX05VTTsgaSsrKSB7DQo+ID4gICAgICAgICAgIEFzcGVl
ZFdEVENsYXNzICphd2MgPQ0KPiBBU1BFRURfV0RUX0dFVF9DTEFTUygmcy0+d2R0W2ldKTsgQEAN
Cj4gPiAtMjI1LDYgKzIzNywxMCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0MTcwMF9pbnN0YW5j
ZV9pbml0KE9iamVjdCAqb2JqKQ0KPiA+ICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9i
aiwgImx0cGktY3RybCIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmx0
cGksIFRZUEVfQVNQRUVEX0xUUEkpOw0KPiA+DQo+ID4gKyAgICAvKiBTR1BJT00gKi8NCj4gPiAr
ICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlvZXhwLXNncGlvbVsqXSIsICZzLT5z
Z3Bpb20sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1VOSU1QTEVNRU5U
RURfREVWSUNFKTsNCj4gPiArDQo+ID4gICAgICAgLyogV0RUICovDQo+ID4gICAgICAgZm9yIChp
ID0gMDsgaSA8IEFTVDE3MDBfV0RUX05VTTsgaSsrKSB7DQo+ID4gICAgICAgICAgIHNucHJpbnRm
KHR5cGVuYW1lLCBzaXplb2YodHlwZW5hbWUpLCAiYXNwZWVkLndkdC0lcyIsDQo+ID4gc29jbmFt
ZSk7DQoNCg==

