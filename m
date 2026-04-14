Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF9DED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYha-0003bP-UT; Tue, 14 Apr 2026 04:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhX-0003Yd-P3; Tue, 14 Apr 2026 04:00:51 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhT-0005oL-OR; Tue, 14 Apr 2026 04:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7g+Z3inz6QzgxRht09uHgjFx6bBEPYUXc8/YT1EmhDdDyIsoUo4/e9axwyY+RilMbrxtskuaLtkldJM1SfdO/ozpnqnEGP7L5dLPSXTYWhxKole2ZlN7YvDaeT0FMbca113Lu56Nl4QeMKAsevEZSzHa/csc/AsHxOp9KxIcVxIhZ64dsqEA6w40vzDJecnSH3shM0sCCGSObh0Mkz6UsGhj6QLQsChX3J2wxCgRVkyUkXGE9P/2RW850BA3nDgFx/HfseCkdQ5u3jUQZDRSCJEvqoKlb2Ja+Kn+cLCKin6qFN6WhwF43gUDJ15kl6kri8Hz5QSqzJC2KszrcWpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPUuYGkfIR6j1AbiEpDRbnOQ1Z8Qp5SXYAhDVwcsM6k=;
 b=g0/+gJiPdZh2YUkk3w4ip/ssVO8nV+CWn/hh1c+rDidVj3BAKNY0P2LAPXPXXAXx5IVq+5J35NFWaY4Iqw0rggxKy30iTHyqVwWHPu/Y+e3lZRdcSwO38jFX4qB1taTazSPkvFNxnwnRInF6NSItBYFBm07qzzpvXqfSFbZUWoieM1ktgEj+oOuQdoZ7PrB4zXzqoX4Ovpcva9NNfRJQuOIIobnmF/c2KHJdUdafO1J4q1zcM3Dx0h8N9igw6pgGzpiNIC264o/gWZQFBqeKVWiTIZSfki5VZhANomdmoHsq3uMYd+GoD+1JbEdi0oX8nofM9JWn4TxcaU+xWLLjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPUuYGkfIR6j1AbiEpDRbnOQ1Z8Qp5SXYAhDVwcsM6k=;
 b=JKLD+RZ04GFuqLVXVkpyaN+hDWn4DfcCYyNXi9w7TaJ7mR91t5m/xsyu3Sp1efTzbI9yRJqPCD9Fu6tl5unhXu5THiFw+rUon4Jh9SD5Fq//lqfIFZFA4LCQcI7CaqtUriGPJ3zVTKdMYyMnp43URnuhZ/n6b6TBZiW6X37MnROHj2y1q4dmqDtKXxS/OA9tnysEZsRVghUnyN2s1bh9sTlI9jXt8HazBXiD15CzdBpj0x6WPtg3VNN2kNftXQgsQBoK94BRHjo/hlLsZ5KLUpVYLCMc7qtn+eapJxJjiIMsReIbKCODEtYzBnsA5R8EbZoy6T19FryfnUAO8JE2Sg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 04/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with
 qemu_log_mask(LOG_GUEST_ERROR)
Thread-Topic: [PATCH v2 04/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...)
 with qemu_log_mask(LOG_GUEST_ERROR)
