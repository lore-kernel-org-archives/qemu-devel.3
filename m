Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB3CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESw-0001zJ-6H; Thu, 15 Oct 2026 01:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESd-0001py-Ln; Thu, 15 Oct 2026 01:57:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESb-0003E2-L8; Thu, 15 Oct 2026 01:57:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXL8gURJvVDT7bboxfPuY00BtH3u0PXrE5LWLIr7FoEtzYJOdZR7jFoVV6UP8b0qGC14MTUqA0h/tT2PUUiqvy3e6ztKa2Urq0auxAWSb9r0YBNeHxBzkgXQ23bQO0APcLqoQB9eb8Zth0SmkrTOXbBcEMM9+CZc/io+PwjvSGmXxf1gXoEL9QEb6ms6d0a3vuiTn6vuwDeOFXuzME+/nAc/VmTT9P5L/1SxuLWxWT9/S5hB2jDFDC06+wNvKjZZz/x7LQo/lzrxFLEr2MLsBoIw8byezVcrtty44DNAl0/k9BxW+45yVWSqj4+hgWtCxOitEzcbXYWnzCzEZNoerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYQxFzsMESdRki9ccUE8iCzeraC3nqvT+ejd1Piaepg=;
 b=IRWHBcK6apnmN1K5P5ng7AyMNpOea8sQSzNmxdKb5tkiKXD80eOyX/8ODsPOX4YlZWBk9Nc3cDeyyWrPjTrAVmVCQnSrrrV696jPH2KJ4C7578cSvSOJWELfwcCbfEiNdo+FJ3Lm1j/RBWLMaUKI1c4SW3FXsdGLKZlhHUQOxbPelaJOwZHMzUJ3YTgXVSWrVpP8MRhgzXa+9PL2rLZFxd39V3ypIBE/AE9ADGxpZ/Uf+ri22JUCJanonhQHtf02GSrEZETHGo1nDAtJNa0xMzaiBgTdhOJIVcUnWIFueHGIpmqbbSKQKgOdtWy0nI1xE6NCwUnHI17kMLhGGw2Wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYQxFzsMESdRki9ccUE8iCzeraC3nqvT+ejd1Piaepg=;
 b=JEM9sySrkf81VleI/psH+xxPQjrmA+wVvISM2+JCg1sYQNM1P4Z4IlwOmSdNsWurFpVhnyWN3t+Dv3RUbdN8qs12mN9lxiSDaBDGMESJLvsPrtE959tNNEB7l7HafT8fXOnFn37pJH3zOehwAr3Ghsrh6JIdjFDUUzJCTiAiv4fQ21PVPx5P6jHRkw/P7h4ul9cvxl8SQMO3ucoQ7JOtDnI9ivBTKSy76riuuvLmWtiSxatsIK1eIuuIU9+jVmsTcbqTuIJv62s2RCVcZfdBY6n7fal7ujeR9PKDIT8T2XOBVcvKKokUAMGf19d1RRlzvEc7w3os6zPLjv7lGndm0w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYSPR06MB6607.apcprd06.prod.outlook.com (2603:1096:400:474::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:55 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 06/14] hw/ssi/aspeed_smc: Add AST1040 FMC and SPI
 controllers
Thread-Topic: [PATCH v1 06/14] hw/ssi/aspeed_smc: Add AST1040 FMC and SPI
 controllers
