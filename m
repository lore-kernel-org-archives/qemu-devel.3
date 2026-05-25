Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4D2CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9F-000272-Dq; Mon, 25 May 2026 00:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8n-0001lI-Rc; Mon, 25 May 2026 00:42:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8l-0001Iv-So; Mon, 25 May 2026 00:42:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS9WIGCJonkt99w/60xANo+MPe1Z+fVaibhITmVoyc7VgI74FUvQFeeA52eq3eCnMyE5jSBgPT9Io4A1X/h+zT530gvPhxDEbviURORzroBQsbxRSMxMFNu94Ie+WdUmjPE0rtM+Ql1amazleg5SpTEXyFb5SGQ/vhW2nLiipITNMIbUbtpoxw4Uc4wnbEYlY8plWgv/Cf74y3AZr9lWPoKHUMXxtlHXnUeRj2wDMsO4lxH3C/r19cgNXtDb8PWH9AKyFyUooeEdmqAXSq8XgDkFCXTWVa5zLW4fkGDNOAKaOz2m10YNEeTWMs6o7WNLEj3JN/+LdD+hk6sm7XFrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaGoJPlUwAp9stcA98S3fgHOABodJl5posqhP+LMp8I=;
 b=JtpHr6aHQm5/GttsCt2dhKit+OboPiQ4/fSYlb4p0aLehvSC8kOUaLw3CXdeWRky5u0g/6V+3ZSSFrFffnOG2RNPmE3WO+amWXIM7f9qhF5L7r/3nmZiKIc7zT38qhIGlObd1MYt0zy2bt7aY5ExjJE2TYc69GHFk4MoYMcAeumK/iQIntM+OYogx5wrAPztngAAtH6U8nFTF3bpH/ewYl2tBFL4sG9snIsw/1FWCJHSYYMmQtX+kKs9IZwmxWlt159deo4BcBwaOlUmdx4QuxSEVUxmRqQUugJFvxWfadC/KfqvO22yQCCfKgP2JcvIEZ9zcI7xQTm+mnuAWTtqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaGoJPlUwAp9stcA98S3fgHOABodJl5posqhP+LMp8I=;
 b=URQnb7B2wxp6ZR5DkdWT4KELC008yFWC+kaNNez3O9PZOhzUbyK0R4qBFJrhUZfHI1BGFrfl41NBggnL+62wkjDSOP8H51DMyY+yiK/SCGIUzzcYAbfBZfnzSYWhdzrong+aXmuZAfvUjcW1+OYUL0kpxwCKd1oXY6rHjptpjln5gvdVp4V7ck43RPmjYGZYP9NhISmuCO7N6FGiP2SUrEJi4XX2iI7ZrdLyYjZKgZRr4lRvaA1ojCe3ijaWEQCon5vPYQsd0bl2Sauw1lxe3+0xGYKPGZznshLeMIs6DfNjFIm+pM9ZWPn8LBsV0TAqmGK7sdYLmEKdJejYMxuRPg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5617.apcprd06.prod.outlook.com (2603:1096:301:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:59 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:59 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 20/23] hw/fsi/aspeed_apb2opb: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 20/23] hw/fsi/aspeed_apb2opb: convert to use
 Resettable interface
