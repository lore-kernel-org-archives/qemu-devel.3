Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C6D6A223
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe56-0004wK-Ir; Thu, 14 Nov 2024 12:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe52-0004uH-8s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:56:32 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe50-0001I2-Tb
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:56:32 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7240fa50694so763261b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731606989; x=1732211789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qBVldW2d5RgPSNqIiYfR/p2EfS0QkaTryi/3gBNmtek=;
 b=a1QPKz/mRXrwVjxcJDtsbrGMwCvUZmswIHPx0bzrwkz/FJKuWn8lZaPU/lqcuXc2qD
 zl4Wtq2feogQILYbqdzj42T0YI1753TNNcp7va2PHO60GprPeag7+LWz7NSKUAHjnLAK
 iZIcLmFU4AO7u0QKImFHWLjhrw4sfuMax+x32sSIDXizEX4N6eJz5CIQXxyMknSgF8UZ
 V/ySZTm5PSwsCVV140X0+W24tESrcAGM7K7jnApaL6EUAhlXrXzswb6y7vOjyxB396nC
 QaGmj0iR352SixNS4kaZgHa6EQRBwXAOzLIdHsAfyFLYgIVc1edYO5Ulj/WF7KFW8xc3
 jrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731606989; x=1732211789;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qBVldW2d5RgPSNqIiYfR/p2EfS0QkaTryi/3gBNmtek=;
 b=nrFRMNN3qDxUNMiAzA/E6byUlonxV8IIonvDpqAKXI7f+bdCGldux7TTLELexh/Ezp
 z3aESkzUkD5Lnzb+BQGN6xA3zcHpj9q8d6+6GtAx7jlV62+Wypv6ErPzGYe/JrQi/bTv
 97VnM97ZSbqEI4OROEmAHQ178qIw7b4j7WMKpXMMXO/fKZNbyEWRdj/WiL9k+S+XJhvo
 tJCRUFKrz1al7kv46m3eXqpbn2cjYN2BgRpeZhvdrN3f44moAZBT0rPMs/NbgmWOJtCl
 +OUZ+9bqLlOXIypFixjFYoUpKnN1w2W1ed4LtToTyQddmW3xMIZeQ5D67DBjUE0WKEP0
 syUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+TUQmnk65iSzCzMYMV9f/4JBRA9AvxDISQkkbjd0llVcnuykDXvTnhtVx20u3VFOYq+uwuPvWelsJ@nongnu.org
X-Gm-Message-State: AOJu0YwfaX5vqt7G5SDkm6bViJiTKWynBOK2Fgd6xNtTpmPaZnwsSjdZ
 gIvEqENZpY9T8ra8bDKI6tV+8UfdnUJv/fAbwZXuy3WHIK8rwQc1d9wxqSK0XpI=
X-Google-Smtp-Source: AGHT+IH1PKbHgQBRtwyEBwPTk+b6ftSbF0Sk2YsFyRb2Ymuvgn7ANlyeO2tfj3daKgPtDOaGiiQXeQ==
X-Received: by 2002:a17:90b:5448:b0:2e2:d74f:65b5 with SMTP id
 98e67ed59e1d1-2e9f2c79228mr10212406a91.16.1731606989410; 
 Thu, 14 Nov 2024 09:56:29 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f16da4sm1478069a91.12.2024.11.14.09.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:56:29 -0800 (PST)
Message-ID: <209047ef-993c-4672-8667-8d091dcb1b2d@linaro.org>
Date: Thu, 14 Nov 2024 09:56:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/54] accel/tcg: Assert non-zero length in
 tlb_flush_range_by_mmuidx*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
> Next patches will assume non-zero length.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 77b972fd93..1346a26d90 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -791,6 +791,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>       TLBFlushRangeData d;
>   
>       assert_cpu_is_self(cpu);
> +    assert(len != 0);
>   
>       /*
>        * If all bits are significant, and len is small,
> @@ -830,6 +831,8 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>       TLBFlushRangeData d, *p;
>       CPUState *dst_cpu;
>   
> +    assert(len != 0);
> +
>       /*
>        * If all bits are significant, and len is small,
>        * this devolves to tlb_flush_page.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


