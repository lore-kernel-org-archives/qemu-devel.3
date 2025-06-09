Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A461FC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhw3-0006QO-IT; Mon, 09 Jun 2025 15:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhw1-0006PV-0L
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvy-0000rz-EV
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDmfUIQxVF5pSgvWN390nZRIsyCmDGidl1i9aKjf6yg=;
 b=JWgtQ7FDNb6Djrxexcy9LJKcc01paBPnLYyGXvFTmpkrSecRxMvZwzG242V+UtekZlYRXA
 nvKDzz860ggOttvscffnc5UBsxNgSetTGo+Mcjkey3CxDYglLl9HbzaRAbbQw1+OwBJpLe
 8EF6EzORB4UprWRCcPh8CYm7h1O/7QU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-daxjYR9ENp2ZUBQlCFOUDg-1; Mon, 09 Jun 2025 15:13:24 -0400
X-MC-Unique: daxjYR9ENp2ZUBQlCFOUDg-1
X-Mimecast-MFC-AGG-ID: daxjYR9ENp2ZUBQlCFOUDg_1749496404
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-739f234f60dso533584a34.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496403; x=1750101203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDmfUIQxVF5pSgvWN390nZRIsyCmDGidl1i9aKjf6yg=;
 b=qKh5Pq4QVtCNv8QV4uzoO+a0E1oNGsQP3WOrgDUYKaBwhB81ifDy8Ee8gRdQ4orErR
 du43M8WZmPrmN8fQoLq5krAiHyRX/M2OkMHl50NAVN2Oy7i1hj+fQ5rYLwFj/SoyMg3h
 FhC7J9u8QrQlyiFtZcaL2ZcplDnnC+Ojew/KUWogGbKaZnlGuBzTsRkRgBXUMM81S6E2
 G0AVPdm/ZXl5Jntps0jza1OLOLM/EQnkPwJnpVxSWuVgHvpIgMj7kkZTdufTNS+LN4KO
 R7LUeDVUn71rFlueqWJc6hi9tAlRVBzT5bGNxZEjqQcL7xEfel4lzFsR/hUdzeVOKyQQ
 SEaQ==
X-Gm-Message-State: AOJu0Yx8MZwZ7Z1/VmRyDYE3BknoRCwOqfkWv8MY6CeSexqkpaDIwGvX
 cWnDoZPWwgA8UWU/zirEzHpk651KefovFc30x/+d1rfxGoe1h2CCwkvbaBhtyV9CLWQu6kI4mXy
 uSyRPb0L3ff6vbk4Toi7Mn3DFNOY9MqilO0STXYXREaaBZMYlcg9Qd7B4K+HkHa8arsXP2BUFLg
 ITrYE6lIo34e9KizTq5RLbLV5lZa0tF7fs+U1I8w==
X-Gm-Gg: ASbGncsP9H/PDV9Pw0HCiiV7UeYxmY1sR1X0UcIRK6phy/FH8hcQW21Onq21fDipXy2
 wTSawTAFg1qXqu+sC0k+TD+Accmz5DhaBcLxhx3xC3DuPtnDBtigMuSoLWw77nuqMp7IQY0jvxE
 ZfPgGPpFz1+dW49u3+QeeV+TKPudMeZBiuBUw5J07JhjwlTo+uJUNfqDT0a6qLOnsJNMr8fPGlV
 n/FkqRoiVbzPC7ycOT13XYRFzj2dav3VmEgb30e1aKYWvX/PQQsUTXcDLx8z2sji5gOPT767mIJ
 8o10ZNHUkr6fOA==
X-Received: by 2002:a05:6830:7317:b0:72a:48d4:290b with SMTP id
 46e09a7af769-73888f1e784mr11289609a34.26.1749496403161; 
 Mon, 09 Jun 2025 12:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhWQyxm8K2zsSZ0qCFvR1AIeJlCw0Hzz7aJ+zv4y8P/GGyUbvv8qFyg/JTuICTg0NEP/KLNA==
X-Received: by 2002:a05:6214:21e4:b0:6e8:9b52:7a1d with SMTP id
 6a1803df08f44-6fb08f627a4mr243976546d6.8.1749496390789; 
 Mon, 09 Jun 2025 12:13:10 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 06/13] migration/postcopy: Bring blocktime layer to us level
Date: Mon,  9 Jun 2025 15:12:52 -0400
Message-ID: <20250609191259.9053-7-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609191259.9053-1-peterx@redhat.com>
References: <20250609191259.9053-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
 migration/postcopy-ram.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e9acb4ef6e..f79fb7663c 100644
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


