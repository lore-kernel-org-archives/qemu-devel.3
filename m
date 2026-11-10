Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5FB60A5BCC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=U6mtt2Xb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEp-00008t-JI; Tue, 10 Nov 2026 03:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEe-000051-GL; Tue, 10 Nov 2026 03:29:47 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEa-0002zI-Ml; Tue, 10 Nov 2026 03:29:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjFDkK3z0uGOGZ7hK4T3hLP2ajXAbWKBzJi6WMthH0/ceM1fJ8XBFJza8sxuk1oOafOTv4GkJae6ETV9i0mYJRX7LCpfIIH3ISl/siLjRea+60vPhVRZqxktxnFQVeMZOfbgHJ7sqijt0XGsOcaHiGFNwS6P8zccYtnbKNrnpNz92g/0ICO9Ec+xQXzuQrYbVINtF+zriCtaU1Hh7FzpAwlDEeONSk8JDS75GtmjE3KzEH2q02yeE1KceOLAVpTycDVtb5agi2JyrFQuWcffqcawiFGVyuJfFWlHGxoeLWBGLnh7BM13inf4RiS58C6qq98QoT3AVclPtY443afE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqX5d+v518O1uOl33Ltd4l+uIXLzcZcq59Fu4qmt/VA=;
 b=Ixmo6kgD1rv7ssK959xZhFUnB1WE4qKZ8yIJ5LExs9+c7IB09I4MIELxpzV39W3NWXeOahlk+E2cBfXaunEUNW/EvnkgYvj3uMFeDy/R58Ld01ZP9vKwQwhm7q3LmSu3kFHlaHv8m73lBKtZex3hHiplpBHcfLZIuYGe2jX/gDcEkdubOQM2buQDLI1i26/wdk39kwWOo1vEOtz0UJUGeUqNl/ivIo+8keB5Bgnbo9au5H4bN9GlnT0g7S35shizEqmqZC1XWy58d4OGpiyLCEm/51rcjy7cvE8amJhYkHyHzJXBFRax+itKuSo5VeG8qAbX4HpqMfZsI0nwAp/3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqX5d+v518O1uOl33Ltd4l+uIXLzcZcq59Fu4qmt/VA=;
 b=U6mtt2XbT1ctHVa4GhE9bKaLEYPEP2fjgKnmPWWtEg9xznuLSAbGZsICWUoXlNVxr3du7+y9Xa6a/tvZl/PEA8NXRhbonCQxi+V3iT6qe6C2tYtbn0pWtBujgFUaoPsEUcNo9sGxXaURi3Vor8kCcdD7ElCV46OcTZNx8gWv4ngXy2tRCWebt3HcdDq1gnV0bcWWcqt+YKDmtyf0B/Ci5diUpE2HvxLLtXY8yoMvI4Kh/qtv8hRAlnUm9NKyI2gLIrFheiTPq+W12EFpNVC085PpzGkPfLJutwVesurmspK/ijoXPudvu/PcB372cwdMx6iYTu/I2QlQUN9NTAjRag==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 08:29:28 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 09/12] hw/usb/aspeed-udc: Use the endpoint max packet size
 for OUT transfers
Thread-Topic: [PATCH v3 09/12] hw/usb/aspeed-udc: Use the endpoint max packet
 size for OUT transfers
