Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DACBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz0G-0003PU-KV; Tue, 07 Jul 2026 02:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz07-0003J0-9C; Tue, 07 Jul 2026 02:09:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz05-00083P-9J; Tue, 07 Jul 2026 02:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/zXIKOH7/YA1BcTMZ6bEowJ8iVA8ETR7Rmn7jsgYCRAV45stAnVl5jSsqnlNN7Z9vpgFfl4/mKZw3HTcdQGPvWAoOhWXGbhvgFK9T+/ZZznwJHKwy3Sq2Yo8Yne4oPEFnjDQyfS+R1ik7v5rShvfRFpaeDJ2iV3iGAFfYnMUtecKfibHypRz9jpmq65ggEMQeWhOaSoOAgZ47X/FbZ0SjzbUt19kZNxERzHvFzBekFYguKNThNJ0mZwTZIZZYhSKPn2ngdg2hMTaWUBuzPKULkfn+N/jltAhOFqOm/O1IptwxGr5C2GWxUghZQ7HPlvryN9X2mz3TgS/bqEURVQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+f7PqWCPtwuTpPUgOmq0KYh5EsYIZxbITF9C5NchAs=;
 b=BW29+OOd1xRy+yk0JGPTx+/bCTGbKeMb2nJgsbwFoi3kQQe+sFbThi1I0iiHpeMK+YPkFfruej3NQSt+3KbADkSaZdu0a5Fy/NgieReRuv3woilTKgktHSC2KAuH6p8m/RE9+QW5iLmOSL1jy0Dal8WA1u/XF7DemjBbiYe7QoXFziKyr/tRrFe09wsrn1CH4CrfnuBMLaj8pU/uF7pc+N2+O00hQmVESjfUrjoyG99j1vEB8jAw8/+ptuOap+Lo+nuFk80ii/MawphuMlPyKSeytd0uDbttNUd9JnscHuie8+ZpVMMK1/b3jNi5a5CT/hx042m9nILkl/W6EwN9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+f7PqWCPtwuTpPUgOmq0KYh5EsYIZxbITF9C5NchAs=;
 b=pSEP9S7628jtTxilGj/7Tx7CkZDFB0lp++HCaVM+xoezLWVlSZ7saAnHAdPbN6ABVHsf5enPShLhjw0jd9h+KaBca9WssuNWhogJycIsOkzIOQMMBsKmcGLWErz0GIqhAJ17HXkpbZTEV71dFzeTq1hInqGOJj9pC0RAi5LnHP5zXFbZ57iBqWaERLvhZZ/W++c5IfLWe23mnUI9vufMF7Wa2OyxUtfCCLIKL5xnrvnoZSjYnBtBPjXmnKMqcsACUG03iBAwDv9DzgLZzrMu6YFVZ0Ioj1wlSFE+qVXzk80YaYnTB3Hfc5ZkjQsY5orNFgqPPBws6pr6y6iQqzGP+A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:30 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 7/8] hw/arm/ast27x0: Share FMC controller with SSP and TSP
Thread-Topic: [PATCH v2 7/8] hw/arm/ast27x0: Share FMC controller with SSP and
 TSP
