Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77479C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSQ-00048l-M0; Wed, 08 Jul 2026 05:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSO-00046v-EJ; Wed, 08 Jul 2026 05:20:40 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSM-0000NV-P7; Wed, 08 Jul 2026 05:20:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZdZaMiggaa6hAKzooPluhLw/8xLRotQIqu2x4h/MT4HnxWnKiei0rfmfmBMcv/oJzl2OwgxUIQGT1DA6hTALTLPwk6NlPgU5VZ0gfFIH6B+NjFYKvlyIO1rPgVKz8DbrYqj2JDs9Ys5kATID0Q6hG8E9QTY/JwWUJYbFkIxT3CCe11ZQpu4bCxy8Wn4lIQZJYdNTkCvYNxfqW/Mz/9/9Z5dob3U0mZVd80xTMwUUJSey194AzzDypUVK4zgO/dUkswEeKWcnNihQiYvgza0TNu6IlDS1XJPTwvOqAVPpsv8iEqayLBVAFBN0KxifPs1hBkstZPmgks/vFgk+Z6tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH2TZcbskFjNiPt2D0nkECLtzdC+bgvhWBRSbc9RtYs=;
 b=BIcztYtL96htcRUMceZEGmgdcikN5OTnyklEXgmfK6k3WA41qFLpvVP06IvbKN9qoZH3LpwWpcdZskyUdooArkRyYQn3ukrAY/NKM+XE3k2rlu5kxIxpE91qe2tYlcjJcfwAd6qaQ9VlSj8FqCNT2/S/joEFkZ26wVL2bK5JJ5S6XTxl3TxVPT9ez4rvIJ/CNaRG/edaUWqdpAZ/9pxBohlzRlfDimRPyxwnZbcsT8gOi1HTAkpYZsnK2tCvMee8T/aC/WgBeCloPvOwod5Wp0hBN8yPhAB3khHTzDu1Nuo7lBaUNbyt/PbgQlTHMMvEjLE3dxohs7WPswJa7GuPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH2TZcbskFjNiPt2D0nkECLtzdC+bgvhWBRSbc9RtYs=;
 b=bV6+Bn7SNxKwNmCZnaHPWsqRRU6RR6D37zR4WRRuJA8WyMh8rRTJkDzK9rryDNQiNMDcpZHOXy5YEMWb3PR88HZARizTSInS5gltDZkWhnbDcTfVO5DnEOwSb5zHOFgA7YDJe2AcJb3pn73rv9vekews5XRy9ZcQidSfm2AOAxxt4b1d28mrATvQfxcblGB5ksf6MIXoUvFQjdgY/h+8X4m4X7OMmuGKRjZR5Ampd/b5oQUo165cor1qCwmpMSZMWNni/+1p2OfPET16/M7ft1cDsKztdZVeZa6P/9hXRRCrIMqMzVQDUh6VGaWvJ1cYUoTUxZXjr2TTPt/ieNQ8iw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:30 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 04/10] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
Thread-Topic: [PATCH v5 04/10] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM
 remap
