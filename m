Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79383CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw9-0008ML-LA; Fri, 29 May 2026 02:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw4-0008J6-Hj; Fri, 29 May 2026 02:43:12 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw2-0002Iq-Sb; Fri, 29 May 2026 02:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDRgOWXNp7Co6SqHj+1rmDnnYPD4p2S0t+K/vf28FKM4CrNtFLN6OYom5XA8XTI8zez7yvmnCulFtkPRixVQGl7Ha4nH16LWxBerdHbjYFlaqrnzmBCkAQWJSM124Jvvq5WcFEXpfGA/95hLl/p74u1Du6PTmBTRiCoSrHDow7PAfxQqS4uOMH6SHeyOPQQN18gPTOr1aTLCpwxFSGJX+b+ziRVxhjWgIk9H0F2GMQ2oDStYuVO6vcfCmVQpMpJEIR8cCkihXwGJY9nXtaNONRgl3tGM4YnXeWdIVlAmvqUeTc7j3/5Gn4S40Z4QP+H2vF2SrIuLSZkcnrMIdxqwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bru9PpMQyjkPKKDXyFrNBGEZXedfPapLoxjV3q9RTz8=;
 b=nqdvJN+anon4LFGWzGiSQsXE4nnvIabL7e8AiHbkDLk6oO9SDK3paRRF9kmJf7tkMWBIy+JNtGx6htfjCGExZrWUwBPScjjMVSt9ytsQWo6z8wrrP0G298X6DhsSlgD8xoFEVQ5RAEQGQhf1AbIIs2Z1MvClLo2elVmQXlMqFlyLKbXyX7zc5geP37bPCh0tFL9DX9S8fujFHvTuuelBF/mNYBRlkdNKFqbWvY672wgtEfyFHZJDDM04AcKJtLC+QKctWBfjISLHaQwhYA4qXiWq/pZT/8T6u6KFZfUhEPD3sPyCFOA0w5swK66bY59CXb5kFJUNBPudVWyNRVrWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bru9PpMQyjkPKKDXyFrNBGEZXedfPapLoxjV3q9RTz8=;
 b=oUrAKVw4EWRW5EGxFCfkzF7sJejM92U0TE8pZMOcDI1FlK/yXoUOKNNGfoJQBeqKlr2gDB6KgObdxEQXW3zjgu4091GWCfMH5gWKWfy3mYYAXJg2o2lyCL/1u7G02BgPRaiWdhP2G0LY/PIcBtRrbKjOthCjTtb50dUsMTtX3djjzS5B/Unu0tDhkrRye+4tM7sLdnMXGmVeYWUSbG0E3yrwZZH6gVcHnjlVNP7XUF+iILu+JFni1GS5mvApzvpsgSBO/ZXv2Uid8yf2TZLv/G7CyuMnZACLafD9lhwYcVTyjqkCcwSsHyQWIfM8kELZwCrUs/bIifomr2FWj9tqGg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYNPR06MB8451.apcprd06.prod.outlook.com (2603:1096:405:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:42:56 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 10/10] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models
Thread-Topic: [PATCH v1 10/10] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog
 models
