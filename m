Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz05-0003Dh-7P; Tue, 07 Jul 2026 02:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz03-000390-F1; Tue, 07 Jul 2026 02:09:43 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz01-00083P-W0; Tue, 07 Jul 2026 02:09:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsVRqhTkC4elKjmXfQfY7eN2pvGnV0ydznWsBh5XS8/YmTSuaY9Gy7JbBq5DD7mfJx5wxlyrAIOsCibohl6iSCzpTk/cBB4BcThzsLdfZe+kuhk/34Pj6a07ajmXm7foAUaKYT4iISosW2VZPDQTYf0RA+FjZP4JSw1WBcFZVaR6mcQx6eOpgZllo9Rz70F+a3dOHC+5WcnDtAfeUZ35/yJZ7qJSVT8SQWOooexH9OSK1QfS4Ga2iXVFQ5yeJu9N0Fvg76jQNJ/ASbkNFQQ9PkPf1x5Cz1+1dIWZlH6KFUorQmQ/2eoNgYFJBFPLL71TDsbfwQDhqRV574R8oJPI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngpXsUNKnu57ktrHgVcu8blVdNv30d/yd9pih9JUz9Y=;
 b=XFjGh2RTWKP2rhGC1GQ2IYfL/UNW+GWAmvNnRSFnp5RjcgooP6Yd+1fsFG9l03+X5M6JRPTvXKb2oViUPX4Y9+E8GEiqHduzhk45ZjnNeCzoUU3MrjgOmd49c8fn67bBByusrpmb6v+QZKDs/Sr0o5XWBNQjBxLeTpqpRvUOlPefOW+oUnq7NVzgMlJFRk19vc9KUG/vjIjLm9rmuKsuFt0/JDhj9Km55fOR4KMky4dbE3liUo6Eb6313xKwXtos0uS7CZk6DQ8Hp6u8EMkcVt2H6wdGwn+tQfVTGayrnu8rR9EsRAgJlrbRjoH/657TAVOiSnnjcK4qB9sSrErLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngpXsUNKnu57ktrHgVcu8blVdNv30d/yd9pih9JUz9Y=;
 b=oiqufoX3gbbJKhlJNBP8pB3ScTEa0Ww7VqT+zVhoI4a4qkQr9bck+0mQVvYEtqOFLVAfuwctUa0g5k49ZXx4OeIoE9/wg/6+6BENxBf1OUrxapo1wki6K6+6UxV8earXsRcsrJj3C2dkUpI/NRAHWrEHi4KaXYcRFIN1Orb13ZgVR0L2ivUIbxb/oi1qvSarI9VACONiXklkh5HEjSitjB9+d4gr1lWyV/NbbIyMWjiHHQi0XVej/NettYJsgrczH58yO6YoW7JjmPfTkFAf9xqLhpMyw9S9GOm4rue/80VWzsxNXGVpVmvKGBv7PurM6B5UZFe+fjQAbXvxAxstJw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:28 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 5/8] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to
 SSP/TSP initialization
Thread-Topic: [PATCH v2 5/8] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to
 SSP/TSP initialization
