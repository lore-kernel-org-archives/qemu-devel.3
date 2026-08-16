Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA5C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvexJ-00086r-BZ; Sun, 16 Aug 2026 13:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexG-00086R-I2
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexE-00039h-Ry
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so32147775ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902447; x=1787507247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dubLpBFCiwdsk5+NM+KpCEOCaNgN9YyZVZ71LCMzMiw=;
 b=qcJCUdWPOZjtB3X1CqkY/X3a5mCtBlyW3AwH5+DOmFOfA8hkzrNKwwtskeHtVDS9YT
 3wzsvVeFFOI/1a8JX7iyvSnS6tReMLXw+XAt+oUcyotddptH1UXrwt7+aUFG5931PX8Y
 AGmt/thgIs+Dc1T+2WRoMuN6H3QCv9TcKAz1906MW2H0czPZjXEC8RCkoLqbBvapIHBL
 PgMI1BXqcp1P9o4DHR7bDpocDGiuxk1WYdAcvUhoKfGevQ0AYFTKYfsGqYTtvoCNE719
 bJJkN37/V46ssxuVayPn2tGyHJ545nz5pcrA50v/BCV14SYBupW58Q4C+bsGcGLAbHgd
 6hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902447; x=1787507247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dubLpBFCiwdsk5+NM+KpCEOCaNgN9YyZVZ71LCMzMiw=;
 b=k81stvq9cdni50fFzSfCV4nWGq/LCRT5gXX93gdh5+lKKrJq6Shm1TwpuVqZItUCtb
 sywDFyOSys8PWNAPmVZaNGTowWjzMLGLXawyIicHM9KD58yiBLV31IMBIVtrOrbeyRPo
 njQ4RYgomwkGTY3M3WKAvV0PXcCmKYcPS1lR7OM+2hVWVHrCnNS1mCedzGGQncITaamW
 GB0LQ3CqZdtsDUEN2N0itaotOXUtcmmHveERmiKEkru8555SP9hku/ak4UgA9yjtlbRG
 BrzJBBIhIZuPgjht6XT0/Aj0uFQ9oj1lvkeM2frGfW8pTelyXoGvHBTKHx46t3BwyVs2
 UO7g==
X-Gm-Message-State: AOJu0YwyZ4JZ86EbNUnaDeM9f9YHzxO0Jw2LyoU+yrWC2qZ19orZkJyb
 IymxYK56iZ0iq4OW4RhGOFKik+TKevGrpqsAHIPxscee5IIShjOisW20miyi0w==
X-Gm-Gg: AR+sD13/MYiqVd9hPvt6/hit1vHAXEwc0ify2sX91EZem+OWxLhM5MH2w3EvlUZnPff
 BwfvwHjRxV00VyZWevvDpO7NRUSzlOYcPhn+zDqys0f46VM0Mwowf98eiK+wyjUDek8jGpbN+vS
 gBS+BWoMUZF03WU5BsEeeDlNVusZg+p4HBd41OgUqczPsgB1F9iyboQBEgiwcTbHxhK0n6m0/ly
 cXQ7m1Bzy+FgB/nZgNazcEaFRe0EKeeJuMFQMNGjH+wemEObf1t+PDsINGBE7im0zrpnpTsoNd+
 6f/A8E53FfP/y1QrTNqQas+jn3uJOkWymgHjQqyRjNYD4qvNxtW0AtgN4bmilVT/SIYKSj4ZEYz
 0laKkzYU6VbboQkv8i5sqlUGwyvWx34xfGxWMxAoZ2xxj1vfFf2axRgCk/2HOyoGfPbzOPPNui+
 rXpgWeEqEh0cdOFsdAidgN4czIf8D3ZEJeWTEiMbtNMht08FUxjeIz010F/wQbPKc8d5GQ6NjlJ
 MgqFZOlSQBDZpk=
X-Received: by 2002:a17:903:2c8:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2d3b08014f7mr241876985ad.3.1786902447466; 
 Sun, 16 Aug 2026 10:47:27 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:26 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v5 06/11] migration: add RAMBlock field and helper for fast
 snapshot load
Date: Sun, 16 Aug 2026 23:16:26 +0530
Message-ID: <20260816174631.1547811-7-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x629.google.com
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
 migration/ram.c           | 66 +++++++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 6 deletions(-)

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
index 967db7c0db..52a3af9245 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -263,6 +263,25 @@ static void ramblock_file_bmap_init(void)
     }
 }
 
+static void ramblock_pending_bmap_init(void)
+{
+    RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
+        assert(!rb->pending_bmap);
+        /*
+         * The pending_bmap granularity must match the maximum of host and guest
+         * page sizes. This ensures that every load operation checks for one
+         * bit, allowing lockless thread coordination via a single-bit atomic
+         * test-and-clear.
+         */
+        size_t size = rb->max_length /
+                      MAX(qemu_ram_pagesize(rb), qemu_target_page_size());
+        rb->pending_bmap = bitmap_new(size);
+        bitmap_set(rb->pending_bmap, 0, size);
+    }
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
@@ -3762,6 +3781,10 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
     ramblock_recv_map_init();
     if (migrate_mapped_ram()) {
         ramblock_file_bmap_init();
+        if (migrate_postcopy_ram()) {
+            /* fast snapshot load */
+            ramblock_pending_bmap_init();
+        }
     }
 
     return 0;
@@ -3782,6 +3805,7 @@ static int ram_load_cleanup(void *opaque)
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         g_clear_pointer(&rb->receivedmap, g_free);
         g_clear_pointer(&rb->file_bmap, g_free);
+        g_clear_pointer(&rb->pending_bmap, g_free);
     }
 
     return 0;
@@ -4201,9 +4225,12 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
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
@@ -4475,15 +4502,42 @@ static int ram_load_precopy(QEMUFile *f)
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
 
@@ -4499,7 +4553,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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


