Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D3C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEn-0003oR-N2; Tue, 01 Sep 2026 04:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEl-0003lf-TZ; Tue, 01 Sep 2026 04:52:59 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEj-0007Il-Dz; Tue, 01 Sep 2026 04:52:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWTvTvx5lA3Gosalqi0jAMSHtczTiUyXnt1ogZ0stEnxksKuyIIsiH6QUhZNrzLNYuukCF72IsVy+VgDdl8un4qkV6KW1QmOlHxoqe3g2FpP0ioxLh3xvQmZVRTl/M/E4EmCzJsmM1BKLKxAC6j9j0V9Lyu/3Lpf7uv0myEWJ7hvRhHHXqTf6uIk2hQOCTzxGksJ+i6ylAxTUc2PHg22zClvSGeaYaqb7WxU5k5af0LsfkyMxBl/eC+qfn7Zk/gzSOaNTiPpmmK35rM8zTKtJbVzW4XpJVBIJBRlEB51ogcaBI9SVeIeU3WMiL4Hzmc/KAjT6ukAiK6AJloUwcI13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yTNDJU4R6qA39x6psiRNQgEiFSV14bFkYLS6CHolAY=;
 b=O62Sx7m6ts3eliVnEhX63h7KlKMV5WU2YQ34Hr5nKo/ZNd3G/Kvk9xFGwXhLF9lDeY86SWUf3mYJvfXuPC77f1EOcoNbdE32/QC/DW1eR6hXNPnrrxlc5IJ8hSPHfnpZiOtX/ne3rQa/qXBFvuy/rd0+URv3G/fdjd6hPE0Pp0zl6QjzqaHOJcHHv38n4weNb2wgqz5ka+H8zqEv6W7pIvIQjOzfjDTvQ1BJ/qgx3pYr7k7Uhij1/8d8xBgk+ZkGZ23EYJS71avnHKTiOxltHIinkQF9ouyq8totFIILvJmlIrHOQwhUpIvfnvQLS1NiXNknq9L1iaFEJeAF9I/WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yTNDJU4R6qA39x6psiRNQgEiFSV14bFkYLS6CHolAY=;
 b=rd4zie/0QzXl0lSwYg9sncD1iQpd17ye6xsQgcDCIaX7XHBBluDQcVaZn99IQOV35o4+gcKrAXcPOcnSLxniMAxJjiRdpXROL/M5YzX++4mOHpUNTCkh6zBC9YbGM8zBa/DviVvwazwZdTv0/usSzon7h0Z6BOrvEDbUUcy2DZnP1Moly7XTdZi9PFYesq1DjXefl1V1+WBOSOg/1ZT8sVKO2dRi0mpNgTkq7SbAxP6mXvrKH7pnXh/tCtcCYyzibPXfFCQd+tse3/BssYcw4dAxW5dkUXoIAbjjUm6VLvYDDduYqz3rhqCozWq+WXuyu0DDeW9lnUwIuKFbzu/aOw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:52:41 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:41 +0000
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
Subject: [PATCH v4 2/9] crypto/akcipher: Support ECDSA sign/verify with gcrypt
Thread-Topic: [PATCH v4 2/9] crypto/akcipher: Support ECDSA sign/verify with
 gcrypt
