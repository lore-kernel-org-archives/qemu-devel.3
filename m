Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A635C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrANp-0004rQ-E1; Tue, 04 Aug 2026 04:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANh-0004q4-FT; Tue, 04 Aug 2026 04:20:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANe-0007MM-L9; Tue, 04 Aug 2026 04:20:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzmGpxfYwDcmol8MJvdeM2d7I7iSSdVDmc3Lc3tpVHkiGGW50VrA+hmBnKe3vcCBZcyeIHCD6+p5A1rxCXEFxGtzgYCmd2heNTfjPfTXaCRVO0CeLOrfwZAGsxqH+atxuLhiqsGVgqwtRE0E+8LY55lqJbhL85IE7AttWn4j3x8fzwLth7j5rfIGoMnypEDEiZbGCdNe5LLum9wB6SbsqsjisTYRhOuCT5IriqdM2xAV1qBSZ1v0oUSvqu5mvS2ajMub+FHokle9zeyRPYHHR6ZgQQclSBOjTCl39surRLMg327D8OBvAQEXQ25fH8nX/cids2bTrosl18KBchG39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWcXH+YFJtNGR+DoMJCF2Dwc6kYERlpqIVN+tuJcSY0=;
 b=fKm27qnknhy1c9Bn7zQl1GAo2l4zgKSls2LKpm+ESeM0mUNPsVwuJNAUIj/eSTQqW0t08FY8ASKUUVz4XqiewdAmCZHdKHA43exOh4g6SNxotET18YnnKiCb0ZWeRp591eiYrmbmKP1gqBYIVJSXSUiqYWf+8jKMn3//ubsgfiJUJ4s53HtGTIgQWK5+5MDwunvxC9rCRZDkBuZJCS0tzKaIkvVHO4hdIhDaTLAqP97QHQVS3rC59sBJc+GJ3tHmrRXKa9Y+98+0+329tenQA8KlvT3o0HulPC+F3R/F8mgrj21Og572g/L+5huL4Sagwpk1UjK6bxZ/153sasWtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWcXH+YFJtNGR+DoMJCF2Dwc6kYERlpqIVN+tuJcSY0=;
 b=elAUE7e7c68UcPVyAXsUuo0s0BKjd1TEx59WP5nCBCiD+7iOUlE9nW6myX0ENIzh+oFWuWOtoHPAGGwVHc0Cmo6m+SHJykThVk1CZLArZUVFj6EY8RqLCEvW/lUZ96HoCcJDZCmg8zP8ap63MTJQB1EWylefOoNlPqd67TesHnt7xMQHqYKH3sUEenqXGEXzPXh6Rd6QW1dvD3vbF2r2NlEuciAGmUw9q32P+91F8WAG/GnugMKEJGQFYn73uht3n0NcT0eVVC5Y24ot0dR4Q8sugCG348hUiF0UZuusmVrcZd4Bdt/63imnmrjY+6G8EEuyMRYqBMdJ3gsZfzW8Mg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:19:58 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:19:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/8] hw/i2c/aspeed_i2c: Support the AST2700 master buffer
 mode
Thread-Topic: [PATCH v1 1/8] hw/i2c/aspeed_i2c: Support the AST2700 master
 buffer mode