Thread-Index: AQHdDdcswp0c/XUQr0+u4uoEoJqq+Q==
Date: Tue, 7 Jul 2026 06:09:30 +0000
Message-ID: <20260707060919.350637-8-jamin_lin@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: af6655fe-5081-44e4-5373-08dedbee4f03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: 5bwl9hbz+YsumgIipbFrnF+oldWMfQxIGA5t+BinMDtzumPAxWO2YYcu+dB+kyB73FUNtFODsIQlw5ZTv0pL7N3aRaFuoEZP6D1cqYAssB5jwWQv4oUC9eHjbMrPFSFh6azkdl+gzsMYMkYLDdo9zUhVYhL46mSy4odZy5GluH5o2kPxQjIgnwe1u3heSGD/1w3K8LWmEdPSKOTUvwLdpVaP2GgUaRMdZOlqp73KrLHJRbj7tY+bvCNSpznFg8LyA539Y6eLaCqHC/uCOJNuNY+GScGg7hGXWhH+Qc+dFxDmgLix6drGR67OOHCahfMNNJvEl/q6OYhHpwYLofCOq6ztkG348banraqHJIkI0ldqeJOcP7r4LrkzB0c7+4xsCooE2lLb9FZRJwU9qs/H7sOzySK0q0bzv5fujj1xXmRLH6VNTwPAMKkSNJG7iTwZgtE/4XpQrWit0zpIDmNhoRyeLGkjh2cvPKtW3ai+3wN/wf/J8fhbWIXe0bAE1JnwBG7xb6GeBo9SwVSsDzyk5e+SM1KOL9CVjcrSyYLsiE3nfb0R1fhrKE6EuJ54EnFOKLWVvHVS/q4VJw6/aWlT0I2v3wd+N5yiyRvrFLaPTDOTbfKiuFU97jGqCqg9bDFHsQBWGynexVSdC4oD3pKlwvY3LJoC2lEfXvexJVO49aNVEf+B7uCmNi8kV9tF2WrvyG9UtzD0sGafyFg+CYIrOeinf80ertbZnEkJf1uk7+I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?55h454XSUyL8lr9aS6afMzzIy2kUWWcrQjOmPBGbdgIOk8AbA42jVMNo?=
 =?Windows-1252?Q?Hiu2TwUVAr/95sKceKM9bDcEt6dXLq0N2nioOsRAZdG3ciSb7a2LioHg?=
 =?Windows-1252?Q?BloU4a7+CWr0Oc9jLfC6Q1zu0tRxtp8LgNumDIA32Vqg4SwNx1BO4rD/?=
 =?Windows-1252?Q?PA+UfbOsw+BA5gw2mn2oGo2yjO5qoHUYWFp+gvt0lDPcmyNJtyUNlOGC?=
 =?Windows-1252?Q?1+2x6F0w9g8dubaL+ihHt3FCD0L91FtI5u+LDXH/qTJ9v97vpYfdieVP?=
 =?Windows-1252?Q?aqpSVpcFnZniX/gM/AuXDw2awO8nwZgHCGsI9uUomFRP2eRPvE5SDopa?=
 =?Windows-1252?Q?S6X5eMAYy8Dw5JBR/ozdsD4H4AvGPxHUZ+mc3hucLQ3f+s0nTBZeOZ/r?=
 =?Windows-1252?Q?UM2fGwdzyhBprnVw8LR/P2yagHfSKT6tuNiWbDzYL+2p/tbi5PwLRaTB?=
 =?Windows-1252?Q?6u668GxYnS1msH+NFFRR5TOq4TWsOiCZ3hyVFW2cBGJwvL+n6LMWpoJb?=
 =?Windows-1252?Q?4h2j9HBK9gqQpb0QUoAqqVoPH9n7Ysk9G+FnWVBJGZdKciLR6mKJRadC?=
 =?Windows-1252?Q?Wk7fE+s1AT6e9OY0bcBp8nUjp/hLbmCcCfVRlJJryZMMEf+Q5RBe5L1z?=
 =?Windows-1252?Q?yW3BONcFX70IWXeOMbmDAHIJiF56ujeQaR00uXEgSHPEYAO1Wh1GpxJ1?=
 =?Windows-1252?Q?W7hwK36dgLaN5KEolTMB4uHSQn9jgsmoLfDharP78Z2lAXvDSEk18yIS?=
 =?Windows-1252?Q?NQLzKWSyPcSU2Wf9Jw0s+Tt/8SanA08Ke5jsHfaj9bZpdPXECDMf3eLF?=
 =?Windows-1252?Q?w+nessD0P+KhjLLrOt9y6aarSisLHDUELuLCbc67SFsaNX8bfvOZbjgz?=
 =?Windows-1252?Q?Gq9wSvbJZfaQ0oE4k5xjzGVlOO4fXyIIgObC1x+BLV6PbFTvOlY6vN2M?=
 =?Windows-1252?Q?p9DE5V7adSh22exi1gypK9kL8TXQc3+6DSkUKDF5QaujWxLFs4EZS4Ke?=
 =?Windows-1252?Q?XWUzuiXXSrrHOtBv3Tvy3lBwSARv7um5VmLt+dTBLhe0bxubLhNe2561?=
 =?Windows-1252?Q?hUB0u1WLDow0BBjL3xscbhqN2sfh5vYqUYmcT8IRi0KPQIvmB7rw1G6f?=
 =?Windows-1252?Q?wOxk0Sk+3ewKNjZ/So/GQ8+q3k8NuRYP6pyT9jNI6D5vLgZyWi1pZqS/?=
 =?Windows-1252?Q?oK+gPMYwNMwJb64ooWjjOm3ATy0qAQs7ZS32vCygQybEj3aR0TsQTGoA?=
 =?Windows-1252?Q?fRJBxB355g3LlTfBA4GdcKoAon2X0vRkoEKRM7WasyHQPfUtK9gk3jIN?=
 =?Windows-1252?Q?GmgJiUjVsAxBJaqAcNEgSlbPy7Z4NWuB1bs/cYH6Gyrw2zt4j+xb+8pR?=
 =?Windows-1252?Q?rJWZxTiaV/7elQER5E9OIo3AisQfn8850hpNSHPUa6p5rA+gEm7cqHvk?=
 =?Windows-1252?Q?s47C+bOb+gXAZMP4F2XSwX7H/Xp7OiSeAGeyGiZB9pDFon5Ws6JNFUnc?=
 =?Windows-1252?Q?Ad2nDCxpiD3VEav1mcERVpT/yeQZypPK5gx3YwEjsKFegcnuHkkcLY2A?=
 =?Windows-1252?Q?KNfgEd+EjiM2oqihlfM+H93QTlDmh/CGB0iZ4NvGBtoo/cOvixleePER?=
 =?Windows-1252?Q?14Qvv/dFXnKEmXroKwmqHLcm1LrseNlCgDlZdvXk2Q8ZEQl/RkdaJKFd?=
 =?Windows-1252?Q?P2ut+4gAZ79esERnynjR2w058cEWF/d0W0ZWUAj4R5CKq1R1ub9CrMF7?=
 =?Windows-1252?Q?bfmurTMOoB2A4SN2EdnVj5WN03piNUrZ0w5zkVIkp207yiE9RwDa/GnN?=
 =?Windows-1252?Q?XURhIC0q4bim+qg6dnp0AQoJzAZO0vpsQd4SZRKDr2v1MhV7z2kBX/R1?=
 =?Windows-1252?Q?ytmpO04CPDYVXw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dCUf3FAjVP/J3oPgzr030Ml55ZtpGA45ZDlIJrblpZ4Wo26k3nvforLLt+wgPJcBMVKqCJQmxNU6/8GWJZIlrz0QsmEHJTLg4KGhlGllFZL5Gq7N4uTruiB99aRFE6jma6q4JWofjJSiHKMvl2GFc9a5AMCgaPQH111C9hcHgJlaEuPY7ETsDc+dcl23JlnI6LdEigEIZ36jyW1cLXZ/xOGuHbF+XURLBj6Y7nAz9uS7MXeTXLHw+tf1KiAA5Rhp60gLN95XNnxdaMackHzK2XvP56JS23pE2tvr1bJTUMbnQHIxcd5PCrZologNG7Blm3yXK2ErlogQcWneJ1tzmA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6655fe-5081-44e4-5373-08dedbee4f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:30.7286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7BIuFQ8W5fcRAHHN7gJGh3Xo3OqN+yfWuAN60Ij9A04uI848lQ7S5M48Z8XfoJXjU+/JxoGZ0YAVY6WTzyhTcrmbpAtEQ5fM5q3jdZCskg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

