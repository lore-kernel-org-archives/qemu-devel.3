Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB33CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 13:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqu6k-0002Ib-Ii; Tue, 26 Aug 2025 09:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqu6f-0002Hp-Cr
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:53:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqu6R-0005AN-Os
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:53:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c7edd71bbfso2997714f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756216361; x=1756821161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d6RVcu7TtsCI1UthkH5T8m5nh2YSjA+TXRxinaVHcxQ=;
 b=Av/LaV9AsB/keSCnQlNTbX3LD2QS/fhEqGcKLvIUPRGNUFV2ThOFz2nVj0jH4xyUSA
 mCYyTtKjUI6TaLIwpVBF0QoRKoZE9r8sgr6NNvsXzC/qNz4ppTynxbVUaDRJr8CawCiP
 F2PEspx4nf0cTOgqeSXhdmYsdOqL2qz5Uc1o3PcFF06c4HpdzuUYwd2ZhMJxK2fTnAoe
 kdjaj+S/5HuT9WQUXM00FgO2CNvh4lxYhLwQzbIWAg3CBJlslZtTzAlTvS56Ch7NrYCx
 ZwRUK3ZZq4XCGXrDawsybHkScapb+bKRVJzbczyuhDsb2jKtKm+ZjBWSFuoQy5aLRO7h
 qwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756216361; x=1756821161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d6RVcu7TtsCI1UthkH5T8m5nh2YSjA+TXRxinaVHcxQ=;
 b=ExL9KErs+UjLuDYmIYVUB75Tmj5Dmv1e3MLXuQG1PMF3tGWdVljmBun1PoqjN5XgL3
 yTuEZ29wVL+GvusiHoJrFDN0s5BUN2SrBad/wt70B9RNnJTadqlpzFdhr3oJAA9f2nwm
 2nYDpSgeTrGt2c1N0gOmMnLLPDNd26Z79YCUWZF/s7ZD+wuO7J9b+PQ20X25Xg4zUti5
 HCrztfMEJ3dvUP9tMJUCVk3N/Y4emyYSKjhqY5Nk/YWc19xZp+N1cvr0I9np+UNbJoJl
 moX6zPQI2mIqYdTZp+62tDthNL0Xhz/RhcZK9attG+hBKsrsyw3Z2+TWwxA2hp28Hcg0
 ISZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuG7chIFvZLyXg6wYsnAL1pwn4UyXMe0YJEQWo12QQ1ot2ZXCX3vsAYbV1eeIJ0PpXJPrzlvBMG/MM@nongnu.org
X-Gm-Message-State: AOJu0Yw4UXsBBgMqOWnT/iHCkp1CDk2yd2/t1jircYEZDvWHDpB5Zx9b
 kAaexxFl+0AXm0cz5VpIFbbJrN9TvX/p3bo5/rHQy8uf7BQ+c36iFA2kcZx+v1jOgb4=
X-Gm-Gg: ASbGncvrn116ifBUQXeQRCKQunFAeo6Ohse6mVJQcdTOn8EDjmnzHeAtFoXxZ6Lxd1l
 +1eszezXnN1jPsoI0MDoJUMA9XiirBF2lIH5Lch6uuKMiGn1GwrTLs3DgMp6PH99MFQD9LCB5eB
 MIpQx3jsrrQ0uaXZtoXWNY/Jk1ANAs/JpjiXxLfeiCv7kZ2K6AeylV3/ygZqzUYMh7XjpdFvmfU
 nOIRs57746XXDszCNClNOdKyZ/Qn0WZ4xpBklfDzB0MBzQlHujMWcaJqhUIrSVPf0gW5Aw3zA9d
 HWmqeIOplXdJF7/Ml+kZ3tFGXa/Ispk5CSj16KWpKRlsckH8mZLT/oPEkPr1IRdBM8Ngo6mT1sA
 H8sU4aja3Jy/ylp9yTspmWO0XU5Kx6bq2HPZWJXcw9NmA4ieNHwWL+lHt6sLkvrHtWA==
X-Google-Smtp-Source: AGHT+IG/4Z0+Jgkq+XDFjvXYw5HL1xMZ4nL94K3kPHFZM61IrJ5g+3RceNBlxRX8uGHRMTuDr5CPbA==
X-Received: by 2002:a05:6000:2507:b0:3b7:9d87:97ad with SMTP id
 ffacd0b85a97d-3c5dc6385b5mr11597727f8f.37.1756216360830; 
 Tue, 26 Aug 2025 06:52:40 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70eb7eed5sm15890252f8f.18.2025.08.26.06.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 06:52:40 -0700 (PDT)
