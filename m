Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8179EC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeOA-0006sR-En; Tue, 16 Jul 2024 05:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTeNy-00067J-H3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:22:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTeNw-0004GP-DT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:22:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4267345e746so35749835e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721121731; x=1721726531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UqGtqsf1B4cToMHFdDFjCfP7fcLn3bLanhmec2hX5KY=;
 b=OjEhtDsz4qfo9AEBqCni3TVIIIVcliUkQQHM6XU/tbiPSODoOALoOdJzGumbaApKaL
 WcZZITLnDUHPs9aOD8vXufkBE6udsw0WUs4aDwHmTuMfd4+f4DODrIq2IaMmZArmziNO
 ajmO+1ZxB1eZ4avQxZcpYx/0dlug8SxjR7x4hA+vau77pI+A4yZk9PnTI+Xj+y7UgcVj
 OI5kxPquRJ4E+z4Ip1FGaHUzmDhQI0KY+DZ7AAVqqz+dfTXbwyb64PPiC8r/L4MJMcXH
 0HOqElgkxc8ljwXCXq+1GHIkBRsfld0JZTgENNnH6k7amZl6FVuvaY31uunETWFUfm1o
 bN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721121731; x=1721726531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UqGtqsf1B4cToMHFdDFjCfP7fcLn3bLanhmec2hX5KY=;
 b=TYSzx1INZgdJL3KrVa9unmhRqqbDjXRI7ROCwCD92QUsD56ablXqCUjtelxtqoNc4h
 1FvXltHNwPnN5sI3VsawEQ796V+/f+KeaAOrKGVIa8mty87dRW0aE8QylAfcjF717xFR
 zqCmBQW/4kbmCYMNj+o9z7Vp5f+dgt2UjB3IxHYpma240/yw5s3voCq4sZoC9R17Xls0
 O329QPOgxS2MQbZ0YafACcwY3pR+8K6r59ZU6SBYQUqYxjnv9m92yS5bIpBDv+xRSU4S
 uhnbkZQSZJUjRA68pYvTagEa2ZDPBsAx50QxHV7PYMzOpvHW+ENXUjzm7NJ/Y8onU2Gl
 pkDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhRn/wZcIURYLk9o5H2Oe0bqFNmEqDAtsM9tRb35bHHhH/cMT3kF1sDI6Y4dBytfmHeC4mtgnkRsbScKMixvmJEwM/yr8=
X-Gm-Message-State: AOJu0Yzq3el2hk5oc+fv/Ezpi13u0E82h21XiOk9F5PI2f4wpG9rYWca
 NFwafPv1M4P/nNbmfV+YYFIhY7HpcYluu6CCjGY9InpP/xhMylbtjE3aCsN76ks=
X-Google-Smtp-Source: AGHT+IEPy1rnh7HUbBX5o5w/iN0Pcj4O3W+gelE8CSpmBmGVsbZ6S2/qCBmZfPJ8vebsc6aHJXgXsw==
X-Received: by 2002:a05:600c:4e91:b0:426:6ad8:3e3c with SMTP id
 5b1f17b1804b1-427ba69694fmr10792965e9.17.1721121730865; 
 Tue, 16 Jul 2024 02:22:10 -0700 (PDT)
Received: from [192.168.86.175] (233.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db0481fsm8416913f8f.106.2024.07.16.02.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:22:10 -0700 (PDT)
Message-ID: <3ef05b2b-06da-40ca-9344-2d5a8cdd6dba@linaro.org>
Date: Tue, 16 Jul 2024 11:22:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] target/arm/kvm: Report PMU unavailability
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Wei Huang <wei@redhat.com>, Andrew Jones <ajones@ventanamicro.com>
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-5-f3e3e4b2d3d5@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240716-pmu-v2-5-f3e3e4b2d3d5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 16/7/24 10:28, Akihiko Odaki wrote:
> target/arm/kvm.c checked PMU availability but claimed PMU is
> available even if it is not. In fact, Asahi Linux supports KVM but lacks
> PMU support. Only advertise PMU availability only when it is really
> available.
> 
> Fixes: dc40d45ebd8e ("target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport")

Commit dc40d45ebd8e only moves the code around. I suppose you meant:

Fixes: 929e754d5a ("arm: Add an option to turn on/off vPMU support")

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/arm/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 70f79eda33cd..b20a35052f41 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       if (kvm_arm_pmu_supported()) {
>           init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>           pmu_supported = true;
> +        features |= 1ULL << ARM_FEATURE_PMU;
>       }
>   
>       if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
> @@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       features |= 1ULL << ARM_FEATURE_V8;
>       features |= 1ULL << ARM_FEATURE_NEON;
>       features |= 1ULL << ARM_FEATURE_AARCH64;
> -    features |= 1ULL << ARM_FEATURE_PMU;
>       features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>   
>       ahcf->features = features;
> 


