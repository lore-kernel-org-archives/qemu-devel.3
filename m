Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9223C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uExoo-00060Z-0o; Tue, 13 May 2025 18:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExof-0005zC-A0
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExod-0006Ge-8m
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747174174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2OZvDlJsc5V7iAtEB+Ve0xlxaeX2GOqMGPYkHqennE=;
 b=g4EkasYos27XjwJ4A7RmaZfhUCvUgvb8r7S3Gky/sOncL4aA1yety3ouJ1BKN/CuVvARfZ
 KjWb3op0a//bhxxtEyiVzrvyT7YJOpFY1+QSkcq7MHrkiL2R9mL02Sg2BHiKczH3nKu/Zm
 VUgPnOuN8IW/TEh+b545WUCkiaOrht4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-MYKRWA0yOUiTdG1oKYXhWg-1; Tue, 13 May 2025 18:09:33 -0400
X-MC-Unique: MYKRWA0yOUiTdG1oKYXhWg-1
X-Mimecast-MFC-AGG-ID: MYKRWA0yOUiTdG1oKYXhWg_1747174173
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6f53d97079aso204645376d6.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747174172; x=1747778972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2OZvDlJsc5V7iAtEB+Ve0xlxaeX2GOqMGPYkHqennE=;
 b=vr+4vo3D0LHAU7vUlszC8gqpLJuuIChmKr0NHMF13JRlh6IXaIG9iyc/genE+9RiJl
 mA3Md3oCcaWrfK9bLOuCK4sw+yk0rkS1VqLoS6NMKO7X2mGPBJDIojJn7qsUCX13G+3K
 9cq8CvTPnqkjhnRQlSlnKwbLi7JNzIqM+OxyaudYAiw/prn8Nxqy3BrzVl697NNFg2mx
 Ka4eYUJqn+yb0wg9g81mbHPZzGRQg5qb+MT1q9eW3Fb+QZqtxnp0UcwLPUoo7hMk42PF
 5H8gQzc0AQxacbX1E2JcOXJ0KDzTbdR30QluPNhTYzQfGFNP8e5p1gpKpxxP8JddBcTf
 /cJQ==
X-Gm-Message-State: AOJu0YxgGg94ZyGCn4MT+U6dlAgctinRpvoTzkKcOIHoMCuxrEPqbs66
 Trctao56Zv+mkhOdbWuhq1dDNwLPbC0gYn56vZ4B0NEQUbPCb0LtaahSs5AGVHqyp3Eq+trC2SD
 i/y9yj8y8v0hk8l2HgZNnwPxZpGH7nBO9Yt1zhx+HyWJFfNGC2bSjuTZLmEKZPIFSZi2WRihuyg
 nZLFZ8YXpF/NxcvAAAkaCGXfHtOe75Vy99nw==
X-Gm-Gg: ASbGncviByZjAUkjq9vBgn1ZmyZg/cLTblzp1lDT9ou2hvTAH0rUF2/xKeCY4vDQXpg
 UQrPLZFPdjDWiXhCdeRJvpnlzheXh2BlAvjEovRh7b1zN/2B9A1o1eWXyKmCdp7pDRyv7bSt8w4
 HDtvccsBr58UtD16G93Htfei37x/zR75kGOROs+dW0AwuPMVn5/tIhjDZaO8u3qUoO6XJHzO05s
 DEMRWrK3xCxoqi7gJyrabWDLs8nPz5y3X2NoNd1R4drK36Y0Z/maUuW+aDBfDd8H0atJS88OR8D
X-Received: by 2002:a05:6214:5007:b0:6f2:b0a7:3982 with SMTP id
 6a1803df08f44-6f896ed979dmr18868456d6.37.1747174172074; 
 Tue, 13 May 2025 15:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvuJx1AeXjmklS8rbujyu5b5WTeHiI/WUYSo/N9Qee40U5NzmH6x+2o2WyDUWgpnxyygiHXg==
X-Received: by 2002:a05:6214:5007:b0:6f2:b0a7:3982 with SMTP id
 6a1803df08f44-6f896ed979dmr18868076d6.37.1747174171674; 
 Tue, 13 May 2025 15:09:31 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a0c5e3sm71708616d6.63.2025.05.13.15.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 15:09:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com
