Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7Kk-0000EF-Gh; Sun, 12 Jul 2026 23:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KK-000091-Ha; Sun, 12 Jul 2026 23:27:28 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KG-0006VO-0s; Sun, 12 Jul 2026 23:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlU4ZIea4i1ugN8U3wJQ/c9OKRBsYzfLEGtzSbeGzZ43YAyK3mT7zWR1RaijFqS8h2v7xbwM6GDEMrJeibNx3F/XrG9eFRXgKeyd7QFAtcYxOmf9HYSRpixnDdH+kZ4OB0UoznCY6TvYwDW4OGkAm8cPtFO13g12pASMHTDoeir+0zZTX+L3sL6eV2c8E/K6b7JZEjSeDA9rskz6+ftpG8FjYX5yb74exCCSqcFdyVElgSZWYkkzCGBVM+GgkTG5lCFEAUBuOibOFWjC5Vj6OPef9OT8NnsfXMx8ZjwoQ3nUorL8FgLObVgvY62+qJYtbdv+e6kOoVJO7RhJefhFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6JMsf++gQL45eiRLo9DOg9CDkaa/X5/z57/NP+3nhs=;
 b=brnQWgmFRpLHzrm3pgpO22Oki+/UJ3p9o0Gf8AVu89+LAf61R+GjoaSQFcZ4FizxsX//Z6MQHlObTMW9rKHq7VkTKAQSJ78ifg9rSyFQhrUL/OtDWLOan4UR+nsDD04U/e/HPQbUY3rigyxKSkFZQWEiSgCcWm6IP/9SqdgK+8tcONzTAtDlraPycQ3HwnH8Fg7WETbmYSHruT73SkC/nfY6bnAX0IY3CKGlISSON+qFajsU0Rqfju8xLkEUoVzP9/JgXiMDX+fuvDb+pTjTyJ/gs535E5Q+Fs7e49vjub1l/3jugCFrJYx/7NbB00kxwe1/DP/1RnWhRJc9CevC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6JMsf++gQL45eiRLo9DOg9CDkaa/X5/z57/NP+3nhs=;
 b=oClYlHQCiWVuYcE/bEgnbMrROc2CjiTDHslHiVyzN97iBy3EKWE9hzhrRLA9MU05Q7mk+yywKB+nnUL+nvaxuIbUEXuQNcXUHGNeSe129Avoo46gNMOymCaug+ruB2O9ux3i4+6ZhD9uYxAYucYrMil95DPUBHkXzotREasVf304AiUvXLjYzeuazDUuIKmkVVvAmEjqnTbRu7z20XHhrOOr+o8TM7bw6Qh5C1GMFzvF4dMuKa2j7JsFTwtckuSW3+r0XQm68nTS4XxA+17ijtBlqRm/5BJk9PnhE/VDS4tI6gL5xQm0ZiAzOMd7TH8EKKvUrJa+y61nSzYoJ0uGNw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:12 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: [PATCH v7 04/10] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Thread-Topic: [PATCH v7 04/10] hw/usb/hcd-ehci: Implement 64-bit qTD
 descriptor addressing