Thread-Index: AQHdcO2ZCJSHBahMuE+dJ9XwKPIyBA==
Date: Tue, 10 Nov 2026 08:29:28 +0000
Message-ID: <20261110082917.240329-10-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6047:EE_
x-ms-office365-filtering-correlation-id: dca26275-0eac-40b5-5315-08df3f04bc9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099006|261026140227099003|261028144727099003|261009223027099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|10067099003;
x-microsoft-antispam-message-info: EZJoWojpGVtP5pVbpfn6KNGEgv2XwyHh/aWsr/0HUxFbPNTVglVA5I8ZQsRT+FupJfDcu1GCOFkrif6gk8ayduu4mGF8UUTfvBui7+0CNBMfBrJxFp2vxx16v9+nf8S5AS6yQf0m9nJ6yT9UqqWW2yrxBEJQRAZm1snkQgF9oN3HrJgQyb9u0/ff7m0RPsTJ7FhcanzHzpHioT1ul8kbI27IEdHkd5AuBjSRxx7F4gU9cxkQC5Co1navYQv3SH8fvUlaqHRovoOVd+sHeTcXZNefSecc/YZSgN4bhdW4Uh4k+kYU2Sp0ZapHlBdDdvOxMnnJGADC0FHdq3FBAFlo7W2IuMNwQ+7YXjIKeUEW3aoH1ycZYRTqKihsdRQygXg+cczdn7IF4Yfudh+16ExXiqxPXSw1xLWi3O2b7Y6nS8gk+kVhsnqx/3prX71OYIc6/bihJ4Cn4WrRdPjfVTJyxzfnxqHKu42kVhFdGwNVIz1dP9cXp/EImNVRaCgvkn94fkPg6gZoHWlgKBnQRr9/tbVrBKysiL8K90csUZnyRvZwQ1T7uLe6vQtOyVYVqY6D8O97jEl0hW8E3p3DRfQ8nitpI9JM0C/RF7CMtP6oHpwMg0VwDcRrxIUubAXTmyT1MOTOgXg/ZGVImkSP5sXEu+KmH2VPxi/jDBbrbWyeTv3POODhVuom13nnx+U00B9lPXssQDT9GU6UKwefdgLYcVhsadFhIOOi6kmjKYSCmZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IcCFQH9T/ZJ14WjD0kVe40pMSLfgFzvhT/i+89PZRSkxa6yky0eJjeKHnF?=
 =?iso-8859-1?Q?czP681WIyREmyZv043Oh8wg75v3c7ECjPve/br8nr1NDD42aCaylKZWWeu?=
 =?iso-8859-1?Q?sdv7B1XN1l6E2QiMwvnVxs5qG19sxZOWGuNSesjrlKlNECYHOPuxnMP0MV?=
 =?iso-8859-1?Q?a53tTY+8qpT+c/Mt4hJksVOmrzHoKkwIRCX0Hp4qOPSpMcJelcmFDhXiS0?=
 =?iso-8859-1?Q?MjZMHYSuQ8qNeKU+uN/lFzQeBU/5Hhq1En1zbfkEwXgdh1Fixs/wyPTubC?=
 =?iso-8859-1?Q?hANkGXNCBEem+/3i1GuH+BsdEnMb4zK4ri6P1grG06Qm6k5b1lmA47UVRf?=
 =?iso-8859-1?Q?3t4ICyK2f6m54Ud6LC9RFqtR/0MuSJog6ZLUNl/YEefnjzpuqDyEX4kIQG?=
 =?iso-8859-1?Q?6XOxZFri4j8DLE18AC7vPwLrMPrRBEdD50S5pnmJ4MUDIXm8YugnSGtIMB?=
 =?iso-8859-1?Q?sg/eIT9oP3QDlwKHWNPEaL4U5xCxT36+cwVRKsliBd6/vDo8cjcGvMW1AR?=
 =?iso-8859-1?Q?iRFpGt18o08dKv9Lh9ComNPkWcrmi8sE3KxlFGKoGVVVbFtxIAIyE7+YVL?=
 =?iso-8859-1?Q?MeL6JNqczfWnSg9tWIqAIynqOKEiosNh/FYsyes1zytVN8DYXcLkd3UeOP?=
 =?iso-8859-1?Q?XuRY3qVRQki+nytMTdwxQS54VKGVeHyskN7ZKYTvW66uK3fz402uCaybwc?=
 =?iso-8859-1?Q?k/DSJrJfY0aJJRqExn+TZX+yOfyqs5T73AmVt3SdXjJ83Z+xr0e0tKJXGx?=
 =?iso-8859-1?Q?1buNN/Li5UwT1OS5FzQBP/t0hJVlRuAa1odCEB/7zsOqDEEWraebTzzK7R?=
 =?iso-8859-1?Q?wtiwdSL52nQ3h2Zww1q9HC2y+h2+XmsPPsgsA3afNYrUSMMSw/G4FpxCKg?=
 =?iso-8859-1?Q?xYZDWwiEKzrXr3ANxHvSNrPkSAudz09tnocVNVJ+diO7bWKfTWNNHJ0tCb?=
 =?iso-8859-1?Q?TZDUgIBHZM5JZSm8diVUgK6nBwxYMZGJH83eyg5vdZmFYNPu+eY8R5jxbX?=
 =?iso-8859-1?Q?XyvI5dOa8CqRYnar4DeOQOZbiDh9E5oyayjQXUp3eLJPZBikZ6UWn7WOUU?=
 =?iso-8859-1?Q?Qo0wC7F2BnoA/92FchWzmKejmTru3UIs4OU9/dLc4fTDBJ2yKZajy4yBTQ?=
 =?iso-8859-1?Q?lYZ5jVxDMrOh/WTYYP5yk2UREvxFxyoDZu+UD9Eq26FdfI7AsEp4+Xgf3t?=
 =?iso-8859-1?Q?hLFXNFyAzpZXzDmn+DMcLsFG/ucMO1ZFR+SqMDEkiD3LqjysS1gBKhzUaV?=
 =?iso-8859-1?Q?6CC92mr9fa+OUXyNjFxLDjD8wUxS7oGwPNYwCCTLone44iWXuHBegbPHBL?=
 =?iso-8859-1?Q?qRfwf+4q1QFEqO6VTlQA03YZWW3ixsHDIpCwE0mcht+LkXPQWdDGOfJ50E?=
 =?iso-8859-1?Q?CGCOkzbMgNYaVOLsCdyV27jCPMp+zOe9e9yBnRqLBsj9qOnzUHsPfI+znM?=
 =?iso-8859-1?Q?PYW92zUETC8EEbBIp3RCuMYXg4ShrqCiEQl/TolkKeWeylFT5GNzwqJbHK?=
 =?iso-8859-1?Q?vRzZcWpmH+a6EFge7xUM5kjeffYEu08NHYyTa3DDlppsTca7XSIWwtMUdd?=
 =?iso-8859-1?Q?6XQ4LUOITxff2RDTERfzro/l0hes9KA/bFGMbhrCpoSi2EmB/z/nxg2BdL?=
 =?iso-8859-1?Q?MMF52ayxNdHgIYx8/IShGHgw52lvHeKlTwNe/ofrL5l4zPm3DxrjN+/FqF?=
 =?iso-8859-1?Q?hCBQBdzGROmZaVwPieCBiAKluOhAasAaCRD+hjZqyhZfZDueSi02eHpAJn?=
 =?iso-8859-1?Q?0YvKs+BQwDcoKPLbZ3pKaEqNnQL9z8xkKPo0vlOnhX+O4GVVOj9DaUvfPD?=
 =?iso-8859-1?Q?y7nlmHVnLQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca26275-0eac-40b5-5315-08df3f04bc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:28.4249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpCp8tLvZWud43/pTTolfqzw8VMmAtjzv4LdLDMgk/gY4fVHdZz30E/nlZ67LE3KLDg1YVPhuLOtorhHIp50p/hQN4UBExTAKjT9y2IcEcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6047
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

