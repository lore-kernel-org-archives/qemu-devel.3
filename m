Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929ABCD6E4F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw6-0008LE-DX; Fri, 29 May 2026 02:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvy-0008Fx-Op; Fri, 29 May 2026 02:43:09 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvw-0002Iq-AH; Fri, 29 May 2026 02:43:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghLtSf5E2+oDCcx0Svz9k5eocU8KDsg1mIHtiAQUQTNNXzWYPVfQ74cA7ktELtXg/whzaVJNzFfw/2BdpagXkNWDCzc+zY+A8maYzLHyGm3/Amc6nSqLOlAkUmZ7ijCftlkmisZCtn5OdHR9ScB5VcBuGyApxp/9zrU2pcGf+4P4O9jXiBhVpt2ildOAKCKxTMIsNHByHm3BM0+YS3HF1fiBp0fKt50s9dfujNnnZMjm+v9UgNguWzxvsRIz2jDtwggsNgnHLsV1o1KRBXzuu2pcoZT5HMZxV09hRiAwm1uAApESg0M3GJ01eUha7kA8pWTsQTIjUh0TJV2x3AxIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVu743c0/xpu22SGedDzrMW7OsABJvEDrckJ7p65Glk=;
 b=ruTjJ3J9q2Q/aCFEdgnYFybEMUUNUZnBivFxEj0U0mbcylB/03dfHKffW+NH8kYa+5tN50uEPxor7DA/Q0YtfgdIm8Pggbqetj9e9T5frTK4gbLCt6oa2tXEFaFaExgUlOBPgPPqISt6x0lrx9hZULcGnm9WGLnMBu/wBFFiwdWZljl6pr4T+3l2/Hqtiib1JkCxkOIwmYI08r9NEqt2ox5NA+Ujqt5VERGSTClK3X3UrYOZx7rE27WhNKiHvELGWSftxThWt5tfkgcLYJONLMpBDLDOF4ii+uUOrSOduxi3z1UQLZVyh9K7VrxhzM1QDhCVOSamaOYWg2aP5Lq2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVu743c0/xpu22SGedDzrMW7OsABJvEDrckJ7p65Glk=;
 b=gLjzIbM+t4MdlQ1gRgNxiSWmRFbc1ZgiEX4ixXvoyBthkdaH55N/o53DsDH+xD8zEWcf+GgFpIW563iB2v4lscwqf9uttz6zBR+YGezz4kZZiARnIN3m/XQzFYbTOzA95pMShRoWXLtWJw3XGzKVQJuzcCr29YKZchF8g7+Oeg2GPOqlFaruBwpdGhyADWhltEfpMhz+s60tpX3eZpKqJhsKEhDvdG9CiognjiBJYUxUZ2CGMNelWL6cKYOd3yXR88uKnJL12a/BHo/2y1SpkOt9dn3difeLMd3VREO4DE/ktyf+P8UFL+QR/gPNtVieoq++6TBSKdAMY/GMHrUK0A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYNPR06MB8451.apcprd06.prod.outlook.com (2603:1096:405:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:42:51 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 06/10] hw/arm/aspeed_ast1040: Add SGPIO controller support
Thread-Topic: [PATCH v1 06/10] hw/arm/aspeed_ast1040: Add SGPIO controller
 support
