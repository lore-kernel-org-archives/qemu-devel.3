Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F41FF8850
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFA8-0005G9-Uv; Mon, 27 Apr 2026 02:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFA6-0005FM-Vb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:43 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFA4-0000ly-TY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:42 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so8441111a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270179; x=1777874979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GSIlnxrsZSBNFgRWz5hkc0UzpRhGNiXWyxmxkH9cRX4=;
 b=A4/KGOZY2qzCBwwh1iL5w3iVqPncbFEzHHssDaUyKx0WsazyMq0tcvp/KlqOcQ10WZ
 WG6Xxf85duG7us3P7qFcVybx22O5bTPPBNLS4pXrqsBc0Coa5R4NbVTFUZcDJVwRXXE/
 RUqFyP6EwHwz3OQxeGvzJId/uoqk9/qmjDY5rt0CuZkB225USkHRR/izIOfcU6BWaYSj
 oI1na/Q3aFezRCeEbMbG46hF0bgs6A+JT7zZxJUYK4rUhso/n/8/1usNqTgB327mb6oV
 yRWCVw1wAWRs+nc/Rx+3sbbLlBYNi/2JP/9bOGhsBen4UevzmZrFwSHJ63CxPRtW6xtN
 DCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270179; x=1777874979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSIlnxrsZSBNFgRWz5hkc0UzpRhGNiXWyxmxkH9cRX4=;
 b=VdNS7PpKaukc8irjtP6Z+72pU/VNSkvhV1viHKaGTfLOBtHOozTkeTwBwNFZvQEwli
 Nzu0l4u675YGQaxEv03fxEJcV0d+C9tyUBVEq7FHFCWLhXFugKK836u12NYMtO2/MXqc
 XK5XdUHa5tWqGK/P3KmDP8VnkFlcSy7XAhRWs5lj6H0UGZrhPQejlY2nfa9wRbbNeVX1
 CIAwSw2awk/sWb/hDToqVlWQTCDMh3J8k/TnK4MN5WsCPl974UAuTKCkhkgg7ms4eGWY
 vgtjv1TzGATN+RFCNdBiFQFikZ8umyQv6h7aRMyMnHPAcJ7GIilXTavChhuIzvD+SlRg
 Px1w==
X-Gm-Message-State: AOJu0YxD+ld26QhMCeARCcJIraU4GHhEf0meng/XyAiY0/5W94oOlm36
 GnJsuppgh5pusX23i3oajDCql6BbI/gLgwEISOoV2/1rW7LvZRGoBBKTQhnTFbvWs0cd8KcYw4f
 dFVNVG806TezWN8lDSktFy9q61FhPTJ2YhU7IsTD5B9q6ON+NStdq310LbhptX9AxlIHybw8Y9O
 cQBeMFCq3iRzLK7O1QLRVbB69PLg0E+4q0abOHreU=
X-Gm-Gg: AeBDietVYCeNTGLGqOSD8iUIWxZamciToZe9KI5qofpxWGe6tidnFDl9JIphV/MYlGb
 hlYUhIN5LGDAz9zsNNY5h1SkivJurk+1bWz0UiiFAtrbWCohQ65si9krvXSufq5NGAfQ/IKBEpJ
 R0pGkP8ySkW12Cw6Cw/tLlQwX4nJtyml4ENS35NJMstYpUCRr4urItTjsLY/nQtwINZe1mJek9L
 n7t6vAmV1tTkMGqRyT3SGdaIRmp8Bg37pOu+OiDxeVEE46LEY1lHSXJBhwyxQzMauCau9TysClb
 Y+f03SpjDw+OfOeLUbE3hlZ04podom0idXZwPh0JQU2ttxHojsxsvqi8iFghUWeTAQP00MAcXKC
 1nOTMvdoUbWwp0qllYowtOjX8HGZQoHkVSidWNbIa5DyC9MXafXShV+k6ye42u9XrSi4vrKHv5f
 z1Qmc4kmBebtThhA6UWyhoW6sQQWOirvlKnjbX5SStprmXDygGzjLoMDzJ+uPL8DXyO+GEDmPRa
 hg4M8vwA2We+6GDx/XfR9Xhq+1djqTt2TC8sg==
