Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4812BCD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 21:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrP5Z-0002ep-W7; Mon, 01 Apr 2024 17:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrP5Y-0002eh-VP
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:21:08 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrP5X-0000lV-6M
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:21:08 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso2637978a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712006466; x=1712611266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rc0pprj1HIsimyTdJHBoSHEdTqF8XxM9/teRgIyElxk=;
 b=YNqLwUJdpvKXGh8MjxjVW6gKU0JnSP42qJ+FyFZR/wDV2y5ipHFDMGFH+8AbZyH8VZ
 cbnPOOb7DXF1rlLcNXf3jnN1oKVfJImDEQYf2u6heDfDy1i1UGr2N2fpYoJsyxuT7fxO
 fZCULY1YLX6koCXWx4PhX+USKdDvnxFscuPEe5HG1O1mluI0gmlFknMjS1Y2k6w+1/on
 K7pxFOlurkzDLKZaV/eeATsRnhQ36rMICz2VOj+gq4CDds0LeP5IS++xaS8dlHe2+c6g
 R/PQgMETe8gmGnpfc05ulWsuOn/YiB5BKxq2evA8uxAo2M1AbJ6yQXGWMGXOPKcQlaLa
 dPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712006466; x=1712611266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rc0pprj1HIsimyTdJHBoSHEdTqF8XxM9/teRgIyElxk=;
 b=KvjtnSuZf5gSlxPxQhIRV7gdJEwGOQ9lq90P6k1749lO3e6Yfj1VgXMYC1GNuti9tP
 wVQg07DtB9qz4AqtrWlYsZDaEImZ+mSEId0OWL2P7gyIsgyb2OVEDUwkAVWT8WNUITxY
 sI/X53gkiuGpD93lYt39ZXg2dT+KcHLiEPkCh9l6ltETJLli7VX1BSUCLa/b4cfIfm66
 MPmoMrUK0cou8enlzbJBg8bdL2BLDAmEVCSiFcT4DmHoJ1FyiiZn36hk7MJr1t+Rws4w
 z0jALMEKGgQNNGyBv+pTiBNF/1vkH3hg/kJfV4gF0pNLSWNyz3UM/F0IenTO5IqrVfwg
 yV3w==
X-Gm-Message-State: AOJu0YxJd/6X+nzAd/VMa7rCr3tKFzZfhnkzCwTB7oW7ElyBQJEO1zxl
 Jyv5MmrGDqEzw+WfictyLMfqBgvDTcnR5wNzrkboLBFc4DobueE0Skel9pM49C4=
X-Google-Smtp-Source: AGHT+IG5w/c9lbeXJygb0Os+U+FN/EzZ5ltGIVY6gclm+Q5KybcDxQY/ZFelwLmp9zicyebI1VMKEw==
X-Received: by 2002:a17:90a:5286:b0:29f:f1f0:88c2 with SMTP id
 w6-20020a17090a528600b0029ff1f088c2mr7768145pjh.4.1712006465649; 
 Mon, 01 Apr 2024 14:21:05 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a17090ad68300b002a21b9805f8sm5752553pju.17.2024.04.01.14.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 14:21:05 -0700 (PDT)
Message-ID: <f7e67270-5ff1-4d93-979c-3b501d8fca98@linaro.org>
Date: Mon, 1 Apr 2024 11:21:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: mask upper iaoq bits when returning to
 narrow mode
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240401145201.2175873-1-svens@stackframe.org>
 <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org>
 <87msqczujz.fsf@t14.stackframe.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87msqczujz.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 4/1/24 10:39, Sven Schnelle wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 4/1/24 04:52, Sven Schnelle wrote:
