Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7KQ-00009z-0d; Sun, 12 Jul 2026 23:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KF-00008M-Nd; Sun, 12 Jul 2026 23:27:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KD-0006V2-3x; Sun, 12 Jul 2026 23:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waLTME7KHPDohz76E2fyGfPyrg+vFavO8naJaXyoH92MkUvjnILVpYCNu5HJCqd8hsm4LdTbh1ztdpMCpK79AaBfyYNJ+e/uCfYa2zHTVQEqzrx3Z1xwKBzhi3FpVUeu3ozNJY3WRlQC9f4TQBHg2nIEu2AGTsctFqH0lPICN4L9seshWEmT/2AX/FmI1XXDIrGKStLVs0luAPHoivS7AQyeB8XqmgTZtQgCg9BxN61mD8xMV949ZWS7g/gRwupO0WJJfCXAalxp4cLuFWZt+4v3A6Jk4ItcHO7WkAFmC1aMov0TULO9eILGKYz44yn+gT1netcoomA6fTOODZkSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG/+nHBo83upt9t8gav8hjMaupJSBrYeBWoCFzogx7g=;
 b=V0Nz/JDZrwJ5BsSqvhCubKnW77U8YY+L1W7AatuSudsV3ma1q91btfFULQry30HBphMNxugoCTnRqXWfG87/NU3REVJwv86HJtn1M8J+t8GiqqragWIp8DNP5e+TTscFtCUKhHFzXjCjOEyGkx/qJD9hNfpLyPFNZIURj8ahgyGCxfcJp7AFQpNDVLmVtczEJp2Uwja98eRqI9Sciwk+U74AH1k49XFgztpsK4Xkl7NP1/f/Ei3v+/I2FVZg2hDgqCvdBa9pzCk23CjuOkEHhCO1DZKWHW6jZjP5yttLX8Vmrx6vGkm171fe5cVtQQ0JCRJ/Ah4PMMG6VESo4Dio+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eG/+nHBo83upt9t8gav8hjMaupJSBrYeBWoCFzogx7g=;
 b=ppEdtfjCLxSxBaiDMHFzV5RvEoKZzgwjEy5gKVOgKGJEwMDdDuE9fxHzEzJp4pK4p31yteEBm+lo7IAhPsiuuisHu0nMqR/XoXCAg2CWf5H2uoprUej/WOb+6eagMkYj5l2fLVzeyNowmvp7o8QR6DE+hkOoqkhpfZVtfEW+l/JUd75wAinVwj7cQEFqQ+UX1gXBzOImHkljyaW1BhWvBwA6ex/gLMhmbo2D9JhFoMv/0s57WVR3rMY5XcSuM6w7fiSFQHPNxID7uw8oqBsgqoqHi3we5LUb0VBpDhwSFHPqxNCYGbsZQDtoyiSKr2OhTb8nykpKCSC8jGGJlU4fxw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:10 +0000
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
Subject: [PATCH v7 03/10] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v7 03/10] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHdEnd9vHssPppjykSsqRuYDqVF0A==
Date: Mon, 13 Jul 2026 03:27:10 +0000
Message-ID: <20260713032704.3583103-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 87a37b1a-ced2-4952-7f3a-08dee08e9fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|6133799003|921020;
x-microsoft-antispam-message-info: xCPlbWryqNnc27p+Q4fSIqcaW4klQ0DDBJNeEQ8jWazTZ4QwDSbS+YReo3tuKoDsCbBwJ/mmO7KCZC0fEZl/DMJn3Y1wx7Ero6pfGX5r7ZPld41WEhmwN4EwWb9gxjkfHVRGgE4Sw6EGbw0lpAp0smSzUWZOzC6mHfa74Our2ORBmBHieE4Fw26WpHI77z98TY6pm+R2LENV+naEMsiQcThc3ijHp0Z3+Xj7hsRYvQUh+UtuaRZkN3xbUJurrClM1he3cFaro8lxh++wctS1FIURFdDfWlcGT/NBH8/S4oTrStNQFcXm14FASKMWqk1SWwY3jIMkiyj9axOBYfDU36ShuRh52RnGNTvm63/FGh7ay9HkcDkWUzjFgn7bepYtmxUl2czA6UvZ0pSnKHWhqo5z6kyYZBVmMz2ixw8ifACEiFYYJl9AwtigKfypGfJo2d8iUMaWMRcxItqXGvFgL8rW/iqiaU4KEDHUpK1NfFEcyxju1NCv3iehR9G6DtulZcqul/ubjUeAD10Vbd1VyedyD2ybGl0C+EIDOBRzAxQMvrk2c1/114kNS5iz34nRd/Ree8mXCGnc79UZOX+AjCT9yYORW/2UxseoW9N3lBvUVIpLebvZPXiV1WdoyoXSP4+bIig4iYOIX4/ZAO52q+I2iwJ1SA9qt4AbiirdINTgnMJ6A4nIu3SHwlZ/FjAxuaK2drKrgmRzasBuGA+N5AOfRHlentGPNvvgEheJyncUKs/yWY43USPLCDpLVLsr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pMoJNtVseoVuwwBio45PdlJj3eG3Ou3T97oQA3Q+ha2xc2bWLR+e4TcHsh?=
 =?iso-8859-1?Q?LxXxa+W4gLngRBm2RtxGBM06nMt1kE6LYZFNhM4pJdN32p9rKjCW3eTCaA?=
 =?iso-8859-1?Q?kcC+JGJJSFXNyrG2nP26f35e4luk2h+dzVexwiNG4eKKTjDPZszOQh6rw3?=
 =?iso-8859-1?Q?buYYmx2x7YfKgE5tUFw9h39HYleWov5Z6N9OMLOx3U0KHLsTteA+7xBo8/?=
 =?iso-8859-1?Q?zlbjRVV+DEDpU86v3DXIo94EftyiCsIKeWpepBVUYJxIHKqYW9uHt5glgi?=
 =?iso-8859-1?Q?lg5+kwXIqnBwOHkhcBrNgGSZDaejhK/STiarZa2FWgH4vEi821X9LVCxvc?=
 =?iso-8859-1?Q?5igbkSf7fZ+vPgkk6+K3Ay0tbHOJgtwT+Y80jWJD/Xcg7C9h2+PJxAVg7s?=
 =?iso-8859-1?Q?Nd7545E9SEAv87BE7REOw8gnBJKeE0D6XLZBAYzRLOxReAJVS/mNSCUk8l?=
 =?iso-8859-1?Q?pv1m32/N4oBu+jUIvG6aZQ4mfRQ84ILJYk/LQqTHgg3E2jooaLGRYYDAAL?=
 =?iso-8859-1?Q?QQniSVSLu5XWq6aqpMLv4VgPvogLAONBgGdWbk/LRBAfGPDvCGPgBktaLr?=
 =?iso-8859-1?Q?IGHYJPbNx+MwjpXgvUuQE+GV/fPvep9bQztnbNk9xMzW7VQP7BOcTKxzhY?=
 =?iso-8859-1?Q?YMO14Ovsu9sKoAc0tvsqQ4ZNBOW/bXAJa6Hm10/W+t1Y5ZKUQbRVM50mcu?=
 =?iso-8859-1?Q?Mi8pYC/kyeXa/Hq9TNszxbjWXf53iSRXZNeNhXMVPsH+tKsWjoYGUPgLjn?=
 =?iso-8859-1?Q?aDnWT+LZ4EcKikLpynZ3UyM3MbP2LfWVUyD3vlg+PKCSTGUZEslwDxWXXE?=
 =?iso-8859-1?Q?antF1Eod1M9DEAGNqtVKCMtEFBmKS+b+esR8I2sTqvFCn+UjX4LKcOhkle?=
 =?iso-8859-1?Q?vLPqQrE4aLj6c7iPK3gxJ0dIgoiYxriVgW1jxzKpJ0TFpBVROPQ3yWrx87?=
 =?iso-8859-1?Q?Ud5R5sw4mu4KewZ0x5nKtyQpugdyhzfKLNeS+LX59J6cXOp9DVJQ50zExA?=
 =?iso-8859-1?Q?OvXXP3w9O/sFEqUwKg4v9nlBfl7IjfSRk+XbTSdI+umh3UXghk31VVxZ0d?=
 =?iso-8859-1?Q?2pqSQxdp3fmc4PBIZO4qrZhAZYJPckXfp077mtcI4rSH0fOCMQd0jObKpO?=
 =?iso-8859-1?Q?3gHuwIjXl7J6y8jklDGynKw0Ikhh/N+pa6w0rNRiwY62y1tUkiwWh0O/d+?=
 =?iso-8859-1?Q?UZI5ki2J+JG1FCgZ8eb5LT1aMhWc0d4APxXhBoq1q7g8z8IENRLhVMnUPi?=
 =?iso-8859-1?Q?Ab8r718Pdus6JnqXnb2rbB7rVjqlfUcMq+AGY6hs68J4HS02MXAvx16bFq?=
 =?iso-8859-1?Q?EPFB688AO+B+eF9fJzQac48lfu6RvSbhuqV8zw6JjEJL/FDm/5I3xdpt57?=
 =?iso-8859-1?Q?gO4NdiMWB6NIOSxJk2xsus3EFi9y7mc0eMA+w5YxfvEjbEpF7wsCyWqmgp?=
 =?iso-8859-1?Q?WdGaTRrEShL6zrFegIFPW0MrF3bt81ymEP2H7tODb5CAgSIDs26eF5BsXO?=
 =?iso-8859-1?Q?//nnDyQiQy5hqbm4hxW7spqADrqVfd3zI2N+1THA07P1Kn9UJFAt6JDhLZ?=
 =?iso-8859-1?Q?z09JLGc3X7RM//j/suJEUuk3ICTMefFjnaSWBQM2jA6gDY0DG89ddp1mTK?=
 =?iso-8859-1?Q?h1OQJkDBif8gyLNMuFZQv4K2YmaYCbW0WLeSeHX2+VBuSftNaQUDcbx5mr?=
 =?iso-8859-1?Q?QcmVJlasegqRSRU+pPxYbRk1+n0UoRZlx9509MxrZH4N8hPY87TCH3R6Od?=
 =?iso-8859-1?Q?onTV4Ol/QVhcUXYdaBGvQ3oN3IZqR+YidnKgMxYdKi9CJq52ehtpjNLrTK?=
 =?iso-8859-1?Q?/qBnddji4A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gFbadqbmPeL1YMxL9DeUdK3zo8DafNhh58fgLPdnEF6Cpr6EMLDPSStfX0Pa0h1DnA/BGTCpmccO1h9s4rfCKHZPzSxKRrC0xAfAPMQtDI+zepo59aP3H949jYHjwNmw1DjZC/mWdg/gnsc74zDLH9sVPb6IcwVUrwo+SshQ7fEnEAXWoW1+OtPOSGf3vSOFCU82JniXrUoII/KtIy0kCotNSuzjMFyx1e4S7if2mGV4TzYE9HwkMaXozCqinBdACN50t62J/A8ikrzlxA1yNcv7bOQkF7G9JU5nD2uJvsh9w7S6r1GKz4SG93Pplk3xPg6+0NKsOK4ya9sZG3mKdg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a37b1a-ced2-4952-7f3a-08dee08e9fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:10.5646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQ1gvVWZSn2qbqYxMIiTGKXV7h1/blzLAAC2mR4/M6jj3LFV9nSsWyTcLyyYnM80fvHDpToDlu2lxHDwRPcNl0WvWCEaFqExBkFuSSGBrEM=
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
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h   |  4 +++=0A=
 hw/usb/hcd-ehci.c   | 72 +++++++++++++++++++++++++++++++++++----------=0A=
 hw/usb/trace-events |  2 +-=0A=
 3 files changed, 62 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index f739e6371b..8732264fde 100644=0A=
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
index e65ea825b0..fd5be7430e 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -96,6 +96,15 @@ typedef enum {=0A=
     *data =3D val; \=0A=
     } while (0)=0A=
 =0A=
