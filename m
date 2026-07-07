Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA84C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz02-00035j-MV; Tue, 07 Jul 2026 02:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz00-00034p-SX; Tue, 07 Jul 2026 02:09:40 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgyzy-00083P-SG; Tue, 07 Jul 2026 02:09:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuG04/qyoIrOepvI/sHd2oXLMQ5Q43SfJcEQnrB7/Fx7sbvLfOgLf012JuY9L/n90B5pEG/lzVwRh/2TwcFnSSFkvBVTiUgPnWN7mdGBYU9l7qHIvtkc5ic/iWxCwyeTartDXZxMrEAIeiKNXQYJbK+bdw/hkDmvCPxA6W8Bx0u8uv3tRs1qU1UaAKFOrNQJLLUfcx+fVhFnh4mcffPuLmTl/tZzFe5NlbAPCjeOLYCEvv+el37oTvtzyDM74dFnnLi7iKEjYCTv7bsv823zByHEp+sVV/nuDsyGKGJn152Ju45CJJEdcsNmrmaa8J7B+ghycV55+JVZTf97Cte8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nu7Giip2EAClnOQh2KNTsn1dckYO+KZTwq8mdcgrzk=;
 b=zLztV/h09AcTuNjbixigZBEW6RpwzxlJ79jvIKwxBN5zxYlLJKS/jTVAfKfTGoqEvtUiOWkbxbsnfaNoYQM4VBfwvLsRneV1xGjmmpI7trfVv6+sm0Qd7ibIXWO1K1Asrl3QpDUHaolP3fZ1SMrGulgtUik3pSsR6jkwHGOnXdUWOgdeFqtb1ieGVUOYdzxzqJN36owTTLl0/7y2tqADjLk9B7sh1ps/dCxg5Ct0C/PpzrN+f/Jm2beGppKxDmzjtmD4eHLc0vnav5/cZ49wndHRPx+RfAHPdmkOUI5dJ9WMgXco9kThxD2sRgjrAm8Y/tGUMSYjPWsPkoXeRJjYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nu7Giip2EAClnOQh2KNTsn1dckYO+KZTwq8mdcgrzk=;
 b=a2Zjqo6j6iZSj7Bj12j3exuuKv59w9Ajls4ZdBvmqA7qHf9SIJbD/xIqLTWK23Np5j5bFe/wJs3EHGWEahW6s2XjXwtSEo6ZN4kIawT2xb/k1CSNAjRScG1xLUUYOCIlnSu6fuqtkRSwshrqB8nvWU7iXnScyBMJwVPnY6J8iifQRLjuGl6TLMeR7t3D+T0E/CCcpFbl4j8Fp76diAxrx7O/GshkUKnLPFzjeQdY+m5TPPN3Kd+Y4Kwq+6ng2SFH252MOjUak2iJ+xAoJ4Wk2vRPAG0rCm9TvGOZyG+iuNs54J+xBOhLUDzrRmjOa78zuBhTYwSvy2zid2lqCgcxAg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:25 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 3/8] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Topic: [PATCH v2 3/8] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Index: AQHdDdcpiDmnrtTxPkWEveUUysqFTQ==
