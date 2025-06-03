Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D862C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQ1F-0000RI-9D; Tue, 03 Jun 2025 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ18-0000MU-00
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:41:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ15-0007LX-7m
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:41:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so3175966f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748950872; x=1749555672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mvcsg1+YZkpbcBSfy53PB6iHtlcbQWd2SsuPUq5xHJA=;
 b=zh8wJB0FbSORvTrVaMEAcSmkYQ9rHeD9Kp2UNSKl9PLAoJ2PjhOofz1dayALGSyfXd
 TLQKN5iBI3EYbrFoY6Qu/TMeosUI+io43IoXC59XvBF7XxL3OufF+sqqFAznqW4xpEi1
 mhhAa6AzPYwEshBruPJqOTFzPb9iWLE+XkOBMgu2SYXBxTBvNhevNAvTaCzdzGf1iaTl
 HeS2Osj7Y/67rNNnyGI88+YPX8HeOb7yWB4eULSxysTNSkBV/6/K3QUwEiQ36VSkxmkg
 dl6xhM0WsY5lig/8Lqv15hq+09jKL9hNFvVLR6PDWB1dPkS3aX1ZumTfdPA7vZma03X5
 C6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748950872; x=1749555672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mvcsg1+YZkpbcBSfy53PB6iHtlcbQWd2SsuPUq5xHJA=;
 b=NEOnUJjaxOcAzJfNPPxnGFBg7cnSD85KzUBkgOyK1MfEGNQDLI5Nq5869KpSX1Nj9C
 KliLwHCfErFOP+UEm0bk2sFTIMMv340792bdu0kgu92fhW/Jb7Q/ptX7iH6rtdRhy+Lf
 WWKQDA/N2eKQf2TF/uJsEP6YSFRuW+EowSCqVqcM3i69Tz76iZILr0lLV+WjhWjaD+yb
 ng52i5HZ3t3ky/o6KUAQGhmemHlw6y6dji6kyHmROyA7Cm1cJ4NA/i7vcJjU3R8Cfmp8
 sCLX2XD8Y62KYPABKqaGI8X4eSWd9F7agXvzKuKdnI7sglf9DEfs0bKFQ+JhBb9DQB8K
 4n4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoC1YHxg6Tlc+HypRe01bknIy+RodXHLL1FWw1crrF9GvPXsG61ngKOgvG/mQx66ktydQyPhnVvzOU@nongnu.org
X-Gm-Message-State: AOJu0YynfooedyLvVIaoOqxSHCnxL6gbr8D4jhp6DK3d4t10tN/T1cnQ
 IVZ940168NbzJbi7bYUn2gz1zvyVARf92jLjjIFIwgf7L57PcQMPDjucuy8dSHFsafc=
X-Gm-Gg: ASbGncuw/CWucg6jYmB+3tr7uW0GqwDdxNwZ+28iErYP/KRNTpa5jUPL3EJ0WrVBM6C
 /o3l78V3gNXhJydA3a+HZPp27mcyZ+sm+Gvy5L3u0ss6MOGBogqclJSo5t6Kmv+pzMycD378BHZ
 /Cuz2YcpI+fBVOwzPNDkxtw06YH+xBy6+PHEN+ecTjQoQTXct3tPbwn2YAYamRV5ugwrm8Tkp5W
 tWPJsojFcGiq0ojVOusHssxd+xIh2JsQt0soYTVLJc+m9oBlOVnuWAo5aN3fcbX+fO7/idBPRpP
 DqcUssxl+q8P832PMGRdJ43MM68pdLc2IfGG28rgF1udnvuGsoq6yo9icRB0nUXhylVN5BB3R6J
 sNs0p0xRO9o5aLpjA7Eiq+J0T
X-Google-Smtp-Source: AGHT+IF7HpI/emaj4ZkMdSFiBjUnKRzY4oqDlrBRr/ZZ673tJfQjWRC+wxH6TzaDQKy4w1oiOqN6dA==
X-Received: by 2002:a05:6000:40df:b0:3a4:dd00:9af3 with SMTP id
 ffacd0b85a97d-3a4f7a7de6dmr13505803f8f.56.1748950871978; 
 Tue, 03 Jun 2025 04:41:11 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c842sm17751769f8f.29.2025.06.03.04.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:41:11 -0700 (PDT)
Message-ID: <100a010f-43ef-4680-bd74-6d3144c05313@linaro.org>
Date: Tue, 3 Jun 2025 13:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] hw/pci-host/raven: Simplify PCI facing part
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <3a588b74c994521a4e4a608a129a13bf9200030d.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3a588b74c994521a4e4a608a129a13bf9200030d.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Zoltan,

On 4/5/25 18:01, BALATON Zoltan wrote:
> The raven PCI device does not need a state struct as it has no data to
> store there any more so we can remove that to simplify code.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 30 +-----------------------------
>   1 file changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index f8c0be5d21..172f01694c 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -31,7 +31,6 @@
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/qdev-properties.h"
> -#include "migration/vmstate.h"
>   #include "hw/intc/i8259.h"
>   #include "hw/irq.h"
>   #include "hw/or-irq.h"
> @@ -40,12 +39,6 @@
>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
> -
> -struct RavenPCIState {
> -    PCIDevice dev;
> -};
> -
>   typedef struct PRePPCIState PREPPCIState;
>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
> @@ -65,7 +58,6 @@ struct PRePPCIState {
>       MemoryRegion bm_ram_alias;
>       MemoryRegion bm_pci_memory_alias;
>       AddressSpace bm_as;
> -    RavenPCIState pci_dev;

I'd rather the PF0 be reachable from PHB:

        PCIDevice *func0;

>   
>       int contiguous_map;
>   };
> @@ -268,8 +260,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-intack", 1);
>       memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>   
> -    /* TODO Remove once realize propagates to child devices. */
> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);

    func0 =

> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
>   }

If you don't object, I can amend if queuing; otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


