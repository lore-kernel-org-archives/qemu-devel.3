Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24927E67A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQO-00054j-U7; Tue, 03 Mar 2026 01:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQB-0004zW-5N; Tue, 03 Mar 2026 01:39:55 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ9-0005rT-1r; Tue, 03 Mar 2026 01:39:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8j9rqT4JNzmdaWe//A79d5k9t2Y4se2SlK7p8Fbwjr8AdUjLaYCMuP5JClAvfIX2PxjnIOfrtWnKk/av91e18SI6JJQ/iFspDsgTZLvbg9Idxa2VF4iu0OF40byC/M2hEP4XjrQ1cI0Ss90H+wE/fSRsJjET0suUyhEJT8BChBkzhSBH/vnb77M03bqG43kAUGO8J0+3jF9eLKy5zeaPeIbpULbDQsqq3rfJf+J/aLa52lyMQ10JZ0pTvLN57RpPHnRZomVfajwU6xh3Q/vt2zOaReTqxcbofgPmEYMN1yolOG27OzHnzO/y+2BLgW6+BccpvyW+UDNO+K74Ij4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyDtZHiQsp2DSSTOHyJu/hIADySVtIPBT12EaVAHO60=;
 b=fmTCYxsE4kHJuxAfm3hO9lVNt722zhZxn/ZHdVfQop+M9bOXU/DQZJxxe7/64V2LB9k/BqsobNLw3B65mwXJTmu3f+4jCZ3/8EAT8YSq/dJ/FQnqX7ezajfuanY+pc4C+CzfyPITKZQ4wt2cMMolvNCni5uLPgVC+GFGFe3ITAPYmvxqSCrdqyz/c4HRNTYg95l7D3UnD/wBbuKOPm5m4a299uTnlacly58XPVq3Bu40J8wPigYL1dg3/PX+woNDDjkKhHfgf+9mnBnEsx6CN45ucwnxur4kV5rrJzh1OEjUFAb6UFhWDCVXDdVqVNQxRvotMvqis8Qxa9hY2fLOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyDtZHiQsp2DSSTOHyJu/hIADySVtIPBT12EaVAHO60=;
 b=WMW3CWF5s/gZTBEITccJOn9+PUrcGrYRIMckWRdGVbFqvzI9d/hsSZF/oOGVKB2eiEqhHoq85dVjXYzJIamLXe80j1Oxgdl1EsuEET6cL8lf8jbYIkvbhvf5mF0UqGWLJ2XgMsiF9cYuON+hAnCN1TSpLfk5Gapo84HQhjN9aS4a2o/cKgtaW8Ym982F1FAteu6V/hh9JC6N3VG6yNBAXV3rMojfglcMLFQ3Vq0+tdvCv5tEs7s4abKQMH6sa51QVJelJdN6/3kbPoEG3X+kEMKPJwrgX5qq7qYkRrENgFF599FsuemEj5D6SwQYGOItPKzn+5GORHc1aZigusvymw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8022.apcprd06.prod.outlook.com (2603:1096:d10:48::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:39:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 09/10] tests/functional/aarch64/test_aspeed_ast2700a2:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 09/10] tests/functional/aarch64/test_aspeed_ast2700a2:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqtiGBA9RgnnAsEySH9RH//Ljdg==
