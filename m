Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4596FCD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8j-0001jx-OO; Mon, 25 May 2026 00:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8W-0001gD-CX; Mon, 25 May 2026 00:41:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8T-0001Fm-P9; Mon, 25 May 2026 00:41:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiE+ATeiMlGuhv6inQGe0ZyPqEBGdxIn5biKCzhKtUs8oNvoZSPi5Ao+fzp3vY2QnXRSMLcFhDoSQNEV7oUiqkhR96C5KeCl4K7HUoezFLRZZBF5GkY8uu654bLE9XHVpjjLnHjeKlvq4l0siJ6lBLkOApD076vigNqKfg138FTUHx1IZ5L2098aV5ICl0chtT49CTV/4uVDUxAQ73PRshT+tgIOoRNOYm0e3DXXSSFP7z/F3aubTj9fOiSnL+xjQ47wki+bOIrya6rN3uhX+qSC3O7zVnpkgLVlaLEWF66ipkwkho5O7Oe7XpzeTYuoQhBe3PVn/Nbzg5wlMcYRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cab454BEmaBF41gEsE6WCjH03hL6W0rrAc9izSSgPcI=;
 b=J9XGTINK4p6XaQRRiAah5Ks7eBDtvDenwjeBfOq0gzKaNrbKlOCp+MsZ6UtD0g4/bfKW9hmBLIzaHxKiHdTgayiwPmmQ0pmZRNZKAreP3vIsJd3JqM0MoWOgb7nxFa1Sr8cNiMLEo3TdvRNECRY90raYSFth78mVpJbiw95d23/sViCaMaSArK/a5fcsJTuAx9kiD8M67It8e9mQy7ayF3W80mpVqrIAkkMqPFRmpxabM3MY0yzQF1DRMm+HBHC6ZNwLJXYl+Wlyb0ojWz9VPFMUG6NX1dv646QgzeGPgMt9mx7zqAPtjsDvUN5jrF2wWdeFou93TOUJHDZjaRHY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cab454BEmaBF41gEsE6WCjH03hL6W0rrAc9izSSgPcI=;
 b=bNqzWa1shUB7p+FMOK8Ae9Bh0D+HoSlulgO1xVVon7ydvFQYZRxkeAx0Wph51rZXNA9DhwWJyEKESu+xGwNZtTEDKmdiHCxVp3kz6WfRvkIktHxVQBj1COX583lIpQYSwhuQwvT1QsjVZ6XJgpI/r5JR5QKq2euthoHJR3Mn/nyD/hOeOtC85e/5r99HZq9G++UK//z8gBWuwh8oqlVSITA3k39acjYu3rVUDtjqF1hRQME23bH1S6ZJrP0xDnmQGjuU02N49QHr+GyVATQ2D0AkfaEL2ol1oYuFVQt1DrTvdk67yLatymYpX04lUHhpzHfnMZu2v5KGuPNwMM7qEA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:42 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:41 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 08/23] hw/misc/aspeed_scu: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 08/23] hw/misc/aspeed_scu: convert to use Resettable
 interface
