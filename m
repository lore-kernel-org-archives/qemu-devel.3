Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6844CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRd-0001an-BD; Sun, 03 May 2026 22:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRW-0001Wk-JN; Sun, 03 May 2026 22:53:59 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRV-00040F-1C; Sun, 03 May 2026 22:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmlSja+pq8DnUUyuwCIWBygbzrHPDfOFkXANR/e01qUQAxNMd/xwJChduGRsKWtskjTvyN/3ZSy7o4/wzCl0UkP6mrJti591V+zGz59ILRCltbeG5GFqxrqtoKUHglldpeLeyLuxvBtYXPi1gGlpDzlNDb93jRqiPMbQ1/J7vc6sXNzeK8IV8LIGKvU6+iFje9DBvB9swVRwPnaRLQVyNFuLwJV3wRy7odLsPM4xorXdsYZPxfzfMg+ooRmQwJwzox0Kr9tzk0gaJeBnd1ao37zUvFgH8JDGMUP6UJGfAihupUuGPaZw2/uIsBBFOLPEvTGdNq/hTIleVG6CQIVW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X28GScWEV9fXKaS4RGKXlaybbJ1oTaFZq6mBazoT3CQ=;
 b=rEWl50YBxuFKZT6VS8JAp/pLOxrnSrHsh2DumH/Wd5kAYnQSfunpCbSsOvjpXFlNlGLq1LaCP18fqXW3BRpIHNaTHyzgErqYL1vF6T+492VAV5rM7QHb11D/tECCEyoXkm3boS3tZqdPAmCWuNm2Re5q7g77TqUZhbExC3wRPiWpqhhRzUfEga8OFc9Rpr0TvkR5e3SM+1hVrlnMz+1Rg/KKQ76Ff57SqgWiN8PlVrfDnVlP741XwkwhHZLSYuak11I+GC90iDrc5p+qzN/Wj/zPehH9DmdnKhos42a3PzZJipLqu3IvEmn5kFIKPnYigsfNlYNY2IthQRCBIF7Z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X28GScWEV9fXKaS4RGKXlaybbJ1oTaFZq6mBazoT3CQ=;
 b=aFSPP5nXGNgLzVRrpv294uIEK0tPNnz6CY9bHUr+hlwhNir1SRCX8cki4Lwtkhly+Pq6EhN41901G1+l9OeeQ0iwNtT+h6QHlaY/wPuUuZJXfQVcVt6T1uevoa6ZF06/8II83AYrRnmIDk/g38OtV2SnJp38i+d7x9/mMGs492xahrZZhhqnf4soKahazO6XXNj65Hnsl56xfm7RytSOIlA5DnkN43/UW1QrFVjVQalKrpgAxOhOqQaY2KuMxS138QmhpL49UdBq4Jm39qdphdk+KbXwWd6fG3GkzFFwVpP3IkU0UO1uYdStJzQ/QDcYCncpRXcuVctRX655xljhbQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:50 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v6 06/11] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Thread-Topic: [PATCH v6 06/11] hw/usb/hcd-ehci: Implement 64-bit iTD
 descriptor addressing
