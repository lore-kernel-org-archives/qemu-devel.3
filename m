Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047860A2626
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=OTL1OAgF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEv-0000BG-09; Tue, 10 Nov 2026 03:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEc-0008WD-ML; Tue, 10 Nov 2026 03:29:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEa-0002z8-Kb; Tue, 10 Nov 2026 03:29:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPpVARrql19Wogp0Wdyii9Bemu2RQ11ZDtdrHkg1LlXnYrQTz8vU+6+L9x7q+/sexlwKcV1BJI9UK5veuvrUX69QELWijuoUb+KTfBMZvTel7qnNS1HfIeItMH2nOlifpz3ZAd3JbWVLExcDprbExXXlYslxAYcnHNV80uUADMMZFxFZPd51vP6nUDO1f9Oe3CGM2NX4qvMSFvzZnAOD6yoO4Ddgz3QrPQjKKX2UvUriTfkjZkCzqTItuc7IwlXS2HOj7nI2MhOOGTqxFpejiJiP9eIyngbcypNTmirTMpi3FpXqFQ/f9GHjeQHTEMa2ciCodRZqF0n193m2itgE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VAfK/1HC+33ODPlCYQRvLmu/zTLbyn++wPv4ZPQnws=;
 b=bZJ6Erls/2WcogPFwkQiK3glbw7eNATiWb9FYeqY/mKaJ2zq9L8ufbMdjq8eKznlykEY6Fw9qvRevcRbUCEzqRm2c15HGnkn16ZZ2rEBJQqFXQluWy0vmmcsD25DIygtO0HH4r7mpdIUf9PoLxzDTwXX4Dk7Q+NKidLul+UIlpjSJX0WX+u8a88M6s+upuECVJWkls+6GbgZ+YlnffcAxyy2Zzv6v3WnJzXWCcMxNYSTCYNc0AjawNTo1Zq7vEeBxDKbAnFQCqi6//+MegpRqDGlTsxUzUdXEJuqA+1EYzoIKrtYm0Fo7Fw/nIrlhE8VrLw5E+EAb2ZcZdhLLHsrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VAfK/1HC+33ODPlCYQRvLmu/zTLbyn++wPv4ZPQnws=;
 b=OTL1OAgFrpk30rdaiEKPhGLYYlHLrEFIvVKqbMfRxrNo6ZZWTXHUS4/zSaQYUBM/vM08b3lnD7bOrySpL05zhzPggd8ddVCb8qfqCee9lOCgpPHAHigHWY5p5kX/CWTM3kERrdwK8fM4Ru9mq3MC5qFMM+WKA7xpB1wKB/C0SmLZJnJ6c58qGggbPS6glFXmjy88unjCahnjZlnZqfeOoe4xD2jsCAnyRiaOF2/WnLxfhsyvO0Av4pCZX0U8bdgyHppIpKS91SzJUbqQ+LQMAlxD+TJqY5mWaybGBB5Mlzz7XJ1pjqdWCuBwKWcnVCYhJEfNtWVh8pPijnyrD0Y1cw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 08:29:26 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 05/12] hw/usb/aspeed-udc: Rename the transfer helpers after
 their DMA mode
Thread-Topic: [PATCH v3 05/12] hw/usb/aspeed-udc: Rename the transfer helpers
 after their DMA mode
