Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC02EA3F03
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1R-0003CH-GP; Tue, 10 Feb 2026 00:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1L-00037t-Dd; Tue, 10 Feb 2026 00:10:44 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1I-0000Go-Gq; Tue, 10 Feb 2026 00:10:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL4Wtn91uvS7OcVuygQgodT1iHCj4wGl6XRzSwZ1wJEVUYxXXYXVpe7CShxPPST8uGMhtOxyi55QNvtWaIMdcYQZxcw/zd2S9zhIX6jW6FSvzVzWdl9R356LyMSRkVRsscF8oozerJ4tsfLka+iIxwH1p1yFM8j720oeByrF6Grhw+EHUatdAA4cSQ5TFN7t/w92eHksw00rW1KHKlB6Q2kzZdcbsyhtThZrQH5jxIDOr+L0ARsZ75yd8W6oxS16oUJXM98hlleuTW1xU55WFB7DIzGOQ9RhNpZA0IS+u3f7VQe88dfWFMyF+RveRbsrGXeIkp0oO9dp0m9XiUjXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br+QEf8Nj8kSFwTCV+J7cXjK/u1NBiM/tYaDeCxcdWs=;
 b=dXbvo+IRn2UJtznCaEQAKHZIW/b10OXY8AAw+aQ1tNYO7cM/zIxiQd2bynW75SPdGtn6L4XnL5DanC0ojD5Urch7o2gEXheDaJ8X95L5bqTPCRlxtjBGH7BoFtWJzxDhE/4Ac1CxvHBBEjotfcD57/GGMVMm/wcthR0hbEAkuxBGAV5JgyuSpYMrth5sToM9/tTFShEiVQpCGEub3m3k+KJx9Xc1zIZiEhHAL5y2JBVrDciani7oIsKdDkVmphpcD8itrXSSc7rYr7r0H1RTn2BUQ3bt2KQYLw95z+rfiWQxtW90bZRkWKfMQQIyoibHcBRDIiJK+1BHSpQQKtOLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br+QEf8Nj8kSFwTCV+J7cXjK/u1NBiM/tYaDeCxcdWs=;
 b=awteZQyK6WNoRV01q6nj/rw3SWay0rkaXBezL+W/KywoTdhHh6Fyndy0VYU7jtT5KTfgGADA3kP+oKeG4KDH44O4rV7++DmBvRVMvngmQMLLgBFrXJk/nHZ6xy5JARRhiRdaaJhReO0ZMqKyzy14SPlbUipf+t+z6L3JA9eDZ2ZmEHWwH3MsNoNn3K22nOOelwHxbpVd1rMiA2bJJzicErwz8lK3fuRafyNiNuAiQWAQZSI9bn/5GWHP+okRU/asJ4UimrxCgdijII0larZVX6G+835ZJi3UDgnNB6MckJk8pEpWuyuutVaw9xREWpGTJIftgwVT/E6GqPUc5OkgkA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:18 +0000
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
Subject: [PATCH v2 08/11] tests/functional/aarch64/test_aspeed_ast2700: Add
 AST2700 A2 EVB functional tests
Thread-Topic: [PATCH v2 08/11] tests/functional/aarch64/test_aspeed_ast2700:
 Add AST2700 A2 EVB functional tests
