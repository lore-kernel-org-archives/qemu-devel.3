Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFDBCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5bU-0006jY-FA; Sun, 11 Oct 2026 22:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5b7-0006UU-4n; Sun, 11 Oct 2026 22:17:09 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5b3-0004md-Ck; Sun, 11 Oct 2026 22:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+RKp1gGxRElPLLjSLxxUzTrnYiizzeSrLwLia2Bvzz1UR53lSzvmsLSiX+N+S+dMWxASIAreHuz0NN0TMyFOYrNG1EBoQLO/HVXdgTzEHeRUdho80Iv7UjHzlGyUgTjO5yX8nuljhIvUG71VFZ+FpzRpsL3PlIhC7p4wWVgU88uV93OvDNDbaN4pOUM5BAD1fihz0WrwOEObDiKMiqy08ZCgf26mKVoXA5KtX8OWHYsIy8jyX5PZaa82gRQ7VAxwkd64YzOeDn8kePSm8lNG59B5ExK6VxyyBIUTwMD3lAirMd+MlOqNep3S95J6huvQsTkUnxf6G5xCVe1x3BbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H8I24m5426+i1aDoskJDmikNzj+ATsq/pLtxTRBSwY=;
 b=ViYcIIvdv7VWD6A9CaNECa0ARrlT6b6QyLMdkNQ1sE7sHAZ0GRSt4LDpIoeeCUNjJmx8ztVbn2lijvo+QUFP/eLOPZUmvQIFXYblvFKl2wMnKBbzmwTeW0G3uF0ti0M+XuzDu/CP+g9uMGIvhtz4vsfWAQ4xZH/ai4CO6pQoRnakw1fFPz2I3Du04A0qihJUpAj3NuA44jSIe2GbfqClXnMdGKkRB1SzImzGkn/u5wdA1IsWenRAR7SHxNtgNNiuh018o2yXRUxWsx2yfkuG6mZw4Geu0Negh2VyiZz75EbZ3qOvS0J5Ii+9abE8kUVR2f9OOFZGI0sQHMcKZM3ZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H8I24m5426+i1aDoskJDmikNzj+ATsq/pLtxTRBSwY=;
 b=pH4nj/qtZ5qu7rUgi+fDhSnRKlm6ZRk1ZO4ymScrJdb7DPxcnwEjT2nySz2p6SaVkkcxgyYiQ0ikFKSEizA8kljl3eLxfsxZF2DzLkyd6xzELlCpF9QKnaqbh4byxQ5wf2qEpqE4TY6uE3Z3tHHVUc+4KY9ccKxUeVV7r+OJt4fJmcI4arFp28YQ1tb1lFy3SD0hFyf6uCO+ZfR3udp5AKpyxqAi8ED16ssSFtMWbQb8Ar4nAK6NQNBP1eiWSwro03vbJsUY/L/26KxQyrCcUxxXIZXT/fZyKfhZeSBOI6SjGkoxmp0TnGqntqXfTzKk9G4JdXsGTh6OptS8VFaD7A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:45 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 8/8] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v3 8/8] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdWe+6qk4kGTYvFk+bovQs9445cw==
