Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C34BC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOX-0007g5-8i; Tue, 22 Sep 2026 05:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOV-0007e2-CD; Tue, 22 Sep 2026 05:02:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOT-0002C2-Qt; Tue, 22 Sep 2026 05:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTNlZWDVyrEJ2//IkiRz72SEXJ05amV+MR0bciO3A0j8oh02jGXH5q4nJxTE5cy/dgNJJCyEdcfa6MiOeP0PuMlrELlKNkn35Y0PBB8x3pvh0Y7GvofQmGNQ9xVxB/K3jhbkbWFQAGDtv5rxkyP6FzsWepQtjjhFBZW/c0fzAu4ZROieSQrZwLHZvtbS+YoyHBvzJwqqI/w7X3JA94gZJL1nt1I/EQxn57JJvoHIT8YpyArCJfVxwomSFGfVDSjyzy1X4bETGJ7WT/z5vpFdPS8mr68oimYHJ8v02zvsMFrZcywbniFNTTNu1+Q9X357jR6JLgk7CNPiI26Hnmprqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j2uqHv+0pvxw/qI5BkdPDALT0W4EgDoWe/QBtg2wRY=;
 b=rpq0X3TO+XaFCWRDVFtzvbKHjOTwDGpM/6GMqQYuico74McSh8gOxAvG5Nh33Zy6Muyw7o8Xv/jMyePtVDqTbnySFmfgK28cd/IkL05IQlnET2nr2j4phVe7kwSjkiOgOgFRhbkrdLvZfncCkolQ7sHwuVNxlKQU7rYTSnY6MTKx6cKDCC9xIq6k+t4JQfbtYiBcXJ0zaHPTCLmvQaU5vHSokKmz5/87nvPRbE+OJnEcueR2iLtaCuYBQf/X1Wu6ZdTNaqfNE/sAKOjcFXl4au12e8kwRFdWL7Pf/HbOYDFV8OgGqhcPVFjktO9qosTXHU4A5ssMKDRK/5YmfGbKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j2uqHv+0pvxw/qI5BkdPDALT0W4EgDoWe/QBtg2wRY=;
 b=LCUQ60N8T5maUI/sOzoHI4BIlKZVIQdbEOaLoMdn/Pc70uvlpGxfdE4J6NgC3Ljaako/hazrVn16qo32zoe5wECYKqEeLy2aet9Jcl8pb+wdBb1/UNElLjLb+nD7eSxMPxZgLKQM61bEmBGkx18H2TZm0BDxmsYG5kcOq5JBdFSbbHW7VjftqjwzPybHp19nIbmWAxqbEK5/fZjexENGmrOTsuzHkFDdSjfZ6mC6nhJaqbs/MBlQR++UXd2kUPDyB5UmUPNuFKGGMtbj6xqqeYDGB9SMqX1PzsFXo3vtdT5NMKfwfM/Ej+RGaagql72JazFZNvKhnCSl70zRTYq7RA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:18 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 18/19] hw/arm/aspeed_ast10x0: Add the USB device controller
Thread-Topic: [PATCH v1 18/19] hw/arm/aspeed_ast10x0: Add the USB device
 controller
