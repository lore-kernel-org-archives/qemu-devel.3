Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3697C98306
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOW-0007g0-RF; Tue, 22 Sep 2026 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOS-0007bL-Kh; Tue, 22 Sep 2026 05:02:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOR-0002C2-12; Tue, 22 Sep 2026 05:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0SGlgF1L9wWWa0FjdEZhTS93gwtiNyZN5V8d0m2IiqcfyTcrQacHIeutsWh/oj1FWzkNxSTjht+gbTBAnzJ54bCDgddXBg1pIuKFlX2mMFCfljtE0TiSLezZG6EBxevO/vIwXV3N91kEHmoAuOjfm+zrPNS/vSiwReiy2cGhXtPTGtomBP9oXlKLh8ZJ8QUZnKQPlAH+fV5ruAF6hhgxkqMPZHOIRvm59xHNMjmXggUt7E9qUXQX6L0+nQEBDtHSQJJ1i1628A+DitSxAuJDBXGsTlUatrKt+KMLlfK/AdwFEiJ7jiIiRtt/8eRPxuYQQ7WIgp2F5ua4k4Wgam9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMjKkC8fGMB55jrAlnFw4sa58GyIrAShACGkbRmHSPM=;
 b=IzdWiAtBU2d7/LLdTa5f76R4aLnhklwwioBjvoERh0pwMou0kWD3c35rzBOHRHSldQCEUHt2+KFYCjwg4V0lE937g2MsUGk1STfjMagRskYvSIWLsJdbfo0TvtXFpLmnvwU6k3wJJJ7WMXVBXOVRcefg1K5MLFdf78ew/fZqKN9a90ia/Yyn3fXUDpl6CNgsXfdVbVy8naCudhfvUVAIcSBc1stKlNVHFwDAz2sK6l7XKt69gaQCogNK8DPOtPP24e/udy25CqtKLsFvmbzeL8g2berSkkBDWAbVYiPXpDjhStS5+sVRRO9Jfsg6g8hSH6X+EAUkDCLYrVwZi4i/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMjKkC8fGMB55jrAlnFw4sa58GyIrAShACGkbRmHSPM=;
 b=YOfurx9cpZ8TvjTS0uBbI3Q30JJ7Gml4RdH9DatpdnMx8JMY9AT/BkEKONtLn3ZvPc5ka+9AO0N/cCLIqg0+xhGygvlYvZ8Ilz+A01Dmt7jMH5otUSOP6tcaGn3/ku6EF19hzXVG8mkG21/WFK42YER4oVWelbJ7RIJhry94RS9ymkcvry7FNKY5obrjfWu871XtJDS0cNKpPGFrqV6OSKdyJQO+EEN8n1vGhL09ugKZPrkbzHQtferh1CKsw3Z4XcQhLDskX0RFvy/SsLIJ2OjpnmF5FDrwKY9nQGmKiHshYpSlFtUG7yFpFAN+D49Rm4Gc7849lYy8z7lZoXoDRw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:15 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 16/19] hw/usb/aspeed-udc: Use the endpoint max packet size
 for OUT transfers
Thread-Topic: [PATCH v1 16/19] hw/usb/aspeed-udc: Use the endpoint max packet
 size for OUT transfers
