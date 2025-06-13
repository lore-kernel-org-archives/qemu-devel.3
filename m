Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7821FC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 02:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPuZg-0002tG-Er; Thu, 12 Jun 2025 22:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uPuZU-0002do-F2; Thu, 12 Jun 2025 22:55:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uPuZR-0007W3-5K; Thu, 12 Jun 2025 22:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4Qp6GpE5bMHyYtmJulHb6NfdCc+OHU5ltdh4edG5Bq4T8/NiZwC1kfYf5LQhjXYDK2e2CbD8gWml8iCobN445ucc61g9N0FRMIBGodk9Br3jfc9auKHr5pjGmGXHfpHLr4RQ3Zn4shYcpg18k7FA7ru3p97gWveSnUrBN+sntzDs0bLYC6YksNsHu7AFlgD9coZmFudV85JqSw87IZrzqy24479MOqTknTnh9PBwrNbQceTAJ/VdtPNyY46WQdywEFdySmT/5WV774rVk40chboFaPzReBg2DzH20LE6GY12C7PdFC+/+zK+C0F9k//m2Xd3MChA3XioorV7xTbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgbMODNQ2BDFhwcJYlbaO/WcmddV9gQYEliQaaxFw+Y=;
 b=c96BHH27X21XbBsF1m89eBJWbaBTDV9Cfkh+9zNLTKBJ/tEUQwVtB6AqMKl20mE5aTmEu2duOpFK0AbpCfKg9eLGgz1InRP/v6KDOwOv4sNjK5RIdlKOAdM+H0DAcMpd0ioSNoOqURbm5FFkl1g31GAdOag5F4BDPcUwScaq3Jby0nUslwQBUM2uLP3FkC/sCmSRzZGV/7MpjdBG9f3cHlU15B/hbBQc8Ib71GTyVFQ4IIdnsr/mvJKEdSMgB6+MXDI/LMM91HdAb75jRWQyOGNeqQONi9qg8suqJO5Es28XuIOMYxaZindmWBJwLsRTO5qUeutAksZnfhBo89Z/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgbMODNQ2BDFhwcJYlbaO/WcmddV9gQYEliQaaxFw+Y=;
 b=FJYw6RldY3sB5UU/gotsKHJKv0YnOVCvaV8VxFU6YNJvSYAAXJn7JbrjremUGnQ3ptOBJX51pmKhrZ1gBLsZjFfWN5VD8yVDUeYpbmimzhtvziYaV3qp2MPfcRj3Gm30umXQ/h/+2KMNAO/pcYx+3CJ5tlAu9rPxNU4lcTiXOhZE6JYocPyn2F2hLnD+jZnWhSx7e+Vgcgi+EKaL35ThJGJu1owusuPzBmLH3Z5Y5UpGjOZnr7PspGH55ZzLFzcVBLZ6lcvcdPvGYhcafUeMMpgjwbeRrgRWOmhXo6T1vcJ+WYg4CwxJ1ievRIukTYQMiC9kMetg8ZxmEqy74ecOog==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.22; Fri, 13 Jun 2025 02:54:57 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 02:54:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Tan Siewert <tan@siewert.io>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Topic: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Index: AQHb26gO6SN3HcnSYUqhj+VKKkWvBrQAZASg
