Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E53ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOe-0001iO-1F; Thu, 05 Feb 2026 22:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO5-0000Uu-WA; Thu, 05 Feb 2026 22:20:13 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO4-00006q-FA; Thu, 05 Feb 2026 22:20:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjlloVFofUNcR8HLkku0dYuJqxkEdYWnEVPUJRjr/s+Gu4igIUJHxNYOgrdZzGTdXRD1wrTiuQeDQLp8rGMTNJgR7W5DNYCeAhPYkj5BkrtJ7gIRgd2ZZnT+ofoDmKcg+h/P1buD0q42A7gbLlkXy8wEaccIlMSfSL3NBJ3SNfZAlNmiJMeVLzMVt/C3CAKB8y+MfbnEj7KTwZ50FY4zwpnUVLy6mPe2vR2+ov4v6ih9AYZfKejqHsAB+2xfmknrYKea6wrYglTKcKZ4nUhqnUHp08P1lfsKrPy0m5Czu6zF89T4N76SU+xovPEBSMexSJaJlT6jnoN3AsQO1Vl1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L++TLYVsonwta4t3vrtzbphLQUrYihRExSXwWphaPXs=;
 b=s5TK4lZRcCAIhHcvQdSrxYAeIz5BdTXH4UrjsDjtrSKPb4tR5hl9NidNqplTAoBkygocH23scXulBy4ujaIZrLOl3P8uDJZMe6aPAi/n8p3jMcrfPwpbn2JlCXdOXevW5dYAYXUTCpKPL5MVqkQzc53M8vpvMWxEl378SPMhBDA8i/tiSmZ0s4YDJ//TFbqZKJ8/fe3ljYqFHu3QhpwJF7DJ/2McaovRdZxIJzxl7bojz6MGkptZVGSWaXBGX8GbEH5Me48YWf4hMU/A+wsfc2qxxR3NjcDF9moDhIySfsiJ2GpmxQgx10cDvRAsQ57UUNGRHtmktyeH0AaVfgM9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L++TLYVsonwta4t3vrtzbphLQUrYihRExSXwWphaPXs=;
 b=eXWmyKr7FN7FpSPkrE+cD1a8TKJRETKOrkm/MNWZyojKKpSMiQZfUp3RkslCGJM1cg0+ol9RnK+kI4mJ5GnYa5/1PIZXvwDKPc6NlDqhI3QOu2LhuhGuPmwm6KwfzmGgNVKEFbAoMauKTMULTkRm6CjYSzhsQOQfmJFJP4UZBuPpgqJ9qe7bqVvpQdR5bJuxAGHd+b9W7s+7NGinx+Yvj9jfcYuaB7VRFjWIZlYkG8QGDYBYTPDrGN/NRzskfC+vBiKceOuwDDQ8Rcjs1NokILD3vpSA5LVzv52B85z9238ef0YU4WoJc2aYe/x3gFTAKnh1vKs8go+47lkcfhIvcQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 03:19:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v3 16/20] hw/i3c/aspeed: Add I3C bus get function
