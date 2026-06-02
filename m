Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B71FC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgW-00041l-61; Tue, 02 Jun 2026 01:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgM-0003yh-3I; Tue, 02 Jun 2026 01:28:54 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgK-0002fW-6n; Tue, 02 Jun 2026 01:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naQ+Id8j2HjwLiG6MusG8Jm0svm5EQ3G+yM3FQhR2LoV/e9jAPnz7PnroEJt0B8n7DAf9nWHgkjlsPVO7CBJ7/CbJw+kgLjhCiXL9KE8nriv60lRsxtnhvPJES00R2IpklFz/x4WHOC/2ZcEfygf3LK14xbs1JXQ5WiJ/zN7ua8apNnkm3g7l054c6iWWT8dmoWmZ3446tB55QEkrbn9qyt090/AaaEdm4yY5ITVLdboxgRRzIcoRi5P9FSFBEag4yQyLTl0+/NPkha20R2xOiq/ZtYaCbUXJNyraqqbmhyOEM8aWQQuqYYY4E/C7w9RUSPw5n+I5JyGSCTtc8G5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwqQTMcIbbeGHj4DzMKq3QP8GMmsA7i24EFJRkLzc1I=;
 b=ybBWiu8Me9tvEF8n1sSO6aGCZx+Kzi7PcjjXFLansQOpWcfoyuNH3DKu/bizTMfczTu46c3aZX+5BPeY8JuH/9vNns9rBF3YYrgN4ru6OX3RvT0NQD9eQcDID0EogEDjr9krk8hMkJ0wRLyEbva0PdLqprXA/mAQZe+MGNlVuG4Tp2/fOW3Ske9rHfRoMpidCwiQJEyKTbsX96gWmBQKANawwHb7LDDQBiyF+blzZswlQfNNxk28huKWcoonCc2JwpBuaRgIWkenec8e/e3jnyj+PmoxXNGvqpV6nCl8tLett7BkelFHoA8CcDtRRY4rsCRL8bhzyK7bC9WNvNN0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwqQTMcIbbeGHj4DzMKq3QP8GMmsA7i24EFJRkLzc1I=;
 b=lRV3ZrHrZageANYVixzRp/hqvFDyfajpcvBnES3PyNbVUgiwRWOv5u0idFF1xA4IpWCRKupwgJXX/96RB5Ysyn2z5h+du1PdY317KTTB7IfiNC4Ywyz1gfRRIFzRx2MUOj0UOsReBI9SCVBNphLaibWkrdGLYqGb/B2dm58CfJvYlquBG4sWcUI0IwxPflbFODeHbhDR39Ekx4xxJixyo9hBCWuYT/bE4/4BD+zaUWMndjzvpegjnrPU1Gc/5Yw1Haub+kYDrw5kHoQZDbJQr3I+7fCKCAM8MF4eKUgLxGJohwevHgWnncpquGmvLV2UeAJ7euvAwOVYnA+n26LOMw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:34 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 05/10] hw/arm/aspeed_ast1040: Reuse AST2700 GPIO controller
 model
Thread-Topic: [PATCH v2 05/10] hw/arm/aspeed_ast1040: Reuse AST2700 GPIO
 controller model
