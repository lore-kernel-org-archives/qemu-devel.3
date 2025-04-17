Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA155C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T2v-0006px-KW; Thu, 17 Apr 2025 13:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T2q-0006me-TS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:29:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T2o-0000gd-Mz
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:29:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22435603572so13085335ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744910936; x=1745515736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uE6SpS9iCTqPjCvh1GFyDybdYD6CvcUwjj0EsECqXYY=;
 b=ui8sc8iX2T2GTUsw+c2Jtw8WxC5uunOAvL1h6SdRiuXihcfqQtq81ukWbDvuYgSq4t
 NDZ+ESSE+9i0Z4EKjrfkMCV4ZhEwyX+UaX9CVqGR2CXGnB/ZVl0A/lXIqpwBhJBQ2Yg7
 YrorzubzuFiCHy9pbpUHwofn7d4e+YEwMQ5fr0kTkI7t5h92qk6IMYGZBLzN4IZuGPNk
 wctxkO8WhcEoHJTWjNdI4UxCn8Av1wpxXz9VAO3O0du7/GQwmwavfEx8nLQIIUNlSEyF
 o6sWu8O1nHgrmmqIsOgelpDP4i+6uEvrwdT/MMyU0HsxRWgiACqvbpAmefm606o7ZSQp
 OrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744910936; x=1745515736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uE6SpS9iCTqPjCvh1GFyDybdYD6CvcUwjj0EsECqXYY=;
 b=G6fuf+TaxrD7nhb/ljBdV5/szW5BzkWWVZLgo/wxK3PzEig9lV5wH4kXfWaPufsvSy
 KVSr2H07t3vvbPviudzvsRk3r7cbzr+PF/g8jt/GZm7RtFXuGQHZxCrTR87Nt3O/VT2o
 vH88KfaYMVk52OrFxLHxgufcr0idOzRt1WR87PpQiV7uzkP9+GQ9+1kvCogr0AlOuHjO
 OWQ35KGUXshy/Tu0NOlXnav/zpP3ksxtdG/lSRyJRMY5+eFWS6FNhyFwimf9JhABQJKD
 opFI35+QnsD0Lt/dVhOaG5UeSgyfAbwAjDPbg6PrWaHArtrBeIolQnebHYzhR7fNrcwg
 7qCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFuGbtg2lrjKIXgueo/fCpG6mKmCWLjjhDJSrW+tLoqP0CP1jBWDw4YgBtUIFe2vAGHxQ9glHS6CvQ@nongnu.org
X-Gm-Message-State: AOJu0Yw69wi2RSdG3pCNZb1+t/T1eiCL1hIEC7XRQs+ZTKJGYOSr9bTT
 Qnf1FqPQEOgHIexR0nPTXzarktIADPmh0Wq5EyYrf65lYQsmZnJuznd7Pe7C6PM=
X-Gm-Gg: ASbGncugb4QFAt4NQHt6Da64/sVe3IA4PxFQcurmmZset/Fx4B2+dzpC6FgkoQPt+Ox
 6GlQGmkgnL/RIw2Fa5K2QtFqYc1muRstfgXfbVr6bnu8wAIECYA6a8gBtBZjAUKkV6oetFiiS4j
 HxiSUv5Uanz/z5e4K3OphDM3YZ7wrkBEZ4kh/CueZ1gVBRsooIWVqUgekl8LlsprZ+v0SbKNnli
 evCNP/XemUMj1j7TJzIoVi4+1YQ50SSCxa0SYujxkX/IRCD/xcVQK5Sm/9xWEPC7dOfrLlmUKXd
 mgZZTBHwMvz3ca5FWLhZuIpPeq0a8HdF/ayKq4PJc2PWlqGuc6Ew
X-Google-Smtp-Source: AGHT+IGCYFCrNLgSophewf089Kr3J8Czq5Bz1RUTB/MSGJmbkeZVCUCGxnPtYvh9mh+O09cXiRcVlA==
X-Received: by 2002:a17:902:e808:b0:223:2aab:462c with SMTP id
 d9443c01a7336-22c358d70femr98442945ad.15.1744910936282; 
 Thu, 17 Apr 2025 10:28:56 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdbc5esm2442985ad.222.2025.04.17.10.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:28:55 -0700 (PDT)
Message-ID: <75bfdfcc-d030-4a59-bece-49f422799869@linaro.org>
Date: Thu, 17 Apr 2025 14:28:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 01/13] acpi: Implement control method sleep button
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, paul@xen.org, Jonathan.Cameron@huawei.com, git@dprinz.de, 
 imammedo@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411202827.2904-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411202827.2904-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
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

Hi Annie,

On 4/11/25 17:28, Annie Li wrote:
> The fixed hardware sleep button isn't appropriate for hardware
> reduced platform. This patch implements the control method sleep
> button in a separate source file so that the button can be added
> for various platforms.
> 
> Co-developed-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/acpi/control_method_device.c         | 33 +++++++++++++++++++++++++
>   hw/acpi/meson.build                     |  1 +
>   include/hw/acpi/control_method_device.h | 21 ++++++++++++++++
>   3 files changed, 55 insertions(+)
> 
> diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
> new file mode 100644
> index 0000000000..c3b1d484c4
> --- /dev/null
> +++ b/hw/acpi/control_method_device.c
> @@ -0,0 +1,33 @@
> +/*
> + * Control Method Device
> + *
> + * Copyright (c) 2023 Oracle and/or its affiliates.
> + *
> + *
> + * Authors:
> + *     Annie Li <annie.li@oracle.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/control_method_device.h"
> +#include "hw/mem/nvdimm.h"

NVDIMM is out of context here, please use:

#include "hw/acpi/aml-build.h"

instead for the aml_* symbols.


> +/*
> + * The control method sleep button[ACPI v6.5 Section 4.8.2.2.2.2]
> + * resides in generic hardware address spaces. The sleep button
> + * is defined as _HID("PNP0C0E") that associates with device "SLPB".
> + */
> +void acpi_dsdt_add_sleep_button(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_SLEEP_BUTTON_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));

I see that since GPE event handler L07 will be tied to the sleep button
device there is no _PRW variable defined here. Do you mind adding a comment
here about it? Something like:

/* No _PRW, the sleeping button device is always tied to GPE L07 event handler. */


Cheers,
Gustavo

> +    aml_append(dev, aml_operation_region("\\SLP", AML_SYSTEM_IO,
> +                                         aml_int(0x201), 0x1));
> +    Aml *field = aml_field("\\SLP", AML_BYTE_ACC, AML_NOLOCK,
> +                           AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("SBP", 1));
> +    aml_append(dev, field);
> +    aml_append(scope, dev);
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 73f02b9691..a62e625cef 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('c
>   acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
> diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
> new file mode 100644
> index 0000000000..079f1a74dd
> --- /dev/null
> +++ b/include/hw/acpi/control_method_device.h
> @@ -0,0 +1,21 @@
> +/*
> + * Control Method Device
> + *
> + * Copyright (c) 2023 Oracle and/or its affiliates.
> + *
> + *
> + * Authors:
> + *     Annie Li <annie.li@oracle.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
> +#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
> +
> +#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
> +
> +void acpi_dsdt_add_sleep_button(Aml *scope);
> +
> +#endif


