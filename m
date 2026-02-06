Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED153ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOh-0001vf-UM; Thu, 05 Feb 2026 22:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO9-0000Vd-4w; Thu, 05 Feb 2026 22:20:19 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO6-0008HM-7D; Thu, 05 Feb 2026 22:20:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wio7xrj8z57d4ChpSMXkgkTvS2CMlVZf4KW9ojsv2nYoW8+skKdfZW2UeZD7NCSk7MtY6OtAEJZGgETglbD7eE3od0dOG7rnyZBSiFCVdYpkB6HY8rQnEuogCAjyS+U4L4atYzUwPG3J/0xy1vf3Nyg03343JFY4jHp8gQW5zG9qON02rzAHrh4I4y/TB5kXcTPLThpbicZPoz3qnQ/kL3WPEgrg0OhcA2raQNijibcscmn5Lm+HaB6AZv8fJGdxaArLOnRkgSHBU+oDStomNLRirGTUuFgrzCey6zERQT7X0yDNszHczc6aYoY+AXK/JEeldfHAb5cOggnFrXF8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSsSPTyfKgXFuxsBcGKMtjX2k24Zj/mMd0eD6WqXFpM=;
 b=EQrdK7pEpvWjSAjNbOytTy/N1cGLTPb+dXKUUdlfjIoW+bhyxHrUtCDGI3vFvOY/LpoITjCNykDE6eH2nRx2NgiZbFguy1yl1B0PefNVZpylEVmG2JJU3iI8rzp1gdnO47xIPC6Bt5ncMJyCIOtKDV6qlnhbEpcAbvXZBAHuW28ghSd1Tt7WFxas9xIIy79XJs/Gv5hDBepT67dtpKkXOk48CbwuTWNvCLE8kHMWCEZFGlF6uScqukCu8gAk4Wl0X1Y0+PMNBTVsW5DJNh/CbS09qpXcsVqCJaKMlnjvXPAFe/VLvvQGO/FoLyPh1WhoK72rALcsVCDNOWKsly0qCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSsSPTyfKgXFuxsBcGKMtjX2k24Zj/mMd0eD6WqXFpM=;
 b=TGTwO+V7AZ7aq5AztqsGrVRHnCihliHcM0twbEsPyThRlMv9U+Q2Z6SLjrKdnJNNXwnR6802E6CVHIhab+TDlVP9IcHjBC9X+nMSoQPcHQT4D+MZM5ln/sKZxR6bbEMnO3ZUMiPizS1LtN/IkdAZ3KoJfeIRWLglgBQJIsC0vAd2FagbZ7fw8Am0OuaZCr79I40JAILseutM36LtF0bFlNIofaYsC6N+6DOttKPkdH5uAoipiuxagavLL3B7QiNff9mKesErQ+mIJwCns26CNDR/n/qIlRnjt11m/9J5r21dK37a9MIoerC4n3gALZTdfB1I89RaoIP6RnKw3lSwZQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:46 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Stephen Longfield
 <slongfield@google.com>
