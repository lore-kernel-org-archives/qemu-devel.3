Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12608C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAO2-0004xC-Nb; Tue, 04 Aug 2026 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANk-0004qZ-5e; Tue, 04 Aug 2026 04:20:16 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANi-0007Xk-0b; Tue, 04 Aug 2026 04:20:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZbEPuxlFn+pgifyS+g5za2773xGuaHfxfciSKRpMhsiy2ic2oZh1b2PBVDo8f7q3bknzJJPC/DGx3wSUwPtPyv4hJaWZW8pg74HHToDeAwq/P92suFSVcv31JEG7DdZEAi3ieyDALBpuXAc0MI68axVpnwt0pU7ZlV3/PP5nmqvJ9bA7tTtYqU0z7u6GAVcFn6X9xakwwSv9uA9UpGof2R0k+xluJtS72UA7bXo5dmK+TxgeDYKNg4N9sqjD3PVx8JkFr/RlIy1CpGyXyR/bV2TxlIAiq4wVGEIdcdOtJZaQHF/P8blLsPNvdSemGfGomDizfO1TyVTGoXbN949Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sB7V946oGEKuZUeJ8nKvPELeNyqqd/f0VWIIYB+d94=;
 b=Fgzw+ihbNDXwiSsZLzc4gsG6GAyggjMVaftRHFpi/FlFh9X2ERb8guJExKPbqMSPiL05UuYIe/1/oyVAL0ChOIZE9alE4jax36yCsRcvmbS+Es5Hnasn9ONrGmz0HtzFPIAEftOQG0BpT3BxRxeGy4jMtHvfUdWwyypjRhStVihn+SqTlljUTNOYd/jCqsrZpGTFJv9tUeBmy+yND0hWoOkZ9ZH3cy05AdUoCRJ1MoVtVi0SlBca1vCyBOsbz7gCgs9oWn3o38PV/AN5SS3hpga8PboeDysWnVlS7kf6x37dHJHnYHUjfg7unpozqXI8jQvvBlY3nKJevSwyWn/6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sB7V946oGEKuZUeJ8nKvPELeNyqqd/f0VWIIYB+d94=;
 b=VrgtT+lHF/Nb6zvJB2T5/cqNoDTNbjNWmz4ucF0Ot8Bwcur3zeHX3NVy3Inv3l+oda8swOW15yftGzgx4YxtPTk34FaXAl476Zdr8yr2k/DgI/roaSa2NOb5j24lWknkNloa7FhaGdQA6Mn8F9bY78roz3hvcYf8uxrCbZkesTV6RxpAvWAq+E6NG7r7xGJD1oONJiXaoxaZPBxnIKKPnzM/B0m5Wl+QSbgweegQD0LKyHzm4Jia6GepKUujZmL/OKNCSgpWULuA00PnnX4ywAmfK/fz+QVRl2bEMHmOwXiUWwbC5WL/sDlLgRZkM5DmZySRiXOyOjArMxwHw+ouMQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:19:59 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:19:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/8] tests/functional/aarch64/test_aspeed_ast2700a2: Update
 ASPEED SDK v11.03
Thread-Topic: [PATCH v1 2/8] tests/functional/aarch64/test_aspeed_ast2700a2:
 Update ASPEED SDK v11.03
