Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9583EA3F07
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1N-0003A5-VW; Tue, 10 Feb 2026 00:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg18-00033u-3q; Tue, 10 Feb 2026 00:10:33 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg14-0000Go-GF; Tue, 10 Feb 2026 00:10:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc9Rgg+l7q0WBdVbmxlqaAVFER8skq57F1SX4oB+Xsmrrzg8Nk4stZ2DbiTlwfaYQwM/cEZzjdxPoxdXa+cEt5qJ7cCx402XAZvI/tLzwiM8hkfyaGo1ygzIRXMwl2dpAhmSGX7geEAlXsxFUW8kCxQERxhskvjUkxQ8X2JR/PWdR+gLF9NaeiwfoHnC2Ec5nf0DyNyJ/oJ6QOZj8Mn8viF8GCiCLpUIc4XLrivdzAjTKveKdshEyK3UcTpR5LYEFPCIGWCmBSMSEg6hw/Rgxc0ejBTvu2k76KvMoLqLZGAGGl8pTHJEDEfXqBz+gfGmQXacoo1gMBKLqJXhjzPHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpk1TOhlBWGMKR/V161Cl9ua50lCbxt6/bOO2s/Ai9c=;
 b=QB1TD4Gull8UCowykgGbt6CnMOrDn2QnIKJPKpmA3URofThUVXrZ3lL/bwKlaywqecsqfVbhb3vll81k18/YpFX29qCyJ351H/vsfOPg7e86GwwvoEVEOl6q4UPgVjlejPnkA4Esm8nHi1d3mw6JRh9qHJJatBtQVg2i5c8gVsE7Qkflc6uEfDie3rMA+CQUHcSu2/ZEln8Elnw+/fKlBXOIxkFtVPKaGAq+wqjKDs8eeakdFoDhxeS2irMLwI4MNXl4vEL3lLA7CdyVczsB6XbLipGQsowz6a0c0ZjrE+G6zLb/dM5YFSXslSD/zNSECebxqM+2sZ2AerRGfu5zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpk1TOhlBWGMKR/V161Cl9ua50lCbxt6/bOO2s/Ai9c=;
 b=B64T9HWNo9V+3l/lQYscPKfstMd11SUVjVRustWmExmmLtfyu0nIvtgN1NiDrGi84cF6/uqishaXUgpqzPeG5X2tNuRiYXvqHip+lJpZzhlSouqZ4IQnSxJ1ePByat3t5bNrW8CSJcI534QqT/OIoSG5XjaFNd+lIV9hUOWk7ATd0nI2OiBog3cThYqp7Z1DQsbN561GIV3hTBLaPS2AjKmQdwqBvNcmjv9yBtP83nKYQ3e2/5rCeN77VZJzGwYFCxl/vVoMsr/0kkZik/cSQVnQ9AqMgGLTbF6XutAL36M2eBv7grYgMVrWH+HN13bI7FugzvvGGhJgr7vJ7e/QiA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:15 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 05/11] hw/arm/aspeed_ast27x0_evb: Move ast2700-evb alias to
 AST2700 A2 EVB
Thread-Topic: [PATCH v2 05/11] hw/arm/aspeed_ast27x0_evb: Move ast2700-evb
 alias to AST2700 A2 EVB
