Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661A8CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjX-0003Av-4e; Sun, 31 May 2026 22:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjU-0003A0-Ql; Sun, 31 May 2026 22:50:28 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjT-0002en-A5; Sun, 31 May 2026 22:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxK0YYOcJxKBhgxLv7S/kemPZWbIkCuOKgSeISFx8ldeXpVdFBT08hJ38e8+u0vnGScYPCCXj1re6mZpgNg13r0QJxRa0Egz+D9LxofdssLb0mFB4sLCY7dUc9E5mKVXJrq5spfba0/vlgZC7Piwn8TjOnop+cStapGMANz6zPTaAMRpFcHy30LtgKV6/BwYW815cl8tmpCcPrc6SLfaAlC6a1fAP7Xz6OzCdQK3z0/AyQYARklJ4oVl9W3jwBgHu6g3xXUqoeu5gXVggUuUx2azIWatT/++mkg7s7XeRN32dqxniPo1lC8H1Ry7W5PvjvPcqth7MbbeE5cJGlGruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKTWrPBGkjUNIhNIqUO8TAm/iutufJvCwfIifvHUPHI=;
 b=b2yaih4rFJHrwEcrRs2n94r0KRctd0TzQfBBwhOKDNeYYBdOtzt3pobYsNJ6mKbXubi2+HlLdo5Du+u2mzwdUQPopKQ/M81095pY0cj/szp0z9vgskMpRx9Himst94NJqYbTQr6Zi82hCRJQ4pndFqUBkw/uOFXCP1lSLolKd/UZDp44rUV0MMlDeDonOWjPpq5IbFmD3B/k6usjzJpDCEOsZZZAGruB2YodQBTNSk1zqYMd2j886ey999uE7UvgiNK8VXQg1P3fN8lz6XprhPHeARen/2JbneQxGh3YAXjrM55XIjI1GVmbA2zvRuiDXBksY/yphqTAIlI/rZarYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKTWrPBGkjUNIhNIqUO8TAm/iutufJvCwfIifvHUPHI=;
 b=PblSYVM5EdCG+ucjxxs4YAhkL74Ytzo5K1H1AUHofVc/cVxqm0IbeTCdS5wumdCwEkMRmrrMtINDox16y57lt/XnbMkpEKKufyuA7c5drQkdg5O6kZMMXgKrmqm8J9dx4PPEXB0ePWRVKAEgQBZzGPdhCvdpI7oqoiQX8Lt9VaalriiBbiPf7WpfziC/fHLMcWJSLi0gZeaA7XQSJxjwVBPrN1NrU1dgtbcYW3tZlq2Zw6vArMQXTWFnMWfg1TQCs74FPqQVS8VFt1egkw1kmXzZInXNfxd3GI6maWn0Kl3TwY4pFRXtgMKAwuXNmQPg8PnhrssHLfd7ofCIFsHFKQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:13 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 08/24] hw/misc:aspeed_sli: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 08/24] hw/misc:aspeed_sli: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFezRqh6jhbfkWd2uaW3EwdTw==
