Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D7EC5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzbq-0001zc-NM; Fri, 31 Jul 2026 22:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbm-0001sd-Bj
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbk-0002Y5-5O
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cace91f112so17975885ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551871; x=1786156671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0OeYZjdGaY4S9lTtzE4pbuibV2LNEpD2FdO/1gBCT4=;
 b=aYHzxCIQdtmBFnQJ4K2clyaMAPe6PT/Nmhln8LG7PmOrxfN2h9BPlcJlUAHg7tOc9T
 QMeJDAju1ycDUphfeiEG8QfC49G+qHZzqmobb1IvqolE+mtFiI5C4T08oQv/9shYfnnS
 kA+BFJEZRpr7RmGQBKVM8mOnEyylsEbj47n5/xhD1ga2E0oQbs6uGsbaRW0EyMpIAPOm
 gjOkxrZuW33keLHefmVUvnOkLwUi5K/9l6Zw6KZRV94QyZpiua5E8vwJ7Zz6jWDnqE6g
 wKbPmL8emvV/yGt5wbgTT94YXn3cxGr1CTobp+1rxWna0+T8yhqnWqn87PEoHs1WZ1zd
 f/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551871; x=1786156671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0OeYZjdGaY4S9lTtzE4pbuibV2LNEpD2FdO/1gBCT4=;
 b=DLEyZgo7qGvgDxzFrBmwbaQcgj7uefcQ1JidpDzG1AE/7WqVat7r9E3T0DDEGQXaGF
 4jmXkR8CYx3cmpLVphBWDTqG4RXhxurnMBRrtsDu+cWud8t0mIKi/dbovwu1BidXbwxH
 YkpGHVrSCQZTqFmmUJrrr6ZEog14W4kZfp+g0bY49LWVoMkSuF/dvSWRQI/Y0zdgxTGJ
 KiH3hpbLkZhDnp2Dmx7FVSaLHdvWIv1vCZyFc4I93B3eHVODJYEcbqifz8kap8nnAM+y
 8va3UnAX4obv6gUBwZo3sU9TV0cErFrdyS+9Pr79G4njn1UZ+15ak4prU8/c+2iqIV1/
 PsZg==
X-Gm-Message-State: AOJu0Yw6o4uunaMetmi5qodlwmVkuZYGDyuDO9Kb+oIhog51Y/Jk1n6P
 oy7Yk7mN23VmtPWqDvEofSS+JvfQgWMHhkk2451wo5zsmYwDNhmvgoIChfjPRs2N
X-Gm-Gg: AR+sD13neOmFQk3SAawnLqUxtIazdHS5m6p/LY3wwD+HmXMNpRoAIw1O0SicXzJJuqd
 B8/xLMcD/HB7quNDlTh+a6mLFHWvJFMkl2NH8enqyaiQQmNXf6Mim1e9HenkZ7viNSSaMinJnYk
 gUlJzCJ3deLyoLTyw/zXmLmiz97MPjkOE4TQ3edIpT4dk6pIQkKYFPSgIp+KNwud8cCIeqWq1Ko
 0Y4kCMG6Crxxg+ijhToidsi0FHAuAcnpeU6/afcpTFzjyLeNJ3YHkWRF+bNvXrm5+J3FM7fjpMi
 /1+3xj0UrFV22wo7kDwbJQA8yUeqC7Pw+PMO8BftUmvml4nJm4t+kRk5Lyq0GuUOQ87PCSSDCSZ
 3HkGpzAhklUk+H3v88ar0/iv0QwkEe7T8RxDrcu+tHu6m4YSH/XetzeIZnVZHrEH/Fg1AS42gNT
 iSCToSu9nhT/H4FWCsg1UERQpCFOLdWtviBYNkRerhXgHkpcZCrBL8VCLri6KxkA5nifryU3uSv
 MCHQ8fPHW7txd2n
X-Received: by 2002:a05:6a20:ae24:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3c92a83880cmr1867325637.46.1785551870503; 
 Fri, 31 Jul 2026 19:37:50 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:49 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 07/11] migration: add support for fault thread to load
 pages from disk
Date: Sat,  1 Aug 2026 08:06:24 +0530
Message-ID: <20260801023628.22665-8-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x631.google.com
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
fault. It uses bitmap_test_and_clear_atomic() on pending_bmap to prevent
multiple threads from loading same page. It loads a page or pages
depending on size of guest pages and host pages, loading exactly the
larger of two. If the entire page is zero postcopy_place_page_zero() is
used for efficiency and in case some part is non zero it is part by part
loaded on loop using new function postcopy_mapped_ram_load_guest_page()
which loads a single guest page in a buffer which is then placed using
postcopy_place_page(). This covers all possible cases for various page
sizes of host and guest.

Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
instead of requesting source in case of fast snapshot load. to_src_file
check is bypassed in fast snapshot load case as there is no source.

Call try_mark_postcopy_blocktime_begin on every page fault to support
postcopy-blocktime.