>>> For unknown reasons, Java 1.5 on 64-bit HP-UX 11.11 does signed
>>> computation of the new IAOQ value in the signal handler. In the
>>> current code these bits are not masked when returning to narrow
>>> mode, causing java to crash.
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> ---
>>>    target/hppa/sys_helper.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
>>> index 208e51c086..3bbc2da71b 100644
>>> --- a/target/hppa/sys_helper.c
>>> +++ b/target/hppa/sys_helper.c
>>> @@ -83,6 +83,10 @@ void HELPER(rfi)(CPUHPPAState *env)
>>>        env->iaoq_f = env->cr[CR_IIAOQ];
>>>        env->iaoq_b = env->cr_back[1];
>>>    +    if (!(env->cr[CR_IPSW] & PSW_W)) {
>>> +        env->iaoq_f &= 0xffffffff;
>>> +        env->iaoq_b &= 0xffffffff;
>>> +    }
>>
>> This shouldn't be needed, because we are already masking these bits
>> later, in cpu_get_tb_cpu_state.  But I do have some cleanups in this
>> area, and perhaps one of them matters.
> 
> Ouch. Appologies, i removed that masking to make 64 bit work, but forgot
> about that. Sorry. I tried your branch, but i'm not able to boot 64 bit HP-UX
> (it wasn't working before without additional changes, so your branch
> doesn't break it). However, i would like to get your oppinion before
> debugging. The code is:
> 
> IN:
> 0xef4680000002c18:   20 20 08 01   ldil L%-40000000,r1
> 0xef4680000002c1c:   e4 20 e0 08   be,l 4(sr7,r1),sr0,r31
> 0xef4680000002c20:   34 16 00 72   ldi 39,r22
> 
> IA_F 0ef46800:0000000000002c23 (0ef4680000002c23)
> IA_B 01e27c00:ffffffffc0000007 (01e27c00c0000007)
> PSW  000000000004000f CB   0000000000000000 ---------C----QPDI
> GR00 0000000000000000 GR01 ffffffffc0000000 GR02 0000000000002ac3 GR03 000000007a000000
> GR04 0000000000000002 GR05 000000007a000034 GR06 000000007a000040 GR07 000000007a000050
> GR08 000000007a0000e0 GR09 8000000040001000 GR10 0000000000000003 GR11 0000000000000006
> GR12 00000000001ecee8 GR13 00000000ffffffff GR14 0000000000000801 GR15 0000000000000006
> GR16 80000000400020c0 GR17 000000000001e720 GR18 0000000000000008 GR19 0000000000000000
> GR20 000000000ef46800 GR21 000000007a000060 GR22 0000000000000000 GR23 000000007a000050
> GR24 0000000000000000 GR25 0000000000000000 GR26 000000007a0020f0 GR27 0000000040008410
> GR28 0000000000000002 GR29 0000000000000000 GR30 000000007a002160 GR31 0000000000002c27
> RC   000000007fffffff CR1  0000000000000000 CR2  0000000000000000 CR3  0000000000000000
> CR4  0000000000000000 CR5  0000000000000000 CR6  0000000000000002 CR7  fffffffffffb0000
> PID1 000000000000256f PID2 0000000000007306 CCR  00000000000000c0 SAR  0000000000000004
> PID3 0000000000000000 PID4 0000000000000000 IVA  000000000002a000 EIEM ffffffffffffffff
> ITMR 00000005d637f804 ISQF 000000000ef46800 IOQF 0000000000002aab IIR  000000006bc23fd9
> ISR  0000000004d0d000 IOR  400000007a0020cc IPSW 000000000004000f EIRR 0000000000000000
> TR0  0000000000abfe68 TR1  000000000465d1d6 TR2  0000000000000002 TR3  0000000000000000
> TR4  0000000000000000 TR5  00000001757973bb TR6  00000000000021eb TR7  000000007a0020e0
> ISQB 000000000ef46800 IOQB 0000000000002aaf
> SR00 0ef46800 SR01 00000000 SR02 00000000 SR03 00000000
> SR04 0ef46800 SR05 04d0d000 SR06 01e27c00 SR07 01e27c00
> 
> INT   3529: instruction tlb miss fault @ 0000000001e27c00:ffffffffc0000007 for 0000000001e27c00:40000000c0000004
> INT   3530: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
> INT   3531: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
> INT   3532: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
> INT   3533: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
> 
> So the PSW indicates narrow mode, but IAOQ seems to contain all the
> ffff... bits.

I believe that the IAOQ *should* contain all of the bits.  The bits should only be 
discarded when we form the GVA -- exactly like "ldb 0(r2)", where r2 contains all of the 
offset bits.  In particular, I believe that "b,l .+8,r2" should copy all of those bits to 
r2 from IAOQ_Back+4 and the fact that mainline crops those bits is a bug.


> Also interesting is that the second TLB miss (INT 3530)
> misses the Space ID.

That is a bit curious, yes.

> Any thoughts? Otherwise i need to investigate and make a wrong patch
> again :-)
> 
> The only patch i have on top which touches target/hppa is the space id
> hashing mask patch:

Ok.  I do have an hppa 11.11 iso -- for clarity, what is your command-line?


r~

