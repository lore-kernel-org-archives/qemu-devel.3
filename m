Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87D6CD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlFp-0002Y0-7s; Sat, 09 May 2026 13:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlFn-0002Xd-IO
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlFk-0004cK-GG
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RcW0quQKqz8yy4pxczvouOsUl/sXidqdUHZr7oY7B+g=;
 b=EJG7GQJWzTidE23PTexI8zuYL2NdVyNVTBY/tXcLnsQKiO9KQGxK3S2B3qLckMcvZzlB3W
 mcBA6nkSj13mnzYkVZ7nRPRenSxavd5K6dd9dmcJvgQeJkIKYw/t7KjGiehdbZGtiFDSQ+
 S72r1YhCxSKkMdwyhaatJjpn4Tyz4Ak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-qDdiWrioPS6xzF9CdKXRGQ-1; Sat,
 09 May 2026 13:14:06 -0400
X-MC-Unique: qDdiWrioPS6xzF9CdKXRGQ-1
X-Mimecast-MFC-AGG-ID: qDdiWrioPS6xzF9CdKXRGQ_1778346845
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11F5518002DC; Sat,  9 May 2026 17:14:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C20771800240; Sat,  9 May 2026 17:14:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 00/33] UI patches
Date: Sat,  9 May 2026 21:13:21 +0400
Message-ID: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to e4c7ebde643811e8dc1f640b50f37ad0a0dd1dac:

  qemu-options: document -chardev dbus (2026-05-09 18:54:16 +0400)

----------------------------------------------------------------
- gtk clipboard fixes
- dbus-vmstate test fixes
- vt100 emulator support for utf8
- qemu-vnc tool

----------------------------------------------------------------

Fabiano Rosas (5):
  tests/qtest/dbus-vmstate: Bring the test up-to-date
  tests/qtest/dbus-vmstate: Mute Glib complaints about g_unsetenv
    thread-safety
  tests/qtest/dbus-vmstate: Honor QTEST_LOG env variable
  tests/qtest/dbus-vmstate: Stop the daemons explicitly
  tests/qtest/dbus-vmstate: Re-enable the test

Jindřich Makovička (1):
  ui/gtk: Fix GTK assertion failure introduced with clipboard fixes

Marc-André Lureau (26):
  ui/input: do not assert() when tracing invalid input
  qemu-options.hx: document -chardev vc backend-specific behavior
  char: error out if given unhandled size options
  ui/console: add vc encoding=utf8/cp437 option
  ui/console: default vc encoding to cp437 for machine < 11.1
  ui/dbus: expose vc encoding via D-Bus Chardev.VCEncoding interface
  ui/console-vc: add UTF-8 input decoding with CP437 rendering
  ui/console-vc: move VT100 state machine and output FIFO into QemuVT100
  ui/console-vc: extract vt100_input() from vc_chr_write()
  ui/console-vc: extract vt100_keysym() from
    qemu_text_console_handle_keysym()
  ui/console-vc: extract vt100_init() and vt100_fini()
  ui/console: remove console_ch_t typedef and console_write_ch()
  ui/console-vc: move VT100 emulation into separate unit
  ui/vnc: make the worker thread per-VncDisplay
  ui/vnc: vnc_display_init() and vnc_display_open() return bool
  ui/vnc: merge vnc_display_init() and vnc_display_open()
  ui/vnc: clean up VNC displays on exit
  ui/vnc: defer listener registration until the console is known
  ui/vnc: add vnc-system unit, to allow different implementations
  ui/console: simplify registering display/console change listener
  ui/console: add doc comment for qemu_console_{un}register_listener()
  ui/console: rename public API to use consistent qemu_console_ prefix
  ui/vnc: replace VNC_DEBUG with trace-events
  ui: extract common sources into a static library
  tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
  tools/qemu-vnc: add standalone VNC server over D-Bus

