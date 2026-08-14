Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF939C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuiYg-0006Cf-6E; Thu, 13 Aug 2026 23:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuiYd-0006C8-HV
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 23:26:11 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuiYa-0002pH-4q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 23:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqOgeVDjFNc3ZNJzLAB+lTH4/XDGyWpCTb/t2PiYH9+QYoKhfpG47NaYNmIwjO1R5znMU82f2G9FjUgLVXFcmqjOXsAtVBGhAgraMon/Z1X3anNfZGNfxl0W/6NQCBe35OPLxIxphOWGXWmKLtd9U/2T77i6ks3C6IxKg/0Gf4gDtyy6T4LMSvtwmhvONln1ALp7Z1Vv4C6/I9O+BjRdWlVM3c2532UIYJynbj7hHf4mLhLpHN4g4Jb3C9bnWEyJ6mkJVfEOFlVH13pMTMd6uZ0gaozNa6d2Y3S86Mzmuz9BMb4K8FkMdNGsCabug0JdIyCd2IDP+miookFQ59Ph6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqbu6wkso216vGGD5cYR947pYD3vcRJqo5HJyVRQ4cM=;
 b=mItxuZ9lZCa3i6zFR/MbPm+BmOBX9kj5t0qJtGtYQrKlRubhiJ0ctFq88Tboxx6ihKIoKIUAcykg4iBqo1itlVkWOlZ0NCbI6YC6/Vsyi/Muj/ZllgPMNQsCJxPcvpB0YwLVdrwOcZByJCYhuDKR7C7R2BpIVjNeF5g0Sj7gAp46oFFKPKZ66ZOFTAeXN9nJnDjSZ01z4DR9fjXtolZl77eKZKJdNmapM5TAEO4T+cGqttg9Ofu8a35JmxzSGSABLWr4ofd9jhXuE0vCN8u2AGqwHLvCOIsbo3MvhN9HjkVV5T0xkp3DK0pYdccVht91wujQXDdmmXeKNl1o1qjpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqbu6wkso216vGGD5cYR947pYD3vcRJqo5HJyVRQ4cM=;
 b=H5kAhdXROFTiv80/NseMwOV0BRmtGCJ8P7rlAmaA+WUuZLqNh1I6JdptrzX8OjqsFzgdTwoPMFbm/pdeUkbcyHW4qh2KvUUEVnf2NIOQw5p1yQuRez2dF0faU0BBLNOiHCzmcmz+SBEK1y3+Sug5pE3TA5XpEylpAdUDqevhS8NB/30OguLkbKzlvtzXvUIoQxefbdupg417hVFL67u3hAwBpY0WSeYPtw6A6nya1Y3ugagw2sAbdLHZ/oct6cAmXZcx+RI0osHZHW2S7gQ1+UIZEn0/PnOy9W9DA8I6eJh0dTJWt24O7tCYn9O8e6AayO7nK+lziXVlVssS5fSE1w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8358.apcprd06.prod.outlook.com (2603:1096:101:32b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 03:26:00 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 03:26:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] hw/core/machine: Move EHCI migration compat properties to
 11.1
Thread-Topic: [PATCH v1] hw/core/machine: Move EHCI migration compat
 properties to 11.1
