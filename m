Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADA8C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK1C-0001Uh-8t; Mon, 10 Aug 2026 03:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK18-0001Qf-BC; Mon, 10 Aug 2026 03:01:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK16-0007uV-Ck; Mon, 10 Aug 2026 03:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4ZZI0z1uHiqOM8HM78a9AV6qMs9h5oT/2K3+hjJv7C7b7IoWeRGrSn3eFiUm5/qSQGljj5oVpRSNHq+GjlU3aBA/3MenEyRDCMjF2QzWv6pOT4bFsnB/6MBPJSjVc7shiMwdE3HwA9n9ein5iBDfe5yqLwmk82Q5NvlUW7NS24Wl5rpzcx7XSi3Bv4pyFqDaTMDtGJa5Jd3QM+kZ27VvdrWyh6wvl7jG/Eol9bzgQagz+3fiD9AptIi4mzomLCe4VeKcjiNmWW9l4EndxJ58mY4zYUvCSNP6mcRPFvnoNrLY7rpe9Y8sRxSRXdCB3uiL/K/t4ay36rdYM7R08xJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPu0+jrPr5H31cvsprSAy8DvhtmFfoHgF1wGuBDllxw=;
 b=LO3b1Zlp9kMxUIkQNf9/rGEY0tFKrK24AP78BMoXp9SnWCoxnpXAXhBmopl8tu5F72NH/lFZGS13Yjc5UvIgshOXC33j+whkVMfUM5IlncOCdQu8oieNp8BIufqB1VpC4EBmYaRJeiz65alWnOTpG3ZHzUTtecMPwZ6Qe2Cr3VFfHnASPCbrQnERqLVlCUTDDbJOGz5bnQclHhSd6OodkYniX0MGhK2qS+cAaXSHIlVrklNt1Ay+e+gF53SgRcSlDTwtku+X1RHV6OEHVGEI1TNqFNE2Wcmtt+PIaQkG6/xOfsxNmQl3FSiDDff4fC+B1H91uA1aPaY04Wp2lyUxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPu0+jrPr5H31cvsprSAy8DvhtmFfoHgF1wGuBDllxw=;
 b=iwhT5k6/mIaUX9ki3nBpmo/ni1ns5DYy0RWrUuqyeU+hxKhiLqUZcYPCdD6ByWn62UO0Y9/2V8e+ZCvWuxC3nbpayUTm8Sj1geYakxWnNlvpbQPJ7peuv6rYIhJdBh/crnVgyXHt+cPmu1ngsIfp+Y1Q4h9UU0qM9IVJrJm0f2FEeddg63+I17TcHkgn+qFgfaS3RW+UugcLEVtRj2xRsPz9bZe271GA9CWEKFVdkGg8+sNBEGxUhMiNTf1aZvW/aBH9rOUAToa0SdLl6g+8hBbCXQZVMMYXldEntumglhz7xcCP8WN3BwZzVprC5JMQT/RZzGiV9OKBG42XRAVVJg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KUYPR06MB9111.apcprd06.prod.outlook.com (2603:1096:d10:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:01:44 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:01:44 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 04/17] hw/misc/aspeed_hace: Support the CTR mode for
 the crypto command
Thread-Topic: [PATCH v2 04/17] hw/misc/aspeed_hace: Support the CTR mode for
 the crypto command
