Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A5FD3E2D0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 07:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5h08-0004oi-DA; Tue, 29 Oct 2024 03:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liequanche@gmail.com>)
 id 1t5h06-0004oU-Fh
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 03:50:50 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liequanche@gmail.com>)
 id 1t5h02-0002IY-71
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 03:50:49 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so33263326d6.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730188244; x=1730793044; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qVLbWbPIqHf+ZZsIgP9gSm843+63gJc4LCL7vT2xgEY=;
 b=coaoufJ5+xaT8yQ8YVCa6wAgHjLboTLr/7fnLrdFp8VIb5r23LYRVblru6ixVXjWrU
 IhWTr/wBYEotwu4eBH1IA1PmkzrsuU5JroW2o61dhe3Fe2S1A9Svq6vboTbtMl59pzat
 xblMFuG2qxUuEUpJtyDSphU1qDOoL9NheDzm5yfK/wqiGSwE3WDzcqNH+FDNnf7dDLEQ
 CJgGDVF0gmVh3dxX8J6AUN3w/QP2avAMmSSeGQIjzYNsYYopd8Lruez0MOim7Hm49yL/
 9tkJgf7NYPPgoHf4jpt30YcLBGWiQBtOS+OLlW1S0NjuWIMHgfZzxNTFAJ0I3VMFThbE
 /qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730188244; x=1730793044;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qVLbWbPIqHf+ZZsIgP9gSm843+63gJc4LCL7vT2xgEY=;
 b=k/KYE3tiuTprujOHx45k7RrFuu1wTr6gbEt0FRKUjaQkOS6xk3zrHnFHCMR/hfDjGT
 2Ve5El3k0by0YYDk/NqT080II+P3Uq5brNDRARK+AvU7kkrHd8RXVFd8z5qAeom5TNYk
 wchcVnNJ5eo+Q7RBoaCrCvfH/smr5NHU2vF8SOexVeygpKUmxmMJWW0lA5yuhB6KaE+q
 omwVld0WutD4Vs9/vAL6E4j189C0EDWv2SpnNpx78g5+P4TevvS49RmoxsbJIr53E5AB
 CmX8fgrXKaaZZw6t47McYZ8f6jpc8WBOsvxfUKuiWeGS4f7qhv1jFe5eUrych3rzUGkt
 WbGg==
X-Gm-Message-State: AOJu0YxbZ0DYfbZap6EvDbc2js732ZCjkXWByhWXne2W7ANtMXkjtXc2
 iCd+9tZbMpuGg18SksCGzFtNIJgLJT5nJwPr0kifQY1VFYaDu1bMpsDopKJ67Q0xriOpMeDpiGa
 emanXK9MRf/aNm+PRzxo1Kyyylc1fBcZT
X-Google-Smtp-Source: AGHT+IGg3O4b5Vr42iFXe/Ni2+zEuysk3WZ+uzefp6C5Tin19OseS6JUTDubtluSmyConc8Ds1lvIppw/PmcIkmAwG8=
X-Received: by 2002:a05:6214:5910:b0:6ce:37cc:4911 with SMTP id
 6a1803df08f44-6d18567ca36mr187179216d6.8.1730188244276; Tue, 29 Oct 2024
 00:50:44 -0700 (PDT)
MIME-Version: 1.0
From: liequan che <liequanche@gmail.com>
Date: Tue, 29 Oct 2024 15:50:33 +0800
Message-ID: <CAAsfc_opwD26bx=9GiQbcuNT3mviySe-9t-rz3U9nA+PkCUS3w@mail.gmail.com>
Subject: [PATCH] crypto: Introduce SM3 hash hmac pbkdf algorithm
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b1dec4062598d7c1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=liequanche@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000b1dec4062598d7c1
Content-Type: text/plain; charset="UTF-8"

Introduce the SM3 cryptographic hash algorithm (GB/T 32905-2016).

SM3 (GB/T 32905-2016) is a cryptographic standard issued by the
Organization of State Commercial Cryptography Administration (OSCCA)
as an authorized cryptographic algorithm for use within China.

Detect the SM3 cryptographic hash algorithm and enable the feature silently
if it is available.

Signed-off-by: cheliequan <cheliequan@inspur.com>
---
 crypto/hash-gcrypt.c           |  3 +++
 crypto/hash-nettle.c           | 14 ++++++++++++
 crypto/hash.c                  |  3 +++
 crypto/hmac-gcrypt.c           |  3 +++
 crypto/hmac-nettle.c           | 11 ++++++++++
 crypto/pbkdf-gcrypt.c          |  6 ++++++
 crypto/pbkdf-nettle.c          | 13 ++++++++++++
 meson.build                    | 39 ++++++++++++++++++++++++++++++++++
 qapi/crypto.json               |  4 +++-
 tests/unit/test-crypto-hash.c  | 16 ++++++++++++++
 tests/unit/test-crypto-hmac.c  |  8 +++++++
 tests/unit/test-crypto-pbkdf.c | 16 ++++++++++++++
 12 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 829e48258d..d3bdfe5633 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -33,6 +33,9 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
     [QCRYPTO_HASH_ALG_SHA384] = GCRY_MD_SHA384,
     [QCRYPTO_HASH_ALG_SHA512] = GCRY_MD_SHA512,
     [QCRYPTO_HASH_ALG_RIPEMD160] = GCRY_MD_RMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = GCRY_MD_SM3,
+#endif
 };

 gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 1ca1a41062..0c2f8ce86c 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -25,6 +25,9 @@
 #include <nettle/md5.h>
 #include <nettle/sha.h>
 #include <nettle/ripemd160.h>
