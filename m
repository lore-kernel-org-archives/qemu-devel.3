Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2805EC369AB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 02:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4sPh-0003sT-AW; Tue, 15 Apr 2025 22:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u4sPe-0003sB-PE; Tue, 15 Apr 2025 22:22:06 -0400
Received: from mail-psaapc01on2070c.outbound.protection.outlook.com
 ([2a01:111:f403:200e::70c]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u4sPY-0005nn-8b; Tue, 15 Apr 2025 22:22:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjBDioOMTnjuqJ1ncsn6nkAOKh9SRmiLOBPEjux4MtR1zxbVhmcHAAFRoGlaVpZkBeYDgKWcter1nr3ZE8gb9mkvt4Sh+uAODIzNobIAKauKzickR23g1x1zsJIipP3bDbK25yAlTaYRp0SU1WKp9OJkcXf3ZhS0fT1GSx+5Bo+FP4r35E0TdcQrxtpC5vAJ4P89xS8nk/2UyXMfZzomRpAZGmm5o8P9UcV2UkTP3LZYVW4/T/bhTvhapqs1zSM83T6Hx7Wlo333S2Rxj0a9rKIn/0ohy1pElB0cNzUQAzd9WiJKhK4iOFBJ8uUXBC5E7DodpFl77uZYhRP+LKV+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zakyszp4SZwLmipEe2e+SRJCDKXXQG6wVhr8cz6V6M=;
 b=BmvRm5ke+Fy8PSld/dLjko4Wq/VgWKRqgUjgmqVrPUPC0UOgCs7+McSkK5Mvj+zgsuTC3vPi95iSV5vauPGnT2pZepLC1mptklm8ZgvZSLl2e+2meQK9ApdUvux0h1gfmX09DeOfCAqJJyspE4VP280DCpyJZe2M1XDoFotYBLfin7koWXIgQQhYAtC21RZQ8bow48iAtV4AQ89ILHbSl3hXGNz2Txbo4zu5rFnGhvAYDz+tKlaMuj5kYYDWfe8KOTYhJfrUi4fcOPsqqzS4LDOsJ6vRzTY6ZlSsj5NfQU4IUMh0qPNevrI4dS4TBl0laEkoG1xRGw0DiwzXh6Av8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zakyszp4SZwLmipEe2e+SRJCDKXXQG6wVhr8cz6V6M=;
 b=kYrN7CH8h7CMgSN6kXOBFlKWvI+m6GdDsgogfJFx+UjzmVyS3kopuOL0pSw97wDPLYPftxUHRfQni03E97fSoPjmGSnNzPHao1VCUwMWmxhgaJ2FZUoP8YDlOY0cC9DU0Y2BRP+P52UZxU4XMMV2dyysjFkDkCqrElj+o0LW+NynNjCYaqCo/yzQCQ+nN50e967oGKFbCG9yzphyUeMWFNMz1rxyUUapmITjea7zAoMYE7Per/w0lQ+TvITw8tEU2mui+EGwyygd5AkuKfctdKlBGTsnxVsUkwxqL0R8V4RxiFRyvKOoX0UYih0Zz1CC/Kf2Uwt6JpDcNdnVLV2vvA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5780.apcprd06.prod.outlook.com (2603:1096:400:27f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.28; Wed, 16 Apr 2025 02:21:49 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 02:21:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Troy
 Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbqcG9me2omjhCUUi7MtZUDXpZTrOepD+AgAPfM9CAAS1ZAIAAxd8AgAB22ACAAKsUwA==
Date: Wed, 16 Apr 2025 02:21:49 +0000
Message-ID: <SI2PR06MB5041AC2091F55170EB85CFBBFCBD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-8-jamin_lin@aspeedtech.com>
 <860fbb39-feec-4c1d-b05f-aea7889a698f@kaod.org>
 <SI2PR06MB5041C73D934E10DEC9B66805FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CA+QoejUvnwZBqS6nJBi5y=g1-r+f=9SnDD4SQOL3kxqeMbS_cw@mail.gmail.com>
 <SI2PR06MB50413B875162D6ADD2F182ECFCB22@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CA+QoejWEn-B8E_QC-hAM87j_5TQXMYZRgDNUvq5qUTYUr9VQ-Q@mail.gmail.com>
In-Reply-To: <CA+QoejWEn-B8E_QC-hAM87j_5TQXMYZRgDNUvq5qUTYUr9VQ-Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5780:EE_
x-ms-office365-filtering-correlation-id: f13f8549-a013-4410-cefe-08dd7c8d716a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c3BmWFlGYjMwUTlET1NWcjRpc2xyMEhrU1gzUzBUeStUamg4SWVob2xLRUVv?=
 =?utf-8?B?dGg0cmRoOTlZZndRM2tkUnNCRnN0ZHRhUUR1bFZwY0pJWlJKRzNjZnpZKzJE?=
 =?utf-8?B?VW1vYUJ3UGVVNWRra05PTlhjVTk3T3NJTmx5RXR1V3BwTldkTzc0WGEwaEl6?=
 =?utf-8?B?Ump1Mkt5ZFZPUU5zNURYN054S090K3A1cnJkTjlzc2JiemRjeDgrbktKTXV1?=
 =?utf-8?B?bFUwaDVlR0p1Mk5uRkVKYlVYTHRyUzBXMWprYVlnRDlhbUpLa01acEYrR1dh?=
 =?utf-8?B?dXpDR3IxT0xxRWVKV2cxSTk3RHNRWHQxaDI3RUNEdllpcWtWeW4vTnhOYWM2?=
 =?utf-8?B?VWFVRWVncWFBcDRmbkY1ZEJ0NHQrQjY1SzRScDQweGwwczYyS05EbXZmNWZD?=
 =?utf-8?B?Ym83VUErUnNDbStSeHIrNFpTQzdaOEVicFNZWHdSall4NUliZjFBc2lYNE1Z?=
 =?utf-8?B?M09wcHI0OEdOV1Jsc2hsSXJPQUJPWXZ1R2VySmx0RStrcU1CSlViM0M3VzdN?=
 =?utf-8?B?MHE2TFZNWHBacm1lYy9NT2Y1WW5pWGpaejVpM3ZtN2w1ZFZYUTc3aG13NFND?=
 =?utf-8?B?ZlVOQnhKSUJYWjVIUURrNGx4RGdqN1lidnlHVG81T3VZaHFYT243SWt4VVZO?=
 =?utf-8?B?M05USHBGc1UrVE1OWDU1emF0T0cxOVpCMXBwenNtT2JOMzVEQUJ0YVgrUTNJ?=
 =?utf-8?B?Z0FTeG1lRjRjNXJxUVJpb2djWSt0ckRNTmdadUNFeG1uOWZyd0dGRWJVWUxB?=
 =?utf-8?B?WEtManlLMENqQ1NuTjJJWDhMU1lZMlAxMDJiaXBZa0dYc0JCellUb0hCNE5G?=
 =?utf-8?B?MEpsU0Judk43czc2cHZENWYwUUhPMGR0cGxXQ045Mjk0ZVZkNzBmV1IxaURi?=
 =?utf-8?B?MDFFaFIrc1FkWS9zbXNqeHlKcWFpUXlIbHp0UHJVemhQY0JBQU41L3lQWXZL?=
 =?utf-8?B?MEF1d2FWSjVURCtxSnJmTXpQM2hJRy8yQjFBT2V3WmxSc1pkN0N3Sm8zT1hF?=
 =?utf-8?B?dkRwTm5NMGZ6Q3d1TUVaRXg5MXk5eGpKa2hidmViYXdzb2J1TGVLTXg5VHFI?=
 =?utf-8?B?YU15enJUVHdqdTJkRmFTR0VnNXVHZjBtcmpCdHUwMnZRN3g4NUpnYi9WMzFL?=
 =?utf-8?B?S3hpMDNOenZTQmYyMjFwNEI0dzhoaFJjK2RjU2pGdzhhbnFKRUVCYTcwM2tl?=
 =?utf-8?B?ZUwvTys0VUpQRWJiQ05wd3NSZUptNDdaUSt2bGNhVytRMER5elJBQzJWOUs5?=
 =?utf-8?B?TGl3SENRL2hYdzJhZHZacXQ2a3pzRE5WYmRxbDVkUEdNeFFjUXhNeVZURVFZ?=
 =?utf-8?B?eGMvWHpDWERDYTdXTFR6VnVtNVltU0R5ZjFMWVJkaGxTeC9kejVHVW5vdmcv?=
 =?utf-8?B?TWpJRXhRN2VKUGEwNXpEK243SVBmZHpSV2Y4bEh5d2RZUzNnZUJVWHoyQzhK?=
 =?utf-8?B?d2UrZ2NXbzdWTVpmYnVZSGRUTGhVbTNHdW5Da3dRdDZMS3FPS0VETjV5N2pL?=
 =?utf-8?B?QldTbk8zcURGbnNVSFBNTEpzR3M1aEFEdCtud3BpTFV2ajIxTDRTNGdkWG9i?=
 =?utf-8?B?VktVK0krbW13U3RvSWpnbm56b1VlaVRuRjFVd1JvZ3UvSkIyZmxkWm9qV3J1?=
 =?utf-8?B?UUZJQmlybDlORTVBcUZyNUlhVGx5QzNjQS9DallHZURJRWtwY3Boa29pVWZi?=
 =?utf-8?B?dDFNaTNYR2ZaWlZ0ZGhNQlhlaHRoYld6bDlzbFAwemdzMVYrNkp1clM1TmxF?=
 =?utf-8?B?VWp1RWxCY3V5RW14TlE2WDRjdUF4QjhyLzlzSmFhWXFIOGZJZ25SWXoyUTYr?=
 =?utf-8?B?ZVhYWnJBNGJVeGRPdHJMM2Q2TTlJNDBOelkzb2YzSXVmZkZBbjV4RzlFT2Fz?=
 =?utf-8?B?YVZLTW04RUorSFNLQm9vT2xVdEgxRXZlUUUxcGJFd1JoL3pvZVNKWU1xeDNI?=
 =?utf-8?Q?eAowucVfFIU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG1YUy9Ca0hycTZOUzkxYVJUM1VoYzFmYkdRU1hJMVhvVlFIa1gxVkQrQUIz?=
 =?utf-8?B?ZkhuYjh5K255b0xYMXRSSEd5c3FMczRlcTVCZWc0MUFiSXNSd1d6RFk0NVZ4?=
 =?utf-8?B?V2w0SSs3cDFjdStnQUtLOGN2NGtaR2t4Q2ZGU2FsUllRcTFjSkx4Q0dsR25J?=
 =?utf-8?B?THNMVUdyenhYdExwYjgyYlBFcThxWUxxYXN6aTM4RkdacG9ycUVaczA1U2F3?=
 =?utf-8?B?WEhiMFpjQUNPYkZ0TmtrVFlNUVVkSEo1Q3ZGUmFnKzVmVlpMSEN1N3FEbk8w?=
 =?utf-8?B?RzhlS1hjN2hEVlZUME4zTmt1T01DWFBRTDVGZFlRUFJHWGZLL3VNUEVDdCt5?=
 =?utf-8?B?N2FLQVBpSGg3ZEV0anZuMjdud3Nwa0licHQ5RWYyUXdZcVhCZ1h2MGhSUERM?=
 =?utf-8?B?TkowRWdSRFhBQUt0VjgzS0ltaDI4NXZuS0VKRDJZTERrby9kL0pqOXJiOE55?=
 =?utf-8?B?dHVhVkdSSEp3Y3BtNXVhdVBPUU94UjNPcXl4bmF0VkJLVXZSS0cwallwc2Nq?=
 =?utf-8?B?ZW1zRHZoeDIxNkpNd0FZRVY1Ty9yaTlqTjBabXp4M0dEZXluVVNHb3NrRkRv?=
 =?utf-8?B?bTlrbmJseGVHc2lVRGJZaWovNGNJSGZjUU83bzBZVjFWUVlnV1hWaU4zWGxN?=
 =?utf-8?B?QWJRM0RMd2kvNGgvc1R4RWw5dlFURHpBeWJXcEdITFE1SStxUnBUb0FGSjBw?=
 =?utf-8?B?cUl6YU4vZ25qdFdCKzVSVEVqclRCZXJPSm9nbHowdjhSNlhZVGllQ0psdjlZ?=
 =?utf-8?B?dE5JeW5YbEpSelJEbG13VWpKSG9vVW5EbWZBaThXN1BYV1FiQnpsNVRMZFY2?=
 =?utf-8?B?R2E0dnpOaW94QnRxRXpvdzFmWTNxaEVySi9pZ1drYUdOd2VLNUxHUkd0UEU1?=
 =?utf-8?B?M2duZE9HckZneXF4eFlZUjhDNVkzbWpXSVRDOWRYNkRTb3lWRlZWeGtjbi9Z?=
 =?utf-8?B?Z2YxbDhBWmIra0ZLYVFMeGIwQ1ZEUDZaVzVPTy9PSlN2YkpmVlZlOHRoTzJB?=
 =?utf-8?B?T2NNOFFqekF5ZGlSUldIZXlZWGwzLzduUjJqSG0rVlkvUVU3L0k3aHlvSFEr?=
 =?utf-8?B?NzQrbEh0dnE0bEN3VDBLTk4xWVF5b0xySkZ0TFo1Z2s5czE1cHlKanB0aFV6?=
 =?utf-8?B?ellJb05LNENIUFNoWlQ3VDg5bVFOdHlzeHJXREFuMEsxMDM5Q3ptREdjTkRv?=
 =?utf-8?B?dnYxT0w1d0M0bW02WFlCQ1g5WmtraEJEaG5HSHczMmVuYlhQakpXVkYrY2lL?=
 =?utf-8?B?UzJLVUtyeENNYWhvUnp5M201Q2hGOFl5aDdEcll0OUVvQzdwQUw2aUJTZDlQ?=
 =?utf-8?B?UWJSQW1EVVFFSXRPcTY2a1Z6a2VScWZIOCtaRlJmSFdSY3hqa1FIZllOVTUw?=
 =?utf-8?B?YTF6ODdhQXlYR1g1RDFveUZ2Q1UyMGZVQ25KNGlwYXZFNTVvcExhU0xzL0Y5?=
 =?utf-8?B?Wi9rQzlDcTVuRGpac21JcHpmNURZM0NIOTBvc2pqRFg2OCsvWFV5TEVVL29T?=
 =?utf-8?B?Q0JBeVR3SWxpZVB3d1ZLS01paE5MdVg5eXZJNzhPRXRYRDV3ZitNQmVpdktm?=
 =?utf-8?B?SFA2ZjVBMWtpN3VrN3BDSHNxeEM1Tk9BZjZrNFlCWWVjaGZkU3pwYjljUVkx?=
 =?utf-8?B?TDFYdDJGOExaU3RBWklZbFZxbUVvS2NLOGh0QTNKd0puWkphT09vYkdva3U5?=
 =?utf-8?B?SnBQa25Zb3I2b1ZQMDQ5a0kvZkJNb3FTMU4reUhqSGZGRld6a1lueGVrMjNt?=
 =?utf-8?B?cytwbDJwbWRzZHdneUtqZ0xmZTNkQ282RnlUNlcyTlRWU29CRktYVXVmU0tm?=
 =?utf-8?B?RURUYTM0dXpwV0tteWd6LzhKYmhBQTI1WlVVWEFVTlhWMU9ueVI5ZjJwNWg2?=
 =?utf-8?B?dWc1eUVsdFJ4T2dyL1NENHJCaUcwZk9iYmduNm9uejQ0VlJSejFFbGw0NzBZ?=
 =?utf-8?B?UnM1K2dTUDNUaHBLWTFXSXFQa1NVOCtvWGRvMXR4eEVnN1FoTDhOTTc0NGho?=
 =?utf-8?B?MWVmSmtRcnZYazdBeU5BRVFydWovK0ZPdndoeDlpZE44TDdJL0ltUnhGTVp3?=
 =?utf-8?B?aUlncmR6Uml2TG1xM2IvQkpidFdHb3hzN3lDbEpodjg5NUNicXI4Y1ErL05H?=
 =?utf-8?Q?xs52NknLVoeIJqbA/NrIMtx1k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13f8549-a013-4410-cefe-08dd7c8d716a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 02:21:49.1086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McmJb1TgBAHFnSxsyqa5q47jSJuFNDTyB/ubI2dHXpM2xByKsh0zXJvS3iMSQ9cSfd6jQaeryvyfgurRRKm/FAN9kUSwkbVMlAoMgT3JmCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5780
Received-SPF: pass client-ip=2a01:111:f403:200e::70c;
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

SGkgTmFiaWgsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNy8xMF0gaHcvYXJtL2FzcGVl
ZDogQWRkIHN1cHBvcnQgZm9yIGxvYWRpbmcNCj4gdmJvb3Ryb20gaW1hZ2UgdmlhICItYmlvcyIN
Cj4gDQo+IEhpIEphbWluLA0KPiANCj4gDQo+IE9uIFR1ZSwgQXByIDE1LCAyMDI1IGF0IDI6MzXi
gK9BTSBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiBIaSBOYWJpaCwNCj4gPg0KPiA+ID4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDA3LzEwXSBody9hcm0vYXNwZWVkOiBBZGQgc3VwcG9ydCBmb3IgbG9hZGluZw0KPiA+ID4gdmJv
b3Ryb20gaW1hZ2UgdmlhICItYmlvcyINCj4gPiA+DQo+ID4gPiBIaSBKYW1pbiBhbmQgQ2Vkcmlj
LA0KPiA+ID4NCj4gPiA+IE9uIFN1biwgQXByIDEzLCAyMDI1IGF0IDg6MTfigK9QTSBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+
ID4gPiBIaSBDZWRyaWMsDQo+ID4gPiA+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAwNy8xMF0gaHcvYXJtL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yDQo+ID4gPiA+ID4gbG9hZGlu
ZyB2Ym9vdHJvbSBpbWFnZSB2aWEgIi1iaW9zIg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gNC8x
MC8yNSAwNDozOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+ID4gPiA+ID4gSW50cm9kdWNlICJhc3Bl
ZWRfbG9hZF92Ym9vdHJvbSgpIiB0byBzdXBwb3J0IGxvYWRpbmcgYQ0KPiA+ID4gPiA+ID4gdmly
dHVhbCBib290IFJPTSBpbWFnZSBpbnRvIHRoZSB2Ym9vdHJvbSBtZW1vcnkgcmVnaW9uLCB1c2lu
ZyB0aGUNCj4gIi1iaW9zIg0KPiA+ID4gPiA+IGNvbW1hbmQtbGluZSBvcHRpb24uDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICAgaHcvYXJtL2FzcGVl
ZC5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+
ID4gPiA+ID4gPiBiNzBhMTIwZTYyLi4yODExODY4YzFhIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0t
IGEvaHcvYXJtL2FzcGVlZC5jDQo+ID4gPiA+ID4gPiArKysgYi9ody9hcm0vYXNwZWVkLmMNCj4g
PiA+ID4gPiA+IEBAIC0yNyw2ICsyNyw3IEBADQo+ID4gPiA+ID4gPiAgICNpbmNsdWRlICJzeXN0
ZW0vcmVzZXQuaCINCj4gPiA+ID4gPiA+ICAgI2luY2x1ZGUgImh3L2xvYWRlci5oIg0KPiA+ID4g
PiA+ID4gICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4gPiA+ID4gPiA+ICsjaW5j
bHVkZSAicWVtdS9kYXRhZGlyLmgiDQo+ID4gPiA+ID4gPiAgICNpbmNsdWRlICJxZW11L3VuaXRz
LmgiDQo+ID4gPiA+ID4gPiAgICNpbmNsdWRlICJody9xZGV2LWNsb2NrLmgiDQo+ID4gPiA+ID4g
PiAgICNpbmNsdWRlICJzeXN0ZW0vc3lzdGVtLmgiDQo+ID4gPiA+ID4gPiBAQCAtMzA1LDYgKzMw
NiwzMiBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gPiA+IGFzcGVlZF9pbnN0YWxsX2Jvb3Rfcm9tKEFz
cGVlZE1hY2hpbmVTdGF0ZSAqYm1jLCBCbG9ja0JhY2tlbmQNCj4gPiA+ID4gPiAqYmxrLA0KPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgcm9tX3NpemUsICZlcnJvcl9hYm9ydCk7DQo+
ID4gPiA+ID4gPiAgIH0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArLyoNCj4gPiA+ID4gPiA+
ICsgKiBUaGlzIGZ1bmN0aW9uIGxvY2F0ZXMgdGhlIHZib290cm9tIGltYWdlIGZpbGUgc3BlY2lm
aWVkDQo+ID4gPiA+ID4gPiArdmlhIHRoZSBjb21tYW5kIGxpbmUNCj4gPiA+ID4gPiA+ICsgKiB1
c2luZyB0aGUgLWJpb3Mgb3B0aW9uLiBJdCBsb2FkcyB0aGUgc3BlY2lmaWVkIGltYWdlIGludG8N
Cj4gPiA+ID4gPiA+ICt0aGUgdmJvb3Ryb20NCj4gPiA+ID4gPiA+ICsgKiBtZW1vcnkgcmVnaW9u
IGFuZCBoYW5kbGVzIGVycm9ycyBpZiB0aGUgZmlsZSBjYW5ub3QgYmUNCj4gPiA+ID4gPiA+ICtm
b3VuZCBvcg0KPiA+ID4gbG9hZGVkLg0KPiA+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ID4gK3N0
YXRpYyB2b2lkIGFzcGVlZF9sb2FkX3Zib290cm9tKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwNCj4g
PiA+ID4gPiA+ICt1aW50NjRfdA0KPiA+ID4gPiA+ID4gK3JvbV9zaXplKQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gcGxlYXNlIGFkZCBhbiAnRXJyb3IgKionIHBhcmFtZXRlciBhbmQgbGV0IHRoZSBj
YWxsZXIgZGVjaWRlIHRvIGV4aXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gV2lsbCBh
ZGQuDQo+ID4gPiA+DQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gKyAgICBBc3BlZWRNYWNo
aW5lU3RhdGUgKmJtYyA9IEFTUEVFRF9NQUNISU5FKG1hY2hpbmUpOw0KPiA+ID4gPiA+ID4gKyAg
ICBjb25zdCBjaGFyICpiaW9zX25hbWUgPSBtYWNoaW5lLT5maXJtd2FyZTsNCj4gPiA+ID4gPiA+
ICsgICAgZ19hdXRvZnJlZSBjaGFyICpmaWxlbmFtZSA9IE5VTEw7DQo+ID4gPiA+ID4gPiArICAg
IEFzcGVlZFNvQ1N0YXRlICpzb2MgPSBibWMtPnNvYzsNCj4gPiA+ID4gPiA+ICsgICAgaW50IHJl
dDsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAgZmlsZW5hbWUgPSBxZW11X2ZpbmRf
ZmlsZShRRU1VX0ZJTEVfVFlQRV9CSU9TLA0KPiA+ID4gPiA+ID4gKyBiaW9zX25hbWUpOw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gV2hhdCBpZiB0aGUgdXNlciBkaWRuJ3QgcHJvdmlkZSBhbnkgLWJp
b3MgY29tbWFuZCBsaW5lIG9wdGlvbiA/DQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4NCj4g
PiA+ID4gV2lsbCB1cGRhdGUgdG8gc3VwcG9ydCBib3RoIHZib290cm9tIGFuZCBsb2FkZXIuDQo+
ID4gPg0KPiA+ID4gRm9yIHRoaXMgY2FzZSwgY291bGQgd2UgaGF2ZSBzb21ldGhpbmcgbGlrZSB0
aGUgbnBjbTh4eF9ib2FyZC5jDQo+ID4gPiB3aGVyZSB3ZSBoYXZlIGEgZGVmYXVsdCBib290cm9t
IGFuZCBvdmVycmlkZSBpdCB3aXRoIC1iaW9zPyBUaGF0DQo+ID4gPiB3b3VsZCBhbHNvIGZpeCB0
aGUgcXRlc3QgaXNzdWVzIHdpdGggdGhlIGFzdDI3MDAgcXRlc3RzIHdoaWNoIGZhaWwgd2l0aCB0
aGlzDQo+IHBhdGNoc2V0Lg0KPiA+ID4NCj4gPiBEbyB5b3UgbWVhbiB0aGF0IGlmIHRoZSB1c2Vy
IGRvZXMgbm90IHNwZWNpZnkgIi1iaW9zIiwgd2Ugc2hvdWxkIHN0aWxsIGxvYWQgYQ0KPiBkZWZh
dWx0IHZib290cm9tIGltYWdlIGludG8gdGhlIHZib290cm9tIG1lbW9yeSByZWdpb24/DQo+ID4g
V2UgY2FuIHZlcmlmeSB3aGV0aGVyIC1iaW9zIHdhcyBwcm92aWRlZCBieSBjaGVja2luZyBpZiBt
YWNoaW5lLT5maXJtd2FyZQ0KPiBpcyBOVUxMLg0KPiA+IEl0IHNlZW1zIHRoYXQgaWYgdGhlIHVz
ZXIgZG9lc24ndCBwcm92aWRlIC1iaW9zLCBOUENNIFFFTVUgd2lsbCBsb29rIGZvciBhDQo+IGRl
ZmF1bHQgdmJvb3Ryb20gaW1hZ2UgaW4gdGhlIGN1cnJlbnQgd29ya2luZyBkaXJlY3Rvcnkg4oCU
IGlzIHRoYXQgY29ycmVjdD8NCj4gPg0KPiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Js
b2IvbWFzdGVyL2h3L2FybS9ucGNtOHh4X2JvYXJkcy5jI0wzNw0KPiANCj4gWWVhaC4gSUlVQyB0
aGUgZGVmYXVsdCBmdW5jdGlvbmFsaXR5IHNob3VsZCBiZSB0byB1c2UgYSB2Ym9vdHJvbSB0byBi
b290IHdpdGgNCj4gdGhlIEFTVDI3WDAgc28gaWYgdGhlcmUgaXMgbm8gYm9vdHJvbSBkZWNsYXJl
ZCB3ZSBzaG91bGQgZGVmYXVsdCB0byB0aGUgb25lDQo+IHlvdSBjcmVhdGVkLiBmb3IgdGhlIE5Q
Q00gb25lLCBpZiB3ZSBkb24ndCBwcm92aWRlIGJpb3MgaXQgd2lsbCBkZWZhdWx0IHRvIHRoZQ0K
PiBvbmUgaW4gcGMtYmlvcyBzaW5jZSBpdCdzIHN1cHBvc2VkIHRvIGJlIHRoZSBiYXNlIHRydWUg
dmVyc2lvbi4NCj4gSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBkbyB0aGUgc2FtZSB0aGluZyBp
biBhc3QyNzAwLiBJZiB3ZSByZWFsbHkgZmluZCB1c2UgaW4NCj4gc3VwcG9ydGluZyBhdHRhY2hp
bmcgdGhlIGxvYWRlciBiaW5hcmllcyBzZXBhcmF0ZWx5IHdlIGNvdWxkIGFkZCBhIGZsYWcgdGhh
dA0KPiBza2lwIHRoZSB2Ym9vdHJvbSwgYnV0IEkgZG9uJ3Qgc2VlIG11Y2ggdXNlIGluIHRoYXQg
c2luY2UgdGhlIGluZm9ybWF0aW9uIHRoYXQNCj4gd291bGQgY2hhbmdlIGlzIGluIHRoZSAiaW1h
Z2UtYm1jIi4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uIGFuZCByZXZpZXcuDQpX
aWxsIGFkZCBpbiB2My4NCg0KPiA+DQo+ID4gYGBgDQo+ID4gY29uc3QgY2hhciAqYmlvc19uYW1l
ID0gbWFjaGluZS0+ZmlybXdhcmUgPzogbnBjbTh4eF9kZWZhdWx0X2Jvb3Ryb207DQo+ID4gYGBg
IENvdWxkIHlvdSBsZXQgbWUga25vdyB3aGljaCBxdGVzdChzKSBmYWlsZWQsIHNvIEkgY2FuIHJ1
biB0aGVtIGFuZA0KPiA+IHZlcmlmeSBldmVyeXRoaW5nIGJlZm9yZSBzZW5kaW5nIG91dCB0aGUg
djMgcGF0Y2g/DQo+IA0KPiBxZW11OnF0ZXN0K3F0ZXN0LWFhcmNoNjQgLyBxdGVzdC1hYXJjaDY0
L2FzdDI3MDAtZ3Bpby10ZXN0DQo+IHFlbXU6cXRlc3QrcXRlc3QtYWFyY2g2NCAvIHF0ZXN0LWFh
cmNoNjQvYXN0MjcwMC1zbWMtdGVzdA0KPiANCj4gVGhleSBib3RoIGZhaWwgd2l0aCAiIHFlbXUt
c3lzdGVtLWFhcmNoNjQ6IENvdWxkIG5vdCBmaW5kIHZib290cm9tIGltYWdlDQo+ICcobnVsbCkn
ICIgc28gc2V0dGluZyB0aGUgZGVmYXVsdCBib290cm9tIHNob3VsZCBmaXggdGhpcy4NCj4gDQoN
CkkgY2FuIHJlcHJvZHVjZSB0aGlzIGlzc3VlLiBUaGFua3MgZm9yIHRlc3RpbmcuDQpXaWxsIGZp
eCBpbiB2My4NCg0KSmFtaW4NCg0KPiA+DQo+ID4gVGhhbmtzLUphbWluDQo+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gPiA+ICsgICAgaWYgKCFmaWxlbmFtZSkgew0KPiA+ID4gPiA+ID4gKyAgICAgICAg
ZXJyb3JfcmVwb3J0KCJDb3VsZCBub3QgZmluZCB2Ym9vdHJvbSBpbWFnZSAnJXMnIiwNCj4gPiA+
IGJpb3NfbmFtZSk7DQo+ID4gPiA+ID4gPiArICAgICAgICBleGl0KDEpOw0KPiA+ID4gPiA+ID4g
KyAgICB9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgIHJldCA9IGxvYWRfaW1hZ2Vf
bXIoZmlsZW5hbWUsICZzb2MtPnZib290cm9tKTsNCj4gPiA+ID4gPiA+ICsgICAgaWYgKHJldCA8
IDApIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiRmFpbGVkIHRvIGxvYWQg
dmJvb3Ryb20gaW1hZ2UgJyVzJyIsDQo+IGZpbGVuYW1lKTsNCj4gPiA+ID4gPiA+ICsgICAgICAg
IGV4aXQoMSk7DQo+ID4gPiA+ID4gPiArICAgIH0NCj4gPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiAgIHZvaWQgYXNwZWVkX2JvYXJkX2luaXRfZmxhc2hlcyhBc3BlZWRT
TUNTdGF0ZSAqcywgY29uc3QgY2hhcg0KPiA+ID4gPiA+ICpmbGFzaHR5cGUsDQo+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGNv
dW50LA0KPiA+ID4gPiA+ID4gaW50DQo+ID4gPiA+ID4gdW5pdDApDQo+ID4gPiA+ID4gPiAgIHsN
Cj4gPiA+ID4gPiA+IEBAIC00ODMsNiArNTEwLDExIEBAIHN0YXRpYyB2b2lkDQo+ID4gPiA+ID4g
PiBhc3BlZWRfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZQ0KPiA+ID4gPiA+ICptYWNoaW5lKQ0K
PiA+ID4gPiA+ID4gICAgICAgICAgIH0NCj4gPiA+ID4gPiA+ICAgICAgIH0NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiArICAgIGlmIChhbWMtPnZib290cm9tKSB7DQo+ID4gPiA+ID4gPiArICAg
ICAgICByb21fc2l6ZSA9IG1lbW9yeV9yZWdpb25fc2l6ZSgmYm1jLT5zb2MtPnZib290cm9tKTs+
DQo+ID4gPiA+ID4gPiArICsNCj4gPiA+ID4gPiBhc3BlZWRfbG9hZF92Ym9vdHJvbShtYWNoaW5l
LCByb21fc2l6ZSk7DQo+ID4gPiA+ID4gPiArICAgIH0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEV2ZW4gd2l0aG91dCBhIHZib290cm9tIGZpbGUsIHRoZSBtYWNoaW5lIGNv
dWxkIGJvb3Qgd2l0aCAnLWRldmljZQ0KPiBsb2FkZXInDQo+ID4gPiA+ID4gb3B0aW9ucy4gV2Ug
c2hvdWxkIHByZXNlcnZlIHRoaXMgd2F5IG9mIGJvb3RpbmcgYW4gYXN0MjcwMC1ldmINCj4gbWFj
aGluZS4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBXaWxsIHN1cHBvcnQgYm90aCBsb2Fk
ZXIgYW5kIHZib290cm9tLg0KPiA+ID4gPiBUaGFua3MgZm9yIHJldmlldyBhbmQgc3VnZ2VzdGlv
bi4NCj4gPiA+ID4NCj4gPiA+ID4gSmFtaW4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcywN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IEMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgIGFybV9sb2FkX2tlcm5lbChBUk1fQ1BVKGZp
cnN0X2NwdSksIG1hY2hpbmUsDQo+ID4gPiA+ID4gJmFzcGVlZF9ib2FyZF9iaW5mbyk7DQo+ID4g
PiA+ID4gPiAgIH0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gQWxzbywgdGVz
dGVkIGFnYWluc3Qgb3VyIGN1c3RvbSBtYWNoaW5lICsgY3VzdG9tIGJtYyBpbWFnZSBhbmQgdGhl
DQo+ID4gPiBib290cm9tIGl0c2VsZiB3b3Jrcy4NCj4gPiA+IEkgdGhpbmsgaXQgbWlnaHQganVz
dCBuZWVkIHRoYXQgZGVmYXVsdCBzZXQuDQo+ID4gPg0KPiA+ID4gVGVzdGVkLUJ5OiBOYWJpaCBF
c3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gTmFiaWgN
Cg==

