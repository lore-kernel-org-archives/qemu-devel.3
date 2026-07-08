Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20884C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSX-0004DT-Cg; Wed, 08 Jul 2026 05:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSV-0004C5-0M; Wed, 08 Jul 2026 05:20:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOST-0000NV-48; Wed, 08 Jul 2026 05:20:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9wpG0ENywnO7UNJTWnLJgU0BTa/pWH115CnPJDtNczleSP9k7NmSRJ7OHW7bkCAqAE5Do/emvziwBOLcnnRk+1dW9X3XThtlElZE0VwYN4J9mLU0GNYl4LlXkbSFL8e+tOKlXfBVyUsscgbY3hrqASMh94psmkdSqSIxNIW4ef6ZQAVadgyXaDlKMMxYhUz4egrIjdT1geidpjnH9Z+ity7C0HWU1RNb6u9C4bAfoEIbJgFLxLfZSZTuQzjP2upa7GglO7NMxo6wzPYj847Ca7JdleBge95FNDDE4uHdlL035us7aO78qt8ASA2U9t1R4ZiZmTyyofPEifhMsOh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkAnbbMEjVAiogcxem6hXl3mCVqBxk+gvEv/Liv0R5Q=;
 b=I+5Mwa9YMDiYpuU0LI+7k3HC6576QZXm07ehx1pTloAYtoJLBfuRmWhbLaYzjOCQ5IezaPYyUjPcmS0opYzGHXhoN4JCsrVe0cEdKO2NZdFgxoUPonj/H4CVFzyOeF4/9X5WgJkUSHiiqIFbHPO27fCM9OSMMHJ2lmbnva8bOgJ+5s9b0xvMvhB12mY9xJM7SGSGIHBNishLet0sbvPLPBcbYrtU77iBTm6XngWJrHCR6fkfRosbgPwA+vpaWvYZ4eVSpYgYGV5st8AEon6LfwGtEoAjWOPSVsbQ6TGUV5PjN0yeBgC2EMBkwcXOybvnunlGfVhC91azBzV8Do0DrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkAnbbMEjVAiogcxem6hXl3mCVqBxk+gvEv/Liv0R5Q=;
 b=fWHgohmo9s9JOQ/DRu4Y9fXyIm63y9elaItWBUbIML4RUvwYqU+YsSTmVKLLkybNQ/prG11hzZQDgOAfwj/7moSszQy5mThiee01t0yheeOkn3+SZPI/TnkF3yrR4fufqHbEzCaxhZwv8Zsw2qinX4XW9jcmj0zQgLoTGQsoP52e0jmN2If7V1oCUOLMR9yE+GMcjumsNjjuF/j5P8wTWgq8g+qO3PG5GWawnbQlyfg8dJX2jdYxhilJlFglJB/ag3u5eEUwGy5gkY5plCn4GgTn122tnz7nmPWanpLqv2DmpdmXFU6I3CevbKfI7ZtMdeye/8IckAwMqlDxsNSPlA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 07/10] hw/misc/aspeed_scu: Add SCU support for SSP SDRAM
 remap
Thread-Topic: [PATCH v5 07/10] hw/misc/aspeed_scu: Add SCU support for SSP
 SDRAM remap
