Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB89EC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmI-0006og-1e; Fri, 17 Jul 2026 04:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmE-0006nJ-KP; Fri, 17 Jul 2026 04:18:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmC-0000E6-2H; Fri, 17 Jul 2026 04:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvM79G3OkuV5Ms3W/SmYlZ25SkBUWID93IkZeT52EQZhp4qtc62qGiDbAHrCMAXC954sj/bR8ZEmnd38g07TKQN8z+TQNZUCgeMQ7oElRY1PADoQ8d9dH/v/xzTLhBrU9cgCff7f8ifY1KwzahclGPVIlHPIfp2g9n2SNZvHmDSPEJthcP5UQ7j+f/TGkCz1cfW8QkFAfWkKzChYwTh2qcf6L/jHaTb4tJHP9V8x2R+5cgMYqHF+UfC0F6Xix+eePDVmOE39Ykh60hvKvhpvAhGMGT4a/0gZeN0Yf6ORcuDxou2QMWtf5COB3wUMVnrXb4psYvapQ8aJUazYQaabQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTV/ITi5t7UVevEhbKYTiB3/+A2/fGz5a1Z0KFZxszY=;
 b=m5nACeBAFYlNP1O2Q+1XALcAkLVA5fGKwsaSMsKOF0TAI4g7NgicY3mZNnzVABLUkUwnVC24ps7LOi+iptsXk9G/jRxSnuaVZDe8nAe/l3lurdVZ9RnYJ8mX31ixO3kdXYJyjmD/BZAaJlf06CEVc5c3oKC9fkZL0SWd3xZMdjiucCZW2n8omnykFif0cfx/kvzRIhoGYoXBK/fSMXGRFSwbYdfwnkMooXLp/qsn2OVRUj2L9S19UeJCYOa5JJm2K3WoR2Twqi+YMAnYB6muaaMnCKI29ptOqTZacMN+3b2j9IJifoU9ZEy1i+hzhqv8X7gg3/0AOp6hfsg24tNgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTV/ITi5t7UVevEhbKYTiB3/+A2/fGz5a1Z0KFZxszY=;
 b=qQV4xVkZKemCno5zC4oVJnw5HIk9ITpPl03WQtFUFg59cxoMe3ktMKUH7O8pf+C2IsEGMAI1beDHKqVaFWxIauKnPA70OfD6Gwyjxr4FGZFWK4njKBWgXmTrLO3saVoA8FFVEao7gcksKeIP9Ey+6hRz7yMJY03JRF1nHFreCw5L1RZ4vjcDCl5GR++HCjCA6HpNVaJ21dZTHJpElAwLmNnbHXJpNjXkjri9EFRTnybmmZjxvxypTy6etNLnQX60/lJW9EFfn8xfyfBL1fRWKfC0DiyPZv0x/ugggVhUrhBmGllMq56frCpGnGEOJWY4oeosSQmxQmzq7/DWw/07mg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 4/9] hw/misc/aspeed_scu: Add separate reset handler for
 AST2700 SCUIO
Thread-Topic: [PATCH v3 4/9] hw/misc/aspeed_scu: Add separate reset handler
 for AST2700 SCUIO
