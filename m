Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F81AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7Ko-0000IV-Cm; Sun, 12 Jul 2026 23:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KQ-0000AD-0U; Sun, 12 Jul 2026 23:27:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KO-0006V2-NC; Sun, 12 Jul 2026 23:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv0bV3EXvfiDM1ACxEBkPGWWA6o7OF3Lpo89mGYfO3sbHmdvlK8VPYEuar3P7pmrWJsXTLWSDyZ3TS3nXw4fwUKWd1Ch4g0MFIlcf93w1f2IW63dYvlomn2FIY1ZARZ0zZxsKujW3xW1Y0cU5Ji99yRmrR70bC00qViU1tZjT9eZ2/bYtRYBhK13ihuxKdIMtpbvYVLVET99owYy6xtmHxgUS3KSzUXsMnIqkPiNTxO/EuNG3shX4rpt0FXKPvPiqYMMwyfXGjIPvyIgOs5epWmUh2i1ClY766+8oniUY5X9QXkY28GaGHkp6TXmaEgrglDuG7geZ0wgHEzlyC9gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AobsAsjQMbNT0zr7kQ9ItFpNIEiOcivN7CZM6dWzZAk=;
 b=ckxnaIZxsf49IXFDrvWC90W+ybkwOEU/WcfGRgRH6M5T7ZcKftE54rtdCUF2jra8Y8HXyHsNyZOcxtOQYkTboEPqnKUkl3o3jp5vSDd1U3EF44JRbP5KilRXXWvFrzUjE+pQ7c25L3wiRVXrzasqEJdZjwxIYTVpVEvbqqm+aCewdlaRifkqhFvXWX77I2KsWFCM54AOhRT7SpKS0fgizmZqmqTgL7VMbgFew7QYs9EKZNWFzWU23dAjUIiiHvBgK12E6tjkAPUS2MGF7nOCFZ8m+VxfBFDQ/faewwm9TMhqv/ykM9pQrDYraVWvg5dxaWFZ0a6+5wqGl/Swh+dVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AobsAsjQMbNT0zr7kQ9ItFpNIEiOcivN7CZM6dWzZAk=;
 b=k6Ig8LTZHNlbS/U67Q3T4t8CJE0cjPOCZn8T1VdicGQmvV6xASOkzkZ25z2h0oIetoYjWdtQft1v5q66WjODkPQLu01YIS3/sRG5XcyjcL7JRUA5YGwJjTqe0rBC+wwveDUTMwLyVMH5KKCRl9C1mCw+x7C2+FFJOjxQVty0dtVKP5s+j4c2776p06mpjRGIrovUb2gCJ6aHTV0xV9VXQUmTp6I7on/600kE2r4tpexGEZbFaP8VAF2bxfXgbGeWziQ/VnAkrjX32eVhglAR3B9gNeRkDmbraq9QhknS4ixQPoRkZGeACIMRv9C3b59tmZ0osd3hHbRKuSPMwivxYg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: [PATCH v7 09/10] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Topic: [PATCH v7 09/10] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Index: AQHdEneCYzrVB//A20amoMb8eJM3Tw==
