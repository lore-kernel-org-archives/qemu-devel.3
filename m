Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9794CC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvu-0006OE-C8; Mon, 09 Jun 2025 15:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvs-0006NW-4A
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvk-0000pj-De
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IV12Wf4LkVZLaVKBOcF5oGfPlhOljDoxLX6j8/o5TFE=;
 b=X6pvGyzzoNgKYnB87uHW1fAW643oRKWvN06UEhFOpN+Oyx4IsridfqtFoHhmraGUAJPFUR
 ChKI2Sq2QBT1P43OVRdPvTggwQoKmVnDqo/Vzv6SSRd0Gg/KyuUdwxX32V7nkBr0XgAnON
 d196OvSsQTQKJIcTZQBZSjV4TtQ6WYg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-SIdxoNnUMpKjuvpUR4SZTw-1; Mon, 09 Jun 2025 15:13:10 -0400
X-MC-Unique: SIdxoNnUMpKjuvpUR4SZTw-1
X-Mimecast-MFC-AGG-ID: SIdxoNnUMpKjuvpUR4SZTw_1749496390
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7d21fc72219so323009185a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496390; x=1750101190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IV12Wf4LkVZLaVKBOcF5oGfPlhOljDoxLX6j8/o5TFE=;
 b=jpJ5SKw02yN0Ughaw8dit/RP79MDD+/RLrQeELrON1GnZrpqSwWpBnbtcIEZqPkIRJ
 4qzifEQoQSfSUPlI7bNB2CHOJf8P2gjVZOTvRNIWYjb9kDq/pi+ynkKENpQ1vHbADBkX
 A8ZyMdbW9h1loZbFKsNoGZ3Frpt8EFdNP6syxGmsN6dNK3odLeUFhhR3s7dxLVkrE/vO
 4yu9qRXdkaHwupuDKTrmx1O4SKyLwjJVSltd45dv5oZdrqCpapDx6AGdXmKPfbYAqsXb
 bPWcW8mFrhNlGdtz+h1d/g6eHaMprOHMo3hfS1wbMZsK+DP8tGZ8ppemEFj/KiA0l/pb
 3m3w==
X-Gm-Message-State: AOJu0YwqIHa9gX8jh0Bm3RaUDeRYpn1USUXtBDtOU7Hx4RtaqvV8cFPe
 uhAJbfRgKUN05am7Lw3gfq8wbdMN5eKL2LeXFWASW2zZf2vC5893mtgtS2f+rHccmZA4wpYSjih
 3+AhXb7ZSd1/uhHBszBRgq8VkQDqgq6jBbSSpKZXiYpzFrnno0lJgnfPEFgIQ8gufpP6fiW0Ero
 +HTiEmBOdKQLeG0oOsk2WQC65Pz90COvgrDm4YDQ==
X-Gm-Gg: ASbGncuokVPaW2/Fo/feF7lhiCRrcwYGavDOD8efMT97/jL2f5elpGwO0CCNm+AcrgY
 XZpAtsTB474cxfpNuvf1/Pc8tJwpoqnszUDUpSiD6+hFzI0rUJ14b49ugDVPjNImh59SXf3RmRW
 85NvNS7pf1QGXEhW3WOuSP71+e7+qv7jL6dr0IsoYkk0Kxz1lUR2zNJbHaJeSF0Wnta2wqviQFL
 Iu+hao7WoLd22nwJ1Gqv6p1gb78daGI5xnE2BpyNLKwgoL4IgBVe9ffYz45P9hLwU6FYk3OoyZ/
 LaA=
X-Received: by 2002:a05:620a:2496:b0:7c5:6678:ab18 with SMTP id
 af79cd13be357-7d2299b1ebdmr2006940585a.42.1749496389800; 
 Mon, 09 Jun 2025 12:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Qsb1PKl+U09/IS69Dg7ONXcI42UiKTGzh4v1Eb2J5b1ZHxDhEP85ILim6lKoIDT+j1Ihkw==
X-Received: by 2002:a05:620a:2496:b0:7c5:6678:ab18 with SMTP id
 af79cd13be357-7d2299b1ebdmr2006936185a.42.1749496389390; 
 Mon, 09 Jun 2025 12:13:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 05/13] migration/postcopy: Drop
 PostcopyBlocktimeContext.start_time
Date: Mon,  9 Jun 2025 15:12:51 -0400
Message-ID: <20250609191259.9053-6-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609191259.9053-1-peterx@redhat.com>
References: <20250609191259.9053-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now with 64bits, the offseting using start_time is not needed anymore,
because the array can always remember the whole timestamp.

Then drop the unused parameter in get_low_time_offset() altogether.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index ec91821b85..e9acb4ef6e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -123,7 +123,6 @@ typedef struct PostcopyBlocktimeContext {
     uint64_t last_begin;
     /* number of vCPU are suspended */
     int smp_cpus_down;
-    uint64_t start_time;
 
     /*
      * Handler for exit event, necessary for
@@ -157,7 +156,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
     ctx->exit_notifier.notify = migration_exit_cb;
-    ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     qemu_add_exit_notifier(&ctx->exit_notifier);
 
     return ctx;
@@ -818,9 +816,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
     return -1;
 }
 
-static uint64_t get_low_time_offset(PostcopyBlocktimeContext *dc)
+static uint64_t get_low_time_offset(void)
 {
-    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - dc->start_time;
+    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 }
 
 /*
@@ -847,7 +845,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         return;
     }
 
-    low_time_offset = get_low_time_offset(dc);
+    low_time_offset = get_low_time_offset();
     if (dc->vcpu_addr[cpu] == 0) {
         dc->smp_cpus_down++;
     }
@@ -907,7 +905,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
         return;
     }
 
-    low_time_offset = get_low_time_offset(dc);
+    low_time_offset = get_low_time_offset();
     /* lookup cpu, to clear it,
      * that algorithm looks straightforward, but it's not
      * optimal, more optimal algorithm is keeping tree or hash
-- 
2.49.0


