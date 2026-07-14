Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE6DC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwn-0006Jk-4d; Tue, 14 Jul 2026 10:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwf-0006Cc-QY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwd-0002cz-V7
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:13 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso3157502a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038631; x=1784643431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tnq9zGOnDlnHudTuQIdRmy2dam2H/yfvlqpu292TAdc=;
 b=XiKK4PBUhoBtSWHPdFgNlbBampdIvZlQd8ofIL1+9J/VWa+vhLzLzZgbq1cMHvmJXx
 oDpVpj6xjJklaLptq3QUdm6E1gfZOmeGdox8A6W1McQjwe+UdPDh72ncbBBdRBVGdp/J
 8gjGHzH2R1k9rsDQrBGEDnI++cazXxUjOON/ZmCMGgGsvtt1xQqGMWKWQtlsq3EHXY1e
 sa7+0am1osEO1x1z/MKwo156c4pBVBc1JHqeuVe2UbXLrRHWLI4EAER3LJDXOvWGBSpQ
 mpUqqwlgK6zMpxBUUCKEgqVx49CTDz2cl0oPWgPFCIrf0DtOXt4G9Co77NHdQOl8gvZ8
 M1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038631; x=1784643431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tnq9zGOnDlnHudTuQIdRmy2dam2H/yfvlqpu292TAdc=;
 b=CJI8AqB9NAn8kegPDDURu5VsvhUTRixg1uI4SpmLzEQFNkpUTKRpS4JI0tXnT1b3Kq
 qIWdjYspgd4mX1dU6fZXWoGWwi1fphXCK7g+QZNTA4Rh8tEKC4fJ2yx9htPp2fce9MD8
 VPjPNVh5ZPWm9g4xbhWeBHF3y5ABdnNWrAcvTQ78DGKBFlhgNHPKu4wbHAPJ9dESizS6
 /nm0BSwDHxUuI1IuOyvWcC3IFgAwHGyeBY0VDvxEG5M/dZjlJU2dlY0T+RURvpYMuGwS
 oF8pN8RiLph+A5071ttzKNIptercOKCt7xlYT5offhJH7FWfNZ0QbOnefq05q1gsk0h/
 EBMg==
X-Gm-Message-State: AOJu0YyYcTD36Bnmk3ru4kb9z1sqHYACeiv+oCOPVJ1wBlD11LpHK8SJ
 s/WCQtJudUVxx0KVZ7SjNSjNdW+3POSeWZbX7uAvlBNf6U9AbakbOPAPCmVafLZq
X-Gm-Gg: AfdE7cn8CMLqI1bVMutbWPqMQ0l6muIGaSg9WBnHPGG0VjRNnpbETIa7CpP2YrzbnC6
 veUEte1jR1RUhhxiljrz/v6sSQPqk2xGEalotvv9xBeZgN2N9XP5+C7yC6CU/bR+s12xlWsyc7v
 ebxuus4tktSRduup2Ge4YJUzobW1SJSF3NZpN4ft062djQHfJ6O+2Jl1ue1a5ThewROLfK+6/bq
 YGqFhvPVyIYGE6FjiCHA5X43bJ1j+taEC+RZrt+TPQxXajWXxwdWkq7rgm+07Vu0v+xU3iDbSfp
 XMEvENSOibzar2uK60K+WoxXtp5FTauahA2WCHqOFfj9XxTx7fOsU4sFZ4puKx/Lnvx6cI4bLEV
 vDKvmOGPs50G+4AKuz8mSbK+lFeEtdQusmcd5yGfdWTJm3GEjr8BPT5GWybGRZcrp6/EHF8EBzp
 SDJFDBrUh5d8F8kHE7uz7olAVxEdzztdiJmvRlZ4nMmQ==
X-Received: by 2002:a05:6a21:e8a:b0:3c1:744:a584 with SMTP id
 adf61e73a8af0-3c35738f6bamr3165458637.19.1784038630424; 
 Tue, 14 Jul 2026 07:17:10 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:17:09 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 07/11] migration: add support for fault thread to load
 pages from disk
