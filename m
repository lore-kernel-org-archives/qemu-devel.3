Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B73C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK0H-0000pI-Bs; Mon, 10 Aug 2026 03:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK0C-0000o5-0B; Mon, 10 Aug 2026 03:00:52 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK0A-0007nS-GE; Mon, 10 Aug 2026 03:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKXKGfazUS29h5Bm2ZA2/E4S37Rn+TsLjtUpacpTRNg4CuOxcusTe01WB245c9ZaSe34XzCbCoH0AIWBzUR3tZN6nzaNa4l0GJ+7Z9WxCgviYqeZXZzYoSKOxjOQx0gaXjR60KF6c2o1VvMiWkBIEeXpQMQOhhdy3fzeGXiGu7ZYRX4qRuyTfu7R763UUPQ5bGxBwNlclBfhfWxvQ9dsTlsXBIUugB7OsMdFcvlmtS/+tE2hfWEMD462UYjZEePJdTC4SK6s7LbCasJBVSGj6CTnUMmgAGvEq2ekbNmuaKhr8DCUINHJjHNzzyzhxs5IUnPA/OWGf3XT5NBKnakKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY/1a3W1bvOpKgLqj1+RjHOJk/Mc2rF6MQ5m9R6ruYY=;
 b=o2nIxPvZaV9ix4ZET2IPdigS+LmaSMyANFiqKKO0H8QjQYQQsN74cxcsZtqyOKGEoeMx028Gjqtn5swI+A45Wvg9QAhK9vZYb3vey/S9yl6kiAoNuWiRAx16Q9mddLrpQ47zvIQdtUL4JY9jZFCA8NcfZzm9T3iOFUnJuwz2AkS6zxq8VUVVTDBLOxcl9Gowc7gsB79YE9Nk6c/SEUFGoq5l+AiRx5M8RK2mIJUXbfcC4NQJK2uJVR59NaIg8Q1ZnhhkUNLdsg7g9v+u/BCWDqFCzKfe0ATAZXWI/QjTvCH8Mlilu6XHQTBW3liNx7aAuCxOfYsJAhTsT0v7tYg2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY/1a3W1bvOpKgLqj1+RjHOJk/Mc2rF6MQ5m9R6ruYY=;
 b=QeDG6RqbRqXtj+qhuFrCJBYA4t854WsNiRE6vMRWqGBeYVAMlQ7aNUfjyWU4Y4/FbQM2wXnb1xV6bsYrmcgkd0CATc26THa6b9q3W5A9nyxzDKL/3urF5C9M358dF9E72noBtfNYLPhehd6qBGdMq608yE6eSVpMlFXo8E0bBYHeDn7WxbD0byGZzEOmDeue+lfCHzqrkhOnesY22+xojWBsK6ChlfFztgg9aRAHb7dFMmrHLdAsnyXyQ4xLBjhv2r/BiRmMTxCS1QT6FUCXlnvw2K1pT//FzswvIt8KxQNBZFgL1Pui0PTsn3uuhUjjdM+jHJv+WnG+o7vUSpZutw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SG2PR06MB5105.apcprd06.prod.outlook.com (2603:1096:4:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:00:45 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:00:45 +0000
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
Subject: RE: [PATCH v2 06/17] tests/qtest/aspeed-hace: Test the crypto command
 on the AST1030
Thread-Topic: [PATCH v2 06/17] tests/qtest/aspeed-hace: Test the crypto
 command on the AST1030
