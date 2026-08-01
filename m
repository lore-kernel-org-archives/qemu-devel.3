Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D44C55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzbj-0001cU-JH; Fri, 31 Jul 2026 22:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbh-0001Sk-8p
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbf-0002XS-Cz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:48 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso1502073a91.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551865; x=1786156665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5vvoJt7uuGazpbvBnQG9ExbIA/smYa698BGAb2WHfG0=;
 b=jmIvV6kpFeKoHuLidHmPFmxpXj2ifplumafOWkQ5y104oRO+6n7BzDJ+OC/xlyxLNS
 MJf4j+Xqape8WeZ9Hb6x6Aqnfk/10kiJuX5frVX+l8//3KOI6d9Jdzr9o0LesnlhPlh1
 10w/zvlvTI6FOBqLKjxVVZLbbvTUCmf8ICxMJrcF9flilon4QPVmgTQnAEBQMgrx8hC9
 qvnBClV/s+f8cB14cgTwFhh1KNVYV2y9iULr9rvHtWwlWgdd9Hhqo7jxrtKTOrD+lwRP
 7TQUaFs7Qo0HXzHJs6g4M0bpo2B2rqiZWpS40yEnD6HNno6wBWcc6NkpdO+UskkMA9Lf
 cVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551866; x=1786156666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5vvoJt7uuGazpbvBnQG9ExbIA/smYa698BGAb2WHfG0=;
 b=s1+jbYkCs7ilQjpGHfFVEzMAJt0L6/0JHR2UJdpiIys+9eOMxziFZ8shidgGNrqfQQ
 syx04Uq6x9M2KrTeTRKam+RdIPTTz9KzPJ3UuEsl0AwOpCcpS772FNsJZhpr4lRFsRGj
 MCUzJh98t+r8odBWenag2kwHQrX87rp+AKzlVzqQU/o4v4HJEdGiIAwlE2bDIGa7pt13
 YTP+O+2Hr/I8m3Sy7DkxuX03epo62VqWkqWM+wwU+ibKXqKjZ+rRfUooSTj1V6k94KKA
 5Vil3X8e7MibGGsPdC7Jjncyj+UuE9ChP57cCM9SNfexLOvh1mqUmEdSUwLb9+QKohCA
 PMVA==
X-Gm-Message-State: AOJu0YxDhoPXMc3/77OmIJhp8f40D+2opxf6ZTViPHOkQvpIy9wdYqwU
 OayEw6xU1ukfHrYqfRxf3IR6ZkYVQGYiIiqHqEcj83Fyq6i4wfgYktmbKtt3b/iA
X-Gm-Gg: AR+sD13IwEovjZfwZYU9a3JfNNTd9r/N5lF1vuiQvGeTsCWZKkWra/EoXgT/buf1P5n
 s2Y3lQ/oYahRggB56gkEP8hSLaLhO9r3JNUz5odDB4GJsJ9vQCNRdol3vtdyaDMAFDv9KAHJ/xw
 WO+JZdibfQhpIx6fNxZ6tp5+SidLOpJ/bKVQ6Ljp+bT7TR6GFTvfJONyuTP2KM7yInh51CYYPj5
 5J/IqLxDBfXjgtWewOgVskasEN9cu+UjUCtlttXW+xD+uyCk9iQYO9WJhGz6nPz6hOOgL5foBVO
 ri71zww1TQU8YPXzv4/dq9KRdhIAErBB9uWVD5zT1OFfsWVUM6ScDGIUUu8mSwKLdMQLhCQp+Tz
 8GDgrCfD0P3ZYrKpNL4XuJkP34NnWMWSvHeStrAXXmFw13PWKVNk4/nuMLB7UouOKI5fSiMUR3a
 Py+p+6F9z9MHarJ4vzGKocXfgBdEfDRDS30GhOC9GrBc1hkXINBo+aOupgZSw30WBkEA/KVn6gA
 0mQo1AyHAdSHaag
X-Received: by 2002:a17:90b:4b8f:b0:38e:2524:7272 with SMTP id
 98e67ed59e1d1-38fbc56c8d6mr1714545a91.39.1785551865582; 
 Fri, 31 Jul 2026 19:37:45 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:44 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 06/11] migration: add RAMBlock field and helper for fast
 snapshot load
Date: Sat,  1 Aug 2026 08:06:23 +0530
Message-ID: <20260801023628.22665-7-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1031.google.com
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
index 967db7c0db..734fd90e12 100644
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
+        size_t size = rb->max_length / qemu_ram_pagesize(rb);
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


