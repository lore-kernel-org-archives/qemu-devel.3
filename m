Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901AAC4828C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgqW-0002rv-KN; Tue, 30 Jan 2024 00:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqQ-0002r0-Nc
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:38 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqO-0001MF-9P
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:38 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d2dfa3bc64so507823241.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593054; x=1707197854;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgBjKCmGIw1QzGuAtBe8Fn0BN4xSBkw1xT0mmLT2npc=;
 b=0we04U9bPNNYh1In4+leZUwv/OtiL6f+JjI5IEifrIWSh8/JQ3bDV7PLovTraKt9aj
 h+ecFJ76oHqTVeNcms5ybH177SNYbo1fCZtBLiwq+ps0lrIAMfic2pLwawnnLoVmJP7V
 UUXi6GQTtYLorl85vPRuZ30VMW+uLOE8gWmFt7peKe4+GswXbwYUmi/1BuL5F4Jw1wr/
 Rg87e5OVZFG4TFRFkSLOOjxlpT5CHeZQVTm6RyduS4E7JAz6QbFS/IzFzWnDKU3gJiNY
 wQRoCn/l6SsiZvjrpA0cG4wqTbcoep1v97aDxeaqIGHPAd7u2DwmgHQGycw91hzf30/E
 bhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593054; x=1707197854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgBjKCmGIw1QzGuAtBe8Fn0BN4xSBkw1xT0mmLT2npc=;
 b=wgWdSNl+oj0LgR+yK0R1ElSox9lmEzF3tqavqxHiW++PhJ9ja+0EuHBWmuCs68vJvG
 9FWUQzyb+P1DlvbkwJI7kWo1/8Is+Lf1iZtBl4ob7OJya3W3B2j/5mkH4jAORe+U+Vot
 Ns2hLrHzMnX+oC8sOLDPS3BK1+fMBhwUTGsJi5Zh3eNgT6q0CL4Djo6Oi1t5krqvphFh
 dK+//FE0GDI3cLgmxNfOSerKvyPxbywyG8H8F4ds5Atyd3PlrYzuBMVICZja7lFRTQ7Y
 yN5BBp+cVuP/FqMbFEhdErNgrW5qsnVqlxZ3FzsgSuqlSzqVRIlWsnZZxJWaqP5ePbuo
 JCxQ==
X-Gm-Message-State: AOJu0YwVdTxgO05TYJtaKWj3fv3GjNr9ibjb9yImpNdDhpYXl9xr4S9/
 XKUAKzkr0yYrZ5Yd+EyVPQJSk0j2XZ9DEuzmi6cN1kXSGr41b/t+9LwBfXpjzmmLyneTNLT1CeJ
 79RU=
X-Google-Smtp-Source: AGHT+IHEdsnnvhbd1i+PHsLhVYF/9HKrKR3440uMhQ7nQMMkJVuPGhsv6/4PbqbLxLLaGualIi3jYw==
X-Received: by 2002:a05:6102:2143:b0:46b:5b70:dfe1 with SMTP id
 h3-20020a056102214300b0046b5b70dfe1mr2287376vsg.2.1706593053347; 
 Mon, 29 Jan 2024 21:37:33 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:32 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 1/7] crypto: Support LUKS volume with detached header
Date: Tue, 30 Jan 2024 13:37:19 +0800
Message-Id: <d597f01ce328442940f5dd4653cf7ec75fe0ce02.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706586786.git.yong.huang@smartx.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::934;
 envelope-from=yong.huang@smartx.com; helo=mail-ua1-x934.google.com
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

By enhancing the LUKS driver, it is possible to implement
the LUKS volume with a detached header.

Normally a LUKS volume has a layout:
  disk:  | header | key material | disk payload data |

With a detached LUKS header, you need 2 disks so getting:
  disk1:  | header | key material |
  disk2:  | disk payload data |

There are a variety of benefits to doing this:
 * Secrecy - the disk2 cannot be identified as containing LUKS
             volume since there's no header
 * Control - if access to the disk1 is restricted, then even
             if someone has access to disk2 they can't unlock
             it. Might be useful if you have disks on NFS but
             want to restrict which host can launch a VM
             instance from it, by dynamically providing access
             to the header to a designated host
 * Flexibility - your application data volume may be a given
                 size and it is inconvenient to resize it to
                 add encryption.You can store the LUKS header
                 separately and use the existing storage
                 volume for payload
 * Recovery - corruption of a bit in the header may make the
              entire payload inaccessible. It might be
              convenient to take backups of the header. If
              your primary disk header becomes corrupt, you
              can unlock the data still by pointing to the
              backup detached header

Take the raw-format image as an example to introduce the usage
of the LUKS volume with a detached header:

1. prepare detached LUKS header images
$ dd if=/dev/zero of=test-header.img bs=1M count=32
$ dd if=/dev/zero of=test-payload.img bs=1M count=1000
$ cryptsetup luksFormat --header test-header.img test-payload.img
> --force-password --type luks1

2. block-add a protocol blockdev node of payload image
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> "filename":"test-payload.img"}}'

3. block-add a protocol blockdev node of LUKS header as above.
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-storage", "driver":"file",
> "filename": "test-header.img" }}'

4. object-add the secret for decrypting the cipher stored in
   LUKS header above
$ virsh qemu-monitor-command vm '{"execute":"object-add",
> "arguments":{"qom-type":"secret", "id":
> "libvirt-2-storage-secret0", "data":"abc123"}}'

5. block-add the raw-drived blockdev format node
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-format", "driver":"raw",
> "file":"libvirt-1-storage"}}'

