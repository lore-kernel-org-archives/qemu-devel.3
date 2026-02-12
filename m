Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC4EB48EF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 09:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSh0-0002WU-3F; Thu, 12 Feb 2026 04:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqSgy-0002Vr-D2; Thu, 12 Feb 2026 04:08:56 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqSgv-00043u-0i; Thu, 12 Feb 2026 04:08:56 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BDF16C0007;
 Thu, 12 Feb 2026 12:08:46 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:450::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id j8QYBp0Al4Y0-l4ZNtWX0; Thu, 12 Feb 2026 12:08:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770887326;
 bh=5iAQz/zusFCqc/p05y149scykRcAG9jVAthIDpZK7Fo=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=z+gIPH+70Gej1ydEWT/YN8NK5y+8BzBPPc7baVq0j82Ww4bav2AWubjPtn1DJcLSJ
 pdgZaTI18qX301pYwHSQjgj89eNfzbSpWfUo+Omo7bYx2MN1ibVzwvi4cBtJ2vyH7T
 MqgEw4AM88yyUjJmcQyW+BrDZeVgSfqe99WMwkv8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, vsementsov@yandex-team.ru
Subject: [PULL 0/2] Block jobs patches
Date: Thu, 12 Feb 2026 12:07:59 +0300
Message-ID: <20260212090801.999731-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 44dba5a0c86fff68fdd013c29bba81d5a1e32825:

  Merge tag 'pull-tpm-2026-02-10-1' of https://github.com/stefanberger/qemu-tpm into staging (2026-02-11 15:12:50 +0000)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2026-02-12

for you to fetch changes up to 267d7ae99a1d3b5be9d3421db3bdf651cc18c7ab:

  iotests: test active mirror with unaligned, small write zeroes op (2026-02-12 11:38:18 +0300)

----------------------------------------------------------------
block: mirror: fix zero bitmap handling

----------------------------------------------------------------
Fiona Ebner (2):
      block/mirror: check range when setting zero bitmap for sync write
      iotests: test active mirror with unaligned, small write zeroes op

 block/mirror.c             |  9 ++++++---
 tests/qemu-iotests/151     | 20 ++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 ++--
 3 files changed, 28 insertions(+), 5 deletions(-)

Fiona Ebner (2):
  block/mirror: check range when setting zero bitmap for sync write
  iotests: test active mirror with unaligned, small write zeroes op

 block/mirror.c             |  9 ++++++---
 tests/qemu-iotests/151     | 20 ++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 ++--
 3 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.52.0