Thread-Index: AQHdEnd+VHK5gNLuRUaB4+ALR9labQ==
Date: Mon, 13 Jul 2026 03:27:11 +0000
Message-ID: <20260713032704.3583103-5-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: 48ee6066-7bf5-4b92-e7d6-08dee08ea0df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|6133799003|921020;
x-microsoft-antispam-message-info: l3zV/u2GSfOcmviCWcyAx196/ijAT0uO65qT0fnl/NoJhl1A7sf3zc1tQABh03ndg5rHXY792jVKixVCi+qCs3cyN0is1Z6LaauyIEokZBz3WlWaFD9i3lJaS32l9LeI6y3YrY3dbgyJnAoZ5oLZrEsVYzXdRk2J60XGS+fkerxAOAogvh3BCImAs3p32jkTK2UR8W5b7HelQYqVaBjJWvvazFuV8Hj3lhglhs5vwmC6PkRJbzqEKCAgVOS4VMsNG5+RHB8X2MrdgNZmRY8pt3NA5Cdxez9MXsibGKDHzKq/IQgP+7WcgVMKOO7FFZdWPe/YKdOqxum0fAZJr62Ok2Xl3Azf6pHZuGFXzOc9N4iQjS3IdfJgBy14JzN+23lQC5QCnKiThkRURnoHDTNj5d7a460Pzx9E1c1cYDnv1Iw4z46vN8vyLGysFdjmM0kFJnKIu1p/OygIgQHpkG+gwvvpZeWtiV3wR46PSE4ilKX+q5+nQSpcs37R0ERllXmwudI8fmD7L0rGS7EIQgbY7cxfjf+zxXrab1efh0tcknNucwPoPN9h0RLvoGQd3t7nRHD9QL2zgpL9vkE6DmP5n73UVjA+6bcf6CEcOev+eV6TfZEqiSLZx4ILi/yd8RWIkcnEwvSgIf5F7f8nyUnp4FGQRtHJnS1wuOlzcn0FuhVDmMTJW6nJ/XOX26cZFJV5kPkIxNISzP7OQ5b2qF2ELG4sftC1p+m9KARNp+ZveTjTUfJBjk+9XWwCyk+7cBlF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e2IdSmJpacqqA+51/VYAGsb1aVmkxJzRYCuuHZkjou+p/ZJ4OP8It909v1?=
 =?iso-8859-1?Q?Q90eEjE781IoJvp862OfMwlAolYicgCsw+L2Qtjg05S1j6T1AAktKPAlZv?=
 =?iso-8859-1?Q?An6AzNqS0sFwCjMKmU8TqDrtHsQPOf/QbzVzN0kV6YuRso0AM4lAEAhL1O?=
 =?iso-8859-1?Q?XwBZXDuU633HoedJdaEFCgbR31lXUjedSnl/Oe0oCPczKuzzw9AjbRSdWe?=
 =?iso-8859-1?Q?0XDndkQ7yRvO/THA7JEVhoiqFbtVcjVvGpJ5k3byxoqmxGcRtioC2btJOb?=
 =?iso-8859-1?Q?M6efDj730/F3Lt+S0vZ0kXPbK38AUc73xJ93frYS48fWtYjSzwOLG0L7CO?=
 =?iso-8859-1?Q?zu5CQugDUdrM+kTyMT0SPiUv59aivYCk0heq2jT8eAgdsz5k0DrJcRKt8o?=
 =?iso-8859-1?Q?+E3ijZTL6+k1QP4n7PChzOh4je2urD676A/ZFAcSsDBNwcfJkT9nFQJx5F?=
 =?iso-8859-1?Q?Yr6rNubB9aHipaIUAzFZpXvcD0KKT4FI/gtvi4cf7cVX9ITxirMTS2LHjb?=
 =?iso-8859-1?Q?ak7MOVm1PrC+G04Rn94pjvG17v6u04mVLwO57fGszfqG2MYyjVg9Ck0Top?=
 =?iso-8859-1?Q?4AqMEeQiv70OI+TBVb0/wg/6QM7QbyO6zee+Ws4K53GKo6cH06pPBuJiWi?=
 =?iso-8859-1?Q?G7n4vOs2d7shDz7CvV6YZEsnK5C1v2qMYuFNGWU9Je6JDUoxftmIRI8UDw?=
 =?iso-8859-1?Q?JjmH4aOdS9ph4YQgNIoZUidiCKyXK9W7i5HwV5ZZhyGECq/+ydFSXi7xSW?=
 =?iso-8859-1?Q?cq9MPVTSm/oV4/UV6KGIf0XXUBS30bDn75hu/EoqseYuqYbWaclVoNVe7S?=
 =?iso-8859-1?Q?entfqe7Hm173zlka2adIuJ3D7JTHNo4Jk9bgxBNH+5mIw0dZrQJUccjcoU?=
 =?iso-8859-1?Q?N6kSG3/dlw3xTAXohxNMWa9mpgwNrBXGDCSw+SlPe8Pffck368S3ZTVOTp?=
 =?iso-8859-1?Q?PEDLzP5xbLy1sDZwqp4L1sKK1qjK6YlXifeE31L4fRQAG/UWM8HSg5nBgM?=
 =?iso-8859-1?Q?aPenb3GtwFFgFcfGfJq+lS/RGHkgGr7BKfZgC2PJ7kfETiLFmZKBRiGsah?=
 =?iso-8859-1?Q?jFjztthyjaubghUoQDbMPgFqRZbRpzUKREj382P5hhANzcyVJUAU8hjuyx?=
 =?iso-8859-1?Q?lFUh04j/D9KOZPfS46QycTE6cYySiAhX4H/KUX4GtiJ9zimy70JcDTZXe5?=
 =?iso-8859-1?Q?YURTgJBkdqH6gC7YALn4ulVfJj82nD35cWLcMFzQFh0bDMnLTFt5lZF/Zi?=
 =?iso-8859-1?Q?iVJzVplKP5F5ZE5Kmokfff1uJxIuorlFGi6u4/P3LgFfM0WJ6z/RO0XcEU?=
 =?iso-8859-1?Q?csw0lB7YyJljy/s7UWKB+1SpdGmjhn8CjYIhRu9qvpCUp0D9UENA00V+aK?=
 =?iso-8859-1?Q?BkcN+J9I2QNGj8hLDmw3wNSF54EEOYGiXxAt9T68VsGb0Xr9wFhponveos?=
 =?iso-8859-1?Q?+ZIxZO6S+zinEJPUmMQSZp8aQFIDCd41NfiBnN/+xFZxDBsVYsInrROUF+?=
 =?iso-8859-1?Q?D5k6CN5ldZEZMOMpKNuJpuKEUnVJ2NNSEldDdaVi9Da5V+yGa5LK5tKaKM?=
 =?iso-8859-1?Q?h0lY448lotjSmmZoKk32pt1ZgCBZYzrus0LogBfI8Q2oU2JcJ4EmCr/yOm?=
 =?iso-8859-1?Q?/Wy5IUhdnKIUDfCke8RRlfxxzi8neJGr5ax3pzkWo8OvbSiA0G+lGV3WF5?=
 =?iso-8859-1?Q?DRUauLF3CJF0ZlhMWznkM70BSRiKHS0IFyhUR88zZzT4j6c9hqmNp1fznu?=
 =?iso-8859-1?Q?ZP8zxhrxKDNHW+322Z6WF2t0Df32bYYvprdBhfvq0X3otTeIwRCxgyMg+J?=
 =?iso-8859-1?Q?DS/eHdujrA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T2P6IWBR0szD7E48U1UpNoWrcJ80CRvSWcY6uJPOZZOsh3l1M2wO9rCUWLQanZcS7zy+9rP5iLg+4+IuOm/aYfcg/0FUHhsNWBrci9SpkGuH7G2Eb9Xu569GssVKiMXe9qD9V3g/b6f5raKC+RLnRVtN/wh8upF0E9CYjz2lFx9g+sQj3A0qLn+Wg5LGcEA1Zx+TiEu9BJgXSFsMfXOMhujxewfDCxOytlIuo4frW0Xmm2Nz48lm9wFcZYt5FzhGjTwhGJp/2dzpZY//NsqUXlCwPGxsxUGTZ++xTU7dTTlU10xLIja8/snMwJhakcZQ9UGX62jsiGDR4NpFR9mUdw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ee6066-7bf5-4b92-e7d6-08dee08ea0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:12.0886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDV4C8RgYn247hl+ysQi8sQOFHK2T9qWQZ1TThBQLQC/VVRcOeW36Vnmd2gTSE1zfM3RXmPLFf7DFvasR9xhPap+5GzDOLXJKSl7hXX6Y7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
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

