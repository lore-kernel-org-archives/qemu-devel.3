Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0C4C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2J-0001kf-CV; Tue, 18 Aug 2026 05:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2H-0001kB-T0; Tue, 18 Aug 2026 05:23:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2F-0001a1-Ir; Tue, 18 Aug 2026 05:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bmrw5MdXOVJebgFbcp9nxfHz/6B67D0hi74HYgDJX2EDCG1CActawcI4N9dQc66U7o6dDn92uL1trT0PQ8u0vRRJcZcOj1vswz2nlnzkmuU5n0sUQ6tLwk7yqRpz1TzkiEQ1lthkDoKEKJ4omyGCJgNxbfTk8wHV1GlDPQd8kNaPNvEySeYQpKWWkqOUC56qXof7UADXQ+LQawlb2+yTsp8MKiQiLyTEFCok9I41XQGdHweFlrmI3/XIXql7eSgTYinQv4fmeonOOVdJh/IkWj6yalgJR+rPslgTQwj8gXGgAzD5EHZ+jwZm49Uf1xbyGiqAXDRRt4gysRAE4xi2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcByvnrGLP92P0qbtGMT2jHiQaWvA8EyI4SGOW3tTQ8=;
 b=S2WLOKS+6Bp+CTpjKa4uueN8ZXGfMIyH8V6hcXBT5THioTrPAMrfYf/zpYsWvgtDgogqKMHkUWtMqJolgdvv98QPyF5K+oSIPohggaVRmXy8sWuIpfcNQRtmo1S1Q30e+HfgVD/hYycaz7GcaJgiI5DvkLCYe8BcOySejOxmORZINOtsiXdBy229h3yvWmkU/9mchJRcFhRyHVtJN+sD8nqPxyClGXbyvbtOIJ2gE6MnnVBOJU3riQNv8I2iwwdy43o1R9BtssJ6zQmY5e5k6GbtGVPYn1tyWk54+qHqEP/5mrdnnQv6exSbbrvQ6xXvbWMx6cz2f0MybRTnUmDkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcByvnrGLP92P0qbtGMT2jHiQaWvA8EyI4SGOW3tTQ8=;
 b=BggI2VXzgIli6/TnotQ6ZO3p3P9T0rqt9Q3QSJFCNkPh5FJ/I375HqArXMVBVwJAK/z9aivi4GgDZHf90BhVvIWOXblCTUEE7dUBoxw5ThAoRa08OgM5UFmIAL4HPoYmgeJP+CRmKupyEYrVveOcGKzusoltlqzw0NUzI1SQuZX3kI0raEZJQpM82i5tbqNIYWekUPMgPrAcLtnGBHGu4iPay8hi/q9nufJJRTY+fan6sQla683ZXSy9boprxlqHv/XEGqIyMq6y5pZjdmF2s/i+4MnuwZnZx8maFMmaY3+iX2zcl+h085ObgbfkaQAdzDfWKWenX+CCpRY530tqtA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:22:56 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:22:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/8] crypto/akcipher: Support ECDSA sign/verify with gcrypt
Thread-Topic: [PATCH v1 2/8] crypto/akcipher: Support ECDSA sign/verify with
 gcrypt
