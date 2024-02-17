Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12566C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 02:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbAZY-0005PW-9n; Fri, 16 Feb 2024 21:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbAZS-0005P9-Fu
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 21:36:54 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbAZQ-00048Z-RP
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 21:36:54 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e11a779334so1733898b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 18:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708137411; x=1708742211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8fSUs8BjH68Z0oXNSJRrjzgD6NMFae9HgvcKhiRDnBo=;
 b=RU/AE4/KYLzlpUVlwf5RLLFfWYo6Z2PSeNOEBmkSkBzHEQMCp9gBNAj9mYwdxe85jD
 cdRru33tGEV2bSdakK7/SdEKkXSPgA8IS/K8Ptl+ETxth4Za1qf5IulCgrsl7tJ1MRBo
 P79MzyfFmz9BawAGzse3BZClZW4JE+SkBuno8O37rRYq6ZZeZPan6bbcX8o+LV2ANqU5
 ke5p1pgAYR42XZiwTppZ+covfe/HPSzgBkPMJYmzToEuOojE9B0WGUORTD+Gc2ysKnbS
 NJz/UTgWadqsjeBxe53diBLRsmWO1nIU69+n/SGk1wh59dCZ9CfzywmjTiBWywQzArbO
 U46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708137411; x=1708742211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8fSUs8BjH68Z0oXNSJRrjzgD6NMFae9HgvcKhiRDnBo=;
 b=TuJcus+XKMCGZkPouvkCtUOG0Dy79R2+P7V+ec4SvIGyWRj4ZAx95oZXLrMUXzin+b
 0S1yUHYG0x9aEQ/x8dpjt51mRpusQMfmxQFK0OLS6uzIPtOpWEjrZNmiU2xoQtRo+55u
 9MK3tT+OYr6qq2zQnWgH1ZR4Cli7PpzrWKYxyATvLxHM5pwhme4r7gs5m8mmW/7xlJFU
 gMaRNNzHH+BUeL2gyJs31I9T1u09DTirtwMsnyHDqcCfqQ5VLPL8prI3MdcFZ4IhWY+C
 JQ6bQc+KORRKkJD9lC4KARrS4XLT25E4yXnFcFklXOM8nIEL+sKsnrChggFc/xRPr+4z
 eDQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR/Iab2NFFV/l8ijXAo7ypQN2a6WL0d2W/XnA1H0fLdD8FOI7MveGU3fo1lQM+yeQnpRVU/Ed/pSgUcQHQ9JAmLghR/Xo=
X-Gm-Message-State: AOJu0Yyl8zwtJIULk9cUdlasdlW5EyiaxaO11JFObwgRuzwwHuTeOxzt
 VVXr2LQ1H80/KXJ69kZeUuN6Ty7pfftVZqaVKAq3iQgHz9htDm/XHHKzMRvaZNg=
X-Google-Smtp-Source: AGHT+IEIB9LYXQsspbEbztTkq9m5HZfhnFyjcNXON4+p5xe6ROfdK1EbiH3oFzZt4j9IdgXHS4PCpA==
X-Received: by 2002:a05:6a00:2451:b0:6e0:50cb:5f0a with SMTP id
 d17-20020a056a00245100b006e050cb5f0amr13468786pfj.12.1708137411296; 
 Fri, 16 Feb 2024 18:36:51 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a62e117000000b006d9a6039745sm619221pfh.40.2024.02.16.18.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 18:36:50 -0800 (PST)
Message-ID: <477ebee9-429e-45ab-b94b-2b649482c9d0@ventanamicro.com>
Date: Fri, 16 Feb 2024 23:36:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/riscv/translate.c: set vstart_eq_zero in
 mark_vs_dirty()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240216135719.1034289-1-dbarboza@ventanamicro.com>
 <20240216135719.1034289-4-dbarboza@ventanamicro.com>
 <16087154-b3d2-4cab-938f-4a04fc8dd166@linaro.org>
 <04a3c3d3-fc2f-4b1e-9845-f5345e062c7b@ventanamicro.com>
 <59b52f47-43a3-4f67-97e8-86e31db8746c@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <59b52f47-43a3-4f67-97e8-86e31db8746c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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



On 2/16/24 20:41, Richard Henderson wrote:
> On 2/16/24 12:40, Daniel Henrique Barboza wrote:
>> After reading the reviews of patches 1 and 3 what I'm considering here is:
>>
>> 1 - drop patch 1;
> 
> Ok.
> 
>> 2 - there's a patch from Ivan Klokov sent 2 months ago:
>>
>> "[PATCH 1/1] target/riscv: Clear vstart_qe_zero flag"
>> https://lore.kernel.org/qemu-riscv/20231214111851.142532-1-ivan.klokov@syntacore.com/
>>
>> His patch is closer to what you suggested than mine. He already renamed mark_vs_dirty()
>> to finalize_rvv_inst() and made it set start_eq_zero unconditionally. It needs a
>> little work (i.e. remove the ifds from the function) that I'll do myself.
>>
>> 3 - I'll keep patch 2 to reduce the redundant calls to the now finalize_rvv_inst();
> 
> Ok.
> 
>> 4 - Add another patch to through all "gen_set_label(over)" cond branches and set
>> vstart = 0 && vstart_eq_zero manually when we're doing the jump.
>>
>> In fact, shouldn't we return earlier if we're not taking the branch? Otherwise
>> we'll set vstart twice in case we didn't get the branch. E.g:
>>
>>        TCGLabel *over = gen_new_label();
>>        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>>        (...)
>>        finalize_rvv_insn();
>>        return true;
>>
>>        gen_set_label(over);
>>        /* some TCG ops to set cpu_vstart to zero. Perhaps a helper?  */
>>        s->vstart_eq_zero = true;
>>        return true;
> 
> That will break, of course, because you wouldn't emit 'over'.
> You really need to get translation-time and run-time separate in your head.
> 
> That said, I think these brcond(vstart >= vl) are a mistake.
> The loops within the helpers are generally of the form
> 
>      for (i = env->vstart; i < evl; i++, env->vstart++) {
> 
> which will operate just fine with vstart >= vl, iterating zero times.
> We will then fall through to the post-insn cleanup,
> 
>      env->vstart = 0;
>      vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
> 
> or whatever.
> 
> I would expect the condition vstart >= vl to never happen in practice.  I believe the only way to induce it is an explicit write to vstart.  Therefore I think you should not attempt to "optimize away" the call to the helper.
> 
> Of course you will want to double-check all of the loop iterations in the associated helpers when removing the branches.

Ok!

> 
> 
> r~
> 
> 
> PS: I believe a better form for the ldst loops is
> 
>      for (i = env->vstart; i < evl; env->vstart = ++i)
> 
> to avoid re-reading from vstart each iteration.


I'll add a patch to convert these loops. Thanks,


Daniel


