Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3758ACD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw3-0008Hc-Cs; Fri, 29 May 2026 02:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvr-0008F7-3S; Fri, 29 May 2026 02:42:59 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvo-0002Ht-1O; Fri, 29 May 2026 02:42:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtvbmwGC/uNMOedW5ZBF/byLWXQDKQ3vVy7iYyrWXrJv/5993tpc28SzGCxCCae1vE9/lyWMzzkB5fvnFgIaQg/r9k56p7RwZJccFCnxBlTK77AHNOvaoIx8Fwj+DApq7dH5L05ObhoXzsO/bOBMmUrJWtiglJ6HySVqriypAHcMqb6xkp/fvJW24S2S+6SKjSHL3aXiht3p/waytDoT3PAQLw+C8ani/hEalZdQRgprwdylW8MS41zFV6mejRKylQGf05L+T8SMpkZVS8sOGWa4W/1+Qz23My7+SJomyTjk8iAujoYP3VbHiEH5GHjb+roDuvGR9DmABNK5/TWAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7zerwl1sCzsoDlPZoO1zUz9arn1leTySEo4UF0E3nA=;
 b=rNqBC2vlWOA8VU/y/5PsxiB++qv9fsyxM0rHw/sPW2vo97hX9PxPfutlgb1Czhxl10w4XU/rTpl6YnITrxrMDEo85XtSK1fTMJedBBLNOVmcQacdxDi5zFsKD9MA8jxROtICf7Pgb2PHnq/6QJpZX4kDu0NOWMLme/rjnDQ7JhaQJ3zhYwZDcsfjJrsMA2nYynPYlYwNhnfFUoWOsMOMpFgaskYkuJfjmVLfgNws9okHLqUZ5ZdGAhOrAZlVARy+3/KH6YfxZZcy8C3QYWvUi5VR0QeDSZigN6NFEVY8HRs+NysuM3kCJ+xqO9o/izSV/KaY7AHxjLEffNnQIvkc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7zerwl1sCzsoDlPZoO1zUz9arn1leTySEo4UF0E3nA=;
 b=Yjyi+wZjEpUApKWP57N8kLdr2go+h6PI008joELx2A9dX5M2kYmOUQ9K5in/jDaY8r3l8qUBer/cwxrT6W5eUZDhC8jxHxVISStpW/C5jhcDkuCG2aJHZh3BlUlDu3bub4kec2iX0HkixucOPBn95VGv3EAYuQAZY/AgGobSQuh5PiIkxqTtES3PxPdah4JxJu9kSr1L7XrCBcpdTihWxh9Pi3DKBNB2AFnLo2JyRlMw56Rjlf/xj41nJOCsNYyvY7S85drL1E0H7cFPg2BepFOy0p31NA74WP4EiA/Rl+jqQe+nbZ0J5pUl8IpHE33jFhNTf4EWPDPPsvfW2o7zqg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYNPR06MB8451.apcprd06.prod.outlook.com (2603:1096:405:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:42:50 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 05/10] hw/arm/aspeed_ast1040: Reuse AST2700 GPIO controller
 model
Thread-Topic: [PATCH v1 05/10] hw/arm/aspeed_ast1040: Reuse AST2700 GPIO
 controller model