Thread-Index: AQHdDrsH52DB9Tkm2k2BnL1Xg2Qurg==
Date: Wed, 8 Jul 2026 09:20:34 +0000
Message-ID: <20260708092023.3826159-8-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: 0cf4910f-bebd-4d77-431e-08dedcd22aa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|38070700021|6133799003|56012099006|921020;
x-microsoft-antispam-message-info: KRCvW+lz0xFR6NfGb8l+yAbDbI6AFCYm5UDh9ojyqgLfUawx3ir+BuOuMcvh2IQuo9X/O9anqlIxFrwB3mFjv7mfJ0YihQnhCOHEb5zyzuKnatIDyGFlZIPXE5krEtu79QRMwFa+XJInTZ0IgMjxaLKtJ43ZPr6UmljHiPP+PW9ktc6mFN5IrP1H2ypPBCQnBHcUl4GFSBc7lRVvzsWzEzsu3F6Ud3O7pmBJvtMln6zvI/7kmFgmcAqvbvsw12azvqsqYwEUTbpiuf9yDX3G37xzc88yrA2RWidhFvgyAtGHmNvj+Q5plRozG42D0K90S9Txn9qKXDo2pLbDowvtFNncaTjQAP7/jN+QD+amBx+rlE1tzBDJ96Rp3FhUkTaXIiyW1Rwhm3uacNDh6tMdCUhmH9J4hhb1o30I0IkT6Pjcb5itfv4xGhrzinlJw+KbPmjZpy8rRueEf9dEl1TmxLSmPHXcLhwPskHTzZBo92smo7S76xpBSDNOwNUhNd3ixhzOAlH08YGh6d2NbdlArBdIkQa3qduHa7tlvwJBLpfTANTw8BpVWxzMdG0APzt5NFvd4qROSSKD++G2i9xnG3ZX14QBvgN9nk81E3cJL2vT6bk8udM3liiES7lJKF8bI0r7PLwsCN2xmefdgNIQpmgiD4iwCa4aguFt+EPe29ZNNblhJf1uRQIVrmnCObbTpnlaAxsyoqhzrBU8conyx/0/T7ykbNhF26IUIWdG3UyZ0/1PaEYtD+hPanfWn/xb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G3br0nmAivK5vv6XSJtN7RLv/W+xKipar+til5R0HfcJPgN/MkJe31YdeF?=
 =?iso-8859-1?Q?0G+I/NoIW7ADUaLMy2YGwBrHiZh15+yS3AeBxWwGWOGw1L41Lm90iC/oha?=
 =?iso-8859-1?Q?jTHC7b4kF2Fn6pTCnCDtINxo/oHNePOc/qH9hm5sSxCEPKCeBPoppctIlc?=
 =?iso-8859-1?Q?7F4i4lF0E1xjuFzJogGYTRYHSOJGF7kSmOuNajxOzUhZWX9jTsVrrJVWie?=
 =?iso-8859-1?Q?L075COuwW30IHuJxqS1tKoHjQIoU6gGJW1XEeB4w27mR1vU5nDSEfUor6e?=
 =?iso-8859-1?Q?wIiNjHJR7ERVQ7D7DYgrQOIWTNHzg2IYeJopsNhwz1kcUx+YY9WOhFz3/m?=
 =?iso-8859-1?Q?71qYOIjZoWh4rabVMFcdZuQdtcXIFdLlqQRPINBgRUk1Y+g3eiMBv8rV8L?=
 =?iso-8859-1?Q?B60KLfyWNEKOabZfP5qUz3C0sOR71e87Qg9Ya+QmuTBtXKRoj5OaTblB1C?=
 =?iso-8859-1?Q?zb6ZRiDCRcgjT1nvR09WcFVXn5/bW/XkW2wUcm7zaexiPJMCKp1mPBgVfl?=
 =?iso-8859-1?Q?JxQIbB3Qd4+amvEPpfN9raYojkFae5NEjWjLnFBUrQvawNhYMgGNkdr7qj?=
 =?iso-8859-1?Q?yu0lMKF8QPTf0/I62aIW/PurKNYG548rE51oi6mv/fKjiYHEY+G/Zab2oW?=
 =?iso-8859-1?Q?8l17QMHkWUDtg8LttUPFmNhKl/VFk6S4M+/ecB5FmOCK/dkRW6HAM70WfK?=
 =?iso-8859-1?Q?SVfrI3wES/hEHzwJ3ImjgzOUsh9R6g9ijwIP8eNFojXw98cRFnkft0UtJP?=
 =?iso-8859-1?Q?sY+qT9KR87aHAySN0c9NY9fu+Q7txoMXpsBjOMYmZi87w93rONuYyoys1X?=
 =?iso-8859-1?Q?EwndQBV8xIvl9q2qaHHVMs8kZCMXlFo0g6YL1ZUIt6TwQOPqZ/jTiVrNle?=
 =?iso-8859-1?Q?7TJkjliE4nxG1mDa4w5QhZ7E3QvQEUkTWWN8gG/9kNbHkj1Lr5zLJb0VTE?=
 =?iso-8859-1?Q?KMuXTh32cD5Cyn8wzmohH4S97IWQj0ftxuDaUZXRM1hG1N0QjyQuVbdr5f?=
 =?iso-8859-1?Q?IQUTemU0d2ZENHoLyrvRyKvnKY0VKKvqNOOiOjm8ToZxRLhOPhYjZiGcBm?=
 =?iso-8859-1?Q?u0mIm5fxXcszwsGUTrl/UhCblsrDbvXRH+bOtGRhccYkbm76ckzb81L6z1?=
 =?iso-8859-1?Q?mafSyAov85Il9vD0caxHwbFkh4WVqu7bzLFKs3/6Rf/aDaV1XrPK3neZjy?=
 =?iso-8859-1?Q?TKrIahaYTUFOpyLCdTeBgLzqJr4BPNlXhMKbKWB5NtYjKOnbobceM+jzoj?=
 =?iso-8859-1?Q?4nqI36oLZdzBBzg8bTRyN1gNnxAcONmUA4vFOvmgeBoCkmNooRqP0A9iIr?=
 =?iso-8859-1?Q?DieNLB0tChJeQwg0LbBQuq3/ypHXV0c86ogjcxS7mDmWToVevvWOGNfJG6?=
 =?iso-8859-1?Q?PccRBJ6kC6Xb8dpNC2ceketbVF9HwZOaHaB0LNbbKoqCYhPQWD+fI5Qsj0?=
 =?iso-8859-1?Q?daFC50xZgFfSIzsNzOHHWrvXVByHc5u+xLIj3pTxEgtj08t6CWs870T2Nj?=
 =?iso-8859-1?Q?7Kc9DjbhnQcW+psrYmNBjDvBUqx97Pp3Hp4yv5pupT6a6C3nw5WwYj4xGL?=
 =?iso-8859-1?Q?BKl1fzCY1Rtoav/YUcuDNREzFV6PhCkf6l0eNFElY6kKm6RWcDNmaozWj7?=
 =?iso-8859-1?Q?YUS7ac/5EsDosuiaJTiRUwQmabqSY9o0RZ/yvy0lDO4zpUNTF/t35DjYpW?=
 =?iso-8859-1?Q?tMP6fZR6NjfMi8FH1XBoOkoUTSnVbSYqeNcERA4ai0Cq8qTJNhF1czxl7w?=
 =?iso-8859-1?Q?YpJYKrK63ZxOyD0fElkBp5PrQf7XJBT7nvv+3lpJS+Nopat+ozrdOCu7Ji?=
 =?iso-8859-1?Q?lcpUYojMww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P2xh2pZGFS5iehKnBnfVhE3Fpw1IcBl7RgpOgeP7bL0/hF3kiH3zvx6l7Xq7jrKEyDLLC50gvE25eanV8vz0KsY0Sv47LUUL8p+4vObYnUFB/tDN5TGI+RA6LgU0NH/1Y0d1B2YhD8UfYaQvQr7F1blaRw5ZA449PManC/7jVnI6hkzNFHlfKko9qRzq6npEX6B8AaWH9tuxxpZXGSdJFjWd+BHtuwb9Y6GAc+YVXZgWHwaCKbUH6Q1oTKZt0/XjFrsJA9Zp4ZcYxVrj3Pdb5jE1CPZ2TnyVCivLyy+XrUEGky1gOkCM/sh1/8B2X3+DEydX5nB+iTAoXNzT4iw4tg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf4910f-bebd-4d77-431e-08dedcd22aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:34.7267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUBwK0fUpAUFjPzwyP7o1oaK/Ct6Gn9zdtXkodXlMn/7tyH1GMKwDyJWAmCTROFcTLagI3Tg5Mp8NzI9jz6H8cnxGvlTUz+0XmHcuUIz+40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

