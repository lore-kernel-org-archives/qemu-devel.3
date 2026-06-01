Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B6CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsju-0003P5-OS; Sun, 31 May 2026 22:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjs-0003O8-QV; Sun, 31 May 2026 22:50:52 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjq-0002lH-8I; Sun, 31 May 2026 22:50:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUjhPbUC0iKydqTrswUUFVebJa3pz401M17buMqWAmd00hF1AuOE0qMTC0qO4cQ66KwX7T2+j8X66OJ4AeqU/66Fq3nJVZYcJtMw2fDmx7w0k31AdX4QxBI6axUAhn1yOZ6af2t2n6X7ouD4ZPzvr0Lt9OxC5S17XksNdWdC/fWVJW0ksHTuWxZum5QocNZv9lwUbEGd1Do7iSPFVUDQzO6xbh6nKQQkdYdYxRxWmIcVFDD3lseLFRhbOccbYvBTbYeKp1GxbK/vvnDZoM/ALovrF4E5RYjAUoKNwUmJ8xLAPRzHh6Od1jbRAeIIZHW2MTNTGWhxsCVuW61ouNeRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuh/iFzln9U8tpSiaz0PD7UvwKyrpdy/M3SHFTLJzZQ=;
 b=L+SVsXZm+PLJy7Y2cz5oLunfGqGR+PukdnV7ZIZUI1DBuyDJHwpxxAV4ze1pVjKg05gSQWfYfbfAqPk5IDdHA58W7f+pyCyBpw/KA0mz0Y442kwzVggDAlEh+ooJSdQWIsK23aj8mrKKrTMV5RSOln8NHhEgzvyGolRltOYw/PPRtD4VNp+IFk0hjFTkw/2B156vJCIrpdKZ7sahr0Fxl5GNIHrXi7/UEllQKuS5RQvI5Z4ulaIEprjrVx+wcImTT37534kgIBRGlToOrH0RCIDmm3xd4ZIzvh9lf1nsyNgZ9eKii0nM9dBtBnZSRv/1mWF/uu39DYrjCSvpRy5kMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuh/iFzln9U8tpSiaz0PD7UvwKyrpdy/M3SHFTLJzZQ=;
 b=BVSVm9XDFD+8u/kyNIlIJ+y8bPDbXxhVpp8Vw12EZXrc0buDULL92zFAwpQYkPPSfjJ9LoXATPGpBauWjtw1S8HDl/YbjspJZphAIoXvoOyAwqVKqnLOelCmdkQO7XLIB39h/6jM7UhNqP5stUCZVWn1bfGF94cUOtuq9jfA5iS7e3SRDElm1T1vp0pdfeNocz4WxhkdMr2CLWdeA1Utab00fixoTMGVJBg1MwTLd7EGgkOFMGhWT2w7AiUtFojMMRPjJqHxFOHd5LXd6Mlh2y5VVkJeFjJQLeEat9sg26aBgXW1gnNqv3NNMVJY8b2k9+nL4KtJS7ryQ5iR4XhMnQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 24/24] hw/ssi/aspeed_smc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 24/24] hw/ssi/aspeed_smc: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFs0GSysgkcDkSrG9sWstDy1g==
