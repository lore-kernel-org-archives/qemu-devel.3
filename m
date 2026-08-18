Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BABC5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2G-0001je-UO; Tue, 18 Aug 2026 05:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2F-0001jD-8s; Tue, 18 Aug 2026 05:23:07 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2D-0001Yk-9t; Tue, 18 Aug 2026 05:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a75hzNXs6R4gWOrSji2TNWLzFw2mxgb5pj0RKnRVwCCge7051pwE/qk5OcfOuUZxhNor66VY8BGS16k94BYwW7GdDVGvUOGhZFj0KaQJD+EgGhKv1NrL2gutNQkxmzKieBlVSKQsDuuOyGQaAASCDij1sNq2+XY99rjjSZS3haEp5i5Roa+79OZ7Nrh40cPJa4t6elbGbx0MFU7045zwRnFxYc4/E+myg570iZTVDuggkwdSnTtNazo9Genp9Zq4zR3aKmgbedEdzKzuLa19bogUEBfJMqt5YkC5DiSMEhP4Gv8vDFrqyfgyx2kHbxzr/qf3oqbJZUZV+le4WQXSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1Kq3Khx87wk8C+OCyTn6pHAPoXCbFUT9tskvA+nBCg=;
 b=B4U+heiJqFCSleq1/1SnIBHL7F8koh5gkLUq0Dt56AdajqLUvbAKEk3oA/chV3HRtSBrCMA3dVTEsyzwRNKsDIUGJFsCF/ubFgnqWi0nM2/26x6Ee8qOfPkES6aiS78Dg7GuhRpNUIompvlXECbFKRkIz2vOxRDO8p/9RtvGNla0eRuxDqD1RpgSGjm9/G6PB1tJc7t+my82k0qosYaAl+VKbY4NwbyGHzjsp6ZCtX7QU7N2CGh3XsP1Zu4yf9DZX4oej6jzs0ZxkEywsOW8m70SYxQflRgsK3Yo37yBLswHJcHEpp4Cs48J8X/5UTLU37k88sNO0W4k3Xzae2VmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Kq3Khx87wk8C+OCyTn6pHAPoXCbFUT9tskvA+nBCg=;
 b=faEa6sGr4e86sFhY+IjvAAw+r60jGjkmK9H6OmYo8G0Pgr+JUgOcSRwgxsSPuLYOMckQ52Bh90D9R583aQOlIp+TI4gCQUV55FuzI5FtsnO+8N2f8DdBJhpnFf96XkrFIAn/VPi8r/JQe5zUw5Uzd2PY8Q5VyCL6ckG3+mQnEwoNt/xTlHQQiEX4SImllKp6m+CYK+KMGJshv/dZbT9i17p5OAfOwJcS31Z6e1nXFjH5onXlCEuWWL4EY4CJvOSXXvBN1O86NFRNQ953JKmab1+4WqmIewh9kaTjiAmcIJYaxQELDmU1xXEM5F7D5o+71QMkayounBpOSwcSxt5Tdg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:22:57 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:22:56 +0000
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
Subject: [PATCH v1 3/8] crypto/akcipher: Support ECDSA sign/verify with nettle
Thread-Topic: [PATCH v1 3/8] crypto/akcipher: Support ECDSA sign/verify with
 nettle
