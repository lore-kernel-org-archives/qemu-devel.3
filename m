Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27C1C4450A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 01:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkXfd-00062T-QH; Thu, 16 Jul 2026 21:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfb-00061z-RV; Thu, 16 Jul 2026 21:47:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfa-0001j6-DS; Thu, 16 Jul 2026 21:47:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDfQrwnm5RF31i/32ypu9vbVpONNrNIroD+cTVFucnB/7VfU3NAea/1nRiO72GEwrZs7qpkqPQOQYG3gYEV6vfpaNXteHYRQIJpN59F6p0Z9AQ9VTKPet9SmY4aFCg4rfZFg5jpfuGbvH0f996Ubgr0HSsG+MzF896jP1M3fqRTw/CRoh8ShXEYretXsMGOnkzUu9AqO2svDQs34wHr0JNM5F/THBY7WRTAz71g/8LGe18R4GyCtx9V5oPaWdicu+FROKTWCvp3AbKSTnQS5dm8V9TTfwa2ULQzWhr9973++7e854Egz8xyU/50Y2glREPR0paHpRl9y2ZSRWf1u8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JG8Etd7Q5/RqtTKxkWB95q5LspQcFuqJhr4/+ZuyjE=;
 b=V5QXNCARZ2lZJiGf0hixK5guYKCBU/b6OLwaY9yQ+NQJmIXpHBlQUugkfv0wNMAR7cR1IajbO7826/R2I9iSgqKZKiIvwTuXzGYR6VozJxWWeKKmg5IFJLmlugAPtbLK8svBnTdYyiyPDLqsMfL88nzLnNpjVPlDkbpensJZMcN4llsWGkBfZPFMKPxiXIAT4auFvmaydrtFvCex2Opri1M0dl2yifA9xaw9sIhhD7dafKm2mkDuD88hA77lehjjWM8sIrl71YJe2qJNrIKFCFGXMxS3eCWtvHLz5o0qDGVVvSl5MQUOpiqrWJk2+NMYzEyYZ1Is4rxZonal4FfmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JG8Etd7Q5/RqtTKxkWB95q5LspQcFuqJhr4/+ZuyjE=;
 b=HZk2uPXOSLkeUzPJrgMWZV5OIM0PIVSNqozATF4ItVthJsyK2gpqYx3c5NP33wQQEorYh9jTjgg/Ifq2axfEiwYXocacWSjttTGfqoXn1/wRQPbfwTN35TyVTWDXbMv8i3mnqqUEFp4Ufhk1CPFmtYn5fymNo8RJj/12k+M75zjMebZfEkVXkPzovYUw2DGy04VJ90xybrKQTvBPMaVABuihGQI1yzLSnbbmN7v3TZdmj4v0AH4GiS8lup4Hkus9hOG0vAf7d/QX57ilF0pzvl7VYGxtIJqS+TJ4tKO0m4l45GYgXzy3TIMaqBEyHe1oTvXR8ATpDqsrsRzmzfOnXA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUYPR06MB9015.apcprd06.prod.outlook.com (2603:1096:d10:74::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 01:47:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 01:47:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/3] hw/arm/aspeed_coprocessor: Clarify SCU/SCUIO/FMC
 fields are shared with PSP SoC to AST2700
Thread-Topic: [PATCH v1 2/3] hw/arm/aspeed_coprocessor: Clarify SCU/SCUIO/FMC
 fields are shared with PSP SoC to AST2700
