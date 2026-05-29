Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2832CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw7-0008LS-G5; Fri, 29 May 2026 02:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqw0-0008Fz-Os; Fri, 29 May 2026 02:43:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvy-0002HG-H6; Fri, 29 May 2026 02:43:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMtPB79N7dLF3CgF1+fb+/0NJpFZ+ckwJF53mCBUWXudSG2ltEhQApBfGZSQ/J4yng89kV4Kvzbff2QKIBmlZnp6Lmf83Otc8KOTHXKsqLJw0Dwj+iQuXA14g1/9tQ4FnMV1TfMj8R8+85fpqov7HQpQJmiiF8YS9TzW/wj34iRx+ZvdqHIFQBUpz5O5NF9FnoKpgDrJEvD3gUiuZWolqYRvdt746ip9PORYPE31ff7ciXp+EMyFYYTOk1aM/YWCC0mBEqsgD3rKEW/nol6FN5StD1ybL4H8fkKuqwVCowc66wSZSPYYCjAEgpHdQVTUTi3Ur41biDeDi5mjrwOlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQIyZk8QRCfZ3vARcB43+qcWmdmYabuZz1FjwiGTWkg=;
 b=cS/CvLZg68DxMImSBOLSyLNuy8wmg86RNpx5R6caWtjko+7Z+PqNmgMSJYiiV9opoPhKQvKf0b4QDAQQUJmLga45SSJw6hi6IUVzQhs+SJjO3c+Ur/ypdmW7JAxMROhpes8q5tPYNTuIFLswA30FYuPjhttt61by13DLK2tyFQ3ygX+G2ThQ24MJVu4DJM+T9jqFFySlQfQPACksul7i57Av2T1wZWxGFtwwsFlvKsJ+UcJVJGwVDPUyTIUqg2uOMOnT54+4XTGm5v1RbXADmY7JdQrCbMK13cj0YFWuF91OIM80bzjvrKGG7IadgnMg1HR9uSNTSxZWR+klJEjP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQIyZk8QRCfZ3vARcB43+qcWmdmYabuZz1FjwiGTWkg=;
 b=S3aShbPa51Gomm/Pggc9f7aMk+S+f0eVWEuPNyK5mf6u+unKaW3e3RzjoUJXesgzA+TlQ6icg4fGBCqL7KrMLCVwfH/kNiVElGFqntNxt+kNYstZ7F/LwbduP3NwqvvVxPMix8beseaz3ZDxMfAGyC5rdXPvkjbgP+9lMH7KIZhoWzYEu6ji4xeMljrc5Se0NO649pV1PllgyhmE5bJTrcvfGSRrkEB3lo6ZMwO40UA1sCrXhRx61dbTL7+5KxaFTotQRke/xQoLizWvPsuaX8dnyiTDR1Uvwpdeff7UPSSHi+k4l3+dsuHsiLshVAFsfSymz+vlyDEeegfaW0cxdw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6063.apcprd06.prod.outlook.com (2603:1096:101:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:42:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size
 and adjust offset
Thread-Topic: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
Thread-Index: AQHc7zZc69NhFNx2/E+FFxJ5LOWxJg==
Date: Fri, 29 May 2026 06:42:46 +0000
Message-ID: <20260529064243.2064188-3-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6063:EE_
x-ms-office365-filtering-correlation-id: 7d1a191b-191b-45bd-f6b5-08debd4d7e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|6133799003|56012099006;
x-microsoft-antispam-message-info: lVerUE3Hun7sFZ8YFhqQoiD9DeSzxK1hiZiDOYowwKBLVQSiuqs3Lg2HBw9vn1ZFnODVe6jiQwaM4AI6ZqMxCS8LLuO5BsntPfZq3SlIuFieum+27zhUZqZUNTFPJDhFZ3EF3EM20zkuz50JdpwVPXXDezlixYpstv7Rn8APPzjwITh70jK0KMESlxZqYX8Ej3OT+Qq7KnIXfzh1MW+UGUK7gGf2O1a8OQyCSHNDmbjfW7Hp1fO9Pqe0ZMIl99wTivbpIuhIphDM1LIrMT82LIH4D/PjrcPFmLFZjZe0qgq45AAfxyO1WOa0B2duGq3cbdT+9JUdQFOvl2G7ugTFzUGz63eJJC7sj53ksWpBRzVEh7eg6lXokoTN8nxH2wnM/ETxDVzEZWc5avu5FgIf7cYcadDK+KFik+GBX74NtKbNfqqeEKM6K7kM3B+1yqkJTIlq3LHfAyGO8uUcWJ80TTW3QknRiW1UFmUK20/+TFoi/9MM86xFlL0ntkC3p6fkQcwKuLk87ghyxBwDufSxhxc+7iagM1NP6cHRsQSUGrpXyLdt+1fYKGGTlb+FqxKBxMOj5K+6ubcy0zl3HPAuecyzTnW8ZXvgV/ZBG8s/6dgDRpg9rp4nHGP5p+MHDeP/tpwoA1QELuP5IhKnIpcGndfZpQbVMC0r6ZWLhfz3RYs9ppFfNsBL/CPbCIr/tKoBFt6RlFFWKVfPL5Gg1tmz4AfIhM+UyBzxZ7ddtmeTm0+78smGyptPaeh0kH1SJ2m7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LSmaBMlngE283qGRp1BbJbkEHZ7NW1APFPa3P+r1LiVOojO8KpXOB/Pb9r?=
 =?iso-8859-1?Q?AqGU3kKwDABGO2FPDuCgM2nf2WF48GDZz+MCQ6sxow1ECg6yBqrikU9c2T?=
 =?iso-8859-1?Q?u0+xxTreyPA6Uf1XLpdZmpKrSAb6LIVlw7yYJnh1GjvgnkodIRh67JyoXl?=
 =?iso-8859-1?Q?jUmLGaRTjnr7wnyw2W7M/WhOZL8c8g97RMAeLBTbHiFyLKrl+2zkXxPjPd?=
 =?iso-8859-1?Q?Bwbli7H3WNf0MJOekabcuPes27yW61Wj8hxLVs2trCqgv/bF5xdtKW+7/X?=
 =?iso-8859-1?Q?Jrcz0iF0hHUTT5FRsNDlr9H+yRQSPNo6kDqRxuPCOGf9W0NXeR2HUGiPJ7?=
 =?iso-8859-1?Q?eF5l0SWDBTQGqBKqafr2zfdPVIZh9gHl28tcbz7omxDV10oEnhF+NxUWfQ?=
 =?iso-8859-1?Q?TUg8rvkY0quZW6b9coS11EoLo0YL94RjW/BPv5x5FWMg/7PEb1cELa++8/?=
 =?iso-8859-1?Q?IyJsyw3gP8xFvgVOSMYU/BsbH2b0kOmSrBvLals5DG6aouo3gekMmAiwjI?=
 =?iso-8859-1?Q?QhX3E4WjARm3UCbwVfgNz4yHAajALOJ1sJSnufpvhfaVom8NzfSHLpxptZ?=
 =?iso-8859-1?Q?3QyI+ZiOX7gYzV8LzzkGidTmOm6Td6aVH68diLqF8wLS8+XdfP3sXMfBJh?=
 =?iso-8859-1?Q?ltyOtbMYB6O0CFiB3/FoZxAH/hfpJxNHLphQxiPAo0c8ENJdG2oTEeIynj?=
 =?iso-8859-1?Q?kIYn0U/ih7IpfPGfIKhv9/H4EbHg865/e7s8RHq6AdMTLpK/uiEg3Se2Yb?=
 =?iso-8859-1?Q?I6ABAL9CV0AU367SRXTpL+2pA1wBkbISQcmgP7qq8Gd4IRrPXwwLP3Deg6?=
 =?iso-8859-1?Q?m7ufbu4ak+yRmsf4h9Q09QT0cQP27LvpnLc5Viq2u6JnCQeOS5Xz9ZXXhl?=
 =?iso-8859-1?Q?+0N5d8+OyGbqEPaH0ieYd0gV7oiC6WEWUS//tmU8nAKjfNSmYdvDJDs/HR?=
 =?iso-8859-1?Q?XjZMAtlHUe1owEVwJxcs6/sKAJALzI3+01runTBL7vvQZ4ElwEKrB/SncR?=
 =?iso-8859-1?Q?KkNH4ThSZ/+fAruuRsVogJXvRQZPJyZDMVhAwN/ECJxQDhS6jXxGv1iMvq?=
 =?iso-8859-1?Q?5a0JfLVKFWadpLkXHiG+QoU4Jn6rJatV3qNE5qAiemh+rD3AcSiH8dhmYj?=
 =?iso-8859-1?Q?An6nhmwWpizbcfpvtZF0MfQnDJ8s0qafBhFnGaxpP9vUmB4FpfzfKDcSpI?=
 =?iso-8859-1?Q?XUr/A3zKcHpMr1iaNACf6Yt1KY7IRte0cgiCxWbCO/YDjlD/qd19FjokCm?=
 =?iso-8859-1?Q?dRixnbuyH/cL11Ajh2cL+MKJpwSdq1x0/8jMEaAX/LFVTbHea6AR5K5oC8?=
 =?iso-8859-1?Q?ZixMQwtCAxA8Jnmm/fSas7PERb7GfCSwSXCfws2k0gP5QuInB1up/BbKpO?=
 =?iso-8859-1?Q?R5c1C2kF4tf2zwsfWUGYd9JWJYtBJlGng4Z3Z9o+z90IU3NyY73Xl9LlCP?=
 =?iso-8859-1?Q?y2uD24XIFrGwX6eBtL3sgtqjlT9+8PyncZuyNbqy675fNmUs7NsaRUHTdK?=
 =?iso-8859-1?Q?uaL1Q5gjoK5JYMy8fGmHu7mDC87gk8z+jGUvuDrdnj5wsTPy3YTeSy//BF?=
 =?iso-8859-1?Q?5/h6yWWH+oHDTd4v+QhfM+Ff8S2wcYjsnwyjZ8iC6Ztm9evcdKqDvhhn+n?=
 =?iso-8859-1?Q?Yy//UXWqrgft+8DDSsNXMgCHDROrVN7BmU7Wr1j16/ZvBOUZNvoiA4Mbxz?=
 =?iso-8859-1?Q?R56s0NmHO+pNrPawNhEp6Ja9XsAKMcjB9hcbsKRHXWu6pO7la2Vhya9VYn?=
 =?iso-8859-1?Q?zpmembX+Ndze5vs/HwyPG7bOBA1m4awNCSIpzUSrPp5MDfi7iBpCKnvGWb?=
 =?iso-8859-1?Q?PPly2zRvvw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GEu3mvIbPMv+fTzViUoJB1dPAoNAwJmiU97n4jJ5M+4kAi7Xwp0vb6n1GESZSmkhEmxxjRyvtdMu1y4N1pxYbRl3VmGmnGMeUDJhgbXJWND457RTgxrMR3xwUVIwZ5RMZpuD+r4k8g4iJ85Eb23MzKQmisj8b1W2BTH0tlAVop0xRFXLRhpgZhqwSg5Ll8fHutcMTyfFBDdxlwSEe7cir+RSwTqSDQC1Xatx3ySsx9fyYzCxO10JVjSiB+EZRj3jxiq5EtPZCtUC7aJjYhbA0OwYuzWY2RvqtpwGAiYg2KJdTTF3zcZB+l7/SJv9X5GISvgHNi3b3kseR0KNVt9/sA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1a191b-191b-45bd-f6b5-08debd4d7e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:46.5792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xev/54cdBqs/AbK3OTTvBOLpEz/Mv9sIEMYVry4NbAXMlUfA5/Xe1d0LUgtGO3qEPPwed/dgoZgAlWo5sZFP7PZvO6gUbHH7yaJ56pWMFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6063
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

Update the AST2700 I2C buffer mode configuration to match=0A=
the latest firmware definition:=0A=
- Increase buffer mode pool size from 0x20 to 0x40=0A=
- Adjust buffer mode base offset to 0x1c0=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  2 +-=0A=
 hw/i2c/aspeed_i2c.c         | 38 ++++++++++++++++++-------------------=0A=
 2 files changed, 20 insertions(+), 20 deletions(-)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 1fc229f699..b2e4d2fb9d 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -35,7 +35,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEE=
D_I2C)=0A=
 =0A=
 #define ASPEED_I2C_NR_BUSSES 16=0A=
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800=0A=
-#define ASPEED_I2C_BUS_POOL_SIZE 0x20=0A=
+#define ASPEED_I2C_BUS_POOL_SIZE 0x40=0A=
 #define ASPEED_I2C_NEW_NUM_REG (0xa0 >> 2)=0A=
 =0A=
 #define A_I2CD_M_STOP_CMD       BIT(5)=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 9c0387a394..5be6fefc4d 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1250,37 +1250,37 @@ static void aspeed_i2c_instance_init(Object *obj)=
