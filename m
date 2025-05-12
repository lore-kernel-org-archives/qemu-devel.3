Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B486C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOkZ-0002ou-D8; Mon, 12 May 2025 04:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEOit-0007vc-Sy; Mon, 12 May 2025 04:41:25 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEOin-0001lp-08; Mon, 12 May 2025 04:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUsIJYPGFnrmd9dwHj9BXoqwygsm7tCHr5LklUU52v0ZqLfvWh0rKo+IMwGdsls2gv8kUtB9jqZrOrK5yjH0PLlVRX/uh2fdNRTDofz1Sv4OZLrPB8obGPrxysLW/pmLkdhPAoSzSnF2s6lbyhBAduJNC7FMZHlZ6XwXpRUUDM54UJFMGxZ6veZQeR9fIjPdU214jYsUa+uI1Lx7CPe2wa7sh1YXnidd/UjVgpxkAmZBzw34ukxTPPtVwIYhZxzGKbpyLAehwV8wOLxQqje+DPPiKFbU44osXBLxqdTH+1PwY539AScAQhqnOWfwhId+0fNkIqTW6HiwMV7Tw0NgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI0WFiS9nu+NoGv0FUDlUbHXEB48uCGB51GbNrmCiLM=;
 b=xBXgZvc/5SuAdWyqalfnj1oIO4lN7ymv54CjWQzeEI+QUDXM37pf26X30MNNg996eNCZrBQeg4Ym3z9znF86g/yoiqLfDetsLfkRgCTEe5hnFkJKSrN3maw+1n/xNDJNLJJ7HPSROxRh9UBgbFj1cqY5QoDz3f1iufWl9M1fecjUFNXFgOwxRibLS+DOArNigCI+msZ8tTsqH3zfJz5u7Wh/CPC8hg/Bqd7i+p9prK/8NxfMQWMMw35b18P4jvd/Hflp+TSi+l54bQRKQORySUC93v3IQ9ZEBNSUL6+T/EMA+Z/1rQFuX8SgCntO5nFfS0nuHchNERW5rPgTDg3rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI0WFiS9nu+NoGv0FUDlUbHXEB48uCGB51GbNrmCiLM=;
 b=J3yV09hbb73lWgpUdA1GuQJa91yRGrWqs8C13MaRCnpKe0ylxtyqc07yL/JuMN9pEjZODsOsd+gtC5JKGXZHYNC9U0joQnqypVdiN58trEBqEQOWw+01vm1L/ie5MIiNls9NpXx+sPyfCvPlvhwluOCtzb6trccU2XfGUVMi/xQ8EKpSogS8+5DGdrKAgyQbnrO9TMbDxjiid4HtSUCiw6+qKWIqDTxqb8RbSCRqtemQxAxytiMAW72U5CGsjOaQU7qt+hUfRTA5Bvqn/rFoqFoK3GI1BNTzi5qtQkSRPaop6tqIuBXy5FjZZ7VluIj3/ITufW593XpuDPoksQ4rfA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Mon, 12 May 2025 08:41:01 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 08:41:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Topic: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Index: AQHbmkNXc4tSzAUgS0eQdreGXV1+FbOQEMwAgDoaPGCAAYZDAIADS7lg
Date: Mon, 12 May 2025 08:41:00 +0000
Message-ID: <SI2PR06MB5041A336D11A710AB57F057FFC97A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-9-jamin_lin@aspeedtech.com>
 <ff5e84c5-4714-4897-90b6-40df76746443@kaod.org>
 <SI2PR06MB504194D74CCFCBB9403B7214FC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ba12c8bd-2d9e-46f1-a89e-fa3692e1098a@kaod.org>