Thread-Index: AQHdcO2XQRWDSBAqaE60nCxtfd0Vgw==
Date: Tue, 10 Nov 2026 08:29:23 +0000
Message-ID: <20261110082917.240329-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a6b354d4-3b43-4c5b-4d8e-08df3f04badb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099006|261026140227099003|261028144727099003|261009223027099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|10067099003;
x-microsoft-antispam-message-info: JJEi9Ddx7xDERtvokremoyF/DfhHajsDQ7nBDqh3/fQjSVXJcZMkfUAiaOtlICPzq5jvsnnZwSyHrhiLOq0/iQiMKAsjf2PIZJrCvcfm9fyz+HUnqMJgeCoqmL+TKg19uUgcvlZbEKAhhjlS/tc5N5jOW23zYL9iMsHZs0gpoqqqv2J1ys6F4ri3qJcxiunk94RqdTQvPapjSVJqhxkCO5DgMj6xtbK8zRk/Qlf+HHf3gaOaY1mkHWJHA15r7LVT1Em3Wgae5UCOYNJJLz98FwKfhqVtN5Rhmz217XznzKtEfJ5nxmKClL/+Tq85fKjUwGSmySnRWY/ryoXuZ3Yxr7qj+XSiug7J5YpbqT4d+jnDOYqt7+ooYcHGK0y15kIMryt+PRNVjij7GntyjWOPhYR0s9wSk2tC3DDKOF+A7bZFAHFaC3Q97NwdzkvH6s/uVUbsbv6rjgH3GRo1R96aCPnxA4Iv5oElJFBQZJsTB5AvB+4EdLpX/JUre1FGDsLNlOS8jqKFB/RBmEaqA49FmGpH2Mpeyb22MwKKFa0EI5cYK8LoVJ/PeLE66WhgpJ+VQcIazEwu10bLTj3OtuXGhw7AlcnJWcOwFy14m59ivlH4RGyZGdrz5KlGrx/ornP0EGQ3ZeQul2UvheTK9JrmcZ9qAZgu6GTC9PiqJ4FenKq5Tbm5SDGC1/Z67wEUf9nidfyemPHclgfRUEnDy7Ra1Ro5ooCSB9yD6IoWM+MnBuQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CkbP5OUSTn2hd8QPbUa6AxG1ulSakK2gnIcJY5ufoGJOrWU40XDuyA2RWG?=
 =?iso-8859-1?Q?UnXdGrkqAiEPdxUr+IX76n/3xdT35W98KGbVgsD90DbPZ8EJHMRfv6ObJr?=
 =?iso-8859-1?Q?MdSiosJPz/W9oRtVvTXwbYhLYQqH6V4/JyKEZ+LF/vb0vS+r/AX1Fdx6Fk?=
 =?iso-8859-1?Q?asXqsy3WyXaFYWRKDInaktOulB5plMek+Jr/m29AjvZSfvdPblyxDhxyzL?=
 =?iso-8859-1?Q?sWd0qrmiQWZjBgRSkbFPGDP5WTWqolve/aOK4W28Y6QcnkKLh+gpak9sWL?=
 =?iso-8859-1?Q?ZYbgOOmwJ4nFaDOXmzhEsnkxbbOkVb4UI9HU/uQSEvIGRKudyvoKVROOdS?=
 =?iso-8859-1?Q?hLvnq+HEvVjwPLp3T0b3mvx48hEluRycDCNX9BFwfJZJWo7Ggg20hJ6bDk?=
 =?iso-8859-1?Q?1dlLfHcAcS9/mUA7ld+dBFPg+WcUNHZlGsiGo/wrcLT3JxAMZvyMak+Iz5?=
 =?iso-8859-1?Q?qZ1C99/URcyxCbHZs+geUK2HYBqx2yTcu82wUYUhd5yJvO70Y1zl/2U6Ej?=
 =?iso-8859-1?Q?oIFmezGIZ/qfGSE8LtinzQIFe1UthRKMn9WNWKTSiqbjqphz+V5mAhJt+H?=
 =?iso-8859-1?Q?Kw1mJy66YiIaC/109ouaLXaEHN2sj0HF1cGLHpPTT60tS0t5KbOvWimrfO?=
 =?iso-8859-1?Q?+iSwgTTUDa1eBl3DxKSnAS3tqhXE3N1t4AMqc/YHP0ZREmT4MpqzNM/pPq?=
 =?iso-8859-1?Q?xl8jN0M2hGe8CHMivRhUEbYwsAEnTC5hGzu7TBT20jDtsXaJxM8U4t8px+?=
 =?iso-8859-1?Q?eNgME11U/QpGRmwC2m7VqWusTS1l734ZvykgRYqfmhJEqjCO1k3w/uGWtj?=
 =?iso-8859-1?Q?msaJOq1tXgs6FOnFPE+HAmDyeGjh3lPq9mtixs+gJeXvnzVOgTLjpef5v0?=
 =?iso-8859-1?Q?oC6e4WE+zxspWo0p+xYBkFd3CtFGytn2KQUk7PKXy7Nry2OEVxz5xNLw/m?=
 =?iso-8859-1?Q?H5kxz23pfV+LujF+jkoyzSMOUAx3hYq10M8ihcJ5Plawktd2cj5ZP3kPgo?=
 =?iso-8859-1?Q?cQZUDo+XG8Bk4JFL/XAxkdO6/NWhmHoF9eCViKwlXyjm9S83H33mRIpD+K?=
 =?iso-8859-1?Q?q+xs8jBpg5lvlxsk0jiCfmKKSl+sDosK/T5V9+ZTSbAjGokGqNZhFY3a5l?=
 =?iso-8859-1?Q?aCw8YqHpynkQjz+XxVcPfteUp9nJRZcfq8TzXnxpjDbTMBhUjsecM6Okv8?=
 =?iso-8859-1?Q?thoD32nkUSPE/aG9ojTLLMO+Us6WeR8aZeeK6qwWf4WeDO8NKBR3Owmn15?=
 =?iso-8859-1?Q?O7GsEMnLlYtnwydnAbV87gFBbjbWID6zVnl0rw7OkFcujYUWpXQFfqlTWX?=
 =?iso-8859-1?Q?x77qezZkY7n0bI+Q46Xg9tkfFAuP4usiLw6/4GgkVJJ9mmDssEpyvy7ToP?=
 =?iso-8859-1?Q?6iXN0hBFuyCa1Q4NxHcxFi8FgpdlaMINsHIcHO1jMnaGQGaGpJyxSxTWKf?=
 =?iso-8859-1?Q?qyyTIBBkh3X9fw5vtNrBuuAB6R644Y9HTXc3z+C1ozPi0PRGIr/RRk29PJ?=
 =?iso-8859-1?Q?MI6ZpmN06clLCpELX/+BK0mdT9pTlXOgTkcDRhXbtI+qDFZNuGG2ZLuUYG?=
 =?iso-8859-1?Q?/GOuLPBVlMlANzO7hczjlfgJD2dLMWFFXiGIdRG0KNPyFXseoAg2cA2VU/?=
 =?iso-8859-1?Q?5FLKhbzBKGOFa+WFW84JGbKwp4L/SKuOgLbp+pvEg9KpTMoQOzllcZI5Yg?=
 =?iso-8859-1?Q?F6wubCq3mkP7WZqUvoDRH/WOhlQNBlwDm9ZF7XZM4LASoXkF0LDHtCqFIY?=
 =?iso-8859-1?Q?RdrfxTe246nw8i+Njgclb3eWZvb6hrYxgQRZ0gG20+fFhtvVBfCdrGtXEV?=
 =?iso-8859-1?Q?xftPi5Axhw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b354d4-3b43-4c5b-4d8e-08df3f04badb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:23.7310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/hBWx36rce1PqkVoLhxV2pJZfgs6zG3B9v9x7TlOkK5AX/VGC4beHbTEeiklKREl/Q8dDKy3JINKqFc9wuppPpbd8QoPyeQwZfL8ihuFcw=
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

