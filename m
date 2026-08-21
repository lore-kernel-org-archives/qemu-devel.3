Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0646C5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoM-00010p-90; Thu, 20 Aug 2026 23:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoK-00010J-Mu; Thu, 20 Aug 2026 23:20:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoI-0004BJ-JG; Thu, 20 Aug 2026 23:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP9753iVIDMz9rb90EZq76caOIOaxmZzylq+y/9NHG4vf3gZuBCXBE1Zq970C4RLsekaIibZYq3JicRLwCnj/URiZFa/84ZE6gHaCzYsCeQ5k39sSne7WvxJQKKYMocEM+aqAs6c2jdEtOkU5LRbb6qXQz4YM2iLSvaN7sPLt2dsyAZrzUy7gDz6KB/jhmPK+CIsx8sWOrw9CuagocSxKaPLJp3EQETCzZwxnYDZ0vvnL3za0SVT/WC0Z9Dr0BmGdiOSNiz8xu1lUnRAZSaBA0BDlo/1LoHMFac8+bTHMZaxPTigPcc+8US46xDHIc0/WY2NPABjYsS4JpAIXIl4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1Kq3Khx87wk8C+OCyTn6pHAPoXCbFUT9tskvA+nBCg=;
 b=mCXXt8GV91JHSreV94KAVlRxvtMk+nDeWLuVs1PD+IA0O5X4nxFE+0VTseJrWKxk6BocaLIf0xekyg3TsaNbCP/QIHTJI8T9fJuzyLleX28sgODv/SDMXl5DR7VcfspHffOwzaHkPufE++R9WMx58cric6ZZhBsM8Y7j9V2AN3x7ZUMNC/fguQMkGkOwUjUwrSBMA/lmtx+k/3/0Y4/22YNVOeG9FejKAqXisreE0hl2Kyx0IFuiVZlpD5kKKeio0xO8fBu8gOTKytspB65U31tN20dMZmfOfU2wTUOLvCOdSGI/N243N/bClnKdhfjetPWJNO24Twe7mS19QWoPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Kq3Khx87wk8C+OCyTn6pHAPoXCbFUT9tskvA+nBCg=;
 b=SYvhJbl5gDyEIZndujKyNOg+LuoKK+3TaYwxmABsI2X3GuN4UvAmJ1Dqhrg2M6vaBzttu4nbgYBp6MKTfw93XhLdkg22411Z5Nnkg5i3RUd3gyVRhOfWMFBw12sCuuWq1UBDvABFJtQu2xbqAY7O7hoPrIp5sF64HDzhWNrLDEs0PSSVZnNt41+uUNYvi5vvYBGqaKSuZnNLQ2hpmCx8w2p06ldoWJtAK15fvIftstnN1VgBV30L0paPBJkCY0nfuMPF5L3yxLVlzIMbFbi9+sos+/h97mT8AjWWopoE1ItwBK05SuSfULVt0dk59R7gbRF+921kRfDYZMFujjZOcw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:41 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:41 +0000
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
Subject: [PATCH v2 3/9] crypto/akcipher: Support ECDSA sign/verify with nettle
Thread-Topic: [PATCH v2 3/9] crypto/akcipher: Support ECDSA sign/verify with
 nettle
