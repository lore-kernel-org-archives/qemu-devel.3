Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3356ECD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 20:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrOJP-0000n0-OI; Mon, 01 Apr 2024 16:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrOJO-0000mc-7F
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:31:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrOJM-0007np-JJ
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:31:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e0edd0340fso40052815ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712003479; x=1712608279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+g0DlDHSXsaMdF3O5I6NJvsT6PlpJpoSncuaYH0IQ04=;
 b=z3dOndBrdCbQCZmQHar5C7blw3+249YSdFzLOkG2chc24KifyzTuA+x8A3tnAR+m4F
 b/1o0PVrIO0Wngh3TZestRukcYC61fP0lX7jitnCvtw9G3yj0XrSnfF2NaHij25pD/2G
 mNfu1ZWdWNwihLXscFbzRgBXlPsY4tocgtNooLYtRMBd/1wZXMbkDwvaasiw3LdA3RK5
 GypjuOeVRDqQFI5EUeSoe5L/whJhnrwHq07cLoHJXQHq+rU+3SsWvYqaX1zmVskf5YQ5
 TR+0oML1NQrETOeAU3fuIct8DjOCAmfz3oqcunGUiom/ytD5y2g6rwo1qhPuiI6FSOqj
 WhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712003479; x=1712608279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+g0DlDHSXsaMdF3O5I6NJvsT6PlpJpoSncuaYH0IQ04=;
 b=cp7AWq68hGxu3u0Q/iza7FbTqrNmU/sG4/daLzRJUyDKHWgYkWkIbiIAjyulb//MhX
 50ioc2T/KlzKldkQc5hmLLYuL5Ji9fV+BYZ75gu89TNLZMKj4bFDAb8+GjBjSQ6587Uc
 3tCsT5Y7xf3ptLxuMSt2L3MO5uKIgEdc57qik7lhQLy2fR78y9DrCcncQIXRJ4ZuL/pV
 bZc+QhVqR1yUF3Qlv+LoVj/NhGv4FkGs+EdRYwyPn6INTMXxt1eid8vCrPkMOlsAPFu7
 30tissh95bYHTIjEXECqwhBQvfCi5NIrSEjajgF78LA2GGwau5YvIvQEq1rk4Qyblkr6
 1K3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU//yl6+1HbWMsP5qCnk/Py80gMM9cSgL+bYlsF2ZGsjTJf0NbjViDqGKRwpoHLhstekd6HOyNTLEsA/q+J60+L0bWN1Kk=
X-Gm-Message-State: AOJu0YzO7wxrNZdMmFJ80UzRMhBVO3jkj+Orp2A2nqtOpzML/qieQqz5
 2pWzGs2Oy3T08GpDbJHfjvudkgU8tCxTFR2CrpIBBhE2xeKva7eF9jOov9NYbu0=
X-Google-Smtp-Source: AGHT+IHl7A0UNZtvtYPVerlHAe/E9j+UKSyJjqhMJkCGO4W/JnIeT7+duEMw205hrX1IXuUTcWXQ+w==
X-Received: by 2002:a17:903:22c6:b0:1e2:6b80:a25a with SMTP id
 y6-20020a17090322c600b001e26b80a25amr164598plg.7.1712003478977; 
 Mon, 01 Apr 2024 13:31:18 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170903230b00b001e0a28f5ad0sm9380293plh.37.2024.04.01.13.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 13:31:18 -0700 (PDT)
Message-ID: <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
Date: Mon, 1 Apr 2024 10:31:15 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Point where target instructions are read
To: Gautam Bhat <mindentropy@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/1/24 09:50, Gautam Bhat wrote:
> Hi,
> 
> Some background: I am trying to write a CPU emulator for MSP430 with
> Qemu. I am loading the MSP430 program as follows using the generic
> device loader:
> 
> /qemu-system-msp430 -machine msp430-launchpad -device
> loader,file=simple_test -d in_asm,out_asm
> 
> I have implemented somewhat the TranslatorOps callbacks and my sample
> output with some prints is as follows:
> 
> ===msp430_tr_disas_log:204===
> 
> OUT: [size=51]
>   -- guest addr 0x00000000000007fa + tb prologue
> 0x7fff6403fe00:  8b 5d f0                 movl     -0x10(%rbp), %ebx
> 0x7fff6403fe03:  85 db                    testl    %ebx, %ebx
> 0x7fff6403fe05:  0f 8c 1c 00 00 00        jl       0x7fff6403fe27
> 0x7fff6403fe0b:  c6 45 f4 01              movb     $1, -0xc(%rbp)
> 0x7fff6403fe0f:  e9 00 00 00 00           jmp      0x7fff6403fe14
> 0x7fff6403fe14:  c7 45 00 fc 07 00 00     movl     $0x7fc, (%rbp)
> 0x7fff6403fe1b:  48 8d 05 1e ff ff ff     leaq     -0xe2(%rip), %rax
> 0x7fff6403fe22:  e9 f1 01 fc ff           jmp      0x7fff64000018
> 0x7fff6403fe27:  48 8d 05 15 ff ff ff     leaq     -0xeb(%rip), %rax
> 0x7fff6403fe2e:  e9 e5 01 fc ff           jmp      0x7fff64000018
> 
> ===gen_intermediate_code:251===
> ===msp430_tr_init_disas_context:84===
> ===msp430_tr_tb_start:99===
> ===msp430_tr_insn_start:107===
> ===msp430_tr_translate_insn:122===
> CTX Dump State
> ==============
> pc_first 2044
> pc_next 2044
> is_jmp 0
> max_insns 1
> num_insns 1
> TB flags: 1
> TB cflags: 4278190081
> TB CS base: 0
> TB PC: 2044
> ==============
> Opcode: 0
> is_jmp: 1
> DISAS_TOO_MANY ===msp430_tr_tb_stop:170===
> 
> I was trying to find out where exactly in the Qemu code does it read
> the target instructions from the file loaded (I could trace it to
> load_elf(...) loading the FW file)

Yes, the contents of the file are loaded within load_elf().


> and call my TranslatorOps
> callbacks.  I get the above output continuously in a loop. Also when
> the device generic loader is used, should I set the program counter to
> a specific value?

The boot process must cooperate somehow.

When using loader, you must link the image such that it loads at the pc reset address 
defined by the architecture manual.


r~

