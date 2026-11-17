Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05322606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iAWZXeTv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI6-0002JI-Dq; Tue, 17 Nov 2026 08:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHy-0002Gt-O7
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:02 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHt-0000Ju-HV
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:31:56 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so43307745e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922312; x=1795527112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lsBy4QQqpE46PRdO+saaGGS03mizv0NFRFGb0T9l2rI=;
 b=iAWZXeTvPtkGuB9oX3lAHK3305gKYJ4OssJMP357GUNnFkN8i16yUB78KxH61pSZHG
 +J7dWuJJxDWRllFdFAWaUE22D+Li2oXj/9DRQEF1GPdIiqGBZpvzi6geFJyqsSubjo0A
 zenZjZspC+m/Kmolom3THazKDoysHPMl1Ig8jK61Xn5bAL2DkG+z0iB16PTqbuDzcXEm
 6AYqK7glJF5cny/ktpdYFqEzyAI7y29yle0HnZ6P3nGheY1J/KqzPxBlAYfuoQIqwxSd
 /2kcyPSLp1mu0jDfr2wKPPJg2W4lXzpB9buM9BYleqrKgSeDeIrMZjxgFjqSKF9+le20
 BUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922312; x=1795527112;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lsBy4QQqpE46PRdO+saaGGS03mizv0NFRFGb0T9l2rI=;
 b=lltbvTIMhpk4FzC2gdcOo3EllXYaOrGmjz01/5RbB0E6//T37MYTz+FSiLtLhtedp4
 5SMflxOiLx4ZeNbClxwkCvwKiWvWQfOiWSnRC0VKPjgOMAjBTerVq7SILCBUQTggD1Xo
 DbbJMUhZI6hv0raEcLEVqwE2U2DB9lKWol76JN3fEXhAk6iajerZVnNws5da6K6W1lAE
 HjabnTlXgNN78B975kCS8UpRWSvruIPB2oFYemTyrLeyD5OlGKsW//fv8uflzcJH+2tI
 hZkDdTIFKVXqXMUVkLAQCwMof9JNWsEmaoHsYBA9KnEPcrN3knHGIOLOsujuX9/86fXX
 JOhQ==
X-Gm-Message-State: APuU4Z+10zTo9wbGkq87huVkavcPmYVOhAMf7G0Ev+E11h9BRevWJAVl
 f6IjkKp2PrErhhEM6+YnvAkWdK97OBWVlGnUYM+bp981x6FMgZ4EVN14XhTolN5GjpK2qiWFpz7
 rGXLdVT4=
X-Gm-Gg: AYBFou0HlB8+t+zhkLRiPv+Xk4kvWVBf3KNQUgBJk+N3alKkQRJWgzSSJByTCKKj1Ok
 lStektfb9NL9jMIYulFcs1y1AaqnavafaVlCUdck0KQ+TXWghq7EpGa8VJjUog8fMp59ToRm6IU
 25y4ZWlhnBRhrKkPpWRxT4y6SGiAI8bdldP5Uqhl/fsDn/e6pQWd2yEq28ypqAckXe6HgejRAe4
 B73MKP8s/JYaXRR7tXcFqo1JHfsNHlH8iBlfUMg6pvCu+mrND1kxGrjKKuApv1+dKC3aYT/dm4C
 L4/3KwzRPfSEzM3LSbhM+i3VtlcLbr4oAqtnlhidXGn8BYmUjQRdEaSbESzY4Z0kg0QoLNpr74d
 mBn21NiLDjOLhufnFnJ8z+L08v4XU2aa4i+YBREBGhLfnx8OaFPEALm/598/OnB+TlWr1CBWTFJ
 fi5BuPQwtWZNZklW+iFHh1sO9x9/yIeVY0RLR9/ZWLIi1WNEGGc3Ztg+cGfcLsDPXpoCwnf/i1J
 Nh75Pp+IrfAcr76+0dgwmeo5isGvtJ4ajovHxrhYF6xw/8CIaOnuyiHCNyzJ6YuvGdKPZ57NiZr
 nW9mQ2+Pngi5b+vQq19wdV33DbM8ITecFNuKoAzT0z9N/3DEep1XcMhIedZ9QISOMW5A0pET9ZL
 sSgcB0/oxMGidUjAY5vjwfVnXlIuHqpqGbLs=