AST2700 provides a single FMC controller shared by the main CA35 processor=
=0A=
(PSP) and the SSP/TSP coprocessors.=0A=
=0A=
From the PSP perspective, the FMC controller is memory-mapped at=0A=
0x14000000=960x140000FF. The SSP and TSP access the same controller through=
=0A=
a different address window at 0x74000000=960x740000FF.=0A=
=0A=
This change allows the SSP and TSP SoC models to reference the existing=0A=
PSP FMC instance instead of creating independent controllers. An MMIO=0A=
alias is added in the SSP and TSP address spaces to map their FMC access=0A=
window to the shared FMC device.=0A=
=0A=
This ensures consistent FMC state across PSP, SSP, and TSP and matches=0A=
the AST2700 hardware design.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  2 ++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 16 ++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 16 ++++++++++++++++=0A=
 4 files changed, 38 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index b77ea06e7f..23c3b97f06 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -51,8 +51,10 @@ struct Aspeed27x0CoprocessorState {=0A=
 =0A=
     MemoryRegion scu_alias;=0A=
     MemoryRegion scuio_alias;=0A=
+    MemoryRegion fmc_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
     AspeedSCUState *scuio;=0A=
+    AspeedSMCState *fmc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index d14a42ebca..058cea42ed 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -159,6 +159,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
                              OBJECT(&psp->scuio), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -191,6 +193,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
                              OBJECT(&psp->scuio), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index fa492f1797..e03653086c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->fmc) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'fmc' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 3a98bd232c..39ba062a20 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->fmc) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'fmc' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

