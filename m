Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07789108E1E6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3B0X-0000uP-LX; Thu, 19 Mar 2026 06:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3B0T-0000tu-4G
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:53:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3B0R-0000Yf-IS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:53:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48628ce9ab5so10534725e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773917614; x=1774522414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EgVWOMJC7tDyrxkwGCDBHNk5vLVLJUqeljIhIXgn3Yw=;
 b=kYv3Q02IW3HnEJXNnlId0XIoGh1YSOiVOSuOJNjZQ5WhqBN692Yr7GQI6/BOjoFxUO
 zJtWseN9gLRkWTk0RWwTxZ6EGHby/pwEROwLcj3XNF/pPf6CrIeKDRr4QmEgDNsT/ck6
 gmDIWsqu2w4RgJBykH58RApbYYRexee73MjJ8+6eH99aa+b9tuBkACZSNSNA3hImzDj6
 3p8AE7PkTwWdA5gyvY6DI6nVuW0aZeTg1oWKzFqgB/3tGEYGoFvQr+gcj7Vj5m846ciy
 1ia0NsTNN2kghNAWKIXgTWzy3JHj8ZY/IJv1hfdnHjZJLfq5cgIGduhwyrQmljXrHM4S
 BYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773917614; x=1774522414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EgVWOMJC7tDyrxkwGCDBHNk5vLVLJUqeljIhIXgn3Yw=;
 b=mih9EwOBotHVHM0Zf2LALbHXA0X/fl0VvFVLTpAIIvAUVEXIyqXk36K7fP3IimjGeH
 98L0TClQY1ByN8IO+FMUs2+I4l9z0W+Gh+2hO2XqSqq6uzHiNY51vvQKZ5KvcZzWh5ho
 kKFqWc7uy6bY++qNPwN+PsAO1j/8gThQUf5WohYh3JT1NNNYFSY+fqMk5V04mVKj3rP6
 S27njJ0Oh7vCBxrjYdyJJyr3BrJENyqoAxHGxV6uNfCMJZIh/vMDuqmwFzXsHLCfYtPN
 Ma93uPer3n1iARAqN2YFu5jiAOSIy7stZkDgHmVK06JwEl0dLEFlN6CmYWlh+bfE1Kzt
 H5uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYeR8cT4/Z1bJtU0xiwD7rD3aUkyLTuUYIC95OnJSuB6ZdF5pJZL9g1ZLxo/uRQDMpSxG5UXVU219J@nongnu.org
X-Gm-Message-State: AOJu0YzsPWIV2WWKSy2g+iL+7OIey3FBGOhnPKtRUMTnL6mY02HURHZ8
 e9C4tdBIunQoM0kzYq1SxOT7gov3VCt430nV+ms/SaF13ZiuXY8/Kz0cdaJt+Y+bYLE=
X-Gm-Gg: ATEYQzwUgk6M1x1oJixMXk5qkK7YpzNiHYicT8zSpZx7QLjQAtVavU4ikJdFFeJ7YDb
 hvhwUHgE5zmlAZ8fyY906R/BY71JJsceWHTH28tJJGemtZpUnITY8Vg2e4+IvjFnMoBDa4Glorb
 B8ZtEd6u0zbLuxcJYz4xz78G4Cq4paPZGuyaxj4Tqlcr/gmR2akDdxdc78r4pA2DSd1i9h2klom
 7Ydvl0OsAJG3tb3sBFH+GplKybzWxNObHbImMsgLyoAIalPYqe2SEXt1kUm1wVEhQBa/BFHDIC7
 iuRGm1cODA/bPWDw7LbVQi9/K8spmrh9bT3LqJy3lh+Z8FI2rJD6cglHWd1ooYTMx23MEi79HtF
 mUwaGI7kueW11ET7qmA5PMzxGCzWflzrP/LZM7pV5uRDxvBqTy66AXPiyVz7XJ2e6eDl8r0me+R
 bxq/Fx+qv31M40fpr/XzT0oGXJTV5VLA7kmmd6HOV771maOzvMkspDWXPQpVgNstHTAQ==
X-Received: by 2002:a05:600c:5742:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-486f446d066mr81640605e9.19.1773917613894; 
 Thu, 19 Mar 2026 03:53:33 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8c40ccbsm100353605e9.9.2026.03.19.03.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:53:33 -0700 (PDT)
Message-ID: <d616ab91-3cfc-4a77-83db-23ef16a00d49@linaro.org>
Date: Thu, 19 Mar 2026 11:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 2/2] i386/hyperv: add stubs for synic enablement
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Michale Tokarev <mjt@tls.msk.ru>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20260319101128.116301-1-anisinha@redhat.com>
 <20260319101128.116301-3-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319101128.116301-3-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Ani,

On 19/3/26 11:11, Ani Sinha wrote:
> Add a new call hyperv_enable_synic() that can be called whether or not
> CONFIG_HYPERV is enabled. This way genetic code in i396/kvm.c can call this
> function to enable synic for hyperv. For non-hyperv cases, the stub will
> be a noop.
> 
> Reported-by: Michale Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/kvm/hyperv-stub.c |  5 +++++
>   target/i386/kvm/hyperv.c      |  9 +++++++++
>   target/i386/kvm/hyperv.h      |  1 +
>   target/i386/kvm/kvm.c         | 12 +++++-------
>   4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
> index 5836f53c23..767a4c7e1a 100644
> --- a/target/i386/kvm/hyperv-stub.c
> +++ b/target/i386/kvm/hyperv-stub.c
> @@ -61,3 +61,8 @@ uint64_t hyperv_syndbg_query_options(void)
>   {
>       return 0;
>   }
> +
> +int hyperv_enable_synic(X86CPU *cpu)
> +{
> +    return 0;
> +}
> diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
> index f7a81bd270..bd3c26d02b 100644
> --- a/target/i386/kvm/hyperv.c
> +++ b/target/i386/kvm/hyperv.c
> @@ -24,6 +24,15 @@ int hyperv_x86_synic_add(X86CPU *cpu)
>       return 0;
>   }
>   
> +int hyperv_enable_synic(X86CPU *cpu)
> +{
> +    int ret = 0;
> +    if (!hyperv_is_synic_enabled()) {
> +        ret = hyperv_x86_synic_add(cpu);
> +    }
> +    return ret;
> +}
> +
>   /*
>    * All devices possibly using SynIC have to be reset before calling this to let
>    * them remove their SINT routes first.
> diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
> index e45a4512fe..a393a5d428 100644
> --- a/target/i386/kvm/hyperv.h
> +++ b/target/i386/kvm/hyperv.h
> @@ -23,6 +23,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
>   #endif
>   
>   int hyperv_x86_synic_add(X86CPU *cpu);
> +int hyperv_enable_synic(X86CPU *cpu);
>   void hyperv_x86_synic_reset(X86CPU *cpu);
>   void hyperv_x86_synic_update(X86CPU *cpu);
>   
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a29f757c16..9e352882c8 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1754,13 +1754,11 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>               return ret;
>           }
>   
> -        if (!hyperv_is_synic_enabled()) {
> -            ret = hyperv_x86_synic_add(cpu);
> -            if (ret < 0) {
> -                error_report("failed to create HyperV SynIC: %s",
> -                             strerror(-ret));
> -                return ret;
> -            }
> +        ret = hyperv_enable_synic(cpu);
> +        if (ret < 0) {
> +            error_report("failed to create HyperV SynIC: %s",
> +                         strerror(-ret));
> +            return ret;
>           }
>       }
>   

Why not simply add a hyperv_is_synic_enabled() stub?