The controller can run an endpoint in descriptor list mode or in single=0A=
stage mode. Put the mode in the helper names. That makes the code=0A=
easier to read.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 30 +++++++++++++++---------------=0A=
 1 file changed, 15 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 2d024533e7..33a197af54 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -469,8 +469,8 @@ static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s=
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
@@ -578,15 +578,15 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in(Aspe=
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
@@ -629,7 +629,7 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out(Aspee=
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
@@ -659,7 +659,7 @@ static void aspeed_udc_ep_in_kick(AspeedUDCState *s, in=
t ep, uint32_t val)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         e->pkt =3D NULL;=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
@@ -681,7 +681,7 @@ static void aspeed_udc_ep_in_kick(AspeedUDCState *s, in=
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
@@ -691,7 +691,7 @@ static void aspeed_udc_ep_out_kick(AspeedUDCState *s, i=
nt ep)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_out_single(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         e->pkt =3D NULL;=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
@@ -737,11 +737,11 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
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
@@ -905,7 +905,7 @@ static void aspeed_udc_ep_data_in(AspeedUDCState *s, in=
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
@@ -913,7 +913,7 @@ static void aspeed_udc_ep_data_in(AspeedUDCState *s, in=
t ep, USBPacket *p)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
@@ -941,7 +941,7 @@ static void aspeed_udc_ep_data_out(AspeedUDCState *s, i=
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
@@ -949,7 +949,7 @@ static void aspeed_udc_ep_data_out(AspeedUDCState *s, i=
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

