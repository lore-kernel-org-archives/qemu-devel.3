Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA33D44C5A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOcg-0005Dt-TH; Thu, 15 Jan 2026 09:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOc9-0004eI-OA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:43 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOc5-0002fW-Sg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bca6:0:640:3d05:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0E27FC01FD;
 Thu, 15 Jan 2026 17:46:10 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b8d::1:8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8kWwj30BHuQ0-E1qsfwKF; Thu, 15 Jan 2026 17:46:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768488369;
 bh=frG0DkhIGmgTjBsjZ/wl/WoNJr3q0+Tv4QQd6Zg7CAE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Yv2MPJNSksMTY1CcLrMfniFqf95q4SXKxWhdSOpVl9UzYdhLtau+2CYoYJ7peoVud
 U+uUJ16DPXlM3HOh1HdDVHWHDpihV/Bf7p9nERZ1rQoP38qdfxYqK6l7QqMtu6F3Y4
 BiGr7LmKU440xBv7LZmWBdNd504gbtAvS5FBu1GU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v3 00/10] chardev: cleanup
Date: Thu, 15 Jan 2026 17:45:54 +0300
Message-ID: <20260115144606.233252-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Here is a cleanup for chardev code:

 - preparation patches to drop spice version checks
 - improve naming
 - add boolean return for some errp-functions
 - simplify open() API

v3:
01-08,10: add r-b by Marc-André
06: fix gd_vc_chr_open return type, and wrong rename,
09: rework

Vladimir Sementsov-Ogievskiy (10):
  ui/spice: Require spice-server >= 0.15.0
  ui/spice: drop SPICE_HAS_ATTACHED_WORKER macro
  chardev: ChardevClass: consistent naming for handlers
  chardev: consistent naming for ChardevClass handlers implementations
  chardev: .chr_open(): drop be_opened parameter
  chardev: .chr_open(): add boolean return value
  chardev/char-pty: store pty_name into PtyChardev state
  chardev: introduce .chr_get_pty_name() handler
  chardev: rework filename handling
  chardev/char: qemu_char_open(): add return value

 chardev/baum.c                                | 12 +--
 chardev/char-console.c                        | 10 +--
 chardev/char-fe.c                             |  8 +-
 chardev/char-file.c                           | 26 +++----
 chardev/char-hub.c                            | 27 ++++---
 chardev/char-mux.c                            | 30 ++++----
 chardev/char-null.c                           |  9 +--
 chardev/char-parallel.c                       | 41 +++++------
 chardev/char-pipe.c                           | 30 ++++----
 chardev/char-pty.c                            | 56 ++++++++------
 chardev/char-ringbuf.c                        | 20 ++---
 chardev/char-serial.c                         | 39 +++++-----
 chardev/char-socket.c                         | 73 ++++++++-----------
 chardev/char-stdio.c                          | 30 ++++----
 chardev/char-udp.c                            | 16 ++--
 chardev/char-win-stdio.c                      | 25 ++++---
 chardev/char.c                                | 65 ++++++++++-------
 chardev/msmouse.c                             | 13 ++--
 chardev/spice.c                               | 52 ++++++-------
 chardev/wctablet.c                            | 10 +--
 gdbstub/system.c                              | 12 +--
 hw/char/xen_console.c                         |  7 +-
 hw/display/qxl.c                              | 23 +-----
 hw/misc/ivshmem-pci.c                         |  4 +-
 include/chardev/char.h                        | 21 ++++--
 include/ui/qemu-spice.h                       |  6 --
 meson.build                                   |  2 +-
 .../codeconverter/test_regexps.py             |  2 +-
 ui/console-vc.c                               | 12 ++-
 ui/dbus-chardev.c                             | 16 ++--
 ui/dbus.c                                     |  4 +-
 ui/gtk.c                                      | 14 ++--
 ui/spice-app.c                                | 18 ++---
 ui/spice-display.c                            | 19 +----
 ui/vdagent.c                                  | 17 ++---
 35 files changed, 362 insertions(+), 407 deletions(-)

-- 
2.52.0


