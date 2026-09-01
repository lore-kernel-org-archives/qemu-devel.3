Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62845C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEr-0003rw-KI; Tue, 01 Sep 2026 04:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEp-0003q3-4z; Tue, 01 Sep 2026 04:53:03 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEm-0007Il-Th; Tue, 01 Sep 2026 04:53:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+KnP93INdscobIPxbmtBmY/33OECnQr/5OffZ0q1wAnMtY8YhFUcf1UchJP+P0xZjuzPfew3Ag//FmYjTTKwCYHxt+XStyX2azmzeGc975DVjmX/XTRQ+C5OonsHbCIFw5O8ESGOsrPtdyIBz8+QwajH8Ju0lXtmrHwUboHo6FalyXoir5i5XD4s95LcDRgqeMdP26WjA1ApzQsYwNRpgN6X3IRZAEHM4xKPhEYGiNMH3iSKkelHNIzN0p1/Qi0bPLqw7Xj1qMKFU0iaH0ntQxsdZvSCwT45gN0rYZJqWFkLcS9EvmtuIsdeTJcu4vLZP8/w6gAY4XUs8sNhy4Mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlfpGmUkETz09htamVF4dZRcHSKyEtONAYW2PFbq3Bs=;
 b=xhwWSZfHE54E3KzK4GM7mltspjRvJiZJ3K4l7uZNXxsMXCu0UGwuHXPPOX08UAbh1Q0qONtn1LjsHdvctAau5q3A0J8tfsXHTH0CGmceBeKQXwMjd17E0yC6ZFr46vkoWWNJY1pEU0KnKa7mOKHkClc0HHDRWJZDEOuySbVsfxwQQw11reHhGZBlJ/AocuwkEvwgWuO3NaJW3/bYndJN68XRTDAEhW0v5bkVIfrFeaYktKGGeZS7j/Fs3sRSxg07z4KLFBTgdDxgKMVn3L+qgDl+RSDD+sqqO1kwJXiPEQ1m8grAP/ocfYqqe3/lLFN4tWBnjFlrzgWbqvBeOLbc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlfpGmUkETz09htamVF4dZRcHSKyEtONAYW2PFbq3Bs=;
 b=Wp4IuWwTHFD1KvVgzRCk00hCx+avRxDF+LiY7switokO2HBAiBK/nJyw+PRw8jc9Uddw17gzdVmbAIuYWEUj3+K2EDqx1/Xvhpj9b7x4/YzH8jH0efdZ0Xy1nyhKc/U9nXFIP86Bk8/vEECshy3J6f+9wfBjZ9rgI4dIuW8vd44YllnBL+fCVoZd94rrnXH6HGRJKDt9kHPVxhZk6x3zHUCju6oZZIFK9ZcY1wOmI361H8pCJOqg3uuJbGtlwTMwWMLTfWmthj8RnuIx0E6fFqjZx+vGFiYW5UjoYwE+vj9nRl9lSX5gR7TEcm3PAHVSquRaGFiCf5vfi0dqAZdoJw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:52:42 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:42 +0000
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
Subject: [PATCH v4 3/9] crypto/akcipher: Support ECDSA sign/verify with nettle
Thread-Topic: [PATCH v4 3/9] crypto/akcipher: Support ECDSA sign/verify with
 nettle