Thread-Index: AQHdI+oKXLImpUynR0OU4QiVlYZWVw==
Date: Tue, 4 Aug 2026 08:19:59 +0000
Message-ID: <20260804081955.1563537-3-jamin_lin@aspeedtech.com>
References: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6961:EE_
x-ms-office365-filtering-correlation-id: b1bd11ce-d7e1-4be7-ac00-08def2012ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 6Z8iDcGTU15Edr80K/1rryegeplHl08uNZjeGMee+hLE1kdqPpxootJu6QxDoHxJ6UpQ3Aj5Q8dgIuTsTeTQujYL04vQkg32LjYRLrTfCG8uuUAGuj+pq0nAXPXPWyoUo9izp0hkCGIWoZppdShcaZr7rM8R0ffNB36eBFaJkqbXtsLF1iDDTl5REHy1B7RarFY9FV95T3uPoLMXwPG8Xsj/LVKPt3UXPFaueRvtFQ+yLcuytpFoIbqT8O6DGa1CyJIBP++kvu0akHr3UaYFbZOAMEsN1AObbJbI2tRiAVByXQPvU8RxwIZnYIlWefl4pkZE6iM4MblPr5yDZPF8IBdxFIYzABziAQDjPae7Eo7iqfz+7si5zna8+9juf336ZMYTM4XYkEHUUecfM1NjXqnxo6Ch8Gz/4cCaj2mAFRyelNW47xKrtpDz75JSFzZYMPp7/YS2ANYA2EjZW/Lkqj+PHuankgnsc6ZHpXxc1Vlnu/LALXbutxolj+nHm8qfM3Tcyl2axylhLqRo+6BTKTuy/IOiJ0iFexqgynlGg8e/+entfzNzqEkDaBK1H66zOgWbv+oFwB8bjUJ+v0I1+VoJs5bbDLXCP4TpGvcgMMnAI6O82HoQ51D/Z0ITEUKAwII0ogewc6ZPD6p6h2oC5M6wibPXgxiXwcyKkgCe7wA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gd0Si6r8s5i77fgnqvarn6rTwEFFKQXouZuQ7FYKS3UTAUjIlw5Ib76+kU?=
 =?iso-8859-1?Q?ZACTW5xP28h4lx4vKLoUwA1BPoxQw7h4u34zZbO9XTy+nBWMjK6fUESztg?=
 =?iso-8859-1?Q?jPkK2ngjIDTl7taEVhrWxfHwgrSqpjKvzmz1qbLMn3F99gVEN0lqoaTvrc?=
 =?iso-8859-1?Q?k69bM/yzzv6sNTuX49jbLG0SDoag5nN28SzLBrXsGsRyB1+ir/pwJFE+JF?=
 =?iso-8859-1?Q?FYCihTRN8EpM0UOmPIUpJENtCJyFJUBKgaSre0lNyST8rPJkbmZ7D9Sfp5?=
 =?iso-8859-1?Q?sQIYRwjnhbAGnH/S3hhTfbDbRRGWhsf2NLe03TWiyfaqROdQNIwpfs9aIY?=
 =?iso-8859-1?Q?KCY9ngueVZL0vZBmmVwy0kQSO625F3qPpZFu1ra3kqJheIsrr9fh79kWsn?=
 =?iso-8859-1?Q?IOggXC6XiUo3G/32h0V1RwCINyO2MwEEncU+pm+BeCQPtZCymAQj6LTByH?=
 =?iso-8859-1?Q?RBQ/xO9AbOC1WJVD6T1cUP2QOLXtCiF6WC1CxnjsnkwpmRB3KJnj5zbpU9?=
 =?iso-8859-1?Q?O8KIeCwBfwl1BlKJ5W67APNeFrDtV/cRkjQXdcyOu7dXBJUjROw7Mmqsbf?=
 =?iso-8859-1?Q?uNdLvI462halt/WKh62xH/lJxdGVrNfY6JS35//Zh44tOMylXcSJzBJbsi?=
 =?iso-8859-1?Q?F17R57kSuPSHgqbO1VRh5UcjEQugYdGjVHxVC7ZsMYmlftTGb7uHGUvbYy?=
 =?iso-8859-1?Q?LCB60d9LWxJn1Q8mqC4koz+veMjDJOyyhyqzflZPcY+C3yt7A2i1R1Nnrv?=
 =?iso-8859-1?Q?BMJ2RmSZeKAeqyrKANPfmdb4l0IBVGzd/4SinOquc9Ntl90s4A6QhMwb4F?=
 =?iso-8859-1?Q?59/07SfhqZJ2qS2eFjf0assGhj06j1vg3Krjo5dLYR8YG9gY/HYh7TJcP8?=
 =?iso-8859-1?Q?iLAFJAGfOP4sNfM9ThbHMNX+JZ+sGcCv0r75XjXD8wcVB/2tbAsFwhsIkU?=
 =?iso-8859-1?Q?SuhAmzLjr5tzcZX56a1n0MeyVoRsyaEDNigAPqPrbZvhseIh1PRpLGZ49P?=
 =?iso-8859-1?Q?SwAocA68qjhw4VvJQkr1pJw1CRVBdKbLyN0KsmYidutEXd3niZe/conx5f?=
 =?iso-8859-1?Q?aG7VDda3q0EGBelrY/RXYE23J5Eej9wrf3q9iGeGLseu2UZwgiH1BidEpL?=
 =?iso-8859-1?Q?OPxcx8weYvJCGGQSucsEBkZAjlY5O8TaoCMJxUfIaKm6aCltAtLL5C5N2z?=
 =?iso-8859-1?Q?e/nLbzBbIquObRRnkbGtqp/7yrcmEHwGu5JZMCWhvhYJEW8DGk6RypuBws?=
 =?iso-8859-1?Q?kSH1Ka31yJTslEXuCpTuRTBJNHO+5jgC1c391vf7ZD2KLoKnH3hSKvraWn?=
 =?iso-8859-1?Q?y0gCSjPg4qR+16c8Sw3UFC/CKFHkBxzCB0rOJ+cpAQc34lojykZChDfSYG?=
 =?iso-8859-1?Q?R3Bj0vnH6AjZ10IXrLxNvGJlWABPFyaKanjgrtNbwA14yy+aNzPZnfeeIp?=
 =?iso-8859-1?Q?CDZ42Kggyc19kZIpsJ1n3RcN8xZdmdTOu3CLQFOjst9wVLu8+5i6rsf5ej?=
 =?iso-8859-1?Q?sw0bBcLFkCJNe/BfKc2+ykFRcA5ZcDF0H/FDFTKPrxAdRWUwdL5vD5mAjN?=
 =?iso-8859-1?Q?gV4kVbbogwzjATuoD3UjE6NWTW1bOWo9M5CTTKdZ4N+pUAl4Pj6XQrCLcn?=
 =?iso-8859-1?Q?7McIVb6nA55Jap8TMZxQsVsQKfdhW+D8VdUBSszX6xsFf26h/P1z1Zhghk?=
 =?iso-8859-1?Q?2QGc6iMnPIPGohE8UyHZNYkzZ8kSl1KubP5wNeaXmGJTJz+CQ8mi3t33vM?=
 =?iso-8859-1?Q?uiN3g7ao51gasldSHtN7xDSJboAPkU/bCRP1wqiJ/NJkX8M6sWMxYk9rOD?=
 =?iso-8859-1?Q?kgATkYsf2g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kT+rqH8TstenriD9X3k5n8nAGZwBgQQJnu9MiPW/3Dd54gjUf855WtF0Wg5a2aHtizu8AKxGTtHMSpaCsxNd0yl1Xg8S4DKzrgbsqn75TemZcZoKFRqjXMT2+AGkDBbxjr9HqCtE+z+sVYSC/wKLw/xI6vphoJYXRFKdLaKKrShvy+kS+jREzyC/XBEEL6tpWdsSGoFdvHAXZ/3MLfuPiquEHO8TTJatTNcVo24c2bt8YKrv/GWfYgVP3JuhjesqX98upnzH5snYrcFQ0dy30egC8K7S0K1N4P9GMCXLwHnPFaP8pT116xGEj5JFFmkf7fd8IJlqek2e++a+jqoIOg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bd11ce-d7e1-4be7-ac00-08def2012ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:19:59.1283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wz9s2Jw3OlaelcoKhsqGlMoTPUH9aKgFkr08m65TwdKJ2j9rU1sWH3v7BfAo4plwB9hYYxYs3xMOxeNtnmCR/wvjzJ10s1Samna6bk2t3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6961
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
 .../aarch64/test_aspeed_ast2700a2.py          | 27 ++++++++++---------=0A=
 1 file changed, 14 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index 0fe04a6eca..52450a9d39 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -85,13 +85,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pc=
