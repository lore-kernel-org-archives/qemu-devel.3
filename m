Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA765F433D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsQ-0008KB-9G; Wed, 15 Apr 2026 21:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrr-0007wS-V6; Wed, 15 Apr 2026 21:50:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBro-0007PV-En; Wed, 15 Apr 2026 21:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jd7FJQjJsuvLjurSnFOYcFgXbfrdKnmhr6KzuAvUzhZPmnvqzCBn8blNaHw0YngnEWB/+hJQ4qXxj12gZKKgW+1w64k8tIm4afTNCiNhtu9rrUClbdNFk7YCxyDh9uRW32EHGPZ6KcmgPNuAL/L98doET4sAw1uMIXDHYTlPcjjPJLfd1cvMcyXL/LpquzWBVpeMZuQTbgbd6HreEA5GlUzTtjUkHOpSVlyWh8wKmHqjDOXzbats8chajvS1MANv+b/ruGR+EPLGFLsUV1bQMwMqoNiiYJaR6Rj6RHqb+PyoQjR2UkntrMFYLZ9NRox5vfoez6p36QesAvlz2nfnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4q66hhwagZTZEGQGqaAV0ODyaTqZRm0o8unDJhfnVw=;
 b=vohrSfcEzA2z3opXXxw99gWdYPQ/o5C7G1wlxvQjG56vk39xik/PZf7Z1XQBi0TZ5+gzSt+ms3gJWl/bIzAL1QS7wxIWHqRhBbDf1PZxu+zPOgP8t2K1QmqBHApXonm73vARfBoKWjGoAdPKjukhgCth4/PU8hnl0Z9Sg0kfWCvgDUyW9v+zdznqnMFFpwNfyH2WHjabt+savyrfc/eGw+M1HyqDtQr9ckuwitQrjuwmsoVuFIZtm1ER837mIQ4V8oJWgwFOxAAhGfx0KYoTRPB64GdNtNYJBcVmvORnh9WtXuhyYTW3N93lXcmFPk0W1P4IT/74gGxIowqKiP88aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4q66hhwagZTZEGQGqaAV0ODyaTqZRm0o8unDJhfnVw=;
 b=aBGTts1HzdDNZMVE3W7s9dkvUmj81b+kBfftfPKIm784eRibY/TyTqb+wOqoPV7Kfg9DX7ZrcREsVnBf0EThFzmuChQfe2IGm8KOe8MhxK+8UODJamhOoaC4DLgg4ACmWB7MAGcvJy4BtbJGGNrKgp/u4ZoX2WbkjKZar48XzPPznoHpir5DDkpMCR7OrUgLXW8HVCBxFZD3ZtFkpbZ0lbHZhjNTEURZzUrK30ILZF1LVA+bue+G2dP6qH4cf47M5J+43En6725NPR6iW9rUapCz2n4MN/g5TAPCbDzgynKUHdNrEoPjdNGXcz5PYaRU0xBzRhpdBGlYXMM8a0j9sg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v3 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHczUNObou9Fmh1/EmYf55F3wvnKQ==
