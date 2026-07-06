Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BBFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbrR-0003FX-O2; Mon, 06 Jul 2026 01:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrO-0003FE-O6; Mon, 06 Jul 2026 01:27:15 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrM-0007PL-Fy; Mon, 06 Jul 2026 01:27:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiAqQyXOPZcMjAPpVlRGyjMT+H1Xaoy43s0dX4oZweAsMLZgiGskS8oArLpGRMDontJfwXvFXTeDt2x4+ZScCOVK7GwcJuG3HfFO6tMo/mKgyk9l/YXtgEyRLQ5h4w54yumZwlpy1V4IQVD+T6K2HNoS9I9SltWnsUepHO0A4VTn3ALPhrflZz0zCN+2ouBzLj3RrRMFy/gMgqe5DGPQWQ5IqmeV4EQVJxwkYirH3YQmiwEUQBcH9T+esh2xmtbYugCftE2uwnldX9E8rsjB0E5etrGFnjy3MgpmlMVOXbTllIVtQu1VuxEs8/OxxoxkVjeQT0l/QYpVpMaxYVhnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpW3JmXtcrW589cPqx7ysqVgp0XJPtYexhATAAo8m3Q=;
 b=zULAj3KPlF1+mJBbHK3dtWa0ekuoKR7ksHDqh6tpxVkuSgWy3B2BL8J3sBG9xl5N1UV46RTN1TjDMlv2X9QG6Xeubf7Bv7JZvEsqJROxY6Geu+7XBh6jvnx4vzulFpHUMGgHoGCX1ERojpfqRoHrzCfIHkReLSIkQGxYlG4kuEbrr0Kak6w7CY0p7qm4LEDNJ4T7t2MERi70mtS5Sls4pGiyapg9+0DvqSna/neUmUVrV/9Hr62vxx/C54UerG2ACAIMq1DnHbzDluzp8PfHZYSAO6M12Bj1Li1GiDMYrs+Kk97gd02Z/VKFMh/AtwSpS9V7hN6kE3158jm+He6IoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpW3JmXtcrW589cPqx7ysqVgp0XJPtYexhATAAo8m3Q=;
 b=jYnFYyVgw5eKOqsuWHvu/5vWpXJTVpmdBjpPpdEGK4QxBejZA8yiCe8L+NQkfdHZ9U9tbqECkods24bAGPghH7Q7V+upD5UYPsCuOSzX+Udlf+Wuo27lv/rWWwn7a/3dfyDlQak9W7Vtk0AnWqQfFIl5OnzqxgEc/WUEQ2q9wfWh1qMyiFxyHjKpvwZ18KdasAEjNH4e30EZuBI1XXTQ+VZAfvqumF+FLPAeCNVr1R6mMSeIgApZ1gGM5bQ1wl/7cP1OKSo/WBsArzY4E7EexSWW3gqVTp3kyHRJRDzh5IphSoaXtqC8vXACSIzFlyaUDTq8KqBx762KpIYKSjgYsQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 05:27:02 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:27:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/5] Split miscellaneous changes from AST2700 FC series
