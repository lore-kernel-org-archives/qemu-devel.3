Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A009D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 20:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2cNa-0000dz-Vx; Sun, 20 Oct 2024 16:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cNZ-0000dr-T0
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:18:21 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cNY-0005Ih-Ba
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:18:21 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo3400736a12.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729455498; x=1730060298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8xWP5gP8x73DMuJxldxKhHQh1gMj6RimeiQtp9i8ONY=;
 b=kZvCNP208UoCbf3dHfnzqRH32ersqXJaVndRpT8l2IG3G9yCx7S0bm93jlv8A9v33l
 CjWUDtbsjWNzunsp+lduGzxuc1Oz2UlEyXf01GMuC1GuLzJzE63hADMUkpk0RqU/52e3
 tPelYpUseVJRuQo/avnEAiZJ8uyFVw+bIisrV1cg8mpxBdOxDB2SAiX3UxQoWPt+v4OT
 YlHROthF0V0/w0iUkkVGhDOAuwCWMyYZWRVDTs00WU8BGctaDCreFlptmTqgc4hh18gH
 oRAjwT9xiWN0St3osJnZ3JCooyqt69wJAXzJX6+ZELTXgTF97F6e96n3Ptrd21pXMKdW
 baow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729455498; x=1730060298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8xWP5gP8x73DMuJxldxKhHQh1gMj6RimeiQtp9i8ONY=;
 b=JePadMNEh1os40gAPxvmMVzPHbbxkPQ96vBXsfsGaPi/h31oyWfTNq49GRg1wlsVO3
 QkAbCEmaVqiRWTCpmsQ+wXVWdsUT4n5I0xUzLLpRWQu17ZWaMPxABKWNxw7LP4ACnwjH
 LRXsOpm13tHKdCxmWzDO0Y8yApKslavSFU3HpRhKVUm2soqjdEMhnXqTSTnDUuSLUt5X
 VqvptmMJgot/JGnI2jLAAgZJh/WYH496h+M4xnFeaWHEUvxoth7dF/BoQlLyx/CbRTC0
 DZJFbc7rFjP9nkRcDno8zqgNYHvYhpg8oTy5n1cLH9QFV13StyWdSzJN6AmDQvV48chH
 HxbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/9cjVGKrYIXbvmJIp5Or/2hMYEKyN7BLAnl1YzdA/sqXovwDdndPUC8wrw7M160C861RVkAmt6Yht@nongnu.org
X-Gm-Message-State: AOJu0YyGlnrIQBU5+iUY//4Xwh83alNvemqI3FZPVc7DYmSq3f+Wba0A
 wM4EYwC0DENuYaSu83ZwzdruM8giFhLyi1GoqWaUs9QgCYdvN/jSt/IKMBrbJvw=
X-Google-Smtp-Source: AGHT+IERLltircntvkDwAdqhxHsdNqYZ3ecGxDXE+O1NbeDwwTqHEmjSJ+DuUFV+qERMLt+BRbpu+A==
X-Received: by 2002:a17:90b:4b92:b0:2e2:c744:2eea with SMTP id
 98e67ed59e1d1-2e565063adcmr12536077a91.13.1729455498235; 
 Sun, 20 Oct 2024 13:18:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad366c7asm1984139a91.19.2024.10.20.13.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 13:18:17 -0700 (PDT)
Message-ID: <bf2c054f-8664-41cd-9041-795adac25d2e@linaro.org>
Date: Sun, 20 Oct 2024 13:18:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/i386: optimize computation of ZF from
 CC_OP_DYNAMIC
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 10/20/24 08:53, Paolo Bonzini wrote:
> Most uses of CC_OP_DYNAMIC are for CMP/JB/JE or similar sequences.
> We can optimize many of them to avoid computation of the flags.
> This eliminates both TCG ops to set up the new cc_op, and helper
> instructions because evaluating just ZF is much cheaper.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/helper.h        |  1 +
>   target/i386/tcg/cc_helper.c | 20 ++++++++++++++++++++
>   target/i386/tcg/translate.c | 10 +++++++---
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/helper.h b/target/i386/helper.h
> index eeb8df56eaa..3f67098f11f 100644
> --- a/target/i386/helper.h
> +++ b/target/i386/helper.h
> @@ -1,5 +1,6 @@
>   DEF_HELPER_FLAGS_4(cc_compute_all, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
>   DEF_HELPER_FLAGS_4(cc_compute_c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
> +DEF_HELPER_FLAGS_3(cc_compute_nz, TCG_CALL_NO_RWG_SE, tl, tl, tl, int)
>   
>   DEF_HELPER_3(write_eflags, void, env, tl, i32)
>   DEF_HELPER_1(read_eflags, tl, env)
> diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
> index 40583c04cf9..c24e6a14c07 100644
> --- a/target/i386/tcg/cc_helper.c
> +++ b/target/i386/tcg/cc_helper.c
> @@ -95,6 +95,26 @@ static target_ulong compute_all_adcox(target_ulong dst, target_ulong src1,
>       return (src1 & ~(CC_C | CC_O)) | (dst * CC_C) | (src2 * CC_O);
>   }
>   
> +target_ulong helper_cc_compute_nz(target_ulong dst, target_ulong src1,
> +                                  int op)
> +{
> +    target_ulong mask;
> +
> +    if (CC_OP_HAS_EFLAGS(op)) {
> +        return ~src1 & CC_Z;
> +    } else {
> +        MemOp size = cc_op_size(op);
> +
> +        if (size == MO_TL) {
> +            /* Avoid shift count overflow when computing the mask below.  */
> +            return dst;
> +        }
> +
> +        mask = (1ull << (8 << size)) - 1;

FWIW, MAKE_64BIT_MASK(0, 8 << size) does not have the overflow problem.


r~