Thread-Index: AQHdDrsFEde+2vNAiUOso48A72IYzg==
Date: Wed, 8 Jul 2026 09:20:30 +0000
Message-ID: <20260708092023.3826159-5-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: c3eb653a-8833-40ef-9ff8-08dedcd2282c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|38070700021|6133799003|56012099006|921020;
x-microsoft-antispam-message-info: +CMsQkrjmDR2E7LbF76ohsIvcM9+i5qtbVp5oGgKJJ/Iqc59akUFc09zikMzrNbr8X4s19RBxMXceIEcccLLgnmSl+2fo/b+S0HwNoSqFjWDIqarAHzlSsO31mtly/mveIxxfvKxk912NFs4Q1ekAyfNsl4sJhrYgYwaunyZmeOlMWashmsyUMNN7Gjcn8/ToUK6u7IYvA8DAMSyLo+fDPNzi9bHScyn/JpVqsz1+uoTGzdUGMGeIioJHqfLYiL/R7Fnik+aDqTVLIPQHctU5dJdS1JnM/Or2fuKoIa3xWeK+8KeSckLgxDXbgrjIkkeP4Zlaj9mS9GfaxA8pkVjtjJHqgyqx+k9AfqSh7yEM3HLV5NzO8ruxHX0i4tV1Kff35WquGbt+cN1gtU2keC0lRGsR8rCVYFkGEoJBpT7mIJAU+64QjKgGzn4As4c6HTSAcmF8M7yNLFRZmP95jK5xoS3bSbXEaW0j1pkpJh39aDkCFcJ/ZF7BFC6LFOIMPlC8KhrBxAQ4Cg8cOeedcm/DVgt+/4O3t9AifB0ckIDLgp4ZfTG/z9jkqtz98t9B5WXRyebr4TaMweGCpRjF7SKzKLum0ZD4WpQBtcfI/qogAn4VNXKbjvbsr78h2SDm2JmWgH+tQyDp9xQrL8cvdHB/jTe+RrGwBTQdPVnsNDtYRAsBq/CG2AH2vt4zpyQuk42+/ozkrrLGnAiWzvfkVP3o/SJ7futulKUezo3pFJqhwGsHoIfv17lnoDChDRpUFCQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?airlRBNbnJ4il0YnD+Gk+4SZk9BGkGGTCgNVWTwecKRYUyyMPs2OVHe93W?=
 =?iso-8859-1?Q?kF1cfqHjIo19CLPQVKfcyLV2ty9Es1HexE2/IafTJsLJZPvnnOH4C+rTTM?=
 =?iso-8859-1?Q?1grVgepjw2qE88bFYW3d/JTk/KCdkc576uGxEOEepStZpDgAWg1KpK/Qip?=
 =?iso-8859-1?Q?+Lb1LWx9VFOJh+EfTp+4Y4uxqTMyK8kReO/ucB0OXbYYDd8Bva5hWnY1Dl?=
 =?iso-8859-1?Q?NyyLccLfC7/TZ9u1U+gjknWzYd84u6wOL5FMBKR5jOLyo77J6zZCvB4TKv?=
 =?iso-8859-1?Q?8tIl8nOyTpt8RTMZLWZfW+Rt7s3CsaTBDeP2qW+loiW6iXta7BzhDbp/RC?=
 =?iso-8859-1?Q?ZbriHHlPhUZbJUQm0cKN0iwILvHd4J09xYsSpuVe+Nnj2BPEW5+lScpW5W?=
 =?iso-8859-1?Q?BMJysHbGc9SajfXybNNcRKvE4/yvHzsu+iMhV8xZ+AcR3HcJvWNjb/B3cX?=
 =?iso-8859-1?Q?av0zOciedDepq7nY78ov4hQ1Gd5t+KXWPbOg1P7brNzVPdhvgZ5W2mDM78?=
 =?iso-8859-1?Q?kbMnFTF1JtOlThT3Wi3Kb47clE62KSLv9rzOd/Wbf7rLmt979JHtPX7WsJ?=
 =?iso-8859-1?Q?SGENTYao1waCojj1MnMiCVlmQ4wtRhlWAESFbNEDN/kt3U0E5CXqqzf0tV?=
 =?iso-8859-1?Q?xYbmc7O0RFBA9T8+WG8p2KW8OSoTE1qmPR7F7aXI2W1sJWMuR0w+tCbFhQ?=
 =?iso-8859-1?Q?r4890py7n13dOvirBOlH239I8F2VxMSXUZ4wA+gkqgqzHaz0LhpfHA7nUq?=
 =?iso-8859-1?Q?Jc/y0Z1SDqyQI/93UmIh1GtLjazkZRD3vNyRUMny2lWN2AgEGYHULlBCka?=
 =?iso-8859-1?Q?OwBkkCFv/u70KjXANxNOdG4v2LWpHHTZ3+JnUH63j0R9J5uN02qLxyGIRR?=
 =?iso-8859-1?Q?kbAFJ09+U+ujJt158KycBF23j6FYOpgC/iGy7gmUlxoUXHGVZxbDZ1E1kf?=
 =?iso-8859-1?Q?nTrinF+C3/tJPNYgio4IkPBiPq4FbzVv7GjQVZaiZFKF2ADcIRtPM0+Hdh?=
 =?iso-8859-1?Q?9JkybYFMCb2yxNQOacQwU8VCKf8QgLOjg3C4pvIUNUTkMrBghoEBBXgmYb?=
 =?iso-8859-1?Q?5pTElGAjH+nvPQoKFQOld/Un9kFPx++UnHdeEo+iCQ4GBODPw6SP036Q9u?=
 =?iso-8859-1?Q?KtlrXXiW5U5QvS2sW9z8SeYvw4kWxP1JVTc9KA/pgGuC6uwMM8Wx7gKsTK?=
 =?iso-8859-1?Q?zbzY4gHANcZofT9rso1h0C3KTU7S396GIj3ZeL8ZxuWh0S47XCgzYO+u4X?=
 =?iso-8859-1?Q?P90QrMLDet/8aiMVvse1U7EtxAex+80Wktjb9QYdOGxh4WRii7zE24L3bS?=
 =?iso-8859-1?Q?lzj8R/nemaH/JAopfr9KG7OAtM0bsZ3tmyDWbyJhMd4LuWDeP1grrz9YY7?=
 =?iso-8859-1?Q?oV7evVQyw4QBSx/gnDJgrQTSAn6RDZOkwG+Tof9axakRIWFTeS5A20xBMu?=
 =?iso-8859-1?Q?VspDKn2Ccz+fxKDKYb5EYyflLb8GsEdhWWQ0kd8JpUuUlEpa/Qmo9W4gBp?=
 =?iso-8859-1?Q?CcFEqOM9jmSHkDF0+K6fLlrfoKJWVt8IMQaPSYe1jJSj0p149EsNMPRgsQ?=
 =?iso-8859-1?Q?AfKmHrsbAlgl9lNNWFELC96q2YpJQSLXZjxuUt4uaBF7XDx02ptzCxlQJm?=
 =?iso-8859-1?Q?nPtDCfGp0QQPQLeqFbV2QIc0IL4/D4BgB7gVdpuUhhn+uZPcMi4JzkrkiO?=
 =?iso-8859-1?Q?noyuFqeDmi7SQa6qEomjwFZC7dk9LYbx4wvcOXo5TDdIpiJ61w9r/R4nxq?=
 =?iso-8859-1?Q?06ZJTwg8Bwlw6RVzIP0LDoXxZtTqdYlqYlGjSAPuraakxuyvqyKt8bvH3K?=
 =?iso-8859-1?Q?FkjY5ifZqg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BH9BL7Mwz9R25WyAGOafu5J8OTDGy5Bx8plgSPegHC3JiiWuKsliyIMW13dgNQdFLpfGVO6mXDiSbkMzcFVUM5ZAKcCzkcRUCALxxU/qaGCjHeKp/GVRoxTApBJNPoM4rIt6TNQFACZksJUJVtbB2obyzXeRvV2lLWZRypF+bA7olmDvTBdREAgIeSuK7tV0rd70dt//NK9AyalbwIAog4AX1rTNtwuCi+XslCXWWJswhlJaAoSuyYsdsYEB2qml/2I+z9ms/hPYWrZjGgMUrW6VrQ0n1V8xWTruZzDmzRdFE2yzwR1Z/1RziQj9TlnU+bxcOSRZe31i2r6atVmBfw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eb653a-8833-40ef-9ff8-08dedcd2282c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:30.7827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+O8K7e9RH2F52FSsYZceYZqMURoHM7wusR4gwOw5aErdS/snB3r/Bq4Mr+t/o/UKinhEkJaNQqiubIYLFJt+/bDitrG6yRiE8zlnuG3SDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

