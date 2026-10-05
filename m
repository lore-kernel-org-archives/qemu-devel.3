Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB37BCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRH-0006bZ-H7; Mon, 05 Oct 2026 02:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRB-0006Ww-N0; Mon, 05 Oct 2026 02:44:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR9-00004z-VA; Mon, 05 Oct 2026 02:44:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neiI6J/AuK+EfFitQkAasxWNywdqwwoTQ81MDrZvNB+uOBtfe3H3/DcW/IR81orwLAVWbSJgrmCTeJW+aLYWU7d25fmEt6rvh6g0Gt50EcBkw0Xm9wGyoc/v6w6m44DFCPCKOeDuZyGjsYehXYgBrfZMk3ekpqmE6ClE58SkdUWYvW2iBPF5jye0dbPwG8Y/tkuWWu+O+rjg1xMbEsJ57WIWLez2zDo6TKP38iSKd9Nlp+0CFgSzwd21k5jN6qSWC05pr+q972yA/GxBY4HlW/8WC6EReHh5Nc5jyIbCnn7NS0efc8bPicqU+QYf70je078OMMrWOe+OmQ0d/hoXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrLtOZDc7y8p5cnANqU7BSpf2kOxLULal2mQg9Deg7Q=;
 b=s4le1K6vf4ncRnhtMTM42IjgYrfsGey/A13Tofwd9Pcmz750/d+Q7Ez6GH7HoYkngEp8O4Z/OU6w+y3gzIECXzH/o0UWJ2E3KkjLqpMyzdQdirgczDngOAwtHJBcb/jITkfkxHVxA+Z5QYWOvPJ+ThGGhRIdwlJQtmDymn+iAGyvEct1xnTpkAPO6dj2EftcRKi8iS/YuimD5VLldkUdbgLW3cl4y7gXbRZ0kOJ1S0v1NXG7nJJyBcR+Ju20FJTVZJ+jfrEMYSY4AolZdOq89NJ1Bq/LxHpMx+69/v3YGJPX5u+oht9E8CkQ5oL2ZJlG60v3Z808ZHBHf5ClVhjt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrLtOZDc7y8p5cnANqU7BSpf2kOxLULal2mQg9Deg7Q=;
 b=jTv+ZN1sBATd1k1w2DXxS94pcSJjSm4Ud5z2R/TSP0jWP4ryy4qUhBjWGT2tynjs750VR0vjCL/6A7C963UHw36RQ7pYItAcUHKzGUF9vK9lAoMZFgIqKhlCYV7HJw9YgvvCQToCHj2t3Pa98D4AdQ752BIO3esTXEMqgyIm0tcjPywECPQ+y2jm0XvdVpjq9WPNJ9VgTzTCxxS5W5EJG/1dh79bHyUh0i1PE+FLbKHavz/rDGc3ra1FXbXSBYNKE2zIBShXa/ZyiKi7VCxEO9ryVRP8r+WoNuVAuQLzBm8G3+V9GQAXt0TSLed7MY2xY4f8h3ic5JH5u4tJNV0h7A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 04/11] hw/usb/aspeed-udc: Rename the transfer helpers after
 their DMA mode
Thread-Topic: [PATCH v2 04/11] hw/usb/aspeed-udc: Rename the transfer helpers
 after their DMA mode
