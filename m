Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E9BD172CE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHe-0005vi-T0; Mon, 02 Feb 2026 01:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHd-0005uX-7u; Mon, 02 Feb 2026 01:19:37 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHa-0003MW-JX; Mon, 02 Feb 2026 01:19:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfvH1kPuoA2flnvM0bBxj5mEti3WDtQ4yoAmjBZ+lg2wAoHeWe6dtAFpAdsrZCgjgRfCUNpgMJmSSEySPuHb3eMyhdqiZOra873jdoWXPbV+qkj5fDcrGs2T+TBtNMeT+ONf4AvbS6F0dTgXPjGDEaTuYnVsdrqGbuohrQOqszRh3orfrzeUfeVAygGM+Lggb+iRmXlKAxHhmG3TwRqY4XBdEoU46mn0ErtCqsYmfVdpe+b/5DRKI5QOqGztAum2Xx4nc6oxkdoLOsrmaoLNQhoxYzHbODkMTcRRaZEXOoBHzWoKYQz/mngAD7v+1oNONyp73FXuwuOeS6xNy4YARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmq7YOalWCpa3fkC2oATmJCz9mbX6YBIGFvKH4x4BXE=;
 b=jug+dnv7fNULhvyzEmrLR1fcVrT+uiuJXwFh+XGoD/qtuilXyJyayGw9kV8A6Q5vOfw+Nx+FdY0/XeR//gBXACzFARxB3XcVUqFbob+5qVQNYz+qky7mS4f1tWwmY2rrGR6ILDNEqYamVJsZVHLejtY5Ds92hMf6jvWGaJ3TAB7TkFQD9sUIugNS5MATXerbsHXB5b1c/avhUpRjXc0I3PZhHallOb9915EvPiZRniNP+twx0qchKfafn48hoc1a3hABw/wZ6nZ6UqPSjBVGzGfRTQ9ZO7M0NeAbh4TZzWrAKMTEYamMPC2s7U+dnURbrEPjFHCfHUZhfuV0jEb4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmq7YOalWCpa3fkC2oATmJCz9mbX6YBIGFvKH4x4BXE=;
 b=EsIQetJTZTyM0A/9Ud2pbCswQkReaPlvNrPzwNRF5QLtbEnsz6Btg1Snzw8y4Xf1MrKXG4o/4+uNgSlk4i3mp/vsJzjwWQYmO9+R/69wqLnyf+lM8Q6Dy5b/oLDpTWZJ3qzHVvwy9tYJgk+in/qdNcf0p1Ml+3CmKoe0oDw2QNzMKjvJZWjXLz0IbGY62d7OWawPdcAe0rNqCkwQ7SU5BpzhmOGcaOTLtWQb4OzDClHKWsUZ04MIOYIqxKE48nPw6Qv/ZQIeU5y5dfQditPuq8IBTrcGlYG5JiYPM1jclDMVWXNwuBeNKKB5W44ZGGmVgnvpJwmlQMk4zFYRKnpWdw==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by TY0PR06MB5127.apcprd06.prod.outlook.com (2603:1096:400:1b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:21 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 0/8] Update test ASPEED SDK v11.00 for AST2700 A1
