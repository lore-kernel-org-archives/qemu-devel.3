Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25171C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 03:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkx1O-0005ZC-Lw; Wed, 19 Feb 2025 22:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tkx1M-0005Yx-8W; Wed, 19 Feb 2025 22:14:40 -0500
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tkx1J-0008Tv-9o; Wed, 19 Feb 2025 22:14:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFtVNxErdhPo1AGQ2bY4jZhelntlljoIJzS8tDmhkJ9HXfCOe4c/fCsdAy4ZVJyPN7P2btp3d5UzisVOV7Z53mVXeB57rBFrHhtmOSOJFr163sOOvs9ym1Udfnt4oyz05H1xOBH15PE30CwIS893Nt5+XsGvcvw2aXuCN6IoCEv8D0zx7EXd/nR2FdzQKQ8nyzcNumBC6CZ2dJcVdV2lU2tF1Xon+dpOmICULySdOjglZjxincmI046LgXCAei4AzOvUPBmlQGKMlyF1ykK0ikKhezaXzj9z2JvCZMrJGM/dfyhA1l4eFSdkZUG+5uq2qGSE6ONCWqZKoYF0pottng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsMoZZ4iS7E04LWk+68LDyaCmA1tThXPUfmOIWenufY=;
 b=wfPj0mFyDujt7QAmh6jucy0jBLCAkhwyAdm0Hm2KKHHc095Ko+cEhGQH3i/5uwVxy6hnPoAp/A6piJe9qGvej4M7IkOwpIzMFBf6YQoMtERyKw0Ylu8rJKrAgh0J4lnDOXGbEGcKMrD4i5FmpM8Rkf0qNqNlBC4VRh9Dr1TIp4bTmp7ZpfULr9R2hbJbrxmCCcXAyoPgiGZKdABhEJxl0hqH/XklHySBDveFVFoc5RI44Khahk5mhvnPVizLQpkwKJ4tQPjklT2LonZF0gujs6B4hS+p/zmiEpR25zyFw2GC+f/kJHwPzMDb9P8bJGJoRb7lz62oDprea5vF5S9abw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsMoZZ4iS7E04LWk+68LDyaCmA1tThXPUfmOIWenufY=;
 b=HNCrdhdLixULuXegmica0eBYujMDEgsRU/8dKMcSO8LhRjODpS6qC8wQCgwR+G2J2GwAwNFHW0Y6LHpOPKKCnycYNsxdRntmH0Q0rHzjvftAtSX+bOxWgmkBHY8HB0w1JiT5uF0bzNHjpaSHtXhhcrcdhSuIDQlGehcROkVq8HimQ6EC1fQQu8JnqDAG+TPOr5Skd4F/5g5hYRm9bUVi/Q3KhShH5O1hgqnxQbEeL9Nrt1kz6vSq7M+OKzAuZy9WGEI6HpwqQZY5ig4vUrvlnCphaw4pzDTvbLSBnAoTW9lY75mN6JQqXkWI0Id0inca2gPjZSxRHrfJBV/fINQmUw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5414.apcprd06.prod.outlook.com (2603:1096:101:65::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.9; Thu, 20 Feb 2025 03:14:21 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.009; Thu, 20 Feb 2025
 03:14:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 11/28] hw/intc/aspeed: Introduce IRQ handler function
 to reduce code duplication
Thread-Topic: [PATCH v3 11/28] hw/intc/aspeed: Introduce IRQ handler function
 to reduce code duplication
Thread-Index: AQHbfchgQ3NR4N8xFUWpxf4JmjhMmrNM0D0AgAK+/xA=
Date: Thu, 20 Feb 2025 03:14:20 +0000
Message-ID: <SI2PR06MB5041164AE512E11508B722C7FCC42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-12-jamin_lin@aspeedtech.com>
 <5ec569c6-f7a7-4a0d-b60e-abb727cf1330@kaod.org>