+#ifdef CONFIG_CRYPTO_SM3
+#include <nettle/sm3.h>
+#endif

 typedef void (*qcrypto_nettle_init)(void *ctx);
 typedef void (*qcrypto_nettle_write)(void *ctx,
@@ -42,6 +45,9 @@ union qcrypto_hash_ctx {
     struct sha384_ctx sha384;
     struct sha512_ctx sha512;
     struct ripemd160_ctx ripemd160;
+#ifdef CONFIG_CRYPTO_SM3
+    struct sm3_ctx sm3;
+#endif
 };

 struct qcrypto_hash_alg {
@@ -92,6 +98,14 @@ struct qcrypto_hash_alg {
         .result = (qcrypto_nettle_result)ripemd160_digest,
         .len = RIPEMD160_DIGEST_SIZE,
     },
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = {
+        .init = (qcrypto_nettle_init)sm3_init,
+        .write = (qcrypto_nettle_write)sm3_update,
+        .result = (qcrypto_nettle_result)sm3_digest,
+        .len = SM3_DIGEST_SIZE,
+    },
+#endif
 };

 gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
diff --git a/crypto/hash.c b/crypto/hash.c
index b0f8228bdc..8f1502ce68 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -30,6 +30,9 @@ static size_t
qcrypto_hash_alg_size[QCRYPTO_HASH_ALG__MAX] = {
     [QCRYPTO_HASH_ALG_SHA384] = 48,
     [QCRYPTO_HASH_ALG_SHA512] = 64,
     [QCRYPTO_HASH_ALG_RIPEMD160] = 20,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = 32,
+#endif
 };

 size_t qcrypto_hash_digest_len(QCryptoHashAlgorithm alg)
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 0c6f979711..888afb86ed 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -26,6 +26,9 @@ static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
     [QCRYPTO_HASH_ALG_SHA384] = GCRY_MAC_HMAC_SHA384,
     [QCRYPTO_HASH_ALG_SHA512] = GCRY_MAC_HMAC_SHA512,
     [QCRYPTO_HASH_ALG_RIPEMD160] = GCRY_MAC_HMAC_RMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = GCRY_MAC_HMAC_SM3,
+#endif
 };

 typedef struct QCryptoHmacGcrypt QCryptoHmacGcrypt;
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 1ad6c4f253..e51e3319ab 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -38,6 +38,9 @@ struct QCryptoHmacNettle {
         struct hmac_sha256_ctx sha256_ctx; /* equals hmac_sha224_ctx */
         struct hmac_sha512_ctx sha512_ctx; /* equals hmac_sha384_ctx */
         struct hmac_ripemd160_ctx ripemd160_ctx;
+#ifdef CONFIG_CRYPTO_SM3
+ struct hmac_sm3_ctx ctx;
+#endif
     } u;
 };

@@ -89,6 +92,14 @@ struct qcrypto_nettle_hmac_alg {
         .digest = (qcrypto_nettle_hmac_digest)hmac_ripemd160_digest,
         .len = RIPEMD160_DIGEST_SIZE,
     },
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sm3_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sm3_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sm3_digest,
+        .len = SM3_DIGEST_SIZE,
+    },
+#endif
 };

 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index a8d8e64f4d..09b38d0d6e 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -33,6 +33,9 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
     case QCRYPTO_HASH_ALG_SHA384:
     case QCRYPTO_HASH_ALG_SHA512:
     case QCRYPTO_HASH_ALG_RIPEMD160:
+#ifdef CONFIG_CRYPTO_SM3
+    case QCRYPTO_HASH_ALG_SM3:
+#endif
         return true;
     default:
         return false;
@@ -54,6 +57,9 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
         [QCRYPTO_HASH_ALG_SHA384] = GCRY_MD_SHA384,
         [QCRYPTO_HASH_ALG_SHA512] = GCRY_MD_SHA512,
         [QCRYPTO_HASH_ALG_RIPEMD160] = GCRY_MD_RMD160,
+#ifdef CONFIG_CRYPTO_SM3
+        [QCRYPTO_HASH_ALG_SM3] = GCRY_MD_SM3,
+#endif
     };
     int ret;

diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
index d6293c25a1..5fea570bd3 100644
--- a/crypto/pbkdf-nettle.c
+++ b/crypto/pbkdf-nettle.c
@@ -34,6 +34,9 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
     case QCRYPTO_HASH_ALG_SHA384:
     case QCRYPTO_HASH_ALG_SHA512:
     case QCRYPTO_HASH_ALG_RIPEMD160:
+#ifdef CONFIG_CRYPTO_SM3
+    case QCRYPTO_HASH_ALG_SM3:
+#endif
         return true;
     default:
         return false;
@@ -55,6 +58,9 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
         struct hmac_sha384_ctx sha384;
         struct hmac_sha512_ctx sha512;
         struct hmac_ripemd160_ctx ripemd160;