In-Reply-To: <ba12c8bd-2d9e-46f1-a89e-fa3692e1098a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5913:EE_
x-ms-office365-filtering-correlation-id: dfe3f841-4860-44ad-14ce-08dd9130b945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cTFrT0JoWldlVTg0VVc0VEs1NWtadjdxRStmTWhxNHI5SHJ6S0dFQmxVYW1N?=
 =?utf-8?B?NGoveGRSY0ZuR3d6ZWljUHBwQkZVRDA1ckM0b2lTVEdvYkZpVmlSdzg5ZTNn?=
 =?utf-8?B?K01YZlVrN09vRzFHK0R6ZG5SckwyOEY2cUFYZ3lLUndvRVpQSDYvam0rb2Zi?=
 =?utf-8?B?RHZnM2NEYktScUVOa1IyTmpZWFBlUjloWGhjTVF6U1U0TUhMUDMwNVprNGw5?=
 =?utf-8?B?R3BTOWdpazVtUXV0OVdpOFJYbG5sZkVLb05VeHArY0djUExjOTFlTytQU3dj?=
 =?utf-8?B?cmxGTytTbEt2aGprTHNnaEhwVmxWUzNZaVVhYXNrUlJqWk9vK2RDU0IwUWtK?=
 =?utf-8?B?RGhXeUE4aUlac0U0ckFuN0RKbHNlcGJhTVdzWkJTRmVWMVlVZGx3cFJXRWwx?=
 =?utf-8?B?NVhVTEIxa3YyMklZYTVqOXhRaVdiQ0pCUm9Bb2p2ZFMwQXFYMHlTc0hIRUc5?=
 =?utf-8?B?djM1ZFBONmNDVnBubEJDRzJDS2VmQ09yaVdPNytyblV0d2d5ZG55V2FXMjQx?=
 =?utf-8?B?bWt0MlNqdWV1ZUQwWjdaclBLY1lkRVhvNGJaTUFnMzBpWEprTTlwSFE2OWpy?=
 =?utf-8?B?Wk9yc0pBS01sRFRyeGhtWUdhWXNJRnBTN21uMTRoZjJBclRGdDBzY3gyU1NX?=
 =?utf-8?B?UDRPdG9xV001SmxxM1pJVEZoOHMzTktHdHpDVWYyYjRMZVNwUzdHSmwvQzhD?=
 =?utf-8?B?TlJsZmk3QkRFWVh5cndIMTFaMlhscHhwVmJvUEdqZkMwT0x4akl0NmtUa0dY?=
 =?utf-8?B?a05FRTV4V1o0YzhzZ3ZML2h4TDQ0anhWcVg4Q0dVOVVGVXdlNVJLNVVBTTJO?=
 =?utf-8?B?MGRYM1Blb1lCcTVUemVXdFN4aVpHYmFPRThXWWhCMDNpTjJhK3VMN0M4c1B0?=
 =?utf-8?B?bGFMSWswUVF0ODYwMHBFSmtmWnViTjJhSWJTRDc5RDlqSTJQcW45cVJ1eXZI?=
 =?utf-8?B?SisycmFrczJWVmxQMnMwQzkrYzR2SDBNZmRWQUc4UDgxRDgzWk9VZ3U5c3dh?=
 =?utf-8?B?RnBEclhVSVQyNW1nZlRXVThLVGt4NVY5SlNTUW5tK1Fwa3dDTnYzTU5oS0NC?=
 =?utf-8?B?SS8vZGQ1RHdPNzIyWGI1WFFrS2FKSXhKcDRoY2djMmNkdjM1OEpDVVhxMzEx?=
 =?utf-8?B?ZWtmTHBCbGJsWlJ4RjA4dUROUjArdjYxNUcrQys2WGZVQkczV0xMck1uRDh1?=
 =?utf-8?B?M0p6Y0FuRjFyWUdTL2IyU1ZNbkVUWElnQWFYU0RBZEJOZTJsNXl2ZFNVMkxi?=
 =?utf-8?B?UHdTY3dINnV5aGp4ZjhDT21yMnJHdFltRFV5K0dmeE90aUJRQWJXcVZEU2VG?=
 =?utf-8?B?bEVHaThYVWd2MjlsNVJEZlA4SXQ5V0Fha2cwRnl0OGRHY1hFQnpkd3Fhd3U3?=
 =?utf-8?B?K3p0SEFjYTlVcitmM0ZYT2tKZFFRVWhISVlaUTFPb05jK3NtR0liQ1FTYXFF?=
 =?utf-8?B?YWhnTjFzcW5wVmZwUTJ2VE9PQVNDaUxNbGRoWGtYb016NHVDMnhCUVhUSnJ4?=
 =?utf-8?B?ZzV1OXdYTTBaS1l6TmZBMkwrUVRGc25NbHFsVXVvelB0QW0yaVpOR00wNGdv?=
 =?utf-8?B?MVdjUUEvSnVjOEtGdnI4dXpHeWQ3N1VsaXZDMWdyTTVsTjF0RW1vYitqTEdE?=
 =?utf-8?B?dUlXRVlSeHB2cS96Qmx4SjZ6Z0x4bUNLMUFWN01LMDRoYlNSeXZ4MHlhcjQx?=
 =?utf-8?B?Z3Z5Q3M4K2czWEdaRUoyTW5MSVYyMVBPbjM3bXdFYUN2bTBuL1R2dnJkL0xD?=
 =?utf-8?B?cDdXQWU1dUpWV0hKdlNvdjEwV2JabHFlbmFTdmVseXpyZGJWQkZzZWRXWmJZ?=
 =?utf-8?B?Ty9PbEdjYnRPNzlDcyttRkxLaDhXUGxHNVIwUDl3ZnplMUtxa2Zhb1pIbEZo?=
 =?utf-8?B?cVN6RHhxaWlQR0FLVTluVjZQT0toTHRpaEVwSzk0NFdBdWJ5UzNyM05lbDBh?=
 =?utf-8?Q?XZwBnv8wTZRqfMWBXPsmigytIYhC12/F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1FvK3B2ejhaYlhZcWFnWml3WFJreGk3Q3J4MHZtcGFTczhseXorZEZWUDVz?=
 =?utf-8?B?V3RmbTN0SjVpbHBZRXp3NTc5dVRkbVdTQVF1VmxSKys2dU4vL1Fpei9RZGRs?=
 =?utf-8?B?V0xWYzhZZFJnVXJ6UmVTS0EwRUF2UjJkOU1HU3ZUcFl0eHpyYWJ6alkwcFQw?=
 =?utf-8?B?V3htU0VkYWY3TzF1eTd4cHJjQ3UvYUptR01aMjhTc3crdWI0akFBZ29MSG1U?=
 =?utf-8?B?L1EvNkhzSS80cW5VTllxeFFxZE9tNVErbmFuQ0hvN1lpL2l1VnA2ZzZIVTVa?=
 =?utf-8?B?K1hpeVdlbHFKSDNzWnpnamhuUWJzeW5TL0M2RnI1S09lNmFHTW1BQ1ZRNG1x?=
 =?utf-8?B?YXRrckcvaUlFcnRlRHFYalVGTW1KeDkyYy8yMHlkRlhwMmxEZDRFSWVCZmpu?=
 =?utf-8?B?aTQrQi8wdHV1NVZEdWVxQjNQcWZ2OWtpbm9ZLzhVb0c4RHNhYXp6RHRTYnla?=
 =?utf-8?B?VmxqN2NHVCtHV0dzTnpvcmN5aXFteW5VazlCT2owS2JYWHFFQnpkc0V4MHJL?=
 =?utf-8?B?QWVSNy9UemdkMXBqaXBJOElUUnpkRkdscHU5RSszMHZTOHlMNk1yUWptTFc4?=
 =?utf-8?B?VWhONVQ0REh1NUxsdFJRLzRWbzVhVFBlWUx4VFdFbWRsQnZFOTczQ21raHpk?=
 =?utf-8?B?aVZXVmRCQURiUGt2MjlxQWg4eE5hMUNPbDBvM3czeTRyNisxZDdCTDUyYWtp?=
 =?utf-8?B?RUNSa0RUdWlpblZjbEdYUkNzM1R3ZmVqeFkxZVhZK0RoUjZMTElDbjdJRzRB?=
 =?utf-8?B?ZmU1eUM2clMzeVhtTUZXWmZiT21QbDROUklFZVlkbUQva1gvZVFUUUhnYXg2?=
 =?utf-8?B?SlNJQ1JCK2MzZzB2L1N5ZXhwcXgvYnRGM2w4d1RUYTFGbGtFczdFeWxsU0wy?=
 =?utf-8?B?OGtxdUJnVnFmYi9lcU50NXJWVzF0dWRUalhTK3BQRFpxdnRNWWEvSmgvUEhH?=
 =?utf-8?B?cWlPeWZHcmRBdXlzM2hCNUcrYkJpejFzMy9IcEVyRHM3M1VVN3BWMnU1R2Q1?=
 =?utf-8?B?QkU0L0MrSVY5RS9qRmczWkthU3RkSFNjNS9JeVQwak5DL3hKSWRVNThTY3dt?=
 =?utf-8?B?NkFySUVucjBhR1hITHdNRkVxUWIwSTZBeUx1akFuc0JLZHN0VzBmWjBKT0dF?=
 =?utf-8?B?UWNuQTFTWkFibVNGOHVyNHQrZ3VsN2hMUXhzSEJ3ZW5leDA1anNjQ2pEck9t?=
 =?utf-8?B?S3BBYmF6Ukl4RmRlemxta3JyOVNPV3pNYzZQSFVoajkrM0haZDhqdzNBbzBx?=
 =?utf-8?B?UG5OZWF3YlNaSjdUamFaand2QnhIaUI4VkttMVhub1NXNGg2c2lYa2xCa0g2?=
 =?utf-8?B?a1ZDNXJ4OXljcFAwd3pmL3N1MUJabVBFMWNhci9iT1lqbTlGVEVrYTlmNSs5?=
 =?utf-8?B?TFYxakM5QW1ZdFVzN3VlVEttbUJSUG1JaUFzbUxiaXdCeElNcVV6QmhaWDMx?=
 =?utf-8?B?cDRZN0t5WUR0d0NlSWVENWwzWkF0YTM5dVNNVURNWnlvZnZrMGpqMWlYS0Z4?=
 =?utf-8?B?K0M3V0lpL1VwR1VKTy9GSnVtTWFSTWt4Y080Q3lWWlBYSFA5L3p0blg1K3VS?=
 =?utf-8?B?eEgvdmxWdFI1V29rSXZndlV3eERGUFFteXlmeDNEK0hYcUlhNG1zbmw5NmxV?=
 =?utf-8?B?Y1BHRU4xRmtycnB3MG1RRHk4ajhWMC9XYlpERm9ROUtBekZTRlZKZncya2F4?=
 =?utf-8?B?Q2RMY0owUmNhWE1ERm1OMTFDNE9lbXRKZkJlY25jUzIvOFljb3A4d3FSOStS?=
 =?utf-8?B?Q2IwZm04Wmp5bXoxTzMvT2RFYXN2RmJGeEl5dXVBUUVqWUd1bWJsTUt3ek1R?=
 =?utf-8?B?cmlhY2RReDkra24yWjl0QkF3R29KdnZ0WXNHQ0xVSUsyZUNwUzc0Z01xMkVk?=
 =?utf-8?B?TWg2RE1xT25pdWVQa1FYY25WMDJtZFVPYWxlaGgzekdxdUlVVDJ4UzZ1ZHEz?=
 =?utf-8?B?OWVJbHUwWU0rTkFzdDNEeEE1VHdmcXplRFQ4YWZEUHJvSkRSRUl5YUIzZmUy?=
 =?utf-8?B?MTBFV2tBKzNHU2Ftb242VkVJVm1pNmRjcEYrbkJ4VytpcWRZaHFJeTZyanda?=
 =?utf-8?B?QW1BamVwWlRWY3VuaEZJbW55cldtaUFqNi9Oc3MxREhMcW04VktRZ1NWOXdV?=
 =?utf-8?Q?647cpDbMQWPJyA+8wOAb62rak?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe3f841-4860-44ad-14ce-08dd9130b945
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 08:41:00.9008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDDlAQdHnedKnPa/sLSyaeXhkkD2UjHndUZlf5jU+YTLbEy9ReXPFDWxUMvqdgZ2GC9Jl9t6ryMQIKiEZ0vHpb19o+DE8KMzvUgK95k5sNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5913
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IFN1cHBvcnQgRE1BIDY0IGJpdHMNCj4gZHJhbSBhZGRyZXNzLg0KPiANCj4gT24g
NS85LzI1IDA5OjA0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQ8OpZHJpYw0KPiA+DQo+ID4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMjJdIGh3L21pc2MvYXNwZWVkX2hhY2U6IFN1cHBv
cnQgRE1BIDY0DQo+ID4+IGJpdHMgZHJhbSBhZGRyZXNzLg0KPiA+Pg0KPiA+PiBPbiAzLzIxLzI1
IDEwOjI2LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+PiBBY2NvcmRpbmcgdG8gdGhlIEFTVDI3MDAg
ZGVzaWduLCB0aGUgZGF0YSBzb3VyY2UgYWRkcmVzcyBpcyA2NC1iaXQsDQo+ID4+PiB3aXRoIFJf
SEFTSF9TUkNfSEkgc3RvcmluZyBiaXRzIFs2MzozMl0gYW5kIFJfSEFTSF9TUkMgc3RvcmluZyBi
aXRzDQo+ID4+IFszMTowXS4NCj4gPj4+DQo+ID4+PiBTaW1pbGFybHksIHRoZSBkaWdlc3QgYWRk
cmVzcyBpcyA2NC1iaXQsIHdpdGggUl9IQVNIX0RFU1RfSEkgc3RvcmluZw0KPiA+Pj4gYml0cyBb
NjM6MzJdIGFuZCBSX0hBU0hfREVTVCBzdG9yaW5nIGJpdHMgWzMxOjBdLg0KPiA+Pj4NCj4gPj4+
IElkZWFsbHksIHNnX2FkZHIgc2hvdWxkIGJlIDY0LWJpdCBmb3IgdGhlIEFTVDI3MDAsIHVzaW5n
IHRoZQ0KPiA+Pj4gZm9sbG93aW5nIHByb2dyYW0gdG8gb2J0YWluIHRoZSA2NC1iaXQgc2dfYWRk
ciBhbmQgY29udmVydCBpdCB0byBhIERSQU0NCj4gb2Zmc2V0Og0KPiA+Pj4NCj4gPj4+IGBgYA0K
PiA+Pj4gc2dfYWRkciA9IGRlcG9zaXQ2NChzZ19hZGRyLCAzMiwgMzIsDQo+ID4+PiAgICAgICAg
ICAgICAgICAgICAgICAgYWRkcmVzc19zcGFjZV9sZGxfbGUoJnMtPmRyYW1fYXMsIHNyYyArDQo+
ID4+IFNHX0xJU1RfQUREUl9TSVpFLA0KPiA+Pj4NCj4gPj4gTUVNVFhBVFRSU19VTlNQRUNJRklF
RCwNCj4gPj4+IE5VTEwpOyBzZ19hZGRyIC09IDB4NDAwMDAwMDAwOyBgYGANCj4gPj4NCj4gPj4g
SSBkb24ndCB0aGluayB0aGUgY29kZSBleHRyYWN0IGFib3ZlIGlzIHVzZWZ1bC4NCj4gPj4NCj4g
Pj4+IFRvIG1haW50YWluIGNvbXBhdGliaWxpdHkgd2l0aCBvbGRlciBTb0NzIHN1Y2ggYXMgdGhl
IEFTVDI2MDAsIHRoZQ0KPiA+Pj4gQVNUMjcwMCBIVyBIQUNFIGNvbnRyb2xsZXJzIGF1dG9tYXRp
Y2FsbHkgc2V0IGJpdCAzNCBvZiB0aGUgNjQtYml0DQo+IHNnX2FkZHIuDQo+ID4+DQo+ID4+IEkg
c3VwcG9zZSB0aGF0J3Mgd2hhdCBiaXRzIFszMDoyOF0gb2YgdGhlIGZpcnN0IHdvcmQgb2YgdGhl
DQo+ID4+IHNjYXR0ZXItZ2F0aGVyIGVudHJ5IGFyZSBmb3IgPw0KPiA+Pg0KPiA+Pj4gQXMgYSBy
ZXN1bHQsDQo+ID4+PiB0aGUgZmlybXdhcmUgb25seSBuZWVkcyB0byBwcm92aWRlIGEgMzItYml0
IHNnX2FkZHIgY29udGFpbmluZyBiaXRzIFszMTowXS4NCj4gPj4+IFRoaXMgaXMgc3VmZmljaWVu
dCBmb3IgdGhlIEFTVDI3MDAsIGFzIGl0IHVzZXMgYSBEUkFNIG9mZnNldCByYXRoZXINCj4gPj4+
IHRoYW4gYSBEUkFNIGFkZHJlc3MuDQo+ID4+DQo+ID4+IHllcyB0aGUgSEFDRSBtb2RlbCBjYW4g
dXNlIGEgcmVsYXRpdmUgYWRkcmVzcyBiZWNhdXNlIHRoZSBEUkFNIG1lbW9yeQ0KPiA+PiByZWdp
b24gaXMgZGlyZWN0bHkgYXZhaWxhYmxlLiBUaGVyZSBpcyBubyBuZWVkIHRvIGNvbnN0cnVjdCBh
IHBoeXNpY2FsIGFkZHJlc3MuDQo+ID4+DQo+ID4+PiBJbnRyb2R1Y2UgYSBoYXNfZG1hNjQgY2xh
c3MgYXR0cmlidXRlIGFuZCBzZXQgaXQgdG8gdHJ1ZSBmb3IgdGhlIEFTVDI3MDAuDQo+ID4+Pg0K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfaGFjZS5oIHwgIDEg
Kw0KPiA+Pj4gICAgaHcvbWlzYy9hc3BlZWRfaGFjZS5jICAgICAgICAgfCAyNw0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L21pc2MvYXNwZWVkX2hhY2UuaA0KPiA+Pj4gYi9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2hh
Y2UuaCBpbmRleCBhNDQ3OWJkMzgzLi41OGZiNjYwMDlhIDEwMDY0NA0KPiA+Pj4gLS0tIGEvaW5j
bHVkZS9ody9taXNjL2FzcGVlZF9oYWNlLmgNCj4gPj4+ICsrKyBiL2luY2x1ZGUvaHcvbWlzYy9h
c3BlZWRfaGFjZS5oDQo+ID4+PiBAQCAtNTIsNiArNTIsNyBAQCBzdHJ1Y3QgQXNwZWVkSEFDRUNs
YXNzIHsNCj4gPj4+ICAgICAgICB1aW50MzJfdCBzcmNfaGlfbWFzazsNCj4gPj4+ICAgICAgICB1
aW50MzJfdCBkZXN0X2hpX21hc2s7DQo+ID4+PiAgICAgICAgdWludDMyX3Qga2V5X2hpX21hc2s7
DQo+ID4+PiArICAgIGJvb2wgaGFzX2RtYTY0Ow0KPiA+Pj4gICAgfTsNCj4gPj4+DQo+ID4+PiAg
ICAjZW5kaWYgLyogQVNQRUVEX0hBQ0VfSCAqLw0KPiA+Pj4gZGlmZiAtLWdpdCBhL2h3L21pc2Mv
YXNwZWVkX2hhY2UuYyBiL2h3L21pc2MvYXNwZWVkX2hhY2UuYyBpbmRleA0KPiA+Pj4gNTFjNjUy
M2ZhYi4uOGYzMzNmYzk3ZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2h3L21pc2MvYXNwZWVkX2hhY2Uu
Yw0KPiA+Pj4gKysrIGIvaHcvbWlzYy9hc3BlZWRfaGFjZS5jDQo+ID4+PiBAQCAtMTQ4LDYgKzE0
OCw3IEBAIHN0YXRpYyBib29sIGhhc19wYWRkaW5nKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4gPj4+
IHN0cnVjdA0KPiA+PiBpb3ZlYyAqaW92LA0KPiA+Pj4gICAgc3RhdGljIHZvaWQgZG9faGFzaF9v
cGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLCBpbnQgYWxnbywgYm9vbA0KPiA+PiBzZ19tb2Rl
LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBhY2NfbW9kZSkN
Cj4gPj4+ICAgIHsNCj4gPj4+ICsgICAgQXNwZWVkSEFDRUNsYXNzICphaGMgPSBBU1BFRURfSEFD
RV9HRVRfQ0xBU1Mocyk7DQo+ID4+PiAgICAgICAgYm9vbCBzZ19hY2NfbW9kZV9maW5hbF9yZXF1
ZXN0ID0gZmFsc2U7DQo+ID4+PiAgICAgICAgZ19hdXRvZnJlZSB1aW50OF90ICpkaWdlc3RfYnVm
ID0gTlVMTDsNCj4gPj4+ICAgICAgICBzdHJ1Y3QgaW92ZWMgaW92W0FTUEVFRF9IQUNFX01BWF9T
R107IEBAIC0xODIsNiArMTgzLDkNCj4gQEANCj4gPj4gc3RhdGljDQo+ID4+PiB2b2lkIGRvX2hh
c2hfb3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywgaW50IGFsZ28sIGJvb2wgc2dfbW9kZSwN
Cj4gPj4+ICAgICAgICAgICAgICAgIH0NCj4gPj4+DQo+ID4+PiAgICAgICAgICAgICAgICBzcmMg
PSBkZXBvc2l0NjQoc3JjLCAwLCAzMiwgcy0+cmVnc1tSX0hBU0hfU1JDXSk7DQo+ID4+PiArICAg
ICAgICAgICAgaWYgKGFoYy0+aGFzX2RtYTY0KSB7DQo+ID4+PiArICAgICAgICAgICAgICAgIHNy
YyA9IGRlcG9zaXQ2NChzcmMsIDMyLCAzMiwgcy0+cmVnc1tSX0hBU0hfU1JDX0hJXSk7DQo+ID4+
PiArICAgICAgICAgICAgfQ0KPiA+Pg0KPiA+PiBUaGF0J3Mgd2hlcmUgYSBsaXR0bGUgaGVscGVy
IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZS4NCj4gPj4NCj4gPiBJIGFkZCBoYXNoX2dldF9zb3VyY2Vf
YWRkciBoZWxwIGZ1bmN0aW9uLg0KPiA+IFBsZWFzZSBzZWUgcGF0Y2ggNiBjb21tZW50cy4NCj4g
Pg0KPiA+Pj4gICAgICAgICAgICAgICAgc3JjICs9IGkgKiBTR19MSVNUX0VOVFJZX1NJWkU7DQo+
ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgICAgbGVuID0gYWRkcmVzc19zcGFjZV9sZGxfbGUoJnMt
PmRyYW1fYXMsIHNyYywgQEANCj4gPj4+IC0xOTAsNg0KPiA+Pj4gKzE5NCwyMSBAQCBzdGF0aWMg
dm9pZCBkb19oYXNoX29wZXJhdGlvbihBc3BlZWRIQUNFU3RhdGUgKnMsIGludA0KPiA+Pj4gK2Fs
Z28sDQo+ID4+IGJvb2wgc2dfbW9kZSwNCj4gPj4+ICAgICAgICAgICAgICAgIHNnX2FkZHIgPSBh
ZGRyZXNzX3NwYWNlX2xkbF9sZSgmcy0+ZHJhbV9hcywgc3JjICsNCj4gPj4gU0dfTElTVF9MRU5f
U0laRSwNCj4gPj4+DQo+ID4+IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiA+Pj4g
ICAgICAgICAgICAgICAgc2dfYWRkciAmPSBTR19MSVNUX0FERFJfTUFTSzsNCj4gPj4+ICsgICAg
ICAgICAgICAvKg0KPiA+Pj4gKyAgICAgICAgICAgICAqIElkZWFsbHksIHNnX2FkZHIgc2hvdWxk
IGJlIDY0LWJpdCBmb3IgdGhlIEFTVDI3MDAsDQo+ID4+PiArIHVzaW5nDQo+ID4+IHRoZQ0KPiA+
Pj4gKyAgICAgICAgICAgICAqIGZvbGxvd2luZyBwcm9ncmFtIHRvIG9idGFpbiB0aGUgNjQtYml0
IHNnX2FkZHIgYW5kDQo+ID4+IGNvbnZlcnQgaXQNCj4gPj4+ICsgICAgICAgICAgICAgKiB0byBh
IERSQU0gb2Zmc2V0Og0KPiA+Pj4gKyAgICAgICAgICAgICAqIHNnX2FkZHIgPSBkZXBvc2l0NjQo
c2dfYWRkciwgMzIsIDMyLA0KPiA+Pj4gKyAgICAgICAgICAgICAqICAgICAgYWRkcmVzc19zcGFj
ZV9sZGxfbGUoJnMtPmRyYW1fYXMsIHNyYyArDQo+ID4+IFNHX0FERFJfTEVOX1NJWkUsDQo+ID4+
PiArICAgICAgICAgICAgICoNCj4gPj4gTUVNVFhBVFRSU19VTlNQRUNJRklFRCwgTlVMTCk7DQo+
ID4+PiArICAgICAgICAgICAgICogc2dfYWRkciAtPSAweDQwMDAwMDAwMDsNCj4gPj4+ICsgICAg
ICAgICAgICAgKg0KPiA+Pg0KPiA+PiBJIGRvbid0IHRoaW5rIHRoZSBhYm92ZSBjb21tZW50IGlz
IHVzZWZ1bC4gUGxlYXNlIGtlZXAgdGhlIG9uZSBiZWxvdy4NCj4gPj4NCj4gPj4+ICsgICAgICAg
ICAgICAgKiBUbyBtYWludGFpbiBjb21wYXRpYmlsaXR5IHdpdGggb2xkZXIgU29DcyBzdWNoIGFz
DQo+ID4+PiArIHRoZQ0KPiA+PiBBU1QyNjAwLA0KPiA+Pj4gKyAgICAgICAgICAgICAqIHRoZSBB
U1QyNzAwIEhXIGF1dG9tYXRpY2FsbHkgc2V0IGJpdCAzNCBvZiB0aGUNCj4gPj4+ICsgNjQtYml0
DQo+ID4+IHNnX2FkZHIuDQo+ID4+PiArICAgICAgICAgICAgICogQXMgYSByZXN1bHQsIHRoZSBm
aXJtd2FyZSBvbmx5IG5lZWRzIHRvIHByb3ZpZGUgYQ0KPiA+Pj4gKyAzMi1iaXQNCj4gPj4gc2df
YWRkcg0KPiA+Pj4gKyAgICAgICAgICAgICAqIGNvbnRhaW5pbmcgYml0cyBbMzE6MF0uIFRoaXMg
aXMgc3VmZmljaWVudCBmb3IgdGhlDQo+ID4+PiArIEFTVDI3MDAsDQo+ID4+IGFzDQo+ID4+PiAr
ICAgICAgICAgICAgICogaXQgdXNlcyBhIERSQU0gb2Zmc2V0IHJhdGhlciB0aGFuIGEgRFJBTSBh
ZGRyZXNzLg0KPiA+Pj4gKyAgICAgICAgICAgICAqLw0KPiA+Pg0KPiA+DQo+ID4gVGhhbmtzIGZv
ciBzdWdnZXN0aW9uIHdpbGwgdXBkYXRlIHRoZW0uDQo+ID4NCj4gPj4gVGhlIFNHX0xJU1RfQURE
Ul9NQVNLIG5lZWRzIGFuIHVwZGF0ZSB0aG91Z2guIEFGQUlDVCwgaXQncyBiaWdnZXIgb24NCj4g
Pj4gQVNUMjcwMC4NCj4gPg0KPiA+IFRoZSB2YWx1ZSBvZiBTR19MSVNUX0FERFJfTUFTSyB3YXMg
d3JvbmcgZm9yIEFTVDI3MDAsIEFTVDI2MDAgYW5kDQo+IEFTVDEwMzAuDQo+ID4gVGhlIGNvcnJl
Y3QgdmFsdWUgc2hvdWxkIGJlIDB4N0ZGRkZGRjguDQo+ID4gV2lsbCBjcmVhdGUgYSBuZXcgcGF0
Y2ggdG8gZml4IGl0Lg0KPiA+IFBsZWFzZSBzZWUgcGF0Y2ggNCBjb21tZW50cy4NCj4gPiBCeSB0
aGUgd2F5LCBBU1QyNTAwIGRvIG5vdCBzdXBwb3J0IFNHIG1vZGUuDQo+IA0KPiBTaG91bGQgd2Ug
aW50cm9kdWNlIGEgY2xhc3MgYXR0cmlidXRlIHRoZW4gPw0KPiANCkNhbiBJIG1vZGlmeSBTR19M
SVNUX0FERFJfTUFTSyBkaXJlY3RseT8NCg0KSW4gdGhpcyBtb2RlbCwgaGFzaF9tYXNrIGlzIHNl
dCB0byAweDAwMDAwM2ZmIGZvciBBU1QyNTAwLCB3aGljaCBkaXNhYmxlcyBzdXBwb3J0IGZvciBT
RyBtb2RlIGFuZCBTSEE1MTI6DQpBcyBhIHJlc3VsdCwgdGhlIG1vZGVsIGRvZXMgbm90IGhhbmRs
ZSBTRyBtb2RlIGZvciBBU1QyNTAwLg0KDQpodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Js
b2IvbWFzdGVyL2h3L21pc2MvYXNwZWVkX2hhY2UuYyNMNTI5DQphaGMtPmhhc2hfbWFzayA9IDB4
MDAwMDAzZmY7IC8qIE5vIFNHIG9yIFNIQTUxMiBtb2RlcyAqLw0KDQpUaGFua3MtSmFtaW4NCj4g
VGhhbmtzLA0KPiANCj4gQy4NCg==

