Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87341C5B553
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3To-0003HX-8T; Tue, 27 May 2025 19:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tm-0003HJ-KP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tl-0001Ci-4b
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYaOLKI31H08Zvy+UoVHhAgs+xU9FR4gz/0hfnp6VKA=;
 b=JUomJIW9WjgUtPB8CxFsIiEC6lQ6pMXzygizNb2XeqlpWy7eWr1Yc4Cv0wWuRzGvGQzR+M
 X0uWQnWjHGea/rRB5vW9qejzpazQgIn5fLHrnwbU5kG3pcJOVg7h4RTIwfeBRLRiHko7pQ
 tyRxaIGzqKra6ZQyXhCDMCSURHiy2wE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-pvKUvSJ4MXGzeSP8cjFCCA-1; Tue, 27 May 2025 19:13:02 -0400
X-MC-Unique: pvKUvSJ4MXGzeSP8cjFCCA-1
X-Mimecast-MFC-AGG-ID: pvKUvSJ4MXGzeSP8cjFCCA_1748387582
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-47682f9e7b9so59097121cf.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387581; x=1748992381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dYaOLKI31H08Zvy+UoVHhAgs+xU9FR4gz/0hfnp6VKA=;
 b=cMWyPQAWXC5/f5/E8dzk2hferkr+3yVJfYUgI3G01B84tO8MiLzh1ULKhHYHb5oqrs
 tNPXEvOd8ds6WEsQPIL/Eosnv9DdRjMC3qh0RPc7iJwdK9aaCPapYx2pSwK07VmRyerv
 Pato2e3K0opqOAVpr86LWZycxiBSh1Upgo8/z40l6keyf8Llzm8+wTe7/Y9IHL1hoAxo
 bWvAOWVII/YYRmqiUsL3deXcM1SOHs0IN+wVaYRmW9YCapnIs7h409skpp8f9ATB+RBu
 9FoTEPp5zwextkv7H7je/qiRfcGnp5bgv7tCjwsCrBzmphLxQNEErbYA1YvWkW7WT9LH
 BZuw==
X-Gm-Message-State: AOJu0Yx26Jnzaebzd6ZQoqfZNWDjosRsa4InsI3GUSFCw0tUQjMxnYfZ
 P3mpP+F27shRw1i9YfSqjkOzp3q6eFtodI+T4J+OjpGKucp6haQQOg9ILcaayAYHwufVk//I+pS
 hQqw5cFcN6HoWn9smH8hXYNYERQZPjbYgHbKTFFnv+7QCvI0vyWoqywFc6pXBPUfCfeZa8zYpk7
 vTAjHOxrt3vLdDmZcNFlDQCnaHu/eQutaz2/6Yag==
X-Gm-Gg: ASbGnctzYgN/mhh4jexOYKJqt2MN6UULEpb+j3Rq8nOMKSxogjfu+1M47vQzxoMoexp
 leMqb9NNybyNJ8RAcWcYudbMX60Ks3O9R+kkt7mJqIcVAyGXm8Ovbjm1x9t32U4zdoW0hHUTe92
 iSKdmXybWlDQQwVxMLGjOZJvRnLhAYDpB0q/Ytu9J4KbAZYktaFTPJ8zK5YcjYGSDFQ/dtv3K2C
 Fill8RAWi5nzhKfGUatBKA1J+GUs91VFo4N9keWs3+tPKtKsfYG1NjFlq0SWBDiprapYTfEHY7N
X-Received: by 2002:a05:622a:5a91:b0:476:b33f:6694 with SMTP id
 d75a77b69052e-49f46e38eb6mr255105651cf.28.1748387581603; 
 Tue, 27 May 2025 16:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1hxrqzKQsmcKq07EZ41BjRKi+q6mO95EKIxsYxwKUpQ7vRgHXxxiHFPjv7XvoFst4P/F+OQ==
X-Received: by 2002:a05:622a:5a91:b0:476:b33f:6694 with SMTP id
 d75a77b69052e-49f46e38eb6mr255105221cf.28.1748387581230; 
 Tue, 27 May 2025 16:13:01 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 05/13] migration/postcopy: Drop
 PostcopyBlocktimeContext.start_time
Date: Tue, 27 May 2025 19:12:40 -0400
Message-ID: <20250527231248.1279174-6-peterx@redhat.com>
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

Now with 64bits, the offseting using start_time is not needed anymore,
because the array can always remember the whole timestamp.

Then drop the unused parameter in get_low_time_offset() altogether.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 72f9075e69..c6ae4b650c 100644
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


