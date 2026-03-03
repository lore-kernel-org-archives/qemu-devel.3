Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0138E67A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQI-00053L-LP; Tue, 03 Mar 2026 01:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ8-0004xV-HM; Tue, 03 Mar 2026 01:39:52 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ7-0005qP-1v; Tue, 03 Mar 2026 01:39:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHCLB/kVlUsB2kmRUxcmmztMUCPwLXUxoLu/5JE9OZ/D+kAjUYqY+R3WQGjokRQhuoJaEqpN/VVXhAuE/7nsmpxLpVF8mavDKZs0PCGXUAY9LwQv5GzNVo9xdZM0J4fIqmzQANo/lyVUliSWpzPTL4ZQdmfcKhvvhx/YkAqT3TPYzYOOg0s5JMTk5FEKqVQXfkASGdcrPKE+lSRkcKFe43uzDgXIcv1Me8RSOgp+t/yvTgCOV9BjVS1XhmsYkZnP1lLC6ddqp5ENTlLsRdEz0EM1LcRVIYfr/Zd51GNgmpM2K4/llTo8edCG9T548F5ah7bBC4hLoKWrTBPRImtpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5R8c5l4tGSYd8JDGr7SW49obQ35y2ZyZ0B4QsopG/A=;
 b=g9d8MKKTd5zEvNka4oG2h4dIO4J0yrHo4xbEZgg12X9bfpJBPlXr/9jlbrGbpKNTkO/HkuJQ76/ZFSvhZ8Sx3RUG7sCq57NOPBj9MiANohXa3iG43E7CJf+1etKL9OQaxzqayfQ7C0e31MTbwE/Nznv9unpWjLclIj2ww74uatA5s7Zyl33HvmSOHecSEGmQgDcFIsQvHE+sNeOLDo4nta+FRvalw1lSA8dRKRJ3kd1ayiMKkIOIrq6M+4GxQEar75wdvGURT0pdfMpptwq4jnQqfgH7pxtTV0aOUNotKj/oC3GdqC6jcSl3SHA2lkTLL3wgLmS9CCUkRGdSyay79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5R8c5l4tGSYd8JDGr7SW49obQ35y2ZyZ0B4QsopG/A=;
 b=l/9JumCjcanHVwZkNT1IBp4AIcDG/pi/MO0QYR7fqNeImXTQdvgACCz+I/hkum/t5P12FmQphC5x9e0reW/yDaL0YLb03kPZMBGmLhkjWzm9Ry1uwJTMofRoXznQR79lmy9gFwqBQps1X6oNMbDb2s6Y/FnVv5NWpDBO4HpZ9h2g1Ql2tp9JG+/YkXofKFO9YqBG9CNT4jngsg8PJjRGsfvMmyTcjCLscb3N1L9pten+XBEc93zH9dI54Xu8+DK+CI4cu7nb1XBYPez18rac/K5ZgRP2DOd1sJsIY+up94FBZNblR9WJpCkibu0BuwK4SKtJZmYxyik5sVOf2g2txA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 05/10] tests/functional/arm/test_aspeed_ast2600_sdk: Update
 test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 05/10] tests/functional/arm/test_aspeed_ast2600_sdk:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqtiCT8R9YEFoqUm1efsWIiVkqw==
