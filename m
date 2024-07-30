Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA3BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 11:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYlIR-0007K4-Pd; Tue, 30 Jul 2024 07:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhipeng@cestc.cn>)
 id 1sYlIK-0007Gn-1a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:45:32 -0400
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luzhipeng@cestc.cn>) id 1sYlIG-000627-F3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:45:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id 03816900114;
 Tue, 30 Jul 2024 19:39:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.58.10])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P1340312T281473089204592S1722339556090940_; 
 Tue, 30 Jul 2024 19:39:17 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: qemu-devel@nongnu.org
X-RCPT-COUNT: 4
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.58.10
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <9b57f88ce533b1520c943f9649ceaf02>
X-System-Flag: 0
From: luzhipeng <luzhipeng@cestc.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH] sm4:Adjust the naming of SM4 encryption method
Date: Tue, 30 Jul 2024 19:38:50 +0800
Message-Id: <20240730113850.30-1-luzhipeng@cestc.cn>
X-Mailer: git-send-email 2.34.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 1.203.97.240 (failed)
Received-SPF: pass client-ip=1.203.97.240; envelope-from=luzhipeng@cestc.cn;
 helo=smtp.cecloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With reference to the naming conventions of other encryption algorithms,
the name of SM4 is modified.So libvirt and qemu are compatible.

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
---
 crypto/block-luks.c             | 2 +-
 crypto/cipher-gcrypt.c.inc      | 4 ++--
 crypto/cipher-nettle.c.inc      | 4 ++--
 crypto/cipher.c                 | 4 ++--
 qapi/crypto.json                | 4 ++--
 tests/unit/test-crypto-cipher.c | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5b777c15d3..c156c6f1ff 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -98,7 +98,7 @@ qcrypto_block_luks_cipher_size_map_twofish[] = {
 #ifdef CONFIG_CRYPTO_SM4
 static const QCryptoBlockLUKSCipherSizeMap
 qcrypto_block_luks_cipher_size_map_sm4[] = {
-    { 16, QCRYPTO_CIPHER_ALG_SM4},
+    { 16, QCRYPTO_CIPHER_ALG_SM4_128},
     { 0, 0 },
 };
 #endif
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 4a8314746d..e9a555bff5 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -46,7 +46,7 @@ static int qcrypto_cipher_alg_to_gcry_alg(QCryptoCipherAlgorithm alg)
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
         return GCRY_CIPHER_TWOFISH;
 #ifdef CONFIG_CRYPTO_SM4
-    case QCRYPTO_CIPHER_ALG_SM4:
+    case QCRYPTO_CIPHER_ALG_SM4_128:
         return GCRY_CIPHER_SM4;
 #endif
     default:
@@ -86,7 +86,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
 #ifdef CONFIG_CRYPTO_SM4
-    case QCRYPTO_CIPHER_ALG_SM4:
+    case QCRYPTO_CIPHER_ALG_SM4_128:
 #endif
         break;
     default:
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 42b39e18a2..a62a5e8178 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -471,7 +471,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_TWOFISH_192:
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
 #ifdef CONFIG_CRYPTO_SM4
-    case QCRYPTO_CIPHER_ALG_SM4:
+    case QCRYPTO_CIPHER_ALG_SM4_128:
 #endif
         break;
     default:
@@ -732,7 +732,7 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             return &ctx->base;
         }
 #ifdef CONFIG_CRYPTO_SM4
-    case QCRYPTO_CIPHER_ALG_SM4:
+    case QCRYPTO_CIPHER_ALG_SM4_128:
         {
             QCryptoNettleSm4 *ctx = g_new0(QCryptoNettleSm4, 1);
 
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 5f512768ea..dc4b39d480 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -39,7 +39,7 @@ static const size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 24,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 32,
 #ifdef CONFIG_CRYPTO_SM4
-    [QCRYPTO_CIPHER_ALG_SM4] = 16,
+    [QCRYPTO_CIPHER_ALG_SM4_128] = 16,
 #endif
 };
 
@@ -57,7 +57,7 @@ static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 16,
 #ifdef CONFIG_CRYPTO_SM4
-    [QCRYPTO_CIPHER_ALG_SM4] = 16,
+    [QCRYPTO_CIPHER_ALG_SM4_128] = 16,
 #endif
 };
 
diff --git a/qapi/crypto.json b/qapi/crypto.json
index e102be337b..1a28e312d8 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -94,7 +94,7 @@
 #
 # @twofish-256: Twofish with 256 bit / 32 byte keys
 #
-# @sm4: SM4 with 128 bit / 16 byte keys (since 9.0)
+# @sm4-128: SM4 with 128 bit / 16 byte keys (since 9.0)
 #
 # Since: 2.6
 ##
@@ -105,7 +105,7 @@
            'cast5-128',
            'serpent-128', 'serpent-192', 'serpent-256',
            'twofish-128', 'twofish-192', 'twofish-256',
-           'sm4']}
+           'sm4-128']}
 
 ##
 # @QCryptoCipherMode:
diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
index f5152e569d..c60d48cb13 100644
--- a/tests/unit/test-crypto-cipher.c
+++ b/tests/unit/test-crypto-cipher.c
@@ -385,8 +385,8 @@ static QCryptoCipherTestData test_data[] = {
 #ifdef CONFIG_CRYPTO_SM4
     {
         /* SM4, GB/T 32907-2016, Appendix A.1 */
-        .path = "/crypto/cipher/sm4",
-        .alg = QCRYPTO_CIPHER_ALG_SM4,
+        .path = "/crypto/cipher/sm4-128",
+        .alg = QCRYPTO_CIPHER_ALG_SM4_128,
         .mode = QCRYPTO_CIPHER_MODE_ECB,
         .key = "0123456789abcdeffedcba9876543210",
         .plaintext  =
-- 
2.34.0.windows.1




