Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A0AC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDH-0008LR-5r; Mon, 09 Jun 2025 12:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDF-0008Ki-4R
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDD-0004TS-2R
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GftW69IoIvz/x1xZNVGzz01cczNmp8jYtfQ1Gtjwb0s=;
 b=OYpcFNJeZYH0O1PbprcQheFZ3r1j8DfhabjtbjQR+YSqrI5nxsP4QS505xf0+i5B4mzSYO
 Vhno7ikpL9IyQ6x82rOHJ9w9Qg0kTZi6/RcrWvKWVIjiTrlC6qr4JvQyh5SOSpOedp51b7
 QijABUT2J311alCf/uR5eVyK1aqt3cw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-f6GpiiGCN8q2REjdlCZUgg-1; Mon, 09 Jun 2025 12:19:01 -0400
X-MC-Unique: f6GpiiGCN8q2REjdlCZUgg-1
X-Mimecast-MFC-AGG-ID: f6GpiiGCN8q2REjdlCZUgg_1749485941
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fad8b4c92cso120102506d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485940; x=1750090740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GftW69IoIvz/x1xZNVGzz01cczNmp8jYtfQ1Gtjwb0s=;
 b=NPeFrNMhnyvaw1O3EogS9AWFx0lk2szjLpeXPRL9otaqiQxcBLzYtMByP7H5Uhksca
 REYcrieNmVULrX0INRkMthL/sPFqh81J/G3ASavgltironf/bRApaHgdo7fc4ClyLu4W
 ib0Wff8nKg/f3UXzWp1RYS00P6dwPsg9jkB7iHf5lDWelBXVcyZmzBXEykaMtoFGuFfX
 TwNeu+Cra6ZIs9jQpz/VoxaEqnVXfYBRDN/6C6HSpgmbTTnCJdhgRhoSA75vrsvMi+5U
 bD+RqCroySsxfx78/eGAYCsApumOoat1w40siTKK7GxoLmcL9s5Wb/sTPdIXVUsO7+wS
 HBbA==
X-Gm-Message-State: AOJu0YwMknAVE8WIXp9L74yTO4AqHE7jYIkl45GrG8G/7BCRNyFxH3sf
 kJwur7oY4apGf1SNicbWw1JfU8r9WryJr16WgqQaD+aCsC7GH9U4S5XXIda/Vpyxx3exOLXAk21
 HlXCC6mlJFPPMmhN5JOabffmD+zAEXWzmwrLkZ2ABaUTJ7k1UMjXi3HtALLOKHnBQkjI/jQoGEC
 HxSxPQnnPJN2BO8CmkAZ132WiCCcS8yHcoJbHU9w==
X-Gm-Gg: ASbGncsgTXZRkLl14itQgK9pWf4k09eiIXTiKzPSm7sIuKXj+eqsl37K8ACwvwhXNI8
 LTiRJi+Qw0H1RPLyEX4u04R3J7XTtd9lxUWyhfr76NPp2Ua9chYHnK0awx9Z8hTJMJizTYW/Z9m
 iWohKE6B32wDDyCUIsuTRnRoTmqnBbh74FxujCKwgaZ9Edaet8iNe9UvZHNvgV5qDAtOtRJa49K
 x3OF7llxODcM61p8z4aw5aTZ4L5TitsBRSKkr9CKIdBGfvXaJbfwOdl0yP4bBKBtK1QJhYrXTyC
 ocjZ2+rVKXAasw==
X-Received: by 2002:a05:6214:2602:b0:6f2:d25e:8f60 with SMTP id
 6a1803df08f44-6fb08ff5e10mr211735876d6.22.1749485940047; 
 Mon, 09 Jun 2025 09:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnLeSdOx25LaY53ALmIXXVSy+ck5Ba7YjZp22VZpyisx34lDsQcaTnx0qjm0XMOIlWIMfRTQ==
X-Received: by 2002:a05:6214:2602:b0:6f2:d25e:8f60 with SMTP id
 6a1803df08f44-6fb08ff5e10mr211735476d6.22.1749485939646; 
 Mon, 09 Jun 2025 09:18:59 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:18:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 01/11] migration/hmp: Reorg "info migrate" once more
Date: Mon,  9 Jun 2025 12:18:45 -0400
Message-ID: <20250609161855.6603-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
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


