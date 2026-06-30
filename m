Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45DFC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTi5-0005Dh-HY; Tue, 30 Jun 2026 04:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weTi0-00056d-6b
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThw-0003TK-Jb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c9b1edf2bdso15230105ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807639; x=1783412439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYYeMV/E9f/Nxn7LVdHk0y8KY7HIlOmILgZ3wts5ucg=;
 b=DGTsdQm9/JvNSi5Zdwt1JmhQyCyAfg82wUHn9lfkeeOOwQtX9Z8/vSb4430Z6D5ihN
 WzT865CSVuNBZyNMMv/iADpXCSRdvS3qdr8pdk7Bd9jB2sOLSmToe4TRQE2+fKXLhZ/0
 UOhm++g8Z4ZeI5RmRxxjgFjIdyF7VMTfXyWTRt08RtTjWT/Z6qB9HKlgoJNnuIHEZMba
 EiOmK/IF+vJJdxuUWWCXvbJJzuQoKJTC4SMkLAGq7HTScWikN8DqS+AzBf6vo8zpTTRS
 z5Pwnw6hyZZ90CB+ByKsVj8PCB96VEQoTZDr3gL8Mek5lBqKP+nrL7oSb5AcytoiVg0O
 CVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807639; x=1783412439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aYYeMV/E9f/Nxn7LVdHk0y8KY7HIlOmILgZ3wts5ucg=;
 b=RYT2P6cuua6LqmAtzFw3EPfMa2drmoaDo47HTEc6oJ2qHCCK2gDhDdqNKW5Uwt/r62
 vR92XG3kDVIRKDlRIorCuatO4afB1gzyO0a5VEjxngRD4CyRhYWvGp586Y+Z9UC7qS3u
 80VuBejcnlLD0NkqNEFm4AgKEVgS8SCgz6KB1tiNhj9h71wIfpOj45tl6t34Fe8um4ZA
 Co5dtgHYbhkz+/y7d3ycIDMyMVQNsEggf4qjT4C8Q50plJdoKBRESlHALZ6Ye9WmtWpJ
 5ZJgcg23qmp8iow2Bv5nuUKBQv8kV2xZkhRwC7IfRGxEaUHfEwRsEXbjuJ8sMzdarN6J
 amlQ==
X-Gm-Message-State: AOJu0YynHzbQ8Ajht0zly+fvkYkl/CaQmRsPFx13PR62mYS9MMZAPRa3
 5BKWEWzxd3B2bQBUT4DYVWT6zjKsg6uRdQPPFb7zVOG6iXiZHKqTj6ZOFNXE/LPw
X-Gm-Gg: AfdE7clG1JIe6VYOv4s3oQwVJUtPGtYnpGaC4BVMXS+YDkKZIv0l28765ZjNA+xBpzs
 dPfq0zja/EuwNrp4TQKK6XNYO9aL6rNOUL+5Wy7MmixHHwxyfwNWelEJ5q4rU2O0Pj/DPB/Wm0j
 gF9dwlHo2LjvfpWXimxvi8PGBpsw33B2ve2TmJ7tah0q7M7v3tMGj/kXWTT1MgFVXMBq4l1rc42
 NPzDyNNWCv1g4S/Gl1ynHsRvdJ8+1Tetw8NObnAF/ER8NLIE7BDT43RxYeItfuHI8JACC5+SJMc
 V/2JcVQdb4XvM34lApJheYLvvib4WF8xniW5lw8hbeFe7s79ukXD4hCbI8N0fXl4Fru6DKenFXf
 1ot8d+MHLxzgTwhXR1HApzhF8kyKr5W4UOQDdGcIVIxHb/ZkmR0l2yBeESl9eLa3P4LGlW19+qz
 XAZB0WVYIHIciCUnXQCUnwq2xZzceN3/o6EkkF/ztkXL8=
X-Received: by 2002:a17:902:ce01:b0:2c2:27be:39a7 with SMTP id
 d9443c01a7336-2ca2ed32422mr19199155ad.29.1782807638688; 
 Tue, 30 Jun 2026 01:20:38 -0700 (PDT)
