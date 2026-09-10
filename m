Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD32AC79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tqr-0005Va-My; Wed, 09 Sep 2026 21:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqc-0005L4-VM; Wed, 09 Sep 2026 21:45:07 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqa-0004BU-TU; Wed, 09 Sep 2026 21:45:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOU88PBPoabaKc9UTjIvXsccBHeb5bdmL9U2t8zWXxHtiODVQ7hohygo/dXvoyMM6ACAKef9688RMGbAMtjMHNNulK3b3QbdezGsjFxfgfH9L9j3fSPo+a6ujBkI82RHzY5hPb0nL+XqxN15tXkiPrNyeHbvIrXaEP/Hx+YDwK6o9g/1F+Rappgapa0wFZVNJw1IDmouZYhEDwDeEW78wwteKfqdXhR3GZigNI+MuVIbLKBxAcR4PEg7ZuJfv3sXienOCc9BDJ1PkqB8/60SJuv8C8LVs8TMp1dN6eYDfyep6LkK2u93SjIi4ur5zI2P8VQ/t757boxmTVAGet93UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTdmA7LlZmTetazpST2j9g0Dux0I3RaCz80XmZlN+PE=;
 b=hzAZRwPfvxgSl81+EaxJOfzD9PFmu2tA1xNZ8anSNPhTXPSmUVFHAbobjjCZqVTeMjXtIg2MiLXU6wd2fywfZoBnK3BAPlTflTHBBu/QexDGNRR7J1/QYkxKvJLiFp7/ieonFu6TEz/n4HKqF5TolAoQoyyb84JiVL6Btv6dwVkfVKl8Jfp4h2bP7SQrNKnrJyvTgFGwa3xywY8hSXkJHW/lTRRqsOa4M6PGcBx1BPRQVFwbQv3PwfB19JuLgdvBrsVluiPqtWGOpfWiNErjiV1r2pejmf5fgCzVKJpm/LZ1Q6grLUBYu5vUsvmGJ2I1WuAwaxmIG726UPCyy4+hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTdmA7LlZmTetazpST2j9g0Dux0I3RaCz80XmZlN+PE=;
 b=IeOHrmaHP1Ts/MDWfhuShp468+8keLprXXWnwxDv9COIqn8oJr47p+hOYlO3YDpQ3dwU4d5oa8sm3vlo1bHE1D0OfD4hb2xDmH9nZINdylXXNsyZ8/jUu4c25UPya0kcI/mxhlbJMOvtIdmXWItbcrGzMMnJc/h+zKiQrCckYSqBAS2/AvDOSBUCuoL3fqqPIuUw+BLedMkU2R9D8d3lV8pnhIMhcqqtKHjozAUHsGcqdeMvfnArrgZIaY7k7BkoY44h8q/2uFfC9ca+vlL154EkW7VA8tsdynG0OaEytpzclL3Ei4y3WahT9jSliqNMKMj5VMuBo3EUieeZJAOwtQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6829.apcprd06.prod.outlook.com (2603:1096:101:1a7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:44:52 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:44:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 4/6] hw/display/aspeed-vga: Add the hardware overlay cursor
Thread-Topic: [PATCH v2 4/6] hw/display/aspeed-vga: Add the hardware overlay
 cursor