Subject: [PATCH 3/3] migration/hmp: Add "info migrate -a", reorg the dump
Date: Tue, 13 May 2025 18:09:23 -0400
Message-ID: <20250513220923.518025-4-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513220923.518025-1-peterx@redhat.com>
References: <20250513220923.518025-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

I did quite some changes to the output of "info migrate".

The general rule is:

  - Put important things at the top
  - Reuse a single line when things are very relevant, hence reducing lines
    needed to show the results
  - Remove almost useless ones (e.g. "normal_bytes", while we also have
    both "page size" and "normal" pages)
  - Regroup things, so that related fields will show together
  - etc.

Before this change, it looks like (one example of a completed case):

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
send-switchover-start: on
clear-bitmap-shift: 18
Migration status: completed
total time: 122952 ms
downtime: 76 ms
setup: 15 ms
transferred ram: 130825923 kbytes
throughput: 8717.68 mbps
remaining ram: 0 kbytes
total ram: 16777992 kbytes
duplicate: 997263 pages
normal: 32622225 pages
normal bytes: 130488900 kbytes
dirty sync count: 10
page size: 4 kbytes
multifd bytes: 117134260 kbytes
pages-per-second: 169431
postcopy request count: 5835
precopy ram: 15 kbytes
postcopy ram: 13691151 kbytes

After this change, giving a few examples:

NORMAL PRECOPY:

(qemu) info migrate
Status: active
Time (ms): total=14292, setup=13, exp_down=12223
RAM info:
  Bandwidth (mbps): 9380.51
  Sizes (KB): psize=4, total=16777992
    transferred=15697718, remain=12383520,
    precopy=2, multifd=15697713, postcopy=0
  Pages: normal=3913877, zero=599981, rate_per_sec=286769
  Others: dirty_syncs=2, dirty_pages_rate=264552

XBZRLE:

(qemu) info migrate
Status: active
Time (ms): total=43973, setup=16, exp_down=75826
RAM info:
  Bandwidth (mbps): 1496.08
  Sizes (KB): psize=4, total=16777992
    transferred=15156743, remain=12877944,
    precopy=15156768, multifd=0, postcopy=0
  Pages: normal=3780458, zero=614029, rate_per_sec=45567
  Others: dirty_syncs=2, dirty_pages_rate=128624
XBZRLE: size=67108864, transferred=0, pages=0, miss=188451
  miss_rate=0.00, encode_rate=0.00, overflow=0

POSTCOPY:

(qemu) info migrate
Status: postcopy-active
Time (ms): total=40504, setup=14, down=145
RAM info:
  Bandwidth (mbps): 6102.65
  Sizes (KB): psize=4, total=16777992
    transferred=37673019, remain=2136404,
    precopy=3, multifd=26108780, postcopy=11563855
  Pages: normal=9394288, zero=600672, rate_per_sec=185875
  Others: dirty_syncs=3, dirty_pages_rate=278378, postcopy_req=4078

COMPLETED:

(qemu) info migrate
Status: completed
Time (ms): total=43708, setup=14, down=145
RAM info:
  Bandwidth (mbps): 7464.50
  Sizes (KB): psize=4, total=16777992
    transferred=39813725, remain=0,
    precopy=3, multifd=26108780, postcopy=13704436
  Pages: normal=9928390, zero=600672, rate_per_sec=167283
  Others: dirty_syncs=3, postcopy_req=5577

INCOMING (WHEN TCP LISTENING):

(qemu) info migrate
Status: setup
Sockets: [
        tcp:0.0.0.0:12345
]

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 158 +++++++++++++++++----------------
 hmp-commands-info.hx           |   6 +-
 2 files changed, 85 insertions(+), 79 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0034dbe47f..c1c10b22ae 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -54,6 +54,7 @@ static void migration_global_dump(Monitor *mon)
 
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
+    bool show_all = qdict_get_try_bool(qdict, "all", false);
     MigrationInfo *info;
 
     info = qmp_query_migrate(NULL);
