Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB13CA5FED
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfwz-00074z-97; Sun, 18 Jan 2026 22:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwc-00072Z-B9
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:47 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwW-0004AP-Kt
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:44 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b870732cce2so587908666b.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793316; x=1769398116; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L22o3zLXCwrulXdv1pmQlKTEfLQqaGrEqGb1SqovEz8=;
 b=aOFxP6g2nL/plBBhl9Y2v2yV7YBBAut9Doy0tnQ+41uN3NJ9uDQVPbDPO3jfozAIEx
 CKX0Jblp7fV/Tg/X2KyI826LhK7mSC3cN/8vDMkvabbOWkqm/oLBIS8gjakX0tksB1CS
 RVsyBp0ohwivvV4RPD/3p+VmsWkR3zCIfU9lJNHVIwgI1qVAk5gtkMQNNb/F6yHrC+L4
 vows6TF2ZVFHTo6ncVoQnFqAGV3inkxWD8T88EzzcPNeik+fr4U7eM7qKafo3iLwjU1D
 ycAKR2jAN85p4hCxGDZ6Hivz5dTVw0OUw3OQzSpZjOZtcB6wU3RLTXM1Qey1SCjbyi2I
 S3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793316; x=1769398116;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L22o3zLXCwrulXdv1pmQlKTEfLQqaGrEqGb1SqovEz8=;
 b=PF/ZXAAIHOs4HNXmPe3RenrxPXIi6rO2bzDtz1heURlYM51OjxwtCf0bNnEWzfzt8F
 PJaU++UfnSSqBv85XuJ8mijs0/1LQSlPa30fWOcwD/M/GuDEJkKrKeo1dk5KW2e047nz
 wXu7myqdhHx/UWIifjNTYXeYLm9ZzBLgmrhQeurZ5hN6KCUA7TUGlBOBwOp0UUE7ZtSr
 U1zkncfBEdY5clBQUot8MDBAhnF5c+Sz1Rw2Evw2pKgptey1WjNu4h0Ppr9jXI7yK4ly
 APfkQPbwU9qPP6pIBUeeSLEtuxG1ArIxYeSQ6G2sdA4Kp7OPIfbBhVAhmXxcy8xfkWfZ
 gtow==
X-Gm-Message-State: AOJu0YyvbYNzPdEaNhJA8i6na7pWCU8Uuus6GPT4E9TiRJLczqMqsHiK
 i039lx8eXa3BX9wRX6Ki48TmgAB2PaMvqiq+mCVKBN5IamLh4XY6Gaom
X-Gm-Gg: AY/fxX6c7mR4sD+eWq07rpIOissf9a/Kdt3YOkbUqZlBYaaBdrrEWGuzZAJfoxNV7fd
 +1MZIEsZns9akKpzFTwBlVLFf/Y5T0xaKBtGSYn2BNu7ZvFW0hI/qaS2quiKAFm0D1oyvCPUKi5
 D5Z7NOijv6A1uvVUR26RlUJJjehC12tJhptsUd3CwQL7Mjpz4x9PJe6Hh+ahwLMoap1nB0wPDcB
 P1J6NE45sXkPBq7ziQrgBaelgltqPE2nTYN6RdWeXT0b0T2R4M/hup/7ChL6uRGXDJ3+8Zmmcxh
 Cq8sUaT9znCNn9Ab4nF0Z4vK6KJQY239W6PVFaRxrZ8JeJ466iKxQGd0eg3YGlx5mE1TUQ+Ca12
 88EsQ4KoGJC+lqR2R65emxOlgr8mIUfkyO4ue1PjkCxlokv3LebqOpw3xw4V9LI5xLbSrrhGnUA
 ydFJQ7m2c230HmM04JqGuQaNGBI/51hhnpuXTQmfRQ
X-Received: by 2002:a17:907:940b:b0:b73:6d56:f3ff with SMTP id
 a640c23a62f3a-b87968f60f9mr764118466b.20.1768793315846; 
 Sun, 18 Jan 2026 19:28:35 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc70fsm9243511a12.17.2026.01.18.19.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:35 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v6 00/12] virtio-console: notify about the terminal size
Date: Mon, 19 Jan 2026 04:27:43 +0100
Message-Id: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQWrDMBAAvxJ07obVdiVbPeUfoQdVWUeC2CpSM
 EmD/145UDCEHucwwzxUlZKkqo/dQxWZU015amDfdipEP50F0qmxIiSDThOEPNV8EShS04+As4F
 JM3557FWTvosM6fYMHj8bDyWPcI1F/F8G0ZLTlpH1njsy1IOGKUeOtR7Oo0+Xfcjj2oqpXnO5P
 99mXov/bswMCJ0jI8zsh8Cb0roxm41O+kU3Te+dvAfbUYcWt/qyLL8T/8hfJwEAAA==
X-Change-ID: 20250912-console-resize-96c42140ba08
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=6395;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=GYYFdurqMqXOZ/L6zuHuelqc1k5rmTk6bwzBEW7KUuE=;
 b=5xr5agXQ8g1uCNeShJqpap8F5YHfA/X7oY00y6f5C/l76CkmdZaWb8T9pO5qVaV6VmxTOoDP4
 D0cJrOUqmeGDuHhX4m9HtyaXomvW959x0epczABf7Ozax29Yeftryzg
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Summary of The Series
---------------------

This series adds terminal size support to the virtio-console device.
The goal is to make it possible to get a resizable terminal into a guest
without using e.g. ssh.

Support for detecting terminal size is added to stdio and vc backends,
but not pty and serial, because for the later it's unfortunately
impossible to get resize notifications.

