Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAEFFA3758
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 02:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spIzI-0001D2-ED; Fri, 13 Sep 2024 22:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1spIzF-00018o-HU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 22:58:14 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1spIzD-0000Y6-V0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 22:58:13 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7db12af2f31so2560942a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 19:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726282690; x=1726887490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LUtRG/W4eX5Y0IkYKBXXbPPzl0qpLvSHCZidAgLlqFs=;
 b=II1Ocr62y/XVTmVz4IKDb6JXdDnhQ/LGE2LWlaxFW0MEBY/8mrPMwXpz9aLU/IhSJL
 XDOeWyKxB4r/iZppw1XD2c3LRJ5umFCjWxNw4iDoJ7wSO4BVND+kbsnuxu04rpjMCGjP
 o/Bwka6LaCkA41pX/6PWOnSxwp2xlRDDfp67tP/74Uq51ub0az1troYXgg5uAcy0EJrd
 rz6KB9g11AvTAQYUljjbARmhWzXiYLylPrAvTCQ9Rc9jGuy4Y8/9MKvpknmv8X5SSmLm
 mwriFmEqreIMb1NKDwGiefddoc1E4lpQSIBCgBr8RpA0J8Lef6PlGFFnV+NXL8jvJn+H
 Iigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726282690; x=1726887490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LUtRG/W4eX5Y0IkYKBXXbPPzl0qpLvSHCZidAgLlqFs=;
 b=J8mYE1YfCa5nv0tKLQEeD1dIQZ3AhOdNe62QVqNjkdUSxxXTP+pOZj2/tWFu1ILltW
 0/cfQ/IEU26CGHkOhojFs0ay7/Wt83MOKcxe7vlw+TjAdl3AUZySBM5pIz7ueRGZqYQv
 n7H7zTsj0Ewu6m/uRzRKpf8IsEFyEcGDht4d/8tkSVy/t+IoZ2g4iMRE7W+OChA3YMjO
 2GMynZjNqOtFd+Dud/nBJIbOLLduOp8V99u24demUNAD4yfd9URzMHhSkEp63L/ojFte
 4rUociXxPRHi5bc0gWnZlZTS6P9ZE1Cert9ymxnujka8jVEqQ+30tJuhiH9xZhH9GxzU
 BbQg==
X-Gm-Message-State: AOJu0YxMU2oNY5gOqzWpVEJzmx1XNi91F5JJ0bzKQYwEmuAZ+QWufI30
 l/ODOclK/MSq5y1M6+tKl1k+FfU9DI0qOhFCStWqKn+pZyLq2dAk6M+9GiSXt/jNpl4ZXvGmwLQ
 L
X-Google-Smtp-Source: AGHT+IGTeZv88I4N+hgw2njoONEfS8kcOKSpzpkeS3rR+8LGtIXUgA65IXvQck6+iEnDsFoYhxoq2Q==
X-Received: by 2002:a17:90b:19d0:b0:2da:8974:b3e3 with SMTP id
 98e67ed59e1d1-2dba006817fmr10760070a91.27.1726282689861; 
 Fri, 13 Sep 2024 19:58:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dbb9c3f593sm2587163a91.9.2024.09.13.19.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 19:58:09 -0700 (PDT)
Message-ID: <05f04c1c-e61a-4bce-b5eb-50a516255a3c@linaro.org>
Date: Fri, 13 Sep 2024 19:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Avoid shifting with bool type variable
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240914014342.2095136-1-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240914014342.2095136-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 9/13/24 18:43, Bibo Mao wrote:
> Variable env->cf[i] is defined as bool type, it cannot be used with left
> shifting operation. 

Not true; it promotes to 'int'.  But that isn't wide enough for the value that you're 
trying to construct.

There is existing api read_fcc(), it can be used when
> dumping fp registers into coredump note segment.
> 
> Resolves: Coverity CID 1561133
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> ---
>   target/loongarch/arch_dump.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
> index 4986db970e..d9e1120333 100644
> --- a/target/loongarch/arch_dump.c
> +++ b/target/loongarch/arch_dump.c
> @@ -97,11 +97,7 @@ static int loongarch_write_elf64_fprpreg(WriteCoreDumpFunction f,
>   
>       loongarch_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.fpu));
>       note.fpu.fcsr = cpu_to_dump64(s, env->fcsr0);
> -
> -    for (i = 0; i < 8; i++) {
> -        note.fpu.fcc |= env->cf[i] << (8 * i);
> -    }
> -    note.fpu.fcc = cpu_to_dump64(s, note.fpu.fcc);
> +    note.fpu.fcc = cpu_to_dump64(s, read_fcc(env));
>   
>       for (i = 0; i < 32; ++i) {
>           note.fpu.fpr[i] = cpu_to_dump64(s, env->fpr[i].vreg.UD[0]);
> 
> base-commit: 28ae3179fc52d2e4d870b635c4a412aab99759e7


