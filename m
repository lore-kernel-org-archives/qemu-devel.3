Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03350E9D40F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngER-0002Qp-8E; Wed, 04 Feb 2026 11:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vngEP-0002QS-Ds
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:59:57 -0500
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vngEN-0006xa-Ds
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:59:57 -0500
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so10024922eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770224394; x=1770829194; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0EvO5S2fGDXgutvQ5wLQrVcDRVCihdG/kVqHHErhiZo=;
 b=e1c1pQE9KiZ3RDz3J1NMwV4ASnc3IWLkP2nAmtVzbU/oG6Gh+Pihgchmrkme/Pldzw
 rm2Fv9i3qaUUnxcv9+0jHZV4SHnMOHUjZtYVxUoy0mVwnrfbcIW4DXvCp7uEPfUg6Zg5
 o/zDI6iVK5yvDq9wV/lH5+ZkfZ6lbplJiCOFBq8Dz3jqopD2fhomHxuaUHrsTScGuoI8
 Y2aXolMZ5ST2Kgx4ThFKfGbnzwdqAhbvaK1z4QLfbOmk4AKcxCyouv6UUvQyCAhxk8Az
 o3/9OjuH7F2ZCZTP2I3HCNa1S7qJjoSFMnxGvGEj8p28kd+j5Vs7wFKZJNC09dbtvspt
 GatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770224394; x=1770829194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EvO5S2fGDXgutvQ5wLQrVcDRVCihdG/kVqHHErhiZo=;
 b=CgdBEdDMM5mFbWmdfqo71OkpwZHjr+xMYlF9IJk2/Y2NbCJ2Pz/HfbvkmPy+5k1Ek0
 d4Z7dl5veztKtMypxwpvbh33jy6lupwY66qa9W/PbasFNpaxITpdlDsDl5y0e56CiPzH
 jA+7jON2fWXu58pWgIVeDejzy5joJZel0woNgzKfLtwNI3E/HYcneBhrtLy1GXurrjK+
 jMZ68xKZCjWuIoVwyHqMmGH7Ppo7V9dDxruRaIYhzYyBSrCimHVNOA2TMcuOy4MfmRPl
 kBLf0BtErv9/GFbDriFlOLprB5e99d0a85KbyB/zZi+bRoMnl7XmT7A34YJ9L55a1zF5
 2PIQ==
X-Gm-Message-State: AOJu0Yw7hwCZ27RBEhQkFsMqzwkERpBc1RBKHkNrqK3Wn4DOs/gHPZLI
 DtriPx4p0W/PPpm4Us6XBp5jTlz19aene1FdHyJDUi++NWWwpGWg3XyY
X-Gm-Gg: AZuq6aIZMiWk9JNipkqZEKTXdG4tqwtBy0otx670kQNCcEifxLvbO8ta8nLcx5dGjii
 0OZef0+QfzlXl5q1M29GabSuuTYXDC4YXbprtESfysXJGzHrABLPdMalACVCt/L5sqblKhT5jo9
 hMDglzKbDnv3GQrASGDkpfWLP2gcQOTM064HMdraL4EPTf71sA6kVD63W5Jgiofd9NVTVcQ1BQi
 EvvStthpBbTldTJHecU0suTE1JCiM7fS2631SKlqPo6pjxaDTkd19F8if0i1P5idgEvPoA5G737
 a3KSX0dyhDWCQO44f15XS2SV/KnRbBO4G/lTxyyoD6sPOspgwVtr6vsCqXgMdLyz+urqaILDWbl
 zk2qdJMy2vcFMerTL8uDIsrHXLPI6jS84swKO1T+9b4qljJSTlp8IIqY5ZIbtw1B1nw7QbzOKVM
 ilSd6EawZrH7aICV6C1yfZwbyj/+wsU7ZGeMpKyZz7aVukSOwglPcR3aOAk07Ta+f86E4o4+jrS
 tElCyP2xPvXw4QDNIE=
X-Received: by 2002:a05:7300:3212:b0:2a4:630b:c789 with SMTP id
 5a478bee46e88-2b832a40be5mr1437035eec.37.1770224393498; 
 Wed, 04 Feb 2026 08:59:53 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-126f503d0fbsm2239958c88.13.2026.02.04.08.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:59:53 -0800 (PST)
Date: Thu, 5 Feb 2026 00:59:40 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 00/19] Add OCP FP8/FP4 and RISC-V
 Zvfofp8min/Zvfofp4min extension support
Message-ID: <aYN6l-wqLutdOOSh@ZEVORN-PC.localdomain>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
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

Hi Max,

