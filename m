Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D102BCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcnO-0003gM-8x; Wed, 03 Jun 2026 00:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmk-0003VF-Cr; Wed, 03 Jun 2026 00:00:54 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmi-0002OB-6v; Wed, 03 Jun 2026 00:00:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNoqB4LS7ur8gwrY3BKnAFe/shpt28xEIqzqPaF8CToVfFbabS9RBzVV42diW7GrFCchoWUpoXa5h8FwIO3ApNEQ3/el529VtZAbGFfPGj3W9ByaVJ0vGkkYnaNQf5T8hergDgAxobWMd1lvesAgBh3L1zL1/F9uXzRHL1vyYQNjPynpTDnrSb4U5cXp6VIHrKPdpZGt5YzVYMwsbWGDi0nrADjom2uV+nCpC91SJFMkpCHbabDh7sxlb5eVGV58PXALQEBPSf/CejjoTWLjldot8LdiXb8nIh7CvJPqZbA3itD5WI7QZy3ZsP57ebAThhiTyIqNeMKnA65w1jDfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3OsqHROOE6fTpnLl+1tLFFrsZTzXXgi1xiWiyPUlGg=;
 b=KB8FobyzpvuQUQ2E5kFleS3G/q3inZE+RLnXe+AVFOAoLX+UR9w2KtLB5pFUZYuVInm911YdpmjH7Reu2y2ws6ERoW0vaTIFtmIBjuJ+jlCbW5IpljWt1zNYujI+J/68P2jNc7LEwNdIahyGmQyObdq0v0duUvz60WaZBmvXtI71C44TA8z3buh8in7WCpFUKGE6IL99qfql7FqNttIDIA16Xudx6cQP531LGW8HBpNtwo5Rna+UK2X93NjWyA69IV3vNCU7rjK54844KT54WGi1EeDxihtH3b6nw3IIyMRn7/mzUew14rKRc1g8VGayHDlIO2K9oJL6waPYsTDK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3OsqHROOE6fTpnLl+1tLFFrsZTzXXgi1xiWiyPUlGg=;
 b=qbPfWozh8AhfXBY9cwBVFF3aWZpUzAt0opa/x4QKDIxIijaABKvg10Jd4zkbp7LfjsoDTx5+EBJuFLmRKHVCGs4g8XlAF/p6vZdrzPyNenMnkrt65WAWI4JdHWuWy+hKDo3Q1bUhfjmvyKlg+ZctaM5l8tEL7jQEUbsaZwN7n3r3uhG4C/N4uW+6PbzWTX6aC0P229YFgN46SZyJPLBDKNmRWW7jLq1Yr794og4wyGtwJXzEbtkgZalhsdXYu8VbJlm7AfMC7DUayDhHxwBRFBzs04DVeSEmHtAKWYIL8e6YZZJwqy1oWC7T48T8A6JlY2IdzCChb9FIhxJrK2rLGQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 06/10] hw/arm/aspeed_ast1040: Add SGPIO controller support
Thread-Topic: [PATCH v3 06/10] hw/arm/aspeed_ast1040: Add SGPIO controller
 support
