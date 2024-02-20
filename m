Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D852C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 23:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcZsc-0001rb-MC; Tue, 20 Feb 2024 18:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcZsa-0001r2-R7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 18:50:28 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcZsZ-0001IL-7N
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 18:50:28 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c0a36077a5so3734837b6e.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 15:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708473026; x=1709077826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWyrBptwjusPHJmkv3FMwY+gN8w1Mbe56nWTBZqxu+0=;
 b=HzQAcYk6jxrcQh3v0sg1LmGMkqK6mTV8nC+yz5Q+0NCb+totx90AD6DAm8qm7PJGGB
 TEv7y9WygUd2MGe6vh/u3gMLnsQ3TovBksZ7poaHk8TJ7VxI4ZBYXUd2jtdqdrHycp65
 rbIbqwKJGtisPKempxAhwTuGnQwO8TK7+KfhiDU2YYat0+B55pcCAUgEMerJWXSdW7xE
 IlWVmqF/uvs8OuV+aDJ/Zebc4P6EUQeQQMcrkpAEzNXF8Cxmp32n6ScxYmrkckGJ5lO5
 Jz/piKwk14A5bQA5VNYGVRyXi7BAV1nsWolEpzAU5joAUG/yKwLWFBrAVJCXex0HjwUR
 Qvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708473026; x=1709077826;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWyrBptwjusPHJmkv3FMwY+gN8w1Mbe56nWTBZqxu+0=;
 b=TRkYDc2Povl26IskJTiAU1g5hVBtllYbiBsQ/JLMKKit73yiBnG2I0Vc/u6IDIll/8
 KiBTjwvjx3B2YXak9lz/gIB4FTz05vvPaQPfOiQafS9xBOTtI2NZ9ISAcWmWjlKEkZp2
 LAS21N29b6UYC/cvpLDkxMroB5yzL0izRplM3lIjwLqltZl0P/H4HgbBTNk9wAQQjzhp
 cKj2Mel9iP3YGcKMiipTK9hUevuD/YhZpC91phOETwp+Gx9/MGQXN62Upyf8caONY4xN
 z+QCuB1AZ8cFRXeV4sPYInfUD7EL3+8nt8T2CL91KD6nclg9ihtbRu/banOGPs11oRP0
 DN0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu30Jj5YnSIWzXimyinRvREf0v8EihP9RUrDS7GtzR2kIw1iVffOrIZ3NwtcnEfwe6/I6Ta5S2ZrUC+Viv+1b+Jzpb3WQ=
X-Gm-Message-State: AOJu0YwgpoZuPnuJu+uOK2m9FBY10aKHTp563gluv9lQGK0UD6uL+TQj
 FbV1VrAl8eDoLphpCXgHzjBX2NrnHruUlk+SdgkfkeBNWz2wtReZI5DYik5+0es=
X-Google-Smtp-Source: AGHT+IEk8/CCQQoitRZdR1QsSk47OVehyjGutPuIObgFPjq2Jx4lO2FibjcktFElRC46hCca0IfmPQ==
X-Received: by 2002:a05:6808:130c:b0:3bf:da3a:cf15 with SMTP id
 y12-20020a056808130c00b003bfda3acf15mr22254910oiv.40.1708473025781; 
 Tue, 20 Feb 2024 15:50:25 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w2-20020a62c702000000b006e089bb3619sm7817082pfg.112.2024.02.20.15.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 15:50:25 -0800 (PST)
Message-ID: <15f50bc1-f154-4b4e-8eb2-23d7e07c7915@linaro.org>
Date: Tue, 20 Feb 2024 13:50:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] trans_rvv.c.inc: remove 'is_store' bool from
 load/store fns
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240220222510.209448-1-dbarboza@ventanamicro.com>
 <20240220222510.209448-3-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220222510.209448-3-dbarboza@ventanamicro.com>
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

On 2/20/24 12:25, Daniel Henrique Barboza wrote:
> After the 'mark_vs_dirty' changes from the previous patch the 'is_store'
> bool is unused in all load/store functions that were changed. Remove it.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 69 ++++++++++++-------------
>   1 file changed, 34 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

