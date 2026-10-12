Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B111CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGeR-0008VM-4v; Mon, 12 Oct 2026 10:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeP-0008Uf-5t
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeN-0005vQ-5L
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so17731135e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813909; x=1792418709; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H1kBJpb5K/8c39yXgw1RJtCNzQ8kubIxC951Rpn+/iM=;
 b=FQzsoh3wq94uTeTIRTIX21DfW7t/dTyi7L+Hr6vEezwvf1hToqmTu2nCEUTALDXwQi
 57LUBdyNDSIvSVPzrBFa+9dS71o59f+2HlWIHBYDACqT0MG0VUaVv7UPprfss8GlFusl
 BMf6cwQYdHsNRa/VBxIMMZ/FW1l2RyNg/TcdGMlfFDtOV2ZhD2d7LZKBo5Syh6CLJ2KL
 SeznoX7VTutZX/NicCqzBFYqWn5DEwYRVj73aWpMjBIdq3bFX31XP5yOQ6HjwdJLzhyo
 7NYEqnVkSmr8hCd0Sxrx1gnfk9eAwKJXHMiWnwICzd3YQXlUr3HiW+sxbFAhFHXFB3td
 5oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813909; x=1792418709;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H1kBJpb5K/8c39yXgw1RJtCNzQ8kubIxC951Rpn+/iM=;
 b=Use4UU+fZ1QDERseelIrwSxuUmZzIjDstVMmkHvAo+FzJPRPVGk+1mzEK0sfI3MFoi
 yzLABvGzzNQPESL22xRCDRq+Gs80tyN4kdGZplHVgdM8Qufb8AtTs04ZUGUJpyTq8ApH
 wHAF9f0fBxr33Z+qg3Uz5WtlRV8i1i50r8ZHyuRAxRKQDJvqAmnn1h4IJ0r8i7s5m1j+
 HU1dkk4+eG47EO4bQEgHiVV3Zx4LeGEpwGhGKCbjufLBNnVg3Kc25iyMNyX44hf8WXe9
 TbZmiXY92FSUzmW/iXqHpGKbRcV6GDPqJ53BqO8sfW/kWztlJjp9I6+umrBk22e9rtdd
 EJEA==
X-Gm-Message-State: AFq9FYIYPTBUR+cj/cbVwIJ1zi/opFbfGLwzaxOm6Lu+DJtibuRD+G3j
 K5eSC8mREVticc3f0NARUbXMiRrf6Lc1/weXBsw/P1UqoxeAnHxp1psg
X-Gm-Gg: AYBFou3daHl8JmwkZiQ905SGWqhry097/FRqnEciuqQ7MAM+VcWoHpEi0UM8M1IBZZN
 7UjCbq8Q+a+JV7dUwoWXRSuKScGcVx5P7FWsZVcu8TMsbXGd3KRUL7DBC5UqmW9p00YKpg6Xxn/
 WTOQBr/mJMFQ0CmQ/bvAXYRxI5J5gIgA3srXfDqlZ3XYRtnRrp8Mx80/z8JDvpbTgDz0fxzoU1P
 jJ5srpKkMrTXSohz91S6o+Y3UoMfk0VcF58i2NFG1SLJqWmhUZZg0pUb9hXTQXh3uBHUTRvXFFC
 qMYG7xxz/9eyF+vw2zDJ9zLepd1SGoGHWnkRNtD8FraLOAT49q7kAg3BdRsvJcyBcT45278BcPs
 2ZfncWBbW0SD6SaeF+aAb3ptoAxWHe9PsvtXCJ9B1fzTYaTwNhOIVlOzZ16V6j8RVyN8QzwupQn
 0xemV5nViEifblqQbrB5SaV9JfwEWwSS3gJ9t9CJ+la+38dUW1Rgyj+QZ1SKw3aeECFAyJ6kV//
 HzASp4LNo/t70M6g0mvCFdwDw==
X-Received: by 2002:a05:600c:4e89:b0:4a1:96cd:2f64 with SMTP id
 5b1f17b1804b1-4a196cd312cmr127090715e9.1.1791813909312; 
 Mon, 12 Oct 2026 07:05:09 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19471edd5sm352905815e9.11.2026.10.12.07.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:08 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v10 00/12] virtio-console: notify about the terminal size
