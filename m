Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BD606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Sy+mCkM8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhFl-0000jh-Vt; Tue, 10 Nov 2026 03:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEi-000068-Ej; Tue, 10 Nov 2026 03:29:49 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEg-0002z8-Si; Tue, 10 Nov 2026 03:29:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0+dGTBxq6K9sOQxSA8s2EOGfxLKldeNRHUiJ3F01BMHXZb6StUxvCxl7v7R4jQwpICBqmkJpb3hlEYFHIrHT8TAJTNqhKZO4M49fenLKZ+ooAe+JkeHdY8fNmJTQz0LjQ0c1jbMPrWknXZ3Tr67+j/9EL9VE7jgnXUxRSu2ZjjYq+pbyGtJj83gw0wj1q4h4t33BAja2rPwLuQ0ZNDZIgzexJxzcqquImHjbDXNQfeZuINun4qCtIkEPLwHhq8VMrJJRdrYD5a+Si+YgJcVZg5NspNDbuxj10IZ7/TjtHy185Y9jJG3bGy7d+l8sWnmjhkOH1JtFHMeAEiF1ltRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op7Y08sYGO8bjPcCRNxX5lP7a5tn89qT449FVw78gpw=;
 b=zJ32hsV8dKcEhexUdMBCrgG9eoSOLMzapUI22rVL3SVcIxDJdN4hHc5Ska/lTblyHGkDZO0OWBjyd356UgyNuj4+c4V9IQH+ShYAj+D1PPPvvvOeFGzXKDxPriqmLwW5ZIPlReWDizJlKkbEXIMBGqGOsi0XM8XQs9sWJP/UQs9ZNlGA3zSdUf4yoe6OjZY875G+GLtzKu5leLwAMKOc4Ltwd69oAvEfDh47TaJY/72lWmx3pLWStoxYQfj0e0eA/VhR9GpNE3H8mQGxa3vb/gG9uVcwmvq3hmi6EpZpQX7sfvYuKJnjwaK/Xu8fQjX2bvPOWjpRWJdET7Iq+uZvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op7Y08sYGO8bjPcCRNxX5lP7a5tn89qT449FVw78gpw=;
 b=Sy+mCkM8wkOGBPyzvPUwDqkmMtmn49khZmv4nvPqs0YH4etHgT8tdWPU3oIubf2+vcZW+lBVJBjK8F3C4eX2rEoVvD90NeH/MGJ1sa1J206/Ep6g6Nb2sSIORzhI7alLZnIF8w2BCsLVM7akOCgA2by1kPpPUiJDXI93WbjUgje09M4MPv2zXQlrG6o3rYLoQxit0c2oWm2Nz7Ae3R/paxLkZCP2eF6NM61fnWr8XAQecHKu2uu5mdyJjr2IUYXzjRI+c64LMj9TgUKEMFSAuu6P35AW7aodRu7wnWpu7Zj9/+wEj+hEnl30ABb55kKuhAoaIGl7OKXTBOGKCU1YBg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 08:29:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 11/12] hw/arm/aspeed_ast10x0: Add the USB device controller
Thread-Topic: [PATCH v3 11/12] hw/arm/aspeed_ast10x0: Add the USB device
 controller
