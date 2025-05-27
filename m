Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C865C5B54E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Ty-0003Kf-Gi; Tue, 27 May 2025 19:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tw-0003K2-Ee
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tu-0001FB-Nn
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkow7bJAoDRkD+7zEweB6Ohhgw4J10hl2WnPvcpjD+M=;
 b=JOgJpJh+U8DFUrQbFRcP3/I12X4Ni+8XnyagfZuUoUs8YiAsfN4aE3l9/NUgYbRWKhxZ6z
 UFy6CW/uR+ICW3Frlb/XtSSp3EKh86sG+hox1Ri1lxD/+2HcVEJPar8+Sam1nJWU4C0uzK
 kKJaR/BaSRtN7RYqgrfoYeQ1lwwkCd4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-oXgp6TKLOrSwR8XzZth-BA-1; Tue, 27 May 2025 19:13:13 -0400
X-MC-Unique: oXgp6TKLOrSwR8XzZth-BA-1
X-Mimecast-MFC-AGG-ID: oXgp6TKLOrSwR8XzZth-BA_1748387592
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4767bab171dso34759001cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387592; x=1748992392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkow7bJAoDRkD+7zEweB6Ohhgw4J10hl2WnPvcpjD+M=;
 b=CnTMJiMaVGaNLdiTjGqM4Ckk247vQ/3CEkDhsCCSiOqEIlBTytLY5v0AOZz4tr9kby
 /AAah+BuFdzogpwppprIyzUYDynD9Z/ElSMb+iteaHcGGzeDL86ITCyyBEkaLzRoXpYV
 vXNq+JKGd41dti0GdMmUj+HhSGSSGnl/utPe4ukifMHcP+G74LqPhHcmbGzXic6xItsV
 6KgmmhvgrKC7xu8x7+icEKFvozZXei9+JXsnm5J/3Q4RwGZehoJpR6j+NWnhJSref+Lz
 qNyOm4DKHQQ9aSkdPA/22F8DXIEyuTa+GfU2U6FOJbJ+QTak8T4GP+nYPGaDIS/Ew4m4
 y8Hw==
X-Gm-Message-State: AOJu0Ywei6IkITYca3n0qbm+J+jFLQCZBVKg1M8dhkfIHwa8AWZaKjMh
 +7dzzi2sTYbogFxz5/q/AazkbeiGJhVJrWLpdyqQjZyv2333MhpxQGh+/Rk+xDU3h/v/d8GNf0q
 Fi6vyc8dKwEbeua/9dAHzSnlBBMVMdUxh3EKjeoblVHDwGtZAoYXuoer2ALZvQm0gb78rcdS7AE
 KVulEz1fSnAOeGH0fP6FmDFulHH/bQ/ZpAXvJhvg==
X-Gm-Gg: ASbGncuh5M5jND+L1XMJZghOMylK0sTP1QUx1Lw+dfuxcnUY6xB/ld594k5geFq4kTm
 arOqnaUZnpxreL9E54ROvOUhbVSV5L/f/D6mcpSIMKwuajKR8BUXRsluk7Y3HFsl30Us5Tg7YZf
 iB0mujhmnwKIUoYclhucHlTyhWJOO03DpsI4nMGDwVHSGS3q5++1SlG+M9h3s1ak7iKOl0ZHPnY
 b+VvXI0s3D9LsXkEN5XnYBReV6LtO2v8ntyU0bWNML1k6bkx4QaFGEdCNb2l68v8NKs1NqQQw+/
X-Received: by 2002:ac8:5f50:0:b0:476:c650:9839 with SMTP id
 d75a77b69052e-49f480c8e90mr205323581cf.51.1748387591984; 
 Tue, 27 May 2025 16:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrB994MjlBWSyEW7RUmyuJQ+6qdDxjFvly9oZdxyaUfj5ov5EhCdPrDH/CveqGnLlmOvG8lA==
X-Received: by 2002:ac8:5f50:0:b0:476:c650:9839 with SMTP id
 d75a77b69052e-49f480c8e90mr205323191cf.51.1748387591536; 
 Tue, 27 May 2025 16:13:11 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 11/13] migration/postcopy: Cleanup the total blocktime
 accounting
Date: Tue, 27 May 2025 19:12:46 -0400
Message-ID: <20250527231248.1279174-12-peterx@redhat.com>
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

The variable vcpu_total_blocktime isn't easy to follow.  In reality, it
wants to capture the case where all vCPUs are stopped, and now there will
be some vCPUs starts running.

The name now starts to conflict with vcpu_blocktime_total[], meanwhile it's
actually not necessary to have the variable at all: since nobody is
touching smp_cpus_down except ourselves, we can safely do the calculation
at the end before decrementing smp_cpus_down.

Hopefully this makes the logic easier to read, side benefit is we drop one
temp var.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4fb1d92d7b..b76ce6b363 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -971,7 +971,6 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
-    bool vcpu_total_blocktime = false;
     uint64_t read_vcpu_time, current_us;
 
     if (!dc) {
@@ -993,20 +992,19 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
         dc->vcpu_addr[i] = 0;
         vcpu_blocktime = current_us - read_vcpu_time;
         affected_cpu += 1;
-        /* we need to know is that mark_postcopy_end was due to
-         * faulted page, another possible case it's prefetched
-         * page and in that case we shouldn't be here */
-        if (!vcpu_total_blocktime && dc->smp_cpus_down == smp_cpus) {
-            vcpu_total_blocktime = true;
-        }
         /* continue cycle, due to one page could affect several vCPUs */
         dc->vcpu_blocktime_total[i] += vcpu_blocktime;
     }
 
-    dc->smp_cpus_down -= affected_cpu;
-    if (vcpu_total_blocktime) {
+    /*
+     * If all vCPUs used to be down, and copying this page would free some
+     * vCPUs, then the system-level blocktime ends here.
+     */
+    if (dc->smp_cpus_down == smp_cpus && affected_cpu) {
         dc->total_blocktime += current_us - dc->last_begin;
     }
+    dc->smp_cpus_down -= affected_cpu;
+
     trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
 }
-- 
2.49.0