Thread-Index: AQHc7ADIPNoeJn621EqL+DBm4UtWDQ==
Date: Mon, 25 May 2026 04:41:41 +0000
Message-ID: <20260525044129.3133916-9-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: 1a409a88-a132-42e0-8adb-08deba17eacc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: uKjFMjtMKPnIhcbHuDIETPhcLbLc5FT18g+rUDq29u+4Tt+ExpeTxOMK5ShUrJGUuEbh+Jz6QNPTcXCBNJUCwIzZc0jG4MzEjayrz4ICGmzBZf+dKY6zt0sLwMOTLTqCCa7cWtb2Zjj4A1hD1kAFNhAgrXhO8dFgYJwE2kADWqFvmPZOTwt5wu2uGyEERS8YNbTay0SkyQcHJO4wCW/AHBANOOs/Q7UGYG4+OJcsl0Wt6y/JgIutsgnM2RayV5mSYiumivgX8nkIi/NbQVNeg7fNUjIBp+Z+ATd/rj7toKqiHT+Ty4/Suc92UGLL6RVaM5ZR4CiIcrjYPQcZHqRRajFsl+N6M2HUQg5u2RJov87XnDhTQREUrSiUWN9yZt7MiacfcUE8sfrdwQu4nYa3oiwE1SCn5qM5H2eOuj+D/WFfve9Mkahyb2Rx6E8Kdv8cTx4VVBXb2AigTcblDmZA3sDmJ+SG0i55PpoocVd9EDWFJruAEqQRZ74RNr59whqphlf4iEu+YS/Dq4dsicuA9F816haY442Twu97Xdo5my1dWyMjNK0F6ujn+I/4D14LqVDoWm+8h71oauafXasAO/zyo0rN0NpKN+KOyzXUAHRrljEhT2+CEv+ffW4sEOaA1AeupwVyjKwoGMbnbn6g+W/1pQdaKGWukNgeUc4pjB8m3FKYAQQmXmdWRtak68/ndtaMeUkuQ/828rZLbk5Yobx4QsNpB3M+LUwzD/jWa4qh/BxNy57tlXcj9flo0JtnvrNC4MjjtxMp5+82WH9l2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QsxdVNIhCWJyfyfb48pqCxsg97KeaYztS2YxJ5AO7LDg+tyMdvwd1CmkQr?=
 =?iso-8859-1?Q?1OwN6qRYeUMUalZhcmQZ7Kv/yN/KGo3PjfoU3HbdCFvWilZ5IdsS8G1+6r?=
 =?iso-8859-1?Q?KghQ9wAr0sx4HwPtDqS3D9lw+d4WULUYaMoHf8Mh8ukdt81A/4wFBJy3Co?=
 =?iso-8859-1?Q?EhR8RmqMQd2i721gUeEkfisA7vNZYuJLfm4UsfQW+iRehqVG2BqmJmEmL1?=
 =?iso-8859-1?Q?JE2EpsTw/1xQCca2osM7gz9KhLUuo5FFm0MWQxDVlPYhV22w21M6PslRZd?=
 =?iso-8859-1?Q?PrVby0hrIPltdV7xMOU0wDNefQS4221K25h4uqVSL1W9PCbxxOmo7PaHZi?=
 =?iso-8859-1?Q?UDOmnuzvpLrMKQJO8GoWn/DZuG+Tvv1jLA4BfErIfJXC4sc4vfZNF6M5zp?=
 =?iso-8859-1?Q?BMMOL9xbA/PFW1V8b4olCyFB81XGtTGpR+VNk26jGndNuFE6q3cyDZKQ7S?=
 =?iso-8859-1?Q?ZbTwiLD+A0EsYCD6pQEK5SzYmiaEmO9B8JgXol4e/Y7/2V7S6EnBbigfw1?=
 =?iso-8859-1?Q?87NeSGyf1/Jwx+/gZzMuOWQTO6CAszwnzJe+3XmCMlq5yj9GtvNxvIjzQm?=
 =?iso-8859-1?Q?A6/pL8i7yJpiVRtX6huTYBFlHM8gCeOoTKHWQzOpydpj1QEwYXQkQX9Vfz?=
 =?iso-8859-1?Q?Fh20dQfxdY+kY3DFupj3UmhnTv/PT1E6H0v7TnboZQX+zueYNSJ+X62kws?=
 =?iso-8859-1?Q?8gqgLvnUO1r+K5tjBYFtapyQg1yoIVPtjU6Ox6+kShtz1ghitQlFWWkxnb?=
 =?iso-8859-1?Q?BfqpJWyoJMOYlCvEedl8w/DCUBMF7FconY77AfAYIvAW7SHXvXHN81IC29?=
 =?iso-8859-1?Q?xgHqZqDACRS5Q4sQIyqku0U8LO2GXtMJ5WLq/KUH9Syi6xKqvWqK0QTTK6?=
 =?iso-8859-1?Q?LgFHv++uMSl+iK1rUJB5xNvd/bXWVX4BoBfTj5hV5rOhbGl0gPQZYLviOV?=
 =?iso-8859-1?Q?m/1k4JGjYYDAW5+1xwIAnGkFJbY26Dqugb733/h8nQtFOxr1Ak5Ms+XbuL?=
 =?iso-8859-1?Q?7deGf/V+9daLA1Quv4omwasHqRNrilKTD8w6NeHtRi4aFVJqfpMQEt/L39?=
 =?iso-8859-1?Q?IhfmcsSBJd6iWo1/6FllnMYtP6LmI6uZ+7oKALYLhAmkD7nsuZG/+sUVR6?=
 =?iso-8859-1?Q?GE8W5BUCipD9uUxjWm0tFSaF+b8IHEyo8UxjC3V6Kr2X1b7kbwAdhUwelu?=
 =?iso-8859-1?Q?5XvVKHbM1Y3wzVonLP+FdOGXEgXjqFcONVn0p31BaVF2D9kVxhhr6Kmw7Z?=
 =?iso-8859-1?Q?bujzoVxvpB3NHBl/ZddOS/NZStcV4nbEDr//0LmE4tgGtpWlNwxZuKeXE+?=
 =?iso-8859-1?Q?O9uzEBORAAffMwLZhiD7PBUF6CBS1VvF+S0FJJEMKPxZmu8b0JwBsWhagq?=
 =?iso-8859-1?Q?Hhiy3NYUkRvP2cX+9uQMVslqjUrwbv3r6PPvNYOpe18mgnwz5Nh+DOwlHA?=
 =?iso-8859-1?Q?eZvLnMT2Uym0ElgOMfoSELhg5yu3XLqC+b3/HansYoAv7ZRNLlzumrGxA7?=
 =?iso-8859-1?Q?NLVdqldv7sNyDH9dNsZqphEGpBXYlmEJqWLhOCeOIsyxLRDNYA6NuWI3LT?=
 =?iso-8859-1?Q?uDb1+RLxSffTzxhkfsJ2FhBQkEiIQ8Sl3yJ1/BfOyTbMi6x45gygNhEhhj?=
 =?iso-8859-1?Q?Qgna7KIlKWcFPPeKu62LSh9uTVtvO1v3YcHF1FBm2jKW+JZWzc0XSDM1iP?=
 =?iso-8859-1?Q?+PmJT+k98n6NM7MkFYKPKe1MMLCtvravAlQBkeR9GihGxe0qBy5fSssX0/?=
 =?iso-8859-1?Q?kky9q8jzAmePw5KJ2g02r6TiSwJWoKhHqNRudR02lvbhuGyrFLISXH9GQ/?=
 =?iso-8859-1?Q?ySDKNvC/qQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QAadENleSU2qwF6ph1WPqCHO1pB/oGkjPWjTyf4KfAolpEwmnmLvIh3xyAM0apPTSebXIy+S7mR2O4MR9V5AYPB5fgw65HjvQH5tWPEgfnWN2SrrzdS9pf22NoBNBfuUbMwzeavwy8LP0jjcCK9fy6Y+qJiWS4joC1L0NeFjc0KRBLJ8T/tspBRO5R0VarBNggcXLGtLHDDH6piHy9Zv4dmncR0iaQt0MPrYkI8oQGHpVFroFEFS1gNG7XYEkMYhmiS/U7D/MgvMLYhkFCmSUYWXM99iboWyuhRErEmnfN5uy7u5qiUmloe2PHQ1KAehTNNOYq+ongSQzDjHnhT0tw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a409a88-a132-42e0-8adb-08deba17eacc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:41.9406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtIaprzXxKbKvyx13tsjS+pIKI1BfFafAx2kYn47fT/6YlanlYBmgX6+82TObcZ6tIPB1odHoeX+/S8MA1IzBCihqhRb9gw2DHajYuIH8Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 39 ++++++++++++++++++++++-----------------=0A=
 1 file changed, 22 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index e4160356e4..d7315bbb9a 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -542,10 +542,10 @@ static uint32_t aspeed_2600_scu_calc_hpll(AspeedSCUSt=
ate *s, uint32_t hpll_reg)=0A=
     return clkin * multiplier;=0A=
 }=0A=
 =0A=
