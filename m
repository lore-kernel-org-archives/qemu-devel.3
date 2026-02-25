Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE0DF55434
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OH-0003Vw-Tp; Tue, 24 Feb 2026 21:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OG-0003UR-HE; Tue, 24 Feb 2026 21:12:40 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OF-0000HF-4i; Tue, 24 Feb 2026 21:12:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etcKZHtx+41gHzfcgidEI0bWyahOLG2FEfMFhRQ1ffk5QOiMMReSOqAVW/Vw5yMFIhV3SdujYEZZ82VRmwhNTf4YcrR1m4XhF1tLQrklXZfFUs6dYqfy5W4IUf9vLzvc1m8XCFOyGP/KcSo0Yt/F4IwdIjDhtzKULPCyNa87VmJhbldM/RcjtOl1VYGraYdaSuD/YPApHGbA0OeTc7ewEkal2arbYrVwo+3wK27/btq++2vaDDEjkmcYS503HojZ6fHIDDwpH+6DlWo6JVYHVDTPa8FFDluzNjWv3FOdp3nlYqxj/u66RaKAJnGzgALmgMHMcLV44+hMMydFPimXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmVF+Hu280YwIRW2Y2PU2OYpm86SrAuPXXf0GR+tRTo=;
 b=mCFMhgJDE0leAbYLbeK1Ql1Vv4jFdu+5kRXtxZh5CnErFx6ojhRHPan5ef10hl2ICufU60v117DwyoFyfolxryV0AcYe8eZKj6T4ZSfiRMCr2XhJ3jZ+hY5EufQUs/xpRBY1eWih9c9xkB+Rb4s9JK4OdnQcsLs/HzwEdKnrHtpCJAoF8D2LGGa6N6p9mvV6FXHhwDs2LGWY89S2e3RvnMjGW48dgB8LCgHqGWXSNVC2yUg5nTDYsqCK2q3Pg+eZBYTRGk2Soo+Q7SETCIFPZL13rNRk5vO3pmb6jl2PZfMh+UlfFc+A+FRFs0fl6ovW7mSsjrUk4eGqbAZ4+iEveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmVF+Hu280YwIRW2Y2PU2OYpm86SrAuPXXf0GR+tRTo=;
 b=Rld3NCJ+EWn5hnFrQvRJDFagM0IJoWoUWtidMKxxttjkL2GQX5EO1qexMJOBv/1GFgfeNWDtiIrW/+Up3/eNdbrMg9RrqpHeFtLezu+AcuZ1myDirfiXmpT72etnRdxGpiTHb9HklaFvSNosleANlzNy8+ByFW07ajtcrCc1gVnvgZ8kZywgF1AK6aIEq2fbvp6/9iQt0gO9AxF67jDFtrGNIBx4EfGvPoLYWWEVAlYI1jd9wdgHws8rh6oBux6OXJ6+I3HCjYFmwQOlKBhsoZp5DakOkzXmW0Eyu4w1ErmyndoQ9HEELstZDZbKUyemCxw8joqMqtDdZMsWLM9HGA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6012.apcprd06.prod.outlook.com (2603:1096:101:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:27 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Titus
 Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v7 15/22] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Topic: [PATCH v7 15/22] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Index: AQHcpfww/bDNaBLSE0Gs+eIa70S5sQ==
