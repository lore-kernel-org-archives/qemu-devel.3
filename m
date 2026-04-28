Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83C9FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHk2M-0001zG-0Q; Tue, 28 Apr 2026 11:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2E-0001xY-9d
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2B-0000W7-NJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777388854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=783+MWuu95kx58wldNJbthYxwY0i2Sl41ZsP00Qd3xk=;
 b=aQK50RqgLXmZ1VruI2Z04/717SvsZS8PVdrI9vvLDmIYerjPJqPtdSaphu2TtlLEZ/Avj/
 E5RDrcWSom1TMtA6Ut0n+EAOYA9IGugLI46HKZP8WdlGTJEFlEMxeM5uW+7XlG+2iW+3jU
 pwzCjivCEAlL+YnQeSiiinSb4/Hm/KA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-lpo8fLGIMzOGws-v6S_E7g-1; Tue,
 28 Apr 2026 11:07:32 -0400
X-MC-Unique: lpo8fLGIMzOGws-v6S_E7g-1
X-Mimecast-MFC-AGG-ID: lpo8fLGIMzOGws-v6S_E7g_1777388851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B54AC19560B0; Tue, 28 Apr 2026 15:07:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 641E71943295; Tue, 28 Apr 2026 15:07:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 00/15] UI patches
Date: Tue, 28 Apr 2026 19:07:10 +0400
Message-ID: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
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

The following changes since commit 759c456b1d22fe4083c8b384da27d3f56fd53f82:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-04-27 12:57:33 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 335e32cbd0a24f13e326d96dd30318cd78740c60:

  ui/gtk: Turn clipboard flag into runtime option (2026-04-28 18:53:59 +0400)

----------------------------------------------------------------
UI-related fixes and cleanups

----------------------------------------------------------------

Akihiko Odaki (3):
  audio: Avoid unsigned sample wraparound
  audio: Clamp unsigned sample conversion
  audio: Use unsigned PCM bias

Jindřich Makovička (2):
  ui/gtk: Use non-blocking clipboard retrieval
  ui/gtk: Turn clipboard flag into runtime option

Marc-André Lureau (10):
  ui: move FONT_WIDTH/HEIGHT to vgafont.h
  ui: move DisplaySurface functions to display-surface.c
  ui: make qemu_default_pixelformat() static inline
  ui: make unregister_displaychangelistener() skip unregistered
  ui: minor code simplification
  ui: rename init_keyboard_layout->kbd_layout_new()
  ui/console: remove qemu_console_is_visible()
  ui/console: return completion status from gfx_update callback
  ui/console: move console_handle_touch_event() to input
  ui/dbus: fix warning for clients without "Interfaces" property

 meson.build                   |   4 -
 qapi/ui.json                  |   6 +-
 audio/mixeng_template.h       |  14 +--
 hw/display/qxl.h              |   2 +-
 include/ui/console.h          |  26 ++---
 include/ui/input.h            |  15 +++
 include/ui/qemu-pixman.h      |   8 ++
 include/ui/surface.h          |   2 -
 ui/console-priv.h             |   6 -
 ui/keymaps.h                  |   4 +-
 ui/vgafont.h                  |   6 +-
 hw/arm/musicpal.c             |   3 +-
 hw/display/artist.c           |   4 +-
 hw/display/bcm2835_fb.c       |   7 +-
 hw/display/bochs-display.c    |   6 +-
 hw/display/cg3.c              |   5 +-
 hw/display/dm163.c            |   4 +-
 hw/display/exynos4210_fimd.c  |   6 +-
 hw/display/g364fb.c           |   9 +-
 hw/display/imx6ul_lcdif.c     |   7 +-
 hw/display/jazz_led.c         |   6 +-
 hw/display/macfb.c            |   6 +-
 hw/display/next-fb.c          |   4 +-
 hw/display/omap_lcdc.c        |  14 ++-
 hw/display/pl110.c            |   5 +-
 hw/display/qxl-render.c       |   6 +-
 hw/display/qxl.c              |   7 +-
 hw/display/ramfb-standalone.c |   4 +-
 hw/display/sm501.c            |   8 +-
 hw/display/ssd0303.c          |  10 +-
 hw/display/ssd0323.c          |  11 +-
 hw/display/tcx.c              |   6 +-
 hw/display/vga.c              |   4 +-
 hw/display/virtio-gpu-base.c  |   3 +-
 hw/display/virtio-vga.c       |   6 +-
 hw/display/vmware_vga.c       |   7 +-
 hw/display/xenfb.c            |   6 +-
 hw/display/xlnx_dp.c          |  10 +-
 hw/vfio/display.c             |  17 +--
 ui/console-vc.c               |   1 +
 ui/console.c                  | 206 +---------------------------------
 ui/curses.c                   |   4 +-
 ui/dbus-console.c             |   6 +-
 ui/dbus-listener.c            |   4 +-
 ui/display-surface.c          | 107 ++++++++++++++++++
 ui/gtk-clipboard.c            |  53 ++++++---
 ui/gtk.c                      |  16 +--
 ui/input-barrier.c            |   4 +-
 ui/input.c                    |  65 +++++++++++
 ui/keymaps.c                  |   4 +-
 ui/sdl2.c                     |   8 +-
 ui/vnc.c                      |  12 +-
 hw/display/apple-gfx.m        |  10 +-
 meson_options.txt             |   7 --
 qemu-options.hx               |   9 +-
 scripts/meson-buildoptions.sh |   3 -
 ui/meson.build                |   5 +-
 57 files changed, 428 insertions(+), 380 deletions(-)
 create mode 100644 ui/display-surface.c

-- 
2.54.0


