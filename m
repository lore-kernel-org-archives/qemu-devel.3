Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5112EB594F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzmG-0005Pm-W8; Tue, 10 Feb 2026 21:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzll-00059L-8d; Tue, 10 Feb 2026 21:15:57 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzli-0001ez-UD; Tue, 10 Feb 2026 21:15:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKFkhEIrSGC2M9xvKgqvbO1ER/bFefQXV4ShU9KJ2j1TmuF1eOOJe9O4dgYmIPJKe0nQeP37JCag4sGAWvQglTNWWvP6bG+OCbVc1+RspeD+q9ZvQPsVsHBIE2rcK17OwiYFTaCrosrZ83mGaxR/ehcyGgzZDEoTKzrCz9aZk8kdxbL8LahKeeGlKGzrya8ir7G50Gp8pEcgs1AcvADjQuO9yMNvAOrp1nHbkSLBcJ5HDXtj5DV0FK1k2AJPbg2U4EwGAx1Q9bXYu4KWqGYeeS59zQWzhGudpYBwThNDHzOU8lk76VXhA5+xK7GJQ2v4FMf8XCOMLRKlKmhl6DRLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07EAgOjzdZTNW9LZ+Xu7cUQ7snaN16ZT/XRVu6ks0WQ=;
 b=HlPYkcWvgxvjoZxSROWFvNtggqLCW7kKqu+XPXLr01LkIvkqwkYnlTkPvYOfZyCsX+ihLyFHj48ZPqI+RuqHOhFpYgNblgvXmOGc10+IwQG+4mC2M2HPB/h+gPbBlFc2mkiHUMWWTQCU8YY+tJRPU/C+FGpZHTsL74+FyoBqucgORdkMoWDTQsVJllOVuI8VU6Cvnt7wPJagwztQix0pxUv089ZmBBjAfwaTVbPRcFTh6GD8way9zGulqxGUQX3g4INQCWB/S9Fo6eH44+yU1yciD2+X70K8jGQJrpVXUO5hyNeco/neX+5T0YpjwuUPzDiqNQ34HeF63oF2xGINKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07EAgOjzdZTNW9LZ+Xu7cUQ7snaN16ZT/XRVu6ks0WQ=;
 b=ZjO7S6xb7KhgKi8/BEFvJsYV4ojKTPCs8vjDzgfyI3EwXC7M0Y3UEZvy2Hn+CSOnG09LhGS3OUaRo/VWjN27HgS7FO+kTGmarFoDL4wAGyU8g9tWdLFp8QpbnBIP4CrWXBaICNfSbzKE5r55i+4SLc08OzwsEotPubthivvWsw4ZcTnKcu5/44D/3UAdq6Mhlv6ByTNYw6lFsIdGVP40uKsoWtpjUTxYG5Ri6yiKgfPTSPXViSP+F/O9igxkZBl/oEwMvsB09fjYzI5AGQ1osH8ajdmqCKPFcUZCRJZNgC6p3DFefdRXmrxlwpALwwp7/5bYnKDX8SOB9njUbIExDg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:40 +0000
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
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 11/11] tests/functional/aarch64/test_aspeed_ast2700fc: Use
 AST2700 A2 SDK image for FC tests
Thread-Topic: [PATCH v3 11/11] tests/functional/aarch64/test_aspeed_ast2700fc:
 Use AST2700 A2 SDK image for FC tests
