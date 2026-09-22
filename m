Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E66BC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOp-0007su-UP; Tue, 22 Sep 2026 05:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOo-0007nd-1G; Tue, 22 Sep 2026 05:02:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOm-0002CW-A4; Tue, 22 Sep 2026 05:02:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7u1O3IJZxBiD3ItVr3xI4ZnQ/pFAS6OiUL0rOHS+osSdMPgkW2b6tFHr/YuuDkDkUxN5e4JDgibp3smAsD3eG4V9WPGUeVPxwziu4UplKynq+X8+Uc98buX1Gn+vPS/tkXHmuCE4JhkmAr083DS0NkQ7NjZA8+hZ+Qdy42gN46K98FVfwG44Z+RyN4hw64xKXOMDIahqipx+c4fC5smcHsuIgidI4XXeGVOC24Kp3oNrm3PkyjoKWQGg3tp4SlQOm7NeUwtPsoyzes9Tx2dDyvGuHOTZxRdv3Zz7C6TCuaZ9XJ+lkJJL4tC3a7wbbkxHZFTrURgzZb+D0Ue2BlVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfzX/ERWx5ePggKAIGR0DI4pPJm0KTIGaNFulqiCjis=;
 b=rk9GugZKvJknuGW3tPj9BkKYX5QlxJR3yHXbu4Ylk3i+MePsL2JhFrn7xjfzBke4PaV4IcaAxl6oEqoTy8Npk5Z/KwnUl10ZYbTe6udZRTVyhRRn0D2U6Y7miBJN0HqtIwNWcXHVhfMLM/0UeFQfA7mGTWgKuD0L3lLSYfhZZ7s+omH4atZ0gTfmelS+e6Cmjx4V+wzwh+cc9vDOrnLYSB3889Z120bqbyBL/9Jvo64ChR8ZJUQp08weL+6aD1PPkxrOweMfjlV0b2AEa663EkRe8l4Eauj+Rb9t89BE88XtTVz1CM7KEzELOo2AF/Lc9xK6w6T8et/ixanvFOlUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfzX/ERWx5ePggKAIGR0DI4pPJm0KTIGaNFulqiCjis=;
 b=Es/vGhrR1DYPopNFpmjVbtYsOzKmvx/XNzdZS5RcyK0c03ua8unn0frYVosaRoBswwBGhykpvoAUEAP4te5cH1Ty5eb8hLKSIMAvcJIuayuQAP/S+h9NrrNwqdAEYXNU+YxZ2fD/+Zj8TaBX7SlobQ2X8Fu/0tfaznKTnLnZGRVxCrDkefCvaSfH1UPakWCDpevianwT+MuI2EWK3emVb+LV1WckmGgt0qeE9qPD34ecln3SLQ1r+iSBoKoAS1Lg2w3E9r9muOjMRJXf1iBI8FK6UabVaTafhx9Hlz3ZTyl8r42mj9Md7Pdjb0k4ddYJ0EIqkxSdU4spy0+KCFuOfw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:16 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 17/19] hw/usb/aspeed-udc: Add trace events for the transfer
 paths
Thread-Topic: [PATCH v1 17/19] hw/usb/aspeed-udc: Add trace events for the
 transfer paths
