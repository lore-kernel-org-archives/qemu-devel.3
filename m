Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE75C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SU5-0006if-Pk; Fri, 18 Sep 2026 02:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7SU2-0006hd-4Q; Fri, 18 Sep 2026 02:54:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7SU0-0002rT-2a; Fri, 18 Sep 2026 02:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXVt25rAOfaAeHLXYtbE1pmtf7B5tcuHjFGMJngFblVS889fI2g1t6+GaTibyMGDRf9X5cqimVT40FrATb5rBdKxz+0Me+Z/TpFO5nXIIVCK1+bYuzNS9KGZ90MNR3GhAI7zOopuN2pZy3eBEZqvEuqLuYcyxHoUNEmjgM6GHk/6e9zif3FIGF1qjCGYL0FPksxdEZfievGqybSUMn3QekC7zAWaid6LYS6gnFpHB9PwwZASMA0r4+NhVmZkgTMgreuqit7Y7xaOf7ygPvBbKWCLV4aFpU8dhWXe5RRMzTIha1DjAXjL1AfRcc9yZNFA5OEYb+NwqCBtpe7e4NrIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OY+Lxi2/fmImLicnUT3qxAlXQseN+iDcInS7GaTGTU=;
 b=Tp/FpUQ1lPVT1OEVHWiR83GYVjLnGwtOW9Ba/rUeo9z159IpeE5Jdm5hNR1syrWNYwV4dnjFtLjsieaV8YiJb6daM4maKeVueemfSswJRVjKkRHbjLLCNvBRYVHldJvR+9F/lgc6K1rXW5LGcJ8+My/K8w/8cfOC8cUPKG+qXrSBnSG/2oG7gMnA45oIrjTi/PHdrwYwDJd4evqXvzk3VDGfcNuG1Owo/sBro/DdELqllrVVwriDudXkCntBY8H9O7Q0Q1xiRYt+2B1siy9wjMsC55gFOV3OqgrqRKO+wjQQR8I2OpL5/05HSzM1nXYjs5ej2G1gFTFUiOgNlYp67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OY+Lxi2/fmImLicnUT3qxAlXQseN+iDcInS7GaTGTU=;
 b=ltSI35APXPrP9ubDmrlU74j5UqfdC7fpEgaMAMWka5kdDIfywX3JdppX0s6jDPWnVOQn21sUjkNOpPwjSUf12w3nRAsMGN2Bd/KJlpBoLSKc0Wjigcev/dEhhyB4fgCVJim/xhrvQvcFIURyIxQEtbg8fid53L2yRqYGF7QTG1zV2FA06j+TfQC+2YdL/J9U/qQxZWXpzOCwPGBzlg7rMzND6jk8w7D5rxMK5paf1xj9Nhw3JHrJ90yxTEqvj51h5ZCZlyuMDDMB7rv+zZ1OijymAni7yPIsratNpyaEf1Sc//U9QQENvJtgeKwgtVUMZEWU681SI6qz9/Jb/Qfs3w==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by SEZPR06MB8814.apcprd06.prod.outlook.com (2603:1096:101:33d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 06:53:50 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:53:50 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 2/3] hw/misc/aspeed_sbc: Derive ABR state from OTP config
 straps
