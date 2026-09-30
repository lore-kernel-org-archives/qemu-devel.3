Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC81CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoh2-0001ui-0v; Wed, 30 Sep 2026 03:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogz-0001u8-K0; Wed, 30 Sep 2026 03:25:29 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogx-00027I-A2; Wed, 30 Sep 2026 03:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8/sc+mQtIT8uTBPb9V+3KkEf8Xh+aiuJkgSe4hcK/k1IpJa6NK+T5qr1UITpYVk0N/CXdfqhduImnpG3U10PMGCW9eRrBbI/eK3iC1OBUbR2Yli4mKTRjcYWFYQm5XWT0uaZou/8Jg0Rkyck2+cTnU/F2ARcBD5kr9I1Lc+Q/7uqPRcPkt32d7oHuzdQfBGN7TacR8/BG8OCmO0S6UeXtcetE7rhpC+LgXSK+G6dsye1uPIAkvUHVr7TMZGS2wtEGse+v5SjPjHjo98PF1TILVxQH098Uax7s2CH8XePJ6a0Y5F/s3iisFirv/Ja7qsETUxBs6cernRT3RAbhHWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBw00OOwbOoaPXkCTxdHXcTyKSa+MFBgYxlcYASym1M=;
 b=SagbM40Lo1I0BJv5b7qktb89/4S8WmqL1D7no2hhv03V36K9qpH6y1SalWcyjh8oW2Wics0IiNdVGIbjZ9OyYRnwnMZks7RwK191DzEZCsdcSNHRDe2C2dcJnHjOhfXWHEJrrsDsGD1lhyrDE/pL/2DMol5TEPEj2sixS9J+OI2eneS68pcGUcU+AAF1QEMfXd81RdJ4hKzc4SH+BlTgoTnuIyMAs5faramiwV8Y9vVwdMx1jbIO0t8d/Y00qbHK9eiMygJ0KrCay6WY4OpkpRDdEF2Ut2QCmssV9Pkd3r3iTSR9rLuh0PX8vBOaiYJJNR9aYbjX+UTTYrUsKYMmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBw00OOwbOoaPXkCTxdHXcTyKSa+MFBgYxlcYASym1M=;
 b=ECG/weM8FtRGGzQdLS9fJG4gf2SlGMcboRWYCHN+q1PPt7mNVZ+hmzcbxFFaUgosrK7H+xhjU03hR2H07q7UiEJ4t+rHVV4Qh8MP/aEoqShXFyf+XQ0603Fofltobpbeci2PkgVHAdNL6C/wO2phtPyon4X6+vnIJgCq2+6NTUCxHvmnxmOF2Jtc7m9DxbYIlCxeEr+UyqNZCftF2yupK7E93FCF3arxLiskXF1kfwOu+v93bdW7kLWv1/+Ffr7AeZSOsx3vUTVAzqCI9NFWRVa9r4UAsg/+8s/Gw1CfCOjoXMApXgM/tZd91DSWZJgY/mc3kDTmStfgDdqOhMVHTA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6451.apcprd06.prod.outlook.com (2603:1096:990:2d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:07 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 04/11] hw/arm/aspeed_ast10x0: Use unimp array and table for
 unimplemented devices
Thread-Topic: [PATCH v1 04/11] hw/arm/aspeed_ast10x0: Use unimp array and
 table for unimplemented devices
