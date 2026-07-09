Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whwHy-0000u0-ES; Thu, 09 Jul 2026 17:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1whwHx-0000nD-CE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:28:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1whwHv-0002u9-Ek
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:28:09 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so489446a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783632486; x=1784237286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cdhDkgTHfKqxBOiswfDOl+RwIrVKFia7sjo3NwIrfTU=;
 b=jVHlAMqvc1rC2jp1hIfyJJzkbCOeJdZ3IOESOp5jmnc9PiKVek3m7alW6pUhvnklbF
 z/RXWkLq54iVqcMMrnNpszOvV8TjYDgBPwN1GGHHfNX6gH7fzlokQ5lM4jCDc0K0Qvm2
 v/w7qzFb7GZR01/SrprdAARkP63NuF2umtpZnegtSjezNa3s1lXGe0Kz9BOZj7Nk28DL
 O28Kvi80Xqs3EYAtPkwKU0koBCDEy1ERUf5fLMPqRAlZJqSRU26nPmucM8jYzx3doS+/
 f9xRRJ9YCTUZjj2T/5HggjlAre6J5kHMGUQPvEAemwIqd9HLdj8eDiyDJtzM4rELsQ59
 LnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783632486; x=1784237286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cdhDkgTHfKqxBOiswfDOl+RwIrVKFia7sjo3NwIrfTU=;
 b=h+hdupEVUbbPgcs/BXBVHWCxZ21Ch7yjovKyc2fCXvLhdpjgwpXk5z8+cHMkz4dRS8
 hKYAWEvBI2eh7XBltPWWz+geRrX4u+IclbC2WeBCGcqzqmQ7yGDOs0WGiOVQcf0ME915
 2MV6ZTLfZe8ZDXY0hRoY3GJ94LO2KgshWyh5jiBlXkBZxZ6ezSsgx4BxHnKBvlub/o5c
 QUpZFMUATuhA5MGugpH6Qodb4omMu5CmezcJ3KWZbc5e35DK3mLPaUsjpXAaoNMoGbMc
 3hhhVUgKU5AiK6/Rf+QYerS/rCFSWKwVbt2YaqhhUF8Y0LBtIeThv7NElVpJz7dkoJ9s
 rfcQ==
X-Gm-Message-State: AOJu0Yx/0//86TwE2ZJoD5bV4mFVnrEcKprMlkpivlt0u+BqOVNtyyBZ
 yZ0xpqWn+7Qrmop3wj5E9I07vhOZAuueNBkzyQZIlV9+9tBMLHGfXml6TZY1Fw==
X-Gm-Gg: AfdE7ck1wlktPYjBBodhlj+t/5sBuW943C0J9b2J+2D7e/Xii2DOu5DB4eH9az6flKe
 +Dh9YkmFJOKJLO2MSD3obvmJTubv3j+iFxI257qjtAwdF8VsVGNVOsDtranS5g74Ny+3+E0kJQ1
 XNqSwC4Wm12OGAtKZTJnoaaAuZKRcTKfF76s9BNkmusgRzaCDUG90mFBMZdoenyamAKhXKJNpCv
 tEVy2aQiJaensiKndVVXd5j6wPBl0SMcyWBEzYqkhu/3AdxNuHECx+XqtfGpG1gkoO4UCZ9AIcf
 JNrxIrnGRFDcK76Ke/4N4CxadbcQ3H98uHt4UXrHlRRZnsE13TJo5fXDxJZukzh7LKLxDxlvDNA
 duCHfPFJ6s1R2Ovg7WzXUPb9jsXJNqMhlbP9wAKsYvgDbEHGRf5GRwvoZ7iN1N3tZtZDz7VOhjO
 At5B/0V/YptTehxObU
X-Received: by 2002:a05:6402:3552:b0:698:87ae:6ced with SMTP id
 4fb4d7f45d1cf-69ab44b1288mr4316134a12.28.1783632485671; 
 Thu, 09 Jul 2026 14:28:05 -0700 (PDT)