Thread-Index: AQHdSnEQKRfqOyMklU2V5oCTqcrJhA==
Date: Tue, 22 Sep 2026 09:02:16 +0000
Message-ID: <20260922090154.1792077-18-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 3af748ff-4961-4636-5755-08df18883358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|10067099003;
x-microsoft-antispam-message-info: 8CUBWFnISZI14EQkpXp6HjpUFL7sBYSuL+FbdIO3KYLVJhV627TwJ1Wi53YFBvSz7mC1qCOqIQGmR3Rkkhmeup33ESFEy9EVDDgfCTV9nG1TaR6MsBDvtKfcO2DBplJzFvDvN6gouC0x6uSzVFt+71oC5nl498BBJ4LGnv0O22Xh3SVd4MffktGtSSeNRPhV65OvilO2SJ+6dCKN478+wMKr+DoCUwE+VgIW0cFXIvZF63DYjcVi4O2XE6jCT3HeVVTdjkSngZwMuw9fKf+m5YBBHS6uADF9AfN0GkWiztWAtZDSP4ROkTXvf22tfw5aqVZndEjcvb8ikTe7X1xC7e/NByrkqpF8uDODNyAE+lR66TYogi48bjsVQPoda7TN7kg7B2VDAqxtEPHJE/KxRMucZTzgmF7WlMGjte32XjxDzdQROA4RN96j2vehtndYbXVDF9wpA7FgmSPMWBgVpAn0n6OA+ocyinq7hRsbIQ6RAkWVtzYILD6LuVV4ZNCUCHkIMr0ZhZcfgED87iWN8oOZR9q4BrWsRcltGSvwl8mddZa786ElYJpds1qerZGyAN0zYptQw9mwDlRjXn019jItij93X+wSDxVWy/0uaznYLS7HNo5SE2XCpjLhFLaEpfu5Rl3WSwVz01mxOo9JVxhAHSPDGBlmOuEzoMa/StDddApZvzDXGzhg27Q7vBPAegg8HAVV2DujIfJwceb+HD4Drgyw6QTQNzK2xELF0ZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nwMrqNqjwKUWtxWid0pqEfEtoNo6j/ceQ9Yc+ivkMzVaApqkYJNS/f2zgo?=
 =?iso-8859-1?Q?IqEtw6SpvBz6XAGfVBvN/qQK++v+/Ee9p80WXyj8mWnbxhnkFjwQJSrbD3?=
 =?iso-8859-1?Q?gG59l+78NRxH82SK2cG/64DY2imGispA5J4dlaQn+v0z0+a+zPFGWrya2f?=
 =?iso-8859-1?Q?YzPmgiCRYv2MTYtmfDEquU05+UoL9fKtTHeISCb8ICevkBR/Wv/2efUOoP?=
 =?iso-8859-1?Q?e1z9BQdWvKhvd6uFYl1zKrsL/lDS/c7m9CcelNYwV/KIIavHynwDL474a8?=
 =?iso-8859-1?Q?SRRgLL84o8TO8y9bnqVS5rDPKHj+/p8YHdrPNbbwlqXC9tSa2FXsOdp5Yc?=
 =?iso-8859-1?Q?grTpFWU7i199qb3hh7iGiL5LhCmu6FR2Q3UGAg8nsfpvGVMr6i4/2YmVxJ?=
 =?iso-8859-1?Q?yayNdnj1BsTbWFEYe3G7RPrFeoM1wtlsRBFeXeF32YALo4JyH3FRTFRm/Q?=
 =?iso-8859-1?Q?ORdpG0RtkAGXQP16QAZeOlcfALw+amuD0gkK/DSB7MxFhDsL0QhHpNhuHj?=
 =?iso-8859-1?Q?hOHQQY+LHllpyhzArKcUjTN1ScUr1Y/qWqzY1G4oq1JOxPXBMBeFJAmFgg?=
 =?iso-8859-1?Q?j0BO6hdSo43jL1Bz5Sqh5lzUbj2A2EqjPLbnBNzAz3heqzgcb0DLlQbe/D?=
 =?iso-8859-1?Q?GAWew1BOmhwnC2YTRxkjV0Gh7f55XKxLnaXMIoBgZwUd6LbVDEzj09Q/BD?=
 =?iso-8859-1?Q?ux09SpCVrrUaoReH7Noa7ScbFOB9pHl1WzKjmgHPJsYIxfQ7FeiLdZpQZJ?=
 =?iso-8859-1?Q?nmW0JQ9nzf89OVxw0sWBokWl9nY1dRkrzvc58X792+Swd0cI/xEWQdaOjl?=
 =?iso-8859-1?Q?eqSa4gAGExfDdGnyBBUb8UKfqA2sAgpiLCnUfHEIsAK8mumCxw1SKaLDPe?=
 =?iso-8859-1?Q?wmr6KzuYB2klQDTx99ehJkQ8M0Tp6Kom16XfVSmzcVgyFJgh9R1w1eXdh3?=
 =?iso-8859-1?Q?Gcfp+e/vM5okFs+GaO1WgSVCxyOJT8I/I/sveMPpc0YEiOtr1aOpbhWZbI?=
 =?iso-8859-1?Q?D+1+LGckjeqNvY7KfdDEmUI1A+Kze9ORisLyvHEOsRAfxQTrgS+0p6v/Hj?=
 =?iso-8859-1?Q?WrsncvbD2ABIpri4JqXHK7Wo8NT0b6/JaE5Fc4wxF7OIGkFgsqcPPA/EdL?=
 =?iso-8859-1?Q?jNxtsHOcxNafDln+6bjhL5dmYgcuAZcbHXMiAmKa9yyhDN50RuxXOWMOHo?=
 =?iso-8859-1?Q?LPgMaC/F+a7Mr7rgD9qOHOCNICJFQtmPOl0cOE4hjm+qrVn8HDO4PG9YFL?=
 =?iso-8859-1?Q?qUOsTTdNLG/YodqkOR3YGdITxpTLzMuRmTOkDZYsnb7J3OJWWYXmVJPztN?=
 =?iso-8859-1?Q?bwRHZb5OvWTI20YM0+rKtL+NRGWSQQKJR7K2lxVjN+3VKqx4nH+oEMcqDS?=
 =?iso-8859-1?Q?qpUSDNvEjYAnZW1833wcXvOxbsQj7G4KW+G3QgVUa66GDRzoc98q4S+lYQ?=
 =?iso-8859-1?Q?gXwJc501UNxELxV1w7eVjSQLOwy86pTY/OTWCcKAmJTPwjsnmCtVOiLncV?=
 =?iso-8859-1?Q?xqDBz6TTYYgTSe10hp6F3EWFx75XNXzU3UPaqL6odb4CJkxbG9dDl4fwrA?=
 =?iso-8859-1?Q?8Oj0Ofz8nLFcxX9RcUo62t0PZWf6aMXqnl2MxFAwub/Gt6lyqYQSYfwsd1?=
 =?iso-8859-1?Q?vzbM8g5zvrj6STD20A7Zf6FsWhMFtxNgaFGB78kwmkbGOWExS4XPoBYnT9?=
 =?iso-8859-1?Q?MUS4DZLSLe/hU8JO+75UUAkdQzEJ2dTUmq55sZGWJidngcLZD778sFX1Az?=
 =?iso-8859-1?Q?vR1nthB450eYhn8Yx8W4GtPUSoCTLQDc5WyLLJ2G7QqolzOvnIoR9hUyYR?=
 =?iso-8859-1?Q?XI8w7opu8A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jtK0/ZRO1Zgc/oOTBqJQU8YnQXht8iAYzHpnI/PHg6yhrUhPoe6qT2tvKPL9DgpTWKBfa/Rd6BnkZQKt2NqbRZt5/yb+tT0iMsKj4n1+ehDOfLr1L551RhZBkn7z6Thb4QDOZh7dJELhmVmsPujvxyRE7envGJnQQ3HKrePC10grpf5MELWPo8tQaPVI2Qm6NxiR/ih8hy8/WcXrtjXoEfIr0LklntvF8O1Nji3fgI//7CsoeDFJ7s1kUjVaZZ5XIkOod+I+VZC/ofXplLm1d9ScXtz6m1A35o99K/OJLp5T3wcD05VdyqJWszJ72ZxQjnj/yBot+Ee+E4ujbLlxXw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af748ff-4961-4636-5755-08df18883358
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:16.5412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2ojDb9U5c3cGbp1S6eyZvM3YsZ5EpsHCN6MTqyA07mPJAU7r1SeaUqjWW8wsv/zUjzBv+QVf+AI5uTfNeMYeVnAMcL5oyHVaQWfBVFrUXo=
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

