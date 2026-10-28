Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACD606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=jGyOGkTH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtSX-0004L1-Lu; Tue, 27 Oct 2026 22:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSU-0004Jy-W4; Tue, 27 Oct 2026 22:32:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSS-00082E-KV; Tue, 27 Oct 2026 22:32:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjQP9P9xc0DwfqBEyo27Nqv7iyF8B7/B/cjyH1TJTRh2MqtN0PWDBj24VafLVEf+0ZIIKBcVvVWe/X7bgheFbvIsc77g7NKv8ca+iCrbfRhYsWo70IFXAte6uUi2l8wVn+wGN6WTg3RXvc/ow759F9dUxiSxTZcDCF1reDTPkhiAtIqX49AAkZAN5g2J2BrUP6xFfGeTfcITjk6fxTzPkwqWdkToKRdKKiv8CtrHVEWqAbmiC5Yhtt33bUfXnjy3t7gxic26OOk4vta2T0XMNlFdXHWbm3HQ653M112wmDgPqbTaujGmkGtJk9RawUGPVA5n0tjuXNPR13O8WRNW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYJDZ7gK/D9WcCW9rhczK+VHbhP0V3qozQjMQoCsACc=;
 b=oNsRTpAxE/MKNctv7x43Gj54b2JBtfg+KjTaQ2aBCeaAX3+d5bxQUaJGBr+qMIlnxE4QYFAs96lzbR+JUqLO+jsA58ed/oMIYXgIAUDFOumIe1A6gs8cCmp/Hccn8DQ1BJi3mFOQ4k3K2d6GCHEwjhptHAzERYJ5vKEu8xkxfB4pVyZhLmR6GQEpdFFg8hdkbtw2FS5+UjzS2bSCyl184bic1AsIFT8vs3bREE5WaUPYT4+fSuVMqwiRhkmX4t5BiaZsGs7gqJm/tU0X/f79INSzQ9/iYrc4u9+N09juVAuwommM1gTXtgiw3Ip1aRb/DasKT5gRVxCLgma/pC1jbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYJDZ7gK/D9WcCW9rhczK+VHbhP0V3qozQjMQoCsACc=;
 b=jGyOGkTHIqYfaHKlPG88j7FS6dR1lq6LSeqv/dz9xX8dM5BPsQaA4DV/Iqr+6aGYW+IZ8o+VL+mgBlP7Qpn/govrx7ZtV1BDJcY17H9FKV0ABusjOSGOb8zoumLspN2vgcf/OJdTQLvjlTIeVNSI+jgzmb7lvSwyRe83qhUNsobwR4VJCiYKab63oI5UpP3mDHz+zsIdn8ybrVvcYT0We91ZXKgrYqbGJNpCJTpCT9tAtCPJeKw8JVG8XQ1jC0x6RGrCPoiOcQV9ST4n6DpXhFcAWzvLB8EaU95bWUBXcgP973UNIBRiiVJGHAqVL/JqNjHC/EhW+68PRnYwZ1O09w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:31:56 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:31:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 01/13] hw/ssi/aspeed_smc: Fix AST2700 segment end address
 decoding
Thread-Topic: [PATCH v2 01/13] hw/ssi/aspeed_smc: Fix AST2700 segment end
 address decoding
