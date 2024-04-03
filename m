Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A148ECD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 22:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs9Hh-0003WG-Qb; Wed, 03 Apr 2024 18:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rs9Hg-0003Vn-09
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 18:40:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rs9He-00064X-F5
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 18:40:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e2a7b5ef7bso2251605ad.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712184040; x=1712788840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9XGLKWxm1HIoFg3oNUWrQ4bhGixbzwIpIrR38xhKGk=;
 b=n2Z38xabf6oVexo2nhQIQB0ewjEuUAU1eiO3IXNtSAHDBBYLgC84AfXk6wXuI8QvNI
 78SUkKBr34F/CJxRRtEDbxUKp6BPY5sM9yNRqRDw1wJgN0WZwDleR+XZWChYqM1eFcZP
 qDTOZY76mDPCkKvubhv9ATyZNOa/DcQ1N4kSnQnApYDbd+w6rwwP+R+72f6FxJxmIr/V
 6ifxdzxulu7VCLoBzgVHGO6ii0n7dxp3qSh8G+oQQSHiyJ/NZG1LWT7oDMYV0G+mW7Kt
 HZ97Dy7f80nS+b98G/tn3EJHBsObupzpRGBWbrdh9mIu7/jK8EzM2q4XKFhszyp2iy9Q
 rY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712184040; x=1712788840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D9XGLKWxm1HIoFg3oNUWrQ4bhGixbzwIpIrR38xhKGk=;
 b=keqJK1diTlCmmHQaApVQRd2zPNzlwYBhsQEbN9kf/D/479waC39PjazS3uwgWi7YGa
 6wHte3aB3w8DcXJQecorz7t42pYXdIpRL3Al5ZGYzn4ZtbHBe5tbu8CglCTvZbTTpYNZ
 Tm15OwPjJLPitVVDx3QHHpKGW/6dkPv6oetcKxcXM1bwAb4jSax8cParOnRJnpsnLcnn
 WYnjnVlvvvlFHYDBgNmdVVJ0uoLNLXaBvIYFlVVIStT6WmVgLGfVT18rycfzlRJw3+3j
 Lc1N+Auw5QmIleKYg7FqZY5lQfzx1NehAVckwukjtJwI3oUM7FrnGQQ+XvG+OGSvF3iF
 oXdQ==
X-Gm-Message-State: AOJu0YyXuacvZAf7viVviYD/LG1iriWB17/qGH8apHKq9AK3NTxdqj4B
 94YThQl3IYhTm3PctyV6paZL8UEB1sbCh40CVrQyjYT4nEa0FLG9oZmJcggQsAs=
X-Google-Smtp-Source: AGHT+IGLg5nAv9BPlPnTjS+AokrUo1n0GlH0HjnJ6F8UAQ4oF4qRDs0JAC6z85qA/Z8P2yP5ev4EuQ==
X-Received: by 2002:a17:902:ed46:b0:1e2:2d16:cd6b with SMTP id
 y6-20020a170902ed4600b001e22d16cd6bmr571728plb.28.1712184039735; 
 Wed, 03 Apr 2024 15:40:39 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170902650b00b001e2866a914esm3278590plk.85.2024.04.03.15.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 15:40:39 -0700 (PDT)
Message-ID: <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
Date: Wed, 3 Apr 2024 12:40:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Point where target instructions are read
To: Gautam Bhat <mindentropy@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/3/24 08:15, Gautam Bhat wrote:
> On Tue, Apr 2, 2024 at 2:01 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> 
>> The boot process must cooperate somehow.
>>
>> When using loader, you must link the image such that it loads at the pc reset address
>> defined by the architecture manual.
>>
>>
>> r~
> 
> I changed my loading options to the following now to have better control:
> 
> ./qemu-system-msp430 -machine msp430-launchpad -device
> loader,file=simple_test.bin,addr=0xFFFE,cpu-num=0,force
> -raw=on -d in_asm,out_asm
> 
> Here simple_test.bin is the raw binary file converted using objcopy.
> addr=0xFFFE is the vector location where the PC will load with the
> starting address.
> 
> Now how do I load the address in that reset vector location and set my
> PC? Is there some example code that I can look at?

Hmm.  I can't find an example.  I see a TODO for m68k which *should* be loading the pc 
from the reset vector on reset.

What I think should work is something like

void msp430_cpu_reset_hold(Object *obj)
{
     standard stuff, mostly zeroing registers.
}

void msp430_cpu_reset_exit(Object *obj)
{
     MSP430CPUClass *mcc = MSP430_CPU_GET_CLASS(obj);
     CPUState *cs = CPU(obj);
     CPUMSP430State *env = cpu_env(cs);
     MemTxResult res;

     if (mcc->parent_phases.exit) {
         mvv->parent_phases.exit(obj);
     }

     /* Load PC from the Hard Reset interrupt vector. */
     env->pc = address_space_lduw(cs->as, 0xfffe, MEMTXATTRS_UNSPECIFIED, &res);
     assert(res == MEMTX_OK);
}

void msp430_cpu_class_init(ObjectClass *c, void *data)
{
     MSP430CPUClass *mcc = MSP430_CPU_CLASS(c);
     ResettableClass *rc = RESETTABLE_CLASS(c);

     resettable_class_set_parent_phases(rc, NULL,
                                        msp430_cpu_reset_hold,
                                        msp430_cpu_reset_exit,
                                        &mcc->parent_phases);
}

The loader device populates ram during the reset hold phase, so I believe you need to wait 
until after that is complete to perform the load, thus the reset_exit hook.


r~

