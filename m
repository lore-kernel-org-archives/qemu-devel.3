Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1B2C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0suU-00065H-LB; Sun, 30 Aug 2026 23:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suQ-00063x-Jr; Sun, 30 Aug 2026 23:42:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suO-0006yh-Ad; Sun, 30 Aug 2026 23:42:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHz5+ZwSjx4OfqmKDyXeHlTXut2KsCH39vGz2QErfK93/JtghqBa9sI0SLJgRfUgUmNYqLFYJpFgh2dVC4Ox49AHomnD9ilRz0KtqDm5Qdn+2+bCJ05eU8RNpeSLIOBC9LuU0wnUexD+dHXNW75ncieKf6nlqt54TocSZ78VZ20wlMbOpEf5S5WwkBqqnbDi9hgilZp30PZ8QfdaXyhHYadC2NPp4+eALsuENMax23tIJMEOJ4ae335tMXWg2jV3prWQupUBXg7Zo9dawuufSHIURw9PxLDzws9V2KF8B5UlVr3FaryOQK3FXSgVNgTZzjQrWrBsP7QJhZXVLIsWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH6DLcQAYsn4zhUtyCn2SqwcAAkm/OWCveIVdmt5VYk=;
 b=fWW/JyZX7SvChoKkv3w2rh4W2yQomIyUcp5rAA58iBw9mQfQ1FWuXwgMwWVD+F6OF4qNGJdDcF0scF4HAdxfzKw57udcbYv4Y8N/IP8mUhdHK+Hy72qhPcpKnQeAVL0LpunsK1FgdCMpxOVc7+Pt4ZNIntWj++EurYowaUTiOJOmJ371M3C4g9tRJB9Uvh8Jn2qG+LHGE1bVVELxb+X+y+/kX4++CbzNtc+mgJPJ5sXz5+sjoHYMamV5YPlTlSFzFUKcQIFtDWYeB9GpfpfVFXfXz8puygBWErXvSKBXs2/mXdZAiU7gS9IrVKal4d3OTvMf3hR1l/pyZQK7jpzW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH6DLcQAYsn4zhUtyCn2SqwcAAkm/OWCveIVdmt5VYk=;
 b=hlfVAZdCL5TvUsBlaq5Wr1O9B3bE6JvJPIHgHT2czaiSYKWaDrDdXujE8rP1BIw98E3BSs0en4PFi29KiNYjBizSUPtwhte8fJRFpbjdM/te5wVJr6EZ7n2wp+HIf5cM4i0A3zF9c1Xb43rle16wB4eyQwy1HM9m0xfUjCtXTTuWULmpW4iJpURaCJDVzOESVHkUDwrEn69a+kJKhwsCgsUC4ejZg8MeWM/UfNjX3Id5bWkHPxMahqJ1k6M5kwWl/cx78a0cpPuaLNbf6CRfUKyxgdr8Ngrg8Ao3apOiJ8jrQpnVliBHT8R9mqzYHV6mkeWZZEyAhMpX/6ySt/a6mQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6164.apcprd06.prod.outlook.com (2603:1096:820:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:41:57 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:41:57 +0000
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
Subject: [PATCH v3 2/9] crypto/akcipher: Support ECDSA sign/verify with gcrypt
Thread-Topic: [PATCH v3 2/9] crypto/akcipher: Support ECDSA sign/verify with
 gcrypt
Thread-Index: AQHdOPqs9p1XQbxZr0e3xtPZr4gAzQ==
Date: Mon, 31 Aug 2026 03:41:57 +0000
Message-ID: <20260831034153.192916-3-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6164:EE_
x-ms-office365-filtering-correlation-id: 5e823e85-b316-4f3f-ac72-08df0711ceb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: P4+3mf51gTBEZZH6K4G361g8L4VauzAhW7APtVE+w+a8WXOl9IjSMoX0VI/QvG8jNWxlAYNhFeTOUV0DndQNmaLMgr3sQswZ+1RwFr+RwcIYiRRr1kKaWRPmxEW6pBjWl/nakAsfHvHy5R/Ywf0Qfj9CWWzgVjRqDEFFLlwDpfHJB/gQw9lx0xCsVWdM0WC0fK79Bvjwq+Kb3475QSyCn+S1Ca0cDk1ffj2FEwkaDgpgmRMEJFg1XKxbRqIkH+MP+EV+Qr5v5Ad9vVfsjAVmJ2OxMv6Z84itaZl+wA/EuvrGJ4Bq1hGHAigG1DLjStiMwMmb54Od3d5xta4aGitnm+RTZNJ/NJf95dSX6Z+aZ7NFa3xEUYmN+k98Ct9DPrtD3rbCjIxegUb8yBiBMtPrMx0dZXsc6TLsW4w8qfoGYhQSJuUi+KVLgzaXtaExoUGQJgmyJJ1Op3xjbfastC/VpYtTGYMh12yztwBeO9HE0NE/mUSTFqJinReXyls9udtqW3KUO5YN9Nne3uAvfsZegTWNiGp+TaC+S9i4XmB6iN2znSjQxaF7pUnQlSapNKX+o2bz2bXfq+s+Rym1akvy1AAk0voWD3DJZz0hmAm1Hfe+LxeFJXRmFgGj91mVYv01oUxgfkwdICm3u8Fl461Nb+sGFTxtsNMIQsKrYUSDstaVGsregeDxkkxY9J5zYJ3Lmds++pMWtloja6/8WvKQPmX8OtdiHl6Vp4WLGOaGnzHi96eyBaRJTRDAcjWCZOP4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6qLnov9t24l8/gV/kVRKfam/aai1jBoiAXlGQFEU/oGejjTzPE5HqwRBgB?=
 =?iso-8859-1?Q?kAkO3TuREqBckUdeB64Bsp9jwwo8OO/u4FwJZgggpEDl2/G4EHQZOyQJF4?=
 =?iso-8859-1?Q?9XJVEutyLUDp3uXVKYwRlh+c3EHAIeWFBiFKFyoVAnSAYQQtJmJgLlIK4j?=
 =?iso-8859-1?Q?TLI4vLWk15xIgzcruHvimezrNrr79Orz9BDtRqLZb6TKxB81DubNhv9/l4?=
 =?iso-8859-1?Q?ZwgJxQfn+SNO5cC3qrKkn4gguPyOUY2KE2MF8wtdpSBfwMGoOka/h20e2b?=
 =?iso-8859-1?Q?JC1rkC9ZYsYgCV4+2RPSUAPrIPpAPKwMP5S+3d9ZyFWAgAJUy1BUJs2lQn?=
 =?iso-8859-1?Q?KaiK2wDGePlzgFp9SX2czc8nO8/qHy7LaT7OKEOA8otgwusX9J8DgRaZl5?=
 =?iso-8859-1?Q?8e7xrrZr0r8SJ5i/GMBP8cDu9QFFrArX6zjM4f497TPQPG7Rsf5LUp3vT+?=
 =?iso-8859-1?Q?TLqoZ54etkbZh4REsELc6j4uvDUHPok+AznC0hZyt8varCrMwLc+XBS1a8?=
 =?iso-8859-1?Q?Gjtj71dF1R67MHUT6R147M2n7ftVEDVVzi7vgp8JQmopW+s/V94OmMxqFt?=
 =?iso-8859-1?Q?0pvbLWyEJkEuG0N9If7F2rLa0VpxVPb88tQqPfs14GXRscYIzb0Hvg2u5V?=
 =?iso-8859-1?Q?LiUqyK4bKXUzavEsc3Qx4cmeFs2G4j6hJymYpncc1EdwlloZfeGQebtfns?=
 =?iso-8859-1?Q?AKSt/KyUL+kJ6wtjhtYZREWrfx+rE6QQrCeUSw/cWbnik827V6Es2REPFO?=
 =?iso-8859-1?Q?gyW4TKVDGIDUbyVN4xd23A1FGiZZ75HDhe6p50MP9HbmJio97tm4hz0fxV?=
 =?iso-8859-1?Q?ewrhiwYjAWk+XW6ODjyTzU9riUaFBBqPxB9db8TgW030/Tx7U2A3zeUlzW?=
 =?iso-8859-1?Q?BGMYfkMEtsKsozHxPgEKUoCxJNdxhmyMnB1mC9bT9irYbfrbjX00VOFQ+T?=
 =?iso-8859-1?Q?GGh54//jQ/QNpty9U8bRgZi5Lx3qmAO+EF7mMKxzLKBHWXU5Y/8TRVCGtq?=
 =?iso-8859-1?Q?55POcfznbXe+cSsSUjb34ByVJt3yjHh+Y5czdrQz5bUngNvVmz/7vnE/g6?=
 =?iso-8859-1?Q?nDwSrEIMtODL8HLMER7CZO5LiizY/K+G3ZvQlFW5aE0pFd73iLXW77Z0Uz?=
 =?iso-8859-1?Q?6YltuPmfyY/G1tehHHV3ClmL/WuSBztzgZgjnJgLdDVeF8b2s46FVlWQdJ?=
 =?iso-8859-1?Q?NYLBFXIqx0QipVS1WdD+LxYUSj/A0SiNPY0zTJG1byvzfOr3QGIF2OZPdA?=
 =?iso-8859-1?Q?Pfop1KKrQWpmIsxDS/pt0lswIshUtyytSMvi/z8PplBZrZRuwPEwVAaQc0?=
 =?iso-8859-1?Q?Kkbg3c3Q08Xpdn7h0WaLQypfYZGGymuPkYOfZZrAOqj90nqXmLA3LGxFQU?=
 =?iso-8859-1?Q?3bU6oJr8VT1/HvxcLa+t45vloB80mUigDUgEh6Y552I93DWHsVU7Mveo/0?=
 =?iso-8859-1?Q?/7NFQbw8roXx9kIGBpsLoEiAF3NnlbWx9kSmy3n8oMDXy7HxkZ9EZZosON?=
 =?iso-8859-1?Q?kA1Uw2Is3V/6NNPZKEGCHVASKyNr7RDd/q5JKh0sxhmcB1llxhINEwHd7S?=
 =?iso-8859-1?Q?hUNtbNcP6hrHrvt7dvhO1DT+/LAxjDAL6Ok8w5Ql7uoSz5ChjJ3L1DLFMx?=
 =?iso-8859-1?Q?uMpwVhujpd4TdidMPJ4u53Voh2ineh0DnwoYqdSKmY9p31cjS1xxFJz5Tt?=
 =?iso-8859-1?Q?mPgbSOib3x2fJAgemTwYMaoHj/6/WbA4qi0+qL7LapjUkDPAN/kkosuqcz?=
 =?iso-8859-1?Q?IBC//HJ+CugojEMswkfTqbqePw3w0vIsqTObjXlHP2Yhzjs8EqNhnozGRO?=
 =?iso-8859-1?Q?1Q8QrdbUJQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qT8QlVs9gIeJzGBmtZ/BB3q29xFvmZy/BwYvwYp7Eu0sqXclV7nzc+ZXn0sjiCWMppOVWwSGi0ImW2GfnwUXLFNfjdhmd6lGGdGfmQq93JLFyJSJrEp9XJVHD5FVmfvoQ7EqYJj3a7chFF968uIC9u+KFbQzI4i7KvpS65YggOabwhnxB7B/OggQr41DPaNuAJ3Nobhb7pbR14sHoX4KNrmsK3MrGbph9hqv/fQYj+/8b5jzz083OhZ6SEgT8S5CwzMtm3FhdRpEhK75nXmQjKG3FJGPBPTYtWczgJj79B240yiVFGiUNUv4LfBR6HqdJVCdVmwI0dchKx/vvB64Bw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e823e85-b316-4f3f-ac72-08df0711ceb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:41:57.3396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25tOdMcK2mu1PPorHNIafVD0hgnohrHKkzWhWlPtgIJLRISnMoLRnwnemVQfKciVn3kAR/4xeyU8ByY2yQ2770KXSeCSApJdIl3o9k8Rw60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6164
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

Implement ECDSA signing and verification for the gcrypt backend, for the=0A=
prime256v1 (NIST P-256) and secp384r1 (NIST P-384) curves. The=0A=
encrypt/decrypt driver ops return an error, as ECDSA is a signature=0A=
algorithm. The public key is provided as the raw affine coordinates=0A=
Qx || Qy, the private key as the raw scalar d, and the signature as the=0A=
raw pair r || s (each half the curve size, big-endian); the input to=0A=
sign/verify is a pre-computed message digest.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
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