Thread-Index: AQHdQMX5R8iKOgx1nkaJXquCRn3SkA==
Date: Thu, 10 Sep 2026 01:44:52 +0000
Message-ID: <20260910014447.4110781-5-jamin_lin@aspeedtech.com>
References: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6829:EE_
x-ms-office365-filtering-correlation-id: 4e57e965-3bde-49a3-12c6-08df0edd1bc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: pgH+41h17iNKe+Zq1Q8SlYpTXaoDJJpVpp/TL8kmw2STAc+BoHF3f6TglT9ibFDPxdIL6Gutn4kkA1MWaytMY7XLQ+5FSMOwP9CL01gQM3XX4mxBf0iop27aaDpTcHL5XB6WLwcmbPsOp5eWzsLkyxl0HRF9uAIyiZsDgCpV3kcwOVx699ZTdOHfQwED7o/tD6lvcyv/Rfdy5YQVLDM8fkdgh1FvaHbIVSe2ZwUsSjA2kVtcp183IWjZqYx8mVNJkuePd05CnBrE/9beetPLfRGDdG9mlWPiCT6VLT5u3sIMIxw2b2yGq7LJJFt67e1mrNEv30msSOujDODbZ1/wqo0feb/bfskl5ak68mrRpn1MScGkjkzYYDd+AaXEUXK4kFnHZ0DpRzEmWCJ16cjYGYbn+Cy1RWIPdCUQrRygxTCJDQ6rLRpt3CVN+alR6lU4mM67287++NiXZRTQnXoHjVAHJaFBcJ6xOP6bqvIBK2WSEI14FeevhfNBxD2XPZsfXDYvFayJX6bv49DMlnsHSNIeeteJf/5bR28o/Xli7liWQntV5F9EHMUPki1uyKqDEttyppZBh6XMoEd/AwBMJt/roqu8ZqeBIf8lwhbiYRGSeaTcyNoRrJ1wWOYHUMTVVowuIPN7oL44VOQE6+10MY+P2pS4zGsT/TC7qlkp2KuMpziq/RTFeJ7QV/DJUbG7HQta+wg24JmnxmmfcLccML6LiTPzsQ5KrxipSfhWWFaE0miRiimg6UyTRc75z8AL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FiAf6SQvNI0wgPyLqzgnecS2nNaJJiiCIB1KERz8mdA2XkfRTsVTmGpmjc?=
 =?iso-8859-1?Q?MvH8mnPOGR4tUyHBf8YrdIGqNzekU6EcgPvSD1otwFVA16WaI7mpr3VLLq?=
 =?iso-8859-1?Q?gIn91TBcWyJ+5xARjwUBeNR5c7aWAONJJyA48DShqS039Ey765SkoeJXBY?=
 =?iso-8859-1?Q?ab5nDRp5OEjHP+j4CuVcd8SflK9QJbh0ES8o/lGuiMtuOCpXoaJK9TWrbT?=
 =?iso-8859-1?Q?EiUsJ59TemU1+pKaeXwsmKriNvOy2pP44f+imwvGt3aF5Wru8FTKwtfS7o?=
 =?iso-8859-1?Q?SYEBbBraP3ycthBMapLPMzYgUQmY1YXs2rJZHJAR1dr4IikCQ84anu7DST?=
 =?iso-8859-1?Q?JUJ5agbKT+bP4NsRFUZJkWP40FLuUlIpV1JWXTJqAAk57s9Uwflb5zHB7d?=
 =?iso-8859-1?Q?92C3D/uPy/XKYPTqB04mOX7jG1ODukcPY3zhyhTWUI9YSKw3bMcuqOM2bM?=
 =?iso-8859-1?Q?49KiLR0/r4O1VTjLy6gj9GZIO3EjkNRF1Us6PTDtJS1F+zTnk0N1+l/VCj?=
 =?iso-8859-1?Q?PwNQCoJ5C2pkKvM+i0uPYPbRho/gdeLRlHDqF9VJKVC0lBAwEmWbkEo5Ty?=
 =?iso-8859-1?Q?X9g+/c3DE98ZZnUyESTMtLmjChi3YY9LglfxRuQxK65aDl4X/BqvKcCs1s?=
 =?iso-8859-1?Q?HUrfqvAJua8Ssl23OF1WJ2JfAtfviv25MwDYavanMlt7ew/8d5TMGUGUFH?=
 =?iso-8859-1?Q?cO9lCf2PNfstV1qk5R5zZBrlKyDH4t76Wi2Cek2iM2Hlmvdx49r3nAf//C?=
 =?iso-8859-1?Q?Zud+CViu7zmc6qeociSzBTXL0dvRzWP19sw27Bs3OMlOMJvToQBJ3H5Ej/?=
 =?iso-8859-1?Q?k2NjmG2idKo4ln2W7fXCXP4OAgFnCaQDPU8rasyqoiJ/BMsrqZvfKNbJ/R?=
 =?iso-8859-1?Q?T4PDELrpw8BgW5a0cYMP6jRpWTpwWiAm8rIdkBtixcqeJJpBA4Y+GFMvgC?=
 =?iso-8859-1?Q?VsnBN3CBFxy13ghFu5TYhEWqAxICyz9eK2Up3y5MgMeEBOZHnyv6dT4a36?=
 =?iso-8859-1?Q?Ab7NcsUVJ4+9iPYLCGn6GRA/E/kExmxrUTjR2EknnPsCYGAnI46f4ySIst?=
 =?iso-8859-1?Q?/xfjIk44NnConSfPY6PVWT+TqmlxyIqyX5zu1zqFYCd0OqU7KRwhXSUptL?=
 =?iso-8859-1?Q?PMIGkkPCvyp01OFD9hp9VrgT02WljaWGr5ZAOUm8G4EhKZO9Jj/XzgEwS9?=
 =?iso-8859-1?Q?TttGfniWFZHF9QSI3gZox0SiYqRZLXUuRD8tEtJnIgvUpfZ6kD2dVmYD9r?=
 =?iso-8859-1?Q?np3oPEwUZ7m04x1dq1SuITak5Xkv9byyJZrUEeIj6ZIm/qE7H9Nv3v26pK?=
 =?iso-8859-1?Q?sfUEvGgXw5GGZC6apAYMiVrkThZmr+3odD4+bEmO/XYGtElDjSs7rguLwa?=
 =?iso-8859-1?Q?vX56YpYFB2BAndYRFlcfdiPH8f3A7EwIf9uBWszpmzAKe7r0h/trTPcB+D?=
 =?iso-8859-1?Q?O9eooYX+jBHmUIu9tdE/BeaIeaUQin4+NgACStmZScHmOkIk4hvto49K40?=
 =?iso-8859-1?Q?tEYoWp6wZIXmHOc2BxBIHlHHgSN1SRg9FqhWXQerym2kITAoiJLdCgGpuU?=
 =?iso-8859-1?Q?uDQwib6aQ67LDZeoqfuC1wA3athpNCwf5o1I2b5FpEvi1KT+RJGoCTDRZb?=
 =?iso-8859-1?Q?F9YSjZEtnNiAekj5O/UAZQ2lRyB06XMmGDoDa1cMTh325ee7lZSOHm8boJ?=
 =?iso-8859-1?Q?cL11Qcsufxvj08pQaPf4ym9aLZJskxU62F6ZosKedvCanjj7nANWatl3iT?=
 =?iso-8859-1?Q?dBRAMirkDfbFQlAdJoi8cl45aZeoYuIXLpoSRiaElmycziMqJuteCvRd6O?=
 =?iso-8859-1?Q?PZ9dY++dOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tgOY3kK3lawoyVz1lRVoHjS4SjqY3agQL8pgWVz+wtofkQAHwvW0PFaz+nT1ghh+qEHmnAy02SzuQm7wpUhooQJuFOyagb7i4TvKYaCk/1s73HGIO8XVk0Opt6+fCkkZy+7GG+zVXYFDt80xollJQMITcu2JaRRkzyhujXElz2CGD8+SxE6uX3YrY8aA9l/gd+P/hVYshjoQvVfIcsCiemlcKNqeA769Bm+V4YuWvJTtlLcNvBfePZ/GN1ReZhwG42DnmwnhxjXesP/r+ex6SpATzs/TojcGEc13+utsaVBD3sZfg0rryCU/Z7XlqD3sjs3cOFPHXwFhS9jm+XCeHA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e57e965-3bde-49a3-12c6-08df0edd1bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:44:52.5812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiVdlBWUZ76yPFKxS3Ht7WvIm7t5NKOMM2lPHGfAJWEnlEnyEKR4WmiK3qx+Lb0fT0FMc0weGnmrdGYavGfuGp0oPG8FaZfmE/haycPjn+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6829
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

