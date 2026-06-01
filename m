Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380C4CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjU-00039s-K6; Sun, 31 May 2026 22:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjS-00038h-Dv; Sun, 31 May 2026 22:50:26 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjQ-0002en-Nb; Sun, 31 May 2026 22:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldQj/DAj20Rg0CgmyzRb/ItBDjgZScuym2K03FJJab+fIdfJInSO6WRX4w0PDuiw6rFXkch6UaiR1+Vn/pS0fBcrTMoHyDjy/9NI+bXyxnP68hO/s281cSfedwgYD7yqV1zY9wmJjkdFPYsjpqZBorrWye568tUP0qO6c08VxDBjruw3LYumdp69oggPCvUtMA3XOl0ZXPIURdNWTgRmJ+kjhzoMnnfGBHAyQBRSU9Qnx1/iYWkOCATcnvsUhVcaPyRgg2YkAem3OB7OKyBMZOEFrBH3a/FL9gN33k5M4JBudaI9OQZQD/bXQ56v1VHvvWgkz01PdTqPaV42nUgOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMvmUyz4dOaXc/K9MwsWy9jaWCHPaSZgP+18ya2c+Ss=;
 b=YkZsipQkI1YGeiouVhDMoIjXzXGbTSbnEM3rZKCbqxwPYYS54gZ5nXy6w11ud/4TZYL3Oqk8g+egHT1o9swTAx3IDf+Eh99lxX5/VRv3hqp4UL96g/SSzbT8HOS4xhEEhwkMmGUGNm/AwC7WVBhnzpEEQ3xMHtcdoCuBUEQ/mg2fVhDDCU9d67xFsOiMVU7diS7SK6vpqfv9x3xX5lYqQhsU/wgnepHjWnPHprjcCUdBJun/1ePh8UXA2XO+KD6F2KCPYyz42oUJGLrerBZ/IfXjs0W7kTcHdcMlkpespLMGx/bJUGtmQKF2/nuZxJls/0xFIrJmpZk1/zsU4KQeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMvmUyz4dOaXc/K9MwsWy9jaWCHPaSZgP+18ya2c+Ss=;
 b=XyAxNI57pQFOI0gT7//GjAQ1/3u2fEg1Vxy2CC4Rj8OkHecm+vMytVIWJ5cyPwQYcjsGP2JGda3KC4y/pkzyWzxC9s+hHa1++pQyb59/i59uJtTLLAjMnYoCFAbfSXQl93AylU5eX3J8o4C8ETEZ+U6V/8y9ejWXKkc6pRs6PxjgM9vuGT9iDznHesiXIIECPD8vXBFe+gY+rk7DNHbkkp+OTp4OSL3KpUiqKMWJWza1TuU59f0hpSBHOgfypkU9g5Qi2Bhl8dM+HQcD3oCrEaLzMrgpIv6dXzLP2IZ6ck3zt+l0ZZt5WYD+6pIu4BJ8JayJnU7RrTE2pdiySnqixQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:10 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 06/24] hw/misc/aspeed_scu: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 06/24] hw/misc/aspeed_scu: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFc6CH5WtbKpk2bAruzpnPjaQ==
