Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7383CD5B86D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B51-0003Zo-7U; Wed, 30 Oct 2024 11:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4z-0003YB-Nk
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4y-0007mZ-04
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2Ri6ieB7IwH4p+D8nROEDVqJEEWkYMxiCblf72V1A4=;
 b=M8ZvIm+1V3ajEhjE/yJjNMR28MssMwYGcy58kfwqwc+ZAKHez/PCaL7aO4YGAnO613YcVO
 Nj6oPBldBcmjpMyfezHVkwn+h/7mYDy5zPR+S1QYYfF+a4+N51paXav4sRSSk4Y0TXhxBp
 JFaVDek+fPgRfd1p05zJ//8HbEwXSFc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-UwO7QnpoNOKEG5l20Y9itQ-1; Wed, 30 Oct 2024 11:57:48 -0400
X-MC-Unique: UwO7QnpoNOKEG5l20Y9itQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-71804a17e53so6878140a34.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303867; x=1730908667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2Ri6ieB7IwH4p+D8nROEDVqJEEWkYMxiCblf72V1A4=;
 b=Dvd1TCCBkZOczNMEb32ugM+8IeD+jsxjB6xUURJCtSenRcVEeE0cMhWMZwZkzsAUMR
 H96rBvWoeB+NATJJ9Ne3JI0fKp86lCLKju58jO01QuMUApagyq1VV8UioDiCVxzf7Vll
 Owg0SouvgVlYmNDqhtvsSFUiYjpLNkC5ObliN9No7huKrQ2dkM8BiMxW21+hPVgDngpJ
 GZYa2snjDl0Vk3OLK+5Uw1VqcyqPdF5TgK9ChJy7LRv/YDGgE2mSvo0qCVKgmnIss0r/
 gbuvA1Jxbag4iCNFnzChNP98BJ8UEhXLa35Qcd8OEt/SVIroxbu8+WWSblKvYQRhy+dy
 ZUXw==
X-Gm-Message-State: AOJu0Yx34J9AJaB8sKDZjNtEEO2/wSLUGh3SuWCga7NdFqc8tl06CWzt
 DCZcwuG1pl8GelBqZflnXZ2reMPeiei7pfhZvxGaPB2C2IZT545D1ZMJUDCCgRt5O224CKBufGv
 JsEBcNajX67lEX73H9umobuQ5I91ecyKjOAVXgjfei3GLz9FAOUIHgwH0KIDd6ZfIBNT+8ulMen
 PhmBhzvzFnHH0saREr8+Cw+fE2lMBwhcOTcw==
X-Received: by 2002:a05:6830:6d86:b0:70f:716c:7d4a with SMTP id
 46e09a7af769-718920b61e1mr4206091a34.27.1730303867334; 
 Wed, 30 Oct 2024 08:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgSW46v0JmeV6C3Cnu5g7Tu7DuHsVCpVPcKY9Mll5jfD4mk+aCpf/vf4ggdbVddvWKGlcQTg==
X-Received: by 2002:a05:6830:6d86:b0:70f:716c:7d4a with SMTP id
 46e09a7af769-718920b61e1mr4206065a34.27.1730303866928; 
 Wed, 30 Oct 2024 08:57:46 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 06/18] migration: Move cpu-throttole.c from system to migration
Date: Wed, 30 Oct 2024 11:57:22 -0400
Message-ID: <20241030155734.2141398-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

From: Hyman Huang <yong.huang@smartx.com>

Move cpu-throttle.c from system to migration since it's
only used for migration; this makes us avoid exporting the
util functions and variables in misc.h but export them in
migration.h when implementing the periodic ramblock dirty
sync feature in the upcoming commits.

Since CPU throttle timers are only used in migration, move
their registry to migration_object_init.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/c1b3efaa0cb49e03d422e9da97bdb65cc3d234d1.1729146786.git.yong.huang@smartx.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 {include/sysemu => migration}/cpu-throttle.h | 0
 {system => migration}/cpu-throttle.c         | 2 +-
 migration/migration.c                        | 5 ++++-
 migration/ram.c                              | 2 +-
 system/cpu-timers.c                          | 3 ---
 migration/meson.build                        | 1 +
 migration/trace-events                       | 3 +++
 system/meson.build                           | 1 -
 system/trace-events                          | 3 ---
 9 files changed, 10 insertions(+), 10 deletions(-)
 rename {include/sysemu => migration}/cpu-throttle.h (100%)
 rename {system => migration}/cpu-throttle.c (99%)

diff --git a/include/sysemu/cpu-throttle.h b/migration/cpu-throttle.h
similarity index 100%
rename from include/sysemu/cpu-throttle.h
rename to migration/cpu-throttle.h
diff --git a/system/cpu-throttle.c b/migration/cpu-throttle.c
similarity index 99%
rename from system/cpu-throttle.c
rename to migration/cpu-throttle.c
index 7632dc6143..fa47ee2e21 100644
--- a/system/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -27,7 +27,7 @@
 #include "hw/core/cpu.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
-#include "sysemu/cpu-throttle.h"
+#include "cpu-throttle.h"
 #include "trace.h"
 
 /* vcpu throttling controls */
diff --git a/migration/migration.c b/migration/migration.c
index e81c70b9d2..05c8cd50b4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -24,7 +24,7 @@
 #include "socket.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/cpu-throttle.h"
+#include "cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
@@ -263,6 +263,9 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+
+    /* Initialize cpu throttle timers */
+    cpu_throttle_init();
 }
 
 typedef struct {
diff --git a/migration/ram.c b/migration/ram.c
index 326ce7eb79..54d352b152 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,7 +52,7 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "sysemu/cpu-throttle.h"
+#include "cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 0b31c9a1b6..856e502e34 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -35,7 +35,6 @@
 #include "sysemu/runstate.h"
 #include "hw/core/cpu.h"
 #include "sysemu/cpu-timers.h"
-#include "sysemu/cpu-throttle.h"
 #include "sysemu/cpu-timers-internal.h"
 
 /* clock and ticks */
@@ -272,6 +271,4 @@ void cpu_timers_init(void)
     seqlock_init(&timers_state.vm_clock_seqlock);
     qemu_spin_init(&timers_state.vm_clock_lock);
     vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
-
-    cpu_throttle_init();
 }
diff --git a/migration/meson.build b/migration/meson.build
index 66d3de86f0..d53cf3417a 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -13,6 +13,7 @@ system_ss.add(files(
   'block-dirty-bitmap.c',
   'channel.c',
   'channel-block.c',
+  'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
   'fd.c',
diff --git a/migration/trace-events b/migration/trace-events
index c65902f042..9a19599804 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -378,3 +378,6 @@ migration_block_progression(unsigned percent) "Completed %u%%"
 # page_cache.c
 migration_pagecache_init(int64_t max_num_items) "Setting cache buckets to %" PRId64
 migration_pagecache_insert(void) "Error allocating page"
+
+# cpu-throttle.c
+cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
diff --git a/system/meson.build b/system/meson.build
index a296270cb0..4952f4b2c7 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -10,7 +10,6 @@ system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
-  'cpu-throttle.c',
   'cpu-timers.c',
   'datadir.c',
   'dirtylimit.c',
diff --git a/system/trace-events b/system/trace-events
index 074d001e90..2ed1d59b1f 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -44,6 +44,3 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
-
-# cpu-throttle.c
-cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
-- 
2.45.0


