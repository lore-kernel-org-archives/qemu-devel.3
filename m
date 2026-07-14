Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE4EC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwJ-00065x-L9; Tue, 14 Jul 2026 10:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwH-00065M-BQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:49 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwF-0002WT-GE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:49 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1261322a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038606; x=1784643406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ohUxk5Yj8cqgknphQ2n4dasqiuWoigzJbQ6j1A5+s0=;
 b=OIRfGR+MZ6VoXo+hoYdU52OTy0sccbJFDwb2gQUQio0eWiv0wD/OnKD6qv2ggynZDQ
 /dyYTLufsNviyzy1u2XwR09rG/qLlFWIEfNQECtdJhnSt8g+4SyWqMlQLj1hcBk6oa87
 dxLedWNaaR+jf56852DSxFzl0cd8JsJyAOOETzkkXzpP22M1pD8owuCjGuEti4jFpkTH
 4wORjQ0Skk/ayTY/Utb6RtqSEmAsnZLy/1tiyTYiS93KUP3IAM1UiZiA1DXx4KlJeO+m
 hqRo/Ar7XSSpe9HRR1T+CyoeKZzDWkiGG6wOTDWOddpWCbvre7t+Hr5npFmypes2Tx69
 vGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038606; x=1784643406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ohUxk5Yj8cqgknphQ2n4dasqiuWoigzJbQ6j1A5+s0=;
 b=aCyapBHMXDHJf2if6ZrDxe/nALtVVeTdyKiv0/PRKd6iRc3OM3HuiycTEA0KcWgjhq
 8yWtQAEn5HrGXI3xo0cvTy62Wi25E6bA5mmWdgGB+g/E6MJDM87rNtUw6aKjvm5wNZ+n
 vF+SZOwVqsPJnryfrui6S/FZGWuJHYh9C01Zm1h+YNuqMFD4iHD8h/T4wACkClILT60a
 TgUR1UIuTYgDbVRQCvgRw3c1zC+2WEy83RfoUIAt7OzLBXELAh2HZhvluc6qFEUxtgnK
 Wz5GeeZpGmK2CeEh3pYBnhTvOLv4DY85ARmWmjVxgOLWHBMR9/2+3HSwxDzU0h/fV+KU
 n3DQ==
X-Gm-Message-State: AOJu0YxZ/FdGBYfX3zQAX7zfDqz2grFYmv9M1b/0jddnVwFiG5EJ9Hdl
 zgT9YCzvh/5eg93OyBv92PzATz4iWtSXGYiBesvomQLcW80vawCHD/6mmAKheyo6
X-Gm-Gg: AfdE7ckFQOC9GyYzngGzvoSDsDBtLXOcNcrgPnKTAuyhg0Vd9+2roDdHn5dlykb0new
 7ZHOL3MZn0mKpbDVIARuWJZZbvJZYwSCBCzLH08IvDs5Mkxn6IXPr3q3iqNLTeeB49jvbB2wCgO
 ZPKUf74ckikOqiiEmAcEnHqLy8UtzBspfyf2xFHk2KkkxtqOgh4zgg7TWYl/zjSXcYOAYyJQOGy
 eqDHf02WxmKUzhPDcaAnDy5sgcY/1xkblXZJYL5zC1BX6E6nNg9juMJPSZKQyOI4xsE4d6NYPG1
 OssCX2aTOhGnE/xJDRDTNAr0nTIhInux7nlNd4DrvDGgExGaY2Qy6AGhWsVYjRQOE4Kti9vQfBn
 Sb3Dz74GCF9rLfGRUfQivX2mC0OSzZZRAxg67kpPIamXgScWzTWpkLWS2H/TFkoiVIN0LYq8gdD
 2xPYT8GGPr3ttTneY0Bt48XEF3AEMV69t2rDGDXZdXsSUbmmxCDxuL