Subject: [PATCH v3 13/20] hw/i3c/dw-i3c: Add IBI handling
Thread-Topic: [PATCH v3 13/20] hw/i3c/dw-i3c: Add IBI handling
Thread-Index: AQHclxdxcLv+NaapTE+sbayQFLnCeg==
Date: Fri, 6 Feb 2026 03:19:46 +0000
Message-ID: <20260206031926.3227848-14-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: b0b8942c-720f-46bb-aadd-08de652e947f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?svnTboP3/BtG2PDJtRpWT/YznXsEckoqRz1eeXujzByJK4p+hdHHDznW9T?=
 =?iso-8859-1?Q?3+CpAKfUHAgraADr4DZvPsH7Q30DGFgxqHU0dEH9pKiHQ2BEI25+AS4i7n?=
 =?iso-8859-1?Q?QPxI6hZ8+Cx/8ok4APHJRIJTC7S7vC2ky3BNZijpbo5yGlGTznFHj1q6wp?=
 =?iso-8859-1?Q?FEOj7DaM+yHBAOpfWCrI6sADTluktAj1r3T35DSsnUfwqB9yaWyzXN0bCh?=
 =?iso-8859-1?Q?HOjX9/+2cLziLSc2qQQeFzlw4k2nwzADz9VEUWZZG9RknMZhQVO3PYPO8u?=
 =?iso-8859-1?Q?rsie0nrAIaVhYvhnLW4u7m/r2fgSFN2XBxCJI99e6kKu/dQLNQsS7aJkWB?=
 =?iso-8859-1?Q?rQoIoafaPjhilW0zSWjk6Y8SDg434gv/uW34TqJd1od7XC9dvWjDN0zeye?=
 =?iso-8859-1?Q?Vx78o274o4c7hqhmzI8gNbloafTC3676facQ7Ck0Mjc+EJfiqhEwrU8hb7?=
 =?iso-8859-1?Q?Q4CwReG2czYhDrKlUc66rInLUnkTH2q2Q3D62kx/EJimMbL9oP1Ld/k/qS?=
 =?iso-8859-1?Q?ERoQ06a9dh6lIlWMSDrG89tPdAWiWOx8QsnSKLsjaIY1BNNWhSj5yS4Upl?=
 =?iso-8859-1?Q?YM7JojouZpDJIQZZOIsu1kJeWwWtAgSNVh7CK9h3X1xYQ7fDBwT0Ki03t6?=
 =?iso-8859-1?Q?latE124Oba42XXHXjYlUSK1TpEgAtPjBzp3TihFtfYVwIUfgwuXFJg0tdd?=
 =?iso-8859-1?Q?jyaVwhv5Q5/6kGR7aFaHIX+HBjCRrtn236XljTZyPdR760ODIHWwQT3XuE?=
 =?iso-8859-1?Q?bnlrx3dT2v3X+qrSOqJl1UvTYnxlq/1yrvBDQ/tsyqHC5VqZ3tt7TP0f0g?=
 =?iso-8859-1?Q?v7Kj+y3LaB8Xrrtob49Bgd2x4zncCCHNbxTGi1qTckVYu/jtMnu48XlK+5?=
 =?iso-8859-1?Q?eGOiR4Cb+g+s9SMKFfjBF09w12LcAd88H49XCAIetPe5J5zNiJylaK17Sb?=
 =?iso-8859-1?Q?VdgtJxbFaKCHI24ovXd/iDEPLf9c0Yyo+O2nOcUj7oA1yMu2qj2KbAkIwz?=
 =?iso-8859-1?Q?7zlV6ysWlBSURCNoy4S2BRQr2+dfv6uo3IKcvz061lNonsVbV9bzzR3jqw?=
 =?iso-8859-1?Q?MPJA3Pgbs8QSLJ9npsRjdgu8iynB4u7PWWblAHXp4Z4DhSXCTNNsQuLtju?=
 =?iso-8859-1?Q?eAETWMOezbBYBEwDAc+Q7ZxGxidh6aaXu30MaLBC/ckRH5rqqcVHsWlLXl?=
 =?iso-8859-1?Q?ewolY4IespC5EZvXL40Y+I7IB9XvKu0i+yfsbKEZKO7Ha/ZNMs8WS6gkxT?=
 =?iso-8859-1?Q?3Z9yaSD+afGfBlGkWwsxyswxg220Dea8Zs9lFhJxtdQOFEZXVkGOL7leUm?=
 =?iso-8859-1?Q?K1hCYJ5UWjFkuBnsLBAHD6nhY3iMyvftdpEBnlG5/xIL0RoD+Z2lwwzuU1?=
 =?iso-8859-1?Q?ajDLWQFatEDV0MWEbHkF4V4Ex9tOT2ldzVIPKtV9K5Lhf49mSNKUFQsYrc?=
 =?iso-8859-1?Q?9DnaGra+jTqAGuinlLbgd8kG7/lvBSOjKGH2acgAU7Ii9dqDrCBO/N9LE2?=
 =?iso-8859-1?Q?irf0bW2SfgAFE7j4o9aCeRhp5XzTcqj7EJX4reu0q00N96mlh2faCKUOXn?=
 =?iso-8859-1?Q?9prDET8TmS5OY9sbr9g3cW9llfTUaS6Hxa+/GXxSTgs5tQ0vIss5bj7B33?=
 =?iso-8859-1?Q?7if2AqvMaAzfKM3Aili9nYVMkhbSL4ZbCNQsqa8xcQ08NghLTX0AbP58g9?=
 =?iso-8859-1?Q?XYNUVPHlgy+M/k7OIVRdGpqxWtTKkhU/Z1jEKJV7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ClcluOTkJ+TyQQvvr4gYF9U0UF6zngWqp1uRt9Si6Od3op1Afh45psOkoc?=
 =?iso-8859-1?Q?OP9U/52VaqXLAGRWBwRkUPYf3I763Hlo8DCEdQQsRvBdo6sVrEKikxTytg?=
 =?iso-8859-1?Q?rfO8/rhIQKcpmrdmoFyZf2TkVBDMkjTxEJPpWMogMJc1+tIWrKsBbG61r1?=
 =?iso-8859-1?Q?2ICmBOsYElDIvI4cJI+IyMO0HIH/nlmoJQGoyylAZRMrBRg2w1xXsKktlu?=
 =?iso-8859-1?Q?/WTNhTkXnhNXtjxfOmvZ1jWBoqyyGe1qWGB1pnOBhH7Wj5zERyC1nmVfLZ?=
 =?iso-8859-1?Q?NeULeVDIXv+xnFeyURcnXwYOiGXompJrCidxT8HMa8EZfi+bAxNIlQ0U58?=
 =?iso-8859-1?Q?TV4Z/XNd1t+uPYZwHrKXZX3BhKCsOPVxiGANHB+Jfg+ai1+6GTmqDI7NPc?=
 =?iso-8859-1?Q?n/XGt19qgplHUZrnbvKlh199XkEXeGr/t0Gz5B4Ux7gEn3K9YKFm8O/Vz6?=
 =?iso-8859-1?Q?TLGnuYxFAfpJdrs1lj8ssLgts6/qTfrRZZvs0y1878QqDKmA6+kS4XkIJN?=
 =?iso-8859-1?Q?pTdGiKt4Q7KRGh6nmtKzHj6GPmZoVFqdeEl5Nzmz50uFkTpXu7dEWXaA5+?=
 =?iso-8859-1?Q?hBLLpYfvm8CBk8X5mSBt8QjPALk/uhxvzvHeds1U7Mu6e58wmiNLLnF00j?=
 =?iso-8859-1?Q?wsitTHPLUh+RMivxy/8J+isxWOA50KrGR9I/xB3E+9zSiMXlCjVEoOZElT?=
 =?iso-8859-1?Q?KWtkuAIEDbSkoYWUbASW1QN90EQGm8Rwc1bLqMxHdcW2vnN3BJE9wmoRwp?=
 =?iso-8859-1?Q?6l8+bZj4SlUQIMzsdkOnJJo4ZJ7DzK//SskRsEikf/1unk2TwSLeWVfu0f?=
 =?iso-8859-1?Q?HtTCD3JJkyWuSEjxeaBYRSS566HT7NItLi3oBUb7xn84DxnnkUJU7fTesy?=
 =?iso-8859-1?Q?2wF6LsGh+OfF6pnaBW/wD9PUlHxGJzUN5BSNUfrhuTXwKIlkQebGXLHR1y?=
 =?iso-8859-1?Q?FZ643Lm7PHja6Ie+qLJvxZ/Q1x1cMIeeGHUtsU35jwuv6/YD2cjrJ17g/T?=
 =?iso-8859-1?Q?LINqdbc89fQ/JfPehwrsrYtAXaPG56jUKTAKK85IqSdwl9ccKDXLrXH5JK?=
 =?iso-8859-1?Q?uZ3IDjZphKguNucMizuBvdX+Ba9ppP9B6U3LljL43S/C5IQVv8caO1sgJB?=
 =?iso-8859-1?Q?JerSmdnaCJl8/TeBqc7bZIfwL32rJeRE44n9jSgdL4UUSwkmEBOFIjNH0m?=
 =?iso-8859-1?Q?f8npSzFzWXUW4jExGQDyxgCLyMzsdMDA9bAOpsdxCHxMrYCLBvUyR6rlas?=
 =?iso-8859-1?Q?uANcCYENU1ALKxQ/EQFHeOjtEYoXGnJJCbDtEy3zz4oEvnCQpEPn4x5qFY?=
 =?iso-8859-1?Q?7krGZAjMWqyXAjbo6wYTSzEZPy0Xkwu9n/epWl4xSap0WoaIIZfofye2SW?=
 =?iso-8859-1?Q?xYvkuJZ1gRjmNFFZWBRWbYXuYwMfV3p7J9sauEBVnhgwaAGMMXN/M/gUhH?=
 =?iso-8859-1?Q?4t5b8dMvHw3YLXyHpp9nLuv8klgLOopSf6fmzHjnH/O+vgz87p6QCh6Z6r?=
 =?iso-8859-1?Q?C5vtDSjIWNjuEDgfjRoQAXaWCFn8rhoTG0w08eE+E3BTI8lVoWgLz6wmOK?=
 =?iso-8859-1?Q?uWCHOAf9KGvB0EA1cXeBAub9I+/2V7RYgo1WPTgxFoaKBnQIQAmc4E+yrZ?=
 =?iso-8859-1?Q?ZKxnOhLUegWOGIAymMmXTHITALSmOK93040GuFgD98CWDZfnQIlH0sYPI0?=
 =?iso-8859-1?Q?W0pfQ/UYb4z3mSPPGAOHceM1YKRpGtSZOzNhWnHiJhHu+yBau52QGZFYeQ?=
 =?iso-8859-1?Q?O85Uo9Rk9Nq6pGK6mDrtc8skiSV5QzpLhJVmJvkIPHjdOvVBjUJJvevnHn?=
 =?iso-8859-1?Q?B0CvXY+/KA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b8942c-720f-46bb-aadd-08de652e947f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:46.6949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znBP7oJ9O9YgVXP17ZUmpJUE+0UD1L4OjrA6wreKPJ/+ceJCrj8FR3dqyGr8zNokwV6o2VeDpHYUjFtsVJUsRWr5s+viKaLK0AZp7W7ykzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

