Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414ABCEE342
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 18:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syboS-0002W4-Cg; Wed, 09 Oct 2024 14:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syboQ-0002Vl-AT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:53:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syboO-0003V2-PT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:53:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c544d345cso988175ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728500007; x=1729104807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u3F3zY7F86Y7io8CqF4T7PWwAjT7JnXvgt79QAORYK4=;
 b=Vsd+1V81n+iOYfgy2owPqy9c7Zx9A+5uK2bF8ICE4Akrheh97CUEdTz2Ot44Piczff
 AEzdRv5ra3KbYrRASVcxkDBp45IVHdfBICSpZBYOEJ80Pg5FhA2Fk3W0VrjQSlWvuF0i
 LhKHjtTSFDgQwWKiZxi4YrGbAeKr4SyZTOTVQDELNyaMZTPMz7DzvO+5yrDwe3TmKSpC
 zTxc7XIxTIhWihLiEl0BP5k/PF4yJ157gMj7hGJozXYowYOQt5ZW8yw+vQx+0r+qbJRa
 l15/zRddBgheL4ZBY8JlCUfHoIgZs/zt4229HRfzq+ymQEfjnPdKUvqXK+kQE4RL1rH8
 qWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728500007; x=1729104807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u3F3zY7F86Y7io8CqF4T7PWwAjT7JnXvgt79QAORYK4=;
 b=X2zJpqJo7QtvM2++0GY2O3pHLNz5BJ+xIAaJs3KYsc/u4I6TXKlFBKC7wViWk8PRk2
 QOt1ct7bTLeqhV6+4UHAm+V5DMJuL5Z6xBb2McZ2DgijdarAOXIFSl22Bpx/1O9+V3II
 dMlfwVMES5iChViJUmSyxm461lhxXiKt4F6ysufw44WJyjIWR5eZRCD5dJ6r65kefIIy
 Y9yWA3RaGP60DviPWlefWcejXJI4uWrKHBPsLMpoTc3fyQ6mmHjWsyhUPyT1NN76fLN/
 iQEBjMyU3z04lZDjX79Xc4rs21pviNeIxphT/e40uookusuUJaqE6WA71mE9MH0Xyjbl
 KbOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3bd8iMnoTNhDgOsYwMiFWHu5KTM4JoDjD324Yw2vL6bKv5eQgbSXkB8H994PbGYCbKzRnThnxSK9i@nongnu.org
X-Gm-Message-State: AOJu0Ywqw/YG12DxqKkx+Y25qNzf6A4LWvYEjvwf0VWRjqWKnByu9cjX
 Eil6O182UYcox4Iok/1Me5QgOscLMV4fkRyI9l+RXUXmEiJwu6UpHTyCDlAftvs=
X-Google-Smtp-Source: AGHT+IEZucVZLOkMmnI9YxBd0/s+hREb1MngA0peQ+Rved3pcEioqVG3onxspFNE0IXj94Q7uAc99w==
X-Received: by 2002:a17:902:d2cf:b0:20a:fd4e:fef6 with SMTP id
 d9443c01a7336-20c8045d5ecmr7327685ad.8.1728500007343; 
 Wed, 09 Oct 2024 11:53:27 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13968a3csm73549555ad.208.2024.10.09.11.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 11:53:26 -0700 (PDT)
Message-ID: <432415cb-fc54-404c-8875-c5cfc942de6c@linaro.org>
Date: Wed, 9 Oct 2024 15:53:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] accel/tcg: Early exit for zero length in
 tlb_flush_range_by_mmuidx*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241009150855.804605-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
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

On 9/10/24 12:08, Richard Henderson wrote:
> Probably never happens, but next patches will assume non-zero length.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index fd8da8586f..93b42d18ee 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -801,6 +801,9 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>        * If all bits are significant, and len is small,
>        * this devolves to tlb_flush_page.
>        */
> +    if (len == 0) {
> +        return;
> +    }

Maybe clearer to move the check before the comment, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
>           tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
>           return;
> @@ -839,6 +842,9 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>        * If all bits are significant, and len is small,
>        * this devolves to tlb_flush_page.
>        */
> +    if (len == 0) {
> +        return;
> +    }
>       if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
>           tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
>           return;


