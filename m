Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A2ACD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs74-00056f-T9; Wed, 17 Jun 2026 11:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs73-00056B-9o
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs71-00041K-0q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=us2rijxDD1Aj0olsPIHkl1pjpQn/infBngJI6/1xwOs=;
 b=gDnuL4NSGtCJuKu1KM/p2kIwg5zCW1jfIiJOYLOQteL8lSFLWDoSTdCr00nCFJObrH3xsn
 UokPwIxzpLMk0Eut1OCLXAjL11eZzWEGR8hyCD7BNqNeHRiKX8bnIhIq93JUQntTI6XXCy
 75XtApz8UnooKZv2CueEt6fThyzh2/8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-UczLduqMPFOW_Fwpy3rEDg-1; Wed,
 17 Jun 2026 11:23:27 -0400
X-MC-Unique: UczLduqMPFOW_Fwpy3rEDg-1
X-Mimecast-MFC-AGG-ID: UczLduqMPFOW_Fwpy3rEDg_1781709807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA90B195607A
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:23:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98442180049F; Wed, 17 Jun 2026 15:23:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/27] UI patches for 2026-06-17
Message-Id: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
Date: Wed, 17 Jun 2026 19:22:57 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4388;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=604hUisd+rrwjfbWMTzXpqrY+OouJ1N1hWvGri9GzCg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvoGWvXoO6/tXs/UsPF1QAgL5sOX+QPAtnaQ
 O+3041TtZuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5U7eEACUakZOsyNDLMVC5KxF533N8fFhnzUP9zLU/SSAmB/o2xyOvAIBF9tUsHpYdpNZkYTlDcz
 RNtVBiVpYgppGsKVKnJPaAw/LaKJuSRh3tEztFfgYitAtihmEkVkjYLAOe9wALvayCcWPNljqkj
 59Vecm+WOg6CrFHhjv2k0fRLTNxsS9XmYJNet7+b85z47UYfOtNsbpfvnvmA1gzwI4nGHgAXR+v
 uSV8AqCeF92caEWbemf9X9ZxlJEv2VmPeZ6M9UcG4cg2JghBpTzVd6IJj/SBegu/1T0B22rBEer
 Fgp3wYSjzc3RdrzaO43c1sCt4N7cWH2PIC1oGTVCnMgglcJl5DTJVL5TGfeVgOAboXg4Yoa8eNE
 1hkL7xpesyG0vYeN/rGrqW51rqhqa9VoBV8CMOMYNoCEiMrGUjY/vrXjMuLdsmMHaMX4n0jFHqx
 rRCgB9FCMPkKaB9ns3hz1NpXehOgxjZ2ISCPlL7Fb3vTFPAYGC6jgMv6wPSEeLCC6gdEpcPs8mh
 rhrS9cnbIsQ7g/Um5DFcOCm/nD46ojdZH8yLnBycOPzxkHpWtuQFtLLysvQ/dPnzf2QXI1GTFQV
 f4fdc/HJAPMgPNFgoQTa0EqjcMe+BT1ij5g37MCMnhmqFGqgKVY+T1qLL+9h5IK/QyV8sipweE8
 0XYA2k1ymxt1tRA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The following changes since commit b0df6e2f2c6c45df8d4d286933799c623e124d98:

  Merge tag 'pull-riscv-to-apply-20260616' of https://github.com/alistair23/qemu into staging (2026-06-16 10:41:47 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-input-pr-v1

for you to fetch changes up to 490a3e1867f025c68fa13db766b5c8da16c6eca4:

  ui/sdl2: Set GL ES profile before creating initial GL context (2026-06-17 19:22:50 +0400)

----------------------------------------------------------------
UI patches for 2026-06-17

- retire input-legacy.c
- sdl2 fixes

To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      ui/sdl2: Explicitly specify EGL platform

Marc-André Lureau (23):
      hmp-commands.hx: fix button_state doc
      ui/hmp: move index_from_key() where it is used
      hw/i386/vmmouse: convert to QemuInputHandler API
      hw/usb/dev-wacom: convert to modern QemuInputHandler API
      ui: move LED and key utilities to input.c, delete input-legacy.c
      hw/input: replace fprint with LOG_GUEST_ERROR
      ui/input: remove double-notification on qemu_mouse_set()
      ui/input: remove dead declaration
      ui/input: add LED state tracking to QemuInputHandlerState
      hw/input/ps2: keep QemuInputHandlerState in PS2State
      hw/arm: keep QemuInputHandlerState in musicpal
      hw/input: keep QemuInputHandlerState in adb-kbd
      hw/input: keep QemuInputHandlerState in stellaris
      hw/m68k: keep QemuInputHandlerState in next-kbd
      ui/input: qemu_input_handler_register to warn for unused result
      hw/input/ps2: use qemu_input_handler_set_leds_mask() for LED state
      hw/input/hid: use qemu_input_handler_set_leds_mask() for LED state
      hw/input/virtio-input-hid: use qemu_input_handler_set_leds_mask() for LED state
      ui/vnc: switch LED handling to Notifier-based input API
      ui/spice: switch LED handling to Notifier-based input API
      ui/dbus: switch LED handling to Notifier-based input API
      ui/input: remove old LED handler broadcast queue
      ui/pixman: fix zero rowstride in qemu_pixman_image_new_shareable()

Philippe Mathieu-Daudé (2):
      tools/qemu-vnc: Have console_get_mouse/keyboard take const QemuConsole
      ui/input: Have qemu_input_is_absolute() take a const QemuConsole

Ryan Zhang (1):
      ui/sdl2: Set GL ES profile before creating initial GL context

 include/hw/input/ps2.h               |   2 +
 include/hw/input/stellaris_gamepad.h |   2 +
 include/ui/console.h                 |  30 -----
 include/ui/egl-helpers.h             |   5 +
 include/ui/input.h                   |  15 ++-
 include/ui/pixman-minimal.h          |  25 +---
 include/ui/qemu-pixman-helpers.h     |  49 ++++++++
 include/ui/qemu-pixman.h             |   1 +
 tools/qemu-vnc/qemu-vnc.h            |   4 +-
 ui/vnc.h                             |   2 +-
 hw/arm/musicpal.c                    |  13 +-
 hw/i386/vmmouse.c                    | 115 ++++++++++++-----
 hw/input/adb-kbd.c                   |  17 ++-
 hw/input/hid.c                       |   3 +-
 hw/input/ps2.c                       |  28 ++++-
 hw/input/stellaris_gamepad.c         |  12 +-
 hw/input/virtio-input-hid.c          |  15 ++-
 hw/m68k/next-kbd.c                   |  11 +-
 hw/usb/dev-wacom.c                   | 155 ++++++++++++++---------
 tools/qemu-vnc/display.c             |   4 +-
 tools/qemu-vnc/input.c               |  51 +++-----
 ui/dbus-console.c                    |  14 ++-
 ui/egl-helpers.c                     |   4 +-
 ui/input-legacy.c                    | 236 -----------------------------------
 ui/input.c                           |  80 ++++++++++--
 ui/qemu-pixman.c                     |   8 +-
 ui/sdl2.c                            |   5 +-
 ui/spice-input.c                     |  16 ++-
 ui/ui-hmp-cmds.c                     |  22 +++-
 ui/vnc.c                             |  11 +-
 hmp-commands.hx                      |   4 +-
 hw/i386/trace-events                 |   2 +-
 ui/meson.build                       |   1 -
 33 files changed, 495 insertions(+), 467 deletions(-)
 create mode 100644 include/ui/qemu-pixman-helpers.h
 delete mode 100644 ui/input-legacy.c


