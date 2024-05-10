Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1151C25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5IXs-000768-Jp; Fri, 10 May 2024 01:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5IXq-00075o-Co
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5IXo-00031R-RC
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715317903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vxp0X1wRPslmz/s68sC9jIdBwFe7VL29SaEk5BnEjUs=;
 b=CDbWlWDLURaojn54QwXvll4GjhJmLy/dKZivZPO/YVCT/X0cdQjf52QwrGHk4/+0XEsOOt
 ygauREjRQ+6OA0qazFJKUuqYBJuGU2Pe/7xByIPwWfgmQZehG9smvS+P9s48L7kp6HfTzb
 tcUxJw4zM0F4uGq99I0/Oekj4J+9MrU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-AJeNZpByPueltsXFtCv-Zg-1; Fri, 10 May 2024 01:11:38 -0400
X-MC-Unique: AJeNZpByPueltsXFtCv-Zg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso82437066b.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 22:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715317897; x=1715922697;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vxp0X1wRPslmz/s68sC9jIdBwFe7VL29SaEk5BnEjUs=;
 b=SAiJe8BrNGjnD6R9dlh/4eB8rnsO06C7H+Jkl84y1bJyBq42HcmRgkzmU5pOQTdIhI
 iuyc8HygP3X9w59o2AvmYjzMpUpCiLBLiSER//GtHrkSnpOtZgnfMGYOU2qcWkqCe1hE
 VdZYM1th3h7jh+ae+6HnaqR1pzbYhK1spNrF1qCABA31Pf4ncRhDmiZY/RD3asGCa30J
 x74v1/1m+pyJedtDWBCunIaQe9n3OC8jA/xZyDenAVN2XEFKvT0gsA9OXjD1yqJi/K1D
 HlBDTP+JogLFs/i9e5s5iQL4Hg0jHs0CM+GPTI5cIPGt9o6FrL4rsO2w9DfGj2Ezl22j
 OB9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6b1i+jv86RjuuQbDpBAdvm49dtY657wPU6PrGi0GXBT7CF0GxHj0pspYR79sYCdw44RU17QpZaTF7hhxSgC7SWJNxSf4=
X-Gm-Message-State: AOJu0Yw0EikYrC0lczEEtywF5Wij58RiKD+ObadqHA+tbtMfS97m5736
 JBQsK3lN54wGtGITMyE5d8STi7EAeR5lXx5VkjMsvohWqAi9D1UBACNQmEqW7A1nq66ZXqr0djW
 H4Twv4UZhygG0IIiQI6zhp1RvAuhdtX4DkdWXV3tqdqM3QNm31sRSTFXd4RBe
X-Received: by 2002:a17:907:3208:b0:a59:ad15:6133 with SMTP id
 a640c23a62f3a-a5a2d6759d9mr119053766b.71.1715317897232; 
 Thu, 09 May 2024 22:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHooqitR10gjAu574kbyHkF4BODW1eIR7EWEch3eCckG1vMHdEh2Har2IOK3GMyKsKtHJVVLg==
X-Received: by 2002:a17:907:3208:b0:a59:ad15:6133 with SMTP id
 a640c23a62f3a-a5a2d6759d9mr119052166b.71.1715317896923; 
 Thu, 09 May 2024 22:11:36 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17922159sm144700066b.97.2024.05.09.22.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 22:11:36 -0700 (PDT)
Message-ID: <7c3cb96c-61d6-458a-bde4-8c876d822ca0@redhat.com>
Date: Fri, 10 May 2024 07:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] s390x: select correct components for no-board build
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-5-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240509170044.190795-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/05/2024 19.00, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 ++--
>   target/s390x/Kconfig       | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 13afd0df1f0..f8502905203 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -650,7 +650,7 @@ build-tci:
>   # Check our reduced build configurations
>   # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
>   #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
> -# does not build without boards: i386, s390x, x86_64
> +# does not build without boards: i386, x86_64
>   build-without-defaults:
>     extends: .native_build_job_template
>     needs:
> @@ -666,7 +666,7 @@ build-without-defaults:
>         --disable-strip
>       TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
>         mips-softmmu mips64-softmmu mipsel-softmmu
> -      sh4-softmmu sh4eb-softmmu sparc-softmmu
> +      s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
>         sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
>         hexagon-linux-user i386-linux-user s390x-linux-user
>       MAKE_CHECK_ARGS: check
> diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
> index 72da48136c6..d886be48b47 100644
> --- a/target/s390x/Kconfig
> +++ b/target/s390x/Kconfig
> @@ -1,2 +1,4 @@
>   config S390X
>       bool
> +    select PCI
> +    select S390_FLIC

Reviewed-by: Thomas Huth <thuth@redhat.com>


