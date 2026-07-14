Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB26C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXaC-0005sk-QH; Tue, 14 Jul 2026 03:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa8-0005rU-1h; Tue, 14 Jul 2026 03:29:32 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa6-0006VZ-Gg; Tue, 14 Jul 2026 03:29:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ4bJNQKhttM0Piqm8gPlOD8DK1++OVQ5cBX9lmKcazhCabSPUBuMgRaQ8hLxsFoypz+86/KoApAW+VmiEKmYo3G5KP5kELOTaAVjGDkx6UmpGeCvLEFB4++P386d36yhTWEJzkjv3tEccIOwkdLVM1lgPt+wPpXpiFdiPl1xvw+pcrbpif98To3WXPqC+fkmNmuO9V/wE/7NjJGzi2Kd8eGfQ8IEeZ1ujoODg50BgsT7lyInfxW1OacuboX3JXJhtHDBePDQftnurP0wDBox+Ky3yaf4h6bDPTdsSyUwyq1MfDvqCus0kpGrQ58hVdUWBc3ewnskk9YbR9pdqtkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRpeKPadUDUUwa9D/Gir/KcrurF7Hnmb/9Xt+/KWuNM=;
 b=oxiJx2JUZBIX9kw993vhQfWqQRBk3uT+Dmst5B2a6M18EmJzxQY14fTtTH7rViFvkXCUdGUS8d2cgobZURcWdDZz/xhllbkF4yieHey+0A4ccGaLPzSBnD+22dzeo0BnomhPa8KWeDRvHt0rSOXG586H2hwk/3rglXt7w+FUFgyAIK1jMcZLO0JTxxh2q1581hVvAQDcoMEuLoE3gquRZ4/Fhj8/Dbue+5mlW2xA2hC4r0fkmDR8/txSGK9kGJ8Vk7YoVDLoyfIZ3o1PnuJE7+IlnMJrj0GpRsx0FhPerzjYgAjiSAabPuMm/4rzB8aDDonscXGjqVW8Ury/B1axZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRpeKPadUDUUwa9D/Gir/KcrurF7Hnmb/9Xt+/KWuNM=;
 b=g1N5RNnf+BjFAtYS3KBkAFPB+NC+xgRMlqsV+eGwmNSA/v8lcTGFqh7H+9Danv+pHtmC7zwPA2gIieu9dGnAYc9ap2TwH+Frz27k1KxHC0207IpGZyfrxrQpVnSpqp92k1PBTdbBSLoVttZESV9vKOJ5kVwOSZQFTA6ZPKLbdTpdSy9CVmALg9L0nkuV831de/NLpbG5FJdDo9wyL4e+mqgwPfcD6FhopcJXHpXk4KtRGV5v1Pg8EErM1ZKko03owsr+ek2VpdO1FeVmVutCcFelPIc9JgeM0bFg4OvSRYgLU7Wg7JDQat/VV4vFX3AAeh05LZmSIcBx8Edv7CDhjQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 11/15] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Topic: [PATCH v1 11/15] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Index: AQHdE2J6V3Z+Ml80FU6fvPn/hNxyJg==
