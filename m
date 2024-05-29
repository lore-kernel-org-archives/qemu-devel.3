Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD6FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCDSU-0000jb-FL; Wed, 29 May 2024 03:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCDSS-0000j8-VZ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCDSN-00047Z-Hl
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716966641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0wR+PuEnjtXXy26U6gdnhg2xY/l2t8Cvxegx6rfnfJM=;
 b=FpA23RNVo2+8ewccNMgB/IYcov8a1IvN2GFOe6hdD0iP0xIs8/N65GLVEhMJ3455ai0+SA
 Q0g5frO70ycvHAXn/fljezFlmfaVSb0/nvpUcGKi/SLNtzZzEQw6FCIbsPFe85XoFyMAyv
 CwJ6kOkw+hDYb7mThbePxPL1F3OzhwQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-cjkk4dA-MwWuatC0_8AP1A-1; Wed, 29 May 2024 03:10:39 -0400
X-MC-Unique: cjkk4dA-MwWuatC0_8AP1A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2e97f963e09so12752491fa.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716966637; x=1717571437;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0wR+PuEnjtXXy26U6gdnhg2xY/l2t8Cvxegx6rfnfJM=;
 b=txLlFkfY6Xi5/tmPgYzVqyLuUXZQeJKaVGS34qZxII4sXCzN9o7TziTnezxXjuk4Tn
 dnnSnxnw3ZRuPT9jm1YGEBuziWngDRTlpfzyK9/zsuuipj+0GgE4GD1duK26hMIKpQk9
 oTXBjW4KhTAjtjsww7F78e/S4jwOxHP0DbwDT1kmDiuwGId68mxFOhhJuk5f2UgqJEek
 yyecMycbKdC1/nDiiG6OuoozHewK6bSYda9v3agQP4WAj7atVilPJSlTWf+gHA7njGCU
 CbWDOSJD0Y3IjdKKLED5Z+Yv6NDXVLJn5d9o4H0tB2mMkDQGZ2K0VYeqtaX18zw70GsT
 YuAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHNWedfFgrsdhpEOhUtlOo/hCyGmxy1cCplYOB0fUbuvv9QCCqAjlzLS/GeJ5iLi2fYeqRZc/JeEZ0L+vVNQS/MJL8RRo=
X-Gm-Message-State: AOJu0Yy1CpS2l0yAlZHjwSmbquDtaQOU/K1GpmpqyFLsMFX2+PFy6HoN
 h8hsSmlt0SSky1DdRWnFFdhAPKlQZokp3k1Zytq/aKDfHVlYGX85xRpEHXdFW2LfG2Gn9RHEbSI
 PRVErr1jukTN+Q66gqS0b9t2VMeKJZEkFbz/xZg6kl0AgyxIURPJU
X-Received: by 2002:a2e:a7ca:0:b0:2e1:a15b:b504 with SMTP id
 38308e7fff4ca-2e95b2564fbmr98394651fa.37.1716966637537; 
 Wed, 29 May 2024 00:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMe5nXUEFYWKbzk3OVytSRk4hbDN0fBAGZOcp261NtH+grKqN1f1IGjFlpJn1kjPam4z/n6A==
X-Received: by 2002:a2e:a7ca:0:b0:2e1:a15b:b504 with SMTP id
 38308e7fff4ca-2e95b2564fbmr98394431fa.37.1716966637075; 
 Wed, 29 May 2024 00:10:37 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089708edsm169062515e9.16.2024.05.29.00.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 00:10:36 -0700 (PDT)
Message-ID: <e10e39b9-f000-4b61-80b8-7ff78b1c176d@redhat.com>
Date: Wed, 29 May 2024 09:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/libqos: Add loongarch virt machine node
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
References: <20240528082053.938564-1-maobibo@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240528082053.938564-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 28/05/2024 10.20, Bibo Mao wrote:
> Add loongarch virt machine to the graph. It is a modified copy of
> the existing riscv virtmachine in riscv-virt-machine.c
> 
> It contains a generic-pcihost controller, and an extra function
> loongarch_config_qpci_bus() to configure GPEX pci host controller
> information, such as ecam and pio_base addresses.
> 
> Also hotplug handle checking about TYPE_VIRTIO_IOMMU_PCI device is
> added on loongarch virt machine, since virtio_mmu_pci device requires
> it.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c                         |   2 +
>   tests/qtest/libqos/loongarch-virt-machine.c | 114 ++++++++++++++++++++
>   tests/qtest/libqos/meson.build              |   1 +
>   3 files changed, 117 insertions(+)
>   create mode 100644 tests/qtest/libqos/loongarch-virt-machine.c
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 3e6e93edf3..2d7f718570 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -45,6 +45,7 @@
>   #include "sysemu/tpm.h"
>   #include "sysemu/block-backend.h"
>   #include "hw/block/flash.h"
> +#include "hw/virtio/virtio-iommu.h"
>   #include "qemu/error-report.h"
>   
>   static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
> @@ -1213,6 +1214,7 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>   
>       if (device_is_dynamic_sysbus(mc, dev) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
>           memhp_type_supported(dev)) {
>           return HOTPLUG_HANDLER(machine);
>       }
> diff --git a/tests/qtest/libqos/loongarch-virt-machine.c b/tests/qtest/libqos/loongarch-virt-machine.c
> new file mode 100644
> index 0000000000..c12089c015
> --- /dev/null
> +++ b/tests/qtest/libqos/loongarch-virt-machine.c
> @@ -0,0 +1,114 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *

Don't you want to add your information here, too?

Anyway:
Acked-by: Thomas Huth <thuth@redhat.com>

I assume this will go through the loongarch tree. Let me know if you want to 
get this merged through the qtest tree instead.