-static void aspeed_scu_reset(DeviceState *dev)=0A=
+static void aspeed_scu_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSCUState *s =3D ASPEED_SCU(dev);=0A=
-    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
 =0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
     s->regs[SILICON_REV] =3D s->silicon_rev;=0A=
@@ -615,8 +615,9 @@ static const Property aspeed_scu_properties[] =3D {=0A=
 static void aspeed_scu_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     dc->realize =3D aspeed_scu_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_scu_reset);=0A=
+    rc->phases.hold =3D aspeed_scu_reset_hold;=0A=
     dc->desc =3D "ASPEED System Control Unit";=0A=
     dc->vmsd =3D &vmstate_aspeed_scu;=0A=
     device_class_set_props(dc, aspeed_scu_properties);=0A=
@@ -821,10 +822,10 @@ static const uint32_t ast2600_a3_resets[ASPEED_AST260=
0_SCU_NR_REGS] =3D {=0A=
     [AST2600_CHIP_ID1]          =3D 0x88884444,=0A=
 };=0A=
 =0A=
-static void aspeed_ast2600_scu_reset(DeviceState *dev)=0A=
+static void aspeed_ast2600_scu_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSCUState *s =3D ASPEED_SCU(dev);=0A=
-    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
 =0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
 =0A=
@@ -843,10 +844,11 @@ static void aspeed_ast2600_scu_reset(DeviceState *dev=
)=0A=
 static void aspeed_2600_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2600 System Control Unit";=0A=