Date: Tue, 14 Jul 2026 07:29:18 +0000
Message-ID: <20260714072900.3023742-12-jamin_lin@aspeedtech.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: d1727c11-07c6-4f0c-fe02-08dee1799d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: XJ025S9ONNwaMNT3tYN+hPI+3hKfdS4oUfF46oDPMEHsjD2MpSgKDta9AffSN2simuSU09WlG1c052MXmOHjceIyU534wCzk3PMXpQBxNDDTyxjUe1YtgrL4pqsAYYe03W04wJmURpxJMkeKZinZ50+xlB/wF+SaVd5Bhe75hDgiDqzRM57Ek1qfbzFYToWBSL5O83NFeJ+nmQaMZ2oX3aWwOcP2dIqdkV9l34nNjBrU0iEGaYBskg0zbhhxHeN4M6KEvHyhlFqBEITv0aSyjl1f4TYlDh92kPPpuh29n38gISo2Xk0xtn+fMvTfFEglAJs2D2lYa1zXU7SMAET+WIUzzNFVpL3+Mny0Fq8cRd4y3+30mAD1Hv7P5xD5caRrD91k7/5ghUCoIgMX34N9zI5545ykikdMFitdNBD1pjuj1gnNld0Mj0tUcRSNTDjdogAbZ83yERoBDjP5RVjEsGFgWsvFAolkvxh6M4o19LLbs1Kq0Uc/6bjLaBpCOVxHchUPtUli4+2A9ZIzI+N0YGXCWh0Qn+K50kcm8ShqcF2FCxvzILkhO/VSUoZ/awloBj+atvZmSPf9dntuNX/bX/L38cMb599+UcuWFLdY4l14aC4ClWJqeSHzGzGRaU496jXjlSff77VyA9witi+u16Ggm+zPqZNkH3bvTlP9ibXhIGfbcTjIafMHLJQCX7ROPHD9JWp3Kg18WvgKtqZnc/9YoOu5Clnr3kdcdxeujD4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Lkmhp3JrTdQ4h4x02X0xevHv+Epb/w+gqBa1cwJmpWEiaWgPmG/DORKNLr?=
 =?iso-8859-1?Q?AWm1Oe3OfTjBBB81Fjp0YGG2DzTqPYBe80c6UcIOgQRC6J6SxkmysOt2cE?=
 =?iso-8859-1?Q?PvKe5AWdzMgRkA3EnBvs7qglXqNrvfJk48XDRQjYSm5i35F52FfVzUBR2s?=
 =?iso-8859-1?Q?uBd8Ge4tBAmg5s9Hw5UmgE5d0mRCcGbOHGidLVejeFTYpa++8G+60FPGMZ?=
 =?iso-8859-1?Q?1xEo/WsY2iFyB41zIkf4Fy7RbG6zB1fsDLQhzBmOCoLd+B0kQtKtquIJCO?=
 =?iso-8859-1?Q?+72HY9jvg5DUxPa7KqWbnuclbkXTSAJuFos0iR2/ESwGoghTEtdL/xHP+Q?=
 =?iso-8859-1?Q?fipgrfAiSKmN2NOK3k3JYm3Kl3uK+pIAqrKk6cyoec83Y1y9TnPjxPnash?=
 =?iso-8859-1?Q?TsKT7aIrvcDpyAtp1NAgk64mFGZNtw/KXIDD4m7bU5KE3GS86bFzr7xU1j?=
 =?iso-8859-1?Q?XBpN+YsxBRq4RuJM7TwOTc4TkyCISuo+9CwQB24vxlMV3u9BCgGNh/He4e?=
 =?iso-8859-1?Q?c1WIF+UkvijEjO2bJONIFO+W1RjLLpixsTa6i5r2YlZLG99b/I3W+l+TJ6?=
 =?iso-8859-1?Q?MQC8VDoTg7NnxmHs09CKzHSvqQntYmUDNS0ZhfLVGN+0p6pkpFR86TyMYv?=
 =?iso-8859-1?Q?Clfhwxm1icw69z12p+p/H7M8QkeCosD7VmHMS2zCTv6I97b06vxnX8ezh8?=
 =?iso-8859-1?Q?6S10tU8/XGYAbgXJM2Vx8U6fjPApDYpL2GCvbrs6hLph0WeglQ39goqu13?=
 =?iso-8859-1?Q?F3HPumSk+6IGV46duOhG+OzyyEmdVf1SMtFYI0ewLdHNxxUNnbrQSvhL5q?=
 =?iso-8859-1?Q?whfEb3wjYCrNMzm9BSbp4O4UcAC1ghLXOz58DduSvCMu7HQkxjSXgPM5+B?=
 =?iso-8859-1?Q?a1+DHsrfeGbLRGhCVTgUk10YT+B9pcRcezXFJ43kgdmjeMSZQnDHEGmFBd?=
 =?iso-8859-1?Q?+IQf1Gzh9pefVDf7Cu+uXsW/V2zqueaZDa4IOBx/+lQImqHEI9tDUgaur+?=
 =?iso-8859-1?Q?3nu2lyuBgKgelCRuuM05zv/e+x3aQzld2f8W10cAAFFj2yHViz9a3KjZ+X?=
 =?iso-8859-1?Q?Ran5C6FyXIJjCHgbT4evu2j4IFQ2vJM3xStzKXhwNW7GqeYenQ9/ZBLBIf?=
 =?iso-8859-1?Q?4VX/Cn0zKq4542wIeG0LIQ4DkXhDaS/VSa4xk0PXSwHwjTQikSFgV4X92q?=
 =?iso-8859-1?Q?LjjFD1hZCNZao5AZl64yozqIQlRr14ALvGP9kPEVhqgRBkoMMYYuBgz910?=
 =?iso-8859-1?Q?flZ5MyIfDNM4tCslaIzIe2rrRylANOHRdS5UT/sK46w4tTC2rbbFsO0AaO?=
 =?iso-8859-1?Q?TTf9qqjLTVUpEtHFywwXhGv1ggwcf08XYR3fx/lwpeeVFHw4+mmjmmMKqj?=
 =?iso-8859-1?Q?GiKPNQ870j+zBn/I1nH2pDoGTpqqLH6R45+qZ3pwYsuoo6n/p/6Xu2oChS?=
 =?iso-8859-1?Q?UymJ2KfQmy1MpanGMhqQMC41qlKD1bxve0TCjBJ6eJZoUeiGtFsA7tkThH?=
 =?iso-8859-1?Q?8buQBWN0p680mablf+zZxe7afAaxtaJAW0eCjEQMKfFYo5i/8lXOvixv2L?=
 =?iso-8859-1?Q?rWav6WubWUIKZo4gHEV7VFyoHEnMX9pC/gdTn5Lm9aiDvfpMNbYCCmoTgX?=
 =?iso-8859-1?Q?nx0ngkFNV4CdYl5BYPbNiqlfvsKc93PT23S1FnvQFy73icKy6dY06lIdxY?=
 =?iso-8859-1?Q?cIP+yT94PFBbgFdXVkske225q+7hbq++4TRwTef5aOx1a1zDtBHWgcjpc1?=
 =?iso-8859-1?Q?NC0H7uOxZYxko9KUfHoTkVRLs3wa4l1BauceTCM5Ryy3Z1MjXm7OI/c/Yx?=
 =?iso-8859-1?Q?jL1nfg7YDA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LhusrBrUb50ULusW6bOaSPyICTngmsNyktBEzWDPAOsifrQIHvH5M92pDYwHyPj5i9tWGJhcmyNiAWlbNG7SZhlA/shgq1NhQdcLd5D3H8Dc5tehauX44vCipoAr4JO4oxp1jrivM7oeNUdPmABhelMpVyET8EsOCEsDrDjOPVA5s9nAf3WC17YMQPYuNRFrsSihW0Q+PsZzw1Yagv90nskR+bDiN1YUnAfoqmCXb0CJZm56Ifi6cQUfpc31tn3kpn3Rc+lJOGcgkWnKr2TPiBmg3SH42MkZX+7qpQ/YAgmgTlQcUI0cnLTEKfS25d9VHXq1QD3Y48gO+fjA1ZyTsA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1727c11-07c6-4f0c-fe02-08dee1799d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:18.1471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzNwFJRiJ5HhGBV0OIwuyxN3b1Hx+szs3hFPX70mrkSRED4wkJGR46EwflS+TvFiNPPUfJDMua6UNVviJcHy+a3D5tvwyF6V2mMTQwh8NzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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

