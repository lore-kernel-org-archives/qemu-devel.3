Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD12D3942D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILM-0008V9-B1; Thu, 02 Apr 2026 09:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8ILG-0004lE-BD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:44:14 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXW-0008Mc-3e
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:52:51 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so525585a91.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134362; x=1775739162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qrr4QbGY7oqnXicvwxf8Z/wpr1z22lvvhKl+uNIG9E8=;
 b=QNiNKVO0CqCoOhv42sBEzwOccbJir11Hg1TLOHYAkThoP+BW/Zlk0tA12RWFK4JkrM
 MI/miDgUhamsePM6UDaaJbV8bIxn5QwSgUpRQyGeccW7qhk/lgZfXT/lVeOV07aN+uK4
 8RNn+UxxrOCYmW2L092G8k3gcRM95KEGQWT9I65yixN50yHr91Qoh+Duw33sZerAUnEv
 ISFXmDw1Kn2c0/5IoJ6nF8GT4jOzpEt2zsjuknLMXThozue6u6ryU+TzctzvX1E0o+ut
 /4OQvev9onAtDRXfLDtiMs7NrF4QKJHL2IDKHBGodJ0Z2VWDyfoWEAgmbhylKyWFfvnt
 7sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134362; x=1775739162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qrr4QbGY7oqnXicvwxf8Z/wpr1z22lvvhKl+uNIG9E8=;
 b=PpXQqS5SyDAP4M18WGqLYNViR+976xpa7ziSJCtzY/c99JnyPY0hjZty8Xa5qQu/J1
 DuP5QBmciD05fbIFmjtaCpoAwFIbn0zg73qL6atE43IrbIMvMui+FlvDoCPbuUif0DRf
 xlJwXhw8SWlFZbjou/s0PDDt7Nvc9Od9Mrc6J2M/B+dg0Ft4rl75LVU73qOKs9SY9JYM
 PqUNJb9eHtT4IzaEWNYF0HLynakjP/mL/9zlc4EVNe8nNDiYqsfiERUMq8pkZjMMEmHS
 wcqWZ8Is4hRVKxtnwDzCnGZog8cSvt2EoWCP1ABYAya0hcugSPOkq8Gk7SxD7Ch/kBE+
 WRGA==
X-Gm-Message-State: AOJu0Ywy9JRGe1y378yAp5Ryqi5oCKXXc1zaDAabptcDfQAOXW3Z4XTf
 nL7xhfcNqMoKIPSfIc8Xgr40AgnT93LoPhs+qkFjUTHDJwnoQfZjwGpVRpcpNU8Ej4Irnk9fTIt
 YsHVMSHBcFo1Yt0L6FdKGVjIJHP9Zp1TarBMnAuD1MFfdThkbXVlwt9255rqXgm+Argj9FMZOql
 FmORk6Xy1LFXgiiXA6Gkq2JqE8SmCNIV0G0w+Y910=
X-Gm-Gg: AeBDiet1BJgvlbovh5FEw1Mu8KR+CcIZXk7fXXPs/t3UT0uqUr+X5BoVixwzLxiudD2
 +6bqJPXX8i9b+LnjR1JmsrsXwReSawLB/ly0ardlNMoHnJ16bvX0m0OgknqXGB/fBM+PjE+XuzA
 chwe3Ti+sU9yUl/q92hVbqYgqVipmenuKcQR3sWIHWUmXVPkU2dxHUwDKgTbux21U3bQ8Pg5LGl
 Qgoq8cemFbwZUg+rDUVeTzwKrOeRwboKlaP+QauWYkoFhxdU5NhBnQN/IJDkgF4iG/EiOm62Ri9
 mGrEegb9GqAgK0gH5+b1EzfPRZDPXacXhShE5XZ95mHDY6Ik9MLij4SJNlJLbIBKmYql/7Ivimv
 2z1xMAmv+zF7q9phhvmc5I2h2jHB06Y3+eHs2HVEig/kcdv8y/rpaiZjDoHYclW0qw+QY9rVL/J
 b4kiVMo8i/3NnK0PT4SGIiM5Pgn6En7cZceAu3EBb91cd0dcKf5Fu8DHlLjoNow9YljTvdFtLCc
 Gnj5DHdeLsqN5+Tq83wJhVsSAk=
