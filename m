Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EFFC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtctc-0003wh-0T; Mon, 10 Aug 2026 23:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctZ-0003vJ-Oc; Mon, 10 Aug 2026 23:11:17 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctY-0004L5-4C; Mon, 10 Aug 2026 23:11:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PojJHxAoNGkxDlJqmlLRGfH0bDoMxjxQmfFPQuRgOkJnlOgSLCFaYMyRrIqlBogQrSYPMogmrvro6Vsbwsgsi+9/oCgz/reYj0/l5d3zddgbibTPMhwEDTSRe2TUH9U5Tyrteb9ME/SUL18P93XM3hYwOaEapzpPG07MQgZOxslYq46yy6Cn6QCY8H9cSZOvnN/Z8lODjdJzb4XSLS35cybYKEz0ss24qatNHG9uoC/W08bkpOcRbiiD5wBbvrYHxL8CJk9F+rbXKhizc/HJwI2LZPVvi8zHklz6TBVEkiwwFjKfub1S5pWlb0MQEyBAahrkAk2MWF78WcAso2vDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVfL5dHQN1kyKBvFKQTw5SAac2NRn6v3dquzwdxZ2XU=;
 b=hn2ayGzojmLoS/dFajqB40Cb3OB3MhdAU1w44PuOiJc4CBN5jv4OwyN0R7W9eVTrCFM8F48TWlpc1x8Xi8B9S9XlCxnwJqRNc89Kx0U1kDa+q31kILYCLCu5WGK+Mye3FJp5X8ZvrQdalMGbNALenJDv7IJearRgf6dqb5oLWITU/i9cpYZACgxkWHyrhaMkRKZgJYavbPKQLt9VBoblEjrNjqHhY79vQ7i9n+cbYh5nygUI9mEeTqHihgnNTZ6X7sPijEUm+DR7ZovrKaaoKETJ6bIe/13ecU7LlHdC13rPlRiSnIAC6yHLUINSqsFTu8qMA1YhcW5jAgwMvpvqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVfL5dHQN1kyKBvFKQTw5SAac2NRn6v3dquzwdxZ2XU=;
 b=jJnZuD3b/gjgvhaD1KHFSoeCe/UR6uNVCzOVHE9oSufsIUJKnfKSNjdO0aNDT09pcWtc4XKGsFqe5/RxWceiEUcDBTZ+MgxlZuHtgP8zOy/AE274Ne08uDHrAXRNT/ffjwZtrRo64GI4fOPJg6wdpsRFMHJ36DOS58Hk3RACXuaJxUyG0lLfNtdrgDFSOEYvZt2pSPPOdxsck9TElzV+6QJZC/I017IdFHzT7KOEaepZo8L+TVMcaGJhR9D+dckOv9bMhUu8kuOP501Zp13epbYigbZNjy80hBGp0Mss6kDQEhZbHn9PQFTT65s0HlywqZfjVGO9mQF3b4hf3rBpEw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:43 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:43 +0000
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
Subject: [PATCH v3 13/16] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Topic: [PATCH v3 13/16] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Index: AQHdKT7/KW6RkWEV2UCZMSNoQGOB5Q==
Date: Tue, 11 Aug 2026 03:10:43 +0000
Message-ID: <20260811031025.2784489-14-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: 178ef3be-c285-4b46-cd53-08def75621bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: d+EO1PZRSM9IbjZW3ryvGBlIoHcd/M6vu02rthygLZfqL1xVXdVPncKSfk5n0ceCWhC3jg9OhqcOOAYOUINwbXk4urbq6XgwdVzV7/NEW6C2vqaM/J4CqG1D8WtzYSbSQ7hpsKxuOdMYKNbnkpVqXuusbtq1KnLGXNrYaNmFJj4wPKsnb/I+yRZH+gDEjuTT4GTMJ6DJknGzhUfBRYvFg+6QAJDU9MJZMeX+tO4eROW25euvJgh99aj2dSlvMRoyw2aTbI0Hg8ci+i3IJibbpwDEYs1R4j/AT1ViQAUUhtHCXtqHuBAto7EeTNjD/yTRDByxR1BXA5v+zhBJMDeVKMlPiDSLIw6H7M8J+F+ciZu5QsXMSXpG0xiTOTzchsFZMX36AUyXFtpAHWahwt+tlv/uu/2jxMDP4HngNftvHvkBgG5BzpVm7nwSAlGlqc1TGVJPNwunDPsVjkqef0kJ6U04I8sBF+T+v+uNS03qnbgr3WmAU86UdU3SuWA31R0JBbQ+Za7Im4/ScmpOajdLDB3+1WVk/HHwUwbjH6IwO6moFQ7+mdpZalhljbh5hlUnrX02I2dFBTMcBCMNl3CM4lDOiUkZXMYxxDECFX0utbiZdeKKSpR0HoqpmnDMBhRwv18iBCbq6pmg99cHrJHiI8PVWNpeaRq37hvLv7VT+WxNCQp7HT9ddPJDK7WVVCIZU5kOliNDPPAJppTzsL5vkmFRsYXsoyCKrtkJyX+Lgls=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d9/14Vol516WtbyqCLQrlTSG9IITwXkWaS7BS2hL3wva/8PdWja0MlFwDi?=
 =?iso-8859-1?Q?nXS3lTAUasydLhJ79WhX8zOJTsJN5Lczg1ipPYT/n9aQiH27xceWoor610?=
 =?iso-8859-1?Q?j6nfTIyzFmmYQR7+5mABdVQcBIwYRD/GIHO8+YJAyIwbjv4DQhD1OjXnbt?=
 =?iso-8859-1?Q?ITQ4OCJrZTT39rBQF8oD3H4pZZtmB4FV5mqxKQQhsP2ZyRUJLgxwgW2v3i?=
 =?iso-8859-1?Q?k6Ss/hjGH5pPkymFrPDPS12s+qxoX3ESpOmG+19v63jI3PVUFll+UMNK6B?=
 =?iso-8859-1?Q?wkhrrbs5J0FZqYSWIn0Anl6ykCvoTWrcH550LaKgezfQdfTcSwfal1oJWp?=
 =?iso-8859-1?Q?f2zwPoBzsWFsgv/qkrcUecYQzQm9Gpe/I9G/Hy9kGc+zcL0HV/o4EFdxKH?=
 =?iso-8859-1?Q?GDXCiSoGltV4rFLjZW3gl3tHcZA817o7jTAW9rHz5GMu53Q3S3Z2Xcm9fc?=
 =?iso-8859-1?Q?cZl5oySKoaG7mOXS5WeDgNpCeO/hIZSxd1zes2IfheWLLxWWVTBS/C/kxA?=
 =?iso-8859-1?Q?0CZkHxhJT4lGItuMKz0sZJsR3wPaYND/UoVOUPFanPpJWN95lk3bFARJXn?=
 =?iso-8859-1?Q?XAfKCHWU4+RLungO0OmSQxo0J42lScXvbIaOf5mzpop6OMOzSWe0xO5e8h?=
 =?iso-8859-1?Q?stCpotf3cyhT2BRpkec85W3hn6SzXxUfybHxqVfFwoATpPoHmen7QJC0/Q?=
 =?iso-8859-1?Q?IU1Mj7E+ptgLGEcPcthnFG4h/J68HiMBEkcDoCsGQunBRblE7csTKiT7bd?=
 =?iso-8859-1?Q?whJQLxpaA00LEFsSrShjwAjKaUCJY1PT4deIVerwQnvciESA0whdU0kNAX?=
 =?iso-8859-1?Q?AgsbchXfBqtxMABszjMlqLS7mAwXnCF48hgdmUpU/49YZWw6MpKtifiXS7?=
 =?iso-8859-1?Q?mcDj1a523XwT1dEJNIcBqSWz5EmkeI9LphvbGC9cUu3fIqYky8rBA0uBbn?=
 =?iso-8859-1?Q?6bXEj6diYdQkuLfeLb6I1D75QX3oBrwjWOMClq2jTbGlmEwYAx8VgZdgVE?=
 =?iso-8859-1?Q?KypbiEvs7WCXnCNTGWwDgZb8lqVOG0ID36g6s1Mo5TSsRZWkcD1j+IlAhC?=
 =?iso-8859-1?Q?ZiEoy0uCUcTjaf8NOWD9VO8e3UnR09dqNFdSiiKtOFdCRim6jE6uGvrmb0?=
 =?iso-8859-1?Q?Wx/CUF0PKqyKNRAOJrMNeM6WS277KD5S6NZ6EuiTpF9f1BxheG4JN0/HXF?=
 =?iso-8859-1?Q?EwJz8RMzUkgyU4vIED/nxyAn/mwZMWkhBFZfsXudx4gBmwVVmFPca8tyC6?=
 =?iso-8859-1?Q?OSf0KEPxq3P7byw6H5IVq+UyzFN38gfhw668ZaFtueS3mrlGIZbi6WQwdC?=
 =?iso-8859-1?Q?FTSmFqC4c2BUJyBzGaPXWESsZ32sgYlWgWJoxuMrKjhPgI1bTHg4yyHF0L?=
 =?iso-8859-1?Q?N8OoFofYpTULPiFyjc2DTjC2pxRv8ffE1eMikx6ByLG4vqWfyZd8dOhvAc?=
 =?iso-8859-1?Q?shyEgAA3N94lYEcSjpQ94zeY8xNOhGki/1CSkHoOvlL3GXWSCA9sGjffGZ?=
 =?iso-8859-1?Q?GZ1nHPpVB3MlPmIzQ0GwCDhXaSRNMTIinNj1Z3uPyHKxmzGZUXeZxhmieS?=
 =?iso-8859-1?Q?kr1VXFwH+LoTRg/nsnBOHJeZB5oOznLWREzIva5ohNXADQFdPZbIgZSp/F?=
 =?iso-8859-1?Q?wrLKCQMmka727TWC5mCzUhldOXljr7xtkS5vNEaEGjSAb8dG6oRh17IZd5?=
 =?iso-8859-1?Q?25nKe1FDMqAFQIkCAa/JUHgN1hi0bvANP5gLo6RH6z87TWf5slSGiiIbDL?=
 =?iso-8859-1?Q?uI9JXRDYU/B3t3Y2SbMG6F76HeAFvHJ7t4EZ2+k/TsYUO+BOzwvvnhpbZD?=
 =?iso-8859-1?Q?pBD43uvbwg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dkh2aoQvfCbdUqbMqR4vtL25ALxz5yzJG2sztgqGEyItcH34Sl+anG4HxXWZD6DNxa+E2536B6ZgiqNF4EkWgFKpUsFG067ZzbnF024VSckaR+tMA1XHfvL4MG955MBOOC6Vvaudvo4REdgsOqliDROKgUyIrF3ZMxhFDkQb41chddln43tGinCQrRDujMwltvQffqufjs2zlXVQUKXSOwiMJoCVUXBbslHi7LSJaolt2S9CgiHvFeaMbheHG+kh+VjigBGIEddopWUnrYNM3sFOjFxejv3Om2+jWqWDbToRhqRrOWfBYQPp7XFYmaHqtPlJL3t3SKqMIW6XlGsdfw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ef3be-c285-4b46-cd53-08def75621bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:43.8441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGoDCd0GUXXoucpKDiqLlfgCs0Bi79dcY8ESEc6KsxX70BHajnvoyE1M3Hq0o8GM5pHF5R5ARKNCuwZLf77zvbaV2844FnFjunGo+gNL0yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 33 ++++++++++++++++++++++++++++++---=0A=
 1 file changed, 30 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index d84f7f9cec..0a6e2fa829 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -57,6 +57,11 @@=0A=
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
@@ -670,6 +675,19 @@ static void crypt_be_add(uint8_t *ctr, size_t len, uin=
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
@@ -717,7 +735,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
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
@@ -758,7 +776,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
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
@@ -794,7 +812,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     /* Scatter the result back out, per the selected mode. */=0A=
-    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    dst_addr =3D crypt_get_addr(s, R_CRYPT_DEST, R_CRYPT_DEST_HI);=0A=
     if (sg_mode) {=0A=
         status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);=0A=
     } else {=0A=
@@ -958,6 +976,15 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
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

