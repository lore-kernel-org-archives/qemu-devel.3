Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B4CCA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRK-0006dp-KT; Mon, 05 Oct 2026 02:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRH-0006bb-IE; Mon, 05 Oct 2026 02:44:43 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRF-00004z-S4; Mon, 05 Oct 2026 02:44:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKjoVEQ/G6mga9+jZBPXCQn4b5F4QLH5Vm9cTWMt3rwKuLRILDj23JYZ8rsFVMDAmUbEMU/mzugAhUazh2r9rOiuzXLp5pINJwln+40D+tk7R6SHLb4myvikQHHeCUzNw69Qbs9xrIj7X8FRBY8kZtwKnR4t9f9XCeDl7vqpEIshIY28hjbmz3Eu87249PwkgYU2MNYXhebioHbJj0EzdqWIdHiP5Sj9rPanojXCcYB6ME+e0NnCS3c8a1gRzQ/g7A4+fcyExwVwcwNBomKItmmEnYI7dt8QPP7biWuKhw8J1hM0K5LOnpFO+ajrCAewmgTdds0YijiMOnkOLbgF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8qAlsUrS5EBzuAdL+2YWqWu96JfsSLbYUfS9BawsUc=;
 b=CMR+OQV8d85yx2QjZjYrXV4MQtknmSBjgPmOwt/IE/EKacbXD99nmyyvY8MYJFtTFltttLokN5XFQL4b7vEho0jHKpcmiOz8wCD+XtBLDSVriaR85PuxhgnTT0KphaWuGJ9wgpxa7P0Uud2xfjNbb0zjM8sxvw5viLdXa992q8ZLqarhNUvdeZvwfI2YAzqqszW1qUyjrdtJgqMDUVuPhZD9BVzbh8b89Qaqr9xdKNYG1mGSw7JWhBP1hFT4dE+zbsyBsumgQrQC8YjItYBuGmEtwet4gOfwF82ASft0KefeC8GK7SZsUiTZXO6Z2ezKMkfVz4bBhqqY6Xe3CiG1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8qAlsUrS5EBzuAdL+2YWqWu96JfsSLbYUfS9BawsUc=;
 b=j9CXewx3UJnvdPdadGPg3SEfX+62t6+8jUZ6b9O15WUdzCaG4KNpspc4Nz/JQ9E6CL/bPSYTLOCqaQvFHvTnfrYRnGimJ3YkIy1Jtv8Uvaru+A0W5wqTI//ONCS9zMUWiXwDt6h23vTAvkN738BjsmHhMdiSBmTmXjGmzTVWHZPOQC0MPXJywIoeyNCxbt5BzaSLPYMfQaSsxC2VzqOpJMZdbkT5yceAsu55kLJ56kscdwsnGwCjyZYE4URoVER0lsq822hrePjBNOjRuzaVnzFLdwvNPZhVyByXuaF8gQffFulFXsVmSzT1/B+gqIHCLi1QJ3nDeFYwmc6oXbS3sg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 08/11] hw/usb/aspeed-udc: Use the endpoint max packet size
 for OUT transfers
Thread-Topic: [PATCH v2 08/11] hw/usb/aspeed-udc: Use the endpoint max packet
 size for OUT transfers