Message-ID: <1f55d5b8-7b9d-455b-842c-6627c48af18e@linaro.org>
Date: Tue, 26 Aug 2025 15:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] log: change qemu_loglevel to unsigned
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-12-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822122655.1353197-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 22/8/25 14:26, Paolo Bonzini wrote:
> Bindgen makes the LOG_* constants unsigned, even if they are defined as
> (1 << 15):
> 
>     pub const LOG_TRACE: u32 = 32768;
> 
> Make them unsigned in C as well, and also change the type of the variable
> that they are used with.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/log-for-trace.h |  4 ++--
>   include/qemu/log.h           | 44 ++++++++++++++++++------------------
>   util/log.c                   |  2 +-
>   rust/qemu-api/src/log.rs     |  2 +-
>   4 files changed, 26 insertions(+), 26 deletions(-)


> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index aae72985f0d..7effba4da4c 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -14,30 +14,30 @@ bool qemu_log_enabled(void);
>   /* Returns true if qemu_log() will write somewhere other than stderr. */
>   bool qemu_log_separate(void);
>   
> -#define CPU_LOG_TB_OUT_ASM (1 << 0)
> -#define CPU_LOG_TB_IN_ASM  (1 << 1)
> -#define CPU_LOG_TB_OP      (1 << 2)
> -#define CPU_LOG_TB_OP_OPT  (1 << 3)
> -#define CPU_LOG_INT        (1 << 4)
> -#define CPU_LOG_EXEC       (1 << 5)
> -#define CPU_LOG_PCALL      (1 << 6)
> -#define CPU_LOG_TB_CPU     (1 << 8)
> -#define CPU_LOG_RESET      (1 << 9)
> -#define LOG_UNIMP          (1 << 10)
> -#define LOG_GUEST_ERROR    (1 << 11)
> -#define CPU_LOG_MMU        (1 << 12)
> -#define CPU_LOG_TB_NOCHAIN (1 << 13)
> -#define CPU_LOG_PAGE       (1 << 14)
> +#define CPU_LOG_TB_OUT_ASM (1u << 0)
> +#define CPU_LOG_TB_IN_ASM  (1u << 1)
> +#define CPU_LOG_TB_OP      (1u << 2)
> +#define CPU_LOG_TB_OP_OPT  (1u << 3)
> +#define CPU_LOG_INT        (1u << 4)
> +#define CPU_LOG_EXEC       (1u << 5)
> +#define CPU_LOG_PCALL      (1u << 6)
> +#define CPU_LOG_TB_CPU     (1u << 8)
> +#define CPU_LOG_RESET      (1u << 9)
> +#define LOG_UNIMP          (1u << 10)
> +#define LOG_GUEST_ERROR    (1u << 11)
> +#define CPU_LOG_MMU        (1u << 12)
> +#define CPU_LOG_TB_NOCHAIN (1u << 13)
> +#define CPU_LOG_PAGE       (1u << 14)
>   /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
> -#define CPU_LOG_TB_OP_IND  (1 << 16)
> -#define CPU_LOG_TB_FPU     (1 << 17)
> -#define CPU_LOG_PLUGIN     (1 << 18)
> +#define CPU_LOG_TB_OP_IND  (1u << 16)
> +#define CPU_LOG_TB_FPU     (1u << 17)
> +#define CPU_LOG_PLUGIN     (1u << 18)
>   /* LOG_STRACE is used for user-mode strace logging. */
> -#define LOG_STRACE         (1 << 19)
> -#define LOG_PER_THREAD     (1 << 20)
> -#define CPU_LOG_TB_VPU     (1 << 21)
> -#define LOG_TB_OP_PLUGIN   (1 << 22)
> -#define LOG_INVALID_MEM    (1 << 23)
> +#define LOG_STRACE         (1u << 19)
> +#define LOG_PER_THREAD     (1u << 20)
> +#define CPU_LOG_TB_VPU     (1u << 21)
> +#define LOG_TB_OP_PLUGIN   (1u << 22)
> +#define LOG_INVALID_MEM    (1u << 23)

Since changing these, alternatively use BIT() from "qemu/bitops.h",
as "easier for the eyes". Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




