Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01873EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6X-0001n9-Cm; Tue, 24 Feb 2026 00:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6N-0001k2-P3; Tue, 24 Feb 2026 00:36:57 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6L-0001LR-DT; Tue, 24 Feb 2026 00:36:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjvlHW2x38OXy49ddy7jk43/22Q2HljW8uyLXzjaY9n6u9s9PAcQxGN6z2dr8EBUsYXlzyqj7/cR3kfuOsurPhqOFYMAgge3ZKwY+4vlBora8jhAM6Ra7zwf8+WQiCOF/B0W4LJVQYOyDsKGIbmssX6cJBJxQE5RWWDzzrVt8QzTbghYQsfQpuEwBhDpKk/ok/gmKuM5Bc+y2bebLX/nOBnQRjiI9vaLC3QyCnO5tAnYE6++O4KnQGCjgNbV8dwXtMsb6A1I/u086bgVNHRW4/ZXmAe3H6w7jaRgkbomvsGrR/SCzLkAIR/FuIrMBs36k5hqGqONlhwn2UjBFe+z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOpWQQBZbGSCguPZQkllcxp24I2J+CNuvsObXbvIlp0=;
 b=tZ417mpA3Iw2oqlGyS5eG8WnWKgYZwaCChQYMhC+6emhbYnTPkB8Ag5/pS1flb2CTKC7TplxAvLi+GdL7ThpJgH1wW/KY0k2xfGZ3wCNgqgwEwkrbl6D8sBYI3rjhB9XC2+irUn3mUxeZL319fWg2UluWQ/uJ28V6nOZUOAhbnqevFEM/HmLjw3qQDdhOB+Ui4H20UuXaIo+AEOm+hSBsGIwwl3S/xAfzX0hGlPnWbzLXQS48QUwuR6bsYJfJ9dq7Iv/tsJPTTWqscgjft8q47/H2iGZmpJRhXstjGtg7IORrRFu5NGpjF0neisaMx1I2HUjQXzAqd2tUsvBKonW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOpWQQBZbGSCguPZQkllcxp24I2J+CNuvsObXbvIlp0=;
 b=dizBsfA/yOfNlaJ0QRyq4ykWt+GpJ5caKkpaeqW5BVUmtzSzGgp7/XxPkAktdIF6YpyyCeDp44Wxf7E6tJ9F3Me4WXQSRVhb8yNETSHZm1y2+kxI52ZpPAfnM6/TXsuuUs8tBy1kGxAgjUENT9sY6P+GRA17qqwKreZoqXMSn+t9WluKah/obx0MZnoUBQFq/kjJYU7Erq55+hnE44nsB2e8ZfSRfdIbRNDCkeFCP9lxzka8gnIWDVKlNnWOTd2BmDz48tnSCrDbMJga/4wGinOUCCJCt0KAQ2ajnnYZgNPEUeSpYPxuOt+DpBAusm6FuaXRP98yQFHtyHkwP9NzBQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB7033.apcprd06.prod.outlook.com (2603:1096:820:11a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 05:36:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v6 22/22] MAINTAINERS: Add I3C maintainers and reviewer