Date: Mon, 12 Oct 2026 02:16:45 +0000
Message-ID: <20261012021634.2006424-9-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5398:EE_
x-ms-office365-filtering-correlation-id: 67de1f0f-f2ea-4aa6-dbad-08df2806dd0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: l7vxpk9obTmvcoKwavzE8pbaivurr7zf1A3nuhWEGd4BJTnIkHfr8HpQwwPvruBVOnPprjbGahw9R7+arJ4YE/mBeEk/c2ds3rKne71EBXxk/Y7s80toyME45foF4zB1ZptDvCPtPcmqu4cBMkvGQPgt+XhUbDxJtEDZEkszfRsOAS0cRsHcQ+kxs/ygWrGHUuNuAper73k7aL+YEAnUMr0TaoNH6juZp2ejDBlQh08VKShOXlQpjCP6pw3MkJzSRp9/voPSnU4kjuAnHzx9zIRiO4xgcdaH35VUeRmYZDShG6pHRQzX0x8diMaWd5Hwi2JzSbI5TLSlkwWFyvTc0bo7XLodWX6gXc1bGB1eJqtduldPJw9J+XvDnTBq2Wp+XPcenIa1KZZ1PGZkDLTXBlj9gUnPQlS8eUrTLyfCdu+bRAvx76JkvPY3tSx9KKiDVVMwGN7sLc0+pY7uF86p5kXzBm9L2GKYfMrvLWdKpDR3fusrK9CoI4ZlAeZSbn/fAq5A6+uDzKoTsG+vaFNCtGtjFEixKBVN3vdcaxwDaFzXqlT8NcQP+ppr737w4UCSZv+gxlGUtx/56rUzsB2V6ewGqqrx+zStOzGyPEJXMZ6LYywmuhnqLItTT6TExpVC5Bgh17Yw/32LpBiHLhkACHj4QEYJeTjSsT4soq99ovLsyT+VbMMqqy4PwM2rzzNp11HCA8yj8ZaFVP3KdLerUs9J9HlUjkJH/byAKfNBHCI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FuORljytbnRpbSpcm2FYQapcQb/xmdiegkg3YsMAVwN7A4F6sWiBhhgrtR?=
 =?iso-8859-1?Q?cbDhqMvGMq7s2Jd3xVtQU7BzUag+OkX4v/akiSlAheHwkXfccyPgEm77tY?=
 =?iso-8859-1?Q?6n0ybaX0FQ3KEMvoEDRLHTGBuZZfcC8V1Zg7Y1ymOzCOqFmGjZfbB61XFi?=
 =?iso-8859-1?Q?h/uQojSyD3imcA+XW5kGQz1bM+cqTc5BYXf0or0bxF3M3XDXnQP7RbZcNW?=
 =?iso-8859-1?Q?ieNSVsujy1pznSxBGxT+yciQ+yjI715pzKE1AH1iNp0oUdwt9IbVIVju+F?=
 =?iso-8859-1?Q?ARtDk5P9tSZlR/uPOqkoK4tvJwmVJ7/jtW9W2VmRPrD+3pdi5JX/4A6oCR?=
 =?iso-8859-1?Q?t/RA7ugmV/V6ztMNh2892fEaUex+ikEumOEljiwfY2u7cA5YRaCbAiPHpo?=
 =?iso-8859-1?Q?J/p1G5CecsvPZtW7hYMNoYiz6/s7Xeyku2fkmTXX69beDsMeaW/4+kgriE?=
 =?iso-8859-1?Q?KOxX25PKvRadgLgptrwBllU2JBbwF6EzpMZMEUbPCJOHlnVtmzM6TpXbxa?=
 =?iso-8859-1?Q?QRW+eonwZJDr+aCJzxpvx+qRNd9f24kewDK+zEzd9d2Zd3QUPwgb6pgJ5C?=
 =?iso-8859-1?Q?YFbHzv8DiW57e73qMyb0MfO54CHzNsknsnpKTeEKi2amPqNEA5tMir9vpi?=
 =?iso-8859-1?Q?eW9+3EdXTGNPArVOsHZQFV+zrOcS9dVYk8hItUWEfUq//yuzZFO49X8/MU?=
 =?iso-8859-1?Q?Ef1CjqzYU631Ls8dfCAFLwRZOwav45hwr0P2qN7R9tYtehLuY0kOw9mQOq?=
 =?iso-8859-1?Q?M8asEv7J8CAgDSz03vmri4inecGdANMZ6Bg6W2vDib2gQSq7cJCiEuP5ZU?=
 =?iso-8859-1?Q?vzHyKKZcwyEBkC9slR22dyIBwc75jD2K4ysm9ahvLJCBD8CTqeUZNdWxu3?=
 =?iso-8859-1?Q?vf3s5uwszTYDFnpqCrTlITN61cG3QFNGDlp+SjrumRQrU03+i9cqEKBjrk?=
 =?iso-8859-1?Q?wso3Y3Qc12mTxJ8LPKBQiBzS4nGTXtZjTlgemjbfNdM7IoNbxTFuS8jMek?=
 =?iso-8859-1?Q?+YjhLmDTqMAauWxpmTxNIIw2lP8xVCl9MNDj1+aaJlTb2Pot1K27oQ5WxW?=
 =?iso-8859-1?Q?O+eKOWTMB4v4LpVfXUut/pBkiQVZOgEcTtxHHmtes+kgteiYBEEmLZVC+6?=
 =?iso-8859-1?Q?b71FznP0KoLfUF70fJtsHgarBczF0Iw1o2Vs6r2yx9//+FlQEfdIsnb7+/?=
 =?iso-8859-1?Q?EgGlOLiY8ik1uEBCKz6fFy4qKNmf00m+R7nq9w1+c6xswB2JeU/LCi7OdF?=
 =?iso-8859-1?Q?+RNThoOxaTUxQsUJ2e9Wix5gPQc0La9ouy95xquzPpdT68d0y758tydnQi?=
 =?iso-8859-1?Q?jNjlc2yZE4qTw0G0kFhgX4e09shPltw4a0HV7BiAH0rD/3Cr+eSd6UGjMR?=
 =?iso-8859-1?Q?e9xhzdSVarMRt2yBe3ys7mOYg2IjE8AgRQszS2lDqrsmlqkmRAL9FONL7+?=
 =?iso-8859-1?Q?HJEy0JWqhMWWiiWcm91d8XC4UZ1mgiXcqimAr2fdwhkgaFknHk/nuk0QZp?=
 =?iso-8859-1?Q?/sFjFL+DlUgtDeXCvosHsb97RKt0k2+G2Egpwum0pcHdBjCB8WrF7lyefG?=
 =?iso-8859-1?Q?beWo4bVQJM8GyvW9rOiw74BV3ky0tDhUcyheEv+vjxT8boM5euywuk0ZHn?=
 =?iso-8859-1?Q?dw+2SptHZk4NBzJFNRPK9WB+PvRbMcAXi8j+EHRjg3ilQjQRkpYHTPcux3?=
 =?iso-8859-1?Q?FGqAKgrInrwyh0iZrTUNRfYi2ExHgzuUKeXoJUT25B79syXHWR3ifhuhxX?=
 =?iso-8859-1?Q?huui0L/i4fbLQe8C+mtYD4Axv3Cf5duEfGybrqLP5+dZu+ME4WtOo7NVYQ?=
 =?iso-8859-1?Q?YkBrTurAtg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ykst/nb5kOAHFcgBF09+/fw5NxugW1vfsU7PJyQI2IoQplfXu/TwPkNX1hgz/9r2gsystNvOOUlj3o0/FUw5G7C7bEVPYWJyyQIHdTfON8HJN4gRk8R/7mxMzUVLBdRghQtiShv9Pp8CVRAG+RO5MRcvivoLJgYpmEN3IU/UbyfTEcADq2kjzoEzHXgyEP3W4U1BLd0/5HwYkyk9BOBunCGUSylDVEmhuaVJN3hdZeZX8HPS/vfDPuto7+75ziaOgR4wz5kgy44UyFwaeshq/z8tnE527YFBgbELu/ZcqHxi6ZxYRnSuezOdJd+UFOnbiOgiIPqN1flgv2Kz3htk3w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67de1f0f-f2ea-4aa6-dbad-08df2806dd0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:45.2284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnK5ZjYNpLScYMT2w1BkbFDZeU7eTU0THR0Yqau2f+uIje3M4NT84YhmIqOPMKRfgzJ7dCi8sH8+EH1zHMWdjLaq1UTW2eeKA0/ApJmxWec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398
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

