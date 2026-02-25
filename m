Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4BF357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0y-000499-Ko; Wed, 25 Feb 2026 05:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0b-000402-2Q; Wed, 25 Feb 2026 05:20:45 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0Z-0002v7-IR; Wed, 25 Feb 2026 05:20:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViWSON1Tz7AX10rrQJm63ffUU5i6HGUi8tkWtjLhWxSC4dZ+h9fRMUmkiuNHP9iRIE4E90fvlliM0YbvElhHtQ1Iwvt29CL7Z06siOGiDWGyyCq9m9jkX8lsXKHBNFuTwNWgJMx2NgEyxtOudskDD3EqAsoXvi1SeC1WT2K3qXCNQetE/LIgmv65LI8wpod1X2rJSrmw4QSPT51jUpA0kj9hddCGanIWa/4hkNzlr2um8ZwkPq2DQ8xkG+9PZe2/jxnixgSp14JFQl7R/08zr6NZrvx4VP56IucYmg4SZs7tzhp8RtSI1kKpLYeD3E3vHgkCKTNuxE2qXU60YSwiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnygywpNtxwy/qpmT+A96vOTmU31bBLEX7D0YfYupXc=;
 b=kV0zjxAHXHZ2+5lZDI5CB062MPFpXkcIUkHOIp0wNH2aSymH+v39ACoFRnu6t4nFOi+qbrHl9lCOf45JrWO5IRjLvhFKNMHZJQvRg2f31fwSeBQ6H/J4HgTvVtBZr+Fz/dcoMOd3SUpXrYeTwH/jTdeqC5nmL7RfKwNzRhd8mvoSw3CGzaQQti8eTFfs6ed14V2D+/fCMNuaAhkSOM8PNUUxQez4vqjnw28QvNS9d5ed0pVWJLsnIzoiEh8/OGH9pJxoF1KUg/Cg6cBx7UzklFp+Vkl68TaLbRjjKx3EMOBaDLTK2r21nGgj9woymWK55+m/LPX99+iOn0MfENXsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnygywpNtxwy/qpmT+A96vOTmU31bBLEX7D0YfYupXc=;
 b=LO4U18MLA8RjJTWurnhYcVs1mwX5MS2TTOHN7bYH2KIWrWvuPbqbE+JoKzTJoMeD/wBLQqjEBLkN1qMi4MrrLaMmTS2/BkYWEr1z2GIClCudNjOF9ZxUJM7eHimMcv+fD4tOt3h3+Y7eklNN3dYjUW7jG+TyqMSbpYo18q5ZxxyoLSX8z72qp7V7ixshd2sCtv1T3BeiPZ4NnTJkL1llea1H92vfEpF+1TQ10+VTrIK/4ua/pASs4rcA7FVH3rpWILTqCd23omm1A4EOyiPv2k1HfL5Ng/jtXMNIHCvuJGyRbvFU9wxPhi/YZOVF9H4buxsU3eOVZIQ2TNMCEmQ5ew==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:28 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 03/16] config/devices: Add BE riscv configs