Thread-Index: AQHdUKzRJ+J/yCrz9UCxEBMw+L4Fkg==
Date: Wed, 30 Sep 2026 07:25:07 +0000
Message-ID: <20260930072501.2612119-5-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB6451:EE_
x-ms-office365-filtering-correlation-id: 84a5a6e6-23ea-41aa-9e02-08df1ec3f407
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: axxJnvyrAmiv6U7ATl0BHnrvdfFp5+7qup3cuDqiNaKbCWjPXUb7k+Kcqva277QEhy1mgMllG9dpQHqwB1k759dQl0WCCLgZBJqe732DMT5w7UNRaCo06PmUtDTb0o1GjLTyttbirT3KgrzhvVx7cksJrdhkMt2uMc4iK9Bs/w2Exhfi1uh8RRyb8vzO1rzR4RCXCQBdg0lYtof6pXWimjkWlPK7FPrbwTGV0AoZWYcR+8PBxEv3JxtOySapTOjYzDnGlO+C1Md2wIpkieHDa3kmo/ViXCjjiJlhErXzaLoXkWILjVNrit9a+QmQ6N/ABzKyO/2kymaTGa4niwWgkaEQ4W8ccA6/jEfCI4WNnlB1nl3R6Z8DX9pvEc+Pew7qeNIZIc+Ld6Hf7gErSOl0TQkIbZVCFgS3eZCsftmMnksGqTBYPWdOrhh//ZI/l3VBXyZM/RhvfXOG1HZkvZ+bqnWWmnz/aIiBppALK+3VbUlUaGSf25WD/5s2KNwQWRGGIhRdqs7J4XMG81bKxo1GsFuTc1tmtq2JCr9s3O/WkemthwCC4w+Toli40Pk95BKsZ0gyoYbnx3Hg3vH9L2/jHW710K/J2KES51X9nUonwpBFS3slukxfPvcBKEWSq2GhHP0e/gxKphsN92vV6qhngjQOZ5fpDqhmlGbQkuvHx8BgC48L1YxOQV6J+v9cOyv7Tq6TyfEtUwXVAlfeUhdqlrVMKUOrp82LfvT4m4tZ2VM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FfKznhehpd26rNogyGB8y5vltmuQkrzO3SKTDf01Hxri3WzNZP7ALZTITI?=
 =?iso-8859-1?Q?qQE3zpF4bo58/uTp17IEuP7Z3Pds0EokXxR4pOD5MzEtxcxk/D+n0oDPM2?=
 =?iso-8859-1?Q?US76xyp5BMwipTSLW6eFuwvUM2yKstzy5S7Jpdjtsmx5At35Pgjm2hoxt7?=
 =?iso-8859-1?Q?zHGcxy+FkleRrVsgV12L4ekanHDvXAHs5LznsbkpZ+LKvjm3/2zl+TNYks?=
 =?iso-8859-1?Q?DnrKTnOJEvBf0sMSrX1KQHGPG7GbSV/GrLX9vdeHEkJ+wpHhgcTQLtBNGP?=
 =?iso-8859-1?Q?1+9AVPhTpJsI8EgR6WR0R8gy7TLrlZrunThmKj1xAR3J5kDcd5jNrGUQg6?=
 =?iso-8859-1?Q?vaO/14S4YTnCIPmQYHZ5o6wpjclhAUnEeLBSqM/8+YL0VV4OeidTVNOWNV?=
 =?iso-8859-1?Q?25iq3Bhezj0KmIfI0vbpmYgxjfT9F9qlEzSJqtklZSLrfgu/uzjsm1BnE3?=
 =?iso-8859-1?Q?+RHK72zt6EAEdhhUv0IZOsvzCmZwLkg/m/zIWZZhnpUnNiTyGjHyMLUxPs?=
 =?iso-8859-1?Q?4lnI4Cf4Z1BCJ8oBwNRlZTKwJRiZfG2WyoEBHPyhig23yLP8pETAZR2gGf?=
 =?iso-8859-1?Q?HMZ//UBYNNILkrN+YN4SIuZKm0OeYxGpgLfwpevCpuPnWKyJ+0OjJpyf0/?=
 =?iso-8859-1?Q?65ceklMV1wzol54gq0W5qozwA0V4ADT7ECC7hIZmEMYnpJyyMLe87qA0at?=
 =?iso-8859-1?Q?AiahSQYrFAWqI9BHmvNcmPSo5nTww3ODsgRKoRe0N42TxldtEsHU7ZdjOL?=
 =?iso-8859-1?Q?go/aiXdtqZSPeW3cBjQkD2Put7/KsurKPER5ro9Mf/ixSC+pKU/euwUI2p?=
 =?iso-8859-1?Q?1wqkYHRk+W9Op4XHh/DDL5DYRfJSyvBYRM7N6RoBCzsMOoY5yCXXmW63jQ?=
 =?iso-8859-1?Q?e8R6SXMr3G/H2dyb7pSB6GMfuZo93hbGhSAu+GxH818IEPSSI+knmClkXk?=
 =?iso-8859-1?Q?EZq3pfvUCwE97vC7NxZJf7uyc+hoDYF19YShL0hV8blRir9Y5QAntRks+e?=
 =?iso-8859-1?Q?NdhO3PM2AGWD9VOGzzYuia7VQtfmc9JTi/ibu4yEKS/Tr4Iy0FRPaFPy+j?=
 =?iso-8859-1?Q?zflENgfEm2VbdVENvNOY/P8DCKULdMy9OeAp6Q0bHXK3ZhkIu0+8SER0pm?=
 =?iso-8859-1?Q?v2G5rjl8Jom5C7cOLwYiZYpJqz9XxaTVWsFuAJN6NWvxgfS4DbqM2MOK9R?=
 =?iso-8859-1?Q?pohUKNE0ocwPeHBI6Tg0tqpw83i//d7qK8qHESknnuESn35I+B2mdp+agJ?=
 =?iso-8859-1?Q?99ztwadBikp6D9+vrx7mpx2nfbsZXTHGoEIr6Wzb34NnSHjMAAu+gxSfBi?=
 =?iso-8859-1?Q?2MT1Mw8Ar8swoZEVGyNFwdzw9Rm+Cyn44kMi2ldhaTjH9mKIiU1jyCTJRT?=
 =?iso-8859-1?Q?jqeJf27cLywpJsTsFQKafaN9IAN6OETdffzPnrCpAFtXS6lekU8TJUzzYo?=
 =?iso-8859-1?Q?9GHSoHpXbMKxaaTj6iwVFSU2a+oabHibXzf0ZtZeS39+qNn3oPjoAWiifP?=
 =?iso-8859-1?Q?xVe1K5b76orS4FIRZSOr6UTry0zLRMVeZNVuxC5xrgr+eLipD1sTTYPUH3?=
 =?iso-8859-1?Q?RqLfwyb9aGoLBbF53KeR9HoC3Dgpn3JtRK1jKQh6NMxZ27BabQ4igByuw9?=
 =?iso-8859-1?Q?j8OnAh9poyy05j1SgHXL0TjwhnO4pzULDVHUnK18kq00Btxe+8dp++7Knw?=
 =?iso-8859-1?Q?dHwSJYZSYZM/S49HIOUFG+QMoXWS5xTBfZ8P/0X7MWLSJPcT7CF5M58KwM?=
 =?iso-8859-1?Q?qCljG8ue/jA4u/M4daqxg3jJHlFLbzlMmbq1PldQ+L/Y5xwcZs1RdZal4F?=
 =?iso-8859-1?Q?lLB8q53wOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: z9tcQvoWdbUhhMKIGKFP+ZRUVs4lL1/+D+WPvu4bDB4Q9yxFR2Im/khyqGFN10Zw4haSZH1NxMefV4Qu5oFzmpdRABp0xQq7SWAZIjNjRdbx2pRa0B6PYWBcU0WgZ4smXDNF+ALF4RAXURrPCVsg64h4m86/uY+/1xsuffua9kb6NqoLEfT7JxvhCuike9WYOiiqW+BWCY1X2z3eBQehTv9qALxjw/UnhZcxqPWCPOMgdbemJ/r7M6CRfDDg/1FjtdqPYaA987mioYn9uTSLq93Sw90AJ+WD2/+gkdvASzLcJbBtK1XT3oUfmEk/EZQIppLUrp8ZbzNngIFU3/YeDw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a5a6e6-23ea-41aa-9e02-08df1ec3f407
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:07.0872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 082ogkYmChKwhZDHu4EYZfwH4H+0WajW/Lo5vCD06/vL4xVBOEkhqdEaYLeHyibD3slMH1TYsDQrEwXAIzu6QVp/d58rPB5LPUjmMbDjcGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6451
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