Thread-Topic: [PATCH v1 0/8] Update test ASPEED SDK v11.00 for AST2700 A1
Thread-Index: AQHclAveT/dWSLHLHE+hbyZCdC6weQ==
Date: Mon, 2 Feb 2026 06:19:21 +0000
Message-ID: <SE3PR06MB8199F4B0069F9326034585D6FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|TY0PR06MB5127:EE_
x-ms-office365-filtering-correlation-id: f33bf690-b10e-41a4-ae13-08de62230145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KbN2heRdYO4CdUF38bGaB2djr1XC4Akmyo9K3kLXsMGFo1KYlJSPdJNaJiIl?=
 =?us-ascii?Q?5VjIPpT1YnY33yS6wn7VFyR5oSM+05gER/EcRhTXPYosHw8vn4/+KPsGPytc?=
 =?us-ascii?Q?AO7zXa+DhDpMAnkNwfrJGN65BV2F1FQfOv8LzV7uumd+Ocyl7eb38fFmiuZZ?=
 =?us-ascii?Q?c5t73Uj9PibFmJdltUL3CuVZsyL5rDl0eZZygsKppU8KqZcZEKuMCeMYpsZr?=
 =?us-ascii?Q?pdeH0ci2Wo1Q6svaNcxsdGqCZkhpHxwlUmzwX/HuxBLbunHr0Ldp5bFSv0jr?=
 =?us-ascii?Q?pmUB333RqifS4chKWO4Zr8g1V6IJnSszDPwBv3mdY76jNY6OaBo1ZNbW8kbR?=
 =?us-ascii?Q?1tIzoLuN46c637GPqZlEP2ZbkZpiNhgdJXn8mQKj7+lBGc3zqQU1Y2F0LONc?=
 =?us-ascii?Q?ImIlnKvIQHEvQKdVkCBpmiBCI/BHt9U88wTzXxiRtv82kQBIIM2vmbHu97eo?=
 =?us-ascii?Q?6ypYpv0svxF47uAiDN8od+eF8bB7v4ntbAObs0uvc8aymevqBnRyTRwo5Hhc?=
 =?us-ascii?Q?hsowQf/uMZObr4S7of1dOKOeCK/NudSxSQhoaEZMY5Q1SxCzo6g2TncLaMGb?=
 =?us-ascii?Q?Dl8qcRVLGNl08hg/+Th0m6MUwuZtXk7K7mNl9y08EVUWDpfynYjCHvOcauK2?=
 =?us-ascii?Q?2oHRFca7OEiEyfEj4TOv6MHQt0T0q5B44L88vcNFdFRvuJoHNVzOBxmFv/4R?=
 =?us-ascii?Q?JtGXpV+kVXw3jtZQZbVfK92kvvU/dQkwCds1NznKLJSRDSzDMOXPqj/yLeJx?=
 =?us-ascii?Q?pW2Tu8JogKuszZHAozfmTOmTxX9HDQInOyx5SZiJJTAiLi9p514Vw4wFlAZS?=
 =?us-ascii?Q?wOzJnX/8edtnlCDgUm8Xg3Kmb5zGBcxJxhDUJKEHBWDq4WxJQWrGkq7/1Kuk?=
 =?us-ascii?Q?odIH9Qkm9miVgQe9TL4usk238ncRdqMhJ0SKhgU8q+IfsVgS0WM0lFqlSdYh?=
 =?us-ascii?Q?+nCozvqyHPm632dwaNccX1Zh19jl4f7oIHlc2NJdNP4fs0p2lCrwsqqKkNuL?=
 =?us-ascii?Q?jdyXXr9HuJAOa2hVM5KTXwmUkgDlna6CGD6reKeGrmipjIDVeLP/sdCnjXmD?=
 =?us-ascii?Q?idF6X0+G1lm49v7S1ndRi5cX9NNFu0eLQEMUjpIf+BMGjkIIaJf2A6Pvdgtt?=
 =?us-ascii?Q?CexqGTPobDOomIQcrwk/Y4FK2xjld0zTodoXotGD/UTBf2wb0+Db7Khv+K0K?=
 =?us-ascii?Q?DwmyBtxpRhleu5wEgLGdQgIKO5Sf5XvCnmcGVWXOv63YnEvHDZ3yU53CGqsT?=
 =?us-ascii?Q?mN4+7xF5MIZVE8jmVmAuQkgxsMtGOd3k9S9GMPr2CxPLKE9GS0/gjTRFW8TX?=
 =?us-ascii?Q?1cEA7JPRStAyxQ6LpZT5NIr6IlX4wjBRx0WCxmQAIjdEdER9HZVPHZ089nKa?=
 =?us-ascii?Q?T0fqv2UIlje6+PlGOYEMT+Mz6r/XuWbGx4/f90zVlA7DwbzyXNiIPJ7fWeQ1?=
 =?us-ascii?Q?SYFSKZrE9+XaTzo36UOCGofSlIMy08MVHUYefmwyhcIecT8AXy62cV0P/79A?=
 =?us-ascii?Q?qfsh0Jqgd+nS3zMRT0CzdaMx574tX9KSTfVhAGv0XtJ/N2pVsbL0cnEoYCZB?=
 =?us-ascii?Q?qgbXR7KMpJjXJXyH8X5R4m+UcLLNEoYskoIwFJy7fdaQbHM5I+qt2aI0CybC?=
 =?us-ascii?Q?grYvZ8CtmdM+XiJznYrFWCXB+IrEz0XiBMTjjEIpwuYh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hYyNPASs2j7naODKMtnjIJ4FXKmjJnKKzKoHsLIID8AGaKGkrBPHeBeGuO54?=
 =?us-ascii?Q?dcv4sJflDSDvtahDgJ10HltQTejn7ry6qxIMjSX0a3yl48sZO0Pgg0HyJ5ag?=
 =?us-ascii?Q?YGdR4MhGy4uveD0AL7vzfs4cRtmu+WrTrYvrygBTwH1mzPUGL62OiMVTJMdB?=
 =?us-ascii?Q?buBo1NcZq9nRJzPRLRGGAh9F5TE5/yrakhueX10k8BG9EtYr5LSqpf1kUqHO?=
 =?us-ascii?Q?xTuvv/lWhB9dBqVdE8H4OqFOxiMGQUqbB3zI7h+Lo540tTb+vTDgremZg5P4?=
 =?us-ascii?Q?Da7xFzK19+w0iLfUzqpAo55BWIZE2Akukp10owFIQeoJW6pcz+P5PC5B5aHU?=
 =?us-ascii?Q?IUCFStPF42/8YrpSU4dPM9CLbaX7TcGGc4q5ec8wsTjodu50Jmh8r6eRCPK1?=
 =?us-ascii?Q?wxLXFiV9ZuAmWJ+sdJ3tpSHKxv5AE1AN+Vvrxn9IXt68Lrh7L9CRXHLisimX?=
 =?us-ascii?Q?sjEwsNBD9a9B5PA305aLlM3Ah3pPWkTbn1B15hdM4qUr2vmujrFcpjdF2cwD?=
 =?us-ascii?Q?3XLfhZvLfG7g4XmEZDA4aY7Wa8PopPRwuUx8NnhI8PO/2IU4xDU08agf7VOi?=
 =?us-ascii?Q?+UagZdXXStpVI4/OlJjIfeLCDj/HEy4xTRqzXi3WARsAOXRNc81GbDn6Sgxy?=
 =?us-ascii?Q?5pNEY7HWFLDcqsAZeWEBlO7yFLZ7LwASSXmv5JHwU6gaYM+5pFQXGKIowkku?=
 =?us-ascii?Q?3IBes7UoOETJ6scLOZMVcTBHhKyp2mrD60WbFpXsebv48U3H5D9XYkD80VIV?=
 =?us-ascii?Q?JK4z8rAH8Yw9bYBHMVnCxBOkUHKwfWGajxFGEKKVAl6FM2zcylSisYnRLB6k?=
 =?us-ascii?Q?5HA4nHb9kZ84zdCGJBB/a9/lOzlTTKYe1IJJ4pceTOAPgeGDgGO90jt88jXI?=
 =?us-ascii?Q?VRMYgHwJXM/j/Mub8uYb7X13FS4kxvAUqLuNTDs0dYZvqdeQX7mHhbRu09q+?=
 =?us-ascii?Q?TgLgvRnyKl/X/Q1cPMMQPBKju2c+UrPzrf5zgL8aDMqyyTMVvNH0/6xnnUvi?=
 =?us-ascii?Q?mYNczz7k5CJo2KxT71YnZP8HMXKN7T8+of3j8SAGUz7ff3PZnHHRnTSw/ya2?=
 =?us-ascii?Q?Res61D6Cg9J7F+79jm44Pem0zZgdRmEI7Px6fhW1H7aE7J7OEeNybZp9k5gZ?=
 =?us-ascii?Q?+nMYnGOmazmF7JGQZWCCzqpGx2ot6ITcgDR07gbhDXivo4PGEeJR2Z+Olrgi?=
 =?us-ascii?Q?Ylc8DzyNcK/hvr16tdI0vljyYNeTcAlbgjvrruB7eqk2qI5fudymjCXEig38?=
 =?us-ascii?Q?oZqC0+srDdapo5rUP2UA6xxhlU5jFHzzCpHgERBCFmfbptf9Mm9LxvcYtpdl?=
 =?us-ascii?Q?GUxF1l3vrTiCOA9bBmHmy0PybHtIpdvFiEUL/aqrBWNH9D/gGi/ssD0+ADzY?=
 =?us-ascii?Q?+1BcSW2EVbT1nhFeOC8ypPbOmkDkQCSaMAR5O2mK1qsLUYxasTtYVzyrhY5m?=
 =?us-ascii?Q?08tENB2ajFfYKgG10CK/trrfwtAY5ODGbWSVkleHti6m4/FY1lBWvfnQH7iB?=
 =?us-ascii?Q?RtGw/wRuQykLgeW+khiXjS20hDwMXL77htW5OyJHZ3rJR8SUclxlQprdxd30?=
 =?us-ascii?Q?6YHGYoLgUzNwkJE6LKTer+tWBmnoPhfcugZfuLZrSx2poetfnoNZqFe3knlH?=
 =?us-ascii?Q?N8/bvwqT2t7+YwSK7msPVtg870wh17cMnmKdkeBqYTjZ+8ocJsWdTa17dw2d?=
 =?us-ascii?Q?705ean3whaNIFpX+nrJKjQJL31dQ8lZPcSTC93EZ7Urnpyi40ygCauUeidbw?=
 =?us-ascii?Q?q+y6QmADQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33bf690-b10e-41a4-ae13-08de62230145
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:21.7841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH/B1L71bG8zszFWRkSSQB8nsZVcTYIjt0jKjprTSnmLvYZriUAg80YjH+aveXTKQBoOktwSitF05lxo8bVXwtpdwxpxrcyR5GWeCGAKt5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5127
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
v1=0A=
 1. Update test ASPEED SDK v11.00 for AST2700 A1=0A=
 2. Fix DMA moving data into incorrect address for I2C=0A=
 3. Fix EHCI3/4 IRQ routing to GIC=0A=
=0A=
Jamin Lin (8):=0A=
  hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC=0A=
  hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap tables by address=0A=
  hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps=0A=
  hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Enable PCIe2 DTS status=0A=
    for AST2700 tests=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Update test ASPEED SDK=0A=
    v11.00 for A1=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED SDK=0A=
    v11.00 for A1=0A=
  docs/system/arm/aspeed: Load raw U-Boot image in AST2700 boot example=0A=
=0A=
 docs/system/arm/aspeed.rst                    |  8 +-=0A=
 hw/arm/aspeed_ast27x0-ssp.c                   | 14 +--=0A=
 hw/arm/aspeed_ast27x0-tsp.c                   | 14 +--=0A=
 hw/arm/aspeed_ast27x0.c                       |  2 +=0A=
 hw/i2c/aspeed_i2c.c                           | 87 +++++++++++++------=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 78 ++++++++++-------=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 54 ++++++------=0A=
 7 files changed, 153 insertions(+), 104 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=
=0A=

