Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4003CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcTa-0001FC-Mt; Tue, 13 Oct 2026 09:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTZ-0001Eq-70
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTX-0004dM-2N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t52HBx95G2L5wBjiY3vYLfeJx9EuuXZ8FiKV8S2kEZE=;
 b=OsGM8lB/9AJnAjVsGOphO2OlBMQBU5fnXVA4s/O6pbhveIp1ORRPh9LKK0C8s2dFS3lJxN
 77rt8+jGNP/pATtv7xp2zBK+q6UY2gZGRZt3aU4ZcTv3svCuapPwxbg4nB1y0m1nm7N8TB
 BUD3sy8+vYofnPLjxnCPKW/Ap0cgCcM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-1xV2-JF_NUGf6vCLtqa8Ww-1; Tue,
 13 Oct 2026 13:23:22 +0000
X-MC-Unique: 1xV2-JF_NUGf6vCLtqa8Ww-1
X-Mimecast-MFC-AGG-ID: 1xV2-JF_NUGf6vCLtqa8Ww_1791897800
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A94C1828B25; Tue, 13 Oct 2026 13:23:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA19D427; Tue, 13 Oct 2026 13:23:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/40] UI, Audio & Chardev fixes + Terminal Resize Support
Message-Id: <20261013-ui-v1-0-92da3082ad96@redhat.com>
Date: Tue, 13 Oct 2026 17:22:57 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=6170;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=I0kRo1fXyj5MHfKD8uuVSvlnX4IZYIvF+dRwhdkMTUo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDB6JjBQI3YmFGTmV+Eho6/lH2/8fah2HPwM
 s8gQZX126KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwQAKCRDa6OEJdZac
 5ehLD/4jvhC3u3usGZc5vO6EwWNHzNVnqczfWENluRE82CaTY5t1+hXZuFZI48P2ACfNOBh5g3H
 mplZ3HCz9RnMKD914Yt2BUDoYDi3c3pFRkgMecOaAxHDBYzqJefoG1FWvrOIdwIDe1IlXNs6DN4
 n9chAL1O6kkfOfEpnUZ6Kqp9JIYp3YNbXuCr86ub4d9hrqTvCTSB8hFH31MhvImkI6ZPvXGt2Wo
 4Xoil/FfM2w63sPOtaFkt+7yyS2JRCqgpjOhdXuKGTA7SU0VI00fDGm1s2oFAsKxRecS4QNjjOz
 99D+wgriAHNDZXpKnF6mqjENnU6p1KUOESuglVev+xdsGJY+GPWEu/TGazkPZKU6pKpW58Ul/a+
 t2/VMzCy1uqVgp/YLawQUPdurX85DTr5282wdiK2cVr7nEgLTJCSc5CvXwxvXxpZBH1Swe2E+zX
 rqXbqrkuOXQ3O/I97c+NQMIFwohdjr94td/8Uq1LwEID1fPCGzq9i8TeDdIWiWxFxaHSzSKAr1b
 GHvSQpwu4PzQ6BnXxG9yOsg/z1HLUViIcu6ay+BuwQPDAgr2AUo7c7aRKgjJvIpSbyGcmKLhDr+
 AVjyS2CBXq7tvMqfNbSn6HcV6cL9V4hakIuO00XXe8NhCS1+uTH+zAHDowfcRN3qmPSbNzDtL3B
 iKAXdAUI72LaCGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pr-v1

for you to fetch changes up to 919711cab29776f12209b375a4db251007c6d96e:

  chardev/char: fix use-after-free on mux creation failure (2026-10-13 17:22:49 +0400)

----------------------------------------------------------------
UI, Audio & Chardev fixes + Terminal Resize Support

Adds end-to-end support for propagating terminal size changes from the
host to the guest. This includes a new CHR_EVENT_RESIZE chardev event,
qemu_chr_resize() API, a chardev-window-size-changed QMP command,
SIGWINCH handling, and wiring through mux/stdio/win-stdio chardevs,
virtio-serial, virtio-console, GTK, and text console backends.

- collect ui, audio, chardev and display fixes

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      hw/display/virtio-gpu: Block migration with large blobs

