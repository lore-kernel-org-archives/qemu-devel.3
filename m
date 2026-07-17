Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D81C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmB-0006mT-5q; Fri, 17 Jul 2026 04:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdm9-0006lm-TQ; Fri, 17 Jul 2026 04:18:29 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdm6-0000Cy-I6; Fri, 17 Jul 2026 04:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzjMG/TKYULvzCOsjhJB7Dl2zDi084b3AqPukH3dZCzFzibLTAZM0ENxClOTmsxs6pQ3BsQka+p0hoR6UbwQ1Tye9ImgUgal2nHxKUqtAxlIBohJOFVQSfRNfhROubLjaqOcxCJqbXjMo7wz0Hl7IaG+MB+F3iMhIeBd2wMzD6cPkje+2HZevSjZSGUBbZQRbjoImWnK0Keo56x3E3aMsb9RXzLXYf5wHTEnXGgi1+MkhO4OYpeeC9Pp2s+/p/pGNCtZatITMa0UrmZ/miLuskxnd8gVrjStXUPyuIKjHIuH1F3yeSon4tcV88TVxTYkl0CMN5UqzXj+3UGZIj5nKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPmBPJkX+8OKOwDgcLfQFDkJ0k+VudPL4dmg7u+qCgg=;
 b=ULY9wLis1Z5eY5x2PYwy1YZN8aTOm+ESu7Qf5jAMSsLZ6hrm59VKxLH4kLGsyByocyTd1rI5YdOp3aWRkKTjHw+bJG9fzIcj9DEXLoQOkXHUzQUU+KpzCxHIyavosatfHQdT7swPXY5e902diamJheEr1buAlV29ASWMorQ4y/ReXOxsTlvn5nOc2DMHYGjTfsUFRAcn6wTsC1RgMaxb5+2fuxQfH05004BPyLuAV8An9XfX1e3SJFurNyDe0ME9svJnGLCjVmnfjlBMvK7dVZ63fEi/8cHe2/ZtBtEQEokbushZzm6slpEVYcjVWDKXLl2d/dZRgfnK4rZSnjkeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPmBPJkX+8OKOwDgcLfQFDkJ0k+VudPL4dmg7u+qCgg=;
 b=pyor5k1f5fCd4j7iBzYc3bnrhg7zfGKpg7eurEwwmDolBOWCb1B+OUwVoz10+VupVs4JnXjZSLxJ0m2tAu5x7MXF8dJW+Wk6RIaHfDGdPBJO4IOrKoBspJFw3Vf8WSaeRRSMTlv9ntkFQnROlTFflzN4ZkWjtAPaJqSYi+J76GnXXhD8TYKiSN8mQ7VgYGC/Kwl2LaGFqwFLhD1LC59q0U3SpZCNHEFKLCOeHcmnc9S9m4rPWQ6oYIu21sS2lAdnNwspDvVhlmsjALqu44LOTsylNY8vkKL3PNTRzcGi7UXz/URT7Pl1Jv38v7PWQ6HqviiRihdaRKPeCEQb6+cixg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:17 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 3/9] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Topic: [PATCH v3 3/9] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Index: AQHdFcTSLCy69bQy+Uusmo9ELoKJeQ==