Thread-Topic: [PATCH v2 2/3] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
Thread-Index: AQHdRzp2ulw00Hg0h0Gv5ZmgRF7wwg==
Date: Fri, 18 Sep 2026 06:53:50 +0000
Message-ID: <20260918065347.3713868-3-kane_chen@aspeedtech.com>
References: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|SEZPR06MB8814:EE_
x-ms-office365-filtering-correlation-id: 2a99ac63-406e-4d43-179d-08df15519899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: ix4fz32HOgLSFz+7rtPRHCzWF/ExEKRYkv194boVIAvUJLqxdmlRAIhKU2oQN/zUvXwLZQ79U7JgYH5mIRdxUT4cg+mZrKfhhiwbvt3nwkv+Ji5v4VhQ9TVUol2r5wXAEzwbr0TpCf8uPuhsxqyN8fk+VFZ9cIyYVuCPuw8+KzCmCNzRbnKk9/cDXZQd5hZBx2t2i2OpdJw92+ZnrgivSnUvLCCtjnA9+vrw/p5fNbNyDMN2Hh63wYkKFSMFArTmg8J2MmWL0Lf95RScna6ae2ljRjlklVxIeoPL8L6nM4m+N/1wXc+PqQ/hqR8Me18pBxhrH04y5dfYt/zkejseoKNZVpoBqLGdrAHaR47fa6n+p8pv99h7SuQCeG6uS5J6eXBmJLonzKxtkhLIWLQf9UFnXzCgi9F3v8aRlPfbnTOoWtufAkohI8w3ePxo3dihK9CEzHxP1xSftVS1PQLIVcjei9bv8PGV3OQoY6fu9uyXggEaBRmAMImOhCkFDEdHLM/Q4WquvSyIkNTp6Jm3D60cX6bdriutj1u9ls5obotanbSqOIo/Dx3Xtdf6/Gucih5N6loZp6Itx+sTvwpKxz7aZbycDK/dKy4r6+7A+IMcoPCexeDGl+jdbH2sroR2zaItwWRwgKhEE+5JibdBu8aRq2bQPAALEQiAFcSQGadi1ZrVUJjR33C+G27JGM1XlV3Quwe+8hbqnau7XwIi2lEQ9ToJaUPuLt4OuARZNro=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5pIfYJivUs9SpG+pMMnFznLu/GbtMG9FdsN49MLJcg4bwf9LooX2y0QRFe?=
 =?iso-8859-1?Q?h3MndGMUWLb8HN1GuJeOaC3RnBA2yY0lgWSAe7LIHsEbo8OnuxW+7+Onoy?=
 =?iso-8859-1?Q?HSI20qz0hj8+hW6/moZEaADu30tM3T//MQAWKeZiUSKd8UTykrIcJMkw9i?=
 =?iso-8859-1?Q?tCPkU2Htnd+wtdhNClKXSIDUtSdXNSwixdXW2GeHp1LgoPNYd5kY6rH9nG?=
 =?iso-8859-1?Q?OTh/HgSHA1scGJlft1pvPsF7V5Ui2mlVXvNcJKMQAYhUDzOd3+AAtOyPKp?=
 =?iso-8859-1?Q?MJGNbDnrlbHovWXHdrjgtLdNm8VAOd+izeXEnMHdOK9f6zXktcmdZcTKsb?=
 =?iso-8859-1?Q?ig4eIv9v0KCotD1BAmEA5QBu4uED1ip/1DBuDM75ckmrxcaGvbRyu5PNCY?=
 =?iso-8859-1?Q?BZix42RGFap8jxhAHiw0mFAg9iK7kN2Y0g+ONI47olXTx+PUo16FAtcyCV?=
 =?iso-8859-1?Q?s3vHmtBtUQPCze2XZ5vERXEnLKKXvUO6RvQEV9ji8W6f/tObHBcr92JNj2?=
 =?iso-8859-1?Q?G5YQO6v5TRmqnXa4yG5GYiXb842EXmGT9s+7jeGU7ZOYnYq7YTWeD8kAQb?=
 =?iso-8859-1?Q?/TO1waR3ZAnE03YXmyvb2ez/q3SRs7XVTnC/xB+c1RjS32Ca8jBDoO+/bl?=
 =?iso-8859-1?Q?xj6PU4gBIbW2j3FgDW7k3JaQfLdrABt7cf5PW1qku/YRyn/CqN5Hnpyrv2?=
 =?iso-8859-1?Q?z6QXh8j+9xJqusWRqj7P/oU/cuDHHL/cNN7Mlr0QGKobjaEx/1XnaBoeWx?=
 =?iso-8859-1?Q?Np1Zi7SOZXRop84LsiMhg474jRGjnYUzsTDG9+IR+yRUsXqa7Tgkv6XRT0?=
 =?iso-8859-1?Q?IEJb9WJFjQrPcVb7OAr3FJwD8rrBs7Kt5iXuWc8rLP6LTwik7piPfIz7i/?=
 =?iso-8859-1?Q?vOP4ru97+OUkji0MNZSPcjC3oit01zGeRALkmo/bMsoek7aMaAC2qevh9G?=
 =?iso-8859-1?Q?Uue4zaIq2mclC1qzoEPwPisjatlwlSiVfn0/QG/EW3kqgIsxkUlxldWuXh?=
 =?iso-8859-1?Q?CwAd1g+l+l1LKcYUDZ1osOOCveiPAxucN1DgE5b7doI8S9EGAzpRD1isR7?=
 =?iso-8859-1?Q?Oa8j61Y3M+iVSYrQGtPLa6RoFny8iFkYWz4ByCaTXQc3n8J+JfxwPFi6oj?=
 =?iso-8859-1?Q?QIEPvoZGn0SUwlCj5hO1nW3DT53c34dEoBrdwhkNSLySQJFbCKtAJ6zPO1?=
 =?iso-8859-1?Q?pEmZKQFnbtTBP2sFLzQ+KTO2YgsmFUSk+2f/TS9wBz5U8eN7JDgxVheEoT?=
 =?iso-8859-1?Q?Dtv6/ciWPzoX7sc9KbL94gnqBKOVEfW7CEPM3gueWHaGQPWEQXBLm2Iziu?=
 =?iso-8859-1?Q?0nDnpnu+AjnRhfDQrRcnUoVXiaKHKdVjB5GXGwSwnMouFdZ3fscOKCVZnz?=
 =?iso-8859-1?Q?gYqwEhRdlCpnMVzjqMuyTxXOzv/6c/pg1ZJ0U+4fqnYbYHnVuKFFXCg0nO?=
 =?iso-8859-1?Q?ioExZDh/gZXGD5/tIJ20BQoP5uSPcuHklhAVBYc9XWES9rcieDfOJEO7Zi?=
 =?iso-8859-1?Q?K0Dkki7FYl3SFKYO5wFMy3VFX0fqs0nVokAY/QyKEtHbTbrSHFStbS4BTw?=
 =?iso-8859-1?Q?f4Uv677ZtfSBRNmvo5Qii6MmiwiSyAlDcYi1dRSANfid/OhCXyYUVxvRhM?=
 =?iso-8859-1?Q?DwsJ+wMPMzlw+8y5OxwrpPAu9AYTUOM3qgP65UZ3mXxTPV2WoqMgS+fVeO?=
 =?iso-8859-1?Q?XJsXPzCk+cHIZPERao2jpuI0mOPDDoJv4MVgmOFiQoc4x+oLaj1BM3Tlg1?=
 =?iso-8859-1?Q?LdgYuNoULLV7x2sdTNRCT58rigiZvDRd25JRl4NaApxr6aXv5YC5h2TY1k?=
 =?iso-8859-1?Q?znv8BBzXZA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yfpv7cEw/FFxjF2EC3iKwTUeCA+3TEgh85ilIWP9BqXR8NK3oAzrCi2le98MW09yVPXMIIGAUPg3OArqZLtqnNFxpEJfef8ppgJ/IsbpqVqobP/k9farSOlSoS/H55B8nhpBkOS1mZU1fQuadVubfjHy9UNfAD2RnGitiPtmFZj/k2wZWWqujr7d2KasJRxcRrgYu9XxvPEQm2IEtdLYSKr4hzzso5e1heYOGO8FaQ4hC/WYSfKUtXTsGV+LPOCQLqn+L970cOSP1JctzGv7Ws4ZUZZcc2YrOWuvNTtSdk5yETNcc5K7KFJX+8owfPV9Ten6nQYySYkDvlZTR5pInQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a99ac63-406e-4d43-179d-08df15519899
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:53:50.6236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpsDLduFCguWaJ6r7e/nludqe54sZ5lsKY8hY/g9g63rKfLcJ9fSSeQjL7Lv4ynkfpLppgyap++ke77K1CVn4dAjkyM9ZsX231DmRsyoTR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8814
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

