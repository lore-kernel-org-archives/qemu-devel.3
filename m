Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFF4D2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkchj-0002kj-IU; Tue, 27 Jan 2026 01:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchh-0002kO-6B
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:33 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkche-0006fz-V0
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:32 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81ed3e6b8e3so2517125b3a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495849; x=1770100649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FAKDkpGIGDBnyprFVYzUuCpyHXCwWeL8Xv+x1RwnT6w=;
 b=SNvGCw3n8OneT+j4o/HuI1nTOUTPNE4L/g2q19w3Dw9FM/Su93gCgm2+HPxKs4Nev/
 IvahzuGoDLBatJZlgvhpEz97aemkUHWsLJL0aaYafuucxQf4uoq2ZIYxGIN2k6ZqGJky
 7D7g5yUG/cjxaqnF66+d9tq3GEnCtO502AbhWTTzxQmZPlDfIjt61CalvtA4yaCMFcKZ
 Yr2u+tzugi7D37YG5Jpd7EjiU51vpPda5TxXHwyWMYtC5rpi5BqUPZkQgrXVnNcabXgu
 S7tSlbk5VanqIA9CyrLBBPrVnbTejxPAJwqFxKV07dXWuSz+2/9jzzomHjMpiM/+zFg5
 L9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495849; x=1770100649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAKDkpGIGDBnyprFVYzUuCpyHXCwWeL8Xv+x1RwnT6w=;
 b=ZTxTTA4+s8gBMsoxsjJ4njsphhqtCRdyYpzTrEa4L2FonzqWUUC03V7LFXo4TQj+9k
 7jqMkuk67TjdWQKGyGMVRb7kkP21ImVFokFqLQysuvTVSqjEpJZKg+OLAFY9gNZ9yUo6
 KZzLZFQEmrFzu5ZByA9NpA9otB8izz0RYfSfezecll48EabqPxmNxsCUvI/JufshDM0J
 G0WAtijTzqGF47Ky4KP2jVlx2HZvMEVnGl3XcsdgDplivZ/+GJB2oTkZK/0mDGyO43p3
 orslQa2D837KuJqFrIx/T1U84bBxo70vrJesU76wUV6bxifAyFsJT717Z3DQrr9oEEyT
 FyZQ==
X-Gm-Message-State: AOJu0YzW04moLN75q/gdB5a6T+wnM/gwU0MpAqQPZXnnkHW5K11XHhKc
 qLgW0SzCZOEB6Fn0XH/JDBqOv+Asl6Arlialv46Hsp9UsHjpcG5NWwwDeCGchG/a55ZFNVcKf82
 DbsqNHBBqwgTN+aQD/D8fAaE8RGudVeN8cpWl2B71q+VSAj/dM5NjryXcG6W8uhf7s0ejwIa6gm
 yMuuaLas3MIekHHRYQtw1AgBTjxnfQ91+gKJGiBVLsDQ==
X-Gm-Gg: AZuq6aJuoKkaN5Uz0+ZKK4QmWTDsO1yDNMBTgQeMhATfRRglWUNrnMukm51h5JFwxQM
 9c5kchLe2jbdo2LwhR46813+bR0mBznjrljxpSoEACgNHcqkfjLtc2XLNktESnrY3baF1qnupMK
 5Y/x6HahYcEo9JUOQEHit6xBvp7KIlt52PR3MTr4iCnGcjxj5OlbWcCw6Nmvxv+P0ZcLocPL79B
 vbGOxClTEWOrvwbwMLyvoJeQOT9YfcPSNzqhDom4X0POscYhOJYmMVtK92bPxnyopzLHjHo7zjj
 9Rhq3KxuhH/U/MEJcgoqp3gdRDvQsv5r22BdvuDG2t4qKNPmUMkxGqa5NmwXQQCN0+SyYIY9Ax7
 XWGmZY0CMNhoodC+KLHTT5bR7GsJsWsPSCwO0cm4MbMS25JFSUBAf5tk8DO5SOK5wK5uz36ivuE
 VSx1OVfXaA34eF7RFP0k365BH3/IOf7lFNACUmyrNPIzzeBEswlEePZyB9PVtN40E1RVlihxek7
 2qS6ybuwNTD+Fw=
X-Received: by 2002:a05:6a20:1589:b0:364:be7:6ffc with SMTP id
 adf61e73a8af0-38ec62c71bemr680057637.18.1769495849092; 
 Mon, 26 Jan 2026 22:37:29 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:28 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 00/17] Add OCP FP8/FP4 and RISC-V Zvfofp8min/Zvfofp4min
 extension support
Date: Tue, 27 Jan 2026 14:37:06 +0800
Message-ID: <20260127063723.442734-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
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

