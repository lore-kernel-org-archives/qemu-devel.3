Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CF5CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mb-0001om-KD; Mon, 12 Oct 2026 02:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mW-0001lp-8a; Mon, 12 Oct 2026 02:45:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mU-0006MT-5N; Mon, 12 Oct 2026 02:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8rCijMJ6aCdjIaOtH/a+UcthiFkjwgiLa8hRgwIEVr5/RdAH+wSWXNh5ii5JJYwUxOj57rmmsjd7O5E44AiALzFN/gpqawRFseVLJasHkEclr27Ef5uYChcX/4G8F40eqkaMmw1JMvFaYLgrCt1hJ10m+RIwyUvHpCvlGs8245m0N8VHPNMCIjEC9IrzF59EiLGIsqrYP1f2EXX+vWIkqHGz0jE4jpK8IA5e2XjzoMGmYf7671ij7KQOm8liltWewGabtZ+RqoygsxVhOSjXAQw8X3sCwRMOa1DwTCFH5uZyio4rGbtcV4TenN+i11eSsP99wUw2gABLP/64OGeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mODzydoSRAiIa4JjXvmZnMSDoH0W6tEpC+oWX4ZjAeU=;
 b=xAZmrYUMUKiYsxX42MtU63RmHJGE/r5eHoWA8FP1FN2hMF2EutxTx+D7BH7krBwp8y7SLE5rUBbX4fNHAxEXuanm/hZaTlxVK1HF11hCsqvNKXsX69gKGRpW/eFSxXF85zsAGMX5/Bgw3om8mBBvSIVZoeohn+dmxtVpR8zxUqsIIK7mw4ukI8EquO7+v0Y+0sLdwlBA5vZzrb+7sKvnLw65SJF5l/k5FcR/fue7hdvzseYtswEdU7aDEjn2nckS9Aep/uEo0TJCf5AOWz18ib3pBHR7OASyJm6kBs+78fJdObPPRFiel1hHEd0HxiTXtq7/HOwJ5XUDqXtLAmIFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mODzydoSRAiIa4JjXvmZnMSDoH0W6tEpC+oWX4ZjAeU=;
 b=MFGRjJZVaNXSmmCYMjjtwW27mibrPOLSR2dQQx7eCFgtgItvZSeGqOVGylUB0jhOrz5skqSx6FGwBYGjKwgv//kR9BknpYblWCT3U9n+OYmYdxMCjYV5dAEQbOAl8jGfR2Cww8DQu+XTf+0sReUknrJItwH9RKh8mO0r1WoWa6uNX7/dC770kZIeBX710uIwfxVKX03+jEtWunrll1dWU7fGz86ZbHWNeuWgzkNz5OcU6bmud6yeVQv21uJzqQ6K0wBM8y56BxOpCKEZoKmpc7VH4JuC2t9V6zNqqI+UUEVhfQy8wlpeg/cFXQCrG2zcmsYOixa1pNMw3F3zQND16Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:52 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 05/12] hw/arm/aspeed_ast10x0: Use a table for unimplemented
 devices
Thread-Topic: [PATCH v2 05/12] hw/arm/aspeed_ast10x0: Use a table for
 unimplemented devices