Thread-Index: AQHdI+oJej/VRjOooE6GyyY7X4Sxpw==
Date: Tue, 4 Aug 2026 08:19:57 +0000
Message-ID: <20260804081955.1563537-2-jamin_lin@aspeedtech.com>
References: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6961:EE_
x-ms-office365-filtering-correlation-id: aaa2f8d8-9af9-4b11-9891-08def2012c1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: pii4YkJIM1XWGqgnNPvWqVMGTlP26vGuF/EVYbFaOSLGSNvxqfCuekgyf/hM7Bi6mQjwCRWWUIJIUpMVYkLr3tKfgAPtCfDP8xgoQGiasawPv5nvUvH00j+7bNTKalkmYqy3YvYmw7uVVZ9FX1EGd2SLVLt36M1i1N9M3HplOWV3pH+saRQad+8Lq5xg2WBQ3+sYxCDlMTfzQkq4GVIBbZFGR0nn84rGsM4Mo7NJN4x5e09e4wTZsKAUAuIOTDA4MYaFL7rY2ONGuJdI8jeBPvHrhQFILhGOefmuoo0k0XPuHXCjep7dLZDRXTDg4LnvyuR46xg7mKLz8TB8Q+451isQLJnsVcW6WA7G1BrL5iBf36fehxPFpuADuno2aEqxXg9vmDQgHUG6O1Di3joI9KzIwwjNyK5Qg1LpU4Sjbgm2zQ9mvaMYeRPm7XMOb+V4qOkrASR+H/OVjqKJEl4jPnqFn0EaqxPGgsJBrnW6UzaZYrkfnxzJkpXM45nwdsjjLw/dDoxnknbVrpnbXbiXx6v6/NvY4J8MQPSIpNThhY0prGRuZ+co1+Jizb6hEzNKa42b773BvouKGlSZp/95QvwYUxRr1kXnL2pu6dTnelUqFL3XKguLHp+Jgq3wTIktGYBDFddwRah1TDhUAkrasrbigLv4KVA6WMuOWE+PB+uJB/3hZBLuZNhJN9oOEMJAz3oqpygYCEZCpxYOjRlr2yTZw1D9u3Pb69i4HeCCZz4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O+UdssOcXaovJR3sneq2LO9p+UIFPbxa4zhYYODRI4jji4Sx3y56hi0zv4?=
 =?iso-8859-1?Q?bzsWaHNb/uG2PoFMmYsfDD4xhmr1xXsEucrp2LVHATwUVa/kyNOWAtjNBI?=
 =?iso-8859-1?Q?1u5zeEs4w0g7id+QXwCfH6rjgf9a2MXRD/tsMJYHIBaUII+RQbr1eHPcoF?=
 =?iso-8859-1?Q?kfR1Q8NnwzFNN4EyzHSQMEuFusMyXJLIk06IsRldNiJhXlidiNCArX77ex?=
 =?iso-8859-1?Q?ILD3aPBuictfBawGjgN0T0PHAAZa3iler40G/swfPqa+fLwEWvnqNOaamJ?=
 =?iso-8859-1?Q?Z5ZJYIzUTHT1NFCTOGx04nh/cdmLBGvBaLktd00ikvLXWa5sRjglspsU4k?=
 =?iso-8859-1?Q?O1JspSPq7kRQ9jnroLUgWhtDZ2JwwRpdnxwyGFfLuMqUYPdREzpSEXEVuO?=
 =?iso-8859-1?Q?LyslOPypnW7HAwKyelQ5StQwnNVsfLsz3W66Hj3OIePboM3RVXMW9bj5ef?=
 =?iso-8859-1?Q?GDDNPfishfexnO6twpoK+Uv8JVCz6QusrlYFTpzXuyBBe3maQOkChKYdDL?=
 =?iso-8859-1?Q?9RT5keJ9LU+SwCHqtoeTylgGfWC68XVORdsNff8do2Wwi4oiOFIEyMS3p9?=
 =?iso-8859-1?Q?lfC2h/KNTE8p0XVdlS1solRvgauuuTp7v+92b0lX/T6zUS6jhYOU4a7gXF?=
 =?iso-8859-1?Q?go+2D0P9PiF95XCdHIP6kmzvH10obrpxJJJ7emJbdpw4+fWd0mp8HSMi9P?=
 =?iso-8859-1?Q?Q58SPqB1gNPsRjc36vzZ+2YqahC5GgXDWkyh7kyWasmKmh5qf5vT0rXn5z?=
 =?iso-8859-1?Q?InVQyVkIx5l/JO1m/cFCfD7Mw8+LZ1N5UBW4dE5tJ4CchByKSSmHDGGtAI?=
 =?iso-8859-1?Q?gcbsodRlx1XBMsji7wRe0KOuGQVi7jMJzFHXyUD8KJHK/vSMzyNyHZdC08?=
 =?iso-8859-1?Q?mKA6TKRa/BBnjGVqsH2p3xfO14WrD2Km3IHh98u+Vp3QmsA+UUZj6sYakf?=
 =?iso-8859-1?Q?XJyZ5I4rCnBVYnFB08/sFq8LMrCBNXx3mItNkYTe5rvMKP7fQ5Q8ri1zEx?=
 =?iso-8859-1?Q?IrREZ0+cejOvQB4O0YcfkKXOwwx4CnE+CFgLr7zbjzCSSNJeVHDnvCn7AS?=
 =?iso-8859-1?Q?LwhJvn99gjWwq6Tv5hZMeok3f2KsGrsbx+53Mi2Px/CyeaZenCjvUhIP4g?=
 =?iso-8859-1?Q?6KBJ436a6S49E0Hj5iH4Kni/V1lLCjtyCnGHLjumujMhxtp4RcMp5JrlHO?=
 =?iso-8859-1?Q?4D/jsJkwzf19zMLy1inLBjxQxZnhTgY3PK/T1xAF6DLYElohlhjQ7OxW5I?=
 =?iso-8859-1?Q?S2DbubrOkvxVPnPu2awKWimgGbjE4aqxXg7T6RUph8YO/VGs1yQCFV4kgI?=
 =?iso-8859-1?Q?H0d1yrjcJ7B6+yBkkptyVduWX0+6PSbiW1/ckO2rxdkPnaQ356LWZwHHQG?=
 =?iso-8859-1?Q?qB6yhn14EkTLwLZr4FA8bs6K3eOXFJzgG3NNMzTNeMfjbo9yh33qxNLrd0?=
 =?iso-8859-1?Q?JRODxTvFX0yZM/j+PIUqtItX/PUmMa0pcKaJEHILpIAlMP+3msaRvR2bho?=
 =?iso-8859-1?Q?5XleGawLh3J4jREqAqCwZEmzOpoabmb3TDcmG8948Sk1HYAwWBYElSCdIl?=
 =?iso-8859-1?Q?5lyZ+KW0EifPgjBXYTYNa3V5bt1ehRItVKE83PVddDDRwQI7/TKN50BEmH?=
 =?iso-8859-1?Q?yMrIHN3TlImNeHL5vmgGTzX4sOLVwge0P91L201WdHk4p/6Ar1s3jfzzSE?=
 =?iso-8859-1?Q?GUABEscutu/ApnSfBhi9DsqYFp/rPACYMZTm+jtD5+2HxMZxSUKwXflTKL?=
 =?iso-8859-1?Q?y7NI4Z22iG8mfgIpbP5pK3ZVRd3Lr3tntwyCltlYGZGNzLemV41KHMm3Hx?=
 =?iso-8859-1?Q?0EYMTLRgMw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CFffQWpwQutyJGq2T8IjegJSTzsiAjVjogyra6raT+0hko7q5qoi/MO6AN2SJcQLxHaeHrfH0Qd0BTNPxWmgbGOtDEo9kRdlntEUSqljzskQBEwlSrV8tys3xW35Nb4D1omJ0u429GKpf5Xi3Hc2A71fd66IGxBfkMa80jLxN5Mq2GgFhSDZiboOBJXypn3V+4ayy3JLJOhvS3qiTguvK5azuobIJBylRO+OYtRIrn04hmu0cFbicVqgAS0E/uJkYGr19LeE67kAykE9p3zrF6AW2c/m9qYDI+MKZGj0VcVFbWOUllLFXx0HMrPlsfpOI3wAJwAUrxYSnlNuK1dU1w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa2f8d8-9af9-4b11-9891-08def2012c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:19:57.9002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54dU69rkw5rc0AQN/15FO7DkenbxTAd1GrZBF2vZFEfxo0QfuzB2/CpuwYJNjey/uYTL/gXzNy47TyUjJpQ7KQGmMIsdiQCxvPlwVb8IIgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6961
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

