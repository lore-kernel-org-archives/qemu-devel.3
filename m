Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A77CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mh-0001rT-Nz; Mon, 12 Oct 2026 02:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mZ-0001ni-0c; Mon, 12 Oct 2026 02:45:11 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mX-0006MT-54; Mon, 12 Oct 2026 02:45:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NndwIpW7+eMJDe02Rf3czMme5a6wnDI1EGKiAtVB6cOtYVeIbbHRdGOhuZPBHNihpZyUCCHXcRFYY/OCYXK0J6ZwTA0tbUpCVTB+ysVXuYxH7dRuU4Xw1JrxtuEjb8kqgYwuuUcjgXpE0P8/0uFZBnZ8+dJ71qYZs5XTrAGmtE0s5DdC9u1F8UuBusyz6lFljQKsxrPf8EcO0p/9j9P7fQk+QZEXlbd91zHDYh8kVYaVUOeLslSNyGpNGqmFrnU6Oklis8iJomh9c+XJ3B7boAgTq6mHEGUTE1PHk2Crp/rMkciXgD0wbFGpmXO1HsSXRc79Rv+OZM3feE0WlP962Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+TSM3tYZif/qzmj60F+nUo1Br1BD5fdIGVLPMR0vN0=;
 b=lPPMTM950VuO4PDHmj3CWtpaqOCFwwpO9nLa76whmC86Re+tZR/4RVJQcxyonaf1l9J2H69SRex4eBaIrxB/YWYNm15lsFJPvVic1P00/DlUefidAd4kISsjKhcJvk0ukpl62e57Oid/VLFxUyUnHcAWXkNxp0Y+litOw4dMpfLs3jV/G53CMRa1nqFv3SKS+GiJWJbxB6kOcNyOApvGPPeIx4gec4wUTul8cdie5E35j/iNZesQtilszhGfSs2s+j9Nkqkk0cfdCQGoWXCmy5ENe71fmjCzW7oNqZxUoCmcQECbCCaJDGa7NFix9d9yGeFHNSNduL0FwNDc4p8kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+TSM3tYZif/qzmj60F+nUo1Br1BD5fdIGVLPMR0vN0=;
 b=lHsy8Mw87lg/b4MtGR9VlazEAhLx4rt+68iQAlx86lN8m10ploGWMxbtQR49ugVVltB3wKT9LD5CgT2fUE3xK5pOeIbM5Ukz60Ydq6xnGK5YnOvDQh94SKDdXmZYnOjt4KJqNKTWa2+s2OM61LapJCsMU6UCKyMIeZE7JKfMZNC4tsgY2qZ7PiyOp5vqwHXITw8YEN/xfCFoumBLMAIAMSh3SOvL49pmfuYbhF1/SRpbom2zQXfhk3FYwOOtJI47opm2nR/GgJe+x0Jr7nsJPSYzfeJX9Y+/ajURTlCnfm1oiL9pxsxvrh8i/6Bes3plL5K56RQgTs0o+i46vhFM3w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:55 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 08/12] hw/arm/aspeed_ast27x0: Use a table for unimplemented
 devices for SSP/TSP
Thread-Topic: [PATCH v2 08/12] hw/arm/aspeed_ast27x0: Use a table for
 unimplemented devices for SSP/TSP