Date: Fri, 13 Jun 2025 02:54:57 +0000
Message-ID: <SI2PR06MB5041DE20EB548C3137045975FC77A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250612144052.22478-1-tan@siewert.io>
In-Reply-To: <20250612144052.22478-1-tan@siewert.io>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6961:EE_
x-ms-office365-filtering-correlation-id: a33e25cd-0908-4656-1abb-08ddaa25ae5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?C0492gCYkxKgggJE/Qcc5XAdeugTsfbeBSlmXwkdzQfsPfI36LDN0LG/RY?=
 =?iso-8859-1?Q?zaVUWJKm6AEwgZFG4IYNz/RyEplbEn8D9Xo2Y7zGDiD49ffWVR0eQLTIiZ?=
 =?iso-8859-1?Q?OMxCRSlLr3Zr7cWRk2cJde5AI31mETeoIf9Sz945ZiyNcf5mfu+OQxZKo3?=
 =?iso-8859-1?Q?gyLH2wj+1PhAmQjH48s+b/XLS40xaVwVFAOj89QnrX/fC60bTfGe6BllRO?=
 =?iso-8859-1?Q?Cs9tdrbdsF4MwBOXVEpvTXvqgHL2bkPdYBbALgnFFLr+rOO5MX4q1tKgKy?=
 =?iso-8859-1?Q?h6n9MDYG8n2DRuDQceoia5oi5UB9aKQvgonBSxXB13wm+CK3oa1CLTIv5K?=
 =?iso-8859-1?Q?hFsy7fv6g+XPiyyZPXixCMvLs0ZOAsNUg8KZo670X5Rlmd7IHTsd4rFgFT?=
 =?iso-8859-1?Q?pdGuEHe1M6o/0uRAgcAGwWii33Thz/uhaZHqVFvJdBt8sWjukE8L/AjTO1?=
 =?iso-8859-1?Q?2N2CYSnAoqOaaiHbYlI/PrbMRWmQDmYeLxSQe/QfAwDvB9wfQnl6eYA6+J?=
 =?iso-8859-1?Q?LMeK3nU5WIyCMNqpN8YHQLar3f2Pscm815UOsZovnlB0j4+DLZo1FP7Pn2?=
 =?iso-8859-1?Q?ItJI/JrIUXSLOskqKtrULB8dXcsPyC6Hoh0rfWQ+c6Y8R/Nr2P2VCVjWTy?=
 =?iso-8859-1?Q?7gXf0tnv5VbW+KeDDe0ErCGVOhAXr25hbbvYWTwsLgAiExN0Se1UICbIuY?=
 =?iso-8859-1?Q?f2x7M3qaJqC5viKUGou+uE2tuFJeeyBxW4xtb8CkXcYyo1qe+ENvmD607n?=
 =?iso-8859-1?Q?dD2sW0fRvTQZiwz+lTaX3o3JLDghFljJFI90Uhrj9aYiuAWlhjyDckdxkW?=
 =?iso-8859-1?Q?JVxIxk5s+sfIbUhuq+/btZBhmwSycSY6VfA4P7MHd+gj5M/kK2zeyonVXH?=
 =?iso-8859-1?Q?TVidQ5xxgfyXsOW8nMvjq1EIfjabB8QT24ygjw7/8pSqKVwSTuH2tWNBCZ?=
 =?iso-8859-1?Q?encfrz6DyOglbm2x04yf9myNNHwUSLyvU0vHNTKS+kFEIZ7SSSaawTAVAY?=
 =?iso-8859-1?Q?QIZo9gp+fFidP1y/1bWbp50Xq5e4rsv0COmiZm3vMQSYgA3SlMXt/HvyV6?=
 =?iso-8859-1?Q?ovpYzjR3weWyWvGe+6vF3eqDzsOHXhdHVzrRQqQoGJvkAwtGvggBG7DxLB?=
 =?iso-8859-1?Q?ChXlA6DfTlDYyXtH7tRaI5oPdT8+4ya0UXG2QBxzw8RPEo8T4nhXStnryA?=
 =?iso-8859-1?Q?FAqzHhHbHBBPDBOUuZe/3v9Hedq0r3pkTqsIHltMe9yQOBdmxK3ZhA/Jvn?=
 =?iso-8859-1?Q?J8xVLP6HJjwuKkdoFooGko8vrnOg1DEgNAcNuMZML67SWTE23L4JFGHozQ?=
 =?iso-8859-1?Q?6nYyKgHXW+UoJYP9Ecl1m59cTs/4yoz28f+TUnHrS8a+i58XVOB1kR8I2q?=
 =?iso-8859-1?Q?3D63PD5uTIeg/eDEIqO5v3E+EWkWk7AAgrd50ZRJJpbOErtWT2ecOfxBWN?=
 =?iso-8859-1?Q?0v2ThdV3p2v+YYMK0ptxygZwOX5DiYuWxIA8Hu7BOwTyQ145RoL2mL2yKC?=
 =?iso-8859-1?Q?6iEsN8mOJmoBQoeU0YbLijQNVPpCdr185soBkesr65YDHU+fusSY2blULQ?=
 =?iso-8859-1?Q?BKd/Lok=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jLsGzF4YCnRXhs5a6rhm3AneN5N53PrqokvYh9SyzG54gm7inmkfknDsm9?=
 =?iso-8859-1?Q?ubOkRcXv44XvPw7yZVj6QG6z5GbXasDKCCYuhHqShfTh4oef56Fvb64205?=
 =?iso-8859-1?Q?95zxbujNeeAwuQ6NB8Saw5gFNNa8D65HA/FNgkKy2muxDY7qsBZQDgveqH?=
 =?iso-8859-1?Q?WdRJ+AtriwpTCdEXhp3lqkxFThfGq/fg4WZN/A2s5PN6ALqB0UNmyiwzwI?=
 =?iso-8859-1?Q?RwEVwjyLjLJwQEWqfHWAkE/b8bf3UMY1NWK4jXs6rAxGmzkHoNYCoMTCKF?=
 =?iso-8859-1?Q?d8NfwBpKuvpSOWM0xvLl/y7wNZctwvmn7kiiDtBxDhGnAyZknJqIgzsy9K?=
 =?iso-8859-1?Q?Sm6s8fedf9t3BsjwsFw+ZCxAuYIHLIgpljdNR8wwrp6cVSfFSZXu6cDQas?=
 =?iso-8859-1?Q?ws/IDIllvrBCkhlsdCwcKpynB9BtR8ol+xItZNk+XzTDEWgPiCcCIWm+Hq?=
 =?iso-8859-1?Q?xKzmipHOJVBer53Fd6BumNr0D4U8dwLrEtLQDVH6+cdWdQGmlnW8BZD+QZ?=
 =?iso-8859-1?Q?H+uSdTzJgtxaLVRZ7T0cqN08aYlciN4PvnmacFZeHKk4oNNLuQE9wBcWrh?=
 =?iso-8859-1?Q?3Y4HsNKAnbzF65RUlPYtX9YuEa2+JSL6sPizbBc40Dq9qDvpzApHt+pJBQ?=
 =?iso-8859-1?Q?YEtQYnJsbIdeUpcNjwr0yyBmdPmaDdhisM6wA4GOxB/gIPU6rekix8XEyb?=
 =?iso-8859-1?Q?p/UBWNUynfxS0Kuxm6sPMAKSlLx0wWjQqrEHXJXAnZQdyCV69ZQelTaZ23?=
 =?iso-8859-1?Q?d19J0z4JieSMnLAIUgLcgvXsNDfOh8gB6c+ZeCi3sW3Y/1ndOi1rpSFsv1?=
 =?iso-8859-1?Q?EpbujBsAn7ZJyY/JRmvH0D9TbX06x9BvMjNrJPWCw97BVv24ignMWU6oOc?=
 =?iso-8859-1?Q?9q3kTLV5tHPodzMYL0K7LgSDJ+AwO1Y2/IDPiYzJEVzvT/64DTJvDlrbrc?=
 =?iso-8859-1?Q?bv3/Y3+hITKSNEpLWuelchAMZpDMymv6BB2VFafPf9sjfDPPsSHjzqCEGU?=
 =?iso-8859-1?Q?V3WgX4Qp3aN9IjLFN4EJCzZAo16DOjIydTRCOyXXGOQZY161vaLXlTkxpy?=
 =?iso-8859-1?Q?MWetCOa1lzrfZPniCUCaLu5J69m3Kao/GQC9mY/j6HeYj1phNsv7D1+RY2?=
 =?iso-8859-1?Q?4QfZzde8t5XMY8cRYf2RFK+OD0xA50LO2aq/o55X7cHkvQPSQ2d3OQ5qDH?=
 =?iso-8859-1?Q?ypIEOknFddHi/0q3e7n5zopnXZkse9VmewbrHJnxGQq4MRPLTWDgzRQLZW?=
 =?iso-8859-1?Q?uP2FprztnUW+zbed+O411r99sTdYAXwSkLbI/MNvsyj3wL4FnVCp4p5h64?=
 =?iso-8859-1?Q?iEAQtp81yNHGeprC0OllrWv9ABteQaFTjaYLH+90s7BovFFqstFqeuLito?=
 =?iso-8859-1?Q?BUqqjM56bwoHgIVhqwFNLoZAnm+lfqf2mwKnvVO/sxc06TJLH3E0C7ggvU?=
 =?iso-8859-1?Q?cQbv7JsDTiReMmHwCxQAblS5dH5RazVv7sbv4NfmbI0/qu//VQAejzLj1d?=
 =?iso-8859-1?Q?YZM8P02XSmIlphmsfRD6orbi062XpiQlDq7itNwHgFXtw79EcOAiEfzlSG?=
 =?iso-8859-1?Q?8JR/wUQSBCZwe2pRNl6nsJcqeZVvA4sSz15yFQYdCfzZBCkvZcnsEhzfVY?=
 =?iso-8859-1?Q?IIKNe+m96JMjqa6b9XB5QeBlWUy9P2JnWM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33e25cd-0908-4656-1abb-08ddaa25ae5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:54:57.2156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPy7ZVZpK2dp/0D8/0/g4RBHRBE850Q4oxnxMJ5lUBqxgbHUtlt2F2f4A3cN85N454CY7MGk5W/0ELFDrkGcfXAILYtYDfkQ20qL57uHWIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6961
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Hi Tan,