Thread-Topic: [PATCH v2 0/5] Split miscellaneous changes from AST2700 FC series
Thread-Index: AQHdDQgTIkyREOEhW0Sn5KFrcZnC0w==
Date: Mon, 6 Jul 2026 05:27:02 +0000
Message-ID: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: 9a5dbc3f-a63e-43c2-4bd0-08dedb1f35c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|56012099006|18002099003;
x-microsoft-antispam-message-info: qBhUZFLs0YsfzSCM+bGggGKAkcT4YC6QrTfdafFHubQksuq5P4Hp4pWLBgHsbEYbZaV7TUmUXa72qcuQfAzd7ioWz88KUdLdu3AUXsD057GvPcaA5ZMJjtSWq5Kvs6wYxi5BnrHI6ahLQwdDXkThTrAQ/y6PFsuluL7vtD9xB6W2jSmj9kpk8wvALOd+cZAfRIxTMCCVOTNmoHiFPoYw0usMvuXtMP+/AdUsseCTaJl4pMnE6IhqvNLhDySVSTKXshLS8LPuTQVHmCr3Cv/uTmwkALJU/e1S+gH3AoKSTtJc7q7eJGF0xL0zuWFtOM6LJdyY+KmM+IRbUwmPeykzRDwPSn7k/uBQwxAfk5FU4JvUEvG7oJAEdlz8rpaqG0j6DzBRPWbZt8KS7oqoTfGBB5AAQHRZua13mLO17329mtQYcQ2dzT54EiZUgp7fcOTtytcg/0nLzPV0nkGBbJ+HaIfPoh5MSYgHWs3osWQOeDWx9CJlXRJHwCIr8vqUlC/J0As/rV+xMRuTzhDFVMNV9QN08cbSF1IuUUqQsu6OxFcvPD6rWejwUrOA01jg0rxWvMZWiFGEEe1AeZQiy4zI5EA49ueO0BLsXYy+qn5RNXOpQDYz8jJ9S+CZ/ONMNRQxexaVDb6xWeYRwHcaW75j92v3/P5xrQUzDsFDyBEg1thd4TaZlV7JF80aRyKAcbNTMlafCHQ13Fblnv6cfjlOYmB2v0pcHbuvTpSKh9xy2Eg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nb1XCjUPEooDcZSkqSCmqDe3lHNeA350pHyK19sU9MXc0UXeUlJWLRAXYl?=
 =?iso-8859-1?Q?7yCOK2yYgDxUvgUNlddjmV7y0UEUV60fp5JofoPnrHgy9KVuyCA0EK4bl5?=
 =?iso-8859-1?Q?r+7ULuQFOdBlJrag4AHRTPtTb+pIHUAuI1nsCzZxu9LPUFI4WiWdNIqh7o?=
 =?iso-8859-1?Q?4IwzmX/W+4Ialrf6kp4yFo6qS0f0p0jUXhGHIudq20RDO6sSyVbO1YYy8Z?=
 =?iso-8859-1?Q?cxnWCcvUL5UDe2/mIbZTedtsYFqCKZZJQ/0Oy51t24HwzDvORgIBwjCbgU?=
 =?iso-8859-1?Q?VN9DPaBJVMnPt10uFud4vc2ZS//o79nh0sPGa8RdRRGd0/ATj6aUxs/wmt?=
 =?iso-8859-1?Q?yRuDjx16S5mq+JIAboWMbAk0amjAdAma+k2+wcKiaP5L2eW/NB1N8FGMN/?=
 =?iso-8859-1?Q?P57FOs3QxUXL7UqgYOCbUTfuDrJ2y4igP+zBBjs6skIs1lVuFVlPgHU2VM?=
 =?iso-8859-1?Q?eivUZVVihQqtE+DPhjyxe9Q9YY4sq2DT/QSU/UoN9CuGlVVUJhQd2xUuo2?=
 =?iso-8859-1?Q?50vtArjhBlN9fsww7dC5wzJCutpqH/baUfDyb8TLUvAktc8oziSU8PM9pD?=
 =?iso-8859-1?Q?4QEo/iZ9aXfLq5/GnUmdBY9pyg6MkMx3mBQdHYwOyI8O6N5Kvgpt5kzoS6?=
 =?iso-8859-1?Q?oNzKzq/xYtoj5zUJIoUzCq/TL9tCLeK+4VyKtXuYWnkm5vhqRYujkEvah5?=
 =?iso-8859-1?Q?z0fbpifoO0o9uzIUDPbSFNd3RqyIzP6d4hEhEOywK2zXNnf/vjkCZNNJR/?=
 =?iso-8859-1?Q?/CaZnzuwx+0ZZBTB9jg5UqcdkBR7T/vL24j8BXwVfFybTnxwOaw3X1eGoP?=
 =?iso-8859-1?Q?T+B8K5U5Y8EjCRgpB1H2kJ1n9qHP2SUPVa/z3tMRCV4s9KXAGecHb84a1L?=
 =?iso-8859-1?Q?tQpeJQ0OKmUsvINMRMxle4BWc8fe7vTh4epW+6z81eacdRe4rlhzVcCGwu?=
 =?iso-8859-1?Q?LiFqXcXG8/55crAgI4a7v6+uvVVdd2rQjlGPqL0KCBGXRkpojcnyGMxoZU?=
 =?iso-8859-1?Q?CFrT7f0dSl18mlf+tbLI+m1/Or/UKtCLHdf+JB7hoajZhJQ5X1KVN5b+Bg?=
 =?iso-8859-1?Q?hbXVtgw8mkzor06O7oPMcF5rK2NlP29XkdbuxsChtRKBX8bberNT3g+V6N?=
 =?iso-8859-1?Q?DynkZlTvm1ro+8ewIQJZfRbybvWgH3wiPa4iLejFpw2x/IR8qE/LCj7ED3?=
 =?iso-8859-1?Q?XIHC1OpruKcAnX7XdPBEKCwaemgBlPJBF5lZXt/S1sfomhTPDBgsswAxAN?=
 =?iso-8859-1?Q?PQ5SlGTfiSh+t8mUDmAFSzt4/uQyQvOABLqYr7J529cQHPiqCG9rbRrYu0?=
 =?iso-8859-1?Q?6yl1Jt7h/ce9U0CaLtN4KRH+F4hM5SgNfultLbo0I0yjMixIgyF9aVcAC5?=
 =?iso-8859-1?Q?WRuUSsjYIyCFuxC8S61ehEGZJMQ2ejEey8glohqCYZGfsUW/OKqxdtlDI3?=
 =?iso-8859-1?Q?fcy4VFat5kKfemzMwaQjfx41TCpOMETOSHqiMra7qTe+Ws30mg+4+pNt5a?=
 =?iso-8859-1?Q?NpgoofiPubjO6RTgkuug+Zy8QVEVTaDhSUh6bFbrRg0nShKpJ70Lb9LmPk?=
 =?iso-8859-1?Q?2IS1pAT9RPBdPCFsnrDB9XLeWQgCU/sMvMIjnYQqleSmbBAifNtuNLNvU0?=
 =?iso-8859-1?Q?ymN01rY0K5gRPqh+37YM6uDYUsl+Gu4PSYh4htCJ2lK/Qve4BLE7psWced?=
 =?iso-8859-1?Q?U/qtNOkRbtXEycVfcnkPBuTbVjjOx5YXdFsYNf1hhArP5Zt73B0R+6oQV0?=
 =?iso-8859-1?Q?g2IzSSYWyKEneKQNdqnNC6Uykq/K/6KvfSZM5RZE+lyiexRn2gaF0NR0hT?=
 =?iso-8859-1?Q?DpmHMosbsg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g4M1fgqw1UmIW4Rvj2sNrmL80SqoI5QEFjb4b6d8oMXFq/JzxRMKcaOC4V/B2eGqS3+BOSy8yOetiokZXVZJSUi33/OdGME9iwUWKkT7grTLPCWVuZYkOyxh8csmiXek8pB/vjM6HvteWs68ed6f7ClAmMQOUA5pzoyTJqpuXmT3IRCs78bLgVVkRDqHdCEHTpvsyccOjt1EpamIH8qFDaG2pMsQamH7TBF2PWZku7nUkL65JvEdBCnIdrXM2u58C1VwePgCoib3DA+Up+zpHL/V5L9OJ3TwjiNAabTmetA7yD26qO12m1K8kYIVCScO/nN/lJhe0Duo8HGZ0JBX0w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5dbc3f-a63e-43c2-4bd0-08dedb1f35c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:27:02.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xz4wMc5yOV4HQ47ZwDoA5Vhjn7Ol4IjlpxyR5Z4TyZtiry3YRCvQENYPPjScplAgJON1hekYsX3g8mbNYI+S0BTSSRX2eHcERaTOQwObFZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