Thread-Index: AQHc7zZeLvfBWmBYfkqAsKe23aYeVg==
Date: Fri, 29 May 2026 06:42:51 +0000
Message-ID: <20260529064243.2064188-7-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYNPR06MB8451:EE_
x-ms-office365-filtering-correlation-id: 48ef9001-e003-477b-a84b-08debd4d8147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: KESv1v4QZe0SDfkO6MGOVD3WEYSFg/lIJ7BtV47g9dun7Q2p8ulalMCF5TznS3hBPxIqGNl5rIPCMkim8PJAeVwYQ9R809SZXJu8ebokiyW38wlq2qw9+TknN5ZDTJDEkEKSnQKC5UPr3eWIavg/hD4OZBrDms4dbori6WwZDuMg4D4QwxBWS0/vpjv80p0HX5GPMjNRrNsb1biFuCclAV8/i3gN9IgDaCo7OqxSHmS5LWvsYajwKZ4df7596e1L+nxQZlXeNmBahKU/GlxwaPaSK8iLrPdvT2B7JUHWimUI9oFsIKDP/nNZXy71QNLqUVz/2nFszHngsd7KY+w0s5VjzGlj5+lYY9HulS5QTFdXydseGAomdJZMAnqWPoGM5GVi3TKg5AGUn7Pp7Wv1jYeBrXTebloLTBG/lCPlD6wHFShQfY0CM3ylV17KTWHuH0b9vdIZdg4nqdAdrOzlXavnmG3H6a158BpwlWGqy6F/UQY5SAr9xHY81jtQMSqf7a6YHAOKC0L6ZmEPZze3yWd0wgfRP/Rq+zTIr9zbXMzypg3SWsTe8bdsAB0Az/F39HO2SQb8rB4Ky8gJ1axl03jwX6JzXcYF7omIC0jLlxEhpCVKzcs29IQ5d1ZjQk0S8TD7PZvg9TzDlWvtatCQunzhIiBrYHxSdSopSXxHhL9wudTuY78oKqJotDapF6IWFZPCNYkcCR6eCuRU5Ji9u4gI8cZmSUD5aAv+7qgp/o53XdQcE06EiNB9/IpvjTh7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ztAkpbmfMc7j2pckdpqbvblFCUNCpShvrCvNzMXTRc/25awW5bs5jCsZfs?=
 =?iso-8859-1?Q?rCMF0odnrr4A53ejcp39vmL8V1ffdtLSCrRCbKy91GtQLl9hC1RIDohBCs?=
 =?iso-8859-1?Q?iysnk84Exg/2VfDv8fv1939rgFHT94sMFpvvMNiRBP3xy9uTWyoOM4cIyr?=
 =?iso-8859-1?Q?ar0B73Nd+BQzuDmVOTQpmXYdWSnXQW9hcjSN036pgQUwQcN5SluimkMTbx?=
 =?iso-8859-1?Q?8mhQK8YfHhx6ucoozrYItlXSuurF2xEwgp5VTxq+J7+7JHM7d99a8n8F7V?=
 =?iso-8859-1?Q?3TLSXc/96GblQ4frsYlA5Hl4oLiLeYB44ac85SPYnCR8W2qfvNvm2zi2tw?=
 =?iso-8859-1?Q?3ZlOho21JmYaEDGMhl0tG5B9rETB8eeHfPZ5Qwz5ceqiLFl8YnGAibajOg?=
 =?iso-8859-1?Q?yvWZJbQLsVAAJW99Gb08tzAkJGJtzscDvSn1c6BnfojryAGlrG4LBMvC8t?=
 =?iso-8859-1?Q?yWXT9O9FJZvufJovgkaK6DxhwrWvjFD6YWZmlGIYc6TA9xdnBSFd2nbsBf?=
 =?iso-8859-1?Q?iFM5sFtYILpri6O7jSvUMp9taKWjPzGq2wUI58Lnjy/aHDLXrCEu/aHqrU?=
 =?iso-8859-1?Q?YhFXaztGb2AYShiuwatE0FlDTh0uc7CMZZL8KRptb4aHtt+IDPugAMkIHr?=
 =?iso-8859-1?Q?09eYsA9Zu+uJ0ocHrHeH4pP6OWjnDpCAcQ2HHlnbjs1oWtpApgtEvnR12z?=
 =?iso-8859-1?Q?P86FDQ9LyREWMAbMLar/FBBvza2aVWPp5IuT8K9vSf16/ErkC5Fwr8SQDw?=
 =?iso-8859-1?Q?Bw3mugr8m5TffLUtFHpAJ/MZtEIJ/jVLKjK+cGxVKU9AyY2f3S5JsmYhaF?=
 =?iso-8859-1?Q?bk5xFUCy3KtC/VRyOFnBKsxQhh/kt9OVZlmtx9RthJvXgsUvfbykfu/DVd?=
 =?iso-8859-1?Q?BFlMftS/vwt/jsPT3Y2LdTa/wnPyzNLnnYDVsIBqYrvQfn3CAtPdZ8wtq1?=
 =?iso-8859-1?Q?TgO4kbOVOmciknZKibcEz2NGrtT2yzoU/IlAWseeaECEeTnk+qgnsjWqSx?=
 =?iso-8859-1?Q?VBqmju471BGv2Dp2bdeGZUYCzdjXkRb99afKsOkAmvVMg1kpkpwzqleiLG?=
 =?iso-8859-1?Q?gjtFEuQM35AAs2AtkM0sQfI8NSbF601TcRrHaaIggwOYvHKNSNHW5tu5ot?=
 =?iso-8859-1?Q?ZsMAKJwXxGiXFhVEjYsJvBh2C3oiPWw1gWFQCdPAn95TjAzOCX4KZZBvKy?=
 =?iso-8859-1?Q?QtRAMZec9ji6nMLB+X4UwanpnvlvUOk/IM9BCqqyOwa1v59bmMTaDglcbZ?=
 =?iso-8859-1?Q?FAnSqjSyA/71FpgVpa0G+SUJ4RGk/Fvs3IofVSGemVkUPLcY3yS9o/+dNx?=
 =?iso-8859-1?Q?bpGcHWoAHRDk0T/G0tNXYucuBtafrl4ZgTssanv26yOZsqXBMkaNdUJySZ?=
 =?iso-8859-1?Q?Oti4b66fho3qXAjTLLMowCC+eqJZrP104PbGWzlv9XOBYI48qTxMw2IEJ+?=
 =?iso-8859-1?Q?Yqe4dm63ypLvrkmU545iPmDqGMqXakvOLGYUeBlJy4HFuuTdDxoMo+iA9+?=
 =?iso-8859-1?Q?b5k+WgioASQBjIL8bMKuVLDGCwLJzCE+8IgwNX/IR4r0ZG31SXUTg0KqSQ?=
 =?iso-8859-1?Q?wZAz7uW3D/NFioEiKKXXwLZCYmotb0eGUFPoGsTVAf0vuiG6Mo3z26m2+d?=
 =?iso-8859-1?Q?G3fnl2/3NhQbaEGfd2QAiHFK3Fb6Ye2Kx3dV4BdGQmiP+hmyJTgh3JigHD?=
 =?iso-8859-1?Q?2KT+/YbTyhfNRNakdICZKOyYgYrapgaJ1cMe9pkaLlkkfzWKeU40Ek6i0U?=
 =?iso-8859-1?Q?einLoETAcLhKv2iVz/KLiFIiYS37CR+5u6XSmAbFGmtrVGEHNzldnQaxlP?=
 =?iso-8859-1?Q?uEgGhcgIQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N8vyK8FoWVKyRPnPnW0dKJ3je/n3qtDutkb4XYansrhLLyLW+U6hvgrhg3MnTFgnpiTQNx2aUaCpo4fMm1DDKaKG1WSSr5czPKSCfO9mWlwmqt0mgRgKNyKLWNZsLCG/jt0mCz+70lNVRCJ7aCik/cHV6UwIR3UkdEk9xMtatXFIG9kkckzpAc0J2QfWGkQMSRKQCU15ApWddzp+TgdE6j/1tC7pw9ri+EQhy8Ur8+7NkVwPRkIcpXkgxOBZDThEzkqgTjxZvIGfnLozbzSfFXC4EegTe6iBJxenfpBMyjpG3h5jDZVaJA7ZLkEMtgAKvEhh3kV21ma/6gIz0LYR1g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ef9001-e003-477b-a84b-08debd4d8147
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:51.1909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oY0bxsp5qzo352XjduwUL4lWNq/XJdB+RVwNjIpzqBRKzoXs+UWjPOgZ7FYmf2DxL0z8ovCOlFrD7UCyPpzZtibyVJaNgzTA6+q2IfxzKGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8451
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

