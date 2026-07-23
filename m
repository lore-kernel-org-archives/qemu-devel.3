Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E723EC4453A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj6D-0005MA-3a; Wed, 22 Jul 2026 22:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5q-00057M-78; Wed, 22 Jul 2026 22:23:29 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5o-0002ZT-I3; Wed, 22 Jul 2026 22:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYVfKgbk1nnv+KyZ0yKf8UDSxCBrKE2P0BWIHHV+DSv0ecKTdpLb5DppUqzbjGEpwFWg04ZxHVAK5+3bU4mN/+IIBGCXriK0pMcvy1pcRKVxRmtE003Mqkt5kv38BBNUIVkvQQYxSR0JhSCoxgjtefE+zQL5QU6QIIZf9yPUGAKJP2IXXfIR0neEAQAYmcCNe8t7EoKoHhN4NgWzMHJquT8qK8bjyH2oPnFOJAgD9Jw6305E+8WadMItwttTH5kh/ldK6tTIttzIfKM6LeXbV3ylBmn0Rz4zBpgINDAEjnNQC/SgeOcYZnpH9diIHYvQedc9s5Y+UeytCddh4v1BTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKyCTRYQJ1wAScwAnPY7waKeOI5/j/+4WDWcB++XCh8=;
 b=YTbJWNSpXfXOILOtGmIPP2WtoNjKDzPB6LB7zdcQkbRHxVuyG0McNZHvl5PGw7wxWzK3jKkwnq0B7nYFtYju//4rNx3Gc53SIqUl/jDXdlJi13wLr/g3MQn3/NwEK3HK15rwZWWthyRLZMDlV2XBGeA9E7eBt3bfJSlqv1kN+rEebB9q5UYkOOxSGR4jel6WegXt4G0iBY0ap2Vs1hh4VuLX9AvBC5/7rCV1vnevnZfyZ91l5EeTz8IEnWohLn6ny0xM64+PQ9xmA1avxx4lbA/LNPz9gUnQ1xzOLPsMIi32nSJUHqJ9f3oTcrYjZW6GiHk0epvih7nNIE0k3olZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKyCTRYQJ1wAScwAnPY7waKeOI5/j/+4WDWcB++XCh8=;
 b=He6WNOJXc0y5z5etuOe586U0JSpq+Ux6Ayi+BuK82CD6EWGOINDR86yYis4y9ZP2XOTmYH1RreMFHZpOoSLXpcLXsb7GtXlJ6+KXVuvG5fuiYux2pVayu4Qywe6RI/nBkLNzOT9fojoyfhQ1zFQ/EyE9hya6WD5N17MrtSkhUcaf/hX1vuagAGbn7obT/k+p/fAA6zheqHFxmzE6rp28Zyb5Q6+IIxREgO6DaoWO9tasZWJql7pCJeczHgPH8V6XvrSZfoVIv/YUxQcY6kG2wA5vP5zAdqyTzdIbQxBZclAUXK1ep5LpX/4BhRHgUVOC8uu2tRh2//7X1SeBveDgPQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:12 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:12 +0000
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
Subject: [PATCH v6 09/11] hw/misc/aspeed_scu: Add SCU support for TSP SDRAM
 remap
Thread-Topic: [PATCH v6 09/11] hw/misc/aspeed_scu: Add SCU support for TSP
 SDRAM remap
