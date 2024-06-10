Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD62C27C53
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 00:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGSlK-0006h7-FR; Sun, 09 Jun 2024 20:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sGSlI-0006gc-1e; Sun, 09 Jun 2024 20:19:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sGSlG-0008Jc-7b; Sun, 09 Jun 2024 20:19:47 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c1ab9e17f6so3302690a91.1; 
 Sun, 09 Jun 2024 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717978784; x=1718583584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m6hqQUkSPE+i8iwc0/b7KUPaUhtT1XxdB1wq55bS3yI=;
 b=UhGbwBd1D5g6wJfDuj1aiy9nGqz0c0zO5Um7k0awxU4oB+gPsdXYOcaYuxjp9U9VsN
 jcSASpmEuTZ37k9b43RCk4WbfOKHDqBsKnKmnbgrYyxoCSvmGWeaiPJu+OepF5kyuSwl
 wBFvZwpUyHrZIPHY4m+OeK8muPhm9HsvE5B1DgR/zz0MSaHMEPz6vqa8C6Y+B9quom5I
 QGjgn9yj+qqE5VvdusFi7fsgrCs9z1cBZSjzcFjHC2mhHJo9NUrqvAMrLLherH2QV220
 uGvj6EN+akaFiLp403Ew+KBP2tHdm5OgcAnLqmpU+EGq5XmJVHE15gpBHkVdoHHGGkqF
 czsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717978784; x=1718583584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6hqQUkSPE+i8iwc0/b7KUPaUhtT1XxdB1wq55bS3yI=;
 b=RoVCZttcgC2AhYJxQJ1Br7q40IDtTzCslL/lo5RZKCvXckWd/hTT1jrsKjOHFBF/zR
 jDwPSfD+zSfioj0PjVCdI5gUH+ln0c3WCsNa2gDLVFAdY7syztzVHSnnRhT5U1Drvq9P
 VPynFS+rJxxlvoV9SzQ6zemRuX20s7TpS2wUFNFkcck9yt3SuF3dGFWh4BpTIFLf73jK
 ls/fdH/A6OQJxAOYIEocFul5hBC945qoD422OpuVA8ZGUIqb9stUbHd+gHb65IY1PyIX
 ZJ/E9ret0Ddk95EnT3InQpOksbfPpFN7ADHUtHGhybctL6tOStWT7KO763hd8paINew1
 dnBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+6+nbeRUebIGsPBDm6IdlHnJeW4fsGR6IsnOtjr3E3WF2vsebJDayEN2err9DN8rKMJLk417Clx+G49piNerMNTod2LU=
X-Gm-Message-State: AOJu0Yzwn7TihFje+PF5Ll8ptfKxXaZNTaNW3v7lXMJS9i+ckrbJz3Q9
 wzVy9FD/rCuoFiUe+u755DtEcWdb06tbbzhaqqnIpia7LFpVl+sj
X-Google-Smtp-Source: AGHT+IHsr2bXMdPJdENF4EZW7l9PJ9PvC3EvCJ1vBbOpIGip8gJk6BGFcaLltucB3oT4TbL9WfeXxQ==
X-Received: by 2002:a17:90a:9f95:b0:2bd:d2f9:c22a with SMTP id
 98e67ed59e1d1-2c2bcc0ddf0mr6905759a91.29.1717978783614; 
 Sun, 09 Jun 2024 17:19:43 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2fae2c6f6sm1810417a91.42.2024.06.09.17.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 17:19:43 -0700 (PDT)
Message-ID: <54aafe24-888f-4339-a0c2-854f3c131874@gmail.com>
Date: Mon, 10 Jun 2024 09:19:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, fam@euphon.net,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, minwoo.im@samsung.com
References: <cover.1717403572.git.jeuk20.kim@samsung.com>
 <5c079578d2e46df626d13eeb629c7d761a5c4e44.1717403572.git.jeuk20.kim@samsung.com>
 <CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 6/8/2024 12:02 AM, Peter Maydell wrote:
> On Mon, 3 Jun 2024 at 09:38, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>> From: Minwoo Im <minwoo.im@samsung.com>
>>
>> This patch adds support for MCQ defined in UFSHCI 4.0.  This patch
>> utilized the legacy I/O codes as much as possible to support MCQ.
>>
>> MCQ operation & runtime register is placed at 0x1000 offset of UFSHCI
>> register statically with no spare space among four registers (48B):
>>
>>          UfsMcqSqReg, UfsMcqSqIntReg, UfsMcqCqReg, UfsMcqCqIntReg
>>
>> The maxinum number of queue is 32 as per spec, and the default
>> MAC(Multiple Active Commands) are 32 in the device.
>>
>> Example:
>>          -device ufs,serial=foo,id=ufs0,mcq=true,mcq-maxq=8
>>
>> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
>> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> Message-Id: <20240528023106.856777-3-minwoo.im@samsung.com>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> Hi; Coverity reported a potential issue with this code.
> I don't think it's an actual bug, but it would be nice to
> clean it up and keep Coverity happy. (CID 1546866).
>
>>   static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>   {
>>       UfsHc *u = (UfsHc *)opaque;
>> -    uint8_t *ptr = (uint8_t *)&u->reg;
>> +    uint8_t *ptr;
>>       uint64_t value;
>> -
>> -    if (addr > sizeof(u->reg) - size) {
> Before this change, we checked addr against (sizeof(u->reg) - size).
>
>> +    uint64_t offset;
>> +
>> +    if (addr < sizeof(u->reg)) {
> Now we changed to check it against sizeof(u->reg).
> That means Coverity thinks it's possible that we could
> have addr = sizeof(u->reg) - 1...
>
>> +        offset = addr;
>> +        ptr = (uint8_t *)&u->reg;
>> +    } else if (ufs_is_mcq_reg(u, addr)) {
>> +        offset = addr - ufs_mcq_reg_addr(u, 0);
>> +        ptr = (uint8_t *)&u->mcq_reg;
>> +    } else if (ufs_is_mcq_op_reg(u, addr)) {
>> +        offset = addr - ufs_mcq_op_reg_addr(u, 0);
>> +        ptr = (uint8_t *)&u->mcq_op_reg;
>> +    } else {
>>           trace_ufs_err_invalid_register_offset(addr);
>>           return 0;
>>       }
>>
>> -    value = *(uint32_t *)(ptr + addr);
>> +    value = *(uint32_t *)(ptr + offset);
> ...so Coverity thinks that this write of a 32-bit value
> might overrun the end of the array.
>
>>       trace_ufs_mmio_read(addr, value, size);
>>       return value;
> Side note: why use uint8_t* for the type of "ptr" in these
> functions? We know it must be a uint32_t* (it comes either from
> the u->reg or from one of these u_mcq_reg or u->mcq_op_reg
> fields, and they must all be uint32_t), and using the right
> type would reduce the number of casts you need to do.

This is probably to make the offset calculation easier (since we can

write `addr + offset` instead of `addr + offset/4`). But I agree with

you that it can be semantically confusing. I'll fix it.


> It also helps the reader a little, because using a uint8_t
> implies that you're indexing into an array-of-bytes, and
> if you were doing that it would be a bug (because both of
> it not handling endianness correctly and because of it
> not handling alignment correctly).
>
>>   }
>> @@ -423,13 +802,17 @@ static void ufs_mmio_write(void *opaque, hwaddr addr, uint64_t data,
>>   {
>>       UfsHc *u = (UfsHc *)opaque;
>>
>> -    if (addr > sizeof(u->reg) - size) {
>> +    trace_ufs_mmio_write(addr, data, size);
>> +
>> +    if (addr < sizeof(u->reg)) {
> Similarly here we changed the bounds check we were doing.
>
>> +        ufs_write_reg(u, addr, data, size);
>> +    } else if (ufs_is_mcq_reg(u, addr)) {
>> +        ufs_write_mcq_reg(u, addr - ufs_mcq_reg_addr(u, 0), data, size);
>> +    } else if (ufs_is_mcq_op_reg(u, addr)) {
>> +        ufs_write_mcq_op_reg(u, addr - ufs_mcq_op_reg_addr(u, 0), data, size);
>> +    } else {
>>           trace_ufs_err_invalid_register_offset(addr);
>> -        return;
>>       }
>> -
>> -    trace_ufs_mmio_write(addr, data, size);
>> -    ufs_write_reg(u, addr, data, size);
> thanks
> -- PMM


Thanks for the detailed explanation! I will prepare a patch to fix the 
coverity issue.


Thanks,

Jeuk