Thread-Index: AQHcmvxRGkaEyZc/dk+2jw5+K+d+qw==
Date: Wed, 11 Feb 2026 02:15:40 +0000
Message-ID: <20260211021527.119674-12-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB7994:EE_
x-ms-office365-filtering-correlation-id: bc280dc5-fcc2-4fd2-47d4-08de69137430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FLUAVIkWjFqwv7wnn8I+LFdcvyD8/QVjgA2FyHfEmNDpaZJz63/H/X9RG3?=
 =?iso-8859-1?Q?H4DfhiziszYByfVSxL8xLfkcPI0A4qapY5iEgG6Uo07rGGzDQIYo6irVYL?=
 =?iso-8859-1?Q?WJDPvcl8xYZ6RtQNkYTVOW0Sp4HEccE1wHBa9HGzlZI1xa4D+N7NTHCoXU?=
 =?iso-8859-1?Q?3v5yEE7V2BTcnltUFVz24F809gUAjU1VTeA4688KjBtoqSl2Z0/Kj7QFON?=
 =?iso-8859-1?Q?Dq4O3QC/HWOm/BMjsOr4nSBYoujI6rnpOUNkpGrrTUCxDw2J+wMFqywpUm?=
 =?iso-8859-1?Q?RRo9NLnv0AeuQ+SaUnGHldd2kadZ3nuqBrrNoT0g7Q5ptkYWuV/U81H3lQ?=
 =?iso-8859-1?Q?t+42nXyMQtkLSC+BvD9mTGzeeWLA5OBW+GFpo7se3GdflwAhsWUbsf/wWz?=
 =?iso-8859-1?Q?3NqugQSVbaba8Yb0ZjsAi+n+b/ilEKKKUJUb0Rqpyn4AUHzcnTxTUfJM5X?=
 =?iso-8859-1?Q?p996xAycyrYlXaPyRkufRyrfc3WG6XwIagKvFe+I2L/1lTKGS+ENMChs7G?=
 =?iso-8859-1?Q?HY1f7aE6VqWsfVsfnEiQz/ydj1oehpU5fs5CtJMI0CrgJsjcrsi25UydNW?=
 =?iso-8859-1?Q?Z/vKjBdXaxXRu5CW3cXUIPJAIcwFhDHorRHNsm5Xoz9N+8lOiT9UywyVxl?=
 =?iso-8859-1?Q?0oLuKKku0kBWjZHFdBrd9Oo7kXMwMnWqWSkjDukDrZjKBxFvC5mzPl5H0u?=
 =?iso-8859-1?Q?0mYIiHr8Zgbn1h1Km81eOyRxKFz+COoFiIT/ZK/0UyvCYmFs31qD5aGx5b?=
 =?iso-8859-1?Q?l6mKHL+AduFXqDC5wWakhTZQB8NHho1CrAh0T9vVMH5ZVcHjPqXnTt+/F0?=
 =?iso-8859-1?Q?sugAEo9+L/lrjmH7jL7FZwN+ADu6oERqgxYuBGGLKFgmMnWAsYz/Qtbwrv?=
 =?iso-8859-1?Q?LGfDS92hiMXxO0ZteqPXV2RubKfoPVExxB4RX7vzAGi7dE8BIilQFk/M8O?=
 =?iso-8859-1?Q?6jAjx7pVOGhpHUBt8DXMvIRQFMvlkGiDZTuQ7I50mzlTbGeV2JLr5j4Gs0?=
 =?iso-8859-1?Q?VYpkWg0zEP6qZK107BiAsdBxmR+Iltf2jHiDp2WbhRoHw3CwtNC4GDkGT+?=
 =?iso-8859-1?Q?+8jHKgqEBoNqtcWLXvNeqCzsSOzswYE+YmiX4k+NMrAMp65ckYtmwbcP9h?=
 =?iso-8859-1?Q?m45hmbUGI8+sIDaUbK53hAPFOjn+fbOBqCc5lX4DVQBWIZvXu+aBvz91kI?=
 =?iso-8859-1?Q?oFyf+Vgw11e6xTJbwpeme/hBf6NtDDVWuMTg4teiQqtrmDGaKrscYnY2La?=
 =?iso-8859-1?Q?MrIBJB8y7EriTXALWzTv72oXlZxv4jKQhnbQTtC/IE7N4NBDZu/eJrsHRB?=
 =?iso-8859-1?Q?e3yMoqIvVj9EFMp227Gj18xXFalRRnOixL0X2mIWSsJFR3gZGChYrpCgto?=
 =?iso-8859-1?Q?KUfqF1OSwZtQ0ek22j05IhB88k44eiK1ZluqIz2D4YtezMg6NaepAjKD+m?=
 =?iso-8859-1?Q?HTfSq8o238/RWih4hRnnD58eCOraPmOp4ssgXW32caaY0QkEFZQes9LyLM?=
 =?iso-8859-1?Q?uFXn0t4wI2R6Xorcbrao3AY1sxaL4ju3oOKS0jx5dBusd39b9cEqTvamrW?=
 =?iso-8859-1?Q?eOuM/U+ttdKaBZuqSs9LtnIE4dbGJLsFQB9y2NKc4aPYV4em09u3FgfJFw?=
 =?iso-8859-1?Q?k7SpBzVu+6Tm6wQCacntlZuE+KAtxNUuHnXZa7GfE838gVa9fEdltuHA?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6MvabyZWUXhayeNfh2ru97ZbwJdBOuFobe8O6FKuVPUTrRY/6GByJuH4fw?=
 =?iso-8859-1?Q?JTU2I7wAJLiE8TFFQHr9LMpnsh27gy92wUgnKELZs5ueGfTiRj14290uqj?=
 =?iso-8859-1?Q?4GPsC+KOnM+8QRTJi2TYUJagw0hfoxi3GOF2mtAWcDXIkSIqDMnbITiPja?=
 =?iso-8859-1?Q?VQ7tdcVe+02yOXdfCHK8XTg6St+DRcYEQt7xn2nocQbsQF5ASSA/3eAO+0?=
 =?iso-8859-1?Q?3oHVa82XbOHSxgDlTP2orFBSawos8BeCquAYyWi6cCs11zj0nFOF+aSex5?=
 =?iso-8859-1?Q?WdT3W+J+XsDcRSRrDmKYnd+hUqIm11puuRlm0Y9Tcxf3xxANqLRNxPvKrE?=
 =?iso-8859-1?Q?5LfzjMVC7jcYxOttdxRPinrD2NRpAbVeawItYM+wXsfYzcgntg1yR60kp0?=
 =?iso-8859-1?Q?LK3E+HLtbWJ0L2yHVWOYDzCzyBtixxJ0dsQQEELOIaxEz93/I98wlIqSXF?=
 =?iso-8859-1?Q?naZ8LuXfEzPDjHo2vNK5gdW/gpVUT5JlSZxzHlnk7HS3GxCDprFck3ZOYM?=
 =?iso-8859-1?Q?EbW58t8u+GHhUa+NQtSZIuOCWXHBfxANii43zvxCUPuxrqeiOSnn1C/nNv?=
 =?iso-8859-1?Q?HyRFgS0bOUXCujPYIhAhdxM9d3lyWzcpuljdNoGoMFthuxEffJjrK7w2be?=
 =?iso-8859-1?Q?rYZP3sDyoki8V7jpEl70BxDU1LRn6P/W3R9r1pSu2aeotfxVoHNf/w+aLo?=
 =?iso-8859-1?Q?Kay4pQY1XA2AYLX0EbK4K6xXBpB2r/QUHDEB9IqKoiW2rCF7800Y9fdw0N?=
 =?iso-8859-1?Q?9Jta99KkZWd1pIRgpsVkSLPavOT+KDJaQpCsyZ7bhm3Ej0MeQEDqA+aO2w?=
 =?iso-8859-1?Q?uUX/HLtJoWgwPjGJ4/5nIyeODs1EwwqtIO16B2/ncAQA/Az4ghCp3Cq6zi?=
 =?iso-8859-1?Q?QQwTnasthxbBltIPcqeagRxTd6mRfvyqXhmSn3KQ77Vokjh9OLwFRAl754?=
 =?iso-8859-1?Q?cbFcM7wkG9i2s0vsEkC++xKWD1/nBAWTY8/j01+qzp7UnJ2nIO3T1uzwP7?=
 =?iso-8859-1?Q?rHYfyvVSxv3bFq0SESADZDuhEK9lXEEBO0K/6BKcg2a7e47dlmpiMuCE0S?=
 =?iso-8859-1?Q?27wTR4wsdHB+vhT1JrE3rOVkvw9NoNIub9GqvCDoUB7ZcgQlPdext3Pgp9?=
 =?iso-8859-1?Q?cAOiHVUYo0icTvr5f7vCbAWRycxQrh3vqYmHKXovqRPn278k47u0kA/O3b?=
 =?iso-8859-1?Q?ARKIz8RaBKNRsKveoOAzWodvq6yR4LoTkSp+nAxkLxj0wkBYvQsBaQlZzr?=
 =?iso-8859-1?Q?CjM/je7rk1/Rj6qvKUHfwC5BrTbparHtCDXBRHUp9pc1yRr617rkX4JR+H?=
 =?iso-8859-1?Q?6jMBKY36st0nz3SN2ktkxtv+yeIFr0uPT7zSL7+I11QtwENaKs+enNgtHP?=
 =?iso-8859-1?Q?2IMG2gPsJFMuqD+YNW1JPcGHEMxLIXV69af/2DtRkTdg6jn20yqIZvZD9q?=
 =?iso-8859-1?Q?v19tGBkTlJ4FZpxyOss4FLFwU9lJeD+VuaaX0j4J+DO1kVI0mtNiguIZ2o?=
 =?iso-8859-1?Q?jHDGt53Grf9DuGTZqzwjo8ZsasGqKSJlY7cTJ/735qZdBAmv6CStyTGTBK?=
 =?iso-8859-1?Q?f8NpDCCo2VEoTSlGoBxjySuFyehY1JDmXkl0Xl5kukVmHPICyJcFzzTdJE?=
 =?iso-8859-1?Q?o9Eil5w0a76wFVn3CaNEUZLh27ngC/cw6nFtcfLZZls4ir7xnDlRgy1A1T?=
 =?iso-8859-1?Q?ESegue8RV9Hm1ql1B2u4072Jzz/bE2gBgU0wcLCpYsMvWMvPGRZl+VhVFQ?=
 =?iso-8859-1?Q?SzXk6kfhVyaPl1mpr2cwLF1lcWRSeunvTY1oEGJXkY5+C7F6RVGjRmWXTw?=
 =?iso-8859-1?Q?CC2v5T94/A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc280dc5-fcc2-4fd2-47d4-08de69137430
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:40.7224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3i8bDZDgG03nMQ30VsNZ7emqLUQareVyA7+0KXXXzwXhQw9gRYCfDjzQx9Npdw9ZBcg2fkNW3jQekQ0+V+61mQvB+GN4gMAtze4lSYQc0G8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7994
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Update AST2700 FC functional tests to use the AST2700 A2 SDK v11.00 image.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700fc.py  | 16 ++++++++--------=0A=
 1 file changed, 8 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 47e56dcfc5..51ee8bc787 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -62,8 +62,8 @@ def load_ast2700fc_coprocessor(self, name):=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
     ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -98,7 +98,7 @@ def do_ast2700fc_ssp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def do_ast2700fc_tsp_test(self):=0A=
         self.vm.shutdown()=0A=
@@ -109,7 +109,7 @@ def do_ast2700fc_tsp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def start_ast2700fc_test(self, name):=0A=
         ca35_core =3D 4=0A=
@@ -153,8 +153,8 @@ def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
         self.require_netdev('user')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
@@ -164,8 +164,8 @@ def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=
=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-- =0A=
2.43.0=0A=

