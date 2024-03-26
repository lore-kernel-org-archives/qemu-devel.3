Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E16C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 19:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpC9E-00068f-Dn; Tue, 26 Mar 2024 15:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpC9A-00065h-00
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:07:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpC97-0000T6-4e
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:07:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ea9a60f7f5so2725247b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711480059; x=1712084859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fHefUxRivmpnUzJBpMin1dHCtvPbntsj8Tn0rnbDfUM=;
 b=brPAwTf6teqNApALWQfUjh9LwoLfH4he0Z6y6VSSZ//lEr1A6oRRselnwa0ZaOxHqz
 0c8U3j0SFz/23wRuXy/fPXmhoLN5vt/Fm2WUv/V9t5iTANhmy3lTPCfN527M1GQk62xS
 rdvp387C2FrRrlpV23KIdFUyKjx+CyZ86BIYyGP4ff7TX77+ztv0nkV/yM4kjONXlEte
 BSlT8xjhEPFbEaDl4+XwXz4L44aTdCDI+ee0OeTdO5ZKcMCWqCn43McTj8he7xFU74W1
 187WGPOrYOEcQ4oAJNJp8O7UIDfKuutq/1FRsOm0hPjv6KDkjLHFipA9WKVqVYMocWMT
 T9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711480059; x=1712084859;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHefUxRivmpnUzJBpMin1dHCtvPbntsj8Tn0rnbDfUM=;
 b=VJOWj6Mi21sI8I9QebpCHjnsZ9twhgxM7lABm6MVlbwbOYOlbuloX4T3mDt43A3wVO
 09y9EiC7Vlbr+qUgARhHcDoCibSlWEInNiSczifHY3ObU279u9Fizh5RKd/EX9Liq5Ot
 ZIff4WgsUEkEJ86u18z5/F7K5oGEz1dTU9/6W4T5QY0FXMGQPzBmu8fVG5DXRUvSZg3c
 9qcCAvEs+zKojKiMCY/0v6PeXB/63yQ80TvHXx/kjPyDglgwLNRevv1VWncM3hnc+HkM
 W8t9ULGz+LW7x8WIoQqE+Gd2dOt1u0fKxNOFkE3LAHFPNiqg54n7yoVwbgVLq2Csh8Bf
 /eFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjtodVBms/5yxOqBbEul9vCrPYu0hA6TYmgPnyzTTzQeF/qu1YrA4gEFDzXAyIu+Bg6LOpQP2Me0W+ha4ecD9w5135Nf0=
X-Gm-Message-State: AOJu0Ywj1iECtMjE4eAiQJYRutVWlGxNBJ5EweXzK/x4Gvily3/WW3dt
 aoQw8s8YC95z5Hwcr8LVYjCkLdad1pZGMbrYsM3jQ7sG/Lq8+uDPpxXyOjayb+A=
X-Google-Smtp-Source: AGHT+IEFnREkcA9VWf/GqEZ/GUgKG2lFVA3jqtoXBcJEhaCrbEyVlQUqbucOdkh/6lvsAA1ORSn8yw==
X-Received: by 2002:a17:902:f542:b0:1e0:511a:ebab with SMTP id
 h2-20020a170902f54200b001e0511aebabmr700444plf.43.1711480059526; 
 Tue, 26 Mar 2024 12:07:39 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p2-20020a170902780200b001deeac592absm7329747pll.180.2024.03.26.12.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 12:07:38 -0700 (PDT)
Message-ID: <c05943e5-24de-4059-b9da-5488d4013b0d@linaro.org>
Date: Tue, 26 Mar 2024 09:07:35 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 4/5] target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is
 supported
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, miguel.luis@oracle.com,
 peter.maydell@linaro.org, maz@kernel.org, gkulkarni@amperecomputing.com,
 gankulkarni@os.amperecomputing.com
References: <20240326182345.326758-1-eric.auger@redhat.com>
 <20240326182345.326758-5-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240326182345.326758-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/26/24 08:22, Eric Auger wrote:
> From: Haibo Xu<haibo.xu@linaro.org>
> 
> KVM_CAP_ARM_EL2 must be supported by the cpu to enable ARM_FEATURE_EL2.
> In case the host does support NV, expose the feature.
> 
> Signed-off-by: Haibo Xu<haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis<miguel.luis@oracle.com>
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> 
> ---
> v2 -> v3:
> - check pmu->has_el2 on kvm_arch_init_vcpu() when setting
>    KVM_ARM_VCPU_HAS_EL2 feature (Peter)
> 
> v1 -> v2:
> - remove isar_feature_aa64_aa32_el2 modif in target/arm/cpu.h
>    [Richard] and use el2_supported in kvm_arch_init_vcpu
> ---
>   target/arm/kvm.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