Thread-Index: AQHdOe9AFRBj9G3fqUiM0HNgJtJ86A==
Date: Tue, 1 Sep 2026 08:52:42 +0000
Message-ID: <20260901085238.995968-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: fe8c9dfc-1565-4a4f-0493-08df0806629e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|3023799007|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: 9nzQ/9UKGs3YWNpTZFYilCR65orkmAaY8ZApysIymlJLOTUlFcWpx52Gluk6zBRbi8bxdK/yG6odnIDmErCHBtdIrWgVO+lxgMnDnpxaQpVBIe1WuiAH5Lp3ook8D48RRJAPYS6WMx9r5L/opVf1TkiQBufny/7kcihgcyhkmcSSCwEmGAdl25+ktujs+xzVt9SzLJgPqGGGh+f7ZJeKoScj7sOdSpnTdobirIKgKyZEGpfMPEFPDDL8+ON5oRUoSRCFXqR1sIXP4qYUnxkbM/nkdUNOyMgD41nGfXuoAze6cMp4eZlSfabXyjhIbqIziqZUzL+N8xRjyeidJ1d4fWquYuhGX7wMZowqFBJz5q5+Ru4pzL5J15L0BABkxubgzOFMJyNf8T06rJWXehMjN8ohrELtM8YBlViX88yv2ZJ4EUIhtBNrT6LLkE1Dk7mP/2qzmzu0UXUKDXrDefkAgPsz/WmXXwxjn1n+xrziNNTJ9vhKWePye7CJ4s401/ETVtrZ/qofMToyXLgJ6VSBQ+WV186CmfMng3s7U7Dw70YH2C/EhONVeadttI1zU6achIdUy1vgEU8+ykd8saiRvGHIMuvVCIIFyTcpMWTuoOX4KYnf8kQKnNfTz0ULIqAKLuoKHppSb4vVSrrACOH/3X2KRSxG9G+7JEt8WUDkUzufYPJI4bFp1RHr/DJ/g8sUW/GNYA5fa646j3K2Ia2Iab65g54GvNbdBIC3M0xUkLxBYBdVNz6ZVGets7Z7VEu3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O8UPwXScQUjhYax/LS9hZSa2Sw2yIzBrWpXFNQWhVXIfqQuk1XUVk0lZJi?=
 =?iso-8859-1?Q?XM/ahD5fwnpW9/N5y/1oQqouuB5Ef/L11Jk3fgZpAmruw1aQpaSgc92x42?=
 =?iso-8859-1?Q?GCnsu1dL/3/Ily4biX7uxUELGbLiG9tAGiAjmdfiphhuFoG/ARCipAMUPs?=
 =?iso-8859-1?Q?/+vAn6H9Gl9Wiz0HE/l690HcDjKG5UqZu3h2in3qzZjcMtyEpxMNAvGTEG?=
 =?iso-8859-1?Q?vInWzLFUkDu6yhAuKR/yAoeYoNMIkc8MK71OpM+vYq43OkwLI4BqHtT/M3?=
 =?iso-8859-1?Q?RLavAYRc32Ml327wRZ1BKaYQwJyAd9+n/2vXdh3rFewBB/OFnMTAumd6gL?=
 =?iso-8859-1?Q?kmpT71yh2J0FQKz9KdmG8REG+uxRt/zQgy6cTWRPn3x4oikUJx5CEnZtsJ?=
 =?iso-8859-1?Q?ATneULTrXdyXwtzHIJ9lokJKZRwqQmAxY9c8YoAFyVBi6UWfFgagiagIRw?=
 =?iso-8859-1?Q?kggF8pFgmbDzGHhfyn7whSLRaSuX3SHdWP6wvTMlsOygF6jdP/O576sMGZ?=
 =?iso-8859-1?Q?LYnBBFGwDKwcjjBoeiMXdsxTe72vge7RdwEHaZhc1zhEl8IF648jMdCgxp?=
 =?iso-8859-1?Q?FrMSq3xDK5Yc9IcMelz2LH24sRqZ6jyZPfKZqXwjiZM9f9wINbo3zQTsZz?=
 =?iso-8859-1?Q?yo1NuLygsj+7PblmXrfr8i13SOggQLTUV5xfuGSsbxF4lIuikca5ZAEfNH?=
 =?iso-8859-1?Q?ApJXeH8AM4JsrVJvV/3VSe4RmqGqYMVlBaS7fQuMFteBDug13O69gIczpT?=
 =?iso-8859-1?Q?XaqldYpSJYBTViIE4vB1zZU48y3gR84ABSgz9nZknDUobWoZWt5iUbCqqS?=
 =?iso-8859-1?Q?GlUZY0nZutBw5224PimhNSBzwIidxgfeKNvyyguRENFRSXhcypVqPtRSVZ?=
 =?iso-8859-1?Q?DHV+Veiqrgx0TJAJFDsHCL6J3YfT5uNgV4wHAY/yHmxtrSit/i5FSjGo2S?=
 =?iso-8859-1?Q?5kjJjTqgdlUEGEpOGoorlOtpWr0V8pZrfUiey7q6gQJK7LKa6zSZEVlH38?=
 =?iso-8859-1?Q?mZOiedDz/5tDIAYCBtNOPzusvK5DfzqOEJylxpHzyQqFc/LOLcbZGvti9W?=
 =?iso-8859-1?Q?3Qph5Oe5MDXzlhTB5rXU8Qk8YRcbhKxAlCKs+FuE5p1JP5dkuOEhVBcx26?=
 =?iso-8859-1?Q?aKbkNaGskt9H4G30EGyXcHJGwqGytS6+ql+IhMSIDfRRySpH/BZ+T5KQTs?=
 =?iso-8859-1?Q?BjfwcoB0mcH+IuA+H2rqUoxkoE8XwaUe2VsPQWFG5b8INqn5eNB55hUjnL?=
 =?iso-8859-1?Q?FgWYjIEuxub6L658fB3Ofp3tYdC4Xe0n+3fJR337oO5+j5p/YE9Vqe3oxu?=
 =?iso-8859-1?Q?JzbBPNlVI+JlLdhdf6WuhwdwooFE1vV35xMdQye6mJw/AdcaSvKB391+2h?=
 =?iso-8859-1?Q?CZQIk/IWV9pQ3nPypOOu2vs3DPPmPfDQJdQr3GK8uCTTpipWbnBc8HxdLQ?=
 =?iso-8859-1?Q?S2eRTv3wI0zLNTsugr3CHlIbPRHy3dsvbo5wW8u90VNlleRhPO8MjRUyjU?=
 =?iso-8859-1?Q?g+Pu3vZM9tvIdCfKg/YQSzubfHw62zpwqeayI8JkjlLx+r4yuGNG4YJW3s?=
 =?iso-8859-1?Q?Mh3EelG+gi1qNPUXPd2w+Bws0cuOhEblPLEuk1h9UOclsJyiohMjzFEyBt?=
 =?iso-8859-1?Q?SoAKu1VPjyqUdMqh+3xn2rG2koKkx4U5KXBAsSV7jIniJTG2f4xGcga0u8?=
 =?iso-8859-1?Q?ejUHgzlBl21cVuMnGMNYXM6o5A0Sw5NvTLWxSOeoZAcw+YcEAlrZSLixci?=
 =?iso-8859-1?Q?1RNPBTePhtO0WG2zja820BSGSI4uXuVcvVJkArWTiRmaJx7SY0LADRxo1R?=
 =?iso-8859-1?Q?qwFlmnvMXw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MfOt2CEZW7HUHiHfcyCc/3vQDkNRANdjylnhaJVaUG4zH3kkZ8eu7Bj+xUpXkC2/IGQEYVdMp6eMtRKM0cxa6usdgmvcWqFf/iCuVb5a8Z/kXwdm/f5h4toegnTmeD8Sc9fP0p/8Z4oO4aKvxq7hvQcIQuYuC3FvhFqNtBSFjk4GG1gdBilO+72ZCnpubelqq5Ggqln7vIPJVk2z2Mp9vIW5jUUMKkjobJwWC5oKgwJAN9AgnSafTFEi/MAogiF36yiVQbYU8Ri3B1v4jhdqNM2j6UwTduXn3SZsJpIzPvjiy7eDl6EkBsrH7RwBLvu9ZLmw+vek+xWA6/7rvoNn1w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8c9dfc-1565-4a4f-0493-08df0806629e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:42.6975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yirzm1KaBdQwsZg+kS/vYUNJYvOOo2LIfkZnSwPCh7bKHWDISPM59YGazDiGB3BLPEOqIRi5pP0yVFSMZohRcwmCKeJI5a/vylB+Lqb7DOE=
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
 crypto/akcipher-nettle.c.inc | 272 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 272 insertions(+)=0A=
=0A=
diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc=0A=
index 1d4bd6960e..a34845af5d 100644=0A=
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
@@ -422,6 +436,254 @@ error:=0A=
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
@@ -445,6 +707,16 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions =
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

