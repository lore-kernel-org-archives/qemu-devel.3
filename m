Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF978C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrti-0001Qz-An; Fri, 17 Jul 2026 19:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtg-0001QE-Dz
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrte-0006wu-P9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so76385545ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330589; x=1784935389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pf35ft1B1D/t3qmeAkjFpsZffjZXUqazoEptkfpvL2w=;
 b=UTMqvPJowLmnqUZ2awWLBf3bocTUdxpABi23HS2tl4Vs4Y5yRvHTF5m0BDHtlnKHmh
 TZyFExTsdab6VYYj6ITDXcD/v2FTzbsuGfi8cAvW2gFSd35cEThitiHhl4vUpHn0Y+QK
 lR4JjGONfkCLjP4lMrC+gcmDOhHh//NXhvyW4mC6EnwrliIqb0M5bhloMZwzFwu1zDo+
 d+T5Fc2N4zNy7h8zSRbpE6Ky0wpLdMLSh7/ed0v7RPzgMijFAtLgIdlo6i/RkyFD5ThG
 asMlY/fLB42dFWc6XzSStWGzVympgA9z9cwPt/K3WlDeZvlSpSKsqnL4Et+sd1Q7Jo6a
 6W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330589; x=1784935389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pf35ft1B1D/t3qmeAkjFpsZffjZXUqazoEptkfpvL2w=;
 b=l4Cyp1Rj9gdUKj6gxbu/mJisFxI79kxbFsWmTBa1iRTbKYo8l3DavQ4te2UMhFKqiq
 MfvbODckAxK//2IZEpBxGErSDPO/MuFnJWJCfD0KkiAqi+PWIZ1QOTr3BxM8S1RZRAGz
 HAxnDe1WRR4cLi3/W+dnTfHpsckihvELoLEUxiHNlItJwV6j+xCjGJL5ZD1LMg9dfHvG
 296LMDcDsmA185tA2cES3ZW2ijuhQw4y7zlQtmw1eSE4/OnXaniUcmYtu5dhygDH6pYQ
 ES/qOxHNrzZmeryoV2nH0Fb0exDaZ9zgh/9BpT9dzRj7VNaJ2vOvbVci24L6fQuA294j
 uzxQ==
X-Gm-Message-State: AOJu0YyEu6veokzzYlDJyOAER0IRC2zFdUg0htgaNgL9twPFPLJqWCKa
 bXsnFrGiLGg4jATLQWCwF+eFoPXdwMBwi4FRr/qjMW+2hH1hbGaRU1gQPsrDhJvp/u9XFqyb+Ej
 iAaGW
X-Gm-Gg: AfdE7clVFIwIif/ZxM7rF4n8gPYC4tJpYsSQtKDRBTkyWL9EGgfbh0fbw5Onpn7rTt2
 GZZu9/0N+yLXwSrdYd2AG1nBCf/doDxH7s4ufzysc0QxGPRnOMDqxhh1sXtkOI1VxeZCGpHn1RL
 sPwc4tohszYNtprtzezmYu2a/fLs9zGXFMXsIxWiVWLKdGCOjEfGi+J2uHL5qiLSLGqat9MU4HV
 4arqpD4YbN92j/Pgys5zCJUWLrmgEH8B6XJauorZgdkmHdTGSn8NfyoA+Yb5ziPYlUZuq6j1/ai
 axLRAClhoAyFKpt0mYRaTxsr5yAnZi0c4Q39OfdMayaXSPd0ju+NzVJpN/iUsTINoOtFiF6OsQS
 VSCxx7CvaJNQwH5FZ0ao+3CLB99Df0dwSci9aMGILh2hFsrRNDe7xbrzya/g2YPrhhwDtUcKGQ1
 vUqkjH59s=
X-Received: by 2002:a17:90b:17c4:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-38e4b431495mr4497943a91.18.1784330588549; 
 Fri, 17 Jul 2026 16:23:08 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/17] target/arm: Various trap fixes for DC ZVA et al
Date: Fri, 17 Jul 2026 16:22:47 -0700
Message-ID: <20260717232306.378988-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This started as just addressing #3005: raising the unaligned access
fault for DC ZVA on pages with Device attribute.  But then I saw that
we weren't correctly ordering the permission fault for MTX, and that
we could avoid multiple page table lookups.

While these are bugs they are minor, and beyond the one patch already
separately posted they are not 11.1 material.  This is complex enough
to warrant a very close look.  I hope that the code structure is cleaner
than before, so that should help.


r~


Richard Henderson (17):
  include/user/guest-host: Include exec/abi_ptr.h
  target/arm: Fix testing of raw mtx value
  target/arm: Move helper_dc_zva to mte_helper.c
  target/arm: Raise alignment fault for DC_ZVA on Device memory
  target/arm: Imply probe from allocation_tag_mem_probe
  target/arm: Simplify invalid page test in allocation_tag_mem_internal
  target/arm: Return struct from allocation_tag_mem_internal
  target/arm: Generalize probe argument to allocation_tag_mem_internal
  target/arm: Drop TLB_MMIO check in allocation_tag_mem_internal
  target/arm: Probe second page earlier in allocation_tag_mem_internal
  target/arm: Expand dczid_bs in DisasContext
  target/arm: Split out helpers for creating MTEDESC
  accel/tcg: Clean addreses in the user-only probe_access api
  target/arm: Drop clean_addr_tbi before helper_dc_zva
  target/arm: Pass MTEDESC to helper_dc_zva
  target/arm: Create helper_dc_zva_mte
  target/arm: Rewrite DC_GVA, DC_GZVA, STZGM

 include/user/guest-host.h        |   1 +
 target/arm/tcg/helper-a64-defs.h |   9 +-
 target/arm/tcg/mte_helper.h      |  18 +-
 target/arm/tcg/translate.h       |   4 +-
 accel/tcg/user-exec.c            |  10 +-
 target/arm/gdbstub64.c           |  10 +-
 target/arm/tcg/helper-a64.c      |  50 ---
 target/arm/tcg/mte_helper.c      | 643 ++++++++++++++++++++-----------
 target/arm/tcg/translate-a64.c   | 189 ++++-----
 9 files changed, 530 insertions(+), 404 deletions(-)

-- 
2.43.0


