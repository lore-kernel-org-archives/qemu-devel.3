Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B19AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTi4-0005DI-KK; Tue, 30 Jun 2026 04:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weTi2-00059j-RU
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:46 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weTi1-0003VK-1C
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ca265d6ca1so2375745ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807643; x=1783412443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsMMXzGNMU+wpIe+e40sOz/5tgxI4sRHgNkcRSe5bUo=;
 b=OtV7GMa+pAQ7B5m84irf4bam1PPnURfTBTyaWswQStedHYsA2eMWimlKR+8AA4S1zL
 b0yUWMyL4x1rlgkYT7tWdcZ1a4KFyZ6TNcStEDXPYUnzExrYT2OCE2yHXSmZdJRLI5Gk
 tWlmyz6USf8pNJTpd9RomtJe8KrLRdet06ociKd0cDl57J8OufMWfgjRiDmza7oUP+yg
 Vcp4rcLrkwectKJnDtgmKV5dq+hUTW5DFJm9xh0IA7JHvuGjDB2NgnjZr9jYzPICAAze
 g7xVBEKVVrv5FPS3hjkPhyr/Mw5VJw189in7z2HUAt7K6s84cVFFsJgQqmQ/CwuW9NPo
 B3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807643; x=1783412443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsMMXzGNMU+wpIe+e40sOz/5tgxI4sRHgNkcRSe5bUo=;
 b=nlb77PBWClpm6uAtQnPi2iBa9/kmlFO5arBCVcPXqiP9XVYml5nKFWJ4IWVxakxhAX
 8uPcj8N/yxwM/k7vvr4n09avMycUyuVaWKsB7okSv1DGSJuFqq6hCS77dcyLtpL4vgSz
 Wr0UvBStON7lQmt2LvaIaYebpRr1tIAXDQ8k+W48fiSKhdwCijpeAuTTv+g8gKUTtB5/
 AiVznW15ZG/NExKXxTCc8YwG2AbaMyoW0jaTf0arcVcIr0Xtz+Pncv84ajNXswl/7MQa
 xw7ylw3O6TqTeN57iWEiO9lvDHIVwfS0xmR++21gVpO4CGYQtGTzqSSyiQWYDPrIFxQu
 V1aA==
X-Gm-Message-State: AOJu0YypH7O3ahYpYvE0W8CRsa7un7v5tkSE8CBIs5FlNieAN+BWAD2N
 BuwZW3xDn95pZqzr5HjsOv0sgG2usk6XoZQVXFC8hmeMTOp+M048djnMU9lxH4y8
X-Gm-Gg: AfdE7cnJ+NIgiGocAdSSzY1Yl5lXiumxS3varsmW92GLVWnyHSpbi4lTmni8cdVaEKZ
 5Ixyyb38yOjC7F5QWA79ohgZaPl+82ys7Lc00OYZx18DvG83Ouc3FCaNqaE4pxeim4g6Ie0CML7
 fP2ddqIX/r7gRA5wiIXl6lOkacOw3kWhnW/ePRydVlKfIqmVoaNEzJtd8rK1VNyYfCn/3iIz4TZ
 Knrzw8nDZt/MjpGexeDf9em5CdvExy4ul4wYk6aEagoBXPAOSxBNxcL7ZlY5nCpTIC/b7Cr7QIr
 7iaNadZlc0T6zyyCpsNwn9kcqKOhVLOE9h3T7p/kVWa6x8/mU8cHWqJ4A5VlMzcdMglpFcn2z48
 U1o3jPc0HO3TP2lWsJslZFSH4obmC7v627SHY/AJe9Ot516DWQuzm+xzrbxLZlKnclwMWAhK25c
 sfcn8HoUWZ/DCQNWdrduQ1Ad+NW/p3W9TypUJo3zF+BS4=
X-Received: by 2002:a17:902:f70f:b0:2ca:1114:3ac8 with SMTP id
 d9443c01a7336-2ca449ab595mr6394575ad.11.1782807643296; 
 Tue, 30 Jun 2026 01:20:43 -0700 (PDT)
Received: from setun ([2401:4900:a344:dc6e:573c:3e9:c03e:731a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca4f2a71dbsm1284615ad.50.2026.06.30.01.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:20:42 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH v2 6/7] migration: add support for fault thread to load
 pages from disk
Date: Tue, 30 Jun 2026 13:49:39 +0530
Message-ID: <20260630081940.611092-7-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630081940.611092-1-aadeshveer07@gmail.com>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x635.google.com
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

Add postcopy-blocktime support by calling mark_postcopy_blocktime_begin
on every fault. We need to aqcuire the page_request_mutex lock and check
the recv bitmap to make sure we prevent a race condition when a fault
occurs but before the fault thread can mark the page for tracking the
eager thread loads in the page making us fail the assert for recv bitmap
being clear while marking in mark_postcopy_blocktime_begin().

Allocate another channel in postcopy_temp_pages_setup(like the preempt
case), for both the fault thread and eager thread to load pages
independently.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/postcopy-ram.c | 121 +++++++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 17 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 96a65aa976..be9edac572 100644
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
+        if (test_bit(page, rb->file_bmap)) {
+            /*
+             * This can happen concurrently, but it's thread-safe because
+             * qemu_get_buffer_at() is thread-safe, and the caller will be using
+             * different temporary buffers.
+             */
+            read = qemu_get_buffer_at(mis->from_src_file, place_source,
+                                      qemu_ram_pagesize(rb),
+                                      rb->pages_offset + rb_offset);
+
+            if (read != qemu_ram_pagesize(rb)) {
+                error_setg(errp, "Could not read page %zu from RAM Block %s",
+                           page, rb->idstr);
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
+
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
@@ -1279,6 +1341,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     int ret;
     size_t index;
     RAMBlock *rb = NULL;
+    Error *local_err = NULL;
 
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
@@ -1320,11 +1383,13 @@ static void *postcopy_ram_fault_thread(void *opaque)
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
@@ -1387,18 +1452,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset,
                                                 msg.arg.pagefault.feat.ptid);
+
+            if (migrate_mapped_ram()) {
+                /* Load page directly in case of fast snapshot load */
+                WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
+                    if (!ramblock_recv_bitmap_test(
+                            rb, (void *)msg.arg.pagefault.address)) {
+                        mark_postcopy_blocktime_begin(
+                            msg.arg.pagefault.address,
+                            msg.arg.pagefault.feat.ptid, rb);
+                    }
+                }
+                if (!postcopy_mapped_ram_load_page(
+                        mis, rb, rb_offset, msg.arg.pagefault.address,
+                        RAM_CHANNEL_POSTCOPY, &local_err)) {
+                    error_report_err(local_err);
+                    break;
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
 
@@ -1470,8 +1554,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
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
-- 
2.54.0


