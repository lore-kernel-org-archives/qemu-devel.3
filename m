Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D4BCD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjvP-0000a5-Q8; Tue, 12 May 2026 06:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wMjvG-0000ZV-Jl
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:01:07 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wMjvE-0000AT-T3
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:01:06 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c8095d7d75bso2185333a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778580062; x=1779184862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DXF1t8a3T3Tww7GUUBF7irqjI/KF0DbSuDolpAIIOd4=;
 b=NlBqBOOm7urzgfQacNYzQFs0LGgIO02uStBrKHGUIGZdPoGBOua87uTU2eydVx/QRR
 eKHVe6wLW4bdD5YrgDXVhx1G9Tw5Gz+6vtZA507PgZ7A45+BgaGx9/e0MgqdWmmfoRKC
 9STlEaHRUhH1JxGAHVATwpb6NNpXumY4sIDt10ydCHYZJJTwAUlaQFrdgUhL0X93T+6C
 CuMY9hUyA1xX+chVhuBeaO0tsVS0uVif+g+lelTru5X56FBBksjrCyuDzbK6TKbAXpud
 AcOPRg6xUnlzFj4FRyAnJtpMotjKXbRiZ8QXouuImyhV2VesyLzesXJUB/tWG17T6ay9
 yIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778580062; x=1779184862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXF1t8a3T3Tww7GUUBF7irqjI/KF0DbSuDolpAIIOd4=;
 b=FrPTrOZa5B4358mgZ65EtKadclqf+qUDMH2yqYqZRde/D/fm3ZVll91yJJQyi8s8mP
 rRaFYJH+U0C6qQItB4TZH03DX3NkdqZhM0u2P4KmeRV/TMhRZebxHnywoX75kN8lG9RI
 nQY9X4rvSfnRXqva/xAJPq/kkZxjIdlrpQ2nslFJFr31Ssq154cgeq3mSPU7k0Co0rBQ
 xT82l+j64xzWvnIMAIRi1lwQmwzXDIe2oxQTWq5Z2YQrgsjWIw+VNdWAGQ6kEBlZWLoN
 hsHpkN8DHnJHW4GgUbPKsJdbPi3urwUNhgF1s7SdVQzR0IUIV/CeU31SZzH/HJzneto7
 t2xw==
X-Gm-Message-State: AOJu0YzO8isJ1QzlRr+ZFN/16bvTHK30e7Q1VHlStqS7daFEA3M6W7vs
 y9uaLmS3WvWG1x14fRcEvGqL7Cv3059ycFQ9mTBFbBlChu+2XsOZzDoFme4wVHOA
X-Gm-Gg: Acq92OEuJ+Ln6eYNJlGNy5ZjgchR7eYC8urFxjvtYUIElvnCRqhmpVUyzRDHU3Fv7AM
 ZzNNaTr0VpS1BBPSBuIi3wNOnkRgDwvmBMxpEDdcctJ/oscMz5CZs4f35cBhZ8Tm722ZJ5kiDk2
 +x1dkeTPoetwKNPh8j+kcfAtEG3fDay+YFsPw3m/nnKE+xeUyJ+KHRd0Tf4nwpSroNGdYPLsmCy
 TQyenvHopO9WETDsWO5q95fF7gRyTrGaIm7b361BEiLkWauYt1xI5F5V4S/Vwaxj+Z/KEl1Q7Id
 eUa6oFa8OBRKVLOXMYt0Wqpha5lPZc7Yj/E/zL1fRBP0L1wQt2NmjO02AV1QFSfEpY5k2DGEOXn
 uBf4LCGwKVhKi60oWCZTvz9PcdqQvX7mkmS0/1W2b1QSACz6oXFW6hx+Wxws8+xpSqvog2dCrRo
 aTsIIZPeyAIaFcKe7TjHAIbntA/T83KQY=
X-Received: by 2002:a05:6a21:33aa:b0:3a1:5cce:ca93 with SMTP id
 adf61e73a8af0-3aad4488601mr15112629637.40.1778580061904; 
 Tue, 12 May 2026 03:01:01 -0700 (PDT)
Received: from setun ([2405:201:502b:380f:df10:4bc8:ea8:8d6d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c826768acf3sm13893187a12.10.2026.05.12.03.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 03:01:01 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH] [migration] Replace current_migration with
 migrate_get_current()
Date: Tue, 12 May 2026 15:30:00 +0530
Message-ID: <20260512095959.736285-2-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces the direct accesses to global variable `current_migration`
with `migrate_get_current()` to ensure safety and
consistency across systems.

Note: Following this only direct access to `current_migration` will be
* `migrate_get_current()` itself
* `migration_object_init()` initializes `current_migration`
* `migration_is_running()`, as there might be a case where this function
  is called by a thread before object initialization

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ecc69dc4d2..f3a96b1949 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -321,7 +321,7 @@ void migration_object_init(void)
 
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
 
-    migration_object_check(current_migration, &error_fatal);
+    migration_object_check(migrate_get_current(), &error_fatal);
 
     ram_mig_init();
     dirty_bitmap_mig_init();
@@ -385,7 +385,7 @@ void migration_shutdown(void)
      * stop the migration using this structure
      */
     migration_cancel();
-    object_unref(OBJECT(current_migration));
+    object_unref(OBJECT(migrate_get_current()));
 
     /*
      * Cancel outgoing migration of dirty bitmaps. It should
@@ -1029,7 +1029,7 @@ bool migration_is_running(void)
 
 static bool migration_is_active(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
             s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
@@ -1634,7 +1634,7 @@ bool migration_in_bg_snapshot(void)
 
 bool migration_thread_is_self(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     return qemu_thread_is_self(&s->thread);
 }
@@ -3062,7 +3062,7 @@ static MigThrError postcopy_pause(MigrationState *s)
 
 void migration_file_set_error(int ret, Error *err)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
-- 
2.54.0


