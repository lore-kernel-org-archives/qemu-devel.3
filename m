Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B68CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3JS-00087i-6y; Wed, 17 Jun 2026 23:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3JQ-00086R-0b
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:04 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3JN-0002FF-PZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:03 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c858961a8efso199179a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 20:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781752860; x=1782357660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UuQ1fcG6Nvpe6RYZ8HgiP4tWeblSoX4zuvVb8Lrw5U=;
 b=OOafGZ4qezB72cfkn0O+V7CGmNXCqKxq2jsdD79eyKqx8S6Blq/3WuIdcnVW5CKUhz
 KAZCfujbdA7ETyadj3kLzlod9TRi7lZ6/ax2/BpB7DO/69FHLCz6KjiPDidmT3+K8682
 ATRzuYVE8XUQrtOrGuvty6FynWliyqvuyK7gDWstTO1ZdBbZtWhP17LNc/43ElZ4oFRe
 8uqioFew/ffJSHxl9/sAK5jQ+tOoe3KtwmescqNnxjREIX/7W9+tX2cjspGGiuHw0V+q
 YZw3KiyVdZjIb3NwfR8gjdy64zRxcbTro7XwUxD1n0cSGYqrg7XSdkmOlkfZV7NyQ/+x
 rVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781752860; x=1782357660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5UuQ1fcG6Nvpe6RYZ8HgiP4tWeblSoX4zuvVb8Lrw5U=;
 b=Q1TM/lVHcIFbAWOrtIIJy2AvJjaJA5GbHa6J4j00KVYx2XzfG0AdipOFnIKDHj0AvX
 shmLSXkZbjJqeq+BWytRfVOZULHJF+fO65dLgvA6x8meqPXFxgExJ+gl226khpnTdz++
 umtwcnVVgWYULrs3pJPRqiupRalbq/+5UBv2LkNg2NqZd5Ijj1zN2XkI6Sryg5Bu8ey/
 PXGYqQRMWIB96UDEKhNV1Lthsxmf10HQ+0VKmZzNsMziC5fqPg3SDQQDVOMxkSAqA/Y2
 Rrosc79RE24HypjTvDLQiWZspN7bwssxyylXT5cnCZmpyykqO22dCCo939OOZU1iyQhS
 UPSQ==
X-Gm-Message-State: AOJu0Yz49GwtVmHJHjjIUxmnK0OTO9XMSdncspB61dUVoau/dMfO9YDL
 2JdtfOzWH7iCNxExXU0gOCfdHFfSexeIts3JRtEPE0hGJV7C+ecM8Rs6jZSkM5hW
X-Gm-Gg: Acq92OHKxWdWxKSyvZGJXhHHlQuJulMFEGSB/t5Hs5ksrB6TmbdgMcwbSxngAweCuC7
 +68qO0HUvq80pr8Xq+oeffu3Fup6HsQTUyxPlAjGzEMrcha4RFgmC2h6ypkVYaBEYvNC8PDbhVH
 Fh5Ig7hNbAQ3JlBOogxDEJzKfMHMFj0/EyxATPYKsIMnylIv11nE51zqM3RVsJmU+Y7nkIlc+iO
 4sALGptcLExhZ9+mSQqDlTFutQUAvZKvnnTaOe7rfVXU0BJ45+YSDqW/so9Fh7hYRzPz4iLswIc
 DNrbYq5nci1p40nmljvuFz08iC+UfMybQv4dSedOAPOzSg8Tjp2Q8uYtx5JqO31bJWnJukVpA/p
 i+maLOO5euagkaIASEZms8rvnIE7S6BMUbfb6fCF55ETphTLEInI9Ha7MbWgcSIHUTKvzZOV5pG
 F6is2YcRsKkQQ7lLLbNlgAExZ4Y9cCSHxzLOqjpuKElA==
X-Received: by 2002:a05:6a20:3ca7:b0:3b3:fc6:622d with SMTP id
 adf61e73a8af0-3b8b7eef8e2mr7251409637.38.1781752859965; 
 Wed, 17 Jun 2026 20:20:59 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c88c6c2b2easm1534623a12.27.2026.06.17.20.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 20:20:59 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH 1/5] migration: add RAM Block fields and helpers for fast
 snapshot load
Date: Thu, 18 Jun 2026 08:50:06 +0530
Message-ID: <20260618032010.88755-2-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618032010.88755-1-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add two fields per RAMBlock:

- nonzeropages: Mirrors the mapped-ram bitmap for storing which pages
  are present in file and which are zero.
- pending_bmap: Bitmap to store internal state of which pages have been
  read by some thread to ensure coordination between threads.

Both fields are allocated and initialized in ram_load_setup and freed in
ram_load_cleanup. nonzeropages is populated in parse_ramblock_mapped_ram
eliminating the use of a temporary bitmap.

Change ram_load() to load using ram_load_precopy() in case of fast
snapshot load.

Also add migrate_fast_snapshot_load() returning true when both
postcopy-ram and mapped-ram capabilities are set.