=0A=
  * Address Definitions (AST2700)=0A=
  *   0x000 ... 0x0FF: Global Register=0A=
  *   0x100 ... 0x19F: Device 0=0A=
- *   0x1A0 ... 0x1BF: Device 0 buffer=0A=
+ *   0x1C0 ... 0x1FF: Device 0 buffer=0A=
  *   0x200 ... 0x29F: Device 1=0A=
- *   0x2A0 ... 0x2BF: Device 1 buffer=0A=
+ *   0x2C0 ... 0x2FF: Device 1 buffer=0A=
  *   0x300 ... 0x39F: Device 2=0A=
- *   0x3A0 ... 0x3BF: Device 2 buffer=0A=
+ *   0x3C0 ... 0x3FF: Device 2 buffer=0A=
  *   0x400 ... 0x49F: Device 3=0A=
- *   0x4A0 ... 0x4BF: Device 3 buffer=0A=
+ *   0x4C0 ... 0x4FF: Device 3 buffer=0A=
  *   0x500 ... 0x59F: Device 4=0A=
- *   0x5A0 ... 0x5BF: Device 4 buffer=0A=
+ *   0x5C0 ... 0x5FF: Device 4 buffer=0A=
  *   0x600 ... 0x69F: Device 5=0A=
- *   0x6A0 ... 0x6BF: Device 5 buffer=0A=
+ *   0x6C0 ... 0x6FF: Device 5 buffer=0A=
  *   0x700 ... 0x79F: Device 6=0A=