Before this change, each unimplemented device needed its own field in=0A=
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Use the "unimp" array in AspeedSoCState for all unimplemented devices,=0A=
and use the AspeedUnimpDevice table to describe them. This makes the=0A=
code easier to maintain and read. Convert AST1030/AST1060 to use them.=0A=
=0A=
This also fixes a type mismatch. AST10x0 used the "pwm" field=0A=
(AspeedPWMState) and the "sgpiom" field (AspeedSGPIOState array) to=0A=
create unimplemented devices. They now use the "unimp" array instead.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast10x0.c | 64 ++++++++++++++++-------------------------=0A=
 1 file changed, 25 insertions(+), 39 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index aeb5a4423d..cc587dcc1a 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -17,8 +17,6 @@=0A=
 #include "hw/misc/unimp.h"=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
 =0A=
-#define ASPEED_SOC_IOMEM_SIZE 0x00200000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast1030_memmap[] =3D {=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x00000000,=0A=
     [ASPEED_DEV_SRAM1]     =3D 0x79000000, /* SEC SRAM */=0A=
@@ -99,6 +97,17 @@ static const int aspeed_soc_ast1030_irqmap[] =3D {=0A=
     [ASPEED_DEV_JTAG1]     =3D 53,=0A=
 };=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_soc_ast10x0_unimp_devs[] =3D {=0A=
+    { "iomem",   "aspeed.io",     ASPEED_DEV_IOMEM,   0x00200000 },=0A=
+    { "pwm",     "aspeed.pwm",    ASPEED_DEV_PWM,     0x100 },=0A=
+    { "espi",    "aspeed.espi",   ASPEED_DEV_ESPI,    0x800 },=0A=
+    { "udc",     "aspeed.udc",    ASPEED_DEV_UDC,     0x1000 },=0A=
+    { "sgpiom",  "aspeed.sgpiom", ASPEED_DEV_SGPIOM0, 0x100 },=0A=
+    { "jtag[0]", "aspeed.jtag0",  ASPEED_DEV_JTAG0,   0x20 },=0A=
+    { "jtag[1]", "aspeed.jtag1",  ASPEED_DEV_JTAG1,   0x20 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_soc_ast10x0_unimp_devs) > ASPEED_UNIMP=
_NUM);=0A=
+=0A=
 static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(s);=0A=
