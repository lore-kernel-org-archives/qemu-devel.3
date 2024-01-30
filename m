Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CDAC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgqX-0002sZ-J9; Tue, 30 Jan 2024 00:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqU-0002re-6q
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:43 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqR-0001N0-Tl
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:41 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ffdf06e009so35043937b3.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593059; x=1707197859;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgIauGmyrGpKEXUINKH8zV3ggDfjrFXnkhV7HaAgky4=;
 b=o6bMqZWeRWXwshqrp+Qfd7VO2U8oVpObQE8ePIBlCEvQDeN8SPeHu9Ep+Cd2MxxI0M
 VD/Ffy5VaJwv/zk2hoj+lbLI6mYJypxNqBgAp2gDnFW+k0E3F6HKnCDw0OvwM9Xfu2Hy
 6e4nGI/bYC77jG8+SGKzqqQfALEiFDEdyZFAZPGZBc80wrvWFZ+w+H7bPjTeQnn8rHbd
 zVq5mSYuCf2KocwOhp3OgTBza7rA1HW/YArPaOiMC+k2uv/AKXcV4LxDBgsDnWxR2ZCC
 UIf+E8zpd09fyqIWb5ytfS5tNIrlcp+tKjy/1NSolLbR8yIHUhP0One5DilWn6OstW/L
 40Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593059; x=1707197859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GgIauGmyrGpKEXUINKH8zV3ggDfjrFXnkhV7HaAgky4=;
 b=EfOGYn3wY7tO9H9jRTvYL8ckroRj8Aw8uaqLoJ3vuIo4s7bcA/d3idgGrN2tRANBD9
 jacS+RmVSkUbds+d6RP2CDkOBd22gxuvoa68OCWq3HSyY/XKcuhqt0R1rmipYf5Y9CiU
 pxkt3AJRYphvyq/JWyGfh0cHh+ulnOaPSvsrpDxUYGl1oG5CI9TFcYQ2ACmkqiLsqbzj
 UJguoL+jAqNJnLVn1NVdMx0nzWlRDlFYKqO6D7BGLMp4/s/Ci/E7CPH7WoEWko7+zgAf
 Vf8OBL0cVW2Qp/4PoKrIw4yCX5VD/kPn6cbfEyCDtlUivPftL1b4y77AWhH8OV4gTTAJ
 4vwQ==
X-Gm-Message-State: AOJu0YxnND99MRWDq1X5Cq+LHNuiw5C3uxT7B0bG3hBaYlJcF6MEnVt/
 ZEuw0mUnTt5fkNyvMpt/uobu7CNt6W7IjY1CqZgpuUJWoz+JAJjDs0C34ew1IQ3i+wNL2WcOSAN
 uL6I=
X-Google-Smtp-Source: AGHT+IEZHbVoS+l8rYL3uw7l10gW5QjIP0/w6qWR4FaGRV7XP9Kysqw70t8AoI7tLpxWiLyCzU1Epg==
X-Received: by 2002:a81:ae50:0:b0:5ee:65b3:f289 with SMTP id
 g16-20020a81ae50000000b005ee65b3f289mr4843588ywk.3.1706593058052; 
 Mon, 29 Jan 2024 21:37:38 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:37 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 3/7] crypto: Modify the qcrypto_block_create to support
 creation flags
Date: Tue, 30 Jan 2024 13:37:21 +0800
Message-Id: <bc537fae33d4c3ba64371359d6dfd4928e653047.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706586786.git.yong.huang@smartx.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1129;
 envelope-from=yong.huang@smartx.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Expand the signature of qcrypto_block_create to enable the
formation of LUKS volumes with detachable headers. To accomplish
that, introduce QCryptoBlockCreateFlags to instruct the creation
process to set the payload_offset_sector to 0.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c                 |  1 +
 block/qcow.c                   |  2 +-
 block/qcow2.c                  |  2 +-
 crypto/block-luks.c            | 28 +++++++++++++++++++++-------
 crypto/block.c                 |  4 +++-
 crypto/blockpriv.h             |  2 ++
 include/crypto/block.h         | 11 +++++++++++
 tests/unit/test-crypto-block.c |  2 ++
 8 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index e87dc84111..1b3f87922a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -369,6 +369,7 @@ block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
                                   block_crypto_create_init_func,
                                   block_crypto_create_write_func,
                                   &data,
