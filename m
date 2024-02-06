Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B8C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUjs-0006C2-3N; Tue, 06 Feb 2024 18:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjq-0006BX-FJ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:26 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUji-0005kf-SI
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:26 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-46d1bebe946so946571137.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707261616; x=1707866416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hql99z+y7jRDtiY0A8dhT8uNlKVIz08nW2SMNrsn4vg=;
 b=ZR7mxwCK2JtAFEbhBU/64mPwwihRNZUirhSwkkMoXstX69dXbsqk4mkCdyWVdaH1M7
 hcbXzyKRFE1f3teQvnzbmZEh7Nx4cFhMAoiyocxKiiBPci4TYCeG+7ZgndDxTDcXsosY
 MA/3bJ6CWG3Pldy6yB/G61zP5R5Pvv4almUDZ/d+PYg6GVGgbNSDZKo0nZnuturDYT70
 +C2uDs5xX+pa5fzZ0CdYs9a9/dtu65v7Nn7tFiNDgIJ21reE0LSdvp/Ab6w7C9JWKxna
 DMHBBpfN9o8RkORSlIGIXEndTwVTTTymcXqV/nPHF7tD4z97Cg5RvxG+CEkzP0l0lsFp
 N2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261616; x=1707866416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hql99z+y7jRDtiY0A8dhT8uNlKVIz08nW2SMNrsn4vg=;
 b=EoFOUvawuxFENBxprRY1iXsD5kJWOBGGUZx/Kat5V1h20ZB1f0zq1WxdhYEtPRnSV1
 Hno5HsANYidt/LAo5pJ6+I/k/f64npNvhzfcgLXCcq1WIWcl07csHJrofROh9E/jZJ09
 0opLoeJJseS9QO9xJ5yvEzUA/R640piG+SbhALzGZQRlxEUITUU5P2OchBfbgybGuTtn
 EK8jRMNxKvS9KqmU205FCBI7w6XzNykUKSIUGEwnDNLctiPQAzvB/oCD1H+ULXKsCsV7
 Sqvp8ifmu4M1SDtKGLC4QA8pjFClfhpOYJWDF6Jn8QgXlNU3SIjbJgleYy+kT3LjTxPE
 l8nQ==
X-Gm-Message-State: AOJu0YynnL5dFes/sHMP5A2A5KnnVvi+FGcsxklFOj2r9zlglbPOeDLE
 sPRPaWNr9fl3vGpkPWUGgqD0Wkg8CVZNh8DFoZBm0rwfX+cBAeq8YtVs571bHobcKJezmdpS0tK
 bUHI=
X-Google-Smtp-Source: AGHT+IHXAiTF72wiy35ZvVV3r2q25C//x/eHRNML9F2n9XkBb2YWH9m2kan8GjqXd8Fkbxlbgv/qIw==
X-Received: by 2002:a67:fd8c:0:b0:46d:3c23:a26 with SMTP id
 k12-20020a67fd8c000000b0046d3c230a26mr1037609vsq.22.1707261616147; 
 Tue, 06 Feb 2024 15:20:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUlnbhe3r2KWe1hPn8fXB6mfhpC19fSqbNrAQi44u0CeRBgKbesIT0XeTfrCRT6kNnaRzJxueSObYew2oEC+NO3HIif0h7izbuXo821OjRcdNNp
Received: from n231-230-216.byted.org ([130.44.215.112])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a67b60b000000b0046d20ce8886sm2352vsm.1.2024.02.06.15.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 15:20:15 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 3/6] migration/multifd: Support for zero pages transmission in
 multifd format.
Date: Tue,  6 Feb 2024 23:19:05 +0000
Message-Id: <20240206231908.1792529-4-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240206231908.1792529-1-hao.xiang@bytedance.com>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vs1-xe31.google.com
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

This change adds zero page counters and updates multifd send/receive
tracing format to track the newly added counters.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  4 ++++
 migration/multifd.c            | 43 ++++++++++++++++++++++++++--------
 migration/multifd.h            | 17 +++++++++++++-
 migration/trace-events         |  8 +++----
 4 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8b0c205a41..2dd99b0509 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -111,6 +111,10 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->ram->normal);
         monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
                        info->ram->normal_bytes >> 10);
+        monitor_printf(mon, "zero: %" PRIu64 " pages\n",
+                       info->ram->zero);
+        monitor_printf(mon, "zero bytes: %" PRIu64 " kbytes\n",
+                       info->ram->zero_bytes >> 10);
         monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
                        info->ram->dirty_sync_count);
         monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
diff --git a/migration/multifd.c b/migration/multifd.c
index 25cbc6dc6b..a20d0ed10e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -264,6 +264,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
     packet->normal_pages = cpu_to_be32(p->normal_num);
