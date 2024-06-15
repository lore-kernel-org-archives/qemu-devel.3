Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AEAC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 23:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIcmI-0001dH-3v; Sat, 15 Jun 2024 19:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIcmG-0001Ys-Dk
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 19:25:44 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIcmE-0004Tl-Ox
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 19:25:44 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-254aec5a084so1524294fac.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718493941; x=1719098741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k7M1Oa1Edipz4lDeElIamJ4Wp+G0HhNLgJ7TS1ngefs=;
 b=ItcWg7XwBc538jRseH7Kla8pvto7JgRAfEAcF0uvfKqB3r6QfYTfQf85wqCNc74/AA
 Is4Dhw/oFCn4ZYcJrYUGsx0N/8Lu46oRr4gZEZ22FKnRPJPZZv0zfwkuP/p7rMt1dxno
 A9nI9Q6nc7nNfbc0qcE2oJzrADoT4BVDeKvvQ1fvjfnBPGc13ykfEgM1CiyP49r4qaXn
 tYhmtPyl/uatDtNByxOxm7cNN4fn/Oar1J3cE93wlP3Clsbr+0ICZKaPgx68Zqgmgh3g
 kHgYarycE8wUqMufEcYmjmG5EZn1a/bVNQd8X3wLJwApkAjJr0WdhOlqsLspGrofOr9G
 fzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718493941; x=1719098741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k7M1Oa1Edipz4lDeElIamJ4Wp+G0HhNLgJ7TS1ngefs=;
 b=WVSQCZ+jRmL7jzkC4NdGuewoFQjj8ucm/u51UGF26OwxPvdVTBDu8VAH/ULHAu74w5
 z3YbATRHCMeOK/BJCQYp07PmDUMXwLyY9jggq6wzl7K4iVAwEXHnZMcDitwMm61Bby4L
 rsYW0Tgi7XidEJb5adHeOZgTRcI3+YswXLjrIOhTAn4emZiGGoxVAPR4AitVmO0MUR18
 JBAviHKhSUd+i3p5r+6sKpZJmcJuSPoZbQefevm7ibDS/OUAp0wMpbK1WLDveM0ANqF6
 701lyKpWGVEpgK0vVePjcUe7f0MZAJXrJZkJ7lzyU+KouJJJdH6LkKHjJrHmCi2AFM/P
 24Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW32Uk+cic712QfodlS3snSMyTWALl4uzBOcCGphhYwwpaqjQkacXa1LtgWKCZ2e1udw6nNSlXx9vpNFFE8BLylurpSW9s=
X-Gm-Message-State: AOJu0Yx8/B2g5UWMa0y/k07ghCjOl2n4oilqS9alIHJI9WDV8+hT0NrQ
 hNMve6YpCRORi44vT5fKBwOuuyszEVRZ+nQl1W/97FdLIVmYkmEUXnIoaDeJ4RU=
X-Google-Smtp-Source: AGHT+IHl4NfINCCcXyURPBtrqGdKuiXY+mWkf8x2N5ujFGw9s5KnwD0hdEf/W9qZ7tPdZ4ORAF3FAA==
X-Received: by 2002:a05:6870:9a23:b0:254:a0ca:6dd1 with SMTP id
 586e51a60fabf-25842885d0fmr6949374fac.12.1718493941093; 
 Sat, 15 Jun 2024 16:25:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc989ff7sm5320890b3a.94.2024.06.15.16.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jun 2024 16:25:40 -0700 (PDT)
Message-ID: <71f86082-05df-48c8-9581-68f6417c525e@linaro.org>
Date: Sat, 15 Jun 2024 16:25:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] i386/tcg: Allow IRET from user mode to user mode for
 dotnet runtime
To: "Robert R. Henry" <rrh.henry@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, "Robert R. Henry" <robhenry@microsoft.com>
References: <20240611162021.269457-1-robhenry@microsoft.com>
 <20240611162021.269457-2-robhenry@microsoft.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240611162021.269457-2-robhenry@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 6/11/24 09:20, Robert R. Henry wrote:
> This fixes a bug wherein i386/tcg assumed an interrupt return using
> the IRET instruction was always returning from kernel mode to either
> kernel mode or user mode. This assumption is violated when IRET is used
> as a clever way to restore thread state, as for example in the dotnet
> runtime. There, IRET returns from user mode to user mode.
> 
> This bug manifested itself as a page fault in the guest Linux kernel.
> 
> This bug appears to have been in QEMU since the beginning.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/249
> Signed-off-by: Robert R. Henry <robhenry@microsoft.com>
> ---
>   target/i386/tcg/seg_helper.c | 78 ++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 715db1f232..815d26e61d 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -843,20 +843,35 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
>   
>   #ifdef TARGET_X86_64
>   
> -#define PUSHQ_RA(sp, val, ra)                   \
> -    {                                           \
> -        sp -= 8;                                \
> -        cpu_stq_kernel_ra(env, sp, (val), ra);  \
> -    }
> -
> -#define POPQ_RA(sp, val, ra)                    \
> -    {                                           \
> -        val = cpu_ldq_kernel_ra(env, sp, ra);   \
> -        sp += 8;                                \
> -    }
> +#define PUSHQ_RA(sp, val, ra, cpl, dpl) \
> +  FUNC_PUSHQ_RA(env, &sp, val, ra, cpl, dpl)
> +
> +static inline void FUNC_PUSHQ_RA(
> +    CPUX86State *env, target_ulong *sp,
> +    target_ulong val, target_ulong ra, int cpl, int dpl) {
> +  *sp -= 8;
> +  if (dpl == 0) {
> +    cpu_stq_kernel_ra(env, *sp, val, ra);
> +  } else {
> +    cpu_stq_data_ra(env, *sp, val, ra);
> +  }
> +}

This doesn't seem quite right.

I would be much happier if we were to resolve the proper mmu index earlier, once, rather 
than within each call to cpu_{ld,st}*_{kernel,data}_ra.  With the mmu index in hand, use 
cpu_{ld,st}*_mmuidx_ra instead.

I believe you will want to factor out a subroutine of x86_cpu_mmu_index which passes in 
the pl, rather than reading cpl from env->hflags.  This will also allow 
cpu_mmu_index_kernel to be eliminated or simplified, which is written to assume pl=0.


r~

