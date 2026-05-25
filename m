Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310A2CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9A-0001wy-PU; Mon, 25 May 2026 00:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8c-0001hz-6X; Mon, 25 May 2026 00:42:03 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8Y-0001Gh-W1; Mon, 25 May 2026 00:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW1Oxn1DtJYEL+0N6Am3DlUhTJeTdODQJeS7q/GGbKXTxKw4oPxjU6bFt07xM2ZJsSfVCqJASjleWPXzTpIeiZaIwp+de5YlzVPy8L65siMpwdq3QEYXu0p8001eLu8SjQLFj1CU/FSpqpQPqc31YkAtBClSZ/AjUzBxM0o3H1FtCSCRSUhd/XEqhMFG8yMXBOpIDA1uMTRqHMz4oidhX5S+lRKZu7gDqlc/LnPAjxEHuwQl8Wf5cTNrRcjuoemCc6ZDJREJUMxT98KXvzHXNhxm9lwq76lh27t/XBUp/0QGaMSrucT94/OfaUpRBRiGrtSD3rNEAvt8aRd0UYbBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f+zvHn//6xapVsLWkkKH2APLh3yMIeCPPr9Aj/WXIQ=;
 b=QyvbXqeT4Lb2YbSafE4MgW8JZOpHm9i/0OaztbEox1zyxekK1DRkFwc3y/EiT4gv/Gnjhs10Z4zbUHLmSTc98l9TlUwIdNypG3grqv8AgNMTFaNvbZPj2ZrC6XOiyFYfSRuclhk+NPtIMqfAA9OUHG2k1h1Jd4wveYfdKtrQ+96TE+XKs1lzIXYA7gr41DSbVJIYFQc3QgST7UNWUJLFFTetwY9aOVOv2zFIVw0Mwj4ZaKGXifGfdG2uEEmJxRL4EKII7RjOySptxLY0TZhjmax9r5jIAUZ4ULdUzr7jDDUrUY5/fBw92ADAyveu76Pm62rWpW1UF8/0kUBzTTlvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f+zvHn//6xapVsLWkkKH2APLh3yMIeCPPr9Aj/WXIQ=;
 b=da4UYuoDumabGotWWjMGFOITPZkXuWKaS9MOC9efg4F/Hcys6SiK4E2cXmqsgrwGZXpVN+A/aO9uB+hgP2u0YlSGLQc/H75rrFJ0Y9bLSW0QFxUFREaQG5JdS8sfNnuTYNIE4QMGCgmzM7ntTCT4OPxD62eL76NquiBBKCZRs8VpksVr7F75Jd/plB/J9uC/UIWf7FqIHuxhHcxAIiLAxvImo3I8HIKzB6uJpcU1KEX44mOJaXBoFOcrX7n6gBz6b5D1zQv03IsdxNwyOhWzL5JG0nNCBELdb9nDz/Y4a1/MYTyQ2xuSQOCvv8ZH7iKhChSDV3zKDLKWaF+NSzgKFA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6593.apcprd06.prod.outlook.com (2603:1096:400:458::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:50 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:50 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 13/23] hw/sd/aspeed_sdhci: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 13/23] hw/sd/aspeed_sdhci: convert to use Resettable
 interface
