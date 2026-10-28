Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477B606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUiKo6aw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8Mt-0005bx-1u; Wed, 28 Oct 2026 14:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8Md-0005Zl-7j
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:10 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8MZ-0003IR-LD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:06 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA8134049B;
 Wed, 28 Oct 2026 18:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0021F01825;
 Wed, 28 Oct 2026 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793212014;
 bh=Qn5jisujd84s7c5b2rJM9t7JmtAJKYLuMuWyEjGr3jo=;
 h=From:To:Cc:Subject:Date;
 b=hUiKo6awFb6RC7u9WMH1PTgpz6qYBTdUg410g7iMG6GH9qaMnBmGUVMwBcqvqbSHq
 gwYKh9j1YFPm2+glirnfn/kkmSOFyTnAp4nUcOtYte7P6IVV6T22T1Hb+g0q7fI/fk
 cwiy6ZZhayyr3PWcgTOSzMIt05Sx2hxhol9IgHRS+jGhWL0xd++RFswPnCy1FbJwAP
 TH9/turQl8fq6mQpoG7/VaZAl/d195L0LpEAEmDvU+gtnAu7CJcv4V4Snb20IywJxg
 laj+VR1fRMw9ktvHOfGAl1ijqYHIbRVBzWZQS7N2V11z4Qr7TyVVPbaWTZ9Y2uf5uh
 iK1o7s+W+cu0w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/9] Hppa 715 patches
Date: Wed, 28 Oct 2026 19:26:42 +0100
Message-ID: <20261028182651.5950-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:

  Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-715-pull-request

for you to fetch changes up to 906a079ca3f466763b622320d230b448f2c12a39:

  target/hppa: Update SeaBIOS-hppa to version 27 (2026-10-28 19:22:13 +0100)

----------------------------------------------------------------
HPPA architecture patches for HP-UX 9 and 715 machine

A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
Includes a graphics/artist fix, adjustment to 15 bits for protection IDs on
the 32-bit CPUs and various other parts which were missing up to now.
Included is also the FPU patche from Kirill A. Korinsky.

To fully support HP-UX 9.05 an additional NCR710 patch series will follow soon.

----------------------------------------------------------------

Helge Deller (3):
  hw/misc/lasi: LASI Harmony Audio presence emulation
  target/hppa: Map CPUs at same addresses as on physical machines
  target/hppa: Update SeaBIOS-hppa to version 27

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
 pc-bios/hppa-firmware.img             | Bin 641484 -> 634968 bytes
 pc-bios/hppa-firmware64.img           | Bin 682800 -> 682880 bytes
 roms/seabios-hppa                     |   2 +-
 target/hppa/cpu.c                     |   1 +
 target/hppa/cpu.h                     |   4 +-
 target/hppa/helper.h                  |   1 +
 target/hppa/mem_helper.c              |  25 +-
 target/hppa/translate.c               |  61 ++++-
 tests/functional/hppa/test_seabios.py |   6 +-
 tests/qtest/hppa-fpu-test.c           | 371 ++++++++++++++++++++++++++
 tests/qtest/meson.build               |   2 +
 14 files changed, 578 insertions(+), 22 deletions(-)
 create mode 100644 tests/qtest/hppa-fpu-test.c

-- 
2.54.0


