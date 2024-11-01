Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3BDE6B27D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6rzA-0002oD-SN; Fri, 01 Nov 2024 09:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6rz9-0002nx-0E
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6rz1-0001zO-Ae
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730468793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nu+5xNHrTBU5mwDhphLRJaf4zVt4FO0grM02ffbwew=;
 b=GAKjYMr+thr4EZfTe7FzzatnRxLKOxObLbwFlRpB00rvhgP2Til5m+vpbIW/1bc8qhps0D
 l4rSEyiSNKb3HQ3SIH3bjYm6+cOoIX5b8L79hYhriTwBgUQ/sYJ/dHlvrVaJaUlA9NuTbU
 e4TDlnKB17PzKe9cuCMM35AjzunBOsM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298--nA3Gbt6PMOlBPWY0xQxhg-1; Fri, 01 Nov 2024 09:46:31 -0400
X-MC-Unique: -nA3Gbt6PMOlBPWY0xQxhg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6e9d6636498so42941867b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 06:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730468790; x=1731073590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nu+5xNHrTBU5mwDhphLRJaf4zVt4FO0grM02ffbwew=;
 b=s4NI5UonfpTzjKsnlxLNazSyk+d1ClYPp7pyrVyPC45maSBM2V72Q7lPG4YLio5MAu
 ZjagotrOLtTYoSR39ioVZqWw2+DI2qGCQXDi2BQ/gLWrxmtYe1TV/VUNNDSJ/xRFiyUW
 DXeWoUBGMLhP0AV6hY2UihcPvnIzxHfLT4bOsGEoaUbZFp1avaSTOf6VFPLEaCdinA5X
 fh0rwksk1KP/bGYYNkSPLZwdGz7n3n6F85XrhWbKd81Qa+wjK1iAYDWD6w4m+hbTAn7X
 UlbcaAlLnOqPts5PHvFDHNkgI9yIrkkVG7+WTUjVB/6UlpKySAI/iTFsygg0YvHDkU2h
 huTg==
X-Gm-Message-State: AOJu0YxZkjcuS7r44sWaGLZruiy2alb+KfiOudiUfm0NLmW/lMN70nWX
 dCzOQZz9/WAGgp6H01IR5kZERWmGmEVXBI6G5xGBepezoI93B3x5ZWLdCmp6gGPNgen6el1E5mK
 624blpu32LqS4HfjnggFvLAZZUndDSYReiITCUsskhhawi2GSrtO5RtLIq2NEbzf4TzUuBjeR2B
 +0MdoeV/oBBTIB0a86oKUxPjRr1eAfOgH2VA==
X-Received: by 2002:a05:6902:84a:b0:e2e:4315:54fd with SMTP id
 3f1490d57ef6-e30e5b0b941mr6943801276.30.1730468789662; 
 Fri, 01 Nov 2024 06:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0mjCkCh6Uew+XQaLD+nPox21oBndL6+1NEL2kaE+0u9MfdoD0eb/+vuebN/p4HKoNan56BA==
X-Received: by 2002:a05:6902:84a:b0:e2e:4315:54fd with SMTP id
 3f1490d57ef6-e30e5b0b941mr6943759276.30.1730468789162; 
 Fri, 01 Nov 2024 06:46:29 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39f7b18sm172065585a.28.2024.11.01.06.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 06:46:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Hyman Huang <yong.huang@smartx.com>
Subject: [PULL v2 06/18] migration: Move cpu-throttle.c from system to
 migration
Date: Fri,  1 Nov 2024 09:46:25 -0400
Message-ID: <20241101134625.2240813-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241101134625.2240813-1-peterx@redhat.com>
References: <20241101134625.2240813-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
[peterx: Fix build on MacOS on cocoa.m, not move cpu-throttle.h yet]
[peterx: Fix subject spelling, per pm215]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 {system => migration}/cpu-throttle.c | 0
 migration/migration.c                | 3 +++
 system/cpu-timers.c                  | 3 ---
 migration/meson.build                | 1 +
 migration/trace-events               | 3 +++
 system/meson.build                   | 1 -
 system/trace-events                  | 3 ---
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename {system => migration}/cpu-throttle.c (100%)

diff --git a/system/cpu-throttle.c b/migration/cpu-throttle.c
similarity index 100%
rename from system/cpu-throttle.c
rename to migration/cpu-throttle.c
diff --git a/migration/migration.c b/migration/migration.c
index e81c70b9d2..64c1d0c1db 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -263,6 +263,9 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+
+    /* Initialize cpu throttle timers */
+    cpu_throttle_init();
 }
 
 typedef struct {
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