Thread-Index: AQHdMRwL92HpCeK0OESgn2oKU+o2LQ==
Date: Fri, 21 Aug 2026 03:20:41 +0000
Message-ID: <20260821032036.1829294-4-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: 935a5918-6490-4d23-399b-08deff332df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: WbnPFFbR+BbujYWfXy21+onumj3FTdxWvnQvPysX7EVjgCL8e7MvGzTUIafR+mzGhpOcKXNqMpmwx4HxCskn3ZRGuctqCRfKmNCF6hVuLWwlom1efpWmKK+7pfwRSmNgboLsDIHMY/zmk81RV9PveDy6nSHS7XIdEpaNDqSbVjKFXgI9Ocnxwv0xgqYdXmMDVwNQCSzxWTCRrH8fQPzr+U54hKoOMdi8oma/6QHD+m88ckE3ugKgKeCWRkyJX3gV8eCK/afKZbJErV/hvzoH9B0f+Kt6xLoEVe5F4/xXK/W/11Vt1AiWVwwUxN/q+b873waBEVMZn056o7j5RvTC9wv+V3wXtANY2JFoWZrnyF5iXAdI90PzVYFeYYK1VuT8j19vRqinFIDl6pbZe81sDl1l2FUXYXqd/kXvlM011ls9jw18sf0vTxaejAcNS+0o36odZrKjFH2zcIkue4Vsi0FC26s9RnKNFiVKZxB2nEWRM/UYnYc7B8+Ae/QZ4IW/wqVwFO8uur1ucb/hTjEAgk+1ea1CGDTw9LDSKIebVmGnaVhbiGgT0PmNJfQs7CK7yyUTxlumE2410dKsqZDxUuVuLptJpF4UfhETfOp05xA+iWIgTMVHD1/gdHidI4vSNUHf1FBdgO+l91+49jcDawwRQHRbHYj/X5ntbVv93vzahTZVPbxDZr9RKGDVT6suDlcrPqHf9sw+oxzKNrT4JilWiaG1KrmDnKRokf5RrwTIRWPFT7c3dO8ye5vsOl89
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RKrfS+rF+iV6lRQdge7WVRxx9U32KYHWsKDXKA17GBsizQJWKSluZJUz99?=
 =?iso-8859-1?Q?Bgrajt9V5J9bHLLTFnpXHG/vtmiTmTcDeZCvoQsmuOongI5hhA5jZ1yI/d?=
 =?iso-8859-1?Q?aYr28Mar2NpdQALMM3B9WttjJHUTuM3E1Falk79UPO6SgUgJ8tCRGJEUac?=
 =?iso-8859-1?Q?Txxex20UcBVWFhubH3PtMBUK/buWxE36GvSjDKeADOLUKsnN1rojAhgxRc?=
 =?iso-8859-1?Q?y16O5h4x1m0ba9MVNUrvdp3HN+H+f0HkmwzFmjdkFnyXT4ebtaYL5VHyr8?=
 =?iso-8859-1?Q?EdXv6EFpPVkMj9E2mNW0O6CzfclGNp4XNvoKaMCdY3c1PGO6Fqj2XsEpJV?=
 =?iso-8859-1?Q?vULSkihXr3l5yfAEQVKu90TjTpgDwzeO4W88h/bWWXXGG0nMTluAx73w4m?=
 =?iso-8859-1?Q?atRQByNPpzwBqMGxMCV8+f66lm5wIokVUhCeXTvyNTicZ2uE7qW+Bxc+jN?=
 =?iso-8859-1?Q?DxnpnqkqEa7UT744BwWfrYw8QEcb6uEQwDtoyghTpS8QYmUfnnH/6Ksxlo?=
 =?iso-8859-1?Q?VEiQzRPmmronWKw9ZPlCnvuIEKocT22mP/+NOmNSwDb3Ubu9MrJ2ljXyOV?=
 =?iso-8859-1?Q?lxlasQ+qz5zWCqGdUWamGxBSKpkASyxlLRZ1O/f7CRUsuy9L2YjqElUd4v?=
 =?iso-8859-1?Q?OVDHgWZyUd7VT/kG5Q1k88plLQEjZcSl+IdgCl0Eja+sUEMdsKfOpf+36B?=
 =?iso-8859-1?Q?M3lv86HptZJx4O8Ej6QCH7grVb7h/2PijF4KI6zCEqsO0i/Ss4rjnSDW9M?=
 =?iso-8859-1?Q?qyw8VxBBhW+S85E3LTzFYevSghqi9g9bYKaFjsxvIBCx/PiTGzuSAZCfQ1?=
 =?iso-8859-1?Q?U7b3iWjnbHZtWTcHwoyHwELBWc1kb31lLetWTCgCcoDB4S6UdEdkyeN+gp?=
 =?iso-8859-1?Q?tIl5rRmvOPbAuB+yeevO+5tFyhhTuNQQQCVar/8cLfQr/gvMCbzJ3J8TY3?=
 =?iso-8859-1?Q?aPAAkrVJsm53PoKBF/LEFbsufSzt81Nm4cj+T1983WSE9QJgbu++tu8v/m?=
 =?iso-8859-1?Q?v/uT73CLuC356DbWOBRapCGSwGrVR0ohnTwcbhvttWeG7FLoK19t8ImdE+?=
 =?iso-8859-1?Q?OFMe7m/IYC8QzcJdWj9vxNEXucN20vc6cZrdNXsEGvGRqLOpXtV7idP9rJ?=
 =?iso-8859-1?Q?FmxZ1dqVA379+l5EulZvgbWwXSJtc/dAz0sGZzxXBek5c/8EuBOiNjvngE?=
 =?iso-8859-1?Q?hE+Aj7MLHVa1XddQxVHa1AfclJOIKXGGlAftbhRR5vo0ygtNCz2YnEmvcD?=
 =?iso-8859-1?Q?j87U64TdU9nx/LBVVJwtO7YepXjbgURkm7oP41bi8XqMQWnipb9e8sP5sK?=
 =?iso-8859-1?Q?Ak4lzWyo3Y8Ljy74DVBPcGZ8iseUzIxcL28f9bJHGxrFBTJVJiN+zBlLph?=
 =?iso-8859-1?Q?lW9tBIu8SpaSHU3wOi8tv9yhFvATp1uHUUSYG5SkIs7OCav3OSWB72luhK?=
 =?iso-8859-1?Q?kebwH/hEkqEgCp+3LxzIzydKnRl3tARvsQwuNkMRSOQbT28spkteUeWS6H?=
 =?iso-8859-1?Q?SGhhTH5a1HjxWnk5Alndsvyzn6gE5iO1p0ecfuwzb2etZbsEppC7mwmcsa?=
 =?iso-8859-1?Q?zj4ALV0f+MHRNvNHu4++6RAGQarbEnHT1X/BDScmv9nCB7xFfQBjUukbhU?=
 =?iso-8859-1?Q?Cs8XsPYlm6cT45OWtjYbcd82cSYyOxK78l4JNLpBGtqGZzSShc2dELejB8?=
 =?iso-8859-1?Q?Df3t4DYbRWZkOZXRLf1of8HX5Tvk5u8yeWS49Gl+rrorGE9xvFwxXnft/o?=
 =?iso-8859-1?Q?7FPgHiDUqRAYHjYHLL9rYjzm4hcG0HzmD8roCn9+zEcVaJ7Nd7hi0AA+tU?=
 =?iso-8859-1?Q?0WAS+7QOHQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Izzl+WJjiqT4x+B9AoD7+yPOzMzEu7GqzXblcVFwPuA+tCzfmoonaz6MWQ1HG00EaQLu335xzH8UTur2pS30LZ6i/gh8deHfn8qJsfun6geKfcCq2tm0BkXeNcJ66qCclrjtvK21JTNVp2yM+0cyl+YLG5vZrYiORsKZ2k3NJs5JXuFMKRJugL+BSE782lS3fLLOsB/hxyBzsjeBK8m1opYEVO7wIv1TyIFCNYvo4C04Z1j/NdPqkCHZV1ADx668wVoqT/eqgR+bkA7L6bIvmiOPd9qQrDh/t1IHnZ26zku1Szk02prkaKgg1uBtlb+Up/7j/+9wm3VWW0UGonRTBg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935a5918-6490-4d23-399b-08deff332df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:41.2243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppFS/SX/X5fdQNqeBaooE2Fjd3v7nO9yqcGcLf7NAAkNYFW7Bk/ks9fH83TmmG7JF42xySrS2PsrtPfGEnU5MEIm/ybgJBpKRW4fM/A3z+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
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