Date: Tue, 14 Jul 2026 19:45:43 +0530
Message-ID: <20260714141547.1268000-8-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

In fast snapshot load, we would like to serve faults as soon as possible
hence loading pages directly instead of requesting a source

Add postcopy_mapped_ram_load_page() function which serves single page
fault by reading the snapshot file. It uses bitmap_test_and_clear_atomic
on pending_bmap to coordinate between threads so each page is loaded
exactly once. Non-zero pages are read using qemu_get_buffer_at into a
temporary page (for loading page atomically), which is then placed using
postcopy_place_page. Zero pages are placed directly using
postcopy_place_page_zero.

Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
instead of requesting source in case of fast snapshot load. to_src_file
check is bypassed in fast snapshot load case as there is no source.

Call try_mark_postcopy_blocktime_begin on every page fault to support
postcopy-blocktime.

Allocate another channel in postcopy_temp_pages_setup(like the preempt
case), for both the fault thread and eager thread to load pages
independently.

Add function ramblock_file_bitmap_page_is_nonzero() which searches a
range of bits corresponding to a page for a set bit. This is just a bit
check for normal pages but for hugepages it checks the range to see if
any part of page is non zero.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/postcopy-ram.c | 121 +++++++++++++++++++++++++++++++++------
 migration/ram.c          |  11 +++-
 migration/ram.h          |   2 +
 3 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 2e2c9fae10..723070b5cd 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -949,6 +949,68 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                        pagesize);
 }
 
+/**
+ * postcopy_mapped_ram_load_page() - Load a page to given host address.
+ * @mis: Migration Incoming State.
+ * @rb: RAMBlock from where page is loaded.
+ * @rb_offset: Offset of page in RAMBlock.
+ * @haddr: Base of page where to load in page.
+ * @channel: Used to identify between threads and use corresponding temp.
+ * @errp: Set error in case of failure
+ *
+ * Load a page from RAMBlock at offset at given host address. Used by postcopy
+ * ram fault thread and eager thread in fast snapshot load case.
+ *
+ * Return: True on success.
+ */
+static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
+                                          RAMBlock *rb, ram_addr_t rb_offset,
+                                          uint64_t haddr, int channel,
+                                          Error **errp)
+{
+    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
+    size_t page;
+    size_t read;
+
+    page = rb_offset / qemu_ram_pagesize(rb);
+
+    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
+        if (ramblock_file_bitmap_page_is_nonzero(rb, page)) {
+            /*
+             * This can happen concurrently, but it's thread-safe because
+             * qemu_get_buffer_at() is thread-safe, and the caller will be using
+             * different temporary buffers.
+             */
+            read = qemu_get_buffer_at(mis->from_src_file, place_source,
+                                      qemu_ram_pagesize(rb),
+                                      rb->pages_offset + rb_offset, errp);
+
+            if (read != qemu_ram_pagesize(rb)) {
+                error_prepend(errp, "Could not read page %zu from RAM Block %s",
+                              page, rb->idstr);
+                return false;
+            }
+
+            if (postcopy_place_page(mis, (void *)haddr, place_source, rb)) {
+                error_setg(errp,
+                           "Failed to place page %zu from RAM Block %s at "
+                           "address %" PRIu64,
+                           page, rb->idstr, haddr);
+                return false;
+            }
+        } else {
+            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
+                error_setg(errp,
+                           "Failed to place zero page %zu from RAM Block %s at "
+                           "address %" PRIu64,
+                           page, rb->idstr, haddr);
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 /*
  * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
  * also optional: when zero is provided, the fault accounting will be ignored.
@@ -1310,6 +1372,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     int ret;
     size_t index;
     RAMBlock *rb = NULL;
+    Error *local_err = NULL;
 
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
@@ -1351,11 +1414,13 @@ static void *postcopy_ram_fault_thread(void *opaque)
             break;
         }
 
-        if (!mis->to_src_file) {
+        if (!migrate_mapped_ram() && !mis->to_src_file) {
             /*
-             * Possibly someone tells us that the return path is
-             * broken already using the event. We should hold until
-             * the channel is rebuilt.
+             * Possibly someone tells us that the return path is broken already
+             * using the event. We should hold until the channel is rebuilt.
+             * Fast snapshot load doesn't support pause and recover, because
+             * it's not necessary: we can fail right away when QEMU just booted
+             * with nothing to lose.
              */
             postcopy_pause_fault_thread(mis);
         }
@@ -1418,18 +1483,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset,
                                                 msg.arg.pagefault.feat.ptid);
