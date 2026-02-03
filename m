Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DBAE7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e9-0003W4-1x; Mon, 02 Feb 2026 20:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dv-0003Nj-PK; Mon, 02 Feb 2026 20:55:53 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5du-0007tD-7A; Mon, 02 Feb 2026 20:55:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUH4JrRFbQRBsX/h6UZwIiqn/hKUoD++H3KbGhh42JFrhxEvZAgaO4315u7DIB5XdAMPJbR3mA16anvy/x4gM0BXTdRWktpveelc0az2L9Yep1XI6S3unQtsBqoH9Tj2Jv2416r8LLmq1LBOgG+HLCcB/t5bfcy8z/W/sQAWGFjRaowA+75/l1KVyI+erTx2Vn0MP6Uj3IA8ns7urVLvzkRz5LxPGdi9VsEkyvzk1at9qJJ7uMQDEWOsyBZjo+ZPwkiaOclEH+tg7PSw7LuNHpn9uEdGhbRrEhsf183mUamBohV+oC+H5TGmjX2UJsXvvOK8zLmzVkucN3Lu8txh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugmfB49OK61jrSpjCpoelAXsbmgwTpyfpV/qvLg3InQ=;
 b=k0pms8jBQAL4lqOBlPu9shTG6T+irOEkfcUPwwca/HsxO4Xk60g0jMezzR2hU+7+Y3RNUhbBfsy1UzeIiBfxfH4xJ7dSwtUm0vJn652WUjGSwy9vposMAOeWiUQ9eGemMdcks6oRaD8TYpLG+dFzLD5AZIUFxnd7z1oSM/wa82nPTv/Mufq6x9DRwKTp2lQ51Cp/Dvp4ZFo0qDjR2/P2uhaYuvUaZx+6+LBfJr8dkQOBmLsEW3EKpT9IrU+zF5NZixNt67M4jtZrY7QoT3Hp7SKF4dMwY2Rw3wYXpRApCKVIMjvIgJELIvwXUieIAB2Nv7JA2zYfoyQxh7/3Ywq9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugmfB49OK61jrSpjCpoelAXsbmgwTpyfpV/qvLg3InQ=;
 b=JoB1QYhnYzdEv7Tpi8H4dl5WsPqOEqg+c56TdFNWytdmr5FDYIf90YDbPusRTvLW1Abp7Vdz03MyXagnBpW/wnYOpFh8Jqw2IXBl/vsz0nRfINoQa9e80GJPycm3CznV9amjA2x3p5VdLHqaPEibnZ93Bm6HckcaC4gcT6St/va3ICd7xqQ7Wnfr+Z9ZQS5O800rAao6ROsGvwKi+EhkfDp3cIW4XB+VxkyfcIe0puTxdnBSxOhqkcmaxiT3waInu5DlLzdeJSI9PGmEmCbLa5kftnJQQ/z6D0Lzu4sdT2dh+KqPUQYMrkCMQJdfvKfeM7z87wZZ4VHI07SFjj4/Pw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 7/8] tests/functional/aarch64/test_aspeed_ast2700fc: Update
 test ASPEED SDK v11.00 for A1
Thread-Topic: [PATCH v2 7/8] tests/functional/aarch64/test_aspeed_ast2700fc:
 Update test ASPEED SDK v11.00 for A1
