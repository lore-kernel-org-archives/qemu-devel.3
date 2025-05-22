Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6722DC54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 03:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHwuV-0002uZ-58; Wed, 21 May 2025 23:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uHwuT-0002tq-Rc; Wed, 21 May 2025 23:47:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uHwuQ-0005Sp-D6; Wed, 21 May 2025 23:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnP06LX2WoQvaN78GFzjLAHkHPRbchIfQRKoJsOVqtDS8MZZBO86s2fLDhQIc/Y5oSCW/5tZ3ImqjM8MabJ0vB/waH8nzc4YpIcEp3h0a8j4pr6NAVdJN191SwhJIyLlp9tcdLbWFuXsW93bIjpBkUelty+3Xd/fKUxgIpMoNDSun6dJXKgbBxGk0hiOYzlI07b8FENxryAVp32p5sbvfZhJcFbPCohbcCfihBXTZFQJFDC2o/lM6W0BAItjcY4cOxK/90/KGXkxkDuSJB6yivjDHfC8YqvKXfpRTNjCjp7C3i5FC9808RWu8OIy8aShzXql0AWFnmJBxSWRL4OPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKkOxgV1K3FnKaaYNHrAva93VIEw9Z7Q3IcZIWBMOM4=;
 b=FCADb0kRNFA0fJtSmXz6+v7c+z4JrjdPkhQkc6Eof/ETU6eYxO7nQy8y+FsGlxjxyYo2VUW3K2+L4PSxfOsxqhbbwXFybI+Qr0VJvZSwzRIDfluSsW8NGkEeLyQf2/QHEK22nSloe8/hgiioy/uIwfAZdToFCYi6ZmLSMu1FlVcgp4xwURP+xLLjWDoisW7/TiLvvUvSKMun/c230wwF25Pt6hvm2ZaVBmjoqwXjdAOLvuIU+WjVcEj1UksOxmfiZ/GQQGdZRlMx1LZdoX0kkw4G1vzN2A6o2Hvsc/6VKdsu4ICGjAXX2dlcBD/TvGYWK0KoANXmK7vMoKMJH7oLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKkOxgV1K3FnKaaYNHrAva93VIEw9Z7Q3IcZIWBMOM4=;
 b=L15FVqS/xWuzZIr4DUvDwP3obCyGXAiC+5V/n4+pT66YuOz4wvMjQ4iGhpFUzHJehem3qtuZ/O1Z6RonsQ37pQW1Q8mBRHuZd9Sx8UbVwQvXUCMnNxaV6OOLwBkoz2XN6ycB8x+PEIrkU+HUGcrqPYOWMS+oN1TZqDIEcVqIbtW14zvdgVWbo0nlgKS/OgocdyfXqCbAswSg/POFPmVUEKCKfMqqRC3LnBVgXHZ6DcglWkhgzYp/saiVTsuhdYVjZy4TzMixVXe38lNluS5T/sxJ6ge0L3QNglsrOgdnvq9qxxuPRdzgVu6tCGEHqbaVxNgu6NwzJQE/35eMXfmzNQ==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB6875.apcprd06.prod.outlook.com
 (2603:1096:101:1a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 03:47:44 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 03:47:43 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: Steven Lee <steven_lee@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 2/5] hw/arm/aspeed_ast27x0: Remove unused iomem region
 overlapping VBootROM
Thread-Topic: [PATCH v3 2/5] hw/arm/aspeed_ast27x0: Remove unused iomem region
 overlapping VBootROM
Thread-Index: AQHbysq4dwRZlt4PcE+ANsx2F8pPYrPeAcBA
Date: Thu, 22 May 2025 03:47:43 +0000
Message-ID: <KL1PR0601MB41809BABF70E5A9F602261D18599A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250522033628.3752086-1-steven_lee@aspeedtech.com>
 <20250522033628.3752086-4-steven_lee@aspeedtech.com>