Thread-Index: AQHdFAquJe/skb2bBEifXsC6VsQpVbaXBAJA
Date: Mon, 10 Aug 2026 07:01:44 +0000
Message-ID: <SI6PR06MB763107A6DB1D80EB841EE731F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-5-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-5-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KUYPR06MB9111:EE_
x-ms-office365-filtering-correlation-id: a17f6467-fa9e-4b69-d000-08def6ad3cc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|10067099003|38070700021|3023799007|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: 4J92gzNBVMNjHGbwbJokYxxtBUDtkqOj6jhMUFEaUiS7YmNH+wQTMchY7yqjPL5CwtRAMZiL8HM2dTgF9pPIJy7VqtHF7XvIbvKg4wEGQYCwsIZO+3w3Vqs/uUGDxmD+pi3c8FUfk+Hxv/V/dm462CEs1mVsnfqi+hZWc7FB59tlHQ6OmnaeB5QARRyGHzuyS6CeRyyo1OHQttBy+9sOamJpxw6M8G9SMHkTN+eyL3IO9cO0t2GgXXL9ReCA0h8s1aNH/ljqWKqyyFF2iPWPVh7FCclKtSScz5ytOaTrvMLPwKP+iFdFTRcwANYBquf9EOi45Lsa3OByLv0QzzX0T548PE/DHWbo8RkjSwDgKVPg9KxEEvy8VC30VBUFuGkN8p8G7SmXss8WqfcAxP65iFtsI7Ao+L8l2rWBpWJnQtPwYvdfaSRLc1gQ4/1KnJBBfWMYh0gfAXjFS2JEKmykZsmaDM45lWtOrVQdVt6Houw9F/cTtFTPPdH8+Duqj0Iq0JgodgeILYC/jSt+GErdbuwTDuiICUCOOULWsmXNW3k2boklOBnEqn0i3jjxixhx8REaSN+yyR5nIZ1JYFtXLD8OHdu7vyn7SyAYB6EjCuwisI/FSnqTZNrEGNzpHgFnof5NxcH//tR4ZvW8Pb0GNaWkoGuRKCnrCFDfx5mX6hLsNHt0NfgyLvKgmTFkraG6t5HEPtE6YncRkCmiBru82mhUb8pCfYEuuM4pUEnzmATA5aphwTBdVlDhSEyk6jif
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(10067099003)(38070700021)(3023799007)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?33V2fVT6NdpEtWHjFouBN2GJ+PCeONAO/BVM0UWPvfpkHQzdm8NI77Aydr?=
 =?iso-8859-1?Q?hWgWpu7Aa8+rpZH4kdqBZZeoZjYRaHhreajmK4vs8/ScgC8nTk5oYyR5lp?=
 =?iso-8859-1?Q?TyZSiMVY1DUBDZJCQ/uMSER8DRMxwpOy6y2qFmedWuv9fpSoam6KKpaELq?=
 =?iso-8859-1?Q?XWsFP2V1mKZCKd+jmYN7dzPra0zw3DI+Ahc6LS1VFKm00qcKd5/DQRCPLg?=
 =?iso-8859-1?Q?yySA1wCu5HbZiSs+M3nJG7T9Z42Fh3nCwoPZI/YQUqGLVz364+9m9VhVIO?=
 =?iso-8859-1?Q?WFDa8dsB3nwNlaF/fApnlaL2IYLWo54yDzuvlwN0sdw1J9IgowBztt8GP4?=
 =?iso-8859-1?Q?Cgr13LretR1CibIijASl//gwdZ2huYuNi/ASfAKyG2ST/T9ku53CdhCYzm?=
 =?iso-8859-1?Q?lyMj/4qU1HEOOraNTOP3MlM27N6Ql9KWYTor/WSome9hIch6i0FtewodVY?=
 =?iso-8859-1?Q?kV8AF4mijAdDcWkg0VdmiiGcOv1b4iiAcyXQIL2N/gPrXn2hjjYaQp8/8K?=
 =?iso-8859-1?Q?D/5wyMRDsTTbtYBAhIvTiIEktk4OMUCtnhS2kIovTokDdu+UQB+mqlcfGU?=
 =?iso-8859-1?Q?C8zOzSH0cgBXKJH1BL8BBJqghJMBmzlrbM1AOm00FjZVQlBTptmqARlXai?=
 =?iso-8859-1?Q?FkBPH2kA8cHd2z9vshVCuhbmIOGUapzi33hatv9UAugxD7ES/QnFhcFnSL?=
 =?iso-8859-1?Q?NV7pgIE5af35oYU+2mPpwJR6OolV6c1jJnO0PuWHLriWMgbiMzkTHDGSD8?=
 =?iso-8859-1?Q?WmxYNK/NPhOtae0QexzLII3FbuJOxF3njOmtIMnHkcgcvaMtd4A9fC51fm?=
 =?iso-8859-1?Q?U520Dk8zZpdBm4zOhYVgejmZ4dgugBtfQZOTIGgUnaVtSFb4d713+0CuKa?=
 =?iso-8859-1?Q?J+QsU0KO52lkJntrY+URid/b2kin87NhPvnmTiz74FVY7KevG14hVdTP7O?=
 =?iso-8859-1?Q?9iA17hUdDeapz4gFhhIDVlKCM80K2oVLwj4bNFela6b6XjMu3uDwZk7IU9?=
 =?iso-8859-1?Q?Nbt6SBsO3YYIkHrHxBO9tsYpOh8wyadNNqZSzw4x+waFTRoyWkWot8wXR2?=
 =?iso-8859-1?Q?n/PdpkKDxDgOWiEExg+b4dsaWW8vjZcP4yQneqaUc03NX4jn+BjBADNd/q?=
 =?iso-8859-1?Q?R1jmv1Umuj0MHDW46zwdp7qS9sr4FBIwc2bPbl3TuyMhvaCtb4R3p0rR5g?=
 =?iso-8859-1?Q?YqvlQRwE76xwalsf/OfuZf3QBhyWm2yewCMXcvNec5Is9/ueVPn3UM/AHG?=
 =?iso-8859-1?Q?xBeGQRfrYlJKI16m/bLQUrRC8nZB6Kr0A7On+xnMinxpvrCgbNxChf2jPH?=
 =?iso-8859-1?Q?OiXhyKa6dIkpfpbYkrpjyEx8zIOyWjIMgJFmyZZCttgI0ZYdMMunanMdL4?=
 =?iso-8859-1?Q?GEj4170//0BuBwTHjiGWTUl4RsSSYqEGLxBSkhTr9JV4OAMnCu+317YhtL?=
 =?iso-8859-1?Q?Nasnko21/qBwuHGyBmxqmtvxOHlK1nHoW6AN8QYNKpCqmsvHZ7LTP/fqQG?=
 =?iso-8859-1?Q?lT2rVzDPU1HjZQTM5F+llcYGVAO7Zng+zvUqfYbgZ9KH4VuWrGKsD84l46?=
 =?iso-8859-1?Q?6/C+ec/l/udHCIYzvy7z+wi8mOKnzS5NaHTbWa0wCiKuIYyBoQTumvNjbD?=
 =?iso-8859-1?Q?dnVeANr8KIW+A7ap0fhn7B4WhANJiaf85T66tm8sHbugJ2GfADhI/VdOjL?=
 =?iso-8859-1?Q?c+vROwEdsCPlkeCbRk1S63acNDGdg5jCVugZ7vF6ke8Z1pMr44h8LAGtNc?=
 =?iso-8859-1?Q?vf+OJ2VsOO/0aPlt5yn6Bf6aOR82wJBCIwYEqnl8uzaGP8V3zuW844XT1m?=
 =?iso-8859-1?Q?qqYwuUFgSQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XwO088zU0YOa/kCgzAOZcELsOokRicxIvaElcs9pXw/+Dg1fU0vo+CF84bh9lUXen2S1sM57JFmnmfZcbaXV7fbgGBpG/NswoKp6cj+XFxveYta9MujpWtNXnDNdNJluJwhchvQK3mw7Kg3JtkGkb8RfnbXhgqzi3AkJhz4feLFZBBnCVqwdTewgNNP4APJkUqYjNaPjCe2bqjSH65EXMuSxDVd6KV0Qie4Nk1J2tqtF+UJY2VnObGb+SS7bDxGoPtJOXtsARw48KjP7J8i69Qyy5EYfZgDzNa3SQAu95ZkEJnWII3ap1LNmW6h6NP9Qe0ukaeMkEds5t3k6HyfZlg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17f6467-fa9e-4b69-d000-08def6ad3cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:01:44.2409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Phfw3Ax/7LewRtFHCYrvE3no3r8X5UVTaCba2ccpNWdA2vaFfUMHiHMEVtIwuR5doKPKnhN5cFQaSFL+vGL24dSb1zYTzDNtpTMI5nzAb3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9111
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
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

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Wednesday, July 15, 2026 11:33 AM
> To: Daniel P. Berrang=E9 <berrange@redhat.com>; C=E9dric Le Goater
> <clg@kaod.org>; Peter Maydell <peter.maydell@linaro.org>; Steven Lee
> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Kane Chen
> <kane_chen@aspeedtech.com>; Andrew Jeffery
> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; Eric Blake
> <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>; Fabiano
> Rosas <farosas@suse.de>; Laurent Vivier <lvivier@redhat.com>; Paolo Bonzi=
ni
> <pbonzini@redhat.com>; open list:All patches CC here
> <qemu-devel@nongnu.org>; open list:ASPEED BMCs
> <qemu-arm@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> <troy_lee@aspeedtech.com>
> Subject: [PATCH v2 04/17] hw/misc/aspeed_hace: Support the CTR mode for
> the crypto command
>=20
> The AST2600, AST1030 and later crypto engines add AES/DES/3DES CTR mode
> (HACE10[6:4] =3D 0b100) on top of the ECB/CBC modes shared with the AST25=
00.
> Decode the CTR selection, round the working buffers up to a whole block s=
o the
> stream-like final block is still processed a block at a time, and write t=
he
> counter advanced by the number of blocks consumed back to the context
> buffer so the driver can continue across requests.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 50
> ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> 3d3f1fc8dd..09d0515271 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -42,6 +42,7 @@
>  #define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)
>  #define  CRYPT_CMD_ECB              (0x0 << 4)
>  #define  CRYPT_CMD_CBC              (0x1 << 4)
> +#define  CRYPT_CMD_CTR              (0x4 << 4)
>  /* AES key length HACE10[3:2] */
>  #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
>  #define  CRYPT_CMD_AES256           (0x2 << 2)
> @@ -589,6 +590,9 @@ static bool crypt_decode_cmd(uint32_t cmd,
> QCryptoCipherAlgo *alg,
>      case CRYPT_CMD_CBC:
>          *mode =3D QCRYPTO_CIPHER_MODE_CBC;
>          break;
> +    case CRYPT_CMD_CTR:
> +        *mode =3D QCRYPTO_CIPHER_MODE_CTR;
> +        break;
>      default:
>          return false;
>      }
> @@ -652,6 +656,22 @@ static bool crypt_prepare_sg(AspeedHACEState *s,
> uint64_t addr,
>      return copied =3D=3D len;
>  }
>=20
> +/*
> + * Add @add to the big-endian counter block @ctr (@len bytes) in place,
> +so the
> + * CTR mode counter can be advanced by the number of blocks just
> consumed.
> + */
> +static void crypt_be_add(uint8_t *ctr, size_t len, uint64_t add) {
> +    size_t i =3D len;
> +
> +    while (i > 0 && add) {
> +        i--;
> +        add +=3D ctr[i];
> +        ctr[i] =3D add & 0xff;
> +        add >>=3D 8;
> +    }
> +}
> +
>  /*
>   * Perform an AES/DES/3DES ECB/CBC operation. The source and destination
> are
>   * either single contiguous buffers (direct access mode) or scatter-gath=
er
> @@ -677,6 +697,7 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      uint64_t dst_addr;
>      size_t iv_offset;
>      size_t blocklen;
> +    size_t buf_len;
>      size_t keylen;
>      bool status;
>=20
> @@ -729,8 +750,14 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>          return;
>      }
>=20
> -    src_buf =3D g_malloc0(len);
> -    dst_buf =3D g_malloc0(len);
> +    /*
> +     * Round the working buffers up to a whole block. Block modes are
> already
> +     * block-aligned; the stream-like CTR mode may leave a partial final
> block
> +     * that the engine still processes a full block at a time.
> +     */
> +    buf_len =3D QEMU_ALIGN_UP(len, blocklen);
> +    src_buf =3D g_malloc0(buf_len);
> +    dst_buf =3D g_malloc0(buf_len);
>=20
>      /* Gather the source into the bounce buffer, per the selected mode. =
*/
>      src_addr =3D s->regs[R_CRYPT_SRC];
> @@ -751,7 +778,7 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      }
>=20
>      if (encrypt) {
> -        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,
> +        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, buf_len,
>                                     &local_err) < 0) {
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed:
> %s\n",
>                            __func__, error_get_pretty(local_err)); @@
> -759,7 +786,7 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>              return;
>          }
>      } else {
> -        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,
> +        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, buf_len,
>                                     &local_err) < 0) {
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed:
> %s\n",
>                            __func__, error_get_pretty(local_err)); @@
> -792,13 +819,26 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>           * output when encrypting, or of the input when decrypting. Writ=
e
> it
>           * back as the IV for the next request.
>           */
> -        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;
> +        next_iv =3D (encrypt ? dst_buf : src_buf) + buf_len - blocklen;
>          if (address_space_write(&s->dram_as, ctx_addr + iv_offset,
>                                  MEMTXATTRS_UNSPECIFIED, next_iv,
> blocklen)) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "%s: Failed to write IV, addr=3D0x%"
> HWADDR_PRIx "\n",
>                            __func__, ctx_addr + iv_offset);
>          }
> +    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {
> +        /*
> +         * CTR chains on the counter, which advances by one per block.
> Add the
> +         * number of blocks processed (buf_len / blocklen) and write it
> back.
> +         */
> +        crypt_be_add(ctx + iv_offset, blocklen, buf_len / blocklen);
> +        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,
> +                                MEMTXATTRS_UNSPECIFIED, ctx +
> iv_offset,
> +                                blocklen)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Failed to write IV, addr=3D0x%"
> HWADDR_PRIx "\n",
> +                          __func__, ctx_addr + iv_offset);
> +        }
>      }
>  }
>=20
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

