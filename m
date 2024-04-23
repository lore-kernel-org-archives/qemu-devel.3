Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A937C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnG-00053U-TA; Tue, 23 Apr 2024 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmk-0004NS-5p
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmg-00006P-Ol
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCSeEIzDnWvUBvWxUzklJfIexfxTGnWOXXLod2ADtIE=;
 b=VR/sujl/Gy60TyHDbJ/aPQRuB9r4RMYEZH64avUtzfTwYZt+1/gsXupZ4l96VL47e3KkA8
 pM6C+MoYv+Pmd9X9CvN8iwyJgH58cZqLqdNc6wcwPdPyIj8hRMQAgGBmvINpGfpU8Muiqx
 rMWJJIeBYNi8qcJZwixnWM2TUy1fHvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-4jHyxC_1ML2oe9smxHAr_A-1; Tue, 23 Apr 2024 11:10:11 -0400
X-MC-Unique: 4jHyxC_1ML2oe9smxHAr_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 410528107BF
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:11 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC903200E290
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/63] stubs: include stubs only if needed
Date: Tue, 23 Apr 2024 17:09:05 +0200
Message-ID: <20240423150951.41600-18-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Currently it is not documented anywhere why some functions need to
be stubbed.

Group the files in stubs/meson.build according to who needs them, both
to reduce the size of the compilation and to clarify the use of stubs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240408155330.522792-18-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/{monitor.c => monitor-internal.c} |   0
 stubs/meson.build                       | 122 +++++++++++++++---------
 2 files changed, 75 insertions(+), 47 deletions(-)
 rename stubs/{monitor.c => monitor-internal.c} (100%)

diff --git a/stubs/monitor.c b/stubs/monitor-internal.c
similarity index 100%
rename from stubs/monitor.c
rename to stubs/monitor-internal.c
diff --git a/stubs/meson.build b/stubs/meson.build
index 4a524f5816b..8ee1fd57530 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -1,58 +1,86 @@
-stub_ss.add(files('bdrv-next-monitor-owned.c'))
-stub_ss.add(files('blk-commit-all.c'))
-stub_ss.add(files('blk-exp-close-all.c'))
-stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
-stub_ss.add(files('change-state-handler.c'))
-stub_ss.add(files('cmos.c'))
+# If possible, add new files to other directories, by using "if_false".
+# If you need them here, try to add them under one of the if statements
+# below, so that it is clear who needs the stubbed functionality.
+
 stub_ss.add(files('cpu-get-clock.c'))
-stub_ss.add(files('cpus-get-virtual-clock.c'))
-stub_ss.add(files('qemu-timer-notify-cb.c'))
-stub_ss.add(files('icount.c'))
-stub_ss.add(files('dump.c'))
-stub_ss.add(files('error-printf.c'))
 stub_ss.add(files('fdset.c'))
-stub_ss.add(files('gdbstub.c'))
-stub_ss.add(files('get-vm-name.c'))
-stub_ss.add(files('graph-lock.c'))
-stub_ss.add(files('hotplug-stubs.c'))
-if linux_io_uring.found()
-  stub_ss.add(files('io_uring.c'))
-endif
 stub_ss.add(files('iothread-lock.c'))
-if have_block
-  stub_ss.add(files('iothread-lock-block.c'))
-endif
 stub_ss.add(files('is-daemonized.c'))
-if libaio.found()
-  stub_ss.add(files('linux-aio.c'))
-endif
-stub_ss.add(files('migr-blocker.c'))
-stub_ss.add(files('monitor.c'))
 stub_ss.add(files('monitor-core.c'))
-stub_ss.add(files('physmem.c'))
-stub_ss.add(files('qemu-timer-notify-cb.c'))
-stub_ss.add(files('qmp-command-available.c'))
-stub_ss.add(files('qmp-quit.c'))
-stub_ss.add(files('qtest.c'))
-stub_ss.add(files('ram-block.c'))
-stub_ss.add(files('replay.c'))
 stub_ss.add(files('replay-mode.c'))