Thread-Index: AQHdLvMmsDSQCNtCaUmYjBvXapSSRQ==
Date: Tue, 18 Aug 2026 09:22:55 +0000
Message-ID: <20260818092249.602137-3-jamin_lin@aspeedtech.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: de334059-90dd-4abb-cb80-08defd0a4934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: GyEomv6Tbtu3Df2FMOAu3fMbXkPioio7P/9j6AkgfXOYGkks0X2lNmJKW/MW1bqmfb9U9xcxcGp035f9ytFryngvRAJlltbDwOaTZHdDrkGvArew8B1lrmRNGCKnx/7SpiIGHKnwMj+vEHqoePtd6srmrZaXAmNtB2sBfnq1LmcRc8cBEH3y4wGvKIUmBbIwf4RklD5Km/13zUa8XFehAqt72meBvhMt+dUBFcf4ZsUbVjjnvGnmP+QANd1UfdzRk8BLVZ94ZLKQnUFAvMzrcNK1OF+ID+syGIXlc/HfD3H556HpucftrTNdnXzb9KlOiRH9UZZhCe17tlxSvupHW6G195b6HOWqVILtcflByZssv55SX+Qs/FgTA7feDl+lBYuEDaPYF+aVuEYrBb0dC6QdLYQMXggBov9mXahRRiKA7+C8fUjnMAv7Jeo9btrkm43cd3V46C1U52qP1LodWuFoABCzZNuR5z4kJATXNd9ll8jn3cfLWx4tFHrrWvo3JTOaptkpqgL0BtMgYbPrA0wOiJHb0BB+wnnBScK/jZURU23muA+Nn+i9ZufZbKUdYIpmx47Afaiwtq+I/yx6Yi47QQq9pIvwSVm6ombLH6KRn1+gCpnt7PGAbTMKPMtpicz+ljrMRG02HvSCoQFkIE400kRRTCjRVHd+5iEH2PemLD+jxRAt8I04RsULLSoAFQTMFUiih8E09zGqgBxq4QsMhlZo77ePYVvr88F+KmMcPy9izSWUPwaStcqjN2UC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?99a27HdFhStJyCEcE6iZmzv7ixZltYWFS0665qtiKZYo6M6nIvOmH5HAVo?=
 =?iso-8859-1?Q?6k7bIuBGM/PeS5XW/UhEdGZop8QnE9I00wLUvdhJw2aO5c4yZgDNpF8aL9?=
 =?iso-8859-1?Q?/5bZsuhEckClZC+dErNvFp8FvjMSWunQ3X0YNlCVYSwdOxZfUq2aV1nYfi?=
 =?iso-8859-1?Q?ZIjLRnNH2SCw96HsZtkZ99pA0ZssfSexVfXAqr4loCbNm0ve5URdyho6ua?=
 =?iso-8859-1?Q?DkP7OZ5qqboYS+rtrddZoRzKqd1O9FMMA6ttAvB7tV9C4LIUmCK969LPMq?=
 =?iso-8859-1?Q?BXPyBYaTI04RZV8D+t3CXRbsKYf9wjdZKSjLBD6cGQt5mZpkergiGhokx1?=
 =?iso-8859-1?Q?S/o/t8brFq9CVUoQfA/gOvzQeVFFWjNOjk3lIInEnU4qAqeP/iqOIFhjRk?=
 =?iso-8859-1?Q?YDGB8Wq3E31lHXJA4KAkvfK58NYFdqBZOdg0W3TsQ5kZ4OrDq3+Zr4DQW6?=
 =?iso-8859-1?Q?Yb1dWhMTVwsUve0pzB2xJQCTJEdovz14Knj74kUp1dbKHk8Z35BikkL/sI?=
 =?iso-8859-1?Q?OPN5dC/NrEAB6zawiUSIWsfukqzaPmQ0ZL1gSJxValaH7T/sCHvn9cX3Zh?=
 =?iso-8859-1?Q?FM6VMuM8Dn9U1MhzJftdILaE5aBAFslUNwSjsi9Mz8yWCD3hHnskdfbv1z?=
 =?iso-8859-1?Q?ZunkZLvaffBSzgPPzDYvjUv9cLY3Q+yQpsC56niX6/5Qt6aHOJVC98QfhN?=
 =?iso-8859-1?Q?i5yHb1HQybfVIBNKUiJHUKDHdZiarRfzHOW4RqGQtpS7GqztKgFm35MrOA?=
 =?iso-8859-1?Q?vsLjvphjCMTCAqeG8zD53KwZabEnVsYyepJi/A9pwX/iEhOGys5ckRtb5k?=
 =?iso-8859-1?Q?KdiVURviNqJY0heImQU5vsWMZ8QV7FkhmBeVFT55EtK+zNnB9LxW+sjURl?=
 =?iso-8859-1?Q?hQyqiC3oXD+uGUzJdcxgslVRPDSEeRlxYzCgnpkqBudS+q7zZksm/7vsNG?=
 =?iso-8859-1?Q?5J0xjtyK/AVV77H0H32MOMqxRNfNgpsWig1/gfRWwt85V74835PyP0sPyE?=
 =?iso-8859-1?Q?nWEvbUUjMH5U5oLb10EhGUaY3NsDU7L5OlY/tk/9/49UmaCoJMty2XevIB?=
 =?iso-8859-1?Q?9gIk5KUm0Vf7CBInfA4LTsW0fJcYH5u6mKT9Xdi67Ufh5a8rqEw6WflP1a?=
 =?iso-8859-1?Q?Fe+W/qcGhvoQ/4ICxXkXSboN/xJezH1fZcbDYe8RreuZ5gMMy9qNheMN2K?=
 =?iso-8859-1?Q?LSD1s8rdfK1nPEH9molYbxsipIcP347jIe8Exv045XheSG/uWmqEM3dMkD?=
 =?iso-8859-1?Q?4CWxmT/hEMB856a5yc7h+/lPDXxUJZEPWZzgkUFK8mngNgSYs3aWwhtyq4?=
 =?iso-8859-1?Q?6mHoN0JKEifQ6hA1D0rSn0enXGqonbsIF3ywcavnJ6HWsvGbdlGSrSz4rj?=
 =?iso-8859-1?Q?iX1bmkQWiCvWlnOjiGPLs/20IdYOZqK5VpbMj1BMlHq3aLb8DDuonkbm/m?=
 =?iso-8859-1?Q?DCeeq6BMD2n9hYhtDdpxisr66nbQKV70d92MM3KJmxg36ogFNfimTUnfFb?=
 =?iso-8859-1?Q?eml8VEHO/6A/G6fGgmot47BslF2BoiS1FiilgHX2CkSCkhtzMyA38/Y1m+?=
 =?iso-8859-1?Q?vamb6Razq3Jpr0oKCesLCAB6SXBhanD+5WypIrnr5f+jI5/4rNdXPM0G8J?=
 =?iso-8859-1?Q?9EJKzb3xhw1YaKZN1IlJBbBfzUxJWbk91p2Ndy9aVnNsnl2mgl2J0Qe7d9?=
 =?iso-8859-1?Q?Bybn/ta7pRxuL+0c9QPMrr0YZaD/6IwUjzx1f1WVPUeedD6O3VQMkZEXSh?=
 =?iso-8859-1?Q?yNEDEYDY/gGQfCKxUXr+GcId0Mfkhwj3eO2wo8PqpMDe2IjBirSyTLCT2/?=
 =?iso-8859-1?Q?yNIeZKE46w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uh4l+c2k7JDdby6j1+n36jQ9h7evAc9qWqogNg0H3as05MIAoEPiHcbmTkp25Mqfe5x0jTPs662119HcbTy1BosIxA5Za5621FchKAwSJViPR8onori085rJMpQtMQLcnJoGksraZbfOJ6Vs0DosahpooBsw8eet2dqhbKAmTGpHf53Qc04TSCz5GSocSVMiaYVRXR9PQoIRQ9heTwMmJ3o3NVfU2o0X5hnRiiyUNBvW85FqeonU8OcPUqUdIFlXdTuMKBjZmE9eJ32jCn/ko3R/mh48D+dRRokOGyizLsPcJjhl5mZifucQBH8Ox3x8Dh5+18cXH83SL8Lcfi0RmA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de334059-90dd-4abb-cb80-08defd0a4934
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:22:55.2061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTvrzG9UluspXOjwwm1jq1ICghUAAzICY1CbHLbyHsijNSGo0p0s/ASj2UnCaYVELMM2mLLxYMGUAAnYUDHkmYZVHOaAgh26kKj1FH76lIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