Date: Mon, 1 Jun 2026 02:50:13 +0000
Message-ID: <20260601024959.2347639-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 5024deb2-cb4a-4699-b2de-08debf8880fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: Z0VfuAXL6Ulsnh+0epsiWHBFdUvxZwl7xS7efFLlZumFdLVMLm85MeTy0GYV2IyFgQZDrpGkxs4iWunJiBMovwNVdJISuAWXWvplFxoU9wFiI27nWnCM9OUVTkpH/N/O2tRaMrC93dO3nAfadKtQPu86sZP2fos8XMZ6gU/7MJqJyK/AaLuroC1I9D3CsyrLZibCZFl+qvzH7KB1hKS5eRbm8ht5Xs2rAj/DSgP8HwWKw2CsHtclxzzrH62NoRInXqpJZ0bUq5fNhN+IqeMAyMLR2LM5RemnfZ9e4hneITdLcGc2H4ABX+FarjIEqF18duC6B/wmwKxk+jolyEzFUavyw39uTA2r/gq2I+lRDtp+rzpW186BDs1ylJmCW/TkD2QjzhKz4XgB6n61sumgSeBH7892uasrG8UXHIpQIE9hU3H/pnvuUTp/JVXjwXK0OHrDsk5tJfr1I2ICr0Tb19TRM8spwP+SyHXiH0uZsBKqylACxizHJ93F6ATXzyr3vDpurRtM5qm9NIg6CVIpViNEY1ooAeQr24MmdFyP5BtFjMDgkmSS5y14lgbRp1icGoioPd04aenlLUjgixtkXJo+W473QuC1yU5XnH4zXGg61x5Rz53KK6Zts6909lUW2dnnsU5s8k1y8oL3LDhipit8lixRC8NBhStxuHf1PHjpd7C/MyOWkpeqO79tHlSf9ksIeDafykKF5ZTgyY/5F/0et6vX/Rb9HjIjnt/3rYM6xcW2rk81jf7f4TXMImbRcLPQCiYqBo1M4DRj+q00ZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nfpiAHyLoQw0QkKUxgHwqkazzAO1vJ1njTq9DlpDATpawY7sHC5IuGxp3Z?=
 =?iso-8859-1?Q?jjmHnQ2BM5kx9mnORmOsEotoe9y3ndd4rKYDb0jsEUQ9r0rYIVpRO2zz0L?=
 =?iso-8859-1?Q?uCE768btJADqOd7uPtCMCUj5Xd3lTmrIPyyG8TOrBOy8FF4C060N37+cCM?=
 =?iso-8859-1?Q?ccKScupCihF2hQsm7kyNXxYLha15dNx+Ct85HnfHztYkuZfbCxmD/lVm+2?=
 =?iso-8859-1?Q?BlCFbKl6n4V27VLZ/Q+LB3PShtaJqI8RAPuDKnGWUh4AJILdAOnC0v9q3z?=
 =?iso-8859-1?Q?s7J/BTkrE0t0nxkgdcFcxhlzIvqbwci9JJ4BSsLyEE9sDts0qCP+dzvoIV?=
 =?iso-8859-1?Q?shqFC2SYbiGRwEGi5tANhL2sMZP2TXP/1J0hjxXwARVYc0pBuU9W3FKQkl?=
 =?iso-8859-1?Q?w7x+z5CRX9f99df4abS0EZl5LaakmffBo+gKbeDDEzZzCpul6WuaIzlORv?=
 =?iso-8859-1?Q?vZzVXwDbUOFcywu0/5Vwhz8cGXmrKZGUAPGShNF8vBWFgEPhVdLDutubt+?=
 =?iso-8859-1?Q?2q2q7j2eAI9GliVUVClOI3ydWkzexXxvVrKLggZKf1Aj8AAzUWax1HgkST?=
 =?iso-8859-1?Q?rP7dvdCOpLfXNAWVuksaDLTKVYRbOi2nMWwaa0U23VRInxvunJwPlZ7g16?=
 =?iso-8859-1?Q?z5X5TReCml6nYA3jDbWvnXos3NRbprtuiOnUv62D1+BIOAEbLstYWrMZXt?=
 =?iso-8859-1?Q?panZTneeYM9Nbj4Lq6EFJc6tkSp3Wd/fSflhmuOdZrLCTizBejTU+5I2/i?=
 =?iso-8859-1?Q?iKNrR/W7xQg0nEX+aV2JNPiF9g1Ch0bhoQ3/eOEjWg972LEvnKqS71QyXz?=
 =?iso-8859-1?Q?fAj+kw8FCoKiYW1TEwk8vHYH/ax0NELVFxtJ16k4o87JHBcIvNpBqTBH1W?=
 =?iso-8859-1?Q?DrI7A5hEnS2JgQwxjD18Xqmveo+CWtrrIMq4okAoaMP9CJruq2VoJfs1Xo?=
 =?iso-8859-1?Q?KT2xhOMF+ekrtau2H1lyF+fE5yNUFjTKXiIgEvkYtwunhuWEaitYi0Ja0F?=
 =?iso-8859-1?Q?vpASRl2MyA/MkRwWkeEp4+LUiGX/rQOPm9OJX9Ovrq/dCuLYLtWanJPfpc?=
 =?iso-8859-1?Q?cUkM8+nU4cBStFup/J6flvmiFNy58o1JEiW+zgKHZo8HstLVWHcfEOG9Xx?=
 =?iso-8859-1?Q?+e/18ZYUVYiJ/DSYJWMg+0be1nI3o7t8Vkd2qp4pEs5/7+CF1yOWIf1mtn?=
 =?iso-8859-1?Q?7SjhBr+RZCYCp7ERvhtyW3XhpN7tJiNaz0BdNiS1iqvNaEfRSP86ajd15J?=
 =?iso-8859-1?Q?BRJ8RNrHcrHChdOD9rjYyxgFhDYqWbeL60Lyy4jcmxB9C0EaAZW0sm7OO/?=
 =?iso-8859-1?Q?4D/fTUFONny/jCSVTkfEfq5so1r/1zsRwFVnOSjx6cCcKMV/zcV4y3zrEW?=
 =?iso-8859-1?Q?140b+rji405BY5HrkyBVE/4h6UFdqqD3LXlJgOLDGmcUyTdK2Mu/uMSkOG?=
 =?iso-8859-1?Q?5v/dc1UY+giUCc622STqYSk0JIghraV6w5Tyg1ofUu0m2ML9L5ZW4Vlqce?=
 =?iso-8859-1?Q?0BvCnXPpNikK7sBnm8Xg4BBV3iQt165A2qA2bMzI2ZVT1gSYhEwUumuGAq?=
 =?iso-8859-1?Q?toUSTIEgUC90e8lyn4YdXN8yv/9pF6XLduLNIGbyrQ8P/A0Zk/R0Cz2BP/?=
 =?iso-8859-1?Q?xLOTCXpa9JMflP6wkC0bmLndXvvd0sJoPp30MvZu4r1eZcZnNfI920HxgF?=
 =?iso-8859-1?Q?RCj3xBs/5bM+z4I0EkVZlx9Lze1AoBLJ7sqhYf+qPW6r6jbOP4kNy4LjPi?=
 =?iso-8859-1?Q?GXUiMnLyrknqQNQXAnZqB5KSmSR/jQmzjPGMT0faAyOxi3vBnd+ktOJ3Fn?=
 =?iso-8859-1?Q?pg0lqNFDLg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DgEX85VzaPOLZxykz6B1DiTTxkOd3BzmgxlZ8yVZ7zeUiF0Qp/bQpKAw6SKfh5AzrJAKkqn+qCcyYznR0vmnNuBZEJAb4A59NH6KcPAm7FiFkcoWllJzsAQFuhSqO66olapJru17RswZLOcHU7skEAg9e/xYyS0n99Di9fL3MkCo3ogpGt9vJw6q6s/mDcO1STgOriKhivfceDzO42e1wryyHGnGATE4ZUcxGCGOfAns6Ouq2LClN0muRar7LB4032CuuirLYgXnRkI1pN7Ei1BQ1+jeX7xlaPb2YB/ETANrxw4CIMMqGtmYYW+NWiNhNYT0o9gqkuGu/SjNHmuvtw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5024deb2-cb4a-4699-b2de-08debf8880fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:13.3263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPo31LAkNN25kh6IyVIUhhmnJ0V+H8hNq3aI2p+FcsyT7wvubDOJzNsjLS94SlPZ11netmiYHUep6bx4XOEZd4E5Ohd45b1DWWmwuMYcGck=
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
Inline 3 standalone TypeInfo variables (aspeed_sli_info as abstract=0A=
base, aspeed_2700_sli_info, aspeed_2700_sliio_info) directly into the=0A=
'aspeed_sli_types[]' array, removing the need for separate=0A=
declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_sli.c | 44 +++++++++++++++++++-------------------------=0A=
 1 file changed, 19 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_sli.c b/hw/misc/aspeed_sli.c=0A=
