Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E35C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAOC-00055t-7N; Tue, 04 Aug 2026 04:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANo-0004rW-1O; Tue, 04 Aug 2026 04:20:21 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANl-0007MM-7Z; Tue, 04 Aug 2026 04:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofp9tBBtge0tUlaGCTF0ree/zxRqYWy2IVzhj1IbPLPGxA4stTnflMeqT3Ry28veI7Z0A2a5/A7MdwXBoZuYM2UsyFwOK8RVewOHp1tYxCCUQ3rDlwrxkBIxJ23jdQRQKKZBMMbQko8lTpjeqyrCz15PD8KivWAgZ98/WQe9d116P05u762Q0gYX+Jdaac+iziBUf0ZcQNhczyDLMMPM2DRKCEtK6gTI3RC7XySRT8U2tGsw/bBEnOGqeNJfTK0JqAAc/fJXlIF2wwX3LPcIqFPi5OXo19bOYa+j+In0b/6bAP+1i5Xo0mJKZNmQ5GE2F2yWE74BrqeV+iD5eBUCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klb1baB2I00YA+K1P20DPz6EP+myzFh0FIYlKIwZshc=;
 b=KzzzEyiP5XgFk9d9HneF03uwTX5i6H36BmVPAHpfKwlJuCK8k/gQRQQwAyKUJ+oU6B4SFp2QHay/cBURq59Bmgc2W+8h/hZSH7pwMmiMEMEvQ4+sXbla64XacdWL0b09bClg87GnGfuVPhcuSZE6BiECi+Yc5zHRH2bX1/R0xDJTOo7JAzDeCfQrUgng+mVxpIOToEGV74bgE8dEXTTTIf10vr+Uk2IotAbd+BjUfNofGyMgoYY0wKtaspnPV7yC10SCokLSP/llG0IyQBxCgTo3fk8y+oAe8b47To8CUYgjEtRiHHhpQ9vp6XeNrygbLb0/s1ukmCx8Dbc2dxZPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klb1baB2I00YA+K1P20DPz6EP+myzFh0FIYlKIwZshc=;
 b=ZtIJuV1bzho3cNWF1g2MT9mTLyccGPXXFxx0PdC71vdH3nIIUzIyyM6KIwSExmVovOHXcS4Gk2l6AKsND+oRWg821CIFMl+uZ+uOAt4Y6pvciCw0IxeHVOF22TMw5l9QeJ0L5BEoKn1xXI7970e7ZYV6oaCx80aFDjDBAnLXDn7f11S+G+XXe38Pe82t5ytuJ2ZNZANXxifKAHO1BfJRf+39nkXBjH0woJZNX6nGPeRe3Iwiq1EtcP3mftvRBCzUpeahaOF+4qqPmFDLnJ+/F53pYmh3O+1bT9T/QHCvxFlBqyF5oPuSa7RxXBXohXz14qKDj4E0KyECOgy16gDaxQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:20:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:20:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 5/8] tests/functional/arm/test_aspeed_ast2600_sdk: Update
 ASPEED SDK v11.03
Thread-Topic: [PATCH v1 5/8] tests/functional/arm/test_aspeed_ast2600_sdk:
 Update ASPEED SDK v11.03
