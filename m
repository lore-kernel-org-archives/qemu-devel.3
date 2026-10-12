Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C730CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEe5-0003Vv-C9; Mon, 12 Oct 2026 07:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdw-0003Se-G2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdu-0002Lh-BA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso12806495e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806191; x=1792410991; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FumWGKrYewuIdm5UCVe+SZtlGbNu1secCW4JNaeGnZw=;
 b=VWQXPa+Q31WWz4u17WWW6RTsY+SVcL8iNyVAeHtr04gc+1MnoPwsn9ntXVXdEiwqIG
 oq5gtS7v1ImeltFqtcYZRFrc0osdbZ/k6FFMzXGo3A6awfL2AKVFfWV6+KPAy+3jWvCc
 3QKTvZJMgLiB+hblLhHLDU12H6fAFCzF+laRBgcK1XO29nl/wStA+qCNv9/cywvmdCmS
 1b6qvulb+t5EMY2l4QOst6ERzlBa2yJCtNE4uRhNfM/ghd0/CQxmAbb+gpp+bs9+29OQ
 VFl4jfSwo45XS3UMBqCH/DJp52U68xLBOZErdsOfSjZkNCIFLQn+aG+Np2OocISysIKV
 aFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806191; x=1792410991;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FumWGKrYewuIdm5UCVe+SZtlGbNu1secCW4JNaeGnZw=;
 b=qupUxs/fh/A0X0+pCB+M/B0jCOaxW1vHsoIN815NamJh5J+Ic750G78VpWOdYo4nhf
 nQ/Kut2W3ejjClzUjSWD61JIUbIEI5/xKyCy6X9bJzKzPQL4E25mM5NX2VT1sZFLZpPU
 miH0babRbmjdL9ra1HKbliXVMPgJzr+piagffcEEVLEXXwfPq3+xGYcYJI/DxsOv0sz2
 d0BB9/23bOm+vg0wG97K5du/JTANUlQSBjW6BrhbWZrmuWLSLoJ7bNGY/Vm7PMB4LCfI
 W6BKToocjzojrCnzDR6iBxThuF8HXSUiMnrIGkBbBp7Xhm55hpoQYlynKXHGU/8FQvwO
 Gspg==
X-Gm-Message-State: AFq9FYL3gkLQ/e1+EECzMAOhZB/zdPf4vjtmNpBcgptfKnufj6H7KTRi
 3ZetNoUFziK92pUK3oa+kmZRS1qTAE3UqnuJZH4O/WjYfsRXTvko5gOi
X-Gm-Gg: AYBFou2AL+M/aLDNJJ1b7UBBUpNeqh06oMWq3Xo0xuFYCmab3M7FttmYwJMcgOcpX1/
 4h+nK8P6Qm5KNxuE6NXylYNiQ6TT9Cyddsjc+ArS7ZJKPti2uMEcNpv1U14t4CKGE5/6eHY5tjf
 tRm2EvS1M2/RU04S9EDD4f7fnPbb3ZZT1rCW6Pkt7ofNN/UcTbrQru6a+SrD7yNt/eNQfVZagNV
 lCR81C90ZHr0/NF0zrdMAF88fzR0jEZL5A7tqxBdWrWkBDcmvH4pTDgKKSNM7x//VK1Py9oSmj2
 kHU2J480gaZ5NQY268IaMmuFTUe88TKNvZIjrQVgQMMVbO3Pi2+o5tisVcJ1vdGdxZHDORpJSRj
 XnBIpywFrYt86MhaYAArMDVBhj4x2BDeJoo9Zac4vXnlJ1OWhZTraZB2M15soY/nnJbjTk6V6+c
 KyE1b3Q1odayR2c5EFMmnLMM+arB+KiCV/uagP3T18b5yHuK9CafbTOWVbpPn6113TuPCgKZn8o
 WST3OhTlEmfW/m2OJYSB0yqg90=
X-Received: by 2002:a05:600c:6285:b0:4a1:70da:3350 with SMTP id
 5b1f17b1804b1-4a18e4b8c6emr171409975e9.32.1791806190763; 
 Mon, 12 Oct 2026 04:56:30 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm453404015e9.8.2026.10.12.04.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:30 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v9 00/12] virtio-console: notify about the terminal size
Date: Mon, 12 Oct 2026 13:55:51 +0200
Message-Id: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOy2rDMBCF4VcJWldhJI9uXfU9SheKMooFsVWkY
 NoGv3vlQEhq0+VZfD/nyiqVRJW97q6s0JRqymMb7mXHQu/HE/F0bJtJkAqckDzkseYz8UI1/RB
 3OqAUCAcPljX0WSimr1vw/aPtWPLAL30hf88AaOmERkCxRyOVtFzwMffY1/p2Gnw670Mellaf6
 iWX79u3CZfivzcm5MCNk4oQ0ceAT6XlxqSeuBQbrhq3jrqgjTSgYc31nWsQwm24brzrvDlA14E
 3fs3Ng2vYctM4BKUgHgMFodbcPriTW24blzE6Ybtojfpzfp7nX/CtbkTkAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=5892;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=iWUmQMzQgSgZpUbH/Dn8Cpy1tBmdPWWI8LZy4qMH4hA=;
 b=sGUIsv0ntsKeer3UjeXBfu+YdFXnwGdyl3P9/vhbwiYmUZAqaBECH5VM0zTI1Yk3N9RDXxkA3
 TcGa3xIai7kBk4+2TxvfvgyKPFP/rjl2b6dmHH2ju6nAeRARu8zcr8j
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x332.google.com
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