Thread-Index: AQHdFY4rJZ+Mzc92gkK7ngV/9xBGng==
Date: Fri, 17 Jul 2026 01:47:04 +0000
Message-ID: <20260717014701.1683876-3-jamin_lin@aspeedtech.com>
References: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUYPR06MB9015:EE_
x-ms-office365-filtering-correlation-id: 772dcc05-bec0-46b7-c6da-08dee3a54da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|921020|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: pp4MvTBGO1Pxu2sqDapUaTj3xlg4qoNQfKtoCC0dmGr8Dru39Vv4yyjtiBhifp9GsRDhjAPnaEGzmK47xRpubHXjmMDjeUByHJP8hfwMLPMnYDXPMVJaSvMM1/te8LezYBbKqRdV8+z1x43GmzIIR5YVaDPe29bLiZtSyzKYxe2oBDT30DCJUklP5dJoBgNcR2SH9mKH8A+d8p9HdHoPsKvKPQJ0qGW09DXUe/orA4bZ7kPYMIjMQENF4nJI2YVjUyoFY4SF09hHsoE5dVwogxvPN/9YB9QF0I1L4yufAH5NX+yR7ww3pHhkY4UiyKtH5gS5yLYjkkBmRclSK/XBTJQRqVXZ0FlG5hCCTSBzDUpvz5ywAN6k8IK/aeOFJYF5YZxJr92UeVmjpxc9eD3DLkk21e3jY3mhXBztPvNU74+Cfdrxo6/SVG93x3P+IOEl62guK8dlfkSimAvypkXn7Mti8uwqsgz+W3uq1xiOXpSIOCPFXKTX3XG5rHQcIwNWnTDK0f5jyk+486yyl49TB8TfLlnN1hcQJFq3doQLjzP6ZoRsL812V7I5TYMWjGv+55WdgAFjPzbJuuB7+7ALS+cPW59cOjylgV8V4aSdGASwPlFy84joXxBMYbAT5krrBxFZJQeFPdVbvvtLe+wzmsyXqt3TyFWYqzuLTNRj1Vq9D3cTuWkJsnd8wFxhCTTX5bwc2Dxa8351WxkhRrNOLm2eEQt+zFToRO3h5+J3MW7qIw5ujIPD/ObmggaNXzHY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(921020)(38070700021)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZKFpV6cCa888Ph1S+e4gXhuSdkxub8YEwyPuHj0Q90ppvzvgIX+Zs+apo/?=
 =?iso-8859-1?Q?nPSZgPZcCJ/Qtu49J979XkdQqRWmy6RTn0MH4K/pYgfCJLuH8/WUyefTJ/?=
 =?iso-8859-1?Q?/CUncRy4pDjp1Ra6vJcb4Y/rBuCfXM+1zNzFvhGrlFsb2u1ZHDeITPTQhe?=
 =?iso-8859-1?Q?qtrfpAngQXN4oPzeNF88pNSpCQ2C7kQKj60dzQhciKAdtktjyUOrEWaIyk?=
 =?iso-8859-1?Q?/83BEn/HjW/9CbzWkR74WQuApe4RekIK2z2OwkqQBvAZinIl8aRCf9TP/G?=
 =?iso-8859-1?Q?LGkIlHW9A4cpFlCCAkXYAMvZqEBcvgzPi5fuZuQTxcl1Eot/WwiEm9B8my?=
 =?iso-8859-1?Q?gOO+3f1868M6q5QxKPWx6KlyONodY5E5LehyIiPkn09bjbz611X1igShFi?=
 =?iso-8859-1?Q?jm8VM2hczXDZ66V13Y+MMwO7zbQ0qiD5YLr1KQWxK9POertB85Oq1LlSYc?=
 =?iso-8859-1?Q?QRPfA+J5cWi4jt83vaFxbylTkyj0Sm5SxjKjZr+lPFF0mNR+XHbIVF+u/f?=
 =?iso-8859-1?Q?mWCsCh9ji6bU91C5AoBSTGm6K/8+zdm1jg7iYu0Eu9XQWHY98psbkrvqYF?=
 =?iso-8859-1?Q?pVxdx7jIsoJ0p/94TwIJlSwX34qA16ZPu9qBOV2pkAe8YisW+DwwbjIsSc?=
 =?iso-8859-1?Q?K3syo/HPtyHAEAqEY9cdZ78ge/Wz9ANccdgyl5I8Y85soSlBX/DNd16LyE?=
 =?iso-8859-1?Q?/Nq6TVWHFuMF0c1lHGr9/ZbblsniziHfJzvPNw5B/vjAGM9KgvgMH03IIU?=
 =?iso-8859-1?Q?Ay9Xjvagn4Ae2js8+KN/ZQGHv6VABPGYgD0j+rBP9jNItgwkU+m0Evvcnn?=
 =?iso-8859-1?Q?/2iSW0JWb5v/WQ+bX3ckrNGt/GowsRvJGMp/e1o2EGsfdSwXh6Czx5P2+A?=
 =?iso-8859-1?Q?Dx/ey0W/XOs/3PV/Qnp1nbfmssqyPOGpkGyOAv9OnyNkXE1FIOu8zdWJQo?=
 =?iso-8859-1?Q?+qEzJuvx48JqARWG+mzrM0KICVFe1t+fz66WMzM0c61StANuU26jm2RIWS?=
 =?iso-8859-1?Q?R8Q34n/TAL3/5Lr6pvg9K2rBLvACecBbx8Yo54WNK0YvyY8qxlrqXwVl65?=
 =?iso-8859-1?Q?NoGSGjVbSPbo0x0xmm6c3Qq06Pqfo5VNcnuaSYE+ESYdHgKbmIrZPC/0+3?=
 =?iso-8859-1?Q?0MDYtn0Y7ofEjzMIGK4LxIFWzP3MvF7qErG0zrT3MQVqi9WDD2Y3fcAuSg?=
 =?iso-8859-1?Q?vB+1TXQR7DkK980ZUHt65IW2oSW7zw2EHxw7p0YR/uAhmKe6ox5MVld9SD?=
 =?iso-8859-1?Q?Teu4WCIoGVVL4IKCm/ijxeYE3f8LBbWSbjQ/olGPsmNuaJq9RE2lFraHJp?=
 =?iso-8859-1?Q?SUUT99GecBU8mOV3IwzEyisI0nkIBSn/E67CKtB8gFJh5CUTQebe8ECq/A?=
 =?iso-8859-1?Q?yBku6+wDrxyMD30EkFSyK1EBBFrIjWgTDWtSI2eCe7mBO9+6g6X2rk8DC1?=
 =?iso-8859-1?Q?fLhoGdZERjJQfAxYQ8+stHu41GPIa7J8Gfq+7RJv68NgXY30PhUqYsHRBu?=
 =?iso-8859-1?Q?mTifB10g7rgj0NCo1YgnZgHFmFdIv0BC7yYdejsZL9pxt8OjaqlVXxmCvw?=
 =?iso-8859-1?Q?TJSwB32ggAGaZvfcwuxUZL+snhZ5sE5+hMvb5w3w/l4/UQ/DqVNkqwHRib?=
 =?iso-8859-1?Q?SKtul3xdAfFewaGzoMEQ3j8CvKHGsJDT56NjEk+UZHoVVbwW9hxD23a5j4?=
 =?iso-8859-1?Q?C33GAJQS0ltLaPhRZ2P94BP2CcIgLsVzmcIZl6FIv26JJ6WRs+qCz8glPN?=
 =?iso-8859-1?Q?J+KaKu6RvjTDE6NAx6e4twgnjZwfGyOmJmfKnwUHeVrSwRVSb//AZFQPUK?=
 =?iso-8859-1?Q?MZkl6lQUQA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xk2sb6B4HlOakSG5Tz9iPDDQVKdMYhfKf8e3yg+Hwa4N9WWbf1I7hYelGAHIwn9mY/EllLIimS1jncR67+BRoix8N0isVHv7483A9XCz4Z3v3xxNeaUjrachPMdAKlSLzGm6k+5YsmShqFIDa2nzbxo1P4Lc7X0EpQDRwxj0eZm/QfjKL+9HlTa3Iijv/n6qJvYShooljf8ssleuoiVem3jdRRIkCd/dU/3PXVXOgMSFvyBv85rX+tWExp0gIEQs97kr955MND3GY5QuAkSvSlROkgbXj0d4pnCDhQq5nTG13gHC2LaIaubIkqiEAqwev400mBO5E416CkfeAblDSg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772dcc05-bec0-46b7-c6da-08dee3a54da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 01:47:04.4803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSBOtQ21sGD3zqqVugqhuSlm6Whs4XK3PZfC0zAwR2AZTdkaMBEc6WOpwyvpCAmEA5fpyjznw8MuAg0us8FAblGPM2iHSTvrGx6j0esyjfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9015
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

Add a comment above Aspeed27x0CoprocessorState's scu_alias/scuio_alias/=0A=
fmc_alias and scu/scuio/fmc fields noting that they are not owned by=0A=
the coprocessor: they point at resources owned by the main PSP SoC,=0A=
only aliased into this coprocessor's own address space.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 23c3b97f06..ff359ab532 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -49,6 +49,11 @@ struct Aspeed27x0CoprocessorState {=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
+   /*=0A=
+    * SCU, SCUIO and FMC are not owned by this coprocessor: they are=0A=
+    * shared with the main PSP SoC, and only aliased into this=0A=
+    * coprocessor's own address space here.=0A=
+    */=0A=
     MemoryRegion scu_alias;=0A=
     MemoryRegion scuio_alias;=0A=
     MemoryRegion fmc_alias;=0A=
-- =0A=
2.43.0=0A=

