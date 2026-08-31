Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E85C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yD4-0001TN-2P; Mon, 31 Aug 2026 05:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yD2-0001Rr-7s; Mon, 31 Aug 2026 05:21:44 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yD0-0004qT-F2; Mon, 31 Aug 2026 05:21:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOy7Hsgk1+T/SEfyOu67n5WtDasBwB0H87uRgb3HPdXuTYkBSj/BzvgKb80mstPjEHY1OFUoJavVN0/1Q7YAI5iux3waP2kiKRN93PXhM8eZ7ZvJi2i0KrBw6aDFBzi3F9vS+i8Xd3pHWkdvcCrJttsPgsEurf0WO6djzjHeJppw/2rpOOiIQdDB4cjRcavPHa2MB1M+17hphR7RXlbJa+pNkeudCEBZ7j7q50nSGhWF2gnURvJSxEwmn7tLMpXWx1zCgr5H51OT16492I9SCaIb7MZ/O8dfUz10weAX+0P0QQ2e+RLfkvpdV7KK+qyP8pnmPov6B2mfW1yyGR1MCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+bzWwB7kQD5omyUZ3eGF8MktAp0NFMKoFFNYBTtuX0=;
 b=thM74HRquBqoJKrRaSde/Bte2sSaQEa4raLGLNb7G6hZLpP+BfgZ9ILujzp02jTA0M64iwjc8E2mAehcVIkSSJRmatEH/j8Xx7rhBXiNRsgPFnNah50Rlx8xBQra4sfEfct4baRIssZCUxQYnDYvPT/7BGUNee4a+Xga5b63CvCjdGKPzm/GDJ4yBvfcIldClZ8oCbTNsDWWvEnyA/jHpzBDlUq33Rs28rJcfrZDUT2YFn1iwvBdv7lJwLYl7hcrbeyNN2+I8m+u8/CEl8YLewceowEga8gy5Ohot2nR5/qJjeXwh2VTiucFwDkYOv9i3pTTrTaTBiEjHeyqGbb3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+bzWwB7kQD5omyUZ3eGF8MktAp0NFMKoFFNYBTtuX0=;
 b=HALNJxWS24FdtJXaHoQsSAd/UHsgNUXS0e/JKjqEcl9YdZFFkpylF6fZilzk0PQljgBbVdHWMfgEsnp2TfQewj8CYeLKKAfmhbw9yKlIbwuOwoKtkVVOpwsO34rB3gzRLuPb2fpuecLiYe5HwSZQ2FjKh/dXVpuBMLZ3Yw1Qri6uFTPwIql3C9SHh77CtnhUYoXusehEyTc/jIIk3OLrsjNhPeT0awIfwcm9SESpSQe0uvzO9hZ5w7n8BIa1ZshssDKS9MAVsv0RkzBThBycrkz+xtAcI764gtZcuoMLkWE0rRyKdhJByznn3TQeaqPqyzv5FVYnysq+H3pGICRE5Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5018.apcprd06.prod.outlook.com (2603:1096:4:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Mon, 31 Aug
 2026 09:21:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 09:21:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Topic: [PATCH v3 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Index: AQHdOSobI5/PV82TVEe9Th6zes3tsw==
Date: Mon, 31 Aug 2026 09:21:30 +0000
Message-ID: <20260831092125.1022201-5-jamin_lin@aspeedtech.com>
References: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5018:EE_
x-ms-office365-filtering-correlation-id: 1e7c1148-1887-4586-35fb-08df07413f9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|921020|38070700021|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: wkfnnZKxV6FOkdP4EqwUvuoQ+TSn9HOaoEUH2C2eq8xWgLG340xkOnxarUSXupurwZ3yyZJpNjyK0SFWOrL3L/lLWMAIWwqtHvJqp1NxLIidpQrKXDyCpfhx5WuTwUOKqdfU1JVUj+rq9lxqj5weMs7tkDyN9heExXjDi5WiJ2lScWvpFmEcQIkIlTape54P0ljMfiNvZFd3uU7kMrmIGxlK9o65W7oUxSkqy73fnKXrz50AJ0pH0ZwRqQtNtmz0bXQRUiBF+KukDLaZdgMcRF5IeOtJaQ2DCyjpBlMi48ptitOV/Ol/82+2HrlRKU5mcOrwJGzNoEy+OXlaGpcO2qWJQZP9qOn+uS/cyl1B4GbyrS0sNfb+E31aa+xa8O71p3kVIZ+8igTwenS8xaKXpiEBduj+r6ganl5v6QFYQI7CKlOgzaQYXqFULGKGRn0B83GT1GL4FmWHWkFzW+j2QcwNFi0SzvEyItm2ovZwLEuTWx62+N4h5BstfQf5twwsn+3gWnCDycsaXW8GKM4WjagFWfiDODK3+xincwgek1eiC6IuPhZfhmKzMlxZhee2LR5A0DbReFaASwnl/ZfGkSQjGi5Pw6Qj/H4qCm4DCHMoYE3NXvUivwYO1MspRLQDn22II/fgPIM4oN3iLJox0TEn6PJKf6bybmEjkCm+KsaHqLbCsCesHrNkLD8DQG/TIJ+j9aBnkhUyzhI1EumFxrPrTIVvdcXNyV/A3++h22s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(921020)(38070700021)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n/v9KYMDoL/QawrIAQ5jIVl/H1FBFvXOtFxSNN5N7F6WDBeoppK012I8ZU?=
 =?iso-8859-1?Q?M1sWkJfSQWoyZPaEVoyPeT7CEPgbgjVvfkPRkAPo1EPhRqZsUWf2TGuFly?=
 =?iso-8859-1?Q?iIsUaUMhIyai8o+4iDmVxqw3jJWZUv94dwUmCO0dxP/RoFf3opQz33MroI?=
 =?iso-8859-1?Q?j3HQ9eXHdADIFnCCHW/KHPDLjZAIBXzlKZ+MA9FLwl+oxUAzcUzzFTVyj2?=
 =?iso-8859-1?Q?6sH38KBhqgYekbuYHe0qSTzLNvmFlou34By3VPgB5y2ljjhLfHXZeRHgWD?=
 =?iso-8859-1?Q?BecwepPDgGryGwUp16Oll9tYVXZAWmy95Lx1+jFJzmUxvbLK+qEx/YvrQl?=
 =?iso-8859-1?Q?nWpCKTEnNPiqMktZm2SVjUVRBic+rklkrAZNE1cFn6ZQfk566jo72VIE/0?=
 =?iso-8859-1?Q?EI+kgOSYlo23TyIQH+hqSK9KkGuhpVyP+5YYJpjdq4ei+DJdFJYxiO9DiW?=
 =?iso-8859-1?Q?rEzY5ph6O8GFTv+SfMO3r3PMU4Qfc/RIZPLZagx2sFdhg7CsUJpNK9wE5M?=
 =?iso-8859-1?Q?ek8/5p7137ZxKqrOipfnS/gnNktAqKudmSQXJNAOWhNfl2goLoy0WlS8aG?=
 =?iso-8859-1?Q?Lmz9i1Cwf2qLSjgHFI20G76t06pgEvDWmIQnOyuyM75tqqyLoTMw2j8AIP?=
 =?iso-8859-1?Q?tWBHZYGBY5WQale3WAeUu4CYWD9bj349uPp9jaJa1JZTfXzOSaEzWLzE2o?=
 =?iso-8859-1?Q?BOUzy9L9jy3RlKxYwZCZmsyzLjocTS8b5QBDGBQ6Es6jV+kwfF2JfuGc3s?=
 =?iso-8859-1?Q?/yt/E73BTjaMk25GQtiss3fCT3n9vgWcmOYAImuE0W27YY/LWdJXVNlOvd?=
 =?iso-8859-1?Q?QlXJn3j+n0D3KX+H9dRkaki2sMFMarBm+e5D04kfLwXC8HL3nGX6a6ZhNz?=
 =?iso-8859-1?Q?gbBuB/xZ495740r07G9RkupUikfnTl/AXlyudvyUF5QjPSU3trFnBqgAuo?=
 =?iso-8859-1?Q?9Ii+VRvgOFAyUVSOAg8/DSEIMjrIh2eP4I6dVXZz5FIoKxcjaMEkF56h8L?=
 =?iso-8859-1?Q?9bGXlatXAzMxxsTEA8MdbmayLMSw2bkNkOvHjsBjHlKltzp4VFi8QIo2Uj?=
 =?iso-8859-1?Q?Kkcp5cSgiMBY682ediwj04ZWzO1uKFmm6I9QFECJ92HyXtPTJgx4yj/AZx?=
 =?iso-8859-1?Q?LRELBFpOUE7voCSLCP0xHgfzMn3S08FRDvJBv3uk7LZO8a5Gslw5zcxl7+?=
 =?iso-8859-1?Q?CYLPRB2dV7blk7D0UrfyoNFU05ddBp2xia508D1msUkz9WmsnXXP9f/uDc?=
 =?iso-8859-1?Q?4sCoGA8pPXkzdsM2WTbKAz097wZb2ukACeXB+ypAAJUZ3Px+WS/y5qMXMB?=
 =?iso-8859-1?Q?+GhzjLr22/tjqzumTwQvBs6htReallwjHHEOrLPqcbA7HylsL2bHt7Ue9N?=
 =?iso-8859-1?Q?MBnPl/AC0ogIl8MhAE6GedjCySC+5eZdJkoZFsc3iBMePkMm8eyMqhnyD5?=
 =?iso-8859-1?Q?NrKo+ZHgbRrjilFCZB6TkxbygV7FwmM3gYqCylbCgufzzsjWnRWEtX2ZxH?=
 =?iso-8859-1?Q?Ck7jyECi0yDz5lLU+29Qea5IW7Ee9/qmdGDCu4DteJchyBTG1QMkNBuzQX?=
 =?iso-8859-1?Q?pMvi+/C7tffLqiRgvg8wSARScbtlh3dTrrDvRWzI9cjjhnY/n/jjiZTHsL?=
 =?iso-8859-1?Q?m9OoLHdBJ8Pd3m67qrCt3IOBSo2nsbG5xOkpGc6AIUTlKBEVYYq/Ok2Yox?=
 =?iso-8859-1?Q?dkmDyM3BZjdeQSl9+OwhEEY+EvF7Q1O3txjUw+AnOXO5cYiyXGxgNh25GR?=
 =?iso-8859-1?Q?j8k0Nz+dfHrf+fqJhGJuJQOdrVB38ZHWsv5hLPvWgX4Jygu1bYLox9ziIT?=
 =?iso-8859-1?Q?rAdiSumY4g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NRL5gdNnnJchDnyTlmmuN1m8pEcOguwqT0Q1ulp9ouQVKz1FxzFSjo/X2XDXxirHIdiOF343k1g18Tw7nOeeAN/f9FgaqlxjNUJNC0wXuinOOzp/VT0Cnvd2NIYNmvxpQMFE/7fnAnirFRLO7FrqHaEPT/5p7A2m+moTr8P21QzIe5fvrXNXC3yBhEfMbtfahJQXrqBbfQW+6uqznZ2pscwlC3AQSCz6pm/wJYLQubvddNxho0AD13mdOem5hU91nroOZAbAFm+toKLlTw+bdMGZohvsWmIbQOuT52gu/5oRqlNd9RuXePyX5928Lf2WgbSlNUL3+Fir7I/mdldohQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7c1148-1887-4586-35fb-08df07413f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 09:21:33.0500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvNggJ4oMFajBNerKB3XwjnYiY3km3eKPb5jeX/ZNbi4AqyE+zvN5W+Tp3HR2V9wFxapicn5ekI5gWN9FJdRPKG7FkS1xQS1wABO7j0U5RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5018
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC=0A=
and map its registers.=0A=
=0A=
The UDC and the second EHCI host controller (EHCI2) share one SoC=0A=
interrupt line. Route both through an OR gate whose output drives that=0A=
GIC input, so either device can raise the interrupt without the other=0A=
clobbering the line.=0A=
=0A=
The gadget USB device is not created by the SoC. It is a separate,=0A=
user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a=0A=
USB host controller's bus; it finds its controller through the "udc"=0A=
link property, e.g.=0A=
=0A=
  -device aspeed.udc-gadget,udc=3D/machine/soc/udc=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  4 ++++=0A=
 hw/arm/aspeed_ast2600.c     | 37 ++++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 38 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index cd68c7f1ca..fe7b31e42c 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -36,6 +36,8 @@=0A=
 #include "hw/gpio/aspeed_sgpio.h"=0A=
 #include "hw/sd/aspeed_sdhci.h"=0A=
 #include "hw/usb/hcd-ehci.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
+#include "hw/core/or-irq.h"=0A=
 #include "qom/object.h"=0A=
 #include "hw/misc/aspeed_lpc.h"=0A=
 #include "hw/misc/unimp.h"=0A=
@@ -138,6 +140,8 @@ struct Aspeed2600SoCState {=0A=
 =0A=
     A15MPPrivState a7mpcore;=0A=
     ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */=0A=
+    AspeedUDCState udc;=0A=
+    OrIRQState ehci2_udc_orgate;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..21db95f5ae 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI1]      =3D 0x1E630000,=0A=
     [ASPEED_DEV_SPI2]      =3D 0x1E631000,=0A=
     [ASPEED_DEV_EHCI1]     =3D 0x1E6A1000,=0A=
+    [ASPEED_DEV_UDC]       =3D 0x1E6A2000,=0A=
     [ASPEED_DEV_EHCI2]     =3D 0x1E6A3000,=0A=
     [ASPEED_DEV_MII1]      =3D 0x1E650000,=0A=
     [ASPEED_DEV_MII2]      =3D 0x1E650008,=0A=
@@ -214,6 +215,10 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
                                 TYPE_PLATFORM_EHCI);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
+    object_initialize_child(obj, "ehci2-udc-orgate", &a->ehci2_udc_orgate,=
=0A=
+                            TYPE_OR_IRQ);=0A=
+=0A=
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);=0A=
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);=0A=
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),=0A=
@@ -561,6 +566,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
                            aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 +=
 i));=0A=
     }=0A=
 =0A=
