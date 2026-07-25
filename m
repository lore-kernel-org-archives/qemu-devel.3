Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF9EC531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnaMH-0007WW-3J; Sat, 25 Jul 2026 07:15:57 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1de8aea061b9d5bc7aaed182e2eebe9554debd68@kylie.crudebyte.com>)
 id 1wnaLq-0007Ti-BB; Sat, 25 Jul 2026 07:15:30 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1de8aea061b9d5bc7aaed182e2eebe9554debd68@kylie.crudebyte.com>)
 id 1wnaLo-0006Pv-Qa; Sat, 25 Jul 2026 07:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Message-ID:References:In-Reply-To:Content-ID:
 Content-Description; bh=MOLPgPjIWHDT04FWcBJ5JBy2d2RH8x/WCrU8sQaCPj4=; b=i+3GD
 hEdWVvIj3BaCfM/b5jTAzFIHI2qVkwcjKdCwkMTtpEY0A1aYapNjms7NeergieaDzo7p5MYUwlQsf
 B/UBuWUVv+3IvV9rok3MCpFRB/xuNI7BMlD8T6i2djH1cIm/m1Q1Ty/ozdpmqirvkWUTSFlRqaPHE
 //6DYvQsmsvQXWfshse9UbAxMFNtO67KQpG/VHixT3a4XYf1eQEZ/ngWqfOKjNNuUUTMVJybZvA6U
 j++itVVVGYc63ucqRzE6njg/ZLzOsMMcb08IQx08zeXkIkmqWSVRaH3GdjKcOPdjWfmR3fbcSl+n/
 0y3iR2k8Ecrj3J6TWvDsOwQlvQfOVLCtLPiTvB5W1v5Ju0/44NnFXgJSIOrsn8WtH2UvsbqKPHcXh
 7kZMS0YzSAvLFKOze6VCdmMGDKNLh3MCau/mqzK3S07vQ6Ah0hQQLK8BOiCPGrHtfMQwMp8H+5psp
 0JyqjizikuxqmYPgZkx0oCb1Lxcc4VgGWbwopMFHNGLtWEa4ujbuLsbl6He9CHftlegwc1tGL4hhL
 upCDg6RZJCkNSZOdQqyVM+/OqH6OxO5pITXoXJQIqSbns6rLJaHYgoY3R6PLdOhT2a+68ozHZJ2WE
 eTWKW9YShDE1X/cTsCcSO8V7/lrKh33/+E1gT3BcVzxNawn56UeP1XlpqADUs4=;
Message-ID: <cover.1784977523.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 25 Jul 2026 13:05:24 +0200
Subject: [PULL 0/5] 9p queue 2026-07-25
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>,
    Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>,
    Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
    Daniel P. Berrangé <berrange@redhat.com>,
    Jia Jia <physicalmtea@gmail.com>,
    Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=1de8aea061b9d5bc7aaed182e2eebe9554debd68@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The following changes since commit 300438ffbb8d9430cac2fcc15cba6f482b2c0587:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-07-24 09:13:49 -0400)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260725

for you to fetch changes up to 1de8aea061b9d5bc7aaed182e2eebe9554debd68:

  hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect (2026-07-25 12:35:25 +0200)

----------------------------------------------------------------
9pfs changes:

- Fix O_TRUNC bypass on read-only export (CVE-2026-63318).

- Fix guest-triggered Treaddir/ACPI eject UAF (#3937).

- Tests: fix "slow" type test errors on certain host systems.

- Tests: fix CID 1660926.

----------------------------------------------------------------
Christian Schoenebeck (4):
      tests/9p: prevent potential error in do_local_xattr_limit()
      tests/9p: reduce xattr size to 1k
      hw/9pfs: fix O_TRUNC bypass on read-only export
      hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect

Jia Jia (1):
      hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize

 hw/9pfs/9p.c                 |  5 +++--
 hw/9pfs/virtio-9p-device.c   |  1 +
 hw/9pfs/xen-9p-backend.c     | 17 +++++++++++++++--
 tests/qtest/virtio-9p-test.c | 16 +++++++++++-----
 4 files changed, 30 insertions(+), 9 deletions(-)