In-Reply-To: <5ec569c6-f7a7-4a0d-b60e-abb727cf1330@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5414:EE_
x-ms-office365-filtering-correlation-id: 6d9c1fb8-9005-4307-6f3e-08dd515cab25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SFh5Y0x2dzdIempRa1NBL2N4S1V5MThzWFdQeHVOK3ozSGovN0szZGdnZlNG?=
 =?utf-8?B?SFVLc2phWU5xeXAyamZpbEFsSVdONEdLZlNRQ0FROUFXUXZsNFRDbXdEYlo2?=
 =?utf-8?B?SnViYWtjbExuVjJRMHdBRU1HY1h1Y2xiUDltSEptTkl5UUVxeklTWXJMNCtm?=
 =?utf-8?B?cjhsQzFnb2RIZWdVNUduVUN3WDM1N3A2SHFGdk9ZTHI4SFRWKzJWakNieEIw?=
 =?utf-8?B?U0hhZGZmNkhVZTRXeWovMm1vT2RuVncySHNMREYrelNEQW9lelZMcUdUVkc1?=
 =?utf-8?B?Zi9NdXB5K1dOQ2U5SVhqL0dBZlc4MSttd1pCNUhRTzBNbFBjM2s0Tk9rUzB4?=
 =?utf-8?B?bFRBMDZNMjVQZWxnQ09oTHJoL0JiUVJnT2c2UnFHeDIxdk1VemI1d2lEcDJW?=
 =?utf-8?B?QVBwbGtJTE5qRkxINFpiZ01VMGdvc0ZQUTBoR0NPS2R2ejBrVWM1RGV1Y0R2?=
 =?utf-8?B?Z3lPT1dVMy9LNWYwR1Y4djloUDcxNGhHU1ZYSGtPNk1JUU52NkJGU1QvUk5i?=
 =?utf-8?B?V3dDb3hwcVU2UWJ1VVlpc1FRS09jL2tTaUpNa1BBKzZPdndlRVREZTFpeE9o?=
 =?utf-8?B?Zy9BYmw3N2QzaEVJdTFMaURLR083Q1JNWTVhWkxsa21ZdnRqS0R4L2xKeURU?=
 =?utf-8?B?bC9jT293OFhIOHZ3NGpNQXM0TXBLOXdGdFRMaVNkTlZZb1ZIU3hjbzBicFZD?=
 =?utf-8?B?Z3JtOVd4cGxIY2RZVysvRlNsNElqRlNlS0NObnQ0UDhVenp2WFBoOVlVdnR4?=
 =?utf-8?B?VTFiZWJqWjhWTGJHK2dxWGtiT0xPWERMWStablBIK0lZU0hWRWRsYWdwdTQ4?=
 =?utf-8?B?ZzVaY3NUQmtvdW12VTlveXFlWThYZURtcjZUWUozeU1COWZnemN2bkk2N0hq?=
 =?utf-8?B?TG5FOXpvS2tKc1IwQldXWFd5ZnlEa2hNcWdMMU1MUTR6cDNDNUhZL21ZaGpN?=
 =?utf-8?B?WjgwdVR6VWNLVTFIZlVGYVRjZ090UUdyUSszRjIrYWRPeU1CdFQvT0hKcmlx?=
 =?utf-8?B?b3lzcGM1Ui9CQzUrMXlYbTRHNGNOaU9obFRiM00xbytoNWJRWCtBTWZZMDFx?=
 =?utf-8?B?SW1JTDZSUk5FRk83bDVSbEZrYjY1bFB2bUlOclJiWnVEcFZubUJDUHM1czV0?=
 =?utf-8?B?UEJFRkRqUkVpeUxHQ3lHRFZxeElSbnd3eDFoRVBaWVliN2JoNWt4N3pGUkRp?=
 =?utf-8?B?ZnFlQ2tFZi9BeXNNNVZUWVlYUnd5NTlLQklVSzBZTkJWY3AvRkxmV2FBWHRq?=
 =?utf-8?B?bm4zTTVSRWJaSFN0NmszYndnWGgxU3dZVU5wMVlQWTVjSEZiUTdCU3JuejFQ?=
 =?utf-8?B?Y2lnQUYvQmM0Zys0clltZVlpOGJYMzUyVnlkakVEWWhGaW11am1qOGtkY3hs?=
 =?utf-8?B?cnRkODJNNWtJQTd3dnh0N3pmUHVqb0hMK2d0WEU2NWpnN2MwYk92aUlOQUtW?=
 =?utf-8?B?K2xxeGd0alIvYWMyeW04dFROejJJYnVFUVRLell6cE5OTld6YlZkUEoyUTd3?=
 =?utf-8?B?RXFCdDdrY09adXJHZExKdC9PUXFZdWxuT0tkOU5QZDAyRERtTy85ZG5DeU9S?=
 =?utf-8?B?VS9iRFZlc2lZOHFGSXRLM3pOTXJud3dRZ1Q3bzJnUjlzeTRUQlV1NjhSbFRq?=
 =?utf-8?B?dFVnMnFYRG9TQmZBSjAzM3JxalFURW5LN3J0bTNrUWg1RWlDNWJkSDBQSnNx?=
 =?utf-8?B?WTZvK2RNY3hkZU8yaXpuNnB0NXA2K0NpQnN1aFFzaVdtT3NsVndwMzluVS93?=
 =?utf-8?B?bkc4VlNNeHp6WTN5VFNqbm9tREkwZ09keGxtY0VXWkQ1S09DSHRHbGR1NTd6?=
 =?utf-8?B?YXAvOGI2cXFlajVwelJlR3BOR0p6Nk5FVFREVXE5dXRJZmFIVTVNYnoxN1Ir?=
 =?utf-8?B?WjVOM2Q3aUNtd0tHSXFFb2tZY244K2tqNldNRW9UWnkwZjFGajNzWjM3dlk4?=
 =?utf-8?Q?rkzAdNW881u0HhqXhYt2WYYuxrdEWLzf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnJrZlllRjlVMXl3UjYwUS9lcUo3OHBHSkxtd1dwZnBCaXhVaW1taEwrUmty?=
 =?utf-8?B?dHoxajF0QjR5bkNKRlJhc3dKZ016N3o1M1JVdmtTNGsvaVdnc3NIVXB0aUVH?=
 =?utf-8?B?eTYxOTRmRjc5QS9PK2s0dXo5a2RRMm5KZzV6MjJBdGx0SjU5SVJJY2xZSWJB?=
 =?utf-8?B?U3BtT25zMlZPeE1hWVBjSk04eDRGRWZZV0tCQ1pBVTVDZFlzM0dkSnBDZG5P?=
 =?utf-8?B?aDVpbkh0MDhpdFVmWHVlRDBkREhFNmQ3ZlFKRWhEQkdwZk9yM01PTzNGdS92?=
 =?utf-8?B?NUxCVmRLWFEwb0svMVhOVGZ3ZlVzamZzQXNjZzRaeHRBa3VRbGZuU0FEUDlm?=
 =?utf-8?B?L21BWnBsQXl5VFlrcEN1RStLVElEcStEMC9KNWF1VndDakR3MWpqSm1JMUM3?=
 =?utf-8?B?OHJaQnRwSWhCQklRZXBxZ3ZuYjE2VlNFNVdGUWdIK29TSlc1Nm14QTFKaTQ5?=
 =?utf-8?B?and6SVBYelRsUEJsRkdzWUVlU1lDMXVKWGt2MDhaZEdld3lLMkhDVDZvM3Ft?=
 =?utf-8?B?MWJaT0UzRTkyZ0g5S1UyTXR2U2h0QlIvTHpXekRuZmZGY3A5cG9lQWJGWjdF?=
 =?utf-8?B?enc5cXVERVZzNFdvZmh1bWlhLzd2NGkrWjRBVTQyd0N5THdzdkdWSU92TzA1?=
 =?utf-8?B?dDJ0azJVUmZndFlCMUdJTm1lZ1hCRmlwcGt3TnNLam5VKzgxdUt0VDhZN0dk?=
 =?utf-8?B?L2lmYzdaU2VBa3dqRStCdnNWN3FSbTZWWjEzSkRORzVRMUFDb0VFeFlST2pY?=
 =?utf-8?B?VmtySkoxRWdldmR0dVA2ZDZMVGd4QUtLalkrQlpEcVJrRXZSVXE5Um9Hc0lw?=
 =?utf-8?B?YW95SCtVa3lyQlJTWTZ5a3VBMUJhZWorQ1pZMVlCZ3lTSmhOdTZBRHhpYXho?=
 =?utf-8?B?dVE4TE5EYWcwc0tWOG5jd2JRS3dHbVZzdFMycFhQSWx6dTFpU05TelVkQ1Vn?=
 =?utf-8?B?dHd4YSt0UDJWcERLRGZYMHVRRDcwL0RPaktOY3ltQ3FzOVQ3cU92eUVwSnAw?=
 =?utf-8?B?bWhhY2NZenJ4VGZDcDJ5MSs0V2hSMGNGVkIzNXUvbnU5S0lwbjZJMkVtTGFh?=
 =?utf-8?B?Mm1jc3M4VitHVGhzck50c0VEYmtiN2svekxscENWdFhSUFd2Q0p6RHR0eXpH?=
 =?utf-8?B?M09NMVNyY0xXWFVLazU2K0tCQS9vQVhjNSt2U2dzTFJWUkczM0liOTl4NHNV?=
 =?utf-8?B?T0FYdkNOc1dOQ29WSnkzRDVqcHFETnozUGNZcU8xNkZYc2tMV0txWC9kaUpl?=
 =?utf-8?B?cndoT2RmNGxrN0s4VFIvcFROeVY1bGxBbXBFdTFOSjdUKzhDTEgyeW4zKzMy?=
 =?utf-8?B?ZDdwQTk4ZGhGNjJNNjhLUjVudUtKZnNFZ0FyM2RVdW1WZFdHV2RsRC9pb3BB?=
 =?utf-8?B?aEN3eG9UckZOdGpZNldjb0lxWFVDc1d2VUNwZjJWSEtVWkVuTGdiUDZSdndl?=
 =?utf-8?B?OXRHWE9obkZ5USszajhTSUFYZ0w1U3dQNzUxZGdXKzFVN1RXQ04xWjRsckg3?=
 =?utf-8?B?cmtaclZBd0dTUmN5SmJPNmkrc0R2OXUzOFZlOWJVWVJvZVF3Nk5KUm5CRmNU?=
 =?utf-8?B?cTNYSGpiMGsxSCtYTzVUeFlQR3krN0xFMTgxUWRhVlVxbVFtRWpoaDNPNm1h?=
 =?utf-8?B?cnROK0N2R2xNWDlhZHpVWEpzVVhGLzU1dmwxMXFySGpWQks4Wm91bVBEMnhG?=
 =?utf-8?B?RUxsVVlvYlZwQUV5YU5mRjlZekx5emEweEQ2UE5zUThFNWZMajRDRmJUVjRn?=
 =?utf-8?B?Z3FoaFNVd0FxanBScWViL1JOaGYvSHZDTnY4SEVxTlhiR0J2V0g2QXpiOGZU?=
 =?utf-8?B?dFM0SS9Tc1VxaXlPdWZCTmdjSUlKZFE2VWVXazJxSUFTa1pWYjdoZnFURW5z?=
 =?utf-8?B?L3I5dkE5bGxYU0FrSy9XdWZKWWNjcUM2ZTEwUi9tNnd3YThIQlh3VmdOVHhU?=
 =?utf-8?B?YWVYT2h1dGMwRkVqYXJyN2FobGJsc21RdlVzKyt2NkZOODNrc25TVU1KV0hp?=
 =?utf-8?B?OGkyeE5zc3pOWTFjMWRpZ1FrQ3pUTzdXbE9acS9LWTF5Y0lNRDRyZVB0bDdZ?=
 =?utf-8?B?Y0ZKbGRDQzZyTDZDcmFQdjB4WnZnYm4xWlpjVkJNUEhaUUFqU2NWbjR6aWlk?=
 =?utf-8?Q?2HE+ffz0NMxp4XsoM/8dcPr56?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9c1fb8-9005-4307-6f3e-08dd515cab25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 03:14:20.6527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjy0Fhc4oM4myYXzoP5i4dwLWBPPbT+RRRZcTE1hLR/TGIWU9nDVMZ5LtLw8GQmvECmoc0OcoFOoMWRYGQyxGLfq31CaUGLcziQpnAQ9jrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5414
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KDQo+IA0KPiBJdCdzIGdvb2QgcHJhY3RpY2UgdG8gYWRkICJObyBmdW5j
dGlvbmFsIGNoYW5nZSIuDQo+IA0KPiBSZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoNClRoYW5rcyBmb3Ig
eW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpJIHdpbGwgYWRkICJObyBmdW5jdGlvbmFsIGNo
YW5nZSIgaW4gY29tbWl0IGxvZy4NCkphbWluDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9pbnRj
L2FzcGVlZF9pbnRjLmMgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9hc3BlZWRfaW50Yy5jIGIvaHcv
aW50Yy9hc3BlZWRfaW50Yy5jIGluZGV4DQo+ID4gNTljMTA2OTI5NC4uZmQ0Zjc1ODA1YSAxMDA2
NDQNCj4gPiAtLS0gYS9ody9pbnRjL2FzcGVlZF9pbnRjLmMNCj4gPiArKysgYi9ody9pbnRjL2Fz
cGVlZF9pbnRjLmMNCj4gPiBAQCAtOTIsMTEgKzkyLDQwIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9p
bnRjX3VwZGF0ZShBc3BlZWRJTlRDU3RhdGUgKnMsDQo+IGludCBpbnBpbl9pZHgsDQo+ID4gICAg
ICAgcWVtdV9zZXRfaXJxKHMtPm91dHB1dF9waW5zW291dHBpbl9pZHhdLCBsZXZlbCk7DQo+ID4g
ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX2ludGNfc2V0X2lycV9oYW5kbGVyKEFz
cGVlZElOVENTdGF0ZSAqcywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IEFzcGVlZElOVENJUlENCj4gKmludGNfaXJxLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qgc2VsZWN0KSB7DQo+ID4gKyAg
ICBjb25zdCBjaGFyICpuYW1lID0gb2JqZWN0X2dldF90eXBlbmFtZShPQkpFQ1QocykpOw0KPiA+
ICsNCj4gPiArICAgIGlmIChzLT5tYXNrW2ludGNfaXJxLT5pbnBpbl9pZHhdIHx8IHMtPnJlZ3Nb
aW50Y19pcnEtPnN0YXR1c19hZGRyXSkgew0KPiA+ICsgICAgICAgIC8qDQo+ID4gKyAgICAgICAg
ICogYS4gbWFzayBpcyBub3QgMCBtZWFucyBpbiBJU1IgbW9kZQ0KPiA+ICsgICAgICAgICAqIHNv
dXJjZXMgaW50ZXJydXB0IHJvdXRpbmUgYXJlIGV4ZWN1dGluZy4NCj4gPiArICAgICAgICAgKiBi
LiBzdGF0dXMgcmVnaXN0ZXIgdmFsdWUgaXMgbm90IDAgbWVhbnMgcHJldmlvdXMNCj4gPiArICAg
ICAgICAgKiBzb3VyY2UgaW50ZXJydXB0IGRvZXMgbm90IGJlIGV4ZWN1dGVkLCB5ZXQuDQo+ID4g
KyAgICAgICAgICoNCj4gPiArICAgICAgICAgKiBzYXZlIHNvdXJjZSBpbnRlcnJ1cHQgdG8gcGVu
ZGluZyB2YXJpYWJsZS4NCj4gPiArICAgICAgICAgKi8NCj4gPiArICAgICAgICBzLT5wZW5kaW5n
W2ludGNfaXJxLT5pbnBpbl9pZHhdIHw9IHNlbGVjdDsNCj4gPiArICAgICAgICB0cmFjZV9hc3Bl
ZWRfaW50Y19wZW5kaW5nX2lycShuYW1lLCBpbnRjX2lycS0+aW5waW5faWR4LA0KPiA+ICsNCj4g
cy0+cGVuZGluZ1tpbnRjX2lycS0+aW5waW5faWR4XSk7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+
ICsgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICogbm90aWZ5IGZpcm13YXJlIHdoaWNoIHNvdXJj
ZSBpbnRlcnJ1cHQgYXJlIGNvbWluZw0KPiA+ICsgICAgICAgICAqIGJ5IHNldHRpbmcgc3RhdHVz
IHJlZ2lzdGVyDQo+ID4gKyAgICAgICAgICovDQo+ID4gKyAgICAgICAgcy0+cmVnc1tpbnRjX2ly
cS0+c3RhdHVzX2FkZHJdID0gc2VsZWN0Ow0KPiA+ICsgICAgICAgIHRyYWNlX2FzcGVlZF9pbnRj
X3RyaWdnZXJfaXJxKG5hbWUsIGludGNfaXJxLT5pbnBpbl9pZHgsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50Y19pcnEtPm91dHBpbl9pZHgsDQo+ID4gKw0K
PiBzLT5yZWdzW2ludGNfaXJxLT5zdGF0dXNfYWRkcl0pOw0KPiA+ICsgICAgICAgIGFzcGVlZF9p
bnRjX3VwZGF0ZShzLCBpbnRjX2lycS0+aW5waW5faWR4LCBpbnRjX2lycS0+b3V0cGluX2lkeCwN
Cj4gMSk7DQo+ID4gKyAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gICAvKg0KPiA+IC0gKiBUaGUg
YWRkcmVzcyBvZiBHSUNJTlQxMjggdG8gR0lDSU5UMTM2IGFyZSBmcm9tIDB4MTAwMCB0byAweDE4
MDQuDQo+ID4gLSAqIFV0aWxpemUgImFkZHJlc3MgJiAweDBmMDAiIHRvIGdldCB0aGUgaXJxIGFu
ZCBpcnEgb3V0cHV0IHBpbiBpbmRleA0KPiA+IC0gKiBUaGUgdmFsdWUgb2YgaXJxIHNob3VsZCBi
ZSAwIHRvIG51bV9pbnBpbnMuDQo+ID4gLSAqIFRoZSBpcnEgMCBpbmRpY2F0ZXMgR0lDSU5UMTI4
LCBpcnEgMSBpbmRpY2F0ZXMgR0lDSU5UMTI5IGFuZCBzbyBvbi4NCj4gPiArICogR0lDSU5UMTI4
IHRvIEdJQ0lOVDEzNiBtYXAgMToxIHRvIGlucHV0IGFuZCBvdXRwdXQgSVJRcyAwIHRvIDguDQo+
ID4gKyAqIFRoZSB2YWx1ZSBvZiBpbnB1dCBJUlEgc2hvdWxkIGJlIGJldHdlZW4gMCBhbmQgdGhl
IG51bWJlciBvZiBpbnB1dHMuDQo+ID4gICAgKi8NCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9p
bnRjX3NldF9pcnEodm9pZCAqb3BhcXVlLCBpbnQgaXJxLCBpbnQgbGV2ZWwpDQo+ID4gICB7DQo+
ID4gQEAgLTEzNSwzMCArMTY0LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2ludGNfc2V0X2lycSh2
b2lkICpvcGFxdWUsIGludA0KPiBpcnEsIGludCBsZXZlbCkNCj4gPiAgICAgICB9DQo+ID4NCj4g
PiAgICAgICB0cmFjZV9hc3BlZWRfaW50Y19zZWxlY3QobmFtZSwgc2VsZWN0KTsNCj4gPiAtDQo+
ID4gLSAgICBpZiAocy0+bWFza1tpbnRjX2lycS0+aW5waW5faWR4XSB8fCBzLT5yZWdzW2ludGNf
aXJxLT5zdGF0dXNfYWRkcl0pIHsNCj4gPiAtICAgICAgICAvKg0KPiA+IC0gICAgICAgICAqIGEu
IG1hc2sgaXMgbm90IDAgbWVhbnMgaW4gSVNSIG1vZGUNCj4gPiAtICAgICAgICAgKiBzb3VyY2Vz
IGludGVycnVwdCByb3V0aW5lIGFyZSBleGVjdXRpbmcuDQo+ID4gLSAgICAgICAgICogYi4gc3Rh
dHVzIHJlZ2lzdGVyIHZhbHVlIGlzIG5vdCAwIG1lYW5zIHByZXZpb3VzDQo+ID4gLSAgICAgICAg
ICogc291cmNlIGludGVycnVwdCBkb2VzIG5vdCBiZSBleGVjdXRlZCwgeWV0Lg0KPiA+IC0gICAg
ICAgICAqDQo+ID4gLSAgICAgICAgICogc2F2ZSBzb3VyY2UgaW50ZXJydXB0IHRvIHBlbmRpbmcg
dmFyaWFibGUuDQo+ID4gLSAgICAgICAgICovDQo+ID4gLSAgICAgICAgcy0+cGVuZGluZ1tpbnRj
X2lycS0+aW5waW5faWR4XSB8PSBzZWxlY3Q7DQo+ID4gLSAgICAgICAgdHJhY2VfYXNwZWVkX2lu
dGNfcGVuZGluZ19pcnEobmFtZSwgaW50Y19pcnEtPmlucGluX2lkeCwNCj4gPiAtDQo+IHMtPnBl
bmRpbmdbaW50Y19pcnEtPmlucGluX2lkeF0pOw0KPiA+IC0gICAgfSBlbHNlIHsNCj4gPiAtICAg
ICAgICAvKg0KPiA+IC0gICAgICAgICAqIG5vdGlmeSBmaXJtd2FyZSB3aGljaCBzb3VyY2UgaW50
ZXJydXB0IGFyZSBjb21pbmcNCj4gPiAtICAgICAgICAgKiBieSBzZXR0aW5nIHN0YXR1cyByZWdp
c3Rlcg0KPiA+IC0gICAgICAgICAqLw0KPiA+IC0gICAgICAgIHMtPnJlZ3NbaW50Y19pcnEtPnN0
YXR1c19hZGRyXSA9IHNlbGVjdDsNCj4gPiAtICAgICAgICB0cmFjZV9hc3BlZWRfaW50Y190cmln
Z2VyX2lycShuYW1lLCBpbnRjX2lycS0+aW5waW5faWR4LA0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGludGNfaXJxLT5vdXRwaW5faWR4LA0KPiA+IC0NCj4gcy0+
cmVnc1tpbnRjX2lycS0+c3RhdHVzX2FkZHJdKTsNCj4gPiAtICAgICAgICBhc3BlZWRfaW50Y191
cGRhdGUocywgaW50Y19pcnEtPmlucGluX2lkeCwgaW50Y19pcnEtPm91dHBpbl9pZHgsDQo+IDEp
Ow0KPiA+IC0gICAgfQ0KPiA+ICsgICAgYXNwZWVkX2ludGNfc2V0X2lycV9oYW5kbGVyKHMsIGlu
dGNfaXJxLCBzZWxlY3QpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRf
aW50Y19lbmFibGVfaGFuZGxlcihBc3BlZWRJTlRDU3RhdGUgKnMsIGh3YWRkcg0KPiA+IG9mZnNl
dCwNCg0K

