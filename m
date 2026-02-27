Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD5104891A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5a2-0007T7-9f; Fri, 27 Feb 2026 16:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5Zz-0007Sc-Nv
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:41:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5Zx-0001eJ-W7
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso20647835e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228456; x=1772833256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qUu9ef3aWVgf43YbMvg9gg+DMUn4XgIMh2vf8UgI2eY=;
 b=dsWO8xtx3rPnvWplmdZ8002CkxR/eocobVQ/NgEsSnAC++ceoGUJKBuB/S0I5NjC05
 SVORsj63cUydSyb5o5Ez+hPWAXzy+TRe7N01qsjtSz+Yg6zbW04atcunDR4QYUlUdJyo
 a/D6y9TuI7glUlTeoKtHVRRiSivXZlteT2YyWwJg7ezyxfPF9WpW+r7b4k+3KYuETU4F
 2ZShli+nJS8UrWkCd0wqd4dYBvpaj2OOQzQypTwUis4S5taf/8z/xpzkKSZ7fig9TsIk
 hBX2sy09PaU++nkCZn5hzygzpRNIDKHQzB9zy/+G+H0HrhBV0bOjKkAPpDzzCIIvTFJp
 brSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228456; x=1772833256;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qUu9ef3aWVgf43YbMvg9gg+DMUn4XgIMh2vf8UgI2eY=;
 b=e0t32mDn7UKSWJpaupmqRhkMwLujist1rGrkguG3GxYDt9dacMUNLw9iIpIa7SrfoI
 cVl/1Udh3FZxy8tLZ/CtwH3TPohZ8CPMReYQXBIT7K6eDWYJPxb/jni3n+20LvIydS2L
 NuMm/ezCECII7gIdXShcw0gYdf9ENI1nA3LK2/b1hNHtFOojzTS0pTTOa1HtHv3oJ9PM
 fd5OSA6e6h2MJW1lg86dOPVX4MW0nJARo4U7EMC4YAbUpH3MolUa02mZ1N9/j1f+3GH5
 5+LlBpocDG/o2ZNOobMaimRIs0/xkMzb2I/jF6XrDir9Q7+44TtkxM1iym9SJTnVPd2v
 s1qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYz7FSkllExcxyuJbd60/TjFcAImyl4ofbKjJMRqD7MTmegpNZDGzRkKSn7QBKxCo3lk4AKBVpK885@nongnu.org
X-Gm-Message-State: AOJu0Yw0NGYcSFTpcmJr91gXUjocF1G+jddeRetrkK3MliCtmQgllV/y
 sYqdeVNWISGtQV2+57sPtrkRkSRtwb+nsuLxPxM3GJGwNUBICTP+gWxhP7IsIaZFsE0=
X-Gm-Gg: ATEYQzyIoMemrxwVBTOgxMRHSAp0BqtMiSktqWA92H0r3/aW9alSKvOOJYih1Ic11XU
 lXlAoeaoNwZjmmIw1ebanGoVot853aoqzX3kXT94tIRaVT4ZBK9j8TDSJdRPVqfHzNLA3hcRsZc
 L7uWBfRTgxUhBaIX5ZjAInGIr64C7sAjK7ERWXL0C2BAdSji2OeKNfVMSklJE1TITOY8uccpY06
 SsELwmJAQbJqlI39gx8uzQowbQ/keSVq2+fCIjaDlhnyW5fAGI6KdFvjg1v9PA4rvwMVVrnAAN3
 MoXeiF9r2kSyJKRJKAoxHdwKvsOIA5KeZXRUI4zz7KdFiVdnZS1ov/LLxg2zpuV9r1JDAjp8WQT
 gpY/mwqQ0xTcqNyK0rtBvLfhZ++toi1wMcPCbph3tRI1hGBtb0Uo+10QkoGqnEhdLm+xD2BdUeq
 rl1fts9h7h0dWm4XQHWDengve6yl+ldGfFZppgR11t5lZMIxZOOyg+MhJaEzeyj++4pQ==
