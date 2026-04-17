Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAFDF8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtD-0002KR-Sm; Thu, 16 Apr 2026 23:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtC-0002Ik-9X; Thu, 16 Apr 2026 23:29:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtA-0005q6-M4; Thu, 16 Apr 2026 23:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+KbTHy2Jxx4h9HbDEomdHSrhwAbLEkOhIMBgeoESAeFJ0ziD3CeV2N5cyG/1tPV9kg7hBq41z39tTB+csh+4x4qFXcO5OlUvoaspoX2gax0qPvPi1qUcHmCsn21Tcp9dymaj4kcbyTuVLOIocfpWgIeRqEGzLQR5cb5ZTgATuXFZnxCoOL+O+wr4dMP/s2J7rVC0ZMXZgDEIVKWWEFLJ+9WlijGrmYda6IUqu4iLGkn9lh5FOMbWbBHJlUsdEytX3Uai4RIZBv9OL8SOA/OOTs6T4+5dsj+L8nVnMVI5GAC0M7RH5gFYSWgXwh1/jrZuwotiZsoWrC1kmjwwyZFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okdtxpjVP3phSX2NRzlscNjtC0zc9L+xbSVmFt/fApE=;
 b=CPr92eBlqIHwQp01laUQpEEG6ZJKZC049uZOm+qML1QjCS+8iI7VNK/ZtQpmKbq00iqe24JBP2cwxHDxJ3z7xIWTfFhqNWClxEiBtOfpEgakrXOIYOG18Bpb6vZLXXik42eS4+XbKpy84ujhKmuXBbcDMEb9k6OUdmt8pjPewHXI9XYfkostzYTeRpmIAcWHpC/T0p6DSdojP1mRRIa+i/VI36QAkLDo1b9qju+hdKfey0KhFE6ur8TSDxkOPWjdqZTPAZjBYpKoTE18eown2sCZZ4gWSkJMUpciTbPY8Www6qHPGHu8XcSQF2fjW6vMDn55FE0TrRSU31T1lDuKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okdtxpjVP3phSX2NRzlscNjtC0zc9L+xbSVmFt/fApE=;
 b=RWUQ44sxaym+n+SucTmucNmi1/I83Gb7DIv3xbLe4jsTZd4TKmX1gkelf1IOr/JpWeQB4Fatxy63upBqParcFF0B8T6GHitwAlG5oXA5c60ciUrksiBkRICnrO8dv1Kju3qmOHfA+54vtVhmCb/yhBrO3y2otPZY+yP1PmBhCFcQeEYRkHL/lBuAFteJddEFvgogqgrtNNwCkD3EKtYJb5fVECRazEF3BV/WdRuO8MKQNKVxVnIFuhSqf05/YzOBgc3CWGRMq+B1WrW76PSBwHGn9vc+qIpGXNNa8wm85h9GY43ggeBsKDlmcKueY3BdhB3hMtx5VT2P7/S+8JcHLQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:51 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 09/21] hw/misc/aspeed_scu: Add SCU support for SSP SDRAM
 remap
Thread-Topic: [PATCH v4 09/21] hw/misc/aspeed_scu: Add SCU support for SSP
 SDRAM remap