This patchset adds support for the OCP (Open Compute Project) 8-bit and
4-bit floating-point formats, along with the RISC-V Zvfofp8min and
Zvfofp4min vector extensions that provide conversion operations for
these formats.

OCP Floating-Point Formats
* The OCP FP8 specification defines two 8-bit floating-point formats:
  - E4M3: 4-bit exponent, 3-bit mantissa
    * No infinity representation; only 0x7f and 0xff are NaN
  - E5M2: 5-bit exponent, 2-bit mantissa
    * IEEE-like format with infinity representation
    * Multiple NaN encodings supported
* The OCP FP4 specification defines the E2M1 format:
  - E2M1: 2-bit exponent, 1-bit mantissa
    * No NaN representation

RISC-V ISA Extensions
* Zvfofp8min (Version 0.2.1):
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

* Zvfofp4min (Version 0.1):
  The Zvfofp4min extension provides minimal vector conversion support
  for the OFP4 E2M1 format. It requires the Zve32f extension.
  Instructions added:
  - vfext.vf2: OFP4 E2M1 to OFP8 E4M3 widening conversion

Modifications
* Softfloat library:
  - Refactored IEEE format NaN classification to share code (new in v2)
  - New float8_e4m3 and float8_e5m2 types with NaN checking functions
  - New float4_e2m1 type for OFP4 support
  - Conversion functions: bfloat16/float32 <-> float8_e4m3/float8_e5m2
  - Conversion function: float4_e2m1 -> float8_e4m3
  - Implementation uses capability-based FloatFmt flags for format behavior
* RISC-V target:
  - CPU configuration properties for Zvfofp8min and Zvfofp4min
  - Extension implied rules (Zvfofp8min requires Zve32f and Zvfbfa)
  - Vector helper functions for OFP8/OFP4 conversion instructions
  - Disassembler support for new instructions

Changes in v2:
= Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
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

References
* OCP FP8 specification:
  https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
* Zvfofp8min specification (v0.2.1 commit e1e20a7):
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp8min.adoc
* Zvfofp4min specification (v0.1 commit e1e20a7):
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp4min.adoc

PS: This series depends on the Zvfbfa extension patchset which introduces:
  - The altfmt field in VTYPE CSR
  - BF16 vector operations infrastructure
  - vfwcvtbf16.f.f.v and vfncvtbf16.f.f.w base instructions

v1: <20260108151650.16329-1-max.chou@sifive.com>

Based-on: 20260127014227.406653-1-max.chou@sifive.com

Max Chou (17):
  target/riscv: rvv: Fix NOP_UU_B vs2 width
  fpu/softfloat: Refactor IEEE format NaN classification to share code
  fpu/softfloat: Support OCP(Open Compute Project) OFP8 data type
  fpu/softfloat: Support OCP(Open Compute Project) OFP4 data type
  target/riscv: Add cfg properity for Zvfofp8min extension
  target/riscv: Add implied rules for Zvfofp8min extension
  target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
    conversion for Zvfofp8min extension
  target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
    conversion for Zvfofp8min extension
  target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
    extension
  target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
    for Zvfofp8min extension
  target/riscv: Expose Zvfofp8min properity
  disas/riscv: Add support of Zvfofp8min extension
  target/riscv: Add cfg properity for Zvfofp4min extension
  target/riscv: Add implied rules for Zvfofp4min extension
  target/riscv: rvv: Add vfext.vf2 instruction for Zvfofp4min extension
  target/riscv: Expose Zvfofp4min properity
  disas/riscv: Add support of Zvfofp4min extension

 disas/riscv.c                              |  12 ++
 fpu/softfloat-parts.c.inc                  | 159 ++++++++++++---
 fpu/softfloat-specialize.c.inc             | 227 ++++++++++++++-------
 fpu/softfloat.c                            | 220 +++++++++++++++++++-
 include/fpu/softfloat-types.h              |  17 ++
 include/fpu/softfloat.h                    | 124 +++++++++++
 target/riscv/cpu.c                         |  32 ++-
 target/riscv/cpu_cfg_fields.h.inc          |   2 +
 target/riscv/helper.h                      |  15 ++
 target/riscv/insn32.decode                 |   8 +
 target/riscv/insn_trans/trans_rvbf16.c.inc |  32 ++-
 target/riscv/insn_trans/trans_rvofp4.c.inc |  44 ++++
 target/riscv/insn_trans/trans_rvofp8.c.inc | 106 ++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++
 target/riscv/tcg/tcg-cpu.c                 |  10 +
 target/riscv/translate.c                   |   2 +
 target/riscv/vector_helper.c               | 135 +++++++++++-
 17 files changed, 1059 insertions(+), 125 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc

-- 
2.52.0


