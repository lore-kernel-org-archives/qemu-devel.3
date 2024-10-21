Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58315D15D96
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ssE-0001UO-CA; Mon, 21 Oct 2024 09:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1t2ssC-0001UB-RH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:55:04 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1t2ssA-0004Ad-QQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:55:04 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7163489149eso3434375a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729518901; x=1730123701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Lodhy3DnOxtCk6jxdpYZ6o09Bre8FH6l3WoSyssrl0M=;
 b=W6O2wQWUyF5Au1+Pf0h0t4GrqE/2aXQp4OpjJ0o9KkGTHAq5KTqs4UQ2iTFChX8MTE
 DcYel/UuCGTnheCZ86zcr1WagJ75+jnzhfp361i8zLYe5sH2LFoWvLZEKtWbr+rEQ3zt
 sR3GUO+mqU9tvQoG0BKD9y1nuyNId+mDedmTKdv5GIIgtG17vVTSpkxrVB7CT1dQiWAX
 djQOEQrR27T4F1BP7sob5L0X3r9nX2n8dE7KidSjK5zKF8egxIjEYTd58m0K16MxmmqN
 EZk0F0ludPdfuGN2GYp8I81WmzNMBy0GQBwwKGhFE9oekun8xDaIgsxVgzOEW22bSO4p
 ny3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729518901; x=1730123701;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lodhy3DnOxtCk6jxdpYZ6o09Bre8FH6l3WoSyssrl0M=;
 b=TgI1ngd0R4EcopqwcvMSYuzvDQBaF7moR0kFRC+Bkq9Uyy32f3hSPz17cfmjEV3M47
 dngY2prBOTY71HGeOYn4PX7btbGDWOIK478TyXEv9MoB/uAff3gl6uWXye+4yA7oYdTp
 KHQigAUK9c2f8aoOLsX70pnz0gtE2LziVZmI4x6mcKnvU+JxmfAGlG+wkcnSDT6iGf12
 dOBpbaxfg4iI4I0+79uSw5QHgoOIl5iFSq+e0OuaMzVmyvzxxu69ms7D45+ZpiPEpHhn
 LoxXTl7hX1BpzRD+aUXiNLwV5++WCohXq5pyleYTqG+qtGB/2SuWIVvbD0ZzJOsW335Z
 tv3A==
X-Gm-Message-State: AOJu0YxPef1TyaVR1Nyyp4SX1wg4lvviM2sGYYLLIH16BCBCIZnhfW2a
 iPpq4b3ApwMazfPAQaE8ebOMAq+nxjgKyy13qlTowKBJVHC6PDQmQsRHRg==
X-Google-Smtp-Source: AGHT+IExnGJcMsYHx4rVqBD7Zdw87homLEYmwRfguewOGAzZwo4X7ib3hprAoLGx3vQHgF1g+v67LA==
X-Received: by 2002:a05:6a21:164e:b0:1d9:26b7:6ca with SMTP id
 adf61e73a8af0-1d92c5ba7b4mr14836395637.45.1729518901116; 
 Mon, 21 Oct 2024 06:55:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec132fec6sm2892357b3a.68.2024.10.21.06.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 06:55:00 -0700 (PDT)
Message-ID: <3d8463b3-8143-49bb-9f9f-4105927a3502@roeck-us.net>
Date: Mon, 21 Oct 2024 06:54:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] target/i386: finish converting 0F AE to the new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-11-pbonzini@redhat.com>
 <8076e922-1839-4e8e-9dbf-35c064a439fc@roeck-us.net>
 <3fbecfbc-5ba7-4bca-9948-ebf8bf0a1637@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <3fbecfbc-5ba7-4bca-9948-ebf8bf0a1637@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/20/24 23:57, Paolo Bonzini wrote:
> On 10/21/24 03:49, Guenter Roeck wrote:
>> Hi,
>>
>> On Sat, Jun 08, 2024 at 10:40:58AM +0200, Paolo Bonzini wrote:
>>> This is already partly implemented due to VLDMXCSR and VSTMXCSR; finish
>>> the job.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> While testing qemu v9.1, I noticed the following crash when testing qemu-system-i386
>> with pentium3 CPU.
> 
> Is this enough to fix it?
> 
Yes.

> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index ee2a508ae9a..cda32ee6784 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -345,9 +345,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
>           [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
>           [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
>           [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
> -        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
> +        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
>           [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
> -        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
> +        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
>       };
> 
>       static const X86OpEntry group15_mem[8] = {
> 
>>    22:    39 c6                    cmp    %eax,%esi
>>    24:    0f 82 6a ff ff ff        jb     0xffffffffffffff94
>>    2a:*    0f 09                    wbinvd         <-- trapping instruction
> 
> This is a bit weird, as wbinvd is not affected by this patch.  However,
> a checkout of Linux has
> 
>          asm volatile("sfence" : :: "memory");
>          kernel_fpu_end();
> }
> 
> at the end of lib/raid6/sse1.c and it would indeed be affected by this
> patch.  SSE2 was not present in Pentium III, but SSE was.
> 

No idea how the 0x0f 0x09 ends up in the log. I wondered about that as well.

Thanks,
Guenter