Adds handling for different IBI events that the controller can receive.=0A=
This includes:=0A=
- Handling a hot-join from a target=0A=
- Handling a secondary controller on the bus requesting to be the=0A=
  primary bus controller=0A=
- Handling an interrupt request from a target.=0A=
=0A=
When receiving an IBI, the controller sets an interrupt to notify=0A=
software about what happened.=0A=
When the IBI is finished being serviced, the controller pushes the=0A=
result of the IBI and any data received from the target into the IBI=0A=
queue.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
---=0A=
 include/hw/i3c/dw-i3c.h |  27 ++++=0A=
 hw/i3c/dw-i3c.c         | 317 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events     |   2 +=0A=
 3 files changed, 346 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
index 4b592552b4..93a3ba784c 100644=0A=
--- a/include/hw/i3c/dw-i3c.h=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -141,6 +141,28 @@ typedef union DWI3CCmdQueueData {=0A=
     DWI3CAddrAssignCmd addr_assign_cmd;=0A=
 } DWI3CCmdQueueData;=0A=
 =0A=
+/*=0A=
+ * When we receive an IBI with data, we need to store it temporarily until=
=0A=
+ * the target is finished sending data. Then we can set the IBI queue stat=
us=0A=
+ * appropriately.=0A=
+ */=0A=
+typedef struct DWI3CIBIData {=0A=
+    /* Do we notify the user that an IBI was NACKed? */=0A=
+    bool notify_ibi_nack;=0A=
+    /* Intermediate storage of IBI_QUEUE_STATUS. */=0A=
+    uint32_t ibi_queue_status;=0A=
+    /* Temporary buffer to store IBI data from the target. */=0A=
+    Fifo8 ibi_intermediate_queue;=0A=
+    /* The address we should send a CCC_DISEC to. */=0A=
+    uint8_t disec_addr;=0A=
+    /* The byte we should send along with the CCC_DISEC. */=0A=
+    uint8_t disec_byte;=0A=
+    /* Should we send a direct DISEC CCC? (As opposed to global). */=0A=
+    bool send_direct_disec;=0A=
+    /* Was this IBI NACKed? */=0A=
+    bool ibi_nacked;=0A=
+} DWI3CIBIData;=0A=
+=0A=
 typedef struct DWI3C {=0A=
     /* <private> */=0A=
     SysBusDevice parent;=0A=
@@ -154,11 +176,16 @@ typedef struct DWI3C {=0A=
     Fifo32 resp_queue;=0A=
     Fifo32 tx_queue;=0A=
     Fifo32 rx_queue;=0A=
+    Fifo32 ibi_queue;=0A=
+=0A=
+    /* Temporary storage for IBI data. */=0A=
+    DWI3CIBIData ibi_data;=0A=
 =0A=
     struct {=0A=
         uint8_t id;=0A=
         uint8_t cmd_resp_queue_capacity_bytes;=0A=
         uint16_t tx_rx_queue_capacity_bytes;=0A=
+        uint8_t ibi_queue_capacity_bytes;=0A=
         uint8_t num_addressable_devices;=0A=
         uint16_t dev_addr_table_pointer;=0A=
         uint16_t dev_addr_table_depth;=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index dd10230da8..9a0460cf31 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,6 +19,14 @@=0A=
 #include "trace.h"=0A=
 #include "hw/core/irq.h"=0A=
 =0A=
+/*=0A=
+ * Disable event command values. sent along with a DISEC CCC to disable ce=
rtain=0A=
+ * events on targets.=0A=
+ */=0A=
+#define DISEC_HJ 0x08=0A=
+#define DISEC_CR 0x02=0A=
+#define DISEC_INT 0x01=0A=
+=0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
     FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
@@ -356,6 +364,23 @@ static inline bool dw_i3c_can_transmit(DWI3C *s)=0A=
            !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);=0A=
 }=0A=
 =0A=
+static inline uint8_t dw_i3c_ibi_slice_size(DWI3C *s)=0A=
+{=0A=
+    uint8_t ibi_slice_size =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                              IBI_DATA_THLD);=0A=
+    /* The minimum supported slice size is 4 bytes. */=0A=
+    if (ibi_slice_size =3D=3D 0) {=0A=
+        ibi_slice_size =3D 1;=0A=
+    }=0A=
+    ibi_slice_size *=3D sizeof(uint32_t);=0A=
+    /* maximum supported size is 63 bytes. */=0A=
+    if (ibi_slice_size >=3D 64) {=0A=
+        ibi_slice_size =3D 63;=0A=
+    }=0A=
+=0A=
+    return ibi_slice_size;=0A=
+}=0A=
+=0A=
 static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)=0A=
 {=0A=
     return regval =3D regval ? (2 << regval) : 1;=0A=
@@ -509,6 +534,266 @@ static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t =
offset)=0A=
                       DEV_DYNAMIC_ADDR);=0A=
 }=0A=
 =0A=
