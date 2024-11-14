Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA27D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeBV-0001WH-6Y; Thu, 14 Nov 2024 13:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeAl-00019B-MS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:02:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeAk-0002mB-7y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:02:27 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cd76c513cso8916415ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607345; x=1732212145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3S18p8Hvva0GRasXkQBedaDjmOANzY9feiOjQvMsGE8=;
 b=gZcWFk8bJKdnkiqk59/MVY5zuaNxNOEsok1/W+SR4yu2Gjivh6bldjtBoWqlVrQbhM
 C+KUxVFAnEIj8+Fyi/uyR/vpiO9ELhsLcd2VoBWC5/54lL9CyArhUh+kfY72PWF2iPo0
 ifdEJ2X7Yt7qLJZpyOf1XkGHKU414wO9oQQLKv0VbTNcWFEqz+ohor1w0YT+KnVp4nf3
 74aNz16IBasq4YPeG3/GZ2Gh1GSq+HI0lrGor03zDuWodftARR5vHHLJXKQbN2S+Rany
 trG0/m1BATdWzfnYcC4YWyptBq4zRTdg5EzMp8Ij/63hYPvNKu2xzybU3NPudzC8j+XL
 n7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607345; x=1732212145;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3S18p8Hvva0GRasXkQBedaDjmOANzY9feiOjQvMsGE8=;
 b=WkEDnIzjYhU4AsHaK1aDePkvRXNiKBjAN9Ka9pZjukPgYFxKW9wHFcQ1XEY3EDdG85
 lg4k0wEYF10iADnhRoN74smTY+VuYBDwwibRB714SwFo+t03NDRNCtjIrQgLqE4W0jx6
 JkZPRymsAL9NGlvPSGmWZTRjj+A/vs4XXOCu36zq4ZMo0qiUjV6jdc5+d7hvOfAHigdE
 ZQ9qujkslfM5pGajHvqXK2nOTI0YcnLi+wW/wQ248iptUm/hnH+GI4pZFH4d/kdIqozt
 bSMIhjeKt6S6Qs3Y1LScbDkhu4KsTydTbYSnBjWkh3yHgpCdO0IT/HvJg8FP2merBYVZ
 dRzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtR9vQjXJM7Pr0Xs0/Yr30Iq81RqpU3aggYflWk6QFutGw+Q+JxkpCgfUV8Ta7yzRr9mGi7nDpSmPs@nongnu.org
X-Gm-Message-State: AOJu0Yy8am+2/XWo9ykS0IT7DjRMq3wO/0AqvC01/prIUczXHzTnHIwz
 ZjHP9DHl3dkwypXSPG4vHRJdrznZqff+NqCnTfckRQTxiM9t1hw/+fBXZuYbyhQ=
X-Google-Smtp-Source: AGHT+IF/p0paR/C0EwohjoZxsVDlNroBsKrZWVwGFrLpsuAUjJiNyQffdDKloyUB67hzqIQflViqtQ==
X-Received: by 2002:a17:903:1c6:b0:20c:a19b:8ddd with SMTP id
 d9443c01a7336-211aba2a94amr139974505ad.51.1731607344935; 
 Thu, 14 Nov 2024 10:02:24 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c28ec0sm13588475ad.56.2024.11.14.10.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:02:24 -0800 (PST)
Message-ID: <a4d44cd4-84d4-4b02-8242-59631dffb874@linaro.org>
Date: Thu, 14 Nov 2024 10:02:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/54] accel/tcg: Process IntervalTree entries in
 tlb_reset_dirty
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
> Update the addr_write copy within each interval tree node.
> Tidy the iteration within the other two loops as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e2c855f147..0c9f834cbe 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1010,17 +1010,20 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
>   
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
>       for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        unsigned int i;
> -        unsigned int n = tlb_n_entries(&cpu->neg.tlb.f[mmu_idx]);
> +        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> +        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
>   
> -        for (i = 0; i < n; i++) {
> -            tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
> -                                         start1, length);
> +        for (size_t i = 0, n = tlb_n_entries(fast); i < n; i++) {
> +            tlb_reset_dirty_range_locked(&fast->table[i], start1, length);
>           }
>   
> -        for (i = 0; i < CPU_VTLB_SIZE; i++) {
> -            tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
> -                                         start1, length);
> +        for (size_t i = 0; i < CPU_VTLB_SIZE; i++) {
> +            tlb_reset_dirty_range_locked(&desc->vtable[i], start1, length);
> +        }
> +
> +        for (CPUTLBEntryTree *t = tlbtree_lookup_range(desc, 0, -1); t;
> +             t = tlbtree_lookup_range_next(t, 0, -1)) {
> +            tlb_reset_dirty_range_locked(&t->copy, start1, length);
>           }
>       }
>       qemu_spin_unlock(&cpu->neg.tlb.c.lock);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


