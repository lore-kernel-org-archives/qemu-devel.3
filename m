Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846AEC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 20:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tf6-0000zk-LZ; Tue, 30 Apr 2024 16:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.mamone@cambridgeconsultants.com>)
 id 1s1sSE-000344-VG
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:43:51 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.mamone@cambridgeconsultants.com>)
 id 1s1sS6-0004fY-Bp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HENSA/2fWaDunji1Rwn3AVkOwAGIB1/tat32Fq3Atq9xaPiw1F0J2cYS8qVK8dwuXBJUOCANvRI+fgupnjlQHTkx8kqzuGh7Xum11h2M/Ed4g0d0B39lvbTdJGcsK0xUDV31u6ILNOVvGOGzIEShG/8CxiIDjJgbsHkJneIpi6MPAFH3zeUR7db5NcVjRPlDvLhE/6Y0wmWgcWC3/I1+7Cqq8yNCuZVrpdJdYUsRVaN5xHHN4Ectd7EVyM5Cr2rz8PJ5LmHHqgY5YbYrLJNyU+srSkUf+6c61ZG25qfmNn/oA1F+HEioMgFTnLEO5T3PGncPgLWazaaaqNdZSOO+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWtyWqIBAquy+PejJl6/+BQGYvEhFXQLSRgVWqBMfB8=;
 b=BtgEgaFfViF9YArv6PUuPsL5tA/LxiY+arSxqfxlU6PQENQL6FcPTznnPmoreJPnD4LZ95RZ/B5PBRF7X+4vZQR+Rr7HnuLE8m61Mu7apjtprXW9C59DUUvQRSe/hbU7Op9rGNW6MPR2qf9Sc2+bwQRZjaT4a0lYjQb74YaQNpyVxeiCXmMFMb+Pzb6muwDsL4W369cJZw+Wi+OxtOxgg+bhd6UhLyDMUguG/XbqcjfnqEDgttAYHsYj7Ycu2rawO8/N34vbdDPw8RpT15glyatoSjDlxeBeyB/moNdqM77fbEojxfWY6X6nlvT60K5KrnskPLjKUoOzTWECx/ICYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cambridgeconsultants.com; dmarc=pass action=none
 header.from=cambridgeconsultants.com; dkim=pass
 header.d=cambridgeconsultants.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teamworkfocus.onmicrosoft.com; s=selector2-teamworkfocus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWtyWqIBAquy+PejJl6/+BQGYvEhFXQLSRgVWqBMfB8=;
 b=fL/WPHdeVy5e/fH8J2Rb4alKaICNw41rHBzXqrdEFjOv9f+D89sIxShdZb1d9RQsNaWnkOkFCsFOs+30XDp9mr4FS3jq/qKHfAkqKijEn4QBI6o/AbSQYOKVLkjFwpLF40mUpU2+r24AlaAUd/FVzsnL/WblpHa7udJI91kBlpt2Vyik5W/zHkGTfCO8Al8rqdnEqCKuuAnVPCFR+iJNH/Hj7L6v0t4hzo9LF4mcH3jiNQXB1BKD18C/gJV+3kb96ioGcxCixqqVVahAiaJex2DCNx4nDBcX9Y14d53DVqBXjRFqGcVNLMVfCxuPByWAVQfmNOEtRyt59eINHGP+9Q==
