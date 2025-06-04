Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A9CC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoAe-0006yK-Gq; Wed, 04 Jun 2025 09:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAc-0006u7-3O
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAa-0004jg-Dw
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhSz5JkY5LLfO9JP0DfYyzUrOP4ozA4C0+gHoyFHmps=;
 b=aqDolU5ojYaTQOQl72Xs5Ms64lfu4dnUR6xv26Bjvy9kAPsB+tx8t9+U70RiFUTb/4EpSg
 T6KD9kf95yyS/h3tfTphCwHFODTi7tlexRkx1RfRuJyYGXURpZhAVTSwkdSgS57vITHOql
 6NQmLxMh3GBuFJQRiJF1cxCOuda80bI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-sEwaOvjzM42YMcDZstQDNg-1; Wed, 04 Jun 2025 09:28:38 -0400
X-MC-Unique: sEwaOvjzM42YMcDZstQDNg-1
X-Mimecast-MFC-AGG-ID: sEwaOvjzM42YMcDZstQDNg_1749043717
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450df53d461so38833765e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043717; x=1749648517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhSz5JkY5LLfO9JP0DfYyzUrOP4ozA4C0+gHoyFHmps=;
 b=XMN55O9spQFr4pIe1irrqAXmiv12vE80HRMDJADe6SpWuGCFYJvovbEji30KT/16zH
 pcKpIesAqBvTk7dCBsOy9Q+8Q6o9spPou1uYDAldvlZ4deC4AEma+O6DLvlfTmMBVh58
 I95Wu4l5W+5zcAhHlFFSi+u7aMrIS/o7yJAsvU3Oyp2Gj4OjzPD330xlwfahT6w7498H
 cTTxbJwC23pYhOW0deo8XvUmupEjwFZuxDyu++UAYaHZhnXEXjc88SvgkCDzHNg/24CX
 aT/xg1iOFx0dKOA7mwhEH0YD/Iaydb/vCJwMTFAXeXrwpmeCaufmhIsM5elKyT4CjBv6
 f2zw==
X-Gm-Message-State: AOJu0YyROB9v70XUuLKTC0Mj5wPofyv7MAOhiQyYLqdotZ5OfkRpHgex
 qVKJG+eezgbEnym3PoNyODNRlBuIiTY2p1nq/fk/snTJyo024PfGfzlc+UcuxoRTcymoVtpSlt8
 VICBGJab8e5YoggoKy3Kd7GsDEFAWEOEHYu4RaapKMBjjrXLoVOt0mO4T
X-Gm-Gg: ASbGnct8uiqAF8wEnfEmD2BjGFqcKmqMtDLGtyy5biEN50nmHO6RZhn8EzLDSW4BVui
 pcltY1fGGGStmKoHJzeT11d3YhmXSnGZebJV01Ex9QyPtBpeXqYpHQSKRDK5v5jCI120Ks24gkb
 cEVMPjujg43VqUDNqQcGQv1FrbraxXKqOHhsIXpwYJh7jf5vyP6iL5JXh5kk1wMz1lbpqpjQX4K
 RdUYwI4Swr05PeBaJKL3MiDu8e3e89JQ3ruGY7RApsBK+Ge5qWrlEYsQuHp69rLjHr3Ppzk2EaA
 UhRW3rYeh1r9F0+3Sho2pjMRz96ck7efIyGhj//ssDnTzwlD86icCdWHtyg1mfHJxv07Qw==
X-Received: by 2002:a05:600c:19c6:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-451f0b0d5cdmr20191245e9.21.1749043717208; 
 Wed, 04 Jun 2025 06:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjEb3i0pDXSToa+sZvdhva1bDq/zVIpDVWfgJNkk1CFvqYKhwpUCtz7xMITElxWqCWMpAMQQ==
X-Received: by 2002:a05:600c:19c6:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-451f0b0d5cdmr20190965e9.21.1749043716752; 
 Wed, 04 Jun 2025 06:28:36 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe2b35dsm21612708f8f.0.2025.06.04.06.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:34 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 05/21] fuse: Change setup_... to mount_fuse_export()
