Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6007C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgqW-0002rt-7M; Tue, 30 Jan 2024 00:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqR-0002rG-Ug
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:40 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqP-0001Mf-Iy
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:39 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5ffee6e8770so42069907b3.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593056; x=1707197856;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaYK0tSoXobJSD9k/CLgH5G9458n5lr/GaWLdjptppA=;
 b=JBIh7pUGdbfKOm+LqDxCRxvB0FalYLi4AHu1IY5gxCJKDrdv8XJPf0am6TJ+CaXVDS
 vsDc6meXXvvE4CN51LhFltncYXgnoPte0odXPkn7iJ0R3ep1f90M3p0W5UQuuqhiFTSc
 bOORos/EanQlK1XmrnqZmr+ySJtHMem7Sp50sGcnPsys949vhx0wBDw/lpcQV6mSEM2Q
 oWYE8mlZflzk1hKP+EsvGRP6ZVPgH6N0UcZQdb0cj9sz/wZ68bcQxclwcy32zgVh8WRQ
 voJL9qyKrMtVgjplTaCDHTIOI8HW0eluK1S/g79Kh/e/2Fp/mlOLlFzWdYHLq8OerT2A
 HFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593056; x=1707197856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaYK0tSoXobJSD9k/CLgH5G9458n5lr/GaWLdjptppA=;
 b=GfZ2oWFFvpq8eumh+6rGrYqoYfzrfDQXNwfdXasQpMr6yuO8RhWPLZxOtz7qH9Bbla
 Q36uMyyuh8DjAuBkaUuK2638jcoX6UBiCVDWZ5gSmbe//tKkSw1tY7wZKMfGSfUaE/X5
 OFC2tmtP37cXuPlh7gWTdJExDqO4bpDZeWNbfxs9gzWPOXOT3Wph7eKgIOCDecf9uAyb
 bUTtjo3YPSWYVKsjTPS7VTgn/qFG4CvImmsflfesUzuZyKRu9ZlfTN6pANAvJA4Z4RpF
 Yjlc2oWRqrYJDKGNrsxua/rBtIJ+m41JNKInDiTa5q7fH5Bx9UXBmaJzAUwN8h+T9msW
 sBUw==
X-Gm-Message-State: AOJu0YzlQ0nm/i0HrDiyMMwh1IZ2DSwkh+fph3ecY9u85klje6hbnK8P
 SByve/U6X3o8TKuQAvvCj8K5Qd0u15mVlF0oSdQLYjSwm4dIxzx356QdJZLAx0IlmPZnNw3R6qP
 w0rw=
X-Google-Smtp-Source: AGHT+IHTINHPUm7ZNm8snvTOU2RFytyHVDhQRqNLbgYDNZFwYNHfZatNAlFFbDGlmyMF916YvQRIqw==
X-Received: by 2002:a81:e505:0:b0:603:aa70:cd3f with SMTP id
 s5-20020a81e505000000b00603aa70cd3fmr5674727ywl.83.1706593055707; 
 Mon, 29 Jan 2024 21:37:35 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:35 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 2/7] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
Date: Tue, 30 Jan 2024 13:37:20 +0800
Message-Id: <af7253711254128efbc37b25fb5c47b851367ce7.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706586786.git.yong.huang@smartx.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::112e;
 envelope-from=yong.huang@smartx.com; helo=mail-yw1-x112e.google.com
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

To support detached LUKS header creation, make the existing 'file'
field in BlockdevCreateOptionsLUKS optional.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/crypto.c       | 21 ++++++++++++++-------
 qapi/block-core.json |  5 +++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 68656158e9..e87dc84111 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -663,9 +663,9 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
     luks_opts = &create_options->u.luks;
 
-    bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
-    if (bs == NULL) {
-        return -EIO;
+    if (luks_opts->file == NULL) {
+        error_setg(errp, "Formatting LUKS disk requires parameter 'file'");
+        return -EINVAL;
     }
 
     create_opts = (QCryptoBlockCreateOptions) {
@@ -677,10 +677,17 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         preallocation = luks_opts->preallocation;
     }
 
-    ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
-                                         preallocation, errp);
-    if (ret < 0) {
-        goto fail;
+    if (luks_opts->file) {
+        bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
+        if (bs == NULL) {
+            return -EIO;
+        }
+
+        ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
+                                             preallocation, errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
 
     ret = 0;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ae604c6019..69a88d613d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4957,7 +4957,8 @@
 #
 # Driver specific image creation options for LUKS.
 #
-# @file: Node to create the image format on
+# @file: Node to create the image format on, mandatory except when
+#        'preallocation' is not requested
 #
 # @size: Size of the virtual disk in bytes
 #
@@ -4968,7 +4969,7 @@
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
-  'data': { 'file':             'BlockdevRef',
+  'data': { '*file':            'BlockdevRef',
             'size':             'size',
             '*preallocation':   'PreallocMode' } }
 
-- 
2.31.1