Thread-Topic: [PATCH v6 22/22] MAINTAINERS: Add I3C maintainers and reviewer
Thread-Index: AQHcpU+QuycfWkTqEEWOXUCbiNizyQ==
Date: Tue, 24 Feb 2026 05:36:45 +0000
Message-ID: <20260224053613.589102-23-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB7033:EE_
x-ms-office365-filtering-correlation-id: 25948f0a-41f5-4d1d-227e-08de7366b2dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bSNTLue0vBLr8qGnt4TS4xyhSoBEcF3z+9PxavXDGtzNOYW5zfUyp9MM/u?=
 =?iso-8859-1?Q?NCb09g/xsQNAj/vlEAa0UF9IAlHa9N0H8gPqxRkzQTLDHLTdN5l18EXuix?=
 =?iso-8859-1?Q?tUxo60YddCAyAmcdxVUDWrZKMG+svaJ4ibJOGWrV/X9zWVLdJ4zOCUQ4NG?=
 =?iso-8859-1?Q?qgEz/OGpRyFTXFlWTaoVUjCnzb6aczgVFlF8Sa2I+fDyDsEQwt0Y7/DS0T?=
 =?iso-8859-1?Q?yw0C7Vwn/GzooKtrPBkeCnGD2EzmDawyAaX2O7CiL8dthX0UNFk++iV99g?=
 =?iso-8859-1?Q?kqU5fmSUq6jwQxJD9o31RRlOhqFX7io+4lVIQl8aPs6jOmo69qYatkYIoq?=
 =?iso-8859-1?Q?9Suo5vT0c4Xvv0XSPb73LfW7FOWPNDqs6s4sHb/8tS+pGSgg42gC+c7+v1?=
 =?iso-8859-1?Q?9iTEk9UUQhUufORkcFHMSI2HQzvEwmrKfWMRr3XXICCAzlN6uuqx5Wl3+c?=
 =?iso-8859-1?Q?vuSTojotVyp4Ur2R/6NN/1pTXUSLQzcDaIOh/Zi/jJrzNUOYPT6pDf+xhg?=
 =?iso-8859-1?Q?tQzJwe+pMduA+Rj9HVvu9820ciQ9WWqLOaSanE87cY3FyWUCaWTXiIrI/o?=
 =?iso-8859-1?Q?rHll7mBlnunCIRgS43MOvaRkUd3y1sQcm/88/ZUGRlCl+tQfb1VDBzJo1f?=
 =?iso-8859-1?Q?ZJflopzEaon0GE14gSkDY88VGS0luXsQU8O8MI3/Mh1eCNRGXAidA2aCze?=
 =?iso-8859-1?Q?8Rp20bYJBIZnOIIJclVwpyJevu54ECePSoyjzpT4aD9CThyr34XjSTauVH?=
 =?iso-8859-1?Q?ITbJiwREwUCW+xzwjJrh9i/w17hY2XQYwobXLbn4dhY99FjK6MSOsKIF2h?=
 =?iso-8859-1?Q?KRnRAgxm+Utrb1Ir8WUrC+5r0bosEFhQD1yvEMcxoyrq7XfLFDCWpFN9mW?=
 =?iso-8859-1?Q?VAh2YukpWavMP6DIc6OquDjCSdof0qwzyPA4jlzOllDdfWGRdI+V8BEQwq?=
 =?iso-8859-1?Q?IgPcoa6rY1KOJ5ZJPXOaFKhsALifgT5wCq+rM4EUjk8KjGfjAVN6QS5a+q?=
 =?iso-8859-1?Q?tpX2AwLOqTKFqeaT+VhfW79BmKnYjsbdmVDQ7VNTseqkVSHfRq+LXJUTZN?=
 =?iso-8859-1?Q?Dbi9EklCQTMs0xUuAvVgS1+1ptHC8hLnb6CFgt7E9BtjQc0zh7IbSmxxgC?=
 =?iso-8859-1?Q?yRJJAZaD+vveFLeJ6vw69vxckqh5t7spdLMK6a38aN7Xds/dyu9PUg1tS2?=
 =?iso-8859-1?Q?a7yQErO0vXItMRR8FB/u4JUNjWMYivs6X07Il1YOZRcBKkwPuUH9rkCZsL?=
 =?iso-8859-1?Q?Gad3TD/e42DlNokIEQOWjaiAjeWVyqAG74yMs8pSNNEufaAClaf/PRcbiW?=
 =?iso-8859-1?Q?Rq5R/6DTDO0jvelHOATboH1BfDvrFXNpOXzc6s8w9qB1rULH4s0yWG43No?=
 =?iso-8859-1?Q?sp2qeFlwWaY8NmcywecD9z9FVY63xi3uyzQHIMpVXr9EtV80hGZkMdYcny?=
 =?iso-8859-1?Q?aMNsQ/nPeUaGXCo1T9yZTVTciovO02zBfoHnBNGASKd+TWm7/Rm92rBU+S?=
 =?iso-8859-1?Q?teAFIR92Fo0KI7lpKLlt73brfGINT7VqbNgxXk6EFTrPHOJzEJ40CToX0w?=
 =?iso-8859-1?Q?33XbI9/vPv0woeySsFfrQVrHcb82HSXJsFEHCHIRKIylmJfTxRYWEXrRwQ?=
 =?iso-8859-1?Q?32H+3pYTq7skFod28oQEioX8jQRVDTeQSp4jRpojAtgXrLjDsHU7GuP6WX?=
 =?iso-8859-1?Q?Y1bukJMq2K+9INNhSvVVU/d/ZS4W6XGF4WKAxpEn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Aw2gzonLd/U7lm1jQmDUbjc5gYFdH+TcobXV3389KqaTjDa0cC5PDRb4/a?=
 =?iso-8859-1?Q?vvof9X3Kc4zV3HL98x7uq6u/QM23+6MTlRzDsku1gOxKTfOMfl+Zu8bO14?=
 =?iso-8859-1?Q?heNYic8ph3aT+k6z2oe9HCp1NkBs7A8+LN13d6npzVZobfea9UozaOCsbx?=
 =?iso-8859-1?Q?zV2nzOhnyVkJNWIRaVvyoe+dZ4RwkMAdCpxkDhhkAi/h78XvtgbH92rYkD?=
 =?iso-8859-1?Q?20K9RLsQgfwCRKFkHdazAVd2a82EMZNvR2dtSQQhfsulQvUWGexC67RwSf?=
 =?iso-8859-1?Q?upVJv9EU2wu9KtcVUOjDtZaKTi186uO0mPNasrMocHQLdgcB+mzx19GI3r?=
 =?iso-8859-1?Q?JtIt2lt/t4lu2vI84JvH4C+f8hJ5F8qU6rNKy1ZzFxJfuH7csXeoBn8DH2?=
 =?iso-8859-1?Q?ILfVHeAHKUPJ5AqgzvNyCjI2jvhuiOzcEcitoP3+S+HgOkgbms9xof0k4a?=
 =?iso-8859-1?Q?M6WdO2NydkASkwp4E2Mj+mpuaN3Ba+nQB5hcgSFRb1+ZBGIexWinTQnUny?=
 =?iso-8859-1?Q?OIew21ioH2+uZ75/9UxcRhKcI5konM4PSGYV2Ae1nm7boVC++DtYl1pZgQ?=
 =?iso-8859-1?Q?bCvTTYCdf7YQIK2qqF0gRrryIL1q7eYh5lUqlZOjHdVYiF01TsxKFn4jEX?=
 =?iso-8859-1?Q?cn7Qd7pOSXBhG3i2dOYezlzY+RYH/gZQwmnceedZRB3nWEuUgCyJ0yLuK7?=
 =?iso-8859-1?Q?wp4zYXN/i35PMZwZiVIqXOP46yV0PXk0NkMfiWt4m+hGS7U1qrtQPbabrF?=
 =?iso-8859-1?Q?qRkFL4GVejGNYwUBNB2l84EGhKj0q0Jp56aiLB+bomCi0GI64qJA5gyRYX?=
 =?iso-8859-1?Q?qjsJTzgck9C+Wvi/hvje3YWN9Oho1BWFjXYRL69Y0lZuxo6908oqWceiST?=
 =?iso-8859-1?Q?mBu4I59QPBzjzJJAKBdevdeDSWCJIUHPmPBg1gsSdYkO0MFI8V/lPNpHDb?=
 =?iso-8859-1?Q?iCGn0ymD+3hTVLS/8Gm6kU5aZn3stRk+HnMOr4+73TZZp44ghqnJxMtPcR?=
 =?iso-8859-1?Q?Y5aTQGE06ckMEjhB3HGFLW3FpUVSD47kc/qIelseQY7PaH69fTp8IO9+xQ?=
 =?iso-8859-1?Q?SpyGW62Ayfarlfk2x5y1g3fgxUHpKxcw/OuJgL3yVzT/JCp/JsWTq3f8mm?=
 =?iso-8859-1?Q?+JvUd/Ca9gF4B2C4uIYfIXykRPWvfWktWWt/OemRmV2rWOdei00dFkPpOu?=
 =?iso-8859-1?Q?61qcDKVBjUqeaEbdezLEAok+/XtJ2buuPF6MhSMscNei0IfDn1y00Bnz3q?=
 =?iso-8859-1?Q?47mAhq9XyawXhQEBJ8JDTqAZ42fZrm6RrDfLh8Plo+gVVZQQLfxZz/Zlzn?=
 =?iso-8859-1?Q?o/UMPoRH4OQRqfx3PQP/OgIIw32T7dRlc9njmVesLolmbgMr+f47uJpuru?=
 =?iso-8859-1?Q?8xx+u6nrppI+qDtLFbj21TWpMXZUGs5tu3RpZmO2Fcu52W+j7wFYWl6NuN?=
 =?iso-8859-1?Q?QJrmDX8STSUVbDtK6oNRr8aW64QlZ5G8UT3OrzafQvSLwCA4QLvL8+nPFZ?=
 =?iso-8859-1?Q?b96N50bGFNY2kWxTAsacG0ILplQalaa+vwoLp5x45NW0Q7/9QSa6KGOtCn?=
 =?iso-8859-1?Q?4mb71VoaefMzGy384MzKunQiaiLKJ5mzhYvlw7ZD7wwSw8SRf2AkunjPxF?=
 =?iso-8859-1?Q?TeCMIzhZnSMrozplci4o4CKHwASk2WyJKxucbJAQFttvplXtE2JlEQV5y2?=
 =?iso-8859-1?Q?trnX0y63Jj/AI21VAoEqgqA0QtgnHFz1ziJQgjT9FpiWc0vydohOnIQZQa?=
 =?iso-8859-1?Q?l5YhHvOn4/gwndAondWowMgihANO1EsSShHWtcefIYrUmylExnhmud+CtW?=
 =?iso-8859-1?Q?SttAzC0lQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25948f0a-41f5-4d1d-227e-08de7366b2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:45.7479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWs8WeDmX3TxdbwutnhXff3mourYkzWQCa+svdoL7kmig5LLGJi796CcYgaRKGSavqHsrGMWxTlJ0i3LCIwlyNNq+zhTUxy/dWJhomRaJiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7033
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

Add a new I3C section to the MAINTAINERS file.=0A=
=0A=
List Joe Komlodi and Jamin Lin as maintainers, and Nabih Estefan as the=0A=
reviewer, covering the I3C core and related files under hw/i3c/ and=0A=
include/hw/i3c/.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 MAINTAINERS | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 233d2a5e71..7bf78e0691 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -3933,6 +3933,18 @@ F: include/hw/i2c/smbus_master.h=0A=
 F: include/hw/i2c/smbus_slave.h=0A=
 F: include/hw/i2c/smbus_eeprom.h=0A=
 =0A=
+I3C=0A=
+M: Joe Komlodi <komlodi@google.com>=0A=
+M: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
+R: Nabih Estefan <nabihestefan@google.com>=0A=
+S: Maintained=0A=
+F: hw/i3c/*.c=0A=
+F: hw/i3c/.h=0A=
+F: hw/i3c/Kconfig=0A=
+F: hw/i3c/meson.build=0A=
+F: hw/i3c/trace-events=0A=
+F: include/hw/i3c/*.h=0A=
+=0A=
 PMBus=0A=
 M: Titus Rwantare <titusr@google.com>=0A=
 S: Maintained=0A=
-- =0A=
2.43.0=0A=

