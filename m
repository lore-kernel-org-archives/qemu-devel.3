Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=A1PN0CTt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtSg-0004Q4-Sj; Tue, 27 Oct 2026 22:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSd-0004ON-CZ; Tue, 27 Oct 2026 22:32:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSb-00082k-I8; Tue, 27 Oct 2026 22:32:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA0JRb8z7Oeq5cxBcVya8XELu0o1qOVvN6A8QUTJqLL8X51emocLKJGXYqqRSNcUxeqL3eJU9/I2ohwTVNG543sq9WWqmG4eAWLvK+adcSMjglJC9V1aIToKfCsA5W9GNjq3QkAkMRzL2z32avaFIqHyi+CdzQYbYBj/v/vm56DbCUxmcuzRi4+XKRV0o8uP25jflf8rynhDWuAYWnitei324KWid/ie7fEpqcp0gJZYCpZwXhY0rjLSPFGmOuNclD/HF4YmELHIoQUo1L5tFghXZa9Q/JVtLkpAt1zepFQyC+2BH1dhWqyJWhYxjyqD8yVbyt+UP6Zlwyz/mRsnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bigdebF8TwkcHgHZieTNXiIlTECdlab3W0K2zu6g1+4=;
 b=jf60WHVJH4kDNkEhJVHep6oDUWL3kCnaEUdQyNt6EjxAoMHUWbg6cr8R3c+2LvNpy56iY/HEN4tSDjhjVadsXvsn02X6AH20ZArEcgISyD1Zh1b2h2VAHC4IA7ifVi5kr/kOwfzobpiDqpRxrWH/S8+NxB79tm38PDpB6nPYzY9i/5DPVFQ8lqPHOcexucStyQjZXNxD6nqvYPzUChE1/4qr3L25uEyKjkreDjscePmNfjlG+d/ngEaJcHl1ksDTGyQlQz6Bre9ubLs/vEykNF81lWh887eWiZ208vI6OK1zV6zi9OUYWVWElmZkXh0K06XIenWn26kKAFuliOQZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bigdebF8TwkcHgHZieTNXiIlTECdlab3W0K2zu6g1+4=;
 b=A1PN0CTtgRCmTTpBPxI/JF6Rrb903KDfTt8InMr751CmchErm969VrzYwnBkBou1Wh2qeJS0Ec3vDlPf503rmdYPpJ5TZGN2rn1Mzlx2voNnSEkT45sPIXpEatsU2Mmp8CICZQOKj0Dc16MmrRQrqIf7r0PC3GGa4dCNklAXWRSvzXyQipAj+LX6RAbJC9i2gQQnqAYtPGbLzzvUM3Hd94x5Tb2lMMzXWeXf0/VfzLjRgt9DikypeEdiViqFyrW8C+K8d74qus4iJHEOXSDPXuL8Gnzk3S23pS2HtOjqc3wsj+p9/szqDqyu+VNlWj3LyD3lH/Uxgisqvrr6RulZQQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:00 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 05/13] hw/ssi/aspeed_smc: Add AST1040 FMC and SPI
 controllers
Thread-Topic: [PATCH v2 05/13] hw/ssi/aspeed_smc: Add AST1040 FMC and SPI
 controllers