Thread-Index: AQHc8w2HIv7L11ABXkuD8T9wsrmY2w==
Date: Wed, 3 Jun 2026 04:00:35 +0000
Message-ID: <20260603040027.938816-7-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6921:EE_
x-ms-office365-filtering-correlation-id: 2fc10fcd-29b3-4654-2e1c-08dec124aa7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: /c8zoLHiKedlcHz2KUNSw6lGHnKKX4B7wX+FYuB8n5wM17GqAifj3xWr9sNku9jP25Y60vQlE60TBRSyDRkX/FLaL2/7IrApgL6tTXkbZMqjY+oz1ziqmDSjpo0Lxf0N2E/oU5iY/E2nML7WmbdAF0OE6+nB8lI2AI99zowWBWbGohcvTC/KrpLwP5BfLjQ+z+6Sj5xsPMPYYSEv9v/FWROyiLPSOAjavxHx/o2jO77qZBs8llhjGDjIAHKZJFMxYIQnzpfpMphGnA3YYcZ8Rbjm/NXVLzz9FJhdd3w2h/eZyPM797otTHljmugDE1uiRm1ZFac9XXDVbjj4TXFZJZSl5XL0+T9cDB6Gf8n38S2RCE73O1gZTSAK/kmrOD5mP07Hg8KA1gsM0uqVMtm5XZ1jg80UAtWswM0D9k6VT8AaV4ouilT5vYQkkTEes8yFfCClOsVRwqnZ/aLJ10SeaDI/X8IRNkLFbmlf2fysHNJ/n/9gqCaKlFi/LCKt/j2dsPnyHOMYagRD5+hMp3bcWy8JusNxXSl5RRMzzh06aFB8DlWbmT79ZwTgpgY2zdbHz5yQX/wm5eip6aBGG1mjHWYZnxfepKg60PPuhpZXgbFuFvX8XFArofhCk2gpDYA6wYIg2jhAk08nsPHCG29TUXDMi1Braze1vLq0nSPrnzt/Pwu2dDwpKiuSExpBkpxVeHHQvwJqymxK0svs+VixxHu2pd+zB7raSjphV/zXi664DRW1I0ErDf5Lkqor232Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8U+OmHvBiAlmqsY7G693K/XOmbKIgiVymYyTMbARCPnd5BCVHk/pa3dgaV?=
 =?iso-8859-1?Q?8uRa1kicxNr42iSWep7t2E/dadMJ47+mTW9k1H7m5fNpGrF/2Nop9iTVhZ?=
 =?iso-8859-1?Q?QhA5O64r/fug3xYTkXvkcgtSJXNE6iQJLAVTzgad2zJbjW+j7jOmdLQrs5?=
 =?iso-8859-1?Q?d2x67Dj8Hieye5Ek5wUpRuCsJ8H+zD1YYo4hogimEH0EwjbFtcPQ/TmTP5?=
 =?iso-8859-1?Q?wmOQ0Mg+CQ7oO47E3jSRT/+4DhHkNeYaVQ2fGV/VDpX25xCDoRVDMObuMg?=
 =?iso-8859-1?Q?+8rwvJOaxSgEOTvjMp1TkXTFDR8JxUYyP9A4Ep6mO48nVGU1DgeopCCx07?=
 =?iso-8859-1?Q?xPzzEa7sLHVsa9CA7HpabzC0rZ78ngxJtNKKOJCpXN33hnSSu+3D4PFuUD?=
 =?iso-8859-1?Q?6T9085zl9hf48Vo1KDBaaTFmNdFKhH9zuwNVdiWIye9cYzylNUc3nNnPhD?=
 =?iso-8859-1?Q?YXF5IMH2VwVNUvtp6MAXyqcRPcLeU3J5P4qNuAbfQ/iWlTnaZMVPGorTXs?=
 =?iso-8859-1?Q?YrExBjs4aYZxvot24LvC9RYlTxwa/k28D8UGg9hO/ipBVgi4L3K3gxHCwh?=
 =?iso-8859-1?Q?hpYM9OjJ86FWFv3jRxapIPy4bg8PlZKVVBxqkc5jo3u/Vdy0cucofkg4RM?=
 =?iso-8859-1?Q?xukHyBwWll9bTMQ7A1K7iBhHgEcVmvWLm4IwfQMP51I7rGj3sor5/Zoo1A?=
 =?iso-8859-1?Q?9uMdUswvBX3umPT/jCi2AWUSzTFG2ISzqQsmy5DN+U6ksmIUPUyT52JphK?=
 =?iso-8859-1?Q?Ihi4mpw/tV2yKJgAjkL9zEf4nQF6meL6XN4SzWqnVOD/oiYse0ttoTE/RW?=
 =?iso-8859-1?Q?6ntdK99qdgvr1OwR2L9uG+FB5GjWeu9exdOk/yLuJO6uW7nLx+7wlkT7OJ?=
 =?iso-8859-1?Q?wh8W+kUK4GQ4YFtYHjyKBSyE44BIii8TfTtLju0imQNXRcMC8kl2AWuhrR?=
 =?iso-8859-1?Q?UM8a5+ZmphOrXWFS/xI8iGd3XLPYzC6rXfqLOx+DqbG46Txqu+llrlvxFb?=
 =?iso-8859-1?Q?OXTZ1LFO/1rBGLDOn6IbLtLg/e9ws9rhaUx3esIeE9/1z9PkKd1OdY+AQv?=
 =?iso-8859-1?Q?x3vP9p0RFYUyPJVp03qyeTatDPSbx6D2O20YncPieFRSzyXLWO3f9Sdqx1?=
 =?iso-8859-1?Q?aQseg76V0B19zp4SC8XuHbDpyKNMkoLVumVU4hvtxdjhHsAS/4HjDH/hoH?=
 =?iso-8859-1?Q?w9/FMva7bcHKN4h4aXks0QAZfdG9extTKXuF2gM2iw3BP28aUxJ8/SnT4h?=
 =?iso-8859-1?Q?l6vIpzODHBbW/VFfuyIOfkSQtTxmyS3Vq4GqRxnkIVHw0nGVuDouqi43d3?=
 =?iso-8859-1?Q?SqhOg/KNpKqauBpYHoAg9EqHUYEasYz1H+dPxYJEfjMY2p16b1xTQlmUW7?=
 =?iso-8859-1?Q?3X3tvL3C+7O9XuF6YVLcED4yN02DqyRSgmkMUtK60DpCO8sVBp9IZukQdy?=
 =?iso-8859-1?Q?csuyiA+VuJVUvvC8rmCbsqGDEbSqf4jWXoHl2QvAPRAgLE/FBivgHBWYA7?=
 =?iso-8859-1?Q?g3OaOXDPiViIIM74A+HgLDKJ1KNELrsHuAeJw3hZ8MJ09ioyQJwIhgRmPd?=
 =?iso-8859-1?Q?Q0EB9LcfgY0qVn0l9qQZcC4dca1AGtvqZW4HRXwrf/XyA4RK8A3BYW7JoB?=
 =?iso-8859-1?Q?VHvoANKrJpTZH9yFMKo1dVuju3w3u6IsLNrO6ggF5aHhIuCsvBCGEzO5Yz?=
 =?iso-8859-1?Q?o1pZqNzB7N+veDPxFcU2iGFLbjt46iAMJgZcwKaok0srPhXdjWUu++qSFx?=
 =?iso-8859-1?Q?WWob+jxoycfPZ6U/N/5w2Zv49ZZeUuVmml1dSN9kfUWsUFCAKx0EaumUkP?=
 =?iso-8859-1?Q?OiiwyszCkw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F5uxc9JhXmoFODvipPLedu5mli7bejWo19/60WHWHABjLVXopnDtYQ69xakW91uj6OTlKjS7SXB9/AIZSr5g9RxDMd7cb+a62mdP/a3+gf61ol2NbuupsGZkr8UIrUzDPVmt6G84y+1ScfiHkD8B4OkCouno4LdIBHs3qRQJeosQlbDGLdcPyY0HNp058Xb/RE96vu998l/aeVfbIvJwf1BXLswu3PhaSkI6EpbtcYvHDTqsz9/mQ08WoqSE4pYCR8S5foFmzpC/IRWeqzrkz/gIm9wlX5NzhWDDLfvJnp6IfgeWkQGWfeIB11RMtC9Lc1bwKgm/PmJdl+eHoiaWUA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc10fcd-29b3-4654-2e1c-08dec124aa7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:35.6011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBzip1LBn1Pm+iQjM3AnDv+Piq64g11I0D9UZ7W/SeuYJNwe73cDigLK65t1GanXqCoqSB+zYKdd8LD17doW8dqHcX521Tic0HvTJxdflqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6921
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

