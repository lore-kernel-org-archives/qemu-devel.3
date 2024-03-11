Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7265C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnir-00040p-MO; Mon, 11 Mar 2024 18:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnhL-0001Hf-4U
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngy-0004IY-F5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNxPnbmMbEaICpUmDjWhNLqH4j4k4F7CKv7EwFIQJbk=;
 b=FkYGudp3ttD/nQObjdGnn9CfNZGvo6GmQARbFY+9L17SmQGVtEmVuBC3WIzOS+R2sLtucD
 +wKjej4A2xbd0gJ2p6Fi2RZ+wlIs1p1QKWelZTyCV98fKLCQPaONE584WCfm8F8hdg85Fz
 T5rXqEgmqye4heLvzowbGaA+CAxrkpk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-g1HNb6wwMjCiMhc0d4yEBg-1; Mon, 11 Mar 2024 18:00:16 -0400
X-MC-Unique: g1HNb6wwMjCiMhc0d4yEBg-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6dde25ac92fso2724514a34.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194414; x=1710799214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNxPnbmMbEaICpUmDjWhNLqH4j4k4F7CKv7EwFIQJbk=;
 b=vPgV9v1nWuptUAk8Cygz6hDtyx5j6S8cmRnYfFbolrWbCwqKcYcP+AZLO36ULfd2M8
 CejyD1BNrO/0IhOZ85Q6O9MUKKa/JNnlw7sKcU+AfwIShgcjmXtSS92ACVCeYFzPj4KW
 jookLtOxjkVHCpHWOzVXPxLaAxQ22KDaqE7WenANfrXmni5pjozBIhQ1DlPWFtHkGF+v
 HMp6duO5lCuJ8j/8Vhu0q7+UA8AgZks2ilSjLrVPz9DSSLX+hrkxFb2FFCv8Bxo7TnH6
 oxfqHBTmin+yR4d9JQFGXyXSI9dbINpHdRzGBms3ftqoiDmiHvSIVv3nLyJfFxMEAMok
 +SCw==
X-Gm-Message-State: AOJu0Yww4pvB1wi62L7OsJoPem+J+1LtUxvnonEnfUN7tnw53AAcEq7h
 fvpB4PnNMb+Hfo3Ilo23HIHkE8oga6xQWMPaYN0Q586ItaT6upWziIvDWugvVYxy4YZ5TNV4ykT
 xDNJYT7gzQDbh+/xXQSOuQbBBWMSuWTDBgQNXsu2Mye0bV8CrnjjdBDO/bX4sdWfNk5CJgKMVhC
 IVCz+a0wpn+1r10+3JVgLU2Zuae4BJtGLXlA==
X-Received: by 2002:a05:6808:20a7:b0:3c1:e136:133f with SMTP id
 s39-20020a05680820a700b003c1e136133fmr9258712oiw.2.1710194414045; 
 Mon, 11 Mar 2024 15:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERM2B1Ty0SdR0wz/fJhQKRx7EPNmUoJxN6A4CCxSRyfTO2nGJpi3LU5hYUmDYE8X+3wIi3ew==
X-Received: by 2002:a05:6808:20a7:b0:3c1:e136:133f with SMTP id
 s39-20020a05680820a700b003c1e136133fmr9258666oiw.2.1710194413452; 
 Mon, 11 Mar 2024 15:00:13 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:12 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 31/34] migration/multifd: Implement zero page transmission on
 the multifd thread.
Date: Mon, 11 Mar 2024 17:59:22 -0400
Message-ID: <20240311215925.40618-32-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hao Xiang <hao.xiang@bytedance.com>

1. Add zero_pages field in MultiFDPacket_t.
2. Implements the zero page detection and handling on the multifd
threads for non-compression, zlib and zstd compression backends.
3. Added a new value 'multifd' in ZeroPageDetection enumeration.
4. Adds zero page counters and updates multifd send/receive tracing
format to track the newly added counters.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240311180015.3359271-5-hao.xiang@linux.dev
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json              |  7 ++-
 migration/multifd.h              | 23 +++++++-
 hw/core/qdev-properties-system.c |  2 +-
 migration/multifd-zero-page.c    | 87 ++++++++++++++++++++++++++++++
 migration/multifd-zlib.c         | 21 ++++++--
 migration/multifd-zstd.c         | 20 +++++--
 migration/multifd.c              | 90 +++++++++++++++++++++++++++-----
 migration/ram.c                  |  1 -
 migration/meson.build            |  1 +
 migration/trace-events           |  8 +--
 10 files changed, 228 insertions(+), 32 deletions(-)
 create mode 100644 migration/multifd-zero-page.c

diff --git a/qapi/migration.json b/qapi/migration.json
index 83fdef73b9..2684e4e9ac 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -677,10 +677,15 @@
 #
 # @legacy: Perform zero page checking in main migration thread.
 #