Thread-Index: AQHc7zZh9Yt0b0PXHEqco10tDB04NQ==
Date: Fri, 29 May 2026 06:42:56 +0000
Message-ID: <20260529064243.2064188-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 91dc1f0f-244a-4240-013c-08debd4d846d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: D1bgtdsMJ7UW/vfinsg7DAIXKEXqSVgAq7lav3JjHm39ttmFjAiVqXOntqc7v4HOzD20BtHugu9rZlCcbvifA5Cr+oe1EDDVr97u/48gijhHV31+MbrfWUxKuWcuZfj+u+Tb5ac0vE/3Vl5gJvX2FbdxdJJlMiGIAcpCRYhWbnznBYS3Qyn2/fSSKrrKhWutlAsZnNbnVOzOUY7Pj9fKKliVDc5cF1m6+VyM1moNcd1kN1Wx0z+eJkclAH7EsWMTfpSadtQpmaHjsdNZnhDDSD58d4RW5DTvUacdPCLuqkA9sDJdMbAODl/btfXOzkajiicygxfi20HKSPdxullcJqb7Nf1O/JNMsSq/rGofrKk/pL2E+scsudSgp2pIfYogcGqfCxBxbbE/9GVQ97Nh5+Skhrtjc5mc21wHw48m8qDeHhxTo9Q3AZp5pmi0uq6r+ZhB7yKoXNzATGbeG51esSFRkfob2hP2Ahew+NQXBws/M8O+v7lyB4Ny5iPR1gzPHV8VRwot8gI5k2t2AVgb/KTHOMS0VT51ycrIhUoSTdAFL26XD7GIWgULF9+1X/F5entmYLFYSyq9jt/r26j7bk9FmBZZ29XPfP8X7x6sJ5LL/HP3/dlKUeDHvBEAASFNHaQ6ZnG1ZKurMZed8BvXxgnNdtDePjoz+2/Pg80Oc/TmhAt8K9rNiI6qwN0CE4BbXPBzAVaxB7XOJNI52L33vGrjPGSgXYfGRw5d+8CKg5c3UxWd3FkeLmSG25oRPxNn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M3ZE4YhrfaH/16IrielSp+sH/kNEGETNnUq+3g51+mOo4rKXZSLpQ5f5hC?=
 =?iso-8859-1?Q?T4F2adBFV53xmaRoh+ltPmQGBmiIpl8UfKGja57KnGdfz2zhDG/0vuUPyu?=
 =?iso-8859-1?Q?PnF7AzX0oNTUJCvm6n4DYJUBxgAcMt4T4Sfe0sN3Hzqtf1KnoaIbHhFfX9?=
 =?iso-8859-1?Q?qVyTC/3ezTu1NcJ4ymd3TVkC9VfVByG7/UCHbsiBKZiWBvbxnP6lgW9OCT?=
 =?iso-8859-1?Q?eQEGwdMdrKRefSpaZFToe1/cq+d7JIIKrxUgWfz8Lshj/kG9q3gSuxtEVs?=
 =?iso-8859-1?Q?5JrpD53U577ongxzBT0FenJSynYTacbFtrB4FrTFwoos5JqLXz+AlvFDYf?=
 =?iso-8859-1?Q?Yck8UxEr4t5kv7TitvIzsfCJ5ccrxdv96qrRbjQcEZ6Hnej2noBfCMxAju?=
 =?iso-8859-1?Q?N0yhVIIK56OarYNsc943DO+fgRQhstCJEL5ksSHA+syWZPIIODCap1N2o7?=
 =?iso-8859-1?Q?5nONUmFM2cr5tQWkSfkDqPvmE7KNPaS16Du0pJvSdvLmpVoWhadHU3NVnY?=
 =?iso-8859-1?Q?QbUJWeuKtQ4S3WD3Q48kEeQiN6OELgrceBurJMV5DqFw76jv1tjWPXf8xZ?=
 =?iso-8859-1?Q?Q7sUp1AtXMAuI+09eQD9khbsUcIDDBvH8Qtq4xSpDQ1kFZdbZ3oNlSAw52?=
 =?iso-8859-1?Q?9rTyfKozmLy2/EE18BvIHG/mi/m4B7BnJ/8fA6CHq7pcG7WpOjTBkiaqN9?=
 =?iso-8859-1?Q?TpfNDIsEWJr4+w50T1rAzTGa3Jq89Ta1qw86BrUa7NW3CTG1l+hLZpfiQb?=
 =?iso-8859-1?Q?jwqdojrVD/Epj5PRHrBhGKoOjoxdOPb/iX87+N3S0nKr8gnT2G5Z2R+t3t?=
 =?iso-8859-1?Q?uIp2MoxHxtzLlt64mZIg1vdtWNYCTrZjFgn7RIpRspmIv3A2gU7v5G+7sA?=
 =?iso-8859-1?Q?kur6BixU4VuAjJpmw4c7aDX03vHNN+SxJcz66MEN87wwcqUkgbb9oVt2D8?=
 =?iso-8859-1?Q?aO7ztKi0aeQAJyLthmBA3zIU3THjodbMtwKuei1At7+nWzdRKliot+Qtqg?=
 =?iso-8859-1?Q?jDnI4Ho4VajZUqNS743MEZU0lzMpcc4zHnj1QsvkSRpi17OGSHpeuILWA+?=
 =?iso-8859-1?Q?pWJSHI6Q16vkemHn25JbaLIQHzBgwtucixuFGhj+0DVQ8gmnDTpgF+gDXZ?=
 =?iso-8859-1?Q?pUifUD4rwhX/dYin/jdP8E9CiuMM3ZpXmDSJT3eUrOxW2viUbGxQKZo96W?=
 =?iso-8859-1?Q?zRZkQcjelhAgEoGUS00fexNnChcOYCGxKCoEG+iAdxjG1sLsNWVGaGV0oO?=
 =?iso-8859-1?Q?PsEpvUjLoNSpJ/q2vt90F1mCVEMjBG1pL30asKcThJmFNEdyDvNmuhXgXq?=
 =?iso-8859-1?Q?4vS35OXBRb4CP2+iDygcbNf4/7FX1aHPbjtK5Ip++U7Ots8vOOb8Koys4S?=
 =?iso-8859-1?Q?lLmbChZCnnuWIkMamlPF0e2EXDR0sqxDOEVu/2W3XbsM8tvub9r6675Mh3?=
 =?iso-8859-1?Q?U6lFOYmmoUuXsOZTTigjUvP2bdw7DZGdkG8xQEASVoi9AiSwG3wH/TAOS4?=
 =?iso-8859-1?Q?gyUgVqHo/DFZoWbbFZG2iRfNWy8VCJFcj2p9F/cGBFgT5lhXtKuhiVYy9I?=
 =?iso-8859-1?Q?xbaiW+hCcduzsgl69TyRlPCimEQReLUACh5XIQ9zEuLssjGQyGH9e3nU4l?=
 =?iso-8859-1?Q?tkelecX+FnAmsStpJlKJyv0VNUeytVhPC8KpsjdiBCc1ANujlVo9aCXMnP?=
 =?iso-8859-1?Q?mw5+W2zyh6ruimY9mwmsc15zEfpnoS4JiFAtpUF2t617HijfTJWK7fG11N?=
 =?iso-8859-1?Q?dhy8OVIueiIz9UscpfUEm+nsvDZgbMYtANXzjBSPVZGC6vDf1LnVrFpkda?=
 =?iso-8859-1?Q?DmRVUx9Nvw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mWsRbeklxyYulB0ZiJeFsNCMjcMJqSSO7BVFhUUigFRpFZbYXdKlNYiOCy1siI48RPYfSr6jEfdR5Fxqu5IiwhQpUlpu8yWLToda4iF71JJKUnXy1be/C6b00XIMYBU8Tk8Iu4mxToG3BOAxxXf/2tMIdCs300DAwvEyiHiiJRXiF90MRoxc8tLgyg0v3XaA+AbAbfmVRWpXq0HiKCP+U4FDCG8xHofjAfgVZceQOgA9I1d5WoP7H1ODoW/FcOYIISBE8ttt7bVOHIKRkC3i17l4VPoSBdRelB1sg6YLE8X8gx1ft0+lTyTsysTUwqfnbuXd20dqn4C4nxvVOCFlFQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dc1f0f-244a-4240-013c-08debd4d846d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:56.4642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+pQpL4xh4i+3KYiCCUCKK1o7H6CDSP57Oq8Bd88iro6HCW/S/aplwJUcAI6j1RJR6iDHWWGnxTw5tHtUrY8VJ22A62xHHp07Zf/zh8JEb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8451
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

