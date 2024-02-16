Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157C6C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6tO-0004vz-4J; Fri, 16 Feb 2024 17:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tM-0004v2-8S
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:12 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tI-0007I9-UY
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:11 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4c0245cba99so664660e0c.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708123268; x=1708728068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3VZ+i6lWDPBJl2XFGqb5oFW0n4zsCAj1svqfubVQtg=;
 b=MtaFq7Fb9velGcm+mNKmmwcPQDnQtYyIACeC0rP+k2/y8cbLzFqssa80p/PX3/Rc0z
 Degq+ZlxOrcSIpGajlVXsYIBKPpPyChJ6+94Gv3FpTFGgIzCDRzf50T//gJ5Hl6P7GJw
 jZBiMIYsmrkAeKgnq9b7uiF/mW3YIyt/TU20aWL/pwOAqc9z0HYd6UUXxIyU9P9Nodly
 sxyMNZTFe3oJZWw2cJtl4EhG025j/aA4rHHybgcBsB/oYzRGQnQyeEkH4eMBGEDwR4IO
 frKLM4wKp/tIhZSZti2Fa4OXrb3sSd7vdLIHovJOLKYDhcIN2mdgfl3Maj21/fBPpijK
 IYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123268; x=1708728068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3VZ+i6lWDPBJl2XFGqb5oFW0n4zsCAj1svqfubVQtg=;
 b=Eir/0cvpGswe7QqKa7OH9B5k/w0gjjy0fo2rl5VXZcmmZ+KwQWFnoBgak7GhnmlUoH
 f49LN/O6xSVSiU6QN3Lzj58eh0M7BO+zMX1dK94oEqgLrnmQB8VlH6E/fhb8S6KrPSc6
 9MjTn6hn+vmv21hpq2TYn+tzU/0lARl8ZsawMwfGTr0YBPckiW7ge7sONwfMfaItOUXZ
 fsNwGLNmDsTtnLFrtb8Ab17wxDq/sQrtQZ1AejXSedYOclzZkeYlt1/obuKp2PcRRmzf
 TxZmVS/3tvY0eV8jOFhkVwV7U5aI+EaZblKK8ZnrdRMSZUsOLJaZ5p9vDXqw47ObRbAh
 DozQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+n0cH0a1AvrGJbwAyZQDqpU0C1ClsIBbtWAnqeRkyl66eD7CL1myYRIWzRT5wWlVA9oOWhBRHgh7PhYM2TBlNsVzZ+GY=
X-Gm-Message-State: AOJu0Yy8/OwuBEVhNa62/YGap2Dh20TW4RVILB6zDg309MWCOUCF2l1S
 broj+saytOAqG3RQIbDXT0HV0QXHsrok80eMKyMot70CFv1yb42bKYYZ7/TjCzI=
X-Google-Smtp-Source: AGHT+IFSbay2OENf55AzM/kqmPauD8uxw2NBdT4Eqt+99bj0GNRyrLfGbsx38ajA8HD+YXVh5Y4oAA==
X-Received: by 2002:a1f:62c3:0:b0:4c0:3621:7ab0 with SMTP id
 w186-20020a1f62c3000000b004c036217ab0mr5632423vkb.15.1708123267284; 
 Fri, 16 Feb 2024 14:41:07 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 cz18-20020a056122449200b004c0a12c4d53sm120991vkb.51.2024.02.16.14.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 14:41:06 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 3/7] migration/multifd: Zero page transmission on the
 multifd thread.
Date: Fri, 16 Feb 2024 22:39:58 +0000
Message-Id: <20240216224002.1476890-4-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216224002.1476890-1-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa2c.google.com
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