Thread-Index: AQHdWhUu2lflTZKkj0Ws2IlOVog+tQ==
Date: Mon, 12 Oct 2026 06:44:51 +0000
Message-ID: <20261012064445.2571633-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 45437a85-a083-4c5c-8d34-08df282c516b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|260925021311599003|260925022911599003|260925021911599003|10067099003|261009221227099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: gAuHFgyk/x0tep6Cd8/hb1ZYOOrBsdBoaqqVCUDoH95rZ7kxMOn3dwOF0saqg918HwDAwUnc8CUjRmtk3I2cFgVbUCW+tJ9sCP7Fh0puv5kr6X4ZdeK1W5SVquwrL3llJAn7WdjLXYBMl/y95PuZMsvG9yG+oHv5VGCHPsYhBWs3VRUHUCje0EBEpfq3rzABRLqkLC208dgmPhwHoxeOiZ+4W3BEVWFUXUywmbUdov0w2Q9PGdZWg6r9nFSjKB5iW9AY0nIAxC8StMr9ZZkRz9ngKs1w2zKnAJCuoLDg45G+vuY2zTbwak0/aK/TV0ksFqAj1JvyY2MxM7BF7Vk7oWsp7RE/o2afHOtG00H1jpQ4E8Nqck5AYkKMzRCz+DTOjH+ohBVh15rvd4g634opuvaxIFKvrCSZN546F6NsrXJi5nAqgCHUKtVgxgpfTVDSloIMJgWJiXH7QbpfhvIGL876ap6mX3y9ijxIX9WH26QEwVKBjnLFQYq9NEfBCF5/P5GfHcLknnPdEjABNMJBoNmwwmNlJQGZIfL1ux7bb27Cs5+6RGYbQHr2oT/FSR1KtL1J9U5ebvLzldigezO9uY/n8DxCCwIwLBnIwlM3WO8pSd262MZVj4qSMF6WGgUZVPMXZxgTI5Vy4iL8nyN8nnYCnpR4w7ztcD0+vG0Pz3YXIax01S9Bo5kfXB6L8825lZW7EI70USSjngPOKzAW+X2ay29fNMZ//9+bDKreSfE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(261009221227099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sI8hAvl1y12l2C13UW0OpghUqNSMVN6jiHxQ8+2TlcqYGH69ZGQQLzweGJ?=
 =?iso-8859-1?Q?0W4hDqJMqNfS2cFh42nrSJ7iS1Lad5CSlNjhb5Nepx9Y3gItx1r3b7SUtM?=
 =?iso-8859-1?Q?CC1gRUT9e6y5vhsq0mEPiEzEEFhvPs8a12QiCMAnSwFyd3NYAA3qiDHcQo?=
 =?iso-8859-1?Q?DCFxT3/h5CQG4N9kB70IW/Pj6Z0udPHku6Y6mfg3VICnMcDsRevk703MTI?=
 =?iso-8859-1?Q?h+5+g2k2wvG8Nl9EOkOaC6iP2GXThiHI/aCvsnFg5eh9QY+1WYXjRfL9XQ?=
 =?iso-8859-1?Q?yE96NQ2z84a9fJJnCqE8k8pkoQY2p7colhyE/A1DOjQQL0A37RNn2+CEtW?=
 =?iso-8859-1?Q?H3X1OOXPDSY+AcEWyN4YaQ0gqwvGRy/PyFPppRQuxMYvx2wm36qduJRRTu?=
 =?iso-8859-1?Q?zahyT8amrLCx48kfJgzdQiDE6siQ5NulgeKnaMRSXbb4GF29GAUM/G8UQs?=
 =?iso-8859-1?Q?PLJPACZ5EvVPZyKo1rJqYe+ruGHUH061covOXvZpNjleJmPUY9iZNWCeG3?=
 =?iso-8859-1?Q?0H8p72Vfl5HtLvlln8a7N4gvcDkWoBTE220+ik+wNNVKuu4jHGuccx0LSc?=
 =?iso-8859-1?Q?EacyP1vY6CrJpw0t3ofYIzdO0/9P6t45sizIdCNEOcW57WfdYSF+oYHC8N?=
 =?iso-8859-1?Q?HgUDcvhyDDd2I5+am7+2xaOKc6XifRNT1Zgq0U4uKv+fBZk6CiVXEzjokg?=
 =?iso-8859-1?Q?S9FStm8/AmAJnWOIySBBqk6ztMQ3LUCn8J32datoLfuN/wTXcKkRVRLxpE?=
 =?iso-8859-1?Q?pJiHU7Djpxy3wRCxcffdNLY+SyH0XTZX7zK0a+bw8SS5CUFUEPxhnQJeSb?=
 =?iso-8859-1?Q?OCXUTzW0171lLHIQweGL63ekHV/1+QPsnAphVIoOB7k/VDOwbXZNXooTOp?=
 =?iso-8859-1?Q?IbunZE/kJtYRRyTAjlrgqTvA8ijW4erC09C5qhJoZxnDegLrnhqBA+yJ3C?=
 =?iso-8859-1?Q?f5/MBIvlBhMFHqcsx5L3iYedcwVBl0y6K56BuGHVf+ILyn2z5fiCH6kwH8?=
 =?iso-8859-1?Q?rz/4wrxwvWz7Y0bYI+Xvif/BnY2Wo3+NYWtonwZC/j2NIMguhNDfJmcfNv?=
 =?iso-8859-1?Q?U4nsj3g80xCYM18wF5RLjHCWOtsN5vwfkFgrhAH8pKUr7i5u2Uf3eA7On+?=
 =?iso-8859-1?Q?e5CMT9C+zshIIwb+cXS2OxqXdLbag9EVw8fVjdbmdJDa66z2wBwpCC+CJO?=
 =?iso-8859-1?Q?nsL1VqDL2COd0TnNqx0gSbAmhTqWNa9XolU8+U2eqkb1F4hS0J/pATwXUQ?=
 =?iso-8859-1?Q?8AyHrjti4AXvx1GKuSiJYQyOeAMnAWGb+JwD9IzQ8Ar7gmLV1yPxEfv29L?=
 =?iso-8859-1?Q?feiSh0beNhikZ0MPw3l5wIaItdz9rv8y4YhpkIbBhu4eXbuqZ+SUWE2Mux?=
 =?iso-8859-1?Q?U9rvpck7zftIkg7Ji3/f/jrivGyDlyDFUTkwtbuD6r40m85HZa29igC8ka?=
 =?iso-8859-1?Q?r3kRnJAUSw4HaCCDaBE7HPhTYDbV5dFeJNQrmQagVVUBEFCf7n8tP8ktb9?=
 =?iso-8859-1?Q?LsDpGap6OrpnrwjCOo6m2INv5Usdrv3i9qFiX5wMFkkEFPDQzvtwyRUQJd?=
 =?iso-8859-1?Q?DgaqtZ0qk3gRyn5iKdhEGY6T1XcpwRKZ/Q2go47FRiiYSIZ//AGAc5IjbN?=
 =?iso-8859-1?Q?WE2OmSeJs6MeDefIJCKvW7T9FPfZS0iXozZi1Y01wIbKkPAm1ZzZQ1bO0T?=
 =?iso-8859-1?Q?Cy1OxPaWqI8QGrXlDFFrDewdg4UwBP1U2yAdzQJkbtHCYl4gm1Ut2d0e9+?=
 =?iso-8859-1?Q?RNR3c09LJmEpblUE3gF9VdxJexxrCbItUvVVW3MsapZX+C5iekQ+4mLpRw?=
 =?iso-8859-1?Q?Lz5y9UUq6g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1fjCEVVSf/dgAzPld5L0I24ais9skpFs+lTKFammIfNwsAX6dlGIm0Gwu6X7H2hQELiSIeUFYfpYWTfIzy5uqiMiwOpB9+xf8wtR9qDqzfbF8MqrOMouxqSR4Wwlr7ipxVDroa0nmLapcbMKWdGUwYZQdz0Jkn/2+v9XkKUNB97acnXB4NJFTfRoAucVI0sdObjwaQHSOgfp+c0xBvFI03DAgLtZH/x/WoJq5yC23iG6FxUawHtfnFuD9dD4RH6PcldVjv5LAZYAd5Hyrt/oFtVCYYyPzxMyri294iNlGKRgfUYkhUJoEhKD4+i9LbTuNvjG0xerMGYrx/2cP4FbWw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45437a85-a083-4c5c-8d34-08df282c516b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:51.5753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdUgBjU7mYV/zE8HDZEH9mRPKJTE5Qpo6QBh9XvYEsvFZizQ6FbAe7K+mjClTAomSdGtbSba8pt7wwP8JLO/tTbwYLPL6UvO0ZYqRuDISIw=
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
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Use the unimp_devs table in AspeedSoCClass to describe the=0A=
unimplemented devices, and use create_unimplemented_devices() to create=0A=
and map them. This makes the code easier to maintain and read. Convert=0A=
AST1030/AST1060 to use them.=0A=
=0A=
This also fixes a type mismatch. AST10x0 used the "pwm" field=0A=
(AspeedPWMState) and the "sgpiom" field (AspeedSGPIOState array) to=0A=
create unimplemented devices. They are not used for that anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast10x0.c | 55 +++++++++++------------------------------=0A=
 1 file changed, 15 insertions(+), 40 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index aeb5a4423d..0790859735 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -17,8 +17,6 @@=0A=
 #include "hw/misc/unimp.h"=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
 =0A=
