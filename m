Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8B606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ITFxLs2U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGE-0007Wq-IY; Mon, 02 Nov 2026 04:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFM-0007LK-GT; Mon, 02 Nov 2026 04:22:33 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFK-0000Yb-6e; Mon, 02 Nov 2026 04:22:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY4jyuncL/jyqXxR3Wg64ANrpq5+HqpjfdRuOICMR5ty7T60XObp+HiIAK4uoMgGlAzFqGhZw0qQA/FMJeQhI43l/Mr1WYv8tGUEBbB+znPOqVp/D0XtJbj03B/xWiaOI8vBhbJlnZFr3OtbDUrunwedmTIdHj4XpOvXAHdAOgucmJ6i4zWm6gJ/U06QvgRUt0T0Nll74TB1Wh7+Ib188P23VoZSAHDOwYrpC8AtKs/y3sSYWNg4PDAfLNgQVSI/Tk/C12AQDh0uypZF+UCOVokDYqp9xRGkGIecB769PabM54DzrYZ0LD/L5fS3n5rKZ8UZYrUorVaPFATyj+udcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOCKnhAngp5J9sy19IWEJJNbBB8dRjj0l68AW4bPQTw=;
 b=Qkr4vmtChgJvK1BfHyeMN+Gsrlg/b6SAzUcGwnE6oo1Z06BLzWIB/YYPTcQT5eoNfgjRZrkcHCfFcu/X8zp/T6Myd3njMWSE6cEHHPr50C3PevNl4s12dB8g0dbmanj5coETFcMgJdMMoTdyFINlOjOT39/NOfciFRZjIlZg9WXxKMmnEb6YyWzqjKOvrMi+Yg3ObUK0t2HRXuxomqdLbWvlDVuPe+u51qTV36KlhTz1qduwk2Wgdhp4qbfOH7eVbAfA3QZM3XcDwr1r31cMcl9XsiadepqHuMdhq3nWKR/RjMGAaI17he1bI09JBllOGjrvxhHFGYqrYfDFXJXJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOCKnhAngp5J9sy19IWEJJNbBB8dRjj0l68AW4bPQTw=;
 b=ITFxLs2UbqdqpOJE8Aq8iKbt8GrJep4/n5M+/lC9WdGYDrhJe7//4PakThD5Pj8+WH1nd6uetm+0uZ+y2EkAIqaVKvgrY8xKHLBmYGn1zb6OgaTfJeH4mnkmgDfRIfrcQoA2StWLsGr06jvIrKzMHWfa2A2ZJQJYKxA7/ZY4DX8esvWqijvgPjGHAfWn2MQJnhcwr1q5Kk+DcqDh42a/qvySx38dr0oInSB+/ng0CSI7JIMifNYqLWSq8+kC9kCQZPnxW6juzFlM6LcEfUmXmkXwxcn+cA9uRVWP8S+reo+jDZlxoalH7aCwEuF4DK8lMIoo49iS4gFB1++ZmUr+WQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6938.apcprd06.prod.outlook.com (2603:1096:990:67::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:24 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 12/18] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v8 12/18] hw/usb/redirect-server: Connect usbredirparser
 to a chardev
