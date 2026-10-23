Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79945606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=wHJBdHZD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKMTc-0001kN-EF; Fri, 23 Oct 2026 17:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTa-0001k7-Pn
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:06:58 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTY-0003PS-QG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=ycMZif4rKpVgs+UajMljkkBtRHLHYkA+mcGV7bQdP9c=; b=wHJBdHZDwk1eCgtYmJGm2GiSXb
 GmgUU8wkmr3N6K83YmhUOi316OZX08cM+h9WfbEaB9ue1Hgm5g5fY/VsJE6OCkSmOul7W9bb7uG7i
 nSiGnLKws6AG5KuehyWbuMEACsRKEN5OKPoCPni6gjmB46iOK7D9N5nKFkTrqEBt7ub/H1GMD1zj9
 DofljacrKi3IGkV9S3RnfUcYBoHQHDPEga9raoBLCTJTXpppnBtp4/3HdacvKFptUk5MuV+ct5UUo
 GEPBp8HEzEfhzWI7ASuarjQjwfcGQbwsGiCbX07QuGdGey2tCuqbSdTubkrZPrVsUVtX4Z2vUSmWd
 wznIdMuE1ApdIE2z5egg1akhvksFXRAwc3rr18EaoyX8F36E0xpKszN3+bxCPaZNuAnwYBIfKub6g
 y0/RERpOIztnb7QfmwkSHaOERVT5NbixiEPNFDwrhxZu12GvC2ogVWuMYVyFsll5Cjq1yz+slAZJ7
 ZIFAJHNzTo4P7+4Qxg9tJ0tQqk1YdVl0jthUZ8uNrOx40FD3ulyr+yrSRCrsPSlKn2O5Lo5QWSGkv
 O/JZzX+Nud/S8mQepmcMVUqjdX1nJd9sSyp6aztnmTItkLy8SzMOeMiU+3/jtRPn+SLsFjWN7Q4c9
 mKDBSZOKY5OzSFzx3e/GKTlZZTdpkX97se66Zi+xE=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xKMSp-003QXg-2t
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:06:11 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Fri, 23 Oct 2026 22:06:30 +0100
Message-ID: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/6] qemu-sparc queue 20261023
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:

  Merge tag 'pbouvier/pr/tcg_tests-20261022' of https://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20261023

for you to fetch changes up to 5d9cd4fb378a4c33b837d7ee1e9ef3f877c66d15:

  target/sparc: Add the SHA instructions (2026-10-23 20:11:08 +0100)

----------------------------------------------------------------
qemu-sparc queue
- First set of Stian's crypto instruction patches

----------------------------------------------------------------
Stian Halseth (6):
      target/sparc: Add crypto feature
      target/sparc: Return CFR when crypto feature is enabled
      target/sparc: Add the eight AES round instructions
      target/sparc: Add the AES key expansion instructions
      target/sparc: Add the CRC32C instruction
      target/sparc: Add the SHA instructions

 target/sparc/cpu-feature.h.inc |   1 +
 target/sparc/cpu.c             |   3 +
 target/sparc/crypto_helper.c   | 442 +++++++++++++++++++++++++++++++++++++++++
 target/sparc/helper.h          |  16 ++
 target/sparc/insns.decode      |  26 ++-
 target/sparc/meson.build       |   2 +-
 target/sparc/translate.c       |  81 ++++++++
 7 files changed, 569 insertions(+), 2 deletions(-)
 create mode 100644 target/sparc/crypto_helper.c

