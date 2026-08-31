Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42439C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0s1K-0005cZ-Lz; Sun, 30 Aug 2026 22:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s1I-0005Yv-9o; Sun, 30 Aug 2026 22:45:12 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s1G-00028Q-Ln; Sun, 30 Aug 2026 22:45:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q14nUKWN6RGqYGm4aL4EsYfaKJuefYtnsYuLr1lxxXFaBtmIWkxAHiuUsk/BBJzvnrg8nr/BaAIIheFpWGEiQ7TU5uK+r88b3UnP/5yaEhspWClMoR8QyFxu8dUc6NgraApPJM3EABnqMfUv+8VqjPjTTmrEicyuN5cq6wjwTndUGgb09C0kdU8SasbmIFdIYkdaWT/N+0M60a5ASuXX3U/RKdz/lxibjfovTILU8AoTX29lLC3L9rP9yixbYMvLhobwee5uSbLRw0eDag+DpnD6kujPQokzLT63VQVuf42n4lAKll9LdU6yWRsKBxDUyM+7rwnYi5E4S/K4bbuuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq3XZmaIV0NmtgtY6zbCD5Y6Sj4yPpLzryMe75TU5bo=;
 b=draGxz5+FCwM3KcylkLclPv12PBCwheT61vxWbKvfULGlSXysxcsCRf8HJMNtCuUGVbZRvrddYTJfy8GAPHVSLpuVKlhumEy83pUgbvYJzSu+ldXh19CqC9+afn79K7+DTuIFfLLmpf4WsxzCnoVg9AKt94jflHwVZkPIH3sj6eMt+8bJnGP2xcj+rBxfydCbmDmoQvfjgwcrIogykP0rDO41NNPzKMzCnSLryzRZ0SHTRs8D/DDJ0TpVXnEbUpL1Raw73Tj04RlXDyF5R81W+g64kFMV4Ehi2YPJmdb7FpTWnBRIXN8g9ftNl6OaGBYccjfH+v/eIIa3yp4EHRCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq3XZmaIV0NmtgtY6zbCD5Y6Sj4yPpLzryMe75TU5bo=;
 b=fQPfrXLwcdmIWDTF7lzdItAKqxTIJ87gczmGhUvaflQtLFEOu1dcypB79RW4APcsIidCmqzcKb2sPsArCd4IrPiBO+mdUd72gC7T/HSnawLzL4giM1D6/LSxAxi1w5NzvIs2CXTTK7P6jdrR/+QYM9kCP9dxBkL60vWkH4UqBDRBzERJf9af3q3H8SKUz06Vcv4KZD16cgyAN3lq9brtxDmb7LL2bVsitIJdyZDEk3azP9igzZY9rUfSj8uI99FbBbiWh9K9erZLYThoJJBI0Acls/0CF/cwHFmNij3ozCWb/e+HAf6hKSW7HPblC3xhDrDBoaqu7fYS3sS2q7sbFw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR0601MB5822.apcprd06.prod.outlook.com (2603:1096:820:b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 02:44:55 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 02:44:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 2/4] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Topic: [PATCH v3 2/4] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Index: AQHdOPK0nt/9SVz/K0ii7d7/w8+4NA==
