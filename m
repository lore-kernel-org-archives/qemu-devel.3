Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AA8C4453A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj69-0005JE-8f; Wed, 22 Jul 2026 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5p-00057K-2Y; Wed, 22 Jul 2026 22:23:26 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5n-0002ZN-BD; Wed, 22 Jul 2026 22:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXZlJtAu/64cuaKRJseSHCDuBRQJYss+kb+P1xqlXz1SUGs/qApCF7tZmok+EKnL43xt6e79jSxqHF/3NIkmPGX+Dg8EmKbF7KfsWKWqd7hAQA9kHhXV7J1R/TRi5GegeJRbwwB4FT3rNA9RKJpERmh27CswK6hoox3b/4oUSfa8nyxGzwIR330cQsx0pbiMmneIpWRJsQw09/jO5IMmP/qLhnXyHWAgk8OIkcJbOyzEteUA9n7obWugcHjsfX6M8bWVaa/U3L/ME6ohrXWjQgXcZzodxZXPw2Dv7fDdUl1p+JQAW9MdqIpAh5HCDFMRo5zFEARcP/WcwRaN0rgxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM95eLoG9oEgHnEZg5qygqqhk/nGcO98uXBw1/dhbeM=;
 b=k4PCIFiEHxO3pumN6PSe/RYXVFacc7eKFWXshsSoqdSYv+OIo5DQBDSwtkys88ExgFMusuuoyqcI386yojK6cSRXcAY7ZeFFB1ubEAkErQR5kTr9N/r+ZzakE5917rUlC45k6/ghG/z4HeM6L7R+qDc8CVUxJyoBLeOoH7NEpRKnUDDsnMEkInGXPpSpgk3l12eeaONMAAmjIbJGqPwrinpg/8y8FL8Kkfxo3s+VYg6AgZE44NUP5bHBE5uNV68wSyVyigTokO6IuaOTthUCnCBauj/2x52cJgwHbEUGes9zYFR8j6rbg1riDZh1GC/TDk55TDZxo6XMWfzOaYzJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM95eLoG9oEgHnEZg5qygqqhk/nGcO98uXBw1/dhbeM=;
 b=JanL1z7MntEHVOu2vOPwNKMNbfE4n0yEwjnX0/kNhg3UEJPQVB0ybhP3czstYevjYMIESgjOvK9tFeC+XyWuScd6weBxqWRFt51OZ63C933f8+jD/IXD3FOiaVrjo1Q8T5LAMFgMxOoiRFbBZ+SE7SHPdooga1UNDkHhJFewl4m7yUwMjrnQl15Hm5Tk0K58izjPBaHrogkmh92oO47L8i5eVBKXh876/rNnq3fmhChPFPA+HltizcX+iwe1Hx9NUwgRH2o+iCH4+w+OWddE5p+KHeM29ktT+0IQF0/OWGc7dUSG8JIoWBhHKugltE27FAFC8JK3emHIPJg+942B8w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 08/11] hw/misc/aspeed_scu: Add SCU support for SSP SDRAM
 remap
Thread-Topic: [PATCH v6 08/11] hw/misc/aspeed_scu: Add SCU support for SSP
 SDRAM remap