Date: Mon, 12 Oct 2026 16:04:59 +0200
Message-Id: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRTWrDMBAF4KsEr6swM/rvqvcoXciKFAsSK0jBt
 A25e+VAmmC3yxF8jzejS1dDSaF2r5tLV8KUaspjGxBeNp0f3LgPLO3aQ0dAEiwS83ms+RBYCTV
 9B2aVF4QCegema+hUQkyft8T3jzbHko/sPJTg7jEAiiwqAQK3QpMkw5CNeRBDrW/7o0uHrc/HO
 WtI9ZzL163cJObEf2tMggHTlmQQQrjoxVPSXGOST5xwxWXjxgbulSYNCpZc3bkCRLviqnHOne6
 Bc3DaLbl+cAVrrhsHLyXEnQ8e5ZKbB7e05qZxitGi4dFouSpvfznCH6ez8+67XhtO7RsNPvPr9
 foD+PHpvSQCAAA=
X-Change-ID: 20250912-console-resize-96c42140ba08
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=6030;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=wZGSMRoiTh20OaW0/LwUuZ8TwverPjRCfaRZOOmSBKw=;
 b=M7s/yEBoOAZ4SMcAmi7AHnjORRHj8JIe4kzK/OCfBn7Z/oAKBvbygSy+GE3qNZDXxLaFc591l
 wXz97/Uhv3WBkcLRfAM+4f10wUA+fbQiXrC05t/6MGlUzVMqPeWA0q2
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x335.google.com
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

Summary of the Series
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

There was a bug in Linux versions prior to 6.15 which caused the
dimensions to be interpreted incorrectly by the guest. The fix has
been backported to currently supported kernels, but to avoid making the
terminal harder to use on out of date guests, the feature is disabled
by default and must be enabled with the console-size property.

Limitations
-----------

There is no documentation for the virtio-serial device. I'm working on
this and will submit it separately.

Resizing support for the spice version of 'vc' chardev is still missing.

After migration, the guest is not informed about the new console size.
I propably won't fix this any time soon unless someone helps me with
migration stream changes.

Full Changelog
--------------

v10:
- Fix build error on win32
- Link to v9: https://lore.kernel.org/qemu-devel/20261012-console-resize-v9-0-8db78320ba81@gmail.com

v9:
- Clean up SIGWINCH notifier when stdio or curses chardev is destroyed
- Link to v8: https://lore.kernel.org/qemu-devel/20260929-console-resize-v8-0-2ff9183f8750@gmail.com

v8:
- Rebased
- Fixed uninitialized buffer in send_console_resize
- "Since: 11.1" -> "Since: 11.2"
- Link to v7: https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com

v7:
- Rebased
- Renamed some functions
- Made virtio size support disabled by default
- "Since: 11.0" -> "Since: 11.1"
- Dropped "must exist" from chardev id param description in qmp docs
- Link to v6: https://lore.kernel.org/qemu-devel/20260119-console-resize-v6-0-33a7b0330a7a@gmail.com

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
      char-win-stdio: add support for terminal size
      ui/console-vc: forward text console size to vc chardev
      ui/gtk: forward gtk console size to vc chardev
      virtio-serial-bus: add terminal resize messages

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
 chardev/char-mux.c                | 19 ++++++++-
 chardev/char-stdio.c              | 33 ++++++++++++++++
 chardev/char-win-stdio.c          | 19 +++++++++
 chardev/char.c                    | 26 +++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 35 +++++++++++++++--
 hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
 hw/display/vhost-user-media.c     |  1 +
 hw/ipmi/ipmi_bmc_extern.c         |  1 +
 hw/scsi/vhost-user-scsi.c         |  1 +
 hw/usb/ccid-card-passthru.c       |  1 +
 hw/usb/dev-serial.c               |  1 +
 hw/usb/redirect.c                 |  1 +
 hw/virtio/vhost-user-base.c       |  1 +
 hw/virtio/vhost-user-scmi.c       |  1 +
 include/chardev/char-fe.h         | 10 +++++
 include/chardev/char.h            |  9 +++++
 include/hw/virtio/virtio-serial.h |  7 ++++
 include/qemu/main-loop.h          |  5 +++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/passt.c                       |  1 +
 net/vhost-user.c                  |  1 +
 qapi/char.json                    | 31 +++++++++++++++
 ui/console-vc.c                   |  8 ++++
 ui/curses.c                       | 21 +++++++---
 ui/gtk.c                          | 28 ++++++++++++++
 util/main-loop.c                  | 33 ++++++++++++++++
 32 files changed, 382 insertions(+), 12 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20250912-console-resize-96c42140ba08

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