Thread-Index: AQHdVJT1i9FhBTFymkim+eR6NEvMvg==
Date: Mon, 5 Oct 2026 06:44:24 +0000
Message-ID: <20261005064418.3060881-5-jamin_lin@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7166:EE_
x-ms-office365-filtering-correlation-id: 0111aa07-b3fb-4b73-59d6-08df22ac19cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: mDWsqXS2gZCJ3ChQbjr56VjhpdsyLiErRhdCrwzzkzpkkC05YqyiZsqDWHzMtxCgR2bH5y4bTr8ztmunmP2oSi62yccmkw1yqm180N2FqEiclKsuRpL02lR6SgCgSh3vvet4Ok5MkrUCW1KjvkolgREceF6fxrlx+EkVNkCTRYygY061lT9QYeQiOHIc9J3v0ln9AI3ZkEUhbaOWjuWsFgLF/flXlq4mmxuXUnaiTbo0zkgHnyTr6PGUb/d3IOn4gbeone7s5zTCdvlMoHy9Ii2eJc0Tbz76aEZ1/jXxqjlC9PAWfbV9w68tYClyaRTM4qOPaLvjVvaXeQIu57mHgGPEhASqC2PBE6o93TpciMBGt/bajnvKA5s5jOlXDNwIVQcBHhWZ4RdqD9aZbyPinOtwkkA2cqK78jxrEtkp3yRDmZGeEu5YJj2lYulj3ZumWIF8uLaWZCMIzxVdUl1kUR5ryGdQ2K4pDoKC4vgZZfy0Dm4eM1YMEu6H/M/50Ty1w/qSUPa5DvEm0g7WE0vSwgTfk3QYq8ywjWoG/725spfAQd07gXrKwEx6+FzjD1j+THCkXbZQh7ei915H2BTchlKR/H0eN2SyCi6xH7konO6Mxh8mecAStshV4ZT1tboOzrmG+4/qUXcETfYOeDkMvQyQp95NST4X0dKyEJ8lbGzb1Y8h1MtMcrqYAMf1aHAAyoCVnYmrFNZLlLXNqJbLUS5hkEcu2ZTlhIZnpRel+V4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8D25c9j1HjFz2J8Tynsm9iRk2h6a8a+X30FqeLeERMrYn7uHyukjckMUcy?=
 =?iso-8859-1?Q?3fhI7eDNeYVpoO5D/AH9NBDpkSjBC7bTJ5JxqstE1+uGBBjoLCFjKch2jz?=
 =?iso-8859-1?Q?DNKM8TwBnxJzdAUr2orQ0HCYsMXcC5XR6+cXk09WF5+Ho1XkVxiW+3pFz2?=
 =?iso-8859-1?Q?I0/q6TCgDyoo93yJfh4r9pLxrRVHjQwtznXdsyojx1a2SC14DtE+jHcco0?=
 =?iso-8859-1?Q?IKd2ZyeZ5sbgXprjMW0FtMOjsuKt7uJC7yzy7qhOa3swznh9BMZ8OWgDK+?=
 =?iso-8859-1?Q?/1j7a1Sohb/BNFXThX7Z/djyh3lW4+Ec9Ji0C8YlXy0I/fSwrw7Huwld1g?=
 =?iso-8859-1?Q?uhH9aFahU1qnnSV5P/xpy5r00cK0gqs5erd+02nNbjmfrMpXWlPuzrDYQ/?=
 =?iso-8859-1?Q?cPkj2sky8dMy9QLSGPNtCd7ly5FhZowtyM+Ywq4hKF+wu78MegJasYvwyB?=
 =?iso-8859-1?Q?s9MJL4/0bUdm2OjUz6tGm2UV6K1s12y7idrkCzEtV5EBYyaUp/KvtD0iZk?=
 =?iso-8859-1?Q?isBcRWHS7fBj2wgORYUz6kwleFu3yU3HF9C9Y/nKSWRQ6Gqeptc0m31c8A?=
 =?iso-8859-1?Q?VaVAGb2u3k8G/loMcsqojK9IspOosJv3ipWKGgthS+n+wUV02/eKGFSHLc?=
 =?iso-8859-1?Q?mes5mMpbpNbYAqMqdpYMM5rz21e2ZHhcmBtAv1Tg1Itq7K2e+I7kyII13w?=
 =?iso-8859-1?Q?f5u9xHd1qLD1Za6AY/rlaiJUqAJA2Wg6iPVH5aNTaYFDN6mTXUiCFzGvXu?=
 =?iso-8859-1?Q?HtpJ/WHnHFfjU07OFcWkfIWe3cJ2MEDNc5f90AZjUMeiK6/41q/lysoNEI?=
 =?iso-8859-1?Q?wzEcCtMe4qE7JPrq2zyespGeEFLO6BVSzjW63OpgKR6F3uzmc7Js36a4AV?=
 =?iso-8859-1?Q?Vxmro8kocsHJH6eqKpqCD/I6xfDvdb5yQ1cTGnItDOi1fendSEqu+ZQW7P?=
 =?iso-8859-1?Q?MheD8fECPQ1ADASOFKZGf4ukHDq3NLRCCKQFF1R4QeYogqVs1YF+gJ0RxD?=
 =?iso-8859-1?Q?lqEmrLCXp8VHmSdUnzYQ5aAl3z7HNwgriGOLhIQX0UiV0jh4i3rnvYWI1h?=
 =?iso-8859-1?Q?54/ECdKX6fS45ei31l+W0V40WOw0Xc7xOzEGdhb94rMSmCB9UAL8jF4TLv?=
 =?iso-8859-1?Q?5hEE4T2lEGKqbKNa4x4xt1vWNX/XQVlkRPJ5iTeLqVbecNMf3cQnT4WU1X?=
 =?iso-8859-1?Q?hu45e63oooQVDeXc+8RZHzLPJUwIc7/XfaycWnGszEYKjraKr65n9J7Bg5?=
 =?iso-8859-1?Q?wVu0V3a0B4LsFFa6+wfqsBKzhfmsYm3FKdBYHljgJHiMBvFqdF6pQb5soa?=
 =?iso-8859-1?Q?yI1WSldtRukPtcR3ONRaWTSiDTd+/KlLyvfmK9dknAEnyGGAJkwr6atuXg?=
 =?iso-8859-1?Q?v57tm99H4KFCGJ7fx7AUk7jImiy4KfYx7XAdLMxDykt0g6jQ4JwkUifd9I?=
 =?iso-8859-1?Q?dUUPDMeOcGQfYsuw4jF/qVl2xMz1AT6XB0W7M7ZC0ICcd3VhXa8wl8n72P?=
 =?iso-8859-1?Q?8uRtFWHyQLNKWD035wkwcRFBKDCGCdU4sDSXJh/x4dKeDi5gZWu34Mzx1V?=
 =?iso-8859-1?Q?wQTN//accYkJk2BabPAVJUkpZR+QWlgLBapwZRAf2/s6a+G0XKNeTOt4eg?=
 =?iso-8859-1?Q?NBR/a/oL87yvimCf9UHLttFRw+Pe9wOHWl63fGh/eBb9YZFu37zhQyQ6nd?=
 =?iso-8859-1?Q?mVPtEIJVxoOgaNSmOGDgx058X7AAQwkeDFYXlmFXezZPyel9ECirHlPWhJ?=
 =?iso-8859-1?Q?+noWua57wZdZ9IxYFvYqVOw8A1FNfFqYe3CMAmvYa0NpVor8PpJCxpXTeq?=
 =?iso-8859-1?Q?s84qXOWHwg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gqfSmd2Tw5b8H4GGtjQlzAz4IfO5+rTPUhuC28ix7yNfBzl9vAyhxLqL95sMD4ItGvE1aWsFfaTnUuSW7a48gawSSchJJIoXzs4EKAja6knHJBKNj57JBFFd/5MWEN1iuWXe73H9Lvzwi/8LJEiRpD7hR3qFwxPYeXMT+Ce1q/7ZPJsNWsjl35scMOeB0YTadOXNXjxmGPEP8DVGZnz7FFwx7Aeu4HHeIbK+td5cqfOBChrpknCKUmcS56EdETfSUkJkjlVkgYIiBvS3t5waD0y2hD+p1LgN5VdZwSuWKmkVnKWQcuimUHS3gMuHMnmTphwIMlO2XFfXJC3TXq03Fw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0111aa07-b3fb-4b73-59d6-08df22ac19cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:24.0818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hutBahuFJ0nAvLl9/XgHyWmU+vvsv5O/eg3uyvw5h3w4vuYluAGMqZn/BYu9DVxCiLSxwvCIzhnQE4Rh8fC+p6yLt2r6dXy+Iwsh1vjgmVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
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

