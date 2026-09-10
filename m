Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFD7C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDr-0003KR-Ki; Thu, 10 Sep 2026 07:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDp-0003Je-Sh
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:41 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDn-0000Ps-J4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:41 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 2F342240027
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040735;
 bh=xWf1GqlHwGn0uSSqMRE8p8KiI9bNqdlz+v8cdZSzrik=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=aeQ1gY90Gu0Od8KwHwkX37PrWCMMlihVwdELvKqNZxWJTgnzYJY2a7MtH2ygZPI4H
 hO5IS+VPPOOE4iRYLRmbHALksqlQdK0l59gI2cBvhwpfoMBUeSxscgnXv+9CQkRXOI
 AOKM6bqf91iH7vGXc8hLZhT8vozYxG2nK5bhkRG2JEntHJaerZZuAFOayOd1itERNC
 dbjuWguxKk3zBdoLmpc+UYRHjT8AVfI9E2Kqrs1ge35heOaMcH71V0FILJ2cd+IqWK
 lkpgYwp8R238ZgHae8+hFhoDNrMnEn9tDA0pglDxlvjXIxjsUdChvey/vUIk49nL5N
 o/xJKl9GLvOgQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTV2T7dz6txv;
 Thu, 10 Sep 2026 13:45:34 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/7] next-cube and test patches
Date: Thu, 10 Sep 2026 11:45:34 +0000
Message-ID: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
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

 Hi!

The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:

  Merge tag 'qom-qapi-pr-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2026-09-10

for you to fetch changes up to 72a02f711d11c78b88869dc00db392ef08504940:

  hw/usb/host-libusb: keep autoscan enabled for bus+addr selector (2026-09-10 13:34:51 +0200)

----------------------------------------------------------------
- Fix minor issues in next-cube machine and mark it as deprecated
- Add a configure option to disable tests
- Remove stamp files when deleting assets from the functional cache
- Make sure that pyling version is not too old
- Keep USB autoscan enabled for bus+addr selector

----------------------------------------------------------------
Brian Cain (1):
      tests: install pylint for functional linters

Florian Schmidt (1):
      Add option to disable building tests

Thomas Huth (4):
      hw/m68k/next-cube: Replace assert()s and abort()s with logging functions
      docs/about: Deprecate the 'next-cube' m68k machine
      MAINTAINERS: Mark the next-cube machine as "Orphan"
      scripts/clean_functional_cache: Remove also .stamp files

Timo Teräs (1):
      hw/usb/host-libusb: keep autoscan enabled for bus+addr selector

 MAINTAINERS                       |  3 +--
 docs/about/deprecated.rst         |  8 ++++++++
 hw/m68k/next-cube.c               | 12 +++++++-----
 hw/usb/host-libusb.c              | 14 ++++----------
 meson.build                       |  2 +-
 meson_options.txt                 |  2 ++
 pythondeps.toml                   |  1 +
 scripts/clean_functional_cache.py |  4 +++-
 scripts/meson-buildoptions.sh     |  3 +++
 9 files changed, 30 insertions(+), 19 deletions(-)