The original series contains both the AST2700 FC support and several unrela=
ted=0A=
cleanups and preparatory changes. Since these changes are independent of th=
e=0A=
FC functionality, they are moved into a separate series so they can be revi=
ewed=0A=
and merged independently.=0A=
=0A=
This series includes:=0A=
=0A=
Fix the AST2700 FC hardware strap configuration.=0A=
Suppress noisy unhandled register read messages for the AST2700 SCU/SCUIO.=
=0A=
Add the AST2700 SCUIO RNG control and data registers.=0A=
Add unimplemented Privilege Controller MMIO regions for the SSP/TSP.=0A=
Add unimplemented OTP controller MMIO regions for the SSP/TSP.=0A=
=0A=
The original AST2700 FC series can be found here:=0A=
=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20260417032837.266412=
2-1-jamin_lin@aspeedtech.com/=0A=
=0A=
v2:=0A=
 Remove ASPEED_DEV_FMC in patch 4.=0A=
=0A=
Jamin Lin (5):=0A=
  hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings=0A=
  hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700=0A=
    SCU/SCUIO=0A=
  hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO=0A=
    regions for SSP/TSP=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions=0A=
    for SSP/TSP=0A=
=0A=
 include/hw/arm/aspeed_coprocessor.h |  2 ++=0A=
 include/hw/arm/aspeed_soc.h         |  3 +++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  6 ++++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 18 ++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 18 ++++++++++++++++=0A=
 hw/misc/aspeed_scu.c                | 33 +++++++++++++++++++----------=0A=
 6 files changed, 67 insertions(+), 13 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

