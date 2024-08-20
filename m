Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1B7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 05:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgHMI-0002Uw-9I; Tue, 20 Aug 2024 01:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHMH-0002Tz-5l
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:24:41 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHMF-0001ij-Jv
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:24:40 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7b594936e9bso3457620a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 22:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724131478; x=1724736278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1mY9qTfLp9/wOp1KnlR/kB6EryzMXxmldfetb9IU/Tg=;
 b=yE0eNrBE+ta38YSQThpscn78H/VUyxBUV9I0ZMUighq+f0u8Dw71r+0REt4Kld48lv
 /byQ9sCOyaTXTI7MYI3Khta8HFRmS1dnqYBRl+L2IdlXnIRHq3MTRFLR0mwUCh6pEtSU
 0FYuOyGBTrwhoE1QGDbEvq8ldzvxDfjqx8BkRFwk4dQK8ec4GUVKCjQA9VC4WneCtPEq
 z2Cpz1THqZKFMuCyiAWpxELmuk2AhRQLkCtggsom43I3rwzIGDScnkBk4uIIIVx2NBE9
 //12XZDjKjnwhmEpY7+hvamdloK60oOzVnvlpJUYH010uDWGY/HonMBbdBMT1ff6v+LS
 dK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724131478; x=1724736278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mY9qTfLp9/wOp1KnlR/kB6EryzMXxmldfetb9IU/Tg=;
 b=Hbw2mmT435cWc4b62EHLDw9EaQededR9D8tRKR/Enn4zVIdo4ovg7Kf+JPO4NlKCbU
 0ByNoFN5lWtXNDlZvEYJZC14hnq4bsGq8m2lmVMp4eby656iztQs4uBaygNJd9kiWzcs
 ruVkUrChtz1nUSMAGyHbbW3VwN/oxq0MNwoUWKY3+m4n5rcH2TGbNZt/5rDLXyRResBc
 396rmphzibCtqicIk8dnBFfviFdAYxOOez8at+SidmmNRPHs4WODh4TbNBuJ8jbwZq76
 fo1WY7USai6Ov4c6l55j5vOkADkplMbRtZYF15CaO8k6yoVmJGm8w3xChKXogRPV256J
 Kkvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnnh3xc/viTj2BIJYZiOg27JoITcotu6R/yCKhddIp9I03KmtInoEEVUITxxuKO3S0IcURSfXdT2Cb8FUQ7P8gsAJZ6QE=
X-Gm-Message-State: AOJu0YzvXHCwGtqt3CAT8tsmnpzNWF5Pv8HILe9DGziDd1X2aBHQ9X07
 XFYBMtZ9pIpAds/kpbbGs0MT/vf746z6u0s6sFVv7ytpO0njW2DlJVFUctCWxWA=
X-Google-Smtp-Source: AGHT+IHVpiKQh/fsSi/DLTqWT+ct27mm8tLjCWslouxhbHk+rY3etHjmvCBwHlr+WGMBttYKEAzRGg==
X-Received: by 2002:a17:90b:1b06:b0:2c4:ee14:94a2 with SMTP id
 98e67ed59e1d1-2d5c0ea73c9mr1351740a91.27.1724131477655; 
 Mon, 19 Aug 2024 22:24:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3c3e5b9fdsm11043956a91.40.2024.08.19.22.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 22:24:37 -0700 (PDT)
Message-ID: <bb1f768e-fd10-4246-b60b-7912e33c7ee6@linaro.org>
Date: Tue, 20 Aug 2024 15:24:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/15] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240820000129.3522346-1-debug@rivosinc.com>
 <20240820000129.3522346-6-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240820000129.3522346-6-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/20/24 10:01, Deepak Gupta wrote:
> zicfilp protects forward control flow (if enabled) by enforcing all
> indirect call and jmp must land on a landing pad instruction `lpad`. If
> target of an indirect call or jmp is not `lpad` then cpu/hart must raise
> a sw check exception with tval = 2.
> 
> This patch implements the mechanism using TCG. Target architecture branch
> instruction must define the end of a TB. Using this property, during
> translation of branch instruction, TB flag = FCFI_LP_EXPECTED can be set.
> Translation of target TB can check if FCFI_LP_EXPECTED flag is set and a
> flag (fcfi_lp_expected) can be set in DisasContext. If `lpad` gets
> translated, fcfi_lp_expected flag in DisasContext can be cleared. Else
> it'll fault.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Co-developed-by: Jim Shu<jim.shu@sifive.com>
> Co-developed-by: Andy Chiu<andy.chiu@sifive.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   target/riscv/cpu.h        |  3 +++
>   target/riscv/cpu_bits.h   |  3 +++
>   target/riscv/cpu_helper.c | 12 ++++++++++++
>   target/riscv/translate.c  | 21 ++++++++++++++++++++-
>   4 files changed, 38 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -1265,11 +1270,25 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>      CPURISCVState *env = cpu_env(cpu);
>      uint16_t opcode16 = translator_lduw(env, &ctx->base, ctx->base.pc_next);
> -
>      ctx->ol = ctx->xl;
>      decode_opc(env, ctx, opcode16);
>      ctx->base.pc_next += ctx->cur_insn_len;

Watch the unrelated whitespace changes.


r~