Thread-Index: AQHdaqupk4VbrDEBxU6nbgiHGzQ0cA==
Date: Mon, 2 Nov 2026 09:22:20 +0000
Message-ID: <20261102092201.1729245-13-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB6938:EE_
x-ms-office365-filtering-correlation-id: bf9e78e2-5127-4c10-0586-08df38c2cba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|921020|38070700021|56012099006|5023799004|261021133027099003|261026135527099003|261021121427099003|261021130227099003|261026130827099003|261022115727099003|261022113327099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003|261021135927099003;
x-microsoft-antispam-message-info: My9ihqG0UNecVIK23bTCIk+ItDux9VJ4rLSvshpO5ey5GZj5uCzrSVB9YrGotImaUpKOFqOM/VQZQU6ojC7s8oWw2D3QN3TEJWn4/1ThnK18oJ40LkRHCLVnURemqyH28jeTR1mls7EQYaTbA1Nvp4fjWp7wOzOOcm78PjyeFhpl64YiGbdJIXM4sVJJyLnbCxuC1kKYUrAphpze4Krs1ne0YIWs9+z7abBdOT88QH3ZWmB1WTFN9/MxhOotgxYPHk61E571FEMQtMAGEb/APKCYdrslvfnOGgpk4OSxFd0RSKUtprU/+JQqQBdbMaiI8om+yjEI1S2oJ7TqQ4iCPuaJPPa6Y+8gyabZ/4XTnzlN7EHgDO02X0uqVXUy7FSPh3XiCdpDcJaWPaQ4/jcOdzB3LDez8rA9cPwX1WKVAPF4TlWfusU660SIDTtNiwq36ETYYuamdxixAz9V1dxbX1jkvJH+gW1cT2TpofruDlvsDnTfehBYOeeJ2rEV3kjJjg9W4mlwoI2/nllg6+qejPxWn5im1NUUivHdVQILojjRPTTDEhPj9084P/KwfXcjH+2BkFTy0e/F/RiDBj5eIHgRHfH+gXxuJ1NtaMvJaQpSENj5TJEFoz44IqndaZMSB5qTxqPhW15GCcW4V7d5pADFjgw3/h7kTPctMPA28XIXB843zOEEP4ahLsMosY0PPvehYGVQT4kIW/KHZTbs0meMnSBNrojvIN2ZeFV3e6mmZwk6XacIkFPp+FKR+VCb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(921020)(38070700021)(56012099006)(5023799004)(261021133027099003)(261026135527099003)(261021121427099003)(261021130227099003)(261026130827099003)(261022115727099003)(261022113327099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021135927099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kSpyAhkRkMgfqPVBp3p3y42nREea3DOB2XiCQPvTagTvt6Yd+ANugpHjJ5?=
 =?iso-8859-1?Q?Ef9HDAQPyCILsPIXvt2ovoTRhoGdCRd6FDGrhLPBRm3tC3v88cowDq11Hq?=
 =?iso-8859-1?Q?Jeb6tOLF/ZfV6/VH/jCEITuam9m87z/wH8lV9pq+lBGiGOxCjrYA330i3W?=
 =?iso-8859-1?Q?GfP9tc/FcavGqGFuD5yo+tgiSQHvC1CW1D6cAZP9RL3iIHFCaf/AMomOxM?=
 =?iso-8859-1?Q?+6lJcC/eIckCC7GYsQBcJ6NeTu84qCgh/ULj5CUlhgJUwxa3l7QFJrVK2l?=
 =?iso-8859-1?Q?90vtrYeBXlNuOsEaExiIrCUlrPERAAoaC/KJiiKXJE8UFAsByrgUY1RnI8?=
 =?iso-8859-1?Q?hNWGqRFPZXV0mooEcb25LexqbnA5NnaY4KdvjEDrN4pwdWvZ3efjGSf+cw?=
 =?iso-8859-1?Q?hf29p7LP1tgQ/K5kfOuXyABrCy2VW5nmFrFGZ/DIfmxE294jG0g7tE4VTF?=
 =?iso-8859-1?Q?OxB9Flsa1xZe+d9UhGXj4uBjvxCscB0oxtRmEI4VnXlfcm0OaXG4YTiKBo?=
 =?iso-8859-1?Q?AgQwE8gmdM6zL6M3PVc16tzQ7m4j9dszJoELHE+e5228LVOvl27TPNqZyP?=
 =?iso-8859-1?Q?iLf8xMFtDQzQWYFOzoc26/9J2OChNvCjA52XLRSYB29+82ZA0P5jFKZ3OR?=
 =?iso-8859-1?Q?u5crONKL1AXqhOg9nBoaK3Jqfv4TwivtSJVOCTHBAKRGh2daXHHTrC4PuB?=
 =?iso-8859-1?Q?eiPj+tM7lNc9i1v2Yd2EsYb++f1gO6iM8AcdWK8APMqkX/b9r7s6ETdzG8?=
 =?iso-8859-1?Q?OlASfH5ODRaaLCyfxPkU0m5vT5dBEPux+yvNt+Q6ka7mF+sNWWbTpTzBPh?=
 =?iso-8859-1?Q?hjeuGcqC7omtfPjLlJvfSG0xpDcmg/BpRQo7PV/tTIh8ZS530eMAklCcF0?=
 =?iso-8859-1?Q?/3FZK0b9TnFDDRWOMdXeAUQ7GAl/P8mT5/RD8TkydTY8ZGzNHBJkAegEEv?=
 =?iso-8859-1?Q?Rg6lLsnD2ZR0ijAeXnpmICtjBvgCM6XILQu02i4DIxzBTnpaqEOPJPeX2p?=
 =?iso-8859-1?Q?FV7tzRAjrVG1KNQGrYCrB4g5RPPuQtIjKs+zAqEIQhWZypDyvoFWgyYbye?=
 =?iso-8859-1?Q?2dXxAYSW1tp7GCcMsIvskFGBKULQcV03ymCvwUc/33zWxpY8a07+rE+G/5?=
 =?iso-8859-1?Q?sKThClcRhKA4T2aZ5z1Mu5/ZtCr7OomSdGcaekKoDR9PuLYj4RpDb09CHD?=
 =?iso-8859-1?Q?IEB7CGncq3PRmhLNbqSgB/VoUoCYUINrzFTIl1WT23vipFB5j4JdaVZv4X?=
 =?iso-8859-1?Q?DgY+nK/UBdpejMeipzRFJEWypsWLAfKa8fz6ZVylE3sJ4iQ/elBnBdoByd?=
 =?iso-8859-1?Q?OPUWdxtQN3uNjlYegccvjXD91BCbGKgPnazOt37vJt5MgU3zhntezesLGV?=
 =?iso-8859-1?Q?NplvosDmmQjLSnoBqs5hRus87tv+0r/RGJjhrOZMleJ/AvkgFEc1HwAOTS?=
 =?iso-8859-1?Q?RrHvNG/EkvpFFi92VYlwYKHWjlb6CU2jQobnI9Kw1dDFjpQecrP2pJ525v?=
 =?iso-8859-1?Q?0fvIuRl6ynIVHWK8N1L6GiXkOwdr5SaI36M/eKcKHHcixdtL2oURnbTHJ1?=
 =?iso-8859-1?Q?m+EITOKJLmQhP5U8ZNhLkSe528FaU5/6src8EiOFzEbWhQBoOgcSHBK2pG?=
 =?iso-8859-1?Q?2+e5NS1MjGysWW75H6Jl8QGuevCST+YYQ5TPkFjf32Q5aBpgVKCIdqgjIP?=
 =?iso-8859-1?Q?OYxur5WvHjRBxwUdm7/uIKcVKC8RvkoJtoXoybxp/1PfiSFI66apPrdY+y?=
 =?iso-8859-1?Q?kchBNOjWeZBDRH5QYVFbGze3bUN1OCopZl4gVN0xcZYy1ucJo2cegKOmNs?=
 =?iso-8859-1?Q?rX3nWnE/6g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JpdWGLMUBvSRa5nSJDXlHcDiBnW81IQhII0UgSh27sj6mJq8rYSN7sWoXF8ffEaLwq8Y0PXTt3+IKAaXXICDEmPEhvXWIuCBSwYWhztupLzJptW3EYxUNod6CTgLx7YGhF26QBv2mihnFujnaH6F9TF2RsnEx7d2WGLIR4l8i8vlZPFJnCORpXxvscmnzXyelhl5L7G+LZpcjAVbvfBXXdnFwqGVmNFJTg74C1djHvg9aJkbkCz6lNVwXqBh8oa7sfN7DIklt5CYTVonO1gFqFFNYUi1la79RS9JHTtHsPe4g+z5CGrNRsyaLbUQLAnQ2mMR9Sdhf1ydat+Oda+PUg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9e78e2-5127-4c10-0586-08df38c2cba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:20.1035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjPDsXeG52IzYCzQ4W3vy5Hp7gtgbjEG1CokJKUxwNLsW9ft/c0wR0EzbPjB61qIzuVsDDWXHvEIVLHV9tvzaTvcmDpTz2Bj3uA/aiAn39U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6938
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Create a usbredirparser when the chardev opens. Feed it from the chardev=0A=
read handler. Destroy it when the chardev closes.=0A=
=0A=
The side that exports a device sets usbredirparser_fl_usb_host. This=0A=
side drives the device, so it is the USB host for it. redirect.c is the=0A=
other side and does not set the flag. The library uses it to decide=0A=
which direction a packet may travel.=0A=
=0A=
The chardev handling follows hw/usb/redirect.c: take no data before the=0A=
parser exists, do not write to a closed backend, do not re-enter the=0A=
writer, and let a close that is still queued finish before a new=0A=
connection opens.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 285 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 291 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 1423564d22..f78351bde9 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -50,22 +50,46 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
+#include "chardev/char-fe.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
+#include <usbredirparser.h>=0A=
+=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "trace.h"=0A=
+=0A=
 #define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
 =0A=
+#define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     /* USB bus */=0A=
     USBBus bus;=0A=
     USBPort port;=0A=
+=0A=
+    /* Properties */=0A=
+    CharFrontend cs;=0A=
+=0A=
+    /* usbredir over the chardev */=0A=
+    struct usbredirparser *parser;=0A=
+    QEMUBH *chardev_close_bh;=0A=
+    const uint8_t *read_buf;=0A=
+    int read_buf_size;=0A=
+    bool in_write;=0A=
+    guint watch;=0A=
+    bool host_connected;=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -94,6 +118,233 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
 };=0A=
 =0A=