Thread-Index: AQHcy+TDZKmGzP6rPU6jtNcClXZIGg==
Date: Tue, 14 Apr 2026 08:00:31 +0000
Message-ID: <20260414080025.3005916-5-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6745:EE_
x-ms-office365-filtering-correlation-id: fdbfc5b8-6845-41ce-1399-08de99fbe630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: FCMEUqbkZJQopC+Z3SHbNcjYlC4KvgrjGYlloTCxDqdLtU3LKIG957xjrDxdj2LBJZ7LYGs6Y0NdFfUQR1JPW0NTMo+tam8GlWmK0CBo96iLF2mrORtt8Q/FsDUfEKKNYgu7N1LB9jWAtd8wH2AShCIJJoJ+aeUPhB6ud/bnfz1KMDgRAqmBb9qYmf94lofj32sKhUYpq1O7gxDFcRj7i5yC7y2TrqVmaORFmq9IhydimGM0cSPvnj6H/1FgvwOY7SbPlwhNw+UGAkt65j82akVtm54RcYYjRmDMlZFdTdOnKj1/23AimvUrU4w6ZdNJ7U625WXkb9J1vBJ4XKwn+st5CsC4sQYGA3y9ujZUy5CJ9bzDsicFlQxR8mxhA6i1k+0wZQrXP/HbQxXxif9cyjCAh0VJI4C/xih5ztKhAS98gR2zoUCz1rTGSubNniiQoU9ltO5rNId22YLtDGtyrALGh5DHQOOCVgUWf49kVwhYVnsN7JYd9uEyNgoytic1SpMxz7iLosy6dk1xkRvEz4AuutGyI651zk5Q6263jc4wXxzcK1wvR+Kx5pVv6AyyAXEG0OsvqIGnEqbKumQnn+H5VKqetWKFwHFpsLpSnhcQ4yB948/aV3vfms95cmIYIC/HLSoZEw9OPW4bE7POC/LgISbim6TRlIPqqwWPjZVi+oCv0zafEFyb3OMxiC2RtXRvZGQu2c391++QJpuNIk4wgFnuPBwu/GyiLVwz1gaYR8uxP/JaAaPWjwzB5GTz6fgVE/Y2SVM/d30AxsJlcR5Fo7sZuEbOO5U+XXXaHys=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IGNC8zogezfWFKSUmMvPwV+0tyIUUGhrA+EkcPG21XFukP6A6u8WZusevm?=
 =?iso-8859-1?Q?Reury8erif56lNpwOAxWoBrv3WW5yhiPAc4kD7fMDs62Hq9m7nR/+/DX2Z?=
 =?iso-8859-1?Q?7GytBbrU90KUyt2U62+cs5AH8NitP8W/hgjk18//w4Zs9O8te8rCWVPsCE?=
 =?iso-8859-1?Q?xlzzSNFl1zdt8Uxql30KbDIvmsm8UmgOgwt6l7ykBazPZl1k9J8qban+8p?=
 =?iso-8859-1?Q?uMze3sWly1PnO5tdxEYIKJLFiMfuhl0qb/vwYqMxpnkCjUTbJho80WLVfO?=
 =?iso-8859-1?Q?OzLQIdJ8ytRH9RXW7eqWJQyKShMA2ug6IEycQZqzdnlB69HctwdaWxLwrt?=
 =?iso-8859-1?Q?JhmO5f3WYc9VLA8QwbvEMU5LhPq7qTiiPMtOOYczMX2kWYufLbUC6HpfPm?=
 =?iso-8859-1?Q?CB6cpKIotENLwNifGhWqfXi7MtPAYU1wkSgqZlPnjL+4Nddw4dupmV7Bnp?=
 =?iso-8859-1?Q?jvVDI/OxxuwqJcOgJqG8jrHOnrlGudPtL2nH9M9cIHuaBllZ4MOyJh1tF5?=
 =?iso-8859-1?Q?gFP27nmQEdf7p+scz55KCnAbu2kUNh4utu94wZ7zy91E2SwFKX1s+rgMzA?=
 =?iso-8859-1?Q?w3FJgTT5uYbr11T3EQKayHC1hy1PZGq2ePnQ/xhaf24ixlMzsnStWDntJH?=
 =?iso-8859-1?Q?J8XRWLeVMpJ+1ONkQXZ1HJJniuzkjrNqmTfHS7LHCBgkltV6Qxs/4uL0ms?=
 =?iso-8859-1?Q?dVd2MThVS6/rsmmegmLTKEpnBeVaWpdSquTWEFZT+o/6orHWd5u6lgPqib?=
 =?iso-8859-1?Q?0HCxULvXgHJOROA7WZY6rtZhRVjXOFpah2+70fF9fP+5gSSbSYy46gaHL7?=
 =?iso-8859-1?Q?LNxog1J6fo3gLFd6DKQUzKn6j3WLNSTP6q61Rsm0lJYoIDjGajN732UPuv?=
 =?iso-8859-1?Q?76Ocel91D+CpMAeybpO5KBHmuVfiDBrzIYI1pH9zkGrG86yk0BC6vibjD8?=
 =?iso-8859-1?Q?QUvhQG3z6b25HdiiS2Szpsgwo6DRfhiiUM9PzZ6dsqZbfJ2X+MllX2+Hh0?=
 =?iso-8859-1?Q?ITzn4W+wGMs9uG22EC2RTIRN8c1ltpoWBp4xZIKKlY6q1JC6Qp2p42hvhg?=
 =?iso-8859-1?Q?q6qDYwYmI0nm3IM/vIdDW7K2idUtaCR3VlTcnG2GTf+3JGZfK1IBPdWZiG?=
 =?iso-8859-1?Q?UAJaK29LcyScaVqrsb1lmWfEBsJfITIZGwSDUAR7GCQHi5dftbxCsxzD6E?=
 =?iso-8859-1?Q?xzlVaNu5tmUdO8MHwlaDLnuBpvoPvgcH0SSkAiKGfnJrV9z74FMkGIjY0E?=
 =?iso-8859-1?Q?erNf8AXtlLfzfSqVQCNT2f2jUhEoDTd76AYQ3A6LErVotm/vWrAlNPxc7D?=
 =?iso-8859-1?Q?0Z6B4QRq7nPNelCTWhuRdX4oyTvm2ZALHj2wqzPJwRg2KV3+glGzsyNgzY?=
 =?iso-8859-1?Q?4It9Cj8wggy1cWDpKoO6vTNVUG+KC3Kb4TpZrNAfSoshNA1BO7AqPTzvdr?=
 =?iso-8859-1?Q?2nColzgJZ40uW+LacKpez22PmZgaYBL3uRG8HTVYj+HDBG7JVuwc21+770?=
 =?iso-8859-1?Q?s6//KA9moE9Xncv0Mi8dDma+z4lsYgcCq4Hiy2jGXVftNMtgsPxKBOxScH?=
 =?iso-8859-1?Q?p6O9NI+/hr3z6ToyW/t/Hpxf6Hb12UQxL2vDdppZLZ9VOaq76wMXgn9GNH?=
 =?iso-8859-1?Q?VfzqF8yYKmMLuJMB0bNInPQTj4XqvNSjobPLvAn4z1/Z5IGWeiJ6wQNKSr?=
 =?iso-8859-1?Q?+q5kEmDcDbpT1bhshM7Um3Sv+O8S389bsEw92qHhJF2+bvJm1k7qlg2PWN?=
 =?iso-8859-1?Q?tX0O8ZLxwbMexYpr9PicXUTXANFKCvcSBqnyWOH7MAXpndmrU9wSdOWi4S?=
 =?iso-8859-1?Q?eYjGadbYgg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ct+FEKADV+dqXqlD9N+H4xNHJtGkEbF+Aw8C7SNyx/4DtYIdOCdeaGlY9Q+vykL4ytHXhQzryJsM+pzEwDCQkt7n12WsJljK38arKi4eaD2MNl6SBvOd4BD95bb/EhQ9ObWXuJ2VO9KGIDrkBiuW9O+IrVXsegmwPaUMaZ0WX0X0f9zZNkOSP3VXldBxkuX9OldN5eqguM40YK8Qbf1zAUBf7uIv8ssmiT6sxQKcJzJsenQJom+lGhpDEt1aTvnmcHnrb5cJ1blwFJquJ5nwgHinFw6uzNOltTLF9btTy7NBBy3SxTh0byGACTH1tqsoGeZ4f1ts8ISySCXbea3sFg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbfc5b8-6845-41ce-1399-08de99fbe630
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:31.0485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EllFd4w8eATkRgTeXzrWOBeazI+JbVSiNg45zUZzTDbwUdkTepJdsKE9OQte/xrLWzMLRveORZ+gKTCC9ztrjnisRhrv5gm7/jx+RShd1j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6745
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