Date: Wed,  4 Jun 2025 15:27:57 +0200
Message-ID: <20250604132813.359438-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There is no clear separation between what should go into
setup_fuse_export() and what should stay in fuse_export_create().

Make it clear that setup_fuse_export() is for mounting only.  Rename it,
and move everything that has nothing to do with mounting up into
fuse_export_create().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 49 ++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 60d68d8fdd..01a5716bdd 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -72,8 +72,7 @@ static void fuse_export_delete(BlockExport *exp);
 
 static void init_exports_table(void);
 
-static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
-                             bool allow_other, Error **errp);
+static int mount_fuse_export(FuseExport *exp, Error **errp);
 static void read_from_fuse_export(void *opaque);
 
 static bool is_regular_file(const char *path, Error **errp);
@@ -193,23 +192,32 @@ static int fuse_export_create(BlockExport *blk_exp,
     exp->st_gid = getgid();
 
     if (args->allow_other == FUSE_EXPORT_ALLOW_OTHER_AUTO) {
-        /* Ignore errors on our first attempt */
-        ret = setup_fuse_export(exp, args->mountpoint, true, NULL);
-        exp->allow_other = ret == 0;
+        /* Try allow_other == true first, ignore errors */
+        exp->allow_other = true;
+        ret = mount_fuse_export(exp, NULL);
         if (ret < 0) {
-            ret = setup_fuse_export(exp, args->mountpoint, false, errp);
+            exp->allow_other = false;
+            ret = mount_fuse_export(exp, errp);
         }
     } else {
         exp->allow_other = args->allow_other == FUSE_EXPORT_ALLOW_OTHER_ON;
-        ret = setup_fuse_export(exp, args->mountpoint, exp->allow_other, errp);
+        ret = mount_fuse_export(exp, errp);
     }
     if (ret < 0) {
         goto fail;
     }
 
+    g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
+
+    aio_set_fd_handler(exp->common.ctx,
+                       fuse_session_fd(exp->fuse_session),
+                       read_from_fuse_export, NULL, NULL, NULL, exp);
+    exp->fd_handler_set_up = true;
+
     return 0;
 
 fail:
+    fuse_export_shutdown(blk_exp);
     fuse_export_delete(blk_exp);
     return ret;
 }
@@ -227,10 +235,10 @@ static void init_exports_table(void)
 }
 
 /**
- * Create exp->fuse_session and mount it.
+ * Create exp->fuse_session and mount it.  Expects exp->mountpoint,
+ * exp->writable, and exp->allow_other to be set as intended for the mount.
  */
-static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
-                             bool allow_other, Error **errp)
+static int mount_fuse_export(FuseExport *exp, Error **errp)
 {
     const char *fuse_argv[4];
     char *mount_opts;
@@ -243,7 +251,7 @@ static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
      */
     mount_opts = g_strdup_printf("max_read=%zu,default_permissions%s",
                                  FUSE_MAX_BOUNCE_BYTES,
-                                 allow_other ? ",allow_other" : "");
+                                 exp->allow_other ? ",allow_other" : "");
 
     fuse_argv[0] = ""; /* Dummy program name */
     fuse_argv[1] = "-o";
@@ -256,30 +264,17 @@ static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
     g_free(mount_opts);
     if (!exp->fuse_session) {
         error_setg(errp, "Failed to set up FUSE session");
-        ret = -EIO;
-        goto fail;
+        return -EIO;
     }
 
-    ret = fuse_session_mount(exp->fuse_session, mountpoint);
+    ret = fuse_session_mount(exp->fuse_session, exp->mountpoint);
     if (ret < 0) {
         error_setg(errp, "Failed to mount FUSE session to export");
-        ret = -EIO;
-        goto fail;
+        return -EIO;
     }
     exp->mounted = true;
 
-    g_hash_table_insert(exports, g_strdup(mountpoint), NULL);
-
-    aio_set_fd_handler(exp->common.ctx,
-                       fuse_session_fd(exp->fuse_session),
-                       read_from_fuse_export, NULL, NULL, NULL, exp);
-    exp->fd_handler_set_up = true;
-
     return 0;
-
-fail:
-    fuse_export_shutdown(&exp->common);
-    return ret;
 }
 
 /**
-- 
2.49.0