+/*=0A=
+ * usbredirparser I/O and logging callbacks=0A=
+ */=0A=
+=0A=
+static void usbredir_server_log(void *priv, int level, const char *msg)=0A=
+{=0A=
+    switch (level) {=0A=
+    case usbredirparser_error:=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    case usbredirparser_warning:=0A=
+        warn_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    default:=0A=
+        trace_usbredir_server_log(msg);=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static int usbredir_server_read(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    if (s->read_buf_size < count) {=0A=
+        count =3D s->read_buf_size;=0A=
+    }=0A=
+=0A=
+    memcpy(data, s->read_buf, count);=0A=
+=0A=
+    s->read_buf_size -=3D count;=0A=
+    if (s->read_buf_size) {=0A=
+        s->read_buf +=3D count;=0A=
+    } else {=0A=
+        s->read_buf =3D NULL;=0A=
+    }=0A=
+=0A=
+    return count;=0A=
+}=0A=
+=0A=
+static gboolean usbredir_server_write_unblocked(void *do_not_use,=0A=
+                                                GIOCondition cond,=0A=
+                                                void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    s->watch =3D 0;=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    return G_SOURCE_REMOVE;=0A=
+}=0A=
+=0A=
+static int usbredir_server_write(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int ret;=0A=
+=0A=
+    if (!qemu_chr_fe_backend_open(&s->cs)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Re-entry guard. The chain is:=0A=
+     *   do_write() -> this -> qemu_chr_fe_write() -> chardev feeds us=0A=
+     *   -> do_read() -> a callback -> do_write() again=0A=
+     *=0A=
+     * The second do_write() would walk the same buffer queue as the=0A=
+     * first. Returning 0 means "sent nothing", so the buffer stays for=0A=
+     * the outer one to send.=0A=
+     */=0A=
+    if (s->in_write) {=0A=
+        trace_usbredir_server_write_recursion();=0A=
+        return 0;=0A=
+    }=0A=
+    s->in_write =3D true;=0A=
+=0A=
+    ret =3D qemu_chr_fe_write(&s->cs, data, count);=0A=
+    if (ret < count) {=0A=
+        if (!s->watch) {=0A=
+            s->watch =3D qemu_chr_fe_add_watch(&s->cs, G_IO_OUT | G_IO_HUP=
,=0A=
+                                             usbredir_server_write_unblock=
ed,=0A=
+                                             s);=0A=
+        }=0A=
+        if (ret < 0) {=0A=
+            ret =3D 0;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    s->in_write =3D false;=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+/* The remote host greets us once the socket is up. */=0A=
+static void usbredir_server_hello(void *priv,=0A=
+                                  struct usb_redir_hello_header *hello)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    s->host_connected =3D true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Parser setup and teardown=0A=
+ */=0A=
+=0A=
+static void usbredir_server_create_parser(USBRedirServer *s)=0A=
+{=0A=
+    uint32_t caps[USB_REDIR_CAPS_SIZE] =3D {};=0A=
+=0A=
+    s->parser =3D usbredirparser_create();=0A=
+    if (!s->parser) {=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": failed to create usbredirpar=
ser");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->parser->priv =3D s;=0A=
+    s->parser->log_func =3D usbredir_server_log;=0A=
+    s->parser->read_func =3D usbredir_server_read;=0A=
+    s->parser->write_func =3D usbredir_server_write;=0A=
+=0A=
+    /* Callbacks for messages the remote host sends to us */=0A=
+    s->parser->hello_func =3D usbredir_server_hello;=0A=
+=0A=
+    /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_ep_info_max_packet_siz=
e);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_64bits_ids);=0A=
+=0A=
+    /*=0A=
+     * In USB the host is the side that starts every transfer; a device=0A=
+     * only answers. The exported device sits on our bus and we issue=0A=
+     * its transfers, so for that device we are the host. That is what=0A=
+     * fl_usb_host means, and why the side that exports a device sets it.=
=0A=
+     *=0A=
+     * The other QEMU does not drive the device, it receives it. In this=
=0A=
+     * protocol that makes it the client, and redirect.c leaves the flag=
=0A=
+     * clear.=0A=
+     *=0A=
+     * Without it the library refuses to send device_connect.=0A=
+     */=0A=
+    usbredirparser_init(s->parser, USBREDIR_SERVER_VERSION,=0A=
+                        caps, USB_REDIR_CAPS_SIZE,=0A=
+                        usbredirparser_fl_usb_host);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
+{=0A=
+    s->host_connected =3D false;=0A=
+=0A=
+    g_clear_handle_id(&s->watch, g_source_remove);=0A=
+=0A=
+    if (s->parser) {=0A=
+        usbredirparser_destroy(s->parser);=0A=
+        s->parser =3D NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_close_bh(void *opaque)=0A=
+{=0A=
+    usbredir_server_destroy_parser(opaque);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * chardev callbacks=0A=
+ */=0A=
+=0A=
+static int usbredir_server_chardev_can_read(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return 0;=0A=
+    }=0A=
+    /* usbredirparser_do_read() consumes everything we hand it */=0A=
+    return 1 * MiB;=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_read(void *opaque, const uint8_t *buf,=
=0A=
+                                         int size)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* No recursion allowed */=0A=
+    assert(s->read_buf =3D=3D NULL);=0A=
+=0A=
+    s->read_buf =3D buf;=0A=
+    s->read_buf_size =3D size;=0A=
+=0A=
+    usbredirparser_do_read(s->parser);=0A=
+    /* do_read() ran our callbacks; flush whatever replies they queued */=
=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_event(void *opaque,=0A=
+                                          QEMUChrEvent event)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    switch (event) {=0A=
+    case CHR_EVENT_OPENED:=0A=
+        trace_usbredir_server_chardev_open();=0A=
+        /*=0A=
+         * A close event only schedules chardev_close_bh. If it has not=0A=
+         * run yet, it would destroy the parser we are about to create,=0A=
+         * so run it now and cancel it.=0A=
+         */=0A=
+        usbredir_server_chardev_close_bh(s);=0A=
+        qemu_bh_cancel(s->chardev_close_bh);=0A=
+        usbredir_server_create_parser(s);=0A=
+        break;=0A=
+    case CHR_EVENT_CLOSED:=0A=
+        trace_usbredir_server_chardev_close();=0A=
+        qemu_bh_schedule(s->chardev_close_bh);=0A=
+        break;=0A=
+    case CHR_EVENT_BREAK:=0A=
+    case CHR_EVENT_MUX_IN:=0A=
+    case CHR_EVENT_MUX_OUT:=0A=
+    case CHR_EVENT_RESIZE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Device registration=0A=
  */=0A=
@@ -102,14 +353,46 @@ static void usbredir_server_realize(DeviceState *dev,=
 Error **errp)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
 =0A=
+    if (!qemu_chr_fe_backend_connected(&s->cs)) {=0A=
+        error_setg(errp,=0A=
+                   TYPE_USB_REDIR_SERVER ": 'chardev' property must be set=
");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* One port: usbredir carries a single device. */=0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
     s->bus.auto_hub =3D false;=0A=
     usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
+=0A=
+    s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
+                                              s, &dev->mem_reentrancy_guar=
d);=0A=
+=0A=
+    qemu_chr_fe_set_handlers(&s->cs,=0A=
+                             usbredir_server_chardev_can_read,=0A=
+                             usbredir_server_chardev_read,=0A=
+                             usbredir_server_chardev_event,=0A=
+                             NULL, s, NULL, true);=0A=
+}=0A=
+=0A=
+static void usbredir_server_unrealize(DeviceState *dev)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    qemu_chr_fe_deinit(&s->cs, true);=0A=
+    usbredir_server_destroy_parser(s);=0A=
+=0A=
+    if (s->chardev_close_bh) {=0A=
+        qemu_bh_delete(s->chardev_close_bh);=0A=
+        s->chardev_close_bh =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
+static const Property usbredir_server_props[] =3D {=0A=
+    DEFINE_PROP_CHR("chardev", USBRedirServer, cs),=0A=
+};=0A=
+=0A=
 /*=0A=
  * The link to the remote host is a chardev, and we cannot migrate=0A=
  * that. So this device cannot be migrated either.=0A=
@@ -125,8 +408,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
ass, const void *data)=0A=
 =0A=
     dc->desc =3D "USB Redirection Server";=0A=
     dc->realize =3D usbredir_server_realize;=0A=
+    dc->unrealize =3D usbredir_server_unrealize;=0A=
     dc->vmsd =3D &vmstate_usbredir_server;=0A=
     set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+    device_class_set_props(dc, usbredir_server_props);=0A=
 }=0A=
 =0A=
 static const TypeInfo usbredir_server_types[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 80ead23358..d141661673 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -393,3 +393,9 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uint=
32_t iov, int ep_idx) "ep=0A=
 aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
 aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
 aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
+=0A=
+# redirect-server.c=0A=
+usbredir_server_chardev_open(void) "chardev opened"=0A=
+usbredir_server_chardev_close(void) "chardev closed"=0A=
+usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
+usbredir_server_log(const char *msg) "%s"=0A=
-- =0A=
2.43.0=0A=