Implement ECDSA signing and verification for the gcrypt backend, for the=0A=
prime256v1 (NIST P-256) and secp384r1 (NIST P-384) curves. The=0A=
encrypt/decrypt driver ops return an error, as ECDSA is a signature=0A=
algorithm. The public key is provided as the raw affine coordinates=0A=
Qx || Qy, the private key as the raw scalar d, and the signature as the=0A=
raw pair r || s (each half the curve size, big-endian); the input to=0A=
sign/verify is a pre-computed message digest.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 crypto/akcipher-gcrypt.c.inc | 328 ++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 327 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc=0A=
index bcf030fdec..ad8aeb7e74 100644=0A=
--- a/crypto/akcipher-gcrypt.c.inc=0A=
+++ b/crypto/akcipher-gcrypt.c.inc=0A=
@@ -36,6 +36,12 @@ typedef struct QCryptoGcryptRSA {=0A=
     QCryptoHashAlgo hash_alg;=0A=
 } QCryptoGcryptRSA;=0A=
 =0A=
+typedef struct QCryptoGcryptECDSA {=0A=
+    QCryptoAkCipher akcipher;=0A=
+    gcry_sexp_t key;=0A=
+    QCryptoCurveID curve_id;=0A=
+} QCryptoGcryptECDSA;=0A=
+=0A=
 static void qcrypto_gcrypt_rsa_free(QCryptoAkCipher *akcipher)=0A=
 {=0A=
     QCryptoGcryptRSA *rsa =3D (QCryptoGcryptRSA *)akcipher;=0A=
@@ -53,6 +59,12 @@ static QCryptoGcryptRSA *qcrypto_gcrypt_rsa_new(=0A=
     const uint8_t *key,  size_t keylen,=0A=
     Error **errp);=0A=
 =0A=
+static QCryptoGcryptECDSA *qcrypto_gcrypt_ecdsa_new(=0A=
+    const QCryptoAkCipherOptionsECDSA *opt,=0A=
+    QCryptoAkCipherKeyType type,=0A=
+    const uint8_t *key,  size_t keylen,=0A=
+    Error **errp);=0A=
+=0A=
 QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,=
=0A=
                                       QCryptoAkCipherKeyType type,=0A=
                                       const uint8_t *key, size_t keylen,=
=0A=
@@ -63,6 +75,10 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCip=
herOptions *opts,=0A=
         return (QCryptoAkCipher *)qcrypto_gcrypt_rsa_new(=0A=
             &opts->u.rsa, type, key, keylen, errp);=0A=
 =0A=
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:=0A=
+        return (QCryptoAkCipher *)qcrypto_gcrypt_ecdsa_new(=0A=
+            &opts->u.ecdsa, type, key, keylen, errp);=0A=
+=0A=
     default:=0A=
         error_setg(errp, "Unsupported algorithm: %u", opts->alg);=0A=
         return NULL;=0A=
@@ -565,6 +581,306 @@ error:=0A=
 }=0A=
 =0A=
 =0A=
