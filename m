Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA54CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHIn-0008Cq-Ec; Tue, 21 Oct 2025 14:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIl-0008CI-GT
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIj-0004OK-EK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761072100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PhYYBUPdMAoLP+z5Vb+cys5nIJwgm1vQ8NpBfF6sNI=;
 b=BwwODp1k+4V3OoSzG/RgKdbYPHlORFauEvTlH1pGG8+TQsqejp8IZRy594ZMN+j0z6ir8K
 ozuugQhqXcnhD5GOvQTdBXMmZh9h54FG3h7y8JuIb0rJR2crXj5JZhJc6G4rrRj2wJOwIH
 mSFDrqq2x9LCvXKgw43p2/tSnEOBLTU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-NzvswkZGONamV7666lx9Mg-1; Tue, 21 Oct 2025 14:41:38 -0400
X-MC-Unique: NzvswkZGONamV7666lx9Mg-1
X-Mimecast-MFC-AGG-ID: NzvswkZGONamV7666lx9Mg_1761072098
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87c6f88fda2so5317656d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072097; x=1761676897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PhYYBUPdMAoLP+z5Vb+cys5nIJwgm1vQ8NpBfF6sNI=;
 b=jcl60MMT+O+tIih7xihH+rXGiD5aATrHsNNoKeJZKSbY1gmJb0SmFRUD1TuLbiK2aO
 LgqDj3RK/U4w0r2coCGSuuNxgKCtXFtaMKKP3cR5Hebcr70uDPBpD8sKZdAUSzotT3zO
 2yZ+KBLv8PCdgBSN1vnjp7LSY22QAkufEsBcZiP3WB0t92HY2oih3Q7TWI2r3mI+6Waf
 +jxxAJCpEyR2WLeEoDqNSyWM/gVm8lAIr6ieHD6qwl71aXF+W9aGFh3sg8HXSzFnkC9R
 8ffnirsJ4w2aFMvYRWQFULL9fNRg3NlTzM+Y/paCCAo43HTnQaLHtmtkrjYnP1Taq11E
 Jl7g==
X-Gm-Message-State: AOJu0YyOsJNQCW1d1Ujz388KOjDw9au7FAl+C6zixkn+2YF9NUQKAsTN
 cQl49lw5uzdHIfaLAkYI+UXtpdOScmogM7t2aL6xk/Ce0RxUPOkLwQirhs3fYqtR1BU6LjAwdsA
 va4wfxxKsC06VO+fJblRGR+xpcYKfqiMWr0UgnSJNhiutMJczDw9pwkp7B5Dho/wDMF0FjRDb/E
 ARr72sIBK5tauIo9bl2sUfgrxt8BjHLxHrBUw3rA==
X-Gm-Gg: ASbGncuclDBrrKV57ue9du1it8ggwtrnMpKNsNG05/tn2xGcuZtRf1cIUDF4B/9g8dV
 QVYWseS5htQTVOps385RG0mjyt1zlpITYoleGo9VQxCJ/JtelAfF9wKrmNv5WNetCKhYOWcbFjc
 Qme13AuZDZDBham6tUpIGK3L+Dlk6KqSNTk2ojODbnrar6RlyYNszPYWez8Uk9xRQT+0HIOqhKJ
 X/8tPUfk3cyN+snF5nPh/1aeDJjd4rKUwE48/P98GIpG7h09cRZOxsZ13d2pvp7jjG8VjWIcctz
 QT71PY8YW18FyGz2IVPkKk10WDEzXHMnpcB/O2b4vg4udVMV+cKnJi89idwsggMq
X-Received: by 2002:a05:6214:d03:b0:87c:19af:4b76 with SMTP id
 6a1803df08f44-87df6535524mr9740926d6.17.1761072097443; 
 Tue, 21 Oct 2025 11:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYzkWhJhTSfGQl6qtPRO3zgOxbmgV3dKvEu7sJb2nXcITPORBfiTThh/NUCW2rU1zpIQQPRQ==
X-Received: by 2002:a05:6214:d03:b0:87c:19af:4b76 with SMTP id
 6a1803df08f44-87df6535524mr9740576d6.17.1761072096903; 
 Tue, 21 Oct 2025 11:41:36 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf51fd3easm74244966d6.10.2025.10.21.11.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:41:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Arun Menon <armenon@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 1/3] migration: Fix error leak in postcopy_ram_listen_thread()
Date: Tue, 21 Oct 2025 14:41:30 -0400
Message-ID: <20251021184132.2635958-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021184132.2635958-1-peterx@redhat.com>
References: <20251021184132.2635958-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com

Fix it by freeing the error.  When at it, always reset the local_err
pointer in both paths.

Cc: Arun Menon <armenon@redhat.com>
Resolves: Coverity CID 1641390
Fixes: 94272d9b45 ("migration: Capture error in postcopy_ram_listen_thread()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index aafa40d779..635fa2f918 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2136,17 +2136,18 @@ static void *postcopy_ram_listen_thread(void *opaque)
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
             !migrate_postcopy_ram() && migrate_dirty_bitmaps())
         {
-            error_report("%s: loadvm failed during postcopy: %d. All states "
+            error_report("%s: loadvm failed during postcopy: %s. All states "
                          "are migrated except dirty bitmaps. Some dirty "
                          "bitmaps may be lost, and present migrated dirty "
                          "bitmaps are correctly migrated and valid.",
-                         __func__, load_res);
+                         __func__, error_get_pretty(local_err));
+            g_clear_pointer(&local_err, error_free);
             load_res = 0; /* prevent further exit() */
         } else {
             error_prepend(&local_err,
                           "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
-            error_report_err(local_err);
+            g_clear_pointer(&local_err, error_report_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }
-- 
2.50.1