Date: Mon, 31 Aug 2026 02:44:54 +0000
Message-ID: <20260831024450.27178-3-jamin_lin@aspeedtech.com>
References: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR0601MB5822:EE_
x-ms-office365-filtering-correlation-id: 0c2af47b-ce62-4115-e628-08df0709d6c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|366016|376014|18002099003|22082099003|56012099006|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: AAfD4BlB8v5pD0x3HyEaOWk7MAiipQQskH3EXagknU18rAhuySbdyiS4a7dOZe8D5bs4VzL7NEhmj4rdpze79fxbuxploLsu9tVUFwoIxEJ1bsQjYTMr1HjdlCMeL/PkjakpdFRzryA9FcMcZW/234pzRa9TZ9yCErYKCx/26e4cWslxhvhpSxHs/1Xv3Fmi4YcHIAscJs9FmnvWiPNd3ncbuFPrmDLFE3CexRaXvIYAesV/NvgPy66gZYR7KNRMDZ4nx+qebopQ0c6ry6P+aOYBEr/VFrD5w++tXFuqVz9nF89zE1v2Yw1eRREkhvdDozaONr+3DW2hkk0LkldddkJ5Rvceqs5x9rppHoYkoRYvdQ/RJpdXq4Xh6dg01N/2sSWTzqzP7EUZbr5j1E49GUTvBo+NucSrHBCfhQQKfqiY2gek6WCw8xGQjrDWdKPZlgZG8KHuiKjP5EWG35rgPkuqXan4Mhz+Vg2kt9P2rV+7m6GCssgPPGx8xdVcOCcxJeZhCILACaw6k/exN0CrLTngHqhejb8Ucvsamg7pyJ9Efft8ex2pwqJOXuBJVQe6juX7YGtmji4HSVTjDuCj9RJhdUprA/0blIgsQuge4VqW5W+ormmPMeJEi7vdVDVUhV3yiVhsGCoECmqMcS9SE+Xl3dQAsQRZ5i1F+FbByrq9Lt6paL8640QrAnJpZ0ZQvbMGxihWG9d8UM8QQEEVJ6HvVLIjnuBwxwQF750tJvQvr7WfL2pTAc6MQ7m+mxwZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JayZM4un65AkR0tK1XJt4YzAemWeSpUCj74szCgfWaxoGSjM2e1dw0L/rC?=
 =?iso-8859-1?Q?9cBy6D1KPa3WFJeuoQvEsmMRPcz3YfNVFRTX8X3lwZ6rMaQcbp7bIroTdO?=
 =?iso-8859-1?Q?fSo7/IrPezi2ex8/Ra3ya5YKETwcR1DBCY0G9EOmLeFwL9gZZVWajvdb40?=
 =?iso-8859-1?Q?r4iaGPiqJPUC+AjUAf+CudoYb5M0sHP/RW+8/dRGRL8GVpyG/kBB2E/SH/?=
 =?iso-8859-1?Q?H9HjbayNOenG6/r/vybxwTAoyeCiCEjHuDhia7SjxyzM0xIB7JfIxYeyT6?=
 =?iso-8859-1?Q?ffcNcmQecvoOiUDiGpD1gL79A5/t+RVfWAUL4W2/BLsUSk1o+WeDVJzK8l?=
 =?iso-8859-1?Q?0OYN6KaRX4l2KoL6ZpyEE3cy/76hTZ2FEFqKfn9MgeutrSJ48cX9bYBNIz?=
 =?iso-8859-1?Q?4nkrURsP0fRys6mZUJWTpzdCyiVE7TftzXxzR9GseDKaZx3mQOkU+oa64n?=
 =?iso-8859-1?Q?olQJkgU58AUtj3FeO3uprcwfltZeAr7BVlZqmRLtF7TG6NnqcSAVJF9H+n?=
 =?iso-8859-1?Q?5IVdenGz41BGSwt8D7uAIC3ygXuAdA+9GVpgFi2CQXzq8n9g81L31Gn++R?=
 =?iso-8859-1?Q?iOpHl9wIYjVHvMI7LXeka9cnCyRAG5W0c5F/ByxiZl/5Efbqjn/fEhsPnr?=
 =?iso-8859-1?Q?WpaUgqwuZAAE2CxG+s65ZAlvnMIFK+OptehoVkVuefJAW1lN5a96prpbt7?=
 =?iso-8859-1?Q?gkJOTTrsetL3DcIbHszBR8Axv9OEB9xgilSTQnoWfQBQmqF7rlLD6kpjzm?=
 =?iso-8859-1?Q?Os2AoCsouRoyjD9yjH8H4H/SBpahSwJRT9sRjErcFeFewzK+qkvvTSuAdR?=
 =?iso-8859-1?Q?AZG52A7jPZflP1vmcnxWB1zznPrNOiBazsxPfpAoVjLYfRtg4xqxsOWX/Z?=
 =?iso-8859-1?Q?zUuNXoR1MhD2+gzfS4yeet4F9Q13xqjpcRyj8iHtLIMhoABfOjItNd/E6k?=
 =?iso-8859-1?Q?GYvm2tQCyErYJGnOxO7oS50Rca1YSLs2EDK0h9Mq2IUQvWw9gmxcoGXfLo?=
 =?iso-8859-1?Q?a+8OQ20iBUDHUDheKpXZoty+VNPpV54Z/3pim4SuIh+FJfUG/ACqQhSE5h?=
 =?iso-8859-1?Q?a4sB4aCg4q9j5dXZffqH1VgBT21q5WALBtCZ4ohB6/apBmfZgwC+m4v3Q8?=
 =?iso-8859-1?Q?dUh1kawikvJfKVONJ6L0xWmQacDP5sd8RJ7BfATYKseGsfXAjckDZN5W37?=
 =?iso-8859-1?Q?WhMeXVLthzQHzSrunvYCdjNVPcQsLqu4RemSj/ilnUDlThmKxrM6pUwOmu?=
 =?iso-8859-1?Q?RpqWtetIXcOMZFZr0+qqOIaiPpDTNkq5x/yRltl+X+0tC5oFb76RR4YrcQ?=
 =?iso-8859-1?Q?bCtAl5cXaaR5qMIdZIvyowTKtmu79szzqV8n70d+LDLsmtINIFh10X49EJ?=
 =?iso-8859-1?Q?mxnFHJp1vS4mRhuCewAyGZrtpAqkEHRHmdbNg8jiKb/hB5ZX4MYx6zsCr5?=
 =?iso-8859-1?Q?zJQjN3Aa16LENnPHyoHd6Zw5OCUVz0/63ETnprFQgkLmCsiKsHAKpIqfU4?=
 =?iso-8859-1?Q?h/itDhaooArzilDKU/wRRtqHgMIfPLAWwlGiYnClM6yGPSMhJHJKxBaDp0?=
 =?iso-8859-1?Q?CZaFjV1YI/8q4p8qGpKe4bBeLXfUjocVkaCMsUYTY0YjrRDQvOC3001jqz?=
 =?iso-8859-1?Q?1UKVlsbrqJ9Rxd0sprWKBYXpA2sxDmwUQH2BD9EAqdLMf2wZZezVgA8vl0?=
 =?iso-8859-1?Q?N8G5MA17uptQPHUw5Z5XF/5HslJYkkF57LpCrAWqlyEtqS+pNF+BjZptUL?=
 =?iso-8859-1?Q?bVgm4bFR5P1cVNXJg5ypW5QOSk4VSIEn5L+QzPZT7Tcuhc8ePLx4UuOJGg?=
 =?iso-8859-1?Q?lmxBBGhuuw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tmZdZcJ+7d8DNBcdMJOKx6Gd9k6vf/q//tsgrJ15BjinJsJKoGN35RLwkJwIWqP/+EGEL8x6NQX4APiLlihCq8oPLxcBx+NwAftR/bH0yyY4b8zJokGgBG1ZRu4PUAWkcJf+P47cX8iPxoOhZGem6pnZ3gYPD2pToINBNsdLK4K7c6UpfvaQ8x7zFmpUgKqCSlfxr4JYKVLkeZX3hxm+m0hYgf+UwL5D1wUuDSeIrVMly+CplEmNHRxBBTU07ixBJlVCXCDXFnchnMDWRQAPX10nZZYoRUBBmmOiDtpxfPq1XHIGBXioIvY2u5JOa7jizA3Jvj9gATtOYmoZll7L8Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2af47b-ce62-4115-e628-08df0709d6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 02:44:54.9110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwfLLboXznDPf9oVEA0wDkPYbCT89uJHI+aPx/HxFyK1VwDEH27dxVSDveQHY15l1tcy+sm+PLTUOw+dFkQFzIwvsPJ2y49CRJV5Wgu5afY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5822
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