Replace direct fprintf(stderr, ...) calls with qemu_log_mask()=0A=
using LOG_GUEST_ERROR in the EHCI controller implementation.=0A=
=0A=
Direct writes to stderr are discouraged in QEMU as they bypass=0A=
the logging framework and cannot be filtered or controlled at=0A=
runtime. Using qemu_log_mask() ensures that guest-visible errors=0A=
are properly categorized and can be managed via QEMU logging=0A=
options.=0A=
=0A=
All affected messages correspond to guest-triggerable error=0A=
conditions, so LOG_GUEST_ERROR is used consistently.=0A=
=0A=
This change improves integration with QEMU's logging infrastructure=0A=
and aligns with upstream coding guidelines.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 43 +++++++++++++++++++++++++------------------=0A=
 1 file changed, 25 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 9b92384bac..bebd137f94 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -36,6 +36,7 @@=0A=
 #include "qemu/error-report.h"=0A=
 #include "qemu/main-loop.h"=0A=
 #include "system/runstate.h"=0A=
+#include "qemu/log.h"=0A=
 =0A=
 #define FRAME_TIMER_FREQ 1000=0A=
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)=0A=
@@ -425,7 +426,7 @@ static int ehci_get_pid(EHCIqtd *qtd)=0A=
     case 2:=0A=
         return USB_TOKEN_SETUP;=0A=
     default:=0A=
