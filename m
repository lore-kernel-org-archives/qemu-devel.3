Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE39CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8N-0001cI-UX; Mon, 25 May 2026 00:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8M-0001c0-Iz; Mon, 25 May 2026 00:41:46 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8L-0001Dc-3B; Mon, 25 May 2026 00:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM/vULmbNWx+nuWeH1x5TiGDxRKVDLwmO/lf5prCpI/pMUec721cO9NAEXIyLYi3AinUDRylh1d6fAiyLUm5y8gyK7VGlrorzN0TLIyWUnmORRv3UUwK/oiT+ycwmhATHCqdrlQ7a6wutVcwiGsFeweqzz2VpWU7qNJqL/Aq2DFSXaRgw/zMxdWpzRUgeytUJlYB4Z2KRxXRoqYwOUY7M0U7txD0fnLskyL43cBBokdAolxzhFgHu/FKm1EREQJNNu+AofGNsMibiO7VcXPGXcPLlt6/x4HPsEcJKMLrHyJ6Pt10eqSDMT29rfbiNB3ZNvJ+jNeCZ+4/X5G/3QBtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2n71ZlDLt9MQuuI71eZ/pBZNiQOH7d23zKXrsOiF4o=;
 b=kq8hIUNmK9D0L2DwJexTujv5THQA9y/QuGVeNrbeto08zd1eEwOZriO1K84IYHW94PMD3PYtqLePP7PiCLlgEccMm145ZtJK5DW82cAaU+LfDKC3dc4qpyNrhFCDJaflG8r8Fl3N8oeJftFMqvG4VOzIG6fa3jW0khvWgwq/OIoijJMQNDJeXFg6/4NfvmoNNy34oYTYmiTZaizs5637hd8NuEEPyD2xipExXRMcFhAEEMeIX1zeASWttcCJEjsd6UleKZIqzLpv2lnSAMoqg8BvR4LP4lcWA6mdQ+2WkaL8KwffE5VYtvznR+9J5C4bsr0ikx3F/FzXoRqh+bKQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2n71ZlDLt9MQuuI71eZ/pBZNiQOH7d23zKXrsOiF4o=;
 b=l7G5REi4wnip0WG/U20014wl9VffxIa76r5P+y5Gj3BCV5Lc5WDoouzrYTYRWflWbiICZEhOTms6l9slXYUCSG0WEIHn/a4Q6V8/q0HHDlsgn9uA0V1Yb/NJmiRPHW/ObwAAXGvQAjXAmzE5iOGkUgMOPhYyacb852Lvkj79kH5TJ3FiBYdLyg8tJBiKpitVcMxEoXHfF1n0mRWhw2k1saPUo4uhtOCvKfsWmjXD57xAEHS3O7KXdv3dB3VK/8KKreHYDTEhbl4qkc0XKFQPc/8yOOzkpRQno6/Dp9w5JNihIqSRidFGZL40j1QQfuhyBa/GcTyBZ7/tqe/iMmVvWA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:33 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:33 +0000
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
Subject: [PATCH v1 02/23] hw/misc/aspeed_peci: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 02/23] hw/misc/aspeed_peci: convert to use Resettable
 interface
