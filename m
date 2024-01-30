Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0668C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgqi-0002uD-55; Tue, 30 Jan 2024 00:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqe-0002tb-V3
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:52 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqW-0001NY-OT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:46 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-603e7d19725so13626597b3.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593063; x=1707197863;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzPI5ZhDw6r0Ms2tiVi1ga4ywHBkJRenawMuK5yu+b8=;
 b=Fx1BLk3Ey4o+HWaGrHLGRVWrFduBY42rza3JIYEOCJuf10gRNOa4t0aiaOvHFckWG9
 T/j4FEDuNvRO3PvfvLSs09AX1uvnpVF1ZJ8c1YEblmmvZTz8HHVWngXuzewXP0/FY44N
 uvVbL8qAZN/IQRu3SUSwIpyUme2C1DiQTD3hvekfziFM+xgcXC7WXCkP13nURU76jJAD
 jlaDoSwaxndzRiZMG/fvr6UFKNyoOw1O3uGG7/hvrmygs+waM56ES+/8dDJcUWeOqKWq
 AJuuJckp6Xwcck+AWjJM+kNlB3g+mnjZiGeIGOMViGNvUg/vCUu5ekKGliCEyoerqdl9
 h++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593063; x=1707197863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzPI5ZhDw6r0Ms2tiVi1ga4ywHBkJRenawMuK5yu+b8=;
 b=mvV32YhmAOQTuXpOKARP2nZF0oge0r8/3KzK6PnRSOL95p5ULLdcyHYDib5q9W1Rlh
 DBaaAY2U32HvEmfcvNTz5NsIUxOAywwGemDmAtoSuaicUJIEdpcSGdmXvAdLAqkCUNRh
 +y0roKq3tHnsNNcunhL1ZaqvSG2bk1uxiBeIrBBJxJCjzjSqzWFCsiY8tSvBChKypRJE
 7tnzfeE//PtfGXg9iw3F0iQDCzSVy1OXhvVtgwEBBNAYY/9s8U/X/eVVbnBRTaI5hHQP
 6iyMBzJhLUi2GNoBP5OgzKI7gTK/MOXZ7vBsRdo/RzoavHfpadX3WnpwGlw62Gk6EnR+
 kP2Q==
X-Gm-Message-State: AOJu0Yyd51sHbwE/vw4WT/6G6RY3sztyzezxQpaRgr7phpc7i5qZjg+K
 BHzD4sNfpU0Hy2hgY7R6smlCr9rxBBxYNfDUoWjZ2+s9yfgRk4FJrqpxsnNHhx5BqE/Fhd/51SV
 p4o4=
X-Google-Smtp-Source: AGHT+IGIUC/LR1n0jPxa3coZEwW292LRhFWh84+rkQTHq9RXPWZD+rZJSG4Au/0kSt/C6acM2Cm8Yw==
X-Received: by 2002:a5b:d0d:0:b0:dc2:66ab:84b0 with SMTP id
 y13-20020a5b0d0d000000b00dc266ab84b0mr5707041ybp.64.1706593062808; 
 Mon, 29 Jan 2024 21:37:42 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:42 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 5/7] block: Support detached LUKS header creation using
 qemu-img
Date: Tue, 30 Jan 2024 13:37:23 +0800
Message-Id: <c573cf4d985b0386e2e419fcccd92245800cdeca.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706586786.git.yong.huang@smartx.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1134;
 envelope-from=yong.huang@smartx.com; helo=mail-yw1-x1134.google.com
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

Even though a LUKS header might be created with cryptsetup,
qemu-img should be enhanced to accommodate it as well.

Add the 'detached-header' option to specify the creation of
a detached LUKS header. This is how it is used:
$ qemu-img create --object secret,id=sec0,data=abc123 -f luks
> -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0
> -o detached-header=true header.luks

Using qemu-img or cryptsetup tools to query information of
an LUKS header image as follows:

Assume a detached LUKS header image has been created by:
$ dd if=/dev/zero of=test-header.img bs=1M count=32
$ dd if=/dev/zero of=test-payload.img bs=1M count=1000
$ cryptsetup luksFormat --header test-header.img test-payload.img
> --force-password --type luks1

