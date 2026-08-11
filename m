Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F7EC5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYb-0007Ss-Nw; Tue, 11 Aug 2026 02:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYa-0007S3-GM; Tue, 11 Aug 2026 02:01:48 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYY-0002cm-HB; Tue, 11 Aug 2026 02:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSFifigpoH8mLTZh48pv45lhWUtZ19Zj4JJDsX6SGlcNbIQ0tq2Wq4W1qoObENNxawFjkqSDhhkxaOIgvWlsy6tOdNRseFVKbc4Gh5F0MhM2gPfOEQ2yOdS/m2pLUjhSDgZhNkixLN9pTtpApbL5uvfUNjJLTzvTjaQzMaGkywoFq0/eJReWeb/G4vA0K12rbhbGNzkUN/kpOhcIyaAZM1e2yw95WpHNX1gwiTkaiasJqpr54Ct/AGp2KdI5VLmx2Bfi4VLuj68hy/wF9eRKKO6i8FyRdkpjlADPlfn7UxUS0SVidVmtSDYDLE7iQHX6tMO1Nv6gvPbK/LjwMg9/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTC7ut6YwVEwF+IAwlfwDPid4eoWB3dHvtOkd+o9Fmg=;
 b=zUxya9CLwsoG5hE6LGSh/7Dj9RC69AeIUefhjEyMTA1EWXXH04EA0K7AcB5nHEPo4ouTBF03lRCGfplPehB/ZjpXcaUpc2s8rK58X+s0j7CB2BsGG4fadKJaSR3RL6VFDoDucp7F0x2RwpLxDWh4L8ctgkQdsK//QFWGiAOzmwP09dnVJJBjBloif0y2ls+djozW1+2X5UkUlTot51Qzm600MbcdiAko5fFykqtxEXJAX+93TTFg9sOuf9KzMdQJo3G3Yf1kGexUNC1EIneNyQ60fYzuxsKjyiSG/f8Mg9Suo+5NFwpd6Ldm5GWUZsd6GWPDgZxhKvna+PMKOb9k/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTC7ut6YwVEwF+IAwlfwDPid4eoWB3dHvtOkd+o9Fmg=;
 b=jn9olyX/Xy1CJ+PAqgyF9I+vCMfMO7MFvFyQULGCy+D0MlYLkEcr5TjPACZyWOqpNQkabs5Pjm/WXXwitoVQEcW1jgKoqjwaFAaouwV7STDIP5D6azxCWV3QA7jNQgyG5toCFNfnAjhQM1GZJwNqYTHpsDeprD2ZLxCZJ5HhLx2qCUONdnFXzWaAzIjy/N5w1EfoDe4qt9LamAJQCt2FKDlRpSPrZzYCLXvdA4aXPhuYGAssvIAu4T9f8SxvSwHCeLM2zq3lm9TlI4CQLrRR2vYaaYnfrp31by2Cjdx/2MXyJtLmNkEqS+8abFoKs1txcWL80ClHnYG+QchSDiqy5g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:31 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:31 +0000
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
Subject: [PATCH v4 11/16] crypto/cipher-gnutls: Implement AES-GCM
Thread-Topic: [PATCH v4 11/16] crypto/cipher-gnutls: Implement AES-GCM
Thread-Index: AQHdKVbboE8LOZS+AEyoreAX1K8f/w==
Date: Tue, 11 Aug 2026 06:01:31 +0000
Message-ID: <20260811060115.1849266-12-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF7489084AC:EE_
x-ms-office365-filtering-correlation-id: da770ec8-dc67-4c43-9480-08def76dfdd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: rVqZS0DMXnj2Twq3BmLaFSl948kyuf1hRcCjkKASLhBTSWd9W4QdluWgG/gETIZde7zSmMgx5uESqpVWu7Iz4ZVFX2ldq5CGjVlZOMPAf4X0Y1Vu8mHjOtkQpcNBbJIIV7z5zTQ9hPml2aBU+Xr/CtL+agBmXY6DYJYz9v7FgboIAy8EdzkPrhKYa7TIHZ4Yn4R6Own2aqWW7C02Y2avuboacs3/hL14eGV0ytjGf/107iDiMCdPWoakeRCLLeyMTjxHc+2o/QRTDEaGX/JsMj+O6mWjQ5TonezrN/6x/KO0VHHspLK21q3JsBME67pwxEKwaPTPRZK4myAOSORNaGJLhO9ygDCnSB6twYpA/XKxrpeqg4kfO5CiIUuwHUZZtE9Xt1Eaqa1CHaGq7Q/YGDK2Dk4SXZbrzd+cgC/xQr6Q2QStwWj4shy0ss5E71iJpDUDPBRqHs4C9oMa3aiivxDP72KYV+k2aaFN8Ay6XEyE4GBoKuMpphQ+HngJf8BeylqkASF04EUbBWx5kwqcS/cIRby+ZVDmwPYzW9/avo/tIrbJwTEn6a0wPtyH/c8/Br1S7oAMBHi03Y+EQZNcEM34N9i034h3mJ37Vay9ek/2XC+7gT2OU4oxCqLKrR0F13FH4bO+t1a+8m6Ep8vTou93l4/VIqyXG1w4DrNRRerlXx6bpKKP67YS9UE3MA4IB1tr+OFPDesFUGFgVRqeUFXKGarJVwNwYDn7K+EVN/Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FUMaMcpwPUqUt7jQrGy+HI60qpqQPZ/3BNIB5/nZ8zWmhnSuDsyJ1FT8h7?=
 =?iso-8859-1?Q?PG8BxZYBKdveCuon0DuEj+gcZ6vrEpaxosUhwb4BEYhEJmzjhr/T2u2fly?=
 =?iso-8859-1?Q?k5s54Y8iwZKQSyp+duGbzCtdmL6S+W2N0RPAB6OIs887jC6BSuzpCCz78c?=
 =?iso-8859-1?Q?Ms3yT46eIywhOFP/3tILnUPuX8cgoZYmA/PoQaC9bwEnhJCT7YiByA+bJS?=
 =?iso-8859-1?Q?e9Pd7XFUad7bVMfa1JVlkSjYMwcpn4/3h1iK+J1ht2soBf7TxFnde7nhrF?=
 =?iso-8859-1?Q?brK/kDUj/mkaFbrwiqCT6nrN0AkPNrO9lbtC/D7Q6TWJPUhRo8p/RprZtN?=
 =?iso-8859-1?Q?QrkrSn+csixuPdRmc9kDrsEqFt5xpiOCv+uE2pyg0ZEIcstUJjfoeQ4M/b?=
 =?iso-8859-1?Q?iB2lAyQCIWDj+ncT++uLmuULAdOb3aCvJC1JUni9QOOBa3zvSYAmzyKZOK?=
 =?iso-8859-1?Q?rfcwVhb+uubuNrrLL+G/NlBOvi87IEeQ7sW3poazoidoRL7tgE9A68hu3s?=
 =?iso-8859-1?Q?d4SAnsxTcjQGxs1h9YSPxXA4ABbhEOJkWClUgOSqTEVnwcCjP3Re5pdIuY?=
 =?iso-8859-1?Q?0WSLlyD0wzGbQXopgh0/aIh9sxTk9CNHYQY+6MD4IHQV0HzC1sTN38BMjX?=
 =?iso-8859-1?Q?eKIzYkQ66wvISxyYe22yRc/v/jtNM/QwAZfAm6SpFPBJXBYTL8K+R4Thui?=
 =?iso-8859-1?Q?yhl63blHKGfwPDa4CKvVDbH5FP/NGAxTjZnigpMqbHyJ9t8nj62ALWAi79?=
 =?iso-8859-1?Q?kwrTcy8MFn3+T2C9kEuGG4ckacrVy5FRIGFnj1QiVn1iYOdpnqWap1XJJz?=
 =?iso-8859-1?Q?rpieOkGFmaU9ycQrQLgp9okkzZd0yobCU7RsFKvTL1rpWpOc1tEZCBC8XZ?=
 =?iso-8859-1?Q?8cxRulcf5qFIO7BISdI9cyTFrIfR5mT6APmJsynPqj1hyMD7Ra0Tk/M56b?=
 =?iso-8859-1?Q?BVr7/3EjIRdEcwWmadQRDnRDi46+2J92pe1FaKV0dalRt3bsz4xYm9XnfB?=
 =?iso-8859-1?Q?err+iMDkbXaRwVwgQmzDLu+nXMSH7VsUwn/k1HW5absCJxgyL1UvZ8fgdL?=
 =?iso-8859-1?Q?yrk9MrE0Bo4mEjkNWhH/Qj2HlQD679JUAn//N1/KP5sEmkIT+2GjW5iwSJ?=
 =?iso-8859-1?Q?KIPfezLpChPHjCO+mMm/XXzjFFvtKSCIRkoVIrPznI4jI4eaWk5351Fabg?=
 =?iso-8859-1?Q?HHCCQRyY+79S3iilF82xf2uxyUAy5vFZmml5KVTuoaQyTzNAzP5gO/1nuL?=
 =?iso-8859-1?Q?0B9I20u48/TpzSiLhJHTYcGsqdqIlxjJLl/kcgKRvhWjo8koA8O58jZCKX?=
 =?iso-8859-1?Q?e/xm8GVymKP7gnwpxxEyW3QRUr/DjN/nxj+ezGLt754REuWzHAagjDVFDp?=
 =?iso-8859-1?Q?fRFHlcjDaoQouID0nqKar4kaHS9JPXf30jHMxg7UMFkGfl68xdSKW8rYV4?=
 =?iso-8859-1?Q?H3muLdBizv0B969/h9xPveSpI1OqVrFYMi4EEV62VnEUvSloNIUG6bOjx/?=
 =?iso-8859-1?Q?fbFT9WcgQEqfxo/gn1xIdPTyuqW6JWq7T+iQLIYQxP12L2r95xeqpvCjkJ?=
 =?iso-8859-1?Q?LpCcbtC/h8b9G3ViSL5wwyMGE9f9V52zQWQi41JWRi48fNwspqoDYO6O4v?=
 =?iso-8859-1?Q?0wJupjwJD7wETs8zmdAp7+N+rVDLDLNaZrdiYJpwAb4sw6ReMoNzojDT6Z?=
 =?iso-8859-1?Q?bzPn8wJ6IXUv08CnA0iurZ/XFVcOEP1sL1ungg1u5F02ZY9iOH4XaCS3O8?=
 =?iso-8859-1?Q?vDIS+REFAm3ItJ5ihwSWLTcH0SK0CYja6a/X92pPgziMh1zEGne9KI+ujO?=
 =?iso-8859-1?Q?ZMktkahcmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ajKzbTergfdeuS6pAl2q3CBrlJkGhZaFsPG07hxCNHopeH4Jg0IzeqmTOHKgOnyXd+8OOG5TLldWruhHzt2LTfVrzCuZUcVl9GBfKU467JUNmMZBgGiayk2CzGe2vg0MbCkNlrgkcq/zp78ickeWl64o/eMPA8axlTUNSU7Zt48Zno1a0DHfbQu28FkcmyeHrTUSmsZQrD3dPmmtc+BDJjn94dTQblcbkZ98HyjLQ/eq8BGFceQWEJjSwzp34zlBYGvUbA2BMYrKW69nyQtSkA/WpQzWuR0yFDIkOPhwhHzl0ICKZcRMpMwiJarvkxFBOGef2Bi6ekI/0sGWx79brw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da770ec8-dc67-4c43-9480-08def76dfdd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:31.5086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7rkxmWW8O+ls/yDiLUlHDEKdpL2bUBDf5burTX9ASK8dqZlXVrNPd/G0ZP9aRsYX4gRLHfintfXGMiJW5XL8vX5jOYETbYkx40cgEeEajA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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

