Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E5BC44521
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wliNx-0004OS-CI; Mon, 20 Jul 2026 03:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wliNh-0004MS-48
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:25:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wliNe-0002y7-Rf
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:25:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8485bd28dd0so11372177b3a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784532329; x=1785137129; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H4HP+j/EkYRR+Vruw/OntbiZHmHVJZSk2k9qn/JO9HM=;
 b=c1T3hpiLUNg5CCsWa4x5zqjODDS121URTVV+KC2M0bPTk7WX3zQsJP93Y34Yfzf0Q1
 MGyxymdX2HcFYK2qqpfYcHEW+5c9SMvp2tRf0PFmGZUkwlvZI4/7vZz0L0/GysrCAgVQ
 mfn1woz88XuVPYHRxvai9vnRE+WfgtABJW6uw4Go7Hg0Q7sBJa3jkzGHDetx7vyMVGl5
 96hMBpx2ZvJHUlGnSly3SeZnSUmhQnUUPZs6LyC8MTZhOo3m48Q10K4PEWUpEv8CzHaX
 qauLWpDQJSmIWDKA5aInVdlzjo10qF2PHF/l+BMAA6L1xVgjtcnYqN7McLDn87jtlwV4
 3XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784532329; x=1785137129;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H4HP+j/EkYRR+Vruw/OntbiZHmHVJZSk2k9qn/JO9HM=;
 b=dxdPcfj9h6CbinWmAe9laBHOMmkF84XDpop1bz57Vu2FrZ6K9Nqk6Q8Y86RDY4EtRA
 GnmOWrXckJOSeQTjL0a6LmAuIRH91cwgMeNLfeW7wwqKRTtRY2Ww/CpVAYa9y/uOeOeR
 GaAr+ArI21RdRRFJgE63w5ZpgEFlgZuh4ulRMPFNuFZ2v5wqIbNpNnjUmYsP5CdvlhMa
 lmUnUxSJqvdW7ai7v1Qw+Fcm7tyBiPQMoTqXWfa7OyvQed24WLld7wFk54Le1+ycBWu+
 b+fjOhME65/v9J8+5utKVl9WxUvoKeXByTbgDW20VHikFAJ+zErs7Pv0ZsbTMs3T27Ku
 OB0A==
X-Gm-Message-State: AOJu0Yy3CzB1CZb7tofdRdeaO5ZfQURiOf6xz5Omp/iMONwTdrJm1ZjU
 L6KRXF3B46T77mU/juk10Y/ZXTLDtfoTKrgNrJ37wgLreGyeCIxutRBhKKse6Kl6vrh2I6+EJON
 fyVUtCA7bFTniJFFxngkP1Fv7oe1G9NY7Dj+VEtOPNbA/7xQ25ncfKmVlh4aRGeOOwkhWoaM7Xj
 h+rP34tUX5nTHHQ4De3DH5RY8mJNRpblHV2X3Uhoxg2Q==
X-Gm-Gg: AfdE7cmGTwZnIjvzn9cHppxlnkTzzaipjdduOgroEdfXQYUujGBpCDB4jyE87wusWW7
 qLCjUMA/+3ISXNYvfED/VJjzzSLlDAv6ADJbxmXGJSXg5Zt62CGuBT6cklmCRugfDR33pfvwZ8I
 NXoEsoEqI/eNeQl9oNy9mCavnzOkGUtvlr61qicZkltze2/H8edbtAPKTcO0ce8N+ppIeesxVfA
 nV5NdHGFRqYaHAE01cpufADZHMunF0b7HlqYLQ2crPJxvbsmK75hKYZMPZjyEV2Xz4CBoVQ9/38
 Y0uDaRBr6Ro1N9AlfQjdqz1gRXqfX+E3i1cmkH/Gqfg8sc0vNG62eJB5JA7kQeqEaM+4dC5aNsn
 oaKBToXKp5lPrxFNUFAGDwIZTOJq+o41cUJuNLtL7Jj256Dm1aDjp2yx5ew6KydZn+Wd/Q0gHgZ
 32wBMwyX6ZGhWuqMGmmaWh221giaXrxSlSOz81xbkeSq6emZN3
X-Received: by 2002:a05:6a00:a245:b0:846:22ea:e171 with SMTP id
 d2e1a72fcca58-84c292d02ddmr12717258b3a.3.1784532328639; 
 Mon, 20 Jul 2026 00:25:28 -0700 (PDT)
Received: from sifive.com ([136.226.240.181]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2af30d0dsm5168457b3a.32.2026.07.20.00.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 00:25:28 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:25:23 +0800
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v6 0/9] target/riscv: Add RISC-V Zvfofp8min extension
 support
Message-ID: <al3MQlLMm5xyM0dV@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

Gental ping.