Thread-Index: AQHczhpP7lP3YZX350681N5dJHbE4Q==
Date: Fri, 17 Apr 2026 03:28:50 +0000
Message-ID: <20260417032837.2664122-10-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 6550541e-5708-4f36-6d34-08de9c3171d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: gLr6N/EIn4yC9LM/hmStWLNqpTrCiNh7hZ5/DuS+93OFB7tMJSNp3jCc9efm0cmKkWLNFgvKYqFErdXcGd09D3hDLYt8uYzUCW9daJ+Hu/5hdTds86vXP8y/RaSwvD+LAW88e5+GsG+M35riDquBqXz8DP2zfID2+h44uiCmZgL8NnIYaVJRsmw07GxsKrNLgS4BwOB/beBRyLmq3bRIeSZ6RXQlNPppxD9KK/m6oZSRRlYpFNSoZpWr6GgurmGgIQi+YCTgO4hvvt2UALJR8YtLwCellRp//fiPmaNvqShYJ3vfttZzKwMD4XdIoE9/byBX9ZftoGCHEgPux9Z555hiZPi4ua+MkjiPaNM+iRNRp4halspyK7Uenzjzlld9JfyCged7IO8yeAh2ndYtY0M28X6pSR+45EygXhw/o2goUIeacUX5/EOMqZGHBCrywZaqp48iGwNkdsQeUzW0t14451ZdRqodm2bWmYnr6BJ5UlL2Pf3PQkdda6ftaWQh0zfvB3OnCoDeYOzqM4kDgPMqrzpR5dJdW5HAui0jNd9JpYr0JKaAqIGnFJVg4vr48houcowLqFoe9pCG748h7mJJZWGqkte2XoeNHzw5FHXO+O1w+hYnZ2PYtbhx+p5AJp5LsyZi9kHhX7qBmplt9nxflixOXDXW2ra4FrjfSQDoUV+IKMYl6iE3aHIRw692G8R8bZrjOCtpEKRJVEUl4cgPZEs2U4fiBmFMWVDdzOIf8rpaiaXtOma6nN8nlE6BDyZad0ucx19zhhIisIhXHPohZ2BiTFNP1cpOLx19sarWYrqQ3uw9vwM7vyZTEPei
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hianGUYMBw7bS3+dMAHTxJF6hvquEzQDytCi1NUf/j1EPBGQE9hWeFD+E+?=
 =?iso-8859-1?Q?oGGtk4o4ZGNF8aE1v++61tHfMcqCQoqXEQlXuN669pUHrXFnh2JEmb637y?=
 =?iso-8859-1?Q?x9MAaCWsrViaSclow1lZIvUBBV0O8tuCb+Dfwn14Rv3YeVDQguDjt2rEOF?=
 =?iso-8859-1?Q?2cGIICK+IIjTbu7kfjORauu4C4v9sIn05PX65jiq0ikrlyTpTGFhzfXlkp?=
 =?iso-8859-1?Q?ehXMqszUu7FyYVMFj32/xYGOj6OFFkC2PBIkh7CEto3AteWqkM5fi74CMI?=
 =?iso-8859-1?Q?X499y2l6Ie7dE1f+FYS0/rpZSdyiaxKebHDtffLKjSAr1a4VwhEHczTj+v?=
 =?iso-8859-1?Q?DCo01EYD9PWZ7aH1RGLD3P2luq74fQ7KCq5bBhlXRRiirbkyqnpkTkKpSv?=
 =?iso-8859-1?Q?0H7dOKpNiuJKP1XwXQaXyPLiwdV38gci+swEP13fcrx8Pw3Rd2/95Z8jpX?=
 =?iso-8859-1?Q?mYb3w4BnwTs4418eELhUt35kbSjXp3lLfjRL+i5kCG6oEjD9O1dpUoTqxC?=
 =?iso-8859-1?Q?A6TvCFPHryD35oOmGW2HcONEevXqr8WwvHyGf6B0DVBQSw6AswIEbFjvJk?=
 =?iso-8859-1?Q?p7sEghfM+WH/Uw4yztWfCuIaD9B6Py7NRSOIK71Be8Z2WCiIogpJn1gPfd?=
 =?iso-8859-1?Q?PsMa2rZYuSaK1beQFMv/BMy0SKUWkeyh3VtXRdNgV6ub6Z0j2/9X+HyCgl?=
 =?iso-8859-1?Q?JnZUSoWw9uRXu/ugd9WHx1WjSVFLTfNmLOJZpv83brH9wUgeHTEVrF+c5l?=
 =?iso-8859-1?Q?bCZLqK/6GSrqp/+bPx+D5lYGPmEPZ/xpU41U0vm1bX5LFF5dMKqwsDLV9p?=
 =?iso-8859-1?Q?ro1g/kYcF12gEmUGfTa7ZjhUlEz3Tjws3meD2wGtaUHmuxZnL1QT50tEU5?=
 =?iso-8859-1?Q?TWzFu+AnO9FDTGMV3mNl4k+Su+Zr6SjLhJntLbEWkZRw2WEIbU9mUH+seK?=
 =?iso-8859-1?Q?/HCrBuRicxURinLN7OIGY5JzeMpCDPuihL5qkQu9qgWCajrsVUIeeTnLKK?=
 =?iso-8859-1?Q?KcyZyIFd5zCUCaqFp9JAukr+fXSw5246cr8dHBbWnqXJnBKuiKKOEzGoym?=
 =?iso-8859-1?Q?M9qgkTaxb33jUYq0FqQ8dhAH8FDhAN01VxdlV14Fxve/TNVQ+TkrlcySDG?=
 =?iso-8859-1?Q?ZdVRCFQKimOSJbqMCnnBP0petkqdvekh5wOe4zbrYYrITryfV8/Q47EaHt?=
 =?iso-8859-1?Q?nDiAfoNbM0ekTVQXUsqfie3KbgPDYgh/oNqkCQtwqKZMWm01+16eCqHGm1?=
 =?iso-8859-1?Q?cSnVtEFLrDrS5lZxCtmwSOLsQARF2X/Y7Mr4Dtle/hEDJGA62koQ7kkbnv?=
 =?iso-8859-1?Q?36TuDTmE3UDuXsxnHN4AYKUEI4EZle09o9mDD2YTWYupqeStm1XxVE793D?=
 =?iso-8859-1?Q?gvPwvzezZ1k1rGcbPpSGrxMWp495UIpZibC70fjifkrksDQi6kmRz4KUYL?=
 =?iso-8859-1?Q?Q0aFhJmrExRabeSR7mOOBJfxgvgepHuTl+Drkw86Mdr+f/ivyKHTGo9q9S?=
 =?iso-8859-1?Q?NuG5jhdagmW1DwDCx6r7rb7oTZHzhlrLXegXSGF/DrKtDskOoOYuNp9Sbu?=
 =?iso-8859-1?Q?X7xkJNh9aQBVMNOWddCufRJt+U+QKAbdhMtE1bu6a5Jxzhd6eMfnXy4DCF?=
 =?iso-8859-1?Q?4bVgYcPiwB+/0ArUd48Kd/SjlSXyejtL7ibujrBTvVuYBInJ0OKcHiC0oQ?=
 =?iso-8859-1?Q?9dv08CshOcGmmmfgIboesZLnWYQNoGcAhtUWMZtLfA0KJVcUhw+sXEj8cW?=
 =?iso-8859-1?Q?aUuCIuvsv6nqGYQbdtpk/NRrLD5COkN68DRgJNu2PIj89eBAhkFrfjvvUT?=
 =?iso-8859-1?Q?nm3R1ZfUzQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qt06daHbEPvVlq+zqiy0pWjGLK7U8irViCSGMiJmuUtivi6AAfLbbvS9sd8KBg+Z0TD9o1q5YhbhMosXvYw8TRCMi2FK/jvR2X1bserviygPudIYIYQ36U/JpBmO2S4cez7FYaYmtZIETpQ37KyyiSWBopT8Y4Di+sv9IKlprkNjQl5DWMSjfmF1p0iKHhHVUdw0g9VERoVTfg9wk08d6tYO6hhNL8XitXVdFislcOQpZKIIymxttncfaeIg6PV/jwxWNc5RWLZIUfJD3DVjUuAIB8bc102LDzwCiiCccZDkXjWFMJXtGc1xsfynsIXXCGY/aw7YGk/MmO06kFsHWQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6550541e-5708-4f36-6d34-08de9c3171d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:50.9755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWUUqvInF33qgn62C8mNOV1IPHEFE/q1UjGfrmi+7jx5rIdw/1xdzOyUkIYy2lf+l1Y2XGRAGoySDU0wPqab7g+GDS+OiBpCyM96neOA3ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

