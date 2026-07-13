Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD658C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7Ko-0000J6-Fy; Sun, 12 Jul 2026 23:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KR-0000AJ-45; Sun, 12 Jul 2026 23:27:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KP-0006VO-Mj; Sun, 12 Jul 2026 23:27:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1k4hx33iMBUIwmNdg5ExhnCrtpzVvYGvmkiHFPPJBip+8yJtJxt9GWqrEiuRhY4rgCer6V0aVnMVhO2O0dMopUDdkdq3v4A1tH28vvqtYfMqPXl6l9BAdVf6rFYA4OcM7LNzlLETB+d6G3lQkmsCjXSimsZQwzRlFcB+TkLO7pjtSb4iaHq3CMGZL7FZk8y/J+BdvWu01lq9Us+l94LvsPbC4qf9OJtwNBFhBslZNO5jQ9LfgI0ia7kEOcsbx7tULjpeo2LyQ6jaCt0nsOdK5yTTw8p2zp2tGXkOkJoOHyw5HoFZSumuex76jfE8HEjPwzDfzZFT5vo/c4ok+8ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZmRshDm37UDSuBxiuaZP8DuMMoer6dqKwO/mLKFHAU=;
 b=qO9Bqp/asmvP3BKAp20fmUECsj9foFBVRRHPTd1ejdr5ePxPPQvMQWyt6EwZrkvDbdsYVqy3dEMhFSy9G72ZW8yywCQUznlzIMF1El3rYuMp1YJX9hXO1PsNgsdnQ8HuMeu7VelQwnx2A/qItiFP+7flpyJkX0BYZorTgjFNAlYTiIxYdKagalaKxERhsYG6IPouxvmvO3l3NfCTFKh1MQLgIu/f5zvfEtRDod72rNrJEBZUVxWucO5beUHb8g5imEgRGafhomBRW9LfIIdVa2eEj8O8LjuOuM2KQilOHcp4NwdvjdeWJ0KLEQemyhkfyU1tBGnrxbJu/goMvhLzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZmRshDm37UDSuBxiuaZP8DuMMoer6dqKwO/mLKFHAU=;
 b=jhpwfP2GlsAdSIZMTuPwC2k1hcDmAJjFSJC9hyPmLB/sxOLRAgdFypLO2r5Dx8Vk2gw8Jv76aJbNfp9WgbVeYOj+Rjg6GZVTZoU/F5d/56KgpTXl6p7wWJW7vKXN1FMsKS4nc7itTWFT4LWNPzPvI9nFTO4/jzT9nbNM1vrJGvoeSszJgtogPExcubINmBoG5+pcCo9sM+OpJm2ETCuDjyibyJpwbV8pZ46gJXmp66w27QfuWc1d4vHtYWKp+ue3ERtkNjBzPyht9FLQ3c5Oo1+AUs95dJeJYStnQUE3kRbx3iyyUOQp66dvQLetkChYiTKPe3b5jdKODiXtHFIOxQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:21 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v7 10/10] tests/functional/aarch64/test_aspeed_ast2700: Add
 USB EHCI test for AST2700 A1/A2
