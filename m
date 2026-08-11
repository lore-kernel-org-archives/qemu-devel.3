Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370B5C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYb-0007Sh-Hv; Tue, 11 Aug 2026 02:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYY-0007Qm-Rt; Tue, 11 Aug 2026 02:01:46 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYX-0002ec-69; Tue, 11 Aug 2026 02:01:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKJ7zN1J5tWCD1RQSAFW3HTBQ6RzWtkkPVaHcpkq/uqY30guYGutWckU0QnjZDyffMwWliB0NzChUPQ8TaZWWHtsDyG7tirQ9FWutSNfK/pMMNEso/17Pj5frW9gpJD1/fod0nmgN3t/bFrMwUvztDeutbQxur4688JZseIbAYzXNslNqSL+SICDo/n6Hno7sVyvpopvkyaWlF9q3OoK9PdiRucVSdh2zBfFKxBvKq7HsxDxnjusmCS3lx04uQjK8qboX2hc2CYgMQ+d4QucPuyCncdfrpsPc2/2DMLhi8fRRj3iN7dO2AojKYnrR9WUI/utd/EpPw7lwRD+SkdcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylLtRQT5uGzVj7u9wCYat0H0DTWZCS106M4GG07Ksr0=;
 b=RVmTonerm63Kf7d7vxRdu70XuBGM2a6SHvhwzwQn92FOmh/WJX//l8DdI89486h/iwMTvu98qGQqzno4dyQ7RJA+liBlxoKpBkGH+DohqJhofJYMuw0qv6RNVj/X7X8JgDBrcIo8ea1vutf/BehVcxPjebuFn1+UWycHgUKCMuY7KPftJ9lRJ/RN2i58AkxZ77tKoudG0qIhZUG4LW9ly3f7ofbgHEGl7ObHIJHwVO6njIPU6xr9A8Hn9Sf6T437cBG+EwuZ8sDDw55lbK24lk5MiqFigP8+HAg0MttoIXgFb2+FkLgKNVIDuTLI7hq33iYhCWAWCPYeTLbDHMB4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylLtRQT5uGzVj7u9wCYat0H0DTWZCS106M4GG07Ksr0=;
 b=iWbls3h4k1lV/P15TRSTSx7hZEzSA2sG4cW3BBtluEnvpiiqIYG85O1FEYHN6alsNihu+LPYDPvw2BNAHgTx1FVs7/ji4AfRGoSriaUw9aC2rtyHBDjyQ8gYkuu7G0v0vmm/MDVfsWx5srpXVkad8lN5DT8vndSoaowlpmw5reHe84KT+JkiH7Z2rlqw1x49J+sUngRSgAdntWWBVj+xKOqcb8caYTLfNAMuk3MKhgOtDiWDp0xDkdrBDzf6vHfMPXwPsf6LezZLKCumVR4XpY0T08A6ZOV0kdfxi1gKWroBY/F1mDquzeaBOmnrhvBEs7wqz4pXsUfT5yw8vftCHg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:30 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:30 +0000
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
Subject: [PATCH v4 10/16] crypto/cipher-nettle: Implement AES-GCM
Thread-Topic: [PATCH v4 10/16] crypto/cipher-nettle: Implement AES-GCM
Thread-Index: AQHdKVba63bzY74boEizgtd1b25EVQ==
Date: Tue, 11 Aug 2026 06:01:30 +0000
Message-ID: <20260811060115.1849266-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 3a8e23fa-33db-4d32-c9d1-08def76dfd6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: fRRCOXREkVpt0mpemSbisinwrNbYxkEvtDxU0Uf95gdiBkfC3c/iTBgu3hbez6/FDzs+hYB5GZdr3KYutDJ/VNoJsaDX+kqrMWb7K/2HtjvXIqx7v2l28JAU3LlXEFxngmpmFuaKnHYjm3jE2ZsB2HxVub3K5XrLD7I1/iA/UEZLDprnAtmhwu2IrK80PUsLf5HhwBIR5+WSt4kXNY6n7NypNdb7lpdAI5A1yd5+47XWsnDbZcHYvWiV0Ja+vAeOxr3nr/at9kloZoxvWN3VfPCDWHLOiq+3UnDxpirRGTq9vGFAKn2BqrfIWEv7eoHwAMo0ARofC1V9xK8uMKgR19eTahLvUCSGigzMlBWsbdkM5/xZHcPyo1oLX+SmhZubdb6UF7WCsImnltXsvjyTkUoF2yNs0dTFUeiHy8I/QwrvQkZX84r8+GKwCzHOVvwvxgDHN3W9h9MegygZUIVPA6QOgBrbbi7VWagwvb5IF0fmNfvhLH1a6DE1ad8GWC1GhWfuEN6V5NFAYopl8UOa5WlqA2CLS8YTcJ65QzGOXqDk6j/WX9vdPIurGa0g0Iqk9jQZi7Hw0uRbEYMSl8EJWxBoEgp4hABxJ1rhNTuSPr8eZkM1vabh3S6AI76olwV13bLU7UiCeUGyUVLys7N9LHFTbt3dKCLSUj1nR3WCQ4nKcw0htdRa9HHrnwozEO/u3i9HpQniPpDUMs6n1q1DTQviUUjV8BvjAnMfYhiQraQq7Cm6cK524Y7ppvt7vqCC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FLb9YY78nm6R+WmziujctBRf+CFP4RblWv6txlZlplyeREKWfuG59dVJqh?=
 =?iso-8859-1?Q?APNMiTRI8cvt8gQNaK7qcPxr5iRGjgaqiZ6xbQw3PGRhPcEPT0nWB6AR+X?=
 =?iso-8859-1?Q?5zUSTQWoWMdUlpWJ1v9R5mRhfBqEsB0xOaVSv8It4RxfECH7xeyE6tH8HL?=
 =?iso-8859-1?Q?2cHbGLj2OBH85YWt6MAYWSICbkGU9tUF+R0A8ZJHmvTadx4bOfqyOJDMi6?=
 =?iso-8859-1?Q?0Kzaol5gc0p8MuKtJOfR4Cn3lX8lF/tyIZqlmNlycmTvxDVtD/uHsovGjv?=
 =?iso-8859-1?Q?ClgGBSYDwf2lYNXvPi8730Z58oqgWPKPyyG0mMedPNoKKjE2/tLG6PmWt/?=
 =?iso-8859-1?Q?uyy+XmOchBYcfxKqebIX8L4+Ha1e3ERzrz9Nk6TN659y/1JVZpVKkhNGhi?=
 =?iso-8859-1?Q?dyE9ZKxtg9tDa+85lJmyxP5dplzOib3hOCTRvg8njitbzBl5k+7v3908ua?=
 =?iso-8859-1?Q?/6xNr2wFrqcXILhyYjk5rxhPInxSC6sQ5YmJM9IMfAJmjWumwB/cTYXUbM?=
 =?iso-8859-1?Q?2W6DGQP4Fb3ZAVll24fHl21xODUsOiWiUGWbA6GeVUjXt8xD32gFvE7lBw?=
 =?iso-8859-1?Q?3AbJW1BlIMUF5OVJLq67K55rvi/22q40CV851ve9eVQ1EVE9dDmnCLN9/W?=
 =?iso-8859-1?Q?9ivOSeF7fPFF4A5uq+pm4WqY6p4uDPjpzRT/cf4EGtDUsQSSSCb0ebSeA3?=
 =?iso-8859-1?Q?t/vwBDff3y5blQSf+fv8fUjtn3bPCNHiGqvLsKqmhvxwMlAXRyGlWe64pP?=
 =?iso-8859-1?Q?QKXlDzx9MBYGL2iJarK/d5FRrZALg68w1/00pb2gPCyOyy3a27pG6k3hch?=
 =?iso-8859-1?Q?PVz/f0AsAVXz8wAekQc2Vn3jf6D4aaokh55ZRWNyXOIond3ORFz+aYPhVK?=
 =?iso-8859-1?Q?i+JXe3cloEaV5Xcn0OUYfgrrvJ2P9T1t2ZdjMRmIuHMIWG7yImpgOly1uP?=
 =?iso-8859-1?Q?48njNhD4YzkiBDnjDMLtx6Dmkqa0zxliUmeFLtNVfiWw2xWZhZLxmlvMYE?=
 =?iso-8859-1?Q?3Cp9JqKk30DotlZ791B1k+/0w0Imx7Gapqi+JLDmAt3EQHMa1i+gYOEGvj?=
 =?iso-8859-1?Q?/3QLpnciRDldq1VJ8q3x787zMYfggLXUr0PBBeCLS+nOiTZA287gyRyuO5?=
 =?iso-8859-1?Q?0Hh6+5RHhvOCWk15VeGUBGXQ6ujiGJhscvD7rdF0xGi4TrDHmGTi3+WmpK?=
 =?iso-8859-1?Q?XnZCFpyNnL9z5FrmgzXut4TG/oJnaF2doQZDAd+G+2o1mQZj1dQkRjJ2df?=
 =?iso-8859-1?Q?t6DO8dhMGmQqEVi5cu4PXH8nnucEj0s4KvFxzHeAcLLRaKY1mGk3RJWxuD?=
 =?iso-8859-1?Q?0si6NoYW8AvjGgVXlpo3uH4TFn0vtdQjT8IKXntVdSLigMiIjicxioJT8A?=
 =?iso-8859-1?Q?/UzCLG6G0NLqbrRgw+Cxx3G5Q6P7C4Z3/uyP+VgxZsejzn/TRbGztFF2Y3?=
 =?iso-8859-1?Q?L3ujYI5j/N2mUyXdJeWTw1N0c2PgnkNFaHkuNjv20QZOjV7vaK+12l4ydL?=
 =?iso-8859-1?Q?ugWRkAW2+tIj0cKLmL0aqL5xqwCrqK0477z0lTmUdM1qp2tIJqVnjNZruu?=
 =?iso-8859-1?Q?xX8NUIoIPXa40FcH27zYz6DJQZBWcCHfkxLuAQs+mT8Z2mJrhnPfWsiicl?=
 =?iso-8859-1?Q?B+3UMnlZhV1Yf/KgoQHh9Kwp8/B9aDgK80PFVi56y/FnCOHI/JpsYgnKde?=
 =?iso-8859-1?Q?p3OIWjhyQfuKBKsfpYE807D5wKomCrXkq5D8hq+89UTDx+QuzCSNUPEJge?=
 =?iso-8859-1?Q?WKCnyNbfOVvOTyQ64FIUTJvFJAKvbXzuEusKuNeRLWrlWYK25HKlYjiYG+?=
 =?iso-8859-1?Q?ROElWh89tQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dH4rN8R2O4v1rq4YoSQtrdpfKYfi4DreZd/3HG3m7QQF1Sula0OxrM8ssMlX6N/aakVErsfLvPUcl6FV+E/TfWx/DrDwLOwTq1loh9kjXTVJM3URHTF/ymXE0Fl48p688KCh/GLrgrhEZu/CLXU9vycBMEGuPo4Q0t7HLKekUOFCmGkca3GJDGBwXq/sIDO0b/Y+g0Fx9KGsI//FwlIKi4uN419tLiwF59Q9wPwnaHXAdrNI6p+ikvPxmqEV0o3JjRkqgyQOmoCcdYpyiWdCRLxiiiLBgwiCgGxSfB0qQp2qhgLmfXDravGy/EjEHRZdVEwcnm3bo+ArkkjT4RtY3w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8e23fa-33db-4d32-c9d1-08def76dfd6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:30.2022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/hK5nNuo/tEOyEQrhyu9ZP3s5M5U2HWB0zRKPk9dcGkhZnrvqvXK+epWjJjHbhd06NRjOqwKHMZvE7Mr3aI99Gf78xK1kSSkQvjP4Jr9mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
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