1. Implements the zero page detection and handling on the multifd
threads for non-compression, zlib and zstd compression backends.
2. Added a new value 'multifd' in ZeroPageDetection enumeration.
3. Add proper asserts to ensure pages->normal are used for normal pages
in all scenarios.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/meson.build         |  1 +
 migration/multifd-zero-page.c | 59 +++++++++++++++++++++++++++++++++++
 migration/multifd-zlib.c      | 26 ++++++++++++---
 migration/multifd-zstd.c      | 25 ++++++++++++---
 migration/multifd.c           | 50 +++++++++++++++++++++++------
 migration/multifd.h           |  7 +++++
 qapi/migration.json           |  4 ++-
 7 files changed, 151 insertions(+), 21 deletions(-)
 create mode 100644 migration/multifd-zero-page.c

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
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
new file mode 100644
index 0000000000..f0cd8e2c53
--- /dev/null
+++ b/migration/multifd-zero-page.c
@@ -0,0 +1,59 @@
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
+void multifd_zero_page_check_send(MultiFDSendParams *p)
+{
+    /*
+     * QEMU older than 9.0 don't understand zero page
+     * on multifd channel. This switch is required to
+     * maintain backward compatibility.
+     */
+    bool use_multifd_zero_page =
+        (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD);
+    MultiFDPages_t *pages = p->pages;
+    RAMBlock *rb = pages->block;
+
+    assert(pages->num != 0);
+    assert(pages->normal_num == 0);
+    assert(pages->zero_num == 0);
+
+    for (int i = 0; i < pages->num; i++) {
+        uint64_t offset = pages->offset[i];
+        if (use_multifd_zero_page &&
+            buffer_is_zero(rb->host + offset, p->page_size)) {
+            pages->zero[pages->zero_num] = offset;
+            pages->zero_num++;
+            ram_release_page(rb->idstr, offset);
+        } else {
+            pages->normal[pages->normal_num] = offset;
+            pages->normal_num++;
+        }
+    }
+}
+
+void multifd_zero_page_check_recv(MultiFDRecvParams *p)
+{
+    for (int i = 0; i < p->zero_num; i++) {
+        void *page = p->host + p->zero[i];
+        if (!buffer_is_zero(page, p->page_size)) {
+            memset(page, 0, p->page_size);
+        }
+    }
+}
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 012e3bdea1..cdfe0fa70e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -123,13 +123,20 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
+    multifd_zero_page_check_send(p);
+
+    if (!pages->normal_num) {
+        p->next_packet_size = 0;
+        goto out;
+    }
+
     multifd_send_prepare_header(p);
 
-    for (i = 0; i < pages->num; i++) {
+    for (i = 0; i < pages->normal_num; i++) {
         uint32_t available = z->zbuff_len - out_size;
         int flush = Z_NO_FLUSH;
 
-        if (i == pages->num - 1) {
+        if (i == pages->normal_num - 1) {
             flush = Z_SYNC_FLUSH;
         }
 
@@ -138,7 +145,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
          * with compression. zlib does not guarantee that this is safe,
          * therefore copy the page before calling deflate().
          */
-        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->page_size);
+        memcpy(z->buf, p->pages->block->host + pages->normal[i], p->page_size);
         zs->avail_in = p->page_size;
         zs->next_in = z->buf;
 
@@ -172,10 +179,10 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
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
 
@@ -261,6 +268,14 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_ZLIB);
         return -1;
     }
+
+    multifd_zero_page_check_recv(p);
+
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
     ret = qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
 
     if (ret != 0) {
@@ -310,6 +325,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, out_size, expected_size);
         return -1;
     }
+
     return 0;
 }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index dc8fe43e94..27a1eba075 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -118,19 +118,26 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
+    multifd_zero_page_check_send(p);
+
+    if (!pages->normal_num) {
+        p->next_packet_size = 0;
+        goto out;
+    }
+
     multifd_send_prepare_header(p);
 
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
-        z->in.src = p->pages->block->host + pages->offset[i];
+        z->in.src = p->pages->block->host + pages->normal[i];
         z->in.size = p->page_size;
         z->in.pos = 0;
 
@@ -161,10 +168,10 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
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
 
@@ -257,6 +264,14 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_ZSTD);
         return -1;
     }