Thread-Topic: [PATCH v7 10/10] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
Thread-Index: AQHdEneDYCyeThvonUmab4W0U8HE+w==
Date: Mon, 13 Jul 2026 03:27:20 +0000
Message-ID: <20260713032704.3583103-11-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: 9f4e707a-4f35-4f13-340f-08dee08ea5f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|921020;
x-microsoft-antispam-message-info: ZHnXwtj4rKpBOoHjB/243SMJNQmlzXFDM7T2y/n4I+ZgvzUqHo/Yb08cE5hHs/50aGFrRctXrkTOAFyHDRPko6/VqDJEE02jooSCAPiChjkP1J5VNAfANiynytz9D53GLBw4mbmcQ47oRTdtyz/ijIr9UlCOivdbGZz6cEvmT+zK61kxQtvsORYuBag8TSv61gyB6Ki/wegY04Hf9gJfzDiqA6DEfErGhYGEXGJFrPBPWMV9NIX7AZZeOi2AGdmNBH3WW1z4njxNFJi8nDwJ33mR5PBOJRqm7UzYY7PYHtSBxgCMr+05r1EnPUibbqO3wZu8hJwzBVVc2fkWJ7ARLdi98dNWb5D9BwSSrL1cNybUATPMXQBeA2tRXUcXiDFfTIGlhgAYqri5iLwuqqOVhUJBRTRyQT5WnnOxKLW5TBxXW+kSFuO5qrb9ddXfudAZrrmRiav1VDuVnnMVLN/wUSq/AOZiWVF4R3wg2HZs9M7tpP7woq+rnaOoaZvwSGbfYwKr4LrAl0ORwAKuQRGP93sJ8xF6zscr9tEHb/4gz/sL/7YzYK7LU176gL9/KdWfq8vm2jGqk3l1RWvTBd1R5pSQ7qy0wWXbqMRhTe2uYTJjTHhXj+nGokBjwyfbbcBVXVu2rEI3mOaH6Wc3h6HiF+vWiSC0bGCAu4L1HnUJeL1T3kRK3VwqYBAj10JfBFAhUdfR+pDEAbZaHfHLFZGBLesNOSW58yf3XP1joftZh1Xbhfl5/VfLgAEXJkxaECgm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wrHTbP/cGDfmNMbf84Th9450/1oZNDYiK8fNOx9MY9636E+ROwa1qHmx4I?=
 =?iso-8859-1?Q?uU4R92REtmlHgEt1Cio7elXw79rUP0nHQ1nQLhoerIICuUy62CVNeHIMlR?=
 =?iso-8859-1?Q?fdGHMV0k0qImgR4BPc2mK+5DUZy55LzUUMAHLg5X7mtyvmqhjN5nBkYIfT?=
 =?iso-8859-1?Q?HTJb8coXjcDzMJ2d/9vC9CAMUOCSQAnxsZxR7rbuQuLoPQ6qjSJ5AU6fq1?=
 =?iso-8859-1?Q?dL33B1Qn09E5NRQFfZP4OUzF6Izen8rar0K7boYbiH+RR7n5OtoIQY8SY3?=
 =?iso-8859-1?Q?0B69rtv9xYTIIwH7katqHjXZQYCES377v039w3EpyCGzLjmGNag7q9+Acb?=
 =?iso-8859-1?Q?ohI8Xz6AnAg8nW/aJ+dzmI5AlPmdHJxfL6sJPwRn5EItIBpPpdsu2C/vEr?=
 =?iso-8859-1?Q?3sGwNr64xcQs70bXddL5z2lUY/YAOxIc938mMkYqG/GHg6kFr0Hm1NHcnw?=
 =?iso-8859-1?Q?9Zc8D7PZsF/oUGG/ZjTtydmiCe/S/lUhu6hM/XOIfBejm+KmGLiDPwuI3G?=
 =?iso-8859-1?Q?ShXb1+PgStgFzz9n/5US3zw7Hb3G8uqfh/vCsA/8IlU+oBCks+i+mTH0P0?=
 =?iso-8859-1?Q?KJn0sWlAWnKpt8InB9Jj4SRmbkkbaOO7GsG/m2p5RaSfFNLw0fMqprugqr?=
 =?iso-8859-1?Q?NMly/fOT8y8BFLHY+vIzUCeMbdmbf64sEuSQbiY3czO6U8zfHud5Aa7bwz?=
 =?iso-8859-1?Q?txd8Brjqm4fvTkFM14fhwGRHesuK0tQ+KIIYs/C8YouetpI5siZFQ23G4w?=
 =?iso-8859-1?Q?poJNJdOzk6JGHlQ+nbYCQ4tRVeT+9BWVQEacrJ41zaDP4femosuu4bOXeO?=
 =?iso-8859-1?Q?3DkIuohhuCDvB4lA6WYwMxKYkPqp0B4cq3IIBq/X/ewdlYi/k1kaoMG6EJ?=
 =?iso-8859-1?Q?yY3xofcu9EeHAZSyz/Hojce8ACT05clEXHFrlgm+6jsSIWx7TGAQHC6Au7?=
 =?iso-8859-1?Q?28lI1WtvSKawneaJNmB5IXpHq9zYWTXD/mHKLcBfDkVGZXRT7O08R/w6+S?=
 =?iso-8859-1?Q?reSCFq/j3J47scZ2cveDmYu95GuozomOJl1LyZtwB+s+hHLJe5brxq5wOf?=
 =?iso-8859-1?Q?yQMskY/Ky5upVe9Un9v8z+EWq4ps+5UIkYfVotLZynY/OXF5j+3SEPA/qF?=
 =?iso-8859-1?Q?swenuIkgEy2PhTYyIrP4p4Sd4McJZl8VqiqThZEgtRBC9GIxh++W+CaJmS?=
 =?iso-8859-1?Q?iGvEsnSScZqsgfffDFxteYp04ukzWqw7kaInrk0lbDkPG77R1SJ4HZKWNi?=
 =?iso-8859-1?Q?rW/xLSheMZ9XbBIxZipZB1CgBcQe0kyDpDEIv9AD8aQ0mQ6LSUGWCXq1HN?=
 =?iso-8859-1?Q?sGCqpgAWXKjigFD1sevs8ooQKYQmR4Spn98FyMHNkTpYijGWRGGI2DbltG?=
 =?iso-8859-1?Q?cbwDwlYsjdzA7Z8ClDcDk4RSfyJNbby/UEzOkQu9Z39hD5TSRHf7vU/LOa?=
 =?iso-8859-1?Q?9kZy7WdChkXw/8PxDlQwcOWNOtGhkXB8MEYZwf6Rc5pZIZ8larBqENRUOK?=
 =?iso-8859-1?Q?/Okwb32Y046YUfSlU7u1/oGTiqDSp0+9ZgcJX9BGvFCsLcREXDYfPyNs1E?=
 =?iso-8859-1?Q?0rIdWq+0yoaI2uGh0i0gptH+OSW2IVhOeH0yn2qUKPu0kGKGnAUgLHhbNa?=
 =?iso-8859-1?Q?IZ9DkfDrLhPZSJTvNlghOYTxDj+aypLYaCUrDm053C7eH4XBU+2tScwpM9?=
 =?iso-8859-1?Q?gnln3RhbJpS3fMYYUyO56wiCEZC/5bgHYNzMyZLDEV4LmPr8QplR0nlSU0?=
 =?iso-8859-1?Q?E8gFDbs4JaSIHD6e+C+GcZkLokb4fn1hxc3eIvTyGCy9EeVIExDhqeQtYg?=
 =?iso-8859-1?Q?9IAWwxEf2w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LZazx+XIzbP0CtnRMjR5IkaTq9cOsL0dgD9/hrsg/b2e/8XmgBQYm6VReffyAWEsRn9/dEh13VAK4SsbS3Ca7dyCTgZeYNQuS43dOQB9TN3E8B4O0ArIgkfOdkAH9plGETaIw5GhESUrVW+hRJLZHVe5DfGkE8ccS0kKxNrEsQ3WMRoPM4apEhh4G1xKwhZHCwC1zdGzN3uNdScl8hgD2urZCSBXURjg7Vve3qnWLsnpbkcVibadd6ua+3nNFaXOrTpH+odhU8KTp2nnaYeCfqkfSHAQ8rTrQEewDOzDOzB/LQBQKVNaTXI8imblqJ2GBRZKleBPzPA7DtEx7zhkfg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4e707a-4f35-4f13-340f-08dee08ea5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:20.7058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EG0uxjHdZoLEZvK2PZ52ucZkOYa6qeB11AloPSO0gyWl3TUonDvYDWYncF3Gcqim6YEK77lLG7b4QRDaxJv8tUw/G3m0JMDysMTzKdA/Y/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
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

Add a functional test to verify USB EHCI support on the AST2700 A2/A1=0A=
by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 7 +++++++=0A=
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 7 +++++++=0A=
 2 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index b0c08854da..42b8b200cf 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -118,6 +118,11 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2700_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
@@ -161,10 +166,12 @@ def test_aarch64_ast2700a1_evb_sdk_v11_01(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.3')=0A=
         self.start_ast2700_test('ast2700-a1-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
+        self.do_ast2700_usb_ehci_test()=0A=
 =0A=
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index ed414999f4..40e0ad81ed 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -121,6 +121,11 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2700_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
@@ -164,10 +169,12 @@ def test_aarch64_ast2700a2_evb_sdk_v11_01(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.3')=0A=
         self.start_ast2700_test('ast2700-default-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
+        self.do_ast2700_usb_ehci_test()=0A=
 =0A=
     def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
-- =0A=
2.43.0=0A=