Thread-Index: AQHdZoR/VWedCOvGYEG90IqEFkJ3GQ==
Date: Wed, 28 Oct 2026 02:31:56 +0000
Message-ID: <20261028023154.48395-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: cf3bc4d2-1a0c-4a46-34b7-08df349ba280
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|921020|56012099006|261026121527099003|261022115727099003|261021121427099003|261021123027099003|10067099003|261022075727099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: 6j3uMeYakSOZab/HanCsjlo3H1OKpW/lGM48uIBlfdwAWnEWzzIuISUkHkeDGmmgs5I9hYrLFIA+Usoe6aVFM50JuCXle4g6KjX2dbAwrXiRvMSktnJhVgvlOra/e1WkBnV5TIP5Y53if+x4En0+3HS8Z0dwfaLv/QdqiT4FVfwDAO+m0VvpjWKufe7l8FFDNWHJ9vOXqnFpyHLWQh484SZnBbHQuFeN6K+JobyXVU4FcAbuwJ5/zdyvGQLOWft/RIo875/nJG42ymD+50uReb3GpCpJxsZaHrlJt5n4UaHhVOkP7P51W+npi7dzohwoakp/LnD3g7m+E7y7sJeIQ5VvKYoYQ7FQHALkTRQWuNhXqc4Un3XjNT4cFo3lJ6MhsM7MRMALobZ9CxraJY+D4D/HqfKsclRnUmnHyLysg3HeKooiQLisTbxq1G/vdU4tSZ1ly66nR5zSJ4kQQZeZ9rCZXJIncYvr087M7Vlq9r9yjD1EXrUIFadALJjayz66/1GA53ZoAWeYeMuoWaGchkw7k/MDUvzCj7CVbB16QSGTLi1HrG1FCMIMIGSZw9jBPNqXINrjPm3cbq0WGiMbBoX5zldNdbBrwK7eRDB5INueaCn+8oXnhwCf9y7MHxucmWNsKt8CD39b9/g/lpKi8gYLj3wwEbGvJExFbqFpuDgkWSC2xOXQiyVj8Am47iyqpf0Fn3yBkmhd+UK2zIU1d00zbmMN6Ie/5fiqTOZtoVN8DUBVzjZgo8x/MtANWFJQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(921020)(56012099006)(261026121527099003)(261022115727099003)(261021121427099003)(261021123027099003)(10067099003)(261022075727099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GBRtoUsWdvflw7IMGQm+CdhWUt3dwRA6xxJhzDwe1bKfE+xk/RYCHaXCzn?=
 =?iso-8859-1?Q?R9TbUNU0MmyuUVJ/2PZr7Qw4U1jdNzQG1SFKIWNuTYe2FRyGgzfJi7a0J+?=
 =?iso-8859-1?Q?M5jkNVbjYlD8fNFm7tTbtsw3JyYlaCSQsnqdZlRcS7KesyGxg/fUwh6a3J?=
 =?iso-8859-1?Q?Qr0CiIzlTfeMMdrT6W5bki2FYpq4JQR+ppMIg4csk9/7EZgRG4u8QIuM3f?=
 =?iso-8859-1?Q?Ydo9mjaM/Aznw+nvZAwNHMXhlu4N8Pi4TmZBjKg0XmSqrGOsBGRGxHb1RP?=
 =?iso-8859-1?Q?pWAyymb98Xnppq0QAmtXkqZul1PtBm6+ZNe46AXAmDqbL9hHwBVeNELCnQ?=
 =?iso-8859-1?Q?mcvc6jsRunNJBzXEr0bvHbdpnYbki4BXOcibyBMLOfab22xWUltZHXlELR?=
 =?iso-8859-1?Q?E/sG4gC2pj2iIogo47nEs6K2GUV6QHnB6GWbBqlQUCK87P/hvcgT1fYVh/?=
 =?iso-8859-1?Q?FfnCK5ABHUNaA279dlOxgt84qa08TkjXIQUa4WhHN2UUEEpdRGD1jZ0dHU?=
 =?iso-8859-1?Q?faQjFotiGakPnL9hccXVvQJANo272qCKaZrggELeq9rDt01PLl1s4zkOSX?=
 =?iso-8859-1?Q?iAe2KhNCzmQC4lNCTpl/y+hv8EEwAh8QiNXnbjPrT0Yh5Pujk0sutmk1/e?=
 =?iso-8859-1?Q?j3HtOsDEGZI4n+CAelDIFuvDF1gcw9a0s6tZCxk5LJshKI5YinL41oASDE?=
 =?iso-8859-1?Q?AZKQW988ipMoxeRbyrEw3SJd2imt+ryG9QLhXxcKeH/wfIfQeLR0CkKH54?=
 =?iso-8859-1?Q?/CNU/CHn1QjWm1L9WL0HdszDzUI8Z4OSUteyNszTU+EDDsZ3R/SlknkBJj?=
 =?iso-8859-1?Q?Zt4VqHg5f16zBzbE/MAoTq1sJxZ1TGzc5QD02G54dn5rfhQjJamj+bjN6S?=
 =?iso-8859-1?Q?L1aAJ2Q1Kqyjmboq5stnni3D3wnsOz0SqOjLllt964QnO2icVILORHUqq4?=
 =?iso-8859-1?Q?M5oVGCPFvIEAD+fwvtnLhZObOioMfxylVIEeiQkC0AsAgm4sDE+SHxCWR2?=
 =?iso-8859-1?Q?zaiLoqndViSDbhfxDaioZ3nxTQ9IK/H4ACYLqGGuttM1DUmQOoWb1XJ0SX?=
 =?iso-8859-1?Q?QcLcAfxNqOJ8++WexnMfD4AdPbHhYA6+GfmoNLPYOap/fAjHJ2fk0BMjZl?=
 =?iso-8859-1?Q?hqowshFp1FGjEuB/dwXyWjeBuBOclsacD5ki+SAaXobrxa6hV/QIKR4p5d?=
 =?iso-8859-1?Q?3TgZq/dX3fHmrGUtyt+2oA3RDYFzo9X/PUZawfQIImPv7zgs5W2LbpIRpc?=
 =?iso-8859-1?Q?j+tykYUv+bqavQHsBv6WxxpWeg0R0svJMG9NbroNAx75sZiUnfN77iSYAg?=
 =?iso-8859-1?Q?C+99BJmYo9Gw8zKJD+FoeU/X3B6SQC7VdX5dVnxQ63Qk+YJ8/ZA846womJ?=
 =?iso-8859-1?Q?R9GaNsQan6M7MEFRG7VYN1kACxw30e7fwsLa+Yj3AeY4R4TVnE9WcnOhLZ?=
 =?iso-8859-1?Q?NwHjdwB4dLs4CZjlJT2Trcd2U4e7orQ4RQSYLGtNd0BxqR0aoYvGMlvxSw?=
 =?iso-8859-1?Q?iBLYAB+lMrvlJsRzhDdP+/K03YFyfdRwWC/vw/WisvULYiShlOgV/f1TFE?=
 =?iso-8859-1?Q?IhIu1cPSGw+/blBRV9e/ZbUyaOUxHHwapLA7ZcUk3vDJKel4WbKaJKlTzO?=
 =?iso-8859-1?Q?9lZnL2HQuYzZztpjz674xrCJHU5DLURB9wISlzhLcP0wuoibA5tWweW6Rw?=
 =?iso-8859-1?Q?/lulV/ICHxTMrwIH84eW/ZRCpR1uUb4zAVMYYtfWaqoeWUsXEWGPx0rReO?=
 =?iso-8859-1?Q?76BJLmsqBSr19nVo2jAzRJEa+boBbSAyv2qtC0x+xFMYyh3D63flaH5Zjm?=
 =?iso-8859-1?Q?ia/fDvWSag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3bc4d2-1a0c-4a46-34b7-08df349ba280
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:31:56.0625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VJaqrJmyCJQkI5rqZ0hlUMJUoNRnJ/1I0bG11Sk+caUTXspw6hY9sN/EfIVIammU15XEt22U8ZBH5Fufp8IG2lVBdOpDYoET6m7wLXNEZw=
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

The AST2700 Address Decoding Range Registers (SPI030 - SPI03C) define=0A=
the end address as an exclusive upper bound, with a unit of 64KB:=0A=
=0A=
  StartAdr <=3D CEx < EndAdr=0A=
=0A=
When the start address equals the end address, the decoding is=0A=
disabled.=0A=
=0A=
However, aspeed_2700_smc_segment_to_reg() and=0A=
aspeed_2700_smc_reg_to_segment() treat the end address as inclusive.=0A=
=0A=
The end offset is programmed as (addr + size - 1) and an extra 64KB is=0A=
added back when decoding it. As a result, every segment is 64KB larger=0A=
than the range defined by the register and overlaps the next chip=0A=
select.=0A=
=0A=
The issue can be reproduced by booting an AST2700 ASPEED SDK image=0A=
with "-d guest_errors", which reports a lot of segment overlap errors=0A=
such as:=0A=
=0A=
  aspeed_smc_flash_set_segment: new segment for CS0 is not aligned :=0A=
    [ 0x100000000 - 0x108010000 ]=0A=
  aspeed_smc_flash_overlap: new segment CS1 [ 0x108000000 - 0x110010000 ]=
=0A=
    overlaps with CS0 [ 0x100000000 - 0x108010000 ]=0A=
=0A=
Fix the segment helpers to use an exclusive end address, so that the=0A=
decoded segments match the definition in the AST2700 datasheet.=0A=
=0A=
Fixes: bdb3748dba30 ("aspeed/smc: Add AST2700 support")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index bf596f7b2d..10ea9e5aa0 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -1823,7 +1823,7 @@ static uint32_t aspeed_2700_smc_segment_to_reg(const =
AspeedSMCState *s,=0A=
     }=0A=
 =0A=
     reg |=3D (seg->addr & AST2700_SEG_ADDR_MASK) >> 16; /* start offset */=
=0A=
-    reg |=3D (seg->addr + seg->size - 1) & AST2700_SEG_ADDR_MASK; /* end o=
ffset */=0A=
+    reg |=3D (seg->addr + seg->size) & AST2700_SEG_ADDR_MASK; /* end offse=
t */=0A=
     return reg;=0A=
 }=0A=
 =0A=
@@ -1836,7 +1836,7 @@ static void aspeed_2700_smc_reg_to_segment(const Aspe=
edSMCState *s,=0A=
 =0A=
     if (reg) {=0A=
         seg->addr =3D asc->flash_window_base + start_offset;=0A=
-        seg->size =3D end_offset + (64 * KiB) - start_offset;=0A=
+        seg->size =3D end_offset - start_offset;=0A=
     } else {=0A=
         seg->addr =3D asc->flash_window_base;=0A=
         seg->size =3D 0;=0A=
-- =0A=
2.53.0=0A=

