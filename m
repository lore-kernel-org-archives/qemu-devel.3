Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEF3CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN97-00071V-1W; Wed, 07 Oct 2026 04:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEI67-0001RK-0c; Tue, 06 Oct 2026 23:13:42 -0400
Received: from mail-westeuropeazon11021128.outbound.protection.outlook.com
 ([52.101.70.128] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEI5c-00015M-VJ; Tue, 06 Oct 2026 23:13:28 -0400
Received: from AS8PR02MB9672.eurprd02.prod.outlook.com (2603:10a6:20b:5ec::8)
 by GV1PR02MB10809.eurprd02.prod.outlook.com (2603:10a6:150:164::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 00:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBhRnEu5rnHQbtLg1sZYer+MBM82ShYgy4vBM9P826/PnWcTGDhJ9IzmdDuw/5Hjd6bRGMsQNkfpBEpjXjV9fXwuoIEDFS/5oS0bWPgSq4PU7ckNZvGJmCK6yy2GTYVZjECsXOOHbOg5IbiBANBLNylgRLHBvANhhcWEd9iMWq3u1zKiC1LRSv/REwDosJxqfWdhAnCP+u58NWz4G34DPFs7aeVl9oxNPAouIP5jrN2ZDSoxGcWeAxqoonGV/3ZzOH5enlfQZdsFE4mkN2CTA/y16Mi+KiEewCLKb4IAiuyDaUt+4Khe+JIFBBej7byYOcVPEEoNex8xMzxUt0lAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVMc/ayqYuxRs7lSn6j3wuDWP/cjIJFvMABsjKBWjDo=;
 b=JI906aZov0NxebxHhF+DsaJp+al0T8qDtFr+wcBa9Xf71BFLTerxo79cgQefZ/vIttLvtmoSqTsFal7cPA5b1P7NEKWzNulqvxr3wBydZAXaVOv4/TFbRRdRJT7HFnjkeAMsWkDY6ukkRaNSXAgRO6TmOulww7Zn/8F/NijYuYeI1hMgblTe69nrh1wpU0cwB5i7KgWeG06r5RGASX0MtbA4l0ezZkf3Tyf1ovgbzRI5YK+GPKI33dcgkKN3GQktu5dZGmQx9Kl6BRBZ1m0vAzUT1kSYbH7wMgqRg5hRezNWHVWY31mHcSi7ZQdSugaKXdLzKklVgwHudLFSNEkDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archimede-energia.com; dmarc=pass action=none
 header.from=archimede-energia.com; dkim=pass header.d=archimede-energia.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ARCHIMEDENERGIA.onmicrosoft.com;
 s=selector1-ARCHIMEDENERGIA-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVMc/ayqYuxRs7lSn6j3wuDWP/cjIJFvMABsjKBWjDo=;
 b=hPCSHtXsbjQu5dsTynvFCKnDzEyaNwdtj3+YVvq2UGOmbqfkbfwJlIge0fyGTBTM2lTz/Jj6KxVtt+5jUSwgNhQBpcH8edxmsmS6Nn8jOcLq+27TVg2ir2PhIAJaGdO3i8Vi2IBYY3Lh6TSoyDzKfaEk7srdE6TtjGd45HH9Vts=
Received: from GVX0PF9060FA358.eurprd02.prod.outlook.com
 (2603:10a6:158:401::b17) by AS8PR02MB9672.eurprd02.prod.outlook.com
 (2603:10a6:20b:5ec::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 13:25:52 +0000
Received: from GVX0PF9060FA358.eurprd02.prod.outlook.com
 ([fe80::5918:7459:2b9a:acd8]) by GVX0PF9060FA358.eurprd02.prod.outlook.com
 ([fe80::5918:7459:2b9a:acd8%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 13:25:51 +0000
From: Manuele Conti <manuele.conti@archimede-energia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: [PATCH v2 2/2] hw/misc/stm32_rcc: mirror oscillator ready and system
 clock status
Thread-Topic: [PATCH v2 2/2] hw/misc/stm32_rcc: mirror oscillator ready and
 system clock status
Thread-Index: AQHdVZY0cRQpHrhkH0+iXQrl4yJhNA==
Date: Tue, 6 Oct 2026 13:25:51 +0000
Message-ID: <BB9E7204-4C28-4981-809A-00454C4154F4@archimede-energia.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.1)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archimede-energia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVX0PF9060FA358:EE_|AS8PR02MB9672:EE_|GV1PR02MB10809:EE_
x-ms-office365-filtering-correlation-id: d121fed8-fee6-4d84-765c-08df23ad5786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|376014|18002099003|10067099003|260925021911599003|56012099006|260925022911599003|260925021311599003|38070700021;
x-microsoft-antispam-message-info: QcTIeeDvIamHB9eRGkzog9cFFNCfiOkg2bHMEEo+upsqb3WvUYQ9fIEhqgOrTuZ9CvA4RohO+Pti7jYv7Yov29sFqFhMcoaRa3LLsOXB48F27ZKQIUYlUD2F6rNvhAonDxrO6jaIom1ZkcDZvN4rys5G6HyDlrQrKRRQE1XY5vp/UK+2DpvdZ516ma2G1h9h5VGca8+aTqP8fK8G9bxFWF+2Rxem+f5S/off+lgl4He10O4fri7T44EpL3xxQu2tlQXeHcZFjf82MBEyoy8uf61I+OL3etFF6vafdi7Odx7g6dvlrUCwC5bH95Q3SBV2QC5oVfExcDU9/JF7IV86mlvbyFa+zPb1tk63R2qaM9K/wQdDw6rJBJltiScD2R8v3iOsxb4gQcIDwnXxt1JfMfsv3y97VT7FBHJqPOEaoc24kg/vkPP0saEWuvvGwdYxOAmKKu+XBLP5gF4TD4eBJQWxNgya/Xgj71tNSal+RbMEzfmWiwqn/Ni2NjdTX/qgVMvWoXG9yJ151ewYtPEdHtX6tyug09ZBvHxytskMFhneA152rhU+96Nz9U5TvS8wQmQcP+IW6QjhfxZ/zqQgr6UBO3vj816qdo8/e9yPMJg0zKiaLptmmIYB+eCHHTbuju84aVw2ypiqVhIjCNSMjRvwgJkEL3x6ti67Xqw6FhMWylW/7G9PPQ/fmvVgriLxyTe7jiS1vnvXM0LJZwyWPewTprK2n9XG8hhLEacIaTw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVX0PF9060FA358.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(18002099003)(10067099003)(260925021911599003)(56012099006)(260925022911599003)(260925021311599003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PBO0CYiRjPhferuDD6ho3wpstALCQP+qp1QQ1eAgbdLElx3IHn5dYvHtQSwR?=
 =?us-ascii?Q?NCesCg4Dba4sPTRoLU7iY4XZVhNC77a19Fzgrl7Z2ElbcIplzbRkO+6wM8dS?=
 =?us-ascii?Q?L+OpOF5UUNth94eL5yqR7KWC4LaDyUsJukoJqU2sd34fJXsozxHPW9ik51eU?=
 =?us-ascii?Q?4szLH8J5c7Os4wod8DgSDq6UsvCCyPH4IC4/IYGHHZMs3nYdtp551BserzCo?=
 =?us-ascii?Q?PspCIS8v5zSL317F7mtSirs53HhmbVsLpJxQTFEZFlTgeJC9Qjd4gAS4cflu?=
 =?us-ascii?Q?DC1PXacufOo0qlwR/XdwbEe7BT8guxlCLhXLM3tBEIO/4QjKH4I3aHituJGY?=
 =?us-ascii?Q?hn67smK6bku1maneLxI2yLunsSxsJcO8qkMzDyT41cRO0oagRpRJ0N9QiK29?=
 =?us-ascii?Q?6VMK3r1bkqFJKzaNxsH6hiVVmYV6z9R7bF/Y2NztTcQd/94ba6vA+AA3L0YX?=
 =?us-ascii?Q?wnvGfmeYt5eJPFEeu/asOpv3LSDqbgkMakO4h18JCEiB2krJhxu65Ssv9pR1?=
 =?us-ascii?Q?tn0Zl9tJagUOD0GYQ9G3hyyOZQr3lri81mrJlrtqF7Fj+lmVRnZxu2N0DKgQ?=
 =?us-ascii?Q?h8EFyFwieSP/B0EdqPVAt8IFexmS/3B6sOhFEDa1JYjdmmOkTq+4Xk0UFobi?=
 =?us-ascii?Q?xvHtNA/DKjH8koDZS+72NS/YH9ciN0Fn58yzQFQTsxnI1oL6PGcBHqh4WLaw?=
 =?us-ascii?Q?zwCMs/4PaRxuCKzjHIG6i53/1QKls2JtFDwMzrQWd+k6Jr9/kBCLk1slnklg?=
 =?us-ascii?Q?q1LQYQbWH+62rwdWmOSxUHEnTy6CfpGlxK4qgt46CG9YRvRjLaLuY/ZADGNH?=
 =?us-ascii?Q?Dpgda8GDguiDT6xHYSDzslfNmshLj5SCEqe9xMybLUzvF2qMlMZziRglD9cR?=
 =?us-ascii?Q?qjkKusTtOX3GLF7sAzQtDdAr6572fTyKmfXQHwG1JSfllqoK4MfCCvSKYzXl?=
 =?us-ascii?Q?tWaVrw47v+zUymnma+ZmuDqn/MID0VDQDmHusXMCriNisz5Q0rVljYlSFzMN?=
 =?us-ascii?Q?s1ArpGVxRxqAkUWausA9Zoao9UHcGJv6pE3uGBs83QrBAsqu1TSffjdhwkWG?=
 =?us-ascii?Q?br64bmdz1/L9AncwFu9l0HTiU8oDab9BB+P4ysBaFGK0sdRrIjNZSIhYVMac?=
 =?us-ascii?Q?cDqGY2/WPY5CRVPnxd+Sm8mAjOT+9HjlEgxeEZQzcrp7JQsf+iRyryn+QA2S?=
 =?us-ascii?Q?M3anjknE8xuxNMFVU1cvHXDlCXN/55esw8KaiCQ/o/XT4tCI0G6IQb/rxQlf?=
 =?us-ascii?Q?YwxZGFdDuFTN6uP35ycfjmvAGVOSrBA84Y/weNKj1IKjd3sNxlRW0Jnh4LQQ?=
 =?us-ascii?Q?CGDyU98vczaeZWH40PH2UgDcfzs1v2cVWJjjRavbpy7Ec1UQpFJWxMTAkscv?=
 =?us-ascii?Q?tV0kjK8DtwRhCXNja9zb6S9bewkqnfUNVBcfNtlQjLRk46X5gWIQahckX5tm?=
 =?us-ascii?Q?Dkvkn0V+pdActcXMvnCFWIZhxy2cjM1VGJ4U2asRwvvYuVg7uNOwG+uCrNc8?=
 =?us-ascii?Q?nqruJ37yTSFoIrgIXDBQkeHcJNC9JfVIzW4YSL6WliphTxsOrO0xew6fOdCl?=
 =?us-ascii?Q?+WMi7jmyJiPZxX5Dll1lyybupbagq6YLzQKYdq52tf1AGdmwmRSYNIvH+nz5?=
 =?us-ascii?Q?P8PwEFQaMDiomKGjkvKirGHMOsBR5H0ecRa1gHupn2tpkGm0+Hw9kIBd7PCO?=
 =?us-ascii?Q?TAWcIy/rFyvuNLDGfEH7c4YV7D3FKunu2Ix+OzEqVLhnsLP072t6YtlTDGLq?=
 =?us-ascii?Q?b6Ka47vggqdfRTUbYuQ4qN5Ovj0X5lzdQOmXgJ6N+B6Ju/iQPyFU+rM4VPWL?=
x-ms-exchange-antispam-messagedata-1: PajcLB6h1QA/1PPbCmnOkMXlKn6y1Pz7RjKMcw5pYd1/qEWWBJy4ouEG
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E413E25FC2286499BFC2118877EFC78@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVX0PF9060FA358.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d121fed8-fee6-4d84-765c-08df23ad5786
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 13:25:51.3854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f446eb6-a8f2-46bc-96fd-2665698112e8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K28Cy2356Jiqmjg8ParJA/E006XlXoZtwLQLfBl4/tYR0FA9Tei6WM7NLpfY2TYIdW0v6l4AaaXZD/69dFHJPRP0JkDJbKKxsvQW/1gKp0+IwMOpwg3WRDkJcvOfCKYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9672
X-OriginatorOrg: archimede-energia.com
Received-SPF: pass client-ip=52.101.70.128;
 envelope-from=manuele.conti@archimede-energia.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RM0090 7.3.1/7.3.3: oscillator ready bits follow their
corresponding enable bits, and SWS follows SW. Upstream stored raw
values, so firmware polling for ready or checking SWS never saw the
expected state.

Mirror the enable bits into the ready bits on CR writes and SW into
SWS on CFGR writes. Clock switching is instantaneous in QEMU. No
oscillator startup or PLL lock delay is modelled.

Add qtest coverage for HSION, HSEON, PLLON, PLLI2SON and SW,
including clearing the ready bits again when the oscillators are
disabled.

Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
---
v2:
- Mirror HSION into HSIRDY.
- Mirror PLLI2SON into PLLI2SRDY.
- Extend the qtest to cover both additional clock ready bits.

 hw/misc/stm32_rcc.c              | 19 ++++++++++
 tests/qtest/meson.build          |  2 ++
 tests/qtest/stm32f405-rcc-test.c | 62 ++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 tests/qtest/stm32f405-rcc-test.c

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 5cfb39e560..814c5ea3b0 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -90,6 +90,25 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
     }
=20
     switch (addr) {
+    case STM32_RCC_CR:
+        /*
+         * Oscillators become ready immediately in QEMU.
+         * Mirror enable bits into ready bits. See RM0090 7.3.1.
+         */
+        value =3D deposit32(value, 1, 1, extract32(value, 0, 1));
+        value =3D deposit32(value, 17, 1, extract32(value, 16, 1));
+        value =3D deposit32(value, 25, 1, extract32(value, 24, 1));
+        value =3D deposit32(value, 27, 1, extract32(value, 26, 1));
+        s->regs[addr >> 2] =3D value;
+        return;
+    case STM32_RCC_CFGR:
+        /*
+         * System clock switching is instantaneous in QEMU.
+         * Mirror SW[1:0] into SWS[3:2]. See RM0090 7.3.3.
+         */
+        value =3D deposit32(value, 2, 2, extract32(value, 0, 2));
+        s->regs[addr >> 2] =3D value;
+        return;
     case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
     case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
         prev_value =3D s->regs[addr / 4];
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 78b3010649..d6a306358f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -238,6 +238,8 @@ qtests_stm32l4x5 =3D \
    'stm32l4x5_usart-test']
=20
 qtests_arm =3D \
+  (config_all_devices.has_key('CONFIG_OLIMEX_STM32_H405') ? \
+   ['stm32f405-rcc-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + =
\
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-=
dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-time=
r-test'] : []) + \
diff --git a/tests/qtest/stm32f405-rcc-test.c b/tests/qtest/stm32f405-rcc-t=
est.c
new file mode 100644
index 0000000000..1a8819b6f5
--- /dev/null
+++ b/tests/qtest/stm32f405-rcc-test.c
@@ -0,0 +1,62 @@
+/*
+ * STM32F405 RCC tests
+ *
+ * Copyright (c) 2026 Manuele Conti <manuele.conti@archimede-energia.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define RCC_BASE        0x40023800
+#define RCC_CR          (RCC_BASE + 0x00)
+#define RCC_CFGR        (RCC_BASE + 0x08)
+
+#define CR_HSION        (1U << 0)
+#define CR_HSIRDY       (1U << 1)
+#define CR_HSEON        (1U << 16)
+#define CR_HSERDY       (1U << 17)
+#define CR_PLLON        (1U << 24)
+#define CR_PLLRDY       (1U << 25)
+#define CR_PLLI2SON     (1U << 26)
+#define CR_PLLI2SRDY    (1U << 27)
+
+static void test_cr_ready_bits(void)
+{
+    uint32_t on =3D CR_HSION | CR_HSEON | CR_PLLON | CR_PLLI2SON;
+    uint32_t ready =3D CR_HSIRDY | CR_HSERDY | CR_PLLRDY | CR_PLLI2SRDY;
+
+    writel(RCC_CR, on);
+    g_assert_cmphex(readl(RCC_CR), =3D=3D, on | ready);
+
+    writel(RCC_CR, 0);
+    g_assert_cmphex(readl(RCC_CR), =3D=3D, 0);
+}
+
+static void test_cfgr_switch_status(void)
+{
+    unsigned int sw;
+
+    for (sw =3D 0; sw < 4; sw++) {
+        writel(RCC_CFGR, sw);
+        g_assert_cmphex(readl(RCC_CFGR), =3D=3D, sw | (sw << 2));
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/stm32f405/rcc/cr-ready-bits", test_cr_ready_bits);
+    qtest_add_func("/stm32f405/rcc/cfgr-switch-status",
+                   test_cfgr_switch_status);
+
+    qtest_start("-machine olimex-stm32-h405");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.54.0 (Apple Git-157)