+#ifdef CONFIG_CRYPTO_SM3
+        struct hmac_sm3_ctx sm3;
+#endif
     } ctx;

     if (iterations > UINT_MAX) {
@@ -106,6 +112,13 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
         PBKDF2(&ctx.ripemd160, hmac_ripemd160_update,
hmac_ripemd160_digest,
                RIPEMD160_DIGEST_SIZE, iterations, nsalt, salt, nout, out);
         break;
+#ifdef CONFIG_CRYPTO_SM3
+    case QCRYPTO_HASH_ALG_SM3:
+        hmac_sm3_set_key(&ctx.sm3, nkey, key);
+        PBKDF2(&ctx.sm3, hmac_sm3_update, hmac_sm3_digest,
+               SM3_DIGEST_SIZE, iterations, nsalt, salt, nout, out);
+        break;
+#endif

     default:
         error_setg_errno(errp, ENOSYS,
diff --git a/meson.build b/meson.build
index 089f45d386..4024f9a4bb 100644
--- a/meson.build
+++ b/meson.build
@@ -1486,6 +1486,7 @@ gcrypt = not_found
 nettle = not_found
 hogweed = not_found
 crypto_sm4 = not_found
+crypto_sm3 = not_found
 xts = 'none'

 if get_option('nettle').enabled() and get_option('gcrypt').enabled()
@@ -1522,6 +1523,17 @@ if not gnutls_crypto.found()
       }''', dependencies: gcrypt)
       crypto_sm4 = not_found
     endif
+    crypto_sm3 = gcrypt
+    # SM3 ALG is available in libgcrypt >= 1.8
+    if gcrypt.found() and not cc.links('''
+      #include <gcrypt.h>
+      int main(void) {
+        gcry_md_hd_t handler;
+        gcry_md_open(&handler, GCRY_MD_SM3, 0);
+        return 0;
+      }''', dependencies: gcrypt)
+      crypto_sm3 = not_found
+    endif
   endif
   if (not get_option('nettle').auto() or have_system) and not
gcrypt.found()
     nettle = dependency('nettle', version: '>=3.4',
@@ -1542,6 +1554,31 @@ if not gnutls_crypto.found()
       }''', dependencies: nettle)
       crypto_sm4 = not_found
     endif
+    crypto_sm3 = nettle
+    # SM3 ALG is available in nettle >= 3.4
+    if nettle.found() and not cc.links('''
+      #include <nettle/sm3.h>
+      #include <nettle/hmac.h>
+      int main(void) {
+      struct sm3_ctx ctx;
+      struct hmac_sm3_ctx hmac_ctx;
+      unsigned char data[64] = {0};
+      unsigned char output[32];
+
+      // SM3 hash function test
+      sm3_init(&ctx);
+      sm3_update(&ctx, 64, data);
+      sm3_digest(&ctx, 32, data);
+
+      // HMAC-SM3 test
+      hmac_sm3_set_key(&hmac_ctx, 32, data);
+      hmac_sm3_update(&hmac_ctx, 64, data);
+      hmac_sm3_digest(&hmac_ctx, 32, output);
+
+      return 0;
+      }''', dependencies: nettle)
+      crypto_sm3 = not_found
+    endif
   endif
 endif

@@ -2229,6 +2266,7 @@ config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
 config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
+config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm3.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
@@ -4306,6 +4344,7 @@ if nettle.found()
    summary_info += {'  XTS':             xts != 'private'}
 endif
 summary_info += {'SM4 ALG support':   crypto_sm4}
+summary_info += {'SM3 ALG support':   crypto_sm3}
 summary_info += {'AF_ALG support':    have_afalg}
 summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 2f2aeff5fd..af38f0a4bd 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -58,11 +58,13 @@
 #
 # @ripemd160: RIPEMD-160. (since 2.7)
 #
+# @sm3: SM3. (since 8.2.0)
+#
 # Since: 2.6
 ##
 { 'enum': 'QCryptoHashAlgorithm',
   'prefix': 'QCRYPTO_HASH_ALG',
-  'data': ['md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512',
'ripemd160']}
+  'data': ['md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512',
'ripemd160', 'sm3']}

 ##
 # @QCryptoCipherAlgorithm:
diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
index 1f4abb822b..61908e1769 100644
--- a/tests/unit/test-crypto-hash.c
+++ b/tests/unit/test-crypto-hash.c
@@ -42,6 +42,9 @@
                       "63b54e4cb2d2032b393994aa263c0dbb" \
                       "e00a9f2fe9ef6037352232a1eec55ee7"
 #define OUTPUT_RIPEMD160 "f3d658fad3fdfb2b52c9369cf0d441249ddfa8a0"
+#ifdef CONFIG_CRYPTO_SM3
+#define OUTPUT_SM3
"d4a97db105b477b84c4f20ec9c31a6c814e2705a0b83a5a89748d75f0ef456a1"
+#endif

 #define OUTPUT_MD5_B64 "Yo0gY3FWMDWrjvYvSSveyQ=="
 #define OUTPUT_SHA1_B64 "sudPJnWKOkIeUJzuBFJEt4dTzAI="
@@ -54,6 +57,10 @@
                           "7sVe5w=="
 #define OUTPUT_RIPEMD160_B64 "89ZY+tP9+ytSyTac8NRBJJ3fqKA="

