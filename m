Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253D2C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2K7-0004hi-Da; Tue, 27 May 2025 17:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K5-0004h3-VG
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K4-000867-5b
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yNX4HDy6gAGu/jS6K4Tf66cqp8itUnTZH8N0AIlKh4=;
 b=epQf4fIo0bak2WdcKr0HKyRPL6Q0sIFBjqRIbzloAZM05JA64jCeKrUWnZORyPRUoj3zJ0
 lq3Q7td10Goea4B4x4ZTIqJnniMjING+1/RlgV4LemskAXN7xR3wWY0mkovz52t7r5a5rZ
 M2j/Qt4CDQomuzd34uvFcMOGVjq+1RY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ozE6QpxlNJ6fqSEAoc3YyA-1; Tue, 27 May 2025 17:58:57 -0400
X-MC-Unique: ozE6QpxlNJ6fqSEAoc3YyA-1
X-Mimecast-MFC-AGG-ID: ozE6QpxlNJ6fqSEAoc3YyA_1748383136
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fabd295d12so2696966d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383136; x=1748987936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yNX4HDy6gAGu/jS6K4Tf66cqp8itUnTZH8N0AIlKh4=;
 b=Io9hfSFfGlDAgaldKXPBgrrHNgfg5zCus20uOXUiSBFAMtnhdsuvJRWlacN1v7LfhE
 PosnpVlYVwm86tbwVNX/289+jt+fkN018+OzMb7IqlxyW0ql2Z8/dWU74MLbMPQ0+3J2
 WB9ZAEGU1VnqSh94kVzdbnCcpE0pWIvwTBkbOZDQsHMUxNwjs9iILDHGthYt40/0VN3o
 esVTLd4s4hzkhfFxtqj+J69Mi1qi3WzNohhTNVR4PXRZ7rWuxDMCr7XiZ4/uB3VVgmGj
 uLA8KoReWWYRUIKaBzNpXiy2OU9x7v1SojEjFTwW7t1RCGHwJs/omLiztqvqKtJf+e9U
 qyVg==
X-Gm-Message-State: AOJu0YxyeNDrCzOR/MuRqE5ykAHnFGLnuIAWkWqmMF3xGkGj/GilPBbt
 JGDrNa5nTxIM4SyFPVhs0DE49UJstzo6qxkftclqWo87B8AL91nMwXOGFbPIdRxIb14LHQJfemM
 Q6wq9q4LEN3910MkwWd0Vmv/121SOP/IV0ICXWiSIf5twyzPTGEYNtPAyA+uClJ7vDOGpFytHkg
 S3OHPY5RJJcd4/gTq/ky8Ff8A5VWQO4M0+RvGl/A==
X-Gm-Gg: ASbGncu7miBxoVqHc2+2LhdiDESOUgLa+gMUdAGwkOFIFWzsU5zqXAWxwHi886kUSpL
 ipmm9mLpn3xddtUyvg0ANKRNINiAS2hM0Yh5IANtsgpHsSg8DtkKtO5Lm5kV4t3hxGZ2SzKaZUg
 90xpT6AW1FIuLxy/BU9VrZzHsgoeZ+Y9icdiRoXs78mSh6GDT1QdSEvMkPIiTOqQ2w+nYshiXHT
 CeExrbhLXZ2Qj8L6XRjTyalu50LVSaTiN7Hz4fnr3KKSrAsEAsT6l+taoleKGoUDxi8taax2kpr
X-Received: by 2002:a05:6214:1646:b0:6fa:9e00:d458 with SMTP id
 6a1803df08f44-6fa9e00e41cmr182134926d6.45.1748383135651; 
 Tue, 27 May 2025 14:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG20ttPQTmZ6aiDCLBbu22z97QpXmIU0L2CXnv6N/RsAylQsXyzTzgdsx3jvsaZRMaqqfdwZQ==
X-Received: by 2002:a05:6214:1646:b0:6fa:9e00:d458 with SMTP id
 6a1803df08f44-6fa9e00e41cmr182134666d6.45.1748383135204; 
 Tue, 27 May 2025 14:58:55 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:58:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: [PATCH 01/11] migration/hmp: Reorg "info migrate" once more
Date: Tue, 27 May 2025 17:58:40 -0400
Message-ID: <20250527215850.1271072-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
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

Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
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


