Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94EAD58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEx-0000Ur-7I; Mon, 02 Mar 2026 04:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEn-0000MK-ID; Mon, 02 Mar 2026 04:06:50 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEm-0005WZ-1Z; Mon, 02 Mar 2026 04:06:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8P5m01ZQcP+ks6V/sWGGzqy9IoxDNnD/AxUhbkcTK2hBeyy9G2iacyIyvHh1Lo/8tW7Y+YecXYD+MUbpQOZqo657YDOW+WemNONwd3usjneI2/Aj99QA4afpZyfcnchE+B8IiohyXuJMAChHDCARXJTsut+0va/VfNqw5USNomRgRAI+iCrEVJdm4Y6CPOLyPhT4xm2pZo79EbVKhrva/vrvbIFHAOpAtuVlb9ti7f6rVFuGFLRPE6PtXoxM6ixUT2/nkzbUBxi8qImvpx277twa79KO1PCZENHhdPzvK4UYqQLjNWg2WeELLS6Aqv3oINdP0o+Gpv9OkPmHRFo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sJ98qPDgnXXwYJ0z/VrAZM/qZtkBxNadGJvnJodStI=;
 b=nPQ/M9S7oJk5NUyD5/KdnNA0IWxaO7R4/R5Bvqngx34sGDbUCOlVf6/H2O70gnygxr5lwEQy/D7owOMkOkUFtWUAZPLa5q5CQfW8gQIpUj5ufBCwvrQ+TwRuGGpb/pUQVGqJfvpJ46NvErG7E1ywTPt0orLVg7BEuliiOnZxDctbcSm1Cpp4sv7/tVYpFamZb9WmL51nyL4ecegqvzelQaJgXtTFNPimfglQBwBm+d0hQpWC8efx9tYhMI3zcW0mMmUZwEHnRcgBfiOx/nbIELXINIXt55ab2LAqqBB+e+ME6DGSEbaubY+trhSeLG1RnWZBiwHNmmDV/K2GeJbzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sJ98qPDgnXXwYJ0z/VrAZM/qZtkBxNadGJvnJodStI=;
 b=VlPO2jgkPB508XIzLIe5diO4T7XGy5OtuZfTNPx1rym33HgQ8UrqkfWtkN+jSRO2QaDGf9LO4eQchpF/nJl/+QfhM1GaMgYPFnUbPKO1Wr7dZOx8kL1jx/1QVCgH7r0Ww5SLpMIYZReAh3PB1vl2RLeDyRYlcDnEavB1YgNF4XAgDiHdXW5dYHuyJCe2ZZC9WpDK17+Gr81Oz4mzur8m0cnJlXHq3tdHRak87L2yWkx0S6klbC+Ykx4C6caC5YqWoo1FEoSmzP6rKKrsQ+BsjcNzZsVLG62nzSbBR6BuYz5J5PtF292V+eX2S5qCLLs+HTttEnKrUN6qj5NrXCvyJQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 06/10] tests/functional/arm/test_aspeed_ast2600_sdk_otp:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 06/10]
 tests/functional/arm/test_aspeed_ast2600_sdk_otp: Update test ASPEED OpenBMC
 SDK v11.01