ie=3DTrue):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V1101_AST2700A2 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
-            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7=
487')=0A=
+    ASSET_SDK_V1103_AST2700A2 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.03/ast2700-default-image.tar.gz',=0A=
+            'b91450d53da234591060cfb926fa30f7534ce20eaab766cb0f80ec332f8f0=
adb')=0A=
 =0A=
-    ASSET_SDK_V1101_AST2700A2_DCSCM =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-dcscm-image.tar.gz',=0A=
-            'b92ece9ca733dfd7a20193a12582f743b77f1898116b6d6f1abe57ac8db01=
c56')=0A=
+    ASSET_SDK_V1103_AST2700A2_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.03/ast2700-dcscm-image.tar.gz',=0A=
+            '7afd8323fc95097c14872b90d68c5cae5d078530c704591b192b74bd892c1=
dbf')=0A=
 =0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
@@ -130,7 +130,8 @@ def start_ast2700_test(self, name, bus_id):=0A=
             },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
-                'file': self.scratch_file(name, 'bl31.bin')=0A=
+                'file': self.scratch_file(name, 'trusted-firmware-a',=0A=
+                                          'bl31.bin')=0A=
             },=0A=
             {=0A=
                 'addr': '0x430080000',=0A=
@@ -157,11 +158,11 @@ def start_ast2700_test_vbootrom(self, name, bus_id):=
=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_sdk_v11_01(self):=0A=
+    def test_aarch64_ast2700a2_evb_sdk_v11_03(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.start_ast2700_test('ast2700-default-image', 1)=0A=
@@ -169,22 +170,22 @@ def test_aarch64_ast2700a2_evb_sdk_v11_01(self):=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):=0A=
+    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_03(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.start_ast2700_test_vbootrom('ast2700-default-image', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_ioexp_v11_01(self):=0A=
+    def test_aarch64_ast2700a2_evb_ioexp_v11_03(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2_DCSCM)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A2_DCSCM)=0A=
         self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')=0A=
         self.vm.add_args('-device',=0A=
                          'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
-- =0A=
2.43.0=0A=