Thread-Index: AQHc7ADDkjiTZHOh5kSjW9oKcR85Dg==
Date: Mon, 25 May 2026 04:41:33 +0000
Message-ID: <20260525044129.3133916-3-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: c1a9a1c0-a945-4c18-74b5-08deba17e5be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: LIVjhrLlyLbclXfcm8kqHBduyuMsU3rjieRPj6Re7s9ezGd5I4gtb7ufx5X+jOATQPjjCKgpamlS7Az9X0/MGm/+5zjvtG7D4JOE9GaeOCSjQKOVu2w7ptPASakbcY20W6+VlOqoCIDnS3IUns26icTV5t0IQik/wYjQqAoUX4lePCx417F3SupHHHWkI9aoc2mpLFudRgZaabUOZjhcgGVZj111bVwjPKZJr0dhG5l3f+wD1yLMHX7z/gpwYreYLEmixzPcr4+ha4JAeO3R6yuwgGNG+A0WMMimMXGzJU4BXv0KRTbZWPyGKaAUQxYnFEbaq72FTWEF7sLgJ7vwtu0B3WO0+ItbNL1rNHTUkGCTjCI0iSa9ExfWDAn86uuMnlMr/B2g7WhPXo4eZlk7c3MOznspeti0mRpbElhz/8VX72bM350lK6CqExTRBFn1/m7qkZtUwVS2HSIkbn7EkvdnsKO+bYMvKfGmFmdSkwsscaD66NM+YnbucfYddz6dUOhxxIAm/JX6c6N9QKthLpys9xRxVgmUBIKidQ0qGi1GywRjghqooCjJx8gt3c13417GeDTpZ5LQz37uQ1VUDy8YuXhpqhf9VM2evI2jHfHxOKeimfDxZ73FUAhved4wqy9PUIiAgrBrdBidpJ+xHtXxtfSSIpmGT9mNd2y7h3nvk55XyKN8RzJ8PTRooZxnzNha+rn/OysrRA63dk93QfEX/jaVa4XiSOjal287huH9L5ZN6T7hBUU/h3vxcYJxd9JD5tchAoxHM4VQXHQUkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p5Hf70RJi3ZjThLdeFbzrRpY0S33wbmo6Wem6ZpMVpWPospQqSDWfmI75n?=
 =?iso-8859-1?Q?9zzDv1NBeYFKpsLlcOu/CTC6XWqTNdtsWED5QsRjIsTJzB+5/dfTBd4UFv?=
 =?iso-8859-1?Q?kKDQMBmKzOJIxlY0/oEAWPILkrqKemZu0pfzHGob8K2d9ndwX03MRcE89n?=
 =?iso-8859-1?Q?Y21Or6iNysva2no/tSPPxRVV8Byf19tjuyPFEv39IxeADXmTb9lZ5CW1Ai?=
 =?iso-8859-1?Q?on9TrjcfJ0w0WJFPROw+hGpG+nDIRjlQ2GYGyg7yywTBsZ+4i8RoBqwhx8?=
 =?iso-8859-1?Q?YgziklzXv0xOh4+1fTXSbhBTRZQSwIQlyJ5h1CCfXTwikpcgVzUW9/h90t?=
 =?iso-8859-1?Q?lC997ZBnzgWB6NmbMRZj4sVGym6x6/BOQWbU7OqhyXolNoQDoeSvbE6X46?=
 =?iso-8859-1?Q?J95HbKF7OvKXi3Z9O5uu9Aom//V1YFtEQ/ICOCxou4M7KEH27xLXIhBsB0?=
 =?iso-8859-1?Q?nrvxAnC/vBoh/wzXxUYKEN4i/Obha68xwjsLhgtfKiu5NSLywsz7g6S5d9?=
 =?iso-8859-1?Q?vzOlGcfxI9SP/WSadJ6hKxlPGDfkIr98joWh3FMs5pRrqeDfYEg01ELpW6?=
 =?iso-8859-1?Q?Aa2fovzjBsY1rvYRsJh/UjIHpR6YgKNKicQNnUfBITfgJutMXdWa0jwnYQ?=
 =?iso-8859-1?Q?d8XTWQQCf9uyV0FbcNvERnQer80IZl2+OGJE6k/L0o2zYAHNE9wi6qBoUX?=
 =?iso-8859-1?Q?YF/7rVzWDs64GZCeMXco+C4RZ5AfPlndvJ8/9z3VJmp8HXTlLRcYQMUM84?=
 =?iso-8859-1?Q?NxCF+Zs+gIsu7UVJBzmEwa5EF/b7vl9o/xvYIN5UKjPujYHFvv6kVYYiu9?=
 =?iso-8859-1?Q?e+m81fhS3DoEIDgBXc8G/N0hXwzRYeM3nvxcIqjlkdnjW19an555sK7rOE?=
 =?iso-8859-1?Q?1hA6zhmYd3+0e8dOAadvUgiKqAaLdArKFFjSoXZqOBkASfPP3OKHxfP8Np?=
 =?iso-8859-1?Q?S7oH2LTfbb7cJdn1uSar0dMNSavsJnCgLBNqp+nCMHVNO34oN7AFiF3fgE?=
 =?iso-8859-1?Q?yUtMKud4sKbD/57P1HZpYC4D3y7k58d+whPLbXVZxo/EW1bIIXsSh5TNfC?=
 =?iso-8859-1?Q?HsjqgeTp4xLQrJPFNS4u1zF8VPpLeO5mFzpyrrOGfWgna6ynMmQPC/1jqs?=
 =?iso-8859-1?Q?RO82onAXKvpOSocAZwIUdLyJeiuTyccJ6avwmpzGjvf3G44+K1pLvtDq10?=
 =?iso-8859-1?Q?s9eW9W1BXVF0In6QGjgaQhBgmBSTqu1/q2qs9sWLm2j6D/h+ALX0pXXTNJ?=
 =?iso-8859-1?Q?KmlbbrrojnFyn1grdaY6pGZ8k8rLuulGN/Y/CbiN4eynPTS5QuXaHWqiKu?=
 =?iso-8859-1?Q?IlXrkW5GPVW4o8hh2lORb5pUllXfN62nCw2kTZoYS3E5k0kUXeJ90Uz4Tx?=
 =?iso-8859-1?Q?xFgwdiK0RYee2uGlyPGe1BqXdItyrPOD9YHFhGySg2+Fr9s6jLeJ3O4cQw?=
 =?iso-8859-1?Q?YX9QhHdgJLIwEEZnbh2QLKkSUXRmB01HqA8h1VN94MEUxh9ZCbAMJhL1BQ?=
 =?iso-8859-1?Q?/lBrHed/9tSAAVXiRdrBnyftk1IJ/M6EvZd5byJRu8fk3jGo4M50pIcU0R?=
 =?iso-8859-1?Q?0VpUMoTT3J6Zd+a2TGPBcNcCcBAcLG5PfAGO92cnp+MkQdeSyfqQpPPx3f?=
 =?iso-8859-1?Q?JCwlxPRE51q4kthgR+yT/DB8xAwNgPHfPAfRSy/IA5KkHFYYAFc0zqQLa0?=
 =?iso-8859-1?Q?H1haJaeBJewI3JTtTfP6IeBwVz6raF8XrKkdjRkC2SVCwElmD6Zo2p6CGr?=
 =?iso-8859-1?Q?7pd4IkpuRMUMPmvlsr6CrMLbiIieTrlMJyzxuHGZlHYQDfiqINxXPmCyDH?=
 =?iso-8859-1?Q?k1orh9heyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fxDHQi7h+kysoAtQ75lwO/mqIRNcmq9lJploNdMEsACEVdcFbwMNdhxx5nlhN3f6n7e2hcIioMzshZsWCz/u78OP8i0dahUxKjXTCb/vdOjcp9KXw7EJTcSy8tiohTk/GD9TWr2bCEdI2+YBIKqROTSkl7ffDdEh29dZqdhl/rPoy+oyJasLriyvUncFPYdV1XDapT+q1yLy0qK7/WyUzMpcFKCHVXcw7Z9PVwmgLXuptNDQjtRMWGl6kir+0h98SUKAdAYukJoMITvh5dGIEEYMjH6WBLQzkjwVa0+zfr8H98qY/JYpvgpSzjrBNyRl7VtlF/J8/Udn2R0CV56K/w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a9a1c0-a945-4c18-74b5-08deba17e5be
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:33.4070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adXBenJzuJiJdM4dE2OG5Kqh/YdtQtVA0PznLGQk2RQaDYM0w5bKY+eB6mbQzO1CbPCYlqwMkWgPmpIsAatraEx4Lfq/IJEPn9RYxL01H2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 hw/misc/aspeed_peci.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_peci.c b/hw/misc/aspeed_peci.c=0A=
index 0569ee57d1..7469f82fad 100644=0A=
--- a/hw/misc/aspeed_peci.c=0A=
+++ b/hw/misc/aspeed_peci.c=0A=
@@ -123,9 +123,9 @@ static void aspeed_peci_realize(DeviceState *dev, Error=
 **errp)=0A=
     sysbus_init_irq(sbd, &s->irq);=0A=
 }=0A=
 =0A=
-static void aspeed_peci_reset(DeviceState *dev)=0A=
+static void aspeed_peci_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedPECIState *s =3D ASPEED_PECI(dev);=0A=
+    AspeedPECIState *s =3D ASPEED_PECI(obj);=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
 }=0A=
@@ -133,9 +133,10 @@ static void aspeed_peci_reset(DeviceState *dev)=0A=
 static void aspeed_peci_class_init(ObjectClass *klass, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_peci_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_peci_reset);=0A=
+    rc->phases.hold =3D aspeed_peci_reset_hold;=0A=
     dc->desc =3D "Aspeed PECI Controller";=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

