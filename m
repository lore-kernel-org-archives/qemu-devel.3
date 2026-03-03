Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC2E67A71
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQO-00054i-TV; Tue, 03 Mar 2026 01:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQE-00050j-6S; Tue, 03 Mar 2026 01:39:58 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQC-0005rT-G0; Tue, 03 Mar 2026 01:39:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUZXM8NusiaX64TyHhQ5Hu0/IKZ05TERb3Tv86dWTUR5iwZJ/3rbwEJD3LJdKhJ2hptF5xdej0wZe/RBt+yRELLSLWVLlejU4M+59XO6FuWeilJqsDxF57lxGNHUf/tMTKoRBeBVicaSkCC1M2nhgVuhODSW6xXLocV4ETi7Vrh5d/dMmKfLAu1pLw7jq/kRxH7TWRDFzcJnpeyho6lzhLUKZ8f9sNdivTq5tRVWE3J8r0L/67PGAw2XG368fS/fVZeMMN3aRGV5CjKH8eGcYzSEYclBI+PYDhRl3VUFWHWjivKGy8m/kuZsbXABmoYl1deJP3vmkOsDRAjtmXeKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCV3Z26BKk/0GXuFaHsZew9xhFBrlIfzE5nznCSqtPo=;
 b=H9dqLYlqYMWA58JQdBclqz7g7iM5bQ7x0A5rNG6c82jdpyHTsVc7pu4axkcm4v2tcLeyyU4YhaefpEzineF1v5aBIxdcxUPaUuOQSBrCo5DS7YJRj5+c5FZbxGMasuR92+cSGjvvOyU3mjCpH1cQKFm2q8d22aE7pmBojbJEK1Z7qTNL3mfzkv5xXsCmp6UmAkphfIG/vxbY+AVgr6Sr2geGF2QfIgAsv5nlhGy+O+XrdMtx6Xn27iq9wQXXOr9xq44HOGsZp4bFucrlhnPn505mWLW9jSwm35Fisi0Cz32ZC6Hkz6QVC+FXox175TLGL5DYL52MwDMc4J2AKK0tVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCV3Z26BKk/0GXuFaHsZew9xhFBrlIfzE5nznCSqtPo=;
 b=Ty5rd8u5Vq3RdItz4LqyJMxRBMFzL7htpxmUyC16tn/jKCmFYnCSIdOEIGpK22jYU7V6Pcrj7cq0bovohLStqkH3oWtYHkuEStP2SOTPSW8PdbV1fOo4athKt0JNRqGAPAhS15tHeQR7Opkyr0Mc0qy+79XN5mXUXqsiGn8B3AZ/nHHV/s0Ij9umqbLx3fWLwm0qILK9KmB0G6c+UIMpzhMpkBjCJZYdJBxUtRrwHzVk4JCebqTFY4M4hl7CUsFst4VDZ1oBfAdxog6oujfPk0z+A88BglNN0wxELZ61KekpHP3No08Z3y7jIsM+NneAjsd/H5vPfFKAK0vFsgqzhA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8022.apcprd06.prod.outlook.com (2603:1096:d10:48::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:39:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 10/10] tests/functional/aarch64/test_aspeed_ast2700fc:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 10/10] tests/functional/aarch64/test_aspeed_ast2700fc:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqtiGgD9dm0yMJU+1NXc4sdx9Gg==
