Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6E5CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw2-0008HU-OJ; Fri, 29 May 2026 02:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvr-0008F8-5M; Fri, 29 May 2026 02:42:59 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvo-0002HG-22; Fri, 29 May 2026 02:42:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7AcRuY0CX8q2k8rjs0DIpoiq6dwg0Y/cZB9DppPVW9JY4RC9Nm0WAHGXVANYSdLH8SAoDeN75xx/X8NAMJTD1hyxmEEFdzwZ+DAvxQGHQmrjvPgOdXd3O8eNNEwU9K/AiHlnbwWKMTQRXkRT8wXH9GfSOSgfzjZkAa6Z0kyEfMUG78ZnQzRbJoNK3125OuBqGr0FM0Bz9mVIPzTDMBYHipUoazSsCWeoFhOMt10J1LwuhAB7b983Md4sKyjzUHrPYdXHA3SeoLK1Nwq1+JK1gRzNhYHopAcI884stD8kaTG9Ly+nRrroLApsbSyaL81woJbLLUAse8kv8qzBvpKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/b6Hi/QSGgRKzVGQGdVIWoR8fCpoGAo6A/CPazV6oA=;
 b=V+c0ytacksnlOutDqe7Ci5b2TnfJ/vPotPCWc3f/fWcGSVLaAHm7hkKhT/5ExwvAPXBegUzMsvS1BsfpQ9n4nfvqwzG0+ctn5ZJ6PRHgyJ5z3PXjqTch8wvwfCVOHNT+86FqT8/Uj2rnABzOQ/z2GLgIknQtR8Uneg4omQTYz7Vfhz0nnnAcc1SA9y8hv0Weg1R5RudLG1YT4MHXiB/cLnBYo2iw464dNv951RHaN+16ftvdvXBGYiXK62i5J2X/YpjCn0N9w2Q+QdOxATf537Fg1DmvbkBhP2fYNPBLgbaYg9f77/BZxsS0bVDr9UjNdicrQDVYK+leXsZKPQU7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/b6Hi/QSGgRKzVGQGdVIWoR8fCpoGAo6A/CPazV6oA=;
 b=aD75rJ4WbwKUuobaic4EaKYN3+KyJaciZc+5T81IGul2sNBK2KQ6H4wdgWbAqKQGqdkMUmQzly3tqG/KcajdfzEQEPSBa4aVzU1jqtPQqaUai1UWsk8J96Q9OKFr1lKNFUmq0ZriwQkxh+oP5zfgb59hlxxdfRDZ4y6mjppHO7BEJ8UTCSvacpugiLwrIimLQMj0Tnb8Kzp6CFq577hky8Oy1+4pa+ExuFWo7uOouo+F4oBU2JxeY8Sz/L11DVCqPSo2kSPrB+EKcplQeg6rhb7U3KVbjGW08mnyF2k0yAOwSD+rJd4aC/NHuz5a6GhSrjodilRXvxUypQmABmkaiw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6063.apcprd06.prod.outlook.com (2603:1096:101:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:42:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/10] hw/arm: Add AST1040 peripheral support