Received: from MN2PR18MB3245.namprd18.prod.outlook.com (2603:10b6:208:163::16)
 by DM4PR18MB4224.namprd18.prod.outlook.com (2603:10b6:5:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 18:32:29 +0000
Received: from MN2PR18MB3245.namprd18.prod.outlook.com
 ([fe80::aa67:58c0:bf38:31d5]) by MN2PR18MB3245.namprd18.prod.outlook.com
 ([fe80::aa67:58c0:bf38:31d5%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 18:32:29 +0000
From: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] hw/display: Add SSD1306 dot matrix display controller support
Thread-Topic: [PATCH] hw/display: Add SSD1306 dot matrix display controller
 support
Thread-Index: AdqbK345jaEl2j54Qs+mUnVNH1704Q==
Date: Tue, 30 Apr 2024 18:32:29 +0000
Message-ID: <MN2PR18MB3245B1A3994C378A3BED5C439E1A2@MN2PR18MB3245.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cambridgeconsultants.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR18MB3245:EE_|DM4PR18MB4224:EE_
x-ms-office365-filtering-correlation-id: d4245ef0-ca9f-4aba-aa20-08dc6943e47f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZqtZNikKMrcaAKzgmrxCrdKEiTn1SgPEZuJp1SEq9bIiln3/6f6EjasWID82?=
 =?us-ascii?Q?AHJdKhlojkss/iYIIY56Tred9FbH1jcy7vG6YpADYGEnQ5mx0VhhITKpWIIN?=
 =?us-ascii?Q?loHDjsq10QIrw1qlJLiPTM0OOtDho1od7QZECMnQEXfnWEGXbrebnjUbklaH?=
 =?us-ascii?Q?+jgwemlnsXleicCLYfUPf/rqicNQwxH75UgHzGh5IuR2G16LnCXK8z2qktVn?=
 =?us-ascii?Q?iKQ4QXHw8Zn/DjpwfXxr5lBMGKfpq8APMVM4hdTLg1iLLwtkyTSejbT6wmDP?=
 =?us-ascii?Q?X5mWsa8UxNeHbgkQTG12eQdRMmzIzqP7AceougdETF4jjV+ofF3vG0aLBIgI?=
 =?us-ascii?Q?GvSwndp9y6bLH4apSRbwRywHEZMCxZm4w1EDOoWn4upQwQTW29Uhdy2K2w8i?=
 =?us-ascii?Q?XFT5v2uXDMLsRTch3jiIc8owAcIjOLrMcqCuf/w0DNWYUOcaLFMMkNo04ypR?=
 =?us-ascii?Q?z9wWB/wIq0bBLT0JVbKTE8STm6hqIdS/by+vdW51hv7ph0l3s69fPwLX51ZG?=
 =?us-ascii?Q?DYigmB4QfsPoLjb2hZjCkf+B/yWSlIDohTGOKD5sZ8Ppwwd9LQAtB960xK/T?=
 =?us-ascii?Q?q3+X96MMnnw09dJy3c+oLuwwZmwugMTDiR387nGcp4VVEiFvW+cLero7OOB3?=
 =?us-ascii?Q?BS3XSpextAkQGfHeg5gblpggs1VrsFSDKmq4V+Eu8x5Q+/0xVEGNhE+qyJH5?=
 =?us-ascii?Q?lGnA5kNXD/a8m0ZRNfbCsdBs87Ftwm87N8Ldz7STRRQRNJSzlCFwV5QMYj5w?=
 =?us-ascii?Q?PT59tu5jYgjVcf8T2xwFag+UB6damOw3BOsmFNfLjHGg8ITs/C5mNm3d6wGT?=
 =?us-ascii?Q?Scr7Fon7GFt348qbuJBjEhz7bfgqo3hINgV8oZ5SQXbQIunTm39tv4bq5C2n?=
 =?us-ascii?Q?LS7oWN3G4xZTGztEcACoXXgEEgybIf92ulUEpRCW8bSs6f5IEweUK8VhKkjo?=
 =?us-ascii?Q?Kv18+0b576b/ICp89Qujyj/POHL7OhaeKsC47IOG0ejIAp+TbLDtCSpG16ig?=
 =?us-ascii?Q?lr2RhRw4kMaWJSMzlCYuBJP++vGSCF3JsN/CYC5wuj40uXkV2Ak+/eFTVXYH?=
 =?us-ascii?Q?0K9AwiuXGdS60lXeuHel1cPxL8bplDIreLcjWO8R7hYgnBNwnUcoahiKdeUt?=
 =?us-ascii?Q?Rx0QntUG6xVYgoRyWUeGwhbjxS+R8hhmnZiGqF6JiM5TGp3CPZvbCL4TDClI?=
 =?us-ascii?Q?MFUJ/rFgpy94th8pkJagtur0NixIyXnBbAAiANzEijm/nUXbztq/rtmT1l2A?=
 =?us-ascii?Q?HzZrjC4d1+6M3IY/uW8MwFf4QLFEfvazOytrXoh9h8dhZB20XopyLDZCG2iO?=
 =?us-ascii?Q?6OZjAWdE7hJVrG9a7uls97pmfgHQYQehrR19Gb4ywYLTsA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR18MB3245.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+lX4vqDAM9BnYOoHvBpMnQHGKAFrEatntP4UIUuI0GLdhUt4xpqAyjCCCimq?=
 =?us-ascii?Q?/+9zVTv1cNLd0JjxWCbTCGBUsEGY/49NQ9MzysGpYGAhysxaOLkRrQeEJCCC?=
 =?us-ascii?Q?yd1BpJuCXv1N7thAd9fglf8aON50ksJysfOFab+HaNk+ajmPHEXwockfBpe4?=
 =?us-ascii?Q?sg79us9/Gfap3gdOW4DJ7TswDqoJWCQkVADf2Xyk0S/cXJdKwysZ4ClLwahA?=
 =?us-ascii?Q?90SoocW4s3TucBrSHkaQL/owkNQB3QS2YxViEmaMyKXyq8/aUC/j43XIAKDv?=
 =?us-ascii?Q?cxiOeYzEnvpexPTgdLlg0lXPknCxQuRlWHayfivekhMxJKkP0WEfH7F1CHOO?=
 =?us-ascii?Q?LPkOygs3wUVTZT4d37G11tJFC2/X1qWpHDb7aW83DKsZfAKD6w5VCs9b8W/2?=
 =?us-ascii?Q?IG7JqlNHENlaPVMf0vgjBlcEA7P0BRG0tBz8LweuXSus+XChykWGjOfvzLLr?=
 =?us-ascii?Q?V/vP67FjRoVqRjAsA7G+cSKuEL/p7724z21/SxLAIuHcfWaD1scbTfXE2AeO?=
 =?us-ascii?Q?EnR3N7BbTd4B9ului2CXTEBPWJi5nLrIhxTyZVnh2YTv3qrBdL0E/aF5J6W3?=
 =?us-ascii?Q?jBl4kvKl9MlrcrSPdDuLeGbraGrRp+bS6UHR/QKAAULcpbLtHjZ3XoP2EDKa?=
 =?us-ascii?Q?dW0QBqotQ89F2Vl6XXTlwsgFppKsCy0IuO+s7kTQEFBY47DVx7vfiB7PDxMR?=
 =?us-ascii?Q?j8UrwiUMZylRGmPv2SN8KXag8D3YgVZgBp9oNE5/TUyohF6WaSQ+F8l/fxol?=
 =?us-ascii?Q?3qFrZvZn3gqInc0j+flxGBTG82xyMEN1tdBSxuBonZFBuX4l+doNsSVeIzZi?=
 =?us-ascii?Q?1u4qpwAEvys9qEwQ2aVFdvs3RngBdkvybGEBAEq16oQCbbTK6M+P4lucYhMo?=
 =?us-ascii?Q?jZYsmGTdKDa/O05uOYy0oAsYSuDDR05+XTKjnvQgube7lnLvmBmyIlsua0Ud?=
 =?us-ascii?Q?TiKPR3fipf+pyP0zzGwWkajKvBMTo4FFCYD9+HDRAHpvdv6AObwxaBsQ6CWJ?=
 =?us-ascii?Q?UJ30RzJ6lW1eTz8ZZ5+fFpj2ItrKPgQIYqjaMXwqMgl1aMUE0fox7KPP/JNe?=
 =?us-ascii?Q?rfEOktTErNmjfM3xZVWEpp5ByO7icSr6VBPJwoVyKqcrVyoNA+QDGcB1yUzA?=
 =?us-ascii?Q?Ccbo2v4GRIlSNd7KfNHC4CzbpLCFZYAsFFuVvQZZHWyAQBy8YDOI7qzg3mIz?=
 =?us-ascii?Q?5Mzt/gFZEgHt1ue6v48CdkyoeLN3SO1p4M4ShAIxudPeJkBLlT/KB/zDXhTX?=
 =?us-ascii?Q?tf8CPKANRpcUCrYjjIsQVUKHh3LjXfFW17PZ9OHsa2Ch6LNb/1kJRIv3hCX4?=
 =?us-ascii?Q?M9jP4MZyJm3Vy377GZg5/qprskyHEBtWf59jadlJb7XoOC6x5U6vND8ygS9q?=
 =?us-ascii?Q?tLGxpgxVh/I0+ts4FovrJDCTmkilTeAX6mmefCJzu8NzNb7iBffxC7//Qnna?=
 =?us-ascii?Q?cVS1W5o2tZWn6IIQejB0MDHYb2uxewx+EY/+J6cdysCS8e9CouD3/r+J+7MA?=
 =?us-ascii?Q?tBdqKKIDGm1qcftn3VEtd1NdhU9Bc85XeeK67FrQwSHVP49iVq0AkCB2uMgl?=
 =?us-ascii?Q?/2iMw1INoYMMiUPjePhGH7BBAnniicB2CL7h0OFGUW9fu5kIPJ38ZqLqmNs9?=
 =?us-ascii?Q?VipbNJ4JY8/SKLuINmtDPHU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR18MB3245B1A3994C378A3BED5C439E1A2MN2PR18MB3245namp_"
MIME-Version: 1.0
X-OriginatorOrg: cambridgeconsultants.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3245.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4245ef0-ca9f-4aba-aa20-08dc6943e47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 18:32:29.6904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5456737e-8eab-46dd-b7dd-26953ed21090
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: br/PRQVfCeuhtYJPoXcLT9E4K63wRyHHNhF9a1jmFHA+hSU89R9G/HxE6aMm95bZZOgPswERIFRLhW6xAPePnIFUF1ix0MtI9WDwmXnPYzJlfulIKT83O/etVKBoWQQN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4224
Received-SPF: pass client-ip=2a01:111:f403:2418::600;
 envelope-from=ryan.mamone@cambridgeconsultants.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Apr 2024 16:01:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_MN2PR18MB3245B1A3994C378A3BED5C439E1A2MN2PR18MB3245namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From 617b2d92085d03524dcf5c223568a4856cdff47f Mon Sep 17 00:00:00 2001
From: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
Date: Tue, 30 Apr 2024 13:20:50 -0400
Subject: [PATCH] hw/display: Add SSD1306 dot matrix display controller supp=
ort

Signed-off-by: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
---
hw/display/Kconfig     |   5 +
hw/display/meson.build |   1 +
hw/display/ssd1306.c   | 612 +++++++++++++++++++++++++++++++++++++++++
3 files changed, 618 insertions(+)
create mode 100644 hw/display/ssd1306.c

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 234c7de027..58afe4048b 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -37,6 +37,11 @@ config SSD0303
config SSD0323
     bool
+config SSD1306
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
+
config VGA_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 4751aab3ba..39f0724e02 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_PL110', if_true: files('pl110=
.c'))
system_ss.add(when: 'CONFIG_SII9022', if_true: files('sii9022.c'))
system_ss.add(when: 'CONFIG_SSD0303', if_true: files('ssd0303.c'))
system_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))
+system_ss.add(when: 'CONFIG_SSD1306', if_true: files('ssd1306.c'))
system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xenfb.c'))
 system_ss.add(when: 'CONFIG_VGA_PCI', if_true: files('vga-pci.c'))