Thread-Index: AQHdGko1EBCRL2OUf0iAkg0VzyKmxg==
Date: Thu, 23 Jul 2026 02:23:11 +0000
Message-ID: <20260723022300.4174471-9-jamin_lin@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: f3c61512-4770-4e87-7a83-08dee86157b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: x+JG5a81vWgezcF1FQAg9Zb/yPsTw2bFaHQFBOZ3y2cqBVKf8ysG53OYEcSYXhmOifmHrtBXYCfsWvJRS9bLF3Nmmv/LxK5nZctcBVq2FlI3dv/o4X2XnG6l5n7qrvtzoBiW3RQuMzEgpAj3GbNJ8krrhGiEzUcRDPIKlh0QVcnDA1qdApzi2P2KRpwMgm+WbRnQH2wVjtGso78b19k+3OenwDDLtrz/0PwLAJqFMXw++q6IAY4yDCzo0LwHoxUM+AuThhEGFTAvGoeW1ieMrmgDkmaNmmEiioPKTW706ernz/5v1OqnGIYDwRE9xU9C8mlz5g4epDLQwW3LabJpv1okLmVgH0Nw/w87APUaEaILGSRjicROyl6lWpVhyBVOz5Lxu5oaju0wA4sz9R5WoN5csJw5KSXWmkKXJQj1PffZpATu4d+i4YXxmDX5+nrkV1wX9vly8eVgDjzW2xQNblxNV8Q/DhqBTDFIwUqWltX/ZPOcZ+sx4JUFi6tfPlZvcXtZzB3DfGIJi7T/yUDhWQ7B+3CD7Dt69YaP7x2AqdXunzblRTZSSnUKrygTx5WjetAtKT7U/oVDX5EW06e1YvqOZCMrkUQ8T7APuRU0qMQcaF11Lr064WDqNbu9JMXCzQlUAXEE5d8+zThKWS+BYiXPXTy8zNBJCGab7/mP+2yA1TWaoiYkC4Cd8V/JlJyvHuMsC8LvkYwcOVUh2/Twgs/HvBSPCaO3+oMvGfP9m6xUPf4D9q/QljFWTTzssRCu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yuwTgNMekW57TY5aPMnBeKk+snN1yJjSFrb+l1tLNPjYhgmiF6lC19r6lv?=
 =?iso-8859-1?Q?l3r37/+tLerpXhix5lNVLhHl/i1zmSZ14VxbhMs+G5nt3yp264xgYYamVz?=
 =?iso-8859-1?Q?pAq9AVc/jA96ehmxH8hnLUp4zBGk+7l9zR6inmY/q9+r3lENf+ZC+io9W4?=
 =?iso-8859-1?Q?O1n216I2fRiLl+gbDJoSkw+iw9s+ic+sSl/atnZqS0ijVLDctVm1bFpVR/?=
 =?iso-8859-1?Q?DAFFYWmK+j9rdwKE/1T6LxNudDu71f1lJtC2SXBzb8nVC/JyzwD9hocSrF?=
 =?iso-8859-1?Q?+VOSxIN8zB0j48IlnHCSoKOgc7zTnVLh0f/Fm38KKneayFKmvVvdgc0448?=
 =?iso-8859-1?Q?9isORSG4/C6vC7LwTXSze5ncLJtddIY/wLjt65k88bRMqhMomAY6FZwTxj?=
 =?iso-8859-1?Q?nEHcbgqyAjYPQVYVEzPlSZAWCilVKCjrclhXxd3pADQr3SNEKpS+Mx5yB4?=
 =?iso-8859-1?Q?0mB3BEpD/sg7XDSlY2Q75rEcDArJ/UiHyOuAe/ps3Ftt+c2ki6u4yHFR/k?=
 =?iso-8859-1?Q?pchdG5wwQTGbE0uj2tDkEvbcj/v2jQjMJIAlM2H7cNnL07CBYhEO6KrL0e?=
 =?iso-8859-1?Q?9OezLKZYmJDPCYrZY+fzs6707umHccG+2nZgcGL9l6S6P6cDHtyAf9Uc3b?=
 =?iso-8859-1?Q?0bBbMCT91LsaOgOjWaRI0j9r5fAZ9dWoJMfpauMkjpkJBNSTaEjPpXlumg?=
 =?iso-8859-1?Q?424tYxyRFIFSkjHzEI9OtWTcuuACijFLQmgdi7KKDzUwhNI+EuFByuMw5y?=
 =?iso-8859-1?Q?dytLgIJ8Bzn2bJLlvntlesF8nMxrUu/+dfUVVT+pp4igxPZHGC//OSZOhk?=
 =?iso-8859-1?Q?LeJFSaiZhBl12omM7ObDQDAhWALmZ4Pg8PzwIiy/xkMq5SC0kOV+tt0NqC?=
 =?iso-8859-1?Q?xUdPra+5R0hMeKeSpzEvFrnQaBdaIk/45Hx/E9JMutBcF0eEk/adYOipC0?=
 =?iso-8859-1?Q?Ukbo6vEFtC+eyIRCXVXi6N0E0UA0msbvzN3Jxq/BEljbk2jKQK6JHhLfre?=
 =?iso-8859-1?Q?YrhivRDeA1oCWmXw1TWzNO4eldoGzMjpMxXSAkFCPzR6d6v3fIednOGfDh?=
 =?iso-8859-1?Q?QBmk1eLSkuNas9mhHM/SmDn5YRcdN0/JK7FMisvuglHvj37AnbuJsoRhUi?=
 =?iso-8859-1?Q?r4Me4/B7W0Q56uduZOReshnOhDNbVLrC+gEKGfdIYGuSO4/1tkcgQjdfXv?=
 =?iso-8859-1?Q?DZ4dzYy/l1Bzx3cK1Y/xsRadcLNjgz0A/LyC+BUgt/tasbRROFk9kdhl/b?=
 =?iso-8859-1?Q?W4x0sARIvokdoHncEoPascOcb14jgYe9dAWc65UCEz6wZIsqEArLD8kmjo?=
 =?iso-8859-1?Q?W8ajXEJtx9ccIKYX1KoOL12Wj402PmIW3sKqJT+EsTbP7jcrq0ICGj0hhq?=
 =?iso-8859-1?Q?ob47pIYYbcSj811CqgB6F4YliXVIhE7DJsEzoj/vDYoMSskgO4+He0M7lp?=
 =?iso-8859-1?Q?3zx6n703WsWJ4zrm2azgJTYSXHXQhc/iq4G7vQA50BOrVPSrWMlJhoO3Di?=
 =?iso-8859-1?Q?CSv4XXBrChCQQY+Sam8ARGU+TP8Ww0X6r+iaGm5l1UVUWgv9QpMEA8Y+YO?=
 =?iso-8859-1?Q?cWN1opb3HvAoi+VXDeeV3sfknOwOSyPD9UQpjMJRwACABxg+N3TqjWui/s?=
 =?iso-8859-1?Q?TvnhrvZg26SiCJd/ArCSGPRyVKKrsFOfjj4f9iYBwPmzTAxICn6+TeEcWe?=
 =?iso-8859-1?Q?cM1Um0lNS+Fheq4wjVRRFGzB/bmS8CVEIWS5P4hS73YAAVsOLwY0YR4sUR?=
 =?iso-8859-1?Q?Slm+U9rdongxC2XzlVkXEI46AC8I+zA2TMq6Zg/+lMJM/a2NsiI4+mKlKX?=
 =?iso-8859-1?Q?sVxeHpOw1Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fm5F+qw33q8W20RgZWO2QToh8jUMsjqMVTaDKl2Gwo8YuPExjlU79YR5OsZYxXyw1T2c2n/RjustoqxR6PuI2Bn/EGMUNKJoWofT6KdwqfmbffFP2DK0Sn1uaYL5xwfelMvhO//gd4f779VwPe4E63ACBcejqVPR7GRjhhZLKA8byb9zVypRBLmPc7A9Gn6L0gKP+Ow0Q2Tjg46ehw/5ec5Hs1HvsDI3b5Mv/k+vWL6YHerH2xhXqrlXYEa8p1MTegDMrhWw26aKZxhqL0dAkP2JlbfquljBDfroD/JCeR+ZbXYIubyLAcQNCdiFP1h0Oxfein66ppYA7NEc/oiX2Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c61512-4770-4e87-7a83-08dee86157b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:11.4221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aY7FoUESDMOdqjtMBtlpcYSjitZJszl+cAut07dV2SgJO0+cSlPgGhxFP7HbURsP4oV/LVGoJTTzNNKf/0Y8s/EPNDqgWzc7fjnFm+yN4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

