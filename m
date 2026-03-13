Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1B7107BCCD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15YQ-0004HL-J0; Fri, 13 Mar 2026 12:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YO-00046Z-9M
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:40:00 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YM-0002F3-Sj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:40:00 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c737d3a51bdso1027062a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419997; x=1774024797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gyjvs03GKoSCoIDRVZY7rL6iHm2kdkVAnNK3ACrr7Wc=;
 b=lQ7teDApBPO7K3028ywg6U1Ektvo4Krkmqw5JT0dh5vPYXPh7rK4NaFfcSF1D1xddG
 nGudFoOr/1DHUXoCxcJkxhRRbxE8lGlPzXGhRw9u4FBVAeUMWbBpJF/3wNbRWgshchtw
 MvQgPDVdwugtL49q1AnoyDEm4WF3oE5QNy3jsdtGvFdgIzpuIoLqWAGyUX6d7VATPoJV
 +J8G9KKz89gyb5oXZi9UqNYF5FIjjnUx+i7jH6GeppWxFIqfYINZwuAje4FRb8qvfs/K
 SEiDP62t31TDxhuH/DbY15aJ2Nb7msbhj7TN5Ec9NSm9hEmppmHjoGyB05BOp4FpX5/7
 nk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419997; x=1774024797;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gyjvs03GKoSCoIDRVZY7rL6iHm2kdkVAnNK3ACrr7Wc=;
 b=jDAfEN7chfrdi6P1EWna/xak3Pn6aWZomq25BXHJT6fXrDdUkXpt5/qZHgFswzFt+P
 F4FIzEO/XiORrMwwJOJeIACyILHZ3FmFPDxrW1n3+27xzRemtu77MWzuBuSRW90QMv2y
 2bL5hU4dNuyXUoZpGpzV4FzOQcCkr+T3rMgEzgpdKOMQeTH3VVUO4O4WRt5Gt/qfydlZ
 o+Qks8g2JedFyBYWzalsrbICdkHSg1hsOkq4RRUQq5QEmghlYNP/zZ64ke11SdMxbngv
 IoGO6K3AhGOJ8p2Q2mUziyCq51n255V4lWSAWhccdt0jeY2S+wgpqcnDljDXxdct9rkU
 M6AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWX21+3FyABt9s7yZSp3NSBvhNUBOzNzDvT0uyAfzBgbGOGag6kD7OBxuaZz8NeFR/kSBti24GLGyc@nongnu.org
X-Gm-Message-State: AOJu0Yx+9o3M/e2AbgRgwnAfMrl7T5fa04SIjfLc+NFzn0x4QA4YsFhA
 SNnEfZb/FK+rKCkLya9ev7uxY0MMj51NUxzPaxDuRajxqGQfflG19AP8juIcRIUPn5o=
X-Gm-Gg: ATEYQzw+9wamZnlorNcBqWR0CPEiORjlYoxsCmg+HT/sCmbAc0eWKyr0dlmZl8Bml8b
 yW+McHDNLueH+TgVoheA5G1/SE8MWi3Kuo3hy6AmI5pvM6neb9lJ7LKNUBn2YEgv2MLrLnILuJk
 CilXSpMANt7HputfyMsLl410N5Jg7CLKyYedo9AdmECXFOnF4jj+O/TvAOLa3/97ZIRVPNp8Ok7
 hVD516U2tFbVTboScLEaZT+HHtI8wuKDNRRWIlXEdR3MvaRdTvaeY23jf3lJrjk4Bw7JzJLrgji
 Fca73LoN66L/0G4AgjIUuRpOv5E7IYLh1XmYRJn4fL87z/n3YL/pKQ+sPu0TszXY8u3ycCfFykl
 LLpPi4nD5MCCa+eK+bSbLdkmzv3UGWkzGjaHRPFoGutuCRL/sUs0U/j205eVTutrl48gSqgr30Z
 Zcrwvz5m1/YKFP86eXyQShHUb0JdxnqgaoIy9KFBDVyxX/CenxQ/1khh8vK1KbFNlLCQ1M
X-Received: by 2002:a17:902:d488:b0:2ae:bd12:f82b with SMTP id
 d9443c01a7336-2aecaaf5484mr38040695ad.47.1773419997249; 
 Fri, 13 Mar 2026 09:39:57 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece627683sm25163655ad.32.2026.03.13.09.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:39:56 -0700 (PDT)
Message-ID: <57103cbe-535f-4b21-ab88-06b0c6459681@linaro.org>
Date: Fri, 13 Mar 2026 09:39:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/38] hw/ppc: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-30-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-30-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ppc/pnv.h          | 2 +-
>   include/hw/ppc/spapr_fadump.h | 2 +-
>   hw/ppc/mpc8544_guts.c         | 2 +-
>   hw/ppc/mpc8544ds.c            | 2 +-
>   hw/ppc/ppc440_uc.c            | 2 +-
>   hw/ppc/ppc4xx_devs.c          | 2 +-
>   hw/ppc/ppc_booke.c            | 2 +-
>   hw/ppc/prep_systemio.c        | 2 +-
>   hw/ppc/spapr_vhyp_mmu.c       | 2 +-
>   hw/ppc/virtex_ml507.c         | 2 +-
>   10 files changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

