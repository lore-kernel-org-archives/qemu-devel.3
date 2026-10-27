Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoX/mdCO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLp5e-0002w2-Bk; Tue, 27 Oct 2026 17:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5c-0002vc-Aa
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:16 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5a-00006m-D0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79B1B401BE;
 Tue, 27 Oct 2026 21:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424981F01825;
 Tue, 27 Oct 2026 21:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137932;
 bh=NS00Falpjs9/z2FDeNa92tJ0T84vgMGfg+reGZBw5Jg=;
 h=From:To:Cc:Subject:Date;
 b=HoX/mdCObjk/hMW1p33/xyfrWo0S4bjjou5wqsK4IdY4dGgb6bUKr/iGdjA0REtzh
 NFENDkhX131yGGi/E1ojNArlthopzWnLTp/7A+S/TVBU8UhKg7ic0hzqjEehO1tpAi
 gINeATwFVgnvTMtNlR0tO1kykSgzpx7xJ6vwBjNnd7C9Z4F9KkPxr08aGLeCfy2UG0
 I5aD6LSyW37L/IF+dbp7/GOfCBdQF7Hhn9NAYWg3D7UmqCz9pPUUywgEe55J4RvfOd
 85fTL3+SM4u2DoMNoipu09IGUbPz08a1VR9WoeRrHR3z3WI39KGYnX1Ae3NYdohDVS
 nDgpKS5taiNVA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>,
 "Kirill A . Korinsky" <kirill@korins.ky>, Helge Deller <deller@gmx.de>
Subject: [PATCH 0/8] HPPA architecture patches for HP-UX 9 and 715 machine
Date: Tue, 27 Oct 2026 22:52:01 +0100
Message-ID: <20261027215209.21150-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
Includes an graphics/artist fix, adjustment to 15 bits for protection IDs on
the 32-bit CPUs and various other parts which were missing up to now.
Included is also the FPU patche from Kirill A. Korinsky.

What's missing to fully support HP-UX 9 is an additional NCR710 patch series
(which will be sent seperately later), and a SeaBIOS update which will be
included in the pull request.

Many thanks to Keith Monahan who did all the debugging and analysis why HP-UX 9
failed up to now, and who came up with most patches which we cleaned up
together.

Helge Deller (2):
  hw/misc/lasi: LASI Harmony Audio presence emulation
  target/hppa: Map CPUs at same addresses as on physical machines

Keith Monahan (5):
  target/hppa: Use 15 bit protection IDs on PA1.1 CPUs
  target/hppa: Only allow 8 BTLB entries for HP-UX 9.05
  target/hppa: Implement local broadcast I/O space
  target/hppa: Preload I/O-space BTLB entries for LASI and the central
    bus
  artist: Redraw screen on colormap changes

Kirill A. Korinsky (1):
  target/hppa: restore lazy FPU context isolation

 hw/display/artist.c                   |   6 +
 hw/hppa/machine.c                     | 106 +++++++-
 hw/misc/lasi.c                        |  15 +-
 target/hppa/cpu.c                     |   1 +
 target/hppa/cpu.h                     |   4 +-
 target/hppa/helper.h                  |   1 +
 target/hppa/mem_helper.c              |  25 +-
 target/hppa/translate.c               |  61 ++++-
 tests/functional/hppa/test_seabios.py |   6 +-
 tests/qtest/hppa-fpu-test.c           | 371 ++++++++++++++++++++++++++
 tests/qtest/meson.build               |   2 +
 11 files changed, 577 insertions(+), 21 deletions(-)
 create mode 100644 tests/qtest/hppa-fpu-test.c

-- 
2.54.0


