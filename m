Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79EDEF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTF-0007Au-PM; Wed, 04 Mar 2026 08:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSf-0006zk-L1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:32 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSd-0005Ej-5b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:25 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8274936d2c0so6721658b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631621; x=1773236421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hP7xEkb4ELGEo/ImdlCdItanx/FbJZc9ggfIwWtD++Q=;
 b=W/8oisXs2iGmhMkoblXAKjjid45RwQA7psDZoWqYqo1JzhcbEMVdktwX5RaSYit62n
 2mujRmLiqfI92EosgctxpV7hd7lQOHv8RHW1Yswq/Gtu+18cl4WCGAs2IV0CwQ43ddZU
 Gy0BsRyqs+3S5n2uWKRpPHh1Ye0H6owFo8m6/mzzx1qL7QzTjpARSyzJELukQl5E3CuL
 g5nCmrrH3vlpROYaTyfLOazxbhVzQwHnx0SAmLvQI/R4Y8ClCKOoaoLbQBvMwtKFkWtM
 ubwheQ8hQKnpCnm9huIj0MU5h4icUS6X/5Q6kePeYvje9PemzkYI+8yebVyBhpPTfv6w
 5rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631621; x=1773236421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP7xEkb4ELGEo/ImdlCdItanx/FbJZc9ggfIwWtD++Q=;
 b=jBJZwsfTxO72LWKrJm9VWLtcNIYganGsomP1XvQWwO1vRpfujHf8XSX4HmhOvpKcmO
 xqeFJmLtUgnRoFfqi2waoccTvKZoXbwcLDdHJ9R0TIZOyStcmZjjxZPiA7NpkzjIcYKv
 DVowxtOWXC5AQtFYOsHDmoQdHulDWHdVeoOoZJD8tqBbdRZvM4rlcva264zqs2D7xQMA
 dirTFo+M0s1JNrQ6MDK2LLT5hvcGh/ca6UGKGrs5x1zQlaOIJXavy8gi/CJvVgJOmGHS
 9h71se8jefKWByT+5hRURZ7xfJxj4x5A1HR2P+sIQfOBOtercVQQIbC8L4iFpQQ8YqcA
 aBDA==
X-Gm-Message-State: AOJu0YygSLlbeCbjOnLa5/6dJXvmwMbBxNc01KM03C0OEp/3ePzKs0+L
 nSV/JLfGNXUtz1gFHuxOGmwPG00l+QELlnU3n5KoWoMNHcP0VfthKjl6vxOLvP1+t1Im7Gc/w3X
 1sPhS86L08Vf21eWf2DnhFh2pvf/gHYMNu8iUqN2xGer3RaCzoxFSa3vE2wwGRES8lInOItbv5F
 ekbN75Vndxpt82Vk0jI6h2r3AnksUhewG9pTtQSUOf+g==
X-Gm-Gg: ATEYQzzAuDDK3KU9mpPsWTxgHdwTY6PlupC85NIW8Wz1sTBjuupECOmdAzay4zmqS3W
 cBqadt6c9EENSPRQYG4q5TaJABEMGHUZ/6Sfi/WIAgUdxPLhqF59d5rUbC3VAcpDNVEFIAGgBfM
 WMK8cx4tkbB6rn/P8mAGx1lZ4qly36zW1OqOjaaSo+tFPoEwGIHpAA55RA3X1xRQNSkCH82ymar
 fdP00bxuRAyoiv8YRtY5vR5PkYz1t8H1dllrx8m5t5m7a2qhCGZwQ587OFBvlQOP4UbCA2RbeGs
 K+uHaLk79vtSn1vmGgfMu4xs7CNfLsphgwFZv2G5/WVbgW8xge5F5XIBGNwQxBZAAIA4aSHIzLp
 4QDsoUQ+WIGgexkNrGIi0QDUaqqKwXWwhwmLSpt80jVyqWO9KGq7p6BltcWFoFb+3j7JS0yeH5F
 DpFpoSkAYfbesxqGbGqa++gOCOPRMUsgPihh0cQDV1bSy5xC1Vpmru9aEtGDbHbnj0tO7Mzus7u
 800/GYjhvO4XRHGjMF/zOw2oOE=
X-Received: by 2002:a05:6a00:92a0:b0:81f:8387:53a7 with SMTP id
 d2e1a72fcca58-82972c63ae3mr2206264b3a.40.1772631620307; 
 Wed, 04 Mar 2026 05:40:20 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:19 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 00/14] Add OCP FP8/FP4 and RISC-V Zvfofp8min/Zvfofp4min
 extension support
Date: Wed,  4 Mar 2026 21:39:52 +0800
Message-ID: <20260304134006.2908449-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
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

This patchset adds support for the RISC-V Zvfofp8min and Zvfofp4min isa
extensions that provide conversion operations for OCP FP8/FP4 formats.

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

v3: <20260204051756.667397-1-max.chou@sifive.com>
v2: <20260127063723.442734-1-max.chou@sifive.com>
v1: <20260108151650.16329-1-max.chou@sifive.com>

References
* OCP FP8 specification:
  https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
* Zvfofp8min specification (v0.2.1 commit e1e20a7):
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp8min.adoc
* Zvfofp4min specification (v0.1 commit e1e20a7):
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp4min.adoc

Based-on: <20260304132514.2889449-1-max.chou@sifive.com>
([v4,0/9] Add Zvfbfa extension support)
Based-on: <20260226071817.1417875-1-max.chou@sifive.com>
([v2,0/2] fpu: Fix OCP FP8 E4M3 conversion issues)

rnax


Max Chou (14):
  target/riscv: rvv: Fix NOP_UU_B vs2 width
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
 target/riscv/cpu.c                         |  29 ++++-
 target/riscv/cpu_cfg_fields.h.inc          |   2 +
 target/riscv/helper.h                      |  15 +++
 target/riscv/insn32.decode                 |   8 ++
 target/riscv/insn_trans/trans_rvbf16.c.inc |  32 +++--
 target/riscv/insn_trans/trans_rvofp4.c.inc |  43 +++++++
 target/riscv/insn_trans/trans_rvofp8.c.inc | 105 ++++++++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++++
 target/riscv/tcg/tcg-cpu.c                 |  10 ++
 target/riscv/translate.c                   |   2 +
 target/riscv/vector_helper.c               | 137 ++++++++++++++++++++-
 12 files changed, 421 insertions(+), 13 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc

-- 
2.52.0


