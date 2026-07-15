Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F9DC4450B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNj-0003E5-MP; Tue, 14 Jul 2026 23:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNQ-000382-EA; Tue, 14 Jul 2026 23:33:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNO-0000oW-2K; Tue, 14 Jul 2026 23:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOA39q+pxLLRu49e7Twy36OEiYT9VPhllqzl48BshdA/fjTUokgYLzA+Zv0EV6SKtotjmu9ULstYBS4a0XyTz0DSMnTXwQ/CzQX/tFXnZ6p54ncWu6roIMFSAE+bN4obYMPqzPaQ4DUuIaaVCK3+GOpItND/Sm6Q+lfdDj+AM4UNkNGrQWkNxMFjIpjRl4gywFuLXhoQwT9hHRMhZvsIVRfQ8XmHI7qrU19bTrU9vYycrl8S26DETYGs1/onpz+RJMB4zD9fwmvywe7ej76tDHJgfFs4cKxaL0zrHIo0JpCHhByEeG1UL1o33BLXYZA+U5jOsfwzNg/knWwBJdLA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEYwu2gJ/fyU8QsoRe5NSTkyYklVb9LQ9lBHS4RtXw4=;
 b=lklnv2zmKdF448Apvm4jDL8CugqSh+zX3HgR5dzqrtuX6xxL+SY6DCIFIHOGxxyPXv7EY0CUEy9xgOr4z51wzaZ4fESbJUgNRJgFQKPaqp9tZFdnxKX4ECeukRTPbqpZuiuO0o8/5iF+1P0dl+8xaL6a9bopkstrJRQOEiug0Kp8TIaxggVLnaPJFnN8j56GpxxhL19iA0F7GQnSe8kpdv8vaGYAuSjYe+tIj5IKYdFN4CPloM8JuC+CPLVY7EVydv1JGjzUaXOfs90JBng+Wd6znZjuqac+c0B3buzUVP+Oeza/R/wt9+0zStm4lbBPiD1FlyF+9dIhsxt6lRKefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEYwu2gJ/fyU8QsoRe5NSTkyYklVb9LQ9lBHS4RtXw4=;
 b=SXySmVabosDlaQhYMJWazaqvwQzTvdCe3KG8eEbef5ma+g2nGABRskLcYNezWWcGo7xGxCau6deCSZvpvo2Ab2UlK/AnH2dU08djJ1KPny2vl6Tr1gLJdfKQk2HHl30S5l/T/BwVOHS0oEz8ZknegbeZGTEJMr+qSwFKL8pIBbcYM+m369pknpbyQtmR+EnocvN8XyJ9GKbOD5iVIiX3ZcTsNYOSWAsHvfSeZkDWmlBWH15/P/ULZnT7dyQh7+04Npf1COfalFPLAzvj5B48hUbs0OzvJs+l6mzOCXzlAbJZ4u//an7WQgtC95kGqi20NC/s1w5hPoLwmMNQBflb5Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:30 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:30 +0000
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
Subject: [PATCH v2 10/17] crypto/cipher-nettle: Implement AES-GCM
Thread-Topic: [PATCH v2 10/17] crypto/cipher-nettle: Implement AES-GCM
Thread-Index: AQHdFAq0Ca6722eZ5EKRna+Cx0yEsw==
Date: Wed, 15 Jul 2026 03:33:29 +0000
Message-ID: <20260715033311.1648424-11-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: b59982c7-bee1-4cfa-60e1-08dee221d6d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: EDVq9hukrgtCef/HPa9eYRWnr40KA07yamP6e0RmnA5+xX20X0wSxuiHSjhCUgMt48B9vbKHPJNbg1P0Z7EYyRl8eQk8tZ3CiBmKFGZgcsz5Qded4Rafs1hPx1x4i+z5PnFCKGahqGCnkES5wNuvtpfobHavaTTscPrpne+aCqvI7Je/lkCAf3v/J1QsZr63b+zxRfRbF3IH6LbPl3Vvm4QquR09uNfCTLD99KYGW4VcHNvqRz9QKbB+c/V1qpYXX+o8hv1l94HA8mTDS1Z3akt0hPrkhyvICDDGeix1gQsDsmR+VErftUC8eFnj0wcUho9Qi6em5toqVwbnG79a6SaxjAlX+sjBCu19NJZhoRZBQuynGuT1dnUAjxXLiFVYPqYX/MtoHZLgRFdieW7LBDS+cXcH8cWzzbi4MlZJyLXbCw1kd3uA/JRKXwfIaPVw5if88sAkfA4NfZMdI0OD/lYf3sYmjR2TFXZN+WtIws7LZV7THVitV5y7dPFUg0oIid0LNClo78kRpKArk+O1TS0aoKGEaGuzoTSAvZfGvZ/VGJJJQHVJAlxjIGi7owXzcpoeq5u8gjP6SbTYArymtO4oBnL8HpFnE8t5xbA5Gx8DaApTZ5QEaotOGWq96DLn9D74dDKw4P2VhjvFLvo/EFXHVcGB+xVE/cz1gQPr240i14kiMGZWYeJXblXqPQwTXHVvsoFPbU7zCkQyBzJP10Y2qCiXDSa+k0/1Syn/Quqs4E9FhBsvswk/sx8upf4W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1ia/7dFCvB5ztSgvEI+fv+kOmowG1+EfMkc5Lw5ZRRcja25Eop9Siqt7bH?=
 =?iso-8859-1?Q?axopelwUZFxZeSmilu3mOuVVlf2tBnTMKgixKRVKXBf0TQdlsbYvfqaF3q?=
 =?iso-8859-1?Q?B4SuEXDs0N/XNut17U34woKVxdBlwUnCK6oLl8r5tXGd/C3VjtZIRu5/lQ?=
 =?iso-8859-1?Q?4aCB6tCEA7rVyIxptkYrUtJbnQQwhyx4xLwYaUkppOiyxuPFv5vd1+sjHM?=
 =?iso-8859-1?Q?Z0IGgsOAEmsaxU6Jc65k7l7bpObqk3eL2RhidL60l6I7YaCvl9hrqt/yrQ?=
 =?iso-8859-1?Q?Oc6SGPhabc9kOfEHniqbxar6xuGNlG8Hrr+r856BBTibggiOYdsjuTYdEC?=
 =?iso-8859-1?Q?kSQfkYBdHAbVLuOgf8zwYFTQUiIMnd3R7FVLCF4sbDQRdJIYgPnPY2ZY/t?=
 =?iso-8859-1?Q?7u0gZ+5G7NsItg6bIQgvqHvoNMleKX+RSnss+l15HFggluM40lFmkQ/fPm?=
 =?iso-8859-1?Q?mVQNLnrN0Syk1tWcZyVNv4gScHw7+kCqeeD53Jg0FJigPuQwl/8bs4l/jN?=
 =?iso-8859-1?Q?I8M5ycCTD0LS1Jx8zvzZYWzIRTlaJZeeaX1XE3/7qLOoERM0ZebT0KC/7p?=
 =?iso-8859-1?Q?dSJak5kxYBRUa35RDGdgKMU3OG149TurVdYLxYc0NjLr2Is2s8PFKG4xRN?=
 =?iso-8859-1?Q?bcIr9/Gs2rL/0F3McwZLO6TMz9/fPYa5NkFbOZMzeor4xZ71/DwcN5eIhU?=
 =?iso-8859-1?Q?9PBiwT3ttaYgZLF6aMivhRqHYAr8Y7Z1aH32A+AQlYWZDxRp/i8fCwrQ13?=
 =?iso-8859-1?Q?4lWUnlm6hG7+FztqHEXGr+Lnxde4i5GE0rnKO7R6YIATLaJKqcWiphfJtW?=
 =?iso-8859-1?Q?DNi0xTxMDSOZlHDAV5FJdURPXaoI0q2dI8NwO8lKBiKatia7lGHfHbTfBf?=
 =?iso-8859-1?Q?bMThF0Al4GwWdQELwSdVIDECtfGovT6MOVQfpZQyrwbnDFFyWhc/NwnDDk?=
 =?iso-8859-1?Q?qNAjfzHunLK0zRo8Dv3+NcXOydbe1ADH5sdresBmxwx9fO6/tIO+70Xd7e?=
 =?iso-8859-1?Q?gg16SBMfTgfrqShZZw9QWm+I9ky3lOtgUmHE2eHAXv671l8FoXjyqa2MUV?=
 =?iso-8859-1?Q?jyjTKxe5AnHss2JtWec/eEucOYKzK8Xg6cE67uNtjJwEFeXHQK6Mo0B0Sz?=
 =?iso-8859-1?Q?RiDFH8kmytucWVElQjOA0hzVaxmpQf34usx/joaiwwIt0d4a5mVKJaSDsg?=
 =?iso-8859-1?Q?FWU+bZOIvioABP7VhJctDX0PPWqyvnapotlTJz1kAo5Xhyh+6EZSMDzGbU?=
 =?iso-8859-1?Q?0Uu4aVw6yV4NmTm3lkUyV9F/B6LWwmg6ag92s8ogYJJUgAb/rhxUMRuMLH?=
 =?iso-8859-1?Q?gyo4oZuaxDWLsoZvP6mtWqhu36XyqlNTvoqbwMptIAcD5AN2dmB2ANyZA+?=
 =?iso-8859-1?Q?HN0VkAJHfaVllDI3yQxxllrOWNPvEzgMlrxP6A4O1Fh4iWeFbEVT0YJJ/p?=
 =?iso-8859-1?Q?szqSY7bxUzN0fk6HlhW7sqMVmTvu+Bi6FxEFg51ibMxveefT+oFbhyhTh5?=
 =?iso-8859-1?Q?8WI6sRSFP13Tbi5GQEWYzddsfIKWgH4w7sH5nqNJime+earXjPF9PLjoqj?=
 =?iso-8859-1?Q?hWApO4bOrzi7QU768uBu4s1mNoz8qKw4+uETILdZiaZDVBPKdTsfQGbQTu?=
 =?iso-8859-1?Q?8Ovxr6S9w0YonP25BSKHx2U6E1GoAJ6uFn4DNeZBPZE/jvxtZZI3m+vtP+?=
 =?iso-8859-1?Q?tFfCwuKzO9rg4UoMIQIfCZq8bmiUaEn8vCcSodpsTejR5dDO7YKdBlFuXh?=
 =?iso-8859-1?Q?zkwEirIw+UwJsVBoZOVdUFltSEzI7OEM3+6BVtUVAZ8CZk/aPCpFjc93fi?=
 =?iso-8859-1?Q?zPkTYP/ARA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cop0QyxmU1gab2+xFuCH9L4fy75H3ifSbWgx4GTSNtUxSb+5f3KUXbIJvT6S9pkhmiyZnP4DYJqzlIcIS4eh9bIQteMnGtf0EBZhZcrLIRQAm15aYo7YkpnqaJ8UINUSWl7MbDT2TZKwmq//QUA43bK3aZA6dd2n6ftSgJLXlS1K++0BvIxbPEtDzQ+W+7xDUFairEk0opO6RvOTXCdk3V+L8QJWLJFB34WB0Nm/3GyLn+asD38O2wd0La5Fqb7/AWQ80/flsxFXFVDWtlfgjAltlk1Sspl7D43ly28+ZNV6Ic9bBsokQ2v6dnCHIVSQqRe8WPRGQCSeVAiKIZ/IYA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59982c7-bee1-4cfa-60e1-08dee221d6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:29.8009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgiV6LbLOM6QaVBxSZhVf8uDXEUjxB0gzm2vB5rX4bhI4EXA5H/u/Cze1JZ5rqQlSa0WJdzdrwJwsJ4KxWir6Z9hvz8dsRxMNQ+450OmUjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
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