Header image information could be queried using cryptsetup:
$ cryptsetup luksDump test-header.img

or qemu-img:
$ qemu-img info 'json:{"driver":"luks","file":{"filename":
> "test-payload.img"},"header":{"filename":"test-header.img"}}'

When using qemu-img, keep in mind that the entire disk
information specified by the JSON-format string above must be
supplied on the commandline; if not, an overlay check will reveal
a problem with the LUKS volume check logic.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block.c          |  5 ++++-
 block/crypto.c   | 10 +++++++++-
 block/crypto.h   |  8 ++++++++
 qapi/crypto.json |  5 ++++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 30afdcbba6..1ed9214f66 100644
--- a/block.c
+++ b/block.c
@@ -7357,7 +7357,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
         goto out;
     }
 
-    if (size == -1) {
+    /* Parameter 'size' is not needed for detached LUKS header */
+    if (size == -1 &&
+        !(!strcmp(fmt, "luks") &&
+          qemu_opt_get_bool(opts, "detached-header", false))) {
         error_setg(errp, "Image creation needs a size parameter");
         goto out;
     }
diff --git a/block/crypto.c b/block/crypto.c
index 8e7ee5e9ac..65426d3a16 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -231,6 +231,7 @@ static QemuOptsList block_crypto_create_opts_luks = {
         BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_DETACHED_HEADER(""),
         { /* end of list */ }
     },
 };
@@ -405,7 +406,7 @@ block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
 
     data = (struct BlockCryptoCreateData) {
         .blk = blk,
-        .size = size,
+        .size = flags & QCRYPTO_BLOCK_CREATE_DETACHED ? 0 : size,
         .prealloc = prealloc,
     };
 
@@ -791,6 +792,9 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     PreallocMode prealloc;
     char *buf = NULL;
     int64_t size;
+    bool detached_hdr =
+        qemu_opt_get_bool(opts, "detached-header", false);
+    unsigned int cflags = 0;
     int ret;
     Error *local_err = NULL;
 
@@ -830,6 +834,10 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
         goto fail;
     }
 
+    if (detached_hdr) {
+        cflags |= QCRYPTO_BLOCK_CREATE_DETACHED;
+    }
+
     /* Create format layer */
     ret = block_crypto_co_create_generic(bs, size, create_opts,
                                          prealloc, 0, errp);
diff --git a/block/crypto.h b/block/crypto.h
index 72e792c9af..dc3d2d5ed9 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -41,6 +41,7 @@
 #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
+#define BLOCK_CRYPTO_OPT_LUKS_DETACHED_HEADER "detached-header"
 #define BLOCK_CRYPTO_OPT_LUKS_KEYSLOT "keyslot"
 #define BLOCK_CRYPTO_OPT_LUKS_STATE "state"
 #define BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET "old-secret"
@@ -100,6 +101,13 @@
         .help = "Select new state of affected keyslots (active/inactive)",\
     }
 
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_DETACHED_HEADER(prefix)     \
+    {                                                         \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_DETACHED_HEADER, \
+        .type = QEMU_OPT_BOOL,                                \
+        .help = "Create a detached LUKS header",              \
+    }
+
 #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT(prefix)              \
     {                                                          \
         .name = prefix BLOCK_CRYPTO_OPT_LUKS_KEYSLOT,          \
diff --git a/qapi/crypto.json b/qapi/crypto.json
index fd3d46ebd1..62fd145223 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -223,6 +223,8 @@
 # @iter-time: number of milliseconds to spend in PBKDF passphrase
 #     processing.  Currently defaults to 2000. (since 2.8)
 #
+# @detached-header: create a detached LUKS header. (since 9.0)
+#
 # Since: 2.6
 ##
 { 'struct': 'QCryptoBlockCreateOptionsLUKS',
@@ -232,7 +234,8 @@
             '*ivgen-alg': 'QCryptoIVGenAlgorithm',
             '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
             '*hash-alg': 'QCryptoHashAlgorithm',
-            '*iter-time': 'int'}}
+            '*iter-time': 'int',
+            '*detached-header': 'bool'}}
 
 ##
 # @QCryptoBlockOpenOptions:
-- 
2.31.1