Thread-Index: AQHdXGn4FHLiH0JF30Si7K74PeClww==
Date: Thu, 15 Oct 2026 05:56:50 +0000
Message-ID: <20261015055642.106204-7-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYSPR06MB6607:EE_
x-ms-office365-filtering-correlation-id: c0b2f4dd-ae9f-44ac-2a8a-08df2a811ddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|921020|56012099006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: UEwowyRi+eTixffEYq+OFSESviBDzuWRsg5gHMfUoKzp1em96HwnsSjneGaXWj+hCAqbDK9eubp1bTeSSUwF1KqmcODHwEAm1Iik4mW3z6Y+Uz7DsvnvAECNt8ecwDuU6aeYo18G84G9XVF1gloQ3VpWCYoCSguNUq3FZnfz6gZJFc9Drn4oFwvJ0bmqukukAn9wCDDkTTuVyAkiZbQt+4Rpgs2B5Yi4WaE2B6SodbwburLYR14Z0yw8F9XybU37wHXmDAhBKmArfGaqW7fs0qG6iDW+s9UVu0n0r7D3J0V4nXvvw9CmhV4THBo7nV4UqIys/tvLhObDsli6KkpXau+b9dNfzsgUCYnpTL81j7FfZNO9OFy6juRjvnka20+eQ/sVrDognn/on8wSfdQMXf/Wj4u5QkBc0Gyt8VqBqHMux6jl4Cs6fZ1pJAJRUhlfZv3EjQ7EDH+WGQuJbbt4KLM8ztXADkyxpL4qN1HpkJR6bzkPkqbT62EPYBOtyXN00uPLF/rtAXVinlVB8Lxx5S+5mludvyemdFyiXHVQCTOXZj0REAXOhcQePmvKg3fE8eVz00XVyP8s81docZKidN1hxS8wP2AA2rm5vhoXt4FdJlnX+apnq7I7s6dA7jcf6ddni+84bLWQ+5aNlGI02aJXfy77IK0a5qZ+n3f6+1hldRDVO9INnBruv+MZN6vUMeCsECy2N4vYAWI2bFbOzXG0p60CrVL7sLlFqJESgBbrWnbhBf/B+5H2Tu/7ffIZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(921020)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Owr7VjwBMEOaPfBOYUCjaMik/dk3sCPgLWJEFBtTO1F3PZOguApgzT+11K?=
 =?iso-8859-1?Q?Pk1FmenOWKB1F88/TWCSHQQy3HkXtdVLM6ogBTBFdouj1NtQf9WG+2Wg4V?=
 =?iso-8859-1?Q?2RIpOHsjOzptSRZvl2j6e/lVI9CRFR4DUSYGO6aIPTn+IjUTIsK+u1op2F?=
 =?iso-8859-1?Q?1b5xHvbdB/ii1QpLIndM8dY08Bsh88fvkV8TCSQi0Kry+eSSTUQJUMa3PT?=
 =?iso-8859-1?Q?mZoEWdde5vr6nWxuyrf8bDiCdXS9R/uaFp7/CQhudY5I4Gx+serOH+VlsO?=
 =?iso-8859-1?Q?TxePIbMK0BnGKtHcQn77dZ1Gr3KaTuzlbLtVemligTSTDcPGXEQxQsjpiX?=
 =?iso-8859-1?Q?lxV/OfbRohvJAKrs78HF9RSjpukFVx/boeVVJ8Il7XzjdapzeUyeimv6OQ?=
 =?iso-8859-1?Q?maLdJbBM/mMLCFcUc29O68ATP3bc33uNlxuBBGTvA1wJ9vEfv+GOj17reB?=
 =?iso-8859-1?Q?7FnnJenkIhv0HoSHldw3EJpBo/0+lfAThHgaye/02hA5KO3eDKwClmBGeX?=
 =?iso-8859-1?Q?SFXp1HRGdk7rS8FUaZw/kQyis3Xwa3Cj/OFkJ7bAKjdzedp2iPX+jx7CpG?=
 =?iso-8859-1?Q?XT7HwNLKU1JrI26j7wCW/fD6+CsXHPnlfpKYDL0QyZjKVu3TTKqOj/O2Op?=
 =?iso-8859-1?Q?S3fZp+rMaOxAVmDv+QkLG9ZShzi8ddenuKj/bDLvfIzgjmjzI1bFVJDx2I?=
 =?iso-8859-1?Q?JYTQ9X8nGuRJXLt+/03hAIowohu/vr15DQQe3f/oEiDUlWRgCH8CM5KdOh?=
 =?iso-8859-1?Q?Vm+VIbMsNDCIYQmuk+J/DX9/54bYorZbZUI+TSp3Tl1RiteC8jZC/RvrQw?=
 =?iso-8859-1?Q?R+1wcnCZhWLBbHpKG3xjiJu3i5cSJSE4WpbsbT/0cHAsb9AQwMc/Yq0ZQ2?=
 =?iso-8859-1?Q?Pke7yoM7JHbCBBDdy/5Wls6Hia5iHdy/bTH15TaGwQPiHKDIO3AjDOg/wk?=
 =?iso-8859-1?Q?W9lWBZbyp4qF9h8QNK9syzrP0O32qsQ9LQM0GZkjLRVwuQU3uNw+3JE63O?=
 =?iso-8859-1?Q?uos+3AXiV8tdTI5oZ3owIaec0Ni3DkE7cdW2Y/G2OcHSnwLqvc7p4p+h0Z?=
 =?iso-8859-1?Q?k395rrjpJXzuFhGeq4X5Ghm2JECcJTBxrwd0mxONVZUHvYG/CLLKrxhSXk?=
 =?iso-8859-1?Q?bZ0YrHmJX07XEf8QiKWQsnpC1fuizAVf9uzQejNIrbdrVrTB/T9f0D19Zr?=
 =?iso-8859-1?Q?RO8YGuCqNmsEzcjDk0Qq9ewwhkIldL2dZ0ypFUvRmgVWbhQNCDYSpz28/m?=
 =?iso-8859-1?Q?8PqzS3YkKvTBeoRjlD/ehBzH5dSVFxccM9M5uDRabRI3qKpddvD3f1yUVY?=
 =?iso-8859-1?Q?sk3hjO8cgE0coxjyJO+gdlGptUzWDCk73N6t8500F/U2wEoLfp6P5AaYWz?=
 =?iso-8859-1?Q?XsZyNgpItgWtu6qCd/jRh6y053j4TXWYeNODBdKPN5eDEmd36NixmnbUN6?=
 =?iso-8859-1?Q?rsP0HiCwk8B6D/uwvJKC5xm/qTFxPt7w6p1YZX4771Y0cmUB30SyZ9eZyT?=
 =?iso-8859-1?Q?zh0dKGeDXX+92J6VXRvgnGRobArrQZl/v9E3d9s3HUrsAJHkt6I6hqKD4v?=
 =?iso-8859-1?Q?MHcCp0/Uq+kc3eYAjNn1CxtSgm2A/0qwdC5Dw7c6FyaImTjBQarG4JwNLf?=
 =?iso-8859-1?Q?xMXi9dYWLpGGvfFNC7Auy8cRHDxAUoPO1/y//IryD8f3OD1G81qBMyNGD4?=
 =?iso-8859-1?Q?RpG4Krnm4oGncVZt7DoT/V+X/sT4VjcuM3Jzg8Lvfcp96mqblYG5JNAmj8?=
 =?iso-8859-1?Q?yVRWfq+4VHqqzbCDuWjv+lE+NCJ/MH/3bkcXqMGne2CWtg+i/tWoR/Mhqi?=
 =?iso-8859-1?Q?4Amz74E5Gg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tNldz1WpCzEnnMZGn6j7HDyX6o1T8AvXmENRjVd4JBFoPIgc9Y/z8J5XmyGfO1VcbJiykqg0Q0g6HlZEnR8cffrex2rlP6Hl0c5p5y15zvnV26NUCZafpVAV5CjdaEVf+h+f4dD3Ie8SLy80yxioDzlwzpMEF0LX/SisbL9UIIb3pPOCg3qtaSIRmEQYY3vJOkn1W8FefpTBoEnVNXWWoEMO5OeMvxrz+IXaq77wqrK7Eap0N7UuEfWPdjCVt8tYD3SJZYwl2t5+nrZSy1SK1WdC7FAmwwkfxPU7QKdYor1jsCGpdP93uwxQLFzi5QK7a42Fk6UZIkx9wpTzedcjHA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b2f4dd-ae9f-44ac-2a8a-08df2a811ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:50.0733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvcU2bJqKW8hvqoZYdDLLMj8I8DdosCZit0vTTLcjnDRI0XB0pi6T1STMfZNZg58QlQwE4aenmv0fdkxmkdfY6QmOf2IjkA1IZ+K9tT05ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6607
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The AST1040 FMC and SPI controllers are compatible with the AST2700=0A=
controllers, but use different flash window. Therefore, the AST2700=0A=
controller types cannot be reused directly for AST1040.=0A=
=0A=
Add dedicated AST1040 FMC, SPI0 and SPI1 controller types with the=0A=
appropriate parameter settings.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 109 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 109 insertions(+)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index c0c3666dbc..89a7dc1105 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -2072,6 +2072,100 @@ static void aspeed_2700_spi2_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
+static void aspeed_1040_fmc_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_CLASS(klass);=0A=
+=0A=
+    dc->desc               =3D "Aspeed 1040 FMC Controller";=0A=
+    asc->r_conf            =3D R_CONF;=0A=
+    asc->r_ce_ctrl         =3D R_CE_CTRL;=0A=
+    asc->r_ctrl0           =3D R_CTRL0;=0A=
+    asc->r_timings         =3D R_TIMINGS;=0A=
+    asc->nregs_timings     =3D 2;=0A=
+    asc->conf_enable_w0    =3D CONF_ENABLE_W0;=0A=
+    asc->cs_num_max        =3D 2;=0A=
+    asc->segments          =3D aspeed_2700_spi0_segments;=0A=
+    asc->segment_addr_mask =3D 0xffffffff;=0A=
+    asc->flash_window_base =3D 0x80000000;=0A=
+    asc->flash_window_size =3D 512 * MiB;=0A=
+    asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+    asc->dma_flash_mask    =3D 0x1FFFFFFC;=0A=
+    asc->dma_dram_mask     =3D 0x00FFFFFC;=0A=
+    asc->dma_start_length  =3D 1;=0A=
+    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
+    asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
+    asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
+}=0A=
+=0A=
+static const AspeedSegments aspeed_1040_spi0_segments[] =3D {=0A=
+    { 0x0, 128 * MiB },=0A=
+    { 128 * MiB, 128 * MiB },=0A=
+    { 256 * MiB, 128 * MiB },=0A=
+    { 384 * MiB, 128 * MiB },=0A=
+};=0A=
+=0A=
+static void aspeed_1040_spi0_class_init(ObjectClass *klass, const void *da=
ta)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_CLASS(klass);=0A=
+=0A=
+    dc->desc               =3D "Aspeed 1040 SPI0 Controller";=0A=
+    asc->r_conf            =3D R_CONF;=0A=
+    asc->r_ce_ctrl         =3D R_CE_CTRL;=0A=
+    asc->r_ctrl0           =3D R_CTRL0;=0A=
+    asc->r_timings         =3D R_TIMINGS;=0A=
+    asc->nregs_timings     =3D 4;=0A=
+    asc->conf_enable_w0    =3D CONF_ENABLE_W0;=0A=
+    asc->cs_num_max        =3D 4;=0A=
+    asc->segments          =3D aspeed_1040_spi0_segments;=0A=
+    asc->segment_addr_mask =3D 0xffffffff;=0A=
+    asc->flash_window_base =3D 0xA0000000;=0A=
+    asc->flash_window_size =3D 512 * MiB;=0A=
+    asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+    asc->dma_flash_mask    =3D 0x1FFFFFFC;=0A=
+    asc->dma_dram_mask     =3D 0x00FFFFFC;=0A=
+    asc->dma_start_length  =3D 1;=0A=
+    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
+    asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
+    asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
+}=0A=
+=0A=
+static void aspeed_1040_spi1_class_init(ObjectClass *klass, const void *da=
ta)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_CLASS(klass);=0A=
+=0A=
+    dc->desc               =3D "Aspeed 1040 SPI1 Controller";=0A=
+    asc->r_conf            =3D R_CONF;=0A=
+    asc->r_ce_ctrl         =3D R_CE_CTRL;=0A=
+    asc->r_ctrl0           =3D R_CTRL0;=0A=
+    asc->r_timings         =3D R_TIMINGS;=0A=
+    asc->nregs_timings     =3D 2;=0A=
+    asc->conf_enable_w0    =3D CONF_ENABLE_W0;=0A=
+    asc->cs_num_max        =3D 2;=0A=
+    asc->segments          =3D aspeed_2700_spi0_segments;=0A=
+    asc->segment_addr_mask =3D 0xffffffff;=0A=
+    asc->flash_window_base =3D 0xC0000000;=0A=
+    asc->flash_window_size =3D 512 * MiB;=0A=
+    asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+    asc->dma_flash_mask    =3D 0x1FFFFFFC;=0A=
+    asc->dma_dram_mask     =3D 0x00FFFFFC;=0A=
+    asc->dma_start_length  =3D 1;=0A=
+    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
+    asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
+    asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_smc_types[] =3D {=0A=
     {=0A=
         .name           =3D TYPE_ASPEED_SMC_FLASH,=0A=
@@ -2103,6 +2197,21 @@ static const TypeInfo aspeed_smc_types[] =3D {=0A=
         .parent     =3D TYPE_ASPEED_SMC,=0A=
         .class_init =3D aspeed_1030_spi2_class_init,=0A=
     },=0A=
+    {=0A=
+        .name       =3D "aspeed.fmc-ast1040",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_1040_fmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi0-ast1040",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_1040_spi0_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D "aspeed.spi1-ast1040",=0A=
+        .parent     =3D TYPE_ASPEED_SMC,=0A=
+        .class_init =3D aspeed_1040_spi1_class_init,=0A=
+    },=0A=
     {=0A=
         .name       =3D "aspeed.smc-ast2400",=0A=
         .parent     =3D TYPE_ASPEED_SMC,=0A=
-- =0A=
2.53.0=0A=

