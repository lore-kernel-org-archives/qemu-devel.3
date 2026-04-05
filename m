Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D461E9D809
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9PN1-0006ls-6m; Sun, 05 Apr 2026 11:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9PMz-0006l7-K1
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 11:26:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9PMx-0008Rv-Ue
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 11:26:37 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82cd5c07f93so1425100b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775402794; x=1776007594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtzvMbJwqmZg1QTzQYdfCcfO+oD+mRx9jQ0oIMWTBPI=;
 b=IHl8HVgdq9JulcAQVkYqXGw5Dedj3klnXfyDvsZe8+iSRgkLxaFh//Dh3n4Qhi0WY7
 x5igdQHwTqz8If8iioFZgkikuyZqxg9efYAtMr6dH2wDZhRid4l7B9BNdxFY59mtJFj0
 uKOdn9kRP2uvisGZk2NQUsX+kgXxADkuWrF6gr0WVB+AtxjEud659ot+4B+ttWHPw+N1
 qLntehftutxxumOlVdGYB5aDcmB7iw2eoTMvDdAkxtkHylRSc4OrZYo6igZ4HuVj/D8f
 cl4sGXZPSuK0OkglbxLfzTkbBByeFi/We7gftZpWlJpWjKna9t8viK9SM0S4K6yMvED0
 AvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775402794; x=1776007594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vtzvMbJwqmZg1QTzQYdfCcfO+oD+mRx9jQ0oIMWTBPI=;
 b=DK1qMoYWsLo6RAVOKYjvGa9PeTeJ79hKg/utHIEBHg5WfrY+nwuHxcKbpMp6F+RchU
 X6aL4vufldjroP+W4r0f9omZSKPVh2hfdQZFagkqgJSocZBgh3OVfoQOW6EKLYlAOH9T
 zSbBwdwF+SPHHY9ocla1vhh/FDVEQVA/8iw4D9JPpAycIWs52ePupBO9FYcW/1kkVR1U
 h9RO9AHPyByDmvc9ONhcqCwMYxM4yFUh1EewKwC12a4+KH2lk0ekzJf1B76yM2K4tRyq
 GKvH2n6DgHBwur8LqQlu+qJ72X+q5/Z/0ml8GlkpyxOGZF4Y+t3fIZLGqT4d31BQFdTE
 hUHQ==
X-Gm-Message-State: AOJu0YxmVPYGtMbu/U5gxrXTPgDMZhJjSd2/sOBwoNsUI8f4V9yw/dv2
 GDsnrg5RBxbKl+NL6Qljlu90Fu+X/bpjvkJK+tvqrogAOOa5HD1q/MKSmCOQaFeAXD4=
X-Gm-Gg: AeBDievN0ShYEw4q5jAgVts6aUV/n9+ugtepymMgFSa3uMZW0Xud6oQUMaDHhEJNXNF
 +PnQIotkL4bpt7U2Z8+4m+JnbGVEvgHqlNYELs7HVqNcpm3m/9xUAsAZQGbgZtGQfYnQYlsMPua
 4oBRPI5e/ai7H56DPH7vhbmSejUvgQz7Wu/ze5lZf4utxv37Gb5xA5JnbVf6dkLBVUaSmApiO0Y
 tNawUpddvIya383mG/9kaDpGmTTKTfpRb9ZOM4N7+HRvsbN0XOupPph0xDJzI7IVLhWzj/7sS+g
 0HoGIeK6Z/7WAYJI25wZ0yXOZ0nx+MoCdxF1abS6Y4/xCL9wzcdexxnlEmBSEaTXd+UEwEwWtxr
 C84mPzG4qrMlJRFOHWAPPba4N8ZEKZNuKGFiXvKlmeUJhoyU7qR1kkw2PAQOEei1IWiGUjl98rY
 is/VDv4OYDSkgS6cINbpgoxUEQSRhWwIEPlqJTnXsIa2gJ9qY=
X-Received: by 2002:a05:6a00:1f0e:b0:82c:26a4:df02 with SMTP id
 d2e1a72fcca58-82d0db8b083mr8599271b3a.42.1775402794346; 
 Sun, 05 Apr 2026 08:26:34 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c72967sm11187938b3a.49.2026.04.05.08.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 08:26:33 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/2] migration: track timing and received pages in
 MigrationIncomingState
Date: Sun,  5 Apr 2026 22:26:07 +0700
Message-ID: <20260405152612.93027-2-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405152612.93027-1-viking4@gmail.com>
References: <20260405152612.93027-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x42c.google.com
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

From: Trieu Huynh <vikingtc4@gmail.com>

Add start_time, total_time, received_normal_pages,
received_zero_pages, and received_xbzrle_pages to
MigrationIncomingState.

start_time is recorded when the incoming state transitions to ACTIVE;
total_time is recorded when it transitions to COMPLETED. The page
counters are incremented in ram_load_precopy() as each page type is
received from the source.

These fields will be used by a subsequent patch to populate
fill_destination_migration_info() for the migration COMPLETED case.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/migration.c |  2 ++
 migration/migration.h | 17 +++++++++++++++++
 migration/ram.c       |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..17c9a8b344 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -726,6 +726,7 @@ static void process_incoming_migration_bh(void *opaque)
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COMPLETED);
+    mis->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - mis->start_time;
     migration_incoming_state_destroy();
 }
 
@@ -758,6 +759,7 @@ process_incoming_migration_co(void *opaque)
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
+    mis->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     mis->loadvm_co = qemu_coroutine_self();
     ret = qemu_loadvm_state(mis->from_src_file, &local_err);
     mis->loadvm_co = NULL;
diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..cd51ae452c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -176,6 +176,23 @@ struct MigrationIncomingState {
     /* PostCopyFD's for external userfaultfds & handlers of shared memory */
     GArray   *postcopy_remote_fds;
 
+    /*
+     * Timestamps for reporting migration duration via query-migrate on the
+     * destination. start_time is recorded when the state moves to ACTIVE;
+     * total_time is recorded when it moves to COMPLETED.
+     */
+    int64_t start_time;
+    int64_t total_time;
+
+    /*
+     * Page counters for reporting RAM statistics via query-migrate on the
+     * destination.  Incremented in ram_load_precopy() as each page type
+     * is received.
+     */
+    uint64_t received_normal_pages;
+    uint64_t received_zero_pages;
+    uint64_t received_xbzrle_pages;
+
     MigrationStatus state;
 
     /*
diff --git a/migration/ram.c b/migration/ram.c
index 979751f61b..6646e5daad 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4417,10 +4417,12 @@ static int ram_load_precopy(QEMUFile *f)
                 break;
             }
             ram_handle_zero(host, TARGET_PAGE_SIZE);
+            mis->received_zero_pages++;
             break;
 
         case RAM_SAVE_FLAG_PAGE:
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
+            mis->received_normal_pages++;
             break;
 
         case RAM_SAVE_FLAG_XBZRLE:
@@ -4430,6 +4432,7 @@ static int ram_load_precopy(QEMUFile *f)
                 ret = -EINVAL;
                 break;
             }
+            mis->received_xbzrle_pages++;
             break;
         case RAM_SAVE_FLAG_MULTIFD_FLUSH:
             multifd_recv_sync_main();
-- 
2.43.0