The display controller draws a 64x64 cursor over the picture. CRC2 to=0A=
CRCB hold its position, the address of its bitmap in the framebuffer,=0A=
the offsets into that bitmap and the format.=0A=
=0A=
Draw it through the common code's cursor callbacks. The position cannot=0A=
be negative, so the offsets say how many rows and columns to skip when=0A=
the cursor runs off the top or the left of the screen.=0A=
=0A=
CRCB selects the format. Both are modelled: ARGB4444, and the one the=0A=
datasheet calls 2 bpp, which is also two bytes per pixel but carries an=0A=
AND and an XOR mask in the top two bits instead of an alpha.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/display/aspeed-vga.h |   2 +=0A=
 hw/display/aspeed-vga.c | 194 ++++++++++++++++++++++++++++++++++++++++=0A=
 2 files changed, 196 insertions(+)=0A=
=0A=
diff --git a/hw/display/aspeed-vga.h b/hw/display/aspeed-vga.h=0A=
index 4b0315f699..55dcc57108 100644=0A=
--- a/hw/display/aspeed-vga.h=0A=
+++ b/hw/display/aspeed-vga.h=0A=
@@ -33,6 +33,8 @@ struct AspeedVGAState {=0A=
     MemoryRegion ioport;=0A=
 =0A=
     uint8_t vgaer;=0A=
+    uint32_t last_cursor_y;=0A=
+    bool last_cursor_on;=0A=
 =0A=
     /* saved standard VGA handlers, used while the extended mode is off */=
=0A=
     int (*std_get_bpp)(VGACommonState *s);=0A=
diff --git a/hw/display/aspeed-vga.c b/hw/display/aspeed-vga.c=0A=
index bf74a0c8ce..e40d503910 100644=0A=
--- a/hw/display/aspeed-vga.c=0A=
+++ b/hw/display/aspeed-vga.c=0A=
@@ -26,6 +26,7 @@=0A=
 #include "qemu/module.h"=0A=
 #include "qom/object.h"=0A=
 #include "ui/console.h"=0A=
+#include "ui/pixel_ops.h"=0A=
 #include "trace.h"=0A=
 #include "aspeed-vga.h"=0A=
 #include "vga_int.h"=0A=
@@ -69,11 +70,40 @@ REG8(AST_CR_OFFSET_HI, 0xb0)=0A=
 REG8(AST_CR_POWER_MGMT, 0xb6)=0A=
     FIELD(AST_CR_POWER_MGMT, VSYNC_OFF, 1, 1)=0A=
     FIELD(AST_CR_POWER_MGMT, HSYNC_OFF, 0, 1)=0A=
+REG8(AST_CR_CURSOR_XOFF, 0xc2)=0A=
+    FIELD(AST_CR_CURSOR_XOFF, OFFSET, 0, 6)=0A=
+REG8(AST_CR_CURSOR_YOFF, 0xc3)=0A=
+    FIELD(AST_CR_CURSOR_YOFF, OFFSET, 0, 6)=0A=
+REG8(AST_CR_CURSOR_X_LO, 0xc4)=0A=
+REG8(AST_CR_CURSOR_X_HI, 0xc5)=0A=
+    FIELD(AST_CR_CURSOR_X_HI, X, 0, 5)=0A=
+REG8(AST_CR_CURSOR_Y_LO, 0xc6)=0A=
+REG8(AST_CR_CURSOR_Y_HI, 0xc7)=0A=
+    FIELD(AST_CR_CURSOR_Y_HI, Y, 0, 4)=0A=
+REG8(AST_CR_CURSOR_ADDR0, 0xc8)=0A=
+    FIELD(AST_CR_CURSOR_ADDR0, ADDR, 1, 7)=0A=
+REG8(AST_CR_CURSOR_ADDR1, 0xc9)=0A=
+REG8(AST_CR_CURSOR_ADDR2, 0xca)=0A=
+    FIELD(AST_CR_CURSOR_ADDR2, ADDR, 0, 7)=0A=
+REG8(AST_CR_CURSOR_CTRL, 0xcb)=0A=
+    FIELD(AST_CR_CURSOR_CTRL, ENABLE, 1, 1)=0A=
+    FIELD(AST_CR_CURSOR_CTRL, FORMAT_ARGB4444, 0, 1)=0A=
 REG8(AST_CR_SOC_SCRATCH0, 0xd0)=0A=
     FIELD(AST_CR_SOC_SCRATCH0, VRAM_INIT_BY_BMC, 7, 1)=0A=
     FIELD(AST_CR_SOC_SCRATCH0, VRAM_INIT_READY, 6, 1)=0A=
     FIELD(AST_CR_SOC_SCRATCH0, IKVM_WIDESCREEN, 0, 1)=0A=
 =0A=
+/*=0A=
+ * The cursor bitmap is always 64x64 and lives in the framebuffer, two byt=
es=0A=
+ * per pixel in both formats.=0A=
+ */=0A=
+#define ASPEED_VGA_CURSOR_SIDE  64=0A=
+#define ASPEED_VGA_CURSOR_PITCH (ASPEED_VGA_CURSOR_SIDE * 2)=0A=
+#define ASPEED_VGA_CURSOR_SIZE  (ASPEED_VGA_CURSOR_SIDE * \=0A=
+                                 ASPEED_VGA_CURSOR_PITCH)=0A=
+#define CURSOR_MONO_AND BIT(15)=0A=
+#define CURSOR_MONO_XOR BIT(14)=0A=
+=0A=
 /*=0A=
  * The ast driver writes a color format to CRA3 when it switches to the=0A=
  * extended mode. Until then CRA3 is zero and the device behaves like a=0A=
@@ -176,10 +206,14 @@ static void aspeed_vga_get_params(VGACommonState *vga=
,=0A=
     AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
 =0A=
     if (!aspeed_vga_ext_enabled(s)) {=0A=
+        vga->force_shadow =3D false;=0A=
         s->std_get_params(vga, params);=0A=
         return;=0A=
     }=0A=
 =0A=
+    vga->force_shadow =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_CTRL],=0A=
+                                  AST_CR_CURSOR_CTRL, ENABLE);=0A=
+=0A=
     /*=0A=
      * GR05 bit 6 selects the mode 13 shift mode, which is packed pixel li=
ke=0A=
      * the extended modes. Without it the common code picks its planar=0A=
@@ -208,6 +242,164 @@ static void aspeed_vga_get_params(VGACommonState *vga=
,=0A=
     params->hpel_split =3D false;=0A=
 }=0A=
 =0A=
+static bool aspeed_vga_cursor_geometry(AspeedVGAState *s, uint32_t *x,=0A=
+                                       uint32_t *y, uint32_t *xoff,=0A=
+                                       uint32_t *yoff, uint32_t *addr)=0A=
+{=0A=
+    VGACommonState *vga =3D &s->vga;=0A=
+    bool is_cursor_enable;=0A=
+=0A=
+    is_cursor_enable =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_CTRL],=0A=
+                                 AST_CR_CURSOR_CTRL, ENABLE);=0A=
+=0A=
+    if (!aspeed_vga_ext_enabled(s) || !is_cursor_enable) {=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    *x =3D vga->cr[R_AST_CR_CURSOR_X_LO] |=0A=
+         (FIELD_EX8(vga->cr[R_AST_CR_CURSOR_X_HI], AST_CR_CURSOR_X_HI, X) =
<< 8);=0A=
+    *y =3D vga->cr[R_AST_CR_CURSOR_Y_LO] |=0A=
+         (FIELD_EX8(vga->cr[R_AST_CR_CURSOR_Y_HI], AST_CR_CURSOR_Y_HI, Y) =
<< 8);=0A=
+    *xoff =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_XOFF],=0A=
+                      AST_CR_CURSOR_XOFF, OFFSET);=0A=
+    *yoff =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_YOFF],=0A=
+                      AST_CR_CURSOR_YOFF, OFFSET);=0A=
+    /*=0A=
+     * cursor pattern address, D[10:4] in CRC8, D[18:11] in CRC9 and=0A=
+     * D[25:19] in CRCA. D[3:0] are not stored, so it is 16 byte aligned.=
=0A=
+     */=0A=
+    *addr =3D ((uint32_t)FIELD_EX8(vga->cr[R_AST_CR_CURSOR_ADDR0],=0A=
+                                 AST_CR_CURSOR_ADDR0, ADDR) << 4) |=0A=
+            ((uint32_t)vga->cr[R_AST_CR_CURSOR_ADDR1] << 11) |=0A=
+            ((uint32_t)FIELD_EX8(vga->cr[R_AST_CR_CURSOR_ADDR2],=0A=
+                                 AST_CR_CURSOR_ADDR2, ADDR) << 19);=0A=
+=0A=
+    return *addr + ASPEED_VGA_CURSOR_SIZE <=3D vga->vram_size;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_cursor_invalidate(VGACommonState *vga)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+    uint32_t addr =3D 0;=0A=
+    uint32_t xoff =3D 0;=0A=
+    uint32_t yoff =3D 0;=0A=
+    uint32_t x =3D 0;=0A=
+    uint32_t y =3D 0;=0A=
+    bool on;=0A=
+=0A=
+    on =3D aspeed_vga_cursor_geometry(s, &x, &y, &xoff, &yoff, &addr);=0A=
+=0A=
+    /*=0A=
+     * Moving the cursor dirties no VRAM, so repaint both bands here: wher=
e=0A=
+     * it was, to erase it, and where it is now, to draw it.=0A=
+     */=0A=
+    if (s->last_cursor_on) {=0A=
+        vga_invalidate_scanlines(vga, s->last_cursor_y,=0A=
+                                 s->last_cursor_y + ASPEED_VGA_CURSOR_SIDE=
);=0A=
+    }=0A=
+    if (on) {=0A=
+        vga_invalidate_scanlines(vga, y, y + ASPEED_VGA_CURSOR_SIDE);=0A=
+    }=0A=
+=0A=
+    s->last_cursor_on =3D on;=0A=
+    s->last_cursor_y =3D on ? y : 0;=0A=
+}=0A=
+=0A=
+/* Source-over blend of one 8 bit color channel with a 4 bit alpha */=0A=
+static uint32_t aspeed_vga_blend_channel(uint32_t under, uint32_t over,=0A=
+                                         uint32_t alpha)=0A=
+{=0A=
+    return (under * (15 - alpha) + over * alpha) / 15;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_cursor_draw_line(VGACommonState *vga, uint8_t *d,=
=0A=
+                                        int scr_y)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+    uint32_t *dst =3D (uint32_t *)d;=0A=
+    const uint8_t *row;=0A=
+    uint32_t screen_x;=0A=
+    uint32_t under;=0A=
+    uint32_t out_r;=0A=
+    uint32_t out_g;=0A=
+    uint32_t out_b;=0A=
+    uint32_t addr;=0A=
+    uint32_t xoff;=0A=
+    uint32_t yoff;=0A=
+    uint32_t cols;=0A=
+    uint32_t col;=0A=
+    uint16_t px;=0A=
+    uint32_t x;=0A=
+    uint32_t y;=0A=
+    uint32_t a;=0A=
+    uint32_t r;=0A=
+    uint32_t g;=0A=
+    uint32_t b;=0A=
+    bool argb;=0A=
+=0A=
+    /* nothing to draw: the cursor is off or outside VRAM */=0A=
+    if (!aspeed_vga_cursor_geometry(s, &x, &y, &xoff, &yoff, &addr)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* this scan line is above or below the cursor */=0A=
+    if (scr_y < y || scr_y >=3D y + (ASPEED_VGA_CURSOR_SIDE - yoff)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* the cursor is off the right edge of the screen */=0A=
+    if (x >=3D vga->last_scr_width) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* xoff hides the leftmost columns of the bitmap */=0A=
+    cols =3D ASPEED_VGA_CURSOR_SIDE - xoff;=0A=
+=0A=
+    /* the screen edge hides the rightmost columns */=0A=
+    if (x + cols > vga->last_scr_width) {=0A=
+        cols =3D vga->last_scr_width - x;=0A=
+    }=0A=
+=0A=
+    argb =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_CTRL],=0A=
+                     AST_CR_CURSOR_CTRL, FORMAT_ARGB4444);=0A=
+=0A=
+    /* the bitmap row for this scan line, past the rows yoff hides */=0A=
+    row =3D vga->vram_ptr + addr +=0A=
+          (uint64_t)(yoff + scr_y - y) * ASPEED_VGA_CURSOR_PITCH;=0A=
+=0A=
+    for (col =3D 0; col < cols; col++) {=0A=
+        screen_x =3D x + col;=0A=
+        px =3D lduw_le_p(row + (xoff + col) * 2);=0A=
+        r =3D ((px >> 8) & 0xf) * 0x11;=0A=
+        g =3D ((px >> 4) & 0xf) * 0x11;=0A=
+        b =3D (px & 0xf) * 0x11;=0A=
+=0A=
+        if (!argb) {=0A=
+            /*=0A=
+             * AND clear draws the color. AND set leaves the pixel alone,=
=0A=
+             * or inverts it when XOR is set.=0A=
+             */=0A=
+            if (!(px & CURSOR_MONO_AND)) {=0A=
+                dst[screen_x] =3D rgb_to_pixel32(r, g, b);=0A=
+            } else if (px & CURSOR_MONO_XOR) {=0A=
+                dst[screen_x] =3D ~dst[screen_x] & 0xffffff;=0A=
+            }=0A=
+            continue;=0A=
+        }=0A=
+=0A=
+        a =3D px >> 12;=0A=
+        if (!a) {=0A=
+            continue;=0A=
+        }=0A=
+=0A=
+        under =3D dst[screen_x];=0A=
+        out_r =3D aspeed_vga_blend_channel((under >> 16) & 0xff, r, a);=0A=
+        out_g =3D aspeed_vga_blend_channel((under >> 8) & 0xff, g, a);=0A=
+        out_b =3D aspeed_vga_blend_channel(under & 0xff, b, a);=0A=
+        dst[screen_x] =3D rgb_to_pixel32(out_r, out_g, out_b);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint8_t aspeed_vga_vgamem_size_reg(uint32_t vram_size_mb)=0A=
 {=0A=
     switch (vram_size_mb) {=0A=
@@ -384,6 +576,8 @@ static void aspeed_vga_realize(PCIDevice *dev, Error **=
errp)=0A=
     vga->get_params =3D aspeed_vga_get_params;=0A=
     vga->get_resolution =3D aspeed_vga_get_resolution;=0A=
     vga->is_blanked =3D aspeed_vga_is_blanked;=0A=
+    vga->cursor_invalidate =3D aspeed_vga_cursor_invalidate;=0A=
+    vga->cursor_draw_line =3D aspeed_vga_cursor_draw_line;=0A=
     vga->big_endian_fb =3D false;=0A=
 =0A=
     vga->con =3D qemu_graphic_console_create(DEVICE(dev), 0, vga->hw_ops, =
vga);=0A=
-- =0A=
2.53.0=0A=

