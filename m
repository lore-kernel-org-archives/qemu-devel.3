Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7A2CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3JY-000895-KY; Wed, 17 Jun 2026 23:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3JW-00088H-TI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3JV-0002GC-4T
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:10 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c858961a8efso199206a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 20:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781752868; x=1782357668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIe6BJESqe4Ygko+qukm5nUWAzH4BOCtOFcveqmu/ag=;
 b=JUyDhlEGygep7mGcb57H+aABTxiro4lmDAHg3n1AJdgVK40lJUoLyzJhGrnGB+JEoO
 tamaXQyFqgtjO69qUoJHPWx4cxBW5XBiyYaxXEymUkTXJB2t1pcuFEQJAdAJUxze/Zg4
 8C5kavUSS2r0ajyVtvfVqiIjy+m949JcbASceFNp4Hn0pTCWzr0uGxh5VKJMtiI2821F
 lEu/P4cebjwlQF+FRo0QRX+IL4lznVBi2zPa4co25/o/+ddJsn2mLMXvP4EFLYUPHVnA
 fDgCpXQDfjp71lmuN9aOnh/85+fi3NNiFAhUwuyE6egTC5zvk7iGZ18aM9dMvACrGS0e
 OGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781752868; x=1782357668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IIe6BJESqe4Ygko+qukm5nUWAzH4BOCtOFcveqmu/ag=;
 b=m6z9dQvCBAOEVlVcn2zA89raPg5NqTtQMKL119poNraV8Q7VQfMsnO06yoE3y2qyoK
 YQIJS7+SYP9kZn/lssp554YRXBdzM/ALiIPOm1FNw3FV3Cg22Kf0xQCZzFMl1koRwsxm
 hksYiczdXeuT9zYDDSZdPQLVwfnFolIoJrTjk1Y3ww+bseZFexXIhTuEOTkC+55xl3bW
 4D645iQvpF2iblb8tx3YohQM9U5sjJ9D+xgNfFlYPUafdAZowzKqopjr/OqeMWmregCM
 0tekep46+IC9n1oudhHdE/Ean+8iikRcDsgrUfWOjVWIlHAGDesyiaZ0vhMcvU1QGHgm
 Ew1w==
X-Gm-Message-State: AOJu0Ywh2+P6vDup1k1qmE1JUaUrytxZJDXS6Xl5x4TVGVtq7Jn0Hhcv
 2IjjPNenx1ICR6rHjo7/UIsTDt7VO2546FJmzWdhk6Q2VoZu0FnOZJIP0GEMZ6KN
X-Gm-Gg: Acq92OGvAXfW4EmfiDVbmiUshQ+nLVzSQz2RMLBEIjuPm5ewul+v0Y3bDvXIZWB2UJw
 QAeQMk3sMjd9yYva7hZ2RXAGqjtTfhva7zqf/w6mtiIVBLYUFOgFQyN61j82Ve2Opf4mCquxeT7
 B21kILoA4Oxkqz2hAjPoOPBLDr9j8TSVAySCsYusgdJWZrGHpM+l3Yhz6cuiZ2+9v+zzn85riNX
 MLPSbJKjiynmgwYH3tt/n6yaMPgtET/G5zsQQKZ9hjjdsgPcjc8fIMJCO6HhVMPsBcRbu3CCOod
 WwTtaaaaZVmLgqYGjRd1fkdizbwpdW2LdO1A6AKF7tv6sTb2yN02j8l5DECWhMMiSFRGRj9xvV7
 s6n9vp9k45KE9xilbR2f5CZGYGGOV5JlB6FJlOrCG+B8thzizQWDBj+NdVBP/DxzkwhFa3eZ9iq
 aRcbNuyMVmqzQTEGA5tz4mYN0bRCg9Y5L+PdYZp1LMQw==