This commit adds a MemoryRegion alias to support PSP access to=0A=
TSP SDRAM through shared memory remapping.=0A=
=0A=
The TSP coprocessor exposes one DRAM alias:=0A=
- remap maps PSP DRAM at 0x42E000000 to TSP SDRAM offset 0x0=0A=
=0A=
These mappings follow the default SCU register configuration used by=0A=
the ASPEED SDK firmware, which defines the memory window mapping=0A=
between PSP and TSP.=0A=
=0A=
Set TSP CPUID 5.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  1 +=0A=
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++=0A=
 hw/arm/aspeed_ast27x0-tsp.c  |  3 +++=0A=
 hw/arm/aspeed_ast27x0.c      |  2 ++=0A=
 hw/misc/aspeed_scu.c         | 18 ++++++++++++++++++=0A=
 5 files changed, 26 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index ae49f6ab9a..1c3a220d96 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -48,6 +48,7 @@ struct Aspeed2700SCUState {=0A=
     MemoryRegion dram_remap_alias[3];=0A=
     MemoryRegion *dram;=0A=
     int ssp_cpuid;=0A=
+    int tsp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index ce245118af..113248b98e 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -104,6 +104,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
Error **errp)=0A=
                             sc->uarts_num, serial_hd(2));=0A=
     object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,=0A=
                             &error_abort);=0A=
