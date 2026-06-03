Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048D7CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcn3-0003Wv-0V; Wed, 03 Jun 2026 00:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcma-0003TN-Id; Wed, 03 Jun 2026 00:00:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmW-0002OB-Kh; Wed, 03 Jun 2026 00:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbrr9Ma5gxAZ5L6FRcF9hxFm8Ig+Wm6kk11BmEluPNUK1dQZ+tqvrv4OvJXPJujptF442SFYmrGGmPnYVI8V5GFH24kR4Lh4BPWL7WsPTzbb2N1zrbnTb0GIdRAT6DSF69wUkCTDKQrCWn/04UdVPA+Q6SJ24RoqO5xdWWkgIwRPqS4AIhptlqrvxcN91UD3M18fuu7KEozpY7eF/O/QvbSExYIkggyUc2Pj1NuFMi/5RUFaoFOUEBSM4id20GsGe9eLFW7wbBwJ/IK6bxXgqeJRoojMy/qXbgczNNVal+2j9U5UL5BOvtBpdyfyI9NYVgWEuADIVl1IbJILdioFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sD+5f3XnSqsP4Wk8AboOCeAD8VeDid6uTASjc96O+E=;
 b=TwmAZKG4lJfq9GLAcfsJ97JDGPnPIvDQhYFTcq+SKtG6VyUXjP8pS6lxkiSetuoEv8cvTEYlOGP6g9BvXCeBZ5zRsvD2iBRAteJFTuzdMwZYq2H9Jgit6pdIBE2QxRUA21MAj+hXLjCdlgfieRRCrVLtaiWr4snJNfCHrDuFffeirDw4QzQo03GI5HowFYyjSr2zbcmP5egKzp0iTUXbXG32Nu/DlzY11wYx6ZcSG27DHVp+LpyPNTFXGjn0sIOuUpw1w7xyi1W34GulzE/AcVeZej/hFUP3boqTLYrMkVGLgYQa5r5NU4lbakEaNZNkl8h25OjWPkztzRj3XQ6gTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sD+5f3XnSqsP4Wk8AboOCeAD8VeDid6uTASjc96O+E=;
 b=Mv02EbY3CNGDe+4m6y/Po1J+eTMKkFSXuVA9cIePTBYDXLDlQA6BslpNAI+kKCstfEGlHqkGIXlCGx788ERrjJ2ycSh1aNf5D7ad4/kJSa7FDLSWkQa1Nwbu1dI/DzHZoqbNOfK9IiVIKeOKG5taiEqnU2MisFpj/IlFRKHA++pYNCfu6gkvtx8QMGR4lcCZZ9XnXHnF+pGCZsBFBCJNkZSfQS3jrve0+eu9ZoDeNt6ui4NHA7ZY9c89oeRzqEvLksJ8jYF89pjBoKmkltBqJR6og/I8xZopYLlts58w0FGxkH7R4mEBk8odrzPjqLQlsXMAdSCGWpufyi3BM9tM2w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:28 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 00/10] hw/arm/aspeed: Add AST1040 peripheral support