Thread-Topic: [PATCH v1 00/10] hw/arm: Add AST1040 peripheral support
Thread-Index: AQHc7zZaDBfQidz3r060QgCVNSnfgw==
Date: Fri, 29 May 2026 06:42:44 +0000
Message-ID: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6063:EE_
x-ms-office365-filtering-correlation-id: 4f679c0a-9635-435b-e63e-08debd4d7d1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099006; 
x-microsoft-antispam-message-info: L7yIlhJWQrtmiQPFqCP482P3mTlibGT6iHgg9vc4MLvAoFpNtgN6i+BoeRkiL5ZH2t0q13WXuN97NzjQ53dy1H0U+OWFLgW0TPybC+z+gO1M06dVHr4uXH2iB5Bb6dqppVfT2lSGlXR+y+vE3Ox7tYBSUOzncl0If/QlAIaeVgTTxBma9LdHslF+mjuuSvpr2xabk3XnOzSDrfWj8Fi9fRosmwosGCrObfsy68BNditi3JPQ31XfiPNb0d/m3DJWZF2V2ZBrwJK45XOsMYIy6fZION9s7zzzuSPOS6G5R2ds3fbwCUPVmEMOH4dQQj1IaXEJPi85Eyv2hscmv+pxeWMiNX2D1PyZtXM2Kw7vMFSY8Gnn7cq0FAM7vaLL80p6pQ/sCE7FUz9XitpxMnsPmKE+b1O+hhvihNFTAuWpbjM3XPreP6OA9qtNYddyOT95IBFYxCxshjFr6vCymDTS5mR8PdxmcLB5RXEDkY0O/7+zk412wQHyE7VOuwyqeQKYKMVELcrBrS3Gt1bOLUIU0TbHbGuVG4qdfKwRu/GbZTBd1whMbpEWWoGJoWhZqF+PaT6mJ6/eFoi05w4ooQEepctXD68EYLLhNBQnDKjPEirj6Cp8Sf4ncOqdalfn2swHYR6wmTPRpj5fbeHf4GQoqaKUxrLDEIt37uB4gUO183Vzz5zQeL1Ql29OAn4MG7C/6mQhV2RdIa+MwzODuJr1G0jzj05mFn4j8GJhnvXJ/LmqQvERtNM4LHnuikpAjV+D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+Lq/FSagdX52LKcO59URvP4ec8KDqurZaJL1yU6PLFyYswdIM55sUT2A6h?=
 =?iso-8859-1?Q?Vabdgw6iCJtrEptVgdDH1WBaKiS7QbVqHn2+t/b4rZxBt83V+4BZrlvIu9?=
 =?iso-8859-1?Q?ePsD3qBTf8dzTo2zAbGBBhaH28M5iGeEFhEWygU6ByBoCgmfCwSPC2pGab?=
 =?iso-8859-1?Q?WsDYkYznOqSvbqu5hgUG7Dne7dsvC1Hjpcm6yaua9sV4yA38FD+9HWMOGZ?=
 =?iso-8859-1?Q?fI78zahEX0Ed/oTzc4xDUjBZcOYuXPKT7fk3lzn6RxSo7nWcIn1vq+3QWP?=
 =?iso-8859-1?Q?RG6yJJj13nseXLgTyTuBQ6w9o+H8YLcTE5zomyczm1M+xnqb92JS9jCPM9?=
 =?iso-8859-1?Q?W2uodbAwsqS9lnDchX8FKhnJm7ku9i8DBOGWj5W3MtAx4OAJslQDWnGFDP?=
 =?iso-8859-1?Q?v6anc6/hoqU5UzaaxmVUNpFSr0iuFx4l1UAzjruMFFT4MJRx8PGrZ0wPwv?=
 =?iso-8859-1?Q?y/y+h0tiGPQeoNjYVWAzvT/Q9jIB4fzgEJrUZwKRVcRMb3bh8Amfkt4At/?=
 =?iso-8859-1?Q?pqlPDalxMy7jy2fueLjuOAshmQ4wisbl5upEyNxpQNo9Q9vN4kovjiwgjY?=
 =?iso-8859-1?Q?nUx4fNhL4pkR28OCdyDMsOkH3IJwlO746qka8ZTnwAH3jaP3CV/gKhQIQG?=
 =?iso-8859-1?Q?nSSoR8AJeIO5Dt7F3sOPEN5Rfz8OZbW5tSPfc0Y9FbdkfyFQamafs/HWO5?=
 =?iso-8859-1?Q?IRQbjQIXTVZTbMJlSe9WdMp9F17EgAWxs4lQrSZuIdh6m6JyzInvXxmVDJ?=
 =?iso-8859-1?Q?cXFlUlob0L9oazqk3kUGVZ4PqgKjRW1XNnzug6P3jC35TLkouTWttEfeoy?=
 =?iso-8859-1?Q?sRxg5DkiXkPGEg8AOmu6k1mI4W7+ToGdI31VKFmjOya12sWxWjOYQjvanG?=
 =?iso-8859-1?Q?Rzy11RDry+vrnFNTr+QMlA4Gd9JsY1KjKvMkRpwupQdbgVirqnuW/OuC+x?=
 =?iso-8859-1?Q?IyrCM90n9GZvxhZxi/rlTMIVlITYuvg1iA9srMCqgifByfqUPVZXjfuHBs?=
 =?iso-8859-1?Q?TIzNpeWCHDK3mL7Pgw+Xt0On/2vgVInmvZW3f/Q1Dw0hHGprnKBIf0vZZb?=
 =?iso-8859-1?Q?q2bNHGOfEMiDtYwhAtvIEgmk9RB0Mgna/lntry+OBqX3AWWrIUTmOUduEL?=
 =?iso-8859-1?Q?VIB+TnscyOpR4jhqLP6fFroYSF774b9i1oIh5vfr9SabK+0+kjcQ79cN8n?=
 =?iso-8859-1?Q?NUJydVHg7W+axrY2kj++BQOnFlyibaPomm5vO1AoVpIV43syXGuS1i03w8?=
 =?iso-8859-1?Q?d0b34zXMUocfHRVKrazbA7Fe2syIxILcWsTGbjDD8KfCSieAJeFUAGUXj5?=
 =?iso-8859-1?Q?hCZlS/XNR50KjK2QPXvj++vG3mm35j1gPH++D/jrkbq8u/2jbuUm/zROY7?=
 =?iso-8859-1?Q?LPz4mAgGsfgZNn+5k9dGyuKPpVzJB7cBhR5wu4bOYIi/TwFrZoSFlrTex5?=
 =?iso-8859-1?Q?NWi3WPVWiUpl9X3h8j3qSKc4zvSfb4Api4b/oVcjvfrdBpIzTJdq/PzDth?=
 =?iso-8859-1?Q?j4O9oKAonFTBI0WTOUHRXfNiMWGGfMa6SJm5Kz3ISC/pZbbcOUqfUhwCVt?=
 =?iso-8859-1?Q?gtdSnvkQkvT2Iq3+aumWvKNz9NknpOYuYdbfyykRxsYayjHYeThmjW4VtS?=
 =?iso-8859-1?Q?Ow62ajp0VvQ8VOG6tb4Lz5vzYhFgEPADeS9s07deOv0tRzqHhxtlaucDWm?=
 =?iso-8859-1?Q?eJ0a1W3Q6IZ0eFCLFwCauSvS6RIif00nCy3ciT2BI7Ytv5kjIX40S5ceZc?=
 =?iso-8859-1?Q?zESjIxptk1+JbRZn6+hBcuuCyCiWfQKafGMvFI/65ajewNcOj/sd38Q1MF?=
 =?iso-8859-1?Q?VQfVw6nu8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JMaWQxmhq+/Y+SDA/sW13LUovJu7uowmeOGdF3NQ0H0JQvN09ZkThOJiCqdkdYKELg6ASSRENrmAgPGobZqF9tFvb1kuFOxlWSkXIYhmAoHxEGsdi4it64b8+gIVrFaZWEU1XGGIoZh9OYXbVDYA9LdqAPK4iYrZmt1LcFGfEMaxL8xZ4V6YqYK0I7bQK9sMPoBaErOY+ynD4WIDaWlqZYFGu/6YEzTRwY/6MqKOU9tJ/I4ZvnXFGs2aLqMxgvXOct6hzWCPd92p2stOxxd0nXRBwzIpQY43AXsHwJ2v2IeAMAfhsHFwQDlF4oSJX3JsYA2FY8Myv9PdTwfpNbhM1Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f679c0a-9635-435b-e63e-08debd4d7d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:44.1633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88TRH9s3h6pXrwAJJ4e7lI2ni9prBQqJxLr337SPdwBQbrvdpX398MN/ekzXU/pbEvNhFNkNA7kgqvqphkHilbVNCO5Gb1663K3irJMpQ5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6063
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
v1:=0A=
  1. Support ADC, GPIO, SGPIO, I2C and PECI=0A=
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
 hw/arm/aspeed_ast1040.c     | 105 +++++++++++++++++++++++++++++++-----=0A=
 hw/arm/aspeed_ast1040_evb.c |  18 +++++++=0A=
 hw/i2c/aspeed_i2c.c         |  89 ++++++++++++++++++++----------=0A=
 4 files changed, 175 insertions(+), 45 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