Date: Tue, 3 Mar 2026 06:39:46 +0000
Message-ID: <20260303063930.2878300-11-jamin_lin@aspeedtech.com>
References: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8022:EE_
x-ms-office365-filtering-correlation-id: ed2ce233-5e31-4b4c-2481-08de78efa95f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 7jxq1CEi+19KFs9iy7oVveAadm0EGf/cCKmj74b9xp8Ho8gHi+r6OI3dCAPrBlJxSufuK6A8HPoAS4CEWeyX3IVSgyaW5hCg0ZiqfaIQiAWErlI1hzWA9y0zKMw2J+SE1hpxA89cL3hVzgvrftuI4aa+VLVWZip7rstKRmiehR4iPSsT7trhQiGurMNjEWKotjc2tX9cpTe+WrvBA2LaAcGm8F4biFdl5K6cp+bfd5lbHyzkRb9uGH5g8B+ulnYn72p9LLIDzIJljZ5KlcbPMHOrxufGycGsQLxKwsPcSc0c/lG2Q9h9nniT1nKmM1Q/8Slyr5busbXlFkFlcF7AbW1MFcY/GW0JmMKPYSpxOLj6sSfPeJ05+b+tdXzDR0BAABfDmN0BXwQhAKiOkZ2X+hh2+IkAr8J75vwO1Pw5doQSj9n2xvDkeYkO9DNnDsDilI256QaHbCan2uLk1eh5WsoRHw4wbQNfQOseoP/xg61i/fXS9keZP0/6soKZBsF5LYgqOkfvrZ2ONZBqIjKnf7JptXE8i7tYlH+r9uLeuf0uOi6ivKnxxuZvky/uQE1lvd6sDPkGi7jeBh46RKZRp99fAoaMKU7f/DaBkjz7yO4Flh1Lo3hbB/J+8I8poDUc4ZXYT4XyXOsquoSU/EAtF4rj6QuHcxPPbDtzWjjzWsAqz+gBZVtJV74Q7iHQNMdhiLDEuTHXfqa1O6Oeg84/UiWULOueuUNAeZkndeONNF/sZj1qixiHNrWQorqrC+T8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GEcKV+J62rMo0Bj14BARa8CfxsBIn9Ylg9QabeiRf25OwZdzlpZnd2vbmx?=
 =?iso-8859-1?Q?kSb16FBkx8B+U58/+raoyYWBTMc81Vk5Aynp+K4CUMeyGDgZeSWgeop0cA?=
 =?iso-8859-1?Q?FgaJdtDYdktLq3vaMHeWZlyYiDrf2F67LvFsTK70MnHStJUZ/1lhQPlTIi?=
 =?iso-8859-1?Q?Ml/aeHFg02EzbQUlBmx8nMcdP/i4whAxLjERvtmzyxNoYbBjvqf30WchFW?=
 =?iso-8859-1?Q?FRYZFEoP/KePlhOotZ8t5rFeItI1CpnN2rz17NLUPhVn98sxzksi85hhHe?=
 =?iso-8859-1?Q?dn/2Eci7u9LRcmqzxe/hX91npxU9lqj0b3BVxGYJ7OVV2S9dfNtB392ydA?=
 =?iso-8859-1?Q?Wnd1Xqj37+qL6rc4jdAW2dhTgs7OKwoDTmNXJomgJvdoY2VZ37X6zV6JSU?=
 =?iso-8859-1?Q?nHnUQV0vhd2ydN8h5XvGSCSCzFUqjeeHhdhnkymrjo4YrEIcDkszG17y4v?=
 =?iso-8859-1?Q?fV61LRX+QlCBmhY1+kEfPPPza13TSO+tGmIWxktp6m9JiQljN9dfgEQedj?=
 =?iso-8859-1?Q?IW8Er0pmUinzlD73S3XTf6H0cxn7Dnb4ZcwSNNiXdbZyNmHhriEiRXJsNY?=
 =?iso-8859-1?Q?qQYljZFh4bLzaMC+eQ8oLsTg8ninSMm0GW63A9w2k3xHCKwnEdFTcVFcxz?=
 =?iso-8859-1?Q?qk5rxYN3Vi18D73HN5vbHdy1HOJStiG8Fd2L616383GA6Z/MzW44FIxFhI?=
 =?iso-8859-1?Q?b7yFs/odVvjtfx4LbkdfkCWxAC6IMWMIDvY4k59tuaT3H/QCtDLQ+dN9iw?=
 =?iso-8859-1?Q?NpTaT/6M4ulbECpuWrUwVodjD0kSMlxdi6MmzetlBmM0HCE8hwJBh2mROa?=
 =?iso-8859-1?Q?wR6hg+JzWTYFn/T11zR/abRuCb6oCnmsMUplrObvPcI2BOIwYXz1XoTlPV?=
 =?iso-8859-1?Q?IqNHHET9asNdf9Zx31vbPhaxMvVlHKaXb4DhQysPnGK/ASGTQH/CHAw95U?=
 =?iso-8859-1?Q?geagUGusG8UimYJ1W7cLv39GgBlyLWFoNpwyZZ6Ya68Pcp0C9bOkno+pb5?=
 =?iso-8859-1?Q?uzXyeX10ErSd2gYLciDe2lr73bdgFRyanyUiUKUv/m+19bLREZwAXvpnDR?=
 =?iso-8859-1?Q?c0yv3lVqIk2dqpmkZQ3oiScAKrphI009ERwzvTrHNAbiGKScwkz+QHtr25?=
 =?iso-8859-1?Q?mR3SoEqm3PPplv3yiOmpQtrAfsRbUABtXVtv1PUtILAAigR4Lv/EzgYliH?=
 =?iso-8859-1?Q?KoH8aCKvnMJlLWXEYxfcDPA+abkhvjEDeT+eZNIwkUnOkKIYYnbqcjx/WB?=
 =?iso-8859-1?Q?o2BRgpqbAaeqwu1Pzs70c4tiiAFixrhfvircQtu1OfN6x9Xd9lHI3Q00Ju?=
 =?iso-8859-1?Q?a4jPcok5pddiHqp5rLiRiQiT0b04rJBmz1ZRzDK/tZQJtLgIUGEW9DKzNP?=
 =?iso-8859-1?Q?H8fumaMWfY+vxXlPyIbEEPxH8hC30cC9xfgLnQOky4LY1SYqFXRHXzPm+4?=
 =?iso-8859-1?Q?JGbfJEsIyG5OOC7IeaCkDMowdWAPHM2ym+pkzUhQP9Qmr0Q3X/JVJ8OSJv?=
 =?iso-8859-1?Q?2FoMq8DC5Ssm+y7ch7rueI8KOzpVv5W8A0VamelsTAHIndeDA7zqVzVBCa?=
 =?iso-8859-1?Q?AkEXRfdP1OsiQRLGmSWoDPsjCPq28E1d4wsxZuRDiey8awSM1HKfkXAyRL?=
 =?iso-8859-1?Q?vHN53TzgXqQ3slfm+Bf7JEPc9JNDLpCU8oNSe961CcYBjIJcWMrbMtSkLZ?=
 =?iso-8859-1?Q?NHDgJ9ZSvHC4DXCw5nDwMFn96pwbUk9Qgmbd67Ly5z+6r4QlLNAD8CQe4G?=
 =?iso-8859-1?Q?luUEWkH5SSHS9Hxmv0iZWDK8Qlz7NB5rwmBr3mz7R3l1yYOeCIFE1RIg97?=
 =?iso-8859-1?Q?2P+cIs30Sg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2ce233-5e31-4b4c-2481-08de78efa95f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:46.7139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euNfPAupHa8QWbQ4dgt0mJAp7ppyRHX0OydRkqkhisJEexNNcFCl9ENOueTYM1wWhpNAbzQaJ+1k5wU2leWZNiiJyjVykGw/nPmrjnNgdwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8022
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py           | 18 +++++++++---------=0A=
 1 file changed, 9 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 51ee8bc787..f68f40a1bf 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -61,9 +61,9 @@ def load_ast2700fc_coprocessor(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
-            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
+    ASSET_SDK_V1101_AST2700 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
+            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7=
487')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -148,23 +148,23 @@ def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
+    def test_aarch64_ast2700fc_sdk_v11_01(self):=0A=
         self.set_machine('ast2700fc')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700)=0A=
+        self.start_ast2700fc_test('ast2700-default-image')=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=0A=
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700)=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-default-image')=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
-- =0A=
2.43.0=0A=

