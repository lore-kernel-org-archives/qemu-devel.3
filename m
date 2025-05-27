Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3BEC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Tp-0003I3-Qs; Tue, 27 May 2025 19:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3To-0003HT-4H
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tm-0001Cq-ED
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FVFBOHDyRMLEfjUsQ8+u7RDvtWgplGxeHp+3xgYqh8=;
 b=ASUFeaXpkEluFXUw5/IOp3Tz3Y0z7cwylyZKjgLTVoiJzT0TxQz8rQTMWwIQl7XiWkAKeS
 lLDtl4VZOBc63d6Tdql/0q+HvwnP4laYQlwqh3tZHlKOkjPXcO7t64Wf7g+GYoWb+xkuPZ
 nMIgMK1lXoK3lKjTu2n12hDKL5O9T6Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-5xrCPdwzPimLhucV3kSV-w-1; Tue, 27 May 2025 19:13:04 -0400
X-MC-Unique: 5xrCPdwzPimLhucV3kSV-w-1
X-Mimecast-MFC-AGG-ID: 5xrCPdwzPimLhucV3kSV-w_1748387584
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4853364ad97so33691991cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387583; x=1748992383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FVFBOHDyRMLEfjUsQ8+u7RDvtWgplGxeHp+3xgYqh8=;
 b=fAVjHFhZYsXS5O5BPFORGkZ8DAq1XnvjDudd49lvpwCjJz6LTm3pAqixeTqOyhJhp5
 /emr47y+PmkyUyoGgHcwyZpzgjez0gNni2CGM0lZJ+I1lEvJvN1k+IK8pZZA3vjfOnxn
 UkedtNUm3WQ8cj1ncykcH+ev56S9pfnGVIbaO0cj0XGFSayosb5ECCcxVqd2p5Pp+1HN
 dARfxWGmDwPypxAq0H40UBrofJwHSf2k2M8GXorgr+IDz+7W8PNnWzPiZFwRn1DUGwad
 qn1rMJjfE3UbodRgsCKMt03IDHzdqwFuJjFEM9/SJHDbmZsW0QXZTuj6yYRUj5siJipb
 w6gg==
X-Gm-Message-State: AOJu0YwmIPNRgkZKTEo2YYNi55GBkMsLRHhnUzrO1iO6fCkaPQ0i0p6K
 e8ksW+j/SPmb9JsqrOXZloJ/4kz9hr3iCwoD9F92lyVB7S8t7ifDpiZuwBdmBCoUJiJXf20bOxr
 S33PEJEIgxYrrdQA4X246fa6GrNQBxoYfrKt3MSsNRHWsIoUpaLbVBC5tRtaSfGfxTTaE1kCVDy
 XY4E/e1xqyBa+keKywphtl8iqgxKQGj2ZwINatfA==
X-Gm-Gg: ASbGncsP+99DqDJFxzSsDQmJdj90BBjnVtbEUbu8pfnDtPMjj6lBeMEACdo9CLtgmOl
 MSzqT7bY5H3yKtmq6yryozeid8Idzfmo4XuOQ119eHc5IKtI6tIgbhFl57VbH0QN3ubKFTJpdxO
 oZMXf537ET6mPZ1dsnbJvmEBMCgCS/TYYiJYMRBVZBc3XLHHA4qzt6Or5dj+cfCEOU5rNynW6em
 Bo8ghtTZGJXbAZVh239KWfZnrT21qzt6TiW/uLEh4rGKkZycnp7hmFT9pvYTwXdze5O4R/soE6N
X-Received: by 2002:a05:622a:6992:b0:494:b3eb:a4cc with SMTP id
 d75a77b69052e-49f480c8fb9mr191276031cf.47.1748387583404; 
 Tue, 27 May 2025 16:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcszs9WQN3XMO00PhJlsqDs0Xu5sp8AY4+mIIMVWYKYOFs1zcjsRrU9G0xxdlQnXMUPkBxag==
X-Received: by 2002:a05:622a:6992:b0:494:b3eb:a4cc with SMTP id
 d75a77b69052e-49f480c8fb9mr191275671cf.47.1748387582916; 
 Tue, 27 May 2025 16:13:02 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 06/13] migration/postcopy: Bring blocktime layer to us level
Date: Tue, 27 May 2025 19:12:41 -0400
Message-ID: <20250527231248.1279174-7-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527231248.1279174-1-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index c6ae4b650c..5cbc7aa77e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -110,6 +110,7 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
+/* All the time records are in unit of microseconds (us) */
 typedef struct PostcopyBlocktimeContext {
     /* time when page fault initiated per vCPU */
     uint64_t *vcpu_blocktime_start;
@@ -168,7 +169,8 @@ static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
     int i;
 
     for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        QAPI_LIST_PREPEND(list, (uint32_t)ctx->vcpu_blocktime_total[i]);
+        QAPI_LIST_PREPEND(
+            list, (uint32_t)(ctx->vcpu_blocktime_total[i] / 1000));
     }
 
     return list;
@@ -191,7 +193,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     }
 
     info->has_postcopy_blocktime = true;
-    info->postcopy_blocktime = (uint32_t)bc->total_blocktime;
+    info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / 1000);
     info->has_postcopy_vcpu_blocktime = true;
     info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
 }
@@ -816,9 +818,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
     return -1;
 }
 
-static uint64_t get_low_time_offset(void)
+static uint64_t get_current_us(void)
 {
-    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    return (uint64_t)qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 }
 
 /*
@@ -835,7 +837,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     int cpu;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
-    uint64_t low_time_offset;
+    uint64_t current_us;
 
     if (!dc || ptid == 0) {
         return;
@@ -845,13 +847,13 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         return;
     }
 
-    low_time_offset = get_low_time_offset();
+    current_us = get_current_us();
     if (dc->vcpu_addr[cpu] == 0) {
         dc->smp_cpus_down++;
     }
 
-    dc->last_begin = low_time_offset;
-    dc->vcpu_blocktime_start[cpu] = low_time_offset;
+    dc->last_begin = current_us;
+    dc->vcpu_blocktime_start[cpu] = current_us;
     dc->vcpu_addr[cpu] = addr;
 
     /*
@@ -899,13 +901,13 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
     bool vcpu_total_blocktime = false;
-    uint64_t read_vcpu_time, low_time_offset;
+    uint64_t read_vcpu_time, current_us;
 
     if (!dc) {
         return;
     }
 
-    low_time_offset = get_low_time_offset();
+    current_us = get_current_us();
     /* lookup cpu, to clear it,
      * that algorithm looks straightforward, but it's not
      * optimal, more optimal algorithm is keeping tree or hash
@@ -918,7 +920,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
             continue;
         }
         dc->vcpu_addr[i] = 0;
-        vcpu_blocktime = low_time_offset - read_vcpu_time;
+        vcpu_blocktime = current_us - read_vcpu_time;
         affected_cpu += 1;
         /* we need to know is that mark_postcopy_end was due to
          * faulted page, another possible case it's prefetched
@@ -932,7 +934,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
 
     dc->smp_cpus_down -= affected_cpu;
     if (vcpu_total_blocktime) {
-        dc->total_blocktime += low_time_offset - dc->last_begin;
+        dc->total_blocktime += current_us - dc->last_begin;
     }
     trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
-- 
2.49.0


