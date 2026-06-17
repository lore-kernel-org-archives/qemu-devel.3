Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FA8CD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsQY-0003lw-84; Wed, 17 Jun 2026 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <116db2986b11c914217bbd1547815b6c7efb944a@kylie.crudebyte.com>)
 id 1wZsQR-0003kJ-VB; Wed, 17 Jun 2026 11:43:37 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <116db2986b11c914217bbd1547815b6c7efb944a@kylie.crudebyte.com>)
 id 1wZsQQ-0002Hf-Jc; Wed, 17 Jun 2026 11:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=CXS5yCMwWBCyy1JNKSW52yBllW7HYQqT5Q+KHEUtY80=; b=urD5w
 TvmG9jxEWFsZ6YnHcs12C7FdnvV5GVuTmkZ0KS72ihlCIqhndhDrODUHvzt/8kf52fyOdCEP3hrid
 MyC9Dt5fWCyIQyNjHOPZWY6YQQjqf8KpNISq9aq3dhezrqmqof5u6lFbhV0TKgkl9NtjFU1jSdoGr
 Gi71qwFXv9pA96xkBme3Fo29B4jiaVmSESy+LkFoT96HBpgcWjJ17JHR7LNfyS5R9gmbq8TDC53Kq
 Pypwwl6v/hbmieFpfrAe5yJJCqCQvLEWKHUec52buXPK37ScOl53vQ3WO5CSjTKPe257ftHO7MLlu
 QgDwQOzXoXBthYB2AFIDUkdYthvg5Q/tBJqFg8AzL3Kd/zNYfPc29bjSQE1jijxeBmQkKWKCf5P2J
 Sapjk1+F2SE18Ji3/AW++x0XJAtL7327boZeudBhyIkEnzTkuUKHHEJfW1X73EpHFIVTXbcu/2eDZ
 wewHGnriiPSTqpCf8R2NaqqZddvpUuynUfJHWucinnoKCHwCZXKuZkLnyR4xp2QFm4kTRHvqUEgLc
 HBBvSGuF43237siknaM+oGNFiyVCaol4wrzsJmbh8r8JnnCfcK26XcRW3+TJt4KFXIDwRlkFdTZAA
 qnhzwTistFjVY1HIirQlycR5Q+CzlpBs5THGSS/2netc9KkY1SBdnX8xklwQhk=;
Message-ID: <cover.1781710785.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 17 Jun 2026 17:39:46 +0200
Subject: [PULL 0/3] 9p queue 2026-06-17
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=116db2986b11c914217bbd1547815b6c7efb944a@kylie.crudebyte.com;
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

The following changes since commit b0df6e2f2c6c45df8d4d286933799c623e124d98:

  Merge tag 'pull-riscv-to-apply-20260616' of https://github.com/alistair23/qemu into staging (2026-06-16 10:41:47 -0400)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260617

for you to fetch changes up to 116db2986b11c914217bbd1547815b6c7efb944a:

  hw/9pfs: consolidate name validation with check_name() (2026-06-17 17:21:55 +0200)

----------------------------------------------------------------
9pfs changes:

- Fix guest-triggerable assertion fault (DoS) with the legacy Twstat
  rename handler.

- Code deduplication.

----------------------------------------------------------------
Christian Schoenebeck (3):
      hw/9pfs: fix abort due to illegal name with Twstat rename
      hw/9pfs: reject . and .. in Twstat rename
      hw/9pfs: consolidate name validation with check_name()

 hw/9pfs/9p.c | 97 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

