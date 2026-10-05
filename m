Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9C8CA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRM-0006f6-Co; Mon, 05 Oct 2026 02:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRJ-0006cf-HH; Mon, 05 Oct 2026 02:44:45 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRH-00005B-Sb; Mon, 05 Oct 2026 02:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPl2scaEOrN5TQENSpwbVx+69+ELvC9qpoWke9S0C3h7+lE+mUh8q6ZhIg/VZ2v6j/WtNAfm2Fpb7CqXsHLLL5Q6Zw3ifJysvxkC02GSaSLJ9RpcusNnUPux9nVry4cHyKbwUBZielUbxWgnu2F7KEMapbdZIO1ru+HvKNb6aYhRX9OAHXIkhW0ZNBj3k/49lpH1RMDfrOear8JiQi7l+Q8gtOGftVbWGWREaw8E387XuGsx/vAhSLUEDIRZ8wUGUjsjxvz6Lnsx9OwZFd1WcgyIjCmrG1g6srkL/TWmona9h8MlzlWD6bvczi8n7EyN1Pkza7zIv+mNdvJc3L5zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNJWhLr9igZ2kB5vR+c5od9Loo0924fKdDn3NOBTHS8=;
 b=p+dfEUQrqUfnVkHB1NnU4i/nATNJzcMw2G9mCYy4SUoP7R3OkdMG615NQnZGKL3ZOeJgTwlSFDz+hVlhOdRVOkr5V4p+RLrkRYnPklUp2nCrkKpKRmdiqAtfQBy3emYd8H/YiNOsM6mbXHHqAtrQ9wNjZCLnRPh8psAcf7nMnYLmTnSwcBNWsJU1lGFO/vKzFIpGkQysFg4oTykOYRugodBB1f1sxcyEHBoro3dYjkrR7hp5ME9VRRfrdK9GxRf3YQ6mzClBcQ+WjnMFSFIsUSAq2Gr+mIb3GPUvrKrJE0Mc8Bir+gws4RqP7U/B/au+20dAchLs6Gk+LmY7l8/rUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNJWhLr9igZ2kB5vR+c5od9Loo0924fKdDn3NOBTHS8=;
 b=jXXlgwch3MFpfuVuP4cuKa93X95OW7SWMNc8+bv4joyWggIju/z84TaaUtqzDixZIM0/5miMZyhRUtD9NtTL8oyJL0nfHhBXPZGI9xbuaFMiyFPb59NTr0Hs/V6D+wd77i4W8xwDSEmqA7AKF/iufwxq38DupH65a1UZF2/hxWpmtuBBJjSfkkZG15ShEILLIDr1njbCZ1Ew7GvP6VXXvtICfb1ykdiLesfidGpaeJfdSHpzzPif+R7orNzrtYELiiDTpJS9RB6HIH+qJLzdwBifO2qTO8AiMQvWjokdMuKzocoV0OK2hXug1dKT12xFle/X72q6HZRPX8i9tlinqw==
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
Subject: [PATCH v2 09/11] hw/usb/aspeed-udc: Add trace events for the transfer
 paths
Thread-Topic: [PATCH v2 09/11] hw/usb/aspeed-udc: Add trace events for the
 transfer paths