EHCI supports 64-bit addressing when the 64-bit Addressing Capability=0A=
bit in HCCPARAMS is set. In that mode, the CTRLDSSEGMENT register=0A=
provides the upper 32 bits that are concatenated with 32-bit link=0A=
pointer values to form 64-bit control data structure addresses=0A=
(EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
qTD link pointers (current_qtd/next_qtd/altnext_qtd and qTD.next)=0A=
are stored as 32-bit values in the data structures and must be=0A=
expanded to full 64-bit descriptor addresses when 64-bit mode is=0A=
enabled. Update the qTD traversal paths to use ehci_get_desc_addr()=0A=
when following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for qTD buffer pointers.=0A=
Add bufptr_hi[5] to EHCIqtd and extend qTD fetch and QH overlay=0A=
handling to load and propagate the high buffer pointer fields.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  1 +=0A=
 hw/usb/hcd-ehci.c | 33 ++++++++++++++++++++++++---------=0A=
 2 files changed, 25 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 8732264fde..7fed206906 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -139,6 +139,7 @@ typedef struct EHCIqtd {=0A=
     uint32_t bufptr[5];               /* Standard buffer pointer */=0A=
 #define QTD_BUFPTR_MASK               0xfffff000=0A=
 #define QTD_BUFPTR_SH                 12=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqtd;=0A=
 =0A=
 /* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index fd5be7430e..947af86ac4 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -104,6 +104,7 @@ typedef enum {=0A=
  * must not read or write past that boundary.=0A=
  */=0A=
 #define EHCI_QH_DWORDS_32   (offsetof(EHCIqh, bufptr_hi) / sizeof(uint32_t=
))=0A=
+#define EHCI_QTD_DWORDS_32  (offsetof(EHCIqtd, bufptr_hi) / sizeof(uint32_=
t))=0A=
 =0A=
 static const char *ehci_state_names[] =3D {=0A=
     [EST_INACTIVE]     =3D "INACTIVE",=0A=
@@ -178,6 +179,11 @@ static uint32_t ehci_qh_dwords(const EHCIState *s)=0A=
     return s->caps_64bit_addr ? (sizeof(EHCIqh) >> 2) : EHCI_QH_DWORDS_32;=
=0A=
 }=0A=
 =0A=
