Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC970CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ21u-0004RV-F2; Thu, 21 May 2026 07:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ21t-0004Qj-4H
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ21r-0003ug-25
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B7ONg1rANqP293JH5oy0MjRdh2T94TaDGb8YiNcRNJU=;
 b=bVldTrFJxs3OQUbK8sYPZ9v37PS4rF/Q5ZbcoaQHaz4W1X1RR3eEuKimnrnvqQwwLSSMat
 atvPTNeK/UGy8IETkNjX4ORt9X6Na0iFBa4cBPh2pZNuLmfabuAnf1Kx6CUGlc/zHnmi1s
 ERc8B9JgFqWUfwG+P48gcSFuJzGnTqI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-19GurTJeMbSx17hvXC2G0w-1; Thu,
 21 May 2026 07:57:24 -0400
X-MC-Unique: 19GurTJeMbSx17hvXC2G0w-1
X-Mimecast-MFC-AGG-ID: 19GurTJeMbSx17hvXC2G0w_1779364643
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A0011800344; Thu, 21 May 2026 11:57:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA3821800357; Thu, 21 May 2026 11:57:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/38] Ui patches
Date: Thu, 21 May 2026 15:56:37 +0400
Message-ID: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The following changes since commit 3f129ea545f16e82b5e43fcc3866b134b7cc4dfc:

  Merge tag 'pull-vfio-20260520' of https://github.com/legoater/qemu into staging (2026-05-20 16:53:28 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 64abff825b6fab9366b582f4d54eb2d12985c0b7:

  ui/gtk: Fix focus loss on re-attachment with single VC (2026-05-21 15:29:58 +0400)

----------------------------------------------------------------
UI pull request

- ui/input: Decouple internal and QAPI input events
- VNC OOB fixes
- vt100 fixes
- GTK focus fix

----------------------------------------------------------------

Akihiko Odaki (29):
  ui/input: Introduce QemuInputEvent typedef
  ui/input: Remove QAPI wrappers from QemuInputEvent
  ui/input: Store QKeyCode directly in QemuInputKeyEvent
  ui/input: Use Linux key codes for internal key events
  ui/input: Prohibit sending KEY_RESERVED
  ui/console: Add qemu_text_console_put_linux()
  ui/kbd-state: Use Linux key codes
  hw/arm/musicpal: Use Linux key codes
  hw/char/escc: Use Linux key codes
  hw/display/xenfb: Use Linux key codes
  hw/input/adb-kbd: Use Linux key codes
  hw/input/hid: Use Linux key codes
  hw/input/ps2: Use Linux key codes
  hw/input/virtio-input: Use Linux key codes
  hw/m68k/next-kbd: Use Linux key codes
  replay: Use Linux key codes
  ui/cocoa: Use Linux key codes
  ui/dbus: Use Linux key codes
  ui/gtk: Use Linux key codes
  ui/input-barrier: Use Linux key codes
  ui/input-legacy: Use Linux key codes
  ui/input-linux: Use Linux key codes
  ui/keymaps: Use Linux key codes
  ui/sdl2: Use Linux key codes
  ui/spice: Use Linux key codes
  ui/vnc: Use Linux key codes
  qemu-keymap: Use Linux key codes
  ui/console: Remove qemu_text_console_put_qcode()
  ui/input: Remove unused QKeyCode helpers and keymaps

Daniel P. Berrangé (4):
  ui/vnc: fix OOB read access in VNC SASL mechname array
  ui/vnc: fix OOB write in VNC stats array
  ui/vnc: fix OOB write in lossy rect worker code
  ui/vnc: fix OOB read updating VNC update frequency stats

Dongwon Kim (1):
  ui/gtk: Fix focus loss on re-attachment with single VC

Heechan Kang (1):
  ui: fix validation of VNC extended clipboard data length

Marc-André Lureau (1):
  ui/vt100: add vt100_fini() check

Peter Maydell (2):
  ui/vt100: Standardize on uint8_t for "ch" byte variables
  ui/vt100: Take byte as uint8_t in bh_utf8_decode()

 include/qemu/typedefs.h      |   1 +
 include/system/replay.h      |   2 +-
 include/ui/console.h         |   3 +-
 include/ui/input.h           |  92 ++++++-----
 include/ui/kbd-state.h       |  12 +-
 replay/replay-internal.h     |   6 +-
 ui/vnc.h                     |   4 +-
 ui/x_keymap.h                |   3 +-
 chardev/msmouse.c            |  12 +-
 chardev/wctablet.c           |  10 +-
 hw/arm/musicpal.c            |  31 ++--
 hw/char/escc.c               |  45 +++---
 hw/display/xenfb.c           |  51 ++-----
 hw/input/adb-kbd.c           | 246 +++++++++++++++--------------
 hw/input/adb-mouse.c         |  22 ++-
 hw/input/hid.c               |  41 +++--
 hw/input/ps2.c               | 118 +++++++-------
 hw/input/stellaris_gamepad.c |  11 +-
 hw/input/virtio-input-hid.c  |  89 ++++++-----
 hw/m68k/next-kbd.c           | 128 ++++++++--------
 qemu-keymap.c                |  41 +++--
 replay/replay-events.c       |   6 +-
 replay/replay-input.c        | 117 +++++---------
 replay/replay.c              |   2 +-
 replay/stubs-system.c        |   2 +-
 tools/qemu-vnc/input.c       |   9 +-
 ui/console.c                 |  62 +++++---
 ui/dbus-console.c            |   8 +-
 ui/gtk.c                     |  55 ++++---
 ui/input-barrier.c           |  26 ++--
 ui/input-keymap.c            |  74 +++++----
 ui/input-legacy.c            |  47 ++----
 ui/input-linux.c             |   3 +-
 ui/input.c                   | 214 ++++++++++++--------------
 ui/kbd-state.c               |  61 ++++----
 ui/keymaps.c                 |   4 +-
 ui/sdl2-input.c              |  17 ++-
 ui/spice-input.c             |   3 +-
 ui/vdagent.c                 |  20 +--
 ui/vnc-auth-sasl.c           |   2 +
 ui/vnc-clipboard.c           |   9 +-
 ui/vnc.c                     |  41 ++---
 ui/vt100.c                   |  11 +-
 ui/x_keymap.c                |  24 +--
 hw/input/trace-events        |   2 +-
 tools/qemu-vnc/trace-events  |   2 +-
 ui/cocoa.m                   | 289 ++++++++++++++++++-----------------
 ui/meson.build               |  29 ++--
 ui/trace-events              |   5 +-
 49 files changed, 1014 insertions(+), 1098 deletions(-)

-- 
2.54.0