Thread-Index: AQHc7zZefAbrieANV0yjcB3GAp9TFQ==
Date: Fri, 29 May 2026 06:42:49 +0000
Message-ID: <20260529064243.2064188-6-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYNPR06MB8451:EE_
x-ms-office365-filtering-correlation-id: 2de8fed8-8f71-4fe5-796b-08debd4d8090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: +dq+yKKIhxOP7gqXtxfbGOE5SJ6SRChCC6JSWxzc5PAQy3JsVXoH55MJd1NynWax7XAzD8CO9iUUL+2uxyfa8oQOXYrj4RpuJC78IZEcK0WLHcOSYImV7dlqx1i86+qfYKavfvd8b+o1gw5N4S48BfrMMekliRsBeGBGHRoTlRLQXdcgohmhIM9p5Lv892tK1cYfItffH2lodQfLh/Xq1VL8rNYea4y+65mzLwnfV3sB02U2jjfhzuEg9N468BteyrqqO81yG/vHX7G4lwaGqUeramCLVTAx3XvOnMRTeFAeCf53imE6xBDgAjQX88K/E6Wodvg6bzDAnr9X2STxXl/Cqnd1qB0Q9JaKb/3dTghAzQOzFivxOIRjqJUpo7oSQnD7ifrsTW+qxC42+nMeOi5M4LCG5wCD0ZYipRHvTMWZAE+2zHDG6meOIKWeXCZaCSHDrUO4gph3t41chD51LT6hivN6v5pT+N6UZS23UIuHkkwJPpcGQIvUGpDjJmCVRQ1ypO+cN+ulRupxnukuUJVnOcm8hxeQzjdMjr++A9m5sDzZqcd/lcPW8+sx9m1yAlJmRpEJ+RHibAe0kRxkJohKoLgTvlYRNZ/SevtM6Nme8vvgypNFMTvv63EL+wu5gvkQIdeJZysjktsVjQ3C9GE9bw/Vc6fCY3Sorx4e6CXHQ3C8dF9K3Ge4Jt24Tvu4bMHFqMdgSRhF0hIZN8x0SBHjcSShv9O3SrfqKHfx+z1twEbbOwKwVfJS3+mqhLjm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S79Wr5CBdeIg8A/Ic0JuE4YX3HEmS91zVSAHpY6Z3WtYEuTvSDcXPXzI6M?=
 =?iso-8859-1?Q?21iZRSaujOQRx7WCXQm2Wf9rrwvIFYyQy0U02hA1DK+h6jiPIoK11QD3qH?=
 =?iso-8859-1?Q?F90I7TU5ByxjsIjy/qRMnvLzMeZ9JyaQ4VcVSR/ATL3tOzNUcekHz7MM5n?=
 =?iso-8859-1?Q?Ia7d88RQNnQo4d5AKUEVNeI4RyrC74gLa2I7IlQkFQVLrpcGZP8QxaJZxo?=
 =?iso-8859-1?Q?vK6uX1ICxu4WqBEuvTrVkFPB1+nKvilLCnns8mA7hDJXTi2kycqig8ee5k?=
 =?iso-8859-1?Q?iurT/GfWdNNHx7R0L0bwD+n3PDiGj9olNNLiCn0ISzy6o5Q7YuuEQur1hm?=
 =?iso-8859-1?Q?iAidvn3Jptd31cbXzbem81fGSNqK3Z2aOd61xpBMsAM/GIiFSkx05jux3v?=
 =?iso-8859-1?Q?40Jugs/SIjRAKsN247QPWCTZk6b0RK1oZbxlC7LS4G4A/sHPEnwlet0qQe?=
 =?iso-8859-1?Q?ABg4JQzrp6qJ2+F7QFweuJSmw0CMDjzXwxm2f8rHuZ2NzVv2LHZD4CXl6D?=
 =?iso-8859-1?Q?z/LVFtHvWuJo7elsOvF5KAp6/7MyO4v9AxuEHNOT8T8Y9yfNJUI16k++v1?=
 =?iso-8859-1?Q?QMLVkaRRV7rnbA5AKQRocS4x0CYuSI0p5d4dcxjPkleJ4SFBj+yQ+OC63m?=
 =?iso-8859-1?Q?3RfjBO13KtNOa13Zpj2iPDVH8T84PGe1Gp0rYGsFftNqdZ/NLRuqMFhfYD?=
 =?iso-8859-1?Q?KCKkgSsbRT2DMFeIrjGlQZM/A0VzCFtrkrxc2Q3Iu6cijmgn+0u6u7qUbo?=
 =?iso-8859-1?Q?9we8gNCruqZFCnP2w1xXjjVqtkOsKsAfdBGX0FYaHl0XWG0ILB4mToSWMO?=
 =?iso-8859-1?Q?OvmkP2+j4JunRIh8ZgBgojpDHI9r4m5i7GelRZ7xUc290fD5Z4lkisd2z7?=
 =?iso-8859-1?Q?823d0v8xoW4vpZkqmXapGoMzql9ADWtcHgAIcCAaDcw1I3FV2JD7ktUnAo?=
 =?iso-8859-1?Q?ABGdgRs6dvcRhQIqC7W3G3NdYqiLXrplOmmwZQLZu7syEkHWyIPKhpFQY+?=
 =?iso-8859-1?Q?g+kE77UsU5T2d0VrDmdDdQclAzJ/YroqV0uR9whA4TqymnydcmB/a6AwMh?=
 =?iso-8859-1?Q?g/yQ4102YUF911nAPisJ35uNZtdYJf5ODm9H3wV0zPRUPcv/6U1We0w0fQ?=
 =?iso-8859-1?Q?aUPCpQMyd4C3lRAhghtBTgDsB5wsZT2atz4krqaYbV6UyrQMniwnaj4kg1?=
 =?iso-8859-1?Q?wy+pckmzV8oewT1oGL/fky5RXj4MHOr+MF4ZmO22XVjJ+lDNRxI1ZrXP2P?=
 =?iso-8859-1?Q?YcAEFTws8SFRAfUGsKC0t6eQea2ysDBep91dNCCL80TlTcgznAGrLaXzni?=
 =?iso-8859-1?Q?pfj2JmXWvYIbVLKru6uRW4gFNNbIREzNv70jdKDLjhrQ2dmOmQAzkg5lct?=
 =?iso-8859-1?Q?UtdorAhbRAThUd0iAttXVJ1tMmTzydJrEQON5SPHtLOAJeSoTMhQUBr8lN?=
 =?iso-8859-1?Q?GIDEn5k4wxQwdqK7eBCF2XTWN6Wug7q0DxWdqoOkEOZOhvRRkloqffW8xS?=
 =?iso-8859-1?Q?i9nMl9lgC7WhLXQbqelqHgkMQC4wuavpsUJgmu7DswHmuqWm2jXEL165ri?=
 =?iso-8859-1?Q?mFQ/M6G3rPanDPrLSg7g/PPEoeiII1fzLooFxBo3A4aRulP12squE7jt1X?=
 =?iso-8859-1?Q?iBEVAgaBKbhMCy4ymocmWxA7zF9qCy2YxYyuoFiej+UsOj/c9Un5hvGTjZ?=
 =?iso-8859-1?Q?48a1wQT1FBRXWL4mR3MondXkTKLgeLqimmJRr0ToCQ288H0yJUovV+VwBz?=
 =?iso-8859-1?Q?1tMIvtc2U/WaKMcWdrhBdc/BveQqib1GIjf8Li0u2b7HrIkTi7y3wTaVH3?=
 =?iso-8859-1?Q?R1RShQOgYA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I73+kLXTWlts2P2NvBAZAunxkQb4gvcRM9JejHcHk1WRrNJgcRsSEF5FkFUgsGRjMdc7Hnckl+AMBvu8s48BccrZtAmhVwCnLzD3rIzextXrmsA5gy9MArmeIYTliaj9jITZO2iZm/R2UU3/8sKALEamu7MzMQxrs14nYSftHhPxVvPdkDeNGTP+oWfG349D4R1vQfAsFBvjKVggJJhV7jkA9LYE0WQdxP6aQVEZ8JGcCNdZ1+0+Qc4Bi2zkGWNK36usn3fNHGTa7XCNEwZViKZBJc/Tl8ugI/VkPs+McOG0BgDAiQ9BQuNuwaZqGUvwhLQMCsL5k/Y6FEtx8Qwrug==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de8fed8-8f71-4fe5-796b-08debd4d8090
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:49.9991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljHf4aqqh/bWX1l255TvbXov1K0Bmj5zhTU4diGUSAJ03JeOviNmXa3wRKX0SsSq/hgxATOut2KKX1hGQPE/9ZYG5wXERDgfQA0f4Ihz5zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8451
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

The AST1040 GPIO controller is compatible with the AST2700 GPIO=0A=
controller implementation.=0A=
=0A=
Reuse the existing "aspeed.gpio-ast2700" device model for AST1040=0A=
instead of introducing a separate implementation.=0A=
=0A=
Add the GPIO device initialization, MMIO mapping, and IRQ wiring=0A=
for the AST1040 SoC model.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 9ae0a0e7a4..c6b22186ce 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -111,6 +111,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
+    object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");=
=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -211,6 +212,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
 =0A=
+    /* GPIO */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,=0A=
+                    sc->memmap[ASPEED_DEV_GPIO]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

