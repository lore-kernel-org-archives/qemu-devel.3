Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44912606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=KjAwFSkR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtSf-0004Px-JB; Tue, 27 Oct 2026 22:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSc-0004NT-Nz; Tue, 27 Oct 2026 22:32:18 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSZ-00082z-P8; Tue, 27 Oct 2026 22:32:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhDzGwJMDKHzs8B3s4zIdt87kqfyN6M/JAn4CU2dkcJuYEYmm/A4zSc/cCWazSa79o2/+xYm+bzQLVlIdc4DuE55jOx+c69AvK6xWwn4ZWoLcGOyk7hLsvUxvQtaV7qTXcXvU7FOGSMF7r+ue9vOgoZDMT2oVcp+5JaT/Ujhy9MTp9fxAkKtRDFn9bbmO1NvKVCB/v0q3z9SZqAQkLDv4P/k+5IhecXylZsK5FzWttKi66o7rSemyCmoqvLZBKzGd/pnwBFunxN5ehF7d9Zw9mWvQ1KBV/9PR+S+nQHMhNM5Y2IwQYr0x3SKKcBperH4y2+RXhR3Qp0Wf/6JCR83xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B41g/1wNlV20mY3fJA5vhMhKDARN+l1o1DLzApyB/2Y=;
 b=oVeOPLvXGL4ztLsxSRwMNPregO9upH6GjCMOT7sLdMP04Ts3DhVgrF4OKjv/rI3FkP7OyJBuDm4XdWosgXmGde952aYqpIXLE2CGKIY84cxJPYgb5B7sC8g2pk6sxuXhqEpSASWeI+UxWgb2GsZWqT8Y2hz2iaFob08YmGZURKLFvL17SiCUK88XOx76phnzR8pBlA9Y6CZAZwOqW5TWfQkd4tJ0Z68rONFF+s4YTQaeex7/ZXII2IEdMGgRMwXiI4TR1s3U2uis2AL14pe9Q4j2W4Nma1sRzbo/CIPj8XnQhMBFyPdNeIIiblcnrENCfDy6ZcqpzCHhQvWmUj2KXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B41g/1wNlV20mY3fJA5vhMhKDARN+l1o1DLzApyB/2Y=;
 b=KjAwFSkRw2nLD1vKXp9JiIdr0b9HvT82Gwf4Dy+fe0du1wPyakwBV0MHD1gxOahuWJnbPYJk6PFPkeHj0PnF/RLgsVyRTNIgfaY0Plzq3wsE28WzLa4JpwPVjGQG0MKjRILa1BtT4DgmfexO0u2lcGySDwvHpeoQDu2F5iMeSImm2B2EFx0A9k6Ng+JEpYVAgiRRhXmGxBGHKfGa94S5sMpYXxKDixQlm53GjEG747iSYacYouGvv5tL74p8N8L+T67WjYcFx2ru8fwdJF0r1Rwxj6bJg38XuR+8DlGNEpd7gCGaX3rNWchjMxhlNA5+pZP2VJHMc0HJSxkGCWxi1A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY8PR06MB9103.apcprd06.prod.outlook.com (2603:1096:405:3ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:04 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 09/13] hw/arm/aspeed_ast1040: Add Anti-Tamper Controller
 (ATC) as an unimplemented device
Thread-Topic: [PATCH v2 09/13] hw/arm/aspeed_ast1040: Add Anti-Tamper
 Controller (ATC) as an unimplemented device
