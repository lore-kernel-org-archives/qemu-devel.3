Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C56C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK3q-0003Fz-NH; Mon, 10 Aug 2026 03:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK3k-0003EJ-T4; Mon, 10 Aug 2026 03:04:33 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK3i-0008Eh-DD; Mon, 10 Aug 2026 03:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO9En0XernX2PRjkLJLwVnYPUxDfQjK5p2tQQ6kmjrDbH7DOznl0Rr4WgD6DB7KBOLVOB5wa+ym60at3w0xGYjZfqXtDhtD8kIBtAsoklYbqX9horiIkFhF6U1FJqlyUWzKU18U0xeKV40AOgAHJ7gFiojTt6/0gGRyj7yLs2TLRjInVblDLh08Gho1K47rGjXPBqaAAzVFIYLz6QqrPPzeXmW5HgXOZ+6X/8SeGlL2OyuhEjcNV6nksvyW3XHqwMMsFPG1SzhTj+4cFj4lkvqSnbVb0JxLXhhdy4jqo2ysMBjCm6f/O96xIgsZryrv1NURwDJg8Lvl33SZTY4yQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT39FY62JscKpNhMqmeOULiqbNSS1VttggkaxEkYnzE=;
 b=t7Px72A09cvXsqWv2+66IuP6DrlNwjToO48h8shTcGSP2S0NEVswuUkqxg0OTNKtWo8UHOpbI9g0axOFJbtaUNh7JUH+vFi2JqEB6XirUOB2okkPt/yUZSCUEoZbV5s0U+NnodLPjL8GDIlTJklo2WVLJ0gSSCVr200tju63lFesCAhwrHjVr6VZFvUhIZY5i/lVdbXvrtDKDSfmvk9BsuGEfRtOPig497sp39utAwSOI2dt5/1G5eWfX+XerVubkRfmxDCUiPlhqkB0R6JcerQLwLgHApUtEYiSsMeGEB7Hjh0+zOgxOsHyuFv5xFaEctMYeOh4JzdCbRB/rW9Eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT39FY62JscKpNhMqmeOULiqbNSS1VttggkaxEkYnzE=;
 b=luBZs482Ths8ylloMA/RnWMyfVe85VdRCuNOwC83p281ZkgEhupU0C9XFuFh3jxwMh/fBS7I5MgeHPg8vO4cHP57Ra9SF2rFBQmsjD6aTZNP3legBVbozon2Zc/7w9nxU8ABb2kiBHJCMo1U4/KknurZmorHEUP8+qNHMr75wiPaZD4uHvbknfJAih+fNNmTEL7N1XHEXFYxRTzKonTkQEIWZH/3SL+2dVMtqBneiOAFjpM2z/XKEx4JGqKx+H0Fqb0vmL9q2vCNny3mFr+DYrWHzG1Bqh8egQUNAcvWzQCAxN4ls97cTh5WfGQdnnOidpVAw3azRpwqIGaW/i7QpQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by JH0PR06MB6534.apcprd06.prod.outlook.com (2603:1096:990:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:04:23 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:04:23 +0000
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
Subject: RE: [PATCH v2 16/17] tests/qtest/aspeed-hace: Test the crypto command
 on the AST2700
Thread-Topic: [PATCH v2 16/17] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2700
Thread-Index: AQHdFAq6EN0Jl0EO5kqIFUT1Tfo3iLaXBMQw
Date: Mon, 10 Aug 2026 07:04:22 +0000
Message-ID: <SI6PR06MB76314A70BFA943E4C80912E7F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-17-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-17-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|JH0PR06MB6534:EE_
x-ms-office365-filtering-correlation-id: 2d8f394d-5bb3-44ec-95f5-08def6ad9b69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|56012099006|38070700021|10067099003|4143699003|921020;
x-microsoft-antispam-message-info: UiyreujAuVHBpXv0hm18OMLD/FlkjVNlGcrtJJEx0hXZ+dS3Zr0mtzB47tJ9EPD7ZB/ck0JawoL2o1SwXQgEIP+aHsq5jOfpeeSKuoFtr1Dy8/HCHC7OvvHUWz0xhhBMgqzQTp3Qq/jUvhska6u4bt8uAIsIDPdxrh9xFFGRoZiEKIwLwcMjVcgDtPanHTqg2QcfC1EgjgS+km+LpFwujXcelFdzw65vRjlqHZsdPgpM15+dIyBZAUBIvxcOXZ4TFe9XMrlPeGJ+WkxQqQWunUaB97mbOyT6nk6W1HgA8OLBRCRiMTrSONbUBdHWEqk2p8JMZGnpgDiIaeh9MbRBPfpQZ1BXe71hJf1u6A5DZ6Ql7hsd9VIm47VYavNJ99OEfkEicXE5VOdkprsYZjZelORurFvEbV8G2969zIwWsxKcpNOEiYWxr9doXee+Tpnnd1gZJ8DsI7jLYq2OAqw6LxJQM1OoZKVwNH3KNQ4G576naq5c0jLkQuvp7jYcXtR97vDHbdfkaML+6uWo9n/yJ7QkphHWkHoYOI8f0X5lF+uCYfScdz80MAoHq/ET2bDgvkalAluPRVmAS2h4jT10HrEq83myBeUb/g7Ry49tJKoKBrNdQEWoWr1c160tgcTdv/LIDA3DadgVqc1DUau29mGHSXgFbduTqWimiqBghUSEuyYuOf3DnIw0OG9P0GrUhQhlhp4Wyujpf+eCMrdokArzJxoIcHFshFZhAznyam5ek7lnNvm6FAaPEFKvrLKz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gD8jQjqUemTVwhGZb0r/BHMcsiPCJy3Ipgwhuu1NURaNw35fRHGugaxQ3d?=
 =?iso-8859-1?Q?rLf+EGNHRnAOh4U5iU6cedmWk4app9yoX6UNszOzxr/fG3ICFJsdeHpztx?=
 =?iso-8859-1?Q?b5C0Oz3B/L1hbvB1HKf4NHB8YaGvoRNFf3pVewIe+7R2YKw+XlNTnaaIE4?=
 =?iso-8859-1?Q?R7/AZDGxB+FZxIT33Pgq2Aos2TLu8iBmMGd4bRMRXoGEBYLk5Va0R0rAdR?=
 =?iso-8859-1?Q?r3ucuc9NfvOPw/ejjTlF3sQZrvFAmGaclk9Y5RQLA54GNfpsBTuQiDps6k?=
 =?iso-8859-1?Q?H56l+pkeFcOouPmFXbvBNGYBFknLwrCAiIJUGOzonV1NNpJqUz0d99p0fi?=
 =?iso-8859-1?Q?G8JHi/Yw84VfhRIQO6LTalMaXFwpKRVvHHgvI5ImOvhpykTPrfYzdDnBhg?=
 =?iso-8859-1?Q?uZpy+dhMaKVwicICK1ZO/pq3ULFe7NjfHyfa0PvB1xKioH9QkjIrz8vzDs?=
 =?iso-8859-1?Q?iTM3/YQH/oWQABmUTJkhfm0/L98g4qBet9IrkUYZFLQrr8K4s9JikBUWLh?=
 =?iso-8859-1?Q?KOTkJMzQofUyDwqIeeaJnHcNNFuBbHXN1Ls1a558HhxNIsRBFZOR/kZZOF?=
 =?iso-8859-1?Q?Nen9A4mSa7+9QH9TByayhyNcBZ75Yw50IyAhcakuM2/cxRfvAvOt7EBbnf?=
 =?iso-8859-1?Q?HeKs1GcLv6yRpHsPZMdgre8t7joR121488K52+2ffAzHvBwmLhpmflvoJK?=
 =?iso-8859-1?Q?9t830/ZDCQ/TfgZvrlSG09c7Tz+HjJuatYvWBAyUdKblrUJaVdbeCWHfjN?=
 =?iso-8859-1?Q?UeEWgc8c6KeHlm/FvxOnwAo4+Qi0S6pil947f5mPnjiag91YXxuWAnc8Ro?=
 =?iso-8859-1?Q?apncikGCVUCsTBPXaGiDKIL7Fe1s/RO52UsMr3hcZuq202gMstA+Kkku+c?=
 =?iso-8859-1?Q?V0V5YoEraZLDCtRl5qVmldT7UIS0wArxUxxT2/NT2GUAMZ1XIrf9a4gpQw?=
 =?iso-8859-1?Q?ycHI2QWVx0X57Q351N6V+M/8qMlPObq2OIqtFx0shvCdSzxjRH2/BodCuo?=
 =?iso-8859-1?Q?LfceDkRlG4d2HfUlIcGj/8cWtmQO2+djxQ7OoO8f6L6Uo8x6IE4FmLTF9e?=
 =?iso-8859-1?Q?xPu7iuXyS8COiULYBssHrxYoUETLBc0RnGpwOZhDxJFcaEH8rU0f73hsU7?=
 =?iso-8859-1?Q?MSmrJVlFKycOnlGVZRRQVYjsW0C0s23rur4lfb79FsiXya2RA1n57USnkv?=
 =?iso-8859-1?Q?/XY1S/pJKb5EB0sCBFP09vvPLwXs/Ys0vnmTqjMjVLtN2CHEN8Wu5p29uW?=
 =?iso-8859-1?Q?EK/6clq73zzjtESKyFyDB6Vw+V98jalicLYkNDJ2517FlU7L5sIPIHfuyT?=
 =?iso-8859-1?Q?Pmtsp/b/bj6EAKDIIGfkPH0mrzE81xQSV7GRcpOH6ARdbIH/9519dIvyav?=
 =?iso-8859-1?Q?ePGxR2tL3aNoB3wSpzt/5BIw3KkFNwcRD64NcLX0BNOjiGwnKE5WMhMHGp?=
 =?iso-8859-1?Q?PlNkV04cnx/7u88bB/RmM2/+KT86TLFrrSxsuDWEIMGS6EcRdRAN0Y5laj?=
 =?iso-8859-1?Q?MAIvq48C+imxCPmV5Z96KqZvw/lL5p9vrqa1nzAcBkfCViifvR/24yjsPj?=
 =?iso-8859-1?Q?rx23OQ1PyNOw+zHozqup2m2xbfJJAgvr0JYuuScm+f125bntq1hlNYDr9c?=
 =?iso-8859-1?Q?9Syi9apIJW2i3zLFs4Ts68vUoFX2aKxayMd9PO01RPkN9/KuK/J6fwUALg?=
 =?iso-8859-1?Q?xJqSK1/K35lFtjz5lscfNcqIDMTOJvBSUl/n9rtHNsI+CUAH+1MGQZigCG?=
 =?iso-8859-1?Q?8wQIncgqZ21aT5CYmVvXG0bIpJX86NxeiCY6RROp/G1Mcg0qHyh2pfVWGK?=
 =?iso-8859-1?Q?zZV9/5slRw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f6I0MGAVpl7V2MpA0Vj1JKthhW+/YqSdhb/kpy//mlXFKkhzI/q8U1X73yhkdIAK7cLkA0E6y9CHKOBWMIsSYMHoeXBpCOvC3PoNyqJaD9nZmhF4EkI5xNjL0jruhiFHQmDT12BHrBPgtTWwyviN6c+oWGtZk3EOXsjRQbSLixotCZQ8MXxkby83JKcfzN68GNaOl6ozwSwlhD9R2nvKjbpyAI1EDMV4kyzVO0dUjjpOttRJWqfI2IA8qsCvWAkN8iJ/PGeuKu8HJmIJ0qRjlVhegQbGU1U50D3VPkgcHeZnl0zCOaIFqSg47av7rzf82ii+eTagm3GAeO8hTNtOMg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8f394d-5bb3-44ec-95f5-08def6ad9b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:04:23.0256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zV/yrxnAgdgc2HhXVqacyJFNHvavwIqETcRFRXmLkdDYc/zMatYbJQXU9eTGMnTP3RV62bPwDnZiRRNtzaBXKcrVMbsHAjXGEkJnvBs/5v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6534
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
> Subject: [PATCH v2 16/17] tests/qtest/aspeed-hace: Test the crypto comman=
d
> on the AST2700
>=20
> Cover the AST2700 crypto engine, which drives 64-bit scatter-gather DMA a=
nd
> adds AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.
> Add AES-128 and AES-256 GCM known-answer vectors (GCM specification /
> NIST SP 800-38D, no associated data) and a dedicated GCM runner that
> programs the tag buffer and reads the tag back, checking it after both
> encryption and decryption. Register the AST2700 with all four modes.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  tests/qtest/aspeed-hace-utils.h |   1 +
>  tests/qtest/aspeed-hace-utils.c | 163 +++++++++++++++++++++++++++++++-
>  tests/qtest/ast2700-hace-test.c |   9 ++
>  3 files changed, 172 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-ut=
ils.h
> index 82b0b3f93d..a5601a3d65 100644
> --- a/tests/qtest/aspeed-hace-utils.h
> +++ b/tests/qtest/aspeed-hace-utils.h
> @@ -86,6 +86,7 @@ enum {
>      CRYPT_MODE_ECB =3D 1 << 0,
>      CRYPT_MODE_CBC =3D 1 << 1,
>      CRYPT_MODE_CTR =3D 1 << 2,
> +    CRYPT_MODE_GCM =3D 1 << 3,
>  };
>=20
>  /*
> diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-ut=
ils.c
> index f582c88ef5..260eec043c 100644
> --- a/tests/qtest/aspeed-hace-utils.c
> +++ b/tests/qtest/aspeed-hace-utils.c
> @@ -654,6 +654,8 @@ void aspeed_test_addresses(const char *machine,
> const uint32_t base,
>  #define HACE_CRYPTO_CONTEXT      0x08
>  #define HACE_CRYPTO_DATA_LEN     0x0c
>  #define HACE_CRYPTO_CMD          0x10
> +#define HACE_CRYPTO_GCM_ADD_LEN  0x14
> +#define HACE_CRYPTO_GCM_TAG      0x18
>=20
>  /* Crypto command bits */
>  #define HACE_CMD_ENCRYPT         BIT(7)
> @@ -666,7 +668,9 @@ void aspeed_test_addresses(const char *machine,
> const uint32_t base,
>  #define HACE_CMD_ECB             (0x0 << 4)
>  #define HACE_CMD_CBC             (0x1 << 4)
>  #define HACE_CMD_CTR             (0x4 << 4)
> +#define HACE_CMD_GCM             (0x5 << 4)
>  #define HACE_CMD_AES128          (0x0 << 2)
> +#define HACE_CMD_AES256          (0x2 << 2)
>=20
>  /* Context buffer layout: IV (DES at +8), key at +0x10 */
>  #define HACE_CTX_KEY_OFFSET      0x10
> @@ -794,6 +798,59 @@ static const uint8_t tdes_ctr_ctext[8] =3D {  static=
 const
> uint8_t tdes_ctr_ivout[8] =3D {
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
>=20
> +/*
> + * aes_gcm_tv_template[2] (AES-128) and [9] (AES-256), from the McGrew
> +& Viega
> + * GCM spec (also NIST SP 800-38D), no AAD. Both cases share this
> plaintext/IV.
> + */
> +static const uint8_t aes_gcm_ptext[64] =3D {
> +    0xd9, 0x31, 0x32, 0x25, 0xf8, 0x84, 0x06, 0xe5,
> +    0xa5, 0x59, 0x09, 0xc5, 0xaf, 0xf5, 0x26, 0x9a,
> +    0x86, 0xa7, 0xa9, 0x53, 0x15, 0x34, 0xf7, 0xda,
> +    0x2e, 0x4c, 0x30, 0x3d, 0x8a, 0x31, 0x8a, 0x72,
> +    0x1c, 0x3c, 0x0c, 0x95, 0x95, 0x68, 0x09, 0x53,
> +    0x2f, 0xcf, 0x0e, 0x24, 0x49, 0xa6, 0xb5, 0x25,
> +    0xb1, 0x6a, 0xed, 0xf5, 0xaa, 0x0d, 0xe6, 0x57,
> +    0xba, 0x63, 0x7b, 0x39, 0x1a, 0xaf, 0xd2, 0x55 }; static const
> +uint8_t aes_gcm_iv[12] =3D {
> +    0xca, 0xfe, 0xba, 0xbe, 0xfa, 0xce, 0xdb, 0xad,
> +    0xde, 0xca, 0xf8, 0x88 };
> +
> +/* aes_gcm_tv_template[2] (AES-128) */
> +static const uint8_t aes128_gcm_key[16] =3D {
> +    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,
> +    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 }; static const
> +uint8_t aes128_gcm_ctext[64] =3D {
> +    0x42, 0x83, 0x1e, 0xc2, 0x21, 0x77, 0x74, 0x24,
> +    0x4b, 0x72, 0x21, 0xb7, 0x84, 0xd0, 0xd4, 0x9c,
> +    0xe3, 0xaa, 0x21, 0x2f, 0x2c, 0x02, 0xa4, 0xe0,
> +    0x35, 0xc1, 0x7e, 0x23, 0x29, 0xac, 0xa1, 0x2e,
> +    0x21, 0xd5, 0x14, 0xb2, 0x54, 0x66, 0x93, 0x1c,
> +    0x7d, 0x8f, 0x6a, 0x5a, 0xac, 0x84, 0xaa, 0x05,
> +    0x1b, 0xa3, 0x0b, 0x39, 0x6a, 0x0a, 0xac, 0x97,
> +    0x3d, 0x58, 0xe0, 0x91, 0x47, 0x3f, 0x59, 0x85 }; static const
> +uint8_t aes128_gcm_tag[16] =3D {
> +    0x4d, 0x5c, 0x2a, 0xf3, 0x27, 0xcd, 0x64, 0xa6,
> +    0x2c, 0xf3, 0x5a, 0xbd, 0x2b, 0xa6, 0xfa, 0xb4 };
> +
> +/* aes_gcm_tv_template[9] (AES-256) */
> +static const uint8_t aes256_gcm_key[32] =3D {
> +    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,
> +    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08,
> +    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,
> +    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 }; static const
> +uint8_t aes256_gcm_ctext[64] =3D {
> +    0x52, 0x2d, 0xc1, 0xf0, 0x99, 0x56, 0x7d, 0x07,
> +    0xf4, 0x7f, 0x37, 0xa3, 0x2a, 0x84, 0x42, 0x7d,
> +    0x64, 0x3a, 0x8c, 0xdc, 0xbf, 0xe5, 0xc0, 0xc9,
> +    0x75, 0x98, 0xa2, 0xbd, 0x25, 0x55, 0xd1, 0xaa,
> +    0x8c, 0xb0, 0x8e, 0x48, 0x59, 0x0d, 0xbb, 0x3d,
> +    0xa7, 0xb0, 0x8b, 0x10, 0x56, 0x82, 0x88, 0x38,
> +    0xc5, 0xf6, 0x1e, 0x63, 0x93, 0xba, 0x7a, 0x0a,
> +    0xbc, 0xc9, 0xf6, 0x62, 0x89, 0x80, 0x15, 0xad }; static const
> +uint8_t aes256_gcm_tag[16] =3D {
> +    0xb0, 0x94, 0xda, 0xc5, 0xd9, 0x34, 0x71, 0xbd,
> +    0xec, 0x1a, 0x50, 0x22, 0x70, 0xe3, 0xcc, 0x6c };
> +
>  typedef struct CryptTest {
>      QCryptoCipherMode mode;
>      QCryptoCipherAlgo alg;
> @@ -801,10 +858,13 @@ typedef struct CryptTest {
>      const uint8_t *iv_out;
>      const uint8_t *ptext;
>      const uint8_t *ctext;
> +    /* expected GCM authentication tag, or NULL for non-AEAD modes */
> +    const uint8_t *tag;
>      const uint8_t *key;
>      const uint8_t *iv;
>      const char *name;
>      size_t keylen;
> +    size_t taglen;
>      /* algorithm | mode | key size selection */
>      uint32_t cmd;
>      size_t ivlen;
> @@ -927,6 +987,36 @@ static const CryptTest crypt_tests[] =3D {
>          .iv_out =3D tdes_ctr_ivout,
>          .len =3D sizeof(tdes_ctr_ptext),
>      },
> +    {
> +        .name =3D "aes128-gcm",
> +        .cmd =3D HACE_CMD_AES128 | HACE_CMD_GCM,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,
> +        .mode =3D QCRYPTO_CIPHER_MODE_GCM,
> +        .key =3D aes128_gcm_key,
> +        .keylen =3D sizeof(aes128_gcm_key),
> +        .iv =3D aes_gcm_iv,
> +        .ivlen =3D sizeof(aes_gcm_iv),
> +        .ptext =3D aes_gcm_ptext,
> +        .ctext =3D aes128_gcm_ctext,
> +        .tag =3D aes128_gcm_tag,
> +        .taglen =3D sizeof(aes128_gcm_tag),
> +        .len =3D sizeof(aes_gcm_ptext),
> +    },
> +    {
> +        .name =3D "aes256-gcm",
> +        .cmd =3D HACE_CMD_AES256 | HACE_CMD_GCM,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_AES_256,
> +        .mode =3D QCRYPTO_CIPHER_MODE_GCM,
> +        .key =3D aes256_gcm_key,
> +        .keylen =3D sizeof(aes256_gcm_key),
> +        .iv =3D aes_gcm_iv,
> +        .ivlen =3D sizeof(aes_gcm_iv),
> +        .ptext =3D aes_gcm_ptext,
> +        .ctext =3D aes256_gcm_ctext,
> +        .tag =3D aes256_gcm_tag,
> +        .taglen =3D sizeof(aes256_gcm_tag),
> +        .len =3D sizeof(aes_gcm_ptext),
> +    },
>  };
>=20
>  /* DRAM offsets for the crypto test source, destination and context buff=
ers. */
> @@ -944,6 +1034,8 @@ static const CryptTest crypt_tests[] =3D {
>   */
>  #define CRYPT_SG_FRAGS         3
>  #define CRYPT_SG_FRAG_STRIDE   0x1000
> +/* DRAM offset for the AES-GCM authentication tag write buffer. */
> +#define CRYPT_OFF_TAG          0x60000
>=20
>  /* Describes one registered crypto test (qtest_add_data_func() data poin=
ter).
> */  typedef struct AspeedCryptoTest { @@ -964,6 +1056,8 @@ static uint32_=
t
> crypt_mode_flag(uint32_t cmd)
>          return CRYPT_MODE_CBC;
>      case HACE_CMD_CTR:
>          return CRYPT_MODE_CTR;
> +    case HACE_CMD_GCM:
> +        return CRYPT_MODE_GCM;
>      default:
>          return 0;
>      }
> @@ -1109,6 +1203,47 @@ static void crypt_run_sg(QTestState *s, uint32_t
> base, uint64_t dram,
>      crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);  }
>=20
> +/*
> + * Run one AES-GCM operation in scatter-gather mode: like
> +crypt_run_sg() but
> + * also program the tag write buffer (HACE18) with no associated data,
> +and read
> + * the authentication tag back into @out_tag.
> + */
> +static void crypt_run_gcm(QTestState *s, uint32_t base, uint64_t dram,
> +                          const CryptTest *t, bool encrypt, uint8_t *out=
,
> +                          uint8_t *out_tag) {
> +    const uint8_t *in =3D encrypt ? t->ptext : t->ctext;
> +    uint64_t src_sg =3D dram + CRYPT_OFF_SRC_SG;
> +    uint64_t dst_sg =3D dram + CRYPT_OFF_DST_SG;
> +    uint64_t ctx =3D dram + CRYPT_OFF_CTX;
> +    uint32_t cmd =3D t->cmd | HACE_CMD_ISR_EN |
> HACE_CMD_SRC_SG_CTRL |
> +                   HACE_CMD_DST_SG_CTRL;
> +
> +    if (encrypt) {
> +        cmd |=3D HACE_CMD_ENCRYPT;
> +    }
> +
> +    crypt_write_ctx(s, ctx, t);
> +    crypt_make_sg(s, dram, CRYPT_OFF_SRC, src_sg, in, t->len);
> +    crypt_make_sg(s, dram, CRYPT_OFF_DST, dst_sg, NULL, t->len);
> +
> +    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src_sg);
> +    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst_sg);
> +    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);
> +    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);
> +    qtest_writel(s, base + HACE_CRYPTO_GCM_ADD_LEN, 0);
> +    qtest_writel(s, base + HACE_CRYPTO_GCM_TAG,
> +                 (uint32_t)(dram + CRYPT_OFF_TAG));
> +    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);
> +
> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR,
> =3D=3D,
> +                    HACE_CRYPTO_ISR);
> +    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);
> +
> +    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);
> +    qtest_memread(s, dram + CRYPT_OFF_TAG, out_tag, t->taglen); }
> +
>  static void aspeed_test_crypto(const void *data)  {
>      const AspeedCryptoTest *c =3D data;
> @@ -1145,6 +1280,29 @@ static void aspeed_test_crypto(const void *data)
>      qtest_quit(s);
>  }
>=20
> +static void aspeed_test_crypto_gcm(const void *data) {
> +    const AspeedCryptoTest *c =3D data;
> +    const CryptTest *t =3D &crypt_tests[c->index];
> +    QTestState *s =3D qtest_init(c->machine);
> +    uint8_t out[64];
> +    uint8_t tag[16];
> +
> +    g_assert_cmpuint(t->len, <=3D, sizeof(out));
> +
> +    /* Encrypt: ptext -> ctext, then check the authentication tag. */
> +    crypt_run_gcm(s, c->base, c->dram, t, true, out, tag);
> +    g_assert_cmpmem(out, t->len, t->ctext, t->len);
> +    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);
> +
> +    /* Decrypt: ctext -> ptext, the recomputed tag must match. */
> +    crypt_run_gcm(s, c->base, c->dram, t, false, out, tag);
> +    g_assert_cmpmem(out, t->len, t->ptext, t->len);
> +    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);
> +
> +    qtest_quit(s);
> +}
> +
>  void aspeed_add_crypto_tests(const char *prefix, const char *machine,
>                               uint32_t base, uint64_t dram, uint32_t
> modes,
>                               bool sg)
> @@ -1152,6 +1310,7 @@ void aspeed_add_crypto_tests(const char *prefix,
> const char *machine,
>      int i;
>=20
>      for (i =3D 0; i < ARRAY_SIZE(crypt_tests); i++) {
> +        bool is_gcm =3D crypt_tests[i].mode =3D=3D
> QCRYPTO_CIPHER_MODE_GCM;
>          g_autofree char *path =3D NULL;
>          AspeedCryptoTest *t;
>=20
> @@ -1173,7 +1332,9 @@ void aspeed_add_crypto_tests(const char *prefix,
> const char *machine,
>          t->dram =3D dram;
>          t->index =3D i;
>          t->sg =3D sg;
> -        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);
> +        qtest_add_data_func_full(path, t,
> +                                 is_gcm ? aspeed_test_crypto_gcm :
> +                                 aspeed_test_crypto, g_free);
>      }
>  }
>=20
> diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-t=
est.c
> index 508a34dd6c..3f0217d635 100644
> --- a/tests/qtest/ast2700-hace-test.c
> +++ b/tests/qtest/ast2700-hace-test.c
> @@ -94,5 +94,14 @@ int main(int argc, char **argv)
>      qtest_add_func("ast2700/hace/sha384_accum",
> test_sha384_accum_ast2700);
>      qtest_add_func("ast2700/hace/sha256_accum",
> test_sha256_accum_ast2700);
>=20
> +    /*
> +     * The AST2700 crypto engine uses scatter-gather with 64-bit DMA and
> adds
> +     * AES-GCM on top of the ECB/CBC/CTR modes shared with the
> AST2600.
> +     */
> +    aspeed_add_crypto_tests("ast2700", "-machine ast2700-evb",
> 0x12070000,
> +                            0x400000000,
> +                            CRYPT_MODE_ECB | CRYPT_MODE_CBC |
> CRYPT_MODE_CTR |
> +                            CRYPT_MODE_GCM, true);
> +
>      return g_test_run();
>  }
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