Thread-Index: AQHdSnERA5EbF8Yt70ibCElO4KkcPw==
Date: Tue, 22 Sep 2026 09:02:17 +0000
Message-ID: <20260922090154.1792077-19-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFFE5B965AC:EE_
x-ms-office365-filtering-correlation-id: 16e02dfa-5e32-4178-b995-08df18883427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: F0BrQ46AyYDSoiirIyJW8HteRfpgXs8/U9jVtnk8TvcjB1zlebq9AXYbTnDNxzn0Uwv+RZ1EMYPihmt8WTJVTmVeveXb7pbSI6pLN3Fg312zpThv2wVXR8B3echqB0r58neEiL3eizu1EoH6Q1zA8r/ANNQp9yaIZlizFGCsZK3umUb5GDnqot/KXayQf9EvJsN2niqb7n64JIYrKA68yvgWeoNrxj4pe5uy5DWCvCiMv8JVjSBFUmUvkUwcGj/UxZ3o3JtYch1L8Thx8/tXsOEo6cjrgpuRxTLIS/osmhFg3Zi1hMjQCSUhyDVwN3HvhUwLq27292qCC1Br2ZkyYfuLbOZBMvP4iib62gMUaG7m2MeszW4BpKzrtLtTD617y0DUrQCcgymUnvQwkQcvR/0dT+NxXbEOjMNWnnDn3TQeIdcvsOg2BjMvToYGvRV0Qq6Z/StM04X4Cr+50JbHwzhbk9OOCLos9uTH+LqH7wmKZq6a26JYfyTJ7L6CpmOpDhBRXh0Jk+7q6zFTjVG0i3jQzs2y1vLGleZ7aSWogwdMZjV7XIOTBx/NONN5GseJwEJAsaUB+jCYiHZs1PmQn4l9/TZfej2smOu+tFjQpP+G88eDKB1E070Gm7amE+gd81ryO8XnFSY/7WSz4Blc9mSo2iHYl6bUPM+GeJZa8i5h4/HlqkoxSSFX1aFfJqLupYIlhETqTvd+cpqdEZr6ipVmnAL41lIOjd/jZJCWPMQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+5YDz9mdfP9XQ0RPZWZww88z8l2/4xzP2douFhyvAN1eURTbGppBqExl9v?=
 =?iso-8859-1?Q?5KhrBLqYTtu2XyTjEk0XuKBMnsYpNdHEv7W6+YGKngcAXT6rQkvqE6Mj4P?=
 =?iso-8859-1?Q?+BVS6q1DsweFCBfL0VH6RKOYRMAmnXf3hCz97caw8qEsiasgdNfphebShJ?=
 =?iso-8859-1?Q?+Q4OGtGzGaTses7y1lTB6fNgZh2TiBegTQxbCeW5Mqi7YXArMeNCFvxdV8?=
 =?iso-8859-1?Q?mxZ+Aw/kvwIvwTXNPdrJWo09BUZcNeWgFZ7iY0qh6hyBb7FRyoouZJN9LT?=
 =?iso-8859-1?Q?7ZqcG6a1nAGwNXEjGUTaUC7ETq5ypzcK+do3ZZiN6nciUQtDOBGXN9qxu0?=
 =?iso-8859-1?Q?5Qt+tHx05JRktxmLhffaEtgs4e8PqSu+RZUnj3TdKO2vazYXHCBDFXEU9h?=
 =?iso-8859-1?Q?meJG2HY35WUt2r0E2NXahcxcmRUgcWYQSX9tCE0Vpw9daGVRK81GsenB0v?=
 =?iso-8859-1?Q?pb1LlWMP4E+0+kSb3yeS1UZROKaMtInLohpG5eeOYSwngoKRItkQW3Cz8C?=
 =?iso-8859-1?Q?oMlD/+AMEdVkphfHrGGHTyhisqfbalmcCivxWN7xRSgcIpDte2CJGUrnrM?=
 =?iso-8859-1?Q?UrbaZ/FCK+2FAiWKrD+UyS3HTP6zjIC4Qxqcq5idf2AHwi/emZ8SOBoYOk?=
 =?iso-8859-1?Q?vxpcp30qSRD/BOEfiQcFIhIHcvB15UyUK5ObisxNW0FFa56aXBAeySvMNP?=
 =?iso-8859-1?Q?5HO2RsMNqTCdegGqcBtekRzCrsohqIa7sndNZ2NL/DrHpWUEQpQqkoYbee?=
 =?iso-8859-1?Q?z/T/Sd/ysgjAe+34aA8xi5KYdFSDzFyCwqnHApAcxD9eykaPitzLfsnaEc?=
 =?iso-8859-1?Q?eEmUM8cnCU0jTpKAiwGVNufgFOB4En1N9ekt/MRA8FoXePLPF/uLzw44JE?=
 =?iso-8859-1?Q?TgbVvHFo0csRArZ3PRfkA8uDgem350/ZVqj2v1oFfQ9i/GUi2Xrs0xN9km?=
 =?iso-8859-1?Q?gYjL05GfhuiIpNlt4yt9YrLvaeiAM6If2nFZ7GF/PJlJsVdlbCphxUyvwP?=
 =?iso-8859-1?Q?T2q70gsNImclgFGu45F8KJJ8W9zeQEQBSWQLgjYUwUDWjwZskLpE8RJDy3?=
 =?iso-8859-1?Q?xbwmiosWX1MEC2ZQg/V3jXH+6snUxFbyMJcS3jF7Nb+JAPzlSkoE0rGH50?=
 =?iso-8859-1?Q?rV7cQAHpvhB1PqaBCEtVGkbMtQoNTXXJU3Jvjz0rZHdnugVr/a8qRkJ6QJ?=
 =?iso-8859-1?Q?qjMUZ5I39W5+9Ys99jvjwCvSQOlpdNsOPIE3JACUp4zSM3r5IYWKrwsLdX?=
 =?iso-8859-1?Q?cbzBrpb9hWXieskRwxrVddmJ9iAQGyixfFr5fieZ6JZApUpKeHiPU8MFLq?=
 =?iso-8859-1?Q?nx1AMCs5dwxWqr9opDQIJ6LBMD8vdgxCcVhxdulx5i8Fc0GZjHTND0YEDf?=
 =?iso-8859-1?Q?6J5Trf+ASoOX6bxEENv2AQ0ZI2oXh34SgW0fUR348fGyOES7U1Hqwieg1E?=
 =?iso-8859-1?Q?TpSMhQjlWFwcewefs7TKvpLcZs4luIz/KnC33pks8GBNCKzLzsFu7YuG8J?=
 =?iso-8859-1?Q?YScuk5M/9NLtvzSf76qci60PULjwbmow5/65IuCzoU3xHvpsgS5tC75G4t?=
 =?iso-8859-1?Q?S02AEUuLqhtUNXcq2N0lQtezlNnZ/cd/v7pUJTa/qJh8hlLt6ZnQ704lAp?=
 =?iso-8859-1?Q?UhyuxOHld78eDX2+9aqSKQLhAI2kYDyAi5M2g6mAikxyO88UFTLooziyX8?=
 =?iso-8859-1?Q?ZXFo0AvI+By5mv46dcMkMBB04+C5PFjXujhFAhDUJobxBy5VNt4GMTBgJU?=
 =?iso-8859-1?Q?4ZcqQOmWa9AeSiGB43nPWiVYywxPqVRc4rSAhi1PKS+OxRCMUpZOMnAo0x?=
 =?iso-8859-1?Q?tKYbg1zV3Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NPBQaveDaSVBuz7/sgS2l2oemgISaj6iB8ba8Mvw5iPW7dGX3XhiY9r/9WK5P8zITICpgQJ33ZIR1zPaQje9A6HZrRF3WZQVD+tsgFveGFu0N+/jDJfjJwD6mQ3/gvWp7HvgOEJfAIjIMEkqI+B+fNomoBngxFzuCdOCFsPy7f3ZWtGHEAYVUgyTmkmo1c8PBydRf56q002WT9ocn6iMp1v/umaClSwbvxh+Edwlv9uT/+yYGH41klWIYl5qOHK4HkyTqcX7L3kIsH67+JHux2TJ8T1XPA53EGexxv2IeJNfUURF4Fd/rmekw9gV1zvBPflxW1tNyNBhjGWds17u2g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e02dfa-5e32-4178-b995-08df18883427
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:17.9263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExodV7i02Yhooan9rotjbO7skVc3ZTM1y2hUIwbGhNSpiAlj087903uXnJW+P61VrSdr5yB1BidtbzGKvAuIxWdIUHdGMyAsttAknpB7GVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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

