Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88C606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Y5Cz/EbO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRaE5-0000MX-4F; Thu, 12 Nov 2026 14:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRaE3-0000M8-4Z; Thu, 12 Nov 2026 14:12:47 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRaE1-0000B7-1B; Thu, 12 Nov 2026 14:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794510759; bh=OaG72upl5Sa6udEcR9CYkdUU4kEmjed2qc51DvTkHZs=;
 h=From:To:Cc:Subject:Date;
 b=Y5Cz/EbOA51onMKm5Mtby+Q0dKi+YpUDuyMxIYI/4u5msZ3ZSr7nlfuA/axUhb5Q4
 iY0fWcluYcjuk7Wv4uCp+x+uJw+mgQ7EL4XsTd1vkkMYm1Cg16GAN8ptsm4YISQWwq
 KVH3QfqKFgGRisVGJSqBPO/0jGrl6ZO26RiLvqC/wy2Phi5G1ZQTp4+pmtBgZTyVx/
 GGxA7h9b39/9lWVUfvNcXo2uEyYInsGFvhO8HmofPbXhU61fqbfLIZMT7K6yITSeLn
 Gu7oJDYoPajEsjTR++9l20sADAuJzQpzGA8XpERkbrgaAzahuTO83rNDTVtsX5jKre
 526NiXsXdLjHg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 003EC1E5D34;
 Thu, 12 Nov 2026 22:12:39 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EDADC45AAF9;
 Thu, 12 Nov 2026 22:12:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DC5B2B7C5C; Thu, 12 Nov 2026 22:12:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL v2 0/5] Trivial patches for 2026-11-12
Date: Thu, 12 Nov 2026 22:12:20 +0300
Message-ID: <20261112191239.2327003-1-mjt@tls.msk.ru>
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 29760efaf96bbe5928f8111881eddbf5ac06439e:

  Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 84d6ea1499d584bc31b64aeae4e0e8528e0da5b4:

  hw/audio/intel-hda: Belatedly update comment for removal of -soundhw (2026-11-12 13:30:40 +0300)

----------------------------------------------------------------
trivial patches for 2026-11-12.

Nothing fancy, some stuff collected since long time.

v2: drop
   Matthew White (1):
      configure: --disable-containers should prevent `docker.py probe`
as it causes questions.

(Not resending any of the patches)
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

 MAINTAINERS                           |  2 +-
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
 15 files changed, 43 insertions(+), 50 deletions(-)