@@ -68,7 +69,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->has_status) {
-        monitor_printf(mon, "Migration status: %s",
+        monitor_printf(mon, "Status: %s",
                        MigrationStatus_str(info->status));
         if (info->status == MIGRATION_STATUS_FAILED && info->error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
@@ -76,90 +77,111 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "\n");
         }
 
-        monitor_printf(mon, "total time: %" PRIu64 " ms\n",
-                       info->total_time);
-        if (info->has_expected_downtime) {
-            monitor_printf(mon, "expected downtime: %" PRIu64 " ms\n",
-                           info->expected_downtime);
-        }
-        if (info->has_downtime) {
-            monitor_printf(mon, "downtime: %" PRIu64 " ms\n",
-                           info->downtime);
+        if (info->total_time) {
+            monitor_printf(mon, "Time (ms): total=%" PRIu64,
+                           info->total_time);
+            if (info->has_setup_time) {
+                monitor_printf(mon, ", setup=%" PRIu64,
+                               info->setup_time);
+            }
+            if (info->has_expected_downtime) {
+                monitor_printf(mon, ", exp_down=%" PRIu64,
+                               info->expected_downtime);
+            }
+            if (info->has_downtime) {
+                monitor_printf(mon, ", down=%" PRIu64,
+                               info->downtime);
+            }
+            monitor_printf(mon, "\n");
         }
-        if (info->has_setup_time) {
-            monitor_printf(mon, "setup: %" PRIu64 " ms\n",
-                           info->setup_time);
+    }
+
+    if (info->has_socket_address) {
+        SocketAddressList *addr;
+
+        monitor_printf(mon, "Sockets: [\n");
+
+        for (addr = info->socket_address; addr; addr = addr->next) {
+            char *s = socket_uri(addr->value);
+            monitor_printf(mon, "\t%s\n", s);
+            g_free(s);
         }
+        monitor_printf(mon, "]\n");
     }
 
     if (info->ram) {
-        monitor_printf(mon, "transferred ram: %" PRIu64 " kbytes\n",
-                       info->ram->transferred >> 10);
-        monitor_printf(mon, "throughput: %0.2f mbps\n",
+        monitor_printf(mon, "RAM info:\n");
+        monitor_printf(mon, "  Bandwidth (mbps): %0.2f\n",
                        info->ram->mbps);
-        monitor_printf(mon, "remaining ram: %" PRIu64 " kbytes\n",
-                       info->ram->remaining >> 10);
-        monitor_printf(mon, "total ram: %" PRIu64 " kbytes\n",
+        monitor_printf(mon, "  Sizes (KB): psize=%" PRIu64
+                       ", total=%" PRIu64 "\n",
+                       info->ram->page_size >> 10,
                        info->ram->total >> 10);
-        monitor_printf(mon, "duplicate: %" PRIu64 " pages\n",
-                       info->ram->duplicate);
-        monitor_printf(mon, "normal: %" PRIu64 " pages\n",
-                       info->ram->normal);
-        monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
-                       info->ram->normal_bytes >> 10);
-        monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
-                       info->ram->dirty_sync_count);
-        monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
-                       info->ram->page_size >> 10);
-        monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
-                       info->ram->multifd_bytes >> 10);
-        monitor_printf(mon, "pages-per-second: %" PRIu64 "\n",
+        monitor_printf(mon, "    transferred=%" PRIu64
+                       ", remain=%" PRIu64 ",\n",
+                       info->ram->transferred >> 10,
+                       info->ram->remaining >> 10);
+        monitor_printf(mon, "    precopy=%" PRIu64
+                       ", multifd=%" PRIu64
+                       ", postcopy=%" PRIu64,
+                       info->ram->precopy_bytes >> 10,
+                       info->ram->multifd_bytes >> 10,
+                       info->ram->postcopy_bytes >> 10);
+
+        if (info->vfio) {
+            monitor_printf(mon, ", vfio=%" PRIu64,
+                           info->vfio->transferred >> 10);
+        }
+        monitor_printf(mon, "\n");
+
+        monitor_printf(mon, "  Pages: normal=%" PRIu64 ", zero=%" PRIu64
+                       ", rate_per_sec=%" PRIu64 "\n",
+                       info->ram->normal,
+                       info->ram->duplicate,
                        info->ram->pages_per_second);
+        monitor_printf(mon, "  Others: dirty_syncs=%" PRIu64,
+                       info->ram->dirty_sync_count);
 
         if (info->ram->dirty_pages_rate) {
-            monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
+            monitor_printf(mon, ", dirty_pages_rate=%" PRIu64,
                            info->ram->dirty_pages_rate);
         }
         if (info->ram->postcopy_requests) {
-            monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
+            monitor_printf(mon, ", postcopy_req=%" PRIu64,
                            info->ram->postcopy_requests);
         }
-        if (info->ram->precopy_bytes) {
-            monitor_printf(mon, "precopy ram: %" PRIu64 " kbytes\n",
-                           info->ram->precopy_bytes >> 10);
-        }
         if (info->ram->downtime_bytes) {
-            monitor_printf(mon, "downtime ram: %" PRIu64 " kbytes\n",
-                           info->ram->downtime_bytes >> 10);
-        }
-        if (info->ram->postcopy_bytes) {
-            monitor_printf(mon, "postcopy ram: %" PRIu64 " kbytes\n",
-                           info->ram->postcopy_bytes >> 10);
+            monitor_printf(mon, ", downtime_ram=%" PRIu64,
+                           info->ram->downtime_bytes);
         }
         if (info->ram->dirty_sync_missed_zero_copy) {
-            monitor_printf(mon,
-                           "Zero-copy-send fallbacks happened: %" PRIu64 " times\n",
+            monitor_printf(mon, ", zerocopy_fallbacks=%" PRIu64,
                            info->ram->dirty_sync_missed_zero_copy);
         }
+        monitor_printf(mon, "\n");
     }
 
     if (info->xbzrle_cache) {
-        monitor_printf(mon, "cache size: %" PRIu64 " bytes\n",
-                       info->xbzrle_cache->cache_size);
-        monitor_printf(mon, "xbzrle transferred: %" PRIu64 " kbytes\n",
-                       info->xbzrle_cache->bytes >> 10);
-        monitor_printf(mon, "xbzrle pages: %" PRIu64 " pages\n",
-                       info->xbzrle_cache->pages);
-        monitor_printf(mon, "xbzrle cache miss: %" PRIu64 " pages\n",
-                       info->xbzrle_cache->cache_miss);
-        monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
-                       info->xbzrle_cache->cache_miss_rate);
-        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
-                       info->xbzrle_cache->encoding_rate);
-        monitor_printf(mon, "xbzrle overflow: %" PRIu64 "\n",
+        monitor_printf(mon, "XBZRLE: size=%" PRIu64
+                       ", transferred=%" PRIu64
+                       ", pages=%" PRIu64
+                       ", miss=%" PRIu64 "\n"
+                       "  miss_rate=%0.2f"
+                       ", encode_rate=%0.2f"
+                       ", overflow=%" PRIu64 "\n",
+                       info->xbzrle_cache->cache_size,
+                       info->xbzrle_cache->bytes,
+                       info->xbzrle_cache->pages,
+                       info->xbzrle_cache->cache_miss,
+                       info->xbzrle_cache->cache_miss_rate,
+                       info->xbzrle_cache->encoding_rate,
                        info->xbzrle_cache->overflow);
     }
 
+    if (!show_all) {
+        goto out;
+    }
+
     if (info->has_cpu_throttle_percentage) {
         monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
                        info->cpu_throttle_percentage);
@@ -191,24 +213,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         g_free(str);
         visit_free(v);
     }
-    if (info->has_socket_address) {
-        SocketAddressList *addr;
-
-        monitor_printf(mon, "socket address: [\n");
-
-        for (addr = info->socket_address; addr; addr = addr->next) {
-            char *s = socket_uri(addr->value);
-            monitor_printf(mon, "\t%s\n", s);
-            g_free(s);
-        }
-        monitor_printf(mon, "]\n");
-    }
-
-    if (info->vfio) {
-        monitor_printf(mon, "vfio device transferred: %" PRIu64 " kbytes\n",
-                       info->vfio->transferred >> 10);
-    }
 
+out:
     qapi_free_MigrationInfo(info);
 }
 
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59cd6637b..639a450ee5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -475,9 +475,9 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show migration status",
+        .args_type  = "all:-a",
+        .params     = "[-a]",
+        .help       = "show migration status (-a: all, dump all status)",
         .cmd        = hmp_info_migrate,
     },
 
-- 
2.49.0