-stub_ss.add(files('runstate-check.c'))
-stub_ss.add(files('sysbus.c'))
-stub_ss.add(files('target-get-monitor-def.c'))
-stub_ss.add(files('target-monitor-defs.c'))
 stub_ss.add(files('trace-control.c'))
-stub_ss.add(files('uuid.c'))
-stub_ss.add(files('vmstate.c'))
-stub_ss.add(files('vm-stop.c'))
-stub_ss.add(files('win32-kbd-hook.c'))
-stub_ss.add(files('cpu-synchronize-state.c'))
-if have_block or have_ga
+
+if have_block
+  stub_ss.add(files('bdrv-next-monitor-owned.c'))
+  stub_ss.add(files('blk-commit-all.c'))
+  stub_ss.add(files('blk-exp-close-all.c'))
+  stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
+  stub_ss.add(files('change-state-handler.c'))
+  stub_ss.add(files('get-vm-name.c'))
+  stub_ss.add(files('iothread-lock-block.c'))
+  stub_ss.add(files('migr-blocker.c'))
+  stub_ss.add(files('physmem.c'))
+  stub_ss.add(files('ram-block.c'))
   stub_ss.add(files('replay-tools.c'))
+  stub_ss.add(files('runstate-check.c'))
+  stub_ss.add(files('uuid.c'))
 endif
-if have_system
-  stub_ss.add(files('fw_cfg.c'))
-  stub_ss.add(files('xen-hw-stub.c'))
-else
+
+if have_block or have_ga
+  # stubs for hooks in util/main-loop.c, util/async.c etc.
+  stub_ss.add(files('cpus-get-virtual-clock.c'))
+  stub_ss.add(files('icount.c'))
+  stub_ss.add(files('graph-lock.c'))
+  if linux_io_uring.found()
+    stub_ss.add(files('io_uring.c'))
+  endif
+  if libaio.found()
+    stub_ss.add(files('linux-aio.c'))
+  endif
+  stub_ss.add(files('qemu-timer-notify-cb.c'))
+
+  # stubs for monitor
+  stub_ss.add(files('monitor-internal.c'))
+  stub_ss.add(files('qmp-command-available.c'))
+  stub_ss.add(files('qmp-quit.c'))
+endif
+
+if have_block or have_user
+  stub_ss.add(files('qtest.c'))
+  stub_ss.add(files('vm-stop.c'))
+  stub_ss.add(files('vmstate.c'))
+
+  # more symbols provided by the monitor
+  stub_ss.add(files('error-printf.c'))
+endif
+
+if have_user
+  # Symbols that are used by hw/core.
+  stub_ss.add(files('cpu-synchronize-state.c'))
   stub_ss.add(files('qdev.c'))
 endif
+
+if have_system
+  # Symbols that are only needed in some configurations.  Try not
+  # adding more of these.  If the symbol is used in specific_ss,
+  # in particular, consider defining a preprocessor macro via
+  # Kconfig or configs/targets/.
+  stub_ss.add(files('dump.c'))
+  stub_ss.add(files('cmos.c'))
+  stub_ss.add(files('fw_cfg.c'))
+  stub_ss.add(files('target-get-monitor-def.c'))
+  stub_ss.add(files('target-monitor-defs.c'))
+  stub_ss.add(files('win32-kbd-hook.c'))
+  stub_ss.add(files('xen-hw-stub.c'))
+endif
+
+if have_system or have_user
+  stub_ss.add(files('gdbstub.c'))
+
+  # Also included in have_system for --disable-tcg builds
+  stub_ss.add(files('replay.c'))
+
+  # Also included in have_system for tests/unit/test-qdev-global-props
+  stub_ss.add(files('hotplug-stubs.c'))
+  stub_ss.add(files('sysbus.c'))
+endif
-- 
2.44.0



