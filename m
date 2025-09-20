Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE648CAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hj-000509-5v; Sat, 20 Sep 2025 19:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HR-0004Z1-Do
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HL-0006eV-Pt
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so936155f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411964; x=1759016764; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X9w++XI6kuMpT/GrEdzmaBxMvxDieHeJG+/Fi0Z+ZQo=;
 b=ZzMW5mOfZfo7312SREkR13B48AGcpJpKJblFX+S21VlK4o/6G4XR8BqnRd5SqkrAK7
 8d9lkGKSBPrAnzXdoPZg+IDOQaeq9sha7wdFxhDWPPZ83/uchEGGiI6Am/VAaWmKxDqg
 NZh5ATPea9/dQz9qksxNdxpRqfZAb5eZYUCE+15b+AKuXyRP0QhwdBYUDCK9ubDUpD6G
 cdAwROc0WlJ4YVyKXBczlLj4bKxnC0mk3N3Yr4UqEojjfZz8zYFzIjhsnl+6jnR2ssq1
 BpwuVGtH8KQkYAlq5c6A//wosS4gvnKVVS5hA690lu8Vm9GC/U0totviBaMpjEJCFLZM
 qLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411964; x=1759016764;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9w++XI6kuMpT/GrEdzmaBxMvxDieHeJG+/Fi0Z+ZQo=;
 b=N2yv5YreiEfXTylcQSFaVLLEW5gqVyhIgUQDM9zsV+Z5rXxwtSsBYOf+ymz+9gdIYt
 HonvQ/g93cF4UGslgLjBMHpXJM6IC2XQ1yjUVq7rQn2oDPjYUcH3qoUeEjyDavJySC6i
 NrF+vn7vkkvl3aVjDkutoTo7K94C5L/tzsCbljfY+pkvBirUz/Fm87oXdgF1oUXKqg6b
 gjH+hsa4X2LY7INZ1Qv2iA0YPdHFtCarrq3cRiXuc3cQ933hmGZBzTqHlnErO1tesT21
 aE5L5G3Gbve0nbaqqlT6g8/kGjL6lrkY1DDXqvPXTkDlrxXOvUFfNvDQ/0A47A8S0XJ9
 tuiQ==
X-Gm-Message-State: AOJu0YxTvXeO+h3WTzPMSc8oRA/2gEEumP0ADgk6wYhpm+5QYU/efIiF
 WQBlbbpeJLwFigtizfY1l1kHT74HdsHAoWF/vWmoYclrj170OPHWxYSF
X-Gm-Gg: ASbGnctzv3+PG66wO1+mblb6pPK+6QvL7BgKcUSzRk2HPE47txNIAKp0LvqtjpoHsdU
 Z0SKeRpbNCAj5X04v4Ni2U9fjQWxmjVqfpsXTVf0lFsRIU19iGZ/T0NIBrcyXEocSG3xs6SiZdh
 DO9Ntd0qwnP8AXIvzmwuYUVdOCAWweTuWQF7wLxFndW4try1J8LMV/A4Oft1jbAYfYv/+gEQgeg
 B+c5wz0ct42+GdWM/vGZNSnjDt45mSo45H1urZ5oarSpYpVW4R4nzUeCaUd0IwTXqUe+xH24IMZ
 wccWPmesaT0kIEeAd6+ZYQy99yhsfncnjvKQtw7Zzv201+8XiFeTNv9xiGKpSffb5VtqX/Cly2i
 A2/AmC99BlKTd8+RzftsjYtlrzgoERalD3V6fK6vRYuCnu5/Ylj8/
X-Google-Smtp-Source: AGHT+IED3AWMCQbGAWiWzH/oThqA02hy/2UqEByCN0SmTju+gYhsIIZzewKbE+bGT/h87gXtMQWwAA==
X-Received: by 2002:a05:6000:310f:b0:3e4:b44d:c586 with SMTP id
 ffacd0b85a97d-3ee8472b5e6mr5913028f8f.34.1758411964279; 
 Sat, 20 Sep 2025 16:46:04 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3f95c5cdaaesm1699726f8f.4.2025.09.20.16.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:03 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH RFC v5 00/12] virtio-console: notify about the terminal
 size
Date: Sun, 21 Sep 2025 01:45:30 +0200
Message-Id: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJo8z2gC/3XOQQrCMBQE0KuUrP0lCT9t40oQPIBb6SLG3ybQN
 pKUopbe3VoQ3LicgXnMzBJFT4nts5lFmnzyYViD2mXMOjO0BP62Zia5VFwLCTYMKXQEkZJ/Eej
 CohTIr4ZXbB3dIzX+sYEXdj4dWb2WTQw9jC6S+VqcF1KLAjmKHEupZAUChuDQpXRoe+O73Ib+A
 zqfxhCf28EJN/bflwmBQ6mlIkQ0jcUfqV6W5Q2zzma07QAAAA==
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
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=6043;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=/97Xcv5n5W+LYdTzUhdyogIyz5NuZYmhA+kWsYjVj5U=;
 b=gkdCnxU0xzGReEIc/naeyrBz4yaPQyozD7pfJjneLEoW7lLEBgGsXq+6/3ATtdwVczOrl2Qnu
 qFHQqCcWFghDawjU1ouWNIymTRGRXWrCmfXLyKOLgz2n9VatAE1l5S2
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x432.google.com
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