Thread-Topic: [PATCH v3 00/10] hw/arm/aspeed: Add AST1040 peripheral support
Thread-Index: AQHc8w2Du1EihNizZkK8TCvEX8xRNg==
Date: Wed, 3 Jun 2026 04:00:28 +0000
Message-ID: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6921:EE_
x-ms-office365-filtering-correlation-id: e73a7045-62d3-4d46-83da-08dec124a644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099006; 
x-microsoft-antispam-message-info: b9NMxHdflncaQZ7RXEshFaCcLIPDeHzKZrSxzV+rv/CugfwhKWrr7n//g5hwD94yuldH288r7WYTq7cuOvCmJ5R23eTJmoDhKD2cjrxEJG54SVhkWMIbagTZgaX+tYSRhLjvfcL8ZTu/rYw6V5XiubUvJ/UqHpp4rbo4Xj8msj0PxjSjCYnCCs6+y4r49czvuvl42C9/WohuMZ33cb4v7QH5ecvvcC2nYEpmUWtNu8S84KnlNvXWB1dQzIzUU320XVaD+J7p10ntQ/Sm0bnz25z58N45gnrRIQNsBpDI37BVAk+XL+1PjrzuE2mZl8UgovZn6GMtEOz4K2yUgoxMn2KsIC1PtfBczE8cLSLQtGAecYROENlfQn060cLtA/Y293E74l5ULGqOuahwbkmttV1SyI+KsBxOPzROrmApvX8O/E9lZWdMubMRFWgr3tv1ruxUUco/a9nY+7BMNO3LnKHmFz8L/qqvEY1KLh4+ZOHL+mdYdwY75DZkpYyRKWm56HpjrNix9UxxMOFg6cPL3CXsfjgmsgYd2OzXeWv/5UMMry8dGz7jt4zaX5w+X9BotGtcQg1O5QDXEodDfSdHhbgLdfzyNWA1TYxHD8s84vxw3sXA5gH6/Ds3kglnRl76cOdIVbtX+oUwBHzXdwOV8f7/FEwaD+qLYnBoLqG5beuERFdsNd9MXmUVGhU+pRChWLTa3isggrd8D2GDPWSP88AMhb9tTF5e4VESQfzA62Srj5FUjMWNyhBHXX4OWW8X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/GL6v5yTUZ3cX9hZEGX6Wj6cEiKruiHQtnIAUUv/SakdiKCsZScOxS062q?=
 =?iso-8859-1?Q?7QJtSlmild8jbgARPKB9SeClqb079di7tk4MbAWvZYnCKDIQG4vrvyG5Hg?=
 =?iso-8859-1?Q?oOX4S/xtQJFWGCy9CWrU5975eNCulqa0uRWOJ6U+mSQzuqPj4LJz0VT+AX?=
 =?iso-8859-1?Q?0wCIxY3m4dOg83WYnLEWhn1oplbwRo7nG109GEuWqRz+I0YC2If2JK4PdO?=
 =?iso-8859-1?Q?PtYExPXBPWt9xsWmwx4hAsNvwGjRoooYheUqjHnhH48/eS0To+SNBfn8Gx?=
 =?iso-8859-1?Q?S9b3mELZVC98db8x+XSxaQxlj9PKiyHW24/m84OaO6X6B/fTaH0pIASXfs?=
 =?iso-8859-1?Q?uceuYEvBtlx7u53ZEUg5tZAaKLWsOIXfO2zKLRI67L6OAZVia2Up9LwDlC?=
 =?iso-8859-1?Q?XzjyO6hov4ICetTBxdCJWVEo358P74nJ0ZNO4h06aHp8agk3qulvu5bvPz?=
 =?iso-8859-1?Q?aqtJQ7byjtasaqC81H8FCjMcO7cPdjns2KAkN5Ox7QoxKZwCiHOY0cHAWC?=
 =?iso-8859-1?Q?gsaOW3yfp1QJMl/w+6pHo74xmUXk7CyFPkcL+ZsK03ZKM/jEkVkyVas91/?=
 =?iso-8859-1?Q?RH7xyQz+On2yBFVch4NxSA9DIuhGN8xnYQ16ZyG4MFR9dfZp8UhGkK4q+V?=
 =?iso-8859-1?Q?lkSPz5GM44DYyprZs9No3VX+xns/oYOXCR/66U0vwFI4Kd7UVM9eGG/OiH?=
 =?iso-8859-1?Q?VBZX9mqupaDfN1Dl/6wYvuahoYrD+BvfH4YSk+tHDUZJ9HJPu4w7ac6URA?=
 =?iso-8859-1?Q?60d2x8NA7DL8F4s01+MS8j7PYn3YaIk+pxFabdvrjCZ3zgDcHaZ7CsbcPE?=
 =?iso-8859-1?Q?iJWfTq3bS+057gyQW6AaG/MDdAjQ+kvB6XD8T/+KcLYxrK1aWFWNuzAhij?=
 =?iso-8859-1?Q?67uzuwnpWBW6txCmUo4CMeaEKeMcNiiQs7qky40Ps/aRZBP3TI4Oec17zy?=
 =?iso-8859-1?Q?ZvTnV14SPMCCfo8TE2xKuTg6VgBOSXWVzzJtM6QzEqw5QdTEe+1S8GuX0I?=
 =?iso-8859-1?Q?euciFxGZc+K/TKSUcqgvEXOkSbfnaC5IOcREWQvWisw+zE/z+CzGdSETOT?=
 =?iso-8859-1?Q?YT/esmd+zfLFZdniFwocPHmRJIgLOF0g7PzPTbyFVJyZu469tXUmniBJMN?=
 =?iso-8859-1?Q?m3HxK3U52cls8/AuEkQik5jmeDYSEvKBmGUdiOWBu7BUQaGq+VrexF1YLi?=
 =?iso-8859-1?Q?3X16ll4pKN06sNi7AXuCeGduNF1+XYSk+JYzll47ZIc7T2l95o3SkjbeXE?=
 =?iso-8859-1?Q?2nY/N9nt9xiPP+FiJsdsshmIC3RhQmA16AHPJiTpkO6C3I5xaF7dKEzROx?=
 =?iso-8859-1?Q?dsN6lX3uW44UbnImbFbpN5OMH6ppk0IYW4kU4p3307C8e8CJyMnjKwdE9k?=
 =?iso-8859-1?Q?30PhxEexbL3KX9GvuiOFi8fKbvz7V6g7jN9yta954jBPXDxZR9b9wZ/4aA?=
 =?iso-8859-1?Q?GmCAFcuIMrlCdTNWQ5gYp0thh4vQyqwdxDTio3G5qvG4jOS1jvEWKDs+qT?=
 =?iso-8859-1?Q?8ml595VWI0zlUwuLIHJylkG3NDaR9I7AdVSJe/BaRHWgssx8K9HyUGEOOj?=
 =?iso-8859-1?Q?7NlqDYWEFSjDzacR1VF7SNzxxybKsr8bMNN7PsJiAykyqpSKSZdizxDq/V?=
 =?iso-8859-1?Q?EG+1HtGmU+WeWs4ytwf0HsAAsp0albE+0VBVAnZgVMwA46K83T8+t1FhtD?=
 =?iso-8859-1?Q?/+1ub9KWol8z+tnYEdV7/FZ6f6ewSngu4PY/v89dO9xEqvsPkHJCj0GCzP?=
 =?iso-8859-1?Q?QPqrhwW1tiMTgCceuMWwVwgr+EBWnFUC3sCZt0ZyLEciVwHUKUDde0l7bG?=
 =?iso-8859-1?Q?Z9letXIjxw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: guocsqqDjwzzNu7NeatOxTqwTYUraDt/NBpBSfbZxE7H1rNaMJ70jj73Jy2vnioVlWLOLS0qK/7qABwjUIMmhoy4G0HuSYYutGEJguuA+4SwbjO5lNaCRgWELS9TAlJzn4oH6CZBj7C4VE0ksMmJ3AnrDz1up0PoYQGJrUuojbb6Gb/OXiqS0Wsy6n35bZxH/sju+Oxh2z37SSN1hoB1f69ByeuSEffWmAjamS1CgrpqlDdo/uUayFfJtxz9VVfIFWqkOqt9zt0boSH9neqGS9K29NfT/kCn0Lv6G6e3MZoO7BUR9htcijp7Za7RlOg6qFAVfMr5kQx1tzJNLqGxzQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73a7045-62d3-4d46-83da-08dec124a644
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:28.5148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSQaqENgENpEQB2ZjSezvn3cu2URe9MfTOVa4tyxHqLxInsZSY6mvo1eAmjBy/7rRltxnSkbqsjwrncpHaqBMZiVxBpmYGqSFBFADxXTka0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6921
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

