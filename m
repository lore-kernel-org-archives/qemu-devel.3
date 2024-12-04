Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19874E77160
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcT-0003Bx-Of; Tue, 03 Dec 2024 19:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcO-00039n-IN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcM-0005SU-0c
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eO5MPkyUkZyqcYRHcQpN0Gixuc0Ku87NoiXHCs64ME=;
 b=iltn93Gu5jIxo0TwHzgaT9jWoiuRpkWn4ldozmllCknrWi2KwDoQ3tSIoFnDDCFqkVZ91u
 BhvYHTLwsTc7LzTxf7rekpvlKzYjPJEVBIIPz03+tD2C5I4btFbgccmL4aAEa9xPwaWxdr
 hwshsRZdcabEJkQEiPcuZfm1/Nbds50=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-CnKCJla8OHq70XaYlIhYlg-1; Tue, 03 Dec 2024 19:51:48 -0500
X-MC-Unique: CnKCJla8OHq70XaYlIhYlg-1
X-Mimecast-MFC-AGG-ID: CnKCJla8OHq70XaYlIhYlg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b677151a03so749213985a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273507; x=1733878307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eO5MPkyUkZyqcYRHcQpN0Gixuc0Ku87NoiXHCs64ME=;
 b=o2dyUyA/YkJQIUGTiDQDY/K7Du3FzqPuTt5uNPX/Ax0k57krUgYhXlAmP+6pkl9xGS
 TYZ/Uu6zPhennVqS/tX4m45VgBq730y6IdqRSPBEkwTqmTTC7DMfDS7gsxC3xDKp7M9b
 WW+AgbA2jR/y2y+9PXMCQ0rPA96LWJA1Z0PhoCis3sV+BiVY1/Zp5F7yVDNbuKZFH83e
 RNm9Ch8RibjbxGUyenZbLW2SaSd4z+BnyHOFoL+QQzX/mYPHU/g3zb7l0T+K7vzaZEh4
 Peecrh499TlncBY3BFMdVOmhMuWhwoFavKUqqZFTS1EZW5pkQQVPID7H9pNCPt9x0kHl
 bqcw==
X-Gm-Message-State: AOJu0YziMHI1Z+L+knxuWCR/85aQOdAIMIdqLw5MFSk7quApD6U5hNVl
 vfOLCtIVE5OA4njb0bj3NadPsEAotY1ojOljTkfZOcUCms91Zwbi3qUa3CM84Yw1LpD8Lmc7vuo
 qmiTviII7Fv6dfd+cWgapw1enIjMhshvvRBHuivPgjU3SJczE7PsWocgAvV7dsHelPfC4vf8qW8
 K+9cNEhMdcchBxaopikoOi4nRyX9m1lP6JVQ==
X-Gm-Gg: ASbGncsCmYOd7SEaMWIORGFUu0Ffhfgey9D154bZOvHpbA5BlXQyRKfWCyt9sGNSxfA
 iD9l9sdhhcArZyQEfpOCvOu0Gq7rg9WOjOgKfQiUO0a9x1VOs2Zf9VOESStcyQlXsYQ7+YfiTRF
 vD9FZdjCTPv3igF+4lmMvWHxDwvK9USWfF2JzcDjAUnWx13twOrY0BA+iVz1H1Iqr+ziOkaHVBF
 szmGaCPuUE2e+e01x+Rvm6sOkV1kHgVh90UumURZn+2hKJ48IMy0RTxZ5OhTaGL1jWDf1OgSBLB
 MTgjzNIJfO1Rlw0dzLGTeRxUNw==
X-Received: by 2002:a05:620a:1a9e:b0:7af:cfc0:7822 with SMTP id
 af79cd13be357-7b6a61a70d1mr404977685a.33.1733273507118; 
 Tue, 03 Dec 2024 16:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg7yUx65HgLNiULxwoxOsjqoo1vP731Ts1QmtCkUb8n+BsSydYEEwKAKA54EEupxWWV13QUQ==
X-Received: by 2002:a05:620a:1a9e:b0:7af:cfc0:7822 with SMTP id
 af79cd13be357-7b6a61a70d1mr404975285a.33.1733273506763; 
 Tue, 03 Dec 2024 16:51:46 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:46 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 03/11] migration/block: Apply late-block-active behavior
 to postcopy
Date: Tue,  3 Dec 2024 19:51:30 -0500
Message-ID: <20241204005138.702289-4-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Postcopy never cared about late-block-active.  However there's no mention
in the capability that it doesn't apply to postcopy.

Considering that we _assumed_ late activation is always good, do that too
for postcopy unconditionally, just like precopy.  After this patch, we
should have unified the behavior across all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 98821c8120..0d52fe522c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2137,22 +2137,19 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-announced");
 
-    /* Make sure all file formats throw away their mutable metadata.
-     * If we get an error here, just don't restart the VM yet. */
-    bdrv_activate_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        local_err = NULL;
-        autostart = false;
-    }
-
-    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
-
     dirty_bitmap_mig_before_vm_start();
 
     if (autostart) {
-        /* Hold onto your hats, starting the CPU */
-        vm_start();
+        /* Make sure all file formats throw away their mutable metadata.
+         * If we get an error here, just don't restart the VM yet. */
+        bdrv_activate_all(&local_err);
+        trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        } else {
+            vm_start();
+        }
     } else {
         /* leave it paused and let management decide when to start the CPU */
         runstate_set(RUN_STATE_PAUSED);
-- 
2.47.0


