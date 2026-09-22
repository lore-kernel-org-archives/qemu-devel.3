Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE384C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOS-0007bE-0u; Tue, 22 Sep 2026 05:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOO-0007ZZ-AR; Tue, 22 Sep 2026 05:02:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOM-0002CW-LU; Tue, 22 Sep 2026 05:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGrFICWSfogsnq9P9KKs+H6kx4nJYipaKDZjjnWfu1Pob7oQrgl5HHW57G+z6Sd4LYVN8TNRH3w8RbT94gAyt68CD4qbtiiDNmu83p7yGELZxGsGvTiV+hK/tSPbjQHMu0vo3nGElCTB3whZChLJnPv/m6FFU+BvGhRdnIUzPQ0siDvGWQNnfToImyZ7Y9sb0gXfFPpVKUfcYCJDLwMZll8wGlzegxwGeQWf07nEPh87o8NtwgNNt2Jmdoxlq8y6or8bJ7YzKxk93UQHnVuSvLsBdLfrKXXwhLvuEEXGl42Eor0g4qkDit++gcmOn7tf5ckMlvAFslhlb5ywK58Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OoA0ur52k8rY6wNtRkAlKs6vLV9k+GzTYiZoeijQJk=;
 b=q7GuIKf2XUzYUsf8xCRKK/bNRKXlPgcm78kR9hf2DEk1IODekQJuV4BjmlPl61oRgNr2jMf0aXIhnt2YCd5gOzGKagI7vR063n9mvnMEBjtVkfil0WOTWnO4/NKYz0Gy4ZrYX2vexlu70glf470pclortMPOO+mmKnWuaWIYNg9qM8argKNtkFikUAZ1audumR5IudTXITAcDcBJ9qpk84TkU9vZpLv690F/WFfWiiUBcJVtSlStpvBHLyqR2rxX/IOMvKw3hiZA2Ct7HZSbONwQftjImEIoY9YIl4WmuCxoyXc9wgsRREPdAsCp+8Yao7TEHyO0YthVzSYkqbLVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OoA0ur52k8rY6wNtRkAlKs6vLV9k+GzTYiZoeijQJk=;
 b=Xps+KB3zdtwpQZ0AR3EVavqN3KWIAqVEPfqQgZY2ADspsgL2QeWvsyD9OyDvUM4bLNahqySMKjnB2dnifT+vR4T/NLcodXqXCHZyk7r4Ln/CaCHiAtzpFe7F924x9MrURSlToI56Qxx8O15enomWWvnNYxU4PB5RqLkwX0+xjvlldMXBBmnlDXb/VpJtecOelxPN9N/uw8fFmqLWw9+MrfMESs8PDVjCKg+Xu2YIlHTwV3+HTjiwHQcbWuyK4vU7eA4zrZjZ2DCVEYnpHWc8EVDHHDLXzCRK4PPQ6Uu8+0Jqs6S8rod8QG2M2W8w+27Kx3etTyYMwOppsY6G+NEddw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:11 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 13/19] hw/usb/aspeed-udc: Store the EP_DMA_STS write first
Thread-Topic: [PATCH v1 13/19] hw/usb/aspeed-udc: Store the EP_DMA_STS write
 first
