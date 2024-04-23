Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B286C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOne-0003dZ-AW; Tue, 23 Apr 2024 18:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmm-0001eW-4o
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmk-0006EY-6i
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJyFsvQUN501aNClmLpvJ1SUtq8254UQPDpetRvAXmM=;
 b=RxvsQI9FHLwIVWumIsc2RoKk/KAOIWxXh2x/Tqe+oinz4MvsLihOmc51l+oUGlPws0rNCN
 bNQnoX5chlqmZ+Zq+gsUenV4hPswWT3BPLSQ/BxY4qGJ8y1HjY1xR/OSFKBDPnD0IY1OZG
 2iktZn7XU5cynxz0JJxIj+hT7rlsifg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-AXekD6IPN0WhmavYXaDUEw-1; Tue, 23 Apr 2024 18:38:44 -0400
X-MC-Unique: AXekD6IPN0WhmavYXaDUEw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c73b20ff25so1675851b6e.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911923; x=1714516723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJyFsvQUN501aNClmLpvJ1SUtq8254UQPDpetRvAXmM=;
 b=lEcC1Muyei+Os0ULCKaeg+V5CWCDRLF5UpEIaa7NtXb//e9FTSx15kTGw8IozGS4lv
 ucDHXWlFxya3wTIRCZnOPuFKkDAnJJCG97sK67L76jckYGmVkgcRqsWPeAQK1Fx8tlPq
 JyrHmsdPzbuPvoNKQrWL84mcWzOC648pYrV0/mozUK8jymalbtVdbTlGPT8fVVQqmhjr
 NNL07oevAy7AzjqhGmTr8qY25BM/hWcCpxNwhi1lVhlS2eln4UWnSCWSdLKSLgCSISWP
 AW4ICvxz8c2CcE7xy5//26gFikwVXqalI8rkRyqzOADBRwIncbYFPLVYNaZd9tvnh5L7
 XTzg==
X-Gm-Message-State: AOJu0Yy4rw+LE4X2HIIoiF5Mfi64kIY8rqdfj1/pjop4v8kOOehoDiVj
 Caqx/Uo7bAx2udb763Z6B15fL48J3bA2vzNweI7Ok5ZpFSkID3Z3eH/Ia8KgCFPGvxUkP3ddKi9
 n/awJvgE1bE7dylQkJtqrDUgBnEwf0+6edTCsNJ63z5uH2czaRFUf+oMF1vSTJ1NkuINgiYlwZV
 +ZInOrsJTYPtDLgfSk87Q1udbjpH+KawYrfQ==
X-Received: by 2002:a9d:5c87:0:b0:6eb:ac96:d26f with SMTP id
 a7-20020a9d5c87000000b006ebac96d26fmr1094356oti.3.1713911923270; 
 Tue, 23 Apr 2024 15:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCPzIw9ollZdtcJsSqbuPXKScNztkXbhQxBo+FTaORlVx7EWUvlLTbpUYOXwQb0BmOjxJ+rw==
X-Received: by 2002:a9d:5c87:0:b0:6eb:ac96:d26f with SMTP id
 a7-20020a9d5c87000000b006ebac96d26fmr1094326oti.3.1713911922648; 
 Tue, 23 Apr 2024 15:38:42 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/26] migration: Modify ram_init_bitmaps() to report dirty
 tracking errors
Date: Tue, 23 Apr 2024 18:38:10 -0400
Message-ID: <20240423223813.3237060-24-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

The .save_setup() handler has now an Error** argument that we can use
to propagate errors reported by the .log_global_start() handler. Do
that for the RAM. The caller qemu_savevm_state_setup() will store the
error under the migration stream for later detection in the migration
sequence.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240320064911.545001-15-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 70797ef5d8..daffcd82d4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2857,9 +2857,8 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
     }
 }
 
-static void ram_init_bitmaps(RAMState *rs)
+static bool ram_init_bitmaps(RAMState *rs, Error **errp)
 {
-    Error *local_err = NULL;
     bool ret = true;
 
     qemu_mutex_lock_ramlist();
@@ -2868,10 +2867,8 @@ static void ram_init_bitmaps(RAMState *rs)
         ram_list_init_bitmaps();
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
-            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
-                                                &local_err);
+            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
             if (!ret) {
-                error_report_err(local_err);
                 goto out_unlock;
             }
             migration_bitmap_sync_precopy(rs, false);
@@ -2882,7 +2879,7 @@ out_unlock:
 
     if (!ret) {
         ram_bitmaps_destroy();
-        return;
+        return false;
     }
 
     /*
@@ -2890,24 +2887,23 @@ out_unlock:
      * containing all 1s to exclude any discarded pages from migration.
      */
     migration_bitmap_clear_discarded_pages(rs);
+    return true;
 }
 
-static int ram_init_all(RAMState **rsp)
+static int ram_init_all(RAMState **rsp, Error **errp)
 {
-    Error *local_err = NULL;
-
-    if (!ram_state_init(rsp, &local_err)) {
-        error_report_err(local_err);
+    if (!ram_state_init(rsp, errp)) {
         return -1;
     }
 
-    if (!xbzrle_init(&local_err)) {
-        error_report_err(local_err);
+    if (!xbzrle_init(errp)) {
         ram_state_cleanup(rsp);
         return -1;
     }
 
-    ram_init_bitmaps(*rsp);
+    if (!ram_init_bitmaps(*rsp, errp)) {
+        return -1;
+    }
 
     return 0;
 }
@@ -3104,8 +3100,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp) != 0) {
-            error_setg(errp, "%s: failed to setup RAM for migration", __func__);
+        if (ram_init_all(rsp, errp) != 0) {
             compress_threads_save_cleanup();
             return -1;
         }
-- 
2.44.0