> Subject: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
> registers correctly
>=20
> The AST2600 SCU has two protection key registers (0x00 and 0x10) that bot=
h
> need to be unlocked. Each must be unlocked individually, but locking one =
will
> lock both.
>=20
> This commit updates the SCU write logic to reject writes unless both prot=
ection
> key registers are unlocked, matching the behaviour of real hardware.
>=20
> Signed-off-by: Tan Siewert <tan@siewert.io>
> ---
> V2:
>   - Fix protection key register check to be an OR instead of AND
>   - Add missing return if SCU is locked (like for AST2500)
>=20
>  hw/misc/aspeed_scu.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c index
> 4930e00fed..4dcfe8f7b4 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -91,6 +91,7 @@
>  #define BMC_DEV_ID           TO_REG(0x1A4)
>=20
>  #define AST2600_PROT_KEY          TO_REG(0x00)
> +#define AST2600_PROT_KEY2         TO_REG(0x10)
>  #define AST2600_SILICON_REV       TO_REG(0x04)
>  #define AST2600_SILICON_REV2      TO_REG(0x14)
>  #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
> @@ -722,6 +723,7 @@ static void aspeed_ast2600_scu_write(void *opaque,
> hwaddr offset,
>      int reg =3D TO_REG(offset);
>      /* Truncate here so bitwise operations below behave as expected */
>      uint32_t data =3D data64;
> +    bool unlocked =3D s->regs[AST2600_PROT_KEY] &&
> + s->regs[AST2600_PROT_KEY2];
>=20
>      if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -730,15 +732,27 @@ static void aspeed_ast2600_scu_write(void *opaque,
> hwaddr offset,
>          return;
>      }
>=20
> -    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
> +    if ((reg !=3D AST2600_PROT_KEY || reg !=3D AST2600_PROT_KEY2) &&
> + !unlocked) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n",
> __func__);
> +        return;
>      }
>=20
>      trace_aspeed_scu_write(offset, size, data);
>=20
>      switch (reg) {
>      case AST2600_PROT_KEY:
> -        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> +    case AST2600_PROT_KEY2:
> +        /*
> +         * Writing a value other than the protection key will lock
> +         * both protection registers, but unlocking must be done
> +         * to each protection register individually.
> +         */
> +        if (data !=3D ASPEED_SCU_PROT_KEY) {
> +            s->regs[AST2600_PROT_KEY] =3D 0;
> +            s->regs[AST2600_PROT_KEY2] =3D 0;
> +        } else {
> +            s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
               It can set 1 directly.
               s->regs[reg] =3D 1;
> +        }
>          return;
According to the datasheet description: it seems your changes do not match =
the actual hardware behavior.
Protection Key
This register is designed to protect SCU registers from unpredictable updat=
es,
especially when ARM CPU is out of control.
The password of the protection key is 0x1688A8A8.
Unlock SCU registers: Write 0x1688A8A8 to this register
Lock SCU registers: Write others value to this register
Only firmware can lock the SCU registers, other softwares (ex. system
BIOS/driver) can not do this to prevent disturbing the operation of firmwar=
e.
When this register is unlocked, the read back value of this register is 0x0=
0000001.
When this register is locked, the read back value of this register is 0x000=
00000.
Writing to SCU000 can be seen on both SCU000 and SCU010.
Writing to SCU010 is only on SCU010 itself. SCU000 does not change.

I The following results were tested on the AST2600 EVB.
Could you please verify the QEMU behavior?

Writing to SCU000 can be seen on both SCU000 and SCU010.
Writing to SCU010 is only on SCU010 itself. SCU000 does not change.

1. locked status
ast# md 1e6e2000
1e6e2000: 00000000                               ....
ast# md 1e6e2010
1e6e2010: 00000000

unlocked protection key
mw 1e6e2000 1688A8A8

both key and key1 unlock
ast# md 1e6e2000
1e6e2000: 00000001                               ....
ast# md 1e6e2010
1e6e2010: 0000000

lock protection key
ast# mw 1e6e2000 abcd

both key and key1 unlock
ast# md 1e6e2000
1e6e2000: 00000000                               ....
ast# md 1e6e2010
1e6e2010: 00000000

unlocked protection key1
ast# mw 1e6e2010 1688A8A8
ast# md 1e6e2000

Only protection key 1 unlock
1e6e2000: 00000000                               ....
ast# md 1e6e2010
1e6e2010: 00000001

Thanks-Jamin

>      case AST2600_HW_STRAP1:
>      case AST2600_HW_STRAP2:
> --
> 2.49.0