6. block-add the luks-drived blockdev to link the raw disk
   with the LUKS header by specifying the field "header"
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-format", "driver":"luks",
> "file":"libvirt-1-format", "header":"libvirt-2-storage",
> "key-secret":"libvirt-2-format-secret0"}}'

7. hot-plug the virtio-blk device finally
$ virsh qemu-monitor-command vm '{"execute":"device_add",
> "arguments": {"num-queues":"1", "driver":"virtio-blk-pci",
> "drive": "libvirt-2-format", "id":"virtio-disk2"}}'

Starting a VM with a LUKS volume with detached header is
somewhat similar to hot-plug in that both maintaining the
same json command while the starting VM changes the
"blockdev-add/device_add" parameters to "blockdev/device".

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c         | 21 +++++++++++++++++++--
 crypto/block-luks.c    | 11 +++++++----
 include/crypto/block.h |  5 +++++
 qapi/block-core.json   |  5 ++++-
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 921933a5e5..68656158e9 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -39,6 +39,7 @@ typedef struct BlockCrypto BlockCrypto;
 struct BlockCrypto {
     QCryptoBlock *block;
     bool updating_keys;
+    BdrvChild *header;  /* Reference to the detached LUKS header */
 };
 
 
@@ -63,12 +64,14 @@ static int block_crypto_read_func(QCryptoBlock *block,
                                   Error **errp)
 {
     BlockDriverState *bs = opaque;
+    BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    ret = bdrv_pread(bs->file, offset, buflen, buf, 0);
+    ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
+                     offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read encryption header");
         return ret;
@@ -84,12 +87,14 @@ static int block_crypto_write_func(QCryptoBlock *block,
                                    Error **errp)
 {
     BlockDriverState *bs = opaque;
+    BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    ret = bdrv_pwrite(bs->file, offset, buflen, buf, 0);
+    ret = bdrv_pwrite(crypto->header ? crypto->header : bs->file,
+                      offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not write encryption header");
         return ret;
@@ -262,6 +267,8 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
                                      int flags,
                                      Error **errp)
 {
+    ERRP_GUARD();
+
     BlockCrypto *crypto = bs->opaque;
     QemuOpts *opts = NULL;
     int ret;
@@ -276,6 +283,13 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         return ret;
     }
 
+    crypto->header = bdrv_open_child(NULL, options, "header", bs,
+                                     &child_of_bds, BDRV_CHILD_METADATA,
+                                     true, errp);
+    if (*errp != NULL) {
+        return -EINVAL;
+    }
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     bs->supported_write_flags = BDRV_REQ_FUA &
@@ -299,6 +313,9 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     if (flags & BDRV_O_NO_IO) {
         cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
     }
+    if (crypto->header != NULL) {
+        cflags |= QCRYPTO_BLOCK_OPEN_DETACHED;
+    }
     crypto->block = qcrypto_block_open(open_opts, NULL,
                                        block_crypto_read_func,
                                        bs,
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index fb01ec38bb..10373aaba4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -457,12 +457,15 @@ qcrypto_block_luks_load_header(QCryptoBlock *block,
  * Does basic sanity checks on the LUKS header
  */
 static int
-qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
+qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks,
+                                unsigned int flags,
+                                Error **errp)
 {
     size_t i, j;
 
     unsigned int header_sectors = QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+    bool detached = flags & QCRYPTO_BLOCK_OPEN_DETACHED;
 
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
@@ -494,7 +497,7 @@ qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
         return -1;
     }
 
-    if (luks->header.payload_offset_sector <
+    if (!detached && luks->header.payload_offset_sector <
         DIV_ROUND_UP(QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET,
                      QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) {
         error_setg(errp, "LUKS payload is overlapping with the header");
@@ -543,7 +546,7 @@ qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
             return -1;
         }
 
-        if (start1 + len1 > luks->header.payload_offset_sector) {
+        if (!detached && start1 + len1 > luks->header.payload_offset_sector) {
             error_setg(errp,
                        "Keyslot %zu is overlapping with the encrypted payload",
                        i);
@@ -1203,7 +1206,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         goto fail;
     }
 
-    if (qcrypto_block_luks_check_header(luks, errp) < 0) {
+    if (qcrypto_block_luks_check_header(luks, flags, errp) < 0) {
         goto fail;
     }
 
diff --git a/include/crypto/block.h b/include/crypto/block.h
index 4f63a37872..d0d97f5d12 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -66,6 +66,7 @@ bool qcrypto_block_has_format(QCryptoBlockFormat format,
 
 typedef enum {
     QCRYPTO_BLOCK_OPEN_NO_IO = (1 << 0),
+    QCRYPTO_BLOCK_OPEN_DETACHED = (1 << 1),
 } QCryptoBlockOpenFlags;
 
 /**
@@ -95,6 +96,10 @@ typedef enum {
  * metadata such as the payload offset. There will be
  * no cipher or ivgen objects available.
  *
+ * If @flags contains QCRYPTO_BLOCK_OPEN_DETACHED then
+ * the open process will be optimized to skip the LUKS
+ * payload overlap check.
+ *
  * If any part of initializing the encryption context
  * fails an error will be returned. This could be due
  * to the volume being in the wrong format, a cipher
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 48c181e55d..ae604c6019 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3365,11 +3365,14 @@
 #     decryption key (since 2.6). Mandatory except when doing a
 #     metadata-only probe of the image.
 #
+# @header: block device holding a detached LUKS header. (since 9.0)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsLUKS',
   'base': 'BlockdevOptionsGenericFormat',
-  'data': { '*key-secret': 'str' } }
+  'data': { '*key-secret': 'str',
+            '*header': 'BlockdevRef'} }
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
-- 
2.31.1


