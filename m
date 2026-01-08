Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437B8D1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrl1-0000i3-7S; Thu, 08 Jan 2026 10:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrky-0000aU-Aq
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:00 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrkw-0003Fb-88
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:00 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso3573632b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885416; x=1768490216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W70TEI13sFZN3wMttx5Ga5KvzSN37elQyVYzPJvoqAM=;
 b=h+1wEdPIKr7pkLPWOeAN6SjjdCumSR8t7p9lK3xIDPS24PZJKOhTqXnSnLimRCbZ2P
 rPnQQSjPGpOi4fIRrU/mAlGXXpGhCYBQ+GFePF1SobRXULE0TBucXc4WK4L0ENEJRPgn
 qH1oJhlgkJfjAAxfwUhxM106J44mBfEmwqS9KKIOM03ztB+1pddG1XET0nf235exoet8
 H2Q4fFtprOANSp1uTMHyyi+bDTVjGZQiSIaf6HrzucdR44nSBGyWe841/FU7glw1KSFC
 m9YbF9+Pk84sa3ju0zYG63mH+r15uTu9gXY0A5nDOY1gaOeHczb/Xm3cICWyLn5XKY4E
 Sfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885416; x=1768490216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W70TEI13sFZN3wMttx5Ga5KvzSN37elQyVYzPJvoqAM=;
 b=aWksc6H4OzGGiyjHGajxP2pq3U5hWO4yEdgB2N3zFv3AvM2giRIQyXVp/OVby7nxro
 ah5DrDtLWFE96B1SP2vTxEmTDANuXclFK6URDPl8dZTQtUEFYYjoFJmjAPsZ/s1Pkmep
 yXljivgM9Erd+AO9HRJ6EVyk2MhmgvRH3hVYqSpkJlD4JKllVvfvsfkF7tYREVv6r/uw
 8vPWz4GAs0Bl5N3UrC5FGqpbXRoznllpUAoK7FihqumuctRDVAC/FSbm0P+Vhwv0xUrI
 hKRMqNAVa+b43OJSaF6so6mNA1FDkhuEo04rmTrI6FEO2Fi/XFh0AqdB4jaSAXex56kn
 vF4A==
X-Gm-Message-State: AOJu0Yz9RfgExN2DpCEo2TZuV9aBUID0UUUIpDpYzl3gyYgI5j/AkklS
 HECprIyRBW7prqY9EX/xjCinluq9mOmZ/uxO3wpTH99KFAsYfeb22fO4tJh3tyiBvizj+e2ubaa
 Xh4o3T7PF0M87/jkLe/L94+S0iVI3/J8c1KqHzLvT92ltQ2yowYN60LvMmPl8SvmbW/+MPCSaaJ
 XpufURxBhpgNFfYCXfAGtC5hAOuoIQG+wp5W96Dpo=
X-Gm-Gg: AY/fxX7n5GkEdUdTj/PvlSJKglQk5egO0C7TjBukGgwzw+8PMB1K71vBT8tjJGs+gfj
 YEQbjiPvhs1UXLEWN8cFY8crLLTTsyjqD+0/gWuy+AFvSdS3vMF1uhe11qAAU5v6eafYl/+IwPz
 yMntI0Mogfynl8fRdHuacTqSSRRmIAjphdDt0fTYGU4u5pu1dIMycFTGROsu5BQuwc9xwrcXr8i
 he57pziP+q0yRWWONnPj422bGFoOTvJrXKJkYG31EHAtQlWpjLbVczme4PB6SugMZG87E3g3vrC
 iqJ3AU0V5o2sR8j9RdERGTsbwM5KutWq6FH3uJvZ3lgHDL0bpHB6JZHg3lsPFpEUYjPST8egpW6
 gQ8LO/lp/a8wXzj52VJZYIIZ4aRr8R+I+Yg0VbEpht/HxFbRBWTNY6xjMyw6lRxtYsQsBH1VwXJ
 qAIi3bUnlRMBfpK7xthogQiz5YpeNOQWB3u5EscBfS9NCuLGiWYcSOrb0=
X-Google-Smtp-Source: AGHT+IEBKu1MN/dSTWgjXQpght8xOwQZLaHo3Uue5okacR4xQ/nUuhlm0GOdZMHvDBCQ6CI92qi7EA==
X-Received: by 2002:a05:6a00:770f:b0:81c:4a92:25a2 with SMTP id
 d2e1a72fcca58-81c4a922872mr3283597b3a.46.1767885416062; 
 Thu, 08 Jan 2026 07:16:56 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:16:55 -0800 (PST)
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 00/18] Add OCP FP8/FP4 and RISC-V Zvfofp8min/Zvfofp4min
 extension support
Date: Thu,  8 Jan 2026 23:16:31 +0800
Message-ID: <20260108151650.16329-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
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
List-Id: <qemu-devel.nongnu.org>
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
  - New float8_e4m3 and float8_e5m2 types with NaN checking functions
  - New float4_e2m1 type for OFP4 support
  - Conversion functions: bfloat16/float32 <-> float8_e4m3/float8_e5m2
  - Conversion function: float4_e2m1 -> float8_e4m3
  - Implementation-defined behavior flags in float_status:
    * ocp_fp8e5m2_no_signal_nan: Treat all E5M2 NaNs as quiet
    * ocp_fp8_same_canonical_nan: Use 0x7f as canonical NaN for all OFP8
* RISC-V target:
  - CPU configuration properties for Zvfofp8min and Zvfofp4min
  - Extension implied rules (Zvfofp8min requires Zve32f and Zvfbfa)
  - Vector helper functions for OFP8/OFP4 conversion instructions
  - Disassembler support for new instructions

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

Based-on: 20260108132631.9429-1-max.chou@sifive.com

Max Chou (18):
  target/riscv: rvv: Fix NOP_UU_B vs2 width
  fpu/softfloat: Add OCP(Open Compute Project) OFP8 data type
  fpu/softfloat: Add convert operations(bf16, fp32) for OFP8 data types
  fpu/softfloat: Add OCP(Open Compute Project) OFP4 data type
  fpu/softfloat: Add OCP FP4 E2M1 to OCP FP8 E4M3 convert operation
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

 disas/riscv.c                              |  12 +
 fpu/softfloat-parts.c.inc                  |  77 +++++-
 fpu/softfloat-specialize.c.inc             |  57 ++++-
 fpu/softfloat.c                            | 274 +++++++++++++++++++++
 include/fpu/softfloat-helpers.h            |  20 ++
 include/fpu/softfloat-types.h              |  28 +++
 include/fpu/softfloat.h                    | 124 ++++++++++
 target/riscv/cpu.c                         |  35 ++-
 target/riscv/cpu_cfg_fields.h.inc          |   2 +
 target/riscv/helper.h                      |  15 ++
 target/riscv/insn32.decode                 |   8 +
 target/riscv/insn_trans/trans_rvbf16.c.inc |  32 ++-
 target/riscv/insn_trans/trans_rvofp4.c.inc |  54 ++++
 target/riscv/insn_trans/trans_rvofp8.c.inc | 115 +++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    |  39 +++
 target/riscv/tcg/tcg-cpu.c                 |  15 ++
 target/riscv/translate.c                   |   2 +
 target/riscv/vector_helper.c               | 131 +++++++++-
 18 files changed, 1022 insertions(+), 18 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc

-- 
2.43.7