On Wed, Feb 04, 2026 at 01:17:36PM +0800, Max Chou wrote:
> This patchset adds support for the OCP (Open Compute Project) 8-bit and
> 4-bit floating-point formats, along with the RISC-V Zvfofp8min and
> Zvfofp4min vector extensions that provide conversion operations for
> these formats.
> 
> OCP Floating-Point Formats
> * The OCP FP8 specification defines two 8-bit floating-point formats:
>   - E4M3: 4-bit exponent, 3-bit mantissa
>     * No infinity representation; only 0x7f and 0xff are NaN
>   - E5M2: 5-bit exponent, 2-bit mantissa
>     * IEEE-like format with infinity representation
>     * Multiple NaN encodings supported
> * The OCP FP4 specification defines the E2M1 format:
>   - E2M1: 2-bit exponent, 1-bit mantissa
>     * No NaN representation
> 
> RISC-V ISA Extensions
> * Zvfofp8min (Version 0.2.1):
>   The Zvfofp8min extension provides minimal vector conversion support
>   for OFP8 formats. It requires the Zve32f extension and leverages the
>   altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
>   E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
>   - Canonical NaN for both E4M3 and E5M2 is 0x7f
>   - All NaNs are treated as quiet NaNs
>   Instructions added/extended:
>   - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
>   - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
>   - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
>   - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
>   - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)
> 
> * Zvfofp4min (Version 0.1):
>   The Zvfofp4min extension provides minimal vector conversion support
>   for the OFP4 E2M1 format. It requires the Zve32f extension.
>   Instructions added:
>   - vfext.vf2: OFP4 E2M1 to OFP8 E4M3 widening conversion
> 
> Modifications
> * Softfloat library:
>   - Refactored IEEE format NaN classification to share code (new in v2)
>   - New float8_e4m3 and float8_e5m2 types with NaN checking functions
>   - New float4_e2m1 type for OFP4 support
>   - Conversion functions: bfloat16/float32 <-> float8_e4m3/float8_e5m2
>   - Conversion function: float4_e2m1 -> float8_e4m3
>   - Implementation uses capability-based FloatFmt flags for format behavior
> * RISC-V target:
>   - CPU configuration properties for Zvfofp8min and Zvfofp4min
>   - Extension implied rules (Zvfofp8min requires Zve32f and Zvfbfa)
>   - Vector helper functions for OFP8/OFP4 conversion instructions
>   - Disassembler support for new instructions
> 
> Changes in v3:
> - Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
>   in patch 2 & 3
> - Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
> 
Thanks for the v3 series.

I have also noted a few minor issues and replied to the relevant patch
emails individually.

Everything else looks good to me.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

> Changes in v2:
> - Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
> - Added new v2 patch 2 to refactor the IEEE format NaN classification
>   functions (float16, bfloat16, float32, float64) to use internal helper
>   functions, reducing code duplication and improving maintainability.
>   The OCP FP8 NaN classification functions follow the same pattern.
> - Refactored softfloat implementation to use capability-based FloatFmt
>   flags (no_infinity, limited_nan, overflow_raises_invalid, normal_frac_max)
>   instead of monolithic flags
> - Removed ocp_fp8e5m2_no_signal_nan and ocp_fp8_same_canonical_nan flags
>   from float_status; now using local float_status with no_signaling_nans
>   and default_nan_pattern for RISC-V Zvfofp8min instructions
> - Rebased on latest riscv-to-apply.next with zvfbfa v3 patchset
> 
> References
> * OCP FP8 specification:
>   https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
> * Zvfofp8min specification (v0.2.1 commit e1e20a7):
>   https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp8min.adoc
> * Zvfofp4min specification (v0.1 commit e1e20a7):
>   https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp4min.adoc
> 
> PS: This series depends on the Zvfbfa extension patchset which introduces:
>   - The altfmt field in VTYPE CSR
>   - BF16 vector operations infrastructure
>   - vfwcvtbf16.f.f.v and vfncvtbf16.f.f.w base instructions
> 
> v2: <20260127063723.442734-1-max.chou@sifive.com>
> v1: <20260108151650.16329-1-max.chou@sifive.com>
> 
> Based-on: <20260127014227.406653-1-max.chou@sifive.com>
> 
> Max Chou (19):
>   target/riscv: rvv: Fix NOP_UU_B vs2 width
>   fpu/softfloat: Refactor IEEE format NaN classification to share code
>   fpu/softfloat: Refactor floatx80 format NaN classification to share
>     code
>   target/i386: Fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
>   fpu/softfloat: Support OCP(Open Compute Project) OFP8 data type
>   fpu/softfloat: Support OCP(Open Compute Project) OFP4 data type
>   target/riscv: Add cfg properity for Zvfofp8min extension
>   target/riscv: Add implied rules for Zvfofp8min extension
>   target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
>     extension
>   target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
>     for Zvfofp8min extension
>   target/riscv: Expose Zvfofp8min properity
>   disas/riscv: Add support of Zvfofp8min extension
>   target/riscv: Add cfg properity for Zvfofp4min extension
>   target/riscv: Add implied rules for Zvfofp4min extension
>   target/riscv: rvv: Add vfext.vf2 instruction for Zvfofp4min extension
>   target/riscv: Expose Zvfofp4min properity
>   disas/riscv: Add support of Zvfofp4min extension
> 
>  disas/riscv.c                              |  12 +
>  fpu/softfloat-parts.c.inc                  | 159 +++++++++---
>  fpu/softfloat-specialize.c.inc             | 287 +++++++++++----------
>  fpu/softfloat.c                            | 220 +++++++++++++++-
>  include/fpu/softfloat-types.h              |  17 ++
>  include/fpu/softfloat.h                    | 128 ++++++++-
>  target/i386/tcg/fpu_helper.c               |  30 +--
>  target/riscv/cpu.c                         |  32 ++-
>  target/riscv/cpu_cfg_fields.h.inc          |   2 +
>  target/riscv/helper.h                      |  15 ++
>  target/riscv/insn32.decode                 |   8 +
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  32 ++-
>  target/riscv/insn_trans/trans_rvofp4.c.inc |  43 +++
>  target/riscv/insn_trans/trans_rvofp8.c.inc | 105 ++++++++
>  target/riscv/insn_trans/trans_rvv.c.inc    |  39 +++
>  target/riscv/tcg/tcg-cpu.c                 |  10 +
>  target/riscv/translate.c                   |   2 +
>  target/riscv/vector_helper.c               | 135 +++++++++-
>  18 files changed, 1072 insertions(+), 204 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc
> 
> -- 
> 2.52.0
> 
> 