Thread-Index: AQHdFAqwu3qZBdvoUUyyJ1W+JSn4LLaXA8Zg
Date: Mon, 10 Aug 2026 07:00:45 +0000
Message-ID: <SI6PR06MB76313322EBE534242BA9D6FBF7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-7-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-7-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SG2PR06MB5105:EE_
x-ms-office365-filtering-correlation-id: afc2f3cc-acc6-4ad3-0d6d-08def6ad19ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|56012099006|38070700021|10067099003|4143699003|921020;
x-microsoft-antispam-message-info: x1v3Pxq95W9m5+JED1iDEcaHDMi0YMeR3Xl9BmRBZ++ZO902K6LGJj/C5AWs4vHUorMTkPGVDelPyXAEr+xuLDHdn3nnjYHLkYw1022zEJGVxrwOjGAha/TgtB9Isc1cH+0w4cKLv6HhIJOHkQZHXN2ZsjJ2Uk6A3aE4imevX1Crnb+8M0cHGN8lLVFt+youAtpjgYSniRu5n4hA0fmbn9kfb0D4SNsf1BaebHsNPD+SLDMb0R6ZfcE4N1mD2BoEZvNFY3FtVSxDQ5NbzpxSPdXCWTrH1xaHd6c2zzAQTczN1EWIIldjMym28nMHNR4Gj7zy1mFZZsgsRODdZ0/J0Gy9oX8FUDglEjmCniV7Uv9xkbE1L/mVwN59HCSkS/2TNxe0m8RlGYCVzcwwLkofSLMKyOvGvUAi+hvDfvXrObGESA9pP3Lltr9NLSM+8M5EZrcqSU/O0OlRcmMDG0XdOvTbUmLji6V9MjmABmeef0Uy8Q+RD0Xn1Ulfx5TBhEV00b9BPXw95tzl4ac3QzX9ufMK7/0/aORu2JQTTV2+Oktlj2womzRxQcy6518VrFwyC8VYs+gtK2XIT/oud2sMMfqbibqs1m+OlG7Q9uURFnhAL+SSe+19382z5fFhF5MPRu9oQqKuiRKrbZS01MRh1waVoHXUIdTu0b8jQX0UdP/BxAj759SF9GI0UQJqQ08hxGhhLPz0ndO0TJOwOJsl8r4VOxiCohBdg2udIeefEZJv9qHm4cmRL1q9CDFdKLTt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hVOVNZo8txnxNNUGeLgffZz5rjx5b6w1/9GgMGRolwBgOR4jxFmTI0s23h?=
 =?iso-8859-1?Q?5aDHHym0HkJuzBTyFnchIskjmG4aoM9gVzLDdTFC+xlt77IwN3R874pPfD?=
 =?iso-8859-1?Q?KThLFWuB9rUPiNp/ed6RN7Vi9srhW69Hs04sDEGhW8nOb5wOBQDGjGIGFu?=
 =?iso-8859-1?Q?5KoQlgXHcPlYDeCAQ27blMHEu5XeQ+DUMfduZG6pRzqD1eyS/NTUZSn5Sc?=
 =?iso-8859-1?Q?wUOMyaPXuUJw//6EwaggFLHpR4YSgaic5pHrWi3fc0A5oXbpL9YLQFrc7q?=
 =?iso-8859-1?Q?RhEBeZcaReLZkNcicIo8DrWo+Hv7/D8rWbrfuGBYnvOGsvKFAdLJ9chCes?=
 =?iso-8859-1?Q?A/uNO4ougU/zDBU3ZeFnKqSqFohgPyMeH1XBplHegZrhXl4DRxhoICGGUG?=
 =?iso-8859-1?Q?j+yaLQFQbuL2j+0C67yo3PXYp1KqAM2F6GcFkbrT4Gu3+kgyAe1oOg6wzs?=
 =?iso-8859-1?Q?KFAhqsnUiFSI+qGZuRACddhIojm5yQCk7xz/wT+i8/zDZ6bt6UXt8MSkBf?=
 =?iso-8859-1?Q?rhKPybQoNfWX4Sx8vyH1ymowHpcknmSB0DD1aDaEa9nGYZKUisoH0E8T19?=
 =?iso-8859-1?Q?9LF/qDpYeKz19Cx+uG2mV+idDdScbkmigtIRPEL4nhUDpLc2nNREso8YyZ?=
 =?iso-8859-1?Q?ajhu3M0xzIq11HB6qsrYaqOvoXPJln1aO/vZGT1WkNkFUpR/DFnmh65eBs?=
 =?iso-8859-1?Q?t2qXKoHNPi/2TMATnCaloodx+bx/X9Yonyj4lJ+sQIdHubxOnjVY3Wxy1N?=
 =?iso-8859-1?Q?/T4e9C8yHOloyl7EHqrKcfuS83pWn2Ns6i0VqqO5XYH9MuSSKPEqodLkeg?=
 =?iso-8859-1?Q?PMROK71fLAT7Pcr5EY0lV+HzM4M+/5F4/eo9FG58fLmje/oY67dX5M7odW?=
 =?iso-8859-1?Q?Js6N8N5HnAveaRByxtmTsPEA2SJCTWuA8rkMIDfP4tRihKwST4McZEjkwR?=
 =?iso-8859-1?Q?5HrCotlxKeY9TR9QbxkcgfYqWzuzj5g74xpIRABE7jR6Y9DScd4jDHEHmr?=
 =?iso-8859-1?Q?UQaOleWMBmboQ7WfiZaG+nceyuZHrPItW+Uu8THG/C45KprunfFOzopQu+?=
 =?iso-8859-1?Q?7ck7t2C6O1x5YIzCNCF1pmoaj7ZX+v2IAbZPN7q4NYLE+ClbtrG2+Kts26?=
 =?iso-8859-1?Q?B0Z9zY8gzazJSrAQxkzzt/gNLw6GDvkQZ5iaqAv4vXeFhA8bMAWU+bO+Df?=
 =?iso-8859-1?Q?eT48CjcTRmh/ixoXiLbd8wHx0pAqQirr6t8v9QRkAVUDDANq0GEaRj7lAR?=
 =?iso-8859-1?Q?iTCdQyBn/aSfGrZUzYaUewepn5EFSk0c1QU6dLrl0RaSJ4KmFJaM63vg1S?=
 =?iso-8859-1?Q?X4zqt+QB1a6yJSymrlKaBTTGIHKEQoN/NdFrgC9PEUbuYycEVbecVT3Kuf?=
 =?iso-8859-1?Q?1Y+m1dP3XXnEzzhwBT89BW3kTYKT2TotgGPy94vs5aGiB20qCnVsitIneP?=
 =?iso-8859-1?Q?EP+gkc0mCbMLZUSdwFWcPlZB5C+8mlzjjuDQkRpiZLOPPaKip0u3FgaPQD?=
 =?iso-8859-1?Q?LeQhVVSPXqVzkp0BR4IW8oSbkvskgb+b6yT+wzjaiVxaLTpBuP1WneHwP/?=
 =?iso-8859-1?Q?vtHzW8rSZ6XYhH3R8ZsqOaLhiyIJhiRou1ogXcs/XI5QiOo7dygT3wNGMK?=
 =?iso-8859-1?Q?ewa2NeGfOxgwZ29Is5D5n9ofn84s/5tEmSqe8fq9ov++5pWWYE8geyX7s3?=
 =?iso-8859-1?Q?1Qrc2K4Qk2a/6LH/BxG1mUniGPHa3dhsZu1GvTtCXN+vVCjo2tECRqC3Dw?=
 =?iso-8859-1?Q?KHmv7uVaVnD91b24s2Ts7cfIoOnCsovoPrF3k1IjITxKpMUV56otYxc0ft?=
 =?iso-8859-1?Q?qoiH1Bf2+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xi8h4ziUd8pWCFcFLqwmwJcQ2YOva5sszrMg7EOBMpJm836ziLKSgrwbSzWBIhicyxzrAo2WTFcUK4RUp+is8LfzskDM/ghfWuxSD69Qjbd38OzTN2GJC4kH/0Ft3stmjLtLGV4r5By+mb1xdG1tiGJdhCJkP3xxNGXbe5dp37bz+cgahYafO4bw1YHbCm/+nnZF0f8JxzNEV2nwlnDQgj12HdtSCbAKg9HG9cuRJL2KDCB8lfsWWH99S+fzQGi5/0+xWxAZJB5y07ZtKgu78bX1aIpPtfYV2QI2bUx57mJI17q42nWt5LU2vD66y/guPNcw+EgZ24lUt9zx9mWUlQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc2f3cc-acc6-4ad3-0d6d-08def6ad19ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:00:45.3533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPrCQwDEN6Tng6hzhhAWEHwgVTcau+V4wTkfuKreRqrN5Nfd5TWfkmOGZeAzYtcGQAOcjNLbS7wnLM1rS6/sVV6/UzKO9FR/8jUpezVqByA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5105
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
> Subject: [PATCH v2 06/17] tests/qtest/aspeed-hace: Test the crypto comman=
d
> on the AST1030
>=20
> The AST1030 reuses the AST2600 crypto engine, so it drives the same
> scatter-gather transfers and supports the same ECB/CBC/CTR modes. Reuse
> the crypto known-answer tests to cover it, registering the AST1030 with t=
he
> same modes and scatter-gather flag as the AST2600.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  tests/qtest/aspeed_hace-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-tes=
t.c
> index 61a3e3feb5..42130df1e2 100644
> --- a/tests/qtest/aspeed_hace-test.c
> +++ b/tests/qtest/aspeed_hace-test.c
> @@ -210,6 +210,12 @@ int main(int argc, char **argv)
>      qtest_add_func("ast1030/hace/sha384_accum",
> test_sha384_accum_ast1030);
>      qtest_add_func("ast1030/hace/sha256_accum",
> test_sha256_accum_ast1030);
>=20
> +    /* The AST1030 reuses the AST2600 crypto engine (scatter-gather, CTR=
).
> */
> +    aspeed_add_crypto_tests("ast1030", "-machine ast1030-evb",
> 0x7e6d0000,
> +                            0x00000000,
> +                            CRYPT_MODE_ECB | CRYPT_MODE_CBC |
> CRYPT_MODE_CTR,
> +                            true);
> +
>      qtest_add_func("ast2600/hace/addresses", test_addresses_ast2600);
>      qtest_add_func("ast2600/hace/sha512", test_sha512_ast2600);
>      qtest_add_func("ast2600/hace/sha384", test_sha384_ast2600);
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

