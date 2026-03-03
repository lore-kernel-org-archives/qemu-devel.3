Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0D9E67A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQH-00052I-Ge; Tue, 03 Mar 2026 01:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ8-0004xR-3g; Tue, 03 Mar 2026 01:39:52 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ6-0005rT-GN; Tue, 03 Mar 2026 01:39:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErUBi26hP6tHE0tAp37mkmzY4J19iEUDaZUDnHx7b+dZq8pHlvdgT1jiC40TRXz1ik+5PXw30LxKJo49TNbv1+/hAxeYa9ZFwmpCHjGKJtAkLuxxEwRicXJLzP2oYpQL5EyEd1nvLdCBBem6Mb70ugIPfxWTTk8MZv+zhesXOT2TbG2L0Qor8Fl02PEpwZjwxw5PsATLKJQOBA3Z6svxbA59ebZoPDGhwik6zzSv9KMcf6jRC7uyIiF/9ugZwChkNsrLmH4VSXAYDCClQMbzGo1sJS7OK3HQ2unW1et1UoU22LrloEGvsj8MwLDsDse8/dlAlgpJZrjSu+u0UUSotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4c4T2+wbXKCnx2GRHOgBrQUrfV13ciuKhbZueMT32U=;
 b=X/Si4QGyanzX+BHUTOP+bvGbudSBl6zzXnKglyLaq+98ElZ/GfLbFqHUE4Ac7frRue2MMgovkXr1RNhUZDV/HIEEapPMMClsYENcmjdl2il4lD9G7LfoiWiRTJG7ORsbOqczANXsfU9D/sS7a0vNAm+IstxXPGhWMeG7EZFa4AeVMtB/Du1IWaL10Ymlhvr1AyC3gNoErvCCTu8cpVKaNxSetZFkeu4ZPZcmnFwkKjard+jmxVg6frqQt8adfL9T7snBm2PEdGNtsAHtM9Of/tFvNzn+QVlg1oenb0RRHQE4p7OT2AKnoAx9gCxcJNdVq/yxUVbj8pTzZz9kZKet4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4c4T2+wbXKCnx2GRHOgBrQUrfV13ciuKhbZueMT32U=;
 b=LavnRjwymhUDzf2mf6EHMK/hzJVKoR3WYOt/cTcMlUx3DaSR58Y+oZ73mFd8UFk5NxZwBoUBSWlawU/zRP39e0oVv2LHZqZlNOHO1ri1AXf7OSTIYZbh/tgdbH+mpkQlMpSS+1yLGq09hcEnuBennAdXFYgcJhSO9ewTUdkXX6DG/0nBNBrnPZPIjWcSoSPcrbQ5T6kNHf6qEOIqOtAkPD1+bK09J2gtOZ3qn5xu/6BaGiTXoGA6Ne0X5cGCxVnfqfVfhJqk9r9VDrAfT4QypGS47h/fp7gNLlGeZvN/FOSDBW+4WTxkCeWRNry0p4WZjg1SxbeRYVZt6W2aYtP/Pw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8022.apcprd06.prod.outlook.com (2603:1096:d10:48::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:39:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 08/10] tests/functional/aarch64/test_aspeed_ast2700a1:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 08/10] tests/functional/aarch64/test_aspeed_ast2700a1:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqtiF19Ulh8ieaEKTV2wXgXhRhw==