+/*=0A=
+ * EHCIqh / EHCIqtd / EHCIitd are sized to always include the extended=0A=
+ * high buffer pointer fields from EHCI 1.0 Appendix B. When 64-bit=0A=
+ * addressing capability is not advertised to the guest, the descriptors=
=0A=
+ * in guest memory only have the classic 32-bit layout, so DMA transfers=
=0A=
+ * must not read or write past that boundary.=0A=
+ */=0A=
+#define EHCI_QH_DWORDS_32   (offsetof(EHCIqh, bufptr_hi) / sizeof(uint32_t=
))=0A=
+=0A=
 static const char *ehci_state_names[] =3D {=0A=
     [EST_INACTIVE]     =3D "INACTIVE",=0A=
     [EST_ACTIVE]       =3D "ACTIVE",=0A=
@@ -147,6 +156,28 @@ static const char *addr2str(hwaddr addr)=0A=
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_buf_addr(const EHCIState *s, uint32_t hi,=0A=
+                                  uint32_t lo, uint32_t lo_mask)=0A=
+{=0A=
+    uint64_t addr =3D lo & lo_mask;=0A=
+=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr =3D deposit64(addr, 32, 32, hi);=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
+static uint64_t ehci_get_desc_addr(const EHCIState *s, uint32_t lo)=0A=
+{=0A=
+    return ehci_get_buf_addr(s, s->ctrldssegment, lo, UINT32_MAX);=0A=
+}=0A=
+=0A=
+static uint32_t ehci_qh_dwords(const EHCIState *s)=0A=
+{=0A=
+    return s->caps_64bit_addr ? (sizeof(EHCIqh) >> 2) : EHCI_QH_DWORDS_32;=
=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -440,7 +471,7 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)=0A=
         (qh->current_qtd !=3D q->qh.current_qtd) ||=0A=
         (q->async && qh->next_qtd !=3D q->qh.next_qtd) ||=0A=
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,=0A=
-                                 7 * sizeof(uint32_t)) !=3D 0) ||=0A=
+                EHCI_QH_OVERLAY_COUNT * sizeof(uint32_t)) !=3D 0) ||=0A=
         (q->dev !=3D NULL && q->dev->addr !=3D devaddr)) {=0A=
         return false;=0A=
     } else {=0A=
@@ -487,8 +518,9 @@ static void ehci_writeback_async_complete_packet(EHCIPa=
cket *p)=0A=
     int state;=0A=
 =0A=
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchq=
td */=0A=
+    memset(&qh, 0, sizeof(qh));=0A=
     get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
-               (uint32_t *) &qh, sizeof(EHCIqh) >> 2);=0A=
+               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));=0A=
     get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
                (uint32_t *) &qtd, sizeof(EHCIqtd) >> 2);=0A=
     if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
