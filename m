Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFB5CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hul-0005Ii-NZ; Fri, 03 Oct 2025 11:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hu5-0004sC-AN
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htV-0007fF-0W
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjCyvwCIevGVBqh+jNw6eLMSkGaP/P1/pHhrhSvpeiI=;
 b=IJFpuR5uQXalbxPLjtU5/bihcMuc9PhjRGVIyXLZpQ1u6guKGm2eaOSKp3qnE3BR9yiK3g
 LF/zrRKYWAMEWFRunzPAZum2teya1f20FXhX73i/YfvLVKiVWzEBoOViCuhLnqmG7lTP0D
 6fNmDGcfNimkxjFW4+CSvBdJStjsBIA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-DHy7VHL2P4aFegVe69WuTA-1; Fri, 03 Oct 2025 11:40:24 -0400
X-MC-Unique: DHy7VHL2P4aFegVe69WuTA-1
X-Mimecast-MFC-AGG-ID: DHy7VHL2P4aFegVe69WuTA_1759506024
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e0e7caf22eso60748101cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506024; x=1760110824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjCyvwCIevGVBqh+jNw6eLMSkGaP/P1/pHhrhSvpeiI=;
 b=PJe3uWV2KtH3ZB7JfRs+GValgXVONjwDPlWg5QMbtEgLcPPzH4zNijGb4zmI+6e+Mn
 pLdQF02d84LhP8nFcRL46qLtVkv1gi1jlNuIf7KekDAlX7teiiYp5Sh9k7UMf9c5FuvF
 i00fQS2tOkKXeVkOfeFCDISo3z30KsSor3JWA9mGPxpFSwjM94xzK4xPUOXdXJAS5qnh
 XLaJD9Czzx+UkqbUW1Q5tKje4/CaXT8fNKfFdKGu60yVudMEs7fU1vhN/cEu5Nzb8S/W
 F6dX40jvmK0G+YrpwU/g/5jUgwa7JfqDQleBUMwYIm3QxB72BWkjpFwJZxIyN8G/AAdt
 qWmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAuusG6lKQFms+iWElBbmk4LSLPVuqKXziBwmv0GOFID+4+NJTeZ6PhVq4N9beAQqOQv7QAW+I82Fw@nongnu.org
X-Gm-Message-State: AOJu0YzOAViNV3JmQSKRI26Z0l7eD6UwhWK9jcamukOTteGGZf50wYoc
 Xi+Aj2lk6yXFdI2jj91J4Pf/pxQdtUdve+PkRTfK9OLEnJg8JirVgd74jo+ZF20fLpO2DXqpMvy
 Tw/RHwZx8rm9z5JrVdftxIMw9wl1dSK2b+JQMrRH5Qnn20ZSBHLICxsfV
X-Gm-Gg: ASbGnctpLaDTJbkxD8U2/BCQU6iqeGxwjEHXKKbAW9DFmeIno8WlsNeWzaVvrvCEker
 NMSnG9AfA6Tvz73nzU0kUFVOaNnEG8pMjz7SsBIN6QGfpQi+ZKRj41LMb77khfhE7qQoGZ1t6XF
 VuOxsKNseeP0Ch8aFoSC32U1wIAU3Y/5/gSA4ULhkET/xISmCbMrIsCDisYJXf0wwS+DKngetxA
 gUossAQf/xDFIbiazWMfB0wVLn3uUBFZxdYD8j8bNHUEDL4x7YlWfV0d9n9WoI0j2OUQh7dwU0r
 WV9aATTU9rSVudjuoVISFmYA/pIa/lOVGD8t2g==
X-Received: by 2002:ac8:5793:0:b0:4d0:fbd5:4cd5 with SMTP id
 d75a77b69052e-4e576a45315mr50988861cf.11.1759506023632; 
 Fri, 03 Oct 2025 08:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4hklLqunnpRNLlKIF3kd1bxchhahx5FHYStyvAlTuDWfFmk8BC7FwJ0zpYIaBvY+SR/fBuw==
X-Received: by 2002:ac8:5793:0:b0:4d0:fbd5:4cd5 with SMTP id
 d75a77b69052e-4e576a45315mr50988331cf.11.1759506023123; 
 Fri, 03 Oct 2025 08:40:23 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 21/45] migration: push Error **errp into
 loadvm_process_enable_colo()
Date: Fri,  3 Oct 2025 11:39:24 -0400
Message-ID: <20251003153948.1304776-22-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_process_enable_colo() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-21-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/ram.h          |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  8 ++++----
 migration/savevm.c       | 26 ++++++++++++++------------
 5 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 43222ef5ae..d4fe422e4d 100644
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
diff --git a/migration/ram.h b/migration/ram.h
index 275709a991..24cd0bf585 100644
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
diff --git a/migration/migration.c b/migration/migration.c
index ce17dcc1c0..2f55f2784b 100644
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
index 163265a57f..a8e8d2cc67 100644
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
diff --git a/migration/savevm.c b/migration/savevm.c
index 2e8776768f..8937496d9f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2515,15 +2515,21 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
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
@@ -2646,11 +2652,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