Thread-Index: AQHc8lComJ7O7DjJ1kCe4lV2qHyMGg==
Date: Tue, 2 Jun 2026 05:28:34 +0000
Message-ID: <20260602052827.1535299-6-jamin_lin@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: 19c208ea-06cf-484e-0a3c-08dec067caa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: ePCl+O9Y+72Nz82rqRE3aMONR+MCXcCvCDpG6MuH6eUIryfIdqtSYj5zDqs/gIuQ/zGkYe1jElfJdH7zbUCJ++9gOwDZ6JzyslTm3kouoA7yRdhPXdnQLz7iBysmVJ4CyTDrcjTOxkDaxlHeujZOckszrP1j7QDWtDlaI5rIb6GJnERr3qt6VtVgzoRC525EfGdGrdyprSZQ3EFe2XOcDaMSC1i90LglyKo2esu0jg0yJbkUsEK6LTixdL2kd3pUT21wSTCX9f8wqS7MZCtrqvBPhprqgN5c3e97GwjEhjq/MbNXO5T9NuExzWx7Lox/CTAKN23z+pRDBM99gSbHCqaVe8fAh/Q/6339470lqx5tRWoYYo0VbHlthY+0h+Mj57P3CWJQNhuy9KQ3dkXmtdo8P3voJUGZgpsmIr5ZD7eWeilu5IpLH3IGu1yGCVzmuq4tTLWUW81+rSpjTMnt16MIal/yrKavYzV7zkXOlIEA8HQ7UShakKjHGdQouqkVFeUv6YDzsAmxv99wtv9guDh8N57o8Lqj8VdeWGJxfNEm+dpxTOFFrVFQHcRt7kYdcFEUQuDsiZAFj+9KsIkWvxOi0x5p4r6hK2NxzW2iPuHN3ouGmK8mH2l35aINc/5UH/GECxXfgGHfndAS4fbySWn2Z6JpdLF3dZrqGQoPkHVjZ5h6MeeeTNEIulsPO0D40LY6dEym47WLim3OCtQL5sLINMgeJEeMZygMZSvMbMGcupf8h4Min/2ouUp0hdwo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/i+b3nrUxdcjAjnEhfUHAtT0xCfxpGy9LPFL56uDYBc3j8fBQsHG1orbXb?=
 =?iso-8859-1?Q?+/X+yCngTzCiYK7nDVt4a9+ZTxPEdBnxORNBKuYPwHZRngz2Z7bN23b7uI?=
 =?iso-8859-1?Q?d5+0TdGX4mv/wZueThK1wYKopZWfd/uS1TbF6itTMcPCr6SIrbxIUURYL2?=
 =?iso-8859-1?Q?0HeYQa1YO+awQsnuUjB8/sDPvdO5xdWMFDkFjdnsQ4I90DtfEmQX5DWsZO?=
 =?iso-8859-1?Q?k4NX2Q081sCDqlZzcJbfMgLW6E7kAkunJ+rbN4jgq+8AzI1sNCOXy5l74F?=
 =?iso-8859-1?Q?VYo8zYZzQOYAAY9Wtg2oVPsSC3NkIjlgu4/qI24lkpsgwCfV/GPfRF5b5o?=
 =?iso-8859-1?Q?w7VA4Nst8FL27Ss/HeJ5szsu3/qT8DZ5BiGV1qVu6EcCOU6fKhldS2YO3j?=
 =?iso-8859-1?Q?oSoDrUKwWl5JcwLab+xqLdZ89BM1XuRblVyA9FkixT+CSaAQoGR2UXxVF2?=
 =?iso-8859-1?Q?h+Ng3QmaJ6GWvpZA/ndCfiUBAQi3zvLWfHt4/L1jMNnCL/6DxWtpOUtCNL?=
 =?iso-8859-1?Q?2XJvLMZZKTzOV1YgmPC1PU7RCAVsdde9jLjU0f4z/nWnFbaDm93Hc79R6G?=
 =?iso-8859-1?Q?jYc0sHFIp3qdaqaby3joQNrwtOuoE/HT7d1efru6joWGFSbkc+zzyh5Yc1?=
 =?iso-8859-1?Q?3UztEi/KMqbDqjpfH7wjNjyZFNPmjUmqgq8d7yOxYQr0669lRLCEL3lm2x?=
 =?iso-8859-1?Q?hg/bUP9s1nMCNHUlEMyl6ZTM9Hmo1uMl0jVHMd14iRKOCwpCyWuJCPfTzt?=
 =?iso-8859-1?Q?WgolnfR+dKon7fciJRxcXy9lhTYDMMlhfXMP7eip2Ury+ap2gkJBIyWH5Y?=
 =?iso-8859-1?Q?Eyxe/a59QJuj8MugCk9Kn1bSJgZ6/DbEhVqqGjf0f8gvQleg+u3Y0oL4vK?=
 =?iso-8859-1?Q?7FTU2lpQx7HKoSXqlWUvpdfnXdNFvctCGt0DgeTQPazlBL0kxb2q7ZAbVG?=
 =?iso-8859-1?Q?0/EOVG/JhpCSPLOjr8/6SSiwtnxAzlERdXBolJd5mqC+yHx7jXLgWtibO8?=
 =?iso-8859-1?Q?VA60buLw0+ioyvhqGsd8MxN6I7rJ8y5viIsQZcLmO9wkibFdpFF/nFXkYN?=
 =?iso-8859-1?Q?wU5+e46XXgf3fksnQiV5NOp1I2aZo884XjnKKJLHk4RDdIdBUJQaZGpu3P?=
 =?iso-8859-1?Q?3ZNSqu14PUw+Wt1rp5N7+0LFBPDU8v2/LXd1rHQ1a5ZRrBNyuShD/Kc0ns?=
 =?iso-8859-1?Q?mkdar49A2X2A3Lg30z/sz5dd31MS342VhlfVQUEjbcjOYi4K8+T831DDRL?=
 =?iso-8859-1?Q?t0MGAbfA4crrGLbeopf3MblqebjSjxuHnIRFv9oQPgzq+WjDOwCKILtQQq?=
 =?iso-8859-1?Q?aR3EJf7j8F5Z32oAMhQFzCdsfx+JIppxhbhlgUEXPfBX4hk/MhsHfVXais?=
 =?iso-8859-1?Q?tQbAOSEVG75VIcKFRJGefPHzE88AYrq37uckCQkHv0WKbAoN620yOuFoUM?=
 =?iso-8859-1?Q?4u+LS2n8dPalexFB72OqSCTkvd3MCLBjt3ELW97CzStH9l9Htp4Yiyjtff?=
 =?iso-8859-1?Q?815QiBJ8vwsDLNDKAiYf9A+7esYHMkH5MuIbYZUJ1An8PkhLxKIc3PfErj?=
 =?iso-8859-1?Q?BUIKDSkuBvSBjbNIR1pSyFPI3nTHktwamRYLAYaQCylqcq3JBXLJwVtruU?=
 =?iso-8859-1?Q?LzCxi5QPk0nEuqQhbu9+s2GA3ZSiH9ZNeFJjQUqfznRp/MrLhgwPSJwTFv?=
 =?iso-8859-1?Q?cDOGXMwW98TavnvsRbGlIrZd/12MpgxMzbHubBqcwlKx+vVhzEfNFCbb8/?=
 =?iso-8859-1?Q?Wgbw6fLVHsJgNNMmYyU6w3Mdwno6wMW9JFhjMuW/9UQdL9HC+OhXKRWIZU?=
 =?iso-8859-1?Q?V94Oo87EBg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jaEpqWwV8ubVEU/EYCvKMaU5D6y8j4gHrqUSlQOZYm8538JW9+r/jkroqGf4zA+ffo0nTn7eLWAnzoU/gUZOFWsLmLasy2XJVNf+8ovCkuYXW1ddqyX/UZN20J7Rm1sRusz8wLP6JMsd1xwBdqkVGFgIB7lNTKerFXwA1XaO7spcwr9h2nI5sQC/xFlkdZ2XAEKoqv0SwBxvkFqdhWVsqJ4JX1vHu3aRL5Yf+KMcIEFrlPVE08PS8HPpSCmvIOFtV/9msChGhwXP+CAeWGj8GvbRf23EG2DDiLGdVwUQbcHMP1tGYhzYrGWrQ9BeceD0mXx1XP4aNLGtArSZesoLCg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c208ea-06cf-484e-0a3c-08dec067caa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:34.7132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfdbpohZW/6x6uwSkwGK4j0IZVMjEpzaXVXjspxl6PlpWwrEeg7BlOQqJ5LjLQaJMCQGe0g7vFBtjCCkW/Lnz11VmWxrQO5FE7NPnzAqmC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
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

The AST1040 GPIO controller is compatible with the AST2700 GPIO=0A=
controller implementation.=0A=
=0A=
Reuse the existing "aspeed.gpio-ast2700" device model for AST1040=0A=
instead of introducing a separate implementation.=0A=
=0A=
Add the GPIO device initialization, MMIO mapping, and IRQ wiring=0A=
for the AST1040 SoC model.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 9ae0a0e7a4..c6b22186ce 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -111,6 +111,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
+    object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");=
=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -211,6 +212,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
 =0A=
+    /* GPIO */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,=0A=
+                    sc->memmap[ASPEED_DEV_GPIO]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

