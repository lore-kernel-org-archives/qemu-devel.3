Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED085C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 07:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKXsW-0001h3-Cg; Thu, 29 May 2025 03:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uKXsP-0001gF-KZ; Thu, 29 May 2025 03:40:33 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uKXsJ-0006ro-QP; Thu, 29 May 2025 03:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCNiGsMGkV7/TIv/2Ud/fVe5w/K/vpZwx94hLKFRNbNZl9hTbGfqI3hL3jWcmyHFZRNZkonlr8ezFiLsPmGSY10shSdpCTEghA6kyxs9ahAh4xlqEVwhRsgvFTAt4EmL5d5/8MI6/dsn/CDQKbkCjucCuHWV6UeneLYYiRbQway4DuQIYpFOIn8MWU4scBZjWHK7BO4PC6XuE90ImiP1gzNmgZsQxdhfRV8hHZswEK7V+umvdO3l/MNYmAJAMLBN4CPD34iyoo9CJThludZvWOWYIsi0TD5MvzifX8zoPuJf/aPs4MkVPrYUATYugA+Yc5yv/SoihlZAxfRaXxlnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDKH/V+HMAaZ0bLOsM2OLq4iISTG3CvpPqlwbXn+yIc=;
 b=CzlMlVhdTtW8mv4ckDvPQvywVrCV4xpgpHNQ0fsFPEDbgTNteAhbhYYOLu/BKLuy+g99H3vFN6ScB8nKs9jlpbpKNE6Oo0/3eZpnHUowQxU+yOvKxy9D5DQSvadvjDIjD7kGynofGFiB5mmvfE4NSCCM5663+NHjQDFMy3SwhMovY6OhGD3HyRrchs+2NCa3NdAOKhVjZY9u0dRRDqyUUjnL9Z/qx4Tpug7OQAEb3Rw77q9Brljj+ydIXnCg7ZDCBEQB1H7RvrWQJo8GirdO7v2wbA7iIIDYStHD8oCPCWQ6BwjH4ZnxNSBuSuTrQ0yjkaM3ocf0wIm/PTIj9O/7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDKH/V+HMAaZ0bLOsM2OLq4iISTG3CvpPqlwbXn+yIc=;
 b=A2SQz53N+xEtVJKr8ZNaaHKshLX1d0DttQ8zOiQ48L9hbfR1kd9SQpa347xbgeP0ZTbM+pnwtHKO5KtgYKIMb3+Gczn/iT83VAXMx5e3xLqpCahKyfMFi6l84GbTMBNlbJAgRVo1dPYDMvsliiApinhSbpCkzgvzYOY2zAUd+6s5opkXc4QGJ6oitoHHYUOFV9EXbRjnriB4zu31nzBWwFl1sx5ee24kqtsmn/otCQiOfgYbk20Hr2VsiDulMhRAs/wE4GzSufMOSginp0AdG5oQjezSjgmS9axM76qZjguq0gWwQXX1QRsG6QzdKO/0g6AmJ2LDXoquBynAhm17VA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6635.apcprd06.prod.outlook.com (2603:1096:101:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 07:40:16 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 07:40:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 00/28] Fix incorrect hash results on AST2700
Thread-Topic: [PATCH v3 00/28] Fix incorrect hash results on AST2700
Thread-Index: AQHbxXDK232Krxmazk6mvIrNpQ/u47PpS++AgAACdgCAAABgEA==
Date: Thu, 29 May 2025 07:40:15 +0000
Message-ID: <SI2PR06MB5041C06629D643329DB6A5C0FC66A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
 <6e6f3084-3ee4-4498-aea6-77b2d2c1bce7@tls.msk.ru>
 <b0e01786-2f70-4331-b5c5-fb979f7e088c@kaod.org>
