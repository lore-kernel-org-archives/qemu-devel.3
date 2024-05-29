Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6C5C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCDPr-0008Er-TQ; Wed, 29 May 2024 03:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCDPl-0008ES-4p
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCDPb-0003kj-R9
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716966470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XBqjefz8LaYrHiYPXOrPEzPq73XyjiyDYdu+8QLT3H4=;
 b=MJG6hB48YvkT68oCMuJipOVL0q6eAi+QgrCkjAHs+NrKw8pBQSS9a3EGMxA7GHEWrqMn/i
 2FJn6FFyTJ+/q7u3v4wweZVpgz8C18isGNJnUo+ZNLB78ch8DIrFszSPcschjcLRkmziIj
 V+Kzc22pdfOd5IV0y+5d2eJhViNcbPY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-FeiUNciMMBSI2lqI4SioRg-1; Wed, 29 May 2024 03:07:48 -0400
X-MC-Unique: FeiUNciMMBSI2lqI4SioRg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a635b551919so40641066b.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 00:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716966467; x=1717571267;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBqjefz8LaYrHiYPXOrPEzPq73XyjiyDYdu+8QLT3H4=;
 b=wI0G2STj39L0lxy4eparN2+l7jk6Oa96r7Dbrnm/Z83vcWH3R+wb3S1XiIdh7LxkTW
 j0t7zZJHCXcx5bRAEWEIrP+TCSqiFT5B7V7dDTwzdl72CS4uI+1RsYoKZx/QdLexbCHh
 GjgDqXpFl899ifRnGsaQyWIbUQ4OktCcZi65RK5HnNP5WPju5JOGI46ZPbA5aMiA21K1
 t77QbJSSKRItTLX66+fJIRRibJF1sXsAYDcxy1kyc4tmAag8dn8Zq+aX4WMNqvTpyh42
 UdtFsb+H7cA4kuY76I8yBaX1q6u/3cMVlhgq2iTV7jJpv5NnAuP6aeE/JQDGTTQbjDdC
 be9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY9MJIfwkbbdLCOGF+CfeuEYfACfDsL9yA8jkDp9/D9JGFcktvQuPbnskQlK7F8uqENeFWdbH0IHlNP/YsU3EqnZ1McxE=
X-Gm-Message-State: AOJu0YzEHa2VmP5PPYDn2QAEmy3ewH/83/svYhgZkqE2b7JWZa/4Rjm9
 rP/knF/NMccE6uHAuZ1Q8G76c8NpA+GjTQytxQNIInM+dGJ3RtETXM5y3mI2/hpDZ9rXYyoveUi
 6uxEy6gj9WsSaHhK1iQOqmNF99mI8yIqanp0siFFzERZBRph+DyWg
X-Received: by 2002:a17:906:eb4a:b0:a63:4e00:aa39 with SMTP id
 a640c23a62f3a-a634e00aabfmr196495766b.24.1716966467226; 
 Wed, 29 May 2024 00:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzcKYUV8CPeIkYaWzTxqFaaysF2HZ0QzuU3j3d51Vz/BplCgOLaA1QIQOpWMk+PmfEiT7M8g==
X-Received: by 2002:a17:906:eb4a:b0:a63:4e00:aa39 with SMTP id
 a640c23a62f3a-a634e00aabfmr196493766b.24.1716966466822; 
 Wed, 29 May 2024 00:07:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.155.52])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a626cc8adf3sm686211566b.152.2024.05.29.00.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 00:07:46 -0700 (PDT)
Message-ID: <c5e14ee6-1ea7-4deb-be37-8d6b4de9f388@redhat.com>
Date: Wed, 29 May 2024 09:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Issue #2294 | Machine microvm doesn't run under Xen accel
 for x86_64
To: Will Gyda <vilhelmgyda@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, richard.henderson@linaro.org, 
 eduardo@habkost.net
References: <20240528102339.106257-1-vilhelmgyda@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240528102339.106257-1-vilhelmgyda@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/28/24 12:23, Will Gyda wrote:
> Issue #2294: Machine microvm doesn't run under Xen accel for qemu-system-x86_64.
> Solution: microvm is now not build if only Xen is available.

This does not fix the issue that microvm does not start with a Xen 
accelerator.  I think it would be better to try and make it work instead.

Paolo

> Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
> 
> ---
>   configs/devices/i386-softmmu/default.mak | 2 +-
>   hw/i386/Kconfig                          | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
> index 598c6646df..6a73aee7dd 100644
> --- a/configs/devices/i386-softmmu/default.mak
> +++ b/configs/devices/i386-softmmu/default.mak
> @@ -29,4 +29,4 @@
>   CONFIG_ISAPC=y
>   CONFIG_I440FX=y
>   CONFIG_Q35=y
> -CONFIG_MICROVM=y
> +#CONFIG_MICROVM=n
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index a6ee052f9a..f8ec8ebd7a 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -108,6 +108,8 @@ config Q35
>   
>   config MICROVM
>       bool
> +    default y
> +    depends on KVM || WHPX || NVMM || HVF
>       select SERIAL_ISA # for serial_hds_isa_init()
>       select ISA_BUS
>       select APIC


