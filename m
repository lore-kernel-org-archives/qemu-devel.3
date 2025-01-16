Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83DCE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 06:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYJjl-0001k3-Aj; Thu, 16 Jan 2025 01:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYJjk-0001jd-3t
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 01:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYJji-0003nq-Gr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 01:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737010333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lKEwV/sdKWrppjVdXOPc4zyU0Q24V4j4YXXoN26YHJg=;
 b=Q44GpOEDAnKxhYFKJDxrdIIIwMy5/L49MUYRidL93VB9S4XpjLzbTUkoFvkPuk8h1RdYxx
 cBPEzjQpNvVsHMGNmaTLpYS04zZjlyL5JzdlxKuzOT+lO3g1C4bP2gJkKoapHdcqZkIvsz
 iW7NptkU1gVJLf/ztG8KlHgcvcKArEg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-6nWHkpxxNz2YRZ3wt8cgzQ-1; Thu, 16 Jan 2025 01:52:10 -0500
X-MC-Unique: 6nWHkpxxNz2YRZ3wt8cgzQ-1
X-Mimecast-MFC-AGG-ID: 6nWHkpxxNz2YRZ3wt8cgzQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43631d8d9c7so2634895e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 22:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737010327; x=1737615127;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKEwV/sdKWrppjVdXOPc4zyU0Q24V4j4YXXoN26YHJg=;
 b=W/BeIq14AGCbPD//v0499RxaYw6Ad4gl6jE17WBEDxcqgsvbXnzlqOuQtHzrq11s3k
 jE9RGORxrcDbbN+YSR44Kf/h0SQZw7YNP1BrWxTtzA5X7QoOeTxlAsqgXA/hsYJZzJfU
 jXX2NMyGdM0YpfId37cOH+0wRg5krS3LF9Lm0Aj/vWT1E0WT4W8lTF6AH8EesMp8qBie
 RYdaGnw4APzvYCocFZlbZBiiRGLfOtNZEJgVMSszHJGFgyRCBbkhKQYD3Pjgv8pY3Q1o
 PYlINiDCeSts3fT8zyh1+LViiCV+nxMAU/4BeGF4WBa6vWCYHIWOT11NtPmKFTl4x6Tq
 uyTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+yWpVgikuT5yu03Df7SZthbrDc6F9HxpG15hal3HLTclWpoPirc77MipM+pV8l+F52BSiURaFMiQB@nongnu.org
X-Gm-Message-State: AOJu0Yz+s3c6V7iFIidCsz3PvOMMT6pi1Cp/Q3arF8Fjm1kiCZ9jyrQB
 OMuACXgcy3vGgZyPrKNH1Hp6w8V0zy4yCJUs71AuiU6iHoAjkMZgeZnweFyeCRLwb6IDiUnszv8
 udCW2wV5QD/ZJXPxzOD5VBXf2JIkpuMzClgMQio1Ztd7dcljx6viI
X-Gm-Gg: ASbGncso0C4daVMg1rVpoHhqeqkdmFuX6w/Cgz30wJM3MHXGX7/8ixbWPcczmKdDTR0
 GKfGtCtBrWT0o/oR9nVQfq3VNdWu7Fr2M1wfteoWivulvco1KA68p2LsYlKvWWh2fPKnL3WVW3h
 Svq7WPsH3pxEepUpUdFsDyR2sS/OfowZDM2C8qNY6cBRYjOcPQ6hIAMmhkxDffgs3TqJSadl3ME
 vDte9isz8XH6FNNtBrav7XS0q/2QYbzAvcSKkhtVthJuEoBkwpYYSX/BdBINwHpPkGwht/vVFjT
 PrEbTkVhJxJ5
X-Received: by 2002:a05:600c:8712:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-437c6b1c468mr46702055e9.8.1737010326956; 
 Wed, 15 Jan 2025 22:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnf/UO24Eiwm6ELQEMlY98e5qVkCQ0bTtfeBlkEbue+DV2s064D9NL6UrEbnwQPhNFqSFBsg==
X-Received: by 2002:a05:600c:8712:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-437c6b1c468mr46701825e9.8.1737010326595; 
 Wed, 15 Jan 2025 22:52:06 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ab449sm48141245e9.10.2025.01.15.22.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 22:52:05 -0800 (PST)
Message-ID: <82e6d8c3-3b5e-4c67-a1a8-8485e618d23e@redhat.com>
Date: Thu, 16 Jan 2025 07:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] hw/arm/virt: Remove deprecated virt-2.6 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20250115171009.19302-1-philmd@linaro.org>
 <20250115171009.19302-2-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115171009.19302-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 15/01/2025 18.09, Philippe Mathieu-Daudé wrote:
> This machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/removed-features.rst |  4 ++++
>   hw/arm/virt.c                   | 12 ------------
>   2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index c6616ce05e5..813988fad4a 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1065,6 +1065,10 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
>   dropping the ``cheetah`` OMAP1 board, because we don't have any
>   test images for it and don't know of anybody who does.
>   
> +Arm ``virt-2.6`` (removed in 10.0)
> +''''''''''''''''''''''''''''''''''
> +This versioned machine has been supported for a period of more than 6 years.

I'd like to suggest that we rather add a generic statement to this file instead:

  https://lore.kernel.org/qemu-devel/20250116064644.65670-1-thuth@redhat.com/

>   linux-user mode CPUs
>   --------------------
>   
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 99e0a68b6c5..3bb8a9c7bd6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3606,15 +3606,3 @@ static void virt_machine_2_7_options(MachineClass *mc)
>       mc->minimum_page_bits = 0;
>   }
>   DEFINE_VIRT_MACHINE(2, 7)
> -
> -static void virt_machine_2_6_options(MachineClass *mc)
> -{
> -    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> -
> -    virt_machine_2_7_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    vmc->disallow_affinity_adjustment = true;
> -    /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
> -    vmc->no_pmu = true;
> -}
> -DEFINE_VIRT_MACHINE(2, 6)

Reviewed-by: Thomas Huth <thuth@redhat.com>


