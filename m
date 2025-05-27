Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD2C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Tk-0003Ge-61; Tue, 27 May 2025 19:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Ti-0003Fw-J3
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Th-0001CK-5Q
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/hTimLfZ82o3Gbt7wDLVs4TTZZVjdvxyDmBoPsW1WQ=;
 b=Y5EiyNisnsa5I/AbyDXQ7InidwJdUw1lcTRkzzhk6ehSVykNvdjRMFGnNL36V+WWypRzNS
 vPrX1CkB+vQXjHZf5vlnvQ+kTkjAWjXxD0mFCmBZQjdOjVSXKbNz1DvbhHydbezohHed2O
 8z/j0MAPl+KxXotirsukYHJEK3LiGrU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-sbDKvI0hMtqWe9G_aYU5dA-1; Tue, 27 May 2025 19:12:59 -0400
X-MC-Unique: sbDKvI0hMtqWe9G_aYU5dA-1
X-Mimecast-MFC-AGG-ID: sbDKvI0hMtqWe9G_aYU5dA_1748387579
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4767e6b4596so65624201cf.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387578; x=1748992378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/hTimLfZ82o3Gbt7wDLVs4TTZZVjdvxyDmBoPsW1WQ=;
 b=NCQ6Oul8oXLeHbVnQ3wrzjIewwg/KVw44Blyzlftn6KxqgF1wcVzKRbJgCjjejqIt2
 8Baf885tp9maj0UwmfX/FbgTrX3loNdfeCxRii4NzhJJQvhHW0tysyceNoV/ZyZ90C0E
 v43sVOndQbTrWzlrbpLng08Lzq9NvpGnT3DBjktxgRDr5nQTO54PETnnOg99opgKf1Vh
 Rwo+fxY6oSEkZr6YuUthYzBm4h51EfbOPGM0PufFB/6UN2toF6Mz4LzAwiaqLDSvsq5M
 rZI3ibqJpGoAcbJPxv//mfVfLsyTXDa6HbKu/vA2Zn17umtYKEa06FJ3HR/INSw97ODe
 xrbA==
X-Gm-Message-State: AOJu0YwxHTNAXsb3uku5L/gZl0iVzy2bz3YcFqbxPRDh77VaiMVguyEh
 A7vLcag75peW9hUS47enO1/9h9dbGI1Y1ACKpdvLQ432WpaXJPID75yxOv1kMGjXKpD6o/PK+EP
 kawIvx7iA4Zt0CuiHyUFKQjqVmPKOYiFWxgI5n6oqdZniVldoEEzIEZi/N47zR8JJeC7s06S3N+
 xg8wXmiAgvdlFRo2Bbux6BsyPiX/Y69sJ2pg+t1g==
X-Gm-Gg: ASbGncv8pnZzYDu58PwW2Nz95PrGhE1jKF35hhZy8/4QxPOGGz+CDoR4yTFGyxeLdpl
 ErFn6ddWk2xgyK9mdhEMl/Hy8b9SacfgVQAzel5upEItqpoMcchduGL9Ob3MF8PRrdbjEa7QfZV
 RdM+zNvsQ96DvmGvdAi9vljNajp1MA7Usu9whUeuLxiE4sC+7oDqw7PPus8yQ2wP7N3L1Xtkqwj
 0/dPpV8F4pwo1gA54frT5Or7544d4xzw2h4EGai6Yi4eI11mBdRUTpJ2U3ot87iq1/h1QSwOi/Y
X-Received: by 2002:a05:622a:5a92:b0:494:771a:9b48 with SMTP id
 d75a77b69052e-49f47fd22edmr278737311cf.50.1748387578421; 
 Tue, 27 May 2025 16:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkmxz03xZq2YTkX+OfVoEMdFkZJ/d8LrbKsA27FpDAo0eX3C2wreaoMlBfZ6G7wFIKYqgO4w==
X-Received: by 2002:a05:622a:5a92:b0:494:771a:9b48 with SMTP id
 d75a77b69052e-49f47fd22edmr278736821cf.50.1748387577966; 
 Tue, 27 May 2025 16:12:57 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:12:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 03/13] migration/postcopy: Drop all atomic ops in blocktime
 feature
Date: Tue, 27 May 2025 19:12:38 -0400
Message-ID: <20250527231248.1279174-4-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527231248.1279174-1-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Now with the mutex protection it's not needed anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9db3eefec4..0b4efdb7fe 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -849,12 +849,12 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
 
     low_time_offset = get_low_time_offset(dc);
     if (dc->vcpu_addr[cpu] == 0) {
-        qatomic_inc(&dc->smp_cpus_down);
+        dc->smp_cpus_down++;
     }
 
-    qatomic_xchg(&dc->last_begin, low_time_offset);
-    qatomic_xchg(&dc->page_fault_vcpu_time[cpu], low_time_offset);
-    qatomic_xchg(&dc->vcpu_addr[cpu], addr);
+    dc->last_begin = low_time_offset;
+    dc->page_fault_vcpu_time[cpu] = low_time_offset;
+    dc->vcpu_addr[cpu] = addr;
 
     /*
      * The caller should only inject a blocktime entry when the page is
@@ -915,29 +915,26 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     for (i = 0; i < smp_cpus; i++) {
         uint32_t vcpu_blocktime = 0;
 
-        read_vcpu_time = qatomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
-        if (qatomic_fetch_add(&dc->vcpu_addr[i], 0) != addr ||
-            read_vcpu_time == 0) {
+        read_vcpu_time = dc->page_fault_vcpu_time[i];
+        if (dc->vcpu_addr[i] != addr || read_vcpu_time == 0) {
             continue;
         }
-        qatomic_xchg(&dc->vcpu_addr[i], 0);
+        dc->vcpu_addr[i] = 0;
         vcpu_blocktime = low_time_offset - read_vcpu_time;
         affected_cpu += 1;
         /* we need to know is that mark_postcopy_end was due to
          * faulted page, another possible case it's prefetched
          * page and in that case we shouldn't be here */
-        if (!vcpu_total_blocktime &&
-            qatomic_fetch_add(&dc->smp_cpus_down, 0) == smp_cpus) {
+        if (!vcpu_total_blocktime && dc->smp_cpus_down == smp_cpus) {
             vcpu_total_blocktime = true;
         }
         /* continue cycle, due to one page could affect several vCPUs */
         dc->vcpu_blocktime[i] += vcpu_blocktime;
     }
 
-    qatomic_sub(&dc->smp_cpus_down, affected_cpu);
+    dc->smp_cpus_down -= affected_cpu;
     if (vcpu_total_blocktime) {
-        dc->total_blocktime += low_time_offset - qatomic_fetch_add(
-                &dc->last_begin, 0);
+        dc->total_blocktime += low_time_offset - dc->last_begin;
     }
     trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
                                       affected_cpu);
-- 
2.49.0