The goal of this series is to have a resizable terminal into a guest
without having to set up networking and using, e.g. ssh.

I tagged this version as an RFC as we still need to wait for a decision
on the swapped rows/cols issue by the virtio maintainers, so it cannot
be merged right away. I would still like to request a review especially
for the two (small) 'vc' chardev patches, which are new in this version.

The virtio spec allows a virtio-console device to notify the guest about
terminal resizes in the host. Linux Kernel implements the driver part of
the spec. This series implement the device part in QEMU.

Terminal size support is added for stdio and vc backends. It would make
sense to also add size support to the pty and serial backends, however
it's not possible to receive resize notifications for tty devices other
than a process' controlling terminal. For the serial backend, it might
still be useful to query the initial dimensions. (In a previous
discussion, only the pty backend was considered, where the initial
dimensions are useless.)

The 'vc' chardev changes are incomplete, because this chardev has
multiple implementations in QEMU. This series contains adds size support
to the generic and gtk/vte implementations. I think I also need to add
a spice implementation, please let me know if there is anything else.

I would also like some advice on how to test resizing the virtual
console. I tried resizing the window of the sdl backend, but that didn't
change the dimensions of the console (instead rescaling the console
image to fit the window).

This series also introduces resize messages that can be sent over QMP to
notify QEMU about the size of the terminal connented to some chardev.
In the libvirt setting, it will allow to implement a resizable terminal
for virsh console and other libvirt clients.

For a long time, the Linux implementation of virtio-console had rows and
columns swapped. This was fixed in Linux 6.15, but older versions will
interpret the dimensions incorrectly. There are two ways this might be
resolved:
 - It has been proposed to change the virtio spec to match historical
   Linux behavior. If the change is accepted, the fix would be reverted
   and we would end up with only two or three broken Linux versions.
 - Alternately, the Linux fix would be kept and backported to LTS
   versions.

In any case, users of broken Linux versions can disable the feature
using the console-size property.

Thanks to Markus, Daniel and Max for their feedback on v4,
and to Michael for helping with the swapped rows/cols issue.

v5:
- rename chardev-resize -> chardev-window-size-changed
- improve chardev-window-size-changed documentation
- add partial implementation for 'vc' chardev
- config space now returns port 0 size if multiport
- console-size property completely disables size support
- fix misnamed variables in char-win-stdio
- Link to v4: https://lore.kernel.org/qemu-devel/20250912-console-resize-v4-0-7925e444afc4@gmail.com

v4:
- changed order of rows and cols fields
- added support for terminal size on Windows
- trace event is also emitted for legacy (non-multiport) drivers
- minor fixes required because of changes in QEMU (DECLARE_INSTANCE_CHECKER, qmp-example)
- updated version numbers ('Since: 10.2', hw_compat_10_1)
- Link to v3: https://lore.kernel.org/qemu-devel/20200629164041.472528-1-noh4hss@gmail.com

v3:
- add resize messages over QMP, as suggested by Daniel

v2:
- fix adding a new virtio feature bit to the virtio console device

---
Filip Hejsek (3):
      char-win-stdio: add support for terminal size
      ui/console-vc: forward text console size to vc chardev
      ui/gtk: forward gtk console size to vc chardev

Szymon Lukasz (9):
      chardev: add cols, rows fields
      chardev: add CHR_EVENT_RESIZE
      chardev: add qemu_chr_resize()
      char-mux: add support for the terminal size
      main-loop: change the handling of SIGWINCH
      char-stdio: add support for the terminal size
      qmp: add chardev-window-size-changed command
      virtio-serial-bus: add terminal resize messages
      virtio-console: notify the guest about terminal resizes

 backends/cryptodev-vhost-user.c   |  1 +
 chardev/char-fe.c                 | 13 ++++++++
 chardev/char-mux.c                | 18 ++++++++++-
 chardev/char-stdio.c              | 30 +++++++++++++++++++
 chardev/char-win-stdio.c          | 19 ++++++++++++
 chardev/char.c                    | 26 ++++++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 63 ++++++++++++++++++++++++++++++++++++---
 hw/char/virtio-serial-bus.c       | 51 +++++++++++++++++++++++++++++--
 hw/core/machine.c                 |  4 ++-
 hw/ipmi/ipmi_bmc_extern.c         |  1 +
 hw/scsi/vhost-user-scsi.c         |  1 +
 hw/usb/ccid-card-passthru.c       |  1 +
 hw/usb/dev-serial.c               |  1 +
 hw/usb/redirect.c                 |  1 +
 hw/virtio/vhost-user-base.c       |  1 +
 hw/virtio/vhost-user-scmi.c       |  1 +
 include/chardev/char-fe.h         | 10 +++++++
 include/chardev/char.h            |  7 +++++
 include/hw/virtio/virtio-serial.h |  5 ++++
 include/qemu/main-loop.h          |  4 +++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/passt.c                       |  1 +
 net/vhost-user.c                  |  1 +
 qapi/char.json                    | 30 +++++++++++++++++++
 ui/console-vc.c                   |  3 ++
 ui/curses.c                       | 11 +++----
 ui/gtk.c                          | 27 +++++++++++++++++
 util/main-loop.c                  | 21 +++++++++++++
 32 files changed, 344 insertions(+), 13 deletions(-)
---
base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
change-id: 20250912-console-resize-96c42140ba08

Best regards,
-- 
Filip Hejsek <filip.hejsek@gmail.com>