Add the USB UDC device at 0x7E6A2000 with IRQ 9. The AST10x0 UDC=0A=
controller is compatible with the AST2600 one, so reuse TYPE_ASPEED_UDC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  1 +=0A=
 hw/arm/aspeed_ast10x0.c     | 17 +++++++++++++----=0A=
 2 files changed, 14 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 38226d9b80..4459188c57 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -167,6 +167,7 @@ struct Aspeed10x0SoCState {=0A=
     AspeedSoCState parent;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
+    AspeedUDCState udc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index aeb5a4423d..81f2d78a45 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -162,10 +162,11 @@ static void aspeed_soc_ast10x0_init(Object *obj, cons=
t char *socname)=0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
+=0A=
     object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
-    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "sgpiom", &s->sgpiom,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
@@ -394,6 +395,17 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                        aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_GPIO));=0A=
 =0A=
+    /* UDC - USB 2.0 Device Controller */=0A=
+    object_property_set_link(OBJECT(&a->udc), "dram",=0A=
+                             OBJECT(&s->sram[0]), &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {=0A=
+        return false;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_UDC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_UDC));=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
                                   sc->memmap[ASPEED_DEV_PWM], 0x100);=0A=
@@ -402,9 +414,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSta=
te *a, Error **errp)=0A=
                                   "aspeed.espi",=0A=
                                   sc->memmap[ASPEED_DEV_ESPI], 0x800);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
-                                  "aspeed.udc",=0A=
-                                  sc->memmap[ASPEED_DEV_UDC], 0x1000);=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),=
=0A=
                                   "aspeed.sgpiom",=0A=
                                   sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);=
=0A=
-- =0A=
2.53.0=0A=

