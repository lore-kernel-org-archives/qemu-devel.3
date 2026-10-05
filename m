Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C1ECA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRM-0006eu-2Q; Mon, 05 Oct 2026 02:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRK-0006d8-6S; Mon, 05 Oct 2026 02:44:46 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRI-00004z-Im; Mon, 05 Oct 2026 02:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIfDkFdaR8XcatofpQ/9I+rOzwchp7tslHCc/SnZsUPw6eGfgDQYTNIPtt847igfuqPTOLVEpGtx2YPPw6KKI/XyPvA9sU7mkJC0T0kjAuOdBH3uD4lNm9gGsZs3K3nxnNPeGLrzDmRzS+pvzNqjPEt9JDvElEwwrkzOKXdHz0KiRHFnuyPC5lCPb9H/2sYa5vUznnrfWG4BvyJgaEZdx6QCg9D3eAXDjyD/EDHAtS/XnrZdn8TfhNkuyP4XAuuvF8liR68XiyAN/7txr2n2i9HOI/T5FnavZd0ZjCnz4ZVgJjD1+aGJMQhq5ZMWgxaj2pr28phq0aaFeo+y2Hkx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vXDmS20ZJNY41AFM8P00IH4rNVIJeg6PTmDixBOGek=;
 b=J9t8uxCHTFdZCohoevcYDurThd/NZo5RlyqcgUz3VElzE6th4bsGthLH8aIvGqt9IQS82UmUqo/39sCsAppdY1LZHVC7a0Kew2Djl4ch/OVJqLUEiuIRDcyZjEd6WttSsqGFvZzYO6lH+5cJa+akiJaDana6AzRscms366qQWNprIt0vBe1pQHHbsSfKZtX2esBgsJlp42hm4mT6FHGTfr8LHQJkmmueZqPOhjPalPmNOYI0cfGXKuexAJt4n9Co07bIIU5Ox4zBax6LaAdv9ney+YJaphRKQQcNomMN+9Jt8VhowO8GmTJ+ntAisAmybuhEuyL3W8nVcdTePd4Tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vXDmS20ZJNY41AFM8P00IH4rNVIJeg6PTmDixBOGek=;
 b=kYMDuYHUcuYDbtkH9ShQ4Nd1CL2iEv+jQ347Y4OA1WtI1ah8vghC2YBPSR6KqwDrcxxHsVXUD7D6NfXhXuOPW+lZq1d1to4y8ul3zmlgjFftizVjmtgge/BVd7yE0GsmaSIIvGvrNujuxnlOsd5mJ9dVfFh687rfxEkdfUyDFoHYdWPlPwBqYySyFEEu/81r26PhMz4NlJ9OGxKUX5prHVKbKi0uKCP+VNr60Px9c1zHCytwB47GbPlykkHkbya7JEIo6QktulZvAICNTkbMB4aMro6DXEpIOepab0aLcGBjcWW84J1oS+bjnmweipEElhg1fQXrtbY4bYMVNH0isw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 10/11] hw/arm/aspeed_ast10x0: Add the USB device controller
Thread-Topic: [PATCH v2 10/11] hw/arm/aspeed_ast10x0: Add the USB device
 controller
