Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F119606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=PyZdMUYO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtSd-0004Oi-MI; Tue, 27 Oct 2026 22:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSb-0004Mm-E6; Tue, 27 Oct 2026 22:32:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSZ-00082E-Qm; Tue, 27 Oct 2026 22:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R79HYhMwXAO/2uZY7dFebp27/vOEAmGalQfPcuMIWmdcSfVVGlCTDOufk5NPqrTdLuRcbmgTJele8zFYr2X7ALFO+XLk3t8T7553noqMh3BxmBcZP3A9mM/5xfpsslMJ3zdWvvKwxrBeKjmsghZYoiJtcsewYGAsn2qcVymJEPEOs1MoUcuJMl2nwjolhZ9O0Av/FgTTqYDf7MIPKMrDHsLbTnG1gorM5UjcS3hyAOpg6OZCuWLte0a6Hbaot7IKvvamehAfQoJtq+6I4noqGH5972jEpLtl+1UKnAaQedC27ccF3P9nl+DRRoEcjrQVUshK5cq8rKB2KOutYDz3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXwh9CSDZXElKofvjLDXpgY9YO6+F0NwdB4m+j7gfVo=;
 b=IUkBhQvu1himTDiN00yPHx14WxxMoafjWDyJtdsA2ANQMnayEf2S1KG1vmDE8NTNrrFzI6/3Of8DIMvYVatfkGCIPxmdQOCoVeqG5rAK6BPI9y9WOGJr7h2oJ/OK3usHqtGgBM6rxZQk1CtNeYyeDuQklzoVwEaIWBiPeXQG5pspg7DRZRltacrmQzxYN6mCuFN/VhsiBDIfg7C99QVsFdF1CL1pBnhMzQt7E15dT31pnVqjbVMtsYwdba7Y67g1YnM+NwzA5e/8DcKWJOtI1JDFgYfEV2S8MHyW1tS71GDIGmvYVPXPua2R9q43+IPUHf3E1ZxqQzw8NMfDQ0p5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXwh9CSDZXElKofvjLDXpgY9YO6+F0NwdB4m+j7gfVo=;
 b=PyZdMUYO88dw4IU17wHGClTE39uv5cxlmZR0gcTRzIdhOBWnQszs3IfleXN3NMp1ql2v7nm0BZj2xaCpb0MxdjA4kQsp945ezuSSzLZMTykX1uLK/ioyDjxoNiMKtfbF+yNTv+nSJ4j3T5ndaDcEfp25dpFbbv/DVNoxMUtHUzC3nOC57NgCsrZjyEpnEvfyyY7OoxvI50+12kQvEAwg0g9OVHEqkF74oBdn2Rl/8vC0QDnJKkDTrDPrU15iZPGdDAdY+JUpxD32AEZcdCj5fLPfXaYJ6S+abqhqNTET19NTD0FQIDlh8oC9v/ykVgIzmB1RCAA9349tv6j08YVAog==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:31:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:31:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 03/13] hw/block/m25p80: Add Winbond W25Q33PW flash
