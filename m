Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3077CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 05:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDz8e-0002UC-E9; Wed, 29 Oct 2025 01:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDz8b-0002TT-Vt
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 01:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDz8U-0004OG-I6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 01:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761717255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UX50O7T+6CxtK81aShDu/YtHqTLIzDtu/vk5nKaFd/E=;
 b=dgHPAzNai45aTYKzFaeKOcn3YlFxmyhZ56dPz5Pgoaz83A2077rwzYzZHvIuTsK82Kw44a
 dn6BrVxDfo38dLy2fESRkDvGfCR5TDrEqaoJHhZ2+lqQc5pNp8O4kKDz5HIppTfm840wVv
 4A83Pjs5mNnHQbheiTLVvAA5R/VnD+Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-tuelku09OlKGbDkd_Ax3Hw-1; Wed, 29 Oct 2025 01:54:14 -0400
X-MC-Unique: tuelku09OlKGbDkd_Ax3Hw-1
X-Mimecast-MFC-AGG-ID: tuelku09OlKGbDkd_Ax3Hw_1761717253
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b6d7c0c634dso296213466b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 22:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761717253; x=1762322053;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UX50O7T+6CxtK81aShDu/YtHqTLIzDtu/vk5nKaFd/E=;
 b=WOhjh0rkt4iko1Z1PCzHuM927l7UJIdyIAgSRoKEQQh4J4bvZVBRa6qJ8VJiUV/QEJ
 4NqmzMlT9ShauEolBKKWKEFYv4OyBGrsx2CWyaoP3rd5+sQzA5mZ/hiB+1m+Zx47brWX
 Qu7WcddwXxxgCMC+AxhwTC9JaODEQRBS3P3P9+Ct4/9nSCspVeM/9L1eZhTIO+jpMHJk
 zb01LWzjSS64vtou/WJ3+NQAN+XvhYNiYMnOeMfSifW9gkn+OjglAH+GxgozBqBKPGw+
 bFwR6b9+1r2OJDEFjN8TeNqSkGvXOxcNp3KgfIL4y5SsOkB8C+zkKj5/4CfpZg0oI0XC
 4A/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvolyrsF1BGImaTy0Ucuab46ercGHrtKWi0lr4wHnFR6y5afs7MO6eifjIusJm4svMO2a4fZkAcxAD@nongnu.org
X-Gm-Message-State: AOJu0Yzh2r0V7ymDAKqSRWogIHtuZAtC/Nl6IbvpWEbNYbcJtwYGm62Z
 NpuWDLHTJlO/SW54Z2lfRPbUXntXhCDEgCJWybi8cH8b0ve6ole3RLYY0yla0IBPSJ+873DTBIJ
 GpN0L58XRECBLU743lWMJ3AkGq00cHwvbrHIDcGK8dTlS6QOJ5IvHuEpW
X-Gm-Gg: ASbGncsSlr+pJJLFVhqhmaVd7XHpX81pQ5B/bmYOP9RjVPFNipOZ5O9uk+EUNYw45o1
 jNmxT1JPlu7a/KZM6Sy69fn7pU/yWFp30HVQ7+HmpkIDpwZCNytYvVtGWj5EmhfTTtB8hpIhgIX
 xAXKXatgsRSJC5StplhxWkyX5DqLZN9rlJGSZmJ3zbycl2sMFZPOsPx0Fu2znPa04rayzk7VlcQ
 5kVLwWCPlLnTe0q2ZWDAmC8nVb3fF5WNUPXapExLIyNnotB2yXE5uY6v2RxrdDZaYvhXW6koq7Z
 X/2uPbv6hU8CBl0VAunP3M0p2st6dnVtT6ehymvPGGRHbass6Jm6wdvTqpVmRijmhVQFsPU=
X-Received: by 2002:a17:907:7f05:b0:b40:b6a9:f70f with SMTP id
 a640c23a62f3a-b703d2df135mr166787766b.4.1761717253026; 
 Tue, 28 Oct 2025 22:54:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFik65qdjmueHclY9gon6Wx4R5zrHjc6TQ224JHpzE5acyhDtwvh87X29lDry6wm5gcTHGf4w==
X-Received: by 2002:a17:907:7f05:b0:b40:b6a9:f70f with SMTP id
 a640c23a62f3a-b703d2df135mr166786366b.4.1761717252608; 
 Tue, 28 Oct 2025 22:54:12 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64043e05a5esm1201107a12.4.2025.10.28.22.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 22:54:11 -0700 (PDT)
Message-ID: <179d3e89-91e5-4845-a415-a136ef36fdc3@redhat.com>
Date: Wed, 29 Oct 2025 06:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/25] hw/i386/microvm: Use proper SysBus accessors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028181300.41475-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 28/10/2025 19.12, Philippe Mathieu-Daudé wrote:
> SysBusDevice::mmio[] is private data of SysBusDevice, use
> sysbus_mmio_get_region() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/microvm-dt.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
> index cb27dfd732e..d7f49bc1b5f 100644
> --- a/hw/i386/microvm-dt.c
> +++ b/hw/i386/microvm-dt.c
> @@ -71,7 +71,8 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
>           return;
>       }
>   
> -    hwaddr base = dev->mmio[0].addr;
> +    MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
> +    hwaddr base = mr->addr;
>       hwaddr size = 512;
>       unsigned index = (base - VIRTIO_MMIO_BASE) / size;
>       uint32_t irq = mms->virtio_irq_base + index;
> @@ -150,7 +151,8 @@ static void dt_add_pcie(MicrovmMachineState *mms)
>   
>   static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
>   {
> -    hwaddr base = dev->mmio[0].addr;
> +    MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
> +    hwaddr base = mr->addr;
>       char *nodename;
>       uint32_t ph;
>       int index;

Wouldn't it make sense to move patch 11 before this patch, and then to use 
memory_region_get_address() here directly?

  Thomas


