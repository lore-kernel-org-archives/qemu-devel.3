Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7451C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdq4x-0000hQ-CI; Tue, 13 Aug 2024 07:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdq4v-0000bW-SJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:52:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdq4t-0005CB-EI
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:52:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ff4568676eso51447515ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723549957; x=1724154757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=woDy5XoMnO/3tyDi7eiYP4/5In+k43tYrb/BO40O4HM=;
 b=FgPA2oTe2QLg84VrNSyPqHCIIQjeYnYdd5Dfs4FV6sBuoBC1tHmyoQu/yIV3e5prMX
 wcjE6ztw/ikMJzKvyXzPiDxizmlc0x34Yy+XRlLQ8WuhRvD4FZC6MVVNOE3KQUus4t9D
 pVgqAkbTO2G9fanrTKGj1t+yVSydZ+29p2Wg0ztpQ/boJdM2He0uLH9HbWDThAXZVZ30
 5KB6ddHpHPeWeVw0A07s+VIEzDSISt9XOzghRtoP1TwcMQ+KZotPRp6pcB1O0AOJPJMQ
 PjREDYU44/tPG5lxSFOw+XCKRqJ2NwwFsssI1Xi6ieEyFgdICVPqYqhshj2NZ+m66b/4
 QGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723549957; x=1724154757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=woDy5XoMnO/3tyDi7eiYP4/5In+k43tYrb/BO40O4HM=;
 b=f6Y6Xu6lsrtDhnoMU8MyA46Jm1dBrnYpVhCwmEws6fAY/YsQTem5J/FVFOCHKtFIEJ
 t/jvD4RoYTFAsKBZ0CkHpf2G/X3Plh9iDkkQk3NSbE7Di0L7tXs/pZ9aPpyoOtPMwYxL
 ksYXKhgpnn+0EYt7jiZ+UNNGdGcU9Mzpv8EaDncJ/FDl+hvehO6BFfzdHMkFm5aCGsFS
 60t+eClOWlL0H2ThKq25ip4n0KucetwaJBFHWDW11/pE9sXmhgalywx3C5ugQI/pdJbU
 GQ27t31TtskgtlQT3QmLzOe7voTaKhi6tzI1YB4X/y9wWyBdEjdSlisjo+b7uvBsXjS9
 6aFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXednEdbuJpQDeYFTIKXWDGA/lxNlAhb4tq7tpEa0tEbuOeKPHY1ivZx3zpbIVSeCEf7ALtUl0/ZbaRIgUS0+fyyZ6jD24=
X-Gm-Message-State: AOJu0Yw/HY1QJKi59A4HmdCpg7nnPrgAjEf+9tT2bD+uFbvJeyWFZqw6
 RnIrhQ3OXtNnqCqMi3oFgLYtM6lHGOy0xaSCpM7L5dRc+lr4HmrizV9vUJB0KWQ=
X-Google-Smtp-Source: AGHT+IGfc0pzdDaX+aev7fOgxT5jY53Dm0FGKEoYbqPBU7xIOTCk0ocPVl5mzQ7l5gFbQoftDP2wbQ==
X-Received: by 2002:a17:902:da8e:b0:1fb:44e1:b5d6 with SMTP id
 d9443c01a7336-201ca13de37mr39340945ad.23.1723549957060; 
 Tue, 13 Aug 2024 04:52:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd14e084sm11898925ad.110.2024.08.13.04.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 04:52:35 -0700 (PDT)
Message-ID: <2efe353a-4700-4632-b919-e43cb039c2c0@linaro.org>
Date: Tue, 13 Aug 2024 21:52:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] tcg: Fix register allocation constraints
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/13/24 21:34, LIU Zhiwei wrote:
> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> 
> When allocating registers for input and output, ensure they match
> the available registers to avoid allocating illeagal registers.
> 
> We should respect RISC-V vector extension's variable-length registers
> and LMUL-based register grouping. Coordinate with tcg_target_available_regs
> initialization tcg_target_init (behind this commit) to ensure proper
> handling of vector register constraints.
> 
> Note: While mov_vec doesn't have constraints, dup_vec and other IRs do.
> We need to strengthen constraints for all IRs except mov_vec, and this
> is sufficient.
> 
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Fixes: 29f5e92502 (tcg: Introduce paired register allocation)
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/tcg.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 34e3056380..d26b42534d 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4722,8 +4722,10 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
>           return;
>       }
>   
> -    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
> -    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs;
> +    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs &
> +                                    tcg_target_available_regs[ots->type];
> +    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs &
> +                                    tcg_target_available_regs[its->type];
>   

Why would you ever have constraints that resolve to unavailable registers?

If you don't want to fix this in the backend, then the next best place is in 
process_op_defs(), so that we take care of this once at startup, and never have to think 
about it again.


r~

