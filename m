Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9060A2623
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=QetixGRf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEc-0008Vm-Ao; Tue, 10 Nov 2026 03:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEX-0008UL-GS; Tue, 10 Nov 2026 03:29:37 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEU-0002z8-IW; Tue, 10 Nov 2026 03:29:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz0zwOm7/2ZCwD59f58NWezGOZRGj6oZlgflTb7gd6A1Yps2fy7NffaVADgM0Sc+5h4/uBWV3SNbJEvL251rIQXvcoq0rJERqHYnXMIfQLfhqhXx2h3JphvqISu5Bc+5WTyQMzqE1RKmc8MJzpyxrFwmjYIzkVsyjnKsYaSp7JGhBmMyaLzg9CC8XDz1KfcQotIJxFnO2DlDLc3hz6fejd+N79MDHUpZba1WEKy9KzAvk28JODDr1+KnA6zQwRx0tl/D+QU7Plg6srygE8Q1xRWvuuBltQW4iPQ49cq000kdnhk1qTEO7N0ADGGSBu7W4r3924p4by5sDJw7/kDERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgw5DxidbfmUiZwwBS+mPPMR7tuAb54e3ngY9MgY8Cs=;
 b=bL0YcZs0bMdjSHh7ruWVWVAhS9QALnzMhZ35F8GfZSx8Qcp21Hhl6ZT8ylqkesh3NNHgyYoQ1lfv+uSLIHpAu6vCvg3EN4brS8LdQoYdO4W3MZ5ngyAugZxffXJBU79ZWHisZp/hNfj3o1dJxu1zxO2bfwztXfupmv5mOLKu36Yv3j/54IfLKvBQULKwnfzBoaMBwOsmRuP5VTds9REJ+9kNo0J2k355lT21M1/K0z1aLy/zcTdgBEYf1MIYAxN20BoBJP6+3fFqUZvrH68Hyi7H2QyefjGFY0CIL739efLdVC86ZBy/v/xLgZS0tWy43OwKgCgQ6U0WWDsDs04yPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgw5DxidbfmUiZwwBS+mPPMR7tuAb54e3ngY9MgY8Cs=;
 b=QetixGRffu+0O7XSdJwY3eMnpLAO58+lsjaSGxC1LJU5AuDxBMYYPOMp9ZSJkGJWijjTSTSEdMFEtY4LnxjpjATlBReWJi1h9eWwxe6c1/Rvc2WSP+DRFyALjbYqSIjCQuftyneC26kSuwdEjR1AwGeBp7XIiKspYiUIsBF2GJJdEFHXyLXjPxhTJm8yd+WukFzYci/viKRUGcM4rHMJ4VYEjdhixMwj3cKrCel1DJOsXVnAXECKDR/V003Ro8uOA6CMrnt2nfifnNq3ApYjD2zqVO0Cy4F9pIs4AD8Bc9yzHTdhMDV057+XiQyLrKjN/v5llamG1lUVc18OHrnLLg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 08:29:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 06/12] hw/usb/aspeed-udc: Store the EP_DMA_STS write first
Thread-Topic: [PATCH v3 06/12] hw/usb/aspeed-udc: Store the EP_DMA_STS write
 first