In-Reply-To: <20250522033628.3752086-4-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB6875:EE_
x-ms-office365-filtering-correlation-id: f93def7d-3523-4775-ef0f-08dd98e3688c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PXwJsYIq5itqL/feD2AvSe1aJXjj5Gq+UVyiVDnYN90rRZqVbNF7o4YZOl?=
 =?iso-8859-1?Q?U/8C1C+AKqpqWcNlC/aD5r2Poio6hnvh2H5vXkUk+MFR8sbGL245y6y/Ro?=
 =?iso-8859-1?Q?kSAznsL4/G5FLhCweYJyQ8cKS8h/iM6Q4g/zuwwLZUMgrNcejjgYjXv4a5?=
 =?iso-8859-1?Q?9Gqx9yudQ66ZasgJl4W2FEYL4xFx/TwxbgW85+d0hAsbpM3imDcPSe6U+M?=
 =?iso-8859-1?Q?iHJmhksdD9hnXGAd62rqsuuemwCkBpldFbg71h7HYuFmFvgUqAp0Yyavjt?=
 =?iso-8859-1?Q?CcmNYdloG4C5anpiLv0WwnU92No6L7a4XPZTlQX1h3SG49HLF7pE6LwH76?=
 =?iso-8859-1?Q?CO9R6M+zPPDuIqjmITTIijPc6z1b4L82PrT4wAbo5V+HpLg6KpGcG/klFw?=
 =?iso-8859-1?Q?ylNmVE9rMcPYxmZDhM0p4w8dvDF6LP56FyTdPww5Xu1LOSiF1yjL3rMJlp?=
 =?iso-8859-1?Q?6zTSB7csCLpP+ROkyv/G8UyKB8ciL6aDCg+39/X3dmVYueJKD6zUJgC3t3?=
 =?iso-8859-1?Q?k41DSO3nxNmgy4DQR2wjaF6mvOjav/hN3RsZGbkVNUOBWdHh1RT8Wvlqst?=
 =?iso-8859-1?Q?mapSE2fh4hnyQukEIKxnpOH5nAIEOQ1iLV/JELdzhlPl9q49/qP3hVWMkR?=
 =?iso-8859-1?Q?nZ/sg4a8PXk/n9z0FF6FxSfep52k+51NokVy1+lEArkjPagzd7pEMBHnlD?=
 =?iso-8859-1?Q?vLcWR03bKUp81fhql+4n4CW+/PSn078SQOMNySFhc9GhmkP04RcuIZuoxF?=
 =?iso-8859-1?Q?5dmqE2wVEGZr2gkI0voobNJuUUy58ECjUzsBHh0XZaLDdAiBNUd/6Sf29O?=
 =?iso-8859-1?Q?aVvNB7qpm6B1r9COqTmywjGOZEiNprCzVHYYIPNLHGzMoTUqBvGoxra9J3?=
 =?iso-8859-1?Q?c5ifkPBRKZJPIx8Q8bZfwgBgs1DsoTy7OC8BMDnZNVKtxIp3KUIAW9n8va?=
 =?iso-8859-1?Q?Di7caH998BF7imKg+2EGirUG2HJ1610rJsXz5Wui4EaN7o2HqK9Q+FvuR6?=
 =?iso-8859-1?Q?Vn17AwuD4u9PAqaLYJOeL3MqVN5Lno9Wh8y86hc7XA8RnSP5I0r6bjtCjY?=
 =?iso-8859-1?Q?iQuUPAvwAWNGCw5sHf648CiPLlHgiHrTn0mp9uptuqoonyWuikJM5CHCjg?=
 =?iso-8859-1?Q?8Ec91w4oJxzPk6Y/aT0UoDVh0MgcB6TIj90pOPrOKIKLD2rsOVLagoDp3A?=
 =?iso-8859-1?Q?L4AqOGQZrMTSrILvVfYaerkiheWSlbT+B4goPZeifdZ+m6TCZaAxARpOH3?=
 =?iso-8859-1?Q?Z96zwcfqP+3ai1O2UTtxnwR7bHX8ZE7TfJN97nzTB3lT/njdajn/DvsM3+?=
 =?iso-8859-1?Q?dNTgxeMbXdfk6iMO2C6glLDlS1EvCVXJUhQRGi2wUkX4GWKKjy15Dij0Rc?=
 =?iso-8859-1?Q?bhHizxEomjAg8Ggq7Pu6RvhZNedayPvu3vkqiaIbdSinuNLhzBKerandbn?=
 =?iso-8859-1?Q?yvqRMluI5Ll4F315CjDNDZ7mJX5Rse3EPpFupzHZc79v0W0mZrG0M5oI9e?=
 =?iso-8859-1?Q?1rFEh1/mLEX4BM+m09ov0QEbs2WkNYYNdS6/JIcXwB63zRRshJLSBFsWjZ?=
 =?iso-8859-1?Q?JXDGA44=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+IbBCkxVXy7Ru2qjOmbt7WOEwfFNI7s0ljqsfZZwEnlcYyJTozDAEa9gni?=
 =?iso-8859-1?Q?9TkjUqgVJzoJpwwXIcLc4j+lbp0h60SwlAzHqW5dT3Ka3IE57V0MeY6NPf?=
 =?iso-8859-1?Q?VpidsB5zi92dkJTP/69ZwAr4icmX2OR/WEoakIiaxGzSJY7k/kWNfQy9Io?=
 =?iso-8859-1?Q?jQe4pUMxckQJMcZOrx2BUI7cfuc9W0LJHC4dD8jfZb2zQMsKdZ59mTbERR?=
 =?iso-8859-1?Q?4CIZJk0BQt50iCjgIB7zKNyxthjKQGT0YdwCNMn6jfFPdCHAM07ipXHG6B?=
 =?iso-8859-1?Q?0XyNSa7qxjlKujA+1W9phBj2v156XaTmQUuBTCyy2XR0Nkl9Of2kD0PBII?=
 =?iso-8859-1?Q?IG0P4bdmbRATxE7VFQt01Nzgdem99A5uInIffUqoSq+Sj4/Coqpl/8YqPJ?=
 =?iso-8859-1?Q?2WJbmc8N7Qw6Sc9I3lr3EMmYC4eCfmpm/soUkuk+tApQfTxrV4xIE5lPx5?=
 =?iso-8859-1?Q?I5aAwMs9IXKRGLv1+AcZCJzFyx6ec4qhmcCaoNZtS5AqaPb3WS2Z13SvZJ?=
 =?iso-8859-1?Q?5No3fNDsQ6m5aSmSHHPCGmZhOqHg6dvVn4Mjqs3Ft4VRqJ65tDFbruB4K0?=
 =?iso-8859-1?Q?Q5xZLBf5UpaVLxMHUwXOpc9TT/zkF0Yy9zPUm6QnDLlSoHow1vout+4zTN?=
 =?iso-8859-1?Q?rpzEP6RUq7+Q5HEV6ZXQLg04HI3yL9CSJPsyHFsGodtHXfrnY6OyJFuW62?=
 =?iso-8859-1?Q?U2+JURmJmeG3Wl1Ku4WPbwadd+CC04c6dZTTkbsZoLdlRvt4o+q4Wk6wZf?=
 =?iso-8859-1?Q?kc/5Oprm9VekbMYSbfJ5uW//0eRNAGs98PuPZiFHtEFmWGC3rC3a1aLsXf?=
 =?iso-8859-1?Q?vpq8jOsEbHKcAWfLjWPmyy3Ze7pYYqgzNB7lImRZLcn9E5UsxpVWTgWPvJ?=
 =?iso-8859-1?Q?J9JznQ/igaAVdLo6r8DdbOj/caW8psdgGIlldu5xgQ/MHgR0wX6ew1sKwD?=
 =?iso-8859-1?Q?XEtzw643xy/1d4n06WtSA0yDbr5tU5Ht/teVtAx/8kAVxO/HIXmRIYo8Gq?=
 =?iso-8859-1?Q?AkYxWFEeN3veFnYZlz03cS3QSii278Qy59P/j/EootoeAGE2Y1rejm5qND?=
 =?iso-8859-1?Q?8tohpUwGJz25yh/4Rs5jS5fTiA6Wl12/e8VXVhaoklaExkV0mKPiBTGzrD?=
 =?iso-8859-1?Q?jdTR1iRAaB5wmqK5aNfYd3mhv4u8D1/h+f7sstCToMluzFEJmtn5RCTQkg?=
 =?iso-8859-1?Q?g/H2d0gOyhuRc8fKM0+poTK4sbjIqhusOqHVjKCLFNUWWX1cYepGDlQd6N?=
 =?iso-8859-1?Q?h0TxTzukeZwGy+Hr0bo5SAKQM5iEIUgLJsrTNvBhrSlVX+65pEqszXOUSN?=
 =?iso-8859-1?Q?VN7kO6fBvY76Kz1SDxMCovRQzPKRVYjIB88q0P10rIKvVs8AzGWa1YTciU?=
 =?iso-8859-1?Q?3OsvwVQ59XfOLsTY94zgZ3YHs9ZzAR1Zny5RotGZoqNLewi6TanW8kXmGC?=
 =?iso-8859-1?Q?9/46XvmDOyBfWN8/VCUizzv+9b9WXCdoaBDTKIwgHzaEg0799OsjOhAdjF?=
 =?iso-8859-1?Q?QqKaSjVe4adE7K6tCIFdUZ4N3ZcOx/anXPZfv4MRc0LWHEtVW4sZYqE8iW?=
 =?iso-8859-1?Q?e7nwWGaqjCC7Eco523ETwTCmjxxBD/La51S8kaY3kSIoepG0SM794XaJI7?=
 =?iso-8859-1?Q?mJpAqU4zahkGBAedqqNNWdn1f/bG3GnnGa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93def7d-3523-4775-ef0f-08dd98e3688c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:47:43.5336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QaibapCMV2JqvS3yjeuc4FLRcddMoXzpXveGbcYsPV//nQ+Ei+LQ8ass+cP+eyMnggFQfsPT7q0D54rT6LfXizlggpXDpVXHNY+Od+6mV0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6875
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=steven_lee@aspeedtech.com;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi reviewers,