Date: Mon, 1 Jun 2026 02:50:36 +0000
Message-ID: <20260601024959.2347639-25-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: 1a92ca54-3be3-44f9-886e-08debf888f33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|3023799007|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: CjyJEGf9baTDCAVqGrGQCCHLHfTaQj4TvysrmQ1HEPpFUIp+yb1WnfbQi6dBCOZRUAPhrc9Zhy9SxeLmb7aiSQJIkqUBCTD8fs+/xwUaklbyFjICAfoTpnyuhAFChTU+WdIvSkDzGoYcLdCGUnQRGFshIm7ZKkkSyGBraMfVQmb9nsh9ky39e51jqEnD6v3+wWUWO9M8qMl8ktdeWMNrYri5l4yGIziPxa/zxfTeLkPYWHLAqa5vIepO4APbHWtrpINY8OmvTFpUeD+0qTfmQQIZPieUECv1Itm5HKIJxiV/7/bgmQVB4gog6Emmh2zlTqjk7U3034/VqVnhpZ9by6YM+bC090yKtW5vDjn6+RG5nkCf4GcC/Jyw0f/TSa8YMaVO3pauyC6CJbzc+kscI1/UeuvRJq5LwnDxz7zVL+wJDX5lmZbvLxYVm8dkvRCiGj/zxqY/tqTjfPxV+S1hnuWs93J6+0/S1gxZ6GfIoPjJXlw4ATiZLsAZ5RpJC/mL2qZ/XA7EtJAPLW0mKfCBOaNPgZh1dZBI8EYbqYdtK4xZ2F193vQGetulangEs3MIbJGaMK6ZNm7SAYDoce1PVlC6jLHZ6Q5m01TK+xVBuUvUFFhD+U/ODiwYcbfFRys3XqWs4ITORR0fKkWEPOnFBuqke5zbQT+KrMdMSbltFIzPLCK82x+nTNyeE6gH/lOQgPwFHZOe5+XUcRMkoQcJN8VuaCzxkDlkwpHuo6F6G56BBVKwb4YB7Lt4iDSUvvnDfAvrL897omvRsc2UB7c6Gw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ULbsuJO0rUlMv63jHtLDAyqeoPhBLKwcasZPnXXUT3qi78l9Pe1zd4Zg1P?=
 =?iso-8859-1?Q?n/WFUfyj0e2IMwzi91JtDJLXW8C54u7xvKK+4qG22ltEpqj6OlEPRaWOxj?=
 =?iso-8859-1?Q?YMBxQ4T7lfYSWZYvxBHovnQMK4KjOFOXFxn+LJzxlUPUJyory0K3SejHaC?=
 =?iso-8859-1?Q?FssSjfpx1XhmaKI5r+AZBRO7jmSiZjFPE0s9t7/W0LVWDgryMpu4NmF7o+?=
 =?iso-8859-1?Q?kDhNKtxDqBjdEpETQw5lW+WTMQl8gD1Mruc5kbR4cnjJAa7OsEHLB999yk?=
 =?iso-8859-1?Q?624z8EhipekREwLFmYGqD7qZGUAWcN14OfIiO7OfvPq7iwvEPqcgpsb5Ev?=
 =?iso-8859-1?Q?/eqPtpGN/C12ZQh3wU+eFVBlkMQWbsC35BOdINMZrsNYU7fTeN+/1MzRev?=
 =?iso-8859-1?Q?HARkOETXquKV0tkzluJGQl/XzRE/Tqgd5d6Yc7M2rD1g+zLvfjMQOHnHrF?=
 =?iso-8859-1?Q?+bAl0R+6x9SWGNVcwovRWEfwsLmAfbIxc7KlYPw7ZRqOCQ9IYVqds0xJ4t?=
 =?iso-8859-1?Q?T2KrTaDi9/4SBZLjjL8V0DiTRiVrevwf9sk2CSNm8wZpN56bb1NC4mVmVk?=
 =?iso-8859-1?Q?DKFugPLpne7nPqWEBINORoXfT9v4shV+RxnZso/mASc58eAZSYXgiZ4ud8?=
 =?iso-8859-1?Q?IH7cCk+CQBa4yjCQomylEO9wSA2zOklMIf173XZsDtpiL/yg7GoKuQhypB?=
 =?iso-8859-1?Q?KXqSpfbl7QK/Qt1GPK5GdJStxlXGzDNeAHifQCxWCBGk0tjgvtavx7UOyd?=
 =?iso-8859-1?Q?fXsanrbVX3sqA2C8rDkObZ+I8+j/+BwpQ6e1C5k5prGcBGwFvqlH+x0rnQ?=
 =?iso-8859-1?Q?oS/VWRmDwBfb23qwue6wHbnMNALq5Wcyk9SE2aQzx/3juSa8qARif7zMBW?=
 =?iso-8859-1?Q?i/ySgsSe+rnxklQQEI5phDKEHcCPZI8xcCPA8UjDGAJRj+/80ZznF9tPHE?=
 =?iso-8859-1?Q?xyEfGuuQbF/WHFbDAuTA6LMpOA67gGTo2oYrLiF7NWeML+PQKX35TaIgrm?=
 =?iso-8859-1?Q?O1giDvlXTFWB8XZtNLKYuCZlrLwkN2lCiBkBdKwIZfwaiefSYoOk/JdAIm?=
 =?iso-8859-1?Q?wAT9hDwRSU/PwfGXh+SNJeddy7wDVWxWr6UBKHg7PaN4j+BmwTTuWzyJOl?=
 =?iso-8859-1?Q?jpUWe3J/trYbhSPKwYqnDwSUSRt7XAhIzJwgmtJjsIMmzXWFGwdOzY8kcB?=
 =?iso-8859-1?Q?zxLnZRwXq4EdGcGqW7vM+jZutkA75kiKP98ATO4togWBJt7GmDLf2IylCn?=
 =?iso-8859-1?Q?GELUaViLr4rcY7s6KoliJmEdjzf9jqm4+/SL+Orq3N/Zip1Z/vaj+pyp4B?=
 =?iso-8859-1?Q?NtAEMZ3DVingQZnxm9kvRL1WIoDmYvWu8Za5Z8QO7PPHs3ftpWARwqFKVy?=
 =?iso-8859-1?Q?263wPLXLW3G4zo1I+5WyLcDH8ssCNBVEQPtdu7JGoKnlcgjoQby2Zw+5FL?=
 =?iso-8859-1?Q?0vFtTWAwjYtvhJ/tviZtpqYhPXqWvdFAx7+dsA5xq0oj6voS7SEfMof6Pf?=
 =?iso-8859-1?Q?p07xiw/v+7O7PPJmJvRv4FBGAK5D7jVcS/zL9D+bQh33L+lV7Q+sgyL2nL?=
 =?iso-8859-1?Q?fxM5c4ugR0aW8hHGQZcEaTO/oayydnLIcZOVhxbcTmw5ZrUiUup3HQ3RJk?=
 =?iso-8859-1?Q?EPN9TbOEecILsUTSuHzgJjCSVcTIkKo0T0tQ1DYo8NL5edARhoVTr8VMuy?=
 =?iso-8859-1?Q?7UEYt1O1vuGPEEHtw/YE5RrYXGgnlHVgHk75qnyYjzWAXNXfejHG9J3GvK?=
 =?iso-8859-1?Q?FzJm8uR8BbEavX80hSuvwa19B5l3mlsZlEmyuHBPnfmFuEc58SzI9IJ9wz?=
 =?iso-8859-1?Q?7RSD1F8SYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y6Ef8jBgwE2gIXdBQ+Yi8Wn0Cp2c0p/qUyV4D88e+O4km374Xwc8T0QwJreoCwEJCPyrrEpTsda4y68o1x5cyfefkSYTVJCWvMSFbqi4o2WEoIr6NK2nlpo0HTzIQFyYuiqvN+7WsddTHUxa201t5bq6X017YOcU7X8lxRcIvZ4asOw9P0tfAquwzZvv9N0Nm2fitn+XTUtwvcXa2U1ksFxNyRuEWAQH4BlX+hDvgvFFuQDwD7eNYLp4pBM/XTlYNvwOiHqkTOuPovNjdaf0dmbxrvhmk8/P+eVf5+20FsqrkW8FyeZbL7EdEcrftg2V+na0KODNfFZOBGLGY2NvJA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a92ca54-3be3-44f9-886e-08debf888f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:36.9637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eimaBQF1mmgkPk8w4VRfv992bnUw07e6Hgr6iGg7BYlycYZcBmqEHFsSFsQQjfigll7JdlaFXXfzIp3fX5Kok7TFEvJFCkbTMzkfrUdaSR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 18 standalone TypeInfo variables (aspeed_smc_flash_info,=0A=
aspeed_smc_info as abstract base, aspeed_2400_smc_info,=0A=
aspeed_2400_fmc_info, aspeed_2400_spi1_info, aspeed_2500_fmc_info,=0A=
aspeed_2500_spi1_info, aspeed_2500_spi2_info, aspeed_2600_fmc_info,=0A=
aspeed_2600_spi1_info, aspeed_2600_spi2_info, aspeed_1030_fmc_info,=0A=
aspeed_1030_spi1_info, aspeed_1030_spi2_info, aspeed_2700_fmc_info,=0A=
aspeed_2700_spi0_info, aspeed_2700_spi1_info, aspeed_2700_spi2_info)=0A=
directly into the 'aspeed_smc_types[]' array, removing the need for=0A=
separate declarations.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 228 +++++++++++++++++++-------------------------=0A=
 1 file changed, 96 insertions(+), 132 deletions(-)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index 3767ad0c7a..d87fbd798c 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -1312,16 +1312,6 @@ static void aspeed_smc_class_init(ObjectClass *klass=
, const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_smc;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_smc_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_SMC,=0A=
-    .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init  =3D aspeed_smc_instance_init,=0A=
-    .instance_size  =3D sizeof(AspeedSMCState),=0A=
-    .class_size     =3D sizeof(AspeedSMCClass),=0A=
-    .class_init     =3D aspeed_smc_class_init,=0A=
-    .abstract       =3D true,=0A=
-};=0A=
-=0A=
 static void aspeed_smc_flash_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     AspeedSMCFlash *s =3D ASPEED_SMC_FLASH(dev);=0A=
