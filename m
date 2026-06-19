Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469DECD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 18:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wadXj-0000Zt-OW; Fri, 19 Jun 2026 14:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadXh-0000Zi-Mc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:14 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadXg-00043v-3g
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=zR0/Pr6K9hRY8EgWjK7cQ5mccChJkum7ALRzOfw/1DE=; b=EJrQodWr3i8W
 f30F0YC+dRg9Geo6N0xiXPSTE4LEXnSbiluEEdmWquN7udHmjONhEo68Q1U2mwJSVg2LVMMcAopm2
 BALX93PHaKsO+6/weWzD8bEDvsX0Z+fzaf2UFz2GhZJjRh+JcjONUWq/ublKLMu/0/Tsc4bA1nd5f
 parVhpIMw5r/kq3c5I0E2MpTiRrW25HsSrty4BadSSnIBbQIeE+Mil4z3Ik00P9IuCtDghdYOogyQ
 BimJpdtyjJU6PF0eW5XcAStuX5hzIwMfwI2SVTRbbLqdiiu7VtVS/CzHYlBWiZFrf/vW/e9OgpPdm
 oQ26AnFNt/5OgHn+0mMHoA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=mami)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <polina.vishneva@virtuozzo.com>) id 1wadWz-001Gyc-16;
 Fri, 19 Jun 2026 20:02:01 +0200
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: Polina Vishneva <polina.vishneva@virtuozzo.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Denis V . Lunev" <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 0/4] qga: Add vsock-listen support on Windows
Date: Fri, 19 Jun 2026 20:00:18 +0200
Message-ID: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=polina.vishneva@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This patch series add AF_VSOCK channel support to QGA on Windows.

For that purpose, all common channel logic that can be reused was
extracted from channel-posix.c into channel-common.[ch].

Also, a header from kvm-guest-drivers-windows was vendored (and trimmed
and adjusted to pass checkpatch).

Most importantly, for vsock-listen to actually work on Windows, the
viosock driver from a very recent kvm-guest-drivers-windows build (not
released yet) is required: the 687c776 commit can be used as a support
marker.

Polina Vishneva (4):
  include/system: Add vio_sockets.h with AF_VSOCK support on Windows
  util/qemu-sockets: Enable AF_VSOCK on Windows
  qga: Move common channel routines to channel-common
  qga: Add AF_VSOCK channel support on Windows

 MAINTAINERS                  |   1 +
 docs/interop/qemu-ga.rst     |   4 +
 include/system/vio_sockets.h |  57 ++++++++
 meson.build                  |  15 +-
 qga/channel-common.c         | 115 +++++++++++++++
 qga/channel-common.h         |  44 ++++++
 qga/channel-posix.c          | 179 +++++++-----------------
 qga/channel-win32.c          | 263 ++++++++++++++++++++++++++++-------
 qga/main.c                   |   6 +
 qga/meson.build              |   3 +-
 util/qemu-sockets.c          |   4 +
 11 files changed, 514 insertions(+), 177 deletions(-)
 create mode 100644 include/system/vio_sockets.h
 create mode 100644 qga/channel-common.c
 create mode 100644 qga/channel-common.h

-- 
2.54.0