+# @multifd: Perform zero page checking in multifd sender thread if
+#     multifd migration is enabled, else in the main migration
+#     thread as for @legacy.
+#
 # Since: 9.0
+#
 ##
 { 'enum': 'ZeroPageDetection',
-  'data': [ 'none', 'legacy' ] }
+  'data': [ 'none', 'legacy', 'multifd' ] }
 
 ##
 # @BitmapMigrationBitmapAliasTransform:
diff --git a/migration/multifd.h b/migration/multifd.h
index 7447c2bea3..c9d9b09239 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -55,14 +55,24 @@ typedef struct {
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     uint64_t packet_num;
-    uint64_t unused[4];    /* Reserved for future use */
+    /* zero pages */
+    uint32_t zero_pages;
+    uint32_t unused32[1];    /* Reserved for future use */
+    uint64_t unused64[3];    /* Reserved for future use */
     char ramblock[256];
+    /*
+     * This array contains the pointers to:
+     *  - normal pages (initial normal_pages entries)
+     *  - zero pages (following zero_pages entries)
+     */
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
 
 typedef struct {
     /* number of used pages */
     uint32_t num;
+    /* number of normal pages */
+    uint32_t normal_num;
     /* number of allocated pages */
     uint32_t allocated;
     /* offset of each page */
@@ -136,6 +146,8 @@ typedef struct {
     uint64_t packets_sent;
     /* non zero pages sent through this channel */
     uint64_t total_normal_pages;
+    /* zero pages sent through this channel */
+    uint64_t total_zero_pages;
     /* buffers to send */
     struct iovec *iov;
     /* number of iovs used */
@@ -194,12 +206,18 @@ typedef struct {
     uint8_t *host;
     /* non zero pages recv through this channel */
     uint64_t total_normal_pages;
+    /* zero pages recv through this channel */
+    uint64_t total_zero_pages;
     /* buffers to recv */
     struct iovec *iov;
     /* Pages that are not zero */
     ram_addr_t *normal;
     /* num of non zero pages */
     uint32_t normal_num;
+    /* Pages that are zero */
+    ram_addr_t *zero;
+    /* num of zero pages */
+    uint32_t zero_num;
     /* used for de-compression methods */
     void *compress_data;
 } MultiFDRecvParams;
@@ -221,6 +239,9 @@ typedef struct {
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
 void multifd_send_fill_packet(MultiFDSendParams *p);
+bool multifd_send_prepare_common(MultiFDSendParams *p);
+void multifd_send_zero_page_detect(MultiFDSendParams *p);
+void multifd_recv_zero_page_process(MultiFDRecvParams *p);
 
 static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 71a21bf24e..7eca2f2377 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -696,7 +696,7 @@ const PropertyInfo qdev_prop_granule_mode = {
 const PropertyInfo qdev_prop_zero_page_detection = {
     .name = "ZeroPageDetection",
     .description = "zero_page_detection values, "
-                   "none,legacy",
+                   "none,legacy,multifd",
     .enum_table = &ZeroPageDetection_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
new file mode 100644
index 0000000000..1ba38be636
--- /dev/null
+++ b/migration/multifd-zero-page.c
@@ -0,0 +1,87 @@
+/*
+ * Multifd zero page detection implementation.
+ *
+ * Copyright (c) 2024 Bytedance Inc
+ *
+ * Authors:
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "exec/ramblock.h"
+#include "migration.h"
+#include "multifd.h"
+#include "options.h"
+#include "ram.h"
+
+static bool multifd_zero_page_enabled(void)
+{
+    return migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD;
+}
+
+static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
+{
+    ram_addr_t temp;
+
+    if (a == b) {
+        return;
+    }
+
+    temp = pages_offset[a];
+    pages_offset[a] = pages_offset[b];
+    pages_offset[b] = temp;
+}
+
+/**
+ * multifd_send_zero_page_detect: Perform zero page detection on all pages.
+ *
+ * Sorts normal pages before zero pages in p->pages->offset and updates
+ * p->pages->normal_num.
+ *
+ * @param p A pointer to the send params.
+ */
+void multifd_send_zero_page_detect(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = p->pages;
+    RAMBlock *rb = pages->block;
+    int i = 0;
+    int j = pages->num - 1;
+
+    if (!multifd_zero_page_enabled()) {
+        pages->normal_num = pages->num;
+        return;
+    }
+
+    /*
+     * Sort the page offset array by moving all normal pages to
+     * the left and all zero pages to the right of the array.
+     */
+    while (i <= j) {
+        uint64_t offset = pages->offset[i];
+
+        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
+            i++;
+            continue;
+        }
+
+        swap_page_offset(pages->offset, i, j);
+        ram_release_page(rb->idstr, offset);
+        j--;
+    }
+
+    pages->normal_num = i;
+}
+
+void multifd_recv_zero_page_process(MultiFDRecvParams *p)
+{
+    for (int i = 0; i < p->zero_num; i++) {
+        void *page = p->host + p->zero[i];
+        if (!buffer_is_zero(page, p->page_size)) {
+            memset(page, 0, p->page_size);
+        }
+    }
+}
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 6120faad65..83c0374380 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -123,13 +123,15 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
-    multifd_send_prepare_header(p);
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
 
-    for (i = 0; i < pages->num; i++) {
+    for (i = 0; i < pages->normal_num; i++) {
         uint32_t available = z->zbuff_len - out_size;
         int flush = Z_NO_FLUSH;
 
-        if (i == pages->num - 1) {
+        if (i == pages->normal_num - 1) {
             flush = Z_SYNC_FLUSH;
         }
 
@@ -172,10 +174,10 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     p->iov[p->iovs_num].iov_len = out_size;
     p->iovs_num++;
     p->next_packet_size = out_size;
-    p->flags |= MULTIFD_FLAG_ZLIB;
 
+out:
+    p->flags |= MULTIFD_FLAG_ZLIB;
     multifd_send_fill_packet(p);
-
     return 0;
 }
 
@@ -261,6 +263,14 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_ZLIB);
         return -1;
     }
+
+    multifd_recv_zero_page_process(p);
+
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
     ret = qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
 
     if (ret != 0) {
@@ -310,6 +320,7 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
                    p->id, out_size, expected_size);
         return -1;
     }
+
     return 0;
 }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index cac236833d..02112255ad 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -118,16 +118,18 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
-    multifd_send_prepare_header(p);
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
 
     z->out.dst = z->zbuff;
     z->out.size = z->zbuff_len;
     z->out.pos = 0;
 
-    for (i = 0; i < pages->num; i++) {
+    for (i = 0; i < pages->normal_num; i++) {
         ZSTD_EndDirective flush = ZSTD_e_continue;
 
-        if (i == pages->num - 1) {
+        if (i == pages->normal_num - 1) {
             flush = ZSTD_e_flush;
         }
         z->in.src = p->pages->block->host + pages->offset[i];
@@ -161,10 +163,10 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     p->iov[p->iovs_num].iov_len = z->out.pos;
     p->iovs_num++;
     p->next_packet_size = z->out.pos;
-    p->flags |= MULTIFD_FLAG_ZSTD;
 
+out:
+    p->flags |= MULTIFD_FLAG_ZSTD;
     multifd_send_fill_packet(p);
-
     return 0;
 }
 
@@ -257,6 +259,14 @@ static int zstd_recv(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_ZSTD);
         return -1;
     }
+
+    multifd_recv_zero_page_process(p);
+
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
     ret = qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
 
     if (ret != 0) {
diff --git a/migration/multifd.c b/migration/multifd.c
index 3ba922694e..0179422f6d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
@@ -111,12 +112,17 @@ void multifd_send_channel_created(void)
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = p->pages;
+    uint32_t zero_num = p->pages->num - p->pages->normal_num;
 
     assert(pages->block);
 
-    for (int i = 0; i < p->pages->num; i++) {
+    for (int i = 0; i < p->pages->normal_num; i++) {
         ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
     }
+
+    for (int i = p->pages->num; i < zero_num; i++) {
+        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], false);
+    }
 }
 
 /* Multifd without compression */
@@ -153,13 +159,13 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = p->pages;
 
-    for (int i = 0; i < pages->num; i++) {
+    for (int i = 0; i < pages->normal_num; i++) {
         p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
         p->iov[p->iovs_num].iov_len = p->page_size;
         p->iovs_num++;
     }
 
-    p->next_packet_size = pages->num * p->page_size;
+    p->next_packet_size = pages->normal_num * p->page_size;
 }
 
 /**
@@ -178,6 +184,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
     bool use_zero_copy_send = migrate_zero_copy_send();
     int ret;
 
+    multifd_send_zero_page_detect(p);
+
     if (!multifd_use_packets()) {
         multifd_send_prepare_iovs(p);
         multifd_set_file_bitmap(p);
@@ -261,6 +269,13 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_NOCOMP);
         return -1;
     }
+
+    multifd_recv_zero_page_process(p);
+
+    if (!p->normal_num) {
+        return 0;
+    }
+
     for (int i = 0; i < p->normal_num; i++) {
         p->iov[i].iov_base = p->host + p->normal[i];
         p->iov[i].iov_len = p->page_size;
@@ -295,6 +310,7 @@ static void multifd_pages_reset(MultiFDPages_t *pages)
      * overwritten later when reused.
      */
     pages->num = 0;
+    pages->normal_num = 0;
     pages->block = NULL;
 }
 
@@ -386,11 +402,13 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     MultiFDPacket_t *packet = p->packet;
     MultiFDPages_t *pages = p->pages;
     uint64_t packet_num;
+    uint32_t zero_num = pages->num - pages->normal_num;
     int i;
 
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
-    packet->normal_pages = cpu_to_be32(pages->num);
+    packet->normal_pages = cpu_to_be32(pages->normal_num);
+    packet->zero_pages = cpu_to_be32(zero_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
 
     packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
@@ -408,10 +426,11 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     }
 
     p->packets_sent++;
-    p->total_normal_pages += pages->num;
+    p->total_normal_pages += pages->normal_num;
+    p->total_zero_pages += zero_num;
 
-    trace_multifd_send(p->id, packet_num, pages->num, p->flags,
-                       p->next_packet_size);
+    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
+                       p->flags, p->next_packet_size);
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -452,20 +471,29 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->normal_num = be32_to_cpu(packet->normal_pages);
     if (p->normal_num > packet->pages_alloc) {
         error_setg(errp, "multifd: received packet "
-                   "with %u pages and expected maximum pages are %u",
+                   "with %u normal pages and expected maximum pages are %u",
                    p->normal_num, packet->pages_alloc) ;
         return -1;
     }
 
+    p->zero_num = be32_to_cpu(packet->zero_pages);
+    if (p->zero_num > packet->pages_alloc - p->normal_num) {
+        error_setg(errp, "multifd: received packet "
+                   "with %u zero pages and expected maximum zero pages are %u",
+                   p->zero_num, packet->pages_alloc - p->normal_num) ;
+        return -1;
+    }
+
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
     p->total_normal_pages += p->normal_num;
+    p->total_zero_pages += p->zero_num;
 
-    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->flags,
-                       p->next_packet_size);
+    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
+                       p->flags, p->next_packet_size);
 