Thread-Index: AQHdDdcqufhJa3gxckGtq2Gm8MI3Gg==
Date: Tue, 7 Jul 2026 06:09:27 +0000
Message-ID: <20260707060919.350637-6-jamin_lin@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: 28984265-7c18-4f7f-f2c0-08dedbee4d5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: vGlvZ5qaIXenurTu8ra/xsFRD6SV2cXpsD+71sE2OpW/t42+CwYq4uy034vd39H4HqZnlqIXxPjieeotJ/3pZ/yYIEIiv08yqSRrXHBB1Nm5CWznc2SDZvyGUKd1+0sqOl/f4NdaONq1f0OZi4Z2enHBLKCfNE3hD9OVCAUWOlK/l11JTO5Lz9wRKuebJzwLqznEM/ELNzYWxzOnQBd8BQzg6lYDLp7V64tL3JMnNGlCeGf+CUr8ZNeZboEGVAPW1fafTbRo5cH7m6KSrCdflP62MHyQ7Kafvo5WA1i5DzmnDJBEsWd1FFrONA47Cjl2wTMzovBVoOX1v95iDuyHOeBIsZWcnT9PMIxaCuYys/t6IQyxuPS5UKXItBYPJ3NtQB75KZJjrmuEqPVaztU+Qdni+d+efffEBnwpr6pJe2w35j+pXNZF35ln58ff9lIWV99D2LfAKbHxHMJTPboDBB1yMToemCyJydH+vFb49lO2vz43UCeu4QX6lS/ntVlDIPoWF1ChZY14KNr0iGEfcLZxjnZjuBxsgkFhzPZdoF+91smu+Z+tsiNC12jVebeyjfPWHSGAEBRzFmDzxpDCZj8Rd/KUEtjmtI0kE56M+5oB6p9Emim2fNzwFgKSp8cuxv4BcXDmj32eeBUoEwSh5N0K57HPYGxyINQtoxrDw7H3AQkoWYzNfHolQ9ZASwyGetoQSK/DMuNj+oWoRPDtrja9AfALV7WlKFwyHCue10gcxkauhW4XY6YeZWsPSpeX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sCUoOa5S75V33eN8EPphulhrU7iClQ1RVInedXnDd1Yo+/VLYqVi9ycOjn?=
 =?iso-8859-1?Q?x7WDSfSxPXzfYFuqgx8ZGOwxtsGsJ8I4Es+qcdqx1/8FaAVJ054heZd531?=
 =?iso-8859-1?Q?O1f2rNPkZdZT19wBkj+LCQ4Cuo/xtjxiGSsT68VNDD67fNWK6v+4tPAvyA?=
 =?iso-8859-1?Q?7+VGq+XMXv4A0+ZfBLS6M6sEm/bq5ZWCZ9Pi4s2teHj/bfTYFEZqlJIyXu?=
 =?iso-8859-1?Q?mr+KvF44oMf/1LyK6b1elyeihQeiYp9EtXOqz3mQVORzoliyuultkatpTH?=
 =?iso-8859-1?Q?BCYgbnoddp25hVB56L35jy6UJPbZLlYh8v5mFkFrrc/+4NDpIR68WFeqR1?=
 =?iso-8859-1?Q?CUBZc40MzCITWa6f4J6TTV3P0DE+R+aBrBqdGlv52OcjT39D827UxEDN2L?=
 =?iso-8859-1?Q?eqIZ4hP4HAWB0y/mZwWQBdLvfmfB2gasrYhUI1zYujX3jzvQb0Sl29ZpRR?=
 =?iso-8859-1?Q?P6i20IuHm6kjPTpXzLhznRilj2IvQBij2k+IL5P5sNHJDUgk9A8gqEJAqV?=
 =?iso-8859-1?Q?ZMpsG0GWkLcaC8MEnyfjybtsjObB77kuI210M7pMfXRMVCXrVuqQT4rQ2M?=
 =?iso-8859-1?Q?JkugbOsGyp6XMYiZUEIbqtlAUnzk0PRas2Y/hln5fKm26l5m7JgwYO5b6H?=
 =?iso-8859-1?Q?S/4RLsE7dUsQC6+4GWx9MxM50azc5novCJ2DHKmQ+u6sezEO+SNxQVe5f9?=
 =?iso-8859-1?Q?myRFlV/6FrACTkHBFvlIQJlqF9TUFikBdhQUn+CScKA8DEhDVs0/q1aCMz?=
 =?iso-8859-1?Q?Az8N1aZPNcvB/Yqy/rGDeviq+BjlOAPHHHGU6ct7P+H6LBuDC7acIeaRQ8?=
 =?iso-8859-1?Q?EYvUDHkvFWgqfyGl7QX7SmyfpECUyUQ8MLr+3HKLegbXR9G2Z8eEGwpQq1?=
 =?iso-8859-1?Q?WSdfWXIfi/bNyvmL59YLmC6XJXJ8+ewQphJtAupGA8vGSHE3PL1C5ARM26?=
 =?iso-8859-1?Q?u4u5ZvQjwupoeu8MMKvpW3AxASj947XQh0ewffywQPk1pFouYRD4XKmS9j?=
 =?iso-8859-1?Q?pkkn8SSQ/GRJ4AFceMn5+LHDpfEKyfEBLOkRQj/9zrfo8kOWwGZ6cPS0Ur?=
 =?iso-8859-1?Q?+ngduiOQ/bFh8JCCkQie7ohc9i3pGE3eupHHJnTeF2mByijFj/UJLSpkF6?=
 =?iso-8859-1?Q?gZgbFwFmSDO9J9PVBmmcZDabq8THmuJOuoyxVbNPbYlTGbRU0Krblh2nSk?=
 =?iso-8859-1?Q?MXdOCrAWH8/dKKgj6qWVe0vI8P2gkZiwZWyyCkarR5JTULwoMHJvLfKOjH?=
 =?iso-8859-1?Q?upHa9S8YgY+BOoA4n3XrfyWGPuBQmf60IkRaF8dCZ39blN4WWDdJ9MefgD?=
 =?iso-8859-1?Q?zd1f9FJkSabli3+rL2wVVcwbAnzvZD8yQRgWgm55s+ZtnVMi20159qjXNX?=
 =?iso-8859-1?Q?f0Z5sJf0F8GkDuFNEdZQgbTc7TbTtvRe3orQBmzF3K2KUnMwXxXa27udc0?=
 =?iso-8859-1?Q?ooipOX0Faj0g8OhVCKNQALUXTAkzTtj8FqPUBdo5IAp0Cu3B4h1u9Toqy2?=
 =?iso-8859-1?Q?hdE3r8Rv7B4e+EpK+Ioz/gRuCzvDMrDuoL3eRiA0CdYOI5Lr7zxKDiqimc?=
 =?iso-8859-1?Q?UVSuydztL1NmvN25T1jVawWOfG2a6wcUCsYnZQv7g2RL+VtR3OZV/DE1qf?=
 =?iso-8859-1?Q?E2cVHQik0CWdT36FtcwD3k7kDDKB9+2TNy6nAZpcejYZf15aef6paY2eK7?=
 =?iso-8859-1?Q?L35/KqSlBVoc4fwZWDPKi/KuzmjVpj5dcnxkEvwNxaUj5N8y0cyTEcMIXx?=
 =?iso-8859-1?Q?DIMaJb30sas6bf0Sr0vkIJY2oDLCmNzuVoGynFid30wSVVO4SL0G4i4x4d?=
 =?iso-8859-1?Q?iq7OuVZt2g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MUtrIaIws2aI4xfNCHYIAIkOCsND37AeOcZ65WGQg/qFmyATg17R1TFZm9lF6jTLX358wALFFoaEzzWeu9FH0yQrjC508lsWsVoXdTDxu8sKxmkPaaAEs7PqfsiD0A2dXI7u2HuMQP9gUPrN0O9tBDkJqyk6jf01HOMymDzBxYBKyiCu5MDNIiO023MszmXwTZV2YGBNI4tuz5b7soll+QLL8Z+GNYfUh1+tl6W8HjkFEtCD5e0Ao+yfkizB9URqQPQx7b6MEzJH6mWRxNCwJpmJC9NtkWv+YTagpeiGNoc8X5Gh1yQKM04kBz4O+eNrX2tiVIl6i8BHZQOBv7F+LA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28984265-7c18-4f7f-f2c0-08dedbee4d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:27.9853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvv65v8vnjCL8uB4Dlmkq/9jIbw1EinXv0BFQ23qF/Co1tgj4A+v6YKiWOy2hifhCJtJJxE+8WcFQnvsnuOj8SRIgodW06b/l29qvQ4j408=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

