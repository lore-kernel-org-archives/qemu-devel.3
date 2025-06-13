Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7529C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ54w-00048l-8H; Fri, 13 Jun 2025 10:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54r-00047l-Fh
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54o-0001TF-Qj
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eb09oWLwuSnauqTMTtyOC9YBT06C8v5NY6NTl05oP68=;
 b=LPrb0xNa6IcC5yGQW6n31n9JdwEUbJTZu91R9GtxN1GNp8v2jdn4SoFH9Wbg33kzjhWCv9
 OyCLvnREuIikGgY0xS/Ff21YUjk+jTweJfB/d8juBsfYldu3mdAYJqNLZrJYt+3rytihQ2
 k1kX138wxts8V8JyaOO+D0MOn+DzphQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-rH5nKDPBNou7lKXnXqF4Bw-1; Fri, 13 Jun 2025 10:08:09 -0400
X-MC-Unique: rH5nKDPBNou7lKXnXqF4Bw-1
X-Mimecast-MFC-AGG-ID: rH5nKDPBNou7lKXnXqF4Bw_1749823687
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fad29c1b72so30499466d6.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823687; x=1750428487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eb09oWLwuSnauqTMTtyOC9YBT06C8v5NY6NTl05oP68=;
 b=Pf15NDN6c9b7qSyZ3tEqHJcEtrj+ZhO6mp0YhPFaNTpzTp/AYhluF0AuaDdFrtBMdK
 GJE2u0moS5FNPaqdjzaPU/q8FeOnSJzaDbOMR+n4fhD1WHr93dQzffYhTR8BmSr6OuvB
 Zrbn68mpreCTyDjTPYL75uCVNfBkF8IMiYB3QJaUNfiOmLpbrliEwCC5wNmrc/elbanN
 ERWLCcYLO6qepq7zRgjF1f5btIZyOKq2jCLMcHAWFOnTcYe4EAGxlP+jqJgB24TEtFqN
 JPTVcWjy97gJsLpmOZBcZciVL1DYRgyBzPNINt2FFxa2Nxtt0kxq7seAd+2Q0nFNBfoN
 7bkQ==
X-Gm-Message-State: AOJu0YxoiA4limTPH2SVb1d17go1wsktaqtJroYpBujP/K6B6g8LkMfE
 Zab456Bvc/kmQuy7Ea0MsHE1q2QnRqJkGqEeC4IgculQSqC6N37dleQtzmc+D6bMps+hSJlore6
 WLTdlO1uL9WIwOlT4d+5l34TO1ByBBvfo9kkPuWDBtPxOJ+vfxlP+ng0I7n7p+C5AbzihZGMz+T
 b767k1fbIOceLvrxsgyVT3m7vdMx4TI+4wT+vIrg==
X-Gm-Gg: ASbGncvHjk8TAzwJLijZavaF/OGhFokL0Lca50QoDs6HCMmxz56yZV51tj/PBTExCH1
 jFK5Qzi8HK8BOLv0WRIwwXADpW6EiLPTSxcvyYS2mA2A6dv65tsk66Z+U3v7eUAWpF2h8I8xRCO
 ccyvpLfVpF9JhVBLnXbNQpW2z6xPIYBXnlnh1zzuZZcGqCwdPd519sHFTQoUSXmZqHnymw2c/iD
 qyQ5t8YNe/z7DvPPdsghTpyZksn6S0vy5pLDbj91bTOP16YdWAqbkcmTd+2tmNGSyej/dyM9LSN
 a95EivlIVYg=
X-Received: by 2002:a05:622a:5c17:b0:494:a4bc:3b4d with SMTP id
 d75a77b69052e-4a72fe7833cmr59582161cf.18.1749823686654; 
 Fri, 13 Jun 2025 07:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS09x4u0ZVFzuSVZy7c0tnx6UYEilIa2/+HZTTGDi28eeJ9k+MqGdgqcReWAiJle1+nhnBVw==
X-Received: by 2002:a05:622a:5c17:b0:494:a4bc:3b4d with SMTP id
 d75a77b69052e-4a72fe7833cmr59581381cf.18.1749823686029; 
 Fri, 13 Jun 2025 07:08:06 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 01/11] migration/hmp: Reorg "info migrate" once more
Date: Fri, 13 Jun 2025 10:07:51 -0400
Message-ID: <20250613140801.474264-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
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

Dave suggested the HMP output for "info migrate" can not only leverage the
lines but also better grouping:

  https://lore.kernel.org/r/aC4_-nMc7FwsMf9p@gallifrey

I followed Dave's suggestion, and some more modifications on top:

  - Added all elements into the picture

  - Use size_to_str() and drop most of the units: benefit is more friendly
  to most human eyes, bad side effect is lose of details, but that should
  be corner case per my uses, and one can still leverage the QMP interface
  when necessary.

  - Sub-grouping for "Transfers" ("Channels" and "Page Types").

  - Better indentations

Sample output:

