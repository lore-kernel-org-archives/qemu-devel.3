Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12854C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wozsn-00039W-KL; Wed, 29 Jul 2026 04:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wozsm-00039L-Qo
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:43:20 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wozsk-000064-KF
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:43:20 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-38111ea8a88so434173a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785314596; x=1785919396; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a11+Cc8dmhp1fC2pGOY46Z24KBM2/GScbvitZXzd2iA=;
 b=XIHvfzpNNzBOiLd2fX85stZe4CSSemtzoeH0O3P0XGrE8ETbCUEHIe46nd5V5+Y0TI
 612797MTkQazdAdbdJknmKgRA6aS29IGbCSIoCD6G4BiAEmZtNncA2O91qdSUJ/kRA3h
 gBBZCPKcFB5pw+cquIFMElSBVz4CdStUYRY4nrYHJSghy5GLJDPabkoqrcvObiahr/5/
 ICs3jPQqqdohcKvvdsCWxrbQc4glsbfQYf3j2pq2f2is4CSgPRHkOHdzuURKTVxJKXch
 wwXqlVQYGPurSWFcN56ty+Il+iEXm8W+uE8NSaOtfn0zU2IKDPNq/fjMzLTz5FzsJcjk
 dLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785314596; x=1785919396;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a11+Cc8dmhp1fC2pGOY46Z24KBM2/GScbvitZXzd2iA=;
 b=sqnYBK9OlMcG2ucM2GqsUy/Q4PieEmGlBPnwk6npDdUk3ojYzu2F9SqP5ZHUPIa/e/
 wEXtgJDOu+fnlupMQx+NnYzKAK7p0pfPn8AFhktOZ/ByI/rrO+/X4a0oJ3emru/090kv
 b+Abcbj3Men7fuoJcd80T7Lat8oil3q3BlxjUKcN1N3+eZXvsx3Ju/kAgInPeTpLGDRo
 o53fl+18NmWp5NIPXdR0s4ge4mdtVgc14QBYQzmqcNvJvnVCYjJv3pV6uaXxy29GrsUS
 Z9s6UwQ3cTaQg5macEEyyer9KYB1EbOmAESIphe8sGYeVeacEU52eEwDYeGsKCghDUMI
 I7rA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBE1J8eLSY3h8VqiaOx8sdpLCOlU2Xhc4k6aiCXsvIMxvFe3zYbo9RAdN7W7GmdzYspEPX3W5C7znb@nongnu.org
X-Gm-Message-State: AOJu0YxSC5mzOpWW/kC+CGPpJi891PMkGBGeJPg+ka1CEJ5z/6zLEEi9
 atMap0TyheVYH5h5mZDTeNMPddklnLjVkmv7i6KSXpG+NscEnFVoGGzD
X-Gm-Gg: AR+sD13ZI6st72RhEBfPYNeV4DIszjT7mN3BdiVCUXsUVny+siMid247np04zkLxcOV
 cYwt6URgBoCtx/wIXznKvEmYhWVGC+Xy03V+yqFIYS2PHbPhST+siDnhepxkb2rmtDxa9CHwuEe
 5sqD0Cj09P1ipF3yaXw+u8IJdJhQqc9cUPPbbH7tJGA+W/cLJVqLsXt7Vi1ywSiXt2BVc9lDE50
 Obr7BlxdXUUkxZkLLJcF34Nh0F2EuY6yGC3B5P4xQaI+29t3oS/YmY82JL3WjVFbdJFPV7Rc/Be
 lboVf55IkDXrtwOFJnUB+USBXSbuwtHWQLKCjBPvZ02A4/ZM4Lk4hXBHQN3lAOMwMHpcE+H2rTr
 NcYBC4lbzPTPCoFjqPwe0MRYyMOr2lTMESRS9Na6sD54eyCnAItQS611mH6mboftIBMftbCWdMF
 ivJJtO9+5LbBrXGJ/WqY7m+vGWwfpZkLoQMqbx/i6z6pTCmPXDALM3OJxfCJF8wkc5XOrN5TS6e
 r5bb4XQqE/AcxoZ0OqB1HX/47s=
X-Received: by 2002:a17:90b:5868:b0:38e:a74:dfe4 with SMTP id
 98e67ed59e1d1-38f6a422e0fmr6344902a91.25.1785314595929; 
 Wed, 29 Jul 2026 01:43:15 -0700 (PDT)
