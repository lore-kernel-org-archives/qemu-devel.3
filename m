Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CA4C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zLY-0002oe-3w; Thu, 03 Sep 2026 00:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLX-0002oF-2s
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:43 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLV-0006Sd-Ht
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:42 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so1699161a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788410799; x=1789015599; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kWP2woB/8m81b+iVlvJ2ZY+9X6MHVsSiQXqVNZ811e0=;
 b=cKGK9O8fgQtIW2ZwRafKQQEopI1870ZWE2BzyVzGxp9J0zxcnTWbb9efMlN8q6w71S
 pFwf9WoQ3FB57kEGGklrcpA8Sx/XMn90522yzadHOsB9oEVcgUJ5mT2qndTk7SK6Qu57
 f8bbYYHRVMkpvhuOU4lefOpDru+uMJgWunzumLsstLwJKrzuHddl7L1wwepSB90+L2HJ
 i8Du68lVnphMnAd6PwXuZsr90UsC96AdgcGMYGPPjcllmvzEeasaR/AtU05KGFFWSslW
 TZmdkPeZqanxhOGpb0pjKEynut21BJ8cQeARphrmN26/+zyzCqTPJQqk8qjVbumfaWmk
 HG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788410799; x=1789015599;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kWP2woB/8m81b+iVlvJ2ZY+9X6MHVsSiQXqVNZ811e0=;
 b=pTNERsMyAXFSp+ZLKWgufHnNdT2ZKziDAE0EmwRfomG0Q/gda6ziAuqT57XUjiZF/c
 1/XcOBDFW+orBg90LZjiEpI0xZe/QYK2ZuWyBYxceZNCWNw4BCcorzd621neNnRCCMfF
 iUYl2XMygaTIIKIZdR4OI4/bcqoiSvpdBsnzPomLO3d77c6A68aRWtTijexMDqN2xQb6
 pSDLe9dUxDftSgJBIl3Wwqkjhewke6QflFnU902WJ8Jc84xOJtKwOlg5fizZFaD3bhqA
 wyr31CT7IB4VWidRuQtlNvUicfmEYCRzu4edEhEHDr1S00maJ+pFYfw9LJPu3XbWD73M
 bQ2w==
X-Gm-Message-State: AFuF++nwYaHBupwqXq8LLgVs+FM0G5M1hGjeI2CxxJZYeH+4YId2+Bfs
 rwbg5mJxPSIBPs5QI38FPYcPrw+ydMdGE7pAQ/6Q0mJxKpT8cqqnkQyIEjbziEim
X-Gm-Gg: AYBFou2y5odoewlRNhzfHbGcJOfzJQ0NmrJT1hzGF1hqgVSY1FLz9YC59SJ0ze6mUlz
 C9OFGLr+/bsqe5rujOGpW/D/5LaGnABNX6rRXjluTwgKZ5LjrbuRWh4N1IeBUHpfbRN3q87G6Jv
 aUrr7pNqAbpHwYRNgvkzzi5lq5eBWtGnB3oh5zo1y8ZjbLd6ZYJawO7ovm0XMYWyEtINX4mtsA/
 9zw5VjEbss3bw1TveMCkGNNnIx1RP1ayacz0Gt+9fqFCGNsxkK7FBSgNAuybdYlTerHjRtBCIj7
 iNrVjIPKY5P+MGCsge0Y5xPcdeMKk/jLzIat1CSPmVv+MYwLPQHr5/gw+wX4R+H8Qas5MvsaPIq
 uW6z58gMrd8LIxqt3gpNI9sRkPAwemakDtu4rMsQ220/K0v7JuK5a+NcquI615IiyW/x9t6i5C3
 lqS5gfRnN94ZBn+RO9NfEkhxbA8bH9kcUO6WSMLPjGfXYFmKUNB3t59n50N6WqLgB1cDyilaJH0
 yodVyI8jh4HPKMN2lAR/CasxIXQOA==
X-Received: by 2002:a05:6a21:394a:b0:3d3:ad3c:49aa with SMTP id
 adf61e73a8af0-3d9ae7e091emr15983109637.24.1788410799230; 
 Wed, 02 Sep 2026 21:46:39 -0700 (PDT)
Received: from localhost.localdomain ([76.133.142.170])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm2337726c88.9.2026.09.02.21.46.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 21:46:38 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	balaton@eik.bme.hu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v5 0/6] Implement missing functionality and hooks in m68k to
 support upcoming Sun-3 implementation
Date: Wed,  2 Sep 2026 21:45:13 -0700
Message-ID: <20260903044626.24453-1-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=54weasels@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds M68020/030-specific features to the m68k target that
are required by the Sun-3 machine (series C) and its PROM/SunOS guests:

  1/6: CAAR register stub for 68020/030 cache control
  2/6: fsave/frestore fix for 68881 (non-68040) FPU frames
  3/6: Edge-triggered NMI semantics for Level 7 interrupts
  4/6: Function code extraction during TLB fills
  5/6: Custom MMU intercept hook for Sun-3 transparent translation
  6/6: Physical Bus Error and M68020 Format 0xB stack frames

Changes since v4:
  - Added Signed-off-by to all patches.
  - Patch 2/6 (fsave): Addressed Zoltan's review — replaced redundant
    M68040||FPU check with just M68K_FEATURE_FPU, removed unnecessary
    if/else in frestore, moved Context: below --- separator.
  - Patch 3/6 (NMI): Addressed Zoltan's review — nmi_pending cannot be
    replaced by testing pending_level == 7. The flag captures the edge
    transition (level < 7 → 7) required by Motorola's NMI specification,
    while pending_level only reflects the current interrupt level.
    Testing pending_level alone would produce level-triggered behavior,
    firing on every interrupt check rather than once per edge.
  - Rebased on current master.

54weasels (6):
  target/m68k: Add dummy CAAR register
  target/m68k: Fix fsave/frestore for 68881 FPU
  target/m68k: Fix NMI pending for Level 7 interrupts
  target/m68k: Extract Function Codes during TLB fills
  target/m68k: Implement custom MMU intercept hook
  target/m68k: Implement Physical Bus Error and Stack

 target/m68k/cpu.c       |   4 +-
 target/m68k/cpu.h       |  21 ++++-
 target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
 target/m68k/op_helper.c | 175 ++++++++++++++++++++++++++--------------
 target/m68k/translate.c |  30 ++++---
 5 files changed, 280 insertions(+), 80 deletions(-)

-- 
2.50.1 (Apple Git-155)


