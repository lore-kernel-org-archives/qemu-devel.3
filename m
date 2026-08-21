Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE46C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 02:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFNr-0001pc-7x; Thu, 20 Aug 2026 22:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFNp-0001pM-0H; Thu, 20 Aug 2026 22:53:29 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFNm-0006zI-UW; Thu, 20 Aug 2026 22:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1BOnnRNyj9+01nSGbH+s8t4CpE/9O3uh4BXmeckrpE56rJnFV+nOILm5O6ixHEVwPV5oIN/shvPw4ogaVtbbWdvQ3/Zxu7b2+85erCoYNp0IfTrn84WlQl8um/+rFOqmagxJNP0NQvRln7oTvXensws5hWGASjnPX8wu9vEHCd3QvpEZSz72UPuW6WtisayiVk43mSQVUQeubo7Ao/wPh0N8p+kC8yBgDUfcA0jeoSiW7MPRM9vVGGe8njDZqaMXOrGkkYFVNs67WvKufoqTfmOA7z6qZV9vjbWtE22kRp4I1hoXiEZxkldz4Oh6pS/GL2A1j20KDZTdmzdAegZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6pgd4bp+Q72+cwLDAR9+r1eM8tIZC9mcxXQjAyMnn8=;
 b=KYvy/wkG1r8QB17hATMVK2rDbSAusDG26F7yEeVGkUmBu4f2LpRe8NnxNYpm0ulAOtHLidFRW6KuE8ZznEcN62+5uCU1UrnjzeT1WCunJ3ZJgoNmY04dZgmbmr/x91RKE8YtYpQpBvnmztnnX0azILZNkun9nfOKv8eiSAvoskjihRhvQDT9EWy7kUxe+CdjWHo6u5Nfx/l6pfHYBP4VtXxjjiQXMujMP9H86ecjb0qvw21wnBMRrVaQklyVMw/JtF5D4NWPRE/R3o4pstuXvrq8YwcVUgnnXU6JcIUhFBwgI5aT6Ksuzns7bldjQT/EDX2G89WlQpZXHkdpDWWDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6pgd4bp+Q72+cwLDAR9+r1eM8tIZC9mcxXQjAyMnn8=;
 b=AT4rmx7dC+AkZxsa3acg09/Ov0JpAOORQvJJdlW7Xv8zbps5xYs/IUTlm2glBfkEwmLdxKd8uz9HEb//B4+kK3ZRojk7n8KmEIIrwZKq88iPi4UU9EMQf/s5lHa6FnNjJzsCVqk8/EIzMCi0cGwJooTYivO+pyQO9GW6TXhhc4WdoHABdh/3mZM+YwD8iNJTs2gj2PYHqU81IEQd5lhVAJTS0p3u/inl4ga+20vGlNh07TG8B+sQpmyf1ZNoZrLk7FoSyzTmSXw1lb/gqtjLyycz5eoOfvm8DXaM1k4NzFwc9N00rRrqgAtle7E0NXp9YDg3mM1cQFWrXzSKsD1iUw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5664.apcprd06.prod.outlook.com (2603:1096:400:284::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 02:53:16 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 02:53:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Markus Armbruster <armbru@redhat.com>
CC: =?iso-8859-1?Q?Daniel_P=2EBerrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/8] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Topic: [PATCH v1 1/8] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Index: AQHdLvMlLO0xzXFb20GZfwuaSkpR/ramqPTfgAEpXyA=
Date: Fri, 21 Aug 2026 02:53:16 +0000
Message-ID: <TYZPR06MB4980C8E8A5ECC93775366A7DFCA32@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
 <20260818092249.602137-2-jamin_lin@aspeedtech.com>
 <87h5kp2m8i.fsf@pond.sub.org>