Date: Mon, 1 Jun 2026 02:50:10 +0000
Message-ID: <20260601024959.2347639-7-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: 94ef35b7-9241-4d1e-3048-08debf887f48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: IxSPXl445zH9Zf4rtzVQxGe2xCfQfVxP3JegatT+Zbk5KOZIMSLmK1gknnZpy68+OxVo/iK7TPF+2Ls4KpDQ/FdPjEWm8/kfil4MjjA5dnWhk8SHsAbz0Fg7cXRKiYhkv47QtDSyyETP60fN9DMCcE7XjKyWb0LnOd+g3rk+S5nJNU77tr+4w5KY6AnCZY2y/6r14NpYanFadc5KyAY1UMUrdjZOhD0nslBPcveG2BlohJg0tYAKa2Hut1OuKvMsV5Z7q2CSJLwwkvQ4nAlS1TX0HG93Ju1INES9nJ4bmJa2/6GbZZTumtrOW8GT6mkSaTTJq2hrbPX0Sc7RcUt0UWIY566/0ycIm1CUEkbhxfjEmflOjLGJ7WOlz+QpMWEXyedH9cQd6Aidhsaoy2TiPyiZvPG/8mD7mcdoEEV9gr4FLW9cYOcDU0aa9ItObEdBYkLyp59Klqrjp/UnqlNmPAs4kWDkPr7dX+zxUfBtxGveSr+TqC9+BA63TClAtmXgnsvYRi1TloGtBttC72dfgXi270vnBDfd3G3L8BgJ8IGPVMW/srsCzx9YwVRQ6m3HKtoGJzuYmsxF4NFVknRbX9GJL+ESUpHC2okWuU9PZrAFBcny5JD2pv6544kaUs6xYr/losWj4Fr5bBcPMesux7ULa4YmZw662QZMppNbtI7/WoiEQf7ErXfLqo+iKT/1cDYDo8T3poUwlvO0vguTzoapCwl9Cj9FAThJ28b6ie7ZXjxK5ktFHwwtRu50AWBQjKBeD6ap63tA7zquDf0KOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pL82HHLfJMnMEWAL/1s7fPTTJGTRne25fMnq02Jq9o7WFjogwGXNewnWtD?=
 =?iso-8859-1?Q?whpZaa/1QNVmkPNk+tsmbegQG19HEk5+i2zF7cRtGjEFdSHI1DIgJ5t774?=
 =?iso-8859-1?Q?bCiSaa/youiOj9XoECjYHj1TId28XvfEnZQWvT+sfK/lZpvVjCUbUem1xO?=
 =?iso-8859-1?Q?oSp+nAs1FgLvmoUWpiQSRW65fHKOTMyRXmisAYwsRPGuifGz9dJP0JWZZE?=
 =?iso-8859-1?Q?zvF3+6dpIU7w+xQ4WwZLNsmJX6g9tpO1kYIBy3kBsm4ljw1xBad8YjngKj?=
 =?iso-8859-1?Q?a13QT3Y4PkqgLikcmOngVmnKcdeXqXaGcyG/EIlcTMGM6yq/xMANDQJuy0?=
 =?iso-8859-1?Q?5eiAKCpgVya3fBicEHATwxm5sJH8iyXlw8w0MjI1eEUvkv5lkju17Dnf6N?=
 =?iso-8859-1?Q?QqpriC7G3bMYdDANep9DCQhAcyljgW0PUJTXs1WeN1dIRMlZpsNVS7caKT?=
 =?iso-8859-1?Q?/evHgxkGVb/n7HRluWwwi0+66tsqWROEQ3pik+57RQb4if5i7ajqWNT82Z?=
 =?iso-8859-1?Q?Vbtpsr2jPmwmp/VUpa49TLiT/zejUQPv1RhvS6HaJ0Bf1BW8LmVKi/QyuV?=
 =?iso-8859-1?Q?Brv+m9v/k0HBjit4kf/giqviJtxCE47QoIngMnZwFsvZf3kwiR0CcZan2g?=
 =?iso-8859-1?Q?vhRANq2pSvPREnLK5y+bnK1OBidwRD60OreKekuN2zYc4AYOrAFqRg3tKg?=
 =?iso-8859-1?Q?ZoUiEfzlHh2nybjLECi2n0XCPBhHks24ByygrIKaCoSWfj+kpdpkULxqEd?=
 =?iso-8859-1?Q?joQtNU1YT7HVTXkhz8PEfjFNMkypmNbMTdlgRaBnhsh9YYM+pvUoqE6+h+?=
 =?iso-8859-1?Q?G4Mh7all0iHXB8KszMqaAkorwNh/yC81xxuJDvAape2fiq0sPSoAwJUIDN?=
 =?iso-8859-1?Q?ZHo6X5EwLgbDdUSClCPOguAhtfyn8jR4/fgCSWnQomzvswO/0IP58kwoJc?=
 =?iso-8859-1?Q?uhNBzmQJfD+T2/x1oYyFd7urfK0ziERMIgZr0EbKbgoEGZO/b5VgsFwdlD?=
 =?iso-8859-1?Q?5RGZXcf9DAJnvIuJgesrUSKlXFOyRTRrBcp6jmskRpzU71HTbw0vq5lh2t?=
 =?iso-8859-1?Q?ldicoxCwJuCisRKCYeHnbdlX61xcg4WyQT61AIOJVgAMP7BM7/fuMfzxzp?=
 =?iso-8859-1?Q?U8JQSiqxllI9ecaFDdahh6mKWEn2qMoV/eiDAL88HMJSwhx/OKwhtb5kNz?=
 =?iso-8859-1?Q?0OHUkvBiX96bVCF2bSbfkCIpnMuan+rvX+wj34rsRowdleXrD0m2VB8MY1?=
 =?iso-8859-1?Q?Ai/etFG4T31nJQkVPn1921W+Iu/48xfQr5kQLGXwy+1yRTj8BwQrbaFkH9?=
 =?iso-8859-1?Q?aFwsH4XoeUPBuu/CKCvmq6IjLUo5EOpg+J9lM8+JDgz28AkINuImLifu7H?=
 =?iso-8859-1?Q?1SKDNF9cXmbDCl3eWMsBRmsOE0QisJEiq0KCMwj6RQlXg/GfxM8jp2EIH/?=
 =?iso-8859-1?Q?AaiNoGt2wNc+vyI09uHD+6oeejjJoqj6smRjT68JUxRV6/tkKIUC2eyTML?=
 =?iso-8859-1?Q?13QkJ6rL6umCR0/lZCKVTB7E50d/7sQJ/Jvae55uO0/X8WyO082Nh7wSUV?=
 =?iso-8859-1?Q?1/wZTbMumiFybK1PZmIvJfRgvvheADraLoJwG1JRcC7YAhqETbiO/2ENvt?=
 =?iso-8859-1?Q?Di2+fzGhazcJmJ6bH3Y0R8JYhBqAlpA/EDsbCI+Ew4IaTBwmldyCwnKoVg?=
 =?iso-8859-1?Q?OmXCobtyI2lcK6PBaFoy5d19POly8p4wnqqEM21IqL1y+ZtQzFQadgLpZ8?=
 =?iso-8859-1?Q?SQyfulOppvk7fMlWyFMtk8xGKTg21uG/bdyBQiUR2pibgfCukbVCjISA4X?=
 =?iso-8859-1?Q?ACmnBWSaQQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cmJ5LD5MJNxdHy/Bj38LuhLvSMbBgZtkInnkOuiIZEahZg/r/2Z3Wj7f4+twqaLttWsdFCN4rjd2C9cVH5YrHCng2pd1fs5MyKh4RwFqFLRnlOPMjn+JPzWSC3lWaWU5GFj7ma7gLahfeLIEhjCXGtFvcxQGzareS1c+R2UfnAE4pDCupXCU1lZRfiqN6mYboYhZBIpwPJH7Z4DJlsnlAA1pF/L117mLNeJVig9dzjZiQhrGvRYfL3hMBEkiCBDslmXEhCyQzFIvKL2ZCpo3DqMjjGsXcOCB5LqflIQgOqvAn/aO7oBcGpqv1rXP4vbIL8vaShd9FTEzje2FiT7lVQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef35b7-9241-4d1e-3048-08debf887f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:10.4741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvmQu+Q2Eu4BMY9JBI8rXpYXluIVjeVayO1nK2c+qFH937XlAE0S8cBa17Fz36/vn/fvlimjzLNn7s1teT0ocOPwMNcrQmLydqu3Iy2laa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 7 standalone TypeInfo variables (aspeed_scu_info as abstract=0A=
base, aspeed_2400_scu_info, aspeed_2500_scu_info, aspeed_2600_scu_info,=0A=
aspeed_1030_scu_info, aspeed_2700_scu_info, aspeed_2700_scuio_info)=0A=
directly into the 'aspeed_scu_types[]' array, removing the need for=0A=
separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 107 +++++++++++++++++++------------------------=0A=
 1 file changed, 46 insertions(+), 61 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 19da6c075f..fe731a28bd 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -624,15 +624,6 @@ static void aspeed_scu_class_init(ObjectClass *klass, =
const void *data)=0A=
     device_class_set_props(dc, aspeed_scu_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_scu_info =3D {=0A=
-    .name =3D TYPE_ASPEED_SCU,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
-    .class_init =3D aspeed_scu_class_init,=0A=
-    .class_size    =3D sizeof(AspeedSCUClass),=0A=
-    .abstract      =3D true,=0A=
-};=0A=
-=0A=
 static void aspeed_2400_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -648,13 +639,6 @@ static void aspeed_2400_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2400_scu_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_scu_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2400_SCU,=0A=
-    .parent =3D TYPE_ASPEED_SCU,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
-    .class_init =3D aspeed_2400_scu_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2500_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -670,13 +654,6 @@ static void aspeed_2500_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2500_scu_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_scu_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2500_SCU,=0A=
-    .parent =3D TYPE_ASPEED_SCU,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
-    .class_init =3D aspeed_2500_scu_class_init,=0A=
-};=0A=
-=0A=
 static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