This commit adds SCU register support for SSP SDRAM remap control and runti=
me=0A=
activation. It introduces logic for the PSP to dynamically configure the ma=
pping=0A=
of its own DRAM windows into SSP-visible SDRAM space, enabling shared memor=
y=0A=
communication via memory region aliases.=0A=
=0A=
- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x400000000 (size: 0x1A7=
7E000) to SSP SDRAM=0A=
    offset 0x5880000=0A=
- coprocessor_sdram_remap[1]: maps PSP DRAM offset 0x42C000000 (size: 0x058=
80000) to SSP SDRAM=0A=
    offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_SSP_CTRL_1/2 and=0A=
AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfigu=
ration=0A=
of alias offset, base, and size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        SSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000         =
       |=0A=
|   remap1 base                            |---| |   |  - SCU_150: target a=
ddr    |=0A=
|   size: 0x1A77E000 (SCU_14C)             |   | |   |    remap2           =
       |=0A=
|------------------------------------------|   | |   |---------------------=
-------|=0A=
|                                          |   | |   |                     =
       |=0A=
| 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x5880000           =
       |=0A=
|   remap2 base                            |   |     |  - SCU_148: target a=
ddr    |=0A=
|   size: 0x05880000 (SCU_154)             |   |---> |    remap1           =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 54 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 54 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 6512b5fccd..8d1ad95402 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -147,6 +147,14 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)=0A=
+#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_0    TO_REG(0x140)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_0    TO_REG(0x144)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14C)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)=0A=
 #define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
