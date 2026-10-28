Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7B606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqsfJmNO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCRT-0001tJ-UX; Wed, 28 Oct 2026 18:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRS-0001t2-BE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:22 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRQ-0007cX-OP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0ACA1600D1;
 Wed, 28 Oct 2026 22:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACD61F01825;
 Wed, 28 Oct 2026 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793227698;
 bh=cq7f/qxPvrSch6L8Ks9haHuiDO8/VA/+fYaJ1Evz1TQ=;
 h=From:To:Cc:Subject:Date;
 b=LqsfJmNOPdS0IEQQGafaHrcqv9iJkWsNDBGefNAPE3mqcGQsarX1qH8LpdCK5tJSp
 VjvvE84N0ajsKwk8dwKSMqgXkjg5pJGIR3zWaZFyqmw4rOJ4xOemgMxkf7COFYT0je
 bNrP6Pl21EpjPAVKb0LKQtBiHCyzOEUPx/PFz4aQfNNwMvVOd6+NSErFPzEFr1vuXQ
 XZMwX7FAgeL84jPHWr0BBWvp/d9rJSedvugu1ofLybngjFaiNdkIXB+YaGD0PlZaOM
 GhqBU9ClrvBn0j1LWkwvhaC8mZNm79LEndvdMSzj4iDpjfrG3W5ovbQNVObmaPi0El
 mRQcDiG+2AIPA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 0/4] Harmony sound card driver for 32-bit PA-RISC machines
Date: Wed, 28 Oct 2026 23:48:11 +0100
Message-ID: <20261028224815.32502-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

Implement the Harmony audio sound chip which is part of the LASI
controller. Used on 715 and B160L machines.

Patch set is on top of the previous series for which I just sent
a pull request.

Helge Deller (1):
  hw/misc: Harmony sound registers now handled by harmony driver

Keith Monahan (3):
  hw/audio: Add HP Harmony audio (LASI audio function, CS4215/AD1849
    codec)
  hw/audio: Wire up the harmony driver in meson and Kconfig
  hw/hppa: Add harmony sound card to HP 715 and B160L machines

 hw/audio/Kconfig           |   3 +
 hw/audio/harmony.c         | 892 +++++++++++++++++++++++++++++++++++++
 hw/audio/meson.build       |   1 +
 hw/audio/trace-events      |  10 +
 hw/hppa/Kconfig            |   1 +
 hw/hppa/machine.c          |  24 +
 hw/misc/lasi.c             |  12 +-
 include/hw/audio/harmony.h |  76 ++++
 8 files changed, 1010 insertions(+), 9 deletions(-)
 create mode 100644 hw/audio/harmony.c
 create mode 100644 include/hw/audio/harmony.h

-- 
2.54.0


