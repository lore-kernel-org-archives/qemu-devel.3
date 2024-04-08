Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2DDCD1299
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrKK-0001be-AM; Mon, 08 Apr 2024 11:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKI-0001bG-37
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKF-0001rg-Vl
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzLCimdhAyi0rVMbm3kXFpGr3NcS9gM1RUctxanXbE8=;
 b=HHeB7toBz2NbMGkTgVG4cjcWs7ja88273gytvrjEvaF4+1rYVb1n+EvkNlphfqvZiuAqTA
 eTw4c700QzruqKzBTM5D/H0LYOaARDmtZ2m5g70p676t1BQ18wupAtdJKlFsbJJfckiIVc
 DFOo7rJpMUJYuX+TLaH2k8aWUXrJ8HI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-LUCuDad-PeG03Rixa8diLQ-1; Mon, 08 Apr 2024 11:54:26 -0400
X-MC-Unique: LUCuDad-PeG03Rixa8diLQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41545bc8962so20502085e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591664; x=1713196464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzLCimdhAyi0rVMbm3kXFpGr3NcS9gM1RUctxanXbE8=;
 b=EgXiDXjBdxKvN/ml8aH6w4UWoBPtUr6Bl3DVM33MYj5e6sEECoezjmRaxt+BKlj2ea
 KJFkTn1nqngh2In+Alz5ppfWIel8J8CD/DzuFRz4KtjQ77182g++mXqSnio8NBoQB8rp
 u5LTwBLDxKGJ//nX7XUKUU2Lx86S62lcVRmEfrBTHTJ8mWdw1Zl7P/TQS6nerebLENiv
 vX8vBEzznB6YK0rRMicp2tU22Tfgzl7bKxr+a/8Eq019r6DIhUWUX1QVPmhWqN3lWLzX
 jIUwshKcl2qhwZzCg9HbkCCvKmhbMHAUe2y+gVsQm4OzVOofeP5EW8XdQ1GuLhqSWa+1
 IwMQ==
X-Gm-Message-State: AOJu0YyML2iM6Sug8GCkQLKEjJKI5V3oW4DGqUl1gRm+iIPiEZj47FTG
 ILQxLE89+xmsKXUxXCR/8BxTIO77LWMp5CX3vcTql3g83fvK+IVwejcIGmW/SIwGODyY4ZW5ugt
 FEw6vVwBNJtRA0KLX7/luVIGHJu40qLeWxY29Mi5QorN4MdoGF5/h6hDE2P8cUCLDAUkhZFjsVg
 7Tyt1F+2Ewzq/O0nZX+lnr8K74etw6zybDAQao
X-Received: by 2002:a05:600c:4fcf:b0:415:6456:c530 with SMTP id
 o15-20020a05600c4fcf00b004156456c530mr6842357wmq.14.1712591664312; 
 Mon, 08 Apr 2024 08:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkrHzUmRjlW5K21kYzQ2sQ8L4wMJGkCkZA+fN1zJHrc6uSXQXBStJ1qiJ0gyurnRF8F/dT2g==
X-Received: by 2002:a05:600c:4fcf:b0:415:6456:c530 with SMTP id
 o15-20020a05600c4fcf00b004156456c530mr6842341wmq.14.1712591663951; 
 Mon, 08 Apr 2024 08:54:23 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 jg1-20020a05600ca00100b00414688af147sm16994248wmb.20.2024.04.08.08.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 17/18] stubs: include stubs only if needed
Date: Mon,  8 Apr 2024 17:53:29 +0200
Message-ID: <20240408155330.522792-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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
index 4a524f5816b..8ff25faaf1c 100644
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
+  # in particular, consider adding a symbol in configs/targets/
+  # instead.
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