+                                  0,
                                   errp);
 
     if (!crypto) {
diff --git a/block/qcow.c b/block/qcow.c
index c6d0e15f1e..ca8e1d5ec8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -885,7 +885,7 @@ qcow_co_create(BlockdevCreateOptions *opts, Error **errp)
         header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
 
         crypto = qcrypto_block_create(qcow_opts->encrypt, "encrypt.",
-                                      NULL, NULL, NULL, errp);
+                                      NULL, NULL, NULL, 0, errp);
         if (!crypto) {
             ret = -EINVAL;
             goto exit;
diff --git a/block/qcow2.c b/block/qcow2.c
index 9bee66fff5..204f5854cf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3216,7 +3216,7 @@ qcow2_set_up_encryption(BlockDriverState *bs,
     crypto = qcrypto_block_create(cryptoopts, "encrypt.",
                                   qcow2_crypto_hdr_init_func,
                                   qcow2_crypto_hdr_write_func,
-                                  bs, errp);
+                                  bs, 0, errp);
     if (!crypto) {
         return -EINVAL;
     }
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 10373aaba4..8ad7cc44a5 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1304,6 +1304,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     const char *hash_alg;
     g_autofree char *cipher_mode_spec = NULL;
     uint64_t iters;
+    uint64_t detached_header_size;
 
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
     if (!luks_opts.has_iter_time) {
@@ -1532,19 +1533,32 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         slot->stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
     }
 
-    /* The total size of the LUKS headers is the partition header + key
-     * slot headers, rounded up to the nearest sector, combined with
-     * the size of each master key material region, also rounded up
-     * to the nearest sector */
-    luks->header.payload_offset_sector = header_sectors +
-            QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
+    if (block->detached_header) {
+        /*
+         * For a detached LUKS header image, set the payload_offset_sector
+         * to 0 to specify the starting point for read/write
+         */
+        luks->header.payload_offset_sector = 0;
+    } else {
+        /*
+         * The total size of the LUKS headers is the partition header + key
+         * slot headers, rounded up to the nearest sector, combined with
+         * the size of each master key material region, also rounded up
+         * to the nearest sector
+         */
+        luks->header.payload_offset_sector = header_sectors +
+                QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
+    }
 
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset_sector *
         block->sector_size;
+    detached_header_size =
+        (header_sectors + QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS *
+         split_key_sectors) * block->sector_size;
 
     /* Reserve header space to match payload offset */
-    initfunc(block, block->payload_offset, opaque, &local_err);
+    initfunc(block, detached_header_size, opaque, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
diff --git a/crypto/block.c b/crypto/block.c
index 7bb4b74a37..506ea1d1a3 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -87,6 +87,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
                                    QCryptoBlockInitFunc initfunc,
                                    QCryptoBlockWriteFunc writefunc,
                                    void *opaque,
+                                   unsigned int flags,
                                    Error **errp)
 {
     QCryptoBlock *block = g_new0(QCryptoBlock, 1);
@@ -102,6 +103,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
     }
 
     block->driver = qcrypto_block_drivers[options->format];
+    block->detached_header = flags & QCRYPTO_BLOCK_CREATE_DETACHED;
 
     if (block->driver->create(block, options, optprefix, initfunc,
                               writefunc, opaque, errp) < 0) {
@@ -146,7 +148,7 @@ qcrypto_block_calculate_payload_offset(QCryptoBlockCreateOptions *create_opts,
         qcrypto_block_create(create_opts, optprefix,
                              qcrypto_block_headerlen_hdr_init_func,
                              qcrypto_block_headerlen_hdr_write_func,
-                             len, errp);
+                             len, 0, errp);
     return crypto != NULL;
 }
 
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 3c7ccea504..836f3b4726 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -42,6 +42,8 @@ struct QCryptoBlock {
     size_t niv;
     uint64_t payload_offset; /* In bytes */
     uint64_t sector_size; /* In bytes */
+
+    bool detached_header; /* True if disk has a detached LUKS header */
 };
 
 struct QCryptoBlockDriver {
diff --git a/include/crypto/block.h b/include/crypto/block.h
index d0d97f5d12..92e823c9f2 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -116,6 +116,10 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  size_t n_threads,
                                  Error **errp);
 
+typedef enum {
+    QCRYPTO_BLOCK_CREATE_DETACHED = (1 << 0),
+} QCryptoBlockCreateFlags;
+
 /**
  * qcrypto_block_create:
  * @options: the encryption options
@@ -123,6 +127,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
  * @initfunc: callback for initializing volume header
  * @writefunc: callback for writing data to the volume header
  * @opaque: data to pass to @initfunc and @writefunc
+ * @flags: bitmask of QCryptoBlockCreateFlags values
  * @errp: pointer to a NULL-initialized error object
  *
  * Create a new block encryption object for initializing
@@ -134,6 +139,11 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
  * generating new master keys, etc as required. Any existing
  * data present on the volume will be irrevocably destroyed.
  *
+ * If @flags contains QCRYPTO_BLOCK_CREATE_DETACHED then
+ * the open process will set the payload_offset_sector to 0
+ * to specify the starting point for the read/write of a
+ * detached LUKS header image.
+ *
  * If any part of initializing the encryption context
  * fails an error will be returned. This could be due
  * to the volume being in the wrong format, a cipher
@@ -147,6 +157,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
                                    QCryptoBlockInitFunc initfunc,
                                    QCryptoBlockWriteFunc writefunc,
                                    void *opaque,
+                                   unsigned int flags,
                                    Error **errp);
 
 /**
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 347cd5f3d7..6cfc817a92 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -283,6 +283,7 @@ static void test_block(gconstpointer opaque)
                                test_block_init_func,
                                test_block_write_func,
                                &header,
+                               0,
                                &error_abort);
     g_assert(blk);
 
@@ -362,6 +363,7 @@ test_luks_bad_header(gconstpointer data)
                                test_block_init_func,
                                test_block_write_func,
                                &buf,
+                               0,
                                &error_abort);
     g_assert(blk);
 
-- 
2.31.1