Add the AES-GCM AEAD mode to the nettle backend so it is available when=0A=
QEMU is built with nettle instead of gcrypt. GCM is driven through=0A=
nettle's generic gcm_* interface, using the AES encrypt function for both=
=0A=
directions: gcm_set_iv() sets the (typically 96-bit) nonce, gcm_update()=0A=
feeds the associated data, gcm_encrypt()/gcm_decrypt() need not be block=0A=
aligned, and gcm_digest() produces the authentication tag.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 crypto/cipher-nettle.c.inc | 128 +++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 128 insertions(+)=0A=
=0A=
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc=0A=
index 1afdc391b4..d4847f0efe 100644=0A=
--- a/crypto/cipher-nettle.c.inc=0A=
+++ b/crypto/cipher-nettle.c.inc=0A=
@@ -27,6 +27,7 @@=0A=
 #include <nettle/twofish.h>=0A=
 #include <nettle/ctr.h>=0A=
 #include <nettle/xts.h>=0A=
+#include <nettle/gcm.h>=0A=
 #ifdef CONFIG_CRYPTO_SM4=0A=
 #include <nettle/sm4.h>=0A=
 #endif=0A=
@@ -410,6 +411,125 @@ DEFINE_ECB(qcrypto_nettle_sm4,=0A=
            sm4_encrypt_native, sm4_decrypt_native)=0A=
 #endif=0A=
 =0A=
