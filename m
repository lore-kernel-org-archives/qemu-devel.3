Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5E6C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 10:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wirpJ-0008Ka-2t; Sun, 12 Jul 2026 06:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wirpG-0008Dl-Nn
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 06:54:22 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wirpD-0007XO-MS
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 06:54:22 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 39E7F240101
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 12:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783853595;
 bh=mU9bLv0sqvJZdyZdrzujoyBBLxBnhozKPzrCBGpTVB0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=kAc6WXS2I/GXg70AP/ipJmSEtN3qnx4RyUywINYbRgqol4T9WO1x0XttQf8ZZ+ks3
 Z7bCRH7g0rxDt24/WUnULIp9kGnJy5B2m/U7cKUNKFo3CCJdHCK1qqGRq1TNhJiVRQ
 6B1XRcY0CNVzCakhQ4ty7bGfn/6Ici67t+ECWSzlUiOXXfIoTeG/yEfLCKPl6TL2P6
 DPGhPdHTzIvelxJPy9Qy7426F/oTznylwQ+xzuHO6bFPPwnQur5Reoxc+bmfj8ze08
 BbJG0Qp0NGywXP09AkRdiTBYZ+VaAbEHC6mFciYldrkn4QATk8qKcoUKzza3s2uA4O
 2YxyYkKTfsEGw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gyj8p3Dmtz6txl;
 Sun, 12 Jul 2026 12:53:14 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PULL 0/1] A fix for functional patches
Date: Sun, 12 Jul 2026 10:53:15 +0000
Message-ID: <20260712105301.35409-1-th.huth@posteo.eu>
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

The following changes since commit a759542a2c62f0fd3b65f5a66ad9868201014669:

  Merge tag 'pull-lu-20260710' of https://gitlab.com/rth7680/qemu into staging (2026-07-11 07:15:53 +0200)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2026-07-12

for you to fetch changes up to 1531b9ec8c2e7033cbb737e2428827677be0a1b0:

  tests/functional: fix querying available machines (2026-07-12 10:12:17 +0200)

----------------------------------------------------------------
* Fix functional tests to take aliased machine names into account again

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (1):
      tests/functional: fix querying available machines

 tests/functional/qemu_test/testcase.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

