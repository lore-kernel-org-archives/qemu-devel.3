Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281C5CF45C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMeJ-0000TO-NI; Mon, 12 Jan 2026 13:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMe0-0000RQ-F7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:28:02 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMdy-0002Ru-5b
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:27:59 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8be92e393f8so603383785a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768242477; x=1768847277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TrhVk2MT0ajl1+qLDEaEWTqJIze/lLE/jFMM4d0P33M=;
 b=kwzFlzm3MmZsxUY5lbT8W7PiG0mh7UXb6D84WdGJ3NMCnWKARaMBLv27FpypozO/mr
 Yb0sQsxVeR9zu9PIH0ScNBi28ljW6HyfDJ9/VvsfX7olzweSmDso/rS54rUZZg6ycuLJ
 YvEANx+jn9jr8P3I4vWnycwPKXxkyxN9K+HqVWHAnPLSHCj5JYRq9KfwpsRVWyyQLUVL
 N7iklUuWHlbF8WfnHcpqF8AXl+Xn3UntkZi1GqbyFcoAq848wxZ5ajSab0AApw8CY0sz
 AKXm/Yzr3L7aabXPF7L7glfL4axwlUmoE7bQaKq3ttNbRIc8nMaQApfr6MFHcAuY2Oj1
 oVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768242477; x=1768847277;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TrhVk2MT0ajl1+qLDEaEWTqJIze/lLE/jFMM4d0P33M=;
 b=JjWw5uebVLjT6KY4iRAbdEtSiV9tCm/crZOg1XurM2w8i4dqP4YeHX0DcvHuCOTKi2
 DHprGNH7ObQUhfm33XkAvIkCkw639VR6eZLvvH6gbSQE7HcXt9k9w2u6h9O5JxQXd8Xz
 9KQ6NKZgUT0c27iv6mRIMAp7clxlPwH2MDZVkRWmCEo5D77vMzSyZ1lGqs2BVnWS6yjY
 fXbbmVWS2rGWjRn+kW4WMgtuESZv9bbOLZhYzVqnP25zendnSgGnAYE6pldK9sMnNLUc
 E0FDOLkCq3Fw4i/ItpaDh71wmy3nNq7WI9LUlsELQPhahYPX7DgNK7e4JDz2gjcyfGZi
 Od3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlNRm9xFP5IVdDwEnafvQH2Op6FR7odD5g2MXscE91oQvTseBzCelRn2lMNbVxNzFx86qEtuT10z0k@nongnu.org
X-Gm-Message-State: AOJu0YxsMFTiaBalHxmYX/7bZay3BVRbAyuJiHZmvJEoJsdIqmN8CRGv
 03rpKH5+mOuAs9QbkM7FYEOL1+Ri24o53N2V4JSgseZem3eC8kFkPY0Zktg3bkB8/dc=
X-Gm-Gg: AY/fxX4J3s3Gy8P7dSl/5ms6pMdNfwSDds7BXr6KHn6VrbSEWKyZJlkrNvdQ7R7LkeE
 23T83Y4eNTpNsnB4NWJ+vPooN/gpM7zq0TQonkYCUKjjRDedzPAikIjRKHa6leLcY0yXGH9hywU
 igxRthZu8sMWBHtUQyElIUe36Bj0G19FI0gdOYFweJULU0iAZUNDGeZ7GVfW9aQbdfh147Q+Qx8
 h6ZTbzO0OEjXjevhFwfzDQxJqRnjzUJUO/jMdtjC0cJgyYg7L7EHvHFB2mtk4PywEB3QR6vv0HM
 UwGJCmL+mecQj1TAiE1iuAwSNpwkHLvzDrPJaW5G8+bYZsQvWtJ1P5wHcVQQky5fbWZlHnnbiox
 uGSKlPy8vZIYriqsByoJBizXkw3Z47spP8erRa+1EVyO//D5Jsx2c+11ckTGQoimYNl1IefdpYO
 pAad6RdEJBA8zy7JgfTpHXZkBe9l7XYaihvL4aGCWh
X-Google-Smtp-Source: AGHT+IG2cgurOIlLliGzTWqPwYcSMBJft8heZDhSVDwQUOegYHRPgL4IiEbgHv93ft4UfuLh9ntDNw==
X-Received: by 2002:a05:620a:3952:b0:883:647b:6dec with SMTP id
 af79cd13be357-8c52083f733mr46611585a.3.1768242476999; 
 Mon, 12 Jan 2026 10:27:56 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f540650sm1547338085a.47.2026.01.12.10.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 10:27:54 -0800 (PST)
Message-ID: <4ee2f8cf-3872-4b0e-87a9-7da336a760e7@ventanamicro.com>
Date: Mon, 12 Jan 2026 15:27:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] target/riscv: rvv: Introduce reset_ill_vtype to
 reset illegal vtype CSR
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
 <20260108132631.9429-5-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260108132631.9429-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/8/2026 10:26 AM, Max Chou wrote:
> Replace the same vill reset flow by reset_ill_vtype function.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/vector_helper.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 525a47bf66..c7b9d6b467 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       return reserved;
>   }
>   
> +static inline void reset_ill_vtype(CPURISCVState *env)
> +{
> +    /* only set vill bit. */
> +    env->vill = 1;
> +    env->vtype = 0;
> +    env->vl = 0;
> +    env->vstart = 0;
> +}
> +
>   target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                               target_ulong s2, target_ulong x0)
>   {
> @@ -83,11 +92,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       }
>   
>       if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
> -        /* only set vill bit. */
> -        env->vill = 1;
> -        env->vtype = 0;
> -        env->vl = 0;
> -        env->vstart = 0;
> +        reset_ill_vtype(env);
>           return 0;
>       }
>   
> @@ -103,11 +108,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       }
>   
>       if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
> -        /* only set vill bit. */
> -        env->vill = 1;
> -        env->vtype = 0;
> -        env->vl = 0;
> -        env->vstart = 0;
> +        reset_ill_vtype(env);
>           return 0;
>       }
>   