The eMMC ABR enable state is currently controlled by the "emmc-abr"=0A=
machine property instead of the OTP configuration.=0A=
=0A=
Add helpers to read the OTP configuration and resolve strap values.=0A=
Use the ABR strap value to update ABR_EN when R_STATUS is read.=0A=
=0A=
Remove the "emmc-abr" property as the ABR state is now derived from=0A=
OTP.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h  |  1 -=0A=
 include/hw/nvram/aspeed_otp.h | 23 +++++++++++--=0A=
 hw/misc/aspeed_sbc.c          | 29 ++++++++++++----=0A=
 hw/nvram/aspeed_otp.c         | 63 +++++++++++++++++++++++++++++++++++=0A=
 4 files changed, 106 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 756c612356..b210ffb8aa 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -32,7 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEE=
D_SBC)=0A=
 struct AspeedSBCState {=0A=
     SysBusDevice parent;=0A=
 =0A=
-    bool emmc_abr;=0A=
     uint32_t signing_settings;=0A=
 =0A=
     MemoryRegion iomem;=0A=
diff --git a/include/hw/nvram/aspeed_otp.h b/include/hw/nvram/aspeed_otp.h=
=0A=
index 2b6c2eaaa3..f91af12ea9 100644=0A=
--- a/include/hw/nvram/aspeed_otp.h=0A=
+++ b/include/hw/nvram/aspeed_otp.h=0A=
@@ -24,11 +24,27 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPState, ASPEED_OTP)=
=0A=
  *=0A=
  *  - [0, OTP_DATA_DWORD_COUNT]: the data region. Each address contains=0A=
  *    64 bits of data.=0A=
