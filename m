Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE5EC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOAo-0008M9-Qx; Mon, 12 Aug 2024 02:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAn-0008LW-06
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:04:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAl-00023G-5C
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:04:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36d2a601c31so1958360f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723442689; x=1724047489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OmxQ1UiezJn7kEH2xHoYS23Qe841zRKWJ62bwFmeLhM=;
 b=mkZ/Y1/U4LMuvEpnBYTjKpgjLs4VManZs9pjR3WHWbo03nL9WvQ7T3Ud8VzpQsehb3
 vrfqBqZ6SF6m5qGWB28z9fMUy01MRivKKp41ULy2vBv3XNIaXRz5C5wCIaruNyjH1jPI
 1+lBj/VE2j2twzPtlVhJj9NpKaK/rdLxNn48UvHEdyYa24zFWCumWsE+IxYYE54Oyr9c
 INCssD1gQ0yS7qwPvDsWVbCYEfu44aY0Xx8ZoQmaA9MNjqKm9tkHD47XcK2MEKy4jcv/
 ZX/8kBZkk+NSX79Bt2oroCDIwpTu0T9WqVMJw7Rd3ul3pLEscjpGBP9xQAqc3E42swWL
 yPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723442689; x=1724047489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OmxQ1UiezJn7kEH2xHoYS23Qe841zRKWJ62bwFmeLhM=;
 b=Y061VzWtT4BjGMDMsRG6Gy1mhZF2QmGCLRJWnH67SNa7DseWm+0uODp5QKAwPI2RbG
 C+yjagagl5IQGdKC/pJ3IDUtDTvNInGOyr17Iat2OHhOnIja6dQK+Ghlf5/HqdRXa4of
 dOg3kn8Dkk+81yfudYc+kUZZElsBd6rnziuDOYh6yOJVl4lJMSfcNyOJG9Th9FVCqS1B
 fdNiu6Q4KwgqbvpbfwlrGrG9zYpZZvyk1Oh+7BDCPBucX7t23XbYsPIZHm/DvEdDlNEq
 15NK5SNJic3A/FqJxAaOAaVTpqOejzuQzBChi9C8niHNbotqN+KwQ/rIL9h31A3hd0sP
 hSMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv2ZiPdM3D+vmL0yFgu00iXvliM6ZtrbNU4t81DjBwss5fchIXK+9WD8VoOSi24ltYjjPDs3aFHUoU@nongnu.org
X-Gm-Message-State: AOJu0YxRX1T0zuOQD/EgNYK64Pxla6y2Md1vGDFGYjFrHor4Z6dEew6I
 KNIikTITAXVsSKwHmYH8H4f+PlSna+/H16+iZCh7iSjUl+iE3/5puytIyo+TIdE=
X-Google-Smtp-Source: AGHT+IGVHzz+Fq6g2lGzyCzR1cKIkwPwhyOMAF4K+y7EKhieq2WS8DckNGo+DAgPlBNpMYOlMOp8xg==
X-Received: by 2002:a5d:4204:0:b0:368:41e0:16c0 with SMTP id
 ffacd0b85a97d-36d5e3c2b97mr4490881f8f.22.1723442689002; 
 Sun, 11 Aug 2024 23:04:49 -0700 (PDT)
Received: from [192.168.71.175] (133.170.88.92.rev.sfr.net. [92.88.170.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm6484940f8f.115.2024.08.11.23.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 23:04:48 -0700 (PDT)
Message-ID: <2506e429-b5ca-4ff1-99a0-2df157321c4d@linaro.org>
Date: Mon, 12 Aug 2024 07:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/mips: Fix execution mode in
 page_table_walk_refill()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240811165407.26312-1-philmd@linaro.org>
 <be719b7b-9096-4d15-9947-8e4003de302d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <be719b7b-9096-4d15-9947-8e4003de302d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/8/24 02:48, Richard Henderson wrote:
> On 8/12/24 02:54, Philippe Mathieu-Daudé wrote:
>> When refactoring page_table_walk_refill() in commit 4e999bf419
>> we replaced the execution mode and forced it to kernel mode.
>> Restore the previous behavior to also get supervisor / user modes.
>>
>> Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>> Reported-by: Waldemar Brodkorb <wbx@uclibc-ng.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2470
>> Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from 
>> mips_cpu_tlb_fill")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/tcg/sysemu/tlb_helper.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/mips/tcg/sysemu/tlb_helper.c 
>> b/target/mips/tcg/sysemu/tlb_helper.c
>> index 3ba6d369a6..e7ae4f0bef 100644
>> --- a/target/mips/tcg/sysemu/tlb_helper.c
>> +++ b/target/mips/tcg/sysemu/tlb_helper.c
>> @@ -940,8 +940,9 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr 
>> address, int size,
>>            * Memory reads during hardware page table walking are 
>> performed
>>            * as if they were kernel-mode load instructions.
>>            */
>> -        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
>> -                           MMU_ERL_IDX : MMU_KERNEL_IDX);
>> +        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL)
>> +                          ? MMU_ERL_IDX
>> +                          : (env->hflags & MIPS_HFLAG_KSU);
> 
> This contradicts the comment above.
> If this code change is correct, then the comment isn't.

OK.

> But the comment certainly makes sense -- page tables are never 
> accessible to user mode.

But we are still dropping the supervisor mode, so OK if I
reword as:

"Restore the previous behavior to also get supervisor modes."

?


