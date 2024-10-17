Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABBCD2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KEA-0001gg-8K; Thu, 17 Oct 2024 02:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE9-0001gX-JP
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:17 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE7-0005Gr-Sa
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:17 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2bb1efe78so406068a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729147394; x=1729752194;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kD9H2eZxfztUOY4sM1Cm1FWeUikKoaPzRcd0R4WpRJc=;
 b=g0pACeirIbirlYI1PNxKq1pe0GbrGUsWCldv0KTCYMdxphz9cErK6w7TbdusQ7JHQT
 UgldLzY6RTLkug4O0HqyLAfU3MaWSnx9qptGXae5FsmRJuNtbCrb2FUDTAiAiasYguUe
 R7ptOhWoikIgCVyX/LNT1AZab0mQl3pUVhOl/2FfezOUq3zbBqCnRwhmApTcqqC94Tbw
 Nfjkw3TrMfhZudJV3GDFZoBtfS99CcZ8OENneMwRiXGrieZDYF+giMjHew5f38zqOxWM
 h4oHYBmsjRog/LXfXsFEqi41r19HzEKV8sKiCNeuwB6LyIh2eI5LvYgb9oWLp1gh+cIA
 64wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147394; x=1729752194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kD9H2eZxfztUOY4sM1Cm1FWeUikKoaPzRcd0R4WpRJc=;
 b=f8RcAZjvVfDvXks7L/g3p60ZHJPwDuF6MJfLD96GBOK9HapmvyzjorU32j9vr6v+U4
 zRCxfH5H+cOvn+O6Ev9IFX26sFEWioDbPWB2+QalrGa1CIyLdA7Bvxh7khMkRaVy4kDs
 CXyj5HVekXDF77dyJlncX2F1cKKuvP9h85xtcf6dCKz/4k2oy6evDIglRCiDDaLcv5g+
 U9NRRRx789z1TUzJn6R9C/8/XD7Yi68QhIKMWdAs8PTYhIpRNISez7NPPfLDnhG3oWgd
 gClSQd6gTi9757tR9g1Upd7emj7u/9dWDJr1q/mIsu26DQUTMLX7W2m9x1MQRAMdVfql
 a25g==
X-Gm-Message-State: AOJu0YztNCmlCXKLynYtneSWwp4d17BAd14oTtEAhswAifqzcTDVW+U6
 Uvubc5sz0NsVVm3VmOPlPUB7H2ghXS+i/S4dlkVMD2QgyQfWfgs00ngKqltHXdxk78dNZihJX7a
 mnX6CoQ==
X-Google-Smtp-Source: AGHT+IHdozgOdudHQcrsqoXC2kB/nT3IoXDzAtZT8zKk5SPi/sKegswRILxhQjgKzXWdUOLIRUvMfg==
X-Received: by 2002:a17:90b:3706:b0:2e2:ada8:2986 with SMTP id
 98e67ed59e1d1-2e3dc29e5fdmr3433093a91.16.1729147393730; 
 Wed, 16 Oct 2024 23:43:13 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08eba12sm1044372a91.29.2024.10.16.23.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 23:43:13 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 3/6] migration: Move cpu-throttole.c from system to
 migration
Date: Thu, 17 Oct 2024 14:42:52 +0800
Message-Id: <c1b3efaa0cb49e03d422e9da97bdb65cc3d234d1.1729146786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 {system => migration}/cpu-throttle.c         | 2 +-
 {include/sysemu => migration}/cpu-throttle.h | 0
 migration/meson.build                        | 1 +
 migration/migration.c                        | 5 ++++-
 migration/ram.c                              | 2 +-
 migration/trace-events                       | 3 +++
 system/cpu-timers.c                          | 3 ---
 system/meson.build                           | 1 -
 system/trace-events                          | 3 ---
 9 files changed, 10 insertions(+), 10 deletions(-)
 rename {system => migration}/cpu-throttle.c (99%)
 rename {include/sysemu => migration}/cpu-throttle.h (100%)

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
diff --git a/include/sysemu/cpu-throttle.h b/migration/cpu-throttle.h
similarity index 100%
rename from include/sysemu/cpu-throttle.h
rename to migration/cpu-throttle.h
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
diff --git a/migration/migration.c b/migration/migration.c
index 37a200a177..2e10ca77af 100644
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
2.27.0


