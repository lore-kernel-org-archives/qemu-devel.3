Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F196C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOo4-0004Fr-Oq; Tue, 23 Apr 2024 18:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOml-0001eU-BU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmj-0006E6-Fm
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHiFwpcPXTwGeM1wMg4mA9U44FpxrIXACxokqBE05fs=;
 b=N6ZQS+p/QaLgAFj1ToABQVP2IiIoc/0CcoCuHs+oRwRI2/vcPLGahF7lnK6ZZo4GtOq9WM
 +rDL9Srv9Ibuu/IsW/XucXJeBtG1CIu6y30a4Qxhm9zH5Z+BrCWMgrz8FH5baQcbPIaecE
 fXX+ZGv1rmTIEFtPLFPPiqiE2bwwH1w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-HpzZVVQCMMK4oANxXcfdiA-1; Tue, 23 Apr 2024 18:38:42 -0400
X-MC-Unique: HpzZVVQCMMK4oANxXcfdiA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a01116b273so18947636d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911912; x=1714516712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHiFwpcPXTwGeM1wMg4mA9U44FpxrIXACxokqBE05fs=;
 b=VfZEva8WMrYW9xFB7kAZAAnNZf6owzFbp2bYhaKcpr4aJt6AjIBj2TBRLOJE1AukiP
 8ewWTU8x2r1kxtgHb9UUfjMbFdlUJ3lm2Or3iZK3giJILOJPrBBONbkAO6sAt/kqRzJu
 TV1mXZrwM58TM0bULSSfDPt9lLyfPmPmtTUTCOpO06FaxEYaTIb6RYQaeUcGkfqFW1h4
 78KtMWBOWzAR6WbK2hnIWkXF78dcXIz/nybeLsAMipIUzNFCFItLtBLHLDh4+ZWqxtd9
 XeSwLSV4/cZWEOJ1kAVBaSxVX3USqxBmHZQg2HGqgx9KHyD5cxDX9/XZp4jDn/f100Rp
 oSFQ==
X-Gm-Message-State: AOJu0YwAoT4rnLDDrojcrr9iY+2RYJRck8VqYXLZhEv5giweAlI+V+Ab
 GoU8p/tKVHgP7tddpoFFJcFnce5ouVd2fp1iMIh2TKmqn2dlUOdsUh+1m3jkAno4MjsrPz+8M6B
 NRXXUH8PR9h6pNwm/C05JxsaXA+SEoMgc+0jDh4MRl/stJZmMBPtvGnMJye/f9NWdn1Oa+CIpq6
 zadW6WXC0reGiCqdL99Seye4crTIifyPtSQg==
X-Received: by 2002:a05:620a:3d09:b0:790:8bbb:dd5f with SMTP id
 tq9-20020a05620a3d0900b007908bbbdd5fmr702359qkn.3.1713911912123; 
 Tue, 23 Apr 2024 15:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH30vEj532dhsnWcieIV1tSTLDAZTzEiCpLgPGxyB6em9DSscR9rMkLs95wymKQLlON0x4OXA==
X-Received: by 2002:a05:620a:3d09:b0:790:8bbb:dd5f with SMTP id
 tq9-20020a05620a3d0900b007908bbbdd5fmr702345qkn.3.1713911911396; 
 Tue, 23 Apr 2024 15:38:31 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 12/26] migration: Always report an error in block_save_setup()
Date: Tue, 23 Apr 2024 18:37:59 -0400
Message-ID: <20240423223813.3237060-13-peterx@redhat.com>
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
block_save_setup() always sets a new error.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-4-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/block.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 2b9054889a..f8a11beb37 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -367,7 +367,7 @@ static void unset_dirty_tracking(void)
     }
 }
 
-static int init_blk_migration(QEMUFile *f)
+static int init_blk_migration(QEMUFile *f, Error **errp)
 {
     BlockDriverState *bs;
     BlkMigDevState *bmds;
@@ -378,7 +378,6 @@ static int init_blk_migration(QEMUFile *f)
         BlkMigDevState *bmds;
         BlockDriverState *bs;
     } *bmds_bs;
-    Error *local_err = NULL;
     int ret;
 
     GRAPH_RDLOCK_GUARD_MAINLOOP();
@@ -406,6 +405,8 @@ static int init_blk_migration(QEMUFile *f)
             continue;
         }
         if (sectors < 0) {
+            error_setg(errp, "Error getting length of block device %s",
+                       bdrv_get_device_name(bs));
             ret = sectors;
             bdrv_next_cleanup(&it);
             goto out;
@@ -442,9 +443,8 @@ static int init_blk_migration(QEMUFile *f)
         bs = bmds_bs[i].bs;
 
         if (bmds) {
-            ret = blk_insert_bs(bmds->blk, bs, &local_err);
+            ret = blk_insert_bs(bmds->blk, bs, errp);
             if (ret < 0) {
-                error_report_err(local_err);
                 goto out;
             }
 
@@ -714,6 +714,7 @@ static void block_migration_cleanup(void *opaque)
 static int block_save_setup(QEMUFile *f, void *opaque)
 {
     int ret;
+    Error *local_err = NULL;
 
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -721,18 +722,27 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     warn_report("block migration is deprecated;"
                 " use blockdev-mirror with NBD instead");
 
-    ret = init_blk_migration(f);
+    ret = init_blk_migration(f, &local_err);
     if (ret < 0) {
+        error_report_err(local_err);
         return ret;
     }
 
     /* start track dirty blocks */
     ret = set_dirty_tracking();
     if (ret) {
+        error_setg_errno(&local_err, -ret,
+                         "Failed to start block dirty tracking");
+        error_report_err(local_err);
         return ret;
     }
 
     ret = flush_blks(f);
+    if (ret) {
+        error_setg_errno(&local_err, -ret, "Flushing block failed");
+        error_report_err(local_err);
+        return ret;
+    }
     blk_mig_reset_dirty_cursor();
     qemu_put_be64(f, BLK_MIG_FLAG_EOS);
 
-- 
2.44.0


