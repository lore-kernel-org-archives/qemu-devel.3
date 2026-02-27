Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BED104891D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5zR-0002Zd-Rt; Fri, 27 Feb 2026 17:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5zM-0002ZO-Fd
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:07:12 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5zH-0005u7-A2
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:07:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso21943375e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772230024; x=1772834824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gez0QBc4OJlPWSsA08sGbil5Uc438dSVgQNIdD62eQ4=;
 b=U/D4L6uxwlYGcee1/etFkNkh4qL0Y6m23T4dgsQIo5XfnCMlFsXIGOwg2HEuaiRiq0
 XID8Z80x/ERL3w5HBI3z+ySB26zcOIRVOczfbX0WYzM3N+62gTreUMrv2zacZm2uInjs
 eWt4lgOV9x5wNFEiLacNQVo/KkovJcge6/1rGfE1QKU0pfdhD8hfh/WaqNCyX7NN0t/M
 FmCRKD2928V+DeZhMH+VbKWa0vnH0fNk+kkkLO4obYuIN714b+Og9r1eurmD6Mlisn7/
 XtX+hMV4glfcHJodj7zv3t364M/tv97AFN8Vhxr/o1MO4ZWOG3hl360vElTzE5cBoWD2
 AE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230024; x=1772834824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gez0QBc4OJlPWSsA08sGbil5Uc438dSVgQNIdD62eQ4=;
 b=gm6jw5DaBoPJS8HyvcHhhAa+FvEZnLmTdyNKtgNu/tMiGJdZ9DliAGwSSFaaTEBDKS
 hSJJwWjdL0OEigP5KpnL5jZFU7jtIoHImF5D9IeqCPET73J4UMdFQEXE2tRzNpK2haPB
 JoI3j/kYQWVJBb/RY0W1LetQ/fZy/oUHUOhBQtNQd/9Xq5xvrA7Usa5Tj3L/91SxnMeT
 trI4dJ4tCe/9sYfSnZ5MGHCaVx60Fk4JN9NfELv1kqVPo8SfFSqjXvBvpf9aVJyPmmBo
 r96drGK2AEmZYeCCU0uGMq29Tq49Q6p34JeVs/7nEclxJP5t1+QxH9XHnJumhTuLSb1x
 ll7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmxppRCmAe2poQ4zvpRKqe0XGoSEqxkebM/XfUZb3dRnyT7J+63MjCezoljU3t2SqMNw+4NVAFZUwZ@nongnu.org
X-Gm-Message-State: AOJu0YxjOJq00ENoxVRTuS/UbgdVZdzJ5PMRJ5z7UagD+NZoa6d3xp0f
 nkp3Cd0yYE+k8KneAyjC7R3oO4KZdyAmuWH9FrMpW4EQz6GXyf0xQUW24JjyepERsn8=
X-Gm-Gg: ATEYQzwHVofkIcJLZVOe7JWVG1AqgUZQar6CY5C51i+KsF0xaueJovC99ztCkBmYWAp
 EMKRmNiMaw/i/QQWldf2CGX6gpxltgwFlUmXwG8kk28miJsnjIRCT7uBEXX6juXcxQxj3KLkXyg
 j2r5rzZnw6hakAsrnl5z//bNgiBSW4Gbmk/WUZ9y3eplTAWx5QueLS7lCFcvib11B2GslZfWZgd
 awCCdYXqR/qcbDwrU3ww8yfgmSavH3Q40XGIy8yn+FKVI4y1YsLtJKpS7u6hiNDrz8ABZuV2/xi
 rqjOHPjWhQsxRhklW3f/Hmw5dj8bgXN9fEW8Rsk10NPeCjNrNxh6g+KPh8mVfEnQw53WfXtjR3K
 y2FSLbSWLRmuy31eIXH8j4EcvW5kSTrMllkuooKRlKIfvvIWIwtzbLTjXwxYmYQEgTmmbIhqyFx
 ne9o9HETNbA8lWx5IUNHjRBgyTyMxa17g25Jj6obRQ6fGVFXQFhPZJhBG+30TDgZ1H5FD6RMRw4
 yI3
X-Received: by 2002:a05:600c:1c28:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-483c9bc5643mr76696935e9.3.1772230024281; 
 Fri, 27 Feb 2026 14:07:04 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60f764sm9576642f8f.3.2026.02.27.14.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:07:03 -0800 (PST)
Message-ID: <9a3d3ea5-962a-44b2-8e5c-7c445741e928@linaro.org>
Date: Fri, 27 Feb 2026 23:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/37] target/hexagon: Add guest/sys reg writes to
 DisasContext
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-16-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-16-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 27/2/26 21:36, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/translate.h | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index f80830f5f16..6e1008b363a 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -40,6 +40,14 @@ typedef struct DisasContext {
>       DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
>       DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
>       bool implicit_usr_write;
> +#ifndef CONFIG_USER_ONLY
> +    int greg_log[GREG_WRITES_MAX];
> +    int greg_log_idx;
> +    int sreg_log[SREG_WRITES_MAX];
> +    int sreg_log_idx;
> +    TCGv t_sreg_new_value[NUM_SREGS];
> +    TCGv greg_new_value[NUM_GREGS];

TCGv_i32.

> +#endif
>       int preg_log[PRED_WRITES_MAX];
>       int preg_log_idx;
>       DECLARE_BITMAP(pregs_written, NUM_PREGS);
> @@ -80,6 +88,34 @@ typedef struct DisasContext {
>   
>   bool is_gather_store_insn(DisasContext *ctx);
>   
> +#ifndef CONFIG_USER_ONLY
> +static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
> +{
> +    if (rnum <= HEX_GREG_G3) {

Shouldn't we assert(rnum > HEX_GREG_G3)?

> +        ctx->greg_log[ctx->greg_log_idx] = rnum;
> +        ctx->greg_log_idx++;
> +    }
> +}
> +
> +static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
> +{
> +    ctx_log_greg_write(ctx, rnum);

Should we assert(!(rnum % 2))?

> +    ctx_log_greg_write(ctx, rnum + 1);
> +}