Let the ASPEED machines accept "x-usb-redir-server" with -device, so a=0A=
UDC gadget can be exported to a USB host running in another QEMU:=0A=
=0A=
  -device x-usb-redir-server,id=3Dredirsrv,chardev=3D<chr>=0A=
  -device aspeed.udc-gadget,bus=3Dredirsrv.0,udc=3D/machine/soc/udc=0A=
=0A=
x-usb-redir-server sits on the main system bus so that the USB bus it=0A=
provides can be found by "bus=3D<id>.0". That makes it a sysbus device, and=
=0A=
a sysbus device can only be created with -device if the machine lists it.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c=0A=
index a7cfbd6c5e..fc27ac1788 100644=0A=
--- a/hw/arm/aspeed.c=0A=
+++ b/hw/arm/aspeed.c=0A=
@@ -409,6 +409,13 @@ static void aspeed_machine_class_init(ObjectClass *oc,=
 const void *data)=0A=
     mc->no_cdrom =3D 1;=0A=
     mc->no_parallel =3D 1;=0A=
     mc->default_ram_id =3D "ram";=0A=
+    /*=0A=
+     * Lets a UDC gadget be exported to another QEMU instance over usbredi=
r.=0A=
+     * The type name is spelled out rather than used through its macro so=
=0A=
+     * that this still builds when the usbredir library is absent.=0A=
+     */=0A=
+    machine_class_allow_dynamic_sysbus_dev(mc,=0A=
+                                           "x-usb-redir-server");=0A=
     amc->macs_mask =3D ASPEED_MAC0_ON;=0A=
     amc->uart_default =3D ASPEED_DEV_UART5;=0A=
 =0A=
-- =0A=
2.53.0=0A=

