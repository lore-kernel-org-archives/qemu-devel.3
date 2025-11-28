Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9590D116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 20:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP4j5-0002Vu-JT; Fri, 28 Nov 2025 15:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vP4j1-0002UD-HC
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 15:05:51 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vP4ix-0000Rq-D4
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 15:05:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 42EB08085D;
 Fri, 28 Nov 2025 23:05:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:894::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id b5mcgZ0FDuQ0-kFAEEFog; Fri, 28 Nov 2025 23:05:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764360337;
 bh=ceRsPdVX6xl+zYMQWr6EMw2fQYTma0PAAkNb3eZ/pTQ=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=G7FV+ITs6akFHQGhI0DoKYl4PAXDjdmO/Q+XmnVLPx5VH2U9EwfE17pHEXZwcVRJi
 z4qxm1vR+L/X+UPkvOp15BmKWJzHqTRRUv54Cg228g8XYMmxnT0i52ixPtiEqWf1Ac
 oFUK+MDzCL+flftGTCgK3Kyw2ynRU4OiG7RIeMPQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org
Subject: [PATCH 0/3] char: add option to inject timestamps into logfile
Date: Fri, 28 Nov 2025 23:05:32 +0300
Message-ID: <20251128200536.207344-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

The ability to correlate the QEMU log and the guest log can be useful
for investigating problems. So, I suggest an option to inject timestimps
into logfile while writing it.

[sorry for resending, I forget to add qemu-devel on first try :(]

Vladimir Sementsov-Ogievskiy (3):
  char: qemu_chr_write_log() use qemu_write_full()
  error-report: move real_time_iso8601() to header
  chardev: add logtimestamp option

 chardev/char.c              | 73 +++++++++++++++++++++++++++++--------
 include/chardev/char.h      |  2 +
 include/qemu/error-report.h |  6 +++
 qapi/char.json              |  6 ++-
 util/error-report.c         |  7 ----
 5 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.48.1


