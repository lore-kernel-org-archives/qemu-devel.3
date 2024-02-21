Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9815EC5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTx-0008EW-Ck; Wed, 21 Feb 2024 10:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoMz-0000nB-7V
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:51 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rciNI-0006hP-54
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:54:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412748b183aso3617075e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 00:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708505682; x=1709110482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IL4qO7MOcVi4MGpjEojSBfFz5U68QnGi75B1lq5XjZU=;
 b=GISvUosUT1g3fGRsnuTbEt2RDCzBZD7+FVcyakzL4TpSGPLTirYpiqb8SCTolAa5VE
 DcukzmnVI0wptl5XgmYTsJFMMIxL+kgjRhcqIN2pyL7HawMK7rozU1+hcUL3WTZgI51t
 ch5kD3okN4n0+iYLBjgOp2LyxyL2PqtfjrH9NV/efW7SpB08UZlO6faFqgYdXt8Vyin0
 UbVAjKTeh9MdDKS11lrzpj1WNlXbGJoeAypS/iazA/oIwI4N/3nerAoQGNE9682YJDoC
 jFyQxguy+qrAz/pY9W/QKGepsBNPZbQ4jX3RdP4ay03lSO1ULgWiM1olpNgNpvHUWeh9
 wb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708505682; x=1709110482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IL4qO7MOcVi4MGpjEojSBfFz5U68QnGi75B1lq5XjZU=;
 b=TR9ea4OGkjVJwxy+njnuRbSomCe5XCIPhB8J/i/BTOlbiroTMCPTA8yGYVF1XkN1OX
 Qq0m8g8IHy3/QjSDoTuiqKWeFEK10PNIzsab5BZ8toWZSwTrkyd6syWETus02K3oqVfB
 98kqvPWUnh1FFD3BSB37RMxw/SX15lW100IqFeLkwBOHx6PBN1aDbY7pXLaUUJFdtEu9
 hfVW+kkP/tbxAlYt4ExJITGKR1ZYBxcMrgGxDgtwwxofmulQHZ18uLEn1/Bl9arMd1To
 ss9X6tgrdHtj2SYtWbgbVizpT5DHkGoaQZeJ7h8an+SUpNWXmoabCYiSH8jceVmOUHzp
 BJTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH3vUnXXCFJtwLqK+VW3OpokK4/ejVrLnHPixbiMGPYnFL2H3TDkKg48XxVOqgL4NNFaHCNko31tp9w3jum3EXO/TTo1E=
X-Gm-Message-State: AOJu0Yw8GboZhpzBgCIzKCPCU8t3ibJ/6KadH5wNFHDm4obVlNuOSvVQ
 8Nx2VDyMGLYzpuBnQtU7HTZN5tFnQVIg3XaZXEQ26UsIHS6RCSg7H1WpwCEoTsI=
X-Google-Smtp-Source: AGHT+IFI9UYRfzbsWl+N286cqalQ65LKK+hxQxVmy+3XCz0FPOCs+XzO3eke16fuHHS9J1x7fwXNWw==
X-Received: by 2002:a05:600c:511f:b0:410:d6c7:e003 with SMTP id
 o31-20020a05600c511f00b00410d6c7e003mr12449107wms.32.1708505682381; 
 Wed, 21 Feb 2024 00:54:42 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.159])
 by smtp.gmail.com with ESMTPSA id
 w2-20020adfec42000000b0033d13530134sm16037706wrn.106.2024.02.21.00.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 00:54:41 -0800 (PST)
Message-ID: <9a386049-17e9-4181-b0a8-050c69d0be20@linaro.org>
Date: Wed, 21 Feb 2024 09:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] hw/pci-bridge: Extract QOM ICH definitions to
 'ich_dmi_pci.h'
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-7-philmd@linaro.org>
 <C977DC8F-8731-4ED4-8FFC-85241ABED160@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <C977DC8F-8731-4ED4-8FFC-85241ABED160@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 20/2/24 20:25, Bernhard Beschow wrote:
> 
> 
> Am 19. Februar 2024 16:38:46 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>> "hw/pci-bridge/ich_dmi_pci.h" header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> MAINTAINERS                         |  1 +
>> include/hw/pci-bridge/ich_dmi_pci.h | 20 ++++++++++++++++++++
>> include/hw/southbridge/ich9.h       |  2 --
>> hw/pci-bridge/i82801b11.c           | 11 ++++-------
>> 4 files changed, 25 insertions(+), 9 deletions(-)
>> create mode 100644 include/hw/pci-bridge/ich_dmi_pci.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1b210c5cc1..50507c3dd6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2609,6 +2609,7 @@ F: hw/acpi/ich9*.c
>> F: hw/i2c/smbus_ich9.c
>> F: hw/isa/lpc_ich9.c
>> F: include/hw/acpi/ich9*.h
>> +F: include/hw/pci-bridge/ich_dmi_pci.h
>> F: include/hw/southbridge/ich9.h
>>
>> PIIX4 South Bridge (i82371AB)
>> diff --git a/include/hw/pci-bridge/ich_dmi_pci.h b/include/hw/pci-bridge/ich_dmi_pci.h
>> new file mode 100644
>> index 0000000000..7623b32b8e
>> --- /dev/null
>> +++ b/include/hw/pci-bridge/ich_dmi_pci.h
> 
> Shouldn't we name the new header like its source file, i.e. i82801b11.h?

I'll rename sources to use the "ichX_FOO.c" pattern.

>> @@ -0,0 +1,20 @@
>> +/*
>> + * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_PCI_BRIDGE_ICH_D2P_H
>> +#define HW_PCI_BRIDGE_ICH_D2P_H
...