Thread-Topic: [PATCH v2 03/16] config/devices: Add BE riscv configs
Thread-Index: AQHcpkBbaJjoVQ8m+EmyGR3wfSmZmQ==
Date: Wed, 25 Feb 2026 10:20:25 +0000
Message-ID: <20260225102016.200654-4-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA1PR09MB7406:EE_
x-ms-office365-filtering-correlation-id: 8d713b97-ab34-40e5-6fc9-08de74577f93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: bi8VRIjOnXbVdFhY//phg+lRBdEp+arG8rc71Fh/5jBUcgO9lCTq5qfb+LQE6n7c6O1lcsYAWY8LG3ZAnuO9efPHs6dFHgWbaOwDwZe03JoULNwsKNTIwNuH+7l9WkzcnHMUw5HoEb6ruBdoHytGOP2xiSTetZtKudyGNSYaWVvulbGInixinCYfQVrVUjKyEeNO2eKSrlZ+18RKJLCOLFxyZJPFrmoBQ3haBxUh7UoFoSgoYYyxYd6LFb73caYBorCQk7Amn/SKGigXsIhMdxtSsNTyeIzQF/EIYjkBEUcc64uFJdoqBt0IkuDudOSTBSP7j4ospQ+a7Ew/LTftCdCB8mymEDkH4G9iU0R/J/aWBq8bcGbxO1Adadgm7blGb5H801ITPvxjRW76DXlMXX4jtz40XGBG8xbyZDL21g8E3LopNAt//+SbC6zWYLtJ6e+5Vu4DElqB/UTPwdV21Kv4MAu7AOwTAfts1ZJ2XEXRMF8nr+emr+vTLc3u8w3IdA6ZbvyMwIkXTkVbVMQSw2MrVcRLzW5a3tJcCH3tHb9pEDeOT9T+3fXedc7xg352Djt0F+i+yrmnj6FD4Pagu6mc5d7wlpD4BPGpZOtztjxNDICqo1G+DOOB8hTa5JaAb69ULZgG4WcJbCGZ0jqeil/GRia058aoWKzYAe5nsDKOtscdZ27Rix4UpPFOdtMDrbijlGPYW66N4yJgohcTparxOZMhkA5histT6DGu/MqJo17iGdmDHUXP1rEOzLO5WQM6mkMD9AJOECNhzSlHQ0XNBT96dYlctRgvuwRYRXI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ut4pNto8xoGDONNnmXX//CeixW22HUssbU1SiRhawqcxAofr8LlzZPiQ3S?=
 =?iso-8859-1?Q?riLh62NwQeSEn+0XJYzfyR5GMtpIPhSpF2nmDCaK5jBHBp4FOkSGTPg/uG?=
 =?iso-8859-1?Q?7TsF2u5xeF7JmheFzWSvNRjQQ2SD2sn8AvFOm96L8qMns0ZTaoc9Utpjth?=
 =?iso-8859-1?Q?OEXAyy1Y5nzOVIo+m5BNAw9Yais5rap65TS0agscNIKuQB3U5JSOOwq2dW?=
 =?iso-8859-1?Q?1UkSthecco8CzCDgGiO5FLoWj7LqwTTV7slNY7E4G0AqYMj5CHB1GF806t?=
 =?iso-8859-1?Q?H69VxUk4JI21FE4+2ocGjjh8I/13nXFnW+bkAPIEA+3l1gpxqE9CbCTQQ6?=
 =?iso-8859-1?Q?EUPJN44cGF1Z62FT8HRf3s+yhgEu42mZhuM2q8QhbSNYVr701VUpJApKCn?=
 =?iso-8859-1?Q?g7y+Az3u9VxpFZrX2/WtL+guvk3RVwRmYuERWV3/cIs+cAjc7wDBSyxxSt?=
 =?iso-8859-1?Q?faaOT/aA5fLM4vUpEC72JoRwgo/6Ss+3CF8EUilTK7umZtmf3eKYQmHcJo?=
 =?iso-8859-1?Q?bS3+EpNRLGK3m6WpLl/q2bScef+L8URWxwXb77CvQdKNzwvORRIrK8AG+a?=
 =?iso-8859-1?Q?KVr9pQZAR7TIctTJUoncRF090fLxyFskvWag1qiMY/AsyZ+CDlWVOBGZGY?=
 =?iso-8859-1?Q?l8OwqSPcbo4+aPSETdQ/dZpZ2QehHVIWfyTLjyoIsa46HcemXN+iy47vwi?=
 =?iso-8859-1?Q?MrTyFHt+vAnyM88OZD8Qa0MbC6E+dUbNUi14vxqA5YpYj/lqXwaRcTpwDc?=
 =?iso-8859-1?Q?U+7Rh7Fy9s0hNY6nh8AbwHiIPa7IhzBpfvSOs0x/0Ji80We8DKzkhGubvh?=
 =?iso-8859-1?Q?uC5lvVbJOY5nQTb++RZqFcxdn+BwoSBe6Oi1Iqotl2M1p26Ue7GxiEDUER?=
 =?iso-8859-1?Q?UZhtfHYLuwBmCYWdBUV24PGbHPwabWpaf48DuFZ0IMpQGQYeI5Jf6IrQ9w?=
 =?iso-8859-1?Q?CqvTb/7mT0wNvyz8jl65YmySk0Gwd34A7qz51szd8bD7b4AuYKQDCI4QtW?=
 =?iso-8859-1?Q?eYMq2PA4hYFQsNEFWIKxfe59Rb6ZHHUvb3z4FNRcuOqJXM0nrLtiEO1N8n?=
 =?iso-8859-1?Q?Me2XNXf+Qc9UAB8z74wTTBMj+fd+uiF72Ab7U3PHqxefOE6mCopgbtdNEP?=
 =?iso-8859-1?Q?rVqsDdfep0FRQw7wg+HszTgPhrCCd8ZtuRneylexf4YaHp6z6SmDw/hjiT?=
 =?iso-8859-1?Q?6cZ7oZa41n3JEvkF0YnLae3rIdqf8hoIWzESLGoEp8AiQgrucdXOuILAot?=
 =?iso-8859-1?Q?5YaTWO5dw/SF81AD2Jf16hDOovxdIMK81C5feGYIMsMnRJv/4u668ddHXO?=
 =?iso-8859-1?Q?u2Rm2aLv7ZBUwBS4FB1+TXsTega9UJ4W3ZxyQw9B5idFp7MUg0kZv40wW0?=
 =?iso-8859-1?Q?PRnVGtyD4p2k5u8I3v8WLNmToQ1f7xeUSLBz//7ky1Ec10Q/CFn3QQ+avD?=
 =?iso-8859-1?Q?y6djm9UZDrE43x8Lf8ohGJTgH+BRpNOKst4mbpfScDGpQ8qu/pr7Gi3qin?=
 =?iso-8859-1?Q?vhXwRwDeI17d4cQ0hEkNvk0IClLmuvJEOG/9MuRx9bsSZ4O2ErLHAaktLL?=
 =?iso-8859-1?Q?318tKy186hg83bgM/k88grEINm4f5yqtIYnt9t8fMeBKNYGFLjA+5Z+MPT?=
 =?iso-8859-1?Q?OkHJkgKDbTsY0S9bDiaSJZ5rj0ECB9wof/S83/pLxm83uhXL8Fo9WKzHoq?=
 =?iso-8859-1?Q?woVoW57TkxdrFr4F0kbX2qSUlFWCOaJ63bT+7TngiSujcmaJ8Hor3/2wMs?=
 =?iso-8859-1?Q?GRbCUu7NX5oSn6ryX0ni1K6/5/ZmAS1bxd1cxPIWL4Re7aXfIlzv1U8ujc?=
 =?iso-8859-1?Q?VmybATqHfJ/njGltAJxerNUJcysH2DcLR6TqMgvszpAdKLvhY6C+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d713b97-ab34-40e5-6fc9-08de74577f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:25.9887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IywOAWTP3SNAkozlXnvbZQT4FgH3MZ8FP/f5eANZHIN/XJEJOCYgspBCR2iropfNg7QaGWTzUZ6+M+Nkyx7EiLTlRRnt7t8p0J5HNPM6ezI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add new configs for BE RISCV softmmu targets.
