Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F809C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 23:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb7pn-0000Gq-0r; Fri, 16 Feb 2024 18:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb7pl-0000GQ-1N
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 18:41:33 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb7pi-00039r-1n
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 18:41:32 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d932f6ccfaso23222775ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708126888; x=1708731688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwJliLzzSPsuR5Z0D9JOXgOfg9pAXkc03kqnwYAdu+4=;
 b=s/cA3y4yDw4jGoNgHZ3tv9KaQK7of+meQetX5lKhrL5BErLPOeTUE3ARG2+lVIW4ze
 3EBPdKj2zi66pHJPQzi4Uqa7GJ2OVu+fu7DPp/El/LBhQE6O/bh8OQIYhztVR0AFjYBk
 mujXlf0ym/nBrpgFy5849uyPf5qBEDhYZvlV85MGH8kajZ7yuS/1pmRHT4SqHxrWRdnc
 +MgzQOsVDXOM2jtvYjh2njAFQMtENqvLDQ/YFvRjnx+gmyBEyWHP+QhjTrAR6qO3y+D0
 3wswqcDPASrevEoh7kfVo5P7k84BqIgyocpGsibV081N701IWjsqhzdl+xkQtAnz08j1
 Gs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708126888; x=1708731688;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwJliLzzSPsuR5Z0D9JOXgOfg9pAXkc03kqnwYAdu+4=;
 b=dcEZxF3evxLU4Dfq0eB+Q7y1tEHDr65E2xJv1ZfE9m4C2n9kXXw17Kt8B51msWjlyK
 X/RvPTfwuI0TiBHp6K9j7x9MdBM1KbeMbo2ZxLTHwIZQO1fg/zGszhY1qPfb+kd/ylGm
 ghFRTYfsiz9S2D4cLj11OVN4BnaQS8bZaOE9BlBzf+ppLMsT/jaEIAaIjYTgt/m11BN7
 ZiKXLuDw+m//+iRV0ipvQqubUE13AA/DxUV/JBjAEO0orcBNO6sFfKnFX/XlDE9pNohF
 iXiCc8R8A1t2kLdICtS/heL0Du53SdSH2ToX2cng+JUQwxD7WkNwYAdAGvuPcnqpLrgH
 Dpfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVANaki8BsKAbkBoZo8xVj0wKwb8uPf7qcUrWmUWs5lVkDTsnqlcj7bpG0IsGpIOSEIsBVyW/xQ1vU7rUt2bdfWmu4tWoo=
X-Gm-Message-State: AOJu0YzeIeCFlgsHOdDEPJsjYUlgtlN6/Mv30tDQxMDij9Npa7DqMZYP
 jwIvt8ErEolIuLIiqCe+FeoXnkDE9hH71fpEv/TB9i0xDrl/6AcUgLg2wkmQEVM=
X-Google-Smtp-Source: AGHT+IGrYUxxYGAz4FemdT2uQ8TF9/BNUNqDwcCdtVZncY32t0yYCGRuX67O5BfMpqPixe1KJ2HkyA==
X-Received: by 2002:a17:902:d349:b0:1d9:8ac8:d79d with SMTP id
 l9-20020a170902d34900b001d98ac8d79dmr6571710plk.19.1708126888267; 
 Fri, 16 Feb 2024 15:41:28 -0800 (PST)
Received: from [192.168.20.227] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c24-20020a170902d91800b001db68d6c4d7sm374638plz.287.2024.02.16.15.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 15:41:27 -0800 (PST)
Message-ID: <59b52f47-43a3-4f67-97e8-86e31db8746c@linaro.org>
Date: Fri, 16 Feb 2024 13:41:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/riscv/translate.c: set vstart_eq_zero in
 mark_vs_dirty()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240216135719.1034289-1-dbarboza@ventanamicro.com>
 <20240216135719.1034289-4-dbarboza@ventanamicro.com>
 <16087154-b3d2-4cab-938f-4a04fc8dd166@linaro.org>
 <04a3c3d3-fc2f-4b1e-9845-f5345e062c7b@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <04a3c3d3-fc2f-4b1e-9845-f5345e062c7b@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/16/24 12:40, Daniel Henrique Barboza wrote:
> After reading the reviews of patches 1 and 3 what I'm considering here is:
> 
> 1 - drop patch 1;

Ok.

> 2 - there's a patch from Ivan Klokov sent 2 months ago:
> 
> "[PATCH 1/1] target/riscv: Clear vstart_qe_zero flag"
> https://lore.kernel.org/qemu-riscv/20231214111851.142532-1-ivan.klokov@syntacore.com/
> 
> His patch is closer to what you suggested than mine. He already renamed mark_vs_dirty()
> to finalize_rvv_inst() and made it set start_eq_zero unconditionally. It needs a
> little work (i.e. remove the ifds from the function) that I'll do myself.
> 
> 3 - I'll keep patch 2 to reduce the redundant calls to the now finalize_rvv_inst();

Ok.

> 4 - Add another patch to through all "gen_set_label(over)" cond branches and set
> vstart = 0 && vstart_eq_zero manually when we're doing the jump.
> 
> In fact, shouldn't we return earlier if we're not taking the branch? Otherwise
> we'll set vstart twice in case we didn't get the branch. E.g:
> 
>        TCGLabel *over = gen_new_label();
>        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>        (...)
>        finalize_rvv_insn();
>        return true;
> 
>        gen_set_label(over);
>        /* some TCG ops to set cpu_vstart to zero. Perhaps a helper?  */
>        s->vstart_eq_zero = true;
>        return true;

That will break, of course, because you wouldn't emit 'over'.
You really need to get translation-time and run-time separate in your head.

That said, I think these brcond(vstart >= vl) are a mistake.
The loops within the helpers are generally of the form

     for (i = env->vstart; i < evl; i++, env->vstart++) {

which will operate just fine with vstart >= vl, iterating zero times.
We will then fall through to the post-insn cleanup,

     env->vstart = 0;
     vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);

or whatever.

I would expect the condition vstart >= vl to never happen in practice.  I believe the only 
way to induce it is an explicit write to vstart.  Therefore I think you should not attempt 
to "optimize away" the call to the helper.

Of course you will want to double-check all of the loop iterations in the associated 
helpers when removing the branches.


r~


PS: I believe a better form for the ldst loops is

     for (i = env->vstart; i < evl; env->vstart = ++i)

to avoid re-reading from vstart each iteration.