X-Received: by 2002:a17:90b:3d92:b0:35a:18b1:c245 with SMTP id
 98e67ed59e1d1-35dc6e7b4damr6368836a91.3.1775134361324; 
 Thu, 02 Apr 2026 05:52:41 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:40 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 0/9] Add Zvfbfa extension support
Date: Thu,  2 Apr 2026 20:52:25 +0800
Message-ID: <20260402125234.1371897-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102f.google.com
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

This patch series adds support for the RISC-V Zvfbfa extension, which
provides additional BF16 vector compute support.

The isa spec of Zvfbfa extension is not ratified yet, but is frozen
(v0.9) with a tag in official riscv-isa-manual repository.
This patch series is based on the latest frozen draft of the Zvfbfa
spec v0.9.

The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
bit position 8.
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Specification:
https://github.com/riscv/riscv-isa-manual/releases/tag/zvfbfa-0.9

Changes in v6:
- Remove the experimental `x-` prefix in cpu property.
- Rebase to latest riscv-to-apply.next branch (commit 479e3e4)

Changes in v5:
- Fix typo in patch 1/5/8
- Remove unnecessary do_bf16_nanbox

Changes in v4:
- Rebase on riscv-to-apply.next (commit 21101a7)
- Update commit message of patch 2 (target/riscv: Add the Zvfbfa
  extension implied rule)
- Update checking flow of illegal ALTFMT SEW patterns at patch 3
  (target/riscv: rvv: Add new VTYPE CSR field - altfmt)

Changes in v3:
- Rebased on riscv-to-apply.next (commit f66f234)
- Fix typo in v2 patch 5 commit message

Changes from v2:
- Removed RFC designation from the series
- Updated commit message for patch 3 (VTYPE CSR field -
  altfmt) to clearly explain:
  * VEDIV field removal (bits 8-9) since EDIV extension is not
    planned to be part of the base V extension
  * ALTFMT field addition at bit 8
  * RESERVED field change from bit 10 to bit 9
- Added new patch 4: Introduce reset_ill_vtype helper function to
  consolidate illegal vtype CSR reset logic

v4: <20260304132514.2889449-1-max.chou@sifive.com>
v3: <20260127014227.406653-1-max.chou@sifive.com>
v2: <20260108132631.9429-1-max.chou@sifive.com>
v1: <20250915084037.1816893-1-max.chou@sifive.com>

rnax


Max Chou (9):
  target/riscv: Add cfg properties for Zvfbfa extensions
  target/riscv: Add the Zvfbfa extension implied rule
  target/riscv: rvv: Add new VTYPE CSR field - altfmt
  target/riscv: rvv: Introduce reset_ill_vtype to reset illegal vtype
    CSR
  target/riscv: Use the tb->cs_base as the extend tb flags
  target/riscv: Introduce altfmt into DisasContext
  target/riscv: Introduce BF16 canonical NaN for Zvfbfa extension
  target/riscv: rvv: Support Zvfbfa vector bf16 operations
  target/riscv: Expose Zvfbfa extension as a cpu property

 include/exec/translation-block.h        |   1 +
 target/riscv/cpu.c                      |  15 +-
 target/riscv/cpu.h                      |   7 +-
 target/riscv/cpu_cfg_fields.h.inc       |   1 +
 target/riscv/helper.h                   |  60 ++
 target/riscv/insn_trans/trans_rvv.c.inc | 988 +++++++++++++++---------
 target/riscv/internals.h                |   1 +
 target/riscv/tcg/tcg-cpu.c              |  15 +-
 target/riscv/translate.c                |  11 +
 target/riscv/vector_helper.c            | 389 +++++++++-
 10 files changed, 1088 insertions(+), 400 deletions(-)

-- 
2.52.0


