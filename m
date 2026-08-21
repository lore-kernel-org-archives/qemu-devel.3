Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4DCC5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoT-00013G-TG; Thu, 20 Aug 2026 23:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoR-00012V-Rs; Thu, 20 Aug 2026 23:21:00 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoP-0004D4-FY; Thu, 20 Aug 2026 23:20:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbAkBJct23TwhWS72lE5yrwJENjs3Yc3vJaPvgjxX8eH6RmhxkoLbA8FeXnOfS44tMdfM9haiNaASAtGS5WHMqK4iEG4W2ECGcxfdqGJgUypJ1uFBofwbBFDpg0NIKLlniDjh3hEWdzQgVOCk+QWIVInPActA5J1pDoiN8G7pPgN0L4e9ijs0mTillM300ahxNYdKxv1td3loLCavPeuHaevm1XnUwVqHJlq93Gj9EXtCEJ7D55BlA55UZ7jv4Ub6oNqEbYdmu+Z0qftRVLyHLnjxESdM9Jrw4lsFFiO7Miz1rO2ELI29lk1QcUVARv9uoW7LlFI+Fe8976qISkCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5n919sZRjGJpq3AliZuxm2CNhDcE18Zq45OpTdwdQc=;
 b=BrKAwWs9+YqcDkqfcxmeEmloW2TJ/jI1jrbuURj0J5SeXyVhZjtveZnhMFSjnDjFDB9/vt3J9JGpQMjVwm03uUxn7xZMECJqzFGKrNyXLzsdcrIexmAO0K+64nR0YsWts+FNXGWOKgZuLYU+ChDVGpk9UfH18LZKrxH9q+SfHyNHErGwr+hDvuNb6UoL/JeoGTMxjKtcxB7U1Vt62rytE/qzUX5R5am8zR60fH/ak7IDDVjYHoLZd/zOjGEh7hzppXVJfNjNOJnJDtpAbSdiZAtCpM7RIT2ldflXwMgDiuPGue1qW3MsI4GqKLaCxpjBZzCX0iai3AWvgcCi3K7vgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5n919sZRjGJpq3AliZuxm2CNhDcE18Zq45OpTdwdQc=;
 b=i8rrDbPQll40YQKQO1XzE0BfWEnYAPpLiao1CTLN569UokkADS568YQgMsw4oMLIDHVhxdIw8bk6XhxRDRcrNFElhjXR88bVlP42VzVZ9ZMdVGUZGlE41JKPEVVkiarECjgOR7qioUlkHx4bOuX4SSJmVPM+vbACcLezqFIvQG5rcsRSeL/nDyuXJcVmjzGrvy4WaZKh/hkvDFb3FyiUPKjMHhosEARgH/Nm7UieWQxRxJQgXdF2jzwAIT18BXIEEE69JLma0+ZxiNJwfKgC8f6YHu1iWF/WypxWGD/4FCxFMexvR2vvTf15cpwHAw93mJtmUkvQuCJlJZ/tNHfsSQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:43 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 4/9] hw/arm/aspeed_ast10x0: Remove obsolete unimplemented
 SBC mapping