Instantiate and realize the watchdog models for the AST1040 SoC.=0A=
=0A=
The AST1040 watchdog controller is compatible with the AST2700 watchdog=0A=
controller, so reuse the existing AST2700 watchdog model.=0A=
=0A=
Configure the AST1040 SoC with 8 watchdog instances and map them to=0A=
their corresponding MMIO regions. The first watchdog controller (WDT0) is=
=0A=
located at 0x74c37000, with subsequent watchdogs placed according to the=0A=
controller register space size.=0A=
=0A=
Each watchdog is linked to the SCU device before realization to provide the=
=0A=
required reset and system control interactions.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 19 +++++++++++++++++++=0A=
 1 file changed, 19 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index a4fe0658d5..edf28c62f9 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -127,6 +127,11 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);=0A=
     object_initialize_child(obj, "i2c", &s->i2c, typename);=0A=
 =0A=
+    for (i =3D 0; i < sc->wdts_num; i++) {=0A=
+        object_initialize_child(obj, "wdt[*]", &s->wdt[i],=0A=
+                                "aspeed.wdt-ast2700");=0A=
+    }=0A=
+=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -257,6 +262,19 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);=0A=
     }=0A=
 =0A=
+    /* Watch dog */=0A=
+    for (i =3D 0; i < sc->wdts_num; i++) {=0A=
+        AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
+        hwaddr wdt_offset =3D sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize=
;=0A=
+=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+                                 &error_abort);=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offs=
et);=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
@@ -298,6 +316,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
     sc->uarts_num       =3D 13;=0A=
     sc->sgpio_num       =3D 2;=0A=
+    sc->wdts_num        =3D 8;=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
-- =0A=
2.43.0=0A=