Allocate another channel in postcopy_temp_pages_setup(like the preempt
case), for both the fault thread and eager thread to load pages
independently.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/postcopy-ram.c | 174 +++++++++++++++++++++++++++++++++++----
 1 file changed, 157 insertions(+), 17 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 2e2c9fae10..1da9c4309b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -949,6 +949,121 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                        pagesize);
 }
 
+/*
+ * Load a single guest page from source file into the buffer.
+ * NOTE: This is not an atomic operation and should not be used to directly load
+ * pages on page faults in postcopy. It is meant to fill in buffer that can then
+ * be copied into the faulting location using UFFDIO_COPY.
+ */
+static bool postcopy_mapped_ram_load_guest_page(MigrationIncomingState *mis,
+                                                RAMBlock *rb,
+                                                ram_addr_t rb_offset, void *buf,
+                                                Error **errp)
+{
+    ERRP_GUARD();
+    size_t page = rb_offset / qemu_target_page_size();
+    size_t read;
+
+    if (test_bit(page, rb->file_bmap)) {
+        /*
+         * This can happen concurrently, but it's thread-safe because
+         * qemu_get_buffer_at() is thread-safe, and the caller will be using
+         * different temporary buffers.
+         */
+        read =
+            qemu_get_buffer_at(mis->from_src_file, buf, qemu_target_page_size(),
+                               rb->pages_offset + rb_offset, errp);
+
+        if (read != qemu_target_page_size()) {
+            error_prepend(errp,
+                          "Could not read page %zu from RAM Block %s: ", page,
+                          rb->idstr);
+            return false;
+        }
+    } else {
+        memset(buf, '\0', qemu_target_page_size());
+    }
+    return true;
+}
+
+/**
+ * postcopy_mapped_ram_load_page() - Load pages required to access host address.
+ * @mis: Migration Incoming State.
+ * @rb: RAMBlock from where page is loaded.
+ * @rb_offset: Offset of target page in RAMBlock.
+ * @haddr: Base of target page where to load in page.
+ * @channel: Used to identify between threads and use corresponding temp.
+ * @errp: Set error in case of failure
+ *
+ * Load page(s) from RAMBlock covering the faulting address. We might need to
+ * load multiple pages in the case when host page size is greater than guest
+ * page size. As userfaultfd works on granularity of host pages, we might need
+ * to load guest pages in single operation.
+ *
+ * Return: True on success.
+ */
+static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
+                                          RAMBlock *rb, ram_addr_t rb_offset,
+                                          uint64_t haddr, int channel,
+                                          Error **errp)
+{
+    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
+    char *buffer_ptr = (char *)place_source;
+    size_t guest_pages_to_load =
+        MAX(1, qemu_ram_pagesize(rb) / qemu_target_page_size());
+    size_t host_page;
+    size_t page;
+
+    /*
+     * If guest page size is greater than host page size uffd needs to load one
+     * guest page and multiple host pages, hence the offsets need to aligned
+     * with guest pages (which is automatically aligned with host pages). In the
+     * same case we need to check range of bits on pending_bmap(bit per host
+     * page) to decide whether all the page have been loaded
+     */
+    rb_offset = ROUND_DOWN(rb_offset, qemu_target_page_size());
+    haddr = ROUND_DOWN(haddr, qemu_target_page_size());
+    host_page = rb_offset / qemu_ram_pagesize(rb);
+    page = rb_offset >> qemu_target_page_bits();
+
+    if (bitmap_test_and_clear_atomic(
+            rb->pending_bmap, host_page,
+            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))) {
+        if (find_next_bit(rb->file_bmap, page + guest_pages_to_load, page) ==
+            page + guest_pages_to_load) {
+            /* It is efficient to use UFFDIO_ZERO if all pages are zero */
+            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
+                error_setg(errp,
+                           "Failed to place zero page %zu from RAM Block %s at "
+                           "address %" PRIu64,
+                           page, rb->idstr, haddr);
+                return false;
+            }
+        } else {
+            size_t load_size = guest_pages_to_load * qemu_target_page_size();
+            size_t offset;
+
+            for (offset = 0; offset < load_size;
+                 offset += qemu_target_page_size()) {
+                if (!postcopy_mapped_ram_load_guest_page(
+                        mis, rb, rb_offset + offset, buffer_ptr + offset,
+                        errp)) {
+                    return false;
+                }
+            }
+
+            if (postcopy_place_page(mis, (void *)haddr, place_source, rb)) {
+                error_setg(errp,
+                           "Failed to place page %zu from RAM Block %s at "
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
@@ -1310,6 +1425,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     int ret;
     size_t index;
     RAMBlock *rb = NULL;
+    Error *local_err = NULL;
 
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
@@ -1351,11 +1467,13 @@ static void *postcopy_ram_fault_thread(void *opaque)
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
@@ -1418,18 +1536,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
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
 
@@ -1501,8 +1638,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
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
2.55.0