Received: from machine.. ([37.113.214.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19dbee72sm10097802a12.30.2026.07.09.14.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 14:28:04 -0700 (PDT)
From: Evgeny Kolmakov <randomjack94dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PATCH] crypto: Use g_autofree
Date: Fri, 10 Jul 2026 00:27:50 +0300
Message-ID: <20260709212750.290898-1-randomjack94dev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=randomjack94dev@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use g_autofree attribute to reduce the amount
of manual g_free() calls and 'goto out' code

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
---
 crypto/block.c          | 17 ++++++-----------
 crypto/hmac-gcrypt.c    | 12 ++++--------
 crypto/hmac-glib.c      | 10 +++-------
 crypto/ivgen-essiv.c    | 15 ++++-----------
 crypto/ivgen.c          |  6 ++----
 crypto/secret_keyring.c |  5 ++---
 6 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/crypto/block.c b/crypto/block.c
index 96c83e60b9..42558f3caf 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -55,7 +55,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  unsigned int flags,
                                  Error **errp)
 {
-    QCryptoBlock *block = g_new0(QCryptoBlock, 1);
+    g_autofree QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
     qemu_mutex_init(&block->mutex);
 
@@ -65,7 +65,6 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
                    QCryptoBlockFormat_str(options->format));
-        g_free(block);
         return NULL;
     }
 
@@ -74,11 +73,10 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
     if (block->driver->open(block, options, optprefix,
                             readfunc, opaque, flags, errp) < 0)
     {
-        g_free(block);
         return NULL;
     }
 
-    return block;
+    return g_steal_pointer(&block);
 }
 
 
@@ -90,7 +88,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
                                    unsigned int flags,
                                    Error **errp)
 {
-    QCryptoBlock *block = g_new0(QCryptoBlock, 1);
+    g_autofree QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
     qemu_mutex_init(&block->mutex);
 
@@ -100,7 +98,6 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
                    QCryptoBlockFormat_str(options->format));
-        g_free(block);
         return NULL;
     }
 
@@ -109,11 +106,10 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
 
     if (block->driver->create(block, options, optprefix, initfunc,
                               writefunc, opaque, errp) < 0) {
-        g_free(block);
         return NULL;
     }
 
-    return block;
+    return g_steal_pointer(&block);
 }
 
 
@@ -185,17 +181,16 @@ int qcrypto_block_amend_options(QCryptoBlock *block,
 QCryptoBlockInfo *qcrypto_block_get_info(QCryptoBlock *block,
                                          Error **errp)
 {
-    QCryptoBlockInfo *info = g_new0(QCryptoBlockInfo, 1);
+    g_autofree QCryptoBlockInfo *info = g_new0(QCryptoBlockInfo, 1);
 
     info->format = block->format;
 
     if (block->driver->get_info &&
         block->driver->get_info(block, info, errp) < 0) {
-        g_free(info);
         return NULL;
     }
 
-    return info;
+    return g_steal_pointer(&info);
 }
 
 
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index e428d17479..44631fb348 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -50,7 +50,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
                            const uint8_t *key, size_t nkey,
                            Error **errp)
 {
-    QCryptoHmacGcrypt *ctx;
+    g_autofree QCryptoHmacGcrypt *ctx = NULL;
     gcry_error_t err;
 
     if (!qcrypto_hmac_supports(alg)) {
@@ -66,7 +66,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
     if (err != 0) {
         error_setg(errp, "Cannot initialize hmac: %s",
                    gcry_strerror(err));
-        goto error;
+        return NULL;
     }
 
     err = gcry_mac_setkey(ctx->handle, (const void *)key, nkey);
@@ -74,14 +74,10 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
         error_setg(errp, "Cannot set key: %s",
                    gcry_strerror(err));
         gcry_mac_close(ctx->handle);
-        goto error;
+        return NULL;
     }
 
-    return ctx;
-
-error:
-    g_free(ctx);
-    return NULL;
+    return g_steal_pointer(&ctx);
 }
 
 static void
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index b845133a05..1f17769c1c 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -46,7 +46,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
                            const uint8_t *key, size_t nkey,
                            Error **errp)
 {
-    QCryptoHmacGlib *ctx;
+    g_autofree QCryptoHmacGlib *ctx = NULL;
 
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
@@ -60,14 +60,10 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
                             (const uint8_t *)key, nkey);
     if (!ctx->ghmac) {
         error_setg(errp, "Cannot initialize hmac and set key");
-        goto error;
+        return NULL;
     }
 