Thread-Index: AQHdVJT529nJ6LmW9UarGGUeMFzGZA==
Date: Mon, 5 Oct 2026 06:44:31 +0000
Message-ID: <20261005064418.3060881-11-jamin_lin@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7166:EE_
x-ms-office365-filtering-correlation-id: 7a728b74-a1f7-45d4-ae43-08df22ac1c2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: bByaiGlvWz6lsRLHhof3Js5FXndDSdMJTvyhtgd+daouGkP/msJRvFwOhY6EqpTgnqbcgJ42YofXU+aGzvJwjAYzUcDqqr4X6uzLmJ6eoVcfZbWYk4Mym8heTIvgV4DljFcAV44rSpaPP5NoO/exx/BhzcBPS+ldw03UO6uowX0Zim2YlStFrD/afhQx5objlJN0us/qpqTo6G7+ci9IfOWVndlir2xoFzTxHXxf5JKrmY7kxL7IdfZPUnijLGIt7s4uH0gi9MbUBGUaP4lDMN4T7LVVAQtIW1euWnVKdTcWdoo/Oaw1nOlq8EAQY7GBbDf3cabY6weLi7Kyq8KTOGFVN2w9GSVqPYIcCwZNx9/rHclQLzxjKrRCmDfb41reGMFxZtW7zHXUs375IvFYU4xKfj4yif2i5wJNtIjYQ4HXM/rYKIiYtRj+mKYmQXtvrbCdq0rcXUGnDaoyKX/PmJwsVgMv33xLxJlD/a5P7ZUD/eokMLCyyeyhRe8uL8ImBjkfYVfwUfOIRifirksYBP+uhT86MKJBEJ/Ek/SRZNjehEEk8a9a1j430AoU8eQ/NYmb+woc+3fxqHTFJ+VcfqfXNCMqRlS7v6YIVVORSJ1Kmxmn306IdgLANvqdE+GzYiIhmL51QTLmrfwl2VmQ2RR6ked3Rpe2GR1g5d+d0rjpeqv37kIIrMQSq98POQmGJyLk+mIpU9gwXHi4+IVRy//H+yRWSV9FVR7xOp3F3bE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xbyQcIcdUQZzEZbBT31l2HcX8cq4GG3pUXq6bdZGBuE/kIrbt+iZ9qlzWd?=
 =?iso-8859-1?Q?GBnTrb2UDtzGEGT6uj5yHBHZ6tAnY8AFrswo6lf8y3OYRSwVNtXwbqKw2l?=
 =?iso-8859-1?Q?dEGtFzvSmHdUJWs7aBkx05DMQrvVLnEBW/10QjowKsfUzmPbryqxwBzh9x?=
 =?iso-8859-1?Q?yJA/SueaTyC3d0am8oJSm9c5rk7gBsce0rTyfnCyAuAw0zxVnxW0aduxlP?=
 =?iso-8859-1?Q?ISs7E/ZEvweqJMvy9MiGKqu+pPv0MTi3ILpIiDcWeVcANoo/fNY319cPEN?=
 =?iso-8859-1?Q?fS2yJTtvFDNt3y+4W4FL9+FzpsdiGFTJXG47nL13KW4HLStMNRXKxkrPT8?=
 =?iso-8859-1?Q?sAlZ8ZsGEFa8VHshz+wDQ4zisqWV3OzBqph1kuuagueN3d4S7yIkFVIamk?=
 =?iso-8859-1?Q?BKal390R+ZP+PAPzdBKJZO0hbcnTvjKRO0+dIBnS+pw/vZ8HYfx45rIz19?=
 =?iso-8859-1?Q?hgtT3byOfQRvcm3e8RGsAoLqSkW75/cPcX0pFYhXskhGczzioFVJm+gvOp?=
 =?iso-8859-1?Q?+fkqkt6aTnnkNzhRvkbvplgHpOKY0Sw9bUFR/iz/G+LTt+j1O6+D1vkFAX?=
 =?iso-8859-1?Q?LUqMfdXv4Fvxkt9IF4VLtILy9oWR+Sd9UP1fGbv+MvauAlhEt5+Ku82JMM?=
 =?iso-8859-1?Q?+SBUwJvdv3bzatHrh1yovXWjdWQLWzS027j3KHKLsdayxxU1FJFiS/HloL?=
 =?iso-8859-1?Q?VS4OAR+zPhnRVqtp6mYRqaB76YmQlWgogQ/qrDqpxpW3U3+xORz7rhdESH?=
 =?iso-8859-1?Q?vCLcW96gVVmPikue67wjH3xttpIwOITaIXp36veAwr2kGz1bvqJimnmU9v?=
 =?iso-8859-1?Q?cSHlsb+NSh8ddOmfRP33U6W5spLFaGxjAZ8+0I4Cd2CeZ3SSqHrWaRBMzF?=
 =?iso-8859-1?Q?YO8HLk4H4JxCWaUcOeuxVCu59RT1wo4Q1+PX79MI6pPyJANj2U8hVePJDK?=
 =?iso-8859-1?Q?GYLLF4JLEVJca2S/nH1BMUnSLqZWWFAi/P15QU2Hdhapre6QisDAg/eZF6?=
 =?iso-8859-1?Q?uMvQEHhv5u+eGg5ELDd41dj42bRmIWu8LjFtzAs8gfYUdU3xBK/E6q7VZH?=
 =?iso-8859-1?Q?/L9HHuPf1BSNBKngapW0J6cZeluNNXMxjz34wtOAbTLra+YF7XOctDUH0I?=
 =?iso-8859-1?Q?lIonR1Xz2syQnPNbkBnlqJOzkeyn4XhzdD23tEg7hy9I9+eAo7K2jt4C33?=
 =?iso-8859-1?Q?PVGE8zQgB+cTWbktVx9yaW5sYcaEIaYWM5xzuA03jWI9IQlz4NxykUWk7S?=
 =?iso-8859-1?Q?otNVnYFX8uNU2srqGLPNrTdqr+VXnuocweWB9Y5XY8wTOWFqq/oHQglO+l?=
 =?iso-8859-1?Q?yn/AZ33NsqaG6ORu1mKYXRo7s+bhei6JlH1H7kTgRsiGVitWIr2aEXQ0YE?=
 =?iso-8859-1?Q?zjL0iQTsHC9PoAbQkqczKeOJ2zgAKhf3tTwX+Y1xZfvyHFSRyS2ieEQ/zS?=
 =?iso-8859-1?Q?tREM7XIBxoEkxZTsD7tIXA8k4dJxLynnwH3b/bIFRe5SYo30mRc+fGgu20?=
 =?iso-8859-1?Q?bCpRjSJS8lJN/wm/WBOIVCZ5y80q+4ldjBEQcX7uIefy/vlwp5EqC39n3c?=
 =?iso-8859-1?Q?ZhNLYkLpUO4i/bnqCI1ozqEPt7gUGo/TitpvWiy2Osi2V/FyBFGAc8ZzdL?=
 =?iso-8859-1?Q?ChjBE0aYBpGHBmnhQIKG0DyWWgwPLRLqeKBd8xxM3xnFy8PPmgMzFu4RLW?=
 =?iso-8859-1?Q?aD2jXEnygSb3ufvOGkzHE/IY/zqJ5L8HizfmCp25TLEKXGXFCl34v5baBZ?=
 =?iso-8859-1?Q?m4wxbj1jkhWQt6c5OlsFNa1PjNIqaCNfRpUs4wEmJVGHJPSMK47+s3XYqF?=
 =?iso-8859-1?Q?WzkDEMUnIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cUJ3AWm/U2dQhM5j4I+7j8ClzIqj3qVdnsMogybG8qbOzoKc5io4sHJGrgoUYbXoIOC9016a4oJUA8pYv/jHzlUj4YDN2PYBq/kcBN7DVqbO0BRVfkWXCXpmuCcup1eo9cKLg8M9Qgan8GjPASn25sWlflJExaSKeK+IT1WleYrKC7K6yolviyeRbtbIybYTDGMslO60mGzH6EW4+NqJL3p1OSvPA0Ytr00hvdtgzaNtQCIoKweeQNIQEKFDsNH+8RxXHOhC+r9Sl/QzNnGUf7KOZkWzMxIIuyjGVzmKXNYptz0zuYDlB0tdm5HY4uhbgcx1Z+7dkPGdatp6l4vwvA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a728b74-a1f7-45d4-ae43-08df22ac1c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:31.1619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8c5ye/4QfdHuKICJx7/YrojjpsUixDJMiWu1inUVGpEOe0Fyn+AuGwmHUR7NFApZi8SmOyDfL3320sM4VDNs9BNw7brbvs8FM0kh3IRE04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
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