-    if (p->normal_num == 0) {
+    if (p->normal_num == 0 && p->zero_num == 0) {
         return 0;
     }
 
@@ -491,6 +519,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
 
@@ -918,6 +958,8 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.normal_pages, pages->normal_num);
+            stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
 
             multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
@@ -965,7 +1007,8 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
+    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1316,6 +1359,8 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->iov = NULL;
     g_free(p->normal);
     p->normal = NULL;
+    g_free(p->zero);
+    p->zero = NULL;
     multifd_recv_state->ops->recv_cleanup(p);
 }
 
@@ -1449,7 +1494,7 @@ static void *multifd_recv_thread(void *opaque)
             flags = p->flags;
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
-            has_data = !!p->normal_num;
+            has_data = p->normal_num || p->zero_num;
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*
@@ -1507,7 +1552,9 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->packets_recved, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->packets_recved,
+                                  p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1559,6 +1606,7 @@ int multifd_recv_setup(Error **errp)
         p->name = g_strdup_printf("multifdrecv_%d", i);
         p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
+        p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
         p->page_size = qemu_target_page_size();
     }
@@ -1633,3 +1681,17 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
 }
+
+bool multifd_send_prepare_common(MultiFDSendParams *p)
+{
+    multifd_send_zero_page_detect(p);
+
+    if (!p->pages->normal_num) {
+        p->next_packet_size = 0;
+        return false;
+    }
+
+    multifd_send_prepare_header(p);
+
+    return true;
+}
diff --git a/migration/ram.c b/migration/ram.c
index 260529f264..c26435adc7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1288,7 +1288,6 @@ static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
     if (!multifd_queue_page(block, offset)) {
         return -1;
     }
-    stat64_add(&mig_stats.normal_pages, 1);
 
     return 1;
 }
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..1eeb915ff6 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -22,6 +22,7 @@ system_ss.add(files(
   'migration.c',
   'multifd.c',
   'multifd-zlib.c',
+  'multifd-zero-page.c',
   'ram-compress.c',
   'options.c',
   'postcopy-ram.c',
diff --git a/migration/trace-events b/migration/trace-events
index bf1a069632..f0e1cb80c7 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -128,21 +128,21 @@ postcopy_preempt_reset_channel(void) ""
 # multifd.c
 multifd_new_send_channel_async(uint8_t id) "channel %u"
 multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " pages %u flags 0x%x next packet size %u"
+multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t zero, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
 multifd_recv_sync_main_wait(uint8_t id) "iter %u"
 multifd_recv_terminate_threads(bool error) "error %d"
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %u packets %" PRIu64 " pages %" PRIu64
+multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" PRIu64 " zero pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u flags 0x%x next packet size %u"
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(void) ""
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64 " zero pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
-- 
2.44.0


