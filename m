Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55E3D172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHq-00061J-01; Mon, 02 Feb 2026 01:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHi-0005y5-Mf; Mon, 02 Feb 2026 01:19:42 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHh-0003NC-2m; Mon, 02 Feb 2026 01:19:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEyWVYoh3qMBnEeLrcH6Gnyq1gUI5w60tcnPp30qpBExA/wWX3273NqM33ltv/vJ/gnDB/bKmiMgKsxJu9KOFIDLIc8VAIHvgUStoknK/eyQQPVmb0+Alecha11SzgtRkVwC+tvPHxSMqZ03j1G2rc5YqKga2rZL6kVmcg0NjgP0w6Ep2B4XoqlSvWhXUg7izu6Dk7CEtQASg0bC7fL0cYKHTW0SqPTFEZ1R/T8C+P8h1CyfAOIDepekjfWksMRFfDxTk3NjSseVoqJOW/a9H8ZeFwTGxL2B72f10vQtmhSz+2oseoMd2lew2P3IBR4dF1GRQH3qRG5iPvGjFLfYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KzjcvNsiwH29ClaM2+/PNv9aaFexgo5VQmAbQDDSnw=;
 b=Frf8rEUa1RbCoXVT6oUAfbJ7IbiCUF3CqhP1cazdTSoKEi/ZPobOI4lhKJgPKOFKAOerUSLgWrgQpMPszEAJZ2qnNY5NNyPQaFLkl1ECMNQeZ2YbFwA2UnKOUaCT2IYTfEAOsg3jqdDOWf+VxrGz3nOZPP8fWkcXgU2zqpmwHDSL+/ZOevjC6KMa/HMfEuoNUqIm9I5mdDE3mUzCEJkgA+DGMsUzAtbInqZvAj3zktdljOshwhhCgn3H9oEV9ngTNtByhOgsQPBEI3dV1+LAEOSSQFlHYEYaOjzzDj34f+jx7R7kLAx4fYPmOS7jpCeLaENvhtHzGi4CipgkqG+zpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KzjcvNsiwH29ClaM2+/PNv9aaFexgo5VQmAbQDDSnw=;
 b=DrO0jenP2FHaK59QeOM7pYn/mRg8WV1pz/Unfc46EGF4ccBq2XHToFc+Q77KkLsSStxLkntvShJIuL/ehbk7JQo99ksuohLO7U4ZgoATF/tcqvf6YVCgrqjxnSwa8xT5XI213xYUYVRZ+xX7nwx24lFvToGeoLeNFJybNcfT05q0yFnQ4MBE2HKzvSLQ1cCpVg9e0+q29G2XDin64+QvfvMqYtzpZj913VML+lkDLedx2gHsXoZe0AAihequJuGV0FZ2bDnQWOUc9oAx9cn9DkCLPTrdQh/dxWXKSvhsw9JRM84zKVlLc5zlFyckoaeEfhhPqMNi/gSZAQS2HXnwqQ==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:29 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 5/8] tests/functional/aarch64/test_aspeed_ast2700: Enable
 PCIe2 DTS status for AST2700 tests
Thread-Topic: [PATCH v1 5/8] tests/functional/aarch64/test_aspeed_ast2700:
 Enable PCIe2 DTS status for AST2700 tests