Filip Hejsek (4):
      char-win-stdio: add support for terminal size
      ui/console-vc: forward text console size to vc chardev
      ui/gtk: forward gtk console size to vc chardev
      virtio-serial-bus: add terminal resize messages

Gurchetan Singh (1):
      virtio-gpu-rutabaga: make sure ctx_ids match

Marc-André Lureau (25):
      ui/spice-app: honor gl=off option, reject core/es
      hw/display/vga: fix OOB writes after external surface resize
      audio/ossaudio: fix ioctl passing address-of-pointer instead of pointer
      audio/dbusaudio: fix off-by-one in volume channel assertion
      audio/ossaudio: fix off-by-one in mmap buffer size assertion
      audio/paaudio: fix server string in PAConnection
      audio/paaudio: avoid pidfile path truncation
      audio/pwaudio: fix capture buffer leak on early return paths
      audio/pwaudio: clamp overrun writes to remaining ring buffer space
      audio/pwaudio: fix integer underflow in qpw_read()
      audio/pwaudio: handle negative avail in qpw_write and qpw_buffer_get_free
      audio/pwaudio: bail out on underrun in qpw_write
      audio/audio-mixeng-be: add upper bounds to audio settings validation
      audio/wavcapture: prevent freq overflow and corrupted WAV header
      ui/clipboard: clean up vm change state handler on last peer unregister
      ui/console: skip empty update regions in qemu_console_update
      ui/console: use QLIST_FOREACH_SAFE in dpy_refresh
      ui/input: fix integer overflow in qemu_input_scale_axis
      ui/vnc-enc-zrle: propagate zrle_compress_data error
      ui/vnc-jobs: assert rect coordinates and dimensions in vnc_job_add_rect
      chardev/char-pty: free pty_name in finalize
      chardev/char-ringbuf: reject zero size with is_power_of_2
      chardev/char-ringbuf: use actual read length in qmp_ringbuf_read
      chardev/char-udp: clarify read_poll return value with pending data
      chardev/char: fix use-after-free on mux creation failure

Szymon Lukasz (8):
      chardev: add cols, rows fields
      chardev: add CHR_EVENT_RESIZE
      chardev: add qemu_chr_resize()
      char-mux: add support for the terminal size
      main-loop: change the handling of SIGWINCH
      char-stdio: add support for the terminal size
      qmp: add chardev-window-size-changed command
      virtio-console: notify the guest about terminal resizes

Tom Desnoyers (1):
      virtio-gpu: fix memory leaks in virgl and rutabaga

 audio/audio-mixeng-be.c           |  4 +-
 audio/dbusaudio.c                 |  4 +-
 audio/ossaudio.c                  |  4 +-
 audio/paaudio.c                   |  6 ++-
 audio/pwaudio.c                   | 22 ++++++++++-
 audio/wavcapture.c                |  6 +++
 backends/cryptodev-vhost-user.c   |  1 +
 chardev/char-fe.c                 | 13 +++++++
 chardev/char-mux.c                | 19 ++++++++-
 chardev/char-pty.c                |  1 +
 chardev/char-ringbuf.c            | 10 +++--
 chardev/char-stdio.c              | 33 ++++++++++++++++
 chardev/char-udp.c                |  4 ++
 chardev/char-win-stdio.c          | 19 +++++++++
 chardev/char.c                    | 27 +++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 35 +++++++++++++++--
 hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
 hw/display/vga.c                  |  8 ++--
 hw/display/vhost-user-media.c     |  1 +
 hw/display/virtio-gpu-rutabaga.c  |  5 ++-
 hw/display/virtio-gpu-virgl.c     |  6 +--
 hw/display/virtio-gpu.c           | 32 ++++++++++++++++
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
 ui/clipboard.c                    |  4 ++
 ui/console-vc.c                   |  8 ++++
 ui/console.c                      |  7 +++-
 ui/curses.c                       | 21 +++++++---
 ui/gtk.c                          | 28 ++++++++++++++
 ui/input.c                        |  8 +++-
 ui/spice-app.c                    | 10 ++++-
 ui/vnc-enc-zrle.c                 | 19 ++++++---
 ui/vnc-jobs.c                     |  1 +
 util/main-loop.c                  | 33 ++++++++++++++++
 51 files changed, 513 insertions(+), 43 deletions(-)