Thread-Index: AQHdcO2b9UJ+8I//L0OqD2fAggJa/g==
Date: Tue, 10 Nov 2026 08:29:30 +0000
Message-ID: <20261110082917.240329-12-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6047:EE_
x-ms-office365-filtering-correlation-id: eafe563f-46a4-4d01-14ae-08df3f04bdb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|260925022911599003|56012099006|260925021911599003|260925021311599003|261009221227099003|261009223027099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info: KUKJccIv0Scgtr/V9h2RvrB+ue8YiCusFUxDHPbDBha0sS8fNQknXp5FBKJUpKSJFkCY+zSevLOF8VuTstZtFAzywxvTq9k+Cr+byZVA7kMEeESnqNykKr7Bf9EDQAQKyx6HFV8zYa33XYaLbVJoAGxHPDPYZ61OV8+NaEfJ9igDyJ/qGbDyn08/TCnZcfMG8BEBD2qNFAYtozx6bSN2z3DeTM8VWnySJQ+UOB5jd6IYSyzMmsiMS4TRaFRmayifqo/f4LdNqzlbvbULtsMtaeBAkAAE5JbwQgjr/uLvITg9hEyyjBQoY7FcIo6+m2vBDvIfh44kksJoX6AY3MWuIDvBIKngcCK0OO0tkW5PiBiY53c8tB09ACblFjmW61IjugYN/o+BxWAUvKN/rpFso8ef3cxLx8jZgIp2vu/B25mvWd94h+3fXyhVH5oK7s7vBe76ceC5rLBE9NtKbX4P6/ltAu/1qcYteptbYXKW49d/PAxV9DMEnrL829AFL4kg+othCrLOloGW1PcBrdb12PXJXuUOH0pEd3DFGTjgycvGm7aRbkaaaW289HC/GYNPtQf5NZ+oUo2xKhE6uxrQDNiQ8cR8qBu7FFuCDYFQQvFt8lgBFFMmQYMpgx9Jvl5AO8xFii/9s7RgM4y7UhY7phzZQFrzszXXKPq8HZNXu2p2T/g3RcSHt/dBPl4jj9GsjBqeV8ItJzo3ao7XS6HNHYvtoaDqQ5hAkbhCe0imtzE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(260925022911599003)(56012099006)(260925021911599003)(260925021311599003)(261009221227099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9AnC+mSoUfx7sCLs11B4mrRNzAdnrdj2yl561EZHX71EvgxcmqZJA4gos3?=
 =?iso-8859-1?Q?k1HdpZudvqDiKAQVddZ6FjuUvYMf3A/KXLkYIUHn9W/6XGJV54rtJMPJvl?=
 =?iso-8859-1?Q?bjV2YdBtl1sIsm7k4GU+uy/iM4RfCvuMCOUzlNN2cIYzFRqqbnuHojjue/?=
 =?iso-8859-1?Q?IhVBxbzgoHZte8FE0i3SGVALsrewhMBhZ2O1+8sGZuvpUDnRBmn7F29x4d?=
 =?iso-8859-1?Q?JSJ8SL60sH+m2KM2Kje7Wz76lKEJyymKcdkFEtFB7wUp0Jy5l0ozzHMWw5?=
 =?iso-8859-1?Q?U7eAd9lbo5Jms2ElSNn7b8IzoSKxugUeqYcf7NGRQ83JqfZX01DwEyiOax?=
 =?iso-8859-1?Q?Y4jwhyBSfU5k/40VAYNalcI9+vHTyDOy/nijqJx9ulWUfZX9SzxULUWWZn?=
 =?iso-8859-1?Q?LfvwQ+6sI2TCAG28hzQh3cSixTBPpGMmtYYEusH9CBPQFSNqZo458qd9xM?=
 =?iso-8859-1?Q?OwtTCrtAt210V+OM9dfWBXdUP2i3y2NIS0Ay821ex6bqtFWkENLlua39gr?=
 =?iso-8859-1?Q?IgJOrG2wJygI5gBzIhRt64Sznpr5iOy3yNtqx/XpMLZDhNRbidikhFttp7?=
 =?iso-8859-1?Q?MF5YQ/g3+pt0J3VoTEBpN5eDmkaBGQYo9IV1gM1QBnjAr5DSaMSMQsW0Bo?=
 =?iso-8859-1?Q?CdFAUVsVhkrjG2P3gdQVsxg5vBqNnHMjUMSI/+DsFrPXSurwm/yHhDP83S?=
 =?iso-8859-1?Q?voHxtQ9mWO2JASRRUYZ4qhmfPR+k0UEEefpeyrmKPrzu+LNWKANY4V0++x?=
 =?iso-8859-1?Q?FI93rr0YzQ4t53QfTGGJOU4Q6c4lActC38H8LzgAobjPoOWw8tod9OImxR?=
 =?iso-8859-1?Q?Gzc8AGtwrH8SWjQEY9pqzN6DS2zURicN9Lw7yI1h+gScKJybf8CzyKda+X?=
 =?iso-8859-1?Q?3Wp1Z1hDmUSebcFh3CTiyS+l3KWfafQuLpicTALA1D9uPyXDE0HrygmXZU?=
 =?iso-8859-1?Q?4gUqslkZNkrO2hsBs2jzxJifhEd0YQbr76L4X8Ma3goqbMTW+pWZBCmUC6?=
 =?iso-8859-1?Q?jhSbKTAWxucWGwlIRZaC2CoI7p3wdh+St8++aq3JeyTj15oq2cqAbj1S+s?=
 =?iso-8859-1?Q?n8BFqCN962TrXpSYi35cLtMd+7VMAy5NeeriUQV/85Mn0mYo4qFHVYX1sd?=
 =?iso-8859-1?Q?70xoTAJmsQesHRNvuZXpVoK2bzuyjqvxoWflSejY4LuebTpLYd6lwsbRWD?=
 =?iso-8859-1?Q?c49AaUxXq60glw5AVrWzZUNnS33p7dQ1Y4X9y5sY2qZFol72Ty64FpwpGx?=
 =?iso-8859-1?Q?UbDi1iXl+NBnYytYo+N+/AwUMkKdVRXuqHxN3TotmAizdDO8sXBDJKCM/s?=
 =?iso-8859-1?Q?74ESjlxPMQYN9sUqAz4+fdkLhH3iPDtXP4o9SANaa1c+/HcnzqHrR36kMf?=
 =?iso-8859-1?Q?T6De7QIR+OyHIYAuhYqkTgQ3i9dWEWtcLBbBV9L1mbPayrAQav1F0nhgXW?=
 =?iso-8859-1?Q?HJ5nq8b/AKd01BMPLUMW5mWTedmSmvRoLSqLwl9VeV2Nib9SUhrnk3lIxx?=
 =?iso-8859-1?Q?+AzgH8GhTXK86ZOoMLulZpYK0sXoAYGp9ih6y9lwnHz8uadDci0j256+YF?=
 =?iso-8859-1?Q?pKdthQZHPY7bE0THhojlaQ1zVucFeH8i9bi5l8BkPcKUVBs+tnyQs8OUD8?=
 =?iso-8859-1?Q?zB0w5CvqUw2TTY+rROEqMMj3N/bj7dWQ9YxcdJm8lp15h/PLaoi38Zu2rZ?=
 =?iso-8859-1?Q?blFHjeuGwKvAPJFKJ709XZSW7ecO1O0oUaiGAgFyLSYJHp+WbHUPSXGJj8?=
 =?iso-8859-1?Q?3QuiomEDHRB15sSzBpUfSj8DOjFAjS3qhITtcvZ0KXBqfB6QLqWSabMRsL?=
 =?iso-8859-1?Q?X90jQcWBDw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafe563f-46a4-4d01-14ae-08df3f04bdb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:30.4891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8s6ysmAfIlhCsg1uXkCIwTwsLhevlY/aqxhxiZ61qnG04PtXJKyQmJOQ4475feBfxTsKC/XRklYX5TsVZPXs7vQPkNtayEnfrgSTQhOR7JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6047
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the USB UDC device at 0x7E6A2000 with IRQ 9. The AST10x0 UDC=0A=
controller is compatible with the AST2600 one, so reuse TYPE_ASPEED_UDC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  1 +=0A=
 hw/arm/aspeed_ast10x0.c     | 13 ++++++++++++-=0A=
 2 files changed, 13 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 338496a421..fc1adcb6c1 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -157,6 +157,7 @@ struct Aspeed10x0SoCState {=0A=
     AspeedSoCState parent;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
+    AspeedUDCState udc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 0790859735..04e7650e7e 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -101,7 +101,6 @@ static const UnimplementedDeviceConfig aspeed_soc_ast10=
x0_unimp_devs[] =3D {=0A=
     { "iomem", "aspeed.io", 0x7E600000, 0x00200000, -1000 },=0A=
     { "pwm", "aspeed.pwm", 0x7E610000, 0x100, -1000 },=0A=
     { "espi", "aspeed.espi", 0x7E6EE000, 0x800, -1000 },=0A=
-    { "udc", "aspeed.udc", 0x7E6A2000, 0x1000, -1000 },=0A=
     { "sgpiom", "aspeed.sgpiom", 0x7E780500, 0x100, -1000 },=0A=
     { "jtag[0]", "aspeed.jtag0", 0x7E6E4000, 0x20, -1000 },=0A=
     { "jtag[1]", "aspeed.jtag1", 0x7E6E4100, 0x20, -1000 },=0A=
@@ -170,6 +169,7 @@ static void aspeed_soc_ast10x0_init(Object *obj, const =
char *socname)=0A=
 =0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1030_init(Object *obj)=0A=
@@ -389,6 +389,17 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
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
     return true;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

