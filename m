Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8838DC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwi-0006Gp-Qt; Tue, 14 Jul 2026 10:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwb-0006Bb-BV
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:10 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwZ-0002cW-L6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:09 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so985837a91.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038626; x=1784643426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3rc6X3QUuPZRks4ZEy0gC68K6c+Nml37luhf4A5r5bs=;
 b=MHpKRJ21Dfpiw7qe/U34qwVzakTPp9V995O/Klw9SG0rDQ1w8Z0P8VVw7OMXp/fIVI
 rbTGlSsxpd0mGQbaTgrkfsdNqEOBp3SVou/ToXY2sS5FwF+SsEORnJKCIW7CDCcBQrdy
 Osaals9o/AsbewJnY6rT9lsC9sKsUuSO8IkOtyhH/jFZ26rV3ELWB6CPauvLwfWrqP2+
 Pi3Pb03cns14vECN/xk6/6l9u39iY+X/OBLWXnBGdzaHXcIsNZhLXziev9pRHprZz05s
 vEyvEiiVnHS/Q40jZUXOZpVBhwWxkoxHf5+wY3iznyvQyugEsH5lXv6Rq41+nviFYF5y
 I9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038626; x=1784643426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3rc6X3QUuPZRks4ZEy0gC68K6c+Nml37luhf4A5r5bs=;
 b=VGsROgvSZViQeV076IYhRS3d5e2C9eWcQfK1hqaTn4N9SQtL1TqFLBToy2saJ+/2sQ
 47YI/MKkGGZ+yRm402ywQ7Tr79DrqX6F+/zz7h1wbj/JAdYssSSHR8X3illstjZaUecA
 7VxVkrSV638DDFCak48AjJOMNCqkEZjXLGTk2p3hsUw7DJ39TuxbTgKR1zv4Fbc60Nji
 wEmCS3B9jLlAEb/Nxd99fXfSvEad4F2CKTLxytLsArgTIWDcvvv9oQmV8M8QEMhO6wrB
 fe3DYMeNCpvUqlEibLcsVFJ+Lc9KEBZoZfvPwCZFMOJCPG8wEmwiEkwOUQ6GBtsWc4C/
 1h/A==
X-Gm-Message-State: AOJu0YwLELFbA5jSaiaMRPEzkIDzMuI64IftuRZg6vSiuziS/bxduuo2
 Aih7tGOhETeFZAieQz9e3VhNgQVDh1Dm4U/0QNg/dhO6qKo18GxUCdBiYDSqU4U5
X-Gm-Gg: AfdE7cmQ9ezTfEg0Cf0dP4rNFIqM5X6hFMLvDKU/UzJ+1tQamdpGmyfEYE6xf1MskVY
 TjGQhJfy5tlpzzuNqF5YlWuJJ84UyW9vFkDQ1gFgdO8/T89RR+fkq/w+zri1B34CeqQatqSfL27
 Kzn8SOidntpRObIYZZ7nRrdu7Tmv/VwQJiR1mqIZ+W8xYVs9+AOZ6c4FYCC7NukGYeUrybYbVKn
 xgbTmukjZSN4TQbFlmaYzi8F+1j2r9hmIw0eLbyXrtM9Krk3ZCp/+o+xQidOfJsbtkQp4AMDTxf
 rW6ANK9XMq8kgiSYQ2iK/hfiZ1R2ka/f4bbXzd7QJpY0rJgRfGu37bgJanHLNvzSnVXQDXYGnhO
 kslcKevXU2u/RkfrCsEya/Hg7CSSUocr33VMx001f80As5AOseMEb7ak5VWBGg9RBGRsPviAFsM
 AvwLzF4AtAZDZ2eDLtU7HfbvRRL6690+k8apNsX47WNg==
X-Received: by 2002:a17:90b:3d4b:b0:381:1f51:1ff0 with SMTP id
 98e67ed59e1d1-38dc782ab85mr12118993a91.2.1784038625965; 
 Tue, 14 Jul 2026 07:17:05 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:17:05 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 06/11] migration: add RAMBlock field and helper for fast
 snapshot load
Date: Tue, 14 Jul 2026 19:45:42 +0530
Message-ID: <20260714141547.1268000-7-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1035.google.com
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
index 967db7c0db..330fceaa43 100644
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
2.55.0


