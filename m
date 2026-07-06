Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C1C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgez9-0004ac-JN; Mon, 06 Jul 2026 04:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgey5-0004JT-Iw; Mon, 06 Jul 2026 04:46:27 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgey3-0004bJ-P6; Mon, 06 Jul 2026 04:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0s2A+cg6bfG+JvHvjqT3sznzLW2sPmyi0nXG6pKZwknIRM0eY4HQmbqX6Qp0+fVgTFUrGr3DJ8fiDLytLjw2lsSyZlSXiiA/TcOo5Vo+1zd4ILoFlbGafbsfpKLBTmY/+lhObIQUv5epm1m3LgRIZ+VIUMLmWezs+ZeQcPjTVGJ9Xq4rqyuuXqn2Ybr9nCC6n7k/bY5Dki87Il1PT9thntjTRCsu9XPrZtcVKbWHt0p3p0JQbNThRDFoTd9pQW7UKrPr7U2QNzCkfFE1CyFdg+LzoJwbxDWqIpfCoUNuP9huts2hUHWoJ9dL2fu6/Ut88syQd1Y21jC/FjQlLj42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgnD/CP9g3WHv5qs+77hjMirb6bsj0ho1nNhWfDTMn0=;
 b=cDl9/CH1siA0yMKzJE7TCuhW/4d6YjLLld/zKoV5Jn+4H25mu3gX/vDTyyQF7VOWRlEkd4NYFJb0ggJ+a+LUO7DeQ11/Aztyy3w402jB4YPR6d/srVTy3y5bLYg8giicx69WVWqF4+NhB0SK3V1vTiE+TOcU1uFEYw7+vNwjfrLEv7CS5SgxF7mRQbyPAh2VnZPofxexKbO2HAHJhlNgcPeRHRjihQqitfxreGah/PF1cITDe49qZQTz9Bp3UfGpl03woeLRJwhgsHPfytWJMDc33xH590yXy6SdDO4SrNBI3TNWz+4UcQkoM/3y1z3ufLXbBVONXxLDvEWOHet6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgnD/CP9g3WHv5qs+77hjMirb6bsj0ho1nNhWfDTMn0=;
 b=qPCPbJM3+S3TpAj2OHctgLAAYZFwIvlypO9JsLhEdM+ECVsrYL0SSk2KKC0OJvs76iS/Gl96zSyGchANTAd3xkPVCxGgNI7gULqrJ5N2qzAKb/G0uxeO7/Jk7qPkglLdJ4rhpDHr5dARFnbmYUV9bzpnUdZUxqUPbbmXTpW690IfGWk5NPknNI3KlCjKTMJHgNvjcM5uvlJp7mjr5VFeeQmSdxTFXBjcGZns6FDSBcmt0sY5pQtpfmNGuNvzhf8SREfXv+fWN/WvRhG1EBpp63BczrVKVODKZSUhAsZIeppnkf/tyB/vQDGfw22qIym0LA7lWgK36QyeDwQS/ra7Gg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB6639.apcprd06.prod.outlook.com (2603:1096:400:45b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:45:43 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 08:45:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/4] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
Thread-Topic: [PATCH v1 2/4] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700
 users
