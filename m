Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CE0C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 02:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQDt-0007en-3U; Sun, 26 May 2024 22:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBQDo-0007eD-Nb
 for qemu-devel@nongnu.org; Sun, 26 May 2024 22:36:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBQDm-00062w-VQ
 for qemu-devel@nongnu.org; Sun, 26 May 2024 22:36:24 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f8f30712d3so1280678b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 19:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716777381; x=1717382181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTqBcAftSmyb55JIwdk8ulhYiyWwM+0L3OBZJgpw2UI=;
 b=t/uIxfdfQZueZmtw2n6QGp+68hkNSDYE5byAcJeggCRGb3nAgo+mPIZ3ss2efuwuuh
 w+vhWu0IYugucbcj0JEGaV9h8dMuUjnIGywmPL45WPdEsLuBU6Glr1FOH5dyrTscP532
 3LEDuMx/e0r0SN5bbxTRkKXD+vypVlcxRfecpHYvDVuepK7VId6/BnkMDnwie77CKXVO
 s6Go38SuYwQ4bSu0eJn7v8r0Xd55UM7uEcXfWzUHCkMO/PPtGG56HwolBcxREgBStKZB
 RevTv0BMkSofR7Xyl/FXqtdWkd40z3Z14l5pVJAf9DGH88VSiN6milXmC0QGv09kM3w2
 Pvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716777381; x=1717382181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eTqBcAftSmyb55JIwdk8ulhYiyWwM+0L3OBZJgpw2UI=;
 b=ixu8o1tm9WparV6cqVu243R1aCd6vJzML455ni0a/X+UaZm17RqWTy+t819kC3HTie
 9MZLSpfLVc7+J8pKCr+jDYPP7FT/XH284s1qMaHitUO6HxaU46deVTNPkPjSWJ+5kZUL
 dG87XzXNi+xGE31OAia9fIsNznFhQp/q/a4HQUaTjU0ErKfOCG8vgwgWGXwqxew7WyxC
 S71kpwJgFE+twIpa3xuwosMtEGhxZxufbzA6WkgYdPkNBfyxk6mw5nY2VpAw36vHMRhQ
 xn0g/k0ivJJ4uoBf4QTEYWOxLgbRVqPxU9ZrlZSUvLNjdiJuu78l+ETICi5uEgk2sJV+
 apXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXidEj9VRlLdaeZWxwk8kvJ3h2ljPNtEJpyCOkrBouytA3E/V7TeV0CX4V7SVrqeaDA9knrozqZXihh47e6/y5iqSgc/vY=
X-Gm-Message-State: AOJu0Yz0nRiVxZ4yzqDSs7f5xXkXv/gDTNmm++tenlE4Qzc44p5wjWV5
 iEbaGFrTwauIDb9xteeGaIBzs4Uz2f7njMtaaZnM6vkIR+pnDywHt8eSjRLl/PA+9pj3oQJXej9
 X
X-Google-Smtp-Source: AGHT+IEKAuCn1nYTk2rvFkxkJmvCyk+GL7Z5VF6EsNxvQ/TlIvuVQDoKmJbEcAKTmvnRNHUBMoCR1Q==
X-Received: by 2002:a05:6a21:339e:b0:1a9:509c:eba6 with SMTP id
 adf61e73a8af0-1b212e135c3mr11887729637.25.1716777381110; 
 Sun, 26 May 2024 19:36:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe64f8sm3999198b3a.151.2024.05.26.19.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 19:36:20 -0700 (PDT)
Message-ID: <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
Date: Sun, 26 May 2024 19:36:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/25/24 13:50, Bernhard Beschow wrote:
> 
> 
> Am 25. Mai 2024 13:41:54 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>
>>
>> Am 5. März 2024 13:52:34 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> If translation is disabled, the default memory type is Device, which
>>> requires alignment checking.  This is more optimally done early via
>>> the MemOp given to the TCG memory operation.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Hi,
>>
>> This change causes an old 4.14.40 Linux kernel to panic on boot using the sabrelite machine:
>>
>> [snip]
>> Alignment trap: init (1) PC=0x76f1e3d4 Instr=0x14913004 Address=0x76f34f3e FSR 0x001
>> Alignment trap: init (1) PC=0x76f1e3d8 Instr=0x148c3004 Address=0x7e8492bd FSR 0x801
>> Alignment trap: init (1) PC=0x76f0dab0 Instr=0x6823 Address=0x7e849fbb FSR 0x001
>> Alignment trap: init (1) PC=0x76f0dab2 Instr=0x6864 Address=0x7e849fbf FSR 0x001
>> scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
>> fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
>> imx-sgtl5000 sound: ASoC: CODEC DAI sgtl5000 not registered
>> imx-sgtl5000 sound: snd_soc_register_card failed (-517)
>> Alignment trap: init (1) PC=0x76eac95a Instr=0xf8dd5015 Address=0x7e849b05 FSR 0x001
>> Alignment trap: not handling instruction f8dd5015 at [<76eac95a>]
>> Unhandled fault: alignment exception (0x001) at 0x7e849b05
>> pgd = 9c59c000
>> [7e849b05] *pgd=2c552831, *pte=109eb34f, *ppte=109eb83f
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
>>
>> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
>>
>> As you can see, some alignment exceptions are handled by the kernel, the last one isn't. I added some additional printk()'s and traced it down to this location in the kernel: <https://github.com/torvalds/linux/blob/v4.14/arch/arm/mm/alignment.c#L762> which claims that ARMv6++ CPUs can handle up to word-sized unaligned accesses, thus no fixup is needed.
>>
>> I hope that this will be sufficient for a fix. Let me know if you need any additional information.
> 
> I'm performing a direct kernel boot. On real hardware, a bootloader is involved which probably enables unaligned access. This may explain why it works there but not in QEMU any longer.
> 
> To fix direct kernel boot, it seems as if the "built-in bootloader" would need to be adapted/extended [1]. Any ideas?

I strongly suspect a kernel bug.  Either mmu disabled or attempting unaligned access on 
pages mapped as Device instead of Normal.


r~

