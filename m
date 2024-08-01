Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F74C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV2b-0002Ev-2V; Thu, 01 Aug 2024 08:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZV2Z-00029a-Kf
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:36:19 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZV2X-0001di-Dj
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:36:19 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f040733086so80126411fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722515775; x=1723120575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AFXwgARkTU6t7ujPZhm+twS44Mu4z5CPiIZcyO6ym3Q=;
 b=dsH/boSh3m7WllRzh4yAJIn8lc3L5Nq2pgCdJjBzrhmzSKzryv9AJ2fqcZIBpZpgWZ
 Aa7EA69Kj3ijLZ/3jOToYlV+qmkdY+1UUFN/okXVbmkU5ZrPd0bEq8tnklnUeQRNdcrQ
 9oyRX5GsqpDwHG+8jQlj/tbuCwlWH5CCBtbJEGa4Bng+rnfBRU0msVTWeRMJ4FhR3hxx
 S89FC0tWZiydudXMqZxgtDlazbONeO/M5vRvH2bJ5x2v2whi+/SxC9zZ2mzq+/zob0Z4
 u+EV/hLP8YL3yZYHL6b7acooMyWxLT1ESJBP0pgxaD/KRkCJ1eeVwJnCplZQhhmhWON9
 AvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722515775; x=1723120575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AFXwgARkTU6t7ujPZhm+twS44Mu4z5CPiIZcyO6ym3Q=;
 b=R0dggjhtivt4lRjIUH608GskpfS/5RqoWsErYp5vkCFhdsuV3LXxeM0sRJyR0v6Rng
 QEA92t1wKum4wnTeVJkrGkI3g+BSm+A8aA9WXI6+q5eKKOXscdGSXOMmLAnMA6CIQHPs
 yrLo21vCTVwaTJmSoMH20PHW0W0aHWqb6XW0WWYQt9F5Yqutsw1LBgOHOxB0ZjGJ6dAq
 RwoAAKLQx/b9+t3ZOIaTlugyEZMdhgj/j6q2tcmMgLvB2Cx4eKSL0cEJWLiVoRS0DXey
 vYdjBiQWMD5DgLYI8LOLNnj/Cu75RKuKI1u+YK9eA07r/LkGVHWb+9oAykwUHeXgjepe
 P53g==
X-Gm-Message-State: AOJu0YzO5WPHLR2jXz9dNGHIsN9sHhgECvf4Mur5WFNYI+MQ/cdd8G/f
 kdgicToxOlP2gauZTw1kulsKmiH7JEuxi74vsd+QIxDfP0ILUyBzubGFGx1+84Q=
X-Google-Smtp-Source: AGHT+IFNb+1Bbg+P3B1wdSVpep/dQLfy15ukteBugQevIgHc3DxFVOH8cCBoBvLjYwRHxxrPOO3k2g==
X-Received: by 2002:a2e:87c3:0:b0:2ee:7bcd:a52 with SMTP id
 38308e7fff4ca-2f15ab53020mr638231fa.46.1722515774724; 
 Thu, 01 Aug 2024 05:36:14 -0700 (PDT)
Received: from [192.168.33.175] (206.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367e51f0sm19370028f8f.46.2024.08.01.05.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 05:36:14 -0700 (PDT)
Message-ID: <3b2c64bd-33b4-48bf-9afa-ac5b138b901a@linaro.org>
Date: Thu, 1 Aug 2024 14:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1?] hw/pci/pci-hmp-cmds: Avoid displaying bogus size
 in 'info pci'
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240801100742.50312-1-philmd@linaro.org>
 <20240801062632-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801062632-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 1/8/24 12:27, Michael S. Tsirkin wrote:
> On Thu, Aug 01, 2024 at 12:07:42PM +0200, Philippe Mathieu-Daudé wrote:
>> When BAR aren't configured, we get:
>>
>>    (qemu) info pci
>>      Bus  0, device   0, function 0:
>>        Host bridge: PCI device dead:beef
>>          ...
>>          BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
>>          BAR5: I/O at 0xffffffffffffffff [0x0ffe].
>>
>> Improve logging to not display bogus sizes:
>>
>>        BAR4: 32 bit memory (not configured)
>>        BAR5: I/O (not configured)
>>
>> Remove trailing dot which is not used in other commands format.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
>> index b09fce9377..8421c3f74a 100644
>> --- a/hw/pci/pci-hmp-cmds.c
>> +++ b/hw/pci/pci-hmp-cmds.c
>> @@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
>>           monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
>>   
>>           if (!strcmp(region->value->type, "io")) {
>> -            monitor_printf(mon, "I/O at 0x%04" PRIx64
>> -                                " [0x%04" PRIx64 "].\n",
>> -                           addr, addr + size - 1);
>> +            if (addr != UINT64_MAX) {
>> +                monitor_printf(mon, "I/O at 0x%04" PRIx64
>> +                                    " [0x%04" PRIx64 "]\n",
>> +                               addr, addr + size - 1);
>> +            } else {
>> +                monitor_printf(mon, "I/O (not configured)\n");
>> +            }
>>           } else {
>> -            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
>> -                               " [0x%08" PRIx64 "].\n",
>> -                           region->value->mem_type_64 ? 64 : 32,
>> -                           region->value->prefetch ? " prefetchable" : "",
>> -                           addr, addr + size - 1);
>> +            if (addr != UINT64_MAX) {
>> +                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
>> +                                   " [0x%08" PRIx64 "]\n",
>> +                               region->value->mem_type_64 ? 64 : 32,
>> +                               region->value->prefetch ? " prefetchable" : "",
>> +                               addr, addr + size - 1);
>> +            } else {
>> +                monitor_printf(mon, "%d bit%s memory (not configured)\n",
>> +                               region->value->mem_type_64 ? 64 : 32,
>> +                               region->value->prefetch ? " prefetchable" : "");
>> +            }
>>           }
>>       }
> 
> what makes bar unconfigured is that memory space is disabled,
> not that it has a special value.

I tried to add a PciMemoryRegion::enabled field then realized
unmapped regions are advertised using addr = PCI_BAR_UNMAPPED
(which is UINT64_MAX):

typedef struct PCIIORegion {
   pcibus_t addr; /* current PCI mapping address. -1 means not mapped */
#define PCI_BAR_UNMAPPED (~(pcibus_t)0)

OK if I respin this patch with s/UINT64_MAX/PCI_BAR_UNMAPPED/?

