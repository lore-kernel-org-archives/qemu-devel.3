Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E85EF9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV0w-0003tW-Kr; Wed, 22 Apr 2026 06:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV0u-0003tG-QX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV0s-00024s-Iw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g2pm9yHcFnjqqBO5iWt6wflKUmerTQ0k6G4ddtZl4S0=;
 b=d0Ro052H6/AOSprxPYz7Rduq/27bHZbk1bL6WWzZcMWznJDDoJ9bDBDRXggylx0haqlvxW
 3aqUP+sGfg4UoGWGC6bA+AEvm3QUFg4M0f9b9XZAmlXfyTwX0389R923jQwp1L01BJf367
 RbOYBccTwB0KZmCUcjQ7/TXl3XsQ0WA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-ehjP8qT_NnidxAu0fGqciQ-1; Wed,
 22 Apr 2026 06:40:52 -0400
X-MC-Unique: ehjP8qT_NnidxAu0fGqciQ-1
X-Mimecast-MFC-AGG-ID: ehjP8qT_NnidxAu0fGqciQ_1776854452
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0551619560B8; Wed, 22 Apr 2026 10:40:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A10E11956095; Wed, 22 Apr 2026 10:40:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/40] UI patches
Date: Wed, 22 Apr 2026 14:40:01 +0400
Message-ID: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 98b060da3a4f92b2a994ead5b16a87e783baf77c:

  Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 4a36e9d6693806c02eae75db346bc6043abbfafc:

  tests: rename the dbus-daemon helper script (2026-04-22 12:54:24 +0400)

----------------------------------------------------------------
UI-related fixes and cleanups

----------------------------------------------------------------

GuoHan Zhao (3):
  ui/input-linux: close evdev fd when qemu_set_blocking fails
  ui/spice-app: detect runtime directory creation failures
  ui/clipboard: clear deferred serial reset flag on resume

Marc-André Lureau (36):
  ui/vnc-jobs: remove needless buffer_reset() before end
  ui/vnc: clarify intent using buffer_empty() function
  ui/vnc-jobs: vnc_has_job_locked() argument cannot be NULL
  ui/vnc-jobs: remove dead VncJobQueue.exit
  ui/vnc-jobs: remove vnc_queue_clear()
  ui/vnc-jobs: narrow taking the queue lock
  ui/vnc-jobs: drop redundant (and needless) qemu_thread_get_self()
  ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
  ui/console-vc: ignore string-type escape sequences
  ui/console-vc: fix comment shift-out/in comments
  ui/console: dispatch get_label() through QOM virtual method
  ui/console-vc: introduce QemuVT100
  ui/console-vc: set vt100 associated pixman image
  ui/console-vc: vga_putcharxy()->vt100_putcharxy()
  ui/console-vc: make invalidate_xy() take vt100
  ui/console-vc: make show_cursor() take vt100
  ui/console-vc: decouple VT100 display updates via function pointer
  ui/console-vc: console_refresh() -> vt100_refresh()
  ui/console-vc: move cursor blinking logic into VT100 layer
  ui/console-vc: console_scroll() -> vt100_scroll()
  ui/console-vc: refactor text_console_resize() into vt100_set_image()
  ui/console-vc: move vc_put_lf() to VT100 layer as vt100_put_lf()
  ui/console-vc: unify the write path
  ui: avoid duplicating vgafont16 in each translation unit
  ui/vgafont: add SPDX license header
  util: move datadir.c from system/
  system: make qemu_del_vm_change_state_handler accept NULL
  ui/vnc: assert preconditions instead of silently returning
  ui/vnc: simplify vnc_init_func error handling
  ui/vnc: VncDisplay.id is not const
  ui/keymaps: introduce kbd_layout_free()
  ui/vnc: fix vnc_display_init() leak on failure
  ui/vnc: make vnc_disconnect_finish() private
  ui/vnc: remove left-over dead code
  ui/vnc: explicitly link with png
  tests: rename the dbus-daemon helper script

Werner de Carne (1):
  serial COM: windows serial COM PollingFunc don't sleep

 include/ui/console.h                          |    3 +-
 ui/console-priv.h                             |    3 +-
 ui/keymaps.h                                  |    1 +
 ui/vgafont.h                                  | 4616 +----------------
 ui/vnc.h                                      |    4 +-
 chardev/char-win.c                            |   16 +-
 system/runstate.c                             |    3 +
 ui/clipboard.c                                |    1 +
 ui/console-vc-stubs.c                         |    8 +-
 ui/console-vc.c                               |  612 ++-
 ui/console.c                                  |  120 +-
 ui/input-linux.c                              |    2 +-
 ui/keymaps.c                                  |   13 +-
 ui/spice-app.c                                |    2 +-
 ui/vgafont.c                                  | 4616 +++++++++++++++++
 ui/vnc-jobs.c                                 |   44 +-
 ui/vnc.c                                      |   71 +-
 {system => util}/datadir.c                    |    0
 system/meson.build                            |    1 -
 system/trace-events                           |    1 -
 ...{dbus-vmstate-daemon.sh => dbus-daemon.sh} |    0
 tests/qtest/meson.build                       |    2 +-
 ui/meson.build                                |    3 +-
 util/meson.build                              |    1 +
 util/trace-events                             |    3 +
 25 files changed, 5113 insertions(+), 5033 deletions(-)
 create mode 100644 ui/vgafont.c
 rename {system => util}/datadir.c (100%)
 rename tests/{dbus-vmstate-daemon.sh => dbus-daemon.sh} (100%)

-- 
2.53.0


