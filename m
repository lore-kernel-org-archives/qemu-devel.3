Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3135C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 17:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roRWa-0006n3-IY; Sun, 24 Mar 2024 13:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roRWY-0006ml-JW
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:20:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roRWX-0000m6-5e
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:20:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dee5ef2a7bso25878725ad.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711300843; x=1711905643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j8nZpTeYo+DDqxna0W10Ww/Uf1DYQIl1P/v8Gsysh68=;
 b=IBAEFzm6mn/94Q6bZQeBHXsmczdX8DT26DLs8BIJxhSYkylls4Y7rVQJ8VYviGus6d
 12tMF+9JchjwWpFw3ncup/rPE/HrrNwK2yVvY5VWuqemWBrdwWOW6r8wBvY9LrP33nB1
 T6Jhpk7x3HHAes/kAMagRF5i/X945bIm911ASZ1xO/iJ+NOsPGXME4FYaAgHz4viMzxk
 sIhOz/jaDVShYjN+mQOsnCCm/RoFXZW9Trz3CNnshtYMTzEN8oTjBE9bu4NxmJN80OvM
 TeR21Yo2GjbWc+j5NqtAxLmy/4bvu1CcuOJB1JZXM2knVh4ydSsrM1v/sU555FrqeYpx
 El8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711300843; x=1711905643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j8nZpTeYo+DDqxna0W10Ww/Uf1DYQIl1P/v8Gsysh68=;
 b=sl0YvytHBsOkdX+pEVHs/RBkNiqNL0p6bYZAawFd0g1GR6teYTaDtspHO15xGnAmRt
 IgOzgzGjZVMrRtsHwRsB8VfKM3yzdp9ytBcJrxCRM2f/ooAsY3amvDWab02aogiHRnG/
 kK+/dnr/KX8Hu6Jl+jX4rVFdIEr7r2yBgn+S23QjAfbz4CvplHPJ9siOCHc6NgPj85Dq
 vKHAdsjB5IMRw+dC/BXPZz5lXfDuK83TbPhPGT7pMolr50SqGDYKJ68kOjgGJkgw1Ovp
 jj+vy2wFq6IqXvY4O7A3E2HSdqg9bzcGpOUZvbHbLRNad8yQvU2BQAunSHvgMZrplK/g
 ki6Q==
X-Gm-Message-State: AOJu0YxeYzlakipUnfOVVQP7mft7oL0AEp1J8iBiq7NEVaKwFymPuny4
 KvAR7IsAdv0CSbpsViHZGBZt5v545bRMfex3i6nNScmN4vPgwivQMqOTWcYxVT0=
X-Google-Smtp-Source: AGHT+IGvXB/Hp3+K5ghVDmB4ww2bwzD7mjcsmm/Ja4q5JOdx+SSLVn78eZQYC2OM8VpfN0E7J/qohg==
X-Received: by 2002:a17:903:1c4:b0:1e0:a1f4:95f with SMTP id
 e4-20020a17090301c400b001e0a1f4095fmr7515417plh.14.1711300843591; 
 Sun, 24 Mar 2024 10:20:43 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y1-20020a17090322c100b001e043df262dsm3275112plg.33.2024.03.24.10.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 10:20:43 -0700 (PDT)
Message-ID: <6be58de3-978b-4248-9023-e89c33612b93@linaro.org>
Date: Sun, 24 Mar 2024 07:20:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: fix building gva for wide mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-4-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240324080945.991100-4-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/23/24 22:09, Sven Schnelle wrote:
> 64 Bit hppa no longer has a fixed 32/32 bit split between space and
> offset. Instead it uses 42 bits for the offset. The lower 10 bits of
> the space are always zero, leaving 22 bits actually used. Simply or
> the values together to build the gva.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/mem_helper.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 84785b5a5c..6f895fced7 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -523,13 +523,16 @@ void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ulong reg)
>   }
>   
>   static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
> -                       target_ulong r2, vaddr va_b)
> +                       target_ulong r2, uint64_t spc, uint64_t off)
>   {
>       HPPATLBEntry *ent;
> -    vaddr va_e;
> +    vaddr va_b, va_e;
>       uint64_t va_size;
>       int mask_shift;
>   
> +    va_b = off & gva_offset_mask(env->psw);
> +    va_b |= spc << 32;

Indeed, this ought to be using

     va_b = hppa_form_gva_psw(env->psw, off, spc << 32);

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