Thread-Index: AQHc23E8Pw5tqStWhUydAG5guIsiAg==
Date: Mon, 4 May 2026 02:53:50 +0000
Message-ID: <20260504025342.1452605-7-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: 88e6e78a-5536-44df-b03d-08dea9885ea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 9+ed/5g1kBtNoF6z/RQQkQ8TwQfdSrQqRRjw31IyQMn43y4SGRhqLsrHvsOntB+c9j29nCVfSQ648O0j74lq7DYLuzSUQXSRWab9Nq9ZgMGdzGxJwFpUyOQBmcaxNSKgcJ6TSn6Y8tyq59Pbzix9rTM9FpNwGwp5paNT86tyKp/J9/QLYsAQngNQ7UJOuBnsBVCEhpW0awbjLT0EYl1o3H+uKHVnA8rxYkkT6VwEzWFx7kDx4hi8/GvrMhJOfBpV6tbzSkI7Q14CoGvcrlDVIragjJpT8XeQ1j4vqcFDnCvKVRna8KQVgwEj4cJYFnUhmmMsmrk1/xJ8eG6oIyYze+ZmM0sKgFg7s9U026uyhgJMWh+9cbPWmHNsmw8ANwvOi3bHutLN68lOLhP8vN09Vx6hqE81GJtelcrd7ly13vzB3H9jj1X+SRLJm+7caQt/MHm+w275DhYAQu8HrgHTQhRoILe5CbDAkbZmfJVCnJsI+ykgo15Q6mElB4iUyfuFfyaMZTSwMWiA+d7xSFHhwc2XzRfBid1MDVVXemwomFlkkB+UXKjCercIVJqHat4lakK+N4WsMTVQrMphCrEDfCuTH0kb2XwtLgjeDxaNukDbk0mC+TOdaszq2flhJb56PxVtqtPWdHEiA+8gqjnAVsW+2X/lsDZXDnqIfoOF5ExlVoAaPt+CEUY8gbyJg3ey00q9sbp0rJEyxZvXMIojzKIeSgNpiKFFFH8s7lnRlv3bJmmjNzWSB6HupejcJqKcemZyC9X6h3OFf3rebzit0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g8ZtgcHdOB2mtZfv+eIUuWs0PuZ91jeG+N1onWvPCdLA/LNaMhf3CpyWm6?=
 =?iso-8859-1?Q?A5p6C8DV9c5GG8AoB3UGN1UR1PXUGM0RRSWmMY/u6JZMZmF/YVPDfvTTP0?=
 =?iso-8859-1?Q?Vu8qivf2t5ItLw4WNgZHq0DZJKG2fniugdrL4FU357YPhGQDD4Hc1wJZz+?=
 =?iso-8859-1?Q?d0IpC6l2lyI1ow1l6evX8v2vJI7c+kxARzGUr96HCzP/lL/yLYcczHUGaW?=
 =?iso-8859-1?Q?QcV3gAY0BnPaXcAvOuGLje7MrfXYPDL9TSRWYRxHHGUBtOkZItkkXl2pAF?=
 =?iso-8859-1?Q?R3xO/TZMYdrA16gJg7WldSW6MMfGxOAjKW+3X4xXMUE6rFAY5f62FInOBA?=
 =?iso-8859-1?Q?KYYOL0aNHMzUtK8Z+C7t4LIXxm6C1y2Uz0Zx+DOe3Hj0wPPEAYrailZljj?=
 =?iso-8859-1?Q?bWkDcaUxXjIw1uViA/N7nC2xJ6car1f+m3IwvFXeRjB8pNWYfWTmiJVKEL?=
 =?iso-8859-1?Q?DjeGHWo34AG4K+nQRr64uKW18khICmdggrRon5AcBnpfHR5Odxdld/dAgs?=
 =?iso-8859-1?Q?djkqfXz2AOqkPT8Xms0FCDkahIC8ZL/aZ18ySwIfAX5qstv+0rfa/ZauAx?=
 =?iso-8859-1?Q?GnKe0x7i4Nw3OSHMolFI8ChJTK9daMy4ooBEyi/sMDTvfsc5x8E18+o1fu?=
 =?iso-8859-1?Q?FMOcdC7O6R7HgD6puS7mRlHWDYqiJeVNNmSkxQ7wnFl6G2HYJ+JjtNcmh4?=
 =?iso-8859-1?Q?3a5TJ7qynCffgJOyppHStVRkopUQQYQio7HFJyEdAaSj1UpWnza0rvS4Q6?=
 =?iso-8859-1?Q?2Zw40+qf/tou9K6vVA7kM7O9uD2DB6RdAQZuzfndg7ahgBGJsIbKq/SvA5?=
 =?iso-8859-1?Q?NeRbNVvwr5bZOowhaU8cWzPnQiz5Ex7izwD2Bo8U33mnhd0ANpo/st4nw1?=
 =?iso-8859-1?Q?aC2Qd60au4jFu+QUbRVgrBqh4nhMmlmqpwUWSL7u2gfHrt4YSZfCt6CRWp?=
 =?iso-8859-1?Q?ObywOeyOZtbXxG4b4CpK2ffOYDVncnkeuh1Kj+o42Y/Izk+Y0rcKiZa/K6?=
 =?iso-8859-1?Q?1hoUb9YjBN1xiJTMvc66H6XQ4ymMzmNL4OdTGUEcGCksTfvm1XeTHpBKeA?=
 =?iso-8859-1?Q?cJtvbF+uMc6xVxqLTiw+KT9U0fQScmnbvwg5pxR1f3Ycov7/UcyabTnfUU?=
 =?iso-8859-1?Q?woLtVO/0vCrfmVwKsAh+7YksprXi3HH5XRBtAg88jeehGNpfLe/+QZCcUt?=
 =?iso-8859-1?Q?q5F2DnfFA6s/SUYO8c+t/Vl96D2T4l4vv9WcxkN/+YBnAwX9SkAjzFLbLl?=
 =?iso-8859-1?Q?c6hNmvPl0xEggmquscb4PgFQJLFlk62frWmDiWAVivPvDeXFCG0kEv9TzA?=
 =?iso-8859-1?Q?Y2gD4A/eKUQ4V8b2hQes8vpHK3Mpjv43l7/D5uPVKzH2OS0jil2HAsd5Se?=
 =?iso-8859-1?Q?lpWj63OmE0lrQefW9Yhg+wbNtEqgzXgp9LeDTY/NqdBxRZs+znG/V18cOY?=
 =?iso-8859-1?Q?GexH5rhahjWAmRte/Aajlm63x0kQmaoPrcWaSvDAMLRoeUzG3i85YpELqw?=
 =?iso-8859-1?Q?Ju5IeMp7W8Nm48cpwYTgn4vxXuNQwXdHgE76wV1jL+g10uIx/tdcI7QA+X?=
 =?iso-8859-1?Q?j7nfQt8yb5JUjTdbL5aPyn5qSuuYCnwFqq3zp3vs1TN0uBoUvqSKN0rueh?=
 =?iso-8859-1?Q?vvbPOLi1OIIESxRvXfI10FfU5fmkRr8el+VHeilNvxySujWWkCPzAHtsKa?=
 =?iso-8859-1?Q?LdbRmRdthLTkRgcsc5m5XEcIhVdpBSJy+miP8iGghIXLG/nxKTiJHnSSs/?=
 =?iso-8859-1?Q?93Ii+3VNwMVaUmz4bzXfuKs5dHDL4Rndt3+66qByUlJ7QUrntHEBXAX69p?=
 =?iso-8859-1?Q?TuCFtDtNhw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GVkbCCuVuq0DIfuSWiVtrwzqCBDIcoaupyQQJ3NllIznM7eLElz60Nyb0znUYJLWPSQUHs5oMpArt8U+AXZ/C3V6WDZdR5HF+hicLerf9B10XOiBX9NA8m5n3wOdseNaNiuWG99b7nE8efhcV7ycacmgQ1w4QVPWcEgZvui5X1/lhZBSZx9hDT9Cz8U0vcHrGomwbUNyqvK+o9ITZXGaJklQ3GX2CNWv/MEP22Qo6oo5/I4PHkQQEkpbjszHOV+FmMVy2ttmNZWnf/aEAKFtgce79mM7psf1p5F6+ynf5dVCwRRn0HxOF1Mz5Xn7y3FZkSRb2d8fatA1D2RfoWsOQQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e6e78a-5536-44df-b03d-08dea9885ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:50.0787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/DlxWq/CgroqTfdOuPMAAJQcYfnPsi8rGsRwss3K5wc48XVjQ9LfwR907raqkPbkqyK4QJqn95MrbS/GAyI4r7XgrHvwe0l1y592XRLZXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
iTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the iTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for iTD buffer pointers.=0A=
Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct=0A=
full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields=0A=
when processing isochronous transfers. This allows buffers above=0A=
4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 9 ++++++---=0A=
 2 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index fc66aacd9f..8e6a8cdfb0 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -63,6 +63,7 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MAXPKT_SH     0=0A=
 #define ITD_BUFPTR_MULT_MASK     0x00000003=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
+    uint32_t bufptr_hi[7];=0A=
 } EHCIitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 238f08b4a5..611882ba1d 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1464,7 +1464,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                 return -1;=0A=
             }=0A=
 =0A=
-            ptr1 =3D (itd->bufptr[pg] & ITD_BUFPTR_MASK);=0A=
+            ptr1 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],=0A=
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);=0A=
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);=0A=
             if (off + len > 4096) {=0A=
                 /* transfer crosses page border */=0A=
@@ -1472,7 +1473,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     qemu_sglist_destroy(&ehci->isgl);=0A=
                     return -1;  /* avoid page pg + 1 */=0A=
                 }=0A=
-                ptr2 =3D (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);=0A=
+                ptr2 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg + 1],=
=0A=
+                                         itd->bufptr[pg + 1],=0A=
+                                         ITD_BUFPTR_MASK);=0A=
                 uint32_t len2 =3D off + len - 4096;=0A=
                 uint32_t len1 =3D len - len2;=0A=
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);=0A=
@@ -1762,7 +1765,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
                sizeof(EHCIitd) >> 2);=0A=
-    ehci_set_fetch_addr(ehci, async, itd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
 =0A=
     return 1;=0A=
-- =0A=
2.43.0=0A=