Thread-Index: AQHdWhUwzzP2nqa+w024lSzGfjpCMQ==
Date: Mon, 12 Oct 2026 06:44:55 +0000
Message-ID: <20261012064445.2571633-9-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 539e56ff-0599-4e0d-c5c4-08df282c535d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009221227099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: uKOqJ0Poq1m/7ml16ZAhN9pjAvUnEzq7gHaCQU5GYYrgm4EIta+5vS1jSldoaxjMFwSOOKHxcIbMhrJOri06Ik5pgS/G1ao0csgVHxoEk/eSs25kDc9PPPfGpxMwDpGPMqyu2wIt3RyvUZUtNScBoFoCNrV+uMWySOdnRPZHxBZk7CD5AcAQhIkmvYuldmfWsRdK6lIj/eso4iEdYGcNWxDlyFmm3I1HFCnha007Dx7WN9SrlqHnYsvtziAF8wYAncFz7QWt1fIYLivcV8aIEgAIQAUnjTfp4PW9xiYOWgScyAJKQkG90TKo9f8HJu9uYHaVqcePZQPWnRMdbZNJwHCOO/Qqcj3d6sLkvSIiepxjsqnmtaSUDsrzMlNYX7xwJ4iX2w2XV9nKdw3qs/s6L4CeT6CsvZ9HvsD+GvFO8xJKECUjXimv5symiJ7VUXteOm/AIL177gfAyOm6MezZSh0FbtCWrbiyv5ORWI/n+RmjAF/9vDvVZE7UO95cxKdtbimE1z/zl4C466zCMkzV/geNfVZGHlD/Rm+xEuBBJ+eoKGuRe2EkTID4UZ/9MlMpkW449WSmQ0hIQDvOAeJBRxoLG1fB0w+QNHfSAt9Ut+wQQviZTXttkll2HUhyL7DD8v6SzPFLyxbQvn70UO3zFg/wiUVvymGnbi7QtLPhjWAYpB5iFx8szK9LBKA4RKm+jSaIXMCVp5JPfO7+j8naE2shQjGbQ0N75DsmQzLlnmeT5PUESXzO/QB0zu6ovQgn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009221227099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xqW1ZUYu9k7j9jAZiD1qsA7fx6Ux0IzMX8N+YsfG8CPEhb7WUhTFTPyQ6M?=
 =?iso-8859-1?Q?7odmYotymDcj+NyV7yRpmdxcZnnv0cjSTYuUM8Zm9+RWGnsyL+mTX3rSx4?=
 =?iso-8859-1?Q?wDSL3LctTy71hxgyXCn0PdXKkmVXAaB6+3nyf9W8GfP/HN/FJ3vNzxwL5y?=
 =?iso-8859-1?Q?1UNFDkySFUJe+v6YGNfacMzWpmAGkhsHv/N9QSvSSKH0Ez3XPF9LaXr001?=
 =?iso-8859-1?Q?jH2EILoQlo9CEE6JV0JBIffVNM6B/YofeF3NGZYuKwLMLVvm1fHLaHSOrl?=
 =?iso-8859-1?Q?e+b2qV052HzihW0LMZjP7gKgyCkWxwKSNyOtX+A4yNIrp/5uTYoaHDGNzv?=
 =?iso-8859-1?Q?1AX/lGyWJAG9u8ttW4tVnUFpBhJXp/9X3dZgkJFTcdEZhQG+giNJUGAPM4?=
 =?iso-8859-1?Q?7SOU7MwbFNjCqLy80P23gR/kwX0PmnncU5rQgPe+OjWX+YgYk1RnoSLoc+?=
 =?iso-8859-1?Q?gWpvqxGoL7MIDHavOSVm7hE6pYg0D5O5lMH+zzKxfJsXE4vsHao75NDdsj?=
 =?iso-8859-1?Q?xbZ89wTjVxuS1cv+PUcxqyxkJt2XhDDg9rJbsok6Kutn06CrEhGysDmzRA?=
 =?iso-8859-1?Q?0XSZsnigH2CsDa1bEwa52xxTFsMz2HnOYtgPYyxpzoKsJOGH7PzgVLLv8a?=
 =?iso-8859-1?Q?rzPKfskw5o9iRVxZmpdiCx+Z9hNOBVgreLa5C9Gu+vu3/l2dZcodkQ9He6?=
 =?iso-8859-1?Q?lslCW/MUb++StsOsN19/upAz69idYQRNQZ0Nk7q6arByMrXJPR45ObBmlc?=
 =?iso-8859-1?Q?1y9VVoUIN3R8/yJRpmGScGBGEfHhtwWfl6ce/TOdF3T4Lj23encUJmGBoQ?=
 =?iso-8859-1?Q?7TaKHCEhi8SyLFU4ojxZEZbCaN+QwlGTqg/B8/eFH9uTEQn5UKuCN7ZC8k?=
 =?iso-8859-1?Q?3Mu3YYD8mhYrpJNLkqaPni6ybkOb5S59SNsr3GeOlqlWwNDnfATIfjkSQ3?=
 =?iso-8859-1?Q?vUxd6IKZmJfrwC+nhwUQo7tRqqAwE0wEezhNnfL+6tW6IZc2axT7OE+zGX?=
 =?iso-8859-1?Q?BEY/eQgzZyz+qZqMvU1Nea4XMyZv9HnXpZtdjea4QEtZqKP6ZjUenH3NeS?=
 =?iso-8859-1?Q?nfOKzvtMuMBSLZhqRMEHrFEk7BmTnrj58lZayxL3Y22bnP7v7movruMjC4?=
 =?iso-8859-1?Q?AoMQ9XNfzoFjSl7O2vZfHBkRRFKIOrKkBl1RThhPDlm8UujtlUCRIfefE5?=
 =?iso-8859-1?Q?Da1VYTCB5cxSz+Hqpt+7yEnCOf/WBKDpoe7YxYFeDx1N/7UyZg7NupztgS?=
 =?iso-8859-1?Q?6wu+u0Ejctb6KaN0xU4VNSV1Ju9/GC1GS7PdTMnZ+q4EPN9URxWk/Qn4FN?=
 =?iso-8859-1?Q?q8R3b5PcnGHd6yfE1lV0vsgC30IwPBmK3Qzs1ga2sAKBr0eTKHtgd14opi?=
 =?iso-8859-1?Q?B92n1e1sG9nRUs6EGOdg1ytwjLz96SuMVxh005yxEiUJkaMQHmUfvDIAxR?=
 =?iso-8859-1?Q?lGCwq+G14KJrhqbSbwxOcdAMkwSTzD+1Vr9MtVNH8DWhR4uQ/3732P+0nS?=
 =?iso-8859-1?Q?yDls+qQ4Quaulr0yMjEywOQQxq92WzgWbsKljsMTLmJgK8NaisbYkcM++c?=
 =?iso-8859-1?Q?z2azivQ6zv0XVt5J0zg/oVzPQ0dcbS7iX1w6Kp5dNLmBWGC1sZnFGoS9jA?=
 =?iso-8859-1?Q?VC+hjsUQeYunro0BakPSvAWkIp+uLNZMI7BFK01vTIUI69UEQxr3nreHGU?=
 =?iso-8859-1?Q?rSY64WsDLGGF29XrfX1r9EaP3y/fulsTlVvbJl1XlpTSnA/dYbYpVQ48kw?=
 =?iso-8859-1?Q?OUJmLdSUqilM5eOYnTBf/hxzz+ZYxQD9N5y34LkearD5c98mv642ZHNftx?=
 =?iso-8859-1?Q?yi/HDEhfSA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mnQpO+rl4sX1VARYEExYujnICFdP65rhInhltsCuNU8PuD5Ggi5zYl6do0aeBpSCvaOH7/mLY9U3H47iz5CVBrE7gsBeWGdvJYsPzqnqJtBDi2/I8wDOK4XixcBl5xldDEUBatmtLNeWyZIqGq0L7idxvB1T8PPRhJ0qXujoT6LauVTrudzWwAKWv1tUImf1d02X3TP24D8odxl3IWva9DDY0wZxkG45QKxs1Dl4cgnF9TKxHTJYwe8q9tSvJUWVqrDnfvnTzYgIXkIdnRbavcnOBKM/gTllRCw2EZmcw1HUBWfAOa7miH9p5kFqNB2yhfUD9Fdcopq+InMTK1L2dw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539e56ff-0599-4e0d-c5c4-08df282c535d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:55.1912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBYfevEJyeV2rNzFdPnp/Vy+Cf2hqDmVkzafnD3oSNjwkyKCc+si5qKI8/OrOOhEaWVH1IjEHaDvszp2moeSR7eEmWC2pMwAaKofZD82o2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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