Thread-Index: AQHdI+oMKkguVqmqNUuXow3wLKjmIg==
Date: Tue, 4 Aug 2026 08:20:02 +0000
Message-ID: <20260804081955.1563537-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 3bda9a48-7751-4c76-6730-08def2012edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|18002099003|22082099003|13003099007|38070700021;
x-microsoft-antispam-message-info: tgJR6p5/+Fq2vyzRM4cY8gSUgNQ2lP/ahdYQ6RCJZy/SPRZph55Cj5mKUeBIkIq2k74lx1g+ftrOAktcuPB9p8KX4c05yIGmN5NdBi2nDTb4gyWdQ3g/C8RKO4NNCfczcpFStyT638UYt4DdzjzqDKdOPmSJ8lhg93YXjM2OPjDqijJ5Z3u0NcUKuPGT8QWvipJdzfLVr6BBX++qOOIgsFvSYwhTzUQsVl6Xgjo24RCkOArqN7ys9picyR2NWA1yImjpQrnodhdKYVHXQCGFt5ZBz8/dEZrLvU61n/n4BX05DWhhxxMyJ7VX+7JPGkB5HPf2liVhy/VHzhDh8g8DMZSDMgj6CRIuvyU5+bysCC3UQBRBTWrny06XaVb7uunEvUqR4y2QinzfuxmZ3DzJXwilBgtbsDzEzQDpaDbOquC2lOEPG98S2TGKUII3McnTKfYBDAD66nOiQpxABxmSjqF1k0K1B29ejdnGqmD76CmhwsXU6vCTL+7N4yxABGOZjRHsBpJB8nj71iphsDoZnrhH6/54J+XO3XCLaVlanNbNThEyAIfwZXR1DSGiVUQZ7HgnHdwc2uHOhU3mc6bCJ5bEMEmzcjZb/lqOWGVRuk5Kt8rT8ZV7SwKa4fHEsR+THU4YAIAFZ4UFU5dOKsfO9MuHMUD7cJOzAKUP1fiqnVg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oajAFj2r7/xI+qCzIRLH65bvMKvyKEUsvDa65x3FmCqGASgi+MfZOmlN9B?=
 =?iso-8859-1?Q?NkNfDbbR53QRbOGDxQ9ao3k9AgtEjDdrmgbWpg47bRLutj6R50pBjB2UjB?=
 =?iso-8859-1?Q?HEthEZPNRZ8ZZ6baIrIpCRWVtAEN4BOOkRZCnxdKLZb8mMPO1Vlfoop0fn?=
 =?iso-8859-1?Q?5nbCqko/SE8cMd3XETWcQSEJ/K+POC6JecebJ0/sJ1LeAcf+ZTXZWeUCyB?=
 =?iso-8859-1?Q?8gBWGgEJfFcwriCUKtk2LMM6jSzuHWIKJajn9mwQI4DYH7m6UARL9ZwxTe?=
 =?iso-8859-1?Q?nPkKb4VBIqYEdS0O164y0ylXSxSuCQF0dhrg8Bzcw8f/N+Cfpa1vjcWQb/?=
 =?iso-8859-1?Q?cYfmSpAY040tNJVPm6+17H9IItAv0T5zzYFjbbrbyEaV+kZVf6bBgxp/+Y?=
 =?iso-8859-1?Q?hWnIoedSna5RqY7jmW/4fxwOJvsCW02WertSh9nOLk4EhYa7qzxLThuLoh?=
 =?iso-8859-1?Q?c0twPDMsP2TQsMfx7GCiUkAGB2QcXmOKplk+SM5sWAEks+yRjMSrLQeIzV?=
 =?iso-8859-1?Q?KmUSR3ngKU8Rs4XesuDEtuLV0MtVR3UpfCHo92vEYc8lUmQhyFlJ5JcyQ3?=
 =?iso-8859-1?Q?/enwXRcevHqCrz+moBy9e0iQOdLLXhBN5Sl3yZxuuBCrwMvGzco5ODbdXe?=
 =?iso-8859-1?Q?P3Gp/NiRvl2M4hU8+HU7odlQZVf0J3N7n9x1vg4o/7aa6JycHWgQJit49f?=
 =?iso-8859-1?Q?DIZpxdqmsxuNdBA0/ZJ7rd1A8uZJ+FkZsBYPgKY0rNlduzt4RgNAVZvUt6?=
 =?iso-8859-1?Q?fg3oeTCqJHA6huBWCsjsE0Ht2lHgGQB1XymGIsfJSHhkhmWJ/k4UrwQwAf?=
 =?iso-8859-1?Q?Ug/LuCL1JQvK87774cjs7NnCpqTX5JxBM3GG/vkhgsa1BdkiFd13vnluo9?=
 =?iso-8859-1?Q?6jrqAD5edR4o/BsdGVVB+Uqhc7d+U84392eF/hj7bw0FEZHCNN+BgcRHW8?=
 =?iso-8859-1?Q?JmZK/rm7NBl824CBBCwPlrFjSqTB7hlI9ydfi/6oWVPP6oxfgZEenYQoAt?=
 =?iso-8859-1?Q?AyphRZtyLAq57bXNk14d46EA9E9u/ny5b2sdT3/3zuL4KGw7JIGi5dtsQ+?=
 =?iso-8859-1?Q?kgADS5H8aW7UOoKerzb+T4u5BJy13iVv/JfctEfmBEzPpUQM1xZqMkNlCn?=
 =?iso-8859-1?Q?DMpiepeiClqNtTUJnB3SxzDs+IQT3hH+CyQnZIltDShsCToj9My9J8ygOD?=
 =?iso-8859-1?Q?3Fx3DjNl+mO9btPzb9hWX6Q5NOSF2gUfkejGclmyQjb9IfOhLkCyY3ibAy?=
 =?iso-8859-1?Q?SkUatHLRRIvkFqCm7AwHgULqejM1+ONrM/2FD/tv8/cNBTj6FoZTXC2MAa?=
 =?iso-8859-1?Q?qiR8JBIaj7o/9JoeIl2apG04Ao32247XSouPLCbSR9CYWJKhQ5et5TrKcx?=
 =?iso-8859-1?Q?ljursT5QUYWGx2LwEp8BUYCZnb9HVrhiiYZIsbpAEuM9IQ72LCKsxA32V9?=
 =?iso-8859-1?Q?byqrOirWndCfw/HCG6bIg4TL0aStak7hC/B3P9UnFxuTo6z8FlYMkpfynh?=
 =?iso-8859-1?Q?zEElvPLWw7XTYIimnO+FbC6xpOWCLs0y1S7YMeDlbA9g5XSzh3j4SMR90L?=
 =?iso-8859-1?Q?OacQXWGLFumv51H6MHnBC0awvQfTHsM9RQ87cejBQ9YppGPa5scmgvp7vf?=
 =?iso-8859-1?Q?f/C7HBfhkQfiXxZGxfCAi/PeKrB15oIqRBXGrIs7cnu5QTOCAwbAAoPwt0?=
 =?iso-8859-1?Q?VJJPTbW2GgoYPzl2HerxuobeKfieLZ1pqusQfdZUuknY3OEci8K099VLf5?=
 =?iso-8859-1?Q?81DUQC/ix1dYQsIQfHMKjJowaSxB9Fpxxofw2F2O6JFZgIVwap5n408qEd?=
 =?iso-8859-1?Q?g8ERCMz3rQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bgylM775Y8cBmhr5vBrvTvr0ZwboqudHq2vI2tJ/e6MWYa9QSnhCRrmLG/AVMM22Kqj4a8Ls0v6Rqf3ZG8y44d8Uw7JHa0MjAYtrzVl5DnXEWMo3MYU7m5JJ7xqdlx/O8p1tr9gb/tQ4T51+S+7XGlAJ+p+OLPB71Lq6zda9PvfeOZ930DMFkZc04JYXsglQKfQkFws1AWh17iXNYxkUvc9aG9N31EVOdDqsg5VEuXJ3FvG6wNN7mIDTcOF6/24BJwsPLMzh43WZPO4dzmYR6ETcpXq5GlsGnSItTLGS+Bw0vtRU/rygwdfbzxPOTvEmMX2ZM0NjcMSOzsMbDFnfPA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bda9a48-7751-4c76-6730-08def2012edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:20:02.8031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2pA2n7Utv8vPue8SXBT+bK1ZXTs2o8pmrbfEdCXMiPYHNNgyBSAfjQnto56F3CLrCPWVkKq4kl37XLQL3NmUog1W2AMoatHAT2imqZ/Wvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6961
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 tests/functional/arm/test_aspeed_ast2600_sdk.py     | 8 ++++----=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 8 ++++----=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py | 8 ++++----=0A=
 3 files changed, 12 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index cabbe230c4..4fc594dfd5 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -14,9 +14,9 @@=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1101_AST2600 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2600-default-image.tar.gz',=0A=
