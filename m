Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D427CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syg77-00081v-7T; Wed, 09 Oct 2024 19:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syg74-00081d-L1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:29:02 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syg73-0003oO-4C
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:29:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71df7632055so332070b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728516539; x=1729121339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wxG4FSCEmhB06nN/5jWNvLEQCwMXOd3bzKNShjSzP0A=;
 b=u9xxg7vG09Zoe+AbimlfldnudJ1J7acFeDOM/8ZTQHcfog5ppsWw1naS/4u0+jjIht
 ZyOUira1OeExQwbkK/6v+N9EqTAiGwylnIk/OnLh1lvqILlcdfjmu4sT2Hv1dH7kK9N9
 3e0No1VvhzbfVuEvTGrmyMCD2BmDDNaFTrGUojDPGQedg6hVuQvoKLMpyXR/iy4oii9S
 YuB/nJjIDdkjqUlvfirzx6WQHhevYinxgMOZyrRhByR7WaBg0Ikzm+llwSwDjTTjCWyy
 hln/MjbYy2i4MgBZBojhrhdC+K6x7s4j/lBr5N+7s6oSh+ZM7bYteYsWhFWQ3qIwJL/E
 vMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728516539; x=1729121339;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxG4FSCEmhB06nN/5jWNvLEQCwMXOd3bzKNShjSzP0A=;
 b=KTZwSEvD1RI++W96qX39tbHzx+FmVJnJxbtH+t+YpyIeDeRt9SrT1TDI4viuk0rTPk
 d7sXxM9FOgxXlpHU0SRZ7Ldn0MSEcKTOnFl8aLo3Rggt4qJKSmoQ29DAStlV9oQEltse
 ZrxvxfWFVxyvaCGic6W66WyTgEA+4JWQPoHuldcqXPFuu9/6cJqGbK45uhzkMMOEpEu8
 wULv0sTL12wHt89rdKMErHk6mIv4X1fLSEkHbRginkTrIFPXvu3dSgca5r0eGr0wpomb
 XpO+OBGnGQYsRSZFiaKWealgkWgyKJ1XBYhos+yXLfAVlhvMCuLkgB9IqrWy+pGAT8X/
 Yqxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm6ZxanSPHeGOPokJcNmz63kdeZ7JQl29F/yRSkSzyCDKw5sWM3q3pP9LFpmWC39+k2pyEnFgsUTaF@nongnu.org
X-Gm-Message-State: AOJu0YxKM7riMAthraJpb408SmSUbi/uTrrW6uuhqCPlf1EQKLhEV4w+
 rQYPxshHAUK39NVgnOthcjPWg0mrFIW/s2hZ3Q4zEOwZrsYunatRR/I4FRZWZfo=
X-Google-Smtp-Source: AGHT+IENT1LACnOVwsrHM7CnTOTiq3S8NDua1nVydMxfC0P4exx3/GvkC+3+7wMQktwVLwzBIE9NUw==
X-Received: by 2002:a05:6a21:1709:b0:1cf:3c60:b8d3 with SMTP id
 adf61e73a8af0-1d8a3c0e379mr7881198637.19.1728516539401; 
 Wed, 09 Oct 2024 16:28:59 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbd8b8sm8294506b3a.1.2024.10.09.16.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:28:58 -0700 (PDT)
Message-ID: <be8521b0-706f-4f35-a385-5a5177c8ddf9@linaro.org>
Date: Wed, 9 Oct 2024 16:28:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/23] accel/tcg: Flush entire tlb when a masked range
 wraps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> We expect masked address spaces to be quite large, e.g. 56 bits
> for AArch64 top-byte-ignore mode.  We do not expect addr+len to
> wrap around, but it is possible with AArch64 guest flush range
> instructions.
> 
> Convert this unlikely case to a full tlb flush.  This can simplify
> the subroutines actually performing the range flush.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 93b42d18ee..8affa25db3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -808,8 +808,12 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>           tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
>           return;
>       }
> -    /* If no page bits are significant, this devolves to tlb_flush. */
> -    if (bits < TARGET_PAGE_BITS) {
> +    /*
> +     * If no page bits are significant, this devolves to full flush.
> +     * If addr+len wraps in len bits, fall back to full flush.
> +     */
> +    if (bits < TARGET_PAGE_BITS
> +        || (bits < TARGET_LONG_BITS && (addr ^ (addr + len - 1)) >> bits)) {
>           tlb_flush_by_mmuidx(cpu, idxmap);
>           return;
>       }
> @@ -849,8 +853,12 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>           tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
>           return;
>       }
> -    /* If no page bits are significant, this devolves to tlb_flush. */
> -    if (bits < TARGET_PAGE_BITS) {
> +    /*
> +     * If no page bits are significant, this devolves to full flush.
> +     * If addr+len wraps in len bits, fall back to full flush.
> +     */
> +    if (bits < TARGET_PAGE_BITS
> +        || (bits < TARGET_LONG_BITS && (addr ^ (addr + len - 1)) >> bits)) {
>           tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
>           return;
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

