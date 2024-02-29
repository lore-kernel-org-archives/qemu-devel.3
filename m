Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDA9C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfl4o-00065S-CH; Thu, 29 Feb 2024 13:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfl4l-0005zs-Tv
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:24:12 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfl4k-00047F-DA
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:24:11 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29954bb87b4so898682a91.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709231049; x=1709835849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kkRWlFAQfwRG1ReVsWUCQxRCLdjMzhkx+wrTfZP2Gx8=;
 b=v3TeZ4i5Gf061BWAsiswVDyY5LU/uRO5wxmj3rLCC6mkN5rFIdE2vybOMe3MehA3eW
 rlCmgQFY53ajIQx90K19WJGkq3dDKFjpA6dUckcZfx4deaaVHn4J+w2lL3vccR8SImzu
 TxoMNizXu1OLzrhFPNe1stpfGFG6JLJ6RtE04oxU4taONQpAJMdYAMHE+sNkfA4UjlAJ
 evIDdDmkHts2OUH7uTDF3Sk6XZSeKVGwzSt7jVWea9dyg0lZ5rfPs8qXivXWpRx74x/S
 odJR7x/eHmk7RPjRNb9TCrOmiD0U2W3Gi/rNNPfhhzNmeVYoj2Ukan9tis0KpDBZm99R
 lA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709231049; x=1709835849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kkRWlFAQfwRG1ReVsWUCQxRCLdjMzhkx+wrTfZP2Gx8=;
 b=UCf2RHSUeDNEZiMctN1kP6iVi/bpCO5aQVx2jI7osvnuVmSECUhSp6EUHaeZD7jOwG
 t6wTYnGQCHDvyAInggm10iqn6mKMkx0IRAL4bUjVetr7+/gLGklIaa33cteucuPVgfsc
 i9fnaWGD/kogDBPJi/tH/pA7tWdYSvlmqVSEnySN2sp/yJS6n3ceKihe47lYeUkzeER7
 b1kG3qBXBM9hJvNzz5UfFs0jCGf4CZGQ1Mfw+laaC+hCMpcFvz8nFfpXDd3oafi4iqxW
 jJwhNQtOGm72ZToKrTZ8Asy+tYKE8xjIudOrsHhE4SOfMcTNmnmhdK+TAs9SAvEfH9Q+
 LjpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfL6MbRXPHkg6Jr80SBWe39lMX3yTs6rawZ3/MxzKKYYPDeGfvPGXP9tcT5zuX9W9nfJ3h3bJKeZCFrW+VtV3ExuvcNNg=
X-Gm-Message-State: AOJu0YymJKdlwqiEcboUy7jTid71L+taPQ7WNqeGGoHtEJUZa190Klgu
 qrIFSkGxfjRmh6qb4C5EYgAKJyNE2my5IQ1pzwcqDlllOk8OZTY+ouKX/3Ckf6c=
X-Google-Smtp-Source: AGHT+IFhDiOfbthGxE89kBRhcgrtagugcugcUq5OmjWgtuuCe52yQAb8QOT7Wi6E8qzC/jok7ljYGQ==
X-Received: by 2002:a17:90a:4210:b0:29a:e097:50be with SMTP id
 o16-20020a17090a421000b0029ae09750bemr3172833pjg.31.1709231048993; 
 Thu, 29 Feb 2024 10:24:08 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 br16-20020a17090b0f1000b0029a8d207010sm3895756pjb.54.2024.02.29.10.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:24:08 -0800 (PST)
Message-ID: <dcfa3952-0c22-46ed-b0d4-b66ca0ea5251@linaro.org>
Date: Thu, 29 Feb 2024 08:24:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: riscv64: Use 'zfa' instead of 'Zfa'
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/29/24 08:06, Christoph Müllner wrote:
> Running test-fcvtmod triggers the following deprecation warning:
>    warning: CPU property 'Zfa' is deprecated. Please use 'zfa' instead
> Let's fix that.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   tests/tcg/riscv64/Makefile.target | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
> index a7e390c384..4da5b9a3b3 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -17,4 +17,4 @@ run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
>   TESTS += test-fcvtmod
>   test-fcvtmod: CFLAGS += -march=rv64imafdc
>   test-fcvtmod: LDFLAGS += -static
> -run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,Zfa=true
> +run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I saw this myself the other day and didn't get around to sending a patch.


r~