+/*=0A=
+ * ECDSA support (sign and verify)=0A=
+ *=0A=
+ * Keys and signatures use raw big-endian formats:=0A=
+ *   - public key: Qx || Qy, each 'coord_len' bytes=0A=
+ *   - private key: the scalar d, 'coord_len' bytes=0A=
+ *   - signature: r || s, each 'coord_len' bytes=0A=
+ *   - the input to sign/verify is a raw message digest=0A=
+ */=0A=
+static const char *qcrypto_gcrypt_ecdsa_curve_name(QCryptoCurveID curve_id=
)=0A=
+{=0A=
+    switch (curve_id) {=0A=
+    case QCRYPTO_CURVE_ID_PRIME256V1:=0A=
+        return "NIST P-256";=0A=
+=0A=
+    case QCRYPTO_CURVE_ID_SECP384R1:=0A=
+        return "NIST P-384";=0A=
+=0A=
+    default:=0A=
+        return NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static size_t qcrypto_gcrypt_ecdsa_coord_len(QCryptoCurveID curve_id)=0A=
+{=0A=
+    switch (curve_id) {=0A=
+    case QCRYPTO_CURVE_ID_PRIME256V1:=0A=
+        return 32;=0A=
+=0A=
+    case QCRYPTO_CURVE_ID_SECP384R1:=0A=
+        return 48;=0A=
+=0A=
+    default:=0A=
+        return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void qcrypto_gcrypt_ecdsa_free(QCryptoAkCipher *akcipher)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa =3D (QCryptoGcryptECDSA *)akcipher;=0A=
+    if (!ecdsa) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    gcry_sexp_release(ecdsa->key);=0A=
+    g_free(ecdsa);=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_encrypt(QCryptoAkCipher *akcipher,=0A=
+                                        const void *in, size_t in_len,=0A=
+                                        void *out, size_t out_len,=0A=
+                                        Error **errp)=0A=
+{=0A=
+    error_setg(errp, "ECDSA does not support encryption");=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_decrypt(QCryptoAkCipher *akcipher,=0A=
+                                        const void *in, size_t in_len,=0A=
+                                        void *out, size_t out_len,=0A=
+                                        Error **errp)=0A=
+{=0A=
+    error_setg(errp, "ECDSA does not support decryption");=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Write an MPI into a fixed-length, big-endian, left-zero-padded buffer.=
=0A=
+ *=0A=
+ * gcry_mpi_print(GCRYMPI_FMT_USG) emits only the minimal number of bytes =
(it=0A=
+ * drops leading zeros), but an ECDSA r/s component must occupy exactly th=
e=0A=
+ * curve size. Zero-fill the leading bytes and right-align the value, so a=
=0A=
+ * component whose most significant byte is zero still lands at the correc=
t=0A=
+ * offset in the r || s output.=0A=
+ *=0A=
+ * Returns -1 if the value does not fit in 'len' bytes.=0A=
+ */=0A=
+static int qcrypto_gcrypt_mpi_to_buf(gcry_mpi_t mpi, uint8_t *buf, size_t =
len)=0A=
+{=0A=
+    size_t nbytes =3D (gcry_mpi_get_nbits(mpi) + 7) / 8;=0A=
+=0A=
+    if (nbytes > len) {=0A=
+        return -1;=0A=
+    }=0A=
+    memset(buf, 0, len - nbytes);=0A=
+    gcry_mpi_print(GCRYMPI_FMT_USG, buf + (len - nbytes), nbytes, NULL, mp=
i);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_sign(QCryptoAkCipher *akcipher,=0A=
+                                     const void *in, size_t in_len,=0A=
+                                     void *out, size_t out_len,=0A=
+                                     Error **errp)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa =3D (QCryptoGcryptECDSA *)akcipher;=0A=
+    size_t coord_len =3D qcrypto_gcrypt_ecdsa_coord_len(ecdsa->curve_id);=
=0A=
+    gcry_sexp_t dgst_sexp =3D NULL;=0A=
+    gcry_sexp_t sig_sexp =3D NULL;=0A=
+    gcry_sexp_t r_sexp =3D NULL;=0A=
+    gcry_sexp_t s_sexp =3D NULL;=0A=
+    gcry_mpi_t r_mpi =3D NULL;=0A=
+    gcry_mpi_t s_mpi =3D NULL;=0A=
+    gcry_error_t err;=0A=
+    int ret =3D -1;=0A=
+=0A=
+    if (in_len =3D=3D 0 || in_len > akcipher->max_dgst_len) {=0A=
+        error_setg(errp, "Invalid digest length %zu", in_len);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    if (out_len < coord_len * 2) {=0A=
+        error_setg(errp, "Signature buffer length %zu is less than %zu",=
=0A=
+                   out_len, coord_len * 2);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_sexp_build(&dgst_sexp, NULL,=0A=
+                          "(data (flags raw) (value %b))",=0A=
+                          (int)in_len, in);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build digest: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_pk_sign(&sig_sexp, dgst_sexp, ecdsa->key);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to make signature: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    /* S-expression of signature: (sig-val (ecdsa (r r-mpi) (s s-mpi))) */=
=0A=
+    r_sexp =3D gcry_sexp_find_token(sig_sexp, "r", 0);=0A=
+    s_sexp =3D gcry_sexp_find_token(sig_sexp, "s", 0);=0A=
+    if (!r_sexp || !s_sexp) {=0A=
+        error_setg(errp, "Invalid signature result");=0A=
+        goto cleanup;=0A=
+    }=0A=
+    r_mpi =3D gcry_sexp_nth_mpi(r_sexp, 1, GCRYMPI_FMT_USG);=0A=
+    s_mpi =3D gcry_sexp_nth_mpi(s_sexp, 1, GCRYMPI_FMT_USG);=0A=
+    if (!r_mpi || !s_mpi) {=0A=
+        error_setg(errp, "Invalid signature result");=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    /* output is r || s, each zero-padded to the curve size */=0A=
+    if (qcrypto_gcrypt_mpi_to_buf(r_mpi, out, coord_len) < 0 ||=0A=
+        qcrypto_gcrypt_mpi_to_buf(s_mpi, (uint8_t *)out + coord_len,=0A=
+                                  coord_len) < 0) {=0A=
+        error_setg(errp, "Signature component is too large");=0A=
+        goto cleanup;=0A=
+    }=0A=
+    ret =3D coord_len * 2;=0A=
+=0A=
+cleanup:=0A=
+    gcry_sexp_release(dgst_sexp);=0A=
+    gcry_sexp_release(sig_sexp);=0A=
+    gcry_sexp_release(r_sexp);=0A=
+    gcry_sexp_release(s_sexp);=0A=
+    gcry_mpi_release(r_mpi);=0A=
+    gcry_mpi_release(s_mpi);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_verify(QCryptoAkCipher *akcipher,=0A=
+                                       const void *in, size_t in_len,=0A=
+                                       const void *in2, size_t in2_len,=0A=
+                                       Error **errp)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa =3D (QCryptoGcryptECDSA *)akcipher;=0A=
+    size_t coord_len =3D qcrypto_gcrypt_ecdsa_coord_len(ecdsa->curve_id);=
=0A=
+    gcry_sexp_t sig_sexp =3D NULL;=0A=
+    gcry_sexp_t dgst_sexp =3D NULL;=0A=
+    gcry_error_t err;=0A=
+    int ret =3D -1;=0A=
+=0A=
+    /* signature is r || s */=0A=
+    if (in_len !=3D coord_len * 2) {=0A=
+        error_setg(errp, "Signature length %zu is not %zu",=0A=
+                   in_len, coord_len * 2);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    if (in2_len =3D=3D 0 || in2_len > akcipher->max_dgst_len) {=0A=
+        error_setg(errp, "Invalid digest length %zu", in2_len);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_sexp_build(&sig_sexp, NULL,=0A=
+                          "(sig-val (ecdsa (r %b) (s %b)))",=0A=
+                          (int)coord_len, in,=0A=
+                          (int)coord_len, (const uint8_t *)in + coord_len)=
;=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build signature: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_sexp_build(&dgst_sexp, NULL,=0A=
+                          "(data (flags raw) (value %b))",=0A=
+                          (int)in2_len, in2);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build digest: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_pk_verify(sig_sexp, dgst_sexp, ecdsa->key);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to verify signature: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+    ret =3D 0;=0A=
+=0A=
+cleanup:=0A=
+    gcry_sexp_release(sig_sexp);=0A=
+    gcry_sexp_release(dgst_sexp);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+QCryptoAkCipherDriver gcrypt_ecdsa =3D {=0A=
+    .encrypt =3D qcrypto_gcrypt_ecdsa_encrypt,=0A=
+    .decrypt =3D qcrypto_gcrypt_ecdsa_decrypt,=0A=
+    .sign =3D qcrypto_gcrypt_ecdsa_sign,=0A=
+    .verify =3D qcrypto_gcrypt_ecdsa_verify,=0A=
+    .free =3D qcrypto_gcrypt_ecdsa_free,=0A=
+};=0A=
+=0A=
+static QCryptoGcryptECDSA *qcrypto_gcrypt_ecdsa_new(=0A=
+    const QCryptoAkCipherOptionsECDSA *opt,=0A=
+    QCryptoAkCipherKeyType type,=0A=
+    const uint8_t *key, size_t keylen,=0A=
+    Error **errp)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa;=0A=
+    const char *curve_name =3D qcrypto_gcrypt_ecdsa_curve_name(opt->curve_=
id);=0A=
+    size_t coord_len =3D qcrypto_gcrypt_ecdsa_coord_len(opt->curve_id);=0A=
+    g_autofree uint8_t *point =3D NULL;=0A=
+    gcry_error_t err;=0A=
+=0A=
+    if (!curve_name || coord_len =3D=3D 0) {=0A=
+        error_setg(errp, "Unsupported curve id: %u", opt->curve_id);=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    ecdsa =3D g_new0(QCryptoGcryptECDSA, 1);=0A=
+    ecdsa->akcipher.driver =3D &gcrypt_ecdsa;=0A=
+    ecdsa->curve_id =3D opt->curve_id;=0A=
+    ecdsa->akcipher.max_dgst_len =3D coord_len;=0A=
+    ecdsa->akcipher.max_signature_len =3D coord_len * 2;=0A=
+=0A=
+    switch (type) {=0A=
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:=0A=
+        /* public key: Qx || Qy */=0A=
+        if (keylen !=3D coord_len * 2) {=0A=
+            error_setg(errp, "Public key length %zu is not %zu",=0A=
+                       keylen, coord_len * 2);=0A=
+            goto error;=0A=
+        }=0A=
+        /* build uncompressed EC point: 0x04 || Qx || Qy */=0A=
+        point =3D g_malloc(1 + keylen);=0A=
+        point[0] =3D 0x04;=0A=
+        memcpy(point + 1, key, keylen);=0A=
+        err =3D gcry_sexp_build(&ecdsa->key, NULL,=0A=
+                              "(public-key (ecc (curve %s) (q %b)))",=0A=
+                              curve_name, (int)(1 + keylen), point);=0A=
+        break;=0A=
+=0A=
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:=0A=
+        /* private key: the scalar d */=0A=
+        if (keylen !=3D coord_len) {=0A=
+            error_setg(errp, "Private key length %zu is not %zu",=0A=
+                       keylen, coord_len);=0A=
+            goto error;=0A=
+        }=0A=
+        err =3D gcry_sexp_build(&ecdsa->key, NULL,=0A=
+                              "(private-key (ecc (curve %s) (d %b)))",=0A=
+                              curve_name, (int)keylen, key);=0A=
+        break;=0A=
+=0A=
+    default:=0A=
+        error_setg(errp, "Unknown akcipher key type %d", type);=0A=
+        goto error;=0A=
+    }=0A=
+=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build ECDSA key: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto error;=0A=
+    }=0A=
+=0A=
+    return ecdsa;=0A=
+=0A=
+error:=0A=
+    qcrypto_gcrypt_ecdsa_free((QCryptoAkCipher *)ecdsa);=0A=
+    return NULL;=0A=
+}=0A=
+=0A=
 bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)=0A=
 {=0A=
     switch (opts->alg) {=0A=
@@ -589,7 +905,17 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions =
*opts)=0A=
             return false;=0A=
         }=0A=
 =0A=
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:=0A=
+        switch (opts->u.ecdsa.curve_id) {=0A=
+        case QCRYPTO_CURVE_ID_PRIME256V1:=0A=
+        case QCRYPTO_CURVE_ID_SECP384R1:=0A=
+            return true;=0A=
+=0A=
+        default:=0A=
+            return false;=0A=
+        }=0A=
+=0A=
     default:=0A=
-        return true;=0A=
+        return false;=0A=
     }=0A=
 }=0A=
-- =0A=
2.53.0=0A=

