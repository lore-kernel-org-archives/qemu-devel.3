Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608660A260B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=rMyMiXHf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGH-0007at-BF; Mon, 02 Nov 2026 04:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFR-0007MF-42; Mon, 02 Nov 2026 04:22:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFN-0000Z0-DC; Mon, 02 Nov 2026 04:22:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBhgURZC4kAlutZz6m376WyDbffd1PhJAbcoWqvE1efQIKuuTeABhcCrQrhie4X75R3SokFaqrGiGpGMPPD3embmDPioIAnK21p/Y0qXLn6kty2ou6yRRahnrtPxZIaOOzJKndx6Sbg3PqgIccIhT5ATIXicwx/49n5l3zdRyry2PP9uLiGQkop8GRNgwt3QH6UHlH3zTnh+q6f0DUhZdNf2a2BSUiUqu81NFJVCNDw+XIj9mwhrKc69IEApjAaPueieyUwfyM4mi8oPkicWaD6wagTMN4zWIAhwFejvHqALgIXi2dHX+OlWB+qOL69ZUdq9Rv/EMX3qFD5kgozLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfiFEH0CPSP8FOE1AeNeCKARq0aAKEWFbvucorbqrbQ=;
 b=Rp1AlIgBGwL7It4Jm2FWRupfKBPTFYXZR/B9c1k5nzs62du6vYDvvihQRZyVkbQfwkpvNEUe36ElbZQz85FoU1g91EXPPgqvPygu5xjKrJNZu+nw7tNBaWq8EgXEcw0TuFnaGTEau6u/TJgEzuSSQrY57j2UR7WQjGawhzhOkhShZpTienBGHB4xaO+bMLcgFg1wCfMNCSYhIaBPR8oiUtqr7X+XJ0I3anZn2bZkyGSd1g0cP3HokCqVvpaDHjp17S91coDWihMICabjIq85jhMWMfFU6HlUDYgTPHx4P3y/3zKSHxj9w94n8AlJRhAfuonJYka+32SevxjKaFK6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfiFEH0CPSP8FOE1AeNeCKARq0aAKEWFbvucorbqrbQ=;
 b=rMyMiXHfB7MrUMak+lD8qqtmUraSv0kiYGByrQbmTsYJyL0OXX7rNh2MVHcTLONQoLCqAQ0uY3RCt3wPoao+/hv6zPVWVmrlFZDmuufWKFBoE6mTvhITlQh8vUcGD/j8TjawSy1me+2V0Cqj7ywldRwMrUJXVomcGMsY1J8h+VikdhLLVJZrMHLx6FNKZxPxhhC5cjQgWxXQygfo2QFgs5p5np6DamIhsH1ZI5xc7dQ1cBFzWLFkfh7d+zri/YEZl2s+67KAjSZednaXqfVtI0auaYJvRjHbC86AWXEjo9B8LxHsc85vh8zvIKmUY8apblmbxGxuPPJ8WjuuHIZriw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUXPR06MB8030.apcprd06.prod.outlook.com (2603:1096:d10:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:25 +0000
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
Subject: [PATCH v8 13/18] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v8 13/18] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdaqupvmzo6sFN+0K1iqt887RtJA==
Date: Mon, 2 Nov 2026 09:22:21 +0000
Message-ID: <20261102092201.1729245-14-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUXPR06MB8030:EE_
x-ms-office365-filtering-correlation-id: 195a2571-f597-46b4-1310-08df38c2cea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|38070700021|261021123027099003|5023799004|56012099006|261009223027099003|261028144727099003|261021121427099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: wDAyTwNva6DwCxBJQzw+YeNiKbHcjUTYttq9nb6aFUpgLhTCzOJvyeaofpHxTTSC6KkEn28ZgvNAi8DMxr3QX2PdOSFmnvdbMnJ1KAh8fL3XkHXN4Z0ZzjKbtuy/e/pHsaLEo+0kqwhLYWJbYR9k3aFKcMzWv/3vZh24x/aIv/4r09nyGgXUXExZFlpqa5dUuQKZZlvMUqUFv1AD4AVKnU7+CZOKO86EuwaZSwjP2s8fGFNzjamdBR8qfjcLzdV+bABSE2LMKfyeXrCcFyFfuNjI1Qd/FFTin3DszRvVdpnBUEA2cI1Mq4m7PTuAkEHDsDT1EwsiIx3dxXaLIlMUk6gdYppy8ppShBy9VitLm8Qqwu5aivb4BzUJQwZnUhwMzqqZTGY/k2vZqr0HaT9az/PfDwQbf6ru3EZUkdB0xmZVy86s5H4QwKlaDIpeaWGD6PBr5v/rBVICqlkYtCNdbmuWIXTSPMMmnHpKCLOnsQBTHPeTd4n8tuD1Rlhj6ed3AQoacPYP3G1L/FMp/q5hmLM7L6x51NDj5V3M4no+RiCuH23rgqm60sFdlDEzNlkwGN+0gKpC+xvAKQ9/pLNC39s1kzNyCnspOeMkOSskdCldBT1jb4OYNmpCylelztEcgYHbljTmD0ZcjPGpTqYgJqGhoB4qSm5gMd9W5P7DBFoxaNW6eR3Zfm1IiUGZBp5s2pxR34Dq3EEQr2YBovr+4Iv++BQEqqBj+V0iSKOIPM3Jh+kdvZaTJXG8NOzYsTU/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(38070700021)(261021123027099003)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KkIVq+EXHyJqp5857ge1GF5I3PTcyvr3CCxRM4Qn/UpTgvuzzY7TovRbNC?=
 =?iso-8859-1?Q?N/w9581x7juD6UhXlJgYVAEg+RfOthypuNg+GW5ea8WPp6KbK3xsZ5zPf1?=
 =?iso-8859-1?Q?lWUl3nCaF8j1rKqocWvFs15z8MUSc22294j35fHP/xEJxnviOUZJuO3mEy?=
 =?iso-8859-1?Q?ki058vhF4OoGuZsrVf1yiwVf6j3qVeMDLfbTg7lmho/huIJjC98FW8uXD9?=
 =?iso-8859-1?Q?WVaFRc469ucyqjJj/1k0XkB2G8e7rkHWny0qyZPRyfWYB2EWwC6muEkaNy?=
 =?iso-8859-1?Q?RJDwAsf0wSouVWeoBc5lVURp0wrOPVqdCJv9plooABu5zmFSYfvwm4ECyY?=
 =?iso-8859-1?Q?JYQrjSciXREfOuSnEKBOBpTxtDJyBzs6Vcrpo34ON+xe6gQp2hkME5alGj?=
 =?iso-8859-1?Q?q9nJmCCw3+rCHmv1C50savYlQqxKVScTFSibqKjgbw5sKGPdKOCoQIukg9?=
 =?iso-8859-1?Q?4CthbeVQ42mUBxqA7TPKGuFYXZFz1ieBTsqxLh5+2fZ5JSrI8txf+jDeyN?=
 =?iso-8859-1?Q?i8686aQEHSAK1qSwPIgmg3wGkGQuKbrO0BLBTr9/BQoG4sAcAFrL6pyynT?=
 =?iso-8859-1?Q?ufO/JgGhX7wh3lmT4y5bS/VWPYFTLrJRbT7g4jvDWDugAFd0Yuenytv5/e?=
 =?iso-8859-1?Q?sGzCr+Aw4eriGzx/IoRFkt16J9MF3GJK7yV4ITz2s39j0ZVuKlVYqAZQAB?=
 =?iso-8859-1?Q?tuPySxxL5aaO8e24bsWPKdcxSGJjOpka8sknMrf7aWByeZN4ICYZmQrZTj?=
 =?iso-8859-1?Q?LW2/LbTkj+WLBgrlJ//xS9MbV4Uqqj6YxIntA2/q/q05WLlNztalSxX8R/?=
 =?iso-8859-1?Q?85uFgRZ3GWbbPKasQR750ogSz9ND9knencmK1b8a+aVzbedTufD5u5Dbxp?=
 =?iso-8859-1?Q?YrHSfnc+CdPu8/8QkRpWAfwl9iEjExFW7vj8xMu2WhcExLNCh5O2V/vafx?=
 =?iso-8859-1?Q?Rtor4x76DuJ2I9AtQIarM84RU16Z55L2OCokJYHN1V1GqSK8TTzZtq4Jrb?=
 =?iso-8859-1?Q?i5q+8IqfDTEaedNiQd7auXVjwW/2RktmWdgGmNAPauH2HRAAapRKBIFcEW?=
 =?iso-8859-1?Q?Q/PvePO3nR0SdHYUtP7k52x71wfDp9FNjSYxOXZuI2p4ANdDXVJ1C6bblg?=
 =?iso-8859-1?Q?zBnLxK+/8wLbQzRILZoPZJbiwegviORurT1iuAFW6OIIIKrVxo0hEVhQ1Z?=
 =?iso-8859-1?Q?+HGL623CtyCZ957zbnhXmeuOEPoAhgQmU/75fq+0BErsvDrhf5L5+TMcly?=
 =?iso-8859-1?Q?op1JPvqR6gyDuyEfxHteApF3NH4xJ390uOzTCC8hKgbpb9WVT9OnFDwLgu?=
 =?iso-8859-1?Q?Eak0DRfaZZ0kvMkZrMeqGvlqfj3yUbNsYRjSLyKdhaUA5uEtjN8YsE9FH4?=
 =?iso-8859-1?Q?d8wDBfY8En6TPnzn2u1gnG6sPv/H/Fq+PAW6g2VEwFv1zFVCPngf3yFpAh?=
 =?iso-8859-1?Q?nl4yP+DjhTK9wN4tRQb9Qoy1xsbp2TsFBqenaFcuW/g5pL8yVLSZZM/Q3B?=
 =?iso-8859-1?Q?ePQJtdRnGya+5zV3P6393fa1TyG2PRwgO+u6mnrjXzxlpFzDBD1jaHGzZz?=
 =?iso-8859-1?Q?bbPKxp3JKrkh6awJuDqhVCNB9ae2f9IHDbfMuCtPxxmFVojTdBM+s3tJWZ?=
 =?iso-8859-1?Q?dBrg9n1h2SCuF9yZ8q1aGmFqmX/fIzfb49wfU/kK7o4WSI9pz4Q2rr1fIO?=
 =?iso-8859-1?Q?XbCowXtFU4Su7CLO0ztwzr5kM3Gs5exuwRjfmD1SuK93vZ/GrsTpRiSb+K?=
 =?iso-8859-1?Q?Zi9idgHJkmFCl6jfVFdX2XOZ4o4mKb2FDbQtEmJfMV+56HCBSDhzNWZvqJ?=
 =?iso-8859-1?Q?kvyIqhu/og=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qsP9p1ljG1UE1r99d0im4nKl4p/Qvy/l1ApljjSibs6KnOpODYDFZ6NOH0bt0MS+7SvGB0MwlSuXNxLmoRDPal7TbPTiHLS8kbaoU2MTl52B01ZJisLx4I3sdoI7nM9/ldYKEqSY7a3xwqKunC2A21ogb84xfuAhLDKXY46gFPxKuq2Li9xRyhDmHGCN99mxNROlelte0NpqeeNYsyTK0e/2UVN3b5k3f27gs+zbh+HzQhrPEeNFWbtO8ccChvmDu706d2iGinz0yxnIn81leGqyRTXNwNUJVddrZVW009sr7ziWmY3nGZ4Y4Ovpx9W/LHJdpYln/a5GIngg+gAKHQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195a2571-f597-46b4-1310-08df38c2cea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:21.4883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b54wC7bu3cteuWn1OpHw3APZahIsl5W8trMfjcOg9p2tMyRE/jd7M+YEQmv+YfCIBteRfmPT5UPrvrx+bNBqmtItwAV02GXbgCpIFLeEqxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8030
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