Add the AES-GCM AEAD mode to the gnutls backend so it is available when=0A=
QEMU is built with gnutls (neither gcrypt nor nettle). GCM uses the=0A=
incremental gnutls_cipher_* API with the GNUTLS_CIPHER_AES_*_GCM=0A=
algorithms: gnutls_cipher_set_iv() sets the nonce, gnutls_cipher_add_auth()=
=0A=
feeds the associated data, gnutls_cipher_encrypt2()/decrypt2() process the=
=0A=
message, and gnutls_cipher_tag() reads back the authentication tag.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 crypto/cipher-gnutls.c.inc | 154 +++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 154 insertions(+)=0A=
=0A=
diff --git a/crypto/cipher-gnutls.c.inc b/crypto/cipher-gnutls.c.inc=0A=
index a8263fff6d..963b328fa1 100644=0A=
--- a/crypto/cipher-gnutls.c.inc=0A=
+++ b/crypto/cipher-gnutls.c.inc=0A=
@@ -48,6 +48,15 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,=0A=
         default:=0A=
             return false;=0A=
         }=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        switch (alg) {=0A=
+        case QCRYPTO_CIPHER_ALGO_AES_128:=0A=
+        case QCRYPTO_CIPHER_ALGO_AES_192:=0A=
+        case QCRYPTO_CIPHER_ALGO_AES_256:=0A=
+            return true;=0A=
+        default:=0A=
+            return false;=0A=
+        }=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -223,6 +232,147 @@ static struct QCryptoCipherDriver gnutls_driver =3D {=
=0A=
     .cipher_free =3D qcrypto_gnutls_cipher_free,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * GCM is an AEAD stream mode: the nonce need not match the block size, th=
e=0A=
+ * message length need not be a multiple of the block size, associated dat=
a is=0A=
+ * fed with gnutls_cipher_add_auth() and the authentication tag is read ba=
ck=0A=
+ * with gnutls_cipher_tag().=0A=
+ */=0A=
+static int=0A=
+qcrypto_gnutls_cipher_encrypt_gcm(QCryptoCipher *cipher,=0A=
+                                  const void *in, void *out,=0A=
+                                  size_t len, Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_encrypt2(ctx->handle, in, len, out, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot encrypt data: %s", gnutls_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_decrypt_gcm(QCryptoCipher *cipher,=0A=
+                                  const void *in, void *out,=0A=
+                                  size_t len, Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_decrypt2(ctx->handle, in, len, out, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot decrypt data: %s", gnutls_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_setiv_gcm(QCryptoCipher *cipher,=0A=
+                                const uint8_t *iv, size_t niv,=0A=
+                                Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+=0A=
+    gnutls_cipher_set_iv(ctx->handle, (void *)iv, niv);=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_setaad_gcm(QCryptoCipher *cipher,=0A=
+                                 const uint8_t *aad, size_t len,=0A=
+                                 Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_add_auth(ctx->handle, aad, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot add associated data: %s",=0A=
+                   gnutls_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_gettag_gcm(QCryptoCipher *cipher,=0A=
+                                 uint8_t *tag, size_t len,=0A=
+                                 Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_tag(ctx->handle, tag, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot get authentication tag: %s",=0A=
+                   gnutls_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static struct QCryptoCipherDriver gnutls_gcm_driver =3D {=0A=
+    .cipher_encrypt =3D qcrypto_gnutls_cipher_encrypt_gcm,=0A=
+    .cipher_decrypt =3D qcrypto_gnutls_cipher_decrypt_gcm,=0A=
+    .cipher_setiv =3D qcrypto_gnutls_cipher_setiv_gcm,=0A=
+    .cipher_setaad =3D qcrypto_gnutls_cipher_setaad_gcm,=0A=
+    .cipher_gettag =3D qcrypto_gnutls_cipher_gettag_gcm,=0A=
+    .cipher_free =3D qcrypto_gnutls_cipher_free,=0A=
+};=0A=
+=0A=
+static QCryptoCipher *=0A=
+qcrypto_gnutls_aes_gcm_ctx_new(QCryptoCipherAlgo alg, const uint8_t *key,=
=0A=
+                               size_t nkey, Error **errp)=0A=
+{=0A=
+    gnutls_datum_t gkey =3D { (unsigned char *)key, nkey };=0A=
+    gnutls_cipher_algorithm_t galg =3D GNUTLS_CIPHER_UNKNOWN;=0A=
+    QCryptoCipherGnutls *ctx;=0A=
+    int err;=0A=
+=0A=
+    switch (alg) {=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_128:=0A=
+        galg =3D GNUTLS_CIPHER_AES_128_GCM;=0A=
+        break;=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_192:=0A=
+        galg =3D GNUTLS_CIPHER_AES_192_GCM;=0A=
+        break;=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_256:=0A=
+        galg =3D GNUTLS_CIPHER_AES_256_GCM;=0A=
+        break;=0A=
+    default:=0A=
+        error_setg(errp, "Unsupported cipher algorithm %s with GCM mode",=
=0A=
+                   QCryptoCipherAlgo_str(alg));=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    if (!qcrypto_cipher_validate_key_length(alg, QCRYPTO_CIPHER_MODE_GCM,=
=0A=
+                                            nkey, errp)) {=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    ctx =3D g_new0(QCryptoCipherGnutls, 1);=0A=
+    ctx->base.driver =3D &gnutls_gcm_driver;=0A=
+    ctx->blocksize =3D 16;=0A=
+=0A=
+    err =3D gnutls_cipher_init(&ctx->handle, galg, &gkey, NULL);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot initialize cipher: %s", gnutls_strerror(e=
rr));=0A=
+        g_free(ctx);=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    return &ctx->base;=0A=
+}=0A=
+=0A=
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,=0A=
                                              QCryptoCipherMode mode,=0A=
                                              const uint8_t *key,=0A=
@@ -234,6 +384,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCi=
pherAlgo alg,=0A=
     gnutls_cipher_algorithm_t galg =3D GNUTLS_CIPHER_UNKNOWN;=0A=
     int err;=0A=
 =0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        return qcrypto_gnutls_aes_gcm_ctx_new(alg, key, nkey, errp);=0A=
+    }=0A=
+=0A=
     switch (mode) {=0A=
     case QCRYPTO_CIPHER_MODE_XTS:=0A=
         switch (alg) {=0A=
-- =0A=
2.43.0=0A=

