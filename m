Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97C3C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK1m-00020T-By; Mon, 10 Aug 2026 03:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK1d-0001pz-V0; Mon, 10 Aug 2026 03:02:23 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK1c-0007xs-1j; Mon, 10 Aug 2026 03:02:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaibATgbF2Ytzh5BZkkhJxNXKAw4/tZ+R+GfXDH13t+QYkfzzN4bTH0rlAGfjTo0MzxGOoJYKTAykm8EvZPfd9B6yl48/1Aw8qJh7abNbHa8q/iu2sy5WkKP/nuQ9sw2drwKXsOKQDflZ036DUERLc3dVG+0qEM96QDisrHmZkFA2vhPYRuG9+Cm2mA1qxykl/IMKhqCKjMLrm2tcfx51xtbu8HcYC2IXBn4FAt6P7SHnrGDsWmvxErNDhQx6BwFzqaldg9BnwJ9b5qd6MHIT9aRGFa44DaomOvkqCztKzzISKDz8eGi7JgHNaatA0Er+8ciX7qYpgsKj398GJ7n3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/IiWZLN3SZWXu5R4XrPJ9MC4BOkcf3/BrgqDVtIvro=;
 b=J/X8zAiMClwoL4N+dXFppiIkUZsPLFKUAcJ7T0WK+nhPqQ+AMuVb4kC2jQ9extQ9rswEDYvC7S0gvw6g/K3DkHg2KGh3eiPqLt8UKiwhIfnus6d+hjjju7J0VqtmPV0ii9x9HTtoikK20mWrNvtB8XpU0tkwCuUJdOv8Qa+LKRl7aT1zb1SEhpMQ3YXXU39SmWRyci1P/Oosas/5QYdiNa5D8be6TIOJG2jk/PI+n8cvil2W14+hXEGlSvly5P4adukG/DTBkgc8IY+UKTntgggukqUnX9rBaAdhnxOc7ECuGj8Q6x/yrKr3Cfx5to3WvTBZgL/XRjsf746vSxjCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/IiWZLN3SZWXu5R4XrPJ9MC4BOkcf3/BrgqDVtIvro=;
 b=kreQfkXT81/OMU1udEEj14AWzwJOFJO43ZD5nlKf0kTGqtVTMBRxzEb4XFfzRSXPdd2FbVCKzL8IXbc8bgezzjwHK6LYH2lRAwPE6WajK1PQU/BtCxeHqiNg0//YFkZGJ7k3xk4yMD6wW1u/6czhS7h5GxEbS/Pinn+dTBx2ZyOo2Xby1tKsyaUBIIc0WJgudJewOWjhDcUDgZvytVV6IdWT2k5sMjbiguBzyenJUFADxIowtUKQmlcos9kSDfiknVWnbNJDHOrQRGX3TpD+40IQiNf1FjLdvYV433bJ0493fkkiH3Rvg+FNdEc4Fxs/H/ToPB+czD3qPOq2HjqAxg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KUYPR06MB9111.apcprd06.prod.outlook.com (2603:1096:d10:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:02:14 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:02:14 +0000
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
Subject: RE: [PATCH v2 08/17] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Topic: [PATCH v2 08/17] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Index: AQHdFAqyz1f5si4Fe0mVTG734szMqLaXBCmQ
Date: Mon, 10 Aug 2026 07:02:13 +0000
Message-ID: <SI6PR06MB7631458490FAC1C2AC55E6CBF7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-9-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-9-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KUYPR06MB9111:EE_
x-ms-office365-filtering-correlation-id: cab85226-c0dc-464b-db42-08def6ad4e79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|10067099003|38070700021|6133799003|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: SeAJP2JW4MBfRUHiwXq7mJ8CGgP7XHrcytvfdz4XwC28hH+9F65XE/0cCgt7RzHLc3Xilt/kYDptniK/Ukp2joa+gBdaZfVV2oAcJuT4VlstSgJX5Qbcj7TVaUWHOB/TIE125s4mPCz/zn+VMv0Hn4Vd9ijjLrmqOWYwfUjN6q0hOr8I4t1LdDtNtEjLylD3dO+hNfCJop1ueNVERSvIij6Kzs9jxd52kGu597Nr+bEO08XwHKhwQdaVIyIKVzDUTOhXIpZ16nl6P27+6ywXKKSSUCGknkmJ9KqkZ1v5R/rMhp1eZLyM7I6ObvYvhu/S/m/bMkHh6536s9e4BVnW89S8DX33W84IrlD3j8wargOZppwpN2GmFESk4zzm4Zq8bZOAYM3+qOdjb61l+J62GPpUDHgDyp5rdDA+SSqSnW3j8vWw5uZcVqSoJwba9lzEdMNfAFryoOLFT1ulGthiDRg6Shb0PbXGVWOfJl+5c+O6cAYpa+ewWxdWWRWHTdpgpSgZiyhOBLMc4/OhuU01j+R8Hhuh1oI9O2XL518lcDv2wJoe5+o0Omrg2H5A84SJsGcQqYEsSWI80yCIy8FCnnMFm03PH+4vmp47dvMEUsnRNn+n+8C9djv+VaNc4A/LpL5bjtNJo5+4lOviwVjSgLGC9vXQwo5NQ15BL2LveBlLngKeT2Yg1q9/lChr9/Yn3iveAIs1SA6mKUm1cRXLis2tquGbBZALiOjcl6ur+SfWajRyOrC3MKfRwIboYl2t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(10067099003)(38070700021)(6133799003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lE9LzTErtBFpzuCqhR1n9QwyzdZIeInC3rdVccCpU03e/tNoky0PvoddKE?=
 =?iso-8859-1?Q?zDQl1L/qnf23A16EbBQqUwQU562AgbN23L9eRrjVGjI32SpDq9BSz54/KI?=
 =?iso-8859-1?Q?TDFPtZiZhQA81KW4GqnQu7n4DlLWzWeMtnKNWPoUSJ7JJJ+MzvJkoZCU4a?=
 =?iso-8859-1?Q?y4dmaFitu4yKe8mEofJzB569amBM1E7teO+K89nH43ZcFXlhLW5gzoR0uY?=
 =?iso-8859-1?Q?WW2jJMmQiaZL9sTfNt6Gk7Olt7twFh8OI2mnOrAoFf+hFsCbXxVgEMqcGU?=
 =?iso-8859-1?Q?aBWoR8fZD+QlTknEQeWt7/DhUp8V/IgfbffB5wxzB361g4Ie5/GR1xVhFc?=
 =?iso-8859-1?Q?YCF0bsJ7OshBk175Zd7Uv96Ib9vBPgf7ZJZpbYCgS3A2WHc/CkbWJkhhEA?=
 =?iso-8859-1?Q?WdW+QhDAQ2PWXjb64ty8Zw7g3sPx+KdKsfDDfvdKg36B2fmJvmRs5sGSi5?=
 =?iso-8859-1?Q?8ssiq8gB5XBEVqhdmaph5LEfLWGcHO38hHMH0dD8CYYlrzeGA5WZsWvrHk?=
 =?iso-8859-1?Q?kPmOP9+2lhspZsho7WBqHquAyospMvmLh1226Ww2V28Uhde/M0+olAZcM4?=
 =?iso-8859-1?Q?XdPkLaU0BbSnx0DkLu3zEkusvVuV+5zaGVUuTNZjvE9qtOpoH6k3us++LF?=
 =?iso-8859-1?Q?97lB/Ce7caqhXhlQ21UfuX+jkS5xch9rVkdeAxgM5DA0IMzoxzqzkNZHMq?=
 =?iso-8859-1?Q?xX0akP5s8MzmOjRoX+lCd8rG7j2Jtdqn5l67DbtG1rxn34g/nBmbNmExTC?=
 =?iso-8859-1?Q?lj/4dCUcHpuud0XTPf0kFhZLsjBYXV/+lgkMfJ9YWLNDmt+a79C/MlHHMK?=
 =?iso-8859-1?Q?Z520a5yL/YY6BaGKyNKPIR5g+4v+7I8ms5p8dh5WoiLn5qV5/9r3tvxS1D?=
 =?iso-8859-1?Q?RSqP0GbxUSwhlDhkQ8Fg9WP4PDnNNVKnSzl1cKWUn0AKlBxvG4N5bDV0Cp?=
 =?iso-8859-1?Q?1suRt9L8puKKF/iB2csVPijYOpkXuIzgambVVC5QmdEH42yNAVlSRs314l?=
 =?iso-8859-1?Q?uQK7IDaO1tZ+Cw+X9nZvYUDsm946o7+tf9QsFAFMabcOi/ArdfDBp3kzKc?=
 =?iso-8859-1?Q?d0AnzxZOANx6z5gvT5k8w5b3nkJoTlmtWLQELlBJz3NlYHurFIjBXWJOp0?=
 =?iso-8859-1?Q?2U667778HouwfmE8tIXwmZ9QET3D1hJwgl2DFqUxLBLeTq3gKvv8InmT+C?=
 =?iso-8859-1?Q?uiHIMBzD4sxSDOVCQz8u0AykWLoj0sYS8De7+Mq6Gt51UEqKFPKOLdnXwf?=
 =?iso-8859-1?Q?v4XeSExiqDGjoFWYGf5DaEdWNwk9uACBGF28OPSR61fwDLrpvp3gn0syqo?=
 =?iso-8859-1?Q?pQkJ1CqfSxdSDhyCNGp9uOcvXNk9RTAMK2JxC8gHY46Kdpn5TvWLnMotEV?=
 =?iso-8859-1?Q?taXY4VuatuqwavbXtijyWvKxASAUO2jm00VUEDjFk3pk4wXZKO7IRYslm5?=
 =?iso-8859-1?Q?gi2xqNsCNleEVTMqxTWwgpqjQJAsshIDXg5J6wc1/sjkvLZtynZTfqfDk5?=
 =?iso-8859-1?Q?uzdZvdp7qxW4bZI76/fBSlCVgklrg/ausq5Dm3GOIQ0kagPSUruu8v07iK?=
 =?iso-8859-1?Q?BIkjwN9XAfcszw4peYziqnK4ls+eNpRDM6Hy4GYcmRyv9lLFGPMhyoCCcu?=
 =?iso-8859-1?Q?ST+5aUOEwYW9/Kbys2mAOFKC5atXB6ctrentR7SXvug3nM6vFiVJvXEzR6?=
 =?iso-8859-1?Q?UcX84lZFrpFPpziSmUBTFHRZ3PNWS1MXqWIm9Z64TJu7fjrFqu+s8Pp/1M?=
 =?iso-8859-1?Q?PVkoi/s79iK5Es3mYfTgPkz2dST11YWKRoHg40mcD/itw5YmgqHeCJSqTN?=
 =?iso-8859-1?Q?nddu0lda7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M39yBJP0i/ljDaBaZpED3181Xr4Bv+lBEOpBWriFhx8VizsOJkiGFtozUdH9dNL8F2b+H2CssDLgJkOreUL5yQQgwCDcx4eFmKmyD5wPE8Vj/D5yzqLgiZdh0MFNYwbHu/qfWeQlVrkITyB+I1kh9JyNCtdnRQ2/AtIdjZ5cn2WofXvh5Fwlk1INJCoZ3xECMLtQGNK02vavIr2vsp0N41QkpUHliNIQxnOt3r10BlCjGmBgA7CAF3uORoR6CVr4K5v1wQYiwKvesGGiRTkxbwNBRPIBjr5K7BJX2ARHowWOb3tanPeJL4o2w0M2jZ2T4On8xMn0PkgzwO/tAa+6QQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab85226-c0dc-464b-db42-08def6ad4e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:02:13.8934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7UcUUb4jqi8cp5+uTwklcYfS8dyKMkwmSmoEOOxYsSDRtWexmXofhXxQeB3lP+wjqjo6BPf5O3bqnS9qlLcU2pWfjFTIZk7KtCz6MqEb+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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
> Subject: [PATCH v2 08/17] crypto/cipher: Add setaad/gettag for AEAD modes
>=20
> AEAD modes such as GCM authenticate optional associated data (AAD) and
> produce an authentication tag, which the block-cipher encrypt/decrypt
> interface cannot express. Add qcrypto_cipher_setaad() and
> qcrypto_cipher_gettag() plus the matching backend driver hooks. The gener=
ic
> front-end reports an error when the selected mode's driver does not
> implement them, so calling them on a non-AEAD mode fails cleanly.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  crypto/cipherpriv.h     |  8 ++++++++
>  include/crypto/cipher.h | 36 ++++++++++++++++++++++++++++++++++++
>  crypto/cipher.c         | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
>=20
> diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h index
> 64737ce961..c4f995f369 100644
> --- a/crypto/cipherpriv.h
> +++ b/crypto/cipherpriv.h
> @@ -34,6 +34,14 @@ struct QCryptoCipherDriver {
>                          const uint8_t *iv, size_t niv,
>                          Error **errp);
>=20
> +    int (*cipher_setaad)(QCryptoCipher *cipher,
> +                         const uint8_t *aad, size_t len,
> +                         Error **errp);
> +
> +    int (*cipher_gettag)(QCryptoCipher *cipher,
> +                         uint8_t *tag, size_t len,
> +                         Error **errp);
> +
>      void (*cipher_free)(QCryptoCipher *cipher);  };
>=20
> diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h index
> 92939310ef..2e361411b9 100644
> --- a/include/crypto/cipher.h
> +++ b/include/crypto/cipher.h
> @@ -235,4 +235,40 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>                           const uint8_t *iv, size_t niv,
>                           Error **errp);
>=20
> +/**
> + * qcrypto_cipher_setaad:
> + * @cipher: the cipher object
> + * @aad: the associated data to authenticate
> + * @len: the length of @aad
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * For AEAD modes such as GCM, feed the associated data (AAD) that is
> + * authenticated but not encrypted. It must be called after
> + * qcrypto_cipher_setiv() and before the first encrypt/decrypt call. It
> +is
> + * an error to call this on a mode that is not an AEAD mode.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_cipher_setaad(QCryptoCipher *cipher,
> +                          const uint8_t *aad, size_t len,
> +                          Error **errp);
> +
> +/**
> + * qcrypto_cipher_gettag:
> + * @cipher: the cipher object
> + * @tag: buffer to receive the authentication tag
> + * @len: the length of @tag
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * For AEAD modes such as GCM, read back the authentication tag
> +computed
> + * over the associated data and the message. It must be called after
> +the
> + * encrypt/decrypt operation. It is an error to call this on a mode
> +that is
> + * not an AEAD mode.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_cipher_gettag(QCryptoCipher *cipher,
> +                          uint8_t *tag, size_t len,
> +                          Error **errp);
> +
>  #endif /* QCRYPTO_CIPHER_H */
> diff --git a/crypto/cipher.c b/crypto/cipher.c index 52d071a90c..67014aad=
6f
> 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -205,6 +205,37 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,  }
>=20
>=20
> +int qcrypto_cipher_setaad(QCryptoCipher *cipher,
> +                          const uint8_t *aad, size_t len,
> +                          Error **errp) {
> +    const QCryptoCipherDriver *drv =3D cipher->driver;
> +
> +    if (!drv->cipher_setaad) {
> +        error_setg(errp, "The cipher mode does not support associated
> data");
> +        return -1;
> +    }
> +
> +    return drv->cipher_setaad(cipher, aad, len, errp); }
> +
> +
> +int qcrypto_cipher_gettag(QCryptoCipher *cipher,
> +                          uint8_t *tag, size_t len,
> +                          Error **errp) {
> +    const QCryptoCipherDriver *drv =3D cipher->driver;
> +
> +    if (!drv->cipher_gettag) {
> +        error_setg(errp,
> +                   "The cipher mode does not produce an authentication
> tag");
> +        return -1;
> +    }
> +
> +    return drv->cipher_gettag(cipher, tag, len, errp); }
> +
> +
>  void qcrypto_cipher_free(QCryptoCipher *cipher)  {
>      if (cipher) {
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