uchouT (1):
  qemu-options: document -chardev dbus

 MAINTAINERS                      |    5 +
 docs/conf.py                     |    3 +
 docs/interop/dbus-display.rst    |    2 +
 docs/interop/dbus-vnc.rst        |   26 +
 docs/interop/index.rst           |    1 +
 docs/meson.build                 |    1 +
 docs/tools/index.rst             |    1 +
 docs/tools/qemu-vnc.rst          |  226 +++++
 meson.build                      |   17 +
 qapi/char.json                   |   30 +-
 include/chardev/char.h           |   21 +
 include/qemu/option.h            |    1 +
 include/ui/console.h             |  124 ++-
 tools/qemu-vnc/qemu-vnc.h        |   49 ++
 tools/qemu-vnc/trace.h           |    4 +
 ui/console-priv.h                |    1 -
 ui/cp437.h                       |   13 +
 ui/dbus.h                        |    1 +
 ui/vnc-jobs.h                    |    3 +-
 ui/vnc.h                         |   17 +-
 ui/vt100.h                       |   95 +++
 chardev/char.c                   |   22 +
 hw/arm/musicpal.c                |    4 +-
 hw/core/machine.c                |    4 +-
 hw/display/artist.c              |    4 +-
 hw/display/ati.c                 |   16 +-
 hw/display/bcm2835_fb.c          |    5 +-
 hw/display/bochs-display.c       |   14 +-
 hw/display/cg3.c                 |    6 +-
 hw/display/cirrus_vga.c          |    8 +-
 hw/display/cirrus_vga_isa.c      |    2 +-
 hw/display/dm163.c               |    6 +-
 hw/display/exynos4210_fimd.c     |    4 +-
 hw/display/g364fb.c              |   10 +-
 hw/display/imx6ul_lcdif.c        |   14 +-
 hw/display/jazz_led.c            |   18 +-
 hw/display/macfb.c               |    6 +-
 hw/display/next-fb.c             |    4 +-
 hw/display/omap_lcdc.c           |    4 +-
 hw/display/pl110.c               |    4 +-
 hw/display/qxl-render.c          |   12 +-
 hw/display/qxl.c                 |   18 +-
 hw/display/ramfb-standalone.c    |    2 +-
 hw/display/ramfb.c               |    4 +-
 hw/display/sm501.c               |    6 +-
 hw/display/ssd0303.c             |    4 +-
 hw/display/ssd0323.c             |    5 +-
 hw/display/tcx.c                 |   16 +-
 hw/display/vga-isa.c             |    2 +-
 hw/display/vga-mmio.c            |    2 +-
 hw/display/vga-pci.c             |    6 +-
 hw/display/vga.c                 |   56 +-
 hw/display/vhost-user-gpu.c      |   22 +-
 hw/display/virtio-gpu-base.c     |    4 +-
 hw/display/virtio-gpu-rutabaga.c |   10 +-
 hw/display/virtio-gpu-udmabuf.c  |    4 +-
 hw/display/virtio-gpu-virgl.c    |   20 +-
 hw/display/virtio-gpu.c          |   26 +-
 hw/display/virtio-vga.c          |    4 +-
 hw/display/vmware_vga.c          |   14 +-
 hw/display/xenfb.c               |    6 +-
 hw/display/xlnx_dp.c             |   10 +-
 hw/vfio/display.c                |   32 +-
 system/runstate.c                |    5 +
 tests/qtest/dbus-vmstate-test.c  |  123 ++-
 tests/qtest/dbus-vnc-test.c      | 1346 ++++++++++++++++++++++++++++++
 tools/qemu-vnc/audio.c           |  308 +++++++
 tools/qemu-vnc/chardev.c         |  148 ++++
 tools/qemu-vnc/clipboard.c       |  376 +++++++++
 tools/qemu-vnc/console.c         |  170 ++++
 tools/qemu-vnc/dbus.c            |  474 +++++++++++
 tools/qemu-vnc/display.c         |  456 ++++++++++
 tools/qemu-vnc/input.c           |  239 ++++++
 tools/qemu-vnc/qemu-vnc.c        |  581 +++++++++++++
 tools/qemu-vnc/stubs.c           |   62 ++
 tools/qemu-vnc/utils.c           |   59 ++
 ui/console-vc-stubs.c            |    1 +
 ui/console-vc.c                  | 1074 ++----------------------
 ui/console.c                     |  173 ++--
 ui/cp437.c                       |  205 +++++
 ui/curses.c                      |   23 +-
 ui/dbus-chardev.c                |   10 +
 ui/dbus-console.c                |   10 +-
 ui/dbus-listener.c               |   37 +-
 ui/dbus.c                        |   59 ++
 ui/egl-headless.c                |    8 +-
 ui/gtk-clipboard.c               |    2 +-
 ui/gtk-egl.c                     |    6 +-
 ui/gtk-gl-area.c                 |    6 +-
 ui/gtk.c                         |   28 +-
 ui/input.c                       |    8 +-
 ui/sdl2-2d.c                     |    2 +-
 ui/sdl2-gl.c                     |    2 +-
 ui/sdl2.c                        |   14 +-
 ui/spice-display.c               |   24 +-
 ui/vnc-auth-sasl.c               |   13 +-
 ui/vnc-enc-tight.c               |    4 +-
 ui/vnc-enc-zlib.c                |    4 +-
 ui/vnc-jobs.c                    |   62 +-
 ui/vnc-system.c                  |   19 +
 ui/vnc-ws.c                      |   10 +-
 ui/vnc.c                         |  232 +++--
 ui/vt100.c                       |  984 ++++++++++++++++++++++
 util/qemu-option.c               |   13 +
 hw/display/apple-gfx.m           |   16 +-
 meson_options.txt                |    2 +
 qemu-options.hx                  |   36 +-
 scripts/meson-buildoptions.sh    |    3 +
 tests/dbus-daemon.sh             |   16 +-
 tests/qtest/meson.build          |   23 +-
 tools/qemu-vnc/meson.build       |   26 +
 tools/qemu-vnc/qemu-vnc1.xml     |  201 +++++
 tools/qemu-vnc/trace-events      |   21 +
 ui/cocoa.m                       |   23 +-
 ui/dbus-display1.xml             |   18 +
 ui/meson.build                   |  103 +--
 ui/trace-events                  |   29 +-
 117 files changed, 7221 insertions(+), 1757 deletions(-)
 create mode 100644 docs/interop/dbus-vnc.rst
 create mode 100644 docs/tools/qemu-vnc.rst
 create mode 100644 tools/qemu-vnc/qemu-vnc.h
 create mode 100644 tools/qemu-vnc/trace.h
 create mode 100644 ui/cp437.h
 create mode 100644 ui/vt100.h
 create mode 100644 tests/qtest/dbus-vnc-test.c
 create mode 100644 tools/qemu-vnc/audio.c
 create mode 100644 tools/qemu-vnc/chardev.c
 create mode 100644 tools/qemu-vnc/clipboard.c
 create mode 100644 tools/qemu-vnc/console.c
 create mode 100644 tools/qemu-vnc/dbus.c
 create mode 100644 tools/qemu-vnc/display.c
 create mode 100644 tools/qemu-vnc/input.c
 create mode 100644 tools/qemu-vnc/qemu-vnc.c
 create mode 100644 tools/qemu-vnc/stubs.c
 create mode 100644 tools/qemu-vnc/utils.c
 create mode 100644 ui/cp437.c
 create mode 100644 ui/vnc-system.c
 create mode 100644 ui/vt100.c
 create mode 100644 tools/qemu-vnc/meson.build
 create mode 100644 tools/qemu-vnc/qemu-vnc1.xml
 create mode 100644 tools/qemu-vnc/trace-events

-- 
2.54.0