+    object_property_set_int(OBJECT(&s->ca35), "tsp-cpuid", 5,=0A=
+                            &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 4212e7bd4c..369576bde3 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -232,6 +232,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
                                 &a->scuio_alias);=0A=
 =0A=
+    /* SDRAM remap alias used by PSP to access TSP SDRAM */=0A=
+    memory_region_add_subregion(&s->sdram, 0, &a->scu->dram_remap_alias[2]=
);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 10d3e35a9b..9c13efa3a6 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -444,6 +444,8 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                               "hw-prot-key");=0A=
     object_property_add_alias(obj, "ssp-cpuid", OBJECT(&a->scu),=0A=
                               "ssp-cpuid");=0A=
+    object_property_add_alias(obj, "tsp-cpuid", OBJECT(&a->scu),=0A=
+                              "tsp-cpuid");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index cc0aa3234a..88c1a57299 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -958,10 +958,28 @@ static void aspeed_2700_scu_realize(DeviceState *dev,=
 Error **errp)=0A=
                                  "ssp.dram.remap2", a->dram,=0A=
                                  0x2c000000, 0x05880000);=0A=
     }=0A=
+=0A=
+    if (a->tsp_cpuid > 0) {=0A=
+        if (!a->dram) {=0A=
+            error_setg(errp, TYPE_ASPEED_2700_SCU ": 'dram' link not set")=
;=0A=
+            return;=0A=
+        }=0A=
+        /*=0A=
+         * The TSP coprocessor uses one memory alias (remap) to access a s=
hared=0A=
+         * region in the PSP DRAM:=0A=
+         *=0A=
+         * - remap maps PSP DRAM at 0x42E000000 (size: 32MB) to TSP SDRAM=
=0A=
+         *   offset 0x0=0A=
+         */=0A=
+        memory_region_init_alias(&a->dram_remap_alias[2], OBJECT(a),=0A=
+                                 "tsp.dram.remap", a->dram,=0A=
+                                 0x2e000000, 32 * MiB);=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property aspeed_2700_scu_properties[] =3D {=0A=
     DEFINE_PROP_INT32("ssp-cpuid", Aspeed2700SCUState, ssp_cpuid, -1),=0A=
+    DEFINE_PROP_INT32("tsp-cpuid", Aspeed2700SCUState, tsp_cpuid, -1),=0A=
     DEFINE_PROP_LINK("dram", Aspeed2700SCUState, dram, TYPE_MEMORY_REGION,=
=0A=
                      MemoryRegion *),=0A=
 };=0A=
-- =0A=
2.43.0=0A=

