Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF06C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Jeq-0008C5-D7; Tue, 01 Sep 2026 04:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jem-0008Bm-0d; Tue, 01 Sep 2026 04:15:48 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jej-0001wa-1N; Tue, 01 Sep 2026 04:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TB6lMLBV46j21E+dfbM5ERoOBKL2/hKDhkk4feinP3WtNkVPmELzHLePcIFB6iyVqPdg49ZjJ8tR5Q6WsWYfY2QIvMrjLjRW2MTaKgFUKBG4L6dN/MmRFIROkU7LSudAahMLMt+4XwFIZ6J8EH3Jp2kSiR/tWUtO6ObmJQkG9VIQLBurfma19r2DF9SOFdjrYTd2i4cjKzSgVWogH3vGK1oXDqkPkBlCdhrnPmGsafOAUl02hwY6OnrnASL9mwsYq+WiL9hxPomiGpSK8NREZ8TfxfeTukYhSinpfX+PE1Y4jitqKl6/sNNn3uBSC4m3mhwWcVEAUWpSlt148rXZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq3XZmaIV0NmtgtY6zbCD5Y6Sj4yPpLzryMe75TU5bo=;
 b=GAjH6KzJuz4l7PRh0bWv0P5gRQ17HL5XFq/sAImAgcXJTLOBH/17WBkLHQYVGXDKKImmI/CdFqC6WCckD4EMrRUqZLvr71sTEnOiE6JhWFad2XcoeGf9iR7lt/cvWZ1csAgDOrIoVvtb8vAXN6sWQaCPB5O8/gLjZuoWSZCskR+PWDKBfTA0U+WQ4/CykFHm1TXezEkC8BHDaWqO5ciTWEWUG+DFrflvr6z46LY/CshjXt/Kyp76BLPd5EGLI8X54XYlcMmZj5QNFcqjd2JvI/Df+17QpC2W43xBWS0N6aYdHknxjEGqnCtnEt7I2QLiQM6/0q59X0tEviw6hbSisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq3XZmaIV0NmtgtY6zbCD5Y6Sj4yPpLzryMe75TU5bo=;
 b=W2czt0T3jJiej+OSRSWKRQolJyMVomKU7f20xsr2XAF8IMfofDH/rZm70Ynxy23Fnur7HAhRTKhkMQlMnkB+W+x5xV9rOseitCZr2GRR4FRjudla91kK/76AmmNySnSfzyc8oJN/DfIy6mhEuYcgtyKa/AnnKH6FGJ9zovgOj/gU08JHcBy7aemXkDynaqnHMt/5II8t7Ck+fL7nBoY+sdvmAEFaK9ISnZoB/oUqtHuBIkByYbxxHGODEEJKrV6nSxrVIHYemivJLsPgPyc/Da2Ui7kh+v3U5CYT97fnJx2w7NvKcpaRw16WipHU8AmrjXcaCrNkj2Pp7sIXMmCXow==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYUPR06MB6151.apcprd06.prod.outlook.com (2603:1096:400:350::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:15:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:15:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 2/4] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Topic: [PATCH v4 2/4] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Index: AQHdOeoQPhLPw7QWPE+qgBUAX3GuMg==