Before this change, each unimplemented device needed its own field in=0A=
the coprocessor state. This made the code hard to maintain.=0A=
=0A=
Add an unimp_devs table in AspeedCoprocessorClass to describe the=0A=
unimplemented devices, and use create_unimplemented_devices() to create=0A=
and map them. This makes the code easier to maintain and read. Convert=0A=
AST2700 SSP and TSP to use them.=0A=
=0A=
This also fixes a type mismatch. SSP and TSP used the "timerctrl"=0A=
field (AspeedTimerCtrlState) to create an unimplemented device. It is=0A=
not used for that anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  1 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 44 +++++++++--------------------=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 44 +++++++++--------------------=0A=
 3 files changed, 27 insertions(+), 62 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index acb8b06457..39209d2579 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -37,6 +37,7 @@ struct AspeedCoprocessorClass {=0A=
     /** valid_cpu_types: NULL terminated array of a single CPU type. */=0A=
     const char * const *valid_cpu_types;=0A=
     const hwaddr *memmap;=0A=
+    const UnimplementedDeviceConfig *unimp_devs;=0A=
     const int *irqmap;=0A=
 };=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index e03653086c..0238dc3672 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -101,6 +101,16 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[]=
 =3D {=0A=
     {169, 1, 9, NULL},=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast27x0ssp_unimp_devs[] =
=3D {=0A=
+    { "timerctrl", "aspeed.timerctrl", 0x72C10000, 0x200, -1000 },=0A=
+    { "ipc0", "aspeed.ipc0", 0x72C1C000, 0x1000, -1000 },=0A=
+    { "ipc1", "aspeed.ipc1", 0x74C39000, 0x1000, -1000 },=0A=
+    { "pric0", "aspeed.pric0", 0x72140000, 0x1000, -1000 },=0A=
+    { "pric1", "aspeed.pric1", 0x74100000, 0x1000, -1000 },=0A=
+    { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,=
=0A=
                                               int dev)=0A=
 {=0A=
@@ -136,19 +146,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_ASPEED_2700SSP_INTC);=0A=
     object_initialize_child(obj, "intc1", &a->intc[1],=0A=
                             TYPE_ASPEED_2700SSP_INTCIO);=0A=
-=0A=
-    object_initialize_child(obj, "timerctrl", &s->timerctrl,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc0", &a->ipc[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "otp", &a->otp,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -283,24 +280,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
                                 &a->fmc_alias);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
-                                  "aspeed.timerctrl",=0A=
-                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),=
=0A=
-                                  "aspeed.ipc0",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
-                                  "aspeed.ipc1",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
-                                  "aspeed.pric0",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
-                                  "aspeed.pric1",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
-                                  "aspeed.otp",=0A=
-                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
+    /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 }=0A=
 =0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