Reuse the existing SRAM array convention on AspeedSoCState to add the=0A=
64 KiB ACRY SRAM region to the AST2600 at its real-silicon address=0A=
(0x1e710000-0x1e71ffff).=0A=
=0A=
Wrap the RAM in a container mapped at offset 0 so the ACRY engine wired=0A=
up in a later patch can address the SRAM by relative offset without the=0A=
device model knowing its mapping address.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@kaod.org>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  1 +=0A=
 hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++=0A=
 2 files changed, 18 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index cd68c7f1ca..46e7854727 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -69,6 +69,7 @@ struct AspeedSoCState {=0A=
     MemoryRegion *dram_mr;=0A=
     MemoryRegion dram_container;=0A=
     MemoryRegion sram[ASPEED_SRAM_NUM];=0A=
+    MemoryRegion sram_container[ASPEED_SRAM_NUM];=0A=
     MemoryRegion spi_boot_container;=0A=
     MemoryRegion spi_boot;=0A=
     MemoryRegion vbootrom;=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..f23a51c8a4 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -8,6 +8,7 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
 #include "hw/misc/unimp.h"=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
@@ -24,6 +25,7 @@=0A=
 static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x10000000,=0A=
+    [ASPEED_DEV_SRAM1]     =3D 0x1E710000, /* ACRY SRAM */=0A=
     [ASPEED_DEV_DPMCU]     =3D 0x18000000,=0A=
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */=0A=
     [ASPEED_DEV_IOMEM]     =3D 0x1E600000,=0A=
@@ -361,6 +363,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev=
, Error **errp)=0A=
     AspeedSoCState *s =3D ASPEED_SOC(dev);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
     qemu_irq irq;=0A=
+    g_autofree char *sram1_name =3D NULL;=0A=
     g_autofree char *sram_name =3D NULL;=0A=
     int uart;=0A=
 =0A=
@@ -444,6 +447,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     memory_region_add_subregion(s->memory,=0A=
                                 sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0])=
;=0A=
 =0A=
+    /* ACRY SRAM */=0A=
+    sram1_name =3D g_strdup_printf("aspeed.acry.sram.%d",=0A=
+                                 CPU(&a->cpu[0])->cpu_index);=0A=
+    if (!memory_region_init_ram(&s->sram[1], OBJECT(s), sram1_name,=0A=
+                                sc->sram_size[1], errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_init(&s->sram_container[1], OBJECT(s),=0A=
+                       "aspeed.acry.sram-container", sc->sram_size[1]);=0A=
+    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
+                                &s->sram_container[1]);=0A=
+=0A=
     /* DPMCU */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
                                   "aspeed.dpmcu",=0A=
@@ -765,6 +781,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *=
oc, const void *data)=0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2600_A3_SILICON_REV;=0A=
     sc->sram_size[0] =3D 0x16400;=0A=
+    sc->sram_size[1] =3D 64 * KiB; /* ACRY SRAM */=0A=
     sc->spis_num     =3D 2;=0A=
     sc->ehcis_num    =3D 2;=0A=
     sc->wdts_num     =3D 4;=0A=
-- =0A=
2.53.0=0A=

