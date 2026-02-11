Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8154CEB594C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzmH-0005Q4-01; Tue, 10 Feb 2026 21:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlc-00055N-6H; Tue, 10 Feb 2026 21:15:48 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzla-0001hz-OZ; Tue, 10 Feb 2026 21:15:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqPB8YCCO4rgJ5SET8AYJSjy8IqAlBLmTyjj/aiMWE1ZFh/ewPE9r+NHa79dt/1Boo/p3KPHhiGDvRcJzfiN+6AWtu0ca/iucRKJXMuemxrDuLS5KBNWOX3+ELo9V4t8RXLJm9SiJxBuE4SZsYwCewcawu/wbjIR3KHgc4b9dTir+bDwmzWOHWPnYo/hqktCJbG8QSJ0x4g7e8Wf1XNHvQLb4CIe4hrPvf6wwwImvob/Bnsk7abwrMcMpSA7ce7quyc8KiFsGm0uWCl+IKOsCLeCMZi7UrRM+ezMFGJJlxbVVh3gIkk8hhaONwjKHC8NuskPLF7VU7A6C3OAd5JZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxwNcFg5roLtm0jK/bxy5RwiqjmoQnZZ2hj5SjLFFwo=;
 b=WFvt/szKJGnxDL27E0Vys30s0PbrTzON/2AwchieX6NP/hv27McKNaVihIYLi6tOdq7XKmyMl2e0X7Wk8tjx0f8IPRkZA8j10V/A0LEdoPxV2i2MdiZpu6WyOIuP0PdStwC9WHHpQoVIh9rnF5PM35FrN9/opzbUMZi4AaylxqbeJLJ/KcTTv6AWQBaw59boWers8tmlI3eQDCxBzscR7eUpEbsD1AkwdcMvpO0YOdcry/5acCKVrzVS1LRgMQwdqsuTpUil5sdpXa9X9tr0/P48BhmhI3ZnAvANxoOuaI3aNp1roaCXjRjWKOs490HdysfH8HFXxIkrJyt6OowFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxwNcFg5roLtm0jK/bxy5RwiqjmoQnZZ2hj5SjLFFwo=;
 b=Pzu/Xa2w8u2fQDVMy2yy5nVwTG0Wuxvwn2zv4fux2Ar4kxO0dPBmdnpsqFqIVNbp2DHHqjE6BK6SEc9kJMa9w+6CDD1clIvkBZwjZoHfYkcG/E7GLfodURaIn0I9p2+yCs0vnuVCcclVj+Huyu+SipfpsHpcCqqJfIavlkMjJRFlYNy9oROzZQZ2is72LlqvpGYJnHz+6QPRmpgvRT2yca4H/d1n/Zr2AUBBDTxiADHz5Au1MjFJs59BCpqcCtJ9ihHKmmssJh2bszHza3+fEc+xAQaLE4ICemarQMrs9h2Muehxe7D43KxdoUeDQGIg66WhHp6z83eftRvNQ6qM4Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB6541.apcprd06.prod.outlook.com (2603:1096:400:47d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 02:15:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:36 +0000
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
Subject: [PATCH v3 07/11] tests/functional/aarch64/test_aspeed_ast2700: Rename
 AST2700 A1 test to reduce test runtime
Thread-Topic: [PATCH v3 07/11] tests/functional/aarch64/test_aspeed_ast2700:
 Rename AST2700 A1 test to reduce test runtime
Thread-Index: AQHcmvxO5SQppWgXeUqH08YXBwEcLg==
Date: Wed, 11 Feb 2026 02:15:35 +0000
Message-ID: <20260211021527.119674-8-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB6541:EE_
x-ms-office365-filtering-correlation-id: 2f13ec66-910d-4164-1474-08de69137151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WsVKOCJSxswRZghqdTeNyd2wUJ5OzGeN+IuNiV+Si4SheiyzdcHrJRr342?=
 =?iso-8859-1?Q?ZJbXllNt1cutL1WIFxQUWseeJhTaZ3CweL1S43cFpKmN5XrPAUoIlxh56U?=
 =?iso-8859-1?Q?p9iQE6RO9OSr5CgxlSxVv0+yVCyYw3/RRb5unJUr7n1YmtjSe5+ascC+v5?=
 =?iso-8859-1?Q?rRNuUKcewn/HOqD+q0wS3gi7pRy13jtwKg97LFkzrFMM0OvyuzPvsc7uFZ?=
 =?iso-8859-1?Q?34LcYIk4mk9lgwOCjti/Ba8tKk7jQLj9iRCE2jfivGdTIaxLGdg9EC6cxK?=
 =?iso-8859-1?Q?DbBgXshkNtyod0ez518wT7sRvU8bUkqg+qAGNYMqylka+3B+YGcbb9V+e4?=
 =?iso-8859-1?Q?W9RVyQ+qqgf6rmar6IylU/+RTxpiCS56fXijfUzW71ZWkXE3v1Yh8MFmRw?=
 =?iso-8859-1?Q?N2WzijPjmySN5iLEAiO7aPujsWMYcLvMP+waLAFVQCW5cZpDcKVMHdoqIe?=
 =?iso-8859-1?Q?lGNMQ9/qWoL9ube+iA+HmcXImFtba/Gshl3/bIvKvV6Ptp79VQW5MkLVUi?=
 =?iso-8859-1?Q?FL675VZp0ObkCnAB0hpm8uIgdLnBacDFdrrVQAxueBw9hosQ87nLUmLf7l?=
 =?iso-8859-1?Q?51204V0HimP+w3Ip1PbW5/q+wHj70O0jIu2qoPDu2aWzzcsqkmjNX8qRsu?=
 =?iso-8859-1?Q?MjtGdSBSOEbHy9r5ESZP2WLhRliSSnCkQqzJgzTOf5AZayQtqy7y57nyJv?=
 =?iso-8859-1?Q?2p5GGxLCH47HMPTGEIlzdog9gakPqKkcovyJe2oS0x1e+LnK7zgmjguxab?=
 =?iso-8859-1?Q?Le1AykQ5Y2D3En0pB/Z5CStdoB1s8AUped45NsXLxrHOe2NxZvuuMoYJNJ?=
 =?iso-8859-1?Q?iHZ/WTxX4dMzLKRuecTrficM9DpdwTiIMydg0v79yTvXKoAOJKlwqTmQKH?=
 =?iso-8859-1?Q?skS/TGhYmQG9iYoN+QrGOFrz5e8Z1mM+WqzMIMOxbZfyZ5kWFEGoYRl/RX?=
 =?iso-8859-1?Q?qgaegTeF1sEr9R5HE5rpUX6zc7BK3Vh//0Qorb1Qvi8Od+DiezIp8wBbzw?=
 =?iso-8859-1?Q?Juw30AmZP9tVbxKyRfiWPv/yDE5rstJWvXPTzA1lMCTPXxKVygqmVB5Imm?=
 =?iso-8859-1?Q?tYZjSJzSn1/tUg/V0Ppo/ZtFQhWkgh/SeK+ewQoOfDu8O4eLdyoQKOd0Tn?=
 =?iso-8859-1?Q?IPxg7QODTL1yH0PB4dXaCFklkYNr4b8GH7SzC+7oWEVwC7tJT+ayFECLxM?=
 =?iso-8859-1?Q?AL+P74Q7nMACBco16X6aCo3q7aUmvAUwQ1t1hZgQbLg1Ow2cfe8DOvbWpV?=
 =?iso-8859-1?Q?mZXE6aNnkinFDm+4tkJDhtoejzzKZdUFFAv4ve/oJiFxH9LPMKkY/kI/9F?=
 =?iso-8859-1?Q?DcXtFZ9LOtiYJXn5DCPsMMS8UdBdzfEIrriv7Ck2GQ5tKHZQviCIQpM5ee?=
 =?iso-8859-1?Q?wJhNF5tODcBI02D28Vz0HhBzQW2+NeeR024Bulss5p+lHm1ARsiUdjcTgz?=
 =?iso-8859-1?Q?pl7f+MQARCplTSmAs4vEi92FqWlPA47czMJKd13wVDvsxkvna5o/hXo7po?=
 =?iso-8859-1?Q?CIZsojqdGsMi5hm2E+zuMJ5Yg7eqquUXIulcniZ313fwPTVS9/vpleXUDN?=
 =?iso-8859-1?Q?AHK+1Q2Z8cBDO2VK5lsCi8mvIyb7Rf/S9IqTTotmw9+Dlpo1CpWXbs9taD?=
 =?iso-8859-1?Q?1Ro3cOxFHJ/PrJzdQhwVc7pgkEQB+JnW3Y/RP4SJNzMxrzj4ZuaAn7G2TK?=
 =?iso-8859-1?Q?Kx31XcJx416Vtuxg80l8Cj71+TPMavApGYfHUKyy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rVyOLnnYglKzVLcOMb060GDW+Ym9GSYhO+IW9AGgUZ47jnSbllSexvstZz?=
 =?iso-8859-1?Q?eCzSFh7BNH1HlxFUUzrNAninulUXRK1bcXTjXy/b3cT3BrnOXD6w/JD2tA?=
 =?iso-8859-1?Q?7guxf1CzEigyuY29/GeQFjnD4eKxCv9FA4yo/W3vb8z5hPuLUCPROjZnFG?=
 =?iso-8859-1?Q?ApOXe0D6W2NmrTZHCt97gGLFMZwojDcV++6sbEKDh764jlxRawotExo9wS?=
 =?iso-8859-1?Q?0h1ApW3P/fTTzynxXjZlpHvaQoBYgHlV6JXGNxrDn4v0HimCpWvWxqtiQE?=
 =?iso-8859-1?Q?1nQr5R910SNWmIMkjLThqIAO4AHqvnhpE4Ccw5sqK5mpLIGxzwlweWHKqN?=
 =?iso-8859-1?Q?ZfN9SxpC/QM1TpIHYvYHiheOZ8iRlgYwttTb9NaG6q9kwmsN97hxTnfDBm?=
 =?iso-8859-1?Q?FbJjD6Jr4thq1P9EKaEUWeLqGs1YbFhRdIE0YsCjOaYbIiTUWajetrQWHL?=
 =?iso-8859-1?Q?JYH18MSzvaKu2RKAj3ZxtPk2sN/1yS6VFjGEt61wPkg23dMgIEu9Fdcd7V?=
 =?iso-8859-1?Q?BRqSAEs0RN/5kPy9Ib6e0fmdiEPsbpQcOlbaCYo94SM/Y8V8DTw5CbckD7?=
 =?iso-8859-1?Q?U0z6jXZ/RkCJjGLWb2eXvG+LekSITug2ZrduyBgSRGFTlqR8ibaXXufEoA?=
 =?iso-8859-1?Q?1IEUU8wQJAfNLWbAmUAJJzuvaMSu/NluXOdAZvxWTwXp40fqPSzQMO4PoL?=
 =?iso-8859-1?Q?aUbWlQX8RdFxymU0MhWUCcxgTMTniBTr//RAh9NSEzDzMFVv7lcT6NQz4D?=
 =?iso-8859-1?Q?EEUrW+iIZzvTctLoMO8VYBSPvpY8r15DIAxbyuUU1YDWGpH/zil1XuGDxb?=
 =?iso-8859-1?Q?ThrT8QFDz7iYBvAFBJpINE4O9RDthhfd3YdI6ULGIumVRMcpURsEvKzPYq?=
 =?iso-8859-1?Q?KP4ITm7mDRDwrSoYQ0zz1XfM733VBiAMLuLkLFQCT0M587vDoBgX3eMF/z?=
 =?iso-8859-1?Q?t9AtGAwP+eW8mpi9yBa6F9qPDjD8TwseGokrjDBYTYOdeW6BYanD4LvRnb?=
 =?iso-8859-1?Q?qIeGsxELMJMxxIiWzzH6nD1fl0iDIMYCEySIxtaIjCKb3gOclqLMH6pNJp?=
 =?iso-8859-1?Q?s/iEPcrmO1Hxfeq+W+TaheH2ZvSDqbD0QmmfQFQ1V/VVNKaaLvZ7Dh3i/9?=
 =?iso-8859-1?Q?uYuIo42g+RP2fKCw+G+pXPTH6JstzAkciXkD4/JQKgBsnUCZSAaYGlwM3M?=
 =?iso-8859-1?Q?JD1MzG10BUula4ygNhsJFYztpPIHL1OxaFlciO9AoWn/uKvMap/EcdrGgl?=
 =?iso-8859-1?Q?ePHOUI7JivizXN+G1By5VTLub5k1XZkGNts6CZn/ZSqVcFUD9PUinVe+eF?=
 =?iso-8859-1?Q?45S2islLGslQuKNEDvhzYtuC3kVFwCJ0OwIuqW0kLLOOOMd3TvWlWlbQ1h?=
 =?iso-8859-1?Q?04p5/p/8KMCQDxi2zga7O2O3zM4CUlsDN38tTQjVOR7iq6IuD5Na2UANsa?=
 =?iso-8859-1?Q?1BvkVEZnfc4I2TY/JydjUsA8GhIe5ZU6xAJ/GEz5H9fgVZ2OPc56pMZlea?=
 =?iso-8859-1?Q?9bTCjrvOELPhze+r0Bj3GVnufbkCZeIa6ORDOllaZg8ySEguoj/HfUdem0?=
 =?iso-8859-1?Q?xPqdlecVt6PY+xmpvgyljNTgw+ONGCKP4D/C4TpAG8n3ttNexqcf+TH6zv?=
 =?iso-8859-1?Q?rw/gmgpV0Y9uIQLljmVac6lzTH5y2K3/rLJ0A7IzQKxcqENtrQvEX6j/zt?=
 =?iso-8859-1?Q?iNH2XUjXgzc7FFE30CFv5TnpHzqt+VchAGcq9c3hPpe4PKcke6SHJJgHPp?=
 =?iso-8859-1?Q?Kwu70SWvHHvW9q5hPEah6ZVJrLQ9tJ4ssyZVeOrn6Kj0KyZBstJRnDsca6?=
 =?iso-8859-1?Q?mAatuPyhBg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f13ec66-910d-4164-1474-08de69137151
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:35.9068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCBu36nhZQ4ehiM901UPqB4GrGzFi9DITv+coCZjyDidwysj2j8icwQxvkkQUlpiSKhajrMoei1zK3Aw6V06pntuuqzx5yFxJ0GFHL6Z4YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6541
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

Adding additional test cases to test_aspeed_ast2700.py makes the test=0A=
suite significantly larger and increases the overall test runtime.=0A=
=0A=
To keep testing efficient and better scoped, rename the existing test=0A=
to test_aspeed_ast2700a1.py and dedicate it to AST2700 A1 specific tests.=
=0A=
=0A=
A new test_aspeed_ast2700.py will be introduced later to always cover=0A=
the latest revision of the AST2700 SoC.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 tests/functional/aarch64/meson.build                          | 4 ++--=0A=
 .../{test_aspeed_ast2700.py =3D> test_aspeed_ast2700a1.py}      | 0=0A=
 2 files changed, 2 insertions(+), 2 deletions(-)=0A=
 rename tests/functional/aarch64/{test_aspeed_ast2700.py =3D> test_aspeed_a=
st2700a1.py} (100%)=0A=
=0A=
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch6=
4/meson.build=0A=
index 5ad52f93e1..b5dd674bac 100644=0A=
--- a/tests/functional/aarch64/meson.build=0A=
+++ b/tests/functional/aarch64/meson.build=0A=
@@ -1,7 +1,7 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-or-later=0A=
 =0A=
 test_aarch64_timeouts =3D {=0A=
-  'aspeed_ast2700' : 600,=0A=
+  'aspeed_ast2700a1' : 600,=0A=
   'aspeed_ast2700fc' : 600,=0A=
   'device_passthrough' : 720,=0A=
   'imx8mp_evk' : 240,=0A=
@@ -23,7 +23,7 @@ tests_aarch64_system_quick =3D [=0A=
 ]=0A=
 =0A=
 tests_aarch64_system_thorough =3D [=0A=
-  'aspeed_ast2700',=0A=
+  'aspeed_ast2700a1',=0A=
   'aspeed_ast2700fc',=0A=
   'device_passthrough',=0A=
   'hotplug_pci',=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700a1.py=0A=
similarity index 100%=0A=
rename from tests/functional/aarch64/test_aspeed_ast2700.py=0A=
rename to tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
-- =0A=
2.43.0=0A=