- *   0x7A0 ... 0x7BF: Device 6 buffer=0A=
+ *   0x7C0 ... 0x7FF: Device 6 buffer=0A=
  *   0x800 ... 0x89F: Device 7=0A=
- *   0x8A0 ... 0x8BF: Device 7 buffer=0A=
+ *   0x8C0 ... 0x8FF: Device 7 buffer=0A=
  *   0x900 ... 0x99F: Device 8=0A=
- *   0x9A0 ... 0x9BF: Device 8 buffer=0A=
+ *   0x9C0 ... 0x9FF: Device 8 buffer=0A=
  *   0xA00 ... 0xA9F: Device 9=0A=
- *   0xAA0 ... 0xABF: Device 9 buffer=0A=
+ *   0xAC0 ... 0xAFF: Device 9 buffer=0A=
  *   0xB00 ... 0xB9F: Device 10=0A=
- *   0xBA0 ... 0xBBF: Device 10 buffer=0A=
+ *   0xBC0 ... 0xBFF: Device 10 buffer=0A=
  *   0xC00 ... 0xC9F: Device 11=0A=
- *   0xCA0 ... 0xCBF: Device 11 buffer=0A=
+ *   0xCC0 ... 0xCFF: Device 11 buffer=0A=
  *   0xD00 ... 0xD9F: Device 12=0A=