A QMP command is added for notifying QEMU about the terminal size
of any chardev. This can be used by clients to support resizing for
devices where QEMU is not able to detect the size by itself (e.g. virsh
console).

There is a bug in Linux versions prior to 6.15 which causes the
dimensions to be interpreted incorrectly by the guest. If the guest
kernel is not up to date, the wrong dimensions can make the terminal
hard to use. The fix will be backported to stable kernels soon, and the
problem can be worked around by disabling the feature using the
console-size property, restoring the previous behavior.

Notes for This Version
----------------------

The issue with swapped rows/cols has now been resolved - the virtio spec
will remain unchanged, and the kernel fix is being backported.

The console-size property is not documented, even though it can be
useful for working aroung a guest kernel bug.

The 'vc' chardev size support is still incomplete - size support has
been added only to the generic and gtk/vte implementations. Size support
for the spice implementation is still missing, and the generic
implementation is mostly untested.

The previous version had a bug that it didn't resend the size
after a guest reset. While fixing this, I ended up rewriting a
significant part of the virtio changes. I also removed the logic
that tries to avoid sending VIRTIO_CONSOLE_RESIZE messages before a
VIRTIO_CONSOLE_CONSOLE_PORT message. I don't think this should cause any
problems, but if it does, the logic could be reintroduced.

Because one of the patches ended up being significantly different from
Szymon Lukasz's original version, I decided to change patch author and
instead add a note about the original version to the commit message. Let
me know if you would like this to be handled differently.

I have also found an initial size bug in the Linux kernel
implementation, although it only affects non-multiport devices. I posted
a fix for the Linux bug to Linux maining lists [1].

[1]: https://lore.kernel.org/virtualization/20251224-virtio-console-fix-v1-1-69d0349692dc@gmail.com/

Full Changelog
--------------

v6:
- Rebased (renaming CharBackend -> CharFrontend)
- Virtio resize message code rewritten to fix corner cases
- Updated version numbers ('Since: 11.0', hw_compat_10_2)
- Added note to CHR_EVENT_RESIZE definition comment, explaining
  that only the focused frontend gets the event
- Fixed checkpatch warning (line length)
- Link to v5: https://lore.kernel.org/qemu-devel/20250921-console-resize-v5-0-89e3c6727060@gmail.com

v5:
- Rename chardev-resize -> chardev-window-size-changed
- Improve chardev-window-size-changed documentation
- Add partial implementation for 'vc' chardev
- Config space now returns port 0 size if multiport
- Console-size property completely disables size support
- Fix misnamed variables in char-win-stdio
- Link to v4: https://lore.kernel.org/qemu-devel/20250912-console-resize-v4-0-7925e444afc4@gmail.com

v4:
- Changed order of rows and cols fields
- Added support for terminal size on Windows
- Trace event is also emitted for legacy (non-multiport) drivers
- Minor fixes required because of changes in QEMU (DECLARE_INSTANCE_CHECKER, qmp-example)
- Updated version numbers ('Since: 10.2', hw_compat_10_1)
- Link to v3: https://lore.kernel.org/qemu-devel/20200629164041.472528-1-noh4hss@gmail.com

v3:
- Add resize messages over QMP, as suggested by Daniel

v2:
- Fix adding a new virtio feature bit to the virtio console device

---
Filip Hejsek (4):
      virtio-serial-bus: add terminal resize messages
      char-win-stdio: add support for terminal size
      ui/console-vc: forward text console size to vc chardev
      ui/gtk: forward gtk console size to vc chardev

Szymon Lukasz (8):
      chardev: add cols, rows fields
      chardev: add CHR_EVENT_RESIZE
      chardev: add qemu_chr_resize()
      char-mux: add support for the terminal size
      main-loop: change the handling of SIGWINCH
      char-stdio: add support for the terminal size
      qmp: add chardev-window-size-changed command
      virtio-console: notify the guest about terminal resizes

 backends/cryptodev-vhost-user.c   |  1 +
 chardev/char-fe.c                 | 13 +++++++
 chardev/char-mux.c                | 18 +++++++++-
 chardev/char-stdio.c              | 30 ++++++++++++++++
 chardev/char-win-stdio.c          | 19 ++++++++++
 chardev/char.c                    | 26 ++++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 35 ++++++++++++++++--
 hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++++++--
 hw/core/machine.c                 |  4 ++-
 hw/ipmi/ipmi_bmc_extern.c         |  1 +
 hw/scsi/vhost-user-scsi.c         |  1 +
 hw/usb/ccid-card-passthru.c       |  1 +
 hw/usb/dev-serial.c               |  1 +
 hw/usb/redirect.c                 |  1 +
 hw/virtio/vhost-user-base.c       |  1 +
 hw/virtio/vhost-user-scmi.c       |  1 +
 include/chardev/char-fe.h         | 10 ++++++
 include/chardev/char.h            |  9 +++++
 include/hw/virtio/virtio-serial.h |  5 +++
 include/qemu/main-loop.h          |  4 +++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/passt.c                       |  1 +
 net/vhost-user.c                  |  1 +
 qapi/char.json                    | 31 ++++++++++++++++
 ui/console-vc.c                   |  3 ++
 ui/curses.c                       | 11 +++---
 ui/gtk.c                          | 28 +++++++++++++++
 util/main-loop.c                  | 21 +++++++++++
 32 files changed, 346 insertions(+), 12 deletions(-)
---
base-commit: 38879a667fbb4ef54c70de71494882615f600a64
change-id: 20250912-console-resize-96c42140ba08

Best regards,
-- 
Filip Hejsek <filip.hejsek@gmail.com>