Thread-Index: AQHcqiPdCqTplNk38EefnlDa5w/gmQ==
Date: Mon, 2 Mar 2026 09:06:33 +0000
Message-ID: <20260302090624.987922-7-jamin_lin@aspeedtech.com>
References: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6134:EE_
x-ms-office365-filtering-correlation-id: 6ec3dd71-276e-4a86-aa95-08de783b006a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: DWRosjU+s3KOVt6gObyhoMiOT0AoziisZ7Vjiu2aAGQYJLOBXoZfR2iLxZVQQDKI499Glx8IkBlXCSEQraySDgHEBJ3PjTAiYZcY4W943cysfFQ8DK3JWO68jSM3AaRy+nnL9hdWESuevrW16KGxK9kP2woWqfFWrjqMqYvhsKx3Uh68HBpgtrVFJYhZ+uFoItvqXfULJA70IUSWdqibHnfDm4a3cGGtWuRCWab5+QLUFesWwgLT3ujZwnGcFwFuMhOx4SIsu+yA9R/3rKVp4dfYHpSJwp01ZjXgr/3KhB5DyGq4B1MsHpCiW3BRX8lh6b1q1anlsO2pK/65SWmqLTDzE5MePPKhyfe+v0yV4Fw4mQc14DL1lq2wQiq7R8SU1Uvge1qV4Xba8YHrh4AFudIU6JVF7HcdXPQ40Wj0hZlR8OU14VHALK+QLCeKRBHiwgETwxzxCAs7VZt2rhrSydCjlUAWUv6/3EMwTHH1QeLxgli9bgU4wVPGQgpCHDvGyPRdDkM60JQQj2v03YdCBSutAtc3fXU74lyDacCxPeFG7hP62FMIv7K3v9yS+ko8r5f+hzLcf4gipG6jeW/TaAHXNyboia/7IXxOQqCCARF4BmSiUPMrl8qMUgWnVOX078MwxRtnIhTDwNYfmQ/fXEPObaZSl4acwsD8zvz+Y+xYHqqZ2EGJD3XE2CTBbC3jiJb0xxe9D5v2CVInTBnA+X1uM/ed5g8CYtqABOucg159gHHS+cidW0WN/My6kg/0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7mcCuY4TZd8ax6BE7s/546zqdo/04pDe3ZBnbwlNfeUTJ/GUmFI0SwBLGe?=
 =?iso-8859-1?Q?kkQelAKen6tUNip6W210WHTOFmadrK18OhIaUACn++ltIHw7UlOWIh+yS1?=
 =?iso-8859-1?Q?z8QEZ75ywmnsZN1UEx998Cb4FASkpjKkCiTmQrZ7x6R1WWhnYEOT+nI6eJ?=
 =?iso-8859-1?Q?isIEVE5isYwMsDg+cKcxNaaEyy1fDQGxC8S+WdVIfALaCBs5S8LOBMOkkj?=
 =?iso-8859-1?Q?33w7+vpduRQpmyb7kRnYXQZWXrZVxLxpdUJONQHvVSJS0oFonm9kxeUlmp?=
 =?iso-8859-1?Q?vTB84OnxD+UbuoUWqKEzPZTjb/Jdbs+zWzkE1nREVknh2lNu6QNRqMNn7d?=
 =?iso-8859-1?Q?/Q2Q3z3LqunbqGtiUh9LHZV+gFjrOZAU2UBmCHo/6lkGSUG9Euogx6cNxF?=
 =?iso-8859-1?Q?xk+Nho8Onfv7H8rgXqtFT0d0uIuT9Vh4t6C9V/dm7ZO3J605xQJSFvo/Gc?=
 =?iso-8859-1?Q?JJrhP4qqPoxDzxtroZJa2R+t+MUY1v9ldpAdr6/5ipsZlLeHHCfOySVtE+?=
 =?iso-8859-1?Q?cZRrfkZjc1M6FA/dnMfh3shvZx/SDQmSIARmUfmoApAtnNrAKByKokTdHD?=
 =?iso-8859-1?Q?NXZv2tdzUJ9AIVOEI91EmDbVNTqw150E2b1Y+bjMSrrbmOEjFCRTEoEe4B?=
 =?iso-8859-1?Q?rSE4l9VkmuqeU0zbWwUceer9wEY2+aSCcKU2esST2AxvVMovciT7hSNRRM?=
 =?iso-8859-1?Q?64gT/tGt0VKHeX2TYRcStdSGOC0/LrWO9pj71+3srx0LaL6kNYK/f4H74p?=
 =?iso-8859-1?Q?ONxziKyvyI4WjjRuVUpUUaENfTOLMVYKcvYHZr6/8/opRp6NczSZitRwgR?=
 =?iso-8859-1?Q?mvD+layGZMGeNUNHRI9HOBfUIvcCXUn9hE2rIs0aQUbJGTpKuslIs5UgUR?=
 =?iso-8859-1?Q?9wpVQ3XBVXVraMgs8M2OFBX9OVvfLM4cxa/SPGnukPpATAmPSv7sbkMly2?=
 =?iso-8859-1?Q?ehKqTxj0sz1x4DE8jgMEyWxLBAO/P+xQSLEHxP+vsq0VVE8dHEqSZiMO3Q?=
 =?iso-8859-1?Q?WVvRsRIskN3sw3QUWbr5H11LJP4RlcWlr2l2Ab2KuIIVdbUGwdPHgs3M/s?=
 =?iso-8859-1?Q?sx5PLbSlf1ze+Wi4LUhKx7wVfP/TIEUE1AA3U+ygR61BCIJCjL0NLMiZkD?=
 =?iso-8859-1?Q?EfPoSCuDvlXpbCSN43uSEPA9APcXxGSZdRsaKuZoZTUD4Hqxw+4BN8QvyL?=
 =?iso-8859-1?Q?ezWDvMPpod4540kEEIGLo/mmwDLSX4yDI5dCOJPPRO6+ET+BNUBKNSZyrY?=
 =?iso-8859-1?Q?B1UjBiYH57szQLwDCXBx7UQBdNrmejRRIO4iG9uJfHvXXDVQYqG9BT84ZM?=
 =?iso-8859-1?Q?6nO6R7p8lJz8OqDAcECW2oZlSKs0WQOPIF4mBRaIMlh39ytCWGXY46pi46?=
 =?iso-8859-1?Q?l23glYAXqts7PWLgMb3IDSDXz/8RSqcnxhuOGLUzyFvoDm1GTWucOBu94y?=
 =?iso-8859-1?Q?MwKdL4bhk8gWnwrX/dWgxr84ScB62gvrqL8Pg7WJrmF9bf9LxNtxY0T7OF?=
 =?iso-8859-1?Q?aIbu6tEYOTtFT2J3D7TPyG7PsBjgMtV5ptmO0NQPka7npe/XlYxatIzT1B?=
 =?iso-8859-1?Q?jiz9JKk845N2geE+T7xow+s4TLXEPSyeg+FG1z1L7lNmoKN20MTksF6LKw?=
 =?iso-8859-1?Q?NTlvdW69Qa3RxwFPK6/KMh7EZnIiJAaZGFkLlTfQp+1Yrcvek/cw7UYVSr?=
 =?iso-8859-1?Q?aA7TI3VZNZKzArvt/TRwjnS7aF9eu/58yFZa7ot6xrqIV6zWMyxhqI/rye?=
 =?iso-8859-1?Q?+RpxEH2cqDLSggMvqYvvnrriHGffffT3XnRYfjRcZ9BUdqP8lTPLMQPMjy?=
 =?iso-8859-1?Q?wBaI+KXPgQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec3dd71-276e-4a86-aa95-08de783b006a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:33.7459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnnNvITEh+xE1CzEHrktm61YIeKRdGQfW+FYA2X20dcawePU0IZN4UOVd0Pa2Vo5vTqX/CKU9SG9dWXsVBsXjA/PNobPaDlMRBvY3OT2HLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
index 31a1c3bed6..f24dea1e8f 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
@@ -12,15 +12,15 @@=0A=
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
     def test_arm_ast2600_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast2600-evb")=0A=
         self.require_netdev('user')=0A=
 =0A=
-        image_path =3D self.archive_extract(self.ASSET_SDK_V1100_AST2600)=
=0A=
+        image_path =3D self.archive_extract(self.ASSET_SDK_V1101_AST2600)=
=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
         self.vm.set_console()=0A=
@@ -29,7 +29,7 @@ def test_arm_ast2600_otp_blockdev_device(self):=0A=
             "-global", "aspeed-otp.drive=3Dotp",=0A=
         )=0A=
         self.vm.add_args('-drive', 'file=3D' +=0A=
-                self.scratch_file("ast2600-default", "image-bmc") +=0A=
+                self.scratch_file("ast2600-default-image", "image-bmc") +=
=0A=
                 ',if=3Dmtd,format=3Draw',=0A=
                 '-net', 'nic', '-net', 'user', '-snapshot')=0A=
         self.vm.launch()=0A=
-- =0A=
2.43.0=0A=

