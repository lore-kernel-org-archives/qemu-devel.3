Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AB4C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 21:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfoH4-0004wr-Ju; Thu, 29 Feb 2024 16:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfoH0-0004ou-7e
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:49:02 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfoGx-000878-N6
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:49:01 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dcb3e6ff3fso1128165ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709243336; x=1709848136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tSn7AD4QqNOPfV7LQwbbjlM8/w6lUBs1x43TwaFCZI=;
 b=f8c5Qr3j19wCW4uqBMdsa8sSwPg8u/M+erFzgMNbZjmBN0pZuUcgdjdolOA95B2CkI
 pZwZk68lkBpVAQG+LbnGyLlSxyEKGXLhvBywTkjDBumkzHqvnDL0VMQEGF0OfkBTfgaI
 7dQ14301INaT/YtAg8+nETn07i+VSOxFUyuERYTm6D+HBVe/9RPcg54osKebWr+w4bDO
 vQthjfEcNCJ/bP9WGYA9rJA1Y7fzFJdp3b4GH9meo/k8lOcKfnxJwwLk/xIuH2V8ilEQ
 ZdJC30hC+j1I7ntn5r99g2E7yZZv2zd9w572ETBeUWZbsRqopNo6Ypa2C1pf5qtZ1S9X
 MAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709243336; x=1709848136;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tSn7AD4QqNOPfV7LQwbbjlM8/w6lUBs1x43TwaFCZI=;
 b=hC1tiVw4FZmTaa/AjvXTmB2vnpKwMSFA9InWn0Sfwh+omfYUJSZp6f8RbKNE3II6Sf
 inS0Q7dcg782wo+e5QB+cBfmWCwCSqGmNP6vwowggysMdp9wSLweP8N3bQKKHa+9dS75
 4UbiN6z85G3R57aEybKXyHhUV07Yp30dk/T+d7uq8KpToC1HMkME54QaZ1yY09uofjS0
 LIFHESxZV3GMuk7fCYZChRQhM1SKWfKuntqWbyZ9ubSxVaNkIRxHV31AsyClLo1e3MOA
 eFdfk06BhqA4vfb4Nkwu6cUTSerHHfp54ixeWrmYGHNRjBH2FiAImh6RfROOoXz60jWm
 dI6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwR/B0efbIeNz7q8uuE1MOXSXon8MrRDCRQjh0bu6ajdY/x5Z6zCEztHzT4PbTPm+2r4m6V1dFkXrfD37kQDJAthyX+3E=
X-Gm-Message-State: AOJu0YwwD2tU0JtJVjgynKA7J7H9xyNEMAsJVj7+LQJHm41442YbZ6a5
 K701ahPiv7X2jjeOSSaMouNtxy3jdgq7xPZkur2hTLlFbaldFRCLwiXpZFZb+WQ=
X-Google-Smtp-Source: AGHT+IGlum+AN1mUmO+ybdS+XZKlAubIbVgyWndfXGfNLZ+x7/4X1LEqWivnivxBz+BhEJ5kUlj9wg==
X-Received: by 2002:a17:902:bc43:b0:1dc:2d4d:45a1 with SMTP id
 t3-20020a170902bc4300b001dc2d4d45a1mr3348668plz.19.1709243335773; 
 Thu, 29 Feb 2024 13:48:55 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 x9-20020a170902a38900b001dce24ac4dbsm892488pla.136.2024.02.29.13.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 13:48:55 -0800 (PST)
Message-ID: <7d5fee5b-870b-470f-a6bb-119d1a65be0f@linaro.org>
Date: Thu, 29 Feb 2024 11:48:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 04/22] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-5-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/29/24 03:10, Jinjie Ruan via wrote:
> +static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
> +{
> +    if (!dc_isar_feature(aa64_nmi, s) || s->current_el == 0) {
> +        return false;
> +    }
> +
> +    if (a->imm == 0) {
> +        clear_pstate_bits(PSTATE_ALLINT);
> +    } else if (s->current_el > 1) {
> +        set_pstate_bits(PSTATE_ALLINT);
> +    } else {
> +        gen_helper_msr_set_allint_el1(tcg_env);
> +    }
> +
> +    s->base.is_jmp = DISAS_TOO_MANY;
> +    return true;
> +}

I just noticed one final item: for imm == 0, we need

     /* Exit the cpu loop to re-evaluate pending IRQs. */
     s->base.is_jmp = DISAS_UPDATE_EXIT;

like trans_MSR_i_DAIFCLEAR.


r~