+static int dw_i3c_addr_table_index_from_addr(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    uint8_t table_size =3D ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POI=
NTER,=0A=
+                                          DEPTH);=0A=
+    for (uint8_t i =3D 0; i < table_size; i++) {=0A=
+        if (dw_i3c_target_addr(s, i) =3D=3D addr) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static void dw_i3c_send_disec(DWI3C *s)=0A=
+{=0A=
+    uint8_t ccc =3D I3C_CCC_DISEC;=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        ccc =3D I3C_CCCD_DISEC;=0A=
+    }=0A=
+=0A=
+    dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                 /*is_i2c=3D*/false);=0A=
+    dw_i3c_send_byte(s, ccc, /*is_i2c=3D*/false);=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_start(s, s->ibi_data.disec_addr,=0A=
+                                     /*is_recv=3D*/false, /*is_i2c=3D*/fal=
se);=0A=
+    }=0A=
+    dw_i3c_send_byte(s, s->ibi_data.disec_byte, /*is_i2c=3D*/false);=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_hj(DWI3C *s)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN=
)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    bool nack_and_disable =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                             HOT_JOIN_ACK_NACK_CTRL);=0A=
+    if (nack_and_disable) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_byte =3D DISEC_HJ;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_ctlr_req(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_R=
EQ)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, MR_REJEC=
T)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable controller role requests. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_CR;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_targ_irq(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IR=
Q)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, SIR_REJE=
CT)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable interrupts. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_INT;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_handle(I3CBus *bus, uint8_t addr, bool is_recv)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->qbus.parent);=0A=
+=0A=
+    trace_dw_i3c_ibi_handle(s->cfg.id, addr, is_recv);=0A=
+    s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_stat=
us,=0A=
+                                              IBI_QUEUE_STATUS, IBI_ID,=0A=
+                                              (addr << 1) | is_recv);=0A=
+    /* Is this a hot join request? */=0A=
+    if (addr =3D=3D I3C_HJ_ADDR) {=0A=
+        return dw_i3c_handle_hj(s);=0A=
+    }=0A=
+    /* Is secondary controller requesting access? */=0A=
+    if (!is_recv) {=0A=
+        return dw_i3c_handle_ctlr_req(s, addr);=0A=
+    }=0A=
+    /* Is this a target IRQ? */=0A=
+    if (is_recv) {=0A=
+        return dw_i3c_handle_targ_irq(s, addr);=0A=
+    }=0A=
+=0A=
+    /* At this point the IBI should have been ACKed or NACKed. */=0A=
+    g_assert_not_reached();=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_recv(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->qbus.parent);=0A=
+    if (fifo8_is_full(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    fifo8_push(&s->ibi_data.ibi_intermediate_queue, data);=0A=
+    trace_dw_i3c_ibi_recv(s->cfg.id, data);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_push(DWI3C *s)=0A=
+{=0A=
+    /* Stored value is in 32-bit chunks, convert it to byte chunks. */=0A=
+    uint8_t ibi_slice_size =3D dw_i3c_ibi_slice_size(s);=0A=
+    uint8_t num_slices =3D (fifo8_num_used(&s->ibi_data.ibi_intermediate_q=
ueue) /=0A=
+                         ibi_slice_size) +=0A=
+                         ((fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue) %=0A=
+                         ibi_slice_size) ? 1 : 0);=0A=
+    uint8_t ibi_status_count =3D num_slices;=0A=
+    union {=0A=
+        uint8_t b[sizeof(uint32_t)];=0A=
+        uint32_t val32;=0A=
+    } ibi_data =3D {=0A=
+        .val32 =3D 0=0A=
+    };=0A=
+=0A=
+    /* The report was suppressed, do nothing. */=0A=
+    if (s->ibi_data.ibi_nacked && !s->ibi_data.notify_ibi_nack) {=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_IDLE);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* If we don't have any slices to push, just push the status. */=0A=
+    if (num_slices =3D=3D 0) {=0A=
+        s->ibi_data.ibi_queue_status =3D=0A=
+             FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=0A=
+                        LAST_STATUS, 1);=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        ibi_status_count =3D 1;=0A=
+    }=0A=
+=0A=
+    for (uint8_t i =3D 0; i < num_slices; i++) {=0A=
+        /* If this is the last slice, set LAST_STATUS. */=0A=
+        if (fifo8_num_used(&s->ibi_data.ibi_intermediate_queue) <=0A=
+            ibi_slice_size) {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN,=0A=
+                           fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue));=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           LAST_STATUS, 1);=0A=
+        } else {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN, ibi_slice_size);=0A=
+        }=0A=
+=0A=
+        /* Push the IBI status header. */=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        /* Move each IBI byte into a 32-bit word and push it into the queu=
e. */=0A=
+        for (uint8_t j =3D 0; j < ibi_slice_size; ++j) {=0A=
+            if (fifo8_is_empty(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+                break;=0A=
+            }=0A=
+=0A=
+            ibi_data.b[j & 3] =3D fifo8_pop(&s->ibi_data.ibi_intermediate_=
queue);=0A=
+            /* We have 32-bits, push it to the IBI FIFO. */=0A=
+            if ((j & 0x03) =3D=3D 0x03) {=0A=
+                fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+                ibi_data.val32 =3D 0;=0A=
+            }=0A=
+        }=0A=
+        /* If the data isn't 32-bit aligned, push the leftover bytes. */=
=0A=
+        if (ibi_slice_size & 0x03) {=0A=
+            fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+        }=0A=
+=0A=
+        /* Clear out the data length for the next iteration. */=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                         IBI_QUEUE_STATUS, IBI_DATA_LEN, 0=
);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,=0A=
+                     ibi_status_count);=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    /* State update. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_finish(I3CBus *bus)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->qbus.parent);=0A=
+    bool nack_and_disable_hj =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                                HOT_JOIN_ACK_NACK_CTRL);=
=0A=
+    if (nack_and_disable_hj || s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_disec(s);=0A=
+    }=0A=
+    dw_i3c_ibi_queue_push(s);=0A=
+=0A=
+    /* Clear out the intermediate values. */=0A=
+    s->ibi_data.ibi_queue_status =3D 0;=0A=
+    s->ibi_data.disec_addr =3D 0;=0A=
+    s->ibi_data.disec_byte =3D 0;=0A=
+    s->ibi_data.send_direct_disec =3D false;=0A=
+    s->ibi_data.notify_ibi_nack =3D false;=0A=
+    s->ibi_data.ibi_nacked =3D false;=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
 {=0A=
     /* Only return the status whose corresponding EN bits are set. */=0A=
@@ -569,6 +854,25 @@ static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
     return val;=0A=
 }=0A=
 =0A=
