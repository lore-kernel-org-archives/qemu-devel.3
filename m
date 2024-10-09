Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD67CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 22:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfYO-0002br-Rt; Wed, 09 Oct 2024 18:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfYN-0002bU-3Z
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:53:11 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfYL-0006TW-F3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:53:10 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo1034796a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728514388; x=1729119188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JN6fk68rLAMDo1zl1yGFaL7Tq8/hY8vZEGwQkz6c6nc=;
 b=s8bOuLgMGd+V/3FdgE42WGHPsM8FiykLf/55zBbJ+JQuanrlaNdV1Jsvg9PiAW9z/x
 p4PAg3EYD9SYJ4nDTlROraHJSbliGRzQYPL3Vyrqcr81eK2yryg8EkInl3S5df8nBHRA
 4m7ebMoOKVFHcgocIxMYRZ1LiAJZOiVuJ9fSXeQeU+yJvxBgzmmRqIHqT1W+Nl2vOHnm
 reyYR2/+nadUxBQkHV4HwVoFvzRzgVx/1tZUOcV2mBjTLP1JE8uPQtPIAWZ0yfVPxfkt
 E4KQ4C5ss+Gopkk8yHOwebhmXrenGGS/1wID0lJ3fNzz4OP/i4QcVzorvp1/2hsCs5Ep
 X/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728514388; x=1729119188;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JN6fk68rLAMDo1zl1yGFaL7Tq8/hY8vZEGwQkz6c6nc=;
 b=GjtYLNDaUXRNbkl012ujCqI1vffVLlXWlWW1up8mkF73WlaIVbmlWcUUiLp1hKZKgu
 ACV6MothZI71rbvf9lnfjxMlDxH0kgC6EmLgl0XHtrQ5KDWrsVTJPo3v4gzEkzotr4xz
 FNWYpjSUbGlPu6cKJuCRainRXmlJ/K/G+56pQ6E3gQJLmWMtjatnqbKDJVRwka9T0SdE
 FLhgr0Bcy8/1o7ghZV/dlZKwjD/RR/faQuo84IGP+lgIVKOW0lv+9Wu3lL5KKnX3wf2k
 9AHXJMPF+sq8LQp5VobDpYgt+lZb+URpzvmzQvFQRE3poAvwf5KHMBz3X10TFPal8xnl
 zstQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyYUPyp0xzyjO5hNwTdXfFC0BM1fjwhxOovF6Ot0qeXDA/+VaNm/cqsu/ELeA2ckjnzI+bRi5sQrBU@nongnu.org
X-Gm-Message-State: AOJu0YzvNm2FcV3wQMQZp59p2l51DCgrrD7rgzcO9X+8jvImS5Iyg8Tl
 BRnWjhb0ORoL9M1kzaWWCcGH7f22OCg9AaTI809f6f25L40Oil3RlsORjUKecQk=
X-Google-Smtp-Source: AGHT+IFMSbbug+kPlLEmzbBSQo1hsl8Rfty6Sb2Ss9F6c5Mo2j73rX1ooVnte0hR0X+pccDGw8Tqmg==
X-Received: by 2002:a17:90b:fd1:b0:2e2:ada8:2986 with SMTP id
 98e67ed59e1d1-2e2c8077f30mr1925072a91.16.1728514388131; 
 Wed, 09 Oct 2024 15:53:08 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2b64aece7sm1769297a91.3.2024.10.09.15.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 15:53:07 -0700 (PDT)
Message-ID: <e177a867-24b7-4fa5-8354-fb18b4976e92@linaro.org>
Date: Wed, 9 Oct 2024 15:53:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] accel/tcg: Split out tlbfast_flush_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