+
+    multifd_zero_page_check_recv(p);
+
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
     ret = qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
 
     if (ret != 0) {
diff --git a/migration/multifd.c b/migration/multifd.c
index a33dba40d9..fbb40ea10b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
@@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
     MultiFDPages_t *pages = p->pages;
     int ret;
 
+    multifd_zero_page_check_send(p);
+
     if (!use_zero_copy_send) {
         /*
          * Only !zerocopy needs the header in IOV; zerocopy will
@@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
         multifd_send_prepare_header(p);
     }
 
-    for (int i = 0; i < pages->num; i++) {
-        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
+    for (int i = 0; i < pages->normal_num; i++) {
+        p->iov[p->iovs_num].iov_base = pages->block->host + pages->normal[i];
         p->iov[p->iovs_num].iov_len = p->page_size;
         p->iovs_num++;
     }
 
-    p->next_packet_size = pages->num * p->page_size;
+    p->next_packet_size = pages->normal_num * p->page_size;
     p->flags |= MULTIFD_FLAG_NOCOMP;
 
     multifd_send_fill_packet(p);
@@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_NOCOMP);
         return -1;
     }
+
+    multifd_zero_page_check_recv(p);
+
+    if (!p->normal_num) {
+        return 0;
+    }
+
     for (int i = 0; i < p->normal_num; i++) {
         p->iov[i].iov_base = p->host + p->normal[i];
         p->iov[i].iov_len = p->page_size;
@@ -339,7 +349,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
-    packet->normal_pages = cpu_to_be32(pages->num);
+    packet->normal_pages = cpu_to_be32(pages->normal_num);
     packet->zero_pages = cpu_to_be32(pages->zero_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
 
@@ -350,18 +360,25 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
         strncpy(packet->ramblock, pages->block->idstr, 256);
     }
 
-    for (i = 0; i < pages->num; i++) {
+    for (i = 0; i < pages->normal_num; i++) {
         /* there are architectures where ram_addr_t is 32 bit */
-        uint64_t temp = pages->offset[i];
+        uint64_t temp = pages->normal[i];
 
         packet->offset[i] = cpu_to_be64(temp);
     }
 
+    for (i = 0; i < pages->zero_num; i++) {
+        /* there are architectures where ram_addr_t is 32 bit */
+        uint64_t temp = pages->zero[i];
+
+        packet->offset[pages->normal_num + i] = cpu_to_be64(temp);
+    }
+
     p->packets_sent++;
-    p->total_normal_pages += pages->num;
+    p->total_normal_pages += pages->normal_num;
     p->total_zero_pages += pages->zero_num;
 
-    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_num,
+    trace_multifd_send(p->id, packet_num, pages->normal_num, pages->zero_num,
                        p->flags, p->next_packet_size);
 }
 
@@ -451,6 +468,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
 
@@ -842,7 +871,7 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
-            stat64_add(&mig_stats.normal_pages, pages->num);
+            stat64_add(&mig_stats.normal_pages, pages->normal_num);
             stat64_add(&mig_stats.zero_pages, pages->zero_num);
 
             multifd_pages_reset(p->pages);
@@ -1256,7 +1285,8 @@ static void *multifd_recv_thread(void *opaque)
         p->flags &= ~MULTIFD_FLAG_SYNC;
         qemu_mutex_unlock(&p->mutex);
 
-        if (p->normal_num) {
+        if (p->normal_num + p->zero_num) {
+            assert(!(flags & MULTIFD_FLAG_SYNC));
             ret = multifd_recv_state->ops->recv_pages(p, &local_err);
             if (ret != 0) {
                 break;
diff --git a/migration/multifd.h b/migration/multifd.h
index 9822ff298a..125f0bbe60 100644
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
 
@@ -224,6 +229,8 @@ typedef struct {
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
 void multifd_send_fill_packet(MultiFDSendParams *p);
+void multifd_zero_page_check_send(MultiFDSendParams *p);
+void multifd_zero_page_check_recv(MultiFDRecvParams *p);
 
 static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 {
diff --git a/qapi/migration.json b/qapi/migration.json
index 99843a8e95..e2450b92d4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -660,9 +660,11 @@
 #
 # @none: Do not perform zero page checking.
 #
+# @multifd: Perform zero page checking on the multifd sender thread. (since 9.0)
+#
 ##
 { 'enum': 'ZeroPageDetection',
-  'data': [ 'legacy', 'none' ] }
+  'data': [ 'legacy', 'none', 'multifd' ] }
 
 ##
 # @BitmapMigrationBitmapAliasTransform:
-- 
2.30.2