The register traces show what the guest wrote, but not which transfer=0A=
path the write chose, how much each call moved, or when the host gave up=0A=
on a packet.=0A=
=0A=
Add one event per path, so the name says which path ran and a single=0A=
path can be enabled on its own: a kick, a transfer result, and a=0A=
cancelled packet.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 23 +++++++++++++++++++++++=0A=
 hw/usb/trace-events |  7 +++++++=0A=
 2 files changed, 30 insertions(+)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 09f5913aef..1c99e45d9a 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -565,6 +565,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(A=
speedUDCState *s,=0A=
         aspeed_udc_raise_ep_ack(s, ep);=0A=
     }=0A=
 =0A=
+    trace_aspeed_udc_ep_xfer_in_desc(ep, (uint32_t)p->actual_length,=0A=
+                                     done ? "done" : "more");=0A=
+=0A=
     return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
 }=0A=
 =0A=
@@ -606,6 +609,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single=
(AspeedUDCState *s,=0A=
      * buffer, and the next IN request sends the rest.=0A=
      */=0A=
     if (e->single_buf_off < buf_len) {=0A=
+        trace_aspeed_udc_ep_xfer_in_single(ep,=0A=
+                                           (uint32_t)p->actual_length,=0A=
+                                           "buffer left");=0A=
         return ASPEED_UDC_XFER_DONE;=0A=
     }=0A=
 =0A=
@@ -619,6 +625,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single=
(AspeedUDCState *s,=0A=
                                         PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
     aspeed_udc_raise_ep_ack(s, ep);=0A=
 =0A=
+    trace_aspeed_udc_ep_xfer_in_single(ep, (uint32_t)p->actual_length,=0A=
+                                       "done");=0A=
+=0A=
     return ASPEED_UDC_XFER_DONE;=0A=
 }=0A=
 =0A=
@@ -664,9 +673,15 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_sing=
le(AspeedUDCState *s,=0A=
     aspeed_udc_raise_ep_ack(s, ep);=0A=
 =0A=
     if ((uint32_t)p->actual_length >=3D pktiov->size) {=0A=
+        trace_aspeed_udc_ep_xfer_out_single(ep,=0A=
+                                            (uint32_t)p->actual_length,=0A=
+                                            "done");=0A=
         return ASPEED_UDC_XFER_DONE;=0A=
     }=0A=
 =0A=
+    trace_aspeed_udc_ep_xfer_out_single(ep, (uint32_t)p->actual_length,=0A=
+                                        "more");=0A=
+=0A=
     return ASPEED_UDC_XFER_MORE;=0A=
 }=0A=
 =0A=
@@ -686,6 +701,8 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *=
s, int ep,=0A=
     uint32_t cur_rptr =3D FIELD_EX32(old_val, EP_DMA_STS, RPTR);=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
+    trace_aspeed_udc_ep_in_kick_desc(ep);=0A=
+=0A=
     /*=0A=
      * A normal kick only sets the write pointer and leaves the read-point=
er=0A=
      * field 0 (the read pointer is ours to advance). The guest resets the=
 ring=0A=
@@ -735,6 +752,8 @@ static void aspeed_udc_ep_in_kick_single(AspeedUDCState=
 *s, int ep)=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
+    trace_aspeed_udc_ep_in_kick_single(ep);=0A=
+=0A=
     /* Do nothing if no host request is waiting, or no buffer was queued. =
*/=0A=
     if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
         return;=0A=
@@ -770,6 +789,8 @@ static void aspeed_udc_ep_out_kick_single(AspeedUDCStat=
e *s, int ep)=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
+    trace_aspeed_udc_ep_out_kick_single(ep);=0A=
+=0A=
     /* nothing to do unless an OUT packet is waiting and a buffer is ready=
 */=0A=
     if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
         return;=0A=
@@ -1155,6 +1176,8 @@ static void aspeed_udc_gadget_cancel_packet(USBDevice=
 *udev, USBPacket *p)=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
     int i;=0A=
 =0A=
+    trace_aspeed_udc_cancel_packet(p->ep->nr);=0A=
+=0A=
     if (s->ep0_packet =3D=3D p) {=0A=
         s->ep0_packet =3D NULL;=0A=
     }=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index e84561d2e8..3b828da36d 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -395,6 +395,13 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uin=
t32_t iov, int ep_idx) "ep=0A=
 aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
 aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
 aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
+aspeed_udc_ep_in_kick_desc(int ep) "ep %d"=0A=
+aspeed_udc_ep_in_kick_single(int ep) "ep %d"=0A=
+aspeed_udc_ep_out_kick_single(int ep) "ep %d"=0A=
+aspeed_udc_ep_xfer_in_desc(int ep, uint32_t sent, const char *res) "ep %d,=
 sent %u, %s"=0A=
+aspeed_udc_ep_xfer_in_single(int ep, uint32_t sent, const char *res) "ep %=
d, sent %u, %s"=0A=
+aspeed_udc_ep_xfer_out_single(int ep, uint32_t received, const char *res) =
"ep %d, received %u, %s"=0A=
+aspeed_udc_cancel_packet(int ep) "ep %d"=0A=
 =0A=
 # redirect-server.c=0A=
 usbredir_server_chardev_open(void) "chardev opened"=0A=
-- =0A=
2.53.0=0A=