Thread-Index: AQHdVJT4GD6016aHRkGdLtI0bJ8j0w==
Date: Mon, 5 Oct 2026 06:44:28 +0000
Message-ID: <20261005064418.3060881-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c5c5e3b9-997b-4307-153f-08df22ac1b66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: taNAuEvrzUydjohyFThqW4pLef81IGuSlBdNnhs7N+D6yDivzYAwnK+SFUnVpThino2UjaJlyLenW3Fta/zL7fszdl1kQujnyzOVaM0Wi9gpTdSczLMRhz9Dcpgr1RqFQQyw/LGpPYf2gTuL6IUlKe74SPJweKEjGVdMG5d+EgN/02sfU5F176AqbHLNghgk0IuIZ3+LfbjqkcJrdd7c1mraC7YF4Ij4dVRxUyYjiwEcPcZU+jds+b3vhIm0QvorG86cDWaZ8cu3NFVqyIrbxZSPELbJej0bZ95z4wVUYqboJHSitNtojZalQVzs+c6aciyP3yiIsnmSogcirn5DVHLdLabdNjj2DD1gI9EuuMOaaguFdIRewugiMyxyB9C3iafBiSiT4vI+weVayxFzJZ3y0B8gbuUKR1iTBDLssvpsK9liWUPilbjInChAXqNzkfVWJVYdUDKyXCy9esUkBYWjR5VizcmrZXlHXolDoDczFxVyItWleqfo5OS61iHvHqujN81Jtw6xhmPErayd3nCvwAHM7hfQkO9r889uQI0gE0URKfWazUjN//d2nR+QTnrO69xIbWfb1uHSL86AXjRD+rF+1Uvah/uqyoYYS7WorPkN49fVF+56LrEScbO5Wx4PmoxUbRxqFdiBarxzlZJ52t5FTVRdFZ+tLj0VJ7bgq79Nay2J3R1nhpobR1x9dY+hTwaWLSqsrEO4uDxBfkWnac8cJsV7n/ed948RHQI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/pf8hjg9kZvaGjFc+yBKdVmeDc+5qR07t4//mGXcwVW7FeADT38QlfpQUr?=
 =?iso-8859-1?Q?2jOTYaSPAL7a1XYuiiVIU/IXRyigkn/HlEL3Ke7Fiv9twTDT1SahD7SeWA?=
 =?iso-8859-1?Q?6fpOYz/dnksTKmnFKPZx2mCvUXXSRJcibGF+fHvEkLP1koPmdn56RTcorc?=
 =?iso-8859-1?Q?/R722YmjYI9vcSK/cs38sYnykhb/DrAjEIVVN9s1qVHyGs9Mk80GUgD+4o?=
 =?iso-8859-1?Q?x06qG4CmpP+jyU0qS8EZWLTCzgSrHxkQyurhsRh61shDvUWzYPrhIRuE6i?=
 =?iso-8859-1?Q?SHTW/NCEIXRoAr33Ol7wmDNW0u3rC04qeCLvxc2Rh2oYLRZukQetLmmVmH?=
 =?iso-8859-1?Q?1jalCqGCx4CGaDBjUTMlWXAGO1pvZWLJtl+pawqeJ8NXIc37T2SWSkg870?=
 =?iso-8859-1?Q?8V9Ru7xGJOPQjmBSvdouYRwRaL1t1EmwS3XlRjI/H0Dac13fr+iE5evdaO?=
 =?iso-8859-1?Q?hDrLMfFOQra79nu40A2bpg2jhCGQzQ46O4QD5ASZydxaBo7vnWV3igJUvo?=
 =?iso-8859-1?Q?QCS8pm+5pcdfEWwDERWYAvU2cjXsE11PbeXe19lsr/aBozYw5FjL/2pc7H?=
 =?iso-8859-1?Q?zYr5AguXN26EZ4zyuSztTFoh7Zv7GT+aWTXKBSuhYgdy0TH+Ht+mEt3XO6?=
 =?iso-8859-1?Q?qAovX3J/p/cifhEhKlrPG6bhsssF/gmivDY20HOw00RJUhYTuKO6NVeZI2?=
 =?iso-8859-1?Q?sFthfIL4W9uV3nYyE/675e33CgiiOpELOe7mo4onbb68ZfLxQS4zmviZrl?=
 =?iso-8859-1?Q?8uRYV2vQQbxABBAcYXSa+Pka8l0byAWyPNbkGT44gclysGT67W8O3DvasU?=
 =?iso-8859-1?Q?bxTrHZQte+gyS8FnVc7dlnu33l/QLocPTT9EXmGBIdR0l2TVNnOwbHGvOQ?=
 =?iso-8859-1?Q?TQZjzpFyKP3RHtwCyUWSMYEZSeSjgvseOdEJtLBEBIgK8tTN6u7uRJSy/s?=
 =?iso-8859-1?Q?GL5MzSpE3lAiwBU8A+7vYH3DCo1VrwX1oOCsX71edAPxJuw4R6hnWxP5PM?=
 =?iso-8859-1?Q?BUISIP09yNjm3/LlZqP0JjiSAHrY8RmnxWm4RjYpFFGL6tGclqUQv1j7S2?=
 =?iso-8859-1?Q?CyJdX5J2wHdMw2ICcQtL5MXHwsMXtNIkeyhpGsMpGvJMuN/28CBE8siPWV?=
 =?iso-8859-1?Q?GQ/tfWKjlZzAzQwNmhqguAiSEVprJc16Nmoc59QQ5Aekly7iYrYSJ4MxwY?=
 =?iso-8859-1?Q?IWk7YSksJh7dEaoPnvwUqRWtjY4/dLJ9GIZ07u4RS0EQru2YLVlixezpEV?=
 =?iso-8859-1?Q?HLirisCrXaFgQ0w9rfUpZfJIhMwB2O0HvSZgl67K8uPpHm7jNcLuABXBOL?=
 =?iso-8859-1?Q?UZ6bQztMFqeSwfnBjoST0G989wdkAxU8EJs568RkA6DRl4Y7qZ+lGx1By0?=
 =?iso-8859-1?Q?sotWwlamti1jlqN5XJm8A0UO7jIwEZgZzmSWGtM5+QPSBaML4RxspaqiXL?=
 =?iso-8859-1?Q?PA7B8EhBq9DmBZQwZAxBuaGW1LJVLZBqTam/4XjGM7j/7DE17FD2HX6m4j?=
 =?iso-8859-1?Q?AxyRQ4JO55USwXBNNRSIomIWhxWj/IB4EHBOQb9Jpmz0ZDSsUrYuP6W25B?=
 =?iso-8859-1?Q?z4IMLLaMucfkEYeoP8tMrfkm9B7COb18/QPfkYORbpZCHkSqd3ZC2qi2am?=
 =?iso-8859-1?Q?exetKOXEkpzNM1c8KQirwaJh1O5Aa8mWCLvLHrIXNfGvkiTdS0KwYm5tS3?=
 =?iso-8859-1?Q?xTNC2rPyWF4lzP7H+EBNXQG65VvQ0o6kE/u3bMZeBMQLyNWG6uX3HOTxJO?=
 =?iso-8859-1?Q?cagAoi66Utw9LFqwAgrNfc1Ct3aHFzeUEFYo5c50J0GxesqdPiz7AceMeC?=
 =?iso-8859-1?Q?/8p0aBvlcA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xDTarmpI0XLzRwwunidOJsY/Bn3ZD9EjmLvAXQKsez0xlfpCnDZOueKlzE/K26SqktCSE4p6py6gqwbVf7kpkJI5gE2BU4AHOmksTFokmgl1gwTC+UF8frIoNbzN3YjXMkIzj1zkQeYD17LvknZBnMHCVQVeCrGMtepfhYbHc1hNdJFEOFPaio979oLldtYFBARikuUqDhwtroRbuWJzoBqwyC2xxDtowyDQqMBul9p5M3YuiFKGS5EXMjUxaPBAP6ev61f7IlT+VUC3Sjh9EO7u1gCl+3NX0m4KD6ynn2NwkDAb8xC7Glj8AwwyAc0jWiLm6CV1I8OlU7v3n0RLJg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c5e3b9-997b-4307-153f-08df22ac1b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:28.4900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0EOD/hN4C+LJm7gXGZZp3qcwsljfI+RtcYwJk1Xl1CXqL1KqaTB30u6KYAhcQWC3KOA4sLhPl/YzFT9FgogeOj//IGLN3Fow60/uJY7Vqw=
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
2.43.0=0A=