-    device_class_set_legacy_reset(dc, aspeed_ast2600_scu_reset);=0A=
+    rc->phases.hold =3D aspeed_ast2600_scu_reset_hold;=0A=
     asc->resets =3D ast2600_a3_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2600_scu_get_apb_freq;=0A=
@@ -949,10 +951,10 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCU_VGA_SCRATCH_0]     =3D 0x00000040,=0A=
 };=0A=
 =0A=
-static void aspeed_ast2700_scu_reset(DeviceState *dev)=0A=
+static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSCUState *s =3D ASPEED_SCU(dev);=0A=
-    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
 =0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
     s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
@@ -962,10 +964,11 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev=
)=0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
-    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);=0A=
+    rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scu_get_apb_freq;=0A=
@@ -1081,10 +1084,11 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_A=
ST2700_SCU_NR_REGS] =3D {=0A=
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit I/O";=0A=
-    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);=0A=
+    rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets_io;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scuio_get_apb_freq;=0A=
@@ -1122,10 +1126,10 @@ static const uint32_t ast1030_a1_resets[ASPEED_AST2=
600_SCU_NR_REGS] =3D {=0A=
     [AST2600_CHIP_ID1]          =3D 0x0BADCAFE,=0A=
 };=0A=
 =0A=
-static void aspeed_ast1030_scu_reset(DeviceState *dev)=0A=
+static void aspeed_ast1030_scu_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSCUState *s =3D ASPEED_SCU(dev);=0A=
-    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
 =0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
 =0A=
@@ -1139,10 +1143,11 @@ static void aspeed_ast1030_scu_reset(DeviceState *d=
ev)=0A=
 static void aspeed_1030_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 1030 System Control Unit";=0A=
-    device_class_set_legacy_reset(dc, aspeed_ast1030_scu_reset);=0A=
+    rc->phases.hold =3D aspeed_ast1030_scu_reset_hold;=0A=
     asc->resets =3D ast1030_a1_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_1030_scu_get_apb_freq;=0A=
-- =0A=
2.43.0=0A=

