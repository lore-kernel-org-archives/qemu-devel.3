Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CC9C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 17:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfk2f-0004uO-ES; Thu, 29 Feb 2024 12:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfk2e-0004tl-3J
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:17:56 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfk2b-0004Jq-Uv
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:17:55 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-299b92948a6so793295a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709227072; x=1709831872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZglatVsfAwaqgOtZ6XWnzgIpWJ3NUN3IDbiM9QdfJ7Y=;
 b=sj+BQVAzlx+Zv7eD+OI3qt7chqYp0V1o4JlCiwcTnq+yklmIFnog96q9nlquNpQRbg
 xq/NgX3U9zf8x+BFzmqNPh3lwefu0DPgMWAnhngKwO0zWFCui6lzQdb32GUpFYRDW6dB
 mVCFyDYPIJVaZfVidA+WJCZ2bNqfa9rpxazwdOWTlcK8FCJ8I8ibDiusFC4tvzilT882
 aFD7XelHNHxjuMph1LXxxQjT6dhVG71RVdxm1gNEcZelUHH151LILFQ1B51Dn7ZJh9p/
 6PYCsrfbhJ41FuQY8DFMmgiPij8cczBBXOLfQfRijM4m8k5c6Y5HUjKPBmQgHIpIOLgJ
 +pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709227072; x=1709831872;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZglatVsfAwaqgOtZ6XWnzgIpWJ3NUN3IDbiM9QdfJ7Y=;
 b=HCwxYt4bKHYEpCMdPFnyorsHG9eDVdd11q8K5d4MC1XoDkg9+kkJzVxrdXy8Wjcbjq
 uvCFDdQjKQfRW2PW6QnShhkQsdjucMZzNuIpXuPTIBwWbLLRme+3mY0+M/s/YCI9chTr
 hRE3sPqUbeOyEqBgny0COlsA1NwWO25FcAe4YPsPtLFZOs0B3XTyouKXhbYKmMFvwXnG
 VPx8IF20RdzIJY9ZvFVRUUUMgt8/5teDbpuC0XdOMovmal7en9eWsKj/OCREgngPIQzD
 w/7u6ZMf33SLdqKVgVm4ZZ0I7ShLM3Y7ebVF7rlcS7Fg6FgopCqNIH14l+Po/0AuA2Xi
 TWxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXizOwLj9yZIIQYX7f4mPGIghFGCE4SfQ38dZIDu2QPvxq1wR3+rwRyOzaIhkQHucZ7ZxRDUrfRbMknmtAMqAoAyh+mb4w=
X-Gm-Message-State: AOJu0YwlE1lbbZSBWGXYv5XykG/q/rancIFTOahoudld44Jg3paaZVZj
 bb4wR1mY/RkDH1gp3kpRnwBdvU1Lz8pOx/basIWPwbIFItMQDoFDOHROon+tJTxDlb8Es/AoXLU
 F
X-Google-Smtp-Source: AGHT+IF7ZI8XOe8U82Mqfm8IC2XWhT27+ksOvLTB67OczU/eMS47g25vF4F706oDrs9wVu0c2Lftqg==
X-Received: by 2002:a17:90a:e693:b0:29a:59e5:abfd with SMTP id
 s19-20020a17090ae69300b0029a59e5abfdmr2576562pjy.12.1709227072282; 
 Thu, 29 Feb 2024 09:17:52 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 sm7-20020a17090b2e4700b002997e87b390sm3904758pjb.29.2024.02.29.09.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 09:17:51 -0800 (PST)
Message-ID: <08b4d72a-4a76-4faa-a7fd-a507c1345b6a@linaro.org>
Date: Thu, 29 Feb 2024 07:17:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tcg/optimize: optimize TSTNE using smask and zmask
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240228111151.287738-1-pbonzini@redhat.com>
 <20240228111151.287738-5-pbonzini@redhat.com>
 <4362aeec-ae18-4515-a3ec-6aba811e17d1@linaro.org>
 <8c623e70-80ab-4058-b898-8eb38e95f1e3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8c623e70-80ab-4058-b898-8eb38e95f1e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 2/28/24 23:35, Paolo Bonzini wrote:
> On 2/29/24 00:10, Richard Henderson wrote:
>> On 2/28/24 01:11, Paolo Bonzini wrote:
>>> -    /* TSTNE x,sign -> LT x,0 */
>>> -    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
>>> -                               ? INT32_MIN : INT64_MIN))) {
>>> +    /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
>>> +    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {
>>
>> This is a good idea, but s_mask isn't defined like you think -- it is *repetitions* of 
>> the sign bit, but not including the sign bit itself. For INT64_MIN, s_mask == 0.
>>
>> So for TSTNE min,min, (min & ~0) != 0, so the test won't pass.
> 
> Oh! So I have to squash:
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index ab976a5bbe7..44d1b1a6d8a 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -140,6 +140,12 @@ static inline bool arg_is_const_val(TCGArg arg, uint64_t val)
>       return ts_is_const_val(arg_temp(arg), val);
>   }
> 
> +/* Calculate all the copies of the sign bit, both redundant and not. */
> +static inline uint64_t all_sign_bit_copies(TempOptInfo *info)
> +{
> +    return (info->s_mask >> 1) | INT64_MIN;
> +}

You need to care about type too -- for TCG_TYPE_I32, you'll want to OR in INT32_MIN.  The 
high bits of s_mask will be unknown (might be 1's from fold_masks, might be 0 from reset_ts).

But otherwise that's a good solution.


r~