Thread-Index: AQHdSnEQl2OWQ2eYMEiQGsuC3sIa3w==
Date: Tue, 22 Sep 2026 09:02:15 +0000
Message-ID: <20260922090154.1792077-17-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 813b1637-64ac-42ef-6d09-08df188832a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: n+TheskpFSXdSbH3wJtyjxlDV4nSfco+zaKvnIicsKHo8q5EMcgk+wdtT9ulK/PXnKHymD4RoWiNNqT0PlMYtkvVkYIMTyKvgK4RaZLriuUOd3fbpOZ0br8FuR+rxlO2nOJsApkpCRSo2+rm69TYiXQ6w5iFMxCya6QqL14oftJW+Q1YfR19n4NqYI19euy507yESV/6wIIeA2de6vSl4i7eHyWD+lAm2xHgmCPN4c3YhsViHkroul5qeTz+6rzyv5fLeT1T2cD3cZm7GdxMZGOHoAUshXBcRzMVrejZZ0VOthWemqkjxB3umZni33mULjxBUFVTX4Vqc4xK2QjFfFoUnOumPcseNptpged0KG7cASOaPPVqyfbKXWqJVoq/bDBjrq2eq9XkmzqozBs6czCJIL6GO0qekyETd0c/2zwcFBBfey6CApSJJJevrgqFsIgvvV1kvL7H8JxZyLV9EQ7UOAOfeprOh85/X4yCSFgYFb1dvfw4ju45wkF0SJI2hHtyA/CkCND1djfzqHX8+qfYmiD0XR+NrcQYoWjc44Wq2aeG6fPodLR8AqtQ7aTZ6r8t3NBXTCKG0rvr9MobD3rXKEVaYCswqY/Gx9VJz0UZV01X4Kue+fxIHYeYC3LYKHj8fEllzLgyJna8dPsN2dBO6nRHkju+pbvWy6b1Ys8oByOKHYgX+MCNClNGY1eaVtPTMR/52eRhaLI2gUES7uvlyiRhmqGN/sltkYNT5Yo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U1zF6aYgTy+W6cW2AYnEFxLrdKou79pD0qNAIaCtwxaPpZ9kbZgv2HPg8b?=
 =?iso-8859-1?Q?wB2t1gFHcV40tuIXzj0gCUqrqKsP1peOQO+R0qyX/sdYDVBRYQel8eTpqx?=
 =?iso-8859-1?Q?3AcFXha/q/iPdEjg8AW/zIHr8qmLY9+J4dZ7VkSSY6e+70WDLc/Zfq1AmW?=
 =?iso-8859-1?Q?J5r/eHdfJc8d9QIvjKydfPZEfFSbgAOSdNN1xawe3g2UQhCuJQykZi+QaD?=
 =?iso-8859-1?Q?lKztaofGrwTWGWz9REBtMv/Siz16wHnErfA8HIGjJwZTf5AvPGZkixGvMi?=
 =?iso-8859-1?Q?sdQnXIwd+TpuH12C8mxZDi0i0PN462tei6fq0hV9n7MJuD62qMv7B8qE8j?=
 =?iso-8859-1?Q?+hyirLVg3Zt9nTFXOH9xp5WjTQi6RytX8Vt0V0SQlu1fS/F3AlxM4tamhO?=
 =?iso-8859-1?Q?41DWQmr/L/YD8r+Yg1xPMVMt/ZKioH1S2CDmvu6aTzL0Mytyv54S0Ldvnn?=
 =?iso-8859-1?Q?O7sGoxihFC2vHg1tsBs1vzHFzDP42rOpT6S2ik8np7WR+mxzYMoWMgfRMO?=
 =?iso-8859-1?Q?m4mMfeuXIn0dM9hD0JsnEN3OIWXJUAoe6pCEegh4qW7w97OO5D0SKtZVFF?=
 =?iso-8859-1?Q?TAxJGT+jjegd95P/dqcXHHSJQ9F7mG0XGjxoNeCevyE/tEf3gE5DdR7lwW?=
 =?iso-8859-1?Q?AlDaEH90h8WvShHd4QulQ4ssgi4zE7KwUfwq8HKro5x33U7DU6CDv5+7jr?=
 =?iso-8859-1?Q?hzftgGHLczc5L7ZCK7sc5LD1t88oOEdv6WBZWSxX33+swWy2vZM3ol0yoB?=
 =?iso-8859-1?Q?RmXoN7eEfsY6EYvZcDRkvXohEwyG4ZPzZ7ir5xttmtj+8fHhd5vBQxAkCl?=
 =?iso-8859-1?Q?dNVVw4WFVbOvPsOD3TLNw34h2o3C9VqFWHKtSAN5sylV34rJEsoQa9WeK/?=
 =?iso-8859-1?Q?T3kS2Mh0KiRhAvAZZKVpTaYAiUe9RHwy2BNjTtMhvB2muASytYO+ENmgM2?=
 =?iso-8859-1?Q?c4m0Cq9voilb4asm1nvvX7Ll4Lln9qYniUXTfBOGv0Gbnn8iaAkHAFg7er?=
 =?iso-8859-1?Q?tmE+U1Lw9Ok6EK77d6Yqqv3CbnK5U2NAMdPxNLFI7C4y9xgZ340sQuLwi0?=
 =?iso-8859-1?Q?wMcbZze1BUH35NHx+UjAaoNbg2shBB0NhSoefK60oIQxsj0fMn3A/msRXY?=
 =?iso-8859-1?Q?X+tbEsVL2AojAVYcOvmF9vVujsgpYH+V8qTtnWj9z4RPfakTsWM/xvPH+C?=
 =?iso-8859-1?Q?HH6lhoAO2J28+J9TPHZcqmr/sS0VxLF8v8lEJxohTWgQq8kQgDWd8iLZ/T?=
 =?iso-8859-1?Q?oRnJueB5FXxlnswewzEv8hPN2XS4U79zPKZi/Bga1wKg4CQCVn+MvAv3O6?=
 =?iso-8859-1?Q?RqbtAsKl6EqHCzjIgGq9xa7zlfn0ht5Bl2TcFstN9TsXgp+9RV9e+XAU1j?=
 =?iso-8859-1?Q?6YWqU7oZ1/W6QS8AOGTjYo9id92EmtFeYxcI3WJvZI3gCw2DIwoXsKRgk1?=
 =?iso-8859-1?Q?KWnEYiYVj3MCXSkVygmJR63bcZQpY007rgQRwiAxcG1QFl7mK3GNMlmwuw?=
 =?iso-8859-1?Q?AJWJStzUAFyx9HqcWTwNn2rdRDJ1tfV3Z1SFqsZwpkfOIu5QTSIHHdwqz/?=
 =?iso-8859-1?Q?oUnU/G9dxmNTw7vYIAst/R/pOj3WLowOMx+p0wyqfDIoBWZeqKjyE+VEmq?=
 =?iso-8859-1?Q?sFW0oDIbonsnRzYOd7D53dJiczgOKIEDTf2WC3/hCz4ZFTvg+L1FfCCJtX?=
 =?iso-8859-1?Q?nSdLeLFoxGtJoSoMrWyzzwDAWCyOgdC3hp5BfH4LG6XCpe/s0jVO6stWtn?=
 =?iso-8859-1?Q?DOtWBgtViW0s3GMx6Qi8qUI/q83cNHi9Kp1zbEIyUK+skEf+T+/uIJ95ZD?=
 =?iso-8859-1?Q?j33Hb3aMig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cadtItPIJx0v2vwrB0ueSdhwf5acPAWVc1YPRJ7Sfmv1o8TqwOJbKXlRpOt3fbzlgU5ILksXfV3pmpJXQgvWjZLNS+a0ot9LBZJNWg0nGz0Yf/7XATpmuNxX6Ua1rqnm/E/LJNfNWkJzglDJFCaFWFK+0mVlRPX983zbiw48N8ZYZy0A9xEWxjSG+NHVnpxTU+6DSwwXlvI6sfIR60/ZO1SnwnoiRngRm3yor+booU0Efq3Xai8/A1wtPRpAvOWc9qh+tf0EdyLzHdPy0BgkaMwWTWpDXmT2M4ZNYaELTQLlAnYBsIoS+76LPiVYcsBKj/QQ4+Qg7R6rgdzEQ4s6eg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813b1637-64ac-42ef-6d09-08df188832a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:15.3948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdMBt0FDotKgQOMtyQVLzPvYRx+YulrBcpINLnUdzAtG+2BY4ZH4VD0I1oegJZBsgpHzcoQPJKGeLR6cvI8ed4p4TgXbHFMbslA8cCxBDlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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
index dcced1b8fb..09f5913aef 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -416,6 +416,13 @@ static const MemoryRegionOps aspeed_udc_setup_ops =3D =
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
@@ -464,10 +471,10 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc=
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
@@ -480,11 +487,6 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(=
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
@@ -624,19 +626,21 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_sing=
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
@@ -659,7 +663,7 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_singl=
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
2.53.0=0A=

