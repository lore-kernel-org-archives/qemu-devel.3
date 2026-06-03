Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74028CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfF4-00009V-Uz; Wed, 03 Jun 2026 02:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfF1-00006o-Ou; Wed, 03 Jun 2026 02:38:15 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEz-0008Ja-Ka; Wed, 03 Jun 2026 02:38:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktejWSfrNXvdnfs011KD7Qq/KkPpVuT7R7LLywHmHXsVaQS0JskP8YOrj3X9NY0dtQmRUTZymzo4xOJIFYISJt6Tb1d2ArTNmUdkTuzoKRMD2umxvmfifkq7i8hHH2caQTM/97UGW9RgM33rEQXLVXPjlis329KLposHECvVbbyC5nN0vl2RCu7YgGs5Dgb9pcWaFPWi13+APePlTVx37avdoR4JCE6zs/VQgSiuT5r85vok4bv5WoNF+Ui4LkwYAvHcbNEikR2oItsjd1qcm0NDRAwK0U3Qkg0udhpaW7/g0swrJk3FbOoePB7W2RGCkRzZ/OERbBYitVIJ+JnTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hugjYfbVn3TZzHsqf6p+fWyxF7mOkdc/9kgjdKtWAeM=;
 b=XoUHNDZtPfbdB6lkuWzhBpSakAEErixxnZW8cDsE2oxiEDIMiTUvvuUN0ULPjFgJUkaLnL8nAWAtUu8buqXWpyZq1nPs2/VUNMgZWwGUKH9xZptaEb1OAZE107O1ZKLPNhPE43VD8MSOBFNOuHfBEq5Aoc7Ikhl5fUMKLE+DVFE5d9VxAjmXAbHRTOCeZDTcNXupeHVl2XUpmlxmcqeicsGill2JgkPUXD1WJfjN916f+hrujAStcfW3usKUHgSr/YEYMimWtUVONZkf/D8DNKB8TK6BWnfY23qm6i8HJLLU16CIj4hemI8I7WatsrN3K0f0QHMAONX9N8W7BTSLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hugjYfbVn3TZzHsqf6p+fWyxF7mOkdc/9kgjdKtWAeM=;
 b=dwR8HkpC7VXS5URQoZ/gwksSFeqqluJO+IhXi3NoQsfFEIieOxxQdlHHd7SGUqTUuMJHcK7tqqoacFk+8xrIoHiIWyHi4HnIfHQFYh520MwVEUzJuGN49s67EzST1G+T/Wb2il+KegQSy0V9WtZqLxQUT2HcjvhVtZ5iIQmYATgqma709me9P4JvE9+HqPmk03ynGaFGkAyRD+VQNc2iXKK45IGdaUxvEaZYCnfI1nYzTddon5e/godRhNOZJ3yP+x4gZ1A2PjsIauV2XJwnzlUeKSS/T0KgWgjvm/MRc/whymM7FBBS4EJZ5rLrLj5pCp47b26UEgRBpFBQmhasNQ==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by TYNPR06MB8525.apcprd06.prod.outlook.com (2603:1096:405:3d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:38:04 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:38:04 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: [RESEND PATCH 4/6] hw/arm/aspeed_ast1040: Wire Caliptra mailbox
Thread-Topic: [RESEND PATCH 4/6] hw/arm/aspeed_ast1040: Wire Caliptra mailbox
Thread-Index: AQHc8yOHJFB0imqHzkmuJPy6oLm/Gg==
Date: Wed, 3 Jun 2026 06:38:03 +0000
Message-ID: <20260603063756.1481524-5-steven_lee@aspeedtech.com>
References: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
In-Reply-To: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|TYNPR06MB8525:EE_
x-ms-office365-filtering-correlation-id: bfe60f29-d599-4322-5d17-08dec13aaa26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|6133799003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: wEMavIjegsJ0QmLB+hZZQixRk5DwewQ70lZ5SfoVuXlPE0ADuUBZmNEoA9RIrUs6a5Ys5I6Xw6aaKvn8wlwAn2iYwRXNUxOJN8ZQi9ys46kpmzZVXd9YR+mvynHbRHzEWG60L2yujdQ3RtlieqDhKf56LFKv7EpQAF62Cb+/Gx1ALANtkwry3lhoeIThKRFQJftDq51Cd/Nt6NPRsqHOA0YXv8jiQqeOgGSm/OcJYv+tURJl17igvick5/yc3LrT8zyMW05031XWzMduMmBNULlu4NaVLHx/DFLwSZismBy8GpB5uTODWHfL7euJ4Aeo/ddaUbkrysPk23yDjOS50tjgZpzWX4/Ph5ByjWdAgIqmkaHnU3DJ01L3vvnByfsN3kNDR4RNqVNDLchfJdNg+/UeD4liGN4I1VLUgD2mJDqmEhAbtBO6B3SpqFA/vUKhqIT7l8IJaohDCfc2mzFiQsLKLI7VKzLsVXh/lFQqe3BNygs0o2uAFK5hA41w2nzjTOLeVhdiFrCCkEO6n/Id7+6TDts9viuBVgG5KbjP9ccgw6UqSq3HU0I84YHkymktaLbu5nsvSsO/UouGihXEu2A+Vr2G/HIic5K/mZTg6sckIzYC3x2656j5eBpHSUfOiv+HsnWn5/1Cj9SL4AU1s4o0dDXeoUIgL2wNXpgyLqUo/G1KG5vMEUmS3siOdgiEMPEhZaTGQ+s/xNYVDCJ3X+zTqV8FGSOB5rAcdLbnzD/KFiDuyQjTXmc/uICRGNI91lVvUiXd1nd0YKk/U2gt3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mG3GQR82KVncjgvEMP4zAcdqvxw7p5/ZTNbDev85V5zDgFX5lgz6NIbu+W?=
 =?iso-8859-1?Q?anOx1d/41vTVzzJbW1ctZEOdyxwQfIbuMSUpiozWLt1dMvt9tB9q+W2Lyk?=
 =?iso-8859-1?Q?skmJ67WPPfW6gK5rcaBZBUaZ4z5PK37ZhnGLzeM+mPk9aD8k0/oBUXL+FT?=
 =?iso-8859-1?Q?ovk4cE0TOBBcWWEXvEhlfwwKllOwqQUqhqCKjfzkHuXN36GZfWrAUrIBm0?=
 =?iso-8859-1?Q?RYFPS6H48b9BxTq7R1YD11Mb9h4zqjjmMMLVqeBeAN1Sbcc12uORTL3+2t?=
 =?iso-8859-1?Q?exk9RdgL2wx1FBhJPd16VBkIcjola8gDnkp5HbAI/XuWQ/A20AlQ3HSl38?=
 =?iso-8859-1?Q?oMJVCnOoU8GHJ7pn07+nUEEpzO9yz75iPTBIiIZtsoR8Na59ih7DDKsxAx?=
 =?iso-8859-1?Q?9ZHWrsNnv0yNBf7LqZRSNf6BTD9cHVRNyI/NPAS6uuhKO1Fb3gpA6mSRYw?=
 =?iso-8859-1?Q?EuMkZINbN3aAC3KjObHUig4GKkKeZj1Qla7vSgP6bkaRRbn9JoVsaUloVN?=
 =?iso-8859-1?Q?3QX5NHJ9TxRTSVpV1CVkY7NnDCpj7B5riOg4gh1HnhOoTptAG7/ajpS3m9?=
 =?iso-8859-1?Q?pkvDgLIVg6Rs2gUUIQN+uQYobz73buwafmPjBrAhO+wahyJzhLXbUKhlo+?=
 =?iso-8859-1?Q?wrl02ns7E2xnfWmtF/iDI6TNiaaini69vKE1xo9g8pCpaBR2OYwQa+JIAX?=
 =?iso-8859-1?Q?n8MciOeyVbVBKrMaILkAZGu8kSxkB6C49QFnTweEsx8qOIHeeRcbMnf44I?=
 =?iso-8859-1?Q?wiRZ6mmBE6/EeTa8eDzUbuvx9gcqXBvLIs0oqaXqce+aIkjhYDjrecY64m?=
 =?iso-8859-1?Q?KpMq1nVgVDUxiQjgQrKxVCJgB00EnbKh4OOtemWDjjx/2VK+Ng0TUgaMQO?=
 =?iso-8859-1?Q?Onw2ULSLM+8TqRF/DwqscVOPFbo4f6iS6wJ6fkIPw1bawWwt3CvjL2r+Q4?=
 =?iso-8859-1?Q?KtIl+DOe31upg8EAV/NCL+qfuv+/IKPP6x9fhHiMofjs1pYFLomZfpoNp9?=
 =?iso-8859-1?Q?WT6omJ1iE1mW1bgD0sEuh7O/ln0pbhRgLQefCvu1s3Q2hpjqvGZ53znkY8?=
 =?iso-8859-1?Q?DF7GghLyIH78WNoqyFs8ldoTAyjZJRLl0aqgTO+jMQMPlMMyS/3ZrUQi62?=
 =?iso-8859-1?Q?7IQp0SfMQpvKJzAaI65znJI2ljxe1IozWAis0ofK9j8+kR0wi2+apOJ6d9?=
 =?iso-8859-1?Q?RP+OXP0nRZCckT8lMm6hOPGoHs74AhiwlfM2flFXGklMtT7AKwM1BoNFgn?=
 =?iso-8859-1?Q?GQdR/9B901TwWbLulqe2i4GHaNfRQbXpOsl03zhvQSHKo/TNa4fbelMSAw?=
 =?iso-8859-1?Q?IUW6oSn3ZGA/LONX1WiolnItrFMNYvaWAO70VbWSrbBPuJy4n0qi85PjUt?=
 =?iso-8859-1?Q?rWztkTh80Hc/MGnGdjpBICtkTtKlP60GujIFb04tLPLnapIucItJqiSDcS?=
 =?iso-8859-1?Q?e22IMyNGiWEyoP4cLZIgJVxyOL7Oj2h+1P0Tqzv3DgxdjzhpLoLJgzTNPH?=
 =?iso-8859-1?Q?wahJroY9a0FLJyVeIcdAv0aZJiLie0v9iK9NdpG6Aye/a67eUXlNlCT0OP?=
 =?iso-8859-1?Q?Frx3TE6/2By/r8fmlpePVBfBt/IR/bExBH8clDf2UppPy/xTHysGTCa1aF?=
 =?iso-8859-1?Q?PMlcw1J23qscgCHciqwESOncSCH4ySgcAwsqXSjJz34rzR4M5YfJI23sIs?=
 =?iso-8859-1?Q?LjniL9NR5nByLtfxNWd72NDuUPATJgH4kki2EXO4bt7SyluI9RVJRo2cXk?=
 =?iso-8859-1?Q?C9ALRPV+TtC1mEy60+WUot0pfHu5K3C6fEGqOLi3p6tUHxdIPOBNPUuTlJ?=
 =?iso-8859-1?Q?du5k1mlOFA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g6rif89+FQ9EFTVlpDKgLQZ/XJ0XFrBemako076uWPrRuVGSvWS6J1D/P/eyWTxZDKVHyx+UV+7uwpyuuDtHnUnSozLQRZ5TtsGpIeFtDMiXa/q/zfr1yprk3PWsQUx+VC/AWPYPoYE7xMUcg/wmT2gOB9b8o4Aoan/qyi8OWkLpyipthVtUqUXmFuYbQDZ9v7U4T/X8Gq8EFQbrvZl0kW7GVbkkMdHOvJ+Uf9S0bkaWkGKykNP32FXreR2gYyhCqorFwWLyELdIL44Dz9/ZgdRCeUjuhKeRQArpGi5RnHkzhSUG2nxX9qM0C9qOZOmx2q49ISlgqZiPxyGyB5KmkA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe60f29-d599-4322-5d17-08dec13aaa26
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:38:03.9464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3EDG31K91eqjbdsUce6gfhun026XGNcOJFZo/gq7AnHX9z6QnSucx0zxZwjxWfMZV5Ukh4C2zqE/wB02MnAQ0R8+Mdw5kbCG1Y45bmLnCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8525
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=steven_lee@aspeedtech.com;
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

Instantiate the Caliptra mailbox in the AST1040 SoC and map its SRAM and CS=
R windows at the guest-visible MCI addresses.=0A=
=0A=
Add the 4 KiB MCI aperture controlled by the AST1040 SCU CPTRA page registe=
r, switch the SoC to the AST1040 SCU model, and expose a machine option tha=
t links an external mailbox peer after machine initialization.=0A=
=0A=
Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 11 ++++++=0A=
 hw/arm/aspeed_ast1040.c     | 60 ++++++++++++++++++++++++++++--=0A=
 hw/arm/aspeed_ast1040_evb.c | 74 ++++++++++++++++++++++++++++++++++++-=0A=
 3 files changed, 140 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 3aac144cd4..9fad3bc082 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -46,6 +46,7 @@=0A=
 #include "hw/intc/arm_gicv3.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/arm/aspeed_ast1700.h"=0A=
+#include "hw/misc/aspeed_cptra_mbox.h"=0A=
 =0A=
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"=0A=
 =0A=
@@ -165,6 +166,16 @@ struct Aspeed10x0SoCState {=0A=
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)=0A=
 =0A=
+struct Aspeed1040SoCState {=0A=
+    Aspeed10x0SoCState parent;=0A=
+=0A=
+    AspeedCptraMboxState cptra_mbox;=0A=
+    MemoryRegion cptra_mci_window;=0A=
+};=0A=
+=0A=
+#define TYPE_ASPEED1040_SOC "ast1040-a0"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed1040SoCState, ASPEED1040_SOC)=0A=
+=0A=
 struct AspeedSoCClass {=0A=
     DeviceClass parent_class;=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 8efcdad8f6..c597982bc5 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -8,12 +8,17 @@=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
 #include "qapi/error.h"=0A=
-#include "system/address-spaces.h"=0A=
 #include "system/system.h"=0A=
 #include "hw/core/qdev-clock.h"=0A=
 #include "hw/misc/unimp.h"=0A=
+#include "hw/misc/aspeed_cptra_mbox.h"=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
 =0A=
+#define AST1040_CPTRA_MCI_WINDOW_BASE 0x74200000=0A=
+#define AST1040_CPTRA_MCI_WINDOW_SIZE 0x1000=0A=
+#define AST1040_CPTRA_MBOX_SRAM_BASE  0x21400000=0A=
+#define AST1040_CPTRA_MBOX_CSR_BASE   0x21600000=0A=
+=0A=
 static const hwaddr aspeed_soc_ast1040_memmap[] =3D {=0A=
     [ASPEED_DEV_SRAM1]     =3D 0x00000000, /* Hyper RAM */=0A=
     [ASPEED_DEV_FMC]       =3D 0x74000000,=0A=
@@ -88,6 +93,7 @@ static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState=
 *s, int dev)=0A=
 =0A=
 static void aspeed_soc_ast1040_init(Object *obj)=0A=
 {=0A=
+    Aspeed1040SoCState *a1040 =3D ASPEED1040_SOC(obj);=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(obj);=0A=
     AspeedSoCState *s =3D ASPEED_SOC(obj);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
@@ -96,12 +102,13 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
 =0A=
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
 =0A=
-    /* AST1040 uses the AST2700 SCUIO model */=0A=
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);=
=0A=
+    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_1040_SCU);=0A=
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);=
=0A=
 =0A=
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu), "hw-strap=
1");=0A=
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu), "hw-strap=
2");=0A=
+    object_initialize_child(obj, "cptra-mbox", &a1040->cptra_mbox,=0A=
+                            TYPE_ASPEED_CPTRA_MBOX);=0A=
 =0A=
     for (i =3D 0; i < sc->uarts_num; i++) {=0A=
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_M=
M);=0A=
@@ -120,8 +127,31 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
+static bool aspeed_soc_ast1040_realize_cptra_mbox(Aspeed1040SoCState *a104=
0,=0A=
+                                                  Error **errp)=0A=
+{=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(a1040);=0A=
+    DeviceState *mbox =3D DEVICE(&a1040->cptra_mbox);=0A=
+=0A=
+    /*=0A=
+     * Caliptra is an AST1040 integrated RoT IP. The external peer is=0A=
+     * optional; without a peer, the mailbox registers remain present and=
=0A=
+     * EXECUTE completes with CMD_FAILURE.=0A=
+     */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(mbox), errp)) {=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(mbox), 0,=0A=
+                    AST1040_CPTRA_MBOX_SRAM_BASE);=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(mbox), 1,=0A=
+                    AST1040_CPTRA_MBOX_CSR_BASE);=0A=
+    return true;=0A=
+}=0A=
+=0A=
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
 {=0A=
+    Aspeed1040SoCState *a1040 =3D ASPEED1040_SOC(dev_soc);=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(dev_soc);=0A=
     AspeedSoCState *s =3D ASPEED_SOC(dev_soc);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
@@ -171,6 +201,27 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
                                 &s->sram[1]);=0A=
 =0A=