@@ -859,13 +836,6 @@ static void aspeed_2600_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2600_scu_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_scu_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2600_SCU,=0A=
-    .parent =3D TYPE_ASPEED_SCU,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
-    .class_init =3D aspeed_2600_scu_class_init,=0A=
-};=0A=
-=0A=
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
@@ -1099,20 +1069,6 @@ static void aspeed_2700_scuio_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2700_scuio_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_scu_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_SCU,=0A=
-    .parent =3D TYPE_ASPEED_SCU,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
-    .class_init =3D aspeed_2700_scu_class_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_2700_scuio_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_SCUIO,=0A=
-    .parent =3D TYPE_ASPEED_SCU,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
-    .class_init =3D aspeed_2700_scuio_class_init,=0A=
-};=0A=
-=0A=
 static const uint32_t ast1030_a1_resets[ASPEED_AST2600_SCU_NR_REGS] =3D {=
=0A=
     [AST2600_SYS_RST_CTRL]      =3D 0xFFC3FED8,=0A=
     [AST2600_SYS_RST_CTRL2]     =3D 0x09FFFFFC,=0A=
@@ -1158,22 +1114,51 @@ static void aspeed_1030_scu_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2600_scu_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_1030_scu_info =3D {=0A=
-    .name =3D TYPE_ASPEED_1030_SCU,=0A=
-    .parent =3D TYPE_ASPEED_SCU,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
-    .class_init =3D aspeed_1030_scu_class_init,=0A=
+static const TypeInfo aspeed_scu_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_SCU,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .class_init =3D aspeed_scu_class_init,=0A=
+        .class_size    =3D sizeof(AspeedSCUClass),=0A=
+        .abstract      =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_1030_SCU,=0A=
+        .parent =3D TYPE_ASPEED_SCU,=0A=
+        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .class_init =3D aspeed_1030_scu_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2400_SCU,=0A=
+        .parent =3D TYPE_ASPEED_SCU,=0A=
+        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .class_init =3D aspeed_2400_scu_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2500_SCU,=0A=
+        .parent =3D TYPE_ASPEED_SCU,=0A=
+        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .class_init =3D aspeed_2500_scu_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2600_SCU,=0A=
+        .parent =3D TYPE_ASPEED_SCU,=0A=
+        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .class_init =3D aspeed_2600_scu_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_SCU,=0A=
+        .parent =3D TYPE_ASPEED_SCU,=0A=
+        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .class_init =3D aspeed_2700_scu_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_SCUIO,=0A=
+        .parent =3D TYPE_ASPEED_SCU,=0A=
+        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .class_init =3D aspeed_2700_scuio_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_scu_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_scu_info);=0A=
-    type_register_static(&aspeed_2400_scu_info);=0A=
-    type_register_static(&aspeed_2500_scu_info);=0A=
-    type_register_static(&aspeed_2600_scu_info);=0A=
-    type_register_static(&aspeed_1030_scu_info);=0A=
-    type_register_static(&aspeed_2700_scu_info);=0A=
-    type_register_static(&aspeed_2700_scuio_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_scu_register_types);=0A=
+DEFINE_TYPES(aspeed_scu_types)=0A=
-- =0A=
2.43.0=0A=