Thread-Index: AQHdK5ygrnV8UOlHPk26dbZ9+Atg0Q==
Date: Fri, 14 Aug 2026 03:26:00 +0000
Message-ID: <20260814032559.3381363-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8358:EE_
x-ms-office365-filtering-correlation-id: f03a0292-c033-4c36-37b9-08def9b3c32b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: 4F8MAamB6gvwbhy87qG6CLIYBgX736r7eaADE9PeZulU+wP+5HqxT42IWHtZe8mICO8yzIj5MWWFURi2F+AXHwEHlJk3pNm9JLoDUMDZVGCvnndLhQzu132vy4KqmB7XApkw3qCl4k8U5YFvnyt09kmtQDIqoR19imjus50N5yXphbM3WrfJcMnf4UNnEa0wBsQ0ms4IJDBOC2ThPDZUpu7TsFafWubVmBB25luwOe4Su2WJ9W0ShnU+DWT1PZJLJ6KY8A8BE1Ch/BrwNDVopHt9fWTCK77mAoAarWDfv4RSVHxqEawnfvZoDQzAjK9Wio9b+sVqiBh0Z1FtSdKt0dgx0cPNYZq9Efe/8cbsDuh7B4EThJJIlzIEk4+V7nFNKapfjL3bu0FW9CjDrDZ+x1QFKI296uznpQOZGAHW/waYTyfnYg2Zzs6+aX5jWzrxzjS4/XvbRbVOYZcG8ufR/UHgB7L6LF/ndPhfVN5gp4cjUfVDTsWI522wIeQ6dLxrW7ELG5lBnweJjzIjxB4tD7IJDjFlZ9HwJ8y0k8IRuPorutcl+r0drX/T+JAs6oS8G1DDMGHaH7kpKtbfxp0MY+EIhz1WH9fWUgr+adRu1az+hrrcS6pt3qMAUxAxqzg2hFz5G5i8pOlsO156Tw/CwxxwFx0EbLINX0Mo+lQ/SjrOiwN79rTnKBgVYxdFfPoeiCVkxwMZDV4tK7d6hyFmFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RCDDGtRcoz7RD/Nxdw6/v5YWPD4ukroXHo5wNUO9zCJ/Z5rJol7R0YYKAU?=
 =?iso-8859-1?Q?UNstpTg1KP4zvS52FlXvtAy38n7mahcWUiBFb/wVZEitE1N4FFNIso+8pn?=
 =?iso-8859-1?Q?t7diLDD8w0yDqmBUKPijBDlgcts2PoSbz1zERR8yE7cWHAzHOouQ2+I0w8?=
 =?iso-8859-1?Q?GRprINJaPI6nk2dqy/6di2dGPHlsp6vsn45Yt7fF5B2Q+3zqYt9koTTfbk?=
 =?iso-8859-1?Q?GW0UVqMWJkn/xX0R17ebcG46pHQd7GOgXulEDJxfAvXeqrS/gm6pVlGGnL?=
 =?iso-8859-1?Q?FUkl4SWxAypUpm03oIVe6s0lQx3CPqqedj4rkiaQfxEDenk9u9UtndyDPt?=
 =?iso-8859-1?Q?pfX+ajabaBfm/To8PZiUP1LquQq9jVHChiMnm82pIboWfQjHV65i12H1ML?=
 =?iso-8859-1?Q?Z90jBMJpGj5xY991l4sDS67wnJoy5gL51Mztd53/DRC4va6cW1piVsI3Bq?=
 =?iso-8859-1?Q?Wet5213Ozsv9d4NPPwublUCg+81AWw3ki/DCWoykzVpGxIAxSkBp/VDsFJ?=
 =?iso-8859-1?Q?+4W9XYuJB2teRH8ilvtPAvYn4QIh/NGjpG+US2YlxP0Ga2lJBj3eif01pU?=
 =?iso-8859-1?Q?E8NVVyu6FK865fffcDnhLgpVl2IbQxvj67JRdxDOVlUYXxgOyQZ8wIXLRW?=
 =?iso-8859-1?Q?rXGmhexxoKTgHKllBKzLDuJEbQujsAJMaEGDKFZ6EJlemZh521Wl0+GaDg?=
 =?iso-8859-1?Q?16Ze8xGkK9kCx8x/ftrI0/B8Ois1YICrO92six+sYjK9dGFkkiToxi2b9y?=
 =?iso-8859-1?Q?+rZMXuXy8S/epkDHcMluYF4J9xNkvJqQkqGqWlw41t3OTylYSlvqLSmPwg?=
 =?iso-8859-1?Q?ojfxFC4YLvFQT/Efbn6RwmDU49nRfNL0ROpasTEQ3BXjrSHz+r7ti1LuHa?=
 =?iso-8859-1?Q?gSG6Ocemuab+MhF8mHz80kxmQdB79cKkO/QbV2hXVjlf4krgDK00b8lnio?=
 =?iso-8859-1?Q?b9B32/1jRcNyUsswsLFg1qJ2aTaOLi9fSehaKjSklACmZDqPo2QlT2BDon?=
 =?iso-8859-1?Q?Q9ZP2WkfG0XWIQyW/aip0eH9tsuJ2IjbWAo8tIIUw2MPLwL52/JuXAJ5fE?=
 =?iso-8859-1?Q?rwnG+7cw2cz80Bv7uW0zs0B4ZjoQa0mjeX/DNamBFX1xIDPg5zKQ11UsYr?=
 =?iso-8859-1?Q?R++sMYP3MyM8utRagNVVKjatGkFSVVYXyn0uNF42yyr8Nor1JmjBC6Wk+F?=
 =?iso-8859-1?Q?M1CW4sPPTUMEE0MqX0xjVDbZp+LcNUeB4X8SDXzsVgFW+Z5ZadAr2kMdnI?=
 =?iso-8859-1?Q?e+H1QR4wXLHuLKkbyz/05y+TNB+xVNE5FPLaMdMdirE1w6A1x0Xx1hZOOc?=
 =?iso-8859-1?Q?Wf/RoUuxtz3jtsTW9i7rB40JYNf52spqlAliRtWTZIJPpKFBmzmSYma8RG?=
 =?iso-8859-1?Q?YyJeocFvSUjHMfvS3FDNex4pAx9zsXbHG42kxbc2/rFf5Cyt7UrTEs9nfS?=
 =?iso-8859-1?Q?N8AhCIEWng9i6nyruEHjrH/CHTGUeS+M9XHNaq73w2rQHkay8bk88IZuDO?=
 =?iso-8859-1?Q?Qpcf+s5sW2O1v6gCMxtHiUSr/P5KjgLeWdu8vD5KDP2EWPjg/BASVG2JxX?=
 =?iso-8859-1?Q?wsb5CqIAekkjncyGFD2u2k5WQCtrkWXDBNBWCHIGpxLVfZUcjFtNZpf/jr?=
 =?iso-8859-1?Q?WhKYpftpPDqMV7DzzAtdu8l7Q+70ohqTDYjrVTh/3d7ze+M53nsK8thMDk?=
 =?iso-8859-1?Q?PaPfsvOn7W72ORaxfI8xfNRrJEIep+2R1NDmDyJkd9KcNUsq2uI09FZ2Sf?=
 =?iso-8859-1?Q?3J+xCSiBvwP9TYz9bQxKwk33MF6yq6Tl62E7UPWb9uaJp5afQ/D9WpLkKG?=
 =?iso-8859-1?Q?ml1AzO9DGw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03a0292-c033-4c36-37b9-08def9b3c32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 03:26:00.1795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EK1rQYy2cluRfvio2635FCpixgjjQ3rj0jNmbxNoJUxLic+ue+AIxAWaGEGGM+jF1YCBuyRAmf79qfdgq6IHrqDUgZv30xe9HrwHPx9d8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8358
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The x-migrate-fetch-addr-64bit compatibility properties for=0A=
sysbus-ehci-usb and pci-ehci-usb were reviewed before the QEMU 11.1=0A=
release and were therefore initially added to hw_compat_11_0.=0A=
=0A=
However, the EHCI migration change was merged after the QEMU 11.1=0A=
release. As a result, these compatibility properties belong in=0A=
hw_compat_11_1 rather than hw_compat_11_0.=0A=
=0A=
Move both properties to hw_compat_11_1 so that migration compatibility=0A=
is associated with the correct machine version.=0A=
=0A=
Fixes: 38ed803aebb2 ("usb/hcd-ehci: Change descriptor addresses to 64-bit w=
ith migration compatibility")=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/core/machine.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index 4e55119446..e617f7804d 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -40,7 +40,10 @@=0A=
 #include "qemu/audio.h"=0A=
 #include "hw/arm/smmuv3.h"=0A=
 =0A=
-GlobalProperty hw_compat_11_1[] =3D {};=0A=
+GlobalProperty hw_compat_11_1[] =3D {=0A=
+    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+};=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
 GlobalProperty hw_compat_11_0[] =3D {=0A=
@@ -54,8 +57,6 @@ GlobalProperty hw_compat_11_0[] =3D {=0A=
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },=0A=
     { TYPE_ARM_SMMUV3, "oas", "44" },=0A=
     { "migration", "switchover-ack-legacy", "on" },=0A=
-    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
-    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
 };=0A=
 const size_t hw_compat_11_0_len =3D G_N_ELEMENTS(hw_compat_11_0);=0A=
 =0A=
-- =0A=
2.43.0=0A=