@@ -938,6 +946,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwad=
dr offset,=0A=
 {=0A=
     Aspeed2700SCUState *a =3D ASPEED_2700_SCU(opaque);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
+    MemoryRegion *mr =3D NULL;=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
@@ -995,6 +1004,37 @@ static void aspeed_ast2700_scu_write(void *opaque, hw=
addr offset,=0A=
         data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
         s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
         return;=0A=
+    case AST2700_SCU_SSP_CTRL_1:=0A=
+    case AST2700_SCU_SSP_CTRL_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_1) ?=0A=
+            &a->dram_remap_alias[0] : &a->dram_remap_alias[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_1:=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_ADDR_1) ?=0A=
+            &a->dram_remap_alias[0] : &a->dram_remap_alias[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_set_address(mr, data);=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_1:=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_SIZE_1) ?=0A=
+            &a->dram_remap_alias[0] : &a->dram_remap_alias[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_set_size(mr, data);=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (a->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1065,6 +1105,14 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SSP_CTRL_1]        =3D 0x40000000,=0A=
+    [AST2700_SCU_SSP_CTRL_2]        =3D 0x42C00000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_0]  =3D 0x1FFFE000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_0]  =3D 0x00002000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_1]  =3D 0x05880000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_1]  =3D 0x1A77E000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
@@ -1097,6 +1145,12 @@ static void aspeed_ast2700_scu_reset(DeviceState *de=
v)=0A=
 =0A=
     if (a->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
+        memory_region_set_address(&a->dram_remap_alias[0], 0x5880000);=0A=
+        memory_region_set_alias_offset(&a->dram_remap_alias[0], 0);=0A=
+        memory_region_set_size(&a->dram_remap_alias[0], 0x1a77e000);=0A=
+        memory_region_set_address(&a->dram_remap_alias[1], 0);=0A=
+        memory_region_set_alias_offset(&a->dram_remap_alias[1], 0x2c000000=
);=0A=
+        memory_region_set_size(&a->dram_remap_alias[1], 0x5880000);=0A=
     }=0A=
 =0A=
     if (a->tsp_cpuid > 0) {=0A=
-- =0A=
2.43.0=0A=

