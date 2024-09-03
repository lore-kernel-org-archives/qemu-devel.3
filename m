Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D81BCD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZmO-0001xT-5E; Tue, 03 Sep 2024 16:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slZmM-0001wo-EJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:05:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slZmK-0003bw-TU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:05:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7176645e4daso1490903b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725393927; x=1725998727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JSFin3VvSpcpGfWbuna+RqNrU4McKXuSxxwVuuLt5sw=;
 b=w21KtW7A1WSyrqr6r1pQq/3OOz2+XZVulgA3FImA0TSg9oe1Vn4CUe8H/VrysjYLnt
 4Kmbsep/jhvUJiFJI6SnndtUSZr2XcnleBA15OttLLrqabOPWu7zlCN2jNLAgDwi/GL9
 xaruXpAejrNQYojOXebd5a7tglNPhOkI04NLr0mTm9FYcN2/wV367ovhrBvaB1zgbDMN
 7vIEhVQ7mrzDJMw1d78GIvy0AAVquBf3V4Kb+Lnzl6G8Cgw26iqcNAdNnSd0tXzlv1V7
 93tPl/viVaEuZ7sOOttuzq/HKr9rB0pRkaNZypGP3ehob6jurVgNNKk0J4Ut0OfXPrl5
 Tf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725393927; x=1725998727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JSFin3VvSpcpGfWbuna+RqNrU4McKXuSxxwVuuLt5sw=;
 b=WInMGNscmVBL1zKEf5Y9wlbbeUUmJQTkqEYHkUUW1AjfsbbAn08y42vwGfPZ31tQNV
 lEMkyGUkBsROXIHtGVWptSXMGpsb8HdUzQ412vjn2EjGsMrgPwz0qXb6wn2d/sjworuO
 ZMv94VlP13EJyYjYgRyjN2XNo2zZnmaq8va0rgJwLhpYrtpBQ1BiWobHw9I5ISui+Vi/
 R4jqtFnNU6HynKjfDZ4f+WnquvdYsSAkEyqFX2WkSXDrk7M9r5zVXwjSr0YcPBSpsEIC
 aZ5G+3BjoTapkM6BPU5DHNA+4JURCNBtDWyA+5I3+7ovvn7FxpVYQQoYI20yIUYuMUjU
 Zj+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+iGImEpU7l4IEM2dpiLI5BK7uITfRAnNyfYetA98SpMj6wJ+Dmn4hb3UGY6oHa3HKyEQ27Dx5SBU/@nongnu.org
X-Gm-Message-State: AOJu0Yx7pF3F2Mu0+4mDdxq+bGN1B3eHau6iQIWIdBXzTNOGwzBMugZV
 KuVDZx2C10kQAPi7/niQxG+27aH+E/poMxL0t8/4g0w6F+7OdOMUpBAMHXIsPN4=
X-Google-Smtp-Source: AGHT+IEq8eOpn/KydhNRSx2XUo/216/AHTeyjAYD9nrCeGPuRkmUO0lU4KZ1gEGfwzo2R+B3rVZw6A==
X-Received: by 2002:a05:6a21:390:b0:1cc:9f2d:85fa with SMTP id
 adf61e73a8af0-1cece5d155emr11688264637.39.1725393927032; 
 Tue, 03 Sep 2024 13:05:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7177859894csm254131b3a.153.2024.09.03.13.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 13:05:26 -0700 (PDT)
Message-ID: <4959cce9-415e-4ba1-8ad4-779b6a1e0262@linaro.org>
Date: Tue, 3 Sep 2024 13:05:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Fix random 32-bit linux-user crashes
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: linux-parisc@vger.kernel.org
References: <Ztc8MaxI8SfD71mx@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Ztc8MaxI8SfD71mx@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 9/3/24 09:41, Helge Deller wrote:
> The linux-user hppa target crashes randomly for me since commit
> 081a0ed188d8 ("target/hppa: Do not mask in copy_iaoq_entry").
> 
> That commit dropped the masking of the IAOQ addresses while copying them
> from other registers and instead keeps them with all 64 bits up until
> the full gva is formed with the help of hppa_form_gva_psw().
> 
> So, when running in linux-user mode on an emulated 64-bit CPU, we need
> to mask to a 32-bit address space at the very end in hppa_form_gva_psw()
> if the PSW-W flag isn't set (which is the case for linux-user on hppa).
> 
> Fixes: 081a0ed188d8 ("target/hppa: Do not mask in copy_iaoq_entry")
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 2bcb3b602b..56d9568d6c 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -319,7 +319,7 @@ static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
>                                                target_ulong off)
>   {
>   #ifdef CONFIG_USER_ONLY
> -    return off;
> +    return off & gva_offset_mask(psw);
>   #else
>       return spc | (off & gva_offset_mask(psw));
>   #endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

