Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F66E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2LI-0007vl-71; Mon, 02 Feb 2026 17:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LF-0007vN-Sm
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LC-0005d9-0k
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:20 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso42482065e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770071054; x=1770675854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dNkFLEId1hGGGjWWQdqVQsN/0wECLMxRnLUqfwiZ/dc=;
 b=v0/ynZJtzNN99LPw9GzjQF4m8J2Tm7optNnIEy9XzqFllGYgeVr3LcqmlAWsLEg7Kn
 317MA8AxFBP6Shfuoaln+4i/GNbRwctHhdGfzTnHOmMwUbnJiKkRxyxqmg+iUEYSoqaT
 myF4eoGC6obDvu6RAa/fSf0nVWzzWxpZnJwphHf7E+oEoyXSfn9XpBr+NJhfx7xdeqDr
 pBXvEFmbXJR8nf89paxIwF+HsfoGLUD6jobqbJxO39N40/svgENfqAZ73u2Dpwusbdc3
 W4njJvXbx5EFkemVfyg3u4bp2ZWFFwWvIX7eQOAIjY+jWtlgqEjmavETKu8Jf4uCE+l/
 auLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071054; x=1770675854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNkFLEId1hGGGjWWQdqVQsN/0wECLMxRnLUqfwiZ/dc=;
 b=BcdcLDClg8/1c2+qrDDo0gBn0Z/FAd+P11Y56aCWvAXePZTnBPYKidzDS6zthiS3b7
 p8b48tgE33uf3Z5DS6aRXZKmH3nJnQv4xi6FDyS2PuYV87vhzgUQ+ZPFcj1FoC4ZmheV
 DPsx5NWQgqpZO6LPV0d+JrFodqk761+MSWgzR99vZKrtzBnjfHVMve2Sgq38ubdtT1F1
 fodEhKLIrKUZzwWJg3TxATTtT4jIB39fK9DJoj5Lee9jqUcY9ufTR949ck+7MjQ3D5WN
 KXSH4oGx4PL/shIqFCh6eBBANbAW4HM/iBN8m7LcnWBDw9trRpIcbs6d9H5g8bzIZvjj
 GZjQ==
X-Gm-Message-State: AOJu0YzQuzsSj1FDtF70ArFjkCcz9BbUAHmCHgmMVaqkCPTO7O2dtoW3
 HiIaTj9Q0P/Itn27nSM+KilvpJXNM44ZRP3lpd86jW7UHtF1lc0pg3msL3ngBAS0uXH5agTPYZC
 gSymGQGWQ9Q==
X-Gm-Gg: AZuq6aLy4Q1UuqxBoVePKZ/a/nX11sIm5izOF/og01pOgS5NZMRg5fPVRB/yLvATn+I
 7yfkaW0LLATLFkIIrzvAZM0D2GqH5LvHj5IzxGOW6j2Fp+zjT0gIjz2Gz+WqQUvL0t4jcrqAJ8e
 mTFJekgW5QGRgtTBPbCSs/earrormoT0dPhdQ/sR/6m6UZS+WXorVH/Z9qfIUc+tdMwXlDQHJ1M
 ZDq8mg7LvICqKDr2360aOQs5EYCTDXEBWoVd9iZ8Iuw+O+YEftQzBI/ZAsVj9BhDh2z0MOIMSbF
 UqcQxPvqE+S4eqX1hVtqTEskgfXbi3Yybd0MmtLaIj5OCa7u8LZaRq9b6aV8M/P/2T+Lywim7rI
 8hKoohllcRhM9ZXVJfJzr1S6yFcEssuLAFMAkwY5Oc6Sd7faZ42crgayw1Rx/RI8bj9GrEKRqEd
 kUsrCRIin/c2ZPZUOEpwhQ7Kw0OocVFeUL7W8nVlxsl4AgG+mWho3YjQo0+hmv
X-Received: by 2002:a05:600c:350c:b0:47f:8c05:786b with SMTP id
 5b1f17b1804b1-482db48d476mr162100825e9.28.1770071054399; 
 Mon, 02 Feb 2026 14:24:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm46734796f8f.7.2026.02.02.14.24.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 14:24:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] disas: Have disas_set_info() take a const CPUState
Date: Mon,  2 Feb 2026 23:24:05 +0100
Message-ID: <20260202222412.24923-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Have the CPUClass::disas_set_info() handler take a const
CPUState to be sure it is not modified. In order to do that,
first constify few callees (ARM & RISCV).

Philippe Mathieu-Daudé (7):
  target/arm: Have arm_feature() take a const @env argument
  target/arm: Have cpu_isar_feature() use a const ARMCPU object
  target/arm: Have is_64() take a const @env argument
  target/arm: Have arm_sctlr_b() take a const @env argument
  disas/riscv: Make rv_decode::cfg const
  disas: Make disassemble_info::target_info field const
  disas: Have disas_set_info() take a const CPUState

 disas/riscv.h             | 2 +-
 include/disas/dis-asm.h   | 2 +-
 include/hw/core/cpu.h     | 2 +-
 target/arm/cpu-features.h | 2 +-
 target/arm/cpu.h          | 6 +++---
 disas/riscv.c             | 5 +++--
 target/alpha/cpu.c        | 3 ++-
 target/arm/cpu.c          | 6 +++---
 target/avr/cpu.c          | 2 +-
 target/hexagon/cpu.c      | 3 ++-
 target/hppa/cpu.c         | 2 +-
 target/i386/cpu.c         | 6 +++---
 target/loongarch/cpu.c    | 3 ++-
 target/m68k/cpu.c         | 2 +-
 target/microblaze/cpu.c   | 2 +-
 target/mips/cpu.c         | 7 +++++--
 target/openrisc/cpu.c     | 2 +-
 target/ppc/cpu_init.c     | 5 +++--
 target/riscv/cpu.c        | 7 ++++---
 target/rx/cpu.c           | 2 +-
 target/s390x/cpu.c        | 2 +-
 target/sh4/cpu.c          | 3 ++-
 target/sparc/cpu.c        | 3 ++-
 target/xtensa/cpu.c       | 3 ++-
 24 files changed, 47 insertions(+), 35 deletions(-)

-- 
2.52.0


