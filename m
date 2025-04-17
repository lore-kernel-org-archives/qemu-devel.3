Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB33C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T9a-0005rn-Hz; Thu, 17 Apr 2025 13:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T95-0005dZ-8I
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:35:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T93-000262-5X
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:35:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2243803b776so18309845ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911324; x=1745516124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SXR83scLRgArngV+mvYFTEFgQJ98v+F0q+9StaH/QB4=;
 b=raZCizEzJwypq2J5rS/KA2PbKj3Fow3KVe9NmmOHcb6e0c69bfVv6JgEyhSWykMeUY
 SAxXOu/z6nBiRDHDm2mh5aKHLY8a7Om7S7Z75kCpYvjCTJRURNuR7cnUn2Sp13p2tbia
 PQp8qushSNUJ1so8oBCu+FjJP+jD0brBjwzhMv9A2fxqyafw3j4xhz/f8WCdD7ZvWdQv
 dGyP2vtSAMemeLMp+X4RkCvHcqFhb11HId9/yE6tm3QCIfn9jBoTdwOSF9J3h5flNXwh
 x9NM/ga0UqG7d1k5pBetJs84C5GuMnRpN/MT3CPL0X+JVy6+JslGSTKsOy2IBMtR9JCY
 3USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911324; x=1745516124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SXR83scLRgArngV+mvYFTEFgQJ98v+F0q+9StaH/QB4=;
 b=ViIkRJgyT3LQyjrmUMkVsQV8PR3SSHDSe2alvZTcrkz98k6A2QxSnE4iQWM5AOhJ5x
 3/cTcYi2x+mVIrhimWB2i2qbsm8FrDTiNRrYTjHKBNlpid8W9Wdrd/XoVEs/qaG5ZhUf
 yz9iTB5LKxOuyFNXbzYh5MQ9b1nTZeqLuU0qqC9/SqP34fgByyAaNXK0yIvPu3wrYzor
 G/rOVDLscY4Uy8wLpnz07gjqpblP5+z10wW+QFoLGK/qFKCR75KNMgnBvOLkKIigevrP
 BAxzAWFBgIXuUhchdR8nN9SoqTrtPMgkU+gYvYpsv1pIIhgkQtFAW+CKy48wYctrvjDg
 onlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgdKgASeL86Z7P/jzLah93I4to4plU0Q2eHV15r7dxC+L5APQXC1aSaezQrLtSzk1McTGnVVrI1Tx2@nongnu.org
X-Gm-Message-State: AOJu0Yw2VnnFlb7GO2Dacb9KY7VKyR+Psu3Cvu7kL1RZV+PCuAnniT3K
 wzOa5iP0/n9Q5O4kjMU/DvuFb3OGxHoAN5NguwRYHsGkgNNMWJHZkl6efX2wiDs=
X-Gm-Gg: ASbGncuMo/mqyBMpGO7uzD6UbJ/v1cYNqDSwDVnM3gfyImB8nImobkmjRLfypxgU46r
 yTX9HFVuAWPipuLaLiBd1CCLIBYE76hUKkw3LhPHinEsnvR8una0yD0+fnscLisqlToMoz/dAxc
 ZNP6i0Xc3XX7DQxMATuYlG6zyppwckNJSsDWv7zmYLf0DaYzywA75zLCYkXuqQAgXO6aq9pEByv
 lMdf7bgSeTgOzhg/J47BvPsKesnt7L9ppkuDYvkMGyflfy294berJWT9rocSTSq/rW/9sGYtxpP
 kVK8llchK7dek+WDMRQU+xY+tTjANsX7PxI3Px/OkCltkuKzkLZX
X-Google-Smtp-Source: AGHT+IEzl3EQd5im67NDSHUpqa/MTc+plY/H9QbBwAZSACEsiMA8BT1qIOVtinhrjLGhy6RJkLigKQ==
X-Received: by 2002:a17:902:ebd1:b0:224:1ec0:8a1a with SMTP id
 d9443c01a7336-22c35985d28mr93935245ad.51.1744911323791; 
 Thu, 17 Apr 2025 10:35:23 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fde883sm2507065ad.242.2025.04.17.10.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:35:23 -0700 (PDT)
Message-ID: <ab507d4a-00bb-43dd-9c86-c52345a6de39@linaro.org>
Date: Thu, 17 Apr 2025 14:35:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 08/13] hw/acpi: Add ACPI GED support for the sleep
 event
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204257.2988-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204257.2988-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/11/25 17:42, Annie Li wrote:
> From: Miguel Luis <miguel.luis@oracle.com>
> 
> Add support for ACPI GED sleep event on the ACPI device
> interface so that HW-reduced systems can enable guests
> to sleep.
> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/acpi/generic_event_device.c         | 9 +++++++++
>   include/hw/acpi/generic_event_device.h | 1 +
>   2 files changed, 10 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index c85d97ca37..5a1ac8e362 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -13,6 +13,7 @@
>   #include "qapi/error.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/generic_event_device.h"
> +#include "hw/acpi/control_method_device.h"
>   #include "hw/irq.h"
>   #include "hw/mem/pc-dimm.h"
>   #include "hw/mem/nvdimm.h"
> @@ -26,6 +27,7 @@ static const uint32_t ged_supported_events[] = {
>       ACPI_GED_PWR_DOWN_EVT,
>       ACPI_GED_NVDIMM_HOTPLUG_EVT,
>       ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_SLEEP_EVT,
>   };
>   
>   /*
> @@ -121,6 +123,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                              aml_notify(aml_name("\\_SB.NVDR"),
>                                         aml_int(0x80)));
>                   break;
> +            case ACPI_GED_SLEEP_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name(ACPI_SLEEP_BUTTON_DEVICE),
> +                                      aml_int(0x80)));
> +                break;
>               default:
>                   /*
>                    * Please make sure all the events in ged_supported_events[]
> @@ -295,6 +302,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>           sel = ACPI_GED_MEM_HOTPLUG_EVT;
>       } else if (ev & ACPI_POWER_DOWN_STATUS) {
>           sel = ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_SLEEP_STATUS) {
> +        sel = ACPI_GED_SLEEP_EVT;
>       } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>       } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 28c5785863..71503e0100 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -102,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>   #define ACPI_GED_PWR_DOWN_EVT      0x2
>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>   #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_SLEEP_EVT          0x10
>   
>   typedef struct GEDState {
>       MemoryRegion evt;

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo


