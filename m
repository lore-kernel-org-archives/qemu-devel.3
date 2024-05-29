Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3E3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKyH-0005fe-KH; Wed, 29 May 2024 11:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCKyF-0005fE-MX
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:12:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCKy9-00005a-7R
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:12:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4202ca70318so19322185e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716995518; x=1717600318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v8hj4Mc2eBtuJq+jqJakwnyg6LK1/42l9mBmMH1kjzA=;
 b=MFCa4WceZXoKVcrhd++DaSvkyh8A5AYY+insTq104cYA8PzLrmSF+Ni7qj5bcyYFEh
 3s9xj2CbL2aCmMQRMevdnncRWC2Uk9MFj4ykxDOGwIPYxI0Teq7slQ8nWBXcHc8fv6UL
 FmliIZgHqziz5/ZitfQ/a8v756ulV5LsYuSYg+r96vKA7TNeJAli9FjY5OuCG8hWkuKx
 4JhO/drL8QICFu+kYYyIYm2h+z8D0HyaS/zN5nFN05tQ/nnDR6Zl4vLtwbwyTf7LbLGT
 4VTP4s6PrXEGaehrVn5A5Si5I4G9RHjZRk0lbdbb1tTUYYPoxVb+UQ/2rm5lrFIA9lml
 AhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995518; x=1717600318;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v8hj4Mc2eBtuJq+jqJakwnyg6LK1/42l9mBmMH1kjzA=;
 b=asXQH1saR5zq9Dx+dt7FMhe8w7gfBDI4thnscvImOQ4Qik/6mWrZtP5Ob4Vf0AD1L9
 6mZK6PD0VxJCI1OjO5Bd5oxnC8TlmY+SUGh0XGHAsV4RvgVVgZUpfzSFL+LktxvkMgJG
 b/nm6Y/KBMRzdCv6waBFUsFeRhZIegBjHwPu3M3v14XwbJfqHtwYTTQylbTCNkRx+EBi
 g8HgoaSkb42elUz5sdjYmcmsPvqEJLn06XubBSn8P8lRuCzjGs2YizQyNsia7DfH5get
 hJqAVND+qPDCMibzDOe182hPJd9JQf0jsTWYP/YuVuk82rhAS5CyWMz/rMQaU2k3SW1s
 2J3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURf0bzGKZA3XpqFmq1KYIvoKvnMlYWJ8zPHR57Vj2Rs3KXBNyNB7MvzdUJWQnw6ugW8EzZPkay6f54ALGzDVPrjKSWAtw=
X-Gm-Message-State: AOJu0Yw/rhCHhTBEAB3hqApkdjO6CoAJGL7Qx9ppSYTW8+ysB26HWfZI
 epdhum+pXdvCI83Txtdy4omSBz8gYNfgY+qjjI5IaCZkt773R8HzeG90H38kdq0=
X-Google-Smtp-Source: AGHT+IHvvBE2lbXFVAEtz+g+5cX1FIpquCZwVV1YInbnzqa1lUl4Svl+1mrTPdi2fXbeIAgUf2O9Ow==
X-Received: by 2002:a05:600c:5806:b0:421:877:9db7 with SMTP id
 5b1f17b1804b1-421089b2232mr119568345e9.2.1716995518509; 
 Wed, 29 May 2024 08:11:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f1399asm216622445e9.11.2024.05.29.08.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 08:11:58 -0700 (PDT)
Message-ID: <d1ded13f-a2bf-4ce0-aabb-22dbdee25ce5@linaro.org>
Date: Wed, 29 May 2024 17:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hppa: Add support for an emulated TOC/NMI button.
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Sven Schnelle <svens@stackframe.org>, Anton Johansson <anjo@rev.ng>
References: <20220131213529.17404-1-deller@gmx.de>
 <20220131213529.17404-4-deller@gmx.de>
 <c6f9b777-4b6f-a71a-ce90-c08e5313e2a8@amsat.org>
Content-Language: en-US
In-Reply-To: <c6f9b777-4b6f-a71a-ce90-c08e5313e2a8@amsat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Helge & Richard,

Nevermind the missed review comments, I'm revisiting this
patch while looking at building libtcg-hppa.so.

On 1/2/22 00:56, Philippe Mathieu-Daudé wrote:
> On 31/1/22 22:35, Helge Deller wrote:
>> Almost all PA-RISC machines have either a button that is labeled with 
>> 'TOC' or
>> a BMC/GSP function to trigger a TOC.  TOC is a non-maskable interrupt 
>> that is
>> sent to the processor.  This can be used for diagnostic purposes like 
>> obtaining
>> a stack trace/register dump or to enter KDB/KGDB in Linux.
>>
>> This patch adds support for such an emulated TOC button.
>>
>> It wires up the qemu monitor "nmi" command to trigger a TOC.  For that it
> 
> s/qemu/QEMU/ (few others).
> 
>> provides the hppa_nmi function which is assigned to the 
>> nmi_monitor_handler
>> function pointer.  When called it raises the EXCP_TOC hardware 
>> interrupt in the
>> hppa_cpu_do_interrupt() function.  The interrupt function then calls the
>> architecturally defined TOC function in SeaBIOS-hppa firmware (at 
>> fixed address
>> 0xf0000000).
>>
>> According to the PA-RISC PDC specification, the SeaBIOS firmware then 
>> writes
>> the CPU registers into PIM (processor internal memmory) for later 
>> analysis.  In
> 
> Typo "memory".
> 
>> order to write all registers it needs to know the contents of the CPU 
>> "shadow
>> registers" and the IASQ- and IAOQ-back values. The IAOQ/IASQ values are
>> provided by qemu in shadow registers when entering the SeaBIOS TOC 
>> function.
>> This patch adds a new aritificial opcode "getshadowregs" (0xfffdead2) 
>> which
> 
> Typo "artificial".
> 
>> restores the original values of the shadow registers. With this opcode 
>> SeaBIOS
>> can store those registers as well into PIM before calling an 
>> OS-provided TOC
>> handler.
>>
>> To trigger a TOC, switch to the qemu monitor with Ctrl-A C, and type 
>> in the
>> command "nmi".  After the TOC started the OS-debugger, exit the qemu 
>> monitor
>> with Ctrl-A C.

IIUC you are abusing TOC to communicate with SeaBIOS, filling
iaoq_f with SeaBIOS-specific 0xf0000000, unrelated to the pa2.0
spec; is that correct?

I'm trying to see how to integrate firmware specific knowledge
into libtcg-hppa.so which is supposed to be only architectured
parts (usually we handle firmware stuffs in machine code, not
translation one).

Regards,

Phil.

>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   hw/hppa/machine.c        | 35 ++++++++++++++++++++++++++++++++++-
>>   target/hppa/cpu.c        |  2 +-
>>   target/hppa/cpu.h        |  5 +++++
>>   target/hppa/helper.h     |  1 +
>>   target/hppa/insns.decode |  1 +
>>   target/hppa/int_helper.c | 19 ++++++++++++++++++-
>>   target/hppa/op_helper.c  |  7 ++++++-
>>   target/hppa/translate.c  | 10 ++++++++++
>>   8 files changed, 76 insertions(+), 4 deletions(-)
>> +static const TypeInfo machine_hppa_machine_init_typeinfo = {
>> +    .name = ("hppa" "-machine"),
> 
>         .name = MACHINE_TYPE_NAME("hppa"),
> 
>> +    .parent = "machine",
>> +    .class_init = machine_hppa_machine_init_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { TYPE_NMI },
>> +        { }
>> +    },
>> +};


