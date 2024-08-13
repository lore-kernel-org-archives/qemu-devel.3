Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60361C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 12:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdqVO-0004nJ-2C; Tue, 13 Aug 2024 08:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdqVJ-0004Vp-RF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:19:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdqVI-0000jR-4E
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:19:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fec34f94abso45794355ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723551594; x=1724156394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VTim0M8aAiudnjVU9beQplJDA4XOjxjzx0QnStTEJaM=;
 b=lx4M8FoCwKCOHZ/1djbunl0TQNgm9EbY7kI6FOA/1kdFs3cLfqbD8NtSIwjBzJ+rgt
 xlXsbahQby/Moj1tQ4A9BlWFc+Yf7PndjpePYQmvwv0TdPmlBKy9F8IdDu31kWt36gzg
 Oe9kT2EmKX2LsmJBGbw7WgGM3coWe+6DuvUEGPzCkwEk2E/doZrqhIySqHyoPBftZzw5
 W0LWM0bKjaHCHPrgYoqReKWho0W3SO181Y4EKiSkU/0E1tImR/o/d9xtGVj6rNEb6w0g
 H1MQqwOjne64YRDzXM+vbPlROfQFGSS6ERh33LabSSLd+qrCP03CmLpr5gqQ2H5ipt5M
 O0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551594; x=1724156394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTim0M8aAiudnjVU9beQplJDA4XOjxjzx0QnStTEJaM=;
 b=Day+3bNz8D9y1RtME8RkokwQkFmgMvGvggdtJNYqfwGRLb0tNJDiDpTk/WkTbSWBBA
 Hd0hGmIDGUU1DcPPUX5EfX8ZXVHG+jm+DhdOzpju5ttBmBMOuX6DY1sVdEEVLzJYsif2
 I7Jm4pjXJsD3OJ8NmVzsEpcXo595OJRhCfrtj2oH0B3sz/jAIkI1tHFbomS5uUqZIzS2
 a0sPtvXvNF232mH2Tad9ri+UWkoavF900J9+PVLrWvPxDLSgJC18zm5ujgzVLwRahIz7
 NjKFZqNP+mHP73uh1QDKO5WOlTwGhC1EP1LEDfEaXVk98VWzHr5vjuuOrp2k8dmm806r
 AjNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuyCia421oYzey1Gd93KzT8k44UaOqCNAWdnVTWJtfoVCr1zcXmtaxsAUCBTif7CZtNZOzT2YCwpPl35boY2JNS8RvFhY=
X-Gm-Message-State: AOJu0YxFBr7gz63GMaHZxomS55gWSPLdNW7G2oxSX/OJpAhCrrq9HsDJ
 CfkJ0Hu9R1RViLAsSmD7FsWLJHajgPW5nj3a6dSOZet6yFwTjeOomwovmiaIHrY=
X-Google-Smtp-Source: AGHT+IF4LGFu/aDKFxvb8qzfRXexhCffHOKqHA7ynILPSbQQXPTQ/wL4vMu4TnTp4PzIsOxIgGfVpw==
X-Received: by 2002:a17:902:bf4b:b0:1fd:96e1:802a with SMTP id
 d9443c01a7336-201ca1ced56mr37075565ad.59.1723551594235; 
 Tue, 13 Aug 2024 05:19:54 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd14b1bcsm12331455ad.114.2024.08.13.05.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 05:19:53 -0700 (PDT)
Message-ID: <b21e2ebb-6eb9-44ef-bbd3-c532f3d1f80b@linaro.org>
Date: Tue, 13 Aug 2024 22:19:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/15] tcg/riscv: Add basic support for vector
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 Swung0x48 <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-5-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-5-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> +    if (cpuinfo & CPUINFO_ZVE64X) {
> +        /* We need to get vlenb for vector's extension */
> +        riscv_get_vlenb();
> +        tcg_debug_assert(riscv_vlen >= 64 && is_power_of_2(riscv_vlen));
> +
> +        if (riscv_vlen >= 256) {
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
> +        } else if (riscv_vlen == 128) {
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_DVECTOR_REG_GROUPS;
> +        } else if (riscv_vlen == 64) {
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_DVECTOR_REG_GROUPS;
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_QVECTOR_REG_GROUPS;
> +        } else {
> +            g_assert_not_reached();
> +        }
> +    }

I think this is over-complicated, and perhaps the reason for patch 3.

What I believe you're missing with patch 3 is the fact that when you change the lmul, 
adjacent vector registers get clobbered, and the tcg register allocator does not expect 
that.  This will result in incorrect register allocation.

You need to pick one size at startup, and expose *only* those registers.

This won't affect code generation much, because we never have heavy vector register 
pressure.  Mostly values go out of scope at the end of every guest instruction.  So having 
only 8 or 16 visible host registers instead of 32 isn't a big deal.


r~