The AST2700 crypto engine addresses DRAM with 64 bits, supplying the high=
=0A=
half of the source, destination and context addresses through HACE80,=0A=
HACE84 and HACE88. Add those registers and a crypt_get_addr() helper that=
=0A=
combines the low and high halves when the SoC has 64-bit DMA, mirroring=0A=
the hash engine. SoCs without 64-bit DMA (AST2500/AST2600/AST1030) ignore=
=0A=
the high registers, so their behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 33 ++++++++++++++++++++++++++++++---=0A=
 1 file changed, 30 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index b7a7c0b7ff..60dedee6a3 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -58,6 +58,11 @@=0A=
 #define CRYPT_CTX_KEY_OFFSET        0x10=0A=
 #define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
+/* AST2700 64-bit DMA high address registers for the crypto command */=0A=
+#define R_CRYPT_SRC_HI      (0x80 / 4)=0A=
+#define R_CRYPT_DEST_HI     (0x84 / 4)=0A=
+#define R_CRYPT_CONTEXT_HI  (0x88 / 4)=0A=
+=0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
 #define CRYPT_IRQ       BIT(12)=0A=
@@ -672,6 +677,19 @@ static void crypt_be_add(uint8_t *ctr, size_t len, uin=
t64_t add)=0A=
     }=0A=
 }=0A=
 =0A=
+static uint64_t crypt_get_addr(AspeedHACEState *s, int reg, int reg_hi)=0A=
+{=0A=
+    AspeedHACEClass *ahc =3D ASPEED_HACE_GET_CLASS(s);=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D deposit64(0, 0, 32, s->regs[reg]);=0A=
+    if (ahc->has_dma64) {=0A=
+        addr =3D deposit64(addr, 32, 32, s->regs[reg_hi]);=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
  * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
@@ -712,7 +730,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     /* Fetch the IV and key from the context buffer in DRAM. */=0A=
-    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];=0A=
+    ctx_addr =3D crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);=
=0A=
     if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
                            ctx, sizeof(ctx))) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -753,7 +771,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     dst_buf =3D g_malloc0(buf_len);=0A=
 =0A=
     /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
-    src_addr =3D s->regs[R_CRYPT_SRC];=0A=
+    src_addr =3D crypt_get_addr(s, R_CRYPT_SRC, R_CRYPT_SRC_HI);=0A=
     if (sg_mode) {=0A=
         status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);=0A=
     } else {=0A=
@@ -789,7 +807,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     /* Scatter the result back out, per the selected mode. */=0A=
-    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    dst_addr =3D crypt_get_addr(s, R_CRYPT_DEST, R_CRYPT_DEST_HI);=0A=
     if (sg_mode) {=0A=
         status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);=0A=
     } else {=0A=
@@ -953,6 +971,15 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
     case R_HASH_KEY_BUFF_HI:=0A=
         data &=3D ahc->key_hi_mask;=0A=
         break;=0A=
+    case R_CRYPT_SRC_HI:=0A=
+        data &=3D ahc->src_hi_mask;=0A=
+        break;=0A=
+    case R_CRYPT_DEST_HI:=0A=
+        data &=3D ahc->dest_hi_mask;=0A=
+        break;=0A=
+    case R_CRYPT_CONTEXT_HI:=0A=
+        data &=3D ahc->key_hi_mask;=0A=
+        break;=0A=
     default:=0A=
         break;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