X-Received: by 2002:a05:6a20:d508:b0:3b4:6265:3786 with SMTP id
 adf61e73a8af0-3b8b80f48d2mr7214494637.43.1781752867484; 
 Wed, 17 Jun 2026 20:21:07 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c88c6c2b2easm1534623a12.27.2026.06.17.20.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 20:21:06 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH 2/5] migration: add support for fault thread to load pages
 from disk
Date: Thu, 18 Jun 2026 08:50:07 +0530
Message-ID: <20260618032010.88755-3-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618032010.88755-1-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52d.google.com
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
check is bypassed in fast snapshot load case as there is no source

Allocate another channel in postcopy_temp_pages_setup(like the preempt
case), for both the fault thread and eager thread to load pages
independently.

In case of failure to read required page crash the system using assert
as disk failure is critical and VM cannot be recovered.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/postcopy-ram.c | 92 ++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 17 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f5ef93f193..1ec20a07dd 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -949,6 +949,53 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                        pagesize);
 }
 
+/*
+ * Load a page from RAMBlock at offset at given host address.
+ * Used by postcopy ram fault thread and eager thread in fast snapshot load
+ * case. rb_offset: Offset of page in RAMBlock haddr: Base of page where to load
+ * in page Channel: Used to identify between threads and use corresponding temp
+ * pages Returns 0 on success
+ */
+static int postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
+                                         RAMBlock *rb, ram_addr_t rb_offset,
+                                         uint64_t haddr, int channel)
+{
+    int ret = 0;
+    unsigned long page;
+    void *host = (void *)haddr;
+    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
+    size_t read;
+
+    page = rb_offset >> TARGET_PAGE_BITS;
+
+    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
+        if (test_bit(page, rb->nonzeropages)) {
+            /*
+             * qemu_get_buffer_at uses preadv which is thread safe we do not
+             * need different channels
+             */
+            read = qemu_get_buffer_at(mis->from_src_file, place_source,
+                                      TARGET_PAGE_SIZE,
+                                      rb->pages_offset + rb_offset);
+
+            g_assert(read == TARGET_PAGE_SIZE);
+
+            ret = postcopy_place_page(mis, host, place_source, rb);
+            if (ret) {
+                return ret;
+            }
+
+        } else {
+            /* zero page */
+            ret = postcopy_place_page_zero(mis, host, rb);
+            if (ret) {
+                return ret;
+            }
+        }
+    }
+    return ret;
+}
+
 /*
  * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
  * also optional: when zero is provided, the fault accounting will be ignored.
@@ -1320,11 +1367,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
             break;
         }
 
-        if (!mis->to_src_file) {
+        if (!migrate_fast_snapshot_load() && !mis->to_src_file) {
             /*
-             * Possibly someone tells us that the return path is
-             * broken already using the event. We should hold until
-             * the channel is rebuilt.
+             * Fast snapshot load has no to src file or in other case someone
+             * possibly tells us that the return path is broken already using
+             * the event. We should hold until the channel is rebuilt.
              */
             postcopy_pause_fault_thread(mis);
         }
@@ -1387,18 +1434,26 @@ static void *postcopy_ram_fault_thread(void *opaque)
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset,
                                                 msg.arg.pagefault.feat.ptid);
+
+            if (migrate_fast_snapshot_load()) {
+                if (postcopy_mapped_ram_load_page(
+                        mis, rb, rb_offset, msg.arg.pagefault.address, 1)) {
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
 
@@ -1471,8 +1526,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
     unsigned i, channels;
     void *temp_page;
 
-    if (migrate_postcopy_preempt()) {
-        /* If preemption enabled, need extra channel for urgent requests */
+    if (migrate_postcopy_preempt() || migrate_fast_snapshot_load()) {
+        /*
+         * If preemption enabled or it is fast snapshot load, need extra channel
+         * for urgent requests/faults
+         */
         mis->postcopy_channels = RAM_CHANNEL_MAX;
     } else {
         /* Both precopy/postcopy on the same channel */
-- 
2.54.0


