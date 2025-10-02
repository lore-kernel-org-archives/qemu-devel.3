Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FF2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DjN-00026i-S7; Thu, 02 Oct 2025 03:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v4DjG-00025T-Ii
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v4Dj5-0005kY-Ci
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759390051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ciFs7nuses53NjNtkyvSY/Whl8DuY3nPaAq7VRH19t8=;
 b=b+SLbLdEBLf8LGFSPSzvqO1+txdH4V89gx1wAgoxcUYD4olaVGf260dcCq+HLKeNyLyCbq
 TNK3x4KSwzX1irVAJaqoU/7tjfp0trNZwGTPNZbPIqd2wyOYpAoswrJEDVLJT9vQX0ZEu+
 lj+y5VEcYi4jqlzLWsUS9WSuKwZJAKU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-fVwMBaG_ORCj0dOCGGUhtg-1; Thu, 02 Oct 2025 03:27:29 -0400
X-MC-Unique: fVwMBaG_ORCj0dOCGGUhtg-1
X-Mimecast-MFC-AGG-ID: fVwMBaG_ORCj0dOCGGUhtg_1759390048
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso387231f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 00:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759390048; x=1759994848;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciFs7nuses53NjNtkyvSY/Whl8DuY3nPaAq7VRH19t8=;
 b=YQDmArN0vzT43WvXRopehvfXX00S395ctFWjSoCwuNA5N3cGXXXIxawDpVZ67GcsVJ
 xdEMUZTEh0Vyh2YOgN1Iknjnyn3azZVnm37Andh65jKOBFDEOiaEhhyB0HSl+3EkEQ3B
 DuAT4wF7yCxkvG4HCU1VPKYmoez+leMqWMGPYV4J1d1fgKAcJt65E/6rk85YCKUZXtoe
 ePREj1NnMeMQtcjawnW/ucT/Sjfc6ofUs29gP2Ecs4hfbdl8NTd0lqagPn8dc9rSB/pc
 M4UucvnvAEsbRxQ7FKb7FUHAv1zsRz1ru6W+B2ikGIA+OTPkdfVGQwWnrmEMZahptvs1
 T/ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHxNVmbawfquAoOq/eaGYlM2s0MBmyBupYdWjyaD4H6GMQ++jTmMnY+o339oIM6OCwzQsteaS1B8jN@nongnu.org
X-Gm-Message-State: AOJu0Yyg0lwPNV8e8BPzR9p+8+SDpgDv6uUOZq07/OO0EuazrXB2KlJu
 i+08TN091aN1Lt496yrMrMAyNzn9U9wUoqcntYmre33E0tL4Xeku+zBy1IesBbX2mKuqIz9ieCZ
 dbJ5I9vDdLVP3YdV9MZLbWZHOurikQ055mmzuDn4Hsht1HvZx3+d/YWWa
X-Gm-Gg: ASbGnctApryTo2mX+uW5ePDQkfvMmhm1XtEmy1Oz5/HEbXkutotxMrWajAqEfCya7hR
 6FnCIqZGAgI3LokuAhUAZcxefSEGaf782te80BQhZRe38LalfQZ3quYlwvYEKW6DwM5Jp2G7qYt
 hNxbJX/lUDFnb6/QtYKCz/PevCSarILsF8UAbToywjOIHsonwbOXOzQZbHqg79LEg1r/aBICiBA
 AGbIqb13UnOkDg/UTMdI0v2+LdbXaUaxAo2IZUrJqEAPz14Jd53AG2ZlTxe0jJ94QoyX2bYgHYv
 ZCfqm9wE+lkf99qoVes4Ad7CCBo/SZsdtOROEHMu5Z5FjCHuZk3hK3eQbmAuqh/8zkNEgEIeqNr
 7NKqeymGe
X-Received: by 2002:a05:6000:288b:b0:3e0:e23f:c6d9 with SMTP id
 ffacd0b85a97d-425577f3550mr4038100f8f.17.1759390047790; 
 Thu, 02 Oct 2025 00:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz36m2DxkY9T7j/sKdhlzbSkuqhkx/IwQdO3NdvVf1XL9cdBPyJpC34oQwWW+g7MGTzgA1ww==
X-Received: by 2002:a05:6000:288b:b0:3e0:e23f:c6d9 with SMTP id
 ffacd0b85a97d-425577f3550mr4038081f8f.17.1759390047374; 
 Thu, 02 Oct 2025 00:27:27 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com.
 [80.187.80.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe49sm2380833f8f.21.2025.10.02.00.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 00:27:26 -0700 (PDT)
Message-ID: <8182adea-f81a-4652-9fdd-132dc43ae690@redhat.com>
Date: Thu, 2 Oct 2025 09:27:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/pci: set kvm_msi_via_irqfd_allowed
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20251001200511.325815-1-mjrosato@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251001200511.325815-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 01.10.25 22:05, Matthew Rosato wrote:
> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e8e41c8a9a..88852acf45 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>       s390_pci_init_default_group();
>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                                S390_ADAPTER_SUPPRESSIBLE, errp);
> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();

Just wondering, what's the net result of this patch?

I assume better performance. Might be worth adding that "why" to the 
patch description.

-- 
Cheers

David / dhildenb


