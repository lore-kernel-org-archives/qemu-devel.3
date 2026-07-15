Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67EBC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNt-0003IA-GP; Tue, 14 Jul 2026 23:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNl-0003F9-Gj; Tue, 14 Jul 2026 23:34:01 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNj-0000nz-NW; Tue, 14 Jul 2026 23:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkNwHEz0yLk0/GU5tspBdNtXQMt1a+KRs4nnsQtO27ewRhvTgwaDwYPdGkLFTXZAMu272gO6/jKKL0ODXZnF0xIVJbCyQ1doooOLNeqUj9Mmnb+DKX+kMPfeJIUtQcwMKjBSXG4LLE5ZTpIBa9/iy2u61VrQXUCQtri1JF5kfGK0EmLPnWiClE7cG56sC9si8ynmdm6eFIpftXJ2ijwu0wQdugm5nDYXTvzLUzX8bcFJQuTEycUR3l2Y9CulxW4gImLx5TtGK1NdYfqQqjzKU8Gkvav2uJK3QTuClMRrB9pupBqHYJsgl2QPizaFidU/0qJ3OMRi8xaKpbN9kcUGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP88/4rPMg1FVqvGqTLlZ5jPpui4Td6aiKBJehpSof8=;
 b=NETvMxIB4mUjx8MC9ZtWmMTdG7KnAahqogcv/GZwmf8vXwbdBObnbb+TKQzYFXTzVKpnXBJozjanRluuYBtRosTBYzUnTQLrsOe+9q80YB2mRsnw7LYw0uFENxS4VU+7KJaRW+4TlzE3ZQPNy5pN0wpoGtgeeDoBuNxbtVf8GE9saLPLOO2UeTYMJ/Wx7Oivi5b0XPOT/NNjAM97aje6w9FxSPmoNMD4WV+cig+tgp04ZMcA0zZac8YaFoxGy1iy2M3BzIm0+n3Cy47sHxXQrEqHd4/xsOhm7dBdmIc/Emf8vpdA/5vN88w8Tpe/B46lPzIAdie7f8WzNZMxSZCK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP88/4rPMg1FVqvGqTLlZ5jPpui4Td6aiKBJehpSof8=;
 b=AZ9azPh46RtmHjtmrScHYlc6X6Ts46CQYYfD5UaoIEBsy3rtEwoVv7t2BjlVSqmwmqYPOa5HBJDp9SsWcuta9uATlLfn1iwiC64jdW30m5I10tLA5unW23oWJFMt+vVpLe3oLy3PkCffc1pA38+NDjvykn9wDfR+iEp5YuZfENwKdAXDx13sNCAHuHxyxQvntfuGafXkoi7aqJGjqU2ob2+g1XBVeAq8cInhvW+uTK3NlMC/1Ft35Ns3JLYAEiXSfCIvAkb9BdvXZ3YuaATIVhFzPTPPWFnPwzwzeCsC6SEy23ZH6iHp9zUeK25/miMYLsMaGvgYeh1qouZOmnUD9w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:31 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:31 +0000
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
Subject: [PATCH v2 11/17] crypto/cipher-gnutls: Implement AES-GCM
Thread-Topic: [PATCH v2 11/17] crypto/cipher-gnutls: Implement AES-GCM
Thread-Index: AQHdFAq1vRz49aUPpUKss5yCKuRwQg==
Date: Wed, 15 Jul 2026 03:33:31 +0000
Message-ID: <20260715033311.1648424-12-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: fa47b659-7d0e-40a2-cb65-08dee221d7cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|6133799003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: bscT1YUXEmJ58kueyqd1FVsiPKM6fV8I1HU1XXz4mvtLaxs70NRyA4UgyKFOJJvH7LZIYUMpRsgYGUSL+xnIQwsJmdOQbBJaDs3sttLeFXq3YdSGgETpE5vA2CRrU7ZbzFgLQnap1VywKRIfIXqY+FHLyC0VH8Ln5FyVGFT8is8BlQsZVUBgkASSF1He/yPaZqgJV9gaFjtXHyUlMqivUDRq1oGOiIknyBANt8wncu1ZpbRfOdkNeqshv9ttj5PbTtOv5o56+stGCCFYOp8eT82WnQvw5rKywk3FFnYR4BaDCwUc2SZ35ugAJ5OfskczmlhiXsTPfaHj7yudRzq2i8R9yBvGWlQ/csJgmBASbL7Zq1JLD4zA8uXIvNIOmvt7WCWhlCZ9zGDcS+9YcOv0Z41ahTdHXpiCJAHORTli1p11/J25g8S8DO+JmqZmJ2oGFdEgeNPIR5EcJCj8OMrfz2ev1Mf270DtXnJkx7mL4WBnzNaHb9NeTpGlseeXmsBV/l44rZBvwY+JCN5FlRjChFXnRChYPVu4mpMxlPNJli8lIpzpGyshmiT7vsL9DY/bKRtYhXOnIyuo9KfJDOGvYV044WsoIXNuQY0g8gdiQfOrOgX7yYiNJY3cpwfo3ux4avYf0WaeT7yl8wi3oz76o8WfvlCB4H7n5n7qAXXilNJjXvEq8eLO6dF6Lo8WaJCn9wR89qEA1nPMY8/z/mB5++9Utut8xbESYRxQfYrjCQ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XD7GmTROaVrIADgWZC5az9pw0NQqaSKlLlOZKFXMyaiZ6dZky7KEYa4py8?=
 =?iso-8859-1?Q?ca157cuwAg9Y9wN3pvjdY18f8xTEY/3+4JMWByIhj9+Fxjoac1lQLgNINi?=
 =?iso-8859-1?Q?4bTMTrQEA8NWPxmaXDkuVM2C7yJ8p4z2P5NgPyna0cTEWAHln+lmsW4WxZ?=
 =?iso-8859-1?Q?LY1sQrCGV+qngWZWTLh/Z/HkarZGdG7TNU5SPYWfNbfqspedfpTbr8/U+4?=
 =?iso-8859-1?Q?ohfrJLYf0Q2QAPKXRaJiC+f3WZpiwxqZ14HlPn3E6u3hMoBfqOIEOuSt8o?=
 =?iso-8859-1?Q?ro5z3nnwyNn5NsYEq/WLqRoppArwCt1tPF64mJAiuX+PTIXYYKf5srvZA+?=
 =?iso-8859-1?Q?OXCq8v2F78VSpJOa7G9lZMnpgZZIF8JDlXokQd7qNHZPJweo4WcWOQuhqc?=
 =?iso-8859-1?Q?c+QtqoPXaYXmQafAb6Vv51NBL9vOJF5Z5M4IukGxkxdXRefV8H83CKE0hR?=
 =?iso-8859-1?Q?8H7xX38ZUVH5JseBfkAuPFY+Mk39UA8vBnV3lOpeJOC1YDsvWI3zVgoZRU?=
 =?iso-8859-1?Q?t5+OJPhXDQd2yF3ofPibyG9SzrL8w9giKMR7ubP1Wi4kNH3nvHVw7MRaL5?=
 =?iso-8859-1?Q?0O/2KezDKMTidZU/ILfSH7L0zBFrrecN7X9f9OBtiMixDp13qMAnMvuAc/?=
 =?iso-8859-1?Q?3xxfz+juGGUjeWebFRycriO3NAQq/tL94yIVPMl8LW+LZpiLg/D9VZKs8O?=
 =?iso-8859-1?Q?dx3fWKB/fvdWocuF+IGPqHY8gdO4R0VmGdriNO790hqyJg66HTPXvV/paA?=
 =?iso-8859-1?Q?6bU+TT+Ln7ykyvpdI96oXBHKVxm3omncqBRm7kO2Y7/djIkxHRNw04fEx/?=
 =?iso-8859-1?Q?xhvAX7jqv1qfvgCob3TASyVlr1M+Bumgh0qYnGQTgx+5iO1rLWVmshZsFV?=
 =?iso-8859-1?Q?TiWHm7wHBJgdC7klqHE85ikI+r7EGXEHcghAumgoaIIPdYkBwPU5fdC5Xt?=
 =?iso-8859-1?Q?d/6D8mh2OSqOY9nRPHyQDAOh7lgGwNErZeb3qX9YfM4LFSIb/HmkC4tyiO?=
 =?iso-8859-1?Q?OxM42mvvLSmpXHx8masi1aqnSctY73ui9KkUwt38FR9Ev3ai29N+PmRjiN?=
 =?iso-8859-1?Q?HsdzZ/kJI2cBSOmlvuFJFOBSDWGGJgRrERNVoOmfkrAz9AL9OxzehojHuv?=
 =?iso-8859-1?Q?qrlBm1Vx58wzBe4EowL63ATBTpClNXbLURhNhMX3TJoQJ9c5OFEs/AjZkU?=
 =?iso-8859-1?Q?q4dZaxqLTDITC7MqhnMpkm1aSOECQRFJ0C7IJwVs46WGC2q6yOWVc658wX?=
 =?iso-8859-1?Q?nz6do9XnHSEvjroe3gRfD1bIHcYFMINNiKTG7Prbm0LIoGJscShZ3Qd435?=
 =?iso-8859-1?Q?GY4MTqeqtp89ukMoJoaqb3Em9zXRR37Q/cJ9ENTwXvFf0I5f8OMYmYvNbY?=
 =?iso-8859-1?Q?vcG1sGzUmWMz9dWG5w9xjcqU5cXbznCeaXi1tzBaKTMTwH3UpQ/zfgFVX6?=
 =?iso-8859-1?Q?jJ/A+99d+09o7cqueJKprBY/119eRWL8c0hKDVDl6unwRDfuYghsbaw+qW?=
 =?iso-8859-1?Q?1QCXxHRtXdTYXcq/GszZ071TNOfslJ9DEFWwDUr/aLgoqhU4Qr3bZz869m?=
 =?iso-8859-1?Q?4nDh9n8IdgLlelMqQkPVhuQf/7zfwzetEg0jQhVYnoSjdPY0euh2m6kl64?=
 =?iso-8859-1?Q?J6Qpp8HXcnwdbL0foTogteGkh9Fs3uhY95OMc4DIWCEq4ATL7MLVZEf+Oe?=
 =?iso-8859-1?Q?/dAlrm/S9JKH5fp0BALPRfRU0sgXUQkSM3qID685a9hMe3/66oZyP3FPek?=
 =?iso-8859-1?Q?qSIyFA7Xu5+ivmJfnBu7fOcfE4/PJhT9e0OpzPJNKHQA1j+lQ5HQ9+8yff?=
 =?iso-8859-1?Q?NmyPir3l+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IiCAy+zStOreaST4P40bXGgU+uuljHvbIpBV2qYvvizvJo4rs73+e+h3wxOYEE+/z63gw24QC3trqJj8zT2aMxv2Eo2Zq5AhbMrPY54rdG4ahceU0WhyTe1NpFtJZMnvYU6mpSLUvmKpGnIas39Kdda0+aQdVAzCFfA00X4rubCZYP235c6Syd/qZ+wAi6cKNNFlMNq9ZPyjWzCet3YXxZne93oNPuTxL2ROjc0JnjLvorluCvSboOcKJ0HwFzm3hmDMgPscPqiLxRdHU9KgvbA7Gk21UnQO23Xln6/nonF82wvpKvOoK0K6nbfyeiPEoCxVwrJxAimSNqt3iZ7Fnw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa47b659-7d0e-40a2-cb65-08dee221d7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:31.5254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owryrq2D82HfAKOWjWgbzvsaJNbb2LUtb8jy0zcNb691m4zXqa59/M2bdq2I1fnbm8YDXMStm8IOhi9bpRRYTU+OoAWqb5xHXQxs9+DcKIk=
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

