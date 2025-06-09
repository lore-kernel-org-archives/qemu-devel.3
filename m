Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08758C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvn-0006MU-BG; Mon, 09 Jun 2025 15:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvl-0006La-BQ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvj-0000pP-Bx
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNCKiYlI5hKeIag9Xbo3Ck8I0JoyXUXuzmM9e2pEd+Y=;
 b=IIWuMmlVERJ67z3hmkM69x1Ik+x7U3JMMvOxUSzzr+R97vTLuydmJLJ2YGok0rbflofOjT
 9TLQTQCIpwzn6YentNg14xJ+fmD2OYFXsjM8pRaWvSKrsbG0vHAGqccJhWclmxXjSzbzL5
 dY9/N/zEyLxsAMJRUGjWmSZmg+uuWdA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-GshyWNFsP62ScvLKgBKTyg-1; Mon, 09 Jun 2025 15:13:08 -0400
X-MC-Unique: GshyWNFsP62ScvLKgBKTyg-1
X-Mimecast-MFC-AGG-ID: GshyWNFsP62ScvLKgBKTyg_1749496388
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fad5f1e70fso88544536d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496387; x=1750101187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNCKiYlI5hKeIag9Xbo3Ck8I0JoyXUXuzmM9e2pEd+Y=;
 b=FD3//AWmPu/I3uGopXltL3UDdPt7yQP4pqQUkPKKCF9RVzR0rNYPznpKTe1w/+nGig
 eynYdHxWz2Qpxfeg9dVvhbBJh+fEAydTGVp5ovmnveWR3N7FPM4dYJe+9LZuXcXVWg1i
 bQS3rnxnJ7MpB8n8P4YFgiXMAZqkzA+1hOxN+iJKi+tHkQy4FX34U0UIV1qDRIFcP3Nu
 qH9Mj4peiu9r6P8rCRydlx+BHaCy2zTp2wMp0ykRWpJmg84uCxtlgm1hBOonvzB9xWS9
 TL1kIck0XJXR6M6+si+D6nqWFZ7C1Ide7XA5YWIcVDHmcxv/nfilr75p8A46jyfrAx/+
 5PBA==
X-Gm-Message-State: AOJu0YxskjYdl6KanE/3mAOpUqEJnwU6zCDaPlWpLGiH/aSPOFXdjn7N
 bl5IRaYQYKItagi/ofiwlXXwV9UbzsPiJatN5qtXLKkXVJ8of0ZYKTJk/yNcymkhmyhq8WFtc04
 humpUwQEAeMR2jgMl7dtXoPHsuBtmOcPpLDPW7G61vIn9m8J8T9tC7d4/066W+s8jQ2KLD5VlhY
 MkG16E+EQGoVwvvKu1LUPtT5oaUoTBuidwcHvccQ==
X-Gm-Gg: ASbGnctKgPhN0PfT26RQ6RuWNB0Cma9NbFgnCERARQqTPC745RGQLju2VEXH3zeGQIK
 qwJrXNYBEMOljBbsG33iKlUiOqQ+LFwFC3d7NoihLtoyaLA8nMjmCEOjyZrgUD0OBBnPTKoj/Fj
 DLm4NXkccqs0uSZcslCegAsnbmP+6tEsdHdGjnP5up+M0mHs9s1NmS4OnXsNKHWo09zpI8cA/Lh
 XQx4CBgl5i4k9j8tVq4Av8XPxyeTjSEjCOLO2Mo6/VsZaPNrNvn5iT7O0KZi4PKLDTJL2HMljUl
 +j8=
X-Received: by 2002:a05:6214:212c:b0:6fa:cce8:3bdd with SMTP id
 6a1803df08f44-6fb08fe3710mr266978306d6.36.1749496387259; 
 Mon, 09 Jun 2025 12:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtjP+VLSZY/RFudtU0Y4JXbKGU5irGTdlhtNaorDw1G1fIpzVgev9zs/YHdNi6B3eNCMAYsQ==
X-Received: by 2002:a05:6214:212c:b0:6fa:cce8:3bdd with SMTP id
 6a1803df08f44-6fb08fe3710mr266977746d6.36.1749496386705; 
 Mon, 09 Jun 2025 12:13:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 03/13] migration/postcopy: Drop all atomic ops in blocktime
 feature
Date: Mon,  9 Jun 2025 15:12:49 -0400
Message-ID: <20250609191259.9053-4-peterx@redhat.com>
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

Now with the mutex protection it's not needed anymore.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 32fa06dabd..81925532de 100644
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


