Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021B606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H9xEEl+Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUKw-0007tf-4Y; Sun, 01 Nov 2026 07:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKq-0007sl-49
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKm-0003XB-Th
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OG8YM9MS95d2tvjv75n5iMCmLhEghxDHYdbIBqQDaBo=;
 b=H9xEEl+QNwyVF9feOFtP5TwuywWS1h3NJvlZW0xq/q5V+TPn5h8KG0eTnRZL8R1j6pFGe2
 3k6jvqyQKB7221GV0eeB5XZsmb8tM1xiOZ/7WlpUqGvpHh+B4F81uHPYRNTKyxrwsC4R4a
 bOvpXFlzDDHhqM5ZZS4ZfZqVhu2tkME=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-LzBYP_vvOF6TvLY7mHrkXw-1; Sun,
 01 Nov 2026 07:06:43 -0500
X-MC-Unique: LzBYP_vvOF6TvLY7mHrkXw-1
X-Mimecast-MFC-AGG-ID: LzBYP_vvOF6TvLY7mHrkXw_1793534802
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C9171955DC2; Sun,  1 Nov 2026 12:06:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5116D30002C9; Sun,  1 Nov 2026 12:06:40 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 0/9] UI-related improvements & fixes
Message-Id: <20261101-ui-v1-0-8af305cef69a@redhat.com>
Date: Sun, 01 Nov 2026 16:06:33 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2853;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BpQFIjF+XYJzrs+a3f/5d/TKdgkwzggar+aJctCGYyA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOT5XESdxfQUZT43udZBV1/WtLrXvGKEOAh
 rm4oe6dBPSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5TV7EACo+QqEfzCv9nwoIdDnA3pwdbaq3UJ3jDIk72Bh85ts/ZD1p9E7FZiEKqyVLqxhYmngN3M
 C0YUnBTFagRfonUYi3I6YHHVUAURbZEHqrYqt98LMgT9IUNjAV4My+DCpFl0CHbz+d3POm3/8Zg
 Ilss4RMw7gbqlaiRXrOggHlW09Af8Q6tEFdZRTUjF9ahpGmYsbpZ9oVM5c7wbGBeakWc9/6Olib
 OEpzpcsiTXnOJvk0AjL+dYk5upeRpvugLzPXvtxIlbqwQX/fm4kV5e/qM126eAPBBx2d8O1Xcm8
 Hum58dTx0vaoQUkFNc7DV557GefEury8in7WpUkWqRZdECMTwAay2nehsfktWOA4sWdymDt7yWz
 sycRpa4h012UK/GIHAnuTRTiv2zpILr6fKDymJ/lPyis50mnTnjfWzQEsDQjT+UeSYmgYBz9n7e
 8+o2vJRBGP79JyTpyXR9LBxL3p1WdnEYz98sAmxY8jrk7463Nd+msPR8WGf8en/fO2z47KVU7vc
 w0D8T6jWJ1BFv6tN2++cs61cm5bmJLPPrssAyIohz5kx0FHZBxVwFIz4CF3iAlOfpQM0QWhk8On
 GneKNMOgMekBJwh1rvYz7RtHFZsg4EW0d/JZXiAhLy3R+RM2P4uhvb0TXXQ+DfyTGJhkoOPeOhu
 xQiDLxcoOxqNilg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-25.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 33eb51c859834f2024090bf843c69814267b6c26:

  Merge tag 'pull-vfio-20261031' of https://github.com/legoater/qemu into staging (2026-10-31 16:52:00 -0700)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pr-v1

for you to fetch changes up to cfe14e550370100ebf27cfeea65f6b1b1e11004f:

  io: report a warning when a file channel is created from a stdio fd (2026-11-01 16:06:27 +0400)

----------------------------------------------------------------
UI-related improvements & fixes

- clipboard: add QEMU_CLIPBOARD_PEER_UPDATE notifications and guest-peer tracking,
  and factor VNC peer registration out of extended clipboard support.
- VNC clipboard: implement ClipboardAvailability so clients are told when a guest
  clipboard peer appears or disappears.
- VNC: stop losing updates (stale pixels, stuck client) when a queued job is
  dropped by a display surface switch.
- D-Bus: send a whole-surface Scanout before the first Update of a new surface,
  with a qtest for the VGA text-mode resize.
- stdio/io: duplicate stdio fds in char-stdio and warn when they are passed to
  qio_channel_file_new_fd().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Christian Quante (2):
      ui/dbus: send a Scanout before the first Update of a new surface
      tests/qtest/dbus-display-test: check the Scanout after a text resize

Dax Kelson (1):
      ui/vnc: recover a job dropped by vnc_abort_display_jobs()

Filip Hejsek (2):
      char-stdio: avoid closing stdio fds
      io: report a warning when a file channel is created from a stdio fd

Lukasz Kornicki (4):
      ui/clipboard: add clipboard peer update notification
      ui/clipboard: keep track of clipboard peer side
      ui/vnc-clipboard: factor out clipboard peer registration
      ui/vnc: notify client of clipboard availability

 chardev/char-stdio.c            |  16 +++-
 include/io/channel-file.h       |  12 ++-
 include/ui/clipboard.h          |  28 +++++++
 io/channel-file.c               |   6 ++
 tests/qtest/dbus-display-test.c | 162 ++++++++++++++++++++++++++++++++++++----
 tools/qemu-vnc/clipboard.c      |   3 +
 tools/qemu-vnc/qemu-vnc.c       |   7 +-
 ui/clipboard.c                  |  35 +++++++++
 ui/cocoa.m                      |   3 +
 ui/dbus-clipboard.c             |   3 +
 ui/dbus-listener.c              |  10 ++-
 ui/gtk-clipboard.c              |   3 +
 ui/trace-events                 |   2 +
 ui/vdagent.c                    |   4 +
 ui/vnc-clipboard.c              |  52 +++++++++++--
 ui/vnc.c                        |  30 +++++++-
 ui/vnc.h                        |   9 +++
 17 files changed, 354 insertions(+), 31 deletions(-)


