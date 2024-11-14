Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C2BD6A223
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe0y-0001yV-BE; Thu, 14 Nov 2024 12:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe0p-0001r1-Qn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:52:15 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe0n-0000KB-74
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:52:11 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21145812538so7971425ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731606728; x=1732211528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kBgaevgn4TlFFONC/89Uxk62RrZEtMKyrJAPxJhb88w=;
 b=VHUD0jAyJqiqnJye3UTr8Z/NRMY5wTCI8xcij/FJDEg9LzMuAuVLGwvtPspLEE8iha
 N88CUTwf56XcERUiYiwOkuRv2XZn8YXN7TeOTHEBmnAMwqnXwB2xsIG4FSEL1GHygfwm
 TC7awGTtWAygEZmBB6MzwuzHzx5Wu0WSTUabAi4LUaZ+hqxcZpmajYQNDdoizaQGeMfR
 9EFUApj2H6t5MDjMxcma1lhKvHCZ4IpQxu18pWUoDRgW+N/V+dF+IWmXEU7mxYQlmHLK
 Vcsj1h3Q9zowF6vys9fU7coc5FVs8QbQCC2Gs+WUoYQDE/tRuif47Xcg5wi0nOeYAUyo
 bRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731606728; x=1732211528;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBgaevgn4TlFFONC/89Uxk62RrZEtMKyrJAPxJhb88w=;
 b=C78NkSaJipSEivwTaEolh2ne9ZSqmeBL/ZX3Nu1BxvO67b9QaSZjKkl8vcC+UAul6B
 LYhJhab7kDsAAjLwAUQIBzMfbmQAbS/KobLz3DlY7HjxwQdGShABP2ca3B1H9IAdI6Sj
 AVc9A60NtwQMIxl62zcaw01U6SL+v66n/yOd8wqXQ6djrtEpiorfNVN5WY2JTmX2F/gr
 HvIKvjL6i0OrUWqvV+4QwbW3Mgwxl8PPazfprBx+GvExXSckf5HOcavKD35kOSQUvOC7
 XJrQIWXa//GIVRd7fklB9wkVSCXYBjSQhz33nR3G+gOnjbMIfXVxDTZXZ4LbDyRFxWSj
 Qyqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKzxFVkzvXm3K9a6zp+hqRitBbQRWJqmiBanNL5t3SwbyTgXb6RByjgnHjYcXZVvAO3FC+iaSZWzwO@nongnu.org
X-Gm-Message-State: AOJu0YzbTPaCnMIlZHNwb0kIg7+gGfB0D6KlirIA+Usz7v+24MIff+1q
 0WuLUl7zA74ou3jqQn2eswMNrHCZwzg+orbZ0nkYvQq3mAUE4Zlb580KJKOhhtc=
X-Google-Smtp-Source: AGHT+IF5M/znuEFUwJqggHYTZqm78RXujQkVWFhdfbXQG+QtFFb7UWxBDcHlfaPEhEMRQVOPf0pk6g==
X-Received: by 2002:a17:902:cf02:b0:20c:a19d:e73e with SMTP id
 d9443c01a7336-21183dcd738mr275936335ad.57.1731606727824; 
 Thu, 14 Nov 2024 09:52:07 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7ce97e4sm13437815ad.166.2024.11.14.09.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:52:07 -0800 (PST)
Message-ID: <bef83864-5a32-4a5b-8dba-f843fb9bd80c@linaro.org>
Date: Thu, 14 Nov 2024 09:52:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/54] accel/tcg: Split out tlbfast_flush_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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



On 11/14/24 08:00, Richard Henderson wrote:
> We will have a need to flush only the "fast" portion
> of the tlb, allowing re-fill from the "full" portion.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b76a4eac4e..c1838412e8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -284,13 +284,18 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
>       }
>   }
>   
> -static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
> +static void tlbfast_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>   {
>       desc->n_used_entries = 0;
> +    memset(fast->table, -1, sizeof_tlb(fast));
> +}
> +
> +static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
> +{
> +    tlbfast_flush_locked(desc, fast);
>       desc->large_page_addr = -1;
>       desc->large_page_mask = -1;
>       desc->vindex = 0;
> -    memset(fast->table, -1, sizeof_tlb(fast));
>       memset(desc->vtable, -1, sizeof(desc->vtable));
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