Add the USB UDC device at 0x7E6A2000 with IRQ 9. The AST10x0 UDC=0A=
controller is compatible with the AST2600 one, so reuse TYPE_ASPEED_UDC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  1 +=0A=
 hw/arm/aspeed_ast10x0.c     | 17 +++++++++++++----=0A=
 2 files changed, 14 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 38226d9b80..4459188c57 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -167,6 +167,7 @@ struct Aspeed10x0SoCState {=0A=
     AspeedSoCState parent;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
+    AspeedUDCState udc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index aeb5a4423d..81f2d78a45 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -162,10 +162,11 @@ static void aspeed_soc_ast10x0_init(Object *obj, cons=
t char *socname)=0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
+=0A=
     object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
-    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "sgpiom", &s->sgpiom,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
@@ -394,6 +395,17 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                        aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_GPIO));=0A=
 =0A=
+    /* UDC - USB 2.0 Device Controller */=0A=
+    object_property_set_link(OBJECT(&a->udc), "dram",=0A=
+                             OBJECT(&s->sram[0]), &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {=0A=
+        return false;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_UDC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_UDC));=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
                                   sc->memmap[ASPEED_DEV_PWM], 0x100);=0A=
@@ -402,9 +414,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSta=
te *a, Error **errp)=0A=
                                   "aspeed.espi",=0A=
                                   sc->memmap[ASPEED_DEV_ESPI], 0x800);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
-                                  "aspeed.udc",=0A=
-                                  sc->memmap[ASPEED_DEV_UDC], 0x1000);=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),=
=0A=
                                   "aspeed.sgpiom",=0A=
                                   sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);=
=0A=
-- =0A=
2.43.0=0A=

