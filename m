Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2C2C87FD2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 19:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMwI-0002w3-5Q; Tue, 05 Aug 2025 15:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPc-0007aG-Pg
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPZ-00047Y-JL
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07QBWaYGFP72bgwrXFQvyDVEM/hIfWp2TskMLU1w054=;
 b=T6Ur/FCZ2276TwL5gruT3s3fViMOmfhY5PPWcN8PLGZuMIVU74cWgM8op6XxQkbs2aDhge
 134xxoYhu/fijWWYsD9JlX6tYxm7HgQYKbe2VRo3bJzCBnxbDAtQTfOtoTZEdWOW1KVkBY
 6QvP8slEmlcyzRT5n3VhRM3x3FUXE5s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-PLJ4TikONWusEB3SVTBySw-1; Tue, 05 Aug 2025 14:29:17 -0400
X-MC-Unique: PLJ4TikONWusEB3SVTBySw-1
X-Mimecast-MFC-AGG-ID: PLJ4TikONWusEB3SVTBySw_1754418556
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b42464016c3so3157511a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418553; x=1755023353;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07QBWaYGFP72bgwrXFQvyDVEM/hIfWp2TskMLU1w054=;
 b=OuQWhOoJ0XNsFe/CqCIrB1uWiq99Qzu8B3Q/Q5v9MDohZKBhcbhxf3iELSSFi/rTYJ
 qNBS2nBoyYpeExWBVpYSORZpWOX8TB2sG0GKnQLffneqeDQ39HK/AW07SuY9C2MKS4PV
 hOs302IixmMa2dU13OLnYVmziu5aYGmeIfCR5sHdEimyKOHOTxFqMxhstz7JJ916F4E0
 KcxQqXkcMMUketlpn7ZP7WJKRUdzkU9uSFqQmFls/Ab91pGBZP1rr+pupx6ZPPAdYN+Q
 366uQ+Jg6FNIbI3hXFM4+DBkYerx5z3MsvVICtTL9o1YtsdoofdZOVkO6AbzOSwRbaR+
 X3Lw==
X-Gm-Message-State: AOJu0YwbgS3Lo4YljViEUHnK+4+QBmbWECXE2olqPPwrOsRpMQdy/1H5
 eGBBY7CZqm3Dg4KxP0LQ56myhxswt0IpX/G9rUWHueHc9CrJnQ/XStVldT870rDQwPOsQtoo9eY
 i/KSlaPNf1g4MQeDu0YkemIKAH/Bd2uYVTzv7RkXNL7pPgSSYqiCJvNXn
X-Gm-Gg: ASbGncsiY87pRvxg0znl1plYbnUlKAG2c7sBPukhrpyZC03GVbFu9aqGFhlQ791EV1P
 ZEOvdQ/lyoCUp2Zsu+BKYHr/lUZArVgNJknuq1dod98MIYzJfTz4BG014i4K2Ie2PEi6oNgBJT0
 w/RP1EvTitdksdMMp7mWHzqsc913xdLH2+0YXTS4Q9UQklUSDrEIFPzmRiU6JEjeCc7d1ItuWX5
 dqQZ5iHp8uu+9EHqIzk+XqHNjZIstefc5K5wFq485rQO/XI/w3IuoqJBYg6sa4uUt1mB0XF3EK7
 1H4SDj34S/Ok7+Z4q9RK0mpV/cNqJPe4gUZmTKjsZNbDgPa99g==
X-Received: by 2002:a17:902:cf4a:b0:240:cd3e:d85c with SMTP id
 d9443c01a7336-2429f51b7cemr1251375ad.31.1754418553189; 
 Tue, 05 Aug 2025 11:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ZPXpWMt8tqXd3gad2Pt/IqMk9hJOzYc7uaubY0Wx+5+pUvIXaWfZ6nBWYTK1Rx8cnnjf9Q==
X-Received: by 2002:a17:902:cf4a:b0:240:cd3e:d85c with SMTP id
 d9443c01a7336-2429f51b7cemr1250965ad.31.1754418552785; 
 Tue, 05 Aug 2025 11:29:12 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:29:12 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:16 +0530
Subject: [PATCH v9 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-9-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6637; i=armenon@redhat.com;
 h=from:subject:message-id; bh=FhyjtxycGqdBWTGuXY6EbWNSDYXy4Pj14R3BjyLrHhc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX+nn7NXsQT+lBV4IaKxcxdZ8tfLNM87vE5RMk8KnN
 sdK/9jfUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCLZ3YwM6748NOzzadx1zo4p
 cI+qlVHjrv5lG/ecWmwZn3nGLqFtNcP/qOs5EzIvcJq9myDc+bFV9tLOji2zxNyqNPf/3JdyuKK
 aFQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_state_main() must report an error
in errp, in case of failure.
loadvm_process_command also sets the errp object explicitly.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   |  5 +++--
 migration/savevm.c | 33 ++++++++++++++++++++-------------
 migration/savevm.h |  3 ++-
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c736c3b4879ff04e58 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
 static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
                       QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
 {
+    ERRP_GUARD();
     uint64_t total_size;
     uint64_t value;
     Error *local_err = NULL;
@@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
     bql_unlock();
 
     if (ret < 0) {
-        error_setg(errp, "Load VM's live state (ram) error");
+        error_prepend(errp, "Load VM's live state (ram) error: ");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f3b91c8ae0eee6078406081f0bd7f686fed28601..ad3dd9b172afc541f104d2187a79bafa8e380466 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, NULL);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2407,6 +2407,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  */
 static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     size_t length;
     QIOChannelBuffer *bioc;
@@ -2456,9 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
+    ret = qemu_loadvm_state_main(packf, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "VM state load failed: %d", ret);
+        error_prepend(errp, "Loading VM state failed: %d: ", ret);
     }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
@@ -3074,8 +3075,10 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
+    ERRP_GUARD();
     uint8_t section_type;
     int ret = 0;
 
@@ -3083,8 +3086,10 @@ retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
+        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
         if (ret) {
+            error_prepend(errp, "Failed to load device state section ID: %d: ",
+                          ret);
             break;
         }
 
@@ -3105,7 +3110,7 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f, NULL);
+            ret = loadvm_process_command(f, errp);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3115,7 +3120,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3123,6 +3128,9 @@ retry:
 
 out:
     if (ret < 0) {
+        if (*errp == NULL) {
+            error_setg(errp, "Loading VM state failed: %d", ret);
+        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */
@@ -3143,6 +3151,8 @@ out:
             migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
+            error_free(*errp);
+            *errp = NULL;
             goto retry;
         }
     }
@@ -3176,10 +3186,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
-    if (ret < 0) {
-        error_setg(errp, "Load VM state failed: %d", ret);
-    }
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3260,9 +3267,9 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "Failed to load device state: %d", ret);
+        error_prepend(errp, "Failed to load device state: %d: ", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,

-- 
2.50.1


