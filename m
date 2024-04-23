Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BA4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOo3-0004FV-T3; Tue, 23 Apr 2024 18:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmd-0001Tm-2l
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOma-00066v-5l
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84ysFweDuscU3Eqxmk0s0iRSrIUVg+aQ2rRdiLwQ8r4=;
 b=g4GesBu7Tdqwr6pWuad7zUHEhwpvZPXrNm7bywTevPxJ5RctdZakjjYdc1iG0cWgJoYhiI
 RZWheLyJS/cenuGHeGWygCkikTYj8XNszMLoZ/3gGGKSr7SxnWRYwc7YGWYXYySiB+3DnX
 5QBtxvEtzschuTVykiuxqUbMQ6km3HM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-mzvCpJQmNnGvmazs20wgiQ-1; Tue, 23 Apr 2024 18:38:32 -0400
X-MC-Unique: mzvCpJQmNnGvmazs20wgiQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c82cfb8913so931335b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911911; x=1714516711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84ysFweDuscU3Eqxmk0s0iRSrIUVg+aQ2rRdiLwQ8r4=;
 b=WuGzZcC59qhpBOAtLny5WLIjmVZIbyoEqwSV/oL4AONzdL/+8Zp3UD1200QW9de3px
 ORKQj6v5p0ViZt0TuXhasGP2nSUr9IkqPdzV/4qFEI0Bi9IKYptTw3a+ikFlYZmDaQHr
 iVHrIRUtGXmIrgEAU6WaV/p1+S0lDeXsBePUENJuk3cyFAfWLvbtx5QaZ/TzNs9Fo4J7
 ycfjVkRpew5rEN1Yzg3slWEwSsuC+khpt1is9IHTRY2Nh4m8EJNGjLWiIkAGiFus+l9H
 0cRa/YBRNa5gaXN1EBG9zonhTDXc2M/KAEJRt+Y/x459Hn202c33UjqQp6TW8yT5tDDy
 JydQ==
X-Gm-Message-State: AOJu0Yzmuw9ygxWAKpE8mEHRgvAJdNF9g0nTbFtK5117MOeFGlKDTCh7
 8D0aYx7KF4hm1w/X1NgBX/0Umjls6O+dCpEqS02vBDGhEpVH4TxXvl/TapegKQS78F5DaHOhWwL
 pjx38tr5obBsowfTC56PqHJMyRvmn2FQcrLDjWxBSuY5zNpEhJEatWxS2z3b+eOtcgFwA0H/pgn
 unKTejucExSFk36+cf8vJvDc2DVH4VtJDDxw==
X-Received: by 2002:a05:6808:308a:b0:3c7:4b27:1679 with SMTP id
 bl10-20020a056808308a00b003c74b271679mr759086oib.2.1713911911143; 
 Tue, 23 Apr 2024 15:38:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7cZpTBGtyR3X9L5H3QKXHNAnWsy1rdXhB4M5oJN+v4ljiOokZvYt1X4BBpYkAQVoo8JKjw==
X-Received: by 2002:a05:6808:308a:b0:3c7:4b27:1679 with SMTP id
 bl10-20020a056808308a00b003c74b271679mr759058oib.2.1713911910448; 
 Tue, 23 Apr 2024 15:38:30 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 11/26] vfio: Always report an error in vfio_save_setup()
Date: Tue, 23 Apr 2024 18:37:58 -0400
Message-ID: <20240423223813.3237060-12-peterx@redhat.com>
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

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
vfio_save_setup() always sets a new error.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-3-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1149c6b374..bf5a29ddc1 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -381,6 +381,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
+    int ret;
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
@@ -395,13 +396,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
     }
 
     if (vfio_precopy_supported(vbasedev)) {
-        int ret;
-
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
                                            VFIO_DEVICE_STATE_RUNNING);
             if (ret) {
+                error_report("%s: Failed to set new PRE_COPY state",
+                             vbasedev->name);
                 return ret;
             }
 
@@ -412,6 +413,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
             /* vfio_save_complete_precopy() will go to STOP_COPY */
             break;
         default:
+            error_report("%s: Invalid device state %d", vbasedev->name,
+                         migration->device_state);
             return -EINVAL;
         }
     }
@@ -420,7 +423,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
-    return qemu_file_get_error(f);
+    ret = qemu_file_get_error(f);
+    if (ret < 0) {
+        error_report("%s: save setup failed : %s", vbasedev->name,
+                     strerror(-ret));
+    }
+
+    return ret;
 }
 
 static void vfio_save_cleanup(void *opaque)
-- 
2.44.0