@@ -330,6 +311,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClas=
s *klass,=0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0ssp_irqmap;=0A=
     sc->memmap =3D aspeed_soc_ast27x0ssp_memmap;=0A=
+    sc->unimp_devs =3D aspeed_soc_ast27x0ssp_unimp_devs;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_soc_ast27x0ssp_types[] =3D {=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 39ba062a20..7f057ff135 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -101,6 +101,16 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[]=
 =3D {=0A=
     {169, 1, 9, NULL},=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast27x0tsp_unimp_devs[] =
=3D {=0A=
+    { "timerctrl", "aspeed.timerctrl", 0x72C10000, 0x200, -1000 },=0A=
+    { "ipc0", "aspeed.ipc0", 0x72C1C000, 0x1000, -1000 },=0A=
+    { "ipc1", "aspeed.ipc1", 0x74C39000, 0x1000, -1000 },=0A=
+    { "pric0", "aspeed.pric0", 0x72140000, 0x1000, -1000 },=0A=
+    { "pric1", "aspeed.pric1", 0x74100000, 0x1000, -1000 },=0A=
+    { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,=
=0A=
                                               int dev)=0A=
 {=0A=
@@ -136,19 +146,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_ASPEED_2700TSP_INTC);=0A=
     object_initialize_child(obj, "intc1", &a->intc[1],=0A=
                             TYPE_ASPEED_2700TSP_INTCIO);=0A=
-=0A=
-    object_initialize_child(obj, "timerctrl", &s->timerctrl,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc0", &a->ipc[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "otp", &a->otp,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -283,24 +280,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
                                 &a->fmc_alias);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
-                                  "aspeed.timerctrl",=0A=
-                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),=
=0A=
-                                  "aspeed.ipc0",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
-                                  "aspeed.ipc1",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
-                                  "aspeed.pric0",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
-                                  "aspeed.pric1",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
-                                  "aspeed.otp",=0A=
-                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
+    /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 }=0A=
 =0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
@@ -330,6 +311,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClas=
s *klass,=0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0tsp_irqmap;=0A=
     sc->memmap =3D aspeed_soc_ast27x0tsp_memmap;=0A=
+    sc->unimp_devs =3D aspeed_soc_ast27x0tsp_unimp_devs;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_soc_ast27x0tsp_types[] =3D {=0A=
-- =0A=
2.53.0=0A=