X-Received: by 2002:a17:90b:3941:b0:364:7467:53e5 with SMTP id
 98e67ed59e1d1-3647467557bmr3487397a91.2.1777270178484; 
 Sun, 26 Apr 2026 23:09:38 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:38 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 0/9] target/riscv: Add RISC-V Zvfofp8min extension support
Date: Mon, 27 Apr 2026 14:09:19 +0800
Message-ID: <20260427060928.2322570-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1034.google.com
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

This patchset adds support for the RISC-V Zvfofp8min isa extension that
provide conversion operations for OCP FP formats.

* riscv-isa-manual tag: https://github.com/riscv/riscv-isa-manual/releases/tag/zvfofp8min-0.9

Zvfofp8min (v0.9):
  The Zvfofp8min extension provides minimal vector conversion support
  for OFP8 formats. It requires the Zve32f extension and leverages the
  altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
  E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
  - Canonical NaN for both E4M3 and E5M2 is 0x7f
  - All NaNs are treated as quiet NaNs
  Instructions added/extended:
  - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
  - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
  - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
  - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
  - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)

Changes in v5
- Drop Zvfofp4min which is not going through the RVIA ratification
  process yet.
- Fix typos.
- Rebase on riscv-to-apply.next (commit bf76a00)

Chagnes in v4
- Rebase on riscv-to-apply.next (commit 21101a7)
- Remove the softfloat library related patches (Thanks for RH's help to
  split this part)
- Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
  patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
  conversion for Zvfofp8min extension)

Changes in v3
- Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
  in patch 2 & 3
- Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers

Changes in v2
- Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
- Added new v2 patch 2 to refactor the IEEE format NaN classification
  functions (float16, bfloat16, float32, float64) to use internal helper
  functions, reducing code duplication and improving maintainability.
  The OCP FP8 NaN classification functions follow the same pattern.
- Refactored softfloat implementation to use capability-based FloatFmt
  flags (no_infinity, limited_nan, overflow_raises_invalid, normal_frac_max)
  instead of monolithic flags
- Removed ocp_fp8e5m2_no_signal_nan and ocp_fp8_same_canonical_nan flags
  from float_status; now using local float_status with no_signaling_nans
  and default_nan_pattern for RISC-V Zvfofp8min instructions
- Rebased on latest riscv-to-apply.next with zvfbfa v3 patchset

v4: <20260304134006.2908449-1-max.chou@sifive.com>
v3: <20260204051756.667397-1-max.chou@sifive.com>
v2: <20260127063723.442734-1-max.chou@sifive.com>
v1: <20260108151650.16329-1-max.chou@sifive.com>

References
* OCP FP8 specification:
  https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1


Max Chou (9):
  target/riscv: rvv: Fix NOP_UU_B vs2 width
  target/riscv: Add cfg property for Zvfofp8min extension
  target/riscv: Add implied rules for Zvfofp8min extension
  target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
    conversion for Zvfofp8min extension
  target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
    conversion for Zvfofp8min extension
  target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
    extension
  target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
    for Zvfofp8min extension
  target/riscv: Expose Zvfofp8min property
  disas/riscv: Add support of Zvfofp8min extension

 disas/riscv.c                              |   9 ++
 target/riscv/cpu.c                         |  15 ++-
 target/riscv/cpu_cfg_fields.h.inc          |   1 +
 target/riscv/helper.h                      |  12 +++
 target/riscv/insn32.decode                 |   5 +
 target/riscv/insn_trans/trans_rvbf16.c.inc |  32 +++++--
 target/riscv/insn_trans/trans_rvofp8.c.inc | 105 +++++++++++++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++++++
 target/riscv/tcg/tcg-cpu.c                 |   5 +
 target/riscv/translate.c                   |   1 +
 target/riscv/vector_helper.c               | 104 +++++++++++++++++++-
 11 files changed, 315 insertions(+), 13 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc

-- 
2.52.0


