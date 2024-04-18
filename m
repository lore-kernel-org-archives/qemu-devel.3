Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D8C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVzh-0003s3-2s; Thu, 18 Apr 2024 13:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVze-0003hD-RR
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:56:18 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVzd-0000G9-7X
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:56:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed9fc77bbfso950482b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713462976; x=1714067776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qHnil1lWS8KrpZkQrwQieUyLD43mQT1Y8ff8vzPt6CA=;
 b=lj4PWZH6+Ae7hOLC4bWL3gtxPegF1V5PeMsJTtvRSZ70NlJUXkvolDdSey98Up9FNy
 pd8kF7rixH5tw69TaOEZXDgqgJVzTGkUPig36s9ewTJqSjRSCHmclYcUl9uFlTmKkseO
 3p4F++6zZfN36lgI4qmO5EAS5K0Tuc+fhmE+pw8xIy+ko+74iknCoz7Zd7wNE+ismKaK
 6XsrLm0qnWXl8jsJ9jdAoMyOAhaLxaJMrcO7t/LthttESC4nzzSDfj2mA8S9JKdBQ0Mg
 AmFOjRIyxHWbYCm2JRNTQ5bFyZ6tBrDGhaE3Z2/KyQKodzP8DEDGbOcn7QXb2+QRdvDo
 LkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713462976; x=1714067776;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qHnil1lWS8KrpZkQrwQieUyLD43mQT1Y8ff8vzPt6CA=;
 b=ooC8nyKLXLqwoidRSS2ZIRPQx9nneetIBlXijE5ijHcACg3OpvRGorOKJOAb18lPDo
 eMxsH3b8DN5LXuPSGMe75eXfK3yBZsQffFe/9x3dw5nBZPu+3QFBMLA13oy39wfE4QtZ
 HoJSgy6I7U4bW4E4uNtUezRP5gA2DJbFZRmhSVxp4wHBLGtfQTwz2DF9rSd2ncUKxEfE
 X/6t653/l84sOBw+C8x31xdVhtdj+755UfqGL4jSkBdHWMLxTF9i8dyBEOZbMzbzt/m9
 ymMnmyVNZtM1/vKwXYoSWZLWEU3x39xIbFshyQImf6Q6AK7f44uf/aAxfD+TCTe+V6Cf
 PwDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpFHyP2yMr4N70POrzMqOSUl9Of1OLv2Z/aNGjo95SgY7cX/UYf61eu2N0fW+uFa1F3yYPdiwBoSGT9IRmECzwnC/K740=
X-Gm-Message-State: AOJu0YwROAE3j/qaS3nF3wTz0mQp4MEox4cKQyCDKXzuYfgYLmPiHdw8
 wVlNv0sTbgw3Py8hDW2UAVwL8mzAD4RTzn4AgyAiVA2XlSCmssYTCHYExOB7zKs=
X-Google-Smtp-Source: AGHT+IHN2jCdljAWl2j/jKQE1FDNnbxL7tWsvdj7FNrShDUB1d6gq02GIWb1oFDRmUooSIdKBA7a2w==
X-Received: by 2002:a05:6a00:4fcc:b0:6ed:4203:bdd2 with SMTP id
 le12-20020a056a004fcc00b006ed4203bdd2mr4335788pfb.9.1713462975730; 
 Thu, 18 Apr 2024 10:56:15 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 du19-20020a056a002b5300b006ece7286c68sm1767807pfb.41.2024.04.18.10.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:56:15 -0700 (PDT)
Message-ID: <98a7be34-d07b-437a-84d2-7542c4a35337@linaro.org>
Date: Thu, 18 Apr 2024 10:56:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/i386: Introduce cpu_compute_eflags_ccop
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/15/24 21:06, Richard Henderson wrote:
> This is a generalization of cpu_compute_eflags, with a dynamic
> value of cc_op, and is thus tcg specific.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/cpu.h           |  2 ++
>   target/i386/tcg/cc_helper.c | 10 ++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6b05738079..285f26d99d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2379,6 +2379,8 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
>   
>   uint32_t cpu_cc_compute_all(CPUX86State *env1);
>   
> +uint32_t cpu_compute_eflags_ccop(CPUX86State *env, CCOp op);
> +
>   static inline uint32_t cpu_compute_eflags(CPUX86State *env)
>   {
>       uint32_t eflags = env->eflags;
> diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
> index f76e9cb8cf..8203682ca8 100644
> --- a/target/i386/tcg/cc_helper.c
> +++ b/target/i386/tcg/cc_helper.c
> @@ -225,6 +225,16 @@ uint32_t cpu_cc_compute_all(CPUX86State *env)
>       return helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, CC_OP);
>   }
>   
> +uint32_t cpu_compute_eflags_ccop(CPUX86State *env, CCOp op)
> +{
> +    uint32_t eflags;
> +
> +    eflags = helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, op);
> +    eflags |= env->df & DF_MASK;
> +    eflags |= env->eflags & ~(VM_MASK | RF_MASK);
> +    return eflags;
> +}
> +
>   target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
>                                    target_ulong src2, int op)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