Thread-Index: AQHdOe8/pufPSqmg20eA2zy9DRsPiA==
Date: Tue, 1 Sep 2026 08:52:41 +0000
Message-ID: <20260901085238.995968-3-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6871:EE_
x-ms-office365-filtering-correlation-id: bd9b41d3-30eb-4e0d-fa86-08df080661dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|3023799007|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: bMtz3il4T19VCMXDmesOHkOJXNudLlzrdxRxnAXOBpYxbZgGwg6v+t8Tile/r/0gI/1n22jIa3QNkVxo4iq4hb94zQx10e10gG/WxOYDtjoC4jzSbvkpl93uGf4O5OOji4zPt7OPVFFpq4/z52wwZHZD7CvHY3xzdAeST1MI7bw8j9En0y0MrlNDnPbeY0W4L+VsEYP624G++jEpAtoFOk811XVHfE4xLwDKukQ4iqUm/PQ7zY057KZTivr1QhKRtegxENU9551PYMAzJ8cdB1oag4Sih7c8ukqEEwFMXtW32ijWSTYQt6Ab9/c5snkIF5t5LhOXPjTmzplrBsQDnqOtttM29fh3DYtcVEFxvtVD9tASoq5GMzGy4qWmw4c1lOoNvcYsV8tLVrlIDRukHm2Z8XFRhZHHSYiZdo6P9w7Mrvn7cwiy81Oide1YYkKS4pl7IU2dqcBztcdeM2lcnWGYkTcf6wez9EmASKeAUZsJ1KuqRdzv8cTs7lVInPftYlXZyprsrllke3JV3/nQA9BtzgGDhIg5ndSWfkWl0kNpG15EYCaCJ77Ux9CsG51xrVPOe1vx6dYHKifKUtUe6T8TiYd89QwRGEzoA8kw3ctSZLoJ0Bpp28onuClGM2FtPD7+LGoKlfYjZ9GI/XX7SBmDigaNqAXPDbu8CSXORNkAjSkH26rBKzs94O+WiEu1hepH5x8k6fogPWSWrPbqLc/bRAcC/prmXNklhKRio5CoD66XXoAV19GA0pytCO/F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JX7jiHwXhx9lL59NWVDnm5T0tLRxQn1pAy9EohfMUvFweeNZD7mx1QYBTw?=
 =?iso-8859-1?Q?jy/dX+ZvMQCwSCp+TwyorSvfsXd9wZ+kQvYN/7xQqJCK+1v4qvWbRdQ5zd?=
 =?iso-8859-1?Q?RG5H7U77ZyvIKoRlMqyNi/E399DyFqGcDSzXH9YwLlIQOw/nzyIHROmNDN?=
 =?iso-8859-1?Q?l8GVBQDRynV+8A3XFqKPETjKFbRUy7RZxEI6+0WWNicgrKPjv3NGBYKLPc?=
 =?iso-8859-1?Q?04yXim+XNlkwkw5CPXeawnlXEApFXOFf8gZHglYwgw32K5mQ9iqH612Xqj?=
 =?iso-8859-1?Q?7ECRW9yizJV6DwDpFThpGz0qrphnAurHodtXIfVfNR4tEqfCDJkoaMHHNc?=
 =?iso-8859-1?Q?4J1VNUeqfOv68nuOrr7aISZk4JT017OVuGrDiyvQx3LHmAq90jjhFQCdee?=
 =?iso-8859-1?Q?WtpQTJigB6aaqzlaTJ4PRgb/hgHG6kBYqwfOf9HE9jL65n4KZQVoZC0OAj?=
 =?iso-8859-1?Q?6oo8Gp53ZMb3LwHLW76DdkSAE8cDPIDAXMJB7r+aK6AujEJaNMQYG0DAj1?=
 =?iso-8859-1?Q?22ipj6W6r1nOghuHVbS8F3FGrCt3Ji5+KLiX2wbbhz/U59RwJvRDUkgsKF?=
 =?iso-8859-1?Q?Knv7t9robLnRlutvftIRw3WTjHoiJMwqZW3LPdhr8R0FZf+tGSxryAD07N?=
 =?iso-8859-1?Q?UTqFEhnh4OTb6OvQZBV4GFFLQoOU4JKReNCSa99o+Kwqv83Fq15eGWDqvm?=
 =?iso-8859-1?Q?BtkYr4wGgaENSL7xAtPUAgj5DJF2NKoGBdaqbEMSG2ttlWm5RAy1Lrcx0p?=
 =?iso-8859-1?Q?U3SFdO+wGjCVCa7oWrAZNjHS8697qNzJWuQTlAAD9YfFUBZPNp4HzvEV0e?=
 =?iso-8859-1?Q?f0l49oRxaAp6buK/FUMWOmkcxR5nSZSZ1F+xTxFDmpuF7dWYratOpyTz7x?=
 =?iso-8859-1?Q?XUPZ4Qh8lCvWZrZP35yp8Jj1ROzg+f8wFDnXNxFdsZW+cMtycek1KTDody?=
 =?iso-8859-1?Q?cXCLdCCD7wMEj/X9WrjYMRRYKOcFyax7SsgKag1T3W1GY5k5ujEQusFrSh?=
 =?iso-8859-1?Q?SoCP8w37r5vDBHCu1Lq17GltRNolcB2rCgGexHXreQOZX2KvTw+xa30CtA?=
 =?iso-8859-1?Q?H79a8DBHK6M/ngZBd3Y1BJj7HOH5dxIPkoZ/h7uRe+5f/vdZamFA1c21Xa?=
 =?iso-8859-1?Q?UDiFtcnpglPmqMZZ3i2o5+osTUVwEadwS32e/Bl8H7GcAn8IQ5wPzhE2CK?=
 =?iso-8859-1?Q?ZC/oEiczbal+uaByZ65YKynegQ1i2gNbMurzumwr6i5/gK9EiELFiw8elA?=
 =?iso-8859-1?Q?lnW2MKZ6DLZ4huDNAkmDMd7QvWwHizcSKyqXxLIcuuxRtkGio1qmRp3Ti3?=
 =?iso-8859-1?Q?5/cJrJc9Hmz6SYY6wpbmmJfF8NupupHa0fDZs3BwmfsFaiVXMDxYw3sq4Q?=
 =?iso-8859-1?Q?jRkl5N35wpHaReoSEErSDIBE+m6iecybQIXSCB5bo4BlBSfeNK67LnqSL9?=
 =?iso-8859-1?Q?HyygSZvl97vWlegdmDP3lBBeDCTP1VJDe7w3HgzEtgj30bTBUg90gtrVyg?=
 =?iso-8859-1?Q?mpqK+TQfO+SoweY0KzFc6kXRPYtUQTcUNQHNelxyiK1hPQiOXGdVzgIQA6?=
 =?iso-8859-1?Q?PzCG/ajDgVZgtjxrqh7o2REskfORlkpyozhCgKv+Lkpwzv5TB4u/ZqWYKU?=
 =?iso-8859-1?Q?ACrcQQq2vkeHnj/uh50RG2MaTACoDwEjCzYDLyQcRMgR6w9/9wCnAxMMOb?=
 =?iso-8859-1?Q?oD+MDVeuojQ79WPa2dSl5RarylTBosetbS7Cw8SeJvw6yNbDSVCP5awh5l?=
 =?iso-8859-1?Q?FNRU8/WnTPImvY0y1b9L3J0rR+/9ublY2428eVCNdSy8B6c/FvOguTMx/y?=
 =?iso-8859-1?Q?0V/x2qVuMw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q1XvY3SIRJfzuYV1Phet3ffEOoNKeJLmu8CtSfXffjD8tT2fWiUNPvQaT0gABdpXUKtvLbvsDcABLGKbPbL/Bm/NgrHmtqUtqMiMXlWjjs5bStnK3c4o1CJSulzk0oH1MnI2DX257Ydk9tQHV02ESXXiVTQMqTE0GigxRo0KC0iQJ75Kmlv69oQAOG98pGsRW70Vt2wVs+9mw8qG7QdDUazfKru0poKGetKjt5aTYWGxn8AzzUZrxNGTrnjRp14I8ucI+LZubK61ZfPn6o8HaVcE+AHDgObuz8yv6gokK1psU8gpdbwI5eu3y7RNl48hQdi6xCW2L1VX9yJDjxi8yQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b41d3-30eb-4e0d-fa86-08df080661dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:41.4535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtcR1DhJoPezfC6VfeKO8HT+Xl3gN7IM76EHC/Las1729issZXuZgy+KoVxIDXAzqIqqHXotbqcVcBwBQcY1FGStTDpY8EYCldGDDpdz4Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6871
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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
 crypto/akcipher-gcrypt.c.inc | 340 ++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 339 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc=0A=