Thread-Index: AQHdLvMnvPzYFDsWyUa2Mko3DAwobg==
Date: Tue, 18 Aug 2026 09:22:56 +0000
Message-ID: <20260818092249.602137-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 01e5dba8-e9ec-48ce-f3b6-08defd0a4a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: 9yJvIFUXiI1m/GMi0KlyPVNx5IVGmiLuqdeWfsYrdzZZ1VtQ12oUJtR8Z/sp0v21EncuhbCvbBEQVR0zas3TaHQoaiS+WV7zyMndeC8DjYpsB+ztD1G79OXR9sUiODxAmNBmurYFoCy4TIg45Z4AFXuc3iVkxO8nAbvvpzjCP0a0E8EYB3AZ+g4rjeEm2fviLizd/d4DvaK9PLR21k+fxLeWmnjlubrP1w5+4qjB1FcV9/VJRLQmaio57Pb2kTeg6T6GcuMnvVHlBJ4yJU+5XLN783wUApOOjXdy1SMr+me54lkq3cHZq223IeSmeVK01V7QGRNuUH+onkWAI87/RcGO/yv8JKR6r/B6ZPU1OoT7ua0q+ZLVh2zHIZWklZVRPDVYj6bIAXwb3UGcwM7idi0sYk6ZToaFRP6Ed0DuTks6vxMvlIvw97f8WzwDLvSxkb4yblaSmN7ZToVVlXhxSHgW7cfhQNwxS+0nu19sJLjajuQMpQtboG2zSr+2dusOaEqF2VWqiOaXbZUf17Wjt2O8fkQq2tlTeJwwWRrjXKBTc7RW6QZzXWMqEugU2nyvXPvYHb16Zum9+Gw2/OTx3sVl4yoFFjhJt1IhuiK44znJsHTnQs6zcJrzh9VIWFxzmSOmYWltAzJSWy4jCQz/RDSAa+5TFUff8YXBMBGgOiNWHjDhUO7ozpaYtci08Hr2VUBBCISuar09XPfS3FLc+i0/vIvgCAeRLiG5KbGBKhH9GrFyYl8UuwGP22XG2InZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dXNjMh7iLiFm7JqEZik5Ins5nnLXPhcaxsMjKVrho6vwYtV4H245Q0kzf7?=
 =?iso-8859-1?Q?ssOHUPMP5U9WKHSki2ngBQyW4hjj1SBnuatK3MWvYXmBhoGmVynjUPweji?=
 =?iso-8859-1?Q?thet/jvWrLpidL4ut7lJ4BXqGZeFTfYI0QMNggcmk480eVbzhYv1D/60Wy?=
 =?iso-8859-1?Q?DkNO5Yl0fRvf6+GfwEHqNTdYArhEiQP4zbBEmb6DSjaZl1W7XFPtFPImfR?=
 =?iso-8859-1?Q?IekWuULiy0PWQWLez1DjAZ/SKHCxALGrsqmwsVKPD7L3Q1fnDzVcMoQ6Zp?=
 =?iso-8859-1?Q?gcjjjJFDkrswQ8mDyXGHnLgWaSUdQzmhUt5DuTmDi+2gGFcVwymhr3ai6C?=
 =?iso-8859-1?Q?wdvoMVP57UgoQEelJPYjHjfegFEgkHPTDvp+WVmH+jAXBkRYv101lhM3Ix?=
 =?iso-8859-1?Q?lbqgTgWI3BzhBxiu4NtoHC5ctSbX3eu3SaQEpddtm7PMAC+q5JXl9YST+5?=
 =?iso-8859-1?Q?//qMcN0ifwO7RMpSBPH7bR3atE0j5tRnpeZY6/2g2tpj9tW21eAWYNxtub?=
 =?iso-8859-1?Q?0TpT/u2GQ3W044y+cjrFI53f456NfY55hzUJZt1jXvkGrUpgOWGbtj8Qo7?=
 =?iso-8859-1?Q?BtC7oSgBZ1IOXHccO18NVXyoii9Xi+aEAa+w6w8AHCggRXRuwet9YfwL7f?=
 =?iso-8859-1?Q?DpbML6LKKqfUMrQdeMEgegUeyU/FnLr2Cv3CR9O/A72sWFhxCs4cabeZjk?=
 =?iso-8859-1?Q?5bJiKmSSEzRpBXuhpBEvp5Emj6fCsCS0v9TdcyU1t90zlHrEKGZcBUPhQH?=
 =?iso-8859-1?Q?uKPfWGljDEztyIWUYBbLieSpJXQt5fYXXqMIdcs8kht32V5efJbeelX5zn?=
 =?iso-8859-1?Q?dzgXZu4+UWvXkEiZn+13PYyNhGVGON2xYPn0xAo2YmP+loMzw+zIGRkzpf?=
 =?iso-8859-1?Q?R1jOFBmy0QDonVCfIyBQ+0aPWMoTysGP7CvBYHUhtignmpK6LslxU2hjgs?=
 =?iso-8859-1?Q?7RhBtmLZuhRwsvGTQi0hE4w98uu9RlF+KlRZ+oZVMkxSmffXGNcNGnowVz?=
 =?iso-8859-1?Q?fYhJkX8YPpB/SeEQr/2C8lR+pWsDy98JDYcSNZUN1I9G/eS3Uvn0giBsn9?=
 =?iso-8859-1?Q?28vDHD7jTsrNMZo01Qs0VzYfRwZfgJCf36RFi9N3QuP7lhE85r8fTbFadb?=
 =?iso-8859-1?Q?WhD1wxVhIsKC3vmfsvkBGyD0KwZpwoIIijCtTokiHgY0+Re48UwkbrXlzx?=
 =?iso-8859-1?Q?yevidh29md2Bkab3Z9Q0jmbDwxGi/BqH33mVjh8emChDQck/KVAd/xHRPP?=
 =?iso-8859-1?Q?ozRsnJoURPIC16ZjU419+w3xmZ/w8JlLv6VR8b0IJTp+hsSuq7hhIZcr6I?=
 =?iso-8859-1?Q?JilG5TfwiLJEbDCaHOByviLWbi28gSjY8qckWGIFlI1QdM58LlNunek8JO?=
 =?iso-8859-1?Q?ymEZZtaL53EBSywS4lWAq51pXjzw/WHMM5OpZigT5d5qJUMH+wdOoJPncn?=
 =?iso-8859-1?Q?zPxprZwu9oyNZPtBmbmoTjznRiVSLcVnlwgdKYcZaINRaPiuDBePV20pBi?=
 =?iso-8859-1?Q?BA56JXUsSBAUmEMwfxMKbWboeRmhSoPnTTzrAyIwg9ybWr7hxdBYTYeCjw?=
 =?iso-8859-1?Q?VE0GpB+4FYPD2huBCeHOL3fdLKoqLfEwcESXNCczHbeiZcz+deKIUj/542?=
 =?iso-8859-1?Q?kwx/dVdD6nHrdxRtHDGCJ80nWNeYkW7Iq/NismhTMLPZCMY9Tt+9785ePl?=
 =?iso-8859-1?Q?okf4yEm3M3ERqlqR9+DlkA+lXaM0HY7YmIgPNDtINP9/IK6hhtmt1Xzmh0?=
 =?iso-8859-1?Q?FQTrqLU/sV6Qp9PnzZJqTbmHTpp9k2GSjehyKKe+sjeOLrN1QxG9vNFQqW?=
 =?iso-8859-1?Q?WDU13HeBuQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C8SQUCA6rLz7JXgNaKtMCMZg0xT1RTdi90XDnJCujcH+2R3kL94P3FMSyaM0yunvfpK0Br5GmIKTEkKLmcVTSE6caLFkNObxicKQgpyrr/vwUsBFuxtgxId/9F+2Q4f4+hBR+nnIGAP9b5t4xWk0QT08FtjttBTvTCzUTvOPENfX27eFjeX24ebdSXJ8uNwvNv5NncGpkJtHoKTkYSAJKmBPZv5JfonVso6Z6rXqo3E6U6mzSs761DIV2E0wmtIQ+G0AnCHSaS+wj/Mkckio+nJVqiVhF8G4NqsSEKBqHuHqB+GNObZi6BccBCOW+/XqLCwf6EbJzQlwk7SXjcMYoA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e5dba8-e9ec-48ce-f3b6-08defd0a4a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:22:56.6304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYYGDLtMAMwDQhhWiiNImPDpuM1DCYq1YURYG5YeeSyDuPcoEv2uUeA3vfeui1BaGcUnA1HHDUcJGCJ/KxTYMnapmcRkvwPEl60Zwkse5Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