Date: Tue, 1 Sep 2026 08:15:35 +0000
Message-ID: <20260901081531.898176-3-jamin_lin@aspeedtech.com>
References: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYUPR06MB6151:EE_
x-ms-office365-filtering-correlation-id: 9c6f0bac-b185-44bf-e004-08df08013379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|56012099006|921020|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 9LOLAZ8ERsDvWe6MZe27obYVioHpeAi/7n2HqWK2fIldoqsUp/u8ptmHfhPKL9Nx89s+BsbfFuSWEtzjcgvWaclcl071OSaeXXaKsSMewbsAkoOSili0A2CioCkeijse/Fop674TeGBqfz2wwrduRUA/4I2NU+CRczzT6QZxdVhwrd1buoGCELaryZzFHToUPgw+wRcfQzJlkYQszyK8a/ArOU4/u5juZdGXl1ZovDFURTtO952DGlIBNiNjcIba9rNPJ+j4TlvA/QdJAGHWKORqhgPamEze/lBidhZvpJMphGso/hxlYZeuYrjoZaCGfQImj4Kj0gGx6rZ4JrHrOnOJkoD/tJcly5fyW0SbTi5sccP4ZquwHuAH863bt38SUPrIfPC9Nlh4e4F2e3Uou+CUnZkYrqutYKppWhNtXBJI4nKHZAL9L7PzitpHRMKFUtlewlSY/9VwahTaxM1NA38Yt4wNZYOUqewi+5FWN2u8O/3Ehk6vzRCK0cEAFxdx3mv7LhYS3rT3dFVUzhZQvEcaJmKdc25/PwuDGFTd6A3j2xNvjXG4cX43fAqr6gWixy0WOGraDL9IWLFmVXodeb4XMNPVgZuB5PmOfP2VaN44k3YS8FucpE8pbobnkjhHpfFXrXuJgLGRvG/pLljAdDQMR/vBJHYdw1LZOwRA4BpQ1vQEj2lV+H/M9c718Lk+JmV+jHIuTr9QW0eRgZvudo0pypJgP/1U4tIbeWfmTp5j5iQOD0cb9dsGobFhI2Fq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(56012099006)(921020)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k763GurXbcwJwGpyyUFGIJ1yArWU7qfZo6A+VgimdMTGVsT76X26YD4UTy?=
 =?iso-8859-1?Q?ytPFCWmlFvxPsF1S9mtoru7RAbdpIjnwIfn6N/j8cJc8S1Tbs7i3/xi01D?=
 =?iso-8859-1?Q?Z5TH3Un64b584JH7U4iL95z/my1MN1lbsipz3N0xunhlj7s2bKbDO7Hu8d?=
 =?iso-8859-1?Q?mDNDH3rKA9AhX/wLkzrcgAARZetoOBNrpq82gNISipMctQGARhRDXfjxkH?=
 =?iso-8859-1?Q?LP1rO5ZDa3q6/0CIRxoIKmgHtK61yhwbdo7uEoqPu64sh8befeoJsHzIJG?=
 =?iso-8859-1?Q?mzeMllSWgzRCg4jv0213bP0nkY2auJT4oGDuHWnYdp+lolOEiyndkGP+vN?=
 =?iso-8859-1?Q?XBKTKwrQn5hiyrnh/yZmZ9PQEKtGE7LI3FoaQPZsIOqMTo8ShN0tdqbaKj?=
 =?iso-8859-1?Q?nQqnSv3TwR9nLniO86Qb6V/crmaRy/M1gruok8IMHu1Fvd1/WFrgfYas3n?=
 =?iso-8859-1?Q?/6LAHLjuuMERZN7iXntq3TkT9k1Rydo2yptKQNWvkIE91N6GbF3qBwBrfR?=
 =?iso-8859-1?Q?vepuxg9xIZ9CgZkdaaP4TO7mrbsW7o/m/u7nyV0Tsi2k3RBbBxz7oMLKB4?=
 =?iso-8859-1?Q?dD51+b+1slH8cQwCy9xFCsYXq8AtvL3YYV8eqI/W4/u7A4cIJxZeDfQXZq?=
 =?iso-8859-1?Q?vByY42kxrcWw7F9H5pG7zPdUVZZjm1hJfgZHEjLDppVTnvJrLP6+o9x/eM?=
 =?iso-8859-1?Q?brzBqz2g2yd9JDw6cvaZp/vgBjOeDvrBUDm/mkF3m+42mbGwLakxvPjdIV?=
 =?iso-8859-1?Q?KU7D08g70534G6G/PfLpO+3kUYsIgJUjw0JRjAK5/GL84DxId5DPKZ3WEC?=
 =?iso-8859-1?Q?fwU/pww5o8BcCmnpwWiu6WVCf+YtHx17nzyvquaDlbBhtlR4ti1DKrMRO0?=
 =?iso-8859-1?Q?C3HJV8tRXrdvz8r6hpxp/p+nKdMNnZsJ8vmVxyhyO2dKWdRMHkaE/2B6pz?=
 =?iso-8859-1?Q?9T9xD0ldfqIqo0rj1OzLM2AI2eYHuQdLm4l5OaazDpHz4pYm3v5akmMMdr?=
 =?iso-8859-1?Q?6WxsaODX8GE4SZ7rTv0Ak8DfBeL7ToZTTfv/dVHD412EJmBZHBg7qpzp46?=
 =?iso-8859-1?Q?+S4ShWVe/zZ3qj5tTZUe2uAmjxViA/bEG0CTDLVBaOOaX84XF3rfXEGGnm?=
 =?iso-8859-1?Q?Mye3QYP7N/b29n+ckCvJdkgRa8/m2t1mYNBjthQNCR+UiEKegl3CNSVTSF?=
 =?iso-8859-1?Q?Nw6Epd2/fKED7cKs2rL2o/fBvJBTIIoCiGiEKTDuBVT64U0UQFMTHBLuwT?=
 =?iso-8859-1?Q?TOo7WdtkPKgcm5Ock84/RC3pmSz6J9SmK1WgzuaOaqgzF6uWu40nrTD21i?=
 =?iso-8859-1?Q?MYf/DONU81SAhkpO7c2qyhfCnJczrkFMKIrpefZIqMo/xqkcF5T75ROmUa?=
 =?iso-8859-1?Q?le1vjS4psHc1GVjBj2MMtW7dvTehxNMQ2A9KcM/Pg7+LbWcfv5k+bN2fx3?=
 =?iso-8859-1?Q?m1K14V1HPB1VooEqYzvnk974/HS6PF2KB71dScOYPB+JFRttKUjob33ISB?=
 =?iso-8859-1?Q?CWSm56CySGNgw7loggpJjnPJdauqOfJIy5Yzgo1E5AJdENBYvsAzET4agN?=
 =?iso-8859-1?Q?0Gxv0Yo86l+fswKC5yZWT8Ale/EZTtCTfXfXOj3xZQXbmkcP4S+COH6xCN?=
 =?iso-8859-1?Q?9/5rUFiV/z0bZJMg+nQEv7OUZwGFdCbZxGYlZPF8c5GndZ/rDmYJIZ5H+O?=
 =?iso-8859-1?Q?NQtJWkm78ro5BF74wGifV8gXnkIvu7UoAei4m/4HQekdTFMbZCR5Uq0N3c?=
 =?iso-8859-1?Q?sKIRRaAE2keN5HuQBygvk+FDvYKlyOrXofe9qLzL6S8XW8m9/qHQwFTudU?=
 =?iso-8859-1?Q?VWASfxTzyA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XM3CiChJVNya6gGSZzfbaTDiXPaRbKMBdDiXIIlrA0VjvtMRyTkMPRAo3LQyDnrYm3bQ0DZB8TdKLoELOq42l5KleOr9gDk53uu+MijQ8fXqOh9irDwqW0RYCVNZUF0D8+hijrTnpI70Pk4yaFA1Mv/2YpjgELHttdgJCWPp8rQe1MdPz7usBIxQXtVXSHGmXTyLkuuxqIcFbZ5XNLEl1L/atdnNhQ+WHm2A79qsJCTrDD4QC/muYt/vTdmynqESTavHA56Q0nzm7cJyuG4/7sB8mu4SH2tTrQquatGSTQVl3YnYLmHyq2IYWru/azTCkel1qD03l25gXmVcVPFjlw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6f0bac-b185-44bf-e004-08df08013379
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:15:35.1112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9a8QEbVg7fgzR/6AY40iYYcLef7T8oQEJXZegptW4F51G/Y1+uUGz1fvcg/qGIw6nK9X+yV3AKsKN+YiyGN49x/QT8yY8tZqPyPNZdBqGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6151
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