+static uint32_t dw_i3c_ibi_queue_r(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->ibi_queue)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->ibi_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    return val;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->resp_queue)) {=0A=
@@ -606,6 +910,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+        value =3D dw_i3c_ibi_queue_r(s);=0A=
+        break;=0A=
     case R_INTR_STATUS:=0A=
         value =3D dw_i3c_intr_status_r(s);=0A=
         break;=0A=
@@ -1345,8 +1652,16 @@ static void dw_i3c_realize(DeviceState *dev, Error *=
*errp)=0A=
     fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);=
=0A=
     fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
     fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);=0A=
+    /* Arbitrarily large enough to not be an issue. */=0A=
+    fifo8_create(&s->ibi_data.ibi_intermediate_queue,=0A=
+                 s->cfg.ibi_queue_capacity_bytes * 8);=0A=
 =0A=
     s->bus =3D i3c_init_bus(DEVICE(s), name);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(s->bus);=0A=
+    bc->ibi_handle =3D dw_i3c_ibi_handle;=0A=
+    bc->ibi_recv =3D dw_i3c_ibi_recv;=0A=
+    bc->ibi_finish =3D dw_i3c_ibi_finish;=0A=
 }=0A=
 =0A=
 static const Property dw_i3c_properties[] =3D {=0A=
@@ -1355,6 +1670,8 @@ static const Property dw_i3c_properties[] =3D {=0A=
                       cfg.cmd_resp_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,=0A=
                       cfg.tx_rx_queue_capacity_bytes, 0x40),=0A=
+    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.ibi_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,=0A=
                       cfg.num_addressable_devices, 8),=0A=
     DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 044ff06a01..a262fcce39 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -9,6 +9,8 @@ dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t da=
ta) "I3C Dev[%u] read=0A=
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PR=
Id32 " bytes to bus"=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
+dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
+dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