The AST2700 I2C controller can move master DMA payloads through its=0A=
internal SRAM pool rather than DRAM. The Linux driver calls this "buffer=0A=
mode" and selects it by default. Buffer mode reuses the master DMA=0A=
command bits (TX/RX_DMA_EN) and the DMA length registers, so the only=0A=
difference from a DRAM transfer is where the data comes from and goes=0A=
to: an offset into the pool programmed in I2CM_DMA_TX/RX_ADDR. The=0A=
I2CC_VERSION_CTRL FUNC_CFG_DMA_EN bit selects between the two.=0A=
=0A=
Implement I2CC_VERSION_CTRL and, when FUNC_CFG_DMA_EN is clear, move the=0A=
payload through the pool buffer instead of DRAM.=0A=
=0A=
I2CC_VERSION_CTRL resets to all ones, so guests that never program it=0A=
keep targeting DRAM and behave as before. The register sits above the=0A=
register window of the earlier SoCs, which are therefore unaffected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  2 +=0A=
 hw/i2c/aspeed_i2c.c         | 79 +++++++++++++++++++++++++++++++++++++=0A=
 2 files changed, 81 insertions(+)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 156998e7c1..05937a7a0b 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)=0A=
     FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)=0A=
 REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)=0A=
     FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)=0A=