The AST1040 SGPIO controller is compatible with the AST2700=0A=
SGPIO controller implementation.=0A=
=0A=
AST1040 contains two SGPIO controllers, so reuse the existing=0A=
"aspeed.sgpio-ast2700" device model instead of keeping them as=0A=
unimplemented devices.=0A=
=0A=
MMIO mapping:=0A=
- SGPIOM0 : 0x74C0C000=0A=
- SGPIOM1 : 0x74C0D000=0A=
=0A=
IRQ mapping:=0A=
- SGPIOM0 : IRQ 85=0A=
- SGPIOM1 : IRQ 88=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 29 +++++++++++++++++------------=0A=
 1 file changed, 17 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index c6b22186ce..77211ce1f3 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -56,6 +56,7 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_ADC]       =3D 80,=0A=
     [ASPEED_DEV_GPIO]      =3D 82,=0A=
     [ASPEED_DEV_SGPIOM0]   =3D 85,=0A=
+    [ASPEED_DEV_SGPIOM1]   =3D 88,=0A=
     [ASPEED_DEV_TIMER1]    =3D 92,=0A=
     [ASPEED_DEV_I3C]       =3D 96, /* 96 ~ 103 */=0A=
     [ASPEED_DEV_WDT]       =3D 112,=0A=
@@ -112,14 +113,14 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
     object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");=
=0A=
+    for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],=0A=
+                                "aspeed.sgpio-ast2700");=0A=
+    }=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "sgpiom[0]", &s->sgpiom[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "sgpiom[1]", &s->sgpiom[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
@@ -221,6 +222,17 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));=0A=
 =0A=
+    /* SGPIO */=0A=
+    for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,=0A=
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + =
i));=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
@@ -234,14 +246,6 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                                   "aspeed.udc",=0A=
                                   sc->memmap[ASPEED_DEV_UDC], 0x4000);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0])=
,=0A=
-                                  "aspeed.sgpiom0",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);=
=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[1])=
,=0A=
-                                  "aspeed.sgpiom1",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM1], 0x1000);=
=0A=
-=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
                                   "aspeed.jtag0",=0A=
                                   sc->memmap[ASPEED_DEV_JTAG0], 0x100);=0A=
@@ -269,6 +273,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->sram_size[0]    =3D 128 * KiB;=0A=
     sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
     sc->uarts_num       =3D 13;=0A=
+    sc->sgpio_num       =3D 2;=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
-- =0A=
2.43.0=0A=