Thread-Index: AQHdGko1O0ggDaItNEWl9EbBW2CNWw==
Date: Thu, 23 Jul 2026 02:23:12 +0000
Message-ID: <20260723022300.4174471-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 80dcbbc2-559a-4b35-8812-08dee861586c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: lWmsh/s3GANjccw+QMp39qGlCKcZuFv4feRus3Z0+zY3M8CCzsv0fM2ZgrgLt5CFNvPiLS0JRX0qt2qbBXHFkUC/uw8+fKFVdWRmROU78rwveQr+F/hQaCHr90t5JGY/IPqkuS+9GR7nxzK2/p9crAJ6f/cRoTBJBKQ1qHJCxhVuEfV5j6qbIT/gD++SAvsqN9uz5lJbPYwCzKCy8k+4xrLrEK/64AbbRE5HXwJNr08EDB8nuGOUX5AcPop6/PbUiY9Fp+Ld82j/jScq+Cw3TV6MoarJA4/7ssceU8B8WM1HmCfV3x05rEoqK5de9E+SVr+jOp2fYPeCgq6lhbCjSWhz4KWTD4b7AmYjEb/OnDrIjsG7njWKkIS9gHNG8offLOvYGylakog9vdjf+x5oRGiDTJzGx1GIwtGeeqVYLak+5lBjkfYFAzFYbvqXxMsDIK/yZOaYrhwYc4a6OK33lq1z74qOKBWOfykxA6FHEBS7g6SDP7PnsX/guP553/OGWayXADOEGCI8osLhkglQTeOHxHo438+pigypSIVedYf0WOTnFMJo6+AjjPGPCMBBIyjRfhdAp8V9whsQLvX2HeWoYBHQh0y11LUjHnZMgc2JvW2MKTuacZocJF2IDoytyxvbauqcMjYj3iSGQfmkQ1/mE09hRnQqDPtipoQvN4hF60xn6RDSznPipUbtHBFOCDDww3wroYThq1ORxWdORLh3z5LLRqjyC6B1QqrT+DSGamYYOY8P7xRihWwzFTKw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UwOwLBfKdW2w65F/Kk9crdg7cseBfU8o+ZDyOUfgfS2tQ0GmYT/JxCtTJs?=
 =?iso-8859-1?Q?3/QU5XsIxCRVViMMcaGUKtW/IZzMitIghBNGsd/TfKGcozNbC/oKRSvUtK?=
 =?iso-8859-1?Q?zwd6+h5/fsAxwVHr9bdgtLqVfZkwmTjbbcENeNTv3wdQTGLCi6vvSUIXRY?=
 =?iso-8859-1?Q?lb+HG86Du5dRqu3wJUL3Vdg0Wid4DlIkveJZhFtFReNz+DIAsaH2n0Oax+?=
 =?iso-8859-1?Q?v7RfYdgvumoII5MLqG40y9M6Bk/1Rsci9+oZB9XclXxMHEWAz3HyR0tljD?=
 =?iso-8859-1?Q?sd55FEmqR9hNgctS4V1BbYDH+KtAYVpx3vInbG5wV2vpe4bPVSjrgC1m1r?=
 =?iso-8859-1?Q?CSfaN5/4v025PaFqAe4lMe88Cu8G1h3QSSSz/Ak1xKBEd0nKP0Y7771f9L?=
 =?iso-8859-1?Q?2AbrFkIXzeVfUEqVSmpR5YxUu5vd7/YUYxDymxxVYUJT05hnJYt8czmkS/?=
 =?iso-8859-1?Q?yvU2AMfU8I/H//0tB5kY6Lo0BSP/TgHmc3ebGXmsNafWz/R1GTZLsUBQPe?=
 =?iso-8859-1?Q?6209bDP+O8FXYuBYMorPGGEYwViiv2X4AWcFbq7oLTZlY5cEEdJCJ2oqkA?=
 =?iso-8859-1?Q?DoOUhpqlxxiBpBiKqMOgfV5G9xkYyqbUIHfc4ETJ672YAr/U5+t7C1M+gb?=
 =?iso-8859-1?Q?E4bZ2ffJ73G6K8Ra4AV9RUHz1NO37uxzJUyeGes4JdH6nf6st5e8VShYMw?=
 =?iso-8859-1?Q?MQXxMtsiGcEM9NCw2s5Q4ztAc/vgA8Wdx3nASsoaahaQnRjWB356wihMC5?=
 =?iso-8859-1?Q?KAfNuVzqZB9Tx8yTjebC6gO8iYdX4bkfUs1uFzH8z1f4dH3rDOtj9u36/r?=
 =?iso-8859-1?Q?USwkaMl+Yuxw2UtL7J7OZz7C2GkKLbD/NMYDuO4AhuuVHm7oHZ10W+S+vL?=
 =?iso-8859-1?Q?vbS4fj0dlZ2J+f7t3yBUPS0GEGm+PZwh2n6CYcoHL3rl8NTDQPpUChgyD8?=
 =?iso-8859-1?Q?KSAdbVW3RCfkSskUg4hMvzH24XTsIdFsUjwzxK1e7KHUDpnMInOyFgxqhS?=
 =?iso-8859-1?Q?Y2D4ixATJhau1Lh10rXkFZ1GQ5wGlWErozyAwCrC1tYibusNDNCLPde1DI?=
 =?iso-8859-1?Q?AKrwNVjZjynDB/vDXHQwDv/WjzTOe4CJIOq8YuastuVWFRzVHv609oMOTD?=
 =?iso-8859-1?Q?YcBKC7f3aATiMtiV22ySPmhdngALuzdY2beLDLKi6uQpvaOcPbFcRz36gm?=
 =?iso-8859-1?Q?s2YLgiY2gl+4H0jNjji18n6NJ6dOeW6LCExNCcykE1Vo34yiBCxPuxRkmn?=
 =?iso-8859-1?Q?uaZLrpv/BKuG9+0zfJJ1tF+kwQUb/KjQatKajNmMPnM5l/2saHdzQH0cnW?=
 =?iso-8859-1?Q?TIzOTRHOKOHh3D/rsejq+itBQBuzDq8zT7ZiNLZzb+tDeWznmW9q8Kvjmb?=
 =?iso-8859-1?Q?71zNoavsfSoqcHle5j2iifdCW1iLqnRrmNorCOqUJDZhJm1XgZ98pApvKc?=
 =?iso-8859-1?Q?BV8+O+FMFqgIT+Z9YWG+aKCqSmRib1fIbRMuqMGFmflR+1TPS9f09Yc3RX?=
 =?iso-8859-1?Q?y2SUJp5v7+p84qyTntfgYjy8vVQ6CjCe04hMTAjrATntXiIacuGb/984bw?=
 =?iso-8859-1?Q?QKJtUIa4ymCIp8gyAqmERDO9Nwo5/2iMIEbDGEt5WweQO+5vfJM4tMxIjr?=
 =?iso-8859-1?Q?/YhkVA+0MRW4mXmay5Ir4PH7R2yhLHBzuF7rb+qPt16lkbxughgs11X7xR?=
 =?iso-8859-1?Q?wdsboLd7ppaHMcehJ7oHB4F8Xhv3u+lK7eJ2fBUF3aOF4x1seZ04lhyoym?=
 =?iso-8859-1?Q?H0FDEj6CkZjoI5DUvy0CLQzPYuSQKvvmmpzewonLhlsoxFdrb78ZltO35c?=
 =?iso-8859-1?Q?y477T9gStQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FaVintEdMyvp2+Icma0IqLW4IDtuWSoqO8ctupJ34GTv22MaE75+bWBC067yt3ppvUhzrJYhVjRdiSnKx5p3X48LnCivB1mVskmxCxNWOvFPNQ9vKg9HzdPHutvRWVtwVkkDfFZ9cbuU6pBpTfI7MZonmiySSeTkULhmDvOaMtuHF0ryVMWOj+Fxtz8Noea0FTsD2q/I+lvqfssu1gLzJLMENb1znknSyVMgKu13TTjPCNFtb2Xe5OGYbCqyxXCSxcuo2RNGYFeD33GmuTzhn38SJdJk3vSmLu0MmToOhqHMKSL82PXkf1c9BjJczCTc/8xopoyBG+Y9RfynViZvIg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dcbbc2-559a-4b35-8812-08dee861586c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:12.5681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29C1w4TW849nZcY/hl9pfOpLnBRRcMzKOGTg6DprbQFK6j6OqLFgNSSuhkV0Bt5aODtB/iIEs5+L/L7FkUy/SqSrAlJEWURvJqGTcZaP7rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

