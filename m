Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB74CD5B872
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5K-0003og-3b; Wed, 30 Oct 2024 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5F-0003lq-Nx
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5D-0007ph-T9
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEuFCgBxTvksT6iByDhahXGFDYrMUUEVp3vLKzxjgS8=;
 b=AYQ/0NQjAawfucEv2IkNGmAqIOHEU4j4H9uyCZps5zlSOLNhRcf3rYPDQWqa7F+p2RShC8
 vhypOFLodq7Y0EzVqfrh7eXs6lF5uvVQca4EpBpHL8HB+DnL/Hbd3UjajmRNc90LPz+BQh
 mp1e8Bk2sqnHLBK6pRU3k54HqVrf5Cw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-FgobQgnBPX2yDodQSkw68w-1; Wed, 30 Oct 2024 11:58:06 -0400
X-MC-Unique: FgobQgnBPX2yDodQSkw68w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cdeeb785c8so84836d6.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303885; x=1730908685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEuFCgBxTvksT6iByDhahXGFDYrMUUEVp3vLKzxjgS8=;
 b=j1UpQ1bKgya8/FVAKhTefMjChfZTYJfdqMyfcN5ZZGDVPAKdNjdkjNts5uvwokubWg
 MFvcom54LRdRtcQGNX0awf5TvfIKzpiWC4/yPNW76D5B9iNKtYdD/UDTaov09JPdJeuu
 Wvt49w0FiB/weoWLEuP6jfkU4I05lJCHL2D8A8tp8V7FbKqNj0bW3AwqExLKdN4hRiqQ
 SGzilHs9H2hG6qVqqf+PIA/sjkgfk+n8+3B5Y605XW65BXQ+5dG71dBwc4RZfzEKyEYi
 4rdt3fQTrh9/lKeJaQ430tmuG4weCZcRiwCt5lmTrCi9WZcuFCWU5loEP54VE4ry3dx0
 gNRQ==
X-Gm-Message-State: AOJu0Yxo9UGmNbBZhHiwYXtHIX9MsWmaVF3YMYlDoNY/clRYJIcnXcA/
 cUtA70W/IQ6L+ccj0lB4PMj2kfMjEeiPEoxFJ61T+0qL1NHFz4dth6Kz/8fFrT205BsXClgfsSu
 O/KRxhwypelI8xK8vJmMWVUCUIJDJpBaRjGeoQIGwVip14+ZdWQAPum8QeRoU0kBctJjpf3e3K+
 INJZuPnuUbif+Fxuz4na8fr4X6+B228d1ecQ==
X-Received: by 2002:a05:6214:5411:b0:6cb:ee08:d4c1 with SMTP id
 6a1803df08f44-6d1856c4a8cmr271025556d6.13.1730303885064; 
 Wed, 30 Oct 2024 08:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk5gSrGBUIiTsDaJSjzfnOaaIwNnmO/TG15vPt/ryAgxB6jM3CKl97CDg/ODol3O+GWP2l2A==
X-Received: by 2002:a05:6214:5411:b0:6cb:ee08:d4c1 with SMTP id
 6a1803df08f44-6d1856c4a8cmr271025216d6.13.1730303884570; 
 Wed, 30 Oct 2024 08:58:04 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:58:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/18] migration: Drop migration_is_idle()
Date: Wed, 30 Oct 2024 11:57:32 -0400
Message-ID: <20241030155734.2141398-17-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now with the current migration_is_running(), it will report exactly the
opposite of what will be reported by migration_is_idle().

Drop migration_is_idle(), instead use "!migration_is_running()" which
should be identical on functionality.

In reality, most of the idle check is inverted, so it's even easier to
write with "migrate_is_running()" check.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241024213056.1395400-6-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  1 -
 hw/virtio/virtio-mem.c   |  2 +-
 migration/migration.c    | 21 +--------------------
 migration/ram.c          |  2 +-
 system/qdev-monitor.c    |  4 ++--
 5 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 86ef160f19..804eb23c06 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);
 
-bool migration_is_idle(void);
 bool migration_is_active(void);
 bool migration_is_device(void);
 bool migration_is_running(void);
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ae1e81d7ba..80ada89551 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -188,7 +188,7 @@ static bool virtio_mem_is_busy(void)
      * after plugging them) until we're running on the destination (as we didn't
      * migrate these blocks when they were unplugged).
      */
-    return migration_in_incoming_postcopy() || !migration_is_idle();
+    return migration_in_incoming_postcopy() || migration_is_running();
 }
 
 typedef int (*virtio_mem_range_cb)(VirtIOMEM *vmem, void *arg,
diff --git a/migration/migration.c b/migration/migration.c
index cab65ba8db..04d7e67897 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1633,25 +1633,6 @@ bool migration_in_bg_snapshot(void)
     return migrate_background_snapshot() && migration_is_running();
 }
 
-bool migration_is_idle(void)
-{
-    MigrationState *s = current_migration;
-
-    if (!s) {
-        return true;
-    }
-
-    switch (s->state) {
-    case MIGRATION_STATUS_NONE:
-    case MIGRATION_STATUS_CANCELLED:
-    case MIGRATION_STATUS_COMPLETED:
-    case MIGRATION_STATUS_FAILED:
-        return true;
-    default:
-        return false;
-    }
-}
-
 bool migration_is_active(void)
 {
     MigrationState *s = current_migration;
@@ -1730,7 +1711,7 @@ static bool is_busy(Error **reasonp, Error **errp)
     ERRP_GUARD();
 
     /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
-    if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
+    if (runstate_check(RUN_STATE_SAVE_VM) || migration_is_running()) {
         error_propagate_prepend(errp, *reasonp,
                                 "disallowing migration blocker "
                                 "(migration/snapshot in progress) for: ");
diff --git a/migration/ram.c b/migration/ram.c
index 5646a0b882..504b48d584 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4498,7 +4498,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
         return;
     }
 
-    if (!migration_is_idle()) {
+    if (migration_is_running()) {
         /*
          * Precopy code on the source cannot deal with the size of RAM blocks
          * changing at random points in time - especially after sending the
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e1..320c47b72d 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -679,7 +679,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
-    if (!migration_is_idle()) {
+    if (migration_is_running()) {
         error_setg(errp, "device_add not allowed while migrating");
         return NULL;
     }
@@ -928,7 +928,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
+    if (migration_is_running() && !dev->allow_unplug_during_migration) {
         error_setg(errp, "device_del not allowed while migrating");
         return;
     }
-- 
2.45.0