Thread-Index: AQHdcO2XD8/flRl3OkG6ZpAeRK1MWw==
Date: Tue, 10 Nov 2026 08:29:24 +0000
Message-ID: <20261110082917.240329-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: adc8074f-ef62-4930-fc72-08df3f04bbb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|261026140227099003|261028144727099003|261009223027099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|10067099003;
x-microsoft-antispam-message-info: eQyD9rLfqfHjhJ39kd4RjMlJ273yoj6aIJJ3zkTPxKEIqG7fCvYDlrNn/JU9wxQ9IAQOKd/r2q7jGZgkb+K4iFgdOmqaj8dvT2L3AT2oR1l8fMCOQn550N2hqlbxallJoNUr2JEW+vZIgnSMOfRxD5OqkMqwpgwrUKqvY0dWoKRYKyqMrS4wlUCnsRNrOA0IvAn/XwWuB3JpMWlkUHyaf7A8kcerT1Mle0xz/SNtSO2osSkpTwVFwimiFS01jQ4wEInAwUFz3EdnigbIP3nG7WcAJb/bIDxhZ+xSwwR41+QPQJF7ZsoWbXqHH19ZS3+A8l5CnN8RUoaEXZXz480I+DAy0xJh2Sw2HbgT6cNLO+n3n3TzDuG74n/xW1flvu+rO8FN56F/35nZigbZdfnnywd5EUrRkNaICy4aerKkvbm6PFp1Ho9Wpwe/BzRzr6e4RijDppryil5U3iU42Nh4gj7d4gvfFfT2a5+J8P/eFELo+nSJ85xh6pbFVLeoE+YVkgUgM+DlHU0po0INlnBuANkGbgVVBZjnAs5QHfIXwISIdvIQwrMdsYvl2ZuRKQogXbBLs7GjoH5gdgnsg1eeZ7vhwnBB0zitKROGLPB8fnx3PuMaEC0gd8bsdfDaQP1mSj7B/xDvGi/EPwuhlYBSyOcO/MgK/1U7f+3L+EbKLvwuJjhjzOas0tDpbZTD7sGxBCNOQ0v5++alUCXV5BzWjJvEcfMU5t5dGqbw8eIHzHM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GmvJZGx7FahrqR5G0YaTcOfCiu+WXSe+0GNpL3qF68MP2T3QJ9Gm8PuaBw?=
 =?iso-8859-1?Q?3qlua+tySO9oeFjU4tQlhry40kfN6p0KjbkBvHlzq0yASn/n3ikI3Y5hXu?=
 =?iso-8859-1?Q?DoSgAhpMsWn24Hk92IhtXJ6UCrmHAWqu6PR/1A9OeQB6ShPlKsU/vGr3o+?=
 =?iso-8859-1?Q?QrngJM1Jw6EtMoptpvI0/B0eDFXkOT8M9nO5jaOmD6dWLDyju6UbfJmcN7?=
 =?iso-8859-1?Q?ZOdR+zXhgrwzqA7cVm2aOCOOXAIGJDUDNpb+Km2mstUAjBQhnG8pZLaXDX?=
 =?iso-8859-1?Q?t61S6kvJfZhpxtpPjUNxGfXCPMjKxChQVc5EJRSwDDrXNTI3ZGC6dP99xc?=
 =?iso-8859-1?Q?BsGy1NI6GP1Gor5YAy+fPh6XKctIsOmVz/afZxK3suTH+RJoggyqPgSAyK?=
 =?iso-8859-1?Q?rMJlXz21OyhYWyIs9AeTmtlDbGfpuIADFZ9q6fTCcal2jvQLaS4tmno5SM?=
 =?iso-8859-1?Q?ANiwaNCegJrhEcjXKMHuysMsQkOyraMxIwy4qol4AktKnU6X6lSN9jr3wo?=
 =?iso-8859-1?Q?PBDBfLwwOXjQJsiUw4DqZU+cq/AYc60VRf3GeH0Xp07fE25zUwQoWZgOKX?=
 =?iso-8859-1?Q?FFdBl3V7MEA847wa9QAm5xb1PjBhqGDyowj3Bh2z5iT7IcGHPZQn++TkY8?=
 =?iso-8859-1?Q?i6/U/C2S/K+EOn64CLQomMRDOislJxZImaI0vWEMQGA2Rc/YrdViTvBu0c?=
 =?iso-8859-1?Q?EwJNPR+WS14t/eyb1SVg74LlYJZoybazB1wFwgLNqgGvemJP+W62NYMK7w?=
 =?iso-8859-1?Q?jwwdnr4Wv3jYto9StID+dnptYvEPWWjstLpJbf4gunhMkXzPygh/L9f2AW?=
 =?iso-8859-1?Q?MHp4205/rR+AOSs5E+pV0wLJJkz8WNwav1GU50hR/zSbN662tNLSNXDqZX?=
 =?iso-8859-1?Q?m8cMC/kThGUawdCeVa/dLJwHDi6bUImyiVmY7BEbTHCXXMrngbKRAHgfIf?=
 =?iso-8859-1?Q?GxFd+fTAMaNS/Zqa867qd3H2MeXvyKVZxQPNTLW3fmexRRIgIrsI/4N/j+?=
 =?iso-8859-1?Q?jWwFaZPULllPFUHxOt2j4h55LeJot3utKzAR35ZPj/OC9WfwZlnP+95+YR?=
 =?iso-8859-1?Q?a1mAyEghKaTszccCI99MrNRl7mj2fnbPkp7/yuyoAWPxAw5F2NYX88hvL+?=
 =?iso-8859-1?Q?IVNEVF/98YfI/gzO93gJnFZ1D/nEXPIE7yntQ3dJQp9AbaxPaHsZ0+/WB2?=
 =?iso-8859-1?Q?lVOdRyFjt2lHDfYsR63qryJuBLCLqtoEqQhCSCCqeWbkKyLn0G25kRf+UU?=
 =?iso-8859-1?Q?HU8Epqt6trfZqCV1eEOVeDFo0i7zoeksNxueOUxZNDBh0HaGb15qokBNNe?=
 =?iso-8859-1?Q?F1h48vWTNIgrfU3/JkwIxFF6+U27gzlYH5by2nawb7YcZGy3gzojQg090f?=
 =?iso-8859-1?Q?FJFtYHfpzlp2yg/vb+zZJKMxHLlsuc47VSOJmhxpx29x1J71uoRWNsrmKF?=
 =?iso-8859-1?Q?j97XnTOikxxchRVgqSqsrUh3l/47wjE691fAr4Kdw4LYthEe61M81eRaCR?=
 =?iso-8859-1?Q?rCYt8ZiSp/cW3MWq3Mq1Zuur3Yd6s8OguJo50u4thrEUdaF2zNtpESSAfV?=
 =?iso-8859-1?Q?8zki3o9YxbVjQ2pQIRh+tNr5SQIrKneOF380+T+6v2hv3MWGLY7AHDOgHp?=
 =?iso-8859-1?Q?NW5DR5BPIeDdJvnu0FBamnFjHXlf1l6rzi3Z7wNatMIt4ozTOBv0VX2VU0?=
 =?iso-8859-1?Q?Sg3dUJg329x7gKZcunfswpmaa8e6GAInRBib6zIxvc7wy7vHruN0H9LGij?=
 =?iso-8859-1?Q?uTVMR/Act0ko1EGRuUg0Mwy9VNvSk8bpT/iqrTwQQ7clbfKsl87zRe3GP6?=
 =?iso-8859-1?Q?9S5Fj2O3Yg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc8074f-ef62-4930-fc72-08df3f04bbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:24.8191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bysQ5oPS68n24Hv3+UVgxOMalJ5Zf3y9I1MnJ7SlAQ8TSgV9DoTeGWRA2XmCQBJdA9Ti6cpKpSMiehBEJWr7Np0FuikE3ncGZadwQVx0s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6047
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
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 19 +++++++++++--------=0A=
 1 file changed, 11 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 33a197af54..5f7b9f94f0 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -629,12 +629,13 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_sin=
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
@@ -651,8 +652,9 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *=
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
@@ -725,6 +727,7 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr of=
fset, uint64_t data,=0A=
     AspeedUDCEP *e =3D opaque;=0A=
     AspeedUDCState *s =3D container_of(e - e->index, AspeedUDCState, ep[0]=
);=0A=
     uint32_t reg =3D offset >> 2;=0A=
+    uint32_t old_val =3D e->regs[reg];=0A=
     uint32_t val =3D data;=0A=
 =0A=
     trace_aspeed_udc_ep_write(e->index, offset, val);=0A=
@@ -735,12 +738,12 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
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
2.43.0=0A=