Date: Tue, 3 Mar 2026 06:39:45 +0000
Message-ID: <20260303063930.2878300-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 992fbcc3-3a8e-4bc5-1fd9-08de78efa895
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: xAgsftkXcmyZvA4yFhR9tQwxRm4S8obMfZIVxcvExFnE4JkKa4QsI4iMF9knchGniptk3d/mCUkPGwyqNxH43gwaWc86QlyeXamBdAvh5n0UUbBz9sQnDdXXCYFfbNc+UnSuPADnSQBjeLce5uxgyl1oTaFWtSbbe7Mt40zIW7ecSgc4ffifeRtwQEuyfYcusHidoY10kI3cD3KTjt2Dko9pjM+D58Uvw1xpTTXRKkhiDl2dw30wDLXi/6tXOFS+xkesGetZHQr6rbgf7eJy5T0bzubKyTmxHDFz0SYA0t+Uwx0+IrgWHFZXY7voHvCtlDD0vheRpw/qsChsbCifPvo/shGGEnEO1uyHpvq0SlYcfthaans1aY3EDPdgu+xEMFpu4G0M7pROfRiG/DW046p87PHowK9F+qB48fZS1sB4rEXXuKxar72RHugFMFcy2sH1X1+g+rTwkszcxtVY6qzkuQwFAckO7to1JxuEOiJKjfIKTEjHtx9am+qdQ1+LnNSuiovwhj9KhVPS/RbJ3XMKWUrxbtZQUW/s236xjWqg0uxXPH0TDN9HDfDWoDSg1u+U1WsRz5lq2A0jQJ3ds6VOOKkxpvS5MbiS2vAGSG8fJKP5WGH0o288PeWn8jde9BXB57pW4k39onnOsJd8NaW/a5rgLdnp9b8iu8QEoB81BCCr/p/AsdJH4TmuNztO2ZQ8heSHgUd6LeoUMawQbLsTa+UvkY9YJw/NniN7fptODa34cGoc8ROLk5xWJ3WA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p31tQGYvmtRthviBfKiX7hQM00Ye+AaCzqk/b8IK2FtiG4mb1laZ8Vz1f/?=
 =?iso-8859-1?Q?xUCOmxBPpKVgL0sO1hlGuLSFhzjY/Jx6QQB8JssDFSjrIkwE/8f6NMxWqv?=
 =?iso-8859-1?Q?pHLUtnr/7Xcu+5pfmvDu24fMitfZL5SicIez7/JzYkf7GJM61AeJpJp20w?=
 =?iso-8859-1?Q?oJnlHE2JwfsprKvbe3hEPXVqYt1IeAOjGn3quG93xCf+eWo8GiuDPO9OOl?=
 =?iso-8859-1?Q?XICcLKgLY2BQID9r9oRl11zuW1eApr/985ZSjd/HfEcm7YZBFWHSi1w/IR?=
 =?iso-8859-1?Q?cGG9PussShl0cp2RUFamIy7aI4SOWwSi7+Q1mx4xhFn4wv/nBnx/7IyFJ9?=
 =?iso-8859-1?Q?1OrEeuG5tWsie1Sa+GEq+26wnDrVrdP7Q5HZ1ZHdfzAW5WrbS9Gw7Os1tP?=
 =?iso-8859-1?Q?/sahTSAcZLbgCu5yyoUuzVanLPq3SVuifn1w7EBhXZlSQAosMWxDT3kuuR?=
 =?iso-8859-1?Q?ExynBpkmGitXMlrFHFt+lWsu9W7YcStwEo+rACqkV2IivXuRJhuf+IbsHG?=
 =?iso-8859-1?Q?VPGrjj+HEUirwDi4isDrCNibBCr7SxJ+8R/QK9W0dfOHsWb1Q+cKDpvlhJ?=
 =?iso-8859-1?Q?W+epL3NbZkq2KKLiCgh/V7duhVq6+R8gclj8q+hm3/RDXcePV/9U5QM5eJ?=
 =?iso-8859-1?Q?/KjXr+00ngmL3TJBn/B06UaGqlchbYEHiZVFcZcIoNgpD/Ej5HOstBiKsN?=
 =?iso-8859-1?Q?SGLXeqXYYMnFD30V//6/JMOiEYnP1MqCA5/GLeFEQczq8nM0C+e4mgzxCD?=
 =?iso-8859-1?Q?50YcKgrdSdiF6jNNW8+wwUxgSpdtntFGsBxFyjXMZ2h+KzDZD+oPoUyw2E?=
 =?iso-8859-1?Q?YeVP5T9jRjnmCDLZFweyVJZsHp381oCOEhzy8qtf0e0iNxK7v8+qbTdLZN?=
 =?iso-8859-1?Q?1jdYzZlv1Gh0Q71ELmqURSr4GGAsSx/R557rH/AUdlNcE8HkkIjMoy+UKz?=
 =?iso-8859-1?Q?zQ0e6CRixznUI6w4ZzZlW95t4BiPa+L33RFcxq4ePewgGo7e+U57ppGyS2?=
 =?iso-8859-1?Q?g7iJFZCUT2EDgAJApvNeNuT2/IrqlOKFlRLBX2LOUnFtqz+ZXFRAjRGUIE?=
 =?iso-8859-1?Q?Zn4NYpjbaptuopOTQAx8hNM8g4zLrRVGNM5IWAdnOOKR1UogB3jo07jUpo?=
 =?iso-8859-1?Q?oe/cyzRCVNCF/zAwth4QYvNMJUQUliv/u2gwBxhjMq2Pads3QJOGrVlYsO?=
 =?iso-8859-1?Q?k9EWRW11qpcPHtwZOgasmfUbeYf1177rpzsfHE7k+4/lVa18xD+h7Qq8MW?=
 =?iso-8859-1?Q?AwasNJNhUSNuCUFr403y+yKAqWym+S1Cdf+DazntHhvh90bv/LIAI3nrdl?=
 =?iso-8859-1?Q?oNk9iWuvpfgM99WBR0Ukl5+3iYqtM1aiA968fKSFhXBiBqneSZl1gLHDil?=
 =?iso-8859-1?Q?ywOhWdHw1jk3TeHMzu+FsyOSJfbflq1zGTzQEu3mteBeyxdpWqwmUEwr77?=
 =?iso-8859-1?Q?1rh9BIpkzWI+eyRTxhCRl8EcX8EwuQYdoXfMR2hQJhIwB8VdbJnFd1YGEV?=
 =?iso-8859-1?Q?Zyv4lbjhG1y/f8wSWIv98o8fmE/BN+h3mMs1dsApGoU59mOx8mPZeV9Lyl?=
 =?iso-8859-1?Q?bOjoja1E53e7JqxRRKIrOvtNqtg3A2jX3vV/56pBhCsQ8IrPjOAyozXNdH?=
 =?iso-8859-1?Q?qkZVoc2d9ONFa+mmOdvpT9CPbjkXJzuxp7KLynrhjW7FvyuZFRm0zLkWNi?=
 =?iso-8859-1?Q?GBl4OHLvuru5mLR1T3HnTCjYR+Ho59CtRYE/sVWqO4TohLlIITERSGGZke?=
 =?iso-8859-1?Q?bBENkfmgA6Mt23U8FWfG9fk/CxpiUtuGt2Bf/WpYE15me4AtztmuSFGXiX?=
 =?iso-8859-1?Q?kWF61+nJsg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992fbcc3-3a8e-4bc5-1fd9-08de78efa895
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:45.3575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTGT5qLyo+lbxrAZq1mMPeY9RT7b3kSvUv1kB0ea3VqTDuDq4RhxabtaJgDrnsJJ+vg/sJ+qRJQTjZr9dD3g6HGy+KGqNsBehHCmNQChyO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8022
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 .../aarch64/test_aspeed_ast2700a2.py          | 30 +++++++++----------=0A=
 1 file changed, 15 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index e527518a55..cc62a915b5 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -78,13 +78,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pc=