+#ifdef CONFIG_CRYPTO_SM3
+#define OUTPUT_SM3_B64 "1Kl9sQW0d7hMTyDsnDGmyBTicFoLg6Wol0jXXw70VqE="
+#endif
+
 static const char *expected_outputs[] = {
     [QCRYPTO_HASH_ALG_MD5] = OUTPUT_MD5,
     [QCRYPTO_HASH_ALG_SHA1] = OUTPUT_SHA1,
@@ -62,6 +69,9 @@ static const char *expected_outputs[] = {
     [QCRYPTO_HASH_ALG_SHA384] = OUTPUT_SHA384,
     [QCRYPTO_HASH_ALG_SHA512] = OUTPUT_SHA512,
     [QCRYPTO_HASH_ALG_RIPEMD160] = OUTPUT_RIPEMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = OUTPUT_SM3,
+#endif
 };
 static const char *expected_outputs_b64[] = {
     [QCRYPTO_HASH_ALG_MD5] = OUTPUT_MD5_B64,
@@ -71,6 +81,9 @@ static const char *expected_outputs_b64[] = {
     [QCRYPTO_HASH_ALG_SHA384] = OUTPUT_SHA384_B64,
     [QCRYPTO_HASH_ALG_SHA512] = OUTPUT_SHA512_B64,
     [QCRYPTO_HASH_ALG_RIPEMD160] = OUTPUT_RIPEMD160_B64,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = OUTPUT_SM3_B64,
+#endif
 };
 static const int expected_lens[] = {
     [QCRYPTO_HASH_ALG_MD5] = 16,
@@ -80,6 +93,9 @@ static const int expected_lens[] = {
     [QCRYPTO_HASH_ALG_SHA384] = 48,
     [QCRYPTO_HASH_ALG_SHA512] = 64,
     [QCRYPTO_HASH_ALG_RIPEMD160] = 20,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALG_SM3] = 32,
+#endif
 };

 static const char hex[] = "0123456789abcdef";
diff --git a/tests/unit/test-crypto-hmac.c b/tests/unit/test-crypto-hmac.c
index 23eb724d94..b1d04e9fcc 100644
--- a/tests/unit/test-crypto-hmac.c
+++ b/tests/unit/test-crypto-hmac.c
@@ -76,6 +76,14 @@ static QCryptoHmacTestData test_data[] = {
             "94964ed4c1155b62b668c241d67279e5"
             "8a711676",
     },
+#ifdef CONFIG_CRYPTO_SM3
+    {
+        .alg = QCRYPTO_HASH_ALG_SM3,
+        .hex_digest =
+            "760e3799332bc913819b930085360ddb"
+    "c05529261313d5b15b75bab4fd7ae91e",
+    },
+#endif
 };

 static const char hex[] = "0123456789abcdef";
diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c
index 43c417f6b4..3d76593c86 100644
--- a/tests/unit/test-crypto-pbkdf.c
+++ b/tests/unit/test-crypto-pbkdf.c
@@ -326,6 +326,22 @@ static QCryptoPbkdfTestData test_data[] = {
                "\xce\xbf\x91\x14\x8b\x5c\x48\x41",
         .nout = 32
     },
+#ifdef CONFIG_CRYPTO_SM3
+    {
+        .path = "/crypto/pbkdf/nonrfc/sm3/iter2",
+        .hash = QCRYPTO_HASH_ALG_SM3,
+        .iterations = 2,
+        .key = "password",
+        .nkey = 8,
+        .salt = "ATHENA.MIT.EDUraeburn",
+        .nsalt = 21,
+        .out = "\x48\x71\x1b\x58\xa3\xcb\xce\x06"
+ "\xba\xad\x77\xa8\xb5\xb9\xd8\x07"
+ "\x6a\xe2\xb3\x5b\x95\xce\xc8\xce"
+ "\xe7\xb1\xcb\xee\x61\xdf\x04\xea",
+        .nout = 32
+    },
+#endif
 #if 0
     {
         .path = "/crypto/pbkdf/nonrfc/whirlpool/iter1200",
-- 
2.44.0.windows.1

--000000000000b1dec4062598d7c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Introduce the SM3 cryptographic hash algorithm (GB/T 32905=
-2016).<br><br>SM3 (GB/T 32905-2016) is a cryptographic standard issued by =
the<br>Organization of State Commercial Cryptography Administration (OSCCA)=
<br>as an authorized cryptographic algorithm for use within China.<br><br>D=
etect the SM3 cryptographic hash algorithm and enable the feature silently<=
br>if it is available.<br><br>Signed-off-by: cheliequan &lt;<a href=3D"mail=
to:cheliequan@inspur.com">cheliequan@inspur.com</a>&gt;<br>---<br>=C2=A0cry=
pto/hash-gcrypt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A03 +++<br>=C2=
=A0crypto/hash-nettle.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 +++++++++++=
+<br>=C2=A0crypto/hash.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A03 +++<br>=C2=A0crypto/hmac-gcrypt.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A03 +++<br>=C2=A0crypto/hmac-nettle.c =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 11 ++++++++++<br>=C2=A0crypto/pbkdf-gcrypt.c =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A06 ++++++<br>=C2=A0crypto/pbkdf-nettle.c=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 ++++++++++++<br>=C2=A0meson.build =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 +=
+++++++++++++++++++++++++++++++++<br>=C2=A0qapi/crypto.json =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A04 +++-<br>=C2=A0tests/unit/test-=
crypto-hash.c =C2=A0| 16 ++++++++++++++<br>=C2=A0tests/unit/test-crypto-hma=
c.c =C2=A0| =C2=A08 +++++++<br>=C2=A0tests/unit/test-crypto-pbkdf.c | 16 ++=
++++++++++++<br>=C2=A012 files changed, 135 insertions(+), 1 deletion(-)<br=
><br>diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c<br>index 829e=
48258d..d3bdfe5633 100644<br>--- a/crypto/hash-gcrypt.c<br>+++ b/crypto/has=
h-gcrypt.c<br>@@ -33,6 +33,9 @@ static int qcrypto_hash_alg_map[QCRYPTO_HAS=
H_ALG__MAX] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA384] =3D GCRY=
_MD_SHA384,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA512] =3D GCRY_MD_SH=
A512,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_RIPEMD160] =3D GCRY_MD_RMD16=
0,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SM3] =
=3D GCRY_MD_SM3,<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0gboolean qcrypto=
_hash_supports(QCryptoHashAlgorithm alg)<br>diff --git a/crypto/hash-nettle=
.c b/crypto/hash-nettle.c<br>index 1ca1a41062..0c2f8ce86c 100644<br>--- a/c=
rypto/hash-nettle.c<br>+++ b/crypto/hash-nettle.c<br>@@ -25,6 +25,9 @@<br>=
=C2=A0#include &lt;nettle/md5.h&gt;<br>=C2=A0#include &lt;nettle/sha.h&gt;<=
br>=C2=A0#include &lt;nettle/ripemd160.h&gt;<br>+#ifdef CONFIG_CRYPTO_SM3<b=
r>+#include &lt;nettle/sm3.h&gt;<br>+#endif<br>=C2=A0<br>=C2=A0typedef void=
 (*qcrypto_nettle_init)(void *ctx);<br>=C2=A0typedef void (*qcrypto_nettle_=
write)(void *ctx,<br>@@ -42,6 +45,9 @@ union qcrypto_hash_ctx {<br>=C2=A0 =
=C2=A0 =C2=A0struct sha384_ctx sha384;<br>=C2=A0 =C2=A0 =C2=A0struct sha512=
_ctx sha512;<br>=C2=A0 =C2=A0 =C2=A0struct ripemd160_ctx ripemd160;<br>+#if=
def CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0struct sm3_ctx sm3;<br>+#endif<br>=
=C2=A0};<br>=C2=A0<br>=C2=A0struct qcrypto_hash_alg {<br>@@ -92,6 +98,14 @@=
 struct qcrypto_hash_alg {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.result =3D=
 (qcrypto_nettle_result)ripemd160_digest,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.len =3D RIPEMD160_DIGEST_SIZE,<br>=C2=A0 =C2=A0 =C2=A0},<br>+#ifdef =
CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SM3] =3D {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.init =3D (qcrypto_nettle_init)sm3_init,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.write =3D (qcrypto_nettle_write)sm3_update,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0.result =3D (qcrypto_nettle_result)sm3_digest,<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.len =3D SM3_DIGEST_SIZE,<br>+ =C2=A0 =C2=A0=
},<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0gboolean qcrypto_hash_supports=
(QCryptoHashAlgorithm alg)<br>diff --git a/crypto/hash.c b/crypto/hash.c<br=
>index b0f8228bdc..8f1502ce68 100644<br>--- a/crypto/hash.c<br>+++ b/crypto=
/hash.c<br>@@ -30,6 +30,9 @@ static size_t qcrypto_hash_alg_size[QCRYPTO_HA=
SH_ALG__MAX] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA384] =3D 48,=
<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA512] =3D 64,<br>=C2=A0 =C2=A0 =
=C2=A0[QCRYPTO_HASH_ALG_RIPEMD160] =3D 20,<br>+#ifdef CONFIG_CRYPTO_SM3<br>=
+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SM3] =3D 32,<br>+#endif<br>=C2=A0};<br>=C2=
=A0<br>=C2=A0size_t qcrypto_hash_digest_len(QCryptoHashAlgorithm alg)<br>di=
ff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c<br>index 0c6f979711.=
.888afb86ed 100644<br>--- a/crypto/hmac-gcrypt.c<br>+++ b/crypto/hmac-gcryp=
t.c<br>@@ -26,6 +26,9 @@ static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__=
MAX] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA384] =3D GCRY_MAC_HM=
AC_SHA384,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA512] =3D GCRY_MAC_HM=
AC_SHA512,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_RIPEMD160] =3D GCRY_MAC=
_HMAC_RMD160,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_=
ALG_SM3] =3D GCRY_MAC_HMAC_SM3,<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0t=
ypedef struct QCryptoHmacGcrypt QCryptoHmacGcrypt;<br>diff --git a/crypto/h=
mac-nettle.c b/crypto/hmac-nettle.c<br>index 1ad6c4f253..e51e3319ab 100644<=
br>--- a/crypto/hmac-nettle.c<br>+++ b/crypto/hmac-nettle.c<br>@@ -38,6 +38=
,9 @@ struct QCryptoHmacNettle {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t hmac_sha256_ctx sha256_ctx; /* equals hmac_sha224_ctx */<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct hmac_sha512_ctx sha512_ctx; /* equals hmac_sha3=
84_ctx */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_ripemd160_ctx ri=
pemd160_ctx;<br>+#ifdef CONFIG_CRYPTO_SM3<br>+	struct hmac_sm3_ctx ctx;<br>=
+#endif<br>=C2=A0 =C2=A0 =C2=A0} u;<br>=C2=A0};<br>=C2=A0<br>@@ -89,6 +92,1=
4 @@ struct qcrypto_nettle_hmac_alg {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.digest =3D (qcrypto_nettle_hmac_digest)hmac_ripemd160_digest,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0.len =3D RIPEMD160_DIGEST_SIZE,<br>=C2=A0 =C2=A0=
 =C2=A0},<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_=
SM3] =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.setkey =3D (qcrypto_nettle_hmac=
_setkey)hmac_sm3_set_key,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.update =3D (qcry=
pto_nettle_hmac_update)hmac_sm3_update,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.di=
gest =3D (qcrypto_nettle_hmac_digest)hmac_sm3_digest,<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.len =3D SM3_DIGEST_SIZE,<br>+ =C2=A0 =C2=A0},<br>+#endif<br>=
=C2=A0};<br>=C2=A0<br>=C2=A0bool qcrypto_hmac_supports(QCryptoHashAlgorithm=
 alg)<br>diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c<br>inde=