Thread-Index: AQHclAviBdAXlT7jqUG9DZX5BbTHsg==
Date: Mon, 2 Feb 2026 06:19:27 +0000
Message-ID: <SE3PR06MB8199D368278D8F280053E04CFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: b70a1b22-adee-4328-4217-08de6223058b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Tw1Pj30Me0nktAlJ8v2t/tMteAFOj9ujK6vRA6YkzC73Ho8rot52x+GYd3+H?=
 =?us-ascii?Q?b2QrN00PHfISgf2/Mbn7JVkV2yvUbRksEBb02I3kcOGpmifvgcol5ruNyZNY?=
 =?us-ascii?Q?8LHdwCle7IkDhFzEYIPcH2rCPs9VR1g7IwdWsNOrFj1ivJAYDernRAu88tBb?=
 =?us-ascii?Q?ZV9h0eA8VGumJv1lbxbWbG/04eE5D5YNBs0Xl4EWCnJ/3LJJWM8b4miSbRPP?=
 =?us-ascii?Q?IBWJTy6quutV7BNjFm95j2IyLFntvPsEQmyhbKhiwFOZBMrkswQUL3X139Fg?=
 =?us-ascii?Q?zvYqlBjumZm2u8b6fqGAt2Ku1GL76j8li4jbDXCS3ahBRP9+07ciMmJUHdJO?=
 =?us-ascii?Q?r30EHMq/GAtdtXHWiQ4YRq8++m+7E40YL+jkIOXPIUGJ/mMEuVRRiyFXuqb7?=
 =?us-ascii?Q?R3esxGkxTPtJxc5AVyR0az+/tc3l16XzZbJtNt0+tmL+CN1WkO3jaGN9TH49?=
 =?us-ascii?Q?U4oyfIdvNmoYSkJKHkpKdpFtJxck41Ho6unx04Q57Kuhj/VHFyyF3HoQN/Vm?=
 =?us-ascii?Q?jmGzw3IqC3sb6Ot9HtI5qVGnDtP82z1aiiqtOphfyuesW6alYoClWbK8vT8U?=
 =?us-ascii?Q?jblakWGsZ2POX1ZXAf1rsWyhGZCuSza/T+Yz2blPLgpqkFiAwXZEiAxO55Sn?=
 =?us-ascii?Q?aW5/qNQ3I0+BaSbKMYpNah5nhIe1lRxvs9nMr8WVoFHovSCsu3UxIsoCxcgk?=
 =?us-ascii?Q?UMU+YomYd54kt7+K/hRtJL4EGyuQfCHw9L060KcSHoMdB63+JUeLvGqqRStL?=
 =?us-ascii?Q?yva2EMT0Q/JkxJu6bB8hYdb+FqBzb5H9FzZ8obAxvvB6HOg3DVlaLtUzyj56?=
 =?us-ascii?Q?Gh8zvgKmojqDPSuRZbSKqSVkT+x2ppOj4DI4AnenWafd5iV0oiilN2mQrPh5?=
 =?us-ascii?Q?k7i6EexKOGICF1Qu4pWxMeZM75UoR+lFQBrmsRACK/XiIfHiHYW9Z0pnKvSy?=
 =?us-ascii?Q?WMQLqcTHHFZwW/kSVRWgc56pnR4Yo+upj8h+dPmIMCvqFI0iWEBesitcF8kH?=
 =?us-ascii?Q?gqHJv6fJL9MgAltSPAIt/C+4OWc4T5jCrvfP7WYMJkSTyGCmJDiz94lk0FMh?=
 =?us-ascii?Q?X5h0WTT/c9dQjifoTysoh3BSK2JI+qxLAe1V6bsbtpo8DSqLziMxQ/8kBmgj?=
 =?us-ascii?Q?RY/XjKWmKCDxO/AwgfIXNmgany04LpSwXd2hP94Bp5jFNVvkrQT3H1BnIlKW?=
 =?us-ascii?Q?72GkJnW2f5wIJhNo91VsQyNUC/RdiWfsHepgDeK3k/c82yKxssePTTPaK5CR?=
 =?us-ascii?Q?0/f8ANrqm9C2DVGDFa88WgBLUb2OhtJ4CMartxQlHznTQti9qex3HP5+Q+hs?=
 =?us-ascii?Q?uywBGZB2d48GejSqdSixTx8OnMpN9zto/HTXdVWF+7t/ZyGBkyAljO+AEuGv?=
 =?us-ascii?Q?00YlUKyPp+QQY2u7fZaLo/G7P9wsJVkC0vmZvazSUozObdvRVoQmeVq9i9Wb?=
 =?us-ascii?Q?smxK2xk54pHUMDVMAzr2cCBlnby70dBCfh9M2Wu7e4K67enIN98g2n2Dd65B?=
 =?us-ascii?Q?Q+x42qg4zK0gKRUDmNJSC3fjZpT2coV6tW/TUewJfY5NOSBJNlIZIeXxrFrb?=
 =?us-ascii?Q?AviGXYXXlSbVGxRvPpmWAeqUxMjYlVVcC0bwCaTI3PnLDJILUczPhEanwi2S?=
 =?us-ascii?Q?ffwZIfX6rd8Ip4dYbVAAp61bRl2iXBlJhHVcHcqaiN/6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jk2KoYGgQvwHHeJj76dumjEYMNufpxtA29yEWPxaSkOwRpXZylhq3DJX65SU?=
 =?us-ascii?Q?VoOs+csGF+ntwfV83N7PyeagN/xr16ZRwespBPY2pDMHmP2PplnYP9LHflWt?=
 =?us-ascii?Q?RPIN66MUVvW0jtw+VttgCHw686gI4toRW0I9yMJQ4ZnUKXtqwFd1+BAQEuu4?=
 =?us-ascii?Q?ytau2FDXyog8JfvdjTUuor6KibAzufBcyHWiULbZA9CvcZskCVnjU5WMYVW5?=
 =?us-ascii?Q?6wtcx4VtI9QVFsHGMHRuZfyyccUY0CgdfT0rcqkM2rdyBWH4zwL4b5HYcrRR?=
 =?us-ascii?Q?jh/PEwFpuLdsajVutTpjS6MecatR79rzxl9AImtgvW2WqdWO1M7m7eGWU2v7?=
 =?us-ascii?Q?hrxD1ZDEeaqHSpyLcH878130ZFpb6y6yVkX8Hn4BmGygaokTP3rpkJ2LFDVp?=
 =?us-ascii?Q?LlYjmDIAf3iYSqX3DB3A8qBrf0Loc+FNIRHU5Kc6mvFD1c/j1MDuJnTlEtEv?=
 =?us-ascii?Q?1dzBAewFTNrpwQWaNG48+UJ5E3jS4XrynHpV29DEbWBcvQkOaaB2I4Wp7c63?=
 =?us-ascii?Q?3GlJfWsQNrUeVIQK6cTaatmBs1I1hli9JXb+3KTpe7Gnbm28HDgLIYQxl3HN?=
 =?us-ascii?Q?fuXkcXq1GC5TrRaFImom1aj+Gy+aStFU1oEqdrIy/jrpavVHpm5sdYSvfuIc?=
 =?us-ascii?Q?AEuAzeJlmZgRm3uNwFns4NmwndsSt7SdUH97HE4/xfvWKlAXKRV0KPV2RvI8?=
 =?us-ascii?Q?sx3RO0y9R+bNvnBLk2gU0WmEdzNFfSN9cMRiI6Q4m3fWs0WcqIKXwLA2V70f?=
 =?us-ascii?Q?dpmJMUuaFgVLS3NOUBfBAyxT54pY6zRTUVSpq1x9/b5aYs0+vezMXCl6+mLi?=
 =?us-ascii?Q?puM8j5TLPef5Lh3dwlC0215dKEJvo6K5YzUScd4172muZ5BQFqzRekKaFT6b?=
 =?us-ascii?Q?wQlD2oewYK6p49QmcPKpkzxfEgD/Xtt9O+ASh1TysUrJ0Z9ej39kABdNj1f7?=
 =?us-ascii?Q?FOABuk2DKkuVXgEo797Z35mSJOEMsh/lzIUQyCMLiwbYCnfCQ6fnVIGwr3nA?=
 =?us-ascii?Q?P8XkgtCgsC2r6As050YrR3IREpnDgdBO9uTViqFSqTxR3cFqJfoa1xYuNFms?=
 =?us-ascii?Q?gp92jlsEIbpk2nfmbGVb+53lZWDgaxfVv/z4GZ/hz+coWxPZesA4WcaTqbac?=
 =?us-ascii?Q?nZ/BrOHL/Rg+GVETnZaibs4+LP5aOYsXbsKjE+kj2k/MpOecJdLCh8j5eyEn?=
 =?us-ascii?Q?dS1ydWx6ge9HwEdX1EvItMBdMiqf0J72jHbVOCJY30y6X7zpmwdhxnK7HruH?=
 =?us-ascii?Q?jXtYyICikeSBCMVO3XgEsGCrbbFpv8QiF6AcPzhoecJyWpDKq2BT5wzz6wbJ?=
 =?us-ascii?Q?EXOIxIRR3xngLMc/ERCoHGoYgjkjkPah5Ty9Typ6fyCgf1df1zvyVw3h/HhM?=
 =?us-ascii?Q?bGRfFfY0+budaPluAACoURYlAsvA7yIAOk91eqK4w6/nnx+gL6NBWGZJro9C?=
 =?us-ascii?Q?EcjsNFpWDhRP2sH9tL6DEbJH+TW9++28HsNETFyzLGjU/jYWgY6Ka4oFwCnl?=
 =?us-ascii?Q?z/INw+qlK/dNNy4smDh9AEfiMuRGEQYj2839QfUom+lQ0s4X2myRd4Hr7kxX?=
 =?us-ascii?Q?83WJpmCcI5K0pGaCZnBd7I50TohjRLrTfnkAlgvEcx0fZka4/R1qB/6OehFy?=
 =?us-ascii?Q?8zTEQokmy3e2TBNpzQPEJsCjxRSR5Gl++FvH/2l0hBI90Rgq1s1712E8zOWa?=
 =?us-ascii?Q?4OawAjg2p+c8fFDlOTnGxAZIgjCBzikiFmw4vkzqFks+Eq4iPOgBneYrXomm?=
 =?us-ascii?Q?niD9H3T1Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70a1b22-adee-4328-4217-08de6223058b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:27.3267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbtKfZtkTolFI8uUrEqCyLTlzOqmlN0VmRIktO5ydCzVsKCgs9EoT6p32KgQnht1wqMGglkZiYXVMCBNt1qUrM95RkTzCQc3E0f+sIjt61o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5142
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
PCIe2 is disabled by default starting from SDK v10.00.=0A=
=0A=
Add a helper function to stop U-Boot autoboot and update the device=0A=
tree at runtime, setting the PCIe2 node status to "okay" before=0A=
booting Linux. This allows the AST2700 functional test to verify=0A=
the PCIe2 root complex behavior correctly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700.py  | 18 ++++++++++++++++--=0A=
 .../aarch64/test_aspeed_ast2700fc.py           | 18 ++++++++++++++++--=0A=
 2 files changed, 32 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index 0ced1a2502..1f1b5749f4 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -9,7 +9,7 @@=0A=
 import os=0A=
 =0A=
 from qemu_test import QemuSystemTest, Asset=0A=
-from qemu_test import wait_for_console_pattern=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
 from qemu_test import exec_command_and_wait_for_pattern=0A=
 =0A=
 =0A=
@@ -37,9 +37,23 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'done')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
+    def enable_ast2700_pcie2(self):=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'cp 100420000 403000000 900000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'bootm start 403000000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
+        exec_command(self, 'bootm go')=0A=
+=0A=
     def verify_openbmc_boot_start(self):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')=
=0A=
+        self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Linux version ')=0A=
 =0A=
     def verify_openbmc_boot_and_login(self, name):=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 8dbc8f234f..a1d8046f58 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -9,7 +9,7 @@=0A=
 import os=0A=
 =0A=
 from qemu_test import QemuSystemTest, Asset=0A=
-from qemu_test import wait_for_console_pattern=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
 from qemu_test import exec_command_and_wait_for_pattern=0A=
 =0A=
 =0A=
@@ -27,9 +27,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
+    def enable_ast2700_pcie2(self):=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'cp 100420000 403000000 900000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'bootm start 403000000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
+        exec_command(self, 'bootm go')=0A=
+=0A=
     def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')=
=0A=
+        self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
         wait_for_console_pattern(self, f'{name} login:')=0A=
-- =0A=
2.43.0=0A=
=0A=