@@ -1358,13 +1348,6 @@ static void aspeed_smc_flash_class_init(ObjectClass =
*klass, const void *data)=0A=
     device_class_set_props(dc, aspeed_smc_flash_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_smc_flash_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_SMC_FLASH,=0A=
-    .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size  =3D sizeof(AspeedSMCFlash),=0A=
-    .class_init     =3D aspeed_smc_flash_class_init,=0A=
-};=0A=
-=0A=
 /*=0A=
  * The Segment Registers of the AST2400 and AST2500 have a 8MB=0A=
  * unit. The address range of a flash SPI peripheral is encoded with=0A=
@@ -1415,12 +1398,6 @@ static void aspeed_2400_smc_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_smc_info =3D {=0A=
-    .name =3D  "aspeed.smc-ast2400",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2400_smc_class_init,=0A=
-};=0A=
-=0A=
 static const uint32_t aspeed_2400_fmc_resets[ASPEED_SMC_R_MAX] =3D {=0A=
     /*=0A=
      * CE0 and CE1 types are HW strapped in SCU70. Do it here to=0A=
@@ -1466,12 +1443,6 @@ static void aspeed_2400_fmc_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_fmc_info =3D {=0A=
-    .name =3D  "aspeed.fmc-ast2400",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2400_fmc_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2400_spi1_segments[] =3D {=0A=
     { 0x30000000, 64 * MiB },=0A=
 };=0A=
@@ -1506,12 +1477,6 @@ static void aspeed_2400_spi1_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_spi1_info =3D {=0A=
-    .name =3D  "aspeed.spi1-ast2400",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2400_spi1_class_init,=0A=
-};=0A=
-=0A=
 static const uint32_t aspeed_2500_fmc_resets[ASPEED_SMC_R_MAX] =3D {=0A=
     [R_CONF] =3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |=0A=
                 CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),=0A=
@@ -1552,12 +1517,6 @@ static void aspeed_2500_fmc_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_fmc_info =3D {=0A=
-    .name =3D  "aspeed.fmc-ast2500",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2500_fmc_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2500_spi1_segments[] =3D {=0A=
     { 0x30000000, 32 * MiB }, /* start address is readonly */=0A=
     { 0x32000000, 96 * MiB }, /* end address is readonly */=0A=
