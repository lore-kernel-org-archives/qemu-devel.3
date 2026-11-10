Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EA606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=C74kfYhA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHS-0008FS-3R; Tue, 10 Nov 2026 02:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHQ-0008Ey-CU; Tue, 10 Nov 2026 02:28:32 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHM-0005Uy-Od; Tue, 10 Nov 2026 02:28:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB7C2VmwZZ9duJDXFUTxPBmy7uA0X+VHEnk3b6sQZUkFa4nr33B3MlnrfslfaiGe1ou8/1y4qkZPgcTGxPpwlswjmPHrTL1fElPlnNmxwJqP7OI6gIF9B9S5F+a/UgU5yQEugiLsswdjLpuwUaLAIFJJBaZr4MrOQL1pBONSayYCt1SkvY+Q2XWIUIUi68hEopbzwloB1hWgUurjUh8uM70NyrQeJDPQsQrlXKwPbOO0qQZHdpZjHphSy5Wkdn8XSgab/GxUw60aQE1gWXGKg2/njYQsWN5NNz7Nsw5AsYFY4lGgZGCXeD6xTO3ULU2KJrXY402HPLxx+iuKq8VLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPxVsAVq/Df1lt5aoYNX0dLBiNbWS8i+wq67xTVGODg=;
 b=K0kSRN8h2mroGEUYB+AAQWDE5gyGSNiKWy/AJlHG5GHt491/xD72tZfIylbmR8G6s9zBaNjCQUeBcvDywDzqqn3TdHvBw6EeVUY19tHR0/DsSfdTRgTZ6cFaf/qXBBRUlbAzpylBFTg9cjJHaav78VtWC6WtOGorG1ckBVom8uvJwMswEf7zhbjP4mDWnd4RKPk22Dyr1GsKI9dXZihF45GXgA/r6PkASSP6lTCvGQXFFbvQfE73v1TgXQdeiP+gVr34dgsnRvkhOhsQabyR7NTwQBwDWi8fog6vmEC0VwQOcCp4rcZ8flwTjjtnhBqKMgPmhXBz1MjmDn58eriqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPxVsAVq/Df1lt5aoYNX0dLBiNbWS8i+wq67xTVGODg=;
 b=C74kfYhAeyERxSok03+0eg46A+FXDxMIZT/zUFuJ34O3LKNr3x0BPZ13pBLxgQGes8DzrnS3J6xqQlDZgBiEH/Ge/xyd+5IkhVaDv+IZJPcvafOJaMpCmCSICds7BlpbKMOnBtx/sErZcGbJLt+AWIMSGvdwY3ppsqbJwAavVIverarchoPSGsCPGZBxAGMqByt0HjDFWq/JOjbFTib1WJulyPwc1Lmw85qhbAB20BMvWdZRCsZPFsymBXSdYt7Hs0REx/Gr+ZcHZzS/WjfM/MsO0+hiSHa0fxJjYEMG2SRQ2vwd9kDKc2+THD1RFqUu0olbIGMBEEg7alFlcKrMUg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:19 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:19 +0000
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
Subject: [PATCH v9 00/19] hw/usb: Add a usbredir server transport
Thread-Topic: [PATCH v9 00/19] hw/usb: Add a usbredir server transport
Thread-Index: AQHdcOUOvQ9unycZW0OUCEaWMn1xcg==
Date: Tue, 10 Nov 2026 07:28:19 +0000
Message-ID: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8987:EE_
x-ms-office365-filtering-correlation-id: 10ded4c3-9d4f-44f8-cdd0-08df3efc3177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|6133799003|10067099003|3023799007|921020|38070700021|56012099006|261102123227099003|261102130727099003|261022105027099003|261022115727099003|261022075727099003|261021123027099003|261022113327099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: WIGyxR0Ia9eT8/ImK49ALQoBHaB2zhAHOBCYaFCzrQTSQMHeYwjBVsKxqu/Ccuj2j745CRqt3VjRiwTYNZdDqCbXVyFuZi/fuF2z6VY3y5oFmJACygSWgA1RgvYzGZ0mzBvPinQ3TXA5MKOftzVXmMLnLsFlGPOwc2pf0e8o1mNDoJ/WKFZPRyVfXmWuiLESUITeWYmC7DOdtGlEA7iR3Kx+vyQsUpXH+OH5XeuS8sE38QX4s/uPmjw5yy7qHSuKtfxY1qNDV6sw3OjC/Sh5w0KOxX2Ohdf+e13sfEmxfDGh2YU3gYD6TD9m8ezjCoUsi/oUJm1VQgP2TNH3bcSAdqD9lXDDRW9eekQVOn3vv66cdG4e83/tbblOaLdF/s4gqBQKxW+4oJ8clt2nElJKvM8Ko2ivKRrORvhLSqexp89lVigWucJiVowQ3lV74ZKP1yaMf4YKzdfcYn3ID78kmeH9c64ne9ZxrcfHeDR9FsQgP14+V+mlQAYQs1uWBZJXu7LVoAFsimneJHFDWM7zzW4pTgPYpI3ziIIfkLgMUHvgDK2G4KQ1f+hPcdnhRi1M1qJ1yZtjVle5gxnNrp6JrBHCGaQF/Jp1eI3nwmkBncwvC6EJbBA1+JsvPGxV3pBrj8FX3weQuYcPiiKqeDJfz8VdRqmbbAZRjGp1bIsdB2M3uXQyLjoKT8HVvN7Ik11+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(6133799003)(10067099003)(3023799007)(921020)(38070700021)(56012099006)(261102123227099003)(261102130727099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021123027099003)(261022113327099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9s0ica91iu7h5+v8hDfeRWX4Q0UAnZlD3SKd17+t7vEhMS//XPWdHaeYBD?=
 =?iso-8859-1?Q?4yJpKEtWWyeOIYRTLMCx2IrIu7lI1hMn8/bpl7tM+92roLVEDNUJfVIhda?=
 =?iso-8859-1?Q?3NAxPmXxsinjfzKADDbk196MeFqdjNjxxR4RFV+GkBVSxFidroTVUCAdN+?=
 =?iso-8859-1?Q?RFMX3+6/q4W50STyW3v7+ueU98PPdceQOSvUID1H62iYl63RD7eY/9wlCI?=
 =?iso-8859-1?Q?ZZ1QhENCLYBvkWAzkyMT8TVpJa7YvQb55tlFLvRH1W+kUk9NgWMf5wCRAP?=
 =?iso-8859-1?Q?Azg5eRcAlj1RJdRKR7N/dACpfV/Hjau2beSg5dEqe2YQvO1kW+WLOqoZ2j?=
 =?iso-8859-1?Q?5MFwNc0CUv+7hrlKktFLKco1+NpezA2Ml56YgOIhRwdoX1F+7EEjgpb+4C?=
 =?iso-8859-1?Q?nvx5KUGz4lyXfBhrn8spzg+GHS//tGY6r1WhM+nUM/RhqFZV4DasdIKBZ+?=
 =?iso-8859-1?Q?oPa3HTh+DNkuVxdm9byq/+o3w1U3Kcfct39zB9cQRZH7LFs127m/XrqdUO?=
 =?iso-8859-1?Q?R76N0oqQJF1qjKRNKr5JPGhW/tac97n7TKJ8/m0SgnfvBq+j/1orcn+1+q?=
 =?iso-8859-1?Q?KadGCAIyKOu4MoIUVQ1jAQitVCggsSbgJZ29ibs0r4F8RHC9a8pjfN2ee3?=
 =?iso-8859-1?Q?NLQQmFUfxlMT8zBiTNBDpcf5+/SYlC6Gq7JJ/RG2qlirzczvI2Ue1+fNRA?=
 =?iso-8859-1?Q?ydsMM6nIMEi1N9R2xjM4F1OQZjXqQ5K+ocOohL8NwZxIpJNJIiXkhl+B+O?=
 =?iso-8859-1?Q?GqM80jP4kWUG244JwvJoUvfOn+mqT2+be31vYWydXJmyAKIwXeub39Ujfm?=
 =?iso-8859-1?Q?42MIR+7RepA2pUYjwJRo28N8/4j2EF1/rsvgU+jSIpFx7pJAkL0wTjcUjI?=
 =?iso-8859-1?Q?6Og5+7LpME6AYFMrq415L6pYmKgPPTnKtT8bcMV55H79gvOCJci74wIK51?=
 =?iso-8859-1?Q?XNEMUY+NXutYKHQaNlnf5IGq32sSm2XtmVaZdXgGEdEjWOIwPlhhiyIloh?=
 =?iso-8859-1?Q?LK3cKMfYciZN1jeIMvCY0b7R7EvcsfCQn+DdMUR96augz6jy262NGInik0?=
 =?iso-8859-1?Q?dJABGxw7Z690bmbuVfEzWgd9b17cSjJTwZT7I4Ff4cNbm8eUJNTUxFSFJL?=
 =?iso-8859-1?Q?28rNS4PrrwOiEXukzJiN9RAlhoh4LGpOhZzYvKcfooOpzUu3WtjLrbCrlD?=
 =?iso-8859-1?Q?IXWdaSt/p2ZAopMFijvGDEu4QwUXRvbS4TeiHvWLm+tMy65wRxS1ce4bCh?=
 =?iso-8859-1?Q?Xwfvsk3ua9jMaIJH2Yv04GwMhubmHXaDoKFjCqle4H1jSXnV5gahIEDtvM?=
 =?iso-8859-1?Q?jJ3XuBqz7tAs90u4nKxbgn1VLiFDvODjSz566x+bzza5HUnqqBtMT8HMlE?=
 =?iso-8859-1?Q?lRNe6xfdJ211bVpStkHf6O8pUYWkya8sfS9AVviySN2Wg8Vr8eKPdi6qGm?=
 =?iso-8859-1?Q?93y/IBij3B8dKO1RveF8sDZjXbYtTh3QaLZFUN9DhA526mH8U6rjatl415?=
 =?iso-8859-1?Q?Pp0V1olldo8taBNE3BwEguOBUXjDveM7sHV4V3kRNl2hgGaShHk9gXMcEZ?=
 =?iso-8859-1?Q?rNlLcyUGfv6F9AJtCX2c8hLc3miWcxVp4JjTtkH6iH38pBHmy4ntT1N+JS?=
 =?iso-8859-1?Q?V7jJnk1ORPHhW/rf0tQ25CqOfEAyvU0Qjg7bNObvH0DCL5/Lr33RUnCZWx?=
 =?iso-8859-1?Q?GlF7zyNjhauz/XlkONA4uDMusLEk2JqxEDTO2mnhTDBCHi4Sdc5vu0T2Ap?=
 =?iso-8859-1?Q?3lkA+pXArfdLjitc4tUwER4L6yFTorApqyg/kVKrOZw+MOEuu2eseRU5Vb?=
 =?iso-8859-1?Q?HJiObg4rug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R5UOFs347326VpE1TMWbXoQbfuT31yWQq0S0QYm6FMglboJn4MTQqQc7nPAB945K/CB+veHB40oYqaYh6ylvYUmci5O1bR6B4b38UY/zz1DOBDN+kBrpKwahRiwIkE8DJWlfaQhlEz3cWfnYT5txrh1Nb5IUO6jM41zZSdn2nzsdEKlx0unDAsT+Z/ESBW0WJS0jw3zDJGyga05+b50qF/AISzJn0vgY5UAm3akb9JbxDqMntq8pT/xiHewf/J5sQAG5fKwkpxJhZkEwVsUnh7aff0eg7Zsm7Ru/oSAoagmr2z6bIJpzc6pvvfZD+EafAl6ga/8r77YJI/uPXwHg3g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ded4c3-9d4f-44f8-cdd0-08df3efc3177
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:19.1800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+5a+W7z1ql1d7SiGx2PBtMgxaCg3xNQ/szfz48xrJ5MpPbjZzCSqDp5XtwnPjFVocPwX/gEcboV0nFsz0RtVdcEKaro8qM2QkkKAmVRwyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8987
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a usbredir server transport to redirect a USB device=0A=
emulated in one QEMU instance to a USB host controller emulated in=0A=
another one over the usbredir protocol.=0A=
=0A=
The v1 series included both the usbredir server transport and the ASPEED=0A=
AST1030 USB Device Controller (UDC) support. Following review feedback,=0A=
this series contains only the usbredir server transport. The ASPEED=0A=
AST1030 UDC support will be sent separately.=0A=
=0A=
This work is part of a larger plan to model USB device-side support on=0A=
ASPEED BMC/BIC SoCs, which has three goals:=0A=
=0A=
1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB host=
=0A=
   (EHCI) controllers, so that work targets the AST2600 UDC: its gadget can=
=0A=
   be attached to the SoC's own EHCI bus, letting the guest enumerate its=
=0A=
   own gadget and exercise the UDC end-to-end.  [Done]=0A=
   https://lore.kernel.org/qemu-devel/20260902021542.3194812-1-jamin_lin@as=
peedtech.com/=0A=
=0A=
2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC=
=0A=
   needs a second QEMU instance. The UDC gadget is redirected out of the=0A=
   guest with libusbredir and attached to another QEMU that runs a USB host=
=0A=
   (a VMM, or an AST2600 / AST2700 guest).  [this series]=0A=
=0A=
3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media=0A=
   support in QEMU.  [future]=0A=
=0A=
This series implements goal 2.=0A=
=0A=
The transport=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
x-usb-redir-server exports a locally emulated USB device to a remote USB=0A=
host over the usbredir protocol, so a device emulated in one QEMU instance=
=0A=
can be enumerated by a host controller emulated in another one.=0A=
=0A=
The left column is a request going to the device. The right column is the=
=0A=
answer coming back. The middle hop carries usbredir messages over a=0A=
socket. The top and bottom hops carry USBPackets inside QEMU.=0A=
=0A=
    remote QEMU: guest driver -> EHCI/XHCI=0A=
             |                     ^=0A=
   USBPacket |                     | USBPacket=0A=
             v                     |=0A=
    "usb-redir" (the client)=0A=
             |                     ^=0A=
    usbredir |   chardev socket    | usbredir=0A=
             v                     |=0A=
    x-usb-redir-server (the server, this series)=0A=
             |                     ^=0A=
   USBPacket |                     | USBPacket=0A=
             v                     |=0A=
    any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
=0A=
"usb-redir" (hw/usb/redirect.c) is the client:=0A=
  - it takes a USBPacket from the remote guest and writes it to the socket=
=0A=
    as a usbredir message=0A=
  - it reads the answer from the socket and completes the USBPacket=0A=
=0A=
x-usb-redir-server is the server. It does the same thing, but backwards:=0A=
  - it reads a usbredir message from the socket and runs it as a USBPacket=
=0A=
    on the bus below=0A=
  - it takes the result of that USBPacket and writes it back to the same=0A=
    socket as a usbredir message, for the client to read=0A=
=0A=
A USB device has to sit on a USB bus, and in QEMU a USB bus is always made=
=0A=
by a host controller. So x-usb-redir-server makes one and acts as the host=
=0A=
controller on this side. It models no real chip: its cable is the chardev=
=0A=
socket. The real host is in the other QEMU.=0A=
=0A=
The type name has an "x-" prefix because the device is experimental. It=0A=
has to sit on the sysbus so that "-device <dev>,bus=3D<id>.0" can find the=
=0A=
USB bus it provides, and that may change later.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported: the=0A=
protocol has no device address field. To export several devices, run one=0A=
x-usb-redir-server per device, each with its own chardev.=0A=
=0A=
Testing=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
A plain usb-storage device was used to test the transport. The storage=0A=
device is attached to x-usb-redir-server and exported over a Unix socket:=
=0A=
=0A=
$ qemu-system-aarch64 ...=0A=
-chardev socket,id=3Dusbredir0,path=3D/tmp/usbredir0.sock,server=3Don,wait=
=3Doff=0A=
-device x-usb-redir-server,id=3Dusbredir0,chardev=3Dusbredir0=0A=
-drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw=0A=
-device usb-storage,bus=3Dusbredir0.0,id=3Dmystorage,drive=3Dusbdisk=0A=
=0A=
The exported device can then be attached to EHCI bus 3 of an AST2700=0A=
guest using the existing usb-redir client:=0A=
=0A=
    -chardev socket,id=3Dstorage,path=3D/tmp/usbredir0.sock,reconnect-ms=3D=
1000 \=0A=
    -device usb-redir,chardev=3Dstorage,bus=3Dusb-bus.3=0A=
=0A=
The AST2700 Linux guest enumerates the redirected USB storage device:=0A=
=0A=
root@ast2700-default:~# lsusb=0A=
unable to initialize usb spec=0A=
Bus 001 Device 001: ID 1d6b:0001 Linux 6.18.36-v00.08.03-gaf2f426c5786 uhci=
_hcd Generic UHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.36-v00.08.03-gaf2f426c5786 ehci=
_hcd EHCI Host Controller=0A=
Bus 002 Device 002: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
=0A=
This also demonstrates that x-usb-redir-server is not specific to the=0A=
ASPEED UDC. Any USBDevice can be attached to its USB bus and exported=0A=
to a host controller in another QEMU instance.=0A=
=0A=
v1:=0A=
  1. Add a usbredir server device=0A=
  2. Announce the exported device=0A=
  3. Implement control transfers=0A=
  4. Implement bulk and interrupt transfers=0A=
  5. Stream interrupt IN endpoints=0A=
=0A=
v2:=0A=
  1. Split the original series into USB and ASPEED parts as suggested=0A=
     during review.=0A=
  2. Keep this series focused on the usbredir server transport.=0A=
  3. Move the ASPEED UDC changes, AST1030 UDC support and its functional=0A=
     test to a separate series.=0A=
=0A=
v3:=0A=
   1. Move include/hw/usb/redirect-server.h into redirect-server.c.=0A=
   2. Drop the announce timer. The firmware does not toggle the pull-up,=0A=
      and the delay would be machine specific anyway.=0A=
   3. Rename the type to "x-usb-redir-server" to mark it experimental.=0A=
=0A=
v4:=0A=
  1. ep_info now says what the host chose, both the configuration and the=
=0A=
     alternate setting. Keep every configuration descriptor, not just the l=
ast one.=0A=
  2. look at the request type too, not only the number=0A=
  3. wait for the endpoint's bInterval before asking the device=0A=
     again.=0A=
=0A=
Patch 7 lost its Reviewed-by because it changed. It used to ask the=0A=
device again from a bottom half, which runs as soon as the main loop=0A=
comes back. So there was no wait at all.=0A=
=0A=
A keyboard answers NAK while no key is down, and the retry timer paces=0A=
that, so it looked fine. usb-net's status endpoint answers every time.=0A=
The loop never stopped: ask, answer, ask again, about 17000 times a=0A=
second. The same main loop runs the guest's timers, and it had no room=0A=
left. The guest stopped feeding its watchdog, and the watchdog reset the=0A=
machine.=0A=
=0A=
bInterval is the rate the endpoint asks to be polled at, and the rate a=0A=
real host controller uses. The stream now waits for it.=0A=
=0A=
v5:=0A=
  1. Use a separate timer and bottom half for each endpoint.=0A=
=0A=
v6:=0A=
 1. Fix a build failure from a missing header.=0A=
 2. Free the packet data in the control, bulk and interrupt callbacks.=0A=
 3. Cancel the packet before cleanup on USB_RET_REMOVE_FROM_QUEUE.=0A=
 4. Send no reply when the cancelled transfer is not found.=0A=
 5. End the interrupt stream only on USB_RET_STALL.=0A=
 6. Keep a USBRedirServer pointer instead of pointer arithmetic.=0A=
 7. Cancel the BH and delete the timer in stop_interrupt_receiving().=0A=
 8. Start the interrupt stream loops at 1, endpoint 0 never streams.=0A=
=0A=
v7:=0A=
 1. Add a flag for the automatic hub and leave it off by default.=0A=
    UHCI, OHCI and dwc2 turn it on.=0A=
 2. Drive a control transfer with one packet and the setup fields in=0A=
    pkt.parameter, instead of walking the token stages.=0A=
 3. Keep a request the device answered NAK and send it again when the=0A=
    endpoint wakes, with a timer for the devices that never do.=0A=
 4. Give each endpoint one struct, holding its waiting list, its retry=0A=
    timer and its descriptor fields.=0A=
 5. Ask more slowly after a streamed request answered NAK or failed,=0A=
    and keep the endpoint's own rate for the good case.=0A=
=0A=
v8:=0A=
 1. Report how many bytes the device moved on a bulk or interrupt OUT trans=
fer.=0A=
 2. Implement isochronous transfers for an OUT endpoint.=0A=
 3. Announce the device from a bottom half, and reset it first. The old=0A=
   path hit an assertion, and the device has to be in DEFAULT state=0A=
   before it can answer anything.=0A=
 4. Avoid cancel a streamed interrupt or isochronous packet.=0A=
 5. Turn the automatic hub off by default.=0A=
 6. Give every USB host controller an auto-hub property, off by default.=0A=
=0A=
v9:=0A=
 1. Read the device and configuration descriptors before announcing=0A=
   the device. Send interface_info and ep_info with real values before=0A=
   device_connect. Close the connection if the read fails.=0A=
 2. Add a TODO to the auto-hub patches. The compat entries move to=0A=
   hw_compat_11_2 after the 11.2 release.=0A=
 3. Do not hit an assertion when a control packet arrives in the same=0A=
   read as hello.=0A=
 4. Send cancelled for every packet that stop_transfers() drops, so the=0A=
   host does not wait forever.=0A=
 5. docs: say 12.0 instead of 11.2, and explain how to get the hub=0A=
   back with "-device usb-hub" or "-global <controller>.auto-hub=3Don". =0A=
 =0A=
Jamin Lin (19):=0A=
  hw/usb/bus: Add an auto-hub flag to the USB bus=0A=
  hw/usb/hcd-xhci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-ehci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-uhci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-ohci: Add an auto-hub property and leave it off=0A=
  hw/usb/hcd-dwc2: Add an auto-hub property and leave it off=0A=
  hw/usb/xen-usb: Do not insert an automatic hub=0A=
  hw/arm/npcm7xx: Keep the automatic hub=0A=
  hw/usb/bus: Turn off the automatic hub by default=0A=
  docs/system/devices/usb: Note the automatic hub change=0A=
  hw/usb/redirect-server: Add a usbredir server device=0A=
  hw/usb/redirect-server: Connect usbredirparser to a chardev=0A=
  hw/usb/redirect-server: Announce the exported device=0A=
  hw/usb/redirect-server: Implement control transfers=0A=
  hw/usb/redirect-server: Send device and interface information=0A=
  hw/usb/redirect-server: Implement bulk and interrupt transfers=0A=
  hw/usb/redirect-server: Stream interrupt IN endpoints=0A=
  hw/usb/redirect-server: Implement isochronous OUT transfers=0A=
  hw/arm/aspeed: Enable the usbredir server transport=0A=
=0A=
 docs/system/devices/usb.rst  |   17 +-=0A=
 hw/usb/hcd-dwc2.h            |    1 +=0A=
 hw/usb/hcd-ehci.h            |    4 +-=0A=
 hw/usb/hcd-ohci.h            |    1 +=0A=
 hw/usb/hcd-uhci.h            |    1 +=0A=
 hw/usb/hcd-xhci.h            |    1 +=0A=
 include/hw/usb/usb.h         |    1 +=0A=
 hw/arm/aspeed.c              |    7 +=0A=
 hw/arm/bcm2835_peripherals.c |    1 +=0A=
 hw/arm/npcm7xx.c             |    2 +=0A=
 hw/core/machine.c            |    6 +=0A=
 hw/usb/bus.c                 |    3 +-=0A=
 hw/usb/hcd-dwc2.c            |    2 +=0A=
 hw/usb/hcd-ehci.c            |    1 +=0A=
 hw/usb/hcd-ohci-pci.c        |    1 +=0A=
 hw/usb/hcd-ohci-sysbus.c     |    1 +=0A=
 hw/usb/hcd-ohci.c            |    1 +=0A=
 hw/usb/hcd-uhci.c            |    3 +=0A=
 hw/usb/hcd-xhci.c            |    2 +=0A=
 hw/usb/pc87560-ohci.c        |    1 +=0A=
 hw/usb/redirect-server.c     | 2671 ++++++++++++++++++++++++++++++++++=0A=
 hw/usb/xen-usb.c             |    1 +=0A=
 hw/usb/meson.build           |    3 +-=0A=
 hw/usb/trace-events          |   46 +=0A=
 24 files changed, 2773 insertions(+), 5 deletions(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
-- =0A=
2.43.0=0A=