The controller can run an endpoint in descriptor list mode or in single=0A=
stage mode. Put the mode in the helper names. That makes the code=0A=
easier to read.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 30 +++++++++++++++---------------=0A=
 1 file changed, 15 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index bdbd1a78b8..b43f077c2d 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -459,8 +459,8 @@ static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s=
, int ep, uint32_t addr,=0A=
  * This function raises the endpoint ACK by itself when the ring becomes e=
mpty=0A=
  * or when a descriptor asks for an interrupt.=0A=
  */=0A=
-static AspeedUDCXferResult aspeed_udc_ep_xfer_in(AspeedUDCState *s, int ep=
,=0A=
-                                                 USBPacket *p)=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(AspeedUDCState *s,=
=0A=
+                                                      int ep, USBPacket *p=
)=0A=
 {=0A=
     QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
@@ -568,15 +568,15 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in(Aspe=
edUDCState *s, int ep,=0A=
 =0A=
 /*=0A=
  * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
- * buffer the guest gadget driver set up (single-stage mode).=0A=
+ * buffer the guest gadget driver set up.=0A=
  *=0A=
  * A host packet can be bigger than one buffer, so we copy at most PKT_SIZ=
E=0A=
  * bytes per call, continuing from where the last call stopped=0A=
  * (p->actual_length). The caller keeps the packet parked until it is full=
y=0A=
  * copied.=0A=
  */=0A=
-static AspeedUDCXferResult aspeed_udc_ep_xfer_out(AspeedUDCState *s, int e=
p,=0A=
-                                                  USBPacket *p)=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_out_single(AspeedUDCState *s=
,=0A=
+                                                         int ep, USBPacket=
 *p)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     uint32_t chunk =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_S=
IZE);=0A=
@@ -619,7 +619,7 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out(Aspee=
dUDCState *s, int ep,=0A=
  * If the request needs more data than was queued, keep it parked and wait=
 for=0A=
  * the next kick.=0A=
  */=0A=
-static void aspeed_udc_ep_in_kick(AspeedUDCState *s, int ep, uint32_t val)=
=0A=
+static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep, uint32_t=
 val)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     uint32_t cur_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
@@ -649,7 +649,7 @@ static void aspeed_udc_ep_in_kick(AspeedUDCState *s, in=
t ep, uint32_t val)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         e->pkt =3D NULL;=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
@@ -671,7 +671,7 @@ static void aspeed_udc_ep_in_kick(AspeedUDCState *s, in=
t ep, uint32_t val)=0A=
  * buffer before), copy its data into the buffer now and finish it. If the=