@@ -162,16 +171,10 @@ static void aspeed_soc_ast10x0_init(Object *obj, cons=
t char *socname)=0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
-    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "sgpiom", &s->sgpiom,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast10x0_unimp_devs); i++) {=0A=
+        object_initialize_child(obj, aspeed_soc_ast10x0_unimp_devs[i].qom_=
name,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1030_init(Object *obj)=0A=
@@ -209,17 +212,22 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCS=
tate *a, Error **errp)=0A=
     int uart;=0A=
     int i;=0A=
     g_autofree char *sram_name =3D NULL;=0A=
+    const AspeedUnimpDevice *unimp;=0A=
 =0A=
     if (!clock_has_source(s->sysclk)) {=0A=
         error_setg(errp, "sysclk clock must be wired up by the board code"=
);=0A=
         return false;=0A=
     }=0A=
 =0A=
-    /* General I/O memory space to catch all unimplemented device */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  ASPEED_SOC_IOMEM_SIZE);=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast10x0_unimp_devs); i++) {=0A=
+        unimp =3D &aspeed_soc_ast10x0_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                                      unimp->region_name,=0A=
+                                      sc->memmap[unimp->memmap_idx],=0A=
+                                      unimp->size);=0A=
+    }=0A=
+=0A=
     /* AST10x0 CPU Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -394,28 +402,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                        aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_GPIO));=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
-                                  "aspeed.pwm",=0A=
-                                  sc->memmap[ASPEED_DEV_PWM], 0x100);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),=0A=
-                                  "aspeed.espi",=0A=
-                                  sc->memmap[ASPEED_DEV_ESPI], 0x800);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
-                                  "aspeed.udc",=0A=
-                                  sc->memmap[ASPEED_DEV_UDC], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),=
=0A=
-                                  "aspeed.sgpiom",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);=
=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
-                                  "aspeed.jtag",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG0], 0x20);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),=
=0A=
-                                  "aspeed.jtag",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG1], 0x20);=0A=
-=0A=
     return true;=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=