@@ -1143,7 +1175,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 static void ehci_flush_qh(EHCIQueue *q)=0A=
 {=0A=
     uint32_t *qh =3D (uint32_t *) &q->qh;=0A=
-    uint32_t dwords =3D sizeof(EHCIqh) >> 2;=0A=
+    uint32_t dwords =3D ehci_qh_dwords(q->ehci);=0A=
     uint64_t addr =3D NLPTR_GET(q->qhaddr);=0A=
 =0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
@@ -1538,7 +1570,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
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
@@ -1548,9 +1582,10 @@ static int ehci_state_waitlisthead(EHCIState *ehci, =
 int async)=0A=
     ehci_queues_rip_unused(ehci, async);=0A=
 =0A=
     /*  Find the head of the list (4.9.1.1) */=0A=
+    memset(&qh, 0, sizeof(qh));=0A=
     for (i =3D 0; i < MAX_QH; i++) {=0A=
         if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,=0A=
-                       sizeof(EHCIqh) >> 2) < 0) {=0A=
+                       ehci_qh_dwords(ehci)) < 0) {=0A=
             return 0;=0A=
         }=0A=
         ehci_trace_qh(NULL, NLPTR_GET(entry), &qh);=0A=
@@ -1566,8 +1601,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
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
@@ -1651,8 +1686,9 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
         goto out;=0A=
     }=0A=
 =0A=
+    memset(&qh, 0, sizeof(qh));=0A=
     if (get_dwords(ehci, NLPTR_GET(q->qhaddr),=0A=
-                   (uint32_t *) &qh, sizeof(EHCIqh) >> 2) < 0) {=0A=
+                   (uint32_t *) &qh, ehci_qh_dwords(ehci)) < 0) {=0A=
         q =3D NULL;=0A=
         goto out;=0A=
     }=0A=
@@ -1693,7 +1729,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
     if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
-        if (q->qhaddr !=3D q->qh.next) {=0A=
+        if (q->qhaddr !=3D ehci_get_desc_addr(ehci, q->qh.next)) {=0A=
             trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
                                        q->qh.epchar & QH_EPCHAR_H,=0A=
                                        q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1876,10 +1912,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
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
@@ -2205,6 +2243,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
     uint32_t entry;=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
+    uint64_t entry64;=0A=
+    uint64_t list64;=0A=
 =0A=
     /* 4.6 */=0A=
 =0A=
@@ -2229,12 +2269,14 @@ static void ehci_advance_periodic_state(EHCIState *=
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

