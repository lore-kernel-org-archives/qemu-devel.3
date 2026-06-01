Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F94ACD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU01J-0004ia-K0; Mon, 01 Jun 2026 06:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5a8da7e979f1f56b1cab82c2354833f309f1a78f@kylie.crudebyte.com>)
 id 1wU01B-0004ew-P7; Mon, 01 Jun 2026 06:37:13 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5a8da7e979f1f56b1cab82c2354833f309f1a78f@kylie.crudebyte.com>)
 id 1wU01A-00079R-7j; Mon, 01 Jun 2026 06:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=C0QomKF6q+zu/2qQM9XiHIve5LZkqpefIiSy+I2Ac40=; b=OUBaS
 hVE7OeC6H3kdRBVWmU75zbQDfZl2i2vMqnveI1rJBnFcXqB5kRnRpmRgKZRmXfCmKFOe0LghGqK+Y
 sffQlRWjBF37sHyrRHwN/gsFGLqnNeJv24p5VPb5Wi/C57rvd1yLlGl9UcK851NkLUgcJc0CCetpk
 p1CdwuauVVFf2GEqppMoGk1t0T/skxuG7WVShpUKyiPPzA6a6s6gx2v+7dHc31Cl4BxnrkYSVyIIv
 jyM3tRkE/4ymMaisGuMKhtK9f+VrSkrvxiSc7CyH20C9PSdK68De0Rt5YTnycqaxRRXd0A4zMyRBd
 Ll+jeA5ot8zyrbNbc8bPTnCashwsrzvI0WBAXjo6RtnK0dl5uQLH8USlsVtr2K5qs1mkaltw11eB0
 GTAI1S2C3bNzYOmZ6iQD7JODPSw5chRhdUEBstDbAcpuKeVt92ahw2WNL9hjSVPUICZpLX00dsd5k
 3YI4MSCnjFF4Dp8feqNL1mJU/KxJN1xXPYCRtaeWPAaV6gWO+OhsHIWtJ4q6/0wvZXmp6rlH4F0U2
 /O4+5KUsDHlN1wnJxLrokKmirj8BKI+QaX/3m9YG91P2OR1PwdGxNqwf4EM7py+pmkESNCbKQ/l0x
 /ppmnjYel+jzP3vQqiBoMBq8DtgfzxntYLyjBFxJPdgDzKG/23ZQ2r/xgrvyKc=;
Message-ID: <cover.1780307575.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 01 Jun 2026 11:52:56 +0200
Subject: [PULL 0/7] 9p queue 2026-06-01
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, sin99xx <sin99xx@proton.me>,
 Fabiano Rosas <farosas@suse.de>, Wang Jihe <wangjihe.mail@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=5a8da7e979f1f56b1cab82c2354833f309f1a78f@kylie.crudebyte.com;
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

The following changes since commit 81cc5f39aa3042e9c0b2ea772b42a2c8b1488e76:

  Merge tag 'pull-target-arm-20260529' of https://gitlab.com/pm215/qemu into staging (2026-05-29 12:58:25 -0400)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260601

for you to fetch changes up to 5a8da7e979f1f56b1cab82c2354833f309f1a78f:

  9pfs: fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004) (2026-06-01 11:11:39 +0200)

----------------------------------------------------------------
9pfs changes:

- fix V9fsPath heap buffer overflow (gitlab #3358)

- fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004)

----------------------------------------------------------------
Christian Schoenebeck (6):
      hw/9pfs: add NULL check in v9fs_path_is_ancestor()
      hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return type
      hw/9pfs: add error handling to v9fs_fix_path()
      hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle errors
      tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool reset
      tests/9pfs: add deep absolute path test

sin99xx (1):
      9pfs: fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004)

 fsdev/file-op-9p.h           |  2 +-
 hw/9pfs/9p-local.c           | 23 ++++++++++-----
 hw/9pfs/9p.c                 | 41 +++++++++++++++++++-------
 hw/9pfs/9p.h                 |  4 +--
 hw/9pfs/codir.c              |  3 ++
 tests/qtest/libqos/virtio.c  | 23 +++++++++++++++
 tests/qtest/libqos/virtio.h  |  2 ++
 tests/qtest/virtio-9p-test.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 147 insertions(+), 20 deletions(-)

