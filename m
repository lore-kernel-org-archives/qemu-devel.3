Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D1AE77160
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcT-0003Bv-MK; Tue, 03 Dec 2024 19:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcQ-0003AX-Iz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcO-0005Sg-B3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bj8MGswrXWKOgEfQ2x9IDB2aXSksN2FVHW5jduhyU+Q=;
 b=LHtzQ7QONTVi9BPotbwkR4wGa2iw7iyHWCSF4wzkk3EqmWZ4YiVAi3uuVp1IFk3jJzbRWm
 DIxcFbaGR7+qhUqfpNCVJhr5kDUShMeT5lycBuC99XitcGdI4MQK2CsgP6G8+7eOY2zjo9
 hHDWfGTwQOAv5Rf89XSNZfczd6jVyhw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-H3vZ0emfMpypT23YOmEWyA-1; Tue, 03 Dec 2024 19:51:46 -0500
X-MC-Unique: H3vZ0emfMpypT23YOmEWyA-1
X-Mimecast-MFC-AGG-ID: H3vZ0emfMpypT23YOmEWyA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b674755f8eso973388385a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273505; x=1733878305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bj8MGswrXWKOgEfQ2x9IDB2aXSksN2FVHW5jduhyU+Q=;
 b=ZOt9jZfEhoG+MOka6BBcKLDj1w2Wh6boOw8KFIYZ/F1Xg0nW/tMqcgbzRepc4/l8FB
 cvB0Qro+llF308i2xjuOfpCpkoy6ChsIAg//dGMJYLczsAIS1LpYT4cjOrR1n5FB/C96
 Au78yWp+rl7UeiCHTEs3sZlG53tlYyxpD/d8T7C2UhC3R6H+RZRjelF2Ly1auQCqu7vD
 hJjEeviOLzn2WJ+x/anBW9mId/PRY2RXZgh5FmALCIdXBZ8GXBFaxzE+5QQiXpS/oAAt
 kOZE2OMJQUsxQm8FPqfUKCfMKxts1EYm1E9lqjOETkt+fGCugTF8jyXKdNVJ7hJnf1YN
 NlgA==
X-Gm-Message-State: AOJu0Yz0KJLyGfwGZnilqHmaq5i5qY9E1fgVzNUkadXJ7j1GZ7AR5rYb
 T70Wy6sKUAAG/WcQqRhCSEs6e7YkU5g86lrT6W8lC5B9RWsaiY3Ve1LxJQysn6ki0VNxPP7LD+X
 jbM86CHwurRdkfGM0ZTRGpIJTC065h1L7qtnnPrD9tzjNOI0d0tQw8p9aJw/vez2FXHZYOngvBK
 5Bzw+Ra3rzGAIbUWoHQRj22KQ2JxfTc7X14g==
X-Gm-Gg: ASbGncv+Xdk5lARTcSJndsZZoh3bthxn/byd8G8jeImjkyjmWaU07Jy2FEim2ihUGv9
 W02+Dr/blTvzpEegQ+RC1nX/J6aAz8+xzGstIRBriryNEVXciveMspG05nGCEhj0lIki2W99RPD
 +LswVwYL3caOKiLCo2JHliTsx8peWO75vZ3/nMrIMXHFlFXgLOmA7UHI4/2SH8Or57DhIZorZ9z
 sgcTvpNE5OJpyuosywM7+4e4VPJSbGB2dKEIAocMYLS6wZTsBlUEJ8df26Skh6nvo9CRFdo4qV0
 2MYx+8YAPfFSMF4isIvC+Isceg==
X-Received: by 2002:a05:620a:4089:b0:7b6:773f:4bd3 with SMTP id
 af79cd13be357-7b6a619aa85mr512943585a.41.1733273505181; 
 Tue, 03 Dec 2024 16:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA9ZLwy+VY7F5c8FJAvgQAzm9ryKvqIDEYug7Ue8bxh4rdmsvy1gpAYngRmZWIWcgPCgeBeA==
X-Received: by 2002:a05:620a:4089:b0:7b6:773f:4bd3 with SMTP id
 af79cd13be357-7b6a619aa85mr512939985a.41.1733273504711; 
 Tue, 03 Dec 2024 16:51:44 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:43 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 02/11] migration/block: Make late-block-active the default
Date: Tue,  3 Dec 2024 19:51:29 -0500
Message-ID: <20241204005138.702289-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Migration capability 'late-block-active' controls when the block drives
will be activated.  If enabled, block drives will only be activated until
VM starts, either src runstate was "live" (RUNNING, or SUSPENDED), or it'll
be postponed until qmp_cont().

Let's do this unconditionally.  There's no harm to delay activation of
block drives.  Meanwhile there's no ABI breakage if dest does it, because
src QEMU has nothing to do with it, so it's no concern on ABI breakage.

IIUC we could avoid introducing this cap when introducing it before, but
now it's still not too late to just always do it.  Cap now prone to
removal, but it'll be for later patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d2a6b939cf..e6db9cfc50 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -743,24 +743,6 @@ static void process_incoming_migration_bh(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-enter");
 
-    /* If capability late_block_activate is set:
-     * Only fire up the block code now if we're going to restart the
-     * VM, else 'cont' will do it.
-     * This causes file locking to happen; so we don't want it to happen
-     * unless we really are starting the VM.
-     */
-    if (!migrate_late_block_activate() ||
-        (autostart && runstate_is_live(migration_get_target_runstate()))) {
-        /* Make sure all file formats throw away their mutable metadata.
-         * If we get an error here, just don't restart the VM yet. */
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-            autostart = false;
-        }
-    }
-
     /*
      * This must happen after all error conditions are dealt with and
      * we're sure the VM is going to be running on this host.
@@ -775,7 +757,25 @@ static void process_incoming_migration_bh(void *opaque)
 
     if (runstate_is_live(migration_get_target_runstate())) {
         if (autostart) {
-            vm_start();
+            /*
+             * Block activation is always delayed until VM starts, either
+             * here (which means we need to start the dest VM right now..),
+             * or until qmp_cont() later.
+             *
+             * We used to have cap 'late-block-activate' but now we do this
+             * unconditionally, as it has no harm but only benefit.  E.g.,
+             * it's not part of migration ABI on the time of disk activation.
+             *
+             * Make sure all file formats throw away their mutable
+             * metadata.  If error, don't restart the VM yet.
+             */
+            bdrv_activate_all(&local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                local_err = NULL;
+            } else {
+                vm_start();
+            }
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-- 
2.47.0