X-Received: by 2002:a05:600c:4ece:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-483c9bad811mr75383595e9.13.1772228456082; 
 Fri, 27 Feb 2026 13:40:56 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm235071145e9.1.2026.02.27.13.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:40:55 -0800 (PST)
Message-ID: <3ec72a91-7326-43ff-8a8a-30135920ebe1@linaro.org>
Date: Fri, 27 Feb 2026 22:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ppc-linux-user GDB stub broken
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
 <70d4f460-c5c5-45ac-9ef0-2307ea4834f2@linaro.org>
Content-Language: en-US
In-Reply-To: <70d4f460-c5c5-45ac-9ef0-2307ea4834f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/2/26 14:09, Philippe Mathieu-Daudé wrote:
> On 27/2/26 10:58, Philippe Mathieu-Daudé wrote:
>> Hi Florian,
> 
> 
>>> on current master (d8a9d97317d03190b34498741f98f22e2a9afe3e), the basic
>>> gdb stub test fails for ppc-linux-user when running "make check-tcg".
> 
> 
>>> I've debugged around a bit but I don't know my way around the gdbstub
>>> internals enough to propose a patch right away, so I'll just summarize
>>> what I figured out so far.
>>> 1. Due to cc->gdb_num_core_regs not being set explicitly anymore, it is
>>>     set to 0 at the end of gdbstub/gdbstub.c:gdb_init_cpu(). In the same
>>>     function, cpu->gdb_num_regs gets set to 70.
>>> 2. When the test tries to read a register in gdbstub/ 
>>> gdbstub.c:gdb_read_register(),
>>>     the first condition of "reg < cc->gdb_num_core_regs" is always 
>>> false.
>>>     Also, the register number for fpscr passed to the function is is 
>>> 103,
>>>     and cpu->gdb_num_regs is also 103. If the register number is 
>>> supposed
>>>     to be an index (as I understand it), this would indicate an
>>>     off-by-one error somewhere.
>>>
>>> If you have some pointers on where to look / what to check out for
>>> fixing this, I'll happily try to work on a patch. But I suppose that
>>> somebody more experienced with this could probably fix this much faster
>>> than I can.
>>
>> I'll have a look.
> 
> Short term, this seems to fix it:

Series for the generic fix posted:

https://lore.kernel.org/qemu-devel/20260227213958.21170-1-philmd@linaro.org/

> 
> -- >8 --
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 90f4b95135b..0b0a5d1e044 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -610,6 +610,10 @@ void gdb_register_coprocessor(CPUState *cpu,
>       guint i;
>       int base_reg = cpu->gdb_num_regs;
> 
> +    if (g_pos && g_pos != base_reg) {
> +        base_reg = g_pos;
> +    }
> +
>       for (i = 0; i < cpu->gdb_regs->len; i++) {
>           /* Check for duplicates.  */
>           s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> @@ -622,14 +626,7 @@ void gdb_register_coprocessor(CPUState *cpu,
> 
>       /* Add to end of list.  */
>       cpu->gdb_num_regs += feature->num_regs;
> -    if (g_pos) {
> -        if (g_pos != base_reg) {
> -            error_report("Error: Bad gdb register numbering for '%s', "
> -                         "expected %d got %d", feature->xml, g_pos, 
> base_reg);
> -        } else {
> -            cpu->gdb_num_g_regs = cpu->gdb_num_regs;
> -        }
> -    }
> +    cpu->gdb_num_g_regs = cpu->gdb_num_regs;
>   }
> 
>   void gdb_unregister_coprocessor_all(CPUState *cpu)
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index e0aae9c9eaf..51b14b95b9f 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -502,7 +502,7 @@ void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *pcc)
>   {
>       if (pcc->insns_flags & PPC_FLOAT) {
>           gdb_register_coprocessor(cs, gdb_get_float_reg, 
> gdb_set_float_reg,
> - gdb_find_static_feature("power-fpu.xml"), 0);
> + gdb_find_static_feature("power-fpu.xml"), 71);
>       }
>       if (pcc->insns_flags & PPC_ALTIVEC) {
>           gdb_register_coprocessor(cs, gdb_get_avr_reg, gdb_set_avr_reg,
> 
> ---


