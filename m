Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1781C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUjt-0006CS-9D; Tue, 06 Feb 2024 18:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjr-0006Bx-Tn
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:27 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjk-0005mP-Qo
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:27 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-46d3b3e0671so594295137.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707261617; x=1707866417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leJ95zOxaZBV0dR1eA9xS1nffMJu6UFCj/XCjWoCKsQ=;
 b=JFsKLcQRGb1RpTfnJ3rShMCcw1csajRjY4TPGfaVmJgaQmtGylulC8odKUiHv/g0Ex
 z6N05cM2j1SSixnUv8uyv3D+HX8emJo6QQpJxG19ypjELCKU6Kly9TPXTyAhRm+wefhW
 AT1nwBJhdYrPhvAVLdNd5DLfi9Ftv8NWcxTs2co3PggqMBNEK+8uQAPHcVkycGMuak1X
 VbrdkDyKfb0Zhxld+tlWG7i5AYlW7Y5Smk7V6tdIrEr3xfi/B04LcW4fHEDydMQ5an1p
 JfOpxFFgMHytw/1cnG8PWxi0QVc4VJwx3TROl4aYbocHPin40TSPm4cuqqglMbRYxNXJ
 FlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261617; x=1707866417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leJ95zOxaZBV0dR1eA9xS1nffMJu6UFCj/XCjWoCKsQ=;
 b=mTyMcgbKCCndZmXWa1WxVavlDWaNC+2GQ/c8XCaBlMyZg4LhMHm/ikqqVHWzjd6B5c
 UXeWxEoXSWat1NnJ7a4BbE0UeGN60d+dIAFqHRHx+hGyrx/VZm8yyzCc4Oa0UK/9196M
 42mj+57EfUc1+a0sQtWs6ZhGVcpZA2Zz2VT9UA0g8SCOpoFNSJmRsli+R0NLDKlPgZog
 z7JoePLf5WAkVNXDpX8usg02Jj/SjI+y0me9rKg8FnBgru2X0mLczPa1MUmF+xp0e/mL
 +1o8ja+SAaRNXJMuSOYDQGJYg0sA6D2zYdPvY+MtH9vcoSfMaxcB5JSdczCQOfCq/rwP
 vYEA==
X-Gm-Message-State: AOJu0YyW45U4yhNi68L+1PK93YzJme+uBXBqJ5Fo+1A6jsDGSB21zz5F
 SSR1zxFD715c+CB0ppYJiJIzslkaeoODUKOL9QpMrNgJQjVqRVl5nI0Covf8+URunalJjH/O7sQ
 XxLo=
X-Google-Smtp-Source: AGHT+IEP1+8U0KedU2ehuuQBQhmBQyACXw8o+IFCofqxVbAMWadc7ZCtzV6sNtW5k5wB2HzEBE+9eQ==
X-Received: by 2002:a05:6102:408:b0:46c:f977:4f9f with SMTP id
 d8-20020a056102040800b0046cf9774f9fmr999583vsq.0.1707261617743; 
 Tue, 06 Feb 2024 15:20:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVYOK1ZYEhlaL+Zu4x9ak6NOXgumqrLo5h2thw1yEh09d+ogGEKZ2NvllIctKVNqGdyT2pjtqyIugtZwYpLB34Wf++JWqYP95cubUFO/6kZ0hXa
Received: from n231-230-216.byted.org ([130.44.215.112])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a67b60b000000b0046d20ce8886sm2352vsm.1.2024.02.06.15.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 15:20:17 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 4/6] migration/multifd: Zero page transmission on the multifd
 thread.
Date: Tue,  6 Feb 2024 23:19:06 +0000
Message-Id: <20240206231908.1792529-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240206231908.1792529-1-hao.xiang@bytedance.com>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This implements the zero page detection and handling on the multifd
threads.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/multifd.c | 62 +++++++++++++++++++++++++++++++++++++++++----
 migration/multifd.h |  5 ++++
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a20d0ed10e..c031f947c7 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
@@ -278,6 +279,12 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
 
         packet->offset[i] = cpu_to_be64(temp);
     }
+    for (i = 0; i < p->zero_num; i++) {
+        /* there are architectures where ram_addr_t is 32 bit */
+        uint64_t temp = p->zero[i];
+
+        packet->offset[p->normal_num + i] = cpu_to_be64(temp);
+    }
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -360,6 +367,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
         p->normal[i] = offset;
     }
 
+    for (i = 0; i < p->zero_num; i++) {
+        uint64_t offset = be64_to_cpu(packet->offset[p->normal_num + i]);
+
+        if (offset > (p->block->used_length - p->page_size)) {
+            error_setg(errp, "multifd: offset too long %" PRIu64
+                       " (max " RAM_ADDR_FMT ")",
+                       offset, p->block->used_length);
+            return -1;
+        }
+        p->zero[i] = offset;
+    }
+
     return 0;
 }
 
@@ -658,13 +677,37 @@ int multifd_send_sync_main(void)
     return 0;
 }
 
+static void zero_page_check_send(MultiFDSendParams *p)
+{
+    /*
+     * QEMU older than 9.0 don't understand zero page
+     * on multifd channel. This switch is required to
+     * maintain backward compatibility.
+     */
+    bool use_multifd_zero_page = migrate_multifd_zero_page();
+    RAMBlock *rb = p->pages->block;
+
+    for (int i = 0; i < p->pages->num; i++) {
+        uint64_t offset = p->pages->offset[i];
+        if (use_multifd_zero_page &&
+            buffer_is_zero(rb->host + offset, p->page_size)) {
+            p->zero[p->zero_num] = offset;
+            p->zero_num++;
+            ram_release_page(rb->idstr, offset);
+        } else {
+            p->normal[p->normal_num] = offset;
+            p->normal_num++;
+        }
+    }
+}
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
-    int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
+    int ret = 0;
 
     thread = migration_threads_add(p->name, qemu_get_thread_id());
 
@@ -699,10 +742,7 @@ static void *multifd_send_thread(void *opaque)
                 p->iovs_num = 1;
             }
 
-            for (int i = 0; i < p->pages->num; i++) {
-                p->normal[p->normal_num] = p->pages->offset[i];
-                p->normal_num++;
-            }
+            zero_page_check_send(p);
 
             if (p->normal_num) {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
@@ -1107,6 +1147,16 @@ void multifd_recv_sync_main(void)
     trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
 }
 
+static void zero_page_check_recv(MultiFDRecvParams *p)
+{
+    for (int i = 0; i < p->zero_num; i++) {
+        void *page = p->host + p->zero[i];
+        if (!buffer_is_zero(page, p->page_size)) {
+            memset(page, 0, p->page_size);
+        }
+    }
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
@@ -1153,6 +1203,8 @@ static void *multifd_recv_thread(void *opaque)
             }
         }
 
+        zero_page_check_recv(p);
+
         if (flags & MULTIFD_FLAG_SYNC) {
             qemu_sem_post(&multifd_recv_state->sem_sync);
             qemu_sem_wait(&p->sem_sync);
diff --git a/migration/multifd.h b/migration/multifd.h
index 6be9b2f6c1..7448cb1aa9 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -53,6 +53,11 @@ typedef struct {
     uint32_t unused32[1];    /* Reserved for future use */
     uint64_t unused64[3];    /* Reserved for future use */
     char ramblock[256];
+    /*
+     * This array contains the pointers to:
+     *  - normal pages (initial normal_pages entries)
+     *  - zero pages (following zero_pages entries)
+     */
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
 
-- 
2.30.2