Thread-Index: AQHc7ADSNbYgmC2Xf0yDideFAM05Ww==
Date: Mon, 25 May 2026 04:41:59 +0000
Message-ID: <20260525044129.3133916-21-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5617:EE_
x-ms-office365-filtering-correlation-id: f99bea62-86a8-4a73-8025-08deba17f55e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: c/4ji8r1wXTUob1Sbk9omZBtYgAebuAs30MK8AUjbUPDanli8+sXK7ApbkBlwyYlhsslgs6t+jqLYZ9A7hYFlqIlmycYvqBlHtPB7862qqHo1y5jBnVCdLi92SPzFcDTZrKFnPQldcLJI3ojzCbMFE89XdpSlzhFL1BUQfQUkhg5RBkxiwHmj+rRrJJs5n6nfwHVWRd8sz5GkqJ2nOYU3cWYMueU/A5yngtgYLBb4RU0uFecvhSpmJcOr/z8PQ8CVHvHr90X3/4eMEfzkOEFk6jr8wucQBpF9q6+UQJGzUhlMPT974uNq9ngHPjcRh2TkCSO1jeQP5wvQn5FtpEAblGpg+FxV8pvQkVpKNxR0sS46A0KPALE0g4e1vHXvu4pHEqAunlctCH379d86KH24X5lMmaW5z7L2thtWxmg1+ENd5po6/BDzUtqnJ28J9v/mh1a45CN0IdKOUKX5sA8EWMXQ7bj6ZNBJq5RwEXzDpa2h3B9xUXiH5eQbgyjwCsw07a8hipqwzJTEgMgGzSn/1lOHq6vxmxaWc/uVtSPUjXn94brQyNnLYvivgbDjSqjcSvjxn2Cq9WoCmh3Q7sMDm1lnulnM5fdCDknmx5YpNvKbjMPlYiWhD3fFxQvnSGa8qrtuAtl7IruH6/pRHGpOVeHo169tj08Y1i76WNoxsaKi7e1jubA2/Ba1/K5qBTRTMZ0MJ/fx9t3/ccdV/Rf2xVl+LtjyWiSsTDU/gCVmJFQUz039bq6e/ZHpaa8sFdnGCfT7W8Flh/JofSMwKJCxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PGR06Rx/7qg66wzv9GltzxqTwiCvid7ip9vPWbmcLZxcTCdcIPIkZHbrxt?=
 =?iso-8859-1?Q?GjSbSvAY0T6k1Z21PHSL2PC1udMcY3q9F9wRg05kUV3gk5VMzKzvi63yEI?=
 =?iso-8859-1?Q?1S8jfqxETSh85eEPXBEd8Bj+CPYofLVl4jGd61yCjBDlYEMkSuC9Vrz5qM?=
 =?iso-8859-1?Q?g0kzJYVxjNNR93v2GqKV499gF4anOHR4Hm6+x9BmteVJ/AW7MiQAzpT10o?=
 =?iso-8859-1?Q?xtIiIm3/6LeHCD6K0rv6P82uUAQUl6b0jIH4alrB0GV/zY2AoObE9ma87x?=
 =?iso-8859-1?Q?jmc7gbKo6t8KYUYRE9TNJh1MRsbSwdzmYkduVaiNlI7MZlIDElkU19oHAT?=
 =?iso-8859-1?Q?KydfVsM98S4v1oh/7EPYBvgLX6O57aSUu7nt9oqEFVgbpU4+nbjsnDRUcA?=
 =?iso-8859-1?Q?QNihJ6KW0Q9wPAasdlr0bprZI2CaxtL4mu7bE9vktexYNoin3hRzF5goxq?=
 =?iso-8859-1?Q?cSpQLYXLgTGn9E0+IhX6gjA3dxBrjeUZnogbKVfBWZE6PmvEjsYCxg9rSo?=
 =?iso-8859-1?Q?suWkKwRY4nGAQ/+400xWu6rG0Pcp8/TrbSiyY5zGiVcErAK1jUmE1hLfoN?=
 =?iso-8859-1?Q?XeV8a7PBGbgEkJrHHOsZmmrzD7/MQhUTfhj11FheEszRQYo7IpjlDU5LwQ?=
 =?iso-8859-1?Q?M8kFCRmctT7kMDR/D3fmW9hxetwjqws22uOSMSrXLc4F8Fmf4X+zJcKDBw?=
 =?iso-8859-1?Q?yYdB39kpTqhIJLXdcob0bw+RrILY3Krhk07+nogY44I+2eJQIFMrM0+96K?=
 =?iso-8859-1?Q?C7LyNJkZ3hM7daUoilPFSjPdT0l54H4h0vVlwSX3QWz8qW2i077jSWuHGe?=
 =?iso-8859-1?Q?S3sxNpRIzfJk6944SkQwvoJ/NlpP5Lq9PC4BiN2z38QW8VUw67QAJBFLzk?=
 =?iso-8859-1?Q?t7hVKhUQ9IhqfbAJEWFM7iVfdyXa4XGrcXcN21R+RnLDR6xh4Vvd05SeCH?=
 =?iso-8859-1?Q?Dn24sAy90FOHNVENnU667KDApvKcIs14iUn2z6x2oSkyMIifxp8nNeUy0A?=
 =?iso-8859-1?Q?ITj+/IVzMBg+5ePxZDom0NYNUU+axICT6H4qr8+x2jKUFvV6hp+EmGlE5l?=
 =?iso-8859-1?Q?RjAR74iXyp5GxVw5Ik+pcME1o00OsypDdtn7TWLx9o4g/Kh//JutZlv5hk?=
 =?iso-8859-1?Q?cpqyJqTxfRSpeHh49e7iIDuybuGwVduTCJWLlim4b/RVGvwWXbdSkiO2Dg?=
 =?iso-8859-1?Q?DxRkElpzEmGZo7zOh57RcBXeoBTWRyDd+RD/7fS+OHu2v+qa6LkwaZP0xM?=
 =?iso-8859-1?Q?67Pd/g3vkbT7oQaycbk7d51VubciwEgkNFgabyskGEIPp3GIu5h+2LG385?=
 =?iso-8859-1?Q?9ITm5swXBdPUWM/jLfSUAe/kXArSwqWPUDhFGFGFTrc1s1+onbdd0rPxFK?=
 =?iso-8859-1?Q?ZpMirPl9Yhu+oiIF4ZhKs50qJnUMSW+QyCb86fjlKtTN+RsugTWa1QRPjk?=
 =?iso-8859-1?Q?VHbUBHkfj+EwJWsEEw2+EE415+hgbqLy8nxvED2g+Y8uaaiJGiUTW0BbIY?=
 =?iso-8859-1?Q?qPkKbLgLXz4NH0dCtezD6epqgrYF2hROnMB0kCGZTFigkCuLibfyW3cC2Z?=
 =?iso-8859-1?Q?deY+2tmn+2MMrmmO4COTVzWEesxo5IjbJVz5yLa+vvoKtCs88xSMadPAeU?=
 =?iso-8859-1?Q?0Tg8UvTewKjHAPqxesmTof66DIec71zJrm6G09xDstK7HrwibcTfXjWg5t?=
 =?iso-8859-1?Q?Uo/aLFH2Fy/nNA8PNM6rEVnyEy72g5b5aQsckn0kHkMZEAPVMOEv5UjaS0?=
 =?iso-8859-1?Q?RQBVLK6jC4gfD4Df+BVMbMk7410L58cZF1xA+K6oa/6C/Oy2hvVftJyJGr?=
 =?iso-8859-1?Q?noHvmM6xjA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b3nPt9cHdy0gWGTNYWynW6SajYk8gREDwZ7zyxfFRHIiahNO0vE8SC84EgauW4RXbxAo2/Fw8s+LXmvI8RtImChYoGQiwgFHgA0ld7kMzxdNC1NaIsinbp9ZIUrHpU3Wzg1XMui/RlRS1uj+ATZ0H+LKRbVL6UH89zWQijvRQraioWDMlaA0aYIqAVuly0Vn5GqeNzu0ev9UfLAZrYB+JmhuBMNHZadzrJx3wxCyrBLfCyCzYOHQjaKQ5GMcy343RBOtVv8P1tMlKiv1fy5FMTlKwGsJ8Y4/k4/godW3rNfyPEhe9gl4bb1G7IaVqAkQ4/yC9vV9c7BdGxtZVwhYXA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99bea62-86a8-4a73-8025-08deba17f55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:59.6176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: za3MpB6YpBjcEOlKOyN+DbBwXohYDeXFvzuEquoWffbOlO7GafJd97GvdXyhJ4Og52dvrJIPab+jYXBpX+KawsYzDZfE6XgXCxomxBPhesI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5617
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/fsi/aspeed_apb2opb.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c=0A=
index 058abc8645..f2d9a9669a 100644=0A=
--- a/hw/fsi/aspeed_apb2opb.c=0A=
+++ b/hw/fsi/aspeed_apb2opb.c=0A=
@@ -302,9 +302,9 @@ static void fsi_aspeed_apb2opb_realize(DeviceState *dev=
, Error **errp)=0A=
     }=0A=
 }=0A=
 =0A=
-static void fsi_aspeed_apb2opb_reset(DeviceState *dev)=0A=
+static void fsi_aspeed_apb2opb_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedAPB2OPBState *s =3D ASPEED_APB2OPB(dev);=0A=
+    AspeedAPB2OPBState *s =3D ASPEED_APB2OPB(obj);=0A=
 =0A=
     memcpy(s->regs, aspeed_apb2opb_reset, ASPEED_APB2OPB_NR_REGS);=0A=
 }=0A=
@@ -312,10 +312,11 @@ static void fsi_aspeed_apb2opb_reset(DeviceState *dev=
)=0A=
 static void fsi_aspeed_apb2opb_class_init(ObjectClass *klass, const void *=
data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED APB2OPB Bridge";=0A=
     dc->realize =3D fsi_aspeed_apb2opb_realize;=0A=
-    device_class_set_legacy_reset(dc, fsi_aspeed_apb2opb_reset);=0A=
+    rc->phases.hold =3D fsi_aspeed_apb2opb_reset_hold;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_apb2opb_info =3D {=0A=
-- =0A=
2.43.0=0A=