-        '3c5b4d4ccf27b0d208a073f98426db54cd751b96143180cd15df1a83978f832c'=
)=0A=
+    ASSET_SDK_V1103_AST2600 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
3/ast2600-default-image.tar.gz',=0A=
+        '47e3656a14bf7a4de28d3dfbf48bc2325443bc42d270f3bc82646f92f6dea165'=
)=0A=
 =0A=
     def do_ast2600_pcie_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -49,7 +49,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2600)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2600)=0A=
 =0A=
         self.vm.add_args('-device',=0A=
             'tmp105,bus=3Daspeed.i2c.bus.5,address=3D0x4d,id=3Dtmp-test')=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_515.py=0A=
index a8e7faff48..f5b14de083 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py=0A=
@@ -10,14 +10,14 @@=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1101_AST2600_515 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2600-default-515-image.tar.gz',=0A=
-        'f3ccf1c08db71cf891637fc73131b80b2c0c0e005c06d5dcae0cf74fc458b43c'=
)=0A=
+    ASSET_SDK_V1103_AST2600_515 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
3/ast2600-default-515-image.tar.gz',=0A=
+        'c79d0197106f146476e82bb878e5438f6569bd30f3b53fbb520b59bc54f6b7dc'=
)=0A=
 =0A=
     def test_arm_ast2600_evb_sdk_515(self):=0A=
         self.set_machine('ast2600-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2600_515)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2600_515)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default-515-image", "image-bmc"))=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
index f24dea1e8f..5813c59bd6 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
@@ -12,15 +12,15 @@=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1101_AST2600 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2600-default-image.tar.gz',=0A=
-        '3c5b4d4ccf27b0d208a073f98426db54cd751b96143180cd15df1a83978f832c'=
)=0A=
+    ASSET_SDK_V1103_AST2600 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
3/ast2600-default-image.tar.gz',=0A=
+        '47e3656a14bf7a4de28d3dfbf48bc2325443bc42d270f3bc82646f92f6dea165'=
)=0A=
 =0A=
     def test_arm_ast2600_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast2600-evb")=0A=
         self.require_netdev('user')=0A=
 =0A=
-        image_path =3D self.archive_extract(self.ASSET_SDK_V1101_AST2600)=
=0A=
+        image_path =3D self.archive_extract(self.ASSET_SDK_V1103_AST2600)=
=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
         self.vm.set_console()=0A=
-- =0A=
2.43.0=0A=

