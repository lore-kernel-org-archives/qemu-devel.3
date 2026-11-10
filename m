Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76798606B9CB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=EGd1js7q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEc-0008W0-GR; Tue, 10 Nov 2026 03:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEY-0008Us-7A; Tue, 10 Nov 2026 03:29:38 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEW-0002zI-40; Tue, 10 Nov 2026 03:29:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol8QSd5zEynwp4kxkExP/TryLjpCfpfG9VWyh+qqQp9tq7WRs6opHPPkI6ij2/Nsz88vNGxd2gghNwIdA2bbxUgvSJHAAVxpNX6K0ctNhrx5BV8rbpfyntMvLzTidhYKTNseo3DGVF0jNOvcrVaBKSz1MoVTvuPqsUNryo09spmnwPCcm7kowSUN4TkYT5GfNKb2QUj9AvFuMDWXe9aZDMKkQVlUQpXAaTp9sPZOz1bKedoHPirCB0xfKP2nqOh7VskIiiL7gZgc9PtcsCycsshym+YrUlnrfmFnMGv9YfcTFjgbYSWo6q4VO96mZ9kS25FwzwVl6Z16YrrwhkguLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oZ4cB/I7Azt+KTwstyGpI+KOSy7RIPzjroVqzcFr8A=;
 b=xKfawO+pX0ZpD4wCvi35yREba3RPY2SwHmJiFknf1IIAPJ1DxydxROAe0Wv9NZp+Iz9FLOqs4bw3ISgr1OAWnnQpSC2CngKoLsEDWrICeEoqPA1HePT59bsufykglV4c0SCHc+jA+OppINifG+Maqs9B00ju9g48YpmNZ4eSzn1EzG6WOlzNEI5bVhocDhDnTQfwXvz8XBlbtDT4nlgxEFl96EJRbHCCWJ5nUUsU4R5cK8zvxlic8naLPkUjsbF16NSjffDovYgvRhrJ/Sb5HU1q+8khej96OD6jxPSTzUPydN3mGpxAu/CC98Qwoo1eqcZUSdrolhb+qbsNwzPneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oZ4cB/I7Azt+KTwstyGpI+KOSy7RIPzjroVqzcFr8A=;
 b=EGd1js7qOTXn2khgI4jwO0yxOEknfIHYx8G3WXn+TweUIND1WVj8ASU3nOzb7cZgJtGFueh0XC0DhDy3caCIfirM63oP8Gczj6uAFsEnPHsXN9A2v7Hs2DPKg9i19w9VLJEenBLfjjM2zVrxKyzF/aHmBwCfQeeqst3dpphfw+zVl01bJfILOWeILA6XFbGvXtMD4OKWMc/kvUjeH77rNe15xQAe/zsW6h7Xpi53LRVibSTNKvPoK/WoSWows1maobzwDl00Wbmf6vdct2iG4GCKLl70FOKjzUJxQEcBLMXTmAcfnYyPCRx04QNBDEL0l+1bXdZwmmpIB5+JL6cg6g==
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
Subject: [PATCH v3 08/12] hw/usb/aspeed-udc: Support single-stage IN transfers
Thread-Topic: [PATCH v3 08/12] hw/usb/aspeed-udc: Support single-stage IN
 transfers
