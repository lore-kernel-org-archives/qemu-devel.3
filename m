Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AC5C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMS-00028r-DR; Fri, 08 Aug 2025 03:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMQ-0001yp-Iy
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMO-0007YO-5n
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zc6KGC9gLPRi6q/fK9uTYSORlFiBhURFQtRCjdrDpz8=;
 b=XzIYhaWppaAXyXDKUv0myHxHknZWpniolXQNvk/d9jRfuQiwAQuSCqCe3QcrIf7qHzKXUm
 msmR8XjyPtDaDx/otkejuVpinnHcfEYQ1OGXQoRgADPyMVkM7EgGohHT2BmONO/WvIIpoB
 5/ZJWpXVOmhdn12Y+SR5R5NIQ22zVCQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-bNQA5oUUMV6m0EDManpkxA-1; Fri, 08 Aug 2025 03:17:49 -0400
X-MC-Unique: bNQA5oUUMV6m0EDManpkxA-1
X-Mimecast-MFC-AGG-ID: bNQA5oUUMV6m0EDManpkxA_1754637468
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24011ceafc8so16025675ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637468; x=1755242268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zc6KGC9gLPRi6q/fK9uTYSORlFiBhURFQtRCjdrDpz8=;
 b=tOKzuKZOL7UqZk8cMc21IQ3lXXTk87Xr86IhIlcaykzDw7Vip0TO3p64oeFVRY1I8m
 ME/AFQfwxcin77kQ/h5vPHUJXJ31fKF3NP1yBdr/4QISSiJed/0CP7UyqW995GAKWGwU
 rt558KbPO7QEji8Dl/nzPx3WLQU8yN6NpMYEfnfmeu47tEvC4yHHFWN/2Jqeyx/X9QG3
 KbWDapIhUGlV707SpgxE8Gp3MqbIRlPTRcZzzvsU5NktXWGlhaMiGvmB1QIdnL+JJniD
 vR/tG7K+j7guBHEZSbXkN6lykLuAb35MmWancvvgeIy8naT0r+H8M8j7vRHs39DL3R/Q
 v7gQ==
X-Gm-Message-State: AOJu0YxXLY9zxWKcblYCS83NaCOqSVRd8y1LO6aV+uNmy7hXIuDOnqbl
 qK2oZCiBPWGRWg5xSU778zi6rJZgpOHNKKD5BgB4FNoiiMPM0k0nnmuE8nBhJAPZ67LTweRuzZu
 Pa4rhhj2NiVNDGn9DwZsQywH7IsC0od3i3oNfpQ4ngYyZWTMBujSHRDJo
X-Gm-Gg: ASbGncuVplQN2JxLMoPQPjP7cqoUcCPFj4sxEkk3939tirF2qugk+I+JTheKH9O4G/5
 Y0tA7rLIZvqlUz+Vzc5dkQatCWojTP7D/3//5PV/5r/ECh1NeSkhRWgC9KwPpw4OjniYW+6yLn+
 mC11BLCu7A2R6LCfSrXrjjY8q/7wpRp60miyzhbYW8yOTShELYSdunnObSeBEcpiOVKP/jnUnA5
 EYkRBseHmWyeMC1C//FMbawH3uUGMt1jW2ZuKZPC2njAlD3M0L5mrjFJdRCdLyyII9vBbWOhfOV
 vQAYro/96m+NqLZSkK3ZyLPI796ybpgNLdMf82LhZ2Q/KUgoipAN1Q==
X-Received: by 2002:a17:903:19ce:b0:240:cd3e:d860 with SMTP id
 d9443c01a7336-242c220df9cmr27243935ad.41.1754637468220; 
 Fri, 08 Aug 2025 00:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9KAVLpGwFNYG2bSaShhaR1b2jiMAmB+ahxcRFnGIfTjtpcMTK9FVy0HLkfyyV55PczCDEjA==
X-Received: by 2002:a17:903:19ce:b0:240:cd3e:d860 with SMTP id
 d9443c01a7336-242c220df9cmr27243575ad.41.1754637467836; 
 Fri, 08 Aug 2025 00:17:47 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:17:47 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:47 +0530