Thread-Index: AQHcmkuMY3Xq9yXsV0qMkx9bBAe6vg==
Date: Tue, 10 Feb 2026 05:10:18 +0000
Message-ID: <20260210051008.355149-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 7394f46e-8cbc-48da-f678-08de6862af38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AlRfqu8WBgEiTl+THlQkb6NwS3jA+sG/QiWFxbHrW2/7WQ96VYxGVpCk5l?=
 =?iso-8859-1?Q?/KtlF2+e8b2XfSgntQwkmulVmemC8ybtLojEmmQJH1bWAmA+XYObp9yXtG?=
 =?iso-8859-1?Q?5Td+6e5LZcIxms5jxF7jVcjE03yy/1b74345nuN2nx3jDH46fXRS7IAKn7?=
 =?iso-8859-1?Q?LdKgZjkEAB9srjpzOE+NoWuByNKDDRTICdN4vuUsZOYmsegxX+auiEk6Kt?=
 =?iso-8859-1?Q?QYHv46+1X2R6ktkpTxqZXegKLDaFUFkf0ssuw1Cexg+ZPCeABCfULTMEYX?=
 =?iso-8859-1?Q?q2d5nzkWDSKT6dVsx71ZiBd2LNYpN2o3mvlTObgpMKpiUeKbomspSwYcyn?=
 =?iso-8859-1?Q?M0iZ39hMJrSLMYyS09ke7JqiYXoyYruHBAHxOY3ilhx/xWj4tKIDSU/mtT?=
 =?iso-8859-1?Q?MR9dnbBU20NdqXviRJeTBDX8EV0sXIv6Z/cKUNh2HVRKK0p1Z86QL89ENG?=
 =?iso-8859-1?Q?130JEDIG15rMlRxZCVwCg6BKMxjgTaUAUWvJVenbytOlgUo6rg9IRpfLN/?=
 =?iso-8859-1?Q?D0BN9MJJgyWzqWzU49XD947fi8mwT2vwexEZLlqumd7RdWsPHlWcRLBg26?=
 =?iso-8859-1?Q?tDQr5iQmyUaRTy4TnMwa0B/MjKiOoM6oHA9viO9m+X/Q+8u9DxwQFbCW+Q?=
 =?iso-8859-1?Q?y0hYn4UEbf93dvuQh0SapWqNjVSM5uLjqx2Jt9nji53793kqq8TtKEXc3K?=
 =?iso-8859-1?Q?4WIf36fOaSbHEvemjZdh+2ki90BnzoGsPOZVpixyRmc3LMPxwUauLguTal?=
 =?iso-8859-1?Q?9Vk7LdKOcmz8SlnyR+fh/nV+eiWKz8Z1MgbitTLoDodMjH4Shn5b6tfViP?=
 =?iso-8859-1?Q?kAg16zA64XwBWIor5fq4PSO1+TNmBblZnDYXehdVXh0FTJT9/+BdDiqofX?=
 =?iso-8859-1?Q?gPnW/IJnf6YfC8HU+bbAhZaA6NkNcJ+nM3XMX3j96FttnaSGYUPEg4rx+s?=
 =?iso-8859-1?Q?b0VO+VOaeMCA/qQxU6J5drXPGbRye0fT8UM0mHACkgx7fCBw7yBavGmiTF?=
 =?iso-8859-1?Q?FKf8qwvf1VSevlbCVEzJQaQFm+JhtVtx+ZYUOp8XoZmynU3QhlNiBDZlK9?=
 =?iso-8859-1?Q?vVD3O1OoHgad4xLgt7j3s10/Gbz1beHcFQAjdGEzG2G5EGZ3LPP00Mm0Dc?=
 =?iso-8859-1?Q?w6RNDUGsguVQvBuMRD6K6daLWVfLrN8qXvtFem02v+ghKL2oO8c+jo8Jsz?=
 =?iso-8859-1?Q?kBBOhLhnl3M8orDv5SF42OuyiuHeNC9Qgc4bahUu837q3izQnRUdGtpGkI?=
 =?iso-8859-1?Q?4w5710MNzyJmnKCFNk475MJNd4pZnV7GG6uuT2LpYxLrrAjVaKSTLCJ1jV?=
 =?iso-8859-1?Q?jM5888OUbv4+KKpKtkcA7+DXwE24VUycLJrLybGJWcRnbR4wotAbgTJCAv?=
 =?iso-8859-1?Q?BwBU3bxKZHlIux1arkUNYTAogbjNl5wV8bqBMScwOjkKCPDsSs8Q9WRRYB?=
 =?iso-8859-1?Q?a9rRANtOnHtt+VeUbb8ZR6PNITPuWCrac+UwqVvYWKiPgvvPLLcPII6hDc?=
 =?iso-8859-1?Q?I0swzko7q+Waeri9gC2/hEB8HhlkuMAlu5HnmWYm7O9LqK3xMlas+A4ByF?=
 =?iso-8859-1?Q?EgbA+GaAPTZ98PuK48E31G2uH9bxZKn4CVe8MCnJPA4H8h/KWDuiG065F/?=
 =?iso-8859-1?Q?OP/sK5chgg8j+lkvzWcvW5/SyUGwF+CdeK6RyYYzH2ysvvcqWo/MQDuQ?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7142099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dXMAMZzRoLrLmAPjOoss6QwoF/f2/kdYCkTsF4NvHE17eZa3QHAqsMKwEQ?=
 =?iso-8859-1?Q?114ECWrMFOZ2vQkkz5k/9AOEoxHqiLFZ2YqWr+VmTkTW5KrN6iavQ9c7g1?=
 =?iso-8859-1?Q?V0swDe0BEvWUhSSfnQR9nlgupmJvBvXrIjPyW8Et79CMpgXYgkZkGduDAl?=
 =?iso-8859-1?Q?j9i4JqQhN4BRMxiebPW9iLGxcZPldygxiKj66CkWdzNM5ieubQ2DNJclWG?=
 =?iso-8859-1?Q?tK4Ncx9guIVNdU4M7lrRlUoDXV7yVLQ3pR73I5AXDsQWLrIsypOhYjuN5Z?=
 =?iso-8859-1?Q?YEXfcYgkUspWvY/yNMoJJDi/vG0XqsWT+dzl8ZkltLo85uQ5p8viSbPLTH?=
 =?iso-8859-1?Q?YJQd7esWNK5UNLvUMa+yhc2uG02yA3rWOPLLGbXBr5Z2AnhyO9HcML/SJM?=
 =?iso-8859-1?Q?tGaycqwAxXCpEHbg1fiiQm2yHlPUsz/CY5pfM9cZT9dVCZffF44q6diI9+?=
 =?iso-8859-1?Q?vPYlFiO44yrRPecLISxX8D9keDhkw/rMMSEXRVdefKMleBqEjgpXC2+A/U?=
 =?iso-8859-1?Q?Wgo2XnI6737QT39iFXGW1p9Z+gFMxTD/mmqjVbjMkRYRRLKcAm0wWKavTi?=
 =?iso-8859-1?Q?fs2lNtt2jp3quG9CGkFirFfjorWj7M6eS/IY+2VbtpU/ZGWcCC4wELNvlc?=
 =?iso-8859-1?Q?Rc6OG+Fl3VhzYz8ykTG5W1Z/9isbDr1nD72aa3QrDnM/M3TurRefdKJp2V?=
 =?iso-8859-1?Q?mGgJknlSxotVyozTnwG8DrQnhiUDs9tWRCPqmlHxQIwPsg5BthuTh849Zl?=
 =?iso-8859-1?Q?fkYiuHLjkWHNYrjmtmUH8AIYaTdTp51C+3K+0/geXuhqwui0PeZSlwITek?=
 =?iso-8859-1?Q?cC0O2h2QU/+4lWrYvw46v7xaj2PZXGIegZhnYeU6cfnWNFwIUtE+APqSBy?=
 =?iso-8859-1?Q?b8E5/QQqBi2MsZPdXCaOCwB47+nx/VZD+fj1g3Iz7L8eKvYS+XheP+6Qw6?=
 =?iso-8859-1?Q?Dzus4OJOLDifr1l9+11nGB2iSSVJ8Gb0cREswVNb5dKG7m6/46A68LKi9m?=
 =?iso-8859-1?Q?JRKN3BKftwggbHAK31vMSnCuW8Ww4bqxgu1rX3p7upXH441zpOz1Sr2eKH?=
 =?iso-8859-1?Q?fodGgaiBVVrSDl/TcA/LCHpKDsfYzGxSpc6/V+2m5QI89if8L/WFdieQfi?=
 =?iso-8859-1?Q?9tyKWPGyDz/YYV5HUC/QD9cqkcaphzSx4HD6087oycXKB31CxzfouGbFc0?=
 =?iso-8859-1?Q?JoyKC6YHqE7CDSQAgwG30bH6WNQnr6J5M1D/SwB8j3kjAE008chOOrOfQd?=
 =?iso-8859-1?Q?JQS3Y7rg4OeWM6Dh1Y2doVxQRz4wLd2LyBNu1Nt/amvm7oRduteCM2d2SW?=
 =?iso-8859-1?Q?uTNWZrpqMP5pvAfQpJkhqyYNlOqI+zhE7H+SA3S2xsRDRom1761lnLw9MA?=
 =?iso-8859-1?Q?u+iSuAceEvYGnwxHhNHgCO7c+vlmlxmlq2050iPYbMT1dKzx5RWYpJaG4G?=
 =?iso-8859-1?Q?ftVYviXXkP6TmB1+nv8Iw2GXXYexDBSBYSqOAWnaD3Z75jp02kf5sajbHt?=
 =?iso-8859-1?Q?mo+fQ3uIWz7qcEX+dkJGCiRAn+hsGCwJUxr7/zrR8I7MqOo9e7XjkaYmUa?=
 =?iso-8859-1?Q?b3pgJ7wsOCkf3Irf53b3y39HQ6VPp0YSrMeGPNhHCSfF/qcZsJ+wTtA8vK?=
 =?iso-8859-1?Q?pEdIRPInNmCLhrYVoUzzlPPXXhvbWJ8m6LR8MpjTggBQOSQhXMN8aVchwe?=
 =?iso-8859-1?Q?3dJ6+pqPj4zAMI8eOTPrB4gjw0ziRJMTw8AP4wVoip8yq8Oy2hxTg7vLZc?=
 =?iso-8859-1?Q?3xPz3SAUxcT6NO6DU+fwVCVFORBfUrfaI59sGfu9DIrcyDdf1SL9fXSiGA?=
 =?iso-8859-1?Q?uBifNEgjKQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7394f46e-8cbc-48da-f678-08de6862af38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:18.8585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYGQjMOMEIX8a/ghDMPlLqJcuvSbBjq5bFfKq8hzf8/9MwHdG4jjTLskSi8sHSyWvHKw/X48QmB7y+CcF+TFvYT/Jluy7l/yTiwum3L2+NA=
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