Thread-Index: AQHdFcTTKxZtKJgKzEW1VvqMp7iX0A==
Date: Fri, 17 Jul 2026 08:18:18 +0000
Message-ID: <20260717081813.3407862-5-jamin_lin@aspeedtech.com>
References: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8339:EE_
x-ms-office365-filtering-correlation-id: 9cf7ae0d-daa3-486f-2883-08dee3dbf594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: wX4C/iuxO1/kytsvhjKoMVKsQBDve86dok3WjX4r804I0WmGavqBLeRwNnM6ex0OnDeCZYAZG/84+NsSwBPNW2h+9qlvPGHl3EpNfyr33EmeaTB8EaaoFu3zcfWFn4bbNE5zczj9KXWo9HOtA4prtONKTaWsJbaZ1st8XfhL4sfjeC2c6EBXfXepW8rgZHFfIDFV6EzwolSeKUd6D/s3m6/Mk/Mbn4eIVagxMz2ji+0e3vzv0nmQOxZmdE5h7gu/WCP54newwhyvVb73XQLMmL6MapiIPULKMPkHY0Y+duUl86dPN70j6x0nHsq4AQx3d2gF115OnyMSy+NQI2MkRh2p9cZDWQgeALEOe7Vy9tpiY62/a7X/zVBvDamWGm+y9UzUCxW8NAERmnlEYW+Sa922q6RJozeFAZay/xrobhAuD5xVbwC5d7GtfH4TmWiD6JaKaTm42EpfhSvIxb83TmKzHT+sXbS7q8DXPQCA964r0AHq0uq/NUSBZON8X8b4V4iXz3e7q54sFgrPeWswYT/cMgbEDFoNfLewRkQ6yk1mwowPXbi+f5Yu8lhEYRhrGa43IUgWsK5hMzRBOtGmMnEQBHtdbNMBCTLhCVz1gg4aNT6ALXFfzZ1IBbn5FbLl09mNFIFQKfra76ydX6+jcQl0cIEBGR7JnuZIeUG2ph7ek4P2EghRMyKZ6HdAR1dxZqoqXTdQ9bEfMDAbbPE2Jf5lG+H2ZCtHzKMs0FcBnswkwT4X3fBBZlER/iUrapz+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ndvXobeMuI7kAfnhvhOiKmEk4AyDMPOxFV1ZjLW/4XFHfBY+JP5tup5iHW?=
 =?iso-8859-1?Q?yQxH2JleJAuA6hvTb941bN2SezoBVLRb0WGL0JTpsO6zeQkOdXbpzCSQdO?=
 =?iso-8859-1?Q?dhw6SBUZzjxd3nY36akbJ2wEndVfqG83Tk5o0PO0a6INUJeZdk+TvHa03X?=
 =?iso-8859-1?Q?egSXBCxB4dasjKZiQLHskgpN2dV8yvtKxr+8q3pqqKlub/WKEdMgCO476Z?=
 =?iso-8859-1?Q?Bga2Ks9ZQoijF9zJsl/ad7MrZdqamdfRjVDRmjbMAWnj6xOeDOSNDwPXDh?=
 =?iso-8859-1?Q?Mi4DOfZjI68NnFPc648bhbdPojw7/7KurHXHc6e69ZwUm8b/UANNGqNO6/?=
 =?iso-8859-1?Q?o43voaUNfJYO7ll11wL9TPVwiS2OkSbAuolTl3kdYL7sGoYE1UIlBIZitn?=
 =?iso-8859-1?Q?iV9IF11iFn4guT5gQQrqKThYgBi7PFvUO71lUEfDBeGPwkVQQ1EqIy+59N?=
 =?iso-8859-1?Q?40rDebaeYbonymVRG1CbBKX3qf3OHFFQyYWUEUPH9h74usX0b5vTv9q8Rv?=
 =?iso-8859-1?Q?X282EK0cwRgmgMsUtfbmk6Pfo/ogMpJCVlmoTnghgpYK5S/2NkVrmLsO7Z?=
 =?iso-8859-1?Q?2EJ//J+mI1tCQhYXuMVqD4NFIH7TxoKn03EaOBNzlbhJCz7AplTsnIb6Yp?=
 =?iso-8859-1?Q?Zp6m12huDsg9+dqGKrVEPXYbvDWrv69FR7awJc5QRyUVqb3fRu84Y3NSeo?=
 =?iso-8859-1?Q?5m/BhZTmpeHhkywqekJdpP2BMXN6eW8U7cJOr5Ap6eMdzs6alTSERvLAib?=
 =?iso-8859-1?Q?bF2p/f5cV8l257P+TpbfibaZ8vux23UN21WzG6ZloVgV2+aVkN4/pi61Vs?=
 =?iso-8859-1?Q?ZWYmTJzpWO++XRnf2CB64G7+jYaHt8KfJU7msfs3aVdBvmTKUD07d8R2oO?=
 =?iso-8859-1?Q?L6s2xIdETXMMPpkM8mrKVjxyTYvBduUZ0lYhjHneFVi2ZaeRFh3nCFwPWK?=
 =?iso-8859-1?Q?t20CpOAaZUVdtuhf5p2i4GUqL/jnCrQovsnDvMw5u8BAiBYbiHbMjt5cIS?=
 =?iso-8859-1?Q?KFxQzuQc3QXU+TQpYsGDKA//V6xlUGwQuFI8rF/7GFfFS2h6BeNguHMc+G?=
 =?iso-8859-1?Q?UQV9XovKpgCEfvfXVsEOhy7tBPelrOkqCRJrLCv5t6PyZxZacXkSybuwip?=
 =?iso-8859-1?Q?wx3eQ93hqNONEU5sryKDTz8/ZScStZ5FQZOe+gHpMkg3Bne/xambJmqjpf?=
 =?iso-8859-1?Q?iZLj9wKmhwOtoErqshM8KquQgA+8BS7mnuKuxPPrsMn4rXCoiOQZh1uvM0?=
 =?iso-8859-1?Q?TBQKn6teL1KWSUUv/oSqD6zDeaJTHBvXtgbrfH1YnYlazqs5HwR/EfeiBe?=
 =?iso-8859-1?Q?6uTAY7pALY99OF+/5c2saIBiqHb3U7RHxQm+rWAEI283arH/0uiNIgAvHI?=
 =?iso-8859-1?Q?OeOTapK08e5S5q1neKqmDdDNwaSPRMOOb2AJzLPymKLU0r/MwfQeNa1A58?=
 =?iso-8859-1?Q?diVZX2rdIUmEUJaoKxnCR5gCBiB0GREeNZtt71SoNOvRz+bjKdkJCZT3Rg?=
 =?iso-8859-1?Q?Uk6Mj9u+88pGA3P9o7VcZvuolrR2HnLDuMoUhC2TFGs0JFgfksQRs59PRG?=
 =?iso-8859-1?Q?vH/7EXYJFxV5YNmpNuHJN43eBTvBlFXSsw8yEq5mUPUiCmrN4K1e6qryKA?=
 =?iso-8859-1?Q?tZMI4EEoGXfqWhVxK1I+OSBNHWgm0K/QjjCir+rKSPLPzlERfz10SVL0MJ?=
 =?iso-8859-1?Q?Omzgyl6ykYPSZ/HO98nJ3B6i2C7HpHk7AHhj5k9mClY8Kwyi9dZ1R2R5PE?=
 =?iso-8859-1?Q?Zzes22Br4Y8mqqqjgIRXx+bdzQpu690h5VDAlGowAr5A5qbiL4QendU51b?=
 =?iso-8859-1?Q?mJVA7EueWA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f5RiP9fwtwh1TgKT1+0gD53ky7/QjLmrRdL3nG8TSIO2srRg+Bhi3z0IzVR+NUPais2rSQ3hlXXrhXEdskJINwxZLL1Kqle/+XtQGltdM817tUbdPCpanApqsb8waposOMPLPy2cIxeUzc+Qs4Dzk5DKvKr3nPdf/G/tHmSwKAt0ne+hvf4z5ZiefBqiqwFN3vct/+IG4qFhOsaS1kgbMMag9eszDyLW6SLOmaO2L4h+A1zrNStYThVJGlLMaadpJa9ItzeCdOrxyo7KD0k79xHw2Ia+ZMKqT23EQyiLuQY1cpqBUWN8h8dSsOgdLeIT6xwgaYAE/e6gTFOx2d7Gmg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf7ae0d-daa3-486f-2883-08dee3dbf594
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:19.0071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBM1mrLC2dpmhQA9uocKzF24ehe4pKVvWCQ7f8ey1uQcNvA/BvWdpelHr+g4tnogIbGlqAwNpNjbg4VOcgs70koTU3ehUawLmBSJHAuRRtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8339
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

Introduce a dedicated reset handler for SCUIO.=0A=
=0A=
Previously, SCU and SCUIO shared the same reset handler. This no longer=0A=
fits the AST2700 design, where SCU uses the Aspeed2700SCUState subclass=0A=
and will handle coprocessor-related control in future changes.=0A=
=0A=
Since these controls are defined in SCU (not SCUIO), SCU and SCUIO=0A=
should not share the same reset logic.=0A=
=0A=
This change gives SCUIO its own reset handler and prepares for upcoming=0A=
SCU-specific functionality.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index efe1d6315b..ca93c3699d 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -1069,6 +1069,16 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AS=
T2700_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCUIO_FREQ_CNT_CTL]        =3D 0x00000080,=0A=
 };=0A=
 =0A=
+static void aspeed_ast2700_scuio_reset_hold(Object *obj, ResetType type)=
=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
+=0A=
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
+    s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
+    s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1076,7 +1086,7 @@ static void aspeed_2700_scuio_class_init(ObjectClass =
*klass, const void *data)=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit I/O";=0A=
-    rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
+    rc->phases.hold =3D aspeed_ast2700_scuio_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets_io;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scuio_get_apb_freq;=0A=
-- =0A=
2.43.0=0A=

