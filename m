Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C908CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfz2-0006nN-Q2; Wed, 09 Oct 2024 19:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfz1-0006mr-RV
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:20:43 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfz0-0002fV-CQ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:20:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71df4620966so313462b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728516041; x=1729120841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSicqOXYnh1t1608309lffFtZAzYcB8vJZaufCb3M2Y=;
 b=kPbeO1Op4si8giq4lRpESDd/w1YW/sBw0tUHF8uFVf+AW7uqL7eDiNvuW66f0lwwL0
 o88m+22svJqZG6XIcIJfvDmYgVYhWvs6JXTP8gdjt7Fo8M82+vsw3enGoe4ZbcNLxAcd
 ne9VKCsq+Ma5vKcSxdPHx6pcheUhA/3qL8ckLWae6EUT0Bp3dFKi3oBSYOb1nKtRh52Y
 fd56it35baDxJ4MCQtNjrEIREqjA6wCsG7I8Qtm9L6AKg3IZQhX2Rq6CPxFcF79zB61C
 dkpn9YDleZjs1ahEte7qFmy9rIz3kFiGPqulEnZ+FEzButf12C7IAa2hk7FnS9L05f7e
 KfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728516041; x=1729120841;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSicqOXYnh1t1608309lffFtZAzYcB8vJZaufCb3M2Y=;
 b=jtM+8l6xy3TU1OiOwXwg6Lfu2vEQ1PkInKXEhJQ0vE5oFrTQjF6bHq1wUMmeWyHSfq
 fUJKuBvtAl4tW842r0VK6z2VcZYnnWG0amSmuY5rksWc16jv0y/p1C81VndzQfEWQ7LR
 KUOU1PrS6VoUeQt3sulKJOMIODi4H8PQktc/cT5sDk8mGuRWq7tR1J9FVu/x6ve58dFt
 C+HvXPWgr8gkZ0+qZqJ6EJt1DZ8OE+wdFMHN2dIrrL8gQ6xaFW7cMhFRUxZ/66Xudv9g
 4Fl2WpSswD1G5eiN1nRn9SFVR2ZtMqUGICfCGiBci6HVNJp04Lv2YczX4EnY7VjBHPAd
 TWpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzyc0FJJXGJSW68kZU6uVHPc0fdLO0YcI2/ONgtVBRgMxWzBNX6/bp7vDxhhhaEKD1skicWMOmEInz@nongnu.org
X-Gm-Message-State: AOJu0Yzs1Rg5KnFLSXLiOxhNNyeOiIJqLQJ95PkvPMSl50MZfJAJmA16
 myCsGK5+gb7aLORBX8wg83Z6fltwaiEquev/nFLYxyNF/myfDeKRyOWxgGF9ghhWwiqCwPEgtMH
 zLKI=
X-Google-Smtp-Source: AGHT+IEqsFAlRz0tBDy6Ppy85t3jz5f3lT+Vi495kg12TVod+szZlX/+X7JQ6WlRdhXmhKWIsr82gA==
X-Received: by 2002:a05:6a00:228d:b0:71d:fae5:4ee6 with SMTP id
 d2e1a72fcca58-71e1db6e1e4mr6783501b3a.5.1728516040859; 
 Wed, 09 Oct 2024 16:20:40 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbdce1sm8305423b3a.2.2024.10.09.16.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:20:40 -0700 (PDT)
Message-ID: <dfb9e130-bee7-43c8-8368-805fe01daf13@linaro.org>
Date: Wed, 9 Oct 2024 16:20:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] accel/tcg: Early exit for zero length in
 tlb_flush_range_by_mmuidx*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

If this "probably never happens", wouldn't that be better to assert that 
len is strictly positive?