Date: Tue, 7 Jul 2026 06:09:24 +0000
Message-ID: <20260707060919.350637-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 84f720fd-5238-4f69-ee91-08dedbee4ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: Vn0GC/gt5FygK6HGJr42ihhM+ULfs4m70TbbpUF8gwyM947iCt2r7yHLkqAnD2tDxLJEpSeqTlomyNQEh7gVQi7Hc5jBU30nguzTjH6RV4IxowgvELRzw/4DBDTnmiykB2ve0UTyexpvnaax6L0LhdWXBpBUNW65GEeDzgWhMvyQ9Exv4oT3/dyQdJEPqo0DrUirobH4l6G/6m7aoZ8y9fpuKNRx2RUPBiP5fiDVjZiSiD52lY/+bL9xINRkT88eQvdunCyjnRkmharaYKZSTrX7ZqOMfm5KtJoZ1cQ8qEyOWGieg6v8rDP1klyzBtybI/dXVAhTDphhMS54t7nHhqq8JPjFuSCy2qt2pFI12Xtt8MYBG6GUaAlo2/VZBOaastkFgwpiy6l25CSaA5TXyAl/vIJJIGSiaqUIAvkNv0dmLRqOjVFq5JbsG0p6ebzvRQY/x4GMmJo8TTAW9GerC3rzvEZKTCcldbLd1fArs1Hexilfdg3NtaY+EpbJzMNWfG9a6n9DeKINGgL04vL7H+F5PL94uTXCm3wbPi91nRnNNGS4LNZQnXQ2DsCwMrUoLFsYb0fQVCFKOwEzDfYN9U7I8iYacKg01E9fg10bxbhx3J1SSmM8rwBz5eHgtTSFnNNf0QeStwJy7uBJTW0GvoOdFtKHhHidGj/XZHvoa7sMppBCtZFONkcx83JKQPtwUNP5uyUsQhokY2sqrmqMbjRJjTthpU2/zqAO+ToVolY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ro1V7bOAL/elmc3qA4J+BinVHvILzQxoZeqXxtqr3tqsB4BOPil3iyDNx1?=
 =?iso-8859-1?Q?8wUbbK36m206qCORc0yRgHiFjQZGoc202vJA16+tZ75tu5nJ8RqMMnjmJO?=
 =?iso-8859-1?Q?p+hP5nIik1VTEws8XIQhiqE91TwrEq3tAsCkGLB3S+zWNCf5vkTgMaLBLx?=
 =?iso-8859-1?Q?Wr3wXm8COjkOFQlYALroGiGZiO9V543PB6kXI/305di1LUa4PYVVWpjSUM?=
 =?iso-8859-1?Q?z3koW3stoFiBYehPlsBDlPNw49CeoU2KA1Z0Jzsl8UoBxRiFIQkcut40zX?=
 =?iso-8859-1?Q?oZPcQZuSw3pJ6CbOcoATEB0ftckTctxvxq8zt4tBOkj9MOEroeXmU+9S19?=
 =?iso-8859-1?Q?t22cXnmNAg08/ewDs66wCxBGQ/uR24AeGjaFyjmIhcm4cUmowKnttzIxNa?=
 =?iso-8859-1?Q?HKy/RjBxxeREGFoJBVUdOlZGrNtV2drKtkDws4GM+VFSJK273zXMOlP7zA?=
 =?iso-8859-1?Q?/JpcvRWACG6jYii5jD05M/AKuUGQ0zvFm3poJtCPxrRbztWGrKRCNrOgb8?=
 =?iso-8859-1?Q?lb8kfhcoUemEChntaH1irOEfDyAOyPcyGj3N5RT/oN/2XPPd3z5wxTHgHm?=
 =?iso-8859-1?Q?I0sbo9uO1ejxDGDU2mIQckuopdvuDtTf3T+hBSWu0/W1iiY5ep6HlwqWQC?=
 =?iso-8859-1?Q?MmsPL0fs2CwDqFpUg+Cq6k8TjHJqkIAHpbZdFe0zQYjjq9o9XPg1m/5kKq?=
 =?iso-8859-1?Q?RGBn61ZB9FdhDmoqAlc9qK920Z4B2RPuKRuLiKB1qR2kLsAwBdaEOPWzgC?=
 =?iso-8859-1?Q?bQ0+DOMeGQEKONlSkI/dLBUpSTO9nwVFKDaNwFR7g81/61iW+YRNmqh9ft?=
 =?iso-8859-1?Q?ClwK3DPlTCsNt+3d8kqt2dv7KM6BjE2ov6dWcrkFQD4Uj/wvYh0aYmNU1y?=
 =?iso-8859-1?Q?3F4TpqwxNmtos/jUCbZI4ZtlOaNYKMobaTx99pMQmtOOW7s2F8y5Rrpw6o?=
 =?iso-8859-1?Q?93lwYSU6f6sI/go/pBHyFbTVhsFLkU/3B1tRueVr9Nb20rwQdv/CkQPtom?=
 =?iso-8859-1?Q?wpx//JCIZz/LQsManqQjx02E6MAYy0afIOt9GgDO0t+jDwYKkLulayLkYZ?=
 =?iso-8859-1?Q?j1cU5qvc0by2028Jir3xYk4KCYNmyi8LvMy0WXx+mjuwedTtEm2/4AexsD?=
 =?iso-8859-1?Q?Nz3RKwh/13ymOvWzou7KB8V9GD/qVtqkGBP31g+/zBZP4pL/FOUpSwcR/9?=
 =?iso-8859-1?Q?LNDjwvxAoxuNnTtCf9e+JRNszip9FCmZhxCFoFgBYF2z6n2R0eF3SgfB9m?=
 =?iso-8859-1?Q?mkIprFPmFV68kFlUwDwXONpk90qMR537fmu5X5jUJ4l7I5Y52JMN6scYBt?=
 =?iso-8859-1?Q?h0aqfL5ZhbzV0pS5xZLCUaxEJIi9THvh7jj1UodFcKbW7ZssU8vQ+Y9ruK?=
 =?iso-8859-1?Q?bT39naNEpl98fETTPNi81glVBN2w5KxKbQMLCAfh2bEQP4NCUvpcJ/gICK?=
 =?iso-8859-1?Q?AYBfbD1r3k/xDDEj1DNIJeyTOSNYewQpK/VY8YgVxsrKIVreKHFnXF6CT6?=
 =?iso-8859-1?Q?/Je8p5wd6zVY8UBABKA8bTJWIWfg680Xe/Zo60bmmCiDBxXpY1L+YYaPRS?=
 =?iso-8859-1?Q?KQjOnyCC35JqGfPZG59/vlQEn5CG7U5w0r9JX8oziLEDDx+vrNa0WLjhFD?=
 =?iso-8859-1?Q?fvELpuvkXltlR3F33BKbp4jnxB0ucEReiDuopO0zqDxDlmY/+2Duolz5RH?=
 =?iso-8859-1?Q?Kf0LZko6/6SWJVGpwu109LRHzBkO6ynewMghRH3wslihlIH6fQH94B89Y3?=
 =?iso-8859-1?Q?ExsSw9RfPADmjEWRx9cvxItqJ1fFzwwKDd6vlZEs0GXxNIutnbfDMTyjJ2?=
 =?iso-8859-1?Q?seV6nlWDOw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QBbn/1JpYSxLenOZNTyykKrdFWaY/jAVrQ5/2Gyr8NjiW0Phi1Fc1KAHIEw5aj6A1ox09sIZKwPBAK5JynTfg+c0PyL01LY7+nFCSmKM+Lg7srqpxPuMTiFeDWd8DoFxES5xZ2DfoI2d7RYz/E9/bPMygefiItpxmfcwj4nU9yMRjr99igpg2dlAw+BXUFAF0hrgIJ0XHNr5JhMT+JXM9LGLrnENGxx8WM/MN2NgAP4MHg31Ew/SCWUAjgIB6L7WPkt2yLZ0UqsxPAPkUu40jz7BeunuCNLId45gJE8hxbsluUCzdeImFAUtFTlOlyrJlZOvbt65gcAMvtXsnuXVyw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f720fd-5238-4f69-ee91-08dedbee4ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:24.9530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRUF0neMfDQIUPtmlVLPHwuTMK3oY8n0cAa1kOFzGY9f6q618aIpfEQq4DqvU3VBD2KhJ4KooBT13lgB6GXZ+4lYX5RKBaxJHfn9WSQSGrU=
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

