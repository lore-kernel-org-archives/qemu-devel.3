Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B1606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nnV1Np2R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHj-0008QF-Hq; Tue, 10 Nov 2026 02:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHi-0008PR-Gx; Tue, 10 Nov 2026 02:28:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHf-0005Xk-C1; Tue, 10 Nov 2026 02:28:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1ZdUYKiVzOvFiQy7owqpesm6uhHX7QE82Iyr7YyqjIU8AytaZMV+QUyZ00a1umNNeGXpyFcvQdYRYNBWo3r7ujBYVAvyjzlxN+km58RwBMbccok6uPjVe+ucFVbhEJRPiRqFx1QrDRvtXOlQROw/HhzMrF7qZKOMHB4RnKbVMfh8SWly4wI13gx5beICJ9+Qq9XldNXY4K7Vruwt49zdDU7JnYEckkH4BfN15e7OVCbthqDLkl95LJ5YTyAwCpN4uOhHPsLJsuC2AA6czsQ5XMg5dZTQKjBbxmyVstfjBCMxaP/RYL1++yu7xeCMgZUWZ7WIENgoYnJSg4ZYiq+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEqXct3sCLOIiFb8RdqPdUSZMxVDw7Sh2f7LqWoN+RE=;
 b=pISEbB8WVt3n6J34/jUsOOB+cQWS2Qjc2HtOweUXeePnOxJsWFRo55M7MCiVcv2GDvNnb/nOI+wifW2kbdFNkztCBBL8iRRALwsFgLLn91h4aELM0NR01RY2aYLhM2wFtUolzqlnVMJ4s363bvs0nx8FvVvTUNEknmF+nKOpyyi4CkTtIplU85c+RdCdg7Tzr+V289yVUEsHzb8fi11ulZFDRwVp+8MEo6CVBpZ7Ppg3FlGMSfd4dsLU31UT0cBZSD90v1GzrgMHmOig5ouNqJBi5KfNAo6cnp0AvGtLkB6mgqXJav6+AK6nsmosxQGug7GvOyoGEj/cfjPdsnE/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEqXct3sCLOIiFb8RdqPdUSZMxVDw7Sh2f7LqWoN+RE=;
 b=nnV1Np2RtHxMsebJ1kUd/kXV+eo1detnORsmkB+ylXowQijwXtMJfDFNoflIMfPp89a8yFS3nLq3GeVLif0tpsDJU6XtNiMSmLGWAjTMm6ymxUSYwGcqhv6h+WIHC8LviPYvtCzXagYued5Td+S2utZdpH12BRkxJM3vwNajeT6VRE1d+xAxr2AbbInLoWiGf2gEiijkldqSWPih6auzKnywfveR7AyFifsPEH5GeDT5IBlaGopVknEuq8CodFxTSIjmv1GyUFnaJSONgdEZA0Hyb63ucsh+cnVUiuo+KzLevi80zZRpr5N6k6P0zvCLzUwmk6foQOLrbRDKtRo1fg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PS1PPFE8625B3B1.apcprd06.prod.outlook.com (2603:1096:308::26b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 07:28:41 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
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
Subject: [PATCH v9 15/19] hw/usb/redirect-server: Send device and interface
 information
Thread-Topic: [PATCH v9 15/19] hw/usb/redirect-server: Send device and
 interface information
Thread-Index: AQHdcOUb18ycLqZ3xEqano6sgszjxg==
Date: Tue, 10 Nov 2026 07:28:41 +0000
Message-ID: <20261110072818.2883349-16-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PS1PPFE8625B3B1:EE_
x-ms-office365-filtering-correlation-id: 9926dfe8-13b8-4f74-215d-08df3efc3e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|261009223027099003|261028144727099003|261102123227099003|261021133027099003|261026135527099003|261026121527099003|261026140227099003|261021135927099003|261021121427099003|261021123027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261022105027099003|261026130827099003|5023799004|56012099006|3023799007|6133799003|10067099003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: me49FYCDtx596undMOJUoqT/BNq9tvttzHVbl7A7AGey4sKFuiXCf1GJoaNPXjGfAHbIlLlgTQTnp5w9eXGk2k6t7cT/Ic0yhi5i63w5WF4RxfYol6JUxZ366KgASdfgVfTWKwBy+HFBcfiP/IZ5xmskiqIHpeK/wVF/yiLa4aVimsabEkUOR/DiD6/3ih15vO15AMlbI5uaPbUW6rORDTJnhfd6bI7ahSPMmdzf01CCSWYuLFgmvY6H2AVxjftMps/SRpWHQKwtgFaYdwzVn6fsmyMux3MfVrwfIQg5Nz6swqSX16fHzyVvVWd67/U1F/XpjYQUu+7X+RkuF5JbAsLvdIfeDWMsJQ2rg28nLTjAm55WcAO3yS2NokFnMphKJ9dx2+R3dM4odAJ43HhlPQKG7Dj2xIS1iSZF6/PEFIu5Ci2psVgUIxwDtiRYAMX1SNQ7OvQ8VM0pnR0eMXL3//5VuQQvcJh3KS95ApK1ov7ZXlq9VoFjxfccP2LLPSqhAPzLsQwxVhabLyM6KAPOKmsOQpQlPaxCEiW8azk5NiNoo8bRTKC8RPasEDnYF3kcru7pnz7aiRN3GMh8YI2mv3MX5t1DSLwpi/dYPgm+gUSkwNP+sbm/M3Fpt4JjhNCyd99KQCkVqg+mNOxImU1GMchr/Hus+DXvgXC1CdQh0Y0FX9Gej4BopfAUi/OzojoxwycgjRsIfz2hmoc2hhVsLukwygWNiHHgKA+8+Q7k/wuMuNmYSm82gmZrxbNWtoXX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(261028144727099003)(261102123227099003)(261021133027099003)(261026135527099003)(261026121527099003)(261026140227099003)(261021135927099003)(261021121427099003)(261021123027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261022105027099003)(261026130827099003)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SBKYjliNHilAZMXA9YjJmr4cY3ZNBZNE5WVv4VHATGmTxGxyxdE/5Ubv5K?=
 =?iso-8859-1?Q?EGxNy09UE2o8F27PZMFhomkjvta5d6ixPcx7O+Xk/GP1ovQ5r/RDo6cR6B?=
 =?iso-8859-1?Q?EuY1MVC5g3D/+ZWCFtZwjROWFDXy9EnR6C+uj70NtLsvAc+UW77h4umwFP?=
 =?iso-8859-1?Q?wVZY2rCmH4WXybDvk28mCswEGzqSdIvh+kMFqafHXcoCo27fcWZpjsQm/z?=
 =?iso-8859-1?Q?Vq2Qbh+q5FLCDMj3WoyJATDKSMjTw46g1N56UcHJLJ4jZSx5GuXatNRcmf?=
 =?iso-8859-1?Q?/ZDrzVm7VcVJ71LrajUNXfdzP8/HMQ0+6ivwKhB+Vbs/zCYllCORTR9XJC?=
 =?iso-8859-1?Q?xyn5KGhhGRecBCuit06rxt8OpZeXmdSZcFoaY8+toXFwNp+Ci3fEbvSv1V?=
 =?iso-8859-1?Q?yfelnBU35cHHeHzkmxJDIOW+L1JKcPxaRpfaCbQkd3nj4yW99U2OPXPwjW?=
 =?iso-8859-1?Q?g7+qpX+KH1e38ErgUaFsEv0LIWvIV0h5CxjoQ9RNjbzWydQjdutm9LD9kG?=
 =?iso-8859-1?Q?YvhratMllULeJuO840ubya6UfbI0mFgDPuLoDF/RhD3Rqf1GgqwgrWySnh?=
 =?iso-8859-1?Q?+UFvJa2LEXlBrkhKXnoOQqBXeDaoq39sXJpEcUBgBHgGfKu9LKt1q6B0Qb?=
 =?iso-8859-1?Q?pEQJxU5n8bQc8LZGEiENqOc10QxA8ZRayytJ/QmrGQqkADsx1+yMWlmwL4?=
 =?iso-8859-1?Q?OhTHLEKbJ1TEANy77P1abl2KCN7i0ErbEYBtTLjJf7/nLFUiGSLYur4CMw?=
 =?iso-8859-1?Q?wZaOeLEpJkut0tZOy/0XeQVancJ9PPlf0pn+hVUTODAVAZiGlqC4YDtr5t?=
 =?iso-8859-1?Q?dBycjTzYnj+IOQRAlxhzz7DwjelypCnnN/v+7ONy2vTHkbEaZpJY8PWh2C?=
 =?iso-8859-1?Q?Cb0FR+/UTzxewpPOLZSegZ3IjNJqr5Vf4gHOpNDv7XJ6PwV2hufR0cpFsB?=
 =?iso-8859-1?Q?VmqM1XyC1flbEpGw/4bQ9U5M+CVHqYsw63CwKvQXJz0IwyUwQPh5A97tmZ?=
 =?iso-8859-1?Q?luamgNY7nhPjivncqgE41tYxMIaB5PBN6o9TDslEZzSK1qAGpbSG6S2DKx?=
 =?iso-8859-1?Q?1sTPUTFFvGaB03tAIPQX27gtPX6nq+fFtR8pNole1ZaR1Nzl4/eKSg6Zdr?=
 =?iso-8859-1?Q?OkTzDrNmihiptcS/v0SJ/i5foNmJgSwVzFHtNdSrePBEbRMoeslh1HPOcl?=
 =?iso-8859-1?Q?KWO61LKvm8n/VISpEjxi75L8olg4Do1kDzMajpBuSGhwhiFuIdz3gdtTdW?=
 =?iso-8859-1?Q?HuvBab1sBQz7v9/jZ20K7TupRAh4WSfXnMjUML4xSGeUfEvWrpF4wXycp+?=
 =?iso-8859-1?Q?CBSfumkO2FkTICngY9o0wAWE4cU1wTs+2oHXPQeoe/pnPk853K9x0JzTwO?=
 =?iso-8859-1?Q?gichGeFm35PUSfO7ffmYwgda7KYebqeFlXswUpW497bK3o5dF+xduAFjb3?=
 =?iso-8859-1?Q?iOK4yzpeSBqOYlTUa7moyxOWbXtZKEHFpxVz81COl9twayY2jcBdBbhdkP?=
 =?iso-8859-1?Q?WkKq8SBq5R8t6Rf9zx45reQpC+o4CAczZIDz7kChCFR8NFcOK+tuKi/17Z?=
 =?iso-8859-1?Q?jUdwGpnv+wHklqIbPJAx/v54/vhCDmS8peIN1ddgYIp/7FpVdK4Vc7EkWQ?=
 =?iso-8859-1?Q?icmIS22xRxAKx/E8K2pJ9XB+9E+IDG++wu/14u/JcMbTqmzSNLv0RSnBaf?=
 =?iso-8859-1?Q?qL5H0eLjO1KW5tkLsmO30w0D3+znm3geqssjEnxod2M8AEnoz3bEbW9t3Z?=
 =?iso-8859-1?Q?0cqjIeyNIMQRp/NWD2/D0LoemYtmOoglDhapDWKM73oEw5p5zGl5Q0j4cn?=
 =?iso-8859-1?Q?GWA2VRBTXA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TKiuWscjzU+jIkkT79R9BwlJQlg7K1u2B1KEuvcpn4vQ3DDwo925+ORHEQu3BxLPFftXdg3Q+mRae2Vjda/y6riFiBKgzq1eNzwrFvZetXkrcLsG5NPnJqHkDxqgomoB4uvb6KRhYuPs3sD+upCR+b5Juj7x1t9Xav+uXrV08ME8/Mfz6MORl97TCUaMsBp4uTksVtOqMfJ9oKzE5v4dj2CG+Mxl1JxyJeXhRTQct4Js3Nsdwn7axeIEM+CvoAYR0bxZJIhhLndx64q3VudC4mHpNaoiBHSjLUbKyogQEYBRn2kStaNNyeLBVlhg2TLKW5AkD/jrBsygwVtKv11erw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9926dfe8-13b8-4f74-215d-08df3efc3e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:41.0916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WusuLHSaJmcCdLG85Od4LLHGUsHQSOIubqOAWbwoXbPscCgjh7990KZlzejgfoTiUUcasVZIcE/6q391Q9NuBXz+v8lIEsgqpgQ07xkwQmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFE8625B3B1
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

The device_connect and interface_info messages currently contain zeroed=0A=
fields, so clients cannot apply device filters or quirks correctly.=0A=
=0A=
Read the device and configuration descriptors before announcing the=0A=
device, and use them to fill these messages. Update interface and=0A=
endpoint information when the configuration or alternate setting changes.=
=0A=
=0A=
Keep internal descriptor requests separate from host transfers. Retry=0A=
on NAK and stop on timeout or invalid descriptors. Do not announce the=0A=
device if reading its descriptors fails.=0A=
=0A=
Wait like a USB host. Wait 100 ms between the attach and the reset,=0A=
and 10 ms between the reset and the first request. Some firmware turns=0A=
on the pull-up before it sets up endpoint 0.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 496 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   7 +=0A=
 2 files changed, 503 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 89d88d6457..914697fdea 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -87,6 +87,28 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
 #define USBREDIR_SERVER_DESC_CONFIG_SIZE 9=0A=
 #define USBREDIR_SERVER_DESC_INTERFACE_SIZE 9=0A=
 #define USBREDIR_SERVER_DESC_ENDPOINT_SIZE 7=0A=
+#define USBREDIR_SERVER_DESC_DEVICE_SIZE 18=0A=
+=0A=
+/*=0A=
+ * How long we keep asking the device what it is. This covers every=0A=
+ * retry and every wait, so a device that never answers stops here.=0A=
+ */=0A=
+#define USBREDIR_SERVER_DESC_TIMEOUT_MS 10000=0A=
+=0A=
+/* How long to wait before asking again after the device said NAK. */=0A=
+#define USBREDIR_SERVER_DESC_RETRY_MS 10=0A=
+=0A=
+/*=0A=
+ * The USB spec gives the device an attach debounce interval of at least=
=0A=
+ * 100 ms. We wait this long after the attach. Then we reset the device.=
=0A=
+ */=0A=
+#define USBREDIR_SERVER_ATTACH_DEBOUNCE_MS 100=0A=
+=0A=
+/*=0A=
+ * The USB spec gives the device a reset recovery time of 10 ms. We wait=
=0A=
+ * this long after the reset. Then we ask the device for its descriptor.=
=0A=
+ */=0A=
+#define USBREDIR_SERVER_RESET_RECOVERY_MS 10=0A=
 =0A=
 /*=0A=
  * Ask again this often after an endpoint answered NAK. Most devices=0A=
@@ -95,8 +117,34 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SE=
RVER)=0A=
  */=0A=
 #define USBREDIR_SERVER_RETRY_MS 1000=0A=
 =0A=
+/*=0A=
+ * The steps to read the descriptors, in order:=0A=
+ *=0A=
+ * IDLE: not started yet.=0A=
+ * ATTACH_DEBOUNCE: the device is attached.=0A=
+ *                  Wait USBREDIR_SERVER_ATTACH_DEBOUNCE_MS, then reset it=
.=0A=
+ * RESET_RECOVERY: the device is reset. Wait USBREDIR_SERVER_RESET_RECOVER=
Y_MS.=0A=
+ * GET_DEVICE: ask for the device descriptor.=0A=
+ * GET_CFG_HEAD: ask for the first part of the config descriptor.=0A=
+ *               It gives the full length.=0A=
+ * GET_CFG_FULL: ask for the full config descriptor.=0A=
+ * DONE: all read. Now we can announce the device.=0A=
+ * FAILED: the read failed. Close the connection.=0A=
+ */=0A=
+typedef enum {=0A=
+    USBREDIR_SERVER_DESC_IDLE,=0A=
+    USBREDIR_SERVER_DESC_ATTACH_DEBOUNCE,=0A=
+    USBREDIR_SERVER_DESC_RESET_RECOVERY,=0A=
+    USBREDIR_SERVER_DESC_GET_DEVICE,=0A=
+    USBREDIR_SERVER_DESC_GET_CFG_HEAD,=0A=
+    USBREDIR_SERVER_DESC_GET_CFG_FULL,=0A=
+    USBREDIR_SERVER_DESC_DONE,=0A=
+    USBREDIR_SERVER_DESC_FAILED,=0A=
+} USBRedirServerDescStep;=0A=
+=0A=
 typedef enum {=0A=
     USBREDIR_SERVER_CTRL,=0A=
+    USBREDIR_SERVER_DESCRIPTOR,=0A=
 } USBRedirServerPktType;=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
@@ -181,6 +229,22 @@ struct USBRedirServer {=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
 =0A=
+    uint8_t device_desc[USBREDIR_SERVER_DESC_DEVICE_SIZE];=0A=
+    uint8_t config_desc[USBREDIR_SERVER_DESC_CONFIG_SIZE];=0A=
+    uint8_t internal_config;=0A=
+=0A=
+    /*=0A=
+     * Our own request on endpoint 0. It never goes on inflight or=0A=
+     * waiting, so a cancel from the host cannot reach it.=0A=
+     */=0A=
+    USBRedirServerDescStep desc_step;=0A=
+    USBRedirServerPkt *desc_pkt;=0A=
+    QEMUTimer *desc_timeout;=0A=
+    QEMUTimer *desc_wait;=0A=
+    bool desc_retrying;=0A=
+    bool desc_answered;=0A=
+    QEMUBH *desc_bh;=0A=
+=0A=
     /* Every request the host is still waiting for an answer to. */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
@@ -533,14 +597,333 @@ static void usbredir_server_send_ep_iface_info(USBRe=
dirServer *s,=0A=
     usbredirparser_do_write(s->parser);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Reading the descriptor=0A=
+ *=0A=
+ * The host cannot tell us what the device is, so we ask the device=0A=
+ * ourselves before we announce it.=0A=
+ */=0A=
+=0A=
+static const char *usbredir_server_desc_step_name(USBRedirServerDescStep s=
tep)=0A=
+{=0A=
+    static const char *const name[] =3D {=0A=
+        [USBREDIR_SERVER_DESC_IDLE] =3D "idle",=0A=
+        [USBREDIR_SERVER_DESC_ATTACH_DEBOUNCE] =3D "attach-debounce",=0A=
+        [USBREDIR_SERVER_DESC_RESET_RECOVERY] =3D "reset-recovery",=0A=
+        [USBREDIR_SERVER_DESC_GET_DEVICE] =3D "get-device",=0A=
+        [USBREDIR_SERVER_DESC_GET_CFG_HEAD] =3D "get-cfg-head",=0A=
+        [USBREDIR_SERVER_DESC_GET_CFG_FULL] =3D "get-cfg-full",=0A=
+        [USBREDIR_SERVER_DESC_DONE] =3D "done",=0A=
+        [USBREDIR_SERVER_DESC_FAILED] =3D "failed",=0A=
+    };=0A=
+=0A=
+    assert(step < ARRAY_SIZE(name) && name[step]);=0A=
+    return name[step];=0A=
+}=0A=
+=0A=
+static void usbredir_server_cancel_descriptor(USBRedirServer *s)=0A=
+{=0A=
+    USBRedirServerPkt *rp =3D s->desc_pkt;=0A=
+=0A=
+    qemu_bh_cancel(s->desc_bh);=0A=
+    timer_del(s->desc_wait);=0A=
+    timer_del(s->desc_timeout);=0A=
+    s->desc_pkt =3D NULL;=0A=
+    s->desc_retrying =3D false;=0A=
+    s->desc_answered =3D false;=0A=
+    if (rp) {=0A=
+        usbredir_server_pkt_free(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void usbredir_server_clear_descriptor(USBRedirServer *s)=0A=
 {=0A=
+    usbredir_server_cancel_descriptor(s);=0A=
+    s->desc_step =3D USBREDIR_SERVER_DESC_IDLE;=0A=
+    s->internal_config =3D 0;=0A=
     s->host_config =3D 0;=0A=
+    memset(s->device_desc, 0, sizeof(s->device_desc));=0A=
+    memset(s->config_desc, 0, sizeof(s->config_desc));=0A=
     memset(s->alt_setting, 0, sizeof(s->alt_setting));=0A=
     usbredir_server_clear_ep_table(s);=0A=
     g_hash_table_remove_all(s->config_table);=0A=
 }=0A=
 =0A=
+static void usbredir_server_descriptor_failed(USBRedirServer *s,=0A=
+                                              const char *reason)=0A=
+{=0A=
+    error_report(TYPE_USB_REDIR_SERVER ": could not read the descriptor "=
=0A=
+                 "at step %s: %s",=0A=
+                 usbredir_server_desc_step_name(s->desc_step), reason);=0A=
+    usbredir_server_clear_descriptor(s);=0A=
+    s->desc_step =3D USBREDIR_SERVER_DESC_FAILED;=0A=
+    qemu_bh_schedule(s->announce_bh);=0A=
+}=0A=
+=0A=
+static void usbredir_server_descriptor_timeout(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    usbredir_server_descriptor_failed(s, "the device took too long");=0A=
+}=0A=
+=0A=
+static void usbredir_server_descriptor_timer(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    qemu_bh_schedule(s->desc_bh);=0A=
+}=0A=
+=0A=
+static void usbredir_server_submit_descriptor(USBRedirServer *s)=0A=
+{=0A=
+    const char *step =3D usbredir_server_desc_step_name(s->desc_step);=0A=
+    USBRedirServerPkt *rp =3D s->desc_pkt;=0A=
+=0A=
+    s->desc_retrying =3D false;=0A=
+    timer_del(s->desc_wait);=0A=
+=0A=
+    /* The same packet goes out again after a NAK, so empty it first. */=
=0A=
+    rp->pkt.actual_length =3D 0;=0A=
+    memset(rp->data, 0, rp->pkt.iov.size);=0A=
+=0A=
+    trace_usbredir_server_submit_descriptor(step);=0A=
+    usb_handle_packet(usbredir_server_device(s), &rp->pkt);=0A=
+=0A=
+    switch (rp->pkt.status) {=0A=
+    case USB_RET_ASYNC:=0A=
+        /*=0A=
+         * The device keeps the packet and its buffer. It answers=0A=
+         * later, and the core calls usbredir_server_packet_complete().=0A=
+         */=0A=
+        break;=0A=
+    case USB_RET_NAK:=0A=
+        s->desc_retrying =3D true;=0A=
+        timer_mod(s->desc_wait, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
+                  (int64_t)USBREDIR_SERVER_DESC_RETRY_MS * SCALE_MS);=0A=
+        break;=0A=
+    default:=0A=
+        /*=0A=
+         * The transfer ended. SUCCESS has the data, STALL and the=0A=
+         * other errors do not. The bottom half looks at the status=0A=
+         * and decides which.=0A=
+         */=0A=
+        s->desc_answered =3D true;=0A=
+        qemu_bh_schedule(s->desc_bh);=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_ask_descriptor(USBRedirServer *s, uint8_t type=
,=0A=
+                                           uint16_t length)=0A=
+{=0A=
+    struct usb_redir_control_packet_header hdr =3D {=0A=
+        .endpoint =3D 0,=0A=
+        .request =3D USB_REQ_GET_DESCRIPTOR,=0A=
+        /* Device to host. The zeros mean standard, to the device. */=0A=
+        .requesttype =3D USB_DIR_IN,=0A=
+        .status =3D 0,=0A=
+        .value =3D type << 8,=0A=
+        .index =3D 0,=0A=
+        .length =3D length,=0A=
+    };=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    assert(!s->desc_pkt);=0A=
+    trace_usbredir_server_ask_descriptor(type, length);=0A=
+=0A=
+    rp =3D usbredir_server_pkt_alloc(length, 0);=0A=
+    rp->type =3D USBREDIR_SERVER_DESCRIPTOR;=0A=
+    usbredir_server_prepare_control(s, rp, &hdr);=0A=
+    s->desc_pkt =3D rp;=0A=
+    usbredir_server_submit_descriptor(s);=0A=
+}=0A=
+=0A=
+static bool usbredir_server_accept_descriptor(USBRedirServer *s,=0A=
+                                              const uint8_t *data,=0A=
+                                              int actual_length)=0A=
+{=0A=
+    const char *step =3D usbredir_server_desc_step_name(s->desc_step);=0A=
+    const USBDescriptor *desc =3D (const USBDescriptor *)data;=0A=
+    const USBDescriptor *head;=0A=
+    uint16_t total;=0A=
+=0A=
+    switch (s->desc_step) {=0A=
+    case USBREDIR_SERVER_DESC_GET_DEVICE:=0A=
+        if (actual_length !=3D USBREDIR_SERVER_DESC_DEVICE_SIZE ||=0A=
+            desc->bLength !=3D USBREDIR_SERVER_DESC_DEVICE_SIZE ||=0A=
+            desc->bDescriptorType !=3D USB_DT_DEVICE) {=0A=
+            trace_usbredir_server_accept_descriptor(step,=0A=
+                                                    "not a device descript=
or");=0A=
+            return false;=0A=
+        }=0A=
+        if (desc->u.device.bNumConfigurations =3D=3D 0) {=0A=
+            trace_usbredir_server_accept_descriptor(step,=0A=
+                                                    "no configuration");=
=0A=
+            return false;=0A=
+        }=0A=
+        memcpy(s->device_desc, data, actual_length);=0A=
+        s->desc_step =3D USBREDIR_SERVER_DESC_GET_CFG_HEAD;=0A=
+        break;=0A=
+    case USBREDIR_SERVER_DESC_GET_CFG_HEAD:=0A=
+        if (actual_length !=3D USBREDIR_SERVER_DESC_CONFIG_SIZE ||=0A=
+            desc->bLength !=3D USBREDIR_SERVER_DESC_CONFIG_SIZE ||=0A=
+            desc->bDescriptorType !=3D USB_DT_CONFIG) {=0A=
+            trace_usbredir_server_accept_descriptor(step,=0A=
+                "not a configuration descriptor");=0A=
+            return false;=0A=
+        }=0A=
+        if (desc->u.config.bConfigurationValue =3D=3D 0) {=0A=
+            trace_usbredir_server_accept_descriptor(step,=0A=
+                                                    "configuration value 0=
");=0A=
+            return false;=0A=
+        }=0A=
+        total =3D desc->u.config.wTotalLength_hi << 8 |=0A=
+                desc->u.config.wTotalLength_lo;=0A=
+        if (total < USBREDIR_SERVER_DESC_CONFIG_SIZE ||=0A=
+            total > USB_DESC_MAX_LEN) {=0A=
+            trace_usbredir_server_desc_too_long(total);=0A=
+            return false;=0A=
+        }=0A=
+        memcpy(s->config_desc, data, sizeof(s->config_desc));=0A=
+        s->desc_step =3D USBREDIR_SERVER_DESC_GET_CFG_FULL;=0A=
+        break;=0A=
+    case USBREDIR_SERVER_DESC_GET_CFG_FULL:=0A=
+        head =3D (const USBDescriptor *)s->config_desc;=0A=
+        total =3D head->u.config.wTotalLength_hi << 8 |=0A=
+                head->u.config.wTotalLength_lo;=0A=
+        if (actual_length !=3D total) {=0A=
+            trace_usbredir_server_accept_descriptor(step,=0A=
+                                                    "wrong length");=0A=
+            return false;=0A=
+        }=0A=
+        if (memcmp(data, s->config_desc, sizeof(s->config_desc))) {=0A=
+            trace_usbredir_server_accept_descriptor(step,=0A=
+                                                    "the head changed");=
=0A=
+            return false;=0A=
+        }=0A=
+        if (!usbredir_server_save_config(s, data, actual_length)) {=0A=
+            trace_usbredir_server_accept_descriptor(step,=0A=
+                "the configuration does not hold together");=0A=
+            return false;=0A=
+        }=0A=
+        s->internal_config =3D desc->u.config.bConfigurationValue;=0A=
+        s->desc_step =3D USBREDIR_SERVER_DESC_DONE;=0A=
+        break;=0A=
+    default:=0A=
+        g_assert_not_reached();=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+static void usbredir_server_descriptor_answer(USBRedirServer *s,=0A=
+                                              USBRedirServerPkt *rp)=0A=
+{=0A=
+    const char *step =3D usbredir_server_desc_step_name(s->desc_step);=0A=
+=0A=
+    trace_usbredir_server_descriptor_answer(step, rp->pkt.status,=0A=
+                                            rp->pkt.actual_length);=0A=
+=0A=
+    if (rp->pkt.status !=3D USB_RET_SUCCESS) {=0A=
+        usbredir_server_descriptor_failed(s, "the transfer failed");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!usbredir_server_accept_descriptor(s, rp->data,=0A=
+                                           rp->pkt.actual_length)) {=0A=
+        usbredir_server_descriptor_failed(s,=0A=
+            "the answer is not what we asked for");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * usbredir_server_accept_descriptor() set the next step. DONE=0A=
+     * means the read is finished.=0A=
+     */=0A=
+    if (s->desc_step =3D=3D USBREDIR_SERVER_DESC_DONE) {=0A=
+        timer_del(s->desc_timeout);=0A=
+        qemu_bh_schedule(s->announce_bh);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    qemu_bh_schedule(s->desc_bh);=0A=
+}=0A=
+=0A=
+static void usbredir_server_descriptor_bh(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    USBRedirServerPkt *rp =3D s->desc_pkt;=0A=
+=0A=
+    if (!s->host_connected || !s->parser || !device || !device->attached) =
{=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (s->desc_step) {=0A=
+    case USBREDIR_SERVER_DESC_ATTACH_DEBOUNCE:=0A=
+        /*=0A=
+         * After attach the device is in ATTACHED state, and=0A=
+         * usb_handle_packet() only takes a packet in DEFAULT state.=0A=
+         * A reset moves it there.=0A=
+         */=0A=
+        usb_device_reset(device);=0A=
+        s->desc_step =3D USBREDIR_SERVER_DESC_RESET_RECOVERY;=0A=
+        timer_mod(s->desc_wait, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
+                  (int64_t)USBREDIR_SERVER_RESET_RECOVERY_MS * SCALE_MS);=
=0A=
+        return;=0A=
+    case USBREDIR_SERVER_DESC_RESET_RECOVERY:=0A=
+        s->desc_step =3D USBREDIR_SERVER_DESC_GET_DEVICE;=0A=
+        qemu_bh_schedule(s->desc_bh);=0A=
+        return;=0A=
+    case USBREDIR_SERVER_DESC_GET_DEVICE:=0A=
+        if (!rp) {=0A=
+            usbredir_server_ask_descriptor(s, USB_DT_DEVICE,=0A=
+                                           USBREDIR_SERVER_DESC_DEVICE_SIZ=
E);=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
+    case USBREDIR_SERVER_DESC_GET_CFG_HEAD:=0A=
+        if (!rp) {=0A=
+            usbredir_server_ask_descriptor(s, USB_DT_CONFIG,=0A=
+                                           USBREDIR_SERVER_DESC_CONFIG_SIZ=
E);=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
+    case USBREDIR_SERVER_DESC_GET_CFG_FULL:=0A=
+        if (!rp) {=0A=
+            usbredir_server_ask_descriptor(s, USB_DT_CONFIG,=0A=
+                                           lduw_le_p(s->config_desc + 2));=
=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        /* IDLE, DONE and FAILED have nothing to send. */=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* rp is the request we gave the device. */=0A=
+    if (s->desc_answered) {=0A=
+        /*=0A=
+         * Set s->desc_pkt to NULL first. On failure,=0A=
+         * usbredir_server_descriptor_answer() ends up in=0A=
+         * usbredir_server_cancel_descriptor(), which frees s->desc_pkt.=
=0A=
+         * With NULL there, only the line below frees the packet.=0A=
+         */=0A=
+        s->desc_pkt =3D NULL;=0A=
+        s->desc_answered =3D false;=0A=
+        usbredir_server_descriptor_answer(s, rp);=0A=
+        usbredir_server_pkt_free(s, rp);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (s->desc_retrying) {=0A=
+        usbredir_server_submit_descriptor(s);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* The device is still holding the request. */=0A=
+}=0A=
+=0A=
 /*=0A=
  * Announcing the device=0A=
  */=0A=
@@ -557,6 +940,22 @@ static uint8_t usbredir_server_speed(USBDevice *device=
)=0A=
     }=0A=
 }=0A=
 =0A=
+static void usbredir_server_describe_device(USBRedirServer *s,=0A=
+    struct usb_redir_device_connect_header *conn)=0A=
+{=0A=
+    const USBDescriptor *desc =3D (const USBDescriptor *)s->device_desc;=
=0A=
+=0A=
+    conn->device_class =3D desc->u.device.bDeviceClass;=0A=
+    conn->device_subclass =3D desc->u.device.bDeviceSubClass;=0A=
+    conn->device_protocol =3D desc->u.device.bDeviceProtocol;=0A=
+    conn->vendor_id =3D desc->u.device.idVendor_hi << 8 |=0A=
+                      desc->u.device.idVendor_lo;=0A=
+    conn->product_id =3D desc->u.device.idProduct_hi << 8 |=0A=
+                       desc->u.device.idProduct_lo;=0A=
+    conn->device_version_bcd =3D desc->u.device.bcdDevice_hi << 8 |=0A=
+                               desc->u.device.bcdDevice_lo;=0A=
+}=0A=
+=0A=
 static void usbredir_server_announce_bh(void *opaque)=0A=
 {=0A=
     USBRedirServer *s =3D opaque;=0A=
@@ -567,9 +966,42 @@ static void usbredir_server_announce_bh(void *opaque)=
=0A=
         !device || !device->attached) {=0A=
         return;=0A=
     }=0A=
+=0A=
+    if (s->desc_step =3D=3D USBREDIR_SERVER_DESC_IDLE) {=0A=
+        s->desc_step =3D USBREDIR_SERVER_DESC_ATTACH_DEBOUNCE;=0A=
+        timer_mod(s->desc_timeout, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=
=0A=
+                  (int64_t)USBREDIR_SERVER_DESC_TIMEOUT_MS * SCALE_MS);=0A=
+        timer_mod(s->desc_wait, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
+                  (int64_t)USBREDIR_SERVER_ATTACH_DEBOUNCE_MS * SCALE_MS);=
=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * We could not read the descriptor. The host waits for=0A=
+     * device_connect, so close the connection to tell it.=0A=
+     */=0A=
+    if (s->desc_step =3D=3D USBREDIR_SERVER_DESC_FAILED) {=0A=
+        trace_usbredir_server_announce_failed();=0A=
+        qemu_chr_fe_disconnect(&s->cs);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (s->desc_step !=3D USBREDIR_SERVER_DESC_DONE) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
     s->device_announced =3D true;=0A=
     conn.speed =3D usbredir_server_speed(device);=0A=
+    usbredir_server_describe_device(s, &conn);=0A=
 =0A=
+    /*=0A=
+     * Send this first. The host looks the device over when=0A=
+     * device_connect arrives, and this is what it looks at.=0A=
+     */=0A=
+    usbredir_server_send_ep_iface_info(s, s->internal_config);=0A=
+=0A=
+    trace_usbredir_server_announce(conn.speed, conn.vendor_id,=0A=
+                                   conn.product_id, conn.device_class);=0A=
     usbredirparser_send_device_connect(s->parser, &conn);=0A=
     usbredirparser_do_write(s->parser);=0A=
 }=0A=
@@ -730,6 +1162,28 @@ static void usbredir_server_packet_complete(USBPort *=
port, USBPacket *p)=0A=
     USBRedirServerPkt *rp =3D container_of(p, USBRedirServerPkt, pkt);=0A=
     USBDevice *device =3D usbredir_server_device(s);=0A=
 =0A=
+    /*=0A=
+     * Our own request. We read the descriptor before we announce=0A=
+     * the device, so the host knows what it is getting.=0A=
+     */=0A=
+    if (rp->type =3D=3D USBREDIR_SERVER_DESCRIPTOR) {=0A=
+        assert(s->desc_pkt =3D=3D rp);=0A=
+=0A=
+        /*=0A=
+         * If the endpoint halts with this packet still queued, the core=
=0A=
+         * leaves it there and loops in usb_packet_complete() until the=0A=
+         * queue is empty. A bottom half would never run, so take it off=
=0A=
+         * now.=0A=
+         */=0A=
+        if (p->status =3D=3D USB_RET_REMOVE_FROM_QUEUE &&=0A=
+            usb_packet_is_inflight(p)) {=0A=
+            usb_cancel_packet(p);=0A=
+        }=0A=
+        s->desc_answered =3D true;=0A=
+        qemu_bh_schedule(s->desc_bh);=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* A cancel can arrive while we answer, so it must not find this one. =
*/=0A=
     QTAILQ_REMOVE(&s->inflight, rp, inflight_link);=0A=
 =0A=
@@ -830,6 +1284,16 @@ static void usbredir_server_wakeup_ep(USBBus *bus, US=
BEndpoint *ep,=0A=
     USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
     uint8_t addr =3D ep->nr | (ep->pid =3D=3D USB_TOKEN_IN ? USB_DIR_IN : =
0);=0A=
 =0A=
+    /*=0A=
+     * Our descriptor request is not on inflight or waiting, so=0A=
+     * usbredir_server_kick_ep() below cannot see it. The device is=0A=
+     * still running when it calls us, so sending now would call back=0A=
+     * into it.=0A=
+     */=0A=
+    if (ep->nr =3D=3D 0 && s->desc_retrying) {=0A=
+        qemu_bh_schedule(s->desc_bh);=0A=
+    }=0A=
+=0A=
     usbredir_server_kick_ep(s, usbredir_server_ep_index(addr));=0A=
 }=0A=
 =0A=
@@ -972,6 +1436,16 @@ static void usbredir_server_reset(void *priv)=0A=
 =0A=
     usbredir_server_stop_transfers(s);=0A=
     usb_device_reset(device);=0A=
+=0A=
+    /*=0A=
+     * Before the announcement, usbredir_server_stop_transfers() above=0A=
+     * also stopped our descriptor read. Start it again from the=0A=
+     * beginning.=0A=
+     */=0A=
+    if (!s->device_announced) {=0A=
+        usbredir_server_clear_descriptor(s);=0A=
+        qemu_bh_schedule(s->announce_bh);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void usbredir_server_prepare_control(USBRedirServer *s,=0A=
@@ -1211,6 +1685,8 @@ static void usbredir_server_stop_transfers(USBRedirSe=
rver *s)=0A=
     USBRedirServerPkt *rp;=0A=
     int i;=0A=
 =0A=
+    usbredir_server_cancel_descriptor(s);=0A=
+=0A=
     for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
         timer_del(s->ep[i].retry);=0A=
     }=0A=
@@ -1291,6 +1767,7 @@ static void usbredir_server_destroy_parser(USBRedirSe=
rver *s)=0A=
     s->host_connected =3D false;=0A=
     s->device_announced =3D false;=0A=
 =0A=
+    usbredir_server_clear_descriptor(s);=0A=
     qemu_bh_cancel(s->announce_bh);=0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
@@ -1364,6 +1841,9 @@ static void usbredir_server_chardev_event(void *opaqu=
e,=0A=
         break;=0A=
     case CHR_EVENT_CLOSED:=0A=
         trace_usbredir_server_chardev_close();=0A=
+        s->host_connected =3D false;=0A=
+        qemu_bh_cancel(s->announce_bh);=0A=
+        usbredir_server_cancel_descriptor(s);=0A=
         qemu_bh_schedule(s->chardev_close_bh);=0A=
         break;=0A=
     case CHR_EVENT_BREAK:=0A=
@@ -1412,6 +1892,12 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
     s->announce_bh =3D qemu_bh_new_guarded(usbredir_server_announce_bh, s,=
=0A=
                                          &dev->mem_reentrancy_guard);=0A=
+    s->desc_bh =3D qemu_bh_new_guarded(usbredir_server_descriptor_bh, s,=
=0A=
+                                     &dev->mem_reentrancy_guard);=0A=
+    s->desc_wait =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                usbredir_server_descriptor_timer, s);=0A=
+    s->desc_timeout =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                   usbredir_server_descriptor_timeout, s);=
=0A=
 =0A=
     qemu_chr_fe_set_handlers(&s->cs,=0A=
                              usbredir_server_chardev_can_read,=0A=
@@ -1440,6 +1926,16 @@ static void usbredir_server_unrealize(DeviceState *d=
ev)=0A=
         s->announce_bh =3D NULL;=0A=
     }=0A=
 =0A=
+    if (s->desc_bh) {=0A=
+        qemu_bh_delete(s->desc_bh);=0A=
+        s->desc_bh =3D NULL;=0A=
+    }=0A=
+=0A=
+    timer_free(s->desc_wait);=0A=
+    s->desc_wait =3D NULL;=0A=
+    timer_free(s->desc_timeout);=0A=
+    s->desc_timeout =3D NULL;=0A=
+=0A=
     for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {=0A=
         timer_free(s->ep[i].retry);=0A=
         s->ep[i].retry =3D NULL;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 917881ab1e..549f5f6e23 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -402,7 +402,14 @@ usbredir_server_log(const char *msg) "%s"=0A=
 usbredir_server_hello(const char *version) "peer is %s"=0A=
 usbredir_server_attach(void) "device attached"=0A=
 usbredir_server_detach(bool announced) "device detached, was announced %d"=
=0A=
+usbredir_server_announce(uint8_t speed, uint16_t vendor, uint16_t product,=
 uint8_t class) "device_connect speed %u, %04x:%04x, class %u"=0A=
+usbredir_server_announce_failed(void) "closing the connection"=0A=
+usbredir_server_ask_descriptor(uint8_t type, uint16_t length) "asking the =
device for descriptor type %u, %u bytes"=0A=
+usbredir_server_submit_descriptor(const char *step) "step %s"=0A=
+usbredir_server_descriptor_answer(const char *step, int status, int length=
) "step %s status %d length %d"=0A=
+usbredir_server_accept_descriptor(const char *step, const char *reason) "s=
tep %s rejected: %s"=0A=
 usbredir_server_interface_info(uint32_t count) "interface_info for %u inte=
rface(s)"=0A=
+usbredir_server_desc_too_long(uint16_t total) "configuration descriptor of=
 %u bytes is more than we take"=0A=
 usbredir_server_disconnect(void) "device_disconnect sent"=0A=
 usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
 usbredir_server_filter_reject(void) "host rejected our device"=0A=
-- =0A=
2.43.0=0A=