Received: from setun ([2401:4900:a344:dc6e:573c:3e9:c03e:731a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca4f2a71dbsm1284615ad.50.2026.06.30.01.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:20:38 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH v2 5/7] migration: add RAMBlock field and helper for fast
 snapshot load
Date: Tue, 30 Jun 2026 13:49:38 +0530
Message-ID: <20260630081940.611092-6-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630081940.611092-1-aadeshveer07@gmail.com>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x62f.google.com
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

Add pending_bmap field per RAMBlock which is a Bitmap to store
internal state of which pages have been read by some thread to ensure
coordination between fault thread and eager load thread.

Modify parse_ramblock_mapped_ram(), to not load the actual RAMBlocks
data in postcopy case as that will be loaded by fault thread and eager
thread after the VM starts running.

Change ram_load() to use new function ram_should_load_postcopy_pages()
to decide how to load/read RAM.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 include/system/ramblock.h |  6 ++++
 migration/ram.c           | 59 +++++++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 4435f8d55f..83187bf44c 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -60,6 +60,12 @@ struct RAMBlock {
 
     /* Bitmap of already received pages.  Only used on destination side. */
     unsigned long *receivedmap;
+    /*
+     * Bitmap for pages that are yet to be read from disk. It is required for
+     * fault thread and eager thread to keep note of which pages are currently
+     * being read. Used by fast snapshot load.
+     */
+    unsigned long *pending_bmap;
 
     /*
      * bitmap to track already cleared dirty bitmap.  When the bit is
diff --git a/migration/ram.c b/migration/ram.c
index 4728f14d73..ffd60b2ac8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -263,6 +263,18 @@ static void ramblock_file_bmap_init(void)
     }
 }
 
+static void ramblock_pending_bmap_init(void)
+{
+    RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
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
@@ -3762,6 +3774,10 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
     ramblock_recv_map_init();
     if (migrate_mapped_ram()) {
         ramblock_file_bmap_init();
+        if (migrate_postcopy_ram()) {
+            /* fast snapshot load */
+            ramblock_pending_bmap_init();
+        }
     }
 
     return 0;
@@ -3782,6 +3798,7 @@ static int ram_load_cleanup(void *opaque)
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         g_clear_pointer(&rb->receivedmap, g_free);
         g_clear_pointer(&rb->file_bmap, g_free);
+        g_clear_pointer(&rb->pending_bmap, g_free);
     }
 
     return 0;
@@ -4201,9 +4218,12 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
         return;
     }
 
-    if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
-                                  errp)) {
-        return;
+    if (!migrate_postcopy_ram()) {
+        /* Do not load RAM during setup for fast snapshot load */
+        if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
+                                      errp)) {
+            return;
+        }
     }
 
     /* Skip pages array */
@@ -4475,15 +4495,42 @@ static int ram_load_precopy(QEMUFile *f)
     return ret;
 }
 
+static bool ram_should_load_postcopy_pages(void)
+{
+    /* This is pure precopy, we don't need to load pages in postcopy way */
+    if (!postcopy_is_running()) {
+        return false;
+    }
+
+    /*
+     * This is postcopy, but when with mapped-ram, pages are not loaded in the
+     * migration stream here, but done separately in a thread eagerly reading
+     * pages from the snapshot.  Here, we only need to read the ram headers,
+     * reusing the precopy code.
+     * TODO: when we have separate function to parse RAM headers we should
+     * switch to that.
+     */
+    if (migrate_mapped_ram()) {
+        return false;
+    }
+
+    /*
+     * Genuine network postcopy, we will load pages in this current stream and
+     * they need to be done in postcopy way.
+     */
+    return true;
+}
+
 static int ram_load(QEMUFile *f, void *opaque, int version_id)
 {
     int ret = 0;
     static uint64_t seq_iter;
     /*
      * If system is running in postcopy mode, page inserts to host memory must
-     * be atomic
+     * be atomic. However, fast snapshot load uses the mapped ram precopy like
+     * path to read block headers and populating bitmaps.
      */
-    bool postcopy_running = postcopy_is_running();
+    bool load_postcopy_pages = ram_should_load_postcopy_pages();
 
     seq_iter++;
 
@@ -4499,7 +4546,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      */
     trace_ram_load_start();
     WITH_RCU_READ_LOCK_GUARD() {
-        if (postcopy_running) {
+        if (load_postcopy_pages) {
             /*
              * Note!  Here RAM_CHANNEL_PRECOPY is the precopy channel of
              * postcopy migration, we have another RAM_CHANNEL_POSTCOPY to
-- 
2.54.0