In single mode EP_DMA_STS.PKT_SIZE on an OUT endpoint is where the=0A=
controller reports the length it received. It is not a buffer size. The=0A=
model took the copy length from it, so a zero in that field meant no=0A=
data was copied at all.=0A=
=0A=
One maximum packet is the most that can arrive, so copy at most=0A=
EP_CONFIG.MAX_PKT bytes per call instead. That field cannot hold 1024,=0A=
so a value of 0 there means 1024 bytes. The IN path decoded that by=0A=
hand; move it into one helper and use it from both paths.=0A=
=0A=
Take the packet size from the combined packet when there is one, as the=0A=
IN paths do. A combined packet holds more than p->iov says, so reading=0A=
p->iov.size cut the transfer short.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 32 ++++++++++++++++++--------------=0A=
 1 file changed, 18 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 1302b19a89..4ba55fd86a 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -426,6 +426,13 @@ static const MemoryRegionOps aspeed_udc_setup_ops =3D =
{=0A=
     },=0A=
 };=0A=
 =0A=
+static uint32_t aspeed_udc_ep_get_max_packet(AspeedUDCEP *e)=0A=
+{=0A=
+    uint32_t mps =3D FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);=
=0A=
+=0A=
+    return mps ? mps : ASPEED_UDC_EP_MAXPKT;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Copy len bytes from guest memory at addr into the IN packet, going thro=
ugh=0A=
  * a bounce buffer one buf-full at a time. Returns false on DMA failure.=
