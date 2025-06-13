Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA63CC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59E-0003uG-Eq; Fri, 13 Jun 2025 10:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ597-0003si-Mp
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002JO-N5
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfDiLFsnA6dZl9kxkmwj0QVEEsOtGZ66FVveHBAm7ew=;
 b=dKykqnY4kW51ayF1Bw5niTqGKH54H80/W7XLfUBuaG3Cib9WZLWlof5FvGnqBH7HRs5orE
 BUlLE0X8c87OY6PEoN9L6YuWZjYDxHWuhh4fKiLunQiQTdNHUNBMk7PVkhXkPnFqjcmOVT
 haRGNsJEhShLVihi8nNL03rhWKFugxs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-9DXSpzx0MR-qyDOeQ1kPhw-1; Fri, 13 Jun 2025 10:12:26 -0400
X-MC-Unique: 9DXSpzx0MR-qyDOeQ1kPhw-1
X-Mimecast-MFC-AGG-ID: 9DXSpzx0MR-qyDOeQ1kPhw_1749823946
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a43988c314so42710981cf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823945; x=1750428745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfDiLFsnA6dZl9kxkmwj0QVEEsOtGZ66FVveHBAm7ew=;
 b=kKAQDjjvcQqbF4JASbqtk8HaeHX5kqc2Cpg6w+0YxPWcNl/PGmspQ+XPFLQFBwFonc
 JIkoAoILW9MU1M4oLgemFyPtWZVl8Djzq2FsxRjvV4WIpcyfY4QIv5oTYesZ8TnE/GKW
 k9hYx4NFBunWlPq34u9XQBtrGINtDeDR0tOdGSYOMXvho+34GLIlPTmNK1hsyjmso4pO
 81IJxVp5XA6RT/Zml4FVZnHdvwIXIEofGo2vsX+r6/OrWHlVPHA9MNHpsMhIYDGrDv0E
 e3m36sB+5FihUDvjGETia1xgi0LeX0D8ohS/RJqyGC/IlNZ9xiEQcEBgRqix0EdcU0/j
 Nd+Q==
X-Gm-Message-State: AOJu0YzGFVqGl0QWWsd9rANow78l0E1OZYHXh5K4MNAORTPcYMWoUwG2
 eiP7aB80+r6f4Cmo0kF3Js2n8ffvAnzmOhvxRWyBDG/u0tDugGu+FgGJwBb03I5/4jKU8pHAIda
 4JG9+zRwNfk7D59Gf2XTdZX5Bze4sDoRLRr7AaooDH8AZPCkQ3KHaje8wdNqQvJ4MaT+/nh7MOH
 etUvti4/tVMfQClAWh8RprpI9679WD5zM1nXnF+w==
X-Gm-Gg: ASbGncuH3qctmmVTph2Ra+Uo1jvJhTXvokkXZA92M+TKJbQ8pM+NePPgP7wKwr30++Z
 HngVo9a6xtiC8XlSAZ2BZEPgLgfRI3rj4a/tJhLYZawwGKqoAo7eFFRzn8iet4KlDEBMfkKFUdI
 TBv4zdiwfBZ3d+B1/fxHQQRkkML0MEuZvWQ35etojvq0dOP+d+UgjSQN/U6qqNfFhw5d5aN4927
 fFlRVDrtHciR000QNU78qeXlkOD5qCLc6D0FsHZUnFZcJXJfVN1MWG695UJGV40uqOsAL/n4+6z
 U18B4plJ5es=
X-Received: by 2002:a05:622a:1144:b0:4a4:4165:ed60 with SMTP id
 d75a77b69052e-4a72fe810aamr58523101cf.3.1749823945169; 
 Fri, 13 Jun 2025 07:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGYrZgpa1RTj8jp6ORf/NfMI9mePxEncRzQJVzpyWRTS/48+dppDujNvAlbqvpO68D1qONQ==
X-Received: by 2002:a05:622a:1144:b0:4a4:4165:ed60 with SMTP id
 d75a77b69052e-4a72fe810aamr58522401cf.3.1749823944579; 
 Fri, 13 Jun 2025 07:12:24 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 04/14] migration/postcopy: Make all blocktime vars 64bits
Date: Fri, 13 Jun 2025 10:12:07 -0400
Message-ID: <20250613141217.474825-5-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I am guessing it was used to be 32bits because of the atomic ops.  Now all
the atomic ops are gone and we're protected by a mutex instead, it's ok we
can switch to 64 bits.

Reasons to move over:

  - Allow further patches to change the unit from ms to us: with postcopy
  preempt mode, we're really into hundreds of microseconds level on
  blocktime.  We'd better be able to trap those.

  - This also paves way for some other tricks that the original version
  used to avoid overflows, e.g., start_time was almost only useful before
  to make sure the sampled timestamp won't overflow a 32-bit field.

  - This prepares further reports on top of existing data collected,
  e.g. average page fault latencies.  When average operation is taken into
  account, milliseconds are simply too coarse grained.

