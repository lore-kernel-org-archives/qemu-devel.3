Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26482C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhw7-0006Qw-1Z; Mon, 09 Jun 2025 15:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhw5-0006Qm-Em
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhw3-0000sr-Rj
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iq7xbPIA+CJC8vrhFn6C8E+xdY4lZ0qyjDI51Wr01Ds=;
 b=XpCSnjSa/gRdbEcnBKIwKm6cU1eD5+I9Kkb/Pho3yrofMG5bfPNgqJv5Nk1V3GCrJa7kfw
 vy9+u5mXLaZvsdgqoSif9I5/FwO/dHbNC8UrWxak9e/BrJnE3Ci30WqrKNk89Tqqu+xeYK
 /Ea4ADpln0wd7/s7THxpV9JOB+vFJmE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ps7BqtPTPeSuZVDqb3h4hg-1; Mon, 09 Jun 2025 15:13:30 -0400
X-MC-Unique: ps7BqtPTPeSuZVDqb3h4hg-1
X-Mimecast-MFC-AGG-ID: ps7BqtPTPeSuZVDqb3h4hg_1749496410
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a6fb9bbbc9so50102201cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496409; x=1750101209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iq7xbPIA+CJC8vrhFn6C8E+xdY4lZ0qyjDI51Wr01Ds=;
 b=Oa1pzDn0g2m+NTlFx4OFZn5eLPkz36VK996BGFJxwCYvrRy0LiCQUTuLzskJq+FNU4
 b8Y8Nz12qDgYg9P11adb2j1Ewn/5+Lb74G56uswnbYBZP/0HIp9hBfFdrjOWz/mkKIwB
 h+yKKaHgT7l+XGua5sAKJxr2MsRkPKmQbmGMLy+iNfaIjRMsmK4aoLnOHkiPvcjRC+Ex
 tpgvMQvSsKLqjhi7IMsF+OQ6EyyMyfjnsqoMZENuPcEu43g8BDvc6ZX+0cOge76ihV17
 oV/JKN9Zfh/IIJAnJD9Iw8CvwQriqN3pavKSIlIX5MYGV7ol6x8jR7Wui3xeaQxquMs+
 7AyQ==
X-Gm-Message-State: AOJu0YzGOBrF38mN0gC1IJX6MHNaCnkAdwDtFq6DDitPxcqLYhSWXkYC
 ychTPz1LTXMfpC6SFgWtvWCOpPfv4b6cYh6WtrtGVD09RDVyr85IEtRV7sOlTYoGRIP9z9zlb09
 ZAQEcZyvdL/PMVHdtyYwxqyBkGNL1fDqfOkgJxTH36CkxHKlm8e7fqd+eYnnaevztKhBNCNcGN6
 n0ZTSjkBMrUeVvTJOR4s10PhVgZBkZNWEsQVeN7w==
X-Gm-Gg: ASbGnct8kYNGHv3ze1OqO8Czv8kRM6SOL5MDWVw5Renbi5g3tNlH2nWClYaNGo2g+1y
 cgZbWiHfB3+EirdA2o2GTYZ+Nbcpw8N/FJjo/buglJ/ChtGbci62FaBPxVdXCNKgq8xJUsuHf1m
 CK8vEfTA/LNJfNzYh6bVnT4H2hmlN4VtX9+VVrtm9YKyUKAm++6AZSvtbymHqZluEfvo89D8R3j
 1lukwP1uZ3xkNazCMRd6KfAYiQXEDTeTuG1KpuWnHeKYpkQI2fphLelc98THQ1qV8/+ui9ai7Tg
 Gq8=
X-Received: by 2002:a05:622a:5984:b0:4a4:2d7a:994b with SMTP id
 d75a77b69052e-4a5b9a436c6mr293068441cf.19.1749496409255; 
 Mon, 09 Jun 2025 12:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVFP7RKaP8qjzzj/qm8SQhdvvZeGhwHLlxFYLVPRYHFLP1P6x/L+0ucwCY3M7uPzPpl+30XA==
X-Received: by 2002:a05:6214:cc5:b0:6fa:ce21:cad with SMTP id
 6a1803df08f44-6fb08ff4381mr223557446d6.18.1749496397568; 
 Mon, 09 Jun 2025 12:13:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 11/13] migration/postcopy: Cleanup the total blocktime
 accounting
Date: Mon,  9 Jun 2025 15:12:57 -0400
Message-ID: <20250609191259.9053-12-peterx@redhat.com>
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
index 494bfbab71..f222239c7a 100644
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