This series extends the AST1040 SoC model by adding support for several=0A=
peripherals that are compatible with existing AST2700 controller models.=0A=
=0A=
The AST1040 shares a number of peripheral IP blocks with the AST2700,=0A=
allowing the existing QEMU models to be reused with minimal changes.=0A=
This series adds support for ADC, PECI, GPIO, SGPIO, I2C, and watchdog=0A=
controllers, and updates the AST1040 EVB machine to instantiate onboard=0A=
I2C devices for validation.=0A=
=0A=
For I2C support, a new AST1040 I2C type is introduced. The model=0A=
inherits the AST2700 I2C architecture, including DMA support and=0A=
64-bit DMA address registers, while constraining DMA accesses to the=0A=
16 MiB HyperRAM address space available on AST1040.=0A=
=0A=
Depends on:=0A=
  https://github.com/legoater/qemu.git (branch: aspeed-next)=0A=
=0A=
v1:=0A=
  1. Support ADC, GPIO, SGPIO, I2C and PECI=0A=
=0A=
v2:=0A=
  1. Address review feedback.=0A=
  2. Fix issues reported during review.=0A=
  3. Update i2c bus number to 14.=0A=
=0A=
Jamin Lin (10):=0A=
  hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to unify DMA address=0A=
    handling=0A=
  hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size and adjust offset=0A=
  hw/arm/aspeed_ast1040: Reuse AST2700 ADC model=0A=
  hw/arm/aspeed_ast1040: Introduce PECI support=0A=
  hw/arm/aspeed_ast1040: Reuse AST2700 GPIO controller model=0A=
  hw/arm/aspeed_ast1040: Add SGPIO controller support=0A=
  hw/i2c/aspeed_i2c: Introduce AST1040 I2C model=0A=
  hw/arm/aspeed_ast1040: Introduce I2C support=0A=
  hw/arm/aspeed_ast1040_evb: Introduce onboard I2C device=0A=
  hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models=0A=
=0A=
 include/hw/i2c/aspeed_i2c.h |   8 ++-=0A=
 hw/arm/aspeed_ast1040.c     |  97 ++++++++++++++++++++++++++++-----=0A=
 hw/arm/aspeed_ast1040_evb.c |  15 ++++++=0A=
 hw/i2c/aspeed_i2c.c         | 103 ++++++++++++++++++++++++------------=0A=
 4 files changed, 173 insertions(+), 50 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