-        fprintf(stderr, "bad token\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "bad token\n");=0A=
         return 0;=0A=
     }=0A=
 }=0A=
@@ -532,7 +533,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
     }=0A=
     if (p->async =3D=3D EHCI_ASYNC_FINISHED &&=0A=
             p->packet.status =3D=3D USB_RET_SUCCESS) {=0A=
-        fprintf(stderr,=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
                 "EHCI: Dropping completed packet from halted %s ep %02X\n"=
,=0A=
                 (p->pid =3D=3D USB_TOKEN_IN) ? "in" : "out",=0A=
                 get_field(p->queue->qh.epchar, QH_EPCHAR_EP));=0A=
@@ -1042,8 +1043,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
         /* not supporting dynamic frame list size at the moment */=0A=
         if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {=0A=
-            fprintf(stderr, "attempt to set frame list size -- value %d\n"=
,=0A=
-                    (int)val & USBCMD_FLS);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "attempt to set frame list size -- value %d\n",=
=0A=
+                          (int)val & USBCMD_FLS);=0A=
             val &=3D ~USBCMD_FLS;=0A=
         }=0A=
 =0A=
@@ -1101,7 +1103,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case PERIODICLISTBASE:=0A=
         if (ehci_periodic_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: PERIODIC list base register set while periodic schedu=
le\n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1109,7 +1111,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: ASYNC list address register set while async schedule\=
n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1200,7 +1202,7 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
 =0A=
     while (bytes > 0) {=0A=
         if (cpage > 4) {=0A=
-            fprintf(stderr, "cpage out of range (%u)\n", cpage);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "cpage out of range (%u)\n", cp=
age);=0A=
             qemu_sglist_destroy(&p->sgl);=0A=
             return -1;=0A=
         }=0A=
@@ -1306,7 +1308,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
         break;=0A=
     default:=0A=
         /* should not be triggerable */=0A=
-        fprintf(stderr, "USB invalid response %d\n", p->packet.status);=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "USB invalid response %d\n",=0A=
+                      p->packet.status);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 =0A=
@@ -1354,7 +1357,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
            p->async =3D=3D EHCI_ASYNC_INITIALIZED);=0A=
 =0A=
     if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {=0A=
-        fprintf(stderr, "Attempting to execute inactive qtd\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to execute inactive qtd=
\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1395,7 +1398,8 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
             p->packet.actual_length);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
-        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1479,8 +1483,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
             case USB_RET_SUCCESS:=0A=
                 break;=0A=
             default:=0A=
-                fprintf(stderr, "Unexpected iso usb result: %d\n",=0A=
-                        ehci->ipacket.status);=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "Unexpected iso usb result: %d\n",=0A=
+                              ehci->ipacket.status);=0A=
                 /* Fall through */=0A=
             case USB_RET_IOERROR:=0A=
             case USB_RET_NODEV:=0A=
@@ -1584,7 +1589,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
 =0A=
     /* section 4.8, only QH in async schedule */=0A=
     if (async && (NLPTR_TYPE_GET(entry) !=3D NLPTR_TYPE_QH)) {=0A=
-        fprintf(stderr, "non queue head request in async schedule\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "non queue head request in async schedule\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1606,7 +1612,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
 =0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
-        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "FETCHENTRY: entry at %X is of type=
 %u "=0A=
                 "which is not supported yet\n", entry, NLPTR_TYPE_GET(entr=
y));=0A=
         return -1;=0A=
     }=0A=
@@ -2112,13 +2118,14 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)=0A=
             break;=0A=
 =0A=
         default:=0A=
-            fprintf(stderr, "Bad state!\n");=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "Bad state!\n");=0A=
             g_assert_not_reached();=0A=
         }=0A=
 =0A=
         if (again < 0 || itd_count > 16) {=0A=
             /* TODO: notify guest (raise HSE irq?) */=0A=
-            fprintf(stderr, "processing error - resetting ehci HC\n");=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "processing error - resetting ehci HC\n");=0A=
             ehci_reset(ehci);=0A=
             again =3D 0;=0A=
         }=0A=
@@ -2175,7 +2182,7 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad asynchronous state %d. "=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "ehci: Bad asynchronous state %d. "=
=0A=
                 "Resetting to active\n", ehci->astate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -2225,7 +2232,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad periodic state %d. "=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "ehci: Bad periodic state %d. "=0A=
                 "Resetting to active\n", ehci->pstate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
-- =0A=
2.43.0=0A=

