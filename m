Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A887DCFD2F6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 13:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLFZ-0005N9-CA; Sat, 29 Nov 2025 08:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFU-0005MN-4V
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:28 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFQ-0002XX-R9
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:27 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0C8AF80880;
 Sat, 29 Nov 2025 16:44:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:891::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Iigm2k0FK8c0-94UWLLJ4; Sat, 29 Nov 2025 16:44:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764423859;
 bh=XjwdxVs2aCLwBknYq2vRjzzcXqaUbJ6EyFF87a5c9NI=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Ly16F/aOQWdaMZ/PsPfq9J4aWutj/7bcaA1LMtaoqrJd3hJlhC4bIkzUHj9jy/55a
 Xj4raoECjIJ79qPvnL3KofgLF3nZYi5Xw4U5KEITflldsm/UbCcDWgHHN7tiV2a/R+
 mvH9Tzj/OTX+UBy3/w2IQvcaWH0pRhWf0zdta+Xg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH for-11.0 0/8] chardev: cleanup
Date: Sat, 29 Nov 2025 16:43:40 +0300
Message-ID: <20251129134350.487839-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all.

Here is a cleanup for chardev code:

 - improve naming
 - add boolean return for some errp-functions
 - simplify open() API

Vladimir Sementsov-Ogievskiy (8):
  chardev: ChardevClass: consistent naming for handlers
  chardev: consistent naming for ChardevClass handlers implementations
  chardev: .chr_open(): drop be_opened parameter
  chardev: .chr_open(): add boolean return value
  chardev/char-pty: store pty_name into PtyChardev state
  chardev: introduce .chr_get_pty_name() handler
  chardev: rework filename handling
  chardev/char: qemu_char_open(): add return value

 chardev/baum.c                                | 12 ++--
 chardev/char-console.c                        | 10 ++--
 chardev/char-fe.c                             |  8 +--
 chardev/char-file.c                           | 26 ++++----
 chardev/char-hub.c                            | 27 ++++-----
 chardev/char-mux.c                            | 30 ++++++----
 chardev/char-null.c                           |  9 +--
 chardev/char-parallel.c                       | 41 ++++++-------
 chardev/char-pipe.c                           | 30 +++++-----
 chardev/char-pty.c                            | 52 ++++++++--------
 chardev/char-ringbuf.c                        | 20 ++++---
 chardev/char-serial.c                         | 39 ++++++------
 chardev/char-socket.c                         | 59 +++++++++----------
 chardev/char-stdio.c                          | 30 +++++-----
 chardev/char-udp.c                            | 16 ++---
 chardev/char-win-stdio.c                      | 25 ++++----
 chardev/char.c                                | 51 ++++++++--------
 chardev/msmouse.c                             | 13 ++--
 chardev/spice.c                               | 50 ++++++++--------
 chardev/wctablet.c                            | 10 ++--
 gdbstub/system.c                              | 12 ++--
 hw/char/xen_console.c                         |  7 ++-
 hw/misc/ivshmem-pci.c                         |  4 +-
 include/chardev/char.h                        | 37 +++++++++---
 .../codeconverter/test_regexps.py             |  2 +-
 ui/console-vc.c                               | 12 ++--
 ui/dbus-chardev.c                             | 16 +++--
 ui/dbus.c                                     |  4 +-
 ui/gtk.c                                      | 14 ++---
 ui/spice-app.c                                | 18 +++---
 ui/vdagent.c                                  | 17 +++---
 31 files changed, 354 insertions(+), 347 deletions(-)

-- 
2.48.1