This commit adds SCU register support for TSP SDRAM remap control and runti=
me=0A=
activation. Unlike SSP, the TSP does not support configurable target addres=
s remapping=0A=
through SCU registers. It only supports setting the PSP DRAM base and size,=
 which=0A=
are then aliased into the TSP-visible SDRAM window.=0A=
=0A=
coprocessor_sdram_remap[2]: maps PSP DRAM offset 0x42E000000 (size: 32MB) t=
o TSP SDRAM=0A=
      offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_TSP_CTRL_1 and=0A=
AST2700_SCU_TSP_REMAP_SIZE_2 allow runtime reconfiguration of the DRAM base=
 (alias offset)=0A=
and mapping size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        TSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x42E0_0000_0 (SCU_168 << 4)             |         | 0x0000_0000         =
       |=0A=
|   remap base                             |------>  |  - fixed target addr=
       |=0A=
|   size: 32MB    (SCU_194)                |         |                     =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 30 ++++++++++++++++++++++++++++++=0A=
 1 file changed, 30 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 407c1743fc..74b7674b06 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -20,6 +20,7 @@=0A=
 #include "qemu/guest-random.h"=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
+#include "qemu/units.h"=0A=
 #include "target/arm/arm-powerctl.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
@@ -160,6 +161,8 @@=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
 #define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
 #define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)=0A=
+#define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
@@ -1011,6 +1014,27 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         memory_region_set_size(mr, data);=0A=
         memory_region_transaction_commit();=0A=
         break;=0A=
+    case AST2700_SCU_TSP_CTRL_1:=0A=
+        mr =3D a->tsp_remap;=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_TSP_REMAP_SIZE_2:=0A=
+        mr =3D a->tsp_remap;=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
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
@@ -1090,6 +1114,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
     [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_1]        =3D 0x42E00000,=0A=
+    [AST2700_SCU_TSP_REMAP_SIZE_2]  =3D 0x02000000,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
@@ -1133,6 +1159,10 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
 =0A=
     if (a->tsp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->tsp_cpuid);=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(a->tsp_remap, 0x2e000000);=0A=
+        memory_region_set_size(a->tsp_remap, 32 * MiB);=0A=
+        memory_region_transaction_commit();=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