X-Received: by 2002:a05:600c:8b56:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4bb55ad0711mr294445895e9.29.1794922311277; 
 Tue, 17 Nov 2026 05:31:51 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] target-arm queue
Date: Tue, 17 Nov 2026 13:31:41 +0000
Message-ID: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi; this is a small pullreq of little things that I forgot about
but which I hope will still make it into rc1... The only big
patch in here is the new ccid-card-emulated test case.

thanks
-- PMM

The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:

  Merge tag 'docs-security-devices-pull-request' of https://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261117

for you to fetch changes up to 81641446c0b5aefdc814131f0ce7435b9f5787ca:

  tests/functional/x86_64: Add test for ccid-card-emulated (2026-11-17 13:06:01 +0000)

----------------------------------------------------------------
target-arm queue:
 * Revert recent qemu version.h handling changes
 * target/arm: Get HVC UNDEF cases for Secure mode right
 * target/riscv: Fix RCsc ordering of Zalasr store-release
 * target/arm: Fix RCsc ordering of store-release instructions
 * target/arm: Fix barrier polarity of A32 LDA load-acquire
 * hw/i386/amd_iommu: Mask address when calculating large PTE page size
 * tests/functional/x86_64: Add test for ccid-card-emulated

----------------------------------------------------------------
LIU Zhiwei (3):
      target/riscv: Fix RCsc ordering of Zalasr store-release
      target/arm: Fix RCsc ordering of store-release instructions
      target/arm: Fix barrier polarity of A32 LDA load-acquire

Peter Maydell (5):
      Revert "meson: rewrite scripts/qemu-version.sh directly in meson.build"
      Revert "include: introduce qemu/version.h"
      target/arm: Get HVC UNDEF cases for Secure mode right
      hw/i386/amd_iommu: Mask address when calculating large PTE page size
      tests/functional/x86_64: Add test for ccid-card-emulated

 meson.build                                      |  29 ++--
 hw/i386/amd_iommu.h                              |   3 +-
 include/qemu/version.h                           |  20 ---
 bsd-user/main.c                                  |   2 +-
 linux-user/main.c                                |   2 +-
 monitor/qmp-cmds-control.c                       |   2 +-
 qemu-img.c                                       |   2 +-
 qemu-io.c                                        |   2 +-
 qemu-nbd.c                                       |   2 +-
 qga/main.c                                       |   2 +-
 scsi/qemu-pr-helper.c                            |   2 +-
 storage-daemon/qemu-storage-daemon.c             |   2 +-
 system/vl.c                                      |   2 +-
 target/arm/tcg/op_helper.c                       |  21 ++-
 target/arm/tcg/translate-a64.c                   |  13 ++
 target/arm/tcg/translate.c                       |   8 +-
 tools/i386/qemu-vmsr-helper.c                    |   3 +-
 tools/qemu-vnc/qemu-vnc.c                        |   2 +-
 util/module.c                                    |   2 +-
 target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc |   8 ++
 scripts/qemu-version.h.in                        |   1 -
 scripts/qemu-version.sh                          |  25 ++++
 tests/functional/x86_64/meson.build              |   1 +
 tests/functional/x86_64/test_ccid_emulated.py    | 167 +++++++++++++++++++++++
 ui/cocoa.m                                       |   2 +-
 25 files changed, 261 insertions(+), 64 deletions(-)
 delete mode 100644 include/qemu/version.h
 delete mode 100644 scripts/qemu-version.h.in
 create mode 100755 scripts/qemu-version.sh
 create mode 100755 tests/functional/x86_64/test_ccid_emulated.py