+    packet->zero_pages = cpu_to_be32(p->zero_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
     packet->packet_num = cpu_to_be64(p->packet_num);
 
@@ -317,18 +318,26 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->normal_num = be32_to_cpu(packet->normal_pages);
     if (p->normal_num > packet->pages_alloc) {
         error_setg(errp, "multifd: received packet "
-                   "with %u pages and expected maximum pages are %u",
+                   "with %u normal pages and expected maximum pages are %u",
                    p->normal_num, packet->pages_alloc) ;
         return -1;
     }
 
-    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
-    p->packet_num = be64_to_cpu(packet->packet_num);
+    p->zero_num = be32_to_cpu(packet->zero_pages);
+    if (p->zero_num > packet->pages_alloc - p->normal_num) {
+        error_setg(errp, "multifd: received packet "
+                   "with %u zero pages and expected maximum zero pages are %u",
+                   p->zero_num, packet->pages_alloc - p->normal_num) ;
+        return -1;
+    }
 
-    if (p->normal_num == 0) {
+    if (p->normal_num == 0 && p->zero_num == 0) {
         return 0;
     }
 
+    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
+    p->packet_num = be64_to_cpu(packet->packet_num);
+
     /* make sure that ramblock is 0 terminated */
     packet->ramblock[255] = 0;
     p->block = qemu_ram_block_by_name(packet->ramblock);
@@ -430,6 +439,7 @@ static int multifd_send_pages(void)
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
+
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
@@ -551,6 +561,8 @@ void multifd_save_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->zero);
+        p->zero = NULL;
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -679,6 +691,7 @@ static void *multifd_send_thread(void *opaque)
             uint64_t packet_num = p->packet_num;
             uint32_t flags;
             p->normal_num = 0;
+            p->zero_num = 0;
 
             if (use_zero_copy_send) {
                 p->iovs_num = 0;
@@ -703,12 +716,13 @@ static void *multifd_send_thread(void *opaque)
             p->flags = 0;
             p->num_packets++;
             p->total_normal_pages += p->normal_num;
+            p->total_zero_pages += p->zero_num;
             p->pages->num = 0;
             p->pages->block = NULL;
             qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
-                               p->next_packet_size);
+            trace_multifd_send(p->id, packet_num, p->normal_num, p->zero_num,
+                               flags, p->next_packet_size);
 
             if (use_zero_copy_send) {
                 /* Send header first, without zerocopy */
@@ -731,6 +745,8 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.normal_pages, p->normal_num);
+            stat64_add(&mig_stats.zero_pages, p->zero_num);
             p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
@@ -761,7 +777,8 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -936,6 +953,7 @@ int multifd_save_setup(Error **errp)
         /* We need one extra place for the packet header */
         p->iov = g_new0(struct iovec, page_count + 1);
         p->normal = g_new0(ram_addr_t, page_count);
+        p->zero = g_new0(ram_addr_t, page_count);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
 
@@ -1051,6 +1069,8 @@ void multifd_load_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->zero);
+        p->zero = NULL;
         multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
@@ -1119,10 +1139,11 @@ static void *multifd_recv_thread(void *opaque)
         flags = p->flags;
         /* recv methods don't know how to handle the SYNC flag */
         p->flags &= ~MULTIFD_FLAG_SYNC;
-        trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
-                           p->next_packet_size);
+        trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
+                           flags, p->next_packet_size);
         p->num_packets++;
         p->total_normal_pages += p->normal_num;
+        p->total_zero_pages += p->zero_num;
         qemu_mutex_unlock(&p->mutex);
 
         if (p->normal_num) {
@@ -1147,7 +1168,8 @@ static void *multifd_recv_thread(void *opaque)
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1186,6 +1208,7 @@ int multifd_load_setup(Error **errp)
         p->name = g_strdup_printf("multifdrecv_%d", i);
         p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
+        p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
         p->page_size = qemu_target_page_size();
     }
diff --git a/migration/multifd.h b/migration/multifd.h
index 35d11f103c..6be9b2f6c1 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -48,7 +48,10 @@ typedef struct {
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     uint64_t packet_num;
-    uint64_t unused[4];    /* Reserved for future use */
+    /* zero pages */
+    uint32_t zero_pages;
+    uint32_t unused32[1];    /* Reserved for future use */
+    uint64_t unused64[3];    /* Reserved for future use */
     char ramblock[256];
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
@@ -120,6 +123,8 @@ typedef struct {
     uint64_t num_packets;
     /* non zero pages sent through this channel */
     uint64_t total_normal_pages;
+    /* zero pages sent through this channel */
+    uint64_t total_zero_pages;
     /* buffers to send */
     struct iovec *iov;
     /* number of iovs used */
@@ -128,6 +133,10 @@ typedef struct {
     ram_addr_t *normal;
     /* num of non zero pages */
     uint32_t normal_num;
+    /* Pages that are zero */
+    ram_addr_t *zero;
+    /* num of zero pages */
+    uint32_t zero_num;
     /* used for compression methods */
     void *data;
 }  MultiFDSendParams;
@@ -179,12 +188,18 @@ typedef struct {
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
     void *data;
 } MultiFDRecvParams;
diff --git a/migration/trace-events b/migration/trace-events
index de4a743c8a..c0a758db9d 100644
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
 multifd_recv_sync_main_wait(uint8_t id) "channel %u"
 multifd_recv_terminate_threads(bool error) "error %d"
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %u packets %" PRIu64 " pages %" PRIu64
+multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" PRIu64 " zero pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u flags 0x%x next packet size %u"
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t normalpages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(bool error) "error %d"
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64 " zero pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
-- 
2.30.2


