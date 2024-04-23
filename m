Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1B4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 08:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzBJv-0000KX-Fj; Tue, 23 Apr 2024 04:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzBJt-0000KB-14
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:16:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzBJp-0004Xo-RQ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:16:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34a7e47d164so3114461f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713860160; x=1714464960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W5lPLAaje3+CrDLYnS7WWCopE3TtY4vVSEJiivbubqg=;
 b=iP1Fvji48R2BjzuLJBkfNOKrkVKp0XBdzP0MLaZTMS94C7fBO0wRfgZaJfabl0KJ7i
 xCZMK90yLzD0amosd7dBKA2AMZYKyoB0X8KJn1Cj4zSoWjQoSwgpbyg12xWucvvtSdqG
 VsxOHFrUFL7zENRxfZno6sC6OL9kLUqgTOo0wH0JJnBrBHHz568d7oUj/rulW5hsvm8I
 zR/ckX4COrcy+4Zy8BiQex2SIQCdt8qEhEQhxhblx0qe1kW6R2PwdJDbtkvq5H0Pov8e
 PAy+XlwvQahfwsxxI4uRBx7tI0pXeGhuXPil8ZEQgkWpu6TnWhJfGwtA1t6YaWBhDPQB
 Cxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713860160; x=1714464960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W5lPLAaje3+CrDLYnS7WWCopE3TtY4vVSEJiivbubqg=;
 b=bdavCXkLK1SeHU2r5zjLlFeI/JHXnrnSb+2zyhA2HQCOT4aIR2nMuxAbWNBsiosjy2
 FSHmptQS1AWbWNkXHEyDmJSUUyaVzRSoUPUN7GTPx5m81uaKXeSEOOr2G1Tqo+MhzhRB
 tDzE3mBlm3U901gULh1xS11T3G9BQcaul7iCUh23mU8DcDARcU2asawjY3Ss4b2TPPTt
 urKWC+DWhvSWSq2jcnEBuerI69WV4fqzpHdSoYsSdLLo1iiQemep9q4fqJ8XoLoAw/9N
 PPmCAMj8++DaclLPCi6mWw42VEJwo07vHe394QwNseJ7gZZxPtKW9SB969y5Zb9zVMBG
 j4Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE7CPeWJy2LPuLT5srE8iCQMGS6GQI4h39Plyrhlpw5AqtkCDNshUEn80Sj93qGjxlp6t+/QpfEkKbvOT55pW4DIUVTD8=
X-Gm-Message-State: AOJu0YyIXKME//3aNjdwGYucaoW8FRyU53aWFo7DB2oms3yYtmH2TXiO
 cqzgiLggv0Og7JH0aotcUyRQ2ITrLLL6RwjjyP9oESbmOv1qUOCp9L0LNsUmzR4=
X-Google-Smtp-Source: AGHT+IEzbmDF5LErdLSObnRUqcdInV4BW6yCcLkHf0xrqSA8CKDEDlyN0Ds5eRsEw4FDqsphdEVv0A==
X-Received: by 2002:a5d:6150:0:b0:346:d7d9:83ae with SMTP id
 y16-20020a5d6150000000b00346d7d983aemr8996968wrt.52.1713860159770; 
 Tue, 23 Apr 2024 01:15:59 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c4f8200b0041884b79b81sm19249824wmq.1.2024.04.23.01.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 01:15:59 -0700 (PDT)
Message-ID: <24c60165-80b6-453b-8fe0-44df563e34be@linaro.org>
Date: Tue, 23 Apr 2024 10:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
 <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
 <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
 <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 22/4/24 21:03, Volker Rümelin wrote:
> Am 20.04.24 um 07:40 schrieb Mark Cave-Ayland:
>> On 20/04/2024 02:21, Richard Henderson wrote:
>>
>>> On 4/19/24 12:51, Mark Cave-Ayland wrote:
>>>> The various Intel CPU manuals claim that SGDT and SIDT can write
>>>> either 24-bits
>>>> or 32-bits depending upon the operand size, but this is incorrect.
>>>> Not only do
>>>> the Intel CPU manuals give contradictory information between processor
>>>> revisions, but this information doesn't even match real-life behaviour.
>>>>
>>>> In fact, tests on real hardware show that the CPU always writes
>>>> 32-bits for SGDT
>>>> and SIDT, and this behaviour is required for at least OS/2 Warp and
>>>> WFW 3.11 with
>>>> Win32s to function correctly. Remove the masking applied due to the
>>>> operand size
>>>> for SGDT and SIDT so that the TCG behaviour matches the behaviour on
>>>> real
>>>> hardware.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
>>>>
>>>> -- 
>>>> MCA: Whilst I don't have a copy of OS/2 Warp handy, I've confirmed
>>>> that this
>>>> patch fixes the issue in WFW 3.11 with Win32s. For more technical
>>>> information I
>>>> highly recommend the excellent write-up at
>>>> https://www.os2museum.com/wp/sgdtsidt-fiction-and-reality/.
>>>> ---
>>>>    target/i386/tcg/translate.c | 14 ++++++++------
>>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>>>> index 76a42c679c..3026eb6774 100644
>>>> --- a/target/i386/tcg/translate.c
>>>> +++ b/target/i386/tcg/translate.c
>>>> @@ -5846,9 +5846,10 @@ static bool disas_insn(DisasContext *s,
>>>> CPUState *cpu)
>>>>                gen_op_st_v(s, MO_16, s->T0, s->A0);
>>>>                gen_add_A0_im(s, 2);
>>>>                tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State,
>>>> gdt.base));
>>>> -            if (dflag == MO_16) {
>>>> -                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>>>> -            }
>>>> +            /*
>>>> +             * NB: Despite claims to the contrary in Intel CPU
>>>> documentation,
>>>> +             *     all 32-bits are written regardless of operand size.
>>>> +             */
>>>
>>> Current documentation agrees that all 32 bits are written, so I don't
>>> think you need this comment:
>>
>> Ah that's good to know the docs are now correct. I added the comment
>> as there was a lot of conflicting information around for older CPUs so
>> I thought it was worth an explicit mention.
>>
>> If everyone agrees a version without comments is preferable, I can
>> re-send an updated version without them included.
>>
> 
> Hi Mark,
> 
> I wouldn't remove the comment.
> 
> Quote from the Intel® 64 and IA-32 Architectures Software Developer’s
> Manual Volume 2B: Instruction Set Reference, M-U March 2024:
> 
> IA-32 Architecture Compatibility
> The 16-bit form of SGDT is compatible with the Intel 286 processor if
> the upper 8 bits are not referenced. The Intel 286 processor fills these
> bits with 1s; processor generations later than the Intel 286 processor
> fill these bits with 0s.

Is that that OS/2 Warp and WFW 3.11 expect a 286 CPU? QEMU starts
modelling the 486, do we want to consider down to the 286?

> Intel still claims the upper 8 bits are filled with 0s, but the
> Operation pseudo code below is correct. The same is true for SIDT.
> 
> With best regards,
> Volker
> 
>>>     IF OperandSize =16 or OperandSize = 32 (* Legacy or Compatibility
>>> Mode *)
>>>       THEN
>>>         DEST[0:15] := GDTR(Limit);
>>>         DEST[16:47] := GDTR(Base); (* Full 32-bit base address stored *)
>>>     FI;
>>>
>>>
>>> Anyway,
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> Thanks!
>>
>>
>> ATB,
>>
>> Mark.
>>
>>
>>
> 
> 