X-Received: by 2002:a17:90b:4f81:b0:387:e0db:3faa with SMTP id
 98e67ed59e1d1-38dc7775133mr12097600a91.35.1784038605961; 
 Tue, 14 Jul 2026 07:16:45 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:16:45 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 02/11] migration: Extract blocktime marking helper
Date: Tue, 14 Jul 2026 19:45:38 +0530
Message-ID: <20260714141547.1268000-3-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1029.google.com
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

Use new function try_mark_postcopy_blocktime_begin() to call
mark_postcopy_blocktime_begin if page was not received and return if it
actually marked it.

This will help in having a cleaner API to call
mark_postcopy_blocktime_begin as it requires the page to not be received
by asserting on it's existance in RAMBlock->receivedmap.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/migration.c    | 24 ++----------------------
 migration/postcopy-ram.c | 31 +++++++++++++++++++++++++++++++
 migration/postcopy-ram.h |  3 +++
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..07394d8eea 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -577,32 +577,12 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
                               RAMBlock *rb, ram_addr_t start, uint64_t haddr,
                               uint32_t tid)
 {
-    void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
-    bool received = false;
-
-    WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
-        received = ramblock_recv_bitmap_test_byte_offset(rb, start);
-        if (!received) {
-            if (!g_tree_lookup(mis->page_requested, aligned)) {
-                /*
-                 * The page has not been received, and it's not yet in the
-                 * page request list.  Queue it.  Set the value of element
-                 * to 1, so that things like g_tree_lookup() will return
-                 * TRUE (1) when found.
-                 */
-                g_tree_insert(mis->page_requested, aligned, (gpointer)1);
-                qatomic_inc(&mis->page_requested_count);
-                trace_postcopy_page_req_add(aligned, mis->page_requested_count);
-            }
-            mark_postcopy_blocktime_begin(haddr, tid, rb);
-        }
-    }
-
     /*
+     * If not able to mark page for blocktime it must already be present.
      * If the page is there, skip sending the message.  We don't even need the
      * lock because as long as the page arrived, it'll be there forever.
      */
-    if (received) {
+    if (!try_mark_postcopy_blocktime_begin(mis, rb, start, haddr, tid)) {
         return 0;
     }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 96a65aa976..4b8f882e1e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1057,6 +1057,37 @@ static void blocktime_fault_inject(PostcopyBlocktimeContext *ctx,
     trace_postcopy_blocktime_begin(addr, time, cpu, !!head);
 }
 
+/*
+ * Take @page_request_mutex and try marking postcopy blocktime begin.
+ * Return true if marking is successful and false if page alredy exists.
+ */
+bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
+                                       RAMBlock *rb, ram_addr_t start,
+                                       uint64_t haddr, uint32_t tid)
+{
+    bool received = false;
+    void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
+
+    WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
+        received = ramblock_recv_bitmap_test_byte_offset(rb, start);
+        if (!received) {
+            if (!g_tree_lookup(mis->page_requested, aligned)) {
+                /*
+                 * The page has not been received, and it's not yet in the
+                 * page request list.  Queue it.  Set the value of element
+                 * to 1, so that things like g_tree_lookup() will return
+                 * TRUE (1) when found.
+                 */
+                g_tree_insert(mis->page_requested, aligned, (gpointer)1);
+                qatomic_inc(&mis->page_requested_count);
+                trace_postcopy_page_req_add(aligned, mis->page_requested_count);
+            }
+            mark_postcopy_blocktime_begin((uint64_t)aligned, tid, rb);
+        }
+    }
+    return !received;
+}
+
 /*
  * This function is being called when pagefault occurs. It tracks down vCPU
  * blocking time.  It's protected by @page_request_mutex.
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 98d918713f..ea879f0bc6 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -196,6 +196,9 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
 void postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
 bool postcopy_is_paused(MigrationStatus status);
+bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
+                                       RAMBlock *rb, ram_addr_t start,
+                                       uint64_t haddr, uint32_t tid);
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb);
 
-- 
2.55.0