@@ -1588,12 +1547,6 @@ static void aspeed_2500_spi1_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_spi1_info =3D {=0A=
-    .name =3D  "aspeed.spi1-ast2500",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2500_spi1_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2500_spi2_segments[] =3D {=0A=
     { 0x38000000, 32 * MiB }, /* start address is readonly */=0A=
     { 0x3A000000, 96 * MiB }, /* end address is readonly */=0A=
@@ -1624,12 +1577,6 @@ static void aspeed_2500_spi2_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_spi2_info =3D {=0A=
-    .name =3D  "aspeed.spi2-ast2500",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2500_spi2_class_init,=0A=
-};=0A=
-=0A=
 /*=0A=
  * The Segment Registers of the AST2600 have a 1MB unit. The address=0A=
  * range of a flash SPI peripheral is encoded with offsets in the overall=
=0A=
@@ -1712,12 +1659,6 @@ static void aspeed_2600_fmc_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_fmc_info =3D {=0A=
-    .name =3D  "aspeed.fmc-ast2600",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2600_fmc_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2600_spi1_segments[] =3D {=0A=
     { 0x0, 128 * MiB }, /* start address is readonly */=0A=
     { 0x0, 0 }, /* disabled */=0A=
@@ -1752,12 +1693,6 @@ static void aspeed_2600_spi1_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_spi1_info =3D {=0A=
-    .name =3D  "aspeed.spi1-ast2600",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2600_spi1_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2600_spi2_segments[] =3D {=0A=
     { 0x0, 128 * MiB }, /* start address is readonly */=0A=
     { 0x0, 0 }, /* disabled */=0A=
@@ -1793,12 +1728,6 @@ static void aspeed_2600_spi2_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_spi2_info =3D {=0A=
-    .name =3D  "aspeed.spi2-ast2600",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2600_spi2_class_init,=0A=
-};=0A=
-=0A=
 /*=0A=
  * The FMC Segment Registers of the AST1030 have a 512KB unit.=0A=
  * Only bits [27:19] are used for decoding.=0A=
@@ -1877,12 +1806,6 @@ static void aspeed_1030_fmc_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_1030_fmc_info =3D {=0A=
-    .name =3D  "aspeed.fmc-ast1030",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_1030_fmc_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_1030_spi1_segments[] =3D {=0A=
     { 0x0, 128 * MiB }, /* start address is readonly */=0A=
     { 0x0, 0 }, /* disabled */=0A=
@@ -1916,11 +1839,6 @@ static void aspeed_1030_spi1_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_1030_spi1_info =3D {=0A=
-    .name =3D  "aspeed.spi1-ast1030",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_1030_spi1_class_init,=0A=
-};=0A=
 static const AspeedSegments aspeed_1030_spi2_segments[] =3D {=0A=
     { 0x0, 128 * MiB }, /* start address is readonly */=0A=
     { 0x0, 0 }, /* disabled */=0A=
@@ -1954,12 +1872,6 @@ static void aspeed_1030_spi2_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_1030_spi2_info =3D {=0A=
-    .name =3D  "aspeed.spi2-ast1030",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_1030_spi2_class_init,=0A=
-};=0A=
-=0A=
 /*=0A=
  * The FMC Segment Registers of the AST2700 have a 64KB unit.=0A=
  * Only bits [31:16] are used for decoding.=0A=
@@ -2061,12 +1973,6 @@ static void aspeed_2700_fmc_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_fmc_info =3D {=0A=
-    .name =3D  "aspeed.fmc-ast2700",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2700_fmc_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2700_spi0_segments[] =3D {=0A=
     { 0x0, 128 * MiB }, /* start address is readonly */=0A=
     { 128 * MiB, 128 * MiB }, /* start address is readonly */=0A=
@@ -2102,12 +2008,6 @@ static void aspeed_2700_spi0_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_spi0_info =3D {=0A=
-    .name =3D  "aspeed.spi0-ast2700",=0A=
-    .parent =3D TYPE_ASPEED_SMC,=0A=
-    .class_init =3D aspeed_2700_spi0_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2700_spi1_segments[] =3D {=0A=
     { 0x0, 128 * MiB }, /* start address is readonly */=0A=
     { 0x0, 0 }, /* disabled */=0A=
@@ -2142,12 +2042,6 @@ static void aspeed_2700_spi1_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_spi1_info =3D {=0A=
-        .name =3D  "aspeed.spi1-ast2700",=0A=
-        .parent =3D TYPE_ASPEED_SMC,=0A=
-        .class_init =3D aspeed_2700_spi1_class_init,=0A=
-};=0A=
-=0A=
 static const AspeedSegments aspeed_2700_spi2_segments[] =3D {=0A=
     { 0x0, 128 * MiB }, /* start address is readonly */=0A=
     { 0x0, 0 }, /* disabled */=0A=
@@ -2182,32 +2076,102 @@ static void aspeed_2700_spi2_class_init(ObjectClas=
s *klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_spi2_info =3D {=0A=
-        .name =3D  "aspeed.spi2-ast2700",=0A=
-        .parent =3D TYPE_ASPEED_SMC,=0A=
+static const TypeInfo aspeed_smc_types[] =3D {=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_SMC_FLASH,=0A=
+        .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size  =3D sizeof(AspeedSMCFlash),=0A=
+        .class_init     =3D aspeed_smc_flash_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_SMC,=0A=
+        .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init  =3D aspeed_smc_instance_init,=0A=
+        .instance_size  =3D sizeof(AspeedSMCState),=0A=
+        .class_size     =3D sizeof(AspeedSMCClass),=0A=
+        .class_init     =3D aspeed_smc_class_init,=0A=
+        .abstract       =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.fmc-ast1030",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_1030_fmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi1-ast1030",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_1030_spi1_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi2-ast1030",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_1030_spi2_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.smc-ast2400",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2400_smc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.fmc-ast2400",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2400_fmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi1-ast2400",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2400_spi1_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.fmc-ast2500",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2500_fmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi1-ast2500",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2500_spi1_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi2-ast2500",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2500_spi2_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.fmc-ast2600",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2600_fmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi1-ast2600",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2600_spi1_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi2-ast2600",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2600_spi2_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.fmc-ast2700",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2700_fmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi0-ast2700",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2700_spi0_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi1-ast2700",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_2700_spi1_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi2-ast2700",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
         .class_init =3D aspeed_2700_spi2_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_smc_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_smc_flash_info);=0A=
-    type_register_static(&aspeed_smc_info);=0A=
-    type_register_static(&aspeed_2400_smc_info);=0A=
-    type_register_static(&aspeed_2400_fmc_info);=0A=
-    type_register_static(&aspeed_2400_spi1_info);=0A=
-    type_register_static(&aspeed_2500_fmc_info);=0A=
-    type_register_static(&aspeed_2500_spi1_info);=0A=
-    type_register_static(&aspeed_2500_spi2_info);=0A=
-    type_register_static(&aspeed_2600_fmc_info);=0A=
-    type_register_static(&aspeed_2600_spi1_info);=0A=
-    type_register_static(&aspeed_2600_spi2_info);=0A=
-    type_register_static(&aspeed_1030_fmc_info);=0A=
-    type_register_static(&aspeed_1030_spi1_info);=0A=
-    type_register_static(&aspeed_1030_spi2_info);=0A=
-    type_register_static(&aspeed_2700_fmc_info);=0A=
-    type_register_static(&aspeed_2700_spi0_info);=0A=
-    type_register_static(&aspeed_2700_spi1_info);=0A=
-    type_register_static(&aspeed_2700_spi2_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_smc_register_types)=0A=
+DEFINE_TYPES(aspeed_smc_types)=0A=
-- =0A=
2.43.0=0A=