diff --git a/hw/display/ssd1306.c b/hw/display/ssd1306.c
new file mode 100644
index 0000000000..f7314efddb
--- /dev/null
+++ b/hw/display/ssd1306.c
@@ -0,0 +1,612 @@
+/*
+ * SSD1306 Dot Matrix Display Controller.
+ *
+ * The SSD1306 controller can support a variety of different displays up t=
o
+ * 128 x 64. The dimensions of the emulated display can be configured by t=
he
+ * 'width' and 'height' properties and has been tested using the most comm=
on
+ * displays dimensions of 128x64 and 128x32. A 'scaling' property has also
+ * been provided to perform integer pixel scaling of the output image to m=
ake
+ * it more viewable on pc displays. While the SSD1306 controller supports
+ * multiple physical interfaces this implementation only supports the I2C
+ * interface. Most of the commands relating to physical control, scrolling=
,
+ * multiplexing, and scanning direction are ignored.
+ *
+ * Copyright (C) 2024 Cambridge Consultants.
+ * Written by Ryan Mamone
+ *
+ * This code is licensed under the GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "hw/i2c/i2c.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "ui/console.h"
+#include "qom/object.h"
+
+/*#define DEBUG_SSD1306 1*/
+
+#ifdef DEBUG_SSD1306
+#define DPRINTF(fmt, ...) \
+do { error_printf("ssd1306: " fmt , ## __VA_ARGS__); } while (0)
+#define BADF(fmt, ...) \
+do { error_printf("ssd1306: error: " fmt , ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) do {} while (0)
+#define BADF(fmt, ...) \
+do { error_printf("ssd1306: error: " fmt , ## __VA_ARGS__); } while (0)
+#endif
+
+
+/* Max supported display dimensions of the SSD1306 controller */
+#define MAX_WIDTH 128
+#define MAX_HEIGHT 64
+/* Max supported color depth 32bit */
+#define MAX_BPP 32
+
+enum ssd1306_addr_mode {
+    ssd1306_ADDR_MODE_HORIZ =3D 0,
+    ssd1306_ADDR_MODE_VERT =3D 1,
+    ssd1306_ADDR_MODE_PAGE =3D 2,
+    ssd1306_ADDR_MODE_INVALID
+};
+
+enum ssd1306_mode {
+    ssd1306_IDLE,
+    ssd1306_DATA,
+    ssd1306_CMD,
+    ssd1306_CMD_DATA
+};
+
+#define TYPE_SSD1306 "ssd1306"
+OBJECT_DECLARE_SIMPLE_TYPE(ssd1306_state, SSD1306)
+
+struct ssd1306_state {
+    I2CSlave parent_obj;
+
+    QemuConsole *con;
+    /* Emulated display dimensions */
+    uint8_t width;
+    uint8_t height;
+    /* Integer scaling factor to enlarge pixels for better viewing on PC d=
isplays */
+    uint8_t scaling_factor;
+    uint8_t addr_mode;
+    uint8_t col;
+    uint8_t col_start;
+    uint8_t col_end;
+    uint8_t page;
+    uint8_t page_start;
+    uint8_t page_end;
+    int mirror;
+    int flash;
+    int enabled;
+    int inverse;
+    int redraw;
+    enum ssd1306_mode mode;
+    uint8_t cmd; /* Command ID byte */
+    uint8_t cmd_byte_num; /* Command data parameter number */
+    uint8_t mono_framebuffer[MAX_WIDTH * MAX_HEIGHT];
+    uint8_t color_framebuffer[MAX_WIDTH * MAX_HEIGHT * (MAX_BPP / 8)];
+};
+
+/* Handler for I2C data transferred from SSD1306 controller */
+static uint8_t ssd1306_recv(I2CSlave *i2c)
+{
+    BADF("Reads not implemented\n");
+    return 0xff;
+}
+
+/* Handler for I2C data transferred to SSD1306 controller */
+static int ssd1306_send(I2CSlave *i2c, uint8_t data)
+{
+    ssd1306_state *s =3D SSD1306(i2c);
+
+    switch (s->mode) {
+    case ssd1306_IDLE:
+        s->mode =3D ((data & 0x40) =3D=3D 0x40) ? ssd1306_DATA : ssd1306_C=
MD;
+        break;
+    case ssd1306_DATA:
+        /*
+         * Map incoming data to pixels at correct location in framebuffer.
+         * Notably every 8 pixels are mapped vertically along the page
+         * (ref Figure 10-2 in the datasheet).
+         */
+        for (int i =3D 0; i < 8; i++) {
+            /* Simulating a monochrome display so just set/clear all bits =
*/
+            s->mono_framebuffer[(((s->page * 8) + i) * s->width) + s->col]=
 =3D
+                ((data >> i) & 0x01) ? 0xff : 0x00;
+        }
+
+        /* GDDRAM pointers update differently dependent on the addressing =
mode */
+        switch (s->addr_mode) {
+        case ssd1306_ADDR_MODE_HORIZ: /* Horizontal Addressing Mode */
+            s->col++;
+            if (s->col > s->col_end) {
+                s->col =3D s->col_start;
+                s->page++;
+                if (s->page > s->page_end) {
+                    s->page =3D s->page_start;
+                }
+            }
+            break;
+        case ssd1306_ADDR_MODE_VERT: /* Vertical Addressing Mode (UNTESTED=
) */
+            s->page++;
+            if (s->page > s->page_end) {
+                s->page =3D s->page_start;
+                s->col++;
+                if (s->col > s->col_end) {
+                    s->col =3D s->col_start;
+                }
+            }
+            break;
+        case ssd1306_ADDR_MODE_PAGE: /* Page Addressing Mode (UNTESTED) */
+            if (s->col < s->col_end) {
+                s->col++;
+            }
+            break;
+        default:
+            break;
+        }
+        s->redraw =3D 1;
+        break;
+    case ssd1306_CMD:
+            s->cmd =3D data;
+            s->cmd_byte_num =3D 0;
+            /*
+             * Fallthrough so same code can handle commands with/without
+             * additional data bytes.
+             */
+            __attribute__ ((fallthrough));
+    case ssd1306_CMD_DATA:
+        switch (s->cmd) {
+        /*
+         * Fundamental Commands
+         */
+        /* Set Contrast Control */
+        case 0x81:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else {
+                data =3D data;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Entire display off (Use GDDRAM) */
+        case 0xA4:
+            s->flash =3D 0;
+            s->redraw =3D 1;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Entire display on (Ignore GDDRAM) */
+        case 0xA5:
+            s->flash =3D 1;
+            s->redraw =3D 1;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Inverse off */
+        case 0xA6:
+            s->inverse =3D 0;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Inverse on */
+        case 0xA7:
+            s->inverse =3D 1;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Display off */
+        case 0xAE:
+            s->enabled =3D 0;
+            s->redraw =3D 1;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Display on */
+        case 0xAF:
+            s->enabled =3D 1;
+            s->redraw =3D 1;
+            s->mode =3D ssd1306_CMD;
+            break;
+
+        /*
+         * Scrolling Commands
+         */
+        /* Continuous Horizontal Scroll Setup (6 data bytes) */
+        case 0x26 ... 0x27:
+            if (s->cmd_byte_num =3D=3D 0) {
+                DPRINTF("Continuous Horizontal Scroll Setup not implemente=
d\n");
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 6) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Continuous Vertical and Horizontal Scroll Setup (5 data bytes) =
*/
+        case 0x29 ... 0x2A:
+            if (s->cmd_byte_num =3D=3D 0) {
+                DPRINTF("Continuous Vertical and Horizontal Scroll Setup n=
ot "
+                        "implemented\n");
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 5) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Deactivate Scroll */
+        case 0x2E:
+            DPRINTF("Deactivate Scroll not implemented\n");
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Activate Scroll */
+        case 0x2F:
+            DPRINTF("Activate Scroll not implemented\n");
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Vertical Scroll (2 data bytes) */
+        case 0xA3:
+            if (s->cmd_byte_num =3D=3D 0) {
+                DPRINTF("Set Vertical Scroll not implemented\n");
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 2) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+
+        /*
+         * Address Setting Commands
+         */
+        /* Set Lower Column Start Address for Page Addressing Mode */
+        case 0x00 ... 0x0F:
+            s->col =3D (s->col & 0xf0) | (data & 0xf);
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Higher Column Start Address for Page Addressing Mode */
+        case 0x10 ... 0x1F:
+            s->col =3D (s->col & 0x0f) | (data & 0xf);
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Memory Addressing Mode (1 data byte) */
+        case 0x20:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->addr_mode =3D data & 0x3;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Column Address (2 data bytes) */
+        case 0x21:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->col_start =3D data & 0x7F;
+                s->col =3D s->col_start;
+            } else if (s->cmd_byte_num =3D=3D 2) {
+                s->col_end =3D data & 0x7F;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Page Address (2 data bytes) */
+        case 0x22:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->page_start =3D data & 0x07;
+                s->page =3D s->page_start;
+            } else if (s->cmd_byte_num =3D=3D 2) {
+                s->page_end =3D data & 0x07;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Page Start Address for Page Addressing Mode */
+        case 0xB0 ... 0xB7:
+            s->page =3D data & 0x07;
+            s->mode =3D ssd1306_CMD;
+            break;
+
+        /*
+         * Hardware Configuration Commands
+         */
+        /* Set Display Start Line */
+        case 0x40 ... 0x7F:
+            if (s->cmd !=3D 0x40) {
+                DPRINTF("Set Display Start Line (cmd 0x%02x) not implement=
ed\n", s->cmd);
+            }
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Segment Re-map */
+        case 0xA0 ... 0xA1:
+            if (s->cmd =3D=3D 0xA1) {
+                DPRINTF("Set Segment Re-map (cmd 0x%02x) not implemented\n=
", s->cmd);
+            }
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Multiplex Ratio (1 data byte) */
+        case 0xA8:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                if (data !=3D s->height - 1) {
+                    DPRINTF("Set Multiplex Ratio (0x%02x) not implemented\=
n", data);
+                }
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set COM Output Scan Direction */
+        case 0xC0 ... 0xC8:
+            if (s->cmd =3D=3D 0xC8) {
+                DPRINTF("Set COM Output Scan Dir (cmd 0x%02x) not implemen=
ted\n", s->cmd);
+            }
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Display Offset (1 data byte) */
+        case 0xD3:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                if (data !=3D 0x00) {
+                    DPRINTF("Set Display Offset (0x%02x) not implemented\n=
", data);
+                }
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set COM Pins Hardware Configuration (1 data byte) */
+        case 0xDA:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                if (data !=3D 0x12) {
+                    DPRINTF("Set COM Pins Hardware (0x%02x) not implemente=
d\n", data);
+                }
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+
+        /*
+         * Timing and Driving Scheme Setting Commands
+         */
+        /* Set Display Clock Divide Ratio/Oscillator Freq. (1 data byte) *=
/
+        case 0xD5:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Pre-charge Period (1 data byte) */
+        case 0xD9:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Vcomh Deselect Level (1 data byte) */
+        case 0xDB:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Charge Pump Setting (1 data byte) */
+        case 0x8D:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* NOP */
+        case 0xE3:
+            s->mode =3D ssd1306_CMD;
+            break;
+        default:
+            BADF("Unknown command: 0x%x\n", data);
+        }
+        s->cmd_byte_num++;
+        break;
+    }
+
+    return 0;
+}
+
+/* Handles I2C bus framing events */
+static int ssd1306_event(I2CSlave *i2c, enum i2c_event event)
+{
+    ssd1306_state *s =3D SSD1306(i2c);
+
+    switch (event) {
+    case I2C_FINISH:
+        s->mode =3D ssd1306_IDLE;
+        break;
+    case I2C_START_RECV:
+    case I2C_START_SEND:
+    case I2C_NACK:
+        /* Nothing to do.  */
+        break;
+    default:
+        return -1;
+    }
+
+    return 0;
+}
+
+/*
+ * Helper function to convert monochrome framebuffer to color framebuffer
+ * by padding out values to match dest color depth.
+ * 'src' framebuffer is expected to be 1 byte per pixel
+ */
+static void ssd1306_mono_to_color_fb(uint8_t *src, uint32_t size,
+                            uint8_t *dst, uint8_t bits_per_pixel)
+{
+    unsigned int idx =3D 0;
+    for (int i =3D 0; i < size; i++) {
+        for (int pad =3D 0; pad < (bits_per_pixel / 8); pad++) {
+            dst[idx++] =3D src[i];
+        }
+    }
+}
+
+/* Helper function to perform per pixel integer scaling */
+static void ssd1306_scale_fb(uint8_t *src, uint32_t src_width, uint32_t sr=
c_height,
+                          uint8_t src_bits_per_pixel, uint8_t *dst, uint8_=
t scale_factor)
+{
+    uint8_t bytes_per_pixel =3D src_bits_per_pixel / 8;
+    unsigned int idx =3D 0;
+
+    /* Scaling of 1 is just a direct copy */
+    if (scale_factor =3D=3D 1) {
+        memcpy(dst, src, src_width * src_height * bytes_per_pixel);
+    } else {
+        /*
+         * Copies each pixel (size=3Dsrc_bits_per_pixel) scale_factor time=
s and
+         * duplicate each of those lines scale_factor times.
+         */
+        for (int h =3D 0; h < src_height; h++) {
+            for (int hs =3D 0; hs < scale_factor; hs++) {
+                for (int w =3D 0; w < src_width; w++) {
+                    for (int ws =3D 0; ws < scale_factor; ws++) {
+                        memcpy(&dst[idx],
+                               &src[h * src_width * bytes_per_pixel +
+                                    w * bytes_per_pixel],
+                               bytes_per_pixel);
+                        idx +=3D bytes_per_pixel;
+                    }
+                }
+            }
+        }
+    }
+}
+
+/* Render the virtual framebuffer to the surface which will be displayed *=
/
+static void ssd1306_update_display(void *opaque)
+{
+    ssd1306_state *s =3D (ssd1306_state *)opaque;
+    DisplaySurface *surface =3D qemu_console_surface(s->con);
+
+    if (!s->redraw) {
+        return;
+    }
+
+    int bpp =3D surface_bits_per_pixel(surface);
+    /* This device only handles displays with whole byte color depths */
+    if (bpp && bpp % 8 !=3D 0) {
+        DPRINTF("Invalid color depth (bpp=3D%d). "
+                "Only whole byte color depths supported.\n", bpp);
+        return;
+    } else {
+        uint8_t *dest_surface =3D surface_data(surface);
+
+        if (s->flash) {
+            /* Turn on all pixels */
+            memset(dest_surface, 0xff,
+                   (s->width * s->scaling_factor) *
+                   (s->height * s->scaling_factor) *
+                   (bpp / 8));
+        } else if (!s->enabled) {
+            /* Clear the output */
+            memset(dest_surface, 0x00,
+                   (s->width * s->scaling_factor) *
+                   (s->height * s->scaling_factor) *
+                   (bpp / 8));
+        } else {
+            /*
+             * The following operations could have been done in a single p=
ass
+             * but that would likely have resulted in even more unreadable=
 code.
+             */
+            ssd1306_mono_to_color_fb(s->mono_framebuffer, s->width * s->he=
ight,
+                                     s->color_framebuffer, bpp);
+            ssd1306_scale_fb(s->color_framebuffer, s->width, s->height, bp=
p,
+                             dest_surface, s->scaling_factor);
+        }
+        s->redraw =3D 0;
+        dpy_gfx_update(s->con, 0, 0, s->width * s->scaling_factor,
+                       s->height * s->scaling_factor);
+    }
+}
+
+static void ssd1306_invalidate_display(void *opaque)
+{
+    ssd1306_state *s =3D (ssd1306_state *)opaque;
+    s->redraw =3D 1;
+}
+
+static const VMStateDescription vmstate_ssd1306 =3D {
+    .name =3D "ssd1306_oled",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT8(addr_mode, ssd1306_state),
+        VMSTATE_UINT8(col, ssd1306_state),
+        VMSTATE_UINT8(col_start, ssd1306_state),
+        VMSTATE_UINT8(col_end, ssd1306_state),
+        VMSTATE_UINT8(page, ssd1306_state),
+        VMSTATE_UINT8(page_start, ssd1306_state),
+        VMSTATE_UINT8(page_end, ssd1306_state),
+        VMSTATE_INT32(mirror, ssd1306_state),
+        VMSTATE_INT32(flash, ssd1306_state),
+        VMSTATE_INT32(enabled, ssd1306_state),
+        VMSTATE_INT32(inverse, ssd1306_state),
+        VMSTATE_INT32(redraw, ssd1306_state),
+        VMSTATE_UINT32(mode, ssd1306_state),
+        VMSTATE_UINT8(cmd, ssd1306_state),
+        VMSTATE_UINT8(cmd_byte_num, ssd1306_state),
+        VMSTATE_BUFFER(mono_framebuffer, ssd1306_state),
+        VMSTATE_BUFFER(color_framebuffer, ssd1306_state),
+        VMSTATE_I2C_SLAVE(parent_obj, ssd1306_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const GraphicHwOps ssd1306_ops =3D {
+    .invalidate  =3D ssd1306_invalidate_display,
+    .gfx_update  =3D ssd1306_update_display,
+};
+
+static void ssd1306_realize(DeviceState *dev, Error **errp)
+{
+    ssd1306_state *s =3D SSD1306(dev);
+
+    s->addr_mode =3D ssd1306_ADDR_MODE_PAGE;
+    s->col_start =3D 0;
+    s->col_start =3D 127;
+    s->page_start =3D 0;
+    s->page_end =3D 7;
+    memset(s->mono_framebuffer, 0, sizeof(s->mono_framebuffer));
+    s->con =3D graphic_console_init(dev, 0, &ssd1306_ops, s);
+    qemu_console_resize(s->con, s->width * s->scaling_factor,
+                        s->height * s->scaling_factor);
+}
+
+static Property ssd1306_properties[] =3D {
+    DEFINE_PROP_UINT8("width", ssd1306_state, width, 128),
+    DEFINE_PROP_UINT8("height", ssd1306_state, height, 32),
+    DEFINE_PROP_UINT8("scaling", ssd1306_state, scaling_factor, 4),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ssd1306_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+
+    dc->realize =3D ssd1306_realize;
+    k->event =3D ssd1306_event;
+    k->recv =3D ssd1306_recv;
+    k->send =3D ssd1306_send;
+    dc->vmsd =3D &vmstate_ssd1306;
+    device_class_set_props(dc, ssd1306_properties);
+}
+
+static const TypeInfo ssd1306_info =3D {
+    .name          =3D TYPE_SSD1306,
+    .parent        =3D TYPE_I2C_SLAVE,
+    .instance_size =3D sizeof(ssd1306_state),
+    .class_init    =3D ssd1306_class_init,
+};
+
+static void ssd1306_register_types(void)
+{
+    type_register_static(&ssd1306_info);
+}
+
+type_init(ssd1306_register_types)
--
2.34.1

This email, including attachments, contains confidential information belong=
ing to Cambridge Consultants. It is intended for the addressee only and may=
 only be copied or disclosed to others with permission. If you are not the =
intended recipient please delete the material from any computer. Emails are=
 subject to monitoring for legal and security purposes. If this email has b=
een sent as a personal message the company accepts no liability for the con=
tent.

--_000_MN2PR18MB3245B1A3994C378A3BED5C439E1A2MN2PR18MB3245namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:"\@Malgun Gothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">From 617b2d92085d03524dcf5c223568a4856cdff47f Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: Ryan Mamone &lt;ryan.mamone@cambridgeconsultan=
ts.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">Date: Tue, 30 Apr 2024 13:20:50 -0400<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH] hw/display: Add SSD1306 dot matrix =
display controller support<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Ryan Mamone &lt;ryan.mamone@cambridge=
consultants.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">hw/display/Kconfig&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&n=
bsp; 5 +<o:p></o:p></p>
<p class=3D"MsoNormal">hw/display/meson.build |&nbsp;&nbsp; 1 +<o:p></o:p><=
/p>
<p class=3D"MsoNormal">hw/display/ssd1306.c&nbsp;&nbsp; | 612 +++++++++++++=
++++++++++++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 618 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 hw/display/ssd1306.c<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/display/Kconfig b/hw/display/Kconfig=
<o:p></o:p></p>
<p class=3D"MsoNormal">index 234c7de027..58afe4048b 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/display/Kconfig<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/display/Kconfig<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -37,6 +37,11 @@ config SSD0303<o:p></o:p></p>
<p class=3D"MsoNormal">config SSD0323<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; bool<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+config SSD1306<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; bool<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; depends on I2C<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; default y if I2C_DEVICES<o:p></o=
:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">config VGA_PCI<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; bool<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; default y if PCI_DEVICES<o:=
p></o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/display/meson.build b/hw/display/mes=
on.build<o:p></o:p></p>
<p class=3D"MsoNormal">index 4751aab3ba..39f0724e02 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/display/meson.build<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/display/meson.build<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_PL110'=
, if_true: files('pl110.c'))<o:p></o:p></p>
<p class=3D"MsoNormal">system_ss.add(when: 'CONFIG_SII9022', if_true: files=
('sii9022.c'))<o:p></o:p></p>
<p class=3D"MsoNormal">system_ss.add(when: 'CONFIG_SSD0303', if_true: files=
('ssd0303.c'))<o:p></o:p></p>
<p class=3D"MsoNormal">system_ss.add(when: 'CONFIG_SSD0323', if_true: files=
('ssd0323.c'))<o:p></o:p></p>
<p class=3D"MsoNormal">+system_ss.add(when: 'CONFIG_SSD1306', if_true: file=
s('ssd1306.c'))<o:p></o:p></p>
<p class=3D"MsoNormal">system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files=
('xenfb.c'))<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;system_ss.add(when: 'CONFIG_VGA_PCI', if_true:=
 files('vga-pci.c'))<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/display/ssd1306.c b/hw/display/ssd13=
06.c<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 0000000000..f7314efddb<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/display/ssd1306.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -0,0 +1,612 @@<o:p></o:p></p>
<p class=3D"MsoNormal">+/*<o:p></o:p></p>
<p class=3D"MsoNormal">+ * SSD1306 Dot Matrix Display Controller.<o:p></o:p=
></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * The SSD1306 controller can support a variety of =
different displays up to<o:p></o:p></p>
<p class=3D"MsoNormal">+ * 128 x 64. The dimensions of the emulated display=
 can be configured by the<o:p></o:p></p>
<p class=3D"MsoNormal">+ * 'width' and 'height' properties and has been tes=
ted using the most common<o:p></o:p></p>
<p class=3D"MsoNormal">+ * displays dimensions of 128x64 and 128x32. A 'sca=
ling' property has also<o:p></o:p></p>
<p class=3D"MsoNormal">+ * been provided to perform integer pixel scaling o=
f the output image to make<o:p></o:p></p>
<p class=3D"MsoNormal">+ * it more viewable on pc displays. While the SSD13=
06 controller supports<o:p></o:p></p>
<p class=3D"MsoNormal">+ * multiple physical interfaces this implementation=
 only supports the I2C<o:p></o:p></p>
<p class=3D"MsoNormal">+ * interface. Most of the commands relating to phys=
ical control, scrolling,<o:p></o:p></p>
<p class=3D"MsoNormal">+ * multiplexing, and scanning direction are ignored=
.<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Copyright (C) 2024 Cambridge Consultants.<o:p></=
o:p></p>
<p class=3D"MsoNormal">+ * Written by Ryan Mamone<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * This code is licensed under the GPL.<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+ */<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;qemu/osdep.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;qemu/error-report.h&quot;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+#include &quot;hw/i2c/i2c.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;hw/qdev-properties.h&quot;<o:p></o:p=
></p>
<p class=3D"MsoNormal">+#include &quot;migration/vmstate.h&quot;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+#include &quot;qemu/module.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;ui/console.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;qom/object.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/*#define DEBUG_SSD1306 1*/<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#ifdef DEBUG_SSD1306<o:p></o:p></p>
<p class=3D"MsoNormal">+#define DPRINTF(fmt, ...) \<o:p></o:p></p>
<p class=3D"MsoNormal">+do { error_printf(&quot;ssd1306: &quot; fmt , ## __=
VA_ARGS__); } while (0)<o:p></o:p></p>
<p class=3D"MsoNormal">+#define BADF(fmt, ...) \<o:p></o:p></p>
<p class=3D"MsoNormal">+do { error_printf(&quot;ssd1306: error: &quot; fmt =
, ## __VA_ARGS__); } while (0)<o:p></o:p></p>
<p class=3D"MsoNormal">+#else<o:p></o:p></p>
<p class=3D"MsoNormal">+#define DPRINTF(fmt, ...) do {} while (0)<o:p></o:p=
></p>
<p class=3D"MsoNormal">+#define BADF(fmt, ...) \<o:p></o:p></p>
<p class=3D"MsoNormal">+do { error_printf(&quot;ssd1306: error: &quot; fmt =
, ## __VA_ARGS__); } while (0)<o:p></o:p></p>
<p class=3D"MsoNormal">+#endif<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/* Max supported display dimensions of the SSD1306 =
controller */<o:p></o:p></p>
<p class=3D"MsoNormal">+#define MAX_WIDTH 128<o:p></o:p></p>
<p class=3D"MsoNormal">+#define MAX_HEIGHT 64<o:p></o:p></p>
<p class=3D"MsoNormal">+/* Max supported color depth 32bit */<o:p></o:p></p=
>
<p class=3D"MsoNormal">+#define MAX_BPP 32<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+enum ssd1306_addr_mode {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_ADDR_MODE_HORIZ =3D 0,<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_ADDR_MODE_VERT =3D 1,<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_ADDR_MODE_PAGE =3D 2,<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_ADDR_MODE_INVALID<o:p></=
o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+enum ssd1306_mode {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_IDLE,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_DATA,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_CMD,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_CMD_DATA<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#define TYPE_SSD1306 &quot;ssd1306&quot;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+OBJECT_DECLARE_SIMPLE_TYPE(ssd1306_state, SSD1306)<=
o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+struct ssd1306_state {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; I2CSlave parent_obj;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; QemuConsole *con;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; /* Emulated display dimensions *=
/<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t width;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t height;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; /* Integer scaling factor to enl=
arge pixels for better viewing on PC displays */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t scaling_factor;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t addr_mode;<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t col;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t col_start;<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t col_end;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t page;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t page_start;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t page_end;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; int mirror;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; int flash;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; int enabled;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; int inverse;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; int redraw;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; enum ssd1306_mode mode;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t cmd; /* Command ID byte =
*/<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t cmd_byte_num; /* Command=
 data parameter number */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t mono_framebuffer[MAX_WID=
TH * MAX_HEIGHT];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t color_framebuffer[MAX_WI=
DTH * MAX_HEIGHT * (MAX_BPP / 8)];<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/* Handler for I2C data transferred from SSD1306 co=
ntroller */<o:p></o:p></p>
<p class=3D"MsoNormal">+static uint8_t ssd1306_recv(I2CSlave *i2c)<o:p></o:=
p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; BADF(&quot;Reads not implemented=
\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; return 0xff;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/* Handler for I2C data transferred to SSD1306 cont=
roller */<o:p></o:p></p>
<p class=3D"MsoNormal">+static int ssd1306_send(I2CSlave *i2c, uint8_t data=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_state *s =3D SSD1306(i2c=
);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; switch (s-&gt;mode) {<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; case ssd1306_IDLE:<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mo=
de =3D ((data &amp; 0x40) =3D=3D 0x40) ? ssd1306_DATA : ssd1306_CMD;<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; case ssd1306_DATA:<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Map incoming data to pixels at correct location in framebuffer.<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Notably every 8 pixels are mapped vertically along the page<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
(ref Figure 10-2 in the datasheet).<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int=
 i =3D 0; i &lt; 8; i++) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Simulating a monochrome display so just set/clear all bi=
ts */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mono_framebuffer[(((s-&gt;page * 8) + i) * s-&gt;widt=
h) + s-&gt;col] =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((data &gt;&gt; i) &amp; 0x01) ? 0x=
ff : 0x00;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GDDRA=
M pointers update differently dependent on the addressing mode */<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (=
s-&gt;addr_mode) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ssd=
1306_ADDR_MODE_HORIZ: /* Horizontal Addressing Mode */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;col++;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;col &gt; s-&gt;col_end) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;col =3D s-&gt;col_start;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;page++;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;page &gt; s-&gt;page_end)=
 {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;page =
=3D s-&gt;page_start;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ssd=
1306_ADDR_MODE_VERT: /* Vertical Addressing Mode (UNTESTED) */<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;page++;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;page &gt; s-&gt;page_end) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;page =3D s-&gt;page_start;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;col++;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;col &gt; s-&gt;col_end) {=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;col =
=3D s-&gt;col_start;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ssd=
1306_ADDR_MODE_PAGE: /* Page Addressing Mode (UNTESTED) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;col &lt; s-&gt;col_end) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;col++;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;re=
draw =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; case ssd1306_CMD:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;cmd =3D data;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;cmd_byte_num =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * Fallthrough so same code can handle commands with/w=
ithout<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * additional data bytes.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; __attribute__ ((fallthrough));<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp; &nbsp;case ssd1306_CMD_DATA:<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (=
s-&gt;cmd) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Fundamental Commands<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set C=
ontrast Control */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x8=
1:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;} else {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D data;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Entir=
e display off (Use GDDRAM) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
4:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;flash =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;redraw =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Entir=
e display on (Ignore GDDRAM) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
5:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;flash =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;redraw =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Inver=
se off */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
6:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;inverse =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Inver=
se on */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
7:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;inverse =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Displ=
ay off */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
E:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;enabled =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;redraw =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Displ=
ay on */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
F:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;enabled =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;redraw =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Scrolling Commands<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Conti=
nuous Horizontal Scroll Setup (6 data bytes) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x2=
6 ... 0x27:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&quot;Continuous Horizontal=
 Scroll Setup not implemented\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 6) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Conti=
nuous Vertical and Horizontal Scroll Setup (5 data bytes) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x2=
9 ... 0x2A:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&quot;Continuous Vertical a=
nd Horizontal Scroll Setup not &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;implemented\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 5) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Deact=
ivate Scroll */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x2=
E:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DPRINTF(&quot;Deactivate Scroll not implemented\n&quot;);<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Activ=
ate Scroll */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x2=
F:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DPRINTF(&quot;Activate Scroll not implemented\n&quot;);<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set V=
ertical Scroll (2 data bytes) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
3:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&quot;Set Vertical Scroll n=
ot implemented\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 2) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Address Setting Commands<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set L=
ower Column Start Address for Page Addressing Mode */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x0=
0 ... 0x0F:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;col =3D (s-&gt;col &amp; 0xf0) | (data &amp; 0xf);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set H=
igher Column Start Address for Page Addressing Mode */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x1=
0 ... 0x1F:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;col =3D (s-&gt;col &amp; 0x0f) | (data &amp; 0xf);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set M=
emory Addressing Mode (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x2=
0:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;addr_mode =3D data &amp; 0x3;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set C=
olumn Address (2 data bytes) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x2=
1:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;col_start =3D data &amp; 0x7F=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;col =3D s-&gt;col_start;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 2) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;col_end =3D data &amp; 0x7F;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set P=
age Address (2 data bytes) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x2=
2:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;page_start =3D data &amp; 0x0=
7;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;page =3D s-&gt;page_start;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 2) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;page_end =3D data &amp; 0x07;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set P=
age Start Address for Page Addressing Mode */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xB=
0 ... 0xB7:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;page =3D data &amp; 0x07;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Hardware Configuration Commands<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set D=
isplay Start Line */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x4=
0 ... 0x7F:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd !=3D 0x40) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&quot;Set Display Start Lin=
e (cmd 0x%02x) not implemented\n&quot;, s-&gt;cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set S=
egment Re-map */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
0 ... 0xA1:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd =3D=3D 0xA1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&quot;Set Segment Re-map (c=
md 0x%02x) not implemented\n&quot;, s-&gt;cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set M=
ultiplex Ratio (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xA=
8:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data !=3D s-&gt;height - 1) {<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&qu=
ot;Set Multiplex Ratio (0x%02x) not implemented\n&quot;, data);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set C=
OM Output Scan Direction */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xC=
0 ... 0xC8:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd =3D=3D 0xC8) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&quot;Set COM Output Scan D=
ir (cmd 0x%02x) not implemented\n&quot;, s-&gt;cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set D=
isplay Offset (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xD=
3:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data !=3D 0x00) {<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&qu=
ot;Set Display Offset (0x%02x) not implemented\n&quot;, data);<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set C=
OM Pins Hardware Configuration (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xD=
A:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data !=3D 0x12) {<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(&qu=
ot;Set COM Pins Hardware (0x%02x) not implemented\n&quot;, data);<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Timing and Driving Scheme Setting Commands<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set D=
isplay Clock Divide Ratio/Oscillator Freq. (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xD=
5:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set P=
re-charge Period (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xD=
9:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set V=
comh Deselect Level (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xD=
B:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Charg=
e Pump Setting (1 data byte) */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x8=
D:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (s-&gt;cmd_byte_num =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD_DATA;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else if (s-&gt;cmd_byte_num =3D=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NOP *=
/<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xE=
3:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;mode =3D ssd1306_CMD;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; BADF(&quot;Unknown command: 0x%x\n&quot;, data);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;cm=
d_byte_num++;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/* Handles I2C bus framing events */<o:p></o:p></p>
<p class=3D"MsoNormal">+static int ssd1306_event(I2CSlave *i2c, enum i2c_ev=
ent event)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_state *s =3D SSD1306(i2c=
);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; switch (event) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; case I2C_FINISH:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;mo=
de =3D ssd1306_IDLE;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; case I2C_START_RECV:<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; case I2C_START_SEND:<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; case I2C_NACK:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Nothi=
ng to do.&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -=
1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/*<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Helper function to convert monochrome framebuffe=
r to color framebuffer<o:p></o:p></p>
<p class=3D"MsoNormal">+ * by padding out values to match dest color depth.=
<o:p></o:p></p>
<p class=3D"MsoNormal">+ * 'src' framebuffer is expected to be 1 byte per p=
ixel<o:p></o:p></p>
<p class=3D"MsoNormal">+ */<o:p></o:p></p>
<p class=3D"MsoNormal">+static void ssd1306_mono_to_color_fb(uint8_t *src, =
uint32_t size,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *dst, uint8_t bits_per_pixel)<=
o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; unsigned int idx =3D 0;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; size; i=
++) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int=
 pad =3D 0; pad &lt; (bits_per_pixel / 8); pad++) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dst[idx++] =3D src[i];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/* Helper function to perform per pixel integer sca=
ling */<o:p></o:p></p>
<p class=3D"MsoNormal">+static void ssd1306_scale_fb(uint8_t *src, uint32_t=
 src_width, uint32_t src_height,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t src_bits_per_pixel, uint8_t *dst, uint8_t =
scale_factor)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint8_t bytes_per_pixel =3D src_=
bits_per_pixel / 8;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; unsigned int idx =3D 0;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; /* Scaling of 1 is just a direct=
 copy */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; if (scale_factor =3D=3D 1) {<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(d=
st, src, src_width * src_height * bytes_per_pixel);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
Copies each pixel (size=3Dsrc_bits_per_pixel) scale_factor times and<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
duplicate each of those lines scale_factor times.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int=
 h =3D 0; h &lt; src_height; h++) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; for (int hs =3D 0; hs &lt; scale_factor; hs++) {<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;for (int w =3D 0; w &lt; src_width;=
 w++) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int ws=
 =3D 0; ws &lt; scale_factor; ws++) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; memcpy(&amp;dst[idx],<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;src[h * src_wid=
th * bytes_per_pixel +<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; w * bytes_per_pixel],<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_per_pixel);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; idx +=3D bytes_per_pixel;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+/* Render the virtual framebuffer to the surface wh=
ich will be displayed */<o:p></o:p></p>
<p class=3D"MsoNormal">+static void ssd1306_update_display(void *opaque)<o:=
p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_state *s =3D (ssd1306_st=
ate *)opaque;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; DisplaySurface *surface =3D qemu=
_console_surface(s-&gt;con);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; if (!s-&gt;redraw) {<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; int bpp =3D surface_bits_per_pix=
el(surface);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; /* This device only handles disp=
lays with whole byte color depths */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; if (bpp &amp;&amp; bpp % 8 !=3D =
0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPRINTF(=
&quot;Invalid color depth (bpp=3D%d). &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Only whole byte color depths =
supported.\n&quot;, bpp);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t =
*dest_surface =3D surface_data(surface);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&g=
t;flash) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Turn on all pixels */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(dest_surface, 0xff,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s-&gt;width * s-=
&gt;scaling_factor) *<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s-&gt;height * s=
-&gt;scaling_factor) *<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bpp / 8));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else i=
f (!s-&gt;enabled) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;/* Clear the output */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(dest_surface, 0x00,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s-&gt;width * s-=
&gt;scaling_factor) *<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s-&gt;height * s=
-&gt;scaling_factor) *<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bpp / 8));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp;* The following operations could have been done in a =
single pass<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * but that would likely have resulted in even more un=
readable code.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ssd1306_mono_to_color_fb(s-&gt;mono_framebuffer, s-&gt;widt=
h * s-&gt;height,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;s-&gt;color_framebuffer, bpp);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ssd1306_scale_fb(s-&gt;color_framebuffer, s-&gt;width, s-&g=
t;height, bpp,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dest_surface, s-&gt;scaling_fact=
or);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;re=
draw =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpy_gfx_=
update(s-&gt;con, 0, 0, s-&gt;width * s-&gt;scaling_factor,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; s-&gt;height * s-&gt;scaling_factor);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void ssd1306_invalidate_display(void *opaque=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_state *s =3D (ssd1306_st=
ate *)opaque;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; s-&gt;redraw =3D 1;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static const VMStateDescription vmstate_ssd1306 =3D=
 {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .name =3D &quot;ssd1306_oled&quo=
t;,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .version_id =3D 1,<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .minimum_version_id =3D 1,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .fields =3D (const VMStateField[=
]) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;VMSTATE_=
UINT8(addr_mode, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(col, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(col_start, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(col_end, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(page, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(page_start, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(page_end, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
INT32(mirror, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
INT32(flash, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
INT32(enabled, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
INT32(inverse, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
INT32(redraw, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT32(mode, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(cmd, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
UINT8(cmd_byte_num, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
BUFFER(mono_framebuffer, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
BUFFER(color_framebuffer, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
I2C_SLAVE(parent_obj, ssd1306_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_=
END_OF_LIST()<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static const GraphicHwOps ssd1306_ops =3D {<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .invalidate&nbsp; =3D ssd1306_in=
validate_display,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .gfx_update&nbsp; =3D ssd1306_up=
date_display,<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void ssd1306_realize(DeviceState *dev, Error=
 **errp)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; ssd1306_state *s =3D SSD1306(dev=
);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; s-&gt;addr_mode =3D ssd1306_ADDR=
_MODE_PAGE;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; s-&gt;col_start =3D 0;<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; s-&gt;col_start =3D 127;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; s-&gt;page_start =3D 0;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; s-&gt;page_end =3D 7;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; memset(s-&gt;mono_framebuffer, 0=
, sizeof(s-&gt;mono_framebuffer));<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; s-&gt;con =3D graphic_console_in=
it(dev, 0, &amp;ssd1306_ops, s);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; qemu_console_resize(s-&gt;con, s=
-&gt;width * s-&gt;scaling_factor,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; s-&gt;height * s-&gt;scaling_factor);<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static Property ssd1306_properties[] =3D {<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT8(&quot;width&qu=
ot;, ssd1306_state, width, 128),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT8(&quot;height&q=
uot;, ssd1306_state, height, 32),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT8(&quot;scaling&=
quot;, ssd1306_state, scaling_factor, 4),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; DEFINE_PROP_END_OF_LIST(),<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void ssd1306_class_init(ObjectClass *klass, =
void *data)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; DeviceClass *dc =3D DEVICE_CLASS=
(klass);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; I2CSlaveClass *k =3D I2C_SLAVE_C=
LASS(klass);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; dc-&gt;realize =3D ssd1306_reali=
ze;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; k-&gt;event =3D ssd1306_event;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; k-&gt;recv =3D ssd1306_recv;<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; k-&gt;send =3D ssd1306_send;<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; dc-&gt;vmsd =3D &amp;vmstate_ssd=
1306;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; device_class_set_props(dc, ssd13=
06_properties);<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static const TypeInfo ssd1306_info =3D {<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D TYPE_SSD1306,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D TYPE_I2C_SLAVE,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(ssd130=
6_state),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; =
=3D ssd1306_class_init,<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void ssd1306_register_types(void)<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; type_register_static(&amp;ssd130=
6_info);<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+type_init(ssd1306_register_types)<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.34.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
This email, including attachments, contains confidential information belong=
ing to Cambridge Consultants. It is intended for the addressee only and may=
 only be copied or disclosed to others with permission. If you are not the =
intended recipient please delete
 the material from any computer. Emails are subject to monitoring for legal=
 and security purposes. If this email has been sent as a personal message t=
he company accepts no liability for the content.
</body>
</html>

--_000_MN2PR18MB3245B1A3994C378A3BED5C439E1A2MN2PR18MB3245namp_--

