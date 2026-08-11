Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373DAC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcxu-00021A-UB; Mon, 10 Aug 2026 23:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtcxs-0001xs-F9; Mon, 10 Aug 2026 23:15:44 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtcxp-0005YT-84; Mon, 10 Aug 2026 23:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMTBDrj6JCGrHxj9zVzrPhhLXNXm8nCm/TFqOr9iXO7lZ7bG9kLAk4wftS0FZLyHUXU/Kt8LJhuCPeYYIxt1yzmuvG430/ckZOIUYUuyA6cciZiA5wVYfuAjfBXI2OQ5qpWm9ocypWFMUC3J3yhW5Elqd50OoxjvgtNUQoIb0wk1kdEC5ycu+VUh3DMSVJ2Nw6CYZ97QrXeh3jjQSkGf1qVuqePV2h/It4htMz5lit3Gc9iGuhF2gMfhKRd25KJ5C3NrUK93rOQF8JXq+REmheUOM333dXWnq30rdNVnSuMQngsAxlvGycEgUlXsRnYeOxRNOe1ctJ5QralQpPYgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeKxUvdwR0rD9gfKvACzciQ4EnwaxmkB/Bn5rVPub88=;
 b=vf2AOX3m3dtTY6wVXwQXtW/lEe2sj+r6c9dJD/8V4v+78fIJas1B3ziuc4+jAOgDJc4EPv4Blxa0JnpIvd4XEzrnTaX6jc/BqyLnSySj4TXxxvaWjiKpXV0sM1rbUAH5EjEHga0bvcxnaL+WatNSRBm+LwrDytr+8EOenS2b7XHUUb1XpzLRij2uDmPPLLs/GxpiyICSKHJiByHaI+0DiKOVDsRChdXTH1t6+fewyxMfJJZXIE86/lFIIiiwiNN0vUPbhjk6PtQeyE7h0TrS/YnQdrwMvrWpngBj70yDtsZ8ch5yOPYSVXMsLBcFxN0NsgAovK5IMzZrB9QBsJ5IdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeKxUvdwR0rD9gfKvACzciQ4EnwaxmkB/Bn5rVPub88=;
 b=J7tdhkL64Sqd848hgxgV13pyGSrBXw7Qw50FoR7BGkdmzCtekuVliYV2ThLj1MuS+HOxWd4CXkBtw5eB4agED0N/ef1ys3lC6vjohvqHo8mpzwjHkCbnAlYqQQYn/NDFF0prgi2SFOD9QgKBgQrDgKEYg/BpPOrgtD82jNbfElzZ4vyZ9PlWAVkiNC8OfPt3ltcs86ObzD7TsRrIVb4cbtFuFWtX9p9OXKAErN3QBL8Mc2e3xU3x2C5ULCW9oHIuQy3uIRoAuDH7BDblnVhhwZRmBsPPqNFPC1Dzb/jNFva+FJ3FeFoBSMkfyRqBDmbHnR5r5xbm7TrMh5Vr3PjIwA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB6105.apcprd06.prod.outlook.com (2603:1096:101:de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Tue, 11 Aug
 2026 03:15:33 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:15:31 +0000
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
Subject: RE: [PATCH v3 05/16] tests/qtest/aspeed-hace: Test the crypto command
 on the AST2600
Thread-Topic: [PATCH v3 05/16] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2600
Thread-Index: AQHdKT75C+K640ayakWe1cX66vGls7aYLMxA
Date: Tue, 11 Aug 2026 03:15:31 +0000
Message-ID: <SI6PR06MB76318CB68A5D38535AEA4C73F7DD2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
 <20260811031025.2784489-6-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-6-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB6105:EE_
x-ms-office365-filtering-correlation-id: d7956cbc-7c5a-48b5-e729-08def756cd40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|38070700021|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: HSlg6dWfgPwXDXOf0l8896AuDYvgy8vy+XzJRAfw6X8JOwgxMsRZUkwzfmWWW9PEfopwCFm2Tdng27Ljkkg/5Hsg/1mG20JnMn6pCFOr1Nqf5kd+sUj14/UrJhWdyQLhI6kXt8/SWgmwgDR/+Yz4sVLJZxrs0XCS77MpjFR9lH5js+DFTfySWlQwM9hd031ideglkwZbegTbHuHauy/L/RK7fiz6GT4/ItRaersmqX/dzzChV0Z/CQpURWl4VklSuVatFgc3GvvBT0DWKlOYMhZlPrWy+p3tZBMS0USfK7KINv6wP0sJt1sWfXpooT0qnbkUM2egcuz67GREpPfIFR9w0IZ8+QhJncIvcth4HNzqxoOXtw//mzpxdnNbrcD3qgJ1p7G95lxYVlE4XNcyRITv7C/+xEisCKKv1svczNKHABi6qMBINTrgoFeWDtQ/9FelQM64mKvrt4/nOMhENoAmCKAaI6k87pKi6gSJ2nLEPJm5PhMyae4E3hTkiupaWX4EQfQhM/GbhCVN6J1GoQ2qipsrU3G4o8IYs8mD3errIIrvGvgbyDv6sMIqXzK8abpa2VSQ+Mq34hGe1iKL8oYks0so+Jvxsddn9qbNOWUeLHHWBMxu75tMQeFhgklEo8kvwMihwni0FCHJGkwh/Ro+hpdBSq1mcU88hmEb7HzED0Y+BxF6Jwf0Zwt9KR/w6KgL/0Fw9WCdtGLTQOxstbIKjbdS/1oSXJEzkEbrfbXNoC7wXRbpoSPP7Y2ZozqY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?THtCnIyhob4KN78MrPnQEMPj6VLRhX35c5uCRL3i0ZmKB6COOZ1TNNlOS2?=
 =?iso-8859-1?Q?NzKMi2B7Wv79vb5IsjTnrGKZzhTpjsBeCMp+cwF4BTvT/x1lXKr7LHpW2E?=
 =?iso-8859-1?Q?UERjNQKnTbPfpGUUVCh9kpAHqhhLdApZFnEA9Ur5YiRPfHu2rl4Q8F6rwP?=
 =?iso-8859-1?Q?sHZSsLGhcJ8EdDs011JeoUyQDl9Rrwxj0JBi9ZHAjyVw5j+1QgcsToPn2E?=
 =?iso-8859-1?Q?ZmWiUT0Y47QSCYeNKzhBmihuhsKYfsCLIxA9l4ziccOQqsBLB1KLTREzie?=
 =?iso-8859-1?Q?fRqH2nBNY2D84tFxYgtEJvc+0Rqxbef2u7kavZYaBI51itukp1rQU2ODs2?=
 =?iso-8859-1?Q?4oztofAmcC+8/F1st/j1NlwbXVMFMdMidC4tIM8hyl7PE8CaZRNidZ5ctA?=
 =?iso-8859-1?Q?x3F8zIUfqd1pBy2UBqBiY/NqvleXtfYL6sI944AqYBQ7sG8hN8/zP8bpCj?=
 =?iso-8859-1?Q?iZNIhBy8Bzj1fiHu3q+wI9SNRCIJryDnMvs0kzoFYHzGY+4KmAFpstdZEO?=
 =?iso-8859-1?Q?dlg6FSR/FsAg0XyY8hanPywXgrh5Ro668aCWf5L+gAUkmxdKl0PBTaNNdy?=
 =?iso-8859-1?Q?HM/p9j12Anihld37i51DPcsh0VKoNj8r6GGpCcSFBFs+AtlTzi8wv/gu6V?=
 =?iso-8859-1?Q?NVGM5INgF7s9szBA5rJDeWDzwFRLTwxxpXr7lY27AgIIpBsBXWbtuJ7Zmh?=
 =?iso-8859-1?Q?5Z6MByd09sdMPAIeJtQ/VSgHiMn2a8D73nFf7kQkUuhKXis1Uuf0XWHH3o?=
 =?iso-8859-1?Q?pc+Wzh4ycENhWgxZYSOTllEcFLFuWD2XpS1s130gSG0pnuTAyr4xr43uS7?=
 =?iso-8859-1?Q?YC97xqDmdZZJbhdn7HitodT52vRNmH/9qFVzz3KTWkZ5QgxMbHLubSs3OO?=
 =?iso-8859-1?Q?zCAUz/xdoczvHvg/Jlq8dFcDwu+7PppTsWlVQmsn7Y6pHTpAh/dOSP6RWe?=
 =?iso-8859-1?Q?a/8eCzd55aKZRDI4mnjYuAV0+LCSiGf8qI93BcxgDLJI/aocLpXAUxewL9?=
 =?iso-8859-1?Q?vkNiBdnNZ5Bhyp8K0jaZRorRlJtdT0UdBYbxvmatVOunEMxm5j9WtcY+//?=
 =?iso-8859-1?Q?e25M1TlRdros3dF7ZRlVTraBDuQl3ROCV7uQH1CFzR2qg1Bdukiq/Fh7Cg?=
 =?iso-8859-1?Q?xyWyKg+Pk+hLZusrrcDIayloqd9MMWtokH+sKttB2Qfl0rGf+YwwOHI+l7?=
 =?iso-8859-1?Q?4vDHeE7l681ChQTi39t/I+erbs2vTyR6hp7kOOs8YyJa9mMGOf0ktj5rVX?=
 =?iso-8859-1?Q?0SIn8629rjUP1aSEE/rI3fWuSbXwKCMZuaHYDGYuCy0aMQJMwmIPITqYv9?=
 =?iso-8859-1?Q?r2DN4nEOEekxWoIbt+6rIg3Oh1BZjLpQIDynPbh9IHyGBL8C4mMR7ArT7E?=
 =?iso-8859-1?Q?jd8QTswx1l/KO58ujGxTmVO7xAIoixnyqUXOhvxHoA9e99UjRZgnaC6ePy?=
 =?iso-8859-1?Q?nRmViaiXwbiv0e2m/KXKGUTUWnfBhiSpZQtYyPfULeiNn1pJ+lw3LZ9Qza?=
 =?iso-8859-1?Q?JZX4NbxdfhCgFlswGVe4OQXiNwdXg6mgKo9fcuMvuqnYFtslJB2OYUZqYw?=
 =?iso-8859-1?Q?ALUX7dAk79U9rf/Co8jDh6PPd3TsP62R3tRsnBP0Z1gfrJeN/LHfy/jItH?=
 =?iso-8859-1?Q?mlG3yACHWi8qehFNyKowDTpwcXKwAZfSR7duapGHx8g2rlCAS1A6dV9oux?=
 =?iso-8859-1?Q?5bYuWkfU5Cgosp6P318U4bmij3ZiBAbOCtso9JzmMCBMnj4A2gF/uAk6Yx?=
 =?iso-8859-1?Q?+R59dC+YGJ+U6HahAid+u+OEw3Fow8QIKyDtHxhMFnxB3edLfqdsNWRunz?=
 =?iso-8859-1?Q?VDiVxQ4EhQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Vz93xoGpfcA/z9GeFOJuSPuHG/n+IeQAmVsB1VIeXN118xP7xGbOcW39J//HDsUOODkQa1kerpfWUS2+owe0bTwQpVGPGi1hoqYW3mF+aBD5JaBICSqta+PS7b6txWtbvHu4Bcu5i0pzpUt99HzxNGoC970bDAVqUi2kw7leMR/PZ6FsB4ipRVZUbxNKINKuUtfjJlBQ+NyfMxu2JSl1LXMj3UYv8RqrBM4/HH7hTytkyfQ6CRohOf4XxFB+FxdH7qmxfcUBEEhxSGibuzKJov/Pa7wEtSSuDApGh6Y3f8Vw7XDDzrhAXNHxO31BFZs9Z5qIakzkX2n+4J/e7xB4FA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7956cbc-7c5a-48b5-e729-08def756cd40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:15:31.5993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crCvjgimn9A/ji1+z2Rttfl/x/C5BxJ89utpnppoG6QiPw9QKbfqh2V66myVpW/ieEj0yd4jBW/o/I5scj9garxz+0fQae8o5vahilUOxZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6105
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
> Sent: Tuesday, August 11, 2026 11:11 AM
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
> Subject: [PATCH v3 05/16] tests/qtest/aspeed-hace: Test the crypto comman=
d
> on the AST2600
>=20
> Extend the crypto known-answer tests to cover the AST2600 crypto engine,
> which drives the source and destination through scatter-gather lists and =
adds
> CTR mode on top of the ECB/CBC modes shared with the AST2500.
>=20
> Add a scatter-gather runner that describes each buffer with three non-adj=
acent
> fragments to exercise the gather/scatter path, add AES/DES/3DES CTR vecto=
rs
> (verifying the counter written back to the context buffer), and give
> aspeed_add_crypto_tests() a mode mask and a scatter-gather flag so each S=
oC
> registers exactly the modes and transfer method it supports. Register the
> AST2600 with ECB/CBC/CTR in scatter-gather mode.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  tests/qtest/aspeed-hace-utils.h |   7 +-
>  tests/qtest/aspeed-hace-utils.c | 217 +++++++++++++++++++++++++++++++-
>  tests/qtest/aspeed_hace-test.c  |   8 +-
>  3 files changed, 224 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-ut=
ils.h
> index 13feaa61e4..82b0b3f93d 100644
> --- a/tests/qtest/aspeed-hace-utils.h
> +++ b/tests/qtest/aspeed-hace-utils.h
> @@ -85,15 +85,18 @@ void aspeed_test_addresses(const char *machine,
> const uint32_t base,  enum {
>      CRYPT_MODE_ECB =3D 1 << 0,
>      CRYPT_MODE_CBC =3D 1 << 1,
> +    CRYPT_MODE_CTR =3D 1 << 2,
>  };
>=20
>  /*
>   * Register the crypto known-answer tests that @modes selects (a mask of
>   * CRYPT_MODE_*) for the given machine. Each test is named
> - * "<prefix>/hace/crypto/<mode>".
> + * "<prefix>/hace/crypto/<mode>". @sg selects scatter-gather mode (used
> + by the
> + * AST2600 and later) instead of the AST2500 direct access mode.
>   */
>  void aspeed_add_crypto_tests(const char *prefix, const char *machine,
> -                             uint32_t base, uint64_t dram, uint32_t
> modes);
> +                             uint32_t base, uint64_t dram, uint32_t
> modes,
> +                             bool sg);
>=20
>  #endif /* TESTS_ASPEED_HACE_UTILS_H */
>=20
> diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-ut=
ils.c
> index 0355dd47af..f582c88ef5 100644
> --- a/tests/qtest/aspeed-hace-utils.c
> +++ b/tests/qtest/aspeed-hace-utils.c
> @@ -665,6 +665,7 @@ void aspeed_test_addresses(const char *machine,
> const uint32_t base,
>  #define HACE_CMD_OP_MODE_MASK    (0x7 << 4)
>  #define HACE_CMD_ECB             (0x0 << 4)
>  #define HACE_CMD_CBC             (0x1 << 4)
> +#define HACE_CMD_CTR             (0x4 << 4)
>  #define HACE_CMD_AES128          (0x0 << 2)
>=20
>  /* Context buffer layout: IV (DES at +8), key at +0x10 */ @@ -750,6 +751=
,49
> @@ static const uint8_t tdes_cbc_ptext[8] =3D {  static const uint8_t
> tdes_cbc_ctext[8] =3D {
>      0x0e, 0x2d, 0xb6, 0x97, 0x3c, 0x56, 0x33, 0xf4 };
>=20
> +/* aes_ctr_tv_template[0] (NIST SP800-38A F.5.1), first block */ static
> +const uint8_t aes128_ctr_key[16] =3D {
> +    0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
> +    0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c }; static const
> +uint8_t aes128_ctr_iv[16] =3D {
> +    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
> +    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff }; static const
> +uint8_t aes128_ctr_ptext[16] =3D {
> +    0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
> +    0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a }; static const
> +uint8_t aes128_ctr_ctext[16] =3D {
> +    0x87, 0x4d, 0x61, 0x91, 0xb6, 0x20, 0xe3, 0x26,
> +    0x1b, 0xef, 0x68, 0x64, 0x99, 0x0d, 0xb6, 0xce }; static const
> +uint8_t aes128_ctr_ivout[16] =3D {
> +    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
> +    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xff, 0x00 };
> +
> +/* des_ctr_tv_template[0] (Crypto++), first block */ static const
> +uint8_t des_ctr_key[8] =3D {
> +    0xc9, 0x83, 0xa6, 0xc9, 0xec, 0x0f, 0x32, 0x55 }; static const
> +uint8_t des_ctr_iv[8] =3D {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd }; static const
> +uint8_t des_ctr_ptext[8] =3D {
> +    0x50, 0xb9, 0x22, 0xae, 0x17, 0x80, 0x0c, 0x75 }; static const
> +uint8_t des_ctr_ctext[8] =3D {
> +    0x2f, 0x96, 0x06, 0x0f, 0x50, 0xc9, 0x68, 0x03 }; static const
> +uint8_t des_ctr_ivout[8] =3D {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe };
> +
> +/* des3_ede_ctr_tv_template[0] (Crypto++), first block */ static const
> +uint8_t tdes_ctr_key[24] =3D {
> +    0x9c, 0xd6, 0xf3, 0x9c, 0xb9, 0x5a, 0x67, 0x00,
> +    0x5a, 0x67, 0x00, 0x2d, 0xce, 0xeb, 0x2d, 0xce,
> +    0xeb, 0xb4, 0x51, 0x72, 0xb4, 0x51, 0x72, 0x1f }; static const
> +uint8_t tdes_ctr_iv[8] =3D {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff }; static const
> +uint8_t tdes_ctr_ptext[8] =3D {
> +    0x05, 0xec, 0x77, 0xfb, 0x42, 0xd5, 0x59, 0x20 }; static const
> +uint8_t tdes_ctr_ctext[8] =3D {
> +    0x07, 0xc2, 0x08, 0x20, 0x72, 0x1f, 0x49, 0xef }; static const
> +uint8_t tdes_ctr_ivout[8] =3D {
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> +
>  typedef struct CryptTest {
>      QCryptoCipherMode mode;
>      QCryptoCipherAlgo alg;
> @@ -841,12 +885,65 @@ static const CryptTest crypt_tests[] =3D {
>          .ctext =3D tdes_cbc_ctext,
>          .len =3D sizeof(tdes_cbc_ptext),
>      },
> +    {
> +        .name =3D "aes128-ctr",
> +        .cmd =3D HACE_CMD_AES128 | HACE_CMD_CTR,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,
> +        .mode =3D QCRYPTO_CIPHER_MODE_CTR,
> +        .key =3D aes128_ctr_key,
> +        .keylen =3D sizeof(aes128_ctr_key),
> +        .iv =3D aes128_ctr_iv,
> +        .ivlen =3D sizeof(aes128_ctr_iv),
> +        .ptext =3D aes128_ctr_ptext,
> +        .ctext =3D aes128_ctr_ctext,
> +        .iv_out =3D aes128_ctr_ivout,
> +        .len =3D sizeof(aes128_ctr_ptext),
> +    },
> +    {
> +        .name =3D "des-ctr",
> +        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_CTR,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_DES,
> +        .mode =3D QCRYPTO_CIPHER_MODE_CTR,
> +        .key =3D des_ctr_key,
> +        .keylen =3D sizeof(des_ctr_key),
> +        .iv =3D des_ctr_iv,
> +        .ivlen =3D sizeof(des_ctr_iv),
> +        .ptext =3D des_ctr_ptext,
> +        .ctext =3D des_ctr_ctext,
> +        .iv_out =3D des_ctr_ivout,
> +        .len =3D sizeof(des_ctr_ptext),
> +    },
> +    {
> +        .name =3D "des3_ede-ctr",
> +        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES |
> HACE_CMD_CTR,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_3DES,
> +        .mode =3D QCRYPTO_CIPHER_MODE_CTR,
> +        .key =3D tdes_ctr_key,
> +        .keylen =3D sizeof(tdes_ctr_key),
> +        .iv =3D tdes_ctr_iv,
> +        .ivlen =3D sizeof(tdes_ctr_iv),
> +        .ptext =3D tdes_ctr_ptext,
> +        .ctext =3D tdes_ctr_ctext,
> +        .iv_out =3D tdes_ctr_ivout,
> +        .len =3D sizeof(tdes_ctr_ptext),
> +    },
>  };
>=20
>  /* DRAM offsets for the crypto test source, destination and context buff=
ers. */
>  #define CRYPT_OFF_SRC   0x10000
>  #define CRYPT_OFF_DST   0x20000
>  #define CRYPT_OFF_CTX   0x30000
> +/* Scatter-gather list offsets (each list has CRYPT_SG_FRAGS entries).
> +*/ #define CRYPT_OFF_SRC_SG  0x40000 #define CRYPT_OFF_DST_SG
> 0x50000
> +/*
> + * The scatter-gather tests split each buffer into CRYPT_SG_FRAGS
> +fragments,
> + * each placed CRYPT_SG_FRAG_STRIDE apart so the fragments never abut.
> +The gaps
> + * make the test fail if the engine ignores the list and reads one
> +contiguous
> + * block.
> + */
> +#define CRYPT_SG_FRAGS         3
> +#define CRYPT_SG_FRAG_STRIDE   0x1000
>=20
>  /* Describes one registered crypto test (qtest_add_data_func() data poin=
ter).
> */  typedef struct AspeedCryptoTest { @@ -854,6 +951,7 @@ typedef struct
> AspeedCryptoTest {
>      uint64_t dram;
>      uint32_t base;
>      int index;
> +    bool sg;
>  } AspeedCryptoTest;
>=20
>  /* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_*
> flag. */ @@ -864,6 +962,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd=
)
>          return CRYPT_MODE_ECB;
>      case HACE_CMD_CBC:
>          return CRYPT_MODE_CBC;
> +    case HACE_CMD_CTR:
> +        return CRYPT_MODE_CTR;
>      default:
>          return 0;
>      }
> @@ -912,7 +1012,104 @@ static void crypt_run_direct(QTestState *s, uint32=
_t
> base, uint64_t dram,
>      qtest_memread(s, dst, out, t->len);  }
>=20
> -static void aspeed_test_crypto_direct(const void *data)
> +/*
> + * Byte range [*frag_off, *frag_off + *frag_len) of fragment @index
> +when an
> + * @len-byte buffer is split into CRYPT_SG_FRAGS pieces; the last piece
> +takes
> + * the remainder of an uneven split.
> + */
> +static void crypt_frag_range(uint32_t len, int index,
> +                             uint32_t *frag_off, uint32_t *frag_len) {
> +    uint32_t base =3D len / CRYPT_SG_FRAGS;
> +
> +    *frag_off =3D base * index;
> +    *frag_len =3D (index =3D=3D CRYPT_SG_FRAGS - 1) ? len - *frag_off : =
base;
> +}
> +
> +/*
> + * Scatter [in, len) across CRYPT_SG_FRAGS buffers based at @base_off
> +and spaced
> + * CRYPT_SG_FRAG_STRIDE apart, then build the SG list describing them at
> @list.
> + * When @in is NULL only the list is built (used for the destination,
> +which the
> + * engine fills in).
> + */
> +static void crypt_make_sg(QTestState *s, uint64_t dram, uint32_t base_of=
f,
> +                          uint64_t list, const uint8_t *in, uint32_t
> +len) {
> +    struct AspeedSgList sg[CRYPT_SG_FRAGS];
> +    uint32_t frag_off;
> +    uint32_t frag_len;
> +    uint64_t buf;
> +    int i;
> +
> +    for (i =3D 0; i < CRYPT_SG_FRAGS; i++) {
> +        crypt_frag_range(len, i, &frag_off, &frag_len);
> +        buf =3D dram + base_off + i * CRYPT_SG_FRAG_STRIDE;
> +
> +        if (in) {
> +            qtest_memwrite(s, buf, in + frag_off, frag_len);
> +        }
> +        sg[i].len =3D cpu_to_le32(frag_len | (i =3D=3D CRYPT_SG_FRAGS - =
1 ?
> +                                            SG_LIST_LEN_LAST :
> 0));
> +        sg[i].addr =3D cpu_to_le32((uint32_t)buf);
> +    }
> +
> +    qtest_memwrite(s, list, sg, sizeof(sg)); }
> +
> +/* Gather a scatter-gathered result back from the CRYPT_SG_FRAGS
> +buffers. */ static void crypt_gather_sg(QTestState *s, uint64_t dram, ui=
nt32_t
> base_off,
> +                            uint8_t *out, uint32_t len) {
> +    uint32_t frag_off;
> +    uint32_t frag_len;
> +    int i;
> +
> +    for (i =3D 0; i < CRYPT_SG_FRAGS; i++) {
> +        crypt_frag_range(len, i, &frag_off, &frag_len);
> +        qtest_memread(s, dram + base_off + i * CRYPT_SG_FRAG_STRIDE,
> +                      out + frag_off, frag_len);
> +    }
> +}
> +
> +/*
> + * Run one block-cipher (ECB/CBC/CTR) operation in scatter-gather mode
> +and read
> + * back the result. The source and destination are each split across
> + * CRYPT_SG_FRAGS non-adjacent DRAM buffers described by an SG list;
> +the gaps
> + * ensure the test fails if the engine ignores the list and reads one
> + * contiguous block.
> + */
> +static void crypt_run_sg(QTestState *s, uint32_t base, uint64_t dram,
> +                         const CryptTest *t, bool encrypt, uint8_t
> +*out) {
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
> +    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);
> +
> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR,
> =3D=3D,
> +                    HACE_CRYPTO_ISR);
> +    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);
> +
> +    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len); }
> +
> +static void aspeed_test_crypto(const void *data)
>  {
>      const AspeedCryptoTest *c =3D data;
>      const CryptTest *t =3D &crypt_tests[c->index]; @@ -924,7 +1121,11 @@
> static void aspeed_test_crypto_direct(const void *data)
>      g_assert_cmpuint(t->len, <=3D, sizeof(out));
>=20
>      /* Encrypt: ptext -> ctext */
> -    crypt_run_direct(s, c->base, c->dram, t, true, out);
> +    if (c->sg) {
> +        crypt_run_sg(s, c->base, c->dram, t, true, out);
> +    } else {
> +        crypt_run_direct(s, c->base, c->dram, t, true, out);
> +    }
>      g_assert_cmpmem(out, t->len, t->ctext, t->len);
>=20
>      if (t->iv_out) {
> @@ -934,14 +1135,19 @@ static void aspeed_test_crypto_direct(const void
> *data)
>      }
>=20
>      /* Decrypt: ctext -> ptext */
> -    crypt_run_direct(s, c->base, c->dram, t, false, out);
> +    if (c->sg) {
> +        crypt_run_sg(s, c->base, c->dram, t, false, out);
> +    } else {
> +        crypt_run_direct(s, c->base, c->dram, t, false, out);
> +    }
>      g_assert_cmpmem(out, t->len, t->ptext, t->len);
>=20
>      qtest_quit(s);
>  }
>=20
>  void aspeed_add_crypto_tests(const char *prefix, const char *machine,
> -                             uint32_t base, uint64_t dram, uint32_t
> modes)
> +                             uint32_t base, uint64_t dram, uint32_t
> modes,
> +                             bool sg)
>  {
>      int i;
>=20
> @@ -966,7 +1172,8 @@ void aspeed_add_crypto_tests(const char *prefix,
> const char *machine,
>          t->base =3D base;
>          t->dram =3D dram;
>          t->index =3D i;
> -        qtest_add_data_func_full(path, t, aspeed_test_crypto_direct,
> g_free);
> +        t->sg =3D sg;
> +        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);
>      }
>  }
>=20
> diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-tes=
t.c
> index 4cb4c475e9..61a3e3feb5 100644
> --- a/tests/qtest/aspeed_hace-test.c
> +++ b/tests/qtest/aspeed_hace-test.c
> @@ -224,6 +224,12 @@ int main(int argc, char **argv)
>      qtest_add_func("ast2600/hace/sha384_accum",
> test_sha384_accum_ast2600);
>      qtest_add_func("ast2600/hace/sha256_accum",
> test_sha256_accum_ast2600);
>=20
> +    /* The AST2600 crypto engine uses scatter-gather mode and adds CTR.
> */
> +    aspeed_add_crypto_tests("ast2600", "-machine ast2600-evb",
> 0x1e6d0000,
> +                            0x80000000,
> +                            CRYPT_MODE_ECB | CRYPT_MODE_CBC |
> CRYPT_MODE_CTR,
> +                            true);
> +
>      qtest_add_func("ast2500/hace/addresses", test_addresses_ast2500);
>      qtest_add_func("ast2500/hace/sha512", test_sha512_ast2500);
>      qtest_add_func("ast2500/hace/sha256", test_sha256_ast2500); @@
> -233,7 +239,7 @@ int main(int argc, char **argv)
>       * The AST2500 crypto engine uses direct access mode and supports
> ECB/CBC.
>       */
>      aspeed_add_crypto_tests("ast2500", "-machine ast2500-evb",
> 0x1e6e3000,
> -                            0x80000000, CRYPT_MODE_ECB |
> CRYPT_MODE_CBC);
> +                            0x80000000, CRYPT_MODE_ECB |
> + CRYPT_MODE_CBC, false);
>=20
>      qtest_add_func("ast2400/hace/addresses", test_addresses_ast2400);
>      qtest_add_func("ast2400/hace/sha512", test_sha512_ast2400);
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