Please ignore this patch - I mistakenly sent two versions of patch 2/5.

The correct one is titled:
  [PATCH v3 2/5] hw/arm/aspeed_ast27x0: Fix unimplemented region overlap wi=
th VBootROM

Sorry for the confusion.

Regards,
Steven

> -----Original Message-----
> From: Steven Lee <steven_lee@aspeedtech.com>
> Sent: Thursday, May 22, 2025 11:36 AM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Troy Lee <leetroy@gmail.com>; Jamin Lin
> <jamin_lin@aspeedtech.com>; Andrew Jeffery
> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
> <qemu-devel@nongnu.org>
> Cc: Troy Lee <troy_lee@aspeedtech.com>; longzl2@lenovo.com; Yunlin Tang
> <yunlin.tang@aspeedtech.com>; Steven Lee <steven_lee@aspeedtech.com>
> Subject: [PATCH v3 2/5] hw/arm/aspeed_ast27x0: Remove unused iomem
> region overlapping VBootROM
>=20
> The iomem region at 0x00000000 is unused and overlaps with VBootROM.
> Removing it avoids incorrect memory layout.
>=20
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  hw/arm/aspeed_ast27x0.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c index
> 1974a25766..328897ded0 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -23,13 +23,11 @@
>  #include "qobject/qlist.h"
>  #include "qemu/log.h"
>=20
> -#define AST2700_SOC_IO_SIZE          0x01000000
>  #define AST2700_SOC_IOMEM_SIZE       0x01000000
>  #define AST2700_SOC_DPMCU_SIZE       0x00040000
>  #define AST2700_SOC_LTPI_SIZE        0x01000000
>=20
>  static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
> -    [ASPEED_DEV_IOMEM]     =3D  0x00000000,
>      [ASPEED_DEV_VBOOTROM]  =3D  0x00000000,
>      [ASPEED_DEV_SRAM]      =3D  0x10000000,
>      [ASPEED_DEV_DPMCU]     =3D  0x11000000,
> @@ -521,8 +519,6 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                              TYPE_UNIMPLEMENTED_DEVICE);
>      object_initialize_child(obj, "ltpi", &s->ltpi,
>                              TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "iomem", &s->iomem,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
>      object_initialize_child(obj, "iomem0", &s->iomem0,
>                              TYPE_UNIMPLEMENTED_DEVICE);
>      object_initialize_child(obj, "iomem1", &s->iomem1, @@ -942,10 +938,6
> @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>                                    "aspeed.ltpi",
>                                    sc->memmap[ASPEED_DEV_LTPI],
>                                    AST2700_SOC_LTPI_SIZE);
> -    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem),
> -                                  "aspeed.io",
> -
> sc->memmap[ASPEED_DEV_IOMEM],
> -                                  AST2700_SOC_IO_SIZE);
>      aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem0),
>                                    "aspeed.iomem0",
>=20
> sc->memmap[ASPEED_DEV_IOMEM0],
> --
> 2.43.0


