Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16FEC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0sud-00068H-GE; Sun, 30 Aug 2026 23:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suW-00066W-2J; Sun, 30 Aug 2026 23:42:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suT-0006yh-Vf; Sun, 30 Aug 2026 23:42:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds22S0TDb2UekcaT1MMwvCgLLbYNwpdppNvQZwmS8lEkY/Zj5z0b85Hw7iz0GQZpGxjKyE1+184SXza/9ZMIWhmtYM7lFgqI+HQd++DFCzFRxCAxr4mth3Otan1L22RYYEr8+QR4KgGAmZqoTk6rElSAZE4oDkdEIAU/KZIeHqRw9pb2Sy0keeRtpQ8XzemsHOfJ5Zi0SsSEd+mBe3ETx9xPmxETbcgN4fmwGvr+Gfrg5ActH+1Y1owD/uyaZtfbiXDKqNe35allQyYcpvOQoaNECUgcKQdot0zSGzK2lzjHJHabPdvfTG9+zftQYNvSJtTs+hKZuQmcC6f5lhRwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmExWYUhArH5VkZnV8VPWf2l7Qy0MgXSQs1kMNSueGk=;
 b=nSbCia1jSwxaD02sxjC3KrL5N+zaZPGXxmm5X8J4IX43w5qZYlJYG1FNBsfooAibNgxOYfAgNQNdiqtCpR+1gjqkC6OhAYhsWF2EobCpNEyv7Ty4zPvT7nzPIGuFq0cHGl5byds1xTojXWeK5eGtH/fCEMnOweCp8WNX3Tu0rZgGwlm4azEE2DsLIqVzYmKQFVhlJ4AcL75j7t7tTuAT8NwtX5Nqonzi6EFNRJzmkRJ+C/VYVpezUiQoit/F+rwFiudcmEiWNBidaaiQ8d5Sn/uhiJiQa9JIqLRm1FCLVXgf0R4BF3aR4FBtrI/Q+RKAtVwYdtK14hO17Ajdo1V/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmExWYUhArH5VkZnV8VPWf2l7Qy0MgXSQs1kMNSueGk=;
 b=iCL79UtiQ+NRKCnMYJ1xxw8WTxnwQp1A8d7yakjt9JYhJX7dxv+ImNiMX3xJx/YrYdxwkAf2m82jd4FguK5UkwPIzuo8C2n5LPbA2+A8oS/Aiztx2YpvFkDM6kU3kMPQodA+o/oKkqO5P+hK6OY0/xO+txPERyyy6xcoLP55X4YAqDZUm50RYdTspLaEH+A+Z8tEiHeYDMxH1MaVoVkuDJKzV+sgfR0Ac36GHQuv98f2uuToKKWd70l2mbjYHYUvRGYsTjmBs1MCCWFzt/L3nIoCZD7enn3jvw0VaH05rAuSY566jc8jGcH0ubE6VwnOsikJid3zP2gAPoFryxtCtg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6164.apcprd06.prod.outlook.com (2603:1096:820:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:41:58 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:41:58 +0000
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
Subject: [PATCH v3 3/9] crypto/akcipher: Support ECDSA sign/verify with nettle
Thread-Topic: [PATCH v3 3/9] crypto/akcipher: Support ECDSA sign/verify with
 nettle
Thread-Index: AQHdOPqs+ct8yq9840aj7tyUupEjyg==
Date: Mon, 31 Aug 2026 03:41:58 +0000
Message-ID: <20260831034153.192916-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 8d4d3001-4807-491a-d24f-08df0711cf63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|3023799007|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: PQV9avPqVfDH74YLinqRcFgF1Wv/JdWIXqS1cQ1IMxBN9YTO+Ewb3x8cJjbVQvZ0+NfTY9NFkSraJ4c7uMjDriMv5kAbbHedfxtSFekLVKqnyokYVAGLnT3xsyKKTOujkSuqKFu1nVDCEnvn5DXCXOwsUBLn5QGfHPyzpz4EJZwu1Xw3TtuMO9VeSBWIF7ymOStuePQNE/fEOTgl+N/2oKB68+6OU+pAh9ho7UIk6/yXbM+C0nn1yhed3miq5gLSJmbZgauL8P80694Xl8TADsf952qrXCd8rocSQHPntUxJDVxrVDmbyNfpWyKv5eby5cEgblgAxL/kBzToPzurkpgPPnlBzK8mBLE9CjPT1rcJ/R00qVxWEkxnj8VzbQDodxuZWlejZacsw6JP5YVV76058gvPp/ntagGkW/bkHMMWiQ8dhLlsvN4Z9frQEP7hV4V0UJ5EJOZuSkqLTcp1h1b9uuxTd+VUZrNlf5JVsNoN7S/xCVUsftoYUPgzDDjoHJL6/80dX7jijiFUjk2Ys6nC+ZMhxxMZtIZP5VYotwh1Y+bsyxd/tpaYTFLNuKfJoanfgESChbI1AUyRxLJxvdriCJLXqqEeHuH+hHpA9S9ilUNN6J7SonVXiUq2VGxRN5mwUd+c/gu7NmblEUqORTKWVHDyyuHdnevIy9RgVKQ52WIPue/If40C4wlZRq+W78A/rlJsN842n5kFP/MJ1qC0gKj6ihGdx9QxQcwAE+jHGB2eeN9TdZX8VpfpWJJE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0NK7e35p4wUw+bAYnnn5mIyRJUi212QbsIs2McPq2iD+/tHc0YLEVP3Zm0?=
 =?iso-8859-1?Q?RtstGcHzhTcIBD11fk2REWepGlftEmmg3YQg5aMOsvEIX1DSKCjUkDVZaR?=
 =?iso-8859-1?Q?6HpCpKOo+MeWZHTnmdCU3bjwREwy54iHTz/URiMR6cakstXBbSB2106YPR?=
 =?iso-8859-1?Q?HJgSCtbVZU/xmmRoKFb2GK5rNsdPBC06tRQtKceK6UUz7ucu9MDcFdsJqU?=
 =?iso-8859-1?Q?bDGSxe7zuSCyIBQ2fiOdNs/AvJWFPTEG+YnyqEeVEXDs3rqLQYxUB4CY1H?=
 =?iso-8859-1?Q?ia8SAjbq3OXAsr4zau1K8cbYVy5+L4gb969H+ah9o4PP8E52R2jasECAeO?=
 =?iso-8859-1?Q?mHOYuItlUFL1f7QIgo3CvUVo7B6nwM8G3mGEOWwamvrrv6Ez7veBwqSWGl?=
 =?iso-8859-1?Q?NT80jCNYKt2WUJTuaC35UnXbfM6gRa+7fHD8hNX4jgZJu3/5y35znOv1ax?=
 =?iso-8859-1?Q?lc+BC2s9TZTH930Fqrtp+ybX28Kg3UBCSL07UBo0WoovdPwSWZQxiG/KzD?=
 =?iso-8859-1?Q?/o2B3Gg58kPaul7RMPqlCRAneziKUDZhEyBi2INlAtH6a52ZiV59OvLn8F?=
 =?iso-8859-1?Q?Df+E0h27wHOYwzESPvKgIIU/2jamYyYHTswpdqapccgsSyjGTOf1faStqi?=
 =?iso-8859-1?Q?c6E/zjh9XfG6imG4X6jnnRPT5tVSm2pSmf5mY3ns0dl9QvyCWEvDnyTXqk?=
 =?iso-8859-1?Q?NoA9dKgY8HbaB5V3zELEfASJKr4U3ylBbrNdIz/IABtR6ffVDlNMdlVLwA?=
 =?iso-8859-1?Q?LDKtmL8Ljs/pXXJMWnLa1DI7mzJt25bXJ49PhvphLl5nN5+N/tbuyQXd4+?=
 =?iso-8859-1?Q?8PpHI464wuiRpKNKmCMFhEdctQmzb/IRxkoDxYjPZYrnp2YP99jZlTUW81?=
 =?iso-8859-1?Q?CygVhK4IBiDzOX9z60dEhObQ3hbpkyjGEEdjjWBF+wcSXVmCpreX6zrjeO?=
 =?iso-8859-1?Q?9E2PSmNbfV37npJGQoE9hr6nnhKqWsm280hVzLWhovjmqHF5d+X5UZmbf9?=
 =?iso-8859-1?Q?Fs+LeF62kLWo3z9X/cl/S1qzRpwZyKguhvMB1AmzcVCPkGgxASD2/a7zHY?=
 =?iso-8859-1?Q?xvbKckIkoltxGPgeo62Oj8c4uGZGRjMUaISvzhE2U/+JlhTgmK5FWTdKDc?=
 =?iso-8859-1?Q?jdiH3vKKsRQt2bemRuh8JD4x5n6V5Cw0TLX47+DmXsK3AoWZqr/CePhuus?=
 =?iso-8859-1?Q?HPcj2/ZxeTzdnT6eYP9I59Q8876l+Yfgw8omkil9T6wC93MADmLG0cgV6g?=
 =?iso-8859-1?Q?Gg6KbSZwftEDCinKr5OPbFRr4Lo6la3IyrJTIdd3M27MXLY/Vu7ZP8eHTq?=
 =?iso-8859-1?Q?z3QLubMhHEMfbUGQ+WkqeGI354+9NMpbsV20YAFcR+RYIOOfDp2I9H7GaF?=
 =?iso-8859-1?Q?pt/Nchmc8NGy/RLbjOuyN4IAr84rX86N5ET8JQVeGjgXDgaKQe8X9PBpBm?=
 =?iso-8859-1?Q?ivyqt9nHGs+BPeW4gPhz7Fir1TEUt5fBPLxBNBWfMR76kK+REjxeOqJcT4?=
 =?iso-8859-1?Q?+QcyIOBFpg08QthALG3kYpkFW+Uz6YMQo1rwYSVuR6iSbOnAs5VsnGuY6l?=
 =?iso-8859-1?Q?oGq3vCGs0ZnFzAUU04Iy4RomXDooocmGzrBsfDDyTcmJYWXUTc5S/DrHgl?=
 =?iso-8859-1?Q?t98aK/HaCNS3bG0ZL3pbOJT2SY6Yta+pkq7FPzWIkER/KXUqhBXp3aSf8D?=
 =?iso-8859-1?Q?XRnuCbTapTJTWa60jJmTm8oiZvE95h6z7yE1yEsmFgLXf1JFRih9837lSO?=
 =?iso-8859-1?Q?JWa+8Uag9t6j0W4nE0f+I/NI2geHZknwHkxN2OxH2K1xpTnFIj3Y2PYmdm?=
 =?iso-8859-1?Q?hWWK1S+iAw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bJmteHpip4fmii5eZm9PEAXaioshHhIfDyGCQdPZ4Y3vDxyNSAVG3ZBWo1EZ3Tt/evcJs5SE1zRHeU3ecdnql4RiKIttP+5o8ENRMIf3+Ym0wMacAxgBi9XTyFpSLwK4gUBI9nZwbIksnxgD6BMFrS1M+qR3r6WEKdIXjSGgKCumXAltBPRO2bZoa/BP5gH38VAe9pJvRoUZMSGrAUyaaOKN8XXigTaoZZ7YApN6Mk504LDzeMNZjYoXcKE4lq8vrfcNbz0SZsfKbfGUivvxzQvLdGO96i+5I9ODCJsQ6anOcY1nsH35dhwhqgya2emYkhls7dhbt+waJRWA7i8uig==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4d3001-4807-491a-d24f-08df0711cf63
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:41:58.4938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPd+TmiDUTNJc0eLeCBezS69RSgO6rzNvZlnLTQewAIpgLJVlQcOhI4YKR9RR9Z4oVVW2SemUa8yVc3y26IXYLHPi04V0nCdKSSxkLR1WPA=
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

Implement ECDSA signing and verification for the nettle/hogweed backend,=0A=
for the prime256v1 (NIST P-256) and secp384r1 (NIST P-384) curves.=0A=
A public key (Qx || Qy) is loaded into an ecc_point for verify;=0A=
a private key (the scalar d) into an ecc_scalar for sign,=0A=
using nettle's ecdsa_sign() / ecdsa_verify().=0A=
=0A=
The encrypt/decrypt driver ops return an error.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 crypto/akcipher-nettle.c.inc | 267 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 267 insertions(+)=0A=
=0A=
diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc=0A=
index 1d4bd6960e..34bdc3de27 100644=0A=
--- a/crypto/akcipher-nettle.c.inc=0A=
+++ b/crypto/akcipher-nettle.c.inc=0A=
@@ -20,6 +20,10 @@=0A=
  */=0A=
 =0A=
 #include <nettle/rsa.h>=0A=
+#include <nettle/ecdsa.h>=0A=
+#include <nettle/ecc-curve.h>=0A=
+#include <nettle/ecc.h>=0A=
+#include <nettle/bignum.h>=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/host-utils.h"=0A=
@@ -55,6 +59,12 @@ static QCryptoAkCipher *qcrypto_nettle_rsa_new(=0A=
     const uint8_t *key,  size_t keylen,=0A=
     Error **errp);=0A=
 =0A=
+static QCryptoAkCipher *qcrypto_nettle_ecdsa_new(=0A=
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
@@ -64,6 +74,10 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCip=
herOptions *opts,=0A=
     case QCRYPTO_AK_CIPHER_ALGO_RSA:=0A=
         return qcrypto_nettle_rsa_new(&opts->u.rsa, type, key, keylen, err=
p);=0A=
 =0A=
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:=0A=
+        return qcrypto_nettle_ecdsa_new(&opts->u.ecdsa, type, key, keylen,=
=0A=
+                                        errp);=0A=
+=0A=
     default:=0A=
         error_setg(errp, "Unsupported algorithm: %u", opts->alg);=0A=
         return NULL;=0A=
@@ -422,6 +436,249 @@ error:=0A=
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
+typedef struct QCryptoNettleECDSA {=0A=
+    QCryptoAkCipher akcipher;=0A=
+    QCryptoAkCipherKeyType type;=0A=
+    struct ecc_point pub;=0A=
+    struct ecc_scalar priv;=0A=
+    QCryptoCurveID curve_id;=0A=
+} QCryptoNettleECDSA;=0A=
+=0A=
+static const struct ecc_curve *qcrypto_nettle_ecdsa_curve(=0A=
+    QCryptoCurveID curve_id)=0A=
+{=0A=
+    switch (curve_id) {=0A=
+    case QCRYPTO_CURVE_ID_PRIME256V1:=0A=
+        return nettle_get_secp_256r1();=0A=
+=0A=
+    case QCRYPTO_CURVE_ID_SECP384R1:=0A=
+        return nettle_get_secp_384r1();=0A=
+=0A=
+    default:=0A=
+        return NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static size_t qcrypto_nettle_ecdsa_coord_len(QCryptoCurveID curve_id)=0A=
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
+static void qcrypto_nettle_ecdsa_free(QCryptoAkCipher *akcipher)=0A=
+{=0A=
+    QCryptoNettleECDSA *ecdsa =3D (QCryptoNettleECDSA *)akcipher;=0A=
+    if (!ecdsa) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (ecdsa->type =3D=3D QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {=0A=
+        ecc_scalar_clear(&ecdsa->priv);=0A=
+    } else {=0A=
+        ecc_point_clear(&ecdsa->pub);=0A=
+    }=0A=
+    g_free(ecdsa);=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_ecdsa_encrypt(QCryptoAkCipher *akcipher,=0A=
+                                        const void *in, size_t in_len,=0A=
+                                        void *out, size_t out_len,=0A=
+                                        Error **errp)=0A=
+{=0A=
+    error_setg(errp, "ECDSA does not support encryption");=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_ecdsa_decrypt(QCryptoAkCipher *akcipher,=0A=
+                                        const void *in, size_t in_len,=0A=
+                                        void *out, size_t out_len,=0A=
+                                        Error **errp)=0A=
+{=0A=
+    error_setg(errp, "ECDSA does not support decryption");=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_ecdsa_sign(QCryptoAkCipher *akcipher,=0A=
+                                     const void *in, size_t in_len,=0A=
+                                     void *out, size_t out_len,=0A=
+                                     Error **errp)=0A=
+{=0A=
+    QCryptoNettleECDSA *ecdsa =3D (QCryptoNettleECDSA *)akcipher;=0A=
+    size_t coord_len =3D qcrypto_nettle_ecdsa_coord_len(ecdsa->curve_id);=
=0A=
+    struct dsa_signature sig;=0A=
+=0A=
+    if (ecdsa->type !=3D QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {=0A=
+        error_setg(errp, "ECDSA sign requires a private key");=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    if (in_len =3D=3D 0 || in_len > akcipher->max_dgst_len) {=0A=
+        error_setg(errp, "Invalid digest length %zu", in_len);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    if (out_len < coord_len * 2) {=0A=
+        error_setg(errp, "Signature buffer length %zu is less than %zu",=
=0A=
+                   out_len, coord_len * 2);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    dsa_signature_init(&sig);=0A=
+    ecdsa_sign(&ecdsa->priv, NULL, wrap_nettle_random_func, in_len, in, &s=
ig);=0A=
+=0A=
+    /* output is r || s, each zero-padded to the curve size */=0A=
+    nettle_mpz_get_str_256(coord_len, out, sig.r);=0A=
+    nettle_mpz_get_str_256(coord_len, (uint8_t *)out + coord_len, sig.s);=
=0A=
+=0A=
+    dsa_signature_clear(&sig);=0A=
+    return coord_len * 2;=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_ecdsa_verify(QCryptoAkCipher *akcipher,=0A=
+                                       const void *in, size_t in_len,=0A=
+                                       const void *in2, size_t in2_len,=0A=
+                                       Error **errp)=0A=
+{=0A=
+    QCryptoNettleECDSA *ecdsa =3D (QCryptoNettleECDSA *)akcipher;=0A=
+    size_t coord_len =3D qcrypto_nettle_ecdsa_coord_len(ecdsa->curve_id);=
=0A=
+    struct dsa_signature sig;=0A=
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
+    dsa_signature_init(&sig);=0A=
+    nettle_mpz_set_str_256_u(sig.r, coord_len, in);=0A=
+    nettle_mpz_set_str_256_u(sig.s, coord_len, (const uint8_t *)in + coord=
_len);=0A=
+=0A=
+    if (ecdsa_verify(&ecdsa->pub, in2_len, in2, &sig) =3D=3D 1) {=0A=
+        ret =3D 0;=0A=
+    } else {=0A=
+        error_setg(errp, "Failed to verify signature");=0A=
+    }=0A=
+=0A=
+    dsa_signature_clear(&sig);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+QCryptoAkCipherDriver nettle_ecdsa =3D {=0A=
+    .encrypt =3D qcrypto_nettle_ecdsa_encrypt,=0A=
+    .decrypt =3D qcrypto_nettle_ecdsa_decrypt,=0A=
+    .sign =3D qcrypto_nettle_ecdsa_sign,=0A=
+    .verify =3D qcrypto_nettle_ecdsa_verify,=0A=
+    .free =3D qcrypto_nettle_ecdsa_free,=0A=
+};=0A=
+=0A=
+static QCryptoAkCipher *qcrypto_nettle_ecdsa_new(=0A=
+    const QCryptoAkCipherOptionsECDSA *opt,=0A=
+    QCryptoAkCipherKeyType type,=0A=
+    const uint8_t *key, size_t keylen,=0A=
+    Error **errp)=0A=
+{=0A=
+    QCryptoNettleECDSA *ecdsa;=0A=
+    const struct ecc_curve *curve =3D qcrypto_nettle_ecdsa_curve(opt->curv=
e_id);=0A=
+    size_t coord_len =3D qcrypto_nettle_ecdsa_coord_len(opt->curve_id);=0A=
+    mpz_t x;=0A=
+    mpz_t y;=0A=
+=0A=
+    if (!curve || coord_len =3D=3D 0) {=0A=
+        error_setg(errp, "Unsupported curve id: %u", opt->curve_id);=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    switch (type) {=0A=
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:=0A=
+        if (keylen !=3D coord_len * 2) {=0A=
+            error_setg(errp, "Public key length %zu is not %zu",=0A=
+                       keylen, coord_len * 2);=0A=
+            return NULL;=0A=
+        }=0A=
+        break;=0A=
+=0A=
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:=0A=
+        if (keylen !=3D coord_len) {=0A=
+            error_setg(errp, "Private key length %zu is not %zu",=0A=
+                       keylen, coord_len);=0A=
+            return NULL;=0A=
+        }=0A=
+        break;=0A=
+=0A=
+    default:=0A=
+        error_setg(errp, "Unknown akcipher key type %d", type);=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    ecdsa =3D g_new0(QCryptoNettleECDSA, 1);=0A=
+    ecdsa->akcipher.driver =3D &nettle_ecdsa;=0A=
+    ecdsa->type =3D type;=0A=
+    ecdsa->curve_id =3D opt->curve_id;=0A=
+    ecdsa->akcipher.max_dgst_len =3D coord_len;=0A=
+    ecdsa->akcipher.max_signature_len =3D coord_len * 2;=0A=
+=0A=
+    if (type =3D=3D QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC) {=0A=
+        /* public key: Qx || Qy */=0A=
+        ecc_point_init(&ecdsa->pub, curve);=0A=
+        mpz_init(x);=0A=
+        mpz_init(y);=0A=
+        nettle_mpz_set_str_256_u(x, coord_len, key);=0A=
+        nettle_mpz_set_str_256_u(y, coord_len,=0A=
+                                 (const uint8_t *)key + coord_len);=0A=
+=0A=
+        if (!ecc_point_set(&ecdsa->pub, x, y)) {=0A=
+            error_setg(errp, "Invalid ECDSA public key (not on curve)");=
=0A=
+            mpz_clear(x);=0A=
+            mpz_clear(y);=0A=
+            qcrypto_nettle_ecdsa_free((QCryptoAkCipher *)ecdsa);=0A=
+            return NULL;=0A=
+        }=0A=
+=0A=
+        mpz_clear(x);=0A=
+        mpz_clear(y);=0A=
+    } else {=0A=
+        /* private key: the scalar d */=0A=
+        ecc_scalar_init(&ecdsa->priv, curve);=0A=
+        mpz_init(x);=0A=
+        nettle_mpz_set_str_256_u(x, coord_len, key);=0A=
+=0A=
+        if (!ecc_scalar_set(&ecdsa->priv, x)) {=0A=
+            error_setg(errp, "Invalid ECDSA private key");=0A=
+            mpz_clear(x);=0A=
+            qcrypto_nettle_ecdsa_free((QCryptoAkCipher *)ecdsa);=0A=
+            return NULL;=0A=
+        }=0A=
+=0A=
+        mpz_clear(x);=0A=
+    }=0A=
+=0A=
+    return (QCryptoAkCipher *)ecdsa;=0A=
+}=0A=
+=0A=
 bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)=0A=
 {=0A=
     switch (opts->alg) {=0A=
@@ -445,6 +702,16 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions =
*opts)=0A=
         }=0A=
         break;=0A=
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
         return false;=0A=
     }=0A=
-- =0A=
2.53.0=0A=