index 5b4d70cdc0..74ad02faf5 100644=0A=
--- a/hw/misc/aspeed_sli.c=0A=
+++ b/hw/misc/aspeed_sli.c=0A=
@@ -132,13 +132,6 @@ static void aspeed_sli_class_init(ObjectClass *klass, =
const void *data)=0A=
     dc->realize =3D aspeed_sli_realize;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_sli_info =3D {=0A=
-    .name          =3D TYPE_ASPEED_SLI,=0A=
-    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedSLIState),=0A=
-    .class_init    =3D aspeed_sli_class_init,=0A=
-    .abstract      =3D true,=0A=
-};=0A=
 =0A=
 static void aspeed_2700_sli_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
@@ -155,23 +148,24 @@ static void aspeed_2700_sliio_class_init(ObjectClass =
*klass, const void *data)=0A=
     dc->realize =3D aspeed_sliio_realize;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_sli_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_2700_SLI,=0A=
-    .parent         =3D TYPE_ASPEED_SLI,=0A=
-    .class_init     =3D aspeed_2700_sli_class_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_2700_sliio_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_2700_SLIIO,=0A=
-    .parent         =3D TYPE_ASPEED_SLI,=0A=
-    .class_init     =3D aspeed_2700_sliio_class_init,=0A=
+static const TypeInfo aspeed_sli_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_SLI,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedSLIState),=0A=
+        .class_init    =3D aspeed_sli_class_init,=0A=
+        .abstract      =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_2700_SLI,=0A=
+        .parent         =3D TYPE_ASPEED_SLI,=0A=
+        .class_init     =3D aspeed_2700_sli_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_2700_SLIIO,=0A=
+        .parent         =3D TYPE_ASPEED_SLI,=0A=
+        .class_init     =3D aspeed_2700_sliio_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_sli_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_sli_info);=0A=
-    type_register_static(&aspeed_2700_sli_info);=0A=
-    type_register_static(&aspeed_2700_sliio_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_sli_register_types);=0A=
+DEFINE_TYPES(aspeed_sli_types)=0A=
-- =0A=
2.43.0=0A=

