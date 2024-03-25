Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5FAC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roflN-0003Fw-Pl; Mon, 25 Mar 2024 04:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1roflL-0003FL-C0
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:32:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1roflJ-00047i-Ly
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:32:59 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33edbc5932bso2918659f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 01:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711355575; x=1711960375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpMbQT3sbLt+EU7UEMsiip1EqmGzp9t5v+GQLOLlT7c=;
 b=V8W4+lSHhhZjcc5Rlc655Z7qAykI4EXRtUezDaT9zZKVYVv1PApUL+T6v5GiTrHibU
 9k6lsUbvCfoAm/jz32gkVd217BvkrpPWXqLLljl/xXI8CcIuDdMnViTKR6GL/7sVCfb3
 HSmszOJ1OCcGHUpvkHV682h7s4Owql8nwTwui6tTR4MR3WfY97d/SMtFE3/Bue5/yXPx
 zEo5T4ofD1NPa8/f/JJ+eox9V54Z6U5ye1oox8DhffATEZiDmA0iQ6QkcOFQ8FkVoOkJ
 4NORPJPUEY3iCUipKW5s32G4ZCyrJL+vY5Nbbdb5Uuywy3D+vdqInAaULANKFQ5P9Bcu
 jWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711355575; x=1711960375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpMbQT3sbLt+EU7UEMsiip1EqmGzp9t5v+GQLOLlT7c=;
 b=gRv4StSFNHQoyVXMSJ7j9YfBTz6uDgNX6yADaZZTIbtybbsgj9X1mbu9Ivavfz+XJq
 0GfsL9D5DgR8XkrclHUpf5itNYt3tVvyP5Mr44zjhH1hc3wW/CwEZqgrb5QHbF6mT5qZ
 o8mx6sBIFWjo1r8nW/D50TY8pGAmj3Dxu12eLe1X8Gc0qtIgV9/obmJ2D0pw1Bk/p1kT
 zZF+/hadYSpDhCzv5qKjep9mTXsHZBS9hohFelOtyXJ7MsIKivDvlZJDbPdnppt0Clkm
 HKAeK5Y9qpS1bYzwz0v5Olvg0PRQ87sx+vHoz0VH03ILncTZ/+lmCY+u8c9B1IS5mEhB
 ak/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnlPJijGWk7aVUVwtLAB9FlijJmqCbji89SdDipTOjsI6EItvZMB8aD9OWd9npkBp7OepPuRWy13J01N5HxyPsHBycX9w=
X-Gm-Message-State: AOJu0YwHxXS916SBXvimTjTHGdVsaxtOMrXHUCi6h0YnAJHSglKUa3Op
 6sTtDvS3s0feLon3hbFtznmYp+QzQ27yIFwBi7Vw4SRWCZPqhaiyFr1utXd+cpc=
X-Google-Smtp-Source: AGHT+IFL0RMwbq5vbWcbpgLAAJLm2kJFQTvFVsJDIuP3BxwsBNrn/tveZN6l42kSQTpTuZ2+76a1Jg==
X-Received: by 2002:adf:a38b:0:b0:341:8efd:e206 with SMTP id
 l11-20020adfa38b000000b003418efde206mr3444401wrb.38.1711355575100; 
 Mon, 25 Mar 2024 01:32:55 -0700 (PDT)
Received: from [192.168.209.175] (237.red-88-29-182.dynamicip.rima-tde.net.
 [88.29.182.237]) by smtp.gmail.com with ESMTPSA id
 ck8-20020a5d5e88000000b00341ba91c1f5sm7622718wrb.102.2024.03.25.01.32.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 01:32:54 -0700 (PDT)
Message-ID: <4f6143f9-5322-4947-aa03-0f3fe87c868f@linaro.org>
Date: Mon, 25 Mar 2024 09:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] confidential guest support: Add kvm_init() and
 kvm_reset() in class
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-4-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322181116.1228416-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Xiaoyao,

On 22/3/24 19:10, Paolo Bonzini wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Different confidential VMs in different architectures all have the same
> needs to do their specific initialization (and maybe resetting) stuffs
> with KVM. Currently each of them exposes individual *_kvm_init()
> functions and let machine code or kvm code to call it.
> 
> To facilitate the introduction of confidential guest technology from
> different x86 vendors, add two virtual functions, kvm_init() and kvm_reset()
> in ConfidentialGuestSupportClass, and expose two helpers functions for
> invodking them.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Message-Id: <20240229060038.606591-1-xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/exec/confidential-guest-support.h | 34 ++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
> index ba2dd4b5dfc..e5b188cffbf 100644
> --- a/include/exec/confidential-guest-support.h
> +++ b/include/exec/confidential-guest-support.h
> @@ -23,7 +23,10 @@
>   #include "qom/object.h"
>   
>   #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
> -OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
> +OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
> +                    ConfidentialGuestSupportClass,
> +                    CONFIDENTIAL_GUEST_SUPPORT)
> +
>   
>   struct ConfidentialGuestSupport {
>       Object parent;
> @@ -55,8 +58,37 @@ struct ConfidentialGuestSupport {
>   
>   typedef struct ConfidentialGuestSupportClass {
>       ObjectClass parent;
> +
> +    int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
> +    int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);

Can we get a docstring indicating what these functions return?
Looking at the next patch, the KVM specific return value doesn't
seem used, so can we return a boolean instead?

>   } ConfidentialGuestSupportClass;

I suppose it will be easy enough to refactor for future other
HW accelerators.

Regards,

Phil.