+REG32(I2CC_VERSION_CTRL, 0x94)=0A=
+    FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)=0A=
 =0A=
 struct AspeedI2CState;=0A=
 =0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 27afcaecee..68bdcd0e25 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -159,6 +159,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *b=
us, hwaddr offset,=0A=
     case A_I2CS_INTR_CTRL:=0A=
     case A_I2CS_DMA_LEN_STS:=0A=
     case A_I2CS_INTR_STS:=0A=
+    case A_I2CC_VERSION_CTRL:=0A=
         value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
         break;=0A=
     case A_I2CC_DMA_ADDR:=0A=
@@ -295,6 +296,65 @@ static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint=
8_t *data)=0A=
     return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * In AST2700 buffer mode the master DMA command bits (TX/RX_DMA_EN) and t=
he=0A=
+ * DMA length registers are reused, but data is moved through the controll=
er=0A=
+ * internal SRAM pool at the offset programmed in I2CM_DMA_TX/RX_ADDR inst=
ead=0A=
+ * of DRAM. FUNC_CFG_DMA_EN selects between the two (set =3D DRAM).=0A=
+ */=0A=
+static bool aspeed_i2c_bus_dma_to_pool(AspeedI2CBus *bus)=0A=
+{=0A=
+    return aspeed_i2c_is_new_mode(bus->controller) &&=0A=
+           !ARRAY_FIELD_EX32(bus->regs, I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN=
);=0A=
+}=0A=
+=0A=
+static int aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *bus)=0A=
+{=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+    uint32_t reg_dma_len =3D aspeed_i2c_bus_dma_len_offset(bus);=0A=
+    uint32_t reg_cmd =3D aspeed_i2c_bus_cmd_offset(bus);=0A=
+    uint32_t offset =3D bus->regs[R_I2CM_DMA_TX_ADDR];=0A=
+    uint8_t *pool_base =3D aic->bus_pool_base(bus);=0A=
+    int ret =3D -1;=0A=
+    int i;=0A=
+=0A=
+    ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);=0A=
+    for (i =3D 0; bus->regs[reg_dma_len] &&=0A=
+                offset + i < ASPEED_I2C_BUS_POOL_SIZE; i++) {=0A=
+        trace_aspeed_i2c_bus_send("BUFF", i + 1, bus->regs[reg_dma_len],=
=0A=
+                                  pool_base[offset + i]);=0A=
+        ret =3D i2c_send(bus->bus, pool_base[offset + i]);=0A=
+        bus->regs[reg_dma_len]--;=0A=
+        ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, i + 1);=0A=
+        if (ret) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+    SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, TX_DMA_EN, 0);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)=0A=
+{=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+    uint32_t reg_dma_len =3D aspeed_i2c_bus_dma_len_offset(bus);=0A=
+    uint32_t reg_cmd =3D aspeed_i2c_bus_cmd_offset(bus);=0A=
+    uint32_t offset =3D bus->regs[R_I2CM_DMA_RX_ADDR];=0A=
+    uint8_t *pool_base =3D aic->bus_pool_base(bus);=0A=
+    int i;=0A=
+=0A=
+    ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);=0A=
+    for (i =3D 0; bus->regs[reg_dma_len] &&=0A=
+                offset + i < ASPEED_I2C_BUS_POOL_SIZE; i++) {=0A=
+        pool_base[offset + i] =3D i2c_recv(bus->bus);=0A=
+        trace_aspeed_i2c_bus_recv("BUFF", i + 1, bus->regs[reg_dma_len],=
=0A=
+                                  pool_base[offset + i]);=0A=
+        bus->regs[reg_dma_len]--;=0A=
+        ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i + 1);=0A=
+    }=0A=
+    SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX_DMA_EN, 0);=0A=
+}=0A=
+=0A=
 static int aspeed_i2c_bus_send(AspeedI2CBus *bus)=0A=
 {=0A=
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
@@ -320,6 +380,10 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)=0A=
         }=0A=
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, TX_BUFF_EN, 0);=0A=
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {=
=0A=
+        /* In buffer mode the DMA moves data through the pool, not DRAM */=
=0A=
+        if (aspeed_i2c_bus_dma_to_pool(bus)) {=0A=
+            return aspeed_i2c_bus_send_dma_pool(bus);=0A=
+        }=0A=
         /* In new mode, clear how many bytes we TXed */=0A=
         if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);=0A=
