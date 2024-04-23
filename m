Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB69EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 20:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzMvG-0007Wq-99; Tue, 23 Apr 2024 16:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzMv9-0007W2-2A
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 16:39:19 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzMv7-0001ak-80
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 16:39:18 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so626736866b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713904755; x=1714509555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=whJX+F+fVuXoaTtj61On/mh60c/Mc5Ka7TYyclrYv2w=;
 b=AI1Z61+aawQJYrt0qCSKThGPDcTUOk2aievuEmzBR4wRngi0XNX7JB+Sn79APpaW1I
 TJVS6dA32z42ZjMn5JKiMmdXnbm6DFXDEpclOASw1bJU8ydyR8pTa/OaQOVHT1nMPd7s
 c4UFZ6ssMKkzsGhCX9uuFSVjbtq8kIGXCNCrGi2H1e0BLUosPqZsGc3YJeVt7K3+g7PC
 hgIZ5qjmqfc2kTV/ztHjWcYU+ODG+fA3RBqwDgxJ6jNv3JMt6XVoL5+hifG8sS9rmfOn
 kmWlqj+mC7pW/zbmIavVv6zZZarTGmjtkZ2q0mwllOO0wM3xpsZxSorMh+4CcnFXxwDn
 QC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713904755; x=1714509555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=whJX+F+fVuXoaTtj61On/mh60c/Mc5Ka7TYyclrYv2w=;
 b=HzpZgueJCta49yRBfNlqHPbDVmS/CH5iSrxXtTTNqO7aycRzFqVcGhQNNhXR+wzxAj
 a5leDveyXDbuFoevNzkdhD6j9SJnjUy+5FC6mYOcASBPyHdg5y9Fc5BqVysULjpPr3yC
 OUkZg61fpmVQSg7LsN2cbXU68SFc21NIqllNyAf+gEsb5ui1vzJyCBfqYXQu1y+74qpa
 T4IaW2+0w1SljeMEEpUCRvpCnaKqfRnbDI3zpMcxYh4Vfc7r5LsTiXutQwEce0hQ1bcD
 6DryVNp7yJrNvV8aYSjhjAUxMNpYza8B2bhOXZlxHyP1M+p5bI6cA5AEKdD3+vUFaumn
 bdWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWowAGE9H5ZF1lATtRmYeSjCB16aer74CTWv+z/bKGj6o6l+UZYLffLKtYx2agAPB034UQGi9dNPYYnqytGNzV5sBVWFEc=
X-Gm-Message-State: AOJu0Yy8h8j4+2zaaGIXTmXLsZm/Hx6veudZgFJKsXeFXDcseERPih5p
 hgRJ/k3X7QC+pe/1/JxogklzGNp76qsIpzTfyEHlx2zuD1mhgMc81dU79gJKiUE=
X-Google-Smtp-Source: AGHT+IETszKhsJCj0WCs9cvIyP1W3qOZmWAo+w1Vyvf8hCiPFXNzERUVYTPmynY7ud5X7TBXadxg7Q==
X-Received: by 2002:a17:906:34c6:b0:a55:b5ba:8104 with SMTP id
 h6-20020a17090634c600b00a55b5ba8104mr258616ejb.27.1713904755487; 
 Tue, 23 Apr 2024 13:39:15 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-107.dsl.sta.abo.bbox.fr.
 [176.184.5.107]) by smtp.gmail.com with ESMTPSA id
 ky17-20020a170907779100b00a55926df215sm5224375ejc.72.2024.04.23.13.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 13:39:14 -0700 (PDT)
Message-ID: <dae5c53a-0f1d-484d-b62d-3c827f6fb8a1@linaro.org>
Date: Tue, 23 Apr 2024 22:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: kvm: allow building without any board
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
References: <20240423191728.52535-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423191728.52535-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 23/4/24 21:17, Paolo Bonzini wrote:
> KVM code might have to call functions on the PCIDevice that is
> passed to kvm_arch_fixup_msi_route().  This fails in the case
> where --without-default-devices is used and no board is
> configured.  While this is not really a useful configuration,
> and therefore setting up stubs for CONFIG_PCI is overkill,
> failing the build is impolite.  Just include the PCI
> subsystem if kvm_arch_fixup_msi_route() requires it, as
> is the case for ARM and x86.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/arm/Kconfig  | 2 ++
>   target/i386/Kconfig | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/target/arm/Kconfig b/target/arm/Kconfig
> index bf57d739cd1..5847c5a74a7 100644
> --- a/target/arm/Kconfig
> +++ b/target/arm/Kconfig
> @@ -9,3 +9,5 @@ config ARM
>   config AARCH64
>       bool
>       select ARM
> +    # kvm_arch_fixup_msi_route() needs to access PCIDevice
> +    select PCI if KVM

Kind of funny :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