Thread-Topic: [PATCH v2 03/13] hw/block/m25p80: Add Winbond W25Q33PW flash
Thread-Index: AQHdZoSBa0aRb8HgB0GaOvfcRuRm6w==
Date: Wed, 28 Oct 2026 02:31:58 +0000
Message-ID: <20261028023154.48395-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 3a136c33-d873-40b1-e02d-08df349ba415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|18002099003|22082099003|921020|56012099006|261021121427099003|10067099003|261022075727099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: Sh/6VU61QgY9Tmcf9U5MmftjBozv0sNthQ2kTe71FinjKC8yCVChiNgHLb0tQPzitttyhq0jnCotjnfpfjCuZpP4DGpwp2S+pBU2X4i26qTPxuvx5+QsCxlaUj4zkT1f5sYNGl21FZpcQgawI25M3W+NdLEqcbysAa13bhzPnoXjL3561J7dBaXMd+GfseMBaw8ibMsElPVhiUe7gCT12T+4AQhW7Di5XlsY2EmZOA/jO+sqLsQAsf1CrAvG6Y8eu7CPd/y73vJly9rVHZH2IMOQNdhcZo1qxHAiU04aoG2+pqGiXWgwI70OkaZXXcpQY5uFtjPxzpkuKSh66dDC1r+a38eDMf7IL7rBougz00yDZWNpODe2UGTJtFhHF9r5JMRD2kQe9DyzzhU6J+FOoaVPqOcNZbQ3xWK+EFOGm5U6aG9ktAHRFkhAtvmzmSvJz+CsEQFMAwwvZFTGAYNogNkH7NBNqC3ZkdYA+r2M7/q5elKWiSt4LC5nI2I3taXGLDfQQwq2UYmDwMgNsv724bipGC4xgV7Bd293Ai9iY1Hr61A+TrUbUfJh/alCiEGEnrNIzugYDlLPDTgQyEek5l09xAQmssbetFb5bdAruQi6igJ4xooNre7uldx/963TVyd0gGRLNeOXewazY5DRwLLjg+T5KoIWzwCOq5wkj97hHgdt9527KDguHdukrQ3ZMDfyLl1gBQufdx/ERPWWuTfYjOG01OlCoqELqNU1yENL+bn2V/XbjrGx2AmxbUek
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(921020)(56012099006)(261021121427099003)(10067099003)(261022075727099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OxTX00jQJU96V52AAPvFE2htJ7pdvErdR9XQboLacwiR+6omzwg9mKg85I?=
 =?iso-8859-1?Q?tEs2Cr/Qb08Wu+4hHFtavBBS9wwz62REp/BDAUPAqV/b5X3aozpTkC09dY?=
 =?iso-8859-1?Q?dd3kMIKaRBb4rmqmzJfUQhVDnYt4Me4NJO9B2glu4NYpwTOhXeON2VIsRN?=
 =?iso-8859-1?Q?blHRrOmwNkO5dPP7HHyF5BMqYTBoSKBmw7CdyYht6v2g5GUoWgoq06cD8u?=
 =?iso-8859-1?Q?f4RZUHFPPvgVrl8CrQIMSd+kGOrx67YVIRVnRSEE8Mi3Yj03421QSwtqaO?=
 =?iso-8859-1?Q?oJjpxAI+shMCeGlpfktgV+rgvUggccxmOIHQhKPwSUtjTJgQSAntKO0TEy?=
 =?iso-8859-1?Q?0A7W7V6w/IacACKVC5DRT5WJSqO57F0NjMYK9VsqD9f+k+d0afAbG5APjp?=
 =?iso-8859-1?Q?Iiw9m7bah+VQ4iqF7N/KUSz0ijAutGeJcrL+8NyfCoAma7PXTtmLkzUwh7?=
 =?iso-8859-1?Q?q4h+mjLEzf4wtcYQEm1j61/D9sZ26mVdj+M1bcj6SL/dqRHDlu9M6pJlaN?=
 =?iso-8859-1?Q?7fFxC3tfwpcxbSpX+cwoq8qwyVL6WgSDxjUylAF9sZ8aVHS9Og8s26Ylqv?=
 =?iso-8859-1?Q?CKm72PmhlloO0xsLa2C0vBijDqCQANWHZAgMxdtmgYNlP14CXQOTSESdQ3?=
 =?iso-8859-1?Q?O3d6xerH8um0RI3V7nCdkDvlGvsBT2bV2nZBgH8k6J8K+xsJkgIu9JYRtk?=
 =?iso-8859-1?Q?B4Mc57wJkYFbOEnMepNK6PlzW2IDPJtZAss53aIQ0t4vuzEo8LT5CYpqfR?=
 =?iso-8859-1?Q?LqWSVFWOAOLuvZ9Jl1BKRrN34bAnBOG3iG3+0btodSztIupfeCnlHTLVCl?=
 =?iso-8859-1?Q?5su9f0CbYavcHIoGjq0dZX1oZvzILJ4Iy569xjtYQLI/ZMy+g4llb+hPf0?=
 =?iso-8859-1?Q?urdUTpkKpdc+f6Saz7xhTEsee84fdtfvFWPVMkthEPBbVMHFr5j4bUnpYx?=
 =?iso-8859-1?Q?Fmhg0AJWfOam4n/hNBRkho+8A3ItFDXXmNp0Xwn09tEwH8dOi/Tf16i+7Q?=
 =?iso-8859-1?Q?wVOzmN3onJHw6sgUASdxwLJsadRcw+7zsiGi915GFZRkuN7hlIt0gUE6hk?=
 =?iso-8859-1?Q?LVXxucqZN0BhWioEgTFIewJOUUL62A35SjynfHpakTMN+EYQC7H/VJuO01?=
 =?iso-8859-1?Q?RYePE/1TY7Td1EG7OEKOWENqln2nzBw75g/1POCSX2j9dIpRazatdZzHp8?=
 =?iso-8859-1?Q?7+haTTzWKSQ4EyByyfL+szq1vszdBHqSGsSkBN2RMjnBZSRcyoczcmt+M7?=
 =?iso-8859-1?Q?QkXWQfJqY7hE8duMam1QKUYj+2BXp8Q/44aHKmEpEOwO82EdV90xwFx3bR?=
 =?iso-8859-1?Q?0qOGUj7Ea3bba+brIMoHFOooAh+UPC9285n3mGSJhUqjopRlrq8ssGup+M?=
 =?iso-8859-1?Q?5Mj5gccWOpEhkCaB4rLZr/xDmX2BRBTnE0sd1Ii+n6sH74x/lGPRxm7UhO?=
 =?iso-8859-1?Q?kTDqWsDWo7RSPwJ8Q6tdaB6Dg1HkrYMKswrP65PQYBGXMrxojenS1DGBl4?=
 =?iso-8859-1?Q?GNU4eyZk8H0A6aZB7h2WOi6ntBslO0rzgy5BeUYLyshNBdRY4QUKtl0H2Q?=
 =?iso-8859-1?Q?XhaneH/6rkPs2bNd0X4RwJXdhcYclsflP/0Z2KVHt+6PVNFCAXYpoVU6UJ?=
 =?iso-8859-1?Q?6g3ZB34pucxeFAJgKyqXJQ0JtZaECwEpKg5RTqu8Hlp287ePhGnxg1Fahk?=
 =?iso-8859-1?Q?DOSPfngZhB5oSpp9P9lz44vNqJ5IKz2GT8/O1/nQOBeYbx7M8pNsDAAAI7?=
 =?iso-8859-1?Q?UtNqGJH8HugEU16StaxALjq4c0z6j3j/RRK90Qlzjgp0mtm6PKH+x7oBz9?=
 =?iso-8859-1?Q?eZZKEveoxQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a136c33-d873-40b1-e02d-08df349ba415
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:31:58.0595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5N7yMpAnhy4twtKQbI/TnJ4zhpl0yIHrvofbcs+QIffxDpB1Tjrr4bGsQvQPjugbAazsbhHXUWVrefh8qRyYn4DfTSokhLvS+5jWNK26nGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8531
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The W25Q32DW and W25Q33PW use the same JEDEC ID (0xef6016), but=0A=
have different part names.=0A=
=0A=
Add the SFDP data table for the Winbond W25Q33PW flash device. The table=0A=
was generated from a real device under Linux by dumping the SFDP content=0A=
using the following command:=0A=
=0A=
Example:=0A=
=0A=
```=0A=
hexdump -v -e '8/1 "0x%02x, " "\n"' \=0A=
    /sys/bus/spi/devices/spi1.0/spi-nor/sfdp=0A=
```=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/block/m25p80_sfdp.h |  1 +=0A=
 hw/block/m25p80.c      |  2 ++=0A=
 hw/block/m25p80_sfdp.c | 36 ++++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 39 insertions(+)=0A=
=0A=
diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h=0A=
index c1e532de5a..61544fb7cc 100644=0A=
--- a/hw/block/m25p80_sfdp.h=0A=
+++ b/hw/block/m25p80_sfdp.h=0A=
@@ -23,6 +23,7 @@ uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_mx66l1g45g(uint32_t addr);=0A=
 =0A=
+uint8_t m25p80_sfdp_w25q33pw(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_w25q256(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_w25q512jv(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_w25q80bl(uint32_t addr);=0A=
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c=0A=
index 545e0b5728..baf798c6b5 100644=0A=
--- a/hw/block/m25p80.c=0A=
+++ b/hw/block/m25p80.c=0A=
@@ -354,6 +354,8 @@ static const FlashPartInfo known_devices[] =3D {=0A=
     { INFO("w25x32",      0xef3016,      0,  64 << 10,  64, ER_4K) },=0A=
     { INFO("w25q32",      0xef4016,      0,  64 << 10,  64, ER_4K) },=0A=
     { INFO("w25q32dw",    0xef6016,      0,  64 << 10,  64, ER_4K) },=0A=
+    { INFO("w25q33pw",    0xef6016,      0,  64 << 10,  64, ER_4K | ER_32K=
),=0A=
+      .sfdp_read =3D m25p80_sfdp_w25q33pw },=0A=
     { INFO("w25x64",      0xef3017,      0,  64 << 10, 128, ER_4K) },=0A=
     { INFO("w25q64",      0xef4017,      0,  64 << 10, 128, ER_4K) },=0A=
     { INFO("w25q80",      0xef5014,      0,  64 << 10,  16, ER_4K) },=0A=
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c=0A=
index 87878c2bf0..8ac603e212 100644=0A=
--- a/hw/block/m25p80_sfdp.c=0A=
+++ b/hw/block/m25p80_sfdp.c=0A=
@@ -296,6 +296,42 @@ define_sfdp_read(mx66l1g45g);=0A=
  * Windbond=0A=
  */=0A=
 =0A=
+static const uint8_t sfdp_w25q33pw[] =3D {=0A=
+    0x53, 0x46, 0x44, 0x50, 0x0a, 0x01, 0x00, 0xff,=0A=
+    0x00, 0x08, 0x01, 0x17, 0x80, 0x00, 0x00, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xe5, 0x20, 0xf9, 0xff, 0xff, 0xff, 0xff, 0x01,=0A=
+    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x42, 0xbb,=0A=
+    0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,=0A=
+    0xff, 0xff, 0x44, 0xeb, 0x0c, 0x20, 0x0f, 0x52,=0A=
+    0x10, 0xd8, 0x00, 0x00, 0x14, 0x32, 0x01, 0x01,=0A=
+    0x81, 0xe3, 0x14, 0xc2, 0xe9, 0x63, 0x76, 0x33,=0A=
+    0x7a, 0x75, 0x7a, 0x75, 0xf7, 0xa9, 0xd5, 0x5c,=0A=
+    0x39, 0xf6, 0x6d, 0xff, 0xe9, 0x30, 0xf8, 0x80,=0A=
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xac, 0x00,=0A=
+    0x00, 0x00, 0x00, 0x00, 0xf7, 0xf5, 0xff, 0xff,=0A=
+    0x0f, 0x00, 0x00, 0x00, 0x06, 0x0d, 0x44, 0xbd,=0A=
+    0x27, 0xed, 0x08, 0x0d, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+};=0A=
+define_sfdp_read(w25q33pw);=0A=
+=0A=
 static const uint8_t sfdp_w25q256[] =3D {=0A=
     0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,=0A=
     0x00, 0x00, 0x01, 0x09, 0x80, 0x00, 0x00, 0xff,=0A=
-- =0A=
2.53.0=0A=