+    if (!aspeed_soc_ast1040_realize_cptra_mbox(a1040, errp)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * The Caliptra MCI aperture is a 4 KiB alias whose target is selected=
 by=0A=
+     * AST1040_SCU_CPTRA_PAGE_REG0. Firmware commonly switches it between=
=0A=
+     * mailbox SRAM (0x21400000) and mailbox CSR (0x21600000), then access=
es=0A=
+     * the selected page through 0x74200000.=0A=
+     */=0A=
+    memory_region_init_alias(&a1040->cptra_mci_window, OBJECT(s),=0A=
+                             "aspeed.ast1040.cptra-mci-window", s->memory,=
=0A=
+                             0, AST1040_CPTRA_MCI_WINDOW_SIZE);=0A=
+    memory_region_add_subregion(s->memory, AST1040_CPTRA_MCI_WINDOW_BASE,=
=0A=
+                                &a1040->cptra_mci_window);=0A=
+    /* The SCU drives the aperture's target offset via SCU_CPTRA_PAGE_REG0=
. */=0A=
+    object_property_set_link(OBJECT(&s->scu), "cptra-page-window",=0A=
+                             OBJECT(&a1040->cptra_mci_window), &error_abor=
t);=0A=
+    object_property_set_uint(OBJECT(&s->scu), "cptra-page-window-base",=0A=
+                             AST1040_CPTRA_MCI_WINDOW_BASE, &error_abort);=
=0A=
+=0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
         return;=0A=
@@ -244,8 +295,9 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
 =0A=
 static const TypeInfo aspeed_soc_ast1040_types[] =3D {=0A=
     {=0A=
-        .name           =3D "ast1040-a0",=0A=
+        .name           =3D TYPE_ASPEED1040_SOC,=0A=
         .parent         =3D TYPE_ASPEED10X0_SOC,=0A=
+        .instance_size  =3D sizeof(Aspeed1040SoCState),=0A=
         .instance_init  =3D aspeed_soc_ast1040_init,=0A=
         .class_init     =3D aspeed_soc_ast1040_class_init,=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c=0A=
index 1d9b55247f..eb325a1095 100644=0A=
--- a/hw/arm/aspeed_ast1040_evb.c=0A=
+++ b/hw/arm/aspeed_ast1040_evb.c=0A=
@@ -8,17 +8,59 @@=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
 #include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
 #include "hw/arm/boot.h"=0A=
 #include "hw/arm/machines-qom.h"=0A=
 #include "hw/arm/aspeed.h"=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
 #include "hw/core/qdev-clock.h"=0A=
+#include "hw/misc/aspeed_cptra_mbox.h"=0A=
 #include "system/system.h"=0A=
 =0A=
 #define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)=0A=
 /* Main SYSCLK frequency in Hz (400MHz) */=0A=
 #define SYSCLK_FRQ 400000000ULL=0A=
 =0A=
+#define TYPE_AST1040_EVB_MACHINE MACHINE_TYPE_NAME("ast1040-evb")=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Ast1040EvbMachineState, AST1040_EVB_MACHINE)=0A=
+=0A=
+struct Ast1040EvbMachineState {=0A=
+    AspeedMachineState parent_obj;=0A=
+=0A=
+    char *cptra_peer;=0A=
+    Notifier machine_done;=0A=
+};=0A=
+=0A=
+static void aspeed_bic_machine_done(Notifier *notifier, void *data)=0A=
+{=0A=
+    Ast1040EvbMachineState *m =3D container_of(notifier,=0A=
+                                             Ast1040EvbMachineState,=0A=
+                                             machine_done);=0A=
+    AspeedMachineState *bmc =3D ASPEED_MACHINE(m);=0A=
+    Aspeed1040SoCState *a1040 =3D ASPEED1040_SOC(bmc->soc);=0A=
+    bool ambiguous =3D false;=0A=
+    Object *peer;=0A=
+    Error *err =3D NULL;=0A=
+=0A=
+    if (!m->cptra_peer) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    peer =3D object_resolve_path_type(m->cptra_peer, TYPE_CPTRA_MBOX_PEER,=
=0A=
+                                    &ambiguous);=0A=
+    if (!peer || ambiguous) {=0A=
+        error_report("cptra-peer: peer '%s' not found%s",=0A=
+                     m->cptra_peer, ambiguous ? " (ambiguous)" : "");=0A=
+        exit(1);=0A=
+    }=0A=
+=0A=
+    if (!aspeed_cptra_mbox_set_peer(&a1040->cptra_mbox,=0A=
+                                    CPTRA_MBOX_PEER(peer), &err)) {=0A=
+        error_report_err(err);=0A=
+        exit(1);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void aspeed_bic_machine_init(MachineState *machine)=0A=
 {=0A=
     AspeedMachineState *bmc =3D ASPEED_MACHINE(machine);=0A=
@@ -38,12 +80,35 @@ static void aspeed_bic_machine_init(MachineState *machi=
ne)=0A=
     aspeed_connect_serial_hds_to_uarts(bmc);=0A=
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);=0A=
 =0A=
+    if (AST1040_EVB_MACHINE(machine)->cptra_peer) {=0A=
+        AST1040_EVB_MACHINE(machine)->machine_done.notify =3D=0A=
+            aspeed_bic_machine_done;=0A=
+        qemu_add_machine_init_done_notifier(=0A=
+            &AST1040_EVB_MACHINE(machine)->machine_done);=0A=
+    }=0A=
+=0A=
     armv7m_load_kernel(ARM_CPU(first_cpu),=0A=
                        machine->kernel_filename,=0A=
                        0,=0A=
                        AST1040_INTERNAL_FLASH_SIZE);=0A=
 }=0A=
 =0A=
+static char *aspeed_bic_get_cptra_peer(Object *obj, Error **errp)=0A=
+{=0A=
+    Ast1040EvbMachineState *m =3D AST1040_EVB_MACHINE(obj);=0A=
+=0A=
+    return g_strdup(m->cptra_peer);=0A=
+}=0A=
+=0A=
+static void aspeed_bic_set_cptra_peer(Object *obj, const char *value,=0A=
+                                      Error **errp)=0A=
+{=0A=
+    Ast1040EvbMachineState *m =3D AST1040_EVB_MACHINE(obj);=0A=
+=0A=
+    g_free(m->cptra_peer);=0A=
+    m->cptra_peer =3D g_strdup(value);=0A=
+}=0A=
+=0A=
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,=0A=
                                                   const void *data)=0A=
 {=0A=
@@ -59,12 +124,19 @@ static void aspeed_machine_ast1040_evb_class_init(Obje=
ctClass *oc,=0A=
     amc->macs_mask =3D 0;=0A=
     amc->uart_default =3D ASPEED_DEV_UART12;=0A=
     aspeed_machine_class_init_cpus_defaults(mc);=0A=
+=0A=
+    object_class_property_add_str(oc, "cptra-peer",=0A=
+                                  aspeed_bic_get_cptra_peer,=0A=
+                                  aspeed_bic_set_cptra_peer);=0A=
+    object_class_property_set_description(oc, "cptra-peer",=0A=
+        "Caliptra mailbox peer object id");=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_ast1040_evb_types[] =3D {=0A=
     {=0A=
-        .name           =3D MACHINE_TYPE_NAME("ast1040-evb"),=0A=
+        .name           =3D TYPE_AST1040_EVB_MACHINE,=0A=
         .parent         =3D TYPE_ASPEED_MACHINE,=0A=
+        .instance_size  =3D sizeof(Ast1040EvbMachineState),=0A=
         .class_init     =3D aspeed_machine_ast1040_evb_class_init,=0A=
         .interfaces     =3D arm_machine_interfaces,=0A=
     }=0A=
-- =0A=
2.43.0=