Thread-Index: AQHdcO2Zcot6tJFtTUqUC3SQneEuJw==
Date: Tue, 10 Nov 2026 08:29:26 +0000
Message-ID: <20261110082917.240329-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 53ca3b73-ac0b-4eca-7622-08df3f04bc4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|261026140227099003|261028144727099003|261009223027099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|10067099003;
x-microsoft-antispam-message-info: xsF+PxVmSI+nXelBdxVere+Oi5ffWsXruDKkgN6yjP3ahxGly0SrdBYkK0Xe0ZsavuVpW2qKJSl6dO8Q2m58GkBrKO5stwkKy+up6F+3kkRlM2G4FehRV/X5E4dyfh6wxRdRqvfPbEyUMw0j1U35Re1qTIUo/1D9jSjWSi0bFH9dblFsPrZQYYkfrtEmP4gZ+Mm7N7UohWkByLonBvc9zYFEL1vDM6Hxk+Ig05Z7nFwWvhd6Rkz9XnUcOdbGf9AYV9wh874dnLE4E04kJvBOw+u6v6k5HheIzNg9CDT0gNdpTY2MlfTn4gWzH10hkO0Tr4WqzSfY8UhfeFxnb6B1UYp41+Au0VSkukfebJIlxUVC7M9mS/ItFYQSxQQTYH0ZhLD4HLPkASQkUCiPprEptASEpKIQsCKBeEp8teA0SB2iXJ8WBiQFI8s4XMo6doEjOAwDeYa+gIj8QvclXpPjh3dQq6v4keFwU2NmpkwV8FFaGAKQy8Pqi4VhgtjHFCZI2GATiGjH0L+WXvJ+V9G3Nk2F/O2x9HnR7QLUnwx+QgeKmML7x4m2pV+f+tPfSRxT2SUmdLTzXEJSvJVpSMfRXWAFLk0+VDG/jtUTwF1uRJfMxsB1YiZo8CUDAysmuOfk94zs3Vxq1imIC3uxAOwA+vs89Ywm85vE5vqMkRP0r6XPeJgOplsfOWGzWZ+QEwgCbodHfIM2qHcXZJoJvN4nkBUZKlz4gpiGIlbgsxgBilE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t+b4Wt2rgFMb2hUAdBbFNm9l0DxaJUejESifFQTDsfmEQ55ZJ0YEUvdr1P?=
 =?iso-8859-1?Q?vkPcnU4VHAKMTn9dp02DqPW7Py14DVPFMLS4q9Bckx3gjsnogmHvXm13rU?=
 =?iso-8859-1?Q?9W6SsKECkBQaCcOmMEI8VTrW6/qLHvbFiszlS71YQecf5u8sGvWEeGtOVW?=
 =?iso-8859-1?Q?yYSKqGq5kgkitCvJZ1KU+UItZJ5X60Xn5+2A9jDFpMTcQ9cNnLcQsqaVRh?=
 =?iso-8859-1?Q?OPo+D7UpBhMJ5GERRzi4NyzTIWXRDVZXtOQIGNnMAptPTPlb4RhKF22dhH?=
 =?iso-8859-1?Q?TU9OxQBBfqitQtRVAQDKzXYBrT0Fmaq5w8Ra/uBKc/UzynloIq4C87LbUK?=
 =?iso-8859-1?Q?BYYDNYTUHwTk3rSEo5dKxK/qNuEL+USPYbM5rbxdQ6cxos0mVHnszNtsKa?=
 =?iso-8859-1?Q?vftm9aXSjyItEap1IRhfhmi4E6C346jo5c+ja9JfLwY413cOAmUGhmsqF0?=
 =?iso-8859-1?Q?Rmpr+Kino8ocgFllh/2jNS7dRxUgNXARa9Pwxy5ETzLPFhrsXwWfeAG/TD?=
 =?iso-8859-1?Q?PsidJaigCkUey6ALgXnYyE718noGgPABcliW1KlwDMqy75Uj/+zsG75wys?=
 =?iso-8859-1?Q?zEGNi+YIkPV+yx9u5/2yyAEZb0tIvtngwOm5iGyCC1fPX+sXX3n9Dedpse?=
 =?iso-8859-1?Q?XxVjlr9ObF8afWSm1uA6DL2RTT/FyMYONmfHKUfZtePXh+rkiotRd64Tdp?=
 =?iso-8859-1?Q?5GqBB7fdWzjniA5Wt/j/irzx3ZtSe2W5+J6Io8FpGuI/hseGaCRHyoAGUt?=
 =?iso-8859-1?Q?fADK8btevJL2mIxGWSWAWwVjsQ3h+4Q8uhw7YKnNnObmXubDNfB9JgSBgh?=
 =?iso-8859-1?Q?LkdaKy38nPemAvsTMQTZDXDCPg6GWfGQP1SxH00BiIrTA6BZHnUfg5EjiE?=
 =?iso-8859-1?Q?rx+EqTIKmp401N4PNUmAnF/EUeisUbavytCSYzUJhHIdh9aoS4JcRiw27L?=
 =?iso-8859-1?Q?GrO/gUv9i4OlU5cuh16KN+PvHscmORDmGsIcRCgRUD0knutCwNsMGTTtbE?=
 =?iso-8859-1?Q?uzVHxUq13tbcCRs5gI306f6tVq+9htEdKr96RQCQCOAECgvG4Ulg1Y1JC1?=
 =?iso-8859-1?Q?/cFUPJbpOUwlJGDT88PAf8rKJ4xkmDVND2baWpM9JmSduAyuTpF0OWN8Rq?=
 =?iso-8859-1?Q?ZBqFGwRs9DPdRQ8xU1N+ck0dgbK1qBZBG294pej2YXrim/02gUdqVVbhmm?=
 =?iso-8859-1?Q?Sj7FoaPgRAqq70aw7xRCQoDPoElfPmHI0B4cC9WkbjQCUUsOYeDa++Urb9?=
 =?iso-8859-1?Q?S3Kg9k9OHIjEXGnXORACm4ip3v5BDSCULXDuth3Fq+XPXqcnYWetEfHOYF?=
 =?iso-8859-1?Q?GoF8jxpG+CgrVVfXMSEXODlhRAVou/fQPhCN+c2hwF4+7TBg5ZAXlz65BM?=
 =?iso-8859-1?Q?SbiBYsvUTd9b1LFxQll/fanJf8pgVtJMrzMjhYCBMXfHX6gefoXt+CjrtU?=
 =?iso-8859-1?Q?oXPYMWiqNLtms1fk13ek8RdweG11ZFWJx2r7hku1Ritco9l9cAfL9j0myA?=
 =?iso-8859-1?Q?6LHXEsdWZUvb5Hcu649zezwbUU3oa1JIqiPklm0iTtrhheUUGH0l587jn8?=
 =?iso-8859-1?Q?igi3eH3qz34M42+q/l5n7uEpGx+WcZJt98AO+hTpiENbXPXi/S/HXjMgUY?=
 =?iso-8859-1?Q?MozVerQqA3e8welCJEZOtUNnA+Ap6vKVXuhgwk8mBXkkLkbOHVwuX8hSRY?=
 =?iso-8859-1?Q?IdPrDzn316C2AJ2tFSdqKtSkNt9q+stToxeLxDiMQTYDOCSsvD5wf1c7wx?=
 =?iso-8859-1?Q?4m+IxddFctcYRb3Nn4Gu0tVc5FM4Jah7q1w1WQallfXEjN5+R8RMQ9+jDz?=
 =?iso-8859-1?Q?aMoNsWb8Xg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ca3b73-ac0b-4eca-7622-08df3f04bc4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:27.0293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Sz6vk4HSmgK27VSTfLE0OIgPenLWuqHHVHVcNqNFRmUxUCEliztchYEteiEKMrm9obPoxapNqU1N4kLWloOBneOOnw2z2ic85m2OBCmJ58=
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The controller can send an IN endpoint's data from a descriptor ring or=0A=
from a single buffer. Only the descriptor ring was modelled, so an IN=0A=
endpoint in single stage mode sent nothing.=0A=
=0A=
Add the path: one buffer at EP_DMA_BUFF, its length in PKT_SIZE, queued=0A=
by setting the write pointer. How to tell whether anything is queued=0A=
also depends on the mode. A descriptor ring is empty when its two=0A=
pointers are equal. A single stage buffer is queued by the write=0A=
pointer alone.=0A=
=0A=
The buffer can hold more than the host asks for in one request, so keep=0A=
an offset into it. The rest goes out when the host asks again, and the=0A=
guest is told only once all of it has gone.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |   2 +=0A=
 hw/usb/aspeed-udc.c         | 108 ++++++++++++++++++++++++++++++++++--=0A=
 2 files changed, 106 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 1cfef6dba9..e55c53d17b 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -53,6 +53,8 @@ typedef struct AspeedUDCEP {=0A=
     USBPacket *pkt;=0A=
     /* bytes of the current IN descriptor already served */=0A=
     uint32_t desc_off;=0A=
+    /* bytes of the single-stage IN buffer already sent */=0A=
+    uint32_t single_buf_off;=0A=
 } AspeedUDCEP;=0A=
 =0A=
 struct AspeedUDCGadget {=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 6231b96487..1302b19a89 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -576,6 +576,60 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(=
AspeedUDCState *s,=0A=
     return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * IN transfer: the guest gadget driver put one buffer in EP_DMA_BUFF, its=
=0A=
+ * length in PKT_SIZE, and kicked it with the write pointer. Copy that=0A=
+ * buffer into the host's IN packet.=0A=
+ *=0A=
+ * The buffer can hold more than the host asked for. Copy what fits and=0A=
+ * remember how far we got in single_buf_off, so the rest goes out when=0A=
+ * the host asks again.=0A=
+ *=0A=
+ * A buffer smaller than the packet makes a short packet, and in USB a=0A=
+ * short packet ends the transfer.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single(AspeedUDCState *s,=
=0A=
+                                                        int ep, USBPacket =
*p)=0A=
+{=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t buf_len =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT=
_SIZE);=0A=
+    uint32_t left =3D buf_len > e->single_buf_off ?=0A=
+                    buf_len - e->single_buf_off : 0;=0A=
+    uint32_t pkt_space =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+                         pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+    uint32_t addr =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t len =3D MIN(left, pkt_space);=0A=
+=0A=
+    if (len && !aspeed_udc_ep_copy_to_pkt(s, ep, addr + e->single_buf_off,=
=0A=
+                                          len, p)) {=0A=
+        return ASPEED_UDC_XFER_ERROR;=0A=
+    }=0A=
+=0A=
+    e->single_buf_off +=3D len;=0A=
+=0A=
+    /*=0A=
+     * The packet is full, but the buffer is not finished. Complete the=0A=
+     * packet. Do not ACK, and leave WPTR set: the guest still owns the=0A=
+     * buffer, and the next IN request sends the rest.=0A=
+     */=0A=
+    if (e->single_buf_off < buf_len) {=0A=
+        return ASPEED_UDC_XFER_DONE;=0A=
+    }=0A=
+=0A=
+    /* All of the buffer went out. Retire it and tell the driver. */=0A=
+    e->single_buf_off =3D 0;=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       PKT_SIZE, buf_len);=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       WPTR, 0);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
+    aspeed_udc_raise_ep_ack(s, ep);=0A=
+=0A=
+    return ASPEED_UDC_XFER_DONE;=0A=
+}=0A=
+=0A=
 /*=0A=
  * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
  * buffer the guest gadget driver set up.=0A=
@@ -677,6 +731,40 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState =
*s, int ep,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * IN kick: the guest gadget driver wrote EP_DMA_STS to queue one buffer t=
o=0A=
+ * send to the host. If a host IN request is already waiting (parked becau=
se=0A=
+ * there was no data before), send the buffer now and finish the request.=
=0A=
+ */=0A=
+static void aspeed_udc_ep_in_kick_single(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /* Do nothing if no host request is waiting, or no buffer was queued. =
*/=0A=
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* A kick serves a newly queued buffer, so start from its beginning. *=
/=0A=
+    e->single_buf_off =3D 0;=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in_single(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer =
for=0A=
  * OUT data. If an OUT packet is already waiting (parked because there was=
 no=0A=
@@ -749,6 +837,8 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr of=
fset, uint64_t data,=0A=
         } else {=0A=
             if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN=
)) {=0A=
                 aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
+            } else {=0A=
+                aspeed_udc_ep_in_kick_single(s, e->index);=0A=
             }=0A=
         }=0A=
         break;=0A=