- *  - [OTP_DATA_DWORD_COUNT, OTP_MEMORY_SIZE / 4]: the configuration=0A=
- *    region. Each address contains 32 bits of data.=0A=
+ *  - [OTP_DATA_DWORD_COUNT(OTP_CFG0), OTP_MEMORY_SIZE / 4]: the=0A=
+ *    configuration region. Each address contains 32 bits of data.=0A=
  */=0A=
 #define OTP_DATA_DWORD_COUNT            (0x800)=0A=
 =0A=
+/* Start of the OTP configuration/strap region. */=0A=
+#define OTP_CFG0                        (0x800)=0A=
+=0A=
+/*=0A=
+ * OTP straps are a 64-bit value packed as two 32-bit halves starting at=
=0A=
+ * config word OTP_STRAP_START_INDEX (OTPCFG16 and OTPCFG17). Each strap=
=0A=
+ * bit is stored redundantly in OTP_STRAP_COPY_NUM config words, spaced=0A=
+ * (OTP_STRAP_BIT_NUM / 32) words apart -- i.e. one word per 32-bit half,=
=0A=
+ * so the two halves interleave; the effective bit value is the XOR of=0A=
+ * all copies, matching how the real hardware and the ast-otp reference=0A=
+ * tool resolve straps.=0A=
+ */=0A=
+#define OTP_STRAP_START_INDEX           16=0A=
+#define OTP_STRAP_BIT_NUM               64=0A=
+#define OTP_STRAP_COPY_NUM              6=0A=
+=0A=
 typedef struct AspeedOTPState {=0A=
     DeviceState parent_obj;=0A=
 =0A=
@@ -43,4 +59,7 @@ typedef struct AspeedOTPState {=0A=
     uint8_t *storage;=0A=
 } AspeedOTPState;=0A=
 =0A=
+uint32_t aspeed_otp_read_config(AspeedOTPState *s, unsigned int cfg_word);=
=0A=
+bool aspeed_otp_read_strap(AspeedOTPState *s, unsigned int bit);=0A=
+=0A=
 #endif /* ASPEED_OTP_H */=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 3402cef5c3..6cec9ad3da 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -71,6 +71,9 @@=0A=
 #define SBC_OTP_CMD_WRITE 0x23b1e362=0A=
 #define SBC_OTP_CMD_PROG 0x23b1e364=0A=
 =0A=
+/* OTP strap bits */=0A=
+#define OTP_STRAP_ABR_EN        0x2b=0A=
+=0A=
 /* Voltage mode */=0A=
 #define MODE_REGISTER               (0x1000)=0A=
 #define MODE_REGISTER_A             (0x3000)=0A=
@@ -89,7 +92,21 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr add=
r, unsigned int size)=0A=
         return 0;=0A=
     }=0A=
 =0A=