(qemu) info migrate
Status:                 postcopy-active
Time (ms):              total=47317, setup=5, down=8
RAM info:
  Throughput (Mbps):    1342.83
  Sizes:                pagesize=4 KiB, total=4.02 GiB
  Transfers:            transferred=1.41 GiB, remain=2.46 GiB
    Channels:           precopy=15.2 MiB, multifd=0 B, postcopy=1.39 GiB
    Page Types:         normal=367713, zero=41195
  Page Rates (pps):     transfer=40900, dirty=4
  Others:               dirty_syncs=2, postcopy_req=57503

Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 59 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e8a563c7d8..367ff6037f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -69,7 +69,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->has_status) {
-        monitor_printf(mon, "Status: %s",
+        monitor_printf(mon, "Status: \t\t%s",
                        MigrationStatus_str(info->status));
         if (info->status == MIGRATION_STATUS_FAILED && info->error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
@@ -78,7 +78,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
 
         if (info->total_time) {
-            monitor_printf(mon, "Time (ms): total=%" PRIu64,
+            monitor_printf(mon, "Time (ms): \t\ttotal=%" PRIu64,
                            info->total_time);
             if (info->has_setup_time) {
                 monitor_printf(mon, ", setup=%" PRIu64,
@@ -110,48 +110,51 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->ram) {
+        g_autofree char *str_psize = size_to_str(info->ram->page_size);
+        g_autofree char *str_total = size_to_str(info->ram->total);
+        g_autofree char *str_transferred = size_to_str(info->ram->transferred);
+        g_autofree char *str_remaining = size_to_str(info->ram->remaining);
+        g_autofree char *str_precopy = size_to_str(info->ram->precopy_bytes);
+        g_autofree char *str_multifd = size_to_str(info->ram->multifd_bytes);
+        g_autofree char *str_postcopy = size_to_str(info->ram->postcopy_bytes);
+
         monitor_printf(mon, "RAM info:\n");
-        monitor_printf(mon, "  Throughput (Mbps): %0.2f\n",
+        monitor_printf(mon, "  Throughput (Mbps): \t%0.2f\n",
                        info->ram->mbps);
-        monitor_printf(mon, "  Sizes (KiB): pagesize=%" PRIu64
-                       ", total=%" PRIu64 ",\n",
-                       info->ram->page_size >> 10,
-                       info->ram->total >> 10);
-        monitor_printf(mon, "    transferred=%" PRIu64
-                       ", remain=%" PRIu64 ",\n",
-                       info->ram->transferred >> 10,
-                       info->ram->remaining >> 10);
-        monitor_printf(mon, "    precopy=%" PRIu64
-                       ", multifd=%" PRIu64
-                       ", postcopy=%" PRIu64,
-                       info->ram->precopy_bytes >> 10,
-                       info->ram->multifd_bytes >> 10,
-                       info->ram->postcopy_bytes >> 10);
+        monitor_printf(mon, "  Sizes: \t\tpagesize=%s, total=%s\n",
+                       str_psize, str_total);
+        monitor_printf(mon, "  Transfers: \t\ttransferred=%s, remain=%s\n",
+                       str_transferred, str_remaining);
+        monitor_printf(mon, "    Channels: \t\tprecopy=%s, "
+                       "multifd=%s, postcopy=%s",
+                       str_precopy, str_multifd, str_postcopy);
 
         if (info->vfio) {
-            monitor_printf(mon, ", vfio=%" PRIu64,
-                           info->vfio->transferred >> 10);
+            g_autofree char *str_vfio = size_to_str(info->vfio->transferred);
+
+            monitor_printf(mon, ", vfio=%s", str_vfio);
         }
         monitor_printf(mon, "\n");
 
-        monitor_printf(mon, "  Pages: normal=%" PRIu64 ", zero=%" PRIu64
-                       ", rate_per_sec=%" PRIu64 "\n",
-                       info->ram->normal,
-                       info->ram->duplicate,
+        monitor_printf(mon, "    Page Types: \tnormal=%" PRIu64
+                       ", zero=%" PRIu64 "\n",
+                       info->ram->normal, info->ram->duplicate);
+        monitor_printf(mon, "  Page Rates (pps): \ttransfer=%" PRIu64,
                        info->ram->pages_per_second);
-        monitor_printf(mon, "  Others: dirty_syncs=%" PRIu64,
-                       info->ram->dirty_sync_count);
-
         if (info->ram->dirty_pages_rate) {
-            monitor_printf(mon, ", dirty_pages_rate=%" PRIu64,
+            monitor_printf(mon, ", dirty=%" PRIu64,
                            info->ram->dirty_pages_rate);
         }
+        monitor_printf(mon, "\n");
+
+        monitor_printf(mon, "  Others: \t\tdirty_syncs=%" PRIu64,
+                       info->ram->dirty_sync_count);
         if (info->ram->postcopy_requests) {
             monitor_printf(mon, ", postcopy_req=%" PRIu64,
                            info->ram->postcopy_requests);
         }
         if (info->ram->downtime_bytes) {
-            monitor_printf(mon, ", downtime_ram=%" PRIu64,
+            monitor_printf(mon, ", downtime_bytes=%" PRIu64,
                            info->ram->downtime_bytes);
         }
         if (info->ram->dirty_sync_missed_zero_copy) {
-- 
2.49.0