Date: Tue, 3 Mar 2026 06:39:43 +0000
Message-ID: <20260303063930.2878300-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 5a7edf4f-263f-4714-fa4c-08de78efa7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: 2EqqRk5ARu+NBGqEm7BHKyIeIft6G0LnKIT548VnNhYhxjzZoVDm+hk26PiIIKPmp7k8XGyqthubKDOioPIWv4H7PWBFDC+Rij6Qg6Quqme8H9axe8sZlwCFybmhoYAgX0I1xEjmTh+fAQx53n9UjRj6Z0/zo30s+rHJZVZ1j81dmH2SAtGkht5cJgnu8zXM1YFZVTLX4e19PyD4LlZzllmq4J/+hVoJmCeOid0iFP+rE1e3lStZt+cHRRXIvjjwWNwIj3O+sXx2bzDtQhgpsBthEIwVmGBO+wPSCwH1LT/P/yVimEW88QVkF/0I/U2ZC/auHqgAagY3xX9Wv8At3rycihTTmjJwqmT30LdY2xm0x9akmCmwP+KMCB3v7BXo3pzo8MFLy9z6Jx1IpQhJqoXBASuWF4eZ0YhFKpCaVdBEGPxw5L5OPQ+npXFWDaAnUTdC6UmNl9qILEpnmW5z/yZE+/BSyoLnU5FCY7BMt2C2pDtvJa8S1Bq92D9je3hv3dPuRKzLIvjqP65EtSB/pxY7hlzNDYxUAWYgXceYSHKZMk4qpxXyuj6+yWefcP90eU1B3+mH6LKTrSi+8t9Prm/fG0oqACodsfVcoYFuZM1V7scMUYXkCiu1sP4BJTRuoEK4oWiTO3Akd8fGWcZ7L2UPDDVgLLXqE/bvTGdgW56UykIlfnOyr5khDmxt9jyGHZO5R6nWlwhdXAnZyqSothju+kTnGWsVdfpGheg2EZHOZhusLnIArtTWPfnuf+7A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4/X9ofwwHKCv8HdINwz/J5VkCQC8Nne2bulPmEOXBnLs2x5j2pNOcvS7M0?=
 =?iso-8859-1?Q?xSRNYhKcKaq5vuyBBQAu+MjyQbvp/OS5GbZB9Uxie0BQdDjU7qLi9g2SyU?=
 =?iso-8859-1?Q?ZimLI/3VhNOii1ByIhummiaX2KFq1NZOwazNWbZwXk14uBYUu1nJysbDnq?=
 =?iso-8859-1?Q?G0bKJGSONd8m0XQVg63i1bZZ4nibTwMH7iQhhkZ+ITzJSHbo8uAbEMPAux?=
 =?iso-8859-1?Q?5/2oW3LWFOwgsYicmNGL473J/Kh0nXJmP4Z3MLu2N/+7a7oTjmnE74iLGJ?=
 =?iso-8859-1?Q?PZKvw50v8b2ULzq4b5kezpXNWeX0oCjCPS9tVKKFCZerc+tVvf+hstttfa?=
 =?iso-8859-1?Q?fgJZmdmXcycNPNr5uvec1EEd9ktk8YkpxpKBxhaeho1Lr2oWaYedxZntkh?=
 =?iso-8859-1?Q?K+klbhXCPhBZQtwXAzrrLWLaOZ5tVkT199fEBO5FsnLDQuu21c+FmCKlkj?=
 =?iso-8859-1?Q?3GxtIm7ZgW9hJxGPjWGZQcQujNoGRaPidXmB7IiSqV2rc9o5npoBUKd9Kr?=
 =?iso-8859-1?Q?1HqpsXosxpblP2IFEzjFQtJG559GlAunCiXSh77Wm4+fVYqyc2KYaEJ4qw?=
 =?iso-8859-1?Q?paAgqFF251nQ11uhKdZu8RpAgBdcfQ3XRBoQ4QxK0BifxvUHtqs39O7syy?=
 =?iso-8859-1?Q?6/4Ga5FiNBFQQ0Rl98T+qPkGVymRkgZU2gSZsR9BoYBukoYu4QQtj9eq2k?=
 =?iso-8859-1?Q?lTuiBYelojQ/tXzU6gA6z9ggX8zOMD57wxCQYRsAFODJ20g/Kj4BvdtnCr?=
 =?iso-8859-1?Q?Odc7KkgzQmR85LSHujBzPWofIE+iym4FndkoH2Llj+NS+jhhmg4YhoBBZf?=
 =?iso-8859-1?Q?x6h77Qyit36tna9ya6biiZoGVpyq/+q+qB+uTLNz2Ic0CKSVLFV7Ut5h+x?=
 =?iso-8859-1?Q?EieBql3syD9k/cyNfAUaPI0Frls9m+WCBo9asD1hickDjLzoMxNlTAdDvD?=
 =?iso-8859-1?Q?YVNGdYdptwR6XoRNt8cg4lZxnaKERyYNZxaARaFFh/AL25rI7bn6loey0O?=
 =?iso-8859-1?Q?f8IR2m7Kb9dywGAGZe3lQdT3bLc8g8Edz/q+jcPY5E7X/hazzxW1Kq9Lcz?=
 =?iso-8859-1?Q?bWawqta+vtdXincVTPr0mEJQKtLqU7NLylAwNRisPUWJgHbCMAb6s7v3PT?=
 =?iso-8859-1?Q?SyPkWQAnbOADwSMNeptWhr/z4azrtGw8zvAekx2ZTCaCrzDiMT7teWWVRx?=
 =?iso-8859-1?Q?fVUoKdIrNcexjKT0DvgsCQ810KgjDQ3Q0xxlHwB0AabE8PzDv0XDA3hEni?=
 =?iso-8859-1?Q?5VSaRA2uJ3kEP3A/XDZGO43KOsxr7xjc7A1TTOygZBfUfGgN9VUozBa6nY?=
 =?iso-8859-1?Q?oUtE4x/8bgkHVAlQS3gONTDUFjpGuiU+6l1tQtLqFszxi1s2et3dqZ5mJe?=
 =?iso-8859-1?Q?tz+lf8gUH7UUF6GDghRDfy9/hOPjZvptTe6rk8oHMDj68FIq3/QBq43tkS?=
 =?iso-8859-1?Q?WbtEha6EtjvA+AHBS1vRHTEn2nN+SrPG+S58gnj9MxFxOKwfml2ZfWyNBD?=
 =?iso-8859-1?Q?xjEu1q8lQXDSLxVOsmcxwYs2jXlYBFq+1XaQainwyvkK676JHFi+nEOCK9?=
 =?iso-8859-1?Q?EQg1ah8ZClywwo3nfgLRCmBQAnq5tmzE0qgHM2+6Nhit7Ir4sOB1cDC3Lt?=
 =?iso-8859-1?Q?lWBLjiUtkX7McoOKHiI/4N+ciqJi6NFO+NCOZYFWTxC0wwaCwRyHxxMstX?=
 =?iso-8859-1?Q?7sLhfvMQMKFo/+G0F5RSl4Uw6w0pMiVMGMDVLRJ61YlgdZlxpeiAJMMMJ2?=
 =?iso-8859-1?Q?62I4mGzgkIjS/WYsNhrEbeZYx22cXdGw1WPTzWCOwXlNcYvOy64Zsny6oR?=
 =?iso-8859-1?Q?Rlol2GvaMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7edf4f-263f-4714-fa4c-08de78efa7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:43.8219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F576J9v9IOUlWc6Fq/a+ZCSEvefVgVjH2NF1lW8SKV6+NlV5tuCG1yCawBkZZLz49xJ8LtLhXXNzMZjQkqzrMgJyuqpeeOZnJsARq3aujKw=
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
 .../aarch64/test_aspeed_ast2700a1.py          | 30 +++++++++----------=0A=
 1 file changed, 15 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index 61373ffe5b..5c0c4b0ed5 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -78,13 +78,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pc=