+/*=0A=
+ * GCM is an AEAD mode built on AES (128-bit block only). Drive it through=
 the=0A=
+ * generic gcm_* interface, using the block cipher's encrypt function for =
both=0A=
+ * directions; associated data is fed with gcm_update() and the authentica=
tion=0A=
+ * tag is produced by gcm_digest().=0A=
+ */=0A=
+typedef struct QCryptoNettleAESGCM {=0A=
+    QCryptoCipher base;=0A=
+    struct gcm_key gcm_key;=0A=
+    struct gcm_ctx gcm_ctx;=0A=
+    union {=0A=
+        struct aes128_ctx aes128;=0A=
+        struct aes192_ctx aes192;=0A=
+        struct aes256_ctx aes256;=0A=
+    } cipher;=0A=
+    nettle_cipher_func *encrypt;=0A=
+} QCryptoNettleAESGCM;=0A=
+=0A=
+static int qcrypto_nettle_aes_gcm_setiv(QCryptoCipher *cipher,=0A=
+                                        const uint8_t *iv, size_t niv,=0A=
+                                        Error **errp)=0A=
+{=0A=
+    QCryptoNettleAESGCM *ctx =3D container_of(cipher, QCryptoNettleAESGCM,=
 base);=0A=
+=0A=
+    gcm_set_iv(&ctx->gcm_ctx, &ctx->gcm_key, niv, iv);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_aes_gcm_setaad(QCryptoCipher *cipher,=0A=
+                                         const uint8_t *aad, size_t len,=
=0A=
+                                         Error **errp)=0A=
+{=0A=
+    QCryptoNettleAESGCM *ctx =3D container_of(cipher, QCryptoNettleAESGCM,=
 base);=0A=
+=0A=
+    gcm_update(&ctx->gcm_ctx, &ctx->gcm_key, len, aad);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_aes_gcm_encrypt(QCryptoCipher *cipher,=0A=
+                                          const void *in, void *out,=0A=
+                                          size_t len, Error **errp)=0A=
+{=0A=
+    QCryptoNettleAESGCM *ctx =3D container_of(cipher, QCryptoNettleAESGCM,=
 base);=0A=
+=0A=
+    gcm_encrypt(&ctx->gcm_ctx, &ctx->gcm_key, &ctx->cipher, ctx->encrypt,=
=0A=
+                len, out, in);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_aes_gcm_decrypt(QCryptoCipher *cipher,=0A=
+                                          const void *in, void *out,=0A=
+                                          size_t len, Error **errp)=0A=
+{=0A=
+    QCryptoNettleAESGCM *ctx =3D container_of(cipher, QCryptoNettleAESGCM,=
 base);=0A=
+=0A=
+    gcm_decrypt(&ctx->gcm_ctx, &ctx->gcm_key, &ctx->cipher, ctx->encrypt,=
=0A=
+                len, out, in);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_nettle_aes_gcm_gettag(QCryptoCipher *cipher,=0A=
+                                         uint8_t *tag, size_t len,=0A=
+                                         Error **errp)=0A=
+{=0A=
+    QCryptoNettleAESGCM *ctx =3D container_of(cipher, QCryptoNettleAESGCM,=
 base);=0A=
+=0A=
+    gcm_digest(&ctx->gcm_ctx, &ctx->gcm_key, &ctx->cipher, ctx->encrypt,=
=0A=
+               len, tag);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static const struct QCryptoCipherDriver qcrypto_nettle_aes_gcm_driver =3D =
{=0A=
+    .cipher_encrypt =3D qcrypto_nettle_aes_gcm_encrypt,=0A=
+    .cipher_decrypt =3D qcrypto_nettle_aes_gcm_decrypt,=0A=
+    .cipher_setiv =3D qcrypto_nettle_aes_gcm_setiv,=0A=
+    .cipher_setaad =3D qcrypto_nettle_aes_gcm_setaad,=0A=
+    .cipher_gettag =3D qcrypto_nettle_aes_gcm_gettag,=0A=
+    .cipher_free =3D qcrypto_cipher_ctx_free,=0A=
+};=0A=
+=0A=
+static QCryptoCipher *qcrypto_nettle_aes_gcm_ctx_new(QCryptoCipherAlgo alg=
,=0A=
+                                                     const uint8_t *key,=
=0A=
+                                                     size_t nkey,=0A=
+                                                     Error **errp)=0A=
+{=0A=
+    QCryptoNettleAESGCM *ctx;=0A=
+=0A=
+    if (!qcrypto_cipher_validate_key_length(alg, QCRYPTO_CIPHER_MODE_GCM,=
=0A=
+                                            nkey, errp)) {=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    ctx =3D g_new0(QCryptoNettleAESGCM, 1);=0A=
+    ctx->base.driver =3D &qcrypto_nettle_aes_gcm_driver;=0A=
+=0A=
+    switch (alg) {=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_128:=0A=
+        aes128_set_encrypt_key(&ctx->cipher.aes128, key);=0A=
+        ctx->encrypt =3D aes128_encrypt_native;=0A=
+        break;=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_192:=0A=
+        aes192_set_encrypt_key(&ctx->cipher.aes192, key);=0A=
+        ctx->encrypt =3D aes192_encrypt_native;=0A=
+        break;=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_256:=0A=
+        aes256_set_encrypt_key(&ctx->cipher.aes256, key);=0A=
+        ctx->encrypt =3D aes256_encrypt_native;=0A=
+        break;=0A=
+    default:=0A=
+        error_setg(errp, "Unsupported cipher algorithm %s with GCM mode",=
=0A=
+                   QCryptoCipherAlgo_str(alg));=0A=
+        g_free(ctx);=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    gcm_set_key(&ctx->gcm_key, &ctx->cipher, ctx->encrypt);=0A=
+    return &ctx->base;=0A=
+}=0A=
+=0A=
 bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,=0A=
                              QCryptoCipherMode mode)=0A=
 {=0A=
@@ -440,6 +560,10 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,=0A=
     case QCRYPTO_CIPHER_MODE_XTS:=0A=
     case QCRYPTO_CIPHER_MODE_CTR:=0A=
         return true;=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        return alg =3D=3D QCRYPTO_CIPHER_ALGO_AES_128 ||=0A=
+               alg =3D=3D QCRYPTO_CIPHER_ALGO_AES_192 ||=0A=
+               alg =3D=3D QCRYPTO_CIPHER_ALGO_AES_256;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -451,6 +575,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCi=
pherAlgo alg,=0A=
                                              size_t nkey,=0A=
                                              Error **errp)=0A=
 {=0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        return qcrypto_nettle_aes_gcm_ctx_new(alg, key, nkey, errp);=0A=
+    }=0A=
+=0A=
     switch (mode) {=0A=
     case QCRYPTO_CIPHER_MODE_ECB:=0A=
     case QCRYPTO_CIPHER_MODE_CBC:=0A=
-- =0A=
2.43.0=0A=