Subject: [PATCH v10 21/27] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-21-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5954; i=armenon@redhat.com;
 h=from:subject:message-id; bh=LREnjd+zirEQOcTJ5PyBLt5tOajL0klZWFfTSsXGi5Q=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxdcE9vzL4P+WufD6cZWdqhnlvOkPW9RjJyztd7Gck
 Krcvz6zo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwET4RRj+OyTPspbZ+nwvD0uq
 pr/4rQDjf48EegtXbJLtUoz6laRzgJFhwYe2s3s+PW6ZenxD0eZlBW1XPr4//+VzRc2FbfPq/D5
 95wYA
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
It is ensured that loadvm_process_enable_colo() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  8 ++++----
 migration/ram.h          |  2 +-
 migration/savevm.c       | 26 ++++++++++++++------------
 5 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fcd73287a0e 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
 /* loadvm */
-int migration_incoming_enable_colo(void);
+int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
 bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
diff --git a/migration/migration.c b/migration/migration.c
index 35f769bc55c235134abb5554ed01b94787d4bf78..39d6142abccf90c3a35e6c2df3df245052eb0bcf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
     migration_colo_enabled = false;
 }
 
-int migration_incoming_enable_colo(void)
+int migration_incoming_enable_colo(Error **errp)
 {
 #ifndef CONFIG_REPLICATION
-    error_report("ENABLE_COLO command come in migration stream, but the "
-                 "replication module is not built in");
+    error_setg(errp, "ENABLE_COLO command come in migration stream, but the "
+               "replication module is not built in");
     return -ENOTSUP;
 #endif
 
     if (!migrate_colo()) {
-        error_report("ENABLE_COLO command come in migration stream, but x-colo "
-                     "capability is not set");
+        error_setg(errp, "ENABLE_COLO command come in migration stream"
+                   ", but x-colo capability is not set");
         return -EINVAL;
     }
 
     if (ram_block_discard_disable(true)) {
-        error_report("COLO: cannot disable RAM discard");
+        error_setg(errp, "COLO: cannot disable RAM discard");
         return -EBUSY;
     }
     migration_colo_enabled = true;
diff --git a/migration/ram.c b/migration/ram.c
index 163265a57f26fb1dc88d9797629d58c278e9afb7..a8e8d2cc6790336625de626fee070ecc51327200 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3578,7 +3578,7 @@ static void colo_init_ram_state(void)
  *
  * Returns zero to indicate success or -1 on error.
  */
-int colo_init_ram_cache(void)
+int colo_init_ram_cache(Error **errp)
 {
     RAMBlock *block;
 
@@ -3587,9 +3587,9 @@ int colo_init_ram_cache(void)
             block->colo_cache = qemu_anon_ram_alloc(block->used_length,
                                                     NULL, false, false);
             if (!block->colo_cache) {
-                error_report("%s: Can't alloc memory for COLO cache of block %s,"
-                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
-                             block->used_length);
+                error_setg(errp, "Can't alloc memory for COLO cache of "
+                           "block %s, size 0x" RAM_ADDR_FMT,
+                           block->idstr, block->used_length);
                 RAMBLOCK_FOREACH_NOT_IGNORED(block) {
                     if (block->colo_cache) {
                         qemu_anon_ram_free(block->colo_cache, block->used_length);
diff --git a/migration/ram.h b/migration/ram.h
index 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6baeea2f0627 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
                                    bool set);
 
 /* ram cache */
-int colo_init_ram_cache(void);
+int colo_init_ram_cache(Error **errp);
 void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index a7aede1b3df9164e322e68f3889df7c4166876f5..c5566199d00893c4e083ecd27a55da832e2df574 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2519,15 +2519,21 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
     return 0;
 }
 
-static int loadvm_process_enable_colo(MigrationIncomingState *mis)
+static int loadvm_process_enable_colo(MigrationIncomingState *mis,
+                                      Error **errp)
 {
-    int ret = migration_incoming_enable_colo();
+    ERRP_GUARD();
+    int ret;
 
-    if (!ret) {
-        ret = colo_init_ram_cache();
-        if (ret) {
-            migration_incoming_disable_colo();
-        }
+    ret = migration_incoming_enable_colo(errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = colo_init_ram_cache(errp);
+    if (ret) {
+        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
+        migration_incoming_disable_colo();
     }
     return ret;
 }
@@ -2648,11 +2654,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
-        ret = loadvm_process_enable_colo(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
         ret = loadvm_postcopy_handle_switchover_start();

-- 
2.50.1


