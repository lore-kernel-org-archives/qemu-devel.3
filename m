Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83290C71151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59P-00044E-KV; Fri, 13 Jun 2025 10:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ599-0003su-1K
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002JJ-NW
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2Y/VxjR0SJSPRQDE9vrJyR5mQKGwsPyvRKvKMkiT1A=;
 b=A8O/mpZVLIWgNOCY31r/ryRxsKUtKr+YdEnY5GoA8StOBCoYcQtfS/NEBxPdfTSjcDR1pF
 CEz4MG5h/k61FPCd5fkS7lEVOLjSO79psV61GHNyjO/xVYEpxvZWtG99GPBkwT3Q+fq1Bz
 dPW4dRliZ1FQCA5wJUNSorJDHoUd/p8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-jxedrYASPIKFrsGblLsu2g-1; Fri, 13 Jun 2025 10:12:28 -0400
X-MC-Unique: jxedrYASPIKFrsGblLsu2g-1
X-Mimecast-MFC-AGG-ID: jxedrYASPIKFrsGblLsu2g_1749823948
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a585dc5f6aso47500331cf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823948; x=1750428748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2Y/VxjR0SJSPRQDE9vrJyR5mQKGwsPyvRKvKMkiT1A=;
 b=XeWrsZTWxvQmFqkAzgAZZ5E657NpmsSVBXJbM/UHRsq9x378kEOFCdSrazhsx+SGxa
 yKhoMU+0F6UphFzlGzjE7XCLcctMJUQADN50sjbDMYRvj+2D0+vbDmgqOeSptwXbC5kY
 pgzmeB305hWpHgahj8tLYyG7R0MO/uuFTPofnZy2Rn187pVm8xAL1KhRtksP3jlg8BFm
 kja7DetR35DS1pIpZoWmdvpZiqiu0XiO0IJEdBk30JLM7MhvHk+hvXxu5mgyex5yPWu6
 NPPjgW9Aql18q90OM/vgcze2xcirP8pcibdCMvdvCMnzX7dXsCK51l+ci9tzYg9qxdLs
 cB2A==
X-Gm-Message-State: AOJu0YwuwwgbuzeFkiW13qVMJCrAyymJU6t1FxOVmRlNH5ESQXGNTuu/
 eYsGuaPJu8+GB4QOHDgs9PlxbYR4+SM885JDHZQQyUAsL99kr0001N5Ve3gO7177NA1Cy2uJ7Ig
 rQdCxAS6nnHTWNw8p43E+iAtnwaPPXmqRfumOUSQ7GMb+3POmM79VKJ1savxMIWI6PeFAlJfoSL
 rZj4LSq5NnZAVxoMH+DKDXog6I422gljc/SI9/Tg==
X-Gm-Gg: ASbGnctExp28ZLxgukmN3Gc4gMLVfGhYkEEXluUR0+ZHGsIRcCbRnKkb5ApMZFU43EW
 UdSduJ9QaFrk4T5h3loR5pDjHNVf7q61YXrwIs3qmUr3p7Ztiv3eZilRVx/ThFP+ALDfy4SNfAo
 uYsK7FpurPwS3RkbnYVWXCbaJkplr9NQKkXNS+wd9gwr3zoBuBD+oTXjzkXNj36jfnCMMG9Gab+
 i5PjMxt8M456R4jOn+ZVwF0ATM0WuhtZNbstb6GLwfUfOyirOJx+F3NCfYxtPuznfbAaovYNcRw
 3FIshS8+PEo=
X-Received: by 2002:a05:622a:1248:b0:4a4:3449:2b82 with SMTP id
 d75a77b69052e-4a72fe9229emr60593261cf.13.1749823947582; 
 Fri, 13 Jun 2025 07:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbwblsb0vk78EWJhH6nHdp6FSb35/FKAe/uVfS0m1qT6wBgYAqkpluLYqBY6xZ2YNpvWzUUw==
X-Received: by 2002:a05:622a:1248:b0:4a4:3449:2b82 with SMTP id
 d75a77b69052e-4a72fe9229emr60592581cf.13.1749823946868; 
 Fri, 13 Jun 2025 07:12:26 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 06/14] migration/postcopy: Bring blocktime layer to ns level
Date: Fri, 13 Jun 2025 10:12:09 -0400
Message-ID: <20250613141217.474825-7-peterx@redhat.com>
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

With 64-bit fields, it is trivial.  The caution is when exposing any values
in QMP, it was still declared with milliseconds (ms).  Hence it's needed to
do the convertion when exporting the values to existing QMP queries.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e9acb4ef6e..9dfa92a62d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -110,6 +110,7 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
+/* All the time records are in unit of nanoseconds */
 typedef struct PostcopyBlocktimeContext {
     /* time when page fault initiated per vCPU */
     uint64_t *vcpu_blocktime_start;
@@ -168,7 +169,9 @@ static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
     int i;
 
     for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        QAPI_LIST_PREPEND(list, (uint32_t)ctx->vcpu_blocktime_total[i]);
+        /* Convert ns -> ms */
+        QAPI_LIST_PREPEND(
+            list, (uint32_t)(ctx->vcpu_blocktime_total[i] / SCALE_MS));
     }
 
     return list;
@@ -191,7 +194,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     }
 
     info->has_postcopy_blocktime = true;
-    info->postcopy_blocktime = (uint32_t)bc->total_blocktime;
+    /* Convert ns -> ms */
+    info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / SCALE_MS);
     info->has_postcopy_vcpu_blocktime = true;
     info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
 }
@@ -816,9 +820,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
     return -1;
 }
 
-static uint64_t get_low_time_offset(void)
+static uint64_t get_current_ns(void)
 {
-    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    return (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 }
 
 /*
@@ -835,7 +839,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     int cpu;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
-    uint64_t low_time_offset;
+    uint64_t current;
 
     if (!dc || ptid == 0) {
         return;
@@ -845,13 +849,13 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         return;
     }
 
-    low_time_offset = get_low_time_offset();
+    current = get_current_ns();
     if (dc->vcpu_addr[cpu] == 0) {
         dc->smp_cpus_down++;
     }
 
-    dc->last_begin = low_time_offset;
-    dc->vcpu_blocktime_start[cpu] = low_time_offset;
+    dc->last_begin = current;
+    dc->vcpu_blocktime_start[cpu] = current;
     dc->vcpu_addr[cpu] = addr;
 
     /*
@@ -899,13 +903,13 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
     bool vcpu_total_blocktime = false;
-    uint64_t read_vcpu_time, low_time_offset;
+    uint64_t read_vcpu_time, current;
 
     if (!dc) {
         return;
     }
 
-    low_time_offset = get_low_time_offset();
+    current = get_current_ns();
     /* lookup cpu, to clear it,
      * that algorithm looks straightforward, but it's not
      * optimal, more optimal algorithm is keeping tree or hash
@@ -918,7 +922,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
             continue;
         }
         dc->vcpu_addr[i] = 0;
-        vcpu_blocktime = low_time_offset - read_vcpu_time;
+        vcpu_blocktime = current - read_vcpu_time;
         affected_cpu += 1;
         /* we need to know is that mark_postcopy_end was due to
          * faulted page, another possible case it's prefetched
@@ -932,7 +936,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
 
     dc->smp_cpus_down -= affected_cpu;
     if (vcpu_total_blocktime) {
-        dc->total_blocktime += low_time_offset - dc->last_begin;
+        dc->total_blocktime += current - dc->last_begin;
     }
     trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
-- 
2.49.0