This commit adds SCU register support for SSP SDRAM remap control and runti=
me=0A=
activation. It introduces logic for the PSP to dynamically configure the ma=
pping=0A=
of its own DRAM windows into SSP-visible SDRAM space, enabling shared memor=
y=0A=
communication via memory region aliases.=0A=
=0A=
- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x400000000 (size: 0x1A7=
7E000) to SSP SDRAM=0A=
    offset 0x5880000=0A=
- coprocessor_sdram_remap[1]: maps PSP DRAM offset 0x42C000000 (size: 0x058=
80000) to SSP SDRAM=0A=
    offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_SSP_CTRL_1/2 and=0A=
AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfigu=
ration=0A=
of alias offset, base, and size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        SSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000         =
       |=0A=
|   remap1 base                            |---| |   |  - SCU_150: target a=
ddr    |=0A=
|   size: 0x1A77E000 (SCU_14C)             |   | |   |    remap2           =
       |=0A=
|------------------------------------------|   | |   |---------------------=
-------|=0A=
|                                          |   | |   |                     =
       |=0A=
| 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x5880000           =
       |=0A=
|   remap2 base                            |   |     |  - SCU_148: target a=
ddr    |=0A=
|   size: 0x05880000 (SCU_154)             |   |---> |    remap1           =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 62 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 62 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 2a20253410..6eeb1b12e1 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -147,6 +147,14 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)=0A=
+#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_0    TO_REG(0x140)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_0    TO_REG(0x144)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14C)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)=0A=
 #define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
