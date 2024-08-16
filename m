Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53BDC52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 03:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1senC7-0005rh-7g; Thu, 15 Aug 2024 23:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1senC2-0005oq-Is
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 23:00:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1senC0-000297-6R
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:59:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc5296e214so16500335ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723777194; x=1724381994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Fa3cMAo+2zsgYTl/HJ1Bxva/sVqWKNEHyQ/EBateBw=;
 b=ZLKulOU6ChtsbstJ2WnU9OnAYzjDl9NEVg4LCT5YZAuaS8xHq8EZW3C6Qqdb1xUxu/
 fS+pr4n6XkC4xlA2IjvsLHGw6AspwdMgU90iGvT/YLL815Wkrah9d4AfcxrM5jqsiizG
 CROjWR4FD9kkUbYOnp+RhnqLDglUUhjk5YMnjdkEiRARF9OjDmCEeOmMjSs1XRh0vKQL
 8OAK8PBZYJElMWdiBInEUeQJUup2tS8YMlXgSClcxS2Vf+tILhRKzOZl17xnzwnHQa0w
 v9MFEXdv5FtAhGBpbOFDx7OT0Hi+EyX9UByRs2z6L7a7/lmD4ujRlNL9R3Qrv35LffCl
 3b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723777194; x=1724381994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Fa3cMAo+2zsgYTl/HJ1Bxva/sVqWKNEHyQ/EBateBw=;
 b=h35bYz/5aa0swl5wYx1kBKETYriBJ/jaTv0PT9wxc4z1e21MP5an5vlF+JznmTh26M
 fyOjIEHqAldSUtvoyAc7mnr3gmSmyKm8aIzuP7E2Dle/S1Mn4KBrZEstQagjbZzM2m2u
 FtGNYoEoyLPYK2zaIFKuUw+5nh7vASoU549WU8Fum6yXoxKCf3IvkQD5qkjgClikNgWV
 pcl/MXDLV+qFuvJO/BUbry6rJ6Xcuh4ECJxYtPzZagQh/+5sjVjkKFtEt4OdD5mJqyPL
 SnxFhJvLGHIHiSYKlltc+u6zz71qzczwphHEl5Npps9ELu24MzmewD/TM3UPdRQ1Enkt
 cEqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjBI7kNJNb2aFho5L5plE2RySNkj/EIJQPMPNpHKdw+eXQ0i0pQkqpuv+m3T2CASx/xmFceEuLelytr+QqMo+7g7tAGew=
X-Gm-Message-State: AOJu0YyhaWZjGodIwEjXyfX0312ERJnuisaYUh4/zY99EdSqpQoRqV2/
 zcPren85VMlap1SlRna9BeATLnydaxl3Ws/yZ8Mqvbw8hSIx5z7WdDmuls/ZcCE=
X-Google-Smtp-Source: AGHT+IGh2IjfYgg6/oBP26YxJLzvmMrlPw3Utst+MQF3mfq0qZ8WfzyVtKKeBGPwuZUGqG284aOL6w==
X-Received: by 2002:a17:902:c94f:b0:1fb:a38b:c5a7 with SMTP id
 d9443c01a7336-20203e55365mr22027135ad.13.1723777193706; 
 Thu, 15 Aug 2024 19:59:53 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:d09c:46ba:97a2:4a99?
 (2403-580a-f89b-0-d09c-46ba-97a2-4a99.ip6.aussiebb.net.
 [2403:580a:f89b:0:d09c:46ba:97a2:4a99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03a55a0sm16650765ad.294.2024.08.15.19.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 19:59:53 -0700 (PDT)
Message-ID: <b56dc234-10da-4f65-9dc9-a205948ffff5@linaro.org>
Date: Fri, 16 Aug 2024 12:59:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/16] target/riscv: save and restore elp state on priv
 transitions
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-4-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-4-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/16/24 11:06, Deepak Gupta wrote:
> @@ -546,6 +575,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>       }
>       bool current_virt = env->virt_enabled;
>   
> +    /*
> +     * If zicfilp extension available and henvcfg.LPE = 1,
> +     * then apply SPELP mask on mstatus
> +     */
> +    if (env_archcpu(env)->cfg.ext_zicfilp &&
> +        get_field(env->henvcfg, HENVCFG_LPE)) {
> +        mstatus_mask |= SSTATUS_SPELP;
> +    }
> +

I think this hunk belongs with the previous patch.

Otherwise.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