Date: Thu, 16 Apr 2026 01:49:47 +0000
Message-ID: <20260416014928.1279360-10-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: b25839cc-6422-42e9-027a-08de9b5a709d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: IiwCKg3epFVNUP5jwriFbswYEN40LV75vlirYKw9bhKTeQAhUXL1IJJfdY/JJOP1Izj/wp9X2EMS9fspXruPDe0+pOluMgbdnU7RS+fvb4b3INMLa7sLkk7Po/OgTtkPOAq/xzhpqs7Z68vXxrsfgkXeE4DhO+93F71WJSvgskkr5rLoX6V4soYS7VlLw9niO1viI7uJft6RJphaiTGsuOmKHlhla3HlYtqBTNXhxHbRYa4pSngcFV7PynjVssyLxT316KVJxKyOZZ9CAiblzadoblrutryB8QkrgARD0I0A1WZv6CkzqvfA343TFy55oXdhU3A3sBDtZZKu5K2/ZQEpHcJWEW4jCbhdKI++yMaujdESoxThT4ILUEfiMyFd0F17iIq+jzAgHYbkZIgXxg2uJvMFUV9Om5i1JWAL1HAXS3XNabit+rOXu9k/1NK+OBeaVavpnk1sFZpk1xUNGRtn5hqhIgBCPU8lwGLH+1V1/6BzEScWi+/SI8dEoTiYY22Lny1LbCJ0l4fopVyH8EIAKszMU0DB9Iv1zQlBHTHMyOMbC3UG9GoPaeyTLEol+6jYnab8n+acHvKm9wsFLsV/NOpmrK+qj76M7BuXtCJs8vZkTGzEZ9ARMn2D8WjgmoUZt9kIT75+Yc+cNSEC1+d/rjfxyWqFAZqA6LdtHO55SHQV5BFjYhyemJObGRYUmVzxuZAwupbBuXXeu1NTJPiDS2YHFBM6G8B5ELiAcEUk3CjRk6Dk5n0XdfT51j4aBMu3Ewcc/EXL1gKcGZOx/kYssdzJ09LI3wy9NBUNTHXJrB6P6rOEN/NQnRnsqqEQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SILt1dXYKWb2aPUXrWabku+zCUtXHSYMK0pY2LtK0WqWYyUulrZAisvgPt?=
 =?iso-8859-1?Q?FS2HW01RPWJAkuCMXibC+RiM4oICJtCf5my30rXEFKtWkCQpvgw+xiQqGl?=
 =?iso-8859-1?Q?SJgmTjm1rZlRACBEPu7vJBYtYOpIXTsKoAM5TFHNYPM1x+odwoWORozYQ7?=
 =?iso-8859-1?Q?362GKQQ7rKi3YipF+9IN0+Nk6c4VcLE4EWd5VJyjGQBU415TJLoQ4zo4Vq?=
 =?iso-8859-1?Q?zxplPtKjOgmvda5q3dozFKBxI7HsgbPmzoLm4MOR00HIbVonaoW4OI+WjC?=
 =?iso-8859-1?Q?FtgXDSmvK6qmHLX4RIuJU09YdBo6HJudppscq9Ec+jtKoMju1xEPbmWyF7?=
 =?iso-8859-1?Q?N4LAFJeS12YmGDRvFb3k6/IrWUAh9iy0masTgosq2eZZvxmgNcE+JHFDdP?=
 =?iso-8859-1?Q?TmiQe7OJ3gaKBmex8x+hUXMlzWcRISvMuZEULbrv8THwIR5bvmU9YEBSYQ?=
 =?iso-8859-1?Q?Tnvk13ROcaSLt77ddGSckebcPZ+9hG8yJVZh5iWdQ42QHoQxg8YeUhkHrN?=
 =?iso-8859-1?Q?G+jqofSyIysTdLlyYy4dCqco8/s/I8l4VakxrIA3VECEtMmtmgCfFEkoCZ?=
 =?iso-8859-1?Q?7SQRV0Mz1f9jHBuRHdxa/wdtyQvR6YkY5DnTzB5Vn690pv0X66jqtZnF6b?=
 =?iso-8859-1?Q?ErQVPDgSuTtQr1QkmoxlOWL2SR8BrNhcgF7KwMRGhJWl0KZXJ7evU04niu?=
 =?iso-8859-1?Q?DWmW+4U6GVQgL3DaydS4jXRWu7r+DF9FHhINwCcv3/I7KcVznHK0R2+vYz?=
 =?iso-8859-1?Q?e7avu5OGA1BYH9ocdix6T7DBSfcjTv0PtIyWNw6slAKCsGDXLyomPsasoO?=
 =?iso-8859-1?Q?n4CltRDkMpslnQ0dUTlhsLCTAFtTKhBdk4h0xOK1cHO1gatLUAj9+fz+Ek?=
 =?iso-8859-1?Q?0lzZi1kUg81wDr3wi/o+txfpjL6z7i0kW1xwILkCVyP6qb/XuhKWikh/WK?=
 =?iso-8859-1?Q?mrPLqgqerVmeWBfmtZfWP+Fu+57aZP9rubl9uico3pRVwwYtk9tzBiPo+e?=
 =?iso-8859-1?Q?jwLA+o+P07Q2RvVvGVt/LBhajXk2MtDyRfl+n5DyMBjM0ooCib3+NIigJU?=
 =?iso-8859-1?Q?hbevuksY2mIwWRTpOSPbXvesMWvcOyejURV601IIoCC9ETizpOgwKSphKs?=
 =?iso-8859-1?Q?XDYHObRvUAJ+FLK+dOa1/XDoXf4L2Az3ie//e6Gei9o50qlhfp8VsSd/MH?=
 =?iso-8859-1?Q?vQXwNcNMCRsBDAkK1NsWID2VCFStMkGeJY1S9+y5iVxXZg934y+t5Vraer?=
 =?iso-8859-1?Q?FR8KH6ojoifVWFRhWzQflHG++LSxySsHcI5DvgefXDB5AvinOTx2gQMDaA?=
 =?iso-8859-1?Q?YqwooqwWBYC/KEBkFJ+ykOmbY4PqxP5Bf5wgRarFGWLpZaWXFIQLCD7sGQ?=
 =?iso-8859-1?Q?vUMkYWNPLirEe2Blt58XODkf3X2GP2KRYiWBegzRb/JGMp3TZl60cfImxW?=
 =?iso-8859-1?Q?Omj7W37OfFPzZ+LKahljPiqC2UY+OwjTkh6IrX9esqOqSidWcUujK6mzfx?=
 =?iso-8859-1?Q?HPqsQEEl+UpnCaCnpSDXDgrT/1dTf3jimd9+v7f1KDQ7kUdFdnbASdG0qS?=
 =?iso-8859-1?Q?U5egQstxYlLsp4pFGGu307zjXpOdm0UIo7NTX7UEfQ1H5E1skreUXRIU9y?=
 =?iso-8859-1?Q?vXeBL3YbxHRsDx0WjlVBWg8JkG/vZ7Pw0WUGJFsfmye6IHxGu7ZnLEH8JA?=
 =?iso-8859-1?Q?wxBBZWjCtnup9uFKySlh0/YuULR9Eaz57tK4XUsIk997h0glYSSHMvOHWw?=
 =?iso-8859-1?Q?BWWTJ5umwZkPV+fdKZeLFXJ2DwjmMq1ZLle9aL0WdUSJKaWmx9bnkEh21S?=
 =?iso-8859-1?Q?EGD3sDzhsg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: enSbhfOch9m/WoImIn7PrdAvPe2xD4MxYBv47twP7QJeagmKVOLSMvjlq84Hki7ABkBBvq/IXhcTnq3PgKfBzQ9lQzre1INEjH9SSdd+MwPz3hSewpnc45C7JEbkLR8zOHoAEA1MetAylOiRvwI8JrWFgI4MPfLhlWOqwuT68s/+T4FKK2XsLUpNdFfLs/lM/T8VD9lOH1i/p7ADfuy/2VDTLVax2q+6ANRYyqNo1djzYu83DX+rIDIxS/hm9oUVDA78BCp7CU/scxwzCc7wyOr48nk2x8Ljc70UxTtrtF420akdMzK2XjWTUAMiWv3LsytPwEmIS9V8F9pVHWucTQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25839cc-6422-42e9-027a-08de9b5a709d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:47.1488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Pnnl/6KMdG47rXMiKXJrZOdeAKe4/gGu6WBoY6suQ3Ix02Q0PgCiAzQGZ91AVuA9E5fuRvBYeSP4VDKYFXGV+Ixi+V9T28f4CKwY1nUsIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
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
the CTRLDSSEGMENT register supplies the upper 32 bits which are=0A=
concatenated with 32-bit link pointer fields to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
The current implementation assumes 32-bit QH descriptor addresses=0A=
and directly uses link pointer values without applying the=0A=
CTRLDSSEGMENT upper dword.=0A=
=0A=
Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit=0A=
descriptor addresses when 64-bit capability is enabled. Update QH=0A=
traversal paths (async list walk, horizontal QH link, and periodic=0A=
schedule entry handling) to use the translated 64-bit addresses.=0A=
=0A=
EHCI 64-bit buffer pointer fields are defined in Appendix B as=0A=
split 32-bit low/high parts located at separate offsets, rather=0A=
than a single contiguous 64-bit field. Therefore, the buffer=0A=
pointers cannot be represented as uint64_t bufptr[5] without=0A=
violating the descriptor layout defined by the specification.=0A=
=0A=
Introduce ehci_get_buf_addr() to construct full 64-bit buffer=0A=
addresses from bufptr[] and bufptr_hi[] fields. Use this helper=0A=
when calculating transfer buffer addresses so that data buffers=0A=
above 4GB are correctly handled.=0A=
=0A=
Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer=0A=
fields as defined in Appendix B.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Note: Similar split 64-bit buffer pointer handling is required for=0A=
qTD, iTD and siTD descriptors, which will be addressed in follow-up=0A=
changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h   |  4 ++++=0A=
 hw/usb/hcd-ehci.c   | 48 ++++++++++++++++++++++++++++++++++-----------=0A=
 hw/usb/trace-events |  2 +-=0A=
 3 files changed, 42 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index fe4c508c32..773f376834 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -141,6 +141,9 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