Thread-Index: AQHdVJT4AGKsuUUpLEiyqf+2nPuDqA==
Date: Mon, 5 Oct 2026 06:44:29 +0000
Message-ID: <20261005064418.3060881-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 0bdb7efb-5372-4d59-2235-08df22ac1bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006|5023799004;
x-microsoft-antispam-message-info: SaMzfqO4QNQUxS0QCCTq5YrdRsjqztACjN7PJfSHAimQc/gtc5SiIvd0nWIjWyKUZfUwk+w+JAOR8KulI+crTXiwjKmIYUVgimu9sOkIgLMIn4+OGooKTrWBmmnFsYsQ7DDJX3Fa/X9O8Ttv1sBDYxs85iqVzu3FfIICsFGFV/OPSzb9lzN+cb3XXdicNgI7/Az7v8x0+dNiZQdW8OGRX2FU9JHSkPpelYcpjAkOgx5aFrF7SAxemiBm/UOb7FcFZKxSX0jvMPe3r8ahODPCbFpbL1p9BhCrFisCxDw2uUUm+rEdbEgJhSpeFxbuEdhWm6kM6DCsqzeyTWdnj6XehzV7AVNx8A/gPxq5Hi1oiqzAo1Dn1vct+OYSim8d0sUjj9sVxi7KFBC0h9DRX5wFrjxMff4SO1ytVdtnGLe7r3P2jEddHKFPEYvUc7N1wCBSkJqRCYNc0DX2HcudhyFyXRXgZPvwpP8JlPAO43v6QN9QdMsbIa8mdRgk9pPsuWLlxBljSTEdYQrrb3VbenDhRieX5l2nULC90+Y/O+t6KmZl4sbbr4ESHSTHMnAqWaj9VFG+6YQxfUfxbQy/lYAeSW7aGGIZ7J/xufMkLDIn3Ph6Cga/2/ELm/pgZndPSdIIOUqRoC82ZuEh8tf/VYVkL4eWMU5W0SsmDceGsmXZP8Jy0KOzpepYeHZgt6VVjnw2Ukgz8XxsNEl025F56aJWghWKTybI/BEuUeGQKbPwVbI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?heyKx46Nu6Whdaj+/7AjGZZiv0SrPc+FlHscFQNhYYiy+uM3nU3dmrO+ib?=
 =?iso-8859-1?Q?yDxS+PB+v60swraPJ2uz3ZsPYmG4hyR8to15w/S9qUVbGeNXJkSs3oo5Fr?=
 =?iso-8859-1?Q?k8Bo4rTQtBlkSCPvHTytDeQmgIdDbqNHa6lth4BdWajWhCWgO2y0QXcxyV?=
 =?iso-8859-1?Q?KPL8W0T2HgXm2Qzb47/0U3VHeGWlzE1JTV3WMto0DEw0QmzBe30v2H5SaD?=
 =?iso-8859-1?Q?sHoE74h16wPeWZ1h+DCNKmYxTizAfXBvPnFnXKr4uKMKWt7aAVZVqk1qig?=
 =?iso-8859-1?Q?NpGIkp2hEGiSfI3pMjKUee7NQRjsn2FR61iaUnrOHS+3VKzCUHMPphPWSx?=
 =?iso-8859-1?Q?a3QCMBYYvY1Y3Rl+8lKsZ5U/tYAe3jTD/OisPbG7pEyPcKCbfal9TJ9BF3?=
 =?iso-8859-1?Q?H6+OSzIZFsATQl2D/yxKeFBMAF65uLqHK0QXou4spqXRnmmeIUcIRCl7ma?=
 =?iso-8859-1?Q?nL657t5GdDVewnpDskL4VN0Fg+0FzBeIjgYrjvwBy+Bj4cOtloxdB1eOLO?=
 =?iso-8859-1?Q?wm3OsTcEd52pI64nfGBUfgizrLxRk/UY21K4pReF5BNCFwjtY4hybbZwMJ?=
 =?iso-8859-1?Q?OBcx/zwfjKQyqAQKLa11a2S/4eYgVqki3XNWfiMplfrFpFOQpLn4a3c5QL?=
 =?iso-8859-1?Q?Z2r8xEQuIeD6o60wc5wlwRTXeW1oSMVqLvW/ZVR83igpkzWvbGgWPHXuvM?=
 =?iso-8859-1?Q?mYcOjgX7WPjT2euuIvQx0LFoBelXRGlc7PW329lmA52ghWLCPFb5jK/DGb?=
 =?iso-8859-1?Q?g97vPJKAmddX6uKsEERy5SugoxxtmtPN9dIlx8NeEOw3peeBXGpuf/FpgU?=
 =?iso-8859-1?Q?fBXN0F+mPpMMOlW8EEkkW9VGsYgH42Jm39auHvkSDqfce2nUbkdxz3uiK1?=
 =?iso-8859-1?Q?8m5GhTB3EW8JbuDsLM3lqHTCgigZGS7l3dpPAl/pySUPIsa8zLpXOzrNDX?=
 =?iso-8859-1?Q?wSAfcHxQX4OUmOUYfsSDKXAMo8NE8TrA/o6IrG1K8bsYbbR5Ss0G0brOgI?=
 =?iso-8859-1?Q?goNcDVfQE5v1fxu1baf/GLPvifn16n21TrRhQYCxWKZ4SkBjB8yOszrzXj?=
 =?iso-8859-1?Q?LoP7xsg/N0b5CZHr9gzcQMrwKGtHUDshNcrKAmmanYSEejDtXX6GRgnme2?=
 =?iso-8859-1?Q?HL8jChO7iQ4k1qTCsUe4lMNVNAt1aFa/5bY98u41Hi4evcO3a2wNfVBP3L?=
 =?iso-8859-1?Q?o9Z7WkLMm0AI4WjK/ugs16H9XacLZ6lODbzT/JA4wi4Wu7AD8DZz/h064o?=
 =?iso-8859-1?Q?1k6Y1S9GFEjJclJAC6snjMn0w60A7yxE/+NVk8heMPFlWOkDnH/7KxbV1+?=
 =?iso-8859-1?Q?jWvo+PQZ2GG6BUW167yHKK6gOxzU4ov3S+7iyaJtbHWSU7hUTCqLckcIYB?=
 =?iso-8859-1?Q?BvZTjZi0+4fHCWyWQBD0WF9FfQWB9cwvLBK+gjdUkCkQlvAuXUe1NFQxiH?=
 =?iso-8859-1?Q?qdVHlqIFeDhDXtZhCdYjtJMypVFtS9VKRxJ1uKO7yzvLoQCceTVuqG5gVq?=
 =?iso-8859-1?Q?QaXXd3bhicwEJFhU3oAuX8YeYiM3akBhyORjOgdiu7F8YYQDl4pRnr8M/y?=
 =?iso-8859-1?Q?pipJtma5MAK3DeTD7jmYy7j5/wy2rLUjwcjB1cx7OxXNFtReLck962LInP?=
 =?iso-8859-1?Q?XqxbCbaUlv1Fxig8zYHLhqCaIxQtJRUzlB0x+eLdTD4rR5Uzg/Mbliab3U?=
 =?iso-8859-1?Q?3MbFN/cFaAODZxLDVsc/7uis0IOBSAaw6Do6pOfgOrG06k2LUPf2dYLqEQ?=
 =?iso-8859-1?Q?S9oKVZpo9XkKfD+Yeo9QKfE/d/6yH2bC2qWC0RX+95JWA1/n7hE6m+iJjn?=
 =?iso-8859-1?Q?dw7lFPPVbg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A8XySWcFe0/uDbMnJKIX6lumwdbBcew7seBTasQBOw/MXIm8Dr47gYhFsEqINL7NFtQ51HFZIWmCGKDfQsSnRqK2KDUZnV2NYaVQJbmXK6m71j78S/0HMzBIMxDoVy1RndNmmTM2l+vqv7mQW3haQDPz/U/oKpgLBr0yXUvi3ngkWy3BP8i5HniZB2g4v0uBBkjisqkAR6QRHgHWiNZVOqj3UCTD994vRQL9D7gnLPE2CE0UB0UrbC/vBoxFEwB5Gd6wuGCFD/166VuwrG4cktfmhnSvw9TIQI8wJpZ5pJ7KWmGviqR2kaDkpRtbL45HP2jNPrcS/9+yfb54+MIR7w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb7efb-5372-4d59-2235-08df22ac1bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:29.9863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYKI9p4riyjc7Zlkyb8UVonry+Abd1PkhXvlQeONLBlN+Ea4/E3hdjR0k4ei173eJsQWuhAzV/6Q15JLNcBlKZOhKueozSQ6MFtb0Il+KeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
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
index aa260dacad..661011b07e 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -395,3 +395,10 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uin=
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
-- =0A=
2.43.0=0A=