Thread-Index: AQHdSnEOK+bZBA98i0WeQU6VecQx+A==
Date: Tue, 22 Sep 2026 09:02:11 +0000
Message-ID: <20260922090154.1792077-14-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFFE5B965AC:EE_
x-ms-office365-filtering-correlation-id: 01040a21-7f52-45f8-8d1c-08df18883087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|10067099003;
x-microsoft-antispam-message-info: uTdU0j4tcuFWR6a2Y3LcuvsamFsTGwGqami+Oji+VXGzoiZPBbrl188VQofP7BYbiUjq9F85/kRjreX5PrqmasH+vp2bodlG51XlOaEglnvIyxIikcKvYJyPcjc5C431wMwzv9s1fOZ6PKxAHMPFXazajfLgbjOPieMOT7/Cf7qJgkM9lc+VfTqS3HQSuGV+rwjQcdTm4fAd18eGMXnhK4RQ19Xos0phAqOfKeuZKdzKPZ3hhWMF4BBhcxNxVoq/e0SEY/uvCrZwWrT6GPWsZOq73b3A+dzqU3NFshCzpLaHvEHzhmBMsmhAGw7mumXq5sBnA1vpnGbnSbyocJcQPQenpMHP0qq71HYhy9he4FfylSBdXcQwlD2ogAkB4zzGwA+in1ZBh+YNjMXp9i2EpnGBG+DEfDD1o55/xNR9ykDFJ4V/XS6o6tnt6pUXOnPc3t50MD/fExgBdIrbPYorNAS6Kl2LzLC1Q9xFdguXualYMaJ9J8bkLisA95ZFtXxdUEDM07RlT5f2hNfcAkOmovzD0uMzRA32NsA4Aq3V0hWVHYnFTdjv6fPvd0ysTgHBmz/L6IUMqAhc26ApTzpHj3HSltTINUWdHDlDYx4bHAaPlILLHfggo1LEPyY+Iapapy/DWmWI0XXsxjoXWPai4v2f3eRFKg7OL8kI3ge62p4acdhmXh8GhY4imt7K4/dk11B5YsRYszg6HkEE4KFEU81TnENZ0odlMDgiH4sXgzo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SvwYKbGhJSFAYo9YgUSagHqolakidyI4srT/1ZzUD003s+fxaSs49qe8ee?=
 =?iso-8859-1?Q?QpH/o69IP2qFx4WdOIe5uv+DNpE8CUw4tc5TKkHgZ4+iWbbvLIf0BpEeFm?=
 =?iso-8859-1?Q?3mr/XJ65guSSwm9XPtaD/mUJB8nG9gerqPtvEzWrC2Wcn2a8ADgtZEUGN0?=
 =?iso-8859-1?Q?ssnmFkvPWmjh4oEnIISiqyugfOGUfyUybP+Wxc8Xz+SNF36MAbrpjZabyE?=
 =?iso-8859-1?Q?mgz1ID05SEpJZg60WsDgUjbUhLpzESCR8KhMziupzrZT4mdN2myyq8JpfG?=
 =?iso-8859-1?Q?8BmgtLrnfW2F/LzQJvoMt6d2gh43cEOiHQlc7VppX0rV3qwjTpQF1ucWOA?=
 =?iso-8859-1?Q?j3pS4tqzBu2Qsq+WEtwNC6jKlhpJygsd10pEoUwvT4r2f+6j8qImsVCTsS?=
 =?iso-8859-1?Q?K/7Df28kthkJO1+KoQ65i9DapLnmTCdXEbnpNQ9KM80aOGxqzVD+CZ6qsf?=
 =?iso-8859-1?Q?aXO5b7E8nbXT16kDQOzT3/O5PLJn7m2SJyv2NB+DWeaGCTQOmkzEUjkDCP?=
 =?iso-8859-1?Q?5Cndt4f4lepxcemEl0WpJ7dlC+ySqNh2hNM16i9b7kF1lOhDxLU28qEgyp?=
 =?iso-8859-1?Q?XEJmBfiCSBe5MPD2fi/NiFmM65S6RV0Tj9hjKZke+djIyj1mwY9dpWPKMZ?=
 =?iso-8859-1?Q?kVQvelul3gjPrLpGHShXsy+kDcmWuAb2mJswYDv9XdNRtkrpD2a1ufuXtM?=
 =?iso-8859-1?Q?glMhXKDWnd3m/LLB0FY5mWx0gyOiLrqqylrCOBDRUc8Nex/22gL0/drqdV?=
 =?iso-8859-1?Q?6fhC7ZjcQoXxWX2r1C8nthfmEHj4nNg5ptjNAO5RWkDVVcZ/3SPYFS02Wd?=
 =?iso-8859-1?Q?ft6zCSfc53aeuytNWMjoQWRuqsoABSm7IoR3ffqZ31nCroYhnQK0ByWAg3?=
 =?iso-8859-1?Q?u6W3QziyhkPrGBUWQY4wib+PwQNVAkm4GQn0exNUm72YvC6Um6GoNbzeLI?=
 =?iso-8859-1?Q?Cn8u5khjRoAFxOfjo05gpj/kfHcmvuZZ5LAwfbTcfvTB3pQv5WKMB1Gprx?=
 =?iso-8859-1?Q?OpeUoEfaF7WAB5M9Y+VRynMvOliLrt3amXJWgW1rJJrUBM9bBFFD/CAnUN?=
 =?iso-8859-1?Q?Digfsb3qJyvkamAZ6cJlpExKQ//xOwQ5LLusMClRwAn9yXQT77Jtqv4gFH?=
 =?iso-8859-1?Q?qlln5VHs8NrQOXq14giWA07NbhE0u/KUBK0cNO7GtN/rJCtkmrs1nM3Mn8?=
 =?iso-8859-1?Q?v/pfyJNsaOirnFTVpci7qRD5JJh3ZHZtIt6Mgr+B9utwwq+2xCY0N5ppyF?=
 =?iso-8859-1?Q?xOoqlUY+pNoxrye3u1UF5oGI8rWleqID1y1/x2D7xR3ApWXlg8Ptk4Oe+4?=
 =?iso-8859-1?Q?Evmtfkag/ExXMEDNEP7j0Q14gtKmBVUEE5NNhFEGz4UAaUE8F7fKOATEWx?=
 =?iso-8859-1?Q?0pSy8FNcwl+sbZoK2M9UBMVpwGYcx45yJBtUgk85snwFn5yc/br3efFY58?=
 =?iso-8859-1?Q?IiQpNIMcaDmaYtOZ7Iyr3Tt1pzJdrp6HC+EE9dbY33JKdrFpXNIQ7puSjf?=
 =?iso-8859-1?Q?uQHPCX0j24ek8p3gyXJFkNcnEGbK0mpPFoYlzLoa3+4pVDJg21VMmqGrWI?=
 =?iso-8859-1?Q?aahY0nUDitiQsx2jut5zf5luC2pMR2Iw0Y7vEzROtr11oZZWZFUaSOrK6p?=
 =?iso-8859-1?Q?b6Wzfq/lS4e+H3SXNMWsI99T3BWkrhzcoQaU7jMdW587AdRC9zflL9iicH?=
 =?iso-8859-1?Q?vOjNnPHQ/vTihuT1yjTA/C+WJQVTkPvRbK/neCalPLrV6ji/eF1Aj4us0Z?=
 =?iso-8859-1?Q?9AiY6rIBFjOI6FeDfTovi6XmdYbPzTzTDVHGlrcC0iRn5e/IhtVaSohIYn?=
 =?iso-8859-1?Q?N9xvnP/tPw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WCGGSMSiN3lmS8BqZi15+p9EwuxR+svh+Td9Q75kWgSHAMTvZw1nNCLYUHCetpQsCgb6lmbZB1wQvwmGXaz86gccVLYlkv8yG2iaUiQdVWHoXdgF3o3sqcaILYXkSYjRWp0Bnhg/3XW8pG9cRSApm3o1lorl3scz1QFPjpmJqaMpoxNbqLHv/0splctHzXYxsVop+F49WyoIwR7WQ2p9vDeHMJrFBW+3ACYb3LQcLc6f3Osbx1zHOqiH+nMU/XDsvTBOWf2g33JvgLPsG4Nnxg6VxtC9TbXQylkk0mbzR4kP8ya4uAP/i19xA8Fd5NjktR77BDTBeeO7q8aQu4Dolw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01040a21-7f52-45f8-8d1c-08df18883087
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:11.8266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+Y6qiIbvLc4Oxxa+uBd6hf42FAiAQ7d0xI4bH8j20KWcaS3ljmwzzqeJHvoXrZ9mN24isQmQ01aYQQsQWw/T0idqLT3lFYqjCRT24VzSws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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