Date: Wed, 25 Feb 2026 02:12:27 +0000
Message-ID: <20260225021158.1586584-16-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6012:EE_
x-ms-office365-filtering-correlation-id: 70e1df69-d7c5-48da-8331-08de74135301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Y6h6HBCEDJ3KhkKC4istiwheL0fTkz+wQQBTdvZaO46hez8jZnL2hYv1yL?=
 =?iso-8859-1?Q?aX90dc524PYBLPWig+arxabBT3F+xwvDxt2WvjUc273sNigdXQVRvcUzO2?=
 =?iso-8859-1?Q?x//Tl+lRiwU2ZfNv5lChysGp8v8TL6KA5Rdyw3S5VYt08E0k1PWOiGVQjL?=
 =?iso-8859-1?Q?WzWK1eCRusg0nxRC5XN91L26+b37GbL63u3Spvm7u5+DIuT2wBp0du5DMZ?=
 =?iso-8859-1?Q?IasNkJS+eRkoRzDKqRN7v+gOGD8F019hGrgjQxzZnUOA1DIPhwrpwcnSnP?=
 =?iso-8859-1?Q?+KNBrWaXYpHdGea4RlzCR9/OmzEUPKmjAPh5Zbr9EvB7gUbs1hAhIpv37n?=
 =?iso-8859-1?Q?+6lA3QuEJea1FHHc5cNYeigCsN3hZl6uZIwkBaWSF8RWWz3EQzX96srBnL?=
 =?iso-8859-1?Q?LBWBL5ToBloKtxZBaYKtWh4rNc+bZCOC2kJK3QVmrLSQPJCXFjqzdw/si4?=
 =?iso-8859-1?Q?fufqAYcoXgxeyyw1iMXqJycBmCdcMN6bulW/tQ7tp8YX/Jdjl7mxbENBGw?=
 =?iso-8859-1?Q?6HqYGWwmpe0ZqOitDun0nsDPTuTkF/7dfjM2zD4JzgnW8lExKEZ9eeZn+r?=
 =?iso-8859-1?Q?duIwr1uZNJEW0LCOL8dXHIzjXOM/klJO8bzTRp0ftR5mxeJEDLJddT1O8x?=
 =?iso-8859-1?Q?o2nDIsVXhugUVKCoZIEJH9uqPB10tc528yS/G1C+CtLlbf5LsZqS0ZnrL/?=
 =?iso-8859-1?Q?M60WoHIWwFOvLR+wvxjGzGMwZTw0ME/mvVtIBYkgHFlLX/AN3OkuFYCFaW?=
 =?iso-8859-1?Q?DZv0s/QN2yS0evlw33+gEIr/yxgt7e7f2pjS0LheQLYJRpau3jaztlsK6L?=
 =?iso-8859-1?Q?ZrIlyvPPksqdru2A/vT/7dVFT5ZB5sHmqkg3+5hJ7rUkzP1ZsRFUScGZAc?=
 =?iso-8859-1?Q?uSwAIIghKQTZoSWGRrAKzdeT2QT1cxcrqxltZCCVb9DhLQqT16ZLMLEZdd?=
 =?iso-8859-1?Q?mRdDQzU3RQNhA1jBGi0WBzPFcZ4w0MaW9wTW4TAWqPXX1QZFYL55JXe8HH?=
 =?iso-8859-1?Q?lbj4giY9ZS5u0dbwS33GsDV2XgJPQNmKtSQrQp8xEP9Q8KNxk7ztIMdo+I?=
 =?iso-8859-1?Q?woOWg9J+MmP3ypSDqY33VEzBR1ZjOFiKnmGHv+61d3Z7kI3VE1aJ9sOwM/?=
 =?iso-8859-1?Q?rjuY+Wlzv4dRAnSXot5KS4fgPn+DX6J5Vvyn0ceIvh3xHU4pTylViRBHae?=
 =?iso-8859-1?Q?Rhky7/DxUjDqzZzAHs7RXCYPK3tRUDiFfDb3lmfKsrhSmrpSK9pt8QJFjf?=
 =?iso-8859-1?Q?qVCYnDq4LbVHosmXIxHqzyQLNSFCfNmUgSo9Byjvf0svS+qnMwTatY4OHL?=
 =?iso-8859-1?Q?Dpf1bOKwR9wHXOIY6V8vawSQ4Xo7ou+0QYb03oF4n3rVHnMdJnrALbQcvV?=
 =?iso-8859-1?Q?M2k50oLx6fhJ3ZZgS4wxFZwlYzuyI47G8H1FaFyuWb1IFbFoR7W4IWB6g/?=
 =?iso-8859-1?Q?ZOnmgxa8FD4KR1mvw8L8ASL0CKOdYqQS8Z/KkW5sBUa/7vtejLlar1repv?=
 =?iso-8859-1?Q?BRtzjqp7GjBvPMp2c9WcUPOfgsxN6qUQ0ODspyoxpDo1mioaGGyl46nHMx?=
 =?iso-8859-1?Q?bFcll91dSz7Fi3IF+A6b7khSZUybIZ0PbUGdO42ATmrhKK28G4QpNtB/qr?=
 =?iso-8859-1?Q?z4tMZ+sgh5cjFgCTisXRWJcovGOPmgiIekQDiOCza2yg8yGVXLJdiOfPd1?=
 =?iso-8859-1?Q?1NJKVv+7LVYx9V2NAzwhCYLlU1IqMzjMjCFY0dCc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WW1vhzi66XDpAuNjpI+8VkoiG5swtv6wSCbR0gWtoceBK8fIigwvGye17v?=
 =?iso-8859-1?Q?OtLjd9s+9sbji6ABse3HYzusW2eRDRIGx1ASanwpDRSN1oDJYQt4FmALjI?=
 =?iso-8859-1?Q?Co2bJxJAZLCZH92enG64jjSaGGgkYFr4SuhxKMXiL//8P8Pj1SogykzuIi?=
 =?iso-8859-1?Q?XD5KknamNFE0Pz+bogABwpaN3IQ/fZvZlL6YY6Wgs+r4CHfpervrEL8bBg?=
 =?iso-8859-1?Q?ihcYPblqetZDAR+I+IrZ7TqZRlA8ybHYbqiirIFOauaqs7u09YDT4rTI5M?=
 =?iso-8859-1?Q?zHOip5FVAHZ3a/fFExc7WDgvmiF+AeUMsuzO8Qj3pG9Z/Dfoy4skOhn8q0?=
 =?iso-8859-1?Q?7jyTWSPTlIEYfM/PZS62hxXmbz4sYbF8m/sCukGiI1k0J74jK2TVzuX/6T?=
 =?iso-8859-1?Q?U78yIIFZ1yaxfsx/WIt6bdf22AUcEBybkcXU0X0q2SpztMLQuwrEUnjLn2?=
 =?iso-8859-1?Q?AqkW8VyWCTI05a8hFazwXs8KFdL8qyqjV6+TankbE8+X5+9tmC2f6R5eAO?=
 =?iso-8859-1?Q?P2p57u+ciTvyJBtY5/5+WjasXxcEa62gu2bZXEn0cOqB9cqHKNcELffoiN?=
 =?iso-8859-1?Q?dBIaS3MbXysYOWZ2v2jsUTjebEuQtQ04BfACEH6WCRglGU9wKaQqb7y7li?=
 =?iso-8859-1?Q?dRpPuYq2dOe1a6O2zmE6GjQOTsKTU48N7kFjQQKux3rz4oi/ZNuf3Dhmse?=
 =?iso-8859-1?Q?X7J8Bojo2kL3565bzr2WX8xDtf0E1mX7N0iDpNGV2zQskJHq/aJn9OpXys?=
 =?iso-8859-1?Q?5yZao/VAHKIU+P+UYNp47H/RsbirpxezBIXfZqh0IgSNxMYnETe03XybFp?=
 =?iso-8859-1?Q?oUCshDx99tjI4hu/eaVLc76+L8Sqd3/zcRkg+oA7GILxtbO/AjPsfwdlFE?=
 =?iso-8859-1?Q?6ZUMPnHNNKIyRU0slH/7R+DDnnPRTJ7VvKMy543lvUAxKZOv/uB9senUkr?=
 =?iso-8859-1?Q?QxUtQGb//V7KTHnYI/hroNi+z7AYmTPg1pDcU6Y7u6c+4W5MEBptndSDyw?=
 =?iso-8859-1?Q?TwOQdrFxlf0iyuKcrN+snYuRZwRgmHwizEjiejVH+BatLTV/yL2ms5sjsS?=
 =?iso-8859-1?Q?scL9TlC7rFmQrM1NB2Mz74ZfkXNBcRIFUeBDXmUqRMj8MFxROMNaHxizjY?=
 =?iso-8859-1?Q?qYG4M7AxZYm0XXBUdvY+7xeWwe9qx3dDX1HF8fKiL6RFeA5LYSU4eDTwqx?=
 =?iso-8859-1?Q?ITLnMnZWyWMZ5eyCWb9rYgzJoNmOYC698GQkZatOehTDKxEfc96vxUJcFk?=
 =?iso-8859-1?Q?S+52c9sZSKDzm39EFlvxfpRBgqN9BzeuNZ+Bwd7bSrxpTBxtfE9HakLo7h?=
 =?iso-8859-1?Q?g3hFDTqK7OI3V2IgAm1SDWwrmanhjLWh3P30Mtlrp37eDvvhjFI4AcKtkn?=
 =?iso-8859-1?Q?dePbX/MKVUKw3Ji0DlSLMuBLSfv99bDWg3gDsnDKbdH+nYq8c9ABU4czi7?=
 =?iso-8859-1?Q?xtC7OtF5lmVLssJvLyVVWQarqWbAF3UfNEbGQjHboQX6VygF4pOr+kvBAp?=
 =?iso-8859-1?Q?h4eHk2lNVc5BE5gHOVWv4Uuj07ilHzlNh3tz/HqSmUdHltigCMg6NThO7I?=
 =?iso-8859-1?Q?VnIjveUTbTvQtqlvnsAsyCiLRVv1TkP88KEMG/KCMMjHCKiN4JssAgjXZ8?=
 =?iso-8859-1?Q?BKSDnChLnML4rTb2A2g6QUib7/U8xx9241iDBwqy2DKxa33XFWI3qFXnq5?=
 =?iso-8859-1?Q?5Q91Ir6CcZuoiQVN+6NCQsbyxTZH/1FPfMcz9bXIcW/tFxY7ZXSVQKQRfT?=
 =?iso-8859-1?Q?3MaHvNgYGPHd3NqGFH+R0UwDLO2EojxFAsxAdPIEcu8dGrCY+/IvQ3+rPy?=
 =?iso-8859-1?Q?qwnG8Inpzw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e1df69-d7c5-48da-8331-08de74135301
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:27.7819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4irPsV3M/3GKblWLDhAboiCg6jkhJsNTVHt9M+45IRLWswPGip2dOC/0D5Oa0s77TTBxtV1EkPkogrP7wZSHbgh2wBfQUy9L8zdAA7A7f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6012
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Adds functionality to the CTRL register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 35 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 35 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 832fcf326a..b6ec0d9579 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -344,6 +344,8 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_cmd_queue_execute(DWI3C *s);=0A=
+=0A=
 static inline bool dw_i3c_has_hdr_ts(DWI3C *s)=0A=
 {=0A=
     return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);=0A=