+static uint32_t ehci_qtd_dwords(const EHCIState *s)=0A=
+{=0A=
+    return s->caps_64bit_addr ? (sizeof(EHCIqtd) >> 2) : EHCI_QTD_DWORDS_3=
2;=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -486,7 +492,8 @@ static bool ehci_verify_qtd(EHCIPacket *p, EHCIqtd *qtd=
)=0A=
             (p->qtd.next !=3D qtd->next)) ||=0A=
         (!NLPTR_TBIT(p->qtd.altnext) && (p->qtd.altnext !=3D qtd->altnext)=
) ||=0A=
         p->qtd.token !=3D qtd->token ||=0A=
-        p->qtd.bufptr[0] !=3D qtd->bufptr[0]) {=0A=
+        p->qtd.bufptr[0] !=3D qtd->bufptr[0] ||=0A=
+        p->qtd.bufptr_hi[0] !=3D qtd->bufptr_hi[0]) {=0A=
         return false;=0A=
     } else {=0A=
         return true;=0A=
@@ -519,10 +526,11 @@ static void ehci_writeback_async_complete_packet(EHCI=
Packet *p)=0A=
 =0A=
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchq=
td */=0A=
     memset(&qh, 0, sizeof(qh));=0A=
+    memset(&qtd, 0, sizeof(qtd));=0A=
     get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
                (uint32_t *) &qh, ehci_qh_dwords(q->ehci));=0A=
     get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
-               (uint32_t *) &qtd, sizeof(EHCIqtd) >> 2);=0A=
+               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));=0A=
     if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
         p->async =3D EHCI_ASYNC_INITIALIZED;=0A=
         ehci_free_packet(p);=0A=
@@ -1215,6 +1223,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 =0A=
     for (i =3D 0; i < 5; i++) {=0A=
         q->qh.bufptr[i] =3D p->qtd.bufptr[i];=0A=
+        q->qh.bufptr_hi[i] =3D p->qtd.bufptr_hi[i];=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
@@ -1248,7 +1257,8 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
             return -1;=0A=
         }=0A=
 =0A=
-        page  =3D p->qtd.bufptr[cpage] & QTD_BUFPTR_MASK;=0A=
+        page =3D ehci_get_buf_addr(p->queue->ehci, p->qtd.bufptr_hi[cpage]=
,=0A=
+                                 p->qtd.bufptr[cpage], QTD_BUFPTR_MASK);=
=0A=
         page +=3D offset;=0A=
         plen  =3D bytes;=0A=
         if (plen > 4096 - offset) {=0A=
@@ -1744,7 +1754,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&=0A=
                (NLPTR_TBIT(q->qh.current_qtd) =3D=3D 0) &&=0A=
                (q->qh.current_qtd !=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.current_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(ehci, q->qh.current_qtd);=0A=
         ehci_set_state(ehci, async, EST_FETCHQTD);=0A=
 =0A=
     } else {=0A=
@@ -1822,14 +1832,14 @@ static int ehci_state_advqueue(EHCIQueue *q)=0A=
      */=0A=
     if (((q->qh.token & QTD_TOKEN_TBYTES_MASK) !=3D 0) &&=0A=
         (NLPTR_TBIT(q->qh.altnext_qtd) =3D=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.altnext_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.altnext_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
      *  next qTD is valid=0A=
      */=0A=
     } else if (NLPTR_TBIT(q->qh.next_qtd) =3D=3D 0) {=0A=
-        q->qtdaddr =3D q->qh.next_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.next_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
@@ -1855,10 +1865,14 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
         return 0;=0A=
     }=0A=
     barrier();=0A=
+    memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));=0A=
     if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||=0A=
         get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||=0A=
         get_dwords(q->ehci, addr + 12, qtd.bufptr,=0A=
-                   ARRAY_SIZE(qtd.bufptr)) < 0) {=0A=
+                   ARRAY_SIZE(qtd.bufptr)) < 0 ||=0A=
+        (q->ehci->caps_64bit_addr &&=0A=
+         get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),=0A=
+                    qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)) < 0)) {=0A=
         return 0;=0A=
     }=0A=
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);=0A=
@@ -1939,7 +1953,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
             break;=0A=
         }=0A=
-        qtdaddr =3D qtd.next;=0A=
+        qtdaddr =3D ehci_get_desc_addr(q->ehci, qtd.next);=0A=
         /*=0A=
          * Detect circular td lists, Windows creates these, counting on th=
e=0A=
          * active bit going low after execution to make the queue stop.=0A=
@@ -1949,8 +1963,9 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
                 goto leave;=0A=
             }=0A=
         }=0A=
+        memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));=0A=
         if (get_dwords(q->ehci, NLPTR_GET(qtdaddr),=0A=
-                       (uint32_t *) &qtd, sizeof(EHCIqtd) >> 2) < 0) {=0A=
+                       (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0) {=
=0A=
             return -1;=0A=
         }=0A=
         ehci_trace_qtd(q, NLPTR_GET(qtdaddr), &qtd);=0A=
-- =0A=
2.43.0=0A=