The AST1040 SGPIO controller is compatible with the AST2700=0A=
SGPIO controller implementation.=0A=
=0A=
AST1040 contains two SGPIO controllers, so reuse the existing=0A=
"aspeed.sgpio-ast2700" device model instead of keeping them as=0A=
unimplemented devices.=0A=
=0A=
MMIO mapping:=0A=
- SGPIOM0 : 0x74C0C000=0A=
- SGPIOM1 : 0x74C0D000=0A=
=0A=
IRQ mapping:=0A=
- SGPIOM0 : IRQ 85=0A=
- SGPIOM1 : IRQ 88=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 29 +++++++++++++++++------------=0A=
 1 file changed, 17 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index c6b22186ce..77211ce1f3 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -56,6 +56,7 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_ADC]       =3D 80,=0A=
     [ASPEED_DEV_GPIO]      =3D 82,=0A=
     [ASPEED_DEV_SGPIOM0]   =3D 85,=0A=
+    [ASPEED_DEV_SGPIOM1]   =3D 88,=0A=
     [ASPEED_DEV_TIMER1]    =3D 92,=0A=
     [ASPEED_DEV_I3C]       =3D 96, /* 96 ~ 103 */=0A=
     [ASPEED_DEV_WDT]       =3D 112,=0A=
@@ -112,14 +113,14 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
     object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");=
=0A=
+    for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],=0A=
+                                "aspeed.sgpio-ast2700");=0A=
+    }=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "sgpiom[0]", &s->sgpiom[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "sgpiom[1]", &s->sgpiom[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
@@ -221,6 +222,17 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));=0A=
 =0A=
+    /* SGPIO */=0A=
+    for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,=0A=
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + =
i));=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
@@ -234,14 +246,6 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                                   "aspeed.udc",=0A=
                                   sc->memmap[ASPEED_DEV_UDC], 0x4000);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0])=
,=0A=
-                                  "aspeed.sgpiom0",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);=
=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[1])=
,=0A=
-                                  "aspeed.sgpiom1",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM1], 0x1000);=
=0A=
-=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
                                   "aspeed.jtag0",=0A=
                                   sc->memmap[ASPEED_DEV_JTAG0], 0x100);=0A=
@@ -269,6 +273,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->sram_size[0]    =3D 128 * KiB;=0A=
     sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
     sc->uarts_num       =3D 13;=0A=
+    sc->sgpio_num       =3D 2;=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
-- =0A=
2.43.0=0A=

