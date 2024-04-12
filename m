Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C78C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKZ0-00040D-WF; Fri, 12 Apr 2024 13:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rvKYz-0003yY-9j
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:19:45 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rvKYx-0001IO-4d
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:19:45 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e3e84a302eso8804415ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712942380; x=1713547180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pKfWM+CvdWFEkgGojd8ew4JZrU+UNJW9I1Aq/Px1mKw=;
 b=jXN/f6ts/LgIZzssdYEWpo3DzWIzI6Zn5q4wHueIShUyoCzhvlUNix9E/lmEwayqEe
 7h3T4eoQo8XlHDRqFevSwBvILeBmcIlknZc8+mm8Q1oXxjF6YrcaskZSJdFBDREAvRp9
 1gK5Bh53UvY8lzufQARLl+jjwiBzZbGAUiTO2pwiJaoNMHQe7R1FMO9S3BeKJo3FRGAr
 PRvGR+fJrc8PAmlefCfmiHYL5pjimTzhEwDxu7J5ReF82j14fsK+TA/lWBeq8IKr9q5s
 Jl7hp40i4eDiyAWUjQzKrk2AToZYJ+Yv9rfj0gPFbNOdShIyDBpnJEbEEMyDz8ePFIs/
 X6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942380; x=1713547180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pKfWM+CvdWFEkgGojd8ew4JZrU+UNJW9I1Aq/Px1mKw=;
 b=ZU3c/r74DE3mNT/X3KtX5FANCdsxn2hgApsNmBlgjEXad+vs35YEGBL9Pwq2iVqs5G
 iX4wL0HGTTnRLfdEc7MZxEmJrRiLeUKNnyfQfCu7aWtFjNBghH5vFwYYwUmeZPIPxKkL
 GnMtPqzSa43ecxrr65m4hy9C3eN2h/WVmYzH+bYJPJj1dgAgS3FEO81Xv8maAUq9urBl
 gq9vyvY0OJwPKbkoZvy8q2go9/ObhiyxY9PkRDy+kC1FDuwVvTHUCPqv2dr+4YDT3nEd
 6+be1rrT6CjuL1yYkSW5XX0F16G3naejTrxd+fSxkpdwRJQsvQr8Gq9o41COXpMYPWPb
 nM6w==
X-Gm-Message-State: AOJu0YyyD/1VTkiwUJ3Kjkn5e40jfg0YX/gpFkUPZZDrgin6dukV0zN7
 ZxGLr/4XA9hn0jOMJYMU2T6NY1QskSVU1qvF0d90cjA2+cp7G8LWQre+EPsWH9U=
X-Google-Smtp-Source: AGHT+IH3B6D3viulP17Qi2o/M/KT06vAqWWmLz6B6trqWZ6DQ3UbO7orXvW91y3XYAQbofWzDI0qRg==
X-Received: by 2002:a17:902:cecc:b0:1e5:2883:6ff6 with SMTP id
 d12-20020a170902cecc00b001e528836ff6mr3683840plg.11.1712942380389; 
 Fri, 12 Apr 2024 10:19:40 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.202])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a170902f29200b001e0da190a07sm3252659plc.167.2024.04.12.10.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:19:40 -0700 (PDT)
Message-ID: <7c65a766-7419-4e73-bccb-43475527734f@ventanamicro.com>
Date: Fri, 12 Apr 2024 14:19:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, alexei.filippov@syntacore.com,
 richard.henderson@linaro.org, Joseph Chan <jchan@ventanamicro.com>
References: <20240409175241.1297072-1-dbarboza@ventanamicro.com>
 <CAFEAcA-XkK8ksZ7aMj-ap4BRw6V8dMJ6hGTozagGAAQfXz_=bg@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA-XkK8ksZ7aMj-ap4BRw6V8dMJ6hGTozagGAAQfXz_=bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 4/12/24 14:12, Peter Maydell wrote:
> On Tue, 9 Apr 2024 at 18:53, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> raise_mmu_exception(), as is today, is prioritizing guest page faults by
>> checking first if virt_enabled && !first_stage, and then considering the
>> regular inst/load/store faults.
>>
>> There's no mention in the spec about guest page fault being a higher
>> priority that PMP faults. In fact, privileged spec section 3.7.1 says:
>>
>> "Attempting to fetch an instruction from a PMP region that does not have
>> execute permissions raises an instruction access-fault exception.
>> Attempting to execute a load or load-reserved instruction which accesses
>> a physical address within a PMP region without read permissions raises a
>> load access-fault exception. Attempting to execute a store,
>> store-conditional, or AMO instruction which accesses a physical address
>> within a PMP region without write permissions raises a store
>> access-fault exception."
>>
>> So, in fact, we're doing it wrong - PMP faults should always be thrown,
>> regardless of also being a first or second stage fault.
>>
>> The way riscv_cpu_tlb_fill() and get_physical_address() work is
>> adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
>> reflected in the 'pmp_violation' flag. What we need is to change
>> raise_mmu_exception() to prioritize it.
>>
>> Reported-by: Joseph Chan <jchan@ventanamicro.com>
>> Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU translation stage")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> I guess from the Fixes: git commit hash that this isn't a regression
> since 8.2 ? That would make it too late for 9.0 at this point in
> the release cycle.

I don't think it's critical enough to push it for 9.0 now. We'll settle for
9.1 and then Michael can pick it for 9.0-stable.


Thanks,

Daniel

> 
> thanks
> -- PMM

