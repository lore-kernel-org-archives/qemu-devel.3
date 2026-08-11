Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587BDC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtctC-0003m9-Kb; Mon, 10 Aug 2026 23:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctA-0003kv-QS; Mon, 10 Aug 2026 23:10:53 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct9-0004JO-28; Mon, 10 Aug 2026 23:10:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLoMfsfSbT+pZExG6/rxNpNAciCSACt+5W7H2VMfwKUkfQi0gJ0G+K+A0kImDtPGYRwtO3fxbbVe/uuMLkr43esRTbvtLqGlmzrZT6wyNfDc8Bq9gcOk1iyFHUBjaPh60EOAVaEVtuO5dWjwypyrcXlhjNMoz0RGbckEwNqpYcVRK9aOT4dQ5fxAFg6e/iMna6LlrxI8NYflUrzNHfAm7nHp/Uf3yCMNcjp2mwQOeE8glQnvpcCzDkAd6YqmJg6nz+ts+BTFKwDgGUzbmOIlndqSwA5yjmY8wMd2t8YwrJmcZIr1M3jaDU1Qil/cahm69GUgZ9Ito2iamRRed4KPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylLtRQT5uGzVj7u9wCYat0H0DTWZCS106M4GG07Ksr0=;
 b=lmnWULCzmpIfLHiegbbJcd0t05B79sXD93ouD0crCZ7vjZs/cRmz5Sza3T/TZ2mHf3r2Z9dBrE0jIXlgyFE5UDQc0Yx0a816snLx1Omrp/knqTU+aj0YEmSZgRBOQjiUzwpz9Y9Db534r884YqmAdMEg6XDEdf3ztejAHeUpzsy7kJEoiivvQS5rtyPWbRuYzmyySrL4JqMbTG/ITeScJLdUcHIECOTSdS+jvVqc1+DOaZqV04MrIIUDIiaGsRW68HewieZr8l4NmI1esbsQfdXFYskWfLtnh9cxjTLGJ2VYAWAYy3MLsqfT9pKqfx2ElcVBerpSk+UtbLdEErrXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylLtRQT5uGzVj7u9wCYat0H0DTWZCS106M4GG07Ksr0=;
 b=E4zk2pEEnpWcD3gCgPOdDbdgWFwdrwok1wzSg7+pgck2NrI955j0nDPZatyZ741C+2yPZmsHebJ1ogP1YBxOMvA0Z2KT5zPZo7JkAMaynpUMQliARWqS17Fo2O0nTTuvPa91baOk5S+Z1Si4qu/CyTV+3nt0byl3WidiKNLZK9ot2B2EJk2JIIKdb+vy1dyn0zZCgwbvTEaUiVLqBinE9fqENvwsM3k0yhYa0ieVJ5pwHYvJpMhXfcRTdKvFkpwJjYqVqZioXtpO6IpRX1jRKTw1ouz0unmBPHIiXa5e2Flh+N4Uo65SYbzNMcByrLjKdSl/adOsP4NQDN8fQqBHRA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:40 +0000
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
Subject: [PATCH v3 10/16] crypto/cipher-nettle: Implement AES-GCM
Thread-Topic: [PATCH v3 10/16] crypto/cipher-nettle: Implement AES-GCM
Thread-Index: AQHdKT78JQotDdA1ZkC2AFMsxdIplQ==
Date: Tue, 11 Aug 2026 03:10:39 +0000
Message-ID: <20260811031025.2784489-11-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: 7a8bde01-23e9-4ce7-42e3-08def7561f6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: y6mmQsokkQL1gpEr5JMVBfE619bzRDxCC5saOcPf9A1eObCNbubtQMFQ05KdWMyMHdyE3eEztZY1PVyDA4/1cuw66mirq7L6YKBIUbA38L/tQynmYP6rK/U3D+vmiI7fNuLr/CTrhsggQf6223XBnvlBGMByE7LqJIZ83rCCozaKuXdcPgvXEnIGr4q9VQKdsjGt9p33tehWaAvA+kSWu/YaGL+auCOvM+zv4mHG6DBB5vi5ExS8xuH3r2bBE0JOEpjPlderRXWo19ybPct554GUUHvYvb4q3SONR/cfeaVR7IcDSCLxhDOZtoBOuAuPvobCFZkeMkHWiAw38yg8uyp/Eiwzij2LHP/+S5XIKyo8KfZlCSUD3DV0tAgWSenGFr/GuErfBDNrz0XLZS8hGGYh3EMyoU6kQs5Z9lQHyVQ/OL12+TYDNyc7+MneeUMZgDQPqQQ8BFwalcwt/5oo4X+n712SczV2Rp+AAsP3+i7AKkQML0x5x+rV81sKzxN8Jp70/WutJGABIoeo0rH/kCs+SVJt+kPzQEtrJxQdV6WQaz/cjhb55mFLWOG5lMSmwocoz4qlbBy7PgjKONcR0J6rGqbYIkoTYE5jSGViro1xBRYIFhFkdJz8copV9Kohml7Z4+C2CJvXllzVT6X+MiEwpUx/0cwNIgkP7mOvws1riefAjU5cGat3UKY8XKYzeWx3GNhUcnysP0L1V84TS9x+pNadPWVyxxu8+8PktCWuZwt/4oyHz5ItCvw5zJel
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5voIJJGKgDMbTK2kxuG6dDzUHQtaeqWPCPM6c/LhtVbXRAGp+NQfvuc9NS?=
 =?iso-8859-1?Q?c+tRbZK5+xtQUyGbxr8iypNHQlVgWza5F8qvMhehRw1m+pPAvJXaxlrtxF?=
 =?iso-8859-1?Q?FELMFM0tHY8whABW988s+ZMaoapnrBgUdjs4EiTvZaQVFUBOlqFpkXWSnw?=
 =?iso-8859-1?Q?pZ7NN/UX7k0KKt7OAcYw3rsGfWbT3xWRJ7/l5SOVBZ9qx9rV6SlBypy5n1?=
 =?iso-8859-1?Q?kV/bDxPS1u2nqSd7wcWZP84bZRjzqrZJp7OQmVgDQabYToqtMc5cV1Q99l?=
 =?iso-8859-1?Q?0uvj6owMlHPMV4c83f653nFAHgIDyEojyeKT9NUzLulqPz0922iUAEGwud?=
 =?iso-8859-1?Q?gwQaq2hLvFlP2p+wx0LDdZZorsnN8EHWMiDVBC1fcldOKSYAIrjl0UYc8O?=
 =?iso-8859-1?Q?oWSPJRUw8y1fMJyDHHi/pe5FvK7HrmrYlXxu3r6OCyicakvqAUtiAT3k6y?=
 =?iso-8859-1?Q?y7HmzbTsuzgghcy6ytGXdR4illrxVJacXqMxULGqKJ7ySYccYJvqUduXNN?=
 =?iso-8859-1?Q?HkjbKtg7mNxN3eRe82hEeZYWvIt9LaOmzis/jGgdI9HJsgGy5yGt8db3nQ?=
 =?iso-8859-1?Q?Gs2iJ1TmCl8WQJEEhuk6OrM43NtquN2WCEWAlHDcKw8wZG/38nyFoePLMA?=
 =?iso-8859-1?Q?jSb8p4i3YJC25JP6QFQzmztG/mmmR5SgsjWZcpHzeFP90l6HvCg1cZ1CTr?=
 =?iso-8859-1?Q?WNS57cNDGkXvL+/391QXSOORyyrLnDat26m+xUanPxPad96pGsLEPccypT?=
 =?iso-8859-1?Q?BdQVs03mtij2+JPKEh9QyG+6gSuHwwNB0w0T4gaBA5+B+4I7YGVanv8SET?=
 =?iso-8859-1?Q?OjMsTfO1kVJAYDvU3TGpTGXYBXk5vjFErcw5oULAt292FZf/+Dzxdiaghq?=
 =?iso-8859-1?Q?r9nPQp+h79pRBKU2dIXU58HgEgSaN5ZcqCCKT/2DrW0Vzxb2oMeYzIiB0H?=
 =?iso-8859-1?Q?EWa1qx/Feza/tl6CQ2dyKYXNlrsMEngoE9RIylGqLuSjDS9N7kmXKY/dW1?=
 =?iso-8859-1?Q?aM+ovN64Vd1bZrxX6Xy8o4+t7cBjQNyAOxGPf381ha+ehadDWH8TrjbU72?=
 =?iso-8859-1?Q?ox0t//UbYPYqEL0C9jP9OciutKC283wKq49RT9SWpIiMNkPm7XgaxOM7NT?=
 =?iso-8859-1?Q?YpDFdntXS/KDTmX/YCFDTE8Oq7rIpwWKrVSblbzZkjkhAr6WiOLWW5AwZs?=
 =?iso-8859-1?Q?h1qwTOyNroYbgktlzykhflUII18aLDlalyXjW7ndAKQK91Gv4PmEQqwQvT?=
 =?iso-8859-1?Q?oycs3hqMWza3j87tyCi+ivs1rTQOLhexhlSfI0ULIabENtiKKe1A6RcWsd?=
 =?iso-8859-1?Q?/4dDycSx2XYyQvnv3r3ZQUvhzXdMpa1bL0AXcxu/xLCL2w/F1d3ZlRzUte?=
 =?iso-8859-1?Q?bsD3O6vEt0mekORpTZOCH1tUww5XpToZKjJOunsLtFRQO5VCAWSfza34Ws?=
 =?iso-8859-1?Q?edTlqg066ADSFRQz4Qf/TTJRlAeo9cNrMsKisZVyI+BtZ9D7SWTJc8c+jA?=
 =?iso-8859-1?Q?yCpriQ5TDokOaK+Br4EHM/YYEZ2gRpGjxL2H25hnFD33YVLnz2474jgHdC?=
 =?iso-8859-1?Q?c+5VlZElU+r+9aZ7ab2zBD0mMzEQhwIVKiqAgoiamWK/T9/mz7aVNzRx33?=
 =?iso-8859-1?Q?wK0kACoMIOf3mJ7W+jM2oxywOiAbhsCrSR2r7aqX0dhFWdNSRUQaAJm8Q+?=
 =?iso-8859-1?Q?coitgJXLxJLrFgkHvOhJDkXtzyTmyOieycV6BE+cI4pQwZiw1iSP26aZTy?=
 =?iso-8859-1?Q?L/uvizLKzE/sdbeK7rxX/seBuGBcWNHQC5pLoVklANeOffYesX2PRGVNNP?=
 =?iso-8859-1?Q?xcPsSevruw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QC9Os21eEAL4X84FR+cgxLcsk86BPV0xP5LO40Ma+8xOJwJyUV1NN5yC1iCQ/mhd0C3jw3aWFOKi0r2AkxHfBnynI5S6vG4LXlQI83UEL+F+T62KuEKqJIsqcVGfdDk7XPOBKJh7Q6SNKofq8WRknD1H5uS36ySJwyf3RzFP590aTyVr0HPKXub/y4E2Ob//GJHiamI7pUjVpHj5oGEY6SvO2q44nHcF6HX9EKQ1oICQYZhNBjCP7M9PJ8R/UCD9kQvPek6afrsW8eZ3OHogiL4kO4jtTfQqVxFCbBWzaAUqMDIBXqxgBhbikkHChhrOCYCeyvNk+adA7biaDQZg3A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8bde01-23e9-4ce7-42e3-08def7561f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:39.9471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzH/V+US5WnHo2EAa6RLBnodzrgWiV2FXcr26bxFZXL52wSlmQrupU6dL2IUlvhAMFL5irofD4FjG2UuLmkJaLGgr2YvrcHM4J2EvJ0+3tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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