@@ -503,6 +505,36 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uin=
t8_t *data,=0A=
     return ret;=0A=
 }=0A=
 =0A=
+static void dw_i3c_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /*=0A=
+     * If the user is setting I3C_RESUME, the controller was halted.=0A=
+     * Try and resume execution and leave the bit cleared.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_RESUME)) {=0A=
+        dw_i3c_cmd_queue_execute(s);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_RESUME, 0);=0A=
+    }=0A=
+    /*=0A=
+     * I3C_ABORT being set sends an I3C STOP. It's cleared when the STOP i=
s=0A=
+     * sent.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_ABORT)) {=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/true);=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/false);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_ABORT, 0);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ABORT, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    /* Update present state. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+=0A=
+    s->regs[R_DEVICE_CTRL] =3D val;=0A=
+}=0A=
+=0A=
 static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)=0A=
 {=0A=
     /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
@@ -1575,6 +1607,9 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
                       "] =3D 0x%08" PRIx64 "\n",=0A=
                       __func__, offset, value);=0A=
         break;=0A=
+    case R_DEVICE_CTRL:=0A=
+        dw_i3c_ctrl_w(s, val32);=0A=
+        break;=0A=
     case R_RX_TX_DATA_PORT:=0A=
         dw_i3c_push_tx(s, val32);=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