Thread-Index: AQHclLAwv9YUzW/mIku+SbYo2vTKOg==
Date: Tue, 3 Feb 2026 01:55:36 +0000
Message-ID: <TYPPR06MB8206C3E9FAF219E5FDE04386FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: 99fd200e-474d-437b-0a8d-08de62c75348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?aMMXLOZI2blL3BLO7YeKxzl3UEWuhbmeHmo11XaNleYfi2D+rcjCfe4SAgrO?=
 =?us-ascii?Q?DQe49HcyUv7g2Pcs0E+mIg+PGgLq0/Vd/1FDupfz04L5fWXwIqnYiaDbfV0e?=
 =?us-ascii?Q?2TKvWX3wFVD0gOHtyMN6y2l+UGfifwerC9fIdbcnZz4HWuZksQvaJorzudXP?=
 =?us-ascii?Q?z+f0t8fL173j8mEkua0EXqagGO9+3DR02tKSTGJvrVdLNTTaK5zku0eSQhlu?=
 =?us-ascii?Q?l2tRn0J6MBmqU/GbiztfEWhhiyZPJj3dmWT5RZ2hrFduue6vZYIshP3IL9iy?=
 =?us-ascii?Q?Jgq9EVBHkE+GSbOCW38o/tpL/XbTm1TW2xRGu+ZQX1FlKGSq4G42zdVERI9j?=
 =?us-ascii?Q?eGIPhIjrbPNN2FibfIlUMkdEumGSNnKY6sy33fn+C3DafNL764FfWfX7Oyyy?=
 =?us-ascii?Q?m/jp5O/2mEnxqkDMU2OG73F9uK4aKjCSbqG0T0BDkmDYUfGNBJU77Tp4L/5B?=
 =?us-ascii?Q?ujx58n9UNF3uSNudVMsECXy0hfQL6jcExp0G6yN6IE22VXyF2yZJ7GZvCyxW?=
 =?us-ascii?Q?L2f1QrVUItiOjWiQcnogP+oK6szKWEtCFKn8l7egrqm+ruJGe5I3ZVjQztSA?=
 =?us-ascii?Q?dpLuOQwUObzwaBffutbX3ORwmQIFdm5DwTnHuLS0/JXoFEK2xDIi7e3r1fFB?=
 =?us-ascii?Q?QMaGtaSekitpr1hbkwaXeg9C2ucDxKtBwzpmT63djJLmQ2A8kN4+xFiJGko1?=
 =?us-ascii?Q?VdJbNau+7umzZvvCTn0Cvxvs9NChxA10Ovqpyk/NMlOIDlAgce/zwzyVo0jF?=
 =?us-ascii?Q?0nGtKcIKHUhJHlQyyHF6vrccn+QkJaY1dAG9e5iP6FlBwgfD2sTpepBZPP15?=
 =?us-ascii?Q?Gsq15Q55JAGZBIB4ruN26DyHYeBe4QSLLXxGK9/uJkeCfiMn5fnNjAKBkaSa?=
 =?us-ascii?Q?KyK6TE3ich1B/JG5SwZuigUKO7/ZdLUXRvkUetjEGIQKslFSkcprLJCVg+ud?=
 =?us-ascii?Q?Jk5AcFakPs31mxk9uHBtQm8HQLESJOh8+ku7ggUFFdZ3KPpengqG9Hw52SAm?=
 =?us-ascii?Q?haoWL2/0MyE+BBTydHffO2/fz/Svl2MMZoVoihuzhw1w31H8ZwxYFq76l4G7?=
 =?us-ascii?Q?cqEXQ6+mrPHa/Ail+nPfiCjSHfktFGp9RgcgCdrybO4DQuIf4fFEpC4qRsXz?=
 =?us-ascii?Q?a35ly8yRBMQBG1vUpneveNZAlJ34XUh74K0JMq/VJKuBgNQV7OQTiHFywgwy?=
 =?us-ascii?Q?+lSiJ3MwuviCwlwD+bQ8t61ff3flwdr4opNsLaL8ltVo6XFcItAyV0SCyyq+?=
 =?us-ascii?Q?sDSOtjbsEzb8QrYTAy6pEzix1jNJqWQ7OnFGQOJ8E/HSSQ9+awI/czoJmyrd?=
 =?us-ascii?Q?ZTpcK4G5YUseyy9hmz8mroCWjORoqd8wr/C/VUgXSxQXXCUW1UpB4g+pE20r?=
 =?us-ascii?Q?vfYqPgMo4ingxfr9cdp7Why/horVquFFhI+TwaXnj2aneS8H+Lmtvcpm5WEo?=
 =?us-ascii?Q?2nuVaBOpdnMRjiMqeKJyEAJriWrrbnnfj1K7+Vetmlz/7NYrP5V5vf6TWe78?=
 =?us-ascii?Q?KEdNlG/Acw6Hq0SijNLqxnwAJ6l5bkjhxLeEuEl9sGZQ8pb6dcS1FpChimU7?=
 =?us-ascii?Q?1xSGlx4F1j3Bdp8I+p4T1qHHi4VV1svNkBHUbIsf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?weF0f2faxGZcJVMWqRr+Q74T0C6LUjBlAwhcXFd7KrIVIV7Ecd+wXQhS6OJ2?=
 =?us-ascii?Q?Z+onNZclrfAYFOTGtjy7nhuA2ZG2GhQAb2kKdjwhtp/vz9RXoweHGXqrff2k?=
 =?us-ascii?Q?3UbTbO/OHzjoTvvZioONiVKsWPEvIA1aRKAYGKeKZ/l0cu9FclMdDKJB9VYb?=
 =?us-ascii?Q?OVqoj5SYszi7IvytnGeWF5Mw4CbQ+VGjJdJjanmQW+xsabCa817e2AvtOQkO?=
 =?us-ascii?Q?9thajka2mVqeMJvYHVqlHqs0bO2j/Sui+p9JbRRwVqbmBgNx1qXUj6/oaZEr?=
 =?us-ascii?Q?ivZ7RYH1ldSbUBlLiA7zNJ8vllfo8RLmrcFuy3uy0TVg8nAg+kBp1Fu0cjRf?=
 =?us-ascii?Q?XD+10EcnE0+4c2OHf3mdTMxjGqDT1y/s6bNE4YP/6lawX0TgFCwfQxa/khNb?=
 =?us-ascii?Q?f+EBjMyJqIW3Z46fA1y0cKEUxm+ucdzJftyp9vDR/BCX+r60sNeYvq4mn4MR?=
 =?us-ascii?Q?zscoZvSVp3itw5cRhkVAgnpr7YxMPi0ubL4VkZRPxSk0rlKikLRA5I2mWDtg?=
 =?us-ascii?Q?nqyGbh9tEsyI4RoB4jPZdJOHKGvvuJ2PrSks20oXB32N5hEsWxtay0dbi9Xd?=
 =?us-ascii?Q?EepBHgxADEaaApgQR5gHsy97MzlThqa+HlcZ3joVTGgtMnN/Iih59/dcd77R?=
 =?us-ascii?Q?p0usbRtkTzPGWOs0Woua0tzL3yS7gPAQp9Ujr5sNFdMOyvFTeitBpK2pvQLg?=
 =?us-ascii?Q?6gXPTQVptiq7mQrURvZesSm4FWeZTl8joLU/OFA0xM05FTt0hvcD23ndufSD?=
 =?us-ascii?Q?MmRoThLC3CgpQjOlF/LpASpuUmhoeYce7p9azF7bDHCBe0eeVjL/3QGctenZ?=
 =?us-ascii?Q?Hz6yhmhqnKB+GhydHR0mUwX/G6ES5068qFL5c9njwYeXcbaBZa4b/uCas/RR?=
 =?us-ascii?Q?9Imq3WfCNptRnUUm2APBo5oUQYktz576fvLGdwoFB/gBJzhS9aHMrIp89a+w?=
 =?us-ascii?Q?HT0/bMnnw15rvY/OgQlu5bwBV9YPuAGLr8iD3U5J994GYNZDUO4QXb1ySN50?=
 =?us-ascii?Q?+q3TOLgZ/6+vWgLF+8ljIMKe/eLf8bxB+y5VU+TbiCGZDoZHwijV1bx0u7LV?=
 =?us-ascii?Q?+mBmTRtLTdznfhZbotQ9QUZogqeWpbeZ0yjuI+jaH9Ga5gmSoG75PFuNCN9F?=
 =?us-ascii?Q?D+KpvFjkxqWfr50L7C1x1SdEyRo91ztYKuMh8fbPUnJgCbcXvZkaLHsGWypo?=
 =?us-ascii?Q?WS+P9+AbzR9ViB2zpblOGpn6gxpdPjgyStIunjJIs5IYmyWKDbs0yWxpoWSx?=
 =?us-ascii?Q?YKx4z0vRtAVLM0GgjQVDm1vNAtGi0aUtDTQn9reEZrQVQ8GEckT3MwUqbjLT?=
 =?us-ascii?Q?JrrehL4AvhljOA6APR4b4lhDH2m98by2uJVGa7K2FxB3n4k1laPiXu0HrRkN?=
 =?us-ascii?Q?2uAhJFm+xi0nF7s+pRfxXtGYTIr+b/JfhD2WgWQ2JPyVP769UPbJTEZmLWgR?=
 =?us-ascii?Q?+VvcNnfx3ueuZbLbNZk4zhc24aOuNfhMfXiZ/uWoND1HzpMnGRdfGVihFD+g?=
 =?us-ascii?Q?cLtwDgrytbNWoLGxbY6z7OBLkNXlR6jy9KBVvy5HMEK8nQJSV5oRsOp1qIXE?=
 =?us-ascii?Q?bJjJedC8CfhGSBiniPsVtrtSyeRUsTBO75dvl7uk1FF34nv5WsaKSPh14JtT?=
 =?us-ascii?Q?YL21AtSdc8E71G97t9haBh5ZvTXryesnOygCyNabFFpY6qrtDt1KmOvE7DJ4?=
 =?us-ascii?Q?9GhDyTn+8M95AOhbMmeyD/wYkewVtn8awSeje7K45OOPj6p1DV8jSD3y3DdK?=
 =?us-ascii?Q?K8h8PCd2CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fd200e-474d-437b-0a8d-08de62c75348
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:36.8196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rx1izUIkcgHaUUVb6jsDhyGgPP1YsutbuL6zh9KD/HOvjEU7IpjTp5HZwykSSd/EhOhXdy+jAg6TUJSfSmqgqdIJuyjF+XjBVF1FhQicI5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 36 +++++++------------=0A=
 1 file changed, 13 insertions(+), 23 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index a1d8046f58..47e56dcfc5 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -61,9 +61,9 @@ def load_ast2700fc_coprocessor(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
-    ASSET_SDK_V908_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
09.08/ast2700-default-obmc.tar.gz',=0A=
-            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e=
2cd')=0A=
+    ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
+            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -113,19 +113,10 @@ def do_ast2700fc_tsp_test(self):=0A=
 =0A=
     def start_ast2700fc_test(self, name):=0A=
         ca35_core =3D 4=0A=
-        uboot_size =3D os.path.getsize(self.scratch_file(name,=0A=
-                                                       'u-boot-nodtb.bin')=
)=0A=
-        uboot_dtb_load_addr =3D hex(0x400000000 + uboot_size)=0A=
-=0A=
         load_images_list =3D [=0A=
             {=0A=
                 'addr': '0x400000000',=0A=
-                'file': self.scratch_file(name,=0A=
-                                          'u-boot-nodtb.bin')=0A=
-            },=0A=
-            {=0A=
-                'addr': str(uboot_dtb_load_addr),=0A=
-                'file': self.scratch_file(name, 'u-boot.dtb')=0A=
+                'file': self.scratch_file(name, 'u-boot.bin')=0A=
             },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
@@ -133,8 +124,7 @@ def start_ast2700fc_test(self, name):=0A=
             },=0A=
             {=0A=
                 'addr': '0x430080000',=0A=
-                'file': self.scratch_file(name, 'optee',=0A=
-                                          'tee-raw.bin')=0A=
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')=0A=
             }=0A=
         ]=0A=
 =0A=
@@ -158,24 +148,24 @@ def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_v09_08(self):=0A=
+    def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
         self.set_machine('ast2700fc')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-default')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
+        self.start_ast2700fc_test('ast2700-a1')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_vbootrom_v09_08(self):=0A=
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-a1')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-- =0A=
2.43.0=0A=