Add functional coverage for the AST2700 A2 EVB machine by introducing=0A=
test cases that boot and validate an OpenBMC SDK v11.00 image on=0A=
"ast2700a2-evb".=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/meson.build          |   2 +=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 190 ++++++++++++++++++=0A=
 2 files changed, 192 insertions(+)=0A=
 create mode 100644 tests/functional/aarch64/test_aspeed_ast2700.py=0A=
=0A=
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch6=
4/meson.build=0A=
index b5dd674bac..1bf0a30a9b 100644=0A=
--- a/tests/functional/aarch64/meson.build=0A=
+++ b/tests/functional/aarch64/meson.build=0A=
@@ -3,6 +3,7 @@=0A=
 test_aarch64_timeouts =3D {=0A=
   'aspeed_ast2700a1' : 600,=0A=
   'aspeed_ast2700fc' : 600,=0A=
+  'aspeed_ast2700' : 600,=0A=
   'device_passthrough' : 720,=0A=
   'imx8mp_evk' : 240,=0A=
   'raspi4' : 480,=0A=
@@ -25,6 +26,7 @@ tests_aarch64_system_quick =3D [=0A=
 tests_aarch64_system_thorough =3D [=0A=
   'aspeed_ast2700a1',=0A=
   'aspeed_ast2700fc',=0A=
+  'aspeed_ast2700',=0A=
   'device_passthrough',=0A=
   'hotplug_pci',=0A=
   'imx8mp_evk',=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
new file mode 100644=0A=
index 0000000000..64f0a5abe4=0A=
--- /dev/null=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -0,0 +1,190 @@=0A=
+#!/usr/bin/env python3=0A=
+#=0A=
+# Functional test that boots the ASPEED SoCs with firmware=0A=
+#=0A=
+# Copyright (C) 2022 ASPEED Technology Inc=0A=
+#=0A=
+# SPDX-License-Identifier: GPL-2.0-or-later=0A=
+=0A=
+import os=0A=
+=0A=
+from qemu_test import QemuSystemTest, Asset=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
+from qemu_test import exec_command_and_wait_for_pattern=0A=
+=0A=
+=0A=
+class AST2x00MachineSDK(QemuSystemTest):=0A=
+=0A=
+    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
+        self.require_netdev('user')=0A=
+        self.vm.set_console()=0A=
+        self.vm.add_args(=0A=
+            '-device',=0A=
+            f'tmp105,'=0A=
+            f'bus=3Daspeed.i2c.bus.{bus_str},'=0A=
+            f'address=3D0x4d,'=0A=
+            f'id=3Dtmp-test-{bus_str}'=0A=
+        )=0A=
+        self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',=0A=
+                         '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+=0A=
+        self.vm.launch()=0A=
+=0A=
+    def verify_vbootrom_firmware_flow(self):=0A=
+        wait_for_console_pattern(self, 'Found valid caliptra flash image')=
=0A=
+        wait_for_console_pattern(self, 'Check flash image checksum')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read abb header')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read soc manifest')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load atf image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load optee image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load uboot image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load ssp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load tsp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
+=0A=
+    def enable_ast2700_pcie2(self):=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'cp 100420000 403000000 900000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'bootm start 403000000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
+        exec_command(self, 'bootm go')=0A=
+=0A=
+    def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=0A=
+        wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
+        if enable_pcie:=0A=
+            self.enable_ast2700_pcie2()=0A=
+        wait_for_console_pattern(self, 'Linux version ')=0A=
+=0A=
+    def verify_openbmc_boot_and_login(self, name, enable_pcie=3DTrue):=0A=
+        self.verify_openbmc_boot_start(enable_pcie)=0A=
+=0A=
+        wait_for_console_pattern(self, f'{name} login:')=0A=
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
+        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
+=0A=
+    ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
+=0A=
+    ASSET_SDK_V1100_AST2700_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-dcscm-obmc.tar.gz',=0A=
+            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb0=
2d0')=0A=
+=0A=
+    def do_ast2700_i2c_test(self, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'echo lm75 0x4d > '=0A=
+            f'/sys/class/i2c-dev/i2c-{bus_str}/device/new_device ',=0A=
+            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0=
x4d')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput',=0A=
+            '0')=0A=
+        self.vm.cmd('qom-set', path=3Df'/machine/peripheral/tmp-test-{bus_=
str}',=0A=
+                    property=3D'temperature', value=3D18000)=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput',=0A=
+            '18000')=0A=
+=0A=
+    def do_ast2700_pcie_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lspci -s 0002:00:00.0',=0A=
+            '0002:00:00.0 PCI bridge: '=0A=
+            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lspci -s 0002:01:00.0',=0A=
+            '0002:01:00.0 Ethernet controller: '=0A=
+            'Intel Corporation 82574L Gigabit Network Connection')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'ip addr show dev eth2',=0A=
+            'inet 10.0.2.15/24')=0A=
+=0A=
+    def start_ast2700_test(self, name, bus_id):=0A=
+        num_cpu =3D 4=0A=
+        load_images_list =3D [=0A=
+            {=0A=
+                'addr': '0x400000000',=0A=
+                'file': self.scratch_file(name, 'u-boot.bin')=0A=
+            },=0A=
+            {=0A=
+                'addr': '0x430000000',=0A=
+                'file': self.scratch_file(name, 'bl31.bin')=0A=
+            },=0A=
+            {=0A=
+                'addr': '0x430080000',=0A=
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')=0A=
+            }=0A=
+        ]=0A=
+=0A=
+        for load_image in load_images_list:=0A=
+            addr =3D load_image['addr']=0A=
+            file =3D load_image['file']=0A=
+            self.vm.add_args('-device',=0A=
+                             f'loader,force-raw=3Don,addr=3D{addr},file=3D=
{file}')=0A=
+=0A=
+        for i in range(num_cpu):=0A=
+            self.vm.add_args('-device',=0A=
+                             f'loader,addr=3D0x430000000,cpu-num=3D{i}')=
=0A=
+=0A=
+        self.vm.add_args('-smp', str(num_cpu))=0A=
+        self.do_test_aarch64_aspeed_sdk_start(=0A=
+            self.scratch_file(name, 'image-bmc'), bus_id)=0A=
+=0A=
+    def start_ast2700_test_vbootrom(self, name, bus_id):=0A=
+        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')=0A=
+        self.do_test_aarch64_aspeed_sdk_start(=0A=
+                self.scratch_file(name, 'image-bmc'), bus_id)=0A=
+=0A=
+    def test_aarch64_ast2700_evb_sdk_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
+        self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
+        self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.start_ast2700_test('ast2700-default', 1)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.do_ast2700_i2c_test(1)=0A=
+        self.do_ast2700_pcie_test()=0A=
+=0A=
+    def test_aarch64_ast2700_evb_sdk_vbootrom_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
+        self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
+        self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.start_ast2700_test_vbootrom('ast2700-default', 1)=0A=
+        self.verify_vbootrom_firmware_flow()=0A=
+        self.verify_openbmc_boot_start()=0A=
+=0A=
+    def test_aarch64_ast2700_evb_ioexp_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700_DCSCM)=0A=
+        self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')=0A=
+        self.vm.add_args('-device',=0A=
+                         'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
+        self.start_ast2700_test('ast2700-dcscm', 8)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-dcscm', False)=0A=
+        self.do_ast2700_i2c_test(8)=0A=
+        self.do_ast2700_i2c_test(16)=0A=
+=0A=
+if __name__ =3D=3D '__main__':=0A=
+    QemuSystemTest.main()=0A=
-- =0A=
2.43.0=0A=