Thread-Index: AQHdDSPUDuIGvzU88kKzbQvBEkTbyQ==
Date: Mon, 6 Jul 2026 08:45:43 +0000
Message-ID: <20260706084540.1988785-3-jamin_lin@aspeedtech.com>
References: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB6639:EE_
x-ms-office365-filtering-correlation-id: dc44ecac-4b5e-4c01-eadb-08dedb3af765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: K+mY/q7HcFRNt1aI9OBfaX1fbnP3sIc237hZwm//9jWRjeG3r6fyoz4boPyqY1zU2HzJ8V1K6/C6NnQ/xwg5FAc/jlCleQcCS1KMx88UjRxYUFRr42RAl4JDZ+AjM4xqCoEHZK2sZGLiET/YVvSvDzvzTdz9OyYHjmuenALrwg7rNZqs7+T9Tnbe+TjgdsBrWk1dmjtVQPIfL8oxHKMhNv1moyBjBlMD0YFcKt4ApokwPHAJ+oODp4IReOt3I0ZiMow8iQeq63cFxn2rhvCSCOs5APbhOiYQ3AqeDrQWjhzRHjfgaPfhbAl6SVWjoXkxzfTk3cDNkHIzB6DLmri4rCnt4PDTWrgjvjFmuNQeeOkTTdNjYg4besGa9QMfqTDTty5bqqhxDkmrAwsgwqR+vBYQe0EYlCPaGH3K2NvjMWiwa7xIYdhJHogRSavSTN3zgysGXvaywsQnW34oYTH9X7AD6M0eBTSKocPdKv+3eGk1EnTgMIUpUysMGBtT3jeoR2lwMqTzg363FWuSjX9GsVELQ/ZJkC+fVyM4uc4UCEgfRIUIeuwLRQiH7XLjaFc8VeFDMUPhQ7nSCOTNN4QbEE2oYi1Wk75PV6fYf/kHoZ+GAhKTNPkQKVVJC4z1cdxn/Jxb45NIO4kwBlNj2AH/R4t5NSdWrPuK8eO8gSR3FQiv7HFWNJO8f6gFH5VHS2jrQji/xJJ+Oz5rvxInIXK003Ytkygp1YlT4q6iG5XjQj8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pZfLyGWnwoMU/1DTKdOxGO7JKEF/6P/gAWLxC9v1bEUgubrElvgYWOGzge?=
 =?iso-8859-1?Q?L6ZYVso7N6+MowduYUUlWTI8Oe7G8hvWSCSAIZ7zIvFb6SYy2ZVlS9+/oc?=
 =?iso-8859-1?Q?49YVMaT0MxCHUrsIvtpeTKUEHp8DOR8Nhy3BzEsuga4nLzkquiTKnjXhKp?=
 =?iso-8859-1?Q?vH5slAxSaDP1YrqPdmhTZkAoe2nVokfreRAqopedBw4uxUGoIfFOEZnCzJ?=
 =?iso-8859-1?Q?JNPyICR43R2NJf7bGT3Jn0WMkXRoeulwkMy6jq6zdKwC4J0MrU+0GjuO3Q?=
 =?iso-8859-1?Q?aHU58gbRnZvLdLntWttWQ8Tv3uU5bvLxFhSysV6BwZrJanqLwmVejw5QRf?=
 =?iso-8859-1?Q?vODDf+l8IUhF6f06/qKWif8IS8xOlRF71ULZK2ZKis2JxlLIvoZWvoxGJ1?=
 =?iso-8859-1?Q?uCcZeqn0ZNSPl+NFViKbm3AKndX5YVMUGdtDQAiRD+le0EqY6tFcgk/Boo?=
 =?iso-8859-1?Q?/UDECGP7E5mRVI49phpsm92LR98jl6qM77UrHHkkIn8DWkeNydXEZlhIBy?=
 =?iso-8859-1?Q?aMjY7zKhPja6TqE/YIuZOCqmMn/8fDq8l+aJolemO/LcmKE0rWO98Oeld8?=
 =?iso-8859-1?Q?tw4EZF9YDoIKoBHmW7oHqLhQK2DrqebjJ0YgL18tNbg82WocygGndY47v8?=
 =?iso-8859-1?Q?CAG6a2H5vEbPs0Q7aolmOn+7II6QZgDAnDnlatIayDAMOVflzYIF8e65QR?=
 =?iso-8859-1?Q?evCujPSKebYWWFyrqXFOxInWdPBnxaUCsAy2YLcC4CGWsUG1rZ58nHdhxq?=
 =?iso-8859-1?Q?6acASUNu6+MWDZPk3qxldcueTdM4p2oD0NJjw1CZkkDlNj/iDfRaP69iq0?=
 =?iso-8859-1?Q?jO7djeOo5CQJLYjS17+ygTCmJcJre4yS1y/qBTJRcaIBnEYxOfcLHb7JEV?=
 =?iso-8859-1?Q?IjtBQ6C/cbKF0FRqUxMqgs3jJMUrsKifWJytdMO6ncbjo2oxYsBgnmA4Q/?=
 =?iso-8859-1?Q?Z/UM7rccfHcix0eGgzOT5Txq9D6JIAQwHb3SfFFrVC0CF5I94ZQ0lju8/F?=
 =?iso-8859-1?Q?LR7mEUjwBDsGEZ898bRnw7BxugPadc3R1p8R7llNJOyyQQ6JSKoDTd3iFq?=
 =?iso-8859-1?Q?0+bY2MpOhBouT3YGWk3fbNQkTtFyP3ItX0HlOnReWT97s2Jn5jGmEkafdN?=
 =?iso-8859-1?Q?egoEmWgLvnpxYEetTZh4fjmZHg+b0ZTqZUDtM+c0Y4vJwoL7Svngk1NPtI?=
 =?iso-8859-1?Q?8rtOtSZAVPb+Yeo9N1JmTX9kT1QeMoUQNzd7HbpB4tfgBB1rSdQxIDWd6R?=
 =?iso-8859-1?Q?bI6eQAXbco322uM01TvkJki+cglYSk/OM9qsvoajVefpUX3ctKecqGSSgT?=
 =?iso-8859-1?Q?ouLCzGllPscq03U5jjpxF3F2h7NhhNo8Wq1A/ZndUOSMoZgljr5mSJK4QS?=
 =?iso-8859-1?Q?lWFRKD3whDTtKwSfd5buNcATUUgRRdRnn2g9J8VZ8I6IdRHqIGKTcsyI26?=
 =?iso-8859-1?Q?BqdZFrG3GxheHgfHedOw0u2HV5tNjoV1CksOsuv2Zn2/sMW8TFkOXfX2l5?=
 =?iso-8859-1?Q?koMKoIagcv306DFgx+O/sPL5UIQfvdlZBfQeBWXWsVTPC3n1Afm7lXvOIX?=
 =?iso-8859-1?Q?D9XbScJkOSqtL5vJpoTW0erIgucbi/w8A5FMNFGrlRtnutfhk/4pGnBjHB?=
 =?iso-8859-1?Q?+WutZtFH/6CAEs2nm8iF1S8RgUZlpwShQiLnOgPxeWgY9nz3tavWtIJHln?=
 =?iso-8859-1?Q?pBTvQvZ6xba8n9ZKbRYsfa4ai2+1uEbTGSKnzTQAncOz0zlvg4g5nonpki?=
 =?iso-8859-1?Q?D4SQVrwkW2iKhrb0lxfLI7qlmqZHe3ha5qCbsmwApq0uN1F4Y/WV2hNley?=
 =?iso-8859-1?Q?VIl+5cmgcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: asziZIAi4TIppyGPPKLIUix5H+eTbW8ovCpG8wkG2zSyaFcwrygdreWQYBOM2CXFTYYLS3pY1rBg10UnQXQQzRsic2Xx0nDL1QlCD21BnmYtAoKEhxfLlCyksc5RIGhCbTujNiKgd6zRbEOzppCpb3SBG9sa0gotQ2OPjd4ZwPnlcsqmsOxrENZHe5D6fADcSufYca11O9M+8nNIy/R+zuwiOE9Un1t2aePB8BHbEyVOeq8Zh+gPXbhrlPAuTQFsVKpSUeA15L1/6EEAlAWXZotaP94I0J+BWckA/CHCsZhuRBYw6OlI9X32rVr4xuDVV1bFWihlHeFgT4TLgMOnNA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc44ecac-4b5e-4c01-eadb-08dedb3af765
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:45:43.8053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQeqvC6mm/z2qnpSfdK2UL2uu+Qa8mkCPLKpzhHigSh1id3HcGpKuA2ZHhUOhLmm2+STYLux7nfrRmAU8SDSXcMqY+0hbuQteXC7COwSn0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6639
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