@@ -909,6 +917,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwad=
dr offset,=0A=
 {=0A=
     Aspeed2700SCUState *a =3D ASPEED_2700_SCU(opaque);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
+    MemoryRegion *mr =3D NULL;=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
@@ -966,6 +975,43 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
         data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
         s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
         return;=0A=
+    case AST2700_SCU_SSP_CTRL_1:=0A=
+    case AST2700_SCU_SSP_CTRL_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_1) ?=0A=
+            &a->dram_remap_alias[0] : &a->dram_remap_alias[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_1:=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_ADDR_1) ?=0A=
+            &a->dram_remap_alias[0] : &a->dram_remap_alias[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_address(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_1:=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_SIZE_1) ?=0A=
+            &a->dram_remap_alias[0] : &a->dram_remap_alias[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_size(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (a->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1036,6 +1082,14 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SSP_CTRL_1]        =3D 0x40000000,=0A=
+    [AST2700_SCU_SSP_CTRL_2]        =3D 0x42C00000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_0]  =3D 0x1FFFE000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_0]  =3D 0x00002000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_1]  =3D 0x05880000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_1]  =3D 0x1A77E000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
@@ -1068,6 +1122,14 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
 =0A=
     if (a->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_address(&a->dram_remap_alias[0], 0x5880000);=0A=
+        memory_region_set_alias_offset(&a->dram_remap_alias[0], 0);=0A=
+        memory_region_set_size(&a->dram_remap_alias[0], 0x1a77e000);=0A=
+        memory_region_set_address(&a->dram_remap_alias[1], 0);=0A=
+        memory_region_set_alias_offset(&a->dram_remap_alias[1], 0x2c000000=
);=0A=
+        memory_region_set_size(&a->dram_remap_alias[1], 0x5880000);=0A=
+        memory_region_transaction_commit();=0A=
     }=0A=
 =0A=
     if (a->tsp_cpuid > 0) {=0A=
-- =0A=
2.43.0=0A=

