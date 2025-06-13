Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215FDC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59M-00042p-JH; Fri, 13 Jun 2025 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ598-0003st-PD
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002Jy-Nn
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cax0HF/e3FLRBTL6vfyxA7ugDSdkEzjc448UZATJ/g=;
 b=cIWjcwwFmV9OJpjYRILOF9dX836+aEsQmaTbrIopDNxV2hCwWVsGx0iBshtvDWNpXzP9HE
 QLlUVSixDNSVnuc7k/lZQaXWa/huInmWLUA1B8War/91e44dgyfd89eVX1ybO9lAKf/PYJ
 830hBWHam0xaBe/25+e3W0BkX5cMtdg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-1ag2WnTUMUmp73I77sLflg-1; Fri, 13 Jun 2025 10:12:34 -0400
X-MC-Unique: 1ag2WnTUMUmp73I77sLflg-1
X-Mimecast-MFC-AGG-ID: 1ag2WnTUMUmp73I77sLflg_1749823954
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a587c85a60so43410371cf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823954; x=1750428754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cax0HF/e3FLRBTL6vfyxA7ugDSdkEzjc448UZATJ/g=;
 b=Nn+s7gZLcrXAVvpCmT/5DHtfOExWbH58mjRh6RAElpZlSC82cAWoTKu/1sMpOaq0Ab
 OSjSYn0Ve3qPzLXVlmFXM1H94cFEsqLwcFCNIE3/7nx8xk91CslTVwDkuQaVvQe12V6t
 JKZciAbq2Jmkcz+CcX/LMELHjrUhemuA+PQSdJtRBlrPAWdidiaLtSY0V336AeQIE01z
 lytEkzJweHCTkVm+AMyl/VESKmj5iLJnc9zgmHQd2NFU1UxUghWhGQ7Ajq8Gqgrd+WJQ
 vaYQcpSEqGHpQ6J6/XIHPac+toHjAYGP7M0820DIEVBcaIWV0WR0wFWtTm/WZ6VwH8bb
 NDlA==
X-Gm-Message-State: AOJu0YyrqkAH6bncNjQ42W8eifc0thtx3xbEX2JzhgKk0I23U2FTEk04
 gFwH2S0k/0SI1OWNjkHigksUMciuNJjxDzSlfI8gXeQHD0U0CJQyar+AVP3+FoiLKXjuEs5jQS4
 98JCv5FDW050UdE3tP3/JT+vEkHPRiHa1fEW3APkWA1EC04apgUfqW1ie2OW641wTIbNuY3i/uX
 OIzSYaJ6UFuWQMdS9vmYfhybHiLbNoHcFyeeXlVw==
X-Gm-Gg: ASbGncs0GsL535adWdG0aMZuNdtWXQ+vMt4f/jzrfuoQamBrIzBbzs3egO1+7ASBlxc
 ofPrzX5svdbMvjHLHeDgTGta+EqY+J4xs3qKMzgsShfiIJkIFHXWSN8qhnUZUN3YkOxyGl+f9+Z
 DetOMw4WW6cbz0bFKb3NAcXgQeslBZEKPd4gVhB0fW9dCP2UN6hDRc9egYmmZcWetaw3VztZMP0
 MfuPH/bjBQTEkwuhGulnnLdMiApK+bhCfgu67J3gMs2rGpVh/cJBJBUP0lGuRTA4ml6caGe0e5/
 0zx5lMknvfw=
X-Received: by 2002:a05:622a:1bab:b0:4a5:a96d:6068 with SMTP id
 d75a77b69052e-4a72ff14f67mr51978121cf.37.1749823953719; 
 Fri, 13 Jun 2025 07:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWGTu7xfM196+tmFJUPgVdX3/G/Y269iBTqvgxx1Q3GV16Y12YHNQJOzRgQ0tzJ2WZsKoRng==
X-Received: by 2002:a05:622a:1bab:b0:4a5:a96d:6068 with SMTP id
 d75a77b69052e-4a72ff14f67mr51977651cf.37.1749823952984; 
 Fri, 13 Jun 2025 07:12:32 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 11/14] migration/postcopy: Cleanup the total blocktime
 accounting
Date: Fri, 13 Jun 2025 10:12:14 -0400
Message-ID: <20250613141217.474825-12-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
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

The variable vcpu_total_blocktime isn't easy to follow.  In reality, it
wants to capture the case where all vCPUs are stopped, and now there will
be some vCPUs starts running.

The name now starts to conflict with vcpu_blocktime_total[], meanwhile it's
actually not necessary to have the variable at all: since nobody is
touching smp_cpus_down except ourselves, we can safely do the calculation
at the end before decrementing smp_cpus_down.

Hopefully this makes the logic easier to read, side benefit is we drop one
temp var.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index bf65d6035c..fd6c0bdb1e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -972,7 +972,6 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
-    bool vcpu_total_blocktime = false;
     uint64_t read_vcpu_time, current;
 
     if (!dc) {
@@ -994,20 +993,19 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
         dc->vcpu_addr[i] = 0;
         vcpu_blocktime = current - read_vcpu_time;
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
         dc->total_blocktime += current - dc->last_begin;
     }
+    dc->smp_cpus_down -= affected_cpu;
+
     trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
 }
-- 
2.49.0