Thread-Index: AQHc7ADNd+bdxQGN8EKz6rAOtaWauw==
Date: Mon, 25 May 2026 04:41:50 +0000
Message-ID: <20260525044129.3133916-14-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6593:EE_
x-ms-office365-filtering-correlation-id: 7fdb91fb-bd84-4528-4e66-08deba17efac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: BvTjK7Ey3TklCKnJrAqH78sc5uqeDmB0Rd62X4LlXOtPxSNkx92JzZ6jMSoqOhATQk3szZ6Sq8Wl3oWJ6pg3enDQXa8LmeewwZivZfVi+USQOmxlyut+tDHnY0hvk9XsUM02Q3dgIclxGuaz/jMs5T+E+BJ6sPnZ8eWcLybyP64KLiYCga7ixOfYxEQPDRgmsARkisqrxC0niIhj8bobPLiIIwX1VD8yV431Zyw5qrZLjwBpBtC+vKMh2ruATHgcz2lNdcjSKBUoscYCjbzQfkQFIf//h401IyGDHnWvMZ2zhqmTvVcSDLo0cZVG8KtJxKvKGBZpnJNzaHIJ1RS3f3FMbvrODPSeV4w6QNwyj8fAAsUYf3XcWeGFbVMkfrD0GlH24ZF7mjnBv2kWHWJzJDCGfANd9mnKVXdl40oXqQqhAW3mfrh/RrrgK/w6cZhgkYYN7+rRCINeeookQ7H3CriCDW6gPYHCiFNA7fWO9uxIYGPpy/o2FWiW37oHLLN2sA9Zitu8/U+A8+LZj6GrOdB8Cfh7vzpcCXiWSPcSJg01vH3AVb0f2mCS3XW9iNrN/rvXsaBhfNZbkP6oEVv6iJnUhsp56//4MXFyMIlX/Jt2sMISB7k4a2aOOm6KQlbj8T5TNQNeDinQNGRVjjVyodSRUorpRRUHpyhTYBH37EIDW3gaAZjwWXH2Oyd+l/EzhOtCroL3hWg/E1ImqrXREobH+QrqVEF7rr4CajMCsEnbIh3rIpHpec82drFJ1gEmYnXiJwcYqDG+3D4oJw3TJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GWG+RibklNzEzAtFgwu2d4pdcO7/HD5vKf68ma4nDWpYfZve2nfIWdRvom?=
 =?iso-8859-1?Q?DPgjCMCihqmyPO0lRQ4YvLG5siLtoC12SAq9O7Xa8W7lsGMmINXVXm20ig?=
 =?iso-8859-1?Q?hbgErc19AePb8quPvA9FDzvJrzxr3SxZ7h1XRM1kZBhOBbAN5aOnBtwFAv?=
 =?iso-8859-1?Q?pDStSDuv8YHUWmf0eMsNYl3w+VptoA1/CB03+VbyLmTQWR0lPfl73PzaEy?=
 =?iso-8859-1?Q?t4IqeGIiTumYtuo+MAmrqdvzqmwpN87yExjPQtRcpoTy7giPju8KirAp0w?=
 =?iso-8859-1?Q?Xvu2dUKvfuYu2+q2Qfk9hShkElmgiqtaYb27SfkHvFmBwPmp0dm0xoXBeG?=
 =?iso-8859-1?Q?5GCLFJCQkx34Gpdpn7We0InuGLmQQcHH1G9yK1X8bVJJdMf65+eO9yvdFW?=
 =?iso-8859-1?Q?97PwWwep0PI5oEbLHdqGzoVFCFkddRtZBho/oNi4M49EQL2ZRnVxwdbuQu?=
 =?iso-8859-1?Q?damX2lUT70m92rj0Af0micVeyM950vmy9pdq/DMs25sktb9pm4BPHLzuVB?=
 =?iso-8859-1?Q?fFJFzLlCBml2hfLFI50p1JnkCcmcpK0nmPVIqsRz3vW8Q/Ararkn3Z0Uz/?=
 =?iso-8859-1?Q?83fddoI+QFq3vPlJXVXRFzoteOKGG8lJ9zEkW0JJ02OpI8FF0oHWKx1Gsl?=
 =?iso-8859-1?Q?2+AqtejvsU/NkuprY0P2zUu0W+X3RjZNTAwX0hdg/U5PrV8BfWtfXif6Xy?=
 =?iso-8859-1?Q?Px0WVVNrMPxn8aqkVVWQuyj621qa4uaQfMm52TedslVWAjjS93Hgpc788U?=
 =?iso-8859-1?Q?/Zh1KDD6KtkUq7LcaIfdGB7t997slCsYs5qjr6EoobDIESLa660QLaINTV?=
 =?iso-8859-1?Q?2C4uLxivrGDaW5/OELihmhqYxlZzi6ODCXZ3ReauYweOPtCXR/iJzR+eX3?=
 =?iso-8859-1?Q?lXXXdI1IRiRBFBalO12dOp6cuNI8/IxPF/j/gI4tBh2HNWXg4+v2eJnkWU?=
 =?iso-8859-1?Q?IFmRbvdYgbfLiDy/1W4gSbKJy1WCQnpO45LTMjkyL8wIZBgZPKUXbK85T4?=
 =?iso-8859-1?Q?SIv2xLL5JnVgbi3CCYr20HWff7QmRCpxSQ/upPpdAUuXj9iZv5bzMNlyFs?=
 =?iso-8859-1?Q?KUriGU8Je+pn/vsy9bejhjkasJ2N21K+rjmPgpHN0Fga7n0AXfhMk7vpWo?=
 =?iso-8859-1?Q?XQmnvaKhAcY0/uKrd2gqUwV4Tw/v7boD9br8LmSmFgjMin98LqpIvXG5Rv?=
 =?iso-8859-1?Q?ozAoBF1s1bnOuOGDAALfRdgGPWhDI4UO9/uR5lgTCE3tvQijNDjMTS9Rb9?=
 =?iso-8859-1?Q?P+gNnO1f1emUMzS8l/lVU53ht/lRhcdY2+pOQM9RPPVarMNiGY95UnwzZy?=
 =?iso-8859-1?Q?TC1gp+bWXZoM/IQcARgeQ+MbRoCIM6zsTRWRLGLtj4b4wL3CIvWTCA3yrK?=
 =?iso-8859-1?Q?cYdqftgzO5vsgXfcYIq6Itro73XCondhC0KGvlEk8n5Z8EfNn/tH9V9Yql?=
 =?iso-8859-1?Q?cH/T9I/EqpzSeOQxJb4IovQzLnaEMRnC9e2IA/GUJdtPN6yCLKMG6xSZOG?=
 =?iso-8859-1?Q?4Ilnyth5yfzBsb7NFBHS6z9iYDY9Uthb8sqzpTCstBRzjrx24tVfE0p/jz?=
 =?iso-8859-1?Q?OzXdnBk2sIp9Vy+Kc8xuchvd6bFguEqFW5UGNIuvRxQvhjsbDGAoD3YVSD?=
 =?iso-8859-1?Q?oQfGFhiXb5UgE+l8oxKZxWsioFPaUo3aO578mEAYaaK8Wx/1R7K8mGyf7t?=
 =?iso-8859-1?Q?D8ncdzuUIUcElbFHoP3ja9gNnxe1dQtBRFUAmEd2l8eoy1XC0TJKJbKK4V?=
 =?iso-8859-1?Q?+t9utqY/1F/vswEmezGl1FIQRFlgFPoWKG+DPJIovRjFieuV+IEQ4z1vcp?=
 =?iso-8859-1?Q?2gjeFULjBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LTUeuP2s4TgAK6BRlC6g4xuNf8nts3h690erTFrlxA7ZK4oOPrD+3x3EoYae2M2pS+9g1ZmLjUciJUaxMUBX69U4GIrWSzlmoLy1+Vp8giQHszCHAuMbya+k3Xlf9z8g5PoqbrWQGnxbV/oE4nN8Lfsyp2rPfwL78jB19Kx2qMxHZ77hn6WQLULn+pab+nnK2ga/b8N6BTlYYovLCVoYDRihuJ208xkvydgpZiccZ314tDtubN4KwDpSHuQ6hzVI0/sh5+xvo3Upuzhpwe0cBk9TlAJOGojqBf1QgRsfXk6x9qoyeGW0F3Pzq7dLoOTcQak2mB0saYW4YNFiWcXwkQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb91fb-bd84-4528-4e66-08deba17efac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:50.1013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtzRLSrFDQ9N2VB1Q1aHS4HaHNFsfoTieGPBI8VFFrqQ6md+wd2dR1kUOe+G5eZKyqoCcQUvXjk3pWmhjRn9zcS4K+ll8eSCBu143Y/V1So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6593
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/sd/aspeed_sdhci.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c=0A=
index 6684f8221a..d93093c4df 100644=0A=
--- a/hw/sd/aspeed_sdhci.c=0A=
+++ b/hw/sd/aspeed_sdhci.c=0A=
@@ -182,9 +182,9 @@ static void aspeed_sdhci_realize(DeviceState *dev, Erro=
r **errp)=0A=
     }=0A=
 }=0A=
 =0A=
-static void aspeed_sdhci_reset(DeviceState *dev)=0A=
+static void aspeed_sdhci_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);=0A=
+    AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(obj);=0A=
 =0A=
     memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);=0A=
 =0A=
@@ -211,9 +211,10 @@ static const Property aspeed_sdhci_properties[] =3D {=
=0A=
 static void aspeed_sdhci_class_init(ObjectClass *classp, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(classp);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(classp);=0A=
 =0A=
     dc->realize =3D aspeed_sdhci_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_sdhci_reset);=0A=
+    rc->phases.hold =3D aspeed_sdhci_reset_hold;=0A=
     dc->vmsd =3D &vmstate_aspeed_sdhci;=0A=
     device_class_set_props(dc, aspeed_sdhci_properties);=0A=
 }=0A=
-- =0A=
2.43.0=0A=

