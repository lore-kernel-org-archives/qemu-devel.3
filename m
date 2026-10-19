Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A1CCF2E6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoT5-0007BP-BH; Mon, 19 Oct 2026 10:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e727e0c5d7d31640708fe3cebe31cc1312eefadc@kylie.crudebyte.com>)
 id 1xIoT3-0007A0-JI; Mon, 19 Oct 2026 10:36:01 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e727e0c5d7d31640708fe3cebe31cc1312eefadc@kylie.crudebyte.com>)
 id 1xIoT1-0007TR-SQ; Mon, 19 Oct 2026 10:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=Uokg2hTbgTAcnHw6vf8xZdktKy1KxQGxZvOJOxbjeQ8=; b=MZdmN
 3jMlsKPIpUfEVZ1+YGN6AnxQ44jm6JCBVPh7AyiY0XI5E1Y9H/4T/0qWnaZGyIuM2D7Eftk1VWYXt
 MJmUzqxJg4PdZD/umv47IREoe4bGOZJylopQQzUhgdU1SoZAwHvpFDhq/npx4HS9QGXb/IwAmBmGI
 J4gtj6Uf/lO8Rogd5Y7iTsFm8jTmZvt2IGf4Q8crfRVTHd/PB00K/vj5eetAaNMPlWm+0fqbPP2VC
 mwy6ngCkBzCDmX5NLQHEEbeHYkWhBp35xxTxMj7KRw7qAq1JjOrN7dKcZGGzKmlmxe5lyPez0UPT0
 mDPXhkEdz2Xnpc528PgpkVz2lcMG73UxbqRhFosEdX2t1U7gu3lpR1T9ZH/j9kzo06+9PEfpC7h1s
 XwfgOdGD2aSy5afJY2un7feHGhoCl4utwN1fmu52OZgb9MlvoJDGCDsWluHVb1SFhHFllKFMbS5XL
 LE4Q8lzrhiLIICYcN/8BQt85GyRxY+83iYPZonXFy7Pf1ZJ0MU00JGq55XK/P3h15qxVcULjSBd5U
 8jyascFgsrp2Onkk/cK4CkeILRA4XoDywh2LmlAygdBrvYSNHnj9ylboDcAr5R2CuHQG0/Qw8QJEy
 uI4NMD3NevHbLsN5jWg+Ytqqij6tnRljUKNyNgX950SQ6Ey30ppjSszd6x6IGc=;
Message-ID: <cover.1792420035.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2026 16:27:16 +0200
Subject: [PULL 0/9] 9p queue 2026-10-19
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=e727e0c5d7d31640708fe3cebe31cc1312eefadc@kylie.crudebyte.com;
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

The following changes since commit 288b6c9e78913401fac4880b3281ce431540b8df:

  Merge tag 'pull-nbd-2026-10-08-v4' of https://gitlab.com/ebblake/qemu into staging (2026-10-19 10:54:44 +0200)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20261019

for you to fetch changes up to e727e0c5d7d31640708fe3cebe31cc1312eefadc:

  tests/9p-race: add Tread-on-dir race test (2026-10-19 16:07:26 +0200)

----------------------------------------------------------------
9pfs changes:

- Fix dir stream race via legacy 9p2000.u Tread request.

- Tests: add 9p race test suite (registered as slow tests).

----------------------------------------------------------------
Christian Schoenebeck (9):
      tests/9p-client: add Txattrwalk / Rxattrwalk test client functions
      tests/9p-race: add 9p race test suite (race FID-path mutations)
      tests/9p-client: add Rerror function (legacy 9p2000.u)
      tests/9p-client: add Tstat / Rstat test client functions
      tests/9p-race: add Treaddir race test
      hw/9pfs: fix dirent stream protection for legacy (9p2000.u) Tread
      tests/9p-client: add Tcreate / Rcreate test client functions
      tests/9p-client: track the negotiated 9p version for session
      tests/9p-race: add Tread-on-dir race test

 MAINTAINERS                           |    1 +
 hw/9pfs/9p.c                          |   23 +-
 tests/qtest/libqos/virtio-9p-client.c |  213 ++++++-
 tests/qtest/libqos/virtio-9p-client.h |  124 ++++
 tests/qtest/libqos/virtio-9p.h        |    6 +
 tests/qtest/meson.build               |    1 +
 tests/qtest/virtio-9p-race-test.c     | 1035 +++++++++++++++++++++++++++++++++
 7 files changed, 1393 insertions(+), 10 deletions(-)
 create mode 100644 tests/qtest/virtio-9p-race-test.c

