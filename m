Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114E60722A6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNu03-0006Ju-PY; Mon, 02 Nov 2026 10:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xNtzt-0006IH-Vt
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:30:58 -0500
Received: from forwardcorp2d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df02])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xNtzs-0005Lq-2L
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:30:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-56
 (mail-nwsmtp-smtp-corp-main-56.yp-c.yandex.net)
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id DB61E80EAC;
 Mon, 02 Nov 2026 18:30:45 +0300 (MSK)
Received: from i115954770.yandex-team.ru
 by mail-nwsmtp-smtp-corp-main-56 with ESMTPSA id iUpabg2Zpa60-OXxN6BfO;
 Mon, 02 Nov 2026 18:30:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1793633445;
 bh=cfQN70RfLl3iVhuj9jdNq2iXGr1RaJKO4IzuKXs/x4M=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=of1Q6bs6+YZC3Tx8z1IjH6j1pyDA+Sm+OVHEG/2FkvCnH3eK/1dgnwgc0KEDvOo7K
 mAxj1CbLTbBiIRp6a18UYmtDFZH5obR/SKlm11o+AhWJfDDRLFU0RaQ/MMMnNScwyv
 zukrc2h87OmYmDsDKFnioN/MhJZ48dYTpoVq+rQI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: peterx@redhat.com, vsementsov@yandex-team.ro, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 0/2] tests/functional: add test_tap_migration
Date: Mon,  2 Nov 2026 18:30:40 +0300
Message-ID: <20261102153043.3795201-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df02;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2:
all fixes are already merged, the test was not because CI failure.
The problem was not in test itself, but in skipWithoutSudo decorator.
Fix skipWithoutSudo in 01, 02 is unchanged test (only add a-b by Peter)

Vladimir Sementsov-Ogievskiy (2):
  tests/functional: skipWithoutSudo: handle missing sudo binary
  tests/functional: add test_tap_migration

 tests/functional/qemu_test/decorators.py      |  15 +-
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 425 ++++++++++++++++++
 3 files changed, 435 insertions(+), 6 deletions(-)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

-- 
2.43.0


