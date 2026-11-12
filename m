Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9D606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Scgvfzjr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZnn-00064i-MR; Thu, 12 Nov 2026 13:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnW-0005sP-Kc; Thu, 12 Nov 2026 13:45:26 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnS-00032h-G3; Thu, 12 Nov 2026 13:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794509113; bh=t7+kNbYhULZd4BN5+QHSl5HQ6ZlZka5Q9D+S33HPMAA=;
 h=From:To:Cc:Subject:Date;
 b=Scgvfzjrm8m3huqsWtJgngt6SFY+nTzW37rituPc8XNQXCPYqbRijhm1+UBEjGNsR
 Hg1KtYK3Qix/emvDAJaUz634f0RFgHfFO4M2kycod/0HQqxh7GTYv1Tbx5pR5HFq4f
 xKL+9XynapcXPiADvW8nDLurIPc5XkF1sZIpREfDEBi6mSxbnORZxyY4Yl8is8bEkC
 EmK2LMd55rPFdfmztPpSGc+p6zizoxqLYLAu/kCVo/ZIgxkGxdzhaO772DRSlh6HD1
 ZrqfkddVifW0XF6ejTjaWVEEsfrVo95TJmOQH8XwDzude/4JvNTWhp7I6W14ghlYVu
 nimehivwGLRnQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7D39B1E5D1B;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5F4A945AAD5;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4D9A3B7C4C; Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/6] Trivial patches for 2026-11-12
Date: Thu, 12 Nov 2026 21:45:03 +0300
Message-ID: <20261112184513.2324634-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 29760efaf96bbe5928f8111881eddbf5ac06439e:

  Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to dab5f72a8f44af4e984f91986f41d4968ff7e337:

  configure: --disable-containers should prevent `docker.py probe` (2026-11-12 13:30:40 +0300)

----------------------------------------------------------------
trivial patches for 2026-11-12.

Nothing fancy, some stuff collected since long time.

----------------------------------------------------------------
Alex Bennée (1):
      MAINTAINERS: fix typo in Gerd's name

Filip Hejsek (2):
      io: avoid potential double close of qio_channel_file's fd
      docs: fix a few typos

Lucas Cardoso (1):
      hw/audio/fmopl.c: Convert malloc, free to g_malloc0, g_new and g_free

Markus Armbruster (1):
      hw/audio/intel-hda: Belatedly update comment for removal of -soundhw

Matthew White (1):
      configure: --disable-containers should prevent `docker.py probe`

 MAINTAINERS                           |  2 +-
 configure                             | 17 +++++++++-----
 docs/devel/clocks.rst                 |  2 +-
 docs/devel/control-flow-integrity.rst |  2 +-
 docs/devel/docs.rst                   |  2 +-
 docs/devel/ebpf_rss.rst               |  2 +-
 docs/devel/multi-process.rst          |  6 ++---
 docs/devel/submitting-a-patch.rst     |  2 +-
 docs/interop/vfio-user.rst            |  2 +-
 docs/specs/ppc-spapr-hcalls.rst       |  2 +-
 docs/specs/ppc-spapr-xive.rst         |  2 +-
 docs/system/security.rst              |  2 +-
 docs/user/main.rst                    |  2 +-
 hw/audio/fmopl.c                      | 43 ++++++++++-------------------------
 hw/audio/intel-hda.c                  |  4 ++--
 io/channel-file.c                     | 18 ++++++++++++---
 16 files changed, 54 insertions(+), 56 deletions(-)

