Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563A8CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 06:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utK9d-00047L-FA; Tue, 02 Sep 2025 02:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1utK9V-00045H-Ih; Tue, 02 Sep 2025 02:05:57 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1utK9T-000495-32; Tue, 02 Sep 2025 02:05:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpwavaV24MOvknfIRXF7FgsKFj8NSlXQ4iu8rCc3IKTuDFvR7g16UEjCOQ1WaW5RoMR+5+zOteTbl4DJPp0n5TomZR0a3EBMqnkaUfsovaodAh12UXDzwVr9aTyBttfVc3sxvkizAeLHp9KPDuoHPqRH6gsc14utJRYNvmmQHgbRw5iZARl7De75LqkTRu04kN52JeCXmBEXGygg9Iiysi7nKyGi0dEJFar/t1TCtHFE8EdHaAEVazgi+6hotnQhcPni+Jtvol3ndkBol98+LGJtBZ0aLiAp2ovGkSyF2ylea2xhCgT6wNmCY8c85IcpYNdCYdR7J/lSqaVhD8B5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+no+ly1eMiJGFdooOLnnwiyNmYOf+6l+vWWFhbobKs=;
 b=G1mk+HnPaPHtthjZUKfyxFKlI3ijORhc8K5FQzkzuaGDxmZd4b1VK1UCaIW5tengpAwoAGNxP9moq5GjdTaywD/Y1QsMVEiZQLcIYhdPdko4Lqz/qlgi42wA0j6hX299yogtRvgMsqweMcoLNvNkCSpXXt3innmMaUJlfd8vB9iRcF7cft5GiDAE9cEQdXTkZpur2E3HnN8ri0DL6shDQGtCzHm/7ROE5qJ79BrB3+dlogkmJH8OSyyZz4cEGxgjSWHXhdWV/xcpyAqbbeJxFoJKRNux/sAftRr+lJPVaglHMsSDZw+Y7RNEBjrCcfIK7eQvcvhPXY4J8+omtEEk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+no+ly1eMiJGFdooOLnnwiyNmYOf+6l+vWWFhbobKs=;
 b=FZO24OP+zJPQ/HdvvHBdy69ck2Ozn4eUIt969nhW6cvxnfru2acbjhc31HqoNxHj9z9dFrRhChjD78aYgxECVDdbAqhTHjigHH4ql3bvpQDyBJKkKcpeZcXhC2tR5IL6JNM0NQr3tWvfa0arLQTZV+5rej8YPVDj2/jAL/WjBN1HqLj2q9/oHdzZ4vl+m0kbzEy8eoOIR1nq6fz0asFJPPs1bnmK0ebQ2sydET8561lhRRQCw2zbf0HWKtGHkv/pkTJVQ3wvteilgzRYXj2WLjfB+KdWkWDKtiQ1U2XanBKq2Q5y1fn0CbqvLI/tRtcKFZwR5h0HpIcYkFyfvlPrEA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB6118.apcprd06.prod.outlook.com (2603:1096:101:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:05:48 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:05:47 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v5 00/10] aspeed: OTP model, SBC integration,
 tests, and docs
Thread-Topic: [SPAM] [PATCH v5 00/10] aspeed: OTP model, SBC integration,
 tests, and docs
Thread-Index: AQHcC20dofjhjMJAE0KjjjkwH5w+A7R/gmuAgAABJeA=
Date: Tue, 2 Sep 2025 06:05:47 +0000
Message-ID: <SI6PR06MB7631C1D6CD0DB98794DFD379F706A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
 <2ba426ce-58f3-4d01-b0a0-330d4718553e@kaod.org>