Received: from localhost ([179.255.148.148]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b1246dsm6884142eec.2.2026.07.29.01.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:43:15 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:43:11 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/18] target/riscv: Add support for RISC-V P
Message-ID: <amm8EfJjG7VdgS8C@ChaodeMacBook-Pro.local>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Molly,

On Fri, Jul 17, 2026 at 10:06:53AM +0800, Molly Chen wrote:
> This series adds support for the RISC-V Packed SIMD (P) extension.
> 
> The P extension defines packed-SIMD fixed-point operations intended
> for DSP-style workloads such as multimedia and signal processing.
> These instructions operate on packed subword elements within
> general-purpose registers (GPRs).
> 
> The implementation follows the current development draft of the
> specification (v0.20):
> 
>   https://github.com/riscv/riscv-p-spec/
>   or
>   https://www.jhauser.us/RISCV/ext-P/
> 
> Compared with v1, this version reduces implementation boilerplate by
> defining and reusing helper macros for common patterns in
> trans_rvp.c.inc and psimd_helper.c. It also consolidates the P
> extension prerequisite validation in riscv_cpu_validate_p().
> 
> The Zbkb dependency has been removed to align the implementation with
> the current specification. This version also implements the
> specification-defined control of vxsat, which was missing from v1.
> 
> All instructions have been functionally tested using the following
> test suite:
> 
>   https://github.com/mollybuild/qemu-riscv-test-uart
I believe we need to add some TCG test cases for the patches if
the latest compiler supports the P extension, we can add some cases
similar to your repo.


Thanks,
Chao

> 
> The implementation focuses on functional correctness and ISA
> coverage. Performance optimizations were not considered at this
> stage.
> 
> Feedback on the implementation details would be highly appreciated.
> 
> Tested with:
> 
>   - ninja -C build test
>   - make -C build check-qtest-riscv32
>   - make -C build check-qtest-riscv64
>   - Functional tests for all P extension instructions using
>     qemu-riscv-test-uart
> 
> No regressions or test failures were observed.
> 
> ---
> Changes in v2:
> 
>   - Refactored trans_rvp.c.inc and psimd_helper.c by defining and
>     reusing helper macros for common implementation patterns, reducing
>     boilerplate and overall code size.
>   - Moved the P extension prerequisite checks into
>     riscv_cpu_validate_p().
>   - Removed the Zbkb dependency to align with the current
>     specification.
>   - Added the specification-defined vxsat control mechanism, which was
>     missing from v1.
> 
> v1:
>   https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html
> 
> Molly Chen (18):
>   target/riscv: Add packed SIMD extension state
>   target/riscv: Add packed SIMD helper framework
>   target/riscv: Add packed SIMD arithmetic instructions
>   target/riscv: Add packed SIMD averaging and rounding instructions
>   target/riscv: Add packed SIMD absolute, difference, compare and mask
>     instructions
>   target/riscv: Add packed SIMD shift instructions
>   target/riscv: Add packed SIMD exchange instructions
>   target/riscv: Add packed SIMD horizontal reduction instructions
>   target/riscv: Add packed SIMD pack, merge and count-leading
>     instructions
>   target/riscv: Add packed SIMD multiplication instructions
>   target/riscv: Add packed SIMD multiply-accumulate instructions
>   target/riscv: Add packed SIMD Q-format multiplication instructions
>   target/riscv: Add packed SIMD Q-format MAC instructions
>   target/riscv: Add packed SIMD two-way MAC instructions
>   target/riscv: Add packed SIMD four-way MAC instructions
>   target/riscv: Add packed SIMD load-replicate instructions
>   target/riscv: Add packed SIMD RV32 only instructions
>   target/riscv: Remove Zbkb dependency from P extension to align with
>     the spec
> 
>  target/riscv/cpu.c                          |    5 +-
>  target/riscv/cpu.h                          |    8 +
>  target/riscv/cpu_bits.h                     |    2 +
>  target/riscv/helper.h                       |  529 ++++
>  target/riscv/insn32.decode                  |  829 +++++
>  target/riscv/machine.c                      |   19 +
>  target/riscv/tcg/csr.c                      |   39 +-
>  target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
>  target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1389 ++++++++
>  target/riscv/tcg/meson.build                |    3 +-
>  target/riscv/tcg/psimd_helper.c             | 3165 +++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                  |   46 +
>  target/riscv/tcg/translate.c                |    6 +
>  13 files changed, 6038 insertions(+), 6 deletions(-)
>  create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
>  create mode 100644 target/riscv/tcg/psimd_helper.c
> 
> 
> base-commit: 8fb307591625731060d399aca42373c02c7cb040
> -- 
> 2.34.1
> 

