Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F5C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahRw-0004nf-Cb; Thu, 15 Feb 2024 14:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahRM-0004GZ-Hy
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:30:45 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahRJ-00059F-H7
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:30:34 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so1178055a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708025432; x=1708630232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X3jH2JS8Icb9oqLzaU0hfXRD5zoULe7nghMNl44ps/I=;
 b=rJYRTFyiV/xj8LE3IOe+wpkR9iX98qYscp0Tcws93qkcwHIOUq2A2FNxx0JRqBDSQH
 s3z3f71XN0H/YtgapeJkcnAnnzJcNXT3xbe/Eux3KT9+XPNRN3Ede8U7Xjf0pUycW4xS
 w27Q4gbwlo4oQlg1xM/UwKThlXB6yKi4iDCyLNEJW2VQNJVtw6YoANeQ22HhKpSVmBFv
 5dolzc+Y2T1rrlOCTEZ5+xM+scAHD1Dh39KPmSo0vR6ygjdOSwJBwHfKn4WfjLveD/sv
 cz+9BcnJbAFz3qsGa6LXKV0U9W8D4g290oxqTFhQYeg8r2J8u8cHVBt2RXruLuOlK+jI
 WSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708025432; x=1708630232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X3jH2JS8Icb9oqLzaU0hfXRD5zoULe7nghMNl44ps/I=;
 b=cy04g+W6hg+VLO2R8k7vu6lomORy2ojFD0HB/2cZTvlvIzlBQMs1JwYCtFU+V4c9WC
 tjKbAvrNkmbPN3n8GRcKuYk0Owws4yKQBd6gVM2rbV8EKAlpobI71ySnSVr/ycwqwdme
 2ujhslvaheFIW0UFeO0jA72Bo+9u+RAWw9m51Jf0gBgnOUoRkwRBT6+/O1ukVKxRAPAH
 kgoH2/6v2LPttjFGu3j5aZTYvaV1PPwzKs3ZJbqK0rrOOw7jYKciWqfdeCQBNv8+/lQa
 AMN6x1DJaxbudRTFkWdLTEeGYyQdlKFIWSq7R/Ky8ii9vZ3hhZbVbyziw0HgW1xYdV2M
 jwDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtti3YKNh0yLsKC1jea71S0NFSl5jZWReyR5Mpzte82rk1Weg38ZhviKww4vYMSbMXJOVbAmgpHiohg4o3mEaVcYjE80s=
X-Gm-Message-State: AOJu0YwhdTYvcmZOQLWfW/eB8H423EN7llSxzWxndniCgsAk3WO8TVWg
 MBtzJl9wO+Q7qcyAP34liQjOsnQXrkh6tbpyb8yacSx+NbdAVgqJGFT7TgUKjwE=
X-Google-Smtp-Source: AGHT+IEDsdRsj/u65YHtSoPM/wJajiqBSJQADzhJh3bY129+226WIkRAHHQKkL+Cl/akOsvHw4QzKA==
X-Received: by 2002:a05:6a21:164e:b0:19e:a1a2:4c53 with SMTP id
 no14-20020a056a21164e00b0019ea1a24c53mr2996223pzb.1.1708025432121; 
 Thu, 15 Feb 2024 11:30:32 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ka19-20020a056a00939300b006e050c8f22bsm1679320pfb.207.2024.02.15.11.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 11:30:31 -0800 (PST)
Message-ID: <4b00b67d-cb3c-4173-bb7f-1ae68cdfbada@linaro.org>
Date: Thu, 15 Feb 2024 09:30:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be in
 mmio memory.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 2/15/24 05:01, Jonathan Cameron wrote:
> On i386, after fixing the page walking code to work with pages in
> MMIO memory (specifically CXL emulated interleaved memory),
> a crash was seen in an interrupt handling path.
> 
> Useful part of bt
> 
> Peter identified this as being due to the BQL already being
> held when the page table walker encounters MMIO memory and attempts
> to take the lock again.  There are other examples of similar paths
> TCG, so this follows the approach taken in those of simply checking
> if the lock is already held and if it is, don't take it again.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   accel/tcg/cputlb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 047cd2cc0a..3b8d178707 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>                                  int mmu_idx, MMUAccessType type, uintptr_t ra)
>   {
>       MemoryRegionSection *section;
> +    bool locked = bql_locked();
>       MemoryRegion *mr;
>       hwaddr mr_offset;
>       MemTxAttrs attrs;
> @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
>       mr = section->mr;
>   
> -    bql_lock();
> +    if (!locked) {
> +        bql_lock();
> +    }
>       ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>                             type, ra, mr, mr_offset);
> -    bql_unlock();
> +    if (!locked) {
> +        bql_unlock();
> +    }

On top of other comments, I'm never keen on this type of test/lock/test/unlock.  When this 
kind of thing is encountered, it means we should have been using a recursive lock in the 
first place.


r~

