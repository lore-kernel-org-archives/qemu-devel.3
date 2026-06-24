Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C194CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLzB-0007Xs-5F; Wed, 24 Jun 2026 07:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzA-0007Xk-BF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLz8-0007Wn-L2
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9EUn1kjnNOHZAtJhTkICNe0YnkPD3jrC0jdzOlATiLA=;
 b=QWZM6SM9bduNR0sR8g8RzAi/lGFEDADkMw2C73QMRSPdGpf8CCLDUN3kL1OvRdcqst+95w
 OyBUkl2gDSxJ/Uw0EL2GgO35TqlU+yySP57jPtNcEVR2NHzxrEypCP5OqW6g28RRsVlgAx
 n3TbESihorcIVUBUm7u29bEmZ6rjr+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-JSc-xMWZN1GbKilegzC42g-1; Wed,
 24 Jun 2026 07:41:35 -0400
X-MC-Unique: JSc-xMWZN1GbKilegzC42g-1
X-Mimecast-MFC-AGG-ID: JSc-xMWZN1GbKilegzC42g_1782301294
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7329A1955F3D
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:41:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59F30180028B; Wed, 24 Jun 2026 11:41:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/35] UI patches
Message-Id: <20260624-ui-v1-0-482147b0a7af@redhat.com>
Date: Wed, 24 Jun 2026 15:41:22 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Gne4n2kDxuxpLSQQ13msG4WOJ6/AMGg2WLfHFqG8hYQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jmv4OhItidExiXlYfQVD6VozXfsMYOh4UKz
 MvAzWe1vUuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZgAKCRDa6OEJdZac
 5RBhD/9HFboD2x/QLKZRBUxZ4EcsZsdkUmNz41zGwGfyblE737/NsOs1ez8EPrfN81g9EKnXWJ8
 rJdd9hiAqqDSwesrwBe8Ppy5GOTem8gGGNWBTsXNko2ElOpFxXyLJNge7KpszH1OV4Gi1upp/aO
 3WSfyrAsgbjZ8yfDZKxMGQA7r74tTMgQ3firHDfPnwR1HzahY++tU963yyUVSa6UAGwjjjX2frS
 +/6HAIY5z1XyRUq+Zq2J7Oli+GPYjWt4eTxkPs0QwDbFkOKSrrz2LD7z9Lfg8yHWb73gewfoc9n
 NJlQMTXGDy9OOyPDvoeahha1V5uve91UbiFMRFqzJ6QwtAwSn8c53nuyBHrHc9vvsFWt2tgrtjT
 rPhm67r7HRT4vhU2R1IpSiJp6NCifejyQRFbgcVV6ERWTAfBcOePWwsHG8NNpykIPHwRWxj8v5T
 spzWzWMI8w+Kz/5grxCwLmpWhu1k7VkL6BJ9m3Ly8kiRpaXYanwrI9XChyGVnbX+UVyNY2rm9Pf
 M+mzOWQWIlbYnTtJ+Ldxr4lMXwJVhY9I1jqoChb72i/qgPEun5r9A+4x7uH3t9dQIZ4qqb172sC
 oxTkuv4xGQmNp7G12o/hciBu6OKEt2gDGUcExfJlPtKOw7FTEMr4F9HrFDo96CLp/G9HBMh+ssb
 Jjg0pAsxoBwgCMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:

  Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into staging (2026-06-19 15:00:01 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pr-v1

for you to fetch changes up to a0e5242e1c670b368e9639bf265e22e11c0c65fe:

  vga: implement text mode character blink (2026-06-24 15:41:15 +0400)

----------------------------------------------------------------
UI patches

- ui: better console hotplug support
- vga: implement blinking

To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Marc-André Lureau (35):
      ui/gtk: fix bad widget realize on non-GFX VC
      build-sys: build with -fno-omit-frame-pointer with ASAN
      irq: add per-IRQ observer to fix qemu_irq_intercept_in leak
      scripts/lsan_suppressions: suppress fontconfig leaks
      vfio/pci: close display console during unrealize, not finalize
      docs: add mdpy mdev vfio display testing guide
      glib-compat: add fallback for g_clear_fd/g_autofd
      util: make notifer_remove() safer
      ui/dbus: remove mouse handler on dispose
      ui/qmp: keep a reference of console across yield
      ui: stop ui timer when closing
      ui/console: init gl_unblock_timer in qemu_console_init
      ui/spice: remove dead spice_displays
      ui/spice: add cleanup on shutdown
      ui: add display cleanup infrastructure
      ui/curses: implement display cleanup
      ui/sdl2: implement display cleanup
      ui/spice-app: implement display cleanup
      ui/egl: implement display and EGL cleanup
      ui/cocoa: implement display cleanup
      ui/dbus: implement display cleanup
      ui/gtk: implement display cleanup
      ui/console: add console event notifier infrastructure
      ui/console: fire console ADDED/REMOVED notifications
      ui/console-vc: fire ADDED/REMOVED notifications
      ui/gtk: convert VirtualConsole storage from fixed array to GPtrArray
      ui/gtk: move global display settings out of per-console init
      ui/gtk: fix tab re-insertion order on window close
      ui/gtk: centralize console menu and shortcut management
      ui/gtk: handle console hotplug/unplug events
      ui/console: register console in QOM tree dynamically
      ui/console: unregister console from QOM tree on close
      ui/dbus: handle console hotplug/unplug events
      tests/qtest: add D-Bus display hotplug test
      vga: implement text mode character blink

 MAINTAINERS                     |   1 +
 docs/devel/index-internals.rst  |   1 +
 docs/devel/vfio-mdpy.rst        |  90 ++++++++++
 meson.build                     |   2 +
 hw/display/vga_int.h            |   2 +
 hw/vfio/pci.h                   |   1 +
 include/glib-compat.h           |  29 ++++
 include/hw/core/irq.h           |   6 +-
 include/ui/console.h            |  20 +++
 include/ui/egl-helpers.h        |   1 +
 include/ui/gtk.h                |   7 +-
 include/ui/qemu-spice-module.h  |   1 +
 include/ui/qemu-spice.h         |   9 +-
 ui/dbus.h                       |   3 +
 hw/core/irq.c                   |  12 +-
 hw/display/vga.c                |  25 ++-
 hw/vfio/display.c               |  29 ++--
 hw/vfio/pci.c                   |   2 +
 system/qtest.c                  |   5 +-
 system/runstate.c               |   4 +-
 tests/qtest/dbus-display-test.c | 101 ++++++++++-
 ui/console-vc.c                 |  13 ++
 ui/console.c                    |  77 ++++++++-
 ui/curses.c                     |  17 +-
 ui/dbus-console.c               |   6 +
 ui/dbus.c                       | 106 ++++++++++--
 ui/egl-headless.c               |  31 ++++
 ui/egl-helpers.c                |  19 ++
 ui/gtk-clipboard.c              |  15 ++
 ui/gtk.c                        | 375 +++++++++++++++++++++++++++++++---------
 ui/sdl2.c                       |  23 ++-
 ui/spice-app.c                  |  10 +-
 ui/spice-core.c                 |  25 ++-
 ui/spice-display.c              |  52 ++++++
 ui/spice-input.c                |  53 ++++--
 ui/spice-module.c               |   5 +
 ui/ui-qmp-cmds.c                |   3 +
 util/notify.c                   |   2 +-
 scripts/lsan_suppressions.txt   |  15 +-
 ui/cocoa.m                      |  19 +-
 ui/meson.build                  |   4 +-
 41 files changed, 1028 insertions(+), 193 deletions(-)
 create mode 100644 docs/devel/vfio-mdpy.rst


