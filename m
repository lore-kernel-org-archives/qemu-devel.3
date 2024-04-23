Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C770C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnK-0002UC-5y; Tue, 23 Apr 2024 18:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmg-0001UD-Tk
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOme-000698-Sp
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ogjs6JiK3ymb5glUm0diONQbHxJ9m7jWp7BW4NE78Cw=;
 b=bhx+YXyPMhRTeN1JpA2sJUthnyoOpBZ4LckHp+Es/5+78dRvsPi23i8aIk2mx0+AIuHWIg
 LSub/uB55W15LYdsQnQcPLsnWk3ulzRSN2uPdLyZzt+pItkifktNLRr+EUOrWSeKt/XwrU
 X4dzZKgytfKmc0QW4NubT6cS3t5bFAQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-o6EwdA3mMNO3gWYhAG24-g-1; Tue, 23 Apr 2024 18:38:38 -0400
X-MC-Unique: o6EwdA3mMNO3gWYhAG24-g-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c73b325809so1693871b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911917; x=1714516717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ogjs6JiK3ymb5glUm0diONQbHxJ9m7jWp7BW4NE78Cw=;
 b=cuz9FshWgc6hIsdV30f3Y1ezrwA1XeZTaEBu1irRgmN3g9vsc1bSJqhQZ4AKGLc8Wd
 w/PsLemtNGJdfsdQUhBbMgM96YQKLNM37KhqiBPiTqZMiIO2qMoWUk3rijdaHGG1DRVa
 t6EBeTLJ6c8gf+sPbsgoINU2PQKUhBoY5snRRf/SZ2gJ7uN4W4vwDYl2STEnhD/5UcIV
 jw8C+6f79mKtZPaFJje8sV2lH4UEtdudFoz637JpbaMulWCuTZOUw+XddmCsjCgET/tK
 qVw8OHE5/CQMxg5Nd1G3QjQL6p5mF1gOBJbkk6mdrfWf066sje2BnsyS7cZc67Ima2YG
 omMg==
X-Gm-Message-State: AOJu0YwKqRzSTueGY+dU8wmQ4tGKWkH8qgijX4Y8ECv8BYRz2BfR1aZd
 tAH0hpSIhXkTbYBNwnTmljBnt+GBnEWYR0n7v3OngFdso14DY+AMp/cDyQoYIP/z/KQoyFS3BR4
 G+FPRDB77/F6KSvAzp8Xa0glSqOKIEkqvodRzm5BkRJuHKuuiDoWh7N2/wuuA2io5LkqsebA+Ab
 dMxzaPt9F1I4ljCBg4vCi22fX1JFuWWEopIA==
X-Received: by 2002:a05:6808:1a10:b0:3c7:528b:12ce with SMTP id
 bk16-20020a0568081a1000b003c7528b12cemr723306oib.3.1713911917437; 
 Tue, 23 Apr 2024 15:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk1Fcr2csB3J0r8mRoRKkylxewfwvuEvKvKqj2IBDoNZnVxUsz/id7MQh+2gfoNWObHAu8qg==
X-Received: by 2002:a05:6808:1a10:b0:3c7:528b:12ce with SMTP id
 bk16-20020a0568081a1000b003c7528b12cemr723278oib.3.1713911916787; 
 Tue, 23 Apr 2024 15:38:36 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/26] migration: Add Error** argument to .load_setup() handler
Date: Tue, 23 Apr 2024 18:38:04 -0400
Message-ID: <20240423223813.3237060-18-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

This will be useful to report errors at a higher level, mostly in VFIO
today.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-9-clg@redhat.com
[peterx: drop comment for ERRP_GUARD, per Markus]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h |  3 ++-
 hw/vfio/migration.c          |  9 +++++++--
 migration/ram.c              |  3 ++-
 migration/savevm.c           | 11 +++++++----
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 64fc7c1103..f60e797894 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -234,10 +234,11 @@ typedef struct SaveVMHandlers {
      *
      * @f: QEMUFile where to receive the data
      * @opaque: data pointer passed to register_savevm_live()
+     * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error
      */
-    int (*load_setup)(QEMUFile *f, void *opaque);
+    int (*load_setup)(QEMUFile *f, void *opaque, Error **errp);
 
     /**
      * @load_cleanup
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 5763c0b683..06ae40969b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -588,12 +588,17 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
     }
 }
 
-static int vfio_load_setup(QEMUFile *f, void *opaque)
+static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
+    int ret;
 
-    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
                                    vbasedev->migration->device_state);
+    if (ret) {
+        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
+    }
+    return ret;
 }
 
 static int vfio_load_cleanup(void *opaque)
diff --git a/migration/ram.c b/migration/ram.c
index 6ea5a06e00..4cd4f0158c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3704,8 +3704,9 @@ void colo_release_ram_cache(void)
  *
  * @f: QEMUFile where to receive the data
  * @opaque: RAMState pointer
+ * @errp: pointer to Error*, to store an error if it happens.
  */
-static int ram_load_setup(QEMUFile *f, void *opaque)
+static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     xbzrle_load_setup();
     ramblock_recv_map_init();
diff --git a/migration/savevm.c b/migration/savevm.c
index a2679ba0b8..5d200cf42a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2768,8 +2768,9 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
     trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
 }
 
-static int qemu_loadvm_state_setup(QEMUFile *f)
+static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     SaveStateEntry *se;
     int ret;
 
@@ -2784,10 +2785,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
             }
         }
 
-        ret = se->ops->load_setup(f, se->opaque);
+        ret = se->ops->load_setup(f, se->opaque, errp);
         if (ret < 0) {
+            error_prepend(errp, "Load state of device %s failed: ",
+                          se->idstr);
             qemu_file_set_error(f, ret);
-            error_report("Load state of device %s failed", se->idstr);
             return ret;
         }
     }
@@ -2968,7 +2970,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f) != 0) {
+    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
+        error_report_err(local_err);
         return -EINVAL;
     }
 
-- 
2.44.0