When at it:

  - Rename page_fault_vcpu_time to vcpu_blocktime_start.

  - Rename vcpu_blocktime to vcpu_blocktime_total.

  - Touch up the trace-events to not dump blocktime ctx pointer

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 50 ++++++++++++++++++++--------------------
 migration/trace-events   |  4 ++--
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 81925532de..ec91821b85 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -112,14 +112,15 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 
 typedef struct PostcopyBlocktimeContext {
     /* time when page fault initiated per vCPU */
-    uint32_t *page_fault_vcpu_time;
+    uint64_t *vcpu_blocktime_start;
+    /* blocktime per vCPU */
+    uint64_t *vcpu_blocktime_total;
     /* page address per vCPU */
     uintptr_t *vcpu_addr;
-    uint32_t total_blocktime;
-    /* blocktime per vCPU */
-    uint32_t *vcpu_blocktime;
+    /* total blocktime when all vCPUs are stopped */
+    uint64_t total_blocktime;
     /* point in time when last page fault was initiated */
-    uint32_t last_begin;
+    uint64_t last_begin;
     /* number of vCPU are suspended */
     int smp_cpus_down;
     uint64_t start_time;
@@ -133,9 +134,9 @@ typedef struct PostcopyBlocktimeContext {
 
 static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
-    g_free(ctx->page_fault_vcpu_time);
+    g_free(ctx->vcpu_blocktime_start);
+    g_free(ctx->vcpu_blocktime_total);
     g_free(ctx->vcpu_addr);
-    g_free(ctx->vcpu_blocktime);
     g_free(ctx);
 }
 
@@ -151,13 +152,14 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
     PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
-    ctx->page_fault_vcpu_time = g_new0(uint32_t, smp_cpus);
-    ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
-    ctx->vcpu_blocktime = g_new0(uint32_t, smp_cpus);
 
+    ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
     ctx->exit_notifier.notify = migration_exit_cb;
     ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     qemu_add_exit_notifier(&ctx->exit_notifier);
+
     return ctx;
 }
 
@@ -168,7 +170,7 @@ static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
     int i;
 
     for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        QAPI_LIST_PREPEND(list, ctx->vcpu_blocktime[i]);
+        QAPI_LIST_PREPEND(list, (uint32_t)ctx->vcpu_blocktime_total[i]);
     }
 
     return list;
@@ -191,12 +193,12 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     }
 
     info->has_postcopy_blocktime = true;
-    info->postcopy_blocktime = bc->total_blocktime;
+    info->postcopy_blocktime = (uint32_t)bc->total_blocktime;
     info->has_postcopy_vcpu_blocktime = true;
     info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
 }
 
-static uint32_t get_postcopy_total_blocktime(void)
+static uint64_t get_postcopy_total_blocktime(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
@@ -816,11 +818,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
     return -1;
 }
 
-static uint32_t get_low_time_offset(PostcopyBlocktimeContext *dc)
+static uint64_t get_low_time_offset(PostcopyBlocktimeContext *dc)
 {
-    int64_t start_time_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
-                                    dc->start_time;
-    return start_time_offset < 1 ? 1 : start_time_offset & UINT32_MAX;
+    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - dc->start_time;
 }
 
 /*
@@ -837,7 +837,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     int cpu;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
-    uint32_t low_time_offset;
+    uint64_t low_time_offset;
 
     if (!dc || ptid == 0) {
         return;
@@ -853,7 +853,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     }
 
     dc->last_begin = low_time_offset;
-    dc->page_fault_vcpu_time[cpu] = low_time_offset;
+    dc->vcpu_blocktime_start[cpu] = low_time_offset;
     dc->vcpu_addr[cpu] = addr;
 
     /*
@@ -862,7 +862,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
      */
     assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
 
-    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
+    trace_mark_postcopy_blocktime_begin(addr, dc->vcpu_blocktime_start[cpu],
                                         cpu);
 }
 
@@ -901,7 +901,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
     bool vcpu_total_blocktime = false;
-    uint32_t read_vcpu_time, low_time_offset;
+    uint64_t read_vcpu_time, low_time_offset;
 
     if (!dc) {
         return;
@@ -913,9 +913,9 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
      * optimal, more optimal algorithm is keeping tree or hash
      * where key is address value is a list of  */
     for (i = 0; i < smp_cpus; i++) {
-        uint32_t vcpu_blocktime = 0;
+        uint64_t vcpu_blocktime = 0;
 
-        read_vcpu_time = dc->page_fault_vcpu_time[i];
+        read_vcpu_time = dc->vcpu_blocktime_start[i];
         if (dc->vcpu_addr[i] != addr || read_vcpu_time == 0) {
             continue;
         }
@@ -929,14 +929,14 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
             vcpu_total_blocktime = true;
         }
         /* continue cycle, due to one page could affect several vCPUs */
-        dc->vcpu_blocktime[i] += vcpu_blocktime;
+        dc->vcpu_blocktime_total[i] += vcpu_blocktime;
     }
 
     dc->smp_cpus_down -= affected_cpu;
     if (vcpu_total_blocktime) {
         dc->total_blocktime += low_time_offset - dc->last_begin;
     }
-    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
+    trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 917f521e88..02cdb6e7cc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -285,8 +285,8 @@ postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
-mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d"
-mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d"
+mark_postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d"
+mark_postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
 postcopy_pause_fault_thread(void) ""
 postcopy_pause_fault_thread_continued(void) ""
 postcopy_pause_fast_load(void) ""
-- 
2.49.0


