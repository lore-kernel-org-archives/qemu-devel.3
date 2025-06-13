Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9FAC71151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59M-00041y-4S; Fri, 13 Jun 2025 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59E-0003vd-Lh
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ591-0002J1-Ry
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNCKiYlI5hKeIag9Xbo3Ck8I0JoyXUXuzmM9e2pEd+Y=;
 b=a/qkvQLmgPpq68XC3QWbq/SVit02GcIshhmM5AbrqR2TmKXnZW+c3iBBj5mEVW7NsQ9x6s
 /O3Hj/WozS4uocBakS88CtldtG+trcuS3lDjrngjPVsAmmGFe+BzA48biqKlpMFmiINsdm
 zvQv97t/MBx1Sqz/VrJ81ZopP7i7vFk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-22hkobuYPXOgTjF5iA6drg-1; Fri, 13 Jun 2025 10:12:25 -0400
X-MC-Unique: 22hkobuYPXOgTjF5iA6drg-1
X-Mimecast-MFC-AGG-ID: 22hkobuYPXOgTjF5iA6drg_1749823945
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4a6f89098cfso46552051cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823944; x=1750428744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNCKiYlI5hKeIag9Xbo3Ck8I0JoyXUXuzmM9e2pEd+Y=;
 b=N45wzE6NK1usgGRykG505kJtFawy8uMdlUXFvdUTXvGqB+vBXNCP2URV5JOsdPtHOb
 wwLD1MhcZLvmM5ixgdLacHthD1/ETVxrDnh004Py8QOWYiALdueRoL72LCrD0LcnC8+Y
 LSnD6dMmihaROofJmNnACktLsmZLT0Cox+pZlQJZyuRz/czhtxbZZRdB5POApN4uKmLC
 gB0yAUAOh2C76SahlH0yKfB9gxV7TX3nV29bdTBHRiEMMNy4vFep6goP4lZqpDoUt5+5
 WOdy9uQ+UQ0RasmYyeNeCb1n8W4PCkJ6we1ESU/27nRHoQMtkNgOgDSl3oTh+wacX5DH
 BzAA==
X-Gm-Message-State: AOJu0YzRMso9s7enBJCzuOIStPfgEClvm8WXBIrvciDP8JcegvPbObjz
 1aaiVD0360w5a5/yA9wmX4FtDQcI6RBk8MlvJXpWwlc9ZbDxcRA0RbRF05MUlVihKzCVJNz2Sne
 zwHD/BsCCheZEa3KN+IEp+w5KLwEIlSSBk48Jpzhi7t6RQYp9atgy1j/PeoZ6DvioAsZNQoMhaB
 MhSWxWJ7WvCpAYZd8tQihMgISTRjURXfj+/yRVtQ==
X-Gm-Gg: ASbGnctXSLnif6MhpJL85OmWsZHwmst5n7qpLpOeW1yrCIh1Y3DJUcT8MAUWFVdYRs1
 2BoNehdttzF+aNEFsjdHwXpdeE9F/wmg1idKCHOXF9RKApJ74s5PlgXmll8J6w+mXcw9f4AIZGS
 DbBsjYvQsfCsZDp+SHJ7acV0ZZL7ISNmy4fqvJPe55p6Qa6Op4tGv/A0MOWCtPaCt9lo/ADUMaq
 DwRlq5qQrHjeBypxUAOw1LIbd1rpcimf3se+BYNDupYObjzw4Gd9GdTroI2X9uzJIpVhJYLcn6Z
 vySP/lkDF/M=
X-Received: by 2002:a05:622a:4d4b:b0:4a3:6cbf:1fb4 with SMTP id
 d75a77b69052e-4a72ff0d5a6mr50272231cf.29.1749823944302; 
 Fri, 13 Jun 2025 07:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiXoOpPm01lpb47ZmlqFFoRtHHkNpqpNWhlhHDDapWkfbGuzsXXgwIQnsrFityAnIwjRLXSg==
X-Received: by 2002:a05:622a:4d4b:b0:4a3:6cbf:1fb4 with SMTP id
 d75a77b69052e-4a72ff0d5a6mr50271711cf.29.1749823943631; 
 Fri, 13 Jun 2025 07:12:23 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 03/14] migration/postcopy: Drop all atomic ops in blocktime
 feature
Date: Fri, 13 Jun 2025 10:12:06 -0400
Message-ID: <20250613141217.474825-4-peterx@redhat.com>
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