Date: Mon, 13 Jul 2026 03:27:19 +0000
Message-ID: <20260713032704.3583103-10-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: 0787adf7-382e-4309-e001-08dee08ea516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|5023799004|921020;
x-microsoft-antispam-message-info: y01LjR5kBgTg6xfNRArqtFKm6OFvDp8Kp2CK6xoc8MPs13DFBRYxdKrpnqThEBnEdBna5cE0gwCQcEitnieiCu3xSncia5peQ6CgultdqbdcqHXSoL+kfpYq9L0YskYkrLQaIWUN4pXxMhZ5R81vGktg9Pby26wa33wQYPV618armlpZgE9l7jy1kMP3kYZzVCsMoqjXxvspROdjLONC45skBl1z5oZsPbhDPETcXftI5NehI+dzn46/Fm6OF6DJPHevoXjhomK+llNYevH06+d5n+X3jfIl9cct6zsUUh8ARF4deFqoCrdXIkW+zQuus+7hZuqGULAzDUm3e5Sh3yWEZpXnWVw6vaAlyG0y2y6la3d95sX86Wx0l49eGuG0ZJvX9nIFgD5bGYXlb9F8DSyqTfvjf03+zoiIuWvyfQXMfd8oqdRqmqg4ypokIOUlqoXunae306IS3X2AHHw+lVzlVsH0NxLLtqG8+xn84pU2PiC/PwJ6TyQPrYdkcIAAua35WiNItPPV5IjVtqsDDbEHcDzsv2F6Vq4+YKCmx2cEOKXx541bLh7dutOsFyXnTtIij74g3qq4mO/NjG5ehLy0wJnQy+B0LKD9PJjLL5qt0RAZpOsZybKch1c1EuFnYxo60fni6qVmZr5ln6SW4s2zEXUdnSIw6vVDQORtSqhW1onHXzEfi/4h+PMRP5XcGzZc2nxK7JkHxKIqo4qfWFZ8KtpTcL1EzwgBmXXlRuSnbUPBR1JtpqqgFkSvZlfO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(5023799004)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vJEC6WHWJ4hMKqgq/M9rCFFYCcbI4UTC+tIwCNIZ5l6I+C5V4LThOCkwPd?=
 =?iso-8859-1?Q?+0QhyB7sMNjEisiPAyLjYHBBNcjCkzDEfvYBPxIvjL9fd7LBmUeP6eX+m+?=
 =?iso-8859-1?Q?jMwtHV4VZ09s3wWq6xIyLeqnlevwJ5XLzqRXslqtVR4vF+SklVsXqA9qjJ?=
 =?iso-8859-1?Q?ZAS5dcR0o4DhREbrXLcxPcnK6acbuJEVXL1N/oqIWfqgGOkUg3xh1tm/tR?=
 =?iso-8859-1?Q?t5dI89lSktTW2s5P9UOPBF+XDh0ORrpOWTznDMJKWchln4QXG0zPUqnAB1?=
 =?iso-8859-1?Q?5PF7qrpnUhFIrnrLDYrvvKy0bUkfMNJC3NVW4R4S8UQ6GmvV1KmtMg0mAt?=
 =?iso-8859-1?Q?LoHrMpwJVyRbauztaa0x5sJx2Ux2QEDS7TDPl8uvWf/eVDynWoJk24Bery?=
 =?iso-8859-1?Q?3I1n7zA/y4/Hyg2HnivuHb8u/eKoUDJCNdAuWHgRm1ry3KtH14K5gqXqDk?=
 =?iso-8859-1?Q?c0NB62t7+OoE07LGd2Qya88Urex7/N30l4CHTX3RzxxFKSYYnFuqQNDubG?=
 =?iso-8859-1?Q?5RUAjoQYQjZER8KvAlGhAKRF4YwJKqXJMxt9ki6TIVBCeXBFjadQPXA1iX?=
 =?iso-8859-1?Q?y/rHbNcWxkGvySklghmLytAPedV6LelnT6ZbIYoqHoloVG/C4t7Ogw9JTn?=
 =?iso-8859-1?Q?z7X8BfMI+g65qvcte5ElkAm3yjc6hrxY2YEM3PjLYZoDWEWBwfT5V2xYBD?=
 =?iso-8859-1?Q?2huyF9nM0BQzH+/pyNxxiRlfKsawqM/Ay5LyaB9IdBP0bz0OIXh+spGAlA?=
 =?iso-8859-1?Q?jijbRl5jqgttz/celL3UGqyx/KHqE8iLxISu3lePVL4nghvBIpE4iP3rWf?=
 =?iso-8859-1?Q?V2D8IKcJGPzh+6Llag8e4ZFvVVPFec4soJfBF2sDFuH28LbsJAvkVOkN8v?=
 =?iso-8859-1?Q?7m45651PJGIL2PW/4xuNjqzvRr18DxDc8QNS423x4xk7cgbcnq86e2B3SX?=
 =?iso-8859-1?Q?IeP3HYEPv3YmViY/0RaBxuNvzYIZ9LzSHrymsisCb9Y8LZt08cjwpfL9Xq?=
 =?iso-8859-1?Q?wy1b+SHrkpT/fNCHr0dFvn2g53KcD3olkfTdYvecZwpxa27TrOtt5q3S/B?=
 =?iso-8859-1?Q?p5qBfDWKZc9aQ/6VzSKjoscCtXjBbGF3xcUlEq7mggojALnAoGSesEjBa8?=
 =?iso-8859-1?Q?X1BGRNjUUiKCILwYup2TcenbFSe4u8+f2e8wzov4+NnKKT1hzBuMoAqKfS?=
 =?iso-8859-1?Q?5pDWzf/9c5KF+6hjU2i0verMTELXTQRlXcKjVuvq1FQzyGlyofQozf1UHX?=
 =?iso-8859-1?Q?v1ztATglIbc6b6JP4I3kyVhsZ7sHPE/7TL6YNpoPDWIoCOgzTj0RZc7FoR?=
 =?iso-8859-1?Q?HF5gZwyjgA9yfN9hm5F8EjGfGDASSfFL8lP+h4RcQty7l68D14/A9ktWat?=
 =?iso-8859-1?Q?pP/xVzgVO1UIO23L3LEuI7CNN0C7zOLmDt/v+EUxE1c8Ce2xkZCmB17EVY?=
 =?iso-8859-1?Q?plHYcVxP7XZiYnbxILlTjW+LPjCSpM+S2CJ9zxDEQoFL7sPl4GnBwMA3/O?=
 =?iso-8859-1?Q?GhHJqyc6ujsIhanoQTjT69dL7JQ8hby2dBT9g4TcobpdVWPn4j4ECHA6vi?=
 =?iso-8859-1?Q?IE3C9XyG1UJgAUUc88KvoORrTzdrtlg9dxuzyHdVvcby3NW7rNif5Aitmy?=
 =?iso-8859-1?Q?xCRkFfuRYgJ8Zwy3LyzYDF6Bkkl+PdBL7olgIJYscwGYhbwvndJLIvO16q?=
 =?iso-8859-1?Q?kQFBAvlygS/bHJYpdbgnYvKBMIkzjC/TqWTTzWoRu+/uX6nCBLQaoYaU0P?=
 =?iso-8859-1?Q?hP1SgWKbI82nC7+x2m1gHRfSz3Blu+qIZQSlTtdHPWB4u2sWZ/9Xpfav1q?=
 =?iso-8859-1?Q?rAM+EHYKRw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YEU5vGUroykYoR89/LtqCpyas2TEmGNJVrR2teEIvcxx+Rlj+/6J3XVX2N5g4f07tW7Aocprg70PBeS/Fktyuro9yI7+FbyTAb5v1MZFJ4hOkxqPdvgl5BDeMjJnT5W2+Z5YQcUr6D9epfaQoO13RJ+pJouETnMB8OuIkpwYyxUe2pOLh+0ypeLhzsxYR9fuxUmSJ41wTHqHnvtOVwtaaoVjwv/wPlNZsfxGUniV8CSH/zzuja5Pg9I2+RVWpxJ1FO04UAS5JJ2uVUYz7sBJSjIqXZPvYBb2QMQe4F4RSKKx3FwxVEaZ9jPmmkEF1J8ImfUMBIE1pN/A6pXP10Bwog==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0787adf7-382e-4309-e001-08dee08ea516
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:19.2192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKjvNxIZ0RCJjlPjAxNcfL1fHM8RqC89QIWjqwP6U5Hbln1Wq3j17YYTp1iLry3OLtWX6yZ2Pkj7oaj674Xuo3fhB/A+P+bq2EB4SBANPSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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

AST2700 supports a 64-bit DRAM address space. Therefore, DMA=0A=
transactions must be capable of accessing 64-bit addresses.=0A=
=0A=
Enable the "caps-64bit-addr" property for the EHCI controllers=0A=
on AST2700 so that USB DMA operations can correctly handle=0A=
64-bit memory addresses.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 0b56d2bb67..7c062580f2 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -873,6 +873,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
         object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
                                 sc->memmap[ASPEED_DEV_SDRAM] >> 32,=0A=
                                 &error_abort);=0A=
+        object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
+                                 &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