In-Reply-To: <87h5kp2m8i.fsf@pond.sub.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5664:EE_
x-ms-office365-filtering-correlation-id: ef3a0f21-f488-4c05-c3e9-08deff2f599d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|4143699003|56012099006|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info: XxAYZ41pKdQ2Ee/luU9P3s3xTwUcdmypwd8KCpnPl3J6ezCq73jE+CB6BxRXRpTY0d2lhyZsutQzxaTjuLZATzw6N78ngqyuaaKCnla3xAZP1xyMUT3ojenk4RNP0nZPqkuBwvbBYk2CELC1RV5dncMEERgFYjZ6tbXHi9/+n9DKCuB0FlugLw/5Wd7N9jtbjaf9DJZ2Uag3mUl56qa7AzKWyz0nd3wjQIb2xUpi1sW82a5nn/sqys7QdTnZlaTWnRYT0EFRIpRFBr6iUyWbDvYIGfdhW8o3yyQr/Ud+gO9VK+lx/BWop1xAWMasvwTrZ7tg2Bq8qn1Ps4cxkdCCYXLRKFb34o+/c5aeAiH3IPotuNJp/vvl3qTVlpMhBv150u0zdarVKKrwTr5UEBAJlR9stsMFTF3mAsgucXSAZCFse8czE1lxsFvqe7y5emCivO5Jm/V3ukxb1lD8dVD2VixyiIQzaA1o85LmyGZx3wiLqn0Rp5cWXzBI/Q/aqQ+CSkHLn3/Brxe1s96UoZhmOWjvztfsZisYoI7d7eiuh98xJQSEXiJm7zeGy/LnuYccfJhj7Y0uOL2Z3IyCvrfH73ZXeOMa/Sgm2MPFV/jQEOHobPblgOQFnCqdtlKppaedY1rhP6VMTp6Jt9guSFwtT65gGPJ0U+uALN2aCRwIsot23e9+XqA2Byr2s2mfZ9Ji1zzrfT+VfsTQ5RF7p7DSJoxKghkJlxKqxmxgfUNtWVg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(3023799007)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AIUzZUpT/RXOI0/kWILHwnA98OyMTJETpccx5uqX5LTLwy24DlzEJeuqlE?=
 =?iso-8859-1?Q?mdeFzhPIpiERgXJR+phlIDhy6yvzA3LWhr7IqJ/+onr6gGzK1IIsjGMlGy?=
 =?iso-8859-1?Q?lBgYlaRpyaemuHpVkMD4xjkPmCj3z41GF5NeCB8pwkFNVD61cHKy/L12Bv?=
 =?iso-8859-1?Q?DBRpt7UJGL+3RGawJIoZzorv2ka5Z0gklP/X33ME6WJhphIdTMNU7WZC6E?=
 =?iso-8859-1?Q?nTf4OTyLuI3HbrtOhwo+OvRL+Pyhpe4vvXplHhLFtdWydJ0mrmFctRnR06?=
 =?iso-8859-1?Q?plJsmFhxhWX+tBMgigqVupecuJMkFK/QH8YJVEH3I/dBet0+FiMie1rEZ7?=
 =?iso-8859-1?Q?OhYXxqxGz6L8tLE7rN0ip06UyterKLjtLLQrbkWNCY366PZF22iu6qwG5A?=
 =?iso-8859-1?Q?682Ww7dBLpCBekSKgR5jHTnR8A7qYaCdVxO27k5+8veeYE+LDJBCkTjiDP?=
 =?iso-8859-1?Q?AVLCp71cE/Ng89OAmRbvXmUvNR0U+/CDogF5Lma0d6frbROLhovkY0tYu7?=
 =?iso-8859-1?Q?di4UQvFNtmECxSYnhn/vKWkwwehtpEO/No9qLUGTCDiDCH/iC7ptMgDaQT?=
 =?iso-8859-1?Q?D+A3zJDsYCZ9VTU7OAgUZbSz94tyOI8nIRqZhXWCReXF4nH4CbYAU8CF5F?=
 =?iso-8859-1?Q?41HY9wpAVHUcu2bQQ3nXAUZlTWyJgpqm4dAcpqNPmYK5ssCAWmJFxAKY18?=
 =?iso-8859-1?Q?sEKz2WJMTvecpuw0dM1k75QWaOEydSNSI0zmz7poTMrUuXFObbEftvz4HW?=
 =?iso-8859-1?Q?YZaukQGc6iKh/7g2G7oaKskcM7ryiWz+i+UUUU/8M3o8456pvn+hVNLExe?=
 =?iso-8859-1?Q?XLl/matEbQH/KSTxbOBzlGskJQsukRWYymZmjEsvJFqwCgaLU4z9z+9Iq1?=
 =?iso-8859-1?Q?73X4EDcHXgDPE7u4gN1O5zQleHlmqaAOPXCuJf/xHTjZEFD1TgkW+omHe/?=
 =?iso-8859-1?Q?eevJ3cZKwfd9kqGUYMw2JE/KBWFySLMjRQ6wkEsl60Qp964ifsBtaBEiOT?=
 =?iso-8859-1?Q?fznMZbtLnZ0GwHJiNGiJiASx1sC633aqNYWOqMAYuV7b147HUQ5TgSYprK?=
 =?iso-8859-1?Q?fAt46/SNRvgbnoIA5POhgiDyuhEaQvfQgT4J/keEVf1hz3mT41WRPYu0Jp?=
 =?iso-8859-1?Q?z592VsV2pQGXoqMrCucitS4DPvSA2TnLnI7hsOUsFKJaSeM7SA6sfF6l+C?=
 =?iso-8859-1?Q?24mPitBRXy//T3d8tK6jBonEPFxw6qVaD4phKrjbNf07XWEt1wHlUqEPHv?=
 =?iso-8859-1?Q?tEmU7EzQ9t+JdOlNrESnc3oEpN5jh4S8gWBBGF/OnXeCy6U615Shox6VCZ?=
 =?iso-8859-1?Q?/vA004WDSxVR5mcqJDTEDO/uZsq/rEGxE9rI/a4tI7YYdAnehyjlW+SeNz?=
 =?iso-8859-1?Q?2xbPOBuWglAI8HZv+pugzwggL+K83HFkI/YTbBj5YPmpq6NMraYrV0e4CN?=
 =?iso-8859-1?Q?X5qh1rf1Q862Jdl8pxPIStLkQqNRQnpSDnwvWHqiP1zWd9mrd0hJEB7f2e?=
 =?iso-8859-1?Q?+P1NAi5Zc8jJO/rM1KdmBqirBYYPoq82T8n5RtWGmGt6nL6qH2Jnff5YDX?=
 =?iso-8859-1?Q?TRzclX7VaKDlO69VyFUoXuO87w1i/XFdpI2YLIOblazZxHT/tQMb1jisUF?=
 =?iso-8859-1?Q?P91U3pYo75xIGy6KDZjE0SZXPwp8dfvaCcY1jRTgiKLRHTHwyIKG392gHa?=
 =?iso-8859-1?Q?Kj9vJjLxUh9uVju7g2yCnpxMCnfXrtKQhabNl7XWEi6wenLcLROlYcAU+c?=
 =?iso-8859-1?Q?e9iRUBfTJXa6KI3AJC7g3wXCbeeUSjapyJbCQ9pV1lv/wbCp3L1YnPs2XU?=
 =?iso-8859-1?Q?9/2I4gAhWw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ta7PeMYL+R6JDBojOFtYIJomgDfUoMC25dBaW4zUl1C3/B2hpFmqRj1vIMuv6XzDxmzOFUJmT86j1iGs3kKOKcUi3CGjsRX0/nBIntArwCu+8xfISr16L9suCB5Vn4nKfZ5YLC8KD3M2RAYjL97aOdr1XBppQHfS6wQeTEZLsUFj+AUQ7M2hQia0K7rvZMnnroebDu+Fc+dJzEu8YB52sN+68fnR/XoM35kedbvjurTVwrZLCZIJCrah2eyYg7zK08bWT4WwhjBmjfT/rOrICt1cHBfpI+U5wPixFJ5pGJ6nS1gvW9I/9kGW5UG7NPkwhoVtU3n39lF90dwPXH9qxA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3a0f21-f488-4c05-c3e9-08deff2f599d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 02:53:16.4709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohJJXpdr+wEt2OdZpdd6ZtNCTB/MUewrjLbj/m5gGKplMP/XpE2xJmAjJ7tfA97Qv997e/5ubbJlKQreAM0oY1upM2wbt1ukoJjLYqouVP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5664
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