In-Reply-To: <2ba426ce-58f3-4d01-b0a0-330d4718553e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB6118:EE_
x-ms-office365-filtering-correlation-id: ef0ebbae-8d1a-497d-5b04-08dde9e6c2ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?NG05bFNSL1k4SUdtTVRwQzRTc3g4MGNyOEU3dkJKZUxSS201NVNheGdvVDdj?=
 =?utf-8?B?RjRlc0pMRXhtQUx0YkIxOEhSaHhzQjczbmZvc3R6Y0JCeXlmVzlEOURnZGJO?=
 =?utf-8?B?Y2RtOVZiczBwNCt1ZlhEbThjeHozdU5kRXRxMXVidStuZGkyVC8wRklDTVVV?=
 =?utf-8?B?Y2tUcEdSY0xKS3VMOGlrQU15eFptLzhSMkRHVnlHN3FUbHlrdUo5QzBmdFVh?=
 =?utf-8?B?Rm5LeXhCdzNHNXNwTzdvV3A4WkdHTGRPZmhGNlZXWkd3WWtoakZBMFd0YjVo?=
 =?utf-8?B?RVh0ME00STIwTEZmZ2pNczB0ejFiN2ZiMEhITmJ6alVQUkFDSkNjcnd2eUt0?=
 =?utf-8?B?VHRIUjVVM25HS2k3R1Q5Vndzblo1RlNNQ3FmcWIyZERIZGdUUURPeVVLVEVm?=
 =?utf-8?B?VjU5Q3JQMUx4YjVmdDlORmRnbkRiNS9seGM1bUxsTUJERzhaYlN5b1o1NG85?=
 =?utf-8?B?ZEl0ZWZiZ084anFPWmw5eHRqdEIyK2w0emhXMytJS1JTc3lYZmE4eWUrdFp5?=
 =?utf-8?B?WUIzaEg2UTBYVW1mRlBjaGhZR0lwUjNvcjJIMllmODdzUEI2dHVpd2wySE5F?=
 =?utf-8?B?Y3dUNzR3TWRLSXU5ZGpYSWRobng5YldBenF2SDVJTWIwbDFYM2FrSml6WXZL?=
 =?utf-8?B?M1dmc0luWEJINFUzbG16ZU5KT2RFOVZGTmtzL0lva0luYW5NNUh1UUNDYmk3?=
 =?utf-8?B?ekdPOUZKeVpIRWs3cEhMUXRMSzhieDI5NHo0emR1a1JIVnY1V3dEa3h1MEFC?=
 =?utf-8?B?Q0lVaXI3U214b2NQM1FwbUM5OEJoYWQycEI0WGxsN3hBekhla1Y4eTE1c0x2?=
 =?utf-8?B?dm1uM2dxUDEzN0hFSTUzWU1EVk91cXlLdDgvbTZlcENBNm9EZEVJenB4VTBP?=
 =?utf-8?B?WndhdXhhS1VQSnB5NzdZS0FIdWI3Tm1oSGNWeThCR0tJTjNTT1NzUWZwR3pk?=
 =?utf-8?B?NWNiQThZWlpVTVduNEM3OUZSb29xM0QzanorRnF2Nk9kVTZlS0JIejZPOUwx?=
 =?utf-8?B?M0trVGpQSExkY0tXcW1zMDJ1LzlORmlUVjgxU09WT1QyaE01YkNhMERVbERX?=
 =?utf-8?B?ZldCTkJtZS81SkN4M2FhMXE0M1hhWWlaRnhRTUlSZkNTRmU4dkZzR0JEVi91?=
 =?utf-8?B?eEwvY2o0VkpCRUdPUFNBNmdlNll1d01ESnJMZElCMWk5MVRQRENjcHBIeUFx?=
 =?utf-8?B?bkxRcUwxTGN3RWpwWFdYOG5ZaGRVbGtaNjZzblNNcmRLeldSaFY0VTF0L29Y?=
 =?utf-8?B?K0ZwMW4zU2lJRHRqZXFybTVublFzN1lWWnMwblR4NE9JYXB3VEU5c2M5US9h?=
 =?utf-8?B?cWNiNkVXbXUwRFRvSTVoL044T3VEWHg5Q2JydkxCejNxbnlZL0Z3UnVhNjNX?=
 =?utf-8?B?SEd3RXY5OWRyQlZyZGJsQy91MFdQWS9PWnVCTXFNN2pHN21ueTNmUzBlL3ZM?=
 =?utf-8?B?NWJvcWVORDBFcGllMDNNRS9Qd092cnBhT1dRRjhQaXhRME1oSjFyWGpKRmhY?=
 =?utf-8?B?OWwrekVEQlVseEtQUmRGeU5aUjZSeXcrNU9ZV0xldjEvdmJYaXVDekxWRita?=
 =?utf-8?B?QWMrRGo5U0FjTlJuMzVoTEhYMWp6MmxSY2tpaFhxYVRYNnVCMUh2Z2JCcEhZ?=
 =?utf-8?B?aWhidzVjUHNpbmoyazVDMzZlNXZ0eTk4TTVLQWVaVjJibnpueVZqNG1YTVc5?=
 =?utf-8?B?K0FFSEZyWlpyWjBxR0pCd2VhZUN4N0xGd1hMUjhOYlNuakJ5dms2ZDBlNlpj?=
 =?utf-8?B?TFZTalJpWkNrVEZzVHJrL0ZvMXB6UVRYTmZBeCs1a3p1cHU1SnhkSkk4eXk2?=
 =?utf-8?B?SjV5bkpuNUhFNXcvOUtQRkhmekNYSitDZ3kwSWhqZTkvREJTVVljaFpUb2lC?=
 =?utf-8?B?SFBydkQvL2l3T296UEtvNVVxMEZ4NDhPVjNLSXJWZHVtWVZLWjB3SnlaVzJG?=
 =?utf-8?B?MVN4eFJMRzRXZmluK0JnM0lNY3F6dE4zRlhNUk50OGNjS0NoY01BTXBEQUNL?=
 =?utf-8?B?WjllOUJ4dlNHVTdVeU1zTzlqSVBZWnVNSGtQUlJ0Tm5SZ3dyVHFVTFhQaGxa?=
 =?utf-8?Q?uMevRK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjdDVCtBaEVZNVVDRllBdFdZclNuTng4c25tM2Zld0d1NUwxdWVMZ0lsU0hk?=
 =?utf-8?B?c216ZnYvdWZ0c2tYUEJJSmpEZWg3OE1LVzhWOFlSL2hHZlpSVUhDdmhWVVZP?=
 =?utf-8?B?UEVsL1hKa0I0T2g4b3kyV082MWRtZDdIM0ZvdzdaNkhINVVFQXZPaW5QM0Q2?=
 =?utf-8?B?bU5BY2tzNGxvNkxiV0ltcmord3g4Mmh3K1FPZXViK2VuV0FaYjk5Q0w3bXhu?=
 =?utf-8?B?UVI4SEY3aWZEeU5YNzlzVVc1MzlmalQwbVEvdjRocEg2QXFod2dFcC9SYjV2?=
 =?utf-8?B?a3Ruc2Z1Vm84anY0MmFXYzhQMUJFRkM4UGJOTkZibEJ4ZWVNWFpJb21TRms2?=
 =?utf-8?B?U0F3UXkvaXpMeFplRERRYWpKZ1k4dkpOTGtmZ3ZUVVpFc08vV0xrNW9iSWh2?=
 =?utf-8?B?RjVsbFIydEJBenNUUkFHTXZYUmErTzhJUnl5Rm95aGFkeHl4bWtmZTNSWTdy?=
 =?utf-8?B?d04rU29MbWg0MC9vTzhiTEw4WmRhdEE5T29GZTE3QmNSZHlQSjF2eG1rU1BY?=
 =?utf-8?B?OFE5Uk5EQTRuMjExOGhCNU5FZFIyeVEwZ29kakxqa2RGUStSWVQ0N21LL3hk?=
 =?utf-8?B?bGpDQisydXBmaDhpYkt2M1RPMnRXYzhEdm1pN1NLUWwxZE1hZm13R1pBNnRC?=
 =?utf-8?B?UWtKQ3FMT014b3JxRDlkQUZXalJYZzM2ZC9UWFo2dzY3ZXhBVVJmQVU4ZmZ1?=
 =?utf-8?B?clIxV3dpemh4eE84V3IxQWJSV1JBVjhNMTgwdHYrbm1NSlJOUHNxZHVLVGJq?=
 =?utf-8?B?S3dweUtnTloxMjFtRVFRZnlRYXplQ3BXLzVpQ3pRNmp1S0R6Nmk0VWlabnJJ?=
 =?utf-8?B?WUVzZmt2TElDNCtibG40Y0NPVGRQTGJwQndrVUpEeittUnZFOGVhL2JuK05M?=
 =?utf-8?B?R2lCME1KWkY4dHpMNmU5UitsR2hqaTI1dElkV1FBeWNrZVlzWWpHY3I5TGp5?=
 =?utf-8?B?MEhuNW9PaVBuLzJFOGhoaXdZQXZNTmxRSEpJMkRqNlhYdFBzV3NNRDNYOHMy?=
 =?utf-8?B?WXRQemFLZm1VK0FIaXQyOWNnMEgrZGl3djdFaFdnUm5IUjAwODBXZzJrVWhN?=
 =?utf-8?B?NUJ1REF0UUZBNEtlVTN6RDE4Z1NwUW1TeTd4L2tSNjU3eHc4WmVmQVpBb3VS?=
 =?utf-8?B?bWxKVDJqU2FONXlIWTFWL0ZvNkYxZFVFSFhBbDFGdUk5d212ZVdVVXA2QW9w?=
 =?utf-8?B?RkljcitsMXJyRTM4RWR6MWZpU3JJZlJOQjNWOVhTelc5R3lVUHJ6MEp6YlFk?=
 =?utf-8?B?eVkxSGZ2QXEwOUhSMVczaWZnTGhsdXNvWUMyWWpLOEw4bjFITkg5Zm9HdlN2?=
 =?utf-8?B?OVVqMngveEQwclV1SFVjSE5JMDVFUTVNNmowU2tRK2VtTk1mN0kxQURMZllQ?=
 =?utf-8?B?UWNOVGpYV1c5U0dGNVhGUkNmYnVXZ1ltbGRLR1ZQQ0N4NHFxNEpuMWVvWlFp?=
 =?utf-8?B?dUZZcy9hdEJhYXozVUhRcGRkRGJnZXREdnVCOW9CNnpTOTB3ZGwyVzNVRmoz?=
 =?utf-8?B?UHlCcVpqT0Jmb3VIRDFQOG5FaUI2OW5OUTQ1RVd3YUhaazJRaVQrM012NWJu?=
 =?utf-8?B?RWhkM1lldUNIdzQrR1Yvdjh0bXlaTFhCU3oyOUhYcE9hZmtPWWNmR25nWWR4?=
 =?utf-8?B?SnovL09TWDJyckcwL2dUSkcwK0RqOTJJRFJ2T05kdUVpeWlWMksyUXdWV3ps?=
 =?utf-8?B?YnpGL01KcjBuV3hwRVVabXErKy9RK25ISlZVQW9jNUpNVGpIMzNPZkNXMU13?=
 =?utf-8?B?QmNpTTVKMFBLcU1mVHBQMnY5UVBBNkZTSHkxQ0poZUxEblJkU0hLSjlkSGt1?=
 =?utf-8?B?YWh1dmZmRE1peG1FdmM2MDhieGJ4MldDUlFqdm1PYzNSWllQcTMwbmpzUDNk?=
 =?utf-8?B?RjBFYUtGZHZ3U29KanVnTU9IYjVvcGlYV1gvbFVac3dIU2xWMFNhWEQwbGpa?=
 =?utf-8?B?UWNjeG8xcGhzeFJBVXkxTzZIQ0p2MVZXSnJ1bEkvT0RxSjZaOG1JZ29KNlFN?=
 =?utf-8?B?K2FQT0x5UXpPbUt0NklSSThKVmEvWHhaKzBPRVB0aGc2RGN6TE45M2tqNWFu?=
 =?utf-8?B?TTI0cGhSYTJXMHdiTGtodDRiK080ejBoaDczeFJaTnhxaFpKUUg4aEJXVGNM?=
 =?utf-8?Q?miUiObfSuvWg6OBUQqDxE4iRh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0ebbae-8d1a-497d-5b04-08dde9e6c2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 06:05:47.8215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVIc+3pZG+/DCk3M/pMeHsLrR1+vRExRv2nq51CZqMD39bTHeHnq6/KDNFesqm9vUzfyYdzsQ7nSHgqWwMXBk6kvOM6MBq1R0aUUUUa6X18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6118
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KVGhhbmsgeW91IGZvciB5b3VyIGhlbHAgYW5kIHRoZSByZXZpZXcuIEni
gJlsbCBzdGFydCBhIG5ldyB0aHJlYWQgdG8gZGlzY3VzcyB0aGUgdGVzdCBzY3JpcHQuDQoNCkJl
c3QgUmVnYXJkcywNCkthbmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVt
YmVyIDIsIDIwMjUgMTo0NCBQTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVj
aC5jb20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2
ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lA
Z21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcN
Cj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxq
b2VsQGptcy5pZC5hdT47DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251
Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdu
dS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbU1BBTV0gW1BBVENIIHY1IDAwLzEwXSBhc3BlZWQ6IE9UUCBtb2RlbCwgU0JDIGlu
dGVncmF0aW9uLA0KPiB0ZXN0cywgYW5kIGRvY3MNCj4gDQo+IEhlbGxvIEthbmUsDQo+IA0KPiBP
biA4LzEyLzI1IDExOjM5LCBLYW5lIENoZW4gd3JvdGU6DQo+ID4gRnJvbTogS2FuZS1DaGVuLUFT
IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBl
eHRlbmRzIHRoZSBRRU1VIG1vZGVsIGZvciB0aGUgQVNQRUVEIE9UUCAoT25lLVRpbWUNCj4gPiBQ
cm9ncmFtbWFibGUpIG1lbW9yeSBkZXZpY2Ugd2l0aCBibG9jayBiYWNrZW5kIHN1cHBvcnQgYW5k
IHRpZ2h0ZXINCj4gPiBpbnRlZ3JhdGlvbiB3aXRoIHRoZSBTb0MgYW5kIG1hY2hpbmUgY29uZmln
dXJhdGlvbi4NCj4gPg0KPiA+IFRoZSBPVFAgbW9kZWwgc2ltdWxhdGVzIGEgc2ltcGxlIGZ1c2Ug
YXJyYXkgdXNlZCBpbiBBU1BFRUQgU29DcyBmb3INCj4gPiBzZWN1cmUgYm9vdCwgY29uZmlndXJh
dGlvbiwga2V5IHN0b3JhZ2UsIGFuZCB1c2VyLXByb2dyYW1tYWJsZSBkYXRhLg0KPiA+IFRoZSB1
cGRhdGVkIG1vZGVsIGFkZHMgc3VwcG9ydCBmb3IgbG9hZGluZyBpbml0aWFsIE9UUCBjb250ZW50
IGZyb20gYQ0KPiA+IGZpbGUgdmlhIHRoZSBRRU1VIENMSS4NCj4gPg0KPiA+IEV4YW1wbGUgdXNh
Z2U6DQo+ID4gICAgLi9xZW11LXN5c3RlbS1hcm0gXA0KPiA+ICAgICAgLW1hY2hpbmUgYXN0MjYw
MC1ldmIgXA0KPiA+ICAgICAgLWJsb2NrZGV2IGRyaXZlcj1maWxlLGZpbGVuYW1lPW90cG1lbS5p
bWcsbm9kZS1uYW1lPW90cCBcDQo+ID4gICAgICAtZ2xvYmFsIGFzcGVlZC1vdHAuZHJpdmU9b3Rw
IFwNCj4gPiAgICAgIC4uLg0KPiA+DQo+ID4gQW55IGZlZWRiYWNrIG9yIHN1Z2dlc3Rpb25zIGFy
ZSBhcHByZWNpYXRlZCENCj4gPg0KPiA+IEthbmUNCj4gPiAtLS0NCj4gPg0KPiA+IENoYW5nZUxv
Zw0KPiA+IC0tLS0tLS0tLQ0KPiA+IHY1Og0KPiA+IC0gQWRkIE9UUCBwcm9ncmFtbWluZyBzZW1h
bnRpY3MgYW5kIHRyYWNpbmcNCj4gPiAtIEludGVncmF0ZSBPVFAgaW50byBBU1QxMDMwIFNvQw0K
PiA+IC0gQWRkIENBTVAyIHJlZ2lzdGVyIHN1cHBvcnQgZm9yIHJlYWRpbmcgYm90aCBEV09SRHMg
b2YgT1RQIGRhdGENCj4gPiAgICBlbnRyaWVzDQo+ID4gLSBIYW5kbGUgdm9sdGFnZSBtb2RlIHdy
aXRlIGNvbW1hbmRzIHRvIGF2b2lkIG1pc3JlcG9ydGluZyB2YWxpZA0KPiA+ICAgIHJlcXVlc3Rz
IGFzICJVbmtub3duIGNvbW1hbmQiDQo+ID4gLSBBZGQgZnVuY3Rpb25hbCB0ZXN0IHRvIHZlcmlm
eSBmaXJtd2FyZSBib290IHdpdGggYSBwcmUtY29uZmlndXJlZA0KPiA+ICAgIE9UUCBpbWFnZQ0K
PiA+IC0gQWRkIGRvY3VtZW50YXRpb24gZm9yIE9UUCBtZW1vcnkgb3B0aW9ucyBpbiBRRU1VDQo+
ID4NCj4gPiB2NDoNCj4gPiAtIEFkZCBhICdkcml2ZScgcHJvcGVydHkgdG8gYWxsb3cgYmFja2lu
ZyBPVFAgZGF0YSB3aXRoIGEgYmxvY2sgZGV2aWNlDQo+ID4gLSBFeHBvc2UgYSBtYWNoaW5lIHBh
cmFtZXRlciAoYC1tYWNoaW5lIG90cG1lbT1YWFhgKSBmb3IgY29udmVuaWVudA0KPiA+ICAgIGFs
aWFzaW5nIG9mIHRoZSBPVFAgZHJpdmUgdmlhIFFPTSBwYXRoDQo+ID4NCj4gPiB2MzoNCj4gPiAt
IFN3aXRjaGVkIHRvIG9iamVjdF9wcm9wZXJ0eV9zZXRfaW50KCkgZm9yIHNldHRpbmcgInNpemUi
DQo+ID4gLSBTaW1wbGlmaWVkIHFkZXZfcmVhbGl6ZSgpIGVycm9yIGhhbmRsaW5nIGJ5IHBhc3Np
bmcgZXJycCBkaXJlY3RseQ0KPiA+IC0gQWRkZWQgImRyaXZlIiBwcm9wZXJ0eSB0byBPVFAgbW9k
ZWwgZm9yIGZ1dHVyZSBleHRlbnNpYmlsaXR5DQo+ID4NCj4gPiB2MjoNCj4gPiAtIFJlbmFtZSBk
ZXZpY2UgZnJvbSAnYXNwZWVkX290cG1lbScgdG8gJ2FzcGVlZF9vdHAnIGFuZCBtb3ZlIGl0IHRv
DQo+ID4gaHcvbnZyYW0vDQo+ID4gLSBNb3ZlIE9UUCBkZXZpY2UgcmVhbGl6YXRpb24gZnJvbSBp
bnN0YW5jZV9pbml0IHRvIHRoZSByZWFsaXplDQo+ID4gZnVuY3Rpb24NCj4gPiAtIEltcHJvdmUg
ZXJyb3IgbG9nZ2luZyB3aXRoIHFlbXVfbG9nX21hc2soKSBhbmQgcmVtb3ZlIHVudXNlZCBlcnJv
cg0KPiA+IHByb3BhZ2F0aW9uDQo+ID4NCj4gPiB2MToNCj4gPiAtIEluaXRpYWwgdmVyc2lvbg0K
PiA+DQo+ID4gLS0tDQo+ID4NCj4gPiBLYW5lLUNoZW4tQVMgKDEwKToNCj4gPiAgICBody9udnJh
bS9hc3BlZWRfb3RwOiBBZGQgQVNQRUVEIE9UUCBtZW1vcnkgZGV2aWNlIG1vZGVsDQo+ID4gICAg
aHcvbWlzYy9hc3BlZWRfc2JjOiBDb25uZWN0IEFTUEVFRCBPVFAgbWVtb3J5IGRldmljZSB0byBT
QkMNCj4gPiAgICBody9hcm06IEludGVncmF0ZSBBU1BFRUQgT1RQIG1lbW9yeSBzdXBwb3J0IGlu
dG8gQVNUMjYwMCBTb0NzDQo+ID4gICAgaHcvbnZyYW0vYXNwZWVkX290cDogQWRkICdkcml2ZScg
cHJvcGVydHkgdG8gc3VwcG9ydCBibG9jayBiYWNrZW5kDQo+ID4gICAgaHcvbnZyYW0vYXNwZWVk
X290cDogQWRkIE9UUCBwcm9ncmFtbWluZyBzZW1hbnRpY3MgYW5kIHRyYWNpbmcNCj4gPiAgICBo
dy9hcm06IEludGVncmF0ZSBBU1BFRUQgT1RQIG1lbW9yeSBzdXBwb3J0IGludG8gQVNUMTAzMCBT
b0NzDQo+ID4gICAgaHcvbWlzYy9hc3BlZWRfc2JjOiBBZGQgQ0FNUDIgc3VwcG9ydCBmb3IgT1RQ
IGRhdGEgcmVhZHMNCj4gPiAgICBody9taXNjL2FzcGVlZF9zYmM6IEhhbmRsZSBPVFAgd3JpdGUg
Y29tbWFuZCBmb3Igdm9sdGFnZSBtb2RlDQo+ID4gICAgICByZWdpc3RlcnMNCj4gPiAgICB0ZXN0
cy9mdW5jdGlvbi9hc3BlZWQ6IEFkZCBPVFAgZnVuY3Rpb25hbCB0ZXN0DQo+ID4gICAgZG9jcy9z
eXN0ZW0vYXJtL2FzcGVlZDogRG9jdW1lbnQgT1RQIG1lbW9yeSBvcHRpb25zDQo+ID4NCj4gPiAg
IGRvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0ICAgICAgICAgICAgICB8ICAzMSArKysrDQo+ID4g
ICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NiYy5oICAgICAgICAgICAgfCAgIDYgKw0KPiA+ICAg
aW5jbHVkZS9ody9udnJhbS9hc3BlZWRfb3RwLmggICAgICAgICAgIHwgIDMzICsrKysNCj4gPiAg
IGh3L2FybS9hc3BlZWRfYXN0MTB4MC5jICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICAg
aHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gICBo
dy9taXNjL2FzcGVlZF9zYmMuYyAgICAgICAgICAgICAgICAgICAgfCAxOTYNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gICBody9udnJhbS9hc3BlZWRfb3RwLmMgICAgICAgICAgICAg
ICAgICAgfCAxOTANCj4gKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L21pc2MvdHJh
Y2UtZXZlbnRzICAgICAgICAgICAgICAgICAgICB8ICAgNiArDQo+ID4gICBody9udnJhbS9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPiA+ICAgaHcvbnZyYW0vdHJhY2Ut
ZXZlbnRzICAgICAgICAgICAgICAgICAgIHwgICA1ICsNCj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwv
bWVzb24uYnVpbGQgICAgICAgICAgICB8ICAgMiArDQo+ID4gICB0ZXN0cy9mdW5jdGlvbmFsL3Rl
c3RfYXJtX2FzcGVlZF9vdHAucHkgfCAgNTUgKysrKysrKw0KPiA+ICAgMTIgZmlsZXMgY2hhbmdl
ZCwgNTMwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9ody9udnJhbS9hc3BlZWRfb3RwLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9udnJhbS9hc3BlZWRfb3RwLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVlZF9vdHAucHkNCj4gPg0KPiANCj4gSSB3aWxsIHF1
ZXVlIHBhdGNoZXMgMS04LDEwIGluIGFzcGVlZC1uZXh0LiBObyBuZWVkIHRvIHJlc2VuZC4NCj4g
DQo+IFBsZWFzZSBhZGRyZXNzIHRoZSBjb21tZW50cyBvbiBwYXRjaCA5IGluIGEgbmV3IHNlcmll
cywgQ2M6IFRob21hcy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+IA0K
PiANCg0K

