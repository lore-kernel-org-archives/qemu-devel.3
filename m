Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F687C5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzbS-00019a-BH; Fri, 31 Jul 2026 22:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbN-000171-ST
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:29 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbM-0002Vt-5Y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:29 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2049301a91.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551846; x=1786156646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KiCgApDtw4yhcRGeRuFEJPughcuv9uFM9kRTnY1jClY=;
 b=Q36TqpYLGjbM6P5W5cMU+vv9MlwrSX8g5yUfhEqnBt9LJ2Dn/Y4x5hL7HSAplkZoxg
 CeSV/17jCKoIhVIh+L01L4/y/y0PIxILC9tvCzHxkzil2wvhLsVRCFckRPiq1g8dQKxq
 Ff5+VOPuFxtPhxhj3Wbv+KSyArjL3mqVxhM4Ww7TJAuPCvxepfT4g1NC7Xy7eKMZo82+
 AVrWJY/SFYmBZJkG4b6ED40lBLAsJQf1bOwNO261QKIEWyCCYrMrwTTCAFCD05fS+nDU
 p0ywUNy7ehkusDeQuV/YoCCkVJrJwK00OHInpcFcOn2d8ChdPH4+qLB+tjVafzofZhp2
 N3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551846; x=1786156646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KiCgApDtw4yhcRGeRuFEJPughcuv9uFM9kRTnY1jClY=;
 b=deeiF/MMZJAQ8oT0LuXzlKCxgLUm5D3v8PJztEDPxYEoAy4hQvdwcn+qCZJThCf9uh
 gsFEYoIUtA7UOcFwrjPKSvWy9uJtnvmx+1mkeOYr+UW7RFMABBoZOyc2FhoO/SLmxj6x
 N6RU2gQHtnjkNAmQIdjnBdBbYC201DePcBapOKZ0hTGwAaorqMOUJALa13kikL3YF2D9
 54PUSUI/AHJYfFzkwYHtSRWR8W0MsIdewDLYZ+sx7H6/dACh4VEDBFo8mPd5+7EWniiJ
 lV5+TNyLGsl1N7B6+yntXn6bEwFEb7RAJDtqN4r1iZejfzTr3wWecvWBePyQZ1aPFn6Z
 Nslw==
X-Gm-Message-State: AOJu0YzDV9YUBx3Fhd/5ihr45ERXvC4okpxiYPdY0YvGGdNZxW/yVn+u
 N+dCKZCo6DlL88bNiMrxSE6moeHz+Dd2iaQR6ssLhY16VBgrLx+XU8gX5RKjbn85
X-Gm-Gg: AR+sD10gYf3p5z0HVAJAGKBE9/mW414nZUpPRX4KimYoGpIGSyciC0CWF38lolbbcZS
 N+/lItPW7Dt7mS+LuFxI9s1le9xOyymBY83OolvhpTliieDRaL4Zz8bF0ly9ltp4C6TtKPgP5Ik
 YJbd7zseAP/GMb53SQyBrAA0b52MY0cpYoiJsfkDTIkXgNZu68HUZut26ZxFvROi75T9fgFwirV
 I2DOQQhuxLyJiRBZzmReDF5C1M7UW3ApsmTI/SBbzk29FmEFU8hye3BqbB0KG+pVDvPpmBIWpAz
 EuP+hATLuFSUxCfRPCJwyFgXWVT4famuooSSTzzViXLe2j/eppquVwvMP6AN4xk9/ATQyJ9bjeo
 hvnFWCDLvS16ZmeH0JwQxOMYJHpFi8HtgIhqBvVkOnbPsiag4Exa4h773V6YflrQGkt7mUA05A4
 S6n1QTzNWgsF0tBmSxzCssq79R23iWGg6SmZBKp9MsIbFZm4V0S6HID6/wmKBm8llsKowYRns/+
 NQQseJJCbPf9DeYljWj3euGJEE=
X-Received: by 2002:a17:90b:4985:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-38fbc44465emr2110308a91.15.1785551846484; 
 Fri, 31 Jul 2026 19:37:26 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:25 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 02/11] migration: Extract blocktime marking helper
Date: Sat,  1 Aug 2026 08:06:19 +0530
Message-ID: <20260801023628.22665-3-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102f.google.com
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