In-Reply-To: <b0e01786-2f70-4331-b5c5-fb979f7e088c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6635:EE_
x-ms-office365-filtering-correlation-id: b7285129-703a-4a06-2ff5-08dd9e840da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c2xkQmZEOWw4SzBQbkoxTVpkaEQ5VTkrbzd1QnZkOU1HY0xwQTBwT2cva0px?=
 =?utf-8?B?S0drUUcyazlqSEtvSFVLdSt1VDM0aGRHZlprQ21HdDFWSzYzUWF4dDVKV3kr?=
 =?utf-8?B?OVJ5OU5UVTNnNFJvbWFSUVBJMjBnUG5JQjZNSzZBWXg1MkNTOTJGV1Q1MXB2?=
 =?utf-8?B?OUhiWVNOeGVZeFJ0WkY0bHhoUHloZ1VyME9ZdEJxL0hiRDQ2WVBpWDlhVWNI?=
 =?utf-8?B?UlZmRzRwNitJSTFSb3ROaWFOQ0NnUFJzUGkzM0VQcEdudWhmczh2ZmN2Znpk?=
 =?utf-8?B?d2pvTGdHeVo4WGNZcmU4MnppZ3JDZXpKR1VhU1RXQThEalRqMk9GTnpCMG0v?=
 =?utf-8?B?YTZYNSt1dkVwcnN2eDFjRTJYYTdKNlJGYWdCSmkzTDRyUGZNc3BYQUtoSnY4?=
 =?utf-8?B?NForakR3R1hpZXI3VTdnbll1MHc4WmtkUzhsU3dxQmxRay9rTXh3NEpuUC9y?=
 =?utf-8?B?UUhPUEZXMGgzSmt2N2tBU2tWNm4zL1MvOUsrZnh6T3VYMmd3b0h6Y0hoYnF4?=
 =?utf-8?B?L0R1RHl0b0txaTI3WEUveTdzbzRSbWVtaDRLTXlHVkNBa3h3bW9JZ1lLdlU2?=
 =?utf-8?B?YkpOemJBcVFSaGFPYkNPOFpheVlRbHZFS3BXODNyV01DUXpUOHJDMHlsL2tu?=
 =?utf-8?B?aXBCazZlVXBtRWVWM2pBa0d0ZXg3OHU4QjRFaVlsbzNDcUZHTUh4Q3FlUTVz?=
 =?utf-8?B?WklXTWxlZnJOdnFxY2pCZjZQTUJSWFlrOW52YTYwb2Zha09XVFp3L0g4dGJr?=
 =?utf-8?B?WEo1MEdPeVdMOW81WWJoMytKN1lSTzF2N2RnU2gyWm50MHg0QmJER0tHOGpS?=
 =?utf-8?B?Ly9hQXhBU0VxQ1lnM0tyMDlNYWkrdjhNNVVzWlN5YThpRDM1ZVNDT3kwRkwr?=
 =?utf-8?B?RC9LcCtaaDdFMnVmR0FybWtoM1hzZmoyQWIvWFdSdG1hc0J1ZGVpY3E0SnQ0?=
 =?utf-8?B?T0kvKzNxR254dlRXcFl0ak5hWU02ODlUZGk0a3hFMG53VkxRd3ZFK3ZNNjVl?=
 =?utf-8?B?bmtabmQ5eHg1OTRGQ0JZOEZMb3lnSDYyclFoaXhZL0VubklrRkhzYVcrOFI2?=
 =?utf-8?B?TDdIRUp0dmNuMzBkNGpacVlkNjd3SjFKSEJsb2c0c0pCWDBJUXZ3OHJyTGhT?=
 =?utf-8?B?SGZLcmVvVXpYQzk4RGxFbnVDeHFJYTROdU9lcStodlJmcWp1K3J3YU1xSWpB?=
 =?utf-8?B?bXpnaGp5ak9iS05wNXgzbE4rSkNIWEF6U0U1ZlpLYWFtOWdUY1NLNEh6cUtS?=
 =?utf-8?B?RWlXa3BzcnN3d0RGOEdUTEdFajdGUVRaT2c3QW1iK1hrbVpkcFliandmZFZE?=
 =?utf-8?B?NTRmdkJGaWdkbXBCZkVRVitUS2VmcTc1T0ZOVWdDcjJSOTVoS1YxQ2RxMDdi?=
 =?utf-8?B?ZlozRmJZQXdBUVhYemNrMTlwUHg0VXBHVWxLYjM4cHNxUmd5ZzdoaEpqSnAy?=
 =?utf-8?B?ZUJyT2REUnVZcEszdGE5WHdmRnl6ekFaTVY2MnVZdmRiN3dNbGV2YXVES0VC?=
 =?utf-8?B?Y1BwRkF4K0ZmZm5sTHdJVlg1aGVqcUFKRW9kTnd0SHk5RHE2Uk1paHRWT2Mz?=
 =?utf-8?B?K2ptY1ZxSTZQbFpsYTNNUXovV0FKZlMwWTNRbGt6bUg5RjdpKzVuYkdZb1JE?=
 =?utf-8?B?bEhtTEN4b0lWUytneGpsS3FCOVpxRnVqOFpHZmtQZzBRaWlEUnQ3eFk1eHdi?=
 =?utf-8?B?U1F5Mnc4a1VFMWd1KzFQZEUzMEF4K0VheC94WHhoTDJwQ2xiSVZtT3FMZ3Ba?=
 =?utf-8?B?RVlYSlpIK2pFa2h6SmRpLzNDbWZJbTZyVGJYU2FpVWtHMlR0OU5EZmh1L0VD?=
 =?utf-8?B?TGJvbXBxYWx1YTUvbnFhbjZhelRYOVJTSE1NZlJkdlQ1cGEvS2xrNk1KRWg1?=
 =?utf-8?B?Y2ZPVllPNlFJT2pUUnVOMEFMRGZMejBKWXFkOVpxQWVlOWVTbEhYa1FGRlN3?=
 =?utf-8?B?ck13OHY1RXREaWc3Skd2OEFPeENUbDZYUTFnZlBPWjdpYzlYS1JLU09qQVhl?=
 =?utf-8?Q?4GVAY330OzJkG5jo2LrovtvLJK38ug=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJvUkZxVTFCWkRmemdFZ3Nwb1h6dGdnWjh0dFppc0lBMlJhTVhZdWxRdnJR?=
 =?utf-8?B?Yk1EL3loWThTWEZSVndYNEhrMFJFNW5TT1ZOakQzK1FIUWxjcS8vM2s4OHhE?=
 =?utf-8?B?WVd5TmJ6NWRPU093Yk1DaUVzbFdkMk5iMnM4a010bkZjbTFnMEJtRktCbzlL?=
 =?utf-8?B?STVyZ1ZCOVVDZTVmSGRqWm9YdE55cDJHSzRCS01yTUtHeGVURTRFVDBzZ0ly?=
 =?utf-8?B?L0pPS2RidnV0cTdNdWp1TW1SUHBvRnZXSzJ4Q25rS1F5T0ZYUzZwQnE3V0tI?=
 =?utf-8?B?WFhsRlRYSmFFb1NZV0RqeWdWMmJKeWNSdEFmMFlyNXJsOGVWVFN3alRYSy9L?=
 =?utf-8?B?aHlMZ1NwbWhqbldENWw0TlR4aU5GanVEVnA3OTNzeVlMSTU1VEhLOWdtYUlY?=
 =?utf-8?B?dXhsc09UV044SmN6Vno4cHFOampPVDd3WGZQaWY2RDNMS0hLcndOSWMzYWFU?=
 =?utf-8?B?QnBCTVFWa2ZBdS9nMzZNOGkwdHo0Njkyd2xXdTRnNTZGQ3ZVNVM5cDYzdjhj?=
 =?utf-8?B?YWtSNml3SUFEZmdlTXA5M1RXOXpDWFoyV0h3MVBZeHl3dlcrR2hKVGZldTZq?=
 =?utf-8?B?bk9nQW5oWGJoM3haYjVXZWIrSHBUSmxZdXNyYmVNNzljVVIzVXA0ODRJTDV5?=
 =?utf-8?B?NkxaUXYxVEl0WnpQdkpScm5lRklhOEFHQ0xTaVh2VHF6WkhQeHJlWmVBek1l?=
 =?utf-8?B?bWp2aVZVN21Db1hQV3BSOUNCTE9reUM3dFZFN28ycDhITzRVVmJudmlUOXBp?=
 =?utf-8?B?WmIyVUgvMWpka041UjBlMCtqUUdHYWpqL1RsdHM2ZlJVUHo1WGxKdURKUEpB?=
 =?utf-8?B?MHpHNWlzdTNRNlVwTkdzYmdQTTNCWFFyQ0pFbTVHQjhzZzlyQ09Pcnc4cjIr?=
 =?utf-8?B?V3JycTRJQWo0cWNCbG5kUlkyME5TdUx4TXJkUWhRTlJuOTZuajB5Nk15VGtx?=
 =?utf-8?B?VmFWWnFQWm8rcVpUR1dvcDgwUjBQeXAxYW5vc2NGZ1lwTVZ6ejJ3SDRNNUs4?=
 =?utf-8?B?VUphYUQyWndtVHcyREFRdTZhWW9jQTJYcjkrZWNzbVhYS21iblprTDlWNFpl?=
 =?utf-8?B?KyszRmJ6SXU2b050TlVBNkh0ejBmZlRMWjNkcmhqcVF5UUNBL0Nka0VsSEsz?=
 =?utf-8?B?bVNzeFloME5aaDQzbnpXVng2eXJaTHRkWUxaTUQxb0Z4MmdCK3BGT29ZRzh6?=
 =?utf-8?B?WUZBRHgzbnJIRjI2eUZUNnREeDJhbVBWaWVsUlUxeWZZNC8xb3U2SEJWSERm?=
 =?utf-8?B?YUZCT0lZSHZGZDA2V3Ntd3d6OWF1b2hpZlB4K1o1cGFjL3BpS05nRGZ4K05l?=
 =?utf-8?B?OHljdmUxMkFvbEdlWlQ4UDRQUDNvNFRsNFJBcEd0TXhIa2NFOWNOUm0xczhn?=
 =?utf-8?B?Z2k4bi96Um5zWHhTK0VmYkkzdGxLT3VMV0dLcmVueG9CemtNM25mbm9xYTVx?=
 =?utf-8?B?THNXcDNIeElCTkN1NmZjL1pjWFB4VmJIV2JjbjllY2FMV1RGRkRrMHVkUkww?=
 =?utf-8?B?M1J1MnBQM2w0ZGZpRlpxa0FxTytuRHQ4MThyWTB4YnJMaG41eHcvK2g4bzB1?=
 =?utf-8?B?L1BqRVd3RENzV1p5by91aGRlTDdRVVRXUGRFTmxBbTlUU2JvMVoya2laYUpx?=
 =?utf-8?B?T3BIamltUCtXcjhiSGNVVHJWNjB1YmlWMjNRclVWOEhaT3FFbFNsK1FQYVE1?=
 =?utf-8?B?T2hxbXRxM0tKOGxFUU9RK2xUelEva2pQVXFBd3NqZW5KYXFVRnFXeWUxZnQr?=
 =?utf-8?B?TVZuMlU3ZVVyWVozanJHQ01MYWJMT1JHU0ZOVlhsSU84SklzQ3E4ditUNWVp?=
 =?utf-8?B?NFJabnRwZTFHTHNPVEFIbkFUcERhZURFeGZNOXdFS0hEQ2ZZV3U5Y3ppU0hs?=
 =?utf-8?B?T1B5TlVvbm03N2RMN3lId3NPeTI1RlNnTFpqN3FMckpoRnVHN0N4ZVJMRTRs?=
 =?utf-8?B?NExZWE8vK1NSQVdVL1FwSy9TUEltSnNQUUJEbU1CRVZwSkxMK2NmbWdIUHVy?=
 =?utf-8?B?dkN6WTdSR0FpU0dtM2xkaTVZUzBsTzREeFVPSS9odW83ODMyRXJjREp6bnJD?=
 =?utf-8?B?YW1pLzJRVUw0TlhZS2htbWFXRVgzTmFTOUMvcDFJc0d3SStlTUhJeWV5d2U1?=
 =?utf-8?Q?mF4PqIWmX3DBl1mZ4pfhwoiGC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7285129-703a-4a06-2ff5-08dd9e840da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 07:40:15.8028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQx3KHAuSD7xSUqgk/WkLvoirtZw56eWdSYNT20PFLtmdfXQvgiMFENFq3w8HpLZAAit7NdJVKfVCuAlProRlSy3I7iZURH8M8zsPZwjLL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6635
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDAvMjhdIEZpeCBpbmNvcnJl
Y3QgaGFzaCByZXN1bHRzIG9uIEFTVDI3MDANCj4gDQo+IEhlbGxvIE1pY2hhZWwNCj4gDQo+IE9u
IDUvMjkvMjUgMDk6MjksIE1pY2hhZWwgVG9rYXJldiB3cm90ZToNCj4gPiBPbiAxNS4wNS4yMDI1
IDExOjA5LCBKYW1pbiBMaW4gdmlhIHdyb3RlOg0KPiA+DQo+ID4+IFRoaXMgcGF0Y2hzZXQgcmVz
b2x2ZXMgaW5jb3JyZWN0IGhhc2ggcmVzdWx0cyByZXBvcnRlZCBvbiB0aGUgQVNUMjcwMA0KPiBw
bGF0Zm9ybS4NCj4gPj4gVGhpcyB1cGRhdGUgYWRkcmVzc2VzIHRoZSBmb2xsb3dpbmcga2VybmVs
IHdhcm5pbmdzIGFuZCB0ZXN0IGZhaWx1cmVzDQo+ID4+IHJlbGF0ZWQgdG8gdGhlIGNyeXB0byBz
ZWxmLXRlc3QgZnJhbWV3b3JrOg0KPiA+IC4uDQo+ID4+IEphbWluIExpbiAoMjgpOg0KPiA+PiDC
oMKgIGh3L21pc2MvYXNwZWVkX2hhY2U6IFJlbW92ZSB1bnVzZWQgY29kZSBmb3IgYmV0dGVyIHJl
YWRhYmlsaXR5DQo+ID4+IMKgwqAgaHcvbWlzYy9hc3BlZWRfaGFjZTogSW1wcm92ZSByZWFkYWJp
bGl0eSBhbmQgY29uc2lzdGVuY3kgaW4NCj4gPj4gdmFyaWFibGUNCj4gPj4gwqDCoMKgwqAgbmFt
aW5nDQo+ID4+IMKgwqAgaHcvbWlzYy9hc3BlZWRfaGFjZTogRW5zdXJlIEhBU0hfSVJRIGlzIGFs
d2F5cyBzZXQgdG8gcHJldmVudA0KPiA+PiBmaXJtd2FyZQ0KPiA+PiDCoMKgwqDCoCBoYW5nDQo+
ID4+IMKgwqAgaHcvbWlzYy9hc3BlZWRfaGFjZTogRXh0cmFjdCBkaXJlY3QgbW9kZSBoYXNoIGJ1
ZmZlciBzZXR1cCBpbnRvDQo+ID4+IGhlbHBlcg0KPiA+PiDCoMKgwqDCoCBmdW5jdGlvbg0KPiA+
PiDCoMKgIGh3L21pc2MvYXNwZWVkX2hhY2U6IEV4dHJhY3QgU0ctbW9kZSBoYXNoIGJ1ZmZlciBz
ZXR1cCBpbnRvIGhlbHBlcg0KPiA+PiDCoMKgwqDCoCBmdW5jdGlvbg0KPiA+PiDCoMKgIGh3L21p
c2MvYXNwZWVkX2hhY2U6IEV4dHJhY3QgZGlnZXN0IHdyaXRlIGFuZCBpb3YgdW5tYXAgaW50bw0K
PiA+PiBoZWxwZXINCj4gPj4gwqDCoMKgwqAgZnVuY3Rpb24NCj4gPj4gwqDCoCBody9taXNjL2Fz
cGVlZF9oYWNlOiBFeHRyYWN0IG5vbi1hY2N1bXVsYXRpb24gaGFzaCBleGVjdXRpb24gaW50bw0K
PiA+PiDCoMKgwqDCoCBoZWxwZXIgZnVuY3Rpb24NCj4gPj4gwqDCoCBody9taXNjL2FzcGVlZF9o
YWNlOiBFeHRyYWN0IGFjY3VtdWxhdGlvbi1tb2RlIGhhc2ggZXhlY3V0aW9uDQo+IGludG8NCj4g
Pj4gwqDCoMKgwqAgaGVscGVyIGZ1bmN0aW9uDQo+ID4+IMKgwqAgaHcvbWlzYy9hc3BlZWRfaGFj
ZTogSW50cm9kdWNlIDY0LWJpdCBoYXNoIHNvdXJjZSBhZGRyZXNzIGhlbHBlcg0KPiA+PiDCoMKg
wqDCoCBmdW5jdGlvbg0KPiA+PiDCoMKgIGh3L21pc2MvYXNwZWVkX2hhY2U6IFJlbmFtZSBSX0hB
U0hfREVTVCB0byBSX0hBU0hfRElHRVNUDQo+IGFuZA0KPiA+PiBpbnRyb2R1Y2UNCj4gPj4gwqDC
oMKgwqAgNjQtYml0IGhhc2ggZGlnZXN0IGFkZHJlc3MgaGVscGVyDQo+ID4+IMKgwqAgaHcvbWlz
Yy9hc3BlZWRfaGFjZTogU3VwcG9ydCBhY2N1bXVsYXRpdmUgbW9kZSBmb3IgZGlyZWN0IGFjY2Vz
cw0KPiA+PiBtb2RlDQo+ID4+IMKgwqAgaHcvbWlzYy9hc3BlZWRfaGFjZTogTW92ZSByZWdpc3Rl
ciBzaXplIHRvIGluc3RhbmNlIGNsYXNzIGFuZA0KPiA+PiDCoMKgwqDCoCBkeW5hbWljYWxseSBh
bGxvY2F0ZSByZWdzDQo+ID4+IMKgwqAgaHcvbWlzYy9hc3BlZWRfaGFjZTogQWRkIHN1cHBvcnQg
Zm9yIHNvdXJjZSwgZGlnZXN0LCBrZXkgYnVmZmVyIDY0DQo+ID4+IGJpdA0KPiA+PiDCoMKgwqDC
oCBhZGRyZXNzZXMNCj4gPj4gwqDCoCBody9taXNjL2FzcGVlZF9oYWNlOiBTdXBwb3J0IERNQSA2
NCBiaXRzIGRyYW0gYWRkcmVzcw0KPiA+PiDCoMKgIGh3L21pc2MvYXNwZWVkX2hhY2U6IEFkZCB0
cmFjZS1ldmVudHMgZm9yIGJldHRlciBkZWJ1Z2dpbmcNCj4gPj4gwqDCoCBody9taXNjL2FzcGVl
ZF9oYWNlOiBTdXBwb3J0IHRvIGR1bXAgcGxhaW50ZXh0IGFuZCBkaWdlc3QgZm9yDQo+ID4+IGJl
dHRlcg0KPiA+PiDCoMKgwqDCoCBkZWJ1Z2dpbmcNCj4gPj4gwqDCoCB0ZXN0cy9xdGVzdDogUmVv
cmRlciBhc3BlZWQgdGVzdCBsaXN0DQo+ID4+IMKgwqAgdGVzdC9xdGVzdDogSW50cm9kdWNlIGEg
bmV3IGFzcGVlZC1oYWNlLXV0aWxzLmMgdG8gcGxhY2UgY29tbW9uDQo+ID4+IMKgwqDCoMKgIHRl
c3RjYXNlcw0KPiA+PiDCoMKgIHRlc3QvcXRlc3QvaGFjZTogU3BlY2lmeSBleHBsaWNpdCBhcnJh
eSBzaXplcyBmb3IgdGVzdCB2ZWN0b3JzIGFuZA0KPiA+PiDCoMKgwqDCoCBoYXNoIHJlc3VsdHMN
Cj4gPj4gwqDCoCB0ZXN0L3F0ZXN0L2hhY2U6IEFkanVzdCB0ZXN0IGFkZHJlc3MgcmFuZ2UgZm9y
IEFTVDEwMzAgZHVlIHRvIFNSQU0NCj4gPj4gwqDCoMKgwqAgbGltaXRhdGlvbnMNCj4gPj4gwqDC
oCB0ZXN0L3F0ZXN0L2hhY2U6IEFkZCBTSEEtMzg0IHRlc3QgY2FzZXMgZm9yIEFTUEVFRCBIQUNF
IG1vZGVsDQo+ID4+IMKgwqAgdGVzdC9xdGVzdC9oYWNlOiBBZGQgU0hBLTM4NCB0ZXN0cyBmb3Ig
QVNUMjYwMA0KPiA+PiDCoMKgIHRlc3QvcXRlc3QvaGFjZTogQWRkIHRlc3RzIGZvciBBU1QxMDMw
DQo+ID4+IMKgwqAgdGVzdC9xdGVzdC9oYWNlOiBVcGRhdGUgc291cmNlIGRhdGEgYW5kIGRpZ2Vz
dCBkYXRhIHR5cGUgdG8gNjQtYml0DQo+ID4+IMKgwqAgdGVzdC9xdGVzdC9oYWNlOiBTdXBwb3J0
IDY0LWJpdCBzb3VyY2UgYW5kIGRpZ2VzdCBhZGRyZXNzZXMgZm9yDQo+ID4+IMKgwqDCoMKgIEFT
VDI3MDANCj4gPj4gwqDCoCB0ZXN0L3F0ZXN0L2hhY2U6IFN1cHBvcnQgdG8gdGVzdCB1cHBlciAz
MiBiaXRzIG9mIGRpZ2VzdCBhbmQNCj4gPj4gc291cmNlDQo+ID4+IMKgwqDCoMKgIGFkZHJlc3Nl
cw0KPiA+PiDCoMKgIHRlc3QvcXRlc3QvaGFjZTogU3VwcG9ydCB0byB2YWxpZGF0ZSA2NC1iaXQg
aG1hYyBrZXkgYnVmZmVyDQo+ID4+IGFkZHJlc3Nlcw0KPiA+PiDCoMKgIHRlc3QvcXRlc3QvaGFj
ZTogQWRkIHRlc3RzIGZvciBBU1QyNzAwDQo+ID4NCj4gPiBJcyB0aGVyZSBhbnl0aGluZyBoZXJl
IHdoaWNoIGlzIHdvcnRoIHRvIGFwcGx5IHRvIHFlbXUtc3RhYmxlICgxMC4wLngNCj4gPiBpcyBz
dXBwb3NlZCB0byBiZSBMVFMgc2VyaWVzKT8NCj4gDQo+IA0KPiBUaGUgY2FuZGlkYXRlcyB3b3Vs
ZCBiZSB0aGVzZSB0d28gOg0KPiANCj4gICAgaHcvbWlzYy9hc3BlZWRfaGFjZTogRW5zdXJlIEhB
U0hfSVJRIGlzIGFsd2F5cyBzZXQgdG8NCj4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBGaXgg
UkFNIHNpemUgZGV0ZWN0aW9uIGZhaWx1cmUgb24NCj4gDQo+IEphbWluLA0KPiANCj4gRG8geW91
IGFncmVlID8NCj4gDQoNCkFncmVlDQpUaGFua3MtSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBD
Lg0KPiANCg0K