Date: Tue, 3 Mar 2026 06:39:39 +0000
Message-ID: <20260303063930.2878300-6-jamin_lin@aspeedtech.com>
References: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: c8315fcf-a0ac-4103-7640-08de78efa531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 16+7jK8rRpikV5Q693JpEKSkH0aLLRtMNts2hfskzaV02h2EJO1zhcXU8s1P0v8zVIdKt7qD2Zi1XBKNPJXKfUnBu7KktsmHz61y4ZCAF1S5grBfwqG6FWsAa4GJZjecXrwA4D61GcJSrZwigBbdh1v3ndCzTUJL3S8imbCom5lsUQhKCJDuHdNiXwqgaIPxJZhohJPrbL0cZ20d6cP9cjEvhX5axfZxKFa3v+nCYY6/cXiNLKfCW+Dd56NF4viCrkgDToZlKud61jDfiKrVPI2QlX9uzwtBrIH2kTMI5ayCH2KcVef6fh5SmrL+JmhxDSL7QqvPd+qQXXXm9zNL23LmpjdJosg/Mf9aPHItx78DUrlcS8YtwJ5Kfw3UWa6qc1gB6PDIkSmmWs2/4EuVQK9AGjnMT1tzcK3DHVMFAVZV6Dyv+g5KCWlwyCXLj1HxpPBT/b93flpk3sFG8Y9VZ0n5js5/JojadGWhengNo3gV69GgQa1p6mCTuDe6q6IBHfx7QcyZZ//zig2xijr0Xfrk/Jrd947WVCm4BH1IbHyyluGNEX9qr7CiLZDn0PqIArugA5855vIkbH7CliQZtmTfgw44CNV+ARHOo5vvtL0P/3ziEdyzFaThpUgwglG5TSa5LFWDzFGD+rr9dveuoBmt6s2Cms9Q+/20aMtF961VqwAupvPlIL3SATNB/MK03Dfrz03tz4scaOuZiDwIUqINBv+hu7qAT6kJs4D4dhWZJKdOmH6YassceG/cpCK8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CDKoQ/szIr8f7S2dJA7mOsR25kXVXki2oTWaEvX1aL2hzepg9XyE6Btk7G?=
 =?iso-8859-1?Q?gvjj/Au/63oyZxbxGcYpCk7zNI8PLWr3o0oe/20oZQ1OiUkcud6nTDUizk?=
 =?iso-8859-1?Q?4GhtqgbMNFRg6MWS/DNtzOhLXJ7//f+9OesXMrOM7j8q3MZnYuv0wsiRxi?=
 =?iso-8859-1?Q?S9EKBSG4SYH02xAFUnZ6QD/HPAb6jPCpMYZumggLvt/xQhWsPQj0nIkgkd?=
 =?iso-8859-1?Q?ZHCRhs1yywt9qMNYQ6s0CuMtnQoqD4ZRHbsyJGrVCR7n8zZmNX4ou6bZ5f?=
 =?iso-8859-1?Q?iA/mDXLeN/hnaCquKiqV+KrqXGimqyY6lVjKr9hh3wXJE9Ih7XvtVtBgSz?=
 =?iso-8859-1?Q?HL9J4m62dY4GbUGPSb8MTitTHGCAN4ObitP97igkgMez6ObCB4fx/Um9jn?=
 =?iso-8859-1?Q?Nvms0OONl0GevM7moJkkfKSbhxPgv0cFjX14iZAWyiR+s1KGeyOpPFy/Sp?=
 =?iso-8859-1?Q?aw+Bhjg3q04iDKiahiJptru9X0Q4WPrZDoQmWkqVyGZB46I6ceroGmiEKm?=
 =?iso-8859-1?Q?X6WnNLnVm1jVRIagOR+JKeccAj8mTPC/wujFudhOLTSGDK05BA6xMByi74?=
 =?iso-8859-1?Q?oRlHyJNIb90T3GoYolq22TM7a2g9ptXq/y+vYMOjnUGruoTaSlR+DoSqsl?=
 =?iso-8859-1?Q?XCnJP70/A0gqEwzJ+K1kexjjyZJZiRmx+4HuY03uSoemUhxzlTSqnWFxzF?=
 =?iso-8859-1?Q?niMwi6HbSrQz0mvc48/l5UByb9/QV3ypY8Yd6f4Bfxy3i5VF+9vZACNxKd?=
 =?iso-8859-1?Q?uWTE9fybYpd4bpYMvOY6LZrmyMZgzzQLStRL4pSlksz6VnIkrLX9nzqHTI?=
 =?iso-8859-1?Q?TspiGbzzYGbtqA8ITMY3DznnOZeiy45Xy4/0By2LBKHS8ZppCp04uBUmgd?=
 =?iso-8859-1?Q?xEupeDhqYhWUBfXuJLlByiXPzmgedW7vXynNL6CqDhDv7T4J/OXmHv3WEb?=
 =?iso-8859-1?Q?dQ72sVpTZ20L1bFxNBD0eYZuWuopqepExTJR3Pz73k61owXw3MB3XgtyPn?=
 =?iso-8859-1?Q?44MQV3SSe83mj7U0geuqxybQOQiy4FuXxebDEFcEEnj/4vO78zMKLCm0OJ?=
 =?iso-8859-1?Q?s5CliOpavGRCTJFPAeVFG3Xo1Pn2U7bLkELYKQDcZnQgoDb6MJEbD8G+T3?=
 =?iso-8859-1?Q?16x8ExyinsPI0I0IEEZP7WVdZkWGvpayK+dfmTQZXIYI0tTgFPT76EOItR?=
 =?iso-8859-1?Q?wazwV8FQMJpNjtUI7kpLMVxon8Qt/ou7WVPjCVc6y2WyE2Jy2YKCIdJfyr?=
 =?iso-8859-1?Q?FzA18wtwGZOjV2Qze3jdhYAAUDF20vyxzQVbC10L/A3rT4IlgvjFkF91dp?=
 =?iso-8859-1?Q?DzaI2MX5KzyH4QM6SBtPBPjll7iM722xl/ImSOEGTFX7NStr7WDOrCrwZS?=
 =?iso-8859-1?Q?7BMnVC19d02/sqQtq1g/FxSkiTKb9+U8fhM2pFZfCV+WZnmQA/aIIUrxIx?=
 =?iso-8859-1?Q?VodpKlVAO4ZptOIhMzzlAdODu0Sgf1pZDt9qOj2Tk3E0EB0mvU+X6YNEYz?=
 =?iso-8859-1?Q?P+7G0NZfj+1vmg2+YaAj/Ruog8h1BFR/NMQPJRYZYUpc6ME1Ufac8Vxn1A?=
 =?iso-8859-1?Q?OEi3vOEZatkUL1GqSef13n6/7qr9/OHWFzodVanUIkzL+QnG3YYD5P1MNY?=
 =?iso-8859-1?Q?KDlGy2XPl50vBDI3xN1bilKkF4NNxBoFou3MPfN+Wa2b25kCq76ElVAwCU?=
 =?iso-8859-1?Q?tt+MyvYBZoL8zAcQ35Gz+vUPjB3JIfMDdk9OEiCBWE0HAr1brNmGeG/7yu?=
 =?iso-8859-1?Q?KVbl69JqRB+UIGpylO/aW3mW6V49FeunWJOM79ZeC7uCjcayTAN3B3KCxb?=
 =?iso-8859-1?Q?5Aq9gvXaWA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8315fcf-a0ac-4103-7640-08de78efa531
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:39.7051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kL20fXkvYlqlPSe1VEVmLn/OgdzDBQjnfCJ/H73qklp2PihS6L0WLX6i2+nd3CDquVTi/UPSkuvWlQBX6W9ancj9H3hnSgTJPwkkM/673w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index 46b9f7058c..d787e90d10 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -14,9 +14,9 @@=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1100_AST2600 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
0/ast2600-default-obmc.tar.gz',=0A=
-        '64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93'=
)=0A=
+    ASSET_SDK_V1101_AST2600 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2600-default-image.tar.gz',=0A=
+        '3c5b4d4ccf27b0d208a073f98426db54cd751b96143180cd15df1a83978f832c'=
)=0A=
 =0A=
     def do_ast2600_pcie_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -44,7 +44,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2600)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2600)=0A=
 =0A=
         self.vm.add_args('-device',=0A=
             'tmp105,bus=3Daspeed.i2c.bus.5,address=3D0x4d,id=3Dtmp-test')=
=0A=
@@ -55,7 +55,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         self.vm.add_args('-device',=0A=
             'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
-            self.scratch_file("ast2600-default", "image-bmc"))=0A=
+            self.scratch_file("ast2600-default-image", "image-bmc"))=0A=
 =0A=
         self.wait_for_console_pattern('ast2600-default login:')=0A=
 =0A=
-- =0A=
2.43.0=0A=

