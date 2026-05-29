Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E66CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqwJ-0008NV-3Y; Fri, 29 May 2026 02:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw4-0008JT-Vc; Fri, 29 May 2026 02:43:12 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw3-0002HG-Cs; Fri, 29 May 2026 02:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpXX0vKDILNe/BOK+rnOS28aKe5QnMX48VRN8t4SMKmSNYWCDrKMMXrmRb2IaJBD22tNC1KJHV/Y9VKhfOprG2PbDHNw7GTn7KSQOmXTfoa9sK+qRFco06cQAcGW9Lkn2d7IUREVslzx90C+HrTigU+P83Ka0RFFro+gZ69Ant3g9fDDhCttkUcbh1z5n9oGZyi58V+n2JKui2bsYidOzZavaAqdYfd1Pg721Yyz7JVYbQjYw0dWf1TuhSX9596eyVXQwuY8XK/NaMW+06iPc43HNGSH7e73znPDrdiLDnBv5beBMUxNTAAbmnuurraCrC3JCvl65bYW2CuQDX5CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhpeWnw2AVkwItFe/7XlUuuVikBz0p7P+0L1u2v9+k0=;
 b=o60/iD2sNPfiw6GAyvDhH8szIi7gtZZANrdKft2afMEPKueIJ3C+xO53lU1fb/7CkUxWRLksTkMhfwrsPRd8E0OmFjo65hgIhekT2skOrGwn7TL67pJYgenhtgMfzqMhRdNUsbTrV/dqCQbs/PeqxAZnAoNtrtnUW6jm54iSx0Jk37xY+/FODXpKKHlg8XwHHSYFsoILQPxfuGifUzP8o6fbClWlTqpQ8cBVJaP+NwNOGtDFw0wFlrPpzP7deuwmGddrTo68pZJ4XjzuUiWCAy5hFS47Mn8sngmcIP/iRSwh5JwEwLbxBiyMibL2g592I6VORFdNgp7uvUPsgRYLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhpeWnw2AVkwItFe/7XlUuuVikBz0p7P+0L1u2v9+k0=;
 b=JoUr/yy6GiFGH/hOS+K7uwokN+/vFTGMy2UNp+nKc/PLVYd/c6CUoN4BMSJQ+hU6Bqs7UySl+jmJtSAqvRDHbmlXoqieoMoKN0AbOGlBi7t74RXGv0e39QSDBvdckWKsRNQK3gY5ZdA6pdpVxw1GcJvPtHg944bykE9eyk1qClCbHviRinX9Ol6srOuAzep30i2cDcrRAPqPkxDDXjFy2smFNNJnJh8rqz5A6rn0sBByuq7JHYxicK7BZhJUshgHLTcqmgQromdj3ReOx4RysCmnUYA6D+BCHl88iQmn0DyUOsPa3aFzmxaRhGR5saxTrIBgx0umzQr9mAcNxzelQw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6063.apcprd06.prod.outlook.com (2603:1096:101:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:42:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/10] hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