+
+            if (migrate_mapped_ram()) {
+                /* Load page directly in case of fast snapshot load */
+
+                uintptr_t aligned = (uintptr_t)ROUND_DOWN(
+                    msg.arg.pagefault.address, qemu_ram_pagesize(rb));
+
+                if (try_mark_postcopy_blocktime_begin(
+                        mis, rb, rb_offset, (uintptr_t)aligned,
+                        msg.arg.pagefault.feat.ptid)) {
+                    if (!postcopy_mapped_ram_load_page(
+                            mis, rb, rb_offset, aligned, RAM_CHANNEL_POSTCOPY,
+                            &local_err)) {
+                        error_report_err(local_err);
+                        break;
+                    }
+                }
+            } else {
 retry:
-            /*
-             * Send the request to the source - we want to request one
-             * of our host page sizes (which is >= TPS)
-             */
-            ret = postcopy_request_page(mis, rb, rb_offset,
-                                        msg.arg.pagefault.address,
-                                        msg.arg.pagefault.feat.ptid);
-            if (ret) {
-                /* May be network failure, try to wait for recovery */
-                postcopy_pause_fault_thread(mis);
-                goto retry;
+                /*
+                 * Send the request to the source - we want to request one
+                 * of our host page sizes (which is >= TPS)
+                 */
+                ret = postcopy_request_page(mis, rb, rb_offset,
+                                            msg.arg.pagefault.address,
+                                            msg.arg.pagefault.feat.ptid);
+                if (ret) {
+                    /* May be network failure, try to wait for recovery */
+                    postcopy_pause_fault_thread(mis);
+                    goto retry;
+                }
             }
         }
 
@@ -1501,8 +1585,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
     unsigned i, channels;
     void *temp_page;
 
-    if (migrate_postcopy_preempt()) {
-        /* If preemption enabled, need extra channel for urgent requests */
+    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
+        /*
+         * If preemption enabled or it is fast snapshot load, need extra channel
+         * for urgent requests/faults
+         */
         mis->postcopy_channels = RAM_CHANNEL_MAX;
     } else {
         /* Both precopy/postcopy on the same channel */
diff --git a/migration/ram.c b/migration/ram.c
index 330fceaa43..4ab8e0e750 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -269,12 +269,21 @@ static void ramblock_pending_bmap_init(void)
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         assert(!rb->pending_bmap);
-        size_t size = rb->max_length >> qemu_target_page_bits();
+        size_t size = rb->max_length / qemu_ram_pagesize(rb);
         rb->pending_bmap = bitmap_new(size);
         bitmap_set(rb->pending_bmap, 0, size);
     }
 }
 
+bool ramblock_file_bitmap_page_is_nonzero(RAMBlock *rb, uint64_t page_idx)
+{
+    int page_bits = qemu_ram_pagesize(rb) / qemu_target_page_size();
+    uint64_t bmap_page_start = page_idx * page_bits;
+    uint64_t bmap_page_end = bmap_page_start + page_bits;
+    return find_next_bit(rb->file_bmap, bmap_page_end, bmap_page_start) !=
+           bmap_page_end;
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
diff --git a/migration/ram.h b/migration/ram.h
index 41697a7599..7e2eac58d3 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -95,6 +95,8 @@ void ram_handle_zero(void *host, uint64_t size);
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
 
+bool ramblock_file_bitmap_page_is_nonzero(RAMBlock *rb, uint64_t page_idx);
+
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
-- 
2.55.0