Date: Fri, 17 Jul 2026 08:18:17 +0000
Message-ID: <20260717081813.3407862-4-jamin_lin@aspeedtech.com>
References: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8339:EE_
x-ms-office365-filtering-correlation-id: a3b3b00f-b5b2-4918-1250-08dee3dbf4d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: qfECXFnqQXwHa4w/DH99CfJrOAffVPXyiyd/11nwVfFBd8jfojQyqkwFEMqrUTHA2e69pxgjxevm/w2gmoE1nfu6FK74TUgZssVJ1CzVmsguOSOPp6fyfLWrUSD/1YGbs/Swg/4HCBSZaPLxQuqB5dLWDoqXlteGVz3FdAFRWqa29fp+CVOCwjyKKMMIm/r22oCDUjsvcchcoj6f9TFbSbFEwMY0usyVWIJOXQ5jZzucyOd7ScErT2MvCrdcYgSysZ8/cr3TGk3QyS4wPEo3oMHYM5iHWgTh2EtliskrV0jNb/GjNmygn4z0q2yRTOW2SPWuagsE4y4xvzes0504ndDXJHcvgLpR+ue225ju/yXK9zUzYFcnSrYuHbSwGSXU5/FAe6+rCOqAAhvrB+7LuYO9k5H6J3lsu1uyktTOxPuE/YgfIPcbOsvnWT4HwOBTglbw7RpxcKB8vfdPJ9XeNb+Z1sGLgel5aoAoOvH8Q+Ft8JVmql0s0IkGcisCJPX92ZcaogoZ+ILY9FAqgqEvkHKhRgY7ZwR6dkdvmuL3TF1zFTLcOoWGMPRizahphjDKVL+pS9A6ddRawhNWz8yC/I2jJuB//odVVDJH4gv3UUx6LlJasQf3hzg/NW+vT0dp7ENtHHOtIJA2m96wAhggR9Vkm5a9X1LN0peIZtPkFobDY74kDYhR/Jke6PWayBC9pHfOfQA+xImll2d8CSRCwnNSJUVOFwDZ5BzCr6JJJHY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lCEFwuKwYJb7bDZSnHQeKZ6VwwxprSYDMDMRDtJ12GpVxivrOJ0d6ATIt/?=
 =?iso-8859-1?Q?6QQy7azceNGXWQpg4SujJXxj0yFHycDBM1l+BCx+YHRCbLpsjopYTbvdUt?=
 =?iso-8859-1?Q?Kb7cFg3UtlIx5NAv1MrFqZCANsMqEGt5wMVqw8oDmxpmMNigY4Qp1zTUlg?=
 =?iso-8859-1?Q?QS4Quaw566fxXrmQUBZdTwxPkJMeXMrTQFAX2EYn6uMxXUWLb8n90kCfBk?=
 =?iso-8859-1?Q?bRt1xn1fFX9vq4rPsN3ny1MUAXMRgNS5at3kSMerQyRSoVSG7FFF/uNCXz?=
 =?iso-8859-1?Q?uzQXIHQO68fKHcJnLrm49m5zpXEAZeLg0PQPHJBMwPPLNxvjvMLdPe6U1H?=
 =?iso-8859-1?Q?G54hgqNZLNVxihSV7NRbtlhAGFHT+G0ICM7SpBAWgEZqEmMgHojv9oCMBP?=
 =?iso-8859-1?Q?b5H1/XOBN5+9/u43TZN09xbk49g14dZ8e2Iahy28rpouyRI680L61Kv/JK?=
 =?iso-8859-1?Q?0EJmlC3g4KFNUVTZQaIKA6WKWwIDsovCUvLpS9w2ca7iz/QuXetqqGerWS?=
 =?iso-8859-1?Q?hX4IG0xLiWhCsUKHAlVN4DWrnj3IXvm/WyLToJeVG2VYWBZ1jXDqUZOEzC?=
 =?iso-8859-1?Q?MSFiiRFX78xIXE4D6QvGa2JJddDcZSaYXPG+9b9dzeZMhZbUThiKCopONo?=
 =?iso-8859-1?Q?hA7GsLTYHjXSpBbgYPNc5WVRmxO8WxvLeO3Hg3+CeU0aXoF0T0QUobiMdZ?=
 =?iso-8859-1?Q?Yr4fEvFnSFcrS5iPppGT5GS+gsfTJEsCVB6BWcehByvxlrEHwDYMs+hxlP?=
 =?iso-8859-1?Q?0LWceuaTZZXRyu/obykgEJtUzUWmeYTxpoMV4KpAbN1vtIctqYAD6sWgmp?=
 =?iso-8859-1?Q?qNOrWY6FHwvgOez6FL1aiC7DmZATDKhkb0wGh3K3QDHtpc5/UkcAVXd/a6?=
 =?iso-8859-1?Q?ZzGPiAkvXYYqtHY87ePtpGVVH8ixBYZndzsrnaNxzcGAxrmkDlr0+t6s9J?=
 =?iso-8859-1?Q?HUxxkAQVzTM43ltkKICzvmrgPPAWm0ilKPSOG/wGmSfYtvSA5/hwYoEsJF?=
 =?iso-8859-1?Q?yC3CatQYnxeIN+ylGdLvFjiiH5slXs73UWPZL9gZ7lrPpTi3TCIGlGmlMd?=
 =?iso-8859-1?Q?cy81jmCebtGYgRLPPhloLUlteQw2VCWkZ7K4UhEsLhzh3zpdYVvE2hcTn0?=
 =?iso-8859-1?Q?tMcmQcgxtotVF1Z3mzEwdVvkopMMjWyCNSnQPBBpoMxk2CiiQtIxkDPAk5?=
 =?iso-8859-1?Q?v00mFEwggKUOzYZUws08p1zA3SIPTUlU9gWxtfAl3++7zSDXiMsibtBjOr?=
 =?iso-8859-1?Q?YloMKDMy6TvPa5VYC+RoEkShGIjQck93Einbfou/r8autsETBah7P8S3Iu?=
 =?iso-8859-1?Q?WdBb8nLUeYb18bOKz0hWOj5zdL3rlQvsB3hhoxPFKARrFZJoTuLTl8mENk?=
 =?iso-8859-1?Q?TdxWm+Oq4D5+4M/Bi1HLPZa7uwxDtrm8KZvHXY2QhP9LEmBSmJkv0+86G0?=
 =?iso-8859-1?Q?ToFEO45GIa9ltuAWgYj3ci7Oq30wKsQ8un8GFVp795zih2CwMw38b6FBbY?=
 =?iso-8859-1?Q?NPU1OQqH7sNcWcBhCm7Y1tOlrJG4PSnVdWY3oRzoq/OJuvJcKuhic10Ooo?=
 =?iso-8859-1?Q?zCv+J6mRFO/YUFLPBxThkilVT+Eoyg+DU0GP2fA43fz9tSnmkKAxq7yk9t?=
 =?iso-8859-1?Q?lKhqo/MppTvJRq3fLlWnx6u9lmFUp8/7IpOPz5ykgyWYxKautPqi61wUqF?=
 =?iso-8859-1?Q?yV7lJG/CXkhOh49OdYDZvb8rGS/pyGTecNcjaSUuwH88ADqWmqyWi7ACIU?=
 =?iso-8859-1?Q?JHbT+5YAfVIHezyXMDmKWbKkBjrH/GRaRd896CnY71bvFfThMLXJ1JHUgN?=
 =?iso-8859-1?Q?HdtQLWiL9w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RSt9HeVJrtcx72rCfhHqleWDJNad140XoetqBqkV+vpwyeA6cysJ8HKbiYXPYbwdh33Nyzwk+CIVVI5x4ANd+vKBl1j09VBuknqbCxmYZ6pM21yG9kBGE0Fhx5338ERkpKygpxVHhGzAeMVp6EBnO0RF5Ywib5JUPdx9zwnzQyPrQ2l73GURW40pNwU0+G6M3D6Vqz8xCEzVjLloK4ub28Nz9VLpmJFrTHJR6ezHeyQLn9LXMJ5GH9McwgOfHbJvtlILGVp14LtSnPDMfaDs0zlDj346ZLHgl/CuoDL7OMxD2qnahCGXa6kwOSX/nMNaVrgPxv3u3ZOrw00SmparBA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b3b00f-b5b2-4918-1250-08dee3dbf4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:17.7462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YzL6eAYEvmFCG3LZ6wmHLC4ssAvvGSVMRpuGrx3merQY6dcDViJip54LRS4z2IhYPQdQGMfzQulyblJdjVClLyauVIoY/IRIRKyRljakdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8339
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
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