Thread-Topic: [PATCH v3 16/20] hw/i3c/aspeed: Add I3C bus get function
Thread-Index: AQHclxd0I8j82tpUwESMBLBwsheTBQ==
Date: Fri, 6 Feb 2026 03:19:50 +0000
Message-ID: <20260206031926.3227848-17-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF4DD1DCAD3:EE_
x-ms-office365-filtering-correlation-id: 5e078c0e-c369-4749-34c5-08de652e985c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2IjsJtdJZtsOtRjXvyPEVc4AxX6LO0gGuB7eT+s2mqzRYBL6ChSHOYkjZ6?=
 =?iso-8859-1?Q?Rt/wSrocgYZcXqk4p6sGgbJeIz/MIzIZGCT7Uh0QDr275tdOHnOJX0kjfh?=
 =?iso-8859-1?Q?6S67/YAAepi10KKz7kPkUmE0B5qo26cSXrqM51esnIyGrmD00cxDROSylZ?=
 =?iso-8859-1?Q?EFmVQ7GxSEbh32+7XXQH3/0C8+z8yxZ+EhUd3IPhMYfdjdtoo3sDMUcdYh?=
 =?iso-8859-1?Q?QprnSs0+RmmQzZkEg5IaCorUYuPm4WzOoNuWYTZWSZvkvOygY3XPlWyQB5?=
 =?iso-8859-1?Q?JdQ/OpdSV05wVjRsfFwIaWYjFF95NgmbqTqVAqmvCeUXVwO8cVaK9XWS+E?=
 =?iso-8859-1?Q?P13SzQzvUkhtqK4YlmrqM+fHVjq3UWLnwxFjeuh+nlw3+kKubbIFvp+DUG?=
 =?iso-8859-1?Q?wPZ7pemoyo8PJ//ifUst8/ANYdICsV01ZeLOxlJtfqMhl1Ya55jxwUYyZW?=
 =?iso-8859-1?Q?KCONIUekR7G86raxeSizzQVmNm8v0bwe5RbPpKbD9WSP6PTQy5z7uc/SQf?=
 =?iso-8859-1?Q?kfe+bJ+R1eV0/xGnO3wG3pJnePcGeEjFY52eU6zKBpC4VIhdCW1XBVzdNU?=
 =?iso-8859-1?Q?XCEeImemi5ruSwo03DGQBwjnlLui7pwsplPjXrvj78rITfIOYQV6FxumbZ?=
 =?iso-8859-1?Q?k5aPSP4eQUe+QE20MurnK0LHDi4whRk+pls2N0QZjkcQof2zwDDsMbHo9E?=
 =?iso-8859-1?Q?Zp+GbhzzOItN1IMo9OUkqXPOPY6Rwl0OdBJfKtaGureuti5CugAB+ML0kB?=
 =?iso-8859-1?Q?4si74vJtr8lQJKTD27ChKAZlsMHMKsr9M1SjNhjfNc+oSKhC3dclBE2S+s?=
 =?iso-8859-1?Q?NpQeB8YE+WcDg+jdr12l7dIEDGVanLJ78B0C0l/bo2mY9vhBM3m6qMNVz+?=
 =?iso-8859-1?Q?3Q2Jaob8yq95PfrzWdzPf01GsKZKQ1/zIv5GJJNzdhnDkTnTTsQZ3mn4KS?=
 =?iso-8859-1?Q?bfYFngvFMyvcMpLUypw28n+tPxBDdGpsGMfL/EmHlKfanKq+W6VmnYlOMO?=
 =?iso-8859-1?Q?agLEDyN1pJjuPVPxlGn+A80YKhn+CuPRwyhtkUw8Lnl7ODeB6V5xpTC344?=
 =?iso-8859-1?Q?SNI0Dj0zI7q1aK4eqFLznYJ4eibwpj7pibaLrhe2PCqVu5bqYqe7mWntSW?=
 =?iso-8859-1?Q?IVxpav6tKYl8zyhcI+sgmcm99DdnfzH9ArLilgg7x0N+1PjTG2hEFeMryy?=
 =?iso-8859-1?Q?oCkfZIZEjKh3OTcThaFhvrQLLuzPU4Xmx5ro6jQFdlbYUF2gYXZq+wM9Vq?=
 =?iso-8859-1?Q?CLTKJ07YtdwxvoKZ2zfy1g5cC8Cg3V6/rFW2NAk1ccPlWl7fTOd9xTGaGp?=
 =?iso-8859-1?Q?HLwKmzEHdBiKFyqbtG9B5B4qEVUGPNkG9gvOEvnPkl2L4q5HgyphPf6xhk?=
 =?iso-8859-1?Q?fUSD5dw+VewS5VbKJFulnJAluPArZhX0v1yypUOxwscc0WrT+Ug9ECsU8G?=
 =?iso-8859-1?Q?RohYdWWr+DnN4RoUlVNqRwGhrUmlXm4hhIfoMtO5Eal4fkKTv5q2vTIqmt?=
 =?iso-8859-1?Q?gIf66URWvYJjsfpt0mJbOp5w0Ab2N5jWU0ayNH1PPPjnrEIZoXn5qwKnUe?=
 =?iso-8859-1?Q?uJz44SbkDdgWC2wlFanNdIKMETzEeIlzYLiB03rn3j3YsrMOuoRLPSbal1?=
 =?iso-8859-1?Q?MoPkrK0SJz61qm5ce1Txlzw+tlJH2rdkF5gvxklW3rydaxi09WUVVCUXWN?=
 =?iso-8859-1?Q?BvlL7EMp8ieVRcUyOaqpl9VJ+uZsxPeP+ManA7YP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JP6ia8InsgCXuZcq9dofqKV91gb+fjXCZE8aPESrcyqQptkJ0XKX0ZlgIB?=
 =?iso-8859-1?Q?90qjwc7vKi5uVhbAYxVhzdWqXTqS+OQH4Upwiqas18jPZcqqDeMhaFSMXo?=
 =?iso-8859-1?Q?hDGW+oQbWv3LjEwoYlN0ZFw765fb9He8qiG/h1pRmjr5H7y56tpZetRZkG?=
 =?iso-8859-1?Q?atGgzdoDK26U0Ni86Eh3hIna+X0qAEFEL6EBr5qBTEVx9LCKTLRxmSwCTq?=
 =?iso-8859-1?Q?9VWQlfOJIGFhDxS0FeplvizduqGEnQm9CgJEYxvjlJal3VJaBgJsbtVPUU?=
 =?iso-8859-1?Q?qWbdis0XdIlww++pEko6VcEUEySVSyczZBq6apwmN1MvP8Tq7/bzWPmkzU?=
 =?iso-8859-1?Q?mWQYQDHZI8vtT/kYzVNSALl2Ii24GgRRPRz4HUyWQJFSrAPMZ6UDn9Hb/s?=
 =?iso-8859-1?Q?ZFa/NxJSTBCEbqxheLhnuR6StmMeTx10aDwaIrAarxKVeVdBbx1psq3/a8?=
 =?iso-8859-1?Q?Pf9KS28ogabAPaHEz4M3SSgvLk6KokWfuJs956BFrF8yGiQ0AjCowXmsEJ?=
 =?iso-8859-1?Q?7jQh8ww4PQrBhk0xpMiGK7NZ8ntQK8YMaYT8KlHCo5CV5OTkOwsa+KIpj4?=
 =?iso-8859-1?Q?WB0j/r6iqreqxPUyIPAW5IUdGdjwZbLzOO8igU3rVhy8cAshkkmnHOhFZK?=
 =?iso-8859-1?Q?P5bbjUwgWrEO9/44MeuChCimm/xZAlLjePihZsVRh/tFEu+Oq9dggQRAra?=
 =?iso-8859-1?Q?6Cd9CuxIWZ6FGu7JIwEVaL/eTdBOB9xRMJTKQkrd88T9XyxLgaK59uGnGQ?=
 =?iso-8859-1?Q?z25IKfafDhFFv/KObNOOEpaezjhOBHXReKwK6WNmiX7diANC+j5W23QuFW?=
 =?iso-8859-1?Q?/ZG5umxqT8z1rOY5EB6WIKBS009buQD9M3FPLxxUS4Wj5d4RGmyXyWJ2bH?=
 =?iso-8859-1?Q?U6qHQJLFZdvwIF7aIj8NEedN9FwjSt33Zq/h0rTx0wqAoAvna3oUYmBuH6?=
 =?iso-8859-1?Q?GzpsM/VXxbPvJmdpNAE42lYM+GCYMGyVQEssbci1y9Gi0j7jzW/5+VbI8W?=
 =?iso-8859-1?Q?zgJiAwHet8tCQOTbRxP+BinrW5T/Dwi1oWn0ndN4EYZYQF/8otGpP2wd/p?=
 =?iso-8859-1?Q?yNCU+mv5t0dIHDdnDuCSS8DnXo/uSOaj208yHDrbTtmGxBTkWJrlJ5Zizs?=
 =?iso-8859-1?Q?DoWheIwLobLm1zFxP0vtKNV0FP7wm5kGaIBuUjLmDsvFcSj94aS1O7BGAp?=
 =?iso-8859-1?Q?LKn6/aFCSgZBbYwRauaTsH6NIXJxTp58XatOjjCm/ID8X0yHIvsZt5E2Tb?=
 =?iso-8859-1?Q?CZQA7YSGZc0GbHe5TVoIrrFZm+x8mSrDpiufj6ukElvzw+63/ZOr3Zy33H?=
 =?iso-8859-1?Q?QCJfhjiDiWaH84K7aYsibkzOvlGux6ntC7QkyJNa9r/5G1I7kFIcNOf8f1?=
 =?iso-8859-1?Q?WJvMQRHuaEnAdXkIueO9ZpHVFYcFy5aHoxVfUsSI/P9mjyWaJ0qrSpzAme?=
 =?iso-8859-1?Q?HF/wxMv1ps9KdPVlCIO6gFGjfGulaWnZYDJfbVQopym8n+Onj03bGMdbZq?=
 =?iso-8859-1?Q?cGx5jekcw2RO0R9PkRFHz2wB8ZZsT3RLJduos7Q8xaMZ/wqC/Gh/tLOrrz?=
 =?iso-8859-1?Q?AbyqsCacA4hBeBxB1mwJgZW3MRdBVIyyY/16/77M/pEGVZnp5FVZSm1o/5?=
 =?iso-8859-1?Q?0OiYu0JLN51/mp4yTR9knf0wKK9aFJifXrn6ZbsXJjUV8LEMXTBesmXt7v?=
 =?iso-8859-1?Q?nY62Tfuh1TPcEnq+6eVVrhFz0yb/OH3k5PXOwvsFx6hHxz8Jtg+yY/OaWb?=
 =?iso-8859-1?Q?onR8l3ZobTXqbsNJuULfM03P8u2A5leSw2J3grUgb/odY+bD4rcE5RJ8VZ?=
 =?iso-8859-1?Q?k0dMV5q5XA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e078c0e-c369-4749-34c5-08de652e985c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:50.6256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jy+QLjxXzF4gyU+Hv/0hvUN004zFII9rtsDJlgv0++kXcSChSOZ+GGBq3Ys7GhoMRTuH9WPulcSU6joIOWrd5rez6ghBWLEIkXTVMCvJecg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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

To retrieve the I3C bus object normally, the order is Aspeed I3C -> DW=0A=
I3C[n] -> bus object, so make a nice wrapper for people to use.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 2 ++=0A=
 hw/i3c/aspeed_i3c.c         | 9 +++++++++=0A=
 2 files changed, 11 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index 436fb532b9..e4e8fda93b 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -34,3 +34,5 @@ typedef struct AspeedI3CState {=0A=
     uint8_t id;=0A=
 } AspeedI3CState;=0A=
 #endif /* ASPEED_I3C_H */=0A=
+=0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num);=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index bb41493c55..867909ebe2 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -153,6 +153,15 @@ static const MemoryRegionOps aspeed_i3c_ops =3D {=0A=
     }=0A=
 };=0A=
 =0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num)=0A=
+{=0A=
+    if (bus_num < ARRAY_SIZE(s->devices)) {=0A=
+        return s->devices[bus_num].bus;=0A=
+    }=0A=
+    /* Developer error, fail fast. */=0A=
+    g_assert_not_reached();=0A=
+}=0A=
+=0A=
 static void aspeed_i3c_reset(DeviceState *dev)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(dev);=0A=
-- =0A=
2.43.0=0A=