-    return ctx;
-
-error:
-    g_free(ctx);
-    return NULL;
+    return g_steal_pointer(&ctx);
 }
 
 static void
diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index 3d5a188795..d5fa269888 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -31,10 +31,10 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
                                     const uint8_t *key, size_t nkey,
                                     Error **errp)
 {
-    uint8_t *salt;
+    g_autofree uint8_t *salt = NULL;
     size_t nhash;
     size_t nsalt;
-    QCryptoIVGenESSIV *essiv = g_new0(QCryptoIVGenESSIV, 1);
+    g_autofree QCryptoIVGenESSIV *essiv = g_new0(QCryptoIVGenESSIV, 1);
 
     /* Not necessarily the same as nkey */
     nsalt = qcrypto_cipher_get_key_len(ivgen->cipher);
@@ -46,8 +46,6 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
     if (qcrypto_hash_bytes(ivgen->hash, (const gchar *)key, nkey,
                            &salt, &nhash,
                            errp) < 0) {
-        g_free(essiv);
-        g_free(salt);
         return -1;
     }
 
@@ -57,13 +55,10 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
                                        salt, MIN(nhash, nsalt),
                                        errp);
     if (!essiv->cipher) {
-        g_free(essiv);
-        g_free(salt);
         return -1;
     }
 
-    g_free(salt);
-    ivgen->private = essiv;
+    ivgen->private = g_steal_pointer(&essiv);
 
     return 0;
 }
@@ -75,7 +70,7 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
 {
     QCryptoIVGenESSIV *essiv = ivgen->private;
     size_t ndata = qcrypto_cipher_get_block_len(ivgen->cipher);
-    uint8_t *data = g_new(uint8_t, ndata);
+    g_autofree uint8_t *data = g_new(uint8_t, ndata);
 
     sector = cpu_to_le64(sector);
     memcpy(data, (uint8_t *)&sector, MIN(sizeof(sector), ndata));
@@ -88,7 +83,6 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
                                data,
                                ndata,
                                errp) < 0) {
-        g_free(data);
         return -1;
     }
 
@@ -99,7 +93,6 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
     if (ndata < niv) {
         memset(iv + ndata, 0, niv - ndata);
     }
-    g_free(data);
     return 0;
 }
 
diff --git a/crypto/ivgen.c b/crypto/ivgen.c
index 6b7d24d889..9f1f7d7dca 100644
--- a/crypto/ivgen.c
+++ b/crypto/ivgen.c
@@ -33,7 +33,7 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgo alg,
                                 const uint8_t *key, size_t nkey,
                                 Error **errp)
 {
-    QCryptoIVGen *ivgen = g_new0(QCryptoIVGen, 1);
+    g_autofree QCryptoIVGen *ivgen = g_new0(QCryptoIVGen, 1);
 
     ivgen->algorithm = alg;
     ivgen->cipher = cipheralg;
@@ -51,16 +51,14 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgo alg,
         break;
     default:
         error_setg(errp, "Unknown block IV generator algorithm %d", alg);
-        g_free(ivgen);
         return NULL;
     }
 
     if (ivgen->driver->init(ivgen, key, nkey, errp) < 0) {
-        g_free(ivgen);
         return NULL;
     }
 
-    return ivgen;
+    return g_steal_pointer(&ivgen);
 }
 
 
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 78d7f09b3b..3b332276ef 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -41,7 +41,7 @@ qcrypto_secret_keyring_load_data(QCryptoSecretCommon *sec_common,
                                  Error **errp)
 {
     QCryptoSecretKeyring *secret = QCRYPTO_SECRET_KEYRING(sec_common);
-    uint8_t *buffer = NULL;
+    g_autofree uint8_t *buffer = NULL;
     long retcode;
 
     *output = NULL;
@@ -61,12 +61,11 @@ qcrypto_secret_keyring_load_data(QCryptoSecretCommon *sec_common,
 
     retcode = keyctl_read(secret->serial, buffer, retcode);
     if (retcode < 0) {
-        g_free(buffer);
         goto keyctl_error;
     }
 
     *outputlen = retcode;
-    *output = buffer;
+    *output = g_steal_pointer(&buffer);
     return;
 
 keyctl_error:
-- 
2.43.0


