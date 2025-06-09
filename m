Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997A5C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvs-0006Ng-7f; Mon, 09 Jun 2025 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvq-0006Ml-Lb
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvn-0000pz-D9
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtJswxUgI+FVYadSfpkgF96burKPZXr5ACVFgqgHl7U=;
 b=iBpaK77FG19R+1MFU4qDt12tZ42j/GQzkDRe9jktDOo8PV0S7gNdn4kREKLvijsE31/M3R
 XnZeZrPNRm0ExCLG5zaNe5yaG2pHPefr3fx7A+jTPOunsgtId74V2oBhS8dlh1pmSj+JaV
 ITawd+O9yLvYAtgh70bV4RC5c/dKiqs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-_gaiZA8gNganKV89GnBVvg-1; Mon, 09 Jun 2025 15:13:13 -0400
X-MC-Unique: _gaiZA8gNganKV89GnBVvg-1
X-Mimecast-MFC-AGG-ID: _gaiZA8gNganKV89GnBVvg_1749496393
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6facb96d553so77531686d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496392; x=1750101192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PtJswxUgI+FVYadSfpkgF96burKPZXr5ACVFgqgHl7U=;
 b=DGVauD1PaISsR1xIqkF0wt5NBKDhNtJw8Jy3J3QdZv8sJXqKeOu6hxP+fy9IUhVGHa
 kym8fPlMEXbuAvjWpQHIgJNlgzXFW+LarFfbMYhnYCAhynBTlqXneoPAGqfF4N4CrV7Z
 qtPzJXRq2yizsxiKpNMPIX4wUiXJH9M7rXZ8Dfwg7th5dwe70xuDhkX2EKYFsfmzZIQk
 7PQGDpByFn3DkmAtKelZ8oLXCHQ8K3nyQ1/3NPgJeaxPJ8QHnvPYRPtD1fYoGKe7f5V7
 GW/GpqAT87kouza4JZeCGDwlrGv31gfdb5XLCLKUZIuc/XNEutNIDUaRk1APRhi978SX
 INag==
X-Gm-Message-State: AOJu0YxZuFMga/ohCuzUwJwLTVgroNVeHx+/KOzgqVWEQf9+ZcSquY3a
 YlbTPDvjI3tUnuSSCcoQ0uB0N12Fi3yvN7JlJdirY+pWzoB+rHpdkchYqK+KR0TqBG+SuUZHex6
 +fnDOCXzj6W/McZwLkAlcLYiIa4erBbA42fwcGOdV/4XAnfD2YUOHiVwRNf4WnFR+hRCQhs9TWs
 M+BEbFeeQjJkaD/RqTq9TQ2/KIPRy9N8FRD+7dAA==
X-Gm-Gg: ASbGncu/+PkYToricSZwO9MgHNW1s42TqmBUOVNnTXTva1IkyynlFYUOcjzzkvZ1PM1
 d8ufnpIe+Yc4ktZVw6s1yaR3z6RvRr6hI/Wr6yvWH9tZdqLKNRsWexG1oiAfR305cjY2CSmJ6zA
 3fxsSCRAuTt5pnLujvbPJrisVR51F7ckYAIZs5i8/VEmdUgixZLugcow+lnc1ZmmkCNzGTPpvtS
 Lr04dlUvHb4m1kKV8xeb4xOmdmdp5EXpA3APrUz8+YyOyJeDAJGuGIpIOSe4IHr4C6z9GpkpVDh
 fRE=
X-Received: by 2002:a05:6214:2349:b0:6f8:ad11:276a with SMTP id
 6a1803df08f44-6fb2396b66amr11889346d6.19.1749496392428; 
 Mon, 09 Jun 2025 12:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYWpum/slEmCYdYNTa9qXPKaGlBs8X6UmS1CIkB+eSQ34Khe1k+Q2zlX18zoTkzBmVqLIZyA==
X-Received: by 2002:a05:6214:2349:b0:6f8:ad11:276a with SMTP id
 6a1803df08f44-6fb2396b66amr11889016d6.19.1749496391971; 
 Mon, 09 Jun 2025 12:13:11 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 07/13] migration/postcopy: Add blocktime fault counts
 per-vcpu
Date: Mon,  9 Jun 2025 15:12:53 -0400
Message-ID: <20250609191259.9053-8-peterx@redhat.com>
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

Add a field to count how many remote faults one vCPU has taken.  So far
it's still not used, but will be soon.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f79fb7663c..f5c58a6ca7 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -116,6 +116,8 @@ typedef struct PostcopyBlocktimeContext {
     uint64_t *vcpu_blocktime_start;
     /* blocktime per vCPU */
     uint64_t *vcpu_blocktime_total;
+    /* count of faults per vCPU */
+    uint64_t *vcpu_faults_count;
     /* page address per vCPU */
     uintptr_t *vcpu_addr;
     /* total blocktime when all vCPUs are stopped */
@@ -136,6 +138,7 @@ static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
     g_free(ctx->vcpu_blocktime_start);
     g_free(ctx->vcpu_blocktime_total);
+    g_free(ctx->vcpu_faults_count);
     g_free(ctx->vcpu_addr);
     g_free(ctx);
 }
@@ -155,6 +158,7 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 
     ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
@@ -855,6 +859,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     dc->last_begin = current_us;
     dc->vcpu_blocktime_start[cpu] = current_us;
     dc->vcpu_addr[cpu] = addr;
+    dc->vcpu_faults_count[cpu]++;
 
     /*
      * The caller should only inject a blocktime entry when the page is
-- 
2.49.0