=0A=
@@ -474,10 +481,10 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc=
(AspeedUDCState *s,=0A=
 {=0A=
     QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
-    uint32_t mps =3D FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);=
=0A=
     uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
     uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
     uint32_t desc_base =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t mps =3D aspeed_udc_ep_get_max_packet(e);=0A=
     uint32_t desc_addr;=0A=
     uint32_t remaining;=0A=
     uint32_t desc_ctrl;=0A=
@@ -490,11 +497,6 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(=
AspeedUDCState *s,=0A=
     bool done =3D false;=0A=
     bool ack =3D false;=0A=
 =0A=
-    if (mps =3D=3D 0) {=0A=
-        /* a MAX_PKT field of 0 means the maximum packet size */=0A=
-        mps =3D ASPEED_UDC_EP_MAXPKT;=0A=
-    }=0A=
-=0A=
     trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);=0A=
 =0A=
     /* walk the queued descriptors, filling the packet */=0A=
@@ -634,19 +636,21 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_sing=
le(AspeedUDCState *s,=0A=
  * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
  * buffer the guest gadget driver set up.=0A=
  *=0A=
- * A host packet can be bigger than one buffer, so we copy at most PKT_SIZ=
E=0A=
- * bytes per call, continuing from where the last call stopped=0A=
- * (p->actual_length). The caller keeps the packet parked until it is full=
y=0A=
- * copied.=0A=
+ * In single mode PKT_SIZE is where the controller reports the length it=
=0A=
+ * received, so it is not a buffer size. One maximum packet is the most th=
at=0A=
+ * can arrive, so copy at most that much per call, continuing from where t=
he=0A=
+ * last call stopped (p->actual_length). The caller keeps the packet parke=
d=0A=
+ * until it is fully copied.=0A=
  */=0A=
 static AspeedUDCXferResult aspeed_udc_ep_xfer_out_single(AspeedUDCState *s=
,=0A=
                                                          int ep, USBPacket=
 *p)=0A=
 {=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
-    uint32_t chunk =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_S=
IZE);=0A=
-    uint32_t remaining =3D p->iov.size - (uint32_t)p->actual_length;=0A=
+    uint32_t remaining =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+                         pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+    uint32_t len =3D MIN(remaining, aspeed_udc_ep_get_max_packet(e));=0A=
     uint32_t data_buf_addr =3D e->regs[R_EP_DMA_BUFF];=0A=
-    uint32_t len =3D MIN(remaining, chunk);=0A=
     g_autofree uint8_t *buf =3D g_malloc(len);=0A=
 =0A=
     if (data_buf_addr && len) {=0A=
@@ -669,7 +673,7 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_singl=
e(AspeedUDCState *s,=0A=
                                         PROC_STS, EP_DMA_CTRL_STS_RX_IDLE)=
;=0A=
     aspeed_udc_raise_ep_ack(s, ep);=0A=
 =0A=
-    if ((uint32_t)p->actual_length >=3D p->iov.size) {=0A=
+    if ((uint32_t)p->actual_length >=3D pktiov->size) {=0A=
         return ASPEED_UDC_XFER_DONE;=0A=
     }=0A=
 =0A=
-- =0A=
2.43.0=0A=