Thread-Index: AQHcmkuKXurPR2jpIE+SqjkBUpz7mQ==
Date: Tue, 10 Feb 2026 05:10:15 +0000
Message-ID: <20260210051008.355149-6-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY1PPF9851F8D71:EE_
x-ms-office365-filtering-correlation-id: 5a73f648-0ae7-49c2-215b-08de6862ad35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qkmuIQ8/lCAcTbmspVF0T3gsa+9OoasMg8E3fFuEVed0LB04XlXKOpcPa8?=
 =?iso-8859-1?Q?GOEO0R1fC35XSKh19tnP2xFkV+qK1mpQ3BNA3u9NUuG8VYi5/C6BkZiPGy?=
 =?iso-8859-1?Q?fp45DWYHjNGSsEvVtxT3WAROfnbMoTCZeRupi7YJuU6IGT18J0xRogyunt?=
 =?iso-8859-1?Q?XvgMeNonqpN4QWeSIXMZANSmj/4yKOTiJkBGKLZmhz4OdTz5jZ+ahtHb3g?=
 =?iso-8859-1?Q?NQB6Mex3/ANQs/ldaNABC7o/c0sZrPHAmSnF4KktjkvF9okGRfVPOrJWty?=
 =?iso-8859-1?Q?6tB4abcQBMpMcuzUWm0ZJHaPtPGndxwbaCFf9WwlKHU662qRQp2OUc2ZSF?=
 =?iso-8859-1?Q?ULhKTEhtKtVFjQrkUP5nnZPgRElxBueWY92x8G0MyyvB0JYyoZBcNGGqVU?=
 =?iso-8859-1?Q?qMioOgykVBYLxhoF5LQR/b5zmgHOALbZJOycydp4ARTWeHjB15yg9lHkMA?=
 =?iso-8859-1?Q?qvN5q7mehIxZooVraHz5VdKXCWcuJA665ywVkFah53Fc2WW/Mg+Iv+3PBj?=
 =?iso-8859-1?Q?t9NPymovq6avae3dftrsNqE5asD0kYl1eGXAiFLzL97vqUmn0MCNaDESqN?=
 =?iso-8859-1?Q?XdUZ9bHugMq1z8UIhBwWm5FXLOrcjTrMkNYJg42cJQUoVcQ52wGDoSHIxU?=
 =?iso-8859-1?Q?0o+vP42dTZLhgjvAMhyme/gGw0SopN1UxbPTpan4ubtGH6O1cmN8x2CTY8?=
 =?iso-8859-1?Q?T+2e9gR2z19lcelgdYDScHHZv+p/w2MeXe+ZV1t1iP0r4eyb3owkzUnpE4?=
 =?iso-8859-1?Q?KHXZaejYGHBFR3ORW0JjxPyh81rUzR/IUTYoD8X37lzPfVrwrxIrgH4Sbx?=
 =?iso-8859-1?Q?ayePMOSwCxeODb3QdQ2V/KfFOSgPohHPrtniLfoSea+UdyU6omGs4nxBZK?=
 =?iso-8859-1?Q?chiQhLVXQthChtxyYmgYZWcgwvszTJeq71i0m83k3fld8UxLgRhdEUZH+E?=
 =?iso-8859-1?Q?9TdF8F5nYINPKELTHP0BJBUR5A2S5FKhyanzp/kZpvT6/DGtzkfR++EG5+?=
 =?iso-8859-1?Q?8EnCPgpSwGCz6Q73MsWhXO5w0bvWKvBp49a6zOpKTha+iTnhxpIEwU+xWh?=
 =?iso-8859-1?Q?r5BGEY9PcC/dnXVHn3cvE3pe3a4dgRJVcyFNQfIC2NaCt2sazChL5FtVjI?=
 =?iso-8859-1?Q?ZqK3u6V2FOkLWIQa3NWyBX93XFcpIYPRJQT6PnC6pcleRlk6CJSANQmqo/?=
 =?iso-8859-1?Q?wAp0A7m8m7YvmC2frazh5R6VI4UZybkAJhTARgYIvsL1gGCo69cIl4EkNf?=
 =?iso-8859-1?Q?nc80MYg8ajvMPy455AKRBE+DgxbIAdRz6wFjva3ISMalVdL5E1GSXNxllS?=
 =?iso-8859-1?Q?VUkcXR+TzvUKU2kwBvmKxLhnnDcAjE2sUCaP8/q4vUpcfx+Mj3j3WJhk7K?=
 =?iso-8859-1?Q?Cn0cPUHNcu7Wn097IyWP9y1HHECTvKxD3/NW92+Mc/G5x3Ln1JiYTDZpJJ?=
 =?iso-8859-1?Q?8hcpdf4ueiX7ZcjLyNJHZjBmUw10YZU1lWgDzp0w7V/xK3z3EuzBflgLOh?=
 =?iso-8859-1?Q?xU8kFPRaz6D1UtNIE8Rxa44A/3LaJtPVrHIWM/Ixsy0th5rxTPY0Ri0iG1?=
 =?iso-8859-1?Q?NAs5Cu3zLe5C/jfecNY1HGCSowdsWWMS2LKK9JGNUmDsA9ddgJqSSh3jvX?=
 =?iso-8859-1?Q?ARdoNChSIGJJsGmmlBEEhAA7CrTcZ+qUi13Lw0nE5TOEjtrvO6ICOXa8n+?=
 =?iso-8859-1?Q?PBwWnnCAxSiq7+CzNlCUSBZIbkNy966uTRmKyPf7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mjhXO9VEvzwVnh29GBKv/6x+bfzrTh9+wx0fr7CVraJPECjLwRYvzoqn2T?=
 =?iso-8859-1?Q?qZMja9S7tA8SxBApzTyVVISTtQ9IQm/WDncpNVwgAAZRgn6RoZeDVd1DUm?=
 =?iso-8859-1?Q?TciJcwOFDgSKxnHohaTxeI3ddYgiiICPEr4usxVRRG6sCJlua2QPEWsDEE?=
 =?iso-8859-1?Q?d20rIrQKuC18Z3LLZqrggnf5LgBcsek8rh1fBqfOlC3kJ/X8iySjmzG87C?=
 =?iso-8859-1?Q?PYKLUUBtOrlkf0qJ2HKLTLBmTsxKcqBkqd93Hcl5ZwoUpEWX/Xf6Vcki+y?=
 =?iso-8859-1?Q?s3oBQr8/dU6oc48f0JVxBcHoRt5ufi9YvuoS79fArTg0oGBm7cNvTzG5Vy?=
 =?iso-8859-1?Q?DglIRp/CRniGcIfrNuA3PiogcwVpZiOo8zK/scNyxwtz5iGWIRJ72BAOya?=
 =?iso-8859-1?Q?H5dRbWIIxQYu+R1384fUgMjqEkoeKfSLeAxaPOvKB9whuFEC7AdWOzm5Qf?=
 =?iso-8859-1?Q?jPtcAAhMBRdUsVrHFv4sRCf5SVcJBH48bO1n/GDhVOkPGdenJFapW21dzU?=
 =?iso-8859-1?Q?s69+Zbwrc5ehxQTKd+dFDoUMprSRDMdtz2EHugBP4XMbJ/2XyJXjbJR4RG?=
 =?iso-8859-1?Q?3XEv0WyD+mTzk1+m2W/yIbJGZwXcfOeypr+ozpciBZ2wkfvbK4EEkZcYSU?=
 =?iso-8859-1?Q?vID3BQee7wFTafEx7idl7k+vDScjkiCQW5edjC30e7Z7shpLcrPz40+Dfi?=
 =?iso-8859-1?Q?bzZVPpmKRbFFvBgDk/I+6UT+YIYKS5sw/dPDm8RypNisxCHZjq+GDuZDd+?=
 =?iso-8859-1?Q?ZedRbmzStAea6z6GFJg+5hHBPCXnkHoeGOaZY4FoHdzER8SOqH3TBkeaHk?=
 =?iso-8859-1?Q?ihcRMVE3zYXNUWYo77/WyT/OHW5uHCTrHF3c+akEYC11CWOYlY19xuP79N?=
 =?iso-8859-1?Q?q+nuYa43VYGw8EPoPV2Nm2pHa0TfUMN2YWP8EG5zUzQYLmXegipDA8ofOk?=
 =?iso-8859-1?Q?NjdZRjUuaiq6slsdTLbUY5rjT6n8ZuP9RSeL4dcJJdhfZzWFnCNH7lBd92?=
 =?iso-8859-1?Q?kccxDvmJO2PaLv6Fx9fPeXseMLDe7aRzwU9Vm14ZNnX7LKZfqztOohs3cz?=
 =?iso-8859-1?Q?AUYt9HooxJz3jIM6+uYQVb+VzXNJ4jcU4Y+SZvAPVgt5lpyzEOv2Ex4wFD?=
 =?iso-8859-1?Q?1ZzEOvggnNPAqFfj6Z8SBEIoHSpJn5XywNuvjDAx0hFXflNH7rGuGFgr7S?=
 =?iso-8859-1?Q?VA9N9Yfur+g6X7cOe+cX+BVoNLq2NEc7xBxaXBMMmuWLX68fDMiUZZOHVe?=
 =?iso-8859-1?Q?EjefRQ3hDnuXkj2WmW+B0kk8GJ7/le6IgXkFaCJjD2E5WocnIDEYk/Y62b?=
 =?iso-8859-1?Q?65KKvRWqTLW92fpieqxncI3/W3U6YBB5lB6MOW7mpPzPqNtS8oLnUl8QNd?=
 =?iso-8859-1?Q?NhLZEhw6clRB+5/p5oRShoOlLKQrcyKBS5NHNmX25DShh1lYRa2/5vMCCR?=
 =?iso-8859-1?Q?vK9K94N05cPVbk9xwpFm9HqOijHVX8QylQnLpeYHDeeEiYCPE4uPzGuPYY?=
 =?iso-8859-1?Q?UDeEuRHdxtc/DTd9LKlUIVSocJuuuORUvcXEX9cZ2g+uSw/4HJjwv8xrxq?=
 =?iso-8859-1?Q?3XmdQPXdLAEfY8oiemdDptB1apQWYsHpZ9n6OqLfu071bNO9VmOyQ6OYZ1?=
 =?iso-8859-1?Q?UySjh0SlIy5of0Nb5Au0RUafMORgUEVDYxJZIxD5boIEtNdfaDmmRvHNRQ?=
 =?iso-8859-1?Q?F8zG6u1SZhZAVzmHeicr0GvuZZXzFpx4X7QKXw7WN5MM5ihDN5FqaQJQZX?=
 =?iso-8859-1?Q?Cko7YA+Ns4KQh2yYkamSoPsN1AaKhS2WBYdXg735Jp8/V/WvcmKQvjMNA1?=
 =?iso-8859-1?Q?XeqXmYmmaw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a73f648-0ae7-49c2-215b-08de6862ad35
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:15.4966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cho3vQxjjw5KU5v4W+B7vk221WgissY9tZ8totmXFiAB4kM6IZ3umjkHPeNSfeYKas2DZQD7/UIT+i5CHoiBoZWPKcyVnfIdasuxGKWxikw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF9851F8D71
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make AST2700 A2 EVB the default ast2700-evb machine.=0A=
=0A=
The "ast2700-evb" machine alias is moved from the AST2700 A1 EVB=0A=
to the AST2700 A2 EVB, making A2 the default evaluation board=0A=
for AST2700.=0A=
=0A=
This ensures that users selecting "ast2700-evb" will run on the=0A=
latest AST2700 silicon revision. The AST2700 A1 EVB machine=0A=
remains available explicitly as "ast2700a1-evb".=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0_evb.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c=0A=
index 32d944848e..0ff1bebeb0 100644=0A=
--- a/hw/arm/aspeed_ast27x0_evb.c=0A=
+++ b/hw/arm/aspeed_ast27x0_evb.c=0A=
@@ -34,7 +34,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(Objec=
tClass *oc,=0A=
     MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
     AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
 =0A=
-    mc->alias =3D "ast2700-evb";=0A=
     mc->desc =3D "Aspeed AST2700 A1 EVB (Cortex-A35)";=0A=
     amc->soc_name  =3D "ast2700-a1";=0A=
     amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
@@ -56,6 +55,7 @@ static void aspeed_machine_ast2700a2_evb_class_init(Objec=
tClass *oc,=0A=
     MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
     AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
 =0A=
+    mc->alias =3D "ast2700-evb";=0A=
     mc->desc =3D "Aspeed AST2700 A2 EVB (Cortex-A35)";=0A=
     amc->soc_name  =3D "ast2700-a2";=0A=
     amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
-- =0A=
2.43.0=0A=

