Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E5CD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu4-0001lx-NB; Mon, 25 May 2026 01:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtx-0001Ou-Ql; Mon, 25 May 2026 01:30:57 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtv-00035Q-FY; Mon, 25 May 2026 01:30:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcUSrU+mqw0JkfRzA01tknRxRsFirenptOc/ua8y85cC/iDykiLK1ZvgK1pL8D/cjdTGN4G6vrhZbHdqNZg4HuSjYKgzG0TpwxvtTiv2E+LiHbnhN+tkPKD6Q7jHf3HhU40pzQf0pBz+dLk6YB4Y3rgwOITFNJthbPkKPduaaZ9X9eMRRFeITgM2gPxM7AjFzvBAOmyAfMYjMR6JNtr4br08Oc4yzcxrS7CCA8CCsMYoYNN5xkWF4JwBJmTI0z7+d4zVrRpsXXEZRgcVn+OENcgpIDUYZkoPHM2urpzkuwCsDnhxccJrQHL55r2bP9IJ9TE4H6gYiUao8kIJujHplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo1a8SUdTnJIY8npVHhQyWaGtar3etmHiBtr7n46jaI=;
 b=Ci9fQ0GE3+3+SwIgKUvZd9ahxE/QrjjjTZzpfqKFVEfowNVzdoMpmLiR4lAK2B3ZjFmxdLVXYyRGWx32TtyvkWnzDzeoKq03howRwqcYPiP3MRsHYlUhjbYktmaoltssnzMe/2lwHraHGL4PAwGBM/BGImRlAANMiXjikA/D1KZWfn+r3hecdJbPf0lSb81pjB1tcSrfH1pbra75lk0Z+9iLu27wNS0AJUApl5aKHph3QixgHuNG1k0nXVzUX/h6WNfbDVuAZEuI7JUXd6MR6/cPQOyZGsvxCbkI7gnC6HjxDpHWqTkzx//gguaxfqSLLlRfHKgkAcLhN8DfcpjwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo1a8SUdTnJIY8npVHhQyWaGtar3etmHiBtr7n46jaI=;
 b=UGANgDRM1G05rX45Rn8MOFRbU7UIEfYOGxfZWUdh4pBDeK7F+slZWIA6BUMPWE7UFaXbkgPWaYH7Bjo6k4ZTdoVLd2A8xyPJf2nm1d9s4/shOHfGC2Rte3pow6EzxhTSfCQOdVW9+HQrw07qfmN5EHtF0jEOhbfc1Ffuq9BKMfFzT13ZRgOcFt3uXmBDks+/xTSmQhhl7r89TjYBV8PcRpfjR47rrIqTCN6t0V+WwAObDGI9tLiOeg+nEAgcAWCf1X1SmoROeE1utyl0UclyKMxdH3OLlPQcuF5RImBllcUdDZjydrYPYkQxFPyYwjKOouLYTVppY2DMPR8sVkQ5/A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:42 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 3/9] hw/arm/aspeed: Rename SRAM memmap entry for multi-SRAM
 support
Thread-Topic: [PATCH v2 3/9] hw/arm/aspeed: Rename SRAM memmap entry for
 multi-SRAM support