Thread-Topic: [PATCH v2 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Thread-Index: AQHdMRwMgjEASpTQWkiRlxIBaIxg2g==
Date: Fri, 21 Aug 2026 03:20:42 +0000
Message-ID: <20260821032036.1829294-5-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: b875080d-ca80-4be5-803f-08deff332eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 9cE3C9uhx1DupJM/D1BX+Kc+iHxbdcWcwmWLuQO1PDbEWGCazkVf+C5454YBzvCZLnX+iWDg1xWGXnAhw9EnWr8E1ijW9nydd4rtxKgwal0EMamfV6GyBkkRcmf8+YBNJi2D6DZlHKZwQM1JATEBruadrfvUJtqwCXOGNGQTmkE0yqbY6FRmO3vBKehTo810ODJfafjsHoP+jiZ+u7k8PCgcNvdTHyGHh3bCIbgyjrcnkL8hCKU0dUA2ssMvcNNlxiU/vlVtVfO75ZTK4w8uo/3Xpgxj7ih0OJr42jCIyxSnFrjaLQGlAzhVbGGpVe2MWteBabJDaPVUEA7mM+AplA9c02WvOlolWlQfF2Uf1YiapSxZprPhKrqZHns7SZ8RO0Wds9wMEsPq0oFfzarlTsvZgY8iiEREQpWV7luApxkZgz9Ef1tCnsa9jINY3fs9QL9nTQM5JFV++i6L8wEyanpGQjmeYoFcHdh2Ad8X+6WIYE3/Ud7KJk/yZzI0nEu+Va4MGpXRUDsZALjev/7mmSlcQeW0cXgl9bXA/JBCPKPv6CYMozBZFZzO95bzkc9G0uo8X10WuOJRzgJYevCm2PCh9oZccLGJmtxSps/ouj/9Go2yllEbJhrWheN4BDrMi2oBG7YYNlVBOGeKPyBSx2WU3U7oxRN4aeYUmiD3nqFPkCD6e/7wwI1/t7OsWPTOko23JACXDB6jIRX2q2txTzZ60elLEJtspr/2aGKVSc8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xeA/j+ZknszP4yM9lBYoZFpkZ2yEziLFL+ToYnpyRThtsJ8yql+ZYzBCRX?=
 =?iso-8859-1?Q?vFNMhizdU3Bko5M0ZF7UBlDg+a3dU0bQXgIaYRumdbtWkmJsk2gVDEOhWJ?=
 =?iso-8859-1?Q?uWWQ9jiKS39wO5seewoB+DB4nZFqoUYyuGUV0FPUP3aE0W2JMirdV+V3kJ?=
 =?iso-8859-1?Q?ejVTG8CLymYPAVhPC353A4wDuueulV+J8BktjgKNAtTNWioeeJgkI2LENI?=
 =?iso-8859-1?Q?ha/FCWQkzqLMUEsz0Jtr3fnBtawnrYW/UePinGP59XSmCPz/3SXqn94HFB?=
 =?iso-8859-1?Q?7wpp+p5Q2NGjKBZbdjLWaDNJI0Jzy0ZDdjGWoJOaAXsFtGXyej/3fSnhT1?=
 =?iso-8859-1?Q?U92TeDxCS1r4NCxSHrL3DkHz7/ggxtknZJhrIu2f5V2EYUvccVVA8N+ye3?=
 =?iso-8859-1?Q?A323UbjXkT+AshZn+ghpIUpPbniaZWgvFKKVQjhnRw5JlRYgsnP9/q5NNg?=
 =?iso-8859-1?Q?8rJuD/N1KafsFMntxE3XI3Gjurp2d/N9B/vF6Ii+QfR5yBFnIi86jbuTO4?=
 =?iso-8859-1?Q?YhhpSimNRamw9yv1dJ8YVh7A9I6nuyBhC/f1wn9UrZZ8+fJHKIVjtFsG1C?=
 =?iso-8859-1?Q?hB7U3N47YkAVrq0hxRMgxfVHec5SyDk4qx19xblKizSunpAIJ2BKAK7fpE?=
 =?iso-8859-1?Q?ZTTMsT39icpmVep9u/n2ENhijIXAlQktiZ/D8I+FTIztfblrkTYUSV73Qb?=
 =?iso-8859-1?Q?zH92JySNNzuNBtp2JlxEyZ0CFFgo9bhRYzLt6FYSRJM1XTBw5mRPxqOr8H?=
 =?iso-8859-1?Q?MEcyKnQ1mnlsueofKtOvSMtv+W6YTyb+O9iTTJfdUq9WGqOg0AR6Hyhfbp?=
 =?iso-8859-1?Q?LyuAmfXTMlmA08slXyxo10Q7DO0SCc7WYz1UAnXogl1WcLjKcnHHseQgyW?=
 =?iso-8859-1?Q?1pqnbbvIIQfPRrJHGkqutvPbB8iqM/Q3tvQNs6+0wfeHXPrg0gIulbTZs2?=
 =?iso-8859-1?Q?JHusnbWtBIkX7+unBgiEe9YMt/dybdLFP3DnBH/BIPf763QWE+wdWelbza?=
 =?iso-8859-1?Q?5kNhfDvt2uoUaw8a1RSwzNmYFQ86LTzi5VZTTzE7t0wm0Z0KOnFhMqpANj?=
 =?iso-8859-1?Q?pj5NXgfoWZpAXQRtm2CfSeroI/JoQl1kUrB+jW6tdFwRybR+dQGuwGy5lq?=
 =?iso-8859-1?Q?/eQHt7BMGl7pV+fqkl8Xn4g/w3O0qYoCZBHxR4nd2IPIGmhlsCmQx3kp+j?=
 =?iso-8859-1?Q?pmoMrx9zM8XtuX19W1f/96dfhMlJitO1ND+2VZRoqZAyeLxqjpFwsU8xed?=
 =?iso-8859-1?Q?LPh0T2pSds4+SQcWXlrFh9m+PNjq8PvpDLSyIh6k4lxxg+9WuUx3DljQst?=
 =?iso-8859-1?Q?/R9DdDsFmOiWNQ2A9bWups9ylMKziqBlho2kMAmaAR3HncPG266vBiD3ZZ?=
 =?iso-8859-1?Q?ySFv2j6xGDufrMrOO0R5xZZcXfEqi+L+xDzlLF2Y4U54a44cLGnFOLjd0A?=
 =?iso-8859-1?Q?7KB7LH8/gH4aTer9umNsWlh9eXR73dwOQFjYpTBmY8kSNPCE/NsTrcdm8e?=
 =?iso-8859-1?Q?b3rWEdDnTbVRIiCK1daT/2jwHXLRolPPn/mNVkigWY7vVNjp+N4xAaTngm?=
 =?iso-8859-1?Q?HCH0ywt07OkOMcU5/3LPZcMmuXu1WjWkNCJjO9URjGTs2fs+avsX2F+/Yt?=
 =?iso-8859-1?Q?m3ts6RN+ALIbuvPSYKY02J4vlJ8jht3adurYTd4p4NX+1jb3Gn1bDLZxNX?=
 =?iso-8859-1?Q?2GzvbkOPuilbQCZZfcpvVP0LkciKmT3CBSPob1CkLxWfeRhjt6gZsP0Pgz?=
 =?iso-8859-1?Q?P9BWYIGniclXIseX00nxl2n0VlxYvwrRMIcst9E8JzBti4F47aPz9XiUiL?=
 =?iso-8859-1?Q?pIzdyBZEYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nq/FD9qTLs79tGRJVLg9eDJs7Tkj55PD/JdV23cmJcEP7ZTwX/hEQ/XVo8mIxH7I5eA6IIwcK+ipTQkVv/CdRzktY/UImQ42alA7bE2E0xeGzR48xascwCEh7Wp2ycKB9Jg0i/SNLr6LSphNMnugjUTde39vqxfvYQti4f7ZCXapqzoE/MiIlGw2XUR5YrsbDjQVf9Bk//aekVh4xiM9ZkClRMD9QrKqKYYaP8hGRRfOIUc8ph8lbIoQxnBpOk/MVq68PAOLR3y6MilqvsXR7wIeu524R6zPDBgMZYtBeJIrh2RZxZ1EkUbAh8kJSJAym/FLWNHdzc2mRKlekfK1lw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b875080d-ca80-4be5-803f-08deff332eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:42.4389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6ExWJ2Tt3FJXsUTtXDxqxes32SKzvcmlJxxVAPrIX1yenxs8n3Rhnskdzdhlf5K8GsBsCAM55RjOToB4J5GWE5EPTXnt3mK4NleC2qLJjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
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

he AST10x0 SoC now implements the SBC device model. However, the=0A=
old unimplemented SBC mapping was left in place.=0A=
=0A=
Remove the obsolete mapping now that the SBC device is implemented.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast10x0.c | 7 -------=0A=
 1 file changed, 7 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 93c81195b5..5165dcce59 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -163,8 +163,6 @@ static void aspeed_soc_ast10x0_init(Object *obj, const =
char *socname)=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
     object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "sbc-unimplemented", &s->sbc_unimplemente=
d,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -222,11 +220,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
                                   "aspeed.io",=0A=
                                   sc->memmap[ASPEED_DEV_IOMEM],=0A=
                                   ASPEED_SOC_IOMEM_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory,=0A=
-                                  SYS_BUS_DEVICE(&s->sbc_unimplemented),=
=0A=
-                                  "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC]=
,=0A=
-                                  0x40000);=0A=
-=0A=
     /* AST10x0 CPU Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
-- =0A=
2.53.0=0A=