@@ -784,6 +874,7 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
         s->ep[i].pkt =3D NULL;=0A=
         s->ep[i].desc_off =3D 0;=0A=
+        s->ep[i].single_buf_off =3D 0;=0A=
     }=0A=
 =0A=
     /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
@@ -906,22 +997,31 @@ static int aspeed_udc_find_ep(AspeedUDCState *s, int =
ep_nr, bool is_out)=0A=
 static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)=
=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    bool is_desc =3D FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_=
OP_EN);=0A=
     uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
     uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+    AspeedUDCXferResult res;=0A=
 =0A=
-    if (rptr =3D=3D wptr) {=0A=
+    /*=0A=
+     * In descriptor mode the ring is empty when the pointers meet;=0A=
+     * in single-stage mode one buffer is queued by setting the write poin=
ter.=0A=
+     */=0A=
+    if (is_desc ? (rptr =3D=3D wptr) : (wptr =3D=3D 0)) {=0A=
         /*=0A=
          * No IN data is queued yet. Save the packet and return ASYNC=0A=
          * instead of NAK. A NAK would make the host retry slowly.=0A=
-         * aspeed_udc_ep_in_kick_desc() serves and completes this packet l=
ater,=0A=
-         * once the guest gadget driver queues descriptors.=0A=
+         * The kick from the guest gadget driver serves and completes this=
=0A=
+         * packet later, once it queues something to send.=0A=
          */=0A=
         e->pkt =3D p;=0A=
         p->status =3D USB_RET_ASYNC;=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
+    res =3D is_desc ? aspeed_udc_ep_xfer_in_desc(s, ep, p)=0A=
+                  : aspeed_udc_ep_xfer_in_single(s, ep, p);=0A=
+=0A=
+    switch (res) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