---
 configs/devices/riscv32be-softmmu/default.mak | 15 +++++++++++++++
 configs/devices/riscv64be-softmmu/default.mak | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 configs/devices/riscv32be-softmmu/default.mak
 create mode 100644 configs/devices/riscv64be-softmmu/default.mak

diff --git a/configs/devices/riscv32be-softmmu/default.mak b/configs/device=
s/riscv32be-softmmu/default.mak
new file mode 100644
index 0000000000..d847bd5692
--- /dev/null
+++ b/configs/devices/riscv32be-softmmu/default.mak
@@ -0,0 +1,15 @@
+# Default configuration for riscv32-softmmu
+
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=3Dn
+CONFIG_SEMIHOSTING=3Dy
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
+
+# Boards:
+#
+CONFIG_SPIKE=3Dy
+CONFIG_SIFIVE_E=3Dy
+CONFIG_SIFIVE_U=3Dy
+CONFIG_RISCV_VIRT=3Dy
+CONFIG_OPENTITAN=3Dy
diff --git a/configs/devices/riscv64be-softmmu/default.mak b/configs/device=
s/riscv64be-softmmu/default.mak
new file mode 100644
index 0000000000..bc69301fa4
--- /dev/null
+++ b/configs/devices/riscv64be-softmmu/default.mak
@@ -0,0 +1,16 @@
+# Default configuration for riscv64-softmmu
+
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=3Dn
+CONFIG_SEMIHOSTING=3Dy
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
+
+# Boards:
+#
+CONFIG_SPIKE=3Dy
+CONFIG_SIFIVE_E=3Dy
+CONFIG_SIFIVE_U=3Dy
+CONFIG_RISCV_VIRT=3Dy
+CONFIG_MICROCHIP_PFSOC=3Dy
+CONFIG_SHAKTI_C=3Dy
--=20
2.34.1

