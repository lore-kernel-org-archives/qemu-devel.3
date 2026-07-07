Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF820C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz9J-0003l6-G7; Tue, 07 Jul 2026 02:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz9D-0003fm-HB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:13 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz99-0001H4-Pq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:10 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 0391B240101
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 08:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783405144;
 bh=EHk8tMq2J/rw8DrKY2dDaonYa74j33mIes5jCdhUaDo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=nWpBJosct5BzkbOwJzyVNkxpblhl0cyr8MgdTia1kp30p9UL8v0yzr+yGX+fQL8xC
 O6Di/y08C1eF6lgbDa2bGHmfWEY6IbiefagTa5RhxrOy56wWBSB6IAEt2dqj3aVFpJ
 mJwqEoWclb4JIiJRyDjbdDuYVqBPNSAxuqPHz3+w/gqDWZEKB1/+vYt9VgHUPeweln
 HzopteVyzdVZ19pvcDZbMXloXqaWB+w+MbBqSTMCJHqQbDqqo4jNrnCc4rvDmP0aYO
 xegPotgyXw2+az7g/Ekc/UYMm9+Bj6Bawgwx9Ifto1cetXM7GuemqpljSGHnm2FShp
 YEqUfaAR2d+ZA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gvWJl2fstz9rxD;
 Tue,  7 Jul 2026 08:19:03 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PULL 0/3] Functional testing patches
Date: Tue, 07 Jul 2026 06:19:03 +0000
Message-ID: <20260707061851.8298-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi Stefan!

The following changes since commit 7f2007d1924565c7a38b2c6ba01ebc1a85db0a49:

  Merge tag 'pull-qobject-2026-07-02' of https://repo.or.cz/qemu/armbru into staging (2026-07-03 07:42:51 +0200)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2026-07-07

for you to fetch changes up to 0e7aa78b0bee50b076785d4cf4a1b7546b3bed31:

  tests/functional: use QMP to query available machines (2026-07-05 21:29:32 +0200)

----------------------------------------------------------------
* Add test for hotplugging a virtio-scsi disk
* Improve boot completion detection in aspeed tests
* Use QMP to query available machines in functional tests

----------------------------------------------------------------
Cédric Le Goater (1):
      tests/functional/aspeed: unify boot completion detection on 'login:' prompt

Ganesh Harshan (1):
      tests/functional: use QMP to query available machines

Siddhi Katage (1):
      tests/functional: Add hotplug_scsi test to hotplug virtio-scsi disk

 MAINTAINERS                                      |  1 +
 tests/functional/arm/test_aspeed_anacapa.py      |  6 +-
 tests/functional/arm/test_aspeed_bletchley.py    |  6 +-
 tests/functional/arm/test_aspeed_catalina.py     |  6 +-
 tests/functional/arm/test_aspeed_gb200nvl_bmc.py |  3 +-
 tests/functional/aspeed.py                       | 21 ++----
 tests/functional/qemu_test/testcase.py           | 31 +++++++--
 tests/functional/x86_64/meson.build              |  1 +
 tests/functional/x86_64/test_hotplug_scsi.py     | 86 ++++++++++++++++++++++++
 9 files changed, 127 insertions(+), 34 deletions(-)
 create mode 100755 tests/functional/x86_64/test_hotplug_scsi.py