Update qemu_get_buffer_at() to not set error to make it thread safe. All
the callers of qemu_get_buffer_at(), take care of error handling.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 include/system/ramblock.h |  8 +++++
 migration/options.c       |  5 ++++
 migration/options.h       |  1 +
 migration/qemu-file.c     | 10 +------
 migration/ram.c           | 61 ++++++++++++++++++++++++++++++++-------
 5 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 4435f8d55f..73275d0459 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -60,6 +60,14 @@ struct RAMBlock {
 
     /* Bitmap of already received pages.  Only used on destination side. */
     unsigned long *receivedmap;
+    /* Bitmap of zero pages. Used for fast snapshot load. */
+    unsigned long *nonzeropages;
+    /*
+     * Bitmap for pages that are yet to be read from disk. It is required for
+     * fault thread and eager thread to keep note of which pages are currently
+     * being read. Used by fast snapshot load.
+     */
+    unsigned long *pending_bmap;
 
     /*
      * bitmap to track already cleared dirty bitmap.  When the bit is
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..5f80dd5b42 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -467,6 +467,11 @@ bool migrate_rdma(void)
     return s->rdma_migration;
 }
 
+bool migrate_fast_snapshot_load(void)
+{
+    return migrate_mapped_ram() && migrate_postcopy_ram();
+}
+
 typedef enum WriteTrackingSupport {
     WT_SUPPORT_UNKNOWN = 0,
     WT_SUPPORT_ABSENT,
diff --git a/migration/options.h b/migration/options.h
index b46221998a..a81ca40d23 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -54,6 +54,7 @@ bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
 bool migrate_rdma(void);
 bool migrate_tls(void);
+bool migrate_fast_snapshot_load(void);
 
 /* capabilities helpers */
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5a48115bd..602ece1b74 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -553,17 +553,9 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
                           off_t pos)
 {
-    Error *err = NULL;
-
-    if (f->last_error) {
-        return 0;
-    }
-
-    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
-        qemu_file_set_error_obj(f, -EIO, err);
+    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, NULL) < 0) {
         return 0;
     }
-
     return buflen;
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index fc38ffbf8a..c2bacf3dfc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -252,6 +252,31 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
     return ret;
 }
 
+static void ramblock_non_zero_map_init(void)
+{
+    RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb)
+    {
+        assert(!rb->nonzeropages);
+        size_t size = rb->max_length >> qemu_target_page_bits();
+        rb->nonzeropages = bitmap_new(size);
+    }
+}
+
+static void ramblock_pending_bmap_init(void)
+{
+    RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb)
+    {
+        assert(!rb->pending_bmap);
+        size_t size = rb->max_length >> qemu_target_page_bits();
+        rb->pending_bmap = bitmap_new(size);
+        bitmap_set(rb->pending_bmap, 0, size);
+    }
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
@@ -3749,6 +3774,12 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     xbzrle_load_setup();
     ramblock_recv_map_init();
+    if (migrate_mapped_ram()) {
+        ramblock_non_zero_map_init();
+    }
+    if (migrate_fast_snapshot_load()) {
+        ramblock_pending_bmap_init();
+    }
 
     return 0;
 }
@@ -3768,6 +3799,10 @@ static int ram_load_cleanup(void *opaque)
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         g_free(rb->receivedmap);
         rb->receivedmap = NULL;
+        g_free(rb->pending_bmap);
+        rb->pending_bmap = NULL;
+        g_free(rb->nonzeropages);
+        rb->nonzeropages = NULL;
     }
 
     return 0;
@@ -4102,7 +4137,7 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
             host = host_from_ram_block_offset(block, offset);
             if (!host) {
                 error_setg(errp, "page outside of ramblock %s range",
-                           block->idstr);
+                            block->idstr);
                 return false;
             }
 
@@ -4110,10 +4145,10 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
 
             if (migrate_multifd()) {
                 read = ram_load_multifd_pages(host, size,
-                                              block->pages_offset + offset);
+                                                block->pages_offset + offset);
             } else {
                 read = qemu_get_buffer_at(f, host, size,
-                                          block->pages_offset + offset);
+                                            block->pages_offset + offset);
             }
 
             if (!read) {
@@ -4142,7 +4177,6 @@ err:
 static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                       ram_addr_t length, Error **errp)
 {
-    g_autofree unsigned long *bitmap = NULL;
     MappedRamHeader header;
     size_t bitmap_size;
     long num_pages;
@@ -4174,15 +4208,18 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
     num_pages = length / header.page_size;
     bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
-    bitmap = g_malloc0(bitmap_size);
-    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
+    if (qemu_get_buffer_at(f, (uint8_t *)block->nonzeropages, bitmap_size,
                            header.bitmap_offset) != bitmap_size) {
         error_setg(errp, "Error reading dirty bitmap");
         return;
     }
 
-    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) {
-        return;
+    if (!migrate_fast_snapshot_load()) {
+        /* Do not load RAM during setup for fast snapshot load */
+        if (!read_ramblock_mapped_ram(f, block, num_pages, block->nonzeropages,
+                                      errp)) {
+            return;
+        }
     }
 
     /* Skip pages array */
@@ -4460,9 +4497,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     static uint64_t seq_iter;
     /*
      * If system is running in postcopy mode, page inserts to host memory must
-     * be atomic
+     * be atomic. However, fast snapshot load uses the mapped ram precopy like
+     * path to read block headers and populating bitmaps.
      */
-    bool postcopy_running = postcopy_is_running();
+    bool load_using_postcopy =
+        postcopy_is_running() && !migrate_fast_snapshot_load();
 
     seq_iter++;
 
@@ -4478,7 +4517,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      */
     trace_ram_load_start();
     WITH_RCU_READ_LOCK_GUARD() {
-        if (postcopy_running) {
+        if (load_using_postcopy) {
             /*
              * Note!  Here RAM_CHANNEL_PRECOPY is the precopy channel of
              * postcopy migration, we have another RAM_CHANNEL_POSTCOPY to
-- 
2.54.0