Pass the realized PSP SoC to the SSP/TSP initialization helpers instead=0A=
of retrieving it from the MachineState.=0A=
=0A=
This makes the dependency explicit, since the SSP and TSP coprocessors=0A=
use resources owned by the PSP SoC, including the UARTs, SRAM, SCU and=0A=
SCUIO. The PSP SoC must therefore be realized before the coprocessors=0A=
are initialized.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 26 ++++++++++++++++----------=0A=
 1 file changed, 16 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 8d49bb95d6..58d0b4d7cd 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -134,11 +134,9 @@ static bool ast2700fc_ca35_init(MachineState *machine,=
 Error **errp)=0A=
     return true;=0A=
 }=0A=
 =0A=
-static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)=0A=
+static bool ast2700fc_ssp_init(Ast2700FCState *s, AspeedSoCState *psp,=0A=
+                               Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700FC(machine);=0A=
-    AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
-=0A=
     s->ssp_sysclk =3D clock_new(OBJECT(s), "SSP_SYSCLK");=0A=
     clock_set_hz(s->ssp_sysclk, 200000000ULL);=0A=
 =0A=
@@ -166,11 +164,9 @@ static bool ast2700fc_ssp_init(MachineState *machine, =
Error **errp)=0A=
     return true;=0A=
 }=0A=
 =0A=
-static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)=0A=
+static bool ast2700fc_tsp_init(Ast2700FCState *s, AspeedSoCState *psp,=0A=
+                               Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700FC(machine);=0A=
-    AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
-=0A=
     s->tsp_sysclk =3D clock_new(OBJECT(s), "TSP_SYSCLK");=0A=
     clock_set_hz(s->tsp_sysclk, 200000000ULL);=0A=
 =0A=
@@ -200,9 +196,19 @@ static bool ast2700fc_tsp_init(MachineState *machine, =
Error **errp)=0A=
 =0A=
 static void ast2700fc_init(MachineState *machine)=0A=
 {=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
+    AspeedSoCState *psp;=0A=
+=0A=
     ast2700fc_ca35_init(machine, &error_abort);=0A=
-    ast2700fc_ssp_init(machine, &error_abort);=0A=
-    ast2700fc_tsp_init(machine, &error_abort);=0A=
+=0A=
+    /*=0A=
+     * SSP and TSP use resources owned by the PSP SoC, such as UART,=0A=
+     * SRAM, SCU and SCUIO.  Therefore the PSP SoC must be realized=0A=
+     * before the coprocessors are initialized.=0A=
+     */=0A=
+    psp =3D ASPEED_SOC(&s->ca35);=0A=
+    ast2700fc_ssp_init(s, psp, &error_abort);=0A=
+    ast2700fc_tsp_init(s, psp, &error_abort);=0A=
 }=0A=
 =0A=
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)=0A=
-- =0A=
2.43.0=0A=