ie=3DTrue):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A1 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
+    ASSET_SDK_V1101_AST2700A1 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-a1-image.tar.gz',=0A=
+            '859808828531a51931aad3b4e70b28143eebb3cde1838ba7d8e7a2b844c8a=
1ab')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A1_DCSCM =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-dcscm-obmc.tar.gz',=0A=
-            '4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd55=
87f')=0A=
+    ASSET_SDK_V1101_AST2700A1_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-a1-dcscm-image.tar.gz',=0A=
+            '4654eabad75da3fd33635cd6d29b7635181daefee7294b68feb124b9d4c24=
116')=0A=
 =0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
@@ -147,38 +147,38 @@ def start_ast2700_test_vbootrom(self, name, bus_id):=
=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-a1', 1)=0A=
+        self.start_ast2700_test('ast2700-a1-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-a1', 1)=0A=
+        self.start_ast2700_test_vbootrom('ast2700-a1-image', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):=0A=
+    def test_aarch64_ast2700a1_evb_ioexp_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1_DCSCM)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1_DCSCM)=0A=
         self.vm.set_machine('ast2700a1-evb,fmc-model=3Dw25q512jv')=0A=
         self.vm.add_args('-device',=0A=
                          'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
-        self.start_ast2700_test('ast2700-a1-dcscm', 8)=0A=
+        self.start_ast2700_test('ast2700-a1-dcscm-image', 8)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1-dcscm', False)=0A=
         self.do_ast2700_i2c_test(8)=0A=
         self.do_ast2700_i2c_test(16)=0A=
-- =0A=
2.43.0=0A=