On 2026-07-09 00:18, Max Chou wrote:
> This patchset adds support for the RISC-V Zvfofp8min ISA extension that
> provides conversion operations for OCP FP8 formats which provide the
> foundation for the future vector matrix extensions.
> 
> Ratification status:
> - Zvfofp8min is currently v0.9 and is going through the RVIA ratification
>   process. This series tracks the v0.9 isa-manual tag below.
> - riscv-isa-manual tag:
>   https://github.com/riscv/riscv-isa-manual/releases/tag/zvfofp8min-0.9
> 
> Zvfofp8min (v0.9):
> - The Zvfofp8min extension provides minimal vector conversion support for
>   the OFP8 formats. It requires the Zve32f extension and leverages the
>   altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
>   E4M3 (altfmt=0) and E5M2 (altfmt=1) formats. Per the OCP FP8 spec and
>   the extension definition:
>   - Canonical NaN for both E4M3 and E5M2 is 0x7f.
>   - All NaNs are treated as quiet NaNs.
>   - Widening conversions are exact: no rounding and no exception flags.
> - These conversions are the data-movement primitives that feed and drain
>   the OFP8 vector/matrix compute pipeline.
> - The LLVM RISC-V backend emits these instructions as of LLVM 22.1.0:
>   https://releases.llvm.org/22.1.0/docs/ReleaseNotes.html#changes-to-the-risc-v-backend
> 
> Instructions:
>   Extended (existing instructions taught to handle OFP8):
>   - vfwcvtbf16.f.f.v   : OFP8 to BF16 widening conversion
>   - vfncvtbf16.f.f.w   : BF16 to OFP8 narrowing conversion
>   New:
>   - vfncvtbf16.sat.f.f.w : BF16 to OFP8 narrowing with saturation
>   - vfncvt.f.f.q         : FP32 to OFP8 quad-width (4x) narrowing conversion
>   - vfncvt.sat.f.f.q     : FP32 to OFP8 quad-width narrowing with saturation
> 
> Verification:
> - riscv-tests (fork https://github.com/riscv-software-src/riscv-tests):
>   https://github.com/rnax/riscv-tests/tree/dev/rnax/support_zvfofp8min
>   - Require LLVM 22.1.0
>     https://releases.llvm.org/22.1.0/docs/ReleaseNotes.html#changes-to-the-risc-v-backend
>   - Zvfofp8min test target: rv64uzvfofp8min/rv32uzvfofp8min
>   - Both Spike and QEMU applied this patchset could pass the riscv-tests
> 
> References:
> - OCP FP8 specification:
>   https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
> 
> 
> Changes in v6
> - Add patch 1 to fix the biased exponent write bug in the
>   parts_float_to_e5m2() saturate path. FloatParts64.exp holds an
>   unbiased exponent, so exp_bias must be subtracted when storing
>   the max-normal biased exponent value.
> - Initialize float_e4m3_nan_is_snan to false in riscv_cpu_reset_hold()
>   to ensure consistent NaN handling for OFP8 E4M3 operations.
> - Merge "Expose Zvfofp8min property" into "Add cfg property for
>   Zvfofp8min extension" to keep the property registration together
>   with the cfg field definition.
> - Fix indentation of cbo.* opcode table entries in the disas patch.
> - Rebase on riscv-to-apply.next (commit 267b5a2)
> 
> Changes in v5
> - Drop Zvfofp4min which is not going through the RVIA ratification
>   process yet.
> - Fix typos.
> - Rebase on riscv-to-apply.next (commit bf76a00)
> 
> Changes in v4
> - Rebase on riscv-to-apply.next (commit 21101a7)
> - Remove the softfloat library related patches (Thanks for RH's help to
>   split this part)
> - Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
>   patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>   conversion for Zvfofp8min extension)
> 
> Changes in v3
> - Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
>   in patch 2 & 3
> - Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
> 
> Changes in v2
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
> v5: 20260427060928.2322570-1-max.chou@sifive.com
> v4: 20260304134006.2908449-1-max.chou@sifive.com
> v3: 20260204051756.667397-1-max.chou@sifive.com
> v2: 20260127063723.442734-1-max.chou@sifive.com
> v1: 20260108151650.16329-1-max.chou@sifive.com
> 
> 
> Max Chou (9):
>   fpu: Fix biased exponent write in parts_float_to_e5m2 saturate path
>   target/riscv: rvv: Fix NOP_UU_B vs2 width
>   target/riscv: Add cfg property for Zvfofp8min extension
>   target/riscv: Add implied rules for Zvfofp8min extension
>   target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
>     extension
>   target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
>     for Zvfofp8min extension
>   disas/riscv: Add support of Zvfofp8min extension
> 
>  disas/riscv.c                                 |  19 ++-
>  fpu/softfloat.c                               |   3 +-
>  target/riscv/cpu.c                            |  13 +-
>  target/riscv/cpu_cfg_fields.h.inc             |   1 +
>  target/riscv/helper.h                         |  12 ++
>  target/riscv/insn32.decode                    |   5 +
>  .../riscv/tcg/insn_trans/trans_rvbf16.c.inc   |  32 +++--
>  .../riscv/tcg/insn_trans/trans_rvofp8.c.inc   | 105 +++++++++++++++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc   |  40 ++++++
>  target/riscv/tcg/tcg-cpu.c                    |   5 +
>  target/riscv/tcg/translate.c                  |   1 +
>  target/riscv/tcg/vector_helper.c              | 120 +++++++++++++++++-
>  12 files changed, 338 insertions(+), 18 deletions(-)
>  create mode 100644 target/riscv/tcg/insn_trans/trans_rvofp8.c.inc
> 
> -- 
> 2.55.0
> 

