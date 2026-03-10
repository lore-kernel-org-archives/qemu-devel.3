Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E56FD4F34
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w03aO-0000Y6-J2; Tue, 10 Mar 2026 16:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w03aG-0000Wx-R8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:21:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w03aD-0004Oh-Cu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:21:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so25906825e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773174095; x=1773778895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k2/OKnJzj+wY2+JlJEtJsS7xrjDT4IdLAXjiJWl+GMU=;
 b=k5Hlt+MRlcXg85JoZces1/mksG4Cf/ww2sWS5wVdo25Gzy5ZRMjHLY/nfJyjQhFmlJ
 JMcdqGwrwdPnweMYM8R/iyVZvBU9aDK1GptC3HOhkvRUAlI3F5rCJ7einMl9ezPKcP79
 8xMZjVQWwo+bG5zBnjQsrQ82hVULOKgcnDDZ6RPNbNI0Qnr6gT8BGN4vTGzyxhWfJ6gV
 mMFPViyiadGA39dvPQwXK5EXzYMTciXe/Ch9i2ovPhjp/qVN4mgXHxTyvo7ODgXydmyv
 psydZSbyz9cky/p0nuoACYORkLcLJNTZr7Sjm5+PNyfyNv68ic1oeeEd+T80YOMMszfn
 HiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773174095; x=1773778895;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k2/OKnJzj+wY2+JlJEtJsS7xrjDT4IdLAXjiJWl+GMU=;
 b=LmW2Wql3HWGPAejBxePf70LihxL9WL7yafm3LJCtuDm7BxUglSqvw8FAWE8ZmodNQ+
 s1u1/c6u4TTsUokRBENFcqph82f9t7x1AzO8ZlB16hKZ4FkI61Vjk8yQqSJ9EOa7Qt6G
 ed3PFt3L0ojmo04vj4rBQ4R/je7/Rfqln5MIL3f/JZRNUAGj44c2vCbSKEjDCydrLVTc
 EC2a5YhX8veeT8rIbGs4nLvmk/fhCDxic1MVntBV9CAo21tTmE0nswsbZEnp6sxMyKBZ
 EoL+9eNaFutoSwdX5z4YsNICWx9ZsKA/NrzHuYGKnL16/xtrAgZUd+IMQU5KhhXBfBe4
 cOxQ==
X-Gm-Message-State: AOJu0YxOZu6vlSNNTeWLs0oLfXe4QEaAGNtGHPJMyhLzffPhntfiAiSi
 nRjy0dxgbKxndZGt9AhsK4MxHkGHePFG4+MEXDB4KdX3YZzEUXNZnzzJkgq3KHX+MGH8KiRa+2Y
 vum7qkkI=
X-Gm-Gg: ATEYQzwng1/MsA1/eNb8qvV698O81B2yU1JkN1pdb9PJfah7+2eKkDjd2dWU0F+S++c
 /iVtAKSWC0hupz80dnt7TJH+4tpabcTalUpsw5L5jD16KGDz82nR33j22d6VSVkaKR56SEXQyFU
 HSffK5CsLSroGwxCUmb3aWlM496yKLtTyHTCBrOen6YPNAn8ACmsvjDcqiTSvxw6x184BXW3F/T
 1ltXwExVHhxxgpbLKHRyKDJefspzsJyeF9zdCpF6M+Y4cGE2T5g/wePq0lz3rAk2kRlj9Oewk4r
 1X4DvHvN50gpQRuy946149b00bT3WDbdiUfrAQkD0qj5GiIGqTTJ0Jhuwvhk1i5okqHOt80lBIJ
 +3GSip+KoptSAlGpRyviLpgTwaZMKBivUzZk6BS7fFdxSZ6GtT6obe1l81HFkthi2Q5yZF/s8YK
 gv418z21MVMDVMk3czmu3j50bdW/SN901dKKc9p1qQxmEDeC+/SLq27Ufx6CqP20eVuw==
X-Received: by 2002:a05:600c:6297:b0:485:3ca4:4ef4 with SMTP id
 5b1f17b1804b1-4854b0bb5d2mr1959065e9.9.1773174094897; 
 Tue, 10 Mar 2026 13:21:34 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3068cfsm3035275e9.8.2026.03.10.13.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 13:21:34 -0700 (PDT)
Message-ID: <59f1a9e0-92e0-4541-ab01-2f301346d5b5@linaro.org>
Date: Tue, 10 Mar 2026 21:21:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] gdbstub: Use GDBFeature::base_reg in
 gdb_register_feature()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-ppc@nongnu.org
References: <20260310155329.48772-1-philmd@linaro.org>
 <20260310155329.48772-10-philmd@linaro.org>
In-Reply-To: <20260310155329.48772-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/3/26 16:53, Philippe Mathieu-Daudé wrote:
> When a feature XML file provides a "regnum=" tag to indicate
> the registers base index, respect it, as it might not be the
> same as our current number of registered entries, in particular
> when there are gaps.
> 
> This fixes a bug with the "power-fpu.xml" file [*] which was
> loaded at index 70 while the base register is 71. This latent
> bug was exposed by commit 1ec0fbe2dda ("target/ppc: Fix
> CPUClass::gdb_num_core_regs value").
> 
> [*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Reported-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c    | 16 ++++++++++------
>   gdbstub/trace-events |  1 +
>   2 files changed, 11 insertions(+), 6 deletions(-)


> @@ -617,7 +618,6 @@ void gdb_register_coprocessor(CPUState *cpu,
>   {
>       GDBRegisterState *s;
>       guint i;
> -    int base_reg = cpu->gdb_num_regs;
>   
>       for (i = 0; i < cpu->gdb_regs->len; i++) {
>           /* Check for duplicates.  */
> @@ -627,7 +627,11 @@ void gdb_register_coprocessor(CPUState *cpu,
>           }
>       }
>   
> -    gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
> +    if (cpu->gdb_num_regs < feature->base_reg) {
> +        trace_gdbxml_register_coprocessor_gap(cpu->gdb_num_regs,
> +                                              feature->base_reg);
> +    }
> +    gdb_register_feature(cpu, get_reg, set_reg, feature);
Broken patch, please disregard.