Hi Markus,

> Subject: Re: [PATCH v1 1/8] qapi/crypto: Add ECDSA algorithm and curve id
>=20
> Jamin Lin <jamin_lin@aspeedtech.com> writes:
>=20
> > Introduce a new asymmetric cipher algorithm, ECDSA, a curve identifier
> > enum (prime256v1 / NIST P-256 and secp384r1 / NIST P-384) and the
> > per-algorithm ECDSA options. This is the QAPI groundwork consumed by
> > the crypto akcipher backends in the following patches.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>=20
> Why do you need this algorithm?  Oh, the cover letter explains.  Please a=
dd
> a suitable brief explanation to this commit message, too.
>=20
Will add
> > ---
> >  qapi/crypto.json | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/qapi/crypto.json b/qapi/crypto.json index
> > 6e3a98ff68..016d7c65bf 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -557,10 +557,26 @@
> >  #
> >  # @rsa: RSA algorithm
> >  #
> > +# @ecdsa: ECDSA algorithm
>=20
> Missing (since 11.2)
>=20
Will add

Thanks for the review and suggestions.
Jamin

> > +#
> >  # Since: 7.1
> >  ##
> >  { 'enum': 'QCryptoAkCipherAlgo',
> > -  'data': ['rsa']}
> > +  'data': ['rsa', 'ecdsa']}
> > +
> > +##
> > +# @QCryptoCurveID:
> > +#
> > +# The supported elliptic curves.
> > +#
> > +# @prime256v1: NIST P-256 curve (prime256v1) # # @secp384r1: NIST
> > +P-384 curve (secp384r1) # # Since: 11.2 ## { 'enum':
> > +'QCryptoCurveID',
> > +  'data': ['prime256v1', 'secp384r1']}
> >
> >  ##
> >  # @QCryptoAkCipherKeyType:
> > @@ -605,6 +621,18 @@
> >    'data': { 'hash-alg':'QCryptoHashAlgo',
> >              'padding-alg': 'QCryptoRSAPaddingAlgo'}}
> >
> > +##
> > +# @QCryptoAkCipherOptionsECDSA:
> > +#
> > +# Specific parameters for the ECDSA algorithm.
> > +#
> > +# @curve-id: the elliptic curve to use # # Since: 11.2 ## { 'struct':
> > +'QCryptoAkCipherOptionsECDSA',
> > +  'data': { 'curve-id': 'QCryptoCurveID' }}
> > +
> >  ##
> >  # @QCryptoAkCipherOptions:
> >  #
> > @@ -618,4 +646,5 @@
> >  { 'union': 'QCryptoAkCipherOptions',
> >    'base': { 'alg': 'QCryptoAkCipherAlgo' },
> >    'discriminator': 'alg',
> > -  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
> > +  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA',
> > +            'ecdsa': 'QCryptoAkCipherOptionsECDSA' }}
>=20
> With the missing since corrected, QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>


