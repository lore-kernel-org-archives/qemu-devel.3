Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFD5C61DD3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 02:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1aWM-0003PT-Nx; Tue, 01 Sep 2026 22:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1aWL-0003PH-La; Tue, 01 Sep 2026 22:16:13 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1aWJ-0007bI-Tq; Tue, 01 Sep 2026 22:16:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqrRiwGAa6uo9LETzpf/vdGXtxJb0LheDqYICsCu1Dxch7tID65OYYlnx9BT3WX/92P6s6vayPHpe8ZlacZ9HNUunx/SxnhpivZfNzgi2JdrX/O/1H0aKpWq1m8Zq2oYHpuPElNdjwoO7P0Flbv5RaBI33ypFrGppeqWYY49x8f8+zfg8XnYwcDrg25omEUmn6Q9leeJ3G9KXgMGooGqB+VhSEE5xRFKNY6UoVf9A6gHk6LmMctzgA043whsLQFQ8xPgDIONRBjcJZS/slOj3huwm1Qn+8etzM8X3cTVxSkP2zMd2Iks9sTvltyB3788NCfnpx1OmEn58ztM9Bq0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqkfcQMqJHPx6pJdymHcdC4wb8lwS2Iarn1ss43vlJI=;
 b=GysJ+sG5tEvjqx1S/aMNqYigHoBu84As88lJwx77dvoKJtzUjQ1pPV34nl5L6cW/CPxVfpHw1z0V2uFIBOrQ7dPxsKi+J2/xJiIu59j13cX3RZGZT5xTxBuCS27BRMXYOQYmuLULV8RNRZcNwCsUV77SvToAalR+R1cNFq1iZPJ0aWC0w+QSIroDuR9x/kE9aZpuejRdkj8byYo+OppdIG5cPZGVU+e+m2Liphag60b3wVti9Kp5qqBsGOyPXEvDkLyCG2oY4aievgQkH/q/sSI/7a0BBnAxfT8W0TfD2M5ugko0sCazwlpqK7UKfltUKr3i/6VXGQqpNEh6e8z5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqkfcQMqJHPx6pJdymHcdC4wb8lwS2Iarn1ss43vlJI=;
 b=VVlGF7RP9KcuM5dnMRzvDc6h/GdAmjsZmgnMKJ9VeHdOizhXs7oNi/uKydG6UPbityeNKV7NDkTGxjyDZWkWj8n4uVJNzLfKEcKTABwkxbt9mo4YRXg+10uLTaVLw410+C8F/h12p/KNNTQXN9uzHsVjn3B18G1xTwokY75eOB16S/AXlNXfC0UQC992mb2S7j8ATv55QWfzzZwAo4PUtuljIvvLV/tPvgUPyGsa/Igz8VuIJrb325cZ0ZAz3IHSd8hZIv3VrbElKLLdp4JWsf4nYalLVcKv95vrR1NwHes8lKH9JCv0LnBpvKhQquSNTUT2iSWZq1Utthco7g4e/A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5782.apcprd06.prod.outlook.com (2603:1096:400:26a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:15:47 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:15:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Topic: [PATCH v5 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Index: AQHdOoD3l+ttzKGGTUG0/bEhwn4n+A==
Date: Wed, 2 Sep 2026 02:15:47 +0000
Message-ID: <20260902021542.3194812-5-jamin_lin@aspeedtech.com>
References: <20260902021542.3194812-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260902021542.3194812-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5782:EE_
x-ms-office365-filtering-correlation-id: 7f47c92c-5d02-4f3c-4d6d-08df08981a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|3023799007|10067099003|5023799004|56012099006|921020|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: Z+zRP6WbmOlk15Rl/XR791P5c/4PFkWw19UomBICc4ynlkXU14xcsBvW2Ze/VDRUZVWo4mJfF0t0Rp/ecCf5ZfT4jQXKMqZDTy0z3iRiQfB6sMJJAv6RVBHTuH20pqL08uGpen6FWQIIvlkvInSdzbXhEiV/GTTKiyeWhc12QZ40PW1b63y6MFZ0krjL1UZGe/KbTPg4ngrYUJBHF2VnU6mm4PkupSrpcsRFU9odnwAMl9veTUd9Qj9m9C4pG6r3ZnuJp/HKTZojLPBIIrDR9GOFUMKgYdw5w6lslH/xW/nWta/P0rXIHrUPuTkN71ZYujWPQrVlOKjGNIP19VZOI2Xdj0DlUmtGPm49yEtuHISsSIvYzVIQbDAuSO8wii8KDLUi3u88r8c/pm+Sbw7ZtZF/U+TLkAfnDiilXSMy+QVElOMrw6cgCP7lqXK4qOZfY9u5XSiLN7mH8cGO9+Wcw+kLs0AdJXRR2MKXBX5ObJXhTj+I84e8JOLM7MhB+/5unK0sGocx68s5kYMKp8aNVylzpFzuJ0Mp6IlC3j3SpjtTF95K7yhtS4ioyn2roklqNpSRCRzL8MuV9n1AA4nyDKSWoV5p3w8fYO4IXC2o9yXUwZOm5oqgZP3Zmvf7bOdG23cDBDu6MUfQDSVYaEgC4nG2LKpioF4Q/qV0lkgjx2B+fHFPHNfro85N+dfm7jUekKBU6PqG08xtPwnrHKUwwHdyljlhXY09Urgu8yTRtiU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(3023799007)(10067099003)(5023799004)(56012099006)(921020)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3+aKpJc7sOfKASjVcd/6rhpzEw5Zr9ccnhXTqf6YYPaXHmo5f+2t8X+pMj?=
 =?iso-8859-1?Q?FeISTwmLWgy09J7WHP8DpcEZTtXWWb/R9QhEtbfXx1w6FNmTSjXObmQWIO?=
 =?iso-8859-1?Q?qUZ8Myy0szzIhSHhghhnf6m9zbBhBFeIhtLbeGAE1cnw7//eWPcS3xKS+8?=
 =?iso-8859-1?Q?SOGb8BrR2TSHNoKYR6MUaX1kz/72HijcPXy8vCVMtjeOpHYlm/b5QBNcNO?=
 =?iso-8859-1?Q?9wjmoC4mjMc7VVFnBaeeSDdmCu0LwdNH9yHXmNySa20tpL+EZfU7+zgD1D?=
 =?iso-8859-1?Q?LnlxVbjuD6/xpt6zJc8k08w7+rRyDbC7XnRHy7Rgv+TIq618mjgn4FFIS6?=
 =?iso-8859-1?Q?2wnxDqqeB0nq/doLj/gaqIysk+YqKqxeQkTZ5XBTSEHqzei5j0G8UICwjq?=
 =?iso-8859-1?Q?fQt0GCnORw4sr7xVWMf7bLHJKGkpd+GThSRSjQubFur+n56N5+Iu2iMRB7?=
 =?iso-8859-1?Q?BHwEg/fRIJQ6vWAwEBgSMwgU7IxmcwkX5ITuqpU7J7qz3YST9RACNXJh2t?=
 =?iso-8859-1?Q?TN9RzXXRRMaQAqFRIQyxpfzIFvahkL0FlhuS9OLR8CTd5weN9tYbUfhTkY?=
 =?iso-8859-1?Q?VQQ8NOT1cJ9C/DPbUZ+EAoir4KmzWbUSrjn0+Lg9armiQEOBQ0gn3ix5aW?=
 =?iso-8859-1?Q?Uvit7IVpiRusSWywXCI/YiOWC0aZ94dETy9XPiYosGWQvZzHYIjioeHQ+h?=
 =?iso-8859-1?Q?/+rTx/6FECYSmxKz5C6i/P3kko6J62vS3tul8+71H+H3RTUZvnHomfSic5?=
 =?iso-8859-1?Q?kxJcdvia+r3sfTIQGA/EAKHq/S1ImBFOE2euw6+lRrQr4x0GrIl/pRxe0p?=
 =?iso-8859-1?Q?fbEpEmd4ojSWTv1CMSdjiOnvjrtLiQ3LAHhSg/KeiKKv95r6u/x5WgmuIX?=
 =?iso-8859-1?Q?zHUxUcwhYk5NpLXnlu+uS/cFuc85zrNW+vTbMnbKHDWF8ELkn+3Kc3gVce?=
 =?iso-8859-1?Q?p/5tEkRtmckqtkTxqOsfo6M8MvhdOOenhBFsddq8pefylRMrQPCClSmD3r?=
 =?iso-8859-1?Q?sIsUzvrYPcVlPDZN6QliPkJGYMvJ51S+FxcW4ZGQlMcmkZ76oENp6I00ug?=
 =?iso-8859-1?Q?0Lu4qLHb+bTh3DpnphltPGjF6gJXxv5prfL4MsllJQiusJe4HKW/XhyE4O?=
 =?iso-8859-1?Q?0FTuDXXXuvKiBKr3EHQTmAifTPcP58G/mVWKuIWWgO98hAowd9j3HWDoqK?=
 =?iso-8859-1?Q?0MglW32Oe1iaTTSHK/2owZ9KJHCuPQPmxWUeoQzq7nE2Ts5d+wiWnrIzl0?=
 =?iso-8859-1?Q?CQ15QbNW6VNx2vOIUlL7ZgAKzaSCYSv6W5z7jA3PmR23dTe0bCT8EZYrXK?=
 =?iso-8859-1?Q?ckJzQenxoq5h/tWLUOZhvfET5oOOswhylm6Pioo9MqkG42VuWYAfmzAjaw?=
 =?iso-8859-1?Q?v4ewoUQgK5MEI57oI9Ci1CMOgY7jNdvfn9MprRvo90dwrQmspcqpQCzmtZ?=
 =?iso-8859-1?Q?q8KOUHnCOlqjCAhAW+BNxDLoSC2iz56URA5ybHx2Uw3MB3IcIAc5OGna91?=
 =?iso-8859-1?Q?C2ADuS/XbtBEWqEMSXcCo1upRUrhs0RRXbvABzNB9kZXMB728Vz6RB+9qk?=
 =?iso-8859-1?Q?b/TxH71lZoPVytM5wX/x/kGXMHaXR10+RFNI/jdOaqKgiqFWPta3Q0FOrQ?=
 =?iso-8859-1?Q?0rG8/BebgmiK2sTGI/nxPCZ+ISQDvSJbNhCdi67Km+4EXEdzMBukcXmWiA?=
 =?iso-8859-1?Q?JUh7xlxgg+bjQhAczUrYpViggsb4dnUZscpex6sJfKNfDqWSxh91x2S9qd?=
 =?iso-8859-1?Q?cN5GjD8NzEwW2zG6eWhkPbYb71L3Vwonjv+42c6ijdI8VMsBkESQ+nMfgZ?=
 =?iso-8859-1?Q?RZYGSFiPYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Td1ELmmgbVRiZaJlGeQxJ7QbU91sjX/Rr7fQfZem+nR/qe0MeBOexa2iN6xz3wKNzrH2eK7Y/88YMNfEGwu72+elN1qX1/P/23dbU5vIo0BTivCuBZaz9Qk60sxMtN37YxriTld6suVgLB+41TtEktNJeGJpVsJ9zwoUXjt6LemUt2xY2vlIEKzjeCLk4ycDHjGCIA1+eHBRzYN7kaCrkYpBbRMS6WXY2usSsUDUxZD+MMGCL9J/jI15MlD82K6YfgL6Mn+b938C2qFEvcjEz40LwDk1st/gK6E3n5DKL5e6PIwVA/Qz6k7ofM9vpKrf5bGIunMqW3z2DBKizTIzQg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f47c92c-5d02-4f3c-4d6d-08df08981a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 02:15:47.7388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrYOMtAVufoS8R/PdEY3Otp+QCE34deWgd7x0p5prVmQRnDLeNud7Iii15g3YInOGbvFs6OH3F5jPAOfVqn6ZAaDPgyJGLL2sRR+oXfiiAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5782
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

Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC=0A=
and map its registers.=0A=
=0A=
The UDC and the second EHCI host controller (EHCI2) share one SoC=0A=
interrupt line. Route both through an OR gate whose output drives that=0A=
GIC input, so either device can raise the interrupt without the other=0A=
clobbering the line.=0A=
=0A=
The gadget USB device is not created by the SoC. It is a separate,=0A=
user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a=0A=
USB host controller's bus; it finds its controller through the "udc"=0A=
link property, e.g.=0A=
=0A=
  -device aspeed.udc-gadget,udc=3D/machine/soc/udc=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  4 ++++=0A=
 hw/arm/aspeed_ast2600.c     | 37 ++++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 38 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index cd68c7f1ca..fe7b31e42c 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -36,6 +36,8 @@=0A=
 #include "hw/gpio/aspeed_sgpio.h"=0A=
 #include "hw/sd/aspeed_sdhci.h"=0A=
 #include "hw/usb/hcd-ehci.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
+#include "hw/core/or-irq.h"=0A=
 #include "qom/object.h"=0A=
 #include "hw/misc/aspeed_lpc.h"=0A=
 #include "hw/misc/unimp.h"=0A=
@@ -138,6 +140,8 @@ struct Aspeed2600SoCState {=0A=
 =0A=
     A15MPPrivState a7mpcore;=0A=
     ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */=0A=
+    AspeedUDCState udc;=0A=
+    OrIRQState ehci2_udc_orgate;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..21db95f5ae 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI1]      =3D 0x1E630000,=0A=
     [ASPEED_DEV_SPI2]      =3D 0x1E631000,=0A=
     [ASPEED_DEV_EHCI1]     =3D 0x1E6A1000,=0A=
+    [ASPEED_DEV_UDC]       =3D 0x1E6A2000,=0A=
     [ASPEED_DEV_EHCI2]     =3D 0x1E6A3000,=0A=
     [ASPEED_DEV_MII1]      =3D 0x1E650000,=0A=
     [ASPEED_DEV_MII2]      =3D 0x1E650008,=0A=
@@ -214,6 +215,10 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
                                 TYPE_PLATFORM_EHCI);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
+    object_initialize_child(obj, "ehci2-udc-orgate", &a->ehci2_udc_orgate,=
=0A=
+                            TYPE_OR_IRQ);=0A=
+=0A=
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);=0A=
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);=0A=
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),=0A=
@@ -561,6 +566,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
                            aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 +=
 i));=0A=
     }=0A=
 =0A=
