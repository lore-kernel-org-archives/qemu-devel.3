Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3566C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV4Z-00051z-OX; Thu, 01 Aug 2024 08:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZV4W-0004bQ-19
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:38:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZV4T-00027g-7g
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:38:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso45402675e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722515894; x=1723120694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EDJyPA23QqXy3m2HXs0alZD9FTsiftBYfRYVZLga4oE=;
 b=oMqExneB1kjG/GKWFhZbrdv/FU3de3uQfsq/lL1ya5gw+SqorBnbYYTegsv01xdjTz
 SR4wg0joUIkMktq6zexFu4+VpRJlscxSnPGnfRvK4mCPmk4PFcnYhhhcF4WNwObx1McZ
 PTU9bUSTktEE8wyxqcvPr+hL0HweLc6YXxVRgwiBwaf3WtIqdDnr4B1+81IPs6MYJINe
 KhNLYJOaz+2DqffhmKIF5eIpejVR4z0ggUWvXH0y5sUJMXsmqQEXyH3QKp5RdijZrKxh
 7Gr3dXOUMBrm+dG47ivLaIJHog9VL8CbwDIGfWObMYNtZdUf+qnxzAgoYViur5tczt3b
 Dbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722515894; x=1723120694;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDJyPA23QqXy3m2HXs0alZD9FTsiftBYfRYVZLga4oE=;
 b=kpQU47Cpn76ger4AHc2ARsx+xRxKxrQQkrnsz5agv0ZNsx9K+xLDSRnH+EfOXqSXrN
 hEOiTWnYv1NjBhdM+g1ESTwujCpqU4Sbr8Y0c8IXipTwMLlycSqrOxB0mSq9qBoRWXKF
 jFDoYfmIAKOIdF7gWOQhd2Uct7soaYVxm1bFj0mxejM3UR11/97hsKC/PFLrPMDwKzkh
 6E1ExkC7WoG2tyRUSttDAsQcjT4BttCj49dOxnO4OEV+9OXnQo6XGixDny78KUY7RR+m
 2dzoNhqYAUhW3TLwEuWyBWGRtV5w+enqi+XKBqTltS8j4r3d4jmy2mvX9UEVqAUUMV9c
 vMbQ==
X-Gm-Message-State: AOJu0YwUMirv243uqLSlQfCHeVb79eAfaTUevFyQuRj6vKi6My4+jpYG
 UlAJ9ZU2h3YBRVdcXrTekkxT35Nb2t2WVS29bFAYVLcjy62Cqpmtb6jdmRFlj1M=
X-Google-Smtp-Source: AGHT+IGhLFwf2MKVJuY3M7dcY6SaDQsX0LV30jMqkZir6Ai5+12Ff0MTZu7h7OVOrP2+FH/FiIoG3w==
X-Received: by 2002:a05:600c:6c4e:b0:426:6a53:e54f with SMTP id
 5b1f17b1804b1-428b032c05cmr15195565e9.33.1722515893879; 
 Thu, 01 Aug 2024 05:38:13 -0700 (PDT)
Received: from [192.168.33.175] (206.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8ada7esm57491265e9.15.2024.08.01.05.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 05:38:13 -0700 (PDT)
Message-ID: <cc6824b3-d4d0-434c-8f9c-c70864abc342@linaro.org>
Date: Thu, 1 Aug 2024 14:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1?] hw/pci/pci-hmp-cmds: Avoid displaying bogus size
 in 'info pci'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240801100742.50312-1-philmd@linaro.org>
 <20240801062632-mutt-send-email-mst@kernel.org>
 <3b2c64bd-33b4-48bf-9afa-ac5b138b901a@linaro.org>
Content-Language: en-US
In-Reply-To: <3b2c64bd-33b4-48bf-9afa-ac5b138b901a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 1/8/24 14:36, Philippe Mathieu-Daudé wrote:
> On 1/8/24 12:27, Michael S. Tsirkin wrote:
>> On Thu, Aug 01, 2024 at 12:07:42PM +0200, Philippe Mathieu-Daudé wrote:
>>> When BAR aren't configured, we get:
>>>
>>>    (qemu) info pci
>>>      Bus  0, device   0, function 0:
>>>        Host bridge: PCI device dead:beef
>>>          ...
>>>          BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
>>>          BAR5: I/O at 0xffffffffffffffff [0x0ffe].
>>>
>>> Improve logging to not display bogus sizes:
>>>
>>>        BAR4: 32 bit memory (not configured)
>>>        BAR5: I/O (not configured)
>>>
>>> Remove trailing dot which is not used in other commands format.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
>>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
>>> index b09fce9377..8421c3f74a 100644
>>> --- a/hw/pci/pci-hmp-cmds.c
>>> +++ b/hw/pci/pci-hmp-cmds.c
>>> @@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, 
>>> const PciDeviceInfo *dev)
>>>           monitor_printf(mon, "      BAR%" PRId64 ": ", 
>>> region->value->bar);
>>>           if (!strcmp(region->value->type, "io")) {
>>> -            monitor_printf(mon, "I/O at 0x%04" PRIx64
>>> -                                " [0x%04" PRIx64 "].\n",
>>> -                           addr, addr + size - 1);
>>> +            if (addr != UINT64_MAX) {
>>> +                monitor_printf(mon, "I/O at 0x%04" PRIx64
>>> +                                    " [0x%04" PRIx64 "]\n",
>>> +                               addr, addr + size - 1);
>>> +            } else {
>>> +                monitor_printf(mon, "I/O (not configured)\n");
>>> +            }
>>>           } else {
>>> -            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
>>> -                               " [0x%08" PRIx64 "].\n",
>>> -                           region->value->mem_type_64 ? 64 : 32,
>>> -                           region->value->prefetch ? " prefetchable" 
>>> : "",
>>> -                           addr, addr + size - 1);
>>> +            if (addr != UINT64_MAX) {
>>> +                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
>>> +                                   " [0x%08" PRIx64 "]\n",
>>> +                               region->value->mem_type_64 ? 64 : 32,
>>> +                               region->value->prefetch ? " 
>>> prefetchable" : "",
>>> +                               addr, addr + size - 1);
>>> +            } else {
>>> +                monitor_printf(mon, "%d bit%s memory (not 
>>> configured)\n",
>>> +                               region->value->mem_type_64 ? 64 : 32,
>>> +                               region->value->prefetch ? " 
>>> prefetchable" : "");
>>> +            }
>>>           }
>>>       }
>>
>> what makes bar unconfigured is that memory space is disabled,
>> not that it has a special value.
> 
> I tried to add a PciMemoryRegion::enabled field then realized
> unmapped regions are advertised using addr = PCI_BAR_UNMAPPED
> (which is UINT64_MAX):
> 
> typedef struct PCIIORegion {
>    pcibus_t addr; /* current PCI mapping address. -1 means not mapped */
> #define PCI_BAR_UNMAPPED (~(pcibus_t)0)
> 
> OK if I respin this patch with s/UINT64_MAX/PCI_BAR_UNMAPPED/?

and s/configured/mapped/ in printf.