@@ -385,6 +449,11 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_pool_ctrl, RX_COUNT, i & 0x=
ff);=0A=
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX_BUFF_EN, 0);=0A=
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {=
=0A=
+        /* In buffer mode the DMA moves data through the pool, not DRAM */=
=0A=
+        if (aspeed_i2c_bus_dma_to_pool(bus)) {=0A=
+            aspeed_i2c_bus_recv_dma_pool(bus);=0A=
+            return;=0A=
+        }=0A=
         /* In new mode, clear how many bytes we RXed */=0A=
         if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);=0A=
@@ -854,6 +923,9 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
                                                       I2CS_DMA_RX_ADDR_HI,=
=0A=
                                                       ADDR_HI);=0A=
         break;=0A=
+    case A_I2CC_VERSION_CTRL:=0A=
+        bus->regs[R_I2CC_VERSION_CTRL] =3D value;=0A=
+        break;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, offset);=0A=
@@ -1497,6 +1569,13 @@ static void aspeed_i2c_bus_reset_hold(Object *obj, R=
esetType type)=0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
     s->pending_intr_sts =3D 0;=0A=
     i2c_end_transfer(s->bus);=0A=
+    /*=0A=
+     * I2CC_VERSION_CTRL resets to all-ones. FUNC_CFG_DMA_EN is therefore =
set,=0A=
+     * so master DMA targets DRAM unless the guest clears it to select buf=
fer=0A=
+     * mode. Guests unaware of buffer mode never touch this register and k=
eep=0A=
+     * doing DRAM DMA.=0A=
+     */=0A=
+    s->regs[R_I2CC_VERSION_CTRL] =3D 0xffffffff;=0A=
 }=0A=
 =0A=
 static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)=0A=
-- =0A=
2.43.0=0A=