Thread-Index: AQHc7Aeg/D0g+1DStEmbXTHsE4Ei3A==
Date: Mon, 25 May 2026 05:30:42 +0000
Message-ID: <20260525053036.3305181-4-jamin_lin@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6657:EE_
x-ms-office365-filtering-correlation-id: 714054b1-bd1a-4d08-879d-08deba1ec349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: 3ZCNbLxFJBxt4MUmuc+r1FZIBPnFxCtogcayAYrKr04RbAGr3YihBoX033mjKi05JmzNtYKgyPhtvETzWVxXlIBAw50RpGfiynZSdOUlAXTmSiK6iKdlYXe1E16BmeBK49OsPXpK9JplUqce3UBPPrSzu+FwOy5lVc5yxGvPlgW5rJS9qtIgfUKGrBD172QRX4q1xlB0RdjokJpUbqByRjPyq/fN5DYOj9KP3rnZwb88yojcu3nnvoyeE22+D4BjALbX6QLIxRCzVVICtP/Id4txanLLkGvkK72NT6wjCXKkJ0kKjDz7FeZ5OM9oKCdDb/Z5brVx5VGn8q8vvCJ6fwRX3pNDz1GTjPk1YG5kISAdaew7ztaSCBIDjOOu1aCW2bT9XG/bcdAlac8ruGDeF/yCNRFXziqb4BMTehpQmgYcYcPlOZBkANvP8t3gRl/Oc7Gd7aBZ2wU4EZYajoPU1KRoULzWxbg9Y2Ojou3whl+iNhZUYzuL8NwXjZq7REZWsbta7nP0jKHnP1UMzJ40DNGdSr31AzF3YsHTK+/JiNKEeFEKp448WmAj3fuF90hI1CyGmKa+Bf2XuFVF0sLjOuFKJDI8E7+yXauqwt2zximeDBUClJoJjJk8dfHL/XO5i0HeDTcPUpqw67dkFYu0CAga0HJRRuznJVFjSOVphAOi/7KEfI131hiaFZDGWD52pZjBvcb4yDeXh7Rd3P1u6gaUsvTaD/l00EQ1wpiCacj/4YA2hsUcXmLvqMXOxQmvUDquEnRYzhpRDdy7+P6Reg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5QfM46ZyP+/8kyAHZeOS2yzeDjEogwa33FQ+ixTWes9nBKu9rWfC+rM8fU?=
 =?iso-8859-1?Q?ob7Zk9NSW7K1vG+PRjn2fvJjq0lKtq3EI3ZB68zo/0PQb/Z7pLABraYL9+?=
 =?iso-8859-1?Q?D8B1RwcI3nCJ/aWPO4+LTPzT/s7krs+d91CA4hNbSY6ZDnbPzkQylvXeUD?=
 =?iso-8859-1?Q?G4Mve9gutFubLO+8TUjVUfMutcAxBKBhO4KoFRuppV1r/Cx/prhXRhhUX+?=
 =?iso-8859-1?Q?6YvHx0YV9puGogUTFBqVFv9v4jTZluwTzXS0F0rF1QLKYb0xLi+9Gay2Fg?=
 =?iso-8859-1?Q?bSmDZ3WHZ13kvPgHaORxd7sj1JWRQkwM+4Ddh8/2joD7GKDmtEilNDWNpf?=
 =?iso-8859-1?Q?VFxX1vi9Eg/pJducsZedDreh3jsrXsZiHrVxRrJ7Y3i5dDjSG7lE9YMTKw?=
 =?iso-8859-1?Q?PfUtRUlv17y5hNxIpnPCzUAjt0XrEHVWz9+pH/fn5N0l0gsY67jV6LBjq0?=
 =?iso-8859-1?Q?K5NK6TBnD9H0hMmXIF0dCXMqt00VGbY9Gl5c3Iei4FrfSao7hzEDEHm3Dh?=
 =?iso-8859-1?Q?o61QipuSjVo6U6CtEPl11WkmvPPyMZ9KbKeK3GVSeyzFFUHUylc1l7JFOm?=
 =?iso-8859-1?Q?SWK0Yl2Uzc7xM40lSCaWzJnHrZHBEwMJd6nifiE7UPGRPiZuwHsUl2tXdr?=
 =?iso-8859-1?Q?teybqZIOBOayfDmkQIKl7MAuKLz9htnexWdDUJ31dTc94rkd+RSiz6HQNl?=
 =?iso-8859-1?Q?t1RCfHb0V5SH+4liOq0BPk/TLz72LQUKAqGjzVAbfyGDen8FgzVGPc6ebe?=
 =?iso-8859-1?Q?eQM1xxT3tGa9lK3LF46kFv+mqPInWnmAJtN0DTfjuK+u2XH87HTXic6KaA?=
 =?iso-8859-1?Q?xGH7kBTqATKVW0P7DNJ+Z6ihq8TmeOBDPnmFvGXqONB+zRZo0bFuKEolBs?=
 =?iso-8859-1?Q?kydLG7SYKQ147jk0xjmDyM+pgi3sc/RZxTH/YOkCNVqRUmPwGrHDDUXwhB?=
 =?iso-8859-1?Q?kHE/aRvV2PnzmjW2lnzhmDqKjZQYyjT5vNfEJ6wJl+D+BAPpyKJNzffJfl?=
 =?iso-8859-1?Q?1fxDze6FDHkAbFOrLakqVti7fQKtKoM7C6gRAV5gwl45a4uQouFC4HilaO?=
 =?iso-8859-1?Q?+cYX1/ZP1ZBP8PGVtfLDk63zDnZOXnbzHvwveUacRwJOZbA8g7iBV3Ghzo?=
 =?iso-8859-1?Q?F7pAwcLr8Lk90viS9Nyi6JwgM2I0GLHStUjymm2AQmiFYrPp9Pbq5X0y/R?=
 =?iso-8859-1?Q?J+N9MmpefFijK34+nJNNHXoVsi86HyA41o+7eyzadjaNf+6ThUGkC2y3RY?=
 =?iso-8859-1?Q?p1R5wFOEej44g11fkYR4F1+f4tVqnVxqIaanX8o9UoKMVeer6e/MeWgArF?=
 =?iso-8859-1?Q?meCITA5e4popqSoaDopZJvXzQY54vCcYTqntZUd/DxbFLxI5d1xyAc+J4u?=
 =?iso-8859-1?Q?HES0xHZYDJREaH8rsNonhmtKrI+HU8TqaGEvC0Xs9y0mShiPUtx828dg/1?=
 =?iso-8859-1?Q?1QmflbSwUTlTUc0OEl72dd99Ke7rZPqFjsscJXK2eRrs+BCdXGKwGOrDIV?=
 =?iso-8859-1?Q?7pL7iXPdV1vVwr2tBg0EossvW6AzcCiGXqqtKZg7efCLWU8Hw3PhkF8MYZ?=
 =?iso-8859-1?Q?wX8MpXXIIRidTNw5TQpU0yCPfbhFe02Qfp31qwWuAt4d5JNLeG8rv20BOj?=
 =?iso-8859-1?Q?gkRLb2Lse6Qwp6iBvsNhmBdqMYg8u+xl6sAByhKreOcrDXMQokeZossUff?=
 =?iso-8859-1?Q?69HuCc9xtwZz85DrbIFRMdGl07ITgHLt2sxE9I59JWIcgJXPP8zxCELBJE?=
 =?iso-8859-1?Q?YtNRnt5xsXYC1AC4ZvPyOxA2Lqrs2py9AADjTychIf3C/uqfdd5Huw115p?=
 =?iso-8859-1?Q?nwt70eOrdQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r0HqeSWPUtFsrUA0aKHjdDgRfOnTwkrf9acdOHmkmdKp4yIvOOusw1h4gxHK/oD1DyWP6pYhzXVc6BHOx0jfT5GLMsINLYd5BUjWr1ZnM6NFZ9W7injAf3UXC4MkyyGC275ilDc7KFy7vNLhA3Ea7k8aFwm4Mkuw89G9etFp3vRxIA2GSrxl0UmFSag5zIfnxE2zJpVZ5BzQ4sRLJ7OiCJWuamRk4kkScRXGO+xks0h96yonpnqL5iVve7xzcFXHHkLgOHbbcHszX0K/TFgaJ0wWZuS8NbZDM+h5c/bporHNRAQtP3quxE7ssFPhzV7CZEjHG8b79+xz1vQLcdaoNw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714054b1-bd1a-4d08-879d-08deba1ec349
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:42.1333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBF41o42SEpqtOV+O9+b5hnKWnNWwTU7JEuhLvyEQxgmPDSLIik4TmaWAqQZ6uzvrbvEdF3XGugsqma3g+0jrNAtY7VihmAeRpr7qyh0jec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Some Aspeed SoCs contain multiple SRAM regions with different=0A=
MMIO mappings, such as internal SRAM and secure SRAM.=0A=
=0A=
Prepare for future multi-SRAM support by renaming the SRAM=0A=
memmap entry from ASPEED_DEV_SRAM to ASPEED_DEV_SRAM0.=0A=
This makes the numbering explicit and aligns with the=0A=
array-based SRAM representation introduced previously.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 2 +-=0A=
 hw/arm/aspeed_ast10x0.c     | 4 ++--=0A=
 hw/arm/aspeed_ast2400.c     | 6 +++---=0A=
 hw/arm/aspeed_ast2600.c     | 4 ++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 4 ++--=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 4 ++--=0A=
 hw/arm/aspeed_ast27x0.c     | 4 ++--=0A=
 7 files changed, 14 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 3a7db959a9..dda602e9f2 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -228,7 +228,7 @@ enum {=0A=
     ASPEED_DEV_SECSRAM,=0A=
     ASPEED_DEV_EMMC_BC,=0A=
     ASPEED_DEV_VIDEO,=0A=
-    ASPEED_DEV_SRAM,=0A=
+    ASPEED_DEV_SRAM0,=0A=
     ASPEED_DEV_SDHCI,=0A=
     ASPEED_DEV_GPIO,=0A=
     ASPEED_DEV_GPIO_1_8V,=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 9e597a75ec..b55f788342 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -20,7 +20,7 @@=0A=
 #define ASPEED_SOC_IOMEM_SIZE 0x00200000=0A=
 =0A=
 static const hwaddr aspeed_soc_ast1030_memmap[] =3D {=0A=
-    [ASPEED_DEV_SRAM]      =3D 0x00000000,=0A=
+    [ASPEED_DEV_SRAM0]     =3D 0x00000000,=0A=
     [ASPEED_DEV_SECSRAM]   =3D 0x79000000,=0A=
     [ASPEED_DEV_IOMEM]     =3D 0x7E600000,=0A=
     [ASPEED_DEV_PWM]       =3D 0x7E610000,=0A=
@@ -247,7 +247,7 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSta=
te *a, Error **errp)=0A=
         return false;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
-                                sc->memmap[ASPEED_DEV_SRAM],=0A=
+                                sc->memmap[ASPEED_DEV_SRAM0],=0A=
                                 &s->sram[0]);=0A=
     memory_region_init_ram(&s->secsram, OBJECT(s), "sec.sram",=0A=
                            sc->secsram_size, &err);=0A=
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c=0A=
index c4e5388999..79a653f65f 100644=0A=
--- a/hw/arm/aspeed_ast2400.c=0A=
+++ b/hw/arm/aspeed_ast2400.c=0A=
@@ -38,7 +38,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] =3D {=0A=
     [ASPEED_DEV_XDMA]   =3D 0x1E6E7000,=0A=
     [ASPEED_DEV_VIDEO]  =3D 0x1E700000,=0A=
     [ASPEED_DEV_ADC]    =3D 0x1E6E9000,=0A=
-    [ASPEED_DEV_SRAM]   =3D 0x1E720000,=0A=
+    [ASPEED_DEV_SRAM0]  =3D 0x1E720000,=0A=
     [ASPEED_DEV_SDHCI]  =3D 0x1E740000,=0A=
     [ASPEED_DEV_GPIO]   =3D 0x1E780000,=0A=
     [ASPEED_DEV_RTC]    =3D 0x1E781000,=0A=
@@ -75,7 +75,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] =3D {=0A=
     [ASPEED_DEV_XDMA]   =3D 0x1E6E7000,=0A=
     [ASPEED_DEV_ADC]    =3D 0x1E6E9000,=0A=
     [ASPEED_DEV_VIDEO]  =3D 0x1E700000,=0A=
-    [ASPEED_DEV_SRAM]   =3D 0x1E720000,=0A=
+    [ASPEED_DEV_SRAM0]  =3D 0x1E720000,=0A=
     [ASPEED_DEV_SDHCI]  =3D 0x1E740000,=0A=
     [ASPEED_DEV_GPIO]   =3D 0x1E780000,=0A=
     [ASPEED_DEV_RTC]    =3D 0x1E781000,=0A=
@@ -286,7 +286,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev=
, Error **errp)=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);=
=0A=
+                                sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0])=
;=0A=
 =0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index 2f8f49a376..d1f18e471a 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -23,7 +23,7 @@=0A=
 =0A=
 static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
