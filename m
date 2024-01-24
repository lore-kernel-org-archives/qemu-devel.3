Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0508C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSRzQ-0003Ye-Iz; Tue, 23 Jan 2024 20:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRzP-0003YH-5P
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:23:39 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRzN-00033H-88
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:23:38 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bd5c4cffefso4882643b6e.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706059416; x=1706664216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ctTqhHc+TkxAsoFMtjhaHkgPljQ5EJNcimehBmqanNA=;
 b=UDiQvZ+I/hELR9IORUVmRz6RKJp5HOpZuXJW0eE2bG+SoY+uxIKjLI1wUJYEpMrm1Y
 WQbc4wkskH4mAPZPGqOfCCdRbVoFbA/umx0/m7y5OMCoJ43fg4n+PAC4/zSc80++Qlfn
 LHb5XgbWRqGVnGfLyIgAFVFZIk2vQw4ZcNkxDCIozboY1N9q9K7WwGZLb72S4Pf0QIdl
 1aoy4lQSg3fmagmUJs2SWwq8DsrTN0OxU/oHx78NxLgVSpGJSTlZR5taKOZ1NGLhbkIU
 rf7yJjI2zeXlblbVyeQIYCTpq1v84/AlzFRMdCM5IHNaGGtb0lOTtQvMuZVWrx7HpPtT
 Gmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706059416; x=1706664216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ctTqhHc+TkxAsoFMtjhaHkgPljQ5EJNcimehBmqanNA=;
 b=KEE5+J7P3hc84A1SZR/5jzbRCWTyF26eqUNyDa+MXnji+jCX4ojlfjRvVK+QTyC0vU
 j+/E+FelqeJpTjFFgEHnvrkdOlAogYOnP/I1TCUxLlq1AByQ8UxmZ/IrxmalxlbOeZvu
 zmc9HMJXSgpuii63t7hzTdmRemzq7B0PPfCr0DhOoPBNYBNrYU8KLrcgZD4B01k7lXNw
 jFGpqwMQ1XZxuqVQ3GukvhBB8/0hN72YjN0+eLEUe/EkWKqSTaFgl33VkDd6QGdDGyHY
 DLv+PvD2ZR82Uz91exctYlddNimYI5BSWh+pWpx7vMDWamHRiWT8S0Fh1HpShGAzI3AI
 jitQ==
X-Gm-Message-State: AOJu0Yw0VzA7UGcZraS/rXlDwaQqG1CYrBTcCqQDaeIBoIukD4oQoGi0
 oFxEitE6fkHAmnlnZ9xXNqY49M6c2iOHGCAIlPI8lO/56gUxV4VY3aY7eMDBDdQ=
X-Google-Smtp-Source: AGHT+IEq14EJyJCdYAzmepbjPKht0wyDK38WYWLkLSaEoPM9zLH6bOseYb6pqTIJyYmEYjR7RswIAg==
X-Received: by 2002:a05:6808:2221:b0:3bd:be5b:246f with SMTP id
 bd33-20020a056808222100b003bdbe5b246fmr947380oib.11.1706059416085; 
 Tue, 23 Jan 2024 17:23:36 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a635314000000b005d4156b3ea2sm1099201pgb.93.2024.01.23.17.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 17:23:35 -0800 (PST)
Message-ID: <633149a1-e8b5-4d1c-99fe-9fb93b4bc797@linaro.org>
Date: Wed, 24 Jan 2024 11:23:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 21/34] accel/tcg: [CPUTLB] Use
 tcg_ctx->tlb_dyn_max_bits
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-22-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-22-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> @@ -172,7 +172,7 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
>       rate = desc->window_max_entries * 100 / old_size;
>   
>       if (rate > 70) {
> -        new_size = MIN(old_size << 1, 1 << CPU_TLB_DYN_MAX_BITS);
> +        new_size = MIN(old_size << 1, 1 << tcg_ctx->tlb_dyn_max_bits);

Out of scope.


r~

