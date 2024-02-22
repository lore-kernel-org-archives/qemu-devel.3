Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07748C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd3xC-0001WF-G8; Thu, 22 Feb 2024 02:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd3x9-0001VV-Sp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:57:11 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd3x6-0005Sz-Sl
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:57:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41241f64c6bso10867775e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 23:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708588626; x=1709193426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D17irSf/U4JZXEZRBRyY2WFC9+zjHUToxM5yrrVq2TI=;
 b=OCco5PcdYncicnvallLKaByHMIyPRGNRgHIT4xC2z94TEh2TxeyKJnNtueeIHdBxN2
 Y9FwNwG5sUshHUUGB0BPOG47eIrFhcHKUi5K8SSzpgNUrfvWgoVg2DLWa/aKSmncDGAb
 HDx6paNzgxQeGG+T1Q94aqVdkzDkuLIAveIgI2fYs0cVL/PUp63ZghqXyr5d+2U4oILU
 SzZr5lB0HETh3EQ6KyDZKT3ugsNuHUQBm6qVF5L7p/P28FI70m0ujKiu6cahVeVxAttc
 xqImgy2o1Zd/PSHFA8ohscx2fkWy8KhOGIw1Fiac1EadwSkya2VwDsQ+9i9eeqtnIbM0
 NI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708588626; x=1709193426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D17irSf/U4JZXEZRBRyY2WFC9+zjHUToxM5yrrVq2TI=;
 b=vp2OhpgGTPn6CJFayqqhdO5lyDLb4bToIzR4TaGZ2L1WMbjZCXkL9RCys81WcEuco5
 SxedD+10kK8H5GCINR60bAyVtirlS44LJtUiJb9Dw3OzUa480P6YY8WAsbuyhwQ5GB6y
 8jRzrWoFqzXQLzBgwoAtIPSDxk66iFJYhm6DDC9Fti80z+XXqQzfJESuejIVV/mtM5fb
 upxC76BgC6I0dhcdK5XUUbNv5ZbnyU/BSnNDsFO8zSb/+d5u2blfRV8zQ9UH6eLSkkvf
 Xb58urXrj7pFIb8F22Upqj9RZ0o9lPIDiTStfYC7Yq/ZAFegHf1zXfl3QKkueq0SqNOm
 zzHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJO9Tn8yW+bvNkF8JEsW4zG6d0VPwdu8dN5zEmxngGzydYP9tI0Mzs1lCxG+VD2Hjer+MwknC8T9ZCVTpsihDn13cmDJI=
X-Gm-Message-State: AOJu0YwvACMWGagjevYWaNuWg7mAdFCBbvN52RlPP7yrJXROLVWv/Qop
 D26tGXgqkCCvJhXe2/yFuOhswEd067wI99v2AB5aIE6UNbLC9wONXnNPZPAoYYg=
X-Google-Smtp-Source: AGHT+IEAbOe7u/xS4q8BIY5U9vHOZ0HUbyrNaE+0F6isHlB3wNZ9niYav9Xy2N1k0zMAmNIFZf4/7w==
X-Received: by 2002:a05:600c:1988:b0:412:6dd7:1d44 with SMTP id
 t8-20020a05600c198800b004126dd71d44mr5327431wmq.17.1708588626458; 
 Wed, 21 Feb 2024 23:57:06 -0800 (PST)
Received: from [192.168.184.175] (41.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.41]) by smtp.gmail.com with ESMTPSA id
 g17-20020a05600c4ed100b0040ecdd672fasm21184179wmq.13.2024.02.21.23.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 23:57:05 -0800 (PST)
Message-ID: <a1f44a85-b13e-4ab8-aea6-94200637c836@linaro.org>
Date: Thu, 22 Feb 2024 08:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/Kconfig: Fix GIC settings when using
 "--without-default-devices"
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240221110059.152665-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240221110059.152665-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 21/2/24 12:00, Thomas Huth wrote:
> When using "--without-default-devices", the ARM_GICV3_TCG and ARM_GIC_KVM
> settings currently get disabled, though the arm virt machine is only of
> very limited use in that case. This also causes the migration-test to
> fail in such builds. Let's make sure that we always keep the GIC switches
> enabled in the --without-default-devices builds, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/intc/Kconfig | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 97d550b06b..2b5b2d2301 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -12,10 +12,6 @@ config IOAPIC
>       bool
>       select I8259
>   
> -config ARM_GIC
> -    bool
> -    select MSI_NONBROKEN
> -
>   config OPENPIC
>       bool
>       select MSI_NONBROKEN
> @@ -25,14 +21,18 @@ config APIC
>       select MSI_NONBROKEN
>       select I8259
>   
> +config ARM_GIC
> +    bool
> +    select ARM_GICV3_TCG if TCG
> +    select ARM_GIC_KVM if KVM

This is odd, we usually 'select' dependencies.

> +    select MSI_NONBROKEN
> +
>   config ARM_GICV3_TCG
>       bool
> -    default y

Don't we want instead:

        default y if TCG

>       depends on ARM_GIC && TCG
>   
>   config ARM_GIC_KVM
>       bool
> -    default y

and:

        default y if KVM

?

>       depends on ARM_GIC && KVM
>   
>   config XICS