Thread-Topic: [PATCH v1 03/10] hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
Thread-Index: AQHc7zZcTwcowaqoPUi7sdmpuDvMBw==
Date: Fri, 29 May 2026 06:42:47 +0000
Message-ID: <20260529064243.2064188-4-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6063:EE_
x-ms-office365-filtering-correlation-id: 529e369e-3774-40c2-92bf-08debd4d7f35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|6133799003|56012099006;
x-microsoft-antispam-message-info: wI0O+WCqylu47EogXepH15tZqm6ExjwdgZUPpZYgqqCpwo3QScQDL+6jYBJTv2PUPD+ro8vjgrKWyzKfkV3Bh+d+dsNr1LP8FGp8alsR6dDFMr63R4sUETcz7Pp32yPEKJZ2F+xjZ+HaKoQcMi6D2H6urtYyOZVmOtNKNdFLGhHThX7uuqTKjEAkCw1A1tmmwdfC3FY85ur5LiFr1VWfevLXwxwPCqt44ETEtfgugH+T/aUeOm1g+F+4dl1EuaQIvEJqfH+iSfCZziPCtLd2oxkQNk+e9DGEaA/x05ohmxC2ECEjdWnO4W0Yj0Icw1JHW2bAx2Pd5v/snsWauS4iVpZ4bOJEpCA3uBt4UL2Byzkd2TozqzpkVDM4MJKQ9tG9PjuhqTux9rWhfC1jy6TqW1Dgq82EAlSgtojnIpGRflI0G/ngwKIzmzJ2Zqwoy7wHFGt/LKb3OClu3fC2bswvKC5DYwRZvxXrlmJ900sYZ5fPc6e1Mukm8VEkOrW3bReLSqS+BDoSYdUB3qT7ygZfuw30C8KKTD5US7LAPr+65ZPpRZdNRr6qRujDFhHpiex4rgSWOAt8onbwzWbJL9qc8SodJGVjbQm2Ttsem6UjBu8hpYAJANzFytmxzucxAXf0tGQPCv9s1VVi3QnQnLdpj6nQH/4iRRF7ICrPxwMSkMvCX90gGh00cCn/0NPpef4E6RhWiwEv+thQxcfXLm7Nri1HslzermgRfrIEQKK8wM2UCHhIMmmPDfJ6/gLFCjlH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dxltsZqVqMOXqmwNtxJMnxgRoLX8M8TV9+I7qyk///pXsLKqtai+LHu8je?=
 =?iso-8859-1?Q?RqtysmH8uyrF1OLFUh7aIQe1MWNc6EJCGK5wruo6jW3PqS03ed/j/n8+zN?=
 =?iso-8859-1?Q?4weerae+hz4ABdJbUcuuSqj8b/CD/BqXIFSa3OQviaWNyMVfg29YoHr0Vk?=
 =?iso-8859-1?Q?tGjjcv0Oi/7efDAKKDhFXB9S4SunidiMLS9boYINVwY2q7hINgvzb5q+k+?=
 =?iso-8859-1?Q?sP+/cMeYYHfaQigIGqFDUxEdDUff12M4K2/vZPLktPrHvJxfgkDCYBE7U6?=
 =?iso-8859-1?Q?M0DEdq5v0KxPifRrC3sRHDfSb7d5YpdF98kCq3SbsksXxFEh+zVcg1KmC6?=
 =?iso-8859-1?Q?0J53+iN21cDrnQSkS5tPqylXP4atRE0m8QDlO3RdWfq5b10jetU5TsTEjQ?=
 =?iso-8859-1?Q?vy+VRhRnC4RHPL6GQese6UuiLohAkf1r5q9P/IUJJedP1/W+EItwHPJbcE?=
 =?iso-8859-1?Q?Q4SBLXJ0EB2cqOeaoVahyVlu+dY1hoLmVxHi5GaYu1vcAvDoaB0Dpoa/VN?=
 =?iso-8859-1?Q?8ezJbtUal5g+fZJnR23BRdlEvugMNxGz8fEIJ5Q5wpGGI9bv9nPteANL18?=
 =?iso-8859-1?Q?rB6imigfndG+w+JSLl1JDnEtZNJrvWwpZfS1p8KYvnF3tP4Ofk4zqkdz63?=
 =?iso-8859-1?Q?Lvh+6KLywKEGNZYE+3d92opurpFB84QHUjjL0m2dFv3bwO7E7pjQMeRzkP?=
 =?iso-8859-1?Q?mn4JtU4NUWfZv+aphekxJFy6vGrVdh1lGP0jrjpvPj7w3AtA4oibK9lv1o?=
 =?iso-8859-1?Q?Z7a6XL05hOdwnf3LVEFRfzedXRTFLiSAdCy6dS84QKOwaeNSEgWWGgeh9o?=
 =?iso-8859-1?Q?IiHr7/4DcIxwJyLtggYQJl/mcLoMkJ8EuMeDxMfLzPfLYwSbM9DwSPBP05?=
 =?iso-8859-1?Q?hSFh7vHVeXB82W/jAaCafIlj+kH3SktMlMm8lDmQ+x5VkkGqLzIrhTt12Q?=
 =?iso-8859-1?Q?Y/8atW8HN4FQdkfScgRfBVeq9I5B8DGG1VnRVCFV7+p9fsG2Jo/BHMjOln?=
 =?iso-8859-1?Q?lB8LPScAM+/huwLUxCPzxaIYiXDXj+UHPenCK7e1hqXGMzmTSIEfxoaMJq?=
 =?iso-8859-1?Q?pieQcqS6d45z8IIO7JPrhPRerhOPu871cPY7p2dtQGtC+EDyq+t5XbOq5O?=
 =?iso-8859-1?Q?sDTyTNguFpOMFgZ2I/3S8MuUYCKd0qxO0teZ0HaKtgTHUOwixL+fHlu1WZ?=
 =?iso-8859-1?Q?9WTT/gz391RH6ud6AvMVqPbgfMMBzmU9rA64y4o5QZkhKVZrO9o8HwtbaM?=
 =?iso-8859-1?Q?gta4uZR4p2o8WVCImPDhxm36+swevehEAjTQimfM1f9Aq2FzoRxKV2SXP1?=
 =?iso-8859-1?Q?KPuLp46tNVj43E0uKMAy+NhENI01Nby9ywnVwRtxHdRTg62xOK+0zrzHQ2?=
 =?iso-8859-1?Q?c+AWbFwhi9awxxv9mfITmOHnsWJkASxVIO/YNysdW4C0tlbVeLSR3WeH9c?=
 =?iso-8859-1?Q?I2CjVatrKYEYRkJ8C1sM2lRYlnh0ad0ZthIGHCWTKAfzZ5OpU8O5AbirrM?=
 =?iso-8859-1?Q?LD2oqGSdlLpvxCptTLvSXDAdXcNxlRP2DRPZ4yC38x5q3A8CRJ/cm3da7b?=
 =?iso-8859-1?Q?nLpBSS/rf1fwcS648IsH9+A9g2j+DPaVdFzAUtf1T7UzF9s6K4pBp+BsEB?=
 =?iso-8859-1?Q?k1b5ysCSyDLy1ShSgRU4KR5WQntCuPUtc1VMUaEW5pQjBLqz4eUbrkycap?=
 =?iso-8859-1?Q?oOA5HH/lvYfBfxnbyYzdNRuDKq0a8VaLolbxiCyYt1CtHrGzhYmOEyP9fJ?=
 =?iso-8859-1?Q?m2Bcj4Z/nCAaat8MvboRpPqFIhO+Z75ASdjLw4NfdL9NZmeUOPFata1CO3?=
 =?iso-8859-1?Q?xwKXw2PltQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pCu1aKiDA9BHTNvMZiYGIJiXcwBE4rQnYHUFvRT8djTL3ORxjXTi3hNzfL6d7f2FAF2BwtZ9KPp+hN+NEd1b+UgtN7GVjGiGHtU175i0ID10qlmqBS/EZhnhmmPSYaW7S1T2eaYpJ9EOtPSA152fQpXhU5/qRdJoXUWRaW8uOqlcme0l/UGr4S3pkTB71UUnR766Gh+S90Aho5hhL5kKj7RORVLzuScL+v4eWkphRCSzLWItU4TxZ0+SXlUw/j6FteyZHaccWoPc8FImca/h47wwUHWQEXiN9A1CDaYJ7nrFP98yPeEFgsM0gPa9eiGvrzvSidfNJ4S7NvLx/K423w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529e369e-3774-40c2-92bf-08debd4d7f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:47.7063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aXV/wTd73XWtx8U68Zm0phbAGb2E0AmyM6geRKhXYbLDQ+FfKjY18DKe0ofqwfid+e0DvYGObioALHLND8OLcnm1mjL5jGRP0bTWahtbO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6063
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

Instead of introducing a dedicated TYPE_ASPEED_1040_ADC model,=0A=
initialize the existing AST2700 ADC device directly for AST1040.=0A=
This avoids unnecessary duplication and keeps the codebase simpler=0A=
and easier to maintain.=0A=
=0A=
Add ADC device initialization and realization support to the=0A=
AST1040 SoC model using TYPE_ASPEED_2700_ADC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 11 +++++++++++=0A=
 1 file changed, 11 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 8efcdad8f6..b736e690e5 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -107,6 +107,8 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_M=
M);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
+=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -188,6 +190,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                            aspeed_soc_ast1040_get_irq(s, uart));=0A=
     }=0A=
 =0A=
+    /* ADC */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_ADC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