-    [ASPEED_DEV_SRAM]      =3D 0x10000000,=0A=
+    [ASPEED_DEV_SRAM0]     =3D 0x10000000,=0A=
     [ASPEED_DEV_DPMCU]     =3D 0x18000000,=0A=
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */=0A=
     [ASPEED_DEV_IOMEM]     =3D 0x1E600000,=0A=
@@ -442,7 +442,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev=
, Error **errp)=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);=
=0A=
+                                sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0])=
;=0A=
 =0A=
     /* DPMCU */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 8b84300e0f..b3c4eb1915 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -20,7 +20,7 @@=0A=
 =0A=
 static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
-    [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
+    [ASPEED_DEV_SRAM0]     =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
@@ -182,7 +182,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     /* SRAM */=0A=
     memory_region_init_alias(&s->sram_alias, OBJECT(s), "sram.alias",=0A=
                              s->sram, 0, memory_region_size(s->sram));=0A=
-    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],=
=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index e7c7b74491..6098d1aae3 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -20,7 +20,7 @@=0A=
 =0A=
 static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
-    [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
+    [ASPEED_DEV_SRAM0]     =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
@@ -182,7 +182,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     /* SRAM */=0A=
     memory_region_init_alias(&s->sram_alias, OBJECT(s), "sram.alias",=0A=
                              s->sram, 0, memory_region_size(s->sram));=0A=
-    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],=
=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 30883ea7ce..d7ce14e8c5 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -30,7 +30,7 @@=0A=
 static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_VBOOTROM]  =3D  0x00000000,=0A=
     [ASPEED_DEV_IOMEM]     =3D  0x00020000,=0A=
-    [ASPEED_DEV_SRAM]      =3D  0x10000000,=0A=
+    [ASPEED_DEV_SRAM0]     =3D  0x10000000,=0A=
     [ASPEED_DEV_DPMCU]     =3D  0x11000000,=0A=
     [ASPEED_DEV_IOMEM0]    =3D  0x12000000,=0A=
     [ASPEED_DEV_EHCI1]     =3D  0x12061000,=0A=
@@ -783,7 +783,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);=
=0A=
+                                sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0])=
;=0A=
 =0A=
     /* VBOOTROM */=0A=
     if (!memory_region_init_ram(&s->vbootrom, OBJECT(s), "aspeed.vbootrom"=
,=0A=
-- =0A=
2.43.0=0A=