+    /*=0A=
+     * EHCI2 and the UDC share one SoC interrupt line, so OR their outputs=
=0A=
+     * together and drive that GIC input from the OR gate.=0A=
+     */=0A=
+    object_property_set_int(OBJECT(&a->ehci2_udc_orgate), "num-lines", 2,=
=0A=
+                            &error_abort);=0A=
+    qdev_realize(DEVICE(&a->ehci2_udc_orgate), NULL, &error_abort);=0A=
+    qdev_connect_gpio_out(DEVICE(&a->ehci2_udc_orgate), 0,=0A=
+                          aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI2))=
;=0A=
+=0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
@@ -568,10 +583,26 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)=0A=
         }=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);=0A=
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
-                           aspeed_soc_ast2600_get_irq(s,=0A=
-                                                      ASPEED_DEV_EHCI1 + i=
));=0A=
     }=0A=
+    /*=0A=
+     * EHCI1 has its own IRQ; EHCI2 shares the UDC's IRQ, so route it thro=
ugh=0A=
+     * the OR gate.=0A=
+     */=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[0]), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI1));=
=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[1]), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 0));=
=0A=
+=0A=
+    /* UDC - USB 2.0 Device Controller */=0A=
+    object_property_set_link(OBJECT(&a->udc), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_UDC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 1));=
=0A=
 =0A=
     /* SDMC - SDRAM Memory Controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {=0A=
-- =0A=
2.53.0=0A=

