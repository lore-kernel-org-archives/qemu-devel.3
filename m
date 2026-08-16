Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F80CC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvex0-0007nf-9V; Sun, 16 Aug 2026 13:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvewx-0007mY-2Y
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:11 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvewv-00036B-Ch
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2547463a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902428; x=1787507228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BMKDxNw1pwTZZvQp5o5+ArM6rOVEta7ek/RWxDFA3V8=;
 b=ri23xW4C8OwPXpdNsTitFxnsVFNBcXrqFtHa7fzghDo8hkS5Whz4mb1HU78xRxcziz
 uFzmp3KGYER77Mx7vfBlbzyG0KVlfrlMR5vROK/Om55WixiEk24wirXlKR0pHG0KF0Gm
 +8LjEHopK10k30giDjPwQXTG6EdnXjLUShhfT8HVH9lxxVMLkMyteS9oRABEuBJDBTeO
 zQTThaCuj4ScJADNgSmP7+6z6mPHP99hO71V3+2/f4MEb8skcCoQCU+JPVo+WR+NdrUq
 0PdciRj99GAFecbdkrKvfB8WXgDiir4Z4/4VAOV9is8ywbNcvNothyL6z6SnaBa5Pq9L
 ZEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902428; x=1787507228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BMKDxNw1pwTZZvQp5o5+ArM6rOVEta7ek/RWxDFA3V8=;
 b=HQIzqJP04Ei/rTebX15gGIKftSaDQLyR3EjLpuLE8nK0CuUh8LyWp1sU6NOtQ8VHFI
 ipg0HiaZJ76zUg0bwKMTBZk2PJrl1xT1t0UutPsp/0jZRi5s3bIeBxLUXtnt/NBYZuwY
 Q3rx72z+H33n8AIFtYanbs3m2P0zvOsWgFS0/L0JQaNdprZwio8kQN+fNDRCnAF0ABJv
 GNkyHOfcEa7Cvnty9HO03XBmr4iHQIYjhr9F7LvxaNTfVc5Lj7BxZOo+ybhuF9kRU+r8
 Afd8Ls8RVFafwqLrat8hxtlTsMSaoT8kWjBZIWqE168E+W95/KzvO/tFQA2FkzfhO/u+
 Lzgw==
X-Gm-Message-State: AOJu0YwaVOqo2S2zYIBLwRkLPBo6yjbSWI8uXZz479o8PJeg3c4S05JV
 op/jASIp+bXv+9v5EyZR+eOUvfxLYiuIA6SxLlYbj56LqrfgDs0g18VLXjoAkIML
X-Gm-Gg: AR+sD11w2Drmrtw/B1c5dIhCfzRkQ2E2JzGjFAoj+Fr+gCvQSw/woi1CKUf48d+hkxn
 WakVXBlrQRUSPjyLfkvtfET/9p2ZfIMyQdsvVwKMGqoJF8yrDuVtO+Mgc/Lmx+S57TJmoF5O3Y+
 iaRTwDbSxM+a5KEZXuXvagXb6XcrLnyqvnaT4KpsUPJwpYITn6jxIFwvR0LsxgK01pyE9RX5BOU
 T70agfFLa+XvfGZSpfiqe/qI0fhtTOxacW3SzUG+dQvH/Oyasyio1UZy6h0QbwvcEzNpIEjAl5j
 5sWoRmJKqSRthXcd1sKyA6prpbxDlShVNdP5ZjwPmqvtmL9+mVefyaEiPmiRbnHlw217Dq5fWn3
 99n2GK8FkYZL+QJu4cZrBq7ZW6ucx/jHr6CW0IWMMYtY97Wacz0fu+euO1xiaIOPJ3RQLvy+OCY
 J/2gUlHj1Yu7Fx70s2dwsKx71M93EDz1LeqEFNdAq5uA3MV2CSphsgQ/XtE8JEMsOJfVBvVHEwL
 AkA4yxphtxukjhwuT88TTk4ew==
X-Received: by 2002:a17:90b:53d0:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3933bcec7eemr19154145a91.17.1786902427835; 
 Sun, 16 Aug 2026 10:47:07 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:07 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v5 02/11] migration: Extract blocktime marking helper
Date: Sun, 16 Aug 2026 23:16:22 +0530
Message-ID: <20260816174631.1547811-3-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1033.google.com
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

Use new function try_mark_postcopy_blocktim_begin() to call
mark_postcopy_blocktime_begin if page was not received and return if it
actually marked it.

This will help in having a cleaner API to call
mark_postcopy_blocktime_begin as it requires the page to not be received
by asserting on it's existance in RAMBlock->receivedmap.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
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