The SCU link is only needed by the AST27x0 SSP/TSP coprocessors for their=
=0A=
AST2700-specific SCU alias window.=0A=
=0A=
Move the link property from the common AspeedCoprocessorState into=0A=
Aspeed27x0CoprocessorState, so the generic coprocessor model no longer=0A=
contains an AST2700-specific dependency.=0A=
=0A=
Also validate that the SCU link has been provided during device realize=0A=
before accessing it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  5 +++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 20 ++++++++++++++++----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 20 ++++++++++++++++----=0A=
 hw/arm/aspeed_coprocessor_common.c  |  2 --=0A=
 4 files changed, 35 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index ac58a5f424..adfc3c4512 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -20,10 +20,8 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion *sram;=0A=
     MemoryRegion sram_alias;=0A=
     MemoryRegion uart_alias;=0A=
-    MemoryRegion scu_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedSCUState *scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
@@ -52,6 +50,9 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
+=0A=
+    MemoryRegion scu_alias;=0A=
+    Aspeed2700SCUState *scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 68a8ab26f7..28bb59c8c5 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scu) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'scu' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0ssp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0ssp_irqmap;=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index b8a4f7c91d..f5c4a02161 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scu) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'scu' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0tsp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0tsp_irqmap;=0A=
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor=
_common.c=0A=
index a0a4c73d08..43026d2a55 100644=0A=
--- a/hw/arm/aspeed_coprocessor_common.c=0A=
+++ b/hw/arm/aspeed_coprocessor_common.c=0A=
@@ -27,8 +27,6 @@ static const Property aspeed_coprocessor_properties[] =3D=
 {=0A=
                      TYPE_MEMORY_REGION, MemoryRegion *),=0A=
     DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REG=
ION,=0A=
                      MemoryRegion *),=0A=
-    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,=
=0A=
-                     AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,=
=0A=
                      SerialMM *),=0A=
     DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),=0A=
-- =0A=
2.43.0=0A=

