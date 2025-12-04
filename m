Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1894D216A4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRBUC-0006aX-Mp; Thu, 04 Dec 2025 10:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTh-0006Q0-WB
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:49 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTf-0007Dt-SJ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:45 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3E43780771;
 Thu, 04 Dec 2025 18:42:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id agnhnW0F9Gk0-zygbYD7v; Thu, 04 Dec 2025 18:42:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764862957;
 bh=bbGTEngzxKOj507oLGhOiw2Y1gTzAHV3Z98v6RaCjsU=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=kSWeyNsNCiGGjdWdBnw46XsVNek3bnjQzxFNVuOyvbHXYKq6Yaaw6x4S1YeUGhy5G
 yIKa+dzyvf1sgwZQmA6QZIRM/qqG3rGzIX34V56cseV2yq6z6s6ksYR5g6f4i4xU8v
 6YaQmdKMm/WI18VLCPQp/m+mHtTGbWMLW/il5BWU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 00/10] chardev: cleanup
Date: Thu,  4 Dec 2025 18:42:24 +0300
Message-ID: <20251204154235.149575-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

 - preparation patches to drop spice version checks
 - improve naming
 - add boolean return for some errp-functions
 - simplify open() API

v2:
01-02: new
04: add r-b by Philippe
05: rebase on 01, fix typo in commit msg
06: rebase on 01, add r-b by Philippe
10: tiny refactor of qemu_char_open and r-b by Philippe

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
 chardev/spice.c                               | 52 +++++++---------
 chardev/wctablet.c                            | 10 ++--
 gdbstub/system.c                              | 12 ++--
 hw/char/xen_console.c                         |  7 ++-
 hw/display/qxl.c                              | 23 +-------
 hw/misc/ivshmem-pci.c                         |  4 +-
 include/chardev/char.h                        | 37 +++++++++---
 include/ui/qemu-spice.h                       |  6 --
 meson.build                                   |  2 +-
 .../codeconverter/test_regexps.py             |  2 +-
 ui/console-vc.c                               | 12 ++--
 ui/dbus-chardev.c                             | 16 +++--
 ui/dbus.c                                     |  4 +-
 ui/gtk.c                                      | 14 ++---
 ui/spice-app.c                                | 18 +++---
 ui/spice-display.c                            | 19 +-----
 ui/vdagent.c                                  | 17 +++---
 35 files changed, 356 insertions(+), 397 deletions(-)

-- 
2.48.1