- *   0xDA0 ... 0xDBF: Device 12 buffer=0A=
+ *   0xDC0 ... 0xDFF: Device 12 buffer=0A=
  *   0xE00 ... 0xE9F: Device 13=0A=
- *   0xEA0 ... 0xEBF: Device 13 buffer=0A=
+ *   0xEC0 ... 0xEFF: Device 13 buffer=0A=
  *   0xF00 ... 0xF9F: Device 14=0A=
- *   0xFA0 ... 0xFBF: Device 14 buffer=0A=
+ *   0xFC0 ... 0xFFF: Device 14 buffer=0A=
  *   0x1000 ... 0x109F: Device 15=0A=
- *   0x10A0 ... 0x10BF: Device 15 buffer=0A=
+ *   0x10C0 ... 0x10BF: Device 15 buffer=0A=
  */=0A=
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
@@ -1714,9 +1714,9 @@ static void aspeed_2700_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->reg_gap_size =3D 0x60;=0A=
     aic->gap =3D -1; /* no gap */=0A=
     aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;=0A=
-    aic->pool_size =3D 0x20;=0A=
-    aic->pool_gap_size =3D 0xe0;=0A=
-    aic->pool_base =3D 0x1a0;=0A=
+    aic->pool_size =3D 0x40;=0A=
+    aic->pool_gap_size =3D 0xc0;=0A=
+    aic->pool_base =3D 0x1c0;=0A=
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x2000;=0A=
-- =0A=
2.43.0=0A=