x a8d8e64f4d..09b38d0d6e 100644<br>--- a/crypto/pbkdf-gcrypt.c<br>+++ b/cry=
pto/pbkdf-gcrypt.c<br>@@ -33,6 +33,9 @@ bool qcrypto_pbkdf2_supports(QCrypt=
oHashAlgorithm hash)<br>=C2=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_ALG_SHA384:<b=
r>=C2=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_ALG_SHA512:<br>=C2=A0 =C2=A0 =C2=A0=
case QCRYPTO_HASH_ALG_RIPEMD160:<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =
=C2=A0case QCRYPTO_HASH_ALG_SM3:<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return true;<br>=C2=A0 =C2=A0 =C2=A0default:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return false;<br>@@ -54,6 +57,9 @@ int qcrypto_pbkdf2(QCryptoH=
ashAlgorithm hash,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_S=
HA384] =3D GCRY_MD_SHA384,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_HA=
SH_ALG_SHA512] =3D GCRY_MD_SHA512,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[QC=
RYPTO_HASH_ALG_RIPEMD160] =3D GCRY_MD_RMD160,<br>+#ifdef CONFIG_CRYPTO_SM3<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SM3] =3D GCRY_MD_SM3,<br>=
+#endif<br>=C2=A0 =C2=A0 =C2=A0};<br>=C2=A0 =C2=A0 =C2=A0int ret;<br>=C2=A0=
<br>diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c<br>index d62=
93c25a1..5fea570bd3 100644<br>--- a/crypto/pbkdf-nettle.c<br>+++ b/crypto/p=
bkdf-nettle.c<br>@@ -34,6 +34,9 @@ bool qcrypto_pbkdf2_supports(QCryptoHash=
Algorithm hash)<br>=C2=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_ALG_SHA384:<br>=C2=
=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_ALG_SHA512:<br>=C2=A0 =C2=A0 =C2=A0case =
QCRYPTO_HASH_ALG_RIPEMD160:<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0=
case QCRYPTO_HASH_ALG_SM3:<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return true;<br>=C2=A0 =C2=A0 =C2=A0default:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>@@ -55,6 +58,9 @@ int qcrypto_pbkdf2(QCryptoHashAlg=
orithm hash,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_sha384_ctx sh=
a384;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_sha512_ctx sha512;<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_ripemd160_ctx ripemd160;<br=
>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_sm3_=
ctx sm3;<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0} ctx;<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0if (iterations &gt; UINT_MAX) {<br>@@ -106,6 +112,13 @@ int qcryp=
to_pbkdf2(QCryptoHashAlgorithm hash,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0P=
BKDF2(&amp;ctx.ripemd160, hmac_ripemd160_update, hmac_ripemd160_digest,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RIPEMD160_DIGEST_SI=
ZE, iterations, nsalt, salt, nout, out);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0case QCRYPTO_HASH_=
ALG_SM3:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0hmac_sm3_set_key(&amp;ctx.sm3, nke=
y, key);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0PBKDF2(&amp;ctx.sm3, hmac_sm3_upda=
te, hmac_sm3_digest,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
SM3_DIGEST_SIZE, iterations, nsalt, salt, nout, out);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>+#endif<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0default:<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, ENOSYS,<br>diff -=
-git a/meson.build b/meson.build<br>index 089f45d386..4024f9a4bb 100644<br>=
--- a/meson.build<br>+++ b/meson.build<br>@@ -1486,6 +1486,7 @@ gcrypt =3D =
not_found<br>=C2=A0nettle =3D not_found<br>=C2=A0hogweed =3D not_found<br>=
=C2=A0crypto_sm4 =3D not_found<br>+crypto_sm3 =3D not_found<br>=C2=A0xts =
=3D &#39;none&#39;<br>=C2=A0<br>=C2=A0if get_option(&#39;nettle&#39;).enabl=
ed() and get_option(&#39;gcrypt&#39;).enabled()<br>@@ -1522,6 +1523,17 @@ i=
f not gnutls_crypto.found()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;,=
 dependencies: gcrypt)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0crypto_sm4 =3D not_fou=
nd<br>=C2=A0 =C2=A0 =C2=A0endif<br>+ =C2=A0 =C2=A0crypto_sm3 =3D gcrypt<br>=
+ =C2=A0 =C2=A0# SM3 ALG is available in libgcrypt &gt;=3D 1.8<br>+ =C2=A0 =
=C2=A0if gcrypt.found() and not cc.links(&#39;&#39;&#39;<br>+ =C2=A0 =C2=A0=
 =C2=A0#include &lt;gcrypt.h&gt;<br>+ =C2=A0 =C2=A0 =C2=A0int main(void) {<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0gcry_md_hd_t handler;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0gcry_md_open(&amp;handler, GCRY_MD_SM3, 0);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 0;<br>+ =C2=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;, dependen=
cies: gcrypt)<br>+ =C2=A0 =C2=A0 =C2=A0crypto_sm3 =3D not_found<br>+ =C2=A0=
 =C2=A0endif<br>=C2=A0 =C2=A0endif<br>=C2=A0 =C2=A0if (not get_option(&#39;=
nettle&#39;).auto() or have_system) and not gcrypt.found()<br>=C2=A0 =C2=A0=
 =C2=A0nettle =3D dependency(&#39;nettle&#39;, version: &#39;&gt;=3D3.4&#39=
;,<br>@@ -1542,6 +1554,31 @@ if not gnutls_crypto.found()<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0}&#39;&#39;&#39;, dependencies: nettle)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0crypto_sm4 =3D not_found<br>=C2=A0 =C2=A0 =C2=A0endif<br>+ =C2=A0=
 =C2=A0crypto_sm3 =3D nettle<br>+ =C2=A0 =C2=A0# SM3 ALG is available in ne=
ttle &gt;=3D 3.4<br>+ =C2=A0 =C2=A0if nettle.found() and not cc.links(&#39;=
&#39;&#39;<br>+ =C2=A0 =C2=A0 =C2=A0#include &lt;nettle/sm3.h&gt;<br>+ =C2=
=A0 =C2=A0 =C2=A0#include &lt;nettle/hmac.h&gt;<br>+ =C2=A0 =C2=A0 =C2=A0in=
t main(void) {<br>+ =C2=A0 =C2=A0 =C2=A0struct sm3_ctx ctx;<br>+ =C2=A0 =C2=
=A0 =C2=A0struct hmac_sm3_ctx hmac_ctx;<br>+ =C2=A0 =C2=A0 =C2=A0unsigned c=
har data[64] =3D {0};<br>+ =C2=A0 =C2=A0 =C2=A0unsigned char output[32];<br=
>+ =C2=A0 =C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0// SM3 hash function test<br>+ =
=C2=A0 =C2=A0 =C2=A0sm3_init(&amp;ctx);<br>+ =C2=A0 =C2=A0 =C2=A0sm3_update=
(&amp;ctx, 64, data);<br>+ =C2=A0 =C2=A0 =C2=A0sm3_digest(&amp;ctx, 32, dat=
a);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0// HMAC-SM3 test<br>+ =C2=A0 =C2=A0 =C2=
=A0hmac_sm3_set_key(&amp;hmac_ctx, 32, data);<br>+ =C2=A0 =C2=A0 =C2=A0hmac=
_sm3_update(&amp;hmac_ctx, 64, data);<br>+ =C2=A0 =C2=A0 =C2=A0hmac_sm3_dig=
est(&amp;hmac_ctx, 32, output);<br>+ =C2=A0 =C2=A0<br>+ =C2=A0 =C2=A0 =C2=
=A0return 0;<br>+ =C2=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;, dependencies: nettl=
e)<br>+ =C2=A0 =C2=A0 =C2=A0crypto_sm3 =3D not_found<br>+ =C2=A0 =C2=A0endi=
f<br>=C2=A0 =C2=A0endif<br>=C2=A0endif<br>=C2=A0<br>@@ -2229,6 +2266,7 @@ c=
onfig_host_data.set(&#39;CONFIG_TASN1&#39;, tasn1.found())<br>=C2=A0config_=
host_data.set(&#39;CONFIG_GCRYPT&#39;, gcrypt.found())<br>=C2=A0config_host=
_data.set(&#39;CONFIG_NETTLE&#39;, nettle.found())<br>=C2=A0config_host_dat=
a.set(&#39;CONFIG_CRYPTO_SM4&#39;, crypto_sm4.found())<br>+config_host_data=
.set(&#39;CONFIG_CRYPTO_SM3&#39;, crypto_sm3.found())<br>=C2=A0config_host_=
data.set(&#39;CONFIG_HOGWEED&#39;, hogweed.found())<br>=C2=A0config_host_da=
ta.set(&#39;CONFIG_QEMU_PRIVATE_XTS&#39;, xts =3D=3D &#39;private&#39;)<br>=
=C2=A0config_host_data.set(&#39;CONFIG_MALLOC_TRIM&#39;, has_malloc_trim)<b=
r>@@ -4306,6 +4344,7 @@ if nettle.found()<br>=C2=A0 =C2=A0 summary_info +=
=3D {&#39; =C2=A0XTS&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xts !=
=3D &#39;private&#39;}<br>=C2=A0endif<br>=C2=A0summary_info +=3D {&#39;SM4 =
ALG support&#39;: =C2=A0 crypto_sm4}<br>+summary_info +=3D {&#39;SM3 ALG su=
pport&#39;: =C2=A0 crypto_sm3}<br>=C2=A0summary_info +=3D {&#39;AF_ALG supp=
ort&#39;: =C2=A0 =C2=A0have_afalg}<br>=C2=A0summary_info +=3D {&#39;rng-non=
e&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_option(&#39;rng_none&#39;)}<b=
r>=C2=A0summary_info +=3D {&#39;Linux keyring&#39;: =C2=A0 =C2=A0 have_keyr=
ing}<br>diff --git a/qapi/crypto.json b/qapi/crypto.json<br>index 2f2aeff5f=
d..af38f0a4bd 100644<br>--- a/qapi/crypto.json<br>+++ b/qapi/crypto.json<br=
>@@ -58,11 +58,13 @@<br>=C2=A0#<br>=C2=A0# @ripemd160: RIPEMD-160. (since 2=
.7)<br>=C2=A0#<br>+# @sm3: SM3. (since 8.2.0)<br>+#<br>=C2=A0# Since: 2.6<b=
r>=C2=A0##<br>=C2=A0{ &#39;enum&#39;: &#39;QCryptoHashAlgorithm&#39;,<br>=
=C2=A0 =C2=A0&#39;prefix&#39;: &#39;QCRYPTO_HASH_ALG&#39;,<br>- =C2=A0&#39;=
data&#39;: [&#39;md5&#39;, &#39;sha1&#39;, &#39;sha224&#39;, &#39;sha256&#3=
9;, &#39;sha384&#39;, &#39;sha512&#39;, &#39;ripemd160&#39;]}<br>+ =C2=A0&#=
39;data&#39;: [&#39;md5&#39;, &#39;sha1&#39;, &#39;sha224&#39;, &#39;sha256=
&#39;, &#39;sha384&#39;, &#39;sha512&#39;, &#39;ripemd160&#39;, &#39;sm3&#3=
9;]}<br>=C2=A0<br>=C2=A0##<br>=C2=A0# @QCryptoCipherAlgorithm:<br>diff --gi=
t a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c<br>index =
1f4abb822b..61908e1769 100644<br>--- a/tests/unit/test-crypto-hash.c<br>+++=
 b/tests/unit/test-crypto-hash.c<br>@@ -42,6 +42,9 @@<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;63b=
54e4cb2d2032b393994aa263c0dbb&quot; \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;e00a9f2fe9ef60373522=
32a1eec55ee7&quot;<br>=C2=A0#define OUTPUT_RIPEMD160 &quot;f3d658fad3fdfb2b=
52c9369cf0d441249ddfa8a0&quot;<br>+#ifdef CONFIG_CRYPTO_SM3<br>+#define OUT=
PUT_SM3 &quot;d4a97db105b477b84c4f20ec9c31a6c814e2705a0b83a5a89748d75f0ef45=
6a1&quot;<br>+#endif<br>=C2=A0<br>=C2=A0#define OUTPUT_MD5_B64 &quot;Yo0gY3=
FWMDWrjvYvSSveyQ=3D=3D&quot;<br>=C2=A0#define OUTPUT_SHA1_B64 &quot;sudPJnW=
KOkIeUJzuBFJEt4dTzAI=3D&quot;<br>@@ -54,6 +57,10 @@<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;7sVe5w=3D=3D&quot;<br>=C2=A0#define OUTPUT_RIPEMD160_B64 &quot;89Z=
Y+tP9+ytSyTac8NRBJJ3fqKA=3D&quot;<br>=C2=A0<br>+#ifdef CONFIG_CRYPTO_SM3<br=
>+#define OUTPUT_SM3_B64 &quot;1Kl9sQW0d7hMTyDsnDGmyBTicFoLg6Wol0jXXw70VqE=
=3D&quot;<br>+#endif<br>+<br>=C2=A0static const char *expected_outputs[] =
=3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_MD5] =3D OUTPUT_MD5,<br>=C2=
=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA1] =3D OUTPUT_SHA1,<br>@@ -62,6 +69,9=
 @@ static const char *expected_outputs[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCR=
YPTO_HASH_ALG_SHA384] =3D OUTPUT_SHA384,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HA=
SH_ALG_SHA512] =3D OUTPUT_SHA512,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_=
RIPEMD160] =3D OUTPUT_RIPEMD160,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =
=C2=A0[QCRYPTO_HASH_ALG_SM3] =3D OUTPUT_SM3,<br>+#endif<br>=C2=A0};<br>=C2=
=A0static const char *expected_outputs_b64[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[=
QCRYPTO_HASH_ALG_MD5] =3D OUTPUT_MD5_B64,<br>@@ -71,6 +81,9 @@ static const=
 char *expected_outputs_b64[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_AL=
G_SHA384] =3D OUTPUT_SHA384_B64,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_S=
HA512] =3D OUTPUT_SHA512_B64,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_RIPE=
MD160] =3D OUTPUT_RIPEMD160_B64,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =
=C2=A0[QCRYPTO_HASH_ALG_SM3] =3D OUTPUT_SM3_B64,<br>+#endif<br>=C2=A0};<br>=
=C2=A0static const int expected_lens[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPT=
O_HASH_ALG_MD5] =3D 16,<br>@@ -80,6 +93,9 @@ static const int expected_lens=
[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA384] =3D 48,<br>=C2=A0=
 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG_SHA512] =3D 64,<br>=C2=A0 =C2=A0 =C2=A0[QCR=
YPTO_HASH_ALG_RIPEMD160] =3D 20,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =
=C2=A0[QCRYPTO_HASH_ALG_SM3] =3D 32,<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static const char hex[] =3D &quot;0123456789abcdef&quot;;<br>diff --g=
it a/tests/unit/test-crypto-hmac.c b/tests/unit/test-crypto-hmac.c<br>index=
 23eb724d94..b1d04e9fcc 100644<br>--- a/tests/unit/test-crypto-hmac.c<br>++=
+ b/tests/unit/test-crypto-hmac.c<br>@@ -76,6 +76,14 @@ static QCryptoHmacT=
estData test_data[] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;94964ed4c1155b62b668c241d67279e5&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;8a711676&quot;,<br>=C2=A0 =C2=A0 =C2=A0},<br>=
+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.alg =3D QCRYPTO_HASH_ALG_SM3,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.hex_dige=
st =3D<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;760e3799332bc913=
819b930085360ddb&quot;<br>+	 =C2=A0 =C2=A0&quot;c05529261313d5b15b75bab4fd7=
ae91e&quot;,<br>+ =C2=A0 =C2=A0},<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static const char hex[] =3D &quot;0123456789abcdef&quot;;<br>diff --git =
a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c<br>index =
43c417f6b4..3d76593c86 100644<br>--- a/tests/unit/test-crypto-pbkdf.c<br>++=
+ b/tests/unit/test-crypto-pbkdf.c<br>@@ -326,6 +326,22 @@ static QCryptoPb=
kdfTestData test_data[] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;\xce\xbf\x91\x14\x8b\x5c\x48\x41&quot;,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.nout =3D 32<br>=C2=A0 =C2=A0 =C2=A0},<br>+#ifdef C=
ONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.path =
=3D &quot;/crypto/pbkdf/nonrfc/sm3/iter2&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.hash =3D QCRYPTO_HASH_ALG_SM3,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.iter=
ations =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.key =3D &quot;password&quot;=
,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.nkey =3D 8,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.salt =3D &quot;ATHENA.MIT.EDUraeburn&quot;,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.nsalt =3D 21,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.out =3D &quot;\x4=
8\x71\x1b\x58\xa3\xcb\xce\x06&quot;<br>+		&quot;\xba\xad\x77\xa8\xb5\xb9\xd=
8\x07&quot;<br>+		&quot;\x6a\xe2\xb3\x5b\x95\xce\xc8\xce&quot;<br>+		&quot;=
\xe7\xb1\xcb\xee\x61\xdf\x04\xea&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.no=
ut =3D 32<br>+ =C2=A0 =C2=A0},<br>+#endif<br>=C2=A0#if 0<br>=C2=A0 =C2=A0 =
=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.path =3D &quot;/crypto/pbkdf/=
nonrfc/whirlpool/iter1200&quot;,<br>-- <br>2.44.0.windows.1<br><br></div>

--000000000000b1dec4062598d7c1--

