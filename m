Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5159FC5AE5D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK4q-0003i9-H7; Mon, 10 Aug 2026 03:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK4K-0003QN-8e; Mon, 10 Aug 2026 03:05:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK46-0008MR-Fb; Mon, 10 Aug 2026 03:04:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjIM+6AyqGBvRBNwEE4mjaJU94xGYWBi434Lt3zVM4wFmqIUTGWjkpCxyfdWtCh3PBMjFqnN9SX17EpoJf3zYD+Og3GNqr05W3EVY38EiegNZwUXZGXznbxxxgnaVwJFtsBeU20F4yvgAiQatXWYGPBS5P7PgcQva8OuPAO4OWPx4Cr5m34I2VXZACq7/XgtCHf4/yFbpjwk2SZGua8AOoe3DG/l/vtnzSiVRnyN/N0PtD5jywI9tWhlDAQaqIu2zRNkRoqvGu13W0b41J0i76FFV622fk2aN7jYmmjpqnyiWW3ZSe411opTzwbO5rE5yplgo1Xd3YFsyBYjA03ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbFa/GjDqE/jepwhH+Fm413C9rmb0Ld1BZVyw1vfQcQ=;
 b=oZgE5uV2W0N5DrgfQkaZeq9xNESWsX0pUP4jldmrO0x/o6iYw+nExDwAV4Z+1oNrFn26bwVG/6s912lid0c/DJNpFZ/d+r5x/1WUg2M1mn/vW9mZET55lU5ef6R3TppqoV5cPmqxdqj3ZC0KE0HYYtAnyfCh17ceqlA9gzMRtzznFtE9xHL4cxmcUxHxtUE0st5uhfyr+MDzr3Vh0K6YUs+AheWtBtQQbZhHkgbMBMaJpA9lkQlXV0pJRFfNdz2CggTuyOJsN3jTGbUKT7Wd+U41DPeD3/lfJO/Uv0/gGW5lEs6TkPPfcyLagrbHgJ0f4hwQClMZrUvnbFxIjkZK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbFa/GjDqE/jepwhH+Fm413C9rmb0Ld1BZVyw1vfQcQ=;
 b=bP1OkKy3CPmnqateJHT8EkvZjZxomOfeC38YUUchZwHpfl8xxG+u6PCrf7qSlcA3y5SvThHpFoAHSMWBGfnn+PdFiAoYZVf+NkWqEo3PGtLUSbq3un6K2S1u9idavV1Jihjkmp9fGqrTA1Lai5z/jOKv8NftHmcZTe4Kwae5+phdYpR7+1952AbOgBZvrOBwb99HTYarMNeMAJIaU+Ot/UJo02ahvMawYO+3eJ3MdD2AVCMmXVIFL+ZWLD6cImfOmTmT6SldQCUQkS9xwAXg6NWXOJaJU5hbiGbqblq/TxL8dJ341dIiAumgPw0ndwOFH6EU0Vs/BQntIHKElPaDFg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by JH0PR06MB6534.apcprd06.prod.outlook.com (2603:1096:990:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:04:47 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:04:47 +0000
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
Subject: RE: [PATCH v2 13/17] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Topic: [PATCH v2 13/17] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Index: AQHdFAq4Pxa5LU4mSUqdBKFRnKiNbbaXBOlg
Date: Mon, 10 Aug 2026 07:04:47 +0000
Message-ID: <SI6PR06MB7631BF37983D54E72254CA61F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-14-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-14-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|JH0PR06MB6534:EE_
x-ms-office365-filtering-correlation-id: 36b9f97a-e452-4cb3-1f56-08def6ada9e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|56012099006|38070700021|10067099003|4143699003|921020;
x-microsoft-antispam-message-info: QzL+aCNMcNVaJ20e6K6H1fifrQlmAx3KZRJpdXUxxTUbFtWZNBnNGmaoOHElFoyeNwYuQXhOpGrQZg47kwxcxmsJd2qpabavncvQ1I/dnyXrHzUSoIYB7T9wUI8hE5kq5ZKBbmn+clsHhKI7AcF4J1dWIHtIMZgzcm0Si0w7bCocXQj81lF7tY2OO2mizuaBA2pOjVvyw6UkaJgbpJV8GRoDeVEAz90ULddaRXedJBL0rjJjB8e/PSqVTS75eqvqG1AshAok9Vxo9YeOUxoSIhO0Y2jm2smORdb+AtVKfhV+CAAcI6SOHfI9/8wV9DCZU4ETdZOndOUT2SL8UE7zAe+GYE0QJo1DS8lfNv4dCFrcZvnb/ZKpBT7s8ZDQd6cWD9UTSk6N2S0UWyXSuPNAMwC/Zv7hwxhxT0QT3UifY+A2dDO2Jp5AdZLPMB21xG5QGH0pYNLBqt70WKuHMOe6tYRK3rix2JB0Mz2Jtc9ojY58uPhYmQ41f7dYMU25+wL+8j5dvtgp1P5T2I+lqJ8k5DOckXy9YBEeekjDcXPapl7OJh3Abb6IlEYP0WOnzk6H//UPyXG8fiARy5/fLZsxxtcLQqAnzF8DOK8U+s9NeTSBtdOPZA1h1gT5Odr69/nWMSP3IKrAiRtEapo+E2+xMaDaaHPyePfzwAuVvAtnMp7XAj4qrlhAGeg0sbHLF33WQd8BlaPosXDX12Ff1aXEk+DoyjwtAjNDdI+E+B8u7J0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vJXDB0goKpyY8nis2jPyPY6hT90GbAevUPewpeZOLDitmvZuj9JAD1GNvg?=
 =?iso-8859-1?Q?i1gJ5NquhsDNXoMnvRWzLV9Nq0vGM7ek/uF76o9jIsQwagFgfZ8TjSvjY1?=
 =?iso-8859-1?Q?elk310DOXwxtfBmpVcyw/tZb42Tahxb0XLPGQ1UxMaJQkp6ifs+2bcCU1H?=
 =?iso-8859-1?Q?Jf9HULOdztpLPPFmDP44Y5G9tlmBRZ6uJ4MYcWIzY0aX4peZtZaqBDUNV2?=
 =?iso-8859-1?Q?0N+oqeD+XLjnCYGt/kPccOMDR6LubaXMXoVVK895N5XynslElv59bWryGa?=
 =?iso-8859-1?Q?K9/Yem0G6CZhwnsP8rALLG9x1xYv/tczZXy6fw3bf1GgGuRLDB9Ru0i2IZ?=
 =?iso-8859-1?Q?XKdEDfXhc9rsRdiUjHrE5sJg4KFTs0QqL2IlVe0NibOQt2MZT5ZqAxPPav?=
 =?iso-8859-1?Q?NyHHzENHaIXdRHutB8uZKhs+8/Djzj6+kf2Q/A8bgrHvnbjqhtKjmS2VIy?=
 =?iso-8859-1?Q?083InbZsXVpVTCQdHg0xD+rxTwJ3SaQNXR2JXfdZKJk20sV0Ony7+zWBzh?=
 =?iso-8859-1?Q?5GlYpSXLrv/1jF2DJcvsud8fqxwhORjRAgyl1Lk02hPbgBp0WJDYzlHrzH?=
 =?iso-8859-1?Q?YSzzvAynxz7njrBStSapTSvjI9FLeJN0j7TAPsPBXUeu4DNhGbH4MIUCBc?=
 =?iso-8859-1?Q?Ec61KyR4L74HtktuooJ/5lWBsWpgB2mmQzuINyEQ1+VxOPDl/yYaHsNj8B?=
 =?iso-8859-1?Q?sFGFCOvF3KbEGnVhHqGdYDa5zOh7MTlP9gOROhQzYALzRQf8Bacf9bM5Z+?=
 =?iso-8859-1?Q?92cHyLi9Hr2U/M/uVN6ZLgLH35uBsjdWNpb0yvqaWTrW28FFC9ar45/kKq?=
 =?iso-8859-1?Q?KDq9ihrhiFfMBC4qnMB/zLiXYQhxq/sRDik5Myqq6EubdmTANNe7C/sLe4?=
 =?iso-8859-1?Q?Ts12i0RoABtQmipwtNGbF/+XeEmGzYlmq6JNMCxNNY4mj6P/qPt/Af9v/W?=
 =?iso-8859-1?Q?o+0be2cjNi2N0/H9XRAGawr0aOqEXihxolXJTy7rCE94Hh8iPmnMFZoP7P?=
 =?iso-8859-1?Q?IjWxhZSC2vuZGEydqE3fhir4iclwKtv1VWa17ay28rWFW1Epsnl99Q02B6?=
 =?iso-8859-1?Q?9JDbqDaUjsQbfWPY1OHDaFtDddOQPgkHJDnQNoim6ym/j2EcOOpgJtnd2H?=
 =?iso-8859-1?Q?bB0VCsky3rTD8HI97CIAL588kBtv1Kj3Hp4LcyUCTG8oz18idEHq4PZGA4?=
 =?iso-8859-1?Q?YuTspxf/Tte5t7EULLu+NQwlSyHt88WC8GGWEu4xe8Luik+qtfAs5v4aBu?=
 =?iso-8859-1?Q?4sWplOZ2fCNS4DOV5c9M8naCs4KoPz3EFCRQqjXt+Md84mKNVP+aft/oE1?=
 =?iso-8859-1?Q?CdmjcBQojsTpnhZHx6mW0ZP6f+L0gzSazdc8+9oLEVFd5Rw40uqAkNTS7/?=
 =?iso-8859-1?Q?+7kNzYSZxkDT2m+JXUD2/+RsHeaGkVT52H61/K1RlAP9F6Gx+/c474C70c?=
 =?iso-8859-1?Q?B5rLuFRMCKln1FEuqLC+kk256IXzSHMuLvRkHsI+JvHfeCYSVCx9yNxkAM?=
 =?iso-8859-1?Q?Yfos5BmuSif3R50L+ujoT6a1MFpURLiYJwYgvo+oeO7h/DqGX51y5Kh7Ge?=
 =?iso-8859-1?Q?77bifcSACbWnWwfwAogq77Lidcn+wJLUXMW7pmWcNb2o5L5EosdUfcVt6e?=
 =?iso-8859-1?Q?z4kB4AWvK3vvY+iaoynCuf96WmwrAFG/xUDhGgjhRRDPnjFO7bXLZwGZfn?=
 =?iso-8859-1?Q?sdeHc76HunFsmMih401nRyHuDsyARFH9nL1lUs980AXdM/Xg3TkVTZQHKu?=
 =?iso-8859-1?Q?WAuhbBYoeLvCb7I9rC4fAc23hbZ0V0CZDY8kbBL8FwPbaD7RZE43DsyTEm?=
 =?iso-8859-1?Q?JXWa2Zr2BQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qQuq50AeZqrv+XuHmDqZQD0pKIruYp1gokjsobT4eKoofwavvKESd5vEBpyTGulykvHpjb5QqebpLKNhQRpYwM7ipmKzWQmTiMQ/fVYB8tHtRK3r8d5vi3I7A3d9QBsOtoJPBGT5NlqHKaN8r2sID+3MSXUl24B2JDbdrfAtD+4DXwBeRPV77ytKZkU0yYm76i2k8Ev1NGG7AfaEA8gG7XGhV4wo3Ya7vqbjIvLLNfC9/Ea1JeTEt+UiNezroc0aY+HeoxnZTqbq34+GLNxwkgHRV5n2OTkHzJFdT9GpNt+hvJpqFhsKdVc2qq1MdIMVnnPYtauu6sLO9LVBI/eUzQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9f97a-e452-4cb3-1f56-08def6ada9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:04:47.2569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zn9x+h+ZhyapyNeytTs/S2Rer/QRMQwXLOcBTDSUjtbKwvNoXr+di4vEUA47AG/Ab1+j6J7TrDgsdKOL4Q4jHuKQPPd7bp/77flGWbrDW48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6534
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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
> Sent: Wednesday, July 15, 2026 11:34 AM
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
> Subject: [PATCH v2 13/17] hw/misc/aspeed_hace: Support 64-bit DMA for the
> crypto command
>=20
> The AST2700 crypto engine addresses DRAM with 64 bits, supplying the high
> half of the source, destination and context addresses through HACE80,
> HACE84 and HACE88. Add those registers and a crypt_get_addr() helper that
> combines the low and high halves when the SoC has 64-bit DMA, mirroring t=
he
> hash engine. SoCs without 64-bit DMA (AST2500/AST2600/AST1030) ignore the
> high registers, so their behaviour is unchanged.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> 09d0515271..a807cc1422 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -58,6 +58,11 @@
>  #define CRYPT_CTX_KEY_OFFSET        0x10
>  #define CRYPT_CTX_SIZE              0x30
>=20
> +/* AST2700 64-bit DMA high address registers for the crypto command */
> +#define R_CRYPT_SRC_HI      (0x80 / 4)
> +#define R_CRYPT_DEST_HI     (0x84 / 4)
> +#define R_CRYPT_CONTEXT_HI  (0x88 / 4)
> +
>  #define R_STATUS        (0x1c / 4)
>  #define HASH_IRQ        BIT(9)
>  #define CRYPT_IRQ       BIT(12)
> @@ -672,6 +677,19 @@ static void crypt_be_add(uint8_t *ctr, size_t len,
> uint64_t add)
>      }
>  }
>=20
> +static uint64_t crypt_get_addr(AspeedHACEState *s, int reg, int reg_hi)
> +{
> +    AspeedHACEClass *ahc =3D ASPEED_HACE_GET_CLASS(s);
> +    uint64_t addr;
> +
> +    addr =3D deposit64(0, 0, 32, s->regs[reg]);
> +    if (ahc->has_dma64) {
> +        addr =3D deposit64(addr, 32, 32, s->regs[reg_hi]);
> +    }
> +
> +    return addr;
> +}
> +
>  /*
>   * Perform an AES/DES/3DES ECB/CBC operation. The source and destination
> are
>   * either single contiguous buffers (direct access mode) or scatter-gath=
er
> @@ -719,7 +737,7 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      }
>=20
>      /* Fetch the IV and key from the context buffer in DRAM. */
> -    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];
> +    ctx_addr =3D crypt_get_addr(s, R_CRYPT_CONTEXT,
> R_CRYPT_CONTEXT_HI);
>      if (address_space_read(&s->dram_as, ctx_addr,
> MEMTXATTRS_UNSPECIFIED,
>                             ctx, sizeof(ctx))) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -760,7 +778,7 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      dst_buf =3D g_malloc0(buf_len);
>=20
>      /* Gather the source into the bounce buffer, per the selected mode. =
*/
> -    src_addr =3D s->regs[R_CRYPT_SRC];
> +    src_addr =3D crypt_get_addr(s, R_CRYPT_SRC, R_CRYPT_SRC_HI);
>      if (sg_mode) {
>          status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);
>      } else {
> @@ -796,7 +814,7 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      }
>=20
>      /* Scatter the result back out, per the selected mode. */
> -    dst_addr =3D s->regs[R_CRYPT_DEST];
> +    dst_addr =3D crypt_get_addr(s, R_CRYPT_DEST, R_CRYPT_DEST_HI);
>      if (sg_mode) {
>          status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);
>      } else {
> @@ -960,6 +978,15 @@ static void aspeed_hace_write(void *opaque, hwaddr
> addr, uint64_t data,
>      case R_HASH_KEY_BUFF_HI:
>          data &=3D ahc->key_hi_mask;
>          break;
> +    case R_CRYPT_SRC_HI:
> +        data &=3D ahc->src_hi_mask;
> +        break;
> +    case R_CRYPT_DEST_HI:
> +        data &=3D ahc->dest_hi_mask;
> +        break;
> +    case R_CRYPT_CONTEXT_HI:
> +        data &=3D ahc->key_hi_mask;
> +        break;
>      default:
>          break;
>      }
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