=0A=
  * packet has more data than fits, keep it parked and wait for the next bu=
ffer.=0A=
  */=0A=
-static void aspeed_udc_ep_out_kick(AspeedUDCState *s, int ep)=0A=
+static void aspeed_udc_ep_out_kick_single(AspeedUDCState *s, int ep)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     USBPacket *p =3D e->pkt;=0A=
@@ -681,7 +681,7 @@ static void aspeed_udc_ep_out_kick(AspeedUDCState *s, i=
nt ep)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_out_single(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         e->pkt =3D NULL;=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
@@ -727,11 +727,11 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
         val &=3D 0x77ffffff;=0A=
         if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
             /* IN, descriptor-list mode */=0A=
-            aspeed_udc_ep_in_kick(s, e->index, val);=0A=
+            aspeed_udc_ep_in_kick_desc(s, e->index, val);=0A=
         } else {=0A=
             /* OUT, single-stage mode */=0A=
             e->regs[reg] =3D val;=0A=
-            aspeed_udc_ep_out_kick(s, e->index);=0A=
+            aspeed_udc_ep_out_kick_single(s, e->index);=0A=
         }=0A=
         break;=0A=
     default:=0A=
@@ -895,7 +895,7 @@ static void aspeed_udc_ep_data_in(AspeedUDCState *s, in=
t ep, USBPacket *p)=0A=
         /*=0A=
          * No IN data is queued yet. Save the packet and return ASYNC=0A=
          * instead of NAK. A NAK would make the host retry slowly.=0A=
-         * aspeed_udc_ep_in_kick() serves and completes this packet later,=
=0A=
+         * aspeed_udc_ep_in_kick_desc() serves and completes this packet l=
ater,=0A=
          * once the guest gadget driver queues descriptors.=0A=
          */=0A=
         e->pkt =3D p;=0A=
@@ -903,7 +903,7 @@ static void aspeed_udc_ep_data_in(AspeedUDCState *s, in=
t ep, USBPacket *p)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
@@ -931,7 +931,7 @@ static void aspeed_udc_ep_data_out(AspeedUDCState *s, i=
nt ep, USBPacket *p)=0A=
          * No OUT buffer is ready yet. Save the packet and return ASYNC=0A=
          * instead of NAK. Writing now could use an old buffer address and=
=0A=
          * lose the data (for example a mass-storage CBW). A NAK would mak=
e=0A=
-         * the host retry slowly. aspeed_udc_ep_out_kick() delivers this=
=0A=
+         * the host retry slowly. aspeed_udc_ep_out_kick_single() delivers=
 this=0A=
          * packet later, once the guest gadget driver sets up a buffer.=0A=
          */=0A=
         e->pkt =3D p;=0A=
@@ -939,7 +939,7 @@ static void aspeed_udc_ep_data_out(AspeedUDCState *s, i=
nt ep, USBPacket *p)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_out_single(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