Send device_connect when a device is attached and the host has greeted=0A=
us, device_disconnect when it goes away, and handle the bus reset the=0A=
host sends before enumerating.=0A=
=0A=
device_connect carries no identity. The peer asks the device itself with=0A=
GET_DESCRIPTOR as soon as it enumerates, so anything we put there would=0A=
be made up. The speed is real: it comes from the device on our port.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 150 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   7 ++=0A=
 2 files changed, 156 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index f78351bde9..e207f5a7eb 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,7 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
 #include "chardev/char-fe.h"=0A=
@@ -85,17 +86,105 @@ struct USBRedirServer {=0A=
     /* usbredir over the chardev */=0A=
     struct usbredirparser *parser;=0A=
     QEMUBH *chardev_close_bh;=0A=
+    QEMUBH *announce_bh;=0A=
     const uint8_t *read_buf;=0A=
     int read_buf_size;=0A=
     bool in_write;=0A=
     guint watch;=0A=
     bool host_connected;=0A=
+    bool device_announced;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * The device is whatever USBDevice the user plugged into our port with=0A=
+ * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
+ */=0A=
+static USBDevice *usbredir_server_device(USBRedirServer *s)=0A=
+{=0A=
+    return s->port.dev;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Device announcement=0A=
+ */=0A=
+=0A=
+static uint8_t usbredir_server_speed(USBDevice *device)=0A=
+{=0A=
+    switch (device->speed) {=0A=
+    case USB_SPEED_LOW:=0A=
+        return usb_redir_speed_low;=0A=
+    case USB_SPEED_FULL:=0A=
+        return usb_redir_speed_full;=0A=
+    default:=0A=
+        return usb_redir_speed_high;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_announce_device(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    struct usb_redir_interface_info_header iface_info =3D {=0A=
+        .interface_count =3D 0,=0A=
+    };=0A=
+    struct usb_redir_device_connect_header conn =3D {};=0A=
+=0A=
+    if (!s->host_connected || s->device_announced ||=0A=
+        !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+    s->device_announced =3D true;=0A=
+    conn.speed =3D usbredir_server_speed(device);=0A=
+=0A=
+    /*=0A=
+     * The device has to be in DEFAULT state before it can answer=0A=
+     * anything, so reset it here.=0A=
+     */=0A=
+    usb_device_reset(device);=0A=
+=0A=
+    /* Send this before device_connect. The peer needs it to accept us. */=
=0A=
+    usbredirparser_send_interface_info(s->parser, &iface_info);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    trace_usbredir_server_announce(conn.speed);=0A=
+    usbredirparser_send_device_connect(s->parser, &conn);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_port_attach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_attach();=0A=
+=0A=
+    /*=0A=
+     * usb_attach() sets the state to ATTACHED after this returns.=0A=
+     * A device needs DEFAULT state before it can serve a request.=0A=
+     * The BH runs after usb_attach(), so the device stays in DEFAULT.=0A=
+     */=0A=
+    qemu_bh_schedule(s->announce_bh);=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_detach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_detach(s->device_announced);=0A=
+=0A=
+    qemu_bh_cancel(s->announce_bh);=0A=
+=0A=
+    if (s->host_connected && s->parser && s->device_announced) {=0A=
+        trace_usbredir_server_disconnect();=0A=
+        usbredirparser_send_device_disconnect(s->parser);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+    }=0A=
+    s->device_announced =3D false;=0A=
+}=0A=
+=0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
 {=0A=
     /* We only export the device on our own port. Nothing to do. */=0A=
@@ -107,6 +196,8 @@ static void usbredir_server_port_wakeup(USBPort *port)=
=0A=
 }=0A=
 =0A=
 static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .attach =3D usbredir_server_port_attach,=0A=
+    .detach =3D usbredir_server_port_detach,=0A=
     .child_detach =3D usbredir_server_port_child_detach,=0A=
     .wakeup =3D usbredir_server_port_wakeup,=0A=
 };=0A=
@@ -210,13 +301,53 @@ static int usbredir_server_write(void *priv, uint8_t =
*data, int count)=0A=
     return ret;=0A=
 }=0A=
 =0A=
-/* The remote host greets us once the socket is up. */=0A=
+/*=0A=
+ * usbredirparser message callbacks=0A=
+ */=0A=
+=0A=
 static void usbredir_server_hello(void *priv,=0A=
                                   struct usb_redir_hello_header *hello)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
+    char version[sizeof(hello->version) + 1];=0A=
+=0A=
+    pstrcpy(version, sizeof(version), hello->version);=0A=
+    trace_usbredir_server_hello(version);=0A=
 =0A=
     s->host_connected =3D true;=0A=
+    qemu_bh_schedule(s->announce_bh);=0A=
+}=0A=
+=0A=
+static void usbredir_server_reset(void *priv)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    trace_usbredir_server_bus_reset(device && device->attached);=0A=
+    usb_device_reset(device);=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_reject(void *priv)=0A=
+{=0A=
+    trace_usbredir_server_filter_reject();=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_filter(void *priv,=0A=
+    struct usbredirfilter_rule *rules, int rules_count)=0A=
+{=0A=
+    /* We accept any host. The callback owns the rules, so free them. */=
=0A=
+    free(rules);=0A=
+}=0A=
+=0A=
+static void usbredir_server_device_disconnect_ack(void *priv)=0A=
+{=0A=
+    /* The host saw our device_disconnect. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_interface_info(void *priv,=0A=
+    struct usb_redir_interface_info_header *hdr)=0A=
+{=0A=
+    /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -240,6 +371,14 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
 =0A=
     /* Callbacks for messages the remote host sends to us */=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
+    s->parser->reset_func =3D usbredir_server_reset;=0A=
+=0A=
+    /* The parser calls these directly, so they must not be NULL. */=0A=
+    s->parser->filter_reject_func =3D usbredir_server_filter_reject;=0A=
+    s->parser->filter_filter_func =3D usbredir_server_filter_filter;=0A=
+    s->parser->device_disconnect_ack_func =3D=0A=
+        usbredir_server_device_disconnect_ack;=0A=
+    s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
@@ -267,7 +406,9 @@ static void usbredir_server_create_parser(USBRedirServe=
r *s)=0A=
 static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
 {=0A=
     s->host_connected =3D false;=0A=
+    s->device_announced =3D false;=0A=
 =0A=
+    qemu_bh_cancel(s->announce_bh);=0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
     if (s->parser) {=0A=
@@ -368,6 +509,8 @@ static void usbredir_server_realize(DeviceState *dev, E=
rror **errp)=0A=
 =0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
+    s->announce_bh =3D qemu_bh_new_guarded(usbredir_server_announce_device=
, s,=0A=
+                                         &dev->mem_reentrancy_guard);=0A=
 =0A=
     qemu_chr_fe_set_handlers(&s->cs,=0A=
                              usbredir_server_chardev_can_read,=0A=
@@ -387,6 +530,11 @@ static void usbredir_server_unrealize(DeviceState *dev=
)=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
     }=0A=
+=0A=
+    if (s->announce_bh) {=0A=
+        qemu_bh_delete(s->announce_bh);=0A=
+        s->announce_bh =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property usbredir_server_props[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d141661673..2cc6a244b9 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -399,3 +399,10 @@ usbredir_server_chardev_open(void) "chardev opened"=0A=
 usbredir_server_chardev_close(void) "chardev closed"=0A=
 usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
 usbredir_server_log(const char *msg) "%s"=0A=
+usbredir_server_hello(const char *version) "peer is %s"=0A=
+usbredir_server_attach(void) "device attached"=0A=
+usbredir_server_detach(bool announced) "device detached, was announced %d"=
=0A=
+usbredir_server_announce(uint8_t speed) "device_connect speed %u"=0A=
+usbredir_server_disconnect(void) "device_disconnect sent"=0A=
+usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
+usbredir_server_filter_reject(void) "host rejected our device"=0A=
-- =0A=
2.43.0=0A=

