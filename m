Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9194CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasg-000579-NV; Tue, 29 Sep 2026 12:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasf-00056e-9w
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:37 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasd-0006Lh-0p
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:36 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff6f0f87so20310705e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700032; x=1791304832; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rsuNvTpJrxJ1QKZ7lFlCu/LAQb5JBsJP99+2NRLKwMc=;
 b=fbR4yM0dWV5ZPT89JRF+pfKznDtYB378O3qRgKAkc4AmTg+8L7uxys32y/TE3RZhmE
 gIBNzI3qNId5gy0+C8Lnyj/ee+veKD1fdQ2siRRkd82Q0OpE5Zd4IPhwcuXfQaPrB+g/
 ZLoNf2GCa1mr2ELrvvddwvUJz/Ni2cw+ltfimWfZI3s5hfSoPfW70tJ5s+i3NqV0qlEg
 viWikDIjkUTiVUgXLuzHn2V/n26C1L2OAOQXfbs6jB5c8zBXiTT7+CK1Ise5o29ztGkx
 w+32VESaEglrfo4BsBJ1jKr7iQCTEOu6lxI4kx5pLMZ3dHsD/2/N1tsIaiU0JPWrIIXM
 7rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700032; x=1791304832;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rsuNvTpJrxJ1QKZ7lFlCu/LAQb5JBsJP99+2NRLKwMc=;
 b=CwRoNow3IVx99vPyLF6DwjCo3MIGS8ObeOHnnwVx1xc+RX5cehG5GJ7P5ZjEAHIrHe
 ebMB8kVqjK4YGJF8LhszhNBSgu3ZZJ2R2dw4ycRMfuYTfNMLnDzo53Y/tulzmBH6hWjY
 27aTiI8YxnHbCaUpTTVLFySSHAaFEC66RwzOTjyZKGyL5J2nj+6GqYzZc1inG3S2BUK8
 uFSRqAZWpYk0Y5/WQElEN3zl9PWZu9drmBfTGQyWAHOAVF8SZRPXVH5NGntpkJQrae9z
 +CEDQSxM7FBVEcaw+j81TC9+xhbvYot81BEDS0o1GtX4/+AxYuYyEmhyqPGRCSz03no0
 B+Pw==
X-Gm-Message-State: AFuF++kJfFFJKvxnFll8x5MM79v0QXeC8PU5HvGKdcobtFp5GYuY1L7k
 ojTQQ/+pfYpiKj7DTexuE/VUJ5Mnzwl7ZLKbso41MuzxuohShM6FCiUK
X-Gm-Gg: AYBFou2YIdsGIP1IqIXJc+GD1tjeq6Fsb+cOi06D1RpwXb+1nvm2cjoEqnszdlXunpk
 Qods1ius3XbRHJCwJW+7TqtP62KBz4CBH+Jj0aryUod0rEY4oCKpwH1BFKsEhLMi/vlcUBUd31c
 PQ4TkN+MHCZ30aETbncIW67TtvQWQmt9Sc15rh2q3ECVhZn21L4nd0JfZbjcpsHcGMlr5hz0led
 2qLU6ClJskeraJs4lYsaPljE3sGarKy9cGpVH7Yb6PeX1ty0ilwvxY9qP2j7NPd19w09GWk68iE
 vpYH8gwT1nYwEfR0llhSjVCCNDeXBTmtwod+DXW1pSE4OqaMnVyXDquklO2TkX62+pvcH85Vqfb
 xYb22NZKiT0CLnwYmDk0f5B6BhEL3elS34bhKlNT9WEeRZ5tplYgXSqCViwLlcqzZWO0txclZF0
 9geZ1IR7zOlvn/g2eqHaW3wDGTJu0HZWqowoP+uKmoIxp4bsMqJo9QE5MzFrOZWVu5RtXxUWgA3
 VD5BWIY/O0WXkrm9vW5ujaS2nQ=
X-Received: by 2002:a05:600c:c494:b0:49c:fa21:1c81 with SMTP id
 5b1f17b1804b1-49fe7bab979mr286015765e9.22.1790700031540; 
 Tue, 29 Sep 2026 09:40:31 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfec703sm84790945e9.6.2026.09.29.09.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:31 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v8 00/12] virtio-console: notify about the terminal size
Date: Tue, 29 Sep 2026 18:38:28 +0200
Message-Id: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOQW7DIBCF4atErEs0wACmq96j6oKQcUCKTQWRl
 TTy3YsjRbVidfkW3693Z5VKosred3dWaEo15bGN7m3HQvTjiXg6ts0kSA1OSB7yWPOZeKGafog
 7E1AKhIOHjjX0XahP10fw86vtvuSBX2Ih/8wAGOmEQUCxRyu17LjgY44Ya/04DT6d9yEPSyume
 snl9vg24VL898aEHLh1UhMi+j7gqrTcmPSKS7HhuvHOkQrGSgsGXrl5cgNCuA03jSvl7QGUAm/
 9K7d/3MCW28YhaA39MVAQes3nef4FkJwY4KUBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=5699;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=6elpaP0WwG5XGbQ+KMTaKuyvh7FgV9NCPWIgSUFd0Sc=;
 b=867ob9yUMCt2+W3kcNtNLoEIOzBjPbNv0CnkROamh0ml8AQOJuU83AMYZM2nR3rJSwoMs3LCQ
 Tk4ctDlXBMsAyrjDhRw6GjpAxCVLlm1fw7RqaRXSztJEeawk1qFCARH
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x10.google.com
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
 chardev/char-stdio.c              | 30 +++++++++++++++
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
 include/qemu/main-loop.h          |  4 ++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/passt.c                       |  1 +
 net/vhost-user.c                  |  1 +
 qapi/char.json                    | 31 +++++++++++++++
 ui/console-vc.c                   |  8 ++++
 ui/curses.c                       | 11 +++---
 ui/gtk.c                          | 28 ++++++++++++++
 util/main-loop.c                  | 21 ++++++++++
 32 files changed, 357 insertions(+), 11 deletions(-)
---
base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1
change-id: 20250912-console-resize-96c42140ba08

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


