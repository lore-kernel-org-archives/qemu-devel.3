Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E3FC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcvf-0000H6-F6; Mon, 10 Aug 2026 23:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtcva-00009R-S5; Mon, 10 Aug 2026 23:13:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtcvX-00050j-BZ; Mon, 10 Aug 2026 23:13:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPzuwjdwRbDiMk5h3kI3qftdC7mPKsgmlPc6p3g6yL91EHRhlwMmhV2u8Z02+pkS7mox8ghIAs3okV9NBzkJFohbC/g6GtLvDEBd+hSZh7wUGhmepEystHycBTnQtL7TyJ4BwJRRx7Wit+yoqKQTvFhY0cDcdB1o7AKwy6uhEfV63968ERy4dCl/20gwEs5hXcdDY975kbwW9o5ksveXNLmCx3tiGar4J4NsAXrSuJ1YHxBE8A/MrmpIXD+I/wan4CkHisTL+WN95LlNATp0922yzrLnMJFxPSyRsUo2wdiYpEKDmNTj90N6b/UUjOr/FmSaHPEms2XaRKG8MxIMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWBouilzExeZW/wGen1RXpvGyX0GS/PVDxro7aXTcRY=;
 b=ydm9bpa10/3Ldl9sdtm0FFqtE3hcAzmYanQzQPvv0Mo7Z2WNHKfcyLmY/XpW3+dQlgIKMBtXTKuR2A0wLtsY66nApHkiFebhNBolB2EB1+oIdNLJ5YimKpcUPREK8ARQgQyyVNQL5hNa7wmNoMTrhrHFo61St3hpIOw0getEADfEJ25eNmH+npUnjh1+ozdLeSyjTa69e3rI41HXmmc2Bp9XkXMiZGJHBNk+Xbv+XvjZHoqLyTyKUcHx1YF0ZOT0a5a+eNoHiDUSPL+xjohK3j3sSIq8idJ2o8M1PMtK0GaKO7nZmHdT21G9GKkGwKeOHuNUa1reD5WNk1VTlOtfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWBouilzExeZW/wGen1RXpvGyX0GS/PVDxro7aXTcRY=;
 b=WTARhfQyUiyJX9wlWx54/2HuHmgNdvz7c2lkG2U9MOxcRlc0OsrBaAeVfmNfQ6udNAvzK1l6YII9tIETwvi3nZAXxaGn/qFmzyHAiYl6zVslRRHh6VyJ4oIZt66FMAiH0eWMdpcs0Qreh7oHzEuAhDlAqOHefBUZwqVZ3geS9rRVvvKeNcToaIrbYVOcMW6pmHnD6kAIm96kOx+uSHA23mPItO8wdpuMZthbH2/lVdYTJd1D23Xsg6puwC3gxyiH2OlSdCzxepFBO4IHJ047b58ShxsnWzYaGuys7z2CAQ1ZRCsZ6fPrwI+NN2EpHZ5Rjb2fWz31OKZLSsDVuN0GTw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB7289.apcprd06.prod.outlook.com (2603:1096:101:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:13:12 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:13:11 +0000
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
Subject: RE: [PATCH v3 01/16] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Topic: [PATCH v3 01/16] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Index: AQHdKT72om7A0vSFM0qp8+iMjklT97aYLBnA
Date: Tue, 11 Aug 2026 03:13:11 +0000
Message-ID: <SI6PR06MB7631341337C609664E963D2CF7DD2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
 <20260811031025.2784489-2-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-2-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB7289:EE_
x-ms-office365-filtering-correlation-id: 9c72f68e-e4d3-42f2-7f17-08def75679da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|6133799003|4143699003|3023799007|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: jIolJ6TkBZLkqirH1ZpAObzPSbAV/48jUHCxoQvkDTY0QjLrI0h80DiZTAq7/t1UUMub0/JMHnIlDKNB4bCHCw5dxQdVOASiF0HAKSRPM7/G4UZxgWF8OgJe0TI4BEh9vdYJJPM6OyFZq3HtkrZ4ZmMowMIbMTUGiOEZesuS9L555+ooT00KHAA7EE9nyMUbCmmYHY40C5iMqgwSxQk40lGKm2G2S/a0cRwB1r+uB49xP8qAmsFeccohe6gEkSV8ugAMh1Fuq8URiRFQGGr4tWGzXNcKNy01NTMfv9R2Vxj1/y3YgQAWxb1+0Q4DTMfBVywT6zgdEsIIPZT/xV8U0BSSpxcYliZR/zgIYvgLsoQnMExmpd5RRCJeIqqh/e9GGqqAEJ+EgqymTNEPH17ERCuHv8tFi2Diu3hgyvTkpvzzxGpy9U5FCgKKm94VM06Q6I7PVORU85mkcrH70VZuhoh3q/m3/J8kdWjKzAIktdMrlmDRkG7kKmNedQaHcTesX3E+ERuKdHtGcwU7jQ/QFzTLEYB9eS3ZubJByG1Xpo21Og0vcyUtpj6X3yQchUQ0rBaf/oyjUajB0FeOBk7i+fgXdb67jpLp6rNnMBz4+n3x4AgcyQBplcMK6Hfi0TemQLx4Ia/fzz2vxxNxrYxWrrMWLcloGOtpItUsUncsnf9nBwkQpDpiJVuGn+EG9Om9U3mkAZkEbMNHfhZJDwDuWc8HmDxvzTsqeEcwPzkkPQ50yFVZLiq4sF0/EfduDEUg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(6133799003)(4143699003)(3023799007)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xFpy5J2nRANGOyb8SB/QUxKR9LsyatMJX4OmNWniss4uJjv72ohntkH5Mx?=
 =?iso-8859-1?Q?fFDvYw2apzbCUCzeLWZzltRaoHrb41/CB8YqUVI7t0WG1pimg3WWF9t1W4?=
 =?iso-8859-1?Q?AJUdcLgNAGCMa0+jm8D/2qhXy6iGAM3TOKXjHM2VZK0dRKxIATNBqAd/5C?=
 =?iso-8859-1?Q?/Djl4+iRwvkVVPbkWzodMjuLnbzmTupvz9yn/bzVLtgnjfNFHWaSXaA/wI?=
 =?iso-8859-1?Q?X+3mtrMoAOj1EJwaO90cLKKV7IkFDyQMJGW+q5elg6HP/jcVPaIWDYWOGw?=
 =?iso-8859-1?Q?HLgcmIGb7u6CAt9f7xSqEasJJegtkdUlwvE1KSzqgA1Wel1pAqSpwfhfCj?=
 =?iso-8859-1?Q?jHs7UztDALx30SdCgE1zBpg3rSP+rylgBEesu+ThI5I0XMQ4eNy/Zu8wd6?=
 =?iso-8859-1?Q?5yCsvyWNLQQAgIB9FZPV88UrO39+IXWMJMLIBEB10xvJbFCX4/KEcZNOU9?=
 =?iso-8859-1?Q?bDn84UW2zFnCnAcD577JcGbxfgw7hdHg9j6H2TtoGT9h7xQySaQG8+DihR?=
 =?iso-8859-1?Q?8ArNlFnXgzd+r3ktU0vLxgYXQj5hGKYT8By+d5qUK4JyKIdcq80xh3CRvN?=
 =?iso-8859-1?Q?2ikMM5mhMfZbZ/ULTN+Yamm4NAkiWfDAvHV2iVnikgXMPTS7oKYCn8GOEw?=
 =?iso-8859-1?Q?GL0JLtWomfbwALSBJchVRGJ+cIaswR9czP9GZbiKA5NPF6mGhzCpurrjQG?=
 =?iso-8859-1?Q?NwZJ787RIGEBjbor0FUwojC3btqCs97fIoT3rZ5xdF5UcZnwK7WImLMSVj?=
 =?iso-8859-1?Q?3PsBnRQ4jyPizPOS5q2hNvQcrhv7oYpXlfTNvYOdaGU0DWjSMX7BpOgVNI?=
 =?iso-8859-1?Q?szySJ0AtHnoaWgsOniRPt317zSFtBcVy0qIxl6llsau/iDSjswh5GogwQl?=
 =?iso-8859-1?Q?ES8gko9QBgkCbWLDTV3uBXWcFnlaw3f0E87gwUBCIVxaszW6DYSjw4p4fF?=
 =?iso-8859-1?Q?S24BJQmscW1wpUDCh+PGg1AxcTgbSpHb1UDf2/uDt6d0cXGw1zsfCHRrRI?=
 =?iso-8859-1?Q?bxyxjRPEBYS9US1dRtIaOOmpr/DCzxFUhrBhnuTYbK3CBYkgnV1EY/UElh?=
 =?iso-8859-1?Q?EM0gRK9bE2TkaWs0DroqCpyC/WjXfVmu1fd72nCXP0YX1JQg5GxWGchMTB?=
 =?iso-8859-1?Q?fOuebNpZWgfdrc0YJzoX9y1YfG+p7MPnBCQKqAgf5c4kbqKgyFgfodAdxR?=
 =?iso-8859-1?Q?0Lfv/PEQCKML/NoXXPCVyVR152Fzx9wIseXeWcLLddaWzi8iCvF5Y69D/l?=
 =?iso-8859-1?Q?dYdp+XkXg9nMM9uHP7qnOFAf5NXasi++KqzgP0YkoIBBFkar+iYR7B/JB9?=
 =?iso-8859-1?Q?WJhxf8xqs3HrvUq2fT84Krzp9im9HxSFZWZR1qlyspbtgL1xZae1xTZoRd?=
 =?iso-8859-1?Q?hCnEEXGKeeJ4TJDs1bJq8/gfR7vsn9s6/oyhd6ee6cQSC0j7Hd+tEJcwD7?=
 =?iso-8859-1?Q?3az663Nx+v+AGjBRrV3XWdBKYpNaxErIjkXB3R/llSQcTi6XZDRijH+sS0?=
 =?iso-8859-1?Q?7K2dbG10P4RrPnAtwWJPEnb3VXB4yEEaDlsJ1XkOLnjh18O0ii1J8jMQN0?=
 =?iso-8859-1?Q?nRckxmfNWA0sOwD2COgNBR0AL9UaFo7o/d8PWPOki8uJBkwrxrVhJ+mdHq?=
 =?iso-8859-1?Q?HmktpN5/uUuA+3D4TfBGg+iaJwW9tgkV53F5nLKEyAWxk0+uJg/QCfAd7Z?=
 =?iso-8859-1?Q?f4w5OwBTM5O1vpZR1bwR2ZSSZpGmpvRHVlozjgK1eCjmVFjOyyEznVxvwz?=
 =?iso-8859-1?Q?yAE8xy5gIMTXWyh7RN4b1C6otGLHWfv55aS7Aq49I/3xC2Ien0SLo1EBiD?=
 =?iso-8859-1?Q?lcsRvOtZMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: quE2c1KMZfkvzQvgYnhm/reviwjk7soHTczUaqRx516+SqH/C+iocDa235Z1Dr3cLWnc2ac7jRYQs7VXDesucGDAL2GxWm0oPAIcMrXSqBe1WTlYh3wW2gjU02QRK28QoTpKHvadKKLdAuF8z1VeJnaMzbBjG6xXvCUn9tBpd94xbqAhNJaLWpJfq9E5ZPzYujJFKKUodnEx1lQ1szP6wFA+8K08wtlP8SHzCtBbpNn5966X9a27zinFIm9GQKCGvhlb/L1AyotTlyx+qj+h9e7kNvdWNECWqZFODNJfZxgooFR84ZJvFoAx96kQWgP6Ik4rj1oBbdewaCASUqTpVA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c72f68e-e4d3-42f2-7f17-08def75679da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:13:11.6708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9iqb6Ot4wymai6M9vWJGULe2RobOLzrOt+nHXWHSUdyPDgVQkJg06DgRermfPwdEkaal2D2mhGIUeX5hG27NYyV3L5eriaAPBKy+RWizTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7289
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
> Sent: Tuesday, August 11, 2026 11:10 AM
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
> Subject: [PATCH v3 01/16] hw/misc/aspeed_hace: Support the crypto
> command in direct access mode
>=20
> The crypt command register was previously stubbed out. Implement it for t=
he
> direct access mode, where HACE00/HACE04 point directly at contiguous sour=
ce
> and destination buffers. AES-128/192/256, DES and 3DES are supported in E=
CB
> and CBC modes via the qcrypto cipher API; the IV and key are read from th=
e
> context buffer (HACE08) and, for CBC, the resulting chaining IV is writte=
n back
> to the context.
>=20
> The completion interrupt is now raised for every HACE variant as the hard=
ware
> does, which fixes the crypt command hang on the AST2500, AST2600 and
> AST1030. The AST2700 crypto engine still needs 64-bit DMA and AES-GCM,
> which are added later, so it keeps its temporary interrupt-only workaroun=
d
> until then.
>=20
> For debugging, the context, source and destination buffers are dumped thr=
ough
> the existing aspeed_hace_hexdump trace event (disabled by default). CTR
> mode, scatter-gather mode and AES-GCM are added separately.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 283
> +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 268 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> c61efe50c4..0f35d74137 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -18,11 +18,43 @@
>  #include "qapi/error.h"
>  #include "migration/vmstate.h"
>  #include "crypto/hash.h"
> +#include "crypto/cipher.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/irq.h"
>  #include "trace.h"
>=20
> -#define R_CRYPT_CMD     (0x10 / 4)
> +/* Crypto engine registers */
> +#define R_CRYPT_SRC         (0x00 / 4)
> +#define R_CRYPT_DEST        (0x04 / 4)
> +#define R_CRYPT_CONTEXT     (0x08 / 4)
> +#define R_CRYPT_DATA_LEN    (0x0c / 4)
> +/* HACE0C[27:0] holds the crypto data length */
> +#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF
> +#define R_CRYPT_CMD         (0x10 / 4)
> +/* Crypto engine command register (HACE10) bits */
> +#define  CRYPT_CMD_ENCRYPT          BIT(7)
> +#define  CRYPT_CMD_ISR_EN           BIT(12)
> +#define  CRYPT_CMD_DES_SELECT       BIT(16)
> +#define  CRYPT_CMD_TRIPLE_DES       BIT(17)
> +#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)
> +/* Operation mode HACE10[6:4] */
> +#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)
> +#define  CRYPT_CMD_ECB              (0x0 << 4)
> +#define  CRYPT_CMD_CBC              (0x1 << 4)
> +/* AES key length HACE10[3:2] */
> +#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
> +#define  CRYPT_CMD_AES256           (0x2 << 2)
> +#define  CRYPT_CMD_AES192           (0x1 << 2)
> +#define  CRYPT_CMD_AES128           (0x0 << 2)
> +
> +/*
> + * Crypto context buffer layout (HACE08). The IV is at the start of the
> +buffer
> + * (DES places its 8 byte IV at offset 8) and the cipher key at offset 0=
x10.
> + */
> +#define CRYPT_CTX_IV_OFFSET         0x00
> +#define CRYPT_CTX_DES_IV_OFFSET     0x08
> +#define CRYPT_CTX_KEY_OFFSET        0x10
> +#define CRYPT_CTX_SIZE              0x30
>=20
>  #define R_STATUS        (0x1c / 4)
>  #define HASH_IRQ        BIT(9)
> @@ -65,7 +97,6 @@
>  /* Other cmd bits */
>  #define  HASH_IRQ_EN                    BIT(9)
>  #define  HASH_SG_EN                     BIT(18)
> -#define  CRYPT_IRQ_EN                   BIT(12)
>  /* Scatter-gather data list */
>  #define SG_LIST_LEN_SIZE                4
>  #define SG_LIST_LEN_MASK                0x0FFFFFFF
> @@ -501,6 +532,216 @@ static void do_hash_operation(AspeedHACEState *s,
> int algo, bool sg_mode,
>      }
>  }
>=20
> +static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg, size_t
> +*keylen) {
> +    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {
> +    case CRYPT_CMD_AES128:
> +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_128;
> +        *keylen =3D 16;
> +        break;
> +    case CRYPT_CMD_AES192:
> +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_192;
> +        *keylen =3D 24;
> +        break;
> +    case CRYPT_CMD_AES256:
> +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_256;
> +        *keylen =3D 32;
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Decode the crypto command register into a libqcrypto algorithm/mode
> +pair
> + * and the block/IV geometry. Returns false for unsupported selections.
> + */
> +static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,
> +                             QCryptoCipherMode *mode, size_t
> *keylen,
> +                             size_t *blocklen, size_t *iv_offset) {
> +    if (cmd & CRYPT_CMD_DES_SELECT) {
> +        *blocklen =3D 8;
> +        *iv_offset =3D CRYPT_CTX_DES_IV_OFFSET;
> +        if (cmd & CRYPT_CMD_TRIPLE_DES) {
> +            *alg =3D QCRYPTO_CIPHER_ALGO_3DES;
> +            *keylen =3D 24;
> +        } else {
> +            *alg =3D QCRYPTO_CIPHER_ALGO_DES;
> +            *keylen =3D 8;
> +        }
> +    } else {
> +        *blocklen =3D 16;
> +        *iv_offset =3D CRYPT_CTX_IV_OFFSET;
> +        if (!crypt_aes_alg(cmd, alg, keylen)) {
> +            return false;
> +        }
> +    }
> +
> +    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {
> +    case CRYPT_CMD_ECB:
> +        *mode =3D QCRYPTO_CIPHER_MODE_ECB;
> +        break;
> +    case CRYPT_CMD_CBC:
> +        *mode =3D QCRYPTO_CIPHER_MODE_CBC;
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Direct access mode: the source/destination register (HACE00/HACE04)
> +points
> + * at a single contiguous buffer in DRAM. Copy @len bytes between it
> +and the
> + * bounce buffer @buf; when @to_dram is true @buf is written out,
> +otherwise it
> + * is read in. Returns true on success.
> + */
> +static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,
> +                                 uint8_t *buf, uint32_t len, bool
> +to_dram) {
> +    return !address_space_rw(&s->dram_as, addr,
> MEMTXATTRS_UNSPECIFIED,
> +                             buf, len, to_dram); }
> +
> +/*
> + * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the
> +source
> + * and destination are single contiguous buffers (HACE00/HACE04) and
> +the IV/key
> + * come from the context buffer (HACE08). For CBC the resulting
> +chaining IV is
> + * written back to the context buffer so the driver can continue the cha=
in.
> + */
> +static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd) {
> +    uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];
> +    bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;
> +    g_autoptr(QCryptoCipher) cipher =3D NULL;
> +    g_autofree uint8_t *src_buf =3D NULL;
> +    g_autofree uint8_t *dst_buf =3D NULL;
> +    uint8_t ctx[CRYPT_CTX_SIZE];
> +    Error *local_err =3D NULL;
> +    QCryptoCipherMode mode;
> +    QCryptoCipherAlgo alg;
> +    const uint8_t *next_iv;
> +    uint64_t ctx_addr;
> +    uint64_t src_addr;
> +    uint64_t dst_addr;
> +    size_t iv_offset;
> +    size_t blocklen;
> +    size_t keylen;
> +
> +    if (len =3D=3D 0) {
> +        return;
> +    }
> +
> +    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen,
> &iv_offset)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Unsupported crypt command 0x%x\n",
> __func__, cmd);
> +        return;
> +    }
> +
> +    if (!qcrypto_cipher_supports(alg, mode)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: cipher mode not supported by the crypto
> backend\n",
> +                      __func__);
> +        return;
> +    }
> +
> +    /* Fetch the IV and key from the context buffer in DRAM. */
> +    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];
> +    if (address_space_read(&s->dram_as, ctx_addr,
> MEMTXATTRS_UNSPECIFIED,
> +                           ctx, sizeof(ctx))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to read context, addr=3D0x%"
> HWADDR_PRIx "\n",
> +                      __func__, ctx_addr);
> +        return;
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> {
> +        hace_hexdump("context", (char *)ctx, sizeof(ctx));
> +    }
> +
> +    cipher =3D qcrypto_cipher_new(alg, mode, ctx + CRYPT_CTX_KEY_OFFSET,
> keylen,
> +                                &local_err);
> +    if (cipher =3D=3D NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new
> failed: %s\n",
> +                      __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +
> +    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&
> +        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,
> +                             &local_err) < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv
> failed: %s\n",
> +                      __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +
> +    src_buf =3D g_malloc0(len);
> +    dst_buf =3D g_malloc0(len);
> +
> +    src_addr =3D s->regs[R_CRYPT_SRC];
> +    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx
> "\n",
> +                      __func__, src_addr);
> +        return;
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> {
> +        hace_hexdump("src", (char *)src_buf, len);
> +    }
> +
> +    if (encrypt) {
> +        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,
> +                                   &local_err) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed:
> %s\n",
> +                          __func__, error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +    } else {
> +        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,
> +                                   &local_err) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed:
> %s\n",
> +                          __func__, error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +    }
> +
> +    dst_addr =3D s->regs[R_CRYPT_DEST];
> +    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx
> "\n",
> +                      __func__, dst_addr);
> +        return;
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> {
> +        hace_hexdump("dst", (char *)dst_buf, len);
> +    }
> +
> +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_CBC) {
> +        /*
> +         * CBC chains on the last ciphertext block: the final block of t=
he
> +         * output when encrypting, or of the input when decrypting. Writ=
e
> it
> +         * back as the IV for the next request.
> +         */
> +        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;
> +        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,
> +                                MEMTXATTRS_UNSPECIFIED, next_iv,
> blocklen)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Failed to write IV, addr=3D0x%"
> HWADDR_PRIx "\n",
> +                          __func__, ctx_addr + iv_offset);
> +        }
> +    }
> +}
> +
>  static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int
> size)  {
>      AspeedHACEState *s =3D ASPEED_HACE(opaque); @@ -531,16 +772,22
> @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data=
,
>                  qemu_irq_lower(s->irq);
>              }
>          }
> -        if (ahc->raise_crypt_interrupt_workaround) {
> -            if (data & CRYPT_IRQ) {
> -                data &=3D ~CRYPT_IRQ;
> +        if (data & CRYPT_IRQ) {
> +            data &=3D ~CRYPT_IRQ;
>=20
> -                if (s->regs[addr] & CRYPT_IRQ) {
> -                    qemu_irq_lower(s->irq);
> -                }
> +            if (s->regs[addr] & CRYPT_IRQ) {
> +                qemu_irq_lower(s->irq);
>              }
>          }
>          break;
> +    case R_CRYPT_SRC:
> +    case R_CRYPT_DEST:
> +    case R_CRYPT_CONTEXT:
> +        data &=3D ahc->src_mask;
> +        break;
> +    case R_CRYPT_DATA_LEN:
> +        data &=3D CRYPT_DATA_LEN_MASK;
> +        break;
>      case R_HASH_SRC:
>          data &=3D ahc->src_mask;
>          break;
> @@ -589,13 +836,19 @@ static void aspeed_hace_write(void *opaque,
> hwaddr addr, uint64_t data,
>          break;
>      }
>      case R_CRYPT_CMD:
> -        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not
> implemented\n",
> -                       __func__);
> -        if (ahc->raise_crypt_interrupt_workaround) {
> -            s->regs[R_STATUS] |=3D CRYPT_IRQ;
> -            if (data & CRYPT_IRQ_EN) {
> -                qemu_irq_raise(s->irq);
> -            }
> +        /*
> +         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM,
> which are
> +         * added later; until then it keeps the temporary workaround of
> only
> +         * raising the completion interrupt without running the command.
> +         */
> +        if (!ahc->raise_crypt_interrupt_workaround) {
> +            do_crypt_operation(s, data);
> +        }
> +
> +        /* Hardware raises the crypt interrupt once the command finishes=
.
> */
> +        s->regs[R_STATUS] |=3D CRYPT_IRQ;
> +        if (data & CRYPT_CMD_ISR_EN) {
> +            qemu_irq_raise(s->irq);
>          }
>          break;
>      case R_HASH_SRC_HI:
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