ie=3DTrue):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A2 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
-            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
+    ASSET_SDK_V1101_AST2700A2 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
+            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7=
487')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A2_DCSCM =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-dcscm-obmc.tar.gz',=0A=
-            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb0=
2d0')=0A=
+    ASSET_SDK_V1101_AST2700A2_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-dcscm-image.tar.gz',=0A=
+            'b92ece9ca733dfd7a20193a12582f743b77f1898116b6d6f1abe57ac8db01=
c56')=0A=
 =0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
@@ -150,38 +150,38 @@ def start_ast2700_test_vbootrom(self, name, bus_id):=
=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_sdk_v11_00(self):=0A=
+    def test_aarch64_ast2700a2_evb_sdk_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-default', 1)=0A=
+        self.start_ast2700_test('ast2700-default-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_00(self):=0A=
+    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-default', 1)=0A=
+        self.start_ast2700_test_vbootrom('ast2700-default-image', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_ioexp_v11_00(self):=0A=
+    def test_aarch64_ast2700a2_evb_ioexp_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2_DCSCM)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2_DCSCM)=0A=
         self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')=0A=
         self.vm.add_args('-device',=0A=
                          'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
-        self.start_ast2700_test('ast2700-dcscm', 8)=0A=
+        self.start_ast2700_test('ast2700-dcscm-image', 8)=0A=
         self.verify_openbmc_boot_and_login('ast2700-dcscm', False)=0A=
         self.do_ast2700_i2c_test(8)=0A=
         self.do_ast2700_i2c_test(16)=0A=
-- =0A=
2.43.0=0A=