Thread-Index: AQHdZoSEHwXZEiBWOk67YElNiC8A8A==
Date: Wed, 28 Oct 2026 02:32:04 +0000
Message-ID: <20261028023154.48395-10-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY8PR06MB9103:EE_
x-ms-office365-filtering-correlation-id: 64de4575-f174-4860-8530-08df349ba757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|38070700021|56012099006|261009221227099003|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ZHlgm8A7xj7Nl6bYNk5SWSZrURkkuYg42ZAPUf8yVTp9ctdrv9APNNjRDvJWIQPEBqTucLqznmlTpvJe4D2wNEfbSkcc4hz7bJDwt4BQFfCY6ARTZRbSpUWSlyaBLOonr9r6C1fbSCpHVV9u2aGBn8s4Rl1Mcf8oH5lebSdMSSWLMsi7sJ6j+W2oNnaYj1iTPmWdaxuDBuBVSUsn6uvJr9ug/1ohKJ5w5Su8zh9pmi3AFLFk/0FHjgHuiwLK4AhrNgqxRkXpRgScCn00qPx0OwQII8LBfodaq7OrDXUQHXOc7EKvhgUusya6yPQ1AmYle7oNOJUOY4tF+1tY0SBIPrJz04FaL5hBmOf+on8snt/SCnxu1FvS0NOu3NW2a4jYfkS11A8fcAmWdDmEOoM1xQe/5+XIEPK/YHZTV/bjeaX7Zo6MX5ADPqUvRYd9GZf1cf2y5B23UTzQgfzRSuyQ4lyaIoL3GNpgLVGzeZ0Y6O9Z2iNwtiGhm01pKI05tE0TJTLePYRJyFEB/5V8HUv3aATllqEyOnAXPjQJGu4jaToK2HhmyjxIHlCOazU6+cJLS3nhz5vpxOUMpLQrz2pupYyqLbPqKAEZvbgfiQlgzekAJP1JyCxQ7uBsb/uxo+QZBLGtdv0NL7we3YLpwUb06hrJbmxYZNeYlBDjl/fSBLF0ARsq7dSBqWHwQKRnO8yLOtGTEM/HDuyntRIjqzWO4utiAFnP3gbhtAbsX+xBfsw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099006)(261009221227099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D9uZpkwpGnMz/IotdfkLQdPDFykcxWrWfiY02Pb4kjqwz9FMszFiwkAkpD?=
 =?iso-8859-1?Q?zvQQR7Xg4RjWavQJ3hJv2OkZLeRWJLKw8igysXkykTzSiqAUUOfmGuUg1k?=
 =?iso-8859-1?Q?M0w+2PykLwH651S8cW5ap5x3OvPOG8WmChzCoqO2leavvwjMu5U5poZcOi?=
 =?iso-8859-1?Q?SztlGwt+3Pm7uK7nPAvYAGIIE326GoWEd/WInqk2gIVbv1vxVkOmv+GAvN?=
 =?iso-8859-1?Q?32XV2IZ5w8Xo2fyZxVZ5xhy+XVwev485AU4PUTkzT6ucrME60n8rmMoFVB?=
 =?iso-8859-1?Q?dpdpJZDPL/3B9O7MnHkw8tDDfLV985L+jUiG0vx2fJKp5L1EHe0aZ8Wv+/?=
 =?iso-8859-1?Q?omLu0YzK3n8jUrzMW2JNlwZHdJD95DHMp2ys2ryVzM2rELJrnJKuouuq40?=
 =?iso-8859-1?Q?x+CGbsEA4vemQlG/HPwWGaubgFeEQ6cmBLsM+M40Cngz0QpG7+qmsDOAsQ?=
 =?iso-8859-1?Q?JQqbpMmP8fGzIzgF8posiD/YzWx+7E4f95yA/JWkw13A1YWxd8d/VrTk6c?=
 =?iso-8859-1?Q?TtYeHLTgJz+pQvGuk1gQTnPQNsczR0zE61Xj53Fxm9rvbPA4TSpbQioU6X?=
 =?iso-8859-1?Q?X5syGDgDwdnraxTp5ZrqGvxCcOPnfS8NiFurnI4MirPVnXcSohmXEowkaX?=
 =?iso-8859-1?Q?Ka/C+bbhWI47KID8d/d9zBXHdphk6tlziT5VgJr6HX1KOFp4Ps0jjdHgz9?=
 =?iso-8859-1?Q?O3Arm8iiPwrDu/WnO8qdoCbvidQL2w6D1V0YAYYfI/npAikPQs7mNsJqkq?=
 =?iso-8859-1?Q?+KEpkrzZAEVrTPIMEVMV0ccH2DDBjvvyir4shz9rBPAM4bx9un04m4YmsA?=
 =?iso-8859-1?Q?MnP1Y1KN+G/u2LMk2sqdix2tk2WHHB+i+kR0EQe1y0mlQ/pVM4pDRIFQ48?=
 =?iso-8859-1?Q?ZH4/VuWX+34ya6ZrbQEjsE8dktyzjuejh2O8wTdop2v25cQMh0h1ajsCNH?=
 =?iso-8859-1?Q?+hP9YSImAI+0KllPF2GcZh8JFW46xyCt127BnsBJDLiV4zOtXfa2EX760H?=
 =?iso-8859-1?Q?WJ3N2IwAVTYZ6c2dasOfYJP6Ey+spQx0Eg/8eqsmymHuB3nJJ1ZuB06t8Y?=
 =?iso-8859-1?Q?syvLYqLcvDAeAj40bOwZmGhM3hultE+5uFAuNfqCFOC1M7lQvtdAeF6rUJ?=
 =?iso-8859-1?Q?57I92zOObHj15zA9PNFgURwaMiRifKqHv85vEEdew6OhchmiFTi1iyc2mR?=
 =?iso-8859-1?Q?JIpxxALiwZ9lSkOBAgPFVr8IFNov6E2uunrp4oeF/Ulnyh0xNi7ZpWtY0q?=
 =?iso-8859-1?Q?9nLRkUwNkyisjo1ravK4mpRlYd/YPoQ+8oE5bvY7AD8HrSHJ7XXKWN4HQN?=
 =?iso-8859-1?Q?Rc9FT7HVGXn0KQ2Bra7PrykmkYL91ZlWCvZn9REl0Kr2AL7lnZ6/HcyOmF?=
 =?iso-8859-1?Q?dt8XCe5C8pPXLc5laiVdpiGk+RccyaCfjH74qrFXV4HfXf0dGKK8o+EKek?=
 =?iso-8859-1?Q?/9V4vfnHaBwSZvrzrZrl1Y3MamTOQRIxbdkQ/D/KdLE+XzYOpZbt8hSEbj?=
 =?iso-8859-1?Q?51gDO48rhwj3okOWhNggvPoh6uIo1oQhPIxdiElAyloe9QmbFbA7IbFbmZ?=
 =?iso-8859-1?Q?SaY9RqM7YBxViEYxVb8EAxMmKzh7mhdTInb2Uja6o56DlriTlge27ORdCX?=
 =?iso-8859-1?Q?WW4mpTkZ/2Sagj8nwTZdbkZ3mA2KCHMTmZ7jWLcheekhTVBxY/twWqfvNR?=
 =?iso-8859-1?Q?G31tVfr0i7bDe0Ei+WMRa4D+6OD0XY84iRJyDiRPPKLHsi+TzSHDa5VGyR?=
 =?iso-8859-1?Q?bWAHtH1Qk82S7E/UvEpt9DB4OXFauNhlELYnMNMEOeS0WCBZO+I+LEhjyv?=
 =?iso-8859-1?Q?+ougFx5uEQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64de4575-f174-4860-8530-08df349ba757
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:04.1984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhBnmCKrw1U0PSci8lK42bm9h7Wox1BsvsVrBGNPnX/SxdP0DRa1+rR0HiZS3sdFHjYXgZ46nGpSCPf+5w7OpsxqvgMqHxX6aANoOSD2CP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9103
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST1040 provides an Anti-Tamper Controller (ATC) at 0x74c35000,=0A=
but the controller is not modeled yet.=0A=
=0A=
Add the ATC register region as an unimplemented device to reflect the=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 48eda35ffe..88f7a2df2c 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -91,6 +91,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },=0A=
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
+    { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