The other helpers run after EP_DMA_STS is written. The descriptor mode=0A=
kick did not: it had to run before the write, because it stored the=0A=
value itself.=0A=
=0A=
Write the register first in every case, then call the helper. The order=0A=
is now the same everywhere, so a later change cannot go wrong on it,=0A=
and the code is easier to maintain.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 19 +++++++++++--------=0A=
 1 file changed, 11 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index b43f077c2d..4572914e16 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -619,12 +619,13 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_sin=
gle(AspeedUDCState *s,=0A=
  * If the request needs more data than was queued, keep it parked and wait=
 for=0A=
  * the next kick.=0A=
  */=0A=
-static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep, uint32_t=
 val)=0A=
+static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep,=0A=
+                                       uint32_t old_val)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
-    uint32_t cur_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
-    uint32_t new_rptr =3D FIELD_EX32(val, EP_DMA_STS, RPTR);=0A=
-    uint32_t new_wptr =3D FIELD_EX32(val, EP_DMA_STS, WPTR);=0A=
+    uint32_t new_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
+    uint32_t new_wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WP=
TR);=0A=
+    uint32_t cur_rptr =3D FIELD_EX32(old_val, EP_DMA_STS, RPTR);=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
     /*=0A=
@@ -641,8 +642,9 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *=
s, int ep, uint32_t val)=0A=
         cur_rptr =3D new_rptr;=0A=
         e->desc_off =3D 0;=0A=
     }=0A=
-    /* store the guest's write, but keep our own read pointer */=0A=
-    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);=
=0A=
+    /* keep our own read pointer */=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       RPTR, cur_rptr);=0A=
 =0A=
     /* nothing to do unless an IN packet is waiting and the ring has data =
*/=0A=
     if (!p || cur_rptr =3D=3D new_wptr) {=0A=
@@ -715,6 +717,7 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr of=
fset, uint64_t data,=0A=
     AspeedUDCEP *e =3D opaque;=0A=
     AspeedUDCState *s =3D container_of(e - e->index, AspeedUDCState, ep[0]=
);=0A=
     uint32_t reg =3D offset >> 2;=0A=
+    uint32_t old_val =3D e->regs[reg];=0A=
     uint32_t val =3D data;=0A=
 =0A=
     trace_aspeed_udc_ep_write(e->index, offset, val);=0A=
@@ -725,12 +728,12 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
         break;=0A=
     case R_EP_DMA_STS:=0A=
         val &=3D 0x77ffffff;=0A=
+        e->regs[reg] =3D val;=0A=
         if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
             /* IN, descriptor-list mode */=0A=
-            aspeed_udc_ep_in_kick_desc(s, e->index, val);=0A=
+            aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
         } else {=0A=
             /* OUT, single-stage mode */=0A=
-            e->regs[reg] =3D val;=0A=
             aspeed_udc_ep_out_kick_single(s, e->index);=0A=
         }=0A=
         break;=0A=
-- =0A=
2.53.0=0A=