Thread-Index: AQHdZoSCkchUXX8rRUag14Z5z69XiA==
Date: Wed, 28 Oct 2026 02:31:59 +0000
Message-ID: <20261028023154.48395-6-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8531:EE_
x-ms-office365-filtering-correlation-id: 5d0d15c4-5514-4e57-6b88-08df349ba4d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|921020|56012099006|261026121527099003|261021121427099003|10067099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: EH6D7yTI2QivWzly+uyO9F7iLsBYmQ/YicgEDibT84FyLvaK/L576pELALJ18HlZQ94cXCjEbNhsEtR6isGz/qI20gOn9QwDI/PXFS/yKZCcY8KM7ZATxVn0Mg2XmCDQ+waJ5FLAKj7MXcEj7/b41ohklmJheW4H2fftF3j3wEB+3N6QEJLWKgJZKrYoHh4qVQTHSbMtbCUwbSaXvJ1BWIpYl1cR74gVHl2oEqoLSKuQh1gvWLAroxZmCCFkiHaGgsMuzfiP/RDyfOvAiEbADAQjRfsM8CiuAqgmn6Ota/RKFhT9CErwezp+TQyxPWO/YGMqy+rDVtUWZKymiFPPYJ+6ds73duEfGAWGuajATvcm/IG74o3Yx8kmw1BvmpoeJO7jvTwXeOaBXRcQImxp413iubqzxocGSZaNXXZmr812W+mMF6rvjgZlTqhRzN0shi2jTDvO6vKvnCPOLJ26sTTewW6IElMEg+wr4tpEfVRYRXFk8hi5sypjPWTAXf12rAtk+q/AmgQAnrSvHBD+faUZ9ScAebz67XcDtWl7i4cvD6wD0zcYWmzuzfZBjG6qRX3gE3vLlABm+NJCZnn1zDJLFGE209OH4krz+N8iXJTXlRVYppXrf1bzK5zOPjrYlFhAAg/khz3h0IMYG8+9ARw/GVzhFb6iKfkow65/8XQROZvri/Z6qq8lqLLz/D/gf1j9/Gk6TUTOCBqYNGv2VnclNy405hw8fNfr3aI89fuQ6EWGQHgnIN5NIEpBepkt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(921020)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oUbVtYJdWmYQpKPrHsryQRfLdw/VDdpXzCrGrqxZogSIHTiD8ihYH7jYVc?=
 =?iso-8859-1?Q?54FhkThKkXc1f+ZXMUpfQB9wraTYv+38WJ3TJf+0cVnEKLRy2L8uegJnKI?=
 =?iso-8859-1?Q?eV/Hh91GIJTESGAnAJwKKT+1INtQbLbO3T80qGWkb5VhQ1DtqadUdUcuLz?=
 =?iso-8859-1?Q?pnZGSYewdDgtYe/iEgvduQuztH2kZQccmWZVGcqe5UGk2AzLMVgFhMdVfw?=
 =?iso-8859-1?Q?yzsWdUMpViluEZEmVI6NXcslzbk+Bx0xBZCyT7S7vhgDgO96+emU5FPQht?=
 =?iso-8859-1?Q?XnPSn7+gX5GZVya3ooUh5GEw1sPoJrdyfyf4xKZgHrWnwQoDkz8NhQ/S9R?=
 =?iso-8859-1?Q?MrdXx/CNAjFYk93j6N9thYy6Kae5CmV/08aMRO6y2yiU+CmLAEuUNe+9u7?=
 =?iso-8859-1?Q?hpC1z/T+nAjfz56eoKz2ngdyxdV+2H7eGti9DCEi50fElTsjJQdNWLjC76?=
 =?iso-8859-1?Q?RW0fQAvEJY23sXsCfpYBn688ZUfDZZxegIUedAvxPKFggvN9bF3Vab8qqI?=
 =?iso-8859-1?Q?ycgtA9yQj09RhL+CNaxs7zQPF20+w6toU1YpMAV4f8bLXMy9aaC4ZhBbnx?=
 =?iso-8859-1?Q?OYF10rmjjB1d5sb4RABijNaxPLH7a/WTxkxg4Lcv3C5pOsqyhx5at1dr8R?=
 =?iso-8859-1?Q?rUKyqS63GQTe4lBCQZMmiorLroP64b0lQjPnJBPChBIhdK3Z5KXIS+qwjB?=
 =?iso-8859-1?Q?51e6exR/qSXR24995l9b9J36U1JtfzpzG+cDnshF85BlBu1HoZAbib1tUy?=
 =?iso-8859-1?Q?4vFGXTl4685dxo3Je16JgXheqh72TSSWfgtqkf+9L1JBTO0D/+obpYTPMy?=
 =?iso-8859-1?Q?m1FYr+x5RQU7wBzJyFCY4NSTzjBaI83qqk7one9KF8ShVR9KeR7/i7/xIL?=
 =?iso-8859-1?Q?Guzn1kto2m2UcDtvUH0N2RdcVANXH4iR+/v2mrvJzPYmaFr2ZqNJ3DoXiO?=
 =?iso-8859-1?Q?tFSEV5on4ZFI1oSHwX5EYGHWTfhPn+hKg8gtNY6RecDImT/lp3A3SLbq/C?=
 =?iso-8859-1?Q?FejSj4K/hHFl2zkrlXiHKOXZ8JJkWVRG79n5e4/iYevcnDu/1jZv/n0C8j?=
 =?iso-8859-1?Q?bqanmP9Jyo9tA7G2zozWHwm4gmWtO+UjF7yrMPRm33R8BcVYVf2ODSo4Gf?=
 =?iso-8859-1?Q?0lJkECZhJsjoV9aFYG0WSTD13B8BvaElv5XgAS8msm6Joa88fYl7zT+/lP?=
 =?iso-8859-1?Q?5Ned5G67gkXq+xgrUoYeEK6ouH/0hD6bccZb9I0vzD1BvTcS6kDf6iuEg5?=
 =?iso-8859-1?Q?01DxVsm1M4EwFXJ+PCdzpiC0oTnK+b4riJqq6DnYvBHMSXjuRnGNPN1Jf/?=
 =?iso-8859-1?Q?O9jA5WNDHr48SHd0d2SYxysFaI5Vcpm5xuuKjM9vEiYcccSaD86Plg1aua?=
 =?iso-8859-1?Q?tV2Ri0ekVUcovV4mjQuGcCOcfhwt206LGwv3S3Mumqh41FLg5TheY7I8GD?=
 =?iso-8859-1?Q?bVZE5BkGPMqwR1ydmc3+x+lORS0wZpCjphrokMTpgGUgzPEyJ/kMdJKYy1?=
 =?iso-8859-1?Q?bTrM/9sJOelLkt2a4TiTnXgPJg9UPPEyjSw7SiF9FHsoqPD4sNBYI60OB3?=
 =?iso-8859-1?Q?lONApugEP3uo/x1AtgdL/dUolVE5QNQ/RoWLUID8mJRKeUvR91/sbZdR71?=
 =?iso-8859-1?Q?rjw4P2H8Fh5c2n/+OYmCI9BPudPrunDdva22hBD8szBYJY6ZpatIyFGOy0?=
 =?iso-8859-1?Q?XPTzssjVSnVaYvnVfwAQgpBr8pxO03+jwdjA8FHzYIk7Hpm7R47nOvBSkb?=
 =?iso-8859-1?Q?/EEdyRUjZ2TFgEe7HbYGpAQsuhdZXHOtMjRAPxW2/XwydPAKy2SUTtr2FU?=
 =?iso-8859-1?Q?rfx1Cen1vQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0d15c4-5514-4e57-6b88-08df349ba4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:31:59.9575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVjd1RgmBd+chTCHaMdY4CXgPXN6stTdJxvRBww4diBzZveXQ1I2cNVNCpR7Vza/wJPdXfpcuxvZTF1cCpNUYXdCb9o6LQFbZMiyRibjYXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8531
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST1040 FMC and SPI controllers are compatible with the AST2700=0A=
controllers, but use different flash window. Therefore, the AST2700=0A=
controller types cannot be reused directly for AST1040.=0A=
=0A=
Add dedicated AST1040 FMC, SPI0 and SPI1 controller types with the=0A=
appropriate parameter settings.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 119 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 119 insertions(+)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index c0c3666dbc..ec9ad0f747 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -2072,6 +2072,110 @@ static void aspeed_2700_spi2_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
+static const uint32_t aspeed_1040_resets[ASPEED_SMC_R_MAX] =3D {=0A=
+    [R_CONF] =3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |=0A=
+                CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1 |=0A=
+                CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE2 |=0A=
+                CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE3),=0A=
+};=0A=
+=0A=
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
+    asc->resets            =3D aspeed_1040_resets;=0A=
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
+    asc->resets            =3D aspeed_1040_resets;=0A=
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
+    asc->resets            =3D aspeed_1040_resets;=0A=
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
@@ -2103,6 +2207,21 @@ static const TypeInfo aspeed_smc_types[] =3D {=0A=
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