This commit adds SCU register support for SSP SDRAM remap control and runti=
me=0A=
activation. It introduces logic for the PSP to dynamically configure the ma=
pping=0A=
of its own DRAM windows into SSP-visible SDRAM space, enabling shared memor=
y=0A=
communication via memory region aliases.=0A=
=0A=
- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x400000000 (size: 0x1A7=
7E000) to SSP SDRAM=0A=
    offset 0x5880000=0A=
- coprocessor_sdram_remap[1]: maps PSP DRAM offset 0x42C000000 (size: 0x058=
80000) to SSP SDRAM=0A=
    offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_SSP_CTRL_1/2 and=0A=
AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfigu=
ration=0A=
of alias offset, base, and size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        SSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000         =
       |=0A=
|   remap1 base                            |---| |   |  - SCU_150: target a=
ddr    |=0A=
|   size: 0x1A77E000 (SCU_14C)             |   | |   |    remap2           =
       |=0A=
|------------------------------------------|   | |   |---------------------=
-------|=0A=
|                                          |   | |   |                     =
       |=0A=
| 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x5880000           =
       |=0A=
|   remap2 base                            |   |     |  - SCU_148: target a=
ddr    |=0A=
|   size: 0x05880000 (SCU_154)             |   |---> |    remap1           =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 62 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 62 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index fdb1cf59b4..407c1743fc 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -146,6 +146,14 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)=0A=
+#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_0    TO_REG(0x140)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_0    TO_REG(0x144)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14C)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)=0A=
 #define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
@@ -908,6 +916,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwad=
dr offset,=0A=
 {=0A=
     Aspeed2700SCUState *a =3D ASPEED_2700_SCU(opaque);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
+    MemoryRegion *mr =3D NULL;=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
@@ -965,6 +974,43 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
         data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
         s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
         return;=0A=
+    case AST2700_SCU_SSP_CTRL_1:=0A=
+    case AST2700_SCU_SSP_CTRL_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_1) ?=0A=
+             a->ssp_remap[0] : a->ssp_remap[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_1:=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_ADDR_1) ?=0A=
+             a->ssp_remap[0] : a->ssp_remap[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_address(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_1:=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_SIZE_1) ?=0A=
+             a->ssp_remap[0] : a->ssp_remap[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_size(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (a->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1035,6 +1081,14 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SSP_CTRL_1]        =3D 0x40000000,=0A=
+    [AST2700_SCU_SSP_CTRL_2]        =3D 0x42C00000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_0]  =3D 0x1FFFE000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_0]  =3D 0x00002000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_1]  =3D 0x05880000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_1]  =3D 0x1A77E000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
@@ -1067,6 +1121,14 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
 =0A=
     if (a->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_address(a->ssp_remap[0], 0x5880000);=0A=
+        memory_region_set_alias_offset(a->ssp_remap[0], 0);=0A=
+        memory_region_set_size(a->ssp_remap[0], 0x1a77e000);=0A=
+        memory_region_set_address(a->ssp_remap[1], 0);=0A=
+        memory_region_set_alias_offset(a->ssp_remap[1], 0x2c000000);=0A=
+        memory_region_set_size(a->ssp_remap[1], 0x5880000);=0A=
+        memory_region_transaction_commit();=0A=
     }=0A=
 =0A=
     if (a->tsp_cpuid > 0) {=0A=
-- =0A=
2.43.0=0A=