index bcf030fdec..3e49cc1508 100644=0A=
--- a/crypto/akcipher-gcrypt.c.inc=0A=
+++ b/crypto/akcipher-gcrypt.c.inc=0A=
@@ -36,6 +36,13 @@ typedef struct QCryptoGcryptRSA {=0A=
     QCryptoHashAlgo hash_alg;=0A=
 } QCryptoGcryptRSA;=0A=
 =0A=
+typedef struct QCryptoGcryptECDSA {=0A=
+    QCryptoAkCipher akcipher;=0A=
+    QCryptoAkCipherKeyType type;=0A=
+    gcry_sexp_t key;=0A=
+    QCryptoCurveID curve_id;=0A=
+} QCryptoGcryptECDSA;=0A=
+=0A=
 static void qcrypto_gcrypt_rsa_free(QCryptoAkCipher *akcipher)=0A=
 {=0A=
     QCryptoGcryptRSA *rsa =3D (QCryptoGcryptRSA *)akcipher;=0A=
@@ -53,6 +60,12 @@ static QCryptoGcryptRSA *qcrypto_gcrypt_rsa_new(=0A=
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
@@ -63,6 +76,10 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCip=
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
@@ -565,6 +582,317 @@ error:=0A=
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
+    if (ecdsa->type !=3D QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {=0A=
+        error_setg(errp, "ECDSA sign requires a private key");=0A=
+        return ret;=0A=
+    }=0A=
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
+    if (ecdsa->type !=3D QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC) {=0A=
+        error_setg(errp, "ECDSA verify requires a public key");=0A=
+        return ret;=0A=
+    }=0A=
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
+    ecdsa->type =3D type;=0A=
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
@@ -589,7 +917,17 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions =
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