Now that Aspeed2700SCUState has been introduced, update the AST1700 and=0A=
AST27x0 SoCs to instantiate the AST2700-specific SCU subclass instead of=0A=
the generic AspeedSCUState.=0A=
=0A=
Also update the AST27x0 FC board to link the SSP/TSP coprocessors to the=0A=
AST2700 SCU instance.=0A=
=0A=
This prepares the AST2700 platform for subsequent patches that move=0A=
AST2700-specific SCU functionality into the subclass.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 +-=0A=
 include/hw/arm/aspeed_soc.h     |  1 +=0A=
 hw/arm/aspeed_ast27x0-fc.c      |  4 ++--=0A=
 hw/arm/aspeed_ast27x0.c         | 16 ++++++++--------=0A=
 4 files changed, 12 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index f7bd4e8650..39c5977cf1 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
-    AspeedSCUState scu;=0A=
+    Aspeed2700SCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];=0A=
     AspeedI2CState i2c;=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 41dc04e293..cd68c7f1ca 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -151,6 +151,7 @@ struct Aspeed27x0SoCState {=0A=
     AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];=0A=
     GICv3State gic;=0A=
     MemoryRegion dram_empty;=0A=
+    Aspeed2700SCUState scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 7d9fade68d..8d49bb95d6 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -158,7 +158,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->ssp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -190,7 +190,7 @@ static bool ast2700fc_tsp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->tsp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index dddd7d2106..dd6dd0377c 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -435,12 +435,12 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());=0A=
 =0A=
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);=0A=
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",=0A=
+    object_initialize_child(obj, "scu", &a->scu, TYPE_ASPEED_2700_SCU);=0A=
+    qdev_prop_set_uint32(DEVICE(&a->scu), "silicon-rev",=0A=
                          sc->silicon_rev);=0A=
-    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&a->scu),=0A=
                               "hw-strap1");=0A=
-    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),=0A=
                               "hw-prot-key");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
@@ -808,10 +808,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vboot=
rom);=0A=
 =0A=
     /* SCU */=0A=
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {=0A=
         return;=0A=
     }=0A=
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->scu), 0,=0A=
                     sc->memmap[ASPEED_DEV_SCU]);=0A=
 =0A=
     /* SCU1 */=0A=
@@ -929,7 +929,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
         AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
         hwaddr wdt_offset =3D sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize=
;=0A=
 =0A=
-        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&a->scu=
),=0A=
                                  &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
             return;=0A=
@@ -1032,7 +1032,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));=0A=
 =0A=
     /* Timer */=0A=
-    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu)=
,=0A=
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&a->scu)=
,=0A=
                              &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {=0A=
         return;=0A=
-- =0A=
2.43.0=0A=

