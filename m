Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7FE606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=urIdDmL9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWT5-0004SQ-Pl; Sun, 01 Nov 2026 09:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWSy-0004Rp-Ce
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWSu-0007aR-Hp
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=J/EJE51CTVltuZt+Hs1ewsLflFCG8vSEOYSy30w62tM=; b=urIdDmL93YLeuKe21Y7kET/n/D
 PCY1l5mX2i+qUlOXRE5pDv3mw77rT3HCMYKVL7RkBoU0OBlaiZwz5xIP80e8HgQogwTtFl813PL63
 lcPsUWqdaMjr3+kaOZlfXOXF9jLYmxDhLcyh3mpwkht+AxHYNvLZdZKfqm+OPyFfwHhlhDb6VmoeH
 vlOxW4JIim9Xj1Jcp8vHxg3b3gzvd3vhdWra29JaXKnunJYNuS7j7D8YGotol73rRsfjQbjp+ch3a
 9t5A2Ren7SfQXKN6+W50GiR76QzmVBjM9tzBMhwawDhz64l67yRSAaTOl7vdPeuQX13zJBxIvKZzQ
 uD7O2YwcHAjgLtjjF9VWQuXp+9YZM+bPAf6yB4YbUOagn5Y/5Az+1X7rDkKOIW2cJnGyBdnsPHpzJ
 EMlrPxujnQK61Ljs/Jht6lc/R8r5itwbva5fWutj/0G34F3CVztRQaaU3IE451HuAGxrkM1hyLahD
 eplK72J9h0PDvNjbuOkkMw59+YCEKnWC0YKv58DP2KSsadJZImyf9anwuXA6T4TA4utm5mYpmB2Ps
 mlt+HpxQyo91bKpjASNnuTskWWms02qrkEVXC7YMpLQcBt1ulRI1YbvNDHtX/ChNNjL8JcU0MyMJO
 FHFF0TK8Ebywm8sSCow4mxRnRhVwEMOUI07qky9c4=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xNWS7-0055Ed-2e
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:22:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Sun,  1 Nov 2026 14:22:50 +0000
Message-ID: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/3] qemu-sparc queue 20261101
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

The following changes since commit 33eb51c859834f2024090bf843c69814267b6c26:

  Merge tag 'pull-vfio-20261031' of https://github.com/legoater/qemu into staging (2026-10-31 16:52:00 -0700)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20261101

for you to fetch changes up to a1eb9a1720eb2738a54fa16ff9fe4ce0b9da9caf:

  hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg (2026-11-01 14:01:53 +0000)

----------------------------------------------------------------
qemu-sparc queue
- The remainder of Stian's crypto patches

----------------------------------------------------------------
Stian Halseth (3):
      target/sparc: Model block-initializing stores
      linux-user/sparc: Report HWCAP_SPARC_CRYPTO for crypto CPU feature
      hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg

 hw/sparc64/sun4u.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 linux-user/sparc/elfload.c |  1 +
 target/sparc/translate.c   | 43 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 89 insertions(+), 2 deletions(-)