+    /*=0A=
+     * EHCI2 and the UDC share one SoC interrupt line, so OR their outputs=
=0A=
+     * together and drive that GIC input from the OR gate.=0A=
+     */=0A=
+    object_property_set_int(OBJECT(&a->ehci2_udc_orgate), "num-lines", 2,=
=0A=
+                            &error_abort);=0A=
+    qdev_realize(DEVICE(&a->ehci2_udc_orgate), NULL, &error_abort);=0A=
+    qdev_connect_gpio_out(DEVICE(&a->ehci2_udc_orgate), 0,=0A=
+                          aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI2))=
;=0A=
+=0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
@@ -568,10 +583,26 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)=0A=
         }=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);=0A=
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
-                           aspeed_soc_ast2600_get_irq(s,=0A=
-                                                      ASPEED_DEV_EHCI1 + i=
));=0A=
     }=0A=
+    /*=0A=
+     * EHCI1 has its own IRQ; EHCI2 shares the UDC's IRQ, so route it thro=
ugh=0A=
+     * the OR gate.=0A=
+     */=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[0]), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI1));=
=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[1]), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 0));=
=0A=
+=0A=
+    /* UDC - USB 2.0 Device Controller */=0A=
+    object_property_set_link(OBJECT(&a->udc), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_UDC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 1));=
=0A=
 =0A=
     /* SDMC - SDRAM Memory Controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {=0A=
-- =0A=
2.53.0=0A=