-    return s->regs[addr];=0A=
+    switch (addr) {=0A=
+    case R_STATUS: {=0A=
+        uint32_t val =3D s->regs[R_STATUS];=0A=
+=0A=
+        if (aspeed_otp_read_strap(&s->otp, OTP_STRAP_ABR_EN)) {=0A=
+            val |=3D ABR_EN;=0A=
+        } else {=0A=
+            val &=3D ~ABR_EN;=0A=
+        }=0A=
+=0A=
+        return val;=0A=
+    }=0A=
+    default:=0A=
+        return s->regs[addr];=0A=
+    }=0A=
 }=0A=
 =0A=
 static bool aspeed_otp_read(AspeedSBCState *s, uint32_t otp_addr,=0A=
@@ -388,13 +405,12 @@ static void aspeed_sbc_reset_hold(Object *obj, ResetT=
ype type)=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
 =0A=
-    /* Set secure boot enabled with RSA4096_SHA256 and enable eMMC ABR */=
=0A=
+    /*=0A=
+     * ABR_EN is derived from OTP on every read, see aspeed_sbc_read().=0A=
+     * Set secure boot enabled with RSA4096_SHA256.=0A=
+     */=0A=
     s->regs[R_STATUS] =3D OTP_IDLE | OTP_MEM_IDLE;=0A=
 =0A=
-    if (s->emmc_abr) {=0A=
-        s->regs[R_STATUS] &=3D ABR_EN;=0A=
-    }=0A=
-=0A=
     if (s->signing_settings) {=0A=
         s->regs[R_STATUS] &=3D SECURE_BOOT_EN;=0A=
     }=0A=
@@ -452,7 +468,6 @@ static const VMStateDescription vmstate_aspeed_sbc =3D =
{=0A=
 };=0A=
 =0A=
 static const Property aspeed_sbc_properties[] =3D {=0A=
-    DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),=0A=
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
     DEFINE_PROP_LINK("sram", AspeedSBCState, sram,=0A=
                      TYPE_MEMORY_REGION, MemoryRegion *),=0A=
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c=0A=
index 81304bda3a..127da15642 100644=0A=
--- a/hw/nvram/aspeed_otp.c=0A=
+++ b/hw/nvram/aspeed_otp.c=0A=
@@ -106,6 +106,69 @@ static void aspeed_otp_write(void *opaque, hwaddr otp_=
offset,=0A=
     trace_aspeed_otp_prog(otp_offset, val, value);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Each OTP configuration setting contains 32 bits of data.=0A=
+ * Configuration words are grouped in banks of 8, with banks spaced=0A=
+ * 0x200 dwords apart and words within a bank spaced 2 dwords apart:=0A=
+ *=0A=
+ *   offset(n) =3D OTP_CFG0 + (n / 8) * 0x200 + (n % 8) * 2=0A=
+ *=0A=
+ * Returns 0 if the OTP read fails.=0A=
+ */=0A=
+uint32_t aspeed_otp_read_config(AspeedOTPState *s, unsigned int cfg_word)=
=0A=
+{=0A=
+    uint32_t otp_addr =3D OTP_CFG0 + (cfg_word / 8) * 0x200 + (cfg_word % =
8) * 2;=0A=
+    uint32_t value =3D 0;=0A=
+=0A=
+    if (address_space_read(&s->as, otp_addr << 2, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                            &value, sizeof(value)) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read OTP config word %u\n",=0A=
+                      __func__, cfg_word);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * OTP straps are a 64-bit value split across two 32-bit config words,=0A=
+ * each of which is repeated OTP_STRAP_COPY_NUM times for reliability.=0A=
+ * The two words interleave starting at OTP_STRAP_START_INDEX:=0A=
+ *=0A=
+ *   cfg_word:    16   17   18   19   20   21   22   23   24   25   26   2=
7=0A=
+ *              +----+----+----+----+----+----+----+----+----+----+----+--=
--+=0A=
+ *              | L0 | H0 | L1 | H1 | L2 | H2 | L3 | H3 | L4 | H4 | L5 | H=
5 |=0A=
+ *              +----+----+----+----+----+----+----+----+----+----+----+--=
--+=0A=
+ *=0A=
+ *   Lx =3D copy #x of bit 0-31, Hx =3D copy #x of bit 32-63=0A=
+ *   (x =3D 0 .. OTP_STRAP_COPY_NUM - 1)=0A=
+ *=0A=
+ * To resolve strap bit `n` (0 <=3D n < OTP_STRAP_BIT_NUM):=0A=
+ *   half    =3D n / 32   -- 0 selects the L* words, 1 selects the H* word=
s=0A=
+ *   bit_pos =3D n % 32   -- bit position within the word=0A=
+ *   word(i) =3D OTP_STRAP_START_INDEX + half + i * (OTP_STRAP_BIT_NUM / 3=
2)=0A=
+ *=0A=
+ * The effective value of bit `n` is the XOR of bit `bit_pos` across all=
=0A=
+ * OTP_STRAP_COPY_NUM copies of word(i).=0A=
+ */=0A=
+bool aspeed_otp_read_strap(AspeedOTPState *s, unsigned int bit)=0A=
+{=0A=
+    uint32_t cfg_word =3D OTP_STRAP_START_INDEX + bit / 32;=0A=
+    uint32_t bit_pos =3D bit % 32;=0A=
+    bool enable =3D false;=0A=
+    int i;=0A=
+=0A=
+    assert(bit < OTP_STRAP_BIT_NUM);=0A=
+=0A=
+    for (i =3D 0; i < OTP_STRAP_COPY_NUM; i++) {=0A=
+        enable ^=3D (aspeed_otp_read_config(s, cfg_word) >> bit_pos) & 0x1=
;=0A=
+        cfg_word +=3D OTP_STRAP_BIT_NUM / 32;=0A=
+    }=0A=
+=0A=
+    return enable;=0A=
+}=0A=
+=0A=
 static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)=0A=
 {=0A=
     uint32_t *p;=0A=
-- =0A=
2.43.0=0A=