-#define ASPEED_SOC_IOMEM_SIZE 0x00200000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast1030_memmap[] =3D {=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x00000000,=0A=
     [ASPEED_DEV_SRAM1]     =3D 0x79000000, /* SEC SRAM */=0A=
@@ -99,6 +97,17 @@ static const int aspeed_soc_ast1030_irqmap[] =3D {=0A=
     [ASPEED_DEV_JTAG1]     =3D 53,=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast10x0_unimp_devs[] =3D=
 {=0A=
+    { "iomem", "aspeed.io", 0x7E600000, 0x00200000, -1000 },=0A=
+    { "pwm", "aspeed.pwm", 0x7E610000, 0x100, -1000 },=0A=
+    { "espi", "aspeed.espi", 0x7E6EE000, 0x800, -1000 },=0A=
+    { "udc", "aspeed.udc", 0x7E6A2000, 0x1000, -1000 },=0A=
+    { "sgpiom", "aspeed.sgpiom", 0x7E780500, 0x100, -1000 },=0A=
+    { "jtag[0]", "aspeed.jtag0", 0x7E6E4000, 0x20, -1000 },=0A=
+    { "jtag[1]", "aspeed.jtag1", 0x7E6E4100, 0x20, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(s);=0A=
@@ -161,17 +170,6 @@ static void aspeed_soc_ast10x0_init(Object *obj, const=
 char *socname)=0A=
 =0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
-=0A=
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
-    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "sgpiom", &s->sgpiom,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1030_init(Object *obj)=0A=
@@ -215,11 +213,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
         return false;=0A=
     }=0A=
 =0A=
-    /* General I/O memory space to catch all unimplemented device */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  ASPEED_SOC_IOMEM_SIZE);=0A=
+    /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
     /* AST10x0 CPU Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -394,28 +389,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                        aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_GPIO));=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
-                                  "aspeed.pwm",=0A=
-                                  sc->memmap[ASPEED_DEV_PWM], 0x100);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),=0A=
-                                  "aspeed.espi",=0A=
-                                  sc->memmap[ASPEED_DEV_ESPI], 0x800);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
-                                  "aspeed.udc",=0A=
-                                  sc->memmap[ASPEED_DEV_UDC], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),=
=0A=
-                                  "aspeed.sgpiom",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);=
=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
-                                  "aspeed.jtag",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG0], 0x20);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),=
=0A=
-                                  "aspeed.jtag",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG1], 0x20);=0A=
-=0A=
     return true;=0A=
 }=0A=
 =0A=
@@ -503,6 +476,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->uarts_base =3D ASPEED_DEV_UART1;=0A=
     sc->irqmap =3D aspeed_soc_ast1030_irqmap;=0A=
     sc->memmap =3D aspeed_soc_ast1030_memmap;=0A=
+    sc->unimp_devs =3D aspeed_soc_ast10x0_unimp_devs;=0A=
     sc->num_cpus =3D 1;=0A=
 }=0A=
 =0A=
@@ -529,6 +503,7 @@ static void aspeed_soc_ast1060_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->uarts_base =3D ASPEED_DEV_UART5;=0A=
     sc->irqmap =3D aspeed_soc_ast1030_irqmap;=0A=
     sc->memmap =3D aspeed_soc_ast1030_memmap;=0A=
+    sc->unimp_devs =3D aspeed_soc_ast10x0_unimp_devs;=0A=
     sc->num_cpus =3D 1;=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=