+/* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
+#define EHCI_QH_OVERLAY_COUNT 12=0A=
+=0A=
 /*=0A=
  * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
@@ -194,6 +197,7 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_FRAMETAG_MASK          0x0000001f=0A=
 #define BUFPTR_SBYTES_MASK            0x00000fe0=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqh;=0A=
 =0A=
 enum async_state {=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index b9e4251d62..37ae637e08 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -147,6 +147,24 @@ static const char *addr2str(hwaddr addr)=0A=
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_buf_addr(EHCIState *s, uint32_t hi, uint32_t low,=
=0A=
+                                  uint32_t mask)=0A=
+{=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D (uint64_t)(low & mask);=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr |=3D (uint64_t)hi << 32;=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
+static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)=0A=
+{=0A=
+    return ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -440,7 +458,7 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)=0A=
         (qh->current_qtd !=3D q->qh.current_qtd) ||=0A=
         (q->async && qh->next_qtd !=3D q->qh.next_qtd) ||=0A=
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,=0A=
-                                 7 * sizeof(uint32_t)) !=3D 0) ||=0A=
+                EHCI_QH_OVERLAY_COUNT * sizeof(uint32_t)) !=3D 0) ||=0A=
         (q->dev !=3D NULL && q->dev->addr !=3D devaddr)) {=0A=
         return false;=0A=
     } else {=0A=
@@ -1536,7 +1554,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint64_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D 0;=0A=
+=0A=
+    entry =3D ehci_get_desc_addr(ehci, ehci->asynclistaddr);=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1564,8 +1584,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
             goto out;=0A=
         }=0A=
 =0A=
-        entry =3D qh.next;=0A=
-        if (entry =3D=3D ehci->asynclistaddr) {=0A=
+        entry =3D ehci_get_desc_addr(ehci, qh.next);=0A=
+        if (entry =3D=3D ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {=
=0A=
             break;=0A=
         }=0A=
     }=0A=
@@ -1691,7 +1711,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
     if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
-        if (q->qhaddr !=3D q->qh.next) {=0A=
+        if (q->qhaddr !=3D ehci_get_desc_addr(ehci, q->qh.next)) {=0A=
             trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
                                        q->qh.epchar & QH_EPCHAR_H,=0A=
                                        q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1868,10 +1888,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
 =0A=
 static int ehci_state_horizqh(EHCIQueue *q)=0A=
 {=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
-    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D q->qh.next) {=0A=
-        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);=0A=
+    addr =3D ehci_get_desc_addr(q->ehci, q->qh.next);=0A=
+    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D addr) {=0A=
+        ehci_set_fetch_addr(q->ehci, q->async, addr);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);=0A=
         again =3D 1;=0A=
     } else {=0A=
@@ -2200,6 +2222,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
     uint32_t entry;=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
+    uint64_t entry64;=0A=
+    uint64_t list64;=0A=
 =0A=
     /* 4.6 */=0A=
 =0A=
@@ -2224,12 +2248,14 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
             break;=0A=
         }=0A=
         list |=3D ((ehci->frindex & 0x1ff8) >> 1);=0A=
-=0A=
-        if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
+        list64 =3D ehci_get_desc_addr(ehci, list);=0A=
+        if (get_dwords(ehci, list64, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
-        ehci_set_fetch_addr(ehci, async, entry);=0A=
+        entry64 =3D ehci_get_desc_addr(ehci, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8,=0A=
+                                              list64, entry64);=0A=
+        ehci_set_fetch_addr(ehci, async, entry64);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 8c90688bb3..67249d69c2 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -113,7 +113,7 @@ usb_ehci_dma_error(void) ""=0A=
 usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
 usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
-usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint64_t list, uint64_t en=
try) "frame=3D%d, list=3D0x%" PRIx64 ", entry=3D0x%" PRIx64=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
-- =0A=
2.43.0=0A=

