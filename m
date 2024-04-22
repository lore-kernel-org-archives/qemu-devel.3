Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9ACC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvWj-0006XF-BC; Mon, 22 Apr 2024 11:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryvWh-0006X6-Tk
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:24:15 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryvWg-0002Nu-BB
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:24:15 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so3657112a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713799452; x=1714404252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wuPcJQup2eopkP1duuuHjqcsoNj8axU1XkE23HZVMiI=;
 b=viUJafmgGspqfoRXaHQtCkwMV6k6h2jK5m55jgbplXV5vnzbLGNNs1XVg8M+H+3VaF
 CHRiraC+UuXnfb40CcloT1HFq/AR2KV4zJ3IL/cqsDdmiSnuVvuNSVebgPXCaJ23F7+z
 bc49lJKX62OynAY+hZXBTDghRtjhK/V5cLf3Wm0UUNG47cDNJtCHQ9USD6F/wkA3b1AQ
 rT3tBoxIEuQ7zFq6ZxURhyRls8RLIhCzBSS0rdrYSswJoLle2B5QI5r59Z3ZKdGN6Zg5
 a7OwcglODWCd0wMNVm/PmP79HHkK3vEuorbU1s+H0GBeRaI9b+kXiyvL9eONcL1sv13y
 CF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713799452; x=1714404252;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wuPcJQup2eopkP1duuuHjqcsoNj8axU1XkE23HZVMiI=;
 b=SRH8pvDi8300hh9dteQxUzlp+j1Q1ShsEf3/jDUFUmUR5i3WpjRfAU3PzPTYLmd3xn
 DU23p9ubkxRp2TqHJX2ukHOtPGzSznnPtnRzrssmvlr8sjkAPISs7a+ia6SlpAie7Hze
 AXFk59V4c4rkB45g7IwiCB3ZgUEgqxbQVhncFztFt/glvUeVl4hq2zA1jMHvwKNASgQ0
 yA/mwC7ct8qXtWmbmLFOkD0Lml2IjjTwKBTH5Bnv0NYyloooxQpep39n4rcQctKIweOF
 q6ediXwiUaj339PHrg7VPPkOJvt23eak+V6hmyxBU0RBPvqC2pX7+npNQubIvwHbE0bU
 AOUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBM0Hjy4kYsZu2ruQwB095DQ8pkdJRiU2H7GS4UfbDUMorFm04/Y0PRzMk/7KdSD055EhsYDm/P9EWwdB7dzENSpUSt9k=
X-Gm-Message-State: AOJu0YzlG7WjUlcdeNLS1cgn+oM0Hj+YqE3nMovPpIkMQAPPprRclyGs
 YEtKZ6dGddhwTUc5YoeLFzZZEt8fo21j6VvvyO1RF97sjtDliG+YCZDZ2vNS120=
X-Google-Smtp-Source: AGHT+IHX8z4mCiFiAJUvWEbTVXkDF5iDTJ0sV2r0ndRfbZGn6pTPb4UFgwjCdSiWHQZJhtyA/v/QZw==
X-Received: by 2002:a17:90a:f494:b0:2a9:f3d1:c0db with SMTP id
 bx20-20020a17090af49400b002a9f3d1c0dbmr9189353pjb.24.1713799451947; 
 Mon, 22 Apr 2024 08:24:11 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a17090aba0100b002a7b1c7db84sm9698124pjr.2.2024.04.22.08.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 08:24:11 -0700 (PDT)
Message-ID: <0bab0cf5-0d74-48ff-9977-9f52471b717f@linaro.org>
Date: Mon, 22 Apr 2024 08:24:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
 <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
Content-Language: en-US
In-Reply-To: <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 4/22/24 08:21, Richard Henderson wrote:
>>> For Arm's CPUs they fall into two categories:
>>>   * older ones don't set MT in their MPIDR, and the Aff0
>>>     field is effectively the CPU number
>>>   * newer ones do set MT in their MPIDR, but don't have
>>>     SMT, so their Aff0 is always 0 and their Aff1
>>>     is the CPU number
>>>
>>> Of all the CPUs we model, none of them are the
>>> architecturally-permitted "MT is set, CPU implements
>>> actual SMT, Aff0 indicates the thread in the CPU" type.
>>
>> Looking at the TRM, Neoverse-E1 is "MT is set, actual SMT,
>> Aff0 is the thread" (Aff0 can be 0 or 1). We just don't
>> model that CPU type yet. But we should probably make
>> sure we don't block ourselves into a corner where that
>> would be awkward -- I'll have a think about this and
>> look at what x86 does with the topology info.
> 
> I'm suggesting that we set things up per -smp, and if the user chooses a -cpu value for 
> which that topology doesn't make sense, we do it anyway and let them keep both pieces.

... but more practically, it allows experimentation at -cpu max, without having to build 
in anything cpu-specific.  Good to know about the E1 though...


r~


